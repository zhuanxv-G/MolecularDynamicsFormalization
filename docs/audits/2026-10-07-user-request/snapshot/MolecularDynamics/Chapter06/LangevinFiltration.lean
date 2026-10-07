import MolecularDynamics.Chapter06.LangevinTransitionSemigroup
import Mathlib.Probability.Process.Adapted

/-! The completed noise filtration of the same actual Langevin model.
Necessary adapted-model dependencies of Theorem 6.2, printed 252 / PDF 273. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- Actual vector Wiener evaluations are measurable on the completion of the original probability space. -/
theorem textbookWienerVector_completed_measurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (t : ℝ≥0) :
    @Measurable (NullMeasurableSpace Ω P) (Fin Nc → ℝ) inferInstance inferInstance (B t) := by
  have hm : AEMeasurable (B t) P := .of_eval (fun i ↦ hB.gaussian.aemeasurable ⟨i, t⟩)
  exact hm.nullMeasurable.measurable'

/-- The actual Wiener history filtration, augmented by every original null set, on the completed ambient space. -/
def textbookWienerVectorCompletedFiltration {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    Filtration ℝ≥0 (inferInstance : MeasurableSpace (NullMeasurableSpace Ω P)) where
  seq S := (⨆ t : ℝ≥0, ⨆ (_ : t ≤ S),
      (inferInstance : MeasurableSpace (Fin Nc → ℝ)).comap (B t)) ⊔
    MeasurableSpace.generateFrom {a : Set Ω | P a = 0}
  mono' S T hST := sup_le_sup (biSup_mono (fun _ ht ↦ ht.trans hST)) le_rfl
  le' S := by
    apply sup_le
    · exact iSup₂_le (fun t _ ↦ (textbookWienerVector_completed_measurable B P hB t).comap_le)
    · exact MeasurableSpace.generateFrom_le (fun a ha ↦ NullMeasurableSet.of_null ha)

/-- Every original null subset is measurable at every time of the actual completed filtration. -/
theorem textbookWienerVectorCompletedFiltration_null_measurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) (a : Set Ω) (ha : P a = 0) :
    MeasurableSet[textbookWienerVectorCompletedFiltration B P hB S] a := by
  have hle : MeasurableSpace.generateFrom {a : Set Ω | P a = 0} ≤
      textbookWienerVectorCompletedFiltration B P hB S := le_sup_right
  exact hle a (MeasurableSpace.measurableSet_generateFrom ha)

/-- Each actual past evaluation is measurable in the completed history at S. -/
theorem textbookWienerVectorCompletedFiltration_eval_measurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S t : ℝ≥0) (ht : t ≤ S) :
    Measurable[textbookWienerVectorCompletedFiltration B P hB S] (B t) := by
  apply Measurable.of_comap_le
  have hle : (inferInstance : MeasurableSpace (Fin Nc → ℝ)).comap (B t) ≤
      ⨆ u : ℝ≥0, ⨆ (_ : u ≤ S), (inferInstance : MeasurableSpace (Fin Nc → ℝ)).comap (B u) :=
    le_iSup_of_le t (le_iSup_of_le ht le_rfl)
  exact hle.trans le_sup_left

/-- The original completed probability measure trimmed to any time history is complete. -/
theorem textbookWienerVectorCompletedFiltration_trim_complete {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    (P.completion.trim ((textbookWienerVectorCompletedFiltration B P hB).le S)).IsComplete := by
  constructor
  intro a ha
  have hz : P.completion a = 0 := measure_eq_zero_of_trim_eq_zero (μ := P.completion)
    ((textbookWienerVectorCompletedFiltration B P hB).le S) ha
  exact textbookWienerVectorCompletedFiltration_null_measurable B P hB S a hz

/-- Trimming to the augmented actual past preserves the entire original almost-everywhere filter. -/
theorem textbookWienerVectorCompletedFiltration_trim_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    ae (P.completion.trim ((textbookWienerVectorCompletedFiltration B P hB).le S)) = ae P := by
  apply Filter.ext
  intro a
  change (P.completion.trim ((textbookWienerVectorCompletedFiltration B P hB).le S)) aᶜ = 0 ↔ P aᶜ = 0
  constructor
  · exact measure_eq_zero_of_trim_eq_zero (μ := P.completion) _
  · intro ha
    have heq := trim_measurableSet_eq (μ := P.completion)
      ((textbookWienerVectorCompletedFiltration B P hB).le S)
      (textbookWienerVectorCompletedFiltration_null_measurable B P hB S aᶜ ha)
    exact heq.trans ha


/-- The actual local completed history permits AE changes without changing the process. -/
private theorem textbookWienerVectorCompletedFiltration_measurable_congr
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

/-- The actual finite continuous Wiener path is measurable using only the completed noise history at its horizon. -/
theorem textbookWienerVectorContinuousPath_filtration_measurable
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) :
    Measurable[textbookWienerVectorCompletedFiltration B P hB S]
      (textbookWienerVectorContinuousPath B S) := by
  have heval (t : Icc (0 : ℝ) S) :
      Measurable[textbookWienerVectorCompletedFiltration B P hB S]
        (fun sample ↦ textbookWienerVectorContinuousPath B S sample t) := by
    apply textbookWienerVectorCompletedFiltration_measurable_congr B P hB S
      (textbookWienerVectorCompletedFiltration_eval_measurable B P hB S
        ⟨t.1, t.2.1⟩ (by exact_mod_cast t.2.2))
    filter_upwards [hB.cont] with sample hc
    exact (textbookWienerVectorContinuousPath_eval B S sample hc t).symm
  exact (@ContinuousMap.measurable_iff_eval (Icc (0 : ℝ) S) (Fin Nc → ℝ)
    _ _ _ _ _ _ _ _ Ω (textbookWienerVectorCompletedFiltration B P hB S)
    (textbookWienerVectorContinuousPath B S)).mpr heval
/-- The same actual Wiener process is adapted to its completed noise-history filtration. -/
theorem textbookWienerVectorCompletedFiltration_adapted {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    Adapted (textbookWienerVectorCompletedFiltration B P hB) B :=
  fun S ↦ textbookWienerVectorCompletedFiltration_eval_measurable B P hB S S le_rfl

/-- The same actual all-time real Langevin process is adapted, not merely AE measurable. -/
theorem textbookLangevinGlobalRandomPhase_adapted {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    Adapted (textbookWienerVectorCompletedFiltration B P hB)
      (fun S : ℝ≥0 ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B S) := by
  intro S
  have mh : Measurable[textbookWienerVectorCompletedFiltration B P hB S]
      (fun sample ↦ textbookLangevinPathEndpoint U L hF γ σ S S.property x S
        (textbookWienerVectorContinuousPath B S sample)) :=
    (textbookLangevinPathEndpoint_continuous U hU L hF γ σ S S.property x S
      ⟨S.property, le_rfl⟩).measurable.comp
      (textbookWienerVectorContinuousPath_filtration_measurable B P hB S)
  apply textbookWienerVectorCompletedFiltration_measurable_congr B P hB S mh
  filter_upwards [textbookLangevinGlobalRandomPhase_history_endpoint_ae B P hB U hU L hF γ σ x] with sample hs
  exact (hs S S.property).symm

/-- The actual periodic all-time process is adapted to the same completed Wiener history. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_adapted {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    Adapted (textbookWienerVectorCompletedFiltration B P hB)
      (fun S : ℝ≥0 ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S) := by
  intro S
  exact (textbookLangevinPeriodicProjection_continuous Nc).measurable.comp
    (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) S)

/-- The original smooth periodic potential produces an adapted actual process without a force regularity conclusion as an input. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_adapted_of_periodic
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
      Adapted (textbookWienerVectorCompletedFiltration B P hB)
        (fun S : ℝ≥0 ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S) := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  exact ⟨L, hF, textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U
    (hU.of_le (by simp)) L hF γ σ x⟩
end MolecularDynamics
