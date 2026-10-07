import MolecularDynamics.Chapter06.LangevinWeakGeneratorBalance
import MolecularDynamics.Chapter06.LangevinMomentumVariation
import Mathlib.Order.Filter.AtTopBot.CountablyGenerated
import Mathlib.Topology.ContinuousMap.ZeroAtInfty

/-! True C0 preservation of the same original Langevin transition.
Actual reverse momentum bounds justify escape of the original endpoint law. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

private theorem c0Lgv_momentum_initial_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ σ T : ℝ) (hγ : 0 < γ) (x : textbookLangevinPhase N)
    (W q p : ℝ → (Fin N → ℝ)) (h : textbookLangevinIntegralSolution U γ σ T x W q p)
    (M : ℝ) (hM0 : 0 ≤ M) (hM : ∀ z, ‖textbookPotentialForce U z‖ ≤ M)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Real.exp (-γ * t) * ‖x.2‖ ≤ ‖p t‖ + M / γ + ‖textbookLangevinDampedNoise γ σ W t‖ := by
  let R := ∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)
  let Z := textbookLangevinDampedNoise γ σ W t
  have he : p t = Real.exp (-γ * t) • x.2 + R + Z :=
    textbookLangevinMomentum_duhamel U hU γ σ T x W q p h t ht
  have hv : Real.exp (-γ * t) • x.2 = p t - R - Z := by rw [he]; abel
  have hb : ‖R‖ ≤ M / γ :=
    textbookLangevinMomentum_force_convolution_uniform_bound U hU γ t M hγ ht.1 hM0 hM q
      (h.1.mono (Icc_subset_Icc le_rfl ht.2))
  calc
    _ = ‖Real.exp (-γ * t) • x.2‖ := by
      rw [norm_smul, Real.norm_of_nonneg (Real.exp_pos _).le]
    _ = ‖p t - R - Z‖ := congrArg norm hv
    _ ≤ ‖p t‖ + ‖R‖ + ‖Z‖ :=
      (norm_sub_le _ _).trans (add_le_add (norm_sub_le _ _) le_rfl)
    _ ≤ ‖p t‖ + M / γ + ‖textbookLangevinDampedNoise γ σ W t‖ :=
      add_le_add (add_le_add le_rfl hb) le_rfl

private theorem c0Lgv_initial_momentum_escape (N : ℕ) :
    Tendsto (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖)
      (cocompact (textbookLangevinPeriodicPhase N)) atTop := by
  apply tendsto_atTop.mpr
  intro R
  have hK : IsCompact ((univ : Set (UnitAddTorus (Fin N))) ×ˢ Metric.closedBall (0 : Fin N → ℝ) R) :=
    isCompact_univ.prod (isCompact_closedBall _ _)
  filter_upwards [hK.compl_mem_cocompact] with x hx
  by_contra hn
  apply hx
  refine ⟨mem_univ _, ?_⟩
  rw [Metric.mem_closedBall, dist_zero_right]
  exact (lt_of_not_ge hn).le

private theorem c0Lgv_cocompact_of_momentum {N : ℕ} {ι : Type*} {l : Filter ι}
    (x : ι → textbookLangevinPeriodicPhase N)
    (hx : Tendsto (fun i ↦ ‖(x i).2‖) l atTop) :
    Tendsto x l (cocompact (textbookLangevinPeriodicPhase N)) := by
  apply hasBasis_cocompact.tendsto_right_iff.mpr
  intro K hK
  obtain ⟨R, hR⟩ := hK.exists_bound_of_continuousOn continuous_snd.continuousOn
  filter_upwards [hx.eventually (eventually_gt_atTop R)] with i hi
  exact fun hki ↦ (not_le_of_gt hi) (hR (x i) hki)

private theorem c0Lgv_countable (N : ℕ) :
    (cocompact (textbookLangevinPeriodicPhase N)).IsCountablyGenerated := by
  have he : cocompact (textbookLangevinPeriodicPhase N) =
      comap (fun x : textbookLangevinPeriodicPhase N ↦ ‖x.2‖) atTop := by
    apply le_antisymm
    · exact map_le_iff_le_comap.mp (c0Lgv_initial_momentum_escape N)
    · exact tendsto_id'.mp (c0Lgv_cocompact_of_momentum id tendsto_comap)
  rw [he]
  infer_instance

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
/-- The actual original periodic process has a genuine reverse momentum estimate.
Its force constant and damped noise do not depend on the initial phase. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_initial_bound_ae
    (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t →
        Real.exp (-γ * t) * ‖x.2‖ ≤
          ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2‖ + M / γ +
            ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t‖ := by
  obtain ⟨M, hM0, hM⟩ := textbookUnitPeriodicPotential_force_bound U hU hp
  refine ⟨M, hM0, fun x ↦ ?_⟩
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro t ht
  exact c0Lgv_momentum_initial_bound U (hU.of_le (by simp)) γ σ t hγ
    (textbookLangevinPeriodicRepresentative x.1, x.2) _ _ _ (hs t ht) M hM0 hM t ⟨ht, le_rfl⟩

include hB hU hp in
/-- Every initial sequence escaping the genuine periodic phase space has actual
fixed-time endpoints escaping it almost surely. The countable common full-measure
set is derived from the uniform reverse momentum estimate. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_escaping_sequence_ae
    (hγ : 0 < γ) (T : ℝ≥0) (x : ℕ → textbookLangevinPeriodicPhase N)
    (hx : Tendsto x atTop (cocompact (textbookLangevinPeriodicPhase N))) :
    ∀ᵐ sample ∂P, Tendsto
      (fun n ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ (x n) B T sample)
      atTop (cocompact (textbookLangevinPeriodicPhase N)) := by
  obtain ⟨M, _, hb⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_initial_bound_ae
    B P hB U hU hp L hF γ σ hγ
  have hAll : ∀ᵐ sample ∂P, ∀ n : ℕ, ∀ t : ℝ, 0 ≤ t →
      Real.exp (-γ * t) * ‖(x n).2‖ ≤
        ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ (x n) B t sample).2‖ + M / γ +
          ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t‖ :=
    ae_all_iff.mpr (fun n ↦ hb (x n))
  have hInitial := (c0Lgv_initial_momentum_escape N).comp hx
  filter_upwards [hAll] with sample hs
  apply c0Lgv_cocompact_of_momentum
  apply tendsto_atTop.mpr
  intro R
  have he : 0 < Real.exp (-γ * (T : ℝ)) := Real.exp_pos _
  let Z := ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖
  filter_upwards [hInitial.eventually (eventually_ge_atTop ((R + M / γ + Z) / Real.exp (-γ * (T : ℝ))))] with n hn
  have hn' := (div_le_iff₀ he).mp hn
  change R + M / γ + Z ≤ ‖(x n).2‖ * Real.exp (-γ * (T : ℝ)) at hn'
  have hm := hs n T T.property
  change Real.exp (-γ * (T : ℝ)) * ‖(x n).2‖ ≤
    ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ (x n) B T sample).2‖ + M / γ + Z at hm
  nlinarith

include hB hU hp in
/-- The same original transition genuinely preserves functions vanishing at
infinity. True endpoint escape and dominated convergence prove this C0 property;
it is not assumed as a Feller or closed-generator premise. -/
theorem textbookLangevinPeriodicTransitionExpectation_zero_at_infty
    (hγ : 0 < γ) (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ)
    (hf : Tendsto f (cocompact (textbookLangevinPeriodicPhase N)) (𝓝 0)) :
    Tendsto (textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f)
      (cocompact (textbookLangevinPeriodicPhase N)) (𝓝 0) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : (cocompact (textbookLangevinPeriodicPhase N)).IsCountablyGenerated := c0Lgv_countable N
  apply tendsto_iff_seq_tendsto.mpr
  intro x hx
  have hEscape := textbookLangevinPeriodicGlobalRandomPhase_escaping_sequence_ae
    B P hB U hU hp L hF γ σ hγ T x hx
  have hMeas (n : ℕ) : AEStronglyMeasurable
      (fun sample ↦ f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ (x n) B T sample)) P :=
    f.continuous.aestronglyMeasurable.comp_aemeasurable
      (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
        (hU.of_le (by simp)) L hF γ σ (x n) T T.property)
  have hLim : ∀ᵐ sample ∂P, Tendsto
      (fun n ↦ f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ (x n) B T sample)) atTop (𝓝 0) :=
    hEscape.mono (fun sample h ↦ hf.comp h)
  have hDCT := tendsto_integral_of_dominated_convergence (fun _ : Ω ↦ ‖f‖) hMeas
    (integrable_const _) (fun n ↦ Eventually.of_forall (fun sample ↦ f.norm_coe_le_norm _)) hLim
  simp only [integral_zero] at hDCT
  have he : (textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f ∘ x) =
      (fun n ↦ ∫ sample, f
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ (x n) B T sample) ∂P) :=
    funext (fun n ↦ textbookLangevinPeriodicTransitionExpectation_actual_process B P hB U hU hp L hF γ σ T f (x n))
  rw [he]
  exact hDCT


open scoped ZeroAtInfty

private def c0Lgv_transition (hγ : 0 < γ) (T : ℝ≥0)
    (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) :
    C₀(textbookLangevinPeriodicPhase N, ℝ) where
  toFun := textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f.toBCF
  continuous_toFun := textbookLangevinPeriodicTransitionExpectation_continuous B P hB U hU hp L hF γ σ T f.toBCF
  zero_at_infty' := textbookLangevinPeriodicTransitionExpectation_zero_at_infty
    B P hB U hU hp L hF γ σ hγ T f.toBCF (zero_at_infty f)

private theorem c0Lgv_transition_bound (hγ : 0 < γ) (T : ℝ≥0)
    (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) :
    ‖c0Lgv_transition B P hB U hU hp L hF γ σ hγ T f‖ ≤ ‖f‖ := by
  change ‖(c0Lgv_transition B P hB U hU hp L hF γ σ hγ T f).toBCF‖ ≤ ‖f.toBCF‖
  apply (BoundedContinuousFunction.norm_le (norm_nonneg f.toBCF)).mpr
  intro x
  exact textbookLangevinPeriodicTransitionExpectation_norm_le B P hB U hU hp L hF γ σ T f.toBCF x

private def c0Lgv_linear (hγ : 0 < γ) (T : ℝ≥0) :
    C₀(textbookLangevinPeriodicPhase N, ℝ) →ₗ[ℝ] C₀(textbookLangevinPeriodicPhase N, ℝ) where
  toFun := c0Lgv_transition B P hB U hU hp L hF γ σ hγ T
  map_add' f g := by
    have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
    ext x
    have hiF : Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) :=
      (integrable_const ‖f.toBCF‖).mono' f.continuous.aestronglyMeasurable
        (Eventually.of_forall f.toBCF.norm_coe_le_norm)
    have hiG : Integrable g (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) :=
      (integrable_const ‖g.toBCF‖).mono' g.continuous.aestronglyMeasurable
        (Eventually.of_forall g.toBCF.norm_coe_le_norm)
    change (∫ y, f y + g y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) =
      (∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) +
        ∫ y, g y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x
    exact integral_add hiF hiG
  map_smul' r f := by
    ext x
    change (∫ y, r • f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) =
      r • ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x
    exact integral_smul _ _

/-- The actual original transition on C0 is a genuine bounded linear operator,
constructed using the proved C0 preservation and true probability contraction. -/
def textbookLangevinPeriodicC0Transition (hγ : 0 < γ) (T : ℝ≥0) :
    C₀(textbookLangevinPeriodicPhase N, ℝ) →L[ℝ] C₀(textbookLangevinPeriodicPhase N, ℝ) :=
  (c0Lgv_linear B P hB U hU hp L hF γ σ hγ T).mkContinuous 1
    (fun f ↦ by
      change ‖c0Lgv_transition B P hB U hU hp L hF γ σ hγ T f‖ ≤ 1 * ‖f‖
      simpa only [one_mul] using c0Lgv_transition_bound B P hB U hU hp L hF γ σ hγ T f)

/-- This actual C0 operator is exactly the same original kernel expectation. -/
theorem textbookLangevinPeriodicC0Transition_apply (hγ : 0 < γ) (T : ℝ≥0)
    (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f x =
      ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x := rfl

/-- The actual C0 transition has operator norm at most one. -/
theorem textbookLangevinPeriodicC0Transition_norm_le (hγ : 0 < γ) (T : ℝ≥0) :
    ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T‖ ≤ 1 := by
  apply ContinuousLinearMap.opNorm_le_bound _ zero_le_one
  intro f
  change ‖c0Lgv_transition B P hB U hU hp L hF γ σ hγ T f‖ ≤ 1 * ‖f‖
  simpa only [one_mul] using c0Lgv_transition_bound B P hB U hU hp L hF γ σ hγ T f

/-- The same original C0 transition returns the true identity at time zero. -/
theorem textbookLangevinPeriodicC0Transition_zero (hγ : 0 < γ) :
    textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ 0 =
      ContinuousLinearMap.id ℝ C₀(textbookLangevinPeriodicPhase N, ℝ) := by
  ext f x
  change (∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ 0 x) = f x
  rw [textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ, Kernel.id_apply]
  exact integral_dirac _ _

/-- The actual C0 operators satisfy the genuine Chapman-Kolmogorov semigroup
law. Strong norm continuity and a closed generator are separate obligations. -/
theorem textbookLangevinPeriodicC0Transition_add (hγ : 0 < γ) (S T : ℝ≥0) :
    textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ (S + T) =
      (textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ S).comp
        (textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T) := by
  ext f x
  exact congrArg (fun g : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ ↦ g x)
    (textbookLangevinPeriodicBoundedTransition_add B P hB U hU hp L hF γ σ S T f.toBCF)

end
end MolecularDynamics
