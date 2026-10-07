import MolecularDynamics.Chapter06.LangevinHamiltonianPowerKernelGenerator
import Mathlib.Analysis.Calculus.TaylorIntegral

/-! Genuine second-order C2 test-function Taylor remainders for the same actual
Langevin process. The test class's global Hessian bound is explicit, and no
actual remainder expectation limit is assumed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

/-- The literal real-phase second-order Taylor error of the actual observable. -/
def textbookLangevinC2ObservableTaylorRemainder {N : ℕ}
    (f : textbookLangevinPhase N → ℝ) (x y : textbookLangevinPhase N) : ℝ :=
  f (x + y) - f x - fderiv ℝ f x y -
    (2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 f x (fun _ ↦ y)

/-- Only C2 regularity is needed for the true integral Hessian-difference formula. -/
theorem textbookLangevinC2ObservableTaylorRemainder_eq_integral {N : ℕ}
    (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f) (x y : textbookLangevinPhase N) :
    textbookLangevinC2ObservableTaylorRemainder f x y =
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
  unfold textbookLangevinC2ObservableTaylorRemainder
  rw [he]
  ring

/-- An explicit global bound on the actual Hessian gives the true quadratic
Taylor bound. The Hessian condition does not assume a process remainder limit. -/
theorem textbookLangevinC2ObservableTaylorRemainder_quadratic_bound {N : ℕ}
    (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f)
    (M : ℝ) (hH : ∀ z, ‖iteratedFDeriv ℝ 2 f z‖ ≤ M) (x y : textbookLangevinPhase N) :
    ‖textbookLangevinC2ObservableTaylorRemainder f x y‖ ≤ (2 * M) * ‖y‖ ^ 2 := by
  have hpoint : ∀ s ∈ uIoc (0 : ℝ) 1,
      ‖(1 - s) • (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤
        (2 * M) * ‖y‖ ^ 2 := by
    intro s hs
    rw [uIoc_of_le (show (0 : ℝ) ≤ 1 by norm_num)] at hs
    have hdiff : ‖iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x‖ ≤ 2 * M :=
      (norm_sub_le _ _).trans ((add_le_add (hH _) (hH _)).trans_eq (by ring))
    have hj : ‖(iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤ (2 * M) * ‖y‖ ^ 2 := by
      simpa using (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x).le_of_opNorm_le hdiff (fun _ ↦ y)
    rw [norm_smul, Real.norm_of_nonneg (sub_nonneg.mpr hs.2)]
    exact (mul_le_mul (by linarith [hs.1]) hj (norm_nonneg _) zero_le_one).trans_eq (one_mul _)
  rw [textbookLangevinC2ObservableTaylorRemainder_eq_integral f hf x y]
  simpa using intervalIntegral.norm_integral_le_of_norm_le_const hpoint

private theorem c2Phase_local_peano {N : ℕ}
    (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f) (x : textbookLangevinPhase N)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ y, ‖y‖ < δ →
      ‖textbookLangevinC2ObservableTaylorRemainder f x y‖ ≤ ε * ‖y‖ ^ 2 := by
  have hc : Continuous (iteratedFDeriv ℝ 2 f) := hf.continuous_iteratedFDeriv (by norm_num)
  obtain ⟨δ, hδ, hb⟩ := Metric.continuousAt_iff.mp hc.continuousAt ε hε
  refine ⟨δ, hδ, fun y hy ↦ ?_⟩
  have hpoint : ∀ s ∈ uIoc (0 : ℝ) 1,
      ‖(1 - s) • (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤
        ε * ‖y‖ ^ 2 := by
    intro s hs
    rw [uIoc_of_le (show (0 : ℝ) ≤ 1 by norm_num)] at hs
    have hsy : dist (x + s • y) x < δ := by
      rw [dist_eq_norm, add_sub_cancel_left, norm_smul, Real.norm_of_nonneg hs.1.le]
      exact (mul_le_of_le_one_left (norm_nonneg y) hs.2).trans_lt hy
    have hdiff : ‖iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x‖ ≤ ε := by
      simpa only [dist_eq_norm] using (hb hsy).le
    have hj : ‖(iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x) (fun _ ↦ y)‖ ≤ ε * ‖y‖ ^ 2 := by
      simpa using (iteratedFDeriv ℝ 2 f (x + s • y) - iteratedFDeriv ℝ 2 f x).le_of_opNorm_le hdiff (fun _ ↦ y)
    rw [norm_smul, Real.norm_of_nonneg (sub_nonneg.mpr hs.2)]
    exact (mul_le_mul (by linarith [hs.1]) hj (norm_nonneg _) zero_le_one).trans_eq (one_mul _)
  rw [textbookLangevinC2ObservableTaylorRemainder_eq_integral f hf x y]
  simpa using intervalIntegral.norm_integral_le_of_norm_le_const hpoint

/-- Actual C2 Hessian continuity at the fixed phase and the explicit global
Hessian bound yield the genuine all-displacement quadratic-plus-quartic bound. -/
theorem textbookLangevinC2ObservableTaylorRemainder_quartic_pointwise_bound {N : ℕ}
    (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f)
    (M : ℝ) (hM : 0 ≤ M) (hH : ∀ z, ‖iteratedFDeriv ℝ 2 f z‖ ≤ M)
    (x : textbookLangevinPhase N) (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ y,
      ‖textbookLangevinC2ObservableTaylorRemainder f x y‖ ≤ ε * ‖y‖ ^ 2 + C * ‖y‖ ^ 4 := by
  obtain ⟨δ, hδ, hlocal⟩ := c2Phase_local_peano f hf x ε hε
  let C := (2 * M) / δ ^ 2
  have hC : 0 ≤ C := div_nonneg (by positivity) (sq_nonneg δ)
  refine ⟨C, hC, fun y ↦ ?_⟩
  by_cases hy : ‖y‖ < δ
  · exact (hlocal y hy).trans (le_add_of_nonneg_right (mul_nonneg hC (by positivity)))
  · have hs : δ ^ 2 ≤ ‖y‖ ^ 2 := pow_le_pow_left₀ hδ.le (le_of_not_gt hy) 2
    have hratio : 1 ≤ ‖y‖ ^ 2 / δ ^ 2 :=
      (le_div_iff₀ (sq_pos_of_pos hδ)).mpr (by simpa using hs)
    have hcoeff : 2 * M ≤ C * ‖y‖ ^ 2 := by
      calc
        _ = 2 * M * 1 := (mul_one _).symm
        _ ≤ 2 * M * (‖y‖ ^ 2 / δ ^ 2) := mul_le_mul_of_nonneg_left hratio (by positivity)
        _ = C * ‖y‖ ^ 2 := by dsimp [C]; ring
    have hbig : (2 * M) * ‖y‖ ^ 2 ≤ C * ‖y‖ ^ 4 := by
      calc
        _ ≤ (C * ‖y‖ ^ 2) * ‖y‖ ^ 2 := mul_le_mul_of_nonneg_right hcoeff (sq_nonneg _)
        _ = _ := by ring
    exact (textbookLangevinC2ObservableTaylorRemainder_quadratic_bound f hf M hH x y).trans
      (hbig.trans (le_add_of_nonneg_left (mul_nonneg hε.le (sq_nonneg _))))

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
  (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f)
  (M : ℝ) (hM : 0 ≤ M) (hH : ∀ z, ‖iteratedFDeriv ℝ 2 f z‖ ≤ M)

/-- The literal C2 Taylor remainder along the same actual original real phase,
using the fixed original periodic initial representative. -/
def textbookLangevinPeriodicC2ObservableTaylorRemainder
    (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) : ℝ :=
  textbookLangevinC2ObservableTaylorRemainder f
    (textbookLangevinPeriodicRepresentative x.1, x.2)
    (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)

include hB hU hp hf hH in
/-- The actual C2 remainder is integrable from its true Hessian bound and the
same actual process second moment, with no target remainder assumption. -/
theorem textbookLangevinPeriodicC2ObservableTaylorRemainder_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    Integrable (textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f T x) P := by
  have hi : Integrable (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 2) P := by
    simpa using textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
      B P hB U hU hp L hF γ σ hγ T hT hT1 x 1 le_rfl
  have hc : Continuous (textbookLangevinC2ObservableTaylorRemainder f
      (textbookLangevinPeriodicRepresentative x.1, x.2)) := by
    unfold textbookLangevinC2ObservableTaylorRemainder
    have := hf.continuous
    fun_prop
  have hm : AEMeasurable (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x) P := (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).sub
      aemeasurable_const
  apply (hi.const_mul (2 * M)).mono'
    (hc.measurable.comp_aemeasurable hm).aestronglyMeasurable
  exact Eventually.of_forall (fun sample ↦
    textbookLangevinC2ObservableTaylorRemainder_quadratic_bound f hf M hH _ _)

include hB hU hp hf hM hH in
/-- For each fixed original initial phase, the expected norm of the actual C2
Taylor remainder divided by time tends to zero, from C2 continuity and true
original second/fourth moments, without assuming a process error bound. -/
theorem textbookLangevinPeriodicC2ObservableTaylorRemainder_norm_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f T x sample‖ ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, hC, hc⟩ := textbookLangevinPeriodicRealPhaseIncrement_norm_even_moment_bound
    B P hB U hU hp L hF γ σ hγ x 1 le_rfl
  obtain ⟨D, hD, hd⟩ := textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_moment_bound
    B P hB U hU hp L hF γ σ hγ x
  apply Metric.tendsto_nhds.mpr
  intro ε hε
  let e := ε / (2 * (C + 1))
  have he : 0 < e := div_pos hε (by positivity)
  obtain ⟨K, hK, hb⟩ := textbookLangevinC2ObservableTaylorRemainder_quartic_pointwise_bound
    f hf M hM hH (textbookLangevinPeriodicRepresentative x.1, x.2) e he
  have hden : 0 < 2 * (K * D + 1) := by positivity
  filter_upwards [self_mem_nhdsWithin,
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1)),
    nhdsWithin_le_nhds (Iio_mem_nhds (div_pos hε hden))] with t ht ht1 hts
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have hts' : t < ε / (2 * (K * D + 1)) := hts
  have hi2 : Integrable (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 2) P := by
    simpa using textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x 1 le_rfl
  have hi4 := textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_integrable
    B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x
  have hr := textbookLangevinPeriodicC2ObservableTaylorRemainder_integrable
    B P hB U hU hp L hF γ σ f hf M hH hγ t ht0.le ht1'.le x
  have hn : (∫ sample, ‖textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f t x sample‖ ∂P) ≤
      e * (C * t) + K * (D * t ^ 2) := by
    calc
      _ ≤ ∫ sample, e * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 2 +
          K * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 4 ∂P := by
        apply integral_mono hr.norm ((hi2.const_mul e).add (hi4.const_mul K))
        intro sample
        exact hb _
      _ = e * (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 2 ∂P) +
          K * (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 4 ∂P) := by
        rw [integral_add (hi2.const_mul e) (hi4.const_mul K), integral_const_mul, integral_const_mul]
      _ ≤ _ := add_le_add
        (mul_le_mul_of_nonneg_left (by simpa using hc t ht0.le ht1'.le) he.le)
        (mul_le_mul_of_nonneg_left (hd t ht0.le ht1'.le) hK)
  have hquot : (∫ sample, ‖textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f t x sample‖ ∂P) / t ≤
      e * C + K * D * t := (div_le_iff₀ ht0).mpr (by nlinarith [hn])
  have heC : e * C ≤ ε / 2 := by
    calc
      _ ≤ e * (C + 1) := mul_le_mul_of_nonneg_left (by linarith) he.le
      _ = _ := by dsimp only [e]; field_simp
  have hKD : K * D * t < ε / 2 := by
    have h := (lt_div_iff₀ hden).mp hts'
    nlinarith
  have hnonneg : 0 ≤ (∫ sample,
      ‖textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f t x sample‖ ∂P) / t :=
    div_nonneg (integral_nonneg (fun _ ↦ norm_nonneg _)) ht0.le
  rw [dist_eq_norm, sub_zero, Real.norm_of_nonneg hnonneg]
  exact hquot.trans_lt (by linarith)

include hB hU hp hf hM hH in
/-- The signed actual C2 remainder expectation has the same true zero
small-time quotient, by the proved expected norm estimate. -/
theorem textbookLangevinPeriodicC2ObservableTaylorRemainder_mean_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f T x sample ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  have hb : ∀ᶠ t : ℝ in 𝓝[>] 0,
      ‖(∫ sample, textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f t x sample ∂P) / t‖ ≤
        (∫ sample, ‖textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f t x sample‖ ∂P) / t := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    rw [norm_div, Real.norm_of_nonneg ht.le]
    exact (div_le_div_iff_of_pos_right ht).mpr (norm_integral_le_integral_norm _)
  exact squeeze_zero_norm' hb
    (textbookLangevinPeriodicC2ObservableTaylorRemainder_norm_div_time_tendsto_zero
      B P hB U hU hp L hF γ σ f hf M hM hH hγ x)

end
end MolecularDynamics
