import MolecularDynamics.Chapter06.LangevinInitialState
import Mathlib.Probability.Kernel.CondDistrib

/-! The actual transition kernel of the constructed Langevin process.
Necessary Markov-model dependency of Theorem 6.2 (printed 252 / PDF 273). -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics

/-- The true transition kernel: integrate the actual endpoint against the genuine Wiener path law. -/
noncomputable def textbookLangevinTransitionKernel {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) :
    Kernel (textbookLangevinPhase Nc) (textbookLangevinPhase Nc) :=
  (Kernel.deterministic
    (fun z : textbookLangevinPhase Nc × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookLangevinPathEndpoint U L hF γ σ T T.property z.1 T z.2)
    (textbookLangevinPathEndpoint_joint_measurable U hU L hF γ σ T T.property T ⟨T.property, le_rfl⟩)) ∘ₖ
      (Kernel.id ×ₖ Kernel.const (textbookLangevinPhase Nc)
        (P.map (textbookWienerVectorContinuousPath B T)))

/-- The actual transition kernel is a probability kernel, derived from the genuine Wiener law. -/
theorem textbookLangevinTransitionKernel_isMarkov {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) :
    IsMarkovKernel (textbookLangevinTransitionKernel B P U hU L hF γ σ T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookLangevinTransitionKernel
  infer_instance

/-- Each actual transition measure is literally the actual endpoint pushforward of the true Wiener path law. -/
theorem textbookLangevinTransitionKernel_apply {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (x : textbookLangevinPhase Nc) :
    textbookLangevinTransitionKernel B P U hU L hF γ σ T x =
      (P.map (textbookWienerVectorContinuousPath B T)).map
        (textbookLangevinPathEndpoint U L hF γ σ T T.property x T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookLangevinTransitionKernel
  rw [Kernel.deterministic_comp_eq_map, Kernel.map_apply, Kernel.prod_apply,
    Kernel.id_apply, Kernel.const_apply, Measure.dirac_prod, Measure.map_map]
  all_goals first
    | exact textbookLangevinPathEndpoint_joint_measurable U hU L hF γ σ T T.property T ⟨T.property, le_rfl⟩
    | exact measurable_prodMk_left
    | rfl

/-- The transition measure is the law of the same genuine all-time process at the stated time. -/
theorem textbookLangevinTransitionKernel_global_law {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (x : textbookLangevinPhase Nc) :
    textbookLangevinTransitionKernel B P U hU L hF γ σ T x =
      P.map (textbookLangevinGlobalRandomPhase U L hF γ σ x B T) := by
  rw [textbookLangevinTransitionKernel_apply B P hB U hU L hF γ σ T x,
    AEMeasurable.map_map_of_aemeasurable
      (textbookLangevinPathEndpoint_continuous U hU L hF γ σ T T.property x T ⟨T.property, le_rfl⟩).measurable.aemeasurable
      (textbookWienerVectorContinuousPath_aemeasurable B P hB T)]
  apply Measure.map_congr
  filter_upwards [textbookLangevinGlobalRandomPhase_history_endpoint_ae B P hB U hU L hF γ σ x] with sample hs
  exact (hs T T.property).symm

/-- Actual transition laws do not depend on the probability-space realization of a standard vector Wiener process. -/
theorem textbookLangevinTransitionKernel_wiener_law_invariant {Nc : ℕ} {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (C : ℝ≥0 → Ω' → (Fin Nc → ℝ)) (Q : Measure Ω') (hC : textbookIsWienerVector C Q)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) :
    textbookLangevinTransitionKernel B P U hU L hF γ σ T =
      textbookLangevinTransitionKernel C Q U hU L hF γ σ T := by
  unfold textbookLangevinTransitionKernel
  rw [textbookWienerVectorContinuousPath_law_eq B P hB C Q hC T T.property]


/-- Disintegration of an endpoint driven by an independent noise law; used only for the actual Langevin kernels. -/
private theorem textbookLangevinEndpoint_product_disintegration
    {H X W : Type*} [MeasurableSpace H] [MeasurableSpace X] [MeasurableSpace W]
    (ν : Measure H) (μ : Measure W) [SFinite ν] [SFinite μ]
    (e : H → X) (he : Measurable e) (f : X × W → X) (hf : Measurable f)
    (κ : Kernel X X) [IsSFiniteKernel κ]
    (hκ : ∀ x, κ x = μ.map (fun w ↦ f (x, w))) :
    (ν.prod μ).map (fun z : H × W ↦ (z.1, f (e z.1, z.2))) =
      ν ⊗ₘ κ.comap e he := by
  have hg : Measurable (fun z : H × W ↦ (z.1, f (e z.1, z.2))) :=
    measurable_fst.prodMk (hf.comp ((he.comp measurable_fst).prodMk measurable_snd))
  ext a ha
  rw [Measure.map_apply hg ha, Measure.prod_apply (hg ha), Measure.compProd_apply ha]
  apply lintegral_congr
  intro h
  have mf : Measurable (fun w : W ↦ f (e h, w)) := hf.comp (measurable_const.prodMk measurable_id)
  rw [Kernel.comap_apply, hκ, Measure.map_apply mf (ha.preimage measurable_prodMk_left)]
  rfl

/-- The actual future endpoint and entire actual past have the joint law of the genuine transition kernel. -/
theorem textbookLangevinGlobalRandomPhase_history_transition_joint_law
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S T : ℝ≥0) :
    P.map (fun sample ↦
      ((fun t : Icc (0 : ℝ) S ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample),
        textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) =
      (P.map (fun sample (t : Icc (0 : ℝ) S) ↦
        textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample)) ⊗ₘ
      (textbookLangevinTransitionKernel B P U hU L hF γ σ T).comap
        (fun h : Icc (0 : ℝ) S → textbookLangevinPhase Nc ↦ h ⟨S, S.property, le_rfl⟩)
        (measurable_pi_apply _) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinTransitionKernel B P U hU L hF γ σ T) :=
    textbookLangevinTransitionKernel_isMarkov B P hB U hU L hF γ σ T
  let H : Ω → (Icc (0 : ℝ) S → textbookLangevinPhase Nc) :=
    fun sample t ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample
  let F := textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T
  let e : (Icc (0 : ℝ) S → textbookLangevinPhase Nc) → textbookLangevinPhase Nc :=
    fun h ↦ h ⟨S, S.property, le_rfl⟩
  let E : textbookLangevinPhase Nc × C(Icc (0 : ℝ) T, Fin Nc → ℝ) → textbookLangevinPhase Nc :=
    fun z ↦ textbookLangevinPathEndpoint U L hF γ σ T T.property z.1 T z.2
  have mH : AEMeasurable H P :=
    textbookLangevinGlobalRandomPhase_history_aemeasurable B P hB U hU L hF γ σ x S
  have mF : AEMeasurable F P := textbookWienerVectorContinuousPath_aemeasurable _ P
    (textbookWienerVectorFuture_isWiener B P hB S) T
  have me : Measurable e := measurable_pi_apply _
  have mE : Measurable E := textbookLangevinPathEndpoint_joint_measurable U hU L hF γ σ
    T T.property T ⟨T.property, le_rfl⟩
  have hj : P.map (fun sample ↦ (H sample, F sample)) =
      (P.map H).prod (P.map (textbookWienerVectorContinuousPath B T)) := by
    have hi := (indepFun_iff_map_prod_eq_prod_map_map mH mF).mp
      (textbookLangevinGlobalRandomPhase_future_independent_history B P hB U hU L hF γ σ x S T).symm
    rw [textbookWienerVectorFuture_continuousPath_law B P hB S T T.property] at hi
    exact hi
  let G : (Icc (0 : ℝ) S → textbookLangevinPhase Nc) × C(Icc (0 : ℝ) T, Fin Nc → ℝ) →
      (Icc (0 : ℝ) S → textbookLangevinPhase Nc) × textbookLangevinPhase Nc :=
    fun z ↦ (z.1, E (e z.1, z.2))
  have mG : Measurable G := measurable_fst.prodMk (mE.comp ((me.comp measurable_fst).prodMk measurable_snd))
  have hr : P.map (fun sample ↦ (H sample,
      textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) =
      (P.map (fun sample ↦ (H sample, F sample))).map G := by
    rw [AEMeasurable.map_map_of_aemeasurable mG.aemeasurable (mH.prodMk mF)]
    apply Measure.map_congr
    filter_upwards [textbookLangevinGlobalRandomPhase_future_restart_ae B P hB U hU L hF γ σ x] with sample hs
    exact Prod.ext rfl (hs S T T.property T ⟨T.property, le_rfl⟩)
  rw [hr, hj]
  exact textbookLangevinEndpoint_product_disintegration (P.map H)
    (P.map (textbookWienerVectorContinuousPath B T)) e me E mE
    (textbookLangevinTransitionKernel B P U hU L hF γ σ T)
    (textbookLangevinTransitionKernel_apply B P hB U hU L hF γ σ T)

/-- At every deterministic restart time, the actual conditional future law given the entire past depends only on the actual current state. -/
theorem textbookLangevinGlobalRandomPhase_condDistrib_history
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S T : ℝ≥0) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    ∀ᵐ sample ∂P,
      condDistrib (textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T))
        (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample)
        P (fun t : Icc (0 : ℝ) S ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) =
      textbookLangevinTransitionKernel B P U hU L hF γ σ T
        (textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinTransitionKernel B P U hU L hF γ σ T) :=
    textbookLangevinTransitionKernel_isMarkov B P hB U hU L hF γ σ T
  have mH := textbookLangevinGlobalRandomPhase_history_aemeasurable B P hB U hU L hF γ σ x S
  have hc := condDistrib_ae_eq_of_measure_eq_compProd mH
    (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U hU L hF γ σ x
      ((S : ℝ) + T) (add_nonneg S.property T.property))
    (textbookLangevinGlobalRandomPhase_history_transition_joint_law B P hB U hU L hF γ σ x S T)
  exact ae_of_ae_map mH hc
/-- The true transition kernel: integrate the actual endpoint against the genuine Wiener path law. -/
noncomputable def textbookLangevinPeriodicTransitionKernel {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) :
    Kernel (textbookLangevinPeriodicPhase Nc) (textbookLangevinPeriodicPhase Nc) :=
  (Kernel.deterministic
    (fun z : textbookLangevinPeriodicPhase Nc × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property z.1 T z.2)
    (textbookLangevinPeriodicPathEndpoint_joint_measurable U hU hP L hF γ σ T T.property T ⟨T.property, le_rfl⟩)) ∘ₖ
      (Kernel.id ×ₖ Kernel.const (textbookLangevinPeriodicPhase Nc)
        (P.map (textbookWienerVectorContinuousPath B T)))

/-- The actual transition kernel is a probability kernel, derived from the genuine Wiener law. -/
theorem textbookLangevinPeriodicTransitionKernel_isMarkov {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) :
    IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookLangevinPeriodicTransitionKernel
  infer_instance

/-- Each actual transition measure is literally the actual endpoint pushforward of the true Wiener path law. -/
theorem textbookLangevinPeriodicTransitionKernel_apply {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase Nc) :
    textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T x =
      (P.map (textbookWienerVectorContinuousPath B T)).map
        (textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property x T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookLangevinPeriodicTransitionKernel
  rw [Kernel.deterministic_comp_eq_map, Kernel.map_apply, Kernel.prod_apply,
    Kernel.id_apply, Kernel.const_apply, Measure.dirac_prod, Measure.map_map]
  all_goals first
    | exact textbookLangevinPeriodicPathEndpoint_joint_measurable U hU hP L hF γ σ T T.property T ⟨T.property, le_rfl⟩
    | exact measurable_prodMk_left
    | rfl

/-- The transition measure is the law of the same genuine all-time process at the stated time. -/
theorem textbookLangevinPeriodicTransitionKernel_global_law {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase Nc) :
    textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T x =
      P.map (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T) := by
  have mE : Measurable (textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property x T) := by
    have mp : Measurable (fun W : C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦ (x, W)) :=
      measurable_const.prodMk measurable_id
    have hm := (textbookLangevinPeriodicPathEndpoint_joint_measurable U hU hP L hF γ σ T T.property T
      ⟨T.property, le_rfl⟩).comp mp
    exact hm
  rw [textbookLangevinPeriodicTransitionKernel_apply B P hB U hU hP L hF γ σ T x,
    AEMeasurable.map_map_of_aemeasurable mE.aemeasurable
      (textbookWienerVectorContinuousPath_aemeasurable B P hB T)]
  apply Measure.map_congr
  filter_upwards [textbookLangevinPeriodicGlobalRandomPhase_history_endpoint_ae B P hB U (hU.of_le (by simp)) L hF γ σ x] with sample hs
  exact (hs T T.property).symm

/-- Actual transition laws do not depend on the probability-space realization of a standard vector Wiener process. -/
theorem textbookLangevinPeriodicTransitionKernel_wiener_law_invariant {Nc : ℕ} {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (C : ℝ≥0 → Ω' → (Fin Nc → ℝ)) (Q : Measure Ω') (hC : textbookIsWienerVector C Q)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) :
    textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T =
      textbookLangevinPeriodicTransitionKernel C Q U hU hP L hF γ σ T := by
  unfold textbookLangevinPeriodicTransitionKernel
  rw [textbookWienerVectorContinuousPath_law_eq B P hB C Q hC T T.property]


/-- The actual periodic history is jointly AE measurable without a measurable representative assumption. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_history_aemeasurable
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S : ℝ≥0) :
    AEMeasurable (fun sample (t : Icc (0 : ℝ) S) ↦
      textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) P := by
  have mh : Measurable (fun f : Icc (0 : ℝ) S → textbookLangevinPhase Nc ↦
      fun t ↦ textbookLangevinPeriodicProjection (f t)) :=
    .of_eval (fun t ↦ (textbookLangevinPeriodicProjection_continuous Nc).measurable.comp (measurable_pi_apply t))
  exact mh.comp_aemeasurable (textbookLangevinGlobalRandomPhase_history_aemeasurable B P hB U hU L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2) S)

/-- The same actual periodic process restarts with the genuine future Wiener path. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_future_restart_ae
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    ∀ᵐ sample ∂P, ∀ S : ℝ≥0, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B (S + t) sample =
        textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT
          (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample) t
          (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample) := by
  filter_upwards [textbookLangevinPeriodicGlobalRandomPhase_restart_ae B P hB U hU hP L hF γ σ x,
    textbookWienerVectorFuture_segment_ae B P hB] with sample hr hs
  intro S T hT t ht
  simpa only [hs S T hT] using hr S S.property T hT t ht
/-- The actual future endpoint and entire actual past have the joint law of the genuine transition kernel. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_history_transition_joint_law
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S T : ℝ≥0) :
    P.map (fun sample ↦
      ((fun t : Icc (0 : ℝ) S ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample),
        textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) =
      (P.map (fun sample (t : Icc (0 : ℝ) S) ↦
        textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample)) ⊗ₘ
      (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T).comap
        (fun h : Icc (0 : ℝ) S → textbookLangevinPeriodicPhase Nc ↦ h ⟨S, S.property, le_rfl⟩)
        (measurable_pi_apply _) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hP L hF γ σ T
  let H : Ω → (Icc (0 : ℝ) S → textbookLangevinPeriodicPhase Nc) :=
    fun sample t ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample
  let F := textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T
  let e : (Icc (0 : ℝ) S → textbookLangevinPeriodicPhase Nc) → textbookLangevinPeriodicPhase Nc :=
    fun h ↦ h ⟨S, S.property, le_rfl⟩
  let E : textbookLangevinPeriodicPhase Nc × C(Icc (0 : ℝ) T, Fin Nc → ℝ) → textbookLangevinPeriodicPhase Nc :=
    fun z ↦ textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property z.1 T z.2
  have mH : AEMeasurable H P :=
    textbookLangevinPeriodicGlobalRandomPhase_history_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ x S
  have mF : AEMeasurable F P := textbookWienerVectorContinuousPath_aemeasurable _ P
    (textbookWienerVectorFuture_isWiener B P hB S) T
  have me : Measurable e := measurable_pi_apply _
  have mE : Measurable E := textbookLangevinPeriodicPathEndpoint_joint_measurable U hU hP L hF γ σ
    T T.property T ⟨T.property, le_rfl⟩
  have hj : P.map (fun sample ↦ (H sample, F sample)) =
      (P.map H).prod (P.map (textbookWienerVectorContinuousPath B T)) := by
    have hi := (indepFun_iff_map_prod_eq_prod_map_map mH mF).mp
      (textbookLangevinPeriodicGlobalRandomPhase_future_independent_history B P hB U (hU.of_le (by simp)) L hF γ σ x S T).symm
    rw [textbookWienerVectorFuture_continuousPath_law B P hB S T T.property] at hi
    exact hi
  let G : (Icc (0 : ℝ) S → textbookLangevinPeriodicPhase Nc) × C(Icc (0 : ℝ) T, Fin Nc → ℝ) →
      (Icc (0 : ℝ) S → textbookLangevinPeriodicPhase Nc) × textbookLangevinPeriodicPhase Nc :=
    fun z ↦ (z.1, E (e z.1, z.2))
  have mG : Measurable G := measurable_fst.prodMk (mE.comp ((me.comp measurable_fst).prodMk measurable_snd))
  have hr : P.map (fun sample ↦ (H sample,
      textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) =
      (P.map (fun sample ↦ (H sample, F sample))).map G := by
    rw [AEMeasurable.map_map_of_aemeasurable mG.aemeasurable (mH.prodMk mF)]
    apply Measure.map_congr
    filter_upwards [textbookLangevinPeriodicGlobalRandomPhase_future_restart_ae B P hB U hU hP L hF γ σ x] with sample hs
    exact Prod.ext rfl (hs S T T.property T ⟨T.property, le_rfl⟩)
  rw [hr, hj]
  exact textbookLangevinEndpoint_product_disintegration (P.map H)
    (P.map (textbookWienerVectorContinuousPath B T)) e me E mE
    (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T)
    (textbookLangevinPeriodicTransitionKernel_apply B P hB U hU hP L hF γ σ T)

/-- At every deterministic restart time, the actual conditional future law given the entire past depends only on the actual current state. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_condDistrib_history
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S T : ℝ≥0) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    ∀ᵐ sample ∂P,
      condDistrib (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T))
        (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample)
        P (fun t : Icc (0 : ℝ) S ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) =
      textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hP L hF γ σ T
  have mH := textbookLangevinPeriodicGlobalRandomPhase_history_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ x S
  have hc := condDistrib_ae_eq_of_measure_eq_compProd mH
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ x
      ((S : ℝ) + T) (add_nonneg S.property T.property))
    (textbookLangevinPeriodicGlobalRandomPhase_history_transition_joint_law B P hB U hU hP L hF γ σ x S T)
  exact ae_of_ae_map mH hc

/-- For the textbook's smooth lattice-periodic potential, force Lipschitz regularity and the actual deterministic-time Markov law are derived together. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_condDistrib_history_of_periodic
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)), ∀ S T : ℝ≥0,
      ∀ᵐ sample ∂P,
        condDistrib (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T))
          (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample)
          P (fun t : Icc (0 : ℝ) S ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) =
        textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T
          (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample) := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  exact ⟨L, hF, fun S T ↦ textbookLangevinPeriodicGlobalRandomPhase_condDistrib_history
    B P hB U hU hP L hF γ σ x S T⟩
end MolecularDynamics