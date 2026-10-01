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
- `NBodyEquationAt` is pointwise in a supplied position and acceleration. A time-dependent trajectory and the identification of that acceleration with its second derivative have not yet been introduced.
- The force-potential relation uses the explicit textbook sign: `force position = -gradient potential position`.
- Mathlib's `gradient` is total and therefore can occur without a differentiability hypothesis. Any later use of gradient differentiation rules must add and expose the required regularity assumptions.
- `nBodyKineticEnergy_particle_eq` proves that the scalar-coordinate kinetic energy equals `∑_j m_j ‖q̇_j‖² / 2` when masses and velocities are expanded from particles. The equality allows arbitrary real masses; the norm is each particle's Euclidean norm, not the outer function-space norm.
- The `noncomputable` marker on the real-valued energy definitions is an implementation property of exact real arithmetic, not a mathematical assumption.

## T1 positivity and inverse assumptions

- All finite indexing identities allow `N=0` and `d=0` as algebraic cases. They do not assert that an empty system is a physical model.
- Recovering particle-mass positivity from coordinate-mass positivity explicitly requires `0<d`. If `d=0` and `N>0`, the coordinate premise is vacuous.
- The positive-definiteness criterion is an equivalence with strictly positive coordinate masses. Inverse identities and the reciprocal-diagonal formula explicitly assume these positive masses. Nonzero masses also suffice for invertibility, but those more general statements are outside this batch.
- No trajectory, differentiability of potential, ODE existence, conserved energy, or stability result follows from the T1 algebraic bridges. The printed19/PDF42 dynamical assertions remain later tasks.
- Local textbook checks compared printed18–19/PDF41–42 with the precise statements and final implementation. MathCopilot's independent T1 report and responsible final semantic sign-off are still pending.
