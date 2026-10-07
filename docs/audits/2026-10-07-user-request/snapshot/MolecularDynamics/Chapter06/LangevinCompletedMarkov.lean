import MolecularDynamics.Chapter06.LangevinCompletedHistory

/-! Deterministic-time Markov laws for the same actual process given the actual
completed Wiener filtration. Necessary dependency of Theorem 6.2,
printed 252 / PDF 273. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics

/-- The same samples, with precisely the actual completed history measurable space. -/
def textbookWienerVectorCompletedHistorySpace {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (_B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (_P : Measure Ω)
    (_hB : textbookIsWienerVector _B _P) (_S : ℝ≥0) := Ω

instance {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    MeasurableSpace (textbookWienerVectorCompletedHistorySpace B P hB S) :=
  textbookWienerVectorCompletedFiltration B P hB S

/-- The actual completed-history observation retains the sample and forgets only future measurability. -/
def textbookWienerVectorCompletedHistoryObservation {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    NullMeasurableSpace Ω P → textbookWienerVectorCompletedHistorySpace B P hB S := id

/-- The actual sample-identity observation is measurable into the completed past. -/
theorem textbookWienerVectorCompletedHistoryObservation_measurable
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    Measurable (textbookWienerVectorCompletedHistoryObservation B P hB S) := by
  intro a ha
  exact (textbookWienerVectorCompletedFiltration B P hB).le S a ha

/-- The actual future noise and the entire completed history have the genuine product law. -/
theorem textbookWienerVectorFuture_completed_history_product_law
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (S T : ℝ≥0) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample))
      P.completion =
    (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion).prod
      (P.map (textbookWienerVectorContinuousPath B T)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have mh := textbookWienerVectorCompletedHistoryObservation_measurable B P hB S
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc (0 : ℝ) T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  have hi : IndepFun (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T)
      (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion := by
    apply (IndepFun_iff_Indep _ _ _).mpr
    apply indep_of_indep_of_le_right
      (textbookWienerVectorFuture_independent_completed_filtration B P hB S T)
    intro a ha
    rcases ha with ⟨c, hc, rfl⟩
    exact hc
  have hj := (indepFun_iff_map_prod_eq_prod_map_map mh.aemeasurable mf.aemeasurable).mp hi.symm
  rw [textbookWienerVectorContinuousPath_completion_law _ P
    (textbookWienerVectorFuture_isWiener B P hB S) T,
    textbookWienerVectorFuture_continuousPath_law B P hB S T T.property] at hj
  exact hj

private theorem completedLangevin_endpoint_joint_law
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


/-- The same actual future endpoint and the entire completed past have the actual transition disintegration. -/
theorem textbookLangevinGlobalRandomPhase_completed_history_transition_joint_law
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S T : ℝ≥0) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) P.completion =
    (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ
      (textbookLangevinTransitionKernel B P U hU L hF γ σ T).comap
        (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
          textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample)
        (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookLangevinTransitionKernel B P U hU L hF γ σ T) :=
    textbookLangevinTransitionKernel_isMarkov B P hB U hU L hF γ σ T
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc (0 : ℝ) T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  apply completedLangevin_endpoint_joint_law P.completion
    (P.map (textbookWienerVectorContinuousPath B T))
    (textbookWienerVectorCompletedHistoryObservation B P hB S)
    (textbookWienerVectorCompletedHistoryObservation_measurable B P hB S)
    _ mf _ (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x S)
    (fun z : textbookLangevinPhase Nc × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookLangevinPathEndpoint U L hF γ σ T T.property z.1 T z.2)
    (textbookLangevinPathEndpoint_joint_measurable U hU L hF γ σ
      T T.property T ⟨T.property, le_rfl⟩)
  · exact textbookWienerVectorFuture_completed_history_product_law B P hB S T
  · rw [Measure.ae_completion]
    filter_upwards [textbookLangevinGlobalRandomPhase_future_restart_ae B P hB U hU L hF γ σ x]
      with sample hs
    exact hs S T T.property T ⟨T.property, le_rfl⟩
  · exact textbookLangevinTransitionKernel_apply B P hB U hU L hF γ σ T

/-- Given the actual completed Wiener past, the same actual future-state law depends only on the current state. -/
theorem textbookLangevinGlobalRandomPhase_condDistrib_completed_history
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S T : ℝ≥0) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    letI : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
    ∀ᵐ sample ∂P.completion,
      @condDistrib (NullMeasurableSpace Ω P)
        (textbookWienerVectorCompletedHistorySpace B P hB S) (textbookLangevinPhase Nc)
        inferInstance inferInstance inferInstance inferInstance inferInstance
        (textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T))
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S sample) =
      textbookLangevinTransitionKernel B P U hU L hF γ σ T
        (textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookLangevinTransitionKernel B P U hU L hF γ σ T) :=
    textbookLangevinTransitionKernel_isMarkov B P hB U hU L hF γ σ T
  have mh := textbookWienerVectorCompletedHistoryObservation_measurable B P hB S
  have my := (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x).measurable
    (i := S + T)
  let κ : Kernel (textbookWienerVectorCompletedHistorySpace B P hB S) (textbookLangevinPhase Nc) :=
    (textbookLangevinTransitionKernel B P U hU L hF γ σ T).comap
      (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
        textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample)
      (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x S)
  have : IsMarkovKernel κ := by
    refine ⟨fun sample ↦ ⟨?_⟩⟩
    change (textbookLangevinTransitionKernel B P U hU L hF γ σ T
      (textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample)) univ = 1
    exact measure_univ
  have hj : @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (fun sample ↦ (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) P.completion =
      (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ κ :=
    textbookLangevinGlobalRandomPhase_completed_history_transition_joint_law B P hB U hU L hF γ σ x S T
  have hc := condDistrib_ae_eq_of_measure_eq_compProd (κ := κ)
    mh.aemeasurable my.aemeasurable hj
  exact ae_of_ae_map mh.aemeasurable hc

/-- The same actual future endpoint and the entire completed past have the actual transition disintegration. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_completed_history_transition_joint_law
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S T : ℝ≥0) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) P.completion =
    (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ
      (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T).comap
        (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
          textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample)
        (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U (hU.of_le (by simp)) L hF γ σ x S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hP L hF γ σ T
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc (0 : ℝ) T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  apply completedLangevin_endpoint_joint_law P.completion
    (P.map (textbookWienerVectorContinuousPath B T))
    (textbookWienerVectorCompletedHistoryObservation B P hB S)
    (textbookWienerVectorCompletedHistoryObservation_measurable B P hB S)
    _ mf _ (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U (hU.of_le (by simp)) L hF γ σ x S)
    (fun z : textbookLangevinPeriodicPhase Nc × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property z.1 T z.2)
    (textbookLangevinPeriodicPathEndpoint_joint_measurable U hU hP L hF γ σ
      T T.property T ⟨T.property, le_rfl⟩)
  · exact textbookWienerVectorFuture_completed_history_product_law B P hB S T
  · rw [Measure.ae_completion]
    filter_upwards [textbookLangevinPeriodicGlobalRandomPhase_future_restart_ae B P hB U hU hP L hF γ σ x]
      with sample hs
    exact hs S T T.property T ⟨T.property, le_rfl⟩
  · exact textbookLangevinPeriodicTransitionKernel_apply B P hB U hU hP L hF γ σ T

/-- Given the actual completed Wiener past, the same actual future-state law depends only on the current state. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_condDistrib_completed_history
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S T : ℝ≥0) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    letI : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
    ∀ᵐ sample ∂P.completion,
      @condDistrib (NullMeasurableSpace Ω P)
        (textbookWienerVectorCompletedHistorySpace B P hB S) (textbookLangevinPeriodicPhase Nc)
        inferInstance inferInstance inferInstance inferInstance inferInstance
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T))
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S sample) =
      textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hP L hF γ σ T
  have mh := textbookWienerVectorCompletedHistoryObservation_measurable B P hB S
  have my := (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U (hU.of_le (by simp)) L hF γ σ x).measurable
    (i := S + T)
  let κ : Kernel (textbookWienerVectorCompletedHistorySpace B P hB S) (textbookLangevinPeriodicPhase Nc) :=
    (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T).comap
      (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
        textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample)
      (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U (hU.of_le (by simp)) L hF γ σ x S)
  have : IsMarkovKernel κ := by
    refine ⟨fun sample ↦ ⟨?_⟩⟩
    change (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample)) univ = 1
    exact measure_univ
  have hj : @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (fun sample ↦ (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T) sample)) P.completion =
      (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ κ :=
    textbookLangevinPeriodicGlobalRandomPhase_completed_history_transition_joint_law B P hB U hU hP L hF γ σ x S T
  have hc := condDistrib_ae_eq_of_measure_eq_compProd (κ := κ)
    mh.aemeasurable my.aemeasurable hj
  exact ae_of_ae_map mh.aemeasurable hc


/-- The actual completed-history observation law is exactly the measure trimmed to that history. -/
theorem textbookWienerVectorCompletedHistoryObservation_law
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    @Measure.map (NullMeasurableSpace Ω P) (textbookWienerVectorCompletedHistorySpace B P hB S)
      inferInstance inferInstance (textbookWienerVectorCompletedHistoryObservation B P hB S)
      P.completion =
    P.completion.trim ((textbookWienerVectorCompletedFiltration B P hB).le S) := by
  exact (trim_eq_map ((textbookWienerVectorCompletedFiltration B P hB).le S)).symm

/-- The textbook smooth periodic potential yields the actual completed-filtration Markov law with derived force regularity. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_condDistrib_completed_history_of_periodic
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    letI : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)), ∀ S T : ℝ≥0,
      ∀ᵐ sample ∂P.completion,
        @condDistrib (NullMeasurableSpace Ω P)
          (textbookWienerVectorCompletedHistorySpace B P hB S) (textbookLangevinPeriodicPhase Nc)
          inferInstance inferInstance inferInstance inferInstance inferInstance
          (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T))
          (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion inferInstance
          (textbookWienerVectorCompletedHistoryObservation B P hB S sample) =
        textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T
          (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample) := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  exact ⟨L, hF, fun S T ↦
    textbookLangevinPeriodicGlobalRandomPhase_condDistrib_completed_history
      B P hB U hU hP L hF γ σ x S T⟩

end MolecularDynamics
