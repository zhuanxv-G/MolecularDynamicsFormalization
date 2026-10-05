import MolecularDynamics.Chapter06.LangevinPathSolution
import MolecularDynamics.Chapter06.WienerVectorContinuousPath

/-! Actual measurable random solutions and periodic accessibility without supplied solution-existence or endpoint-measurability premises. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics

/-- The centered continuous-map version agrees with the literal real-time Wiener noise on the whole interval almost surely. -/
theorem textbookWienerVectorContinuousPath_noise_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) :
    ∀ᵐ sample ∂P, ∀ t ∈ Icc 0 T,
      textbookLangevinPathNoise T hT (textbookWienerVectorContinuousPath B T sample) t =
        B t.toNNReal sample := by
  filter_upwards [hB.cont, textbookWienerVector_zero_ae B P hB] with sample hc hz
  intro t ht
  unfold textbookLangevinPathNoise
  rw [projIcc_of_mem hT ht,
    textbookWienerVectorContinuousPath_eval B T sample hc ⟨t, ht⟩,
    textbookWienerVectorContinuousPath_eval B T sample hc ⟨0, le_rfl, hT⟩]
  have he : (⟨t, ht.1⟩ : ℝ≥0) = t.toNNReal := (Real.toNNReal_of_nonneg ht.1).symm
  rw [he]
  change B t.toNNReal sample - B 0 sample = B t.toNNReal sample
  rw [hz, sub_zero]

/-- The genuine pathwise constructed random solution, from the actual Wiener continuous-map version. -/
noncomputable def textbookLangevinRandomSolution {Nc : ℕ} {Ω : Type*}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc)
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (sample : Ω) :
    (ℝ → (Fin Nc → ℝ)) × (ℝ → (Fin Nc → ℝ)) :=
  textbookLangevinPathSolution U L hF γ σ T hT x (textbookWienerVectorContinuousPath B T sample)

/-- The actual constructed functions solve the literal Wiener-driven integral equations almost surely. -/
theorem textbookLangevinRandomSolution_integralSolution_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, textbookLangevinIntegralSolution U γ σ T x (fun t ↦ B t.toNNReal sample)
      (textbookLangevinRandomSolution U L hF γ σ T hT x B sample).1
      (textbookLangevinRandomSolution U L hF γ σ T hT x B sample).2 := by
  filter_upwards [textbookWienerVectorContinuousPath_noise_ae B P hB T hT] with sample he
  have hs := textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x
    (textbookWienerVectorContinuousPath B T sample)
  rcases hs with ⟨hq, hp, hW, hW0, hqeq, hpeq⟩
  refine ⟨hq, hp, hW.congr (fun t ht ↦ (he t ht).symm), ?_, hqeq, ?_⟩
  · change B (0 : ℝ).toNNReal sample = 0
    rw [← he 0 ⟨le_rfl, hT⟩, hW0]
  · intro t ht
    simp only []
    rw [← he t ht]
    exact hpeq t ht

/-- Every actual random phase evaluation is a.e.-measurable, derived from true endpoint continuity and genuine Wiener path measurability. -/
theorem textbookLangevinRandomSolution_endpoint_aemeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPhase Nc) (t : ℝ) (ht : t ∈ Icc 0 T) :
    AEMeasurable (fun sample ↦ ((textbookLangevinRandomSolution U L hF γ σ T hT x B sample).1 t,
      (textbookLangevinRandomSolution U L hF γ σ T hT x B sample).2 t)) P :=
  (textbookLangevinPathEndpoint_continuous U hU L hF γ σ T hT x t ht).measurable.comp_aemeasurable
    (textbookWienerVectorContinuousPath_aemeasurable B P hB T)

/-- Actual constructed real-space solutions have nonempty-open accessibility, without assumed solution existence or measurable endpoints. -/
theorem textbookLangevinRandomSolution_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hσ : σ ≠ 0) (hT : 0 < T)
    (x : textbookLangevinPhase Nc) (C : Set (textbookLangevinPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | ((textbookLangevinRandomSolution U L hF γ σ T hT.le x B sample).1 T,
      (textbookLangevinRandomSolution U L hF γ σ T hT.le x B sample).2 T) ∈ C} P ∧
    0 < P {sample | ((textbookLangevinRandomSolution U L hF γ σ T hT.le x B sample).1 T,
      (textbookLangevinRandomSolution U L hF γ σ T hT.le x B sample).2 T) ∈ C} := by
  exact textbookLangevinEndpoint_open_pos B P hB U hU γ σ T hσ hT x
    (fun t sample ↦ (textbookLangevinRandomSolution U L hF γ σ T hT.le x B sample).1 t)
    (fun t sample ↦ (textbookLangevinRandomSolution U L hF γ σ T hT.le x B sample).2 t)
    (textbookLangevinRandomSolution_integralSolution_ae B P hB U L hF γ σ T hT.le x)
    (textbookLangevinRandomSolution_endpoint_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ T hT.le x T ⟨hT.le, le_rfl⟩)
    C hC hCN

private theorem project_actual_solution {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (x : textbookLangevinPeriodicPhase Nc) (W q p : ℝ → (Fin Nc → ℝ))
    (hs : textbookLangevinIntegralSolution U γ σ T (textbookLangevinPeriodicRepresentative x.1, x.2) W q p) :
    textbookLangevinPeriodicIntegralSolution U γ σ T x W (fun t i ↦ (q t i : UnitAddCircle)) p := by
  rcases hs with ⟨_, hp, hW, hW0, hqeq, hpeq⟩
  refine ⟨hp, hW, hW0, ?_, ?_⟩
  · intro t ht
    simp only []
    rw [hqeq t ht]
    ext i
    change ((textbookLangevinPeriodicRepresentative x.1 i + (∫ s in 0..t, p s) i : ℝ) : UnitAddCircle) = _
    rw [AddCircle.coe_add]
    exact congrArg (fun z : UnitAddCircle ↦ z + ((∫ s in 0..t, p s) i : UnitAddCircle))
      (congrFun (textbookLangevinPeriodicRepresentative_projects x.1) i)
  · intro t ht
    have hint : (∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s) =
        ∫ s in 0..t, textbookLangevinPeriodicForce U (fun i ↦ (q s i : UnitAddCircle)) - γ • p s := by
      apply intervalIntegral.integral_congr
      intro s _
      change textbookPotentialForce U (q s) - γ • p s =
        textbookLangevinPeriodicForce U (fun i ↦ (q s i : UnitAddCircle)) - γ • p s
      rw [textbookLangevinPeriodicForce_lift U hU hP]
    have he := hpeq t ht
    rw [hint] at he
    exact he

/-- The actual real integral solution projects to the true periodic integral equations. -/
theorem textbookLangevinIntegralSolution_periodicProjection {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (x : textbookLangevinPeriodicPhase Nc) (W q p : ℝ → (Fin Nc → ℝ))
    (hs : textbookLangevinIntegralSolution U γ σ T (textbookLangevinPeriodicRepresentative x.1, x.2) W q p) :
    textbookLangevinPeriodicIntegralSolution U γ σ T x W (fun t i ↦ (q t i : UnitAddCircle)) p :=
  project_actual_solution U hU hP γ σ T x W q p hs

/-- Smooth actual periodicity constructs a genuine a.e. Wiener-driven periodic integral solution with every time evaluation a.e.-measurable. -/
theorem textbookLangevinPeriodicRandomSolution_exists {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ q : ℝ → Ω → UnitAddTorus (Fin Nc), ∃ p : ℝ → Ω → (Fin Nc → ℝ),
      (∀ᵐ sample ∂P, textbookLangevinPeriodicIntegralSolution U γ σ T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample)) ∧
      ∀ t ∈ Icc 0 T, AEMeasurable (fun sample ↦ (q t sample, p t sample)) P := by
  obtain ⟨L, hL⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  let xr : textbookLangevinPhase Nc := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let qp := textbookLangevinRandomSolution U L hL γ σ T hT xr B
  let q : ℝ → Ω → UnitAddTorus (Fin Nc) := fun t sample i ↦ ((qp sample).1 t i : UnitAddCircle)
  let p : ℝ → Ω → (Fin Nc → ℝ) := fun t sample ↦ (qp sample).2 t
  refine ⟨q, p, ?_, ?_⟩
  · filter_upwards [textbookLangevinRandomSolution_integralSolution_ae B P hB U L hL γ σ T hT xr]
      with sample hs
    exact project_actual_solution U hU hP γ σ T x _ _ _ hs
  · intro t ht
    have hm := textbookLangevinRandomSolution_endpoint_aemeasurable B P hB U (hU.of_le (by simp))
      L hL γ σ T hT xr t ht
    exact (textbookLangevinPeriodicProjection_continuous Nc).measurable.comp_aemeasurable hm

/-- The actual periodic random model has nonempty-open accessibility at every specified positive time, without assuming existence or endpoint measurability. -/
theorem textbookLangevinPeriodicRandomSolution_exists_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (hσ : σ ≠ 0) (hT : 0 < T) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ q : ℝ → Ω → UnitAddTorus (Fin Nc), ∃ p : ℝ → Ω → (Fin Nc → ℝ),
      (∀ᵐ sample ∂P, textbookLangevinPeriodicIntegralSolution U γ σ T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample)) ∧
      (∀ t ∈ Icc 0 T, AEMeasurable (fun sample ↦ (q t sample, p t sample)) P) ∧
      ∀ C : Set (textbookLangevinPeriodicPhase Nc), IsOpen C → C.Nonempty →
        NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
          0 < P {sample | (q T sample, p T sample) ∈ C} := by
  obtain ⟨q, p, hs, hm⟩ := textbookLangevinPeriodicRandomSolution_exists B P hB U hU hP γ σ T hT.le x
  refine ⟨q, p, hs, hm, fun C hC hCN ↦ ?_⟩
  exact textbookLangevinPeriodicEndpoint_open_pos B P hB U hU hP γ σ T hσ hT x q p hs
    (hm T ⟨hT.le, le_rfl⟩) C hC hCN

/-- Physical positive friction and inverse temperature yield a genuine constructed periodic model and nonempty-open accessibility. -/
theorem textbookLangevinPeriodicRandomSolution_physicalNoise_exists_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ β T : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (hT : 0 < T) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ q : ℝ → Ω → UnitAddTorus (Fin Nc), ∃ p : ℝ → Ω → (Fin Nc → ℝ),
      (∀ᵐ sample ∂P, textbookLangevinPeriodicIntegralSolution U γ (Real.sqrt (2 * γ * β⁻¹)) T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample)) ∧
      (∀ t ∈ Icc 0 T, AEMeasurable (fun sample ↦ (q t sample, p t sample)) P) ∧
      ∀ C : Set (textbookLangevinPeriodicPhase Nc), IsOpen C → C.Nonempty →
        NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
          0 < P {sample | (q T sample, p T sample) ∈ C} := by
  exact textbookLangevinPeriodicRandomSolution_exists_open_pos B P hB U hU hP γ _ T
    (ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))) hT x

end MolecularDynamics
