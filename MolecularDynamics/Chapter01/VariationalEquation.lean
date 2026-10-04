import MolecularDynamics.Chapter01.MatrixFlow
import MolecularDynamics.Chapter01.RealSpectralFlow
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

/-!
# Constant-coefficient variational equations

Printed pages 44--47/PDF pages 67--70 introduce the variational equation
`W' = f'(z(t)) W` and then list basic matrix-exponential exercises.  This
module records the exact constant-coefficient specialization `W' = A W`:
the exponential flow is a solution and is unique from its initial value.
The matrix-exponential identities below are the corresponding exercise-2
identities; a time-dependent Jacobian and Lyapunov-exponent limit are separate
claims and are not assumed here.
-/

open NormedSpace

namespace MolecularDynamics

section Banach

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

/-- The constant-coefficient variational equation used by the linearized flow. -/
def IsConstantVariationalSolution (A : E →L[ℝ] E) (W : ℝ → E) (w₀ : E) : Prop :=
  W 0 = w₀ ∧ ∀ t, HasDerivAt W (A (W t)) t

theorem linearExponentialFlow_isConstantVariationalSolution
    (A : E →L[ℝ] E) (w₀ : E) :
    IsConstantVariationalSolution A (fun t => linearExponentialFlow A t w₀) w₀ := by
  constructor
  · simp [linearExponentialFlow]
  · intro t
    exact hasDerivAt_linearExponentialFlow A w₀ t

theorem constantVariationalSolution_unique
    (A : E →L[ℝ] E) (W : ℝ → E) (w₀ : E)
    (hW : IsConstantVariationalSolution A W w₀) :
    W = fun t => linearExponentialFlow A t w₀ := by
  simpa only [sub_zero] using linearExponentialFlow_unique A w₀ 0 W hW.2 hW.1

end Banach

section Matrix

open scoped Matrix

theorem matrixExponential_zero {m : ℕ} :
    NormedSpace.exp (0 : Matrix (Fin m) (Fin m) ℝ) = 1 := by
  exact NormedSpace.exp_zero

theorem matrixExponential_add_of_commute {m : ℕ}
    (A B : Matrix (Fin m) (Fin m) ℝ) (h : Commute A B) :
    NormedSpace.exp (A + B) = NormedSpace.exp A * NormedSpace.exp B := by
  exact Matrix.exp_add_of_commute A B h

theorem matrixExponential_neg {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ) :
    NormedSpace.exp (-A) = (NormedSpace.exp A)⁻¹ := by
  exact Matrix.exp_neg A

theorem matrixExponentialFlow_realEigenmode {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ) (ω : ℝ) (v : Position m)
    (hA : WithLp.toLp 2 (A.mulVec (WithLp.ofLp v)) = ω • v) (t : ℝ) :
    matrixExponentialFlow A t v = Real.exp (ω * t) • v := by
  exact linearExponentialFlow_realEigenmode
    (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) ω v hA t

theorem matrixExponentialFlow_diagonal {m : ℕ}
    (d : Fin m → ℝ) (t : ℝ) (z : Position m) :
    matrixExponentialFlow (Matrix.diagonal d) t z =
      WithLp.toLp 2 (fun i => Real.exp (t * d i) * (WithLp.ofLp z) i) := by
  rw [matrixExponentialFlow_eq]
  have hsmul : t • Matrix.diagonal d = Matrix.diagonal (fun i => t * d i) := by
    ext i j
    by_cases hij : i = j <;> simp [hij]
  rw [hsmul, Matrix.exp_diagonal]
  congr 1
  funext i
  rw [Matrix.mulVec_diagonal]
  rw [Pi.coe_exp]
  rw [← Real.exp_eq_exp_ℝ]

theorem matrixExponential_conjugate {m : ℕ}
    (X D : Matrix (Fin m) (Fin m) ℝ) (hX : IsUnit X) :
    NormedSpace.exp (X * D * X⁻¹) =
      X * NormedSpace.exp D * X⁻¹ := by
  exact Matrix.exp_conj X D hX

end Matrix

end MolecularDynamics
