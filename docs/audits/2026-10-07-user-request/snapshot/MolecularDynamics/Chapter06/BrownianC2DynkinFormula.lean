import MolecularDynamics.Chapter06.BrownianC2Generator

/-! The same actual Brownian probability process satisfies the genuine Dynkin
formula on the original C2 integer-periodic observable range. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

variable (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f)

include hB hf hpf in
/-- The actual semigroup law transports the proved original generator limit to every nonnegative time. -/
theorem textbookBrownianTorusProbabilityOperator_C2shifted_generator_tendsto
    (s : ℝ) (hs : 0 ≤ s) :
    Tendsto (fun h : ℝ ↦ h⁻¹ •
      (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB (s + h).toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
       textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf)))
      (𝓝[>] 0) (𝓝 (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal
        (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf))) := by
  have hh := ((textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal).continuous.tendsto _).comp
    (textbookBrownianTorusProbabilityOperator_C2original_generator_tendsto m hm U hU hPU β hβ B P hB f hf hpf)
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with h hpos
  rw [Real.toNNReal_add hs hpos.le, textbookBrownianTorusProbabilityOperator_add]
  simp only [Function.comp_def, ContinuousLinearMap.comp_apply, map_smul, map_sub]

include hB hf hpf in
/-- Every time has the true right derivative P_s Lf on the original observable core; no time-derivative premise is supplied. -/
theorem textbookBrownianTorusProbabilityOperator_C2hasDeriv_right
    (s : ℝ) (hs : 0 ≤ s) :
    HasDerivWithinAt (fun t : ℝ ↦ textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf))
      (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal
        (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf)) (Ioi s) s := by
  apply (hasDerivWithinAt_iff_tendsto_slope' (show s ∉ Ioi s by simp)).mpr
  have hshift : Tendsto (fun t : ℝ ↦ t - s) (𝓝[>] s) (𝓝[>] (0 : ℝ)) := by
    apply tendsto_nhdsWithin_iff.mpr
    refine ⟨?_, ?_⟩
    · have hc : Continuous (fun t : ℝ ↦ t - s) := by fun_prop
      simpa only [sub_self] using (hc.tendsto s).mono_left nhdsWithin_le_nhds
    · filter_upwards [self_mem_nhdsWithin] with t ht
      change 0 < t - s
      exact sub_pos.mpr ht
  have hh := (textbookBrownianTorusProbabilityOperator_C2shifted_generator_tendsto m hm U hU hPU β hβ B P hB f hf hpf s hs).comp hshift
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have he : s + (t - s) = t := by ring
  simp only [Function.comp_def, slope, he, vsub_eq_sub]

include hB hf hpf in
/-- The genuine Banach-space fundamental theorem of calculus gives the same actual probability semigroup's Dynkin formula. -/
theorem textbookBrownianTorusProbabilityOperator_C2Dynkin
    (T : ℝ) (hT : 0 ≤ T) :
    textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf) -
      textbookConfigurationContinuousObservable f hf.continuous hpf =
      ∫ s in 0..T, textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal
        (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf) := by
  have hcF := textbookBrownianTorusProbabilityOperator_real_time_continuous m hm U hU hPU β hβ B P hB
    (textbookConfigurationContinuousObservable f hf.continuous hpf)
  have hcG := textbookBrownianTorusProbabilityOperator_real_time_continuous m hm U hU hPU β hβ B P hB
    (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf)
  have he := intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le hT hcF.continuousOn
    (fun s hs ↦ textbookBrownianTorusProbabilityOperator_C2hasDeriv_right m hm U hU hPU β hβ B P hB f hf hpf s hs.1.le)
    (hcG.intervalIntegrable (μ := volume) 0 T)
  simpa only [Real.toNNReal_zero, textbookBrownianTorusProbabilityOperator_zero m hm U hU hPU β hβ B P hB,
    ContinuousLinearMap.id_apply] using he.symm

include hB hf hpf in
/-- The actual probability expectation of the same original configuration satisfies Dynkin's genuine integral identity at every torus initial state. -/
theorem textbookBrownianGlobalRandomConfiguration_C2observable_Dynkin
    (T : ℝ) (hT : 0 ≤ T) (X : UnitAddTorus (Fin Nc)) :
    (∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
      (textbookConfigurationTorusRepresentative X) B T sample) ∂P) - f (textbookConfigurationTorusRepresentative X) =
      ∫ s in 0..T, (∫ sample, textbookBrownianGenerator m U β f
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
          (textbookConfigurationTorusRepresentative X) B s sample) ∂P) := by
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  let G := textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf
  let ev : C(UnitAddTorus (Fin Nc), ℝ) →L[ℝ] ℝ := ContinuousMap.evalCLM (R := ℝ) X
  have hi := (textbookBrownianTorusProbabilityOperator_real_time_continuous m hm U hU hPU β hβ B P hB G).intervalIntegrable (μ := volume) 0 T
  have hg := textbookBrownianC2Generator_continuous m U β f hU hf
  have hpg := textbookBrownianC2Generator_periodic m U β f hPU hpf
  calc
    _ = (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T.toNNReal F - F) X := by
      change _ = (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf)) X - f (textbookConfigurationTorusRepresentative X)
      rw [textbookBrownianTorusProbabilityOperator_continuous_observable_expectation m hm U hU hPU β hβ B P hB f hpf hf.continuous,
        Real.coe_toNNReal T hT]
    _ = (∫ s in 0..T, textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal G) X :=
      congrArg (fun g : C(UnitAddTorus (Fin Nc), ℝ) ↦ g X)
        (textbookBrownianTorusProbabilityOperator_C2Dynkin m hm U hU hPU β hβ B P hB f hf hpf T hT)
    _ = ∫ s in 0..T, (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal G) X :=
      (ev.intervalIntegral_comp_comm hi).symm
    _ = _ := by
      apply intervalIntegral.integral_congr
      intro s hs
      rw [uIcc_of_le hT] at hs
      change (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal
        (textbookConfigurationContinuousObservable (textbookBrownianGenerator m U β f) hg hpg)) X = _
      rw [textbookBrownianTorusProbabilityOperator_continuous_observable_expectation m hm U hU hPU β hβ B P hB
        (textbookBrownianGenerator m U β f) hpg hg, Real.coe_toNNReal s hs.1]


include hB hf hpf in
/-- The actual probability semigroup preserves its true generator domain on each evolved original core observable, with image P_s Lf. -/
theorem textbookBrownianTorusProbabilityOperator_C2evolved_generator_tendsto
    (s : ℝ≥0) :
    Tendsto (fun h : ℝ ↦ h⁻¹ •
      (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB h.toNNReal
        (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s
          (textbookConfigurationContinuousObservable f hf.continuous hpf)) -
       textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s
          (textbookConfigurationContinuousObservable f hf.continuous hpf)))
      (𝓝[>] 0) (𝓝 (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s
        (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf))) := by
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  have hcomm (h : ℝ≥0) :
      textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB h
        (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s F) =
      textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s
        (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB h F) := by
    calc
      _ = textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB (h + s) F := by
        rw [textbookBrownianTorusProbabilityOperator_add]
        rfl
      _ = textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB (s + h) F := by rw [add_comm]
      _ = _ := by
        rw [textbookBrownianTorusProbabilityOperator_add]
        rfl
  have hh := ((textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s).continuous.tendsto _).comp
    (textbookBrownianTorusProbabilityOperator_C2original_generator_tendsto m hm U hU hPU β hβ B P hB f hf hpf)
  apply hh.congr'
  exact Eventually.of_forall fun h ↦ by
    change textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s
        (h⁻¹ • (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB h.toNNReal F - F)) =
      h⁻¹ • (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB h.toNNReal
        (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s F) -
        textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s F)
    rw [hcomm h.toNNReal]
    simp only [map_smul, map_sub]
include hB hf hpf in
/-- The actual probability expectation in the original Gibbs L2 space has the derived right derivative at every nonnegative time. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2hasDeriv_right
    (s : ℝ) (hs : 0 ≤ s) :
    HasDerivWithinAt (fun t : ℝ ↦ textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf))
      (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB s.toNNReal
        (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf)) (Ioi s) s := by
  exact (textbookGibbsContinuousToLp U hU hPU β).hasFDerivAt.comp_hasDerivWithinAt s
    (textbookBrownianTorusProbabilityOperator_C2hasDeriv_right m hm U hU hPU β hβ B P hB f hf hpf s hs)

include hB hf hpf in
/-- The genuine same-Gibbs L2 images satisfy the true Dynkin integral identity for the original stochastic process. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2Dynkin
    (T : ℝ) (hT : 0 ≤ T) :
    textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB T.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf) -
      textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf =
      ∫ s in 0..T, textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB s.toNNReal
        (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf) := by
  let J := textbookGibbsContinuousToLp U hU hPU β
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  let G := textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf
  have hi := (textbookBrownianTorusProbabilityOperator_real_time_continuous m hm U hU hPU β hβ B P hB G).intervalIntegrable (μ := volume) 0 T
  calc
    _ = J (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T.toNNReal F - F) := by
      rw [map_sub, textbookGibbsContinuousToLp_original_observable]
      rfl
    _ = J (∫ s in 0..T, textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal G) :=
      congrArg J (textbookBrownianTorusProbabilityOperator_C2Dynkin m hm U hU hPU β hβ B P hB f hf hpf T hT)
    _ = ∫ s in 0..T, J (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal G) :=
      (J.intervalIntegral_comp_comm hi).symm
    _ = _ := rfl


end
end MolecularDynamics
