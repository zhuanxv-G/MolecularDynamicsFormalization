import Mathlib.Probability.Kernel.Invariance

/-! Lemma 7.1, printed299--300/PDF320--321.
S and T are genuine Markov kernels acting on genuine probability measures.
The explicitly assumed invariant distributions are unique as in the textbook.
-/

open MeasureTheory ProbabilityTheory Filter
open scoped ProbabilityTheory

namespace MolecularDynamics

variable {Ω : Type*} [MeasurableSpace Ω]

/-- The textbook data: an actual invariant probability distribution, unique among such measures. -/
def textbookUniqueInvariantProbability (K : Kernel Ω Ω) (ρ : Measure Ω) : Prop :=
  IsProbabilityMeasure ρ ∧ Kernel.Invariant K ρ ∧
    ∀ μ : Measure Ω, IsProbabilityMeasure μ → Kernel.Invariant K μ → μ = ρ

private theorem actual_kernel_intertwining (S T : Kernel Ω Ω) (ρ : Measure Ω) :
    (S ∘ₖ T) ∘ₘ (S ∘ₘ ρ) = S ∘ₘ ((T ∘ₖ S) ∘ₘ ρ) := by
  calc
    (S ∘ₖ T) ∘ₘ (S ∘ₘ ρ) = S ∘ₘ (T ∘ₘ (S ∘ₘ ρ)) := Measure.comp_assoc.symm
    _ = S ∘ₘ ((T ∘ₖ S) ∘ₘ ρ) := congrArg (fun μ ↦ S ∘ₘ μ) Measure.comp_assoc

/-- An actual TS-invariant measure maps under S to an actual ST-invariant measure. -/
theorem textbookKernelInvariant_swap (S T : Kernel Ω Ω) {ρ : Measure Ω}
    (hρ : Kernel.Invariant (T ∘ₖ S) ρ) :
    Kernel.Invariant (S ∘ₖ T) (S ∘ₘ ρ) := by
  change (S ∘ₖ T) ∘ₘ (S ∘ₘ ρ) = S ∘ₘ ρ
  rw [actual_kernel_intertwining S T ρ]
  exact congrArg (fun μ ↦ S ∘ₘ μ) hρ

/-- The finite identity used in the printed proof, for the real kernel actions on measures. -/
theorem textbookKernelComposition_iterate (S T : Kernel Ω Ω) (ρ : Measure Ω) (n : ℕ) :
    ((fun μ ↦ (S ∘ₖ T) ∘ₘ μ)^[n + 1]) ρ =
      S ∘ₘ (((fun μ ↦ (T ∘ₖ S) ∘ₘ μ)^[n]) (T ∘ₘ ρ)) := by
  induction n with
  | zero =>
    simpa only [Nat.zero_add, Function.iterate_one, Function.iterate_zero, id_eq] using
      (Measure.comp_assoc (η := S) (κ := T) (μ := ρ)).symm
  | succ n ih =>
    calc
      ((fun μ ↦ (S ∘ₖ T) ∘ₘ μ)^[n + 1 + 1]) ρ =
          (S ∘ₖ T) ∘ₘ (((fun μ ↦ (S ∘ₖ T) ∘ₘ μ)^[n + 1]) ρ) :=
        Function.iterate_succ_apply' _ _ _
      _ = (S ∘ₖ T) ∘ₘ (S ∘ₘ (((fun μ ↦ (T ∘ₖ S) ∘ₘ μ)^[n]) (T ∘ₘ ρ))) :=
        congrArg (fun μ ↦ (S ∘ₖ T) ∘ₘ μ) ih
      _ = S ∘ₘ ((T ∘ₖ S) ∘ₘ (((fun μ ↦ (T ∘ₖ S) ∘ₘ μ)^[n]) (T ∘ₘ ρ))) :=
        actual_kernel_intertwining S T _
      _ = S ∘ₘ (((fun μ ↦ (T ∘ₖ S) ∘ₘ μ)^[n + 1]) (T ∘ₘ ρ)) :=
        congrArg (fun μ ↦ S ∘ₘ μ)
          (Function.iterate_succ_apply' (fun μ : Measure Ω ↦ (T ∘ₖ S) ∘ₘ μ) n (T ∘ₘ ρ)).symm

/-- The first distribution identity follows from actual Markov transport and textbook uniqueness. -/
theorem textbookInvariantDistributionSwap_left (S T : Kernel Ω Ω) [IsMarkovKernel S]
    {ρST ρTS : Measure Ω} (hST : textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS := by
  have : IsProbabilityMeasure ρTS := hTS.1
  exact (hST.2.2 (S ∘ₘ ρTS) inferInstance (textbookKernelInvariant_swap S T hTS.2.1)).symm

/-- Lemma7.1's two actual probability-distribution identities; no swapped identity is assumed. -/
theorem textbookInvariantDistributionSwap (S T : Kernel Ω Ω)
    [IsMarkovKernel S] [IsMarkovKernel T] {ρST ρTS : Measure Ω}
    (hST : textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST := by
  exact ⟨textbookInvariantDistributionSwap_left S T hST hTS,
    textbookInvariantDistributionSwap_left T S hTS hST⟩

end MolecularDynamics
