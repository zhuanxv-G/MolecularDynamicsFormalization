import MolecularDynamics.Chapter06.LangevinFiltration

/-! Actual future independence from the null-augmented Wiener history.
Necessary completed-Markov-model dependencies of Theorem 6.2, printed 252 / PDF 273. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- The actual completed noise history has no additional positive-probability events beyond the actual continuous history. -/
theorem textbookWienerVectorCompletedFiltration_le_eventual_path {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    textbookWienerVectorCompletedFiltration B P hB S ≤
      eventuallyMeasurableSpace
        ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) S, Fin Nc → ℝ)).comap
          (textbookWienerVectorContinuousPath B S)) (ae P) := by
  apply sup_le
  · apply iSup₂_le
    intro t ht
    let r : Icc (0 : ℝ) S := ⟨t, t.property, by exact_mod_cast ht⟩
    have he : (B t) =ᵐ[P] (fun sample ↦ textbookWienerVectorContinuousPath B S sample r) := by
      filter_upwards [hB.cont] with sample hc
      exact (textbookWienerVectorContinuousPath_eval B S sample hc r).symm
    intro a ha
    rcases ha with ⟨c, hc, rfl⟩
    refine ⟨(fun sample ↦ textbookWienerVectorContinuousPath B S sample r) ⁻¹' c, ?_, he.preimage c⟩
    exact ⟨(fun W : C(Icc (0 : ℝ) S, Fin Nc → ℝ) ↦ W r) ⁻¹' c,
      (ContinuousMap.measurable_eval r) hc, rfl⟩
  · apply MeasurableSpace.generateFrom_le
    intro a ha
    refine ⟨∅, @MeasurableSet.empty Ω
      ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) S, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath B S)), ?_⟩
    exact ae_eq_empty.mpr ha

/-- Every completed past event is genuinely AE equal to a measurable continuous-path-history event. -/
theorem textbookWienerVectorCompletedFiltration_event_ae_path {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) (a : Set Ω) (ha : MeasurableSet[textbookWienerVectorCompletedFiltration B P hB S] a) :
    ∃ c : Set Ω, MeasurableSet[(inferInstance : MeasurableSpace C(Icc (0 : ℝ) S, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath B S)] c ∧ a =ᵐ[P] c :=
  textbookWienerVectorCompletedFiltration_le_eventual_path B P hB S a ha

/-- The actual future continuous noise is independent of the entire null-augmented Wiener history. -/
theorem textbookWienerVectorFuture_independent_completed_filtration
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion := by
  apply (Indep_iff _ _ _).mpr
  intro d a hd ha
  obtain ⟨c, hc, he⟩ := textbookWienerVectorCompletedFiltration_event_ae_path B P hB S a ha
  have hi := textbookWienerVectorFuture_continuousPath_independent_history B P hB S T
  have hi' := hi.meas_inter hd hc
  change P (d ∩ a) = P d * P a
  calc
    P (d ∩ a) = P (d ∩ c) := measure_congr (Filter.EventuallyEqSet.inter (.rfl) he)
    _ = P d * P c := hi'
    _ = P d * P a := by rw [measure_congr he]


/-- Completion preserves the genuine continuous Wiener history law, with actual measurable paths. -/
theorem textbookWienerVectorContinuousPath_completion_law {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    @Measure.map (NullMeasurableSpace Ω P) C(Icc 0 T, Fin Nc → ℝ) inferInstance inferInstance
      (textbookWienerVectorContinuousPath B T) P.completion =
      P.map (textbookWienerVectorContinuousPath B T) := by
  have hm := textbookWienerVectorContinuousPath_aemeasurable B P hB T
  ext a ha
  rw [Measure.map_apply hm.nullMeasurable.measurable' ha,
    Measure.map_apply_of_aemeasurable hm ha]
  rfl

/-- The actual future noise is independent of the same actual real present state on the completed probability space. -/
theorem textbookLangevinGlobalRandomPhase_future_independent_current_completed
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S : ℝ≥0) (T : ℝ) :
    IndepFun (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T)
      (textbookLangevinGlobalRandomPhase U L hF γ σ x B S) P.completion := by
  apply (IndepFun_iff_Indep _ _ _).mpr
  apply indep_of_indep_of_le_right
    (textbookWienerVectorFuture_independent_completed_filtration B P hB S T)
  exact @Measurable.comap_le Ω (textbookLangevinPhase Nc) _ _ _
    (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x S)

/-- The same actual future independence holds for the present torus state on the completed probability space. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_future_independent_current_completed
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S : ℝ≥0) (T : ℝ) :
    IndepFun (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T)
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S) P.completion := by
  apply (IndepFun_iff_Indep _ _ _).mpr
  apply indep_of_indep_of_le_right
    (textbookWienerVectorFuture_independent_completed_filtration B P hB S T)
  exact @Measurable.comap_le Ω (textbookLangevinPeriodicPhase Nc) _ _ _
    (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U hU L hF γ σ x S)

/-- The actual future-noise / actual present joint law on the completed space is the original Wiener law times the actual present law. -/
theorem textbookLangevinGlobalRandomPhase_future_current_product_law_completed
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S : ℝ≥0) (T : ℝ) (hT : 0 ≤ T) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample,
        textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample)) P.completion =
      (P.map (textbookWienerVectorContinuousPath B T)).prod
        (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
          (textbookLangevinGlobalRandomPhase U L hF γ σ x B S) P.completion) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc 0 T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  have mx := (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x).measurable (i := S)
  have he := (indepFun_iff_map_prod_eq_prod_map_map mf.aemeasurable mx.aemeasurable).mp
    (textbookLangevinGlobalRandomPhase_future_independent_current_completed B P hB U hU L hF γ σ x S T)
  rw [textbookWienerVectorContinuousPath_completion_law _ P
    (textbookWienerVectorFuture_isWiener B P hB S) T,
    textbookWienerVectorFuture_continuousPath_law B P hB S T hT] at he
  exact he
/-- The actual future-noise / actual present joint law on the completed space is the original Wiener law times the actual present law. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_future_current_product_law_completed
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S : ℝ≥0) (T : ℝ) (hT : 0 ≤ T) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample,
        textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample)) P.completion =
      (P.map (textbookWienerVectorContinuousPath B T)).prod
        (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
          (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S) P.completion) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc 0 T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  have mx := (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U hU L hF γ σ x).measurable (i := S)
  have he := (indepFun_iff_map_prod_eq_prod_map_map mf.aemeasurable mx.aemeasurable).mp
    (textbookLangevinPeriodicGlobalRandomPhase_future_independent_current_completed B P hB U hU L hF γ σ x S T)
  rw [textbookWienerVectorContinuousPath_completion_law _ P
    (textbookWienerVectorFuture_isWiener B P hB S) T,
    textbookWienerVectorFuture_continuousPath_law B P hB S T hT] at he
  exact he

end MolecularDynamics
