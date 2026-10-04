import MolecularDynamics.Chapter01.PolarCoordinates
import Mathlib.Analysis.CStarAlgebra.Matrix

namespace MolecularDynamics
noncomputable def polarCoordinateMap (q : Position 2) : Position 2 :=
  WithLp.toLp 2 ![q 0 * Real.cos (q 1), q 0 * Real.sin (q 1)]

theorem hasStrictFDerivAt_polarCoordinateMap (q : Position 2) :
    HasStrictFDerivAt polarCoordinateMap
      (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (polarJacobian (q 0) (q 1))) q := by
  apply hasStrictFDerivAt_euclidean.mpr
  intro i
  fin_cases i
  · have h := (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)).hasStrictFDerivAt.mul
      ((Real.hasStrictDerivAt_cos (q 1)).comp_hasStrictFDerivAt q
        (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2)).hasStrictFDerivAt)
    have heq : Real.cos (q 1) • (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)) +
        q 0 • (-Real.sin (q 1) • (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2))) =
        (PiLp.proj 2 (fun _ : Fin 2 => ℝ) 0).comp
          (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (polarJacobian (q 0) (q 1))) := by
      ext u
      change Real.cos (q 1) * u 0 + q 0 * (-Real.sin (q 1) * u 1) =
        ∑ j : Fin 2, polarJacobian (q 0) (q 1) 0 j * u j
      simp [polarJacobian, Fin.sum_univ_two]
      ring
    rw [heq] at h
    exact h
  · have h := (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)).hasStrictFDerivAt.mul
      ((Real.hasStrictDerivAt_sin (q 1)).comp_hasStrictFDerivAt q
        (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2)).hasStrictFDerivAt)
    have heq : Real.sin (q 1) • (EuclideanSpace.proj (𝕜 := ℝ) (0 : Fin 2)) +
        q 0 • (Real.cos (q 1) • (EuclideanSpace.proj (𝕜 := ℝ) (1 : Fin 2))) =
        (PiLp.proj 2 (fun _ : Fin 2 => ℝ) 1).comp
          (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (polarJacobian (q 0) (q 1))) := by
      ext u
      change Real.sin (q 1) * u 0 + q 0 * (Real.cos (q 1) * u 1) =
        ∑ j : Fin 2, polarJacobian (q 0) (q 1) 1 j * u j
      simp [polarJacobian, Fin.sum_univ_two]
      ring
    rw [heq] at h
    exact h

#print axioms hasStrictFDerivAt_polarCoordinateMap
end MolecularDynamics
