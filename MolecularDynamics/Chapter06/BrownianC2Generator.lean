import MolecularDynamics.Chapter06.BrownianC2ObservableTaylor

/-! The actual general-mass Brownian probability generator on the original C2
integer-periodic observable range; no C-infinity observable is required. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

/-- Actual C2 coordinate second partials are the true second Frechet derivative entries. -/
theorem textbookConfigurationC2Partial_second_fderiv_entry {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f)
    (x : Fin Nc → ℝ) (i j : Fin Nc) :
    textbookConfigurationPartial (textbookConfigurationPartial f j) i x =
      fderiv ℝ (fderiv ℝ f) x (Pi.single i 1) (Pi.single j 1) := by
  unfold textbookConfigurationPartial
  have hc : ContDiff ℝ 1 (fderiv ℝ f) := hf.fderiv_right (by norm_num)
  rw [fderiv_clm_apply (hc.differentiable (by norm_num) x) (differentiableAt_const _)]
  simp

/-- The true second-order Taylor coefficient of a C2 observable equals its original coordinate Hessian sum. -/
theorem textbookConfigurationC2Partial_second_coordinate_sum {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (x y : Fin Nc → ℝ) :
    iteratedFDeriv ℝ 2 f x (fun _ ↦ y) =
      ∑ i, ∑ j, textbookConfigurationPartial (textbookConfigurationPartial f j) i x * (y i * y j) := by
  let H := fderiv ℝ (fderiv ℝ f) x
  have ho : H y = ∑ i : Fin Nc, y i • H (Pi.single i 1) := by
    calc
      _ = H (∑ i : Fin Nc, y i • Pi.single i 1) := congrArg H (pi_eq_sum_univ' y)
      _ = _ := by simp
  have hi (L : (Fin Nc → ℝ) →L[ℝ] ℝ) : L y = ∑ j : Fin Nc, y j • L (Pi.single j 1) := by
    calc
      _ = L (∑ j : Fin Nc, y j • Pi.single j 1) := congrArg L (pi_eq_sum_univ' y)
      _ = _ := by simp
  calc
    _ = H y y := iteratedFDeriv_two_apply f x (fun _ ↦ y)
    _ = (∑ i : Fin Nc, y i • H (Pi.single i 1)) y := congrArg (fun L : (Fin Nc → ℝ) →L[ℝ] ℝ ↦ L y) ho
    _ = ∑ i : Fin Nc, y i * H (Pi.single i 1) y := by simp
    _ = ∑ i : Fin Nc, ∑ j : Fin Nc, y i * (y j * H (Pi.single i 1) (Pi.single j 1)) := by
      apply Finset.sum_congr rfl
      intro i _
      rw [hi (H (Pi.single i 1))]
      simp [Finset.mul_sum]
    _ = _ := by
      apply Finset.sum_congr rfl
      intro i _
      apply Finset.sum_congr rfl
      intro j _
      rw [textbookConfigurationC2Partial_second_fderiv_entry f hf x i j]
      dsimp [H]
      ring_nf

/-- The literal original generator is truly continuous on every C2 observable. -/
theorem textbookBrownianC2Generator_continuous {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) :
    Continuous (textbookBrownianGenerator m U β f) := by
  have h1 (i : Fin Nc) : ContDiff ℝ 1 (textbookConfigurationPartial f i) :=
    (hf.fderiv_right (by norm_num)).clm_apply contDiff_const
  have h2 (i : Fin Nc) : ContDiff ℝ 0 (textbookConfigurationPartial (textbookConfigurationPartial f i) i) :=
    ((h1 i).fderiv_right (by norm_num)).clm_apply contDiff_const
  apply continuous_finsetSum
  intro i _
  exact continuous_const.mul ((continuous_const.mul (h2 i).continuous).sub
    ((textbookConfigurationPartial_contDiff U hU i).continuous.mul (h1 i).continuous))

private theorem original_partial_periodic {N : ℕ}
    (g : (Fin N → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential g) (i : Fin N) :
    textbookUnitPeriodicPotential (textbookConfigurationPartial g i) := by
  intro q n
  let c : Fin N → ℝ := fun j ↦ (n j : ℝ)
  have he : (fun z ↦ g (z + c)) = g := funext (fun z ↦ hp z n)
  have hh := fderiv_comp_add_right (𝕜 := ℝ) (f := g) (x := q) c
  rw [he] at hh
  exact congrArg (fun L : (Fin N → ℝ) →L[ℝ] ℝ ↦ L (Pi.single i 1)) hh.symm

/-- Actual coordinate differentiation keeps the literal original C2 generator integer-periodic. -/
theorem textbookBrownianC2Generator_periodic {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (hPU : textbookUnitPeriodicPotential U) (hpf : textbookUnitPeriodicPotential f) :
    textbookUnitPeriodicPotential (textbookBrownianGenerator m U β f) := by
  intro q n
  unfold textbookBrownianGenerator
  apply Finset.sum_congr rfl
  intro i _
  have hpi := original_partial_periodic f hpf i
  rw [original_partial_periodic _ hpi i q n, original_partial_periodic U hPU i q n, hpi q n]

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f)

include hB hf hpf in
/-- The original periodic observable of the actual global process is truly integrable. -/
theorem textbookBrownianGlobalRandomConfiguration_C2observable_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    Integrable (fun sample ↦ f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hb⟩ := textbookUnitPeriodicPotential_bound f hf.continuous hpf
  have hx := (textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB x t ht).aestronglyMeasurable
  exact (integrable_const M).mono' (hf.continuous.comp_aestronglyMeasurable hx)
    (Eventually.of_forall fun sample ↦ hb _)

include hB hf hpf in
/-- The true probability expectation has the actual Taylor expansion with a genuinely integrable remainder. -/
theorem textbookBrownianGlobalRandomConfiguration_C2observable_expectation_Taylor
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    (∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) - f x =
      fderiv ℝ f x (∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) +
      (2 : ℝ)⁻¹ * (∑ i, ∑ j,
        textbookConfigurationPartial (textbookConfigurationPartial f j) i x *
          (∫ sample, (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
            (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j ∂P)) +
      ∫ sample, textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample ∂P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  let H : Fin Nc → Fin Nc → ℝ := fun i j ↦ textbookConfigurationPartial (textbookConfigurationPartial f j) i x
  let Q : Ω → ℝ := fun sample ↦ ∑ i, ∑ j, H i j * (X sample i * X sample j)
  let R : Ω → ℝ := textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t
  have hiX : Integrable X P :=
    (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 1 (by norm_num)).integrable (by norm_num)
  have hiL := (fderiv ℝ f x).integrable_comp hiX
  have hiQ : Integrable Q P := textbookBrownianGlobalRandomConfiguration_quadratic_observable_integrable m hm U hU hPU β hβ B P hB f x t ht
  have hiQC : Integrable (fun sample ↦ (2 : ℝ)⁻¹ * Q sample) P := hiQ.const_mul _
  have hiS : Integrable (fun sample ↦ fderiv ℝ f x (X sample) + (2 : ℝ)⁻¹ * Q sample) P := hiL.add hiQC
  have hiR : Integrable R P := textbookBrownianGlobalC2ObservableTaylorRemainder_integrable m hm U hU hPU β hβ B P hB f hf hpf x t ht
  have hiF := textbookBrownianGlobalRandomConfiguration_C2observable_integrable m hm U hU hPU β hβ B P hB f hf hpf x t ht
  have hiTerm (i j : Fin Nc) : Integrable (fun sample ↦ H i j * (X sample i * X sample j)) P :=
    (textbookBrownianGlobalRandomConfiguration_second_product_integrable m hm U hU hPU β hβ B P hB x t ht i j).const_mul _
  have he (sample : Ω) : f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) - f x =
      fderiv ℝ f x (X sample) + (2 : ℝ)⁻¹ * Q sample + R sample := by
    have hexy : x + X sample = textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample := by dsimp [X]; abel
    have her : R sample = f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) - f x -
        fderiv ℝ f x (X sample) - (2 : ℝ)⁻¹ * Q sample := by
      change textbookBrownianObservableTaylorRemainder f x (X sample) = _
      unfold textbookBrownianObservableTaylorRemainder
      rw [hexy, textbookConfigurationC2Partial_second_coordinate_sum f hf x (X sample)]
    rw [her]
    ring_nf
  have hQint : (∫ sample, Q sample ∂P) = ∑ i, ∑ j, H i j * (∫ sample, X sample i * X sample j ∂P) := by
    change (∫ sample, ∑ i, ∑ j, H i j * (X sample i * X sample j) ∂P) = _
    rw [integral_finsetSum Finset.univ (fun i _ ↦ integrable_finsetSum Finset.univ (fun j _ ↦ hiTerm i j))]
    apply Finset.sum_congr rfl
    intro i _
    rw [integral_finsetSum Finset.univ (fun j _ ↦ hiTerm i j)]
    apply Finset.sum_congr rfl
    intro j _
    exact integral_const_mul _ _
  calc
    _ = ∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) - f x ∂P := by
      rw [integral_sub hiF (integrable_const _)]
      simp
    _ = ∫ sample, fderiv ℝ f x (X sample) + (2 : ℝ)⁻¹ * Q sample + R sample ∂P :=
      integral_congr_ae (Eventually.of_forall he)
    _ = _ := by
      rw [integral_add hiS hiR, integral_add hiL hiQC,
        (fderiv ℝ f x).integral_comp_comm hiX, integral_const_mul, hQint]

include hB hf hpf in
/-- The same original probability process truly has the textbook generator on every original C2 periodic observable, at every initial lift. -/
theorem textbookBrownianGlobalRandomConfiguration_C2observable_generator_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ ((∫ sample,
      f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) - f x) / t)
      (𝓝[>] 0) (𝓝 (textbookBrownianGenerator m U β f x)) := by
  let H : Fin Nc → Fin Nc → ℝ := fun i j ↦ textbookConfigurationPartial (textbookConfigurationPartial f j) i x
  have hl : Tendsto (fun t : ℝ ↦
      fderiv ℝ f x (∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) / t)
      (𝓝[>] 0) (𝓝 (fderiv ℝ f x (textbookBrownianSDEDrift m U x))) := by
    simpa only [Function.comp_def, map_smul, smul_eq_mul, div_eq_mul_inv, mul_comm] using
      ((fderiv ℝ f x).continuous.tendsto _).comp
        (textbookBrownianGlobalRandomConfiguration_increment_mean_div_tendsto m hm U hU hPU β hβ B P hB x)
  have hq : Tendsto (fun t : ℝ ↦ ∑ i, ∑ j, H i j *
      ((∫ sample, (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j ∂P) / t))
      (𝓝[>] 0) (𝓝 (∑ i, ∑ j, H i j * (textbookBrownianSDENoiseAmplitude m β i *
        textbookBrownianSDENoiseAmplitude m β j * (if i = j then 1 else 0)))) := by
    apply tendsto_finsetSum
    intro i _
    apply tendsto_finsetSum
    intro j _
    exact (textbookBrownianGlobalRandomConfiguration_second_product_div_tendsto m hm U hU hPU β hβ B P hB x i j).const_mul _
  have hq0 : (∑ i, ∑ j, H i j * (textbookBrownianSDENoiseAmplitude m β i *
      textbookBrownianSDENoiseAmplitude m β j * (if i = j then 1 else 0))) =
      ∑ i, textbookBrownianSDENoiseAmplitude m β i ^ 2 * H i i := by
    apply Finset.sum_congr rfl
    intro i _
    simp [mul_ite, pow_two, mul_comm]
  have hh := (hl.add (hq.const_mul (2 : ℝ)⁻¹)).add
    (textbookBrownianGlobalC2ObservableTaylorRemainder_expectation_div_tendsto m hm U hU hPU β hβ B P hB f hf hpf x)
  rw [hq0, add_zero, ← textbookBrownianGenerator_original_Taylor_coefficients m hm U β hβ f x] at hh
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  rw [textbookBrownianGlobalRandomConfiguration_C2observable_expectation_Taylor m hm U hU hPU β hβ B P hB f hf hpf x t ht.le]
  simp only [add_div, mul_div_assoc, Finset.sum_div, H]


/-- Original C2 regularity and actual periodic derivatives give common true first-derivative and Hessian-coordinate bounds. -/
theorem textbookBrownianC2Observable_Taylor_coefficients_bound {N : ℕ}
    (g : (Fin N → ℝ) → ℝ) (hg : ContDiff ℝ 2 g) (hpg : textbookUnitPeriodicPotential g) :
    ∃ K1 K2 : ℝ, 0 ≤ K1 ∧ 0 ≤ K2 ∧ ∀ x,
      ‖fderiv ℝ g x‖ ≤ K1 ∧
      (∑ i : Fin N, ∑ j : Fin N, |textbookConfigurationPartial (textbookConfigurationPartial g j) i x|) ≤ K2 := by
  obtain ⟨K1, hK1, hb1⟩ := textbookUnitPeriodicC2Observable_iteratedFDeriv_bound g hg hpg 1 (by norm_num)
  let J : (Fin N → ℝ) → ℝ := fun x ↦
    ∑ i : Fin N, ∑ j : Fin N, |textbookConfigurationPartial (textbookConfigurationPartial g j) i x|
  have h1 (j : Fin N) : ContDiff ℝ 1 (textbookConfigurationPartial g j) :=
    (hg.fderiv_right (by norm_num)).clm_apply contDiff_const
  have h2 (i j : Fin N) : ContDiff ℝ 0 (textbookConfigurationPartial (textbookConfigurationPartial g j) i) :=
    ((h1 j).fderiv_right (by norm_num)).clm_apply contDiff_const
  have hp2 (i j : Fin N) : textbookUnitPeriodicPotential (textbookConfigurationPartial (textbookConfigurationPartial g j) i) :=
    original_partial_periodic _ (original_partial_periodic g hpg j) i
  have hc : Continuous J := continuous_finsetSum _ fun i _ ↦
    continuous_finsetSum _ fun j _ ↦ (h2 i j).continuous.abs
  have hpJ : textbookUnitPeriodicPotential J := by
    intro x n
    dsimp [J]
    apply Finset.sum_congr rfl
    intro i _
    apply Finset.sum_congr rfl
    intro j _
    rw [hp2 i j x n]
  obtain ⟨K2, hK2, hb2⟩ := textbookUnitPeriodicPotential_bound J hc hpJ
  refine ⟨K1, K2, hK1, hK2, fun x ↦ ⟨?_, ?_⟩⟩
  · simpa only [norm_iteratedFDeriv_one] using hb1 x
  · have hJ : 0 ≤ J x := Finset.sum_nonneg fun i _ ↦ Finset.sum_nonneg fun j _ ↦ abs_nonneg _
    simpa only [Real.norm_of_nonneg hJ, J] using hb2 x


include hB hf hpf in
/-- True mean, covariance and Taylor errors give the original generator's uniform unscaled probability error. -/
theorem textbookBrownianGlobalRandomConfiguration_C2uniform_generator_error
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      ‖(∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
          f x - t * textbookBrownianGenerator m U β f x‖ ≤ (ε + C * (t + Real.sqrt t)) * t := by
  obtain ⟨M1, hM1, hmean⟩ := textbookBrownianGlobalRandomConfiguration_mean_error_bound m hm U hU hPU β hβ B P hB
  obtain ⟨M2, hM2, hsecond⟩ := textbookBrownianGlobalRandomConfiguration_second_product_error_bound m hm U hU hPU β hβ B P hB
  obtain ⟨K1, K2, hK1, hK2, hjet⟩ := textbookBrownianC2Observable_Taylor_coefficients_bound f hf hpf
  obtain ⟨Cr, hCr, hrem⟩ := textbookBrownianGlobalC2ObservableTaylorRemainder_uniform_norm_expectation_bound m hm U hU hPU β hβ B P hB f hf hpf ε hε
  let N : ℝ := ∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hPU
  have hN : 0 ≤ N := Finset.sum_nonneg fun i _ ↦ Real.sqrt_nonneg _
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hPU).property
  let A : ℝ := K1 * L * M1 + (2 : ℝ)⁻¹ * K2 * M2^2 + Cr
  let D0 : ℝ := K1 * L * N + K2 * M2 * N
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hD0 : 0 ≤ D0 := by dsimp [D0]; positivity
  refine ⟨A + D0, add_nonneg hA hD0, fun x t ht ↦ ?_⟩
  let X : Ω → (Fin Nc → ℝ) := fun sample ↦ textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x
  let H : Fin Nc → Fin Nc → ℝ := fun i j ↦ textbookConfigurationPartial (textbookConfigurationPartial f j) i x
  let E : Fin Nc → Fin Nc → ℝ := fun i j ↦ ∫ sample, X sample i * X sample j ∂P
  let V : Fin Nc → Fin Nc → ℝ := fun i j ↦ textbookBrownianSDENoiseAmplitude m β i * textbookBrownianSDENoiseAmplitude m β j * (if i = j then t else 0)
  let Q : ℝ := ∑ i, ∑ j, H i j * (E i j - V i j)
  let R : ℝ := ∫ sample, textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample ∂P
  let D : Fin Nc → ℝ := (∫ sample, X sample ∂P) - t • textbookBrownianSDEDrift m U x
  let err : ℝ := M2 * t * (M2 * t + 2 * N * Real.sqrt t)
  have ht0 : 0 ≤ t := ht.1
  have herr : 0 ≤ err := by dsimp [err]; positivity
  have hv : (∑ i, ∑ j, H i j * V i j) = t * ∑ i, textbookBrownianSDENoiseAmplitude m β i ^ 2 * H i i := by
    calc
      _ = ∑ i, H i i * (textbookBrownianSDENoiseAmplitude m β i * textbookBrownianSDENoiseAmplitude m β i * t) := by
        apply Finset.sum_congr rfl
        intro i _
        simp [V, mul_ite]
      _ = _ := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro i _
        ring_nf
  have hQeq : Q = (∑ i, ∑ j, H i j * E i j) -
      t * ∑ i, textbookBrownianSDENoiseAmplitude m β i ^ 2 * H i i := by
    dsimp [Q]
    simp only [mul_sub, Finset.sum_sub_distrib]
    rw [hv]
  have he : (∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
      f x - t * textbookBrownianGenerator m U β f x =
      fderiv ℝ f x D + (2 : ℝ)⁻¹ * Q + R := by
    rw [textbookBrownianGlobalRandomConfiguration_C2observable_expectation_Taylor m hm U hU hPU β hβ B P hB f hf hpf x t ht.1,
      textbookBrownianGenerator_original_Taylor_coefficients m hm U β hβ f x, hQeq]
    dsimp [D, X, H, E, R]
    simp only [map_sub, map_smul, smul_eq_mul]
    ring
  have hlin : ‖fderiv ℝ f x D‖ ≤ K1 * (L * (M1 * t + N * Real.sqrt t) * t) := by
    apply (fderiv ℝ f x).le_opNorm D |>.trans
    exact mul_le_mul (hjet x).1 (hmean x t ht.1) (norm_nonneg D) hK1
  have hcoord (i j : Fin Nc) : ‖H i j * (E i j - V i j)‖ ≤ |H i j| * err := by
    rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs]
    exact mul_le_mul_of_nonneg_left (hsecond x t ht.1 i j) (abs_nonneg _)
  have hQ : ‖Q‖ ≤ K2 * err := by
    calc
      _ ≤ ∑ i : Fin Nc, ‖∑ j : Fin Nc, H i j * (E i j - V i j)‖ := norm_sum_le _ _
      _ ≤ ∑ i : Fin Nc, ∑ j : Fin Nc, ‖H i j * (E i j - V i j)‖ :=
        Finset.sum_le_sum fun i _ ↦ norm_sum_le _ _
      _ ≤ ∑ i : Fin Nc, ∑ j : Fin Nc, |H i j| * err :=
        Finset.sum_le_sum fun i _ ↦ Finset.sum_le_sum fun j _ ↦ hcoord i j
      _ = (∑ i : Fin Nc, ∑ j : Fin Nc, |H i j|) * err := by simp only [Finset.sum_mul]
      _ ≤ K2 * err := mul_le_mul_of_nonneg_right (hjet x).2 herr
  have hR : ‖R‖ ≤ (ε * t + Cr * t^2) := (norm_integral_le_integral_norm _).trans (hrem x t ht)
  have hQC : ‖(2 : ℝ)⁻¹ * Q‖ ≤ (2 : ℝ)⁻¹ * (K2 * err) := by
    rw [norm_mul, Real.norm_of_nonneg (show 0 ≤ (2 : ℝ)⁻¹ by norm_num)]
    exact mul_le_mul_of_nonneg_left hQ (by norm_num)
  calc
    _ ≤ ‖fderiv ℝ f x D‖ + ‖(2 : ℝ)⁻¹ * Q‖ + ‖R‖ := by
      rw [he]
      exact (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ K1 * (L * (M1 * t + N * Real.sqrt t) * t) +
        (2 : ℝ)⁻¹ * (K2 * err) + (ε * t + Cr * t^2) :=
      add_le_add (add_le_add hlin hQC) hR
    _ = (ε + A * t + D0 * Real.sqrt t) * t := by dsimp [A, D0, err]; ring_nf
    _ ≤ (ε + (A + D0) * (t + Real.sqrt t)) * t := by
      apply mul_le_mul_of_nonneg_right _ ht.1
      nlinarith [mul_nonneg hA (Real.sqrt_nonneg t), mul_nonneg hD0 ht.1]

include hB hf hpf in
/-- The true probability generator quotient error has one bound for every initial state. -/
theorem textbookBrownianGlobalRandomConfiguration_C2uniform_generator_quotient_error
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Ioc (0 : ℝ) 1,
      ‖((∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
          f x) / t - textbookBrownianGenerator m U β f x‖ ≤ ε + C * (t + Real.sqrt t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianGlobalRandomConfiguration_C2uniform_generator_error m hm U hU hPU β hβ B P hB f hf hpf ε hε
  refine ⟨C, hC, fun x t ht ↦ ?_⟩
  have he : ((∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) - f x) / t -
      textbookBrownianGenerator m U β f x =
      ((∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
        f x - t * textbookBrownianGenerator m U β f x) / t := by field_simp [ht.1.ne']
  rw [he, norm_div, Real.norm_of_nonneg ht.1.le]
  exact ((div_le_div_iff_of_pos_right ht.1).mpr (hb x t ⟨ht.1.le, ht.2⟩)).trans_eq (by field_simp [ht.1.ne'])


/-- The literal original generator on a C2 observable is a genuine continuous function on the same torus. -/
def textbookBrownianC2ContinuousGeneratorImage : C(UnitAddTorus (Fin Nc), ℝ) :=
  textbookConfigurationContinuousObservable (textbookBrownianGenerator m U β f)
    (textbookBrownianC2Generator_continuous m U β f hU hf)
    (textbookBrownianC2Generator_periodic m U β f hPU hpf)

include hB hpf in
/-- The actual probability operator on each actual continuous periodic observable is exactly the expectation of the same genuine q. -/
theorem textbookBrownianTorusProbabilityOperator_continuous_observable_expectation
    (hc : Continuous f) (t : ℝ≥0) (X : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t
      (textbookConfigurationContinuousObservable f hc hpf) X =
      ∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
        (textbookConfigurationTorusRepresentative X) B t sample) ∂P := by
  rw [textbookBrownianTorusProbabilityOperator_apply,
    textbookBrownianTorusTransitionExpectation_actual_probability m hm U hU hPU β hβ B P hB]
  change (∫ sample, textbookConfigurationTorusObservable f
    (textbookConfigurationTorusProjection (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
      (textbookConfigurationTorusRepresentative X) B t sample)) ∂P) = _
  exact integral_congr_ae (Eventually.of_forall fun sample ↦ textbookConfigurationTorusObservable_lift f hpf _)

include hB hf hpf in
/-- The actual probability CMap generator difference has the derived C2 uniform norm error epsilon plus a vanishing rate. -/
theorem textbookBrownianTorusProbabilityOperator_C2uniform_generator_error
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ t ∈ Ioc (0 : ℝ) 1,
      ‖t⁻¹ • (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
          (textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf‖ ≤ ε + C * (t + Real.sqrt t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianGlobalRandomConfiguration_C2uniform_generator_quotient_error m hm U hU hPU β hβ B P hB f hf hpf ε hε
  refine ⟨C, hC, fun t ht ↦ ?_⟩
  have hbound : 0 ≤ ε + C * (t + Real.sqrt t) := add_nonneg hε.le (mul_nonneg hC (add_nonneg ht.1.le (Real.sqrt_nonneg t)))
  apply (ContinuousMap.norm_le _ hbound).mpr
  intro X
  change ‖t⁻¹ * (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf) X - f (textbookConfigurationTorusRepresentative X)) -
      textbookBrownianGenerator m U β f (textbookConfigurationTorusRepresentative X)‖ ≤ _
  rw [textbookBrownianTorusProbabilityOperator_continuous_observable_expectation m hm U hU hPU β hβ B P hB f hpf hf.continuous,
    Real.coe_toNNReal t ht.1.le]
  simpa only [div_eq_mul_inv, mul_comm] using hb (textbookConfigurationTorusRepresentative X) t ht

include hB hf hpf in
/-- Every original C2 integer-periodic observable belongs to the genuine probability semigroup strong uniform generator, with the literal textbook value. -/
theorem textbookBrownianTorusProbabilityOperator_C2original_generator_tendsto :
    Tendsto (fun t : ℝ ↦ t⁻¹ •
      (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookConfigurationContinuousObservable f hf.continuous hpf))
      (𝓝[>] 0) (𝓝 (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf)) := by
  apply Metric.tendsto_nhds.mpr
  intro ε hε
  obtain ⟨C, _, hb⟩ := textbookBrownianTorusProbabilityOperator_C2uniform_generator_error m hm U hU hPU β hβ B P hB f hf hpf (ε / 2) (by positivity)
  have hc : Continuous (fun t : ℝ ↦ C * (t + Real.sqrt t)) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦ C * (t + Real.sqrt t)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [Real.sqrt_zero, add_zero, mul_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  have hsmall : ∀ᶠ t : ℝ in 𝓝[>] 0, C * (t + Real.sqrt t) < ε / 2 :=
    hl.eventually (Iio_mem_nhds (by positivity : (0 : ℝ) < ε / 2))
  have htime : ∀ᶠ t : ℝ in 𝓝[>] 0, t < 1 :=
    (show ∀ᶠ t : ℝ in 𝓝 0, t < 1 from Iio_mem_nhds zero_lt_one).filter_mono nhdsWithin_le_nhds
  filter_upwards [self_mem_nhdsWithin, hsmall, htime] with t ht hs ht1
  rw [dist_eq_norm]
  exact (hb t ⟨ht, ht1.le⟩).trans_lt (by linarith)

/-- The literal original C2 generator image in the same original Gibbs L2 space. -/
def textbookBrownianC2GibbsL2GeneratorImage : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  textbookConfigurationGibbsL2Observable U hU hPU β (textbookBrownianGenerator m U β f)
    (textbookBrownianC2Generator_continuous m U β f hU hf)
    (textbookBrownianC2Generator_periodic m U β f hPU hpf)

include hB hf hpf in
/-- The same actual probability expectations have the literal original C2 generator as their strong same-Gibbs L2 limit. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2original_generator_tendsto :
    Tendsto (fun t : ℝ ↦ t⁻¹ •
      (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβ B P hB t.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
       textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf))
      (𝓝[>] 0) (𝓝 (textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf)) := by
  have hG : textbookGibbsContinuousToLp U hU hPU β
      (textbookBrownianC2ContinuousGeneratorImage m U hU hPU β f hf hpf) =
      textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf := by
    exact textbookGibbsContinuousToLp_original_observable U hU hPU β
      (textbookBrownianGenerator m U β f) (textbookBrownianC2Generator_continuous m U β f hU hf)
      (textbookBrownianC2Generator_periodic m U β f hPU hpf)
  have hh := ((textbookGibbsContinuousToLp U hU hPU β).continuous.tendsto _).comp
    (textbookBrownianTorusProbabilityOperator_C2original_generator_tendsto m hm U hU hPU β hβ B P hB f hf hpf)
  simpa only [Function.comp_def, map_smul, map_sub,
    textbookGibbsContinuousToLp_original_observable, hG,
    textbookBrownianProbabilityGibbsL2Image, ContinuousLinearMap.comp_apply] using hh

end
end MolecularDynamics
