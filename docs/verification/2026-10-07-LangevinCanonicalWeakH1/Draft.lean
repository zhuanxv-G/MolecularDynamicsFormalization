import MolecularDynamics.Chapter06.LangevinCanonicalCoordinateWeakDerivative
import Mathlib.Analysis.InnerProductSpace.PiL2

/-! The original canonical weighted H1 norm, with genuine coordinate weak
derivatives characterized by the proved original weighted test pairings.
The weak graph is closed and gives a complete Hilbert space with an injective
function projection. H1 smooth norm density and Poisson solvability are not asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace
namespace MolecularDynamics
noncomputable section

private theorem weakH1_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

/-- Function and coordinate derivative classes, with the genuine finite Hilbert square-sum norm. -/
abbrev textbookLangevinCanonicalH1Jet {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β) : Type :=
  PiLp 2 (fun _ : Option (Fin N ⊕ Fin N) ↦ Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))

/-- The actual coordinate weak derivative graph, defined by the proved original
canonical IBP transpose, for every genuine compact smooth phase test. -/
def textbookLangevinCanonicalH1WeakGraph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Submodule ℝ (textbookLangevinCanonicalH1Jet U β hβ) where
  carrier := {v | ∀ (j : Fin N ⊕ Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G),
    ⟪v (some j), textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (weakH1_F_continuous G hG) hsG⟫_ℝ =
    ⟪v none, (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _⟫_ℝ}
  zero_mem' := by
    intro j G hG hsG
    simp
  add_mem' := by
    intro v w hv hw j G hG hsG
    simpa only [PiLp.add_apply, inner_add_left] using congrArg₂ (· + ·) (hv j G hG hsG) (hw j G hG hsG)
  smul_mem' := by
    intro c v hv j G hG hsG
    simpa only [PiLp.smul_apply, real_inner_smul_left] using
      congrArg (fun r : ℝ ↦ c * r) (hv j G hG hsG)

/-- True weak coordinate pairings are continuous, so the actual weak H1 graph is closed. -/
theorem textbookLangevinCanonicalH1WeakGraph_isClosed {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    IsClosed (textbookLangevinCanonicalH1WeakGraph U hU hp β hβ :
      Set (textbookLangevinCanonicalH1Jet U β hβ)) := by
  change IsClosed {v : textbookLangevinCanonicalH1Jet U β hβ |
    ∀ (j : Fin N ⊕ Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
      (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G),
    ⟪v (some j), textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (weakH1_F_continuous G hG) hsG⟫_ℝ =
    ⟪v none, (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _⟫_ℝ}
  simp_rw [Set.ofPred_forall]
  exact isClosed_iInter (fun j ↦ isClosed_iInter (fun G ↦ isClosed_iInter (fun hG ↦
    isClosed_iInter (fun hsG ↦ isClosed_eq (by fun_prop) (by fun_prop)))))

/-- Genuine dense tests force uniqueness of every actual weak derivative:
an H1 weak jet with zero function class has no nonzero derivative class. -/
theorem textbookLangevinCanonicalH1WeakGraph_zero_value {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (v : textbookLangevinCanonicalH1Jet U β hβ)
    (hv : v ∈ textbookLangevinCanonicalH1WeakGraph U hU hp β hβ) (h0 : v none = 0) : v = 0 := by
  have hd (j : Fin N ⊕ Fin N) : v (some j) = 0 := by
    apply (textbookLangevinCanonicalL2_dense_smooth_compact U hU hp β hβ).eq_zero_of_inner_left ℝ
    rintro t ⟨G, ht, hsG, hG⟩
    have he : t = textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
        (weakH1_F_continuous G hG) hsG := by
      apply Lp.ext
      exact ht.trans (textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G _ hsG).symm
    rw [he]
    simpa only [h0, inner_zero_left] using hv j G hG hsG
  apply PiLp.ext
  intro j
  cases j with
  | none => exact h0
  | some j => exact hd j

/-- The original canonical weighted H1 space represented by its genuine function
and unique coordinate weak derivatives with exactly the textbook square-sum norm. -/
abbrev textbookLangevinCanonicalWeakH1 {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : Type :=
  ↥(textbookLangevinCanonicalH1WeakGraph U hU hp β hβ)

/-- Completeness is derived from the actual closed weak graph in the genuine product Hilbert space. -/
instance textbookLangevinCanonicalWeakH1_completeSpace {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : CompleteSpace (textbookLangevinCanonicalWeakH1 U hU hp β hβ) :=
  (textbookLangevinCanonicalH1WeakGraph_isClosed U hU hp β hβ).completeSpace_coe

/-- The true function-class inclusion is a continuous linear map. -/
def textbookLangevinCanonicalWeakH1Value {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ →L[ℝ] Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (PiLp.proj 2 (fun _ : Option (Fin N ⊕ Fin N) ↦ Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) none).comp
    (textbookLangevinCanonicalH1WeakGraph U hU hp β hβ).subtypeL

/-- Each actual coordinate weak derivative is a continuous linear map into the same L2. -/
def textbookLangevinCanonicalWeakH1Derivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ →L[ℝ] Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (PiLp.proj 2 (fun _ : Option (Fin N ⊕ Fin N) ↦ Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) (some j)).comp
    (textbookLangevinCanonicalH1WeakGraph U hU hp β hβ).subtypeL

/-- Every actual H1 function has its true canonical coordinate weak derivative pairing. -/
theorem textbookLangevinCanonicalWeakH1_pairing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ)
    (j : Fin N ⊕ Fin N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    ⟪textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ j f,
      textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G (weakH1_F_continuous G hG) hsG⟫_ℝ =
    ⟪textbookLangevinCanonicalWeakH1Value U hU hp β hβ f,
      (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _⟫_ℝ :=
  f.property j G hG hsG

/-- The actual H1 function projection is injective by proved weak derivative uniqueness. -/
theorem textbookLangevinCanonicalWeakH1Value_injective {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Function.Injective (textbookLangevinCanonicalWeakH1Value U hU hp β hβ) := by
  intro f g heq
  have h0 : ((f - g : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
      textbookLangevinCanonicalH1Jet U β hβ) none = 0 := by
    change (f : textbookLangevinCanonicalH1Jet U β hβ) none -
      (g : textbookLangevinCanonicalH1Jet U β hβ) none = 0
    exact sub_eq_zero.mpr heq
  have hz := textbookLangevinCanonicalH1WeakGraph_zero_value U hU hp β hβ
    ((f - g : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
      textbookLangevinCanonicalH1Jet U β hβ) (f - g).property h0
  apply sub_eq_zero.mp
  exact Subtype.ext hz

/-- The actual norm is precisely the textbook function, q-gradient and p-gradient
L2 square sum, including dimension zero. -/
theorem textbookLangevinCanonicalWeakH1_norm_sq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2) := by
  change ‖(f : textbookLangevinCanonicalH1Jet U β hβ)‖ ^ 2 =
    ‖(f : textbookLangevinCanonicalH1Jet U β hβ) none‖ ^ 2 +
      (∑ i : Fin N, ‖(f : textbookLangevinCanonicalH1Jet U β hβ) (some (Sum.inl i))‖ ^ 2) +
      (∑ i : Fin N, ‖(f : textbookLangevinCanonicalH1Jet U β hβ) (some (Sum.inr i))‖ ^ 2)
  simpa only [Fintype.sum_option, Fintype.sum_sum_type, add_assoc] using
    PiLp.norm_sq_eq_of_L2 _ (f : textbookLangevinCanonicalH1Jet U β hβ)

private def weakH1_D_class {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ
    (textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j))
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF (textbookLangevinCanonicalCoordinateDirection j))
    (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs (textbookLangevinCanonicalCoordinateDirection j))).toLp
      (textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j))

private theorem weakH1_D_class_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) :
    weakH1_D_class U hU hp β hβ F hF hs j =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
      textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j) :=
  MemLp.coeFn_toLp _

/-- Every original compact smooth phase test gives a genuine H1 weak jet, using
proved actual coordinate IBP, not by postulating a Sobolev domain membership. -/
def textbookLangevinCanonicalWeakH1SmoothTest {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ :=
  ⟨WithLp.toLp 2 (fun j : Option (Fin N ⊕ Fin N) ↦ match j with
    | none => textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F (weakH1_F_continuous F hF) hs
    | some j => weakH1_D_class U hU hp β hβ F hF hs j), by
      intro j G hG hsG
      have hpair : (textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F
          (weakH1_F_continuous F hF) hs, weakH1_D_class U hU hp β hβ F hF hs j) ∈
          textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j :=
        ⟨F, hs, hF, textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ F (weakH1_F_continuous F hF) hs,
          weakH1_D_class_ae U hU hp β hβ F hF hs j⟩
      exact textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_pairing U hU hp β hβ j
        _ _ (subset_closure hpair) G hG hsG⟩

/-- The actual function projection of the smooth H1 test is the same original L2 class. -/
theorem textbookLangevinCanonicalWeakH1SmoothTest_value {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    textbookLangevinCanonicalWeakH1Value U hU hp β hβ
      (textbookLangevinCanonicalWeakH1SmoothTest U hU hp β hβ F hF hs) =
    textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F (weakH1_F_continuous F hF) hs := rfl

/-- The actual smooth H1 coordinate class is represented by its literal coordinate derivative. -/
theorem textbookLangevinCanonicalWeakH1SmoothTest_derivative_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) :
    textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ j
      (textbookLangevinCanonicalWeakH1SmoothTest U hU hp β hβ F hF hs) =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
    textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j) :=
  weakH1_D_class_ae U hU hp β hβ F hF hs j

private theorem weakH1_D_class_norm_sq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) :
    ‖weakH1_D_class U hU hp β hβ F hF hs j‖ ^ 2 =
    ∫ x, (textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j) x) ^ 2
      ∂textbookLangevinCanonicalMeasure U β hβ := by
  rw [← real_inner_self_eq_norm_sq, L2.inner_def]
  apply integral_congr_ae
  filter_upwards [weakH1_D_class_ae U hU hp β hβ F hF hs j] with x hx
  rw [hx, Real.inner_apply, pow_two]

/-- For actual smooth tests, the genuine H1 norm is exactly the original weighted
integral of the function square plus all q- and p-coordinate derivative squares. -/
theorem textbookLangevinCanonicalWeakH1SmoothTest_norm_sq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    ‖textbookLangevinCanonicalWeakH1SmoothTest U hU hp β hβ F hF hs‖ ^ 2 =
    (∫ x, (F x) ^ 2 ∂textbookLangevinCanonicalMeasure U β hβ) +
      (∑ i : Fin N, ∫ x, (textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x) ^ 2
        ∂textbookLangevinCanonicalMeasure U β hβ) +
      (∑ i : Fin N, ∫ x, (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) ^ 2
        ∂textbookLangevinCanonicalMeasure U β hβ) := by
  rw [textbookLangevinCanonicalWeakH1_norm_sq]
  have hFNorm : ‖textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F
      (weakH1_F_continuous F hF) hs‖ ^ 2 =
      ∫ x, (F x) ^ 2 ∂textbookLangevinCanonicalMeasure U β hβ := by
    rw [← real_inner_self_eq_norm_sq, textbookLangevinCanonicalL2CompactObservable_inner]
    simp only [pow_two]
  change ‖textbookLangevinCanonicalL2CompactObservable U hU hp β hβ F
      (weakH1_F_continuous F hF) hs‖ ^ 2 +
      (∑ i : Fin N, ‖weakH1_D_class U hU hp β hβ F hF hs (Sum.inl i)‖ ^ 2) +
      (∑ i : Fin N, ‖weakH1_D_class U hU hp β hβ F hF hs (Sum.inr i)‖ ^ 2) = _
  simp_rw [hFNorm, weakH1_D_class_norm_sq, textbookLangevinCanonicalCoordinateDirection]

end
end MolecularDynamics
