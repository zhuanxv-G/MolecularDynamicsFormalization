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
