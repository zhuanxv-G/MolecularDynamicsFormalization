import MolecularDynamics.Chapter02.OneStepConvergence
import Mathlib.Topology.Homeomorph.Lemmas

/-!
# Conjugacy and processed numerical methods

Printed88/PDF110, §2.4.5.  A genuine homeomorphism supplies both the actual
inverse and its continuity.  Iteration and pre/post-processing are actual
maps, with transformed initial data kept explicit.  Accuracy is transferred
by exact identity with the conjugate method, not inferred from conjugacy alone.
-/

open Filter
open scoped Topology

namespace MolecularDynamics

section Topological

variable {E : Type*} [TopologicalSpace E]

/-- Actual change of coordinates: apply χ, then B, then the genuine inverse. -/
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ

/-- Complete cancellation of the intermediate changes of coordinates. -/
theorem textbookConjugateMap_iterate (χ : E ≃ₜ E) (B : E → E) (n : ℕ) (z : E) :
    (textbookConjugateMap χ B)^[n] z = χ.symm (B^[n] (χ z)) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih]
    simp only [textbookConjugateMap, Function.comp_apply, Homeomorph.apply_symm_apply,
      Function.iterate_succ_apply']

/-- The literal A^n = χ⁻¹ ∘ B^n ∘ χ formula for the given conjugate maps. -/
theorem textbook_conjugate_iterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  subst A
  funext z
  exact textbookConjugateMap_iterate χ B n z

/-- Corresponding actual orbits converge to corresponding points in both
directions.  The B orbit begins at χ z₀, not at the untransformed z₀. -/
theorem textbook_conjugate_iterates_tendsto_iff (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (z₀ zStar : E) :
    Tendsto (fun n : ℕ => A^[n] z₀) atTop (𝓝 zStar) ↔
      Tendsto (fun n : ℕ => B^[n] (χ z₀)) atTop (𝓝 (χ zStar)) := by
  subst A
  constructor
  · intro h
    have hc := χ.continuous.continuousAt.tendsto.comp h
    simpa only [Function.comp_def, textbookConjugateMap_iterate,
      Homeomorph.apply_symm_apply] using hc
  · intro h
    have hc := χ.symm.continuous.continuousAt.tendsto.comp h
    simpa only [Function.comp_def, textbookConjugateMap_iterate,
      Homeomorph.symm_apply_apply] using hc

/-- The step-dependent conjugate method in the text. -/
def textbookProcessedMethod (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E) (h : ℝ) : E → E :=
  textbookConjugateMap (χ h) (B h)

/-- Preprocess once, take n actual B steps, then postprocess once. -/
noncomputable def textbookProcessedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)

/-- The processed algorithm is exactly iteration of the conjugate method. -/
theorem textbookProcessedIterate_eq (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n =
      oneStepIterate (textbookProcessedMethod χ B) h z₀ n :=
  (textbookConjugateMap_iterate (χ h) (B h) n z₀).symm

/-- When G is the conjugate higher-order method, processing evaluates its
actual iterates, without repeatedly applying χ during the inner loop. -/
theorem textbookProcessedIterate_eq_of_conjugacy (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n := by
  rw [textbookProcessedIterate_eq]
  simp only [oneStepIterate, hG h]

end Topological

section Error

variable {E : Type*} [NormedAddCommGroup E]

/-- The actual finite-mesh maximum error of the processed algorithm. -/
noncomputable def textbookProcessedMaxError (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (γ : ℝ → E) (ν : ℕ) : ℝ :=
  (Finset.range (ν + 1)).sup' Finset.nonempty_range_add_one
    (fun n => ‖textbookProcessedIterate χ B h (γ 0) n - γ ((n : ℝ) * h)‖)

/-- Exact equality transfers every already proved global error bound for G
to pre/iterate/post-processing.  Conjugacy itself supplies no accuracy order. -/
theorem textbookProcessedMaxError_eq_of_conjugacy (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (γ : ℝ → E) (ν : ℕ) :
    textbookProcessedMaxError χ B h γ ν = oneStepMaxError G h γ ν := by
  unfold textbookProcessedMaxError oneStepMaxError
  congr 1
  funext n
  rw [textbookProcessedIterate_eq_of_conjugacy χ B G hG]

end Error

end MolecularDynamics
