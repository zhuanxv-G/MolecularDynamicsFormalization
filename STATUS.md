# Formalization status

## Completed

- Initial project layout, toolchain pin, and build/check workflow; the local check script passed on 2026-09-30.
- Minimal coordinate and model types in `MolecularDynamics/Notation.lean` and `MolecularDynamics/BasicDefinitions.lean`.
- Chapter 1 §1.2 definitions in `MolecularDynamics/Chapter01/NBody.lean`: `CoordinateMasses`, `diagonalMassMatrix`, `NBodyEquationAt`, `nBodyKineticEnergy`, and `nBodyTotalEnergy`.
- Nonnegativity of the kinetic term under coordinatewise nonnegative masses: `nBodyKineticEnergy_nonneg`.
- `Scratch.lean` retains the original API checks and contains the corresponding MathCopilot draft definitions.

## Verification

- MathCopilot reported successful managed Lean checks for the exported definitions.
- Local `lake build` passed on 2026-10-01, including the new `NBody.lean` module.
- Local `scripts/check.ps1` passed on 2026-10-01: the source scan found no `sorry`, `admit`, or `axiom`; `lake build` and `Scratch.lean` compilation both succeeded.
- On branch `chapter01-kinetic-energy-nonneg`, managed Lean checks pass for both `MolecularDynamics/Chapter01/NBody.lean` and the full local import closure of `Scratch.lean`, with zero errors and zero warnings.
- The MathCopilot shell used for those managed checks did not provide `lake`, `pwsh`, or `powershell`, so it could not run the post-change formal-project build and check script.
- After local integration of `nBodyKineticEnergy_nonneg` on 2026-10-01, `lake build` and `scripts/check.ps1` both passed, including `Scratch.lean` compilation and the source scan for `sorry`, `admit`, and `axiom`.
- The local integration checks used the repository's pinned Lean/mathlib `v4.34.0` and dependency manifest; MathCopilot's managed Lean/mathlib versions were not exposed.


### Local/CI acceptance workflow update (2026-10-01)

- The existing check entry now verifies configured and actual Lean/mathlib v4.34.0, scans sources including unsafe declarations, builds the library, checks Scratch, and audits imported project declarations against the standard logical dependency allowlist.
- The final local check passed at 23:20 +08:00 (exit 0, 8928 build jobs, 36 audited declarations). The key theorem depends on propext, Classical.choice, and Quot.sound. Eight isolated rejection cases behaved as expected; no formal mathematical source or dependency pin changed.
- Evidence, exact input hashes, and limitations are in [the step 3 result](docs/verification/2026-10-01-step3/RESULT.zh-CN.md). Machine success leaves responsible textbook semantic review pending; there is no new T1 proof or MathCopilot return in this batch.
- The existing CI configuration uses the same check and saves evidence artifacts. Commit 9587329 was pushed to the working branch and GitHub Actions run 36887786627 passed, including 8928 build jobs and 36 imported project declarations. Evidence is in `docs/verification/2026-10-02-remote-ci/`. This successful baseline CI does not validate later T1 source changes.

### T1 implementation (2026-10-02)

- Integrated `Chapter01/ParticleCoordinates.lean`: particle masses/vectors, particle-first coordinate equivalence, flatten/unflatten, repeated masses, particle kinetic energy, and 13 complete theorem proofs covering the 11 T1 specification IDs.
- Corrected the Notation comment to distinguish configuration coordinates from constrained degrees of freedom; included the new module in the project import root and added key axiom prints.
- Before integration, standalone fixed Lean 4.34.0 compilation passed with no diagnostics. All 13 theorem dependencies were the permitted standard logical axioms; the draft environment audit passed for 60 imported project declarations. The integrated full-project check also passed at 2026-10-02 00:26 +08:00: fixed versions, source scan, 8929 build jobs, Scratch and 60 declaration dependency audits. Evidence is in `docs/verification/2026-10-02-T1/`.
- Rechecked §1.2 printed18–19/PDF41–42: particle-first mass repetition, Euclidean norm, and coordinate/degrees-of-freedom distinction. The energy identity has no mass-positivity assumption; the reverse positivity bridge requires `0<d`.
- MathCopilot's subsequent read-only T1 review accepted all 11 IDs and 13 proofs. Its seven original reports were received and byte-checked locally on 2026-10-02. This does not certify the separate semantic-search/index configuration; responsible semantic sign-off is pending.
- T1 commit `c7d9778fe981c24ba7281db730206d1cfefbba4d` was pushed to the existing working branch. GitHub Actions run36894446209/job110477787074 succeeded, including the full check and evidence artifact11179876157. See `docs/verification/2026-10-02-T1/REMOTE_CI_RESULT.json`. A Git-input website review instruction is saved separately; the task has not been sent.

## Not yet formalized

- Maximal extension and global existence for the mechanical ODE. Local existence and local uniqueness under C¹ regularity at the initial state, plus interval uniqueness under a global Lipschitz field, are recorded below.
- Higher regularity of the force, potential and trajectory beyond the explicit derivative bridges.
- Time-trajectory Hamiltonian/mechanical equivalence beyond the static T3 identities.
- The maximal/global continuation argument and the full stability theorem. Energy conservation on open intervals for existing conservative solutions, momentum bounds, and given-interval confinement are recorded below.
- Chapter 1 §1.3 and later material.

## T2-L0 checkpoint (2026-10-03)

- Added `Chapter01/LocalTrajectories.lean` with fixed-mass continuous linear operators, their two coordinate identities, and both inverse directions under strictly positive coordinate masses. The module is imported by the project root.
- Standalone fixed Lean 4.34.0 compilation exited 0 with no diagnostics. The full `scripts/check.ps1` result and any CI result must be recorded separately; standalone compilation alone is not full-project acceptance. Responsible semantic sign-off remains pending.
- The completed L0 full check is recorded in `docs/verification/2026-10-03-T2-L0/`: fixed versions, source scan, 8930 build jobs, Scratch and 76 imported project declaration audits passed. It verifies the L0 snapshot, not later trajectory changes.

## T2 first-batch trajectory implementation (2026-10-03)

- All seven specification IDs now have complete proofs in `LocalTrajectories.lean`: L0, S1, B1–B4 and E1. The module contains five model definitions and fifteen theorem proofs including the B3 semantic layer and three solution helpers.
- Standalone fixed Lean4.34.0 draft compilation passed with no diagnostics and permitted standard logical dependencies. The initial B4 failure from an unexpanded function composition is preserved in `../tmp/t2-implementation-20261003/attempt01.log`; attempt02 passed after an explicit `Function.comp_apply` simplification.
- The complete integrated `scripts/check.ps1` passed: pinned versions, source scan, 8930 build jobs, Scratch and 93 imported project declaration audits. Evidence is in `docs/verification/2026-10-03-T2-first-batch/`; printed key dependencies only contain the permitted standard logical axioms.
- Commit `675fcaedbdef7b6ec57393c1ee99e9ca727da649` was pushed to the existing work branch. GitHub Actions run37039648187/job110946317955 passed the same full check, including 8930 jobs and 93 imported declaration audits; artifact11242095896 was saved. Remote metadata and the actual check log excerpt are in the same evidence directory.
- MathCopilot's earlier S1 proof request failed with the previous account's usage limit and returned no completed draft. This batch follows the received statement-review corrections, but independent website proof review and responsible semantic sign-off remain pending.
- The separate T5 chat completed its independent proofs and the small-perturbation initial-value generalization. Formal integration is recorded below.

## T5 barrier and conditional confinement implementation (2026-10-03)

- `PotentialBarriers.lean` now contains five definitions and twenty-five complete named proofs: the six general target statements, static energy exclusion, interval confinement for arbitrary initial positions inside the ball, a combined open-domain theorem, and quartic/constant/zero-dimensional/domain/radius boundary examples. The standalone draft has twenty-four named proofs plus a continuity example; integration gives that example a public theorem name.
- The independently compiled draft and its original log were rehashed locally and matched the final T5 handoff. All twenty-four printed dependencies were permitted standard logical axioms, with no errors or warnings. The exact initial-ball refinement was reviewed before integration.
- Formal full-project check passed at01:25–01:28: fixed versions, source scan, 8931 build jobs, Scratch and 128 imported declaration audits. Commit `9baf87f89d07138a95bfbfe1f37d45dd54946cf7` was pushed and GitHub Actions run37041343101/job110951942612 passed the same full check; artifact11242057946 was saved. Exact local and remote evidence is in `docs/verification/2026-10-03-T5-first-batch/`.
- The textbook's strict local minimum was visually rechecked at printed32/PDF55; printed33/PDF56 treats Hessian positivity as a sufficient condition. This batch does not assume that stronger condition. Website independent proof review and responsible semantic sign-off remain pending.
- Theorem1.1, maximal/global extension, and the full stability argument remain later goals; actual energy conservation, local existence/uniqueness, momentum bounds, and given-interval confinement are recorded below.

## T3 fixed-mass Hamiltonian implementation (2026-10-03)

- Installed `Chapter01/Hamiltonian.lean`, with five definitions and eighteen complete theorems covering the seven specification IDs and nine general goals. It reuses T2 operators and is imported by the project root.
- Checked frozen candidate SHA256 `89b808b5f181e6b388023dc25b604043ac1d1868eb2db971ea0e419e5fbba1ac` and unchanged T2 interface SHA256 `2867aa94d87c65afa6869d2f3bc552f828de797862e4ab334fd480044b535538` before installation. The installed header describes the formal module; mathematical statements and proofs match the candidate.
- Added explicit key theorem dependency prints to Scratch and the complete namespace audit. The integrated full check passed in `docs/verification/2026-10-03-T3-first-batch-retry03/`: pinned versions, source scan, 8932 build jobs, Scratch and 171 imported declaration audits. All dependencies are the permitted standard logical dependencies. The original nine goals and seven boundaries also passed against the installed module; their exact sources, logs and result hashes are in the T3 continuation directory.
- The preceding three unsuccessful checks are preserved: the elan launcher attempted an unavailable network update, one dependency lacked a process-local Git ownership exception, and the interrupted run compiled Hamiltonian but lost its top-level process with exit1073807364. None is represented as a successful full check; the retry03 actual result is the acceptance evidence.
- Local original-page review passed for the nine static goals after newly rendering and viewing printed18--19/PDF41--42 and printed24--25/PDF47--48. Responsible or senior reviewer final semantic sign-off remains pending.
- MathCopilot proof review has not been sent. The user reports that the website quota was updated, but both Browser versions still timed out on page control. External Edge launched; Computer Use then stopped because it could not reliably determine the current browser URL. Website review and remote CI remain separate from the successful local acceptance.

## T4 conservation and local existence checkpoint (2026-10-03)

- Integrated `EnergyConservation.lean`, `LocalExistence.lean` and `MomentumConservation.lean`, with the imports and key axiom checks in the project root, Scratch and `scripts/CheckAxioms.lean`.
- For an existing solution on an open time interval, strictly positive masses, differentiable potential and `F = -gradient U`, the mechanical Hamiltonian has zero derivative and is constant on that interval. The corresponding printed energy identity is on printed19/PDF42.
- A C¹ force at the initial position gives a local solution through a prescribed state on an open configuration domain containing it. C¹ regularity of the mechanical field at a common initial state gives equality of two solutions near the initial time; a separate theorem gives equality on a whole common open interval under a supplied global Lipschitz constant. No maximal flow or global existence is claimed.
- For particle-first coordinates, each component of total momentum has zero derivative and is constant when the sum of forces in that direction vanishes on the configuration domain. The printed momentum assertion is on printed19/PDF42.
- Integrated `scripts/check.ps1` passed at 13:56–13:59 +08:00: pinned Lean 4.34.0/mathlib revision, source scan, 8935 build jobs, Scratch and 182 imported declaration dependency audits. The key declarations depend only on `propext`, `Classical.choice` and `Quot.sound`. Evidence is in `docs/verification/2026-10-03-T4-first-batch/`.
- Independent MathCopilot review and responsible textbook semantic sign-off remain pending; remote CI for the later T4 snapshots is recorded below.
- The C¹ local-uniqueness follow-up was committed as `522f82de4863f9ef64f0a9a2f3cf3dbb8f02b1bc` and pushed. GitHub Actions run `37104591425` / job `111150531699` completed successfully; metadata is in `docs/verification/2026-10-03-T4-third-batch/REMOTE_CI_RESULT.json`. Independent MathCopilot review and responsible textbook semantic sign-off remain pending.
- `Equilibrium.lean` now connects a strict relative potential minimum in an open domain to the zero-momentum mechanical equilibrium. This is the first equilibrium dependency for Theorem 1.1; it deliberately does not claim Lyapunov stability or global continuation. The bridge subsequently passed its local and remote checks.
- The equilibrium bridge was committed as `4d55e405c665ddfd9fcc5d4d0de1084a3a691b04` and pushed. GitHub Actions run `37105793203` / job `111153920486` completed successfully; metadata is in `docs/verification/2026-10-03-T4-fourth-batch/REMOTE_CI_RESULT.json`.

## T4 momentum bounds and confinement follow-up (2026-10-03)

- Added `MomentumBounds.lean` and `MechanicalConfinement.lean`: five static energy/norm/compactness lemmas and two existing-solution confinement lemmas. The energy conservation input of the old conditional T5 result is now derived from the mechanical ODE.
- Newly viewed printed25--26/PDF48--49 and printed32/PDF55. Compact position containment, the explicit mass bound and the product maximum metric remain visible in the statements.
- The first standalone attempt was terminated without diagnostic output after a long wait; the second returned three proof errors from missing use of the pointwise positive-mass premise. Those were repaired explicitly. The integrated fifth full check subsequently passed and is recorded below.
- MathCopilot T2/T5 independent proof review is now actually running. The website acknowledged fixed commit 9baf87f and verified the 73702-byte input packet and all 14 byte/hash/Git-blob entries. Original reports have not yet been collected. Current attempt evidence is in `docs/reviews/2026-10-03-T2-T5-proofs/CURRENT_ATTEMPT.json`.
- Global/maximal continuation, the complete Theorem 1.1 and responsible human semantic sign-off remain open.

- Fifth full local check passed at 20:16:02--20:20:54 +08:00: 8938 build jobs, Scratch and 201 imported declaration audits, only permitted logical dependencies and stable input hashes. Exact times and SHA values are in the actual CHECK_REPORT.json. Remote CI for this new snapshot subsequently passed and is recorded below.

- The fifth-batch source commit 7c61e9d001887066bfa03771343ce91e7ce68ddb was pushed. Exact-head GitHub Actions run37122822014/job111202155182 completed successfully at20:28:11 +08:00. Metadata is in the fifth-batch REMOTE_CI_RESULT.json.

## Current snapshot (2026-10-03 22:09 +08:00)

- The current branch is `chapter01-kinetic-energy-nonneg` at HEAD `80fcbd63cf6b0508dce54ff10e47c4ac01947b6c`; the two commits after `7c61e9d` contain handoff/review documentation only. No Lean source, toolchain, or manifest diff was found between `7c61e9d` and HEAD.
- Chapter 1 is partially formalized and machine-checked through the T4 momentum/confinement batch, but not complete. The remaining mathematical core is maximal/global ODE continuation and the full Theorem 1.1 stability conclusion with its all-future-time bound; Chapter 1 §1.3 and later material are not formalized.
- This status query did not rerun `scripts/check.ps1`; the effective evidence remains the fifth-batch local exit-0 check and the exact-head remote CI success recorded above. MathCopilot independent review reports and responsible semantic sign-off remain pending.

## Local long-running Goal and finite endpoints (2026-10-04 01:12 +08:00)

- Native whole-book Goal is active in chat `01a102b1-a3fe-71e1-a571-347703fc09b8`. Only local work is used. The startup chat configured the same-chat 15-minute heartbeat; actual quota-exhaustion recovery has not been tested.
- Added `Continuation.lean` with seven complete proofs: Lipschitz endpoint limit, closed-set endpoint membership, actual mechanical derivative control, bounded/compact-field endpoint limits, connected-domain uniqueness from C1 regularity along the trajectory, and explicit-overlap gluing.
- Full `scripts/check.ps1` exited 0 at 01:11:13 +08:00 (started 01:08:40): pinned Lean/mathlib, source scan, 8939 build jobs, Scratch, 208 declaration audits and stable hashes. Each new key theorem uses only propext/Classical.choice/Quot.sound. Evidence: `docs/verification/2026-10-04-T4-continuation/full-check01/`.
- Newly viewed Theorem 1.1 at printed32/PDF55. Its strict all-time supremum requires a uniform margin, beyond pointwise strict bounds.
- Still unfinished: deriving the overlap equality from endpoint local IVP, maximal/global continuation, complete Theorem 1.1, later chapters and final responsible semantic sign-off. No new remote CI claim.
- A separate FTC endpoint-derivative probe passed. It is not yet in the formal library; the next task uses it to recover a one-sided derivative at the filled endpoint and apply local uniqueness.

## Actual finite endpoint continuation (2026-10-04 01:23 +08:00)

- `ODEEndpoint.lean` and `MechanicalContinuation.lean` add five fully proved key statements, including C1 endpoint matching and compact mechanical continuation with no assumed overlap equality.
- Full-check02 passed at01:18:50--01:21:37 +08:00:8941jobs, Scratch,214declaration audits, fixed versions and stable SHA. All five key dependencies use only the permitted three axioms. Evidence lives beside full-check01.
- The independent next global compact-confinement probe already passed. It constructs the union of all right-extendable local IVPs and excludes a finite supremum using the actual endpoint extension. Formal integration and energy-barrier discharge are in progress; full global textbook stability is not yet marked done.
- Responsible semantic sign-off remains pending; no new remote CI or publication has been performed.

## Global future stability integration (2026-10-04 05:58 +08:00)

- Same whole-book objective continues under user authorization. The native Goal is currently usageLimited, while a read-only quota query returned ordinaryUsageAllowed=true; the available tool cannot restore that platform status. No duplicate Goal, quota purchase/reset, account change or automation was created.
- GlobalContinuation, EnergyGlobalExistence, PotentialRegularity and Stability passed independent builds. Stability includes actual all-future existence, all same-IVP solutions, BddAbove and strict sSup bounds. PhaseMetric comparisons passed their independent probe and are being formally built.
- Euclidean stability transfer is in progress. Full-check03 has not yet run; these candidates are not counted as fully integrated machine acceptance. Final responsible semantic sign-off remains pending; new remote CI is not run under the current local-only instruction.

## Theorem 1.1 local machine acceptance (2026-10-04 06:11 +08:00)

- Six new modules passed full-check03 at06:07:48--06:10:29 +08:00:8947jobs, Scratch,231imported declaration audits, pinned Lean4.34.0/mathlib and stable input SHA. Thirteen newly explicit key theorem dependencies use only propext/Classical.choice/Quot.sound.
- The Euclidean statement `strictPotentialMin_futureStableEuclidean_of_smooth` proves equilibrium plus future existence and a bounded distance range with strict all-time supremum bound for every same-IVP future solution. It matches Theorem1.1 within the fixed positive diagonal mass model; C2 also suffices.
- Original printed32/PDF55 and the local proof chain were reviewed; final responsible semantic sign-off is pending, and no new remote CI was run. Entire Chapter1 and the whole book remain unfinished. Next independent work is §1.3 Lagrangian and Euler--Lagrange bridges.

## Lagrangian and Legendre integration (2026-10-04 06:29 +08:00)

- Lagrangian, GeneralizedCoordinates and LegendreTransform candidates were added after independent probe success. Sixteen key statements cover genuine gradients, actual Euler--Lagrange/mechanical trajectory bridges, rectangular coordinate changes, mass positivity/invertibility and the bounded Legendre supremum with its unique maximizer.
- Printed22--24/PDF45--47 was visually checked. The physical positive-mass condition repairs the original Legendre argument's insufficient mere-invertibility wording. Generalized configuration-dependent dynamics and all other whole-book work remain open.
- Full local verification is about to run in the Lagrangian batch. Responsible semantic sign-off is pending; new remote CI not run. Native whole-book Goal platform status remains usageLimited; work continues under the same explicit authorization.

## Section 1.3--1.4 local machine acceptance (2026-10-04 06:32 +08:00)

- All three modules passed the new full check at06:29:14--06:31:00 +08:00:8950jobs, Scratch,261imported declaration audits, pinned Lean/mathlib, forbidden-source scan and stable input hashes. Sixteen new explicit key dependencies use only the three allowed foundational axioms.
- Lagrangian gradients, actual Euler--Lagrange/mechanical trajectory equivalence, rectangular coordinate change, generalized mass positivity/invertibility and the true Legendre supremum with its unique maximizing velocity are locally machine-accepted.
- Sections1.3/1.4 remain partial: generalized configuration-dependent dynamics and variational least action are still open. Final responsible semantic sign-off remains pending; remote CI not run for this local snapshot. Next dependency is Section1.5.1 flow-map construction and composition laws with honest existence domains.

## Genuine future flow integration (2026-10-04 06:40 +08:00)

- Added FutureFlow after successful independent probes: energy barriers construct actual future IVPs on an invariant low-energy position-ball domain; time translation plus uniqueness prove nonnegative-time composition/commutation and injectivity; energy invariance follows from actual ODE conservation.
- Six key proofs use only the three permitted foundational axioms. Full local verification is being started. Negative-time existence/inverse group laws and continuity in initial states remain open; Chapter1/all-book and responsible sign-off remain incomplete.

## Future flow local machine acceptance (2026-10-04 06:44 +08:00)

- Flow/full-check01 passed at06:40:32--06:42:49:8951jobs, Scratch,268imported project declaration audits, stable pinned inputs and source scan. All six explicit new key dependencies use only the permitted three foundational axioms.
- Genuine future family existence/invariance, nonnegative-time composition/commutation, energy conservation and injectivity are machine-accepted on the barrier domain. Negative-time inverse laws and joint continuity remain open; Section1.5.1 is partial. Final responsible semantic sign-off is pending; remote CI not run.

## Two-sided mechanical flow integration (2026-10-04 06:52 +08:00)

- Independent TimeReversal and GlobalFlow proofs passed. Momentum/time reflection plus actual local uniqueness/gluing constructs all-real-time energy-barrier IVPs and an invariant all-time flow family. Composition, inverse, commutation, bijectivity and energy invariance follow from actual ODEs, with no such laws assumed.
- Flow/full-check02 is being started. Initial-state continuity and arbitrary global coercive models remain open. Original printed26/PDF49 checked; responsible final semantic sign-off pending, no new remote CI.

## All-real-time flow local machine acceptance (2026-10-04 06:56 +08:00)

- Flow/full-check02 passed at06:52:24--06:54:30:8953jobs, Scratch,286imported declaration audits, stable pinned Lean/mathlib and input SHA. Eleven new key explicit dependencies use only the permitted three foundational axioms.
- Time reversal, genuine all-real-time barrier IVPs, concrete invariant all-time families, composition/commutation, inverse maps, bijectivity and energy invariance are locally machine-accepted. Initial-state continuity and a continuous Dynamics.Flow structure remain unproved; other chapter/book content remains open.
- Original printed26/PDF49 and local statement review completed; final responsible semantic sign-off pending, no new remote CI. Next task is the explicit harmonic-oscillator flow on printed27/PDF50.

### Explicit oscillator and zero-frequency flow (2026-10-04)

- HarmonicOscillator: true unit-mass ODE, Ω≠0, joint time/state continuity, actual Flow, composition/inverse, actual potential gradient and Hamiltonian invariance passed independent probe03. FreeParticleFlow: actual q₀+tM⁻¹p₀/constant p, joint continuity and Flow passed probe02.
- Integrated full-check02 passed at07:09:12--07:10:36:8955jobs, Scratch,310declaration audits, stable pinned inputs. Failed full-check01 is preserved: module documentation preceded imports; file order was corrected and the oscillator module rebuilt successfully. Failed probe logs are retained without treating error-recovery sorryAx as accepted evidence.
- Section1.5.1 remains partial; general initial continuity and linear/spectral/matrix examples remain open. Whole book remains ongoing; final responsible semantic sign-off pending, no new remote CI.

### Constant-linear, matrix exponential and real spectral candidates (2026-10-04)

- Three new modules passed independent probes: genuine Banach operator exponential IVP/unique solution/continuous Flow, exact matrix exponential mulVec bridge plus arbitrary initial time, and real eigenmode/finite/eigenbasis spectral formulas with actual repr coefficients.
- full-check01 passed:8958jobs,348project audits, Scratch, pinned versions/source scan and stable input SHA. Complex spectra/real solution recovery and general nonlinear initial-state continuity remain open. Section1.5.1 and whole book remain ongoing; final responsible sign-off pending, no new remote CI.

### Complex spectra and real matrix recovery (2026-10-04)

- Three formal candidates integrated: real-time complex eigenmodes/finite/eigenbasis formulas and true Flow, real matrix/real initial-state recovery from ODE uniqueness and conjugation, and basis-column matrix invertibility/actual inverse coefficient solution.
- integrated ComplexSpectral/full-check01 passed at07:40:13--07:41:57:8961jobs,382project audits, Scratch, pinned versions/scan and stable SHA. General nonlinear initial-state continuity and other Section1.5.1/whole-book tasks remain open; final responsible sign-off pending, no new remote CI.

### First integrals, planar conservation and polar dependencies (2026-10-04)

- Genuine first-integral conservation/differential equivalence with local IVP necessity, true planar central-force angular momentum, actual polar time derivatives and static kinetic/angular/Lagrangian/coefficient determinant formulas passed independent probes and are formally integrated.
- FirstIntegrals/full-check01 passed at07:49:56--07:52:08:8964jobs,403project audits, Scratch, pinned versions/scan and stable SHA. Kepler gradient/dynamics/quadrature, action-angle/torus and further content remain open; Section1.5.2 and whole book stay ongoing, responsible final sign-off pending, no new remote CI.

### Kepler actual singular-domain model (2026-10-04)

- Candidate03 passed: true inverse-distance gradient/negative-gradient force, force C1 and real local IVP on q≠0, actual interval energy conservation and planar angular momentum conservation. Kepler/full-check01 passed at07:59:01--08:00:56:8965jobs,412project audits, Scratch, pinned versions/scan and stable SHA.
- No collision-free global orbit, polar radial quadrature or full integrability claim is inferred. Section1.5.2/whole book remain ongoing, responsible final sign-off pending, no new remote CI.

### Polar actual derivative and local inverse (2026-10-04)

- PolarJacobian candidate05 passed: five key declarations only use the permitted foundational axioms. Actual derivative, fderiv formula, invertible derivative at nonzero radius and genuine local chart with strict differentiable inverse formally integrated.
- Kepler/full-check02 starts for the new formal module. Section1.5.2/whole book ongoing; final responsible semantic sign-off pending, new remote CI not run.
Kepler/full-check02 passed at08:12:32--08:13:53:8966jobs, Scratch, full project axiom audit, pinned versions/source scan/stable input SHA. The formal polar local chart is accepted locally; scalar polar EL candidates remain outside the library.

### Kepler polar differential dynamics and angle integral (2026-10-04)

- Candidate10 passed with thirteen key declarations using only the allowed foundational axioms: four true partial derivatives, actual EL equivalence, angular conservation/radial reduction, effective energy and true FTC angle integral. New KeplerPolarDynamics formally integrated; Kepler/full-check03 starts.
- Cartesian/polar trajectory equivalence, full radial quadrature, action-angle/torus, later chapter and whole book remain open; responsible final semantic sign-off pending, new remote CI not run.
Kepler/full-check03 passed at08:27:02--08:28:23:8967jobs, Scratch,454imported project declaration audits, pinned versions/source scan/stable input SHA. Polar EL/radial energy/angle integral accepted; Cartesian bridge candidate not included.

### True Cartesian/polar Kepler trajectory equivalence (2026-10-04)

- CartesianBridge candidate05 passed without warnings; eleven key proofs use only permitted foundational axioms. Genuine unit-mass Kepler mechanical↔polar EL equivalence (positive-radius kinematic lift) and actual norm/angular/energy identities formally integrated. Kepler/full-check04 starts.
- Arbitrary initial-state local polar lifting, radial IVP reconstruction/quadrature and action-angle/torus remain open; Section1.5.2/whole book ongoing, final responsible sign-off pending, new remote CI not run.
Kepler/full-check04 passed at08:37:49--08:39:11:8968jobs, Scratch,490imported project declaration audits, pinned versions/source scan/stable input SHA. True Cartesian/polar equivalence accepted; reconstruction candidate remains outside the formal library.

### Real radial-IVP Kepler reconstruction (2026-10-04)

- Reconstruction candidate03 passed without warnings; nine key proofs only use permitted foundational axioms. Real positive-radius radial IVPs, true angle integral reconstruction, all nonzero Cartesian initial-state polar representation and reconstructed genuine local Kepler IVP formally integrated. Kepler/full-check05 starts.
- Radial separated quadrature/inverse with turning-point treatment, action-angle/torus and whole-book continuation remain open; final responsible semantic sign-off pending, new remote CI not run.
Kepler/full-check05 passed at08:46:27--08:47:48:8969jobs, Scratch,511imported project declaration audits, pinned versions/source scan/stable input SHA. Arbitrary nonzero initial-state radial-IVP reconstruction accepted; separated integral/inverse candidate remains outside the library.

### Separated scalar quadrature (2026-10-04)

- SeparableQuadrature candidate03 passed without warnings; five key proofs only use permitted foundational axioms. Actual separated integral strict derivative/local inverse/time formula and local inverse solution formally integrated; Kepler/full-check06 starts.
- Kepler signed square-root speed branch and local nonturning-point reduction, turning points, action-angle/torus and whole book remain open; final responsible semantic sign-off pending, no new remote CI.

Kepler/full-check06 passed at11:07:37--11:10:48:8970jobs, Scratch,525imported project declaration audits, pinned versions/source scan/stable input SHA. True scalar quadrature and inverse accepted; Kepler square-root branch candidate remains outside the formal library.

### Kepler nonturning signed quadrature (2026-10-04)

- Candidate01 eight key proofs passed without warnings and only permitted foundational axioms. Actual radial energy conservation, positive-radicand/sign window, true signed separated integral and actual trajectory local inverse formally integrated; Kepler/full-check07 starts.
- Turning points/global orbit classification, harmonic action-angle/torus and whole book remain open; final responsible semantic signoff pending, no new remote CI.

Kepler/full-check07 passed at11:17:25--11:20:26:8971jobs, Scratch,536 imported project declarations, pinned versions/source scan/stable input SHA. Signed nonturning radial quadrature accepted locally; final responsible signoff pending.

### Harmonic action-angle dynamics (2026-10-04)

- Candidate04 eleven key theorems passed without warnings and only permitted foundational axioms. Actual printed formulas/energy, actual ODE equivalence/time solution, every nonzero scalar phase representation and true harmonicFlow intertwining formally integrated; Kepler/full-check08 starts.
- Coordinate local inverse chart, decoupled oscillator torus, rational periodicity/irrational density and remaining whole book are open; final responsible semantic signoff pending, no new remote CI.

Kepler/full-check08 passed at11:26:45--11:29:08:8972jobs, Scratch,589 imported project declaration audits, pinned versions/source scan/stable input SHA. Actual harmonic action-angle dynamics/flow intertwining accepted locally; final signoff pending.

### Actual action-angle local chart (2026-10-04)

- Chart candidate03 five key proofs passed without warnings and only permitted foundational axioms. Actual strict derivative/Jacobian det1/local OpenPartialHomeomorph strict inverse formally integrated; full-check09 starts.
- Multi-oscillator torus/period/density and whole book remain open; final responsible semantic signoff pending, no new remote CI.

Kepler/full-check09 passed at11:35:41--11:37:03:8973jobs, Scratch,613 imported project declaration audits, pinned versions/source scan/stable input SHA. Actual local action-angle chart and strict inverse accepted; final signoff pending.

### Genuine decoupled oscillator torus and mechanical bridge (2026-10-04)

- Torus candidate07 eleven key proofs passed without warnings and only permitted foundational axioms. Actual angle torus/continuous rotation Flow/exact period criterion/fixed coordinate-energy image and true mechanical solution bridge formally integrated; full-check10 starts.
- Two-frequency irrational density and higher-dimensional integer resonance/nonresonance are separate. Final responsible semantic signoff pending, no new remote CI, whole book ongoing.

Kepler/full-check10 passed at11:48:35--11:49:55:8974jobs, Scratch,643 imported project declaration audits, pinned versions/source scan/stable input SHA. Actual torus rotation/period/fixed energy image/true mechanical solution accepted locally; responsible signoff pending.

### True torus homeomorphism and two-frequency density (2026-10-04)

- Density candidate03 eight key proofs passed without warnings and only permitted foundational axioms. Genuine fixed-energy torus homeomorphism, real-time two-frequency irrational DenseRange/physical orbit closure and three-frequency resonance non-density formally integrated; full-check11 starts.
- General higher-dimensional nonresonance density, forward-time density and rational-period iff remain open; final responsible semantic signoff pending, no new remote CI, whole book ongoing.

Kepler/full-check11 passed at11:56:21--11:57:42:8975jobs, Scratch,663 imported project declaration audits, pinned versions/source scan/stable input SHA. True torus homeomorphism/two-frequency real-time density/physical energy-level closure and three-frequency resonance non-density accepted locally; final signoff pending.

### True rational-period iff and physical nonperiodicity (2026-10-04)

- Period candidate02 six key proofs passed without warnings and only permitted foundational axioms. Exact positive-period iff rational frequency ratio and irrational no-period for both angle and true nondegenerate mechanical phase formally integrated; full-check12 starts.
- General high-dimensional nonresonance, forward density and remaining whole book pending; final responsible semantic signoff pending, no new remote CI.

Kepler/full-check12 passed at12:02:15--12:03:37:8976jobs, Scratch,676 imported project declaration audits, pinned versions/source scan/stable input SHA. Positive period iff rational ratio/nonperiodicity for angle and genuine mechanical phase accepted locally; final signoff pending.

### True first-integral implicit graph and scalar reduction (2026-10-04)

- Graph candidate02 three key proofs passed without warnings and only permitted foundational axioms. Actual y-partial nonzero gives inverse, true implicit graph and actual conserved trajectory scalar reduction formally integrated; full-check13 starts.
- Neighborhood regularity/nonturning scalar quadrature connection and remaining whole book open; final responsible semantic signoff pending, no new remote CI.

Kepler/full-check13 passed at12:07:11--12:08:31:8977jobs, Scratch,679 imported project declaration audits, pinned versions/source scan/stable input SHA. Actual first-integral implicit graph and trajectory scalar reduction accepted locally; final signoff pending.

### Genuine planar first-integral local integral solution (2026-10-04)

- Quadrature candidate02 three key proofs passed without warnings and only permitted foundational axioms. True C1 graph/automatic continuous nonzero reduced-speed and time windows/actual two-component inverse integral solution formally integrated; full-check14 starts.
- General scalar potential Example1.6 including turning/stationary cases, higher-dimensional nonresonance/forward density and whole book remain open; final responsible semantic signoff pending, no new remote CI.

- 2026-10-04 ScalarIntegrability candidate03 six keys passed exit0 without warnings; actual C2 potential first integral and nonturning quadrature formally integrated. Full-check15 passed (8979 jobs/691 declarations), fixed versions, Scratch, source scan and stable input SHA verified. Turning/stationary and whole book pending; final human signoff pending, no new remote CI.

- 2026-10-04 ScalarTurning candidate03 eight keys passed exit0 without warnings, allowed base axioms. Actual regular-turning inverse quadrature and stationary initial state whole-Ioo constancy formally integrated. Full-check16 passed (8980jobs/702 declarations), Scratch/fixed versions/source scan/stable SHA verified; whole book and human semantic signoff pending, no new remote CI.

- 2026-10-04 ScalarLocalIVP candidate01 three keys passed exit0 without warnings and with allowed axioms; actual arbitrary initial data IVP plus energy and exhaustive local integrability formally integrated. Full-check17 passed (8981jobs/708 declarations), Scratch/fixed versions/scan/stable input SHA verified; final human signoff and whole-book completion pending, no new remote CI.

- 2026-10-04 EquilibriumLinearization candidate02 eight keys passed exit0 without warnings and with base axioms; actual equilibrium, little-o remainder, nonlinear perturbation, linearized IVP and mechanical block derivative formally integrated. Full-check18 passed (8982jobs/720 declarations), Scratch/fixed versions/scan/stable SHA verified; Hartman–Grobman/general nonlinear initial dependence and whole book pending; final signoff pending, no new remote CI.

- 2026-10-04 LocalContinuousFlow candidate04 three keys passed exit0 without warnings and with base axioms; actual C1 solution family joint continuity, initial Lipschitz dependence, ODE, and open-domain mechanical local IVP family formally integrated. Full-check19 passed (8983jobs/724 declarations), Scratch/fixed versions/scan/stable SHA verified; global flow/Hartman–Grobman/whole book pending, final signoff pending, no new remote CI.

- 2026-10-04 HamiltonianHessian candidate01 three keys passed exit0 without warnings and with base axioms; actual C2 Hessian symmetry and conservative mechanical force-block data formally integrated. Full-check20 passed (8984jobs/727 declarations), Scratch/fixed versions/scan/stable SHA verified; Hartman–Grobman and remaining book pending, final signoff pending, no new remote CI.

- 2026-10-04 LinearizedHamiltonian candidate03 four keys passed exit0 without warnings and with base axioms; actual displayed quadratic linearized energy and explicit nonnegativity bridge formally integrated. Full-check21 passed (8985jobs/733 declarations), Scratch/fixed versions/scan/stable SHA verified; Hessian positivity-from-minimum, Hartman–Grobman and remaining book pending, final signoff pending, no new remote CI.

- 2026-10-04 LatticePairPotential candidate04 passed exit0 without warnings and with only base axioms; the uniform finite pair-potential sum, translation invariance, and exact two-atom reduction were formally integrated from printed33/PDF56. Full-check22 remains to run; nearest-neighbor/periodic/vibration claims and whole-book completion remain pending, final semantic signoff pending, no new remote CI.

- 2026-10-04 nearest-neighbor chain extension passed full-check23 (8986 jobs, 739 imported declarations); translation invariance and the two-site reduction are accepted with only allowed base axioms. Boundary/periodic variants and lattice-vibration dynamics remain pending.

- 2026-10-04 `LatticeVibrations` added the actual gradient first-order expansion and little-o remainder under the stated equilibrium/C² hypotheses. The local probe is clean with only allowed axioms; full-check24 is pending. Positive-definite Hessian spectral modes and periodic/boundary lattice dynamics remain open.

- 2026-10-04 full-check25 passed (8987 jobs, 746 imported declarations): explicit positive-Hessian quadratic-form assumptions now bridge to nonnegative linearized Hamiltonian energy. No minimum-to-Hessian implication or pure-imaginary normal-mode spectrum is claimed; those and the rest of §1.6.1 remain open.

- 2026-10-04 periodic nearest-neighbor energy on `ZMod N` (with `[NeZero N]`) and its translation invariance passed full-check26 (8987 jobs, 748 declarations). Periodic spectra, normal modes, and later chapters remain open.

- 2026-10-04 the periodic formula was corrected against printed33/PDF56: actual walled and box-periodic seam definitions are now present, distinct from the abstract `ZMod` helper. A NormalModes probe also derives the real sine/cosine solution and its linearized mechanical derivative from supplied generalized eigenpair hypotheses. Full-check31 passed with 8988 jobs, 350 audited declarations, zero build warnings, fixed versions, Scratch, source scan, and only permitted foundational axioms. Pure-imaginary spectral classification, complete mode bases, and responsible semantic signoff remain pending.

- 2026-10-04, printed44--47/PDF67--70: `VariationalEquation` adds the exact constant-coefficient specialization of (1.10), exponential-flow existence/uniqueness, and four matrix-exponential exercise bridges. The candidate single-file compile passed with no warnings; the integrated full check is pending. Nonlinear time-dependent Jacobians, initial-data derivatives, Lyapunov limits, and remaining exercises remain open.

- 2026-10-04 `VariationalEquation` full-check32 passed at 19:08:19--19:10:52 +08:00: 8989 build jobs, zero build warnings, 357 audited declarations, fixed Lean 4.34.0/mathlib `5ed2965256430c3649e86755f9576b54eca72435`, Scratch, source scan, stable input hashes, and axiom audit all passed. The seven new declarations use only `propext`, `Classical.choice`, and `Quot.sound`; the constant-coefficient specialization and exercise-2 matrix identities are accepted locally. Nonlinear time-dependent Jacobians, flow differentiation in initial data, Lyapunov limits, and exercises 1 and 3--5 remain open; responsible semantic signoff and whole-book completion remain pending.

- 2026-10-04, printed46/PDF69 exercise 1(a): `matrixExponentialFlow_diagonal` now gives the exact componentwise solution for a finite real diagonal matrix. The local fixed-toolchain compile passes; integration full-check is pending. Upper-triangular/diagonalization cases 1(b)--1(c), exercises 3--5, nonlinear variational flow, and Lyapunov limits remain open.

- 2026-10-04 `full-check33` passed at 19:51:30--19:54:12 +08:00: 8989 build jobs, zero build warnings, 358 audited declarations, fixed Lean 4.34.0/mathlib `5ed2965256430c3649e86755f9576b54eca72435`, Scratch, source scan, stable input hashes, and axiom audit all passed. The diagonal exercise is accepted locally; upper-triangular/diagonalization cases 1(b)--1(c), exercises 3--5, nonlinear variational flow, Lyapunov limits, responsible semantic signoff, and whole-book completion remain pending.

- 2026-10-04, printed46/PDF69 exercise 1(c): `matrixExponential_conjugate` now proves the similarity identity under explicit `IsUnit X`. The local fixed-toolchain compile passes; a new integration full-check is pending. No eigenbasis existence or upper-triangular exercise 1(b) claim is made.

- 2026-10-04 `full-check34` passed at 20:02:37--20:03:56 +08:00: 8989 build jobs, zero build warnings, 359 audited declarations, fixed Lean 4.34.0/mathlib `5ed2965256430c3649e86755f9576b54eca72435`, Scratch, source scan, stable input hashes, and axiom audit all passed. Exercise 1(c)'s explicit similarity bridge is accepted locally; exercise 1(b), exercises 3--5, nonlinear variational flow, Lyapunov limits, responsible semantic signoff, and whole-book completion remain pending.

- 2026-10-04, printed46/PDF69 exercise 1(b): `upperTriangularFlow` and `matrixExponentialFlow_upperTriangular` now prove the exact two-dimensional upper-triangular solution by `HasDerivAt` and ODE uniqueness. The local fixed-toolchain compile passes with zero warnings; a new integration full-check is pending. General Jordan forms and exercises 3--5 remain open.

- 2026-10-04 `full-check35` passed at 20:32:41--20:37:31 +08:00: 8989 build jobs, zero build warnings, 364 audited declarations, fixed Lean 4.34.0/mathlib `5ed2965256430c3649e86755f9576b54eca72435`, Scratch, source scan, stable input hashes, and axiom audit all passed. Exercise 1(b)'s literal upper-triangular solution is accepted locally; general Jordan forms, exercises 3--5, nonlinear variational flow, Lyapunov limits, responsible semantic signoff, and whole-book completion remain pending.

- 2026-10-04 `full-check36` passed at 21:20:01--21:21:04 +08:00: 8990 build jobs, zero build warnings, 373 audited declarations, fixed Lean 4.34.0/mathlib `5ed2965256430c3649e86755f9576b54eca72435`, Scratch, source scan, stable input hashes, and axiom audit all passed. Exercise 3(b)'s equal-mass planar center/relative coordinate algebra and kinetic decomposition are accepted locally and committed as `556d321`; the radial potential and equations of motion, exercise 3(c), exercises 4--5, nonlinear variational flow, Lyapunov limits, responsible semantic signoff, and whole-book completion remain pending.
- 2026-10-04, printed47/PDF70 exercise 3(a/b): `twoBodyRadialLagrangian` and `twoBody_equalMass_lagrangian_center_relative` add the radial-potential Lagrangian expansion in center/relative coordinates. `full-check37` passed at 21:36:07--21:37:58 +08:00 with fixed versions, 8990 jobs, zero build warnings, 373 audited declarations, Scratch, source scan, stable input hashes, and allowed axioms only. The reduced equations of motion, exercise 3(c), exercises 4--5, nonlinear variational flow, Lyapunov limits, responsible semantic signoff, and whole-book completion remain pending.

- 2026-10-04, printed56/PDF78: the full `theorem_2_1_euler` candidate now compiles with fixed Lean 4.34.0 and no warnings. It derives compact-trajectory constants, quadratic local defect, numerical-domain retention and the actual maximum first-order global error from the C¹ open-domain hypotheses; the finite and zero time horizons are covered. The candidate is integrated into the root, Scratch and axiom audit. Full project acceptance is pending; notation inventory now maps 30 existing items without claiming that the remaining notation or responsible semantic review is complete. The current scope excludes independent exercises (see CORE_SCOPE).

- 2026-10-04 Theorem 2.1 full-check01 passed at 22:30:06--22:36:28 +08:00: 8991 jobs, zero build warnings, 387 audited declarations, fixed Lean 4.34.0/mathlib, Scratch, source scan and stable input SHA. The complete Euler domain-retention and maximum-error theorem is accepted locally. All new declarations use only propext, Classical.choice and Quot.sound. Responsible textbook semantic signoff and the remaining CORE_SCOPE remain pending. Next: the main-text proof in §2.2.3, not independent exercises.

- 2026-10-04 §2.2.3, printed66--67/PDF88--89: the actual one-step recurrence, equation (2.12), finite maximum order-p bound and mesh-refinement convergence all pass the final single-file fixed-version Lean check with zero warnings. The original numerical-retention assumption and strict/non-strict step thresholds are explicit. Root, Scratch and the ten new public axiom checks are integrated; full project acceptance and responsible semantic signoff are pending.

- 2026-10-04 §2.2.3 full-check01 passed at22:55:31--23:04:36 +08:00:8992jobs,0warnings,397audited declarations, fixed Lean4.34.0/mathlib, Scratch, source scan, stable SHA and allowed axioms only. The actual finite and limiting convergence conclusions are accepted locally; all10new public declarations depend only on propext,Classical.choice,Quot.sound. Root compilation took381seconds and most build jobs reused cache. Responsible semantic signoff and remaining CORE_SCOPE are pending. Next: standard symplectic form and its exact pullback/matrix equivalence on printed76--78/PDF98--100.
