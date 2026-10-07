import MolecularDynamics.Chapter06.LangevinMomentumVariation
import MolecularDynamics.Chapter06.WienerDeterministicLaw
import Mathlib.MeasureTheory.Integral.Prod

/-! Finite second-moment dependencies for the genuine Langevin noise convolution,
using the same Wiener law and actual continuous-path version. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

private def clippedWiener {N : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (T : ℝ) (hT : 0 ≤ T) (sample : Ω) (s : ℝ) : Fin N → ℝ :=
  textbookWienerVectorContinuousPath B T sample (projIcc 0 T hT s)

private theorem clipped_continuous {N : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (T : ℝ) (hT : 0 ≤ T) (sample : Ω) :
    Continuous (clippedWiener B T hT sample) :=
  (textbookWienerVectorContinuousPath B T sample).continuous.comp continuous_projIcc

private theorem clipped_eval {N : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (T : ℝ) (hT : 0 ≤ T) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (s : ℝ) :
    clippedWiener B T hT sample s =
      B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample :=
  textbookWienerVectorContinuousPath_eval B T sample hc _

private theorem clipped_coordinate_memLp {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) (s : ℝ) :
    MemLp (fun sample ↦ clippedWiener B T hT sample s i) 2 P := by
  have hb := ((textbookWienerVector_coordinate B P hB i).isGaussianProcess.hasGaussianLaw_eval
    ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩).memLp_two
  have he : (fun sample ↦ B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample i) =ᵐ[P]
      (fun sample ↦ clippedWiener B T hT sample s i) := by
    filter_upwards [hB.cont] with sample hc
    exact (congrFun (clipped_eval B T hT sample hc s) i).symm
  exact (memLp_congr_ae he).mp hb

private theorem clipped_coordinate_secondMoment {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) (s : ℝ) :
    (∫ sample, clippedWiener B T hT sample s i ^ 2 ∂P) = (projIcc 0 T hT s).1 := by
  have he : (fun sample ↦ clippedWiener B T hT sample s i ^ 2) =ᵐ[P]
      (fun sample ↦ B ⟨(projIcc 0 T hT s).1, (projIcc 0 T hT s).2.1⟩ sample i ^ 2) := by
    filter_upwards [hB.cont] with sample hc
    rw [clipped_eval B T hT sample hc s]
  rw [integral_congr_ae he]
  exact textbookCenteredGaussian_secondMoment ((textbookWienerVector_coordinate B P hB i).hasLaw_eval _)

private theorem clipped_square_joint_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) :
    Integrable (fun z : ℝ × Ω ↦ clippedWiener B T hT z.2 z.1 i ^ 2)
      ((volume.restrict (Ioc 0 T)).prod P) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hc : Continuous (fun z : C(Icc 0 T, Fin N → ℝ) × ℝ ↦ z.1 (projIcc 0 T hT z.2) i) := by
    fun_prop
  have hm : AEMeasurable (fun z : ℝ × Ω ↦ clippedWiener B T hT z.2 z.1 i)
      ((volume.restrict (Ioc 0 T)).prod P) :=
    hc.measurable.comp_aemeasurable
      ((textbookWienerVectorContinuousPath_aemeasurable B P hB T).comp_snd.prodMk measurable_fst.aemeasurable)
  apply (integrable_prod_iff (hm.pow_const 2).aestronglyMeasurable).mpr
  refine ⟨Eventually.of_forall (fun s ↦ (clipped_coordinate_memLp B P hB T hT i s).integrable_sq), ?_⟩
  have hproj : Continuous (fun s : ℝ ↦ (projIcc 0 T hT s).1) := by fun_prop
  have hi : Integrable (fun s : ℝ ↦ (projIcc 0 T hT s).1) (volume.restrict (Ioc 0 T)) :=
    hproj.continuousOn.integrableOn_Icc.mono_set Ioc_subset_Icc_self
  apply hi.congr
  filter_upwards with s
  simp only [Real.norm_eq_abs, abs_sq]
  exact (clipped_coordinate_secondMoment B P hB T hT i s).symm

private theorem clipped_time_square_ae {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) :
    (fun sample ↦ ∫ s, clippedWiener B T hT sample s i ^ 2 ∂volume.restrict (Ioc 0 T)) =ᵐ[P]
      (fun sample ↦ ∫ s in 0..T, B s.toNNReal sample i ^ 2) := by
  filter_upwards [hB.cont] with sample hc
  rw [intervalIntegral.integral_of_le hT]
  apply setIntegral_congr_fun measurableSet_Ioc
  intro s hs
  dsimp only
  rw [clipped_eval B T hT sample hc s]
  have hp : projIcc 0 T hT s = ⟨s, Ioc_subset_Icc_self hs⟩ := projIcc_of_mem hT (Ioc_subset_Icc_self hs)
  rw [hp]
  have he : (⟨s, hs.1.le⟩ : ℝ≥0) = s.toNNReal := by
    apply NNReal.eq
    simp only [Real.coe_toNNReal s hs.1.le]
    rfl
  rw [he]

/-- The actual coordinate Wiener time-energy is integrable under its genuine law; no supplied moment premise is needed. -/
theorem textbookWienerVector_coordinate_time_square_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) :
    Integrable (fun sample ↦ ∫ s in 0..T, B s.toNNReal sample i ^ 2) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  exact (clipped_square_joint_integrable B P hB T hT i).integral_prod_right.congr
    (clipped_time_square_ae B P hB T hT i)

/-- Fubini and the genuine Gaussian coordinate law give the actual expected time-energy T²/2. -/
theorem textbookWienerVector_coordinate_time_square_mean {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 ≤ T) (i : Fin N) :
    (∫ sample, (∫ s in 0..T, B s.toNNReal sample i ^ 2) ∂P) = T ^ 2 / 2 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  rw [← integral_congr_ae (clipped_time_square_ae B P hB T hT i)]
  rw [← integral_integral_swap (clipped_square_joint_integrable B P hB T hT i)]
  simp_rw [clipped_coordinate_secondMoment B P hB T hT i]
  have he : (∫ s in Ioc 0 T, (projIcc 0 T hT s).1) = ∫ s in 0..T, s := by
    rw [intervalIntegral.integral_of_le hT]
    apply setIntegral_congr_fun measurableSet_Ioc
    intro s hs
    dsimp only
    exact congrArg Subtype.val (projIcc_of_mem hT (Ioc_subset_Icc_self hs))
  rw [he, integral_id]
  ring


private theorem integral_cauchy_square (f : ℝ → ℝ) (t : ℝ) (ht : 0 ≤ t)
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

private theorem noise_coordinate_formula {N : ℕ} (γ σ t : ℝ)
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

private theorem noise_coordinate_path_bound {N : ℕ} (γ σ t : ℝ) (hγ : 0 ≤ γ) (ht : 0 ≤ t)
    (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    textbookLangevinDampedNoise γ σ W t i ^ 2 ≤
      2 * σ ^ 2 * (W t i ^ 2 + γ ^ 2 * t * (∫ s in 0..t, W s i ^ 2)) := by
  let f : ℝ → ℝ := fun s ↦ Real.exp (-γ * (t - s)) * W s i
  have hw : Continuous (fun s ↦ W s i) := (continuous_apply i).comp hW
  have hf : Continuous f := by dsimp [f]; fun_prop
  have hi := integral_cauchy_square f t ht hf
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
  have hγi := mul_le_mul_of_nonneg_left hi' (sq_nonneg γ)
  have hs : (W t i - γ * (∫ s in 0..t, f s)) ^ 2 ≤
      2 * (W t i ^ 2 + γ ^ 2 * (∫ s in 0..t, f s) ^ 2) := by
    nlinarith [sq_nonneg (W t i + γ * (∫ s in 0..t, f s))]
  rw [noise_coordinate_formula γ σ t W hW i, mul_pow]
  change σ ^ 2 * (W t i - γ * (∫ s in 0..t, f s)) ^ 2 ≤ _
  have hs' := mul_le_mul_of_nonneg_left hs (sq_nonneg σ)
  have hγi' := mul_le_mul_of_nonneg_left hγi (sq_nonneg σ)
  nlinarith

private theorem clipped_noise_ae {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hT : 0 ≤ T) :
    (fun sample ↦ textbookLangevinDampedNoise γ σ (clippedWiener B T hT sample) T) =ᵐ[P]
      (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T) := by
  filter_upwards [hB.cont] with sample hc
  have he (s : ℝ) (hs : s ∈ Icc 0 T) :
      clippedWiener B T hT sample s = B s.toNNReal sample := by
    rw [clipped_eval B T hT sample hc s, projIcc_of_mem hT hs]
    congr 1
    apply NNReal.eq
    simp only [Real.coe_toNNReal s hs.1]
    rfl
  have hi : (∫ s in 0..T, Real.exp (-γ * (T - s)) • clippedWiener B T hT sample s) =
      ∫ s in 0..T, Real.exp (-γ * (T - s)) • B s.toNNReal sample := by
    apply intervalIntegral.integral_congr
    intro s hs
    dsimp only
    rw [he s (by simpa only [uIcc_of_le hT] using hs)]
  simp only [textbookLangevinDampedNoise, he T ⟨hT, le_rfl⟩, hi]

/-- Each actual coordinate of the genuine damped Wiener convolution is a.e.-measurable, derived from the true continuous-path version and product measurability. -/
theorem textbookLangevinDampedNoise_coordinate_aemeasurable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hT : 0 ≤ T) (i : Fin N) :
    AEMeasurable (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hc : Continuous (fun z : C(Icc 0 T, Fin N → ℝ) × ℝ ↦
      Real.exp (-γ * (T - z.2)) * z.1 (projIcc 0 T hT z.2) i) := by fun_prop
  have hm : AEMeasurable (fun z : Ω × ℝ ↦
      Real.exp (-γ * (T - z.2)) * clippedWiener B T hT z.1 z.2 i)
      (P.prod (volume.restrict (Ioc 0 T))) :=
    hc.measurable.comp_aemeasurable
      ((textbookWienerVectorContinuousPath_aemeasurable B P hB T).comp_fst.prodMk measurable_snd.aemeasurable)
  have hi : AEMeasurable (fun sample ↦ ∫ s in 0..T,
      Real.exp (-γ * (T - s)) * clippedWiener B T hT sample s i) P := by
    simpa only [intervalIntegral.integral_of_le hT] using hm.aestronglyMeasurable.integral_prod_right'.aemeasurable
  have hh : AEMeasurable (fun sample ↦ σ * (clippedWiener B T hT sample T i -
      γ * (∫ s in 0..T, Real.exp (-γ * (T - s)) * clippedWiener B T hT sample s i))) P :=
    measurable_const.aemeasurable.mul
      ((clipped_coordinate_memLp B P hB T hT i T).aemeasurable.sub (measurable_const.aemeasurable.mul hi))
  apply hh.congr
  filter_upwards [clipped_noise_ae B P hB γ σ T hT] with sample he
  rw [← congrFun he i, noise_coordinate_formula γ σ T _ (clipped_continuous B T hT sample) i]

/-- Pathwise Cauchy-Schwarz bounds the actual noise square using actual Wiener endpoint and time-energy values; no random moment is assumed. -/
theorem textbookLangevinDampedNoise_coordinate_square_bound_ae {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    ∀ᵐ sample ∂P, textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2 ≤
      2 * σ ^ 2 * (B T.toNNReal sample i ^ 2 +
        γ ^ 2 * T * (∫ s in 0..T, B s.toNNReal sample i ^ 2)) := by
  filter_upwards [hB.cont] with sample hc
  exact noise_coordinate_path_bound γ σ T hγ hT (fun s ↦ B s.toNNReal sample)
    (hc.comp (by fun_prop)) i

/-- The true damped noise coordinate square is integrable, from actual Gaussian endpoint moments and the already proved time-energy, rather than a supplied stochastic-integral law. -/
theorem textbookLangevinDampedNoise_coordinate_square_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    Integrable (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) P := by
  have hm := textbookLangevinDampedNoise_coordinate_aemeasurable B P hB γ σ T hT i
  have he : Integrable (fun sample ↦ B T.toNNReal sample i ^ 2) P :=
    (hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.integrable_sq
  have hd : Integrable (fun sample ↦ 2 * σ ^ 2 * (B T.toNNReal sample i ^ 2 +
      γ ^ 2 * T * (∫ s in 0..T, B s.toNNReal sample i ^ 2))) P :=
    (he.add ((textbookWienerVector_coordinate_time_square_integrable B P hB T hT i).const_mul _)).const_mul _
  exact hd.mono_nonneg (hm.pow_const 2).aestronglyMeasurable
    (Eventually.of_forall (fun sample ↦ sq_nonneg _))
    (textbookLangevinDampedNoise_coordinate_square_bound_ae B P hB γ σ T hγ hT i)

/-- The actual damped noise coordinate is genuinely in L² under the original Wiener law. -/
theorem textbookLangevinDampedNoise_coordinate_memLp {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    MemLp (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i) 2 P :=
  (memLp_two_iff_integrable_sq
    (textbookLangevinDampedNoise_coordinate_aemeasurable B P hB γ σ T hT i).aestronglyMeasurable).mpr
      (textbookLangevinDampedNoise_coordinate_square_integrable B P hB γ σ T hγ hT i)

/-- A finite-time second-moment bound for the same true Wiener convolution suffices for the fixed-time process drift proof; an exact Ornstein-Uhlenbeck variance is not claimed. -/
theorem textbookLangevinDampedNoise_coordinate_secondMoment_bound {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) (i : Fin N) :
    (∫ sample, textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2 ∂P) ≤
      2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3 := by
  have he : Integrable (fun sample ↦ B T.toNNReal sample i ^ 2) P :=
    (hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.integrable_sq
  have hj := textbookWienerVector_coordinate_time_square_integrable B P hB T hT i
  have hd : Integrable (fun sample ↦ 2 * σ ^ 2 * (B T.toNNReal sample i ^ 2 +
      γ ^ 2 * T * (∫ s in 0..T, B s.toNNReal sample i ^ 2))) P :=
    (he.add (hj.const_mul _)).const_mul _
  calc
    _ ≤ ∫ sample, 2 * σ ^ 2 * (B T.toNNReal sample i ^ 2 +
        γ ^ 2 * T * (∫ s in 0..T, B s.toNNReal sample i ^ 2)) ∂P :=
      integral_mono_ae (textbookLangevinDampedNoise_coordinate_square_integrable B P hB γ σ T hγ hT i) hd
        (textbookLangevinDampedNoise_coordinate_square_bound_ae B P hB γ σ T hγ hT i)
    _ = _ := by
      rw [integral_const_mul, integral_add he (hj.const_mul _), integral_const_mul,
        textbookWienerVector_coordinate_time_square_mean B P hB T hT i,
        textbookCenteredGaussian_secondMoment ((textbookWienerVector_coordinate B P hB i).hasLaw_eval T.toNNReal),
        Real.coe_toNNReal T hT]
      ring


/-- All coordinates together give true L² integrability of the same finite-dimensional noise convolution. -/
theorem textbookLangevinDampedNoise_memLp {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) :
    MemLp (fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T) 2 P := by
  let ξ := fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T
  have hm : AEMeasurable ξ P := .of_eval
    (fun i ↦ textbookLangevinDampedNoise_coordinate_aemeasurable B P hB γ σ T hT i)
  have hs : MemLp (fun sample ↦ ∑ i : Fin N, ‖ξ sample i‖) 2 P := by
    simpa using memLp_finsetSum Finset.univ
      (fun i _ ↦ (textbookLangevinDampedNoise_coordinate_memLp B P hB γ σ T hγ hT i).norm)
  apply hs.mono' hm.aestronglyMeasurable
  apply Eventually.of_forall
  intro sample
  apply (pi_norm_le_iff_of_nonneg (Finset.sum_nonneg (fun i _ ↦ norm_nonneg (ξ sample i)))).mpr
  intro i
  exact Finset.single_le_sum (fun j _ ↦ norm_nonneg (ξ sample j)) (Finset.mem_univ i)

/-- The actual coordinate square sum in the physical kinetic energy is integrable. It is not replaced by the sup norm squared. -/
theorem textbookLangevinDampedNoise_sum_square_integrable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) :
    Integrable (fun sample ↦ ∑ i : Fin N,
      textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) P := by
  exact integrable_finsetSum Finset.univ
    (fun i _ ↦ textbookLangevinDampedNoise_coordinate_square_integrable B P hB γ σ T hγ hT i)

/-- The same original Wiener law gives an explicit finite second moment for the genuine Euclidean coordinate square sum, for every dimension including zero. -/
theorem textbookLangevinDampedNoise_sum_secondMoment_bound {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ T : ℝ) (hγ : 0 ≤ γ) (hT : 0 ≤ T) :
    (∫ sample, (∑ i : Fin N,
      textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) ∂P) ≤
        (N : ℝ) * (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3) := by
  rw [integral_finsetSum Finset.univ
    (fun i _ ↦ textbookLangevinDampedNoise_coordinate_square_integrable B P hB γ σ T hγ hT i)]
  calc
    _ ≤ ∑ _i : Fin N, (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3) :=
      Finset.sum_le_sum (fun i _ ↦ textbookLangevinDampedNoise_coordinate_secondMoment_bound B P hB γ σ T hγ hT i)
    _ = _ := by simp; ring

/-- The actual periodic Langevin process momentum is in L² at every specified nonnegative time, with no moment hypothesis on the process. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2) 2 P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hm : AEStronglyMeasurable (fun sample ↦
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2) P :=
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T hT).snd.aestronglyMeasurable
  obtain ⟨M, _, hM⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_bound_ae B P hB U hU hp L hF γ σ hγ
  have hc : MemLp (fun _ : Ω ↦ Real.exp (-γ * T) * ‖x.2‖ + M / γ) 2 P := memLp_const _
  have hn : MemLp (fun sample ↦ ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖) 2 P :=
    (textbookLangevinDampedNoise_memLp B P hB γ σ T hγ.le hT).norm
  have hd : MemLp (fun sample ↦ Real.exp (-γ * T) * ‖x.2‖ + M / γ +
      ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖) 2 P := hc.add hn
  exact hd.mono' hm ((hM x).mono (fun _ h ↦ h T hT))

end
end MolecularDynamics
