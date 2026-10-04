import MolecularDynamics.Chapter06.WienerQuadraticVariation

/-! Actual finite Wiener integrals and the proved unnumbered integral on printed229--230.
The general smooth deterministic integral of Proposition 6.3 requires a separate limit construction.
-/

open MeasureTheory ProbabilityTheory Filter
open scoped NNReal ENNReal Topology ProbabilityTheory

namespace MolecularDynamics

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}

/-- A genuine finite stochastic sum with deterministic coefficients. -/
noncomputable def textbookWienerWeightedSum (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ)
    (a : Fin K → ℝ) : Ω → ℝ :=
  fun ω ↦ ∑ k, a k * textbookWienerIncrement W T K k ω

/-- The actual deterministic squared-coefficient sum times the interval length. -/
noncomputable def textbookWienerWeightedVariance (T : ℝ≥0) (K : ℕ) (a : Fin K → ℝ) : ℝ≥0 :=
  ∑ k, (a k ^ 2).toNNReal * (T / (K : ℝ≥0))

theorem textbookWienerWeightedSum_hasGaussianLaw {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (a : Fin K → ℝ) :
    HasGaussianLaw (textbookWienerWeightedSum W T K a) P := by
  let L : (Fin K → ℝ) →L[ℝ] ℝ :=
    { toFun x := ∑ k, a k * x k
      map_add' x y := by simp [mul_add, Finset.sum_add_distrib]
      map_smul' c x := by
        simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro k _
        ring }
  have hg := hW.isGaussianProcess.hasGaussianLaw_increments
    (n := K) (t := fun k : Fin (K + 1) ↦ textbookWienerTime T K k.val)
  exact hg.map L

theorem textbookWienerWeightedSum_integral {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (a : Fin K → ℝ) :
    (∫ ω, textbookWienerWeightedSum W T K a ω ∂P) = 0 := by
  unfold textbookWienerWeightedSum
  rw [integral_finsetSum _ (fun k _ ↦
    ((textbookWienerIncrement_hasLaw hW T K k).hasGaussianLaw.integrable).const_mul (a k))]
  apply Finset.sum_eq_zero
  intro k _
  rw [integral_const_mul, (textbookWienerIncrement_hasLaw hW T K k).integral_eq,
    integral_id_gaussianReal, mul_zero]

theorem textbookWienerWeightedSum_variance {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (a : Fin K → ℝ) :
    variance (textbookWienerWeightedSum W T K a) P =
      (textbookWienerWeightedVariance T K a : ℝ) := by
  let V : Fin K → Ω → ℝ := fun k ω ↦ a k * textbookWienerIncrement W T K k ω
  have hv (k : Fin K) : MemLp (V k) 2 P :=
    ((textbookWienerIncrement_hasLaw hW T K k).hasGaussianLaw.memLp_two).const_mul (a k)
  have hi : iIndepFun V P := (textbookWienerIncrement_independent hW T K).comp
    (fun (k : Fin K) (x : ℝ) ↦ a k * x) (fun _ ↦ by fun_prop)
  have hvar (k : Fin K) : variance (V k) P = a k ^ 2 * (T / (K : ℝ≥0) : ℝ) := by
    rw [variance_const_mul, (textbookWienerIncrement_hasLaw hW T K k).variance_eq,
      variance_id_gaussianReal]
    simp only [NNReal.coe_div]
  have hs : variance (∑ k : Fin K, V k) P = ∑ k : Fin K, variance (V k) P :=
    IndepFun.variance_sum (fun k _ ↦ hv k) (fun _ _ _ _ hij ↦ hi.indepFun hij)
  have he : textbookWienerWeightedSum W T K a = ∑ k : Fin K, V k := by
    funext ω
    simp only [textbookWienerWeightedSum, Finset.sum_apply, V]
  rw [he, hs]
  simp only [hvar, textbookWienerWeightedVariance]
  push_cast
  simp only [Real.coe_toNNReal, sq_nonneg]

/-- The actual finite deterministic Wiener sum is centered Gaussian with its computed variance. -/
theorem textbookWienerWeightedSum_hasLaw {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (a : Fin K → ℝ) :
    HasLaw (textbookWienerWeightedSum W T K a)
      (gaussianReal 0 (textbookWienerWeightedVariance T K a)) P := by
  have hg := textbookWienerWeightedSum_hasGaussianLaw hW T K a
  refine ⟨hg.aemeasurable, ?_⟩
  rw [hg.map_eq_gaussianReal, textbookWienerWeightedSum_integral hW T K a,
    textbookWienerWeightedSum_variance hW T K a, Real.toNNReal_coe]

/-- The real L² isometry for differences of actual finite deterministic Wiener sums. -/
theorem textbookWienerWeightedSum_difference_secondMoment {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (a b : Fin K → ℝ) :
    (∫ ω, (textbookWienerWeightedSum W T K a ω -
      textbookWienerWeightedSum W T K b ω) ^ 2 ∂P) =
      ∑ k, (a k - b k) ^ 2 * (T / (K : ℝ≥0) : ℝ) := by
  have he : (fun ω ↦ textbookWienerWeightedSum W T K a ω -
      textbookWienerWeightedSum W T K b ω) = textbookWienerWeightedSum W T K (a - b) := by
    funext ω
    simp only [textbookWienerWeightedSum, Pi.sub_apply, sub_mul, Finset.sum_sub_distrib]
  change (∫ ω, (fun ω ↦ textbookWienerWeightedSum W T K a ω -
    textbookWienerWeightedSum W T K b ω) ω ^ 2 ∂P) = _
  rw [he, textbookCenteredGaussian_secondMoment (textbookWienerWeightedSum_hasLaw hW T K (a - b))]
  simp only [textbookWienerWeightedVariance, Pi.sub_apply]
  push_cast
  simp only [Real.coe_toNNReal, sq_nonneg]

/-- The genuine left endpoint sum for the integral of W against itself. -/
noncomputable def textbookWienerSelfItoSum (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ k : Fin K, W (textbookWienerTime T K k.val) ω *
    textbookWienerIncrement W T K k ω

private theorem discrete_square_identity (v : ℕ → ℝ) (K : ℕ) :
    2 * (∑ k ∈ Finset.range K, v k * (v (k + 1) - v k)) =
      v K ^ 2 - v 0 ^ 2 - ∑ k ∈ Finset.range K, (v (k + 1) - v k) ^ 2 := by
  induction K with
  | zero => simp
  | succ K ih =>
    rw [Finset.sum_range_succ, Finset.sum_range_succ]
    nlinarith [ih]

/-- The self-integral identity is derived by an actual finite telescoping calculation. -/
theorem textbookWienerSelfItoSum_identity {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ ω ∂P, 2 * textbookWienerSelfItoSum W T K ω =
      W T ω ^ 2 - textbookWienerQuadraticSum W T K ω := by
  have htime : textbookWienerTime T K K = T := by
    unfold textbookWienerTime
    have hn : (K : ℝ≥0) ≠ 0 := by exact_mod_cast hK.ne'
    field_simp
  filter_upwards [hW.eval_zero_ae_eq_zero] with ω h0
  have h := discrete_square_identity (fun k ↦ W (textbookWienerTime T K k) ω) K
  rw [htime] at h
  rw [Finset.sum_range, Finset.sum_range] at h
  simpa [textbookWienerSelfItoSum, textbookWienerQuadraticSum,
    textbookWienerIncrement, textbookWienerTime, h0] using h

/-- The proposed self-integral is a genuine L² random variable, from Gaussian fourth integrability. -/
theorem textbookWienerSelfItoLimit_memLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun ω ↦ (W T ω ^ 2 - (T : ℝ)) / 2) 2 P := by
  have := hW.isGaussianProcess.isProbabilityMeasure
  have hs := textbookCenteredGaussian_square_memLp (hW.hasLaw_eval T)
  have hd := hs.sub (memLp_const (T : ℝ))
  simpa only [Pi.sub_apply, div_eq_mul_inv] using hd.mul_const (2 : ℝ)⁻¹

/-- The actual self left sums are L²; the finite telescoping identity gives this without fake limits. -/
theorem textbookWienerSelfItoSum_memLp {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P := by
  have hq : MemLp (textbookWienerQuadraticSum W T K) 2 P :=
    memLp_finsetSum _ (fun k _ ↦
      textbookCenteredGaussian_square_memLp (textbookWienerIncrement_hasLaw hW T K k))
  have hs := (textbookCenteredGaussian_square_memLp (hW.hasLaw_eval T)).sub hq
  have he : (fun ω ↦ (W T ω ^ 2 - textbookWienerQuadraticSum W T K ω) * (2 : ℝ)⁻¹)
      =ᵐ[P] textbookWienerSelfItoSum W T K := by
    filter_upwards [textbookWienerSelfItoSum_identity hW T hK] with ω hω
    linarith
  exact (memLp_congr_ae he).mp (hs.mul_const (2 : ℝ)⁻¹)

/-- The exact mean-square error constructs the self-Itô integral as a true left-sum limit. -/
theorem textbookWienerSelfItoSum_meanSquareError {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ ω, (textbookWienerSelfItoSum W T K ω -
      (W T ω ^ 2 - (T : ℝ)) / 2) ^ 2 ∂P) = ((T : ℝ) ^ 2 / 2) / (K : ℝ) := by
  have he : ∀ᵐ ω ∂P, (textbookWienerSelfItoSum W T K ω -
      (W T ω ^ 2 - (T : ℝ)) / 2) ^ 2 =
      (1 / 4 : ℝ) * (textbookWienerQuadraticSum W T K ω - (T : ℝ)) ^ 2 := by
    filter_upwards [textbookWienerSelfItoSum_identity hW T hK] with ω hω
    have hS : textbookWienerSelfItoSum W T K ω =
        (W T ω ^ 2 - textbookWienerQuadraticSum W T K ω) / 2 := by linarith
    rw [hS]
    ring
  rw [integral_congr_ae he, integral_const_mul, textbookWienerQuadraticSum_meanSquareError hW T hK]
  ring

/-- Printed230/PDF251: the left sums genuinely converge in mean square to (W(T)²-T)/2. -/
theorem textbookWienerSelfItoSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerSelfItoSum W T K ω -
      (W T ω ^ 2 - (T : ℝ)) / 2) ^ 2 ∂P) atTop (𝓝 0) := by
  apply (tendsto_const_div_atTop_nhds_zero_nat ((T : ℝ) ^ 2 / 2)).congr'
  filter_upwards [eventually_gt_atTop 0] with K hK
  exact (textbookWienerSelfItoSum_meanSquareError hW T hK).symm

/-- The self-integral actually exists as an L² mean-square limit, with its computed value. -/
theorem textbookWienerSelfItoIntegral_exists {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerSelfItoSum W T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ ω ∂P, Y ω = (W T ω ^ 2 - (T : ℝ)) / 2 := by
  exact ⟨fun ω ↦ (W T ω ^ 2 - (T : ℝ)) / 2, textbookWienerSelfItoLimit_memLp hW T,
    textbookWienerSelfItoSum_meanSquare_tendsto hW T, Filter.Eventually.of_forall (fun _ ↦ rfl)⟩

end MolecularDynamics
