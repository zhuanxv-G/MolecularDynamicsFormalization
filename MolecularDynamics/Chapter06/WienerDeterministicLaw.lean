import MolecularDynamics.Chapter06.WienerRefinement
import Mathlib.MeasureTheory.Measure.LevyConvergence
import Mathlib.MeasureTheory.Function.ConvergenceInMeasure

/-! The real integral variance and Gaussian limiting law required by Proposition 6.3. -/

open MeasureTheory ProbabilityTheory Filter
open scoped NNReal ENNReal Topology ProbabilityTheory

namespace MolecularDynamics

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}

private theorem compact_integrand_lipschitz {g : ℝ → ℝ}
    (hg : ContDiff ℝ 1 g) (T : ℝ≥0) : ∃ M, LipschitzOnWith M g (Set.Icc 0 (T : ℝ)) := by
  have hc := (isCompact_Icc : IsCompact (Set.Icc (0 : ℝ) T)).image_of_continuousOn
    hg.continuous_deriv_one.nnnorm.continuousOn
  obtain ⟨M, hM⟩ := hc.bddAbove
  exact ⟨M, Convex.lipschitzOnWith_of_nnnorm_deriv_le
    (fun x _ ↦ (hg.differentiable (by norm_num)) x)
    (fun x hx ↦ hM ⟨x, hx, rfl⟩) (convex_Icc _ _)⟩

private theorem uniform_left_sum_error {f : ℝ → ℝ} (hf : Continuous f)
    (T : ℝ≥0) {C : ℝ≥0} (hC : LipschitzOnWith C f (Set.Icc 0 (T : ℝ)))
    {K : ℕ} (hK : 0 < K) :
    |(∑ k : Fin K, f ((k.val : ℝ) * ((T : ℝ) / (K : ℝ))) * ((T : ℝ) / (K : ℝ))) -
      ∫ x in (0 : ℝ)..T, f x| ≤ (C : ℝ) * (T : ℝ) ^ 2 / (K : ℝ) := by
  let δ : ℝ := (T : ℝ) / (K : ℝ)
  let t (k : ℕ) : ℝ := (k : ℝ) * δ
  have hδ : 0 ≤ δ := by dsimp [δ]; positivity
  have hKr : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
  have ht0 : t 0 = 0 := by simp [t]
  have htK : t K = T := by dsimp [t, δ]; field_simp
  have ht : Monotone t := fun _ _ h ↦ mul_le_mul_of_nonneg_right (by exact_mod_cast h) hδ
  have hstep (k : ℕ) : t (k + 1) - t k = δ := by dsimp [t]; push_cast; ring
  have hdom (k : ℕ) (hk : k ≤ K) : t k ∈ Set.Icc 0 (T : ℝ) :=
    ⟨by dsimp [t]; positivity, (ht hk).trans_eq htK⟩
  have hs : (∑ k ∈ Finset.range K, ∫ x in t k..t (k + 1), f x) =
      ∫ x in (0 : ℝ)..T, f x := by
    rw [intervalIntegral.sum_integral_adjacent_intervals (fun _ _ ↦ hf.intervalIntegrable _ _),
      ht0, htK]
  have hb (k : ℕ) (hk : k ∈ Finset.range K) :
      |f (t k) * δ - ∫ x in t k..t (k + 1), f x| ≤ (C : ℝ) * δ ^ 2 := by
    have hkp : k < K := Finset.mem_range.mp hk
    have hab : t k ≤ t (k + 1) := ht (by omega)
    have he : f (t k) * δ - (∫ x in t k..t (k + 1), f x) =
        ∫ x in t k..t (k + 1), (f (t k) - f x) := by
      rw [intervalIntegral.integral_sub intervalIntegrable_const (hf.intervalIntegrable _ _),
        intervalIntegral.integral_const, smul_eq_mul, hstep]
      ring
    have hbound (x : ℝ) (hx : x ∈ Set.uIoc (t k) (t (k + 1))) :
        ‖f (t k) - f x‖ ≤ (C : ℝ) * δ := by
      rw [Set.uIoc_of_le hab] at hx
      have hxT : x ∈ Set.Icc 0 (T : ℝ) :=
        ⟨(hdom k hkp.le).1.trans hx.1.le, hx.2.trans (hdom (k + 1) (by omega)).2⟩
      have hd : dist (t k) x ≤ δ := by
        rw [Real.dist_eq, abs_sub_comm, abs_of_nonneg (sub_nonneg.mpr hx.1.le)]
        linarith [hstep k, hx.2]
      simpa only [Real.norm_eq_abs, ← Real.dist_eq] using
        (hC.dist_le_mul _ (hdom k hkp.le) _ hxT).trans
          (mul_le_mul_of_nonneg_left hd C.coe_nonneg)
    rw [he, ← Real.norm_eq_abs]
    calc
      _ ≤ (C : ℝ) * δ * |t (k + 1) - t k| :=
        intervalIntegral.norm_integral_le_of_norm_le_const hbound
      _ = _ := by rw [hstep, abs_of_nonneg hδ]; ring
  have he : (∑ k : Fin K, f ((k.val : ℝ) * ((T : ℝ) / (K : ℝ))) * ((T : ℝ) / (K : ℝ))) =
      ∑ k ∈ Finset.range K, f (t k) * δ := by rw [Finset.sum_range]
  rw [he]
  calc
    _ = |∑ k ∈ Finset.range K, (f (t k) * δ - ∫ x in t k..t (k + 1), f x)| := by
      rw [Finset.sum_sub_distrib, hs]
    _ ≤ ∑ k ∈ Finset.range K, |f (t k) * δ - ∫ x in t k..t (k + 1), f x| := by
      simpa only [Real.norm_eq_abs] using norm_sum_le (Finset.range K)
        (fun k ↦ f (t k) * δ - ∫ x in t k..t (k + 1), f x)
    _ ≤ ∑ _k ∈ Finset.range K, (C : ℝ) * δ ^ 2 := Finset.sum_le_sum hb
    _ = _ := by simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]; dsimp [δ]; field_simp

/-- The actual variance integral, represented as the nonnegative variance parameter. -/
noncomputable def textbookWienerDeterministicVariance (g : ℝ → ℝ) (T : ℝ≥0) : ℝ≥0 :=
  (∫ x in (0 : ℝ)..T, g x ^ 2).toNNReal

theorem textbookWienerDeterministicVariance_coe (g : ℝ → ℝ) (T : ℝ≥0) :
    (textbookWienerDeterministicVariance g T : ℝ) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  apply Real.coe_toNNReal _
  exact intervalIntegral.integral_nonneg_of_ae T.coe_nonneg
    (Filter.Eventually.of_forall (fun x ↦ sq_nonneg (g x)))

/-- The actual finite-sum variances converge to the actual time integral of g². -/
theorem textbookWienerDeterministicFiniteVariance_tendsto {g : ℝ → ℝ}
    (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦
      (textbookWienerWeightedVariance T K (fun k ↦ g (textbookWienerTime T K k.val)) : ℝ))
      atTop (𝓝 (textbookWienerDeterministicVariance g T : ℝ)) := by
  obtain ⟨C, hC⟩ := compact_integrand_lipschitz (hg.pow 2) T
  rw [textbookWienerDeterministicVariance_coe]
  apply (tendsto_iff_dist_tendsto_zero).2
  apply squeeze_zero' (Filter.Eventually.of_forall (fun _ ↦ dist_nonneg)) _
    (tendsto_const_div_atTop_nhds_zero_nat ((C : ℝ) * (T : ℝ) ^ 2))
  filter_upwards [eventually_gt_atTop 0] with K hK
  have he := uniform_left_sum_error (hg.pow 2).continuous T hC hK
  simpa only [textbookWienerWeightedVariance, NNReal.coe_sum, NNReal.coe_mul,
    Real.coe_toNNReal _ (sq_nonneg _), textbookWienerTime, NNReal.coe_div,
    NNReal.coe_natCast, Real.dist_eq] using he

private theorem integral_error_eq_lp_distance {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (g : ℝ → ℝ) (T : ℝ≥0) (K : ℕ)
    {Y : Ω → ℝ} (hY : MemLp Y 2 P) :
    (∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P) =
      dist (textbookWienerDeterministicLp hW g T K) (hY.toLp Y) ^ 2 := by
  rw [dist_eq_norm, ← real_inner_self_eq_norm_sq]
  symm
  change (∫ ω, inner ℝ ((textbookWienerDeterministicLp hW g T K - hY.toLp Y) ω)
    ((textbookWienerDeterministicLp hW g T K - hY.toLp Y) ω) ∂P) = _
  apply integral_congr_ae
  filter_upwards [Lp.coeFn_sub (textbookWienerDeterministicLp hW g T K) (hY.toLp Y),
    (textbookWienerDeterministicSum_memLp hW g T K).coeFn_toLp, hY.coeFn_toLp] with ω hs hK hYω
  simp only [Pi.sub_apply] at hs
  rw [hs]
  unfold textbookWienerDeterministicLp
  rw [hK, hYω]
  simp

/-- Every genuine L² integral limit has the computed Gaussian law. Its existence was constructed. -/
theorem textbookWienerDeterministicIntegral_hasLaw {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0)
    {Y : Ω → ℝ} (hY : MemLp Y 2 P)
    (hlim : Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P)
      atTop (𝓝 0)) : HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P := by
  have := hW.isGaussianProcess.isProbabilityMeasure
  let F := textbookWienerDeterministicLp hW g T
  let Z := hY.toLp Y
  have hs : Tendsto (fun K : ℕ ↦ dist (F K) Z ^ 2) atTop (𝓝 0) :=
    hlim.congr' (Filter.Eventually.of_forall (fun K ↦ integral_error_eq_lp_distance hW g T K hY))
  have hd : Tendsto (fun K : ℕ ↦ dist (F K) Z) atTop (𝓝 0) := by
    simpa only [Real.sqrt_sq_eq_abs, abs_of_nonneg dist_nonneg, Real.sqrt_zero] using hs.sqrt
  have hLp : Tendsto F atTop (𝓝 Z) := (tendsto_iff_dist_tendsto_zero).2 hd
  have hD := (tendstoInMeasure_of_tendsto_Lp hLp).tendstoInDistribution_of_aemeasurable
    (fun K ↦ (Lp.memLp (F K)).aestronglyMeasurable.aemeasurable)
    (Lp.memLp Z).aestronglyMeasurable.aemeasurable
  have hmap (K : ℕ) : P.map (F K : Ω → ℝ) =
      gaussianReal 0 (textbookWienerWeightedVariance T K (fun k ↦ g (textbookWienerTime T K k.val))) :=
    (Measure.map_congr (textbookWienerDeterministicSum_memLp hW g T K).coeFn_toLp).trans
      (textbookWienerWeightedSum_hasLaw hW T K _).map_eq
  have hmapZ : P.map (Z : Ω → ℝ) = P.map Y := Measure.map_congr hY.coeFn_toLp
  refine ⟨hY.aestronglyMeasurable.aemeasurable, Measure.ext_of_charFun ?_⟩
  funext t
  have hDY := hD.tendsto_charFun t
  rw [hmapZ] at hDY
  have hDY' : Tendsto (fun K : ℕ ↦ charFun
      (gaussianReal 0 (textbookWienerWeightedVariance T K (fun k ↦ g (textbookWienerTime T K k.val)))) t)
      atTop (𝓝 (charFun (P.map Y) t)) := by simpa only [hmap] using hDY
  have hc : Continuous (fun v : ℝ ↦ Complex.exp (-((v : ℂ) * (t : ℂ) ^ 2 / 2))) := by fun_prop
  have hG : Tendsto (fun K : ℕ ↦ charFun
      (gaussianReal 0 (textbookWienerWeightedVariance T K (fun k ↦ g (textbookWienerTime T K k.val)))) t)
      atTop (𝓝 (charFun (gaussianReal 0 (textbookWienerDeterministicVariance g T)) t)) := by
    simpa only [charFun_gaussianReal, Complex.ofReal_zero, mul_zero, zero_mul, zero_sub,
      Function.comp_def] using
      (hc.tendsto (textbookWienerDeterministicVariance g T : ℝ)).comp
        (textbookWienerDeterministicFiniteVariance_tendsto hg T)
  exact tendsto_nhds_unique hDY' hG

/-- Proposition 6.3, including actual construction, Gaussian law, mean and second moment. -/
theorem textbookWienerDeterministicIto_proposition63 {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ ω, Y ω ∂P) = 0 ∧ (∫ ω, Y ω ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  obtain ⟨Y, hY, hlim⟩ := textbookWienerDeterministicIntegral_exists hW hg T
  have hLaw := textbookWienerDeterministicIntegral_hasLaw hW hg T hY hlim
  refine ⟨Y, hY, hlim, hLaw, ?_, ?_⟩
  · rw [hLaw.integral_eq, integral_id_gaussianReal]
  · rw [textbookCenteredGaussian_secondMoment hLaw, textbookWienerDeterministicVariance_coe]

end MolecularDynamics
