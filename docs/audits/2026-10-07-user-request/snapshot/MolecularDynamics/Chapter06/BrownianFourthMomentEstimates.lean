import MolecularDynamics.Chapter06.BrownianSecondMomentEstimates

/-! Genuine Gaussian fourth-moment scaling and actual Brownian configuration
fourth moments needed to control the stochastic-generator Taylor remainder. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

/-- The true standard Gaussian fourth norm moment, rather than an assumed noise bound. -/
def textbookBrownianStandardGaussianFourthMoment : ℝ :=
  ∫ z : ℝ, ‖z‖^4 ∂gaussianReal 0 1

/-- The fixed fourth moment exists by genuine Gaussian finite-order integrability. -/
theorem textbookBrownianStandardGaussianFourthMoment_integrable :
    Integrable (fun z : ℝ ↦ ‖z‖^4) (gaussianReal 0 1) := by
  have h : MemLp (id : ℝ → ℝ) (4 : ℝ≥0∞) (gaussianReal 0 1) :=
    (IsGaussian.hasGaussianLaw_id (μ := gaussianReal 0 1)).memLp (by norm_num)
  exact h.integrable_norm_pow (by norm_num)

/-- The actual fixed Gaussian fourth norm moment is nonnegative. -/
theorem textbookBrownianStandardGaussianFourthMoment_nonneg :
    0 ≤ textbookBrownianStandardGaussianFourthMoment :=
  integral_nonneg fun z ↦ pow_nonneg (norm_nonneg z) 4

/-- The real Gaussian distribution at time t is genuinely the pushforward of the standard Gaussian by sqrt t. -/
theorem textbookBrownianGaussian_time_sqrt_map (t : ℝ≥0) :
    (gaussianReal 0 1).map (fun z : ℝ ↦ Real.sqrt (t : ℝ) * z) = gaussianReal 0 t := by
  have hv : (NNReal.mk ((Real.sqrt (t : ℝ))^2) (sq_nonneg _)) = t :=
    NNReal.eq (Real.sq_sqrt t.property)
  have he : (gaussianReal 0 1).map (fun z : ℝ ↦ Real.sqrt (t : ℝ) * z) =
      gaussianReal 0 (NNReal.mk ((Real.sqrt (t : ℝ))^2) (sq_nonneg _)) := by
    simpa only [mul_zero, mul_one] using
      gaussianReal_map_const_mul (μ := (0 : ℝ)) (v := (1 : ℝ≥0)) (Real.sqrt (t : ℝ))
  exact he.trans (congrArg (gaussianReal (0 : ℝ)) hv)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The actual original physical coordinate noise has the true fourth moment scaling t^2, proved from its genuine Gaussian time law. -/
theorem textbookBrownianPhysicalNoise_coordinate_fourth_moment (t : ℝ≥0) (i : Fin Nc) :
    (∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖^4 ∂P) =
      (textbookBrownianSDENoiseAmplitude m β i)^4 * (t : ℝ)^2 *
        textbookBrownianStandardGaussianFourthMoment := by
  have htLaw := (textbookWienerVector_coordinate B P hB i).hasLaw_eval t
  let a : ℝ := textbookBrownianSDENoiseAmplitude m β i
  have hc : Continuous (fun z : ℝ ↦ ‖a * z‖^4) := by fun_prop
  calc
    _ = ∫ z : ℝ, ‖a * z‖^4 ∂gaussianReal 0 t := by
      simp only [textbookBrownianSDENoise_apply]
      exact htLaw.integral_comp hc.aestronglyMeasurable
    _ = ∫ z : ℝ, ‖a * (Real.sqrt (t : ℝ) * z)‖^4 ∂gaussianReal 0 1 := by
      rw [← textbookBrownianGaussian_time_sqrt_map t]
      exact integral_map (by fun_prop) hc.aestronglyMeasurable
    _ = ∫ z : ℝ, (a^4 * (t : ℝ)^2) * ‖z‖^4 ∂gaussianReal 0 1 := by
      apply integral_congr_ae
      filter_upwards with z
      rw [norm_mul, norm_mul, mul_pow, mul_pow, Real.norm_eq_abs,
        Real.norm_eq_abs, ← abs_pow, ← abs_pow]
      have ht4 : (Real.sqrt (t : ℝ))^4 = (t : ℝ)^2 := by
        calc
          _ = ((Real.sqrt (t : ℝ))^2)^2 := by ring
          _ = _ := congrArg (fun v : ℝ ↦ v^2) (Real.sq_sqrt t.property)
      have ha4 : 0 ≤ a^4 := by positivity
      rw [abs_of_nonneg ha4, abs_of_nonneg (pow_nonneg (Real.sqrt_nonneg _) 4), ht4]
      ring
    _ = _ := integral_const_mul _ _

private theorem pi_norm_fourth_le_sum {Nc : ℕ} (v : Fin Nc → ℝ) :
    ‖v‖^4 ≤ ∑ i : Fin Nc, ‖v i‖^4 := by
  by_cases h : Nonempty (Fin Nc)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin Nc ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun r : ℝ≥0 ↦ (r : ℝ)) hi
    rw [he]
    exact Finset.single_le_sum (fun j _ ↦ pow_nonneg (norm_nonneg _) 4) (Finset.mem_univ i)
  · have : IsEmpty (Fin Nc) := not_nonempty_iff.mp h
    simp [Pi.norm_def]

include hB in
/-- True finite-dimensional noise fourth norm expectation is bounded by its actual coordinate Gaussian fourth moments. -/
theorem textbookBrownianPhysicalNoise_norm_fourth_moment_bound (t : ℝ≥0) :
    (∫ sample, ‖textbookBrownianSDENoise m β (B t sample)‖^4 ∂P) ≤
      ((∑ i : Fin Nc, (textbookBrownianSDENoiseAmplitude m β i)^4) *
        textbookBrownianStandardGaussianFourthMoment) * (t : ℝ)^2 := by
  have hn : Integrable (fun sample ↦ ‖textbookBrownianSDENoise m β (B t sample)‖^4) P :=
    (textbookBrownianPhysicalNoise_memLp m β B P hB t 4 (by norm_num)).integrable_norm_pow (by norm_num)
  have hi (i : Fin Nc) : Integrable (fun sample ↦ ‖textbookBrownianSDENoise m β (B t sample) i‖^4) P :=
    (textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t i 4 (by norm_num)).integrable_norm_pow (by norm_num)
  calc
    _ ≤ ∫ sample, ∑ i : Fin Nc, ‖textbookBrownianSDENoise m β (B t sample) i‖^4 ∂P :=
      integral_mono hn (integrable_finsetSum Finset.univ fun i _ ↦ hi i) fun sample ↦ pi_norm_fourth_le_sum _
    _ = ∑ i : Fin Nc, ∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖^4 ∂P :=
      integral_finsetSum Finset.univ (fun i _ ↦ hi i)
    _ = _ := by
      simp_rw [textbookBrownianPhysicalNoise_coordinate_fourth_moment m β B P hB t]
      rw [← Finset.sum_mul, ← Finset.sum_mul]
      ring


include hB in
/-- The same actual configuration's true fourth norm moment is bounded by the derived drift and Gaussian noise, uniformly in its initial state. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_fourth_moment_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4 ∂P) ≤
        8 * ((M * t)^4 + ((∑ i : Fin Nc, (textbookBrownianSDENoiseAmplitude m β i)^4) *
          textbookBrownianStandardGaussianFourthMoment) * t^2) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM, hD⟩ := textbookBrownianGlobalDriftIntegral_norm_bound_ae m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦
    textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  let D := textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t
  let N : Ω → (Fin Nc → ℝ) := fun sample ↦ textbookBrownianSDENoise m β (B t.toNNReal sample)
  have hXi : Integrable (fun sample ↦ ‖X sample‖^4) P :=
    (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 4 (by norm_num)).integrable_norm_pow (by norm_num)
  have hNi : Integrable (fun sample ↦ ‖N sample‖^4) P :=
    (textbookBrownianPhysicalNoise_memLp m β B P hB t.toNNReal 4 (by norm_num)).integrable_norm_pow (by norm_num)
  have ha : ∀ᵐ sample ∂P, ‖X sample‖^4 ≤ 8 * ((M * t)^4 + ‖N sample‖^4) := by
    filter_upwards [hD x t ht, textbookBrownianGlobalDriftIntegral_ae_eq m hm U hU hPU β hβ B P hB x t ht]
      with sample hs he
    have he' : X sample = D sample + N sample := by
      change D sample = X sample - N sample at he
      rw [he]
      abel
    have hx : ‖X sample‖ ≤ M * t + ‖N sample‖ :=
      he' ▸ (norm_add_le _ _).trans (add_le_add hs le_rfl)
    exact (pow_le_pow_left₀ (norm_nonneg _) hx 4).trans (by
      have hp := add_pow_le (mul_nonneg hM ht) (norm_nonneg (N sample)) 4
      norm_num at hp
      exact hp)
  calc
    _ ≤ ∫ sample, 8 * ((M * t)^4 + ‖N sample‖^4) ∂P :=
      integral_mono_ae hXi (((integrable_const _).add hNi).const_mul 8) ha
    _ = 8 * ((M * t)^4 + ∫ sample, ‖N sample‖^4 ∂P) := by
      rw [integral_const_mul, integral_add (integrable_const _) hNi]
      simp
    _ ≤ _ := mul_le_mul_of_nonneg_left (add_le_add le_rfl (by
      simpa only [N, Real.coe_toNNReal t ht] using textbookBrownianPhysicalNoise_norm_fourth_moment_bound m β B P hB t.toNNReal))
      (by norm_num)


private theorem pi_norm_second_le_sum {Nc : ℕ} (v : Fin Nc → ℝ) :
    ‖v‖^2 ≤ ∑ i : Fin Nc, ‖v i‖^2 := by
  by_cases h : Nonempty (Fin Nc)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin Nc ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun r : ℝ≥0 ↦ (r : ℝ)) hi
    rw [he]
    exact Finset.single_le_sum (fun j _ ↦ pow_nonneg (norm_nonneg _) 2) (Finset.mem_univ i)
  · have : IsEmpty (Fin Nc) := not_nonempty_iff.mp h
    simp [Pi.norm_def]

include hm hβ hB in
/-- The actual physical vector noise has a true second norm moment bound with the original positive-mass coefficients. -/
theorem textbookBrownianPhysicalNoise_norm_second_moment_bound (t : ℝ≥0) :
    (∫ sample, ‖textbookBrownianSDENoise m β (B t sample)‖^2 ∂P) ≤
      (∑ i : Fin Nc, 2 * β⁻¹ * (m i)⁻¹) * t := by
  have hn : Integrable (fun sample ↦ ‖textbookBrownianSDENoise m β (B t sample)‖^2) P :=
    (textbookBrownianPhysicalNoise_memLp m β B P hB t 2 (by norm_num)).integrable_norm_pow (by norm_num)
  have hi (i : Fin Nc) : Integrable (fun sample ↦ ‖textbookBrownianSDENoise m β (B t sample) i‖^2) P :=
    (textbookBrownianPhysicalNoise_coordinate_memLp m β B P hB t i 2 (by norm_num)).integrable_norm_pow (by norm_num)
  calc
    _ ≤ ∫ sample, ∑ i : Fin Nc, ‖textbookBrownianSDENoise m β (B t sample) i‖^2 ∂P :=
      integral_mono hn (integrable_finsetSum Finset.univ fun i _ ↦ hi i) fun sample ↦ pi_norm_second_le_sum _
    _ = ∑ i : Fin Nc, ∫ sample, ‖textbookBrownianSDENoise m β (B t sample) i‖^2 ∂P :=
      integral_finsetSum Finset.univ (fun i _ ↦ hi i)
    _ = _ := by
      simp only [Real.norm_eq_abs, sq_abs,
        textbookBrownianPhysicalNoise_second_moment m hm β hβ B P hB t]
      rw [Finset.sum_mul]

include hB in
/-- The genuine configuration increment has its derived second norm moment bound uniformly in its initial state. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_second_moment_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2 ∂P) ≤
        2 * ((M * t)^2 + (∑ i : Fin Nc, 2 * β⁻¹ * (m i)⁻¹) * t) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM, hD⟩ := textbookBrownianGlobalDriftIntegral_norm_bound_ae m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦
    textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  let D := textbookBrownianGlobalDriftIntegral m hm U hU hPU β hβ B x t
  let N : Ω → (Fin Nc → ℝ) := fun sample ↦ textbookBrownianSDENoise m β (B t.toNNReal sample)
  have hXi : Integrable (fun sample ↦ ‖X sample‖^2) P :=
    (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 2 (by norm_num)).integrable_norm_pow (by norm_num)
  have hNi : Integrable (fun sample ↦ ‖N sample‖^2) P :=
    (textbookBrownianPhysicalNoise_memLp m β B P hB t.toNNReal 2 (by norm_num)).integrable_norm_pow (by norm_num)
  have ha : ∀ᵐ sample ∂P, ‖X sample‖^2 ≤ 2 * ((M * t)^2 + ‖N sample‖^2) := by
    filter_upwards [hD x t ht, textbookBrownianGlobalDriftIntegral_ae_eq m hm U hU hPU β hβ B P hB x t ht]
      with sample hs he
    have he' : X sample = D sample + N sample := by
      change D sample = X sample - N sample at he
      rw [he]
      abel
    have hx : ‖X sample‖ ≤ M * t + ‖N sample‖ :=
      he' ▸ (norm_add_le _ _).trans (add_le_add hs le_rfl)
    exact (pow_le_pow_left₀ (norm_nonneg _) hx 2).trans (by
      have hp := add_pow_le (mul_nonneg hM ht) (norm_nonneg (N sample)) 2
      norm_num at hp
      exact hp)
  calc
    _ ≤ ∫ sample, 2 * ((M * t)^2 + ‖N sample‖^2) ∂P :=
      integral_mono_ae hXi (((integrable_const _).add hNi).const_mul 2) ha
    _ = 2 * ((M * t)^2 + ∫ sample, ‖N sample‖^2 ∂P) := by
      rw [integral_const_mul, integral_add (integrable_const _) hNi]
      simp
    _ ≤ _ := mul_le_mul_of_nonneg_left (add_le_add le_rfl (by
      simpa only [N, Real.coe_toNNReal t ht] using textbookBrownianPhysicalNoise_norm_second_moment_bound m hm β hβ B P hB t.toNNReal))
      (by norm_num)

include hB in
/-- Actual fourth moments have a genuine uniform O(t^2) bound on the entire short-time interval. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_fourth_moment_small_time :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4 ∂P) ≤ C * t^2 := by
  obtain ⟨M, _, hb⟩ := textbookBrownianGlobalRandomConfiguration_norm_fourth_moment_bound m hm U hU hPU β hβ B P hB
  let F : ℝ := (∑ i : Fin Nc, (textbookBrownianSDENoiseAmplitude m β i)^4) *
    textbookBrownianStandardGaussianFourthMoment
  have hF : 0 ≤ F := mul_nonneg (Finset.sum_nonneg fun i _ ↦ by positivity)
    textbookBrownianStandardGaussianFourthMoment_nonneg
  refine ⟨8 * (M^4 + F), mul_nonneg (by norm_num) (add_nonneg (by positivity) hF), fun x t ht ↦ ?_⟩
  have ht2 : t^2 ≤ 1 := (pow_le_pow_left₀ ht.1 ht.2 2).trans_eq (one_pow 2)
  have ht4 : t^4 ≤ t^2 := by
    calc
      _ = t^2 * t^2 := by ring
      _ ≤ 1 * t^2 := mul_le_mul_of_nonneg_right ht2 (sq_nonneg t)
      _ = _ := one_mul _
  calc
    _ ≤ 8 * ((M * t)^4 + F * t^2) := hb x t ht.1
    _ ≤ 8 * (M^4 * t^2 + F * t^2) := by
      rw [mul_pow]
      exact mul_le_mul_of_nonneg_left
        (add_le_add (mul_le_mul_of_nonneg_left ht4 (by positivity)) le_rfl) (by norm_num)
    _ = _ := by ring

include hB in
/-- Actual second moments have a genuine uniform O(t) bound on the entire short-time interval. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_second_moment_small_time :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2 ∂P) ≤ C * t := by
  obtain ⟨M, _, hb⟩ := textbookBrownianGlobalRandomConfiguration_norm_second_moment_bound m hm U hU hPU β hβ B P hB
  let A : ℝ := ∑ i : Fin Nc, 2 * β⁻¹ * (m i)⁻¹
  have hA : 0 ≤ A := Finset.sum_nonneg fun i _ ↦
    mul_nonneg (mul_nonneg zero_le_two (inv_nonneg.mpr hβ.le)) (inv_nonneg.mpr (hm i).le)
  refine ⟨2 * (M^2 + A), mul_nonneg zero_le_two (add_nonneg (sq_nonneg M) hA), fun x t ht ↦ ?_⟩
  have ht2 : t^2 ≤ t := by
    calc
      _ = t * t := pow_two t
      _ ≤ 1 * t := mul_le_mul_of_nonneg_right ht.2 ht.1
      _ = _ := one_mul _
  calc
    _ ≤ 2 * ((M * t)^2 + A * t) := hb x t ht.1
    _ ≤ 2 * (M^2 * t + A * t) := by
      rw [mul_pow]
      exact mul_le_mul_of_nonneg_left
        (add_le_add (mul_le_mul_of_nonneg_left ht2 (sq_nonneg M)) le_rfl) zero_le_two
    _ = _ := by ring

include hB in
/-- Genuine second/fourth moment integrability supplies Cauchy for the same configuration's third norm moment. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_third_moment_holder
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P) ≤
      Real.sqrt (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2 ∂P) *
      Real.sqrt (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4 ∂P) := by
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦
    textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  have hx2 := textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 2 (by norm_num)
  have hx4 := textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 4 (by norm_num)
  have hf : MemLp (fun sample ↦ ‖X sample‖) (ENNReal.ofReal 2) P := by
    simpa using hx2.norm
  have hg : MemLp (fun sample ↦ ‖X sample‖^2) (ENNReal.ofReal 2) P := by
    have hg0 := hx4.norm_rpow_div 2
    have hdiv : (4 : ℝ≥0∞) / 2 = 2 := by
      have he := ENNReal.ofReal_div_of_pos (x := 4) (y := 2) (by norm_num)
      norm_num at he
      exact he.symm
    norm_num only [ENNReal.toReal_ofNat, Real.rpow_two] at hg0
    rw [hdiv] at hg0
    simpa only [X, ENNReal.ofReal_ofNat] using hg0
  have hh := integral_mul_norm_le_Lp_mul_Lq (Real.holderConjugate_iff.mpr (by norm_num : 1 < (2 : ℝ) ∧ (2 : ℝ)⁻¹ + (2 : ℝ)⁻¹ = 1)) hf hg
  have hpow (sample : Ω) : (‖X sample‖^2)^2 = ‖X sample‖^4 := by ring
  simpa only [norm_pow, norm_norm, Real.rpow_two, hpow, ← Real.sqrt_eq_rpow,
    show (fun sample : Ω ↦ ‖X sample‖ * ‖X sample‖^2) = fun sample ↦ ‖X sample‖^3 by funext sample; ring] using hh

include hB in
/-- The actual third moment, needed for Taylor's remainder, is uniformly O(t^(3/2)) without a high-moment assumption. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_third_moment_small_time :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P) ≤
        C * t * Real.sqrt t := by
  obtain ⟨C2, hC2, h2⟩ := textbookBrownianGlobalRandomConfiguration_norm_second_moment_small_time m hm U hU hPU β hβ B P hB
  obtain ⟨C4, hC4, h4⟩ := textbookBrownianGlobalRandomConfiguration_norm_fourth_moment_small_time m hm U hU hPU β hβ B P hB
  refine ⟨Real.sqrt C2 * Real.sqrt C4, mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _), fun x t ht ↦ ?_⟩
  calc
    _ ≤ Real.sqrt (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2 ∂P) *
        Real.sqrt (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4 ∂P) :=
      textbookBrownianGlobalRandomConfiguration_norm_third_moment_holder m hm U hU hPU β hβ B P hB x t ht.1
    _ ≤ Real.sqrt (C2 * t) * Real.sqrt (C4 * t^2) := mul_le_mul
      (Real.sqrt_le_sqrt (h2 x t ht)) (Real.sqrt_le_sqrt (h4 x t ht))
      (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
    _ = _ := by
      rw [Real.sqrt_mul hC2 t, Real.sqrt_mul hC4 (t^2), Real.sqrt_sq_eq_abs, abs_of_nonneg ht.1]
      ring

include hB in
/-- The genuine third-moment Taylor error divided by time vanishes at zero. -/
theorem textbookBrownianGlobalRandomConfiguration_norm_third_moment_div_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P) / t)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _, hC⟩ := textbookBrownianGlobalRandomConfiguration_norm_third_moment_small_time m hm U hU hPU β hβ B P hB
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ), (∫ sample,
      ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P) / t ≤ C * Real.sqrt t := by
    have hsmall : ∀ᶠ t : ℝ in 𝓝[>] 0, t < 1 :=
      (show ∀ᶠ t : ℝ in 𝓝 0, t < 1 from Iio_mem_nhds (show (0 : ℝ) < 1 by norm_num)).filter_mono nhdsWithin_le_nhds
    filter_upwards [self_mem_nhdsWithin, hsmall] with t ht ht1
    have ht0 : 0 < t := ht
    exact ((div_le_div_iff_of_pos_right ht0).mpr (hC x t ⟨ht0.le, ht1.le⟩)).trans_eq (by field_simp [ht0.ne'])
  have hnon : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 ≤ (∫ sample,
      ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P) / t := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg fun sample ↦ pow_nonneg (norm_nonneg _) 3) ht.le
  have hc : Continuous (fun t : ℝ ↦ C * Real.sqrt t) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦ C * Real.sqrt t) (𝓝[>] 0) (𝓝 0) := by
    simpa only [Real.sqrt_zero, mul_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  exact squeeze_zero' hnon hb hl

end
end MolecularDynamics
