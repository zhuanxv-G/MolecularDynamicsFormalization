import MolecularDynamics.Chapter06.LangevinTransitionKernel
import Mathlib.Probability.Kernel.Composition.MeasureComp

/-! Actual Chapman–Kolmogorov laws for the constructed Langevin transition kernels.
Necessary Markov-model dependencies for Theorem 6.2, printed 252 / PDF 273. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics

/-- The actual continuous-path solution starts at the stated initial phase for every noise path. -/
theorem textbookLangevinPathEndpoint_initial {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookLangevinPathEndpoint U L hF γ σ T hT x 0 W = x := by
  have hs := textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x W
  apply Prod.ext
  · change (textbookLangevinPathSolution U L hF γ σ T hT x W).1 0 = x.1
    simpa only [intervalIntegral.integral_same, add_zero] using hs.2.2.2.2.1 0 ⟨le_rfl, hT⟩
  · change (textbookLangevinPathSolution U L hF γ σ T hT x W).2 0 = x.2
    simpa only [intervalIntegral.integral_same, add_zero, hs.2.2.2.1, smul_zero] using
      hs.2.2.2.2.2 0 ⟨le_rfl, hT⟩

/-- The actual periodic solution also starts at its stated torus phase for every noise path. -/
theorem textbookLangevinPeriodicPathEndpoint_initial {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase Nc) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT x 0 W = x := by
  unfold textbookLangevinPeriodicPathEndpoint
  rw [textbookLangevinPathEndpoint_initial]
  exact Prod.ext (textbookLangevinPeriodicRepresentative_projects x.1) rfl

/-- The actual real transition kernel at zero time is the identity probability kernel. -/
theorem textbookLangevinTransitionKernel_zero {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) :
    textbookLangevinTransitionKernel B P U hU L hF γ σ 0 = Kernel.id := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  ext x : 1
  rw [textbookLangevinTransitionKernel_apply B P hB U hU L hF γ σ 0 x, Kernel.id_apply]
  have he : textbookLangevinPathEndpoint U L hF γ σ 0 (by simp) x 0 = (fun _ ↦ x) :=
    funext (textbookLangevinPathEndpoint_initial U L hF γ σ 0 (by simp) x)
  change (P.map (textbookWienerVectorContinuousPath B 0)).map
    (textbookLangevinPathEndpoint U L hF γ σ 0 (by simp) x 0) = Measure.dirac x
  rw [he, Measure.map_const, measure_univ, one_smul]

/-- The same zero-time identity holds for the true periodic transition kernel. -/
theorem textbookLangevinPeriodicTransitionKernel_zero {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) :
    textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ 0 = Kernel.id := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  ext x : 1
  rw [textbookLangevinPeriodicTransitionKernel_apply B P hB U hU hP L hF γ σ 0 x, Kernel.id_apply]
  have he : textbookLangevinPeriodicPathEndpoint U L hF γ σ 0 (by simp) x 0 = (fun _ ↦ x) :=
    funext (textbookLangevinPeriodicPathEndpoint_initial U L hF γ σ 0 (by simp) x)
  change (P.map (textbookWienerVectorContinuousPath B 0)).map
    (textbookLangevinPeriodicPathEndpoint U L hF γ σ 0 (by simp) x 0) = Measure.dirac x
  rw [he, Measure.map_const, measure_univ, one_smul]

/-- The actual future marginal is the transition kernel composed with the actual present law. -/
theorem textbookLangevinGlobalRandomPhase_transition_marginal {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPhase Nc) (S T : ℝ≥0) :
    P.map (textbookLangevinGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T)) =
      textbookLangevinTransitionKernel B P U hU L hF γ σ T ∘ₘ
        P.map (textbookLangevinGlobalRandomPhase U L hF γ σ x B S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinTransitionKernel B P U hU L hF γ σ T) :=
    textbookLangevinTransitionKernel_isMarkov B P hB U hU L hF γ σ T
  have mH := textbookLangevinGlobalRandomPhase_history_aemeasurable B P hB U hU L hF γ σ x S
  have mS := textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U hU L hF γ σ x S S.property
  have mY := textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U hU L hF γ σ x
    ((S : ℝ) + T) (add_nonneg S.property T.property)
  have hj := congrArg Measure.snd
    (textbookLangevinGlobalRandomPhase_history_transition_joint_law B P hB U hU L hF γ σ x S T)
  rw [Measure.snd_map_prodMk₀ mH mY, Measure.snd_compProd] at hj
  rw [hj]
  ext a ha
  rw [Measure.bind_apply ha (Kernel.aemeasurable _), Measure.bind_apply ha (Kernel.aemeasurable _),
    lintegral_map' (Kernel.measurable_coe _ ha).aemeasurable mH,
    lintegral_map' (Kernel.measurable_coe _ ha).aemeasurable mS]
  rfl

/-- Genuine Chapman–Kolmogorov law of the actual real Langevin transition family. -/
theorem textbookLangevinTransitionKernel_add {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (S T : ℝ≥0) :
    textbookLangevinTransitionKernel B P U hU L hF γ σ (S + T) =
      textbookLangevinTransitionKernel B P U hU L hF γ σ T ∘ₖ
        textbookLangevinTransitionKernel B P U hU L hF γ σ S := by
  ext x : 1
  rw [textbookLangevinTransitionKernel_global_law B P hB U hU L hF γ σ (S + T) x,
    Kernel.comp_apply, textbookLangevinTransitionKernel_global_law B P hB U hU L hF γ σ S x]
  exact textbookLangevinGlobalRandomPhase_transition_marginal B P hB U hU L hF γ σ x S T

/-- The actual future marginal is the transition kernel composed with the actual present law. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_transition_marginal {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase Nc) (S T : ℝ≥0) :
    P.map (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B ((S : ℝ) + T)) =
      textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T ∘ₘ
        P.map (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hP L hF γ σ T
  have mH := textbookLangevinPeriodicGlobalRandomPhase_history_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ x S
  have mS := textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ x S S.property
  have mY := textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U (hU.of_le (by simp)) L hF γ σ x
    ((S : ℝ) + T) (add_nonneg S.property T.property)
  have hj := congrArg Measure.snd
    (textbookLangevinPeriodicGlobalRandomPhase_history_transition_joint_law B P hB U hU hP L hF γ σ x S T)
  rw [Measure.snd_map_prodMk₀ mH mY, Measure.snd_compProd] at hj
  rw [hj]
  ext a ha
  rw [Measure.bind_apply ha (Kernel.aemeasurable _), Measure.bind_apply ha (Kernel.aemeasurable _),
    lintegral_map' (Kernel.measurable_coe _ ha).aemeasurable mH,
    lintegral_map' (Kernel.measurable_coe _ ha).aemeasurable mS]
  rfl

/-- Genuine Chapman–Kolmogorov law of the actual real Langevin transition family. -/
theorem textbookLangevinPeriodicTransitionKernel_add {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (S T : ℝ≥0) :
    textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ (S + T) =
      textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T ∘ₖ
        textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ S := by
  ext x : 1
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hP L hF γ σ (S + T) x,
    Kernel.comp_apply, textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hP L hF γ σ S x]
  exact textbookLangevinPeriodicGlobalRandomPhase_transition_marginal B P hB U hU hP L hF γ σ x S T


/-- The original smooth periodic potential gives a genuine probability-kernel semigroup, without a force regularity conclusion as an input. -/
theorem textbookLangevinPeriodicTransitionKernel_semigroup_of_periodic
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) :
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
      (∀ T, IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T)) ∧
      textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ 0 = Kernel.id ∧
      ∀ S T, textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ (S + T) =
        textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T ∘ₖ
          textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ S := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  exact ⟨L, hF, textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hP L hF γ σ,
    textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hP L hF γ σ,
    textbookLangevinPeriodicTransitionKernel_add B P hB U hU hP L hF γ σ⟩
end MolecularDynamics
