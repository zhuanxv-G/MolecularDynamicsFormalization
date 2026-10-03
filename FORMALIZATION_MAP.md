# Textbook to Lean map

Record the edition/page, exact textbook statement, Lean declaration, formal assumptions, and any intentional reformulation when each item is started.

| Textbook content | Lean declaration | Status | Notes |
| --- | --- | --- | --- |
| Chapter 1 §1.2, Eq. (1.3), pp. 18–19: `M q̈ = F(q) = -∇U(q)` | `MolecularDynamics.NBodyEquationAt` | Implemented | Pointwise in a supplied `position` and `acceleration`. `M` is `diagonalMassMatrix masses`. No trajectory or time derivative is introduced at this stage. Mathlib's total `gradient` is used without a differentiability assumption in the definition. |
| Chapter 1 §1.2, Eq. (1.4), p. 18: `E = ∑_j m_j ‖q̇_j‖²/2 + U(q)` | `MolecularDynamics.nBodyTotalEnergy` (using `nBodyKineticEnergy`) | Implemented | With `n = N_c`, the kinetic term is expanded over scalar coordinates as `∑_i masses i * (velocity i)^2 / 2`. In 3D each particle mass is repeated for its three coordinates. |
| Chapter 1 §1.2, Eq. (1.4), auxiliary property: nonnegativity of the kinetic term | `MolecularDynamics.nBodyKineticEnergy_nonneg` | Proved | Assumes explicitly that every coordinate mass is nonnegative: `hm : ∀ i, 0 ≤ masses i`. No condition on velocity is required. |
| Theorem 1.1 | TBD | Not started | Verify statement and hypotheses before implementation. |

## T1 integration (2026-10-02)

The complete proofs below are integrated into `Chapter01/ParticleCoordinates.lean`.
Their standalone and integrated fixed-version checks passed, including 8929
build jobs, Scratch, and 60 declaration dependency audits. The later MathCopilot
read-only review accepted all 11 IDs and 13 proofs; its original reports were
received and checked locally on 2026-10-02. Responsible semantic review is
recorded separately from machine verification.

| Spec ID | Lean declaration | Textbook correspondence and assumptions |
| --- | --- | --- |
| T1-I1 | `flattenParticleVectors_apply` | Particle-first coordinate ordering in §1.2, printed18/PDF41; no positivity assumption. |
| T1-I2 | `unflatten_flatten`, `flatten_unflatten` | The particle/coordinate representations are inverse for all `N,d`, including empty index sets. |
| T1-M1 | `coordinateMassesOfParticles_apply` | Repeats each mass across spatial directions; `d=3` gives the displayed diagonal matrix in (1.3). |
| T1-M2 | `coordinateMassesOfParticles_pos` | Positive particle masses give positive coordinate masses, with no dimension restriction. |
| T1-M3 | `coordinateMassesOfParticles_pos_iff` | The reverse implication explicitly requires `0<d`; it does not follow from empty coordinates. |
| T1-E1 | `nBodyKineticEnergy_particle_eq` | Equality of scalar-coordinate and particle kinetic expressions in (1.4); arbitrary real masses. |
| T1-P1 | `diagonalMassMatrix_posDef_iff` | Auxiliary diagonal-matrix positive-definiteness criterion, not a numbered textbook theorem. |
| T1-P2 | `diagonalMassMatrix_isUnit` | Strictly positive coordinate masses imply matrix invertibility. |
| T1-P3 | `diagonalMassMatrix_mul_inv`, `diagonalMassMatrix_inv_mul` | Both inverse identities under the same strictly positive mass hypothesis. |
| T1-P4 | `diagonalMassMatrix_inv_eq` | Inverse diagonal is the coordinatewise reciprocal under positive masses; no unconditional singular-matrix claim. |
| T1-P5 | `diagonalMassMatrix_inv_mulVec` | Coordinatewise recovery of a Euclidean velocity after mass multiplication and inverse; positive masses. |

## T2-L0 integration (2026-10-03)

`Chapter01/LocalTrajectories.lean` now defines continuous linear mass and
inverse-matrix operators and proves their two coordinate links and two-sided
recovery under positive coordinate masses. These are the L0 algebraic
dependencies for later trajectory theorems. The inverse-matrix operator is
defined for all masses, but its recovery theorems require positivity. The
trajectory bridges are recorded in the next table; general local existence
is a later goal.

| Spec ID | Lean declaration | Textbook correspondence and assumptions |
| --- | --- | --- |
| T2-L0 definitions | `massOperator`, `velocityOperator` | Fixed diagonal matrix `M` and total matrix inverse, printed24/PDF47. |
| T2-L0 coordinates | `massOperator_apply`, `velocityOperator_apply` | The continuous linear operators agree coordinatewise with the matrix actions, for arbitrary real masses. |
| T2-L0 inverse | `massOperator_velocityOperator`, `velocityOperator_massOperator` | Both recovery directions require `∀ i, 0 < μ i` and use T1 matrix inverse results. |

## T2 trajectory integration (2026-10-03)

Complete proofs now cover all seven first-batch specification IDs. The
standalone draft compiled with fixed Lean 4.34.0 and permitted logical
dependencies. The integrated full check passed: pinned versions, source scan,
8930 build jobs, Scratch and 93 imported declaration audits. Evidence is in
`docs/verification/2026-10-03-T2-first-batch/`. Independent
MathCopilot review of these proofs and responsible semantic sign-off remain
pending. These results concern supplied solutions, with an explicit free
particle example; they do not prove general local existence or uniqueness.

| Spec ID | Lean declaration | Textbook correspondence and assumptions |
| --- | --- | --- |
| T2 definitions | `mechanicalVectorField`, `IsMechanicalSolutionOn`, `IsLocalMechanicalIVP` | Fixed-mass first-order equations, printed24/PDF47, and local initial-value formulation, printed26/PDF49. The local predicate includes a positive interval radius and the initial value. |
| T2-S1 | `isMechanicalSolutionOn_iff_components` | An open time domain converts the within-set ODE into the two ordinary derivative equations. No force regularity or mass positivity is needed for this equivalence. |
| T2-B1 | `momentum_eq_mass_deriv_position` | `p=M q̇` along an existing solution; positive masses and an open time domain. |
| T2-B2 | `hasDerivAt_deriv_position` | The actual position derivative has derivative `M⁻¹F(q)` by neighborhood equality and the linear chain rule. This derivative statement alone does not need positive masses. |
| T2-B3 algebra | `solution_nBodyEquationAt` | Equation (1.3), printed18/PDF41: positive masses recover `M q̈=F(q)`, with the explicit model relation `F=-gradient U` on Q. |
| T2-B3 semantics | `solution_nBodyEquationAt_of_differentiable`, `solution_hasGradientAt_potential` | The textbook application adds differentiability of U on Q; the separate `HasGradientAt U (-F q) q` result certifies a genuine gradient. |
| T2-B4 | `newtonTrajectory_to_mechanicalSolution` | A curve with supplied actual velocity/acceleration derivatives and Newton's equation yields the first-order solution with `p=Mv`. No openness of the time set is required because the hypotheses already give two-sided derivatives. |
| T2-E1 | `freeParticle_localIVP` | Explicit `q=q₀+(t-t₀)v₀`, `p=Mv₀`, zero force on the full space, positive masses and positive radius. |
| T2 auxiliary | `IsMechanicalSolutionOn.mono`, `IsMechanicalSolutionOn.continuousOn`, `IsLocalMechanicalIVP.initial_mem` | Restriction, continuity on the supplied time domain, and initial-position membership; no added existence or conservation assumption. |

## T5 potential barriers (2026-10-03)

`Chapter01/PotentialBarriers.lean` integrates the independently compiled T5
proofs. The full-project check passed: pinned versions, source scan, 8931 build
jobs, Scratch and 128 imported declaration audits. Evidence is in
`docs/verification/2026-10-03-T5-first-batch/`. This is a static and conditional
confinement part of the proof route for Theorem 1.1, printed32/PDF55. The full
stability theorem remains unproved; independent website review and responsible
semantic sign-off are pending.

| Spec ID | Lean declaration | Correspondence and assumptions |
| --- | --- | --- |
| T5 definitions | `StrictPotentialMinRadius`, `IsStrictPotentialMinOn`, `IsStrictPotentialMin`, `HasSpherePotentialBarrier` | The textbook's strict punctured-neighborhood minimum, with a relative-domain version and an explicit positive sphere gap. No Hessian condition is imposed. |
| T5-D1 | `strictOn_iff_punctured`, `strictUniv_iff`, `strictOn_isLocalMinOn` | Relative strict minimum and the punctured neighborhood are equivalent in a metric space; the strict notion implies mathlib's non-strict local minimum. |
| T5-C1 | `compact_positive_gap` | Continuity on a compact set and pointwise strict separation imply a uniform positive gap. Empty sets are allowed. |
| T5-S1 | `fixed_sphere_barrier` | Finite-dimensional Euclidean positions, `0<r<R`, sphere inclusion in Q, and continuity on that sphere give a positive barrier. No positive dimension is needed. |
| T5-O1 | `open_domain_barrier` | An open position domain, continuity on it, and a relative strict minimum give `∃R>0, ∀0<r<R, ∃δ>0`; the gap may depend on r. |
| T5 energy auxiliary | `energy_excludes_sphere`, `energy_below_barrier_excludes_sphere` | Nonnegative kinetic energy and energy strictly below the sphere threshold exclude a position on the sphere. |
| T5 trajectory auxiliary | `conserved_trajectory_below_barrier_stays_in_ball`, two center-initial-value variants | For a supplied continuous position curve on `[t₀,t₁]`, an initial position inside the ball, nonnegative kinetic energy and a constant energy below the barrier imply confinement throughout that stated interval. |
| T5 combined auxiliary | `open_domain_energy_confinement` | Combines small-sphere barriers with confinement of any supplied low-energy conserved curve starting in the ball. No ODE existence, conservation proof or extension is inferred. |
| T5-E1 | `quartic_*`, `constant_*`, `zero_dimensional_*`, `singleton_*`, `endpoint_*` | Complete quartic/constant/empty-sphere/domain and `r=R` boundary proofs; they justify the hypotheses without substituting Hessian positivity. |

## T3 fixed-mass Hamiltonian integration (2026-10-03)

`Chapter01/Hamiltonian.lean` integrates five definitions and eighteen complete
theorems, reusing the T2 mass operators. Seven specification IDs cover nine
general goals. The frozen candidate and T2 source hashes were checked before
integration. The full-project check passed: pinned versions, source scan,
8932 build jobs, Scratch and 171 imported declaration audits. Evidence is in
`docs/verification/2026-10-03-T3-first-batch-retry03/`. The installed module also
passed the original nine goals and seven boundary checks. Remote CI is pending;
independent MathCopilot review and responsible semantic sign-off are recorded
separately. Local original-page review passed in the stated static scope.

| Spec ID | Lean declaration | Correspondence and assumptions |
| --- | --- | --- |
| T3 definitions | `coordinateVelocity`, `momentumKineticEnergy`, `massSeparableEnergy`, `massHamiltonian`, `hamiltonianVectorField` | Fixed diagonal mass specialization of printed24/PDF47, using two Euclidean slices for the Hamiltonian field. |
| T3-K1 | `momentumKineticEnergy_eq_inner` | The coordinate sum equals half the inverse-matrix inner product under strictly positive coordinate masses. |
| T3-E1 | `momentumKineticEnergy_massOperator`, `massHamiltonian_massOperator` | Substituting `p=Mv` gives the kinetic and total velocity energies from (1.4); arbitrary real masses, arbitrary U. |
| T3-P1 | `massHamiltonian_particle` | Uses the established particle-first flattening; arbitrary N and d, including zero. |
| T3-G1 | `hasGradientAt_momentumKineticEnergy`, `gradient_momentumKineticEnergy_eq_velocityOperator` | A genuine derivative gives coordinate velocity for arbitrary masses; the matrix inverse interpretation requires positive masses. |
| T3-G2 | `gradient_position_slice`, `hasGradientAt_position_slice` | The total-gradient identity holds for arbitrary U; the genuine position gradient explicitly requires differentiability at q. |
| T3-V1 | `hamiltonianVectorField_eq` | The static field equals `(M⁻¹p,-gradient U q)` under positive masses. A classical Hamilton equation interpretation also requires potential differentiability. |
| T3-R1 | `massHamiltonian_velocityOperator` | For arbitrary p and positive masses, H equals velocity energy at `M⁻¹p`. |

## T4 conservation and local ODE existence (2026-10-03)

`EnergyConservation.lean`, `LocalExistence.lean` and `MomentumConservation.lean`
are imported by the project root. The integrated full check passed with 8935
build jobs and 182 imported declaration dependency audits; see
`docs/verification/2026-10-03-T4-first-batch/`. These results address
printed19/PDF42 and the fixed-mass equations at printed24/PDF47. They do not
establish maximal or global solutions or the full Theorem 1.1.

| Result | Lean declaration | Correspondence and assumptions |
| --- | --- | --- |
| Energy derivative | `mechanical_energy_hasDerivAt_zero` | Along an existing mechanical solution on an open time set, positive masses, differentiable U on Q and `F=-gradient U` make the Hamiltonian derivative zero. |
| Energy conservation | `mechanical_energy_const_on_Ioo` | The same hypotheses on one connected open time interval imply equal energies at any two times in it. |
| Field regularity | `mechanicalVectorField_contDiffAt` | C¹ force at an initial position yields a C¹ fixed-mass mechanical vector field at the initial phase point. |
| Local existence | `exists_localMechanicalIVP_univ`, `exists_localMechanicalIVP_open`, `exists_localMechanicalIVP_open_of_force_contDiffAt` | Construct a genuine local IVP solution; the open-domain versions shrink the interval so positions stay in Q. The final theorem assumes C¹ force at the initial position and q₀∈Q. |
| Local uniqueness | `mechanicalSolution_eventually_unique_of_contDiffAt` | If the mechanical field is C¹ at the common initial phase point, two solutions on an open interval with that initial state agree on some neighborhood of the initial time. |
| Conditional interval uniqueness | `mechanicalSolution_unique_on_Ioo` | Two solutions with the same initial phase state agree on their common open interval under a supplied global Lipschitz bound on the mechanical vector field. |
| Momentum derivative | `totalMomentumCoordinate_hasDerivAt_zero` | For particle-first coordinates, force sums zero in a given spatial direction on Q imply zero derivative of the corresponding total momentum. |
| Momentum conservation | `totalMomentumCoordinate_const_on_Ioo` | The corresponding total-momentum component is constant on a connected open time interval. |
| Equilibrium bridge | `IsMechanicalEquilibrium`, `strictPotentialMin_mechanicalEquilibrium` | A strict relative potential minimum in an open configuration domain, together with the negative-gradient force relation, gives the zero-momentum equilibrium of the fixed-mass mechanical field. This is the equilibrium step only, not Lyapunov stability. |

## T4 momentum bounds and mechanical confinement (2026-10-03, local check passed)

Printed25--26/PDF48--49 and printed32/PDF55 were newly rendered and visually
checked. The fifth full check passed: 8938 build jobs, Scratch and 201 declaration dependency audits. No global extension or full Theorem 1.1 is claimed.

| Result | Lean declaration | Correspondence and assumptions |
| --- | --- | --- |
| Momentum kinetic nonnegativity | `momentumKineticEnergy_nonneg` | Positive coordinate masses make the momentum energy nonnegative, including the zero-dimensional algebraic case. |
| Quantitative momentum bound | `momentum_norm_sq_le`, `momentum_norm_le_of_energy`, `momentum_norm_lt_of_kineticEnergy` | For masses bounded above by M, norm squared is at most 2 M times kinetic energy. Positive M, a potential lower bound and an energy upper bound give the square-root bound. |
| Compact energy set | `isCompact_phaseEnergySublevel` | Positive fixed masses, compact position set K and U continuous on K imply compactness of `{z : z.1 ∈ K ∧ H z ≤ E}`. The lower bound for U and an upper mass bound are derived, including empty K and n=0. |
| Actual solution position bound | `mechanicalSolution_below_barrier_stays_in_ball` | The supplied solution on Ioo satisfies the conservative mechanical ODE. Energy conservation and continuity are derived; only the initial position lies in the ball. The conclusion covers later times inside that interval. |
| Actual solution phase bound | `mechanicalSolution_phase_dist_lt` | Additionally U has its minimum value at the center within the ball, and the initial energy is below the momentum budget. Position and momentum bounds combine in the existing product maximum metric. |

## T4 finite endpoint and gluing dependencies (2026-10-04)

`Chapter01/Continuation.lean` has seven complete proofs. The integrated check
passed at 01:08:40--01:11:13 +08:00: 8939 jobs, Scratch, 208 declaration audits
and stable input hashes. Evidence: `docs/verification/2026-10-04-T4-continuation/full-check01/`.
Theorem 1.1 (printed32/PDF55) was viewed again. These are supporting dependencies;
maximal/global existence, full stability and responsible semantic sign-off remain open.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Complete-space endpoint | `exists_rightEndpointLimit_of_lipschitzOnWith` | a<b and Lipschitz control on Ioo a b; no condition on the ambient value at b. |
| Closed-set endpoint | `exists_rightEndpointLimit_mem_of_lipschitzOnWith` | Image in closed K implies the endpoint belongs to K. |
| Actual derivative control | `mechanicalSolution_lipschitzOnWith_of_field_bound` | ODE plus uniform field nnnorm bound imply Lipschitz control. |
| Mechanical endpoint | `mechanicalSolution_has_rightEndpointLimit_of_field_bound` | Derivative bound and nonempty interval yield a right limit. |
| Compact mechanical endpoint | `mechanicalSolution_has_rightEndpointLimit_of_compact` | Compact K, image in K and field continuity on K derive the bound and a limit in K. |
| Connected-domain uniqueness | `mechanicalSolution_unique_on_preconnected_of_contDiffAt` | Open preconnected domain, common state and C1 field along the first solution; no global Lipschitz assumption. |
| Explicit-overlap gluing | `mechanicalSolution_glue_on_Ioo` | Solutions on (a,b) and (c,d), c<b, equality on (c,b). Equality is explicit, not yet derived from a common endpoint. |
