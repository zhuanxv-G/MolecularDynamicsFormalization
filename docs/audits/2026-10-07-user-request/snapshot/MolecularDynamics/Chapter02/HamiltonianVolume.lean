import MolecularDynamics.Chapter02.ActualFlowVariations
import Mathlib.Analysis.ODE.ExistUnique
import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.MeasureTheory.Function.Jacobian

/-!
# Genuine Hamiltonian divergence and set-volume preservation

Printed72/PDF94 and78/PDF100.  True C¹ field bounds on a compact convex
set and actual ODE uniqueness derive injectivity of the solution map.
The actual determinant and the change-of-variables theorem then give
Lebesgue volume equality of measurable images.  No injectivity or
volume-preservation conclusion is supplied as flow data.
-/

open Set Matrix Filter MeasureTheory Metric
open scoped BigOperators Topology Matrix Matrix.Norms.Elementwise NNReal ENNReal

namespace MolecularDynamics

theorem textbookHamiltonianVectorField_jacobian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    textbookJacobian (textbookHamiltonianVectorField H) z =
      textbookJ Nc * textbookHamiltonianHessian H z := by
  ext i j
  rw [textbookJacobian_entry, textbookHamiltonianVectorField_fderiv_mulVec H z (Pi.single j 1) hH]
  simp [Matrix.mulVec, dotProduct, Pi.single_apply]

/-- The divergence is the trace of the actual derivative, not a formal symbol. -/
theorem textbookHamiltonianVectorField_divergence_zero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  rw [textbookHamiltonianVectorField_jacobian H z hH]
  let S := textbookHamiltonianHessian H z
  have hS := textbookHamiltonianHessian_isSymm H z hH
  have htr : (textbookJ Nc * S).trace = -(textbookJ Nc * S).trace := by
    calc
      _ = ((textbookJ Nc * S)ᵀ).trace := (Matrix.trace_transpose _).symm
      _ = (S * (-textbookJ Nc)).trace := by
        rw [Matrix.transpose_mul, hS.eq, textbookJ_transpose]
      _ = -(S * textbookJ Nc).trace := by rw [Matrix.mul_neg, Matrix.trace_neg]
      _ = _ := by rw [Matrix.trace_mul_comm]
  change (textbookJ Nc * S).trace = 0
  linarith

private theorem compact_C1_field_lipschitz {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (hf : ContDiff ℝ 1 f) (B : Set E)
    (hB : IsCompact B) (hconv : Convex ℝ B) :
    ∃ K : ℝ≥0, LipschitzOnWith K f B := by
  obtain ⟨A, hA⟩ := hB.bddAbove_image
    (((hf.contDiffOn.continuousOn_fderiv_of_isOpen isOpen_univ (by rfl)).mono
      (subset_univ B)).norm)
  let K : ℝ≥0 := ⟨max A 1, (show (0 : ℝ) ≤ 1 by norm_num).trans (le_max_right A 1)⟩
  refine ⟨K, LipschitzOnWith.of_dist_le_mul fun x hx y hy => ?_⟩
  change dist (f x) (f y) ≤ max A 1 * dist x y
  simpa only [dist_eq_norm] using hconv.norm_image_sub_le_of_norm_fderiv_le
    (fun z _ => hf.differentiable_one z)
    (fun z hz => (hA ⟨z, hz, rfl⟩).trans (le_max_left A 1)) hy hx

/-- Real C¹ field regularity and uniqueness give injectivity at every time
in the specified interval, with only a continuous actual solution family. -/
theorem textbookC1SolutionFamily_injective {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
    (f : E → E) (hf : ContDiff ℝ 1 f) (Φ : ℝ × E → E) (hΦ : Continuous Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, Function.Injective (fun z => Φ (t, z)) := by
  intro t ht x y hxy
  have hcx : Continuous (fun s => Φ (s, x)) := hΦ.comp (continuous_id.prodMk continuous_const)
  have hcy : Continuous (fun s => Φ (s, y)) := hΦ.comp (continuous_id.prodMk continuous_const)
  have hcompact : IsCompact
      ((fun s => Φ (s, x)) '' Icc 0 t ∪ (fun s => Φ (s, y)) '' Icc 0 t) :=
    (isCompact_Icc.image hcx).union (isCompact_Icc.image hcy)
  obtain ⟨R, hR⟩ := hcompact.isBounded.subset_closedBall (0 : E)
  let B := closedBall (0 : E) R
  have hBx (s : ℝ) (hs : s ∈ Icc 0 t) : Φ (s, x) ∈ B :=
    hR (Or.inl ⟨s, hs, rfl⟩)
  have hBy (s : ℝ) (hs : s ∈ Icc 0 t) : Φ (s, y) ∈ B :=
    hR (Or.inr ⟨s, hs, rfl⟩)
  obtain ⟨K, hK⟩ := compact_C1_field_lipschitz f hf B
    (isCompact_closedBall (0 : E) R) (convex_closedBall (0 : E) R)
  have heq := ODE_solution_unique_of_mem_Icc_left (v := fun _ => f) (s := fun _ => B)
    (a := 0) (b := t) (K := K)
    (fun _ _ => hK) hcx.continuousOn
    (fun s hs => (hODE s ⟨hs.1.le, hs.2.trans ht.2⟩ x).hasDerivWithinAt)
    (fun s hs => hBx s (mem_Icc_of_Ioc hs)) hcy.continuousOn
    (fun s hs => (hODE s ⟨hs.1.le, hs.2.trans ht.2⟩ y).hasDerivWithinAt)
    (fun s hs => hBy s (mem_Icc_of_Ioc hs)) hxy
  have hzero := heq (show (0 : ℝ) ∈ Icc 0 t from ⟨le_rfl, ht.1⟩)
  simpa only [congrFun hinit x, congrFun hinit y, id_eq] using hzero

theorem textbookHamiltonianFlow_injective_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, Function.Injective (fun z => Φ (t, z)) := by
  have hf : ContDiff ℝ 1 (textbookHamiltonianVectorField H) :=
    contDiffOn_univ.mp (contDiffOn_textbookHamiltonianVectorField univ isOpen_univ H hH.contDiffOn)
  exact textbookC1SolutionFamily_injective _ hf Φ hΦ.continuous τ hODE hinit

theorem textbookHamiltonianFlow_measurable_image_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    MeasurableSet ((fun z => Φ (t, z)) '' s) := by
  have hm := (textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit t ht).1
  exact measurable_image_of_fderivWithin hs
    (fun z _ => (hm.differentiable_one z).hasFDerivAt.hasFDerivWithinAt)
    (textbookHamiltonianFlow_injective_of_jointC2 H hH Φ hΦ τ hODE hinit t ht).injOn

/-- Actual Lebesgue volume of every measurable set is preserved on its image. -/
theorem textbookHamiltonianFlow_volume_image_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  have hm := textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit t ht
  have hdet (z : SymplecticCoordinates Nc) : (fderiv ℝ (fun y => Φ (t, y)) z).det = 1 := by
    change LinearMap.det (fderiv ℝ (fun y => Φ (t, y)) z).toLinearMap = 1
    rw [← LinearMap.det_toMatrix']
    exact hm.jacobian_det_eq_one z
  have hcv := lintegral_abs_det_fderiv_eq_addHaar_image
    (volume : Measure (SymplecticCoordinates Nc)) hs
    (fun z _ => (hm.1.differentiable_one z).hasFDerivAt.hasFDerivWithinAt)
    (textbookHamiltonianFlow_injective_of_jointC2 H hH Φ hΦ τ hODE hinit t ht).injOn
  simpa only [hdet, abs_one, ENNReal.ofReal_one, lintegral_const, one_mul, Measure.restrict_apply_univ]
    using hcv.symm

end MolecularDynamics
