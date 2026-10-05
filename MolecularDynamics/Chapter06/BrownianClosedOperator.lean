import MolecularDynamics.Chapter06.BrownianSmoothDensity
import Mathlib.Analysis.InnerProductSpace.LinearPMap

/-! The actual densely defined Brownian operator, its adjoint, and its genuine graph closure.
Self-adjointness and spectral statements require additional proof. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics

variable {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)

/-- The original actual smooth-domain operator as a genuine partially defined linear operator. -/
noncomputable def textbookBrownianGibbsPartialOperator :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →ₗ.[ℝ]
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) where
  domain := textbookBrownianGibbsSmoothDomain U hU hPU β
  toFun := textbookBrownianGibbsDomainOperator m U hU hPU β

/-- Its domain is exactly the same full smooth periodic Gibbs Hilbert domain. -/
theorem textbookBrownianGibbsPartialOperator_domain :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).domain =
      textbookBrownianGibbsSmoothDomain U hU hPU β :=
  rfl

/-- Its values are exactly the already proved actual-domain Brownian values. -/
theorem textbookBrownianGibbsPartialOperator_apply
    (x : textbookBrownianGibbsSmoothDomain U hU hPU β) :
    textbookBrownianGibbsPartialOperator m U hU hPU β x =
      textbookBrownianGibbsDomainOperator m U hU hPU β x :=
  rfl

/-- The partial operator is genuinely densely defined for the same actual measure. -/
theorem textbookBrownianGibbsPartialOperator_dense :
    Dense ((textbookBrownianGibbsPartialOperator m U hU hPU β).domain :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) :=
  textbookBrownianGibbsSmoothDomain_dense U hU hPU β

/-- The same actual partial operator is its own formal adjoint on its smooth domain. -/
theorem textbookBrownianGibbsPartialOperator_formalAdjoint (hβ : β ≠ 0) :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).IsFormalAdjoint
      (textbookBrownianGibbsPartialOperator m U hU hPU β) := by
  intro x y
  exact (textbookBrownianGibbsDomainOperator_symmetric m U hU hPU β hβ x y).symm

/-- The genuine adjoint extends the actual smooth operator, using proved density. -/
theorem textbookBrownianGibbsPartialOperator_le_adjoint (hβ : β ≠ 0) :
    textbookBrownianGibbsPartialOperator m U hU hPU β ≤
      (textbookBrownianGibbsPartialOperator m U hU hPU β).adjoint :=
  LinearPMap.IsFormalAdjoint.le_adjoint
    (textbookBrownianGibbsPartialOperator_dense m U hU hPU β)
    (textbookBrownianGibbsPartialOperator_formalAdjoint m U hU hPU β hβ)

/-- The actual adjoint is closed; its densely defined construction is not the junk case. -/
theorem textbookBrownianGibbsPartialOperator_adjoint_isClosed :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).adjoint.IsClosed :=
  LinearPMap.adjoint_isClosed
    (textbookBrownianGibbsPartialOperator_dense m U hU hPU β)

/-- The genuine adjoint also has a dense domain, because it contains the full smooth domain. -/
theorem textbookBrownianGibbsPartialOperator_adjoint_dense (hβ : β ≠ 0) :
    Dense ((textbookBrownianGibbsPartialOperator m U hU hPU β).adjoint.domain :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) :=
  (textbookBrownianGibbsPartialOperator_dense m U hU hPU β).mono
    (textbookBrownianGibbsPartialOperator_le_adjoint m U hU hPU β hβ).1

/-- The actual Brownian operator is closable, with an actual closed adjoint extension. -/
theorem textbookBrownianGibbsPartialOperator_isClosable (hβ : β ≠ 0) :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).IsClosable :=
  (textbookBrownianGibbsPartialOperator_adjoint_isClosed m U hU hPU β).isClosable.leIsClosable
    (textbookBrownianGibbsPartialOperator_le_adjoint m U hU hPU β hβ)

/-- The actual graph closure of the original Brownian operator; genuine closure is proved below. -/
noncomputable def textbookBrownianGibbsClosedOperator :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →ₗ.[ℝ]
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  (textbookBrownianGibbsPartialOperator m U hU hPU β).closure

/-- The actual original operator is contained in its constructed graph closure. -/
theorem textbookBrownianGibbsPartialOperator_le_closed :
    textbookBrownianGibbsPartialOperator m U hU hPU β ≤
      textbookBrownianGibbsClosedOperator m U hU hPU β :=
  LinearPMap.le_closure _

/-- The constructed closure really is a closed operator in the same weighted Hilbert space. -/
theorem textbookBrownianGibbsClosedOperator_isClosed (hβ : β ≠ 0) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).IsClosed :=
  (textbookBrownianGibbsPartialOperator_isClosable m U hU hPU β hβ).closure_isClosed

/-- Its graph is literally the topological closure of the original operator graph. -/
theorem textbookBrownianGibbsClosedOperator_graph (hβ : β ≠ 0) :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).graph.topologicalClosure =
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph :=
  (textbookBrownianGibbsPartialOperator_isClosable m U hU hPU β hβ).graph_closure_eq_closure_graph

/-- The actual closed realization has a dense domain, derived from the original smooth domain. -/
theorem textbookBrownianGibbsClosedOperator_dense :
    Dense ((textbookBrownianGibbsClosedOperator m U hU hPU β).domain :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) :=
  (textbookBrownianGibbsPartialOperator_dense m U hU hPU β).mono
    (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1

/-- The genuine full smooth periodic domain is a core of the constructed closure. -/
theorem textbookBrownianGibbsClosedOperator_hasCore :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).HasCore
      (textbookBrownianGibbsSmoothDomain U hU hPU β) :=
  LinearPMap.closureHasCore _

/-- The graph closure retains all actual original-domain values. -/
theorem textbookBrownianGibbsClosedOperator_apply_domain
    (x : textbookBrownianGibbsSmoothDomain U hU hPU β) :
    textbookBrownianGibbsClosedOperator m U hU hPU β
      (Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1 x) =
      textbookBrownianGibbsDomainOperator m U hU hPU β x :=
  (LinearPMap.apply_comp_inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β) x).symm

/-- Every actual smooth lift has the literal original differential-generator value under the closure. -/
theorem textbookBrownianGibbsClosedOperator_apply_lift (f : textbookPeriodicSmoothSpace Nc) :
    textbookBrownianGibbsClosedOperator m U hU hPU β
      (Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
        (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β f)) =
      textbookBrownianGibbsL2Image m U hU hPU β f f.prop.1 f.prop.2 := by
  rw [textbookBrownianGibbsClosedOperator_apply_domain]
  exact textbookBrownianGibbsDomainOperator_apply_equiv m U hU hPU β f

/-- The actual graph closure retains the original constant zero mode. -/
theorem textbookBrownianGibbsClosedOperator_const (c : ℝ) :
    textbookBrownianGibbsClosedOperator m U hU hPU β
      (Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
        (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc c))) = 0 := by
  rw [textbookBrownianGibbsClosedOperator_apply_domain]
  exact textbookBrownianGibbsDomainOperator_const m U hU hPU β c

/-- The actual closure is the least closed extension of the actual original operator. -/
theorem textbookBrownianGibbsClosedOperator_le_extension
    (S : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →ₗ.[ℝ]
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hS : S.IsClosed) (hTS : textbookBrownianGibbsPartialOperator m U hU hPU β ≤ S) :
    textbookBrownianGibbsClosedOperator m U hU hPU β ≤ S := by
  have h := hS.isClosable.closure_mono hTS
  have he : S.closure = S := LinearPMap.eq_of_eq_graph
    (hS.isClosable.graph_closure_eq_closure_graph.symm.trans hS.submodule_topologicalClosure_eq)
  exact he ▸ h

/-- A closure-domain graph point belongs to the actual closure of the original graph. -/
private theorem textbookBrownianGibbsClosedOperator_mem_graphClosure (hβ : β ≠ 0)
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain) :
    ((x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
      textbookBrownianGibbsClosedOperator m U hU hPU β x) ∈
      closure ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph :
        Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
          Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) := by
  change ((x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
      textbookBrownianGibbsClosedOperator m U hU hPU β x) ∈
    (textbookBrownianGibbsPartialOperator m U hU hPU β).graph.topologicalClosure
  rw [textbookBrownianGibbsClosedOperator_graph m U hU hPU β hβ]
  exact LinearPMap.mem_graph _ x

/-- Formal adjointness extends across the actual graph closure in the first argument. -/
theorem textbookBrownianGibbsClosedOperator_formalAdjoint_partial (hβ : β ≠ 0) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).IsFormalAdjoint
      (textbookBrownianGibbsPartialOperator m U hU hPU β) := by
  intro x y
  have hclosed : IsClosed {z :
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) |
      ⟪z.2, (y : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ =
        ⟪z.1, textbookBrownianGibbsPartialOperator m U hU hPU β y⟫_ℝ} :=
    isClosed_eq (continuous_snd.inner continuous_const) (continuous_fst.inner continuous_const)
  have hsub : ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) ⊆
      {z | ⟪z.2, (y : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ =
        ⟪z.1, textbookBrownianGibbsPartialOperator m U hU hPU β y⟫_ℝ} := by
    intro z hz
    rcases (LinearPMap.mem_graph_iff' _).mp hz with ⟨a, rfl⟩
    exact textbookBrownianGibbsPartialOperator_formalAdjoint m U hU hPU β hβ a y
  exact (closure_minimal hsub hclosed)
    (textbookBrownianGibbsClosedOperator_mem_graphClosure m U hU hPU β hβ x)

/-- The actual closed realization is formally symmetric on its entire actual closed domain. -/
theorem textbookBrownianGibbsClosedOperator_formalAdjoint (hβ : β ≠ 0) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).IsFormalAdjoint
      (textbookBrownianGibbsClosedOperator m U hU hPU β) := by
  intro x y
  have hclosed : IsClosed {z :
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) |
      ⟪textbookBrownianGibbsClosedOperator m U hU hPU β x, z.1⟫_ℝ =
        ⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)), z.2⟫_ℝ} :=
    isClosed_eq (continuous_const.inner continuous_fst) (continuous_const.inner continuous_snd)
  have hsub : ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) ⊆
      {z | ⟪textbookBrownianGibbsClosedOperator m U hU hPU β x, z.1⟫_ℝ =
        ⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)), z.2⟫_ℝ} := by
    intro z hz
    rcases (LinearPMap.mem_graph_iff' _).mp hz with ⟨a, rfl⟩
    exact textbookBrownianGibbsClosedOperator_formalAdjoint_partial m U hU hPU β hβ x a
  exact (closure_minimal hsub hclosed)
    (textbookBrownianGibbsClosedOperator_mem_graphClosure m U hU hPU β hβ y)

/-- The actual closed-domain quadratic form remains nonpositive by continuity on the actual graph. -/
theorem textbookBrownianGibbsClosedOperator_nonpos (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain) :
    ⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
      textbookBrownianGibbsClosedOperator m U hU hPU β x⟫_ℝ ≤ 0 := by
  have hclosed : IsClosed {z :
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) |
      ⟪z.1, z.2⟫_ℝ ≤ 0} :=
    isClosed_le (continuous_fst.inner continuous_snd) continuous_const
  have hsub : ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) ⊆
      {z | ⟪z.1, z.2⟫_ℝ ≤ 0} := by
    intro z hz
    rcases (LinearPMap.mem_graph_iff' _).mp hz with ⟨a, rfl⟩
    exact textbookBrownianGibbsDomainOperator_nonpos m hm U hU hPU β hβ a
  exact (closure_minimal hsub hclosed)
    (textbookBrownianGibbsClosedOperator_mem_graphClosure m U hU hPU β hβ.ne' x)

end MolecularDynamics
