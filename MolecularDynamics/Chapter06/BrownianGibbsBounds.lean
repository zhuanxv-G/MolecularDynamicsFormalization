import MolecularDynamics.Chapter06.BrownianClosedOperator

/-! Actual Gibbs density bounds on the original compact torus, for Theorem 6.1. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)

/-- The actual original periodic potential as a genuine continuous torus function. -/
def textbookTorusPotentialContinuous : C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨textbookConfigurationTorusObservable U,
    textbookConfigurationTorusObservable_continuous U hU.continuous hPU⟩

/-- The original torus potential is bounded by its actual sup norm, without a bound premise. -/
theorem textbookTorusPotential_abs_le_norm (Q : UnitAddTorus (Fin Nc)) :
    |textbookConfigurationTorusObservable U Q| ≤ ‖textbookTorusPotentialContinuous U hU hPU‖ :=
  (textbookTorusPotentialContinuous U hU hPU).norm_coe_le_norm Q

/-- The derived explicit size of the original Boltzmann exponent. -/
def textbookTorusPotentialScale : ℝ :=
  |β| * ‖textbookTorusPotentialContinuous U hU hPU‖

/-- The actual exponent scale is nonnegative. -/
theorem textbookTorusPotentialScale_nonneg : 0 ≤ textbookTorusPotentialScale U hU hPU β :=
  mul_nonneg (abs_nonneg β) (norm_nonneg _)

/-- The literal original Gibbs exponent has this derived uniform bound. -/
theorem textbookTorusGibbsExponent_abs_le (Q : UnitAddTorus (Fin Nc)) :
    |-β * textbookConfigurationTorusObservable U Q| ≤ textbookTorusPotentialScale U hU hPU β := by
  rw [abs_mul, abs_neg]
  exact mul_le_mul_of_nonneg_left (textbookTorusPotential_abs_le_norm U hU hPU Q) (abs_nonneg β)

/-- The original unnormalized torus Gibbs weight has a strictly positive explicit lower bound. -/
theorem textbookTorusGibbsWeight_lower (Q : UnitAddTorus (Fin Nc)) :
    Real.exp (-textbookTorusPotentialScale U hU hPU β) ≤
      textbookConfigurationTorusGibbsWeight U β Q :=
  Real.exp_le_exp.mpr (abs_le.mp (textbookTorusGibbsExponent_abs_le U hU hPU β Q)).1

/-- The original unnormalized torus Gibbs weight has a finite explicit upper bound. -/
theorem textbookTorusGibbsWeight_upper (Q : UnitAddTorus (Fin Nc)) :
    textbookConfigurationTorusGibbsWeight U β Q ≤ Real.exp (textbookTorusPotentialScale U hU hPU β) :=
  Real.exp_le_exp.mpr (abs_le.mp (textbookTorusGibbsExponent_abs_le U hU hPU β Q)).2

/-- The same original partition has the derived explicit positive lower bound. -/
theorem textbookTorusPartition_lower :
    Real.exp (-textbookTorusPotentialScale U hU hPU β) ≤ textbookConfigurationPartition U β := by
  have h := integral_mono (integrable_const (Real.exp (-textbookTorusPotentialScale U hU hPU β)))
    (textbookConfigurationTorusGibbsWeight_integrable U hU hPU β)
    (textbookTorusGibbsWeight_lower U hU hPU β)
  rw [textbookConfigurationTorusGibbsWeight_integral U hPU β] at h
  simpa using h

/-- The same original partition has the derived finite upper bound. -/
theorem textbookTorusPartition_upper :
    textbookConfigurationPartition U β ≤ Real.exp (textbookTorusPotentialScale U hU hPU β) := by
  have h := integral_mono (textbookConfigurationTorusGibbsWeight_integrable U hU hPU β)
    (integrable_const (Real.exp (textbookTorusPotentialScale U hU hPU β)))
    (textbookTorusGibbsWeight_upper U hU hPU β)
  rw [textbookConfigurationTorusGibbsWeight_integral U hPU β] at h
  simpa using h

/-- The literal real density already used in the original Gibbs withDensity measure. -/
def textbookConfigurationTorusGibbsDensity (Q : UnitAddTorus (Fin Nc)) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q

include hU in
/-- The actual Gibbs density is genuinely strictly positive everywhere. -/
theorem textbookConfigurationTorusGibbsDensity_pos (Q : UnitAddTorus (Fin Nc)) :
    0 < textbookConfigurationTorusGibbsDensity U β Q :=
  mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β)) (Real.exp_pos _)

/-- The same actual normalized Gibbs density has an explicit uniform positive lower bound. -/
theorem textbookTorusGibbsDensity_lower (Q : UnitAddTorus (Fin Nc)) :
    Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) ≤
      textbookConfigurationTorusGibbsDensity U β Q := by
  let A := textbookTorusPotentialScale U hU hPU β
  have hZ := textbookConfigurationPartition_pos U hU β
  have hInv : Real.exp (-A) ≤ (textbookConfigurationPartition U β)⁻¹ := by
    rw [Real.exp_neg]
    simpa only [one_div] using one_div_le_one_div_of_le hZ (textbookTorusPartition_upper U hU hPU β)
  calc
    Real.exp (-2 * A) = Real.exp (-A) * Real.exp (-A) := by
      rw [← Real.exp_add]
      congr 1
      ring
    _ ≤ textbookConfigurationTorusGibbsDensity U β Q :=
      mul_le_mul hInv (textbookTorusGibbsWeight_lower U hU hPU β Q)
        (Real.exp_pos _).le (inv_pos.mpr hZ).le

/-- The same actual normalized Gibbs density has an explicit uniform finite upper bound. -/
theorem textbookTorusGibbsDensity_upper (Q : UnitAddTorus (Fin Nc)) :
    textbookConfigurationTorusGibbsDensity U β Q ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) := by
  let A := textbookTorusPotentialScale U hU hPU β
  have hInv : (textbookConfigurationPartition U β)⁻¹ ≤ Real.exp A := by
    have h := one_div_le_one_div_of_le (Real.exp_pos (-A)) (textbookTorusPartition_lower U hU hPU β)
    simpa only [one_div, ← Real.exp_neg, neg_neg] using h
  calc
    textbookConfigurationTorusGibbsDensity U β Q ≤ Real.exp A * Real.exp A :=
      mul_le_mul hInv (textbookTorusGibbsWeight_upper U hU hPU β Q)
        (Real.exp_pos _).le (Real.exp_pos _).le
    _ = Real.exp (2 * A) := by
      rw [← Real.exp_add]
      congr 1
      ring

include hU hPU in
/-- The actual real Gibbs density is continuous on the genuine torus. -/
theorem textbookConfigurationTorusGibbsDensity_continuous :
    Continuous (textbookConfigurationTorusGibbsDensity U β) :=
  continuous_const.mul (Real.continuous_exp.comp (continuous_const.mul
    (textbookConfigurationTorusObservable_continuous U hU.continuous hPU)))

include hU hPU in
/-- The actual density times every continuous observable is Haar-integrable. -/
theorem textbookTorusGibbsDensity_mul_integrable (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    Integrable (fun Q ↦ textbookConfigurationTorusGibbsDensity U β Q * g Q) := by
  exact memLp_one_iff_integrable.mp (ContinuousMap.memLp volume ℝ
    ⟨fun Q ↦ textbookConfigurationTorusGibbsDensity U β Q * g Q,
      (textbookConfigurationTorusGibbsDensity_continuous U hU hPU β).mul g.continuous⟩)

include hU hPU in
/-- The actual Gibbs integral is literally Haar integration against its already constructed density. -/
theorem textbookTorusGibbsDensity_integral (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    (∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β) =
      ∫ Q, textbookConfigurationTorusGibbsDensity U β Q * g Q := by
  have hm : Measurable (fun Q ↦ ENNReal.ofReal (textbookConfigurationTorusGibbsDensity U β Q)) :=
    (textbookConfigurationTorusGibbsDensity_continuous U hU hPU β).measurable.ennreal_ofReal
  change (∫ Q, g Q ∂volume.withDensity
    (fun Q ↦ ENNReal.ofReal (textbookConfigurationTorusGibbsDensity U β Q))) = _
  rw [integral_withDensity_eq_integral_toReal_smul hm
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top) _]
  simp_rw [ENNReal.toReal_ofReal (textbookConfigurationTorusGibbsDensity_pos U hU β _).le,
    smul_eq_mul]

/-- Actual positive continuous-observable integrals have the derived explicit Gibbs lower comparison. -/
theorem textbookTorusGibbsIntegral_lower (g : C(UnitAddTorus (Fin Nc), ℝ)) (hg : ∀ Q, 0 ≤ g Q) :
    Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) * (∫ Q, g Q) ≤
      ∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookTorusGibbsDensity_integral U hU hPU β g]
  have hi : Integrable (fun Q ↦ g Q) :=
    memLp_one_iff_integrable.mp (ContinuousMap.memLp volume ℝ g)
  have h := integral_mono (hi.const_mul (Real.exp (-2 * textbookTorusPotentialScale U hU hPU β)))
    (textbookTorusGibbsDensity_mul_integrable U hU hPU β g)
    (fun Q ↦ mul_le_mul_of_nonneg_right (textbookTorusGibbsDensity_lower U hU hPU β Q) (hg Q))
  simpa only [integral_const_mul] using h

/-- Actual positive continuous-observable integrals have the derived finite Gibbs upper comparison. -/
theorem textbookTorusGibbsIntegral_upper (g : C(UnitAddTorus (Fin Nc), ℝ)) (hg : ∀ Q, 0 ≤ g Q) :
    (∫ Q, g Q ∂textbookConfigurationTorusGibbsMeasure U β) ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * (∫ Q, g Q) := by
  rw [textbookTorusGibbsDensity_integral U hU hPU β g]
  have hi : Integrable (fun Q ↦ g Q) :=
    memLp_one_iff_integrable.mp (ContinuousMap.memLp volume ℝ g)
  have h := integral_mono (textbookTorusGibbsDensity_mul_integrable U hU hPU β g)
    (hi.const_mul (Real.exp (2 * textbookTorusPotentialScale U hU hPU β)))
    (fun Q ↦ mul_le_mul_of_nonneg_right (textbookTorusGibbsDensity_upper U hU hPU β Q) (hg Q))
  simpa only [integral_const_mul] using h

/-- Mean squares in the same actual Gibbs measure have the derived positive Haar lower comparison. -/
theorem textbookTorusGibbsSquareIntegral_lower (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) * (∫ Q, (g Q) ^ 2) ≤
      ∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β := by
  exact textbookTorusGibbsIntegral_lower U hU hPU β (g ^ 2) (fun Q ↦ sq_nonneg (g Q))

/-- Mean squares in the same actual Gibbs measure have the derived finite Haar upper comparison. -/
theorem textbookTorusGibbsSquareIntegral_upper (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    (∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β) ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * (∫ Q, (g Q) ^ 2) := by
  exact textbookTorusGibbsIntegral_upper U hU hPU β (g ^ 2) (fun Q ↦ sq_nonneg (g Q))

include hU hPU in
/-- The genuine continuous-to-L² vector has the actual Gibbs mean square as its norm squared. -/
theorem textbookGibbsContinuousToLp_norm_sq (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ‖textbookGibbsContinuousToLp U hU hPU β g‖ ^ 2 =
      ∫ Q, (g Q) ^ 2 ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [← real_inner_self_eq_norm_sq, L2.inner_def]
  apply integral_congr_ae
  filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hPU β g] with Q h
  rw [h, Real.inner_apply, pow_two]

/-- The actual Hilbert norm has the derived positive lower Haar mean-square comparison. -/
theorem textbookGibbsContinuousToLp_norm_sq_lower (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    Real.exp (-2 * textbookTorusPotentialScale U hU hPU β) * (∫ Q, (g Q) ^ 2) ≤
      ‖textbookGibbsContinuousToLp U hU hPU β g‖ ^ 2 := by
  rw [textbookGibbsContinuousToLp_norm_sq U hU hPU β g]
  exact textbookTorusGibbsSquareIntegral_lower U hU hPU β g

/-- The actual Hilbert norm has the derived finite upper Haar mean-square comparison. -/
theorem textbookGibbsContinuousToLp_norm_sq_upper (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ‖textbookGibbsContinuousToLp U hU hPU β g‖ ^ 2 ≤
      Real.exp (2 * textbookTorusPotentialScale U hU hPU β) * (∫ Q, (g Q) ^ 2) := by
  rw [textbookGibbsContinuousToLp_norm_sq U hU hPU β g]
  exact textbookTorusGibbsSquareIntegral_upper U hU hPU β g

end

end MolecularDynamics
