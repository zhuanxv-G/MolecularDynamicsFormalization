import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03ShortMore
set_option maxHeartbeats 400000
theorem verletOscillatorEnergy :
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2 := by
  intro Ω ρ hΩ hρ hρ2 z
  let A : ℝ := 1-ρ^2/4
  have hA : 0 < A := by dsimp [A]; nlinarith
  let E0 : ℝ := (z.2 0)^2+Ω^2*(z.1 0)^2
  refine ⟨Ω^2*E0/(4*A), by dsimp [E0]; positivity, ?_⟩
  intro h hh ν
  have hh2 : h^2*Ω^2 ≤ ρ^2 := by
    have hp := abs_le.mp hh
    nlinarith
  have hcoeff : A ≤ 1-h^2*Ω^2/4 := by dsimp [A]; linarith
  let K : Z 1 → ℝ := fun w => (w.2 0)^2+Ω^2*(1-h^2*Ω^2/4)*(w.1 0)^2
  have hstep : ∀ w, K (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0) h w) = K w := by
    intro w
    simp only [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]
    ring
  have hi : K (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν) = K z := by
    induction ν with
    | zero => rfl
    | succ ν ih => rw [oneStepIterate_succ, hstep, ih]
  have hupper : K z ≤ E0 := by
    dsimp [K, E0]
    nlinarith [mul_nonneg (sq_nonneg h) (mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sq_nonneg Ω) (sq_nonneg (z.1 0))))]
  have hlower : ∀ w, Ω^2*A*(w.1 0)^2 ≤ K w := by
    intro w
    dsimp [K]
    nlinarith [sq_nonneg (w.2 0), mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sub_nonneg.mpr hcoeff) (sq_nonneg (w.1 0)))]
  let w := oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν
  have hden : 0 < Ω^2*A := mul_pos (sq_pos_of_pos hΩ) hA
  have hw : (w.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower w
    change K w=K z at hi
    nlinarith
  have hz : (z.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower z
    nlinarith
  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (w.1 0), sq_nonneg (z.1 0)]
  have heq : mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z =
      (h^2*Ω^4/8)*((w.1 0)^2-(z.1 0)^2) := by
    norm_num [mechanicalEnergy, quadraticKinetic, Fin.sum_univ_one]
    change K w=K z at hi
    dsimp [K] at hi
    nlinarith
  change |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
    mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ _
  rw [heq, abs_mul, abs_of_nonneg (show 0 ≤ h^2*Ω^4/8 by positivity)]
  calc
    _ ≤ (h^2*Ω^4/8)*(2*E0/(Ω^2*A)) := mul_le_mul_of_nonneg_left habs (by positivity)
    _ = Ω^2*E0/(4*A)*h^2 := by
      have hg : Ω ≠ 0 := ne_of_gt hΩ
      have ha : A ≠ 0 := ne_of_gt hA
      field_simp
      ring
end MD.Ch03ShortMore
