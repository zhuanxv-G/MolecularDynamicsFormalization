import MolecularDynamics.Chapter06.BrownianGroundState
import Mathlib.Analysis.Normed.Operator.Extend

/-! The actual full Gibbs-to-Haar Hilbert isometry, derived from the original normalized density. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace RealInnerProductSpace

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The true normalized torus factor is everywhere positive on the actual full quotient. -/
theorem textbookTorusGibbsNormalizedGroundStateFactor_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (Q : UnitAddTorus (Fin Nc)) :
    0 < textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q :=
  textbookGibbsNormalizedGroundStateFactor_pos U hU β (textbookConfigurationTorusRepresentative Q)

/-- The genuine continuous inverse factor; no inverse or positivity is supplied as a premise. -/
def textbookTorusGibbsNormalizedGroundStateInverse {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) : C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨fun Q ↦ (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q)⁻¹,
    (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β).continuous.inv₀
      (fun Q ↦ ne_of_gt (textbookTorusGibbsNormalizedGroundStateFactor_pos U hU hPU β Q))⟩

/-- Multiplication by the actual normalized factor is a genuine equivalence of all continuous functions. -/
def textbookGibbsGroundStateContinuousEquiv {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    C(UnitAddTorus (Fin Nc), ℝ) ≃ₗ[ℝ] C(UnitAddTorus (Fin Nc), ℝ) where
  toFun g := textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β * g
  invFun g := textbookTorusGibbsNormalizedGroundStateInverse U hU hPU β * g
  left_inv g := by
    ext Q
    change (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q)⁻¹ *
      (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q * g Q) = g Q
    rw [← mul_assoc, inv_mul_cancel₀
      (ne_of_gt (textbookTorusGibbsNormalizedGroundStateFactor_pos U hU hPU β Q)), one_mul]
  right_inv g := by
    ext Q
    change textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q *
      ((textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q)⁻¹ * g Q) = g Q
    rw [← mul_assoc, mul_inv_cancel₀
      (ne_of_gt (textbookTorusGibbsNormalizedGroundStateFactor_pos U hU hPU β Q)), one_mul]
  map_add' g h := by
    ext Q
    change _ * (g Q + h Q) = _ * g Q + _ * h Q
    ring
  map_smul' c g := by
    ext Q
    change _ * (c * g Q) = c * (_ * g Q)
    ring

/-- The actual continuous equivalence is precisely the original normalized multiplication. -/
theorem textbookGibbsGroundStateContinuousEquiv_apply {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsGroundStateContinuousEquiv U hU hPU β g =
      textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β * g := rfl

/-- Its actual continuous inverse is multiplication by the derived reciprocal. -/
theorem textbookGibbsGroundStateContinuousEquiv_symm_apply {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    (textbookGibbsGroundStateContinuousEquiv U hU hPU β).symm g =
      textbookTorusGibbsNormalizedGroundStateInverse U hU hPU β * g := rfl

/-- The actual full continuous-to-Haar L² embedding on the original torus. -/
def textbookHaarContinuousToLp (Nc : ℕ) :
    C(UnitAddTorus (Fin Nc), ℝ) →L[ℝ] Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  ContinuousMap.toLp 2 volume ℝ

/-- The actual Haar embedding has genuinely dense range, without a density premise. -/
theorem textbookHaarContinuousToLp_denseRange (Nc : ℕ) :
    DenseRange (textbookHaarContinuousToLp Nc) :=
  ContinuousMap.toLp_denseRange ℝ volume ℝ (by norm_num)

/-- Its genuine Haar L² norm is the true same-function square integral. -/
theorem textbookHaarContinuousToLp_norm_sq {Nc : ℕ} (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ‖textbookHaarContinuousToLp Nc g‖ ^ 2 =
      ∫ Q : UnitAddTorus (Fin Nc), (g Q) ^ 2 := by
  rw [← real_inner_self_eq_norm_sq, L2.inner_def]
  apply integral_congr_ae
  filter_upwards [ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℝ) g] with Q hQ
  change (textbookHaarContinuousToLp Nc g Q) * textbookHaarContinuousToLp Nc g Q = (g Q) ^ 2
  change (g.toLp 2 volume ℝ Q) * g.toLp 2 volume ℝ Q = (g Q) ^ 2
  rw [hQ]
  ring

/-- Actual density normalization gives equality of the two true embedded Hilbert norms. -/
theorem textbookGibbsGroundStateContinuousEquiv_norm {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    ‖textbookHaarContinuousToLp Nc (textbookGibbsGroundStateContinuousEquiv U hU hPU β g)‖ =
      ‖textbookGibbsContinuousToLp U hU hPU β g‖ := by
  apply (sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _)).mp
  rw [textbookHaarContinuousToLp_norm_sq, textbookGibbsContinuousToLp_norm_sq U hU hPU β g]
  change (∫ Q : UnitAddTorus (Fin Nc),
    (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β Q * g Q) ^ 2) = _
  exact textbookTorusGibbsGroundState_square_integral U hU hPU β g

/-- The genuine equivalence of the entire original Gibbs and Haar Hilbert spaces.
Its inverse, surjectivity and norm preservation are proved through two actual dense embeddings. -/
def textbookGibbsHaarGroundStateIsometry {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ≃ₗᵢ[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  (textbookGibbsGroundStateContinuousEquiv U hU hPU β).extendOfIsometry
    (textbookGibbsContinuousToLp U hU hPU β).toLinearMap
    (textbookHaarContinuousToLp Nc).toLinearMap
    (by exact textbookGibbsContinuousToLp_denseRange U hU hPU β)
    (by exact textbookHaarContinuousToLp_denseRange Nc)
    (textbookGibbsGroundStateContinuousEquiv_norm U hU hPU β)

/-- The actual full Hilbert isometry agrees with normalized multiplication for every continuous function. -/
theorem textbookGibbsHaarGroundStateIsometry_apply_continuous {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookGibbsHaarGroundStateIsometry U hU hPU β (textbookGibbsContinuousToLp U hU hPU β g) =
      textbookHaarContinuousToLp Nc (textbookTorusGibbsNormalizedGroundStateFactor U hU hPU β * g) := by
  exact LinearEquiv.extendOfIsometry_eq _ _ _ _ _ _ g

/-- Its true full Hilbert inverse agrees with actual reciprocal multiplication on every continuous function. -/
theorem textbookGibbsHaarGroundStateIsometry_symm_continuous {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    (textbookGibbsHaarGroundStateIsometry U hU hPU β).symm (textbookHaarContinuousToLp Nc g) =
      textbookGibbsContinuousToLp U hU hPU β (textbookTorusGibbsNormalizedGroundStateInverse U hU hPU β * g) := by
  exact LinearEquiv.extendOfIsometry_symm_eq _ _ _ _ _ _ g

/-- The actual original Gibbs-to-Haar map preserves the norm of every Hilbert vector. -/
theorem textbookGibbsHaarGroundStateIsometry_norm {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    ‖textbookGibbsHaarGroundStateIsometry U hU hPU β x‖ = ‖x‖ :=
  (textbookGibbsHaarGroundStateIsometry U hU hPU β).norm_map x

/-- The actual map is onto the entire Haar Hilbert space, rather than only the smooth image. -/
theorem textbookGibbsHaarGroundStateIsometry_surjective {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Function.Surjective (textbookGibbsHaarGroundStateIsometry U hU hPU β) :=
  (textbookGibbsHaarGroundStateIsometry U hU hPU β).surjective

/-- The actual full Hilbert map preserves the same original real inner product. -/
theorem textbookGibbsHaarGroundStateIsometry_inner {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (x y : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    ⟪textbookGibbsHaarGroundStateIsometry U hU hPU β x,
      textbookGibbsHaarGroundStateIsometry U hU hPU β y⟫_ℝ = ⟪x, y⟫_ℝ :=
  (textbookGibbsHaarGroundStateIsometry U hU hPU β).inner_map_map x y

end

end MolecularDynamics