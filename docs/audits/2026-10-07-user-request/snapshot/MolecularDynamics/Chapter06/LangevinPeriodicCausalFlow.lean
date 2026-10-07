import MolecularDynamics.Chapter06.LangevinCausalFlow

/-! The actual periodic solution family is independent of lifts and has a genuine restart identity. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- Every genuine real integral solution projects to the periodic model with its actual projected initial phase. -/
theorem textbookLangevinIntegralSolution_project {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (x : textbookLangevinPhase Nc) (W q p : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ T x W q p) :
    textbookLangevinPeriodicIntegralSolution U γ σ T (textbookLangevinPeriodicProjection x) W
      (fun t i ↦ (q t i : UnitAddCircle)) p := by
  rcases h with ⟨_, hp, hW, hz, hqeq, hpeq⟩
  refine ⟨hp, hW, hz, ?_, ?_⟩
  · intro t ht
    simp only []
    rw [hqeq t ht]
    ext i
    change ((x.1 i + (∫ s in 0..t, p s) i : ℝ) : UnitAddCircle) = _
    simp only [AddCircle.coe_add, textbookLangevinPeriodicProjection, Pi.add_apply]
  · intro t ht
    have he : (∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s) =
        ∫ s in 0..t, textbookLangevinPeriodicForce U (fun i ↦ (q s i : UnitAddCircle)) - γ • p s := by
      apply intervalIntegral.integral_congr
      intro s _
      change textbookPotentialForce U (q s) - γ • p s =
        textbookLangevinPeriodicForce U (fun i ↦ (q s i : UnitAddCircle)) - γ • p s
      rw [textbookLangevinPeriodicForce_lift U hU hP (q s)]
    simp only []
    rw [← he]
    exact hpeq t ht

/-- Two actual periodic integral solutions with the same initial phase and driving noise agree, using the genuinely constructed real lifts. -/
theorem textbookLangevinPeriodicIntegralSolution_unique {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase Nc)
    (W : ℝ → (Fin Nc → ℝ)) (q r : ℝ → UnitAddTorus (Fin Nc)) (p v : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinPeriodicIntegralSolution U γ σ T x W q p)
    (hr : textbookLangevinPeriodicIntegralSolution U γ σ T x W r v) :
    ∀ t ∈ Icc 0 T, (q t, p t) = (r t, v t) := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  have ha := textbookLangevinPeriodicIntegralSolution_lift U hU hP γ σ T hT x W q p h
  have hb := textbookLangevinPeriodicIntegralSolution_lift U hU hP γ σ T hT x W r v hr
  intro t ht
  have he := textbookLangevinIntegralSolution_unique_globalLip U (hU.of_le (by simp)) L hF γ σ T hT
    (textbookLangevinPeriodicRepresentative x.1, x.2) W
    (textbookLangevinPeriodicPositionLift x p) p (textbookLangevinPeriodicPositionLift x v) v ha hb t ht
  apply Prod.ext
  · have heq := congrArg Prod.fst he
    change textbookLangevinPeriodicPositionLift x p t = textbookLangevinPeriodicPositionLift x v t at heq
    have hpq := textbookLangevinPeriodicPositionLift_projects U γ σ T x W q p h t ht
    have hpr := textbookLangevinPeriodicPositionLift_projects U γ σ T x W r v hr t ht
    calc
      q t = (fun i ↦ (textbookLangevinPeriodicPositionLift x p t i : UnitAddCircle)) := hpq.symm
      _ = (fun i ↦ (textbookLangevinPeriodicPositionLift x v t i : UnitAddCircle)) := by rw [heq]
      _ = r t := hpr
  · simpa only [] using congrArg (Prod.snd : textbookLangevinPhase Nc → (Fin Nc → ℝ)) he

/-- The actual selected periodic phase endpoint, obtained from the true real solution. -/
noncomputable def textbookLangevinPeriodicPathEndpoint {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase Nc) (t : ℝ)
    (W : C(Icc 0 T, Fin Nc → ℝ)) : textbookLangevinPeriodicPhase Nc :=
  textbookLangevinPeriodicProjection
    (textbookLangevinPathEndpoint U L hF γ σ T hT (textbookLangevinPeriodicRepresentative x.1, x.2) t W)

/-- The actual periodic endpoint equals the projected endpoint from every real initial representative. -/
theorem textbookLangevinPeriodicPathEndpoint_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPhase Nc) (W : C(Icc 0 T, Fin Nc → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT (textbookLangevinPeriodicProjection x) t W =
      textbookLangevinPeriodicProjection (textbookLangevinPathEndpoint U L hF γ σ T hT x t W) := by
  let y := textbookLangevinPeriodicProjection x
  let a := textbookLangevinPathSolution U L hF γ σ T hT x W
  let b := textbookLangevinPathSolution U L hF γ σ T hT (textbookLangevinPeriodicRepresentative y.1, y.2) W
  have ha := textbookLangevinIntegralSolution_project U hU hP γ σ T x _ a.1 a.2
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x W)
  have hb := textbookLangevinIntegralSolution_periodicProjection U hU hP γ σ T y _ b.1 b.2
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT (textbookLangevinPeriodicRepresentative y.1, y.2) W)
  exact textbookLangevinPeriodicIntegralSolution_unique U hU hP γ σ T hT y
    (textbookLangevinPathNoise T hT W) (fun s i ↦ (b.1 s i : UnitAddCircle))
    (fun s i ↦ (a.1 s i : UnitAddCircle)) b.2 a.2 hb ha t ht

/-- The actual periodic endpoint family has the true representative-independent noise-increment restart identity. -/
theorem textbookLangevinPeriodicPathEndpoint_restart {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ A S T : ℝ)
    (hA : 0 ≤ A) (hS : 0 ≤ S) (hT : 0 ≤ T) (hSTA : S + T ≤ A)
    (x : textbookLangevinPeriodicPhase Nc) (W : C(Icc 0 A, Fin Nc → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    textbookLangevinPeriodicPathEndpoint U L hF γ σ A hA x (S + t) W =
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT
        (textbookLangevinPeriodicPathEndpoint U L hF γ σ A hA x S W) t
        (textbookLangevinPathSegment A S T hS hT hSTA W) := by
  let xr : textbookLangevinPhase Nc := (textbookLangevinPeriodicRepresentative x.1, x.2)
  change textbookLangevinPeriodicProjection (textbookLangevinPathEndpoint U L hF γ σ A hA xr (S + t) W) = _
  rw [textbookLangevinPathEndpoint_restart U (hU.of_le (by simp)) L hF γ σ A S T hA hS hT hSTA xr W t ht]
  exact (textbookLangevinPeriodicPathEndpoint_lift U hU hP L hF γ σ T hT
    (textbookLangevinPathEndpoint U L hF γ σ A hA xr S W)
    (textbookLangevinPathSegment A S T hS hT hSTA W) t ht).symm

/-- The actual all-time periodic process uses the single coherent real process and the true position quotient. -/
noncomputable def textbookLangevinPeriodicGlobalRandomPhase {Nc : ℕ} {Ω : Type*}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (t : ℝ) (sample : Ω) : textbookLangevinPeriodicPhase Nc :=
  textbookLangevinPeriodicProjection (textbookLangevinGlobalRandomPhase U L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2) B t sample)

/-- One actual periodic process satisfies the original periodic model on all real finite intervals almost surely. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_integralSolution_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    ∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T → textbookLangevinPeriodicIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample)
      (fun t ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).1)
      (fun t ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U (hU.of_le (by simp)) L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro T hT
  exact textbookLangevinIntegralSolution_periodicProjection U hU hP γ σ T x _ _ _ (hs T hT)

/-- Every actual periodic phase evaluation is a.e.-measurable, rather than a model premise. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc)
    (t : ℝ) (ht : 0 ≤ t) :
    AEMeasurable (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t) P :=
  (textbookLangevinPeriodicProjection_continuous Nc).measurable.comp_aemeasurable
    (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U hU L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) t ht)

/-- The actual periodic process equals the finite real-time history construction for all nonnegative times on one full-measure sample set. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_history_endpoint_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, ∀ ht : 0 ≤ t,
      textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample =
        textbookLangevinPeriodicPathEndpoint U L hF γ σ t ht x t (textbookWienerVectorContinuousPath B t sample) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_history_endpoint_ae B P hB U hU L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample he
  intro t ht
  exact congrArg textbookLangevinPeriodicProjection (he t ht)

/-- The actual all-time periodic solution has the genuine increment-path restart identity for all real nonnegative time pairs on a common full-measure set. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_restart_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    ∀ᵐ sample ∂P, ∀ S : ℝ, ∀ hS : 0 ≤ S, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B (S + t) sample =
        textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT
          (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S sample) t
          (textbookLangevinPathSegment (S + T) S T hS hT le_rfl
            (textbookWienerVectorContinuousPath B (S + T) sample)) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_restart_ae B P hB U (hU.of_le (by simp)) L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample he
  intro S hS T hT t ht
  change textbookLangevinPeriodicProjection
    (textbookLangevinGlobalRandomPhase U L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) B (S + t) sample) = _
  rw [he S hS T hT t ht]
  exact (textbookLangevinPeriodicPathEndpoint_lift U hU hP L hF γ σ T hT
    (textbookLangevinGlobalRandomPhase U L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) B S sample)
    (textbookLangevinPathSegment (S + T) S T hS hT le_rfl (textbookWienerVectorContinuousPath B (S + T) sample)) t ht).symm

end MolecularDynamics
