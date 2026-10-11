import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Algebra
set_option maxHeartbeats 500000
theorem relativeWeightedZero : ∀ N (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V),
    MolecularDynamics.Chapter04Review.totalMass m ≠ 0 → (∑ i, m i • MolecularDynamics.Chapter04Review.relativePositions m q i)=0 := by
  intro N m q hm
  simp only [MolecularDynamics.Chapter04Review.relativePositions,smul_sub,Finset.sum_sub_distrib,← Finset.sum_smul]
  rw [MolecularDynamics.Chapter04Review.centerMass,smul_smul]
  change (∑ i, m i • q i)-(MolecularDynamics.Chapter04Review.totalMass m * (MolecularDynamics.Chapter04Review.totalMass m)⁻¹) • (∑ i, m i • q i)=0
  rw [mul_inv_cancel₀ hm,one_smul,sub_self]
end MD.Ch04Algebra
