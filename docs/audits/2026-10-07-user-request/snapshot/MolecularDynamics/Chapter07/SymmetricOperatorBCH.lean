import MolecularDynamics.Chapter03.FormalOperatorSeries

/-! Actual noncommuting composition and formal logarithm coefficients for Proposition 7.1. -/

open scoped BigOperators PowerSeries

namespace MolecularDynamics

variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- The genuine formal log(1+P), defined by its locally finite coefficients. -/
noncomputable def textbookFormalOperatorLogarithm (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun j ↦ ∑ n ∈ Finset.range (j + 1),
    ((-1 : ℝ) ^ (n + 1) / (n : ℝ)) • PowerSeries.coeff j ((S - 1) ^ n))

/-- The coefficients are stable under every sufficiently long actual logarithmic partial sum. -/
theorem textbookFormalOperatorLogarithm_coeff_stabilizes
    (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1)
    (j N : ℕ) (hjN : j < N) :
    PowerSeries.coeff j (textbookFormalOperatorLogarithm S) =
      ∑ n ∈ Finset.range N,
        ((-1 : ℝ) ^ (n + 1) / (n : ℝ)) • PowerSeries.coeff j ((S - 1) ^ n) := by
  have hp : PowerSeries.constantCoeff (S - 1) = 0 := by rw [map_sub, hS, map_one, sub_self]
  rw [textbookFormalOperatorLogarithm, PowerSeries.coeff_mk]
  apply Finset.sum_subset (Finset.range_mono (Nat.succ_le_of_lt hjN))
  intro n _ hn
  have hnj : j + 1 ≤ n := Nat.le_of_not_gt (fun h ↦ hn (Finset.mem_range.mpr h))
  rw [textbookFormalZeroConstant_power_coeff_zero ⟨S - 1, hp⟩ j n
    ((Nat.lt_succ_self j).trans_le hnj), smul_zero]

private theorem log_coeff_zero (S : PowerSeries R) :
    PowerSeries.coeff 0 (textbookFormalOperatorLogarithm S) = 0 := by
  simp [textbookFormalOperatorLogarithm]

omit [Algebra ℝ R] in
private theorem unit_sub_coeff_zero (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1) :
    PowerSeries.coeff 0 (S - 1) = 0 := by
  rw [map_sub, PowerSeries.coeff_zero_eq_constantCoeff_apply, hS]
  simp

omit [Algebra ℝ R] in
private theorem unit_sub_coeff_pos (S : PowerSeries R) {n : ℕ} (hn : n ≠ 0) :
    PowerSeries.coeff n (S - 1) = PowerSeries.coeff n S := by simp [hn]

theorem textbookFormalOperatorLogarithm_coeff_one (S : PowerSeries R) :
    PowerSeries.coeff 1 (textbookFormalOperatorLogarithm S) = PowerSeries.coeff 1 S := by
  norm_num [textbookFormalOperatorLogarithm, Finset.sum_range_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, unit_sub_coeff_pos]

theorem textbookFormalOperatorLogarithm_coeff_two (S : PowerSeries R)
    (hS : PowerSeries.constantCoeff S = 1) :
    PowerSeries.coeff 2 (textbookFormalOperatorLogarithm S) =
      PowerSeries.coeff 2 S - (1 / 2 : ℝ) • (PowerSeries.coeff 1 S) ^ 2 := by
  norm_num [textbookFormalOperatorLogarithm, Finset.sum_range_succ, pow_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, unit_sub_coeff_zero S hS,
    unit_sub_coeff_pos, hS]
  module

theorem textbookFormalOperatorLogarithm_coeff_three (S : PowerSeries R)
    (hS : PowerSeries.constantCoeff S = 1) :
    PowerSeries.coeff 3 (textbookFormalOperatorLogarithm S) =
      PowerSeries.coeff 3 S - (1 / 2 : ℝ) •
        (PowerSeries.coeff 1 S * PowerSeries.coeff 2 S +
          PowerSeries.coeff 2 S * PowerSeries.coeff 1 S) +
        (1 / 3 : ℝ) • (PowerSeries.coeff 1 S) ^ 3 := by
  norm_num [textbookFormalOperatorLogarithm, Finset.sum_range_succ, pow_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, unit_sub_coeff_zero S hS,
    unit_sub_coeff_pos, hS, mul_add, add_mul, mul_assoc]
  module

theorem textbookFormalOperatorLogarithm_coeff_four (S : PowerSeries R)
    (hS : PowerSeries.constantCoeff S = 1) :
    PowerSeries.coeff 4 (textbookFormalOperatorLogarithm S) =
      PowerSeries.coeff 4 S - (1 / 2 : ℝ) •
        (PowerSeries.coeff 1 S * PowerSeries.coeff 3 S +
          (PowerSeries.coeff 2 S) ^ 2 + PowerSeries.coeff 3 S * PowerSeries.coeff 1 S) +
        (1 / 3 : ℝ) • ((PowerSeries.coeff 1 S) ^ 2 * PowerSeries.coeff 2 S +
          PowerSeries.coeff 1 S * PowerSeries.coeff 2 S * PowerSeries.coeff 1 S +
          PowerSeries.coeff 2 S * (PowerSeries.coeff 1 S) ^ 2) -
        (1 / 4 : ℝ) • (PowerSeries.coeff 1 S) ^ 4 := by
  norm_num [textbookFormalOperatorLogarithm, Finset.sum_range_succ, pow_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, unit_sub_coeff_zero S hS,
    unit_sub_coeff_pos, hS, mul_add, add_mul, mul_assoc]
  module

/-- The literal five-stage XYZYX formal exponential composition. -/
noncomputable def textbookSymmetricOperatorComposition (X Y Z : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1 / 2 : ℝ) • X) *
    textbookFormalOperatorExponential ((1 / 2 : ℝ) • Y) *
    textbookFormalOperatorExponential Z *
    textbookFormalOperatorExponential ((1 / 2 : ℝ) • Y) *
    textbookFormalOperatorExponential ((1 / 2 : ℝ) • X)

/-- The actual operator commutator, retaining multiplication order. -/
def textbookOperatorCommutator (A B : R) : R := A * B - B * A

/-- The literal L2 expression on printed297/PDF318. -/
noncomputable def textbookSymmetricOperatorCorrection (X Y Z : R) : R :=
  (1 / 12 : ℝ) • (textbookOperatorCommutator Z (textbookOperatorCommutator Z Y) +
    textbookOperatorCommutator (Y + Z) (textbookOperatorCommutator (Y + Z) X)) -
  (1 / 24 : ℝ) • (textbookOperatorCommutator Y (textbookOperatorCommutator Y Z) +
    textbookOperatorCommutator X (textbookOperatorCommutator X (Y + Z)))

theorem textbookSymmetricOperatorComposition_coeff_zero (X Y Z : R) :
    PowerSeries.coeff 0 (textbookSymmetricOperatorComposition X Y Z) = 1 := by
  simp [textbookSymmetricOperatorComposition, PowerSeries.coeff_mul,
    textbookFormalOperatorExponential_coeff]

theorem textbookSymmetricOperatorComposition_coeff_one (X Y Z : R) :
    PowerSeries.coeff 1 (textbookSymmetricOperatorComposition X Y Z) = X + Y + Z := by
  norm_num [textbookSymmetricOperatorComposition, PowerSeries.coeff_mul,
    Finset.Nat.antidiagonal_succ, textbookFormalOperatorExponential_coeff,
    Nat.factorial_succ, smul_pow, smul_mul_assoc, mul_smul_comm, smul_smul]
  module

theorem textbookSymmetricOperatorComposition_coeff_two (X Y Z : R) :
    PowerSeries.coeff 2 (textbookSymmetricOperatorComposition X Y Z) =
      (1 / 2 : ℝ) • (X + Y + Z) ^ 2 := by
  norm_num [textbookSymmetricOperatorComposition, PowerSeries.coeff_mul,
    Finset.Nat.antidiagonal_succ, textbookFormalOperatorExponential_coeff,
    Nat.factorial_succ, smul_pow, smul_mul_assoc, mul_smul_comm, smul_smul]
  simp only [pow_succ, pow_zero, one_mul, mul_add, add_mul,
    smul_add, smul_mul_assoc, smul_smul]
  module

set_option maxHeartbeats 800000 in
theorem textbookSymmetricOperatorComposition_coeff_three (X Y Z : R) :
    PowerSeries.coeff 3 (textbookSymmetricOperatorComposition X Y Z) =
      (1 / 6 : ℝ) • (X + Y + Z) ^ 3 + textbookSymmetricOperatorCorrection X Y Z := by
  norm_num [textbookSymmetricOperatorComposition, PowerSeries.coeff_mul,
    Finset.Nat.antidiagonal_succ, textbookFormalOperatorExponential_coeff,
    Nat.factorial_succ, smul_pow, smul_mul_assoc, mul_smul_comm, smul_smul]
  simp only [textbookSymmetricOperatorCorrection, textbookOperatorCommutator,
    pow_succ, pow_zero, one_mul, mul_add, add_mul, mul_sub, sub_mul,
    mul_assoc, smul_add, smul_sub, smul_mul_assoc, smul_smul]
  module

set_option maxHeartbeats 800000 in
theorem textbookSymmetricOperatorComposition_coeff_four (X Y Z : R) :
    PowerSeries.coeff 4 (textbookSymmetricOperatorComposition X Y Z) =
      (1 / 24 : ℝ) • (X + Y + Z) ^ 4 + (1 / 2 : ℝ) •
        ((X + Y + Z) * textbookSymmetricOperatorCorrection X Y Z +
          textbookSymmetricOperatorCorrection X Y Z * (X + Y + Z)) := by
  norm_num [textbookSymmetricOperatorComposition, PowerSeries.coeff_mul,
    Finset.Nat.antidiagonal_succ, textbookFormalOperatorExponential_coeff,
    Nat.factorial_succ, smul_pow, smul_mul_assoc, mul_smul_comm, smul_smul]
  simp only [textbookSymmetricOperatorCorrection, textbookOperatorCommutator,
    pow_succ, pow_zero, one_mul, mul_add, add_mul, mul_sub, sub_mul,
    mul_assoc, smul_add, smul_sub, smul_mul_assoc, mul_smul_comm, smul_smul]
  module

/-- The full formal generator obtained by shifting the actual formal logarithm. -/
noncomputable def textbookSymmetricModifiedGenerator (X Y Z : R) : PowerSeries R :=
  PowerSeries.mk (fun n ↦ PowerSeries.coeff (n + 1)
    (textbookFormalOperatorLogarithm (textbookSymmetricOperatorComposition X Y Z)))

private theorem composition_constant_one (X Y Z : R) :
    PowerSeries.constantCoeff (textbookSymmetricOperatorComposition X Y Z) = 1 := by
  rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply,
    textbookSymmetricOperatorComposition_coeff_zero]

theorem textbookSymmetricModifiedGenerator_coeff_zero (X Y Z : R) :
    PowerSeries.coeff 0 (textbookSymmetricModifiedGenerator X Y Z) = X + Y + Z := by
  rw [textbookSymmetricModifiedGenerator, PowerSeries.coeff_mk]
  exact (textbookFormalOperatorLogarithm_coeff_one _).trans
    (textbookSymmetricOperatorComposition_coeff_one X Y Z)

theorem textbookSymmetricModifiedGenerator_coeff_one (X Y Z : R) :
    PowerSeries.coeff 1 (textbookSymmetricModifiedGenerator X Y Z) = 0 := by
  rw [textbookSymmetricModifiedGenerator, PowerSeries.coeff_mk,
    textbookFormalOperatorLogarithm_coeff_two _ (composition_constant_one X Y Z),
    textbookSymmetricOperatorComposition_coeff_two, textbookSymmetricOperatorComposition_coeff_one]
  exact sub_self _

theorem textbookSymmetricModifiedGenerator_coeff_two (X Y Z : R) :
    PowerSeries.coeff 2 (textbookSymmetricModifiedGenerator X Y Z) =
      textbookSymmetricOperatorCorrection X Y Z := by
  rw [textbookSymmetricModifiedGenerator, PowerSeries.coeff_mk,
    textbookFormalOperatorLogarithm_coeff_three _ (composition_constant_one X Y Z),
    textbookSymmetricOperatorComposition_coeff_three, textbookSymmetricOperatorComposition_coeff_two,
    textbookSymmetricOperatorComposition_coeff_one]
  simp only [smul_mul_assoc, mul_smul_comm, smul_add, smul_smul,
    pow_succ, pow_zero, one_mul, mul_assoc]
  module

theorem textbookSymmetricModifiedGenerator_coeff_three (X Y Z : R) :
    PowerSeries.coeff 3 (textbookSymmetricModifiedGenerator X Y Z) = 0 := by
  rw [textbookSymmetricModifiedGenerator, PowerSeries.coeff_mk,
    textbookFormalOperatorLogarithm_coeff_four _ (composition_constant_one X Y Z),
    textbookSymmetricOperatorComposition_coeff_four, textbookSymmetricOperatorComposition_coeff_three,
    textbookSymmetricOperatorComposition_coeff_two, textbookSymmetricOperatorComposition_coeff_one]
  simp only [smul_mul_assoc, mul_smul_comm, smul_add, smul_smul, mul_add, add_mul,
    pow_succ, pow_zero, one_mul, mul_assoc]
  module

/-- The exact formal fourth-order remainder factor, without an analytic convergence assertion. -/
theorem textbookSymmetricModifiedGenerator_formal_proposition71 (X Y Z : R) :
    ∃ Q : PowerSeries R, textbookSymmetricModifiedGenerator X Y Z =
      PowerSeries.C (X + Y + Z) +
        PowerSeries.C (textbookSymmetricOperatorCorrection X Y Z) * PowerSeries.X ^ 2 +
        PowerSeries.X ^ 4 * Q := by
  have hd : PowerSeries.X ^ 4 ∣ textbookSymmetricModifiedGenerator X Y Z -
      (PowerSeries.C (X + Y + Z) +
        PowerSeries.C (textbookSymmetricOperatorCorrection X Y Z) * PowerSeries.X ^ 2) := by
    rw [PowerSeries.X_pow_dvd_iff]
    intro n hn
    have hc0 : PowerSeries.constantCoeff (textbookSymmetricModifiedGenerator X Y Z) = X + Y + Z := by
      simpa only [PowerSeries.coeff_zero_eq_constantCoeff_apply] using
        textbookSymmetricModifiedGenerator_coeff_zero X Y Z
    interval_cases n <;> simp [hc0, textbookSymmetricModifiedGenerator_coeff_one,
      textbookSymmetricModifiedGenerator_coeff_two, textbookSymmetricModifiedGenerator_coeff_three,
      PowerSeries.coeff_X_pow]
  obtain ⟨Q, hQ⟩ := hd
  have he := sub_eq_iff_eq_add.mp hQ
  exact ⟨Q, by simpa only [add_comm] using he⟩

private theorem exp_coeff_zero
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    PowerSeries.coeff 0 (textbookFormalZeroConstantExponential P) = 1 := by
  simp [textbookFormalZeroConstantExponential, Finset.sum_range_succ]

private theorem exp_coeff_one
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    PowerSeries.coeff 1 (textbookFormalZeroConstantExponential P) = PowerSeries.coeff 1 P.val := by
  simp [textbookFormalZeroConstantExponential, Finset.sum_range_succ]

private theorem exp_coeff_two
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    PowerSeries.coeff 2 (textbookFormalZeroConstantExponential P) =
      PowerSeries.coeff 2 P.val + (1 / 2 : ℝ) • (PowerSeries.coeff 1 P.val) ^ 2 := by
  norm_num [textbookFormalZeroConstantExponential, Finset.sum_range_succ, pow_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, P.property]

private theorem exp_coeff_three
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    PowerSeries.coeff 3 (textbookFormalZeroConstantExponential P) =
      PowerSeries.coeff 3 P.val + (1 / 2 : ℝ) •
        (PowerSeries.coeff 1 P.val * PowerSeries.coeff 2 P.val +
          PowerSeries.coeff 2 P.val * PowerSeries.coeff 1 P.val) +
        (1 / 6 : ℝ) • (PowerSeries.coeff 1 P.val) ^ 3 := by
  norm_num [textbookFormalZeroConstantExponential, Finset.sum_range_succ, Nat.factorial_succ, pow_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, P.property, mul_add, add_mul, mul_assoc]

private theorem exp_coeff_four
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    PowerSeries.coeff 4 (textbookFormalZeroConstantExponential P) =
      PowerSeries.coeff 4 P.val + (1 / 2 : ℝ) •
        (PowerSeries.coeff 1 P.val * PowerSeries.coeff 3 P.val +
          (PowerSeries.coeff 2 P.val) ^ 2 + PowerSeries.coeff 3 P.val * PowerSeries.coeff 1 P.val) +
        (1 / 6 : ℝ) • ((PowerSeries.coeff 1 P.val) ^ 2 * PowerSeries.coeff 2 P.val +
          PowerSeries.coeff 1 P.val * PowerSeries.coeff 2 P.val * PowerSeries.coeff 1 P.val +
          PowerSeries.coeff 2 P.val * (PowerSeries.coeff 1 P.val) ^ 2) +
        (1 / 24 : ℝ) • (PowerSeries.coeff 1 P.val) ^ 4 := by
  norm_num [textbookFormalZeroConstantExponential, Finset.sum_range_succ, Nat.factorial_succ, pow_succ,
    PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ, P.property, mul_add, add_mul, mul_assoc]
  module

/-- The actual formal exponential of the actual formal logarithm. -/
noncomputable def textbookFormalLogarithmExponential (S : PowerSeries R) : PowerSeries R :=
  textbookFormalZeroConstantExponential ⟨textbookFormalOperatorLogarithm S, by
    rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply, log_coeff_zero]⟩

/-- The needed inverse identity is verified through the genuine degree-four jet. -/
theorem textbookFormalLogarithmExponential_coeff_matches
    (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1) (n : ℕ) (hn : n < 5) :
    PowerSeries.coeff n (textbookFormalLogarithmExponential S) = PowerSeries.coeff n S := by
  interval_cases n
  · rw [textbookFormalLogarithmExponential, exp_coeff_zero,
      PowerSeries.coeff_zero_eq_constantCoeff_apply, hS]
  · rw [textbookFormalLogarithmExponential, exp_coeff_one, textbookFormalOperatorLogarithm_coeff_one]
  · rw [textbookFormalLogarithmExponential, exp_coeff_two,
      textbookFormalOperatorLogarithm_coeff_two S hS, textbookFormalOperatorLogarithm_coeff_one]
    module
  · rw [textbookFormalLogarithmExponential, exp_coeff_three,
      textbookFormalOperatorLogarithm_coeff_three S hS,
      textbookFormalOperatorLogarithm_coeff_two S hS, textbookFormalOperatorLogarithm_coeff_one]
    simp only [mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
      smul_add, smul_sub, smul_smul, pow_succ, pow_zero, one_mul, mul_assoc]
    module
  · rw [textbookFormalLogarithmExponential, exp_coeff_four,
      textbookFormalOperatorLogarithm_coeff_four S hS, textbookFormalOperatorLogarithm_coeff_three S hS,
      textbookFormalOperatorLogarithm_coeff_two S hS, textbookFormalOperatorLogarithm_coeff_one]
    simp only [mul_add, add_mul, mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
      smul_add, smul_sub, smul_smul, pow_succ, pow_zero, one_mul, mul_assoc]
    module

/-- The full actual logarithm equals the time variable times the full shifted generator. -/
theorem textbookSymmetricModifiedGenerator_logarithm (X Y Z : R) :
    textbookFormalOperatorLogarithm (textbookSymmetricOperatorComposition X Y Z) =
      PowerSeries.X * textbookSymmetricModifiedGenerator X Y Z := by
  ext n
  cases n with
  | zero =>
    have hz : PowerSeries.constantCoeff
        (textbookFormalOperatorLogarithm (textbookSymmetricOperatorComposition X Y Z)) = 0 := by
      rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply, log_coeff_zero]
    simp [hz]
  | succ n =>
    simpa only [pow_one, textbookSymmetricModifiedGenerator, PowerSeries.coeff_mk] using
      (PowerSeries.coeff_X_pow_mul (textbookSymmetricModifiedGenerator X Y Z) 1 n).symm

/-- The actual formal exponential of X times the full modified generator. -/
noncomputable def textbookSymmetricGeneratorExponential (X Y Z : R) : PowerSeries R :=
  textbookFormalZeroConstantExponential ⟨PowerSeries.X * textbookSymmetricModifiedGenerator X Y Z,
    by simp⟩

/-- The exponentiated actual generator matches the original five factors through degree four. -/
theorem textbookSymmetricGeneratorExponential_coeff_matches (X Y Z : R) (n : ℕ) (hn : n < 5) :
    PowerSeries.coeff n (textbookSymmetricGeneratorExponential X Y Z) =
      PowerSeries.coeff n (textbookSymmetricOperatorComposition X Y Z) := by
  have he : textbookSymmetricGeneratorExponential X Y Z =
      textbookFormalLogarithmExponential (textbookSymmetricOperatorComposition X Y Z) := by
    unfold textbookSymmetricGeneratorExponential textbookFormalLogarithmExponential
    congr 1
    apply Subtype.ext
    exact (textbookSymmetricModifiedGenerator_logarithm X Y Z).symm
  rw [he]
  exact textbookFormalLogarithmExponential_coeff_matches _ (composition_constant_one X Y Z) n hn

end MolecularDynamics
