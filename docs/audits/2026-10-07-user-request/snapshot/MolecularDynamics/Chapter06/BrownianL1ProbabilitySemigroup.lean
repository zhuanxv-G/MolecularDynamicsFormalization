import MolecularDynamics.Chapter06.BrownianSpectralDensityLaw
import Mathlib.Analysis.Normed.Operator.Extend
import Mathlib.MeasureTheory.Function.L1Space.AEEqFun

/-! Genuine L1 extensions of the same original Brownian probability semigroup.
The bound uses actual kernel integration and the proved original Gibbs invariance. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

/-- The actual continuous-observable inclusion into the entire original Gibbs L1. -/
def textbookGibbsContinuousToL1 :
    C(UnitAddTorus (Fin N), ℝ) →L[ℝ] Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  exact ContinuousMap.toLp 1 (textbookConfigurationTorusGibbsMeasure U β) ℝ

theorem textbookGibbsContinuousToL1_ae_eq (F : C(UnitAddTorus (Fin N), ℝ)) :
    (textbookGibbsContinuousToL1 U hU hp β F : UnitAddTorus (Fin N) → ℝ)
      =ᵐ[textbookConfigurationTorusGibbsMeasure U β] F := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  exact ContinuousMap.coeFn_toLp (textbookConfigurationTorusGibbsMeasure U β) F

theorem textbookGibbsContinuousToL1_denseRange :
    DenseRange (textbookGibbsContinuousToL1 U hU hp β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  exact ContinuousMap.toLp_denseRange ℝ (textbookConfigurationTorusGibbsMeasure U β) ℝ (by norm_num)

/-- The same actual continuous inclusion has exactly the original Gibbs integral of the absolute value as its L1 norm. -/
theorem textbookGibbsContinuousToL1_norm (F : C(UnitAddTorus (Fin N), ℝ)) :
    ‖textbookGibbsContinuousToL1 U hU hp β F‖ =
      ∫ Q, |F Q| ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [L1.norm_def, ← integral_norm_eq_lintegral_enorm (Lp.aestronglyMeasurable _)]
  apply integral_congr_ae
  filter_upwards [textbookGibbsContinuousToL1_ae_eq U hU hp β F] with Q hQ
  rw [hQ, Real.norm_eq_abs]

include hB in
/-- The norm of an actual original Brownian probability expectation is dominated by the actual probability expectation of the norm. -/
theorem textbookBrownianTorusProbabilityOperator_norm_expectation (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) (Q : UnitAddTorus (Fin N)) :
    ‖textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q‖ ≤
      textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t
        ⟨fun X ↦ ‖F X‖, F.continuous.norm⟩ Q := by
  rw [textbookBrownianTorusProbabilityOperator_apply, textbookBrownianTorusProbabilityOperator_apply]
  change ‖∫ X, F X ∂textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t Q‖ ≤
    ∫ X, ‖F X‖ ∂textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t Q
  exact norm_integral_le_integral_norm _

include hB in
/-- Actual original Gibbs invariance turns the genuine kernel norm inequality into the original L1 integral contraction. -/
theorem textbookBrownianTorusProbabilityOperator_L1_integral_le (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, |textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q|
      ∂textbookConfigurationTorusGibbsMeasure U β) ≤
      ∫ Q, |F Q| ∂textbookConfigurationTorusGibbsMeasure U β := by
  let μ := textbookConfigurationTorusGibbsMeasure U β
  have : IsProbabilityMeasure μ := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  let PF := textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F
  let A : C(UnitAddTorus (Fin N), ℝ) := ⟨fun Q ↦ ‖F Q‖, F.continuous.norm⟩
  let PA := textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t A
  have hiF : Integrable (fun Q ↦ ‖PF Q‖) μ :=
    PF.continuous.norm.integrable_of_hasCompactSupport (HasCompactSupport.of_compactSpace _)
  have hiA : Integrable (fun Q ↦ PA Q) μ :=
    PA.continuous.integrable_of_hasCompactSupport (HasCompactSupport.of_compactSpace _)
  have hh : (∫ Q, ‖PF Q‖ ∂μ) ≤ ∫ Q, PA Q ∂μ :=
    integral_mono hiF hiA (fun Q ↦
      textbookBrownianTorusProbabilityOperator_norm_expectation m hm U hU hp β hβ B P hB t F Q)
  have he := textbookBrownianTorusProbabilityOperator_Gibbs_integral m hm U hU hp β hβ B P hB t A
  change (∫ Q, PA Q ∂μ) = ∫ Q, ‖F Q‖ ∂μ at he
  rw [he] at hh
  simpa only [Real.norm_eq_abs] using hh

include hB in
/-- The genuine continuous probability image is bounded by the actual input L1 norm, not only the uniform norm. -/
theorem textbookBrownianProbabilityGibbsL1_input_norm_le (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    ‖textbookGibbsContinuousToL1 U hU hp β
      (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F)‖ ≤
      ‖textbookGibbsContinuousToL1 U hU hp β F‖ := by
  rw [textbookGibbsContinuousToL1_norm, textbookGibbsContinuousToL1_norm]
  exact textbookBrownianTorusProbabilityOperator_L1_integral_le m hm U hU hp β hβ B P hB t F

/-- The actual whole Gibbs L1 probability operator is the proved bounded extension of its genuine continuous input images. -/
def textbookBrownianGibbsL1ProbabilityOperator (t : ℝ≥0) :
    Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) →L[ℝ]
      Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) :=
  ((textbookGibbsContinuousToL1 U hU hp β).comp
    (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t)).toLinearMap.extendOfNorm
      (textbookGibbsContinuousToL1 U hU hp β).toLinearMap

include hB in
/-- The whole original L1 extension agrees with the same original Brownian probability expectation on every continuous test. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_spec (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
      (textbookGibbsContinuousToL1 U hU hp β F) =
      textbookGibbsContinuousToL1 U hU hp β
        (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F) := by
  apply LinearMap.extendOfNorm_eq
    (textbookGibbsContinuousToL1_denseRange U hU hp β)
  exact ⟨1, fun G ↦ by
    change ‖textbookGibbsContinuousToL1 U hU hp β
      (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t G)‖ ≤
        1 * ‖textbookGibbsContinuousToL1 U hU hp β G‖
    simpa only [one_mul] using
      textbookBrownianProbabilityGibbsL1_input_norm_le m hm U hU hp β hβ B P hB t G⟩

include hB in
/-- The actual probability extension is contractive on the entire original Gibbs L1. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_norm_le_one (t : ℝ≥0) :
    ‖textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t‖ ≤ 1 := by
  apply LinearMap.opNorm_extendOfNorm_le
    (textbookGibbsContinuousToL1_denseRange U hU hp β) zero_le_one
  intro F
  change ‖textbookGibbsContinuousToL1 U hU hp β
    (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F)‖ ≤
      1 * ‖textbookGibbsContinuousToL1 U hU hp β F‖
  simpa only [one_mul] using
    textbookBrownianProbabilityGibbsL1_input_norm_le m hm U hU hp β hβ B P hB t F


include hB in
/-- Every entire original L1 input satisfies the true actual probability contraction. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_norm_apply_le (t : ℝ≥0)
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    ‖textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t x‖ ≤ ‖x‖ := by
  calc
    _ ≤ ‖textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t‖ * ‖x‖ :=
      ContinuousLinearMap.le_opNorm _ x
    _ ≤ 1 * ‖x‖ := mul_le_mul_of_nonneg_right
      (textbookBrownianGibbsL1ProbabilityOperator_norm_le_one m hm U hU hp β hβ B P hB t) (norm_nonneg x)
    _ = _ := one_mul _

include hB in
/-- The actual entire original Gibbs L1 extension begins at the full-space identity. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_zero :
    textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB 0 =
      ContinuousLinearMap.id ℝ (Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) := by
  let A := textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB 0
  let R := ContinuousLinearMap.id ℝ (Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
  have he : (A : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) → _) = R :=
    (textbookGibbsContinuousToL1_denseRange U hU hp β).equalizer A.continuous R.continuous (by
      funext F
      simp only [Function.comp_apply, A, R, textbookBrownianGibbsL1ProbabilityOperator_spec,
        textbookBrownianTorusProbabilityOperator_zero, ContinuousLinearMap.id_apply])
  apply ContinuousLinearMap.ext
  intro x
  exact congr_fun he x

include hB in
/-- The genuine original L1 probability extensions obey the same entire-input semigroup law. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_add (s t : ℝ≥0) :
    textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB (s + t) =
      (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB s).comp
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t) := by
  let A := textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB (s + t)
  let R := (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB s).comp
    (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t)
  have he : (A : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) → _) = R :=
    (textbookGibbsContinuousToL1_denseRange U hU hp β).equalizer A.continuous R.continuous (by
      funext F
      simp only [Function.comp_apply, A, R, ContinuousLinearMap.comp_apply,
        textbookBrownianGibbsL1ProbabilityOperator_spec, textbookBrownianTorusProbabilityOperator_add])
  apply ContinuousLinearMap.ext
  intro x
  exact congr_fun he x

include hB in
/-- Dense genuine continuous tests and the uniform actual L1 contraction give the true C0 limit for every entire original Gibbs L1 input. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_c0
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    Tendsto (fun t : ℝ≥0 ↦ textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t x)
      (𝓝 0) (𝓝 x) := by
  let J := textbookGibbsContinuousToL1 U hU hp β
  let A := textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB
  apply Metric.tendsto_nhds.mpr
  intro ε hε
  obtain ⟨F, hF⟩ := (textbookGibbsContinuousToL1_denseRange U hU hp β).exists_dist_lt x
    (show 0 < ε / 4 by positivity)
  have hcore : Tendsto (fun t : ℝ≥0 ↦ A t (J F)) (𝓝 0) (𝓝 (J F)) := by
    have hc := J.continuous.tendsto F |>.comp
      (textbookBrownianTorusProbabilityOperator_c0 m hm U hU hp β hβ B P hB F)
    simpa only [Function.comp_def, J, A, textbookBrownianGibbsL1ProbabilityOperator_spec] using hc
  have ht := Metric.tendsto_nhds.mp hcore (ε / 2) (by positivity)
  filter_upwards [ht] with t ht
  have hb : dist (A t x) (A t (J F)) ≤ dist x (J F) := by
    rw [dist_eq_norm, dist_eq_norm, ← map_sub]
    exact textbookBrownianGibbsL1ProbabilityOperator_norm_apply_le m hm U hU hp β hβ B P hB t (x - J F)
  have h1 := dist_triangle (A t x) (A t (J F)) x
  have h2 := dist_triangle (A t (J F)) (J F) x
  have hF' : dist (J F) x < ε / 4 := by simpa only [J, dist_comm] using hF
  change dist (A t x) x < ε
  linarith
end
end MolecularDynamics
