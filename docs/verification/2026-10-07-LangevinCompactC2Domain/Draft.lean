import MolecularDynamics.Chapter06.LangevinC0GeneratorGraph
import MolecularDynamics.Chapter06.LangevinWeakGeneratorBalance
import Mathlib.Analysis.Calculus.Deriv.Slope

/-! Compact periodic C2 tests belong to the actual original norm-generator domain.
True transition moments and dominated kernel limits give the orbit FTC identity. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty

namespace MolecularDynamics
noncomputable section

/-- The original transition law has a genuine finite momentum second moment
at every nonnegative time, without an invariant-law or moment premise. -/
theorem textbookLangevinPeriodicTransitionKernel_momentum_norm_square_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun y : textbookLangevinPeriodicPhase N ↦ ‖y.2‖ ^ 2)
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact (integrable_map_measure (continuous_snd.norm.pow 2).aestronglyMeasurable
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)).mpr
    ((textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp B P hB U hU hp L hF γ σ T hγ T.property x).integrable_norm_pow (by norm_num))

/-- A genuinely compact periodic C2 observable, on the original phase space. -/
def textbookLangevinPeriodicCompactC2Observable {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F) :
    C₀(textbookLangevinPeriodicPhase N, ℝ) where
  toFun := F
  continuous_toFun :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  zero_at_infty' := hcs.is_zero_at_infty

/-- The existing differential expression, bundled as its proved genuine C0 image. -/
def textbookLangevinPeriodicCompactC2DifferentialImage {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F) :
    C₀(textbookLangevinPeriodicPhase N, ℝ) where
  toFun := textbookLangevinPeriodicDifferentialOperator U γ σ F
  continuous_toFun := textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ F hG
  zero_at_infty' :=
    (textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U γ σ F hG hcs).is_zero_at_infty

private def domainC2_eval {N : ℕ} (x : textbookLangevinPeriodicPhase N) :
    C₀(textbookLangevinPeriodicPhase N, ℝ) →L[ℝ] ℝ :=
  (show C₀(textbookLangevinPeriodicPhase N, ℝ) →ₗ[ℝ] ℝ from
    { toFun := fun f ↦ f x
      map_add' := fun _ _ ↦ rfl
      map_smul' := fun _ _ ↦ rfl }).mkContinuous 1 (fun f ↦ by
        change ‖f x‖ ≤ 1 * ‖f‖
        rw [one_mul]
        change ‖f.toBCF x‖ ≤ ‖f.toBCF‖
        exact f.toBCF.norm_coe_le_norm x)

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (hγ : 0 < γ)
  (F : textbookLangevinPeriodicPhase N → ℝ)
  (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F)

local notation "E" => C₀(textbookLangevinPeriodicPhase N, ℝ)
local notation "S" => textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ
local notation "f" => textbookLangevinPeriodicCompactC2Observable F hG hcs
local notation "g" => textbookLangevinPeriodicCompactC2DifferentialImage U hU hp γ σ F hG hcs
local notation "A" => textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ

private theorem domainC2_integrable (v : E) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    Integrable v (μ : Measure (textbookLangevinPeriodicPhase N)) :=
  (integrable_const ‖v.toBCF‖).mono' v.continuous.aestronglyMeasurable
    (Eventually.of_forall v.toBCF.norm_coe_le_norm)

private theorem domainC2_expectation_right_derivative (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) :
    HasDerivWithinAt (fun t : ℝ ↦ S T (S t.toNNReal f) x) (S T g x) (Ioi 0) 0 := by
  let μ := textbookLangevinPeriodicTransitionProbability B P hB U hU hp L hF γ σ T x
  have hiP : Integrable (fun y : textbookLangevinPeriodicPhase N ↦ ‖y.2‖ ^ 2)
      (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    textbookLangevinPeriodicTransitionKernel_momentum_norm_square_integrable B P hB U hU hp L hF γ σ hγ T x
  have hLim := (textbookLangevinPeriodicTransitionKernel_compactC2_integrated_generator_limit
    B P hB U hU hp L hF γ σ F hG hcs hγ μ hiP).2
  apply (hasDerivWithinAt_iff_tendsto_slope' (by simp : (0 : ℝ) ∉ Ioi 0)).mpr
  have he : slope (fun t : ℝ ↦ S T (S t.toNNReal f) x) 0 =
      (fun t : ℝ ↦ ∫ y,
        ((∫ z, F z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ t.toNNReal y) - F y) / t
          ∂(μ : Measure (textbookLangevinPeriodicPhase N))) := by
    funext t
    rw [slope_def_module, sub_zero, Real.toNNReal_zero,
      textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.id_apply]
    change t⁻¹ • ((∫ y, (S t.toNNReal f) y ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
      ∫ y, ((S t.toNNReal f) y - f y) / t ∂(μ : Measure (textbookLangevinPeriodicPhase N))
    rw [integral_div, integral_sub (domainC2_integrable (S t.toNNReal f) μ) (domainC2_integrable f μ)]
    simp only [smul_eq_mul, div_eq_mul_inv, mul_comm]
  rw [he]
  exact hLim

/-- Actual transition moments and dominated generator limits give the genuine
right derivative of each compact C2 orbit at every nonnegative time. -/
theorem textbookLangevinPeriodicC0Transition_compactC2_orbit_right_derivative
    (x : textbookLangevinPeriodicPhase N) (t : ℝ) (ht : 0 ≤ t) :
    HasDerivWithinAt (fun s : ℝ ↦ S s.toNNReal f x) (S t.toNNReal g x) (Ioi t) t := by
  have hd0 := domainC2_expectation_right_derivative B P hB U hU hp L hF γ σ hγ F hG hcs t.toNNReal x
  have hshift := hd0.scomp_of_eq t ((hasDerivAt_id t).sub_const t).hasDerivWithinAt
    (show MapsTo (fun s : ℝ ↦ s - t) (Ioi t) (Ioi 0) from
      fun s hs ↦ by
        change 0 < s - t
        exact sub_pos.mpr hs) (by simp)
  have hd : HasDerivWithinAt (fun s : ℝ ↦ S t.toNNReal (S (s - t).toNNReal f) x)
      (S t.toNNReal g x) (Ioi t) t := by
    simpa only [Function.comp_apply, one_smul, id_eq] using! hshift
  apply hd.congr
  · intro s hs
    have hs0 : 0 ≤ s := ht.trans hs.le
    have he : t.toNNReal + (s - t).toNNReal = s.toNNReal := by
      apply NNReal.eq
      simp only [NNReal.coe_add, Real.coe_toNNReal t ht,
        Real.coe_toNNReal (s - t) (sub_nonneg.mpr hs.le), Real.coe_toNNReal s hs0]
      ring
    rw [← he, textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.comp_apply]
  · simp only [sub_self, Real.toNNReal_zero,
      textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.id_apply]

/-- The compact C2 observable satisfies the actual C0-valued integrated
generator identity, proved by true scalar FTC and continuous point evaluation. -/
theorem textbookLangevinPeriodicC0Transition_compactC2_integrated_identity (T : ℝ≥0) :
    (∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g) = S T f - f := by
  have hc (v : E) : Continuous (fun s : ℝ ↦ S s.toNNReal v) :=
    (textbookLangevinPeriodicC0Transition_strong_continuous B P hB U hU hp L hF γ σ hγ v).comp
      continuous_real_toNNReal
  ext x
  change domainC2_eval x (∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g) = domainC2_eval x (S T f - f)
  rw [← (domainC2_eval x).intervalIntegral_comp_comm ((hc g).intervalIntegrable _ _),
    map_sub]
  have hfC : Continuous (fun s : ℝ ↦ S s.toNNReal f x) := (domainC2_eval x).continuous.comp (hc f)
  have hgC : Continuous (fun s : ℝ ↦ S s.toNNReal g x) := (domainC2_eval x).continuous.comp (hc g)
  have he := intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le T.property hfC.continuousOn
    (fun t ht ↦ textbookLangevinPeriodicC0Transition_compactC2_orbit_right_derivative
      B P hB U hU hp L hF γ σ hγ F hG hcs x t ht.1.le)
    (hgC.intervalIntegrable _ _)
  change (∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g x) = S T f x - f x
  change (∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g x) =
    S (T : ℝ).toNNReal f x - S (0 : ℝ).toNNReal f x at he
  have hT : (T : ℝ).toNNReal = T := Real.toNNReal_coe
  rw [hT] at he
  simpa only [Real.toNNReal_zero,
    textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
    ContinuousLinearMap.id_apply] using he

/-- Compact periodic C2 tests lie in the actual right norm derivative graph
with exactly the existing textbook differential expression as image. -/
theorem textbookLangevinPeriodicCompactC2_mem_generator_graph :
    (f, g) ∈ textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ := by
  apply (textbookLangevinPeriodicC0GeneratorGraph_integrated_iff B P hB U hU hp L hF γ σ hγ f g).mpr
  exact textbookLangevinPeriodicC0Transition_compactC2_integrated_identity B P hB U hU hp L hF γ σ hγ F hG hcs

/-- Membership in the genuine densely defined closed generator domain is
derived for each compact periodic C2 test, without a norm-limit premise. -/
theorem textbookLangevinPeriodicCompactC2_mem_generator_domain : f ∈ (A).domain := by
  apply LinearPMap.mem_domain_iff.mpr
  refine ⟨g, ?_⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ]
  exact textbookLangevinPeriodicCompactC2_mem_generator_graph B P hB U hU hp L hF γ σ hγ F hG hcs

/-- The actual closed generator agrees with the original differential
expression on every compact periodic C2 test. A graph core remains separate. -/
theorem textbookLangevinPeriodicC0Generator_compactC2_apply :
    A ⟨f, textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hF γ σ hγ F hG hcs⟩ = g := by
  have ha := (A).mem_graph
    ⟨f, textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hF γ σ hγ F hG hcs⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ] at ha
  exact textbookLangevinPeriodicC0GeneratorGraph_unique B P hB U hU hp L hF γ σ hγ f _ g ha
    (textbookLangevinPeriodicCompactC2_mem_generator_graph B P hB U hU hp L hF γ σ hγ F hG hcs)

end
end MolecularDynamics
