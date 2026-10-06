import MolecularDynamics.Chapter06.LangevinHarrisAllTime
import Mathlib.MeasureTheory.Measure.Portmanteau
import Mathlib.MeasureTheory.Measure.Regular

/-! Necessary nonvacuity audit of the literal printed closed-time density clause in Assumption 1(ii). -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

local instance densityTimeZeroHaarMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance densityTimeZeroHaarIsAddHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance densityTimeZeroHaarProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- In every positive dimension, the actual kernel's genuine time-zero Dirac limit rules out the literal printed joint continuity on C×C×[0,∞) whenever C has an interior point. This does not rule out positive-time density continuity. -/
theorem textbookLangevinPeriodicDensityClause_printed_time_zero_impossible
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
    (hN : 0 < N) (C : Set (textbookLangevinPeriodicPhase N))
    (x : textbookLangevinPeriodicPhase N) (hx : x ∈ interior C)
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ) :
    ¬ textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ C ρ := by
  intro hρ
  have : NeZero N := ⟨Nat.ne_of_gt hN⟩
  have : Nonempty (Fin N) := ⟨⟨0, hN⟩⟩
  have : NullSingletonClass (volume : Measure (Fin N → ℝ)) := inferInstance
  have : NullSingletonClass (volume : Measure (textbookLangevinPeriodicPhase N)) :=
    inferInstanceAs (NullSingletonClass ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
  let F := fun w : textbookLangevinPeriodicPhase N × ℝ≥0 ↦ ρ x w.1 w.2
  have hemb : Continuous (fun w : textbookLangevinPeriodicPhase N × ℝ≥0 ↦ ((x, w.1), (w.2 : ℝ))) := by fun_prop
  have hCont : ContinuousOn F (C ×ˢ (univ : Set ℝ≥0)) := by
    apply hρ.2.comp hemb.continuousOn
    intro w hw
    exact ⟨⟨interior_subset hx, hw.1⟩, w.2.property⟩
  have hCS : C ×ˢ (univ : Set ℝ≥0) ∈ 𝓝 (x, (0 : ℝ≥0)) :=
    prod_mem_nhds (mem_interior_iff_mem_nhds.mp hx) univ_mem
  have hFc : ContinuousAt F (x, (0 : ℝ≥0)) :=
    (hCont (x, 0) ⟨interior_subset hx, mem_univ _⟩).continuousAt hCS
  let M : ℝ := |ρ x x 0| + 1
  have hM : 0 < M := by dsimp only [M]; linarith [abs_nonneg (ρ x x 0)]
  have hval : {w : textbookLangevinPeriodicPhase N × ℝ≥0 | F w < M} ∈ 𝓝 (x, (0 : ℝ≥0)) :=
    hFc.preimage_mem_nhds (Iio_mem_nhds (by
      change ρ x x 0 < |ρ x x 0| + 1
      linarith [le_abs_self (ρ x x 0)]))
  obtain ⟨r, hr, hb⟩ := Metric.mem_nhds_iff.mp (inter_mem hCS hval)
  have hpair (y : textbookLangevinPeriodicPhase N) (hy : y ∈ Metric.ball x r)
      (t : ℝ≥0) (ht : (t : ℝ) < r) : (y, t) ∈ Metric.ball (x, (0 : ℝ≥0)) r := by
    rw [Metric.mem_ball, Prod.dist_eq, max_lt_iff]
    refine ⟨hy, ?_⟩
    change dist (t : ℝ) (0 : ℝ) < r
    rw [Real.dist_eq, sub_zero]
    exact (abs_of_nonneg (show 0 ≤ (t : ℝ) from t.property)).symm ▸ ht
  have hball : Metric.ball x r ⊆ C := by
    intro y hy
    exact (hb (hpair y hy 0 (by simpa using hr))).1.1
  have hbd (y : textbookLangevinPeriodicPhase N) (hy : y ∈ Metric.ball x r)
      (t : ℝ≥0) (ht : (t : ℝ) < r) : ρ x y t ≤ M :=
    (hb (hpair y hy t ht)).2.le
  let c : ℝ≥0∞ := ENNReal.ofReal M
  have hc0 : c ≠ 0 := (ENNReal.ofReal_pos.mpr hM).ne'
  have hctop : c ≠ (∞ : ℝ≥0∞) := ENNReal.ofReal_ne_top
  have hcinv : (0 : ℝ≥0∞) < c⁻¹ := ENNReal.inv_pos.mpr hctop
  have : IsLocallyFiniteMeasure (volume : Measure (textbookLangevinPeriodicPhase N)) :=
    inferInstanceAs (IsLocallyFiniteMeasure ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
  obtain ⟨O, hxO, hO, hvolO⟩ :=
    ({x} : Set (textbookLangevinPeriodicPhase N)).exists_isOpen_lt_of_lt (μ := volume) c⁻¹
      (by simpa only [measure_singleton] using hcinv)
  let G := O ∩ Metric.ball x r
  have hG : IsOpen G := hO.inter Metric.isOpen_ball
  have hxG : x ∈ G := ⟨hxO (mem_singleton x), Metric.mem_ball_self hr⟩
  have hGc : G ⊆ C := inter_subset_right.trans hball
  have hvol : (volume : Measure (textbookLangevinPeriodicPhase N)) G < c⁻¹ :=
    (measure_mono inter_subset_left).trans_lt hvolO
  have hsmall : c * (volume : Measure (textbookLangevinPeriodicPhase N)) G < 1 := by
    calc
      _ < c * c⁻¹ := ENNReal.mul_lt_mul_right hc0 hctop hvol
      _ = 1 := ENNReal.mul_inv_cancel hc0 hctop
  let J : Filter ℝ≥0 := 𝓝[>] (0 : ℝ≥0)
  have : NeBot J := inferInstance
  let laws := fun t : ℝ≥0 ↦ textbookLangevinPeriodicTransitionProbability B P hB U hU hp L hF γ σ t x
  have hweak : Tendsto laws J (𝓝 (laws 0)) :=
    (textbookLangevinPeriodicTransitionProbability_time_continuous B P hB U hU hp L hF γ σ x).continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  have hport := ProbabilityMeasure.le_liminf_measure_open_of_tendsto hweak hG
  have hzero : (laws 0 : Measure (textbookLangevinPeriodicPhase N)) = Measure.dirac x := by
    change textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ 0 x = _
    rw [textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ, Kernel.id_apply]
  simp only [hzero, Measure.dirac_apply' x hG.measurableSet, Set.indicator_of_mem hxG, Pi.one_apply] at hport
  have hcoe : Tendsto (fun t : ℝ≥0 ↦ (t : ℝ)) J (𝓝 (0 : ℝ)) :=
    NNReal.continuous_coe.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  have htime : ∀ᶠ (t : ℝ≥0) in J, (t : ℝ) < r := hcoe.eventually (Iio_mem_nhds hr)
  have hup : ∀ᶠ (t : ℝ≥0) in J, (laws t : Measure (textbookLangevinPeriodicPhase N)) G ≤
      c * (volume : Measure (textbookLangevinPeriodicPhase N)) G := by
    filter_upwards [self_mem_nhdsWithin, htime] with t ht htr
    have ht0 : (0 : ℝ) < t := ht
    change textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ t x G ≤ _
    rw [hρ.1 t ht0 x (interior_subset hx) G hG.measurableSet hGc]
    calc
      _ ≤ ∫⁻ y in G, c := by
        apply lintegral_mono_ae
        filter_upwards [ae_restrict_mem hG.measurableSet] with y hy
        exact ENNReal.ofReal_le_ofReal (hbd y hy.2 t htr)
      _ = _ := by simp only [lintegral_const, Measure.restrict_apply_univ]
  have hlim : J.liminf (fun t ↦ (laws t : Measure (textbookLangevinPeriodicPhase N)) G) ≤
      c * (volume : Measure (textbookLangevinPeriodicPhase N)) G :=
    liminf_le_of_frequently_le' hup.frequently
  exact (not_lt_of_ge (hport.trans hlim)) hsmall

end
end MolecularDynamics
