import MolecularDynamics.Chapter06.BrownianL1ProbabilitySemigroup

/-! Actual integrable initial densities: original Gibbs integral duality for the
same whole L1 probability evolution, rather than a new abstract model. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal InnerProductSpace

namespace MolecularDynamics
noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

private theorem pairing_integrable (F : C(UnitAddTorus (Fin N), ℝ))
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    Integrable (fun Q ↦ F Q * x Q) (textbookConfigurationTorusGibbsMeasure U β) :=
  (L1.integrable_coeFn x).bdd_mul F.continuous.aestronglyMeasurable
    (Eventually.of_forall fun Q ↦ F.norm_coe_le_norm Q)

private def pairingLinear (F : C(UnitAddTorus (Fin N), ℝ)) :
    Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) →ₗ[ℝ] ℝ where
  toFun x := ∫ Q, F Q * x Q ∂textbookConfigurationTorusGibbsMeasure U β
  map_add' x y := by
    calc
      _ = ∫ Q, F Q * x Q + F Q * y Q ∂textbookConfigurationTorusGibbsMeasure U β := by
        apply integral_congr_ae
        filter_upwards [Lp.coeFn_add x y] with Q hQ
        change F Q * (x + y) Q = F Q * x Q + F Q * y Q
        rw [hQ]
        simp only [Pi.add_apply]
        ring
      _ = _ := integral_add (pairing_integrable U β F x) (pairing_integrable U β F y)
  map_smul' c x := by
    calc
      _ = ∫ Q, c • (F Q * x Q) ∂textbookConfigurationTorusGibbsMeasure U β := by
        apply integral_congr_ae
        filter_upwards [Lp.coeFn_smul c x] with Q hQ
        change F Q * (c • x) Q = c • (F Q * x Q)
        rw [hQ]
        simp only [Pi.smul_apply, smul_eq_mul]
        ring
      _ = _ := integral_smul c _

private theorem pairing_norm_le (F : C(UnitAddTorus (Fin N), ℝ))
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    ‖pairingLinear U β F x‖ ≤ ‖F‖ * ‖x‖ := by
  calc
    _ ≤ ∫ Q, ‖F Q * x Q‖ ∂textbookConfigurationTorusGibbsMeasure U β :=
      norm_integral_le_integral_norm _
    _ ≤ ∫ Q, ‖F‖ * ‖x Q‖ ∂textbookConfigurationTorusGibbsMeasure U β := by
      apply integral_mono (pairing_integrable U β F x).norm ((L1.integrable_coeFn x).norm.const_mul ‖F‖)
      intro Q
      dsimp only
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right (F.norm_coe_le_norm Q) (norm_nonneg _)
    _ = _ := by rw [integral_const_mul, ← L1.norm_eq_integral_norm x]

private def pairing (F : C(UnitAddTorus (Fin N), ℝ)) :
    Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) →L[ℝ] ℝ :=
  (pairingLinear U β F).mkContinuous ‖F‖ (pairing_norm_le U β F)

include hB in
/-- The actual original continuous Brownian expectations are symmetric for the same true Gibbs integral. -/
theorem textbookBrownianTorusProbabilityOperator_Gibbs_duality (t : ℝ≥0)
    (F G : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, F Q * textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t G Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q * G Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  let J := textbookGibbsContinuousToLp U hU hp β
  let T := textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
  let PF := textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F
  let PG := textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t G
  have hF : T (J F) = J PF :=
    (textbookBrownianProbabilityGibbsL2Image_eq_spectral m hm U hU hp β hβ B P hB t F).symm
  have hG : T (J G) = J PG :=
    (textbookBrownianProbabilityGibbsL2Image_eq_spectral m hm U hU hp β hβ B P hB t G).symm
  calc
    _ = ∫ Q, (J F) Q * (T (J G)) Q ∂textbookConfigurationTorusGibbsMeasure U β := by
      rw [hG]
      apply integral_congr_ae
      filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hp β F,
        textbookGibbsContinuousToLp_ae_eq U hU hp β PG] with Q hQ hR
      rw [hQ, hR]
    _ = ∫ Q, (T (J F)) Q * (J G) Q ∂textbookConfigurationTorusGibbsMeasure U β :=
      textbookBrownianGibbsSpectralEvolution_integral_duality m hm U hU hp β hβ t (J G) (J F)
    _ = _ := by
      rw [hF]
      apply integral_congr_ae
      filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hp β PF,
        textbookGibbsContinuousToLp_ae_eq U hU hp β G] with Q hQ hR
      rw [hQ, hR]

include hB in
/-- The actual whole original Gibbs L1 evolution satisfies true density-observable integral duality for every entire integrable input. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_integral_duality (t : ℝ≥0)
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, F Q * (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t x) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q * x Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  let A := textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t
  let PF := textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F
  let L := (pairing U β F).comp A
  let R := pairing U β PF
  have he : (L : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β) → ℝ) = R :=
    (textbookGibbsContinuousToL1_denseRange U hU hp β).equalizer L.continuous R.continuous (by
      funext G
      change (∫ Q, F Q * (A (textbookGibbsContinuousToL1 U hU hp β G)) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) =
        ∫ Q, PF Q * (textbookGibbsContinuousToL1 U hU hp β G) Q ∂textbookConfigurationTorusGibbsMeasure U β
      rw [textbookBrownianGibbsL1ProbabilityOperator_spec]
      calc
        _ = ∫ Q, F Q * textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t G Q
            ∂textbookConfigurationTorusGibbsMeasure U β := by
          apply integral_congr_ae
          filter_upwards [textbookGibbsContinuousToL1_ae_eq U hU hp β
            (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t G)] with Q hQ
          rw [hQ]
        _ = ∫ Q, PF Q * G Q ∂textbookConfigurationTorusGibbsMeasure U β :=
          textbookBrownianTorusProbabilityOperator_Gibbs_duality m hm U hU hp β hβ B P hB t F G
        _ = _ := by
          apply integral_congr_ae
          filter_upwards [textbookGibbsContinuousToL1_ae_eq U hU hp β G] with Q hQ
          rw [hQ])
  exact congr_fun he x

include hB in
private theorem probability_one (t : ℝ≥0) :
    textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t
      (ContinuousMap.const (UnitAddTorus (Fin N)) (1 : ℝ)) =
    ContinuousMap.const (UnitAddTorus (Fin N)) (1 : ℝ) := by
  have := textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hp β hβ B P hB t
  ext Q
  change (∫ _X, (1 : ℝ) ∂textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t Q) = 1
  simp

include hB in
/-- The actual original probability extension preserves the genuine Gibbs integral of every entire L1 input. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_integral_mass (t : ℝ≥0)
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    (∫ Q, (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t x) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, x Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  have hh := textbookBrownianGibbsL1ProbabilityOperator_integral_duality m hm U hU hp β hβ B P hB t x
    (ContinuousMap.const (UnitAddTorus (Fin N)) (1 : ℝ))
  rw [probability_one m hm U hU hp β hβ B P hB t] at hh
  simpa only [ContinuousMap.const_apply, one_mul] using hh

/-- The genuine measure of an entire original Gibbs L1 relative density. -/
def textbookBrownianInitialL1DensityMeasure
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    Measure (UnitAddTorus (Fin N)) :=
  (textbookConfigurationTorusGibbsMeasure U β).withDensity (fun Q ↦ ENNReal.ofReal (ρ Q))

/-- Actual nonnegative density with true unit integral defines a probability measure. -/
theorem textbookBrownianInitialL1DensityMeasure_isProbabilityMeasure
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    IsProbabilityMeasure (textbookBrownianInitialL1DensityMeasure U β ρ) := by
  apply isProbabilityMeasure_iff.mpr
  unfold textbookBrownianInitialL1DensityMeasure
  rw [withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ,
    ← ofReal_integral_eq_lintegral_ofReal
      (L1.integrable_coeFn ρ) hρpos, hρmass]
  simp

/-- Every real observable integral against the true initial density is its original Gibbs weighted integral. -/
theorem textbookBrownianInitialL1DensityMeasure_integral
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (F : UnitAddTorus (Fin N) → ℝ) :
    (∫ Q, F Q ∂textbookBrownianInitialL1DensityMeasure U β ρ) =
      ∫ Q, F Q * ρ Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  unfold textbookBrownianInitialL1DensityMeasure
  rw [integral_withDensity_eq_integral_toReal_smul
    (Lp.stronglyMeasurable ρ).measurable.ennreal_ofReal
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)]
  apply integral_congr_ae
  filter_upwards [hρpos] with Q hQ
  simp only [ENNReal.toReal_ofReal hQ, smul_eq_mul, mul_comm]

/-- The time-t distribution is the original actual Brownian Markov kernel applied to the genuine initial density measure. -/
def textbookBrownianL1DensityLaw
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) (t : ℝ≥0) :
    Measure (UnitAddTorus (Fin N)) :=
  textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t ∘ₘ
    textbookBrownianInitialL1DensityMeasure U β ρ

include hB in
/-- The actual time-t density law is a genuine probability at every nonnegative time. -/
theorem textbookBrownianL1DensityLaw_isProbabilityMeasure
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    IsProbabilityMeasure (textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t) := by
  have := textbookBrownianInitialL1DensityMeasure_isProbabilityMeasure U β ρ hρpos hρmass
  have := textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hp β hβ B P hB t
  unfold textbookBrownianL1DensityLaw
  infer_instance

include hB in
/-- Actual distribution expectations equal the actual evolved observable against the true initial Gibbs relative density. -/
theorem textbookBrownianL1DensityLaw_integral_probability
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, F Q ∂textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t) =
      ∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q * ρ Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  let κ := textbookBrownianTorusTransitionKernel m hm U hU hp β hβ B P t
  let ν := textbookBrownianInitialL1DensityMeasure U β ρ
  have : IsProbabilityMeasure ν :=
    textbookBrownianInitialL1DensityMeasure_isProbabilityMeasure U β ρ hρpos hρmass
  have : IsMarkovKernel κ :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hp β hβ B P hB t
  have hi : Integrable (fun Q ↦ F Q) (κ ∘ₘ ν) :=
    (integrable_const ‖F‖).mono' F.continuous.aestronglyMeasurable
      (Eventually.of_forall fun Q ↦ F.norm_coe_le_norm Q)
  change (∫ Q, F Q ∂(κ ∘ₘ ν)) = _
  rw [Measure.comp_eq_comp_const_apply] at hi ⊢
  rw [Kernel.integral_comp hi, Kernel.const_apply]
  change (∫ Q, textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F Q
    ∂textbookBrownianInitialL1DensityMeasure U β ρ) = _
  exact textbookBrownianInitialL1DensityMeasure_integral U β ρ hρpos _



private theorem positive_part_identity (r : ℝ) :
    (ENNReal.ofReal r).toReal = r + (ENNReal.ofReal (-r)).toReal := by
  by_cases hr : 0 ≤ r
  · rw [ENNReal.toReal_ofReal hr, ENNReal.ofReal_eq_zero.mpr (by linarith),
      ENNReal.toReal_zero, add_zero]
  · have hnr : 0 ≤ -r := by linarith
    rw [ENNReal.ofReal_eq_zero.mpr (by linarith), ENNReal.toReal_zero,
      ENNReal.toReal_ofReal hnr]
    ring

private theorem density_measure_from_expectations
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (ν : Measure (UnitAddTorus (Fin N))) [IsFiniteMeasure ν]
    (he : ∀ F : C(UnitAddTorus (Fin N), ℝ),
      (∫ Q, F Q ∂ν) = ∫ Q, F Q * x Q ∂textbookConfigurationTorusGibbsMeasure U β) :
    ν = textbookBrownianInitialL1DensityMeasure U β x ∧
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] x := by
  let μ := textbookConfigurationTorusGibbsMeasure U β
  let νp := μ.withDensity (fun Q ↦ ENNReal.ofReal (x Q))
  let νn := μ.withDensity (fun Q ↦ ENNReal.ofReal (-x Q))
  have hx : Integrable (x : UnitAddTorus (Fin N) → ℝ) μ :=
    L1.integrable_coeFn x
  have hxm : Measurable (x : UnitAddTorus (Fin N) → ℝ) :=
    (Lp.stronglyMeasurable x).measurable
  have : IsFiniteMeasure νp := isFiniteMeasure_withDensity_ofReal hx.hasFiniteIntegral
  have : IsFiniteMeasure νn := isFiniteMeasure_withDensity_ofReal hx.neg.hasFiniteIntegral
  have hxmneg : Measurable (fun Q ↦ -x Q) := hxm.neg
  have hparts : ν + νn = νp := by
    apply Measure.ext_of_integral_eq_on_compactlySupported
    intro F
    rw [integral_add_measure F.integrable F.integrable]
    change (∫ Q, F.toContinuousMap Q ∂ν) + (∫ Q, F Q ∂νn) = ∫ Q, F Q ∂νp
    rw [he F.toContinuousMap]
    have hneg : Integrable (fun Q ↦ (ENNReal.ofReal (-x Q)).toReal * F Q) μ := by
      simpa only [smul_eq_mul] using
        (integrable_withDensity_iff_integrable_smul' hxmneg.ennreal_ofReal
          (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)).mp
          (show Integrable (fun Q ↦ F Q) νn from F.integrable)
    have hprod : Integrable (fun Q ↦ F Q * x Q) μ :=
      hx.bdd_mul F.continuous.aestronglyMeasurable
        (Eventually.of_forall fun Q ↦ F.toContinuousMap.norm_coe_le_norm Q)
    change (∫ Q, F Q * x Q ∂μ) + (∫ Q, F Q ∂μ.withDensity (fun Q ↦ ENNReal.ofReal (-x Q))) =
      ∫ Q, F Q ∂μ.withDensity (fun Q ↦ ENNReal.ofReal (x Q))
    rw [integral_withDensity_eq_integral_toReal_smul hxmneg.ennreal_ofReal
      (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top),
      integral_withDensity_eq_integral_toReal_smul hxm.ennreal_ofReal
        (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)]
    simp only [smul_eq_mul]
    rw [← integral_add hprod hneg]
    apply integral_congr_ae
    exact Eventually.of_forall fun Q ↦ by
      dsimp only
      rw [positive_part_identity (x Q)]
      ring
  have hle : νn ≤ νp := by
    rw [← hparts]
    exact Measure.le_add_left le_rfl
  have hnzero : νn = 0 :=
    Measure.eq_zero_of_absolutelyContinuous_of_mutuallySingular hle.absolutelyContinuous
      (withDensity_ofReal_mutuallySingular hxm).symm
  have hnonneg : 0 ≤ᵐ[μ] x := by
    have hz := (withDensity_eq_zero_iff hxmneg.ennreal_ofReal.aemeasurable).mp hnzero
    filter_upwards [hz] with Q hQ
    have hr : -x Q ≤ 0 := ENNReal.ofReal_eq_zero.mp hQ
    change 0 ≤ x Q
    linarith
  refine ⟨?_, hnonneg⟩
  change ν = νp
  simpa only [hnzero, add_zero] using hparts




include hB in
/-- The true original Brownian law expectation is exactly the actual whole-L1 evolved density pairing for every integrable initial probability density. -/
theorem textbookBrownianL1DensityLaw_integral_evolution
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    (∫ Q, F Q ∂textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t) =
      ∫ Q, F Q * (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookBrownianL1DensityLaw_integral_probability m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact (textbookBrownianGibbsL1ProbabilityOperator_integral_duality m hm U hU hp β hβ B P hB t ρ F).symm

include hB in
/-- The actual original kernel-evolved law equals the true density measure of the same actual entire L1 evolution. -/
theorem textbookBrownianL1DensityLaw_eq_evolvedDensityMeasure
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t =
      textbookBrownianInitialL1DensityMeasure U β
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) := by
  have := textbookBrownianL1DensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t
  exact (density_measure_from_expectations U β
    (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ)
    (textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t)
    (fun F ↦ textbookBrownianL1DensityLaw_integral_evolution m hm U hU hp β hβ B P hB ρ hρpos hρmass t F)).1

include hB in
/-- The same actual entire Gibbs L1 evolution preserves genuine probability-density nonnegativity, proved from its actual original law. -/
theorem textbookBrownianGibbsL1ProbabilityOperator_density_nonnegative
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ := by
  have := textbookBrownianL1DensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t
  exact (density_measure_from_expectations U β
    (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ)
    (textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t)
    (fun F ↦ textbookBrownianL1DensityLaw_integral_evolution m hm U hU hp β hβ B P hB ρ hρpos hρmass t F)).2

/-- Formula (5.6) applied to the genuine original law of an integrable initial probability density. -/
def textbookBrownianL1DensityAverage
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) : ℝ :=
  (∫ Q, F Q ∂textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t) /
    (∫ _Q, (1 : ℝ) ∂textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t)

include hB in
/-- True probability normalization connects the actual (5.6) average to the same whole-L1 evolved density pairing. -/
theorem textbookBrownianL1DensityAverage_eq_evolution
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianL1DensityAverage m hm U hU hp β hβ B P ρ t F =
      ∫ Q, F Q * (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q
        ∂textbookConfigurationTorusGibbsMeasure U β := by
  have := textbookBrownianL1DensityLaw_isProbabilityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass t
  unfold textbookBrownianL1DensityAverage
  simp only [integral_const, probReal_univ, one_smul, div_one]
  exact textbookBrownianL1DensityLaw_integral_evolution m hm U hU hp β hβ B P hB ρ hρpos hρmass t F

private abbrev gibbsHaarWeight (Q : UnitAddTorus (Fin N)) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q

include hU in
private theorem gibbsHaarWeight_positive (Q : UnitAddTorus (Fin N)) :
    0 < gibbsHaarWeight U β Q :=
  mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β)) (Real.exp_pos _)

include hU in
private theorem gibbsHaarWeight_measurable :
    Measurable (gibbsHaarWeight U β) :=
  measurable_const.mul ((measurable_const.mul
    (textbookConfigurationTorusObservable_measurable U hU.continuous)).exp)

include hU in
private theorem haar_absolutelyContinuous_gibbs :
    (volume : Measure (UnitAddTorus (Fin N))) ≪ textbookConfigurationTorusGibbsMeasure U β := by
  change volume ≪ volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))
  apply withDensity_absolutelyContinuous' (gibbsHaarWeight_measurable U hU β).ennreal_ofReal.aemeasurable
  exact Eventually.of_forall fun Q ↦ ne_of_gt
    (ENNReal.ofReal_pos.mpr (gibbsHaarWeight_positive U hU β Q))

/-- The physical density against the original flat torus Haar reference measure is the true Gibbs weight times the relative Gibbs density. -/
def textbookBrownianGibbsL1ToHaarDensity
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (Q : UnitAddTorus (Fin N)) : ℝ :=
  gibbsHaarWeight U β Q * x Q

include hU in
/-- The true flat-reference density is measurably constructed from the original Gibbs L1 representative. -/
theorem textbookBrownianGibbsL1ToHaarDensity_measurable
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    Measurable (textbookBrownianGibbsL1ToHaarDensity U β x) :=
  (gibbsHaarWeight_measurable U hU β).mul (Lp.stronglyMeasurable x).measurable

include hU in
/-- Strict positivity of the original Gibbs weight transfers nonnegativity to the actual Haar density. -/
theorem textbookBrownianGibbsL1ToHaarDensity_nonnegative
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hx : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] x) :
    0 ≤ᵐ[volume] textbookBrownianGibbsL1ToHaarDensity U β x := by
  have hxhaar : 0 ≤ᵐ[(volume : Measure (UnitAddTorus (Fin N)))] x :=
    (Measure.ae_le_iff_absolutelyContinuous.mpr (haar_absolutelyContinuous_gibbs U hU β)) hx
  filter_upwards [hxhaar] with Q hQ
  change 0 ≤ gibbsHaarWeight U β Q * x Q
  exact mul_nonneg (gibbsHaarWeight_positive U hU β Q).le hQ

include hU in
/-- The original Gibbs-relative density measure is precisely the flat Haar measure with its genuine physical density. -/
theorem textbookBrownianGibbsL1ToHaarDensity_measure
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    textbookBrownianInitialL1DensityMeasure U β x =
      volume.withDensity (fun Q ↦ ENNReal.ofReal (textbookBrownianGibbsL1ToHaarDensity U β x Q)) := by
  change (volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))).withDensity
      (fun Q ↦ ENNReal.ofReal (x Q)) =
    volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q * x Q))
  rw [← withDensity_mul volume (gibbsHaarWeight_measurable U hU β).ennreal_ofReal
    (Lp.stronglyMeasurable x).measurable.ennreal_ofReal]
  apply withDensity_congr_ae
  exact Eventually.of_forall fun Q ↦ (ENNReal.ofReal_mul
    (gibbsHaarWeight_positive U hU β Q).le).symm

include hU in
/-- The actual Gibbs density pairing is exactly the original flat-reference physical-density integral. -/
theorem textbookBrownianGibbsL1ToHaarDensity_integral
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (F : UnitAddTorus (Fin N) → ℝ) :
    (∫ Q, F Q * x Q ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, F Q * textbookBrownianGibbsL1ToHaarDensity U β x Q := by
  change (∫ Q, F Q * x Q ∂volume.withDensity
    (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))) =
    ∫ Q, F Q * (gibbsHaarWeight U β Q * x Q)
  rw [integral_withDensity_eq_integral_toReal_smul
    (gibbsHaarWeight_measurable U hU β).ennreal_ofReal
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)]
  simp_rw [ENNReal.toReal_ofReal (gibbsHaarWeight_positive U hU β _).le, smul_eq_mul]
  apply integral_congr_ae
  exact Eventually.of_forall fun Q ↦ by ring

include hU in
/-- Every original Gibbs L1 representative gives a genuinely Haar-integrable physical density. -/
theorem textbookBrownianGibbsL1ToHaarDensity_integrable
    (x : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β)) :
    Integrable (textbookBrownianGibbsL1ToHaarDensity U β x) := by
  have hx := L1.integrable_coeFn x
  change Integrable (x : UnitAddTorus (Fin N) → ℝ)
    (volume.withDensity (fun Q ↦ ENNReal.ofReal (gibbsHaarWeight U β Q))) at hx
  have hh := (integrable_withDensity_iff_integrable_smul'
    (gibbsHaarWeight_measurable U hU β).ennreal_ofReal
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top)).mp hx
  simp_rw [ENNReal.toReal_ofReal (gibbsHaarWeight_positive U hU β _).le, smul_eq_mul] at hh
  exact hh

include hB in
/-- The original actual time-t Brownian distribution has the true original flat-reference physical density. -/
theorem textbookBrownianL1DensityLaw_eq_HaarDensityMeasure
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    textbookBrownianL1DensityLaw m hm U hU hp β hβ B P ρ t =
      volume.withDensity (fun Q ↦ ENNReal.ofReal (textbookBrownianGibbsL1ToHaarDensity U β
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q)) := by
  rw [textbookBrownianL1DensityLaw_eq_evolvedDensityMeasure m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact textbookBrownianGibbsL1ToHaarDensity_measure U hU β _

include hB in
/-- The actual time-t flat-reference physical density is nonnegative, rather than a signed formal expression. -/
theorem textbookBrownianL1DensityLaw_HaarDensity_nonnegative
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    0 ≤ᵐ[volume] textbookBrownianGibbsL1ToHaarDensity U β
      (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) := by
  exact textbookBrownianGibbsL1ToHaarDensity_nonnegative U hU β _
    (textbookBrownianGibbsL1ProbabilityOperator_density_nonnegative m hm U hU hp β hβ B P hB ρ hρpos hρmass t)

/-- The genuine Haar density of the original actual law has integral one at every nonnegative time. -/
theorem textbookBrownianL1DensityLaw_HaarDensity_mass
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) :
    (∫ Q, textbookBrownianGibbsL1ToHaarDensity U β
      (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q) = 1 := by
  have hh := textbookBrownianGibbsL1ToHaarDensity_integral U hU β
    (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) (fun _ ↦ 1)
  simp only [one_mul] at hh
  rw [← hh, textbookBrownianGibbsL1ProbabilityOperator_integral_mass, hρmass]

include hB in
/-- Formula (5.6) for the true original Brownian time-t law is literally the quotient of observable-density and density integrals against the flat Haar reference. -/
theorem textbookBrownianL1DensityAverage_eq_HaarDensityRatio
    (ρ : Lp ℝ 1 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1)
    (t : ℝ≥0) (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianL1DensityAverage m hm U hU hp β hβ B P ρ t F =
      (∫ Q, F Q * textbookBrownianGibbsL1ToHaarDensity U β
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q) /
      (∫ Q, textbookBrownianGibbsL1ToHaarDensity U β
        (textbookBrownianGibbsL1ProbabilityOperator m hm U hU hp β hβ B P hB t ρ) Q) := by
  rw [textbookBrownianL1DensityLaw_HaarDensity_mass m hm U hU hp β hβ B P hB ρ hρmass, div_one]
  rw [textbookBrownianL1DensityAverage_eq_evolution m hm U hU hp β hβ B P hB ρ hρpos hρmass]
  exact textbookBrownianGibbsL1ToHaarDensity_integral U hU β _ F
end
end MolecularDynamics
