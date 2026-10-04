import MolecularDynamics.Chapter02.SymplecticForm
import Mathlib.Analysis.Calculus.ContDiff.Comp
import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Algebra.Group.End

/-!
# Actual Jacobians and the group of symplectic coordinate diffeomorphisms

Leimkuhler--Matthews, §2.3.3 and §2.3.5, printed pages 76--79 / PDF 98--101.
The Jacobian is the coordinate matrix of the actual Fréchet derivative.
Global invertibility is represented by a genuine equivalence, with C¹
forward and inverse maps; it is not inferred from pointwise invertibility.
-/

open Matrix
open scoped Matrix

namespace MolecularDynamics

/-- The coordinate matrix of the actual derivative, using the coordinate basis. -/
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap

theorem textbookJacobian_entry {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc)
    (i j : Fin Nc ⊕ Fin Nc) :
    textbookJacobian Φ z i j = ((fderiv ℝ Φ z) (Pi.single j 1)) i := rfl

theorem textbookJacobian_mulVec {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (z u : SymplecticCoordinates Nc) :
    textbookJacobian Φ z *ᵥ u = (fderiv ℝ Φ z) u := by
  exact LinearMap.toMatrix'_mulVec _ u

theorem textbookJacobian_id (Nc : ℕ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (id : SymplecticCoordinates Nc → SymplecticCoordinates Nc) z = 1 := by
  unfold textbookJacobian
  rw [fderiv_id]
  exact LinearMap.toMatrix'_id

/-- The chain rule, for actual derivatives and their actual coordinate matrices. -/
theorem textbookJacobian_comp {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  unfold textbookJacobian
  have hchain : fderiv ℝ (Φ ∘ Ψ) z = (fderiv ℝ Φ (Ψ z)).comp (fderiv ℝ Ψ z) :=
    fderiv_comp z (hΦ (Ψ z)) (hΨ z)
  rw [hchain]
  exact LinearMap.toMatrix'_comp _ _

/-- The C¹ map definition with the literal condition (2.17) at every point. -/
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)

/-- The actual derivative preserves the actual standard two-form exactly
when the map satisfies the textbook's Jacobian condition. -/
theorem isTextbookSymplecticMap_iff_preserves_form {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  constructor
  · intro h
    refine ⟨h.1, ?_⟩
    intro z u v
    simpa only [textbookJacobian_mulVec] using
      (isTextbookSymplectic_iff_preserves_form (textbookJacobian Φ z)).mp (h.2 z) u v
  · intro h
    refine ⟨h.1, ?_⟩
    intro z
    apply (isTextbookSymplectic_iff_preserves_form (textbookJacobian Φ z)).mpr
    intro u v
    simpa only [textbookJacobian_mulVec] using h.2 z u v

theorem isTextbookSymplecticMap_id (Nc : ℕ) :
    IsTextbookSymplecticMap (id : SymplecticCoordinates Nc → SymplecticCoordinates Nc) := by
  refine ⟨contDiff_id, ?_⟩
  intro z
  rw [textbookJacobian_id]
  exact isTextbookSymplectic_one Nc

theorem IsTextbookSymplecticMap.comp {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ) := by
  refine ⟨hΦ.1.comp hΨ.1, ?_⟩
  intro z
  rw [textbookJacobian_comp Φ Ψ hΦ.1.differentiable_one hΨ.1.differentiable_one]
  exact (hΦ.2 (Ψ z)).mul (hΨ.2 z)

theorem IsTextbookSymplecticMap.jacobian_det_eq_one {Nc : ℕ}
    {Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (z : SymplecticCoordinates Nc) :
    (textbookJacobian Φ z).det = 1 :=
  (hΦ.2 z).det_eq_one

/-- The inverse derivative formula comes from a true equivalence and the chain rule. -/
theorem textbookJacobian_equiv_symm {Nc : ℕ}
    (e : Equiv.Perm (SymplecticCoordinates Nc))
    (he : Differentiable ℝ (e : SymplecticCoordinates Nc → SymplecticCoordinates Nc))
    (hinv : Differentiable ℝ (e.symm : SymplecticCoordinates Nc → SymplecticCoordinates Nc))
    (z : SymplecticCoordinates Nc) :
    textbookJacobian e.symm z = (textbookJacobian e (e.symm z))⁻¹ := by
  have hid : (e : SymplecticCoordinates Nc → SymplecticCoordinates Nc) ∘ e.symm = id := by
    funext x
    exact e.apply_symm_apply x
  have h := textbookJacobian_comp e e.symm he hinv z
  rw [hid, textbookJacobian_id] at h
  exact (Matrix.inv_eq_right_inv h.symm).symm

/-- Globally invertible C¹ symplectic maps, with a genuinely C¹ inverse. -/
def IsTextbookSymplecticEquiv {Nc : ℕ} (e : Equiv.Perm (SymplecticCoordinates Nc)) : Prop :=
  IsTextbookSymplecticMap (e : SymplecticCoordinates Nc → SymplecticCoordinates Nc) ∧
    ContDiff ℝ 1 (e.symm : SymplecticCoordinates Nc → SymplecticCoordinates Nc)

theorem isTextbookSymplecticEquiv_refl (Nc : ℕ) :
    IsTextbookSymplecticEquiv (Equiv.refl (SymplecticCoordinates Nc)) := by
  exact ⟨isTextbookSymplecticMap_id Nc, contDiff_id⟩

theorem IsTextbookSymplecticEquiv.mul {Nc : ℕ}
    {e f : Equiv.Perm (SymplecticCoordinates Nc)}
    (he : IsTextbookSymplecticEquiv e) (hf : IsTextbookSymplecticEquiv f) :
    IsTextbookSymplecticEquiv (e * f) := by
  constructor
  · change IsTextbookSymplecticMap
      ((e : SymplecticCoordinates Nc → SymplecticCoordinates Nc) ∘ f)
    exact he.1.comp hf.1
  · change ContDiff ℝ 1
      ((f.symm : SymplecticCoordinates Nc → SymplecticCoordinates Nc) ∘ e.symm)
    exact hf.2.comp he.2

theorem IsTextbookSymplecticEquiv.symm {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  constructor
  · refine ⟨he.2, ?_⟩
    intro z
    rw [textbookJacobian_equiv_symm e he.1.1.differentiable_one he.2.differentiable_one]
    exact (he.1.2 (e.symm z)).inv
  · change ContDiff ℝ 1 (e : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    exact he.1.1

/-- The actual subgroup under composition, not just matrix closure or a proposition named group. -/
noncomputable def textbookSymplecticDiffeomorphismGroup (Nc : ℕ) :
    Subgroup (Equiv.Perm (SymplecticCoordinates Nc)) where
  carrier := {e | IsTextbookSymplecticEquiv e}
  one_mem' := isTextbookSymplecticEquiv_refl Nc
  mul_mem' he hf := he.mul hf
  inv_mem' he := he.symm

theorem textbookSymplecticDiffeomorphismGroup_mem_iff {Nc : ℕ}
    (e : Equiv.Perm (SymplecticCoordinates Nc)) :
    e ∈ textbookSymplecticDiffeomorphismGroup Nc ↔ IsTextbookSymplecticEquiv e := Iff.rfl

/-- The maps in the subgroup inherit its proven group structure. -/
noncomputable abbrev TextbookSymplecticDiffeomorphism (Nc : ℕ) :=
  textbookSymplecticDiffeomorphismGroup Nc

theorem textbookSymplecticDiffeomorphism_mul_apply {Nc : ℕ}
    (e f : TextbookSymplecticDiffeomorphism Nc) (z : SymplecticCoordinates Nc) :
    ((e * f).val : Equiv.Perm (SymplecticCoordinates Nc)) z = e.val (f.val z) := rfl

end MolecularDynamics
