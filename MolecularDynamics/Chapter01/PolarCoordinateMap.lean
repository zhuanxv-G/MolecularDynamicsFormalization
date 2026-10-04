import MolecularDynamics.Chapter01.PolarCoordinates
import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.Analysis.Calculus.InverseFunctionTheorem.FDeriv

/-! Printed29/PDF52: genuine polar Frechet derivative and local inverse chart.
The chart is local at nonzero radius; angles are not globally identified. -/

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
    dsimp only [Function.comp_def] at h
    rw [add_comm] at h
    simp only [EuclideanSpace.coe_proj] at h
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
    dsimp only [Function.comp_def] at h
    rw [add_comm] at h
    simp only [EuclideanSpace.coe_proj] at h
    rw [heq] at h
    exact h

theorem exists_polarDerivativeEquiv (q : Position 2) (hq : q 0 ≠ 0) :
    ∃ L : Position 2 ≃L[ℝ] Position 2,
      (L : Position 2 →L[ℝ] Position 2) =
        Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (polarJacobian (q 0) (q 1)) := by
  have hm := (polarJacobian_isUnit_iff (q 0) (q 1)).mpr hq
  have hu := hm.map
    (Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ)).toAlgEquiv.toAlgHom.toMonoidHom
  obtain ⟨u, hu⟩ := hu
  refine ⟨ContinuousLinearEquiv.unitsEquiv ℝ (Position 2) u, ?_⟩
  change (u : Position 2 →L[ℝ] Position 2) = _
  exact hu

theorem fderiv_polarCoordinateMap (q : Position 2) :
    fderiv ℝ polarCoordinateMap q =
      Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (polarJacobian (q 0) (q 1)) :=
  (hasStrictFDerivAt_polarCoordinateMap q).hasFDerivAt.fderiv

theorem exists_polarLocalChart_strictInverse (q : Position 2) (hq : q 0 ≠ 0) :
    ∃ (L : Position 2 ≃L[ℝ] Position 2)
      (e : OpenPartialHomeomorph (Position 2) (Position 2)),
      (L : Position 2 →L[ℝ] Position 2) =
        Matrix.toEuclideanCLM (n := Fin 2) (𝕜 := ℝ) (polarJacobian (q 0) (q 1)) ∧
      q ∈ e.source ∧ (e : Position 2 → Position 2) = polarCoordinateMap ∧
      HasStrictFDerivAt (e.symm : Position 2 → Position 2)
        (L.symm : Position 2 →L[ℝ] Position 2) (polarCoordinateMap q) := by
  obtain ⟨L, hL⟩ := exists_polarDerivativeEquiv q hq
  have hd : HasStrictFDerivAt polarCoordinateMap
      (L : Position 2 →L[ℝ] Position 2) q := by
    rw [hL]
    exact hasStrictFDerivAt_polarCoordinateMap q
  exact ⟨L, hd.toOpenPartialHomeomorph polarCoordinateMap, hL,
    hd.mem_toOpenPartialHomeomorph_source, rfl, hd.to_localInverse⟩

theorem exists_polarLocalChart (q : Position 2) (hq : q 0 ≠ 0) :
    ∃ e : OpenPartialHomeomorph (Position 2) (Position 2),
      q ∈ e.source ∧ (e : Position 2 → Position 2) = polarCoordinateMap ∧
      DifferentiableAt ℝ e.symm (polarCoordinateMap q) := by
  obtain ⟨L, e, _, hq, he, hd⟩ := exists_polarLocalChart_strictInverse q hq
  exact ⟨e, hq, he, hd.hasFDerivAt.differentiableAt⟩

end MolecularDynamics
