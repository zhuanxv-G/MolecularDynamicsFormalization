import MolecularDynamics.Chapter06.BrownianObservableTaylor

/-! Genuine expectations of the original Brownian process identify its
short-time generator on the original smooth periodic observable core. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

private theorem clm_coordinate_decomposition {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : (Fin Nc → ℝ) →L[ℝ] E) (v : Fin Nc → ℝ) :
    L v = ∑ i, v i • L (Pi.single i 1) := by
  have hs (i : Fin Nc) : v i • Pi.single i 1 = Pi.single i (v i) := by
    ext j
    by_cases hj : j = i <;> simp [hj]
  have he : v = ∑ i : Fin Nc, v i • Pi.single i 1 := by
    calc
      _ = ∑ i : Fin Nc, Pi.single i (v i) := (Finset.univ_sum_single v).symm
      _ = _ := Finset.sum_congr rfl (fun i _ ↦ (hs i).symm)
  calc
    _ = L (∑ i : Fin Nc, v i • Pi.single i 1) := congrArg L he
    _ = _ := by simp

/-- The actual observable derivative equals its original coordinate partial expansion. -/
theorem textbookConfigurationPartial_fderiv_coordinate_sum {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (x y : Fin Nc → ℝ) :
    fderiv ℝ f x y = ∑ i, textbookConfigurationPartial f i x * y i := by
  simpa only [smul_eq_mul, textbookConfigurationPartial, mul_comm] using
    clm_coordinate_decomposition (fderiv ℝ f x) y

/-- A coordinate partial of a partial is the genuine second Frechet derivative entry. -/
theorem textbookConfigurationPartial_second_fderiv_entry {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f)
    (x : Fin Nc → ℝ) (i j : Fin Nc) :
    textbookConfigurationPartial (textbookConfigurationPartial f j) i x =
      fderiv ℝ (fderiv ℝ f) x (Pi.single i 1) (Pi.single j 1) := by
  unfold textbookConfigurationPartial
  have hc : ContDiff ℝ ∞ (fderiv ℝ f) := hf.fderiv_right (by simp)
  rw [fderiv_clm_apply (hc.differentiable (by simp) x)
    (differentiableAt_const _)]
  simp

/-- The true quadratic Taylor coefficient is exactly the double original-coordinate Hessian sum. -/
theorem textbookConfigurationPartial_second_coordinate_sum {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (x y : Fin Nc → ℝ) :
    iteratedFDeriv ℝ 2 f x (fun _ ↦ y) =
      ∑ i, ∑ j, textbookConfigurationPartial (textbookConfigurationPartial f j) i x * (y i * y j) := by
  let H := fderiv ℝ (fderiv ℝ f) x
  calc
    _ = H y y := iteratedFDeriv_two_apply f x (fun _ ↦ y)
    _ = (∑ i : Fin Nc, y i • H (Pi.single i 1)) y :=
      congrArg (fun L : (Fin Nc → ℝ) →L[ℝ] ℝ ↦ L y) (clm_coordinate_decomposition H y)
    _ = ∑ i : Fin Nc, y i * H (Pi.single i 1) y := by simp
    _ = ∑ i : Fin Nc, ∑ j : Fin Nc, y i * (y j * H (Pi.single i 1) (Pi.single j 1)) := by
      apply Finset.sum_congr rfl
      intro i _
      rw [clm_coordinate_decomposition (H (Pi.single i 1)) y]
      simp [Finset.mul_sum]
    _ = _ := by
      apply Finset.sum_congr rfl
      intro i _
      apply Finset.sum_congr rfl
      intro j _
      rw [textbookConfigurationPartial_second_fderiv_entry f hf x i j]
      dsimp [H]
      ring_nf

/-- The drift and diagonal covariance coefficients recover the literal original general-mass generator. -/
theorem textbookBrownianGenerator_original_Taylor_coefficients {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
    (β : ℝ) (hβ : 0 < β) (f : (Fin Nc → ℝ) → ℝ) (x : Fin Nc → ℝ) :
    textbookBrownianGenerator m U β f x =
      fderiv ℝ f x (textbookBrownianSDEDrift m U x) +
      (2 : ℝ)⁻¹ * ∑ i, textbookBrownianSDENoiseAmplitude m β i ^ 2 *
        textbookConfigurationPartial (textbookConfigurationPartial f i) i x := by
  rw [textbookConfigurationPartial_fderiv_coordinate_sum]
  unfold textbookBrownianGenerator
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  rw [textbookBrownianSDEDrift_apply, textbookBrownianSDENoiseAmplitude_sq m hm β hβ i]
  ring_nf

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hpf : textbookUnitPeriodicPotential f)

include hB hf hpf in
/-- The original periodic observable of the actual global process is truly integrable. -/
theorem textbookBrownianGlobalRandomConfiguration_observable_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    Integrable (fun sample ↦ f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hb⟩ := textbookUnitPeriodicPotential_bound f hf.continuous hpf
  have hx := (textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB x t ht).aestronglyMeasurable
  exact (integrable_const M).mono' (hf.continuous.comp_aestronglyMeasurable hx)
    (Eventually.of_forall fun sample ↦ hb _)

include hB in
/-- Every true quadratic coordinate term is integrable before taking the Taylor expectation. -/
theorem textbookBrownianGlobalRandomConfiguration_quadratic_observable_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    Integrable (fun sample ↦ ∑ i, ∑ j,
      textbookConfigurationPartial (textbookConfigurationPartial f j) i x *
        ((textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) i *
         (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x) j)) P := by
  exact integrable_finsetSum Finset.univ fun i _ ↦
    integrable_finsetSum Finset.univ fun j _ ↦
      (textbookBrownianGlobalRandomConfiguration_second_product_integrable m hm U hU hPU β hβ B P hB x t ht i j).const_mul _

include hB hf hpf in
/-- The true probability expectation has the actual Taylor expansion with a genuinely integrable remainder. -/
theorem textbookBrownianGlobalRandomConfiguration_observable_expectation_Taylor
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
  have hiR : Integrable R P := textbookBrownianGlobalObservableTaylorRemainder_integrable m hm U hU hPU β hβ B P hB f hf hpf x t ht
  have hiF := textbookBrownianGlobalRandomConfiguration_observable_integrable m hm U hU hPU β hβ B P hB f hf hpf x t ht
  have hiTerm (i j : Fin Nc) : Integrable (fun sample ↦ H i j * (X sample i * X sample j)) P :=
    (textbookBrownianGlobalRandomConfiguration_second_product_integrable m hm U hU hPU β hβ B P hB x t ht i j).const_mul _
  have he (sample : Ω) : f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) - f x =
      fderiv ℝ f x (X sample) + (2 : ℝ)⁻¹ * Q sample + R sample := by
    have hexy : x + X sample = textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample := by dsimp [X]; abel
    have her : R sample = f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) - f x -
        fderiv ℝ f x (X sample) - (2 : ℝ)⁻¹ * Q sample := by
      change textbookBrownianObservableTaylorRemainder f x (X sample) = _
      unfold textbookBrownianObservableTaylorRemainder
      rw [hexy, textbookConfigurationPartial_second_coordinate_sum f hf x (X sample)]
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
/-- The same original probability process truly has the textbook generator on every smooth periodic observable, at every initial lift. -/
theorem textbookBrownianGlobalRandomConfiguration_observable_generator_tendsto
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
    (textbookBrownianGlobalObservableTaylorRemainder_expectation_div_tendsto m hm U hU hPU β hβ B P hB f hf hpf x)
  rw [hq0, add_zero, ← textbookBrownianGenerator_original_Taylor_coefficients m hm U β hβ f x] at hh
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  rw [textbookBrownianGlobalRandomConfiguration_observable_expectation_Taylor m hm U hU hPU β hβ B P hB f hf hpf x t ht.le]
  simp only [add_div, mul_div_assoc, Finset.sum_div, H]

end
end MolecularDynamics
