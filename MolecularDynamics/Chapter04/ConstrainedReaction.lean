import MolecularDynamics.Chapter04.CotangentProjection
import Mathlib.Analysis.Calculus.Deriv.Mul

/-!
# Actual constraint reaction and cotangent invariance

Printed152--153/PDF174--175, equations (4.7)--(4.10).
The curvature is made from the real second derivative, the reaction
multiplier is solved by the true Gram inverse, and both constraints
are preserved on the whole closed interval of a specified actual solution.
Global existence is a separate question.
-/

open Set Matrix
open scoped BigOperators Topology

namespace MolecularDynamics

/-- The actual quadratic curvature term D²γ_j(q)[M⁻¹p,M⁻¹p]. -/
noncomputable def textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)

/-- The explicit reaction from G M⁻¹(F-Gᵀρ)+φ=0. -/
noncomputable def textbookConstrainedReactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)

theorem textbookConstrainedReaction_balance {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (F q - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookConstrainedReactionMultiplier m γ F q p)) +
        textbookConstraintCurvature m γ q p = 0 := by
  let G := textbookConstraintJacobian γ q
  let D := textbookInverseMassMatrix m
  let A := textbookConstraintGram m γ q
  let φ := textbookConstraintCurvature m γ q p
  let ρ := textbookConstrainedReactionMultiplier m γ F q p
  have hρ : A *ᵥ ρ = G *ᵥ (D *ᵥ F q) + φ := by
    change A *ᵥ (A⁻¹ *ᵥ (G *ᵥ (D *ᵥ F q) + φ)) = G *ᵥ (D *ᵥ F q) + φ
    rw [Matrix.mulVec_mulVec, Matrix.mul_nonsing_inv A (isUnit_iff_ne_zero.mpr hdet), Matrix.one_mulVec]
  have hterm : G *ᵥ (D *ᵥ (Gᵀ *ᵥ ρ)) = A *ᵥ ρ := by
    rw [Matrix.mulVec_mulVec, Matrix.mulVec_mulVec]
    rfl
  change G *ᵥ (D *ᵥ (F q - Gᵀ *ᵥ ρ)) + φ = 0
  rw [Matrix.mulVec_sub, Matrix.mulVec_sub, hterm, hρ]
  abel

private theorem hidden_constraint_hasDerivWithinAt_zero {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : ℝ → Fin Nc → ℝ) (s : Set ℝ) (t : ℝ) (j : Fin Mc)
    (hγ : ContDiff ℝ 2 (γ j)) (hdet : (textbookConstraintGram m γ (q t)).det ≠ 0)
    (hq : HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) s t)
    (hp : HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) s t) :
    HasDerivWithinAt (fun u => (fderiv ℝ (γ j) (q u))
      (textbookInverseMassMatrix m *ᵥ p u)) 0 s t := by
  let D := textbookInverseMassMatrix m
  let L := (D.toLin').toContinuousLinearMap
  have hc := ((hγ.fderiv_right (m := 1) (by norm_num)).differentiable_one (q t)).hasFDerivAt
    |>.comp_hasDerivWithinAt t hq
  have hv := L.hasFDerivAt.comp_hasDerivWithinAt t hp
  have hd := hc.clm_apply hv
  change HasDerivWithinAt (fun u => (fderiv ℝ (γ j) (q u)) (D *ᵥ p u))
    ((fderiv ℝ (fderiv ℝ (γ j)) (q t)) (D *ᵥ p t) (D *ᵥ p t) +
      (fderiv ℝ (γ j) (q t)) (D *ᵥ (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)))) s t at hd
  have hz : (fderiv ℝ (fderiv ℝ (γ j)) (q t)) (D *ᵥ p t) (D *ᵥ p t) +
      (fderiv ℝ (γ j) (q t)) (D *ᵥ (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t))) = 0 := by
    have hh := congrFun (textbookConstrainedReaction_balance m γ F (q t) (p t) hdet) j
    rw [Pi.add_apply, textbookConstraintJacobian_mulVec] at hh
    change (fderiv ℝ (γ j) (q t)) (D *ᵥ (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
      textbookConstrainedReactionMultiplier m γ F (q t) (p t))) +
        (fderiv ℝ (fderiv ℝ (γ j)) (q t)) (D *ᵥ p t) (D *ᵥ p t) = 0 at hh
    simpa only [add_comm] using hh
  rw [hz] at hd
  exact hd

private theorem real_curve_const_of_closed_deriv_zero (f : ℝ → ℝ) (τ : ℝ)
    (hd : ∀ t ∈ Icc 0 τ, HasDerivWithinAt f 0 (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, f t = f 0 := by
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)

/-- Initial position and hidden constraints persist along the given actual
reduced ODE with its constructed reaction, including the closed endpoints.
Neither retained constraints nor their time derivatives are supplied. -/
theorem textbookConstrainedODE_cotangent_invariant {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : ℝ → Fin Nc → ℝ) (τ : ℝ) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hdet : ∀ t ∈ Icc 0 τ, (textbookConstraintGram m γ (q t)).det ≠ 0)
    (hq : ∀ t ∈ Icc 0 τ, HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) (Icc 0 τ) t)
    (hp : ∀ t ∈ Icc 0 τ, HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) (Icc 0 τ) t)
    (hpos₀ : ∀ j, γ j (q 0) = 0)
    (hhidden₀ : ∀ j, (fderiv ℝ (γ j) (q 0)) (textbookInverseMassMatrix m *ᵥ p 0) = 0) :
    ∀ t ∈ Icc 0 τ, ∀ j, γ j (q t) = 0 ∧
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 := by
  have hhidden (j : Fin Mc) (t : ℝ) (ht : t ∈ Icc 0 τ) :
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 := by
    exact (real_curve_const_of_closed_deriv_zero _ τ
      (fun u hu => hidden_constraint_hasDerivWithinAt_zero m γ F q p (Icc 0 τ) u j
        (hγ j) (hdet u hu) (hq u hu) (hp u hu)) t ht).trans (hhidden₀ j)
  have hpos (j : Fin Mc) : ∀ t ∈ Icc 0 τ, γ j (q t) = γ j (q 0) := by
    apply real_curve_const_of_closed_deriv_zero _ τ
    intro t ht
    simpa only [hhidden j t ht, Function.comp_def] using
      ((hγ j).differentiable (by norm_num) (q t)).hasFDerivAt.comp_hasDerivWithinAt t (hq t ht)
  intro t ht j
  exact ⟨(hpos j t ht).trans (hpos₀ j), hhidden j t ht⟩

end MolecularDynamics
