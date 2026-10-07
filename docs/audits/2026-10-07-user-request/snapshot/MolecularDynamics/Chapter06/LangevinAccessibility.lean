import MolecularDynamics.Chapter06.WienerVectorSupport
import MolecularDynamics.Chapter06.LangevinSmoothCutoff

/-! Actual positive endpoint probabilities in the real-space Langevin model of Lemma6.1.
A genuine almost-sure integral solution on the prescribed interval is explicit;
existence and nonexplosion are not concealed in a support premise. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics

/-- Genuine vector Wiener support and actual smooth-potential noise stability give every endpoint ball positive probability. -/
theorem textbookLangevinEndpoint_ball_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x : textbookLangevinPhase Nc)
    (q p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (y : textbookLangevinPhase Nc) (δ : ℝ) (hδ : 0 < δ) :
    NullMeasurableSet {sample | (q T sample, p T sample) ∈ Metric.ball y δ} P ∧
      0 < P {sample | (q T sample, p T sample) ∈ Metric.ball y δ} := by
  refine ⟨hEnd.nullMeasurableSet_preimage measurableSet_ball, ?_⟩
  obtain ⟨ε, hε, hs⟩ := textbookLangevinControlledEndpoint_stable U hU γ σ T δ hσ hT hδ x y
  let R := textbookLangevinControlPath U γ σ T x y
  have hr : Continuous R := (textbookLangevinControlPath_contDiff U hU γ σ T x y).continuous
  have hz : R 0 = 0 := by simp [R, textbookLangevinControlPath]
  have hp := textbookWienerVectorRealControlTube_pos B P hB T hT R hr hz ε hε
  apply lt_of_lt_of_le hp
  apply measure_mono_ae
  filter_upwards [hSol] with sample hsample
  intro htube
  exact hs (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample) hsample htube

/-- Every nonempty open phase set has genuinely positive endpoint probability for the given actual Langevin solution. -/
theorem textbookLangevinEndpoint_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x : textbookLangevinPhase Nc)
    (q p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (C : Set (textbookLangevinPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
      0 < P {sample | (q T sample, p T sample) ∈ C} := by
  refine ⟨hEnd.nullMeasurableSet_preimage hC.measurableSet, ?_⟩
  obtain ⟨y, hy⟩ := hCN
  obtain ⟨δ, hδ, hb⟩ := Metric.mem_nhds_iff.mp (hC.mem_nhds hy)
  have hp := (textbookLangevinEndpoint_ball_pos B P hB U hU γ σ T hσ hT x q p hSol hEnd y δ hδ).2
  apply lt_of_lt_of_le hp
  apply measure_mono
  intro sample hsample
  exact hb hsample

/-- The textbook positive-friction and positive-inverse-temperature noise has the actual nonempty-open accessibility. -/
theorem textbookLangevinEndpoint_physicalNoise_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ β T : ℝ)
    (hγ : 0 < γ) (hβ : 0 < β) (hT : 0 < T) (x : textbookLangevinPhase Nc)
    (q p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinIntegralSolution U γ (Real.sqrt (2 * γ * β⁻¹)) T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (C : Set (textbookLangevinPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
      0 < P {sample | (q T sample, p T sample) ∈ C} := by
  apply textbookLangevinEndpoint_open_pos B P hB U hU γ _ T _ hT x q p hSol hEnd C hC hCN
  exact ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))

end MolecularDynamics
