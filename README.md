# Molecular Dynamics Formalization

Lean 4 + mathlib project for selected material from Leimkuhler and Matthews, *Molecular Dynamics: With Deterministic and Stochastic Numerical Methods*.

## Workflow

1. Draft a small declaration in `Scratch.lean` and check it with `lake env lean Scratch.lean`.
2. Move reviewed code into `MolecularDynamics/` and add it to `MolecularDynamicsFormalization.lean` if needed.
3. Record its textbook reference and assumptions in `FORMALIZATION_MAP.md` and `ASSUMPTIONS.md`.
4. Run `pwsh -File scripts/check.ps1` (or `powershell -File scripts/check.ps1` on Windows). This scans project Lean files for forbidden proof shortcuts and runs `lake build`.

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
