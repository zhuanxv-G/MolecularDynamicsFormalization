import MolecularDynamics.Chapter04.CotangentProjectionRegularity
import MolecularDynamics.Chapter04.ConstrainedReaction
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Algebra.Order.Star.Real

/-!
# Physical nondegeneracy of the actual constraint Gram matrix

Necessary model dependency for printed153/PDF175 and159/PDF181.
Positive masses and the independent real constraint gradients yield
positive definiteness and a positive determinant of G M⁻¹Gᵀ.
No invertibility or retained constraint is supplied in the physical results.
-/

open Matrix Set
open scoped BigOperators Topology

namespace MolecularDynamics

theorem textbookConstraintJacobian_vecMul_injective {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    Function.Injective (textbookConstraintJacobian γ q).vecMul := by
  have heq (c : Fin Mc → ℝ) :
      Fintype.linearCombination ℝ (fun j => textbookConstraintGradient (γ j) q) c =
        c ᵥ* textbookConstraintJacobian γ q := by
    ext i
    simp only [Fintype.linearCombination_apply, Finset.sum_apply, Pi.smul_apply,
      smul_eq_mul, Matrix.vecMul, dotProduct, textbookConstraintJacobian]
  intro a b hab
  apply hind.fintypeLinearCombination_injective
  rw [heq a, heq b]
  exact hab

theorem textbookInverseMassMatrix_posDef {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) : (textbookInverseMassMatrix m).PosDef := by
  exact Matrix.PosDef.diagonal fun i => inv_pos.mpr (hm i)

theorem textbookConstraintGram_posDef {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef := by
  simpa only [textbookConstraintGram, Matrix.conjTranspose_eq_transpose_of_trivial] using
    (textbookInverseMassMatrix_posDef m hm).mul_mul_conjTranspose_same
      (B := textbookConstraintJacobian γ q) (textbookConstraintJacobian_vecMul_injective γ q hind)

theorem textbookConstraintGram_det_pos {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    0 < (textbookConstraintGram m γ q).det :=
  (textbookConstraintGram_posDef m γ q hm hind).det_pos

theorem textbookConstraintGram_det_ne_zero {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).det ≠ 0 :=
  (textbookConstraintGram_det_pos m γ q hm hind).ne'

theorem textbookCotangentProjection_hiddenConstraint_of_mass_and_independence {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0 :=
  textbookCotangentProjection_hiddenConstraint m γ q p
    (textbookConstraintGram_det_ne_zero m γ q hm hind)

theorem contDiffAt_textbookCotangentMultiplier_of_mass_and_independence {Nc Mc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q x))) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentMultiplier m γ (q y) (p y)) x :=
  contDiffAt_textbookCotangentMultiplier m γ q p x hγ hq hp
    (textbookConstraintGram_det_ne_zero m γ (q x) hm hind)

/-- The physical assumptions give solution-interval invariance without a
separately supplied Gram invertibility condition. -/
theorem textbookConstrainedODE_cotangent_invariant_of_mass_and_independence {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (F : (Fin Nc → ℝ) → Fin Nc → ℝ) (q p : ℝ → Fin Nc → ℝ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q t)))
    (hq : ∀ t ∈ Icc 0 τ, HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) (Icc 0 τ) t)
    (hp : ∀ t ∈ Icc 0 τ, HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) (Icc 0 τ) t)
    (hpos₀ : ∀ j, γ j (q 0) = 0)
    (hhidden₀ : ∀ j, (fderiv ℝ (γ j) (q 0)) (textbookInverseMassMatrix m *ᵥ p 0) = 0) :
    ∀ t ∈ Icc 0 τ, ∀ j, γ j (q t) = 0 ∧
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 :=
  textbookConstrainedODE_cotangent_invariant m γ F q p τ hγ
    (fun t ht => textbookConstraintGram_det_ne_zero m γ (q t) hm (hind t ht)) hq hp hpos₀ hhidden₀

end MolecularDynamics
