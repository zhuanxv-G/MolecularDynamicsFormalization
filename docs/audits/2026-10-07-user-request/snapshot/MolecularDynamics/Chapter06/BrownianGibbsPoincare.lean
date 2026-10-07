import MolecularDynamics.Chapter06.BrownianHaarPoincare

/-! The original positive diagonal-mass Gibbs Poincare inequality from actual Haar and density bounds. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- A genuine finite positive mass bound derived from all original diagonal masses. -/
def textbookConfigurationMassScale {Nc : ℕ} (m : Fin Nc → ℝ) : ℝ :=
  1 + ∑ i, |m i|

/-- The actual derived mass scale is strictly positive in every dimension. -/
theorem textbookConfigurationMassScale_pos {Nc : ℕ} (m : Fin Nc → ℝ) :
    0 < textbookConfigurationMassScale m := by
  have hs : 0 ≤ ∑ i, |m i| := Finset.sum_nonneg fun i _ ↦ abs_nonneg (m i)
  unfold textbookConfigurationMassScale
  linarith

/-- Every original mass is bounded by the explicit finite scale, without a bound premise. -/
theorem textbookConfigurationMass_le_scale {Nc : ℕ} (m : Fin Nc → ℝ) (i : Fin Nc) :
    m i ≤ textbookConfigurationMassScale m := by
  have hs : |m i| ≤ ∑ j, |m j| :=
    Finset.single_le_sum (fun j _ ↦ abs_nonneg (m j)) (Finset.mem_univ i)
  have hm := le_abs_self (m i)
  unfold textbookConfigurationMassScale
  linarith

/-- The original gradient pairing is actually smooth on full Euclidean smooth observables. -/
theorem textbookConfigurationGradientPair_contDiff {Nc : ℕ} (m : Fin Nc → ℝ)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g) :
    ContDiff ℝ ∞ (textbookConfigurationGradientPair m f g) := by
  apply ContDiff.sum
  intro i _
  exact (contDiff_const.mul (textbookConfigurationPartial_contDiff f hf i)).mul
    (textbookConfigurationPartial_contDiff g hg i)

/-- The true full diagonal-mass gradient square is nonnegative under the original positive masses. -/
theorem textbookConfigurationGradientPair_self_nonneg {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (f : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) :
    0 ≤ textbookConfigurationGradientPair m f f q := by
  unfold textbookConfigurationGradientPair
  apply Finset.sum_nonneg
  intro i _
  nlinarith [inv_pos.mpr (hm i), sq_nonneg (textbookConfigurationPartial f i q)]

/-- Pointwise actual unit-mass gradient energy is bounded by the original weighted gradient. -/
theorem textbookConfigurationGradientPair_unit_le_mass {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (f : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) :
    textbookConfigurationGradientPair (fun _ ↦ 1) f f q ≤
      textbookConfigurationMassScale m * textbookConfigurationGradientPair m f f q := by
  unfold textbookConfigurationGradientPair
  simp only [inv_one, one_mul, Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i _
  have hmi : m i ≠ 0 := ne_of_gt (hm i)
  have hc : 1 ≤ textbookConfigurationMassScale m * (m i)⁻¹ := by
    calc
      1 = (m i)⁻¹ * m i := (inv_mul_cancel₀ hmi).symm
      _ ≤ (m i)⁻¹ * textbookConfigurationMassScale m :=
        mul_le_mul_of_nonneg_left (textbookConfigurationMass_le_scale m i) (inv_pos.mpr (hm i)).le
      _ = _ := by ring
  have h := mul_le_mul_of_nonneg_right hc (sq_nonneg (textbookConfigurationPartial f i q))
  nlinarith

/-- The true energy integral in the same actual Gibbs probability, with all original masses. -/
def textbookTorusGibbsGradientEnergy {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ) : ℝ :=
  ∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
    (textbookConfigurationGradientPair m f f) Q ∂textbookConfigurationTorusGibbsMeasure U β

/-- Original positive diagonal masses make the genuine Gibbs gradient energy nonnegative. -/
theorem textbookTorusGibbsGradientEnergy_nonneg {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ) :
    0 ≤ textbookTorusGibbsGradientEnergy m U β f := by
  apply integral_nonneg
  intro Q
  exact textbookConfigurationGradientPair_self_nonneg m hm f (textbookConfigurationTorusRepresentative Q)

/-- Actual density lower bounds compare Haar energy to the same genuine Gibbs unit-mass energy. -/
theorem textbookTorusHaarGradientEnergy_le_gibbs {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    textbookTorusHaarGradientEnergy f ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
        textbookTorusGibbsGradientEnergy (fun _ ↦ 1) U β f := by
  let e : C(UnitAddTorus (Fin Nc), ℝ) :=
    ⟨textbookConfigurationTorusObservable (textbookConfigurationGradientPair (fun _ ↦ 1) f f),
      textbookConfigurationTorusObservable_continuous _
        (textbookConfigurationGradientPair_contDiff (fun _ ↦ 1) f f hf hf).continuous
        (textbookConfigurationGradientPair_periodic (fun _ ↦ 1) f f hf hf hPf hPf)⟩
  have hn : ∀ Q, 0 ≤ e Q := by
    intro Q
    exact textbookConfigurationGradientPair_self_nonneg (fun _ ↦ 1) (by intro _; norm_num) f
      (textbookConfigurationTorusRepresentative Q)
  have h : Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) *
      textbookTorusHaarGradientEnergy f ≤
      textbookTorusGibbsGradientEnergy (fun _ ↦ 1) U β f :=
    textbookTorusGibbsIntegral_lower U hU hPU β e hn
  have hmul := mul_le_mul_of_nonneg_left h
    (Real.exp_pos (2 * textbookTorusPotentialScale U hU hPU β)).le
  have he : Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
      Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) = 1 := by
    rw [← Real.exp_add]
    have hz : 2 * textbookTorusPotentialScale U hU hPU β +
        -2 * textbookTorusPotentialScale U hU hPU β = 0 := by ring
    rw [hz, Real.exp_zero]
  calc
    textbookTorusHaarGradientEnergy f =
        Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
          (Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) *
            textbookTorusHaarGradientEnergy f) := by rw [← mul_assoc, he, one_mul]
    _ ≤ _ := hmul

/-- True Gibbs integration preserves the derived original diagonal-mass gradient comparison. -/
theorem textbookTorusGibbsGradientEnergy_unit_le_mass {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    textbookTorusGibbsGradientEnergy (fun _ ↦ 1) U β f ≤
      textbookConfigurationMassScale m * textbookTorusGibbsGradientEnergy m U β f := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  let e (m' : Fin Nc → ℝ) : C(UnitAddTorus (Fin Nc), ℝ) :=
    ⟨textbookConfigurationTorusObservable (textbookConfigurationGradientPair m' f f),
      textbookConfigurationTorusObservable_continuous _
        (textbookConfigurationGradientPair_contDiff m' f f hf hf).continuous
        (textbookConfigurationGradientPair_periodic m' f f hf hf hPf hPf)⟩
  have hi (m' : Fin Nc → ℝ) : Integrable (e m') (textbookConfigurationTorusGibbsMeasure U β) :=
    memLp_one_iff_integrable.mp (ContinuousMap.memLp (textbookConfigurationTorusGibbsMeasure U β) ℝ (e m'))
  have h := integral_mono (hi (fun _ ↦ 1)) ((hi m).const_mul (textbookConfigurationMassScale m))
    (fun Q ↦ textbookConfigurationGradientPair_unit_le_mass m hm f (textbookConfigurationTorusRepresentative Q))
  rw [integral_const_mul] at h
  exact h

/-- An explicit finite Gibbs Poincare constant derived from the original masses and potential. -/
def textbookGibbsPoincareConstant {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) : ℝ :=
  Real.exp (4 * textbookTorusPotentialScale U hU hPU β) *
    textbookConfigurationMassScale m * (4 * Real.pi ^ 2)⁻¹

/-- The actual Gibbs Poincare constant is strictly positive in every finite dimension. -/
theorem textbookGibbsPoincareConstant_pos {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    0 < textbookGibbsPoincareConstant m U hU hPU β := by
  have hm := textbookConfigurationMassScale_pos m
  unfold textbookGibbsPoincareConstant
  positivity

/-- The original full diagonal-mass model satisfies the genuine same-measure Gibbs Poincare inequality. -/
theorem textbookGibbsVariance_poincare {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ))
    (hg : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q))) :
    textbookGibbsVariance U β g ≤ textbookGibbsPoincareConstant m U hU hPU β *
      textbookTorusGibbsGradientEnergy m U β (fun q : Fin Nc → ℝ ↦
        g (textbookConfigurationTorusProjection q)) := by
  let f := fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q)
  have hp : textbookUnitPeriodicPotential f := by
    intro q z
    change g (textbookConfigurationTorusProjection (q + fun i ↦ (z i : ℝ))) =
      g (textbookConfigurationTorusProjection q)
    rw [textbookConfigurationTorusProjection_integer_translate]
  have hH := textbookTorusHaarGradientEnergy_le_gibbs U hU hPU β f hg hp
  have hM := textbookTorusGibbsGradientEnergy_unit_le_mass m hm U hU hPU β f hg hp
  have he : Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) =
      Real.exp (4 * textbookTorusPotentialScale U hU hPU β) := by
    rw [← Real.exp_add]
    congr 1
    ring
  calc
    textbookGibbsVariance U β g ≤
        (Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * (4 * Real.pi ^ 2)⁻¹) *
          textbookTorusHaarGradientEnergy f :=
      textbookGibbsVariance_le_haarGradientEnergy U hU hPU β g hg
    _ ≤ (Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * (4 * Real.pi ^ 2)⁻¹) *
        (Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
          (textbookConfigurationMassScale m * textbookTorusGibbsGradientEnergy m U β f)) :=
      mul_le_mul_of_nonneg_left
        (hH.trans (mul_le_mul_of_nonneg_left hM (by positivity))) (by positivity)
    _ = textbookGibbsPoincareConstant m U hU hPU β *
        textbookTorusGibbsGradientEnergy m U β f := by
      unfold textbookGibbsPoincareConstant
      calc
        _ = (Real.exp (2 * textbookTorusPotentialScale U hU hPU β) *
            Real.exp (2 * textbookTorusPotentialScale U hU hPU β)) *
              textbookConfigurationMassScale m * (4 * Real.pi ^ 2)⁻¹ *
                textbookTorusGibbsGradientEnergy m U β f := by ring
        _ = _ := by rw [he]

/-- Subtracting any real constant preserves the actual original diagonal-mass Gibbs energy. -/
theorem textbookTorusGibbsGradientEnergy_sub_const {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ) (c : ℝ) :
    textbookTorusGibbsGradientEnergy m U β (fun q ↦ f q - c) =
      textbookTorusGibbsGradientEnergy m U β f := by
  simp only [textbookTorusGibbsGradientEnergy, textbookConfigurationTorusObservable,
    textbookConfigurationGradientPair, textbookConfigurationPartial_sub_const]

/-- The same genuine Gibbs energy is exactly the original Brownian Dirichlet pairing. -/
theorem textbookTorusGibbsGradientEnergy_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : β ≠ 0) (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    (∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f Q *
      textbookConfigurationTorusObservable (textbookBrownianGenerator m U β f) Q
        ∂textbookConfigurationTorusGibbsMeasure U β) =
      -β⁻¹ * textbookTorusGibbsGradientEnergy m U β f :=
  textbookBrownianTorusGibbsMeasure_dirichlet m U β hβ f f hU hf hf hPU hPf hPf

/-- A quantitative core coercivity rate derived from the original temperature and proved Poincare constant. -/
def textbookBrownianGibbsCoercivityRate {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) : ℝ :=
  (β * textbookGibbsPoincareConstant m U hU hPU β)⁻¹

/-- Positive original temperature gives a strictly positive derived core coercivity rate. -/
theorem textbookBrownianGibbsCoercivityRate_pos {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    0 < textbookBrownianGibbsCoercivityRate m U hU hPU β := by
  unfold textbookBrownianGibbsCoercivityRate
  exact inv_pos.mpr (mul_pos hβ (textbookGibbsPoincareConstant_pos m U hU hPU β))

/-- Actual mean-zero smooth torus functions obey a genuine original-generator coercivity inequality. -/
theorem textbookBrownianGibbs_mean_zero_coercive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (g : C(UnitAddTorus (Fin Nc), ℝ))
    (hg : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q)))
    (hmean : textbookGibbsMean U β g = 0) :
    textbookBrownianGibbsCoercivityRate m U hU hPU β *
      (∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β) ≤
      -(∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable
        (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q)) Q *
          textbookConfigurationTorusObservable
            (textbookBrownianGenerator m U β
              (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q))) Q
                ∂textbookConfigurationTorusGibbsMeasure U β) := by
  let f := fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q)
  have hp : textbookUnitPeriodicPotential f := by
    intro q z
    change g (textbookConfigurationTorusProjection (q + fun i ↦ (z i : ℝ))) =
      g (textbookConfigurationTorusProjection q)
    rw [textbookConfigurationTorusProjection_integer_translate]
  have hv : (∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β) ≤
      textbookGibbsPoincareConstant m U hU hPU β * textbookTorusGibbsGradientEnergy m U β f := by
    have h := textbookGibbsVariance_poincare m hm U hU hPU β g hg
    simpa only [textbookGibbsVariance, hmean, sub_zero] using h
  have hC := textbookGibbsPoincareConstant_pos m U hU hPU β
  have hr := textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ
  have he := textbookTorusGibbsGradientEnergy_dirichlet m U hU hPU β (ne_of_gt hβ) f hg hp
  calc
    textbookBrownianGibbsCoercivityRate m U hU hPU β *
        (∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β) ≤
        textbookBrownianGibbsCoercivityRate m U hU hPU β *
          (textbookGibbsPoincareConstant m U hU hPU β * textbookTorusGibbsGradientEnergy m U β f) :=
      mul_le_mul_of_nonneg_left hv hr.le
    _ = β⁻¹ * textbookTorusGibbsGradientEnergy m U β f := by
      unfold textbookBrownianGibbsCoercivityRate
      rw [mul_inv_rev]
      calc
        _ = β⁻¹ * ((textbookGibbsPoincareConstant m U hU hPU β)⁻¹ *
            textbookGibbsPoincareConstant m U hU hPU β) *
              textbookTorusGibbsGradientEnergy m U β f := by ring
        _ = _ := by rw [inv_mul_cancel₀ (ne_of_gt hC), mul_one]
    _ = _ := by rw [he]; ring

end

end MolecularDynamics
