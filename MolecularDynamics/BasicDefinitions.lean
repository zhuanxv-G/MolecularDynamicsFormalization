import MolecularDynamics.Notation

namespace MolecularDynamics

/-- Data for a separable Hamiltonian `H(q, p) = K(p) + U(q)`.
The relation of `K` to a mass matrix and of force to `U` is specified later. -/
structure SeparableEnergy (n : ℕ) where
  kinetic : KineticEnergy n
  potential : PotentialEnergy n

def SeparableEnergy.hamiltonian {n : ℕ} (energy : SeparableEnergy n) : Hamiltonian n :=
  fun state => energy.kinetic state.2 + energy.potential state.1

end MolecularDynamics
