import Mathlib
import MolecularDynamicsFormalization

-- Check small MathCopilot drafts here before moving them into the library.
#check MolecularDynamics.Position
#check MolecularDynamics.SeparableEnergy.hamiltonian
#check MolecularDynamics.massHamiltonian
#check MolecularDynamics.hamiltonianVectorField
#check MolecularDynamics.mechanical_energy_const_on_Ioo
#check MolecularDynamics.exists_localMechanicalIVP_open_of_force_contDiffAt
#check MolecularDynamics.mechanicalSolution_eventually_unique_of_contDiffAt
#check MolecularDynamics.totalMomentumCoordinate_const_on_Ioo
#check MolecularDynamics.strictPotentialMin_mechanicalEquilibrium
#check MolecularDynamics.momentum_norm_sq_le
#check MolecularDynamics.isCompact_phaseEnergySublevel
#check MolecularDynamics.mechanicalSolution_phase_dist_lt
#check MolecularDynamics.mechanicalSolution_has_rightEndpointLimit_of_compact
#check MolecularDynamics.mechanicalSolution_unique_on_preconnected_of_contDiffAt
#check MolecularDynamics.mechanicalSolution_glue_on_Ioo
#print axioms MolecularDynamics.exists_rightEndpointLimit_of_lipschitzOnWith
#print axioms MolecularDynamics.exists_rightEndpointLimit_mem_of_lipschitzOnWith
#print axioms MolecularDynamics.mechanicalSolution_lipschitzOnWith_of_field_bound
#print axioms MolecularDynamics.mechanicalSolution_has_rightEndpointLimit_of_field_bound
#print axioms MolecularDynamics.mechanicalSolution_has_rightEndpointLimit_of_compact
#print axioms MolecularDynamics.mechanicalSolution_unique_on_preconnected_of_contDiffAt
#print axioms MolecularDynamics.mechanicalSolution_glue_on_Ioo
#check MolecularDynamics.mechanicalSolution_extend_of_compact
#print axioms MolecularDynamics.hasDerivWithinAt_rightEndpoint_of_continuousOn
#print axioms MolecularDynamics.exists_localODE_matching_rightEndpoint
#print axioms MolecularDynamics.mechanicalSolution_extend_of_rightEndpointLimit
#print axioms MolecularDynamics.mechanicalSolution_extend_of_force_contDiffAt
#print axioms MolecularDynamics.mechanicalSolution_extend_of_compact

#print axioms MolecularDynamics.momentumKineticEnergy_eq_inner
#print axioms MolecularDynamics.massHamiltonian_massOperator
#print axioms MolecularDynamics.massHamiltonian_particle
#print axioms MolecularDynamics.hasGradientAt_momentumKineticEnergy
#print axioms MolecularDynamics.hasGradientAt_position_slice
#print axioms MolecularDynamics.hamiltonianVectorField_eq
#print axioms MolecularDynamics.massHamiltonian_velocityOperator
#print axioms MolecularDynamics.mechanical_energy_hasDerivAt_zero
#print axioms MolecularDynamics.mechanical_energy_const_on_Ioo
#print axioms MolecularDynamics.exists_localMechanicalIVP_open_of_force_contDiffAt
#print axioms MolecularDynamics.mechanicalSolution_unique_on_Ioo
#print axioms MolecularDynamics.mechanicalSolution_eventually_unique_of_contDiffAt
#print axioms MolecularDynamics.totalMomentumCoordinate_const_on_Ioo
#print axioms MolecularDynamics.strictPotentialMin_mechanicalEquilibrium
#print axioms MolecularDynamics.momentum_norm_sq_le
#print axioms MolecularDynamics.momentum_norm_le_of_energy
#print axioms MolecularDynamics.isCompact_phaseEnergySublevel
#print axioms MolecularDynamics.mechanicalSolution_below_barrier_stays_in_ball
#print axioms MolecularDynamics.mechanicalSolution_phase_dist_lt

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
#print axioms MolecularDynamics.exists_glued_function_of_compatible
#print axioms MolecularDynamics.exists_mechanicalSolutionOn_iUnion
#print axioms MolecularDynamics.exists_globalMechanicalSolution_of_local_compact_confinement
#print axioms MolecularDynamics.exists_globalMechanicalIVP_of_energy_barrier
#print axioms MolecularDynamics.gradient_contDiffAt_of_potential_contDiffAt_two
#print axioms MolecularDynamics.strictPotentialMin_exists_future_bound
#print axioms MolecularDynamics.strictPotentialMin_futureStable
#print axioms MolecularDynamics.strictPotentialMin_futureStable_of_potential_contDiffAt_two
#print axioms MolecularDynamics.product_dist_le_phaseEuclideanDistance
#print axioms MolecularDynamics.phaseEuclideanDistance_le_two_mul_dist
#print axioms MolecularDynamics.IsFutureMechanicalStable.euclidean
#print axioms MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_potential_contDiffAt_two
#print axioms MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_smooth
#check MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_smooth
#print axioms MolecularDynamics.nBodyKineticEnergy_eq_inner
#print axioms MolecularDynamics.hasGradientAt_nBodyKineticEnergy
#print axioms MolecularDynamics.hasGradientAt_massLagrangian_velocity
#print axioms MolecularDynamics.hasGradientAt_massLagrangian_position
#print axioms MolecularDynamics.mechanicalSolution_eulerLagrange
#print axioms MolecularDynamics.eulerLagrange_to_mechanicalSolution
#print axioms MolecularDynamics.massLagrangian_coordinateChange
#print axioms MolecularDynamics.hasDerivAt_coordinateChange
#print axioms MolecularDynamics.generalizedMassMatrix_posDef
#print axioms MolecularDynamics.generalizedMassMatrix_isUnit
#print axioms MolecularDynamics.massHamiltonian_legendre_gap
#print axioms MolecularDynamics.legendre_objective_le_massHamiltonian
#print axioms MolecularDynamics.legendre_objective_attains_massHamiltonian
#print axioms MolecularDynamics.nBodyKineticEnergy_eq_zero_iff
#print axioms MolecularDynamics.legendre_objective_eq_massHamiltonian_iff
#print axioms MolecularDynamics.massHamiltonian_eq_legendre_sup
#print axioms MolecularDynamics.mechanicalSolution_translate_on_Ioi
#print axioms MolecularDynamics.futureMechanicalFlow_add
#print axioms MolecularDynamics.futureMechanicalFlow_commute
#print axioms MolecularDynamics.futureMechanicalFlow_energy
#print axioms MolecularDynamics.futureMechanicalFlow_injOn
#print axioms MolecularDynamics.exists_futureMechanicalFlow_of_energy_barrier
