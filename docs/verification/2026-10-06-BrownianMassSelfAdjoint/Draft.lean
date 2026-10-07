import MolecularDynamics.Chapter06.BrownianGroundStateGraph
import MolecularDynamics.Chapter06.BrownianFourierHilbert

/-! Genuine selfadjointness of the actual full original-mass Haar Laplacian closure. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace BigOperators LinearPMap

namespace MolecularDynamics

noncomputable section

private local instance brownianMassSelfAdjointCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianMassSelfAdjointCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual potential term is exactly zero for the necessary zero-potential mass calculation. -/
theorem textbookBrownianGroundStatePotential_zero {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    textbookBrownianGroundStatePotential m (fun _ ↦ 0) β = 0 := by
  funext q
  simp [textbookBrownianGroundStatePotential, textbookConfigurationPartial]

/-- The actual transformed smooth operator equals the literal original mass Laplacian in this case. -/
theorem textbookBrownianHaarGroundStateSmoothGenerator_zero {Nc : ℕ}
    (m : Fin Nc → ℝ) (β : ℝ) :
    textbookBrownianHaarGroundStateSmoothGenerator m (fun _ ↦ 0)
      contDiff_const (by intro _ _; rfl) β = textbookHaarMassSmoothGenerator m β := by
  ext f q
  rw [textbookBrownianHaarGroundStateSmoothGenerator_apply,
    textbookHaarMassSmoothGenerator_apply, textbookBrownianGroundStatePotential_zero]
  simp

/-- The actual original-mass Haar partial operator, on the entire original smooth domain. -/
def textbookHaarMassPartialOperator {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →ₗ.[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  textbookBrownianHaarGroundStatePartialOperator m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β

/-- Its true graph closure; no selfadjoint or closed-realization premise is supplied. -/
def textbookHaarMassClosedOperator {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →ₗ.[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  textbookBrownianHaarGroundStateClosedOperator m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β

/-- Its actual partial graph consists exactly of all original smooth graph vectors. -/
theorem textbookHaarMassPartialOperator_graph_smooth {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (z : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    z ∈ (textbookHaarMassPartialOperator m β).graph ↔
      ∃ f : textbookPeriodicSmoothSpace Nc,
        (textbookPeriodicSmoothHaarEmbedding Nc f,
          textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β f)) = z := by
  rw [LinearPMap.mem_graph_iff']
  constructor
  · rintro ⟨x, hx⟩
    obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothHaarEmbeddingEquiv Nc).surjective x
    refine ⟨f, ?_⟩
    simpa only [textbookHaarMassPartialOperator,
      textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
      textbookPeriodicSmoothHaarEmbeddingEquiv_coe,
      textbookBrownianHaarGroundStateSmoothGenerator_zero] using hx
  · rintro ⟨f, hf⟩
    refine ⟨textbookPeriodicSmoothHaarEmbeddingEquiv Nc f, ?_⟩
    simpa only [textbookHaarMassPartialOperator,
      textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
      textbookPeriodicSmoothHaarEmbeddingEquiv_coe,
      textbookBrownianHaarGroundStateSmoothGenerator_zero] using hf

/-- The actual mass closure has a genuinely closed graph. -/
theorem textbookHaarMassClosedOperator_isClosed {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0) : (textbookHaarMassClosedOperator m β).IsClosed :=
  textbookBrownianHaarGroundStateClosedOperator_isClosed m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β hβ

/-- The whole actual closed mass domain is dense. -/
theorem textbookHaarMassClosedOperator_dense {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    Dense ((textbookHaarMassClosedOperator m β).domain :
      Set (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))) :=
  textbookBrownianHaarGroundStateClosedOperator_dense m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β

/-- The entire actual mass closure is formally symmetric. -/
theorem textbookHaarMassClosedOperator_formalAdjoint {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0) :
    (textbookHaarMassClosedOperator m β).IsFormalAdjoint (textbookHaarMassClosedOperator m β) :=
  textbookBrownianHaarGroundStateClosedOperator_formalAdjoint m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β hβ

private theorem partial_le_closed {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    textbookHaarMassPartialOperator m β ≤ textbookHaarMassClosedOperator m β :=
  textbookBrownianHaarGroundStatePartialOperator_le_closed m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β

private theorem partial_dense {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    Dense ((textbookHaarMassPartialOperator m β).domain :
      Set (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))) :=
  textbookBrownianHaarGroundStatePartialOperator_dense m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β

private theorem restrict_formalAdjoint {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (S : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →ₗ.[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (hS : S.IsFormalAdjoint (textbookHaarMassClosedOperator m β)) :
    S.IsFormalAdjoint (textbookHaarMassPartialOperator m β) := by
  intro u a
  let b : (textbookHaarMassClosedOperator m β).domain :=
    ⟨a, (partial_le_closed m β).1 a.prop⟩
  have hb : textbookHaarMassClosedOperator m β b = textbookHaarMassPartialOperator m β a :=
    ((partial_le_closed m β).2 (show (a : Lp ℝ 2 volume) = b from rfl)).symm
  simpa only [hb] using hS u b

private theorem formalAdjoint_coeff {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ)
    (S : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →ₗ.[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (hS : S.IsFormalAdjoint (textbookHaarMassPartialOperator m β))
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (hxy : (x, y) ∈ S.graph) :
    ∀ n : Fin Nc → ℤ,
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) n =
        (-textbookMassFourierFrequency m β n : ℂ) *
          UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n := by
  obtain ⟨u, hu, hSu⟩ := (LinearPMap.mem_graph_iff S).mp hxy
  have hp (c : ℂ) (n : Fin Nc → ℤ) :
      (star c * UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) n).re =
        -textbookMassFourierFrequency m β n *
          (star c * UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n).re := by
    let f := textbookFourierRealMode c n
    let a := textbookPeriodicSmoothHaarEmbeddingEquiv Nc f
    have ha : textbookHaarMassPartialOperator m β a =
        (-textbookMassFourierFrequency m β n) • textbookPeriodicSmoothHaarEmbedding Nc f := by
      change textbookBrownianHaarGroundStateDomainOperator m (fun _ ↦ 0)
        contDiff_const (by intro _ _; rfl) β a = _
      rw [textbookBrownianHaarGroundStateDomainOperator_apply_equiv,
        textbookBrownianHaarGroundStateSmoothGenerator_zero,
        textbookHaarMassSmoothGenerator_realMode, map_smul]
    have hh := hS.symm a u
    change ⟪textbookHaarMassPartialOperator m β a, (u : Lp ℝ 2 volume)⟫_ℝ =
      ⟪textbookPeriodicSmoothHaarEmbedding Nc f, S u⟫_ℝ at hh
    rw [ha, hu, hSu, real_inner_smul_left, textbookFourierRealMode_inner,
      textbookFourierRealMode_inner] at hh
    exact hh.symm
  intro n
  apply Complex.ext
  · have h := hp 1 n
    simpa [Complex.mul_re] using h
  · have h := hp Complex.I n
    simpa [Complex.mul_im] using h

/-- A genuine coefficient relation places the actual vector pair in the genuine graph closure. -/
theorem textbookHaarMassClosedOperator_mem_graph_of_coeff {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0)
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (h : ∀ n : Fin Nc → ℤ,
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) n =
        (-textbookMassFourierFrequency m β n : ℂ) *
          UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n) :
    (x, y) ∈ (textbookHaarMassClosedOperator m β).graph := by
  apply (textbookHaarMassClosedOperator_isClosed m β hβ).mem_of_tendsto
    (textbookHaarFourierPolynomial_graph_tendsto m β x y h)
  apply Filter.Eventually.of_forall
  intro s
  apply LinearPMap.le_graph_of_le (partial_le_closed m β)
  exact (textbookHaarMassPartialOperator_graph_smooth m β _).mpr
    ⟨textbookHaarFourierPolynomial
      (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x)) s, rfl⟩

/-- The whole actual closed graph is exactly the genuine weighted Fourier graph. -/
theorem textbookHaarMassClosedOperator_graph_iff_coeff {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0)
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    (x, y) ∈ (textbookHaarMassClosedOperator m β).graph ↔
      ∀ n : Fin Nc → ℤ,
        UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc y) n =
          (-textbookMassFourierFrequency m β n : ℂ) *
            UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n := by
  constructor
  · exact formalAdjoint_coeff m β _ (restrict_formalAdjoint m β _
      (textbookHaarMassClosedOperator_formalAdjoint m β hβ)) x y
  · exact textbookHaarMassClosedOperator_mem_graph_of_coeff m β hβ x y

/-- The true closure of the entire original mass Laplacian is selfadjoint on the actual real Haar L². -/
theorem textbookHaarMassClosedOperator_isSelfAdjoint {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0) : IsSelfAdjoint (textbookHaarMassClosedOperator m β) := by
  rw [LinearPMap.isSelfAdjoint_def]
  apply le_antisymm
  · apply LinearPMap.le_of_le_graph
    intro z hz
    exact textbookHaarMassClosedOperator_mem_graph_of_coeff m β hβ z.1 z.2
      (formalAdjoint_coeff m β _ (restrict_formalAdjoint m β _
        (LinearPMap.adjoint_isFormalAdjoint (textbookHaarMassClosedOperator_dense m β)))
        z.1 z.2 hz)
  · exact LinearPMap.IsFormalAdjoint.le_adjoint (textbookHaarMassClosedOperator_dense m β)
      (textbookHaarMassClosedOperator_formalAdjoint m β hβ)

/-- The true full smooth mass Laplacian is essentially selfadjoint: its adjoint equals its graph closure. -/
theorem textbookHaarMassPartialOperator_adjoint_eq_closed {Nc : ℕ} (m : Fin Nc → ℝ)
    (β : ℝ) (hβ : β ≠ 0) :
    (textbookHaarMassPartialOperator m β)† = textbookHaarMassClosedOperator m β := by
  apply le_antisymm
  · apply LinearPMap.le_of_le_graph
    intro z hz
    exact textbookHaarMassClosedOperator_mem_graph_of_coeff m β hβ z.1 z.2
      (formalAdjoint_coeff m β _ (LinearPMap.adjoint_isFormalAdjoint (partial_dense m β))
        z.1 z.2 hz)
  · exact LinearPMap.IsFormalAdjoint.le_adjoint (partial_dense m β)
      (restrict_formalAdjoint m β _ (textbookHaarMassClosedOperator_formalAdjoint m β hβ)).symm

end

end MolecularDynamics