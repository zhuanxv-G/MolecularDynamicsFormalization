import MolecularDynamics.Chapter06.LangevinMomentumFirstMean

/-! Actual small-time configuration moments for the unit-mass Langevin generator.
Increments use the continuous real lift of the same periodic process. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem position_integral_cauchy_square (f : ℝ → ℝ) (t : ℝ) (ht : 0 ≤ t)
    (hf : Continuous f) :
    (∫ s in 0..t, f s) ^ 2 ≤ t * (∫ s in 0..t, f s ^ 2) := by
  rcases ht.eq_or_lt with he | ht
  · subst t
    simp
  let I := ∫ s in 0..t, f s
  let J := ∫ s in 0..t, f s ^ 2
  let m := I / t
  have hi : IntervalIntegrable f volume 0 t := hf.intervalIntegrable 0 t
  have hj : IntervalIntegrable (fun s ↦ f s ^ 2) volume 0 t := (hf.pow 2).intervalIntegrable 0 t
  have he : (∫ s in 0..t, (f s - m) ^ 2) = J - (2 * m) * I + m ^ 2 * t := by
    have hp : (fun s ↦ (f s - m) ^ 2) = (fun s ↦ (f s ^ 2 - (2 * m) * f s) + m ^ 2) := by
      funext s
      ring
    rw [hp, intervalIntegral.integral_add (hj.sub (hi.const_mul (2 * m))) intervalIntegrable_const,
      intervalIntegral.integral_sub hj (hi.const_mul (2 * m)), intervalIntegral.integral_const_mul,
      intervalIntegral.integral_const]
    simp only [smul_eq_mul, sub_zero]
    dsimp [I, J]
    ring
  have hn : 0 ≤ ∫ s in 0..t, (f s - m) ^ 2 :=
    intervalIntegral.integral_nonneg_of_ae ht.le (Eventually.of_forall (fun s ↦ sq_nonneg _))
  have hmul := mul_nonneg ht.le hn
  rw [he] at hmul
  have hh : t * (J - (2 * m) * I + m ^ 2 * t) = t * J - I ^ 2 := by
    dsimp [m]
    field_simp
    ring
  rw [hh] at hmul
  exact sub_nonneg.mp hmul

private theorem position_noise_coordinate_formula {N : ℕ} (γ σ t : ℝ)
    (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    textbookLangevinDampedNoise γ σ W t i =
      σ * (W t i - γ * (∫ s in 0..t, Real.exp (-γ * (t - s)) * W s i)) := by
  have hc : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s)) • W s) :=
    (by fun_prop : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s)))).smul hW
  have hf : IntervalIntegrable (fun s : ℝ ↦ Real.exp (-γ * (t - s)) • W s) volume 0 t := hc.intervalIntegrable 0 t
  have he := (ContinuousLinearMap.proj i : (Fin N → ℝ) →L[ℝ] ℝ).intervalIntegral_comp_comm hf
  simp only [ContinuousLinearMap.proj_apply, Pi.smul_apply, smul_eq_mul] at he
  change σ * (W t i - γ * ((∫ s in 0..t, Real.exp (-γ * (t - s)) • W s) i)) = _
  rw [← he]


private theorem position_noise_remainder_path_bound {N : ℕ} (γ σ t : ℝ)
    (hγ : 0 ≤ γ) (ht : 0 ≤ t) (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    (textbookLangevinDampedNoise γ σ W t i - σ * W t i) ^ 2 ≤
      σ ^ 2 * γ ^ 2 * t * (∫ s in 0..t, W s i ^ 2) := by
  let f : ℝ → ℝ := fun s ↦ Real.exp (-γ * (t - s)) * W s i
  have hw : Continuous (fun s ↦ W s i) := (continuous_apply i).comp hW
  have hf : Continuous f := by dsimp [f]; fun_prop
  have hi := position_integral_cauchy_square f t ht hf
  have hb : (∫ s in 0..t, f s ^ 2) ≤ ∫ s in 0..t, W s i ^ 2 := by
    apply intervalIntegral.integral_mono_on ht ((hf.pow 2).intervalIntegrable 0 t)
      ((hw.pow 2).intervalIntegrable 0 t)
    intro s hs
    have he : Real.exp (-γ * (t - s)) ≤ 1 := Real.exp_le_one_iff.mpr (by nlinarith [hs.2])
    have he2 : Real.exp (-γ * (t - s)) ^ 2 ≤ 1 :=
      pow_le_one₀ (Real.exp_pos _).le he
    dsimp [f]
    rw [mul_pow]
    simpa only [one_mul] using mul_le_mul_of_nonneg_right he2 (sq_nonneg (W s i))
  have hi' := hi.trans (mul_le_mul_of_nonneg_left hb ht)
  calc
    _ = (σ ^ 2 * γ ^ 2) * (∫ s in 0..t, f s) ^ 2 := by
      rw [position_noise_coordinate_formula γ σ t W hW i]
      dsimp [f]
      ring
    _ ≤ (σ ^ 2 * γ ^ 2) * (t * (∫ s in 0..t, W s i ^ 2)) :=
      mul_le_mul_of_nonneg_left hi' (mul_nonneg (sq_nonneg _) (sq_nonneg _))
    _ = _ := by ring


private theorem position_integral_cauchy_square_on (f : ℝ → ℝ) (t : ℝ) (ht : 0 ≤ t)
    (hf : ContinuousOn f (Icc 0 t)) :
    (∫ s in 0..t, f s) ^ 2 ≤ t * (∫ s in 0..t, f s ^ 2) := by
  let fc : C(Icc (0 : ℝ) t, ℝ) := ⟨fun s ↦ f s, hf.domRestrict⟩
  let g : ℝ → ℝ := fun s ↦ fc (projIcc 0 t ht s)
  have hg : Continuous g := by dsimp only [g]; fun_prop
  have he : (∫ s in 0..t, g s) = ∫ s in 0..t, f s := by
    apply intervalIntegral.integral_congr
    intro s hs
    have hs' : s ∈ Icc 0 t := by simpa only [uIcc_of_le ht] using hs
    dsimp only [g]
    rw [projIcc_of_mem ht hs']
    rfl
  have he2 : (∫ s in 0..t, g s ^ 2) = ∫ s in 0..t, f s ^ 2 := by
    apply intervalIntegral.integral_congr
    intro s hs
    have hs' : s ∈ Icc 0 t := by simpa only [uIcc_of_le ht] using hs
    dsimp only [g]
    rw [projIcc_of_mem ht hs']
    rfl
  simpa only [he, he2] using position_integral_cauchy_square g t ht hg

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- The continuous real configuration lift from the original initial representative;
its projection is the configuration of the same actual periodic process. -/
def textbookLangevinPeriodicConfigurationLift (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) :
    Fin N → ℝ :=
  (textbookLangevinGlobalRandomPhase U L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample).1

include hB hU hp in
/-- A genuine pathwise integrated momentum estimate bounds the configuration residual,
using the same Wiener time energy on a common full-measure set for every time. -/
theorem textbookLangevinPeriodicConfigurationLift_residual_square_bound_ae (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t → ∀ i : Fin N,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i - t * x.2 i) ^ 2 ≤
        6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) * t ^ 4 +
          (6 * σ ^ 2 * γ ^ 2 * t ^ 3 + 2 * σ ^ 2 * t) *
            (∫ s in 0..t, B s.toNNReal sample i ^ 2) := by
  obtain ⟨M, hM0, hb⟩ :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_square_bound_ae
      B P hB U hU hp L hF γ σ hγ
  refine ⟨M, hM0, fun x ↦ ?_⟩
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  filter_upwards [hb x, hB.cont,
    textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
      (hU.of_le (by simp)) L hF γ σ z] with sample hres hcont hsol
  intro t ht i
  let p : ℝ → (Fin N → ℝ) := fun s ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ z B s sample).2
  let W : ℝ → (Fin N → ℝ) := fun s ↦ B s.toNNReal sample
  let J : ℝ → ℝ := fun s ↦ ∫ r in 0..s, W r i ^ 2
  let A : ℝ := γ ^ 2 * x.2 i ^ 2 + M ^ 2
  have hW : Continuous W := hcont.comp (by fun_prop)
  have hWi : Continuous (fun s ↦ W s i ^ 2) := ((continuous_apply i).comp hW).pow 2
  have hJ (s : ℝ) (hs : 0 ≤ s) : 0 ≤ J s :=
    intervalIntegral.integral_nonneg hs (fun _ _ ↦ sq_nonneg _)
  have hJmono (s : ℝ) (hs : s ∈ Icc 0 t) : J s ≤ J t := by
    have he := intervalIntegral.integral_add_adjacent_intervals
      (hWi.intervalIntegrable (μ := volume) 0 s) (hWi.intervalIntegrable (μ := volume) s t)
    have hn : 0 ≤ ∫ r in s..t, W r i ^ 2 :=
      intervalIntegral.integral_nonneg hs.2 (fun _ _ ↦ sq_nonneg _)
    dsimp only [J]
    linarith
  have hpcont : ContinuousOn p (Icc 0 t) := (hsol t ht).2.1
  have hdcont : ContinuousOn (fun s ↦ p s i - x.2 i) (Icc 0 t) :=
    ((continuous_apply i).continuousOn.comp hpcont (fun _ hs ↦ mem_univ _)).sub continuous_const.continuousOn
  have hdelta (s : ℝ) (hs : s ∈ Icc 0 t) :
      (p s i - x.2 i) ^ 2 ≤
        6 * A * t ^ 2 + 6 * σ ^ 2 * γ ^ 2 * t * J t + 2 * σ ^ 2 * W s i ^ 2 := by
    have hr := hres s hs.1 i
    change (p s i - x.2 i - σ * W s i) ^ 2 ≤
      3 * γ ^ 2 * s ^ 2 * x.2 i ^ 2 + 3 * M ^ 2 * s ^ 2 +
        3 * (textbookLangevinDampedNoise γ σ W s i - σ * W s i) ^ 2 at hr
    have hn := position_noise_remainder_path_bound γ σ s hγ.le hs.1 W hW i
    have hs2 : s ^ 2 ≤ t ^ 2 := (sq_le_sq₀ hs.1 ht).mpr hs.2
    have h1 := mul_le_mul_of_nonneg_left hs2 (show 0 ≤ 3 * γ ^ 2 * x.2 i ^ 2 by positivity)
    have h2 := mul_le_mul_of_nonneg_left hs2 (show 0 ≤ 3 * M ^ 2 by positivity)
    have hsJ : s * J s ≤ t * J t :=
      mul_le_mul hs.2 (hJmono s hs) (hJ s hs.1) ht
    have h3 := mul_le_mul_of_nonneg_left hsJ (mul_nonneg (sq_nonneg σ) (sq_nonneg γ))
    have hrr : (p s i - x.2 i - σ * W s i) ^ 2 ≤
        3 * A * t ^ 2 + 3 * σ ^ 2 * γ ^ 2 * t * J t := by
      dsimp only [A]
      dsimp only [J] at h3
      nlinarith
    have ha : (p s i - x.2 i) ^ 2 ≤
        2 * (p s i - x.2 i - σ * W s i) ^ 2 + 2 * (σ * W s i) ^ 2 := by
      nlinarith [sq_nonneg (p s i - x.2 i - 2 * σ * W s i)]
    nlinarith
  have hpc : ContinuousOn p (uIcc 0 t) := by simpa only [uIcc_of_le ht] using hpcont
  have hproj := (ContinuousLinearMap.proj i : (Fin N → ℝ) →L[ℝ] ℝ).intervalIntegral_comp_comm
    (hpc.intervalIntegrable (μ := volume))
  simp only [ContinuousLinearMap.proj_apply] at hproj
  have hq := congrArg (fun v : Fin N → ℝ ↦ v i) ((hsol t ht).2.2.2.2.1 t ⟨ht, le_rfl⟩)
  simp only [Pi.add_apply] at hq
  have he : textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
      textbookLangevinPeriodicRepresentative x.1 i - t * x.2 i =
        ∫ s in 0..t, p s i - x.2 i := by
    have hpi : IntervalIntegrable (fun s ↦ p s i) volume 0 t :=
      ((continuous_apply i).comp_continuousOn hpc).intervalIntegrable
    rw [intervalIntegral.integral_sub (f := fun s ↦ p s i) (g := fun _s : ℝ ↦ x.2 i)
      hpi intervalIntegrable_const]
    rw [intervalIntegral.integral_const]
    simp only [sub_zero, smul_eq_mul]
    change (textbookLangevinGlobalRandomPhase U L hF γ σ z B t sample).1 i -
      z.1 i - t * x.2 i = _
    dsimp only [p] at hproj
    rw [hproj]
    linarith
  rw [he]
  have hj := position_integral_cauchy_square_on (fun s ↦ p s i - x.2 i) t ht hdcont
  have hd : IntervalIntegrable (fun s ↦ (p s i - x.2 i) ^ 2) volume 0 t := by
    have hc : ContinuousOn (fun s ↦ (p s i - x.2 i) ^ 2) (uIcc 0 t) := by
      rw [uIcc_of_le ht]
      intro s hs
      exact (hdcont s hs).pow 2
    exact hc.intervalIntegrable
  have hu : IntervalIntegrable (fun s ↦
      (6 * A * t ^ 2 + 6 * σ ^ 2 * γ ^ 2 * t * J t) + 2 * σ ^ 2 * W s i ^ 2) volume 0 t :=
    intervalIntegrable_const.add ((hWi.intervalIntegrable (μ := volume) 0 t).const_mul _)
  have hi := intervalIntegral.integral_mono_on ht hd hu hdelta
  rw [intervalIntegral.integral_add intervalIntegrable_const
    ((hWi.intervalIntegrable (μ := volume) 0 t).const_mul _),
    intervalIntegral.integral_const, intervalIntegral.integral_const_mul] at hi
  simp only [sub_zero, smul_eq_mul] at hi
  have hh := hj.trans (mul_le_mul_of_nonneg_left hi ht)
  dsimp only [J, W, A] at hh
  calc
    _ ≤ _ := hh
    _ = _ := by ring


include hB hU in
private theorem position_residual_aemeasurable (T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    AEMeasurable (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i) P := by
  have hm := (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).fst.eval i
  exact (hm.sub aemeasurable_const).sub aemeasurable_const

include hB hU hp in
/-- The actual lift residual square is integrable, derived from genuine endpoint
measurability and the original Wiener time-energy domination. -/
theorem textbookLangevinPeriodicConfigurationLift_residual_square_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Integrable (fun sample ↦ (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i) ^ 2) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _hM0, hb⟩ := textbookLangevinPeriodicConfigurationLift_residual_square_bound_ae
    B P hB U hU hp L hF γ σ hγ
  have hj := textbookWienerVector_coordinate_time_square_integrable B P hB T hT i
  have hu : Integrable (fun sample ↦ 6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) * T ^ 4 +
      (6 * σ ^ 2 * γ ^ 2 * T ^ 3 + 2 * σ ^ 2 * T) *
        (∫ s in 0..T, B s.toNNReal sample i ^ 2)) P :=
    (integrable_const _).add (hj.const_mul _)
  exact hu.mono_nonneg
    ((position_residual_aemeasurable B P hB U hU L hF γ σ T hT x i).pow_const 2).aestronglyMeasurable
    (Eventually.of_forall (fun _ ↦ sq_nonneg _))
    ((hb x).mono (fun _ hs ↦ hs T hT i))

include hB hU hp in
/-- The actual lift residual belongs to L² under the same original law. -/
theorem textbookLangevinPeriodicConfigurationLift_residual_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    MemLp (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i) 2 P :=
  (memLp_two_iff_integrable_sq
    (position_residual_aemeasurable B P hB U hU L hF γ σ T hT x i).aestronglyMeasurable).mpr
      (textbookLangevinPeriodicConfigurationLift_residual_square_integrable
        B P hB U hU hp L hF γ σ hγ T hT x i)

include hB hU hp in
/-- The true expectation of the lift residual square is O(T³)+O(T⁴)+O(T⁵);
the Wiener time-energy mean is derived from the original covariance. -/
theorem textbookLangevinPeriodicConfigurationLift_residual_secondMoment_bound (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ T : ℝ, 0 ≤ T → ∀ x : textbookLangevinPeriodicPhase N, ∀ i : Fin N,
      (∫ sample, (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i) ^ 2 ∂P) ≤
        6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) * T ^ 4 + σ ^ 2 * T ^ 3 +
          3 * σ ^ 2 * γ ^ 2 * T ^ 5 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM0, hb⟩ := textbookLangevinPeriodicConfigurationLift_residual_square_bound_ae
    B P hB U hU hp L hF γ σ hγ
  refine ⟨M, hM0, fun T hT x i ↦ ?_⟩
  have hr := textbookLangevinPeriodicConfigurationLift_residual_square_integrable
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hj := textbookWienerVector_coordinate_time_square_integrable B P hB T hT i
  have hc : Integrable (fun _sample : Ω ↦ 6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) * T ^ 4) P :=
    integrable_const _
  have hu := hc.add (hj.const_mul (6 * σ ^ 2 * γ ^ 2 * T ^ 3 + 2 * σ ^ 2 * T))
  have hh := integral_mono_ae hr hu ((hb x).mono (fun _ hs ↦ hs T hT i))
  simp only [Pi.add_apply] at hh
  rw [integral_add (f := fun _sample : Ω ↦ 6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) * T ^ 4)
    (g := fun sample ↦ (6 * σ ^ 2 * γ ^ 2 * T ^ 3 + 2 * σ ^ 2 * T) *
      (∫ s in 0..T, B s.toNNReal sample i ^ 2)) hc (hj.const_mul _), integral_const, probReal_univ, one_smul,
    integral_const_mul, textbookWienerVector_coordinate_time_square_mean B P hB T hT i] at hh
  calc
    _ ≤ _ := hh
    _ = _ := by ring

include hB hU hp in
/-- The actual configuration residual second-moment quotient by T² tends to zero. -/
theorem textbookLangevinPeriodicConfigurationLift_residual_secondMoment_div_time_sq_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i) ^ 2 ∂P) / T ^ 2)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨M, _hM0, hb⟩ := textbookLangevinPeriodicConfigurationLift_residual_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  let A : ℝ := 6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2)
  let D : ℝ := 3 * σ ^ 2 * γ ^ 2
  have hc : Continuous (fun t : ℝ ↦ A * t ^ 2 + σ ^ 2 * t + D * t ^ 3) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦ A * t ^ 2 + σ ^ 2 * t + D * t ^ 3) (𝓝[>] 0) (𝓝 0) := by
    simpa using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  apply squeeze_zero' _ _ hl
  · exact Eventually.of_forall (fun t ↦
      div_nonneg (integral_nonneg (fun _ ↦ sq_nonneg _)) (sq_nonneg t))
  · filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    calc
      _ ≤ (A * t ^ 4 + σ ^ 2 * t ^ 3 + D * t ^ 5) / t ^ 2 :=
        div_le_div_of_nonneg_right (hb t ht0.le x i) (sq_nonneg t)
      _ = _ := by field_simp

include hB hU hp in
/-- Every actual real configuration increment coordinate is in L². -/
theorem textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    MemLp (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i) 2 P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hr := textbookLangevinPeriodicConfigurationLift_residual_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have ha := hr.add (memLp_const (T * x.2 i))
  have he : ((fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i) + (fun _sample : Ω ↦ T * x.2 i)) =
      (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) := by
    funext sample
    exact sub_add_cancel _ _
  rw [he] at ha
  exact ha

include hB hU hp in
/-- The actual configuration increment expectation divided by time tends to the
original initial momentum, from a derived residual variance estimate. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i ∂P) / T) (𝓝[>] 0) (𝓝 (x.2 i)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let R := fun (t : ℝ) sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
    textbookLangevinPeriodicRepresentative x.1 i - t * x.2 i
  let E := fun t : ℝ ↦ (∫ sample, R t sample ^ 2 ∂P) / t ^ 2
  have hE : Tendsto E (𝓝[>] 0) (𝓝 0) :=
    textbookLangevinPeriodicConfigurationLift_residual_secondMoment_div_time_sq_tendsto_zero
      B P hB U hU hp L hF γ σ hγ x i
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ), ‖(∫ sample, R t sample ∂P) / t‖ ≤ Real.sqrt (E t) := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have hr := textbookLangevinPeriodicConfigurationLift_residual_memLp
      B P hB U hU hp L hF γ σ hγ t ht0.le x i
    have hv := variance_nonneg (R t) P
    rw [variance_eq_sub hr] at hv
    simp only [Pi.pow_apply] at hv
    have hm : (∫ sample, R t sample ∂P) ^ 2 ≤ ∫ sample, R t sample ^ 2 ∂P := by linarith
    have hz := div_le_div_of_nonneg_right hm (sq_nonneg t)
    rw [← div_pow] at hz
    have h0 : 0 ≤ E t := div_nonneg (integral_nonneg (fun _ ↦ sq_nonneg _)) (sq_nonneg t)
    have hs := Real.sq_sqrt h0
    have hs0 := Real.sqrt_nonneg (E t)
    rw [Real.norm_eq_abs]
    change ((∫ sample, R t sample ∂P) / t) ^ 2 ≤ E t at hz
    nlinarith [sq_abs ((∫ sample, R t sample ∂P) / t),
      abs_nonneg ((∫ sample, R t sample ∂P) / t)]
  have hR : Tendsto (fun t : ℝ ↦ (∫ sample, R t sample ∂P) / t) (𝓝[>] 0) (𝓝 0) :=
    squeeze_zero_norm' hb (by simpa only [Real.sqrt_zero] using hE.sqrt)
  have hh := hR.add_const (x.2 i)
  simp only [zero_add] at hh
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  have hr := (textbookLangevinPeriodicConfigurationLift_residual_memLp
    B P hB U hU hp L hF γ σ hγ t ht0.le x i).integrable (by norm_num)
  have he : (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
      textbookLangevinPeriodicRepresentative x.1 i) = (fun sample ↦ R t sample + t * x.2 i) := by
    funext sample
    dsimp only [R]
    ring
  rw [he, integral_add (f := R t) (g := fun _sample : Ω ↦ t * x.2 i) hr (integrable_const _),
    integral_const, probReal_univ, one_smul]
  field_simp

include hB hU hp in
/-- The actual configuration increment square divided by time has vanishing
expectation, giving its zero diffusion coefficient without a supplied limit. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_secondMoment_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ∂P) / T) (𝓝[>] 0) (𝓝 0) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _hM0, hb⟩ := textbookLangevinPeriodicConfigurationLift_residual_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  let A : ℝ := 6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2)
  let D : ℝ := 3 * σ ^ 2 * γ ^ 2
  have hc : Continuous (fun t : ℝ ↦
      2 * A * t ^ 3 + 2 * σ ^ 2 * t ^ 2 + 2 * D * t ^ 4 + 2 * t * x.2 i ^ 2) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦
      2 * A * t ^ 3 + 2 * σ ^ 2 * t ^ 2 + 2 * D * t ^ 4 + 2 * t * x.2 i ^ 2)
      (𝓝[>] 0) (𝓝 0) := by
    simpa using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  apply squeeze_zero' _ _ hl
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ sq_nonneg _)) ht.le
  · filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have hi := (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ t ht0.le x i).integrable_sq
    have hr := textbookLangevinPeriodicConfigurationLift_residual_square_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le x i
    have hu : Integrable (fun sample ↦ 2 *
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
          textbookLangevinPeriodicRepresentative x.1 i - t * x.2 i) ^ 2 + 2 * (t * x.2 i) ^ 2) P :=
      (hr.const_mul 2).add (integrable_const _)
    have he := integral_mono_ae hi hu (Eventually.of_forall (fun sample ↦
      show (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
          textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ≤
          2 * (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
            textbookLangevinPeriodicRepresentative x.1 i - t * x.2 i) ^ 2 + 2 * (t * x.2 i) ^ 2 from
        by nlinarith [sq_nonneg (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
          textbookLangevinPeriodicRepresentative x.1 i - 2 * t * x.2 i)]))
    rw [integral_add (hr.const_mul 2) (integrable_const _), integral_const_mul, integral_const,
      probReal_univ, one_smul] at he
    have hres := hb t ht0.le x i
    have hh : (∫ sample,
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
          textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ∂P) ≤
          2 * A * t ^ 4 + 2 * σ ^ 2 * t ^ 3 + 2 * D * t ^ 5 + 2 * t ^ 2 * x.2 i ^ 2 := by
      dsimp only [A, D]
      nlinarith
    calc
      _ ≤ (2 * A * t ^ 4 + 2 * σ ^ 2 * t ^ 3 + 2 * D * t ^ 5 + 2 * t ^ 2 * x.2 i ^ 2) / t :=
        div_le_div_of_nonneg_right hh ht0.le
      _ = _ := by field_simp

private theorem position_integral_product_cauchy {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (f g : Ω → ℝ) (hf : MemLp f 2 P) (hg : MemLp g 2 P) :
    ‖∫ sample, f sample * g sample ∂P‖ ≤
      Real.sqrt (∫ sample, f sample ^ 2 ∂P) * Real.sqrt (∫ sample, g sample ^ 2 ∂P) := by
  have hpq : (2 : ℝ).HolderConjugate 2 :=
    Real.holderConjugate_iff.mpr (by norm_num)
  have hh := integral_mul_norm_le_Lp_mul_Lq hpq
    (show MemLp f (ENNReal.ofReal 2) P by simpa using hf)
    (show MemLp g (ENNReal.ofReal 2) P by simpa using hg)
  have hs : (∫ sample, ‖f sample‖ * ‖g sample‖ ∂P) ≤
      Real.sqrt (∫ sample, f sample ^ 2 ∂P) * Real.sqrt (∫ sample, g sample ^ 2 ∂P) := by
    simpa only [Real.rpow_two, ← Real.sqrt_eq_rpow, Real.norm_eq_abs, sq_abs] using hh
  calc
    _ ≤ ∫ sample, ‖f sample * g sample‖ ∂P := norm_integral_le_integral_norm _
    _ = ∫ sample, ‖f sample‖ * ‖g sample‖ ∂P := by simp only [norm_mul]
    _ ≤ _ := hs


private theorem position_product_div_time_bound {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (f g : Ω → ℝ) (hf : MemLp f 2 P) (hg : MemLp g 2 P)
    (t : ℝ) (ht : 0 < t) :
    ‖(∫ sample, f sample * g sample ∂P) / t‖ ≤
      Real.sqrt ((∫ sample, f sample ^ 2 ∂P) / t) *
        Real.sqrt ((∫ sample, g sample ^ 2 ∂P) / t) := by
  let F := fun sample ↦ f sample / Real.sqrt t
  let G := fun sample ↦ g sample / Real.sqrt t
  have hF : MemLp F 2 P := by
    simpa only [F, div_eq_mul_inv, mul_comm] using hf.const_mul (Real.sqrt t)⁻¹
  have hG : MemLp G 2 P := by
    simpa only [G, div_eq_mul_inv, mul_comm] using hg.const_mul (Real.sqrt t)⁻¹
  have he : (fun sample ↦ F sample * G sample) = (fun sample ↦ (f sample * g sample) / t) := by
    funext sample
    dsimp only [F, G]
    rw [div_mul_div_comm, ← pow_two, Real.sq_sqrt ht.le]
  have hFs : (∫ sample, F sample ^ 2 ∂P) = (∫ sample, f sample ^ 2 ∂P) / t := by
    dsimp only [F]
    simp_rw [div_pow]
    rw [integral_div, Real.sq_sqrt ht.le]
  have hGs : (∫ sample, G sample ^ 2 ∂P) = (∫ sample, g sample ^ 2 ∂P) / t := by
    dsimp only [G]
    simp_rw [div_pow]
    rw [integral_div, Real.sq_sqrt ht.le]
  have hh := position_integral_product_cauchy P F G hF hG
  rw [he, integral_div, hFs, hGs] at hh
  exact hh

include hB hU hp in
/-- Actual real configuration increments have integrable coordinate cross products. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_second_product_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Integrable (fun sample ↦
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) *
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample j -
        textbookLangevinPeriodicRepresentative x.1 j)) P :=
  (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i).integrable_mul
    (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x j)

include hB hU hp in
/-- Every actual configuration cross second-moment quotient tends to zero. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_second_product_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) *
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample j -
        textbookLangevinPeriodicRepresentative x.1 j) ∂P) / T) (𝓝[>] 0) (𝓝 0) := by
  let Q := fun (t : ℝ) (k : Fin N) sample ↦
    textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample k -
      textbookLangevinPeriodicRepresentative x.1 k
  let E := fun (t : ℝ) (k : Fin N) ↦ (∫ sample, Q t k sample ^ 2 ∂P) / t
  have hE (k : Fin N) : Tendsto (fun t ↦ E t k) (𝓝[>] 0) (𝓝 0) :=
    textbookLangevinPeriodicConfigurationLift_increment_secondMoment_div_time_tendsto_zero
      B P hB U hU hp L hF γ σ hγ x k
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ),
      ‖(∫ sample, Q t i sample * Q t j sample ∂P) / t‖ ≤ Real.sqrt (E t i) * Real.sqrt (E t j) := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    exact position_product_div_time_bound P (Q t i) (Q t j)
      (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
        B P hB U hU hp L hF γ σ hγ t ht0.le x i)
      (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
        B P hB U hU hp L hF γ σ hγ t ht0.le x j) t ht0
  exact squeeze_zero_norm' hb (by
    simpa only [Real.sqrt_zero, zero_mul] using (hE i).sqrt.mul (hE j).sqrt)

include hB hU hp in
/-- The actual configuration-momentum mixed product is integrable under the original law. -/
theorem textbookLangevinPeriodicConfigurationLift_momentum_increment_product_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Integrable (fun sample ↦
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) *
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 j - x.2 j)) P :=
  (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i).integrable_mul
    (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x j)

include hB hU hp in
/-- The actual mixed configuration-momentum second-moment quotient tends to zero,
from true configuration and momentum moments and Holder's inequality. -/
theorem textbookLangevinPeriodicConfigurationLift_momentum_increment_product_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) *
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 j - x.2 j) ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  let Q := fun (t : ℝ) sample ↦
    textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
      textbookLangevinPeriodicRepresentative x.1 i
  let R := fun (t : ℝ) sample ↦
    (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 j - x.2 j
  let Eq := fun t : ℝ ↦ (∫ sample, Q t sample ^ 2 ∂P) / t
  let Ep := fun t : ℝ ↦ (∫ sample, R t sample ^ 2 ∂P) / t
  have hq : Tendsto Eq (𝓝[>] 0) (𝓝 0) :=
    textbookLangevinPeriodicConfigurationLift_increment_secondMoment_div_time_tendsto_zero
      B P hB U hU hp L hF γ σ hγ x i
  have hplim : Tendsto Ep (𝓝[>] 0) (𝓝 (σ ^ 2)) := by
    simpa only [Ep, R, pow_two, ite_true, mul_one] using
      textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_div_time_tendsto
        B P hB U hU hp L hF γ σ hγ x j j
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ),
      ‖(∫ sample, Q t sample * R t sample ∂P) / t‖ ≤ Real.sqrt (Eq t) * Real.sqrt (Ep t) := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    exact position_product_div_time_bound P (Q t) (R t)
      (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
        B P hB U hU hp L hF γ σ hγ t ht0.le x i)
      (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
        B P hB U hU hp L hF γ σ hγ t ht0.le x j) t ht0
  exact squeeze_zero_norm' hb (by
    simpa only [Real.sqrt_zero, zero_mul] using hq.sqrt.mul hplim.sqrt)

end
end MolecularDynamics
