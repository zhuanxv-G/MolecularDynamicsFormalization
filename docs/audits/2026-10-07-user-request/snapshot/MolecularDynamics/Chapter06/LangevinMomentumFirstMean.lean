import MolecularDynamics.Chapter06.LangevinSmallTimeMomentum
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! Necessary actual first-moment momentum drift for the original Langevin
generator. Ordinary FTC, dominated convergence, and genuine Wiener moments
identify the original drift without any infinitesimal limit premise. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem firstMean_force_average_limit (f : ℝ → ℝ)
    (hf : ContinuousOn f (Icc (0 : ℝ) 1)) (γ : ℝ) :
    Tendsto (fun t : ℝ ↦ (∫ s in 0..t, Real.exp (-γ * (t - s)) * f s) / t)
      (𝓝[>] 0) (𝓝 (f 0)) := by
  let fc : C(Icc (0 : ℝ) 1, ℝ) := ⟨fun s ↦ f s, hf.domRestrict⟩
  let g : ℝ → ℝ := fun s ↦ Real.exp (γ * s) * fc (projIcc 0 1 zero_le_one s)
  have hg : Continuous g := by dsimp only [g]; fun_prop
  have hg0 : g 0 = f 0 := by
    dsimp only [g]
    rw [projIcc_of_mem zero_le_one ⟨le_rfl, zero_le_one⟩]
    change Real.exp (γ * 0) * f 0 = f 0
    simp only [mul_zero, Real.exp_zero, one_mul]
  have hd := intervalIntegral.integral_hasDerivAt_right
    (hg.intervalIntegrable (μ := volume) 0 0) hg.stronglyMeasurable.stronglyMeasurableAtFilter hg.continuousAt
  have hbase : Tendsto (fun t : ℝ ↦ (∫ s in 0..t, g s) / t) (𝓝[>] 0) (𝓝 (f 0)) := by
    simpa only [zero_add, intervalIntegral.integral_same, sub_zero, smul_eq_mul, hg0,
      div_eq_mul_inv, mul_comm] using hd.tendsto_slope_zero_right
  have hExp : Tendsto (fun t : ℝ ↦ Real.exp (-γ * t)) (𝓝[>] 0) (𝓝 1) := by
    have hc : Continuous (fun t : ℝ ↦ Real.exp (-γ * t)) := by fun_prop
    simpa only [mul_zero, Real.exp_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  have hprod := hExp.mul hbase
  simp only [one_mul] at hprod
  apply hprod.congr'
  filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))]
    with t ht ht1
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have hc : (∫ s in 0..t, Real.exp (-γ * (t - s)) * f s) =
      Real.exp (-γ * t) * (∫ s in 0..t, g s) := by
    rw [← intervalIntegral.integral_const_mul]
    apply intervalIntegral.integral_congr
    intro s hs
    have hs' : s ∈ Icc (0 : ℝ) 1 := by
      have hst : s ∈ Icc 0 t := by simpa only [uIcc_of_le ht0.le] using hs
      exact ⟨hst.1, hst.2.trans ht1'.le⟩
    dsimp only [g]
    rw [projIcc_of_mem zero_le_one hs']
    change Real.exp (-γ * (t - s)) * f s = Real.exp (-γ * t) * (Real.exp (γ * s) * f s)
    rw [← mul_assoc, ← Real.exp_add]
    congr 1
    ring
  rw [hc]
  ring


private theorem firstMean_force_coordinate_integral {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ T : ℝ) (hT : 0 ≤ T) (q : ℝ → (Fin N → ℝ)) (hq : ContinuousOn q (Icc 0 T)) (i : Fin N) :
    (∫ s in 0..T, Real.exp (-γ * (T - s)) • textbookPotentialForce U (q s)) i =
      ∫ s in 0..T, Real.exp (-γ * (T - s)) * textbookPotentialForce U (q s) i := by
  have hc : ContinuousOn (fun s ↦ Real.exp (-γ * (T - s)) • textbookPotentialForce U (q s)) (uIcc 0 T) := by
    rw [uIcc_of_le hT]
    exact (by fun_prop : Continuous (fun s : ℝ ↦ Real.exp (-γ * (T - s)))).continuousOn.smul
      ((contDiff_textbookPotentialForce U hU).continuous.comp_continuousOn hq)
  have he := (ContinuousLinearMap.proj i : (Fin N → ℝ) →L[ℝ] ℝ).intervalIntegral_comp_comm (hc.intervalIntegrable (μ := volume))
  simpa only [ContinuousLinearMap.proj_apply, Pi.smul_apply, smul_eq_mul] using he.symm

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- Genuine second moments imply that the expected actual damped-noise remainder divided by time vanishes; a noise stochastic-integral law is not assumed. -/
theorem textbookLangevinDampedNoise_coordinate_Brownian_remainder_mean_div_time_tendsto_zero
    (γ σ : ℝ) (hγ : 0 ≤ γ) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i -
        σ * B T.toNNReal sample i ∂P) / T) (𝓝[>] 0) (𝓝 0) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let R := fun (t : ℝ) sample ↦
    textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i - σ * B t.toNNReal sample i
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ), ‖(∫ sample, R t sample ∂P) / t‖ ≤
      Real.sqrt (σ ^ 2 * γ ^ 2 * t / 2) := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have hLp := textbookLangevinDampedNoise_coordinate_Brownian_remainder_memLp B P hB γ σ t hγ ht0.le i
    have hv := variance_nonneg (R t) P
    rw [variance_eq_sub hLp] at hv
    simp only [Pi.pow_apply] at hv
    have hmoment := textbookLangevinDampedNoise_coordinate_Brownian_remainder_secondMoment_bound
      B P hB γ σ t hγ ht0.le i
    have hmean : (∫ sample, R t sample ∂P) ^ 2 ≤ σ ^ 2 * γ ^ 2 * t ^ 3 / 2 := by
      dsimp only [R] at hv ⊢
      linarith
    have hz : ((∫ sample, R t sample ∂P) / t) ^ 2 ≤ σ ^ 2 * γ ^ 2 * t / 2 := by
      apply (mul_le_mul_iff_of_pos_right (sq_pos_of_pos ht0)).mp
      calc
        _ = (∫ sample, R t sample ∂P) ^ 2 := by
          rw [← mul_pow, div_mul_cancel₀ _ ht0.ne']
        _ ≤ σ ^ 2 * γ ^ 2 * t ^ 3 / 2 := hmean
        _ = _ := by ring
    have h0 : 0 ≤ σ ^ 2 * γ ^ 2 * t / 2 := by positivity
    have hs := Real.sq_sqrt h0
    have hs0 := Real.sqrt_nonneg (σ ^ 2 * γ ^ 2 * t / 2)
    rw [Real.norm_eq_abs]
    nlinarith [sq_abs ((∫ sample, R t sample ∂P) / t), abs_nonneg ((∫ sample, R t sample ∂P) / t)]
  have hc : Continuous (fun t : ℝ ↦ Real.sqrt (σ ^ 2 * γ ^ 2 * t / 2)) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦ Real.sqrt (σ ^ 2 * γ ^ 2 * t / 2)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [mul_zero, zero_div, Real.sqrt_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  exact squeeze_zero_norm' hb hl

variable (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- The original force convolution along the same actual periodic global process, using its genuine real lift and leaving physical momentum unchanged. -/
def textbookLangevinPeriodicForceConvolution (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) :
    Fin N → ℝ :=
  ∫ s in 0..T, Real.exp (-γ * (T - s)) • textbookPotentialForce U
    (textbookLangevinGlobalRandomPhase U L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) B s sample).1

include hB hU in
private theorem firstMean_actual_duhamel (x : textbookLangevinPeriodicPhase N) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t →
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 =
        Real.exp (-γ * t) • x.2 + textbookLangevinPeriodicForceConvolution B U L hF γ σ t x sample +
          textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t := by
  filter_upwards [textbookLangevinGlobalRandomPhase_momentum_duhamel_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro t ht
  exact hs t ht

include hB hU in
/-- Actual endpoint and noise measurability plus true Duhamel give the force convolution's measurability, rather than imposing an integrand measurability assumption. -/
theorem textbookLangevinPeriodicForceConvolution_aemeasurable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    AEMeasurable (textbookLangevinPeriodicForceConvolution B U L hF γ σ T x) P := by
  have hp := (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ x T hT).snd
  have hn := (textbookLangevinDampedNoise_memLp B P hB γ σ T hγ.le hT).aestronglyMeasurable.aemeasurable
  have hm := (hp.sub (aemeasurable_const (b := Real.exp (-γ * T) • x.2))).sub hn
  apply hm.congr
  filter_upwards [firstMean_actual_duhamel B P hB U hU L hF γ σ x] with sample hs
  change (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 -
    Real.exp (-γ * T) • x.2 - textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T =
      textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample
  rw [hs T hT]
  module

include hB hU hp in
/-- One genuine periodic force constant bounds the same actual convolution by M T on a common full-measure set for every initial state and nonnegative time. -/
theorem textbookLangevinPeriodicForceConvolution_norm_bound_ae
    (hγ : 0 ≤ γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ T : ℝ, 0 ≤ T → ‖textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample‖ ≤ M * T := by
  obtain ⟨M, hM0, hM⟩ := textbookUnitPeriodicPotential_force_bound U hU hp
  refine ⟨M, hM0, fun x ↦ ?_⟩
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro T hT
  exact textbookLangevinMomentum_force_convolution_linear_bound U (hU.of_le (by simp)) γ T M hγ hT hM0 hM
    _ (hs T hT).1

include hB hU hp in
/-- Each actual convolution coordinate is integrable, derived from actual measurability and the true force bound. -/
theorem textbookLangevinPeriodicForceConvolution_coordinate_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Integrable (fun sample ↦ textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _hM0, hb⟩ := textbookLangevinPeriodicForceConvolution_norm_bound_ae B P hB U hU hp L hF γ σ hγ.le
  have hm := (textbookLangevinPeriodicForceConvolution_aemeasurable B P hB U hU L hF γ σ hγ T hT x).eval i
  have hLp : MemLp (fun sample ↦ textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i) 1 P :=
    MemLp.of_bound hm.aestronglyMeasurable (M * T) ((hb x).mono (fun sample hs ↦
      (norm_le_pi_norm _ i).trans (hs T hT)))
  exact hLp.integrable (by norm_num)

include hB hU in
/-- Ordinary pathwise FTC derives the actual force convolution divided by time's limit at the original initial position. -/
theorem textbookLangevinPeriodicForceConvolution_coordinate_average_tendsto_ae
    (x : textbookLangevinPeriodicPhase N) :
    ∀ᵐ sample ∂P, ∀ i : Fin N,
      Tendsto (fun T : ℝ ↦ textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i / T)
        (𝓝[>] 0) (𝓝 (textbookPotentialForce U (textbookLangevinPeriodicRepresentative x.1) i)) := by
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro i
  let q := fun t ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2) B t sample).1
  have hq0 : q 0 = textbookLangevinPeriodicRepresentative x.1 := by
    simpa only [intervalIntegral.integral_same, add_zero] using (hs 1 zero_le_one).2.2.2.2.1 0 ⟨le_rfl, zero_le_one⟩
  have hf : ContinuousOn (fun t ↦ textbookPotentialForce U (q t) i) (Icc (0 : ℝ) 1) :=
    (continuous_apply i).comp_continuousOn
      ((contDiff_textbookPotentialForce U (hU.of_le (by simp))).continuous.comp_continuousOn (hs 1 zero_le_one).1)
  have hh := firstMean_force_average_limit (fun t ↦ textbookPotentialForce U (q t) i) hf γ
  rw [hq0] at hh
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with T hT
  exact congrArg (fun v : ℝ ↦ v / T) (firstMean_force_coordinate_integral U
    (hU.of_le (by simp)) γ T hT.le q (hs T hT.le).1 i).symm

include hB hU hp in
/-- True dominated convergence with the derived M bound identifies the expected force convolution's first-order limit. -/
theorem textbookLangevinPeriodicForceConvolution_coordinate_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i ∂P) / T)
      (𝓝[>] 0) (𝓝 (textbookPotentialForce U (textbookLangevinPeriodicRepresentative x.1) i)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _hM0, hb⟩ := textbookLangevinPeriodicForceConvolution_norm_bound_ae B P hB U hU hp L hF γ σ hγ.le
  have hm : ∀ᶠ T in 𝓝[>] (0 : ℝ), AEStronglyMeasurable (fun sample ↦
      textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i / T) P := by
    filter_upwards [self_mem_nhdsWithin] with T hT
    simpa only [div_eq_mul_inv, mul_comm] using
      ((textbookLangevinPeriodicForceConvolution_coordinate_integrable B P hB U hU hp L hF γ σ
        hγ T hT.le x i).const_mul T⁻¹).aestronglyMeasurable
  have hbound : ∀ᶠ T in 𝓝[>] (0 : ℝ), ∀ᵐ sample ∂P,
      ‖textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i / T‖ ≤ M := by
    filter_upwards [self_mem_nhdsWithin] with T hT
    filter_upwards [hb x] with sample hs
    have hT0 : 0 < T := hT
    rw [norm_div, Real.norm_of_nonneg hT0.le]
    exact (div_le_iff₀ hT0).mpr ((norm_le_pi_norm _ i).trans (hs T hT0.le))
  have hl : ∀ᵐ sample ∂P, Tendsto (fun T : ℝ ↦
      textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i / T)
      (𝓝[>] 0) (𝓝 (textbookPotentialForce U (textbookLangevinPeriodicRepresentative x.1) i)) :=
    (textbookLangevinPeriodicForceConvolution_coordinate_average_tendsto_ae B P hB U hU L hF γ σ x).mono
      (fun _sample hs ↦ hs i)
  have hd := tendsto_integral_filter_of_dominated_convergence (fun _sample : Ω ↦ M) hm hbound (integrable_const M) hl
  simpa only [integral_div, integral_const, probReal_univ, one_smul] using hd

include hB hU hp in
/-- The actual momentum's expected increment has exactly the original force-minus-friction right derivative at zero, with no infinitesimal mean premise. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i ∂P) / T)
      (𝓝[>] 0) (𝓝 (textbookPotentialForce U (textbookLangevinPeriodicRepresentative x.1) i - γ * x.2 i)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hExpD : HasDerivAt (fun T : ℝ ↦ Real.exp (-γ * T)) (-γ) 0 := by
    simpa only [Function.comp_def, mul_zero, Real.exp_zero, mul_one, one_mul, id_eq, neg_mul] using (Real.hasDerivAt_exp (-γ * 0)).comp 0 ((hasDerivAt_id (0 : ℝ)).const_mul (-γ))
  have hExp : Tendsto (fun T : ℝ ↦ (Real.exp (-γ * T) - 1) / T) (𝓝[>] 0) (𝓝 (-γ)) := by
    simpa only [zero_add, mul_zero, Real.exp_zero, smul_eq_mul, div_eq_mul_inv, mul_comm] using hExpD.tendsto_slope_zero_right
  have hC := textbookLangevinPeriodicForceConvolution_coordinate_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x i
  have hN := textbookLangevinDampedNoise_coordinate_Brownian_remainder_mean_div_time_tendsto_zero B P hB γ σ hγ.le i
  have hsum := ((hExp.mul_const (x.2 i)).add hC).add hN
  have hsum' : Tendsto (fun T : ℝ ↦ ((Real.exp (-γ * T) - 1) / T) * x.2 i +
      (∫ sample, textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i ∂P) / T +
      (∫ sample, textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i -
        σ * B T.toNNReal sample i ∂P) / T) (𝓝[>] 0)
      (𝓝 (textbookPotentialForce U (textbookLangevinPeriodicRepresentative x.1) i - γ * x.2 i)) := by
    convert hsum using 1
    congr 1
    ring
  apply hsum'.congr'
  filter_upwards [self_mem_nhdsWithin] with T hT
  have hT0 : 0 < T := hT
  let C := fun sample ↦ textbookLangevinPeriodicForceConvolution B U L hF γ σ T x sample i
  let R := fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i - σ * B T.toNNReal sample i
  let G := fun sample ↦ σ * B T.toNNReal sample i
  let d := (Real.exp (-γ * T) - 1) * x.2 i
  have hCI := textbookLangevinPeriodicForceConvolution_coordinate_integrable B P hB U hU hp L hF γ σ hγ T hT0.le x i
  have hRI := (textbookLangevinDampedNoise_coordinate_Brownian_remainder_memLp B P hB γ σ T hγ.le hT0.le i).integrable (by norm_num)
  have hGI := ((hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.const_mul σ).integrable (by norm_num)
  have hfun : (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) =ᵐ[P]
      (fun sample ↦ ((d + C sample) + R sample) + G sample) := by
    filter_upwards [firstMean_actual_duhamel B P hB U hU L hF γ σ x] with sample hs
    rw [hs T hT0.le]
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    dsimp only [d, C, R, G]
    ring
  have hconst : Integrable (fun _sample : Ω ↦ d) P := integrable_const _
  have hmean : (∫ sample, (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i ∂P) =
      d + (∫ sample, C sample ∂P) + (∫ sample, R sample ∂P) := by
    rw [integral_congr_ae hfun]
    rw [integral_add (f := fun sample ↦ (d + C sample) + R sample) (g := G)
      ((hconst.add hCI).add hRI) hGI]
    rw [integral_add (f := fun sample ↦ d + C sample) (g := R) (hconst.add hCI) hRI]
    rw [integral_add (f := fun _sample : Ω ↦ d) (g := C) hconst hCI]
    simp only [integral_const, probReal_univ, one_smul, G, integral_const_mul, hB.mean, mul_zero, add_zero]
  rw [hmean]
  dsimp only [d, C, R]
  ring

end
end MolecularDynamics
