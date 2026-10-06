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

### Constant-coefficient variational equation and matrix-exponential exercises (2026-10-04)

Printed44--47/PDF67--70: `VariationalEquation` records the exact constant-coefficient specialization of (1.10), `W' = A W`, with an exponential-flow solution and uniqueness from the initial perturbation. It also verifies the exercise-2 identities `exp(0)=1`, `exp(A+B)=exp(A)exp(B)` for commuting matrices, `exp(-A)=(exp A)⁻¹`, and the real matrix-eigenmode formula. The time-dependent Jacobian `f'(z(t))`, nonlinear flow derivative with respect to initial data, singular-value growth, Lyapunov-exponent limits, and the remaining exercises remain pending.

### Diagonal matrix exponential exercise (2026-10-04)

Printed46/PDF69 exercise 1(a): for a finite real diagonal matrix `diag d`, `matrixExponentialFlow_diagonal` proves the componentwise solution `exp(t dᵢ) zᵢ` directly from `Matrix.exp_diagonal` and the matrix-vector product. The theorem does not claim the upper-triangular cases 1(b)--1(c) or a general diagonalization theorem.

### Similarity bridge for matrix exponentials (2026-10-04)

Printed46/PDF69 exercise 1(c): `matrixExponential_conjugate` proves `exp(X D X⁻¹) = X exp(D) X⁻¹` for an explicitly `IsUnit` matrix `X`, using the fixed `Matrix.exp_conj` theorem. This is the similarity identity needed after a diagonal computation; it does not assert that an arbitrary matrix has such an `X` or formalize exercise 1(b).

### Upper-triangular matrix exponential exercise (2026-10-04)

Printed46/PDF69 exercise 1(b): `upperTriangularMatrix` is the literal matrix `[[1, α], [0, 1]]`; `upperTriangularFlow` and `matrixExponentialFlow_upperTriangular` prove its exact solution `eᵗ(x₀+α t y₀), eᵗ y₀` by derivative calculation and the existing global linear-ODE uniqueness theorem. The helper records the two-coordinate derivative bridge; no claim about arbitrary Jordan forms is made.

### Two-body center-of-mass coordinates (2026-10-04)

Printed47/PDF70 exercise 3(b): `TwoBodyCoordinates` defines the planar equal-mass center coordinate `q_cm=(q₁+q₂)/2`, relative coordinate `Δ=q₂-q₁`, and their velocity counterparts. It proves both reconstruction identities, both inverse-coordinate round trips, and the equal-mass kinetic decomposition into total-mass center motion and reduced-mass relative motion. The radial potential, reduced equations of motion, polar integration in 3(c), and exercises 4--5 remain separate.

The same module now defines the radial-potential two-body Lagrangian and proves its exact center/relative-coordinate expansion. This is an algebraic form of exercise 3(a/b); no force differentiation or equation-of-motion reduction is included.

### Theorem 2.1: Euler convergence (2026-10-04)

Printed56/PDF78, with the supporting argument on printed66--67/PDF88--89: `Chapter02/EulerConvergence.lean` defines the literal Euler step/iterate and the actual maximum over `n = 0,...,ν`. `theorem_2_1_euler` proves that a C¹ field on a bounded open Euclidean domain, with an exact solution staying in the domain on `[0,τ]`, admits `C > 0` and a positive step-count threshold such that all numerical nodes stay in the domain and the maximum error is at most `C * (τ/ν)`. Endpoint derivatives are within the exact interval; the zero-horizon case is included. The numerical retention, uniform local Lipschitz bound and quadratic defect are derived, not assumed. The proof against a specified exact solution does not need the text's uniqueness premise or global domain boundedness; the latter is retained in the textbook-facing theorem. Responsible semantic signoff remains pending.

### Section 2.2.3: stability, consistency and order of convergence (2026-10-04)

Printed66--67/PDF88--89: `Chapter02/OneStepConvergence.lean` defines the actual iterates of `G_h` and the full finite maximum error. From the explicit in-domain stability and along-trajectory consistency assumptions (2.10)--(2.11), `oneStep_error_recursion` derives the actual nodal recurrence and `oneStep_error_bound` proves the literal bound (2.12), `(K/L) exp(L n h) h^p`. The coefficient `L` is positive as needed by that formula, and `K` is nonnegative. `oneStepMaxError_order_bound` makes the fixed-horizon constant independent of the step count. For `p > 0` and a positive time horizon, `oneStep_converges_of_consistency_stability` proves that the actual maximum tends to zero along the mesh `h=τ/ν`, with the original strict consistency threshold and non-strict stability threshold. Numerical domain retention is the stated simplifying assumption of this section. Example 2.2 is outside this batch; responsible semantic signoff remains pending.

### Section 2.3.3: the symplectic form and matrix pullback (2026-10-04)

Printed76--78/PDF98--100: `Chapter02/SymplecticForm.lean` uses labeled position/momentum coordinates, the exact textbook block matrix `J=[0,I;-I,0]`, actual linear coordinate one-forms and their bundled wedge. It proves that the standard bilinear form is the literal sum of `dq_i∧dp_i`, its alternation, the actual matrix pullback `AᵀJA`, and equivalence between preservation and equation (2.17). The sign and transpose conventions are proved equivalent to pinned mathlib. The determinant-squared and absolute-determinant results are included, using mathlib's stronger `det=1` theorem. Matrix product/inverse closure and the inverse formula supply the algebra needed in §2.3.5. Actual nonlinear Jacobians/chain rules, global invertibility, general flow variation and the measure change-of-variables conclusion remain separate dependencies; no complete nonlinear-flow or nonlinear-map-group claim is made. Responsible semantic signoff remains pending.

### Sections 2.3.3--2.3.5: actual symplectic maps and their group (2026-10-04)

Printed76--79/PDF98--101: `Chapter02/SymplecticMaps.lean` represents the actual Jacobian by the coordinate matrix of `fderiv`, proves the pointwise derivative/form-preservation equivalence and the actual chain rule, and obtains determinant one at each point. For a genuine globally invertible C¹ map whose inverse is C¹, it derives the inverse Jacobian and proves the inverse is symplectic. `textbookSymplecticDiffeomorphismGroup` is an actual subgroup of coordinate permutations, inheriting the group laws under composition. The text's inference of global invertibility from nonzero Jacobian is insufficient; global invertibility and smooth inverse are explicit in this faithful corrected group statement, not silently inferred. General Hamiltonian-flow variation and measurable-set volume preservation remain pending. Responsible semantic signoff remains pending.

### Section 2.3.4: time-dependent Hamiltonian variational equation (2026-10-05)

Printed79/PDF101: `Chapter02/HamiltonianVariational.lean` differentiates actual matrix curves entrywise, proves cancellation of the two product-rule terms for arbitrary time-dependent symmetric S(t), and proves that WᵀJW is constant on the entire closed interval. Initial W(0)=I gives the literal symplectic matrix condition. A genuine C² Hamiltonian supplies its actual coordinate Hessian and its symmetry. The actual-flow-Jacobian bridge proves symplecticity conditional on the actual Jacobian satisfying this variational equation and on F0=id/C¹ spatial maps. Differentiability of a general nonlinear flow with respect to initial data and derivation of that Jacobian variational equation are still pending; this dependency batch does not claim the whole Hamiltonian-flow statement. Responsible semantic signoff remains pending.

### Section 2.3.6: the actual symplectic Euler method (2026-10-05)

Printed80--81/PDF102--103: `Chapter02/SymplecticEuler.lean` defines the actual force as the negative coordinate partial derivatives of a globally C² potential. It derives C¹ force and symmetric actual force Jacobian, computes the genuine kick/drift Jacobians, and proves symplecticity of the actual momentum-first update (2.18)--(2.19). The block-shear proof preserves the already verified standard wedge form. The actual inverse is explicitly constructed from negative-step kick/drift, giving a true global C¹ symplectic equivalence needed in §2.3.7. Physical positive masses instantiate the literal inverse diagonal coefficients; the geometry itself is independent of positivity. Singular open-domain potentials/domain retention and numerical order estimates are not claimed by this batch. Responsible semantic signoff remains pending.

### Section 2.3.7: actual adjoint methods (2026-10-05)

Printed81--82/PDF103--104: `Chapter02/AdjointMethods.lean` defines the adjoint using genuine negative-step inverse equivalences, proves the full family involution, and obtains self-adjointness of an actual continuous Flow. It proves the precise backward-Euler relation, without asserting global invertibility of an arbitrary Euler step. For the actual already invertible symplectic Euler method, it derives the explicit position-first formulas (2.22)--(2.23) and symplecticity of that actual adjoint. Numerical orders and general nonlinear flow-Jacobian variation remain separate. Responsible semantic signoff remains pending.

### Section 2.4.1: actual Hamiltonian splitting local error (2026-10-05)

Printed83/PDF105: `Chapter02/SplittingError.lean` proves the literal difference F1_h(F2_h(u))-F_h(u) is bounded by C h² on the common nonnegative time interval. All positive constants and actual Taylor/Euler defects are derived from C¹ fields and compact continuous solution families. The actual J-gradient Hamiltonian field is defined, C² on the open domain gives C¹ field, and the genuine field-of-sum identity connects the complete splitting bound to H1+H2. A formal right-hand IsBigO conclusion follows for positive time horizon. The real local flows, common domain retention, joint continuity and initial data are explicit; global flow existence and global first-order convergence are not claimed by this local-error batch. Responsible semantic signoff remains pending.

### Sections 2.4.1--2.4.2: actual method composition and symmetry (2026-10-05)

Printed85/PDF107: `Chapter02/CompositionMethods.lean` defines the actual half-step composition and proves C¹ Jacobian symplecticity for arbitrary given symplectic maps, without an extra global-invertibility assumption. For genuinely invertible method families, it proves adjoint reversal and uses the full double-adjoint identity to prove K†=K for K_h=G†_(h/2)∘G_(h/2). The composed and symmetric actual C¹ symplectic equivalences are verified as well. The text's externally referenced even-order claim and general accuracy-order claims remain separate unresolved targets; algebraic symmetry is not counted as an accuracy proof. Responsible semantic signoff remains pending.

### Section 2.4.5: actual conjugate iterates and processing (2026-10-05)

Printed88/PDF110: `Chapter02/ProcessedMethods.lean` proves the actual all-n conjugacy identity using a genuine homeomorphism. Continuity in both directions yields equivalence of convergence of corresponding actual orbits, with the B initial point χ(z0) explicit. The step-dependent pre/iterate/post algorithm is proved equal to iteration of the conjugate method G, and its actual finite-mesh maximum error is exactly the accepted oneStepMaxError of G. This transfers any established accuracy bound for G by equality; accuracy improvement is not inferred from conjugacy alone. The independent symplectic-Euler/Verlet example is outside this batch. Responsible semantic signoff remains pending.

### Sections 3.2--3.3: actual Lie derivatives, Poisson identity and commutator (2026-10-05)

Printed100--102/PDF122--124 and104--105/PDF126--127: `Chapter03/LiePoisson.lean` uses actual Fréchet derivatives and the existing actual textbook J-gradient field. It proves the genuine first/second time-derivative identities, literal coordinate Poisson sum, both-slot linearity, skew/self-zero, C² Jacobi via actual second-derivative symmetry, and Hamiltonian conservation on an entire closed solution interval. The actual Lie additivity and commutator are verified. With L_H F={F,H} and [A,B]=AB-BA, the commutator is L_{H2,H1}; p105 first derives this but the next display reverses the bracket. The corrected result and original discrepancy are explicit, with responsible semantic signoff pending. Formal-series convergence, actual higher modified-Hamiltonian matching and all of Theorem3.1 remain pending; its reviewed original proof/dependencies are in the Theorem3_1 verification folder.

### Section 3.3: genuine noncommuting formal exponential coefficients (2026-10-05)

Printed103--105/PDF125--127: `Chapter03/FormalOperatorSeries.lean` constructs actual PowerSeries over an associative real algebra and derives the Cauchy-product coefficients through degree three. It proves the literal half-commutator leading difference and the full displayed cubic difference. For a genuine zero-constant generator, high powers vanish in lower degree and each finite formal exponential coefficient stabilizes. The actual generator X(A+B)+X²C and its formal exponential are constructed; C=(AB-BA)/2 matches all product coefficients below degree three. No analytic exponential convergence, boundedness of Lie differential operators, actual-flow Taylor remainder or all-order modified Hamiltonian is asserted. Responsible semantic signoff remains pending.

### Section 3.4: uniform finite modified-Hamiltonian bounds (2026-10-05)

Printed114--115/PDF136--137 equation(3.11): `Chapter03/ModifiedHamiltonianBounds.lean` constructs the actual finite truncation, proves C1 regularity, derives a positive compact-set remainder constant uniform over all 0≤h≤1 and its genuine right-hand IsBigO, and derives a single Lipschitz constant from actual C1 derivatives on an open domain containing the compact convex set. No coefficient bound, derivative bound or remainder estimate is supplied. This necessary dependency is fully accepted; actual high-order numerical-flow matching and complete Theorem3.1 remain pending. Responsible semantic signoff remains pending.

### Section 3.4: actual finite energy drift (2026-10-05)

Printed115--116/PDF137--138: `Chapter03/ModifiedEnergyDrift.lean` proves exact finite telescoping for actual oneStepIterate and derives modified-Hamiltonian conservation from the genuine retained ODE solutions. Actual compact C1 uniform constants yield the original energy bound 2C h^r+L times the sum of actual numerical/flow endpoint distances without any local accuracy premise. A separately named conditional corollary derives the long-time uniform energy rate when a genuine uniform endpoint defect A h^(k+1) has been proved. That matching condition is not yet constructed; whole Theorem3.1 and responsible semantic signoff remain pending.

### Section 4.3.4: complete Lemma4.1 and finite constraint projection (2026-10-05)

Printed159--160/PDF181--182: `Chapter04/ConstrainedProjection.lean` proves `lemma_4_1` as an actual standard two-form pullback identity for genuine constrained parameter charts. The constraint gradient is the real derivative on coordinate basis vectors. The actual P=p−μ∇γ derivative is derived, tangent annihilation follows from γ(q)=0 in a neighborhood of the parameter point, and the genuine C2 Hessian supplies symmetry. The numbered lemma retains both printed constraint conditions. Its necessary coordinate version only needs position constraints; the following finite g′ᵀμ correction is defined and its actual differentiability and pullback identity are proved by finite induction. Original tangent restrictions are not replaced by unrestricted ambient symplecticity. Actual implicit solving branches/complete constrained integrator and responsible semantic signoff remain pending.

### Section 4.3.4: actual constrained Euler stage pullbacks (2026-10-05)

Printed159--160/PDF181--182: `Chapter04/ConstrainedIntegrator.lean` constructs the actual kick/finite initial constraint correction, diagonal-mass position update and final finite correction. Actual derivatives, the already derived potential kick/drift symplecticity and the proved finite projection identity yield the complete three-stage restricted two-form proof for actual differentiable multipliers and true initial/final position constraints. Force kick coefficient a explicitly represents both possible textbook force-sign readings; numerical order is not claimed. The final hidden-constraint solve and actual smooth implicit solving branch remain separate constructions; responsible semantic signoff remains pending.

### Section 4.3.4: explicit actual Gram projection and hidden constraint (2026-10-05)

Printed159/PDF181 equations(4.23)--(4.24), with the explicit nonsingular-Gram condition on printed153/PDF175: `Chapter04/CotangentProjection.lean` constructs the actual derivative-row Jacobian, diagonal inverse mass, true Gram G M^-1 G^T, inverse-formula multiplier and projected momentum. Actual Jacobian/vector-derivative agreement and the literal finite gradient sum are proved. Actual Gram det≠0 yields the hidden constraint G M^-1 P=0 and each true Dγ_j(q)(M^-1P)=0; neither multiplier nor constraint is supplied as a conclusion premise. C1 parameter-branch regularity, nonlinear initial solving branch and responsible semantic signoff remain pending.

## 2026-10-05 actual constrained reaction and cotangent invariance

Printed152--153/PDF174--175: `Chapter04/ConstrainedReaction.lean` constructs the actual second-derivative curvature and actual Gram-inverse reaction. The matrix balance is derived, followed by the real hidden-constraint chain rule and constancy on the entire closed solution interval. Initial position and hidden constraints therefore persist at every point, including endpoints. Neither preservation nor derivative-zero conclusions are inputs; all-time existence is separate. Full pinned verification passed; responsible semantic signoff remains pending.

## 2026-10-05 actual Gram multiplier regularity and constructed final stage

Printed159--160/PDF181--182: `Chapter04/CotangentProjectionRegularity.lean` derives actual C1 Jacobian/Gram/inverse/multiplier/projection regularity through the true determinant and adjugate formulas. The constructed projection preserves the actual restricted pullback without a supplied multiplier or its regularity. Actual C1 pre-momentum/position maps give the fully constructed final Gram stage, its genuine hidden constraint and the complete three-stage pullback identity. The initial nonlinear lam branch and its actual position-solving properties remain explicit method data; these are not counted as constructed. Force coefficient a remains explicit. Responsible semantic signoff, initial branch construction and method order remain pending.

## 2026-10-05 actual physical Gram nondegeneracy

Printed153/PDF175 and159/PDF181 necessary model dependency: `Chapter04/ConstrainedGram.lean` derives actual G.vecMul injectivity from linear independence of the real constraint gradients. Positive masses give the actual inverse mass matrix positive definiteness; its true G M^-1 G^T is positive definite with a strictly positive determinant, including the empty-constraint case. Physical hidden projection, actual multiplier C1 and solution-interval cotangent invariance now follow without a separately supplied invertibility condition. Initial nonlinear solving branch and global flow existence remain separate; responsible semantic signoff pending.

## 2026-10-05 genuine joint C2 flow variations and symplecticity

Printed79/PDF101 and154/PDF176: `Chapter02/ActualFlowVariations.lean` defines the genuine initial-parameter derivative. Actual joint C2 mixed derivative symmetry and the real time ODE near the initial parameter derive its variational equation. The actual Hamiltonian vector-field derivative is identified with J times the genuine symmetric Hessian, yielding the true flow Jacobian ODE and the whole closed-interval symplectic condition and Jacobian det=1. No variational equation or preservation premise is supplied. Joint C2 of the specified actual family is explicit model data; constructing general C1 initial-data regularity from H C2, global solution existence and set-volume transport remain separate. The parameter is the fixed initial point; the printed W line's moving-point notation remains a responsible semantic review item.

## 2026-10-05 actual Hamiltonian Lebesgue set volume

Printed72/PDF94 and78/PDF100: `Chapter02/HamiltonianVolume.lean` derives the actual Jacobian and zero divergence. Actual C1 field regularity on a common compact convex ball for two trajectories and real ODE uniqueness derive injectivity. Explicitly jointly C2 Hamiltonian solution families have measurable images and equal Lebesgue image volume by actual det=1 and the genuine change-of-variables theorem. No injectivity/global inverse/volume premise is supplied. General divergence-free Liouville, weaker flow regularity construction/global existence and responsible semantic signoff remain pending.

## 2026-10-05 actual general divergence-free Liouville volume

Printed72/PDF94: `Chapter02/LiouvilleVolume.lean` derives the actual matrix determinant differential from the genuine continuous multilinear determinant, including singular matrices. The true time ODE for an explicitly jointly C2 family gives its actual initial-Jacobian variational equation. Actual C1-field zero divergence and the initial identity then imply det=1, genuine ODE injectivity and measurable-image Lebesgue volume equality. No Jacobian ODE/determinant/injectivity/volume conclusion is supplied. Construction of weaker C1 initial flow regularity, local-domain generality/all-time existence and responsible semantic signoff remain pending.

## 2026-10-05 actual constrained-flow restricted symplecticity

Printed153--155/PDF175--177: `Chapter04/ConstrainedReactionRegularity.lean` derives real C1 curvature/constructed Gram reaction/reduced phase vector field from actual C3 constraints and C2 potential. `Chapter04/ConstrainedFlowSymplectic.lean` derives retained constraints from the actual ODE and initial two constraints, then genuine variations from joint C2 and the real ODE. Actual potential/finite-reaction cancellations and diagonal-mass cancellation prove the pulled-back standard form constant on the entire closed interval. Physical positive-mass/independent-gradient instances use no inverse premise. This is equality on actual initial parameter charts, not all ambient directions. Constructing weaker flow regularity/global existence/manifold charts and numerical nonlinear branch/order remains separate; responsible semantic signoff pending.

## 2026-10-05 Wiener quadratic variation

Printed229--230/PDF250--251: `Chapter06/WienerQuadraticVariation.lean` fully proves Proposition6.2 for the genuine finite-dimensional law model `IsPreBrownianReal`. It constructs the uniform grid/increments/squared sum, derives Gaussian second/fourth moments and square L2 from actual laws/mgf, derives increment/square independence, computes expectation T and exact variance/mean-square error 2T²/K for positive K, and proves the actual K-to-infinity mean-square limit. T=0 is included. Original cross-term sign and final K-to-zero typographical errors are documented. Continuous sample paths are not used. Responsible semantic signoff and remaining stochastic integration targets pending.

## 2026-10-05 actual Wiener integration

Printed229--231/PDF250--252: `Chapter06/WienerIntegration.lean` derives actual deterministic finite Wiener sums' centered Gaussian laws and the real L2 difference isometry from genuine joint Gaussian increments and actual independence. The printed230 proved self-Itô integral is fully constructed: true finite telescoping and W(0)=0 a.e. give the real left-sum identity, actual L2 integrability, exact mean-square error T²/(2K), the real limit and an L2 random-variable witness with value (W(T)²-T)/2. Proposition6.3 remains partial: constructing the general smooth deterministic integral, Gaussian-law closure and continuous variance integral remain pending; finite dependencies are not counted as the full proposition. Actual stochastic-midpoint Stratonovich convergence remains separate.

## 2026-10-05 invariant distribution swap

Printed299--300/PDF320--321: `Chapter07/InvariantDistributionSwap.lean` fully proves Lemma7.1 for real Markov kernels and genuinely unique invariant probability measures. Actual kernel action/associativity derive transferred invariance, real Markov normalization keeps the distribution probabilistic, and textbook uniqueness gives both swapped identities. The true finite-iterate identity from the original proof is also derived. No swapped equality or formal symbolic action is supplied. The explicitly assumed uniqueness suffices without using the extra ergodicity hypothesis; concrete numerical kernel construction/ergodicity/density representation and responsible semantic signoff remain separate.


### Actual thermostat linear Lie fields (2026-10-05)

Printed347/PDF368: `Chapter08/ThermostatLieFields.lean` fully proves Lemma8.1 for actual linear F/G/C/D and all matrix powers. True fderiv computations bridge the opposite End commutator sign; real negative closure witnesses actual VectorField bracket closure. Real matrix identities and LieSpan induction derive both field families, with no desired membership supplied. Internal k0 is textbook k1; positive distinct spectrum and Proposition8.3 independence, Hörmander lift and the full Theorem8.1 remain separate.


### Actual positive spectral thermostat span (2026-10-05)

Printed347--348/PDF368--369: `Chapter08/ThermostatSpan.lean` fully proves Proposition8.3 from the actual SPD spectral theorem, original distinct-eigenvalue data and the actual nonzero eigenmode domain. Real eigen-coordinates are tied to eigenvector dot products; D is open. Both actual coefficient families vanish by positive modal weights and actual Vandermonde injectivity, yielding true finite-family linear independence, dimension-based spanning and real generated Lie algebra value spanning. The printed348 q/p swap is recorded and recomputed from printed347 definitions. Hörmander lift, Theorem8.1 and the proved unnumbered invariant-mode claim remain separate.


### Actual Hörmander thermostat chain (2026-10-05)

Printed254/PDF275 and344--348/PDF365--369: `Chapter08/HormanderClosure.lean` formalizes Definition6.1 by actual recursive fderiv brackets and point spans, deriving smooth finite-coefficient module bracket closure and evaluation into the original span. `Chapter08/ThermostatHormander.lean` fully proves Proposition8.2 with explicit nonzero noise, actual drift/noise derivatives, physical lifts and full horizontal/vertical span. True End LieSpan maps into actual negative-G physical brackets. With accepted Lemma8.1/Proposition8.3, actual NHL quadratic feedback, drift equations, open domain, smooth fields and original positive-parameter sqrt noise give the full Theorem8.1. No extended span or coefficient closure is supplied. Responsible signoff and separate ergodicity/accessibility/invariant-mode body claims remain pending.


### Actual NHL zero-mode path invariance (2026-10-05)

Printed346/PDF367: `Chapter08/ThermostatModeInvariant.lean` proves the explicit unnumbered zero-eigenmode claim. Actual spectral linear coordinate chain rules derive the true time-dependent two-mode ODE from actual q/p equations and continuous auxiliary paths. Compact operator-norm bounds derive uniform Lipschitz continuity; real ODE uniqueness against the zero solution yields invariance throughout a closed interval, supporting right derivatives at the initial endpoint. Actual Vi and D as complement of their union are mapped. No whole-time zero or uniqueness conclusion is supplied. SDE solution construction and independent atlas/codimension structure are separate.


### Actual temporal midpoint self-Stratonovich integral (2026-10-05)

Printed230/PDF251: `Chapter06/WienerStratonovich.lean` fully proves the explicitly derived unnumbered self-integral formula using true temporal midpoint evaluations. Actual coarse/fine time identities and finite telescoping give an alternating sum of squared half-interval increments. Genuine Gaussian fourth moments and actual independence yield mean zero and variance T²/K for that correction, exact midpoint mean-square error T²/(4K), real L2 integrability and the actual limit witness W(T)²/2. This supplies the missing global error justification in the printed per-step O(sqrt dt) replacement. General deterministic Itô Proposition6.3 and owner signoff remain separate.


### Actual deterministic Wiener integral construction (2026-10-05)

Printed231/PDF252: `Chapter06/WienerRefinement.lean` proves genuine common KL refinements, actual two-grid L2 isometry, true mesh and compact-time Lipschitz error bounds, Cauchy convergence in the actual complete L2 space and existence of a real mean-square integral of the genuine deterministic left sums. Compact C1 derivative bounds derive the Lipschitz condition. This completes the necessary integral construction for Proposition6.3; its variance integral and limiting Gaussian law remain separate and pending.


### Full actual Gaussian deterministic Itô integral (2026-10-05)

Printed231/PDF252: `Chapter06/WienerDeterministicLaw.lean` completes Proposition6.3 with accepted actual integral construction. Genuine interval-cell integration and compact-time Lipschitz bounds prove convergence of the actual finite variances to the true integral of g². Actual mean-square convergence implies L2, probability and distribution convergence; finite Gaussian characteristic functions converge with their computed variances, and actual characteristic-function uniqueness identifies the limit law. The final theorem constructs Y and proves its actual mean-square limit, Gaussian law, zero mean and second moment equal to the time integral. C1 suffices for the textbook smooth integrand; T=0 is included. No Gaussian law or moment conclusion is supplied. Owner signoff remains pending.

### Actual thermostat Liouville product density (2026-10-05)

Printed338--339/PDF359--360: Chapter08/ThermostatDensity.lean supplies the genuine Liouville proof of Proposition8.1. Divergence is trace of the actual Frechet derivative; genuine density/product/conjugacy rules, idle coordinate lifts and flux add-sub yield the true combined field with one Hamiltonian drift. Actual J/Hessian trace and Poisson self-cancellation derive Gibbs base stationarity, including a specified fixed normalizer. Nonnegativity of the product density is proved. This batch establishes the literal stationary PDE; connecting it to actual flow transport and invariant probability measures remains the next necessary dependency, rather than an assumed implication. Owner signoff pending.

### Actual stationary-density solution-family transport (2026-10-05)

Printed338--339/PDF359--360: Chapter08/StationaryDensityFlow.lean completes the actual flow/measure bridge required by Proposition8.1. True time and Jacobian ODEs derive rho(Phi) det(DPhi)=rho(initial), transported through a real finite basis to arbitrary finite-dimensional state spaces. Nonnegative densities give the absolute determinant identity; real Haar change of variables yields equality on measurable images. Actual probability normalization makes the range conull, deriving pushforward invariance without a surjectivity or invariance premise. Genuine withDensity product equalities derive the combined probability measure from normalized original factors. The final thermostat result applies the accepted actual Liouville additivity to a specified joint C2 real solution family. This verifies the actual PDE plus invariant probability interpretation on that family; constructing weaker regularity or all-time solutions remains separate. Owner semantic signoff pending.

### Actual noncommuting symmetric formal BCH (2026-10-05)

Printed297/PDF318: Chapter07/SymmetricOperatorBCH.lean constructs the actual noncommuting five-factor composition and genuine coefficientwise stable logarithm. Cauchy products derive coefficients through degree four, the literal nested-commutator L2 and the actual shifted generator. Its exact X4 remainder factor and full log=X*G identity are proved; actual exp(XG) matches the original composition through degree four. No logarithm/exponential coefficient identities or commutator correction are supplied. Full infinite exp/log inversion, full parity and analytic unbounded-operator BCH interpretation remain separate necessary dependencies, with owner signoff pending.

### Full actual noncommuting formal functional calculus (2026-10-05)

Printed297/PDF318: Chapter07/FormalOperatorFunctionalCalculus.lean completes the full formal interpretation of Proposition7.1, extending the accepted literal L2 and X4 remainder. A genuine locally finite scalar-series evaluation is an algebra homomorphism into noncommuting operator series, proved through actual polynomial truncation and aeval. Actual scalar substitution compatibility transports the fixed scalar exp/log inverse identities to full noncommuting exp/log inverses. Genuine time-negation, actual opposite-generator exponentials and palindrome cancellation derive full logarithm oddness and vanishing of every odd generator correction. The original five factors equal exp(XG) at every coefficient. No commutativity of X/Y/Z, inverse conclusion or symmetry conclusion is assumed. Analytic unbounded-operator BCH interpretation and owner signoff remain separate.

### Actual Langevin Hörmander computation (2026-10-05)

Printed255/PDF276: Chapter06/LangevinHormander.lean fully proves the explicitly derived unnumbered Hörmander computation for actual Langevin negative-potential-gradient drift and actual constant coordinate noises. Real Frechet derivatives give the literal (-sigma e_i,sigma gamma e_i) bracket. Genuine finite-coordinate sums prove linear independence of the original 2Nc family and full actual iterated-bracket point span. Smoothness of the actual gradient and every seed follows from smooth U; the physical sqrt noise is nonzero from positive friction and temperature. This completes the algebraic Hörmander calculation, without claiming its analytic hypoellipticity consequence or Lemma6.1 positive-probability accessibility.

### Actual Langevin smooth endpoint control (2026-10-05)

Printed255--256/PDF276--277: Chapter06/LangevinControlPath.lean supplies the actual smooth deterministic-control construction in Lemma6.1. A genuine cubic Hermite position curve has the actual polynomial velocity and acceleration, with all four prescribed phase endpoint conditions proved. The real potential force determines the control rate, whose genuine Bochner time integral has value zero initially and is C infinity. Its actual derivative solves the controlled Langevin equation, yielding true smooth control existence for arbitrary endpoints at positive time. No path existence or endpoint-control conclusion is supplied. The remaining positive Wiener tube probability and actual solution-continuity/localization steps are separate necessary dependencies of the full lemma.

### Actual Langevin integral-noise stability (2026-10-05)

Printed255--256/PDF276--277: Chapter06/LangevinNoiseStability.lean proves actual continuous integral-solution equations imply genuine differentiable noise-compensated paths. True FTC right derivatives and actual constructed control equations feed a real Gronwall bound; undoing compensation gives the original phase error. Continuity of that bound at zero noise constructs a positive tube threshold reaching the prescribed endpoint ball. The explicit global-Lipschitz force condition is an auxiliary model, pending genuine smooth cutoff/first-exit localization. Wiener tube positive probability remains separate. The printed all-open-set claim needs Nonempty C, since empty-set probability is zero. Owner signoff pending.

### Actual smooth-potential noise localization (2026-10-05)

Printed255--256/PDF276--277: Chapter06/LangevinSmoothCutoff.lean removes the global-force Lipschitz qualification from actual solution-noise dependence. An actual smooth compact bump cuts off the original potential; neighborhood equality proves actual force equality on the inner ball. Genuine gradient compact support and smoothness derive global Lipschitz continuity. A true earliest hitting time from compactness and IVT bounds the original phase before exit, where its actual integral equations transfer to the cut potential. The true time-uniform Gronwall bound contradicts exit. Consequently every globally smooth original potential has a genuine positive control-tube endpoint threshold, without supplied trajectory confinement or global force bounds. Wiener tube positive probability remains separate.

### Actual Brownian bridge and short path support (2026-10-05)

Printed255--256/PDF276--277: Chapter06/WienerBridgeSupport.lean supplies a necessary part of the original Wiener-tube argument. Genuine Brownian linear combinations yield joint Gaussian bridge/endpoint laws; actual covariance cancellation proves independence of the entire bridge and endpoint. Actual positive-variance Gaussian reverse absolute continuity proves every endpoint ball positive. Real AE sample continuity at zero constructs a positive small-path subset, giving actual countable bridge-tube positivity at every sufficiently short time. True dense-sample/continuity extension and the independent-event product yield the null-measurable entire linear-path tube with positive probability, for every endpoint at those short times. No tube-support conclusion is a premise. Arbitrary prescribed time via independent segments, vector Wiener noise and the full smooth-control tube remain necessary next dependencies.

### Actual countable Brownian laws and independent segment support (2026-10-05)

Printed255--256/PDF276--277: Chapter06/WienerPathLaw.lean proves genuine countable Brownian sample-law equality through finite projective laws, including repeated times, and true projective-measure uniqueness. Real dense-sample/path-continuity equivalence transports entire linear-tube probabilities across spaces and all shifted processes. Actual finite linear transforms and covariance cancellation prove independence of the entire nonoverlapping segment processes. Countable joint bridge/endpoint events have equal laws, giving a common shift threshold independent of endpoint tolerance. True measurable segment-event intersections have actual marginal-product probability; computed positive marginals yield every finite joint event positive. No support, path-law equality or whole-process independence is assumed. Arbitrary prescribed-time continuous-control assembly and vector Wiener support remain necessary next dependencies.


## 2026-10-05 引理6.1实际任意时长控制支持与终点可达

- 印刷255--256/PDF276--277：Chapter06/WienerPathSupport.lean实际uniform cells、endpoint telescoping/bounds、ContinuousOn-control entire tube AE/null可测及任意指定T正概率。Chapter06/WienerVectorSupport.lean标准vector Wiener定义与真实scalar coordinate law/whole independence/finite tube product、NNReal与real time转换及全vector管支持。
- Chapter06/LangevinAccessibility.lean：textbookLangevinEndpoint_ball_pos、_open_pos及_physicalNoise_open_pos接已接受C∞控制、真实smooth局部化和本批实际Wiener支持。真实单位质量全Rn/指定区间AE积分解和end可测下的球与Nonempty-open positive及null可测完整。
- 本批25项public/full-check01-LangevinAccessibility，源码/原始日志SHA及公理覆盖逐项核验；负责人pending。原[257,Lemma3.4]用于噪声稳定性，[349]用于Wiener正概率，两条必要外部依赖已本地证明。原all-open缺Nonempty、全局随机解构造、periodic实际lift/Thm6.2全遍历仍单独记录，不计CORE_SCOPE完成。


## 2026-10-05 引理6.1真实周期积分解及构造lift

- Chapter06/LangevinPeriodicProjection.lean：真实UnitAddTorus位置商、连续满射、Nonempty-open拉回与given-real-solution projection事件。Chapter06/LangevinPeriodicForce.lean：真实格点periodic U定义，actual fderiv/force/force derivative周期性、compact基本cube全局bound及global forceLip。
- Chapter06/LangevinPeriodicLift.lean：真实代表/force与任意lift一致、actual周期积分方程、q_real=初始代表+∫p真实构造和Rn积分方程/projection identity、真正periodic Nonempty-open endpoint null可测/positive及physical noise。给定真实periodic解，不输入lift存在。
- 24public/full-check01-LangevinPeriodicLift固定版本、SHA、零警告及公理接受。原Nonempty修正负责人签核、全局随机过程构造/联合AEmeas/nonexplosion/全遍历单列；不计CORE_SCOPE完成。

## 2026-10-05 连续噪声实际指定区间解存在

LangevinDrivenExistence.lean 与既有真实field Lipschitz导出：统一Picard长度/有限拼接接点真实导数、projIcc连续噪声延拓、FTC还原实际q/p积分方程、真实周期势能derived Lip给periodic积分解存在。full9043/957/126，4public零警告；AE随机模型/适应性及最终语义签核pending。

## 2026-10-05 实际Cpath解映射与周期可测随机模型

LangevinPathSolution/WienerVectorContinuousPath/LangevinRandomSolution：实际chosen q/p与Gronwall导出endpoint Lipschitz/连续及同噪声唯一性；真实标准Wiener Cpath AEm与AE原noise一致，actual随机积分解/逐timephase AEm；C∞周期势能真实构造模型并得Nonempty-open/physicalNoise概率可达。full9046/977/129，20public零警告。全时域一致/适应性及最终语义签核pending。

## 2026-10-05 实际同一全时域Langevin随机模型

LangevinGlobalRandomSolution.lean：actual restriction/EqOn积分转移与same-noise唯一→integer模型重叠一致；ceil(t)+1定义同一phase，在同一AE sample集上每个real T满足真原积分方程，逐time AEm和Ici全路径连续；true periodic projection和physicalNoise all-time Nonempty-open可达。full9047/985/130，8public零警告；适应性/生成元/遍历性及负责人pending。

## 2026-10-05 实际Hamiltonian-power Lyapunov及周期properness

印刷253--254/PDF274--275：LangevinLyapunov.lean真实drift/二阶导数/正确2l(l−1)+Nc*l Laplacian界、compact cube potential bound与低阶幂吸收→Lφ≤−γlφ+δ。LangevinPeriodicLyapunov.lean实际torus代表独立/连续/正性/动量coercivity/真正紧sublevel与cocompact逃逸atTop；physical thermal γβ⁻¹保留。30public/full9049/1015/132，源码与raw-log SHA和基础三公理完整核对。原打印中间界52>40真实counter，修正负责人pending；Markov实际generator识别/Harris与全CORE_SCOPE仍pending。

## 2026-10-05 实际因果历史与周期restart

LangevinCausalFlow/PeriodicCausalFlow：actual Cpath history restriction与真实integral time shift/increment segment，解唯一→common AE全部real-time history/restart；实际periodic real lift唯一、endpoint任意代表独立、明确同一global periodic过程/原AE全T模型/逐time AEm。22public/full9051/1037/134。尚待future increments law/历史独立、joint初值可测/条件Markov、generator/transition密度及Harris正文定理；不按pathwise cocycle称Markov已完整。

## 2026-10-05 Theorem6.2 actual future Wiener law dependency（机器验收通过，语义pending）
WienerVectorFuture/LangevinFutureLaw：实际future B(S+t)-B(S) Gaussian/isotropic covariance/连续、endpoint Gaussian pi、任意可数samples law、真正Cpath Borel law、整段future与整个Wiener和实际global Langevin/periodic历史独立、共同AE所有S/T真实segment/future restart、实际noise-history乘积law。17public完整验收9053/1054/136、零Lean警告与exact输入/日志SHA核验通过；负责人pending。joint初值/filtration/条件Markov/generator/density/Harris和CORE_SCOPE仍pending。

## 2026-10-05 Theorem6.2 actual joint initial/path measurability（机器验收通过，语义pending）
LangevinInitialState：从真正积分解推导同noise不同initial指数Gronwall、chosen endpoint初值uniform Lip和initial×Cpath joint连续可测；actual periodic initial/path联合连续经open quotient×id下降、无需代表可测性；random real/periodic initial endpoint AEm完整局部。9public完整验收9054/1063/137零警告及exact输入/日志SHA核验通过；conditional Markov/filtration/density/generator/Harris及负责人与CORE_SCOPEpending。

## 2026-10-05 Theorem6.2 真实转移核与确定时间条件Markov（机器验收通过，语义pending）
LangevinTransitionKernel：真实Wiener Cpath law与joint endpoint deterministic kernel组合构造actual real/periodic probability transition kernel，逐状态等于actual endpoint pushforward并识别同一global process law，Wiener实现无关。whole history×future真实乘积law及commonAE restart经端点联合可测映射导出joint compProd disintegration，再由condDistrib唯一性证明实际全部past history条件律只依赖当前actual state；原C∞ lattice periodic势能推导forceLip主结论，无kernel/Markov结论假设。full-check01 2026-10-05T20:15:02.4380876+08:00--2026-10-05T20:17:24.7030669+08:00退出0；9055 jobs/零Lean警告/1080audit基础三公理/138inputs及全部raw SHA复核一致；17public逐名覆盖。确定S/T的AE结论不声称跨所有S/T的共同异常集或stopping-time strongMarkov；completed filtration/semigroup/density/actual generator/Harris与负责人语义pending。

## 2026-10-05 Theorem6.2 actual Chapman–Kolmogorov（机器验收通过，语义pending）
LangevinTransitionSemigroup：真正积分方程导出real/periodic endpoint零时刻初值；actual K0=id。actual whole-history transition joint law取snd，通过comap与lintegral_map'识别future marginal=K_T∘law(XS)，再actual global law得到K_(S+T)=K_T∘K_S。原C∞ lattice periodic U推导forceLip的完整probability kernel semigroup，无semigroup结论前提。full-check01 2026-10-05T20:29:20.8171566+08:00--2026-10-05T20:32:18.7715566+08:00退出0；9056 jobs/零Lean警告/1089audit基础三公理/139inputs及全部raw SHA复核一致；9public逐名覆盖。completed filtration/适应性/density/actual generator/Harris及负责人/CORE_SCOPE仍pending。

## 2026-10-05 Theorem6.2 actual completed Wiener filtration/适应性（机器验收通过，语义pending）
LangevinFiltration：在原P的completion ambient上构造截至S的actual vector Wiener eval σ代数加全部原P-null sets；derived filtration单调/ambient le、past eval可测、local trim complete及与原P的整个AE filter一致。实际Cpath在local history可测经各evaluation/commonAE一致及complete trim的congr_ae、真实ContinuousMap Borel evaluation API推导；actual同一real/periodic global process Adapted，原C∞lattice U主结论derived forceLip。full-check01 2026-10-05T21:05:07.7047296+08:00--2026-10-05T21:11:39.3824305+08:00退出0；9057 jobs/零Lean警告/1100audit基础三公理/140inputs及全部raw SHA复核一致；11public逐名覆盖。无right-continuity或strongMarkov声明；completed-filter条件Markov/密度/actual generator/Harris及全CORE_SCOPE/负责人pending。

## 2026-10-05 Theorem6.2 actual future独立于completed Wiener过去（机器验收通过，语义pending）
LangevinCompletedHistory：F_S≤eventuallyMeasurableSpace(actual Cpath history comap)(ae P)，每完成化历史事件AE等于actual Cpath历史事件；实际future Cpath与全部completed F_S在P.completion下真正Indep。真实Cpath law completion=原P law；actual real/periodic current state来自Adapted，future/current独立及joint product law噪声边缘等于原Wiener Cpath law。full-check01退出0；9058 jobs/零Lean警告/1108audit基础三公理/141inputs及全部raw SHA复核一致；8public逐名覆盖。completed-filtration condDistrib恒等式/progressive/density/actual generator/Harris与全CORE_SCOPE/负责人仍pending；不声称strongMarkov/right-continuity。
## 2026-10-05 Theorem6.2 actual completed-filtration 条件 Markov（机器验收通过，语义pending）
LangevinCompletedMarkov：同一样本type tag实际F_S/history id可测、观测law恰为completion.trim F_S。实际future与整个completed过去的product law，经同一global process共同AE restart及joint endpoint可测映射得到真实history/future-state compProd disintegration；condDistrib唯一性给actual real/periodic过程完成化过滤条件律KT(XS)。原C∞lattice U主结论derived forceLip。full-check01 2026-10-05T21:50:18.6212785+08:00--2026-10-05T21:53:07.0779702+08:00退出0；9059 jobs/零Lean警告/1118audit基础三公理/142inputs及全部raw SHA复核一致；10public逐名覆盖。每固定S/T AE不声称uncountable同异常集/right-continuity/strongMarkov；progressive/density/actual generator/Harris与CORE_SCOPE/负责人pending。
## 2026-10-05 Theorem6.2 actual all-sample continuity/progressive（机器验收通过，语义pending）
LangevinProgressive：同一B的Cpath在所有sample逐horizon restriction一致，含原exceptional samples；已接受真实解唯一性给同一global endpoint=time-t history endpoint=fixed A endpoint（t≤A）。真实fixed horizon integral solution的q/p连续给全部sample全NNReal path连续，periodic真实投影同样连续。与前批actual Adapted结合推出same real/periodic过程在actual completed Wiener过滤IsProgressive，C∞lattice势能主结论derived forceLip。full-check01 2026-10-05T22:06:50.5907102+08:00--2026-10-05T22:09:00.1030594+08:00退出0；9060 jobs/零Lean警告/1127audit基础三公理/143inputs及全部raw SHA复核一致；9public逐名覆盖。未更换过程，未把AE continuous当∀sample；density/actual generator/Harris/CORE_SCOPE和负责人pending。
## 2026-10-05 Proposition6.1 actual weighted divergence/IBP density cutoff（机器验收通过，原命题pending）
CanonicalTemperature：实际SymplecticCoordinates Nc为2Nc相空间；复用actual Gibbs weight/LieDerivative/divergence。真实partition及canonical average/归一化正性；weighted flux div=ρ(divG−β LieG H)和从两原weighted observable integrability推导divFlux L1；actual紧支C1 field方向导数积分0、真正trace坐标散度与div积分0。真实smoothTransition密度cutoff0..1/C1/1/R导数、support Gibbs lower bound、每point最终exact1、由原bounded weighted field借C exp(2R)ρ支配得cutoff L1，及真实cutoff divergence error term。full-check01 2026-10-05T22:40:54.1848185+08:00--2026-10-05T22:43:09.0075861+08:00退出0；9061 jobs/零Lean警告/1145audit基础三公理/144inputs及全部raw SHA复核一致；18public逐名覆盖。原print222/PDF243重新目视；完整全域IBP/L1空间cutoff/密度cutoff极限与Prop6.1温度比值仍未完成，不把紧支情形当原定理；原第三条uniform bounded解释和负责人签核pending。
## 2026-10-05 Proposition6.1 actual full-space Gibbs IBP/温度比值（完整验收中）
CanonicalIntegrationByParts：actual fixed finiteDim ContDiffBump空间缩放η_R C1/紧支/0..1/每point最终exact1和derived derivative C/R；actual compact div0经真实DCT得到F/divF均L1时全域div积分0，仅要求divsum L1不偷增每partial L1。真实smoothTransition derivative locally constant outside[0,1]→compact/global bound；原bounded weighted G条件下density-cutoff flux/div均L1，再第二次DCT得原ρG totaldiv积分0，未增加ρG L1。真实Av divG=β Av LieG H、Avdiv正与β>0给实际温度比值，proposition_6_1接β=(kBT)^-1；原坐标G·∇H桥接和原分子正性也真正推导。19public local09退出0空日志/零Lean警告；full-check01待验证。原print222/PDF243修正证明路线；第三条明确uniform weighted bound、真实canonical Z正有限及weighted观测Lebesgue可积、Nc有限和kB/T正；负责人原第三条含义与修正证明签核pending。Theorem6.2 generator/density/Harris和CORE_SCOPE未完成。

CanonicalIntegrationByParts统一验收：full-check01 passed：9062 jobs、1164 audited declarations、145 exact inputs；10 checks退出0，全部输入/原始日志SHA256复核匹配，新增19项逐名公理审计仅propext/Classical.choice/Quot.sound，Lean警告0。固定Lean4.34.0/mathlib5ed2965。负责人第三条统一有界解释、替代证明与教材语义仍pending。

## 2026-10-05 Theorem6.1真实周期Brownian Dirichlet依赖
MolecularDynamics/Chapter06/BrownianDirichlet.lean，29public；完整unit周期cube divergence由actual相对face整数平移抵消；一般diagonal质量的literal Brownian generator，真实weighted Gibbs Dirichlet与normalized form，正质量/β下formal symmetry及quadratic nonpositive，derived nonzero L2 norm positive→real eigenvalue非正，常数zero mode与Gibbs weak stationarity。local07退出0零诊断，统一验收进行中。C∞tests；正式Hilbert self-adjoint closure/compact resolvent/discrete spectrum/gap/实际expectation exponential convergence仍未证，最终负责人语义pending。

BrownianDirichlet统一验收：full-check01 passed：9063 jobs/1193公理声明/146exact输入；10checks退出0，全部input/rawlog SHA256复核匹配，29public逐名审计仅propext/Classical.choice/Quot.sound，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人语义pending。

## 2026-10-06 Brownian真实torus Gibbs概率对接
MolecularDynamics/Chapter06/BrownianTorusGibbs.lean，25public local05零诊断。真实full cube→normalized Haar measure-preserving map，实际可测representative及lattice descent，same partition positive finite，withDensity actual Gibbs probability/normalized weighted integral。原同一Brownian全质量Dirichlet/对称与nonpositive/weak stationarity已在actual Gibbs measure证明；formal closed selfadjoint/spectrum/gap/expectation未完成；统一验收进行中，负责人语义pending。

BrownianTorusGibbs统一验收：full-check01 passed：9064 jobs/1218公理声明/147exact输入；10checks退出0，全部input/rawlog SHA256匹配，25public逐名审计仅propext/Classical.choice/Quot.sound，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人语义pending。

## 2026-10-06 Brownian真实weighted Hilbert L2依赖
MolecularDynamics/Chapter06/BrownianHilbertCore.lean，19public local05零诊断；same quotient continuity→actual MemLp2/toLp+AE→sameµ Hilbert inner/norm/generator image Dirichlet与nonpositive，actualL² real eigenvalue非正、constant zero/norm-one nonzero，positive density→fullsupport→injectivity。actual dense domain/closed selfadjoint/spectrum/gap/期望未完成；负责人语义pending，统一验收进行中。

BrownianHilbertCore统一验收：full-check01 passed：9065 jobs/1237公理声明/148exact输入；10checks退出0，全部input/rawlog SHA256匹配，19public逐名审计仅propext/Classical.choice/Quot.sound，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人语义pending。

## 2026-10-06 Brownian实际光滑周期Hilbert定义域
BrownianSmoothDomain.lean：真实coordinate partial与literal generator线性，全smooth periodic Submodule及generator endomorphism；同一Gibbs L² LinearMap/injective/range/unique lift→实际domain operator，其原generator一致、Dirichlet、domain全pair对称/nonpositive/常数zero norm-one均证明。local04零诊断，统一验收进行中。density/closed selfadjoint/discrete spectrum/gap/actual semigroup未完成，负责人pending。

BrownianSmoothDomain统一验收：full-check01 passed：9066 jobs/1259公理声明/149exact输入；10checks退出0，全部input/rawlog SHA256匹配，22public逐名仅基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。

## 2026-10-06 Brownian实际smooth periodic Gibbs L² domain稠密性
BrownianSmoothDensity.lean：actual Fourier Euclidean lift C∞、complex fullspan dense与real-part onto→real smooth torus连续函数dense；integer quotient translation及original representative给full smooth periodic lift/descent；sameµ continuous-to-L² actualCLM/denseRange与AE bridge推出原actual domain dense/closure=top。local03零诊断，统一验收进行中。不是finite Fourier模型；closed selfadjoint/spectrum/gap/semigroup仍未完成；负责人pending。

BrownianSmoothDensity统一验收：full-check01 passed：9067jobs/1275公理声明/150exact inputs；10checks退出0，全部input/rawlog SHA256匹配，16public逐名只基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。

## 2026-10-06 Brownian actual dense partial operator/可闭图闭包
BrownianClosedOperator.lean：actualsameµ LinearPMap/dense/formal→T≤actualclosedadjoint→IsClosable；真实图closure/closed/dense/core、原domain/literalgenerator/constant值保持与最小closedextension；两次actualgraph closed-inner-condition证明闭包全domain formal symmetry，closed inner≤0推全closure非正。local02零诊断，统一验收中。selfadjoint/compactresolvent/谱/gap/semigroup未完成；负责人pending。

BrownianClosedOperator统一验收：full-check01 passed：9068jobs/1297公理声明/151exact inputs；10checks退出0，全部input/rawlog SHA256匹配，22public逐名只基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。

## 2026-10-06 Brownian actual Gibbs density双边界与weighted norm比较
BrownianGibbsBounds.lean：actualtorus potential CM/supnorm M→A=absβ*M→literalweight/truepartition exp±A bounds→actualdensity exp±2A uniformpositive/finite；真实withDensity integral identity/continuous integral lowerupper/square integrals与sameµ actualHilbert norm²双边Haar比较全部证明。23public local03零诊断，统一验收中。未假设bounds；HaarPoincare/selfadjoint/gap/谱/semigroup及CORE_SCOPE未完成，负责人pending。

BrownianGibbsBounds统一验收：full-check01 passed：9069jobs/1320公理声明/152exact inputs；10checks退出0，全部input/rawlog SHA256匹配，23public逐名只基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。

## 2026-10-06 Brownian实际Gibbs mean/variance
BrownianVariance20public local02零diagnostic；actualmean/center/variance2moment/最小mean-square/varzeroiffpointconstant与sameµ Hilbertnorm/mean0orthogonality，deriveddensity Haarvariance comparison和shift/center invariance完整。fullcheck中，HaarPoincare/selfadjoint/gap未完成，负责人pending。

BrownianVariance统一验收：full-check01 passed：9070jobs/1340公理声明/153exact inputs；10checks0exit/allinput-rawlogSHA匹配/20public逐名基础三公理/0Leanwarnings；固定Lean4.34.0/mathlib5ed2965；负责人semanticpending。

## 2026-10-06 Fourier 字符真实微分依赖
BrownianFourierDifferential：26公开声明local04退出0/空日志/零警告。actualmFourier lift=exp(i actualphase)、realimag=literalcos/sin，真实C∞/periodic及一二阶partials；原literal生成元的Haar辅助m=1/U=0/β=1计算给实际特征值-4π²Σn_i²，非零整数frequency≥4π²由整数平方和证明。DEP036/NOT045；full-check进行中，原一般mass/potential主模型未改，HaarPoincare/gap/selfadjoint尚未完成。

full-check01 passed：9071 jobs/1366公理声明/154exact inputs；10checks退出0、全部input/rawlog SHA匹配、26public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，HaarPoincare与Theorem6.1整体未完成。

## 2026-10-06 实际Fourier coefficient与Parseval能量
BrownianFourierCoefficient19public local05零诊断：actualU0 Gibbs=Haar、真实formal symmetry→literalLaplace Fourier coefficient=-frequency*fcoeff、实际L² AE和Parseval norm/bilinear→HasSum frequency*coeffnorm²=真实坐标梯度energy，zero coeff=actualmean。DEP037/NOT046，fullcheck中；HaarPoincare/gap/selfadjoint尚未完成，负责人pending。

full-check01 passed：9072 jobs/1385公理声明/155exact inputs；10checks退出0、全部input/rawlog SHA匹配、19 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 真实Haar Poincare
BrownianHaarPoincare9public local03零诊断：完整Haarmean0 HasSum comparison/真实constant centering与gradient不变给VarHaar≤(4π²)inv trueHaarGradientEnergy，actualtorus CM与原Gibbsvariance到Haarenergy连接。DEP038/NOT047，fullcheck中；原一般mass Gibbsweighted Poincare/gap/selfadjoint仍未完成。

full-check01 passed：9073 jobs/1394公理声明/156exact inputs；10checks退出0、全部input/rawlog SHA匹配、9 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原Gibbs weighted Poincare和实际core强制性
BrownianGibbsPoincare18public local02零诊断：actualderived massM与densitylower真实积分比较给原sameµ一般positive mass Varµ≤exp4A M/(4π²) weightedenergy，actualDirichlet/energyconstantshift和βpositive rateκ>0给actualmean0 core coercivity。DEP039/NOT048，fullcheck中；closed coercivity/selfadjoint/full谱gap未完成，负责人pending。

full-check01 passed：9074 jobs/1412公理声明/157exact inputs；10checks退出0、全部input/rawlog SHA匹配、18 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 真实closed域强制性、常数零核和实特征值界
BrownianClosedCoercivity15public local12零诊断：sameµ fullsmooth embedding actualCM与Hilbertvariance桥接、derivedrate core→真实closedgraph domain moduloone/orthogonalcoercivity、normconstantprojection给closedkernel onlyconstant，formal symmetry推出实际nonzero real eigen≤-κ。DEP040/NOT049，fullcheck中；selfadjoint/compactresolvent/full谱existence和semigroup仍缺。

full-check01 passed：9075 jobs/1427公理声明/158exact inputs；10checks退出0、全部input/rawlog SHA匹配、15 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原质量 Fourier 对角公式
BrownianMassFourier26public local04零诊断：原mass/β Haar必要auxiliary实际cos/sin generator与Fouriercoeff=-Ωfcoef、实际mass energy/graphsquare Parseval、derived Ω≥cΣni²和onlyzero，以及真正finite sublevel/cofinite frequencydivergence/(1+Ω)inv decay。DEP041/NOT050，fullcheck中；实际Hilbert自伴/compactresolvent/full谱仍未完成。

full-check01 passed：9076 jobs/1453公理声明/159exact inputs；10checks退出0、全部input/rawlog SHA匹配、26 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原 Gibbs ground-state 共轭
BrownianGroundState29public local06零诊断：actualpartialproduct/secondproduct/weightsecond、exp s/h互逆，literal originalm/U/β生成元sL(hf)=massLaplacef+Vf及真实V C∞periodic/CMnormbound；同一partition normalizedfactor²=originalsameµdensity、actualHaar square integral=Gibbs square integral。DEP042/NOT051，fullcheck中；尚未构造actualfullLpunitary/selfadjoint/compactresolvent。

full-check01 passed：9077 jobs/1482公理声明/160exact inputs；10checks退出0、全部input/rawlog SHA匹配、29 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 实际全 Gibbs-Haar Hilbert 等距同构
BrownianGroundStateIsometry15public exactbyte draft局部零诊断：actualnormalizedfactor reciprocal和CM multiplication LinearEquiv，actualdense embeddings与derived normeq扩张至整个sameµ GibbsLp≃ₗᵢHaarLp，实际onto/inverse/norm/inner及全CMformula。DEP043/NOT052，fullcheck中；actualsmoothdomain/operatorgraph共轭和diagonal selfadjoint仍未完成。

full-check01 passed：9078 jobs/1497公理声明/161exact inputs；10checks退出0、全部input/rawlog SHA匹配、15 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 实际全smooth域和Hilbert core共轭
BrownianGroundStateCore15public local04零诊断：actualnormalizedinverse互逆及entirefullsmoothEquiv，actualHaar linearembedding和fullLpI maps entire smoothrange onto；actualnormalizedliteralgenerator公式、直接massLaplace+V smoothLinearMap与originalSmoothGenerator真正共轭，再actualHilbertcore和GibbsL2image共轭。DEP044/NOT053，fullcheck中；wholeclosedgraph/diagonal selfadjoint/compact仍未完成。

full-check01 passed：9079 jobs/1512公理声明/162exact inputs；10checks退出0、全部input/rawlog SHA匹配、15 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 实际整个 Gibbs–Haar 闭图共轭
BrownianGroundStateGraph23public local05零诊断：actualfullsmoothHaar embedding单射/唯一lift及真实partialoperator；原partial graph实际I×I.map双向等于Haar graph、稠密/形式伴随/可闭；真正Haarclosure闭/稠密/光滑core及原整个Gibbsclosedgraph unitarymap=Haarclosedgraph，全Haar闭域形式对称和非正。DEP045/NOT054，统一fullcheck中；自伴/compactresolvent/full谱/semigroup未完成。

full-check01 passed：9080 jobs/1535公理声明/163exact inputs；10checks退出0、全部input/rawlog SHA匹配、23 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 实际全实值Haar Fourier重构及原质量光滑图逼近
BrownianFourierHilbert28public local06零诊断：actualJ/R全Lp AE/左逆/norm/injective、真正FourierBasis全L²重构；原smooth Re(c e_n)及literalmassfreq/有限polynomial generator；actualinner-coefficient桥接及全coeff单射；真实coef关系给实际smoothgraph同时逼近。DEP046/NOT055 full中；actualadjoint全部coef关系及自伴尚缺。

full-check02 passed：9081 jobs/1563公理声明/164exact inputs；10checks退出0、全部input/rawlog SHA匹配、28 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 真正原质量Laplace闭包自伴
BrownianMassSelfAdjoint12public local02零诊断：真实V0zero/actualtransformedmassoperator equality/完整smoothpartialgraph；整个真实closedgraph iff Fouriercoef加权关系，伴随全域由实际测试推导coef，再actualpolynomial graph逼近证明真正H†=H及P†=H。本质自伴无diagonal/selfadjoint/椭圆正则性前提，原m和β保持。DEP047/NOT056 full中；原一般U boundedV扰动、自伴compact/full谱未完成。

full-check01 passed：9082 jobs/1575公理声明/165exact inputs；10checks退出0、全部input/rawlog SHA匹配、12 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原有界势的实际整个Hilbert乘法及闭图变换
BrownianPotentialOperator13public local05零诊断：actualV∞/Holder全HaarLp boundedCLM与derivednormbound/AE/symmetric；truecontinuous/fullsmooth对应与原TH=MassG+SmoothV实际Hilbertimage；actualgraph E(x,y)=(x,y+Bx) continuousLinearEquiv/actualinverse/closure保持。DEP048/NOT057 full中；原一般U图识别与自伴尚缺。

full-check01 passed：9083 jobs/1588公理声明/166exact inputs；10checks退出0、全部input/rawlog SHA匹配、13 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原一般U同一Gibbs闭包真正自伴
BrownianPotentialSelfAdjoint6public local03零诊断：actualmass/sameU Haar partial与wholeclosedgraph均actualboundedB shear双向相等，全Haarclosed域=massclosed域；实际伴随定义subtract B和mass已证自伴推得originalgeneralU Haarclosed真正自伴，再actualsameµ I/wholeclosedgraph/injectivity传回originalGibbsclosed真正IsSelfAdjoint。DEP049/NOT058 full中；原C²/core语义签核pending、compact/full谱/semigroup仍未完成。

full-check01 passed：9084 jobs/1594公理声明/167exact inputs；10checks退出0、全部input/rawlog SHA匹配、6 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 实际全Haar Fourier紧算子
BrownianFourierCompact20public local08空日志：actualinverseweights/真实lpCLM/每个finiteCLM坐标及compact/wholeopnormlimitderivedfrom原frequencies，实际HilbertBasis onto传到全complexHaar并证明coeff/norm/compact；actualJ/R构成整个realHaar compactCLM。DEP050/NOT059 full中。尚未实际识别massClosed双向resolvent，原一般U compact/full谱仍未完成。

full-check01 passed：9085 jobs/1614公理声明/168exact inputs；10checks退出0、全部input/rawlog SHA匹配、20 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原质量闭包真实紧双向预解算子
BrownianMassResolvent5public local03空日志：truecomplex Fourier series的realpart smoothpoly同时graphlimit证明全x (Rx,Rx−x)∈实际MassClosed.graph；再真closedgraphcoef推导actualJRxcoef，再证明全部closedgraph R(x−y)=x/真实range=整个closeddomain，真实compactCLM由此identified为原质量双向resolvent。DEP051/NOT060 full中；generalU compact/full谱/semigroup仍缺。

full-check01 passed：9086 jobs/1619公理声明/169exact inputs；10checks退出0、全部input/rawlog SHA匹配、5 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原sameGibbs wholeclosedgraph紧嵌入
BrownianGraphCompact9public local05空日志：actualmasswholegraph firstprojection=R.comp(fst−snd)；原generalU actualgraphiff与boundedB给Haarwholegraphprojection=R.comp(fst−snd+Bfst)紧；sameµ I×I真实整closedgraph传输和actualIinverse.comp(R.compT)给整个originalGibbs graphprojection紧。actualproductnorm inherited，未换成closed域L²norm。DEP052/NOT061 full中；actualgeneralU boundedinverse存在仍缺，不计generalU compactresolvent。

full-check01 passed：9087 jobs/1628公理声明/170exact inputs；10checks退出0、全部input/rawlog SHA匹配、9 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## 2026-10-06 原一般U sameGibbs真正compactresolvent
BrownianGibbsResolvent12public local05空日志：actualwholeclosedgraph shiftS=x−y，原nonpos→normcoercivity→Antilipschitz/closedrange；真实adjoint domain test和原sameµ selfadj/nonpos给rangeorthogbot，再actualrangeclosed/orthogonalprojection得真正onto。actualBanach inverse与真compactgraphprojection构造全sameGibbs boundedcompactR，真实全部x rightinversegraph/全closedgraphleftinverse/norm≤1，明确actualoriginalGibbscompacttwo-sidedresolvent。DEP053/NOT062 full中；完整谱/本征基/evolution与C²core签核仍缺。

full-check01 passed：9088 jobs/1640公理声明/171exact inputs；10checks退出0、全部input/rawlog SHA匹配、12 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem6.1 — original Gibbs whole Hilbert eigenbasis (BrownianResolventSpectrum)
25public原actualA closedgraph定义eigenspace与truecompactR双向eigencorrespondence；全eigenspace有限dim/相互正交/closuretop；Sigma有限基组合成实际整个sameGibbs HilbertBasis，每基向量trueAdomain/graph，非正及非零≤−κ，所有x HasSum与Parseval。MolecularDynamics/Chapter06/BrownianResolventSpectrum.lean；docs/reviews/2026-10-06-BrownianResolventSpectrum/REVIEW.zh-CN.md。统一验收中；谱枚举/整谱/evolution与core最终语义pending。

full-check01 passed：9089 jobs/1665公理声明/172exact inputs；10checks退出0、全部input/rawlog SHA匹配、25 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem6.1 — original Gibbs entire closed graph and domain coefficients (BrownianEigenGraph)
5public actualA graph iff真实wholebasis λweightedcoeff；actualwholeAdomain iff weightedMemℓp；actualAapply与trueR coefficient完整。MolecularDynamics/Chapter06/BrownianEigenGraph.lean；docs/reviews/2026-10-06-BrownianEigenGraph/REVIEW.zh-CN.md。下一真正spectralheat contractive evolution与stronggeneration、概率transition识别/整谱/core最终语义仍缺。

full-check01 passed：9090 jobs/1670公理声明/173exact inputs；10checks退出0、全部input/rawlog SHA匹配、5 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem6.1 — actual original Gibbs strongly continuous contractive spectral evolution (BrownianSpectralEvolution)
17public实际原wholebasis exp eigenweights/actualℓ² CLM与trueunitary传回sameGibbs entireLp；T0identity、timeadd semigroup、norm≤1、所有x真正HasSum；actualwholeAgraph保持；summableTannery norm² DCT与sqrt证明全space alltime强连续。MolecularDynamics/Chapter06/BrownianSpectralEvolution.lean；docs/reviews/2026-10-06-BrownianSpectralEvolution/REVIEW.zh-CN.md。stronginfgen identification/Markovpositivity/actualSDE expectation及整谱/core语义仍缺。

full-check01 passed：9091 jobs/1687公理声明/174exact inputs；10checks退出0、全部input/rawlog SHA匹配、17 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem6.1 — exact entire actual Gibbs semigroup infinitesimal generator (BrownianSpectralGenerator)
7public actualpositive differenceweights/exponentialscalar derivative bound与pointlimit，wholeactualAgraph ⇒ genuineHilbertstrong rightderivative via实际y coefficients squaredsumDCT/unitary；reverse viainnerCLM与unique limits/wholegraphiff；原Agraph iffactualT strongrightderivative全空间完整。MolecularDynamics/Chapter06/BrownianSpectralGenerator.lean；docs/reviews/2026-10-06-BrownianSpectralGenerator/REVIEW.zh-CN.md。下一constantmode exponentialdecay/真实expectation识别；谱枚举/整谱/core最终语义pending。

full-check01 passed：9092 jobs/1694公理声明/175exact inputs；10checks退出0、全部input/rawlog SHA匹配、7 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem6.1 — actual entire Gibbs equilibrium mode exponential decay (BrownianSpectralDecay)
6public trueT symmetric/constantone fixed/actualGibbsmean preserved；wholezeroeigspaces来自truekernelconstant，fullnonzero eigenbasis gap→lp norm_mono得全orthogonalLp真实指数normbound→wholecenteredx/correlation指数bound。MolecularDynamics/Chapter06/BrownianSpectralDecay.lean；docs/reviews/2026-10-06-BrownianSpectralDecay/REVIEW.zh-CN.md。实际SDElaw/probabilityexpectation识别、整谱与枚举及core最终语义pending。

full-check01 passed：9093 jobs/1700公理声明/176exact inputs；10checks退出0、全部input/rawlog SHA匹配、6 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem6.1 — true original compact Gibbs resolvent whole real spectrum (BrownianResolventRealSpectrum)
5public realFredholm nonzeroR spectrum iffgenuineeigen、whole spectrum nonnegative≤1、r≠1≤(1+actualκ)inv<1；actualconstant e证明1真实属于wholeRreal spectrum，fullstrictseparation。MolecularDynamics/Chapter06/BrownianResolventRealSpectrum.lean；docs/reviews/2026-10-06-BrownianResolventRealSpectrum/REVIEW.zh-CN.md。原unboundedA whole-real-spectrum correspondence/finitecofinite-countable枚举与SDE probability识别/core最终语义仍缺。

full-check01 passed：9094 jobs/1705公理声明/177exact inputs；10checks退出0、全部input/rawlog SHA匹配、5 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual original unbounded Gibbs generator whole real spectrum (BrownianGeneratorRealSpectrum)
11 public：真正有界两侧图预解集与 id+(ℓ−1)R unit 双向等价；通过正确非零因子 (1−ℓ) 精确转到 Mathlib R 实谱；原整个 A 实谱 iff 真特征空间非零，非正性、所有非零谱值≤−κ及零实际存在；全部真实有界移位图逆紧。MolecularDynamics/Chapter06/BrownianGeneratorRealSpectrum.lean；docs/reviews/2026-10-06-BrownianGeneratorRealSpectrum/REVIEW.zh-CN.md。有限/余有限离散与可数有序枚举、复谱及概率识别/core 最终语义未完成。

full-check01 passed：9095 jobs/1716公理声明/178exact inputs；10checks退出0、全部input/rawlog SHA匹配、11 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual whole original generator closed discrete real spectrum (BrownianEigenDiscreteness)
10 public：真实紧 R 图像有限覆盖及正交系数证明有限 ε 权重层；权重 cofinite→0；真实 A 模式任意下界层有限（计重数）与 eigenvalue cofinite→−∞；无假设推索引可数；整实谱=真正 basis eigenvalue range、谱有限下界层/可数/闭/每点孤立。MolecularDynamics/Chapter06/BrownianEigenDiscreteness.lean；docs/reviews/2026-10-06-BrownianEigenDiscreteness/REVIEW.zh-CN.md。Nc=0 有限情形保留，正维无限性/有序 ℕ 谱枚举、复谱及概率识别/core 最终语义未完成。

full-check01 passed：9096 jobs/1726公理声明/179exact inputs；10checks退出0、全部input/rawlog SHA匹配、10 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — positive-dimensional genuine infinite Gibbs eigenbasis and complete natural sequence (BrownianEigenEnumeration)
11 public：真实实 Haar L² 无限维由实际实虚部满射与 Fourier 独立证明，再 actual whole Gibbs unitary 推原 Gibbs 无限维、实际 eigenIndex Infinite。与既有 Countable 合成真正 ℕ≃actualIndex，保留所有模式和重数；complete ℕ HilbertBasis、逐向量真图、所有 x HasSum、λ_n→−∞、整个实谱=sequence range 及实际全谱无限。MolecularDynamics/Chapter06/BrownianEigenEnumeration.lean；docs/reviews/2026-10-06-BrownianEigenEnumeration/REVIEW.zh-CN.md。严格 Nc>0；未排序，未声称首项常数。有序谱列/复谱/概率识别/core最终语义继续。

full-check01 passed：9097 jobs/1737公理声明/180exact inputs；10checks退出0、全部input/rawlog SHA匹配、11 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual complete ordered eigenvalues, simple zero mode and ordered evolution (BrownianEigenOrdering)
17 public；实际Lex降序特征值/升序重数索引由真实有限Iic、bot、无限性noMax构造ℕ有序同构，覆盖全部actualIndex。λ0=0、反单调、n≠0时λn≤−κ、λn→−∞、整个原实谱=range；实际K0=span常数且finrank1。完整整个Gibbs有序HilbertBasis、每个φn真实Agraph、所有x HasSum及同一真实T的有序HasSum/tsum指数展开。MolecularDynamics/Chapter06/BrownianEigenOrdering.lean；docs/reviews/2026-10-06-BrownianEigenOrdering/REVIEW.zh-CN.md。Nc>0用于无限ℕ序列；K0简单含Nc0。首向量相位/复谱/实际SDE概率识别/core最终语义pending。

full-check01 passed：9098 jobs/1754公理声明/181exact inputs；10checks退出0、全部input/rawlog SHA匹配、17 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1(3) — actual integral averages and original canonical exponential estimate (BrownianSpectralAverage)
12public；原e真实AE1→所有整个Gibbs Lp代表可积、两代表乘积可积、实际inner=product integral、e pairing=实际integral。原T保真integral mass且integral duality；全ρ/g真实积分指数收敛至g integral*ρ真实mass。真实初始mass1时K=norm(ρ-e)+1>0及α=实际κ>0；所有原smooth periodic f/非负t左侧真实torus积分收敛至原Z^-1 cube weighted average，右侧原Gibbs test norm。MolecularDynamics/Chapter06/BrownianSpectralAverage.lean；docs/reviews/2026-10-06-BrownianSpectralAverage/REVIEW.zh-CN.md。解析平均完整；实际T positivity/SDElaw expectation(5.6)识别/复谱/coresemanticpending，未冒称Theorem6.1(3)概率部分完成。

full-check01 passed：9099 jobs/1766公理声明/182exact inputs；10checks退出0、全部input/rawlog SHA匹配、12 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual whole same-Gibbs complexification and complete complex basis of original real eigenmodes (BrownianGibbsComplexification)
16public；同一actual原Gibbs measure全Lpℝ/ℂ的真实ofReal/re/im CLM及AE、双向整个空间分解、真norm/inner保存/injective；由原real Hilbert HasSum映射和实际complex closed-span证明完整同索引complex HilbertBasis，保留全部实际模式及重数并给所有complex z HasSum。MolecularDynamics/Chapter06/BrownianGibbsComplexification.lean；docs/reviews/2026-10-06-BrownianGibbsComplexification/REVIEW.zh-CN.md。复杂基为原real模式实际复化；complex original A graph/entire complex spectrum下一未完成，不冒称定义未构造的operator已具备此基。SDE概率识别/core语义/整范围pending。

full-check01 passed：9100 jobs/1782公理声明/183exact inputs；10checks退出0、全部input/rawlog SHA匹配、16 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual whole complex Gibbs original generator graph and full self-adjointness (BrownianGibbsComplexOperator)
17public；真complex coordinates=re/im原real coordinates；complex-linear graph实际等价于原real A的真实re/im两图。由true vertical uniqueness构造actual LinearPMap并证graph相等，完整坐标graph iff/整个weightedℓ²domain/逐mode真本征图/closed/dense/fullformalAdjoint以及全adjoint domain equality的IsSelfAdjoint均证明。MolecularDynamics/Chapter06/BrownianGibbsComplexOperator.lean；docs/reviews/2026-10-06-BrownianGibbsComplexOperator/REVIEW.zh-CN.md。整个复原A已真实复化；complex compact resolvent/整复谱与SDElaw概率识别/core负责人语义pending。

full-check01 passed：9101 jobs/1799公理声明/184exact inputs；10checks退出0、全部input/rawlog SHA匹配、17 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — genuine bounded compact two-sided resolvent of actual complex Gibbs generator (BrownianGibbsComplexResolvent)
10public；C=J actualR Re+iJ actualR Im由真全部坐标推complex-linearity，真实ℝopnorm界给samefunction complexCLM。真正原Rcompact经pre/postcompose/scalar/add推出actualcomplex R紧；所有wholecomplex input真A_C图preimage及任何truegraph(z,w)给R_C(z−w)=z，实际complex A_C compact two-sided inverse at1完整。MolecularDynamics/Chapter06/BrownianGibbsComplexResolvent.lean；docs/reviews/2026-10-06-BrownianGibbsComplexResolvent/REVIEW.zh-CN.md。下一真正entirecomplex spectrum transform/Fredholm；SDE概率识别/core语义/整范围pending。

full-check01 passed：9102 jobs/1809公理声明/185exact inputs；10checks退出0、全部input/rawlog SHA匹配、10 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — entire complex spectrum of actual original Gibbs closed generator (BrownianGibbsComplexSpectrum)
21public；真实双边闭图resolventSet⇔unit(id+(z−1)R_C)，非零1−z真实谱变换与紧Fredholm完整识别；整个complex谱恰原真实real模式集合且=ofReal整个real谱。真Im0/nonpos/非零gap/0spec/countable/finitelevels/closed/isolated，以及任何actualboundedgraphinverse真compact。MolecularDynamics/Chapter06/BrownianGibbsComplexSpectrum.lean；docs/reviews/2026-10-06-BrownianGibbsComplexSpectrum/REVIEW.zh-CN.md。原有序基首常数相位待正文规范化；SDE概率识别/core最终语义及整范围pending。

full-check02 passed：9103 jobs/1830公理声明/186exact inputs；10checks退出0、全部input/rawlog SHA匹配、21 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — literal constant-one first vector of complete ordered original eigenbases (BrownianEigenNormalization)
17public；真实kernel projection与unitnorm推出原首mode phase r*r=1，整个orderedreal basis common sign normalization真实complete/首φ0=e与AE1/所有actualA graph/HasSum/原T normalizedordered HasSum及tsum。实际J嵌入给整个原complex normalizedordered HilbertBasis真实complete/φ0=J e与AEcomplex1/全部actualA_C graph/全输入HasSum及wholecomplex谱orderedλrange。正维是实际ℕ无限完整枚举必要条件，保留全部真实重数。MolecularDynamics/Chapter06/BrownianEigenNormalization.lean；docs/reviews/2026-10-06-BrownianEigenNormalization/REVIEW.zh-CN.md。SDE概率识别/core最终语义及全范围pending。

full-check01 passed：9104 jobs/1847公理声明/187exact inputs；10checks退出0、全部input/rawlog SHA匹配、17 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual complex zero eigenspace and smooth-model spectral parts (BrownianComplexKernel)
6public；actual A_C.ker真等于complex span J originalone，true finrank1以及FiniteDimensional（Nc0允许），actualzero graph iff actualconstant。smooth_spectral_parts完整汇总原wholecomplex A真实IsSelfAdjoint/单重零/κpositive及原ordered completecomplex basis/λ0=0/antitone/趋−∞/非零gap/literalφ0one/所有trueeigen graphs/entirecomplexSpec exactorderedrange/allHasSum，完整ℕ需positiveNc。MolecularDynamics/Chapter06/BrownianComplexKernel.lean；docs/reviews/2026-10-06-BrownianComplexKernel/REVIEW.zh-CN.md。不计实际SDE概率识别或教材C²core签核完成；整范围pending。

full-check01 passed：9105 jobs/1853公理声明/188exact inputs；10checks退出0、全部input/rawlog SHA匹配、6 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual original-mass overdamped Brownian drift and diagonal noise coefficients (BrownianSDECoefficients)
13public；原gamma1/generalmasses mobilityCLM、actualdrift/literalpartial、真derivedglobalLipschitz与periodic、actualsqrtcov amp square/strictpositive/literal inverse sqrtmass factor、noiseCLM全coordinate及纯differentialexpression原BrownianGenerator恒等。240/PDF261式6.36与249/PDF2706.46已视觉核对，原Mass未换M=I。MolecularDynamics/Chapter06/BrownianSDECoefficients.lean；docs/reviews/2026-10-06-BrownianSDECoefficients/REVIEW.zh-CN.md。不是actualSDE stochasticgenerator/law识别；下一真实指定区间additive-noise integral solution，SDE/core/wholepending。

full-check01 passed：9106 jobs/1866公理声明/189exact inputs；10checks退出0、全部input/rawlog SHA匹配、13 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — genuine original-mass Brownian additive-noise integral solution on every specified finite interval (BrownianDrivenExistence)
5public；actualcompensatedfield原b(z+Σ(Wt−W0)) deriveduniformLip/timecontinuous/true everyfiniteinterval ODE α与其真正所有点导数、原q ContinuousOn/q0=x/allt原Bochner integral equation及originalpositive cov/square。无需Brownian noise differentiable，不加solution exists前提，保留wholeoriginal masses gamma1。MolecularDynamics/Chapter06/BrownianDrivenExistence.lean；docs/reviews/2026-10-06-BrownianDrivenExistence/REVIEW.zh-CN.md。下一trueuniqueness/horizon一致与pathmap连续measurable；SDEactual概率识别/core/wholepending。

full-check01 passed：9107 jobs/1871公理声明/190exact inputs；10checks退出0、全部input/rawlog SHA匹配、5 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。

## Theorem 6.1 — actual Brownian integral path uniqueness, initial/noise stability and joint measurable endpoints (BrownianPathSolution)
27public合并批次，原mass b/Σ、literal实际积分模型从真存在到右导数/initial/restrict、deriveddriftL、actualincrement误差/commonfield Gronwall与原q扰动、wholeintervalunique/horizonagreement、实际CPath选解与selectedunique、初值及joint初值+uniformpath Lipschitz/continuous/measurable。MolecularDynamics/Chapter06/BrownianPathSolution.lean；docs/reviews/2026-10-06-BrownianPathSolution/REVIEW.zh-CN.md。只复用已验收genericnoisecarrier，不用Langevin物理解替Brownian。下一真实randommodel；SDElaw=T/Markov/5.6/core/wholepending。

full-check01 passed：9108 jobs/1898公理声明/191exact inputs；10checks退出0、全部input/rawlog SHA匹配、27 public逐名仅propext Classical.choice Quot.sound、0Leanwarnings；固定Lean4.34.0/mathlib5ed2965。负责人semanticpending，Theorem6.1整体未完成。
