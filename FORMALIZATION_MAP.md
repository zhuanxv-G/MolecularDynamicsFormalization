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

## T4 actual finite endpoint continuation (2026-10-04)

`ODEEndpoint.lean` and `MechanicalContinuation.lean` are integrated. Full-check02
passed at01:18:50--01:21:37 +08:00:8941jobs and214declaration audits, fixed inputs stable.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Endpoint derivative | `hasDerivWithinAt_rightEndpoint_of_continuousOn` | Continuous curve and derivative data on Icc; genuine derivatives on Ioo recover the right endpoint derivative within Icc by FTC. |
| Endpoint matching | `exists_localODE_matching_rightEndpoint` | Existing open-interval solution, right limit and C1 field at the limit derive a local IVP and equality on a left tail. |
| Actual extension | `mechanicalSolution_extend_of_rightEndpointLimit` | Limit position lies in open Q, field C1 at limit; constructs δ>0 and solution on (a,b+δ) agreeing throughout (a,b). |
| Force specialization | `mechanicalSolution_extend_of_force_contDiffAt` | Field regularity follows from force C1 at the endpoint position. |
| Compact extension | `mechanicalSolution_extend_of_compact` | Compact phase K contains the trajectory, K projects into open Q, force C1 along that projection; no endpoint limit or overlap equality assumed. |

Global existence and full Theorem1.1 are still separate. A newly passed
independent global compact-confinement probe is being integrated; it is not
covered by full-check02. Responsible semantic sign-off and new remote CI remain pending.

## T4 global continuation and Theorem 1.1 integration (2026-10-04)

The six new modules passed integrated full-check03 at 06:07:48--06:10:29 +08:00:
8947 jobs, Scratch, 231 declaration audits, pinned versions and stable hashes.
Printed32/PDF55 was viewed again; final responsible semantic sign-off is pending.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Compatible cover | `exists_glued_function_of_compatible`, `exists_mechanicalSolutionOn_iUnion` | Genuine mechanical solutions agree on open overlaps and hence glue on the union. |
| Future continuation | `exists_globalMechanicalSolution_of_local_compact_confinement` | Local IVP, C1 force on open Q, and common compact confinement of every existing local IVP imply all-future existence. The confinement premise does not assume a global solution. |
| Energy discharge | `exists_globalMechanicalIVP_of_energy_barrier` | Conservation and a safe closed position ball derive the compact confinement premise; below-barrier initial states have future solutions. |
| Potential regularity | `gradient_contDiffAt_of_potential_contDiffAt_two` | C2 potential gives C1 gradient by the continuous linear Riesz inverse. |
| Strict future bound | `strictPotentialMin_exists_future_bound`, `strictPotentialMin_futureStable` | Arbitrarily close initial states admit future solutions, and every same-initial-state future solution has bounded distance range with strict supremum less than epsilon. |
| C2 equilibrium/stability | `strictPotentialMin_futureStable_of_potential_contDiffAt_two` | Positive fixed coordinate masses, open Q and strict relative potential minimum. Product maximum metric. |
| Euclidean phase distance | `product_dist_le_phaseEuclideanDistance`, `phaseEuclideanDistance_le_two_mul_dist` | sqrt(dq²+dp²) compares uniformly with the product maximum metric; Euclidean transfer and the smooth-potential theorem passed full-check03. |

The global proof uses the union of all extendable intervals and rules out a
finite supremum. A separate abstract maximal-solution API is not asserted.
No subsequent chapter or complete Chapter1 coverage is implied.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Euclidean stability transfer | `IsFutureMechanicalStable.euclidean` | Product stability at epsilon/2 gives explicit boundedness and strict all-future supremum in sqrt(dq²+dp²). |
| Theorem 1.1 | `strictPotentialMin_futureStableEuclidean_of_smooth` | Smooth U on open Q, strict relative potential minimum, positive fixed diagonal masses; equilibrium plus actual future IVP existence and strict Euclidean supremum bound for every such solution. C2 sufficient version is also proved. |

Full-check03 evidence: `docs/verification/2026-10-04-T4-continuation/full-check03/`.
Responsible final semantic sign-off is pending; no new remote CI under local-only scope.

## Section 1.3--1.4 Lagrangian integration (2026-10-04)

Original printed22--24/PDF45--47 was viewed in this run. The following
modules passed full local acceptance at06:29:14--06:31:00 +08:00:
8950jobs, Scratch,261declaration audits and stable pinned inputs. Evidence is
in `docs/verification/2026-10-04-Lagrangian/full-check01/`.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Velocity kinetic form | `nBodyKineticEnergy_eq_inner`, `hasGradientAt_nBodyKineticEnergy` | Fixed real masses; T(v)=vᵀMv/2 and genuine gradient Mv, including zero masses and n=0 algebraically. |
| Lagrangian partial gradients | `hasGradientAt_massLagrangian_velocity`, `hasGradientAt_massLagrangian_position` | L=T-U; velocity slice always differentiable, position slice assumes U differentiable at q. |
| Euler--Lagrange trajectories | `mechanicalSolution_eulerLagrange`, `eulerLagrange_to_mechanicalSolution` | Actual time derivative predicate; positive masses and differentiable U. Forward direction requires open time I; reverse direction constructs actual (q,M deriv q). |
| Coordinate change | `massLagrangian_coordinateChange`, `hasDerivAt_coordinateChange` | Rectangular Jacobian matrix; static quadratic identity separated from genuine chain-rule derivative hypotheses. |
| Generalized mass | `generalizedMassMatrix_posDef`, `generalizedMassMatrix_isUnit` | Positive masses and injective J.mulVec give positive definite and invertible JᵀMJ. |
| Legendre quadratic gap | `massHamiltonian_legendre_gap`, `legendre_objective_le_massHamiltonian` | Positive masses prove H minus objective equals nonnegative T(v-M⁻¹p). |
| Unique maximizing velocity | `legendre_objective_eq_massHamiltonian_iff` | Equality holds precisely when v=M⁻¹p; derived from kinetic-energy zero iff zero velocity. |
| Actual Legendre supremum | `massHamiltonian_eq_legendre_sup` | BddAbove range and sSup=H; attainment is actually proved, not assumed. U arbitrary in this static result. |

Configuration-dependent generalized dynamics, least-action variation,
all remaining section content and final responsible sign-off are separate.

## Future flow-map integration (2026-10-04)

Printed26/PDF49 was viewed again. `FutureFlow.lean` candidates passed both
independent probe runs and full-check01 at06:40:32--06:42:49:
8951jobs, Scratch,268declaration audits and stable fixed inputs. Evidence in
`docs/verification/2026-10-04-Flow/full-check01/`.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Actual time translation | `mechanicalSolution_translate_on_Ioi` | An actual solution on Ioi a translates to Ioi(a-s), with the same autonomous field. |
| Future composition and commutation | `futureMechanicalFlow_add`, `futureMechanicalFlow_commute` | C1 force, actual future family and forward-invariant S; s,t nonnegative, no assumed group law. |
| Energy invariance | `futureMechanicalFlow_energy` | Derived from actual ODE, positive masses, differentiable U and conservative force. |
| Forward injectivity | `futureMechanicalFlow_injOn` | Two trajectories meeting at a future time have equal initial states by connected-domain uniqueness; no inverse map assumed. |
| Family construction | `exists_futureMechanicalFlow_of_energy_barrier` | Safe closed position ball and actual barrier/global existence construct the family on S={position in ball and H below barrier}, including forward invariance. |

This is not a claim of a two-sided flow group, a continuous Dynamics.Flow
structure, or complete Section1.5.1. Backward existence remains next.

## Two-sided flow integration (2026-10-04)

`TimeReversal.lean` and `GlobalFlow.lean` passed independent probes (the latter
on its first run) and passed Flow/full-check02 at06:52:24--06:54:30:
8953jobs, Scratch,286declaration audits and stable fixed inputs.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Time reflection | `massHamiltonian_momentumReflection`, `mechanicalSolution_time_reverse_on_Iio` | Momentum and time both flip. Genuine ODE derivative and Q membership are checked, with energy unchanged. |
| Two-sided IVP | `exists_globalMechanicalIVP_of_energy_barrier_two_sided` | The forward IVPs of z and reflected z are locally equal after reflection; open-cover gluing constructs an actual univ-time IVP below the energy barrier. |
| All-time laws | `globalMechanicalFlow_add`, `globalMechanicalFlow_inverse`, `globalMechanicalFlow_commute`, `globalMechanicalFlow_bijOn` | Any actual all-time family invariant on S, with C1 force, has real-time composition, inverse, commutation and bijectivity; none are assumed in its predicate. |
| All-time energy | `mechanicalSolution_energy_on_univ`, `globalMechanicalFlow_energy` | Derived from actual ODE conservation with positive fixed masses, differentiable U and conservative force. |
| Actual two-sided family | `exists_globalMechanicalFlow_of_energy_barrier` | Constructs the all-real-time family and invariant S={q in safe ball and H below barrier} from proved IVP existence. |

Initial-state continuity, a continuous Dynamics.Flow structure, arbitrary
coercive-potential global existence and all remaining Section1.5.1 content
remain separate. Responsible semantic sign-off and new remote CI are pending/not run.
