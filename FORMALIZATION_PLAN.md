# Formalization plan

## Goal

Formalize selected results from Leimkuhler and Matthews, *Molecular Dynamics: With Deterministic and Stochastic Numerical Methods*, in Lean 4 with mathlib. MathCopilot may help draft individual declarations; this repository holds reviewed, compiling code and the correspondence with the textbook.

## Correctness standard

- State every mathematical assumption explicitly, including dimensions, mass positivity, regularity, and solution domains when relevant.
- Project-owned Lean code must compile without proof placeholders or project-specific axioms.
- Every textbook claim should have a traceable entry in `FORMALIZATION_MAP.md`; any change in formulation should be explained there.
- `scripts/check.ps1` and `lake build` must pass before code is treated as completed.

## Phase 1 scope

1. Notation and basic data types.
2. N-body basics.
3. Kinetic energy and potential energy.
4. Hamiltonian.
5. Energy conservation.
6. Equilibrium.
7. First integral.
8. Flow map.

Shared notation, the minimal data model, and the pointwise N-body equations (1.3) and (1.4) are implemented. The remaining items above are a work plan, not claims already formalized.

## Later phases

- Chapter 2 models and numerical methods, once Chapter 1 conventions are stable.
- Deterministic integrators and their properties.
- Stochastic models and methods, with a separate treatment of probability and regularity assumptions.

Add further chapter files when their first declaration is ready.
