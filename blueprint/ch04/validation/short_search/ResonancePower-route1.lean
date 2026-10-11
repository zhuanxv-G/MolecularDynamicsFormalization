import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Resonance
set_option maxHeartbeats 400000
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1] := by
  intro Ω hΩ k
  have hne : Ω ≠ 0 := ne_of_gt hΩ
  have ha : Ω*(Real.pi/Ω)=Real.pi := by field_simp
  have hm : MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω)= -!![1,0; -(Real.pi/Ω),1] := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.impulseMatrix,MolecularDynamics.Chapter04Review.slowMatrix,MolecularDynamics.Chapter04Review.fastMatrix,Matrix.mul_apply,Fin.sum_univ_two,ha] <;> ring
  induction k with
  | zero =>
    ext i j
    fin_cases i <;> fin_cases j <;> norm_num
  | succ k hk =>
    rw [pow_succ,hk,hm,pow_succ]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,Nat.cast_add,Nat.cast_one] <;> ring
end MD.Ch04Resonance
