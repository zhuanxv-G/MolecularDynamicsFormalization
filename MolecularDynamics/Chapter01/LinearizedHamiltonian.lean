import MolecularDynamics.Chapter01.HamiltonianHessian
import MolecularDynamics.Chapter01.MomentumBounds

open Set Filter
open scoped InnerProductSpace Topology
namespace MolecularDynamics

/-- The quadratic Hamiltonian displayed by the linearized conservative system. -/
noncomputable def linearizedHamiltonianQuadratic {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (q₀ : Position n)
    (δq : Position n) (δp : Momentum n) : ℝ :=
  momentumKineticEnergy m δp +
    inner ℝ δq (fderiv ℝ (gradient U) q₀ δq) / 2

theorem linearizedHamiltonianQuadratic_eq_textbook_form {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (q₀ : Position n)
    (δq : Position n) (δp : Momentum n) :
    linearizedHamiltonianQuadratic m U q₀ δq δp =
      momentumKineticEnergy m δp +
        inner ℝ δq (fderiv ℝ (gradient U) q₀ δq) / 2 := rfl

theorem linearizedHamiltonianQuadratic_nonneg {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hH : ∀ v : Position n,
      0 ≤ inner ℝ v (fderiv ℝ (gradient U) q₀ v))
    (δq : Position n) (δp : Momentum n) :
    0 ≤ linearizedHamiltonianQuadratic m U q₀ δq δp := by
  unfold linearizedHamiltonianQuadratic
  have hk := momentumKineticEnergy_nonneg m δp hm
  have hq := hH δq
  positivity

/-- Strict positive masses make the kinetic block nonnegative; the potential
block is separately controlled by the actual Hessian quadratic-form hypothesis. -/
theorem linearizedHamiltonianQuadratic_nonneg_of_hessian {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hH : ∀ v : Position n,
      0 ≤ inner ℝ v (fderiv ℝ (gradient U) q₀ v))
    (δq : Position n) (δp : Momentum n) :
    0 ≤ linearizedHamiltonianQuadratic m U q₀ δq δp :=
  linearizedHamiltonianQuadratic_nonneg m U q₀ hm hH δq δp

end MolecularDynamics
