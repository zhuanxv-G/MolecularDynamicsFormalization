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
end

end MolecularDynamics
