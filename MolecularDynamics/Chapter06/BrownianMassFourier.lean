import MolecularDynamics.Chapter06.BrownianClosedCoercivity

/-! Actual diagonal-mass Haar Fourier multipliers, necessary for the original Gibbs selfadjoint proof. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators ComplexConjugate

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual original diagonal-mass Haar frequency, with the original inverse temperature. -/
def textbookMassFourierFrequency {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (n : Fin Nc → ℤ) : ℝ :=
  β⁻¹ * (4 * Real.pi ^ 2) * ∑ i, (m i)⁻¹ * (n i : ℝ) ^ 2

/-- The actual zero mode has zero multiplier in every dimension. -/
theorem textbookMassFourierFrequency_zero {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    textbookMassFourierFrequency m β (0 : Fin Nc → ℤ) = 0 := by
  simp [textbookMassFourierFrequency]

/-- The auxiliary unit masses and temperature recover the already proved literal Haar frequency. -/
theorem textbookMassFourierFrequency_unit {Nc : ℕ} (n : Fin Nc → ℤ) :
    textbookMassFourierFrequency (fun _ ↦ 1) 1 n = textbookFourierLaplaceFrequency n := by
  simp [textbookMassFourierFrequency, textbookFourierLaplaceFrequency]

/-- Genuine opposite Fourier modes have identical original mass multipliers. -/
theorem textbookMassFourierFrequency_neg {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (n : Fin Nc → ℤ) :
    textbookMassFourierFrequency m β (-n) = textbookMassFourierFrequency m β n := by
  simp [textbookMassFourierFrequency]

/-- The actual original frequency is nonnegative for positive original masses and temperature. -/
theorem textbookMassFourierFrequency_nonneg {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) :
    0 ≤ textbookMassFourierFrequency m β n := by
  unfold textbookMassFourierFrequency
  apply mul_nonneg (by positivity)
  exact Finset.sum_nonneg fun i _ ↦ mul_nonneg (inv_pos.mpr (hm i)).le (sq_nonneg _)

/-- Every actual inverse mass has a derived positive lower bound. -/
theorem textbookConfigurationMassScale_inv_le {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (i : Fin Nc) :
    (textbookConfigurationMassScale m)⁻¹ ≤ (m i)⁻¹ := by
  simpa only [one_div] using
    one_div_le_one_div_of_le (hm i) (textbookConfigurationMass_le_scale m i)

/-- The actual mass frequency controls the full integer square sum with an explicit derived constant. -/
theorem textbookMassFourierFrequency_coercive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) :
    (β⁻¹ * (4 * Real.pi ^ 2) * (textbookConfigurationMassScale m)⁻¹) *
      (∑ i, (n i : ℝ) ^ 2) ≤ textbookMassFourierFrequency m β n := by
  unfold textbookMassFourierFrequency
  rw [mul_assoc, Finset.mul_sum]
  apply mul_le_mul_of_nonneg_left _ (by positivity)
  apply Finset.sum_le_sum
  intro i _
  exact mul_le_mul_of_nonneg_right (textbookConfigurationMassScale_inv_le m hm i) (sq_nonneg _)

/-- The actual nonzero frequency lower bound follows from integer coordinates, with no gap premise. -/
theorem textbookMassFourierFrequency_lower {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) (hn : n ≠ 0) :
    β⁻¹ * (4 * Real.pi ^ 2) * (textbookConfigurationMassScale m)⁻¹ ≤
      textbookMassFourierFrequency m β n := by
  have hc : 0 ≤ β⁻¹ * (4 * Real.pi ^ 2) * (textbookConfigurationMassScale m)⁻¹ :=
    (mul_pos (mul_pos (inv_pos.mpr hβ) (by positivity))
      (inv_pos.mpr (textbookConfigurationMassScale_pos m))).le
  have hl : β⁻¹ * (4 * Real.pi ^ 2) * (textbookConfigurationMassScale m)⁻¹ ≤
      (β⁻¹ * (4 * Real.pi ^ 2) * (textbookConfigurationMassScale m)⁻¹) *
        (∑ i, (n i : ℝ) ^ 2) := by
    simpa only [mul_one] using
      mul_le_mul_of_nonneg_left (textbookFourier_integer_sum_sq_lower n hn) hc
  exact hl.trans (textbookMassFourierFrequency_coercive m hm β hβ n)

/-- Actual nonzero modes have genuinely positive original mass frequency. -/
theorem textbookMassFourierFrequency_pos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) (hn : n ≠ 0) :
    0 < textbookMassFourierFrequency m β n :=
  lt_of_lt_of_le
    (mul_pos (mul_pos (inv_pos.mpr hβ) (by positivity))
      (inv_pos.mpr (textbookConfigurationMassScale_pos m)))
    (textbookMassFourierFrequency_lower m hm β hβ n hn)

/-- Only the actual zero Fourier index has zero original multiplier. -/
theorem textbookMassFourierFrequency_eq_zero_iff {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) :
    textbookMassFourierFrequency m β n = 0 ↔ n = 0 := by
  constructor
  · intro hz
    by_contra hn
    exact (ne_of_gt (textbookMassFourierFrequency_pos m hm β hβ n hn)) hz
  · rintro rfl
    exact textbookMassFourierFrequency_zero m β

/-- The literal original zero-potential generator is the full mass-weighted coordinate Laplace. -/
theorem textbookBrownianGenerator_mass_flat {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) :
    textbookBrownianGenerator m (fun _ ↦ 0) β f q =
      ∑ i, (m i)⁻¹ * β⁻¹ *
        textbookConfigurationPartial (textbookConfigurationPartial f i) i q := by
  simp [textbookBrownianGenerator, textbookConfigurationPartial, mul_assoc]

/-- Actual cosine characters are eigenfunctions of the original mass-weighted auxiliary generator. -/
theorem textbookFourierCosineLift_mass_generator {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    textbookBrownianGenerator m (fun _ ↦ 0) β (textbookFourierCosineLift n) q =
      -textbookMassFourierFrequency m β n * textbookFourierCosineLift n q := by
  rw [textbookBrownianGenerator_mass_flat]
  simp only [textbookFourierCosineLift_second_partial]
  unfold textbookMassFourierFrequency
  calc
    ∑ i, (m i)⁻¹ * β⁻¹ * (-(2 * Real.pi * (n i : ℝ)) ^ 2 *
        textbookFourierCosineLift n q) =
        ∑ i, (-β⁻¹ * (4 * Real.pi ^ 2) * textbookFourierCosineLift n q) *
          ((m i)⁻¹ * (n i : ℝ) ^ 2) := by
      apply Finset.sum_congr rfl
      intro i _
      ring
    _ = _ := by rw [← Finset.mul_sum]; ring

/-- Actual sine characters are eigenfunctions of the original mass-weighted auxiliary generator. -/
theorem textbookFourierSineLift_mass_generator {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (n : Fin Nc → ℤ) (q : Fin Nc → ℝ) :
    textbookBrownianGenerator m (fun _ ↦ 0) β (textbookFourierSineLift n) q =
      -textbookMassFourierFrequency m β n * textbookFourierSineLift n q := by
  rw [textbookBrownianGenerator_mass_flat]
  simp only [textbookFourierSineLift_second_partial]
  unfold textbookMassFourierFrequency
  calc
    ∑ i, (m i)⁻¹ * β⁻¹ * (-(2 * Real.pi * (n i : ℝ)) ^ 2 *
        textbookFourierSineLift n q) =
        ∑ i, (-β⁻¹ * (4 * Real.pi ^ 2) * textbookFourierSineLift n q) *
          ((m i)⁻¹ * (n i : ℝ) ^ 2) := by
      apply Finset.sum_congr rfl
      intro i _
      ring
    _ = _ := by rw [← Finset.mul_sum]; ring

/-- Actual Haar Dirichlet equality preserves every original diagonal mass and inverse temperature. -/
theorem textbookHaarMassLaplace_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
      textbookConfigurationTorusObservable (textbookBrownianGenerator m (fun _ ↦ 0) β g) Q) =
      -β⁻¹ * (∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (textbookConfigurationGradientPair m f g) Q) := by
  have h := textbookBrownianTorusGibbsMeasure_dirichlet m (fun _ ↦ 0) β hβ f g
    contDiff_const hf hg (by intro _ _; rfl) hPf hPg
  simpa only [textbookConfigurationTorusGibbsMeasure_zero] using h

/-- Actual Haar formal symmetry holds for the same literal original mass generator. -/
theorem textbookHaarMassLaplace_symmetric {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
      textbookConfigurationTorusObservable (textbookBrownianGenerator m (fun _ ↦ 0) β g) Q) =
      ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (textbookBrownianGenerator m (fun _ ↦ 0) β f) Q *
          textbookConfigurationTorusObservable g Q := by
  have h := textbookBrownianTorusGibbsMeasure_symmetric m (fun _ ↦ 0) β hβ f g
    contDiff_const hf hg (by intro _ _; rfl) hPf hPg
  simpa only [textbookConfigurationTorusGibbsMeasure_zero] using h
/-- The literal Haar Laplace acts on cosine test pairings with its actual Fourier multiplier. -/
theorem textbookHaarMassLaplace_cosine_pairing {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0) (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    (∫ Q, textbookConfigurationTorusObservable (textbookFourierCosineLift n) Q *
      textbookConfigurationTorusObservable
        (textbookBrownianGenerator m (fun _ ↦ 0) β f) Q) =
      -textbookMassFourierFrequency m β n *
        ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
          (textbookFourierCosineLift n) Q * textbookConfigurationTorusObservable f Q := by
  rw [textbookHaarMassLaplace_symmetric m β hβ _ f (textbookFourierCosineLift_contDiff n) hf
    (textbookFourierCosineLift_periodic n) hPf]
  simp only [textbookConfigurationTorusObservable, textbookFourierCosineLift_mass_generator]
  simp_rw [mul_assoc]
  exact integral_const_mul _ _

/-- The literal Haar Laplace acts on sine test pairings with its actual Fourier multiplier. -/
theorem textbookHaarMassLaplace_sine_pairing {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0) (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    (∫ Q, textbookConfigurationTorusObservable (textbookFourierSineLift n) Q *
      textbookConfigurationTorusObservable
        (textbookBrownianGenerator m (fun _ ↦ 0) β f) Q) =
      -textbookMassFourierFrequency m β n *
        ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
          (textbookFourierSineLift n) Q * textbookConfigurationTorusObservable f Q := by
  rw [textbookHaarMassLaplace_symmetric m β hβ _ f (textbookFourierSineLift_contDiff n) hf
    (textbookFourierSineLift_periodic n) hPf]
  simp only [textbookConfigurationTorusObservable, textbookFourierSineLift_mass_generator]
  simp_rw [mul_assoc]
  exact integral_const_mul _ _

/-- The actual Fourier coefficient of the literal auxiliary Laplace is its true frequency multiplier. -/
theorem textbookHaarMassLaplace_fourierCoeff {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0) (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    UnitAddTorus.mFourierCoeff (fun Q ↦
      (textbookConfigurationTorusObservable
        (textbookBrownianGenerator m (fun _ ↦ 0) β f) Q : ℂ)) n =
      -(textbookMassFourierFrequency m β n : ℂ) *
        UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n := by
  have hg := textbookBrownianGenerator_contDiff m (fun _ ↦ 0) β f
    contDiff_const hf
  have hPg := textbookBrownianGenerator_periodic m (fun _ ↦ 0) β f
    contDiff_const hf (by intro _ _; rfl) hPf
  apply Complex.ext
  · simp only [Complex.mul_re, Complex.neg_re, Complex.ofReal_re,
      Complex.neg_im, Complex.ofReal_im, neg_zero, zero_mul, sub_zero]
    rw [textbookTorusHaarFourierCoeff_re _ hg.continuous hPg,
      textbookTorusHaarFourierCoeff_re f hf.continuous hPf]
    exact textbookHaarMassLaplace_cosine_pairing m β hβ f hf hPf n
  · simp only [Complex.mul_im, Complex.neg_re, Complex.ofReal_re,
      Complex.neg_im, Complex.ofReal_im, neg_zero, zero_mul]
    rw [textbookTorusHaarFourierCoeff_im _ hg.continuous hPg,
      textbookTorusHaarFourierCoeff_im f hf.continuous hPf,
      textbookHaarMassLaplace_sine_pairing m β hβ f hf hPf]
    ring

/-- Actual Haar mass energy includes the same original inverse temperature as the generator. -/
def textbookTorusHaarMassGradientEnergy {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) : ℝ :=
  β⁻¹ * ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
    (textbookConfigurationGradientPair m f f) Q

/-- The mass energy is literally the full weighted original coordinate-square integral. -/
theorem textbookTorusHaarMassGradientEnergy_eq_sum {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) :
    textbookTorusHaarMassGradientEnergy m β f =
      β⁻¹ * ∫ Q : UnitAddTorus (Fin Nc), ∑ i, (m i)⁻¹ *
        (textbookConfigurationPartial f i (textbookConfigurationTorusRepresentative Q)) ^ 2 := by
  simp [textbookTorusHaarMassGradientEnergy, textbookConfigurationTorusObservable,
    textbookConfigurationGradientPair, pow_two, mul_assoc]

/-- The genuine mass-weighted Haar energy is nonnegative for the original positive parameters. -/
theorem textbookTorusHaarMassGradientEnergy_nonneg {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (f : (Fin Nc → ℝ) → ℝ) :
    0 ≤ textbookTorusHaarMassGradientEnergy m β f := by
  unfold textbookTorusHaarMassGradientEnergy textbookConfigurationTorusObservable
  apply mul_nonneg (inv_pos.mpr hβ).le
  exact integral_nonneg fun Q ↦
    textbookConfigurationGradientPair_self_nonneg m hm f (textbookConfigurationTorusRepresentative Q)
/-- The actual frequency-weighted Fourier squares sum to the literal coordinate-gradient energy. -/
theorem textbookTorusHaarMassFourier_energy_hasSum {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0) (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    HasSum (fun n : Fin Nc → ℤ ↦ textbookMassFourierFrequency m β n *
      ‖UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n‖ ^ 2)
      (textbookTorusHaarMassGradientEnergy m β f) := by
  let g := textbookBrownianGenerator m (fun _ ↦ 0) β f
  have hg : ContDiff ℝ ∞ g :=
    textbookBrownianGenerator_contDiff m (fun _ ↦ 0) β f contDiff_const hf
  have hPg : textbookUnitPeriodicPotential g :=
    textbookBrownianGenerator_periodic m (fun _ ↦ 0) β f contDiff_const hf
      (by intro _ _; rfl) hPf
  let F := textbookTorusHaarComplexObservable f hf.continuous hPf
  let G := textbookTorusHaarComplexObservable g hg.continuous hPg
  have haeF := ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℂ) F
  have haeG := ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℂ) G
  have he : (∫ Q, conj (F.toLp 2 volume ℂ Q) * G.toLp 2 volume ℂ Q) =
      (-(textbookTorusHaarMassGradientEnergy m β f : ℂ)) := by
    calc
      (∫ Q, conj (F.toLp 2 volume ℂ Q) * G.toLp 2 volume ℂ Q) =
          ∫ Q : UnitAddTorus (Fin Nc),
            ((textbookConfigurationTorusObservable f Q *
              textbookConfigurationTorusObservable g Q : ℝ) : ℂ) := by
        apply integral_congr_ae
        filter_upwards [haeF, haeG] with Q hF hG
        rw [hF, hG]
        change conj (textbookConfigurationTorusObservable f Q : ℂ) *
          (textbookConfigurationTorusObservable g Q : ℂ) = _
        simp
      _ = -(textbookTorusHaarMassGradientEnergy m β f : ℂ) := by
        rw [integral_complex_ofReal]
        change ((∫ Q, textbookConfigurationTorusObservable f Q *
          textbookConfigurationTorusObservable
            (textbookBrownianGenerator m (fun _ ↦ 0) β f) Q : ℝ) : ℂ) = _
        rw [textbookHaarMassLaplace_dirichlet m β hβ f f hf hf hPf hPf]
        simp [textbookTorusHaarMassGradientEnergy]
  have hs := UnitAddTorus.hasSum_prod_mFourierCoeff (F.toLp 2 volume ℂ) (G.toLp 2 volume ℂ)
  rw [he] at hs
  simp only [UnitAddTorus.mFourierCoeff_toLp] at hs
  have hsum : HasSum (fun n : Fin Nc → ℤ ↦
      -((textbookMassFourierFrequency m β n *
        ‖UnitAddTorus.mFourierCoeff F n‖ ^ 2 : ℝ) : ℂ))
      (-(textbookTorusHaarMassGradientEnergy m β f : ℂ)) := by
    apply hs.congr_fun
    intro n
    have hc : UnitAddTorus.mFourierCoeff G n =
        -(textbookMassFourierFrequency m β n : ℂ) * UnitAddTorus.mFourierCoeff F n :=
      textbookHaarMassLaplace_fourierCoeff m β hβ f hf hPf n
    rw [hc]
    calc
      -((textbookMassFourierFrequency m β n *
          ‖UnitAddTorus.mFourierCoeff F n‖ ^ 2 : ℝ) : ℂ) =
          -(textbookMassFourierFrequency m β n : ℂ) *
            (conj (UnitAddTorus.mFourierCoeff F n) * UnitAddTorus.mFourierCoeff F n) := by
        rw [Complex.conj_mul']
        push_cast
        ring
      _ = _ := by ring
  have hr := (RCLike.hasSum_re ℂ hsum).neg
  simp only [RCLike.re_eq_complex_re, Complex.neg_re, Complex.ofReal_re, neg_neg] at hr
  exact hr

/-- Actual generator-square Parseval gives the full original multiplier-square graph norm. -/
theorem textbookTorusHaarMassFourier_generator_sq_hasSum {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0) (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    HasSum (fun n : Fin Nc → ℤ ↦ (textbookMassFourierFrequency m β n) ^ 2 *
      ‖UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n‖ ^ 2)
      (∫ Q : UnitAddTorus (Fin Nc),
        (textbookConfigurationTorusObservable (textbookBrownianGenerator m (fun _ ↦ 0) β f) Q) ^ 2) := by
  have hg := textbookBrownianGenerator_contDiff m (fun _ ↦ 0) β f contDiff_const hf
  have hPg := textbookBrownianGenerator_periodic m (fun _ ↦ 0) β f contDiff_const hf
    (by intro _ _; rfl) hPf
  have hs := textbookTorusHaarFourierCoeff_sq_hasSum _ hg.continuous hPg
  apply hs.congr_fun
  intro n
  rw [textbookHaarMassLaplace_fourierCoeff m β hβ f hf hPf n]
  simp [Complex.norm_real, Real.norm_eq_abs, mul_pow]

/-- Every finite frequency sublevel has only finitely many actual original integer Fourier indices. -/
theorem textbookMassFourierFrequency_finite_sublevel {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (R : ℝ) :
    {n : Fin Nc → ℤ | textbookMassFourierFrequency m β n ≤ R}.Finite := by
  classical
  let c := β⁻¹ * (4 * Real.pi ^ 2) * (textbookConfigurationMassScale m)⁻¹
  have hc : 0 < c :=
    mul_pos (mul_pos (inv_pos.mpr hβ) (by positivity))
      (inv_pos.mpr (textbookConfigurationMassScale_pos m))
  obtain ⟨k, hk⟩ := exists_nat_gt (max 1 (R / c))
  have hk1 : (1 : ℝ) < k := lt_of_le_of_lt (le_max_left _ _) hk
  have hkR : R / c < k := lt_of_le_of_lt (le_max_right _ _) hk
  refine (Set.Finite.pi' (fun _ : Fin Nc ↦ Set.finite_Icc (-(k : ℤ)) (k : ℤ))).subset ?_
  intro n hn i
  have hsingle : (n i : ℝ) ^ 2 ≤ ∑ j, (n j : ℝ) ^ 2 :=
    Finset.single_le_sum (fun j _ ↦ sq_nonneg (n j : ℝ)) (Finset.mem_univ i)
  have hs : c * (n i : ℝ) ^ 2 ≤ R :=
    ((mul_le_mul_of_nonneg_left hsingle hc.le).trans
      (textbookMassFourierFrequency_coercive m hm β hβ n)).trans hn
  have hni : (n i : ℝ) ^ 2 < k :=
    lt_of_le_of_lt ((le_div_iff₀ hc).mpr (by simpa only [mul_comm] using hs)) hkR
  have hk0 : (0 : ℝ) ≤ k := Nat.cast_nonneg k
  have hkSq : (k : ℝ) ≤ (k : ℝ) ^ 2 := by nlinarith
  have habs : |(n i : ℝ)| ≤ (k : ℝ) :=
    (sq_le_sq₀ (abs_nonneg _) hk0).mp (by simpa only [sq_abs] using hni.le.trans hkSq)
  constructor
  · exact_mod_cast (abs_le.mp habs).1
  · exact_mod_cast (abs_le.mp habs).2

/-- The actual frequencies diverge outside finite subsets of the original integer index space. -/
theorem textbookMassFourierFrequency_tendsto {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    Tendsto (textbookMassFourierFrequency m β) cofinite atTop := by
  apply tendsto_atTop.2
  intro R
  rw [eventually_cofinite]
  exact (textbookMassFourierFrequency_finite_sublevel m hm β hβ R).subset
    (fun _ h ↦ (lt_of_not_ge h).le)

/-- The true positive resolvent multipliers tend to zero outside finite index sets. -/
theorem textbookMassFourierFrequency_resolvent_decay {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    Tendsto (fun n : Fin Nc → ℤ ↦ (1 + textbookMassFourierFrequency m β n)⁻¹)
      cofinite (𝓝 0) := by
  apply tendsto_inv_atTop_zero.comp
  exact tendsto_atTop_mono (fun n ↦ by linarith)
    (textbookMassFourierFrequency_tendsto m hm β hβ)
end

end MolecularDynamics
