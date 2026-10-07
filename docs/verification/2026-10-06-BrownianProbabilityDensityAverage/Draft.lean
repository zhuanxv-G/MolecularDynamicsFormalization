import MolecularDynamics.Chapter06.BrownianProbabilityGibbsInvariance
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap

/-! Actual initial Gibbs-relative densities and their original Brownian transition
laws. Nonnegativity and mass one describe genuine initial probability densities;
all evolution identities are proved, rather than imposed as hypotheses. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ)

/-- The genuine measure of an entire original Gibbs L2 relative density. -/
def textbookBrownianInitialDensityMeasure
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    Measure (UnitAddTorus (Fin N)) :=
  (textbookConfigurationTorusGibbsMeasure U β).withDensity (fun Q ↦ ENNReal.ofReal (ρ Q))

include hU hp in
/-- Actual nonnegative density with true unit integral defines a probability measure. -/
theorem textbookBrownianInitialDensityMeasure_isProbabilityMeasure
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    IsProbabilityMeasure (textbookBrownianInitialDensityMeasure U β ρ) := by
  apply isProbabilityMeasure_iff.mpr
  unfold textbookBrownianInitialDensityMeasure
  rw [withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ,
    ← ofReal_integral_eq_lintegral_ofReal
      (textbookBrownianGibbsL2_integrable U hU hp β ρ) hρpos, hρmass]
  simp

/-- Every real observable integral against the true initial density is its original Gibbs weighted integral. -/
theorem textbookBrownianInitialDensityMeasure_integral
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (F : UnitAddTorus (Fin N) → ℝ) :
    (∫ Q, F Q ∂textbookBrownianInitialDensityMeasure U β ρ) =
      ∫ Q, F Q * ρ Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  unfold textbookBrownianInitialDensityMeasure
  rw [integral_withDensity_eq_integral_toReal_smul
    (Lp.stronglyMeasurable ρ).measurable.ennreal_ofReal
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)]
  apply integral_congr_ae
  filter_upwards [hρpos] with Q hQ
  simp only [ENNReal.toReal_ofReal hQ, smul_eq_mul, mul_comm]

variable (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

/-- The time-t distribution is the original actual Brownian Markov kernel applied to the genuine initial density measure. -/
def textbookBrownianDensityLaw
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) (t : ℝ≥0) :
    Measure (UnitAddTorus (Fin N)) :=
  textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t ∘ₘ
    textbookBrownianInitialDensityMeasure U β ρ

include hB in
/-- The actual time-t density law is a genuine probability at every nonnegative time. -/
theorem textbookBrownianDensityLaw_isProbabilityMeasure
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    IsProbabilityMeasure (textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t) := by
  have := textbookBrownianInitialDensityMeasure_isProbabilityMeasure U hU hp β ρ hρpos hρmass
  have := textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hp β hβ B P hB t
  unfold textbookBrownianDensityLaw
  infer_instance

include hB in
/-- Actual distribution expectations equal the actual evolved observable against the true initial Gibbs relative density. -/
theorem textbookBrownianDensityLaw_integral_probability
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, F Q ∂textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t) =
      ∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q * ρ Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  let κ := textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t
  let ν := textbookBrownianInitialDensityMeasure U β ρ
  have : IsProbabilityMeasure ν :=
    textbookBrownianInitialDensityMeasure_isProbabilityMeasure U hU hp β ρ hρpos hρmass
  have : IsMarkovKernel κ :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hp β hβ B P hB t
  have hi : Integrable (fun Q ↦ F Q) (κ ∘ₘ ν) :=
    (integrable_const ‖F‖).mono' F.continuous.aestronglyMeasurable
      (Eventually.of_forall fun Q ↦ F.norm_coe_le_norm Q)
  change (∫ Q, F Q ∂(κ ∘ₘ ν)) = _
  rw [Measure.comp_eq_comp_const_apply] at hi ⊢
  rw [Kernel.integral_comp hi, Kernel.const_apply]
  change (∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q
    ∂textbookBrownianInitialDensityMeasure U β ρ) = _
  exact textbookBrownianInitialDensityMeasure_integral U β ρ hρpos _

include hB in
/-- The genuine original Brownian distribution average is precisely the proved original Gibbs spectral density pairing. -/
theorem textbookBrownianDensityLaw_integral_spectral
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, F Q ∂textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t) =
      ∫ Q, F Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookBrownianDensityLaw_integral_probability m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  let J := textbookGibbsContinuousToLp U hU hp β
  calc
    _ = ∫ Q, (textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F) Q * ρ Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
      apply integral_congr_ae
      filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hp β
        (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F)] with Q hQ
      rw [← hQ]
      rfl
    _ = ∫ Q, (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t (J F)) Q * ρ Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
      rw [textbookBrownianProbabilityGibbsL2Image_eq_spectral]
    _ = ∫ Q, (J F) Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β :=
      (textbookBrownianGibbsSpectralEvolution_integral_duality m hm U hU hp β hβ t ρ (J F)).symm
    _ = _ := by
      apply integral_congr_ae
      filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hp β F] with Q hQ
      rw [hQ]

include hB in
/-- The actual law average of each original observable integrates the original globally constructed random configuration over its genuine initial density. -/
theorem textbookBrownianDensityLaw_integral_globalExpectation
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (f : textbookPeriodicSmoothSpace N) :
    (∫ Q, textbookConfigurationTorusObservable f Q
        ∂textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t) =
      ∫ Q, (∫ sample, (f : (Fin N → ℝ) → ℝ)
        (textbookBrownianGlobalRandomConfiguration m hm U hU hp β hβ
          (textbookConfigurationTorusRepresentative Q) B t sample) ∂P) * ρ Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  change (∫ Q, (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) Q
    ∂textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t) = _
  rw [textbookBrownianDensityLaw_integral_probability m hm U hU hp β hβ B P hB
    ρ hρpos hρmass t (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2)]
  apply integral_congr_ae
  exact Eventually.of_forall fun Q ↦ congrArg (fun r : ℝ ↦ r * ρ Q)
    (textbookBrownianTorusProbabilityOperator_original_observable_expectation
      m hm U hU hp β hβ B P hB f f.prop.1 f.prop.2 t Q)

/-- The normalized distribution average of (5.6), applied to the true original time-t law. -/
def textbookBrownianDensityAverage
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) : ℝ :=
  (∫ Q, F Q ∂textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t) /
    (∫ _Q, (1 : ℝ) ∂textbookBrownianDensityLaw m hm U hU hp β hβ B P ρ t)

include hB in
/-- The denominator of the actual normalized distribution average is one; its numerator is the true evolved density pairing. -/
theorem textbookBrownianDensityAverage_eq_spectral
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t F =
      ∫ Q, F Q * (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  have := textbookBrownianDensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t
  unfold textbookBrownianDensityAverage
  simp only [integral_const, probReal_univ, one_smul, div_one]
  exact textbookBrownianDensityLaw_integral_spectral m hm U hU hp β hβ B P hB ρ hρpos hρmass t F

private abbrev oneVector : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  textbookPeriodicSmoothEmbedding U hU hp β (textbookPeriodicSmoothConstant N 1)

include hB in
/-- The actual distribution average of the original Brownian process converges exponentially to the original full-cube canonical average. -/
theorem textbookBrownianDensityAverage_smooth_decay
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (f : textbookPeriodicSmoothSpace N) :
    |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
        (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
      (textbookConfigurationPartition U β)⁻¹ *
        (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
          textbookConfigurationGibbsWeight U β q)| ≤
      (‖ρ - oneVector U hU hp β‖ + 1) * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ *
        Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hp β * (t : ℝ)) := by
  rw [textbookBrownianDensityAverage_eq_spectral m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact textbookBrownianGibbsSpectralEvolution_smooth_average_decay m hm U hU hp β hβ ρ hρmass t f

include hB in
/-- The positive constants in Theorem6.1(3) apply to the same actual Brownian time-t law for every original smooth periodic test. -/
theorem textbookBrownianDensityAverage_smooth_exponential
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace N) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α * (t : ℝ)) := by
  refine ⟨‖ρ - oneVector U hU hp β‖ + 1, textbookBrownianGibbsCoercivityRate m U hU hp β,
    by positivity, textbookBrownianGibbsCoercivityRate_pos m U hU hp β hβ, ?_⟩
  intro f t
  exact textbookBrownianDensityAverage_smooth_decay m hm U hU hp β hβ B P hB ρ hρpos hρmass t f

end
end MolecularDynamics
