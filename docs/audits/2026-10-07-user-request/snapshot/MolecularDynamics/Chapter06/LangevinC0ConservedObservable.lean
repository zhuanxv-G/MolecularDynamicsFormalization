import MolecularDynamics.Chapter06.LangevinGeneratorOrbit
import Mathlib.MeasureTheory.Measure.OpenPos
import Mathlib.Topology.Order.Compact

/-! Conserved observables in the original C0 semigroup and generator.
Full support comes from the actual Wiener-driven accessibility, without a density. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (hγ : 0 < γ)

local notation "E" => C₀(textbookLangevinPeriodicPhase N, ℝ)
local notation "S" => textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ
local notation "A" => textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ
local notation "G" => textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ

/-- A zero image in the actual right norm graph is equivalent to a genuinely
stationary original orbit, including time zero. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_zero_iff_stationary (f : E) :
    (f, 0) ∈ G ↔ ∀ T : ℝ≥0, S T f = f := by
  rw [textbookLangevinPeriodicC0GeneratorGraph_integrated_iff B P hB U hU hp L hF γ σ hγ f 0]
  simp only [map_zero, intervalIntegral.integral_zero, eq_comm (a := (0 : E)), sub_eq_zero]

/-- The true generator has zero value on a domain element exactly when its
actual semigroup orbit is stationary. -/
theorem textbookLangevinPeriodicC0Generator_zero_iff_stationary
    (f : E) (hf : f ∈ (A).domain) :
    A ⟨f, hf⟩ = 0 ↔ ∀ T : ℝ≥0, S T f = f := by
  have hfg := (A).mem_graph ⟨f, hf⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ] at hfg
  constructor
  · intro hz
    rw [hz] at hfg
    exact (textbookLangevinPeriodicC0GeneratorGraph_zero_iff_stationary
      B P hB U hU hp L hF γ σ hγ f).mp hfg
  · intro hs
    exact textbookLangevinPeriodicC0GeneratorGraph_unique B P hB U hU hp L hF γ σ hγ f _ 0 hfg
      ((textbookLangevinPeriodicC0GeneratorGraph_zero_iff_stationary
        B P hB U hU hp L hF γ σ hγ f).mpr hs)

private theorem conservedC0_positive_max_constant (hσ : σ ≠ 0) (T : ℝ≥0)
    (hT : (0 : ℝ) < T) (f : E) (hf : S T f = f)
    (y : textbookLangevinPeriodicPhase N) (hy : 0 < f y) :
    ∀ a b : textbookLangevinPeriodicPhase N, f a = f b := by
  have htail : ∀ᶠ z in cocompact (textbookLangevinPeriodicPhase N), f z ≤ f y :=
    (f.zero_at_infty'.eventually (Iio_mem_nhds hy)).mono fun _ hz ↦ hz.le
  obtain ⟨x, hmax⟩ := f.continuous.exists_forall_ge' y htail
  let μ := textbookLangevinPeriodicTransitionProbability B P hB U hU hp L hF γ σ T x
  have : Measure.IsOpenPosMeasure (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    ⟨fun C hC hCN ↦ ne_of_gt (textbookLangevinPeriodicTransitionKernel_open_pos
      B P hB U hU hp L hF γ σ T hT hσ x C hC hCN)⟩
  have hi : Integrable f (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (integrable_const ‖f.toBCF‖).mono' f.continuous.aestronglyMeasurable
      (Eventually.of_forall f.toBCF.norm_coe_le_norm)
  have he := textbookLangevinPeriodicC0Transition_apply B P hB U hU hp L hF γ σ hγ T f x
  rw [hf] at he
  change f x = ∫ z, f z ∂(μ : Measure (textbookLangevinPeriodicPhase N)) at he
  have hz : (∫ z, (f x - f z) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) = 0 := by
    rw [integral_sub (integrable_const (f x)) hi]
    simp [he.symm]
  have ha := (integral_eq_zero_iff_of_nonneg
    (fun z ↦ sub_nonneg.mpr (hmax z)) ((integrable_const (f x)).sub hi)).mp hz
  have heq : (fun z ↦ f z) =ᵐ[(μ : Measure (textbookLangevinPeriodicPhase N))] (fun _ ↦ f x) := by
    filter_upwards [ha] with z hz
    exact (sub_eq_zero.mp hz).symm
  have hfull : (fun z ↦ f z) = (fun _ ↦ f x) :=
    Measure.eq_of_ae_eq heq f.continuous continuous_const
  intro a b
  exact (congrFun hfull a).trans (congrFun hfull b).symm

/-- Any original C0 observable fixed by one positive-time transition is
constant. Actual open accessibility and a genuine attained C0 maximum give
the result, without a transition-density or invariant-law premise. -/
theorem textbookLangevinPeriodicC0Transition_fixed_is_constant
    (hσ : σ ≠ 0) (T : ℝ≥0) (hT : (0 : ℝ) < T) (f : E) (hf : S T f = f) :
    ∀ x y : textbookLangevinPeriodicPhase N, f x = f y := by
  by_cases hpF : ∃ y, 0 < f y
  · obtain ⟨y, hy⟩ := hpF
    exact conservedC0_positive_max_constant B P hB U hU hp L hF γ σ hγ hσ T hT f hf y hy
  · by_cases hnF : ∃ y, f y < 0
    · obtain ⟨y, hy⟩ := hnF
      have hneg : S T (-f) = -f := by rw [map_neg, hf]
      have hn := conservedC0_positive_max_constant B P hB U hU hp L hF γ σ hγ hσ T hT
        (-f) hneg y (by simpa using neg_pos.mpr hy)
      intro x z
      have he := hn x z
      change -f x = -f z at he
      exact neg_injective he
    · have hz (x : textbookLangevinPeriodicPhase N) : f x = 0 :=
        le_antisymm (not_lt.mp (fun hx ↦ hpF ⟨x, hx⟩)) (not_lt.mp (fun hx ↦ hnF ⟨x, hx⟩))
      intro x y
      rw [hz x, hz y]

/-- Conserved elements of the actual C0 generator domain are constant.
This identifies that original space's zero modes, separately from the
weighted Sobolev domain appearing in Proposition6.4. -/
theorem textbookLangevinPeriodicC0Generator_zero_is_constant (hσ : σ ≠ 0)
    (f : E) (hf : f ∈ (A).domain) (hz : A ⟨f, hf⟩ = 0) :
    ∀ x y : textbookLangevinPeriodicPhase N, f x = f y := by
  have hs := (textbookLangevinPeriodicC0Generator_zero_iff_stationary
    B P hB U hU hp L hF γ σ hγ f hf).mp hz
  exact textbookLangevinPeriodicC0Transition_fixed_is_constant
    B P hB U hU hp L hF γ σ hγ hσ 1 (by norm_num) f (hs 1)

include B P hB hU hp L hF hγ

/-- A compact periodic C2 test annihilated by the existing original
differential expression is constant, via its proved actual norm graph and
actual open accessibility. No density or Gibbs law is assumed. -/
theorem textbookLangevinPeriodicDifferentialOperator_compactC2_zero_is_constant
    (hσ : σ ≠ 0) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F)
    (hz : ∀ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x = 0) :
    ∀ x y : textbookLangevinPeriodicPhase N, F x = F y := by
  let f := textbookLangevinPeriodicCompactC2Observable F hG hcs
  let g := textbookLangevinPeriodicCompactC2DifferentialImage U hU hp γ σ F hG hcs
  have hg : g = 0 := by
    ext x
    exact hz x
  have hfg := textbookLangevinPeriodicCompactC2_mem_generator_graph B P hB U hU hp L hF γ σ hγ F hG hcs
  change (f, g) ∈ G at hfg
  rw [hg] at hfg
  have hs := (textbookLangevinPeriodicC0GeneratorGraph_zero_iff_stationary
    B P hB U hU hp L hF γ σ hγ f).mp hfg
  exact textbookLangevinPeriodicC0Transition_fixed_is_constant
    B P hB U hU hp L hF γ σ hγ hσ 1 (by norm_num) f (hs 1)

end
end MolecularDynamics
