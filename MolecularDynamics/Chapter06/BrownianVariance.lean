import MolecularDynamics.Chapter06.BrownianGibbsBounds
import Mathlib.Probability.Moments.Variance

/-! Actual Gibbs mean, variance, and centering identities needed for Theorem 6.1. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)

/-- The actual normalized Gibbs expectation of a genuine continuous torus observable. -/
def textbookGibbsMean (g : C(UnitAddTorus (Fin Nc), ℝ)) : ℝ :=
  ∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β

/-- The actual Gibbs mean-square deviation, with the original measure and actual expectation. -/
def textbookGibbsVariance (g : C(UnitAddTorus (Fin Nc), ℝ)) : ℝ :=
  ∫ Q, (g Q - textbookGibbsMean U β g) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β

/-- The genuine centered continuous observable, not a formal variable. -/
def textbookGibbsCenteredContinuous (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    C(UnitAddTorus (Fin Nc), ℝ) :=
  g - ContinuousMap.const (UnitAddTorus (Fin Nc)) (textbookGibbsMean U β g)

include hU hPU in
/-- Every actual continuous observable is square integrable for the same Gibbs probability. -/
theorem textbookGibbsContinuous_memLp_two (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    MemLp (fun Q ↦ g Q) 2 (textbookConfigurationTorusGibbsMeasure U β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  exact ContinuousMap.memLp (textbookConfigurationTorusGibbsMeasure U β) ℝ g

include hU hPU in
/-- The actual continuous observable is integrable, derived from genuine square integrability. -/
theorem textbookGibbsContinuous_integrable (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    Integrable (fun Q ↦ g Q) (textbookConfigurationTorusGibbsMeasure U β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  exact (textbookGibbsContinuous_memLp_two U hU hPU β g).integrable (by norm_num)

include hU hPU in
/-- Actual centering gives exactly zero Gibbs mean. -/
theorem textbookGibbsCenteredContinuous_mean_zero (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsMean U β (textbookGibbsCenteredContinuous U β g) = 0 := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  change (∫ Q, g Q - textbookGibbsMean U β g ∂textbookConfigurationTorusGibbsMeasure U β) = 0
  rw [integral_sub (textbookGibbsContinuous_integrable U hU hPU β g) (integrable_const _)]
  simp [textbookGibbsMean]

/-- The literal mean-square deviation is the actual probability-theoretic variance for this same measure. -/
theorem textbookGibbsVariance_eq_variance (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsVariance U β g =
      ProbabilityTheory.variance (fun Q ↦ g Q) (textbookConfigurationTorusGibbsMeasure U β) :=
  (ProbabilityTheory.variance_eq_integral g.continuous.measurable.aemeasurable).symm

include hU hPU in
/-- Actual Gibbs variance equals the original second moment minus the actual mean squared. -/
theorem textbookGibbsVariance_eq_sub (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsVariance U β g =
      (∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β) -
        (textbookGibbsMean U β g) ^ 2 := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  rw [textbookGibbsVariance_eq_variance]
  exact ProbabilityTheory.variance_eq_sub (textbookGibbsContinuous_memLp_two U hU hPU β g)

/-- The actual mean-square deviation is nonnegative. -/
theorem textbookGibbsVariance_nonneg (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    0 ≤ textbookGibbsVariance U β g :=
  integral_nonneg (fun Q ↦ sq_nonneg (g Q - textbookGibbsMean U β g))

include hU hPU in
/-- The actual Gibbs expectation really minimizes the mean-square deviation over all constants. -/
theorem textbookGibbsVariance_le_square_sub_const (g : C(UnitAddTorus (Fin Nc), ℝ)) (c : ℝ) :
    textbookGibbsVariance U β g ≤
      ∫ Q, (g Q - c) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  rw [textbookGibbsVariance_eq_variance,
    ← ProbabilityTheory.variance_sub_const g.continuous.aestronglyMeasurable c]
  exact ProbabilityTheory.variance_le_expectation_sq
    (g.continuous.sub continuous_const).aestronglyMeasurable

include hU hPU in
/-- Zero actual variance forces the actual continuous observable to equal its mean at every point. -/
theorem textbookGibbsVariance_eq_zero_iff (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsVariance U β g = 0 ↔ ∀ Q, g Q = textbookGibbsMean U β g := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  have := textbookConfigurationTorusGibbsMeasure_isOpenPosMeasure U hU hPU β
  constructor
  · intro h
    have hae := ProbabilityTheory.ae_eq_integral_of_variance_eq_zero
      (textbookGibbsContinuous_memLp_two U hU hPU β g)
      ((textbookGibbsVariance_eq_variance U β g).symm.trans h)
    have he := (g.continuous.ae_eq_iff_eq
      (textbookConfigurationTorusGibbsMeasure U β) continuous_const).mp hae
    exact fun Q ↦ congrFun he Q
  · intro h
    change (∫ Q, (g Q - textbookGibbsMean U β g) ^ 2
      ∂textbookConfigurationTorusGibbsMeasure U β) = 0
    simp_rw [h, sub_self, zero_pow two_ne_zero]
    exact integral_zero (UnitAddTorus (Fin Nc)) ℝ

include hU hPU in
/-- The actual centered Gibbs Hilbert vector has the actual variance as its norm squared. -/
theorem textbookGibbsCenteredContinuous_norm_sq (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ‖textbookGibbsContinuousToLp U hU hPU β (textbookGibbsCenteredContinuous U β g)‖ ^ 2 =
      textbookGibbsVariance U β g := by
  rw [textbookGibbsContinuousToLp_norm_sq U hU hPU β]
  rfl

include hU hPU in
/-- The actual Gibbs Hilbert pairing with the actual constant-one vector is the actual Gibbs mean. -/
theorem textbookGibbsContinuousToLp_inner_one (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ⟪textbookGibbsContinuousToLp U hU hPU β (ContinuousMap.const (UnitAddTorus (Fin Nc)) 1),
      textbookGibbsContinuousToLp U hU hPU β g⟫_ℝ = textbookGibbsMean U β g := by
  rw [L2.inner_def]
  apply integral_congr_ae
  filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hPU β
      (ContinuousMap.const (UnitAddTorus (Fin Nc)) 1),
    textbookGibbsContinuousToLp_ae_eq U hU hPU β g] with Q hOne hg
  rw [hOne, hg, Real.inner_apply]
  exact one_mul (g Q)

include hU hPU in
/-- Actual zero mean is precisely Hilbert orthogonality to the actual constant-one vector. -/
theorem textbookGibbsContinuousToLp_orthogonal_one_iff (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ⟪textbookGibbsContinuousToLp U hU hPU β (ContinuousMap.const (UnitAddTorus (Fin Nc)) 1),
      textbookGibbsContinuousToLp U hU hPU β g⟫_ℝ = 0 ↔ textbookGibbsMean U β g = 0 := by
  rw [textbookGibbsContinuousToLp_inner_one U hU hPU β g]

/-- The derived actual density comparison bounds Gibbs variance by the genuine Haar centered square integral. -/
theorem textbookGibbsVariance_le_haar_centered_square (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsVariance U β g ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
        (∫ Q, (g Q - ∫ R, g R) ^ 2) := by
  have h := textbookTorusGibbsSquareIntegral_upper U hU hPU β
    (g - ContinuousMap.const (UnitAddTorus (Fin Nc)) (∫ R, g R))
  exact (textbookGibbsVariance_le_square_sub_const U hU hPU β g (∫ R, g R)).trans h

/-- The actual normalized Haar mean, in the same original torus model. -/
def textbookTorusHaarMean (g : C(UnitAddTorus (Fin Nc), ℝ)) : ℝ :=
  ∫ Q, g Q

/-- The actual Haar centered mean-square deviation in the original torus model. -/
def textbookTorusHaarVariance (g : C(UnitAddTorus (Fin Nc), ℝ)) : ℝ :=
  ∫ Q, (g Q - textbookTorusHaarMean g) ^ 2

/-- The derived Gibbs density bounds compare actual Gibbs and actual Haar variances. -/
theorem textbookGibbsVariance_le_haar_variance (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsVariance U β g ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * textbookTorusHaarVariance g :=
  textbookGibbsVariance_le_haar_centered_square U hU hPU β g

include hU hPU in
/-- Actual Gibbs variance is invariant under subtraction of any real constant. -/
theorem textbookGibbsVariance_sub_const (g : C(UnitAddTorus (Fin Nc), ℝ)) (c : ℝ) :
    textbookGibbsVariance U β (g - ContinuousMap.const (UnitAddTorus (Fin Nc)) c) =
      textbookGibbsVariance U β g := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  rw [textbookGibbsVariance_eq_variance, textbookGibbsVariance_eq_variance]
  exact ProbabilityTheory.variance_sub_const g.continuous.aestronglyMeasurable c

include hU hPU in
/-- Actual centering preserves actual Gibbs variance. -/
theorem textbookGibbsCenteredContinuous_variance (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsVariance U β (textbookGibbsCenteredContinuous U β g) =
      textbookGibbsVariance U β g :=
  textbookGibbsVariance_sub_const U hU hPU β g (textbookGibbsMean U β g)

end

end MolecularDynamics
