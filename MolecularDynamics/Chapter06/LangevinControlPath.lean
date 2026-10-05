import MolecularDynamics.Chapter06.LangevinHormander
import Mathlib.Analysis.Calculus.ContDiff.Deriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! The actual smooth control-path construction in Lemma6.1, printed255--256/PDF276--277. -/

open Set Filter MeasureTheory
open scoped Topology ContDiff

namespace MolecularDynamics

private noncomputable def controlQuadratic {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) : Fin Nc → ℝ :=
  (3 / T ^ 2) • (y.1 - x.1) - (2 / T) • x.2 - (1 / T) • y.2

private noncomputable def controlCubic {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) : Fin Nc → ℝ :=
  (-2 / T ^ 3) • (y.1 - x.1) + (1 / T ^ 2) • (x.2 + y.2)

/-- The genuine cubic Hermite position path between the two phase endpoints. -/
noncomputable def textbookLangevinControlPosition {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) (t : ℝ) : Fin Nc → ℝ :=
  x.1 + t • x.2 + t ^ 2 • controlQuadratic T x y + t ^ 3 • controlCubic T x y

/-- The actual velocity of the cubic position path. -/
noncomputable def textbookLangevinControlMomentum {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) (t : ℝ) : Fin Nc → ℝ :=
  x.2 + (2 * t) • controlQuadratic T x y + (3 * t ^ 2) • controlCubic T x y

private noncomputable def controlAcceleration {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) (t : ℝ) : Fin Nc → ℝ :=
  (2 : ℝ) • controlQuadratic T x y + (6 * t) • controlCubic T x y

/-- The original substitution solves for the genuine control derivative. -/
noncomputable def textbookLangevinControlRate {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (x y : textbookLangevinPhase Nc) (t : ℝ) :
    Fin Nc → ℝ :=
  σ⁻¹ • (controlAcceleration T x y t -
    textbookPotentialForce U (textbookLangevinControlPosition T x y t) +
      γ • textbookLangevinControlMomentum T x y t)

/-- The actual driving path, obtained by a genuine Bochner interval integral. -/
noncomputable def textbookLangevinControlPath {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (x y : textbookLangevinPhase Nc) (t : ℝ) :
    Fin Nc → ℝ := ∫ s in 0..t, textbookLangevinControlRate U γ σ T x y s

private theorem control_position_smooth {Nc : ℕ} (T : ℝ) (x y : textbookLangevinPhase Nc) :
    ContDiff ℝ ∞ (textbookLangevinControlPosition T x y) := by
  unfold textbookLangevinControlPosition
  fun_prop

private theorem control_momentum_smooth {Nc : ℕ} (T : ℝ) (x y : textbookLangevinPhase Nc) :
    ContDiff ℝ ∞ (textbookLangevinControlMomentum T x y) := by
  unfold textbookLangevinControlMomentum
  fun_prop

private theorem control_acceleration_smooth {Nc : ℕ} (T : ℝ) (x y : textbookLangevinPhase Nc) :
    ContDiff ℝ ∞ (controlAcceleration T x y) := by
  unfold controlAcceleration
  fun_prop

private theorem control_rate_smooth {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (x y : textbookLangevinPhase Nc) : ContDiff ℝ ∞ (textbookLangevinControlRate U γ σ T x y) := by
  exact (((control_acceleration_smooth T x y).sub
    ((textbookLangevinForce_contDiff U hU).comp (control_position_smooth T x y))).add
      ((control_momentum_smooth T x y).const_smul γ)).const_smul σ⁻¹

/-- The position has the literal cubic velocity at every time. -/
theorem textbookLangevinControlPosition_hasDerivAt {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) (t : ℝ) :
    HasDerivAt (textbookLangevinControlPosition T x y)
      (textbookLangevinControlMomentum T x y t) t := by
  have hd := (((hasDerivAt_const t x.1).add ((hasDerivAt_id t).smul_const x.2)).add
    (((hasDerivAt_id t).pow 2).smul_const (controlQuadratic T x y))).add
      (((hasDerivAt_id t).pow 3).smul_const (controlCubic T x y))
  convert! hd using 1
  simp [textbookLangevinControlMomentum]

private theorem control_momentum_derivative {Nc : ℕ} (T : ℝ)
    (x y : textbookLangevinPhase Nc) (t : ℝ) :
    HasDerivAt (textbookLangevinControlMomentum T x y) (controlAcceleration T x y t) t := by
  have hd := ((hasDerivAt_const t x.2).add
    (((hasDerivAt_id t).const_mul 2).smul_const (controlQuadratic T x y))).add
      ((((hasDerivAt_id t).pow 2).const_mul 3).smul_const (controlCubic T x y))
  convert! hd using 1
  dsimp [controlAcceleration]
  have he : 3 * (2 * t) = 6 * t := by ring
  simp [he]

/-- All four actual position/momentum endpoint constraints are derived. -/
theorem textbookLangevinControl_endpoints {Nc : ℕ} (T : ℝ) (hT : 0 < T)
    (x y : textbookLangevinPhase Nc) :
    textbookLangevinControlPosition T x y 0 = x.1 ∧
      textbookLangevinControlMomentum T x y 0 = x.2 ∧
      textbookLangevinControlPosition T x y T = y.1 ∧
      textbookLangevinControlMomentum T x y T = y.2 := by
  have hn := ne_of_gt hT
  refine ⟨by simp [textbookLangevinControlPosition],
    by simp [textbookLangevinControlMomentum], ?_, ?_⟩
  · ext i
    simp [textbookLangevinControlPosition, controlQuadratic, controlCubic]
    field_simp [hn]
    ring
  · ext i
    simp [textbookLangevinControlMomentum, controlQuadratic, controlCubic]
    field_simp [hn]
    ring

/-- The actual time integral has the prescribed control derivative. -/
theorem textbookLangevinControlPath_hasDerivAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (x y : textbookLangevinPhase Nc) (t : ℝ) :
    HasDerivAt (textbookLangevinControlPath U γ σ T x y)
      (textbookLangevinControlRate U γ σ T x y t) t := by
  have hc := (control_rate_smooth U hU γ σ T x y).continuous
  exact intervalIntegral.integral_hasDerivAt_right (hc.intervalIntegrable 0 t)
    hc.aestronglyMeasurable.stronglyMeasurableAtFilter hc.continuousAt

/-- Smoothness of the actual integral path follows from its actual derivative. -/
theorem textbookLangevinControlPath_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (x y : textbookLangevinPhase Nc) : ContDiff ℝ ∞ (textbookLangevinControlPath U γ σ T x y) := by
  rw [contDiff_infty_iff_deriv]
  refine ⟨fun t ↦ (textbookLangevinControlPath_hasDerivAt U hU γ σ T x y t).differentiableAt, ?_⟩
  have he : deriv (textbookLangevinControlPath U γ σ T x y) =
      textbookLangevinControlRate U γ σ T x y := by
    funext t
    exact (textbookLangevinControlPath_hasDerivAt U hU γ σ T x y t).deriv
  rw [he]
  exact control_rate_smooth U hU γ σ T x y

/-- The genuinely constructed paths solve the original controlled Langevin equation. -/
theorem textbookLangevinControlMomentum_hasDerivAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ) (hσ : σ ≠ 0)
    (x y : textbookLangevinPhase Nc) (t : ℝ) :
    HasDerivAt (textbookLangevinControlMomentum T x y)
      (textbookPotentialForce U (textbookLangevinControlPosition T x y t) -
        γ • textbookLangevinControlMomentum T x y t +
          σ • deriv (textbookLangevinControlPath U γ σ T x y) t) t := by
  rw [(textbookLangevinControlPath_hasDerivAt U hU γ σ T x y t).deriv]
  have he : textbookPotentialForce U (textbookLangevinControlPosition T x y t) -
      γ • textbookLangevinControlMomentum T x y t +
        σ • textbookLangevinControlRate U γ σ T x y t = controlAcceleration T x y t := by
    simp only [textbookLangevinControlRate, smul_smul, mul_inv_cancel₀ hσ, one_smul]
    abel
  rw [he]
  exact control_momentum_derivative T x y t

/-- The original smooth control exists for arbitrary phase endpoints and positive time. -/
theorem textbookLangevinControlledEndpoint {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t := by
  obtain ⟨hq0, hp0, hqT, hpT⟩ := textbookLangevinControl_endpoints T hT x y
  refine ⟨textbookLangevinControlPosition T x y, textbookLangevinControlMomentum T x y,
    textbookLangevinControlPath U γ σ T x y,
    control_position_smooth T x y, control_momentum_smooth T x y,
    textbookLangevinControlPath_contDiff U hU γ σ T x y,
    hq0, hp0, hqT, hpT, ?_, ?_⟩
  · simp [textbookLangevinControlPath]
  · intro t
    exact ⟨textbookLangevinControlPosition_hasDerivAt T x y t,
      textbookLangevinControlMomentum_hasDerivAt U hU γ σ T hσ x y t⟩

end MolecularDynamics
