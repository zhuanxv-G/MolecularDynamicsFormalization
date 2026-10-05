import Mathlib.Analysis.Calculus.VectorField
import Mathlib.LinearAlgebra.Span.Basic

/-! Definition6.1 and the necessary smooth-coefficient step in Proposition8.2.
The point span always consists of actual recursively differentiated vector fields.
-/

open scoped ContDiff

namespace MolecularDynamics

section
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Actual iterated derivative brackets, starting with the specified drift and noise fields. -/
inductive textbookIteratedBracket (seed : Set (E → E)) : (E → E) → Prop
  | seed {V : E → E} (hV : V ∈ seed) : textbookIteratedBracket seed V
  | bracket {V W : E → E} (hV : textbookIteratedBracket seed V)
      (hW : textbookIteratedBracket seed W) :
      textbookIteratedBracket seed (VectorField.lieBracket ℝ V W)

theorem textbookIteratedBracket_contDiff (seed : Set (E → E))
    (hseed : ∀ V ∈ seed, ContDiff ℝ ∞ V) {V : E → E}
    (hV : textbookIteratedBracket seed V) : ContDiff ℝ ∞ V := by
  induction hV with
  | seed h => exact hseed _ h
  | bracket _ _ hV hW => exact hV.lieBracket_vectorField hW (by simp)

/-- The real pointwise vector span in the textbook's definition. -/
def textbookBracketPointSpan (seed : Set (E → E)) (x : E) : Submodule ℝ E :=
  Submodule.span ℝ (Set.range (fun V : {V // textbookIteratedBracket seed V} ↦ V.val x))

def textbookHormanderAt (seed : Set (E → E)) (x : E) : Prop :=
  textbookBracketPointSpan seed x = ⊤

/-- Finite real sums of smooth scalar multiples of actual iterated brackets. -/
def textbookSmoothBracketModule (seed : Set (E → E)) : Submodule ℝ (E → E) :=
  Submodule.span ℝ {H | ∃ (f : E → ℝ) (V : E → E),
    ContDiff ℝ ∞ f ∧ textbookIteratedBracket seed V ∧ H = fun x ↦ f x • V x}

theorem textbookSmoothBracketModule_generator_mem (seed : Set (E → E))
    (f : E → ℝ) (V : E → E) (hf : ContDiff ℝ ∞ f)
    (hV : textbookIteratedBracket seed V) :
    (fun x ↦ f x • V x) ∈ textbookSmoothBracketModule seed :=
  Submodule.subset_span ⟨f, V, hf, hV, rfl⟩

theorem textbookSmoothBracketModule_contDiff (seed : Set (E → E))
    (hseed : ∀ V ∈ seed, ContDiff ℝ ∞ V) {H : E → E}
    (hH : H ∈ textbookSmoothBracketModule seed) : ContDiff ℝ ∞ H := by
  induction hH using Submodule.span_induction with
  | mem H h =>
    rcases h with ⟨f, V, hf, hV, rfl⟩
    exact hf.smul (textbookIteratedBracket_contDiff seed hseed hV)
  | zero => exact contDiff_const
  | add H K _ _ hH hK => exact hH.add hK
  | smul c H _ hH => exact contDiff_const.smul hH

theorem textbookSmoothBracketModule_smooth_smul_mem (seed : Set (E → E))
    (f : E → ℝ) (hf : ContDiff ℝ ∞ f) {H : E → E}
    (hH : H ∈ textbookSmoothBracketModule seed) :
    (fun x ↦ f x • H x) ∈ textbookSmoothBracketModule seed := by
  induction hH using Submodule.span_induction with
  | mem H h =>
    rcases h with ⟨g, V, hg, hV, rfl⟩
    simpa only [mul_smul] using
      textbookSmoothBracketModule_generator_mem seed (fun x ↦ f x * g x) V (hf.mul hg) hV
  | zero =>
    change (fun x : E ↦ f x • (0 : E)) ∈ textbookSmoothBracketModule seed
    have he : (fun x : E ↦ f x • (0 : E)) = 0 := by funext x; exact smul_zero (f x)
    rw [he]
    exact (textbookSmoothBracketModule seed).zero_mem
  | add H K _ _ hH hK =>
    have he : (fun x ↦ f x • (H + K) x) =
        (fun x ↦ f x • H x) + (fun x ↦ f x • K x) := by
      funext x
      exact smul_add (f x) (H x) (K x)
    rw [he]
    exact (textbookSmoothBracketModule seed).add_mem hH hK
  | smul c H _ hH =>
    have he : (fun x ↦ f x • (c • H) x) = c • (fun x ↦ f x • H x) := by
      funext x
      exact smul_comm (f x) c (H x)
    rw [he]
    exact (textbookSmoothBracketModule seed).smul_mem c hH

/-- Smooth scalar coefficients do not enlarge the actual point span. -/
theorem textbookSmoothBracketModule_eval_mem (seed : Set (E → E)) {H : E → E}
    (hH : H ∈ textbookSmoothBracketModule seed) (x : E) : H x ∈ textbookBracketPointSpan seed x := by
  induction hH using Submodule.span_induction with
  | mem H h =>
    rcases h with ⟨f, V, _, hV, rfl⟩
    exact (textbookBracketPointSpan seed x).smul_mem (f x)
      (Submodule.subset_span ⟨⟨V, hV⟩, rfl⟩)
  | zero => exact (textbookBracketPointSpan seed x).zero_mem
  | add H K _ _ hH hK => exact (textbookBracketPointSpan seed x).add_mem hH hK
  | smul c H _ hH => exact (textbookBracketPointSpan seed x).smul_mem c hH

private theorem smoothBracketGenerator_bracket_mem (seed : Set (E → E))
    (hseed : ∀ V ∈ seed, ContDiff ℝ ∞ V)
    (f g : E → ℝ) (V W : E → E) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hV : textbookIteratedBracket seed V) (hW : textbookIteratedBracket seed W) :
    VectorField.lieBracket ℝ (fun x ↦ f x • V x) (fun x ↦ g x • W x) ∈
      textbookSmoothBracketModule seed := by
  have hsV := textbookIteratedBracket_contDiff seed hseed hV
  have hsW := textbookIteratedBracket_contDiff seed hseed hW
  have hdf : ContDiff ℝ ∞ (fun x ↦ fderiv ℝ f x (W x)) :=
    (hf.fderiv_right (by simp)).clm_apply hsW
  have hdg : ContDiff ℝ ∞ (fun x ↦ fderiv ℝ g x (V x)) :=
    (hg.fderiv_right (by simp)).clm_apply hsV
  have he : VectorField.lieBracket ℝ (fun x ↦ f x • V x) (fun x ↦ g x • W x) =
      (fun x ↦ -(g x * fderiv ℝ f x (W x)) • V x) +
      (fun x ↦ (f x * fderiv ℝ g x (V x)) • W x) +
      (fun x ↦ (f x * g x) • VectorField.lieBracket ℝ V W x) := by
    funext x
    rw [VectorField.lieBracket_smul_left (hf.differentiable (by simp) x)
      (hsV.differentiable (by simp) x),
      VectorField.lieBracket_smul_right (hg.differentiable (by simp) x)
        (hsW.differentiable (by simp) x)]
    simp only [Pi.add_apply, map_smul, smul_add, smul_smul]
    module
  rw [he]
  exact (textbookSmoothBracketModule seed).add_mem
    ((textbookSmoothBracketModule seed).add_mem
      (textbookSmoothBracketModule_generator_mem seed _ V (hg.mul hdf).neg hV)
      (textbookSmoothBracketModule_generator_mem seed _ W (hf.mul hdg) hW))
    (textbookSmoothBracketModule_generator_mem seed _ _ (hf.mul hg)
      (textbookIteratedBracket.bracket hV hW))

/-- Actual derivative brackets preserve the smooth finite-combination module. -/
theorem textbookSmoothBracketModule_bracket_mem (seed : Set (E → E))
    (hseed : ∀ V ∈ seed, ContDiff ℝ ∞ V) {H K : E → E}
    (hH : H ∈ textbookSmoothBracketModule seed) (hK : K ∈ textbookSmoothBracketModule seed) :
    VectorField.lieBracket ℝ H K ∈ textbookSmoothBracketModule seed := by
  induction hH using Submodule.span_induction with
  | mem H h =>
    rcases h with ⟨f, V, hf, hV, rfl⟩
    induction hK using Submodule.span_induction with
    | mem K h =>
      rcases h with ⟨g, W, hg, hW, rfl⟩
      exact smoothBracketGenerator_bracket_mem seed hseed f g V W hf hg hV hW
    | zero => rw [VectorField.lieBracket_zero_right]; exact (textbookSmoothBracketModule seed).zero_mem
    | add K L hk hl ihk ihl =>
      have he : VectorField.lieBracket ℝ (fun x ↦ f x • V x) (K + L) =
          VectorField.lieBracket ℝ (fun x ↦ f x • V x) K +
          VectorField.lieBracket ℝ (fun x ↦ f x • V x) L := by
        funext x
        exact VectorField.lieBracket_add_right
          ((textbookSmoothBracketModule_contDiff seed hseed hk).differentiable (by simp) x)
          ((textbookSmoothBracketModule_contDiff seed hseed hl).differentiable (by simp) x)
      rw [he]
      exact (textbookSmoothBracketModule seed).add_mem ihk ihl
    | smul c K hk ihk =>
      have he : VectorField.lieBracket ℝ (fun x ↦ f x • V x) (c • K) =
          c • VectorField.lieBracket ℝ (fun x ↦ f x • V x) K := by
        funext x
        exact VectorField.lieBracket_const_smul_right
          ((textbookSmoothBracketModule_contDiff seed hseed hk).differentiable (by simp) x)
      rw [he]
      exact (textbookSmoothBracketModule seed).smul_mem c ihk
  | zero => rw [VectorField.lieBracket_zero_left]; exact (textbookSmoothBracketModule seed).zero_mem
  | add H L hh hl ihh ihl =>
    have he : VectorField.lieBracket ℝ (H + L) K =
        VectorField.lieBracket ℝ H K + VectorField.lieBracket ℝ L K := by
      funext x
      exact VectorField.lieBracket_add_left
        ((textbookSmoothBracketModule_contDiff seed hseed hh).differentiable (by simp) x)
        ((textbookSmoothBracketModule_contDiff seed hseed hl).differentiable (by simp) x)
    rw [he]
    exact (textbookSmoothBracketModule seed).add_mem ihh ihl
  | smul c H hh ihh =>
    have he : VectorField.lieBracket ℝ (c • H) K = c • VectorField.lieBracket ℝ H K := by
      funext x
      exact VectorField.lieBracket_const_smul_left
        ((textbookSmoothBracketModule_contDiff seed hseed hh).differentiable (by simp) x)
    rw [he]
    exact (textbookSmoothBracketModule seed).smul_mem c ihh

end
end MolecularDynamics
