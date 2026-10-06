import MolecularDynamics.Chapter06.BrownianRandomModel
import MolecularDynamics.Chapter06.LangevinCompletedMarkov

/-! Actual deterministic-time completed-history Markov laws for the same original-mass
Brownian process. Rough-noise restart is combined with genuine future Wiener independence,
rather than identified with the Markov assertion. Torus descent and spectral-law
identification are separate. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

private theorem integral_split_shift {Nc : ℕ}
    (f : ℝ → (Fin Nc → ℝ)) (S T : ℝ) (hS : 0 ≤ S) (hT : 0 ≤ T)
    (hf : ContinuousOn f (Icc 0 (S + T))) (t : ℝ) (ht : t ∈ Icc 0 T) :
    (∫ r in 0..(S + t), f r) = (∫ r in 0..S, f r) + ∫ r in 0..t, f (S + r) := by
  have ha : IntervalIntegrable f volume 0 S := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hS]
    exact hf.mono (Icc_subset_Icc le_rfl (by linarith))
  have hb : IntervalIntegrable f volume S (S + t) := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le (show S ≤ S + t by linarith [ht.1])]
    exact hf.mono (Icc_subset_Icc hS (by linarith [ht.2]))
  rw [intervalIntegral.integral_comp_add_left, add_zero]
  exact (intervalIntegral.integral_add_adjacent_intervals ha hb).symm



private theorem completed_filtration_measurable_congr
    {Nc : ℕ} {Ω E : Type*} [MeasurableSpace Ω] [MeasurableSpace E]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0)
    {f g : Ω → E} (hf : Measurable[textbookWienerVectorCompletedFiltration B P hB S] f)
    (he : f =ᵐ[P] g) : Measurable[textbookWienerVectorCompletedFiltration B P hB S] g := by
  have he' : f =ᵐ[P.completion.trim ((textbookWienerVectorCompletedFiltration B P hB).le S)] g := by
    rw [textbookWienerVectorCompletedFiltration_trim_ae]
    exact he
  exact @Measurable.congr_ae Ω E (textbookWienerVectorCompletedFiltration B P hB S) inferInstance
    (P.completion.trim ((textbookWienerVectorCompletedFiltration B P hB).le S))
    (textbookWienerVectorCompletedFiltration_trim_complete B P hB S) f g hf he'

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

include hU hPU in
/-- The actual rough-noise integral equation restarts with the genuine increment of its driving path. -/
theorem textbookBrownianIntegralSolution_shift (S T : ℝ) (hS : 0 ≤ S) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W q : ℝ → (Fin Nc → ℝ))
    (h : textbookBrownianIntegralSolution m U β (S + T) x W q) :
    textbookBrownianIntegralSolution m U β T (q S)
      (fun t ↦ W (S + t) - W S) (fun t ↦ q (S + t)) := by
  have hmapped : MapsTo (fun t : ℝ ↦ S + t) (Icc 0 T) (Icc 0 (S + T)) := by
    intro t ht
    constructor
    · linarith [ht.1]
    · linarith [ht.2]
  have hsc : ContinuousOn (fun t : ℝ ↦ S + t) (Icc 0 T) :=
    (continuous_const.add continuous_id).continuousOn
  obtain ⟨L, hL⟩ := textbookBrownianSDEDrift_lipschitz m U hU hPU
  have hb : ContinuousOn (fun t ↦ textbookBrownianSDEDrift m U (q t)) (Icc 0 (S + T)) :=
    hL.continuous.comp_continuousOn h.1
  have hSin : S ∈ Icc 0 (S + T) := ⟨hS, by linarith⟩
  refine ⟨h.1.comp hsc hmapped, (h.2.1.comp hsc hmapped).sub continuousOn_const, fun t ht ↦ ?_⟩
  change q (S + t) = q S + (∫ r in 0..t, textbookBrownianSDEDrift m U (q (S + r))) +
    textbookBrownianSDENoise m β ((W (S + t) - W S) - (W (S + 0) - W S))
  simp only [add_zero, sub_self, sub_zero]
  rw [h.2.2 (S + t) (hmapped ht), h.2.2 S hSin,
    integral_split_shift (fun r ↦ textbookBrownianSDEDrift m U (q r)) S T hS hT hb t ht]
  simp only [map_sub]
  abel

/-- On one common full-measure sample set the same actual global process restarts with its true future Wiener process. -/
theorem textbookBrownianGlobalRandomConfiguration_future_restart_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ S : ℝ≥0, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B (S + t) sample =
        textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT
          (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample) t
          (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x,
    hB.cont] with sample hg hc
  intro S T hT t ht
  let q : ℝ → (Fin Nc → ℝ) :=
    fun r ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B r sample
  have hs := textbookBrownianIntegralSolution_shift m U hU hPU β S T S.property hT x
    (fun r ↦ B r.toNNReal sample) q (hg (S + T) (add_nonneg S.property hT))
  have he : EqOn (fun r : ℝ ↦ textbookWienerVectorFuture B S r.toNNReal sample)
      (fun r : ℝ ↦ B ((S : ℝ) + r).toNNReal sample - B ((S : ℝ).toNNReal) sample) (Icc 0 T) := by
    intro r hr
    change B (S + r.toNNReal) sample - B S sample =
      B ((S : ℝ) + r).toNNReal sample - B ((S : ℝ).toNNReal) sample
    have hi : ((S : ℝ) + r).toNNReal = S + r.toNNReal := by
      apply NNReal.eq
      change max ((S : ℝ) + r) 0 = (S : ℝ) + max r 0
      calc
        _ = (S : ℝ) + r := max_eq_left (add_nonneg S.property hr.1)
        _ = (S : ℝ) + max r 0 :=
          congrArg (fun a : ℝ ↦ (S : ℝ) + a) (max_eq_left hr.1).symm
    exact congrArg₂ (fun a b : ℝ≥0 ↦ B a sample - B b sample)
      hi.symm (Real.toNNReal_coe (r := S)).symm
  have hs' := textbookBrownianIntegralSolution_noise_congr m U β T hT (q S) _ _
    (fun r ↦ q (S + r)) hs he
  have hf : Continuous (fun r ↦ textbookWienerVectorFuture B S r sample) :=
    (hc.comp (continuous_const.add continuous_id)).sub continuous_const
  have hr := textbookBrownianRandomSolution_integralSolution_of_cont m hm U hU hPU β hβ
    (textbookWienerVectorFuture B S) T hT (q S) sample hf
  exact textbookBrownianIntegralSolution_unique m U hU hPU β T hT (q S) _ _ _ hs' hr t ht

/-- The same true Brownian configuration process is adapted to the actual completed Wiener filtration. -/
theorem textbookBrownianGlobalRandomConfiguration_adapted {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) :
    Adapted (textbookWienerVectorCompletedFiltration B P hB)
      (fun S : ℝ≥0 ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B S) := by
  intro S
  have mh : Measurable[textbookWienerVectorCompletedFiltration B P hB S]
      (fun sample ↦ textbookBrownianPathEndpoint m hm U hU hPU β hβ S S.property x S
        (textbookWienerVectorContinuousPath B S sample)) :=
    (textbookBrownianPathEndpoint_measurable m hm U hU hPU β hβ S S.property x S
      ⟨S.property, le_rfl⟩).comp
      (textbookWienerVectorContinuousPath_filtration_measurable B P hB S)
  apply completed_filtration_measurable_congr B P hB S mh
  filter_upwards [textbookBrownianGlobalRandomConfiguration_history_path_ae m hm U hU hPU β hβ B P hB x]
    with sample hs
  exact (hs S S.property S ⟨S.property, le_rfl⟩).symm

/-- The actual transition kernel integrates the original Brownian endpoint against the genuine Wiener path law. -/
def textbookBrownianTransitionKernel {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (T : ℝ≥0) :
    Kernel (Fin Nc → ℝ) (Fin Nc → ℝ) :=
  (Kernel.deterministic
    (fun z : (Fin Nc → ℝ) × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookBrownianPathEndpoint m hm U hU hPU β hβ T T.property z.1 T z.2)
    (textbookBrownianPathEndpoint_joint_measurable m hm U hU hPU β hβ
      T T.property T ⟨T.property, le_rfl⟩)) ∘ₖ
      (Kernel.id ×ₖ Kernel.const (Fin Nc → ℝ) (P.map (textbookWienerVectorContinuousPath B T)))

/-- The genuine Wiener law makes the actual Brownian transition kernel a probability kernel. -/
theorem textbookBrownianTransitionKernel_isMarkov {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) :
    IsMarkovKernel (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookBrownianTransitionKernel
  infer_instance

/-- Each genuine transition measure is literally the endpoint pushforward of the true continuous Wiener path law. -/
theorem textbookBrownianTransitionKernel_apply {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (x : Fin Nc → ℝ) :
    textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T x =
      (P.map (textbookWienerVectorContinuousPath B T)).map
        (textbookBrownianPathEndpoint m hm U hU hPU β hβ T T.property x T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookBrownianTransitionKernel
  rw [Kernel.deterministic_comp_eq_map, Kernel.map_apply, Kernel.prod_apply,
    Kernel.id_apply, Kernel.const_apply, Measure.dirac_prod, Measure.map_map]
  all_goals first
    | exact textbookBrownianPathEndpoint_joint_measurable m hm U hU hPU β hβ
        T T.property T ⟨T.property, le_rfl⟩
    | exact measurable_prodMk_left
    | rfl

/-- The transition measure is the actual time law of the same single global Wiener-driven Brownian process. -/
theorem textbookBrownianTransitionKernel_global_law {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (x : Fin Nc → ℝ) :
    textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T x =
      textbookBrownianGlobalTimeLaw m hm U hU hPU β hβ x B P T := by
  rw [textbookBrownianTransitionKernel_apply m hm U hU hPU β hβ B P hB T x,
    AEMeasurable.map_map_of_aemeasurable
      (textbookBrownianPathEndpoint_measurable m hm U hU hPU β hβ T T.property x T
        ⟨T.property, le_rfl⟩).aemeasurable
      (textbookWienerVectorContinuousPath_aemeasurable B P hB T)]
  apply Measure.map_congr
  filter_upwards [textbookBrownianGlobalRandomConfiguration_history_path_ae m hm U hU hPU β hβ B P hB x]
    with sample hs
  exact (hs T T.property T ⟨T.property, le_rfl⟩).symm

/-- The actual Brownian transition laws are independent of the realization of the genuine standard Wiener process. -/
theorem textbookBrownianTransitionKernel_wiener_law_invariant {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (C : ℝ≥0 → Ω' → (Fin Nc → ℝ)) (Q : Measure Ω') (hC : textbookIsWienerVector C Q)
    (T : ℝ≥0) :
    textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T =
      textbookBrownianTransitionKernel m hm U hU hPU β hβ C Q T := by
  unfold textbookBrownianTransitionKernel
  rw [textbookWienerVectorContinuousPath_law_eq B P hB C Q hC T T.property]

private theorem completedBrownian_endpoint_joint_law
    {A H X W : Type*} [MeasurableSpace A] [MeasurableSpace H]
    [MeasurableSpace X] [MeasurableSpace W]
    (Q : Measure A) [IsProbabilityMeasure Q] (μ : Measure W) [SFinite μ]
    (Hobs : A → H) (mh : Measurable Hobs) (F : A → W) (mf : Measurable F)
    (e : H → X) (me : Measurable e) (E : X × W → X) (mE : Measurable E)
    (Y : A → X) (κ : Kernel X X) [IsMarkovKernel κ]
    (hj : Q.map (fun sample ↦ (Hobs sample, F sample)) = (Q.map Hobs).prod μ)
    (hr : Y =ᵐ[Q] fun sample ↦ E (e (Hobs sample), F sample))
    (hκ : ∀ x, κ x = μ.map (fun w ↦ E (x, w))) :
    Q.map (fun sample ↦ (Hobs sample, Y sample)) = (Q.map Hobs) ⊗ₘ κ.comap e me := by
  let G : H × W → H × X := fun z ↦ (z.1, E (e z.1, z.2))
  have mG : Measurable G :=
    measurable_fst.prodMk (mE.comp ((me.comp measurable_fst).prodMk measurable_snd))
  have hmap : Q.map (fun sample ↦ (Hobs sample, Y sample)) =
      (Q.map (fun sample ↦ (Hobs sample, F sample))).map G := by
    rw [Measure.map_map mG (mh.prodMk mf)]
    apply Measure.map_congr
    filter_upwards [hr] with sample hs using Prod.ext rfl hs
  rw [hmap, hj]
  ext a ha
  rw [Measure.map_apply mG ha, Measure.prod_apply (mG ha), Measure.compProd_apply ha]
  apply lintegral_congr
  intro h
  have mef : Measurable (fun w : W ↦ E (e h, w)) :=
    mE.comp (measurable_const.prodMk measurable_id)
  rw [Kernel.comap_apply, hκ, Measure.map_apply mef (ha.preimage measurable_prodMk_left)]
  rfl




/-- The actual future configuration and the entire completed past have the genuine Brownian transition disintegration. -/
theorem textbookBrownianGlobalRandomConfiguration_completed_history_transition_joint_law
    {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : (Fin Nc → ℝ)) (S T : ℝ≥0) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B ((S : ℝ) + T) sample)) P.completion =
    (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ
      (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T).comap
        (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
          textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample)
        (textbookBrownianGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc (0 : ℝ) T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  apply completedBrownian_endpoint_joint_law P.completion
    (P.map (textbookWienerVectorContinuousPath B T))
    (textbookWienerVectorCompletedHistoryObservation B P hB S)
    (textbookWienerVectorCompletedHistoryObservation_measurable B P hB S)
    _ mf _ (textbookBrownianGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S)
    (fun z : (Fin Nc → ℝ) × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookBrownianPathEndpoint m hm U hU hPU β hβ T T.property z.1 T z.2)
    (textbookBrownianPathEndpoint_joint_measurable m hm U hU hPU β hβ
      T T.property T ⟨T.property, le_rfl⟩)
  · exact textbookWienerVectorFuture_completed_history_product_law B P hB S T
  · rw [Measure.ae_completion]
    filter_upwards [textbookBrownianGlobalRandomConfiguration_future_restart_ae m hm U hU hPU β hβ B P hB x]
      with sample hs
    exact hs S T T.property T ⟨T.property, le_rfl⟩
  · exact textbookBrownianTransitionKernel_apply m hm U hU hPU β hβ B P hB T

/-- Given the actual completed Wiener past, the same actual future-state law depends only on the current state. -/
theorem textbookBrownianGlobalRandomConfiguration_condDistrib_completed_history
    {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : (Fin Nc → ℝ)) (S T : ℝ≥0) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    letI : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
    ∀ᵐ sample ∂P.completion,
      @condDistrib (NullMeasurableSpace Ω P)
        (textbookWienerVectorCompletedHistorySpace B P hB S) ((Fin Nc → ℝ))
        inferInstance inferInstance inferInstance inferInstance inferInstance
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B ((S : ℝ) + T))
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S sample) =
      textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  have mh := textbookWienerVectorCompletedHistoryObservation_measurable B P hB S
  have my := (textbookBrownianGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x).measurable
    (i := S + T)
  let κ : Kernel (textbookWienerVectorCompletedHistorySpace B P hB S) ((Fin Nc → ℝ)) :=
    (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T).comap
      (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
        textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample)
      (textbookBrownianGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S)
  have : IsMarkovKernel κ := by
    refine ⟨fun sample ↦ ⟨?_⟩⟩
    change (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample)) univ = 1
    exact measure_univ
  have hj : @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (fun sample ↦ (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B ((S : ℝ) + T) sample)) P.completion =
      (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ κ :=
    textbookBrownianGlobalRandomConfiguration_completed_history_transition_joint_law m hm U hU hPU β hβ B P hB x S T
  have hc := condDistrib_ae_eq_of_measure_eq_compProd (κ := κ)
    mh.aemeasurable my.aemeasurable hj
  exact ae_of_ae_map mh.aemeasurable hc


end
end MolecularDynamics