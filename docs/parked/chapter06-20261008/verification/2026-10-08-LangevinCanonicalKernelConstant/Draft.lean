import MolecularDynamics.Chapter06.LangevinCanonicalKernelContinuousTest
import MolecularDynamics.Chapter06.LangevinCanonicalH1MeanZero
import Mathlib.Topology.MetricSpace.ThickenedIndicator
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.MeasureTheory.Function.AEEqOfIntegral

/-! Actual kernel AE constancy is derived from continuous compact testing,
genuine compact-indicator dominated convergence and measurable Fubini.
This proves the kernel-to-constant direction; minimal closed-domain membership
of all constants and the full kernel identity remain separate obligations. -/
open Set Filter MeasureTheory Metric Function
open scoped Topology ContDiff NNReal ENNReal BigOperators
namespace MolecularDynamics
noncomputable section
local instance kernelConstantUnitCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance kernelConstantUnitCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance kernelConstantUnitCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private theorem kernelConstant_continuous_test_dual {N : ℕ}
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : LocallyIntegrable f ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
    (htest : ∀ G : textbookLangevinPeriodicPhase N → ℝ, Continuous G → HasCompactSupport G →
      (∫ x, f x * G x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0) :
    f =ᵐ[((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] 0 := by
  apply ae_eq_zero_of_forall_setIntegral_isCompact_eq_zero' hf
  intro K hK
  obtain ⟨r, hr, hR⟩ := hK.exists_isCompact_cthickening
  let R := cthickening r K
  let δ : ℕ → ℝ := fun n ↦ r / ((n : ℝ) + 1)
  have hδ (n : ℕ) : 0 < δ n := div_pos hr (by positivity)
  have hδr (n : ℕ) : δ n ≤ r := by
    apply (div_le_iff₀ (by positivity : 0 < (n : ℝ) + 1)).mpr
    nlinarith [Nat.cast_nonneg (α := ℝ) n]
  have hδlim : Tendsto δ atTop (𝓝 0) := by
    have he := (tendsto_one_div_add_atTop_nhds_zero_nat (𝕜 := ℝ)).const_mul r
    simpa only [mul_zero, mul_one_div] using he
  let g : ℕ → textbookLangevinPeriodicPhase N → ℝ :=
    fun n x ↦ ((thickenedIndicator (hδ n) K x : ℝ≥0) : ℝ)
  have hgc (n : ℕ) : Continuous (g n) :=
    NNReal.continuous_coe.comp (thickenedIndicator (hδ n) K).continuous
  have hgs (n : ℕ) : HasCompactSupport (g n) := by
    apply HasCompactSupport.of_support_subset_isCompact hR
    intro x hx
    by_contra hxR
    have hz : thickenedIndicator (hδ n) K x = 0 :=
      thickenedIndicator_zero (hδ n) K (fun h ↦ hxR ((thickening_subset_cthickening_of_le (hδr n) K) h))
    exact hx (by simp only [g, hz, NNReal.coe_zero])
  let bound : textbookLangevinPeriodicPhase N → ℝ := R.indicator (fun x ↦ ‖f x‖)
  have hboundI : Integrable bound
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    (integrable_indicator_iff hR.measurableSet).mpr (hf.integrableOn_isCompact hR).norm
  have hb (n : ℕ) (x : textbookLangevinPeriodicPhase N) : ‖f x * g n x‖ ≤ bound x := by
    by_cases hx : x ∈ R
    · have hgn : ‖g n x‖ ≤ 1 := by
        change ‖((thickenedIndicator (hδ n) K x : ℝ≥0) : ℝ)‖ ≤ 1
        rw [Real.norm_of_nonneg (NNReal.coe_nonneg _)]
        exact_mod_cast thickenedIndicator_le_one (hδ n) K x
      calc
        _ = ‖f x‖ * ‖g n x‖ := norm_mul _ _
        _ ≤ ‖f x‖ := mul_le_of_le_one_right (norm_nonneg _) hgn
        _ = bound x := by simp only [bound, indicator_of_mem hx]
    · have hz : thickenedIndicator (hδ n) K x = 0 :=
        thickenedIndicator_zero (hδ n) K (fun h ↦ hx ((thickening_subset_cthickening_of_le (hδr n) K) h))
      simp only [g, hz, NNReal.coe_zero, mul_zero, norm_zero, bound, indicator_of_notMem hx, le_refl]
  have hgLim := thickenedIndicator_tendsto_indicator_closure hδ hδlim K
  have hpoint (x : textbookLangevinPeriodicPhase N) :
      Tendsto (fun n ↦ f x * g n x) atTop (𝓝 (K.indicator f x)) := by
    have ht := (NNReal.continuous_coe.tendsto _).comp ((tendsto_pi_nhds.mp hgLim) x)
    have hm := ht.const_mul (f x)
    by_cases hx : x ∈ K
    · simpa only [g, Function.comp_apply, hK.isClosed.closure_eq, indicator_of_mem hx, NNReal.coe_one, mul_one] using hm
    · simpa only [g, Function.comp_apply, hK.isClosed.closure_eq, indicator_of_notMem hx, NNReal.coe_zero, mul_zero] using hm
  have hlim : Tendsto
      (fun n ↦ ∫ x, f x * g n x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
      atTop (𝓝 (∫ x in K, f x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))) := by
    rw [← integral_indicator hK.measurableSet]
    exact tendsto_integral_of_dominated_convergence bound
      (fun n ↦ hf.aestronglyMeasurable.mul (hgc n).aestronglyMeasurable)
      hboundI (fun n ↦ Eventually.of_forall (hb n)) (Eventually.of_forall hpoint)
  have hz (n : ℕ) : (∫ x, f x * g n x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) = 0 :=
    htest (g n) (hgc n) (hgs n)
  have hzero : Tendsto
      (fun n ↦ ∫ x, f x * g n x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
      atTop (𝓝 (0 : ℝ)) := by simpa only [hz] using (tendsto_const_nhds : Tendsto (fun _ : ℕ ↦ (0 : ℝ)) atTop (𝓝 0))
  exact tendsto_nhds_unique hlim hzero

private theorem kernelConstant_pairing_shift {N : ℕ}
    (f G : textbookLangevinPeriodicPhase N → ℝ) (a : textbookLangevinPeriodicPhase N) :
    (∫ x, f (x + a) * G x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) =
      ∫ x, f x * G (x + -a)
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  have he := (textbookLangevinPeriodicReferenceMeasure_shift_measurePreserving a).integral_comp
    (Homeomorph.addRight a).measurableEmbedding (fun x ↦ f x * G (x + -a))
  simpa only [add_neg_cancel_right] using he

/-- Every true closed-operator kernel representative is genuinely AE invariant
under every phase shift for the reference Haar times Lebesgue measure. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_shift_ae {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (a : textbookLangevinPeriodicPhase N) :
    (fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) (x + a)) =ᵐ[
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))]
      (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) := by
  let f0 : textbookLangevinPeriodicPhase N → ℝ := fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x
  have hl := textbookLangevinCanonicalL2_unweighted_locallyIntegrable U hU hp β hβ
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
  have hls := textbookLangevinCanonicalL2_unweighted_shift_locallyIntegrable U hU hp β hβ
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) a
  have hz : (fun x ↦ f0 (x + a) - f0 x) =ᵐ[
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] 0 := by
    apply kernelConstant_continuous_test_dual _ (hls.sub hl)
    intro G hG hsG
    have hi1 : Integrable (fun x ↦ f0 (x + a) * G x)
        ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
      simpa only [smul_eq_mul, mul_comm] using hls.integrable_smul_left_of_hasCompactSupport hG hsG
    have hi0 : Integrable (fun x ↦ f0 x * G x)
        ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
      simpa only [smul_eq_mul, mul_comm] using hl.integrable_smul_left_of_hasCompactSupport hG hsG
    simp_rw [Pi.sub_apply, sub_mul]
    rw [integral_sub hi1 hi0, kernelConstant_pairing_shift f0 G a,
      textbookLangevinCanonicalHilbertClosedOperator_kernel_continuous_pairing_shift_invariant
        U hU hp β γ σ hβ hγ hσ f hf G hG hsG (-a), sub_self]
  filter_upwards [hz] with x hx
  exact sub_eq_zero.mp hx

private theorem kernelConstant_fubini {N : ℕ}
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : AEStronglyMeasurable f ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
    (hinv : ∀ a : textbookLangevinPeriodicPhase N, (fun x ↦ f (x + a)) =ᵐ[
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] f) :
    ∃ c : ℝ, f =ᵐ[((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] fun _ ↦ c := by
  let g : textbookLangevinPeriodicPhase N → ℝ := hf.mk f
  have hgm : Measurable g := hf.stronglyMeasurable_mk.measurable
  have hfg : f =ᵐ[((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] g :=
    hf.ae_eq_mk
  have hgi (a : textbookLangevinPeriodicPhase N) : (fun x ↦ g (x + a)) =ᵐ[
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] g := by
    have hs := (textbookLangevinPeriodicReferenceMeasure_shift_measurePreserving a).quasiMeasurePreserving.ae_eq_comp hfg
    filter_upwards [hs, hinv a, hfg] with x hx hi hg
    exact hx.symm.trans (hi.trans hg)
  have hmeas : MeasurableSet {p : textbookLangevinPeriodicPhase N × textbookLangevinPeriodicPhase N |
      g (p.2 + p.1) = g p.2} :=
    measurableSet_eq_fun (hgm.comp (measurable_snd.add measurable_fst)) (hgm.comp measurable_snd)
  have hj := (Measure.ae_ae_comm
    (μ := ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
    (ν := ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
    hmeas).mp (Eventually.of_forall hgi)
  obtain ⟨x0, hx0⟩ := hj.exists
  have hc := (textbookLangevinPeriodicReferenceMeasure_shift_measurePreserving (-x0)).quasiMeasurePreserving.ae_eq_comp hx0
  have hgc : g =ᵐ[((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] fun _ ↦ g x0 := by
    filter_upwards [hc] with x hx
    simpa only [Function.comp_apply, add_comm x0, add_assoc, neg_add_cancel, add_zero] using hx
  exact ⟨g x0, hfg.trans hgc⟩

/-- AE constancy of the actual rough kernel for the genuine reference measure
follows from proved AE shifts and measurable Fubini, including N = 0. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_ae_constant {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    ∃ c : ℝ, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) =ᵐ[
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))] fun _ ↦ c :=
  kernelConstant_fubini _
    (textbookLangevinCanonicalL2_unweighted_locallyIntegrable U hU hp β hβ
      (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))).aestronglyMeasurable
    (textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_shift_ae U hU hp β γ σ hβ hγ hσ f hf)

/-- The original canonical kernel is AE constant for the same actual canonical
law, transferred only through its proved withDensity absolute continuity. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_constant {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    ∃ c : ℝ, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) =ᵐ[
      textbookLangevinCanonicalMeasure U β hβ] fun _ ↦ c := by
  obtain ⟨c, hc⟩ := textbookLangevinCanonicalHilbertClosedOperator_kernel_unweighted_ae_constant
    U hU hp β γ σ hβ hγ hσ f hf
  have hac : textbookLangevinCanonicalMeasure U β hβ ≪
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
    rw [textbookLangevinCanonicalMeasure_withDensity U hU hp β hβ]
    exact withDensity_absolutelyContinuous _ _
  exact ⟨c, hac.ae_eq hc⟩

/-- The true constant value is exactly the original canonical mean integral. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_eq_integral {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
      fun _ ↦ ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  obtain ⟨c, hc⟩ := textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_constant U hU hp β γ σ hβ hγ hσ f hf
  have hi : Integrable (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
      (textbookLangevinCanonicalMeasure U β hβ) := (Lp.memLp _).integrable (by norm_num)
  have he : (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x
      ∂textbookLangevinCanonicalMeasure U β hβ) = c := integral_eq_const hc
  simpa only [he] using hc

/-- A true kernel L2 element equals the actual H1 constant value at its canonical
mean; this does not assert that arbitrary constants are in the minimal L domain. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_eq_constant_value {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0) :
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) =
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ (textbookLangevinCanonicalWeakH1Constant U hU hp β hβ
        (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x
          ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  apply Lp.ext
  exact (textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_eq_integral U hU hp β γ σ hβ hγ hσ f hf).trans
    (textbookLangevinCanonicalWeakH1Constant_value_ae U hU hp β hβ _).symm

/-- The actual original kernel with genuine zero canonical mean is trivial.
No Poisson solution existence or full kernel identity is assumed. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_mean_zero_eq_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (hm : (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0) :
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) = 0 := by
  apply Lp.ext
  have hc := textbookLangevinCanonicalHilbertClosedOperator_kernel_ae_eq_integral U hU hp β γ σ hβ hγ hσ f hf
  rw [hm] at hc
  exact hc.trans (Lp.coeFn_zero ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)).symm

end
end MolecularDynamics
