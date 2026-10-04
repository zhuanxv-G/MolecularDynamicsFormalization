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

## Explicit harmonic and free-particle flows (2026-10-04)

Printed27/PDF50 was visually checked. HarmonicOscillator and FreeParticleFlow
independent probes passed; integrated full-check02 passed at07:09:12--07:10:36 (8955jobs,310declaration audits, stable pinned inputs).

| Result | Lean declarations | Scope |
| --- | --- | --- |
| Explicit oscillator | harmonicFlow_isMechanicalSolution, harmonicFlow_isGlobalFlow | Actual q'=p, p'=-Ω²q on all real time, unit masses, nonzero scalar Ω, arbitrary finite n. |
| Continuous oscillator flow | harmonicFlow_continuous, harmonicContinuousFlow, harmonicFlow_add, harmonicFlow_inverse | Joint time/state continuity and actual mathlib Flow; composition/inverse derive from genuine ODE uniqueness. |
| Oscillator energy | hasGradientAt_harmonicPotential, harmonicFlow_energy | True gradient of ΣΩ²qᵢ²/2 and actual Hamiltonian conservation. |
| Free particle | freeParticleFlow_isMechanicalSolution, freeParticleFlow_isGlobalFlow, freeParticleFlow_add | q=q₀+tM⁻¹p₀, constant p, actual all-time total mass-operator ODE. Physical interpretation uses positive masses. |
| Continuous free flow | freeParticleFlow_continuous, freeParticleContinuousFlow, freeParticleFlow_energy | Joint continuity, genuine Flow and zero-potential energy invariance. |

General initial-state dependence, spectral decomposition, matrix exponential,
and all remaining Section1.5.1 claims are separate. Responsible sign-off pending.

## Constant-linear exponential IVPs and real spectral formulas (2026-10-04)

Printed27/PDF50 was viewed. Independent Linear03, Matrix03 and Spectral03 probes passed;
full-check01 passed:8958jobs,348project audits, Scratch, pinned versions/source scan and stable input SHA.

| Result | Lean declaration | Exact scope |
| --- | --- | --- |
| Actual exponential ODE | hasDerivAt_linearExponentialFlow, hasDerivAt_linearExponentialFlow_initial_time, linearExponentialFlow_unique | Real Banach-space continuous-linear A, actual exp((t-t₀)A) derivative/initial value and all-time IVP uniqueness. |
| Continuous flow/laws | linearExponentialFlow_continuous, linearContinuousFlow, linearExponentialFlow_add, linearExponentialFlow_inverse | Actual joint continuity and Flow, commuting scalar multiples derive the laws. |
| Genuine matrix formula | matrixExponentialFlow_eq, hasDerivAt_matrixExponentialFlow_initial_time, matrixExponentialFlow_unique, matrixContinuousFlow | Continuous algebra equivalence proves exact exp(tA)mulVec representation, real finite m including0; no diagonalizability/invertibility assumed. |
| Exponential series | linearExponentialOperator_series, matrixExponential_series | Genuine convergent Banach/matrix exponential series; no new symbolic exp definition. |
| Real spectral solution | hasDerivAt_realEigenmode, linearExponentialFlow_realEigenmode, linearExponentialFlow_realSpectral_sum, linearExponentialFlow_realEigenbasis | Real eigenvalues/vectors. Eigenbasis coefficients are Basis.repr z, not an assumed initial decomposition. |

Complex spectral decomposition and real recovery, general nonlinear initial-state
continuity and the rest of the book remain open. Final responsible sign-off pending.

## Complex spectrum, real recovery and column-basis matrix (2026-10-04)

Printed27--28/PDF50--51 checked. Independent Complex04, RealRecovery02 and
BasisMatrix03 passed; integrated ComplexSpectral/full-check01 passed at07:40:13--07:41:57:8961jobs,382project audits, Scratch, pinned versions/scan and stable SHA.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Complex modes and eigenbasis | hasDerivAt_complexEigenmode, complexExponentialFlow_eigenmode, complexExponentialFlow_spectral_sum, complexExponentialFlow_eigenbasis | Real time, complex eigenvalues/vectors/coefficients; actual ODE/uniqueness gives spectral formulas when the corresponding decomposition/eigenbasis exists. |
| Real-time complex flow | hasDerivAt_complexExponentialFlow, complexContinuousFlow | Real-scalar restriction of complex-linear A yields a genuine continuous Flow with actual ODE. |
| Unique coefficients | complexEigenbasis_coefficients_unique | repr supplies the unique coefficient family for the supplied complex basis. |
| Actual real recovery | realMatrix_complexFlow_isReal, realMatrix_complexSpectral_sum_isReal | A real matrix and initial coordinate imaginary parts0 imply all-time imaginary parts0, including the complex spectral sum; individual modes need not be real. |
| Basis-column matrix | basisColumnMatrix_mulVec, basisColumnMatrix_mulVec_repr, basisColumnMatrix_isUnit, basisColumnMatrix_inverse_coefficients | X columns are basis vectors; actual Xc=z, proved invertibility and c=X⁻¹z for real/complex RCLike coefficients, including dimension0. |

These results complete the checked linear example formulas, not all nonlinear
claims of Section1.5.1 or the whole book. Responsible sign-off remains pending.

## First integrals, angular momentum and polar dependencies (2026-10-04)

Printed28--29/PDF51--52 viewed. Independent probes passed;
FirstIntegrals/full-check01 passed at07:49:56--07:52:08:8964jobs,403project audits, Scratch, pinned versions/scan and stable SHA.

| Result | Lean declaration | Exact boundary |
| --- | --- | --- |
| Genuine first-integral criterion | IsFirstIntegralOn, isFirstIntegralOn_iff_differential, firstIntegral_const_on_Ioo, firstIntegral_gradient_criterion | Actual conservation along all Q-valued interval trajectories iff DI·f=0, with open Q/C1 f/local IVPs for necessity, differentiable I. Hilbert gradient bridge separately proved. |
| Planar conservation | planarAngularMomentum_hasDerivAt_zero, planarAngularMomentum_const_on_Ioo, centralForce_planarAngularMomentum_const | Unit-mass planar actual ODE and zero torque; central-force torque zero is proved. |
| Polar identities | polarKinetic_identity, polarAngularMomentum_identity, keplerPolarLagrangian_identity | Actual trig/algebraic identities for velocity/kinetic energy/angular momentum and the displayed Kepler L expression. |
| Actual polar curve derivatives | polarCoordinates_hasDerivAt_components | True HasDerivAt assumptions for r,theta yield actual Cartesian time derivatives. |
| Coordinate coefficient matrix | polarJacobian_det, polarJacobian_isUnit_iff | det=r and invertibility iff r≠0 for the velocity-transform matrix; a full Frechet Jacobian and general EL covariance remain separate. |

Kepler potential gradient, polar dynamics/radial quadrature, action-angle and
torus claims remain open. Section1.5.2 stays partial; responsible sign-off pending.

## Kepler actual potential, force and conserved IVPs (2026-10-04)

Printed29/PDF52 checked. Independent Kepler03 passed;
Kepler/full-check01 passed at07:59:01--08:00:56:8965jobs,412project audits, Scratch, pinned versions/scan and stable SHA.

| Result | Lean declaration | Scope |
| --- | --- | --- |
| Actual inverse-distance gradient | hasGradientAt_keplerPotential, keplerForce_eq_neg_gradient | U=-1/‖q‖, grad U=q/‖q‖³ and F=-grad U at q≠0. |
| Regular field and actual local IVP | keplerForce_contDiffAt, exists_kepler_localIVP | C1 force on the open nonzero position domain, actual unit-mass local IVP for every nonzero initial position. |
| True conserved energy and angular momentum | kepler_energy_const_on_Ioo, kepler_planarAngularMomentum_const_on_Ioo | Actual trajectories avoiding0; energy in any finite dimension, planar angular momentum in dimension2. |

Collision-free global continuation, polar radial dynamics/quadrature and complete
integrability claims remain open; responsible sign-off pending.

### Genuine polar derivative and local chart (2026-10-04)

Printed29/PDF52: `PolarCoordinateMap.lean` proves the actual strict Frechet derivative of (r cosθ,r sinθ), identifies its fderiv with the previously verified matrix, and constructs a genuine OpenPartialHomeomorph at r≠0. The inverse has the strict derivative of the inverse linear equivalence. No global inverse across periodic angles is asserted. Euler--Lagrange covariance, radial reduction and quadrature remain separate tasks.

### Kepler polar EL, radial energy and angular quadrature (2026-10-04)

Printed29--30/PDF52--53: KeplerPolarDynamics proves four actual scalar partial derivatives of the displayed polar Lagrangian. The true Euler--Lagrange predicate uses these deriv slices and actual time derivatives. Its equivalence to radial acceleration and angular-momentum derivative zero is proved, not assumed. Angular momentum conservation yields the reduced radial force, true radial effective-energy conservation (including initial-angular-momentum version) and genuine angle interval integral via FTC. General coordinate covariance, actual Cartesian Kepler equivalence, solving the radial IVP by quadrature, orbit classification and action-angle/torus remain separate.

### Genuine Cartesian/polar Kepler equivalence (2026-10-04)

Printed29--30/PDF52--53: KeplerCartesianBridge proves norm=positive radius, actual Cartesian angular momentum/energy equal the polar formulas, and polar EL→true Cartesian mechanical solution. Conversely, on open time sets with a positive-radius true kinematic lift r'=v,θ'=ω, the actual Cartesian momentum derivative implies radial acceleration; central-force angular momentum derivative gives the angular EL equation. Hence genuine EL/mechanical equivalence is proved for those lifts without assuming the acceleration conclusions. Local polar lift existence and solving/reconstructing radial IVPs remain separate.

### Kepler reconstruction from actual radial IVPs (2026-10-04)

Printed30/PDF53: KeplerReconstruction proves the true angle-integral derivative from positive-radius actual curves, then radial mechanical trajectories reconstruct polar EL and Cartesian Kepler solutions. C1 effective radial force gives real local IVPs for arbitrary positive radial initial data. Complex.arg plus proved trigonometric/velocity algebra gives polar representation of every nonzero-position Cartesian state. Thus any such Cartesian initial state has a true Kepler local IVP constructed from a real radial IVP and explicit angle integral. Separating the radial equation by an antiderivative/inverse, turning points and orbit classification remain separate.

### Actual scalar separated quadrature and inverse (2026-10-04)

Printed28/PDF51 and30/PDF53: SeparableQuadrature proves G(x)=∫x₀..x 1/w has the actual strict derivative 1/w(x) when w is continuous and nonzero on an open position interval. FTC and the inverse function theorem give a true local inverse g with both inverse identities and strict derivative w(x₀). Every actual solution r'=w(r) in that interval satisfies G(r(t))=t-t₀, then locally r(t)=g(t-t₀). Integrability is derived from continuity/nonzero denominator. Kepler square-root branch reduction and turning points are separate.

### Kepler signed radial quadrature (2026-10-04)

Printed30/PDF53: KeplerQuadrature reduces actual positive-radius radial trajectories using true energy conservation, v²=2(E+1/r-l²/(2r²)). At each actual nonturning point v(t₀)≠0, continuity proves a position window with positive radicand and a time window with fixed velocity sign. A derived σ=±1 gives w=σ√(2(E+1/r-l²/(2r²))), true separated integral=time difference and a local inverse g with strict derivative v(t₀) and r(t)=g(t-t₀). Turning points and global orbit classification are separate.

### Harmonic action-angle dynamics (2026-10-04)

Printed30/PDF53: HarmonicActionAngle proves x=√(2I/Ω)cosθ and v=√(2IΩ)sinθ, actual E=IΩ, actual derivative equations equivalent to I'=0/θ'=-Ω for differentiable positive-action lifts, actual interval time formulas, and global explicit θ(t)=θ₀-Ω(t-t₀). Every nonzero scalar initial phase has a proved positive-action representation using complex argument. A true identity intertwines the accepted harmonicFlow with θ↦θ-Ωt. Local invertible coordinate chart and multi-oscillator torus/density are separate.

### Genuine harmonic action-angle local chart (2026-10-04)

Printed30/PDF53: ActionAngleChart supplies the actual strict Fréchet derivative of (I,θ)↦(√(2I/Ω)cosθ,√(2IΩ)sinθ), the actual Jacobian det=1, and an OpenPartialHomeomorph around every Ω>0,I>0 point with strict differentiable inverse. This completes local coordinate invertibility for the accepted actual action-angle dynamics; angle periodicity prevents a global real-angle inverse.

### Actual decoupled oscillator angle torus (2026-10-04)

Printed30/PDF53: HarmonicTorus is the finite product of actual angle quotient circles ℝ/(2πℤ); continuous rotation gives a genuine Flow. Its period condition is exactly ΩⱼT∈2πℤ for every j; integer multiples of a common nonzero base frequency give the expected period. The continuous torus phase map has image exactly the fixed positive coordinate-energy levels. Actual angle rotation maps to a true unit-mass decoupled harmonic mechanical solution. Irrational density and high-dimensional integer resonance are separate.

### Torus topology, two-frequency density and resonance (2026-10-04)

Printed30/PDF53: TorusDensity proves fixed positive coordinate-energy levels are actually homeomorphic to the finite product angle torus, using continuous injectivity and compactness. For two frequencies with Ω₀≠0 and Ω₁/Ω₀ irrational, true real-time rotation is DenseRange for every initial angle; this follows from irrational return-angle integer multiples and continuous closure, without assuming density. The corresponding actual mechanical phase orbit has every fixed-energy phase point in its closure. In three dimensions Ω₂=Ω₀+Ω₁ gives a true conserved angle relation and proves non-density, so higher-dimensional pairwise irrational ratios are not used as a sufficient condition.

### Exact two-frequency rational/irrational period distinction (2026-10-04)

Printed30/PDF53: TorusPeriod proves existence of a positive real-time period iff Ω₁/Ω₀ is rational for Ω₀>0; the rational witness constructs an actual period using numerator/denominator, and the reverse derives a rational ratio from the true integer angle-period criterion. Irrational ratio gives no positive period. Positive-frequency/action phase injectivity transfers the iff and nonperiodicity to the real mechanical orbit, not only the abstract angle variables.

### Genuine first-integral implicit level graph (2026-10-04)

Printed28/PDF51: FirstIntegralGraph derives actual invertibility of the scalar y-partial from L(0,1)≠0, then the real implicit function theorem constructs ψ with ψ(x₀)=y₀, actual differentiability and exact local equivalence J(x,y)=J(x₀,y₀) iff y=ψ(x). Conservation of the actual first integral along actual trajectories proves the local graph representation and genuine scalar derivative x'=f₁(x,ψ(x)); the graph and reduced ODE are derived rather than assumed. C1 graph-neighborhood speed and separated quadrature remain separate.

### Actual planar first-integral quadrature (2026-10-04)

Printed28/PDF51: FirstIntegralQuadrature constructs a true C1 implicit level graph from actual C1 first integral and nonzero y-partial. Actual C1 vector field plus nonzero base x-velocity yields a derived neighborhood with continuous nonzero reduced speed and a derived actual-trajectory time window. The accepted separated integral/inverse theorem gives actual x(t)=g(t-t₀), y(t)=ψ(g(t-t₀)), both local inverse identities, strict derivative g'(0)=f₁(p) and true integral=time formula. Graph/continuous speed/trajectory range and inverse solution are derived, not added as hypotheses.

### ScalarIntegrability — printed20/PDF43 Example1.4 and28/PDF51 Example1.6

For unit mass and a genuine C2 real potential U, proves actual energy derivative zero along every true ODE, its first-integral property, true velocity partial v, C1 vector field, and local inverse-quadrature recovery of both coordinates whenever initial velocity is nonzero. No assumed graph/inverse/conservation conclusion. Turning/stationary/global continuation remain separate.

### ScalarTurning — Example1.4 degenerate velocity handling

True coordinate swap derives C1 field/energy, first integral and energy position partial U′. If U′ at the initial position is nonzero, actual velocity is the separating scalar and its strict integral inverse recovers velocity and position even at zero-velocity turning points. If velocity and U′ both vanish, the true constant solution is locally unique by C1 ODE uniqueness and remains constant on the whole connected original solution interval, via open/relative-closed coincidence set. These are local quadratures and interval stationarity, not global nonstationary existence.

### ScalarLocalIVP — genuine arbitrary-data local integrability

C1 derived field gives an actual local IVP for every real initial position/velocity and initial time. Actual energy constancy and exhaustive disjoint alternatives follow: nonzero velocity gives position quadrature; zero velocity/nonzero U′ gives velocity quadrature; both zero give whole-interval stationarity. Each quadrature predicate stores actual two coordinates, strict inverse derivative, both inverse identities and integral-time identity. Local original statement only, not nonstationary global existence.

### EquilibriumLinearization — printed31/PDF54, actual first-order linearization

Constant trajectory true ODE iff f(z*)=0; actual Frechet derivative gives R(h)=f(z*+h)-Ah=o(h). C1 implies actual A=fderiv; nonlinear perturbation satisfies exactly δ′=Aδ+Rδ. Genuine linearized IVP δ′=Aδ is provided by accepted operator exponential. Mechanical field actual block derivative is (dq,dp)↦(M⁻¹dp,DFdq); conservative C2 potential gives DF=-D(gradient U). No Hartman–Grobman conjugacy claimed.

### LocalContinuousFlow — genuine local flow-map dependence

Fixed Picard–Lindelöf data from a C1 vector field yields one actual family Φ(z,t), joint continuous on a product closed-ball/time interval, uniformly Lipschitz in initial state, and satisfying the true ODE for each initial point. For a mechanical C1 force field, the actual block field is bridged; open configuration domains are handled by shrinking radii from true continuity so every local trajectory stays in Q. This is local only and does not assert a global flow or Hartman–Grobman conjugacy.

### HamiltonianHessian — printed32/PDF55 quadratic linearization data

For every C2 real potential, the actual second Frechet derivative is symmetric. Combined with the previously verified conservative mechanical block derivative, this records the exact force Hessian data behind the textbook quadratic linearized Hamiltonian. No positive-definite Hessian or Hartman–Grobman conjugacy is assumed or claimed.

### LinearizedHamiltonian — displayed quadratic energy

Defines the exact linearized Hamiltonian quadratic form using the actual inverse-mass kinetic energy and `D(gradient U)(q*)`, proves the displayed text expansion by rfl, and proves nonnegativity under explicit positive-mass and Hessian quadratic-form hypotheses. It does not infer Hessian positivity from a minimum or claim Hartman–Grobman.

### Uniform lattice pair potential (2026-10-04)

Printed33/PDF56: `LatticePairPotential` defines the upper-triangular finite pair sum `∑ i, ∑ j ∈ Ioi i, φ ‖xᵢ-xⱼ‖` for a one-dimensional finite lattice. Translation invariance is proved from the relative-distance expression, and the two-atom case reduces exactly to the single pair term.

### Nearest-neighbor lattice chain (2026-10-04)

Printed33/PDF56: `nearestNeighborPotentialEnergy` sums `φ ‖x_(i+1)-x_i‖` over `Fin N` bonds on `Fin (N+1)` sites. Translation invariance and the exact two-site reduction are proved.

### Lattice-vibration gradient linearization (2026-10-04)

Printed36--37/PDF59--60: `LatticeVibrations` records the equilibrium first-order expansion `∇U(q₀+h)=D(∇U)(q₀)h+R(h)` and proves `R=o(h)` under `C²` regularity and `∇U(q₀)=0`. Hessian symmetry is inherited from `HamiltonianHessian`; positive definiteness, normal-mode eigenvalue classification, and periodic/boundary spectra remain pending.

### Positive Hessian quadratic bridge (2026-10-04)

Printed37/PDF60: under an explicit positive-definite Hessian quadratic-form hypothesis, `LatticeVibrations` derives nonnegativity of the potential quadratic form and feeds it into the already defined linearized Hamiltonian, proving its nonnegativity with strictly positive masses. The theorem keeps positive definiteness as a hypothesis; it does not derive it from a minimum or claim the pure-imaginary spectrum.

### Periodic nearest-neighbor lattice (2026-10-04)

Printed33/PDF56: `periodicNearestNeighborPotentialEnergy` uses a nonempty cyclic index `ZMod N` and sums the bond `i → i+1`, including the wrap-around bond. Global translation invariance is proved. It is an abstract cyclic helper without the physical box length.

### Actual walled and box-periodic energies (2026-10-04)

Printed33/PDF56: after visual recheck, the finite chain records the end-wall energy (1.7) and the box-periodic seam term `φ ‖L+x₁-x_N‖` in (1.8). The earlier `ZMod` definition is retained explicitly as an abstract cyclic helper and is not identified with (1.8). Translation invariance is proved for the box-periodic expression. Force derivatives, boundary dynamics, and periodic spectra remain pending.

### Real normal modes (2026-10-04)

Printed37/PDF60: `NormalModes` defines the real sine/cosine mode expression, proves its derivative from a supplied pair of generalized eigenvectors `A u = -Ω v`, `A v = Ω u`, and identifies it with the actual exponential linear flow. A mechanical pair bridge uses positive masses and an explicit stiffness relation `K q = Ω² M q`. Pure-imaginary spectral classification and completeness of the mode basis remain pending.
