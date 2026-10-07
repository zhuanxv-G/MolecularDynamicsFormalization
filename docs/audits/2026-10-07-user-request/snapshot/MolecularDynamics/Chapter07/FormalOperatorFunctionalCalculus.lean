import MolecularDynamics.Chapter07.SymmetricOperatorBCH
import Mathlib.RingTheory.PowerSeries.Log
import Mathlib.RingTheory.PowerSeries.Trunc
import Mathlib.Algebra.Polynomial.AlgebraMap

/-! The necessary locally finite functional calculus for the full formal inverse in Proposition 7.1. -/

open scoped BigOperators PowerSeries

namespace MolecularDynamics

variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- Evaluation of a scalar formal series at an actual zero-constant noncommuting series. -/
noncomputable def textbookFormalOperatorCalculus
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (f : PowerSeries ℝ) : PowerSeries R :=
  PowerSeries.mk (fun j ↦ ∑ n ∈ Finset.range (j + 1),
    PowerSeries.coeff n f • PowerSeries.coeff j (P.val ^ n))

private theorem calculus_stable
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (f : PowerSeries ℝ) (j N : ℕ) (hj : j < N) :
    PowerSeries.coeff j (textbookFormalOperatorCalculus P f) =
      ∑ n ∈ Finset.range N, PowerSeries.coeff n f • PowerSeries.coeff j (P.val ^ n) := by
  rw [textbookFormalOperatorCalculus, PowerSeries.coeff_mk]
  apply Finset.sum_subset (Finset.range_mono (Nat.succ_le_of_lt hj))
  intro n _ hn
  have hnj : j + 1 ≤ n := Nat.le_of_not_gt (fun h ↦ hn (Finset.mem_range.mpr h))
  rw [textbookFormalZeroConstant_power_coeff_zero P j n
    ((Nat.lt_succ_self j).trans_le hnj), smul_zero]

private theorem calculus_trunc
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (f : PowerSeries ℝ) (j N : ℕ) (hj : j < N) :
    PowerSeries.coeff j (textbookFormalOperatorCalculus P f) =
      PowerSeries.coeff j (Polynomial.aeval P.val (PowerSeries.trunc N f)) := by
  rw [calculus_stable P f j N hj, Polynomial.aeval_def,
    PowerSeries.eval₂_trunc_eq_sum_range, map_sum]
  apply Finset.sum_congr rfl
  intro n _
  rw [Algebra.algebraMap_eq_smul_one, smul_mul_assoc, one_mul, PowerSeries.coeff_smul]

omit [Algebra ℝ R] in
private theorem jet_mul {N : ℕ} {a b c d : PowerSeries R}
    (hab : ∀ j < N, PowerSeries.coeff j a = PowerSeries.coeff j b)
    (hcd : ∀ j < N, PowerSeries.coeff j c = PowerSeries.coeff j d) :
    ∀ j < N, PowerSeries.coeff j (a * c) = PowerSeries.coeff j (b * d) := by
  intro j hj
  rw [PowerSeries.coeff_mul, PowerSeries.coeff_mul]
  apply Finset.sum_congr rfl
  intro k hk
  have he : k.1 + k.2 = j := Finset.mem_antidiagonal.mp hk
  rw [hab k.1 ((Nat.le.intro rfl : k.1 ≤ k.1 + k.2).trans_lt (he ▸ hj)),
    hcd k.2 ((Nat.le_add_left k.2 k.1).trans_lt (he ▸ hj))]

omit [Algebra ℝ R] in
private theorem power_mul_low_zero
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (Q : PowerSeries R) (j N : ℕ) (hj : j < N) :
    PowerSeries.coeff j (P.val ^ N * Q) = 0 := by
  rw [PowerSeries.coeff_mul]
  apply Finset.sum_eq_zero
  intro k hk
  have he : k.1 + k.2 = j := Finset.mem_antidiagonal.mp hk
  rw [textbookFormalZeroConstant_power_coeff_zero P k.1 N
    ((Nat.le.intro rfl : k.1 ≤ k.1 + k.2).trans_lt (he ▸ hj)), zero_mul]

private theorem aeval_jet
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (p q : Polynomial ℝ) (N : ℕ)
    (hpq : ∀ j < N, p.coeff j = q.coeff j) (j : ℕ) (hj : j < N) :
    PowerSeries.coeff j (Polynomial.aeval P.val p) =
      PowerSeries.coeff j (Polynomial.aeval P.val q) := by
  have hd : Polynomial.X ^ N ∣ p - q := by
    rw [Polynomial.X_pow_dvd_iff]
    intro k hk
    simp [hpq k hk]
  obtain ⟨w, hw⟩ := hd
  have he := congrArg (Polynomial.aeval P.val) hw
  simp only [map_sub, map_mul, map_pow, Polynomial.aeval_X] at he
  have hc := congrArg (PowerSeries.coeff j) he
  rw [map_sub, power_mul_low_zero P _ j N hj] at hc
  exact sub_eq_zero.mp hc

private theorem calculus_const
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) (c : ℝ) :
    textbookFormalOperatorCalculus P (PowerSeries.C c) = algebraMap ℝ (PowerSeries R) c := by
  ext j
  rw [calculus_trunc P _ j (j + 1) (Nat.lt_succ_self j), PowerSeries.trunc_C,
    Polynomial.aeval_C]

private theorem calculus_mul
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) (f g : PowerSeries ℝ) :
    textbookFormalOperatorCalculus P (f * g) =
      textbookFormalOperatorCalculus P f * textbookFormalOperatorCalculus P g := by
  ext j
  let N := j + 1
  have hj : j < N := Nat.lt_succ_self j
  rw [calculus_trunc P _ j N hj]
  trans PowerSeries.coeff j (Polynomial.aeval P.val
    (PowerSeries.trunc N f * PowerSeries.trunc N g))
  · apply aeval_jet P _ _ N _ j hj
    intro k hk
    rw [PowerSeries.coeff_trunc, ite_eq_left hk, Polynomial.coeff_mul, PowerSeries.coeff_mul]
    apply Finset.sum_congr rfl
    intro n hn
    have he : n.1 + n.2 = k := Finset.mem_antidiagonal.mp hn
    rw [PowerSeries.coeff_trunc, PowerSeries.coeff_trunc,
      ite_eq_left ((Nat.le.intro rfl : n.1 ≤ n.1 + n.2).trans_lt (he ▸ hk)),
      ite_eq_left ((Nat.le_add_left n.2 n.1).trans_lt (he ▸ hk))]
  · rw [map_mul]
    exact jet_mul (fun k hk ↦ (calculus_trunc P f k N hk).symm)
      (fun k hk ↦ (calculus_trunc P g k N hk).symm) j hj

/-- The genuine scalar-series evaluation is an algebra homomorphism; R need not commute. -/
noncomputable def textbookFormalOperatorCalculusHom
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    PowerSeries ℝ →ₐ[ℝ] PowerSeries R where
  toFun := textbookFormalOperatorCalculus P
  map_zero' := by ext j; simp [textbookFormalOperatorCalculus]
  map_one' := by simpa using calculus_const P 1
  map_add' f g := by
    ext j
    simp [textbookFormalOperatorCalculus, add_smul, Finset.sum_add_distrib]
  map_mul' := calculus_mul P
  commutes' c := by simpa using calculus_const P c

private theorem calculus_constant
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) (f : PowerSeries ℝ) :
    PowerSeries.constantCoeff (textbookFormalOperatorCalculusHom P f) =
      algebraMap ℝ R (PowerSeries.constantCoeff f) := by
  change PowerSeries.constantCoeff (textbookFormalOperatorCalculus P f) = _
  rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply]
  simp [textbookFormalOperatorCalculus, Algebra.algebraMap_eq_smul_one]

private theorem calculus_X
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    textbookFormalOperatorCalculusHom P PowerSeries.X = P.val := by
  ext j
  change PowerSeries.coeff j (textbookFormalOperatorCalculus P _) = _
  rw [calculus_trunc P _ j (j + 2) (by omega), PowerSeries.trunc_X, Polynomial.aeval_X]

private theorem calculus_source_jet
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (f g : PowerSeries ℝ) (N : ℕ)
    (hfg : ∀ j < N, PowerSeries.coeff j f = PowerSeries.coeff j g) :
    ∀ j < N, PowerSeries.coeff j (textbookFormalOperatorCalculusHom P f) =
      PowerSeries.coeff j (textbookFormalOperatorCalculusHom P g) := by
  intro j hj
  change PowerSeries.coeff j (textbookFormalOperatorCalculus P f) =
    PowerSeries.coeff j (textbookFormalOperatorCalculus P g)
  rw [calculus_stable P f j N hj, calculus_stable P g j N hj]
  exact Finset.sum_congr rfl (fun n hn ↦ by rw [hfg n (Finset.mem_range.mp hn)])

private theorem scalar_subst_trunc
    (g : {g : PowerSeries ℝ // PowerSeries.constantCoeff g = 0})
    (f : PowerSeries ℝ) (j N : ℕ) (hj : j < N) :
    PowerSeries.coeff j (f.subst g.val) =
      PowerSeries.coeff j (Polynomial.aeval g.val (PowerSeries.trunc N f)) := by
  rw [PowerSeries.coeff_subst' (PowerSeries.HasSubst.of_constantCoeff_zero' g.property),
    Polynomial.aeval_def, PowerSeries.eval₂_trunc_eq_sum_range, map_sum]
  trans ∑ n ∈ Finset.range N, PowerSeries.coeff n f • PowerSeries.coeff j (g.val ^ n)
  · apply finsum_eq_sum_of_support_subset
    intro n hn
    apply Finset.mem_range.mpr
    by_contra h
    have hz := textbookFormalZeroConstant_power_coeff_zero g j n
      (hj.trans_le (Nat.le_of_not_gt h))
    exact hn (by
      change PowerSeries.coeff n f • PowerSeries.coeff j (g.val ^ n) = 0
      rw [hz, smul_zero])
  · apply Finset.sum_congr rfl
    intro n _
    rw [Algebra.algebraMap_eq_smul_one, smul_mul_assoc, one_mul, PowerSeries.coeff_smul]

private theorem calculus_aeval
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (g : PowerSeries ℝ) (p : Polynomial ℝ) :
    textbookFormalOperatorCalculusHom P (Polynomial.aeval g p) =
      Polynomial.aeval (textbookFormalOperatorCalculusHom P g) p := by
  have he : (textbookFormalOperatorCalculusHom P).comp (Polynomial.aeval g) =
      Polynomial.aeval (textbookFormalOperatorCalculusHom P g) := by
    apply Polynomial.algHom_ext
    simp
  exact DFunLike.congr_fun he p

/-- Genuine nested evaluation agrees with actual scalar substitution at every degree. -/
theorem textbookFormalOperatorCalculus_subst
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (g : {g : PowerSeries ℝ // PowerSeries.constantCoeff g = 0}) (f : PowerSeries ℝ) :
    textbookFormalOperatorCalculusHom P (f.subst g.val) =
      textbookFormalOperatorCalculusHom
        ⟨textbookFormalOperatorCalculusHom P g.val, by
          rw [calculus_constant, g.property, map_zero]⟩ f := by
  ext j
  let N := j + 1
  have hj : j < N := Nat.lt_succ_self j
  trans PowerSeries.coeff j (textbookFormalOperatorCalculusHom P
    (Polynomial.aeval g.val (PowerSeries.trunc N f)))
  · apply calculus_source_jet P _ _ N _ j hj
    intro k hk
    exact scalar_subst_trunc g f k N hk
  · rw [calculus_aeval]
    exact (calculus_trunc
      ⟨textbookFormalOperatorCalculusHom P g.val, by
        rw [calculus_constant, g.property, map_zero]⟩ f j N hj).symm

/-- Evaluation of the actual scalar exponential is the actual locally finite exponential. -/
theorem textbookFormalOperatorCalculus_exp
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    textbookFormalOperatorCalculusHom P (PowerSeries.exp ℝ) =
      textbookFormalZeroConstantExponential P := by
  ext j
  simp [textbookFormalOperatorCalculusHom, textbookFormalOperatorCalculus,
    textbookFormalZeroConstantExponential, PowerSeries.coeff_exp]

/-- Evaluation of the actual scalar log(1+X) is the actual noncommuting log(1+P). -/
theorem textbookFormalOperatorCalculus_log
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    textbookFormalOperatorCalculusHom P (PowerSeries.log ℝ) =
      textbookFormalOperatorLogarithm (1 + P.val) := by
  ext j
  change PowerSeries.coeff j (textbookFormalOperatorCalculus P _) = _
  simp only [textbookFormalOperatorCalculus, textbookFormalOperatorLogarithm,
    PowerSeries.coeff_mk, add_sub_cancel_left]
  apply Finset.sum_congr rfl
  intro n _
  by_cases hn : n = 0
  · simp [hn]
  · simp [PowerSeries.coeff_log, hn]
    norm_cast

/-- The full noncommuting exp/log inverse, with the constant term actually one. -/
theorem textbookFormalLogarithmExponential_eq
    (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1) :
    textbookFormalLogarithmExponential S = S := by
  let P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0} :=
    ⟨S - 1, by rw [map_sub, hS, map_one, sub_self]⟩
  let Q : {Q : PowerSeries R // PowerSeries.constantCoeff Q = 0} :=
    ⟨textbookFormalOperatorCalculusHom P (PowerSeries.log ℝ), by
      rw [calculus_constant, PowerSeries.constantCoeff_log, map_zero]⟩
  have he : textbookFormalOperatorCalculusHom P
      ((PowerSeries.exp ℝ).subst (PowerSeries.log ℝ)) =
        textbookFormalZeroConstantExponential Q := by
    rw [textbookFormalOperatorCalculus_subst P
      ⟨PowerSeries.log ℝ, PowerSeries.constantCoeff_log⟩, textbookFormalOperatorCalculus_exp]
  rw [PowerSeries.subst_exp_log, map_add, map_one, calculus_X] at he
  have hQ : Q.val = textbookFormalOperatorLogarithm S := by
    change textbookFormalOperatorCalculusHom P (PowerSeries.log ℝ) = _
    rw [textbookFormalOperatorCalculus_log]
    congr 1
    dsimp [P]
    noncomm_ring
  have hx : textbookFormalZeroConstantExponential Q = textbookFormalLogarithmExponential S := by
    unfold textbookFormalLogarithmExponential
    congr 1
    exact Subtype.ext hQ
  rw [hx] at he
  have hp : 1 + P.val = S := by dsimp [P]; noncomm_ring
  exact he.symm.trans hp

/-- The other full inverse derives the actual logarithm of a zero-constant exponential. -/
theorem textbookFormalOperatorLogarithm_exp
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    textbookFormalOperatorLogarithm (textbookFormalZeroConstantExponential P) = P.val := by
  let Q : {Q : PowerSeries R // PowerSeries.constantCoeff Q = 0} :=
    ⟨textbookFormalOperatorCalculusHom P (PowerSeries.exp ℝ - 1), by
      rw [calculus_constant, map_sub, PowerSeries.constantCoeff_exp, map_one, sub_self, map_zero]⟩
  have he : textbookFormalOperatorCalculusHom P
      ((PowerSeries.log ℝ).subst (PowerSeries.exp ℝ - 1)) =
        textbookFormalOperatorLogarithm (1 + Q.val) := by
    rw [textbookFormalOperatorCalculus_subst P
      ⟨PowerSeries.exp ℝ - 1, by simp⟩, textbookFormalOperatorCalculus_log]
  rw [PowerSeries.subst_log_exp_sub_one, calculus_X] at he
  have hq : 1 + Q.val = textbookFormalZeroConstantExponential P := by
    dsimp [Q]
    rw [map_sub, map_one, textbookFormalOperatorCalculus_exp]
    noncomm_ring
  rw [hq] at he
  exact he.symm

/-- The original five factors equal the actual generator exponential at every order. -/
theorem textbookSymmetricGeneratorExponential_eq (X Y Z : R) :
    textbookSymmetricGeneratorExponential X Y Z =
      textbookSymmetricOperatorComposition X Y Z := by
  have he : textbookSymmetricGeneratorExponential X Y Z =
      textbookFormalLogarithmExponential (textbookSymmetricOperatorComposition X Y Z) := by
    unfold textbookSymmetricGeneratorExponential textbookFormalLogarithmExponential
    congr 1
    apply Subtype.ext
    exact (textbookSymmetricModifiedGenerator_logarithm X Y Z).symm
  rw [he]
  apply textbookFormalLogarithmExponential_eq
  rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply,
    textbookSymmetricOperatorComposition_coeff_zero]

/-- Genuine time reversal on noncommuting operator series, preserving multiplication order. -/
noncomputable def textbookFormalOperatorTimeNeg : PowerSeries R →ₐ[ℝ] PowerSeries R where
  toFun f := PowerSeries.mk (fun n ↦ (-1 : ℝ) ^ n • PowerSeries.coeff n f)
  map_zero' := by ext n; simp
  map_one' := by ext n; by_cases hn : n = 0 <;> simp [hn]
  map_add' f g := by ext n; simp [smul_add]
  map_mul' f g := by
    ext n
    rw [PowerSeries.coeff_mk, PowerSeries.coeff_mul, PowerSeries.coeff_mul, Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro k hk
    have he : k.1 + k.2 = n := Finset.mem_antidiagonal.mp hk
    simp only [PowerSeries.coeff_mk, smul_mul_assoc, mul_smul_comm, smul_smul, ← pow_add]
    rw [Nat.add_comm k.2 k.1, he]
  commutes' c := by
    ext n
    by_cases hn : n = 0 <;>
      simp [Algebra.algebraMap_eq_smul_one, hn]

private theorem timeNeg_coeff (f : PowerSeries R) (n : ℕ) :
    PowerSeries.coeff n (textbookFormalOperatorTimeNeg f) =
      (-1 : ℝ) ^ n • PowerSeries.coeff n f := by
  change PowerSeries.coeff n (PowerSeries.mk (fun n ↦ (-1 : ℝ) ^ n • PowerSeries.coeff n f)) = _
  rw [PowerSeries.coeff_mk]

private theorem timeNeg_constant (f : PowerSeries R) :
    PowerSeries.constantCoeff (textbookFormalOperatorTimeNeg f) = PowerSeries.constantCoeff f := by
  rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply,
    timeNeg_coeff, pow_zero, one_smul, PowerSeries.coeff_zero_eq_constantCoeff_apply]

private theorem calculus_rescale
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0})
    (f : PowerSeries ℝ) (c : ℝ) :
    textbookFormalOperatorCalculusHom P (PowerSeries.rescale c f) =
      textbookFormalOperatorCalculusHom ⟨c • P.val, by simp [P.property]⟩ f := by
  ext j
  change PowerSeries.coeff j (textbookFormalOperatorCalculus P _) =
    PowerSeries.coeff j (textbookFormalOperatorCalculus _ _)
  simp [textbookFormalOperatorCalculus, PowerSeries.coeff_rescale,
    smul_pow, smul_smul, mul_comm]

/-- Genuine formal exponentials of opposite generators are inverses. -/
theorem textbookFormalZeroConstantExponential_mul_neg
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    textbookFormalZeroConstantExponential P *
      textbookFormalZeroConstantExponential ⟨-P.val, by simp [P.property]⟩ = 1 := by
  have he := congrArg (textbookFormalOperatorCalculusHom P)
    (PowerSeries.exp_mul_exp_neg_eq_one (A := ℝ))
  rw [map_mul, map_one, textbookFormalOperatorCalculus_exp] at he
  change textbookFormalZeroConstantExponential P *
    textbookFormalOperatorCalculusHom P (PowerSeries.rescale (-1) (PowerSeries.exp ℝ)) = 1 at he
  rw [calculus_rescale, textbookFormalOperatorCalculus_exp] at he
  simpa only [neg_one_smul] using he

private theorem calculus_timeNeg
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) (f : PowerSeries ℝ) :
    textbookFormalOperatorTimeNeg (textbookFormalOperatorCalculusHom P f) =
      textbookFormalOperatorCalculusHom
        ⟨textbookFormalOperatorTimeNeg P.val, by rw [timeNeg_constant, P.property]⟩ f := by
  ext j
  rw [timeNeg_coeff]
  change (-1 : ℝ) ^ j • PowerSeries.coeff j (textbookFormalOperatorCalculus P f) =
    PowerSeries.coeff j (textbookFormalOperatorCalculus _ f)
  simp only [textbookFormalOperatorCalculus, PowerSeries.coeff_mk, Finset.smul_sum,
    ← map_pow, timeNeg_coeff, smul_smul, mul_comm]

private theorem exponential_timeNeg
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) :
    textbookFormalOperatorTimeNeg (textbookFormalZeroConstantExponential P) =
      textbookFormalZeroConstantExponential
        ⟨textbookFormalOperatorTimeNeg P.val, by rw [timeNeg_constant, P.property]⟩ := by
  rw [← textbookFormalOperatorCalculus_exp P, calculus_timeNeg,
    textbookFormalOperatorCalculus_exp]

private theorem calculus_log_unit
    (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1) :
    textbookFormalOperatorCalculusHom
      ⟨S - 1, by rw [map_sub, hS, map_one, sub_self]⟩ (PowerSeries.log ℝ) =
        textbookFormalOperatorLogarithm S := by
  rw [textbookFormalOperatorCalculus_log]
  congr 1
  noncomm_ring

private theorem logarithm_timeNeg
    (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1) :
    textbookFormalOperatorTimeNeg (textbookFormalOperatorLogarithm S) =
      textbookFormalOperatorLogarithm (textbookFormalOperatorTimeNeg S) := by
  rw [← calculus_log_unit S hS, calculus_timeNeg, textbookFormalOperatorCalculus_log]
  congr 1
  simp only [map_sub, map_one]
  noncomm_ring

private theorem linear_generator_exp (A : R) :
    textbookFormalZeroConstantExponential ⟨PowerSeries.C A * PowerSeries.X, by simp⟩ =
      textbookFormalOperatorExponential A := by
  have hp (n : ℕ) : (PowerSeries.C A * PowerSeries.X) ^ n =
      PowerSeries.C (A ^ n) * PowerSeries.X ^ n := by
    rw [(PowerSeries.commute_X (PowerSeries.C A)).mul_pow, map_pow]
  ext j
  rw [textbookFormalZeroConstantExponential, PowerSeries.coeff_mk,
    textbookFormalOperatorExponential_coeff]
  simp only [hp, PowerSeries.coeff_C_mul, PowerSeries.coeff_X_pow]
  rw [Finset.sum_eq_single j]
  · simp
  · intro n _ hnj
    simp [Ne.symm hnj]
  · simp

/-- Actual linear operator exponentials and their negatives cancel at all orders. -/
theorem textbookFormalOperatorExponential_mul_neg (A : R) :
    textbookFormalOperatorExponential A * textbookFormalOperatorExponential (-A) = 1 := by
  have he := textbookFormalZeroConstantExponential_mul_neg
    ⟨PowerSeries.C A * PowerSeries.X, by simp⟩
  have hn : -(PowerSeries.C A * PowerSeries.X) = PowerSeries.C (-A) * PowerSeries.X := by simp
  simpa only [hn, linear_generator_exp] using he

private theorem operator_exp_timeNeg (A : R) :
    textbookFormalOperatorTimeNeg (textbookFormalOperatorExponential A) =
      textbookFormalOperatorExponential (-A) := by
  ext n
  rw [timeNeg_coeff, textbookFormalOperatorExponential_coeff,
    textbookFormalOperatorExponential_coeff, ← neg_one_smul ℝ A, smul_pow, smul_smul]
  rw [smul_smul]
  congr 1
  exact mul_comm _ _

private theorem operator_exp_neg_cancel (A : R) (Q : PowerSeries R) :
    textbookFormalOperatorExponential A * (textbookFormalOperatorExponential (-A) * Q) = Q := by
  rw [← mul_assoc, textbookFormalOperatorExponential_mul_neg, one_mul]

/-- The literal palindrome at negative time is the actual inverse product. -/
theorem textbookSymmetricOperatorComposition_inverse (X Y Z : R) :
    textbookSymmetricOperatorComposition X Y Z *
      textbookSymmetricOperatorComposition (-X) (-Y) (-Z) = 1 := by
  simp only [textbookSymmetricOperatorComposition, smul_neg, mul_assoc,
    operator_exp_neg_cancel, textbookFormalOperatorExponential_mul_neg]

private theorem composition_timeNeg (X Y Z : R) :
    textbookFormalOperatorTimeNeg (textbookSymmetricOperatorComposition X Y Z) =
      textbookSymmetricOperatorComposition (-X) (-Y) (-Z) := by
  simp only [textbookSymmetricOperatorComposition, map_mul, operator_exp_timeNeg, smul_neg]

private theorem log_constant_unit (S : PowerSeries R) (hS : PowerSeries.constantCoeff S = 1) :
    PowerSeries.constantCoeff (textbookFormalOperatorLogarithm S) = 0 := by
  rw [← calculus_log_unit S hS, calculus_constant, PowerSeries.constantCoeff_log, map_zero]

/-- The full logarithm of the actual symmetric composition is odd in time. -/
theorem textbookSymmetricOperatorLogarithm_timeNeg (X Y Z : R) :
    textbookFormalOperatorTimeNeg
        (textbookFormalOperatorLogarithm (textbookSymmetricOperatorComposition X Y Z)) =
      -textbookFormalOperatorLogarithm (textbookSymmetricOperatorComposition X Y Z) := by
  let S := textbookSymmetricOperatorComposition X Y Z
  have hS : PowerSeries.constantCoeff S = 1 := by
    rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply,
      textbookSymmetricOperatorComposition_coeff_zero]
  let L : {L : PowerSeries R // PowerSeries.constantCoeff L = 0} :=
    ⟨textbookFormalOperatorLogarithm S, log_constant_unit S hS⟩
  have hExp : textbookFormalZeroConstantExponential L = S :=
    textbookFormalLogarithmExponential_eq S hS
  have hInverse : S * textbookFormalZeroConstantExponential ⟨-L.val, by simp [L.property]⟩ = 1 := by
    rw [← hExp]
    exact textbookFormalZeroConstantExponential_mul_neg L
  have hleft : textbookFormalOperatorTimeNeg S * S = 1 := by
    rw [composition_timeNeg]
    simpa only [neg_neg] using textbookSymmetricOperatorComposition_inverse (-X) (-Y) (-Z)
  have he : textbookFormalZeroConstantExponential ⟨-L.val, by simp [L.property]⟩ =
      textbookFormalOperatorTimeNeg S := by
    calc
      _ = 1 * textbookFormalZeroConstantExponential ⟨-L.val, by simp [L.property]⟩ := by simp
      _ = (textbookFormalOperatorTimeNeg S * S) *
          textbookFormalZeroConstantExponential ⟨-L.val, by simp [L.property]⟩ := by rw [hleft]
      _ = textbookFormalOperatorTimeNeg S *
          (S * textbookFormalZeroConstantExponential ⟨-L.val, by simp [L.property]⟩) := mul_assoc _ _ _
      _ = textbookFormalOperatorTimeNeg S := by rw [hInverse, mul_one]
  change textbookFormalOperatorTimeNeg (textbookFormalOperatorLogarithm S) = -L.val
  rw [logarithm_timeNeg S hS, ← he, textbookFormalOperatorLogarithm_exp]

/-- Every odd-degree correction to the actual modified generator vanishes. -/
theorem textbookSymmetricModifiedGenerator_odd_coeff_zero (X Y Z : R) (n : ℕ) :
    PowerSeries.coeff (2 * n + 1) (textbookSymmetricModifiedGenerator X Y Z) = 0 := by
  have he := congrArg (PowerSeries.coeff (2 * (n + 1)))
    (textbookSymmetricOperatorLogarithm_timeNeg X Y Z)
  rw [timeNeg_coeff, map_neg] at he
  have hp : (-1 : ℝ) ^ (2 * (n + 1)) = 1 := by rw [pow_mul]; norm_num
  rw [hp, one_smul] at he
  have hz : (2 : ℝ) • PowerSeries.coeff (2 * (n + 1))
      (textbookFormalOperatorLogarithm (textbookSymmetricOperatorComposition X Y Z)) = 0 := by
    rw [two_smul]
    exact add_eq_zero_iff_eq_neg.mpr he
  have hc := (smul_eq_zero.mp hz).resolve_left (by norm_num)
  rw [textbookSymmetricModifiedGenerator, PowerSeries.coeff_mk]
  convert! hc using 2

end MolecularDynamics
