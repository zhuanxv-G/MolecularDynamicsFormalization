import MolecularDynamics.Chapter06.BrownianProbabilityDensityAverage

/-! The actual spectral density is nonnegative and defines exactly the genuine
Brownian distribution law. The continuous expectation identities alone are
used to prove positivity, through finite regular measure uniqueness. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private theorem positive_part_identity (r : ℝ) :
    (ENNReal.ofReal r).toReal = r + (ENNReal.ofReal (-r)).toReal := by
  by_cases hr : 0 ≤ r
  · rw [ENNReal.toReal_ofReal hr, ENNReal.ofReal_eq_zero.mpr (by linarith),
      ENNReal.toReal_zero, add_zero]
  · have hnr : 0 ≤ -r := by linarith
    rw [ENNReal.ofReal_eq_zero.mpr (by linarith), ENNReal.toReal_zero,
      ENNReal.toReal_ofReal hnr]
    ring

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hU hp in
private theorem density_measure_from_expectations
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (ν : Measure (UnitAddTorus (Fin N))) [IsFiniteMeasure ν]
    (he : ∀ F : C(UnitAddTorus (Fin N), ℝ),
      (∫ Q, F Q ∂ν) = ∫ Q, F Q * x Q ∂textbookConfigurationTorusGibbsMeasure U β) :
    ν = textbookBrownianInitialDensityMeasure U β x ∧
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] x := by
  let μ := textbookConfigurationTorusGibbsMeasure U β
  let νp := μ.withDensity (fun Q ↦ ENNReal.ofReal (x Q))
  let νn := μ.withDensity (fun Q ↦ ENNReal.ofReal (-x Q))
  have hx : Integrable (x : UnitAddTorus (Fin N) → ℝ) μ :=
    textbookBrownianGibbsL2_integrable U hU hp β x
  have hxm : Measurable (x : UnitAddTorus (Fin N) → ℝ) :=
    (Lp.stronglyMeasurable x).measurable
  have : IsFiniteMeasure νp := isFiniteMeasure_withDensity_ofReal hx.hasFiniteIntegral
  have : IsFiniteMeasure νn := isFiniteMeasure_withDensity_ofReal hx.neg.hasFiniteIntegral
  have hxmneg : Measurable (fun Q ↦ -x Q) := hxm.neg
  have hparts : ν + νn = νp := by
    apply Measure.ext_of_integral_eq_on_compactlySupported
    intro F
    rw [integral_add_measure F.integrable F.integrable]
    change (∫ Q, F.toContinuousMap Q ∂ν) + (∫ Q, F Q ∂νn) = ∫ Q, F Q ∂νp
    rw [he F.toContinuousMap]
    have hneg : Integrable (fun Q ↦ (ENNReal.ofReal (-x Q)).toReal * F Q) μ := by
      simpa only [smul_eq_mul] using
        (integrable_withDensity_iff_integrable_smul' hxmneg.ennreal_ofReal
          (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)).mp
          (show Integrable (fun Q ↦ F Q) νn from F.integrable)
    have hprod : Integrable (fun Q ↦ F Q * x Q) μ :=
      hx.bdd_mul F.continuous.aestronglyMeasurable
        (Eventually.of_forall fun Q ↦ F.toContinuousMap.norm_coe_le_norm Q)
    change (∫ Q, F Q * x Q ∂μ) + (∫ Q, F Q ∂μ.withDensity (fun Q ↦ ENNReal.ofReal (-x Q))) =
      ∫ Q, F Q ∂μ.withDensity (fun Q ↦ ENNReal.ofReal (x Q))
    rw [integral_withDensity_eq_integral_toReal_smul hxmneg.ennreal_ofReal
      (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top),
      integral_withDensity_eq_integral_toReal_smul hxm.ennreal_ofReal
        (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)]
    simp only [smul_eq_mul]
    rw [← integral_add hprod hneg]
    apply integral_congr_ae
    exact Eventually.of_forall fun Q ↦ by
      dsimp only
      rw [positive_part_identity (x Q)]
      ring
  have hle : νn ≤ νp := by
    rw [← hparts]
    exact Measure.le_add_left le_rfl
  have hnzero : νn = 0 :=
    Measure.eq_zero_of_absolutelyContinuous_of_mutuallySingular hle.absolutelyContinuous
      (withDensity_ofReal_mutuallySingular hxm).symm
  have hnonneg : 0 ≤ᵐ[μ] x := by
    have hz := (withDensity_eq_zero_iff hxmneg.ennreal_ofReal.aemeasurable).mp hnzero
    filter_upwards [hz] with Q hQ
    have hr : -x Q ≤ 0 := ENNReal.ofReal_eq_zero.mp hQ
    change 0 ≤ x Q
    linarith
  refine ⟨?_, hnonneg⟩
  change ν = νp
  simpa only [hnzero, add_zero] using hparts

include hB in
/-- The original actual Brownian law is exactly the original Gibbs measure with the true spectrally evolved relative density. -/
theorem textbookBrownianDensityLaw_eq_spectralDensityMeasure
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t =
      textbookBrownianInitialDensityMeasure U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) := by
  have := textbookBrownianDensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t
  exact (density_measure_from_expectations U hU hp β
    (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ)
    (textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t)
    (fun F ↦ textbookBrownianDensityLaw_integral_spectral m hm U hU hp β hβ B P hB ρ hρpos hρmass t F)).1

include hB in
/-- True original Gibbs spectral evolution preserves actual density nonnegativity, derived from the genuine original law. -/
theorem textbookBrownianGibbsSpectralEvolution_density_nonnegative
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ := by
  have := textbookBrownianDensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t
  exact (density_measure_from_expectations U hU hp β
    (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ)
    (textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t)
    (fun F ↦ textbookBrownianDensityLaw_integral_spectral m hm U hU hp β hβ B P hB ρ hρpos hρmass t F)).2

include hB in
/-- The actual evolved density itself defines a probability measure, rather than merely a formal pairing. -/
theorem textbookBrownianSpectralDensityMeasure_isProbabilityMeasure
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    IsProbabilityMeasure (textbookBrownianInitialDensityMeasure U β
      (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ)) := by
  rw [← textbookBrownianDensityLaw_eq_spectralDensityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact textbookBrownianDensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t

include hB in
/-- The actual (5.6) law average equals the ratio of genuine evolved density integrals for the same Gibbs reference measure. -/
theorem textbookBrownianDensityAverage_eq_spectralDensityRatio
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t F =
      (∫ Q, F Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) /
      (∫ Q, (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) := by
  rw [textbookBrownianGibbsSpectralEvolution_integral_mass, hρmass, div_one]
  exact textbookBrownianDensityAverage_eq_spectral m hm U hU hp β hβ B P hB ρ hρpos hρmass t F


private abbrev gibbsHaarWeight (Q : UnitAddTorus (Fin N)) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q

include hU in
private theorem gibbsHaarWeight_positive (Q : UnitAddTorus (Fin N)) :
    0 < gibbsHaarWeight U β Q :=
  mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β)) (Real.exp_pos _)

include hU in
private theorem gibbsHaarWeight_measurable :
    Measurable (gibbsHaarWeight U β) :=
  measurable_const.mul ((measurable_const.mul
    (textbookConfigurationTorusObservable_measurable U hU.continuous)).exp)

include hU in
private theorem haar_absolutelyContinuous_gibbs :
    (volume : Measure (UnitAddTorus (Fin N))) ≪ textbookConfigurationTorusGibbsMeasure U β := by
  change volume ≪ volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))
  apply withDensity_absolutelyContinuous' (gibbsHaarWeight_measurable U hU β).ennreal_ofReal.aemeasurable
  exact Eventually.of_forall fun Q ↦ ne_of_gt
    (ENNReal.ofReal_pos.mpr (gibbsHaarWeight_positive U hU β Q))

/-- The physical density against the original flat torus Haar reference measure is the true Gibbs weight times the relative Gibbs density. -/
def textbookBrownianGibbsToHaarDensity
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (Q : UnitAddTorus (Fin N)) : ℝ :=
  gibbsHaarWeight U β Q * x Q

include hU in
/-- The true flat-reference density is measurably constructed from the original Gibbs L2 representative. -/
theorem textbookBrownianGibbsToHaarDensity_measurable
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    Measurable (textbookBrownianGibbsToHaarDensity U β x) :=
  (gibbsHaarWeight_measurable U hU β).mul (Lp.stronglyMeasurable x).measurable

include hU in
/-- Strict positivity of the original Gibbs weight transfers nonnegativity to the actual Haar density. -/
theorem textbookBrownianGibbsToHaarDensity_nonnegative
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hx : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] x) :
    0 ≤ᵐ[volume] textbookBrownianGibbsToHaarDensity U β x := by
  have hxhaar : 0 ≤ᵐ[(volume : Measure (UnitAddTorus (Fin N)))] x :=
    (Measure.ae_le_iff_absolutelyContinuous.mpr (haar_absolutelyContinuous_gibbs U hU β)) hx
  filter_upwards [hxhaar] with Q hQ
  change 0 ≤ gibbsHaarWeight U β Q * x Q
  exact mul_nonneg (gibbsHaarWeight_positive U hU β Q).le hQ

include hU in
/-- The original Gibbs-relative density measure is precisely the flat Haar measure with its genuine physical density. -/
theorem textbookBrownianGibbsToHaarDensity_measure
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    textbookBrownianInitialDensityMeasure U β x =
      volume.withDensity (fun Q ↦ ENNReal.ofReal (textbookBrownianGibbsToHaarDensity U β x Q)) := by
  change (volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))).withDensity
      (fun Q ↦ ENNReal.ofReal (x Q)) =
    volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q * x Q))
  rw [← withDensity_mul volume (gibbsHaarWeight_measurable U hU β).ennreal_ofReal
    (Lp.stronglyMeasurable x).measurable.ennreal_ofReal]
  apply withDensity_congr_ae
  exact Eventually.of_forall fun Q ↦ (ENNReal.ofReal_mul
    (gibbsHaarWeight_positive U hU β Q).le).symm

include hU in
/-- The actual Gibbs density pairing is exactly the original flat-reference physical-density integral. -/
theorem textbookBrownianGibbsToHaarDensity_integral
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (F : UnitAddTorus (Fin N) → ℝ) :
    (∫ Q, F Q * x Q ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, F Q * textbookBrownianGibbsToHaarDensity U β x Q := by
  change (∫ Q, F Q * x Q ∂volume.withDensity
    (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))) =
    ∫ Q, F Q * (gibbsHaarWeight U β Q * x Q)
  rw [integral_withDensity_eq_integral_toReal_smul
    (gibbsHaarWeight_measurable U hU β).ennreal_ofReal
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)]
  simp_rw [ENNReal.toReal_ofReal (gibbsHaarWeight_positive U hU β _).le, smul_eq_mul]
  apply integral_congr_ae
  exact Eventually.of_forall fun Q ↦ by ring

include hU hp in
/-- Every original Gibbs L2 representative gives a genuinely Haar-integrable physical density. -/
theorem textbookBrownianGibbsToHaarDensity_integrable
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    Integrable (textbookBrownianGibbsToHaarDensity U β x) := by
  have hx := textbookBrownianGibbsL2_integrable U hU hp β x
  change Integrable (x : UnitAddTorus (Fin N) → ℝ)
    (volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))) at hx
  have hh := (integrable_withDensity_iff_integrable_smul'
    (gibbsHaarWeight_measurable U hU β).ennreal_ofReal
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)).mp hx
  simp_rw [ENNReal.toReal_ofReal (gibbsHaarWeight_positive U hU β _).le, smul_eq_mul] at hh
  exact hh

include hB in
/-- The original actual time-t Brownian distribution has the true original flat-reference physical density. -/
theorem textbookBrownianDensityLaw_eq_HaarDensityMeasure
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t =
      volume.withDensity (fun Q ↦ ENNReal.ofReal (textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q)) := by
  rw [textbookBrownianDensityLaw_eq_spectralDensityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact textbookBrownianGibbsToHaarDensity_measure U hU β _

include hB in
/-- The actual time-t flat-reference physical density is nonnegative, rather than a signed formal expression. -/
theorem textbookBrownianDensityLaw_HaarDensity_nonnegative
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    0 ≤ᵐ[volume] textbookBrownianGibbsToHaarDensity U β
      (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) := by
  exact textbookBrownianGibbsToHaarDensity_nonnegative U hU β _
    (textbookBrownianGibbsSpectralEvolution_density_nonnegative m hm U hU hp β hβ B P hB ρ hρpos hρmass t)

/-- The genuine Haar density of the original actual law has integral one at every nonnegative time. -/
theorem textbookBrownianDensityLaw_HaarDensity_mass
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    (∫ Q, textbookBrownianGibbsToHaarDensity U β
      (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q) = 1 := by
  have hh := textbookBrownianGibbsToHaarDensity_integral U hU β
    (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) (fun _ ↦ 1)
  simp only [one_mul] at hh
  rw [← hh, textbookBrownianGibbsSpectralEvolution_integral_mass, hρmass]

include hB in
/-- Formula (5.6) for the true original Brownian time-t law is literally the quotient of observable-density and density integrals against the flat Haar reference. -/
theorem textbookBrownianDensityAverage_eq_HaarDensityRatio
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t F =
      (∫ Q, F Q * textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q) /
      (∫ Q, textbookBrownianGibbsToHaarDensity U β
        (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q) := by
  rw [textbookBrownianDensityLaw_HaarDensity_mass m hm U hU hp β hβ ρ hρmass, div_one]
  rw [textbookBrownianDensityAverage_eq_spectral m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact textbookBrownianGibbsToHaarDensity_integral U hU β _ F
end
end MolecularDynamics
