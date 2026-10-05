import MolecularDynamics.Chapter06.LangevinRandomSolution
import Mathlib.Algebra.Order.Floor.Semiring

/-! Actual coherent all-time Wiener-driven Langevin paths, not a family of unrelated finite-time solutions. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics

/-- Restricting a genuine integral solution preserves the original equations and driving noise. -/
theorem textbookLangevinIntegralSolution_restrict {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ A T : ℝ) (hTA : T ≤ A)
    (x : textbookLangevinPhase Nc) (W q p : ℝ → (Fin Nc → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ A x W q p) :
    textbookLangevinIntegralSolution U γ σ T x W q p := by
  rcases h with ⟨hq, hp, hW, hz, hqeq, hpeq⟩
  have hs : Icc 0 T ⊆ Icc 0 A := Icc_subset_Icc le_rfl hTA
  exact ⟨hq.mono hs, hp.mono hs, hW.mono hs, hz,
    fun t ht ↦ hqeq t (hs ht), fun t ht ↦ hpeq t (hs ht)⟩

private theorem solution_of_eqOn {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (_hT : 0 ≤ T) (x : textbookLangevinPhase Nc)
    (W : ℝ → (Fin Nc → ℝ)) (α β : ℝ → textbookLangevinPhase Nc)
    (hs : textbookLangevinIntegralSolution U γ σ T x W (fun t ↦ (α t).1) (fun t ↦ (α t).2))
    (he : EqOn β α (Icc 0 T)) :
    textbookLangevinIntegralSolution U γ σ T x W (fun t ↦ (β t).1) (fun t ↦ (β t).2) := by
  rcases hs with ⟨hq, hp, hW, hz, hqeq, hpeq⟩
  refine ⟨hq.congr (fun t ht ↦ congrArg Prod.fst (he ht)),
    hp.congr (fun t ht ↦ congrArg Prod.snd (he ht)), hW, hz, ?_, ?_⟩
  · intro t ht
    simp only [] at hqeq hpeq ⊢
    have hseg : uIcc 0 t ⊆ Icc 0 T := by rw [uIcc_of_le ht.1]; exact Icc_subset_Icc le_rfl ht.2
    have hint : (∫ s in 0..t, (α s).2) = ∫ s in 0..t, (β s).2 :=
      intervalIntegral.integral_congr (fun s hs ↦ (congrArg Prod.snd (he (hseg hs))).symm)
    rw [congrArg Prod.fst (he ht), hqeq t ht, hint]
  · intro t ht
    simp only [] at hqeq hpeq ⊢
    have hseg : uIcc 0 t ⊆ Icc 0 T := by rw [uIcc_of_le ht.1]; exact Icc_subset_Icc le_rfl ht.2
    have hint : (∫ s in 0..t, textbookPotentialForce U (α s).1 - γ • (α s).2) =
        ∫ s in 0..t, textbookPotentialForce U (β s).1 - γ • (β s).2 := by
      apply intervalIntegral.integral_congr
      intro s hs
      simp only [he (hseg hs)]
    rw [congrArg Prod.snd (he ht), hpeq t ht, hint]

private theorem family_agree {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (W : ℝ → (Fin Nc → ℝ))
    (α : ℕ → ℝ → textbookLangevinPhase Nc)
    (hs : ∀ n : ℕ, textbookLangevinIntegralSolution U γ σ (n : ℝ) x W
      (fun t ↦ (α n t).1) (fun t ↦ (α n t).2))
    (m n : ℕ) (t : ℝ) (ht0 : 0 ≤ t) (htm : t ≤ m) (htn : t ≤ n) : α m t = α n t := by
  have hm := textbookLangevinIntegralSolution_restrict U γ σ (m : ℝ) (min (m : ℝ) (n : ℝ))
    (min_le_left _ _) x W _ _ (hs m)
  have hn := textbookLangevinIntegralSolution_restrict U γ σ (n : ℝ) (min (m : ℝ) (n : ℝ))
    (min_le_right _ _) x W _ _ (hs n)
  have he := textbookLangevinIntegralSolution_unique_globalLip U hU L hF γ σ _ (by positivity)
    x W _ _ _ _ hm hn t ⟨ht0, le_min htm htn⟩
  exact he

private theorem global_from_family {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (W : ℝ → (Fin Nc → ℝ))
    (α : ℕ → ℝ → textbookLangevinPhase Nc)
    (hs : ∀ n : ℕ, textbookLangevinIntegralSolution U γ σ (n : ℝ) x W
      (fun t ↦ (α n t).1) (fun t ↦ (α n t).2)) :
    ∀ T : ℝ, 0 ≤ T → textbookLangevinIntegralSolution U γ σ T x W
      (fun t ↦ (α (Nat.ceil t + 1) t).1) (fun t ↦ (α (Nat.ceil t + 1) t).2) := by
  intro T hT
  let N := Nat.ceil T + 1
  have hTN : T ≤ (N : ℝ) := (Nat.le_ceil T).trans (by dsimp [N]; simp only [Nat.cast_add, Nat.cast_one]; exact le_add_of_nonneg_right zero_le_one)
  have hr := textbookLangevinIntegralSolution_restrict U γ σ (N : ℝ) T hTN x W _ _ (hs N)
  apply solution_of_eqOn U γ σ T hT x W (α N) (fun t ↦ α (Nat.ceil t + 1) t) hr
  intro t ht
  have htn : t ≤ ((Nat.ceil t + 1 : ℕ) : ℝ) := (Nat.le_ceil t).trans (by simp only [Nat.cast_add, Nat.cast_one]; exact le_add_of_nonneg_right zero_le_one)
  exact family_agree U hU L hF γ σ x W α hs _ N t ht.1 htn (ht.2.trans hTN)

/-- Select actual integer-horizon solutions coherently at every time. Agreement is proved, rather than assumed. -/
noncomputable def textbookLangevinGlobalRandomPhase {Nc : ℕ} {Ω : Type*}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (x : textbookLangevinPhase Nc) (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (t : ℝ) (sample : Ω) : textbookLangevinPhase Nc :=
  let n := Nat.ceil t + 1
  let qp := textbookLangevinRandomSolution U L hF γ σ (n : ℝ) (Nat.cast_nonneg n) x B sample
  (qp.1 t, qp.2 t)

/-- One genuine random process solves the original equations on every finite interval on the same full-measure sample set. -/
theorem textbookLangevinGlobalRandomPhase_integralSolution_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T → textbookLangevinIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample)
      (fun t ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample).1)
      (fun t ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample).2) := by
  have hAll : ∀ᵐ sample ∂P, ∀ n : ℕ, textbookLangevinIntegralSolution U γ σ (n : ℝ) x
      (fun t ↦ B t.toNNReal sample)
      (textbookLangevinRandomSolution U L hF γ σ (n : ℝ) (Nat.cast_nonneg n) x B sample).1
      (textbookLangevinRandomSolution U L hF γ σ (n : ℝ) (Nat.cast_nonneg n) x B sample).2 :=
    ae_all_iff.mpr (fun n ↦ textbookLangevinRandomSolution_integralSolution_ae B P hB U L hF γ σ _ (Nat.cast_nonneg n) x)
  filter_upwards [hAll] with sample hs
  let α : ℕ → ℝ → textbookLangevinPhase Nc := fun n t ↦
    ((textbookLangevinRandomSolution U L hF γ σ (n : ℝ) (Nat.cast_nonneg n) x B sample).1 t,
      (textbookLangevinRandomSolution U L hF γ σ (n : ℝ) (Nat.cast_nonneg n) x B sample).2 t)
  exact global_from_family U hU L hF γ σ x (fun t ↦ B t.toNNReal sample) α hs

/-- Every evaluation of the actual all-time random phase is a.e.-measurable. -/
theorem textbookLangevinGlobalRandomPhase_endpoint_aemeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc)
    (t : ℝ) (ht : 0 ≤ t) : AEMeasurable (textbookLangevinGlobalRandomPhase U L hF γ σ x B t) P := by
  have htn : t ≤ ((Nat.ceil t + 1 : ℕ) : ℝ) := (Nat.le_ceil t).trans (by simp only [Nat.cast_add, Nat.cast_one]; exact le_add_of_nonneg_right zero_le_one)
  exact textbookLangevinRandomSolution_endpoint_aemeasurable B P hB U hU L hF γ σ _
    (Nat.cast_nonneg _) x t ⟨ht, htn⟩

/-- The actual global phase paths are continuous on the entire nonnegative time axis almost surely. -/
theorem textbookLangevinGlobalRandomPhase_continuousOn_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) (Ici 0) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U hU L hF γ σ x]
    with sample hs
  intro t ht
  have hh := hs (t + 1) (by have h0 : 0 ≤ t := ht; linarith)
  have hc := (hh.1.prodMk hh.2.1) t ⟨ht, by linarith⟩
  have he : Icc (0 : ℝ) (t + 1) =ᶠ[𝓝 t] Ici 0 := by
    filter_upwards [Iio_mem_nhds (show t < t + 1 by linarith)] with s hs
    exact propext ⟨fun h ↦ h.1, fun h ↦ ⟨h, (show s < t + 1 from hs).le⟩⟩
  exact hc.congr_set he

/-- A true periodic random process exists for all nonnegative times and has the actual open-set accessibility at every positive time. -/
theorem textbookLangevinPeriodicGlobalRandomSolution_exists_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ q : ℝ → Ω → UnitAddTorus (Fin Nc), ∃ p : ℝ → Ω → (Fin Nc → ℝ),
      (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T → textbookLangevinPeriodicIntegralSolution U γ σ T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample)) ∧
      (∀ t : ℝ, 0 ≤ t → AEMeasurable (fun sample ↦ (q t sample, p t sample)) P) ∧
      ∀ T : ℝ, 0 < T → ∀ C : Set (textbookLangevinPeriodicPhase Nc), IsOpen C → C.Nonempty →
        NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
          0 < P {sample | (q T sample, p T sample) ∈ C} := by
  obtain ⟨L, hL⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  let xr : textbookLangevinPhase Nc := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let Z := textbookLangevinGlobalRandomPhase U L hL γ σ xr B
  let q : ℝ → Ω → UnitAddTorus (Fin Nc) := fun t sample i ↦ ((Z t sample).1 i : UnitAddCircle)
  let p : ℝ → Ω → (Fin Nc → ℝ) := fun t sample ↦ (Z t sample).2
  have hs : ∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T → textbookLangevinPeriodicIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample) := by
    filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
      (hU.of_le (by simp)) L hL γ σ xr] with sample hs
    intro T hT
    exact textbookLangevinIntegralSolution_periodicProjection U hU hP γ σ T x _ _ _ (hs T hT)
  have hm (t : ℝ) (ht : 0 ≤ t) : AEMeasurable (fun sample ↦ (q t sample, p t sample)) P :=
    (textbookLangevinPeriodicProjection_continuous Nc).measurable.comp_aemeasurable
      (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U (hU.of_le (by simp)) L hL γ σ xr t ht)
  refine ⟨q, p, hs, hm, fun T hT C hC hCN ↦ ?_⟩
  exact textbookLangevinPeriodicEndpoint_open_pos B P hB U hU hP γ σ T hσ hT x q p
    (hs.mono (fun _ h ↦ h T hT.le)) (hm T hT.le) C hC hCN

/-- The physical positive-friction, positive-temperature model exists as a single all-time periodic random process with actual accessibility. -/
theorem textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ q : ℝ → Ω → UnitAddTorus (Fin Nc), ∃ p : ℝ → Ω → (Fin Nc → ℝ),
      (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T → textbookLangevinPeriodicIntegralSolution U γ (Real.sqrt (2 * γ * β⁻¹)) T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample)) ∧
      (∀ t : ℝ, 0 ≤ t → AEMeasurable (fun sample ↦ (q t sample, p t sample)) P) ∧
      ∀ T : ℝ, 0 < T → ∀ C : Set (textbookLangevinPeriodicPhase Nc), IsOpen C → C.Nonempty →
        NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
          0 < P {sample | (q T sample, p T sample) ∈ C} := by
  exact textbookLangevinPeriodicGlobalRandomSolution_exists_open_pos B P hB U hU hP γ _
    (ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))) x

end MolecularDynamics
