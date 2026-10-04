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

noncomputable def upperTriangularMatrix (α : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1, α; 0, 1]

noncomputable def upperTriangularFlow (α : ℝ) (t : ℝ) (z : Position 2) : Position 2 :=
  WithLp.toLp 2 ![Real.exp t * ((WithLp.ofLp z) 0 + α * t * (WithLp.ofLp z) 1),
    Real.exp t * (WithLp.ofLp z) 1]

theorem hasDerivAt_positionPair (f g : ℝ → ℝ) (f' g' t : ℝ)
    (hf : HasDerivAt f f' t) (hg : HasDerivAt g g' t) :
    HasDerivAt (fun u => WithLp.toLp 2 ![f u, g u]) (WithLp.toLp 2 ![f', g']) t := by
  have hp : HasDerivAt (fun u => ![f u, g u]) ![f', g'] t := by
    apply hasDerivAt_pi.mpr
    intro i
    fin_cases i
    · exact hf
    · exact hg
  exact (PiLp.hasFDerivAt_toLp (𝕜 := ℝ) 2 _).comp_hasDerivAt t hp

theorem hasDerivAt_upperTriangularFlow (α : ℝ) (z : Position 2) (t : ℝ) :
    HasDerivAt (fun u => upperTriangularFlow α u z)
      (WithLp.toLp 2 ((upperTriangularMatrix α).mulVec
        (WithLp.ofLp (upperTriangularFlow α t z)))) t := by
  let z0 : ℝ := (WithLp.ofLp z) 0
  let z1 : ℝ := (WithLp.ofLp z) 1
  have hp : HasDerivAt (fun u : ℝ => z0 + α * u * z1) (α * z1) t := by
    convert (hasDerivAt_const t z0).add (((hasDerivAt_id t).const_mul α).mul_const z1) using 1
    · funext u
      simp only [Pi.add_apply, id_eq]
    · ring
  have h0 : HasDerivAt (fun u : ℝ => Real.exp u * (z0 + α * u * z1))
      (Real.exp t * (z0 + α * t * z1) + Real.exp t * (α * z1)) t := by
    convert (Real.hasDerivAt_exp t).mul hp using 1
  have h1 : HasDerivAt (fun u : ℝ => Real.exp u * z1) (Real.exp t * z1) t := by
    simpa using (Real.hasDerivAt_exp t).mul_const z1
  have hpair := hasDerivAt_positionPair
    (fun u => Real.exp u * (z0 + α * u * z1))
    (fun u => Real.exp u * z1)
    (Real.exp t * (z0 + α * t * z1) + Real.exp t * (α * z1))
    (Real.exp t * z1) t h0 h1
  have hvec :
      (WithLp.toLp 2 ((upperTriangularMatrix α).mulVec
        (WithLp.ofLp (upperTriangularFlow α t z)))) =
      WithLp.toLp 2 ![Real.exp t * (z0 + α * t * z1) + Real.exp t * (α * z1),
        Real.exp t * z1] := by
    congr 1
    funext i
    fin_cases i
    · simp [upperTriangularMatrix, upperTriangularFlow, z0, z1]
      ring
    · simp [upperTriangularMatrix, upperTriangularFlow, z0, z1]
  rw [hvec]
  simpa [upperTriangularFlow, z0, z1] using hpair

theorem matrixExponentialFlow_upperTriangular (α : ℝ) (t : ℝ) (z : Position 2) :
    matrixExponentialFlow (upperTriangularMatrix α) t z = upperTriangularFlow α t z := by
  have hinit : upperTriangularFlow α 0 z = z := by
    ext i
    fin_cases i <;> simp [upperTriangularFlow]
  have heq := matrixExponentialFlow_unique (upperTriangularMatrix α) z 0
    (upperTriangularFlow α · z)
    (fun s => hasDerivAt_upperTriangularFlow α z s) hinit
  simpa using (congrFun heq t).symm

end Matrix

end MolecularDynamics
