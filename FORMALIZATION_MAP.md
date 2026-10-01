# Textbook to Lean map

Record the edition/page, exact textbook statement, Lean declaration, formal assumptions, and any intentional reformulation when each item is started.

| Textbook content | Lean declaration | Status | Notes |
| --- | --- | --- | --- |
| Chapter 1 §1.2, Eq. (1.3), pp. 18–19: `M q̈ = F(q) = -∇U(q)` | `MolecularDynamics.NBodyEquationAt` | Implemented | Pointwise in a supplied `position` and `acceleration`. `M` is `diagonalMassMatrix masses`. No trajectory or time derivative is introduced at this stage. Mathlib's total `gradient` is used without a differentiability assumption in the definition. |
| Chapter 1 §1.2, Eq. (1.4), p. 18: `E = ∑_j m_j ‖q̇_j‖²/2 + U(q)` | `MolecularDynamics.nBodyTotalEnergy` (using `nBodyKineticEnergy`) | Implemented | With `n = N_c`, the kinetic term is expanded over scalar coordinates as `∑_i masses i * (velocity i)^2 / 2`. In 3D each particle mass is repeated for its three coordinates. |
| Chapter 1 §1.2, Eq. (1.4), auxiliary property: nonnegativity of the kinetic term | `MolecularDynamics.nBodyKineticEnergy_nonneg` | Proved | Assumes explicitly that every coordinate mass is nonnegative: `hm : ∀ i, 0 ≤ masses i`. No condition on velocity is required. |
| Theorem 1.1 | TBD | Not started | Verify statement and hypotheses before implementation. |

## T1 integration (2026-10-02)

The complete proofs below are integrated into `Chapter01/ParticleCoordinates.lean`.
Their standalone and integrated fixed-version checks passed, including 8929
build jobs, Scratch, and 60 declaration dependency audits. The MathCopilot T1 review is pending because the
website reported a server connection failure. Responsible semantic review is
recorded separately from machine verification.

| Spec ID | Lean declaration | Textbook correspondence and assumptions |
| --- | --- | --- |
| T1-I1 | `flattenParticleVectors_apply` | Particle-first coordinate ordering in §1.2, printed18/PDF41; no positivity assumption. |
| T1-I2 | `unflatten_flatten`, `flatten_unflatten` | The particle/coordinate representations are inverse for all `N,d`, including empty index sets. |
| T1-M1 | `coordinateMassesOfParticles_apply` | Repeats each mass across spatial directions; `d=3` gives the displayed diagonal matrix in (1.3). |
| T1-M2 | `coordinateMassesOfParticles_pos` | Positive particle masses give positive coordinate masses, with no dimension restriction. |
| T1-M3 | `coordinateMassesOfParticles_pos_iff` | The reverse implication explicitly requires `0<d`; it does not follow from empty coordinates. |
| T1-E1 | `nBodyKineticEnergy_particle_eq` | Equality of scalar-coordinate and particle kinetic expressions in (1.4); arbitrary real masses. |
| T1-P1 | `diagonalMassMatrix_posDef_iff` | Auxiliary diagonal-matrix positive-definiteness criterion, not a numbered textbook theorem. |
| T1-P2 | `diagonalMassMatrix_isUnit` | Strictly positive coordinate masses imply matrix invertibility. |
| T1-P3 | `diagonalMassMatrix_mul_inv`, `diagonalMassMatrix_inv_mul` | Both inverse identities under the same strictly positive mass hypothesis. |
| T1-P4 | `diagonalMassMatrix_inv_eq` | Inverse diagonal is the coordinatewise reciprocal under positive masses; no unconditional singular-matrix claim. |
| T1-P5 | `diagonalMassMatrix_inv_mulVec` | Coordinatewise recovery of a Euclidean velocity after mass multiplication and inverse; positive masses. |
