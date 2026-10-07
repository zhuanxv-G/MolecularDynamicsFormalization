import MolecularDynamics.Chapter06.BrownianFellerContinuity
import Mathlib.MeasureTheory.SpecificCodomains.Pi

/-! Actual original-mass noise moments and pathwise short-time drift estimates
needed for identification of the genuine Brownian probability generator. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- Each original mass-weighted physical noise coordinate has genuine moments of every finite order. -/
theorem textbookBrownianPhysicalNoise_coordinate_memLp (t : ℝ≥0) (i : Fin Nc)
    (p : ℝ≥0∞) (hp : p ≠ (∞ : ℝ≥0∞)) :
    MemLp (fun sample ↦ textbookBrownianSDENoise m β (B t sample) i) p P := by
  have he : (fun sample ↦ textbookBrownianSDENoise m β (B t sample) i) =
      fun sample ↦ textbookBrownianSDENoiseAmplitude m β i * B t sample i :=
    funext (fun sample ↦ textbookBrownianSDENoise_apply m β (B t sample) i)
  rw [he]
  exact ((hB.gaussian.hasGaussianLaw_eval ⟨i, t⟩).memLp hp).const_mul _

include hB in
/-- The whole actual finite-coordinate physical noise has genuine finite-order moments. -/
theorem textbookBrownianPhysicalNoise_memLp (t : ℝ≥0)
    (p : ℝ≥0∞) (hp : p ≠ (∞ : ℝ≥0∞)) :
    MemLp (fun sample ↦ textbookBrownianSDENoise m β (B t sample)) p P :=
  memLp_pi_iff.mpr (fun i ↦ textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t i p hp)

include hB in
/-- Each original mass-weighted noise coordinate is genuinely integrable. -/
theorem textbookBrownianPhysicalNoise_coordinate_integrable (t : ℝ≥0) (i : Fin Nc) :
    Integrable (fun sample ↦ textbookBrownianSDENoise m β (B t sample) i) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  exact (textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t i 1 (by norm_num)).integrable (by norm_num)

include hB in
/-- The whole actual finite-coordinate noise is Bochner integrable. -/
theorem textbookBrownianPhysicalNoise_integrable (t : ℝ≥0) :
    Integrable (fun sample ↦ textbookBrownianSDENoise m β (B t sample)) P :=
  Integrable.of_eval (textbookBrownianPhysicalNoise_coordinate_integrable m β B P hB t)

include hB in
/-- Every original physical noise coordinate has its actual zero expectation. -/
theorem textbookBrownianPhysicalNoise_coordinate_mean (t : ℝ≥0) (i : Fin Nc) :
    (∫ sample, textbookBrownianSDENoise m β (B t sample) i ∂P) = 0 := by
  simp only [textbookBrownianSDENoise_apply, integral_const_mul, hB.mean, mul_zero]

include hB in
/-- The whole actual physical noise has true zero Bochner mean. -/
theorem textbookBrownianPhysicalNoise_mean (t : ℝ≥0) :
    (∫ sample, textbookBrownianSDENoise m β (B t sample) ∂P) = 0 := by
  ext i
  rw [eval_integral (textbookBrownianPhysicalNoise_coordinate_integrable m β B P hB t) i]
  exact textbookBrownianPhysicalNoise_coordinate_mean m β B P hB t i

include hB in
/-- The actual physical noise cross second moment is its true amplitude-weighted isotropic Wiener covariance. -/
theorem textbookBrownianPhysicalNoise_second_product (t : ℝ≥0) (i j : Fin Nc) :
    (∫ sample, textbookBrownianSDENoise m β (B t sample) i *
      textbookBrownianSDENoise m β (B t sample) j ∂P) =
      textbookBrownianSDENoiseAmplitude m β i * textbookBrownianSDENoiseAmplitude m β j *
        (if i = j then (t : ℝ) else 0) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi := textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t i 2 (by norm_num)
  have hj := textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t j 2 (by norm_num)
  have hc := covariance_eq_sub hi hj
  have hc' : cov[fun sample ↦ textbookBrownianSDENoise m β (B t sample) i,
      fun sample ↦ textbookBrownianSDENoise m β (B t sample) j; P] =
      textbookBrownianSDENoiseAmplitude m β i * textbookBrownianSDENoiseAmplitude m β j *
        (if i = j then (t : ℝ) else 0) := by
    simp only [textbookBrownianSDENoise_apply, covariance_const_mul_left,
      covariance_const_mul_right, hB.covariance, min_self]
    ring
  simpa only [Pi.mul_apply, textbookBrownianPhysicalNoise_coordinate_mean m β B P hB t i,
    textbookBrownianPhysicalNoise_coordinate_mean m β B P hB t j, mul_zero, sub_zero] using hc.symm.trans hc'

include hm hβ hB in
/-- Each original coordinate has exactly the original positive-mass diffusion second moment. -/
theorem textbookBrownianPhysicalNoise_second_moment (t : ℝ≥0) (i : Fin Nc) :
    (∫ sample, (textbookBrownianSDENoise m β (B t sample) i)^2 ∂P) =
      2 * β⁻¹ * (m i)⁻¹ * t := by
  have h := textbookBrownianPhysicalNoise_second_product m β B P hB t i i
  simpa [← pow_two, textbookBrownianSDENoiseAmplitude_sq m hm β hβ i] using h


include hm hβ hB in
/-- Each actual original physical noise absolute first moment has the true diffusion square-root-time bound. -/
theorem textbookBrownianPhysicalNoise_coordinate_norm_mean_le (t : ℝ≥0) (i : Fin Nc) :
    (∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖ ∂P) ≤
      Real.sqrt (2 * β⁻¹ * (m i)⁻¹ * t) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hLp := textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t i 2 (by norm_num)
  have hsq : (∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖ ^ 2 ∂P) =
      2 * β⁻¹ * (m i)⁻¹ * t := by
    simpa only [Real.norm_eq_abs, sq_abs] using
      textbookBrownianPhysicalNoise_second_moment m hm β hβ B P hB t i
  have hv := variance_nonneg (fun sample ↦ ‖textbookBrownianSDENoise m β (B t sample) i‖) P
  rw [variance_eq_sub hLp.norm] at hv
  simp only [Pi.pow_apply] at hv
  have hv' : (∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖ ∂P)^2 ≤
      2 * β⁻¹ * (m i)⁻¹ * t := by
    nlinarith [hsq]
  have hn : 0 ≤ ∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖ ∂P :=
    integral_nonneg (fun _ ↦ norm_nonneg _)
  have hc : 0 ≤ 2 * β⁻¹ * (m i)⁻¹ * (t : ℝ) :=
    mul_nonneg (mul_nonneg (mul_nonneg zero_le_two (inv_nonneg.mpr hβ.le))
      (inv_nonneg.mpr (hm i).le)) t.property
  have hs := Real.sq_sqrt hc
  have hs0 := Real.sqrt_nonneg (2 * β⁻¹ * (m i)⁻¹ * (t : ℝ))
  nlinarith

include hm hβ hB in
/-- The whole actual finite-coordinate physical noise has a derived square-root-time first-moment bound. -/
theorem textbookBrownianPhysicalNoise_norm_mean_le (t : ℝ≥0) :
    (∫ sample, ‖textbookBrownianSDENoise m β (B t sample)‖ ∂P) ≤
      (∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)) * Real.sqrt (t : ℝ) := by
  have hi (i : Fin Nc) : Integrable (fun sample ↦ ‖textbookBrownianSDENoise m β (B t sample) i‖) P :=
    (textbookBrownianPhysicalNoise_coordinate_integrable m β B P hB t i).norm
  have hs : Integrable (fun sample ↦ ∑ i : Fin Nc, ‖textbookBrownianSDENoise m β (B t sample) i‖) P :=
    integrable_finsetSum Finset.univ (fun i _ ↦ hi i)
  have hp (sample : Ω) : ‖textbookBrownianSDENoise m β (B t sample)‖ ≤
      ∑ i : Fin Nc, ‖textbookBrownianSDENoise m β (B t sample) i‖ := by
    apply (pi_norm_le_iff_of_nonneg (Finset.sum_nonneg (fun i _ ↦ norm_nonneg _))).mpr
    intro i
    exact Finset.single_le_sum (fun j _ ↦ norm_nonneg _) (Finset.mem_univ i)
  calc
    _ ≤ ∫ sample, ∑ i : Fin Nc, ‖textbookBrownianSDENoise m β (B t sample) i‖ ∂P :=
      integral_mono (textbookBrownianPhysicalNoise_integrable m β B P hB t).norm hs hp
    _ = ∑ i : Fin Nc, ∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖ ∂P :=
      integral_finsetSum Finset.univ (fun i _ ↦ hi i)
    _ ≤ ∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹ * (t : ℝ)) :=
      Finset.sum_le_sum (fun i _ ↦ textbookBrownianPhysicalNoise_coordinate_norm_mean_le m hm β hβ B P hB t i)
    _ = _ := by
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro i _
      have hcoef : 0 ≤ 2 * β⁻¹ * (m i)⁻¹ :=
        mul_nonneg (mul_nonneg zero_le_two (inv_nonneg.mpr hβ.le)) (inv_nonneg.mpr (hm i).le)
      exact Real.sqrt_mul hcoef (t : ℝ)

include hU hPU in
/-- Original smooth periodicity gives a genuine global bound for the actual positive-mass drift. -/
theorem textbookBrownianSDEDrift_bounded :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖textbookBrownianSDEDrift m U q‖ ≤ M := by
  obtain ⟨M, hM, hbound⟩ := textbookUnitPeriodicPotential_force_bound U hU hPU
  refine ⟨‖textbookBrownianMassMobility m‖ * M, mul_nonneg (norm_nonneg _) hM, fun q ↦ ?_⟩
  exact ((textbookBrownianMassMobility m).le_opNorm _).trans
    (mul_le_mul_of_nonneg_left (hbound q) (norm_nonneg _))

include hU hPU in
/-- Every actual original integral path has genuine drift integrability and its true bounded-drift increment estimate. -/
theorem textbookBrownianIntegralSolution_drift_integral_bound
    (T : ℝ) (x : Fin Nc → ℝ) (W q : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (M : ℝ) (hM : ∀ y, ‖textbookBrownianSDEDrift m U y‖ ≤ M)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    IntervalIntegrable (fun s ↦ textbookBrownianSDEDrift m U (q s)) volume 0 t ∧
      ‖∫ s in 0..t, textbookBrownianSDEDrift m U (q s)‖ ≤ M * t := by
  have hc := (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).continuous
  have hq' : ContinuousOn q (Icc 0 t) :=
    hq.1.mono (fun s hs ↦ ⟨hs.1, hs.2.trans ht.2⟩)
  refine ⟨(hc.comp_continuousOn hq').intervalIntegrable_of_Icc (μ := volume) ht.1, ?_⟩
  have hb := intervalIntegral.norm_integral_le_of_norm_le_const
    (a := (0 : ℝ)) (b := t) (fun s _ ↦ hM (q s))
  simpa only [sub_zero, abs_of_nonneg ht.1] using hb

include hU hPU in
/-- Every actual original path displacement is controlled by true bounded drift and its actual physical noise increment. -/
theorem textbookBrownianIntegralSolution_displacement_bound
    (T : ℝ) (x : Fin Nc → ℝ) (W q : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (M : ℝ) (hM : ∀ y, ‖textbookBrownianSDEDrift m U y‖ ≤ M)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    ‖q t - x‖ ≤ M * t + ‖textbookBrownianSDENoise m β‖ * ‖W t - W 0‖ := by
  have he : q t - x = (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) +
      textbookBrownianSDENoise m β (W t - W 0) := by
    rw [hq.2.2 t ht]
    abel
  rw [he]
  exact (norm_add_le _ _).trans (add_le_add
    (textbookBrownianIntegralSolution_drift_integral_bound m U hU hPU β T x W q hq M hM t ht).2
    ((textbookBrownianSDENoise m β).le_opNorm _))

include hm hU hPU hβ hB in
/-- The same actual global Wiener-driven configuration has a derived all-time displacement bound on one full-measure set. -/
theorem textbookBrownianGlobalRandomConfiguration_displacement_bound_ae (x : Fin Nc → ℝ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t →
      ‖textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B t sample - x‖ ≤
        M * t + ‖textbookBrownianSDENoise m β‖ * ‖B t.toNNReal sample‖ := by
  obtain ⟨M, hM, hbound⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  refine ⟨M, hM, ?_⟩
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x,
    textbookWienerVector_zero_ae B P hB] with sample hs hz
  intro t ht
  have hb := textbookBrownianIntegralSolution_displacement_bound m U hU hPU β t x
    (fun s ↦ B s.toNNReal sample)
    (textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B · sample)
    (hs t ht) M hbound t ⟨ht, le_rfl⟩
  simpa only [Real.toNNReal_zero, hz, sub_zero] using hb

/-- The literal error after freezing the original drift at its actual initial position. -/
def textbookBrownianFrozenDriftError (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (t : ℝ) : Fin Nc → ℝ :=
  q t - x - t • textbookBrownianSDEDrift m U x -
    textbookBrownianSDENoise m β (W t - W 0)

include hU hPU in
/-- The actual frozen-drift error is exactly the true time integral of the original drift difference. -/
theorem textbookBrownianFrozenDriftError_eq_integral
    (T : ℝ) (x : Fin Nc → ℝ) (W q : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    textbookBrownianFrozenDriftError m U β x W q t =
      ∫ s in 0..t, textbookBrownianSDEDrift m U (q s) - textbookBrownianSDEDrift m U x := by
  have hc := (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).continuous
  have hq' : ContinuousOn q (Icc 0 t) :=
    hq.1.mono (fun s hs ↦ ⟨hs.1, hs.2.trans ht.2⟩)
  have hi : IntervalIntegrable (fun s ↦ textbookBrownianSDEDrift m U (q s)) volume 0 t :=
    (hc.comp_continuousOn hq').intervalIntegrable_of_Icc (μ := volume) ht.1
  calc
    _ = (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) - t • textbookBrownianSDEDrift m U x := by
      unfold textbookBrownianFrozenDriftError
      rw [hq.2.2 t ht]
      abel
    _ = (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) -
        (∫ _ in 0..t, textbookBrownianSDEDrift m U x) := by
      rw [intervalIntegral.integral_const, sub_zero]
    _ = _ := (intervalIntegral.integral_sub hi
      (intervalIntegrable_const (c := textbookBrownianSDEDrift m U x))).symm

include hU hPU in
/-- The genuine frozen-drift error is controlled by the derived original drift Lipschitz constant and the actual path displacement. -/
theorem textbookBrownianFrozenDriftError_norm_le
    (T : ℝ) (x : Fin Nc → ℝ) (W q : ℝ → (Fin Nc → ℝ))
    (hq : textbookBrownianIntegralSolution m U β T x W q)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    ‖textbookBrownianFrozenDriftError m U β x W q t‖ ≤
      (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
        ∫ s in 0..t, ‖q s - x‖ := by
  rw [textbookBrownianFrozenDriftError_eq_integral m U hU hPU β T x W q hq t ht]
  have hq' : ContinuousOn q (Icc 0 t) :=
    hq.1.mono (fun s hs ↦ ⟨hs.1, hs.2.trans ht.2⟩)
  have hc : ContinuousOn (fun s ↦
      (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) * ‖q s - x‖) (Icc 0 t) :=
    continuousOn_const.mul (hq'.sub continuousOn_const).norm
  have hb := intervalIntegral.norm_integral_le_of_norm_le ht.1
    (Eventually.of_forall (fun s _ ↦
      (textbookBrownianDriftLipschitzConstant_spec m U hU hPU).norm_sub_le (q s) x))
    (hc.intervalIntegrable_of_Icc (μ := volume) ht.1)
  simpa only [intervalIntegral.integral_const_mul] using hb

include hm hU hPU hβ hB in
/-- The same actual global process obeys the frozen-drift error estimate at every nonnegative time on one full-measure set. -/
theorem textbookBrownianGlobalRandomConfiguration_frozenDriftError_ae (x : Fin Nc → ℝ) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t →
      ‖textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B t sample -
        x - t • textbookBrownianSDEDrift m U x - textbookBrownianSDENoise m β (B t.toNNReal sample)‖ ≤
      (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
        ∫ s in 0..t, ‖textbookBrownianGlobalRandomConfiguration (Ω := Ω)
          m hm U hU hPU β hβ x B s sample - x‖ := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB x,
    textbookWienerVector_zero_ae B P hB] with sample hs hz
  intro t ht
  have hb := textbookBrownianFrozenDriftError_norm_le m U hU hPU β t x
    (fun s ↦ B s.toNNReal sample)
    (textbookBrownianGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B · sample)
    (hs t ht) t ⟨ht, le_rfl⟩
  simpa only [textbookBrownianFrozenDriftError, Real.toNNReal_zero, hz, sub_zero] using hb

end
end MolecularDynamics