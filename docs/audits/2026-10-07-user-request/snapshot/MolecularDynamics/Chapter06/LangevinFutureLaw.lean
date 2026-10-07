import MolecularDynamics.Chapter06.WienerVectorFuture
import MolecularDynamics.Chapter06.LangevinPeriodicCausalFlow

/-! Actual future Wiener laws connected to the same all-time Langevin model.
Necessary dependencies for Theorem 6.2 (printed 252 / PDF 273).
Conditional Markov identities and completed filtrations remain separate goals. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- On one full-measure set every real finite future segment is literally the future Wiener path. -/
theorem textbookWienerVectorFuture_segment_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    ∀ᵐ sample ∂P, ∀ S : ℝ≥0, ∀ T : ℝ, ∀ hT : 0 ≤ T,
      textbookLangevinPathSegment (S + T) S T S.property hT le_rfl
        (textbookWienerVectorContinuousPath B (S + T) sample) =
      textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample := by
  filter_upwards [hB.cont] with sample hc
  intro S T hT
  have hf : Continuous (fun t ↦ textbookWienerVectorFuture B S t sample) :=
    (hc.comp (continuous_const.add continuous_id)).sub continuous_const
  apply ContinuousMap.ext
  intro t
  change textbookWienerVectorContinuousPath B (S + T) sample
      ⟨S + t.1, add_nonneg S.property t.2.1, add_le_add le_rfl t.2.2⟩ -
    textbookWienerVectorContinuousPath B (S + T) sample
      ⟨S, S.property, le_add_of_nonneg_right hT⟩ = _
  rw [textbookWienerVectorContinuousPath_eval B _ sample hc,
    textbookWienerVectorContinuousPath_eval B _ sample hc,
    textbookWienerVectorContinuousPath_eval _ T sample hf]
  rfl

/-- The same actual all-time real process restarts with the actual independent future Wiener path. -/
theorem textbookLangevinGlobalRandomPhase_future_restart_ae {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, ∀ S : ℝ≥0, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookLangevinGlobalRandomPhase U L hF γ σ x B (S + t) sample =
        textbookLangevinPathEndpoint U L hF γ σ T hT
          (textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample) t
          (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_restart_ae B P hB U hU L hF γ σ x,
    textbookWienerVectorFuture_segment_ae B P hB] with sample hr hs
  intro S T hT t ht
  simpa only [hs S T hT] using hr S S.property T hT t ht

/-- The actual entire solution history has joint AE measurability, derived from its noise history. -/
theorem textbookLangevinGlobalRandomPhase_history_aemeasurable {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S : ℝ≥0) :
    AEMeasurable (fun sample (t : Icc (0 : ℝ) S) ↦
      textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) P := by
  let e : C(Icc (0 : ℝ) S, Fin Nc → ℝ) → (Icc (0 : ℝ) S → textbookLangevinPhase Nc) :=
    fun W t ↦ textbookLangevinPathEndpoint U L hF γ σ S S.property x t W
  have me : Measurable e := .of_eval (fun t ↦
    (textbookLangevinPathEndpoint_continuous U hU L hF γ σ S S.property x t t.2).measurable)
  have he : (e ∘ textbookWienerVectorContinuousPath B S) =ᵐ[P]
      (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) := by
    filter_upwards [textbookLangevinGlobalRandomPhase_history_path_ae B P hB U hU L hF γ σ x] with sample hh
    exact funext (fun t ↦ (hh S S.property t t.2).symm)
  exact (me.comp_aemeasurable (textbookWienerVectorContinuousPath_aemeasurable B P hB S)).congr he

/-- The true continuous future noise is independent of the entire actual real Langevin history. -/
theorem textbookLangevinGlobalRandomPhase_future_independent_history {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S : ℝ≥0) (T : ℝ) :
    IndepFun (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T)
      (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) P := by
  let e : C(Icc (0 : ℝ) S, Fin Nc → ℝ) → (Icc (0 : ℝ) S → textbookLangevinPhase Nc) :=
    fun W t ↦ textbookLangevinPathEndpoint U L hF γ σ S S.property x t W
  have me : Measurable e := .of_eval (fun t ↦
    (textbookLangevinPathEndpoint_continuous U hU L hF γ σ S S.property x t t.2).measurable)
  have hi := (textbookWienerVectorFuture_continuousPath_independent_history B P hB S T).comp
    (φ := id) (ψ := e) measurable_id me
  apply hi.congr (.rfl)
  filter_upwards [textbookLangevinGlobalRandomPhase_history_path_ae B P hB U hU L hF γ σ x] with sample hh
  exact funext (fun t ↦ (hh S S.property t t.2).symm)

/-- The same true future noise is independent of the entire actual periodic Langevin history. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_future_independent_history {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S : ℝ≥0) (T : ℝ) :
    IndepFun (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T)
      (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) P := by
  have hi := textbookLangevinGlobalRandomPhase_future_independent_history B P hB U hU L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2) S T
  exact hi.comp (φ := id) (ψ := fun f t ↦ textbookLangevinPeriodicProjection (f t))
    measurable_id (.of_eval (fun t ↦ (textbookLangevinPeriodicProjection_continuous Nc).measurable.comp
      (measurable_pi_apply t)))

/-- The actual future-noise / actual solution-history joint law is the original-noise-law product. -/
theorem textbookLangevinGlobalRandomPhase_future_history_product_law {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S : ℝ≥0) (T : ℝ) (hT : 0 ≤ T) :
    P.map (fun sample ↦ (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample,
      fun t : Icc (0 : ℝ) S ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample)) =
      (P.map (textbookWienerVectorContinuousPath B T)).prod
        (P.map (fun sample (t : Icc (0 : ℝ) S) ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have he := (indepFun_iff_map_prod_eq_prod_map_map
    (textbookWienerVectorContinuousPath_aemeasurable _ P (textbookWienerVectorFuture_isWiener B P hB S) T)
    (textbookLangevinGlobalRandomPhase_history_aemeasurable B P hB U hU L hF γ σ x S)).mp
      (textbookLangevinGlobalRandomPhase_future_independent_history B P hB U hU L hF γ σ x S T)
  rw [textbookWienerVectorFuture_continuousPath_law B P hB S T hT] at he
  exact he

end MolecularDynamics