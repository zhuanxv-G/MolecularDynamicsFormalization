import MolecularDynamics.Chapter06.LangevinPositiveTimeHarris

/-! Necessary actual small-time momentum estimates for the original unit-mass
Langevin generator. Drift and Brownian remainder estimates are derived for the
same actual process; full generator or density existence is not asserted. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem smallTime_integral_cauchy_square (f : ℝ → ℝ) (t : ℝ) (ht : 0 ≤ t)
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

private theorem smallTime_noise_coordinate_formula {N : ℕ} (γ σ t : ℝ)
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


private theorem smallTime_noise_remainder_path_bound {N : ℕ} (γ σ t : ℝ)
    (hγ : 0 ≤ γ) (ht : 0 ≤ t) (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    (textbookLangevinDampedNoise γ σ W t i - σ * W t i) ^ 2 ≤
      σ ^ 2 * γ ^ 2 * t * (∫ s in 0..t, W s i ^ 2) := by
  let f : ℝ → ℝ := fun s ↦ Real.exp (-γ * (t - s)) * W s i
  have hw : Continuous (fun s ↦ W s i) := (continuous_apply i).comp hW
  have hf : Continuous f := by dsimp [f]; fun_prop
  have hi := smallTime_integral_cauchy_square f t ht hf
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
      rw [smallTime_noise_coordinate_formula γ σ t W hW i]
      dsimp [f]
      ring
    _ ≤ (σ ^ 2 * γ ^ 2) * (t * (∫ s in 0..t, W s i ^ 2)) :=
      mul_le_mul_of_nonneg_left hi' (mul_nonneg (sq_nonneg _) (sq_nonneg _))
    _ = _ := by ring

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The actual damped noise differs from its original Brownian leading increment by a true pathwise square bound. -/
theorem textbookLangevinDampedNoise_coordinate_Brownian_remainder_square_bound_ae
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    ∀ᵐ sample ∂P,
      (textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i -
        σ * B T.toNNReal sample i) ^ 2 ≤
      σ ^ 2 * γ ^ 2 * T * (∫ s in 0..T, B s.toNNReal sample i ^ 2) := by
  filter_upwards [hB.cont] with sample hc
  exact smallTime_noise_remainder_path_bound γ σ T hγ hT
    (fun s ↦ B s.toNNReal sample) (hc.comp (by fun_prop)) i

include hB in
/-- Both actual terms, and hence the true noise remainder, belong to L² under the original probability law. -/
theorem textbookLangevinDampedNoise_coordinate_Brownian_remainder_memLp
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    MemLp (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i -
      σ * B T.toNNReal sample i) 2 P := by
  exact (textbookLangevinDampedNoise_coordinate_memLp B P hB γ σ T hγ hT i).sub
    ((hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.const_mul σ)

include hB in
/-- Genuine Wiener time energy gives an O(T³) second moment for the actual damping remainder; no covariance or stochastic-integral identity is assumed. -/
theorem textbookLangevinDampedNoise_coordinate_Brownian_remainder_secondMoment_bound
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    (∫ sample, (textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i -
        σ * B T.toNNReal sample i) ^ 2 ∂P) ≤ σ ^ 2 * γ ^ 2 * T ^ 3 / 2 := by
  have hj := textbookWienerVector_coordinate_time_square_integrable B P hB T hT i
  have hi := (textbookLangevinDampedNoise_coordinate_Brownian_remainder_memLp
    B P hB γ σ T hγ hT i).integrable_sq
  calc
    _ ≤ ∫ sample, σ ^ 2 * γ ^ 2 * T * (∫ s in 0..T, B s.toNNReal sample i ^ 2) ∂P :=
      integral_mono_ae hi (hj.const_mul _)
        (textbookLangevinDampedNoise_coordinate_Brownian_remainder_square_bound_ae B P hB γ σ T hγ hT i)
    _ = _ := by
      rw [integral_const_mul, textbookWienerVector_coordinate_time_square_mean B P hB T hT i]
      ring

/-- The actual force convolution has its O(t) bound for nonnegative friction and time, derived by ordinary integration. -/
theorem textbookLangevinMomentum_force_convolution_linear_bound
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ t M : ℝ) (hγ : 0 ≤ γ) (ht : 0 ≤ t) (hM0 : 0 ≤ M)
    (hM : ∀ z, ‖textbookPotentialForce U z‖ ≤ M)
    (q : ℝ → (Fin N → ℝ)) (hq : ContinuousOn q (Icc 0 t)) :
    ‖∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)‖ ≤ M * t := by
  have he : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s))) := by fun_prop
  have hf : IntervalIntegrable (fun s ↦ Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)) volume 0 t := by
    have hh : ContinuousOn (fun s ↦ Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)) (uIcc 0 t) := by
      rw [uIcc_of_le ht]
      exact he.continuousOn.smul ((contDiff_textbookPotentialForce U hU).continuous.comp_continuousOn hq)
    exact hh.intervalIntegrable
  calc
    _ ≤ ∫ s in 0..t, ‖Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)‖ :=
      intervalIntegral.norm_integral_le_integral_norm ht
    _ ≤ ∫ _s in 0..t, M := by
      apply intervalIntegral.integral_mono_on ht hf.norm intervalIntegrable_const
      intro s hs
      rw [norm_smul, Real.norm_of_nonneg (Real.exp_pos _).le]
      have hb : Real.exp (-γ * (t - s)) ≤ 1 := Real.exp_le_one_iff.mpr (by nlinarith [hs.2])
      calc
        _ ≤ Real.exp (-γ * (t - s)) * M := mul_le_mul_of_nonneg_left (hM (q s)) (Real.exp_pos _).le
        _ ≤ M := by simpa using mul_le_mul_of_nonneg_right hb hM0
    _ = _ := by simp only [intervalIntegral.integral_const, sub_zero, smul_eq_mul]; ring

private theorem smallTime_damping_difference (γ t : ℝ) (hγ : 0 ≤ γ) (ht : 0 ≤ t) :
    |Real.exp (-γ * t) - 1| ≤ γ * t := by
  have he : Real.exp (-γ * t) ≤ 1 := Real.exp_le_one_iff.mpr (by nlinarith)
  rw [abs_of_nonpos (sub_nonpos.mpr he)]
  have hlow := Real.add_one_le_exp (-γ * t)
  linarith

variable (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
/-- One true force bound gives a simultaneous pathwise square bound on every actual momentum Brownian remainder. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_square_bound_ae
    (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t → ∀ i : Fin N,
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i -
        x.2 i - σ * B t.toNNReal sample i) ^ 2 ≤
        3 * γ ^ 2 * t ^ 2 * x.2 i ^ 2 + 3 * M ^ 2 * t ^ 2 +
          3 * (textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i -
            σ * B t.toNNReal sample i) ^ 2 := by
  obtain ⟨M, hM0, hM⟩ := textbookUnitPeriodicPotential_force_bound U hU hp
  refine ⟨M, hM0, fun x ↦ ?_⟩
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ z] with sample hs
  intro t ht i
  let q := fun s ↦ (textbookLangevinGlobalRandomPhase U L hF γ σ z B s sample).1
  let F := ∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)
  have hFb : ‖F‖ ≤ M * t := textbookLangevinMomentum_force_convolution_linear_bound
    U (hU.of_le (by simp)) γ t M hγ.le ht hM0 hM q (hs t ht).1
  have hFi : F i ^ 2 ≤ M ^ 2 * t ^ 2 := by
    have hh : ‖F i‖ ^ 2 ≤ (M * t) ^ 2 :=
      (sq_le_sq₀ (norm_nonneg _) (mul_nonneg hM0 ht)).mpr ((norm_le_pi_norm F i).trans hFb)
    simpa only [Real.norm_eq_abs, sq_abs, mul_pow] using hh
  have hDi : ((Real.exp (-γ * t) - 1) * x.2 i) ^ 2 ≤ γ ^ 2 * t ^ 2 * x.2 i ^ 2 := by
    have hh : |Real.exp (-γ * t) - 1| ^ 2 ≤ (γ * t) ^ 2 :=
      (sq_le_sq₀ (abs_nonneg _) (mul_nonneg hγ.le ht)).mpr (smallTime_damping_difference γ t hγ.le ht)
    have hm := mul_le_mul_of_nonneg_right hh (sq_nonneg (x.2 i))
    simpa only [sq_abs, mul_pow] using hm
  have he := textbookLangevinMomentum_duhamel U (hU.of_le (by simp)) γ σ t z _ _ _ (hs t ht) t ⟨ht, le_rfl⟩
  have htriple (a b c : ℝ) : (a + b + c) ^ 2 ≤ 3 * a ^ 2 + 3 * b ^ 2 + 3 * c ^ 2 := by
    nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c)]
  have hh := htriple ((Real.exp (-γ * t) - 1) * x.2 i) (F i)
    (textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i - σ * B t.toNNReal sample i)
  change ((textbookLangevinGlobalRandomPhase U L hF γ σ z B t sample).2 i -
    x.2 i - σ * B t.toNNReal sample i) ^ 2 ≤ _
  rw [he]
  simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
  change (Real.exp (-γ * t) * x.2 i + F i +
    textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i - x.2 i -
    σ * B t.toNNReal sample i) ^ 2 ≤ _
  nlinarith

include hB hU hp in
/-- The actual process remainder is in L², obtained from genuine process and Wiener moments. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
      x.2 i - σ * B T.toNNReal sample i) 2 P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hv := textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp B P hB U hU hp L hF γ σ T hγ hT x
  have hm := (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ x T hT).snd.eval i
  have hi : MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) 2 P :=
    hv.norm.mono' hm.aestronglyMeasurable (Eventually.of_forall (fun sample ↦ norm_le_pi_norm _ i))
  exact (hi.sub (memLp_const (x.2 i))).sub
    ((hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.const_mul σ)

include hB hU hp in
/-- The actual momentum remainder has a derived O(T²)+O(T³) second-moment bound with one genuine force constant. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_secondMoment_bound
    (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ T : ℝ, 0 ≤ T → ∀ x : textbookLangevinPeriodicPhase N, ∀ i : Fin N,
      (∫ sample, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i - σ * B T.toNNReal sample i) ^ 2 ∂P) ≤
        3 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) * T ^ 2 + (3 / 2 : ℝ) * σ ^ 2 * γ ^ 2 * T ^ 3 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM0, hb⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_square_bound_ae
    B P hB U hU hp L hF γ σ hγ
  refine ⟨M, hM0, fun T hT x i ↦ ?_⟩
  have hY := (textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i).integrable_sq
  have hZ := (textbookLangevinDampedNoise_coordinate_Brownian_remainder_memLp B P hB γ σ T hγ.le hT i).integrable_sq
  have hC : Integrable (fun _sample : Ω ↦ 3 * γ ^ 2 * T ^ 2 * x.2 i ^ 2 + 3 * M ^ 2 * T ^ 2) P :=
    integrable_const _
  have hupper : Integrable (fun sample ↦ 3 * γ ^ 2 * T ^ 2 * x.2 i ^ 2 + 3 * M ^ 2 * T ^ 2 +
      3 * (textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i - σ * B T.toNNReal sample i) ^ 2) P :=
    hC.add (hZ.const_mul _)
  have hh := integral_mono_ae hY hupper
    ((hb x).mono (fun sample hs ↦ hs T hT i))
  rw [integral_add hC (hZ.const_mul 3), integral_const, probReal_univ, one_smul, integral_const_mul] at hh
  have hn := textbookLangevinDampedNoise_coordinate_Brownian_remainder_secondMoment_bound B P hB γ σ T hγ.le hT i
  nlinarith

include hB hU hp in
/-- Dividing the actual momentum Brownian remainder's square moment by time tends to zero, a genuine necessary diffusion-generator asymptotic. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_secondMoment_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦
      (∫ sample, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i - σ * B T.toNNReal sample i) ^ 2 ∂P) / T) (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨M, _hM0, hb⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  let A : ℝ := 3 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2)
  let D : ℝ := (3 / 2 : ℝ) * σ ^ 2 * γ ^ 2
  have hc : Continuous (fun t : ℝ ↦ A * t + D * t ^ 2) := by fun_prop
  have hlim : Tendsto (fun t : ℝ ↦ A * t + D * t ^ 2) (𝓝[>] 0) (𝓝 0) := by
    simpa using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  apply squeeze_zero' _ _ hlim
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _sample ↦ sq_nonneg _)) ht.le
  · filter_upwards [self_mem_nhdsWithin] with t ht
    calc
      _ ≤ (A * t ^ 2 + D * t ^ 3) / t :=
        div_le_div_of_nonneg_right (hb t ht.le x i) ht.le
      _ = A * t + D * t ^ 2 := by field_simp


private theorem smallTime_integral_product_cauchy {Ω : Type*} [MeasurableSpace Ω]
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

private theorem smallTime_second_product_stability {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (Z W R S : Ω → ℝ)
    (hZ : MemLp Z 2 P) (hW : MemLp W 2 P) (hR : MemLp R 2 P) (hS : MemLp S 2 P) :
    ‖(∫ sample, (Z sample + R sample) * (W sample + S sample) ∂P) -
        ∫ sample, Z sample * W sample ∂P‖ ≤
      Real.sqrt (∫ sample, Z sample ^ 2 ∂P) * Real.sqrt (∫ sample, S sample ^ 2 ∂P) +
      Real.sqrt (∫ sample, R sample ^ 2 ∂P) * Real.sqrt (∫ sample, W sample ^ 2 ∂P) +
      Real.sqrt (∫ sample, R sample ^ 2 ∂P) * Real.sqrt (∫ sample, S sample ^ 2 ∂P) := by
  have he : (fun sample ↦ (Z sample + R sample) * (W sample + S sample)) =
      (fun sample ↦ ((Z sample * W sample + Z sample * S sample) + R sample * W sample) +
        R sample * S sample) := by funext sample; ring
  rw [he]
  rw [integral_add
    (f := fun sample ↦ (Z sample * W sample + Z sample * S sample) + R sample * W sample)
    (g := fun sample ↦ R sample * S sample)
    (((hZ.integrable_mul hW).add (hZ.integrable_mul hS)).add (hR.integrable_mul hW))
    (hR.integrable_mul hS)]
  rw [integral_add (f := fun sample ↦ Z sample * W sample + Z sample * S sample)
    (g := fun sample ↦ R sample * W sample)
    ((hZ.integrable_mul hW).add (hZ.integrable_mul hS)) (hR.integrable_mul hW)]
  rw [integral_add (f := fun sample ↦ Z sample * W sample) (g := fun sample ↦ Z sample * S sample)
    (hZ.integrable_mul hW) (hZ.integrable_mul hS)]
  have hcancel : (∫ sample, Z sample * W sample ∂P) + (∫ sample, Z sample * S sample ∂P) +
      (∫ sample, R sample * W sample ∂P) + (∫ sample, R sample * S sample ∂P) -
      (∫ sample, Z sample * W sample ∂P) =
        ((∫ sample, Z sample * S sample ∂P) + (∫ sample, R sample * W sample ∂P)) +
          ∫ sample, R sample * S sample ∂P := by ring
  rw [hcancel]
  exact (norm_add_le _ _).trans ((add_le_add (norm_add_le _ _) le_rfl).trans
    (add_le_add (add_le_add (smallTime_integral_product_cauchy P Z S hZ hS)
      (smallTime_integral_product_cauchy P R W hR hW))
      (smallTime_integral_product_cauchy P R S hR hS)))

include hB in
private theorem smallTime_Wiener_second_product (t : ℝ≥0) (i j : Fin N) :
    (∫ sample, B t sample i * B t sample j ∂P) = if i = j then (t : ℝ) else 0 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi := (hB.gaussian.hasGaussianLaw_eval ⟨i, t⟩).memLp_two
  have hj := (hB.gaussian.hasGaussianLaw_eval ⟨j, t⟩).memLp_two
  have hc := covariance_eq_sub hi hj
  have hh := hc.symm.trans (hB.covariance i j t t)
  simpa only [Pi.mul_apply, hB.mean, mul_zero, sub_zero, min_self] using hh

include hB hU hp in
/-- Every actual momentum increment coordinate is in L²; mixed moments are therefore genuine expectations. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
      x.2 i) 2 P := by
  have hr := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hn := (hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.const_mul σ
  have ha := hr.add hn
  have he : ((fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
      x.2 i - σ * B T.toNNReal sample i) + (fun sample ↦ σ * B T.toNNReal sample i)) =
      (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) := by
    funext sample
    exact sub_add_cancel _ _
  rw [he] at ha
  exact ha

include hB hU hp in
/-- The true product of two actual momentum increments is integrable, with no supplied moment hypothesis. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Integrable (fun sample ↦
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) *
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 j - x.2 j)) P := by
  exact (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i).integrable_mul
    (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x j)

include hB hU hp in
/-- The actual Langevin momentum cross second-moment quotient has its original diffusion limit σ² δᵢⱼ, derived from the same Wiener covariance and true small-time residual moments. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) *
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 j - x.2 j) ∂P) / T)
      (𝓝[>] 0) (𝓝 (σ ^ 2 * (if i = j then 1 else 0))) := by
  let Δ := fun (t : ℝ) (k : Fin N) sample ↦
    (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 k - x.2 k
  let R := fun (t : ℝ) (k : Fin N) sample ↦ (Δ t k sample - σ * B t.toNNReal sample k) / Real.sqrt t
  let Z := fun (t : ℝ) (k : Fin N) sample ↦ σ * B t.toNNReal sample k / Real.sqrt t
  let E := fun (t : ℝ) (k : Fin N) ↦ (∫ sample, (Δ t k sample - σ * B t.toNNReal sample k) ^ 2 ∂P) / t
  let c : ℝ := σ ^ 2 * (if i = j then 1 else 0)
  have hE (k : Fin N) : Tendsto (fun t ↦ E t k) (𝓝[>] 0) (𝓝 0) :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_secondMoment_div_time_tendsto_zero
      B P hB U hU hp L hF γ σ hγ x k
  have hR (t : ℝ) (ht : 0 < t) (k : Fin N) :
      (∫ sample, R t k sample ^ 2 ∂P) = E t k := by
    dsimp only [R, E]
    simp_rw [div_pow]
    rw [integral_div, Real.sq_sqrt ht.le]
  have hZ (t : ℝ) (ht : 0 < t) (a b : Fin N) :
      (∫ sample, Z t a sample * Z t b sample ∂P) = σ ^ 2 * (if a = b then 1 else 0) := by
    have he : (fun sample ↦ Z t a sample * Z t b sample) =
        (fun sample ↦ (σ ^ 2 / t) * (B t.toNNReal sample a * B t.toNNReal sample b)) := by
      funext sample
      dsimp only [Z]
      rw [div_mul_div_comm, ← pow_two, Real.sq_sqrt ht.le]
      ring
    rw [he, integral_const_mul, smallTime_Wiener_second_product B P hB]
    simp only [Real.coe_toNNReal t ht.le]
    by_cases hab : a = b
    · simp [hab, ht.ne']
    · simp [hab]
  have hRI (t : ℝ) (ht : 0 < t) (k : Fin N) : MemLp (R t k) 2 P := by
    simpa only [R, Δ, div_eq_mul_inv, mul_comm] using
      (textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_memLp
        B P hB U hU hp L hF γ σ hγ t ht.le x k).const_mul (Real.sqrt t)⁻¹
  have hZI (t : ℝ) (k : Fin N) : MemLp (Z t k) 2 P := by
    simpa only [Z, div_eq_mul_inv, mul_comm] using
      ((hB.gaussian.hasGaussianLaw_eval ⟨k, t.toNNReal⟩).memLp_two.const_mul σ).const_mul (Real.sqrt t)⁻¹
  have hbound : ∀ᶠ t in 𝓝[>] (0 : ℝ),
      ‖(∫ sample, Δ t i sample * Δ t j sample ∂P) / t - c‖ ≤
        |σ| * Real.sqrt (E t j) + Real.sqrt (E t i) * |σ| +
          Real.sqrt (E t i) * Real.sqrt (E t j) := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have he : (fun sample ↦ (Z t i sample + R t i sample) * (Z t j sample + R t j sample)) =
        (fun sample ↦ (Δ t i sample * Δ t j sample) / t) := by
      funext sample
      have heq (k : Fin N) : Z t k sample + R t k sample = Δ t k sample / Real.sqrt t := by
        dsimp only [Z, R]
        ring
      rw [heq, heq, div_mul_div_comm, ← pow_two, Real.sq_sqrt ht0.le]
    have hh := smallTime_second_product_stability P (Z t i) (Z t j) (R t i) (R t j)
      (hZI t i) (hZI t j) (hRI t ht0 i) (hRI t ht0 j)
    rw [he, integral_div, hZ t ht0 i j, hR t ht0 i, hR t ht0 j] at hh
    have hi : (∫ sample, Z t i sample ^ 2 ∂P) = σ ^ 2 := by
      simpa [pow_two] using hZ t ht0 i i
    have hj : (∫ sample, Z t j sample ^ 2 ∂P) = σ ^ 2 := by
      simpa [pow_two] using hZ t ht0 j j
    rw [hi, hj, Real.sqrt_sq_eq_abs] at hh
    exact hh
  have hlim : Tendsto (fun t : ℝ ↦ |σ| * Real.sqrt (E t j) + Real.sqrt (E t i) * |σ| +
      Real.sqrt (E t i) * Real.sqrt (E t j)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [Real.sqrt_zero, mul_zero, zero_mul, add_zero] using
      ((tendsto_const_nhds.mul (hE j).sqrt).add ((hE i).sqrt.mul tendsto_const_nhds)).add
        ((hE i).sqrt.mul (hE j).sqrt)
  have hz := squeeze_zero_norm' hbound hlim
  simpa only [Δ, c, sub_add_cancel, zero_add] using hz.add_const c

include hB hU hp in
/-- With the original fluctuation-dissipation amplitude, the actual momentum covariance derivative is exactly 2γβ⁻¹ δᵢⱼ. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_physical_second_product_div_time_tendsto
    (hγ : 0 < γ) (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) (i j : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2 * γ * β⁻¹)) x B T sample).2 i - x.2 i) *
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2 * γ * β⁻¹)) x B T sample).2 j - x.2 j) ∂P) / T)
      (𝓝[>] 0) (𝓝 (2 * γ * β⁻¹ * (if i = j then 1 else 0))) := by
  have hh := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_div_time_tendsto
    B P hB U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) hγ x i j
  rw [Real.sq_sqrt (mul_nonneg (mul_nonneg (by norm_num) hγ.le) (inv_nonneg.mpr hβ.le))] at hh
  exact hh

end
end MolecularDynamics
