import MolecularDynamics.Chapter02.HamiltonianVolume
import Mathlib.Analysis.Calculus.FDeriv.Analytic

/-!
# Genuine divergence-free solution-family volume

Printed72/PDF94.  Actual differentiation of the multilinear determinant
gives det(W)' = trace(A) det(W) for the real matrix ODE W' = A W,
even at singular W.  The actual solution-family variation derives that
ODE.  Zero divergence, the initial identity and genuine change of variables
give measurable-image Lebesgue volume equality.  Joint C² regularity of
the specified family is explicit; weaker regularity construction is separate.
-/

open Set Matrix Filter MeasureTheory
open scoped BigOperators Topology Matrix Matrix.Norms.Elementwise ENNReal

namespace MolecularDynamics

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Actual Jacobian in the standard coordinates of the finite real state space. -/
noncomputable def textbookCoordinateJacobian (f : (ι → ℝ) → ι → ℝ) (z : ι → ℝ) :
    Matrix ι ι ℝ := LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap

theorem textbookCoordinateJacobian_entry (f : (ι → ℝ) → ι → ℝ) (z : ι → ℝ) (i j : ι) :
    textbookCoordinateJacobian f z i j = ((fderiv ℝ f z) (Pi.single j 1)) i := rfl

theorem textbookCoordinateJacobian_mulVec (f : (ι → ℝ) → ι → ℝ) (z u : ι → ℝ) :
    textbookCoordinateJacobian f z *ᵥ u = (fderiv ℝ f z) u :=
  LinearMap.toMatrix'_mulVec _ u

private noncomputable def determinantMultilinear :
    ContinuousMultilinearMap ℝ (fun _ : ι => ι → ℝ) ℝ where
  toMultilinearMap := Matrix.detRowAlternating.toMultilinearMap
  cont := by
    change Continuous (fun W : Matrix ι ι ℝ => W.det)
    exact continuous_id.matrix_det

/-- The real determinant derivative needs no inverse or nonsingularity. -/
theorem textbookMatrixDet_hasDerivAt_of_linearODE (W : ℝ → Matrix ι ι ℝ)
    (A : Matrix ι ι ℝ) (t : ℝ) (hW : HasDerivAt W (A * W t) t) :
    HasDerivAt (fun s => (W s).det) (A.trace * (W t).det) t := by
  have hrow (i : ι) : (A * W t) i = ∑ k, A i k • W t k := by
    ext j
    simp [Matrix.mul_apply, Finset.sum_apply, Pi.smul_apply, smul_eq_mul]
  have hsum : (∑ i, ((W t).updateRow i ((A * W t) i)).det) = A.trace * (W t).det := by
    simp_rw [hrow, Matrix.det_updateRow_sum, smul_eq_mul]
    change (∑ i, A i i * (W t).det) = (∑ i, A i i) * (W t).det
    exact (Finset.sum_mul _ _ _).symm
  have hd := (determinantMultilinear (ι := ι)).hasFDerivAt (W t)
    |>.comp_hasDerivAt t hW
  have hd' : HasDerivAt (fun s => (W s).det)
      (∑ i, ((W t).updateRow i ((A * W t) i)).det) t := by
    convert hd using 1
    · rfl
    · exact (ContinuousMultilinearMap.linearDeriv_apply
        (determinantMultilinear (ι := ι)) (W t) (A * W t)).symm
  rw [hsum] at hd'
  exact hd'

/-- The actual initial Jacobian ODE follows from the true time ODE. -/
theorem textbookSolutionFamilyJacobian_hasDerivAt (f : (ι → ℝ) → ι → ℝ)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (t : ℝ) (z : ι → ℝ)
    (hf : DifferentiableAt ℝ f (Φ (t, z)))
    (hODE : ∀ᶠ y in 𝓝 z, HasDerivAt (fun s => Φ (s, y)) (f (Φ (t, y))) t) :
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s, y)) z)
      (textbookCoordinateJacobian f (Φ (t, z)) *
        textbookCoordinateJacobian (fun y => Φ (t, y)) z) t := by
  apply hasDerivAt_pi.mpr
  intro i
  apply hasDerivAt_pi.mpr
  intro j
  have hv := textbookSolutionVariation_hasDerivAt Φ f hΦ t z (Pi.single j 1) hf hODE
  rw [← textbookCoordinateJacobian_mulVec f (Φ (t, z))
    (textbookSolutionVariation Φ t z (Pi.single j 1))] at hv
  simpa only [textbookCoordinateJacobian_entry,
    textbookSolutionVariation, Matrix.mul_apply, Matrix.mulVec, dotProduct] using
    hasDerivAt_pi.mp hv i

/-- Actual zero divergence forces the actual flow Jacobian determinant to be one. -/
theorem textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2
    (f : (ι → ℝ) → ι → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1 := by
  have hd (z : ι → ℝ) (t : ℝ) (ht : t ∈ Icc 0 τ) :
      HasDerivAt (fun s => (textbookCoordinateJacobian (fun y => Φ (s, y)) z).det) 0 t := by
    have h := textbookMatrixDet_hasDerivAt_of_linearODE
      (fun s => textbookCoordinateJacobian (fun y => Φ (s, y)) z)
      (textbookCoordinateJacobian f (Φ (t, z))) t
      (textbookSolutionFamilyJacobian_hasDerivAt f Φ hΦ t z (hf.differentiable_one _)
        (Filter.Eventually.of_forall (hODE t ht)))
    simpa only [hdiv, zero_mul] using h
  intro t ht z
  have hc : ∀ s ∈ Icc 0 τ,
      (textbookCoordinateJacobian (fun y => Φ (s, y)) z).det =
        (textbookCoordinateJacobian (fun y => Φ (0, y)) z).det := by
    apply constant_of_has_deriv_right_zero
      (fun s hs => (hd z s hs).hasDerivWithinAt.continuousWithinAt)
    intro s hs
    exact (hd z s (mem_Icc_of_Ico hs)).hasDerivWithinAt.mono_of_mem_nhdsWithin
      (Icc_mem_nhdsGE_of_mem hs)
  rw [hc t ht, hinit]
  unfold textbookCoordinateJacobian
  rw [fderiv_id]
  change (LinearMap.toMatrix' (LinearMap.id : (ι → ℝ) →ₗ[ℝ] ι → ℝ)).det = 1
  rw [LinearMap.toMatrix'_id, Matrix.det_one]

omit [DecidableEq ι] in
theorem textbookDivergenceFreeFlow_measurable_image_of_jointC2
    (f : (ι → ℝ) → ι → ℝ) (hf : ContDiff ℝ 1 f)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (ι → ℝ)) (hs : MeasurableSet s) :
    MeasurableSet ((fun z => Φ (t, z)) '' s) := by
  have hm : Differentiable ℝ (fun z => Φ (t, z)) := by
    have hΦ1 : ContDiff ℝ 1 Φ := hΦ.of_le (by norm_num)
    have hc : ContDiff ℝ 1 (fun z => Φ (t, z)) := by
      simpa only [Function.comp_def, id_eq] using hΦ1.comp (contDiff_const.prodMk contDiff_id)
    exact hc.differentiable_one
  exact measurable_image_of_fderivWithin hs
    (fun z _ => (hm z).hasFDerivAt.hasFDerivWithinAt)
    (textbookC1SolutionFamily_injective f hf Φ hΦ.continuous τ hODE hinit t ht).injOn

/-- General divergence-free Liouville: the actual Lebesgue measure of every
measurable image equals that of the source set on the given solution interval. -/
theorem textbookDivergenceFreeFlow_volume_image_of_jointC2
    (f : (ι → ℝ) → ι → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (ι → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  have hm : Differentiable ℝ (fun z => Φ (t, z)) := by
    have hΦ1 : ContDiff ℝ 1 Φ := hΦ.of_le (by norm_num)
    have hc : ContDiff ℝ 1 (fun z => Φ (t, z)) := by
      simpa only [Function.comp_def, id_eq] using hΦ1.comp (contDiff_const.prodMk contDiff_id)
    exact hc.differentiable_one
  have hdet (z : ι → ℝ) : (fderiv ℝ (fun y => Φ (t, y)) z).det = 1 := by
    change LinearMap.det (fderiv ℝ (fun y => Φ (t, y)) z).toLinearMap = 1
    rw [← LinearMap.det_toMatrix']
    exact textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2 f hf hdiv Φ hΦ τ hODE hinit t ht z
  have hcv := lintegral_abs_det_fderiv_eq_addHaar_image (volume : Measure (ι → ℝ)) hs
    (fun z _ => (hm z).hasFDerivAt.hasFDerivWithinAt)
    (textbookC1SolutionFamily_injective f hf Φ hΦ.continuous τ hODE hinit t ht).injOn
  simpa only [hdet, abs_one, ENNReal.ofReal_one, lintegral_const, one_mul, Measure.restrict_apply_univ]
    using hcv.symm

end MolecularDynamics
