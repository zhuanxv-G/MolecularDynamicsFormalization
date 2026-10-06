import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.Calculus.MeanValue
import MolecularDynamics.Chapter06.LangevinCesaroInvariant
import MolecularDynamics.Chapter06.LangevinProgressive
import Mathlib.MeasureTheory.Constructions.BorelSpace.Order

/-! Actual NNReal time continuity and measurable probability-law evolution of the original Langevin kernel.
Necessary dependencies for full-time invariant-law construction in Theorem 6.2; no stationarity or density premise is used for continuity. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
/-- The same actual expectation is continuous in the true nonnegative time, including zero, by actual all-sample path continuity and genuine dominated integration. -/
theorem textbookLangevinPeriodicTransitionExpectation_time_continuous
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ)
    (x : textbookLangevinPeriodicPhase N) :
    Continuous (fun T : ℝ≥0 ↦ textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f x) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have he : (fun T : ℝ≥0 ↦ textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f x) =
      (fun T : ℝ≥0 ↦ ∫ sample, f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ∂P) :=
    funext (fun T ↦ textbookLangevinPeriodicTransitionExpectation_actual_process B P hB U hU hp L hF γ σ T f x)
  rw [he]
  apply continuous_of_dominated (bound := fun _ ↦ ‖f‖)
  · intro T
    exact f.continuous.aestronglyMeasurable.comp_aemeasurable
      (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
        (hU.of_le (by simp)) L hF γ σ x T T.property)
  · intro T
    exact Eventually.of_forall fun sample ↦ f.norm_coe_le_norm _
  · exact integrable_const _
  · exact Eventually.of_forall fun sample ↦ f.continuous.comp
      (textbookLangevinPeriodicGlobalRandomPhase_nnreal_continuous B U
        (hU.of_le (by simp)) L hF γ σ x sample)

/-- The actual point transition law is a genuine weakly continuous probability curve in the same nonnegative time. -/
theorem textbookLangevinPeriodicTransitionProbability_time_continuous
    (x : textbookLangevinPeriodicPhase N) :
    Continuous (fun T : ℝ≥0 ↦ textbookLangevinPeriodicTransitionProbability B P hB U hU hp L hF γ σ T x) := by
  apply ProbabilityMeasure.continuous_iff_forall_continuous_integral.mpr
  intro f
  exact textbookLangevinPeriodicTransitionExpectation_time_continuous B P hB U hU hp L hF γ σ f x

/-- Every genuine initial probability law has a true weakly continuous actual evolution in nonnegative time. -/
theorem textbookLangevinPeriodicProbabilityEvolution_time_continuous
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    Continuous (fun T : ℝ≥0 ↦ textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ) := by
  apply ProbabilityMeasure.continuous_iff_forall_continuous_integral.mpr
  intro f
  have he : (fun T : ℝ≥0 ↦ ∫ y, f y
      ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ : Measure (textbookLangevinPeriodicPhase N))) =
      (fun T : ℝ≥0 ↦ ∫ x, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f x
        ∂(μ : Measure (textbookLangevinPeriodicPhase N))) :=
    funext (fun T ↦ textbookLangevinPeriodicProbabilityEvolution_integral B P hB U hU hp L hF γ σ T μ f)
  rw [he]
  apply continuous_of_dominated (bound := fun _ ↦ ‖f‖)
  · intro T
    exact (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f).continuous.aestronglyMeasurable
  · intro T
    exact Eventually.of_forall fun x ↦ textbookLangevinPeriodicTransitionExpectation_norm_le B P hB U hU hp L hF γ σ T f x
  · exact integrable_const _
  · exact Eventually.of_forall fun x ↦ textbookLangevinPeriodicTransitionExpectation_time_continuous B P hB U hU hp L hF γ σ f x

/-- Actual weak probability continuity gives Giry measurability of the same measure curve by open-set portmanteau and the true Borel pi-system, with no assumed topology-measurability identification. -/
theorem textbookLangevinPeriodicProbabilityEvolution_time_measurable
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    Measurable (fun T : ℝ≥0 ↦
      (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ : Measure (textbookLangevinPeriodicPhase N))) := by
  apply Measurable.measure_of_isPiSystem_of_isProbabilityMeasure (μ := fun T : ℝ≥0 ↦ (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ : Measure (textbookLangevinPeriodicPhase N)))
    (show (inferInstance : MeasurableSpace (textbookLangevinPeriodicPhase N)) =
      MeasurableSpace.generateFrom {C : Set (textbookLangevinPeriodicPhase N) | IsOpen C} from BorelSpace.measurable_eq)
    isPiSystem_isOpen
  intro C hC
  have hl : LowerSemicontinuous (fun T : ℝ≥0 ↦
      (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ : Measure (textbookLangevinPeriodicPhase N)) C) := by
    intro T
    apply lowerSemicontinuousAt_iff_le_liminf.mpr
    exact ProbabilityMeasure.le_liminf_measure_open_of_tendsto
      (textbookLangevinPeriodicProbabilityEvolution_time_continuous B P hB U hU hp L hF γ σ μ).continuousAt hC
  exact hl.measurable

/-- The original probability-law orbit as a genuine measurable kernel from the actual nonnegative time. -/
def textbookLangevinPeriodicEvolutionTimeKernel
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    Kernel ℝ≥0 (textbookLangevinPeriodicPhase N) :=
  ⟨fun T ↦ (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ :
      Measure (textbookLangevinPeriodicPhase N)),
    textbookLangevinPeriodicProbabilityEvolution_time_measurable B P hB U hU hp L hF γ σ μ⟩

/-- The genuine time-law kernel equals the same original transition composed with the actual initial law. -/
theorem textbookLangevinPeriodicEvolutionTimeKernel_apply
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) (T : ℝ≥0) :
    textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ T =
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) := rfl

/-- Every time-law in this exact kernel is truly a probability measure. -/
theorem textbookLangevinPeriodicEvolutionTimeKernel_isMarkov
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    IsMarkovKernel (textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ) := by
  constructor
  intro T
  change IsProbabilityMeasure
    (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ : Measure (textbookLangevinPeriodicPhase N))
  infer_instance

/-- The same actual probability-law evolution returns the true initial law at zero time. -/
theorem textbookLangevinPeriodicProbabilityEvolution_zero
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ 0 μ = μ := by
  apply Subtype.ext
  change textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ 0 ∘ₘ
    (μ : Measure (textbookLangevinPeriodicPhase N)) = μ
  rw [textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ, Measure.id_comp]

/-- The genuine same-kernel probability-law evolution obeys the true Chapman-Kolmogorov semigroup law. -/
theorem textbookLangevinPeriodicProbabilityEvolution_add
    (S T : ℝ≥0) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ (S + T) μ =
      textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T
        (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ S μ) := by
  apply Subtype.ext
  change textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ (S + T) ∘ₘ
    (μ : Measure (textbookLangevinPeriodicPhase N)) =
    textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)))
  rw [textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ, Measure.comp_assoc]

/-- The actual probability-law orbit of a skeleton invariant law is genuinely periodic in nonnegative time; this does not assert full-time stationarity of that initial law. -/
theorem textbookLangevinPeriodicProbabilityEvolution_periodic_of_skeleton_invariant
    (τ : ℝ≥0) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    Function.Periodic
      (fun T : ℝ≥0 ↦ textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ) τ := by
  have hm : textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ τ μ = μ := Subtype.ext hInv
  intro T
  change textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ (T + τ) μ =
    textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ
  rw [add_comm T τ, textbookLangevinPeriodicProbabilityEvolution_add, hm]


/-- This auxiliary real calculation is used only to average the actual periodic probability orbit over one positive skeleton period. -/
private theorem textbookLangevinNonnegativePeriodic_interval_mean_shift
    (τ T : ℝ≥0) (g : ℝ≥0 → ℝ) (hg : Continuous g) (hper : Function.Periodic g τ) :
    (∫ s in (0 : ℝ)..(τ : ℝ), g (Real.toNNReal s + T)) =
      ∫ s in (0 : ℝ)..(τ : ℝ), g (Real.toNNReal s) := by
  let gr : ℝ → ℝ := fun s ↦ g (Real.toNNReal s)
  have hgr : Continuous gr := hg.comp continuous_real_toNNReal
  have hperiod (s : ℝ) (hs : 0 ≤ s) : gr (s + τ) = gr s := by
    have hnn : Real.toNNReal (s + (τ : ℝ)) = Real.toNNReal s + τ := by
      apply NNReal.eq
      change max (s + (τ : ℝ)) 0 = max s 0 + (τ : ℝ)
      rw [max_eq_left hs]
      apply max_eq_left
      exact add_nonneg hs τ.property
    exact (congrArg g hnn).trans (hper _)
  let F : ℝ → ℝ := fun t ↦ (∫ s in (0 : ℝ)..(t + τ), gr s) - ∫ s in (0 : ℝ)..t, gr s
  have hd (t : ℝ) : HasDerivAt F (gr (t + τ) - gr t) t := by
    have hA := (hgr.integral_hasStrictDerivAt 0 (t + (τ : ℝ))).hasDerivAt
    have hshiftDeriv := hA.comp t ((hasDerivAt_id t).add_const (τ : ℝ))
    convert hshiftDeriv.sub ((hgr.integral_hasStrictDerivAt 0 t).hasDerivAt) using 1
    · funext z
      rfl
    · simp only [mul_one]
  have hcont : Continuous F := continuous_iff_continuousAt.mpr (fun t ↦ (hd t).continuousAt)
  have hzero : ∀ t ∈ Ico (0 : ℝ) (T : ℝ), HasDerivWithinAt F 0 (Ici t) t := by
    intro t ht
    have hdt := hd t
    rw [hperiod t ht.1, sub_self] at hdt
    exact hdt.hasDerivWithinAt
  have he := constant_of_has_deriv_right_zero hcont.continuousOn hzero (T : ℝ) ⟨T.property, le_rfl⟩
  have hshift : (∫ s in (0 : ℝ)..(τ : ℝ), g (Real.toNNReal s + T)) =
      ∫ s in (0 : ℝ)..(τ : ℝ), gr (s + T) := by
    apply intervalIntegral.integral_congr
    intro s hs
    have hs0 : 0 ≤ s := ((uIcc_of_le τ.property) ▸ hs).1
    have hnn : Real.toNNReal (s + (T : ℝ)) = Real.toNNReal s + T := by
      apply NNReal.eq
      change max (s + (T : ℝ)) 0 = max s 0 + (T : ℝ)
      rw [max_eq_left hs0]
      apply max_eq_left
      exact add_nonneg hs0 T.property
    exact (congrArg g hnn).symm
  rw [hshift, intervalIntegral.integral_comp_add_right]
  calc
    (∫ s in (0 : ℝ) + (T : ℝ)..(τ : ℝ) + (T : ℝ), gr s) = F T := by
      dsimp only [F]
      rw [intervalIntegral.integral_interval_sub_left (hgr.intervalIntegrable _ _) (hgr.intervalIntegrable _ _)]
      simp only [add_zero, add_comm]
    _ = F 0 := he
    _ = ∫ s in (0 : ℝ)..(τ : ℝ), g (Real.toNNReal s) := by
      simp only [F, zero_add, intervalIntegral.integral_same, sub_zero, gr]

/-- The actual nonzero finite Lebesgue period, transported to nonnegative time and normalized to a true probability clock. -/
def textbookLangevinInvariantAveragingClock (τ : ℝ≥0) (hτ : 0 < τ) :
    ProbabilityMeasure ℝ≥0 := by
  refine ⟨((τ : ℝ≥0∞)⁻¹) • (volume.restrict (Ioc (0 : ℝ) (τ : ℝ))).map Real.toNNReal, ?_⟩
  constructor
  rw [Measure.smul_apply, smul_eq_mul, Measure.map_apply measurable_real_toNNReal MeasurableSet.univ,
    Set.preimage_univ, Measure.restrict_apply MeasurableSet.univ, Set.univ_inter,
    Real.volume_Ioc, sub_zero, ENNReal.ofReal_coe_nnreal]
  exact ENNReal.inv_mul_cancel (by exact_mod_cast hτ.ne') ENNReal.coe_ne_top

/-- Integrating a genuine continuous time observable under the real probability clock is exactly its normalized original period integral. -/
theorem textbookLangevinInvariantAveragingClock_integral
    (τ : ℝ≥0) (hτ : 0 < τ) (g : ℝ≥0 → ℝ) (hg : Continuous g) :
    (∫ T, g T ∂(textbookLangevinInvariantAveragingClock τ hτ : Measure ℝ≥0)) =
      (τ : ℝ)⁻¹ * ∫ t in (0 : ℝ)..(τ : ℝ), g (Real.toNNReal t) := by
  change (∫ T, g T ∂(((τ : ℝ≥0∞)⁻¹) •
    (volume.restrict (Ioc (0 : ℝ) (τ : ℝ))).map Real.toNNReal)) = _
  rw [integral_smul_measure, integral_map measurable_real_toNNReal.aemeasurable hg.aestronglyMeasurable]
  simp only [ENNReal.toReal_inv, ENNReal.coe_toReal, smul_eq_mul]
  exact congrArg (fun c : ℝ ↦ (τ : ℝ)⁻¹ * c)
    (intervalIntegral.integral_of_le (μ := volume) (f := fun t : ℝ ↦ g (Real.toNNReal t)) τ.property).symm

/-- The real probability average of the original probability-law orbit over a genuine positive skeleton period. -/
def textbookLangevinPeriodicOrbitAverage
    (τ : ℝ≥0) (hτ : 0 < τ) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) :
    ProbabilityMeasure (textbookLangevinPeriodicPhase N) := by
  have : IsMarkovKernel (textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ) :=
    textbookLangevinPeriodicEvolutionTimeKernel_isMarkov B P hB U hU hp L hF γ σ μ
  exact ⟨textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ ∘ₘ
    (textbookLangevinInvariantAveragingClock τ hτ : Measure ℝ≥0), inferInstance⟩

/-- Each original bounded continuous test of the actual averaged law is its genuine normalized period expectation. -/
theorem textbookLangevinPeriodicOrbitAverage_integral
    (τ : ℝ≥0) (hτ : 0 < τ) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    (∫ y, f y ∂(textbookLangevinPeriodicOrbitAverage B P hB U hU hp L hF γ σ τ hτ μ :
      Measure (textbookLangevinPeriodicPhase N))) =
      (τ : ℝ)⁻¹ * ∫ t in (0 : ℝ)..(τ : ℝ), ∫ y, f y
        ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ (Real.toNNReal t) μ :
          Measure (textbookLangevinPeriodicPhase N)) := by
  have : IsMarkovKernel (textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ) :=
    textbookLangevinPeriodicEvolutionTimeKernel_isMarkov B P hB U hU hp L hF γ σ μ
  have he : (∫ y, f y ∂(textbookLangevinPeriodicOrbitAverage B P hB U hU hp L hF γ σ τ hτ μ :
      Measure (textbookLangevinPeriodicPhase N))) =
      ∫ T, (∫ y, f y ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T μ :
        Measure (textbookLangevinPeriodicPhase N)))
        ∂(textbookLangevinInvariantAveragingClock τ hτ : Measure ℝ≥0) := by
    change (∫ y, f y ∂(textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ ∘ₘ
      (textbookLangevinInvariantAveragingClock τ hτ : Measure ℝ≥0))) = _
    rw [Measure.comp_eq_comp_const_apply]
    have hi : Integrable f
        ((textbookLangevinPeriodicEvolutionTimeKernel B P hB U hU hp L hF γ σ μ ∘ₖ
          Kernel.const Unit (textbookLangevinInvariantAveragingClock τ hτ : Measure ℝ≥0)) ()) :=
      (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable
        (Eventually.of_forall f.norm_coe_le_norm)
    simpa only [Kernel.const_apply, textbookLangevinPeriodicEvolutionTimeKernel, Kernel.coe_mk] using Kernel.integral_comp hi
  rw [he]
  exact textbookLangevinInvariantAveragingClock_integral τ hτ _
    ((ProbabilityMeasure.continuous_integral_boundedContinuousFunction f).comp
      (textbookLangevinPeriodicProbabilityEvolution_time_continuous B P hB U hU hp L hF γ σ μ))

/-- A genuine positive-period orbit average of an actual skeleton invariant probability is invariant under the same original kernel at every nonnegative time. -/
theorem textbookLangevinPeriodicOrbitAverage_invariant
    (τ : ℝ≥0) (hτ : 0 < τ) (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) (T : ℝ≥0) :
    textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
      (textbookLangevinPeriodicOrbitAverage B P hB U hU hp L hF γ σ τ hτ μ :
        Measure (textbookLangevinPeriodicPhase N)) =
      textbookLangevinPeriodicOrbitAverage B P hB U hU hp L hF γ σ τ hτ μ := by
  let ν := textbookLangevinPeriodicOrbitAverage B P hB U hU hp L hF γ σ τ hτ μ
  have hfinite : (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T ν).toFiniteMeasure =
      ν.toFiniteMeasure := by
    apply FiniteMeasure.ext_of_forall_integral_eq
    intro f
    change (∫ y, f y ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ T ν :
      Measure (textbookLangevinPeriodicPhase N))) = ∫ y, f y ∂(ν : Measure (textbookLangevinPeriodicPhase N))
    rw [textbookLangevinPeriodicProbabilityEvolution_integral]
    dsimp only [ν]
    rw [textbookLangevinPeriodicOrbitAverage_integral, textbookLangevinPeriodicOrbitAverage_integral]
    let g : ℝ≥0 → ℝ := fun s ↦ ∫ y, f y
      ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ s μ :
        Measure (textbookLangevinPeriodicPhase N))
    have hg : Continuous g := (ProbabilityMeasure.continuous_integral_boundedContinuousFunction f).comp
      (textbookLangevinPeriodicProbabilityEvolution_time_continuous B P hB U hU hp L hF γ σ μ)
    have hper : Function.Periodic g τ :=
      (textbookLangevinPeriodicProbabilityEvolution_periodic_of_skeleton_invariant B P hB U hU hp L hF γ σ τ μ hInv).comp
        (fun ρ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) ↦ ∫ y, f y ∂(ρ : Measure (textbookLangevinPeriodicPhase N)))
    have htest (s : ℝ≥0) :
        (∫ y, textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f y
          ∂(textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ s μ :
            Measure (textbookLangevinPeriodicPhase N))) = g (s + T) := by
      dsimp only [g]
      rw [← textbookLangevinPeriodicProbabilityEvolution_integral B P hB U hU hp L hF γ σ T
        (textbookLangevinPeriodicProbabilityEvolution B P hB U hU hp L hF γ σ s μ) f,
        ← textbookLangevinPeriodicProbabilityEvolution_add]
    simp_rw [htest]
    exact congrArg (fun c : ℝ ↦ (τ : ℝ)⁻¹ * c)
      (textbookLangevinNonnegativePeriodic_interval_mean_shift τ T g hg hper)
  have hprob := (ProbabilityMeasure.toFiniteMeasure_isEmbedding (textbookLangevinPeriodicPhase N)).injective hfinite
  exact congrArg (fun ρ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) ↦
    (ρ : Measure (textbookLangevinPeriodicPhase N))) hprob

include hB in
/-- The same original actual Langevin transition has a genuine probability law invariant for all nonnegative times, without any density or invariant-law premise. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∀ T : ℝ≥0,
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨τ, hτ, μ, hInv⟩ := textbookLangevinPeriodicTransitionKernel_skeleton_invariant_exists
    B P hB U hU hp L hF γ σ hLower hγ
  exact ⟨textbookLangevinPeriodicOrbitAverage B P hB U hU hp L hF γ σ τ hτ μ,
    fun T ↦ textbookLangevinPeriodicOrbitAverage_invariant B P hB U hU hp L hF γ σ τ hτ μ hInv T⟩

include hB in
/-- Original smooth periodic force regularity and a full-time invariant law of the same true kernel are derived, rather than supplied as model data. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists_of_periodic
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
      ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∀ T : ℝ≥0,
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
          (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hp
  exact ⟨L, hF, textbookLangevinPeriodicTransitionKernel_invariant_exists B P hB U hU hp L hF γ σ hLower hγ⟩

end
end MolecularDynamics
