import MolecularDynamics.Chapter01.LinearizedHamiltonian

open Set Filter Asymptotics
open scoped Topology InnerProductSpace
namespace MolecularDynamics

/-! First-order gradient data used in the lattice-vibration linearization on
printed pages 36--37/PDF59--60. -/
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

theorem potentialHessian_quadratic_nonneg_of_posDef {n : ℕ}
    (U : PotentialEnergy n) (q₀ : Position n)
    (hpos : ∀ v : Position n, v ≠ 0 →
      0 < inner ℝ v (fderiv ℝ (gradient U) q₀ v)) :
    ∀ v : Position n, 0 ≤ inner ℝ v (fderiv ℝ (gradient U) q₀ v) := by
  intro v
  by_cases hv : v = 0
  · simp [hv]
  · exact (hpos v hv).le

theorem linearizedHamiltonianQuadratic_nonneg_of_positive_hessian {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (q₀ : Position n)
    (hm : ∀ i, 0 < m i)
    (hpos : ∀ v : Position n, v ≠ 0 →
      0 < inner ℝ v (fderiv ℝ (gradient U) q₀ v))
    (δq : Position n) (δp : Momentum n) :
    0 ≤ linearizedHamiltonianQuadratic m U q₀ δq δp := by
  exact linearizedHamiltonianQuadratic_nonneg m U q₀ hm
    (potentialHessian_quadratic_nonneg_of_posDef U q₀ hpos) δq δp

end MolecularDynamics
