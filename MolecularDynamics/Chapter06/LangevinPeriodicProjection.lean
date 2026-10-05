import MolecularDynamics.Chapter06.LangevinAccessibility
import Mathlib.Topology.Instances.AddCircle.Real

/-! Actual unit-torus position projection of the existing Langevin integral solution.
This identifies the quotient endpoint event; a stochastic lift or periodic-generator
identification is not inferred from a topological projection alone. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics

/-- The actual unit-period position torus times real momentum space in Chapter6. -/
abbrev textbookLangevinPeriodicPhase (Nc : ℕ) := UnitAddTorus (Fin Nc) × (Fin Nc → ℝ)

/-- The actual position quotient, leaving momentum unchanged. -/
def textbookLangevinPeriodicProjection {Nc : ℕ}
    (z : textbookLangevinPhase Nc) : textbookLangevinPeriodicPhase Nc :=
  (fun i ↦ (z.1 i : UnitAddCircle), z.2)

/-- The actual finite position quotient is continuous. -/
theorem textbookLangevinPeriodicProjection_continuous (Nc : ℕ) :
    Continuous (textbookLangevinPeriodicProjection : textbookLangevinPhase Nc → textbookLangevinPeriodicPhase Nc) := by
  unfold textbookLangevinPeriodicProjection
  apply Continuous.prodMk
  · apply continuous_pi
    intro i
    exact (AddCircle.continuous_mk' (1 : ℝ)).comp ((continuous_apply i).comp continuous_fst)
  · exact continuous_snd

/-- Every actual torus position and momentum has a genuine real phase representative. -/
theorem textbookLangevinPeriodicProjection_surjective (Nc : ℕ) :
    Function.Surjective (textbookLangevinPeriodicProjection : textbookLangevinPhase Nc → textbookLangevinPeriodicPhase Nc) := by
  intro y
  have h (i : Fin Nc) : ∃ r : ℝ, (r : UnitAddCircle) = y.1 i := QuotientAddGroup.mk_surjective (y.1 i)
  choose q hq using h
  refine ⟨(q, y.2), ?_⟩
  apply Prod.ext
  · exact funext hq
  · rfl

/-- A nonempty open periodic phase target pulls back to a genuinely nonempty open real phase target. -/
theorem textbookLangevinPeriodicProjection_open_preimage {Nc : ℕ}
    (C : Set (textbookLangevinPeriodicPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    IsOpen (textbookLangevinPeriodicProjection ⁻¹' C) ∧
      (textbookLangevinPeriodicProjection ⁻¹' C).Nonempty := by
  refine ⟨hC.preimage (textbookLangevinPeriodicProjection_continuous Nc), ?_⟩
  obtain ⟨y, hy⟩ := hCN
  obtain ⟨z, hz⟩ := textbookLangevinPeriodicProjection_surjective Nc y
  refine ⟨z, ?_⟩
  change textbookLangevinPeriodicProjection z ∈ C
  rw [hz]
  exact hy

/-- The actual quotient endpoint of the given real Langevin solution hits every nonempty open periodic phase target with positive probability. -/
theorem textbookLangevinProjectedEndpoint_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x : textbookLangevinPhase Nc)
    (q p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (C : Set (textbookLangevinPeriodicPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | textbookLangevinPeriodicProjection (q T sample, p T sample) ∈ C} P ∧
      0 < P {sample | textbookLangevinPeriodicProjection (q T sample, p T sample) ∈ C} := by
  obtain ⟨hD, hDN⟩ := textbookLangevinPeriodicProjection_open_preimage C hC hCN
  exact textbookLangevinEndpoint_open_pos B P hB U hU γ σ T hσ hT x q p hSol hEnd
    (textbookLangevinPeriodicProjection ⁻¹' C) hD hDN

/-- The physical positive-friction noise has the same genuine projected nonempty-open accessibility. -/
theorem textbookLangevinProjectedEndpoint_physicalNoise_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ β T : ℝ)
    (hγ : 0 < γ) (hβ : 0 < β) (hT : 0 < T) (x : textbookLangevinPhase Nc)
    (q p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinIntegralSolution U γ (Real.sqrt (2 * γ * β⁻¹)) T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (C : Set (textbookLangevinPeriodicPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | textbookLangevinPeriodicProjection (q T sample, p T sample) ∈ C} P ∧
      0 < P {sample | textbookLangevinPeriodicProjection (q T sample, p T sample) ∈ C} := by
  obtain ⟨hD, hDN⟩ := textbookLangevinPeriodicProjection_open_preimage C hC hCN
  exact textbookLangevinEndpoint_physicalNoise_open_pos B P hB U hU γ β T hγ hβ hT x q p hSol hEnd
    (textbookLangevinPeriodicProjection ⁻¹' C) hD hDN

end MolecularDynamics
