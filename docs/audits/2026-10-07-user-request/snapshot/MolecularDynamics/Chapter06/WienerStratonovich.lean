import MolecularDynamics.Chapter06.WienerIntegration

/-! Printed230/PDF251: the actual temporal midpoint sum for the self-Stratonovich integral.
Independent half-interval increments control the real midpoint correction in mean square.
-/

open MeasureTheory ProbabilityTheory Filter
open scoped NNReal ENNReal Topology ProbabilityTheory

namespace MolecularDynamics

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}

private def midpointSign (j : ℕ) : ℝ := if j % 2 = 0 then 1 else -1

private theorem midpointSign_even (k : ℕ) : midpointSign (2 * k) = 1 := by
  simp [midpointSign]

private theorem midpointSign_odd (k : ℕ) : midpointSign (2 * k + 1) = -1 := by
  simp [midpointSign, Nat.add_mod]

private theorem midpointSign_sq (j : ℕ) : midpointSign j ^ 2 = 1 := by
  unfold midpointSign
  split <;> norm_num

private theorem midpointSign_sum (K : ℕ) : (∑ j : Fin (2 * K), midpointSign j.val) = 0 := by
  have hs : ∑ j ∈ Finset.range (2 * K), midpointSign j = 0 := by
    induction K with
    | zero => simp
    | succ K ih =>
      rw [show 2 * (K + 1) = 2 * K + 1 + 1 by omega,
        Finset.sum_range_succ, Finset.sum_range_succ, ih]
      rw [midpointSign_even, midpointSign_odd]
      ring
  rw [Finset.sum_range] at hs
  exact hs

private theorem midpoint_discrete_identity (v : ℕ → ℝ) (K : ℕ) :
    2 * (∑ k ∈ Finset.range K, v (2 * k + 1) * (v (2 * k + 2) - v (2 * k))) =
      v (2 * K) ^ 2 - v 0 ^ 2 +
        ∑ j ∈ Finset.range (2 * K), midpointSign j * (v (j + 1) - v j) ^ 2 := by
  induction K with
  | zero => simp
  | succ K ih =>
    rw [Finset.sum_range_succ, show 2 * (K + 1) = 2 * K + 1 + 1 by omega,
      Finset.sum_range_succ, Finset.sum_range_succ, midpointSign_even, midpointSign_odd]
    nlinarith [ih]

private theorem midpoint_coarse_time (T : ℝ≥0) {K : ℕ} (hK : 0 < K) (k : ℕ) :
    textbookWienerTime T K k = textbookWienerTime T (2 * K) (2 * k) := by
  apply NNReal.coe_injective
  simp only [textbookWienerTime, NNReal.coe_mul, NNReal.coe_div, NNReal.coe_natCast,
    Nat.cast_mul, Nat.cast_ofNat]
  have hn : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
  field_simp

/-- Genuine temporal midpoint evaluations multiplied by actual coarse Brownian increments. -/
noncomputable def textbookWienerMidpointSum (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) ω *
    textbookWienerIncrement W T K k ω

/-- The actual alternating squared half-interval increments in the midpoint error. -/
noncomputable def textbookWienerMidpointCorrection (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ j : Fin (2 * K), midpointSign j.val * textbookWienerIncrement W T (2 * K) j ω ^ 2

theorem textbookWienerMidpointCorrection_memLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    MemLp (textbookWienerMidpointCorrection W T K) 2 P :=
  memLp_finsetSum _ (fun j _ ↦
    (textbookCenteredGaussian_square_memLp (textbookWienerIncrement_hasLaw hW T (2 * K) j)).const_mul _)

theorem textbookWienerMidpointCorrection_integral {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    (∫ ω, textbookWienerMidpointCorrection W T K ω ∂P) = 0 := by
  have := hW.isGaussianProcess.isProbabilityMeasure
  unfold textbookWienerMidpointCorrection
  rw [integral_finsetSum _ (fun j _ ↦
    ((textbookCenteredGaussian_square_memLp (textbookWienerIncrement_hasLaw hW T (2 * K) j)).integrable
      (by norm_num)).const_mul _)]
  simp only [integral_const_mul,
    textbookCenteredGaussian_secondMoment (textbookWienerIncrement_hasLaw hW T (2 * K) _)]
  rw [← Finset.sum_mul, midpointSign_sum, zero_mul]

theorem textbookWienerMidpointCorrection_variance {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    variance (textbookWienerMidpointCorrection W T K) P = (T : ℝ) ^ 2 / (K : ℝ) := by
  let V : Fin (2 * K) → Ω → ℝ :=
    fun j ω ↦ midpointSign j.val * textbookWienerIncrement W T (2 * K) j ω ^ 2
  have hv (j : Fin (2 * K)) : MemLp (V j) 2 P :=
    (textbookCenteredGaussian_square_memLp (textbookWienerIncrement_hasLaw hW T (2 * K) j)).const_mul _
  have hi : iIndepFun V P := (textbookWienerIncrement_independent hW T (2 * K)).comp
    (fun (j : Fin (2 * K)) (x : ℝ) ↦ midpointSign j.val * x ^ 2) (fun _ ↦ by fun_prop)
  have hvar (j : Fin (2 * K)) : variance (V j) P =
      2 * ((T / ((2 * K : ℕ) : ℝ≥0) : ℝ≥0) : ℝ) ^ 2 := by
    rw [variance_const_mul, midpointSign_sq,
      textbookCenteredGaussian_square_variance (textbookWienerIncrement_hasLaw hW T (2 * K) j), one_mul]
  have hs : variance (∑ j : Fin (2 * K), V j) P = ∑ j : Fin (2 * K), variance (V j) P :=
    IndepFun.variance_sum (fun j _ ↦ hv j) (fun _ _ _ _ hij ↦ hi.indepFun hij)
  have he : textbookWienerMidpointCorrection W T K = ∑ j : Fin (2 * K), V j := by
    funext ω
    simp only [textbookWienerMidpointCorrection, Finset.sum_apply, V]
  rw [he, hs]
  simp only [hvar, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  push_cast
  have hn : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
  field_simp

theorem textbookWienerMidpointSum_identity {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ ω ∂P, 2 * textbookWienerMidpointSum W T K ω =
      W T ω ^ 2 + textbookWienerMidpointCorrection W T K ω := by
  have htime : textbookWienerTime T (2 * K) (2 * K) = T := by
    unfold textbookWienerTime
    have hn : (2 * K : ℝ≥0) ≠ 0 := by positivity
    field_simp
  have htime0 : textbookWienerTime T (2 * K) 0 = 0 := by simp [textbookWienerTime]
  filter_upwards [hW.eval_zero_ae_eq_zero] with ω h0
  have h := midpoint_discrete_identity (fun j ↦ W (textbookWienerTime T (2 * K) j) ω) K
  rw [htime, htime0, h0] at h
  rw [Finset.sum_range, Finset.sum_range] at h
  simpa only [textbookWienerMidpointSum, textbookWienerMidpointCorrection, textbookWienerIncrement,
    midpoint_coarse_time T hK, Nat.mul_add, Nat.mul_one, zero_pow (by norm_num : (2 : ℕ) ≠ 0),
    sub_zero] using h

theorem textbookWienerMidpointLimit_memLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun ω ↦ W T ω ^ 2 / 2) 2 P := by
  simpa only [div_eq_mul_inv] using
    (textbookCenteredGaussian_square_memLp (hW.hasLaw_eval T)).mul_const (2 : ℝ)⁻¹

theorem textbookWienerMidpointSum_memLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P := by
  have hm := (textbookCenteredGaussian_square_memLp (hW.hasLaw_eval T)).add
    (textbookWienerMidpointCorrection_memLp hW T K)
  have he : (fun ω ↦ (W T ω ^ 2 + textbookWienerMidpointCorrection W T K ω) * (2 : ℝ)⁻¹)
      =ᵐ[P] textbookWienerMidpointSum W T K := by
    filter_upwards [textbookWienerMidpointSum_identity hW T hK] with ω hω
    linarith
  exact (memLp_congr_ae he).mp (hm.mul_const (2 : ℝ)⁻¹)

/-- The true midpoint correction has the exact mean-square error T²/(4K). -/
theorem textbookWienerMidpointSum_meanSquareError {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ ω, (textbookWienerMidpointSum W T K ω - W T ω ^ 2 / 2) ^ 2 ∂P) =
      ((T : ℝ) ^ 2 / 4) / (K : ℝ) := by
  have he : ∀ᵐ ω ∂P, (textbookWienerMidpointSum W T K ω - W T ω ^ 2 / 2) ^ 2 =
      (1 / 4 : ℝ) * textbookWienerMidpointCorrection W T K ω ^ 2 := by
    filter_upwards [textbookWienerMidpointSum_identity hW T hK] with ω hω
    have hs : textbookWienerMidpointSum W T K ω =
        (W T ω ^ 2 + textbookWienerMidpointCorrection W T K ω) / 2 := by linarith
    rw [hs]
    ring
  have hv := variance_eq_integral
    (textbookWienerMidpointCorrection_memLp hW T K).aestronglyMeasurable.aemeasurable
  rw [textbookWienerMidpointCorrection_integral hW T K] at hv
  simp only [sub_zero] at hv
  rw [integral_congr_ae he, integral_const_mul, ← hv, textbookWienerMidpointCorrection_variance hW T hK]
  ring

theorem textbookWienerMidpointSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerMidpointSum W T K ω - W T ω ^ 2 / 2) ^ 2 ∂P)
      atTop (𝓝 0) := by
  apply (tendsto_const_div_atTop_nhds_zero_nat ((T : ℝ) ^ 2 / 4)).congr'
  filter_upwards [eventually_gt_atTop 0] with K hK
  exact (textbookWienerMidpointSum_meanSquareError hW T hK).symm

theorem textbookWienerSelfStratonovichIntegral_exists {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerMidpointSum W T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ ω ∂P, Y ω = W T ω ^ 2 / 2 :=
  ⟨fun ω ↦ W T ω ^ 2 / 2, textbookWienerMidpointLimit_memLp hW T,
    textbookWienerMidpointSum_meanSquare_tendsto hW T, Filter.Eventually.of_forall (fun _ ↦ rfl)⟩

end MolecularDynamics
