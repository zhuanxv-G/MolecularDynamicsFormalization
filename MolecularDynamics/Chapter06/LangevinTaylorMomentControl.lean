import MolecularDynamics.Chapter06.LangevinHigherIncrementMoments

/-! Actual absolute integer increment moments for the original H^l generator's
Taylor expectation remainder, including the third moment. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem taylor_moment_product_cauchy {Ω : Type*} [MeasurableSpace Ω]
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

private theorem taylor_moment_power_bound (a : ℝ) (k : ℕ) :
    a ^ k ≤ 1 + a ^ (2 * k) := by
  have he : a ^ (2 * k) = (a ^ k) ^ 2 := by rw [← pow_mul, Nat.mul_comm]
  rw [he]
  nlinarith [sq_nonneg (a ^ k - (1 / 2 : ℝ))]

private theorem taylor_moment_higher_bound (a : ℝ) (ha : 0 ≤ a) (k : ℕ) (hk : 3 ≤ k) :
    a ^ k ≤ a ^ 3 + a ^ (2 * k) := by
  rcases le_total a 1 with h | h
  · exact (pow_le_pow_of_le_one ha h hk).trans (le_add_of_nonneg_right (pow_nonneg ha _))
  · have hk1 : 1 ≤ a ^ k := one_le_pow₀ h
    have he : a ^ (2 * k) = (a ^ k) ^ 2 := by rw [← pow_mul, Nat.mul_comm]
    have hb : a ^ k ≤ a ^ (2 * k) := by
      rw [he]
      nlinarith [mul_nonneg (pow_nonneg ha k) (sub_nonneg.mpr hk1)]
    exact hb.trans (le_add_of_nonneg_left (pow_nonneg ha _))

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU in
private theorem taylor_phase_norm_aemeasurable (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    AEMeasurable (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖) P :=
  ((textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).sub
      aemeasurable_const).norm

include hB hU hp in
/-- Every nonnegative integer norm power of the same actual phase increment is
integrable near zero, derived from the genuine even moment domination. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (k : ℕ) :
    Integrable (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ k) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  cases k with
  | zero => simpa only [pow_zero] using (integrable_const (1 : ℝ) : Integrable (fun _ : Ω ↦ (1 : ℝ)) P)
  | succ k =>
    have hi := textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
      B P hB U hU hp L hF γ σ hγ T hT hT1 x (k + 1) (by omega)
    have hu := (integrable_const (1 : ℝ)).add hi
    have hm := (taylor_phase_norm_aemeasurable B P hB U hU L hF γ σ T hT x).pow_const (k + 1)
    exact hu.mono_nonneg hm.aestronglyMeasurable
      (Eventually.of_forall (fun _ ↦ pow_nonneg (norm_nonneg _) _))
      (Eventually.of_forall (fun sample ↦ taylor_moment_power_bound
        ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ (k + 1)))

include hB hU hp in
/-- The square of the actual third absolute phase-increment moment is O(T³),
from actual L² Holder and genuine second/fourth moment bounds. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_third_norm_moment_square_bound
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 3 ∂P) ^ 2 ≤ C * T ^ 3 := by
  obtain ⟨C, hC, hc⟩ := textbookLangevinPeriodicRealPhaseIncrement_norm_even_moment_bound
    B P hB U hU hp L hF γ σ hγ x 1 (by norm_num)
  obtain ⟨D, hD, hd⟩ := textbookLangevinPeriodicRealPhaseIncrement_norm_even_moment_bound
    B P hB U hU hp L hF γ σ hγ x 2 (by norm_num)
  refine ⟨C * D, mul_nonneg hC hD, fun t ht ht1 ↦ ?_⟩
  let f : Ω → ℝ := fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖
  let g : Ω → ℝ := fun sample ↦ f sample ^ 2
  have hm : AEMeasurable f P := taylor_phase_norm_aemeasurable B P hB U hU L hF γ σ t ht x
  have hi2 : Integrable (fun sample ↦ f sample ^ 2) P := by
    simpa only [f] using textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht ht1 x 2
  have hi4 : Integrable (fun sample ↦ g sample ^ 2) P := by
    have he : (fun sample ↦ g sample ^ 2) =
        (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 4) := by
      funext sample
      dsimp only [f, g]
      ring
    rw [he]
    exact textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht ht1 x 4
  have hf : MemLp f 2 P := (memLp_two_iff_integrable_sq hm.aestronglyMeasurable).mpr hi2
  have hg : MemLp g 2 P :=
    (memLp_two_iff_integrable_sq (hm.pow_const 2).aestronglyMeasurable).mpr hi4
  have hh := taylor_moment_product_cauchy P f g hf hg
  have he : (fun sample ↦ f sample * g sample) =
      (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 3) := by
    funext sample
    dsimp only [f, g]
    ring
  rw [he, Real.norm_eq_abs, abs_of_nonneg (integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) 3))] at hh
  have hI2 : 0 ≤ ∫ sample, f sample ^ 2 ∂P := integral_nonneg (fun _ ↦ sq_nonneg _)
  have hI4 : 0 ≤ ∫ sample, g sample ^ 2 ∂P := integral_nonneg (fun _ ↦ sq_nonneg _)
  have hs := pow_le_pow_left₀
    (integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) 3)) hh 2
  rw [mul_pow, Real.sq_sqrt hI2, Real.sq_sqrt hI4] at hs
  have hc' : (∫ sample, f sample ^ 2 ∂P) ≤ C * t := by simpa only [f, Nat.reduceMul, pow_one] using hc t ht ht1
  have hd' : (∫ sample, g sample ^ 2 ∂P) ≤ D * t ^ 2 := by
    have he : (fun sample ↦ g sample ^ 2) =
        (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 4) := by
      funext sample
      dsimp only [f, g]
      ring
    rw [he]
    simpa only [Nat.reduceMul] using hd t ht ht1
  calc
    _ ≤ (∫ sample, f sample ^ 2 ∂P) * (∫ sample, g sample ^ 2 ∂P) := hs
    _ ≤ (C * t) * (D * t ^ 2) := mul_le_mul hc' hd' hI4 (mul_nonneg hC ht)
    _ = _ := by ring

include hB hU hp in
/-- The genuine actual third absolute phase-increment moment divided by time
vanishes, as needed for the original Hamiltonian power Taylor remainder. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_third_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 3 ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, hC, hb⟩ := textbookLangevinPeriodicRealPhaseIncrement_third_norm_moment_square_bound
    B P hB U hU hp L hF γ σ hγ x
  have hc : Continuous (fun t : ℝ ↦ Real.sqrt (C * t)) := by fun_prop
  have hlim : Tendsto (fun t : ℝ ↦ Real.sqrt (C * t)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [mul_zero, Real.sqrt_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  apply squeeze_zero' _ _ hlim
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) 3)) ht.le
  · filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    let I := ∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 3 ∂P
    have hI : 0 ≤ I := integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)
    have hs : (I / t) ^ 2 ≤ C * t := by
      calc
        _ = I ^ 2 / t ^ 2 := div_pow _ _ _
        _ ≤ C * t ^ 3 / t ^ 2 := div_le_div_of_nonneg_right (hb t ht0.le ht1'.le) (sq_nonneg t)
        _ = _ := by field_simp
    have hsqrt := Real.sq_sqrt (mul_nonneg hC ht0.le)
    have hdiv := div_nonneg hI ht0.le
    have hsqrt0 := Real.sqrt_nonneg (C * t)
    change I / t ≤ Real.sqrt (C * t)
    nlinarith

include hB hU hp in
/-- Every actual absolute integer phase-increment moment of order k≥3 divided
by time tends to zero; no target remainder or moment limit is assumed. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_integer_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (k : ℕ) (hk : 3 ≤ k) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ k ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  have h3 := textbookLangevinPeriodicRealPhaseIncrement_norm_third_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x
  have he := textbookLangevinPeriodicRealPhaseIncrement_norm_even_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x k (by omega)
  apply squeeze_zero' _ _ (by simpa only [zero_add] using h3.add he)
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)) ht.le
  · filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    have hi := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x k
    have hi3 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x 3
    have hi2k := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x (2 * k)
    have hb := integral_mono_ae hi (hi3.add hi2k)
      (Eventually.of_forall (fun sample ↦ taylor_moment_higher_bound
        ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ (norm_nonneg _) k hk))
    simp only [Pi.add_apply] at hb
    rw [integral_add
      (f := fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 3)
      (g := fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ (2 * k)) hi3 hi2k] at hb
    exact (div_le_div_of_nonneg_right hb ht0.le).trans_eq (add_div _ _ _)

end
end MolecularDynamics
