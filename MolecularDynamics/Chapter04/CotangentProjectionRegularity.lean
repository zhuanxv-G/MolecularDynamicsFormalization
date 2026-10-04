import MolecularDynamics.Chapter04.CotangentProjection
import Mathlib.Analysis.Calculus.ContDiff.Operations
import Mathlib.Analysis.Matrix.Normed

/-!
# Regularity of the actual Gram projection

Printed159--160/PDF181--182.  The C¹ multiplier is derived from the
actual inverse formula, rather than supplied as separate method data.
This constructs the final linear projection branch, not the initial
nonlinear position solve.
-/

open Matrix Filter
open scoped BigOperators Topology Matrix.Norms.Elementwise

namespace MolecularDynamics

section Regularity

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

private theorem entries_contDiffAt_det {n : ℕ} (A : E → Matrix (Fin n) (Fin n) ℝ)
    (x : E) (hA : ∀ i j, ContDiffAt ℝ 1 (fun y => A y i j) x) :
    ContDiffAt ℝ 1 (fun y => (A y).det) x := by
  classical
  simp only [Matrix.det_apply']
  exact ContDiffAt.sum fun σ _ => contDiffAt_const.mul
    (contDiffAt_prod fun i _ => hA (σ i) i)

private theorem entries_contDiffAt_inverse {n : ℕ} (A : E → Matrix (Fin n) (Fin n) ℝ)
    (x : E) (hA : ∀ i j, ContDiffAt ℝ 1 (fun y => A y i j) x)
    (hdet : (A x).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => (A y)⁻¹) x := by
  classical
  apply contDiffAt_pi.mpr
  intro i
  apply contDiffAt_pi.mpr
  intro j
  simp only [Matrix.inv_def, Ring.inverse_eq_inv, Matrix.smul_apply, smul_eq_mul,
    Matrix.adjugate_apply]
  apply ((entries_contDiffAt_det A x hA).inv hdet).mul
  apply entries_contDiffAt_det
  intro k l
  by_cases hk : k = j
  · simp only [Matrix.updateRow_apply, hk, ite_true]
    exact contDiffAt_const
  · simpa only [Matrix.updateRow_apply, hk, ite_false] using hA k l

theorem contDiffAt_textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x) :
    ContDiffAt ℝ 1 (fun y => textbookConstraintJacobian γ (q y)) x := by
  apply contDiffAt_pi.mpr
  intro j
  change ContDiffAt ℝ 1 (fun y => textbookConstraintGradient (γ j) (q y)) x
  simpa only [Function.comp_def] using
    (contDiff_textbookConstraintGradient (γ j) (hγ j)).contDiffAt.comp x hq

theorem contDiffAt_textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x) :
    ContDiffAt ℝ 1 (fun y => textbookConstraintGram m γ (q y)) x := by
  have hG := contDiffAt_textbookConstraintJacobian γ q x hγ hq
  have hg (i : Fin Mc) (j : Fin Nc) := contDiffAt_pi.mp (contDiffAt_pi.mp hG i) j
  apply contDiffAt_pi.mpr
  intro i
  apply contDiffAt_pi.mpr
  intro j
  simp only [textbookConstraintGram, Matrix.mul_apply, Matrix.transpose_apply]
  exact ContDiffAt.sum fun k _ =>
    (ContDiffAt.sum fun l _ => (hg i l).mul contDiffAt_const).mul (hg j k)

/-- The actual Gram inverse, needed also by the continuous constraint reaction. -/
theorem contDiffAt_textbookConstraintGram_inverse {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => (textbookConstraintGram m γ (q y))⁻¹) x := by
  have hA := contDiffAt_textbookConstraintGram m γ q x hγ hq
  exact entries_contDiffAt_inverse (fun y => textbookConstraintGram m γ (q y)) x
    (fun i j => contDiffAt_pi.mp (contDiffAt_pi.mp hA i) j) hdet

theorem contDiffAt_textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentMultiplier m γ (q y) (p y)) x := by
  have hG := contDiffAt_textbookConstraintJacobian γ q x hγ hq
  have hg (i : Fin Mc) (j : Fin Nc) := contDiffAt_pi.mp (contDiffAt_pi.mp hG i) j
  have hA := contDiffAt_textbookConstraintGram m γ q x hγ hq
  have hI := entries_contDiffAt_inverse (fun y => textbookConstraintGram m γ (q y)) x
    (fun i j => contDiffAt_pi.mp (contDiffAt_pi.mp hA i) j) hdet
  apply contDiffAt_pi.mpr
  intro i
  simp only [textbookCotangentMultiplier, Matrix.mulVec, dotProduct]
  exact ContDiffAt.sum fun j _ =>
    (contDiffAt_pi.mp (contDiffAt_pi.mp hI i) j).mul
      (ContDiffAt.sum fun k _ => (hg j k).mul
        (ContDiffAt.sum fun l _ => contDiffAt_const.mul (contDiffAt_pi.mp hp l)))

theorem contDiffAt_textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentProjection m γ (q y) (p y)) x := by
  have hG := contDiffAt_textbookConstraintJacobian γ q x hγ hq
  have hμ := contDiffAt_textbookCotangentMultiplier m γ q p x hγ hq hp hdet
  apply contDiffAt_pi.mpr
  intro i
  simp only [textbookCotangentProjection, Pi.sub_apply, Matrix.mulVec, dotProduct,
    Matrix.transpose_apply]
  exact (contDiffAt_pi.mp hp i).sub (ContDiffAt.sum fun j _ =>
    (contDiffAt_pi.mp (contDiffAt_pi.mp hG j) i).mul (contDiffAt_pi.mp hμ j))

/-- The actual inverse-formula projection preserves the constrained pullback.
Its multiplier regularity is proved above, rather than requested as a premise. -/
theorem textbookCotangentProjection_preserves_pullback {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x u)
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  have hμ := contDiffAt_textbookCotangentMultiplier m γ q p x hγ hq hp hdet
  have heq : (fun y => textbookCotangentProjection m γ (q y) (p y)) =
      textbookMultiConstrainedMomentum Finset.univ γ
        (fun j y => textbookCotangentMultiplier m γ (q y) (p y) j) q p := by
    funext y
    rw [textbookCotangentProjection_eq_gradient_sum]
    rfl
  rw [heq]
  exact textbookMultiConstrainedMomentum_preserves_pullback Finset.univ γ
    (fun j y => textbookCotangentMultiplier m γ (q y) (p y) j) q x
    (hq.differentiableAt (by norm_num)) (fun j _ => hγ j)
    (fun j _ => (contDiffAt_pi.mp hμ j).differentiableAt (by norm_num))
    (fun j _ => hconstraint j) p (hp.differentiableAt (by norm_num)) u v

theorem contDiffAt_textbookProjectedEulerPreMomentum {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x) :
    ContDiffAt ℝ 1 (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) x := by
  have hF := (contDiff_textbookPotentialForce U hU).contDiffAt.comp x hq
  have hg (j : Fin Mc) := (contDiff_textbookConstraintGradient (γ j) (hγ j)).contDiffAt.comp x hq
  unfold textbookProjectedEulerPreMomentum textbookMultiConstrainedMomentum
  simpa only [Function.comp_def] using
    (hp.add (contDiffAt_const.fun_smul hF)).sub
      (ContDiffAt.sum fun j _ => (contDiffAt_const.mul (hlam j)).fun_smul (hg j))

theorem contDiffAt_textbookProjectedEulerPosition {Nc : ℕ}
    (m : Fin Nc → ℝ) (h : ℝ) (q P : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hP : ContDiffAt ℝ 1 P x) :
    ContDiffAt ℝ 1 (textbookProjectedEulerPosition m h q P) x := by
  unfold textbookProjectedEulerPosition
  exact contDiffAt_pi.mpr fun i =>
    (contDiffAt_pi.mp hq i).add (contDiffAt_const.mul (contDiffAt_pi.mp hP i))

/-- The final multiplier and momentum are constructed by the actual Gram inverse. -/
noncomputable def textbookGramProjectedEulerChart {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) : E → SymplecticCoordinates Nc :=
  let P := textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p
  let Q := textbookProjectedEulerPosition m h q P
  textbookCotangentChart Q (fun y => textbookCotangentProjection m γ (Q y) (P y))

/-- The actual integrator has its hidden constraint and full three-stage
restricted form identity, with no supplied final multiplier or its regularity.
The initial nonlinear solving branch is still specified as genuine method data. -/
theorem textbookGramProjectedEulerChart_hiddenConstraint_and_pullback {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  let P := textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p
  let Q := textbookProjectedEulerPosition m h q P
  let μ : Fin Mc → E → ℝ := fun j y => textbookCotangentMultiplier m γ (Q y) (P y) j
  have hP := contDiffAt_textbookProjectedEulerPreMomentum γ lam U h a q p x hq hp hU hγ hlam
  have hQ := contDiffAt_textbookProjectedEulerPosition m h q P x hq hP
  have hμ := contDiffAt_textbookCotangentMultiplier m γ Q P x hγ hQ hP hdet
  constructor
  · intro j
    change (fderiv ℝ (γ j) (Q x))
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ (Q x) (P x)) = 0
    exact textbookCotangentProjection_constraint_derivative_zero m γ (Q x) (P x) hdet j
  · have heq : textbookGramProjectedEulerChart γ lam m U h a q p =
        textbookProjectedEulerChart Finset.univ γ lam μ m U h a q p := by
      have hproj : (fun y => textbookCotangentProjection m γ (Q y) (P y)) =
          textbookMultiConstrainedMomentum Finset.univ γ μ Q P := by
        funext y
        rw [textbookCotangentProjection_eq_gradient_sum]
        rfl
      change textbookCotangentChart Q _ = textbookCotangentChart Q _
      rw [hproj]
    rw [heq]
    exact textbookProjectedEulerChart_preserves_pullback Finset.univ γ lam μ m U h a q p x
      (hq.differentiableAt (by norm_num)) (hp.differentiableAt (by norm_num)) hU
      (fun j _ => hγ j) (fun j _ => (hlam j).differentiableAt (by norm_num))
      (fun j _ => (contDiffAt_pi.mp hμ j).differentiableAt (by norm_num))
      (fun j _ => hold j) (fun j _ => hnew j) u v

end Regularity

end MolecularDynamics
