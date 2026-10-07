import MolecularDynamics.Chapter06.LangevinHamiltonianDrift
import MolecularDynamics.Chapter06.BrownianFourthMomentEstimates
import Mathlib.Analysis.Convex.Integral
import Mathlib.Analysis.Convex.Mul

/-! Higher physical Hamiltonian moment dependencies for Theorem 6.2, restricted to the required even Wiener coordinate powers. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private def powerClippedWiener {N : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (T : ℝ) (hT : 0 ≤ T) (sample : Ω) (s : ℝ) : Fin N → ℝ :=
  textbookWienerVectorContinuousPath B T sample (projIcc 0 T hT s)

private theorem powerClipped_continuous {N : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (T : ℝ) (hT : 0 ≤ T) (sample : Ω) :
    Continuous (powerClippedWiener B T hT sample) :=
  (textbookWienerVectorContinuousPath B T sample).continuous.comp continuous_projIcc

private theorem powerClipped_eval {N : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (T : ℝ) (hT : 0 ≤ T) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (s : ℝ) :
    powerClippedWiener B T hT sample s =
      B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample :=
  textbookWienerVectorContinuousPath_eval B T sample hc _

private theorem powerClipped_norm_pow_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) (l : ℕ) (s : ℝ) :
    Integrable (fun sample ↦ ‖powerClippedWiener B T hT sample s i‖ ^ (2 * l)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hb : MemLp (fun sample ↦ B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample i)
      ((2 * l : ℕ) : ℝ≥0∞) P :=
    ((textbookWienerVector_coordinate B P hB i).isGaussianProcess.hasGaussianLaw_eval _).memLp (p := ((2 * l : ℕ) : ℝ≥0∞)) (ENNReal.natCast_ne_top (2 * l))
  have he : (fun sample ↦ B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample i) =ᵐ[P]
      (fun sample ↦ powerClippedWiener B T hT sample s i) := by
    filter_upwards [hB.cont] with sample hc
    exact (congrFun (powerClipped_eval B T hT sample hc s) i).symm
  have hp := (memLp_congr_ae he).mp hb
  exact hp.integrable_norm_pow'

private theorem powerClipped_norm_pow_mean {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) (l : ℕ) (s : ℝ) :
    (∫ sample, ‖powerClippedWiener B T hT sample s i‖ ^ (2 * l) ∂P) =
      Real.sqrt (projIcc 0 T hT s).1 ^ (2 * l) *
      ∫ z : ℝ, ‖z‖ ^ (2 * l) ∂gaussianReal 0 1 := by
  have he : (fun sample ↦ ‖powerClippedWiener B T hT sample s i‖ ^ (2 * l)) =ᵐ[P]
      (fun sample ↦ ‖B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample i‖ ^ (2 * l)) := by
    filter_upwards [hB.cont] with sample hc
    rw [powerClipped_eval B T hT sample hc s]
  rw [integral_congr_ae he]
  let t : ℝ≥0 := ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩
  have hc : Continuous (fun z : ℝ ↦ ‖z‖ ^ (2 * l)) := by fun_prop
  calc
    _ = ∫ z : ℝ, ‖z‖ ^ (2 * l) ∂gaussianReal 0 t :=
      ((textbookWienerVector_coordinate B P hB i).hasLaw_eval t).integral_comp hc.aestronglyMeasurable
    _ = ∫ z : ℝ, ‖Real.sqrt (t : ℝ) * z‖ ^ (2 * l) ∂gaussianReal 0 1 := by
      rw [← textbookBrownianGaussian_time_sqrt_map t]
      exact integral_map (by fun_prop) hc.aestronglyMeasurable
    _ = _ := by
      simp_rw [norm_mul, Real.norm_of_nonneg (Real.sqrt_nonneg _), mul_pow]
      exact integral_const_mul _ _

private theorem powerClipped_joint_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) (l : ℕ) :
    Integrable (fun z : ℝ × Ω ↦ ‖powerClippedWiener B T hT z.2 z.1 i‖ ^ (2 * l))
      ((volume.restrict (Ioc 0 T)).prod P) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hc : Continuous (fun z : C(Icc 0 T, Fin N → ℝ) × ℝ ↦ z.1 (projIcc 0 T hT z.2) i) := by
    fun_prop
  have hm : AEMeasurable (fun z : ℝ × Ω ↦ powerClippedWiener B T hT z.2 z.1 i)
      ((volume.restrict (Ioc 0 T)).prod P) :=
    hc.measurable.comp_aemeasurable
      ((textbookWienerVectorContinuousPath_aemeasurable B P hB T).comp_snd.prodMk measurable_fst.aemeasurable)
  apply (integrable_prod_iff (hm.norm.pow_const (2 * l)).aestronglyMeasurable).mpr
  refine ⟨Eventually.of_forall (fun s ↦ powerClipped_norm_pow_integrable B P hB T hT i l s), ?_⟩
  have hcont : Continuous (fun s : ℝ ↦ Real.sqrt (projIcc 0 T hT s).1 ^ (2 * l) *
      ∫ z : ℝ, ‖z‖ ^ (2 * l) ∂gaussianReal 0 1) := by fun_prop
  have hi : Integrable (fun s : ℝ ↦ Real.sqrt (projIcc 0 T hT s).1 ^ (2 * l) *
      ∫ z : ℝ, ‖z‖ ^ (2 * l) ∂gaussianReal 0 1) (volume.restrict (Ioc 0 T)) :=
    hcont.continuousOn.integrableOn_Icc.mono_set Ioc_subset_Icc_self
  apply hi.congr
  filter_upwards with s
  simpa only [Real.norm_eq_abs, abs_pow, abs_abs] using
    (powerClipped_norm_pow_mean B P hB T hT i l s).symm

/-- The genuine Wiener time integral of the even coordinate norm power required by H^l is integrable under the original law. -/
theorem textbookWienerVector_coordinate_time_even_norm_power_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) (l : ℕ) :
    Integrable (fun sample ↦ ∫ s in 0..T, ‖B s.toNNReal sample i‖ ^ (2 * l)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  apply (powerClipped_joint_integrable B P hB T hT i l).integral_prod_right.congr
  filter_upwards [hB.cont] with sample hc
  rw [intervalIntegral.integral_of_le hT]
  apply setIntegral_congr_fun measurableSet_Ioc
  intro s hs
  dsimp only
  rw [powerClipped_eval B T hT sample hc s, projIcc_of_mem hT (Ioc_subset_Icc_self hs)]
  have he : (⟨s, hs.1.le⟩ : ℝ≥0) = s.toNNReal := by
    apply NNReal.eq
    simp only [Real.coe_toNNReal s hs.1.le]
    rfl
  rw [he]

private theorem time_integral_norm_power_bound (f : ℝ → ℝ) (T : ℝ) (hT : 0 < T)
    (hf : Continuous f) (n : ℕ) :
    (∫ s in 0..T, ‖f s‖) ^ n ≤ T ^ n * ((∫ s in 0..T, ‖f s‖ ^ n) / T) := by
  have h0 : volume (Ioc 0 T) ≠ 0 := by
    simp only [Real.volume_Ioc, sub_zero, ne_eq, ENNReal.ofReal_eq_zero]
    exact not_le.mpr hT
  have htop : volume (Ioc 0 T) ≠ (∞ : ℝ≥0∞) := by
    rw [Real.volume_Ioc]
    exact ENNReal.ofReal_ne_top
  have hnorm : IntegrableOn (fun s ↦ ‖f s‖) (Ioc 0 T) :=
    hf.norm.continuousOn.integrableOn_Icc.mono_set Ioc_subset_Icc_self
  have hpow : IntegrableOn ((fun y : ℝ ↦ y ^ n) ∘ (fun s ↦ ‖f s‖)) (Ioc 0 T) :=
    (hf.norm.pow n).continuousOn.integrableOn_Icc.mono_set Ioc_subset_Icc_self
  have hcp : Continuous (fun y : ℝ ↦ y ^ n) := by fun_prop
  have hj := (convexOn_pow (𝕜 := ℝ) n).map_set_average_le hcp.continuousOn isClosed_Ici h0 htop
    (Eventually.of_forall (fun s ↦ norm_nonneg (f s))) hnorm hpow
  simp only [setAverage_eq, measureReal_def, Real.volume_Ioc, sub_zero,
    ENNReal.toReal_ofReal hT.le, smul_eq_mul] at hj
  rw [intervalIntegral.integral_of_le hT.le, intervalIntegral.integral_of_le hT.le]
  have he : T * (T⁻¹ * ∫ s in Ioc 0 T, ‖f s‖) = ∫ s in Ioc 0 T, ‖f s‖ := by
    rw [← mul_assoc, mul_inv_cancel₀ hT.ne', one_mul]
  calc
    _ = T ^ n * (T⁻¹ * ∫ s in Ioc 0 T, ‖f s‖) ^ n := by rw [← mul_pow, he]
    _ ≤ T ^ n * (T⁻¹ * ∫ s in Ioc 0 T, ‖f s‖ ^ n) :=
      mul_le_mul_of_nonneg_left hj (pow_nonneg hT.le n)
    _ = _ := by rw [div_eq_mul_inv]; ring


private theorem square_power_eq_even_norm (a : ℝ) (l : ℕ) :
    (a ^ 2) ^ l = ‖a‖ ^ (2 * l) := by
  rw [pow_mul, Real.norm_eq_abs, sq_abs]

private theorem square_bound_power (a b I J c d t : ℝ) (l : ℕ)
    (hc : 0 ≤ c) (hd : 0 ≤ d) (hI0 : 0 ≤ I)
    (ha : a ^ 2 ≤ c * (b ^ 2 + d * I))
    (hI : I ^ l ≤ t ^ l * (J / t)) :
    ‖a‖ ^ (2 * l) ≤ c ^ l * 2 ^ (l - 1) *
      (‖b‖ ^ (2 * l) + d ^ l * (t ^ l / t) * J) := by
  calc
    _ = (a ^ 2) ^ l := (square_power_eq_even_norm a l).symm
    _ ≤ (c * (b ^ 2 + d * I)) ^ l := pow_le_pow_left₀ (sq_nonneg a) ha l
    _ = c ^ l * (b ^ 2 + d * I) ^ l := mul_pow _ _ _
    _ ≤ c ^ l * (2 ^ (l - 1) * ((b ^ 2) ^ l + (d * I) ^ l)) :=
      mul_le_mul_of_nonneg_left (add_pow_le (sq_nonneg b) (mul_nonneg hd hI0) l) (pow_nonneg hc l)
    _ = c ^ l * 2 ^ (l - 1) * (‖b‖ ^ (2 * l) + d ^ l * I ^ l) := by
      rw [square_power_eq_even_norm, mul_pow]
      ring
    _ ≤ c ^ l * 2 ^ (l - 1) * (‖b‖ ^ (2 * l) + d ^ l * (t ^ l * (J / t))) :=
      mul_le_mul_of_nonneg_left (add_le_add le_rfl (mul_le_mul_of_nonneg_left hI (pow_nonneg hd l)))
        (mul_nonneg (pow_nonneg hc l) (by positivity))
    _ = _ := by ring

/-- The even coordinate noise moment needed by the original H^l proof is genuinely integrable, using Gaussian endpoint moments and true time-integral Jensen rather than a process moment input. -/
theorem textbookLangevinDampedNoise_coordinate_even_norm_power_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) (l : ℕ) :
    Integrable (fun sample ↦
      ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i‖ ^ (2 * l)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have heLp : MemLp (fun sample ↦ B T.toNNReal sample i) ((2 * l : ℕ) : ℝ≥0∞) P :=
    ((textbookWienerVector_coordinate B P hB i).isGaussianProcess.hasGaussianLaw_eval _).memLp (p := ((2 * l : ℕ) : ℝ≥0∞)) (ENNReal.natCast_ne_top (2 * l))
  have he : Integrable (fun sample ↦ ‖B T.toNNReal sample i‖ ^ (2 * l)) P := heLp.integrable_norm_pow'
  rcases hT.eq_or_lt with hT0 | hTpos
  · subst T
    simpa only [textbookLangevinDampedNoise, intervalIntegral.integral_same, smul_zero, sub_zero,
      Pi.smul_apply, smul_eq_mul, norm_mul, mul_pow] using he.const_mul (‖σ‖ ^ (2 * l))
  let J := fun sample ↦ ∫ s in 0..T, ‖B s.toNNReal sample i‖ ^ (2 * l)
  let c := (2 * σ ^ 2) ^ l * 2 ^ (l - 1)
  let d := (γ ^ 2 * T) ^ l * (T ^ l / T)
  have hj : Integrable J P := textbookWienerVector_coordinate_time_even_norm_power_integrable B P hB T hTpos.le i l
  have hd : Integrable (fun sample ↦ c * (‖B T.toNNReal sample i‖ ^ (2 * l) + d * J sample)) P :=
    (he.add (hj.const_mul d)).const_mul c
  have hm := (textbookLangevinDampedNoise_coordinate_aemeasurable B P hB γ σ T hTpos.le i).norm.pow_const (2 * l)
  apply hd.mono_nonneg hm.aestronglyMeasurable
    (Eventually.of_forall (fun sample ↦ pow_nonneg (norm_nonneg _) _))
  filter_upwards [hB.cont,
    textbookLangevinDampedNoise_coordinate_square_bound_ae B P hB γ σ T hγ hTpos.le i] with sample hW hξ
  have hw : Continuous (fun s : ℝ ↦ B s.toNNReal sample i) :=
    ((continuous_apply i).comp hW).comp continuous_real_toNNReal
  let f := fun s : ℝ ↦ B s.toNNReal sample i ^ 2
  have hf : Continuous f := hw.pow 2
  have hp := time_integral_norm_power_bound f T hTpos hf l
  simp only [f, Real.norm_eq_abs, abs_sq] at hp
  simp only [square_power_eq_even_norm] at hp
  have hI0 : 0 ≤ ∫ s in 0..T, B s.toNNReal sample i ^ 2 :=
    intervalIntegral.integral_nonneg_of_ae hTpos.le (Eventually.of_forall (fun s ↦ sq_nonneg _))
  exact square_bound_power _ _ _ _ (2 * σ ^ 2) (γ ^ 2 * T) T l (by positivity)
    (mul_nonneg (sq_nonneg γ) hTpos.le) hI0 hξ hp

/-- Only the required even finite-order Lp space is used for the genuine coordinate convolution. -/
theorem textbookLangevinDampedNoise_coordinate_memLp_even
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) (l : ℕ) (hl : 1 ≤ l) :
    MemLp (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i)
      ((2 * l : ℕ) : ℝ≥0∞) P := by
  have hm := (textbookLangevinDampedNoise_coordinate_aemeasurable B P hB γ σ T hT i).aestronglyMeasurable
  have hn : (2 * l : ℕ) ≠ 0 := by omega
  apply (integrable_norm_rpow_iff (p := ((2 * l : ℕ) : ℝ≥0∞)) hm (by exact_mod_cast hn)
    (ENNReal.natCast_ne_top (2 * l))).mp
  simpa only [ENNReal.toReal_natCast, Real.rpow_natCast] using
    textbookLangevinDampedNoise_coordinate_even_norm_power_integrable B P hB γ σ T hγ hT i l

/-- The same actual vector convolution is in the finite-order space needed for the physical Hamiltonian power. -/
theorem textbookLangevinDampedNoise_memLp_even
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (l : ℕ) (hl : 1 ≤ l) :
    MemLp (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T)
      ((2 * l : ℕ) : ℝ≥0∞) P := by
  let ξ := fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T
  have hm : AEMeasurable ξ P := .of_eval
    (fun i ↦ textbookLangevinDampedNoise_coordinate_aemeasurable B P hB γ σ T hT i)
  have hs : MemLp (fun sample ↦ ∑ i : Fin N, ‖ξ sample i‖) ((2 * l : ℕ) : ℝ≥0∞) P := by
    simpa using memLp_finsetSum Finset.univ
      (fun i _ ↦ (textbookLangevinDampedNoise_coordinate_memLp_even B P hB γ σ T hγ hT i l hl).norm)
  apply hs.mono' hm.aestronglyMeasurable
  apply Eventually.of_forall
  intro sample
  apply (pi_norm_le_iff_of_nonneg (Finset.sum_nonneg (fun i _ ↦ norm_nonneg (ξ sample i)))).mpr
  intro i
  exact Finset.single_le_sum (fun j _ ↦ norm_nonneg (ξ sample j)) (Finset.mem_univ i)

private theorem physical_square_sum_power_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (f : Ω → (Fin N → ℝ)) (l : ℕ) (hl : 1 ≤ l)
    (hf : MemLp f ((2 * l : ℕ) : ℝ≥0∞) P) :
    Integrable (fun sample ↦ (∑ i : Fin N, f sample i ^ 2) ^ l) P := by
  have hn : (2 * l : ℕ) ≠ 0 := by omega
  have hi : Integrable (fun sample ↦ ‖f sample‖ ^ (2 * l)) P := hf.integrable_norm_pow hn
  have hc : Continuous (fun v : Fin N → ℝ ↦ (∑ i : Fin N, v i ^ 2) ^ l) := by fun_prop
  have hm : AEStronglyMeasurable (fun sample ↦ (∑ i : Fin N, f sample i ^ 2) ^ l) P :=
    (hc.measurable.comp_aemeasurable hf.aestronglyMeasurable.aemeasurable).aestronglyMeasurable
  apply (hi.const_mul ((N : ℝ) ^ l)).mono_nonneg hm
    (Eventually.of_forall (fun sample ↦ pow_nonneg (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) l))
  apply Eventually.of_forall
  intro sample
  have hs : (∑ i : Fin N, f sample i ^ 2) ≤ (N : ℝ) * ‖f sample‖ ^ 2 := by
    calc
      _ ≤ ∑ _i : Fin N, ‖f sample‖ ^ 2 := by
        apply Finset.sum_le_sum
        intro i _
        have h := (sq_le_sq₀ (norm_nonneg (f sample i)) (norm_nonneg (f sample))).mpr
          (norm_le_pi_norm (f sample) i)
        simpa only [Real.norm_eq_abs, sq_abs] using h
      _ = _ := by simp
  have hp := pow_le_pow_left₀ (Finset.sum_nonneg (fun i _ ↦ sq_nonneg (f sample i))) hs l
  simpa only [mul_pow, ← pow_mul] using hp

/-- The genuine Euclidean coordinate square sum to power l is integrable for the same noise, including dimension zero. -/
theorem textbookLangevinDampedNoise_physical_energy_power_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (l : ℕ) (hl : 1 ≤ l) :
    Integrable (fun sample ↦ (∑ i : Fin N,
      textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) ^ l) P :=
  physical_square_sum_power_integrable P _ l hl
    (textbookLangevinDampedNoise_memLp_even B P hB γ σ T hγ hT l hl)

/-- The momentum of the same actual periodic global process has the required 2l moment, without any supplied process-moment premise. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp_even
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (l : ℕ) (hl : 1 ≤ l) :
    MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2)
      ((2 * l : ℕ) : ℝ≥0∞) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hm : AEStronglyMeasurable (fun sample ↦
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2) P :=
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T hT).snd.aestronglyMeasurable
  obtain ⟨M, _, hM⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_bound_ae B P hB U hU hp L hF γ σ hγ
  have hc : MemLp (fun _ : Ω ↦ Real.exp (-γ * T) * ‖x.2‖ + M / γ) ((2 * l : ℕ) : ℝ≥0∞) P := memLp_const _
  have hn : MemLp (fun sample ↦ ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖)
      ((2 * l : ℕ) : ℝ≥0∞) P :=
    (textbookLangevinDampedNoise_memLp_even B P hB γ σ T hγ.le hT l hl).norm
  have hd : MemLp (fun sample ↦ Real.exp (-γ * T) * ‖x.2‖ + M / γ +
      ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖) ((2 * l : ℕ) : ℝ≥0∞) P := hc.add hn
  exact hd.mono' hm ((hM x).mono (fun _ h ↦ h T hT))

/-- The physical coordinate square sum power is genuinely integrable for the same all-time process. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_square_sum_power_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (l : ℕ) (hl : 1 ≤ l) :
    Integrable (fun sample ↦ (∑ i : Fin N,
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i ^ 2) ^ l) P :=
  physical_square_sum_power_integrable P _ l hl
    (textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp_even B P hB U hU hp L hF γ σ T hγ hT x l hl)


private theorem physical_hamiltonian_power_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hLower : ∀ q, 1 ≤ U q)
    (Q : ℝ) (hQ0 : 0 ≤ Q) (hQ : ∀ q, ‖U q‖ ≤ Q)
    (l : ℕ) (z : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianPower U l z ≤
      2 ^ (l - 1) * ((∑ i : Fin N, z.2 i ^ 2) ^ l / 2 ^ l + Q ^ l) := by
  let K := ∑ i : Fin N, z.2 i ^ 2
  have hk0 : 0 ≤ K / 2 := div_nonneg (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) (by norm_num)
  have hU0 : 0 ≤ U (textbookLangevinPeriodicRepresentative z.1) := le_trans (by norm_num) (hLower _)
  have hUQ : U (textbookLangevinPeriodicRepresentative z.1) ≤ Q :=
    (le_abs_self _).trans (by simpa only [Real.norm_eq_abs] using hQ _)
  change (K / 2 + U (textbookLangevinPeriodicRepresentative z.1)) ^ l ≤ _
  calc
    _ ≤ (K / 2 + Q) ^ l :=
      pow_le_pow_left₀ (add_nonneg hk0 hU0) (add_le_add le_rfl hUQ) l
    _ ≤ 2 ^ (l - 1) * ((K / 2) ^ l + Q ^ l) := add_pow_le hk0 hQ0 l
    _ = _ := by rw [div_pow]

/-- The actual textbook H^l of the same periodic all-time process is integrable at each nonnegative time, derived from true noise moments rather than supplied as a hypothesis. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (l : ℕ) (hl : 1 ≤ l) :
    Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨Q, hQ0, hQ⟩ := textbookUnitPeriodicPotential_bound U hU.continuous hp
  let Y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T
  have hk : Integrable (fun sample ↦ (∑ i : Fin N, (Y sample).2 i ^ 2) ^ l) P :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_square_sum_power_integrable B P hB U hU hp L hF γ σ T hγ hT x l hl
  have hm : AEStronglyMeasurable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l (Y sample)) P :=
    ((textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l).measurable.comp_aemeasurable
      (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
        (hU.of_le (by simp)) L hF γ σ x T hT)).aestronglyMeasurable
  have hd : Integrable (fun sample ↦ 2 ^ (l - 1) *
      ((∑ i : Fin N, (Y sample).2 i ^ 2) ^ l / 2 ^ l + Q ^ l)) P :=
    ((hk.div_const (2 ^ l)).add (integrable_const (Q ^ l))).const_mul (2 ^ (l - 1))
  apply hd.mono_nonneg hm
    (Eventually.of_forall (fun sample ↦ (textbookLangevinPeriodicHamiltonianPower_pos U hLower l (Y sample)).le))
  exact Eventually.of_forall (fun sample ↦ physical_hamiltonian_power_bound U hLower Q hQ0 hQ l (Y sample))

/-- The genuine original transition kernel has finite physical H^l moments, obtained from its actual process law. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N)
    (l : ℕ) (hl : 1 ≤ l) :
    Integrable (textbookLangevinPeriodicHamiltonianPower U l)
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact (integrable_map_measure
    (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l).aestronglyMeasurable
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)).mpr
    (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ T hγ T.property x l hl)

end
end MolecularDynamics
