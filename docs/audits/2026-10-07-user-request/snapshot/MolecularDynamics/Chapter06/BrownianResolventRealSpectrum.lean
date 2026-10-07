import MolecularDynamics.Chapter06.BrownianSpectralDecay

/-! Whole real spectrum of the genuine compact original Gibbs resolvent. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- Every nonzero point of the actual whole real resolvent spectrum is a genuine eigenvalue, and conversely. -/
theorem textbookBrownianGibbsResolvent_eigenvalue_iff_real_spectrum (r : ℝ) (hr : r ≠ 0) :
    Module.End.HasEigenvalue (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap r ↔
      r ∈ spectrum ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) :=
  (textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ).hasEigenvalue_iff_mem_spectrum hr

/-- The actual whole real compact-resolvent spectrum is nonnegative and bounded above by one. -/
theorem textbookBrownianGibbsResolvent_real_spectrum_bounds (r : ℝ)
    (hs : r ∈ spectrum ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ)) :
    r = 0 ∨ (0 < r ∧ r ≤ 1) := by
  by_cases hr : r = 0
  · exact Or.inl hr
  · have he := (textbookBrownianGibbsResolvent_eigenvalue_iff_real_spectrum
      m hm U hU hPU β hβ r hr).mpr hs
    obtain ⟨x, hx, hx0⟩ := he.exists_hasEigenvector
    have hRx : textbookBrownianGibbsResolvent m U hU hPU β hm hβ x = r • x := by
      simp only [Module.End.mem_genEigenspace_one] at hx
      exact hx
    exact Or.inr (textbookBrownianGibbsResolvent_eigenvalue_bounds m hm U hU hPU β hβ r x hx0 hRx)

/-- Every actual whole real spectral value away from the constant mode has the derived strict resolvent separation. -/
theorem textbookBrownianGibbsResolvent_real_spectrum_gap (r : ℝ) (hr1 : r ≠ 1)
    (hs : r ∈ spectrum ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ)) :
    r ≤ (1 + textbookBrownianGibbsCoercivityRate m U hU hPU β)⁻¹ := by
  have hk := textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ
  have hc : 0 < 1 + textbookBrownianGibbsCoercivityRate m U hU hPU β := by linarith
  by_cases hr : r = 0
  · rw [hr]
    exact le_of_lt (inv_pos.mpr hc)
  · have he := (textbookBrownianGibbsResolvent_eigenvalue_iff_real_spectrum
      m hm U hU hPU β hβ r hr).mpr hs
    obtain ⟨x, hx, hx0⟩ := he.exists_hasEigenvector
    have hRx : textbookBrownianGibbsResolvent m U hU hPU β hm hβ x = r • x := by
      simp only [Module.End.mem_genEigenspace_one] at hx
      exact hx
    have hp := (textbookBrownianGibbsResolvent_eigenvalue_bounds m hm U hU hPU β hβ r x hx0 hRx).1
    have hℓ : 1 - r⁻¹ ≠ 0 := by
      intro h
      have hi : r⁻¹ = 1 := by linarith
      have hm := inv_mul_cancel₀ hr
      rw [hi, one_mul] at hm
      exact hr1 hm
    obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
      (textbookBrownianGibbsResolvent_eigen_mem_graph m hm U hU hPU β hβ r hr x hRx)
    change (a : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) = x at ha
    change textbookBrownianGibbsClosedOperator m U hU hPU β a = (1 - r⁻¹) • x at hAa
    have hxa : (a : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) ≠ 0 := by
      rw [ha]
      exact hx0
    have hA : textbookBrownianGibbsClosedOperator m U hU hPU β a =
        (1 - r⁻¹) • (a : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) := by
      rw [ha]
      exact hAa
    have hb := textbookBrownianGibbsClosedOperator_real_eigenvalue_bound
      m hm U hU hPU β hβ a hxa (1 - r⁻¹) hℓ hA
    have hi : 1 + textbookBrownianGibbsCoercivityRate m U hU hPU β ≤ r⁻¹ := by linarith
    have hmul := mul_le_mul_of_nonneg_right hi hp.le
    rw [inv_mul_cancel₀ hr] at hmul
    rw [← one_div]
    apply (le_div_iff₀ hc).mpr
    nlinarith

/-- The entire actual compact-resolvent real spectrum has a strict isolated constant mode, with no completeness hypothesis. -/
theorem textbookBrownianGibbsResolvent_real_spectrum_separation :
    ∃ c : ℝ, 0 < c ∧ c < 1 ∧
      ∀ r ∈ spectrum ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ),
        r = 1 ∨ (0 ≤ r ∧ r ≤ c) := by
  let c := (1 + textbookBrownianGibbsCoercivityRate m U hU hPU β)⁻¹
  have hk := textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ
  have hp : 0 < 1 + textbookBrownianGibbsCoercivityRate m U hU hPU β := by linarith
  have hc : 0 < c := inv_pos.mpr hp
  have hc1 : c < 1 := by
    change (1 + textbookBrownianGibbsCoercivityRate m U hU hPU β)⁻¹ < 1
    rw [← one_div]
    apply (div_lt_one hp).mpr
    linarith
  refine ⟨c, hc, hc1, ?_⟩
  intro r hs
  by_cases hr : r = 1
  · exact Or.inl hr
  · apply Or.inr
    constructor
    · rcases textbookBrownianGibbsResolvent_real_spectrum_bounds m hm U hU hPU β hβ r hs with hz | hb
      · rw [hz]
      · exact hb.1.le
    · exact textbookBrownianGibbsResolvent_real_spectrum_gap m hm U hU hPU β hβ r hr hs


/-- The original normalized constant vector makes one a genuine spectral value of the actual resolvent. -/
theorem textbookBrownianGibbsResolvent_one_mem_real_spectrum :
    (1 : ℝ) ∈ spectrum ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) := by
  let e := textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
  let a := Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
    (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc 1))
  have hg : (e, 0) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph :=
    (LinearPMap.mem_graph_iff _).mpr
      ⟨a, rfl, textbookBrownianGibbsClosedOperator_const m U hU hPU β 1⟩
  have hR := textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ e 0 hg
  rw [sub_zero] at hR
  have hne : e ≠ 0 := by
    intro he
    have hn : ‖e‖ = 1 := textbookPeriodicSmoothEmbedding_one_norm U hU hPU β
    rw [he, norm_zero] at hn
    norm_num at hn
  apply (textbookBrownianGibbsResolvent_eigenvalue_iff_real_spectrum
    m hm U hU hPU β hβ 1 (by norm_num)).mp
  rw [Module.End.hasEigenvalue_iff]
  intro he
  have hx : e ∈ Module.End.eigenspace
      (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap 1 := by
    rw [Module.End.mem_eigenspace_iff, one_smul]
    exact hR
  rw [he] at hx
  exact hne hx

end
end MolecularDynamics
