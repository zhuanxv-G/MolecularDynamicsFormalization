import MolecularDynamics.Chapter06.LangevinCanonicalSmoothDensity
import Mathlib.Analysis.InnerProductSpace.Continuous

/-! Same-measure Hilbert graph closure of the original differential expression.
The test transpose identity is derived from actual canonical integration by parts.
No identification with a semigroup generator or full adjoint domain is asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace
namespace MolecularDynamics
noncomputable section

/-- Continuous compact actual phase functions belong to the original canonical L2. -/
theorem textbookLangevinCanonicalMeasure_compact_memLp_two {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : Continuous F) (hs : HasCompactSupport F) :
    MemLp F 2 (textbookLangevinCanonicalMeasure U β hβ) := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  exact hF.memLp_of_hasCompactSupport hs

/-- Embed the genuine actual compact observable in the same canonical Hilbert space. -/
def textbookLangevinCanonicalL2CompactObservable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : Continuous F) (hs : HasCompactSupport F) :
    Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ F hF hs).toLp F

/-- The actual Hilbert class is represented by the original function almost everywhere. -/
theorem textbookLangevinCanonicalL2CompactObservable_ae_eq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : Continuous F) (hs : HasCompactSupport F) :
    (textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F hF hs :
      textbookLangevinPeriodicPhase N → ℝ) =ᵐ[textbookLangevinCanonicalMeasure U β hβ] F :=
  MemLp.coeFn_toLp _

/-- Actual canonical Hilbert pairing equals the true original weighted integral. -/
theorem textbookLangevinCanonicalL2CompactObservable_inner {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : Continuous F) (hG : Continuous G) (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    ⟪textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F hF hsF,
      textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G hG hsG⟫_ℝ =
      ∫ x, F x * G x ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [L2.inner_def]
  apply integral_congr_ae
  filter_upwards [textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ F hF hsF,
    textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G hG hsG] with x hx hy
  rw [hx, hy, Real.inner_apply]

private theorem hilbert_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private theorem hilbert_H_eq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) :
    textbookLangevinPeriodicHamiltonianTransportExpression U F =
      textbookLangevinPeriodicDifferentialOperator U 0 0 F := by
  funext x
  rw [textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp 1 0 0
    (by norm_num) (by simp) F hF]
  simp [textbookLangevinPeriodicHamiltonianTransportExpression]

private theorem hilbert_O_continuous {N : ℕ} (β γ : ℝ)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) :
    Continuous (textbookLangevinPeriodicMomentumOUExpression β γ F) := by
  apply Continuous.const_mul
  apply continuous_finsetSum
  intro i _
  exact ((textbookLangevinPeriodicDirectionalDerivative_continuous _
    (textbookLangevinPeriodicDirectionalDerivative_lift_contDiff F hF _) _).const_mul β⁻¹).sub
    (((continuous_apply i).comp continuous_snd).mul
      (textbookLangevinPeriodicDirectionalDerivative_continuous F hF _))

private theorem hilbert_O_compact {N : ℕ} (β γ : ℝ)
    (F : textbookLangevinPeriodicPhase N → ℝ) (hs : HasCompactSupport F) :
    HasCompactSupport (textbookLangevinPeriodicMomentumOUExpression β γ F) := by
  let a (i : Fin N) : textbookLangevinPeriodicPhase N → ℝ := fun x ↦
    β⁻¹ * textbookLangevinPeriodicDirectionalDerivative
      (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)) (0, Pi.single i 1) x
  let b (i : Fin N) : textbookLangevinPeriodicPhase N → ℝ := fun x ↦
    x.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
  have hD (v : textbookLangevinPhase N) : HasCompactSupport (textbookLangevinPeriodicDirectionalDerivative F v) :=
    textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs v
  have ha (i : Fin N) : HasCompactSupport (a i) :=
    (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport _
      (hD (0, Pi.single i 1)) (0, Pi.single i 1)).mul_left
  have hb (i : Fin N) : HasCompactSupport (b i) := (hD (0, Pi.single i 1)).mul_left
  have hsum : HasCompactSupport (∑ i : Fin N, (a i - b i)) :=
    HasCompactSupport.finset_sum (fun i _ ↦ (ha i).sub (hb i))
  have he : textbookLangevinPeriodicMomentumOUExpression β γ F =
      (fun x ↦ γ * (∑ i : Fin N, (a i - b i)) x) := by
    funext x
    simp only [textbookLangevinPeriodicMomentumOUExpression, Finset.sum_apply, Pi.sub_apply, a, b]
  rw [he]
  exact hsum.mul_left

/-- The true differential image of each actual compact smooth test lies in the same L2. -/
theorem textbookLangevinCanonicalMeasure_differential_memLp_two {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    MemLp (textbookLangevinPeriodicDifferentialOperator U γ σ F) 2
      (textbookLangevinCanonicalMeasure U β hβ) :=
  textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ _
    (textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ F
      (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)))
    (textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U γ σ F
      (hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs)

/-- The proved weighted formal transpose image of every true test also lies in L2. -/
theorem textbookLangevinCanonicalMeasure_formalAdjoint_memLp_two {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    MemLp (textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ F) 2
      (textbookLangevinCanonicalMeasure U β hβ) := by
  have hFc : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection) :=
    hF.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)
  have hHc : Continuous (textbookLangevinPeriodicHamiltonianTransportExpression U F) := by
    rw [hilbert_H_eq U hU hp F hF]
    exact textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp 0 0 F hFc
  have hHs : HasCompactSupport (textbookLangevinPeriodicHamiltonianTransportExpression U F) := by
    rw [hilbert_H_eq U hU hp F hF]
    exact textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U 0 0 F hFc hs
  exact textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ _
    (hHc.neg.add (hilbert_O_continuous β γ F hF))
    (hHs.neg.add (hilbert_O_compact β γ F hs))

/-- The actual smooth compact differential graph in the original canonical Hilbert space,
with genuine AE representatives of both the function and its literal differential image. -/
def textbookLangevinCanonicalHilbertTestGraph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β γ σ : ℝ) (hβ : 0 < β) :
    Set (Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) :=
  {p | ∃ F : textbookLangevinPeriodicPhase N → ℝ,
    HasCompactSupport F ∧ ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection) ∧
    p.1 =ᵐ[textbookLangevinCanonicalMeasure U β hβ] F ∧
    p.2 =ᵐ[textbookLangevinCanonicalMeasure U β hβ] textbookLangevinPeriodicDifferentialOperator U γ σ F}

/-- The domain of the actual Hilbert test graph is dense, using the proved actual L2 density. -/
theorem textbookLangevinCanonicalHilbertTestGraph_domain_dense {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) :
    Dense {f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) |
      ∃ g, (f, g) ∈ textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ} := by
  apply (textbookLangevinCanonicalL2_dense_smooth_compact U hU hp β hβ).mono
  rintro f ⟨F, hf, hs, hF⟩
  have hg := textbookLangevinCanonicalMeasure_differential_memLp_two U hU hp β γ σ hβ F hF hs
  exact ⟨hg.toLp _, F, hs, hF, hf, hg.coeFn_toLp⟩

/-- True canonical weighted transpose testing persists to the actual graph closure
by continuity of Hilbert pairing, not by an assumed closed adjoint domain. -/
theorem textbookLangevinCanonicalHilbertTestGraph_closure_pairing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (f g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hfg : (f, g) ∈ closure (textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ))
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    ⟪g, textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (hilbert_F_continuous G hG) hsG⟫_ℝ =
      ⟪f, (textbookLangevinCanonicalMeasure_formalAdjoint_memLp_two U hU hp β γ hβ G hG hsG).toLp _⟫_ℝ := by
  let H := Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)
  let v : H := textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
    (hilbert_F_continuous G hG) hsG
  let w : H := (textbookLangevinCanonicalMeasure_formalAdjoint_memLp_two U hU hp β γ hβ G hG hsG).toLp _
  let Z : Set (H × H) := {p | ⟪p.2, v⟫_ℝ = ⟪p.1, w⟫_ℝ}
  have hZ : IsClosed Z := isClosed_eq (by fun_prop) (by fun_prop)
  have hsub : textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ ⊆ Z := by
    rintro p ⟨F, hsF, hF, hf, hg⟩
    have hv : v =ᵐ[textbookLangevinCanonicalMeasure U β hβ] G :=
      textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G _ hsG
    have hw : w =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
        textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ G :=
      MemLp.coeFn_toLp _
    change ⟪p.2, v⟫_ℝ = ⟪p.1, w⟫_ℝ
    rw [L2.inner_def, L2.inner_def]
    have he := textbookLangevinCanonicalMeasure_weighted_formal_adjoint U hU hp β γ σ hβ hσ
      G F hG hF hsG hsF
    calc
      _ = ∫ x, G x * textbookLangevinPeriodicDifferentialOperator U γ σ F x
          ∂textbookLangevinCanonicalMeasure U β hβ := by
        apply integral_congr_ae
        filter_upwards [hg, hv] with x hx hy
        rw [hx, hy, Real.inner_apply]
        exact mul_comm _ _
      _ = ∫ x, textbookLangevinCanonicalWeightedFormalAdjointExpression U β γ G x * F x
          ∂textbookLangevinCanonicalMeasure U β hβ := he
      _ = _ := by
        apply integral_congr_ae
        filter_upwards [hf, hw] with x hx hy
        rw [hx, hy, Real.inner_apply]
        ring
  exact (closure_minimal hsub hZ) hfg

/-- The actual canonical differential graph closure has no nonzero vertical limit:
a true Hilbert closability condition, proved by the genuine dense smooth test class. -/
theorem textbookLangevinCanonicalHilbertTestGraph_closure_zero_vertical {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hg : (0, g) ∈ closure (textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ)) : g = 0 := by
  apply (textbookLangevinCanonicalL2_dense_smooth_compact U hU hp β hβ).eq_zero_of_inner_left ℝ
  rintro v ⟨G, hv, hsG, hG⟩
  have he : v = textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (hilbert_F_continuous G hG) hsG := by
    apply Lp.ext
    exact hv.trans (textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G _ hsG).symm
  rw [he]
  simpa using textbookLangevinCanonicalHilbertTestGraph_closure_pairing U hU hp β γ σ hβ hσ
    0 g hg G hG hsG

end
end MolecularDynamics
