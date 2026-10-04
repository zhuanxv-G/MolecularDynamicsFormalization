import MolecularDynamics.Chapter04.ConstrainedIntegrator
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse

/-!
# The actual linear cotangent projection

Printed159/PDF181, equations (4.23)--(4.24), with the explicit Gram
nonsingularity condition already discussed on printed153/PDF175.
The multiplier is constructed from the real constraint Jacobian and
diagonal inverse mass matrix; its hidden constraint is then derived.
-/

open Matrix
open scoped BigOperators

namespace MolecularDynamics

/-- Rows are the actual coordinate derivatives of the scalar constraints. -/
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i

theorem textbookConstraintJacobian_mulVec {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q w : Fin Nc → ℝ) (j : Fin Mc) :
    (textbookConstraintJacobian γ q *ᵥ w) j = (fderiv ℝ (γ j) q) w := by
  have hw : ∑ i : Fin Nc, w i • Pi.single i 1 = w := by
    ext i
    simp [Finset.sum_apply, Pi.single_apply]
  calc
    _ = (fderiv ℝ (γ j) q) (∑ i : Fin Nc, w i • Pi.single i 1) := by
      simp only [textbookConstraintJacobian, textbookConstraintGradient, Matrix.mulVec,
        dotProduct, map_sum, map_smul, smul_eq_mul, mul_comm]
    _ = _ := congrArg (fderiv ℝ (γ j) q) hw

/-- For actual differentiable constraints, G is the actual vector-valued Jacobian. -/
theorem textbookConstraintJacobian_eq_actualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap := by
  have hd : HasFDerivAt (fun y j => γ j y)
      (ContinuousLinearMap.pi fun j => fderiv ℝ (γ j) q) q :=
    hasFDerivAt_pi.mpr fun j => (hγ j).hasFDerivAt
  rw [hd.fderiv]
  rfl

noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹

/-- The actual constraint Gram matrix G M⁻¹ Gᵀ. -/
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ

/-- The actual solution μ=(G M⁻¹ Gᵀ)⁻¹ G M⁻¹p. -/
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))

noncomputable def textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p

/-- The matrix correction is exactly the printed finite gradient correction. -/
theorem textbookCotangentProjection_eq_gradient_sum {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) :
    textbookCotangentProjection m γ q p =
      p - ∑ j : Fin Mc, textbookCotangentMultiplier m γ q p j • textbookConstraintGradient (γ j) q := by
  ext i
  simp [textbookCotangentProjection, textbookConstraintJacobian, Matrix.mulVec,
    dotProduct, Finset.sum_apply, Pi.smul_apply, mul_comm]

/-- Genuine Gram nondegeneracy yields the hidden constraint from the constructed μ. -/
theorem textbookCotangentProjection_hiddenConstraint {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0 := by
  let G := textbookConstraintJacobian γ q
  let D := textbookInverseMassMatrix m
  let A := textbookConstraintGram m γ q
  let b := G *ᵥ (D *ᵥ p)
  let μ := textbookCotangentMultiplier m γ q p
  have hμ : A *ᵥ μ = b := by
    change A *ᵥ (A⁻¹ *ᵥ b) = b
    rw [Matrix.mulVec_mulVec, Matrix.mul_nonsing_inv A (isUnit_iff_ne_zero.mpr hdet), Matrix.one_mulVec]
  have hterm : G *ᵥ (D *ᵥ (Gᵀ *ᵥ μ)) = A *ᵥ μ := by
    rw [Matrix.mulVec_mulVec, Matrix.mulVec_mulVec]
    rfl
  change G *ᵥ (D *ᵥ (p - Gᵀ *ᵥ μ)) = 0
  rw [Matrix.mulVec_sub, Matrix.mulVec_sub, hterm, hμ, sub_self]

/-- In genuine derivative notation the output satisfies every g′_j(q)M⁻¹P=0. -/
theorem textbookCotangentProjection_constraint_derivative_zero {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hdet : (textbookConstraintGram m γ q).det ≠ 0) (j : Fin Mc) :
    (fderiv ℝ (γ j) q)
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0 := by
  rw [← textbookConstraintJacobian_mulVec]
  exact congrFun (textbookCotangentProjection_hiddenConstraint m γ q p hdet) j

end MolecularDynamics
