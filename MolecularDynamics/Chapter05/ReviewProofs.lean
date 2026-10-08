import MolecularDynamics.Chapter05.Statements
import Mathlib.Tactic
/-! Only bounded elementary dependencies are proved here. Theorem 5.1,
Liouville transport, coarea, Birkhoff and KAM remain unproved statements. -/
open Set Filter MeasureTheory
open scoped BigOperators Topology ENNReal
noncomputable section
namespace MolecularDynamics.Chapter05Review
theorem coordinatePullback_proved {n : ℕ} (Φ : ℝ → E n → E n) (t : ℝ) (z : E n) (i : Fin n) :
    pullback Φ (fun x => x i) t z=Φ t z i := rfl
theorem probabilityBounds_proved {n : ℕ} (μ : Measure (E n)) [IsProbabilityMeasure μ] (A : Set (E n)) :
    0 ≤ μ A ∧ μ A ≤ 1 := ⟨bot_le, by
      calc μ A ≤ μ univ := measure_mono (subset_univ A)
           _ = 1 := measure_univ⟩
theorem conservedAverage_proved {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : timeAverage z g T=a := by
  simp [timeAverage,h,intervalIntegral.integral_const,hT]
theorem invariantIndicator_proved {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0 := by
  have ht : Φ t z ∈ A := by rw [←h t];exact mem_image_of_mem _ hz
  exact indicator_of_notMem (by simpa using ht) _
theorem correlationPullback_proved {n d : ℕ} (μ : Measure (E n)) Φ (a b : E n → E d) k t :
    correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ) := rfl
theorem denominatorBound_proved {n : ℕ} (H : E n → ℝ) (w : E n → E n) c
    (hK : IsCompact (energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (grad H z)|) (energySurface H c))
    (hn : ∀ z ∈ energySurface H c,inner ℝ (w z) (grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ energySurface H c,a ≤ |inner ℝ (w z) (grad H z)| :=
  hK.exists_forall_le' hc (fun z hz => abs_pos.mpr (hn z hz))
theorem smoothDenominatorBound_proved {n : ℕ} (H : E n → ℝ) (w : E n → E n) c
    (hK : IsCompact (energySurface H c)) (hH : ContDiff ℝ 2 H) (hw : Continuous w)
    (hn : ∀ z ∈ energySurface H c,inner ℝ (w z) (grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ energySurface H c,a ≤ |inner ℝ (w z) (grad H z)| := by
  have hg : Continuous (grad H) := by
    change Continuous ((InnerProductSpace.toDual ℝ (E n)).symm ∘ fderiv ℝ H)
    apply Continuous.comp
    · exact (InnerProductSpace.toDual ℝ (E n)).symm.toContinuousLinearEquiv.continuous
    · exact (hH.fderiv_right (m := 1) (by norm_num)).continuous
  exact denominatorBound_proved H w c hK (hw.inner hg |>.abs |>.continuousOn) hn
theorem zeroPerturbation_proved {n : ℕ} (H g : E n → ℝ) (w : E n → E n) c ε :
    perturbationCorrection H (fun _ => 0) g w c ε=0 := by
  have hz : perturbationDisplacement H (fun _ => 0) w ε=(fun _ => 0) := by
    funext z
    simp [perturbationDisplacement]
  simp [perturbationCorrection,hz,divergence,microAverage,average]
theorem symplecticEulerShadow_proved : symplecticEulerShadow_statement := by
  intro h z
  simp [shadowOscillator,symplecticEuler]
  ring
end MolecularDynamics.Chapter05Review
