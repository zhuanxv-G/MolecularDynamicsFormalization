# Assumptions to make explicit

These are modeling questions to check against each textbook statement, not global assumptions silently imposed by the project.

- **Finite dimensions:** specify the number of degrees of freedom, and when needed the number of particles and spatial dimension. A zero-dimensional space is mathematically allowed unless a result requires positivity.
- **Mass:** decide whether the model uses positive scalar particle masses, a diagonal mass matrix, or an arbitrary symmetric positive-definite matrix. Positivity/invertibility must be explicit before using an inverse.
- **Position domain:** record whether positions range over the full Euclidean space or an open subset excluding collisions or singularities.
- **Potential and force:** specify differentiability of `U` and whether `F = -∇U`; a force field need not be conservative in general.
- **Regularity:** state the differentiability or smoothness needed for gradients, Hessians, ODE uniqueness, flow maps, and energy arguments.
- **Time dependence:** the initial model is autonomous. Time-dependent forces or potentials require extra arguments.
- **Solutions:** distinguish local solutions on an interval from globally defined flows; global existence needs its own hypotheses.
- **Lagrangian variables:** `L` takes position and velocity, while `H` takes position and momentum. Relating them uses a mass-dependent Legendre transform.
- **Inner product convention:** finite-dimensional coordinate spaces use the standard real Euclidean inner product. A physical mass-weighted metric, if needed, must be introduced separately.

## Chapter 1, Section 1.2 representation choices

- The Lean parameter `n` denotes the textbook's `N_c`, the total number of configuration coordinates.
- `CoordinateMasses n` is `Fin n → ℝ`. `ParticleCoordinates.lean` now maps `Fin N × Fin d` to `Fin (N*d)` in particle-first order, repeating each particle's mass across its `d` directions. The common `d=1` and `d=3` cases match §1.2; arbitrary `d` is an explicit algebraic generalization.
- Equations (1.3) and (1.4) do not require mass positivity or invertibility merely to be stated, so neither is assumed. Later results that divide by masses must state the appropriate hypotheses.
- `NBodyEquationAt` is pointwise in a supplied position and acceleration. T2 now proves its connection with the actual second derivative of an existing mechanical solution on an open time domain.
- The force-potential relation uses the explicit textbook sign: `force position = -gradient potential position`.
- Mathlib's `gradient` is total and therefore can occur without a differentiability hypothesis. Any later use of gradient differentiation rules must add and expose the required regularity assumptions.
- `nBodyKineticEnergy_particle_eq` proves that the scalar-coordinate kinetic energy equals `∑_j m_j ‖q̇_j‖² / 2` when masses and velocities are expanded from particles. The equality allows arbitrary real masses; the norm is each particle's Euclidean norm, not the outer function-space norm.
- The `noncomputable` marker on the real-valued energy definitions is an implementation property of exact real arithmetic, not a mathematical assumption.

## T1 positivity and inverse assumptions

- All finite indexing identities allow `N=0` and `d=0` as algebraic cases. They do not assert that an empty system is a physical model.
- Recovering particle-mass positivity from coordinate-mass positivity explicitly requires `0<d`. If `d=0` and `N>0`, the coordinate premise is vacuous.
- The positive-definiteness criterion is an equivalence with strictly positive coordinate masses. Inverse identities and the reciprocal-diagonal formula explicitly assume these positive masses. Nonzero masses also suffice for invertibility, but those more general statements are outside this batch.
- No trajectory, differentiability of potential, ODE existence, conserved energy, or stability result follows from the T1 algebraic bridges. The printed19/PDF42 dynamical assertions remain later tasks.
- Local textbook checks compared printed18–19/PDF41–42 with the precise statements and final implementation. MathCopilot's independent T1 read-only review has been received and accepted; responsible final semantic sign-off is still pending.

## T2-L0 operator assumptions

- `massOperator` and `velocityOperator` are continuous linear wrappers of the fixed diagonal mass matrix and mathlib's total inverse matrix. Both coordinate identities hold for arbitrary real masses, including singular matrices.
- The two theorems interpreting these operators as mutual inverses explicitly assume strictly positive coordinate masses. The matrix inverse's total value at a singular matrix is not interpreted as physical velocity recovery.
- The initial L0 checkpoint supplies the algebraic operators; the subsequent T2 trajectory batch uses them as described below. The L0/B3 statement revisions remain subject to responsible semantic sign-off.

## T2 trajectory and derivative assumptions

- `IsMechanicalSolutionOn` requires position membership in Q and `HasDerivWithinAt` on the given time set I. The ambient curve is defined on ℝ, but the solution assertion only applies on I. Neither openness of Q nor force continuity is silently included.
- S1, B1, B2 and B3 explicitly require `IsOpen I` before using ordinary `deriv` and two-sided second derivatives. No closed-interval endpoint result is asserted. B2 uses equality throughout a neighborhood inside I rather than differentiating equality at one point.
- S1 and B2 allow arbitrary masses because they only use the defined linear operators. B1, B3, B4 and the free-particle example require strictly positive masses when interpreting the total matrix inverse as recovery of physical velocity or momentum.
- B3 separates the supplied force model `∀ q ∈ Q, F q = -gradient U q` from a genuine gradient. Its algebraic bridge does not differentiate U; the textbook application explicitly assumes `DifferentiableAt ℝ U q` on Q and proves `HasGradientAt U (-F q) q` along the curve.
- B4 assumes actual derivatives of q and v and the mass-acceleration equation. It does not obtain a curve from isolated pointwise data. Two-sided derivatives are already supplied, so I need not be open for this direction.
- `IsLocalMechanicalIVP` includes ε>0 and γ(t₀)=z₀. The proved `initial_mem` consequence uses the nonempty interval to obtain z₀.1∈Q. General existence/uniqueness is not a field of either solution predicate.
- `freeParticle_localIVP` constructs an explicit solution for zero force on the full space. It does not establish existence for a general F, a maximal time interval, a global flow, conserved energy or stability.
- The local ContinuousSMul instances are obtained from existing normed-space results; they add no mathematical hypothesis or logical dependency.

## T5 strict minimum, sphere and trajectory assumptions

- The strict minimum matches the textbook's punctured open-ball inequality. Its relative version requires the center to belong to Q; it does not assume a positive definite Hessian, strong convexity or a quadratic lower bound.
- Uniform positive separation on a compact set requires continuity on that set. The statement allows an empty compact set and does not claim that a minimizing point exists in every case.
- The sphere result requires `0<r<R`, inclusion of the full ambient sphere in Q and continuity of U on that sphere. The open-domain result constructs a smaller ball in Q; δ is chosen after r and generally depends on it. No common positive gap for all small radii is asserted.
- `Position 0` is a singleton, so a positive-radius sphere is empty. The definitions and gap statements still hold vacuously; this is not a nontrivial physical equilibrium. The explicit zero-dimensional examples retain that distinction.
- The conditional trajectory theorem takes position continuity, nonnegative kinetic energy and constant total energy as inputs on the supplied closed interval. Its initial position may be any point inside the ball. It proves confinement on that interval via the intermediate value theorem; it does not prove conservation, solution existence, uniqueness, momentum control or global continuation.
- The potential and kinetic terms are general real-valued functions in the conditional lemmas. Relating them to the actual mechanical Hamiltonian and proving conservation are separate T3/T4 results.
- Theorem1.1 remains pending: position confinement alone is not the full phase-space stability conclusion or its strict supremum bound for all future time.
