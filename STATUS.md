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

## Not yet formalized

- A time-dependent trajectory and its first and second derivatives.
- Regularity of the potential or trajectory.
- Positivity or invertibility of the mass entries.
- Energy conservation along solutions of equation (1.3).
- Chapter 1 §1.3 and later material.
