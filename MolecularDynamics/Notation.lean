import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Data.Matrix.Basic

/-!
Minimal real, finite-dimensional notation for the autonomous mechanical models.
`n` counts degrees of freedom. Particle and spatial indices can be introduced later.
-/

namespace MolecularDynamics

abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)

abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ

abbrev Force (n : ℕ) := Position n → Position n
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
abbrev KineticEnergy (n : ℕ) := Momentum n → ℝ
abbrev Lagrangian (n : ℕ) := Position n → Velocity n → ℝ
abbrev Hamiltonian (n : ℕ) := PhaseSpace n → ℝ

end MolecularDynamics
