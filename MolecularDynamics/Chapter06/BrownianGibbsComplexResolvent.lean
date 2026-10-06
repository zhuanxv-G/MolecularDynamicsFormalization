import MolecularDynamics.Chapter06.BrownianGibbsComplexOperator
import Mathlib.Analysis.Normed.Operator.Compact.Basic

/-! The genuine bounded compact two-sided resolvent of the actual original complex Gibbs generator. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev GibbsComplex {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private abbrev cb := textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ
private abbrev R := textbookBrownianGibbsResolvent m U hU hPU β hm hβ

/-- The real-continuous map built from the actual original compact resolvent on genuine real and imaginary parts, for the same entire Gibbs measure. -/
def textbookBrownianGibbsComplexResolventReal : GibbsComplex U β →L[ℝ] GibbsComplex U β :=
  (textbookBrownianGibbsL2Complexify U β).comp
      ((R m hm U hU hPU β hβ).comp (textbookBrownianGibbsL2RealPart U β)) +
    Complex.I • (textbookBrownianGibbsL2Complexify U β).comp
      ((R m hm U hU hPU β hβ).comp (textbookBrownianGibbsL2ImagPart U β))

/-- Its true entire original complex coordinates have the actual inverse shifted real eigenvalues. -/
theorem textbookBrownianGibbsComplexResolventReal_coefficient
    (z : GibbsComplex U β) (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪cb m hm U hU hPU β hβ j, textbookBrownianGibbsComplexResolventReal m hm U hU hPU β hβ z⟫_ℂ =
      (((1 - j.1)⁻¹ : ℝ) : ℂ) * ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ := by
  change ⟪cb m hm U hU hPU β hβ j,
    textbookBrownianGibbsL2Complexify U β (R m hm U hU hPU β hβ (textbookBrownianGibbsL2RealPart U β z)) +
      Complex.I • textbookBrownianGibbsL2Complexify U β
        (R m hm U hU hPU β hβ (textbookBrownianGibbsL2ImagPart U β z))⟫_ℂ = _
  rw [inner_add_right, inner_smul_right]
  conv_lhs =>
    rw [textbookBrownianGibbsComplexEigenbasis_apply,
      textbookBrownianGibbsL2Complexify_inner, textbookBrownianGibbsL2Complexify_inner,
      textbookBrownianGibbsResolvent_coefficient, textbookBrownianGibbsResolvent_coefficient]
  rw [textbookBrownianGibbsComplexEigenbasis_coefficient_re_im]
  push_cast
  ring

/-- Complex scalar-linearity of the actual real-continuous construction is proved on the whole space using true complete basis coordinates. -/
theorem textbookBrownianGibbsComplexResolventReal_complex_smul (c : ℂ) (z : GibbsComplex U β) :
    textbookBrownianGibbsComplexResolventReal m hm U hU hPU β hβ (c • z) =
      c • textbookBrownianGibbsComplexResolventReal m hm U hU hPU β hβ z := by
  let b := cb m hm U hU hPU β hβ
  apply b.repr.injective
  apply Subtype.ext
  funext j
  rw [b.repr_apply_apply, b.repr_apply_apply,
    textbookBrownianGibbsComplexResolventReal_coefficient, inner_smul_right,
    inner_smul_right, textbookBrownianGibbsComplexResolventReal_coefficient]
  ring

/-- The actual bounded complex-linear resolvent, with continuity inherited from the genuinely constructed whole-space map. -/
def textbookBrownianGibbsComplexResolvent : GibbsComplex U β →L[ℂ] GibbsComplex U β := by
  let C := textbookBrownianGibbsComplexResolventReal m hm U hU hPU β hβ
  let B : GibbsComplex U β →ₗ[ℂ] GibbsComplex U β :=
    { toFun := C
      map_add' := C.map_add
      map_smul' := textbookBrownianGibbsComplexResolventReal_complex_smul m hm U hU hPU β hβ }
  exact B.mkContinuous ‖C‖ (fun z ↦ C.le_opNorm z)

/-- The actual complex-continuous resolvent has precisely the genuine constructed real-imaginary value. -/
theorem textbookBrownianGibbsComplexResolvent_apply (z : GibbsComplex U β) :
    textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ z =
      textbookBrownianGibbsComplexResolventReal m hm U hU hPU β hβ z := rfl

/-- The true complex bounded resolvent has the actual full inverse-shifted generator coefficients. -/
theorem textbookBrownianGibbsComplexResolvent_coefficient
    (z : GibbsComplex U β) (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪cb m hm U hU hPU β hβ j, textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ z⟫_ℂ =
      (((1 - j.1)⁻¹ : ℝ) : ℂ) * ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ :=
  textbookBrownianGibbsComplexResolventReal_coefficient m hm U hU hPU β hβ z j

/-- Compactness follows from the actual original compact real resolvent and genuine continuous pre/postcomposition, complex scaling and addition. -/
theorem textbookBrownianGibbsComplexResolvent_isCompact :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  have hR := textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ
  have hRe := (hR.comp_clm (textbookBrownianGibbsL2RealPart U β)).clm_comp
    (textbookBrownianGibbsL2Complexify U β)
  have hIm := ((hR.comp_clm (textbookBrownianGibbsL2ImagPart U β)).clm_comp
    (textbookBrownianGibbsL2Complexify U β)).smul Complex.I
  exact hRe.add hIm

include hm hβ in
private theorem weight_cancel (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    (((1 - j.1)⁻¹ : ℝ) : ℂ) * (1 - (j.1 : ℂ)) = 1 := by
  have hn := textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j
  have hd : 1 - j.1 ≠ 0 := by linarith
  exact_mod_cast inv_mul_cancel₀ hd

/-- Every entire original complex Gibbs input has its genuine shifted original graph preimage. -/
theorem textbookBrownianGibbsComplexResolvent_mem_graph (z : GibbsComplex U β) :
    (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ z,
      textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ z - z) ∈
        (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph := by
  rw [textbookBrownianGibbsComplexOperator_graph_iff_coefficients]
  intro j
  rw [inner_sub_right, textbookBrownianGibbsComplexResolvent_coefficient]
  let r : ℂ := (((1 - j.1)⁻¹ : ℝ) : ℂ)
  let a := ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ
  have hr : r * (1 - (j.1 : ℂ)) = 1 := weight_cancel m hm U hU hPU β hβ j
  change r * a - a = (j.1 : ℂ) * (r * a)
  calc
    r * a - a = (r * (1 - (j.1 : ℂ)) + (j.1 : ℂ) * r) * a - a := by ring
    _ = _ := by rw [hr]; ring

/-- The same actual bounded complex map is the other inverse on the entire true original complex generator graph. -/
theorem textbookBrownianGibbsComplexResolvent_inverse_graph (z w : GibbsComplex U β)
    (hzw : (z, w) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph) :
    textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ (z - w) = z := by
  let b := cb m hm U hU hPU β hβ
  have hc := (textbookBrownianGibbsComplexOperator_graph_iff_coefficients m hm U hU hPU β hβ z w).mp hzw
  apply b.repr.injective
  apply Subtype.ext
  funext j
  rw [b.repr_apply_apply, b.repr_apply_apply,
    textbookBrownianGibbsComplexResolvent_coefficient, inner_sub_right, hc j]
  let r : ℂ := (((1 - j.1)⁻¹ : ℝ) : ℂ)
  let a := ⟪b j, z⟫_ℂ
  have hr : r * (1 - (j.1 : ℂ)) = 1 := weight_cancel m hm U hU hPU β hβ j
  change r * (a - (j.1 : ℂ) * a) = a
  calc
    r * (a - (j.1 : ℂ) * a) = (r * (1 - (j.1 : ℂ))) * a := by ring
    _ = a := by rw [hr, one_mul]

/-- The actual original whole complex Gibbs generator has a genuine bounded compact two-sided resolvent at one. -/
theorem textbookBrownianGibbsComplexOperator_hasCompactResolvent :
    ∃ C : GibbsComplex U β →L[ℂ] GibbsComplex U β, IsCompactOperator C ∧
      (∀ z, (C z, C z - z) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph) ∧
      (∀ z w, (z, w) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph →
        C (z - w) = z) :=
  ⟨textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ,
    textbookBrownianGibbsComplexResolvent_isCompact m hm U hU hPU β hβ,
    textbookBrownianGibbsComplexResolvent_mem_graph m hm U hU hPU β hβ,
    textbookBrownianGibbsComplexResolvent_inverse_graph m hm U hU hPU β hβ⟩

end
end MolecularDynamics