import MolecularDynamics.Chapter06.BrownianProbabilitySpectralIdentification
import MolecularDynamics.Chapter06.BrownianSpectralAverage
import Mathlib.Probability.Kernel.Composition.IntegralCompProd
import Mathlib.MeasureTheory.Integral.RieszMarkovKakutani.Real

/-! Genuine invariance of the original Gibbs probability for the same actual
Brownian transition kernel, derived from the proved original probability identity. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The actual entire Gibbs probability extension preserves the true original Gibbs integral. -/
theorem textbookBrownianGibbsProbabilityOperator_integral_mass (t : ℝ≥0)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    (∫ Q, (textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookBrownianGibbsProbabilityOperator_eq_spectral]
  exact textbookBrownianGibbsSpectralEvolution_integral_mass m hm U hU hp β hβ t ρ

include hB in
/-- Integrating the same original continuous probability expectation against the original Gibbs measure gives its original integral. -/
theorem textbookBrownianTorusProbabilityOperator_Gibbs_integral (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, F Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  let J := textbookGibbsContinuousToLp U hU hp β
  calc
    _ = ∫ Q, (textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
      exact integral_congr_ae (textbookGibbsContinuousToLp_ae_eq U hU hp β
        (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F)).symm
    _ = ∫ Q, (textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t (J F)) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
      rw [textbookBrownianProbabilityGibbsL2Image_eq_spectral]
    _ = ∫ Q, (J F) Q ∂textbookConfigurationTorusGibbsMeasure U β :=
      textbookBrownianGibbsSpectralEvolution_integral_mass m hm U hU hp β hβ t (J F)
    _ = _ := integral_congr_ae (textbookGibbsContinuousToLp_ae_eq U hU hp β F)

include hB in
/-- The actual original Brownian Markov transition sends the genuine original Gibbs probability measure to itself. -/
theorem textbookBrownianTorusTransitionKernel_Gibbs_invariant (t : ℝ≥0) :
    textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t ∘ₘ
        textbookConfigurationTorusGibbsMeasure U β =
      textbookConfigurationTorusGibbsMeasure U β := by
  let κ := textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t
  let μ := textbookConfigurationTorusGibbsMeasure U β
  have : IsMarkovKernel κ := textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hp β hβ B P hB t
  have : IsProbabilityMeasure μ := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  change κ ∘ₘ μ = μ
  apply Measure.ext_of_integral_eq_on_compactlySupported
  intro F
  rw [Measure.comp_eq_comp_const_apply, Kernel.integral_comp F.integrable, Kernel.const_apply]
  change (∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F.toContinuousMap Q ∂μ) =
    ∫ Q, F.toContinuousMap Q ∂μ
  exact textbookBrownianTorusProbabilityOperator_Gibbs_integral m hm U hU hp β hβ B P hB t F.toContinuousMap

end
end MolecularDynamics
