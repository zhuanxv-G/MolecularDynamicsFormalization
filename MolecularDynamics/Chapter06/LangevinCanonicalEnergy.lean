import MolecularDynamics.Chapter06.LangevinCanonicalWeakBalance
import Mathlib.MeasureTheory.Measure.OpenPos
import Mathlib.Analysis.Calculus.MeanValue

/-! The canonical energy identity on the original compact smooth phase tests.
This supplies the smooth-test stage of the weighted H1 conserved-quantity
argument, without claiming an H1 extension or a Hilbert adjoint domain. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ZeroAtInfty BigOperators
namespace MolecularDynamics
noncomputable section

local instance energyUnitAddCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance energyUnitAddCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance energyUnitAddCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private theorem energy_rep {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (Q : UnitAddTorus (Fin N)) (p : Fin N → ℝ) :
    (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) = F (Q, p) := by
  change F (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative Q), p) = _
  rw [textbookConfigurationTorusRepresentative_projects]

private theorem energy_lift_mul {N : ℕ} (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) :
    ContDiff ℝ ∞ ((fun x ↦ F x * G x) ∘ textbookLangevinPeriodicProjection) := by
  simpa only [Function.comp_apply] using! hF.mul hG

/-- The actual descended directional derivative obeys the genuine product
rule, derived from the true real Frechet derivative of the original lift. -/
theorem textbookLangevinPeriodicDirectionalDerivative_mul {N : ℕ}
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (v : textbookLangevinPhase N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (fun y ↦ F y * G y) v x =
      F x * textbookLangevinPeriodicDirectionalDerivative G v x +
        G x * textbookLangevinPeriodicDirectionalDerivative F v x := by
  let z : textbookLangevinPhase N := (textbookConfigurationTorusRepresentative x.1, x.2)
  have hm : HasFDerivAt ((fun y ↦ F y * G y) ∘ textbookLangevinPeriodicProjection)
      ((F ∘ textbookLangevinPeriodicProjection) z • fderiv ℝ (G ∘ textbookLangevinPeriodicProjection) z +
        (G ∘ textbookLangevinPeriodicProjection) z • fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z) z := by
    simpa only [Function.comp_apply, Pi.mul_apply] using!
      (hF.differentiable (by simp) z).hasFDerivAt.mul (hG.differentiable (by simp) z).hasFDerivAt
  unfold textbookLangevinPeriodicDirectionalDerivative
  change fderiv ℝ ((fun y ↦ F y * G y) ∘ textbookLangevinPeriodicProjection) z v = _
  rw [hm.fderiv]
  simp only [add_apply, _root_.smul_apply, smul_eq_mul]
  dsimp only [z]
  rw [energy_rep, energy_rep]

private theorem energy_D_add {N : ℕ} (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (v : textbookLangevinPhase N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (fun y ↦ F y + G y) v x =
      textbookLangevinPeriodicDirectionalDerivative F v x +
        textbookLangevinPeriodicDirectionalDerivative G v x := by
  let z : textbookLangevinPhase N := (textbookConfigurationTorusRepresentative x.1, x.2)
  have hm : HasFDerivAt ((fun y ↦ F y + G y) ∘ textbookLangevinPeriodicProjection)
      (fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z +
        fderiv ℝ (G ∘ textbookLangevinPeriodicProjection) z) z := by
    simpa only [Function.comp_apply, Pi.add_apply] using!
      (hF.differentiable (by simp) z).hasFDerivAt.add (hG.differentiable (by simp) z).hasFDerivAt
  unfold textbookLangevinPeriodicDirectionalDerivative
  change fderiv ℝ ((fun y ↦ F y + G y) ∘ textbookLangevinPeriodicProjection) z v = _
  rw [hm.fderiv]
  rfl

private theorem energy_D_twice_mul {N : ℕ} (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (v : textbookLangevinPhase N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative
      (textbookLangevinPeriodicDirectionalDerivative (fun y ↦ F y * G y) v) v x =
      F x * textbookLangevinPeriodicDirectionalDerivative (textbookLangevinPeriodicDirectionalDerivative G v) v x +
      G x * textbookLangevinPeriodicDirectionalDerivative (textbookLangevinPeriodicDirectionalDerivative F v) v x +
      2 * textbookLangevinPeriodicDirectionalDerivative F v x * textbookLangevinPeriodicDirectionalDerivative G v x := by
  have hDF := textbookLangevinPeriodicDirectionalDerivative_lift_contDiff F hF v
  have hDG := textbookLangevinPeriodicDirectionalDerivative_lift_contDiff G hG v
  have he : textbookLangevinPeriodicDirectionalDerivative (fun y ↦ F y * G y) v =
      fun y ↦ F y * textbookLangevinPeriodicDirectionalDerivative G v y +
        G y * textbookLangevinPeriodicDirectionalDerivative F v y :=
    funext (fun y ↦ textbookLangevinPeriodicDirectionalDerivative_mul F G hF hG v y)
  rw [he, energy_D_add _ _ (energy_lift_mul F _ hF hDG) (energy_lift_mul G _ hG hDF)]
  rw [textbookLangevinPeriodicDirectionalDerivative_mul F _ hF hDG,
    textbookLangevinPeriodicDirectionalDerivative_mul G _ hG hDF]
  ring

/-- The actual squared momentum-gradient magnitude of an original phase
test, in the textbook's sum-of-coordinate-squares convention. -/
def textbookLangevinPeriodicMomentumGradientSquare {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (x : textbookLangevinPeriodicPhase N) : ℝ :=
  ∑ i : Fin N, (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) ^ 2

/-- The literal original operator has its true diffusion product rule on
arbitrary smooth periodic phase tests. -/
theorem textbookLangevinPeriodicDifferentialOperator_product {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDifferentialOperator U γ σ (fun y ↦ F y * G y) x =
      F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x +
      G x * textbookLangevinPeriodicDifferentialOperator U γ σ F x +
      σ ^ 2 * ∑ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
        textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x := by
  rw [textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp β γ σ hβ hσ _ (energy_lift_mul F G hF hG),
    textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp β γ σ hβ hσ G hG,
    textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp β γ σ hβ hσ F hF]
  simp_rw [energy_D_twice_mul F G hF hG, textbookLangevinPeriodicDirectionalDerivative_mul F G hF hG]
  rw [hσ]
  simp only [div_eq_mul_inv, mul_add, mul_assoc, Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  ring

private theorem energy_gamma_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsF : HasCompactSupport F) :
    Integrable (fun x ↦ ∑ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
      textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x)
      (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  apply integrable_finsetSum
  intro i _
  exact ((textbookLangevinPeriodicDirectionalDerivative_continuous F hF _).mul
    (textbookLangevinPeriodicDirectionalDerivative_continuous G hG _)).integrable_of_hasCompactSupport
      (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hsF _).mul_right

/-- The actual canonical symmetric bilinear energy identity on the genuine
compact smooth phase tests follows from proved full-phase weak balance of
their product and true joint integrability, without an adjoint assumption. -/
theorem textbookLangevinCanonicalMeasure_bilinear_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    (∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x ∂textbookLangevinCanonicalMeasure U β hβ) +
      (∫ x, G x * textbookLangevinPeriodicDifferentialOperator U γ σ F x ∂textbookLangevinCanonicalMeasure U β hβ) =
      -σ ^ 2 * ∫ x, ∑ i : Fin N,
        textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
          textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x
            ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous
  have hGc : Continuous G :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  have hi1 : Integrable (fun x ↦ F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (hFc.mul (textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ G
      (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)))).integrable_of_hasCompactSupport hsF.mul_right
  have hi2 : Integrable (fun x ↦ G x * textbookLangevinPeriodicDifferentialOperator U γ σ F x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (hGc.mul (textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ F
      (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)))).integrable_of_hasCompactSupport hsG.mul_right
  have hiΓ := energy_gamma_integrable U hU hp β hβ F G hF hG hsF
  have hi12 : Integrable (fun x ↦ F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x +
      G x * textbookLangevinPeriodicDifferentialOperator U γ σ F x) (textbookLangevinCanonicalMeasure U β hβ) := by
    simpa only [Pi.add_apply] using! hi1.add hi2
  have hi3 : Integrable (fun x ↦ σ ^ 2 * ∑ i : Fin N,
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
        textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x) (textbookLangevinCanonicalMeasure U β hβ) :=
    hiΓ.const_mul (σ ^ 2)
  have hz := textbookLangevinCanonicalMeasure_weak_balance U hU hp β γ σ hβ hσ
    (fun x ↦ F x * G x) (energy_lift_mul F G hF hG) hsF.mul_right
  have he : textbookLangevinPeriodicDifferentialOperator U γ σ (fun x ↦ F x * G x) =
      fun x ↦ F x * textbookLangevinPeriodicDifferentialOperator U γ σ G x +
        G x * textbookLangevinPeriodicDifferentialOperator U γ σ F x +
        σ ^ 2 * ∑ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
          textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x :=
    funext (fun x ↦ textbookLangevinPeriodicDifferentialOperator_product U hU hp β γ σ hβ hσ F G hF hG x)
  rw [he, integral_add hi12 hi3, integral_add hi1 hi2, integral_const_mul] at hz
  linarith

/-- The actual canonical energy is precisely the negative physical
momentum-gradient energy on the compact smooth phase tests. -/
theorem textbookLangevinCanonicalMeasure_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ σ F x ∂textbookLangevinCanonicalMeasure U β hβ) =
      -(γ * β⁻¹) * ∫ x, textbookLangevinPeriodicMomentumGradientSquare F x ∂textbookLangevinCanonicalMeasure U β hβ := by
  have hb := textbookLangevinCanonicalMeasure_bilinear_energy U hU hp β γ σ hβ hσ F F hF hF hs hs
  have he : (fun x ↦ ∑ i : Fin N,
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
        textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) =
      textbookLangevinPeriodicMomentumGradientSquare F := by
    funext x
    unfold textbookLangevinPeriodicMomentumGradientSquare
    apply Finset.sum_congr rfl
    intro i _
    ring
  rw [he, hσ] at hb
  simp only [div_eq_mul_inv] at hb
  nlinarith [hb]

/-- The same true energy identity holds with the actual physical noise
sigma equal to the positive fluctuation-dissipation square root. -/
theorem textbookLangevinCanonicalMeasure_physical_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹)) F x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
      -(γ * β⁻¹) * ∫ x, textbookLangevinPeriodicMomentumGradientSquare F x ∂textbookLangevinCanonicalMeasure U β hβ := by
  apply textbookLangevinCanonicalMeasure_energy U hU hp β γ _ hβ _ F hF hs
  simpa only [div_eq_mul_inv] using
    Real.sq_sqrt (mul_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hγ.le) (inv_nonneg.mpr hβ.le))

/-- A true zero mode among the genuine compact smooth phase tests has
zero momentum gradient almost everywhere for the actual canonical law.
No extension to all weighted H1 zero modes is asserted. -/
theorem textbookLangevinCanonicalMeasure_zero_mode_momentum_gradient_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (hz : ∀ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x = 0) :
    ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      ∀ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x = 0 := by
  have he := textbookLangevinCanonicalMeasure_energy U hU hp β γ σ hβ hσ F hF hs
  have hzL : (∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ σ F x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by simp_rw [hz]; simp
  have hiΓ : Integrable (textbookLangevinPeriodicMomentumGradientSquare F) (textbookLangevinCanonicalMeasure U β hβ) := by
    convert! energy_gamma_integrable U hU hp β hβ F F hF hF hs using 1
    funext x
    unfold textbookLangevinPeriodicMomentumGradientSquare
    apply Finset.sum_congr rfl
    intro i _
    ring
  have hcoef : 0 < γ * β⁻¹ := mul_pos hγ (inv_pos.mpr hβ)
  have hzI : (∫ x, textbookLangevinPeriodicMomentumGradientSquare F x ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
    rw [hzL] at he
    exact (mul_eq_zero.mp he.symm).resolve_left (neg_ne_zero.mpr hcoef.ne')
  have hn (x : textbookLangevinPeriodicPhase N) : 0 ≤ textbookLangevinPeriodicMomentumGradientSquare F x :=
    Finset.sum_nonneg (fun _ _ ↦ sq_nonneg _)
  have hae := (integral_eq_zero_iff_of_nonneg hn hiΓ).mp hzI
  filter_upwards [hae] with x hx
  intro i
  have hle : (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) ^ 2 ≤
      textbookLangevinPeriodicMomentumGradientSquare F x :=
    Finset.single_le_sum (fun j _ ↦ sq_nonneg (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single j 1) x)) (Finset.mem_univ i)
  have heq : (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) ^ 2 = 0 :=
    le_antisymm (hle.trans_eq (show textbookLangevinPeriodicMomentumGradientSquare F x = 0 from hx)) (sq_nonneg _)
  exact (sq_eq_zero_iff).mp heq

/-- On each genuine compact smooth test in the proved actual C0 domain,
the same actual closed generator has the canonical energy identity. -/
theorem textbookLangevinCanonicalMeasure_C0_generator_energy
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hForce : LipschitzWith L (textbookPotentialForce U))
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x, F x *
      (textbookLangevinPeriodicC0Generator B P hB U hU hp L hForce γ σ hγ
        ⟨textbookLangevinPeriodicCompactC2Observable F (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs,
          textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hForce γ σ hγ F
            (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs⟩) x ∂textbookLangevinCanonicalMeasure U β hβ) =
      -(γ * β⁻¹) * ∫ x, textbookLangevinPeriodicMomentumGradientSquare F x ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [textbookLangevinPeriodicC0Generator_compactC2_apply]
  exact textbookLangevinCanonicalMeasure_energy U hU hp β γ σ hβ hσ F hF hs

/-- The actual canonical phase density is continuous through the true open
quotient, from its verified original real smooth density lift. -/
theorem textbookLangevinCanonicalDensity_continuous {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Continuous (textbookLangevinCanonicalDensity U β) := by
  apply (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr
  have he : textbookLangevinCanonicalDensity U β ∘ textbookLangevinPeriodicProjection =
      textbookLangevinCanonicalDensityReal U β :=
    funext (textbookLangevinCanonicalDensity_lift U hU hp β hβ)
  rw [he]
  exact (textbookLangevinCanonicalDensityReal_contDiff U hU β).continuous

/-- The genuine original canonical probability has positive mass on every
nonempty open phase set, derived from its actual strictly positive density
on true position Haar times momentum Lebesgue measure. -/
theorem textbookLangevinCanonicalMeasure_isOpenPosMeasure {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Measure.IsOpenPosMeasure (textbookLangevinCanonicalMeasure U β hβ) := by
  rw [textbookLangevinCanonicalMeasure_withDensity U hU hp β hβ]
  have hm : Measurable (fun x ↦ ENNReal.ofReal (textbookLangevinCanonicalDensity U β x)) :=
    (textbookLangevinCanonicalDensity_continuous U hU hp β hβ).measurable.ennreal_ofReal
  have hn : ∀ᵐ x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))),
      ENNReal.ofReal (textbookLangevinCanonicalDensity U β x) ≠ 0 :=
    Eventually.of_forall (fun x ↦ (ENNReal.ofReal_pos.mpr (textbookLangevinCanonicalDensity_pos U hU β hβ x)).ne')
  exact (withDensity_absolutelyContinuous' hm.aemeasurable hn).isOpenPosMeasure

/-- For an actual smooth phase observable, zero momentum gradient almost
everywhere for the actual full-support canonical law is true pointwise
zero momentum gradient. No compactness or zero-mode conclusion is assumed. -/
theorem textbookLangevinCanonicalMeasure_momentum_gradient_ae_zero_pointwise {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hae : ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      ∀ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x = 0) :
    ∀ x, ∀ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x = 0 := by
  have : Measure.IsOpenPosMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isOpenPosMeasure U hU hp β hβ
  intro x i
  have hi : textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) =ᵐ[textbookLangevinCanonicalMeasure U β hβ] 0 :=
    hae.mono (fun y hy ↦ hy i)
  have he := Measure.eq_of_ae_eq hi
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF (0, Pi.single i 1)) continuous_const
  exact congrFun he x

private theorem energy_p_slice_fderiv {N : ℕ}
    (g : textbookLangevinPhase N → ℝ) (hg : ContDiff ℝ ∞ g)
    (q p v : Fin N → ℝ) :
    fderiv ℝ (fun y ↦ g (q, y)) p v = fderiv ℝ g (q, p) (0, v) := by
  have hi : HasFDerivAt (fun y : Fin N → ℝ ↦ (q, y))
      ((0 : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)).prod (ContinuousLinearMap.id ℝ (Fin N → ℝ))) p := by
    simpa only [id_eq] using! (hasFDerivAt_const q p).prodMk (hasFDerivAt_id (𝕜 := ℝ) p)
  have h : HasFDerivAt (fun y ↦ g (q, y))
      ((fderiv ℝ g (q, p)).comp
        ((0 : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)).prod (ContinuousLinearMap.id ℝ (Fin N → ℝ)))) p := by
    simpa only [Function.comp_def] using! (hg.differentiable (by simp) (q, p)).hasFDerivAt.comp p hi
  rw [h.fderiv]
  rfl

/-- The actual canonical almost-everywhere zero momentum gradient of a
smooth phase observable implies true independence of every momentum value,
by genuine coordinate Frechet calculus and the mean-value theorem.
This is the smooth-observable stage, not an extension to all weighted H1. -/
theorem textbookLangevinCanonicalMeasure_momentum_gradient_ae_zero_independent {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hae : ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      ∀ i : Fin N, textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x = 0) :
    ∀ Q : UnitAddTorus (Fin N), ∀ p r : Fin N → ℝ, F (Q, p) = F (Q, r) := by
  have hz := textbookLangevinCanonicalMeasure_momentum_gradient_ae_zero_pointwise U hU hp β hβ F hF hae
  intro Q p r
  let f := fun y : Fin N → ℝ ↦ F (Q, y)
  have heF : f = fun y ↦ (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, y) :=
    funext (fun y ↦ (energy_rep F Q y).symm)
  have hf : ContDiff ℝ ∞ f := by
    rw [heF]
    exact hF.comp (contDiff_const.prodMk contDiff_id)
  have hD (y : Fin N → ℝ) (i : Fin N) :
      fderiv ℝ f y (Pi.single i 1) = textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) (Q, y) := by
    rw [heF]
    exact energy_p_slice_fderiv _ hF _ y _
  have hdf (y : Fin N → ℝ) : fderiv ℝ f y = 0 := by
    ext v
    rw [pi_eq_sum_univ' v, map_sum]
    simp only [map_smul]
    simp_rw [hD, hz]
    simp
  exact is_const_of_fderiv_eq_zero (hf.differentiable (by simp)) hdf p r

end
end MolecularDynamics
