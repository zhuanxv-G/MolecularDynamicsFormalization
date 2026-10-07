import MolecularDynamics.Chapter06.LangevinC2Generator

/-! The actual original periodic kernel's pointwise expectation generator on
continuous periodic observables with true C2 lifts and globally bounded Hessians.
The existing periodic differential expression is identified, not assumed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem c2Kernel_initial_projection {N : ℕ} (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicProjection (textbookLangevinPeriodicRepresentative x.1, x.2) = x := by
  change ((fun i ↦ (textbookLangevinPeriodicRepresentative x.1 i : UnitAddCircle)), x.2) = x
  rw [textbookLangevinPeriodicRepresentative_projects]

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
  (F : textbookLangevinPeriodicPhase N → ℝ) (hFc : Continuous F)
  (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection))
  (M : ℝ) (hM : 0 ≤ M)
  (hH : ∀ z, ‖iteratedFDeriv ℝ 2 (F ∘ textbookLangevinPeriodicProjection) z‖ ≤ M)

include hB hU hp hG hH in
/-- The actual original periodic observable endpoint is integrable near zero:
its true real-lift increment is integrable and its initial value is finite. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_C2_observable_local_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ F
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let g := F ∘ textbookLangevinPeriodicProjection
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  have hi := textbookLangevinGlobalRandomPhase_C2_observable_increment_integrable
    B P hB U hU hp L hF γ σ g hG M hH hγ T hT hT1 x
  apply (hi.add (integrable_const (g z))).congr
  exact Eventually.of_forall (fun sample ↦ sub_add_cancel _ _)

include hB hFc hG hH in
/-- The same actual original kernel genuinely integrates the unbounded C2
periodic test observable locally, through its actual endpoint pushforward law. -/
theorem textbookLangevinPeriodicTransitionKernel_C2_observable_local_integrable
    (hγ : 0 < γ) (T : ℝ≥0) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    Integrable F (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact (integrable_map_measure hFc.aestronglyMeasurable
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)).mpr
    (textbookLangevinPeriodicGlobalRandomPhase_C2_observable_local_integrable
      B P hB U hU hp L hF γ σ F hG M hH hγ T T.property (by exact_mod_cast hT1) x)

include hB hFc hG hH in
/-- The actual original kernel expectation minus its initial observable value
equals the genuine integrable periodic-process increment expectation. -/
theorem textbookLangevinPeriodicTransitionKernel_C2_observable_actual_increment_expectation
    (hγ : 0 < γ) (T : ℝ≥0) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    (∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) - F x =
      ∫ sample, F (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - F x ∂P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi := textbookLangevinPeriodicGlobalRandomPhase_C2_observable_local_integrable
    B P hB U hU hp L hF γ σ F hG M hH hγ T T.property (by exact_mod_cast hT1) x
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x,
    integral_map
      (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
        (hU.of_le (by simp)) L hF γ σ x T T.property) hFc.aestronglyMeasurable,
    integral_sub hi (integrable_const _)]
  simp

include hB hU hp hG hM hH in
/-- The existing periodic differential expression is truly the actual original
process expectation generator on this explicit C2 lifted test class. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_C2_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      F (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - F x ∂P) / T)
      (𝓝[>] 0) (𝓝 (textbookLangevinPeriodicDifferentialOperator U γ σ F x)) := by
  have hi : F (textbookLangevinPeriodicProjection (textbookLangevinPeriodicRepresentative x.1, x.2)) = F x :=
    congrArg F (c2Kernel_initial_projection x)
  simpa only [textbookLangevinPeriodicDifferentialOperator, Function.comp_apply,
    textbookLangevinPeriodicGlobalRandomPhase, hi] using
    textbookLangevinGlobalRandomPhase_C2_actual_differentialOperator_limit
      B P hB U hU hp L hF γ σ (F ∘ textbookLangevinPeriodicProjection) hG M hM hH hγ x

include hB hFc hG hM hH in
/-- The actual original periodic transition kernel has the true pointwise C2
expectation generator equal to the existing periodic Langevin differential expression.
A specified closed semigroup domain is a separate question. -/
theorem textbookLangevinPeriodicTransitionKernel_C2_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦
      ((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) - F x) / T)
      (𝓝[>] 0) (𝓝 (textbookLangevinPeriodicDifferentialOperator U γ σ F x)) := by
  have hs := textbookLangevinPeriodicGlobalRandomPhase_C2_actual_differentialOperator_limit
    B P hB U hU hp L hF γ σ F hG M hM hH hγ x
  apply hs.congr'
  filter_upwards [self_mem_nhdsWithin,
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have htNN : t.toNNReal ≤ 1 := by
    exact_mod_cast (show (t.toNNReal : ℝ) ≤ (1 : ℝ) by
      simpa only [Real.coe_toNNReal t ht0.le] using ht1'.le)
  have he := textbookLangevinPeriodicTransitionKernel_C2_observable_actual_increment_expectation
    B P hB U hU hp L hF γ σ F hFc hG M hH hγ t.toNNReal htNN x
  have he' : (∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ t.toNNReal x) - F x =
      ∫ sample, F (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) - F x ∂P := by
    simpa only [Real.coe_toNNReal t ht0.le] using he
  exact congrArg (fun a : ℝ ↦ a / t) he'.symm

end
end MolecularDynamics
