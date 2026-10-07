import MolecularDynamics.Chapter06.BrownianEigenGraph
import Mathlib.Analysis.Normed.Group.Tannery

/-! Actual bounded spectral evolution on the whole original Gibbs Hilbert space. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private abbrev Coefficients :=
  lp (fun _ : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ ℝ) 2

/-- The actual original generator eigenvalue heat weight, at a genuinely nonnegative time. -/
def textbookBrownianGibbsEvolutionWeight (t : NNReal)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) : ℝ :=
  Real.exp (j.1 * (t : ℝ))

/-- Each actual heat weight is positive. -/
theorem textbookBrownianGibbsEvolutionWeight_pos (t : NNReal)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    0 < textbookBrownianGibbsEvolutionWeight m U hU hPU β t j :=
  Real.exp_pos _

include hm hβ in
/-- The genuine full original generator eigenbasis makes all heat weights contractions. -/
theorem textbookBrownianGibbsEvolutionWeight_le_one (t : NNReal)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    textbookBrownianGibbsEvolutionWeight m U hU hPU β t j ≤ 1 :=
  Real.exp_le_one_iff.mpr (mul_nonpos_of_nonpos_of_nonneg
    (textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j) t.property)

/-- The actual eigenvalue weights obey the time addition law. -/
theorem textbookBrownianGibbsEvolutionWeight_add (s t : NNReal)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    textbookBrownianGibbsEvolutionWeight m U hU hPU β (s + t) j =
      textbookBrownianGibbsEvolutionWeight m U hU hPU β s j *
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t j := by
  simp only [textbookBrownianGibbsEvolutionWeight, NNReal.coe_add, mul_add, Real.exp_add]

include hm hβ in
private theorem weight_mul_norm (t : NNReal)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) (c : ℝ) :
    ‖textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * c‖ ≤ ‖c‖ := by
  rw [norm_mul, Real.norm_eq_abs, abs_of_pos
    (textbookBrownianGibbsEvolutionWeight_pos m U hU hPU β t j)]
  exact (mul_le_mul_of_nonneg_right
    (textbookBrownianGibbsEvolutionWeight_le_one m hm U hU hPU β hβ t j)
    (norm_nonneg c)).trans_eq (one_mul _)

/-- Genuine heat multiplication on the actual full eigenbasis coefficient space. -/
def textbookBrownianGibbsEvolutionCoefficientOperator (t : NNReal) :
    Coefficients m U hU hPU β →L[ℝ] Coefficients m U hU hPU β :=
  LinearMap.mkContinuous
    { toFun a := ⟨fun j ↦ textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * a j,
        (lp.memℓp a).mono' (fun j ↦ weight_mul_norm m hm U hU hPU β hβ t j (a j))⟩
      map_add' a b := by
        apply Subtype.ext
        funext j
        change textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * (a j + b j) =
          textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * a j +
            textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * b j
        ring
      map_smul' c a := by
        apply Subtype.ext
        funext j
        change textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * (c * a j) =
          c * (textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * a j)
        ring }
    1 (fun a ↦ by
      have h := lp.norm_mono (by norm_num : (2 : ENNReal) ≠ 0)
        (x := (⟨fun j ↦ textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * a j,
          (lp.memℓp a).mono' (fun j ↦ weight_mul_norm m hm U hU hPU β hβ t j (a j))⟩ :
            Coefficients m U hU hPU β))
        (y := a) (fun j ↦ weight_mul_norm m hm U hU hPU β hβ t j (a j))
      simp only [one_mul]
      exact h)

/-- The actual coefficient operator multiplies by the true heat weights. -/
theorem textbookBrownianGibbsEvolutionCoefficientOperator_apply (t : NNReal)
    (a : Coefficients m U hU hPU β) (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t a j =
      textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * a j := rfl

/-- The actual whole coefficient evolution contracts the true coefficient Hilbert norm. -/
theorem textbookBrownianGibbsEvolutionCoefficientOperator_norm (t : NNReal)
    (a : Coefficients m U hU hPU β) :
    ‖textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t a‖ ≤ ‖a‖ :=
  lp.norm_mono (by norm_num : (2 : ENNReal) ≠ 0)
    (fun j ↦ weight_mul_norm m hm U hU hPU β hβ t j (a j))

/-- The genuine spectral evolution on the entire original same-Gibbs Hilbert space. -/
def textbookBrownianGibbsSpectralEvolution (t : NNReal) :
    Gibbs U β →L[ℝ] Gibbs U β :=
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  b.repr.symm.toContinuousLinearEquiv.toContinuousLinearMap.comp
    ((textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t).comp
      b.repr.toContinuousLinearEquiv.toContinuousLinearMap)

/-- Actual whole-space coordinates identify the genuine evolution with its true heat multiplier. -/
theorem textbookBrownianGibbsSpectralEvolution_repr (t : NNReal) (x : Gibbs U β) :
    (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).repr
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) =
        textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t
          ((textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).repr x) := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  change b.repr (b.repr.symm (_)) = _
  exact b.repr.apply_symm_apply _

/-- Every actual evolution coefficient is the true original generator heat weight times its initial coefficient. -/
theorem textbookBrownianGibbsSpectralEvolution_coefficient (t : NNReal)
    (x : Gibbs U β) (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j,
      textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x⟫_ℝ =
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t j *
          ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  rw [← b.repr_apply_apply, textbookBrownianGibbsSpectralEvolution_repr,
    textbookBrownianGibbsEvolutionCoefficientOperator_apply, b.repr_apply_apply]

/-- Genuine contraction of the original Gibbs norm on the entire Hilbert space at every nonnegative time. -/
theorem textbookBrownianGibbsSpectralEvolution_norm (t : NNReal) (x : Gibbs U β) :
    ‖textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x‖ ≤ ‖x‖ := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  change ‖b.repr.symm (textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t
    (b.repr x))‖ ≤ ‖x‖
  rw [b.repr.symm.norm_map]
  exact (textbookBrownianGibbsEvolutionCoefficientOperator_norm m hm U hU hPU β hβ t _).trans_eq
    (b.repr.norm_map x)

/-- The actual whole-space spectral evolution starts at the identity. -/
theorem textbookBrownianGibbsSpectralEvolution_zero :
    textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ 0 =
      ContinuousLinearMap.id ℝ (Gibbs U β) := by
  apply ContinuousLinearMap.ext
  intro x
  apply (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).repr.injective
  rw [textbookBrownianGibbsSpectralEvolution_repr]
  apply Subtype.ext
  funext j
  change textbookBrownianGibbsEvolutionWeight m U hU hPU β 0 j * _ = _
  simp only [textbookBrownianGibbsEvolutionWeight, NNReal.coe_zero, mul_zero, Real.exp_zero, one_mul, ContinuousLinearMap.id_apply]

/-- The actual bounded operators obey the true semigroup law on the entire original Gibbs space. -/
theorem textbookBrownianGibbsSpectralEvolution_add (s t : NNReal) :
    textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ (s + t) =
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ s).comp
        (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t) := by
  apply ContinuousLinearMap.ext
  intro x
  apply (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).repr.injective
  change (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).repr
    (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ (s + t) x) =
    (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).repr
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ s
        (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x))
  rw [textbookBrownianGibbsSpectralEvolution_repr, textbookBrownianGibbsSpectralEvolution_repr,
    textbookBrownianGibbsSpectralEvolution_repr]
  apply Subtype.ext
  funext j
  change textbookBrownianGibbsEvolutionWeight m U hU hPU β (s + t) j * _ =
    textbookBrownianGibbsEvolutionWeight m U hU hPU β s j *
      (textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * _)
  rw [textbookBrownianGibbsEvolutionWeight_add, mul_assoc]

/-- The genuine spectral evolution has its actual full original eigenfunction expansion. -/
theorem textbookBrownianGibbsSpectralEvolution_hasSum (t : NNReal) (x : Gibbs U β) :
    HasSum (fun j ↦ (textbookBrownianGibbsEvolutionWeight m U hU hPU β t j *
      ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ) •
        textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j)
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) := by
  simpa only [HilbertBasis.repr_apply_apply, textbookBrownianGibbsSpectralEvolution_coefficient] using
    (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).hasSum_repr
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x)

/-- The actual evolution preserves the entire original generator graph and commutes with its actual graph values. -/
theorem textbookBrownianGibbsSpectralEvolution_preserves_graph (t : NNReal)
    (x y : Gibbs U β)
    (hg : (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x,
      textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t y) ∈
        (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  apply (textbookBrownianGibbsClosedOperator_graph_iff_coefficients m hm U hU hPU β hβ _ _).mpr
  intro j
  rw [textbookBrownianGibbsSpectralEvolution_coefficient, textbookBrownianGibbsSpectralEvolution_coefficient,
    textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ x y hg j]
  ring


private theorem coefficient_norm_sq (a : Coefficients m U hU hPU β) :
    ‖a‖ ^ 2 = ∑' j, ‖a j‖ ^ 2 := by
  simpa using lp.norm_rpow_eq_tsum (by norm_num : 0 < (2 : ENNReal).toReal) a

/-- The true coefficient heat multiplier is strongly continuous at every nonnegative time. -/
theorem textbookBrownianGibbsEvolutionCoefficientOperator_continuous
    (a : Coefficients m U hU hPU β) :
    Continuous (fun t : NNReal ↦ textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t a) := by
  rw [continuous_iff_continuousAt]
  intro t₀
  rw [ContinuousAt, tendsto_iff_norm_sub_tendsto_zero]
  have hs : Summable (fun j ↦ ‖a j‖ ^ 2) := by
    simpa using (lp.memℓp a).summable (by norm_num : 0 < (2 : ENNReal).toReal)
  have hp : ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
      Tendsto (fun t : NNReal ↦
        ‖(textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
          textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j) * a j‖ ^ 2)
        (𝓝 t₀) (𝓝 (0 : ℝ)) := by
    intro j
    have hc : Continuous (fun t : NNReal ↦
        ‖(textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
          textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j) * a j‖ ^ 2) := by
      unfold textbookBrownianGibbsEvolutionWeight
      fun_prop
    simpa using (hc.tendsto t₀)
  have hb : ∀ᶠ t : NNReal in 𝓝 t₀, ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
      ‖‖(textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j) * a j‖ ^ 2‖ ≤ ‖a j‖ ^ 2 := by
    apply Eventually.of_forall
    intro t j
    have hwt := textbookBrownianGibbsEvolutionWeight_le_one m hm U hU hPU β hβ t j
    have hw₀ := textbookBrownianGibbsEvolutionWeight_le_one m hm U hU hPU β hβ t₀ j
    have hpt := textbookBrownianGibbsEvolutionWeight_pos m U hU hPU β t j
    have hp₀ := textbookBrownianGibbsEvolutionWeight_pos m U hU hPU β t₀ j
    have hd : |textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j| ≤ 1 :=
      abs_le.mpr ⟨by linarith, by linarith⟩
    have hn : ‖(textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j) * a j‖ ≤ ‖a j‖ := by
      rw [norm_mul, Real.norm_eq_abs]
      exact (mul_le_mul_of_nonneg_right hd (norm_nonneg (a j))).trans_eq (one_mul _)
    rw [Real.norm_of_nonneg (sq_nonneg _)]
    exact pow_le_pow_left₀ (norm_nonneg _) hn 2
  have ht : Tendsto (fun t : NNReal ↦ ∑' j,
      ‖(textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j) * a j‖ ^ 2)
        (𝓝 t₀) (𝓝 (0 : ℝ)) := by
    simpa only [tsum_zero] using
      (tendsto_tsum_of_dominated_convergence hs hp hb)
  have he (t : NNReal) :
      ‖textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t a -
        textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t₀ a‖ ^ 2 =
      ∑' j, ‖(textbookBrownianGibbsEvolutionWeight m U hU hPU β t j -
        textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j) * a j‖ ^ 2 := by
    rw [coefficient_norm_sq m U hU hPU β]
    congr 1
    funext j
    change ‖textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * a j -
      textbookBrownianGibbsEvolutionWeight m U hU hPU β t₀ j * a j‖ ^ 2 = _
    rw [sub_mul]
  have hn : Tendsto (fun t : NNReal ↦
      ‖textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t a -
        textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t₀ a‖ ^ 2)
        (𝓝 t₀) (𝓝 (0 : ℝ)) := by
    simpa only [he] using ht
  simpa only [Function.comp_def, Real.sqrt_sq_eq_abs, abs_norm, Real.sqrt_zero] using
    Real.continuous_sqrt.continuousAt.tendsto.comp hn

/-- The genuine contraction semigroup on the entire original Gibbs Hilbert space is strongly continuous. -/
theorem textbookBrownianGibbsSpectralEvolution_continuous (x : Gibbs U β) :
    Continuous (fun t : NNReal ↦ textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  change Continuous (fun t : NNReal ↦ b.repr.symm
    (textbookBrownianGibbsEvolutionCoefficientOperator m hm U hU hPU β hβ t (b.repr x)))
  exact b.repr.symm.continuous.comp
    (textbookBrownianGibbsEvolutionCoefficientOperator_continuous m hm U hU hPU β hβ (b.repr x))

end
end MolecularDynamics
