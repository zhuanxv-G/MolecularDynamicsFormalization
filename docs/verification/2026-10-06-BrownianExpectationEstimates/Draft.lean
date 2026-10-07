import MolecularDynamics.Chapter06.BrownianSmallTimeEstimates

/-! Actual probability expectations of the same original Wiener-driven Brownian
configuration, needed for short-time stochastic-generator identification. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

/-- One original drift bound supplies true integrability and the same actual global process's short-time displacement expectation for every initial state and time. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_expectation_bound
    {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      Integrable (fun sample ↦ textbookBrownianGlobalRandomConfiguration (Ω := Ω)
        m hm U hU hPU β hβ x B t sample - x) P ∧
      (∫ sample, ‖textbookBrownianGlobalRandomConfiguration (Ω := Ω)
        m hm U hU hPU β hβ x B t sample - x‖ ∂P) ≤
        M * t + (∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)) * Real.sqrt t := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM, hbound⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦
    textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B t sample - x
  let N : Ω → (Fin Nc → ℝ) := fun sample ↦ textbookBrownianSDENoise m β (B t.toNNReal sample)
  have ha : ∀ᵐ sample ∂P, ‖X sample‖ ≤ M * t + ‖N sample‖ := by
    filter_upwards [
      textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x,
      textbookBrownianGlobalRandomConfiguration_original_equation_ae m hm U hU hPU β hβ B P hB x]
      with sample hs he
    have hdi := (textbookBrownianIntegralSolution_drift_integral_bound m U hU hPU β t x
      (fun s ↦ B s.toNNReal sample)
      (textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B · sample)
      (hs t ht) M hbound t ⟨ht, le_rfl⟩).2
    have he' : X sample =
        (∫ s in 0..t, textbookBrownianSDEDrift m U
          (textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B s sample)) + N sample := by
      dsimp [X, N]
      rw [he t ht]
      abel
    exact he' ▸ (norm_add_le _ _).trans (add_le_add hdi le_rfl)
  have hNi : Integrable N P := textbookBrownianPhysicalNoise_integrable m β B P hB t.toNNReal
  have hdom : Integrable (fun sample ↦ M * t + ‖N sample‖) P :=
    (integrable_const (M * t)).add hNi.norm
  have hmeas : AEStronglyMeasurable X P :=
    ((textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable
      m hm U hU hPU β hβ B P hB x t ht).aestronglyMeasurable).sub aestronglyMeasurable_const
  have hXi : Integrable X P := hdom.mono' hmeas ha
  refine ⟨hXi, ?_⟩
  calc
    _ ≤ ∫ sample, M * t + ‖N sample‖ ∂P := integral_mono_ae hXi.norm hdom ha
    _ = M * t + ∫ sample, ‖N sample‖ ∂P := by
      rw [integral_add (integrable_const _) hNi.norm]
      simp
    _ ≤ M * t + (∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)) * Real.sqrt t :=
      add_le_add le_rfl (by
        simpa only [N, Real.coe_toNNReal t ht] using
          textbookBrownianPhysicalNoise_norm_mean_le m hm β hβ B P hB t.toNNReal)


variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

/-- Literal drift integral along the same actual global configuration. -/
def textbookBrownianGlobalDriftIntegral (x : Fin Nc → ℝ) (t : ℝ) (sample : Ω) : Fin Nc → ℝ :=
  ∫ s in 0..t, textbookBrownianSDEDrift m U
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)

include hB in
/-- The original equation identifies the drift integral with the actual increment minus its physical noise. -/
theorem textbookBrownianGlobalDriftIntegral_ae_eq (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t =ᵐ[P]
      fun sample ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample -
        x - textbookBrownianSDENoise m β (B t.toNNReal sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_original_equation_ae
    m hm U hU hPU β hβ B P hB x] with sample he
  dsimp [textbookBrownianGlobalDriftIntegral]
  rw [he t ht]
  abel

include hB in
/-- Actual drift integrals are integrable and have their genuine linear-time expected norm bound. -/
theorem textbookBrownianGlobalDriftIntegral_integrable_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      Integrable (textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t) P ∧
      (∫ sample, ‖textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t sample‖ ∂P) ≤ M * t := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM, hbound⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  obtain ⟨_, _, hXi⟩ := textbookBrownianGlobalRandomConfiguration_increment_expectation_bound
    m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  have hi := ((hXi x t ht).1.sub
    (textbookBrownianPhysicalNoise_integrable m β B P hB t.toNNReal)).congr
    (textbookBrownianGlobalDriftIntegral_ae_eq m hm U hU hPU β hβ B P hB x t ht).symm
  have ha : ∀ᵐ sample ∂P,
      ‖textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t sample‖ ≤ M * t := by
    filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae
      m hm U hU hPU β hβ B P hB x] with sample hs
    exact (textbookBrownianIntegralSolution_drift_integral_bound m U hU hPU β t x
      (fun s ↦ B s.toNNReal sample)
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B · sample)
      (hs t ht) M hbound t ⟨ht, le_rfl⟩).2
  refine ⟨hi, ?_⟩
  calc
    _ ≤ ∫ _ : Ω, M * t ∂P := integral_mono_ae hi.norm (integrable_const _) ha
    _ = M * t := by simp

include hB in
/-- The true physical noise has zero mean, so the actual configuration's mean increment equals its drift-integral expectation. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_mean_eq
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    (∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) =
      ∫ sample, textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t sample ∂P := by
  obtain ⟨_, _, hXi⟩ := textbookBrownianGlobalRandomConfiguration_increment_expectation_bound
    m hm U hU hPU β hβ B P hB
  have hNi := textbookBrownianPhysicalNoise_integrable m β B P hB t.toNNReal
  calc
    _ = (∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) -
        ∫ sample, textbookBrownianSDENoise m β (B t.toNNReal sample) ∂P := by
      rw [textbookBrownianPhysicalNoise_mean m β B P hB t.toNNReal, sub_zero]
    _ = ∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x -
        textbookBrownianSDENoise m β (B t.toNNReal sample) ∂P :=
      (integral_sub (hXi x t ht).1 hNi).symm
    _ = _ := integral_congr_ae
      (textbookBrownianGlobalDriftIntegral_ae_eq m hm U hU hPU β hβ B P hB x t ht).symm

include hB in
/-- The actual mean increment is of linear order, uniformly in the initial configuration. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_mean_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      ‖∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P‖ ≤ M * t := by
  obtain ⟨M, hM, hMi⟩ := textbookBrownianGlobalDriftIntegral_integrable_bound m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  rw [textbookBrownianGlobalRandomConfiguration_increment_mean_eq m hm U hU hPU β hβ B P hB x t ht]
  exact (norm_integral_le_integral_norm _).trans (hMi x t ht).2

/-- Actual expected drift, extended to negative parameters by the explicit clamp max 0 t. -/
def textbookBrownianGlobalDriftExpectation (x : Fin Nc → ℝ) (t : ℝ) : Fin Nc → ℝ :=
  ∫ sample, textbookBrownianSDEDrift m U
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B (max 0 t) sample) ∂P

include hB in
/-- The original periodic drift is genuinely integrable at every clamped time. -/
theorem textbookBrownianGlobalDriftExpectation_integrable (x : Fin Nc → ℝ) (t : ℝ) :
    Integrable (fun sample ↦ textbookBrownianSDEDrift m U
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B (max 0 t) sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hM⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  have hmeas := (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).continuous.measurable.comp_aemeasurable
    (textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB x (max 0 t) (le_max_left 0 t))
  exact (integrable_const M).mono' hmeas.aestronglyMeasurable (Eventually.of_forall fun sample ↦ hM _)

include hB in
/-- True expectation of the same process's drift is continuous, by bounded drift and genuine a.s. path continuity. -/
theorem textbookBrownianGlobalDriftExpectation_continuous (x : Fin Nc → ℝ) :
    Continuous (textbookBrownianGlobalDriftExpectation m hm U hU hPU β hβ B P x) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hM⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  apply continuous_of_dominated (bound := fun _ : Ω ↦ M)
  · intro t
    exact (textbookBrownianGlobalDriftExpectation_integrable m hm U hU hPU β hβ B P hB x t).aestronglyMeasurable
  · intro t
    exact Eventually.of_forall fun sample ↦ hM _
  · exact integrable_const M
  · filter_upwards [textbookBrownianGlobalRandomConfiguration_continuousOn_ae
      m hm U hU hPU β hβ B P hB x] with sample hs
    exact (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).continuous.comp
      (hs.comp_continuous (continuous_const.max continuous_id) fun t ↦ le_max_left 0 t)

include hB in
/-- The genuine zero-time expected drift is exactly the original drift at the initial configuration. -/
theorem textbookBrownianGlobalDriftExpectation_zero (x : Fin Nc → ℝ) :
    textbookBrownianGlobalDriftExpectation m hm U hU hPU β hβ B P x 0 = textbookBrownianSDEDrift m U x := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  simp only [textbookBrownianGlobalDriftExpectation, max_self,
    textbookBrownianGlobalRandomConfiguration_initial]
  simp


include hB in
/-- Joint time/sample measurability of the actual drift, proved from the genuine finite-history path law and continuous endpoint. -/
theorem textbookBrownianGlobalDriftIntegral_joint_aestronglyMeasurable
    (x : Fin Nc → ℝ) (T : ℝ) (hT : 0 ≤ T) :
    AEStronglyMeasurable (fun z : ℝ × Ω ↦ textbookBrownianSDEDrift m U
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B z.1 z.2))
      ((volume.restrict (uIoc 0 T)).prod P) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let ν : Measure ℝ := volume.restrict (uIoc 0 T)
  have hW := textbookWienerVectorContinuousPath_aemeasurable B P hB T
  have hc : Continuous (fun z : ((Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ)) × Icc 0 T ↦
      textbookBrownianSDEDrift m U
        (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1.1 z.2 z.1.2)) :=
    (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).continuous.comp
      (textbookBrownianPathEndpoint_joint_time_continuous m hm U hU hPU β hβ T hT)
  have hmz : Measurable (fun z : ℝ × Ω ↦
      ((x, hW.mk (textbookWienerVectorContinuousPath B T) z.2), projIcc 0 T hT z.1)) :=
    (measurable_const.prodMk (hW.measurable_mk.comp measurable_snd)).prodMk
      ((continuous_projIcc (a := (0 : ℝ)) (b := T) (h := hT)).measurable.comp measurable_fst)
  have hmodel := hc.stronglyMeasurable.comp_measurable hmz
  apply hmodel.aestronglyMeasurable.congr
  have hhist := (Measure.quasiMeasurePreserving_snd (μ := ν) (ν := P)).tendsto_ae.eventually
    (textbookBrownianGlobalRandomConfiguration_history_path_ae m hm U hU hPU β hβ B P hB x)
  have hpath := (Measure.quasiMeasurePreserving_snd (μ := ν) (ν := P)).tendsto_ae.eventually hW.ae_eq_mk
  have htime := (Measure.quasiMeasurePreserving_fst (μ := ν) (ν := P)).tendsto_ae.eventually
    (ae_restrict_mem measurableSet_uIoc)
  filter_upwards [hhist, hpath, htime] with z hs hw hz
  have hz' : z.1 ∈ Icc 0 T := by
    rw [uIoc_of_le hT] at hz
    exact ⟨hz.1.le, hz.2⟩
  have hp : (projIcc 0 T hT z.1 : ℝ) = z.1 := by
    change max 0 (min T z.1) = z.1
    exact (congrArg (max (0 : ℝ)) (min_eq_right hz'.2)).trans (max_eq_right hz'.1)
  change textbookBrownianSDEDrift m U
      (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x
        (projIcc 0 T hT z.1) (hW.mk (textbookWienerVectorContinuousPath B T) z.2)) = _
  rw [hp, ← hw]
  exact congrArg (textbookBrownianSDEDrift m U) (hs T hT z.1 hz').symm

include hB in
/-- The actual drift is genuinely product-integrable over finite time and the original probability space. -/
theorem textbookBrownianGlobalDriftIntegral_joint_integrable
    (x : Fin Nc → ℝ) (T : ℝ) (hT : 0 ≤ T) :
    Integrable (fun z : ℝ × Ω ↦ textbookBrownianSDEDrift m U
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B z.1 z.2))
      ((volume.restrict (uIoc 0 T)).prod P) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsFiniteMeasure (volume.restrict (uIoc 0 T)) := by
    rw [uIoc_of_le hT]
    infer_instance
  obtain ⟨M, _, hM⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  exact (integrable_const M).mono'
    (textbookBrownianGlobalDriftIntegral_joint_aestronglyMeasurable m hm U hU hPU β hβ B P hB x T hT)
    (Eventually.of_forall fun z ↦ hM _)

include hB in
/-- Genuine product integrability justifies Fubini for the same original drift integral and its true probability expectation. -/
theorem textbookBrownianGlobalDriftIntegral_expectation_fubini
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    (∫ sample, textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t sample ∂P) =
      ∫ s in 0..t, textbookBrownianGlobalDriftExpectation m hm U hU hPU β hβ B P x s := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  calc
    _ = ∫ s in 0..t, ∫ sample, textbookBrownianSDEDrift m U
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample) ∂P :=
      (intervalIntegral_integral_swap
        (textbookBrownianGlobalDriftIntegral_joint_integrable m hm U hU hPU β hβ B P hB x t ht)).symm
    _ = _ := by
      apply intervalIntegral.integral_congr
      intro s hs
      rw [uIcc_of_le ht] at hs
      simp only [textbookBrownianGlobalDriftExpectation, max_eq_right hs.1]

include hB in
/-- The actual mean increment is the time integral of the true expected original drift. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_mean_integral
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    (∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) =
      ∫ s in 0..t, textbookBrownianGlobalDriftExpectation m hm U hU hPU β hβ B P x s :=
  (textbookBrownianGlobalRandomConfiguration_increment_mean_eq m hm U hU hPU β hβ B P hB x t ht).trans
    (textbookBrownianGlobalDriftIntegral_expectation_fubini m hm U hU hPU β hβ B P hB x t ht)

include hB in
/-- The actual configuration's mean has the original drift as its genuine right derivative at zero. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_mean_right_deriv
    (x : Fin Nc → ℝ) :
    HasDerivWithinAt (fun t : ℝ ↦ ∫ sample,
      textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P)
      (textbookBrownianSDEDrift m U x) (Ici 0) 0 := by
  have hc := textbookBrownianGlobalDriftExpectation_continuous m hm U hU hPU β hβ B P hB x
  have hd := intervalIntegral.integral_hasDerivAt_right
    (hc.intervalIntegrable (μ := volume) 0 0) hc.stronglyMeasurable.stronglyMeasurableAtFilter hc.continuousAt
  have hd' : HasDerivAt (fun t : ℝ ↦ ∫ s in 0..t,
      textbookBrownianGlobalDriftExpectation m hm U hU hPU β hβ B P x s)
      (textbookBrownianSDEDrift m U x) 0 := by
    simpa only [textbookBrownianGlobalDriftExpectation_zero m hm U hU hPU β hβ B P hB x] using hd
  exact hd'.hasDerivWithinAt.congr_of_mem
    (fun t ht ↦ textbookBrownianGlobalRandomConfiguration_increment_mean_integral m hm U hU hPU β hβ B P hB x t ht)
    (show (0 : ℝ) ∈ (Ici 0 : Set ℝ) by simp)

include hB in
/-- The genuine first-moment difference quotient converges to the original general-mass drift, rather than being postulated as generator data. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_mean_div_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ t⁻¹ • (∫ sample,
      textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P))
      (𝓝[>] 0) (𝓝 (textbookBrownianSDEDrift m U x)) := by
  have hc := textbookBrownianGlobalDriftExpectation_continuous m hm U hU hPU β hβ B P hB x
  have hd := intervalIntegral.integral_hasDerivAt_right
    (hc.intervalIntegrable (μ := volume) 0 0) hc.stronglyMeasurable.stronglyMeasurableAtFilter hc.continuousAt
  have hd' : HasDerivAt (fun t : ℝ ↦ ∫ s in 0..t,
      textbookBrownianGlobalDriftExpectation m hm U hU hPU β hβ B P x s)
      (textbookBrownianSDEDrift m U x) 0 := by
    simpa only [textbookBrownianGlobalDriftExpectation_zero m hm U hU hPU β hβ B P hB x] using hd
  apply hd'.tendsto_slope_zero_right.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  simp only [zero_add, intervalIntegral.integral_same, sub_zero]
  exact congrArg (fun v : Fin Nc → ℝ ↦ t⁻¹ • v)
    (textbookBrownianGlobalRandomConfiguration_increment_mean_integral m hm U hU hPU β hβ B P hB x t ht.le).symm


include hB in
/-- A derived displacement expectation bound controls the true expected norm of the original drift difference. -/
theorem textbookBrownianGlobalDriftExpectation_difference_norm_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      (∫ sample, ‖textbookBrownianSDEDrift m U
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) -
          textbookBrownianSDEDrift m U x‖ ∂P) ≤
        (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
          (M * t + (∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)) * Real.sqrt t) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM, hXi⟩ := textbookBrownianGlobalRandomConfiguration_increment_expectation_bound
    m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  have hbi : Integrable (fun sample ↦ textbookBrownianSDEDrift m U
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) -
        textbookBrownianSDEDrift m U x) P := by
    have hi := textbookBrownianGlobalDriftExpectation_integrable m hm U hU hPU β hβ B P hB x t
    have hi' : Integrable (fun sample ↦ textbookBrownianSDEDrift m U
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B (max 0 t) sample) -
          textbookBrownianSDEDrift m U x) P := hi.sub (integrable_const (textbookBrownianSDEDrift m U x))
    simpa only [max_eq_right ht] using hi'
  calc
    _ ≤ ∫ sample, (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
        ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖ ∂P :=
      integral_mono_ae hbi.norm ((hXi x t ht).1.norm.const_mul _)
        (Eventually.of_forall fun sample ↦
          (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).norm_sub_le _ _)
    _ = (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
        (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖ ∂P) :=
      integral_const_mul _ _
    _ ≤ _ := mul_le_mul_of_nonneg_left (hXi x t ht).2
      (textbookBrownianDriftLipschitzConstant m U hU hPU).property

/-- Literal same-process frozen-drift error with its actual zero-start physical Wiener noise. -/
def textbookBrownianGlobalFrozenDriftError (x : Fin Nc → ℝ) (t : ℝ) (sample : Ω) : Fin Nc → ℝ :=
  textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample -
    x - t • textbookBrownianSDEDrift m U x - textbookBrownianSDENoise m β (B t.toNNReal sample)

include hB in
/-- The genuine same-process frozen error is integrable, with no remainder integrability premise. -/
theorem textbookBrownianGlobalFrozenDriftError_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    Integrable (textbookBrownianGlobalFrozenDriftError m hm U hU hPU β hβ B x t) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨_, _, hi⟩ := textbookBrownianGlobalRandomConfiguration_increment_expectation_bound
    m hm U hU hPU β hβ B P hB
  exact ((hi x t ht).1.sub (integrable_const (t • textbookBrownianSDEDrift m U x))).sub
    (textbookBrownianPhysicalNoise_integrable m β B P hB t.toNNReal)

include hB in
/-- The actual frozen error equals the literal original drift-difference integral almost surely. -/
theorem textbookBrownianGlobalFrozenDriftError_ae_eq_integral
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    textbookBrownianGlobalFrozenDriftError m hm U hU hPU β hβ B x t =ᵐ[P]
      fun sample ↦ ∫ s in 0..t, textbookBrownianSDEDrift m U
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample) -
          textbookBrownianSDEDrift m U x := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae
    m hm U hU hPU β hβ B P hB x, textbookWienerVector_zero_ae B P hB] with sample hs hz
  simpa only [textbookBrownianGlobalFrozenDriftError, textbookBrownianFrozenDriftError,
    Real.toNNReal_zero, hz, sub_zero] using
    textbookBrownianFrozenDriftError_eq_integral m U hU hPU β t x
      (fun s ↦ B s.toNNReal sample)
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B · sample)
      (hs t ht) t ⟨ht, le_rfl⟩

include hB in
/-- Genuine product integrability and actual first noise moments yield the frozen-error expectation of order t^2 plus t^(3/2), uniformly in the initial state. -/
theorem textbookBrownianGlobalFrozenDriftError_norm_expectation_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      (∫ sample, ‖textbookBrownianGlobalFrozenDriftError m hm U hU hPU β hβ B x t sample‖ ∂P) ≤
        (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
          (M * t + (∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)) * Real.sqrt t) * t := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM, hD⟩ := textbookBrownianGlobalDriftExpectation_difference_norm_bound
    m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  have : IsFiniteMeasure (volume.restrict (uIoc 0 t)) := by
    rw [uIoc_of_le ht]
    infer_instance
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hPU
  let C : ℝ := ∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hPU).property
  have hC : 0 ≤ C := Finset.sum_nonneg fun i _ ↦ Real.sqrt_nonneg _
  let H : ℝ → Ω → ℝ := fun s sample ↦ ‖textbookBrownianSDEDrift m U
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample) -
      textbookBrownianSDEDrift m U x‖
  have hp : Integrable (Function.uncurry H) ((volume.restrict (uIoc 0 t)).prod P) :=
    ((textbookBrownianGlobalDriftIntegral_joint_integrable m hm U hU hPU β hβ B P hB x t ht).sub
      (integrable_const (textbookBrownianSDEDrift m U x))).norm
  have hright : Integrable (fun sample ↦ ∫ s in 0..t, H s sample) P := by
    simpa only [Function.uncurry, intervalIntegral.integral_of_le ht, uIoc_of_le ht] using hp.integral_prod_right
  have hleft : IntervalIntegrable (fun s ↦ ∫ sample, H s sample ∂P) volume 0 t := by
    rw [intervalIntegrable_iff_integrableOn_Ioc_of_le ht]
    simpa only [Function.uncurry, IntegrableOn, uIoc_of_le ht] using hp.integral_prod_left
  have ha : ∀ᵐ sample ∂P,
      ‖textbookBrownianGlobalFrozenDriftError m hm U hU hPU β hβ B x t sample‖ ≤ ∫ s in 0..t, H s sample := by
    filter_upwards [textbookBrownianGlobalFrozenDriftError_ae_eq_integral m hm U hU hPU β hβ B P hB x t ht]
      with sample he
    rw [he, intervalIntegral.integral_of_le ht, intervalIntegral.integral_of_le ht]
    exact norm_integral_le_integral_norm _
  calc
    _ ≤ ∫ sample, (∫ s in 0..t, H s sample) ∂P := integral_mono_ae
      (textbookBrownianGlobalFrozenDriftError_integrable m hm U hU hPU β hβ B P hB x t ht).norm hright ha
    _ = ∫ s in 0..t, ∫ sample, H s sample ∂P := (intervalIntegral_integral_swap hp).symm
    _ ≤ ∫ _ in 0..t, L * (M * t + C * Real.sqrt t) := by
      apply intervalIntegral.integral_mono_on ht hleft (intervalIntegrable_const (c := L * (M * t + C * Real.sqrt t)))
      intro s hs
      exact (hD x s hs.1).trans (mul_le_mul_of_nonneg_left
        (add_le_add (mul_le_mul_of_nonneg_left hs.2 hM)
          (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hs.2) hC)) hL)
    _ = _ := by
      simp only [intervalIntegral.integral_const, sub_zero, smul_eq_mul]
      dsimp [L, C]
      ring

end
end MolecularDynamics


