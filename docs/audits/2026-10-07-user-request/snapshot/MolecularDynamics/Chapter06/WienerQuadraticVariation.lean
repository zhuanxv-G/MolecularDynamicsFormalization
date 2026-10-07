import Mathlib.Probability.BrownianMotion.Basic
import Mathlib.Probability.Moments.Variance

/-! The textbook Proposition 6.2, printed pages 229--230 (PDF 250--251).
The probability data are the actual finite-dimensional laws of a real Brownian process.
-/

open MeasureTheory ProbabilityTheory Filter
open scoped NNReal ENNReal Topology ProbabilityTheory

namespace MolecularDynamics

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}

private theorem gaussian_fourth_moment (v : ℝ≥0) :
    (∫ x : ℝ, x ^ 4 ∂gaussianReal 0 v) = 3 * (v : ℝ) ^ 2 := by
  let E : ℝ → ℝ := fun t ↦ Real.exp ((v : ℝ) * t ^ 2 / 2)
  have hE (t : ℝ) : HasDerivAt E ((v : ℝ) * t * E t) t := by
    convert (((hasDerivAt_const t (v : ℝ)).mul ((hasDerivAt_id t).pow 2)).div_const 2).exp
      using 1
    · rfl
    · dsimp [E]
      ring
  have h2 (t : ℝ) : HasDerivAt (fun t ↦ (v : ℝ) * t * E t)
      (((v : ℝ) + (v : ℝ) ^ 2 * t ^ 2) * E t) t := by
    convert (((hasDerivAt_const t (v : ℝ)).mul (hasDerivAt_id t)).mul (hE t))
      using 1
    · rfl
    · dsimp
      ring
  have h3 (t : ℝ) : HasDerivAt (fun t ↦ ((v : ℝ) + (v : ℝ) ^ 2 * t ^ 2) * E t)
      ((3 * (v : ℝ) ^ 2 * t + (v : ℝ) ^ 3 * t ^ 3) * E t) t := by
    convert (((hasDerivAt_const t (v : ℝ)).add
      ((hasDerivAt_const t ((v : ℝ) ^ 2)).mul ((hasDerivAt_id t).pow 2))).mul (hE t))
      using 1
    · rfl
    · dsimp
      ring
  have h4 (t : ℝ) : HasDerivAt
      (fun t ↦ (3 * (v : ℝ) ^ 2 * t + (v : ℝ) ^ 3 * t ^ 3) * E t)
      ((3 * (v : ℝ) ^ 2 + 6 * (v : ℝ) ^ 3 * t ^ 2 + (v : ℝ) ^ 4 * t ^ 4) * E t) t := by
    convert ((((hasDerivAt_const t (3 * (v : ℝ) ^ 2)).mul (hasDerivAt_id t)).add
      ((hasDerivAt_const t ((v : ℝ) ^ 3)).mul ((hasDerivAt_id t).pow 3))).mul (hE t))
      using 1
    · rfl
    · dsimp
      ring
  have d1 : iteratedDeriv 1 E = fun t ↦ (v : ℝ) * t * E t := by
    funext t
    simpa only [iteratedDeriv_one] using (hE t).deriv
  have d2 : iteratedDeriv 2 E = fun t ↦ ((v : ℝ) + (v : ℝ) ^ 2 * t ^ 2) * E t := by
    rw [iteratedDeriv_succ, d1]
    funext t
    exact (h2 t).deriv
  have d3 : iteratedDeriv 3 E =
      fun t ↦ (3 * (v : ℝ) ^ 2 * t + (v : ℝ) ^ 3 * t ^ 3) * E t := by
    rw [iteratedDeriv_succ, d2]
    funext t
    exact (h3 t).deriv
  have hmgf : (∫ x : ℝ, x ^ 4 ∂gaussianReal 0 v) =
      iteratedDeriv 4 (mgf id (gaussianReal 0 v)) 0 := by
    simpa only [Pi.pow_apply, id_eq] using
      (iteratedDeriv_mgf_zero (X := id) (μ := gaussianReal 0 v) (by simp) 4).symm
  rw [hmgf, mgf_id_gaussianReal]
  simp only [zero_mul, zero_add]
  change iteratedDeriv 4 E 0 = _
  rw [iteratedDeriv_succ, d3]
  simpa [E] using (h4 0).deriv

/-- The second moment is derived from the genuine centered Gaussian law. -/
theorem textbookCenteredGaussian_secondMoment {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ ω, X ω ^ 2 ∂P) = (v : ℝ) := by
  have hm : (∫ ω, X ω ∂P) = 0 := by rw [hX.integral_eq, integral_id_gaussianReal]
  rw [← variance_of_integral_eq_zero hX.aemeasurable hm, hX.variance_eq,
    variance_id_gaussianReal]

/-- The fourth moment is derived by differentiating the actual Gaussian mgf four times. -/
theorem textbookCenteredGaussian_fourthMoment {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ ω, X ω ^ 4 ∂P) = 3 * (v : ℝ) ^ 2 := by
  exact (hX.integral_comp (f := fun x : ℝ ↦ x ^ 4) (by fun_prop)).trans
    (gaussian_fourth_moment v)

/-- Squaring a genuine Gaussian random variable gives an actual L² variable. -/
theorem textbookCenteredGaussian_square_memLp {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) : MemLp (fun ω ↦ X ω ^ 2) 2 P := by
  refine (memLp_two_iff_integrable_sq (hX.aemeasurable.pow_const 2).aestronglyMeasurable).2 ?_
  have h4g : Integrable (fun x : ℝ ↦ x ^ 4) (gaussianReal 0 v) :=
    integrable_pow_of_mem_interior_integrableExpSet (X := id) (by simp) 4
  have h4 : Integrable (fun ω ↦ X ω ^ 4) P := hX.integrable_fun_comp h4g
  simpa only [← pow_mul] using h4

/-- The variance of the squared increment follows from its genuine second and fourth moments. -/
theorem textbookCenteredGaussian_square_variance {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    variance (fun ω ↦ X ω ^ 2) P = 2 * (v : ℝ) ^ 2 := by
  have := hX.isProbabilityMeasure
  rw [variance_eq_sub (textbookCenteredGaussian_square_memLp hX)]
  simp only [Pi.pow_apply, ← pow_mul]
  rw [textbookCenteredGaussian_fourthMoment hX, textbookCenteredGaussian_secondMoment hX]
  ring

/-- The actual uniform partition, with K intervals on [0,T]. -/
noncomputable def textbookWienerTime (T : ℝ≥0) (K k : ℕ) : ℝ≥0 :=
  (k : ℝ≥0) * (T / (K : ℝ≥0))

/-- An increment of the given process over one actual uniform interval. -/
noncomputable def textbookWienerIncrement (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ)
    (k : Fin K) : Ω → ℝ :=
  fun ω ↦ W (textbookWienerTime T K (k.val + 1)) ω - W (textbookWienerTime T K k.val) ω

/-- The actual sum of squared Brownian increments. -/
noncomputable def textbookWienerQuadraticSum (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ k : Fin K, textbookWienerIncrement W T K k ω ^ 2

theorem textbookWienerIncrement_hasLaw {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P := by
  have hd : nndist (textbookWienerTime T K (k.val + 1) : ℝ)
      (textbookWienerTime T K k.val : ℝ) = T / (K : ℝ≥0) := by
    apply NNReal.coe_injective
    change dist (textbookWienerTime T K (k.val + 1) : ℝ)
      (textbookWienerTime T K k.val : ℝ) = (T / (K : ℝ≥0) : ℝ≥0)
    rw [Real.dist_eq]
    have he : (textbookWienerTime T K (k.val + 1) : ℝ) -
        (textbookWienerTime T K k.val : ℝ) = (T / (K : ℝ≥0) : ℝ≥0) := by
      simp only [textbookWienerTime, NNReal.coe_mul, NNReal.coe_div, NNReal.coe_natCast,
        Nat.cast_add, Nat.cast_one]
      push_cast
      ring
    rw [he, abs_of_nonneg (by positivity)]
  have h := hW.hasLaw_sub (textbookWienerTime T K (k.val + 1))
    (textbookWienerTime T K k.val)
  convert h using 1
  · rfl
  · exact congrArg (gaussianReal 0) hd.symm

theorem textbookWienerIncrement_independent {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P := by
  apply hW.hasIndepIncrements K (fun k ↦ textbookWienerTime T K k.val)
  intro i j hij
  exact mul_le_mul_of_nonneg_right (by exact_mod_cast hij) (by positivity)

/-- The genuine squared-increment sum has expectation T for every positive partition size. -/
theorem textbookWienerQuadraticSum_integral {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ ω, textbookWienerQuadraticSum W T K ω ∂P) = (T : ℝ) := by
  have := hW.isGaussianProcess.isProbabilityMeasure
  have he (k : Fin K) : (∫ ω, textbookWienerIncrement W T K k ω ^ 2 ∂P) =
      (T / (K : ℝ≥0) : ℝ≥0) :=
    textbookCenteredGaussian_secondMoment (textbookWienerIncrement_hasLaw hW T K k)
  unfold textbookWienerQuadraticSum
  rw [integral_finsetSum _ (fun k _ ↦
    (textbookCenteredGaussian_square_memLp (textbookWienerIncrement_hasLaw hW T K k)).integrable
      (by norm_num))]
  simp only [he, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  push_cast
  have hn : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
  field_simp

/-- Independence of actual increments gives the exact variance of their squared sum. -/
theorem textbookWienerQuadraticSum_variance {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    variance (textbookWienerQuadraticSum W T K) P = 2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  let V : Fin K → Ω → ℝ := fun k ω ↦ textbookWienerIncrement W T K k ω ^ 2
  have hv (k : Fin K) : MemLp (V k) 2 P :=
    textbookCenteredGaussian_square_memLp (textbookWienerIncrement_hasLaw hW T K k)
  have hi : iIndepFun V P :=
    (textbookWienerIncrement_independent hW T K).comp
      (fun (_ : Fin K) (x : ℝ) ↦ x ^ 2) (fun _ ↦ by fun_prop)
  have hvar (k : Fin K) : variance (V k) P = 2 * (T / (K : ℝ≥0) : ℝ) ^ 2 :=
    textbookCenteredGaussian_square_variance (textbookWienerIncrement_hasLaw hW T K k)
  have hs : variance (∑ k : Fin K, V k) P = ∑ k : Fin K, variance (V k) P :=
    IndepFun.variance_sum (fun k _ ↦ hv k) (fun _ _ _ _ hij ↦ hi.indepFun hij)
  have hsum : textbookWienerQuadraticSum W T K = ∑ k : Fin K, V k := by
    funext ω
    simp only [textbookWienerQuadraticSum, Finset.sum_apply, V]
  rw [hsum, hs]
  simp only [hvar, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  push_cast
  have hn : (K : ℝ) ≠ 0 := by exact_mod_cast hK.ne'
  field_simp

/-- Proposition 6.2's exact mean-square error, derived from the Brownian laws. -/
theorem textbookWienerQuadraticSum_meanSquareError {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ ω, (textbookWienerQuadraticSum W T K ω - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  have ha : AEMeasurable (textbookWienerQuadraticSum W T K) P := by
    unfold textbookWienerQuadraticSum
    exact Finset.aemeasurable_fun_sum _ (fun k _ ↦
      (textbookWienerIncrement_hasLaw hW T K k).aemeasurable.pow_const 2)
  have hv := variance_eq_integral ha
  rw [textbookWienerQuadraticSum_integral hW T hK] at hv
  exact hv.symm.trans (textbookWienerQuadraticSum_variance hW T hK)

/-- Proposition 6.2: the actual sums converge to T in the textbook mean-square sense. -/
theorem textbookWienerQuadraticSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ ω,
      (textbookWienerQuadraticSum W T K ω - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply (tendsto_const_div_atTop_nhds_zero_nat (2 * (T : ℝ) ^ 2)).congr'
  filter_upwards [eventually_gt_atTop 0] with K hK
  exact (textbookWienerQuadraticSum_meanSquareError hW T hK).symm

end MolecularDynamics
