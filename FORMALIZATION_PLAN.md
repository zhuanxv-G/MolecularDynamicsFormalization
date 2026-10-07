# Formalization plan

## Goal

Formalize the textbook notation, main-text theorems, lemmas, propositions, corollaries, and their proofs from Leimkuhler and Matthews, *Molecular Dynamics: With Deterministic and Stochastic Numerical Methods*, in Lean 4 with mathlib. The user revised the scope and authorized continuation on 2026-10-04; see `docs/CORE_SCOPE.zh-CN.md`. Exercises and numerical experiments are excluded as independent deliverables. Reuse existing verified source and add only definitions and dependencies needed by the target statements.

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

This phase list describes the original plan. Later Chapter 1 source and acceptance evidence already exist, including Theorem 1.1; consult the latest handoff and exact source hashes before deciding what remains. Continue the main-text goals rather than completing every Chapter 1 exercise or independent extension.

## Later phases

- Chapter 2 models and numerical methods, once Chapter 1 conventions are stable.
- Deterministic integrators and their properties.
- Stochastic models and methods, with a separate treatment of probability and regularity assumptions.

Add further chapter files when their first declaration is ready.

## Whole-book planning draft

The Chinese [whole-book roadmap and acceptance criteria](docs/WHOLE_BOOK_ROADMAP.zh-CN.md)
describes the revised coverage, dependencies, semantic review, and formal
verification requirements. The latest scope is authorized, while individual new
statements still need review and proof; the whole book is not yet formalized. The inventories in `docs/` track section coverage,
the front-matter notation table, and preliminary numbered declaration candidates;
unnumbered claims and missing proofs still require a page-by-page audit.
