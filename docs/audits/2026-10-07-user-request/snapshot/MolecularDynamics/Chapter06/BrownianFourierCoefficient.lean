import MolecularDynamics.Chapter06.BrownianFourierDifferential

/-! Actual Haar Fourier coefficient identity from the literal periodic Brownian Dirichlet proof. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators ComplexConjugate

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- Zero potential has true partition one on the same normalized Haar torus. -/
theorem textbookConfigurationPartition_zero (Nc : ℕ) (β : ℝ) :
    textbookConfigurationPartition (fun _ : Fin Nc → ℝ ↦ 0) β = 1 := by
  rw [← textbookConfigurationTorusGibbsWeight_integral (fun _ : Fin Nc → ℝ ↦ 0)
    (by intro _ _; rfl) β]
  simp [textbookConfigurationTorusGibbsWeight, textbookConfigurationTorusObservable]

/-- The genuine zero-potential Gibbs measure is exactly the normalized Haar volume. -/
theorem textbookConfigurationTorusGibbsMeasure_zero (Nc : ℕ) (β : ℝ) :
    textbookConfigurationTorusGibbsMeasure (fun _ : Fin Nc → ℝ ↦ 0) β =
      (volume : Measure (UnitAddTorus (Fin Nc))) := by
  simp [textbookConfigurationTorusGibbsMeasure, textbookConfigurationPartition_zero,
    textbookConfigurationTorusGibbsWeight, textbookConfigurationTorusObservable]

/-- Actual Haar Dirichlet equality is obtained from the same literal generator and Gibbs measure. -/
theorem textbookHaarLaplace_dirichlet {Nc : ℕ}
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
      textbookConfigurationTorusObservable
        (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 g) Q) =
      -(∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (textbookConfigurationGradientPair (fun _ ↦ 1) f g) Q) := by
  have h := textbookBrownianTorusGibbsMeasure_dirichlet (fun _ : Fin Nc ↦ 1)
    (fun _ ↦ 0) 1 one_ne_zero f g contDiff_const hf hg (by intro _ _; rfl) hPf hPg
  simpa only [textbookConfigurationTorusGibbsMeasure_zero, inv_one, neg_one_mul] using h

/-- Actual Haar formal symmetry follows from proved periodic integration by parts. -/
theorem textbookHaarLaplace_symmetric {Nc : ℕ}
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
      textbookConfigurationTorusObservable
        (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 g) Q) =
      ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 f) Q *
          textbookConfigurationTorusObservable g Q := by
  have h := textbookBrownianTorusGibbsMeasure_symmetric (fun _ : Fin Nc ↦ 1)
    (fun _ ↦ 0) 1 one_ne_zero f g contDiff_const hf hg (by intro _ _; rfl) hPf hPg
  simpa only [textbookConfigurationTorusGibbsMeasure_zero] using h

/-- The real part of the actual torus character is its genuine descended cosine lift. -/
theorem textbookTorusFourier_cosine_observable {Nc : ℕ} (n : Fin Nc → ℤ)
    (Q : UnitAddTorus (Fin Nc)) :
    textbookConfigurationTorusObservable (textbookFourierCosineLift n) Q =
      (UnitAddTorus.mFourier n Q).re := by
  have h := textbookTorusFourier_lift_re n (textbookConfigurationTorusRepresentative Q)
  simpa only [textbookConfigurationTorusRepresentative_projects,
    textbookConfigurationTorusObservable] using h.symm

/-- The imaginary part of the actual torus character is its genuine descended sine lift. -/
theorem textbookTorusFourier_sine_observable {Nc : ℕ} (n : Fin Nc → ℤ)
    (Q : UnitAddTorus (Fin Nc)) :
    textbookConfigurationTorusObservable (textbookFourierSineLift n) Q =
      (UnitAddTorus.mFourier n Q).im := by
  have h := textbookTorusFourier_lift_im n (textbookConfigurationTorusRepresentative Q)
  simpa only [textbookConfigurationTorusRepresentative_projects,
    textbookConfigurationTorusObservable] using h.symm

/-- The literal Haar Laplace acts on cosine test pairings with its actual Fourier multiplier. -/
theorem textbookHaarLaplace_cosine_pairing {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    (∫ Q, textbookConfigurationTorusObservable (textbookFourierCosineLift n) Q *
      textbookConfigurationTorusObservable
        (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 f) Q) =
      -textbookFourierLaplaceFrequency n *
        ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
          (textbookFourierCosineLift n) Q * textbookConfigurationTorusObservable f Q := by
  rw [textbookHaarLaplace_symmetric _ f (textbookFourierCosineLift_contDiff n) hf
    (textbookFourierCosineLift_periodic n) hPf]
  simp only [textbookConfigurationTorusObservable, textbookFourierCosineLift_flat_generator]
  simp_rw [mul_assoc]
  exact integral_const_mul _ _

/-- The literal Haar Laplace acts on sine test pairings with its actual Fourier multiplier. -/
theorem textbookHaarLaplace_sine_pairing {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    (∫ Q, textbookConfigurationTorusObservable (textbookFourierSineLift n) Q *
      textbookConfigurationTorusObservable
        (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 f) Q) =
      -textbookFourierLaplaceFrequency n *
        ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
          (textbookFourierSineLift n) Q * textbookConfigurationTorusObservable f Q := by
  rw [textbookHaarLaplace_symmetric _ f (textbookFourierSineLift_contDiff n) hf
    (textbookFourierSineLift_periodic n) hPf]
  simp only [textbookConfigurationTorusObservable, textbookFourierSineLift_flat_generator]
  simp_rw [mul_assoc]
  exact integral_const_mul _ _

/-- The actual continuous complexification of a full periodic real observable on Haar torus. -/
def textbookTorusHaarComplexObservable {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    C(UnitAddTorus (Fin Nc), ℂ) :=
  ⟨fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ),
    Complex.ofRealCLM.continuous.comp (textbookConfigurationTorusObservable_continuous f hf hPf)⟩

/-- The genuine continuous complexification lifts back to the same original observable. -/
theorem textbookTorusHaarComplexObservable_lift {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) (q : Fin Nc → ℝ) :
    textbookTorusHaarComplexObservable f hf hPf (textbookConfigurationTorusProjection q) =
      (f q : ℂ) := by
  exact congrArg Complex.ofReal (textbookConfigurationTorusObservable_lift f hPf q)

/-- The real part of the actual Fourier coefficient is the genuine cosine Haar pairing. -/
theorem textbookTorusHaarFourierCoeff_re {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    (UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n).re =
      ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (textbookFourierCosineLift n) Q * textbookConfigurationTorusObservable f Q := by
  have hc : Continuous (fun Q : UnitAddTorus (Fin Nc) ↦
      UnitAddTorus.mFourier (-n) Q * (textbookConfigurationTorusObservable f Q : ℂ)) :=
    (UnitAddTorus.mFourier (-n)).continuous.mul
      (textbookTorusHaarComplexObservable f hf hPf).continuous
  have hi : Integrable (fun Q : UnitAddTorus (Fin Nc) ↦
      UnitAddTorus.mFourier (-n) Q * (textbookConfigurationTorusObservable f Q : ℂ)) :=
    (ContinuousMap.memLp (p := 2) volume ℂ ⟨_, hc⟩).integrable (by norm_num)
  unfold UnitAddTorus.mFourierCoeff
  simp only [smul_eq_mul]
  have hr := integral_re hi
  simp only [RCLike.re_eq_complex_re] at hr
  rw [← hr]
  apply integral_congr_ae
  filter_upwards [] with Q
  simp [UnitAddTorus.mFourier_neg, textbookTorusFourier_cosine_observable]

/-- The imaginary part of the actual Fourier coefficient is minus the genuine sine Haar pairing. -/
theorem textbookTorusHaarFourierCoeff_im {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    (UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n).im =
      -(∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (textbookFourierSineLift n) Q * textbookConfigurationTorusObservable f Q) := by
  have hc : Continuous (fun Q : UnitAddTorus (Fin Nc) ↦
      UnitAddTorus.mFourier (-n) Q * (textbookConfigurationTorusObservable f Q : ℂ)) :=
    (UnitAddTorus.mFourier (-n)).continuous.mul
      (textbookTorusHaarComplexObservable f hf hPf).continuous
  have hi : Integrable (fun Q : UnitAddTorus (Fin Nc) ↦
      UnitAddTorus.mFourier (-n) Q * (textbookConfigurationTorusObservable f Q : ℂ)) :=
    (ContinuousMap.memLp (p := 2) volume ℂ ⟨_, hc⟩).integrable (by norm_num)
  unfold UnitAddTorus.mFourierCoeff
  simp only [smul_eq_mul]
  have him := integral_im hi
  simp only [RCLike.im_eq_complex_im] at him
  rw [← him, ← integral_neg]
  apply integral_congr_ae
  filter_upwards [] with Q
  simp [UnitAddTorus.mFourier_neg, textbookTorusFourier_sine_observable, neg_mul]

/-- The actual Fourier coefficient of the literal auxiliary Laplace is its true frequency multiplier. -/
theorem textbookHaarLaplace_fourierCoeff {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) (n : Fin Nc → ℤ) :
    UnitAddTorus.mFourierCoeff (fun Q ↦
      (textbookConfigurationTorusObservable
        (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 f) Q : ℂ)) n =
      -(textbookFourierLaplaceFrequency n : ℂ) *
        UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n := by
  have hg := textbookBrownianGenerator_contDiff (fun _ : Fin Nc ↦ 1) (fun _ ↦ 0) 1 f
    contDiff_const hf
  have hPg := textbookBrownianGenerator_periodic (fun _ : Fin Nc ↦ 1) (fun _ ↦ 0) 1 f
    contDiff_const hf (by intro _ _; rfl) hPf
  apply Complex.ext
  · simp only [Complex.mul_re, Complex.neg_re, Complex.ofReal_re,
      Complex.neg_im, Complex.ofReal_im, neg_zero, zero_mul, sub_zero]
    rw [textbookTorusHaarFourierCoeff_re _ hg.continuous hPg,
      textbookTorusHaarFourierCoeff_re f hf.continuous hPf]
    exact textbookHaarLaplace_cosine_pairing f hf hPf n
  · simp only [Complex.mul_im, Complex.neg_re, Complex.ofReal_re,
      Complex.neg_im, Complex.ofReal_im, neg_zero, zero_mul]
    rw [textbookTorusHaarFourierCoeff_im _ hg.continuous hPg,
      textbookTorusHaarFourierCoeff_im f hf.continuous hPf,
      textbookHaarLaplace_sine_pairing f hf hPf]
    ring

/-- The genuine zero Fourier coefficient is exactly the actual Haar integral of the observable. -/
theorem textbookTorusHaarFourierCoeff_zero {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) :
    UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ))
      (0 : Fin Nc → ℤ) =
      ((∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f Q) : ℂ) := by
  simp [UnitAddTorus.mFourierCoeff, UnitAddTorus.mFourier_zero, integral_complex_ofReal]

/-- The actual Haar energy is the integral of the original coordinate-gradient pairing. -/
def textbookTorusHaarGradientEnergy {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) : ℝ :=
  ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
    (textbookConfigurationGradientPair (fun _ ↦ 1) f f) Q

/-- The actual Haar energy is the true full coordinate square-gradient integral. -/
theorem textbookTorusHaarGradientEnergy_eq_sum {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) :
    textbookTorusHaarGradientEnergy f =
      ∫ Q : UnitAddTorus (Fin Nc), ∑ i,
        (textbookConfigurationPartial f i (textbookConfigurationTorusRepresentative Q)) ^ 2 := by
  simp [textbookTorusHaarGradientEnergy, textbookConfigurationTorusObservable,
    textbookConfigurationGradientPair, pow_two]

/-- The true Haar coordinate-gradient energy is nonnegative. -/
theorem textbookTorusHaarGradientEnergy_nonneg {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) :
    0 ≤ textbookTorusHaarGradientEnergy f := by
  rw [textbookTorusHaarGradientEnergy_eq_sum]
  apply integral_nonneg
  intro Q
  exact Finset.sum_nonneg fun i _ ↦ sq_nonneg
    (textbookConfigurationPartial f i (textbookConfigurationTorusRepresentative Q))

/-- Actual Haar Parseval squares use genuine L² representatives of the full continuous observable. -/
theorem textbookTorusHaarFourierCoeff_sq_hasSum {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    HasSum (fun n : Fin Nc → ℤ ↦
      ‖UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n‖ ^ 2)
      (∫ Q : UnitAddTorus (Fin Nc), (textbookConfigurationTorusObservable f Q) ^ 2) := by
  let F := textbookTorusHaarComplexObservable f hf hPf
  have hae := ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℂ) F
  have he : (∫ Q, ‖F.toLp 2 volume ℂ Q‖ ^ 2) =
      ∫ Q : UnitAddTorus (Fin Nc), (textbookConfigurationTorusObservable f Q) ^ 2 := by
    apply integral_congr_ae
    filter_upwards [hae] with Q hQ
    rw [hQ]
    change ‖(textbookConfigurationTorusObservable f Q : ℂ)‖ ^ 2 =
      (textbookConfigurationTorusObservable f Q) ^ 2
    simp [Complex.norm_real, Real.norm_eq_abs]
  have hs := UnitAddTorus.hasSum_sq_mFourierCoeff (F.toLp 2 volume ℂ)
  simp only [UnitAddTorus.mFourierCoeff_toLp] at hs
  rw [he] at hs
  exact hs

/-- The actual frequency-weighted Fourier squares sum to the literal coordinate-gradient energy. -/
theorem textbookTorusHaarFourier_energy_hasSum {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    HasSum (fun n : Fin Nc → ℤ ↦ textbookFourierLaplaceFrequency n *
      ‖UnitAddTorus.mFourierCoeff (fun Q ↦ (textbookConfigurationTorusObservable f Q : ℂ)) n‖ ^ 2)
      (textbookTorusHaarGradientEnergy f) := by
  let g := textbookBrownianGenerator (fun _ : Fin Nc ↦ 1) (fun _ ↦ 0) 1 f
  have hg : ContDiff ℝ ∞ g :=
    textbookBrownianGenerator_contDiff (fun _ ↦ 1) (fun _ ↦ 0) 1 f contDiff_const hf
  have hPg : textbookUnitPeriodicPotential g :=
    textbookBrownianGenerator_periodic (fun _ ↦ 1) (fun _ ↦ 0) 1 f contDiff_const hf
      (by intro _ _; rfl) hPf
  let F := textbookTorusHaarComplexObservable f hf.continuous hPf
  let G := textbookTorusHaarComplexObservable g hg.continuous hPg
  have haeF := ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℂ) F
  have haeG := ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℂ) G
  have he : (∫ Q, conj (F.toLp 2 volume ℂ Q) * G.toLp 2 volume ℂ Q) =
      (-(textbookTorusHaarGradientEnergy f : ℂ)) := by
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
      _ = -(textbookTorusHaarGradientEnergy f : ℂ) := by
        rw [integral_complex_ofReal]
        change ((∫ Q, textbookConfigurationTorusObservable f Q *
          textbookConfigurationTorusObservable
            (textbookBrownianGenerator (fun _ ↦ 1) (fun _ ↦ 0) 1 f) Q : ℝ) : ℂ) = _
        rw [textbookHaarLaplace_dirichlet f f hf hf hPf hPf, Complex.ofReal_neg]
        rfl
  have hs := UnitAddTorus.hasSum_prod_mFourierCoeff (F.toLp 2 volume ℂ) (G.toLp 2 volume ℂ)
  rw [he] at hs
  simp only [UnitAddTorus.mFourierCoeff_toLp] at hs
  have hsum : HasSum (fun n : Fin Nc → ℤ ↦
      -((textbookFourierLaplaceFrequency n *
        ‖UnitAddTorus.mFourierCoeff F n‖ ^ 2 : ℝ) : ℂ))
      (-(textbookTorusHaarGradientEnergy f : ℂ)) := by
    apply hs.congr_fun
    intro n
    have hc : UnitAddTorus.mFourierCoeff G n =
        -(textbookFourierLaplaceFrequency n : ℂ) * UnitAddTorus.mFourierCoeff F n :=
      textbookHaarLaplace_fourierCoeff f hf hPf n
    rw [hc]
    calc
      -((textbookFourierLaplaceFrequency n *
          ‖UnitAddTorus.mFourierCoeff F n‖ ^ 2 : ℝ) : ℂ) =
          -(textbookFourierLaplaceFrequency n : ℂ) *
            (conj (UnitAddTorus.mFourierCoeff F n) * UnitAddTorus.mFourierCoeff F n) := by
        rw [Complex.conj_mul']
        push_cast
        ring
      _ = _ := by ring
  have hr := (RCLike.hasSum_re ℂ hsum).neg
  simp only [RCLike.re_eq_complex_re, Complex.neg_re, Complex.ofReal_re, neg_neg] at hr
  exact hr

end

end MolecularDynamics
