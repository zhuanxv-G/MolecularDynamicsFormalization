import MolecularDynamics.Chapter06.BrownianProbabilityGibbsImage
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Topology.UniformSpace.HeineCantor

/-! Necessary true second-order Taylor estimates for the original C2 periodic
observable range; higher observable regularity is not assumed. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

/-- Every existing jet through order two is globally bounded for an actual C2 integer-periodic observable. -/
theorem textbookUnitPeriodicC2Observable_iteratedFDeriv_bound {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f)
    (hp : textbookUnitPeriodicPotential f) (k : ℕ) (hk : k ≤ 2) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x, ‖iteratedFDeriv ℝ k f x‖ ≤ M := by
  have hc : Continuous (iteratedFDeriv ℝ k f) :=
    hf.continuous_iteratedFDeriv (by exact_mod_cast hk)
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

/-- Periodicity and compact continuity give a derived global uniform modulus for the actual Hessian. -/
theorem textbookUnitPeriodicC2Observable_hessian_uniform_modulus {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hp : textbookUnitPeriodicPotential f)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ x y, ‖y‖ < δ →
      ‖iteratedFDeriv ℝ 2 f (x + y) - iteratedFDeriv ℝ 2 f x‖ < ε := by
  have hc : Continuous (iteratedFDeriv ℝ 2 f) := hf.continuous_iteratedFDeriv (by norm_num)
  have hu := isCompact_Icc.uniformContinuousOn_of_continuous
    (hc.continuousOn : ContinuousOn (iteratedFDeriv ℝ 2 f) (Icc (-1 : Fin Nc → ℝ) 2))
  obtain ⟨d, hd, hb⟩ := Metric.uniformContinuousOn_iff.mp hu ε hε
  refine ⟨min d 1, lt_min hd zero_lt_one, fun x y hy ↦ ?_⟩
  have hyd : ‖y‖ < d := hy.trans_le (min_le_left _ _)
  have hy1 : ‖y‖ < 1 := hy.trans_le (min_le_right _ _)
  let a : Fin Nc → ℝ := fun i ↦ Int.fract (x i)
  let n : Fin Nc → ℤ := fun i ↦ Int.floor (x i)
  have ha : a ∈ Icc (-1 : Fin Nc → ℝ) 2 := by
    constructor
    · intro i
      change (-1 : ℝ) ≤ Int.fract (x i)
      linarith [Int.fract_nonneg (x i)]
    · intro i
      change Int.fract (x i) ≤ (2 : ℝ)
      linarith [Int.fract_lt_one (x i)]
  have hay : a + y ∈ Icc (-1 : Fin Nc → ℝ) 2 := by
    constructor
    · intro i
      change (-1 : ℝ) ≤ Int.fract (x i) + y i
      have hyi : |y i| ≤ ‖y‖ := by simpa only [Real.norm_eq_abs] using norm_le_pi_norm y i
      linarith [neg_abs_le (y i), Int.fract_nonneg (x i)]
    · intro i
      change Int.fract (x i) + y i ≤ (2 : ℝ)
      have hyi : |y i| ≤ ‖y‖ := by simpa only [Real.norm_eq_abs] using norm_le_pi_norm y i
      linarith [le_abs_self (y i), Int.fract_lt_one (x i)]
  have he : a + (fun i ↦ (n i : ℝ)) = x := funext (fun i ↦ Int.fract_add_floor (x i))
  have hey : (a + y) + (fun i ↦ (n i : ℝ)) = x + y := by
    calc
      _ = (a + fun i ↦ (n i : ℝ)) + y := by abel
      _ = x + y := by rw [he]
  have hax := textbookUnitPeriodicObservable_iteratedFDeriv_periodic f hp 2 a n
  have hayx := textbookUnitPeriodicObservable_iteratedFDeriv_periodic f hp 2 (a + y) n
  rw [he] at hax
  rw [hey] at hayx
  rw [hayx, hax]
  have hdist : dist (a + y) a < d := by simpa only [dist_eq_norm, add_sub_cancel_left] using hyd
  simpa only [dist_eq_norm] using hb (a + y) hay a ha hdist

/-- The literal second-order remainder for an actual C2 observable is the integral of the true Hessian difference. -/
theorem textbookBrownianC2ObservableTaylorRemainder_eq_integral {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (x y : Fin Nc → ℝ) :
    textbookBrownianObservableTaylorRemainder f x y =
      ∫ s in (0 : ℝ)..1, (1 - s) •
        (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y) := by
  have he := map_add_eq_sum_add_integral_iteratedFDeriv (f := f) (n := 1)
    (x := x) (y := y) (fun s _ ↦ hf.contDiffAt.of_le (by norm_num))
  norm_num [Finset.sum_range_succ, iteratedFDeriv_zero_apply, iteratedFDeriv_one_apply,
    smul_eq_mul] at he
  have hH : Continuous (iteratedFDeriv ℝ 2 f) := hf.continuous_iteratedFDeriv (by norm_num)
  have hc : Continuous (fun s : ℝ ↦ (1 - s) * iteratedFDeriv ℝ 2 f (x + s • y) (fun _ ↦ y)) := by fun_prop
  have hk : Continuous (fun s : ℝ ↦ (1 - s) * iteratedFDeriv ℝ 2 f x (fun _ ↦ y)) := by fun_prop
  have hconst : (∫ s in (0 : ℝ)..1, (1 - s) * iteratedFDeriv ℝ 2 f x (fun _ ↦ y)) =
      (2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 f x (fun _ ↦ y) := by
    rw [intervalIntegral.integral_mul_const]
    have hw : (∫ s in (0 : ℝ)..1, (1 - s)) = (2 : ℝ)⁻¹ := by
      have hi1 : IntervalIntegrable (fun _ : ℝ ↦ (1 : ℝ)) volume 0 1 := continuous_const.intervalIntegrable 0 1
      have hii : IntervalIntegrable (fun s : ℝ ↦ s) volume 0 1 := continuous_id.intervalIntegrable 0 1
      rw [intervalIntegral.integral_sub hi1 hii]
      norm_num [intervalIntegral.integral_const, integral_id]
    rw [hw]
  simp only [sub_apply, smul_eq_mul, mul_sub]
  rw [intervalIntegral.integral_sub (hc.intervalIntegrable 0 1) (hk.intervalIntegrable 0 1), hconst]
  unfold textbookBrownianObservableTaylorRemainder
  rw [he]
  ring

/-- The true C2 periodic Hessian bound gives a genuine global quadratic remainder estimate. -/
theorem textbookBrownianC2ObservableTaylorRemainder_quadratic_bound {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hp : textbookUnitPeriodicPotential f) :
    ∃ K : ℝ, 0 ≤ K ∧ ∀ x y, ‖textbookBrownianObservableTaylorRemainder f x y‖ ≤ K * ‖y‖^2 := by
  obtain ⟨M, hM, hb⟩ := textbookUnitPeriodicC2Observable_iteratedFDeriv_bound f hf hp 2 le_rfl
  refine ⟨2 * M, mul_nonneg (by norm_num) hM, fun x y ↦ ?_⟩
  have hpoint : ∀ s ∈ uIoc (0 : ℝ) 1,
      ‖(1 - s) • (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤
        (2 * M) * ‖y‖^2 := by
    intro s hs
    rw [uIoc_of_le (show (0 : ℝ) ≤ 1 by norm_num)] at hs
    have hdiff : ‖iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x‖ ≤ 2 * M :=
      (norm_sub_le _ _).trans ((add_le_add (hb _) (hb _)).trans_eq (by ring))
    have hj : ‖(iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤ (2 * M) * ‖y‖^2 := by
      simpa using (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x).le_of_opNorm_le hdiff (fun _ ↦ y)
    rw [norm_smul, Real.norm_of_nonneg (sub_nonneg.mpr hs.2)]
    exact (mul_le_mul (by linarith [hs.1]) hj
      (norm_nonneg ((iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y))) zero_le_one).trans_eq (one_mul _)
  rw [textbookBrownianC2ObservableTaylorRemainder_eq_integral f hf x y]
  simpa using intervalIntegral.norm_integral_le_of_norm_le_const hpoint

/-- The original C2 range has a uniform genuine Peano remainder, derived from actual Hessian continuity and periodicity. -/
theorem textbookBrownianC2ObservableTaylorRemainder_uniform_peano {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hp : textbookUnitPeriodicPotential f)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ x y, ‖y‖ < δ →
      ‖textbookBrownianObservableTaylorRemainder f x y‖ ≤ ε * ‖y‖^2 := by
  obtain ⟨δ, hδ, hb⟩ := textbookUnitPeriodicC2Observable_hessian_uniform_modulus f hf hp ε hε
  refine ⟨δ, hδ, fun x y hy ↦ ?_⟩
  have hpoint : ∀ s ∈ uIoc (0 : ℝ) 1,
      ‖(1 - s) • (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤ ε * ‖y‖^2 := by
    intro s hs
    rw [uIoc_of_le (show (0 : ℝ) ≤ 1 by norm_num)] at hs
    have hsy : ‖s • y‖ < δ := by
      rw [norm_smul, Real.norm_of_nonneg hs.1.le]
      exact (mul_le_of_le_one_left (norm_nonneg y) hs.2).trans_lt hy
    have hj : ‖(iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤ ε * ‖y‖^2 := by
      simpa using (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x).le_of_opNorm_le (hb x (s • y) hsy).le (fun _ ↦ y)
    rw [norm_smul, Real.norm_of_nonneg (sub_nonneg.mpr hs.2)]
    exact (mul_le_mul (by linarith [hs.1]) hj
      (norm_nonneg ((iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y))) zero_le_one).trans_eq (one_mul _)
  rw [textbookBrownianC2ObservableTaylorRemainder_eq_integral f hf x y]
  simpa using intervalIntegral.norm_integral_le_of_norm_le_const hpoint


/-- The genuine C2 Peano bound and global quadratic bound combine into an all-displacement quadratic-plus-quartic estimate. -/
theorem textbookBrownianC2ObservableTaylorRemainder_quartic_uniform_bound {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hp : textbookUnitPeriodicPotential f)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x y,
      ‖textbookBrownianObservableTaylorRemainder f x y‖ ≤ ε * ‖y‖^2 + C * ‖y‖^4 := by
  obtain ⟨K, hK, hglobal⟩ := textbookBrownianC2ObservableTaylorRemainder_quadratic_bound f hf hp
  obtain ⟨δ, hδ, hlocal⟩ := textbookBrownianC2ObservableTaylorRemainder_uniform_peano f hf hp ε hε
  let C := K / δ^2
  have hC : 0 ≤ C := div_nonneg hK (sq_nonneg δ)
  refine ⟨C, hC, fun x y ↦ ?_⟩
  by_cases hy : ‖y‖ < δ
  · exact (hlocal x y hy).trans (le_add_of_nonneg_right (mul_nonneg hC (by positivity)))
  · have hs : δ^2 ≤ ‖y‖^2 := pow_le_pow_left₀ hδ.le (le_of_not_gt hy) 2
    have hratio : 1 ≤ ‖y‖^2 / δ^2 :=
      (le_div_iff₀ (sq_pos_of_pos hδ)).mpr (by simpa using hs)
    have hcoeff : K ≤ C * ‖y‖^2 := by
      calc
        K = K * 1 := (mul_one _).symm
        _ ≤ K * (‖y‖^2 / δ^2) := mul_le_mul_of_nonneg_left hratio hK
        _ = C * ‖y‖^2 := by dsimp [C]; ring
    have hbig : K * ‖y‖^2 ≤ C * ‖y‖^4 := by
      calc
        _ ≤ (C * ‖y‖^2) * ‖y‖^2 := mul_le_mul_of_nonneg_right hcoeff (sq_nonneg _)
        _ = _ := by ring
    exact (hglobal x y).trans (hbig.trans (le_add_of_nonneg_left (mul_nonneg hε.le (sq_nonneg _))))

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f)

include hB hf hpf in
/-- The literal C2 remainder along the same original q is genuinely integrable, using its true second moments. -/
theorem textbookBrownianGlobalC2ObservableTaylorRemainder_integrable
    (x : Fin Nc → ℝ) (t : ℝ) (ht : 0 ≤ t) :
    Integrable (textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t) P := by
  obtain ⟨K, _, hb⟩ := textbookBrownianC2ObservableTaylorRemainder_quadratic_bound f hf hpf
  have hx := textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht 2 (by norm_num)
  have hdom := (hx.integrable_norm_pow (by norm_num)).const_mul K
  have hmeas := (textbookBrownianObservableTaylorRemainder_continuous f hf.continuous x).comp_aestronglyMeasurable hx.aestronglyMeasurable
  exact hdom.mono' hmeas (Eventually.of_forall fun sample ↦ hb x _)

include hB hf hpf in
/-- Actual second and fourth moments give a true uniform expected C2 remainder bound epsilon t plus C_epsilon t squared. -/
theorem textbookBrownianGlobalC2ObservableTaylorRemainder_uniform_norm_expectation_bound
    (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ x : Fin Nc → ℝ, ∀ t ∈ Icc (0 : ℝ) 1,
      (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) ≤
        ε * t + C * t^2 := by
  obtain ⟨C2, hC2, h2⟩ := textbookBrownianGlobalRandomConfiguration_norm_second_moment_small_time m hm U hU hPU β hβ B P hB
  obtain ⟨C4, hC4, h4⟩ := textbookBrownianGlobalRandomConfiguration_norm_fourth_moment_small_time m hm U hU hPU β hβ B P hB
  let e := ε / (C2 + 1)
  have he : 0 < e := div_pos hε (by linarith)
  obtain ⟨K, hK, hb⟩ := textbookBrownianC2ObservableTaylorRemainder_quartic_uniform_bound f hf hpf e he
  have heC : e * C2 ≤ ε := by
    dsimp [e]
    rw [div_mul_eq_mul_div]
    exact (div_le_iff₀ (by linarith : 0 < C2 + 1)).mpr (by nlinarith)
  refine ⟨K * C4, mul_nonneg hK hC4, fun x t ht ↦ ?_⟩
  have hi := textbookBrownianGlobalC2ObservableTaylorRemainder_integrable m hm U hU hPU β hβ B P hB f hf hpf x t ht.1
  have hi2 : Integrable (fun sample ↦ ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2) P :=
    (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht.1 2 (by norm_num)).integrable_norm_pow (by norm_num)
  have hi4 : Integrable (fun sample ↦ ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4) P :=
    (textbookBrownianGlobalRandomConfiguration_increment_memLp m hm U hU hPU β hβ B P hB x t ht.1 4 (by norm_num)).integrable_norm_pow (by norm_num)
  calc
    _ ≤ ∫ sample, e * ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2 +
        K * ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4 ∂P :=
      integral_mono_ae hi.norm ((hi2.const_mul e).add (hi4.const_mul K))
        (Eventually.of_forall fun sample ↦ hb x _)
    _ = e * (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^2 ∂P) +
        K * (∫ sample, ‖textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ x B t sample - x‖^4 ∂P) := by
      rw [integral_add (hi2.const_mul e) (hi4.const_mul K), integral_const_mul, integral_const_mul]
    _ ≤ e * (C2 * t) + K * (C4 * t^2) :=
      add_le_add (mul_le_mul_of_nonneg_left (h2 x t ht) he.le) (mul_le_mul_of_nonneg_left (h4 x t ht) hK)
    _ = (e * C2) * t + (K * C4) * t^2 := by ring
    _ ≤ _ := add_le_add (mul_le_mul_of_nonneg_right heC ht.1) le_rfl

include hB hf hpf in
/-- The actual expected norm of the original C2 remainder divided by time vanishes uniformly over every initial configuration. -/
theorem textbookBrownianGlobalC2ObservableTaylorRemainder_norm_div_uniform_small
    (ε : ℝ) (hε : 0 < ε) :
    ∀ᶠ t : ℝ in 𝓝[>] 0, ∀ x : Fin Nc → ℝ,
      0 ≤ (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t ∧
      (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t < ε := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianGlobalC2ObservableTaylorRemainder_uniform_norm_expectation_bound m hm U hU hPU β hβ B P hB f hf hpf (ε / 2) (by positivity)
  have hden : 0 < 2 * (C + 1) := by positivity
  have hsmall : ∀ᶠ t : ℝ in 𝓝[>] 0, t < ε / (2 * (C + 1)) :=
    (show ∀ᶠ t : ℝ in 𝓝 0, t < ε / (2 * (C + 1)) from Iio_mem_nhds (div_pos hε hden)).filter_mono nhdsWithin_le_nhds
  have htime : ∀ᶠ t : ℝ in 𝓝[>] 0, t < 1 :=
    (show ∀ᶠ t : ℝ in 𝓝 0, t < 1 from Iio_mem_nhds zero_lt_one).filter_mono nhdsWithin_le_nhds
  filter_upwards [self_mem_nhdsWithin, hsmall, htime] with t ht hts ht1
  intro x
  refine ⟨div_nonneg (integral_nonneg fun sample ↦ norm_nonneg _) ht.le, ?_⟩
  have hr := hb x t ⟨ht.le, ht1.le⟩
  have hquot : (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t ≤ ε / 2 + C * t :=
    (div_le_iff₀ ht).mpr (by nlinarith [hr])
  have hCt : C * t < ε / 2 := by
    have hd := (lt_div_iff₀ hden).mp hts
    nlinarith [ht]
  exact hquot.trans_lt (by linarith)

include hB hf hpf in
/-- In particular the same true expected C2 remainder norm divided by time tends to zero at every initial state. -/
theorem textbookBrownianGlobalC2ObservableTaylorRemainder_norm_div_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t)
      (𝓝[>] 0) (𝓝 0) := by
  apply Metric.tendsto_nhds.mpr
  intro ε hε
  filter_upwards [textbookBrownianGlobalC2ObservableTaylorRemainder_norm_div_uniform_small m hm U hU hPU β hβ B P hB f hf hpf ε hε] with t ht
  simpa only [dist_eq_norm, sub_zero, Real.norm_of_nonneg (ht x).1] using (ht x).2

include hB hf hpf in
/-- The actual signed expectation of the original C2 Taylor remainder divided by time also tends to zero. -/
theorem textbookBrownianGlobalC2ObservableTaylorRemainder_expectation_div_tendsto
    (x : Fin Nc → ℝ) :
    Tendsto (fun t : ℝ ↦ (∫ sample,
      textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample ∂P) / t)
      (𝓝[>] 0) (𝓝 0) := by
  have hb : ∀ᶠ t : ℝ in 𝓝[>] 0,
      ‖(∫ sample, textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample ∂P) / t‖ ≤
      (∫ sample, ‖textbookBrownianGlobalObservableTaylorRemainder m hm U hU hPU β hβ B f x t sample‖ ∂P) / t := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    rw [norm_div, Real.norm_of_nonneg ht.le]
    exact (div_le_div_iff_of_pos_right ht).mpr (norm_integral_le_integral_norm _)
  exact squeeze_zero_norm' hb
    (textbookBrownianGlobalC2ObservableTaylorRemainder_norm_div_tendsto m hm U hU hPU β hβ B P hB f hf hpf x)

end
end MolecularDynamics
