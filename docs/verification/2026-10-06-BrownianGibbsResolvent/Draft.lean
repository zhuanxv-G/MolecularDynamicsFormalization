import MolecularDynamics.Chapter06.BrownianGraphCompact
import Mathlib.Analysis.Normed.Operator.Banach
import Mathlib.Topology.MetricSpace.Antilipschitz

/-! Actual original same-Gibbs closed graph resolvent construction. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics

noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ)

/-- The true shifted original closed graph map, in the actual same Gibbs Hilbert space. -/
def textbookBrownianGibbsClosedGraphShift :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).graph →L[ℝ] Gibbs U β :=
  ((ContinuousLinearMap.fst ℝ (Gibbs U β) (Gibbs U β)) -
    (ContinuousLinearMap.snd ℝ (Gibbs U β) (Gibbs U β))).comp
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.subtypeL

/-- Its true value is the original vector minus the actual closed generator value. -/
theorem textbookBrownianGibbsClosedGraphShift_apply
    (z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    textbookBrownianGibbsClosedGraphShift m U hU hPU β z = z.val.1 - z.val.2 := rfl

private theorem graph_nonpos (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    ⟪z.val.1, z.val.2⟫_ℝ ≤ 0 := by
  obtain ⟨u, hu, hAu⟩ := (LinearPMap.mem_graph_iff _).mp z.prop
  have h := textbookBrownianGibbsClosedOperator_nonpos m U hU hPU β hm hβ u
  rw [hu, hAu] at h
  exact h

/-- True original nonpositivity controls the first graph vector by the actual shift norm. -/
theorem textbookBrownianGibbsClosedGraphShift_norm_first
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    ‖z.val.1‖ ≤ ‖textbookBrownianGibbsClosedGraphShift m U hU hPU β z‖ := by
  rw [textbookBrownianGibbsClosedGraphShift_apply]
  have hnonpos := graph_nonpos m U hU hPU β hm hβ z
  have hinner : ‖z.val.1‖ ^ 2 ≤ ⟪z.val.1, z.val.1 - z.val.2⟫_ℝ := by
    rw [inner_sub_right, real_inner_self_eq_norm_sq]
    linarith
  have hcs : ⟪z.val.1, z.val.1 - z.val.2⟫_ℝ ≤ ‖z.val.1‖ * ‖z.val.1 - z.val.2‖ :=
    by
      have hh := norm_inner_le_norm (𝕜 := ℝ) z.val.1 (z.val.1 - z.val.2)
      have hb : |⟪z.val.1, z.val.1 - z.val.2⟫_ℝ| ≤ ‖z.val.1‖ * ‖z.val.1 - z.val.2‖ := by
        simpa only [Real.norm_eq_abs] using hh
      exact (le_abs_self _).trans hb
  by_cases hx : ‖z.val.1‖ = 0
  · rw [hx]
    exact norm_nonneg _
  · have hxpos : 0 < ‖z.val.1‖ := lt_of_le_of_ne (norm_nonneg _) (Ne.symm hx)
    nlinarith

/-- The entire actual inherited product graph norm is controlled by twice the genuine shift norm. -/
theorem textbookBrownianGibbsClosedGraphShift_norm_graph
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    ‖z‖ ≤ 2 * ‖textbookBrownianGibbsClosedGraphShift m U hU hPU β z‖ := by
  have hx := textbookBrownianGibbsClosedGraphShift_norm_first m U hU hPU β hm hβ z
  have hy : ‖z.val.2‖ ≤ ‖z.val.1‖ + ‖z.val.1 - z.val.2‖ := by
    calc
      _ = ‖z.val.1 - (z.val.1 - z.val.2)‖ := by congr 1; abel
      _ ≤ _ := norm_sub_le _ _
  change ‖z.val‖ ≤ _
  rw [Prod.norm_def]
  rw [textbookBrownianGibbsClosedGraphShift_apply] at hx ⊢
  apply max_le
  · nlinarith [norm_nonneg (z.val.1 - z.val.2)]
  · linarith

private theorem shift_antilipschitz (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    AntilipschitzWith 2 (textbookBrownianGibbsClosedGraphShift m U hU hPU β) := by
  apply AntilipschitzWith.of_le_mul_dist
  intro z w
  rw [dist_eq_norm, dist_eq_norm, ← map_sub]
  exact textbookBrownianGibbsClosedGraphShift_norm_graph m U hU hPU β hm hβ (z - w)

/-- The actual shifted entire original Gibbs graph map is injective, from the real graph norm estimate. -/
theorem textbookBrownianGibbsClosedGraphShift_injective
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    Function.Injective (textbookBrownianGibbsClosedGraphShift m U hU hPU β) :=
  (shift_antilipschitz m U hU hPU β hm hβ).injective

private theorem shift_range_closed (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    IsClosed ((textbookBrownianGibbsClosedGraphShift m U hU hPU β).range : Set (Gibbs U β)) := by
  letI : IsClosed ((textbookBrownianGibbsClosedOperator m U hU hPU β).graph :
      Set (Gibbs U β × Gibbs U β)) :=
    textbookBrownianGibbsClosedOperator_isClosed m U hU hPU β hβ.ne'
  letI : CompleteSpace (textbookBrownianGibbsClosedOperator m U hU hPU β).graph :=
    IsClosed.completeSpace_coe
  change IsClosed (Set.range (textbookBrownianGibbsClosedGraphShift m U hU hPU β))
  exact (shift_antilipschitz m U hU hPU β hm hβ).isClosed_range
    (textbookBrownianGibbsClosedGraphShift m U hU hPU β).uniformContinuous

private theorem shift_range_orthogonal (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    (textbookBrownianGibbsClosedGraphShift m U hU hPU β).rangeᗮ = ⊥ := by
  apply Submodule.eq_bot_iff.mpr
  intro v hv
  have htest : ∀ u : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain,
      ⟪v, (u : Gibbs U β)⟫_ℝ =
        ⟪v, textbookBrownianGibbsClosedOperator m U hU hPU β u⟫_ℝ := by
    intro u
    let z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph :=
      ⟨((u : Gibbs U β), textbookBrownianGibbsClosedOperator m U hU hPU β u),
        (LinearPMap.mem_graph_iff' _).mpr ⟨u, rfl⟩⟩
    have hmem : textbookBrownianGibbsClosedGraphShift m U hU hPU β z ∈
        (textbookBrownianGibbsClosedGraphShift m U hU hPU β).range := ⟨z, rfl⟩
    have h := (Submodule.mem_orthogonal _ v).mp hv _ hmem
    change ⟪(u : Gibbs U β) - textbookBrownianGibbsClosedOperator m U hU hPU β u, v⟫_ℝ = 0 at h
    rw [inner_sub_left] at h
    calc
      _ = ⟪(u : Gibbs U β), v⟫_ℝ := real_inner_comm _ _
      _ = ⟪textbookBrownianGibbsClosedOperator m U hU hPU β u, v⟫_ℝ := sub_eq_zero.mp h
      _ = _ := real_inner_comm _ _
  have hvd : v ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β)†.domain :=
    LinearPMap.mem_adjoint_domain_of_exists v ⟨v, htest⟩
  let a : (textbookBrownianGibbsClosedOperator m U hU hPU β)†.domain := ⟨v, hvd⟩
  have hAv : (textbookBrownianGibbsClosedOperator m U hU hPU β)† a = v :=
    LinearPMap.adjoint_apply_eq
      (textbookBrownianGibbsClosedOperator_dense m U hU hPU β) a htest
  have hgraph : (v, v) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β)†.graph :=
    (LinearPMap.mem_graph_iff _).mpr ⟨a, rfl, hAv⟩
  have hself := textbookBrownianGibbsClosedOperator_isSelfAdjoint m U hU hPU β hβ.ne'
  rw [LinearPMap.isSelfAdjoint_def] at hself
  rw [hself] at hgraph
  obtain ⟨u, hu, hAu⟩ := (LinearPMap.mem_graph_iff _).mp hgraph
  have hn := textbookBrownianGibbsClosedOperator_nonpos m U hU hPU β hm hβ u
  change (u : Gibbs U β) = v at hu
  change textbookBrownianGibbsClosedOperator m U hU hPU β u = v at hAu
  rw [hu, hAu, real_inner_self_eq_norm_sq] at hn
  have hnorm : ‖v‖ = 0 := by nlinarith [norm_nonneg v]
  exact Submodule.mem_bot.mpr (norm_eq_zero.mp hnorm)

/-- The entire actual shifted Gibbs closed graph is onto the whole original Gibbs Hilbert space. -/
theorem textbookBrownianGibbsClosedGraphShift_range_eq_top
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    (textbookBrownianGibbsClosedGraphShift m U hU hPU β).range = ⊤ := by
  letI : IsClosed ((textbookBrownianGibbsClosedGraphShift m U hU hPU β).range :
      Set (Gibbs U β)) := shift_range_closed m U hU hPU β hm hβ
  letI : CompleteSpace (textbookBrownianGibbsClosedGraphShift m U hU hPU β).range :=
    IsClosed.completeSpace_coe
  exact Submodule.orthogonal_eq_bot_iff.mp (shift_range_orthogonal m U hU hPU β hm hβ)

private def shifted_graph_equiv (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).graph ≃L[ℝ] Gibbs U β := by
  letI : IsClosed ((textbookBrownianGibbsClosedOperator m U hU hPU β).graph :
      Set (Gibbs U β × Gibbs U β)) :=
    textbookBrownianGibbsClosedOperator_isClosed m U hU hPU β hβ.ne'
  letI : CompleteSpace (textbookBrownianGibbsClosedOperator m U hU hPU β).graph :=
    IsClosed.completeSpace_coe
  exact ContinuousLinearEquiv.ofBijective (textbookBrownianGibbsClosedGraphShift m U hU hPU β)
    (LinearMap.ker_eq_bot.mpr (textbookBrownianGibbsClosedGraphShift_injective m U hU hPU β hm hβ))
    (textbookBrownianGibbsClosedGraphShift_range_eq_top m U hU hPU β hm hβ)

/-- The genuine bounded original same-Gibbs resolvent at 1, defined using the actual onto shifted graph. -/
def textbookBrownianGibbsResolvent (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    Gibbs U β →L[ℝ] Gibbs U β :=
  (textbookBrownianGibbsClosedGraphProjection m U hU hPU β).comp
    (shifted_graph_equiv m U hU hPU β hm hβ).symm.toContinuousLinearMap

/-- Every original Gibbs vector has its actual shifted closed-graph preimage. -/
theorem textbookBrownianGibbsResolvent_mem_graph
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (x : Gibbs U β) :
    (textbookBrownianGibbsResolvent m U hU hPU β hm hβ x,
      textbookBrownianGibbsResolvent m U hU hPU β hm hβ x - x) ∈
        (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  let E := shifted_graph_equiv m U hU hPU β hm hβ
  let z := E.symm x
  have hz := E.apply_symm_apply x
  change z.val.1 - z.val.2 = x at hz
  have hy : z.val.2 = z.val.1 - x := by rw [← hz]; abel
  change (z.val.1, z.val.1 - x) ∈ _
  rw [← hy]
  exact z.prop

/-- The same genuine bounded map is a left inverse on the whole original Gibbs closed graph. -/
theorem textbookBrownianGibbsResolvent_inverse_graph
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (x y : Gibbs U β)
    (hxy : (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    textbookBrownianGibbsResolvent m U hU hPU β hm hβ (x - y) = x := by
  let E := shifted_graph_equiv m U hU hPU β hm hβ
  let z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := ⟨(x, y), hxy⟩
  have hz := E.symm_apply_apply z
  have hf := congrArg (fun p : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph ↦ p.val.1) hz
  exact hf

/-- The actual whole original Gibbs resolvent contracts the true Gibbs Hilbert norm. -/
theorem textbookBrownianGibbsResolvent_norm
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (x : Gibbs U β) :
    ‖textbookBrownianGibbsResolvent m U hU hPU β hm hβ x‖ ≤ ‖x‖ := by
  let E := shifted_graph_equiv m U hU hPU β hm hβ
  let z := E.symm x
  have h := textbookBrownianGibbsClosedGraphShift_norm_first m U hU hPU β hm hβ z
  have hz := E.apply_symm_apply x
  change textbookBrownianGibbsClosedGraphShift m U hU hPU β z = x at hz
  rw [hz] at h
  exact h

/-- Compactness of the true original same-Gibbs resolvent follows from the actual compact whole graph embedding. -/
theorem textbookBrownianGibbsResolvent_isCompact
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) :=
  (textbookBrownianGibbsClosedGraphProjection_isCompact m hm U hU hPU β hβ).comp_clm
    (shifted_graph_equiv m U hU hPU β hm hβ).symm.toContinuousLinearMap

/-- The original general-potential same-Gibbs entire graph closure has a genuine compact two-sided resolvent. -/
theorem textbookBrownianGibbsClosedOperator_hasCompactResolvent
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) :
    ∃ R : Gibbs U β →L[ℝ] Gibbs U β,
      IsCompactOperator R ∧
      (∀ x, (R x, R x - x) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) ∧
      (∀ x y, (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph →
        R (x - y) = x) :=
  ⟨textbookBrownianGibbsResolvent m U hU hPU β hm hβ,
    textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ,
    textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ,
    textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ⟩

end

end MolecularDynamics