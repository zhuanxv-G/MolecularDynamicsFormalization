import MolecularDynamics.Chapter06.LangevinCesaroLaw
import MolecularDynamics.Chapter06.LangevinWeakFeller
import Mathlib.Analysis.SpecificLimits.Basic

/-! Actual original Langevin skeleton invariant-law existence from genuine Cesaro laws and true weak Feller continuity. No density or invariant-law premise is used. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- Evolution of a genuine initial probability law by the same actual original transition kernel. -/
def textbookLangevinPeriodicProbabilityEvolution (T : ℝ≥0)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    ProbabilityMeasure (textbookLangevinPeriodicPhase N) := by
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  exact ⟨textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
    (μ : Measure (textbookLangevinPeriodicPhase N)), inferInstance⟩

/-- Actual probability-law evolution acts on original bounded continuous tests by the true kernel expectation operator. -/
theorem textbookLangevinPeriodicProbabilityEvolution_integral (T : ℝ≥0)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    (∫ y, f y ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ :
      Measure (textbookLangevinPeriodicPhase N))) =
      ∫ x, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f x
        ∂(μ : Measure (textbookLangevinPeriodicPhase N)) := by
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T
  have : IsMarkovKernel K := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  change (∫ y, f y ∂(K ∘ₘ (μ : Measure (textbookLangevinPeriodicPhase N)))) = _
  rw [Measure.comp_eq_comp_const_apply]
  have hi : Integrable f ((K ∘ₖ Kernel.const Unit (μ : Measure (textbookLangevinPeriodicPhase N))) ()) :=
    (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable
      (Eventually.of_forall f.norm_coe_le_norm)
  simpa only [Kernel.const_apply, textbookLangevinPeriodicBoundedTransition_apply] using Kernel.integral_comp hi

/-- Genuine weak Feller test continuity yields weak continuity of the same actual probability-law evolution. -/
theorem textbookLangevinPeriodicProbabilityEvolution_continuous (T : ℝ≥0) :
    Continuous (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T) := by
  apply ProbabilityMeasure.continuous_iff_forall_continuous_integral.mpr
  intro f
  have he : (fun μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) ↦
      ∫ y, f y ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ :
        Measure (textbookLangevinPeriodicPhase N))) =
      (fun μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) ↦
        ∫ x, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f x
          ∂(μ : Measure (textbookLangevinPeriodicPhase N))) :=
    funext (fun μ ↦ textbookLangevinPeriodicProbabilityEvolution_integral B P hB U hU hp L hF γ σ T μ f)
  rw [he]
  exact ProbabilityMeasure.continuous_integral_boundedContinuousFunction _

/-- The actual one-step Cesaro test defect telescopes to the true last transition expectation minus the true initial value, with the actual n+1 normalization. -/
theorem textbookLangevinPeriodicCesaroProbability_transition_defect
    (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (n : ℕ)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    (∫ y, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f y
      ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
        Measure (textbookLangevinPeriodicPhase N))) -
      (∫ y, f y ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
        Measure (textbookLangevinPeriodicPhase N))) =
      ((n + 1 : ℕ) : ℝ)⁻¹ *
        ((∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
          (((n + 1 : ℕ) : ℝ≥0) * τ) x) - f x) := by
  let a := fun i : ℕ ↦ ∫ y, f y
    ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ) x
  have hshift (i : ℕ) :
      (∫ y, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((i : ℝ≥0) * τ) x) =
        a (i + 1) := by
    change textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ ((i : ℝ≥0) * τ)
      (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f) x =
      textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ (((i + 1 : ℕ) : ℝ≥0) * τ) f x
    have ht : (i : ℝ≥0) * τ + τ = ((i + 1 : ℕ) : ℝ≥0) * τ := by push_cast; ring
    rw [← textbookLangevinPeriodicBoundedTransition_add B P hB U hU hp L hF γ σ, ht]
  have ha0 : a 0 = f x := by
    dsimp only [a]
    rw [Nat.cast_zero, zero_mul, textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ,
      Kernel.id_apply, integral_dirac]
  rw [textbookLangevinPeriodicCesaroProbability_integral, textbookLangevinPeriodicCesaroProbability_integral]
  simp_rw [hshift]
  change ((n + 1 : ℕ) : ℝ)⁻¹ * (∑ i ∈ Finset.range (n + 1), a (i + 1)) -
    ((n + 1 : ℕ) : ℝ)⁻¹ * (∑ i ∈ Finset.range (n + 1), a i) =
    ((n + 1 : ℕ) : ℝ)⁻¹ * (a (n + 1) - f x)
  rw [← mul_sub, ← Finset.sum_sub_distrib, Finset.sum_range_sub, ha0]

/-- The actual probability expectations bound the true Cesaro defect by 2 times the original test norm divided by n+1. -/
theorem textbookLangevinPeriodicCesaroProbability_transition_defect_norm_le
    (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (n : ℕ)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    ‖(∫ y, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f y
      ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
        Measure (textbookLangevinPeriodicPhase N))) -
      (∫ y, f y ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
        Measure (textbookLangevinPeriodicPhase N)))‖ ≤
      2 * ‖f‖ / ((n + 1 : ℕ) : ℝ) := by
  rw [textbookLangevinPeriodicCesaroProbability_transition_defect, norm_mul, Real.norm_of_nonneg (by positivity)]
  have he : ‖∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
      (((n + 1 : ℕ) : ℝ≥0) * τ) x‖ ≤ ‖f‖ :=
    textbookLangevinPeriodicTransitionExpectation_norm_le B P hB U hU hp L hF γ σ _ f x
  have hs : ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
      (((n + 1 : ℕ) : ℝ≥0) * τ) x) - f x‖ ≤ 2 * ‖f‖ :=
    (norm_sub_le _ _).trans (by have hx := f.norm_coe_le_norm x; linarith)
  calc
    _ ≤ ((n + 1 : ℕ) : ℝ)⁻¹ * (2 * ‖f‖) := mul_le_mul_of_nonneg_left hs (by positivity)
    _ = _ := by rw [div_eq_mul_inv]; ring

/-- The actual one-step Cesaro expectation defect truly tends to zero for every bounded continuous original observable. -/
theorem textbookLangevinPeriodicCesaroProbability_transition_defect_tendsto
    (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    Tendsto (fun n : ℕ ↦
      (∫ y, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f y
        ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
          Measure (textbookLangevinPeriodicPhase N))) -
        (∫ y, f y ∂(textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x n :
          Measure (textbookLangevinPeriodicPhase N)))) atTop (𝓝 0) := by
  have hr : Tendsto (fun n : ℕ ↦ 2 * ‖f‖ / ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) :=
    (tendsto_const_div_atTop_nhds_zero_nat (2 * ‖f‖)).comp (tendsto_add_atTop_nat 1)
  exact squeeze_zero_norm
    (fun n ↦ textbookLangevinPeriodicCesaroProbability_transition_defect_norm_le B P hB U hU hp L hF γ σ τ x n f) hr

/-- A genuine weak Cesaro subsequence limit is actually invariant under the same skeleton kernel; invariance is derived from the true defect limit and weak Feller tests. -/
theorem textbookLangevinPeriodicCesaroProbability_weak_limit_invariant
    (τ : ℝ≥0) (x : textbookLangevinPeriodicPhase N)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) (φ : ℕ → ℕ) (hφ : StrictMono φ)
    (hlim : Tendsto (fun n ↦ textbookLangevinPeriodicCesaroProbability B P hB U hU hp L hF γ σ τ x (φ n))
      atTop (𝓝 μ)) :
    textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  have hfinite :
      (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ τ μ).toFiniteMeasure =
        μ.toFiniteMeasure := by
    apply FiniteMeasure.ext_of_forall_integral_eq
    intro f
    have hL := ProbabilityMeasure.tendsto_iff_forall_integral_tendsto.mp hlim
      (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f)
    have hR := ProbabilityMeasure.tendsto_iff_forall_integral_tendsto.mp hlim f
    have hzero := (textbookLangevinPeriodicCesaroProbability_transition_defect_tendsto
      B P hB U hU hp L hF γ σ τ x f).comp hφ.tendsto_atTop
    have he : (∫ y, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ f y
      ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
      (∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0 :=
        tendsto_nhds_unique (hL.sub hR) hzero
    change (∫ y, f y ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ τ μ :
      Measure (textbookLangevinPeriodicPhase N))) = _
    rw [textbookLangevinPeriodicProbabilityEvolution_integral]
    exact sub_eq_zero.mp he
  have hprob := (ProbabilityMeasure.toFiniteMeasure_isEmbedding (textbookLangevinPeriodicPhase N)).injective hfinite
  exact congrArg (fun ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N) ↦
    (ν : Measure (textbookLangevinPeriodicPhase N))) hprob

include hB in
/-- The original actual Langevin kernel has a genuine probability invariant law at a derived positive skeleton time, without any density or invariant-law assumption. -/
theorem textbookLangevinPeriodicTransitionKernel_skeleton_invariant_exists
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicCesaroProbability_weak_subsequence B P hB U hU hp L hF γ σ hLower hγ
  let x : textbookLangevinPeriodicPhase N := ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ))
  obtain ⟨μ, φ, hφ, hlim⟩ := h x
  exact ⟨τ, hτ, μ, textbookLangevinPeriodicCesaroProbability_weak_limit_invariant B P hB U hU hp L hF γ σ τ x μ φ hφ hlim⟩

end
end MolecularDynamics
