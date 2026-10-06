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

## T3 fixed-mass Hamiltonian assumptions

- The physical model specializes printed24--25/PDF47--48 to fixed positive diagonal coordinate masses. Position-dependent mass matrices, constrained generalized coordinates and the Legendre supremum argument are outside this batch.
- The coordinate energy uses real total division. Its substitution identity and genuine coordinate gradient hold for arbitrary real masses, including zero. This algebraic extension does not turn zero or negative masses into a physical model.
- Equating coordinate division with the whole matrix inverse, and recovering velocity energy from arbitrary momentum, explicitly require strictly positive coordinate masses. For mixed zero/nonzero masses the coordinate formula may differ from mathlib's total singular-matrix inverse.
- `gradient_position_slice` and `hamiltonianVectorField_eq` are identities of total operations. `hasGradientAt_position_slice` separately assumes `DifferentiableAt ℝ U q` to certify the classical derivative. A relative differentiability premise on Q needs a neighborhood/open-domain condition for a two-sided derivative at q.
- The vector field uses a momentum slice and a position slice in their existing Euclidean spaces. No inner product on the ordinary product-norm phase space is assumed or introduced.
- All finite indexing identities allow n=0, N=0 and d=0; no positivity of dimension is needed for these static algebra and gradient statements.
- This batch does not prove time-trajectory equivalence, energy conservation, existence/uniqueness, maximal extension, stability or Theorem 1.1. Local textbook review, independent website review and final responsible sign-off have separate evidence and statuses.

## T4 conservation and local existence assumptions

- Energy conservation requires an **existing** solution on an open time interval, strictly positive coordinate masses, differentiability of U at every visited position in Q, and the explicit conservative-force equation `F q = -gradient U q` on Q. It proves a derivative identity and constancy on `Ioo a b`; it does not construct that solution or assert closed-endpoint differentiability.
- Local existence assumes a C¹ force at the initial position and an open configuration domain Q containing that position. The produced ambient curve is asserted to solve the mechanical ODE only on a smaller open interval. No mass positivity is needed for this mathematical existence theorem, because the total inverse-matrix operator still defines a field for arbitrary masses; physical recovery of `p=M q̇` requires positive masses separately.
- `mechanicalSolution_eventually_unique_of_contDiffAt` proves local uniqueness near the initial time from C¹ regularity at the common initial phase point; it uses the local Lipschitz neighborhood supplied by mathlib and does not extend equality beyond that neighborhood. The separate interval theorem assumes a supplied **global Lipschitz** constant for equality on the whole common open interval. Maximal extension remains a further task.
- Total momentum is indexed by a spatial direction after the particle-first `Fin N × Fin d` equivalence. Its conservation explicitly requires the sum of particle forces in that direction to vanish on Q; a general external force need not conserve it. The theorem allows zero particles or zero spatial dimension algebraically.
- These first-batch results do not imply a global phase-space bound or a maximal solution. In particular, T5's conditional position confinement has not yet been combined with an ODE continuation theorem to prove Theorem 1.1.
- `strictPotentialMin_mechanicalEquilibrium` uses the open-domain relative strict minimum to obtain an ordinary local minimum and hence zero total gradient at the center. Together with `F q₀ = -gradient U q₀`, this makes `(q₀, 0)` a zero of the mechanical vector field for any defined mass operator. It does not prove positive-time existence, conservation-based confinement, or Lyapunov stability.

## T4 momentum bounds and mechanical confinement assumptions

- The norm-square estimate requires strictly positive coordinate masses and an explicit upper mass bound M. The norm and strict-radius estimates additionally require M>0. This is the fixed diagonal mass model, not a result for variable mass matrices.
- Compact energy sublevels use a supplied compact position set K and only continuity of U on K. The proof derives a potential lower bound, chooses M=1+sum of absolute masses, and bounds momentum in a closed Euclidean ball. It does not assume compactness of the desired phase set, or global coercivity of U. Empty K and n=0 are allowed.
- The mechanical barrier theorem takes an actual solution on a supplied open interval, positive masses, differentiability of U on Q and F=-gradient U on Q. It derives energy conservation and curve continuity rather than assuming them. The initial position is in the ball; future positions are not included in the hypotheses.
- The phase-distance theorem additionally takes U(q₀)≤U(q) within the ball and an initial energy budget smaller than U(q₀)+r²/(2M). It proves dist(γ(t),(q₀,0))<r for t≥t₀ still inside the supplied interval. The ordinary product norm uses the maximum of the two component distances.
- These results do not construct a global solution, derive arbitrary-initial-state stability, or prove the strict supremum bound in Theorem 1.1. Compactness is a dependency for a future continuation theorem, not a replacement for that theorem.

## T4 finite endpoint and gluing assumptions (2026-10-04)

- Endpoint limits use a complete metric target and a<b, with Lipschitz control only on Ioo a b. The ambient value at b is arbitrary. A closed-set membership conclusion additionally requires the open-interval image to lie in that set.
- The mechanical version obtains its Lipschitz estimate from the actual ODE derivative and a uniform field bound. The compact version derives this bound from compact phase K and continuity of the field on K. It does not assume an endpoint limit or phase compactness as a disguised conclusion.
- Compact K is an explicit input to this dependency. Deriving it from the energy barrier uses the already checked energy sublevel theorem in a later continuation corollary. To apply local existence at the limit one must still prove its position lies in open Q and sufficient field regularity there.
- Connected-domain uniqueness requires C1 regularity at each point of the first trajectory. It uses the equal-time set's openness from local uniqueness and closedness from continuity. It does not require a global Lipschitz field.
- Gluing assumes equality on an explicit open overlap. Its piecewise curve agrees locally with one genuine solution even at b, so the ODE and position membership are proved there. This dependency does not yet derive overlap equality from a common endpoint or assert maximal/global existence.
- The seven formal results passed the integrated local check and dependency audit (208 declarations). Remote CI has not run for this batch; responsible textbook semantic sign-off remains pending.

## T4 actual finite endpoint continuation (2026-10-04)

- The FTC endpoint derivative theorem requires continuity of the curve and derivative data on a closed interval, with actual derivatives only on its interior. It handles a degenerate interval algebraically; the matching theorem separately requires a<b.
- Endpoint matching uses a C1 field at the endpoint limit, obtains a local Lipschitz neighborhood there, fills the original curve's endpoint by its limit, recovers its one-sided derivative, and applies backwards local uniqueness. The curve's original ambient value at b is not used.
- Mechanical continuation requires the limit position in open Q, shrinks the new local IVP to stay in Q, and proves agreement on the original interval. Compact continuation derives the limit and uses K's position projection in Q plus C1 force there. It does not require global Lipschitzness or positive masses beyond the total mass-operator model.
- Five new key statements passed full-check02; final responsible textbook semantic sign-off is pending. The uniform confinement-to-global theorem is a later bridge and is not claimed by these finite-endpoint results.

## T4 future continuation and strict stability assumptions (2026-10-04)

- Fixed strictly positive coordinate masses are required for the energy-based global and stability results. The algebraic n=0 case is allowed; no positive dimension is silently assumed. General configuration-dependent mass matrices remain outside this model.
- GlobalContinuation takes confinement of each already-existing local same-IVP solution in a common compact K, K projecting inside open Q, and C1 force on Q. EnergyGlobalExistence discharges this premise from actual ODE conservation and a safe energy barrier, without assuming global existence, coercivity or a global Lipschitz bound.
- Stability requires a strict relative potential minimum in open Q, U differentiable there, F=-gradient U and F locally C1. The final potential specialization derives these from local C2 potential regularity, which is weaker than the textbook's smoothness assumption.
- Future existence and bounds for every supplied same-initial-state future solution are separate conjuncts. Each real supremum is accompanied by explicit BddAbove of the distance range, and the proof uses a control radius strictly smaller than epsilon. Pointwise strict bounds alone are not used as a strict supremum argument.
- PhaseSpace uses the ordinary product maximum metric. PhaseEuclideanDistance is sqrt(dq²+dp²) in the two Euclidean component spaces; its comparison constants are dimension-independent, including n=0. The checked separate Euclidean predicate makes the textbook norm correspondence explicit, with the smooth-potential specialization stated directly.
- Full-check03 passed at06:07:48--06:10:29 +08:00:8947jobs, Scratch,231imported declaration audits and stable fixed inputs. New remote CI and responsible human textbook sign-off have not run. No named abstract maximal-solution API is exposed yet.

## Lagrangian, generalized coordinates and Legendre assumptions (2026-10-04)

- The fixed coordinate-mass Lagrangian is T(v)-U(q). Its velocity gradient Mv is proved from real polynomial Frechet derivatives for arbitrary real masses; position gradient requires differentiability of U at the position. These algebraic derivative identities do not require positive mass or positive dimension.
- Euler--Lagrange trajectory equivalence uses strictly positive fixed masses, actual time derivatives and U differentiable on Q. The mechanical-to-Lagrangian direction uses open I to recover actual position derivatives locally; the converse constructs (q,M deriv q) from the given two-sided derivative predicate. It does not infer the ODE from an isolated static identity.
- Rectangular J is allowed. The static coordinate-change formula requires no invertibility or differentiability; the separately stated velocity chain rule requires an actual HasFDerivAt for Phi with matrix J. Positive generalized mass/invertibility additionally require positive coordinate masses and injectivity of J.mulVec, an explicit version of full column rank.
- Positive masses, rather than mere invertibility, are needed for the Legendre maximum. The gap is nonnegative kinetic energy, equality iff v=M⁻¹p, and the objective range is explicitly BddAbove before stating its real supremum equals H. U is arbitrary for this fixed-position algebraic statement. Degenerate n=0 remains allowed.
- These results do not yet prove Euler--Lagrange covariance or dynamics with a configuration-dependent mass matrix, nor the least-action variational principle. All original pages were locally checked; full local check passed at06:29:14--06:31:00 (8950jobs,261declaration audits, fixed inputs stable); responsible semantic sign-off and new remote CI remain pending/not run respectively.

## Future mechanical flow assumptions (2026-10-04)

- IsFutureMechanicalFlowOn records actual future IVPs for each z in S (each has its own a<0) and actual forward invariance of S. It does not assume composition, injectivity, energy conservation or global negative-time existence.
- Composition, commutation and injectivity derive from C1 force on Q and actual mechanical trajectories; mass positivity is not needed for these uniqueness consequences of the total mass-operator ODE. Time translation shrinks/shifts the actual time domain explicitly.
- The energy result and energy-barrier family construction require positive fixed masses, differentiable U, F=-gradient U and the safe closed position ball inside open Q. The family existence and invariance are proved; they are not an external global-flow assumption.
- The asserted composition laws cover s,t≥0. The ambient family values outside S or before its per-state local negative endpoint have no ODE/group claims. Joint continuity in initial state and time is not asserted. No full Dynamics.Flow structure or negative inverse law is claimed yet.
- Original printed26/PDF49 was viewed; six new key independent proofs use only the permitted foundational axioms. Full local verification passed at06:40:32--06:42:49 (8951jobs,268declaration audits, stable fixed inputs); responsible semantic sign-off remains pending, new remote CI not run.

## Time reversal and global flow assumptions (2026-10-04)

- MomentumReflection is a continuous linear map (q,p)↦(q,-p). Reversing only time would solve the negative vector field; reversing momentum as well yields the actual mechanical field because the fixed inverse mass operator is linear and the force depends only on position.
- Two-sided barrier existence starts from the already proved forward IVPs for z and reflected z. Reflection preserves the Hamiltonian and position; C1 uniqueness derives their equality on a nonempty open overlap around0. Actual open-cover gluing yields a solution on all real time. No backward solution is assumed.
- IsGlobalMechanicalFlowOn assumes actual all-real-time IVPs and invariant S, not inverse/composition laws. These follow from time translation and connected-domain uniqueness. Positive masses are needed for the energy/barrier existence model, not for these abstract uniqueness consequences of the total fixed-mass field.
- The concrete constructed family is on the low-energy safe ball domain S. The pointwise choice outside S is irrelevant; no property outside S is claimed. S may be empty algebraically; the strict-minimum application supplies a positive safe radius/barrier containing the equilibrium.
- These all-time families are not yet claimed jointly continuous in initial state and time, and no continuous Dynamics.Flow structure is introduced. General globally coercive potentials, periodic domains and singular collision domains need their own hypotheses/proofs.
- Eleven key independent proofs passed with only permitted axioms; the new integrated Flow/full-check02 passed at06:52:24--06:54:30 (8953jobs,286declaration audits, stable pinned inputs). Original printed26/PDF49 was checked, responsible final sign-off pending and new remote CI not run.

## Explicit oscillator/free-particle assumptions (2026-10-04)

- Harmonic formulas use one real scalar frequency Ω≠0 and unit coordinate masses. Negative nonzero Ω is allowed; the force/potential depend on Ω². Finite dimension may be zero. Actual q/p derivatives, initial values, all-time ODE, joint continuity and Flow fields are proved; no general chosen barrier-family continuity is inferred.
- The potential is the genuine quadratic ΣΩ²qᵢ²/2 and its gradient is Ω²q. Conservation derives from the existing actual ODE theorem. Ω=0 is handled separately as the free particle, since literal total division in the nonzero-frequency formula would omit the linear q drift.
- FreeParticleFlow uses arbitrary fixed coordinate masses and the existing total velocityOperator convention; its actual first-order ODE and constant-zero-potential energy identity need no positivity. A physical invertible positive-mass interpretation requires positive masses. Neither module assumes composition laws or a global solution to prove the formulas.
- Integrated full-check02 passed at07:09:12--07:10:36 (8955jobs,310declaration audits, stable pinned inputs); original printed27/PDF50 locally checked; responsible final semantic sign-off pending, new remote CI not run.

## Constant-linear/matrix/real-spectral assumptions (2026-10-04)

- LinearFlow uses real Banach E and a continuous linear endomorphism A. The actual exp(tA) ODE, arbitrary initial time, all-time uniqueness and joint continuity require completeness; static zero-time/series identities omit it when unused. NormedAlgebra ℚ is the explicit restriction of the existing real algebra, without extra axioms.
- MatrixFlow covers arbitrary real m×m matrices on Position m, including m=0. Standard continuous toEuclideanCLM sends matrix exponential to operator exponential, so the displayed mulVec equality is actually proved. No symmetry, invertibility or diagonalizability assumption is needed.
- RealSpectralFlow proves actual real eigenmode derivatives, finite spectral superposition and the formula from a real eigenbasis. The eigenbasis assumption is needed to supply all initial coefficients, explicitly via repr. No nonzero eigenvalue or nonzero vector hypothesis is required for the mode identity. Complex eigenvalues/coefficients and real recovery are separate, still unproved.
- Original printed27/PDF50 visually checked; independent candidates passed. full-check01 passed:8958jobs,348project audits, Scratch, pinned versions/source scan and stable input SHA, responsible semantic sign-off pending, new remote CI not run.

## Complex spectral and real recovery assumptions (2026-10-04)

- ComplexSpectralFlow uses complex Banach E, complex-linear continuous A and real time. Its real-scalar restriction solves the actual ODE and forms a continuous Flow. Spectral formulas require the supplied eigenvectors/eigenbasis; no claim that every matrix is diagonalizable. Eigenvalues may be0 and dimension may be0. Basis.repr gives coefficients and their uniqueness is proved.
- RealRecoveryFlow uses actual real-linear intertwining maps, proved from genuine derivative/IVP uniqueness. Complex coordinate conjugation is real-linear, not complex-linear. Its actual commutation with the complex lift of a real matrix, plus initial imaginary parts0, gives all-time imaginary parts0. Real recovery also applies to the full eigenbasis spectral sum; no individual-mode reality is assumed.
- BasisMatrix defines columns from any finite Euclidean basis over an RCLike field. Column multiplication equals the actual vector combination, basis uniqueness gives injectivity and true IsUnit, and nonsingular inverse yields coefficients. X invertibility is a conclusion, not a hypothesis.
- Independent candidates passed and integrated ComplexSpectral/full-check01 passed at07:40:13--07:41:57:8961jobs,382project audits, Scratch, pinned versions/scan and stable SHA. Original printed27--28/PDF50--51 checked; responsible semantic sign-off pending, new remote CI not run.

## First-integral and planar/polar assumptions (2026-10-04)

- FirstIntegrals uses real normed Banach state spaces for the criterion equivalence. IsFirstIntegralOn quantifies actual Q-valued ODE trajectories over open intervals. Sufficiency uses the genuine chain rule and zero derivative; necessity uses C1 f and open Q to construct/shrink a real local IVP. I is differentiable on Q. Hilbert gradient conversion additionally uses a complete real inner-product space.
- PlanarAngularMomentum uses dimension2 and unit masses. An actual mechanical solution plus zero torque implies constant x p_y-y p_x; arbitrary central force has zero torque by algebra. No global orbit, force smoothness or assumed conservation is needed for the existing-trajectory claim.
- PolarCoordinates proves trig identities and actual scalar time derivatives. The velocity-coordinate coefficient matrix has det=r and is invertible iff r≠0. Physical Kepler/polar use requires r>0 despite total division keeping static expressions defined at0. General Frechet Jacobian and EL covariance, true Kepler potential gradient and collision/global orbit assertions are separate.
- Independent candidates passed; FirstIntegrals/full-check01 passed at07:49:56--07:52:08:8964jobs,403project audits, Scratch, pinned versions/scan and stable SHA. Original printed28--29/PDF51--52 checked; responsible semantic sign-off pending, new remote CI not run.

## Kepler singular domain (2026-10-04)

- KeplerPotential and Force are total Lean functions, but actual gradient, C1 field and local IVP theorems explicitly require q≠0 and use the open nonzero position domain. No smoothness or physical value at0 is inferred from total inverse.
- Unit masses and arbitrary finite configuration dimension are used for the energy/local IVP statement; planar angular momentum is specifically dimension2. Energy and angular momentum follow from the genuine mechanical ODE and proved force-gradient/central-force identities. Existing trajectory avoidance of0 is the model domain, not a new proof of no collisions.
- Radial/polar dynamics and quadrature, global noncollision conditions and action-angle/torus results remain separate. Candidate03 passed with permitted axioms; Kepler/full-check01 passed at07:59:01--08:00:56:8965jobs,412project audits, Scratch, pinned versions/scan and stable SHA, responsible sign-off pending and new remote CI not run.

### Polar local chart (2026-10-04)

Two real Euclidean coordinates, radius q₀≠0 for inverse chart; derivative formula itself holds at every q. Local invertibility is deduced from the proved Jacobian determinant q₀ through the actual inverse function theorem. Inverse is strict differentiable at the image of the base point. Positive radius, physical Kepler trajectories and global angle branch selection are not inferred from this local result.

### Kepler polar Euler--Lagrange trajectories (2026-10-04)

Real scalar r,θ,v,ω with r>0 along the declared time set; actual r'=v and θ'=ω. The EL predicate contains time derivatives of actual Lagrangian partials, not radial dynamics as premises. Open connected Ioo gives genuine angular/energy conservation; closed oriented subintervals are inside that Ioo and continuity proves angle integrability. Fixed angular momentum in the low-level energy lemma is supplied from proven conservation in the initial-angular-momentum corollary and the angle formula. No unproved Cartesian covariance or full radial quadrature is inferred.

### Cartesian/polar trajectory bridge (2026-10-04)

Planar Euclidean unit-mass Kepler force; polarCartesianState uses genuine positions and momenta from scalar kinematics. Positive radius implies nonzero Cartesian position. Forward polar EL→Cartesian has no openness requirement; reverse/iff requires open I and actual r'=v,θ'=ω with r>0. Neither v' nor ω' is assumed in reverse: the former follows from Cartesian radial velocity projection, the latter is available from true angular momentum conservation. No global lift across arbitrary branch choices is inferred.

### Kepler radial initial-state reconstruction (2026-10-04)

Unit-mass planar Kepler, nonzero Cartesian initial position. No polar representation or radial solution existence is assumed: the representation follows from complex argument, and positive radial local IVPs follow from proved C1 force on {r>0}. Angle integrability and true derivative follow from positive radius/actual radial derivatives over the prescribed open interval. Arbitrary real angular momentum l (including zero) is supported locally; no global collision avoidance or global radial inverse/branch selection is claimed.

### Separated scalar quadrature (2026-10-04)

Continuous real scalar w, nonzero throughout the specified open position interval; base and trajectory positions inside it. Actual time-domain solution satisfies HasDerivAt r (w(r(t))) on a connected open interval with real initial value. FTC supplies integrability and actual strict derivative, inverse theorem supplies local inverse, conservation of G(r(t))-t proves the time formula. Local inverse identities/solution hold eventually at the base point only. Zeros of w and turning points are explicitly excluded, not hidden by total division.

### Kepler local nonturning quadrature (2026-10-04)

Actual r'=v and v'=-1/r²+l²/r³ with positive radius on an open time interval; initial point inside the interval and v(t₀)≠0. Energy, velocity sign and local windows are derived rather than assumed by the final theorem. Both signs and l=0 are included. Integral inverse identities are eventual at the base point, and the time formula holds on a derived window. No differentiable inverse at a turning point or global noncollision claim is made.

### Harmonic action-angle (2026-10-04)

Unit scalar harmonic oscillator; Ω>0. Energy identity permits I≥0; actual ODE equivalence/time formula uses I>0 and actual differentiability of the chosen real angle/action lift. Nonzero phase representation is proved rather than assumed. Angle evolution is a real lift, not a global unique angle function; zero action is excluded from invertible-angle dynamics. Flow intertwining follows directly for all real I but uses Ω>0; the physically relevant representation has I>0. Local chart/torus topology are not inferred from mere representation.

### Action-angle local coordinate chart (2026-10-04)

Actual Euclidean two-dimensional action/real-angle input and position/velocity output, Ω>0 and base action I>0. Positive amplitude/nonzero denominators and true Jacobian invertibility are proved. Forward map is globally defined by total sqrt/div, but its accepted strict derivative/chart is restricted to positive action. No zero-action inverse or globally unique real angle is asserted.

### Decoupled harmonic torus (2026-10-04)

Finite dimension (including empty product for algebraic Flow/period laws). Quotient-circle rotation accepts arbitrary real frequencies; positive Ωⱼ and Iⱼ are used for nondegenerate coordinate energy image and actual mechanical bridge. Integer-frequency periodicity assumes nonzero base frequency. A period value in the formal criterion is not automatically positive; positive physical period follows if the base frequency is positive. Density is not inferred merely from irrational pairwise ratios in general dimension.

### Torus homeomorphism and density (2026-10-04)

Positive Ωⱼ/Iⱼ for fixed-energy homeomorphism, finite product including dimension zero. Two-frequency angle density needs Ω₀≠0 and irrational Ω₁/Ω₀, no sign assumption; physical fixed-energy closure additionally uses positive frequencies/actions. Density is for real-time range (both directions), not yet forward-time density. Three-frequency resonance non-density allows arbitrary frequencies and initial angle. General higher-dimensional rational independence density and rational-period iff remain separate.

### Exact two-frequency period classification (2026-10-04)

Ω₀>0 for the angle positive-period iff, Ω₁ arbitrary; physical orbit classification additionally Ω₁>0 and both actions positive, so phase map is injective. Rational frequency ratio is an existential real equality to a rational, and a positive period is explicitly constructed. Zero-action degeneracy can remove a frequency and is not included in physical iff. High-dimensional resonances/general nonresonance remain separate.

### Local first-integral graph reduction (2026-10-04)

Actual real pair state, strict Fréchet differentiable first integral at the base and actual derivative y-component L(0,1)≠0. Trajectory reduction assumes the previously defined genuine first-integral property, actual ODE derivatives on a connected open time interval and base inside it. Graph and reduced trajectory formulas are eventual near the base only. No generic global level graph/zero partial inverse or already solved scalar trajectory is assumed. Stronger C1 graph regularity for quadrature is separate.

### Planar nonturning first-integral quadrature (2026-10-04)

Actual first-integral property and actual real-pair ODE on a connected open interval, with trajectory in Q and base inside. J and f are genuinely C1 at the base; derivative ∂yJ≠0 and x-component of f at base≠0. C1-at gives required local regularity, all windows and nonzero speed derived. Inverse/solution formulas are local/eventual, not global; zeros of selected partial or selected component require a different chart or independent stationary/turning-point treatment.

- ScalarIntegrability: one real position/velocity pair, unit mass, U globally C2; true HasDerivAt ODE on an open Ioo interval and interior base time, nonzero initial velocity. The velocity graph, nonzero local windows, strict integral inverse and actual trajectory representation are derived. Local statement only; no claim yet for zero initial velocity/global patching.

- ScalarTurning: unit-mass real scalar system, U globally C2, genuine interval ODE, interior initial time. Regular-turning quadrature needs U′(x0)≠0 (includes v0=0); it uses actual swapped coordinates, no assumed graph/level conservation. Equilibrium claims require v0=0 and U′(x0)=0; C1 uniqueness and connected-interval continuation prove actual stationarity. No blanket nonstationary global-existence assumption.

- ScalarLocalIVP: arbitrary z0∈R×R and real t0; globally C2 potential U and unit mass. No assumed trajectory: actual C1 ODE local existence produces one, then derives conserved energy and all three initial alternatives. Quadrature localization may shrink the original existence interval. Nonstationary global extension remains separate.

- EquilibriumLinearization: real normed spaces; for linearized exponential IVP additionally Banach completeness. Little-o requires actual Frechet derivative (or true C1 base regularity) and f(z*)=0. Nonlinear actual perturbation includes the full remainder; it is never equated with the linearized IVP. Mechanical block derivative uses actual force derivative; total inverse mass operator algebra is meaningful even singular, physical inverse-mass reading requires positive masses. Conservative block result assumes U C2 at base. Hyperbolicity/topological conjugacy not proved.

- LocalContinuousFlow: complete normed state space, C1 field at base point, and for mechanical open-domain result an open Q with base position in Q. Picard–Lindelöf supplies the actual family, with a reduced common time/initial ball ensuring domain membership. Joint continuity is only on the stated local product; global continuation, flow group laws, and hyperbolic conjugacy remain separate.

- HamiltonianHessian: real inner-product state position and actual ContDiffAt U 2 at the equilibrium position. Hessian symmetry is derived from fixed mathlib's C2 second-derivative theorem. The mechanical force block uses the actual derivative of gradient U; no claim that it is positive/negative definite, and no nonlinear-to-linear conjugacy.

- LinearizedHamiltonian: strict positive coordinate masses and an explicit nonnegative actual Hessian quadratic form are required for quadratic-energy nonnegativity. The formula itself uses the true `fderiv (gradient U)`; no arbitrary matrix or hidden positivity assumption is substituted.

- LatticePairPotential: finite index type `Fin N` and an arbitrary real pair potential `φ`; the uniform energy is the upper-triangular unordered-pair sum, so each pair is counted once. Translation invariance uses only algebra of differences. The two-atom reduction is exact. No nearest-neighbor, boundary-condition, periodic-lattice, stability, or lattice-vibration claim is inferred.

- The nearest-neighbor chain uses `N + 1` ordered sites and `N` bonds, represented by `Fin.castSucc` and `Fin.succ`. Its two-site statement is exact. No force derivative, boundary condition, periodic identification, or vibration spectrum is assumed.

- LatticeVibrations assumes a finite-dimensional `Position n`, a `C²` potential at the candidate equilibrium, and zero gradient there for the little-o theorem. The expansion uses the actual derivative of `gradient U`; it does not assert Hessian positive definiteness or imaginary eigenvalues. Those spectral conclusions require separate positive-definite mass/Hessian hypotheses.

- The positive-Hessian bridge assumes strict positivity of the actual quadratic form on every nonzero displacement. It derives only nonnegativity, with the kinetic block separately requiring strictly positive masses. Spectral classification and derivation of positive definiteness from a strict minimum remain unproved.

- The periodic nearest-neighbor definition requires `[NeZero N]` so `ZMod N` has a finite index set. The wrap-around bond is represented by modular addition. Only the energy formula and translation invariance are formalized; no periodic force, spectrum, or stability conclusion is inferred.

- The actual box-periodic formula includes a real box length `L` and seam displacement `L + x 0 - x (last N)`; it is distinct from the abstract `ZMod` cyclic helper. The walled formula includes endpoint confinement potentials. No physical ordering, collision avoidance, force derivative, or periodic spectrum is assumed.

- NormalModes takes the generalized eigenpair relations as hypotheses and derives the real mode solution; it does not assert that every positive Hessian supplies a complete eigenbasis or derive the pure-imaginary spectrum. The mechanical bridge uses positive coordinate masses and the explicit mass/stiffness relation.

- VariationalEquation formalizes only the constant-coefficient variational system `W' = A W` on a complete real normed space. It does not identify `A` with a time-dependent Jacobian along a nonlinear trajectory, prove differentiability of a nonlinear flow with respect to initial data, or define/compute Lyapunov exponents. The matrix-exponential exercise lemmas use the fixed mathlib matrix exponential and state the commuting hypothesis explicitly.

- The diagonal exercise uses a finite real index type and the literal matrix `Matrix.diagonal d`; its component formula follows from the fixed `Matrix.exp_diagonal` lemma. No diagonalizability assumption is silently extended to arbitrary matrices, and exercises 1(b)--1(c) remain open.

- The similarity exercise assumes `IsUnit X` for the displayed conjugating matrix and uses the literal inverse `X⁻¹`. It proves only the matrix-exponential conjugation identity; existence of an eigenbasis or a diagonalizing `X` is a separate hypothesis.

- The upper-triangular exercise is the literal two-dimensional matrix `[[1, α], [0, 1]]` with real `α`; its explicit solution is verified by `HasDerivAt` and linear-ODE uniqueness. This is a special case, not a general Jordan-form or arbitrary upper-triangular theorem.

- TwoBodyCoordinates formalizes only the linear coordinate algebra for two planar particles with equal masses and the corresponding kinetic-energy identity. The definitions use `q_cm=(q₁+q₂)/2` and `Δ=q₂-q₁`; no radial potential, force law, reduced equation of motion, polar-coordinate integration, or unequal-mass claim is inferred.

- The radial-potential extension defines `L=T-φ(‖Δ‖)` and rewrites it using the equal-mass center/relative kinetic identity. It still assumes no differentiability of `φ` and makes no claim about the resulting force or reduced equations.

- Theorem 2.1 uses `Position m` with its Euclidean norm, `Bornology.IsBounded D`, `IsOpen D`, and `ContDiffOn ℝ 1 f D`. A specified exact curve stays in `D` and has actual `HasDerivWithinAt` derivative `f (γ t)` on `[0,τ]`, with `τ ≥ 0`; the initial value is `γ 0`. All Euler domain retention and error bounds are conclusions. No convexity, globally bounded derivative, numerical retention, supplied Lipschitz constant, supplied local-error bound, C² field, or global flow assumption is added. Finite-dimensional compactness gives the necessary uniform constants near the trajectory. The estimate is valid for any specified solution, so the text's uniqueness premise is unnecessary for this conclusion. The arbitrary total extension of `f` outside `D` is not used by the proven in-domain numerical trajectory.

- Section 2.2.3 retains its explicit numerical-domain and exact-trajectory containment premises. Stability is the actual map inequality with factor `1+hL`; consistency is the actual along-trajectory defect `≤ K h^(p+1)`. The displayed division by `L` requires `L > 0`, and `K ≥ 0`. The finite bound holds for any real `p`; the mesh-refinement limit requires `p > 0`, `τ > 0`, a positive threshold, and constants independent of the step count. Consistency uses `0 < h < δ`, while stability and numerical retention use `0 < h ≤ δ`. The exact-flow relation is expanded along the specified curve; no global flow, supplied error recurrence, smooth map, or differential-equation hypotheses are additionally needed for this quantitative implication. The initial numerical value is exactly `γ 0`, and the maximum includes both interval endpoints. This section's assumed domain retention does not replace Theorem 2.1's derived retention.

- SymplecticForm is finite-dimensional real coordinate algebra, indexed by `Fin Nc ⊕ Fin Nc` with explicit q/p labels. It includes dimension zero. The textbook J is the negative of mathlib J; the actual wedge and bilinear signs are proved, not silently identified. The pullback is under the linear tangent map represented by A, and its preservation is equivalent to `AᵀJA=J`. Matrix invertibility and determinant conclusions follow from this condition. Nonlinear global invertibility, true flow-Jacobian variation, differentiation of an inverse nonlinear map and volume transformation for measurable sets are not assumptions hidden in a claimed theorem; those claims remain pending. The generic two-form coefficient convention with a sum over all ordered pairs is not conflated with the textbook's standard coordinate-wedge normalization.

- SymplecticMaps uses actual globally defined C¹ maps on the labeled finite real coordinates, with the actual Fréchet Jacobian. Closure under composition and determinant one do not require global invertibility. The group statement uses an actual `Equiv.Perm`, requires a C¹ forward map and C¹ inverse, and derives symplecticity of the inverse from the chain rule. Global invertibility is necessary data, not a conclusion from a nonzero determinant. This correction to the textbook's local/global inference is recorded explicitly; no claim about arbitrary local symplectic maps forming this global group is made. Hamiltonian-flow Jacobian variation and set-volume transformation are independent pending claims.

- HamiltonianVariational uses actual HasDerivWithinAt of a finite matrix curve on the complete closed interval, in the explicitly scoped elementwise norm. S(t) may vary arbitrarily with time; symmetry is needed at every interval point and no derivative of S is assumed. Initial W(0)=I is explicit. Its Hessian variant derives symmetry from the actual C² Hamiltonian. Its actual-Jacobian variant has an explicit variational-derivative hypothesis, spatial C¹ maps and F0=id; deriving that derivative from the original nonlinear ODE is a separate unsolved dependency, not a supplied symplecticity premise or an accepted complete-flow theorem.

- SymplecticEuler uses globally C² real coordinate potentials and their actual negative partial derivatives. C¹ force and symmetric force Jacobian are derived. The actual momentum-first formula uses diagonal coefficients m_i⁻¹; physical interpretation uses positive masses, while the algebraic symplecticity proof holds for any constant diagonal coefficients and adds no zero-mass physical conclusion. Global kick/drift inverses are constructed directly and do not require invertible nonlinear Jacobians as premises. This globally defined version does not claim retention on singular open potential domains or a convergence-order theorem.

- AdjointMethods represents invertible numerical families by actual Equiv.Perm. The backward-Euler equation is proved equivalent to the negative Euler inverse relation for all fields, but existence/uniqueness as a map is asserted only conditional on a genuine equivalence with that Euler step. Continuous global Flow supplies its actual inverse; this does not assert global existence of any arbitrary ODE. The symplectic Euler adjoint has a directly proved actual inverse and requires globally C² potential for its C¹ symplecticity.

- SplittingError uses C¹ vector fields on an open domain in a proper real normed space, with actual curves solving the two fields and their sum on [0,τ], τ≥0. The first-field family starts at the second curve and is jointly continuous in its two time parameters, with the entire compact rectangle staying in the domain. These are true local-flow data, not supplied error constants. All norm/derivative bounds, cross increments and quadratic remainders are derived. The Hamiltonian specialization uses the actual coordinate J-gradient and C² H1/H2 on the common open domain. IsBigO is explicitly along positive h→0 and requires τ>0. It does not assume or claim global existence, initial-data differentiability of general ODE flows, negative-step bounds, or global first-order convergence without stability.

- CompositionMethods separates arbitrary actual C¹ symplectic maps from genuine C¹ symplectic equivalences. The former suffice for composition; a true Equiv family is needed only for the actual adjoint/inverse formulas. No regularity in the step-size parameter or accuracy bound is assumed for the algebraic K†=K identity. All steps use literal h/2 and negative h. This batch does not assert that arbitrary self-adjoint methods have even order without an accuracy expansion, or that composition always has precisely the minimum order.

- ProcessedMethods uses a genuine Homeomorph χ, hence a true inverse and continuity in both directions. No differentiability, symplecticity, accuracy or stability bounds are needed for the actual iteration identity and corresponding-orbit convergence equivalence. The latter compares A from z0 to B from χ(z0), with correspondingly transformed limits. A step-dependent χ_h requires no uniform regularity in h for the finite iterate identity. Actual pre/iterate/post-processing equals iteration of the given conjugate G, and its finite maximum error equals G's; no higher-order accuracy follows merely from this conjugacy data.

- LiePoisson uses actual scalar Fréchet derivatives. The first chain rule only requires differentiability at the actual curve point and its actual time derivative; no global flow existence is asserted. The second time-derivative result uses globally C¹ field/C² observable and a specified actual differentiable solution, with no accuracy premise. The bracket uses genuine coordinate covectors and the exact textbook J; both-slot linearity assumes differentiability of the combined functions. Jacobi and the actual commutator require C² at the point, deriving Hessian symmetry. Hamiltonian conservation needs only differentiability along the actual retained closed-interval solution. Formal operator exponentials are not assumed to converge. The p105 reversed-bracket display is not accepted as stated; signs remain those of the original definitions.

- FormalOperatorSeries requires only an associative ring with a real algebra structure; multiplication need not commute. PowerSeries multiplication is the actual finite Cauchy product at each coefficient. The general generator input has an explicit true zero constant coefficient, from which high-power coefficient vanishing and finite-sum stabilization are derived. No norm, analytic convergence, supplied low-order coefficient agreement, supplied commutator correction or accuracy estimate is assumed. The formal low-order matching does not substitute for actual nonlinear flow Taylor estimates or construction of higher modified Hamiltonians.

- ModifiedHamiltonianBounds: continuity of the finitely many real coefficient functions on the compact set suffices for the uniform truncation remainder; convexity and base-Hamiltonian regularity are unnecessary for this part. Actual C1 regularity on an open domain containing the compact convex set is used to derive the entire family's uniform Lipschitz constant. No nonemptiness or finite-dimensional ambient-space assumption is added. The interval includes h=0 and h=1 and permits empty truncations. Actual modified coefficients and numerical/flow high-order matching remain separate constructions.

- ModifiedEnergyDrift: true finite iterates retain the compact convex set; specified modified-Hamiltonian curves start at each actual point, stay in that set, and satisfy the actual ODE on the closed interval. Conservation and uniform remainder/Lipschitz constants are derived. The primary defect-sum bound has no local accuracy premise. ONLY the explicitly conditional rate theorem assumes a uniform true numerical/modified-flow endpoint defect; it additionally uses r≤k and nonnegative A,T with n h h^(k-r)≤T. Constructing this defect for the numerical method is still pending, and the corollary is not recorded as complete Theorem3.1.

- ConstrainedProjection: γ is globally C2 as in Lemma4.1; q,p and varying μ are differentiable at the parameter point. Their actual chart lies in the constrained cotangent set near that point, deriving Dγ(q)Dq=0 rather than supplying it. The final numbered lemma keeps both γ(q)=0 and p·∇γ(q)=0; the coordinate and finite-projection dependencies only need the first, as the original proof does not use the second. Derivatives/Hessian symmetry/form conservation are not premises. Finite coefficients require actual C2 constraints and differentiable multipliers. No Gram nonsingularity, manifold-chart existence, global inverse, implicit solver existence, integration order or whole-algorithm symplecticity is asserted.

- ConstrainedIntegrator: actual C2 potential/constraints, actual q,p,lam,mu differentiable at the parameter point, and actual initial/final position constraints near it are method data. The stage maps and all their derivative/form properties are derived, including varying multipliers. No form-conservation or method Jacobian premise is supplied. The force coefficient a is explicit (a=-h for the literal minus a negative-gradient F, a=h for Hamiltonian-consistent plus F); this geometric identity supplies neither order nor a force-sign semantic decision. Final hidden constraint Eq4.24/Gram solve and nonlinear lam solving-branch existence are not yet constructed.

- CotangentProjection: the actual Gram determinant is nonzero, precisely naming the inverse condition used. The formulas and all cancellation identities are derived from the real matrix inverse. Differentiability of each actual constraint at q is only needed to identify the row matrix with the vector map's actual derivative; the algebraic constraint is proved from its actual row definition. No positivity/nonempty/positive-dimension premise is added to this algebraic result. Physical positive-mass/independent-gradient derivation of nondegeneracy, multiplier C1 regularity and initial nonlinear solving branch are separate dependencies, not hidden premises or claimed results.

- ConstrainedReaction: each actual scalar constraint is globally C2; the actual Gram determinant is nonzero along the given closed solution interval; the real q,p curves satisfy the ODE with this constructed reaction and both initial constraints. F is a specified force, including the textbook negative potential gradient. No retained constraint, zero derivative or conservation premise is supplied. This proves solution-interval invariance, not global existence or a numerical solving branch.

- CotangentProjectionRegularity: actual C2 constraints, actual C1 parameter maps q,p, and Gram det nonzero at the parameter point yield multiplier/projection C1 there; neighboring nonsingularity is supplied by genuine scalar inversion regularity, not assumed. Matrix calculations use the actual elementwise/Pi norm. The constructed final integrator stage also uses a true C2 potential and specified actual C1 initial lam branch with initial/final position constraints near the chart point. Final mu, its derivative and its hidden constraint are all derived. Initial nonlinear solving-branch existence, physical derivation of Gram nondegeneracy and numerical accuracy are still separate dependencies.

- ConstrainedGram: each actual mass is strictly positive and the actual constraint-gradient family is linearly independent at q (along the actual solution for interval invariance). No determinant or Gram invertibility premise is used in the physical results. These hypotheses derive the actual Gram positive definiteness and positive determinant. C2 constraints/C1 parameter maps or real ODE/initial constraints remain exactly the earlier respective model data. Nonlinear initial branch existence and all-time ODE existence are not claimed.

- ActualFlowVariations: the actual specified solution family Phi is jointly C2 as a real map of time and initial parameter. The local derivative result needs only the real ODE at the given time for parameters near x and actual field differentiability at Phi(t,x). Hamiltonian instantiation uses actual C2 H and real ODE at all initial points along the specified closed interval, with Phi(0,z)=z. Variational ODE, field derivative, symplecticity and det=1 are derived. No globally existing ODE solution or construction of joint C2 from H C2 is claimed. Weaker C1-family regularity and set-volume transport are still separate dependencies; the one generic proof uses a bounded local 800000-heartbeat computation setting.

- HamiltonianVolume: actual C1 field, continuous actual solution family, real time ODE on a specified closed interval and initial identity imply injectivity. Hamiltonian volume uses real C2 H and explicitly joint C2 Phi, true ODE/initial identity; actual divergence/derivative/determinant, injectivity and measurable-image Lebesgue volume equality are derived. Measurable sets need not have finite volume. General divergence-free Liouville and weaker flow construction/all-time existence remain pending.

- LiouvilleVolume: arbitrary finite real coordinate space, actual C1 autonomous f with real trace Df=0, specified joint C2 actual Phi and real time ODE on Icc(0,tau), initial identity and measurable source sets. The Jacobian ODE, real determinant differential/value, injectivity and image-volume equality are derived. No matrix inverse or nonsingularity premise is needed by the determinant differential. Joint C2 is explicit stronger regularity; constructing weaker flow regularity/local-domain/general all-time existence remains pending.

- ConstrainedFlowSymplectic / ReactionRegularity: actual scalar constraints are C3, potential C2, specified actual phase family is joint C2 in time and initial parameter, with true reduced ODE and real initial position/hidden constraints for the chart parameters. Actual Gram det nonzero along the family is explicit in the algebraic result; the physical result derives it from positive masses and actual independent constraint gradients. Real curvature/reaction/field C1, retained constraints, actual variation and restricted standard-form constancy are derived. Generic acceleration helper accepts true differentiable multiplier functions; final flow theorem constructs their differentiability from the actual Gram formula. No ambient symplecticity, all-time existence/regularity/manifold chart construction or initial numerical nonlinear solve is claimed.

- WienerQuadraticVariation: arbitrary measurable probability carrier with actual `IsPreBrownianReal W P` finite-dimensional Brownian laws (probability-measure instance is derived), time T:NNReal including zero, positive K for exact partition error. Actual uniform increments, Gaussian moments, square integrability, independence, expectation, variance/error and K-to-infinity limit are derived. No continuity of sample paths or moment/independence/error conclusion premise is supplied; no general Itô integral construction is claimed by this module.

- WienerIntegration: same genuine preBrownian finite-dimensional laws; T:NNReal, arbitrary finite real deterministic coefficients, no Gaussian/variance conclusion premise. Finite sums' actual law, mean, variance and L2 isometry are derived. The self-Itô result uses actual left sums and derives W(0)=0 a.e. plus true finite telescoping, actual L2 integrability and the mean-square limit witness; precise error requires positive K. This does not construct a general deterministic Itô integral or a Stratonovich midpoint limit.

- InvariantDistributionSwap: S/T are genuine kernels, final pair assumes each is Markov. The textbook data consist of actual invariant probability measures, unique among all invariant probability measures. Transferred invariance, probability normalization, finite action iteration and both swapped equalities are derived. No general existence/ergodicity/uniqueness for arbitrary S/T is claimed; equality is of actual distributions as measures, with density representation separate.

- ThermostatLieFields: arbitrary actual real square A; no SPD is needed for Lemma8.1 algebra. Product phase carries genuine matrix linear fields and genuine finite-dimensional fderiv. End XY-YX is the negative actual vector-field derivative bracket; sign bridge and real negative closure are derived. No generated-field membership is assumed. Positive definiteness and distinct eigenvalues belong to the next independence result, with owner semantic review pending.

- ThermostatSpan: A.PosDef includes actual symmetry and positivity; real spectral theorem supplies the chosen orthonormal eigenvectors, and positivity of their actual eigenvalues is derived. Injectivity of those eigenvalues and actual nonzero position/momentum mode pairs are the textbook data. Genuine finite-sum coordinate projection and both coefficient cancellations derive independence/spanning; no diagonalization or spanning conclusion is assumed. The actual domain is open and canonical coordinates equal original eigenvector inner products.

- HormanderClosure/ThermostatHormander: Definition6.1 includes b0 and actual C∞ fields. Smooth finite sums are justified by genuine Leibniz identities and evaluate inside actual recursive-bracket point spans. Generic Proposition8.2 takes the original physical spanning premise and smooth F/G/g, with necessary nonzero sigma explicit. Original NHL physical span is derived from SPD/distinct spectra/nonzero mode D; true negative G, feedback sum p_i², original sigma=sqrt(2 theta gamma/mu), open D×R and C∞ fields are explicit. Positive mu/theta/gamma derive nonzero sigma. No extended spanning conclusion is supplied; other ergodicity/density/SDE existence results remain separate.

- ThermostatModeInvariant: actual Hermitian A suffices; actual q/p trajectories are continuous on Icc and solve q'=p, p'=-Aq-xi p by right derivatives on Ico, with continuous xi and initially zero true eigenmode. Actual mode operator continuity, compact norm bounds, Lipschitz and zero-solution uniqueness are derived. No whole-interval zero is assumed. This is pathwise invariance for real NHL q/p equations, without constructing stochastic solutions or an independent submanifold atlas.

- WienerStratonovich: actual IsPreBrownianReal W P finite-dimensional laws, T:NNReal including zero, positive K for exact error and K tending to infinity for the true mean-square limit. Probability normalization, centered half-step Gaussian moments, independence and square L2 integrability are derived. The sum uses actual time midpoints rather than averaged endpoint values. No correction variance or mean-square convergence conclusion is supplied. General deterministic Itô construction and owner semantic signoff remain separate.

- WienerRefinement: actual preBrownian finite-dimensional laws and T:NNReal including zero. Uniform coarse sizes K,L are positive for finite common-grid error. Initial error lemma uses the integrand LipschitzOnWith on the actual Icc; final existence result derives that condition from C1 g by compact derivative bounds. Actual KL telescoping, isometry, mesh error, Cauchy and completeness witness are proved. No Cauchy or mean-square convergence premise is supplied to the existence theorem. Limiting Gaussian law and variance integral belong to the next Proposition6.3 batch.

- WienerDeterministicLaw: actual IsPreBrownianReal W P, C1 deterministic g on real time and T:NNReal. Compact derivative bounds, genuine Riemann cell integration and finite Gaussian variance prove the time-integral variance limit. Actual mean-square/Lp representatives give probability/distribution convergence; true characteristic-function uniqueness gives the Gaussian law. The auxiliary identification theorem accepts an actual mean-square integral, whose existence is constructed in the final Proposition6.3 theorem. No limiting Gaussian law or moments are assumptions. Variance, rather than standard deviation, is the gaussianReal parameter.

- ThermostatDensity: finite-dimensional real normed physical state, actual C1 feedback/auxiliary functions and densities; the Hamiltonian instance uses C2 H. The two original single-thermostat stationary PDEs are premises; Hamiltonian Gibbs base stationarity and every flux/additivity conclusion are derived. Auxiliary couplings depend only on their own auxiliary coordinate and the common physical state. A real constant c specifies the Gibbs normalization, without assuming partition-function finiteness/existence. Product nonnegativity is separately derived from factor nonnegativity. Actual solution-family transport and probability normalization are not claimed from the PDE alone and remain the next required bridge.

- StationaryDensityFlow: finite-dimensional real normed state and specified Haar measure, actual C1 field/density, nonnegative density and true stationary Liouville PDE; a specified jointly C2 time/initial-state family satisfies the actual ODE and initial identity on the specified closed interval. Jacobian ODE/density conservation/injectivity/image-measure equality and normalized pushforward invariance are derived. No Jacobian, surjectivity or invariant-measure conclusion is assumed. Final Proposition8.1 uses real C2 H, C1 feedback and original single stationary densities, positive specified normalizer, and genuinely normalized nonnegative factors. Real product Haar and combined normalization are derived. No arbitrary-feedback global flow, partition-function existence, ergodicity or weaker C1-family construction is claimed; the stronger explicit joint C2 family remains an honest semantic qualification.

### Actual noncommuting symmetric formal BCH (2026-10-05)

SymmetricOperatorBCH: arbitrary possibly noncommuting real algebra R with Ring R and Algebra real R. Three actual operators X/Y/Z have no commutation hypothesis. Locally finite logarithm stabilization uses the genuine constant coefficient one, which the actual five-factor composition supplies. The remainder is exact formal X4 divisibility, not an analytic O(h4) bound. Actual exp(log S) is proved through degree four in this batch; full inversion/parity and unbounded-operator convergence are not yet claimed.

### Full actual noncommuting formal functional calculus (2026-10-05)

FormalOperatorFunctionalCalculus uses arbitrary Ring R with Algebra real R, without commuting operators, nilpotence or analytic convergence. Actual zero-constant series provide the locally finite scalar functional calculus. Scalar exp/log inverse results are applied only over the commutative real source and transported by a genuinely proved noncommuting-target algebra homomorphism. True time reversal preserves the original multiplication order; actual opposite exponentials and palindrome products give full parity, without assuming an inverse or all-order evenness. This supersedes the prior full-inverse/parity gaps in the formal BCH batch. No scalar-stepsize convergence or analytic O(h4) bound is claimed.

### Actual Langevin Hörmander computation (2026-10-05)

LangevinHormander: actual finite-coordinate R^Nc position/momentum and actual coordinate negative derivative force of U, with identity mass as in (6.47). C2 U suffices for the actual bracket/span calculation; C infinity U proves smooth original seeds. Nonzero sigma is necessary for the full-rank family and is derived for sqrt(2 gamma theta) at positive gamma/theta. The proof uses no Hessian rank, bracket result or spanning assumption. Toroidal charts, SDE existence, hypoelliptic density regularity and Wiener-support accessibility are separate.

### Actual Langevin smooth endpoint control (2026-10-05)

LangevinControlPath: finite R^Nc coordinate phase, actual globally C infinity U, real friction gamma, nonzero real sigma and positive endpoint time T. The constructed cubic remains a genuine path in this whole coordinate domain; arbitrary singular potential domains and toroidal quotient lifting are not claimed. Actual polynomial derivatives, actual force, Bochner integral, all endpoints, R(0)=0, global smoothness and the controlled equation are derived. Neither stochastic path support, probability accessibility nor solution-stability is a premise or conclusion of this construction batch.

### Actual Langevin integral-noise stability (2026-10-05)

LangevinNoiseStability: finite real coordinate phase, actual C2 U for trajectory estimates and C infinity U for the constructed reference, specified globally Lipschitz actual negative potential gradient, real friction/noise, specified true continuous integral solutions on Icc0T with W0=0. The controlled endpoint uses sigma nonzero,T>0 and delta>0. Actual compensated derivative, Lipschitz estimate, Gronwall bound and positive tube threshold are derived. No solution-continuity or target-ball premise is supplied. Removing the explicit global-Lipschitz condition requires true cutoff/first-exit localization; actual Wiener support/probability and Nonempty-open corrected Lemma6.1 remain separate.

### Actual smooth-potential noise localization (2026-10-05)

LangevinSmoothCutoff: finite R^Nc coordinate phase, genuine globally C infinity U, real gamma, nonzero sigma, positive T/delta, actual continuous Langevin integral solution on Icc0T with W0=0. Actual potential/force equality, compact gradient support, global cut-force Lipschitz constant, first hitting time and pre-exit confinement are all derived. The final endpoint stability theorem has no global original-force Lipschitz or stay-in-ball premise, superseding that qualification in the prior auxiliary batch. SDE existence on this interval, singular domains/toroidal lifting, Wiener support/probability and Nonempty-open semantic correction remain separate.

### Actual Brownian bridge and short path support (2026-10-05)

WienerBridgeSupport: actual IsPreBrownianReal B P suffices for Gaussian bridge/endpoint independence and endpoint-ball positivity at T:NNReal nonzero. Actual IsBrownianReal B P, including AE continuous true paths, is required for all sufficiently short time path support. Canonical unit-interval dense samples are constructed internally in the entire-path conclusions. The preliminary small-path set is used only through outer-measure coverage/lower bounds; actual countable bridge tubes and entire linear tubes are separately proved null-measurable. No small-ball or Wiener-support probability is assumed. Only real scalar short-interval support is accepted; arbitrary-time/vector/smooth-control support and final Lemma6.1 remain separate.

### Actual countable Brownian laws and independent segment support (2026-10-05)

WienerPathLaw: actual IsPreBrownianReal for finite/countable sample laws, segment Gaussianity/independence and raw measurable-event law transfer; actual IsBrownianReal for entire-path continuity and short support. Real equal-length nonoverlapping segments are computed from B with h:NNReal; the positive-support application explicitly requires 0<h<=eta and positive bridge radius and every endpoint tolerance. Any finite K and endpoint vector are permitted; no Brownian process law equality, segment independence or positive event probability is a hypothesis. The same eta is proved independent of K and all endpoint widths. Entire path tubes and finite joint events are null-measurable. Full prescribed-time/smooth-control/vector support and final Lemma6.1 remain pending.


## 2026-10-05 Prescribed-time Wiener support and actual Langevin endpoint accessibility

WienerPathSupport uses genuine IsBrownianReal, T:NNReal>0, R continuous on Icc0T, R0=0 and eps>0. The actual compact-control modulus, uniform mesh, true endpoint error sum and independent short bridge/endpoint event are constructed; support is not assumed. WienerVectorSupport defines the standard real vector law by actual joint Gaussianity, zero mean, isotropic min-time covariance and AE path continuity. Whole coordinate independence, true finite product probabilities, null-measurability and every prescribed-time control tube are derived; the finite-coordinate sup norm is the project model norm. NNReal and nonnegative real times are proved literally equivalent.

LangevinAccessibility is for the unit-mass finite real coordinate phase, global C-infinity real potential, sigma nonzero, T>0 and an actual AE integral solution on that interval, with the endpoint map AEMeasurable. No original force global-Lipschitz bound, confinement, noise-stability or support conclusion is a premise. Its actual control and localized-noise stability combine with the independently proved vector Wiener support. Every positive-radius target ball and every Nonempty open phase set have null-measurable positive-probability endpoint events. The physical coefficient sqrt(2*gamma*beta^-1) is nonzero at positive gamma,beta. General global stochastic solution construction/nonexplosion and periodic-lift identification are separate; the original all-open statement omits the necessary Nonempty condition. Responsible final semantic review remains pending.


## 2026-10-05 Actual unit-periodic Langevin integral model

The periodic position type is UnitAddTorus(Fin Nc), with real momenta and unit mass. The lifted real potential is C infinity and truly integer-lattice invariant; actual force and its derivative periodicity, compact-fundamental-cube global bounds and global force Lipschitz continuity are derived. The genuine representative-defined torus force is proved equal to the negative potential gradient on every real lift.

The periodic actual integral solution supplies the torus position integral equation, real momentum Bochner equation, p/W continuity on Icc0T and W0=0. Its real position lift is explicitly constructed from the initial representative plus the momentum integral; continuity, projection and the original real Langevin equation are proved, not assumed. Actual periodic endpoint AEMeasurability, genuine standard vector Brownian law, T>0,sigma nonzero and Nonempty open C yield null-measurable positive-probability target events. Real-lift endpoint measurability is not required. The physical gamma,beta positive specialization is included. General global stochastic solution construction/adaptedness/joint AE measurability/nonexplosion, other singular domains and nonunit period boxes are separate. The original all-open claim needs Nonempty; responsible final semantic review remains pending.

## 2026-10-05 指定区间实际Langevin存在模型

全局forceLip辅助模型的力场条件显式；周期主结论由C∞势能实际integer-lattice invariance推出globalLip。只需W ContinuousOn(Icc0T)、W0=0、T≥0；无需W导数、给定解、延拓或有界轨迹前提。unit mass/unit torus/finite Nc；随机模型AEmeas和适应性未计完成。

## 2026-10-05 实际随机积分解模型条件

只输入真实标准vector Wiener定义、C∞周期势能实际lattice invariance、unit-mass/unit torus/finite Nc、T≥0；真实R^n auxiliary模型force globalLip显式，周期主结论由compact cube证明推导。概率可达需T>0/σ≠0/Nonempty-open，physicalNoise需γ>0/β>0。实际随机解存在和每timeendpoint AEm、路径AEm、唯一/连续依赖及管支持均已证明而非前提；全时域一致/适应性/生成元未计完成。

## 2026-10-05 全时域模型与不爆炸条件

原单位周期C∞势能actual integer-lattice invariance推出global forceLip；auxiliary Rn模型的forceLip显式。实际同一标准Wiener、unit-mass/unit torus/finite Nc和任意γ/σ构造全非负时间模型；open可达需σ≠0/T>0/Nonempty，physicalNoise需γ>0/β>0。不输入global存在/不爆炸/finite-horizon一致或任何可测端点结论；适应性、强Markov、density/generator未计完成。

## 2026-10-05 实际periodic Lyapunov条件

单位质量/单位周期torus/finite Nc，实际C∞ integer-lattice periodic U，1≤U(q)，γ>0，positive integer l；physical σ=√(2γβ⁻¹)需β>0。U全局上界、H^l真实各阶导数、动量coercivity、torus紧sublevel/properness与δ漂移界均推导，不作为待证结论前提。generic σ²/2保留；原错误l(l+Nc−1)界用已核验的2l(l−1)+Nc*l替换并保持owner correction pending。literal smooth-lift differential expression与真实Markov generator的识别、适应性/密度及Harris遍历定理未计完成。

## 2026-10-05 actual causal/restart模型条件

auxiliary real模型需C² U和真实global forceLip，实际periodic主模型是C∞整数格点周期U，周期唯一性由compact-cube bound导出Lip；unit-mass/unit-torus/finite Nc。actual标准vector Wiener、任意γ/σ、real horizons非负，noise history/segment是实际连续路径。不存在causal/restart/解唯一性结论前提；common AE全real参数证明来自同一连续zero-start样本与已接受all-time integral解。exceptional版本全路径事件不自动给逐点适应；Markov条件律/filtration/joint初值可测/密度/generator仍pending。

## 2026-10-05 actual future Wiener law/历史独立依赖
标准有限Nc vector Wiener定义的Gaussian/mean/covariance/AE连续；任意确定S≥0，真实continuous-path law horizon T≥0；auxiliary real Langevin需C² U/global forceLip/unit mass，任意γ/σ。实际future Gaussian law、与整个过去独立和history joint AEm均derived，不作假设；实际periodic全历史用同一投影模型，代表独立主模型沿用C∞lattice-periodic U。无stopping-time或strongMarkov陈述；completed filtration/适应性/随机初值joint连续、transition密度/actual generator/Harris未计完成。

## 2026-10-05 actual initial/path联合可测依赖
真正同一W积分解可用不同初值x/y，C² U与actual force globalLip、unit-mass finite Nc、T≥0/t∈[0,T]，任意γ/σ。periodic endpoint descent需实际C∞ lattice-periodic U及已接受任意rep独立，无需chosen rep连续/可测假设。随机初值AEm是明确必要输入，endpoint AEm/joint map均derived；可测性无需初值/noise独立假设。conditional Markov/filtration/generator/Harris未计完成。

## 2026-10-05 真实transition kernel/确定时间条件律
actual标准finite-dimensional vector Wiener；unit mass、finite Nc、S/T≥0及任意γ/σ。auxiliary real模型为C² U、显式force globalLip；periodic实际unit torus模型为C∞ lattice-periodic U，最后主结论推导globalLip并构造同一个全时间过程的条件律。kernel measurability/probability、actual endpoint law、未来与整个历史独立及条件Markov均证明，不作为输入；condDistrib所需IsProbabilityMeasure P在陈述中由hB局部绑定，并非新增假设。AE量词位于每固定S/T之后；无stopping time/强Markov/所有确定时间共同AE条件律承诺。completed filtration、density/generator/Harris仍待证明。

## 2026-10-05 actual transition semigroup依赖
与已接受真实Markov模型同一unit-mass/unit-torus/finite Nc、标准vector Wiener、任意γ/σ、S/T非负；real C² U/globalforceLip辅助模型，periodic C∞lattice U最后主结论derived forceLip。actual endpoint初值对所有noise paths，不只AE；概率转移族K0=id与Chapman–Kolmogorov皆derived，不把半群或随机解边缘factorization当输入。无需σ≠0即可成立；transition密度或可达另有条件。completed filtration/适应性/actual generator/Harris仍待证。

## 2026-10-05 actual completed过滤与适应性条件
finite Nc、unit mass/unit torus、真实标准vector Wiener、任意γ/σ、非负NNReal time。completed ambient为NullMeasurableSpace Ω P；每S过去由actual B(t),t≤S及全部原P-null subsets生成，不假设原Ω/原历史测度已complete。局部trim complete/AE一致、actual Cpath meas与同一全时间real/periodic解Adapted均derived。real auxiliary C² U/global forceLip显式，periodic C∞lattice U主结论derived Lip。未经证明right-continuous usual augmentation、completed-filtration conditional law/strongMarkov、progressive或实际generator；原样本与process不替换。

## 2026-10-05 actual completed过去独立性依赖
与真实completed Wiener过滤同一原P及actual B，不新增完成化独立性/联合law/可测性假设。原B为标准有限Nc vector Wiener、Cpath有原AE连续样本identity；F_S含所有原null subsets，其任一事件与actual Cpath history事件原P-AE相等。P.completion每集合概率与原P一致，真实未来独立从已接受Cpath law/history独立导出。actual real/periodic current state为已接受Adapted的同一过程；real C²/globalLip auxiliary，periodic original C∞lattice模型derivedLip。任意γ/σ、S≥0、T≥0 product law（Indep statement任意real T）；unit mass/torus/finite Nc。未宣称completed条件Markov/strongMarkov/progressive/generator/Harris。
## Actual completed-filtration deterministic-time conditional law (2026-10-05)
LangevinCompletedMarkov uses the same standard finite vector Wiener B/P and actual completed history F_S. History observation is literal identity into F_S; its law is P.completion trimmed to F_S. Completion probability mass is derived from hB, never assumed. Actual real model requires C² global force Lipschitz; periodic main statement C∞ lattice periodic U derives that bound. Real/periodic X(S+T) conditional distributions given the whole actual completed noise past equal the genuine K_T at X(S), for each fixed nonnegative S/T AE. True independence, restart, and joint measurability are proved inputs from accepted actual model dependencies; no Markov/canonical-kernel conclusion assumption. No right continuity, stopping-time strong Markov, generator/density/Harris completion. Finite Nc, unit mass and unit torus scope retained; responsible semantic review pending.
## Actual all-sample continuity / progressive measurability (2026-10-05)
LangevinProgressive keeps the same actual chosen integer-horizon global process. True Cpath restriction is consistent for every sample: continuous raw samples evaluate the same B, and all horizons on exceptional samples equal zero. Actual chosen endpoint restriction/uniqueness gives global/fixed-horizon endpoint equality and all-sample continuity; no probability assumptions for that pathwise result. The true Wiener model's accepted completed-filtration Adapted then implies IsProgressive of the same real/periodic process. C² U/global force Lip for real auxiliary model, original C∞ lattice periodic U derives the bound in the main model. Finite Nc, unit mass/unit torus scope. No supplied continuity/progressive conclusion; no right continuity/stopping-time strong Markov/density/generator/Harris claim; responsible review pending.
## Actual canonical weighted divergence and density cutoffs (2026-10-05)
CanonicalTemperature is a necessary proof dependency of original Proposition6.1, printed222/PDF243, using the same actual 2Nc-dimensional SymplecticCoordinates, existing Gibbs weight, true Lie derivative G·∇H and trace divergence. H/G C1 where used; arbitrary real β algebraically, positive R in cutoff flux integrability, actual Gibbs integrability and explicit uniform bound on weighted G. Uniform bounded interpretation of the original third item needs semantic signoff; it is not silently replaced by weighted-field L1. True compact-field derivative/divergence integrals are derived from fixed Haar integration by parts, not supplied. Density-cutoff L1 is derived by domination with C exp(2R)ρ; no original weighted-field L1 assumption. Full-space L1 divergence theorem, density-cutoff limit, β=(kBT)^-1 and final temperature ratio remain to be proved, and full Proposition6.1 is not accepted. No unit-mass/torus restriction imposed on this full-phase-space arbitrary H dependency.
## Proposition6.1 actual full-space canonical temperature (2026-10-05)
CanonicalIntegrationByParts derives the full-space Gibbs integration-by-parts identity and physical temperature ratio from actual H/G C1 on real 2Nc-dimensional SymplecticCoordinates, actual integrable Gibbs weight, both weighted observables integrable, positive canonical divergence average, and an explicit uniform bound on weighted G. kB/T positive, β=(kB*T)^-1. The original numerator positive-absolute-value assumption is redundant: actual signed numerator positivity is derived by the true IBP identity. No original weighted-field L1, no per-partial global L1, no boundary flux/IBP/ratio conclusions assumed. Two actual smooth cutoff/DCT limits prove the entire identity. The printed division by ball volume is replaced with this actual proof. The third item's uniform bounded interpretation and corrected proof require responsible semantic signoff. Coordinate Pi norm is used for uniform boundedness in finite dimensions; actual trace divergence and directional derivative are proved literal coordinate sums. Nc=0 auxiliary identities remain valid, but positive divergence average excludes the degenerate empty-coordinate target case. All masses are represented by arbitrary actual H; no unit-mass/torus restriction.

## 2026-10-05 BrownianDirichlet实际假设
有限Nc，config=FinNc→R，full Icc0 1 Lebesgue基本cube，真实所有整数格点periodicity，U/f/g C∞；β≠0为IBP与normalized identity；positive β与每个m_i>0为nonpositive及real eigenvalue结论；real eigenfunction满足actual generator equation ∀q，真实restricted-volume AE非zero，weighted norm正性已推导而非假设。arbitrary positive diagonal masses，无单位质量限制。正式quotient Haar/Gibbs概率测度对接、C²/closed-domain self-adjoint realization、compact resolvent/gap/semigroup期望仍后续。原(5.6)印刷190/PDF211目视已确认time t演化分布平均，非(5.9)轨道长期平均。

## 2026-10-06 BrownianTorusGibbs真实模型
unit torus=UnitAddTorus(FinNc)，normalized circle Haar=AddCircle.haarAddCircle且Pi product；projection fromfull realcube不是替换域。可测代表由actual measurableEquivPiIoc，不是随意quotient choice。U C∞且integer-lattice invariant推实际ρ integrability/normalization，βany的Gibbs概率性真正已证；periodic smooth f/g actualBrownian same generaldiagonal masses；β≠0/β,m正条件沿用原真实Dirichlet/nonpositive。Haar default mass T与normalized convention在T1由definition true equality处理。无compact support real-lift特例，无actualsemigroup invariance/closed selfadjoint conclusion。

## 2026-10-06 BrownianHilbertCore实际条件
same finite unit torus/actual Gibbs probability，real periodic continuous obs真continuous quotient，chosen representative只measurable；actual MemLp2与sameµ AE解释已推导。U C∞/integer periodic，f/g连续嵌入在Continuous+periodicity，generator在C∞；all diagonal masses。真正HilbertL2 inner/norm回到same canonical cube integral，actualdensity/fullsupport与embedding injectivity推导。L² eigen要求same实际image=ℓactualvector/nonzerovector，非谱结论作假设。β/m正及β≠0只在对应结论；实际unbounded domain/closed谱/gap/semigroup未证。

## 2026-10-06 BrownianSmoothDomain实际条件
实际有限unit torus与同一Gibbs Hilbert L²，U C∞/整数periodic；domain是所有C∞周期实lift的真embedding.range，单射已推导。任意diagonal m；β≠0给Dirichlet/symmetry，β>0/各m_i>0给nonpositive。没有假设domain density、operator closure/selfadjointness、gap或任意谱结论。C∞ core不冒充原C²闭算子。

## 2026-10-06 BrownianSmoothDensity实际条件
Finite Nc，actual unit torus/同一normalized Gibbs measure，U C∞ integer periodic，β任意；所有C∞ periodic real lifts的genuine domain。actual compactness/概率性/weak regular和Fourier span dense来自已证明结果；没有附加density/谱/closure/selfadjoint/gap前提。质量不参与density。实际CM满射/AE身份及original quotient/lift都推导。

## 2026-10-06 BrownianClosedOperator实际条件
实际finite unit torus/同一normalized Gibbs L²；U C∞ integerperiodic；arbitrary diagonal m，β≠0用于symmetry/closability/genuineclosed realization，β>0/各m_i>0用于nonpositive。actualdense/fullsupport/operatorinjectivity已证明；没有把closed extension、可闭性、graphclosure、closed-domain对称非正/selfadjoint/gap作为模型假设。最小closed-extension定理的S.IsClosed和T≤S是该最小性关系的正常量词前提，不参与原算子可闭性证明。闭包选择就是原smooth operator graph closure；selfadjoint仍缺独立证明。

## 2026-10-06 BrownianGibbsBounds实际条件
actualfinite unit torus/normalized Haar与sameµ，原U C∞ integerperiodic；βany，本批无mass限制。M是真原U descended ContinuousMap norm，所有weight/Z/densitybounds与integrability均derived，不带bounds/Poincare/gap/modelreplacement前提。g为torus连续实观测，积分比较时g非负，平方/norm比较自动非负。实际Hilbert norm²与weighted积分由sameµ AE identity证明。

## 2026-10-06 BrownianVariance条件
samefiniteunit torus/normalized Gibbs µ，U C∞integerperiodic、βany，g actualcontinuousreal。概率/compact/MemLp/fullsupport derived；无variance identity、minmean、varzero常数性或gap前提。actualHaar辅助variance不替换主µ。

## 2026-10-06 BrownianFourierDifferential条件
Nc任意自然数、n为全部整数坐标index、q为完整Euclidean配置空间；实际UnitAddTorus及其quotient projection未改。未假设频率下界；n≠0只用于从整数平方和导出≥1。辅助Haar Laplace只是同一literal生成元m_i=1/U=0/β=1用于真实Haar Poincare依赖计算；主一般正对角质量与势能Gibbs结果不能由此特例宣称完成。真实C∞、periodicity、partials及mFourier对应关系全证明，不添加项目公理或目标结论假设；负责人semantic pending。

## 2026-10-06 BrownianFourierCoefficient条件
Nc任意，全smooth integerperiodic真实Euclidean f；实际torus full normalized Haar，辅助原literal generator m1/U0/β1为Poincare依赖。MemLp2/continuous/AE与积分系数恒等式全部推导，不作假设。能量literalΣactualpartial²；无HaarPoincare/gap premise，原一般positive mass/周期势能Gibbs主模型及selfadjoint仍独立未完成，负责人pending。

## 2026-10-06 BrownianHaarPoincare条件
Nc任意，全C∞ integerperiodic f或actualtorus CM g且原quotient Euclidean lift C∞；真实normalized Haar mean/variance与actualcoordinate gradient，不供应Poincare/frequency/Parseval假设。实际mean0只为中间subspace bound，最终一般方差界无mean0前提；包含Nc0。原Gibbsvariance connection沿同一U C∞periodic/βany actualmeasure，未实现一般mass加权GibbsPoincare或谱gap，负责人pending。

## 2026-10-06 BrownianGibbsPoincare条件
Nc任意，原每m_i>0、U C∞integerperiodic，g actualtorus CM且原quotient Euclidean lift C∞。同一µ，Poincare βany，originalgenerator coercivity β>0。M=1+Σ|m|、A=|β|实际potential CM norm、C=exp4A M/(4π²)、κ=(βC)inv均derived positive（κ要求β>0）。不假设Poincare/density/mass bound、gradient identity或gap。actualmean0只为最后core meanzero coercivity，完整variance inequality无mean0前提；closed/selfadjoint/spectrum仍独立未完成，负责人pending。

## 2026-10-06 BrownianClosedCoercivity条件
真实sameµ fullL²、actualsmoothdomain及其已证明graphclosure。Ncany、originalmass每mi>0、U C∞integerperiodic、β>0给closed强制性/kernel/realpoint-eigen separation。orthogonality由actualconstantzero/formalsymmetry推导（非零real eigen）、closedzero relation/eigenrelation只是被讨论向量定义条件，不供应κ bound/自伴/谱existence假设。κ=(βC)inv已证positive，constantone真实norm1。所有graph/continuous/AE/variance对应都证明；source单一声明800k heartbeat仅资源预算，不禁内核检查/不unsafe。full spectrum selfadjoint compactresolvent未完成，负责人pending。

## 2026-10-06 BrownianMassFourier条件
Nc任意整数Fourierindices和原finiteunit configurationtorus，必要Haarauxiliary U=0但全部originaldiagonalmass m/β保留。literal eigen公式不要求masspositive/βnonzero；formalDirichlet/coeff/energyParseval β≠0，freqpositivity/derivedlower/finite sublevel/decay每mi>0且β>0。原observables C∞integerperiodic。真实M=1+Σ|mi|和c=βinv4π²Minv derived，不供应freq/Parseval/finiteness/gap/ellipticregularity。未完成实际selfadjoint/resolventcompact，原U Gibbs主模型仍独立保留，负责人pending。

## 2026-10-06 BrownianGroundState条件
Nc任意、所有原质量m任意；实际U C∞，周期性/actualCMnormbounds需要originalintegerperiodic，literalconjugation β≠0，因子/normalizeddensity/integralidentity β任意。全部actualpartials/真实exp/samepartition和sameµ未改；不供应conjugation/derivative/boundedpotential/isometry或selfadjoint前提。标准fixedkernel no新axiom，actualfullLponto与域共轭尚缺，负责人semanticpending。

## 2026-10-06 BrownianGroundStateIsometry条件
Nc任意、U C∞integerperiodic、β任意，同一originalµ/normalizedHaar fullrealLp2。normalizedfactorpos、inverseCM、CMLinearEquiv、normidentity与denseRange全部derived；固定extendOfIsometry产生真正全空间等距满射，不供应measureequivalence/onto/isometry或结论假设。尚未识别operator/smoothdomain/closedgraph、自伴/compact，负责人semanticpending。

## 2026-10-06 BrownianGroundStateCore条件
Nc任意、originalm任意、U C∞integerperiodic，真实normalizedfactor/inverse/smoothEquiv及range/Hilbertembeddings β任意；generatorconjugation β≠0。所有实际sqrtZ正性/逆/域互映/线性和sameHilbertcore公式derived，不供给domain/elliptic/selfadjoint/compact前提。真正全部smoothdomain保留，wholeclosedgraph尚未识别，负责人semanticpending。

## 2026-10-06 BrownianGroundStateGraph条件
Nc任意、原m任意、U C∞整数周期、sameoriginalµ/actualHaar全L²。实际域/embedding/密性构造β任意；partial/closed graph共轭与formaladjoint/closable闭性需β≠0；整个Haarclosednonpos每mi>0且β>0。所有域唯一lift/图两个方向/图closure保持/伴随和可闭性均证明，不提供这些结论或ellipticregularity为前提。自伴/实际compact/full谱存在仍未证明，负责人pending。

## 2026-10-06 BrownianFourierHilbert条件
Nc任意，sameactualfullreal/complexHaarLp2；m/β任意，U0仅masspart必要依赖。trueJ/R/左逆/norm/基底重构/模式与实际partial微分均derived，不供应orthogonality或diagonal假设。最后graph_tendsto的x/y真实coeff关系显式作为条件性逼近引理前提；将从adjoint测试推导后才计selfadjoint，不把它当原定理前提。无新axiom/占位/unsafe/linter绕过。原Gibbs自伴compact/full谱仍未完成，负责人pending。

## 2026-10-06 BrownianMassSelfAdjoint条件
Nc任意、原质量m任意、β≠0、U0只为原一般U groundstate后质量部分必要依赖。实际全realHaarLp及完整C∞periodicdomain；密性/形式对称/闭性与trueFourier加权图关系均derived。主selfadjoint和essentialselfadjoint中所有伴随域coef关系从actualadjoint定义与真实smooth测试推导，不供给coef/regularity/自伴前提。每masspositive与βpositive将在compactresolvent/原正文模型使用；本批不需要它们。负责人pending，原Gibbs一般U定理整体未完成。

## 2026-10-06 BrownianPotentialOperator条件
Nc任意，原m任意、U C∞整数周期、β任意，真正sameactualHaarLp2。V的真实CMsupbound/actualL∞/HolderLp乘法/全对称与正则周期和图homeomorph均derived，无有界/乘法/图对应/自伴前提。原Gibbs量与同一V literalformula保留。尚未识别原一般U完整closedgraph为boundedperturbation，负责人pending，原正文定理整体未完成。

## 2026-10-06 BrownianPotentialSelfAdjoint条件
Nc任意、原质量m任意、原U C∞整数周期、β≠0，sameactualoriginalGibbs fullrealLp2。真正boundedV/wholegraph双向identity/闭域相等和actualadjoint均derived，无图域对应/自伴/正则性结论前提。masszero-potential只为必要masspart，其后完整originalU与sameµ传输证明。原教材C²test与C∞core闭包最终语义负责人pending；positive masses/β在原正文与之后compact/coercivity使用。自伴只为原已构造smoothgraphclosure，compact完整谱/semigroup未完成。

## 2026-10-06 BrownianFourierCompact条件
Nc任意、所有原质量m_i>0、β>0；actualsamewholecomplex/realHaarLp2。真实frequency来自原massdifferential，real/complex HilbertBasis、权重bounds、cofinite decay、每个finiteCLM compact与norm convergence均derived。private条件tailbound在主limit中实际由finite bad-index推导，不供给compactness或resolvent前提。U0质量部分是一般原U compactresolvent必要依赖；本批仅actualcompactCLM，未称actualclosedmassresolvent。负责人pending，wholeTheorem6.1未完成。

## 2026-10-06 BrownianMassResolvent条件
Nc任意、原每个m_i>0、β>0、samewholeactualHaarLp2。原freqnonneg、真实r代数/closedness/fullsmoothgraph/frequencycoef关系与actualRcompact均来自原算子已证链。没有实值保持、resolvent、domain对应、graphlimit、inverse结论前提；任意x与整个原closedgraph双向对应真derived。U0质量部分只为原generalU必要依赖；generalU compact/full谱未完成。C²/core最终负责人pending。

## 2026-10-06 BrownianGraphCompact条件
Nc任意、原每m_i>0、U C∞整数周期、β>0，sameactualwholemass/HaarU/originalGibbsclosedgraphsubtype，productnorm inherited。actualboundedB/sameµ isometry/wholeclosedgraphiff/actualMasscompacttwo-sidedresolvent均由已验收原数据derived，不供给compact embedding或graph/domain/resolvent结论前提。真实generalU graph投影紧不等于一般U预解存在，后者仍需真实onto inverse证明。负责人C²core pending，完整正文定理未完成。

## 2026-10-06 BrownianGibbsResolvent条件
Nc任意、每个原m_i>0、原U C∞整数周期、β>0，sameoriginalGibbs measure/fullrealLp与actualfullsmoothgraphclosure。真实GibbsA nonpos/selfadj/closed及wholegraph compactprojection来自原已验收链；Srangeclosed、onto、inverse与Ractualcompact/norm均derived，没有graphnormbound/rangedensity/rangeorthogonal/onto/resolvent结论前提，没有模型替换或新regularity假设。C²test/C∞core负责人pending，原whole谱与evolution仍未完成。

## BrownianResolventSpectrum: original whole Gibbs Hilbert eigenbasis
保留原m_i>0、U C∞整数周期、β>0、原sameGibbs fullrealLp与actualwholeAgraph；R实际compacttwo-sided inverse已证明而非前提。本批所有whole eigenspaces/finite multiplicity/dense complete Hilbert eigenbasis从actualcompactR/selfadj/nonpos推出，不假设basis/domain/eigenvalues/谱complete。Nc任意包含Nc0，使用Sigma(ℓ;Fin actualfinrank)不伪造永远无限的ℕ序列。完整展开与Parseval真实；全谱枚举及unbounded spectrum/evolution尚缺。原C²test与C∞fullcore语义负责人pending；无sorry/admit/newaxiom/unsafe/资源或linter绕过。

## BrownianEigenGraph: genuine whole graph/domain coefficient characterization
原positive m/U C∞整数周期/β>0/sameGibbs entireLp保留。fullbasis和实际Agraph已从truecompactresolvent推导，graph/domain充分性由fullseries+closedgraph+逆isometry证明，不额外假设domain、完整展开或加权operator模型。weightedMemℓp为等价条件非隐藏domain结论；原Nc任意。actualMarkov positivity/SDE law识别与evolution及谱枚举/整谱仍缺，C²/C∞core最终语义pending；无占位/axiom/unsafe/资源绕过。

## BrownianSpectralEvolution: actual whole Gibbs C0 contraction semigroup
原m_i>0/U C∞整数周期/β>0/sameactualGibbs fullrealLp，timeNNReal实际≥0。exp eigenweights界、wholeC0normcontinuity、actualsemigroup/graphpreservation从已验收真实fullbasis与wholeAgraph刻画推导，不以semigroup/C0/weightbound/Adomain/生成元结论为假设。此阶段actualstronginfgen identity及Markovpositivity/SDEprobabilityexpectation未验证，不称已完成真实随机轨道定理；谱枚举/whole-spectrum/core语义pending。Nc0兼容，不伪造无限index；无newaxiom/unsafe/占位或资源限制修改。

## BrownianSpectralGenerator: full actual generator identification
保留原m_i>0/U C∞整数周期/β>0/actualsameGibbs fullrealLp/NNRealpositive righttime。actualT由真实A整个Hilbert本征基构造并已证C0contraction，现全originalAgraph⇔actualstrongdifferencequotient limit：allx y不加domain/eigenassumptions，domain在⇐方向从truewholegraph刻画推导，⇒只用originalactualgraph是完整生成元定义而非藏结论。scalarpointlimit/DCTbound/stronglimit完整证明，不假设generatoridentity或derivlimit；Markovpositivity/SDEprobabilitylaw与expectation/谱枚举整谱及C²/core语义仍pending；无占位/axiom/unsafe/资源绕过。

## BrownianSpectralDecay: actual whole-space exponential equilibrium decay
保留原m_i>0/U C∞整数周期/β>0/actualsameGibbs fullLp/NNRealnonnegtime；T actualstronggenerator=A整个closedgraph已证明。e真正normalizedconstant/Ae0，wholekernel1dim、fullbasis/gap均已derived；指数rate实际κ来源originalGibbsPoincare，未给任意rate或convergence/orthogonalcomplete/kernelconstant结论假设。范数结论全Lp，相关函数结论真Hilbertinner products；actualSDE probabilityexpectation/Markovpositivity尚未识别，不给density-law结论。谱枚举/整谱和C²test/C∞core最终owner语义仍pending；无占位/axiom/unsafe/资源更改。

## BrownianResolventRealSpectrum: entire actual compact R real spectrum
原positive m/U C∞整数周期/β>0/actualsameGibbs entireLp。realSpectrum是真Mathlib Banach CLM spectrum；nonzero spectral point iff actualeigenvalue由provedcompactR+fixedFredholm得到，不以purepoint或谱complete假设。actualAgraph与真实κeigenbound推derivedR wholegap，actualconstantnorm1/trueRinverse证明真实spectral1。对象是boundedR整个realSpectrum，unboundedA realresolvent identification/复杂谱枚举与Markovpositivity/SDEprobabilityexpectation尚缺，C²/core语义pending；无placeholder/newaxiom/unsafe/资源绕过。

## BrownianGeneratorRealSpectrum: actual whole unbounded-generator real spectrum
原 m_i>0、U C∞ 整数周期、β>0、同一 Gibbs entire real Lp。实预解集仅以实际 bounded two-sided closed-graph inverse 定义；其存在性通过真正 R 和 bounded bridge unit 推导，不是假设 generator domain、谱离散或结论。使用两側逆的 isUnit_iff_exists，不使用无限维 CLM 上未经证明的单侧逆性质。非零标量 (1−ℓ) 的 algebraMap unit 给真正全实谱对应；Fredholm 与实际 eigenspace 构造推真实纯点实谱、整个非正/谱隙/零存在和任意实际移位逆紧性。未声称复谱或 actual SDE probability identification；枚举和原 C²/core 最终语义 pending，无 placeholder/newaxiom/unsafe/限制绕过。

## BrownianEigenDiscreteness: genuine finite spectral levels and closed discrete whole real spectrum
保留 original positive masses/U C∞periodic/β>0/actual sameGibbs whole realLp。所有有限层、基索引与实谱可数性、cofinite趋零和趋负无穷、closed/discrete 谱由真正 compact R、实际 graph/basis/spectrum 证明，不加入 finite/Countable/Infinite 结论前提。每谱值重数来自既有真实 finiteDimensional eigenspace。Nc0允许有限索引和可能底cofinite，不声称自然数无限枚举或其真实逃逸。尚未复化全复谱/正维有序枚举/Markov正性/SDElaw expectation，C²/core最终负责人语义pending；无placeholder/newaxiom/unsafe/限制绕过。

## BrownianEigenEnumeration: proved positive-dimensional infinitude and genuine complete sequence
仅将 0<Nc 作为无限维结论真实适用维数条件；正质量/原 U C∞periodic/β>0 与原 entireGibbs 不变。Infinite/Denumerable/整个谱无限/λ_n escape 均由实际 Haar实虚满射、真实 Fourier 独立、wholeGibbsHaar unitary、实际完整本征基和既有有限谱层推导，无结论入假设。ℕ 双射覆盖全部索引及重数；未假定或声称排序与首模式。Nc0此前 finite/cofinite statement保留，未强行无限化。复化Hilbert空间用于无限维依赖，不等于证明A复谱。真正 Markov/SDElaw expectation及原C²/core最终semanticpending；无placeholder/newaxiom/unsafe/限制绕过。

## BrownianEigenOrdering: proved ordering and simple zero eigenvalue
仅原hm>0、原C∞整数周期U、β>0和无限序列适用的Nc>0。真实有限谱层、Infinite、OrderBot、NoMax、排序、zero-simple、λn非零和谱隙全部推导，不藏入假设。ℕ实际双射覆盖全部模式及重数；同一整个Lp真实T对所有x,t提供有序展开，未假定SDE期望等于T。零空间=span实际归一化常数及finrank1允许Nc0。φ0相位未选定，未声称φ0=e；复谱/Markov/SDElaw概率识别及C²/core最终semanticpending。无placeholder/newaxiom/unsafe/限制绕过。

## BrownianSpectralAverage: actual analytic integral averages, probability identification kept separate
原sameGibbs entireLp、原正质量/C∞整数周期U/β>0不变；无Nc>0要求，解析平均包含Nc0。初始ρ的实际integral=1仅真实初始质量条件；一般质量结果不需要此条件。ρ与Tρ非负、Markov核、SDElaw/PDE识别均未假设或声称。本批真正积分可积性、原T质量守恒、对偶、真实canonical积分极限、严格正K/α和全部tests/t的指数估计已直接推导，无结论作前提。原文(5.6)真实时变概率law仍独立pending，复谱与C²/core语义pending；无placeholder/newaxiom/unsafe/资源或linter绕过。

## BrownianGibbsComplexification: genuine same-measure entire complex L2 and complete mode basis
complexify/re/im/AE/whole decomposition/norm及inner保存无需正维或新模型假设；使用相同原Gibbs measure，不替换为Haar。完整complex基依赖原hm>0/U C∞periodic/β>0已接受全real本征基；dense complex span真正由全real HasSum和actual complex decomposition推导，未假定完备性/密度/谱完整。Nc0合法。尚未定义复原A graph或证明其complex spectra、也未假定SDElaw、Markov正性或期望识别，原C²core负责人语义pending。无placeholder/newaxiom/unsafe/资源或linter绕过。

## BrownianGibbsComplexOperator: proved actual complex graph equivalence and full-domain self-adjointness
原hm>0、原U C∞integerperiodic、β>0及actual sameGibbs entirecomplexLp，无正维假设。全模式coeff graph确切等于原real A的re/im两图；verticalzero、complex-linearity、closed、dense、weightedℓ²domain、所有mode真图、全形式伴随和真实IsSelfAdjoint均由已接受真实原real graph与完整complex基推导，不作前提。Submodule.toLinearPMap真实非junk图由唯一性证明。没有把IsSelfAdjoint当整复谱及compact resolvent证据，后者仍下一；真实Markov/SDE概率识别与原C²core负责人语义pending。无placeholder/newaxiom/unsafe/资源或linter绕过。

## BrownianGibbsComplexResolvent: actual entire compact two-sided inverse proved
同一actual original Gibbs measure/wholecomplexLp、原正质量/原C∞整数周期U/β>0，无Nc>0。actualrealR作为已接受真实原生成元inverse使用，不引入外部inverse假设；C complex-linearity、连续、紧性、两方向whole graphinverse全部构造/推导。1−λ nonzero由实际λ≤0推出，不添加条件。没有把compact或point spectrum当整复谱已证明，整complex spectrum仍下一；SDE概率law及原core负责人语义pending。无placeholder/newaxiom/unsafe/资源或linter绕过。

## BrownianGibbsComplexSpectrum: genuine entire complex spectrum proved
同一原Gibbs wholecomplexLp、原positive masses/原C∞periodic U/β>0，不要求Nc>0。双边closedgraphinverse定义、unit等价、真实非零谱变换、compact Fredholm及全部模式完整性均证明，没有假定整谱=point spectrum，没有用某模型特例替原U。任何actualinverse紧性结论仅使用该B真inverse图条件。全部real谱、负κgap、有限层与closed来源是先前真实证明。SDElaw/Markov正性/式5.6概率识别及C²/C∞ core负责人签核继续pending；默认资源/linters，无占位、新公理或unsafe。

## BrownianEigenNormalization: entire ordered bases with genuine phi-zero equals one
同一原Gibbs measure/whole real-complex Lp、原positive masses/原C∞periodic U/β>0。0<Nc仅用于实际无限ℕ全mode枚举；r*r=1/首mode是constant/新real与complex基完整性全部证明，不新增sign/unit phase/完整性假设。实际原A/A_C graph与T均不换模型；旧truebasis/真实kernel/coefficient/API结论复用。概率law/Markov正性/式5.6识别及C²/C∞ core负责人签核独立pending。无sorry/admit/newaxiom/unsafe/资源或linter关闭。

## BrownianComplexKernel: actual entire complex constant kernel and explicit smooth-model spectral conclusion
同一原m/positive masses、原C∞integerperiodic U/β>0，真实原Gibbs整个complexLp；kernel不要求positiveNc，完整ℕ谱汇总显式positiveNc且依赖真实无限性。complexkernel/span/finiteDimensional/finrank1全推导，κpositive从真实Gibbs coercivityrate证明使用，无新核或谱假设。光滑正则性C∞比教材C²的语义依赖继续待负责人最终签核，不把smooth parts当全正文Theorem6.1完成；真实SDElaw/Markov positivity/式5.6概率识别独立未证。无placeholder/新公理/unsafe/资源或linter关闭。

## BrownianSDECoefficients: actual model coefficients at original gamma-one generator
原positive masses/beta>0/C∞integerperiodic U，Theorem6.1的gamma1原generator，非6.46的M=I特例。inverse-mass mobility与noise定义原全部coordinates；positivity/covariance/原sqrtmass因子实际证明，Lipschitz从真实periodic force得出无额外driftLip前提。基础Lip和factor identity允许更一般totalinverse参数是必要helper，不据此主张无positive-mass的物理模型。纯sum differentialexpression恒等不等于actualSDElaw的stochasticgenerator识别；未来noisePath/measurableFlow/概率识别及C²core负责人仍pending。无placeholder/newaxiom/unsafe/资源/linter绕过。

## BrownianDrivenExistence: actual specified-interval continuous-noise existence constructed
原positive masses/原C∞integerperiodic U/β>0、gamma1，T≥0及W ContinuousOn实际[0,T]，任意original lift初值x，不假定roughW可微或路径解存在。privateuniform-local/finiteODE拼接已真实证明（复用原验收source），actualdriftLip由原potential推出，positive physical covariance由hm/hβ导出。低层field存在本身对任何固定系数成立；主integral theorem随原positive covariance明确physical模型条件。每个specifiedT构造真实α/q，不假定globalhorizoncoherence/measurability/Markov。所有这些以及law=T/式5.6/C²core负责人继续pending。无sorry/admit/newaxiom/unsafe/资源或linter绕过。

## BrownianPathSolution: true original-mass integral solutions and jointly measurable selected endpoints
主selectedpath/endpoint保持原positive masses、U C∞integerperiodic、β>0、gamma1、T≥0、Nc含0，W是真C(Icc0T,Vec)。低层uniqueness/estimates不需covariance正性：固定Σ即可，driftLip由真实U原条件推出；无需W可微或W0=0，实际noiseincrement中心化。q存在/唯一性/右导数/endpoint连续可测均已推导，未作前提。privateFTC复制原已验收actualintegral右导数；genericCPathcarrier复用，不混两种equation。关键GronwallK=1+derivedL>0，constantpotential情形有效。未称randomlaw/Markov/5.6/stochasticgenerator、wholeTheorem6.1或C²core完成；负责人pending。

## BrownianRandomModel: actual same global Wiener-driven path and genuine time law
原positivegeneral masses/C∞integerperiodic U/β>0/gamma1，Nc含0，actualvectorWiener B与其jointGaussian/covariance/cont性质 hB。given真实标准Wiener是原随机方程输入，不是q解假设；实际randomq、uniquehorizon/global拼接、samefullmeasure allrealT、jointderivedendpointAEmeasurable、continuous与physicalnoiseeq全部推导。Probability主结论明确t≥0，并使用actualmap_apply与derivedAEMeasurable证明质量1，避免fallback误认。没有law=T/Markov/torus或stochasticgenerator输入；这些仍未证，C²core负责人和全定理/范围pending。finitecompensatedconstruction所有continuous样本支持Wienerincrements，不错误假定noise可微。

## BrownianMarkovModel: true deterministic-time completed-history Markov assertion
原positive masses/C∞integerperiodic U/β>0/gamma1/Nc含0和actualstandardvectorWiener B/hB，S,T非负确定时间。actualsameglobalq是已构造真实积分解；shift/restart/Adapted、jointendpointmeasurable、standardfutureWienerlaw与completedpast independence均来自完整证明，不作新前提。主conditional law是给整个actualcompletedWienerpast的condDistrib，明确P.completion及真正completehistory measurable space，不把仅路径restart称Markov、不扩大到stoppingtime或strongMarkov。privategeneric依赖原proof复制仅用于actualendpoint。仍未torusquotient、stochgenerator/SDElaw=谱T、C²core或全定理/范围；负责人pending。

BrownianTorusModel：同一UnitAddTorus配置空间，原positive general masses、U C∞及integerperiodic、β>0、γ=1，Nc含0；实际jointGaussian vectorWiener law及AE连续性已定义并使用真正证明的futureindependence，deterministicnonneg S/T。代表只可测，端点continuous由整数等变/openquotient推导。存在/唯一/Adapted/Markov/condDistrib不作输入假设。原C²与C∞核心差异及负责人的语义签核仍pending；actualstochasticgenerator/SDElaw与spectral T识别未证明。

BrownianTransitionSemigroup：与BrownianTorusModel同一原positive general masses/U C∞periodic/β>0/γ1/allNc/UnitAddTorus和actualjointGaussianWienerlaw，同一globalq与completedhistory真实conditionallaw；deterministicS/TNNReal，continuous torus observable在compactdomain有界。kernelzero/Chapman–Kolmogorov/Feller/期待合成线性收缩均推导，不置于假设。C∞vsC²语义签核、时间uniformC0、actualstochasticgenerator与谱T识别继续pending。

BrownianFellerContinuity：原positivegeneral masses/U C∞integerperiodic/β>0/γ1/allNc、sameUnitAddTorus和actualtrueWienerlaw；finiteT≥0，continuous torus observable。uniformhorizon Lipschitz、jointtime连续、CMap-Bochner概率期待identification和uniformnorm strongC0由原积分解/quotient/DCT真正推导，不作输入前提。全space actualprobabilityboundedlinearoperator不同于尚待识别的Gibbs谱T，不自动声称wholeLp extension或Gibbsinvariant。C²vsC∞core负责人及actualstochgenerator/谱T/5.6算子识别pending。

BrownianSmallTimeEstimates：actualjointGaussian vectorWiener/P，原m_i>0/β>0/γ1/generalNc，noiseallfiniteorderLp和actualmoments仅用真实Wiener及原Sigma，原periodicC∞U供应deriveddriftbound/L。任意IntegralSolution辅助估计明确输入原积分方程，但sameactualglobalq AE定理复用真正全time已构造解且不需要外加path存在/位移/error假设。drift integral trueintegrability同时证明；sqrt-time期待由actualvariance及moment推导，noisebounds不是模型假设。实际高阶noise时间缩放、实际q期待误差/概率generator与原谱T及5.6算子识别未证明；C²vsC∞负责人pending。

BrownianExpectationEstimates：m_i>0/β>0/γ1/generalNc，U C∞ integerperiodic，原 genuine vectorWiener B/P。全部实际端点/同一 q 原 allhorizon solution/history、真实 drift bound/L、noise first moments 使用已接受依赖；真实 AEstrong time×Ω/product finite measure/trueprobability integrability与Fubini明确证明，不作为模型假设。clamped max0t只用于连续期待参数延拓；actual firstmean derivative声明是非负时间右导数。frozen error actual original Sigma B_t，真实期待rate由真实productintegrability和moment bound导出。尚未 whole probability generator/spectralT/5.6/operator equality；C²vsC∞ core负责人pending。

BrownianSecondMomentEstimates：原m正性/β正性/γ1/任意Nc、U C∞integerperiodic、genuinevectorWiener B/P及已构造sameglobalq。boundedDrift/allhorizon actual解和trueSigma moments已验依赖；D AEbound及Lp和actualdelta finiteLp/mixedsecond trueintegrability均证明，不当模型假设；secondproducterror和quotientlimit来自真实概率积分及derived M、C，全初值时间坐标统一。无whole stochasticgenerator或Gibbs谱T等同前提；实际高阶moment rate/Taylor余项仍待、C²vsC∞core负责人pending。

BrownianFourthMomentEstimates：原m正性/β正性/γ1/任意Nc、U C∞integerperiodic及真实Wiener B/P与sameglobalq。标准Gaussian和actualnoise第四矩可积、真实time sqrt pushforward、actualD bound与sameq Lp及原noisevariance均证明/已接受依赖；真正有限Pi norm和Holder推出所有highmoment rates，不引入highmoment/Taylor目标前提。原C²vs当前C∞core负责人及完整概率generator/spectralT/5.6/Gibbsinvariance仍pending。

BrownianObservableTaylor：原m正性/β正性/γ1/任意Nc、U和observable f C∞ integerperiodic、trueWiener B/P及sameglobalq。真实jets周期和compactcube导出全阶bound，真实多元Taylor积分和multilinear norm推cubicbound；truefiniteLp3/AEmeas/moment rate导出实际余项可积/期待及商极限。全阶bound/余项界及极限不作为模型前提；原C²vsC∞core、wholeactualgenerator/谱T/5.6/Gibbsinvariance负责人pending。

BrownianGeneratorExpectation：原正质量/β>0/γ1/任意Nc、U与f C∞整数周期、sameglobalq及真实Wiener/P。原partial/Hessian实际微分和finitecoord identity推导，actualf(q)/quadratic/Taylor项可积显式证明，再使用真正first/crosssecond/rem概率极限导出originalgenerator逐初值期待商。无generator/law/目标前提。wholeuniform CMap generator、概率operator=Gibbs谱T及5.6/Gibbsinvariance/Lp、C²core负责人签核未完成。

BrownianUniformGenerator：原m正性/β正性/γ1/任意Nc、U与f C∞整数周期、真实Wiener/P/sameq/UnitAddTorus actual概率C0 semigroup。原Df/Hessian共同bound、实际均值error/二阶covarianceerror/Taylorerror和sameq积分身份均推导。全初值uniformgeneratorerror及actualsupnorm generator极限是真结论，无目标/不变性/谱T识别假设。未声称wholeCMapgraphcore/actualprobability=Gibbs谱T或Gibbsinvariance/Lp extension。C²vsC∞负责人签核仍pending。

BrownianDynkinFormula：原positive masses/β>0/γ1/任意Nc、U/f C∞整数周期、truevectorWiener/sameP/q/UnitAddTorus/actual概率C0 operator。真实alltime rightderivative和Dynkin由强generator/实际semigroup/真实timecontinuous及Banach右FTC推导；积分可积及continuous evaluation明确真证明。evolveddomain只actualgenerator关系，不把evolvedf C∞、Gibbsinvariance/wholeLp operator/谱T等同作输入；C²core负责人及fullscope未完。

BrownianProbabilityGibbsImage：原positive masses/β>0/γ1/任意Nc、U/f C∞整数周期、same真实Wiener/P/q/actualtorus概率operator。同一Gibbsnormalized概率与真实ContinuousToLp复用，输入CMap，norm界是uniform输入。真实L2强generatorlimit、alltime右导数/Dynkin及closed原smoothcore值全部推导；不假设wholeL2-input概率operatorboundedness、谱T等同、Gibbsinvariance或evolvedf光滑。C²core负责人/fullscope未完。
