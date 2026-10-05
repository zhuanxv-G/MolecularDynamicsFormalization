import MolecularDynamics.Chapter06.LangevinCompletedMarkov

/-! Actual path continuity and progressive measurability of the same Langevin model.
Necessary dependency of Theorem 6.2, printed 252 / PDF 273. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- The chosen actual continuous Wiener path restricts consistently on every sample, including exceptional samples. -/
theorem textbookWienerVectorContinuousPath_restrict {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (A T : ℝ) (hTA : T ≤ A) (sample : Ω) :
    textbookLangevinPathRestriction A T hTA (textbookWienerVectorContinuousPath B A sample) =
      textbookWienerVectorContinuousPath B T sample := by
  classical
  ext t
  by_cases hc : Continuous (fun t ↦ B t sample)
  · simp [textbookLangevinPathRestriction, textbookWienerVectorContinuousPath, hc]
  · simp [textbookLangevinPathRestriction, textbookWienerVectorContinuousPath, hc]

/-- The same actual global process agrees with its actual finite-history endpoint on every sample. -/
theorem textbookLangevinGlobalRandomPhase_history_endpoint
    {Nc : ℕ} {Ω : Type*} (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (sample : Ω) (t : ℝ) (ht : 0 ≤ t) :
    textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample =
      textbookLangevinPathEndpoint U L hF γ σ t ht x t
        (textbookWienerVectorContinuousPath B t sample) := by
  let n := Nat.ceil t + 1
  have htn : t ≤ (n : ℝ) := (Nat.le_ceil t).trans (by
    dsimp [n]
    simp only [Nat.cast_add, Nat.cast_one]
    exact le_add_of_nonneg_right zero_le_one)
  have he := textbookLangevinPathEndpoint_restrict U hU L hF γ σ (n : ℝ) t
    (Nat.cast_nonneg n) ht htn x (textbookWienerVectorContinuousPath B n sample) t ⟨ht, le_rfl⟩
  rw [textbookWienerVectorContinuousPath_restrict] at he
  exact he

/-- On every sample, the actual global endpoint before A agrees with the same actual fixed-A solution. -/
theorem textbookLangevinGlobalRandomPhase_fixed_endpoint
    {Nc : ℕ} {Ω : Type*} (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (sample : Ω) (A : ℝ) (hA : 0 ≤ A)
    (t : ℝ) (ht : t ∈ Icc 0 A) :
    textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample =
      textbookLangevinPathEndpoint U L hF γ σ A hA x t
        (textbookWienerVectorContinuousPath B A sample) := by
  rw [textbookLangevinGlobalRandomPhase_history_endpoint B U hU L hF γ σ x sample t ht.1]
  have he := textbookLangevinPathEndpoint_restrict U hU L hF γ σ A t hA ht.1 ht.2 x
    (textbookWienerVectorContinuousPath B A sample) t ⟨ht.1, le_rfl⟩
  rw [textbookWienerVectorContinuousPath_restrict] at he
  exact he.symm

/-- The same chosen global process is actually continuous on every sample, with no probability-space regularity assumption. -/
theorem textbookLangevinGlobalRandomPhase_continuousOn
    {Nc : ℕ} {Ω : Type*} (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (sample : Ω) :
    ContinuousOn (fun t ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) (Ici 0) := by
  intro t ht
  have hA : 0 ≤ t + 1 := by have h0 : 0 ≤ t := ht; linarith
  have hs := textbookLangevinPathSolution_integralSolution U L hF γ σ (t + 1) hA x
    (textbookWienerVectorContinuousPath B (t + 1) sample)
  have hc : ContinuousOn (fun s ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B s sample)
      (Icc 0 (t + 1)) :=
    (hs.1.prodMk hs.2.1).congr (fun s h ↦
      textbookLangevinGlobalRandomPhase_fixed_endpoint B U hU L hF γ σ x sample (t + 1) hA s h)
  have he : Icc (0 : ℝ) (t + 1) =ᶠ[𝓝 t] Ici 0 := by
    filter_upwards [Iio_mem_nhds (show t < t + 1 by linarith)] with s hs
    exact propext ⟨fun h ↦ h.1, fun h ↦ ⟨h, (show s < t + 1 from hs).le⟩⟩
  exact (hc t ⟨ht, by linarith⟩).congr_set he

/-- The actual real process has continuous paths on the entire nonnegative time axis for every sample. -/
theorem textbookLangevinGlobalRandomPhase_nnreal_continuous
    {Nc : ℕ} {Ω : Type*} (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (sample : Ω) :
    Continuous (fun t : ℝ≥0 ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t sample) := by
  exact (textbookLangevinGlobalRandomPhase_continuousOn B U hU L hF γ σ x sample).comp_continuous
    NNReal.continuous_coe (fun t ↦ t.property)

/-- The same actual torus process also has continuous paths on every sample. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_nnreal_continuous
    {Nc : ℕ} {Ω : Type*} (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (sample : Ω) :
    Continuous (fun t : ℝ≥0 ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) :=
  (textbookLangevinPeriodicProjection_continuous Nc).comp
    (textbookLangevinGlobalRandomPhase_nnreal_continuous B U hU L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) sample)

/-- Actual adaptedness and actual all-sample path continuity give progressive measurability of the same real process. -/
theorem textbookLangevinGlobalRandomPhase_isProgressive
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPhase Nc) :
    IsProgressive (textbookWienerVectorCompletedFiltration B P hB)
      (fun t : ℝ≥0 ↦ textbookLangevinGlobalRandomPhase U L hF γ σ x B t) :=
  IsStronglyProgressive.isProgressive
    (StronglyAdapted.isStronglyProgressive_of_continuous
      (Adapted.stronglyAdapted (textbookLangevinGlobalRandomPhase_adapted B P hB U hU L hF γ σ x))
      (textbookLangevinGlobalRandomPhase_nnreal_continuous B U hU L hF γ σ x))

/-- The same actual torus process is progressively measurable for the completed Wiener filtration. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_isProgressive
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    IsProgressive (textbookWienerVectorCompletedFiltration B P hB)
      (fun t : ℝ≥0 ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t) :=
  IsStronglyProgressive.isProgressive
    (StronglyAdapted.isStronglyProgressive_of_continuous
      (Adapted.stronglyAdapted (textbookLangevinPeriodicGlobalRandomPhase_adapted B P hB U hU L hF γ σ x))
      (textbookLangevinPeriodicGlobalRandomPhase_nnreal_continuous B U hU L hF γ σ x))

/-- In the actual smooth periodic textbook model, force Lipschitz regularity and progressive measurability are derived. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_isProgressive_of_periodic
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
      IsProgressive (textbookWienerVectorCompletedFiltration B P hB)
        (fun t : ℝ≥0 ↦ textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t) := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  exact ⟨L, hF, textbookLangevinPeriodicGlobalRandomPhase_isProgressive
    B P hB U (hU.of_le (by simp)) L hF γ σ x⟩

end MolecularDynamics
