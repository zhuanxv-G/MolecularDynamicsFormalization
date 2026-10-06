import MolecularDynamics.Chapter06.BrownianPathSolution
import MolecularDynamics.Chapter06.WienerVectorContinuousPath
import Mathlib.Algebra.Order.Floor.Semiring
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability

/-! Actual original-mass Wiener-driven Brownian paths and their genuine probability laws.
This constructs one coherent global random solution. Conditional Markov structure,
torus projection and identification with the spectral evolution remain separate. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- Changing the noise outside the true interval preserves the actual centered integral equation. -/
theorem textbookBrownianIntegralSolution_noise_congr (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (W R q : ℝ → (Fin Nc → ℝ))
    (h : textbookBrownianIntegralSolution m U β T x W q) (he : EqOn R W (Icc 0 T)) :
    textbookBrownianIntegralSolution m U β T x R q := by
  refine ⟨h.1, h.2.1.congr he, fun t ht ↦ ?_⟩
  rw [he ht, he ⟨le_rfl, hT⟩]
  exact h.2.2 t ht

/-- Select the genuine original Brownian solution driven by the actual continuous Wiener path version. -/
def textbookBrownianRandomSolution {Ω : Type*} (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ)
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (sample : Ω) : ℝ → (Fin Nc → ℝ) :=
  textbookBrownianPathSolution m hm U hU hPU β hβ T hT x
    (textbookWienerVectorContinuousPath B T sample)

/-- Each genuinely continuous sample solves the original equation with its literal noise increments. -/
theorem textbookBrownianRandomSolution_integralSolution_of_cont {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ)
    (sample : Ω) (hc : Continuous (fun t ↦ B t sample)) :
    textbookBrownianIntegralSolution m U β T x (fun t ↦ B t.toNNReal sample)
      (textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample) := by
  let W := textbookLangevinPathNoise T hT (textbookWienerVectorContinuousPath B T sample)
  have hs := textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT x
    (textbookWienerVectorContinuousPath B T sample)
  have he (t : ℝ) (ht : t ∈ Icc 0 T) : W t = B t.toNNReal sample - B 0 sample := by
    dsimp [W, textbookLangevinPathNoise]
    rw [projIcc_of_mem hT ht,
      textbookWienerVectorContinuousPath_eval B T sample hc ⟨t, ht⟩,
      textbookWienerVectorContinuousPath_eval B T sample hc ⟨0, le_rfl, hT⟩]
    have hn : (⟨t, ht.1⟩ : ℝ≥0) = t.toNNReal := (Real.toNNReal_of_nonneg ht.1).symm
    rw [hn]
    rfl
  have hcts : Continuous (fun t : ℝ ↦ B t.toNNReal sample) := hc.comp (by fun_prop)
  refine ⟨hs.1, hcts.continuousOn, fun t ht ↦ ?_⟩
  have ht0 : (0 : ℝ) ∈ Icc 0 T := ⟨le_rfl, hT⟩
  have hq := hs.2.2 t ht
  change textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample t =
    x + (∫ s in 0..t, textbookBrownianSDEDrift m U
    (textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample s)) +
      textbookBrownianSDENoise m β (W t - W 0) at hq
  rw [he t ht, he 0 ht0] at hq
  simp only [Real.toNNReal_zero, sub_self, sub_zero] at hq ⊢
  exact hq

/-- The true selected random functions satisfy the original Wiener-driven equation almost surely. -/
theorem textbookBrownianRandomSolution_integralSolution_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, textbookBrownianIntegralSolution m U β T x (fun t ↦ B t.toNNReal sample)
      (textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample) := by
  filter_upwards [hB.cont] with sample hc
  exact textbookBrownianRandomSolution_integralSolution_of_cont m hm U hU hPU β hβ B T hT x sample hc

/-- The physical zero-start Wiener law gives the literal original additive-noise equation. -/
theorem textbookBrownianRandomSolution_original_equation_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ t ∈ Icc 0 T,
      textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample t =
        x + (∫ s in 0..t, textbookBrownianSDEDrift m U
          (textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample s)) +
            textbookBrownianSDENoise m β (B t.toNNReal sample) := by
  filter_upwards [textbookBrownianRandomSolution_integralSolution_ae m hm U hU hPU β hβ B P hB T hT x,
    textbookWienerVector_zero_ae B P hB] with sample hs hz
  intro t ht
  simpa only [Real.toNNReal_zero, hz, sub_zero] using hs.2.2 t ht

/-- Endpoint a.e. measurability follows from the actual solution map and the true Wiener path carrier. -/
theorem textbookBrownianRandomSolution_endpoint_aemeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ) (t : ℝ) (ht : t ∈ Icc 0 T) :
    AEMeasurable (fun sample ↦ textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample t) P :=
  (textbookBrownianPathEndpoint_measurable m hm U hU hPU β hβ T hT x t ht).comp_aemeasurable
    (textbookWienerVectorContinuousPath_aemeasurable B P hB T)

/-- Actual solutions on different horizons agree almost surely at every shared time. -/
theorem textbookBrownianRandomSolution_horizon_agreement_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T) (hTA : T ≤ A) (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ t ∈ Icc 0 T,
      textbookBrownianRandomSolution m hm U hU hPU β hβ A hA x B sample t =
        textbookBrownianRandomSolution m hm U hU hPU β hβ T hT x B sample t := by
  filter_upwards [textbookBrownianRandomSolution_integralSolution_ae m hm U hU hPU β hβ B P hB A hA x,
    textbookBrownianRandomSolution_integralSolution_ae m hm U hU hPU β hβ B P hB T hT x] with sample ha ht
  exact textbookBrownianIntegralSolution_horizon_agreement m U hU hPU β A T hT hTA x _ _ _ ha ht

private theorem solution_of_eqOn (T : ℝ) (x : Fin Nc → ℝ) (W q r : ℝ → (Fin Nc → ℝ))
    (h : textbookBrownianIntegralSolution m U β T x W q) (he : EqOn r q (Icc 0 T)) :
    textbookBrownianIntegralSolution m U β T x W r := by
  refine ⟨h.1.congr he, h.2.1, fun t ht ↦ ?_⟩
  have hseg : uIcc 0 t ⊆ Icc 0 T := by
    rw [uIcc_of_le ht.1]
    exact Icc_subset_Icc le_rfl ht.2
  have hint : (∫ s in 0..t, textbookBrownianSDEDrift m U (r s)) =
      ∫ s in 0..t, textbookBrownianSDEDrift m U (q s) :=
    intervalIntegral.integral_congr (fun s hs ↦ congrArg (textbookBrownianSDEDrift m U) (he (hseg hs)))
  rw [he ht, hint]
  exact h.2.2 t ht

include hU hPU in
private theorem family_agree (x : Fin Nc → ℝ) (W : ℝ → (Fin Nc → ℝ))
    (α : ℕ → ℝ → (Fin Nc → ℝ))
    (hs : ∀ n : ℕ, textbookBrownianIntegralSolution m U β (n : ℝ) x W (α n))
    (a n : ℕ) (t : ℝ) (ht0 : 0 ≤ t) (hta : t ≤ a) (htn : t ≤ n) : α a t = α n t := by
  have ha := textbookBrownianIntegralSolution_restrict m U β (a : ℝ) (min (a : ℝ) (n : ℝ))
    (min_le_left _ _) x W _ (hs a)
  have hn := textbookBrownianIntegralSolution_restrict m U β (n : ℝ) (min (a : ℝ) (n : ℝ))
    (min_le_right _ _) x W _ (hs n)
  exact textbookBrownianIntegralSolution_unique m U hU hPU β _ (by positivity) x W _ _ ha hn
    t ⟨ht0, le_min hta htn⟩

include hU hPU in
private theorem global_from_family (x : Fin Nc → ℝ) (W : ℝ → (Fin Nc → ℝ))
    (α : ℕ → ℝ → (Fin Nc → ℝ))
    (hs : ∀ n : ℕ, textbookBrownianIntegralSolution m U β (n : ℝ) x W (α n))
    (T : ℝ) (_hT : 0 ≤ T) :
    textbookBrownianIntegralSolution m U β T x W (fun t ↦ α (Nat.ceil t + 1) t) := by
  let N := Nat.ceil T + 1
  have hTN : T ≤ (N : ℝ) := (Nat.le_ceil T).trans (by
    dsimp [N]; simp only [Nat.cast_add, Nat.cast_one]; exact le_add_of_nonneg_right zero_le_one)
  have hr := textbookBrownianIntegralSolution_restrict m U β (N : ℝ) T hTN x W _ (hs N)
  apply solution_of_eqOn m U β T x W (α N) (fun t ↦ α (Nat.ceil t + 1) t) hr
  intro t ht
  have htn : t ≤ ((Nat.ceil t + 1 : ℕ) : ℝ) := (Nat.le_ceil t).trans (by
    simp only [Nat.cast_add, Nat.cast_one]; exact le_add_of_nonneg_right zero_le_one)
  exact family_agree m U hU hPU β x W α hs _ N t ht.1 htn (ht.2.trans hTN)

/-- A single actual all-time random configuration, assembled from genuinely agreeing integer-horizon solutions. -/
def textbookBrownianGlobalRandomConfiguration {Ω : Type*} (x : Fin Nc → ℝ)
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (t : ℝ) (sample : Ω) : Fin Nc → ℝ :=
  let n := Nat.ceil t + 1
  textbookBrownianRandomSolution m hm U hU hPU β hβ (n : ℝ) (Nat.cast_nonneg n) x B sample t

/-- The same full-measure sample set solves the original equation on every finite real horizon. -/
theorem textbookBrownianGlobalRandomConfiguration_integralSolution_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
      textbookBrownianIntegralSolution m U β T x (fun t ↦ B t.toNNReal sample)
        (fun t ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) := by
  have hAll : ∀ᵐ sample ∂P, ∀ n : ℕ,
      textbookBrownianIntegralSolution m U β (n : ℝ) x (fun t ↦ B t.toNNReal sample)
        (textbookBrownianRandomSolution m hm U hU hPU β hβ (n : ℝ) (Nat.cast_nonneg n) x B sample) :=
    ae_all_iff.mpr (fun n ↦ textbookBrownianRandomSolution_integralSolution_ae
      m hm U hU hPU β hβ B P hB (n : ℝ) (Nat.cast_nonneg n) x)
  filter_upwards [hAll] with sample hs
  exact global_from_family m U hU hPU β x (fun t ↦ B t.toNNReal sample)
    (fun n ↦ textbookBrownianRandomSolution m hm U hU hPU β hβ (n : ℝ) (Nat.cast_nonneg n) x B sample) hs

/-- The actual global process has its original initial value on every sample. -/
theorem textbookBrownianGlobalRandomConfiguration_initial {Ω : Type*} (x : Fin Nc → ℝ)
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (sample : Ω) :
    textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B 0 sample = x := by
  unfold textbookBrownianGlobalRandomConfiguration textbookBrownianRandomSolution
  exact textbookBrownianPathEndpoint_initial m hm U hU hPU β hβ _ (Nat.cast_nonneg _) x
    (textbookWienerVectorContinuousPath B _ sample)

/-- Every actual nonnegative-time evaluation of the single global process is a.e.-measurable. -/
theorem textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    AEMeasurable (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t) P := by
  have htn : t ≤ ((Nat.ceil t + 1 : ℕ) : ℝ) := (Nat.le_ceil t).trans (by
    simp only [Nat.cast_add, Nat.cast_one]; exact le_add_of_nonneg_right zero_le_one)
  exact textbookBrownianRandomSolution_endpoint_aemeasurable m hm U hU hPU β hβ B P hB _
    (Nat.cast_nonneg _) x t ⟨ht, htn⟩

/-- Almost surely the genuine global paths are continuous on the whole nonnegative time axis. -/
theorem textbookBrownianGlobalRandomConfiguration_continuousOn_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P,
      ContinuousOn (fun t ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) (Ici 0) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x]
    with sample hs
  intro t ht
  have hh := hs (t + 1) (by have h0 : 0 ≤ t := ht; linarith)
  have hc := hh.1 t ⟨ht, by linarith⟩
  have he : Icc (0 : ℝ) (t + 1) =ᶠ[𝓝 t] Ici 0 := by
    filter_upwards [Iio_mem_nhds (show t < t + 1 by linarith)] with s hs
    exact propext ⟨fun h ↦ h.1, fun h ↦ ⟨h, (show s < t + 1 from hs).le⟩⟩
  exact hc.congr_set he

/-- On one common full-measure sample set the global process uses only each actual finite history. -/
theorem textbookBrownianGlobalRandomConfiguration_history_path_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample =
        textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x t
          (textbookWienerVectorContinuousPath B T sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x,
    hB.cont] with sample hs hc
  intro T hT t ht
  exact textbookBrownianIntegralSolution_unique m U hU hPU β T hT x _ _ _
    (hs T hT)
    (textbookBrownianRandomSolution_integralSolution_of_cont m hm U hU hPU β hβ B T hT x sample hc) t ht

/-- Literal original zero-start Wiener increments drive the true global integral equation. -/
theorem textbookBrownianGlobalRandomConfiguration_original_equation_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t →
      textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample =
        x + (∫ s in 0..t, textbookBrownianSDEDrift m U
          (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) +
            textbookBrownianSDENoise m β (B t.toNNReal sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x,
    textbookWienerVector_zero_ae B P hB] with sample hs hz
  intro t ht
  simpa only [Real.toNNReal_zero, hz, sub_zero] using (hs t ht).2.2 t ⟨ht, le_rfl⟩

/-- The actual time law is the pushforward of the genuinely constructed global configuration. -/
def textbookBrownianGlobalTimeLaw {Ω : Type*} [MeasurableSpace Ω]
    (x : Fin Nc → ℝ) (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (t : ℝ) :
    Measure (Fin Nc → ℝ) :=
  P.map (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t)

/-- The actual constructed time law is a probability measure under the genuine Wiener law. -/
theorem textbookBrownianGlobalTimeLaw_isProbabilityMeasure {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    IsProbabilityMeasure (textbookBrownianGlobalTimeLaw m hm U hU hPU β hβ x B P t) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hf := textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB x t ht
  refine ⟨?_⟩
  rw [textbookBrownianGlobalTimeLaw, Measure.map_apply_of_aemeasurable hf MeasurableSet.univ,
    preimage_univ, measure_univ]

/-- At every genuine nonnegative time, the time law evaluates to the actual endpoint event probability. -/
theorem textbookBrownianGlobalTimeLaw_apply {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) (S : Set (Fin Nc → ℝ)) (hS : MeasurableSet S) :
    textbookBrownianGlobalTimeLaw m hm U hU hPU β hβ x B P t S =
      P {sample | textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample ∈ S} :=
  Measure.map_apply_of_aemeasurable
    (textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB x t ht) hS

end
end MolecularDynamics