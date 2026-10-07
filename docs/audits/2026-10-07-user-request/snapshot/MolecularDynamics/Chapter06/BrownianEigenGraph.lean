import MolecularDynamics.Chapter06.BrownianResolventSpectrum

/-! Actual entire closed generator graph and domain in its genuine whole Gibbs eigenbasis. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- All actual closed-graph values have the actual generator eigenvalue-weighted coefficients. -/
theorem textbookBrownianGibbsClosedOperator_graph_coefficient
    (x y : Gibbs U β)
    (hg : (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, y⟫_ℝ =
      j.1 * ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ := by
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp hg
  obtain ⟨b, hb, hAb⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ j)
  have h := textbookBrownianGibbsClosedOperator_formalAdjoint m U hU hPU β hβ.ne' b a
  rw [hb, ha, hAb, hAa, real_inner_smul_left] at h
  exact h.symm

/-- Exact characterization of the whole actual original closed generator graph by its full eigenbasis coefficients. -/
theorem textbookBrownianGibbsClosedOperator_graph_iff_coefficients
    (x y : Gibbs U β) :
    (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph ↔
      ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
        ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, y⟫_ℝ =
          j.1 * ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ := by
  constructor
  · intro hg j
    exact textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ x y hg j
  · intro hc
    let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
    have hx := textbookBrownianGibbsEigenbasis_hasSum m hm U hU hPU β hβ x
    have hy := textbookBrownianGibbsEigenbasis_hasSum m hm U hU hPU β hβ y
    have hp := hx.prodMk hy
    apply (textbookBrownianGibbsClosedOperator_isClosed m U hU hPU β hβ.ne').mem_of_tendsto hp
    apply Eventually.of_forall
    intro s
    apply Submodule.sum_mem
    intro j hj
    have hg := (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.smul_mem
      ⟪b j, x⟫_ℝ (textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ j)
    have he : ⟪b j, y⟫_ℝ • b j = ⟪b j, x⟫_ℝ • (j.1 • b j) := by
      rw [hc j, smul_smul, mul_comm]
    change (⟪b j, x⟫_ℝ • b j, ⟪b j, y⟫_ℝ • b j) ∈ _
    rw [he]
    exact hg

/-- The true whole original generator domain is precisely the square-summable eigenvalue-weighted coefficients. -/
theorem textbookBrownianGibbsClosedOperator_domain_iff_coefficients
    (x : Gibbs U β) :
    x ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).domain ↔
      Memℓp (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦
        j.1 * ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ) 2 := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  constructor
  · intro hx
    let a : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain := ⟨x, hx⟩
    let y := textbookBrownianGibbsClosedOperator m U hU hPU β a
    have hg : (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph :=
      (LinearPMap.mem_graph_iff _).mpr ⟨a, rfl, rfl⟩
    have he : (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ j.1 * ⟪b j, x⟫_ℝ) =
        (fun j ↦ b.repr y j) := by
      funext j
      rw [HilbertBasis.repr_apply_apply]
      exact (textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ x y hg j).symm
    rw [he]
    exact lp.memℓp (b.repr y)
  · intro hx
    let a : lp (fun _ : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ ℝ) 2 :=
      ⟨fun j ↦ j.1 * ⟪b j, x⟫_ℝ, hx⟩
    let y := b.repr.symm a
    have hc : ∀ j, ⟪b j, y⟫_ℝ = j.1 * ⟪b j, x⟫_ℝ := by
      intro j
      rw [← HilbertBasis.repr_apply_apply]
      change b.repr (b.repr.symm a) j = _
      rw [b.repr.apply_symm_apply]
    have hg := (textbookBrownianGibbsClosedOperator_graph_iff_coefficients
      m hm U hU hPU β hβ x y).mpr hc
    obtain ⟨v, hv, _⟩ := (LinearPMap.mem_graph_iff _).mp hg
    change (v : Gibbs U β) = x at hv
    rw [← hv]
    exact v.prop

/-- The actual closed generator acts by actual eigenvalue multiplication on every vector of its entire domain. -/
theorem textbookBrownianGibbsClosedOperator_apply_coefficient
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j,
      textbookBrownianGibbsClosedOperator m U hU hPU β x⟫_ℝ =
        j.1 * ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, (x : Gibbs U β)⟫_ℝ :=
  textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ
    x (textbookBrownianGibbsClosedOperator m U hU hPU β x)
    ((LinearPMap.mem_graph_iff _).mpr ⟨x, rfl, rfl⟩) j

/-- The genuine original resolvent is diagonal with the true inverse shifted generator eigenvalues. -/
theorem textbookBrownianGibbsResolvent_coefficient
    (x : Gibbs U β) (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j,
      textbookBrownianGibbsResolvent m U hU hPU β hm hβ x⟫_ℝ =
        (1 - j.1)⁻¹ * ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ := by
  have h := textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ
    _ _ (textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x) j
  rw [inner_sub_right] at h
  have hn := textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j
  have hd : 1 - j.1 ≠ 0 := by linarith
  rw [inv_mul_eq_div]
  apply (eq_div_iff hd).mpr
  nlinarith

end
end MolecularDynamics
