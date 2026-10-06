import MolecularDynamics.Chapter06.BrownianExpectationEstimates

/-! Necessary true second-moment asymptotics of the same original Brownian
configuration for the actual stochastic-generator identification. -/

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
/-- One derived original drift bound controls the actual drift integral for every initial state and nonnegative time. -/
theorem textbookBrownianGlobalDriftIntegral_norm_bound_ae :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      ∀ᵐ sample ∂P, ‖textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t sample‖ ≤ M * t := by
  obtain ⟨M, hM, hbound⟩ := textbookBrownianSDEDrift_bounded m U hU hPU
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae
    m hm U hU hPU β hβ B P hB x] with sample hs
  exact (textbookBrownianIntegralSolution_drift_integral_bound m U hU hPU β t x
    (fun s ↦ B s.toNNReal sample)
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B · sample)
    (hs t ht) M hbound t ⟨ht, le_rfl⟩).2

include hB in
/-- Genuine bounded drift integrals have all Lp orders, including essential boundedness. -/
theorem textbookBrownianGlobalDriftIntegral_memLp
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) (p : ℝ≥0∞) :
    MemLp (textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t) p P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hb⟩ := textbookBrownianGlobalDriftIntegral_norm_bound_ae m hm U hU hPU β hβ B P hB
  obtain ⟨_, _, hi⟩ := textbookBrownianGlobalDriftIntegral_integrable_bound m hm U hU hPU β hβ B P hB
  exact MemLp.of_bound (hi x t ht).1.aestronglyMeasurable (M * t) (hb x t ht)

include hB in
/-- The actual configuration increment, rather than just its noise, has every finite Lp order. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_memLp
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) (p : ℝ≥0∞) (hp : p ≠ (∞ : ℝ≥0∞)) :
    MemLp (fun sample ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) p P := by
  have hd := textbookBrownianGlobalDriftIntegral_memLp m hm U hU hPU β hβ B P hB x t ht p
  have hn := textbookBrownianPhysicalNoise_memLp m β B P hB t.toNNReal p hp
  apply (memLp_congr_ae ?_).mp (hd.add hn)
  filter_upwards [textbookBrownianGlobalDriftIntegral_ae_eq m hm U hU hPU β hβ B P hB x t ht] with sample hs
  change textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t sample +
      textbookBrownianSDENoise m β (B t.toNNReal sample) =
    textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  rw [hs]
  abel

include hB in
/-- Every actual increment coordinate has its genuine finite-order moment integrability. -/
theorem textbookBrownianGlobalRandomConfiguration_increment_coordinate_memLp
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) (i : Fin Nc)
    (p : ℝ≥0∞) (hp : p ≠ (∞ : ℝ≥0∞)) :
    MemLp (fun sample ↦
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i) p P :=
  (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht p hp).eval i

include hB in
/-- Actual mixed second moments are genuinely integrable before manipulating their expectations. -/
theorem textbookBrownianGlobalRandomConfiguration_second_product_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) (i j : Fin Nc) :
    Integrable (fun sample ↦
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j) P :=
  (textbookBrownianGlobalRandomConfiguration_increment_coordinate_memLp m hm U hU hPU β hβ B P hB x t ht i 2 (by norm_num)).integrable_mul
    (textbookBrownianGlobalRandomConfiguration_increment_coordinate_memLp m hm U hU hPU β hβ B P hB x t ht j 2 (by norm_num))

include hB in
/-- The actual mixed second moment differs from the original physical covariance by a genuinely derived O(t^2+t^(3/2)) bound, uniformly in the initial state and coordinates. -/
theorem textbookBrownianGlobalRandomConfiguration_second_product_error_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t → ∀ i j : Fin Nc,
      |(∫ sample,
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j ∂P) -
          textbookBrownianSDENoiseAmplitude m β i * textbookBrownianSDENoiseAmplitude m β j *
            (if i = j then t else 0)| ≤
        M * t * (M * t + 2 * (∑ k : Fin Nc, Real.sqrt (2 * β⁻¹ * (m k)⁻¹)) * Real.sqrt t) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨MD, hMD, hbD⟩ := textbookBrownianGlobalDriftIntegral_norm_bound_ae m hm U hU hPU β hβ B P hB
  obtain ⟨MX, hMX, hX⟩ := textbookBrownianGlobalRandomConfiguration_increment_expectation_bound
    m hm U hU hPU β hβ B P hB
  let M : ℝ := max MD MX
  have hM : 0 ≤ M := hMD.trans (le_max_left MD MX)
  refine ⟨M, hM, fun x t ht i j ↦ ?_⟩
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦
    textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  let N : Ω → (Fin Nc → ℝ) := fun sample ↦ textbookBrownianSDENoise m β (B t.toNNReal sample)
  let D := textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t
  let C : ℝ := ∑ k : Fin Nc, Real.sqrt (2 * β⁻¹ * (m k)⁻¹)
  have hXi : Integrable X P := (hX x t ht).1
  have hNi : Integrable N P := textbookBrownianPhysicalNoise_integrable m β B P hB t.toNNReal
  have hXij : Integrable (fun sample ↦ X sample i * X sample j) P :=
    textbookBrownianGlobalRandomConfiguration_second_product_integrable m hm U hU hPU β hβ B P hB x t ht i j
  have hNij : Integrable (fun sample ↦ N sample i * N sample j) P :=
    (textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t.toNNReal i 2 (by norm_num)).integrable_mul
      (textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t.toNNReal j 2 (by norm_num))
  have hb : ∀ᵐ sample ∂P, ‖D sample‖ ≤ M * t :=
    (hbD x t ht).mono fun sample hs ↦ hs.trans (mul_le_mul_of_nonneg_right (le_max_left MD MX) ht)
  have ha : ∀ᵐ sample ∂P,
      |X sample i * X sample j - N sample i * N sample j| ≤ M * t * (‖X sample‖ + ‖N sample‖) := by
    filter_upwards [hb, textbookBrownianGlobalDriftIntegral_ae_eq m hm U hU hPU β hβ B P hB x t ht]
      with sample hs he
    have hei : D sample i = X sample i - N sample i := congrFun he i
    have hej : D sample j = X sample j - N sample j := congrFun he j
    have heq : X sample i * X sample j - N sample i * N sample j =
        D sample i * X sample j + N sample i * D sample j := by rw [hei, hej]; ring
    have hdi : |D sample i| ≤ M * t :=
      (norm_le_pi_norm (D sample) i).trans hs
    have hdj : |D sample j| ≤ M * t :=
      (norm_le_pi_norm (D sample) j).trans hs
    calc
      _ ≤ |D sample i * X sample j| + |N sample i * D sample j| := by rw [heq]; exact abs_add_le _ _
      _ = |D sample i| * |X sample j| + |N sample i| * |D sample j| := by rw [abs_mul, abs_mul]
      _ ≤ M * t * ‖X sample‖ + ‖N sample‖ * (M * t) := add_le_add
        (mul_le_mul hdi (norm_le_pi_norm (X sample) j) (abs_nonneg _) (mul_nonneg hM ht))
        (mul_le_mul (norm_le_pi_norm (N sample) i) hdj (abs_nonneg _) (norm_nonneg _))
      _ = _ := by ring
  have hNx : (∫ sample, ‖N sample‖ ∂P) ≤ C * Real.sqrt t := by
    simpa only [N, C, Real.coe_toNNReal t ht] using textbookBrownianPhysicalNoise_norm_mean_le m hm β hβ B P hB t.toNNReal
  have hXx : (∫ sample, ‖X sample‖ ∂P) ≤ M * t + C * Real.sqrt t :=
    (hX x t ht).2.trans (add_le_add (mul_le_mul_of_nonneg_right (le_max_right MD MX) ht) le_rfl)
  have hcov : (∫ sample, N sample i * N sample j ∂P) =
      textbookBrownianSDENoiseAmplitude m β i * textbookBrownianSDENoiseAmplitude m β j *
        (if i = j then t else 0) := by
    simpa only [N, Real.coe_toNNReal t ht] using textbookBrownianPhysicalNoise_second_product m β B P hB t.toNNReal i j
  calc
    _ = |∫ sample, X sample i * X sample j - N sample i * N sample j ∂P| := by
      rw [integral_sub hXij hNij, hcov]
    _ ≤ ∫ sample, |X sample i * X sample j - N sample i * N sample j| ∂P := by
      simpa only [Real.norm_eq_abs] using
        (norm_integral_le_integral_norm (fun sample : Ω ↦ X sample i * X sample j - N sample i * N sample j) (μ := P))
    _ ≤ ∫ sample, M * t * (‖X sample‖ + ‖N sample‖) ∂P :=
      integral_mono_ae (hXij.sub hNij).norm ((hXi.norm.add hNi.norm).const_mul _) ha
    _ = M * t * ((∫ sample, ‖X sample‖ ∂P) + ∫ sample, ‖N sample‖ ∂P) := by
      rw [integral_const_mul, integral_add hXi.norm hNi.norm]
    _ ≤ M * t * (M * t + 2 * C * Real.sqrt t) :=
      (mul_le_mul_of_nonneg_left (add_le_add hXx hNx) (mul_nonneg hM ht)).trans_eq (by ring)
    _ = _ := rfl


include hB in
/-- The true mixed second-moment quotient of the original configuration converges to its actual mass-weighted diffusion covariance. -/
theorem textbookBrownianGlobalRandomConfiguration_second_product_div_tendsto
    (x : Fin Nc → ℝ) (i j : Fin Nc) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
      (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j ∂P) / t)
      (𝓝[>] 0) (𝓝 (textbookBrownianSDENoiseAmplitude m β i *
        textbookBrownianSDENoiseAmplitude m β j * (if i = j then 1 else 0))) := by
  obtain ⟨M, _, hM⟩ := textbookBrownianGlobalRandomConfiguration_second_product_error_bound
    m hm U hU hPU β hβ B P hB
  let C : ℝ := ∑ k : Fin Nc, Real.sqrt (2 * β⁻¹ * (m k)⁻¹)
  let c : ℝ := textbookBrownianSDENoiseAmplitude m β i *
    textbookBrownianSDENoiseAmplitude m β j * (if i = j then 1 else 0)
  let S : ℝ → ℝ := fun t ↦ ∫ sample,
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j ∂P
  have hbound : ∀ᶠ t in 𝓝[>] (0 : ℝ), ‖S t / t - c‖ ≤ M * (M * t + 2 * C * Real.sqrt t) := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have hcov : textbookBrownianSDENoiseAmplitude m β i *
        textbookBrownianSDENoiseAmplitude m β j * (if i = j then t else 0) = c * t := by
      dsimp [c]
      split_ifs <;> ring
    have herr : |S t - c * t| ≤ M * t * (M * t + 2 * C * Real.sqrt t) := by
      simpa only [S, C, hcov] using hM x t ht0.le i j
    calc
      ‖S t / t - c‖ = |S t - c * t| / t := by
        have he : S t / t - c = (S t - c * t) / t := by field_simp [ht0.ne']
        rw [Real.norm_eq_abs, he, abs_div, abs_of_pos ht0]
      _ ≤ (M * t * (M * t + 2 * C * Real.sqrt t)) / t :=
        (div_le_div_iff_of_pos_right ht0).mpr herr
      _ = M * (M * t + 2 * C * Real.sqrt t) := by field_simp [ht0.ne']
  have hc : Continuous (fun t : ℝ ↦ M * (M * t + 2 * C * Real.sqrt t)) := by fun_prop
  have hlim : Tendsto (fun t : ℝ ↦ M * (M * t + 2 * C * Real.sqrt t)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [mul_zero, Real.sqrt_zero, add_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  have hz := squeeze_zero_norm' hbound hlim
  simpa only [sub_add_cancel, zero_add] using hz.add_const c

include hB in
/-- The actual diagonal second moment recovers exactly the original coefficient 2 beta^-1 m_i^-1 at short times. -/
theorem textbookBrownianGlobalRandomConfiguration_second_moment_div_tendsto
    (x : Fin Nc → ℝ) (i : Fin Nc) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      ((textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i)^2 ∂P) / t)
      (𝓝[>] 0) (𝓝 (2 * β⁻¹ * (m i)⁻¹)) := by
  simpa [← pow_two, textbookBrownianSDENoiseAmplitude_sq m hm β hβ i] using
    textbookBrownianGlobalRandomConfiguration_second_product_div_tendsto m hm U hU hPU β hβ B P hB x i i

end
end MolecularDynamics
