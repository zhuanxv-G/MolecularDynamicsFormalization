import Mathlib
import MolecularDynamics.BasicDefinitions

/-!
# The N-body problem

Foundational definitions for Leimkuhler--Matthews, Chapter 1, Section 1.2,
equations (1.3) and (1.4). Here `n` is the total number `N_c` of configuration
coordinates, rather than the number of particles.
-/

namespace MolecularDynamics

/-- One mass for each of the `n = N_c` configuration coordinates.

For particles in three dimensions, the same particle mass occurs in each of its
three coordinate entries. Positivity is not included because it is not needed to
state equations (1.3) and (1.4). -/
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ

/-- The diagonal mass matrix `M` in equation (1.3). -/
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses

/-- Equation (1.3) at a position with a specified acceleration:
`M q̈ = F(q)` and `F(q) = -∇U(q)`.

Mathlib's `gradient` is a total operation, so this definition itself requires no
differentiability hypothesis. Such hypotheses must be stated on later theorems
that use differentiation rules. -/
def NBodyEquationAt {n : ℕ} (masses : CoordinateMasses n) (force : Force n)
    (potential : PotentialEnergy n) (position acceleration : Position n) : Prop :=
  (diagonalMassMatrix masses).mulVec acceleration = force position ∧
    force position = -gradient potential position

/-- The kinetic term in equation (1.4), expressed using the `N_c` scalar
configuration coordinates. -/
noncomputable def nBodyKineticEnergy {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) : ℝ :=
  ∑ i, masses i * (velocity i) ^ 2 / 2

/-- The kinetic energy in equation (1.4) is nonnegative when every coordinate
mass is nonnegative. -/
theorem nBodyKineticEnergy_nonneg {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) (hm : ∀ i, 0 ≤ masses i) :
    0 ≤ nBodyKineticEnergy masses velocity := by
  unfold nBodyKineticEnergy
  apply Finset.sum_nonneg
  intro i _
  exact div_nonneg (mul_nonneg (hm i) (sq_nonneg (velocity i))) (by norm_num)

/-- Equation (1.4): the total mechanical energy `E(q, q̇) = T(q̇) + U(q)`. -/
noncomputable def nBodyTotalEnergy {n : ℕ} (masses : CoordinateMasses n)
    (potential : PotentialEnergy n) (position : Position n) (velocity : Velocity n) : ℝ :=
  nBodyKineticEnergy masses velocity + potential position

end MolecularDynamics
