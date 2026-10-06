import MolecularDynamics.Chapter06.BrownianGeneratorExpectation
import MolecularDynamics.Chapter06.BrownianFellerContinuity

/-! Uniform original Brownian generator errors on the true continuous
torus observable space, derived from the same actual probability process. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

/-- True original smooth periodic jets give a common derivative norm and total Hessian-coordinate bound. -/
theorem textbookBrownianObservable_Taylor_coefficients_bound {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hpf : textbookUnitPeriodicPotential f) :
    ∃ K1 K2 : ℝ, 0 ≤ K1 ∧ 0 ≤ K2 ∧ ∀ x,
      ‖fderiv ℝ f x‖ ≤ K1 ∧
      (∑ i : Fin Nc, ∑ j : Fin Nc, |textbookConfigurationPartial (textbookConfigurationPartial f j) i x|) ≤ K2 := by
  obtain ⟨K1, hK1, hb1⟩ := textbookUnitPeriodicObservable_iteratedFDeriv_bound f hf hpf 1
  let J : (Fin Nc → ℝ) → ℝ := fun x ↦
    ∑ i : Fin Nc, ∑ j : Fin Nc, |textbookConfigurationPartial (textbookConfigurationPartial f j) i x|
  have hpart (i j : Fin Nc) : ContDiff ℝ ∞ (textbookConfigurationPartial (textbookConfigurationPartial f j) i) :=
    textbookConfigurationPartial_contDiff _ (textbookConfigurationPartial_contDiff f hf j) i
  have hppart (i j : Fin Nc) : textbookUnitPeriodicPotential (textbookConfigurationPartial (textbookConfigurationPartial f j) i) :=
    textbookConfigurationPartial_periodic _ (textbookConfigurationPartial_contDiff f hf j)
      (textbookConfigurationPartial_periodic f hf hpf j) i
  have hc : Continuous J := continuous_finsetSum _ fun i _ ↦
    continuous_finsetSum _ fun j _ ↦ (hpart i j).continuous.abs
  have hpJ : textbookUnitPeriodicPotential J := by
    intro x n
    dsimp [J]
    apply Finset.sum_congr rfl
    intro i _
    apply Finset.sum_congr rfl
    intro j _
    rw [hppart i j x n]
  obtain ⟨K2, hK2, hb2⟩ := textbookUnitPeriodicPotential_bound J hc hpJ
  refine ⟨K1, K2, hK1, hK2, fun x ↦ ⟨?_, ?_⟩⟩
  · simpa only [norm_iteratedFDeriv_one] using hb1 x
  · have hJ : 0 ≤ J x := Finset.sum_nonneg fun i _ ↦ Finset.sum_nonneg fun j _ ↦ abs_nonneg _
    simpa only [Real.norm_of_nonneg hJ, J] using hb2 x

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The literal same-process frozen error has exactly the true mean displacement error, since the actual physical Wiener noise has zero mean. -/
theorem textbookBrownianGlobalFrozenDriftError_expectation
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    (∫ sample, textbookBrownianGlobalFrozenDriftError m hm U hU hPU β hβ B x t sample ∂P) =
      (∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) -
        t • textbookBrownianSDEDrift m U x := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hiX := (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 1 (by norm_num)).integrable (by norm_num)
  have hiN := textbookBrownianPhysicalNoise_integrable m β B P hB t.toNNReal
  have hiD : Integrable (fun sample ↦
      textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x -
      t • textbookBrownianSDEDrift m U x) P := hiX.sub (integrable_const _)
  unfold textbookBrownianGlobalFrozenDriftError
  rw [integral_sub hiD hiN, integral_sub hiX (integrable_const _),
    textbookBrownianPhysicalNoise_mean m β B P hB t.toNNReal]
  simp

include hB in
/-- The original drift Lipschitz constant gives a derived true mean error uniformly in all initial configurations. -/
theorem textbookBrownianGlobalRandomConfiguration_mean_error_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : Fin Nc → ℝ, ∀ t : ℝ, 0 ≤ t →
      ‖(∫ sample, textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x ∂P) -
          t • textbookBrownianSDEDrift m U x‖ ≤
        (textbookBrownianDriftLipschitzConstant m U hU hPU : ℝ) *
          (M * t + (∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)) * Real.sqrt t) * t := by
  obtain ⟨M, hM, hb⟩ := textbookBrownianGlobalFrozenDriftError_norm_expectation_bound m hm U hU hPU β hβ B P hB
  refine ⟨M, hM, fun x t ht ↦ ?_⟩
  rw [← textbookBrownianGlobalFrozenDriftError_expectation m hm U hU hPU β hβ B P hB x t ht]
  exact (norm_integral_le_integral_norm _).trans (hb x t ht)


variable (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hpf : textbookUnitPeriodicPotential f)

include hB hf hpf in
/-- True mean, covariance and Taylor errors give the original generator's uniform unscaled probability error. -/
theorem textbookBrownianGlobalRandomConfiguration_uniform_generator_error :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      ‖(∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
          f x - t * textbookBrownianGenerator m U β f x‖ ≤ C * (t + Real.sqrt t) * t := by
  obtain ⟨M1, hM1, hmean⟩ := textbookBrownianGlobalRandomConfiguration_mean_error_bound m hm U hU hPU β hβ B P hB
  obtain ⟨M2, hM2, hsecond⟩ := textbookBrownianGlobalRandomConfiguration_second_product_error_bound m hm U hU hPU β hβ B P hB
  obtain ⟨K1, K2, hK1, hK2, hjet⟩ := textbookBrownianObservable_Taylor_coefficients_bound f hf hpf
  obtain ⟨Cr, hCr, hrem⟩ := textbookBrownianGlobalObservableTaylorRemainder_norm_expectation_bound m hm U hU hPU β hβ B P hB f hf hpf
  let N : ℝ := ∑ i : Fin Nc, Real.sqrt (2 * β⁻¹ * (m i)⁻¹)
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hPU
  have hN : 0 ≤ N := Finset.sum_nonneg fun i _ ↦ Real.sqrt_nonneg _
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hPU).property
  let A : ℝ := K1 * L * M1 + (2 : ℝ)⁻¹ * K2 * M2^2
  let D0 : ℝ := K1 * L * N + K2 * M2 * N + Cr
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
    rw [textbookBrownianGlobalRandomConfiguration_observable_expectation_Taylor m hm U hU hPU β hβ B P hB f hf hpf x t ht.1,
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
  have hR : ‖R‖ ≤ Cr * t * Real.sqrt t := (norm_integral_le_integral_norm _).trans (hrem x t ht)
  have hQC : ‖(2 : ℝ)⁻¹ * Q‖ ≤ (2 : ℝ)⁻¹ * (K2 * err) := by
    rw [norm_mul, Real.norm_of_nonneg (show 0 ≤ (2 : ℝ)⁻¹ by norm_num)]
    exact mul_le_mul_of_nonneg_left hQ (by norm_num)
  calc
    _ ≤ ‖fderiv ℝ f x D‖ + ‖(2 : ℝ)⁻¹ * Q‖ + ‖R‖ := by
      rw [he]
      exact (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ K1 * (L * (M1 * t + N * Real.sqrt t) * t) +
        (2 : ℝ)⁻¹ * (K2 * err) + Cr * t * Real.sqrt t :=
      add_le_add (add_le_add hlin hQC) hR
    _ = (A * t + D0 * Real.sqrt t) * t := by dsimp [A, D0, err]; ring_nf
    _ ≤ (A + D0) * (t + Real.sqrt t) * t := by
      apply mul_le_mul_of_nonneg_right _ ht.1
      nlinarith [mul_nonneg hA (Real.sqrt_nonneg t), mul_nonneg hD0 ht.1]

include hB hf hpf in
/-- The true probability generator quotient error has one bound for every initial state. -/
theorem textbookBrownianGlobalRandomConfiguration_uniform_generator_quotient_error :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Ioc (0 : ℝ) 1,
      ‖((∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
          f x) / t - textbookBrownianGenerator m U β f x‖ ≤ C * (t + Real.sqrt t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianGlobalRandomConfiguration_uniform_generator_error m hm U hU hPU β hβ B P hB f hf hpf
  refine ⟨C, hC, fun x t ht ↦ ?_⟩
  have he : ((∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) - f x) / t -
      textbookBrownianGenerator m U β f x =
      ((∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample) ∂P) -
        f x - t * textbookBrownianGenerator m U β f x) / t := by field_simp [ht.1.ne']
  rw [he, norm_div, Real.norm_of_nonneg ht.1.le]
  exact ((div_le_div_iff_of_pos_right ht.1).mpr (hb x t ⟨ht.1.le, ht.2⟩)).trans_eq (by field_simp [ht.1.ne'])

/-- The original periodic continuous lift, as a true continuous torus observable. -/
def textbookConfigurationContinuousObservable {N : ℕ}
    (g : (Fin N → ℝ) → ℝ) (hg : Continuous g) (hpg : textbookUnitPeriodicPotential g) :
    C(UnitAddTorus (Fin N), ℝ) :=
  ⟨textbookConfigurationTorusObservable g, textbookConfigurationTorusObservable_continuous g hg hpg⟩

/-- The literal original generator image on the same actual continuous torus space. -/
def textbookBrownianContinuousGeneratorImage : C(UnitAddTorus (Fin Nc), ℝ) :=
  textbookConfigurationContinuousObservable (textbookBrownianGenerator m U β f)
    (textbookBrownianGenerator_contDiff m U β f hU hf).continuous
    (textbookBrownianGenerator_periodic m U β f hU hf hPU hpf)

include hB hf hpf in
/-- The true probability operator on the original continuous observable is exactly the same global q expectation. -/
theorem textbookBrownianTorusProbabilityOperator_original_observable_expectation
    (t : ℝ≥0) (X : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t
      (textbookConfigurationContinuousObservable f hf.continuous hpf) X =
      ∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
        (textbookConfigurationTorusRepresentative X) B t sample) ∂P := by
  rw [textbookBrownianTorusProbabilityOperator_apply,
    textbookBrownianTorusTransitionExpectation_actual_probability m hm U hU hPU β hβ B P hB]
  change (∫ sample, textbookConfigurationTorusObservable f
    (textbookConfigurationTorusProjection (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
      (textbookConfigurationTorusRepresentative X) B t sample)) ∂P) = _
  exact integral_congr_ae (Eventually.of_forall fun sample ↦ textbookConfigurationTorusObservable_lift f hpf _)

include hB hf hpf in
/-- The whole true C(Torus,Real) norm has the derived uniform original-generator quotient error. -/
theorem textbookBrownianTorusProbabilityOperator_uniform_generator_error :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ t ∈ Ioc (0 : ℝ) 1,
      ‖t⁻¹ • (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
          (textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf‖ ≤ C * (t + Real.sqrt t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianGlobalRandomConfiguration_uniform_generator_quotient_error m hm U hU hPU β hβ B P hB f hf hpf
  refine ⟨C, hC, fun t ht ↦ ?_⟩
  have hbound : 0 ≤ C * (t + Real.sqrt t) := mul_nonneg hC (add_nonneg ht.1.le (Real.sqrt_nonneg t))
  apply (ContinuousMap.norm_le _ hbound).mpr
  intro X
  change ‖t⁻¹ * (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
      (textbookConfigurationContinuousObservable f hf.continuous hpf) X - f (textbookConfigurationTorusRepresentative X)) -
      textbookBrownianGenerator m U β f (textbookConfigurationTorusRepresentative X)‖ ≤ _
  rw [textbookBrownianTorusProbabilityOperator_original_observable_expectation m hm U hU hPU β hβ B P hB f hf hpf,
    Real.coe_toNNReal t ht.1.le]
  simpa only [div_eq_mul_inv, mul_comm] using hb (textbookConfigurationTorusRepresentative X) t ht

include hB hf hpf in
/-- The original smooth periodic core belongs to the true probability semigroup's strong uniform-norm generator, with exactly the textbook image. -/
theorem textbookBrownianTorusProbabilityOperator_original_generator_tendsto :
    Tendsto (fun t : ℝ ↦ t⁻¹ •
      (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookConfigurationContinuousObservable f hf.continuous hpf))
      (𝓝[>] 0) (𝓝 (textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf)) := by
  obtain ⟨C, _, hC⟩ := textbookBrownianTorusProbabilityOperator_uniform_generator_error m hm U hU hPU β hβ B P hB f hf hpf
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ),
      ‖t⁻¹ • (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookConfigurationContinuousObservable f hf.continuous hpf) -
        textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf‖ ≤ C * (t + Real.sqrt t) := by
    have hsmall : ∀ᶠ t : ℝ in 𝓝[>] 0, t < 1 :=
      (show ∀ᶠ t : ℝ in 𝓝 0, t < 1 from Iio_mem_nhds (show (0 : ℝ) < 1 by norm_num)).filter_mono nhdsWithin_le_nhds
    filter_upwards [self_mem_nhdsWithin, hsmall] with t ht ht1
    exact hC t ⟨ht, ht1.le⟩
  have hc : Continuous (fun t : ℝ ↦ C * (t + Real.sqrt t)) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦ C * (t + Real.sqrt t)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [Real.sqrt_zero, add_zero, mul_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  have hz := squeeze_zero_norm' hb hl
  simpa only [sub_add_cancel, zero_add] using hz.add_const (textbookBrownianContinuousGeneratorImage m U hU hPU β f hf hpf)
end
end MolecularDynamics
