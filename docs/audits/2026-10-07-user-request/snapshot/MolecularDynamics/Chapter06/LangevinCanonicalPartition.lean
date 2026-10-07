import MolecularDynamics.Chapter06.LangevinCanonicalMeasure

/-! The true canonical partition integral and the same normalized
classical Gibbs density for the original periodic unit-mass model. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty BigOperators

namespace MolecularDynamics
noncomputable section

local instance partitionUnitAddCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance partitionUnitAddCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance partitionUnitAddCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private def canonicalNormalizationCoefficient {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ * ((Real.sqrt (2 * Real.pi * β⁻¹))⁻¹) ^ N

private theorem canonicalNormalizationCoefficient_pos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) (hβ : 0 < β) :
    0 < canonicalNormalizationCoefficient U β := by
  exact mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
    (pow_pos (inv_pos.mpr (Real.sqrt_pos.mpr (mul_pos
      (mul_pos (by norm_num : (0 : ℝ) < 2) Real.pi_pos) (inv_pos.mpr hβ)))) _)

/-- The genuine full canonical partition integral, on normalized position
Haar times momentum Lebesgue, rather than a supplied normalization scalar. -/
def textbookLangevinCanonicalPartition {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) : ℝ :=
  ∫ x : textbookLangevinPeriodicPhase N, textbookLangevinPeriodicGibbsWeight U β x
    ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))

/-- Actual integrability of the original unnormalized full Gibbs weight
follows from the already derived density and its strictly positive coefficient. -/
theorem textbookLangevinPeriodicGibbsWeight_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  let k := canonicalNormalizationCoefficient U β
  have hk : 0 < k := canonicalNormalizationCoefficient_pos U hU β hβ
  refine ((textbookLangevinCanonicalDensity_integrable U hU hp β hβ).const_mul k⁻¹).congr
    (Eventually.of_forall (fun x ↦ ?_))
  change k⁻¹ * (k * textbookLangevinPeriodicGibbsWeight U β x) =
    textbookLangevinPeriodicGibbsWeight U β x
  rw [← mul_assoc, inv_mul_cancel₀ hk.ne', one_mul]

/-- The actual full partition integral has the original separated
configurational and Gaussian momentum factors, including dimension zero. -/
theorem textbookLangevinCanonicalPartition_formula {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalPartition U β =
      textbookConfigurationPartition U β * (Real.sqrt (2 * Real.pi * β⁻¹)) ^ N := by
  let k := canonicalNormalizationCoefficient U β
  have hk : 0 < k := canonicalNormalizationCoefficient_pos U hU β hβ
  have he := textbookLangevinCanonicalDensity_integral_one U hU hp β hβ
  change (∫ x : textbookLangevinPeriodicPhase N, k * textbookLangevinPeriodicGibbsWeight U β x
    ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 1 at he
  rw [integral_const_mul] at he
  have hz : textbookLangevinCanonicalPartition U β = k⁻¹ := by
    apply mul_left_cancel₀ hk.ne'
    change k * (∫ x : textbookLangevinPeriodicPhase N, textbookLangevinPeriodicGibbsWeight U β x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = k * k⁻¹
    rw [he, mul_inv_cancel₀ hk.ne']
  rw [hz]
  simp only [k, canonicalNormalizationCoefficient, mul_inv_rev, inv_pow, inv_inv]
  ring

/-- The genuine full canonical partition is strictly positive, proved
from its actual integral formula and the two original positive factors. -/
theorem textbookLangevinCanonicalPartition_pos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : 0 < textbookLangevinCanonicalPartition U β := by
  rw [textbookLangevinCanonicalPartition_formula U hU hp β hβ]
  exact mul_pos (textbookConfigurationPartition_pos U hU β)
    (pow_pos (Real.sqrt_pos.mpr (mul_pos
      (mul_pos (by norm_num : (0 : ℝ) < 2) Real.pi_pos) (inv_pos.mpr hβ))) _)

/-- The actual probability density uses exactly the reciprocal of the
true full partition integral of equation 6.3, not a free parameter. -/
theorem textbookLangevinCanonicalDensity_partition {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinCanonicalDensity U β x =
      (textbookLangevinCanonicalPartition U β)⁻¹ * textbookLangevinPeriodicGibbsWeight U β x := by
  unfold textbookLangevinCanonicalDensity
  rw [textbookLangevinCanonicalPartition_formula U hU hp β hβ]
  simp only [mul_inv_rev, inv_pow]
  ring

/-- The real lift of the same genuine normalized canonical phase density. -/
def textbookLangevinCanonicalDensityReal {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (z : textbookLangevinPhase N) : ℝ :=
  (textbookLangevinCanonicalPartition U β)⁻¹ * textbookLangevinGibbsWeight U β z

/-- The true real lifted canonical density is smooth for the original
smooth potential, with a constant actual partition normalization. -/
theorem textbookLangevinCanonicalDensityReal_contDiff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookLangevinCanonicalDensityReal U β) :=
  contDiff_const.mul (textbookLangevinGibbsWeight_contDiff U hU β)

/-- Original potential periodicity identifies the actual probability
density with its same smooth real lift at every representative. -/
theorem textbookLangevinCanonicalDensity_lift {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (z : textbookLangevinPhase N) :
    textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection z) =
      textbookLangevinCanonicalDensityReal U β z := by
  rw [textbookLangevinCanonicalDensity_partition U hU hp β hβ,
    textbookLangevinPeriodicGibbsWeight_lift U hp β z]
  rfl

/-- Multiplication by a genuine constant commutes with the complete
classical forward expression, including both true momentum derivatives. -/
theorem textbookLangevinForwardDifferentialOperator_const_mul {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ c : ℝ) (f : textbookLangevinPhase N → ℝ)
    (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (fun y ↦ c * f y) z =
      c * textbookLangevinForwardDifferentialOperator U γ σ f z := by
  unfold textbookLangevinForwardDifferentialOperator
  simp only [deriv_const_mul_field', deriv_const_mul_field, ← Finset.mul_sum]
  ring

/-- The actual normalized Gibbs density satisfies the classical forward
identity under the physical coefficient relation; no invariance is assumed. -/
theorem textbookLangevinForwardDifferentialOperator_canonical_eq_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (textbookLangevinCanonicalDensityReal U β) z = 0 := by
  unfold textbookLangevinCanonicalDensityReal
  rw [textbookLangevinForwardDifferentialOperator_const_mul,
    textbookLangevinForwardDifferentialOperator_gibbs_eq_zero U hU β γ σ hβ hσ z, mul_zero]

/-- For the original physical square-root noise, the actual normalized
torus probability density, lifted at every representative, has zero
classical forward expression. This does not assert kernel invariance. -/
theorem textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0 := by
  have he : (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) =
      textbookLangevinCanonicalDensityReal U β :=
    funext (textbookLangevinCanonicalDensity_lift U hU hp β hβ)
  rw [he]
  unfold textbookLangevinCanonicalDensityReal
  rw [textbookLangevinForwardDifferentialOperator_const_mul,
    textbookLangevinForwardDifferentialOperator_physical_gibbs_eq_zero U
      (hU.differentiable (by simp)) β γ hβ hγ z, mul_zero]

end
end MolecularDynamics
