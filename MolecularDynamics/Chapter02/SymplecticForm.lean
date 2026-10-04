import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Algebra.Bilinear
import Mathlib.LinearAlgebra.SymplecticGroup
import Mathlib.LinearAlgebra.Matrix.BilinearForm
import Mathlib.Tactic.Ring

/-!
# The standard symplectic form and its coordinate pullback

Leimkuhler--Matthews, §2.3.3, printed pages 76--78 / PDF pages 98--100,
and the matrix algebra used in §2.3.5, printed page 79 / PDF page 101.
Position and momentum coordinates have distinct labels. The textbook's
`J = [0, I; -I, 0]` is the negative of mathlib's canonical `Matrix.J`.
The bundled bilinear form is proved to be the actual sum of `dq_i ∧ dp_i`.
These are coordinate and matrix results; they do not assert global
invertibility of an arbitrary nonlinear map or its variational equation.
-/

open Matrix
open scoped BigOperators Matrix

namespace MolecularDynamics

/-- Configuration and momentum coordinates, in that order. -/
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ

abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ

/-- The exact sign convention of the textbook. -/
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0

theorem textbookJ_eq_neg_mathlibJ (Nc : ℕ) :
    textbookJ Nc = -Matrix.J (Fin Nc) ℝ := by
  ext (i | i) (j | j) <;> simp [textbookJ, Matrix.J]

theorem textbookJ_transpose (Nc : ℕ) : (textbookJ Nc)ᵀ = -textbookJ Nc := by
  rw [textbookJ_eq_neg_mathlibJ]
  simp [Matrix.J_transpose]

theorem textbookJ_squared (Nc : ℕ) : textbookJ Nc * textbookJ Nc = -1 := by
  rw [textbookJ_eq_neg_mathlibJ]
  simp [Matrix.J_squared]

/-- The coordinate one-form `dq_i` evaluates a position component of the tangent vector. -/
def textbookDq {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinates Nc →ₗ[ℝ] ℝ where
  toFun u := u (Sum.inl i)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

/-- The coordinate one-form `dp_i` evaluates a momentum component of the tangent vector. -/
def textbookDp {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinates Nc →ₗ[ℝ] ℝ where
  toFun u := u (Sum.inr i)
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

@[simp] theorem textbookDq_apply {Nc : ℕ} (i : Fin Nc) (u : SymplecticCoordinates Nc) :
    textbookDq i u = u (Sum.inl i) := rfl

@[simp] theorem textbookDp_apply {Nc : ℕ} (i : Fin Nc) (u : SymplecticCoordinates Nc) :
    textbookDp i u = u (Sum.inr i) := rfl

/-- The wedge of the actual one-forms, bundled as a bilinear form. -/
def textbookWedgeOneForms {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring

/-- The standard two-form as a genuine bundled bilinear form. -/
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'

/-- Its literal coordinate value is the sum of the coordinate wedge products. -/
theorem textbookSymplecticForm_coordinates (Nc : ℕ) (u v : SymplecticCoordinates Nc) :
    textbookSymplecticForm Nc u v =
      ∑ i : Fin Nc, (u (Sum.inl i) * v (Sum.inr i) - u (Sum.inr i) * v (Sum.inl i)) := by
  simp [textbookSymplecticForm, Matrix.toBilin'_apply', textbookJ,
    Matrix.fromBlocks_mulVec, Matrix.neg_mulVec, dotProduct, Fintype.sum_sum_type,
    Finset.sum_add_distrib, sub_eq_add_neg]

theorem textbookSymplecticForm_eq_sum_wedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i) := by
  apply LinearMap.ext
  intro u
  apply LinearMap.ext
  intro v
  simp only [LinearMap.sum_apply, textbookSymplecticForm_coordinates,
    textbookWedgeOneForms_apply, textbookDq_apply, textbookDp_apply]
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem textbookSymplecticForm_self (Nc : ℕ) (u : SymplecticCoordinates Nc) :
    textbookSymplecticForm Nc u u = 0 := by
  rw [textbookSymplecticForm_coordinates]
  simp [mul_comm]

theorem textbookSymplecticForm_skew (Nc : ℕ) (u v : SymplecticCoordinates Nc) :
    textbookSymplecticForm Nc v u = -textbookSymplecticForm Nc u v := by
  rw [textbookSymplecticForm_coordinates, textbookSymplecticForm_coordinates,
    ← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro i _
  ring

/-- The actual pullback under the tangent-coordinate map represented by `A`. -/
noncomputable def textbookSymplecticPullback {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookSymplecticForm Nc).comp A.toLin' A.toLin'

theorem textbookSymplecticPullback_apply {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc)
    (u v : SymplecticCoordinates Nc) :
    textbookSymplecticPullback A u v = textbookSymplecticForm Nc (A *ᵥ u) (A *ᵥ v) := rfl

/-- The coordinate coefficient matrix of that pullback is `Aᵀ J A`. -/
theorem textbookSymplecticPullback_matrix {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) :
    textbookSymplecticPullback A = (Aᵀ * textbookJ Nc * A).toBilin' := by
  exact Matrix.toBilin'_comp (textbookJ Nc) A A

/-- Equation (2.17) for a tangent-coordinate matrix. -/
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc

theorem isTextbookSymplectic_iff_pullback {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) :
    IsTextbookSymplectic A ↔ textbookSymplecticPullback A = textbookSymplecticForm Nc := by
  rw [IsTextbookSymplectic, textbookSymplecticPullback_matrix]
  change _ ↔ (Aᵀ * textbookJ Nc * A).toBilin' = (textbookJ Nc).toBilin'
  constructor
  · exact congrArg (fun M : SymplecticCoordinateMatrix Nc => M.toBilin')
  · intro h
    exact (Matrix.toBilin' (n := Fin Nc ⊕ Fin Nc) (R₁ := ℝ)).injective h

/-- Preserving the actual two-form is equivalent to the textbook matrix condition. -/
theorem isTextbookSymplectic_iff_preserves_form {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) :
    IsTextbookSymplectic A ↔ ∀ u v : SymplecticCoordinates Nc,
      textbookSymplecticForm Nc (A *ᵥ u) (A *ᵥ v) = textbookSymplecticForm Nc u v := by
  rw [isTextbookSymplectic_iff_pullback]
  constructor
  · intro h u v
    exact congrArg (fun B : LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) => B u v) h
  · intro h
    exact LinearMap.ext (fun u => LinearMap.ext (fun v => h u v))

/-- The sign and transpose conventions are explicitly bridged to fixed mathlib. -/
theorem isTextbookSymplectic_iff_mathlib {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) :
    IsTextbookSymplectic A ↔ A ∈ Matrix.symplecticGroup (Fin Nc) ℝ := by
  rw [IsTextbookSymplectic, SymplecticGroup.mem_iff', textbookJ_eq_neg_mathlibJ]
  simp

theorem isTextbookSymplectic_one (Nc : ℕ) :
    IsTextbookSymplectic (1 : SymplecticCoordinateMatrix Nc) := by
  simp [IsTextbookSymplectic]

/-- The product of symplectic tangent matrices is symplectic. -/
theorem IsTextbookSymplectic.mul {Nc : ℕ} {A B : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) (hB : IsTextbookSymplectic B) :
    IsTextbookSymplectic (A * B) := by
  apply (isTextbookSymplectic_iff_mathlib (A * B)).mpr
  exact (Matrix.symplecticGroup (Fin Nc) ℝ).mul_mem
    ((isTextbookSymplectic_iff_mathlib A).mp hA) ((isTextbookSymplectic_iff_mathlib B).mp hB)

/-- Fixed mathlib proves the stronger positive sign without a path assumption. -/
theorem IsTextbookSymplectic.det_eq_one {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : A.det = 1 := by
  exact SymplecticGroup.det_eq_one ((isTextbookSymplectic_iff_mathlib A).mp hA)

/-- The determinant-squared conclusion explicitly displayed in the textbook. -/
theorem IsTextbookSymplectic.det_square {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : A.det ^ 2 = 1 := by
  rw [hA.det_eq_one]
  simp

theorem IsTextbookSymplectic.abs_det {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : |A.det| = 1 := by
  rw [hA.det_eq_one]
  exact abs_one

/-- A symplectic matrix, as opposed to a general nonlinear map, has an inverse. -/
theorem IsTextbookSymplectic.inv {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : IsTextbookSymplectic A⁻¹ := by
  apply (isTextbookSymplectic_iff_mathlib A⁻¹).mpr
  let S : Matrix.symplecticGroup (Fin Nc) ℝ := ⟨A, (isTextbookSymplectic_iff_mathlib A).mp hA⟩
  have hinv := (S⁻¹).property
  change (↑S⁻¹ : SymplecticCoordinateMatrix Nc) ∈ Matrix.symplecticGroup (Fin Nc) ℝ at hinv
  rw [SymplecticGroup.coe_inv'] at hinv
  exact hinv

theorem IsTextbookSymplectic.inv_formula {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : A⁻¹ = -textbookJ Nc * Aᵀ * textbookJ Nc := by
  rw [SymplecticGroup.inv_eq_symplectic_inv A ((isTextbookSymplectic_iff_mathlib A).mp hA),
    textbookJ_eq_neg_mathlibJ]
  simp

end MolecularDynamics
