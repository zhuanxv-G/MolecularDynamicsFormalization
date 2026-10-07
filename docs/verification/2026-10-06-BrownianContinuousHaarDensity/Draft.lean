import MolecularDynamics.Chapter06.BrownianL1L2Compatibility

/-! The original flat-reference continuous initial probability density is
converted into the actual Gibbs L2 density for the same Brownian law.
The textbook test norm uses the unnormalized weight exp(-beta U). -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

private abbrev haarWeight (Q : UnitAddTorus (Fin N)) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q

include hU in
private theorem haarWeight_pos (Q : UnitAddTorus (Fin N)) : 0 < haarWeight U β Q :=
  mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β)) (Real.exp_pos _)

include hU hp in
private theorem haarWeight_continuous : Continuous (haarWeight U β) :=
  continuous_const.mul (Real.continuous_exp.comp (continuous_const.mul
    (textbookConfigurationTorusObservable_continuous U hU.continuous hp)))

include hU hp in
private theorem haar_ac_gibbs :
    (volume : Measure (UnitAddTorus (Fin N))) ≪ textbookConfigurationTorusGibbsMeasure U β := by
  change volume ≪ volume.withDensity (fun Q ↦ ENNReal.ofReal (haarWeight U β Q))
  apply withDensity_absolutelyContinuous'
    (haarWeight_continuous U hU hp β).measurable.ennreal_ofReal.aemeasurable
  exact Eventually.of_forall fun Q ↦ ne_of_gt
    (ENNReal.ofReal_pos.mpr (haarWeight_pos U hU β Q))

/-- The original continuous flat Haar density divided by the true positive normalized Gibbs weight. -/
def textbookBrownianHaarRelativeContinuousDensity (R : C(UnitAddTorus (Fin N), ℝ)) :
    C(UnitAddTorus (Fin N), ℝ) :=
  ⟨fun Q ↦ R Q / haarWeight U β Q,
    R.continuous.div (haarWeight_continuous U hU hp β) (fun Q ↦ (haarWeight_pos U hU β Q).ne')⟩

/-- A physical continuous initial Haar density belongs to the actual Gibbs Hilbert space, by genuine compactness. -/
def textbookBrownianHaarInitialGibbsDensity (R : C(UnitAddTorus (Fin N), ℝ)) :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  textbookGibbsContinuousToLp U hU hp β (textbookBrownianHaarRelativeContinuousDensity U hU hp β R)

/-- The actual L2 representative is the original physical density divided by the real Gibbs weight almost everywhere. -/
theorem textbookBrownianHaarInitialGibbsDensity_ae_eq (R : C(UnitAddTorus (Fin N), ℝ)) :
    (textbookBrownianHaarInitialGibbsDensity U hU hp β R : UnitAddTorus (Fin N) → ℝ) =ᵐ[
      textbookConfigurationTorusGibbsMeasure U β] (fun Q ↦ R Q / haarWeight U β Q) :=
  textbookGibbsContinuousToLp_ae_eq U hU hp β _

/-- Mapping the actual representative back to flat Haar volume recovers precisely the original physical initial density. -/
theorem textbookBrownianHaarInitialGibbsDensity_Haar_ae_eq (R : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianGibbsToHaarDensity U β
      (textbookBrownianHaarInitialGibbsDensity U hU hp β R) =ᵐ[volume] R := by
  have he := (Measure.ae_le_iff_absolutelyContinuous.mpr (haar_ac_gibbs U hU hp β))
    (textbookBrownianHaarInitialGibbsDensity_ae_eq U hU hp β R)
  filter_upwards [he] with Q hQ
  change haarWeight U β Q * textbookBrownianHaarInitialGibbsDensity U hU hp β R Q = R Q
  rw [hQ]
  exact mul_div_cancel₀ _ (haarWeight_pos U hU β Q).ne'

/-- The original flat Haar initial density and the constructed Gibbs-relative density define exactly the same measure. -/
theorem textbookBrownianHaarInitialGibbsDensity_measure (R : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianInitialDensityMeasure U β (textbookBrownianHaarInitialGibbsDensity U hU hp β R) =
      volume.withDensity (fun Q ↦ ENNReal.ofReal (R Q)) := by
  rw [textbookBrownianGibbsToHaarDensity_measure U hU β]
  apply withDensity_congr_ae
  filter_upwards [textbookBrownianHaarInitialGibbsDensity_Haar_ae_eq U hU hp β R] with Q hQ
  rw [hQ]

/-- Physical nonnegativity under the original Haar measure gives actual Gibbs nonnegativity. -/
theorem textbookBrownianHaarInitialGibbsDensity_nonnegative (R : C(UnitAddTorus (Fin N), ℝ))
    (hR : 0 ≤ᵐ[volume] (R : UnitAddTorus (Fin N) → ℝ)) :
    0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      textbookBrownianHaarInitialGibbsDensity U hU hp β R := by
  have hRg : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] (R : UnitAddTorus (Fin N) → ℝ) :=
    (Measure.ae_le_iff_absolutelyContinuous.mpr (withDensity_absolutelyContinuous _ _)) hR
  filter_upwards [hRg, textbookBrownianHaarInitialGibbsDensity_ae_eq U hU hp β R] with Q hQ he
  change 0 ≤ textbookBrownianHaarInitialGibbsDensity U hU hp β R Q
  rw [he]
  exact div_nonneg hQ (haarWeight_pos U hU β Q).le

/-- Original flat Haar probability normalization becomes exactly Gibbs-relative integral one. -/
theorem textbookBrownianHaarInitialGibbsDensity_mass (R : C(UnitAddTorus (Fin N), ℝ))
    (hR : (∫ Q, R Q) = 1) :
    (∫ Q, textbookBrownianHaarInitialGibbsDensity U hU hp β R Q
      ∂textbookConfigurationTorusGibbsMeasure U β) = 1 := by
  have hh := textbookBrownianGibbsToHaarDensity_integral U hU β
    (textbookBrownianHaarInitialGibbsDensity U hU hp β R) (fun _ ↦ 1)
  simp only [one_mul] at hh
  rw [hh, integral_congr_ae (textbookBrownianHaarInitialGibbsDensity_Haar_ae_eq U hU hp β R)]
  exact hR

/-- The genuine original Brownian transition acts on the given physical initial Haar density itself. -/
def textbookBrownianHaarDensityLaw (R : C(UnitAddTorus (Fin N), ℝ)) (t : ℝ≥0) :
    Measure (UnitAddTorus (Fin N)) :=
  textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t ∘ₘ
    volume.withDensity (fun Q ↦ ENNReal.ofReal (R Q))

/-- The physical initial-law construction is the same actual Brownian distribution law as the original Gibbs L2 construction. -/
theorem textbookBrownianHaarDensityLaw_eq_GibbsLaw (R : C(UnitAddTorus (Fin N), ℝ)) (t : ℝ≥0) :
    textbookBrownianHaarDensityLaw m hm U hU hp β hβ B P R t =
      textbookBrownianDensityLaw m hm U hU hp β hβ B P
        (textbookBrownianHaarInitialGibbsDensity U hU hp β R) t := by
  unfold textbookBrownianHaarDensityLaw textbookBrownianDensityLaw
  rw [textbookBrownianHaarInitialGibbsDensity_measure]

include hB in
/-- Nonnegative normalized physical initial Haar densities give true probability laws at every nonnegative time. -/
theorem textbookBrownianHaarDensityLaw_isProbabilityMeasure (R : C(UnitAddTorus (Fin N), ℝ))
    (hRpos : 0 ≤ᵐ[volume] (R : UnitAddTorus (Fin N) → ℝ)) (hRmass : (∫ Q, R Q) = 1)
    (t : ℝ≥0) : IsProbabilityMeasure (textbookBrownianHaarDensityLaw m hm U hU hp β hβ B P R t) := by
  rw [textbookBrownianHaarDensityLaw_eq_GibbsLaw]
  exact textbookBrownianDensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB _
    (textbookBrownianHaarInitialGibbsDensity_nonnegative U hU hp β R hRpos)
    (textbookBrownianHaarInitialGibbsDensity_mass U hU hp β R hRmass) t

/-- Formula (5.6) for the same actual law driven from the physical Haar initial density. -/
def textbookBrownianHaarDensityAverage (R : C(UnitAddTorus (Fin N), ℝ)) (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) : ℝ :=
  (∫ Q, F Q ∂textbookBrownianHaarDensityLaw m hm U hU hp β hβ B P R t) /
    (∫ _ : UnitAddTorus (Fin N), (1 : ℝ) ∂textbookBrownianHaarDensityLaw m hm U hU hp β hβ B P R t)

/-- Actual distribution averages from the same physical initial density agree with the original Gibbs construction. -/
theorem textbookBrownianHaarDensityAverage_eq_GibbsAverage (R : C(UnitAddTorus (Fin N), ℝ))
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianHaarDensityAverage m hm U hU hp β hβ B P R t F =
      textbookBrownianDensityAverage m hm U hU hp β hβ B P
        (textbookBrownianHaarInitialGibbsDensity U hU hp β R) t F := by
  unfold textbookBrownianHaarDensityAverage textbookBrownianDensityAverage
  rw [textbookBrownianHaarDensityLaw_eq_GibbsLaw]

include hB in
/-- The original physical initial law has precisely the genuinely evolved flat Haar density. -/
theorem textbookBrownianHaarDensityLaw_eq_evolvedDensityMeasure (R : C(UnitAddTorus (Fin N), ℝ))
    (hRpos : 0 ≤ᵐ[volume] (R : UnitAddTorus (Fin N) → ℝ)) (hRmass : (∫ Q, R Q) = 1)
    (t : ℝ≥0) :
    textbookBrownianHaarDensityLaw m hm U hU hp β hβ B P R t =
      volume.withDensity (fun Q ↦ ENNReal.ofReal (textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
          (textbookBrownianHaarInitialGibbsDensity U hU hp β R)) Q)) := by
  rw [textbookBrownianHaarDensityLaw_eq_GibbsLaw]
  exact textbookBrownianDensityLaw_eq_HaarDensityMeasure m hm U hU hp β hβ B P hB _
    (textbookBrownianHaarInitialGibbsDensity_nonnegative U hU hp β R hRpos)
    (textbookBrownianHaarInitialGibbsDensity_mass U hU hp β R hRmass) t

include hB in
/-- Literal flat Haar density formula (5.6), from the actual given physical initial probability density. -/
theorem textbookBrownianHaarDensityAverage_eq_evolvedDensityRatio (R : C(UnitAddTorus (Fin N), ℝ))
    (hRpos : 0 ≤ᵐ[volume] (R : UnitAddTorus (Fin N) → ℝ)) (hRmass : (∫ Q, R Q) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianHaarDensityAverage m hm U hU hp β hβ B P R t F =
      (∫ Q, F Q * textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
          (textbookBrownianHaarInitialGibbsDensity U hU hp β R)) Q) /
      (∫ Q, textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
          (textbookBrownianHaarInitialGibbsDensity U hU hp β R)) Q) := by
  rw [textbookBrownianHaarDensityAverage_eq_GibbsAverage]
  exact textbookBrownianDensityAverage_eq_HaarDensityRatio m hm U hU hp β hβ B P hB _
    (textbookBrownianHaarInitialGibbsDensity_nonnegative U hU hp β R hRpos)
    (textbookBrownianHaarInitialGibbsDensity_mass U hU hp β R hRmass) t F

/-- The literal unnormalized weighted test norm defined immediately before Theorem 6.1. -/
def textbookBrownianOriginalWeightedTestNorm (f : textbookPeriodicSmoothSpace N) : ℝ :=
  Real.sqrt (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q ^ 2 *
    textbookConfigurationGibbsWeight U β q)

/-- The already constructed Gibbs Hilbert norm differs from the original textbook norm by the exact positive partition factor. -/
theorem textbookBrownianOriginalWeightedTestNorm_normalization (f : textbookPeriodicSmoothSpace N) :
    ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ =
      (Real.sqrt (textbookConfigurationPartition U β))⁻¹ *
        textbookBrownianOriginalWeightedTestNorm U β f := by
  have hs := textbookConfigurationGibbsL2Observable_norm_sq U hU hp β f f.prop.1.continuous f.prop.2
  change ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ ^ 2 =
    (textbookConfigurationPartition U β)⁻¹ *
      (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
        (f : (Fin N → ℝ) → ℝ) q * textbookConfigurationGibbsWeight U β q) at hs
  calc
    ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ =
        Real.sqrt (‖textbookPeriodicSmoothEmbedding U hU hp β f‖ ^ 2) :=
      (Real.sqrt_sq (norm_nonneg _)).symm
    _ = _ := by
      rw [hs, Real.sqrt_mul (inv_nonneg.mpr (textbookConfigurationPartition_pos U hU β).le),
        Real.sqrt_inv]
      simp only [textbookBrownianOriginalWeightedTestNorm, pow_two]

include hB in
/-- The actual physical initial-density average has the original canonical limit with the exact textbook weighted norm. -/
theorem textbookBrownianHaarDensityAverage_original_norm_decay (R : C(UnitAddTorus (Fin N), ℝ))
    (hRpos : 0 ≤ᵐ[volume] (R : UnitAddTorus (Fin N) → ℝ)) (hRmass : (∫ Q, R Q) = 1)
    (f : textbookPeriodicSmoothSpace N) (t : ℝ≥0) :
    |textbookBrownianHaarDensityAverage m hm U hU hp β hβ B P R t
        (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
      (textbookConfigurationPartition U β)⁻¹ *
        (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
          textbookConfigurationGibbsWeight U β q)| ≤
      ((‖textbookBrownianHaarInitialGibbsDensity U hU hp β R -
        textbookPeriodicSmoothEmbedding U hU hp β (textbookPeriodicSmoothConstant N 1)‖ + 1) *
        (Real.sqrt (textbookConfigurationPartition U β))⁻¹) *
      textbookBrownianOriginalWeightedTestNorm U β f *
        Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hp β * (t : ℝ)) := by
  rw [textbookBrownianHaarDensityAverage_eq_GibbsAverage]
  have hh := textbookBrownianDensityAverage_smooth_decay m hm U hU hp β hβ B P hB _
    (textbookBrownianHaarInitialGibbsDensity_nonnegative U hU hp β R hRpos)
    (textbookBrownianHaarInitialGibbsDensity_mass U hU hp β R hRmass) t f
  rw [textbookBrownianOriginalWeightedTestNorm_normalization U hU hp β f] at hh
  simpa only [mul_assoc] using hh

include hB in
/-- Positive constants give the original theorem's uniform test estimate for genuine continuous physical initial probability densities. -/
theorem textbookBrownianHaarDensityAverage_original_norm_exponential (R : C(UnitAddTorus (Fin N), ℝ))
    (hRpos : 0 ≤ᵐ[volume] (R : UnitAddTorus (Fin N) → ℝ)) (hRmass : (∫ Q, R Q) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace N) (t : ℝ≥0),
      |textbookBrownianHaarDensityAverage m hm U hU hp β hβ B P R t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * textbookBrownianOriginalWeightedTestNorm U β f * Real.exp (-α * (t : ℝ)) := by
  refine ⟨(‖textbookBrownianHaarInitialGibbsDensity U hU hp β R -
    textbookPeriodicSmoothEmbedding U hU hp β (textbookPeriodicSmoothConstant N 1)‖ + 1) *
    (Real.sqrt (textbookConfigurationPartition U β))⁻¹,
    textbookBrownianGibbsCoercivityRate m U hU hp β, ?_,
    textbookBrownianGibbsCoercivityRate_pos m U hU hp β hβ, ?_⟩
  · exact mul_pos (by positivity) (inv_pos.mpr (Real.sqrt_pos.mpr (textbookConfigurationPartition_pos U hU β)))
  · intro f t
    exact textbookBrownianHaarDensityAverage_original_norm_decay m hm U hU hp β hβ B P hB R hRpos hRmass f t

end
end MolecularDynamics
