import MolecularDynamics.Chapter06.BrownianGroundStateCore

/-! Genuine real Haar L² Fourier reconstruction for the original mass Laplacian. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace BigOperators

namespace MolecularDynamics

noncomputable section

private local instance brownianFourierHilbertCircleMeasure : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
private local instance brownianFourierHilbertCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The genuine real-to-complex embedding of full Haar L². -/
def textbookHaarL2Complexify (Nc : ℕ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
      Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  Complex.ofRealCLM.compLpL 2 volume

/-- The genuine pointwise real part on full complex Haar L². -/
def textbookHaarL2RealPart (Nc : ℕ) :
    Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  Complex.reCLM.compLpL 2 volume

/-- Actual almost-everywhere values of complexification. -/
theorem textbookHaarL2Complexify_ae {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookHaarL2Complexify Nc x =ᵐ[volume] fun Q ↦ (x Q : ℂ) :=
  Complex.ofRealCLM.coeFn_compLpL x

/-- Actual almost-everywhere values of the real-part map. -/
theorem textbookHaarL2RealPart_ae {Nc : ℕ}
    (x : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookHaarL2RealPart Nc x =ᵐ[volume] fun Q ↦ (x Q).re :=
  Complex.reCLM.coeFn_compLpL x

/-- Real part is a genuine left inverse on the entire original real Hilbert space. -/
theorem textbookHaarL2RealPart_complexify {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookHaarL2RealPart Nc (textbookHaarL2Complexify Nc x) = x := by
  apply Lp.ext
  filter_upwards [textbookHaarL2RealPart_ae (textbookHaarL2Complexify Nc x),
    textbookHaarL2Complexify_ae x] with Q hR hJ
  rw [hR, hJ, Complex.ofReal_re]

/-- Complexification preserves the genuine L² norm, from actual AE norm equality. -/
theorem textbookHaarL2Complexify_norm {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ‖textbookHaarL2Complexify Nc x‖ = ‖x‖ := by
  rw [Lp.norm_def, Lp.norm_def]
  congr 1
  apply eLpNorm_congr_norm_ae (Lp.aestronglyMeasurable _) (Lp.aestronglyMeasurable _)
  filter_upwards [textbookHaarL2Complexify_ae x] with Q hQ
  rw [hQ, Complex.norm_real]

/-- The actual full real Hilbert embedding is injective. -/
theorem textbookHaarL2Complexify_injective (Nc : ℕ) :
    Function.Injective (textbookHaarL2Complexify Nc) := by
  intro x y h
  have hr := congrArg (textbookHaarL2RealPart Nc) h
  simpa only [textbookHaarL2RealPart_complexify] using hr

/-- The genuine Fourier series reconstructs every real Haar L² vector. -/
theorem textbookHaarL2RealPart_fourier_hasSum {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    HasSum (fun n : Fin Nc → ℤ ↦ textbookHaarL2RealPart Nc
      (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n •
        UnitAddTorus.mFourierLp 2 n)) x := by
  have h := (textbookHaarL2RealPart Nc).hasSum
    (UnitAddTorus.hasSum_mFourier_series_L2 (textbookHaarL2Complexify Nc x))
  simpa only [textbookHaarL2RealPart_complexify] using h

/-- The actual cosine mode belongs to the full original smooth periodic space. -/
def textbookFourierCosineSmooth {Nc : ℕ} (n : Fin Nc → ℤ) :
    textbookPeriodicSmoothSpace Nc :=
  ⟨textbookFourierCosineLift n, textbookFourierCosineLift_contDiff n,
    textbookFourierCosineLift_periodic n⟩

/-- The actual sine mode belongs to the full original smooth periodic space. -/
def textbookFourierSineSmooth {Nc : ℕ} (n : Fin Nc → ℤ) :
    textbookPeriodicSmoothSpace Nc :=
  ⟨textbookFourierSineLift n, textbookFourierSineLift_contDiff n,
    textbookFourierSineLift_periodic n⟩

/-- The actual real part of a complex-scaled Fourier mode, as a genuine smooth vector. -/
def textbookFourierRealMode {Nc : ℕ} (c : ℂ) (n : Fin Nc → ℤ) :
    textbookPeriodicSmoothSpace Nc :=
  c.re • textbookFourierCosineSmooth n + (-c.im) • textbookFourierSineSmooth n

/-- Its actual Euclidean lift is the literal cosine-sine combination. -/
theorem textbookFourierRealMode_apply {Nc : ℕ} (c : ℂ) (n : Fin Nc → ℤ)
    (q : Fin Nc → ℝ) :
    (textbookFourierRealMode c n : (Fin Nc → ℝ) → ℝ) q =
      c.re * textbookFourierCosineLift n q - c.im * textbookFourierSineLift n q := by
  change c.re * textbookFourierCosineLift n q +
    (-c.im) * textbookFourierSineLift n q = _
  ring

/-- Its actual continuous torus observable is precisely the real part of the actual character. -/
theorem textbookFourierRealMode_observable {Nc : ℕ} (c : ℂ) (n : Fin Nc → ℤ)
    (Q : UnitAddTorus (Fin Nc)) :
    textbookPeriodicSmoothContinuous (textbookFourierRealMode c n) Q =
      (c * UnitAddTorus.mFourier n Q).re := by
  conv_lhs => rw [← textbookConfigurationTorusRepresentative_projects Q]
  conv_rhs => rw [← textbookConfigurationTorusRepresentative_projects Q]
  rw [textbookPeriodicSmoothContinuous_lift, textbookFourierRealMode_apply,
    Complex.mul_re, textbookTorusFourier_lift_re, textbookTorusFourier_lift_im]

/-- The actual real-part L² map of a scaled Fourier basis vector equals the genuine smooth embedding. -/
theorem textbookFourierRealMode_haarEmbedding {Nc : ℕ} (c : ℂ) (n : Fin Nc → ℤ) :
    textbookPeriodicSmoothHaarEmbedding Nc (textbookFourierRealMode c n) =
      textbookHaarL2RealPart Nc (c • UnitAddTorus.mFourierLp 2 n) := by
  apply Lp.ext
  filter_upwards [ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℝ)
      (textbookPeriodicSmoothContinuous (textbookFourierRealMode c n)),
    textbookHaarL2RealPart_ae (c • UnitAddTorus.mFourierLp 2 n),
    Lp.coeFn_smul c (UnitAddTorus.mFourierLp 2 n),
    UnitAddTorus.coeFn_mFourierLp 2 n] with Q hS hR hC hF
  change ((textbookPeriodicSmoothContinuous (textbookFourierRealMode c n)).toLp
    2 volume ℝ Q) = _
  rw [hS, hR, hC]
  simp only [Pi.smul_apply, smul_eq_mul]
  rw [hF]
  exact textbookFourierRealMode_observable c n Q

/-- The original diagonal-mass zero-potential generator on the entire original smooth space. -/
def textbookHaarMassSmoothGenerator {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    textbookPeriodicSmoothSpace Nc →ₗ[ℝ] textbookPeriodicSmoothSpace Nc :=
  textbookBrownianSmoothGenerator m (fun _ ↦ 0) contDiff_const (by intro _ _; rfl) β

/-- This smooth operator is the literal original mass Laplacian, with no diagonal premise. -/
theorem textbookHaarMassSmoothGenerator_apply {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (f : textbookPeriodicSmoothSpace Nc) (q : Fin Nc → ℝ) :
    (textbookHaarMassSmoothGenerator m β f : (Fin Nc → ℝ) → ℝ) q =
      textbookBrownianGenerator m (fun _ ↦ 0) β f q := rfl

/-- Every genuine complex-scaled real Fourier mode has its derived original mass multiplier. -/
theorem textbookHaarMassSmoothGenerator_realMode {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (c : ℂ) (n : Fin Nc → ℤ) :
    textbookHaarMassSmoothGenerator m β (textbookFourierRealMode c n) =
      (-textbookMassFourierFrequency m β n) • textbookFourierRealMode c n := by
  have hc : textbookHaarMassSmoothGenerator m β (textbookFourierCosineSmooth n) =
      (-textbookMassFourierFrequency m β n) • textbookFourierCosineSmooth n := by
    apply Subtype.ext
    funext q
    exact textbookFourierCosineLift_mass_generator m β n q
  have hs : textbookHaarMassSmoothGenerator m β (textbookFourierSineSmooth n) =
      (-textbookMassFourierFrequency m β n) • textbookFourierSineSmooth n := by
    apply Subtype.ext
    funext q
    exact textbookFourierSineLift_mass_generator m β n q
  unfold textbookFourierRealMode
  rw [map_add, map_smul, map_smul, hc, hs, smul_comm c.re, smul_comm (-c.im),
    ← smul_add]
/-- The Fourier series of every full real Haar vector consists of actual smooth-domain vectors. -/
theorem textbookHaarL2Fourier_smooth_hasSum {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    HasSum (fun n : Fin Nc → ℤ ↦ textbookPeriodicSmoothHaarEmbedding Nc
      (textbookFourierRealMode
        (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n) n)) x := by
  simpa only [textbookFourierRealMode_haarEmbedding] using
    textbookHaarL2RealPart_fourier_hasSum x

/-- Genuine finite Fourier polynomials, staying in the entire original smooth domain. -/
def textbookHaarFourierPolynomial {Nc : ℕ}
    (a : (Fin Nc → ℤ) → ℂ) (s : Finset (Fin Nc → ℤ)) :
    textbookPeriodicSmoothSpace Nc :=
  ∑ n ∈ s, textbookFourierRealMode (a n) n

/-- The actual embedding of each finite polynomial is its real-part Fourier sum. -/
theorem textbookHaarFourierPolynomial_embedding {Nc : ℕ}
    (a : (Fin Nc → ℤ) → ℂ) (s : Finset (Fin Nc → ℤ)) :
    textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarFourierPolynomial a s) =
      ∑ n ∈ s, textbookHaarL2RealPart Nc (a n • UnitAddTorus.mFourierLp 2 n) := by
  classical
  simp only [textbookHaarFourierPolynomial, map_sum, textbookFourierRealMode_haarEmbedding]

/-- The original generator acts on actual polynomials by the derived mass frequencies. -/
theorem textbookHaarFourierPolynomial_generator {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (a : (Fin Nc → ℤ) → ℂ) (s : Finset (Fin Nc → ℤ)) :
    textbookHaarMassSmoothGenerator m β (textbookHaarFourierPolynomial a s) =
      ∑ n ∈ s, (-textbookMassFourierFrequency m β n) • textbookFourierRealMode (a n) n := by
  classical
  simp only [textbookHaarFourierPolynomial, map_sum, textbookHaarMassSmoothGenerator_realMode]

/-- Actual Fourier polynomials converge in the genuine full real Haar Hilbert norm. -/
theorem textbookHaarFourierPolynomial_tendsto {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    Tendsto (fun s : Finset (Fin Nc → ℤ) ↦
      textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarFourierPolynomial
        (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x)) s)) atTop (𝓝 x) := by
  have h := textbookHaarL2Fourier_smooth_hasSum x
  unfold HasSum SummationFilter.unconditional at h
  simpa only [textbookHaarFourierPolynomial, map_sum] using h

/-- The genuine pointwise real-part map is adjoint to real complexification for the true inner products. -/
theorem textbookHaarL2RealPart_inner {Nc : ℕ}
    (z : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ⟪textbookHaarL2RealPart Nc z, x⟫_ℝ =
      (⟪z, textbookHaarL2Complexify Nc x⟫_ℂ).re := by
  rw [L2.inner_def, L2.inner_def]
  change (∫ Q : UnitAddTorus (Fin Nc), ⟪textbookHaarL2RealPart Nc z Q, x Q⟫_ℝ) =
    RCLike.re (∫ Q : UnitAddTorus (Fin Nc), ⟪z Q, textbookHaarL2Complexify Nc x Q⟫_ℂ)
  rw [← integral_re (L2.integrable_inner (𝕜 := ℂ) z (textbookHaarL2Complexify Nc x))]
  apply integral_congr_ae
  filter_upwards [textbookHaarL2RealPart_ae z, textbookHaarL2Complexify_ae x] with Q hR hJ
  rw [hR, hJ]
  simp [RCLike.inner_apply]

/-- Actual smooth Fourier tests recover the true complex Fourier coefficient of every real L² vector. -/
theorem textbookFourierRealMode_inner {Nc : ℕ} (c : ℂ) (n : Fin Nc → ℤ)
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ⟪textbookPeriodicSmoothHaarEmbedding Nc (textbookFourierRealMode c n), x⟫_ℝ =
      (star c * UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n).re := by
  have hcoef := UnitAddTorus.mFourierBasis_repr (textbookHaarL2Complexify Nc x) n
  rw [HilbertBasis.repr_apply_apply, UnitAddTorus.coe_mFourierBasis] at hcoef
  rw [textbookFourierRealMode_haarEmbedding, textbookHaarL2RealPart_inner, inner_smul_left, hcoef]
  rfl

/-- Real scalars act on the genuine real-part mode exactly through their complex embedding. -/
theorem textbookFourierRealMode_real_mul {Nc : ℕ} (r : ℝ) (c : ℂ) (n : Fin Nc → ℤ) :
    textbookFourierRealMode ((r : ℂ) * c) n = r • textbookFourierRealMode c n := by
  apply Subtype.ext
  funext q
  change _ = r * (textbookFourierRealMode c n : (Fin Nc → ℝ) → ℝ) q
  rw [textbookFourierRealMode_apply, textbookFourierRealMode_apply]
  simp only [Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    zero_mul, sub_zero]
  ring

/-- Every actual smooth Fourier polynomial has the original weighted coefficient polynomial as its generator. -/
theorem textbookHaarFourierPolynomial_generator_coeff {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (a : (Fin Nc → ℤ) → ℂ) (s : Finset (Fin Nc → ℤ)) :
    textbookHaarMassSmoothGenerator m β (textbookHaarFourierPolynomial a s) =
      textbookHaarFourierPolynomial
        (fun n ↦ (-textbookMassFourierFrequency m β n : ℂ) * a n) s := by
  classical
  rw [textbookHaarFourierPolynomial_generator]
  unfold textbookHaarFourierPolynomial
  apply Finset.sum_congr rfl
  intro n _
  simpa only [Complex.ofReal_neg] using
    (textbookFourierRealMode_real_mul (-textbookMassFourierFrequency m β n) (a n) n).symm

/-- Actual Fourier coefficients determine the entire real Haar Hilbert vector. -/
theorem textbookHaarL2Fourier_coeff_injective {Nc : ℕ}
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (h : ∀ n : Fin Nc → ℤ,
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n =
        UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) n) : x = y := by
  apply textbookHaarL2Complexify_injective Nc
  apply UnitAddTorus.mFourierBasis.repr.injective
  ext n
  simp only [UnitAddTorus.mFourierBasis_repr]
  exact h n

/-- When actual coefficients describe a vector y, actual smooth Fourier graphs converge to (x,y). -/
theorem textbookHaarFourierPolynomial_graph_tendsto {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (h : ∀ n : Fin Nc → ℤ,
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) n =
        (-textbookMassFourierFrequency m β n : ℂ) *
          UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n) :
    Tendsto (fun s : Finset (Fin Nc → ℤ) ↦
      (textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarFourierPolynomial
        (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x)) s),
       textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β
         (textbookHaarFourierPolynomial
           (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x)) s))))
      atTop (𝓝 (x, y)) := by
  have hc : (fun n ↦ (-textbookMassFourierFrequency m β n : ℂ) *
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n) =
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) := by
    funext n
    exact (h n).symm
  have hy := textbookHaarFourierPolynomial_tendsto y
  have hy' : Tendsto (fun s : Finset (Fin Nc → ℤ) ↦
      textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β
        (textbookHaarFourierPolynomial
          (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x)) s)))
      atTop (𝓝 y) := by
    simpa only [textbookHaarFourierPolynomial_generator_coeff, hc] using hy
  exact (textbookHaarFourierPolynomial_tendsto x).prodMk_nhds hy'

end

end MolecularDynamics