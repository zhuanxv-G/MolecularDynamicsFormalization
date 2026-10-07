import MolecularDynamics.Chapter06.LangevinCanonicalPartition
import Mathlib.Analysis.Calculus.LineDeriv.IntegrationByParts

/-! Genuine integration by parts for the actual original Gaussian momentum law,
and its physical Ornstein-Uhlenbeck part of Langevin weak balance. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators

namespace MolecularDynamics
noncomputable section

/-- The actual normalized momentum Boltzmann density from the original
unit-mass canonical measure; the Gaussian law identity is proved below. -/
def textbookLangevinCanonicalMomentumDensity (N : ℕ) (β : ℝ) (p : Fin N → ℝ) : ℝ :=
  ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N *
    Real.exp (-β * (∑ i : Fin N, p i ^ 2) / 2)

private theorem momentum_density_as_gibbs (N : ℕ) (β : ℝ) (p : Fin N → ℝ) :
    textbookLangevinCanonicalMomentumDensity N β p =
      ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N *
        textbookLangevinGibbsWeight (fun _ : Fin N → ℝ ↦ 0) β (0, p) := by
  unfold textbookLangevinCanonicalMomentumDensity textbookLangevinGibbsWeight textbookLangevinHamiltonian
  simp only [add_zero]
  congr 1
  congr 1
  ring

private theorem momentum_density_nonneg (N : ℕ) (β : ℝ) (p : Fin N → ℝ) :
    0 ≤ textbookLangevinCanonicalMomentumDensity N β p := by
  unfold textbookLangevinCanonicalMomentumDensity
  positivity

/-- Actual smoothness of the same momentum density follows from the
true mechanical Gaussian weight, without a derivative assumption. -/
theorem textbookLangevinCanonicalMomentumDensity_contDiff (N : ℕ) (β : ℝ) :
    ContDiff ℝ ∞ (textbookLangevinCanonicalMomentumDensity N β) := by
  have hG : ContDiff ℝ ∞ (fun p : Fin N → ℝ ↦ textbookLangevinGibbsWeight
      (fun _ : Fin N → ℝ ↦ 0) β (0, p)) := (textbookLangevinGibbsWeight_contDiff (fun _ : Fin N → ℝ ↦ 0)
    contDiff_const β).comp (contDiff_const.prodMk contDiff_id)
  have he : textbookLangevinCanonicalMomentumDensity N β =
      (fun p : Fin N → ℝ ↦ ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N *
        textbookLangevinGibbsWeight (fun _ : Fin N → ℝ ↦ 0) β (0, p)) :=
    funext (momentum_density_as_gibbs N β)
  rw [he]
  exact contDiff_const.mul hG

/-- The actual original Gaussian pi measure has exactly this literal
Boltzmann density, as follows from its verified true product-PDF identity. -/
theorem textbookLangevinCanonicalMomentumDensity_withDensity (N : ℕ) (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalMomentumMeasure N β hβ =
      (volume : Measure (Fin N → ℝ)).withDensity
        (fun p ↦ ENNReal.ofReal (textbookLangevinCanonicalMomentumDensity N β p)) := by
  rw [textbookLangevinCanonicalMomentumMeasure_withDensity N β hβ]
  congr 1
  funext p
  rw [textbookLangevinCanonicalMomentumMeasure_pdf_product N β hβ p]
  rfl

/-- Actual expectation under the genuine original Gaussian law is its
same derived real density integral, for every observable. -/
theorem textbookLangevinCanonicalMomentumDensity_integral (N : ℕ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin N → ℝ) → ℝ) :
    (∫ p, f p ∂textbookLangevinCanonicalMomentumMeasure N β hβ) =
      ∫ p : Fin N → ℝ, textbookLangevinCanonicalMomentumDensity N β p * f p := by
  have hm : Measurable (fun p ↦ ENNReal.ofReal (textbookLangevinCanonicalMomentumDensity N β p)) :=
    (textbookLangevinCanonicalMomentumDensity_contDiff N β).continuous.measurable.ennreal_ofReal
  rw [textbookLangevinCanonicalMomentumDensity_withDensity N β hβ,
    integral_withDensity_eq_integral_toReal_smul hm
      (Eventually.of_forall (fun _ ↦ ENNReal.ofReal_lt_top)) _]
  simp_rw [ENNReal.toReal_ofReal (momentum_density_nonneg N β _), smul_eq_mul]

/-- The true coordinate derivative of the same normalized Gaussian
density is minus beta times actual momentum times the same density. -/
theorem textbookLangevinCanonicalMomentumDensity_fderiv (N : ℕ) (β : ℝ)
    (p : Fin N → ℝ) (i : Fin N) :
    fderiv ℝ (textbookLangevinCanonicalMomentumDensity N β) p (Pi.single i 1) =
      -β * p i * textbookLangevinCanonicalMomentumDensity N β p := by
  let c := ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N
  have he : (fun t : ℝ ↦ textbookLangevinCanonicalMomentumDensity N β (p + t • Pi.single i 1)) =
      (fun t ↦ c * textbookLangevinGibbsWeight (fun _ : Fin N → ℝ ↦ 0) β
        ((0, p) + t • ((0 : Fin N → ℝ), Pi.single i 1))) := by
    funext t
    rw [momentum_density_as_gibbs]
    rfl
  have hd : HasDerivAt (fun t : ℝ ↦ textbookLangevinCanonicalMomentumDensity N β
      (p + t • Pi.single i 1)) (-β * p i * textbookLangevinCanonicalMomentumDensity N β p) 0 := by
    rw [he]
    convert! (textbookLangevinGibbsWeight_momentum_hasDerivAt
      (fun _ : Fin N → ℝ ↦ 0) β (0, p) i 0).const_mul c using 1
    simp only [zero_smul, add_zero, momentum_density_as_gibbs]
    ring
  have hg := (textbookLangevinCanonicalMomentumDensity_contDiff N β).differentiable (by simp) p
  have ht : HasDerivAt (fun t : ℝ ↦ textbookLangevinCanonicalMomentumDensity N β
      (p + t • Pi.single i 1))
      (fderiv ℝ (textbookLangevinCanonicalMomentumDensity N β) p (Pi.single i 1)) 0 := by
    simpa only [id_eq, zero_smul, add_zero, one_smul] using!
      hg.hasFDerivAt.comp_hasDerivAt_of_eq 0
        (((hasDerivAt_id (0 : ℝ)).smul_const (Pi.single i (1 : ℝ))).const_add p) (by simp)
  exact ht.unique hd

/-- Integration by parts is proved for the actual original Gaussian law
and every C1 compact momentum test, using true full-space Haar calculus. -/
theorem textbookLangevinCanonicalMomentumMeasure_integrationByParts (N : ℕ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 1 f) (hs : HasCompactSupport f) (i : Fin N) :
    (∫ p, fderiv ℝ f p (Pi.single i 1) ∂textbookLangevinCanonicalMomentumMeasure N β hβ) =
      β * ∫ p, p i * f p ∂textbookLangevinCanonicalMomentumMeasure N β hβ := by
  let ρ := textbookLangevinCanonicalMomentumDensity N β
  have hρ : ContDiff ℝ ∞ ρ := textbookLangevinCanonicalMomentumDensity_contDiff N β
  have hD : Continuous (fun p ↦ fderiv ℝ f p (Pi.single i 1)) :=
    (hf.continuous_fderiv (by norm_num)).clm_apply continuous_const
  have hsD : HasCompactSupport (fun p ↦ fderiv ℝ f p (Pi.single i 1)) :=
    hs.fderiv_apply ℝ (Pi.single i 1)
  have hi1 : Integrable (fun p ↦ fderiv ℝ ρ p (Pi.single i 1) * f p) :=
    (((hρ.continuous_fderiv (by simp)).clm_apply continuous_const).mul hf.continuous).integrable_of_hasCompactSupport (hs.mul_left)
  have hi2 : Integrable (fun p ↦ ρ p * fderiv ℝ f p (Pi.single i 1)) :=
    (hρ.continuous.mul hD).integrable_of_hasCompactSupport hsD.mul_left
  have hi3 : Integrable (fun p ↦ ρ p * f p) :=
    (hρ.continuous.mul hf.continuous).integrable_of_hasCompactSupport hs.mul_left
  have he := integral_mul_fderiv_eq_neg_fderiv_mul_of_integrable hi1 hi2 hi3
    (fun p _ ↦ hρ.differentiable (by simp) p) (fun p _ ↦ hf.differentiable_one p)
  rw [textbookLangevinCanonicalMomentumDensity_integral N β hβ,
    textbookLangevinCanonicalMomentumDensity_integral N β hβ]
  change (∫ p, ρ p * fderiv ℝ f p (Pi.single i 1)) = β * ∫ p, ρ p * (p i * f p)
  rw [he]
  dsimp only [ρ]
  simp_rw [textbookLangevinCanonicalMomentumDensity_fderiv]
  calc
    -(∫ p, -β * p i * textbookLangevinCanonicalMomentumDensity N β p * f p) =
        -(∫ p, (-β) * (ρ p * (p i * f p))) := by
          congr 1
          apply integral_congr_ae
          filter_upwards [] with p
          dsimp [ρ]
          ring
    _ = β * ∫ p, ρ p * (p i * f p) := by rw [integral_const_mul]; ring

/-- The physical momentum friction-diffusion part of the original
Langevin differential expression with sigma squared equal to 2 gamma / beta. -/
def textbookLangevinMomentumOrnsteinUhlenbeckOperator (N : ℕ) (γ β : ℝ)
    (f : (Fin N → ℝ) → ℝ) (p : Fin N → ℝ) : ℝ :=
  γ * ∑ i : Fin N, (β⁻¹ * fderiv ℝ (fun q ↦ fderiv ℝ f q (Pi.single i 1)) p (Pi.single i 1) -
    p i * fderiv ℝ f p (Pi.single i 1))

/-- The actual Gaussian momentum law gives zero weak friction-diffusion
for every C2 compact momentum test, without a target balance premise. -/
theorem textbookLangevinCanonicalMomentumMeasure_ou_weak_balance (N : ℕ) (β γ : ℝ) (hβ : 0 < β)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f) :
    (∫ p, textbookLangevinMomentumOrnsteinUhlenbeckOperator N γ β f p
      ∂textbookLangevinCanonicalMomentumMeasure N β hβ) = 0 := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  let D (i : Fin N) := fun p ↦ fderiv ℝ f p (Pi.single i 1)
  have hD (i : Fin N) : ContDiff ℝ 1 (D i) :=
    (hf.fderiv_right (by norm_num)).clm_apply contDiff_const
  have hsD (i : Fin N) : HasCompactSupport (D i) := hs.fderiv_apply ℝ (Pi.single i 1)
  have hi1 (i : Fin N) : Integrable (fun p ↦ β⁻¹ * fderiv ℝ (D i) p (Pi.single i 1))
      (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    (((hD i).continuous_fderiv (by norm_num)).clm_apply continuous_const).const_mul β⁻¹
      |>.integrable_of_hasCompactSupport ((hsD i).fderiv_apply ℝ (Pi.single i 1)).mul_left
  have hi2 (i : Fin N) : Integrable (fun p ↦ p i * D i p)
      (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    ((continuous_apply i).mul (hD i).continuous).integrable_of_hasCompactSupport (hsD i).mul_left
  unfold textbookLangevinMomentumOrnsteinUhlenbeckOperator
  have hi (i : Fin N) : Integrable (fun p ↦ β⁻¹ * fderiv ℝ (D i) p (Pi.single i 1) - p i * D i p)
      (textbookLangevinCanonicalMomentumMeasure N β hβ) := by
    simpa only [Pi.sub_apply] using! (hi1 i).sub (hi2 i)
  rw [integral_const_mul]
  change γ * (∫ p, ∑ i : Fin N, (β⁻¹ * fderiv ℝ (D i) p (Pi.single i 1) - p i * D i p)
    ∂textbookLangevinCanonicalMomentumMeasure N β hβ) = 0
  rw [integral_finsetSum _ (fun i _ ↦ hi i)]
  have he (i : Fin N) := textbookLangevinCanonicalMomentumMeasure_integrationByParts
    N β hβ (D i) (hD i) (hsD i) i
  have hz (i : Fin N) :
      (∫ p, β⁻¹ * fderiv ℝ (D i) p (Pi.single i 1) - p i * D i p
        ∂textbookLangevinCanonicalMomentumMeasure N β hβ) = 0 := by
    rw [integral_sub (hi1 i) (hi2 i), integral_const_mul, he]
    rw [← mul_assoc, inv_mul_cancel₀ hβ.ne', one_mul, sub_self]
  change γ * (∑ i : Fin N, ∫ p, β⁻¹ * fderiv ℝ (D i) p (Pi.single i 1) - p i * D i p
    ∂textbookLangevinCanonicalMomentumMeasure N β hβ) = 0
  simp_rw [hz]
  simp

end
end MolecularDynamics
