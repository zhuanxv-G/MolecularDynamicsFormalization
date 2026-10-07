import MolecularDynamics.Chapter06.LangevinCanonicalHilbertGraph
import Mathlib.Analysis.InnerProductSpace.LinearPMap

/-! The genuine closed Hilbert realization obtained from the original test graph.
Its smooth adjoint tests have the proved original weighted transpose values.
This does not identify a stochastic semigroup generator or the full adjoint domain. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

/-- Actual additivity follows from the original real Frechet first and second derivatives. -/
theorem textbookLangevinPeriodicDifferentialOperator_smooth_add {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ : ℝ) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDifferentialOperator U γ σ (F + G) x =
      textbookLangevinPeriodicDifferentialOperator U γ σ F x +
      textbookLangevinPeriodicDifferentialOperator U γ σ G x := by
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let f := F ∘ textbookLangevinPeriodicProjection
  let g := G ∘ textbookLangevinPeriodicProjection
  have hf : ContDiff ℝ 2 f := hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)
  have hg : ContDiff ℝ 2 g := hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)
  change textbookLangevinDifferentialOperator U γ σ (fun y ↦ f y + g y) z =
    textbookLangevinDifferentialOperator U γ σ f z + textbookLangevinDifferentialOperator U γ σ g z
  have hd := fderiv_add (hf.differentiable (by norm_num) z) (hg.differentiable (by norm_num) z)
  change fderiv ℝ (fun y ↦ f y + g y) z = fderiv ℝ f z + fderiv ℝ g z at hd
  have hH := iteratedFDeriv_add_apply (x := z) hf.contDiffAt hg.contDiffAt
  change iteratedFDeriv ℝ 2 (fun y ↦ f y + g y) z =
    iteratedFDeriv ℝ 2 f z + iteratedFDeriv ℝ 2 g z at hH
  rw [textbookLangevinDifferentialOperator_C2_frechet U γ σ _ (hf.add hg),
    textbookLangevinDifferentialOperator_C2_frechet U γ σ _ hf,
    textbookLangevinDifferentialOperator_C2_frechet U γ σ _ hg, hd, hH]
  simp only [add_apply, Finset.sum_add_distrib]
  ring

/-- Actual scalar linearity follows from genuine first and second derivatives of the real lift. -/
theorem textbookLangevinPeriodicDifferentialOperator_smooth_smul {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ c : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDifferentialOperator U γ σ (c • F) x =
      c * textbookLangevinPeriodicDifferentialOperator U γ σ F x := by
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let f := F ∘ textbookLangevinPeriodicProjection
  have hf : ContDiff ℝ 2 f := hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)
  change textbookLangevinDifferentialOperator U γ σ (fun y ↦ c • f y) z =
    c * textbookLangevinDifferentialOperator U γ σ f z
  have hd := fderiv_const_smul (hf.differentiable (by norm_num) z) c
  change fderiv ℝ (fun y ↦ c • f y) z = c • fderiv ℝ f z at hd
  have hH := iteratedFDeriv_const_smul_apply' (x := z) (a := c) hf.contDiffAt
  rw [textbookLangevinDifferentialOperator_C2_frechet U γ σ _ (hf.const_smul c),
    textbookLangevinDifferentialOperator_C2_frechet U γ σ _ hf, hd, hH]
  simp only [_root_.smul_apply, smul_eq_mul, ← Finset.mul_sum]
  ring

private theorem closed_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private theorem closed_L_zero {N : ℕ} (U : (Fin N → ℝ) → ℝ) (γ σ : ℝ)
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDifferentialOperator U γ σ (fun _ ↦ 0) x = 0 := by
  have hF : ContDiff ℝ ∞ ((fun _ : textbookLangevinPeriodicPhase N ↦ (0 : ℝ)) ∘
      textbookLangevinPeriodicProjection) := contDiff_const
  change textbookLangevinPeriodicDifferentialOperator U γ σ (0 : textbookLangevinPeriodicPhase N → ℝ) x = 0
  simpa only [zero_smul, zero_mul] using
    textbookLangevinPeriodicDifferentialOperator_smooth_smul U γ σ 0 (fun _ ↦ 0) hF x

/-- The original true differential test graph is a submodule, using proved actual linearity
and genuine AE addition and scalar multiplication of the same L2 representatives. -/
def textbookLangevinCanonicalHilbertTestGraphSubmodule {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ σ : ℝ) (hβ : 0 < β) :
    Submodule ℝ (Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) where
  carrier := textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ
  zero_mem' := by
    refine ⟨fun _ ↦ 0, HasCompactSupport.zero, contDiff_const, ?_, ?_⟩
    · exact Lp.coeFn_zero ℝ 2 _
    · filter_upwards [Lp.coeFn_zero ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)] with x hx
      exact hx.trans (closed_L_zero U γ σ x).symm
  add_mem' := by
    rintro p q ⟨F, hsF, hF, hf1, hf2⟩ ⟨G, hsG, hG, hg1, hg2⟩
    have hFG : ContDiff ℝ ∞ ((F + G) ∘ textbookLangevinPeriodicProjection) := hF.add hG
    refine ⟨F + G, hsF.add hsG, hFG, ?_, ?_⟩
    · filter_upwards [Lp.coeFn_add p.1 q.1, hf1, hg1] with x hx hy hz
      simp only [Prod.fst_add, hx, Pi.add_apply, hy, hz]
    · filter_upwards [Lp.coeFn_add p.2 q.2, hf2, hg2] with x hx hy hz
      simp only [Prod.snd_add, hx, Pi.add_apply, hy, hz,
        textbookLangevinPeriodicDifferentialOperator_smooth_add U γ σ F G hF hG]
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
        textbookLangevinPeriodicDifferentialOperator U γ σ (c • F) x
      rw [hx, textbookLangevinPeriodicDifferentialOperator_smooth_smul U γ σ c F hF]
      simp only [Pi.smul_apply, smul_eq_mul, hy]

/-- The true candidate closed realization is constructed from the original graph's
topological closure; the following theorem proves the non-junk functional graph. -/
def textbookLangevinCanonicalHilbertClosedOperator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ σ : ℝ) (hβ : 0 < β) :
    Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) →ₗ.[ℝ]
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure.toLinearPMap

/-- The constructed operator's actual graph is exactly the original test graph closure,
proved functional by the genuine dense-test zero-vertical result. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_graph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β) :
    (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).graph =
      (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure := by
  apply Submodule.toLinearPMap_graph_eq
  intro p hpcl hp0
  have he : p = (0, p.2) := Prod.ext hp0 rfl
  rw [he] at hpcl
  exact textbookLangevinCanonicalHilbertTestGraph_closure_zero_vertical U hU hp β γ σ hβ hσ p.2 hpcl

/-- The actual realization is a closed partially defined linear operator in the same L2. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_isClosed {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β) :
    (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).IsClosed := by
  rw [LinearPMap.IsClosed, textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ]
  exact Submodule.isClosed_topologicalClosure _

/-- Its actual domain is dense because it contains the proved dense original test graph domain. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_dense {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β) :
    Dense ((textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain :
      Set (Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))) := by
  apply (textbookLangevinCanonicalHilbertTestGraph_domain_dense U hU hp β γ σ hβ).mono
  rintro f ⟨g, hfg⟩
  apply LinearPMap.mem_domain_of_mem_graph (y := g)
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ]
  exact subset_closure hfg

/-- Each true compact smooth test and its literal differential image belong to
the constructed closed graph, with no assumed operator-domain membership. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_smooth_graph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F (closed_F_continuous F hF) hs,
      (textbookLangevinCanonicalMeasure_differential_memLp_two U hU hp β γ σ hβ F hF hs).toLp _) ∈
      (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).graph := by
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ]
  apply subset_closure
  change _ ∈ textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ
  exact ⟨F, hs, hF, textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ F (closed_F_continuous F hF) hs,
    (textbookLangevinCanonicalMeasure_differential_memLp_two U hU hp β γ σ hβ F hF hs).coeFn_toLp⟩

private theorem closed_transpose_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain) :
    ⟪(textbookLangevinCanonicalMeasure_formalAdjoint_memLp_two U hU hp β γ hβ G hG hsG).toLp _, (f :
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))⟫_ℝ =
      ⟪textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (closed_F_continuous G hG) hsG,
        textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f⟫_ℝ := by
  have hfg := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hfg
  have he := textbookLangevinCanonicalHilbertTestGraph_closure_pairing U hU hp β γ σ hβ hσ
    f (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f) hfg G hG hsG
  simpa only [real_inner_comm] using he.symm

/-- Genuine smooth compact tests lie in the actual Hilbert adjoint domain of
the constructed closed realization, proved from real weighted transpose testing. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_smooth_mem_adjoint_domain {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (closed_F_continuous G hG) hsG ∈
      (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ)†.domain := by
  apply LinearPMap.mem_adjoint_domain_of_exists
  exact ⟨_, closed_transpose_testing U hU hp β γ σ hβ hσ G hG hsG⟩

/-- On every proved compact smooth adjoint-domain element the actual adjoint
value is exactly the original canonical-weight minus-H plus-OU expression. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_adjoint_smooth_apply {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ)†
      ⟨textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (closed_F_continuous G hG) hsG,
        textbookLangevinCanonicalHilbertClosedOperator_smooth_mem_adjoint_domain U hU hp β γ σ hβ hσ G hG hsG⟩ =
      (textbookLangevinCanonicalMeasure_formalAdjoint_memLp_two U hU hp β γ hβ G hG hsG).toLp _ := by
  apply LinearPMap.adjoint_apply_eq (textbookLangevinCanonicalHilbertClosedOperator_dense U hU hp β γ σ hβ hσ)
  exact closed_transpose_testing U hU hp β γ σ hβ hσ G hG hsG

end
end MolecularDynamics
