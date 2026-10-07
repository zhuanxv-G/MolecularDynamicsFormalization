import MolecularDynamics.Chapter06.LangevinCanonicalKernelShift
import Mathlib.Analysis.Calculus.ParametricIntegral
import Mathlib.Topology.ContinuousMap.BoundedCompactlySupported

/-! Genuine dominated differentiation of the original kernel test pairing.
Translation invariance of the test functional is derived from true weak testing;
pointwise or AE constancy of the rough kernel remains a separate target. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section
local instance pairingShiftUnitCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance pairingShiftUnitCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance pairingShiftUnitCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual common compact support region for tests and their directional
derivatives over the genuine real time interval around t0. -/
def textbookLangevinPeriodicTestShiftSupportRegion {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ) (v : textbookLangevinPhase N) (t0 : ℝ) :
    Set (textbookLangevinPeriodicPhase N) :=
  (fun p : textbookLangevinPeriodicPhase N × ℝ ↦ p.1 - textbookLangevinPeriodicProjection (p.2 • v)) ''
    ((tsupport G ∪ tsupport (textbookLangevinPeriodicDirectionalDerivative G v)) ×ˢ Icc (t0 - 1) (t0 + 1))

/-- The actual support region is compact by compact original supports and the
continuous real-time phase shift, rather than by a supplied support bound. -/
theorem textbookLangevinPeriodicTestShiftSupportRegion_isCompact {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ) (hsG : HasCompactSupport G)
    (v : textbookLangevinPhase N) (t0 : ℝ) :
    IsCompact (textbookLangevinPeriodicTestShiftSupportRegion G v t0) := by
  have hc : Continuous (fun p : textbookLangevinPeriodicPhase N × ℝ ↦
      p.1 - textbookLangevinPeriodicProjection (p.2 • v)) :=
    continuous_fst.sub ((textbookLangevinPeriodicProjection_continuous N).comp
      (continuous_snd.smul continuous_const))
  exact ((hsG.union (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport G hsG v)).prod
    isCompact_Icc).image hc

/-- Both the shifted genuine test and its true directional derivative vanish
outside the proved common support region for every time in the actual interval. -/
theorem textbookLangevinPeriodicTestShiftSupportRegion_outside {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ) (v : textbookLangevinPhase N)
    (t0 t : ℝ) (ht : t ∈ Icc (t0 - 1) (t0 + 1))
    (x : textbookLangevinPeriodicPhase N) (hx : x ∉ textbookLangevinPeriodicTestShiftSupportRegion G v t0) :
    G (x + textbookLangevinPeriodicProjection (t • v)) = 0 ∧
      textbookLangevinPeriodicDirectionalDerivative G v
        (x + textbookLangevinPeriodicProjection (t • v)) = 0 := by
  constructor
  · by_contra hn
    apply hx
    refine ⟨(x + textbookLangevinPeriodicProjection (t • v), t), ⟨Or.inl ?_, ht⟩, ?_⟩
    · exact subset_tsupport _ hn
    · exact add_sub_cancel_right _ _
  · by_contra hn
    apply hx
    refine ⟨(x + textbookLangevinPeriodicProjection (t • v), t), ⟨Or.inr ?_, ht⟩, ?_⟩
    · exact subset_tsupport _ hn
    · exact add_sub_cancel_right _ _

private theorem pairingShift_continuous {N : ℕ}
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) : Continuous G :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous

/-- An actual canonical L2 representative has a genuine integrable dominator
for all shifted directional products near any real time. It is constructed
from true reference local L1, the proved support region and the actual test bound. -/
theorem textbookLangevinCanonicalL2_test_shift_derivative_dominator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G)
    (v : textbookLangevinPhase N) (t0 : ℝ) :
    ∃ bound : textbookLangevinPeriodicPhase N → ℝ,
      Integrable bound ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) ∧
      ∀ x, ∀ t ∈ Icc (t0 - 1) (t0 + 1),
        ‖f x * textbookLangevinPeriodicDirectionalDerivative G v
          (x + textbookLangevinPeriodicProjection (t • v))‖ ≤ bound x := by
  let D := textbookLangevinPeriodicDirectionalDerivative G v
  let bD : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ := ofCompactSupport D
    (textbookLangevinPeriodicDirectionalDerivative_continuous G hG v)
    (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport G hsG v)
  let C : ℝ := ‖bD‖
  let K := textbookLangevinPeriodicTestShiftSupportRegion G v t0
  let bound : textbookLangevinPeriodicPhase N → ℝ := K.indicator (fun x ↦ ‖f x‖ * C)
  have hK : IsCompact K := textbookLangevinPeriodicTestShiftSupportRegion_isCompact G hsG v t0
  have hI : IntegrableOn (fun x ↦ ‖f x‖ * C) K
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    ((textbookLangevinCanonicalL2_unweighted_locallyIntegrable U hU hp β hβ f).integrableOn_isCompact hK).norm.mul_const C
  refine ⟨bound, (integrable_indicator_iff hK.measurableSet).mpr hI, ?_⟩
  intro x t ht
  by_cases hx : x ∈ K
  · have hb : ‖D (x + textbookLangevinPeriodicProjection (t • v))‖ ≤ C :=
      BoundedContinuousFunction.norm_coe_le_norm bD _
    calc
      _ = ‖f x‖ * ‖D (x + textbookLangevinPeriodicProjection (t • v))‖ := norm_mul _ _
      _ ≤ ‖f x‖ * C := mul_le_mul_of_nonneg_left hb (norm_nonneg _)
      _ = bound x := by simp only [bound, Set.indicator_of_mem hx]
  · have hd := (textbookLangevinPeriodicTestShiftSupportRegion_outside G v t0 t ht x hx).2
    simp only [hd, mul_zero, norm_zero, bound, Set.indicator_of_notMem hx, le_refl]

/-- The actual original kernel pairing curve has derivative zero by genuine
dominated differentiation with a constructed integrable bound, and the previously
proved all-direction shifted weak tests. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_pairing_shift_hasDerivAt {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G)
    (v : textbookLangevinPhase N) (t0 : ℝ) :
    HasDerivAt (fun t : ℝ ↦ ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      G (x + textbookLangevinPeriodicProjection (t • v))
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) 0 t0 := by
  let F : ℝ → textbookLangevinPeriodicPhase N → ℝ :=
    fun t x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      G (x + textbookLangevinPeriodicProjection (t • v))
  let F' : ℝ → textbookLangevinPeriodicPhase N → ℝ :=
    fun t x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
      textbookLangevinPeriodicDirectionalDerivative G v (x + textbookLangevinPeriodicProjection (t • v))
  have hl := textbookLangevinCanonicalL2_unweighted_locallyIntegrable U hU hp β hβ
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
  have hGt (t : ℝ) : Continuous (fun x ↦ G (x + textbookLangevinPeriodicProjection (t • v))) :=
    pairingShift_continuous _ (textbookLangevinPeriodicTest_shift_lift_contDiff G hG _)
  have hFmeas (t : ℝ) : AEStronglyMeasurable (F t)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    hl.aestronglyMeasurable.mul (hGt t).aestronglyMeasurable
  have hFint : Integrable (F t0)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
    simpa only [F, smul_eq_mul, mul_comm] using
      hl.integrable_smul_left_of_hasCompactSupport (hGt t0)
        (textbookLangevinPeriodicTest_shift_hasCompactSupport G hsG _)
  have hD : Continuous (fun x ↦ textbookLangevinPeriodicDirectionalDerivative G v
      (x + textbookLangevinPeriodicProjection (t0 • v))) :=
    (textbookLangevinPeriodicDirectionalDerivative_continuous G hG v).comp
      (continuous_id.add continuous_const)
  have hF'meas : AEStronglyMeasurable (F' t0)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    hl.aestronglyMeasurable.mul hD.aestronglyMeasurable
  obtain ⟨bound, hboundI, hbound⟩ := textbookLangevinCanonicalL2_test_shift_derivative_dominator U hU hp β hβ
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) G hG hsG v t0
  have hn : Icc (t0 - 1) (t0 + 1) ∈ 𝓝 t0 := Icc_mem_nhds (by linarith) (by linarith)
  have hd : ∀ᵐ x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))),
      ∀ t ∈ Icc (t0 - 1) (t0 + 1), HasDerivAt (fun s ↦ F s x) (F' t x) t :=
    Eventually.of_forall (fun x t _ ↦
      (textbookLangevinPeriodicTest_shift_curve_hasDerivAt G hG x v t).const_mul
        ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x))
  have he := (hasDerivAt_integral_of_dominated_loc_of_deriv_le (F := F) (F' := F') hn
    (Eventually.of_forall hFmeas) hFint hF'meas (Eventually.of_forall hbound) hboundI hd).2
  have hz : (∫ x, F' t0 x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 :=
    textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_shift_direction_testing U hU hp β γ σ hβ hγ hσ f hf
      (textbookLangevinPeriodicProjection (t0 • v)) v G hG hsG
  rw [hz] at he
  exact he

/-- The original rough kernel test functional is invariant under every genuine
phase translation, by zero derivatives of actual integral pairing curves.
AE constancy of the kernel representative is not included in this statement. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_pairing_shift_invariant {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G)
    (a : textbookLangevinPeriodicPhase N) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * G (x + a)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) =
    ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * G x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  obtain ⟨v, rfl⟩ := textbookLangevinPeriodicProjection_surjective N a
  let I : ℝ → ℝ := fun t ↦ ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x *
    G (x + textbookLangevinPeriodicProjection (t • v))
    ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))
  have hI (t : ℝ) : HasDerivAt I 0 t :=
    textbookLangevinCanonicalHilbertClosedOperator_kernel_pairing_shift_hasDerivAt U hU hp β γ σ hβ hγ hσ f hf G hG hsG v t
  have he : I 1 = I 0 := is_const_of_deriv_eq_zero (fun t ↦ (hI t).differentiableAt) (fun t ↦ (hI t).deriv) 1 0
  have hzero : textbookLangevinPeriodicProjection (0 : textbookLangevinPhase N) = 0 := by
    ext i <;> simp [textbookLangevinPeriodicProjection]
  simpa only [I, one_smul, zero_smul, hzero, add_zero] using he

end
end MolecularDynamics
