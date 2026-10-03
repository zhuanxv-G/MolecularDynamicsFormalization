import Mathlib
import MolecularDynamicsFormalization

-- Check small MathCopilot drafts here before moving them into the library.
#check MolecularDynamics.Position
#check MolecularDynamics.SeparableEnergy.hamiltonian
#check MolecularDynamics.massHamiltonian
#check MolecularDynamics.hamiltonianVectorField

#print axioms MolecularDynamics.momentumKineticEnergy_eq_inner
#print axioms MolecularDynamics.massHamiltonian_massOperator
#print axioms MolecularDynamics.massHamiltonian_particle
#print axioms MolecularDynamics.hasGradientAt_momentumKineticEnergy
#print axioms MolecularDynamics.hasGradientAt_position_slice
#print axioms MolecularDynamics.hamiltonianVectorField_eq
#print axioms MolecularDynamics.massHamiltonian_velocityOperator

namespace MolecularDynamics

/-- One mass for each of the `n = N_c` configuration coordinates. -/
abbrev ScratchCoordinateMasses (n : ℕ) := Fin n → ℝ

/-- The diagonal mass matrix associated with coordinate masses. -/
def scratchDiagonalMassMatrix {n : ℕ} (masses : ScratchCoordinateMasses n) :
    MassMatrix n :=
  Matrix.diagonal masses

/-- Pointwise form of textbook equation (1.3), including both displayed equalities. -/
def ScratchNBodyEquationAt {n : ℕ} (masses : ScratchCoordinateMasses n)
    (force : Force n) (potential : PotentialEnergy n) (position acceleration : Position n) :
    Prop :=
  (scratchDiagonalMassMatrix masses).mulVec acceleration = force position ∧
    force position = -gradient potential position

/-- The coordinate form of the kinetic-energy sum in textbook equation (1.4). -/
noncomputable def scratchKineticEnergy {n : ℕ} (masses : ScratchCoordinateMasses n) :
    Velocity n → ℝ :=
  fun velocity => ∑ i, masses i * (velocity i) ^ 2 / 2

/-- Textbook equation (1.4): kinetic plus potential energy. -/
noncomputable def scratchTotalEnergy {n : ℕ} (masses : ScratchCoordinateMasses n)
    (potential : PotentialEnergy n) (position : Position n) (velocity : Velocity n) : ℝ :=
  scratchKineticEnergy masses velocity + potential position

end MolecularDynamics
