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

- General local existence, uniqueness and maximal extension for the mechanical ODE.
- Higher regularity of the force, potential and trajectory beyond the explicit derivative bridges.
- Hamiltonian consistency under the now-available positive-mass inverse bridges (T3).
- Energy conservation along solutions of equation (1.3).
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
- Theorem1.1, actual mechanical energy conservation, momentum bounds, ODE existence/uniqueness and global extension remain later goals.
