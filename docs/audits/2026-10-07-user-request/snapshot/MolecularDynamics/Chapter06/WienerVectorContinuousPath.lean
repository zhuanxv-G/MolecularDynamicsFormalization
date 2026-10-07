import MolecularDynamics.Chapter06.WienerVectorSupport
import Mathlib.Topology.ContinuousMap.Compact
import Mathlib.MeasureTheory.Constructions.BorelSpace.ContinuousMap
import Mathlib.Topology.ContinuousMap.SecondCountableSpace

/-! A genuine continuous-map-valued version of the actual vector Wiener path. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology NNReal

namespace MolecularDynamics

/-- A genuine interval continuous Wiener path on continuous samples; zero on the exceptional samples. -/
noncomputable def textbookWienerVectorContinuousPath {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω) : C(Icc 0 T, Fin Nc → ℝ) := by
  classical
  exact if h : Continuous (fun t ↦ B t sample) then
    ⟨fun s ↦ B ⟨s.1, s.2.1⟩ sample, h.comp (by fun_prop)⟩ else 0

/-- On every continuous sample the genuine continuous map is literally the original path at every time. -/
theorem textbookWienerVectorContinuousPath_eval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample := by
  simp [textbookWienerVectorContinuousPath, hc]

/-- Actual coordinate Gaussian measurability and almost-sure continuity give whole continuous-path measurability; it is not a model premise. -/
theorem textbookWienerVectorContinuousPath_aemeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P := by
  have hEval (t : Icc 0 T) : AEMeasurable (fun sample ↦ textbookWienerVectorContinuousPath B T sample t) P := by
    have hm : AEMeasurable (fun sample ↦ B ⟨t.1, t.2.1⟩ sample) P :=
      .of_eval (fun i ↦ hB.gaussian.aemeasurable ⟨i, ⟨t.1, t.2.1⟩⟩)
    apply hm.congr
    filter_upwards [hB.cont] with sample hc
    exact (textbookWienerVectorContinuousPath_eval B T sample hc t).symm
  have hn : NullMeasurable (textbookWienerVectorContinuousPath B T) P := by
    change @Measurable (NullMeasurableSpace Ω P) C(Icc 0 T, Fin Nc → ℝ) _ _ _
    exact ContinuousMap.measurable_iff_eval.mpr (fun t ↦ (hEval t).nullMeasurable.measurable')
  exact hn.aemeasurable

end MolecularDynamics
