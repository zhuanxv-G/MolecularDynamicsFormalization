import MolecularDynamics.Chapter02.SymplecticMaps
import Mathlib.Analysis.Calculus.Deriv.Prod
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.FDeriv.Symmetric
import Mathlib.LinearAlgebra.Matrix.Symmetric
import Mathlib.Analysis.Matrix.Normed

/-!
# The time-dependent Hamiltonian variational equation

Printed79/PDF101, §2.3.4.  All derivatives below are actual derivatives of
matrix curves, checked entry by entry.  The time-dependent variational
equation is explicit input; identifying it with the Jacobian of an actual
nonlinear Hamiltonian flow is a separate pending dependency.
-/

open Set Matrix
open scoped Matrix Matrix.Norms.Elementwise

namespace MolecularDynamics

private theorem matrix_curve_deriv_transpose {Nc : ℕ}
    {W : ℝ → SymplecticCoordinateMatrix Nc} {W' : SymplecticCoordinateMatrix Nc}
    {s : Set ℝ} {t : ℝ} (hW : HasDerivWithinAt W W' s t) :
    HasDerivWithinAt (fun u => (W u)ᵀ) W'ᵀ s t := by
  apply hasDerivWithinAt_pi.mpr
  intro i
  apply hasDerivWithinAt_pi.mpr
  intro j
  exact hasDerivWithinAt_pi.mp (hasDerivWithinAt_pi.mp hW j) i

private theorem matrix_curve_deriv_mul {Nc : ℕ}
    {A B : ℝ → SymplecticCoordinateMatrix Nc}
    {A' B' : SymplecticCoordinateMatrix Nc} {s : Set ℝ} {t : ℝ}
    (hA : HasDerivWithinAt A A' s t) (hB : HasDerivWithinAt B B' s t) :
    HasDerivWithinAt (fun u => A u * B u) (A' * B t + A t * B') s t := by
  apply hasDerivWithinAt_pi.mpr
  intro i
  apply hasDerivWithinAt_pi.mpr
  intro j
  have h := HasDerivWithinAt.fun_sum (u := Finset.univ) fun k _ =>
    (hasDerivWithinAt_pi.mp (hasDerivWithinAt_pi.mp hA i) k).mul
      (hasDerivWithinAt_pi.mp (hasDerivWithinAt_pi.mp hB k) j)
  simpa only [Pi.mul_apply, Matrix.mul_apply, Matrix.add_apply,
    Finset.sum_add_distrib] using h

/-- Symmetry of the genuine second derivative, in the coordinate basis. -/
noncomputable def textbookHamiltonianHessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)

theorem textbookHamiltonianHessian_isSymm {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm := by
  apply Matrix.IsSymm.ext
  intro i j
  exact hH.isSymmSndFDerivAt (by norm_num) (Pi.single j 1) (Pi.single i 1)

/-- The two terms in the product rule cancel for each symmetric S(t). -/
theorem hamiltonian_variational_matrix_cancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0 := by
  have hleft : (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W = Wᵀ * S * W := by
    rw [Matrix.transpose_mul, Matrix.transpose_mul, hS.eq, textbookJ_transpose]
    calc
      Wᵀ * (S * (-textbookJ Nc)) * textbookJ Nc * W =
          -(Wᵀ * S * (textbookJ Nc * textbookJ Nc) * W) := by noncomm_ring
      _ = Wᵀ * S * W := by rw [textbookJ_squared]; simp
  have hright : Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = -(Wᵀ * S * W) := by
    calc
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) =
          Wᵀ * (textbookJ Nc * textbookJ Nc) * S * W := by noncomm_ring
      _ = -(Wᵀ * S * W) := by rw [textbookJ_squared]; simp
  rw [hleft, hright, add_neg_cancel]

/-- Actual differentiation of W(t)ᵀ J W(t), without differentiating S(t). -/
theorem hasDerivWithinAt_hamiltonian_variational_form {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (s : Set ℝ) (t : ℝ)
    (hS : (S t).IsSymm)
    (hW : HasDerivWithinAt W (textbookJ Nc * S t * W t) s t) :
    HasDerivWithinAt (fun u => (W u)ᵀ * textbookJ Nc * W u) 0 s t := by
  have h := matrix_curve_deriv_mul
    (matrix_curve_deriv_mul (matrix_curve_deriv_transpose hW)
      (hasDerivWithinAt_const t s (textbookJ Nc))) hW
  simpa only [Matrix.mul_zero, add_zero,
    hamiltonian_variational_matrix_cancellation (S t) (W t) hS] using h

/-- The actual product is constant on the entire closed solution interval. -/
theorem hamiltonian_variational_form_constant {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, (W t)ᵀ * textbookJ Nc * W t = (W 0)ᵀ * textbookJ Nc * W 0 := by
  have hQ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt (fun u => (W u)ᵀ * textbookJ Nc * W u) 0 (Icc 0 τ) t :=
    fun t ht => hasDerivWithinAt_hamiltonian_variational_form S W (Icc 0 τ) t
      (hS t ht) (hW t ht)
  apply constant_of_has_deriv_right_zero
    (fun t ht => (hQ t ht).continuousWithinAt)
  intro t ht
  exact (hQ t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin
    (Icc_mem_nhdsGE_of_mem ht)

/-- Initial identity and the true variational equation imply the symplectic condition. -/
theorem hamiltonian_variational_isSymplectic {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t)
    (hinit : W 0 = 1) : ∀ t ∈ Icc 0 τ, IsTextbookSymplectic (W t) := by
  intro t ht
  have h := hamiltonian_variational_form_constant S W τ hS hW t ht
  simpa only [IsTextbookSymplectic, hinit, Matrix.transpose_one,
    Matrix.one_mul, Matrix.mul_one] using h

/-- A genuine C² Hamiltonian supplies the symmetric coefficient in the equation. -/
theorem hamiltonian_hessian_variational_isSymplectic {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : ℝ → SymplecticCoordinates Nc)
    (W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, ContDiffAt ℝ 2 H (z t))
    (hW : ∀ t ∈ Icc 0 τ, HasDerivWithinAt W
      (textbookJ Nc * textbookHamiltonianHessian H (z t) * W t) (Icc 0 τ) t)
    (hinit : W 0 = 1) : ∀ t ∈ Icc 0 τ, IsTextbookSymplectic (W t) := by
  exact hamiltonian_variational_isSymplectic
    (fun t => textbookHamiltonianHessian H (z t)) W τ
    (fun t ht => textbookHamiltonianHessian_isSymm H (z t) (hH t ht)) hW hinit

/-- Conditional bridge for the actual flow Jacobian.  Deriving the
variational equation from a nonlinear ODE is not assumed to be done here. -/
theorem hamiltonian_flow_isSymplectic_of_variational_equation {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ)
    (F : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc) (τ : ℝ)
    (hF : ∀ t ∈ Icc 0 τ, ContDiff ℝ 1 (F t))
    (hH : ∀ t ∈ Icc 0 τ, ∀ z, ContDiffAt ℝ 2 H (F t z))
    (hvar : ∀ z t, t ∈ Icc 0 τ →
      HasDerivWithinAt (fun u => textbookJacobian (F u) z)
        (textbookJ Nc * textbookHamiltonianHessian H (F t z) *
          textbookJacobian (F t) z) (Icc 0 τ) t)
    (hinit : F 0 = id) : ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (F t) := by
  intro t ht
  refine ⟨hF t ht, ?_⟩
  intro z
  apply hamiltonian_hessian_variational_isSymplectic H (fun u => F u z)
    (fun u => textbookJacobian (F u) z) τ
    (fun u hu => hH u hu z) (hvar z) ?_ t ht
  rw [hinit, textbookJacobian_id]

end MolecularDynamics
