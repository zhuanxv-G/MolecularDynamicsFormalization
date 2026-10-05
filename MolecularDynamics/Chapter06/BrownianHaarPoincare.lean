import MolecularDynamics.Chapter06.BrownianFourierCoefficient
import Mathlib.Topology.Algebra.InfiniteSum.Order

/-! Actual Haar Poincare inequality from the proved full Fourier spectrum and gradient identity. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- Subtracting a real constant preserves every genuine original coordinate partial. -/
theorem textbookConfigurationPartial_sub_const {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (c : ℝ) (i : Fin Nc) :
    textbookConfigurationPartial (fun q ↦ f q - c) i = textbookConfigurationPartial f i := by
  funext q
  simp only [textbookConfigurationPartial, fderiv_sub_const]

/-- The true Haar gradient energy is unchanged by subtracting any real constant. -/
theorem textbookTorusHaarGradientEnergy_sub_const {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) (c : ℝ) :
    textbookTorusHaarGradientEnergy (fun q ↦ f q - c) = textbookTorusHaarGradientEnergy f := by
  rw [textbookTorusHaarGradientEnergy_eq_sum, textbookTorusHaarGradientEnergy_eq_sum]
  simp only [textbookConfigurationPartial_sub_const]

/-- The zero Fourier coefficient is explicitly the complex cast of the actual real Haar mean. -/
theorem textbookTorusHaarFourierCoeff_zero_eq_mean {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) :
    UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ))
      (0 : Fin Nc → ℤ) =
      ((∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f Q : ℝ) : ℂ) := by
  rw [textbookTorusHaarFourierCoeff_zero, integral_complex_ofReal]
/-- Mean-zero full smooth periodic observables satisfy the actual Haar spectral Poincare bound. -/
theorem textbookTorusHaarPoincare_mean_zero {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f)
    (hmean : (∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f Q) = 0) :
    4 * Real.pi ^ 2 * (∫ Q : UnitAddTorus (Fin Nc),
      (textbookConfigurationTorusObservable f Q) ^ 2) ≤ textbookTorusHaarGradientEnergy f := by
  have h0 : UnitAddTorus.mFourierCoeff
      (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) (0 : Fin Nc → ℤ) = 0 := by
    rw [textbookTorusHaarFourierCoeff_zero_eq_mean, hmean, Complex.ofReal_zero]
  have hle : ∀ n : Fin Nc → ℤ,
      (4 * Real.pi ^ 2) *
        ‖UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n‖ ^ 2 ≤
      textbookFourierLaplaceFrequency n *
        ‖UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n‖ ^ 2 := by
    intro n
    by_cases hn : n = 0
    · simp [hn, h0]
    · exact mul_le_mul_of_nonneg_right (textbookFourierLaplaceFrequency_lower n hn)
        (sq_nonneg _)
  exact hasSum_le hle
    ((textbookTorusHaarFourierCoeff_sq_hasSum f hf.continuous hPf).mul_left (4 * Real.pi ^ 2))
    (textbookTorusHaarFourier_energy_hasSum f hf hPf)

/-- Centering by the genuine Haar integral gives actual mean zero for every continuous periodic lift. -/
theorem textbookTorusHaar_center_mean_zero {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    (∫ Q : UnitAddTorus (Fin Nc),
      textbookConfigurationTorusObservable f Q -
        ∫ R : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f R) = 0 := by
  have hi : Integrable (textbookConfigurationTorusObservable f) :=
    (ContinuousMap.memLp (p := 2) volume ℝ
      ⟨_, textbookConfigurationTorusObservable_continuous f hf hPf⟩).integrable (by norm_num)
  rw [integral_sub hi (integrable_const _)]
  simp

/-- The actual full Haar centered variance obeys the derived 4π² gradient bound. -/
theorem textbookTorusHaarPoincare_centered {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    4 * Real.pi ^ 2 * (∫ Q : UnitAddTorus (Fin Nc),
      (textbookConfigurationTorusObservable f Q -
        ∫ R : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f R) ^ 2) ≤
      textbookTorusHaarGradientEnergy f := by
  let c := ∫ R : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f R
  have hp : textbookUnitPeriodicPotential (fun q ↦ f q - c) := by
    intro q z
    change f (q + fun i ↦ (z i : ℝ)) - c = f q - c
    rw [hPf q z]
  have hm : (∫ Q : UnitAddTorus (Fin Nc),
      textbookConfigurationTorusObservable (fun q ↦ f q - c) Q) = 0 :=
    textbookTorusHaar_center_mean_zero f hf.continuous hPf
  have h := textbookTorusHaarPoincare_mean_zero (fun q ↦ f q - c) (hf.sub contDiff_const) hp hm
  rw [textbookTorusHaarGradientEnergy_sub_const] at h
  exact h

/-- The actual Haar Poincare constant 1/(4π²) is derived from all integer Fourier modes. -/
theorem textbookTorusHaarPoincare {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    (∫ Q : UnitAddTorus (Fin Nc),
      (textbookConfigurationTorusObservable f Q -
        ∫ R : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f R) ^ 2) ≤
      (4 * Real.pi ^ 2)⁻¹ * textbookTorusHaarGradientEnergy f := by
  have h := textbookTorusHaarPoincare_centered f hf hPf
  have hp : 0 < 4 * Real.pi ^ 2 := by positivity
  calc
    _ ≤ textbookTorusHaarGradientEnergy f / (4 * Real.pi ^ 2) :=
      (le_div_iff₀ hp).mpr (by nlinarith)
    _ = _ := by rw [div_eq_mul_inv]; ring

/-- Every actual torus continuous function with smooth Euclidean lift satisfies the Haar variance bound. -/
theorem textbookTorusHaarVariance_poincare {Nc : ℕ} (g : C(UnitAddTorus (Fin Nc), ℝ))
    (hg : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q))) :
    textbookTorusHaarVariance g ≤ (4 * Real.pi ^ 2)⁻¹ *
      textbookTorusHaarGradientEnergy (fun q : Fin Nc → ℝ ↦
        g (textbookConfigurationTorusProjection q)) := by
  have hp : textbookUnitPeriodicPotential (fun q : Fin Nc → ℝ ↦
      g (textbookConfigurationTorusProjection q)) := by
    intro q z
    change g (textbookConfigurationTorusProjection (q + fun i ↦ (z i : ℝ))) =
      g (textbookConfigurationTorusProjection q)
    rw [textbookConfigurationTorusProjection_integer_translate]
  have h := textbookTorusHaarPoincare _ hg hp
  simpa only [textbookConfigurationTorusObservable, textbookConfigurationTorusRepresentative_projects,
    textbookTorusHaarVariance, textbookTorusHaarMean] using h

/-- The original genuine Gibbs variance is bounded by the derived Haar coordinate-gradient energy. -/
theorem textbookGibbsVariance_le_haarGradientEnergy {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ))
    (hg : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q))) :
    textbookGibbsVariance U β g ≤
      (Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * (4 * Real.pi ^ 2)⁻¹) *
        textbookTorusHaarGradientEnergy (fun q : Fin Nc → ℝ ↦
          g (textbookConfigurationTorusProjection q)) := by
  calc
    textbookGibbsVariance U β g ≤
        Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * textbookTorusHaarVariance g :=
      textbookGibbsVariance_le_haar_variance U hU hPU β g
    _ ≤ Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
        ((4 * Real.pi ^ 2)⁻¹ * textbookTorusHaarGradientEnergy
          (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q))) :=
      mul_le_mul_of_nonneg_left (textbookTorusHaarVariance_poincare g hg) (by positivity)
    _ = _ := by ring

end

end MolecularDynamics
