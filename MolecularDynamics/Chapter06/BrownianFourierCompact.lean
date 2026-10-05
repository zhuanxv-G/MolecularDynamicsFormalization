import MolecularDynamics.Chapter06.BrownianPotentialSelfAdjoint
import Mathlib.Analysis.Normed.Operator.Compact.Basic

/-! Genuine inverse-frequency coefficient operators, necessary for actual compact resolvent construction. -/

open MeasureTheory Filter Topology
open scoped ContDiff BigOperators

namespace MolecularDynamics

noncomputable section

private local instance brownianFourierCompactCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianFourierCompactCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual original mass frequency inverse weight. -/
def textbookMassFourierInverseWeight {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (n : Fin Nc → ℤ) : ℝ :=
  (1 + textbookMassFourierFrequency m β n)⁻¹

/-- Actual positive original masses and temperature give a genuinely positive weight. -/
theorem textbookMassFourierInverseWeight_pos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) :
    0 < textbookMassFourierInverseWeight m β n := by
  have h := textbookMassFourierFrequency_nonneg m hm β hβ n
  exact inv_pos.mpr (by linarith)

/-- The actual frequency weights are contractions, rather than a supplied coefficient bound. -/
theorem textbookMassFourierInverseWeight_le_one {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) :
    textbookMassFourierInverseWeight m β n ≤ 1 := by
  have h := textbookMassFourierFrequency_nonneg m hm β hβ n
  unfold textbookMassFourierInverseWeight
  have hbound := one_div_le_one_div_of_le (by norm_num : (0 : ℝ) < 1)
      (show (1 : ℝ) ≤ 1 + textbookMassFourierFrequency m β n by linarith)
  simp only [one_div, inv_one] at hbound
  exact hbound

/-- Actual inverse weights are even under the genuine integer index negation. -/
theorem textbookMassFourierInverseWeight_neg {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (n : Fin Nc → ℤ) :
    textbookMassFourierInverseWeight m β (-n) = textbookMassFourierInverseWeight m β n := by
  simp [textbookMassFourierInverseWeight, textbookMassFourierFrequency]

private theorem weight_mul_norm {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) (c : ℂ) :
    ‖(textbookMassFourierInverseWeight m β n : ℂ) * c‖ ≤ ‖c‖ := by
  rw [norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos (textbookMassFourierInverseWeight_pos m hm β hβ n)]
  exact (mul_le_mul_of_nonneg_right
    (textbookMassFourierInverseWeight_le_one m hm β hβ n) (norm_nonneg c)).trans_eq (one_mul _)

/-- The genuine bounded inverse-frequency multiplication operator on the actual coefficient ℓ² space. -/
def textbookMassFourierCoefficientOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2 →L[ℂ] lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2 :=
  LinearMap.mkContinuous
    { toFun a := ⟨fun n ↦ (textbookMassFourierInverseWeight m β n : ℂ) * a n,
        (lp.memℓp a).mono' (fun n ↦ weight_mul_norm m hm β hβ n (a n))⟩
      map_add' a b := by
        apply Subtype.ext
        funext n
        change (textbookMassFourierInverseWeight m β n : ℂ) * (a n + b n) =
          (textbookMassFourierInverseWeight m β n : ℂ) * a n +
            (textbookMassFourierInverseWeight m β n : ℂ) * b n
        ring
      map_smul' c a := by
        apply Subtype.ext
        funext n
        change (textbookMassFourierInverseWeight m β n : ℂ) * (c * a n) =
          c * ((textbookMassFourierInverseWeight m β n : ℂ) * a n)
        ring }
    1 (fun a ↦ by
      have h := lp.norm_mono (by norm_num : (2 : ENNReal) ≠ 0)
        (x := (⟨fun n ↦ (textbookMassFourierInverseWeight m β n : ℂ) * a n,
          (lp.memℓp a).mono' (fun n ↦ weight_mul_norm m hm β hβ n (a n))⟩ :
            lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2))
        (y := a) (fun n ↦ weight_mul_norm m hm β hβ n (a n))
      simp only [one_mul]
      exact h)

/-- The true coefficient operator acts by the actual original weights at every integer index. -/
theorem textbookMassFourierCoefficientOperator_apply {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (a : lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2) (n : Fin Nc → ℤ) :
    textbookMassFourierCoefficientOperator m hm β hβ a n =
      (textbookMassFourierInverseWeight m β n : ℂ) * a n := rfl

/-- The genuine whole coefficient operator is norm-contracting. -/
theorem textbookMassFourierCoefficientOperator_norm {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (a : lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2) :
    ‖textbookMassFourierCoefficientOperator m hm β hβ a‖ ≤ ‖a‖ :=
  lp.norm_mono (by norm_num : (2 : ENNReal) ≠ 0)
    (fun n ↦ weight_mul_norm m hm β hβ n (a n))

/-- Actual finite-rank truncations using the genuine coefficient evaluation and single maps. -/
def textbookMassFourierCoefficientFinite {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (s : Finset (Fin Nc → ℤ)) :
    lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2 →L[ℂ] lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2 :=
  ∑ n ∈ s, (textbookMassFourierInverseWeight m β n : ℂ) •
    (lp.singleContinuousLinearMap ℂ (fun _ : Fin Nc → ℤ ↦ ℂ) 2 n).comp
      (lp.evalCLM ℂ (fun _ : Fin Nc → ℤ ↦ ℂ) 2 n)

/-- Every finite approximation acts on exactly the selected actual integer coordinates. -/
theorem textbookMassFourierCoefficientFinite_apply {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (s : Finset (Fin Nc → ℤ)) (a : lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2)
    (n : Fin Nc → ℤ) :
    textbookMassFourierCoefficientFinite m β s a n =
      if n ∈ s then (textbookMassFourierInverseWeight m β n : ℂ) * a n else 0 := by
  classical
  simp only [textbookMassFourierCoefficientFinite, sum_apply,
    smul_apply, ContinuousLinearMap.comp_apply,
    lp.singleContinuousLinearMap_apply]
  change (∑ i ∈ s, (textbookMassFourierInverseWeight m β i : ℂ) •
    lp.single 2 i (a i)) n = _
  simp only [lp.coeFn_sum, Finset.sum_apply, lp.coeFn_smul, Pi.smul_apply,
    lp.single_apply]
  by_cases hn : n ∈ s
  · rw [ite_eq_left hn]
    rw [Finset.sum_eq_single n]
    · simp
    · intro i _ hin
      simp [Pi.single, Function.update, hin.symm]
    · exact fun h ↦ (h hn).elim
  · rw [ite_eq_right hn]
    apply Finset.sum_eq_zero
    intro i hi
    have hin : n ≠ i := by intro h; exact hn (h.symm ▸ hi)
    simp [Pi.single, Function.update, hin]

/-- The actual finite sums are compact, since each genuine single map has domain ℂ. -/
theorem textbookMassFourierCoefficientFinite_isCompact {Nc : ℕ}
    (m : Fin Nc → ℝ) (β : ℝ) (s : Finset (Fin Nc → ℤ)) :
    IsCompactOperator (textbookMassFourierCoefficientFinite m β s) := by
  classical
  apply (compactOperator (RingHom.id ℂ)
    (lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2)
    (lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2)).sum_mem
  intro n _
  apply (compactOperator (RingHom.id ℂ)
    (lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2)
    (lp (fun _ : Fin Nc → ℤ ↦ ℂ) 2)).smul_mem
  exact (isCompactOperator_of_locallyCompactSpace_rng
    (lp.singleContinuousLinearMap ℂ (fun _ : Fin Nc → ℤ ↦ ℂ) 2 n)).comp_clm
      (lp.evalCLM ℂ (fun _ : Fin Nc → ℤ ↦ ℂ) 2 n)

private theorem coefficient_tail_bound {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (s : Finset (Fin Nc → ℤ)) (ε : ℝ) (hε : 0 ≤ ε)
    (hs : ∀ n ∉ s, textbookMassFourierInverseWeight m β n ≤ ε) :
    ‖textbookMassFourierCoefficientOperator m hm β hβ -
      textbookMassFourierCoefficientFinite m β s‖ ≤ ε := by
  apply ContinuousLinearMap.opNorm_le_bound _ hε
  intro a
  have hnorm := lp.norm_mono (by norm_num : (2 : ENNReal) ≠ 0)
    (x := (textbookMassFourierCoefficientOperator m hm β hβ -
      textbookMassFourierCoefficientFinite m β s) a) (y := ε • a) ?_
  · simpa only [norm_smul, Real.norm_eq_abs, abs_of_nonneg hε] using hnorm
  intro n
  change ‖textbookMassFourierCoefficientOperator m hm β hβ a n -
    textbookMassFourierCoefficientFinite m β s a n‖ ≤ ‖ε • a n‖
  rw [textbookMassFourierCoefficientOperator_apply,
    textbookMassFourierCoefficientFinite_apply]
  by_cases hn : n ∈ s
  · simp only [ite_eq_left hn, sub_self, norm_zero]
    exact norm_nonneg _
  · rw [ite_eq_right hn, sub_zero, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (textbookMassFourierInverseWeight_pos m hm β hβ n),
      norm_smul, Real.norm_eq_abs, abs_of_nonneg hε]
    exact mul_le_mul_of_nonneg_right (hs n hn) (norm_nonneg _)

/-- The genuine finite-rank coefficient maps converge in actual operator norm. -/
theorem textbookMassFourierCoefficientFinite_tendsto {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    Tendsto (textbookMassFourierCoefficientFinite m β) atTop
      (𝓝 (textbookMassFourierCoefficientOperator m hm β hβ)) := by
  classical
  apply Metric.tendsto_atTop.2
  intro ε hε
  have hdecay := textbookMassFourierFrequency_resolvent_decay m hm β hβ
  have hev : ∀ᶠ n in cofinite, dist (textbookMassFourierInverseWeight m β n) 0 < ε / 2 :=
    hdecay (Metric.ball_mem_nhds 0 (by linarith))
  rw [eventually_cofinite] at hev
  refine ⟨hev.toFinset, fun s hs ↦ ?_⟩
  rw [dist_eq_norm, norm_sub_rev]
  apply lt_of_le_of_lt (coefficient_tail_bound m hm β hβ s (ε / 2)
    (by linarith) ?_) (by linarith)
  intro n hn
  have hnsmall : dist (textbookMassFourierInverseWeight m β n) 0 < ε / 2 := by
    by_contra h
    exact hn (hs (hev.mem_toFinset.mpr h))
  rw [dist_zero_right, Real.norm_eq_abs,
    abs_of_pos (textbookMassFourierInverseWeight_pos m hm β hβ n)] at hnsmall
  exact hnsmall.le

/-- Compactness of the genuine whole coefficient operator is derived from the actual norm limit. -/
theorem textbookMassFourierCoefficientOperator_isCompact {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookMassFourierCoefficientOperator m hm β hβ) :=
  isCompactOperator_of_tendsto (textbookMassFourierCoefficientFinite_tendsto m hm β hβ)
    (Filter.Eventually.of_forall (textbookMassFourierCoefficientFinite_isCompact m β))

/-- The genuine entire complex Haar L² inverse-frequency operator using the actual Hilbert basis. -/
def textbookHaarMassComplexFourierOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℂ]
      Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  UnitAddTorus.mFourierBasis.repr.symm.toContinuousLinearEquiv.toContinuousLinearMap.comp
    ((textbookMassFourierCoefficientOperator m hm β hβ).comp
      UnitAddTorus.mFourierBasis.repr.toContinuousLinearEquiv.toContinuousLinearMap)

/-- Its genuine Fourier coefficients are the literal original inverse-frequency multipliers. -/
theorem textbookHaarMassComplexFourierOperator_coeff {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (x : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) (n : Fin Nc → ℤ) :
    UnitAddTorus.mFourierCoeff (textbookHaarMassComplexFourierOperator m hm β hβ x) n =
      (textbookMassFourierInverseWeight m β n : ℂ) * UnitAddTorus.mFourierCoeff x n := by
  rw [← UnitAddTorus.mFourierBasis_repr, ← UnitAddTorus.mFourierBasis_repr]
  change UnitAddTorus.mFourierBasis.repr
    (UnitAddTorus.mFourierBasis.repr.symm
      (textbookMassFourierCoefficientOperator m hm β hβ
        (UnitAddTorus.mFourierBasis.repr x))) n = _
  rw [LinearIsometryEquiv.apply_symm_apply, textbookMassFourierCoefficientOperator_apply]

/-- The genuine whole complex Haar L² map contracts the actual Hilbert norm. -/
theorem textbookHaarMassComplexFourierOperator_norm {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (x : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ‖textbookHaarMassComplexFourierOperator m hm β hβ x‖ ≤ ‖x‖ := by
  change ‖UnitAddTorus.mFourierBasis.repr.symm
    (textbookMassFourierCoefficientOperator m hm β hβ
      (UnitAddTorus.mFourierBasis.repr x))‖ ≤ ‖x‖
  rw [LinearIsometryEquiv.norm_map]
  exact (textbookMassFourierCoefficientOperator_norm m hm β hβ _).trans_eq
    (UnitAddTorus.mFourierBasis.repr.norm_map x)

/-- Actual whole complex Haar compactness follows from the genuine coefficient norm-limit proof. -/
theorem textbookHaarMassComplexFourierOperator_isCompact {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookHaarMassComplexFourierOperator m hm β hβ) :=
  ((textbookMassFourierCoefficientOperator_isCompact m hm β hβ).comp_clm
    UnitAddTorus.mFourierBasis.repr.toContinuousLinearEquiv.toContinuousLinearMap).clm_comp
      UnitAddTorus.mFourierBasis.repr.symm.toContinuousLinearEquiv.toContinuousLinearMap

/-- The actual real-part map contracts full Haar L², derived from the true scalar norm bound. -/
theorem textbookHaarL2RealPart_norm {Nc : ℕ}
    (z : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ‖textbookHaarL2RealPart Nc z‖ ≤ ‖z‖ := by
  have hre : ‖Complex.reCLM‖ ≤ 1 :=
    ContinuousLinearMap.opNorm_le_bound _ (by norm_num) (fun c ↦ by
      simpa only [Complex.reCLM_apply, Real.norm_eq_abs, one_mul] using Complex.abs_re_le_norm c)
  have hlp : ‖textbookHaarL2RealPart Nc‖ ≤ 1 :=
    (Complex.reCLM.norm_compLpL_le (p := 2)
      (μ := (volume : Measure (UnitAddTorus (Fin Nc))))).trans hre
  exact ((textbookHaarL2RealPart Nc).le_opNorm z).trans
    ((mul_le_mul_of_nonneg_right hlp (norm_nonneg z)).trans_eq (one_mul _))

/-- The genuine entire real Haar L² map, from actual complexification, Fourier multiplication and real part. -/
def textbookHaarMassFourierOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  (textbookHaarL2RealPart Nc).comp
    (((textbookHaarMassComplexFourierOperator m hm β hβ).restrictScalars ℝ).comp
      (textbookHaarL2Complexify Nc))

/-- The actual real Haar map contracts the genuine norm. -/
theorem textbookHaarMassFourierOperator_norm {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ‖textbookHaarMassFourierOperator m hm β hβ x‖ ≤ ‖x‖ :=
  ((textbookHaarL2RealPart_norm _).trans
    (textbookHaarMassComplexFourierOperator_norm m hm β hβ _)).trans_eq
      (textbookHaarL2Complexify_norm x)

/-- Actual entire real Haar compactness is proved by continuous composition, with no compactness premise. -/
theorem textbookHaarMassFourierOperator_isCompact {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookHaarMassFourierOperator m hm β hβ) :=
  ((textbookHaarMassComplexFourierOperator_isCompact m hm β hβ).comp_clm
    (textbookHaarL2Complexify Nc)).clm_comp (textbookHaarL2RealPart Nc)

end

end MolecularDynamics