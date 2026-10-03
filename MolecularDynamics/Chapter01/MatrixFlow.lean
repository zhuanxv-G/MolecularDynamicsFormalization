import MolecularDynamics.Chapter01.LinearFlow
import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

/-! Printed27/PDF50: actual finite matrix exponential IVPs.
The continuous algebra equivalence proves agreement with the operator formula.
No invertibility or diagonalizability of A is assumed. -/

open scoped Matrix.Norms.L2Operator
namespace MolecularDynamics

noncomputable local instance (m : ℕ) : NormedAlgebra ℚ (Matrix (Fin m) (Fin m) ℝ) :=
  .restrictScalars ℚ ℝ _
noncomputable local instance (m : ℕ) : NormedAlgebra ℚ (Position m →L[ℝ] Position m) :=
  .restrictScalars ℚ ℝ _

noncomputable def matrixExponentialFlow {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (t : ℝ) (z : Position m) : Position m :=
  linearExponentialFlow (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) t z

theorem matrixExponentialFlow_eq {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (t : ℝ) (z : Position m) :
    matrixExponentialFlow A t z = WithLp.toLp 2 ((NormedSpace.exp (t • A)).mulVec z) := by
  have hmap := NormedSpace.map_exp (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ))
    ((Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ)).toAlgEquiv.toLinearEquiv.toLinearMap.continuous_of_finiteDimensional)
    (t • A)
  rw [map_smul] at hmap
  unfold matrixExponentialFlow linearExponentialFlow
  rw [← hmap]
  exact Matrix.toEuclideanCLM_toLp _ (WithLp.ofLp z)

theorem hasDerivAt_matrixExponentialFlow {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t : ℝ) :
    HasDerivAt (fun u => matrixExponentialFlow A u z)
      (WithLp.toLp 2 (A.mulVec (matrixExponentialFlow A t z))) t := by
  exact hasDerivAt_linearExponentialFlow (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) z t

theorem matrixExponentialFlow_initial_time {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) :
    (fun t => matrixExponentialFlow A (t - t₀) z) t₀ = z := by
  exact linearExponentialFlow_initial_time (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) z t₀


theorem hasDerivAt_matrixExponentialFlow_initial_time {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ) (z : Position m) (t₀ t : ℝ) :
    HasDerivAt (fun u => matrixExponentialFlow A (u - t₀) z)
      (WithLp.toLp 2 (A.mulVec (matrixExponentialFlow A (t - t₀) z))) t := by
  exact hasDerivAt_linearExponentialFlow_initial_time
    (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) z t₀ t

theorem matrixExponentialFlow_unique {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z) : γ = fun t => matrixExponentialFlow A (t - t₀) z := by
  exact linearExponentialFlow_unique
    (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) z t₀ γ hγ hinit

noncomputable def matrixContinuousFlow {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ) :
    Flow ℝ (Position m) :=
  linearContinuousFlow (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A)

theorem matrixExponential_series {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ) :
    NormedSpace.exp A = ∑' k : ℕ, ((k.factorial : ℝ)⁻¹) • A ^ k := by
  rw [NormedSpace.exp_eq_tsum ℝ]

end MolecularDynamics
