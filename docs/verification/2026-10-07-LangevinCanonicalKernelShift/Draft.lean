import MolecularDynamics.Chapter06.LangevinCanonicalKernelUnweighted
import Mathlib.MeasureTheory.Group.Prod

/-! Genuine phase translations of compact smooth tests for the original kernel
constancy proof. No invariance of the canonical probability or constancy of a
rough kernel representative is assumed or asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section
local instance kernelShiftUnitCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance kernelShiftUnitCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance kernelShiftUnitCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual real-to-periodic phase projection preserves phase addition. -/
theorem textbookLangevinPeriodicProjection_add {N : ℕ} (z w : textbookLangevinPhase N) :
    textbookLangevinPeriodicProjection (z + w) =
      textbookLangevinPeriodicProjection z + textbookLangevinPeriodicProjection w := by
  apply Prod.ext
  · funext i
    change ((z.1 i + w.1 i : ℝ) : UnitAddCircle) =
      (z.1 i : UnitAddCircle) + (w.1 i : UnitAddCircle)
    exact AddCircle.coe_add (1 : ℝ) (z.1 i) (w.1 i)
  · rfl

/-- Every genuine phase translate of a smooth original test has a smooth real lift. -/
theorem textbookLangevinPeriodicTest_shift_lift_contDiff {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (a : textbookLangevinPeriodicPhase N) :
    ContDiff ℝ ∞ ((fun x ↦ G (x + a)) ∘ textbookLangevinPeriodicProjection) := by
  obtain ⟨w, rfl⟩ := textbookLangevinPeriodicProjection_surjective N a
  have he : (fun x ↦ G (x + textbookLangevinPeriodicProjection w)) ∘ textbookLangevinPeriodicProjection =
      (G ∘ textbookLangevinPeriodicProjection) ∘ (fun z ↦ z + w) := by
    funext z
    simp only [Function.comp_apply, textbookLangevinPeriodicProjection_add]
  rw [he]
  exact hG.comp (contDiff_id.add contDiff_const)

/-- Genuine phase translation preserves compact support by its actual homeomorphism. -/
theorem textbookLangevinPeriodicTest_shift_hasCompactSupport {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ) (hsG : HasCompactSupport G)
    (a : textbookLangevinPeriodicPhase N) :
    HasCompactSupport (fun x ↦ G (x + a)) :=
  hsG.comp_homeomorph (Homeomorph.addRight a)

/-- The actual descended coordinate derivative commutes with each genuine phase shift. -/
theorem textbookLangevinPeriodicDirectionalDerivative_shift {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ) (a : textbookLangevinPeriodicPhase N)
    (v : textbookLangevinPhase N) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (fun y ↦ G (y + a)) v x =
      textbookLangevinPeriodicDirectionalDerivative G v (x + a) := by
  obtain ⟨w, rfl⟩ := textbookLangevinPeriodicProjection_surjective N a
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  have he : (fun x ↦ G (x + textbookLangevinPeriodicProjection w)) ∘ textbookLangevinPeriodicProjection =
      fun y ↦ (G ∘ textbookLangevinPeriodicProjection) (y + w) := by
    funext y
    simp only [Function.comp_apply, textbookLangevinPeriodicProjection_add]
  rw [textbookLangevinPeriodicDirectionalDerivative_lift, he, fderiv_comp_add_right]
  rw [← textbookLangevinPeriodicProjection_add, textbookLangevinPeriodicDirectionalDerivative_lift]

/-- The true phase curve of a smooth test has its actual Frechet directional
derivative at every real time, with the position quotient and momentum shift aligned. -/
theorem textbookLangevinPeriodicTest_shift_curve_hasDerivAt {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (x : textbookLangevinPeriodicPhase N) (v : textbookLangevinPhase N) (t : ℝ) :
    HasDerivAt (fun s : ℝ ↦ G (x + textbookLangevinPeriodicProjection (s • v)))
      (textbookLangevinPeriodicDirectionalDerivative G v
        (x + textbookLangevinPeriodicProjection (t • v))) t := by
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  have hline : HasDerivAt (fun s : ℝ ↦ z + s • v) v t := by
    simpa only [id_eq, one_smul] using! ((hasDerivAt_id t).smul_const v).const_add z
  have hc := (hG.differentiable (by simp) (z + t • v)).hasFDerivAt.comp_hasDerivAt t hline
  have he : (fun s : ℝ ↦ G (textbookLangevinPeriodicProjection z + textbookLangevinPeriodicProjection (s • v))) =
      (G ∘ textbookLangevinPeriodicProjection) ∘ (fun s : ℝ ↦ z + s • v) := by
    funext s
    simp only [Function.comp_apply, textbookLangevinPeriodicProjection_add]
  rw [he, ← textbookLangevinPeriodicProjection_add, textbookLangevinPeriodicDirectionalDerivative_lift]
  simpa only [Function.comp_apply] using! hc

/-- The original unweighted reference phase measure is genuinely preserved by
phase translations; this says nothing about translated canonical probabilities. -/
theorem textbookLangevinPeriodicReferenceMeasure_shift_measurePreserving {N : ℕ}
    (a : textbookLangevinPeriodicPhase N) :
    MeasurePreserving (fun x ↦ x + a)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  exact (measurePreserving_add_right (volume : Measure (UnitAddTorus (Fin N))) a.1).prod
    (measurePreserving_add_right (volume : Measure (Fin N → ℝ)) a.2)

private theorem kernelShift_basis {N : ℕ}
    (A : textbookLangevinPhase N →L[ℝ] ℝ) (v : textbookLangevinPhase N) :
    A v = (∑ i : Fin N, v.1 i * A (Pi.single i 1, 0)) +
      ∑ i : Fin N, v.2 i * A (0, Pi.single i 1) := by
  classical
  have hq : (∑ i : Fin N, v.1 i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) = (v.1, 0) := by
    apply Prod.ext
    · rw [Prod.fst_sum]
      exact (pi_eq_sum_univ' v.1).symm
    · rw [Prod.snd_sum]
      simp
  have hp : (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ))) = (0, v.2) := by
    apply Prod.ext
    · rw [Prod.fst_sum]
      simp
    · rw [Prod.snd_sum]
      exact (pi_eq_sum_univ' v.2).symm
  have he : v = (∑ i : Fin N, v.1 i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) +
      ∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ)) := by
    rw [hq, hp]
    exact (Prod.ext (add_zero _) (zero_add _)).symm
  calc
    A v = A ((∑ i : Fin N, v.1 i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) +
        ∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ))) := congrArg A he
    _ = _ := by
      rw [map_add, map_sum, map_sum]
      simp only [map_smul, smul_eq_mul]

private theorem kernelShift_direction_basis {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ) (v : textbookLangevinPhase N)
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDirectionalDerivative G v x =
      (∑ i : Fin N, v.1 i * textbookLangevinPeriodicDirectionalDerivative G (Pi.single i 1, 0) x) +
      ∑ i : Fin N, v.2 i * textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x := by
  unfold textbookLangevinPeriodicDirectionalDerivative
  exact kernelShift_basis _ v

private theorem kernelShift_kernel_direction_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (v : textbookLangevinPhase N) (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G v x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 := by
  let Q : Fin N → textbookLangevinPeriodicPhase N → ℝ :=
    fun i x ↦ v.1 i * ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (Pi.single i 1, 0) x)
  let P : Fin N → textbookLangevinPeriodicPhase N → ℝ :=
    fun i x ↦ v.2 i * ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x)
  have hq (i : Fin N) : Integrable (Q i)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    (textbookLangevinCanonicalL2_unweighted_derivative_test_integrable U hU hp β hβ f (Sum.inl i) G hG hsG).const_mul _
  have hp' (i : Fin N) : Integrable (P i)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    (textbookLangevinCanonicalL2_unweighted_derivative_test_integrable U hU hp β hβ f (Sum.inr i) G hG hsG).const_mul _
  have hq0 (i : Fin N) : (∫ x, Q i x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 := by
    change (∫ x, v.1 i * ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (Pi.single i 1, 0) x)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0
    rw [integral_const_mul]
    change v.1 i * (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection (Sum.inl i)) x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0
    rw [textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_coordinate_testing U hU hp β γ σ hβ hγ hσ f hf (Sum.inl i) G hG hsG]
    exact mul_zero _
  have hp0 (i : Fin N) : (∫ x, P i x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 := by
    change (∫ x, v.2 i * ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (0, Pi.single i 1) x)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0
    rw [integral_const_mul]
    change v.2 i * (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection (Sum.inr i)) x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0
    rw [textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_coordinate_testing U hU hp β γ σ hβ hγ hσ f hf (Sum.inr i) G hG hsG]
    exact mul_zero _
  have hQ : Integrable (fun x ↦ ∑ i : Fin N, Q i x)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    integrable_finsetSum Finset.univ (fun i _ ↦ hq i)
  have hP : Integrable (fun x ↦ ∑ i : Fin N, P i x)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    integrable_finsetSum Finset.univ (fun i _ ↦ hp' i)
  calc
    _ = ∫ x, (∑ i : Fin N, Q i x) + ∑ i : Fin N, P i x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
      apply integral_congr_ae
      filter_upwards [] with x
      rw [kernelShift_direction_basis G v x, mul_add, Finset.mul_sum, Finset.mul_sum]
      dsimp only [Q, P]
      congr 1 <;> apply Finset.sum_congr rfl <;> intro i _ <;> ring
    _ = 0 := by
      rw [integral_add hQ hP, integral_finsetSum Finset.univ (fun i _ ↦ hq i),
        integral_finsetSum Finset.univ (fun i _ ↦ hp' i)]
      simp only [hq0, hp0, Finset.sum_const_zero, add_zero]

/-- Every genuine phase shifted compact smooth test is annihilated by the actual
kernel along every real phase direction, from proved ordinary coordinate testing.
This supplies the zero derivative integrals needed for the later pairing curve. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_shift_direction_testing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (a : textbookLangevinPeriodicPhase N) (v : textbookLangevinPhase N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G v (x + a)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 := by
  have ht := textbookLangevinPeriodicTest_shift_lift_contDiff G hG a
  have hs := textbookLangevinPeriodicTest_shift_hasCompactSupport G hsG a
  have hz := kernelShift_kernel_direction_testing U hU hp β γ σ hβ hγ hσ f hf v (fun x ↦ G (x + a)) ht hs
  simpa only [textbookLangevinPeriodicDirectionalDerivative_shift] using hz

end
end MolecularDynamics
