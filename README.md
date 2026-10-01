# Molecular Dynamics Formalization

Lean 4 + mathlib project for selected material from Leimkuhler and Matthews, *Molecular Dynamics: With Deterministic and Stochastic Numerical Methods*.

## Workflow

1. Draft a small declaration in `Scratch.lean` and check it with `lake env lean Scratch.lean`.
2. Move reviewed code into `MolecularDynamics/` and add it to `MolecularDynamicsFormalization.lean` if needed.
3. Record its textbook reference and assumptions in `FORMALIZATION_MAP.md` and `ASSUMPTIONS.md`.
4. Run `pwsh -NoProfile -File scripts/check.ps1` with PowerShell 7. This checks fixed runtime/dependency versions, scans project sources, builds the library, checks Scratch, and audits imported project declarations for unexpected logical dependencies.

`lake build` checks the formal library. `Scratch.lean` is checked separately during drafting and is also scanned by the check script.

## Layout

- `MolecularDynamics/Notation.lean`: coordinate, phase-space, and energy-function types.
- `MolecularDynamics/BasicDefinitions.lean`: small shared structures.
- `MolecularDynamics/Chapter01/`: add files as Chapter 1 declarations are developed.
- `Scratch.lean`: temporary compilation area.
- `FORMALIZATION_PLAN.md`: scope and correctness standard.
- `FORMALIZATION_MAP.md`: textbook-to-Lean correspondence.
- `ASSUMPTIONS.md`: explicit hypotheses and modeling decisions.
- `STATUS.md`: current progress.
- `MATHLIB_SURVEY.md`: APIs verified against the pinned mathlib checkout.

The project pins Lean and mathlib versions in `lean-toolchain` and `lakefile.toml`/`lake-manifest.json`.

Use `-ReportDirectory <new-directory>` to preserve input hashes, versions, command logs, and exit codes. The existing GitHub workflow runs this same check and saves its evidence artifact. Machine success leaves textbook semantic review pending; see [the local/CI acceptance guide](docs/verification/LOCAL_ACCEPTANCE.zh-CN.md) and [semantic review template](docs/verification/SEMANTIC_REVIEW_TEMPLATE.zh-CN.md).

## Resume across Codex accounts

Open the same local workspace and read `AGENTS.md`, then the Chinese
[current checkpoint](docs/handoff/CURRENT_STATE.zh-CN.md) and the latest entry in
[the work log](docs/handoff/WORK_LOG.zh-CN.md). Copy the
[resume prompt](docs/handoff/RESUME_PROMPT.zh-CN.md) into the next account.
Update the checkpoint and append the log after each small task; preserve local
uncommitted files when handing off. The checkpoint distinguishes source inventory,
formal proofs, build results, and semantic review.
