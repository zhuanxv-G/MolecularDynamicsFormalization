import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology
noncomputable section
namespace MD.Ch03BracketSearch
set_option maxHeartbeats 200000
theorem potentialDoubleBracket :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ 2 U → ∀ z : Z n,
    (∑ i, grad U z.1 i*invMass m (grad U z.1) i)=
      textbookPoissonBracket (fun x => U (unpack x).1)
        (textbookPoissonBracket (fun x => U (unpack x).1) (fun x => quadraticKinetic m (unpack x).2)) (pack z) := by
  intro n m U hm hU z
  simp_rw [textbookPoissonBracket_coordinates]
  dsimp [grad, invMass, unpack, pack, quadraticKinetic]
  simp [fderiv_fun_sum, fderiv_comp, fderiv_const_mul, fderiv_fun_mul,
    Pi.single_apply]
  ring
end MD.Ch03BracketSearch
