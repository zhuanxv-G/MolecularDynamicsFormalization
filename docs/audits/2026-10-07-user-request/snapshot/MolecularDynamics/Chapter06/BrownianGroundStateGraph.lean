import MolecularDynamics.Chapter06.BrownianGroundStateCore

/-! The genuine Haar smooth partial operator, for actual whole-graph Gibbs conjugation. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The full original smooth-to-Haar Hilbert embedding is genuinely injective. -/
theorem textbookPeriodicSmoothHaarEmbedding_injective (Nc : ℕ) :
    Function.Injective (textbookPeriodicSmoothHaarEmbedding Nc) := by
  let U : (Fin Nc → ℝ) → ℝ := fun _ ↦ 0
  have hU : ContDiff ℝ ∞ U := contDiff_const
  have hPU : textbookUnitPeriodicPotential U := by intro _ _; rfl
  let E := textbookGibbsGroundStateSmoothEquiv U hU hPU 1
  let I := textbookGibbsHaarGroundStateIsometry U hU hPU 1
  intro f g h
  apply E.symm.injective
  apply textbookPeriodicSmoothEmbedding_injective U hU hPU 1
  apply I.injective
  change textbookGibbsHaarGroundStateIsometry U hU hPU 1
      (textbookPeriodicSmoothEmbedding U hU hPU 1 (E.symm f)) =
    textbookGibbsHaarGroundStateIsometry U hU hPU 1
      (textbookPeriodicSmoothEmbedding U hU hPU 1 (E.symm g))
  rw [textbookGibbsHaarGroundStateIsometry_apply_smooth,
    textbookGibbsHaarGroundStateIsometry_apply_smooth]
  change textbookPeriodicSmoothHaarEmbedding Nc (E (E.symm f)) =
    textbookPeriodicSmoothHaarEmbedding Nc (E (E.symm g))
  rw [E.apply_symm_apply, E.apply_symm_apply]
  exact h

/-- The actual full Haar smooth Hilbert domain, rather than a finite Fourier image. -/
def textbookBrownianHaarSmoothDomain (Nc : ℕ) :
    Submodule ℝ (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :=
  (textbookPeriodicSmoothHaarEmbedding Nc).range

/-- The true unique full smooth lift of the actual Haar smooth domain. -/
def textbookPeriodicSmoothHaarEmbeddingEquiv (Nc : ℕ) :
    textbookPeriodicSmoothSpace Nc ≃ₗ[ℝ] textbookBrownianHaarSmoothDomain Nc :=
  LinearEquiv.ofInjective (textbookPeriodicSmoothHaarEmbedding Nc)
    (textbookPeriodicSmoothHaarEmbedding_injective Nc)

/-- The actual domain equivalence has the same original Haar Hilbert vector. -/
theorem textbookPeriodicSmoothHaarEmbeddingEquiv_coe (Nc : ℕ) (f : textbookPeriodicSmoothSpace Nc) :
    (textbookPeriodicSmoothHaarEmbeddingEquiv Nc f :
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) =
        textbookPeriodicSmoothHaarEmbedding Nc f := rfl

/-- The true Haar domain operator evaluates the original literal mass Laplace plus derived potential. -/
def textbookBrownianHaarGroundStateDomainOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookBrownianHaarSmoothDomain Nc →ₗ[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  (textbookPeriodicSmoothHaarEmbedding Nc).comp
    ((textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β).comp
      (textbookPeriodicSmoothHaarEmbeddingEquiv Nc).symm.toLinearMap)

/-- On every genuine smooth vector the actual Haar domain operator has exactly its original core image. -/
theorem textbookBrownianHaarGroundStateDomainOperator_apply_equiv {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookBrownianHaarGroundStateDomainOperator m U hU hPU β (textbookPeriodicSmoothHaarEmbeddingEquiv Nc f) =
      textbookPeriodicSmoothHaarEmbedding Nc
        (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β f) := by
  change textbookPeriodicSmoothHaarEmbedding Nc
    (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β
      ((textbookPeriodicSmoothHaarEmbeddingEquiv Nc).symm
        (textbookPeriodicSmoothHaarEmbeddingEquiv Nc f))) = _
  rw [LinearEquiv.symm_apply_apply]

/-- The genuine Haar smooth partial operator, constructed with its actual full domain and unique lift. -/
def textbookBrownianHaarGroundStatePartialOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →ₗ.[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) where
  domain := textbookBrownianHaarSmoothDomain Nc
  toFun := textbookBrownianHaarGroundStateDomainOperator m U hU hPU β

/-- The actual product Hilbert coordinate change for true operator graphs. -/
def textbookGibbsHaarGroundStateGraphEquiv {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) ≃L[ℝ]
    (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :=
  (textbookGibbsHaarGroundStateIsometry U hU hPU β).toContinuousLinearEquiv.prodCongr
    (textbookGibbsHaarGroundStateIsometry U hU hPU β).toContinuousLinearEquiv

/-- The actual product Hilbert coordinate change commutes with the true original graph closure. -/
theorem textbookGibbsHaarGroundStateGraphEquiv_closure {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).graph.topologicalClosure.map
      (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toLinearMap =
    ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph.map
      (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toLinearMap).topologicalClosure := by
  apply SetLike.ext'
  rw [Submodule.map_coe, Submodule.topologicalClosure_coe,
    Submodule.topologicalClosure_coe, Submodule.map_coe]
  exact (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toHomeomorph.image_closure
    (textbookBrownianGibbsPartialOperator m U hU hPU β).graph
private theorem gibbsGraph_smooth_iff {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) ×
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    z ∈ (textbookBrownianGibbsPartialOperator m U hU hPU β).graph ↔
      ∃ f : textbookPeriodicSmoothSpace Nc,
        (textbookPeriodicSmoothEmbedding U hU hPU β f,
          textbookBrownianGibbsL2Image m U hU hPU β f f.prop.1 f.prop.2) = z := by
  rw [LinearPMap.mem_graph_iff']
  constructor
  · rintro ⟨x, hx⟩
    obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).surjective x
    refine ⟨f, ?_⟩
    simpa only [textbookBrownianGibbsPartialOperator_apply,
      textbookBrownianGibbsDomainOperator_apply_equiv,
      textbookPeriodicSmoothEmbeddingEquiv_coe] using hx
  · rintro ⟨f, hf⟩
    refine ⟨textbookPeriodicSmoothEmbeddingEquiv U hU hPU β f, ?_⟩
    simpa only [textbookBrownianGibbsPartialOperator_apply,
      textbookBrownianGibbsDomainOperator_apply_equiv,
      textbookPeriodicSmoothEmbeddingEquiv_coe] using hf

private theorem haarGraph_smooth_iff {Nc : ℕ} (m : Fin Nc → ℝ)
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

private theorem isometry_gibbsImage {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (f : textbookPeriodicSmoothSpace Nc) :
    textbookGibbsHaarGroundStateIsometry U hU hPU β
      (textbookBrownianGibbsL2Image m U hU hPU β f f.prop.1 f.prop.2) =
      textbookPeriodicSmoothHaarEmbedding Nc
        (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β
          (textbookGibbsGroundStateSmoothEquiv U hU hPU β f)) := by
  have h := textbookBrownianGibbsL2Image_groundState_core m U hU hPU β hβ
    (textbookGibbsGroundStateSmoothEquiv U hU hPU β f)
  simp only [LinearEquiv.symm_apply_apply] at h
  exact h

/-- The actual two smooth partial operator graphs are related by the genuine entire Hilbert product equivalence. -/
theorem textbookGibbsHaarGroundState_partial_graph {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianGibbsPartialOperator m U hU hPU β).graph.map
      (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toLinearMap =
      (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).graph := by
  ext z
  rw [Submodule.mem_map]
  constructor
  · rintro ⟨p, hp, hpz⟩
    rcases (gibbsGraph_smooth_iff m U hU hPU β p).mp hp with ⟨f, rfl⟩
    apply (haarGraph_smooth_iff m U hU hPU β z).mpr
    refine ⟨textbookGibbsGroundStateSmoothEquiv U hU hPU β f, ?_⟩
    change (textbookGibbsHaarGroundStateIsometry U hU hPU β
        (textbookPeriodicSmoothEmbedding U hU hPU β f),
      textbookGibbsHaarGroundStateIsometry U hU hPU β
        (textbookBrownianGibbsL2Image m U hU hPU β f f.prop.1 f.prop.2)) = z at hpz
    rw [textbookGibbsHaarGroundStateIsometry_apply_smooth,
      isometry_gibbsImage m U hU hPU β hβ f] at hpz
    exact hpz
  · intro hz
    rcases (haarGraph_smooth_iff m U hU hPU β z).mp hz with ⟨f, rfl⟩
    let g := (textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm f
    refine ⟨(textbookPeriodicSmoothEmbedding U hU hPU β g,
      textbookBrownianGibbsL2Image m U hU hPU β g g.prop.1 g.prop.2),
      (gibbsGraph_smooth_iff m U hU hPU β _).mpr ⟨g, rfl⟩, ?_⟩
    change (textbookGibbsHaarGroundStateIsometry U hU hPU β
        (textbookPeriodicSmoothEmbedding U hU hPU β g),
      textbookGibbsHaarGroundStateIsometry U hU hPU β
        (textbookBrownianGibbsL2Image m U hU hPU β g g.prop.1 g.prop.2)) = _
    dsimp only [g]
    rw [textbookGibbsHaarGroundStateIsometry_apply_smooth, LinearEquiv.apply_symm_apply,
      textbookBrownianGibbsL2Image_groundState_core m U hU hPU β hβ f]

/-- The actual full Haar smooth Hilbert domain is dense, using the genuine full smooth torus density. -/
theorem textbookBrownianHaarSmoothDomain_dense (Nc : ℕ) :
    Dense (textbookBrownianHaarSmoothDomain Nc :
      Set (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))) := by
  apply (textbookHaarContinuousToLp_denseRange Nc).dense_of_mapsTo
    (textbookHaarContinuousToLp Nc).continuous (textbookSmoothTorusReal_dense Nc)
  intro f hf
  change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ f (textbookConfigurationTorusProjection q)) at hf
  change ∃ g, textbookPeriodicSmoothHaarEmbedding Nc g = textbookHaarContinuousToLp Nc f
  refine ⟨textbookSmoothTorusRealLift f hf, ?_⟩
  change textbookHaarContinuousToLp Nc
    (textbookPeriodicSmoothContinuous (textbookSmoothTorusRealLift f hf)) = _
  congr 1
  ext Q
  exact congrFun (textbookSmoothTorusRealLift_observable f hf) Q
private theorem haarEmbedding_isometry_inverse {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookGibbsHaarGroundStateIsometry U hU hPU β
      (textbookPeriodicSmoothEmbedding U hU hPU β
        ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm f)) =
      textbookPeriodicSmoothHaarEmbedding Nc f := by
  rw [textbookGibbsHaarGroundStateIsometry_apply_smooth, LinearEquiv.apply_symm_apply]

/-- The genuine Haar smooth partial operator is densely defined on its actual full domain. -/
theorem textbookBrownianHaarGroundStatePartialOperator_dense {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Dense ((textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).domain :
      Set (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))) :=
  textbookBrownianHaarSmoothDomain_dense Nc

/-- Formal adjointness of the actual Haar partial operator is derived from the same original Gibbs operator. -/
theorem textbookBrownianHaarGroundStatePartialOperator_formalAdjoint {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).IsFormalAdjoint
      (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β) := by
  intro x y
  obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothHaarEmbeddingEquiv Nc).surjective x
  obtain ⟨g, rfl⟩ := (textbookPeriodicSmoothHaarEmbeddingEquiv Nc).surjective y
  change ⟪textbookBrownianHaarGroundStateDomainOperator m U hU hPU β
      (textbookPeriodicSmoothHaarEmbeddingEquiv Nc f), textbookPeriodicSmoothHaarEmbedding Nc g⟫_ℝ =
    ⟪textbookPeriodicSmoothHaarEmbedding Nc f,
      textbookBrownianHaarGroundStateDomainOperator m U hU hPU β
        (textbookPeriodicSmoothHaarEmbeddingEquiv Nc g)⟫_ℝ
  rw [textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
    textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
    ← textbookBrownianGibbsL2Image_groundState_core m U hU hPU β hβ f,
    ← textbookBrownianGibbsL2Image_groundState_core m U hU hPU β hβ g,
    ← haarEmbedding_isometry_inverse U hU hPU β f,
    ← haarEmbedding_isometry_inverse U hU hPU β g,
    textbookGibbsHaarGroundStateIsometry_inner,
    textbookGibbsHaarGroundStateIsometry_inner]
  exact (textbookBrownianGibbsL2Image_symmetric m U hU hPU β hβ
    ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm f)
    ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm g)
    ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm f).prop.1
    ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm g).prop.1
    ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm f).prop.2
    ((textbookGibbsGroundStateSmoothEquiv U hU hPU β).symm g).prop.2).symm

/-- The actual Haar operator is closable, with its genuine closed adjoint extension. -/
theorem textbookBrownianHaarGroundStatePartialOperator_isClosable {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).IsClosable := by
  have hd := textbookBrownianHaarGroundStatePartialOperator_dense m U hU hPU β
  have hf := textbookBrownianHaarGroundStatePartialOperator_formalAdjoint m U hU hPU β hβ
  exact (LinearPMap.adjoint_isClosed hd).isClosable.leIsClosable
    (LinearPMap.IsFormalAdjoint.le_adjoint hd hf)

/-- The genuine graph closure of the actual full Haar mass-Laplace-plus-potential operator. -/
def textbookBrownianHaarGroundStateClosedOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →ₗ.[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).closure

/-- The actual Haar closure really has a closed graph; no closed-realization premise is supplied. -/
theorem textbookBrownianHaarGroundStateClosedOperator_isClosed {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).IsClosed :=
  (textbookBrownianHaarGroundStatePartialOperator_isClosable m U hU hPU β hβ).closure_isClosed

/-- The real closure graph is exactly the closure of the actual original Haar partial graph. -/
theorem textbookBrownianHaarGroundStateClosedOperator_graph {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianHaarGroundStatePartialOperator m U hU hPU β).graph.topologicalClosure =
      (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph :=
  (textbookBrownianHaarGroundStatePartialOperator_isClosable m U hU hPU β hβ).graph_closure_eq_closure_graph

/-- The entire original Gibbs closed graph is genuinely conjugate to the actual Haar closed graph. -/
theorem textbookGibbsHaarGroundState_closed_graph {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.map
      (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toLinearMap =
      (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).graph := by
  rw [← textbookBrownianGibbsClosedOperator_graph m U hU hPU β hβ,
    textbookGibbsHaarGroundStateGraphEquiv_closure,
    textbookGibbsHaarGroundState_partial_graph m U hU hPU β hβ,
    textbookBrownianHaarGroundStateClosedOperator_graph m U hU hPU β hβ]

/-- The actual Haar graph closure retains all genuine original smooth values. -/
theorem textbookBrownianHaarGroundStatePartialOperator_le_closed {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookBrownianHaarGroundStatePartialOperator m U hU hPU β ≤
      textbookBrownianHaarGroundStateClosedOperator m U hU hPU β :=
  LinearPMap.le_closure _

/-- The entire original smooth Haar domain is an actual core of the constructed Haar graph closure. -/
theorem textbookBrownianHaarGroundStateClosedOperator_hasCore {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).HasCore
      (textbookBrownianHaarSmoothDomain Nc) :=
  LinearPMap.closureHasCore _

/-- The true Haar closure also has dense domain, by the actual full smooth inclusion. -/
theorem textbookBrownianHaarGroundStateClosedOperator_dense {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Dense ((textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).domain :
      Set (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))) :=
  (textbookBrownianHaarGroundStatePartialOperator_dense m U hU hPU β).mono
    (textbookBrownianHaarGroundStatePartialOperator_le_closed m U hU hPU β).1

private theorem closedGraph_preimage {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (x : (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).domain) :
    ∃ a : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain,
      textbookGibbsHaarGroundStateIsometry U hU hPU β
        (a : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) =
        (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) ∧
      textbookGibbsHaarGroundStateIsometry U hU hPU β
        (textbookBrownianGibbsClosedOperator m U hU hPU β a) =
        textbookBrownianHaarGroundStateClosedOperator m U hU hPU β x := by
  have hx : ((x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))),
      textbookBrownianHaarGroundStateClosedOperator m U hU hPU β x) ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.map
        (textbookGibbsHaarGroundStateGraphEquiv U hU hPU β).toLinearMap := by
    rw [textbookGibbsHaarGroundState_closed_graph m U hU hPU β hβ]
    exact LinearPMap.mem_graph _ x
  rcases Submodule.mem_map.mp hx with ⟨p, hp, hpx⟩
  rcases (LinearPMap.mem_graph_iff' _).mp hp with ⟨a, rfl⟩
  change (textbookGibbsHaarGroundStateIsometry U hU hPU β
      (a : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
    textbookGibbsHaarGroundStateIsometry U hU hPU β
      (textbookBrownianGibbsClosedOperator m U hU hPU β a)) =
      ((x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))),
        textbookBrownianHaarGroundStateClosedOperator m U hU hPU β x) at hpx
  exact ⟨a, congrArg Prod.fst hpx, congrArg Prod.snd hpx⟩

/-- Actual formal symmetry holds throughout the genuine entire Haar closed domain. -/
theorem textbookBrownianHaarGroundStateClosedOperator_formalAdjoint {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0) :
    (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).IsFormalAdjoint
      (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β) := by
  intro x y
  obtain ⟨a, ha, hTa⟩ := closedGraph_preimage m U hU hPU β hβ x
  obtain ⟨b, hb, hTb⟩ := closedGraph_preimage m U hU hPU β hβ y
  rw [← hTa, ← hb, ← ha, ← hTb,
    textbookGibbsHaarGroundStateIsometry_inner,
    textbookGibbsHaarGroundStateIsometry_inner]
  exact textbookBrownianGibbsClosedOperator_formalAdjoint m U hU hPU β hβ a b

/-- Actual full closed-domain nonpositivity is transported from the same original positive-mass Gibbs model. -/
theorem textbookBrownianHaarGroundStateClosedOperator_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : (textbookBrownianHaarGroundStateClosedOperator m U hU hPU β).domain) :
    ⟪(x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))),
      textbookBrownianHaarGroundStateClosedOperator m U hU hPU β x⟫_ℝ ≤ 0 := by
  obtain ⟨a, ha, hTa⟩ := closedGraph_preimage m U hU hPU β hβ.ne' x
  rw [← ha, ← hTa, textbookGibbsHaarGroundStateIsometry_inner]
  exact textbookBrownianGibbsClosedOperator_nonpos m U hU hPU β hm hβ a
end

end MolecularDynamics
