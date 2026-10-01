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
