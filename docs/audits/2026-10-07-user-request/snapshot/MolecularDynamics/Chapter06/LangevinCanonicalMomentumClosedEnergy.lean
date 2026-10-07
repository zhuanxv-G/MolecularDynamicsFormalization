import MolecularDynamics.Chapter06.LangevinCanonicalCoordinateClosed
import MolecularDynamics.Chapter06.LangevinCanonicalHilbertDissipativity
import Mathlib.Topology.Algebra.Module.ContinuousLinearMap.Extend

/-! Extend the original momentum energy identity to the actual closed Langevin
Hilbert realization, for strictly positive friction. A genuine continuous momentum
gradient on the closed graph is obtained from the proved graph norm bound.
This proves momentum derivative membership and energy on the entire actual domain,
without identifying a stochastic generator or claiming full q-derivative regularity. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

private theorem momentumClosed_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private theorem momentumClosed_D_memLp {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (i : Fin N) :
    MemLp (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)) 2
      (textbookLangevinCanonicalMeasure U β hβ) :=
  textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ _
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF _)
    (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _)

private theorem momentumClosed_test_domain {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β)
    (p : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ) (i : Fin N) :
    (p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1 ∈
      (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).domain := by
  obtain ⟨F, hs, hF, hf, hg⟩ := p.property
  apply LinearPMap.mem_domain_of_mem_graph (y := (momentumClosed_D_memLp U hU hp β hβ F hF hs i).toLp _)
  rw [textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ (Sum.inr i)]
  apply subset_closure
  change _ ∈ textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ (Sum.inr i)
  exact ⟨F, hs, hF, hf, (momentumClosed_D_memLp U hU hp β hβ F hF hs i).coeFn_toLp⟩

/-- Genuine momentum derivative classes with the original finite Hilbert square-sum norm. -/
abbrev textbookLangevinCanonicalMomentumJet {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β) : Type :=
  PiLp 2 (fun _ : Fin N ↦ Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))

/-- The true momentum derivative map on the original differential test graph. -/
def textbookLangevinCanonicalTestMomentumDerivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ →ₗ[ℝ]
      textbookLangevinCanonicalMomentumJet U β hβ where
  toFun p := WithLp.toLp 2 (fun i ↦ textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)
    ⟨(p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
      momentumClosed_test_domain U hU hp β γ σ hβ p i⟩)
  map_add' p q := by
    apply PiLp.ext
    intro i
    simp only [PiLp.add_apply]
    change textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)
      ⟨((p + q : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ) :
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1, _⟩ = _
    exact (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).map_add
      ⟨(p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1, momentumClosed_test_domain U hU hp β γ σ hβ p i⟩
      ⟨(q : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1, momentumClosed_test_domain U hU hp β γ σ hβ q i⟩
  map_smul' c p := by
    apply PiLp.ext
    intro i
    change textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)
      ⟨((c • p : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ) :
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1, _⟩ = _
    exact (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).map_smul c
      ⟨(p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1, momentumClosed_test_domain U hU hp β γ σ hβ p i⟩

private theorem momentumClosed_test_derivative_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β)
    (p : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hs : HasCompactSupport F) (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hf : (p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1 =ᵐ[textbookLangevinCanonicalMeasure U β hβ] F)
    (i : Fin N) :
    textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p i
      =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
        textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) := by
  let D := textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)
  have ht : ((p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
      (momentumClosed_D_memLp U hU hp β hβ F hF hs i).toLp _) ∈ D.graph := by
    rw [textbookLangevinCanonicalCoordinateClosedOperator_graph U hU hp β hβ (Sum.inr i)]
    apply subset_closure
    exact ⟨F, hs, hF, hf, (momentumClosed_D_memLp U hU hp β hβ F hF hs i).coeFn_toLp⟩
  have he := D.mem_graph_snd_inj
    (D.mem_graph ⟨_, momentumClosed_test_domain U hU hp β γ σ hβ p i⟩) ht rfl
  change D ⟨_, momentumClosed_test_domain U hU hp β γ σ hβ p i⟩ =ᵐ[_] _
  rw [he]
  exact (momentumClosed_D_memLp U hU hp β hβ F hF hs i).coeFn_toLp

/-- The original energy is exactly the true momentum derivative Hilbert norm on every test graph pair. -/
theorem textbookLangevinCanonicalTestMomentumDerivative_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (p : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ) :
    ⟪(p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
      (p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).2⟫_ℝ =
      -(γ * β⁻¹) * ‖textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p‖ ^ 2 := by
  obtain ⟨F, hs, hF, hf, hg⟩ := p.property
  have hn : ‖textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p‖ ^ 2 =
      ∫ x, textbookLangevinPeriodicMomentumGradientSquare F x ∂textbookLangevinCanonicalMeasure U β hβ := by
    rw [PiLp.norm_sq_eq_of_L2]
    have hsq (i : Fin N) :
        ‖textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p i‖ ^ 2 =
        ∫ x, (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) ^ 2
          ∂textbookLangevinCanonicalMeasure U β hβ := by
      rw [← real_inner_self_eq_norm_sq, L2.inner_def]
      apply integral_congr_ae
      filter_upwards [momentumClosed_test_derivative_ae U hU hp β γ σ hβ p F hs hF hf i] with x hx
      rw [hx, Real.inner_apply, pow_two]
    simp_rw [hsq]
    rw [← integral_finsetSum]
    · rfl
    · intro i _
      have hi := momentumClosed_D_memLp U hU hp β hβ F hF hs i
      have hm : Integrable (fun x ↦
          textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x *
          textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)
          (textbookLangevinCanonicalMeasure U β hβ) := hi.integrable_mul hi
      simpa only [pow_two] using hm
  rw [hn, L2.inner_def]
  calc
    _ = ∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ σ F x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
      apply integral_congr_ae
      filter_upwards [hf, hg] with x hx hy
      rw [hx, hy, Real.inner_apply]
    _ = _ := textbookLangevinCanonicalMeasure_energy U hU hp β γ σ hβ hσ F hF hs

/-- Positive friction gives a genuine graph norm bound for the actual momentum derivative. -/
theorem textbookLangevinCanonicalTestMomentumDerivative_graph_norm_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (p : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ) :
    ‖textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p‖ ≤
      Real.sqrt (β / γ) * ‖p‖ := by
  have he := textbookLangevinCanonicalTestMomentumDerivative_energy U hU hp β γ σ hβ hσ p
  let z := (p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
    Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
  have hn : ‖textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p‖ ^ 2 =
      -(β / γ) * ⟪z.1, z.2⟫_ℝ := by
    dsimp [z]
    field_simp [ne_of_gt hβ, ne_of_gt hγ] at he ⊢
    nlinarith [he]
  have hC : 0 ≤ β / γ := le_of_lt (div_pos hβ hγ)
  have hi : -⟪z.1, z.2⟫_ℝ ≤ ‖z‖ ^ 2 := by
    have hb := norm_inner_le_norm (𝕜 := ℝ) z.1 z.2
    have h1 := norm_fst_le z
    have h2 := norm_snd_le z
    have hm := mul_le_mul h1 h2 (norm_nonneg z.2) (norm_nonneg z)
    have ha := neg_le_abs ⟪z.1, z.2⟫_ℝ
    simpa only [Real.norm_eq_abs, pow_two] using ha.trans (hb.trans hm)
  have hb : ‖textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p‖ ^ 2 ≤
      (Real.sqrt (β / γ) * ‖p‖) ^ 2 := by
    rw [hn, mul_pow, Real.sq_sqrt hC]
    change -(β / γ) * ⟪z.1, z.2⟫_ℝ ≤ (β / γ) * ‖z‖ ^ 2
    nlinarith [mul_le_mul_of_nonneg_left hi hC]
  exact (sq_le_sq₀ (norm_nonneg _) (mul_nonneg (Real.sqrt_nonneg _) (norm_nonneg _))).mp hb

private def momentumClosed_inclusion {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ σ : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ →L[ℝ]
      (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure :=
  ⟨Submodule.inclusion (Submodule.le_topologicalClosure _), by fun_prop⟩

private theorem momentumClosed_inclusion_dense {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ σ : ℝ) (hβ : 0 < β) :
    DenseRange (momentumClosed_inclusion U β γ σ hβ) :=
  (denseRange_inclusion_iff (Submodule.le_topologicalClosure _)).mpr subset_rfl

private theorem momentumClosed_inclusion_uniform {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ σ : ℝ) (hβ : 0 < β) :
    IsUniformInducing (momentumClosed_inclusion U β γ σ hβ) :=
  (isUniformEmbedding_set_inclusion (Submodule.le_topologicalClosure _)).isUniformInducing

/-- The actual graph norm bound constructs a true continuous momentum derivative
on the entire original differential graph closure, by extension along a proved dense embedding. -/
def textbookLangevinCanonicalClosedGraphMomentumDerivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β) :
    (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure →L[ℝ]
      textbookLangevinCanonicalMomentumJet U β hβ :=
  ((textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ).mkContinuous
    (Real.sqrt (β / γ)) (textbookLangevinCanonicalTestMomentumDerivative_graph_norm_bound U hU hp β γ σ hβ hγ hσ)).extend
      (momentumClosed_inclusion U β γ σ hβ)

/-- The true continuous extension agrees with the actual original test momentum derivatives. -/
theorem textbookLangevinCanonicalClosedGraphMomentumDerivative_test {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (p : textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ) :
    textbookLangevinCanonicalClosedGraphMomentumDerivative U hU hp β γ σ hβ hγ hσ
      (momentumClosed_inclusion U β γ σ hβ p) =
      textbookLangevinCanonicalTestMomentumDerivative U hU hp β γ σ hβ p :=
  ContinuousLinearMap.extend_eq _ (momentumClosed_inclusion_dense U β γ σ hβ)
    (momentumClosed_inclusion_uniform U β γ σ hβ) p

/-- Every actual closed differential graph pair has genuine minimal closed momentum derivatives. -/
theorem textbookLangevinCanonicalClosedGraphMomentumDerivative_coordinate_graph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (p : (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure)
    (i : Fin N) :
    ((p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
      textbookLangevinCanonicalClosedGraphMomentumDerivative U hU hp β γ σ hβ hγ hσ p i) ∈
      (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).graph := by
  apply (momentumClosed_inclusion_dense U β γ σ hβ).induction_on
    (p := fun z : (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure ↦
      ((z : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
        textbookLangevinCanonicalClosedGraphMomentumDerivative U hU hp β γ σ hβ hγ hσ z i) ∈
        (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).graph) p
  · exact (textbookLangevinCanonicalCoordinateClosedOperator_isClosed U hU hp β hβ
      (Sum.inr i)).preimage (by fun_prop)
  · intro q
    rw [textbookLangevinCanonicalClosedGraphMomentumDerivative_test]
    exact (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).mem_graph
      ⟨_, momentumClosed_test_domain U hU hp β γ σ hβ q i⟩

/-- The original energy identity persists on the entire actual graph closure
by the proved continuous momentum extension, with no assumed H1 domain regularity. -/
theorem textbookLangevinCanonicalClosedGraphMomentumDerivative_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (p : (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure) :
    ⟪(p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
      (p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).2⟫_ℝ =
      -(γ * β⁻¹) *
        ‖textbookLangevinCanonicalClosedGraphMomentumDerivative U hU hp β γ σ hβ hγ hσ p‖ ^ 2 := by
  apply (momentumClosed_inclusion_dense U β γ σ hβ).induction_on
    (p := fun z : (textbookLangevinCanonicalHilbertTestGraphSubmodule U β γ σ hβ).topologicalClosure ↦
      ⟪(z : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
        Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).1,
        (z : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
          Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).2⟫_ℝ =
        -(γ * β⁻¹) * ‖textbookLangevinCanonicalClosedGraphMomentumDerivative U hU hp β γ σ hβ hγ hσ z‖ ^ 2) p
  · exact isClosed_eq (by fun_prop) (by fun_prop)
  · intro q
    rw [textbookLangevinCanonicalClosedGraphMomentumDerivative_test]
    exact textbookLangevinCanonicalTestMomentumDerivative_energy U hU hp β γ σ hβ hσ q

/-- The genuine closed Langevin domain is contained in every actual minimal
closed momentum derivative domain. No full q-derivative H1 inclusion is asserted. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_momentum_domain {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (i : Fin N) :
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) ∈
      (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).domain := by
  have hf := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hf
  exact LinearPMap.mem_domain_of_mem_graph
    (textbookLangevinCanonicalClosedGraphMomentumDerivative_coordinate_graph U hU hp β γ σ hβ hγ hσ
      ⟨_, hf⟩ i)

/-- The actual momentum derivative vector of every genuine closed Langevin domain element. -/
def textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain) :
    textbookLangevinCanonicalMomentumJet U β hβ :=
  textbookLangevinCanonicalClosedGraphMomentumDerivative U hU hp β γ σ hβ hγ hσ
    ⟨((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
      textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f), by
      have hf := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
      rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hf
      exact hf⟩

/-- The textbook energy holds on the entire actual closed Langevin Hilbert domain. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_energy {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain) :
    ⟪(f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
      textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f⟫_ℝ =
      -(γ * β⁻¹) *
        ‖textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative U hU hp β γ σ hβ hγ hσ f‖ ^ 2 :=
by
  unfold textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative
  exact textbookLangevinCanonicalClosedGraphMomentumDerivative_energy U hU hp β γ σ hβ hγ hσ
    ⟨((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
      textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f), by
      have h := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
      rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at h
      exact h⟩

/-- On genuine weak H1 functions in the actual closed Langevin domain, the proved
closed-domain momentum vector agrees with their actual canonical weak derivatives. -/
theorem textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative_weakH1 {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ)
    (hf : textbookLangevinCanonicalWeakH1Value U hU hp β hβ f ∈
      (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain) (i : Fin N) :
    textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative U hU hp β γ σ hβ hγ hσ
      ⟨textbookLangevinCanonicalWeakH1Value U hU hp β hβ f, hf⟩ i =
      textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f := by
  let d : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain :=
    ⟨textbookLangevinCanonicalWeakH1Value U hU hp β hβ f, hf⟩
  let hm := textbookLangevinCanonicalHilbertClosedOperator_momentum_domain U hU hp β γ σ hβ hγ hσ d i
  have hgraph := textbookLangevinCanonicalClosedGraphMomentumDerivative_coordinate_graph U hU hp β γ σ hβ hγ hσ
    ⟨((d : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
      textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ d), by
      have h := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph d
      rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at h
      exact h⟩ i
  have he := (textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).mem_graph_snd_inj
    hgraph ((textbookLangevinCanonicalCoordinateClosedOperator U β hβ (Sum.inr i)).mem_graph ⟨_, hm⟩) rfl
  exact he.trans (textbookLangevinCanonicalCoordinateClosedOperator_weakH1_apply U hU hp β hβ (Sum.inr i) f hm)

/-- An actual closed Langevin kernel element has zero genuine momentum derivative vector,
derived from the full closed-domain energy and strictly positive friction. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_momentum_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative U hU hp β γ σ hβ hγ hσ f = 0 := by
  have he := textbookLangevinCanonicalHilbertClosedOperator_energy U hU hp β γ σ hβ hγ hσ f
  rw [hf, inner_zero_right] at he
  have hc : 0 < γ * β⁻¹ := mul_pos hγ (inv_pos.mpr hβ)
  apply norm_eq_zero.mp
  have hn := (mul_eq_zero.mp he.symm).resolve_left (neg_ne_zero.mpr (ne_of_gt hc))
  nlinarith [hn, norm_nonneg (textbookLangevinCanonicalHilbertClosedOperatorMomentumDerivative U hU hp β γ σ hβ hγ hσ f)]

end
end MolecularDynamics
