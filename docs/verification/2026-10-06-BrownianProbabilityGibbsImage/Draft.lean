import MolecularDynamics.Chapter06.BrownianDynkinFormula
import MolecularDynamics.Chapter06.BrownianClosedOperator

/-! The same actual probability expectations in the original Gibbs L2 space.
The input of the bounded image map is C(Torus,Real); no L2-input probability
extension or equality with the Gibbs spectral semigroup is assumed. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory LinearPMap

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ)

/-- Original Gibbs probability normalization, proved previously, makes the continuous inclusion a contraction. -/
theorem textbookGibbsContinuousToLp_norm_le_one :
    ‖textbookGibbsContinuousToLp U hU hPU β‖ ≤ 1 := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  have he := ContinuousMap.toLp_norm_le (p := 2) (𝕜 := ℝ) (E := ℝ) (textbookConfigurationTorusGibbsMeasure U β)
  simpa [textbookGibbsContinuousToLp, measureUnivNNReal] using he

/-- The inclusion of the original lifted observable is precisely the already accepted same-Gibbs L2 observable. -/
theorem textbookGibbsContinuousToLp_original_observable
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hpf : textbookUnitPeriodicPotential f) :
    textbookGibbsContinuousToLp U hU hPU β
      (textbookConfigurationContinuousObservable f hf hpf) =
      textbookConfigurationGibbsL2Observable U hU hPU β f hf hpf := by
  apply Lp.ext
  exact (textbookGibbsContinuousToLp_ae_eq U hU hPU β _).trans
    (textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f hf hpf).symm

variable (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

/-- The same actual probability transition followed by actual Gibbs inclusion; its input is the entire continuous-observable space. -/
def textbookBrownianProbabilityGibbsL2Image (t : ℝ≥0) :
    C(UnitAddTorus (Fin Nc), ℝ) →L[ℝ] Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  (textbookGibbsContinuousToLp U hU hPU β).comp
    (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t)

/-- This same-Gibbs representative is the genuine probability expectation of the same original q, for every original core observable. -/
theorem textbookBrownianProbabilityGibbsL2Image_original_observable_ae_expectation
    (t : ℝ≥0) (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hpf : textbookUnitPeriodicPotential f) :
    (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t
      (textbookConfigurationContinuousObservable f hf.continuous hpf) : UnitAddTorus (Fin Nc) → ℝ) =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      fun X ↦ ∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
        (textbookConfigurationTorusRepresentative X) B t sample) ∂P := by
  refine (textbookGibbsContinuousToLp_ae_eq U hU hPU β _).trans ?_
  exact Eventually.of_forall fun X ↦ textbookBrownianTorusProbabilityOperator_original_observable_expectation m hm U hU hPU β hβ B P hB f hf hpf t X

/-- The actual image is bounded from the uniform continuous norm to Gibbs L2; this statement has CMap input, rather than an unproved L2 extension. -/
theorem textbookBrownianProbabilityGibbsL2Image_norm_le_one (t : ℝ≥0) :
    ‖textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t‖ ≤ 1 := by
  apply (textbookGibbsContinuousToLp U hU hPU β).opNorm_comp_le _ |>.trans
  calc
    ‖textbookGibbsContinuousToLp U hU hPU β‖ *
        ‖textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t‖ ≤
        ‖textbookGibbsContinuousToLp U hU hPU β‖ * 1 :=
      mul_le_mul_of_nonneg_left
        (textbookBrownianTorusProbabilityOperator_norm_le_one m hm U hU hPU β hβ B P hB t)
        (norm_nonneg (textbookGibbsContinuousToLp U hU hPU β))
    _ = ‖textbookGibbsContinuousToLp U hU hPU β‖ := mul_one _
    _ ≤ 1 := textbookGibbsContinuousToLp_norm_le_one U hU hPU β

variable (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hpf : textbookUnitPeriodicPotential f)

/-- The literal continuous-generator image embeds into exactly the accepted original same-Gibbs image. -/
theorem textbookGibbsContinuousToLp_original_generator_image :
    textbookGibbsContinuousToLp U hU hPU β
      (textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf) =
      textbookBrownianGibbsL2Image m U hU hPU β f hf hpf := by
  exact textbookGibbsContinuousToLp_original_observable U hU hPU β
    (textbookBrownianGenerator m U β f)
    (textbookBrownianGenerator_contDiff m U β f hU hf).continuous
    (textbookBrownianGenerator_periodic m U β f hU hf hPU hpf)

include hB hf hpf in
/-- The same genuine probability expectations have the literal original generator as their strong Gibbs L2 right limit on the original core. -/
theorem textbookBrownianProbabilityGibbsL2Image_original_generator_tendsto :
    Tendsto (fun t : ℝ ↦ t⁻¹ •
      (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
       textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf))
      (𝓝[>] 0) (𝓝 (textbookBrownianGibbsL2Image m U hU hPU β f hf hpf)) := by
  have hh := ((textbookGibbsContinuousToLp U hU hPU β).continuous.tendsto _).comp
    (textbookBrownianTorusProbabilityOperator_original_generator_tendsto m hm U hU hPU β hβ B P hB f hf hpf)
  simpa only [Function.comp_def, map_smul, map_sub,
    textbookGibbsContinuousToLp_original_observable,
    textbookGibbsContinuousToLp_original_generator_image,
    textbookBrownianProbabilityGibbsL2Image, ContinuousLinearMap.comp_apply] using hh

include hB in
/-- These genuine same-Gibbs probability images are strongly continuous in the real time parameter. -/
theorem textbookBrownianProbabilityGibbsL2Image_real_time_continuous
    (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    Continuous (fun t : ℝ ↦ textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t.toNNReal g) :=
  (textbookGibbsContinuousToLp U hU hPU β).continuous.comp
    (textbookBrownianTorusProbabilityOperator_real_time_continuous m hm U hU hPU β hβ B P hB g)

include hB hf hpf in
/-- The actual probability expectation in the original Gibbs L2 space has the derived right derivative at every nonnegative time. -/
theorem textbookBrownianProbabilityGibbsL2Image_hasDeriv_right
    (s : ℝ) (hs : 0 ≤ s) :
    HasDerivWithinAt (fun t : ℝ ↦ textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf))
      (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB s.toNNReal
        (textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf)) (Ioi s) s := by
  exact (textbookGibbsContinuousToLp U hU hPU β).hasFDerivAt.comp_hasDerivWithinAt s
    (textbookBrownianTorusProbabilityOperator_hasDeriv_right m hm U hU hPU β hβ B P hB f hf hpf s hs)

include hB hf hpf in
/-- The genuine same-Gibbs L2 images satisfy the true Dynkin integral identity for the original stochastic process. -/
theorem textbookBrownianProbabilityGibbsL2Image_Dynkin
    (T : ℝ) (hT : 0 ≤ T) :
    textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB T.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf) -
      textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf =
      ∫ s in 0..T, textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB s.toNNReal
        (textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf) := by
  let J := textbookGibbsContinuousToLp U hU hPU β
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  let G := textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf
  have hi := (textbookBrownianTorusProbabilityOperator_real_time_continuous m hm U hU hPU β hβ B P hB G).intervalIntegrable (μ := volume) 0 T
  calc
    _ = J (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T.toNNReal F - F) := by
      rw [map_sub, textbookGibbsContinuousToLp_original_observable]
      rfl
    _ = J (∫ s in 0..T, textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal G) :=
      congrArg J (textbookBrownianTorusProbabilityOperator_Dynkin m hm U hU hPU β hβ B P hB f hf hpf T hT)
    _ = ∫ s in 0..T, J (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB s.toNNReal G) :=
      (J.intervalIntegral_comp_comm hi).symm
    _ = _ := rfl

include hB in
/-- On every actual original smooth core element, the genuine probability generator limit is exactly the value of the previously constructed same-Gibbs closed operator. -/
theorem textbookBrownianProbabilityGibbsL2Image_closed_original_core_tendsto
    (g : textbookPeriodicSmoothSpace Nc) :
    Tendsto (fun t : ℝ ↦ t⁻¹ •
      (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t.toNNReal
        (textbookConfigurationContinuousObservable g g.prop.1.continuous g.prop.2) -
       textbookConfigurationGibbsL2Observable U hU hPU β g g.prop.1.continuous g.prop.2))
      (𝓝[>] 0) (𝓝 (textbookBrownianGibbsClosedOperator m U hU hPU β
        (Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
          (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β g)))) := by
  rw [textbookBrownianGibbsClosedOperator_apply_lift]
  exact textbookBrownianProbabilityGibbsL2Image_original_generator_tendsto U hU hPU β m hm hβ B P hB
    g g.prop.1 g.prop.2

end
end MolecularDynamics
