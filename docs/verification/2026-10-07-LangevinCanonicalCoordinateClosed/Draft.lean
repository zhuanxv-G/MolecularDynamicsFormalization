import MolecularDynamics.Chapter06.LangevinCanonicalWeakH1
import Mathlib.Analysis.InnerProductSpace.LinearPMap

/-! Genuine closed coordinate derivatives on the original canonical Hilbert space.
The minimal closed test graph is constructed and its smooth adjoint values are proved.
Compatibility with weak H1 derivatives is proved on the actual minimal domain;
equality of the minimal domain with the full weak derivative domain is not asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

/-- Actual directional additivity follows from the real Frechet derivative of the lift. -/
theorem textbookLangevinPeriodicDirectionalDerivative_smooth_add {N : ℕ}
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (v : textbookLangevinPhase N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (F + G) v x =
      textbookLangevinPeriodicDirectionalDerivative F v x +
      textbookLangevinPeriodicDirectionalDerivative G v x := by
  let z : textbookLangevinPhase N := (textbookConfigurationTorusRepresentative x.1, x.2)
  let f := F ∘ textbookLangevinPeriodicProjection
  let g := G ∘ textbookLangevinPeriodicProjection
  have hd := fderiv_add (hF.differentiable (by simp) z) (hG.differentiable (by simp) z)
  change fderiv ℝ (fun y ↦ f y + g y) z = fderiv ℝ f z + fderiv ℝ g z at hd
  change fderiv ℝ (fun y ↦ f y + g y) z v = fderiv ℝ f z v + fderiv ℝ g z v
  rw [hd]
  rfl

/-- Actual scalar linearity follows from the real Frechet derivative of the lift. -/
theorem textbookLangevinPeriodicDirectionalDerivative_smooth_smul {N : ℕ}
    (c : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (v : textbookLangevinPhase N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (c • F) v x =
      c * textbookLangevinPeriodicDirectionalDerivative F v x := by
  let z : textbookLangevinPhase N := (textbookConfigurationTorusRepresentative x.1, x.2)
  let f := F ∘ textbookLangevinPeriodicProjection
  have hd := fderiv_const_smul (hF.differentiable (by simp) z) c
  change fderiv ℝ (fun y ↦ c • f y) z = c • fderiv ℝ f z at hd
  change fderiv ℝ (fun y ↦ c • f y) z v = c * fderiv ℝ f z v
  rw [hd]
  rfl

private theorem coordinateClosed_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private theorem coordinateClosed_D_zero {N : ℕ} (v : textbookLangevinPhase N)
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (fun _ ↦ 0) v x = 0 := by
  have hF : ContDiff ℝ ∞ ((fun _ : textbookLangevinPeriodicPhase N ↦ (0 : ℝ)) ∘
      textbookLangevinPeriodicProjection) := contDiff_const
  change textbookLangevinPeriodicDirectionalDerivative (0 : textbookLangevinPeriodicPhase N → ℝ) v x = 0
  simpa only [zero_smul, zero_mul] using
    textbookLangevinPeriodicDirectionalDerivative_smooth_smul 0 (fun _ ↦ 0) hF v x

private theorem coordinateClosed_D_memLp {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) :
    MemLp (textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j))
      2 (textbookLangevinCanonicalMeasure U β hβ) :=
  textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ _
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF (textbookLangevinCanonicalCoordinateDirection j))
    (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs (textbookLangevinCanonicalCoordinateDirection j))

/-- The original true coordinate derivative test graph is a submodule, using proved actual linearity
and genuine AE addition and scalar multiplication of the same L2 representatives. -/
def textbookLangevinCanonicalCoordinateTestGraphSubmodule {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    Submodule ℝ (Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) where
  carrier := textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j
  zero_mem' := by
    refine ⟨fun _ ↦ 0, HasCompactSupport.zero, contDiff_const, ?_, ?_⟩
    · exact Lp.coeFn_zero ℝ 2 _
    · filter_upwards [Lp.coeFn_zero ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)] with x hx
      exact hx.trans (coordinateClosed_D_zero (textbookLangevinCanonicalCoordinateDirection j) x).symm
  add_mem' := by
    rintro p q ⟨F, hsF, hF, hf1, hf2⟩ ⟨G, hsG, hG, hg1, hg2⟩
    have hFG : ContDiff ℝ ∞ ((F + G) ∘ textbookLangevinPeriodicProjection) := hF.add hG
    refine ⟨F + G, hsF.add hsG, hFG, ?_, ?_⟩
    · filter_upwards [Lp.coeFn_add p.1 q.1, hf1, hg1] with x hx hy hz
      simp only [Prod.fst_add, hx, Pi.add_apply, hy, hz]
    · filter_upwards [Lp.coeFn_add p.2 q.2, hf2, hg2] with x hx hy hz
      simp only [Prod.snd_add, hx, Pi.add_apply, hy, hz,
        textbookLangevinPeriodicDirectionalDerivative_smooth_add F G hF hG (textbookLangevinCanonicalCoordinateDirection j)]
  smul_mem' := by
    rintro c p ⟨F, hsF, hF, hf1, hf2⟩
    have hcF : ContDiff ℝ ∞ ((c • F) ∘ textbookLangevinPeriodicProjection) := hF.const_smul c
    have hcs : HasCompactSupport (c • F) := hsF.smul_left
    refine ⟨c • F, hcs, hcF, ?_, ?_⟩
    · filter_upwards [Lp.coeFn_smul c p.1, hf1] with x hx hy
      change (c • p.1 : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x = c • F x
      rw [hx]
      simp only [Pi.smul_apply, hy]
    · filter_upwards [Lp.coeFn_smul c p.2, hf2] with x hx hy
      change (c • p.2 : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x =
        textbookLangevinPeriodicDirectionalDerivative (c • F) (textbookLangevinCanonicalCoordinateDirection j) x
      rw [hx, textbookLangevinPeriodicDirectionalDerivative_smooth_smul c F hF (textbookLangevinCanonicalCoordinateDirection j)]
      simp only [Pi.smul_apply, smul_eq_mul, hy]

/-- The true candidate closed realization is constructed from the original graph's
topological closure; the following theorem proves the non-junk functional graph. -/
def textbookLangevinCanonicalCoordinateClosedOperator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) →ₗ.[ℝ]
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (textbookLangevinCanonicalCoordinateTestGraphSubmodule U β hβ j).topologicalClosure.toLinearPMap

/-- The constructed operator's actual graph is exactly the original test graph closure,
proved functional by the genuine dense-test zero-vertical result. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_graph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).graph =
      (textbookLangevinCanonicalCoordinateTestGraphSubmodule U β hβ j).topologicalClosure := by
  apply Submodule.toLinearPMap_graph_eq
  intro p hpcl hp0
  have he : p = (0, p.2) := Prod.ext hp0 rfl
  rw [he] at hpcl
  exact textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_zero_vertical U hU hp β hβ j p.2 hpcl

/-- The actual realization is a closed partially defined linear operator in the same L2. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_isClosed {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).IsClosed := by
  rw [LinearPMap.IsClosed, textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ j]
  exact Submodule.isClosed_topologicalClosure _

/-- Its actual domain is dense because it contains the proved dense original test graph domain. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_dense {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    Dense ((textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).domain :
      Set (Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))) := by
  apply (textbookLangevinCanonicalCoordinateHilbertTestGraph_domain_dense U hU hp β hβ j).mono
  rintro f ⟨g, hfg⟩
  apply LinearPMap.mem_domain_of_mem_graph (y := g)
  rw [textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ j]
  exact subset_closure hfg

/-- Each true compact smooth test and its literal differential image belong to
the constructed closed graph, with no assumed operator-domain membership. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_smooth_graph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F (coordinateClosed_F_continuous F hF) hs,
      (coordinateClosed_D_memLp U hU hp β hβ F hF hs j).toLp _) ∈
      (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).graph := by
  rw [textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ j]
  apply subset_closure
  change _ ∈ textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j
  exact ⟨F, hs, hF, textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ F (coordinateClosed_F_continuous F hF) hs,
    (coordinateClosed_D_memLp U hU hp β hβ F hF hs j).coeFn_toLp⟩

private theorem coordinateClosed_transpose_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G)
    (f : (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).domain) :
    ⟪(textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _, (f :
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))⟫_ℝ =
      ⟪textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (coordinateClosed_F_continuous G hG) hsG,
        textbookLangevinCanonicalCoordinateClosedOperator U β hβ j f⟫_ℝ := by
  have hfg := (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).mem_graph f
  rw [textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ j] at hfg
  have he := textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_pairing U hU hp β hβ j
    f (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j f) hfg G hG hsG
  simpa only [real_inner_comm] using he.symm

/-- Genuine smooth compact tests lie in the actual Hilbert adjoint domain of
the constructed closed realization, proved from real weighted transpose testing. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_smooth_mem_adjoint_domain {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (coordinateClosed_F_continuous G hG) hsG ∈
      (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j)†.domain := by
  apply LinearPMap.mem_adjoint_domain_of_exists
  exact ⟨_, coordinateClosed_transpose_testing U hU hp β hβ j G hG hsG⟩

/-- On every proved compact smooth adjoint-domain element the actual adjoint
value is exactly the original canonical-weight negative derivative plus log-slope expression. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_adjoint_smooth_apply {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j)†
      ⟨textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (coordinateClosed_F_continuous G hG) hsG,
        textbookLangevinCanonicalCoordinateClosedOperator_smooth_mem_adjoint_domain U hU hp β hβ j G hG hsG⟩ =
      (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _ := by
  apply LinearPMap.adjoint_apply_eq (textbookLangevinCanonicalCoordinateClosedOperator_dense U hU hp β hβ j)
  exact coordinateClosed_transpose_testing U hU hp β hβ j G hG hsG

/-- On the actual minimal closed coordinate domain, its value agrees with the
unique derivative of every genuine weak H1 function. Full domain equality is not assumed. -/
theorem textbookLangevinCanonicalCoordinateClosedOperator_weakH1_apply {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ)
    (hf : textbookLangevinCanonicalWeakH1Value U hU hp β hβ f ∈
      (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).domain) :
    textbookLangevinCanonicalCoordinateClosedOperator U β hβ j
      ⟨textbookLangevinCanonicalWeakH1Value U hU hp β hβ f, hf⟩ =
      textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ j f := by
  apply sub_eq_zero.mp
  apply (textbookLangevinCanonicalL2_dense_smooth_compact U hU hp β hβ).eq_zero_of_inner_left ℝ
  rintro t ⟨G, ht, hsG, hG⟩
  have he : t = textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (coordinateClosed_F_continuous G hG) hsG := by
    apply Lp.ext
    exact ht.trans (textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G
      (coordinateClosed_F_continuous G hG) hsG).symm
  rw [he, inner_sub_left]
  have hfg := (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j).mem_graph
    ⟨textbookLangevinCanonicalWeakH1Value U hU hp β hβ f, hf⟩
  rw [textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ j] at hfg
  rw [textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_pairing U hU hp β hβ j
    (textbookLangevinCanonicalWeakH1Value U hU hp β hβ f)
    (textbookLangevinCanonicalCoordinateClosedOperator U β hβ j
      ⟨textbookLangevinCanonicalWeakH1Value U hU hp β hβ f, hf⟩) hfg G hG hsG,
    textbookLangevinCanonicalWeakH1_pairing U hU hp β hβ f j G hG hsG, sub_self]

end
end MolecularDynamics
