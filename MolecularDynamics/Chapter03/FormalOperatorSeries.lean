import Mathlib.Basic.Real.Basic
import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.Tactic.Module
import Mathlib.Tactic.NoncommRing
import Mathlib.Tactic.IntervalCases

/-!
# Noncommuting formal operator exponentials

Printed103--105/PDF125--127, §3.3.  The coefficient algebra is associative
and may be noncommutative.  These are genuine formal power series and their
finite coefficient identities, with no analytic convergence assertion.
-/

open scoped BigOperators PowerSeries

namespace MolecularDynamics

variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- The genuine formal series for exp(X A), defined coefficientwise. -/
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)

theorem textbookFormalOperatorExponential_coeff (A : R) (n : ℕ) :
    PowerSeries.coeff n (textbookFormalOperatorExponential A) =
      (1 / (n.factorial : ℝ)) • A ^ n := by
  rw [textbookFormalOperatorExponential, PowerSeries.coeff_mk]

private theorem exponential_coeff_zero (A : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A) = 1 := by
  simp [textbookFormalOperatorExponential_coeff]

private theorem exponential_coeff_one (A : R) :
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A) = A := by
  simp [textbookFormalOperatorExponential_coeff]

private theorem exponential_coeff_two (A : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A) = (1 / 2 : ℝ) • A ^ 2 := by
  norm_num [textbookFormalOperatorExponential_coeff, Nat.factorial_succ]

private theorem exponential_coeff_three (A : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A) = (1 / 6 : ℝ) • A ^ 3 := by
  norm_num [textbookFormalOperatorExponential_coeff, Nat.factorial_succ]

/-- Actual Cauchy-product coefficients of exp(X A) exp(X B). -/
theorem textbookFormalOperatorProduct_coeff_zero (A B : R) :
    PowerSeries.coeff 0
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) = 1 := by
  simp [PowerSeries.coeff_mul, exponential_coeff_zero]

theorem textbookFormalOperatorProduct_coeff_one (A B : R) :
    PowerSeries.coeff 1
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) = A + B := by
  simp [PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    exponential_coeff_zero, exponential_coeff_one, add_comm]

theorem textbookFormalOperatorProduct_coeff_two (A B : R) :
    PowerSeries.coeff 2
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      (1 / 2 : ℝ) • A ^ 2 + A * B + (1 / 2 : ℝ) • B ^ 2 := by
  simp only [PowerSeries.coeff_mul]
  norm_num [Finset.Nat.antidiagonal_succ,
    exponential_coeff_zero, exponential_coeff_one, exponential_coeff_two]
  module

theorem textbookFormalOperatorProduct_coeff_three (A B : R) :
    PowerSeries.coeff 3
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      (1 / 6 : ℝ) • A ^ 3 + (1 / 2 : ℝ) • (A ^ 2 * B) +
        (1 / 2 : ℝ) • (A * B ^ 2) + (1 / 6 : ℝ) • B ^ 3 := by
  simp only [PowerSeries.coeff_mul]
  norm_num [Finset.Nat.antidiagonal_succ,
    exponential_coeff_zero, exponential_coeff_one, exponential_coeff_two,
    exponential_coeff_three, smul_mul_assoc, mul_smul_comm]
  module

/-- The leading formal difference is exactly half the noncommuting commutator. -/
theorem textbookFormalOperatorDifference_coeff_two (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A) := by
  rw [map_sub, textbookFormalOperatorProduct_coeff_two, exponential_coeff_two]
  have hs : (A + B) ^ 2 = A ^ 2 + A * B + B * A + B ^ 2 := by noncomm_ring
  rw [hs]
  module

/-- The exact degree-three coefficient displayed on printed104/PDF126. -/
theorem textbookFormalOperatorDifference_coeff_three (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  rw [map_sub, textbookFormalOperatorProduct_coeff_three, exponential_coeff_three]
  have hc : (A + B) ^ 3 = A ^ 3 + A ^ 2 * B + A * B ^ 2 + A * B * A +
      B ^ 2 * A + B * A ^ 2 + B * A * B + B ^ 3 := by noncomm_ring
  rw [hc]
  module

omit [Algebra ℝ R] in
/-- The high powers really vanish below their degree, even in a noncommuting ring. -/
theorem textbookFormalZeroConstant_power_coeff_zero
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (j n : ℕ) (hjn : j < n) : PowerSeries.coeff j (P.val ^ n) = 0 := by
  induction n generalizing j with
  | zero => exact (Nat.not_lt_zero j hjn).elim
  | succ n ih =>
    rw [pow_succ, PowerSeries.coeff_mul]
    apply Finset.sum_eq_zero
    intro p hp
    have hadd : p.1 + p.2 = j := Finset.mem_antidiagonal.mp hp
    by_cases hp2 : p.2 = 0
    · simp [hp2, PowerSeries.coeff_zero_eq_constantCoeff_apply, P.property]
    · have hp1 : p.1 < j := by
        rw [← hadd]
        exact Nat.lt_add_of_pos_right (Nat.pos_of_ne_zero hp2)
      rw [ih p.1 (hp1.trans_le (Nat.lt_succ_iff.mp hjn)), zero_mul]

/-- For a zero-constant generator, each formal exponential coefficient is a
finite sum: powers above its degree contribute zero. -/
noncomputable def textbookFormalZeroConstantExponential
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) : PowerSeries R :=
  PowerSeries.mk (fun j => ∑ n ∈ Finset.range (j + 1),
    (1 / (n.factorial : ℝ)) • PowerSeries.coeff j (P.val ^ n))

/-- Each formal coefficient agrees with every sufficiently long exponential
partial sum; there is no convergence assumption on scalar step size. -/
theorem textbookFormalZeroConstantExponential_coeff_stabilizes
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (j N : ℕ) (hjN : j < N) :
    PowerSeries.coeff j (textbookFormalZeroConstantExponential P) =
      ∑ n ∈ Finset.range N, (1 / (n.factorial : ℝ)) • PowerSeries.coeff j (P.val ^ n) := by
  rw [textbookFormalZeroConstantExponential, PowerSeries.coeff_mk]
  apply Finset.sum_subset (Finset.range_mono (Nat.succ_le_of_lt hjN))
  intro n _ hn
  have hnj : j + 1 ≤ n := Nat.le_of_not_gt (fun h => hn (Finset.mem_range.mpr h))
  rw [textbookFormalZeroConstant_power_coeff_zero P j n
    ((Nat.lt_succ_self j).trans_le hnj), smul_zero]

private noncomputable def modifiedGenerator (A B C : R) : PowerSeries R :=
  PowerSeries.C (A + B) * PowerSeries.X + PowerSeries.C C * PowerSeries.X ^ 2

omit [Algebra ℝ R] in
private theorem modifiedGenerator_zero (A B C : R) :
    PowerSeries.constantCoeff (modifiedGenerator A B C) = 0 := by
  simp [modifiedGenerator]

/-- Formal exp(X(A+B)+X²C), with the genuine zero-constant generator. -/
noncomputable def textbookFormalModifiedExponential (A B C : R) : PowerSeries R :=
  textbookFormalZeroConstantExponential
    ⟨modifiedGenerator A B C, modifiedGenerator_zero A B C⟩

omit [Algebra ℝ R] in
private theorem modifiedGenerator_coeff_zero (A B C : R) :
    PowerSeries.coeff 0 (modifiedGenerator A B C) = 0 := by
  simp [modifiedGenerator]

omit [Algebra ℝ R] in
private theorem modifiedGenerator_coeff_one (A B C : R) :
    PowerSeries.coeff 1 (modifiedGenerator A B C) = A + B := by
  simp [modifiedGenerator, PowerSeries.coeff_X_pow]

omit [Algebra ℝ R] in
private theorem modifiedGenerator_coeff_two (A B C : R) :
    PowerSeries.coeff 2 (modifiedGenerator A B C) = C := by
  simp [modifiedGenerator, PowerSeries.coeff_X_pow]

theorem textbookFormalModifiedExponential_coeff_zero (A B C : R) :
    PowerSeries.coeff 0 (textbookFormalModifiedExponential A B C) = 1 := by
  simp [textbookFormalModifiedExponential, textbookFormalZeroConstantExponential,
    Finset.sum_range_succ]

theorem textbookFormalModifiedExponential_coeff_one (A B C : R) :
    PowerSeries.coeff 1 (textbookFormalModifiedExponential A B C) = A + B := by
  simp [textbookFormalModifiedExponential, textbookFormalZeroConstantExponential,
    Finset.sum_range_succ, modifiedGenerator_coeff_one]

theorem textbookFormalModifiedExponential_coeff_two (A B C : R) :
    PowerSeries.coeff 2 (textbookFormalModifiedExponential A B C) =
      C + (1 / 2 : ℝ) • (A + B) ^ 2 := by
  simp [textbookFormalModifiedExponential, textbookFormalZeroConstantExponential,
    Finset.sum_range_succ, PowerSeries.coeff_mul, pow_two,
    Finset.Nat.antidiagonal_succ,
    modifiedGenerator_coeff_zero, modifiedGenerator_coeff_one, modifiedGenerator_coeff_two]

/-- The half-commutator correction matches all formal coefficients below degree three. -/
theorem textbookFormalModifiedExponential_matches_product (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
  interval_cases n
  · rw [textbookFormalOperatorProduct_coeff_zero, textbookFormalModifiedExponential_coeff_zero]
  · rw [textbookFormalOperatorProduct_coeff_one, textbookFormalModifiedExponential_coeff_one]
  · rw [textbookFormalOperatorProduct_coeff_two, textbookFormalModifiedExponential_coeff_two]
    have hs : (A + B) ^ 2 = A ^ 2 + A * B + B * A + B ^ 2 := by noncomm_ring
    rw [hs]
    module

end MolecularDynamics
