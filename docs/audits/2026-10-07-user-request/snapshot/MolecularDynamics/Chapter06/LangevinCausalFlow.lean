import MolecularDynamics.Chapter06.LangevinGlobalRandomSolution

/-! Actual history restriction and restart dependencies for the Markov model in Theorem6.2. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- A genuine integral solution is unchanged when its driving path is changed only outside the interval. -/
theorem textbookLangevinIntegralSolution_noise_congr {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc)
    (W R q p : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ T x W q p) (he : EqOn R W (Icc 0 T)) :
    textbookLangevinIntegralSolution U γ σ T x R q p := by
  rcases h with ⟨hq, hp, hW, hz, hqeq, hpeq⟩
  refine ⟨hq, hp, hW.congr he, ?_, hqeq, ?_⟩
  · rw [he ⟨le_rfl, hT⟩, hz]
  · intro t ht
    rw [he ht]
    exact hpeq t ht

/-- The actual continuous noise history on a shorter interval. -/
def textbookLangevinPathRestriction {Nc : ℕ} (A T : ℝ) (hTA : T ≤ A)
    (W : C(Icc 0 A, Fin Nc → ℝ)) : C(Icc 0 T, Fin Nc → ℝ) where
  toFun t := W ⟨t.1, t.2.1, t.2.2.trans hTA⟩
  continuous_toFun := W.continuous.comp (by fun_prop)

/-- Genuine history restriction is Lipschitz in the actual uniform path metric. -/
theorem textbookLangevinPathRestriction_lipschitz {Nc : ℕ} (A T : ℝ) (hTA : T ≤ A) :
    LipschitzWith 1 (textbookLangevinPathRestriction (Nc := Nc) A T hTA) := by
  apply LipschitzWith.of_dist_le_mul
  intro W R
  simp only [NNReal.coe_one, one_mul]
  apply (ContinuousMap.dist_le (dist_nonneg : 0 ≤ dist W R)).mpr
  intro t
  exact ContinuousMap.dist_apply_le_dist (f := W) (g := R) ⟨t.1, t.2.1, t.2.2.trans hTA⟩

private theorem restricted_noise_eq {Nc : ℕ} (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T)
    (hTA : T ≤ A) (W : C(Icc 0 A, Fin Nc → ℝ)) :
    EqOn (textbookLangevinPathNoise T hT (textbookLangevinPathRestriction A T hTA W))
      (textbookLangevinPathNoise A hA W) (Icc 0 T) := by
  intro t ht
  simp only [textbookLangevinPathNoise, textbookLangevinPathRestriction, ContinuousMap.coe_mk,
    projIcc_of_mem hT ht, projIcc_of_mem hA ⟨ht.1, ht.2.trans hTA⟩]

/-- The actual chosen solution before T depends only on its genuine noise history before T. -/
theorem textbookLangevinPathEndpoint_restrict {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ A T : ℝ)
    (hA : 0 ≤ A) (hT : 0 ≤ T) (hTA : T ≤ A) (x : textbookLangevinPhase Nc)
    (W : C(Icc 0 A, Fin Nc → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    textbookLangevinPathEndpoint U L hF γ σ A hA x t W =
      textbookLangevinPathEndpoint U L hF γ σ T hT x t (textbookLangevinPathRestriction A T hTA W) := by
  let a := textbookLangevinPathSolution U L hF γ σ A hA x W
  let b := textbookLangevinPathSolution U L hF γ σ T hT x (textbookLangevinPathRestriction A T hTA W)
  have ha := textbookLangevinIntegralSolution_restrict U γ σ A T hTA x
    (textbookLangevinPathNoise A hA W) a.1 a.2
    (textbookLangevinPathSolution_integralSolution U L hF γ σ A hA x W)
  have hc := textbookLangevinIntegralSolution_noise_congr U γ σ T hT x
    (textbookLangevinPathNoise A hA W)
    (textbookLangevinPathNoise T hT (textbookLangevinPathRestriction A T hTA W)) a.1 a.2 ha
    (restricted_noise_eq A T hA hT hTA W)
  exact textbookLangevinIntegralSolution_unique_globalLip U hU L hF γ σ T hT x
    (textbookLangevinPathNoise T hT (textbookLangevinPathRestriction A T hTA W)) a.1 a.2 b.1 b.2 hc
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x (textbookLangevinPathRestriction A T hTA W)) t ht

/-- On a truly continuous zero-start sample the actual selected functions solve the literal integral equations for every chosen real horizon. -/
theorem textbookLangevinRandomSolution_integralSolution_of_cont {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPhase Nc) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (hz : B 0 sample = 0) :
    textbookLangevinIntegralSolution U γ σ T x (fun t ↦ B t.toNNReal sample)
      (textbookLangevinRandomSolution U L hF γ σ T hT x B sample).1
      (textbookLangevinRandomSolution U L hF γ σ T hT x B sample).2 := by
  have he : EqOn (fun t : ℝ ↦ B t.toNNReal sample)
      (textbookLangevinPathNoise T hT (textbookWienerVectorContinuousPath B T sample)) (Icc 0 T) := by
    intro t ht
    unfold textbookLangevinPathNoise
    rw [projIcc_of_mem hT ht,
      textbookWienerVectorContinuousPath_eval B T sample hc ⟨t, ht⟩,
      textbookWienerVectorContinuousPath_eval B T sample hc ⟨0, le_rfl, hT⟩]
    have hn : (⟨t, ht.1⟩ : ℝ≥0) = t.toNNReal := (Real.toNNReal_of_nonneg ht.1).symm
    rw [hn]
    change B t.toNNReal sample = B t.toNNReal sample - B 0 sample
    rw [hz, sub_zero]
  exact textbookLangevinIntegralSolution_noise_congr U γ σ T hT x _ _ _ _
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x (textbookWienerVectorContinuousPath B T sample)) he

/-- On one common full-measure sample set the actual all-time endpoint equals the construction using only each finite real-time history. -/
theorem textbookLangevinGlobalRandomPhase_history_endpoint_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, ∀ ht : 0 ≤ t,
      textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample =
        textbookLangevinPathEndpoint U L hF γ σ t ht x t (textbookWienerVectorContinuousPath B t sample) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U hU L hF γ σ x,
    hB.cont, textbookWienerVector_zero_ae B P hB] with sample hs hc hz
  intro t ht
  have hf := textbookLangevinRandomSolution_integralSolution_of_cont B U L hF γ σ t ht x sample hc hz
  have he := textbookLangevinIntegralSolution_unique_globalLip U hU L hF γ σ t ht x
    (fun s ↦ B s.toNNReal sample)
    (fun s ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ x B s sample).1)
    (fun s ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ x B s sample).2)
    (textbookLangevinRandomSolution U L hF γ σ t ht x B sample).1
    (textbookLangevinRandomSolution U L hF γ σ t ht x B sample).2 (hs t ht) hf t ⟨ht, le_rfl⟩
  exact he

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

/-- A real time shift of the actual rough-noise integral equations is a true restarted solution driven by the noise increment. -/
theorem textbookLangevinIntegralSolution_shift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ S T : ℝ)
    (hS : 0 ≤ S) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) (W q p : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ (S + T) x W q p) :
    textbookLangevinIntegralSolution U γ σ T (q S, p S)
      (fun t ↦ W (S + t) - W S) (fun t ↦ q (S + t)) (fun t ↦ p (S + t)) := by
  rcases h with ⟨hq, hp, hW, _, hqeq, hpeq⟩
  have hm : MapsTo (fun t : ℝ ↦ S + t) (Icc 0 T) (Icc 0 (S + T)) := by
    intro t ht
    constructor
    · linarith [ht.1]
    · linarith [ht.2]
  have hsc : ContinuousOn (fun t : ℝ ↦ S + t) (Icc 0 T) := (continuous_const.add continuous_id).continuousOn
  have hFS : ContinuousOn (fun t ↦ textbookPotentialForce U (q t) - γ • p t) (Icc 0 (S + T)) :=
    ((contDiff_textbookPotentialForce U hU).continuous.comp_continuousOn hq).fun_sub (hp.const_smul γ)
  have hSin : S ∈ Icc 0 (S + T) := ⟨hS, by linarith⟩
  refine ⟨hq.comp hsc hm, hp.comp hsc hm, (hW.comp hsc hm).sub continuousOn_const,
    by simp, ?_, ?_⟩
  · intro t ht
    change q (S + t) = q S + ∫ r in 0..t, p (S + r)
    rw [hqeq (S + t) (hm ht), hqeq S hSin, integral_split_shift p S T hS hT hp t ht]
    abel
  · intro t ht
    change p (S + t) = p S +
      (∫ r in 0..t, textbookPotentialForce U (q (S + r)) - γ • p (S + r)) + σ • (W (S + t) - W S)
    rw [hpeq (S + t) (hm ht), hpeq S hSin,
      integral_split_shift (fun r ↦ textbookPotentialForce U (q r) - γ • p r) S T hS hT hFS t ht]
    module

/-- The actual continuous increment path on a prescribed later noise interval. -/
def textbookLangevinPathSegment {Nc : ℕ} (A S T : ℝ) (hS : 0 ≤ S) (hT : 0 ≤ T)
    (hSTA : S + T ≤ A) (W : C(Icc 0 A, Fin Nc → ℝ)) : C(Icc 0 T, Fin Nc → ℝ) where
  toFun t := W ⟨S + t.1, add_nonneg hS t.2.1, (add_le_add le_rfl t.2.2).trans hSTA⟩ -
    W ⟨S, hS, (le_add_of_nonneg_right hT).trans hSTA⟩
  continuous_toFun := (W.continuous.comp (by fun_prop)).sub continuous_const

/-- The true later increment path is centered at zero. -/
theorem textbookLangevinPathSegment_zero {Nc : ℕ} (A S T : ℝ) (hS : 0 ≤ S) (hT : 0 ≤ T)
    (hSTA : S + T ≤ A) (W : C(Icc 0 A, Fin Nc → ℝ)) :
    textbookLangevinPathSegment A S T hS hT hSTA W ⟨0, le_rfl, hT⟩ = 0 := by
  simp [textbookLangevinPathSegment]

private theorem segment_noise_eq {Nc : ℕ} (A S T : ℝ) (hA : 0 ≤ A) (hS : 0 ≤ S) (hT : 0 ≤ T)
    (hSTA : S + T ≤ A) (W : C(Icc 0 A, Fin Nc → ℝ)) :
    EqOn (textbookLangevinPathNoise T hT (textbookLangevinPathSegment A S T hS hT hSTA W))
      (fun t ↦ textbookLangevinPathNoise A hA W (S + t) - textbookLangevinPathNoise A hA W S) (Icc 0 T) := by
  intro t ht
  have hst : S + t ∈ Icc 0 A :=
    ⟨add_nonneg hS ht.1, (add_le_add le_rfl ht.2).trans hSTA⟩
  have hs : S ∈ Icc 0 A := ⟨hS, (le_add_of_nonneg_right hT).trans hSTA⟩
  simp only [textbookLangevinPathNoise, projIcc_of_mem hT ht,
    projIcc_of_mem hA hst, projIcc_of_mem hA hs, textbookLangevinPathSegment, ContinuousMap.coe_mk]
  abel

/-- The actual chosen solution has the genuine pathwise restart identity, rather than an assumed cocycle. -/
theorem textbookLangevinPathEndpoint_restart {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ A S T : ℝ)
    (hA : 0 ≤ A) (hS : 0 ≤ S) (hT : 0 ≤ T) (hSTA : S + T ≤ A)
    (x : textbookLangevinPhase Nc) (W : C(Icc 0 A, Fin Nc → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    textbookLangevinPathEndpoint U L hF γ σ A hA x (S + t) W =
      textbookLangevinPathEndpoint U L hF γ σ T hT
        (textbookLangevinPathEndpoint U L hF γ σ A hA x S W) t
        (textbookLangevinPathSegment A S T hS hT hSTA W) := by
  let a := textbookLangevinPathSolution U L hF γ σ A hA x W
  let y : textbookLangevinPhase Nc := (a.1 S, a.2 S)
  let R := textbookLangevinPathSegment A S T hS hT hSTA W
  let b := textbookLangevinPathSolution U L hF γ σ T hT y R
  have ha := textbookLangevinIntegralSolution_restrict U γ σ A (S + T) hSTA x
    (textbookLangevinPathNoise A hA W) a.1 a.2
    (textbookLangevinPathSolution_integralSolution U L hF γ σ A hA x W)
  have hs := textbookLangevinIntegralSolution_shift U hU γ σ S T hS hT x
    (textbookLangevinPathNoise A hA W) a.1 a.2 ha
  have hc := textbookLangevinIntegralSolution_noise_congr U γ σ T hT y _ _ _ _ hs
    (segment_noise_eq A S T hA hS hT hSTA W)
  exact textbookLangevinIntegralSolution_unique_globalLip U hU L hF γ σ T hT y
    (textbookLangevinPathNoise T hT R) (fun r ↦ a.1 (S + r)) (fun r ↦ a.2 (S + r)) b.1 b.2 hc
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT y R) t ht

/-- The one actual all-time process agrees with every finite-history solution on its entire interval, on a common full-measure set. -/
theorem textbookLangevinGlobalRandomPhase_history_path_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, ∀ A : ℝ, ∀ hA : 0 ≤ A, ∀ t ∈ Icc 0 A,
      textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample =
        textbookLangevinPathEndpoint U L hF γ σ A hA x t (textbookWienerVectorContinuousPath B A sample) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U hU L hF γ σ x,
    hB.cont, textbookWienerVector_zero_ae B P hB] with sample hs hc hz
  intro A hA t ht
  have hf := textbookLangevinRandomSolution_integralSolution_of_cont B U L hF γ σ A hA x sample hc hz
  exact textbookLangevinIntegralSolution_unique_globalLip U hU L hF γ σ A hA x
    (fun s ↦ B s.toNNReal sample)
    (fun s ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ x B s sample).1)
    (fun s ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ x B s sample).2)
    (textbookLangevinRandomSolution U L hF γ σ A hA x B sample).1
    (textbookLangevinRandomSolution U L hF γ σ A hA x B sample).2 (hs A hA) hf t ht

/-- The actual all-time random solution has the genuine noise-increment restart identity for every real pair of nonnegative times on one full-measure sample set. -/
theorem textbookLangevinGlobalRandomPhase_restart_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, ∀ S : ℝ, ∀ hS : 0 ≤ S, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookLangevinGlobalRandomPhase U L hF γ σ x B (S + t) sample =
        textbookLangevinPathEndpoint U L hF γ σ T hT
          (textbookLangevinGlobalRandomPhase U L hF γ σ x B S sample) t
          (textbookLangevinPathSegment (S + T) S T hS hT le_rfl
            (textbookWienerVectorContinuousPath B (S + T) sample)) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_history_path_ae B P hB U hU L hF γ σ x] with sample he
  intro S hS T hT t ht
  have hA : 0 ≤ S + T := add_nonneg hS hT
  have hst : S + t ∈ Icc 0 (S + T) := ⟨add_nonneg hS ht.1, add_le_add le_rfl ht.2⟩
  have hs : S ∈ Icc 0 (S + T) := ⟨hS, le_add_of_nonneg_right hT⟩
  have h := textbookLangevinPathEndpoint_restart U hU L hF γ σ (S + T) S T hA hS hT le_rfl x
    (textbookWienerVectorContinuousPath B (S + T) sample) t ht
  rw [← he (S + T) hA (S + t) hst, ← he (S + T) hA S hs] at h
  exact h

end MolecularDynamics
