import Lean
import MolecularDynamicsFormalization

-- Keep explicit dependency evidence for the current key textbook theorem.
-- Add corresponding commands when new key theorems enter the formal library.
#print axioms MolecularDynamics.nBodyKineticEnergy_nonneg
#print axioms MolecularDynamics.unflatten_flatten
#print axioms MolecularDynamics.flatten_unflatten
#print axioms MolecularDynamics.coordinateMassesOfParticles_pos_iff
#print axioms MolecularDynamics.nBodyKineticEnergy_particle_eq
#print axioms MolecularDynamics.diagonalMassMatrix_posDef_iff
#print axioms MolecularDynamics.diagonalMassMatrix_inv_eq
#print axioms MolecularDynamics.diagonalMassMatrix_inv_mulVec
#print axioms MolecularDynamics.massOperator_velocityOperator
#print axioms MolecularDynamics.velocityOperator_massOperator
#print axioms MolecularDynamics.isMechanicalSolutionOn_iff_components
#print axioms MolecularDynamics.momentum_eq_mass_deriv_position
#print axioms MolecularDynamics.hasDerivAt_deriv_position
#print axioms MolecularDynamics.solution_nBodyEquationAt
#print axioms MolecularDynamics.solution_nBodyEquationAt_of_differentiable
#print axioms MolecularDynamics.solution_hasGradientAt_potential
#print axioms MolecularDynamics.newtonTrajectory_to_mechanicalSolution
#print axioms MolecularDynamics.freeParticle_localIVP
#print axioms MolecularDynamics.IsLocalMechanicalIVP.initial_mem

#print axioms MolecularDynamics.momentumKineticEnergy_eq_inner
#print axioms MolecularDynamics.momentumKineticEnergy_massOperator
#print axioms MolecularDynamics.massHamiltonian_massOperator
#print axioms MolecularDynamics.massHamiltonian_particle
#print axioms MolecularDynamics.massHamiltonian_velocityOperator
#print axioms MolecularDynamics.hasGradientAt_momentumKineticEnergy
#print axioms MolecularDynamics.gradient_momentumKineticEnergy_eq_velocityOperator
#print axioms MolecularDynamics.gradient_position_slice
#print axioms MolecularDynamics.hasGradientAt_position_slice
#print axioms MolecularDynamics.hamiltonianVectorField_eq

#print axioms MolecularDynamics.strictOn_iff_punctured
#print axioms MolecularDynamics.strictUniv_iff
#print axioms MolecularDynamics.strictOn_isLocalMinOn
#print axioms MolecularDynamics.compact_positive_gap
#print axioms MolecularDynamics.fixed_sphere_barrier
#print axioms MolecularDynamics.open_domain_barrier
#print axioms MolecularDynamics.energy_excludes_sphere
#print axioms MolecularDynamics.energy_below_barrier_excludes_sphere
#print axioms MolecularDynamics.conserved_trajectory_stays_in_ball
#print axioms MolecularDynamics.conserved_trajectory_below_barrier_stays_in_ball
#print axioms MolecularDynamics.conserved_trajectory_center_below_barrier_stays_in_ball
#print axioms MolecularDynamics.open_domain_energy_confinement
#print axioms MolecularDynamics.zero_dimensional_sphere_empty
#print axioms MolecularDynamics.zero_dimensional_barrier
#print axioms MolecularDynamics.zero_dimensional_strict_min
#print axioms MolecularDynamics.singleton_relative_strict
#print axioms MolecularDynamics.singleton_sphere_not_subset
#print axioms MolecularDynamics.quartic_strict_min
#print axioms MolecularDynamics.quartic_sphere_barrier
#print axioms MolecularDynamics.constant_local_min
#print axioms MolecularDynamics.constant_not_strict
#print axioms MolecularDynamics.endpoint_strict_radius
#print axioms MolecularDynamics.endpoint_potential_continuous
#print axioms MolecularDynamics.endpoint_no_barrier
#print axioms MolecularDynamics.quartic_potential_continuous

-- Audit all declarations in the imported project namespace, including private
-- declarations after removing their generated private-name prefix.
open Lean Elab Command in
run_cmd do
  let allowed : Array Name := #[`propext, `Classical.choice, `Quot.sound]
  let env ← getEnv
  let names := env.constants.fold (init := #[]) fun names name _ =>
    if (`MolecularDynamics).isPrefixOf (privateToUserName name) then
      names.push name
    else
      names
  if names.isEmpty then
    throwError "No project declarations were found in the imported environment."
  for name in names do
    let dependencies ← collectAxioms name
    for dependency in dependencies do
      unless allowed.contains dependency do
        throwError "{name} depends on a disallowed logical dependency: {dependency}"
  logInfo m!"Dependency audit passed for {names.size} imported project declarations; allowed: {allowed}."
