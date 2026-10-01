# mathlib survey

Checked against the local mathlib `v4.34.0` checkout (`5ed296525643`), rather than inferred from older API examples. Paths below are relative to `.lake/packages/mathlib/Mathlib/`.

| Topic | Existing mathlib API | Planned use |
| --- | --- | --- |
| Finite real vectors | `EuclideanSpace ℝ (Fin n)` in `Analysis/InnerProductSpace/PiL2.lean`; `Fin n → ℝ` is the plain coordinate-function type | Use `EuclideanSpace` for positions, velocities, and momenta. |
| Inner product and norm | `PiLp.inner_apply`, `EuclideanSpace.inner_eq_star_dotProduct`, `EuclideanSpace.norm_eq` in `Analysis/InnerProductSpace/PiL2.lean` | Reuse Euclidean inner product and norm. |
| Matrices and matrix-vector multiplication | `Matrix`, `Matrix.mulVec` / `*ᵥ`, and `dotProduct` / `⬝ᵥ` in `Data/Matrix/Mul.lean` | Use `Matrix (Fin n) (Fin n) ℝ` for a general mass matrix. |
| Matrix/Euclidean bridge | `Matrix.toEuclideanLin` in `Analysis/InnerProductSpace/PiL2.lean` | Prefer this bridge when applying matrices to the Euclidean state space. |
| Differentiability and Fréchet derivative | `DifferentiableAt`, `HasFDerivAt`, and `fderiv` in `Analysis/Calculus/FDeriv/Defs.lean`; one-variable `HasDerivAt` | Reuse these hypotheses and derivatives. |
| Gradient | `gradient`, `gradientWithin`, and `HasGradientAt` in `Analysis/Calculus/Gradient/Basic.lean` | Use for conservative force after regularity is specified. |
| Hessian | No generally named `hessian`/`Hessian` declaration was found by searching this checkout | If required, first choose between the derivative of `gradient` and the second Fréchet derivative; introduce a small local definition only then. |
| ODE | `IsIntegralCurveOn`, `IsIntegralCurveAt`, and `IsIntegralCurve` in `Analysis/ODE/Basic.lean`; existence/uniqueness results in `Analysis/ODE/ExistUnique.lean` | Reuse for trajectories and state regularity. |
| Flow/dynamical systems | `Flow`, `IsInvariant`, `IsForwardInvariant` in `Dynamics/Flow.lean` | Reuse for a global continuous action when global existence has been established. |
| Positive definite matrices | `Matrix.PosDef`, `Matrix.PosDef.isUnit`, `Matrix.PosDef.inv`, and `posDef_iff_dotProduct_mulVec` in `LinearAlgebra/Matrix/PosDef.lean` | Use `M.PosDef` as the mass-matrix hypothesis when this model is selected. |

## Modeling boundaries

- `Fin n → ℝ` is convenient for `Matrix.mulVec`, but mathlib's ordinary finite function space uses a supremum norm. `EuclideanSpace` carries the `L²` inner product norm; `Matrix.toEuclideanLin` connects the representations.
- `M.PosDef` is a property of a matrix, not something guaranteed by the `MassMatrix` alias. Energy definitions involving `M⁻¹` need this hypothesis or another invertibility assumption.
- `Flow ℝ α` describes a global continuous flow. A local ODE solution alone does not provide such a flow.
- A gradient needs an inner product identification with the dual. `F = -∇U` is an additional model hypothesis, not a consequence of the types.
- A Lagrangian uses velocity, while a Hamiltonian uses momentum; translating between them depends on the chosen mass model.
- `Position`, `Velocity`, and `Momentum` are deliberately transparent aliases, so Lean permits mixing them. If this causes mistakes later, replace selected aliases with lightweight wrappers.
- For N particles in spatial dimension d, decide later whether to keep two indices `(Fin N → EuclideanSpace ℝ (Fin d))` or flatten to `Fin (N*d)`. The current `n` means total degrees of freedom.

The project-specific declarations currently live in `MolecularDynamics/Notation.lean` and `MolecularDynamics/BasicDefinitions.lean`.
