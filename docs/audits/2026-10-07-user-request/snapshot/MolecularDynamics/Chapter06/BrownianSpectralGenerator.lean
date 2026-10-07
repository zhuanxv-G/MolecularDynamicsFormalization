import MolecularDynamics.Chapter06.BrownianSpectralEvolution
import Mathlib.Analysis.Calculus.Deriv.Slope

/-! Genuine infinitesimal generator identification through the actual whole Gibbs semigroup right derivative. -/

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

/-- The genuine right-difference heat weight of the actual generator eigenvalue. -/
def textbookBrownianGibbsDifferenceWeight (t : NNReal)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) : ℝ :=
  (t : ℝ)⁻¹ * (textbookBrownianGibbsEvolutionWeight m U hU hPU β t j - 1)

include hm hβ in
/-- The actual exponential difference quotient is controlled by the true original generator eigenvalue. -/
theorem textbookBrownianGibbsDifferenceWeight_norm_le (t : NNReal) (ht : 0 < t)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ‖textbookBrownianGibbsDifferenceWeight m U hU hPU β t j‖ ≤ -j.1 := by
  have htr : 0 < (t : ℝ) := ht
  have hu := textbookBrownianGibbsEvolutionWeight_le_one m hm U hU hPU β hβ t j
  have hn : textbookBrownianGibbsDifferenceWeight m U hU hPU β t j ≤ 0 := by
    unfold textbookBrownianGibbsDifferenceWeight
    exact mul_nonpos_of_nonneg_of_nonpos (inv_nonneg.mpr htr.le) (by linarith)
  have hl : j.1 ≤ textbookBrownianGibbsDifferenceWeight m U hU hPU β t j := by
    unfold textbookBrownianGibbsDifferenceWeight
    rw [inv_mul_eq_div]
    apply (le_div_iff₀ htr).mpr
    have h := Real.add_one_le_exp (j.1 * (t : ℝ))
    change j.1 * (t : ℝ) ≤ Real.exp (j.1 * (t : ℝ)) - 1
    linarith
  rw [Real.norm_eq_abs, abs_of_nonpos hn]
  exact neg_le_neg hl

include hm hβ in
/-- The true scalar generator difference error has the required eigenvalue domination. -/
theorem textbookBrownianGibbsDifferenceWeight_error_le (t : NNReal) (ht : 0 < t)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ‖textbookBrownianGibbsDifferenceWeight m U hU hPU β t j - j.1‖ ≤ 2 * ‖j.1‖ := by
  calc
    _ ≤ ‖textbookBrownianGibbsDifferenceWeight m U hU hPU β t j‖ + ‖j.1‖ := norm_sub_le _ _
    _ ≤ -j.1 + ‖j.1‖ := by
      have h := textbookBrownianGibbsDifferenceWeight_norm_le m hm U hU hPU β hβ t ht j
      linarith
    _ = _ := by
      rw [Real.norm_eq_abs, abs_of_nonpos
        (textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j)]
      ring

/-- The actual scalar heat right difference converges to its true original generator eigenvalue. -/
theorem textbookBrownianGibbsDifferenceWeight_tendsto
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    Tendsto (fun t : NNReal ↦ textbookBrownianGibbsDifferenceWeight m U hU hPU β t j)
      (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 j.1) := by
  have hd : HasDerivAt (fun t : ℝ ↦ Real.exp (j.1 * t)) j.1 0 := by
    convert ((hasDerivAt_id (0 : ℝ)).const_mul j.1).exp using 1 <;> simp
  have hc : Tendsto (fun t : NNReal ↦ (t : ℝ))
      (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝[Set.Ioi (0 : ℝ)] 0) := by
    apply tendsto_nhdsWithin_iff.mpr
    constructor
    · exact (NNReal.continuous_coe.tendsto 0).mono_left nhdsWithin_le_nhds
    · filter_upwards [self_mem_nhdsWithin] with t ht
      exact ht
  simpa only [Function.comp_def, zero_add, mul_zero, Real.exp_zero, smul_eq_mul,
    textbookBrownianGibbsDifferenceWeight, textbookBrownianGibbsEvolutionWeight] using
      hd.tendsto_slope_zero_right.comp hc

private theorem coefficient_norm_sq (a : Coefficients m U hU hPU β) :
    ‖a‖ ^ 2 = ∑' j, ‖a j‖ ^ 2 := by
  simpa using lp.norm_rpow_eq_tsum (by norm_num : 0 < (2 : ENNReal).toReal) a

/-- Every actual original generator graph vector has the true Hilbert right derivative under the genuine C0 semigroup. -/
theorem textbookBrownianGibbsSpectralEvolution_right_derivative_of_graph
    (x y : Gibbs U β)
    (hg : (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    Tendsto (fun t : NNReal ↦ (t : ℝ)⁻¹ •
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x - x))
      (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 y) := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  let F (t : NNReal) : Coefficients m U hU hPU β :=
    b.repr ((t : ℝ)⁻¹ • (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x - x) - y)
  have hc (t : NNReal) (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
      F t j = (textbookBrownianGibbsDifferenceWeight m U hU hPU β t j - j.1) * b.repr x j := by
    change b.repr _ j = _
    rw [b.repr_apply_apply, inner_sub_right, inner_smul_right, inner_sub_right,
      textbookBrownianGibbsSpectralEvolution_coefficient,
      textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ x y hg j,
      b.repr_apply_apply]
    unfold textbookBrownianGibbsDifferenceWeight
    ring
  have hs : Summable (fun j ↦ 4 * ‖b.repr y j‖ ^ 2) := by
    have h : Summable (fun j ↦ ‖b.repr y j‖ ^ 2) := by
      simpa using (lp.memℓp (b.repr y)).summable (by norm_num : 0 < (2 : ENNReal).toReal)
    exact h.mul_left 4
  have hp : ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
      Tendsto (fun t : NNReal ↦ ‖F t j‖ ^ 2)
        (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 (0 : ℝ)) := by
    intro j
    have h := ((textbookBrownianGibbsDifferenceWeight_tendsto m U hU hPU β j).sub_const j.1).mul_const
      (b.repr x j)
    simpa only [hc, sub_self, zero_mul, norm_zero, zero_pow (by decide : (2 : ℕ) ≠ 0)] using h.norm.pow 2
  have hb : ∀ᶠ t : NNReal in 𝓝[Set.Ioi (0 : NNReal)] 0,
      ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
        ‖‖F t j‖ ^ 2‖ ≤ 4 * ‖b.repr y j‖ ^ 2 := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    intro j
    have he : ‖b.repr y j‖ = ‖j.1‖ * ‖b.repr x j‖ := by
      rw [b.repr_apply_apply, b.repr_apply_apply,
        textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ x y hg j, norm_mul]
    have hn : ‖F t j‖ ≤ 2 * ‖b.repr y j‖ := by
      rw [hc, norm_mul, he]
      have h := mul_le_mul_of_nonneg_right
        (textbookBrownianGibbsDifferenceWeight_error_le m hm U hU hPU β hβ t ht j)
        (norm_nonneg (b.repr x j))
      simpa only [mul_assoc] using h
    rw [Real.norm_of_nonneg (sq_nonneg _)]
    calc
      _ ≤ (2 * ‖b.repr y j‖) ^ 2 := pow_le_pow_left₀ (norm_nonneg _) hn 2
      _ = _ := by ring
  have hsq : Tendsto (fun t : NNReal ↦ ‖F t‖ ^ 2)
      (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 (0 : ℝ)) := by
    simpa only [coefficient_norm_sq m U hU hPU β, tsum_zero] using
      (tendsto_tsum_of_dominated_convergence hs hp hb)
  have hn : Tendsto (fun t : NNReal ↦ ‖F t‖)
      (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 (0 : ℝ)) := by
    simpa only [Function.comp_def, Real.sqrt_sq_eq_abs, abs_norm, Real.sqrt_zero] using
      Real.continuous_sqrt.continuousAt.tendsto.comp hsq
  apply tendsto_iff_norm_sub_tendsto_zero.mpr
  have he (t : NNReal) : ‖F t‖ =
      ‖(t : ℝ)⁻¹ • (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x - x) - y‖ :=
    b.repr.norm_map _
  simpa only [he] using hn

/-- Any true strong right derivative of the actual semigroup belongs to the original entire closed generator graph. -/
theorem textbookBrownianGibbsSpectralEvolution_graph_of_right_derivative
    (x y : Gibbs U β)
    (ht : Tendsto (fun t : NNReal ↦ (t : ℝ)⁻¹ •
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x - x))
        (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 y)) :
    (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  apply (textbookBrownianGibbsClosedOperator_graph_iff_coefficients m hm U hU hPU β hβ x y).mpr
  intro j
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  have hc := ((innerSL ℝ (b j)).continuous.tendsto y).comp ht
  have he (t : NNReal) :
      ⟪b j, (t : ℝ)⁻¹ • (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x - x)⟫_ℝ =
        textbookBrownianGibbsDifferenceWeight m U hU hPU β t j * ⟪b j, x⟫_ℝ := by
    rw [inner_smul_right, inner_sub_right, textbookBrownianGibbsSpectralEvolution_coefficient]
    unfold textbookBrownianGibbsDifferenceWeight
    ring
  have hl := (textbookBrownianGibbsDifferenceWeight_tendsto m U hU hPU β j).mul_const ⟪b j, x⟫_ℝ
  have hc' : Tendsto (fun t : NNReal ↦
      textbookBrownianGibbsDifferenceWeight m U hU hPU β t j * ⟪b j, x⟫_ℝ)
      (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 ⟪b j, y⟫_ℝ) := by
    simpa only [Function.comp_def, innerSL_apply_apply, he] using hc
  exact tendsto_nhds_unique hc' hl

/-- The whole original closed generator is exactly the genuine infinitesimal generator of the actual C0 semigroup. -/
theorem textbookBrownianGibbsSpectralEvolution_generator_graph_iff
    (x y : Gibbs U β) :
    (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph ↔
      Tendsto (fun t : NNReal ↦ (t : ℝ)⁻¹ •
        (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x - x))
        (𝓝[Set.Ioi (0 : NNReal)] 0) (𝓝 y) :=
  ⟨textbookBrownianGibbsSpectralEvolution_right_derivative_of_graph m hm U hU hPU β hβ x y,
    textbookBrownianGibbsSpectralEvolution_graph_of_right_derivative m hm U hU hPU β hβ x y⟩

end
end MolecularDynamics
