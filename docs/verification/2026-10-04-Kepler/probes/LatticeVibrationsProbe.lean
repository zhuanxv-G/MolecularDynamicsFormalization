import MolecularDynamics.Chapter01.LinearizedHamiltonian

open Set Filter Asymptotics
open scoped Topology InnerProductSpace
namespace MolecularDynamics

noncomputable def gradientLinearizationRemainder {n : ℕ}
    (U : PotentialEnergy n) (q₀ h : Position n) : Momentum n :=
  gradient U (q₀ + h) - fderiv ℝ (gradient U) q₀ h

theorem gradientLinearizationRemainder_isLittleO {n : ℕ}
    (U : PotentialEnergy n) (q₀ : Position n)
    (hU : ContDiffAt ℝ 2 U q₀) (heq : gradient U q₀ = 0) :
    (gradientLinearizationRemainder U q₀) =o[𝓝 0] (fun h : Position n => h) := by
  unfold gradientLinearizationRemainder
  exact equilibriumLinearizationRemainder_of_C1 (gradient U) q₀
    (gradient_contDiffAt_of_potential_contDiffAt_two hU) heq

theorem gradientLinearization_expansion {n : ℕ}
    (U : PotentialEnergy n) (q₀ h : Position n) :
    gradient U (q₀ + h) =
      fderiv ℝ (gradient U) q₀ h + gradientLinearizationRemainder U q₀ h := by
  unfold gradientLinearizationRemainder
  abel

end MolecularDynamics
#print axioms MolecularDynamics.gradientLinearizationRemainder
#print axioms MolecularDynamics.gradientLinearizationRemainder_isLittleO
#print axioms MolecularDynamics.gradientLinearization_expansion
