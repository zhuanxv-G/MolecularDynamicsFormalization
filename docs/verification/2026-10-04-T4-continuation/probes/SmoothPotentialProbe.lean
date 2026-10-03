import MolecularDynamics.Notation
import Mathlib.Analysis.Calculus.ContDiff.Comp
import Mathlib.Analysis.Calculus.Gradient.Basic
import Mathlib.Tactic.NormNum

namespace MolecularDynamics

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

theorem gradient_regular_probe {n : ℕ} {U : PotentialEnergy n} {q : Position n}
    (hU : ContDiffAt ℝ 2 U q) : ContDiffAt ℝ 1 (gradient U) q := by
  have hD : ContDiffAt ℝ 1 (fderiv ℝ U) q := hU.fderiv_right (by norm_num)
  change ContDiffAt ℝ 1
    (fun x => (InnerProductSpace.toDual ℝ (Position n)).symm (fderiv ℝ U x)) q
  exact (InnerProductSpace.toDual ℝ (Position n)).symm.contDiff.contDiffAt.comp q hD

#print axioms gradient_regular_probe

end MolecularDynamics
