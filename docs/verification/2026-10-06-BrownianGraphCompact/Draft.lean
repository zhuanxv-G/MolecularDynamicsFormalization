import MolecularDynamics.Chapter06.BrownianMassResolvent

/-! Compactness of the actual whole original Gibbs graph-domain embedding. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics

noncomputable section

private local instance brownianGraphCompactCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianGraphCompactCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private abbrev Haar (Nc : ℕ) := Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))

/-- The actual whole closed mass graph first projection, with the genuine inherited product norm. -/
def textbookHaarMassClosedGraphProjection {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    (textbookHaarMassClosedOperator m β).graph →L[ℝ] Haar Nc :=
  (ContinuousLinearMap.fst ℝ (Haar Nc) (Haar Nc)).comp
    (textbookHaarMassClosedOperator m β).graph.subtypeL

/-- Its actual value is exactly the original Hilbert vector in the entire graph. -/
theorem textbookHaarMassClosedGraphProjection_apply {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (z : (textbookHaarMassClosedOperator m β).graph) :
    textbookHaarMassClosedGraphProjection m β z = z.val.1 := rfl

/-- The actual whole closed mass graph embedding is compact, by its true two-sided resolvent. -/
theorem textbookHaarMassClosedGraphProjection_isCompact {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookHaarMassClosedGraphProjection m β) := by
  let S := ((ContinuousLinearMap.fst ℝ (Haar Nc) (Haar Nc)) -
    (ContinuousLinearMap.snd ℝ (Haar Nc) (Haar Nc))).comp
      (textbookHaarMassClosedOperator m β).graph.subtypeL
  have h : textbookHaarMassClosedGraphProjection m β =
      (textbookHaarMassFourierOperator m hm β hβ).comp S := by
    ext z
    change z.val.1 = textbookHaarMassFourierOperator m hm β hβ (z.val.1 - z.val.2)
    exact (textbookHaarMassFourierOperator_inverse_graph m hm β hβ _ _ z.prop).symm
  rw [h]
  exact (textbookHaarMassFourierOperator_isCompact m hm β hβ).comp_clm S

/-- The actual whole original-potential closed Haar graph first projection. -/
def textbookBrownianHaarClosedGraphProjection {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph →L[ℝ] Haar Nc :=
  (ContinuousLinearMap.fst ℝ (Haar Nc) (Haar Nc)).comp
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph.subtypeL

/-- The actual projection retains exactly the genuine original-potential Haar vector. -/
theorem textbookBrownianHaarClosedGraphProjection_apply {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph) :
    textbookBrownianHaarClosedGraphProjection m U hU hPU β z = z.val.1 := rfl

private def haarGraph_to_mass {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph →L[ℝ]
      (textbookHaarMassClosedOperator m β).graph :=
  (((textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).symm.toContinuousLinearMap).comp
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph.subtypeL).codRestrict
      (textbookHaarMassClosedOperator m β).graph (fun z ↦ by
        change (z.val.1, z.val.2 - textbookBrownianHaarPotentialOperator m U hU hPU β z.val.1) ∈ _
        exact (textbookBrownianHaarPotential_closed_graph_iff m U hU hPU β hβ _ _).mp z.prop)

/-- The actual bounded original-potential graph transform preserves compact graph embedding. -/
theorem textbookBrownianHaarClosedGraphProjection_isCompact {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianHaarClosedGraphProjection m U hU hPU β) := by
  have h : textbookBrownianHaarClosedGraphProjection m U hU hPU β =
      (textbookHaarMassClosedGraphProjection m β).comp
        (haarGraph_to_mass m U hU hPU β hβ.ne') := by
    ext z
    rfl
  rw [h]
  exact (textbookHaarMassClosedGraphProjection_isCompact m hm β hβ).comp_clm
    (haarGraph_to_mass m U hU hPU β hβ.ne')

/-- The actual same-Gibbs closed graph embedding, into the genuine original Gibbs Hilbert space. -/
def textbookBrownianGibbsClosedGraphProjection {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).graph →L[ℝ]
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  (ContinuousLinearMap.fst ℝ
    (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))).comp
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.subtypeL

/-- Its value is precisely the entire genuine original Gibbs graph's first vector. -/
theorem textbookBrownianGibbsClosedGraphProjection_apply {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    textbookBrownianGibbsClosedGraphProjection m U hU hPU β z = z.val.1 := rfl

private def gibbsGraph_to_haar {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).graph →L[ℝ]
      (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph :=
  ((textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toContinuousLinearMap.comp
    (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.subtypeL).codRestrict
      (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph (fun z ↦ by
        change (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β) z.val ∈ _
        rw [← textbookGibbsHaarGroundState_closed_graph m U hU hPU β hβ]
        exact Submodule.mem_map.mpr ⟨z.val, z.prop, rfl⟩)

/-- The genuine original same-Gibbs whole closed graph embedding is compact. -/
theorem textbookBrownianGibbsClosedGraphProjection_isCompact {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsClosedGraphProjection m U hU hPU β) := by
  let I := textbookGibbsHaarGroundStateIsometry U hU hPU β
  have h : textbookBrownianGibbsClosedGraphProjection m U hU hPU β =
      I.symm.toContinuousLinearEquiv.toContinuousLinearMap.comp
        ((textbookBrownianHaarClosedGraphProjection m U hU hPU β).comp
          (gibbsGraph_to_haar m U hU hPU β hβ.ne')) := by
    ext z
    change z.val.1 = I.symm (I z.val.1)
    exact (I.symm_apply_apply z.val.1).symm
  rw [h]
  exact ((textbookBrownianHaarClosedGraphProjection_isCompact m hm U hU hPU β hβ).comp_clm
    (gibbsGraph_to_haar m U hU hPU β hβ.ne')).clm_comp
      I.symm.toContinuousLinearEquiv.toContinuousLinearMap

end

end MolecularDynamics