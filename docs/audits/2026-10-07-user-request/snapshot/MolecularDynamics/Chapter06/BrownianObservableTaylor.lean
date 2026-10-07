import MolecularDynamics.Chapter06.BrownianFourthMomentEstimates
import MolecularDynamics.Chapter06.BrownianDirichlet
import Mathlib.Analysis.Calculus.TaylorIntegral

/-! Necessary Taylor remainder bounds for the same actual Brownian process
and original smooth integer-periodic observables in Theorem 6.1. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

/-- Every actual iterated derivative preserves the original integer-lattice periodicity. -/
theorem textbookUnitPeriodicObservable_iteratedFDeriv_periodic {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential f)
    (k : ℕ) (x : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    iteratedFDeriv ℝ k f (x + fun i ↦ (n i : ℝ)) = iteratedFDeriv ℝ k f x := by
  let c : Fin Nc → ℝ := fun i ↦ (n i : ℝ)
  have he : (fun z ↦ f (z + c)) = f := funext (fun z ↦ hp z n)
  rw [← iteratedFDeriv_comp_add_right k c x, he]

/-- The compact fundamental cube gives a derived global norm bound for every smooth periodic jet. -/
theorem textbookUnitPeriodicObservable_iteratedFDeriv_bound {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f)
    (hp : textbookUnitPeriodicPotential f) (k : ℕ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x, ‖iteratedFDeriv ℝ k f x‖ ≤ M := by
  have hc : Continuous (iteratedFDeriv ℝ k f) :=
    hf.continuous_iteratedFDeriv (by simp)
  obtain ⟨M, hb⟩ := isCompact_Icc.exists_bound_of_continuousOn
    (hc.continuousOn : ContinuousOn (iteratedFDeriv ℝ k f) (Icc (0 : Fin Nc → ℝ) 1))
  have h0 : (0 : Fin Nc → ℝ) ∈ Icc 0 1 := ⟨le_rfl, fun _ ↦ zero_le_one⟩
  refine ⟨M, (norm_nonneg _).trans (hb 0 h0), fun x ↦ ?_⟩
  let a : Fin Nc → ℝ := fun i ↦ Int.fract (x i)
  let n : Fin Nc → ℤ := fun i ↦ Int.floor (x i)
  have ha : a ∈ Icc (0 : Fin Nc → ℝ) 1 :=
    ⟨fun i ↦ Int.fract_nonneg (x i), fun i ↦ (Int.fract_lt_one (x i)).le⟩
  have he : a + (fun i ↦ (n i : ℝ)) = x := funext (fun i ↦ Int.fract_add_floor (x i))
  have hh := textbookUnitPeriodicObservable_iteratedFDeriv_periodic f hp k a n
  rw [he] at hh
  rw [hh]
  exact hb a ha

/-- The literal second-order error, using the observable's actual Frechet derivatives. -/
def textbookBrownianObservableTaylorRemainder {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (x y : Fin Nc → ℝ) : ℝ :=
  f (x + y) - f x - fderiv ℝ f x y -
    (2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 f x (fun _ ↦ y)

/-- The actual multivariate Taylor formula identifies the literal error with its true third-derivative integral. -/
theorem textbookBrownianObservableTaylorRemainder_eq_integral {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (x y : Fin Nc → ℝ) :
    textbookBrownianObservableTaylorRemainder f x y =
      (2 : ℝ)⁻¹ * ∫ s in (0 : ℝ)..1,
        (1 - s)^2 • iteratedFDeriv ℝ 3 f (x + s • y) (fun _ ↦ y) := by
  have he := map_add_eq_sum_add_integral_iteratedFDeriv (f := f) (n := 2)
    (x := x) (y := y) (fun s _ ↦ hf.contDiffAt.of_le (by simp))
  norm_num [Finset.sum_range_succ, iteratedFDeriv_zero_apply, iteratedFDeriv_one_apply,
    smul_eq_mul] at he
  unfold textbookBrownianObservableTaylorRemainder
  rw [he]
  ring_nf

/-- Original periodic smoothness, rather than an assumed remainder estimate, yields a uniform cubic error. -/
theorem textbookBrownianObservableTaylorRemainder_bound {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hp : textbookUnitPeriodicPotential f) :
    ∃ K : ℝ, 0 ≤ K ∧ ∀ x y, ‖textbookBrownianObservableTaylorRemainder f x y‖ ≤ K * ‖y‖^3 := by
  obtain ⟨M, hM, hb⟩ := textbookUnitPeriodicObservable_iteratedFDeriv_bound f hf hp 3
  refine ⟨(2 : ℝ)⁻¹ * M, mul_nonneg (by norm_num) hM, fun x y ↦ ?_⟩
  have hi : ‖∫ s in (0 : ℝ)..1,
      (1 - s)^2 • iteratedFDeriv ℝ 3 f (x + s • y) (fun _ ↦ y)‖ ≤ M * ‖y‖^3 := by
    have hpoint : ∀ s ∈ uIoc (0 : ℝ) 1,
        ‖(1 - s)^2 • iteratedFDeriv ℝ 3 f (x + s • y) (fun _ ↦ y)‖ ≤ M * ‖y‖^3 := by
      intro s hs
      rw [uIoc_of_le (show (0 : ℝ) ≤ 1 by norm_num)] at hs
      have hs2 : (1 - s)^2 ≤ 1 := by nlinarith [hs.1, hs.2]
      have hj : ‖iteratedFDeriv ℝ 3 f (x + s • y) (fun _ ↦ y)‖ ≤ M * ‖y‖^3 := by
        simpa using (iteratedFDeriv ℝ 3 f (x + s • y)).le_of_opNorm_le (hb _) (fun _ ↦ y)
      rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
      exact (mul_le_mul hs2 hj (norm_nonneg _) zero_le_one).trans_eq (one_mul _)
    simpa using intervalIntegral.norm_integral_le_of_norm_le_const hpoint
  rw [textbookBrownianObservableTaylorRemainder_eq_integral f hf x y, norm_mul,
    Real.norm_eq_abs, abs_of_nonneg (show 0 ≤ (2 : ℝ)⁻¹ by norm_num)]
  exact (mul_le_mul_of_nonneg_left hi (by norm_num)).trans_eq (by ring_nf)

/-- The literal remainder is continuous in the actual displacement. -/
theorem textbookBrownianObservableTaylorRemainder_continuous {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (x : Fin Nc → ℝ) :
    Continuous (textbookBrownianObservableTaylorRemainder f x) := by
  unfold textbookBrownianObservableTaylorRemainder
  fun_prop


variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hpf : textbookUnitPeriodicPotential f)

/-- The literal remainder along the same original global Wiener-driven configuration. -/
def textbookBrownianGlobalObservableTaylorRemainder (x : Fin Nc → ℝ) (t : ℝ) (sample : Ω) : ℝ :=
  textbookBrownianObservableTaylorRemainder f x
    (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x)

include hB hf hpf in
/-- True finite third moments and actual endpoint measurability give genuine remainder integrability. -/
theorem textbookBrownianGlobalObservableTaylorRemainder_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    Integrable (textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t) P := by
  obtain ⟨K, _, hb⟩ := textbookBrownianObservableTaylorRemainder_bound f hf hpf
  have hx := textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 3 (by norm_num)
  have hdom := (hx.integrable_norm_pow (by norm_num)).const_mul K
  have hmeas := (textbookBrownianObservableTaylorRemainder_continuous f hf.continuous x).comp_aestronglyMeasurable hx.aestronglyMeasurable
  exact hdom.mono' hmeas (Eventually.of_forall fun sample ↦ hb x _)

include hB hf hpf in
/-- The actual probability expectation of the literal Taylor error is uniformly O(t^(3/2)). -/
theorem textbookBrownianGlobalObservableTaylorRemainder_norm_expectation_bound :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) ≤
        C * t * Real.sqrt t := by
  obtain ⟨K, hK, hb⟩ := textbookBrownianObservableTaylorRemainder_bound f hf hpf
  obtain ⟨C3, hC3, h3⟩ := textbookBrownianGlobalRandomConfiguration_norm_third_moment_small_time m hm U hU hPU β hβ B P hB
  refine ⟨K * C3, mul_nonneg hK hC3, fun x t ht ↦ ?_⟩
  have hi := textbookBrownianGlobalObservableTaylorRemainder_integrable m hm U hU hPU β hβ B P hB f hf hpf x t ht.1
  have hx := textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht.1 3 (by norm_num)
  calc
    _ ≤ ∫ sample, K * ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P :=
      integral_mono_ae hi.norm ((hx.integrable_norm_pow (by norm_num)).const_mul K)
        (Eventually.of_forall fun sample ↦ hb x _)
    _ = K * ∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^3 ∂P := integral_const_mul _ _
    _ ≤ K * (C3 * t * Real.sqrt t) := mul_le_mul_of_nonneg_left (h3 x t ht) hK
    _ = _ := by ring_nf

include hB hf hpf in
/-- The true expected norm of the actual Taylor remainder divided by time vanishes at zero. -/
theorem textbookBrownianGlobalObservableTaylorRemainder_norm_div_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _, hC⟩ := textbookBrownianGlobalObservableTaylorRemainder_norm_expectation_bound m hm U hU hPU β hβ B P hB f hf hpf
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ), (∫ sample,
      ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t ≤ C * Real.sqrt t := by
    have hsmall : ∀ᶠ t : ℝ in 𝓝[>] 0, t < 1 :=
      (show ∀ᶠ t : ℝ in 𝓝 0, t < 1 from Iio_mem_nhds (show (0 : ℝ) < 1 by norm_num)).filter_mono nhdsWithin_le_nhds
    filter_upwards [self_mem_nhdsWithin, hsmall] with t ht ht1
    have ht0 : 0 < t := ht
    exact ((div_le_div_iff_of_pos_right ht0).mpr (hC x t ⟨ht0.le, ht1.le⟩)).trans_eq (by field_simp [ht0.ne'])
  have hnon : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 ≤ (∫ sample,
      ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg fun _ ↦ norm_nonneg _) ht.le
  have hc : Continuous (fun t : ℝ ↦ C * Real.sqrt t) := by fun_prop
  have hl : Tendsto (fun t : ℝ ↦ C * Real.sqrt t) (𝓝[>] 0) (𝓝 0) := by
    simpa only [Real.sqrt_zero, mul_zero] using (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  exact squeeze_zero' hnon hb hl

include hB hf hpf in
/-- The actual signed expected remainder divided by time also vanishes, by its true norm estimate. -/
theorem textbookBrownianGlobalObservableTaylorRemainder_expectation_div_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample ∂P) / t)
      (𝓝[>] 0) (𝓝 0) := by
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ), ‖(∫ sample,
      textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample ∂P) / t‖ ≤
      (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    rw [norm_div, Real.norm_of_nonneg ht.le]
    exact div_le_div_of_nonneg_right (norm_integral_le_integral_norm _) ht.le
  exact squeeze_zero_norm' hb
    (textbookBrownianGlobalObservableTaylorRemainder_norm_div_tendsto m hm U hU hPU β hβ B P hB f hf hpf x)
end
end MolecularDynamics
