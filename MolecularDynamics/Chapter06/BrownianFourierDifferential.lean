import MolecularDynamics.Chapter06.BrownianVariance
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv

/-! Literal Fourier-phase coordinate derivatives, needed for the Haar Poincare proof. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators

namespace MolecularDynamics

/-- The actual linear phase 2π∑ n_i q_i as a continuous real linear map. -/
noncomputable def textbookFourierPhase {Nc : ℕ} (n : Fin Nc → ℤ) :
    (Fin Nc → ℝ) →L[ℝ] ℝ :=
  (2 * Real.pi) • ∑ i, (n i : ℝ) • ContinuousLinearMap.proj i

/-- The actual Fourier phase has the literal original coordinate sum. -/
theorem textbookFourierPhase_apply {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    textbookFourierPhase n q = 2 * Real.pi * ∑ i, (n i : ℝ) * q i := by
  simp [textbookFourierPhase, smul_eq_mul]

/-- The actual phase applied to an original coordinate basis vector is exactly 2π n_i. -/
theorem textbookFourierPhase_single {Nc : ℕ} (n : Fin Nc → ℤ) (i : Fin Nc) :
    textbookFourierPhase n (Pi.single i 1) = 2 * Real.pi * (n i : ℝ) := by
  classical
  simp [textbookFourierPhase, smul_eq_mul, Pi.single_apply]

/-- The literal real cosine lift of the original Fourier phase. -/
noncomputable def textbookFourierCosineLift {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) : ℝ :=
  Real.cos (textbookFourierPhase n q)

/-- The literal real sine lift of the original Fourier phase. -/
noncomputable def textbookFourierSineLift {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) : ℝ :=
  Real.sin (textbookFourierPhase n q)

/-- The actual cosine lift is smooth on the original full Euclidean configuration space. -/
theorem textbookFourierCosineLift_contDiff {Nc : ℕ} (n : Fin Nc → ℤ) :
    ContDiff ℝ ∞ (textbookFourierCosineLift n) :=
  Real.contDiff_cos.comp (textbookFourierPhase n).contDiff

/-- The actual sine lift is smooth on the original full Euclidean configuration space. -/
theorem textbookFourierSineLift_contDiff {Nc : ℕ} (n : Fin Nc → ℤ) :
    ContDiff ℝ ∞ (textbookFourierSineLift n) :=
  Real.contDiff_sin.comp (textbookFourierPhase n).contDiff

/-- The genuine Frechet derivative of the actual cosine-phase lift. -/
theorem textbookFourierCosineLift_hasFDerivAt {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    HasFDerivAt (textbookFourierCosineLift n)
      (-Real.sin (textbookFourierPhase n q) • textbookFourierPhase n) q :=
  (Real.hasDerivAt_cos (textbookFourierPhase n q)).comp_hasFDerivAt q
    (textbookFourierPhase n).hasFDerivAt

/-- The genuine Frechet derivative of the actual sine-phase lift. -/
theorem textbookFourierSineLift_hasFDerivAt {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    HasFDerivAt (textbookFourierSineLift n)
      (Real.cos (textbookFourierPhase n q) • textbookFourierPhase n) q :=
  (Real.hasDerivAt_sin (textbookFourierPhase n q)).comp_hasFDerivAt q
    (textbookFourierPhase n).hasFDerivAt

/-- The literal original coordinate partial of the cosine lift. -/
theorem textbookFourierCosineLift_partial {Nc : ℕ} (n : Fin Nc → ℤ) (i : Fin Nc) :
    textbookConfigurationPartial (textbookFourierCosineLift n) i =
      fun q ↦ -(2 * Real.pi * (n i : ℝ)) * textbookFourierSineLift n q := by
  funext q
  unfold textbookConfigurationPartial
  rw [(textbookFourierCosineLift_hasFDerivAt n q).fderiv,
    smul_apply, textbookFourierPhase_single]
  simp only [smul_eq_mul]
  unfold textbookFourierSineLift
  ring

/-- The literal original coordinate partial of the sine lift. -/
theorem textbookFourierSineLift_partial {Nc : ℕ} (n : Fin Nc → ℤ) (i : Fin Nc) :
    textbookConfigurationPartial (textbookFourierSineLift n) i =
      fun q ↦ (2 * Real.pi * (n i : ℝ)) * textbookFourierCosineLift n q := by
  funext q
  unfold textbookConfigurationPartial
  rw [(textbookFourierSineLift_hasFDerivAt n q).fderiv,
    smul_apply, textbookFourierPhase_single]
  simp only [smul_eq_mul]
  unfold textbookFourierCosineLift
  ring

/-- The original integer-lattice phase shift is an actual integer multiple of 2π. -/
theorem textbookFourierPhase_integer_apply {Nc : ℕ} (n z : Fin Nc → ℤ) :
    textbookFourierPhase n (fun i ↦ (z i : ℝ)) =
      ((∑ i, n i * z i : ℤ) : ℝ) * (2 * Real.pi) := by
  rw [textbookFourierPhase_apply]
  push_cast
  ring

/-- The literal cosine Fourier lift is periodic under the full original integer lattice. -/
theorem textbookFourierCosineLift_periodic {Nc : ℕ} (n : Fin Nc → ℤ) :
    textbookUnitPeriodicPotential (textbookFourierCosineLift n) := by
  intro q z
  change Real.cos (textbookFourierPhase n (q + fun i ↦ (z i : ℝ))) =
    Real.cos (textbookFourierPhase n q)
  rw [(textbookFourierPhase n).map_add, textbookFourierPhase_integer_apply]
  exact Real.cos_add_int_mul_two_pi _ _

/-- The literal sine Fourier lift is periodic under the full original integer lattice. -/
theorem textbookFourierSineLift_periodic {Nc : ℕ} (n : Fin Nc → ℤ) :
    textbookUnitPeriodicPotential (textbookFourierSineLift n) := by
  intro q z
  change Real.sin (textbookFourierPhase n (q + fun i ↦ (z i : ℝ))) =
    Real.sin (textbookFourierPhase n q)
  rw [(textbookFourierPhase n).map_add, textbookFourierPhase_integer_apply]
  exact Real.sin_add_int_mul_two_pi _ _

/-- The actual second original coordinate partial of the cosine Fourier lift. -/
theorem textbookFourierCosineLift_second_partial {Nc : ℕ} (n : Fin Nc → ℤ) (i : Fin Nc) :
    textbookConfigurationPartial
      (textbookConfigurationPartial (textbookFourierCosineLift n) i) i =
      fun q ↦ -(2 * Real.pi * (n i : ℝ)) ^ 2 * textbookFourierCosineLift n q := by
  rw [textbookFourierCosineLift_partial]
  change textbookConfigurationPartial (-(2 * Real.pi * (n i : ℝ)) • textbookFourierSineLift n) i =
    fun q ↦ -(2 * Real.pi * (n i : ℝ)) ^ 2 * textbookFourierCosineLift n q
  rw [textbookConfigurationPartial_smul _ (textbookFourierSineLift_contDiff n),
    textbookFourierSineLift_partial]
  funext q
  simp only [Pi.smul_apply, smul_eq_mul]
  ring

/-- The actual second original coordinate partial of the sine Fourier lift. -/
theorem textbookFourierSineLift_second_partial {Nc : ℕ} (n : Fin Nc → ℤ) (i : Fin Nc) :
    textbookConfigurationPartial
      (textbookConfigurationPartial (textbookFourierSineLift n) i) i =
      fun q ↦ -(2 * Real.pi * (n i : ℝ)) ^ 2 * textbookFourierSineLift n q := by
  rw [textbookFourierSineLift_partial]
  change textbookConfigurationPartial ((2 * Real.pi * (n i : ℝ)) • textbookFourierCosineLift n) i =
    fun q ↦ -(2 * Real.pi * (n i : ℝ)) ^ 2 * textbookFourierSineLift n q
  rw [textbookConfigurationPartial_smul _ (textbookFourierCosineLift_contDiff n),
    textbookFourierCosineLift_partial]
  funext q
  simp only [Pi.smul_apply, smul_eq_mul]
  ring


/-- The genuine torus Fourier character has exactly the literal linear-phase exponential lift. -/
theorem textbookTorusFourier_lift_exp {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    UnitAddTorus.mFourier n (textbookConfigurationTorusProjection q) =
      Complex.exp ((textbookFourierPhase n q : ℂ) * Complex.I) := by
  change (∏ i, fourier (n i) (q i : UnitAddCircle)) = _
  simp only [fourier_coe_apply, Complex.ofReal_one, div_one]
  rw [← Complex.exp_sum]
  congr 1
  rw [textbookFourierPhase_apply]
  push_cast
  simp only [Finset.mul_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i _
  ring

/-- The real part of the genuine Fourier character is the actual cosine lift. -/
theorem textbookTorusFourier_lift_re {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    (UnitAddTorus.mFourier n (textbookConfigurationTorusProjection q)).re =
      textbookFourierCosineLift n q := by
  rw [textbookTorusFourier_lift_exp, Complex.exp_mul_I]
  simp [← Complex.ofReal_cos, ← Complex.ofReal_sin, textbookFourierCosineLift]

/-- The imaginary part of the genuine Fourier character is the actual sine lift. -/
theorem textbookTorusFourier_lift_im {Nc : ℕ} (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    (UnitAddTorus.mFourier n (textbookConfigurationTorusProjection q)).im =
      textbookFourierSineLift n q := by
  rw [textbookTorusFourier_lift_exp, Complex.exp_mul_I]
  simp [← Complex.ofReal_cos, ← Complex.ofReal_sin, textbookFourierSineLift]

/-- The auxiliary Haar Laplace frequency is the actual 4π² sum of integer coordinate squares. -/
noncomputable def textbookFourierLaplaceFrequency {Nc : ℕ} (n : Fin Nc → ℤ) : ℝ :=
  4 * Real.pi ^ 2 * ∑ i, (n i : ℝ) ^ 2

/-- The zero Fourier frequency has exactly zero Laplace multiplier. -/
theorem textbookFourierLaplaceFrequency_zero (Nc : ℕ) :
    textbookFourierLaplaceFrequency (0 : Fin Nc → ℤ) = 0 := by
  simp [textbookFourierLaplaceFrequency]

/-- A nonzero integer Fourier index has sum of squares at least one, including all dimensions. -/
theorem textbookFourier_integer_sum_sq_lower {Nc : ℕ} (n : Fin Nc → ℤ) (hn : n ≠ 0) :
    1 ≤ ∑ i, (n i : ℝ) ^ 2 := by
  classical
  have hi : ∃ i, n i ≠ 0 := by
    by_contra h
    push Not at h
    apply hn
    funext i
    exact h i
  obtain ⟨i, hi⟩ := hi
  have hs : 0 < ∑ j, (n j) ^ 2 := by
    exact lt_of_lt_of_le (sq_pos_of_ne_zero hi)
      (Finset.single_le_sum (fun j _ ↦ sq_nonneg (n j)) (Finset.mem_univ i))
  have hs' : (1 : ℤ) ≤ ∑ j, (n j) ^ 2 := by omega
  exact_mod_cast hs'

/-- The positive Haar frequency lower bound is derived from integer indices, not assumed. -/
theorem textbookFourierLaplaceFrequency_lower {Nc : ℕ} (n : Fin Nc → ℤ) (hn : n ≠ 0) :
    4 * Real.pi ^ 2 ≤ textbookFourierLaplaceFrequency n := by
  unfold textbookFourierLaplaceFrequency
  calc
    4 * Real.pi ^ 2 = (4 * Real.pi ^ 2) * 1 := by ring
    _ ≤ (4 * Real.pi ^ 2) * ∑ i, (n i : ℝ) ^ 2 :=
      mul_le_mul_of_nonneg_left (textbookFourier_integer_sum_sq_lower n hn) (by positivity)

/-- The literal original generator reduces to actual coordinate Laplace sum for the Haar auxiliary calculation. -/
theorem textbookBrownianGenerator_flat {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) :
    textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 f q =
      ∑ i, textbookConfigurationPartial (textbookConfigurationPartial f i) i q := by
  simp [textbookBrownianGenerator, textbookConfigurationPartial]

/-- The genuine cosine mode is an eigenfunction of the literal auxiliary Haar Laplace operator. -/
theorem textbookFourierCosineLift_flat_generator {Nc : ℕ} (n : Fin Nc → ℤ)
    (q : Fin Nc → ℝ) :
    textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 (textbookFourierCosineLift n) q =
      -textbookFourierLaplaceFrequency n * textbookFourierCosineLift n q := by
  rw [textbookBrownianGenerator_flat]
  simp only [textbookFourierCosineLift_second_partial]
  unfold textbookFourierLaplaceFrequency
  calc
    ∑ i, -(2 * Real.pi * (n i : ℝ)) ^ 2 * textbookFourierCosineLift n q =
        ∑ i, (-4 * Real.pi ^ 2 * textbookFourierCosineLift n q) * (n i : ℝ) ^ 2 := by
      apply Finset.sum_congr rfl
      intro i _
      ring
    _ = _ := by rw [← Finset.mul_sum]; ring

/-- The genuine sine mode is an eigenfunction of the literal auxiliary Haar Laplace operator. -/
theorem textbookFourierSineLift_flat_generator {Nc : ℕ} (n : Fin Nc → ℤ)
    (q : Fin Nc → ℝ) :
    textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 (textbookFourierSineLift n) q =
      -textbookFourierLaplaceFrequency n * textbookFourierSineLift n q := by
  rw [textbookBrownianGenerator_flat]
  simp only [textbookFourierSineLift_second_partial]
  unfold textbookFourierLaplaceFrequency
  calc
    ∑ i, -(2 * Real.pi * (n i : ℝ)) ^ 2 * textbookFourierSineLift n q =
        ∑ i, (-4 * Real.pi ^ 2 * textbookFourierSineLift n q) * (n i : ℝ) ^ 2 := by
      apply Finset.sum_congr rfl
      intro i _
      ring
    _ = _ := by rw [← Finset.mul_sum]; ring

end MolecularDynamics
