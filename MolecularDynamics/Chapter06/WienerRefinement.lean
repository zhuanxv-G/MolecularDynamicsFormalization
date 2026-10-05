import MolecularDynamics.Chapter06.WienerIntegration
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.MeasureTheory.Function.LpSpace.Complete
import Mathlib.Analysis.Calculus.ContDiff.Deriv
import Mathlib.Analysis.Calculus.MeanValue

/-! Genuine common refinements needed to construct the deterministic integral of Proposition 6.3. -/

open MeasureTheory ProbabilityTheory Filter
open scoped NNReal ENNReal Topology ProbabilityTheory

namespace MolecularDynamics

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}

private theorem sum_range_blocks (f : ℕ → ℝ) (K L : ℕ) :
    (∑ j ∈ Finset.range (K * L), f j) =
      ∑ k ∈ Finset.range K, ∑ r ∈ Finset.range L, f (k * L + r) := by
  induction K with
  | zero => simp
  | succ K ih =>
    rw [Nat.succ_mul, Finset.sum_range_add, ih, Finset.sum_range_succ]

private theorem refinement_time (T : ℝ≥0) {K L : ℕ} (hK : 0 < K) (hL : 0 < L)
    (k : ℕ) : textbookWienerTime T (K * L) (k * L) = textbookWienerTime T K k := by
  apply NNReal.coe_injective
  simp only [textbookWienerTime, NNReal.coe_mul, NNReal.coe_div, NNReal.coe_natCast,
    Nat.cast_mul]
  have hnK : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
  have hnL : (L : ℝ) ≠ 0 := by exact_mod_cast hL.ne'
  field_simp

omit [MeasurableSpace Ω] in
/-- An actual coarse deterministic Wiener sum equals its genuine uniformly refined sum. -/
theorem textbookWienerWeightedSum_refine (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0)
    {K L : ℕ} (hK : 0 < K) (hL : 0 < L) (a : ℕ → ℝ) :
    textbookWienerWeightedSum W T K (fun k ↦ a k.val) =
      textbookWienerWeightedSum W T (K * L) (fun j ↦ a (j.val / L)) := by
  funext ω
  let v (j : ℕ) := W (textbookWienerTime T (K * L) j) ω
  have hb (k : ℕ) :
      (∑ r ∈ Finset.range L, a ((k * L + r) / L) *
        (v (k * L + r + 1) - v (k * L + r))) =
      a k * (v ((k + 1) * L) - v (k * L)) := by
    have he (r : ℕ) (hr : r ∈ Finset.range L) : (k * L + r) / L = k := by
      rw [Nat.mul_comm k L, Nat.mul_add_div hL,
        Nat.div_eq_of_lt (Finset.mem_range.mp hr), add_zero]
    calc
      _ = a k * ∑ r ∈ Finset.range L, (v (k * L + r + 1) - v (k * L + r)) := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl (fun r hr ↦ by rw [he r hr])
      _ = _ := by
        have hs := Finset.sum_range_sub (fun r ↦ v (k * L + r)) L
        simp only [Nat.add_zero] at hs
        simpa only [Nat.add_assoc, Nat.add_mul, Nat.one_mul] using congrArg (a k * ·) hs
  have hs := sum_range_blocks
    (fun j ↦ a (j / L) * (v (j + 1) - v j)) K L
  simp only [hb] at hs
  simp only [v, refinement_time T hK hL] at hs
  rw [Finset.sum_range, Finset.sum_range] at hs
  exact hs.symm

/-- True common-grid L² isometry, with no independence premise supplied for the two coarse sums. -/
theorem textbookWienerWeightedSum_twoGrid_secondMoment {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K L : ℕ} (hK : 0 < K) (hL : 0 < L)
    (a b : ℕ → ℝ) :
    (∫ ω, (textbookWienerWeightedSum W T K (fun k ↦ a k.val) ω -
      textbookWienerWeightedSum W T L (fun k ↦ b k.val) ω) ^ 2 ∂P) =
      ∑ j : Fin (K * L), (a (j.val / L) - b (j.val / K)) ^ 2 *
        ((T / ((K * L : ℕ) : ℝ≥0) : ℝ≥0) : ℝ) := by
  have hb : textbookWienerWeightedSum W T L (fun k ↦ b k.val) =
      textbookWienerWeightedSum W T (K * L) (fun j ↦ b (j.val / K)) := by
    have h := textbookWienerWeightedSum_refine W T hL hK b
    rw [Nat.mul_comm L K] at h
    exact h
  rw [textbookWienerWeightedSum_refine W T hK hL a, hb]
  exact textbookWienerWeightedSum_difference_secondMoment hW T (K * L) _ _

/-- The genuine left-endpoint sum for a deterministic real-time integrand. -/
noncomputable def textbookWienerDeterministicSum (W : ℝ≥0 → Ω → ℝ) (g : ℝ → ℝ)
    (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  textbookWienerWeightedSum W T K (fun k ↦ g (textbookWienerTime T K k.val))

theorem textbookWienerDeterministicSum_memLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (g : ℝ → ℝ) (T : ℝ≥0) (K : ℕ) :
    MemLp (textbookWienerDeterministicSum W g T K) 2 P :=
  (textbookWienerWeightedSum_hasGaussianLaw hW T K _).memLp_two

private theorem wienerTime_coe (T : ℝ≥0) (K k : ℕ) :
    (textbookWienerTime T K k : ℝ) = (k : ℝ) * (T : ℝ) / (K : ℝ) := by
  simp only [textbookWienerTime, NNReal.coe_mul, NNReal.coe_div, NNReal.coe_natCast]
  ring

private theorem wienerTime_mono (T : ℝ≥0) (K : ℕ) : Monotone (textbookWienerTime T K) := by
  intro k l hkl
  exact mul_le_mul_of_nonneg_right (by exact_mod_cast hkl) (by positivity)

theorem textbookWienerTime_mem_Icc (T : ℝ≥0) {K : ℕ} (hK : 0 < K)
    {k : ℕ} (hk : k ≤ K) : (textbookWienerTime T K k : ℝ) ∈ Set.Icc 0 (T : ℝ) := by
  refine ⟨NNReal.coe_nonneg _, ?_⟩
  rw [wienerTime_coe]
  have hKr : (0 : ℝ) < K := by exact_mod_cast hK
  apply (div_le_iff₀ hKr).2
  have hkr : (k : ℝ) ≤ K := by exact_mod_cast hk
  nlinarith [mul_le_mul_of_nonneg_right hkr T.coe_nonneg]

private theorem floor_time_dist_le (T : ℝ≥0) {K L : ℕ} (hK : 0 < K) (hL : 0 < L)
    (j : ℕ) :
    dist (textbookWienerTime T K (j / L) : ℝ) (textbookWienerTime T (K * L) j : ℝ) ≤
      (T : ℝ) / (K : ℝ) := by
  have hlo : j / L * L ≤ j := Nat.div_mul_le_self _ _
  have hhi : j ≤ (j / L + 1) * L := by
    have := Nat.mod_lt j hL
    have he := Nat.div_add_mod j L
    rw [Nat.mul_comm L (j / L)] at he
    rw [Nat.add_mul, Nat.one_mul]
    omega
  have hl := wienerTime_mono T (K * L) hlo
  have hh := wienerTime_mono T (K * L) hhi
  rw [refinement_time T hK hL] at hl hh
  have hlr : (textbookWienerTime T K (j / L) : ℝ) ≤
      (textbookWienerTime T (K * L) j : ℝ) := by exact_mod_cast hl
  have hhr : (textbookWienerTime T (K * L) j : ℝ) ≤
      (textbookWienerTime T K (j / L + 1) : ℝ) := by exact_mod_cast hh
  rw [Real.dist_eq, abs_sub_comm, abs_of_nonneg (sub_nonneg.mpr hlr)]
  calc
    _ ≤ (textbookWienerTime T K (j / L + 1) : ℝ) -
        (textbookWienerTime T K (j / L) : ℝ) := sub_le_sub_right hhr _
    _ = _ := by rw [wienerTime_coe, wienerTime_coe]; push_cast; ring

/-- A genuine two-grid mean-square bound from the integrand's Lipschitz condition on [0,T]. -/
theorem textbookWienerDeterministicSum_twoGrid_meanSquare_le {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (T : ℝ≥0) {M : ℝ≥0}
    (hg : LipschitzOnWith M g (Set.Icc 0 (T : ℝ))) {K L : ℕ} (hK : 0 < K) (hL : 0 < L) :
    (∫ ω, (textbookWienerDeterministicSum W g T K ω -
      textbookWienerDeterministicSum W g T L ω) ^ 2 ∂P) ≤
      (M : ℝ) ^ 2 * (T : ℝ) * ((T : ℝ) / (K : ℝ) + (T : ℝ) / (L : ℝ)) ^ 2 := by
  unfold textbookWienerDeterministicSum
  rw [textbookWienerWeightedSum_twoGrid_secondMoment hW T hK hL
    (fun k ↦ g (textbookWienerTime T K k)) (fun k ↦ g (textbookWienerTime T L k))]
  let B : ℝ := (M : ℝ) * ((T : ℝ) / (K : ℝ) + (T : ℝ) / (L : ℝ))
  have hB : 0 ≤ B := by dsimp [B]; positivity
  have hsq (j : Fin (K * L)) :
      (g (textbookWienerTime T K (j.val / L)) -
        g (textbookWienerTime T L (j.val / K))) ^ 2 ≤ B ^ 2 := by
    have hk : j.val / L < K := (Nat.div_lt_iff_lt_mul hL).2 j.isLt
    have hl : j.val / K < L := by
      apply (Nat.div_lt_iff_lt_mul hK).2
      simpa only [Nat.mul_comm L K] using j.isLt
    have hx := textbookWienerTime_mem_Icc T hK hk.le
    have hy := textbookWienerTime_mem_Icc T hL hl.le
    have hd1 := floor_time_dist_le T hK hL j.val
    have hd2 := floor_time_dist_le T hL hK j.val
    rw [Nat.mul_comm L K, dist_comm] at hd2
    have hd : dist (textbookWienerTime T K (j.val / L) : ℝ)
        (textbookWienerTime T L (j.val / K) : ℝ) ≤
        (T : ℝ) / (K : ℝ) + (T : ℝ) / (L : ℝ) :=
      (dist_triangle _ (textbookWienerTime T (K * L) j.val : ℝ) _).trans (add_le_add hd1 hd2)
    have hb : |g (textbookWienerTime T K (j.val / L)) -
        g (textbookWienerTime T L (j.val / K))| ≤ B := by
      exact (hg.dist_le_mul _ hx _ hy).trans (mul_le_mul_of_nonneg_left hd M.coe_nonneg)
    simpa only [sq_abs] using (sq_le_sq₀ (abs_nonneg _) hB).2 hb
  calc
    _ ≤ ∑ j : Fin (K * L), B ^ 2 *
        ((T / ((K * L : ℕ) : ℝ≥0) : ℝ≥0) : ℝ) :=
      Finset.sum_le_sum (fun j _ ↦ mul_le_mul_of_nonneg_right (hsq j) (by positivity))
    _ = _ := by
      simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
      push_cast
      have hnK : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
      have hnL : (L : ℝ) ≠ 0 := by exact_mod_cast hL.ne'
      dsimp [B]
      field_simp

private theorem lp_dist_sq_of_ae {x y : Lp ℝ 2 P} {f g : Ω → ℝ}
    (hx : ⇑x =ᵐ[P] f) (hy : ⇑y =ᵐ[P] g) :
    dist x y ^ 2 = ∫ ω, (f ω - g ω) ^ 2 ∂P := by
  rw [dist_eq_norm, ← real_inner_self_eq_norm_sq]
  change (∫ ω, inner ℝ ((x - y) ω) ((x - y) ω) ∂P) = _
  apply integral_congr_ae
  filter_upwards [Lp.coeFn_sub x y, hx, hy] with ω hxy hfx hgy
  simp only [Pi.sub_apply] at hxy
  rw [hxy, hfx, hgy]
  simp

/-- The actual finite sums represented in the complete real L² space. -/
noncomputable def textbookWienerDeterministicLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (g : ℝ → ℝ) (T : ℝ≥0) (K : ℕ) : Lp ℝ 2 P :=
  (textbookWienerDeterministicSum_memLp hW g T K).toLp (textbookWienerDeterministicSum W g T K)

theorem textbookWienerDeterministicLp_dist_le {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (T : ℝ≥0) {M : ℝ≥0}
    (hg : LipschitzOnWith M g (Set.Icc 0 (T : ℝ))) {K L : ℕ} (hK : 0 < K) (hL : 0 < L) :
    dist (textbookWienerDeterministicLp hW g T K) (textbookWienerDeterministicLp hW g T L) ≤
      (M : ℝ) * Real.sqrt T * ((T : ℝ) / (K : ℝ) + (T : ℝ) / (L : ℝ)) := by
  apply le_of_sq_le_sq _ (by positivity)
  unfold textbookWienerDeterministicLp
  rw [lp_dist_sq_of_ae (textbookWienerDeterministicSum_memLp hW g T K).coeFn_toLp
    (textbookWienerDeterministicSum_memLp hW g T L).coeFn_toLp]
  convert textbookWienerDeterministicSum_twoGrid_meanSquare_le hW T hg hK hL using 1
  rw [mul_pow, mul_pow, Real.sq_sqrt T.coe_nonneg]

/-- Actual Cauchy convergence is derived from the common-grid Brownian isometry. -/
theorem textbookWienerDeterministicLp_cauchySeq {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (T : ℝ≥0) {M : ℝ≥0}
    (hg : LipschitzOnWith M g (Set.Icc 0 (T : ℝ))) :
    CauchySeq (textbookWienerDeterministicLp hW g T) := by
  let C : ℝ := (M : ℝ) * Real.sqrt T
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hb : Tendsto (fun N : ℕ ↦ 2 * C * ((T : ℝ) / (N : ℝ))) atTop (𝓝 0) := by
    simpa only [mul_zero] using (tendsto_const_div_atTop_nhds_zero_nat (T : ℝ)).const_mul (2 * C)
  apply Metric.cauchySeq_iff.mpr
  intro ε hε
  obtain ⟨N, hN⟩ := eventually_atTop.mp
    ((hb.eventually_lt_const hε).and (eventually_gt_atTop 0))
  have hNp : 0 < N := (hN N le_rfl).2
  refine ⟨N, fun n hn m hm ↦ ?_⟩
  have hnp : 0 < n := lt_of_lt_of_le hNp hn
  have hmp : 0 < m := lt_of_lt_of_le hNp hm
  have hNr : (0 : ℝ) < N := by exact_mod_cast hNp
  have hnr : (N : ℝ) ≤ n := by exact_mod_cast hn
  have hmr : (N : ℝ) ≤ m := by exact_mod_cast hm
  have dn := div_le_div_of_nonneg_left T.coe_nonneg hNr hnr
  have dm := div_le_div_of_nonneg_left T.coe_nonneg hNr hmr
  calc
    _ ≤ C * ((T : ℝ) / (n : ℝ) + (T : ℝ) / (m : ℝ)) :=
      textbookWienerDeterministicLp_dist_le hW T hg hnp hmp
    _ ≤ C * ((T : ℝ) / (N : ℝ) + (T : ℝ) / (N : ℝ)) :=
      mul_le_mul_of_nonneg_left (add_le_add dn dm) hC
    _ = 2 * C * ((T : ℝ) / (N : ℝ)) := by ring
    _ < ε := (hN N le_rfl).1

/-- Completeness constructs a real L² limit of the genuine deterministic sums. -/
theorem textbookWienerDeterministicIntegral_exists_of_lipschitz {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (T : ℝ≥0) {M : ℝ≥0}
    (hg : LipschitzOnWith M g (Set.Icc 0 (T : ℝ))) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) := by
  obtain ⟨Y, hY⟩ := cauchySeq_tendsto_of_complete (textbookWienerDeterministicLp_cauchySeq hW T hg)
  refine ⟨Y, Lp.memLp Y, ?_⟩
  have hd : Tendsto (fun K : ℕ ↦ dist (textbookWienerDeterministicLp hW g T K) Y ^ 2)
      atTop (𝓝 0) := by
    simpa only [dist_self, zero_pow (by norm_num : (2 : ℕ) ≠ 0)] using
      (hY.dist (tendsto_const_nhds : Tendsto (fun _ : ℕ ↦ Y) atTop (𝓝 Y))).pow 2
  apply hd.congr'
  exact Filter.Eventually.of_forall (fun K ↦ lp_dist_sq_of_ae
    (textbookWienerDeterministicSum_memLp hW g T K).coeFn_toLp Filter.EventuallyEq.rfl)

private theorem integrand_lipschitz_of_contDiff {g : ℝ → ℝ}
    (hg : ContDiff ℝ 1 g) (T : ℝ≥0) : ∃ M, LipschitzOnWith M g (Set.Icc 0 (T : ℝ)) := by
  have hc := (isCompact_Icc : IsCompact (Set.Icc (0 : ℝ) T)).image_of_continuousOn
    hg.continuous_deriv_one.nnnorm.continuousOn
  obtain ⟨M, hM⟩ := hc.bddAbove
  refine ⟨M, Convex.lipschitzOnWith_of_nnnorm_deriv_le
    (fun x _ ↦ (hg.differentiable (by norm_num)) x) (fun x hx ↦ hM ⟨x, hx, rfl⟩) (convex_Icc _ _)⟩

/-- In particular every smooth deterministic textbook integrand has an actual mean-square integral. -/
theorem textbookWienerDeterministicIntegral_exists {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) := by
  obtain ⟨M, hM⟩ := integrand_lipschitz_of_contDiff hg T
  exact textbookWienerDeterministicIntegral_exists_of_lipschitz hW T hM

end MolecularDynamics
