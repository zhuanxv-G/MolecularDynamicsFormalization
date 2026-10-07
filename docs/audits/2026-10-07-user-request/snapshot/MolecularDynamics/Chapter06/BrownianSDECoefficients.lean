import MolecularDynamics.Chapter06.BrownianDirichlet

/-! Actual original-mass overdamped Brownian coefficients at gamma one.
These coefficient identities do not assert identification of a stochastic law or generator. -/

open MeasureTheory
open scoped ContDiff NNReal

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- The literal diagonal inverse-mass map on the original configuration coordinates. -/
def textbookBrownianMassMobility : (Fin Nc → ℝ) →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i ↦ (m i)⁻¹ • ContinuousLinearMap.proj i

/-- The actual mobility multiplies each original coordinate by its own inverse mass. -/
theorem textbookBrownianMassMobility_apply (q : Fin Nc → ℝ) (i : Fin Nc) :
    textbookBrownianMassMobility m q i = (m i)⁻¹ * q i := by
  simp only [textbookBrownianMassMobility, ContinuousLinearMap.pi_apply,
    smul_apply, ContinuousLinearMap.proj_apply, smul_eq_mul]

/-- The original mass-weighted overdamped drift at gamma one. -/
def textbookBrownianSDEDrift (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  textbookBrownianMassMobility m (textbookPotentialForce U q)

/-- The drift is exactly minus the original inverse mass times the original potential partial. -/
theorem textbookBrownianSDEDrift_apply (q : Fin Nc → ℝ) (i : Fin Nc) :
    textbookBrownianSDEDrift m U q i = -(m i)⁻¹ * textbookConfigurationPartial U i q := by
  simp only [textbookBrownianSDEDrift, textbookBrownianMassMobility_apply,
    textbookPotentialForce, textbookConfigurationPartial]
  ring

include hU hPU in
/-- Smooth original periodicity yields a genuine global Lipschitz constant for the actual original-mass drift, rather than adding one as a model assumption. -/
theorem textbookBrownianSDEDrift_lipschitz :
    ∃ L : ℝ≥0, LipschitzWith L (textbookBrownianSDEDrift m U) := by
  obtain ⟨L, hL⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hPU
  refine ⟨‖textbookBrownianMassMobility m‖₊ * L, ?_⟩
  exact (textbookBrownianMassMobility m).lipschitzWith.comp hL

include hU hPU in
/-- The actual inverse-mass drift preserves the same original integer-lattice periodicity. -/
theorem textbookBrownianSDEDrift_periodic (q : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    textbookBrownianSDEDrift m U (q + fun i ↦ (n i : ℝ)) = textbookBrownianSDEDrift m U q :=
  congrArg (textbookBrownianMassMobility m) (textbookUnitPeriodicPotential_force U hU hPU q n)

/-- The positive diagonal square root of the original covariance at gamma one and beta inverse equals kBT. -/
def textbookBrownianSDENoiseAmplitude (i : Fin Nc) : ℝ :=
  Real.sqrt (2 * β⁻¹ * (m i)⁻¹)

include hm hβ in
/-- Its square is exactly the original covariance entry, with original positive masses and temperature. -/
theorem textbookBrownianSDENoiseAmplitude_sq (i : Fin Nc) :
    textbookBrownianSDENoiseAmplitude m β i ^ 2 = 2 * β⁻¹ * (m i)⁻¹ := by
  apply Real.sq_sqrt
  exact (mul_pos (mul_pos zero_lt_two (inv_pos.mpr hβ)) (inv_pos.mpr (hm i))).le

include hm hβ in
/-- Each actual original covariance amplitude is strictly positive. -/
theorem textbookBrownianSDENoiseAmplitude_pos (i : Fin Nc) :
    0 < textbookBrownianSDENoiseAmplitude m β i := by
  exact Real.sqrt_pos.mpr (mul_pos (mul_pos zero_lt_two (inv_pos.mpr hβ)) (inv_pos.mpr (hm i)))

include hβ in
/-- The actual amplitude is exactly the literal textbook square-root temperature factor times inverse square-root mass. -/
theorem textbookBrownianSDENoiseAmplitude_eq_original (i : Fin Nc) :
    textbookBrownianSDENoiseAmplitude m β i = Real.sqrt (2 * β⁻¹) * (Real.sqrt (m i))⁻¹ := by
  rw [textbookBrownianSDENoiseAmplitude,
    Real.sqrt_mul (mul_pos zero_lt_two (inv_pos.mpr hβ)).le, Real.sqrt_inv]

/-- The actual whole diagonal noise map on the original finite-dimensional configuration lift. -/
def textbookBrownianSDENoise : (Fin Nc → ℝ) →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i ↦ textbookBrownianSDENoiseAmplitude m β i • ContinuousLinearMap.proj i

/-- All original noise coordinates are given by the literal diagonal amplitude applied to the driving vector. -/
theorem textbookBrownianSDENoise_apply (w : Fin Nc → ℝ) (i : Fin Nc) :
    textbookBrownianSDENoise m β w i = textbookBrownianSDENoiseAmplitude m β i * w i := by
  simp only [textbookBrownianSDENoise, ContinuousLinearMap.pi_apply,
    smul_apply, ContinuousLinearMap.proj_apply, smul_eq_mul]

include hm hβ in
/-- The drift/covariance differential expression is exactly the original mass-weighted Brownian expression.
This algebraic equality is distinct from proving that expression is the stochastic generator of an actual SDE law. -/
theorem textbookBrownianGenerator_eq_sde_coefficients
    (f : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) :
    textbookBrownianGenerator m U β f q =
      ∑ i, (textbookBrownianSDEDrift m U q i * textbookConfigurationPartial f i q +
        (1 / 2 : ℝ) * textbookBrownianSDENoiseAmplitude m β i ^ 2 *
          textbookConfigurationPartial (textbookConfigurationPartial f i) i q) := by
  unfold textbookBrownianGenerator
  apply Finset.sum_congr rfl
  intro i _
  rw [textbookBrownianSDEDrift_apply, textbookBrownianSDENoiseAmplitude_sq m hm β hβ i]
  ring

end
end MolecularDynamics
