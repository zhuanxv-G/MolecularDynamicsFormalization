import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Algebra
set_option maxHeartbeats 500000
theorem shakeElimination :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1
end MD.Ch04Algebra
