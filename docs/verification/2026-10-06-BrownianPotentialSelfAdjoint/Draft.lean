import MolecularDynamics.Chapter06.BrownianPotentialOperator

/-! Genuine bounded-potential perturbation of the actual full Haar mass Laplacian closure. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace BigOperators LinearPMap

namespace MolecularDynamics

noncomputable section

private local instance brownianPotentialSelfAdjointCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianPotentialSelfAdjointCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private theorem potentialPartial_smooth_iff {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    z ∈ (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).graph ↔
      ∃ f : textbookPeriodicSmoothSpace Nc,
        (textbookPeriodicSmoothHaarEmbedding Nc f,
          textbookPeriodicSmoothHaarEmbedding Nc
            (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β f)) = z := by
  rw [LinearPMap.mem_graph_iff']
  constructor
  · rintro ⟨x, hx⟩
    obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothHaarEmbeddingEquiv Nc).surjective x
    refine ⟨f, ?_⟩
    change ((textbookPeriodicSmoothHaarEmbeddingEquiv Nc f :
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))),
        textbookBrownianHaarGroundStateDomainOperator m U hU hPU β
          (textbookPeriodicSmoothHaarEmbeddingEquiv Nc f)) = z at hx
    simpa only [textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
      textbookPeriodicSmoothHaarEmbeddingEquiv_coe] using hx
  · rintro ⟨f, hf⟩
    refine ⟨textbookPeriodicSmoothHaarEmbeddingEquiv Nc f, ?_⟩
    change ((textbookPeriodicSmoothHaarEmbeddingEquiv Nc f :
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))),
        textbookBrownianHaarGroundStateDomainOperator m U hU hPU β
          (textbookPeriodicSmoothHaarEmbeddingEquiv Nc f)) = z
    simpa only [textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
      textbookPeriodicSmoothHaarEmbeddingEquiv_coe] using hf


variable {Nc : ℕ} (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ)

/-- The actual entire smooth mass graph transforms into the actual full original-potential smooth graph. -/
theorem textbookBrownianHaarPotential_partial_graph :
    (textbookHaarMassPartialOperator m β).graph.map
      (textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).toLinearMap =
      (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).graph := by
  ext z
  rw [Submodule.mem_map]
  constructor
  · rintro ⟨w, hw, rfl⟩
    obtain ⟨f, rfl⟩ := (textbookHaarMassPartialOperator_graph_smooth m β w).mp hw
    apply (potentialPartial_smooth_iff m U hU hPU β _).mpr
    refine ⟨f, ?_⟩
    change (textbookPeriodicSmoothHaarEmbedding Nc f,
      textbookPeriodicSmoothHaarEmbedding Nc
        (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β f)) =
      (textbookPeriodicSmoothHaarEmbedding Nc f,
       textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β f) +
         textbookBrownianHaarPotentialOperator m U hU hPU β (textbookPeriodicSmoothHaarEmbedding Nc f))
    rw [textbookBrownianHaarGroundStateSmoothGenerator_embedding_split]
  · intro hz
    obtain ⟨f, rfl⟩ := (potentialPartial_smooth_iff m U hU hPU β z).mp hz
    refine ⟨(textbookPeriodicSmoothHaarEmbedding Nc f,
      textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β f)),
      (textbookHaarMassPartialOperator_graph_smooth m β _).mpr ⟨f, rfl⟩, ?_⟩
    change (textbookPeriodicSmoothHaarEmbedding Nc f,
      textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β f) +
        textbookBrownianHaarPotentialOperator m U hU hPU β (textbookPeriodicSmoothHaarEmbedding Nc f)) =
      (textbookPeriodicSmoothHaarEmbedding Nc f,
        textbookPeriodicSmoothHaarEmbedding Nc
          (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β f))
    rw [textbookBrownianHaarGroundStateSmoothGenerator_embedding_split]

private theorem mass_closed_graph {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) (hβ : β ≠ 0) :
    (textbookHaarMassPartialOperator m β).graph.topologicalClosure =
      (textbookHaarMassClosedOperator m β).graph :=
  textbookBrownianHaarGroundStateClosedOperator_graph m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β hβ

/-- The genuine whole closed graph has exactly the same bounded-potential coordinate transform. -/
theorem textbookBrownianHaarPotential_closed_graph (hβ : β ≠ 0) :
    (textbookHaarMassClosedOperator m β).graph.map
      (textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).toLinearMap =
      (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph := by
  rw [← mass_closed_graph m β hβ, textbookBrownianHaarPotentialGraphEquiv_closure,
    textbookBrownianHaarPotential_partial_graph,
    textbookBrownianHaarGroundStateClosedOperator_graph m U hU hPU β hβ]

/-- The actual full original-potential closed graph is characterized by subtracting the true bounded multiplication. -/
theorem textbookBrownianHaarPotential_closed_graph_iff (hβ : β ≠ 0)
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    (x, y) ∈ (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph ↔
      (x, y - textbookBrownianHaarPotentialOperator m U hU hPU β x) ∈
        (textbookHaarMassClosedOperator m β).graph := by
  rw [← textbookBrownianHaarPotential_closed_graph m U hU hPU β hβ, Submodule.mem_map]
  constructor
  · rintro ⟨z, hz, he⟩
    have hx := congrArg Prod.fst he
    have hy := congrArg Prod.snd he
    change z.1 = x at hx
    change z.2 + textbookBrownianHaarPotentialOperator m U hU hPU β z.1 = y at hy
    rw [hx] at hy
    have hzy : z.2 = y - textbookBrownianHaarPotentialOperator m U hU hPU β x :=
      eq_sub_of_add_eq hy
    have heq : z = (x, y - textbookBrownianHaarPotentialOperator m U hU hPU β x) :=
      Prod.ext hx hzy
    simpa only [heq] using hz
  · intro hz
    refine ⟨(x, y - textbookBrownianHaarPotentialOperator m U hU hPU β x), hz, ?_⟩
    change (x, y - textbookBrownianHaarPotentialOperator m U hU hPU β x +
      textbookBrownianHaarPotentialOperator m U hU hPU β x) = (x, y)
    simp only [sub_add_cancel]

/-- The actual original-potential Haar closure is selfadjoint on the entire real Hilbert space. -/
theorem textbookBrownianHaarGroundStateClosedOperator_isSelfAdjoint (hβ : β ≠ 0) :
    IsSelfAdjoint (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β) := by
  let T := textbookBrownianHaarGroundStateClosedOperator m U hU hPU β
  let A := textbookHaarMassClosedOperator m β
  let B := textbookBrownianHaarPotentialOperator m U hU hPU β
  have hd := textbookBrownianHaarGroundStateClosedOperator_dense m U hU hPU β
  have hAdj := LinearPMap.adjoint_isFormalAdjoint hd
  rw [LinearPMap.isSelfAdjoint_def]
  apply le_antisymm
  · apply LinearPMap.le_of_le_graph
    intro z hz
    obtain ⟨u, hu, hTu⟩ := (LinearPMap.mem_graph_iff T†).mp hz
    have ht (a : A.domain) : ⟪z.2 - B z.1, (a : Lp ℝ 2 volume)⟫_ℝ =
        ⟪z.1, A a⟫_ℝ := by
      have hgraph : ((a : Lp ℝ 2 volume), A a + B a) ∈ T.graph := by
        apply (textbookBrownianHaarPotential_closed_graph_iff m U hU hPU β hβ _ _).mpr
        simpa only [add_sub_cancel_right] using A.mem_graph a
      obtain ⟨b, hb, hTb⟩ := (LinearPMap.mem_graph_iff T).mp hgraph
      have hh := hAdj u b
      rw [hu, hTu, hb, hTb, inner_add_right] at hh
      rw [inner_sub_left, textbookBrownianHaarPotentialOperator_symmetric m U hU hPU β]
      linarith
    have hdom : z.1 ∈ A†.domain :=
      LinearPMap.mem_adjoint_domain_of_exists z.1 ⟨z.2 - B z.1, ht⟩
    let a : A†.domain := ⟨z.1, hdom⟩
    have hAa : A† a = z.2 - B z.1 :=
      LinearPMap.adjoint_apply_eq (textbookHaarMassClosedOperator_dense m β) a ht
    have hmass : (z.1, z.2 - B z.1) ∈ A.graph := by
      have h := A†.mem_graph a
      rw [hAa] at h
      have he : A† = A :=
        LinearPMap.isSelfAdjoint_def.mp (textbookHaarMassClosedOperator_isSelfAdjoint m β hβ)
      simpa only [he] using h
    exact (textbookBrownianHaarPotential_closed_graph_iff m U hU hPU β hβ z.1 z.2).mpr hmass
  · exact LinearPMap.IsFormalAdjoint.le_adjoint hd
      (textbookBrownianHaarGroundStateClosedOperator_formalAdjoint m U hU hPU β hβ)

end

end MolecularDynamics