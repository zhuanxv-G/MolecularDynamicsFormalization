import MolecularDynamics.Chapter06.LangevinFourthMoments
import MolecularDynamics.Chapter06.BrownianC2ObservableTaylor
import MolecularDynamics.Chapter06.BrownianGeneratorExpectation

/-! Actual Hamiltonian expectation drift for the original unit-mass Langevin
process. The differential expression is not assumed to be its generator. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem expectedH_pi_norm_square_le_sum {N : ℕ} (v : Fin N → ℝ) :
    ‖v‖ ^ 2 ≤ ∑ i : Fin N, v i ^ 2 := by
  by_cases h : Nonempty (Fin N)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin N ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun r : ℝ≥0 ↦ (r : ℝ)) hi
    rw [he, Real.norm_eq_abs, sq_abs]
    exact Finset.single_le_sum (fun j _ ↦ sq_nonneg (v j)) (Finset.mem_univ i)
  · have : IsEmpty (Fin N) := not_nonempty_iff.mp h
    simp [Pi.norm_def]

private theorem expectedH_first_order_remainder_bound {N : ℕ}
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hp : textbookUnitPeriodicPotential f) :
    ∃ K : ℝ, 0 ≤ K ∧ ∀ x y,
      ‖f (x + y) - f x - fderiv ℝ f x y‖ ≤ K * ‖y‖ ^ 2 := by
  obtain ⟨K, hK, hb⟩ := textbookBrownianC2ObservableTaylorRemainder_quadratic_bound f hf hp
  obtain ⟨M, hM, hMbound⟩ := textbookUnitPeriodicC2Observable_iteratedFDeriv_bound f hf hp 2 le_rfl
  refine ⟨K + M / 2, add_nonneg hK (div_nonneg hM (by norm_num)), fun x y ↦ ?_⟩
  have hh : ‖iteratedFDeriv ℝ 2 f x (fun _ ↦ y)‖ ≤ M * ‖y‖ ^ 2 := by
    simpa using (iteratedFDeriv ℝ 2 f x).le_of_opNorm_le (hMbound x) (fun _ ↦ y)
  have he : f (x + y) - f x - fderiv ℝ f x y =
      textbookBrownianObservableTaylorRemainder f x y +
        (2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 f x (fun _ ↦ y) := by
    unfold textbookBrownianObservableTaylorRemainder
    ring
  rw [he]
  calc
    _ ≤ ‖textbookBrownianObservableTaylorRemainder f x y‖ +
        ‖(2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 f x (fun _ ↦ y)‖ := norm_add_le _ _
    _ ≤ K * ‖y‖ ^ 2 + (2 : ℝ)⁻¹ * (M * ‖y‖ ^ 2) := by
      rw [norm_mul, Real.norm_of_nonneg (by norm_num : 0 ≤ (2 : ℝ)⁻¹)]
      exact add_le_add (hb x y) (mul_le_mul_of_nonneg_left hh (by norm_num))
    _ = _ := by ring

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
/-- The actual continuous configuration increment squared norm is integrable. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_norm_square_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample -
      textbookLangevinPeriodicRepresentative x.1‖ ^ 2) P := by
  have hi (i : Fin N) := (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i).integrable_sq
  have hu := integrable_finsetSum Finset.univ (fun i _ ↦ hi i)
  have hm := ((textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).fst.sub
      (aemeasurable_const (b := textbookLangevinPeriodicRepresentative x.1))).norm.pow_const 2
  exact hu.mono_nonneg hm.aestronglyMeasurable
    (Eventually.of_forall (fun _ ↦ sq_nonneg _))
    (Eventually.of_forall (fun sample ↦ expectedH_pi_norm_square_le_sum _))

include hB hU hp in
/-- The genuine configuration squared norm expectation divided by time vanishes. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_norm_square_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample -
        textbookLangevinPeriodicRepresentative x.1‖ ^ 2 ∂P) / T) (𝓝[>] 0) (𝓝 0) := by
  let E := fun (t : ℝ) (i : Fin N) ↦ (∫ sample,
    (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
      textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ∂P) / t
  have hl : Tendsto (fun t : ℝ ↦ ∑ i : Fin N, E t i) (𝓝[>] 0) (𝓝 0) := by
    have hh : Tendsto (fun t : ℝ ↦ ∑ i : Fin N, E t i) (𝓝[>] 0) (𝓝 (∑ _i : Fin N, (0 : ℝ))) := by
      apply tendsto_finsetSum
      intro i _
      exact textbookLangevinPeriodicConfigurationLift_increment_secondMoment_div_time_tendsto_zero
        B P hB U hU hp L hF γ σ hγ x i
    simpa using hh
  apply squeeze_zero' _ _ hl
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ sq_nonneg _)) ht.le
  · filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have hi := textbookLangevinPeriodicConfigurationLift_increment_norm_square_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le x
    have hcoord (i : Fin N) := (textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ t ht0.le x i).integrable_sq
    have hb := integral_mono hi (integrable_finsetSum Finset.univ (fun i _ ↦ hcoord i))
      (fun sample ↦ expectedH_pi_norm_square_le_sum
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
          textbookLangevinPeriodicRepresentative x.1))
    rw [integral_finsetSum Finset.univ (fun i _ ↦ hcoord i)] at hb
    simpa only [E, Finset.sum_div] using div_le_div_of_nonneg_right hb ht0.le

/-- The literal first-order potential remainder along the same actual real configuration. -/
def textbookLangevinPeriodicPotentialFirstRemainder (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) : ℝ :=
  U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample) -
    U (textbookLangevinPeriodicRepresentative x.1) -
    fderiv ℝ U (textbookLangevinPeriodicRepresentative x.1)
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample -
        textbookLangevinPeriodicRepresentative x.1)

include hB hU in
private theorem expectedH_remainder_aemeasurable (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    AEMeasurable (textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ T x) P := by
  let q0 := textbookLangevinPeriodicRepresentative x.1
  have hc : Continuous (fun q : Fin N → ℝ ↦ U q - U q0 - fderiv ℝ U q0 (q - q0)) := by
    have hcU := hU.continuous
    fun_prop
  exact hc.measurable.comp_aemeasurable
    (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ (q0, x.2) T hT).fst

include hB hU hp in
/-- The actual potential first-order remainder is integrable by true periodic
smoothness and actual configuration squared moments. -/
theorem textbookLangevinPeriodicPotentialFirstRemainder_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    Integrable (textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ T x) P := by
  obtain ⟨K, hK, hb⟩ := expectedH_first_order_remainder_bound U (hU.of_le (by simp)) hp
  have hq := textbookLangevinPeriodicConfigurationLift_increment_norm_square_integrable
    B P hB U hU hp L hF γ σ hγ T hT x
  apply (hq.const_mul K).mono'
    (expectedH_remainder_aemeasurable B P hB U hU L hF γ σ T hT x).aestronglyMeasurable
  apply Eventually.of_forall
  intro sample
  have hh := hb (textbookLangevinPeriodicRepresentative x.1)
    (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample -
      textbookLangevinPeriodicRepresentative x.1)
  simp only [add_sub_cancel] at hh
  simpa only [textbookLangevinPeriodicPotentialFirstRemainder, Real.norm_eq_abs,
    abs_of_nonneg (mul_nonneg hK (sq_nonneg _))] using hh

include hB hU hp in
/-- The expected potential remainder divided by time is zero in the small-time
limit, proved using the actual configuration squared norm moment. -/
theorem textbookLangevinPeriodicPotentialFirstRemainder_mean_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ T x sample ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨K, hK, hb⟩ := expectedH_first_order_remainder_bound U (hU.of_le (by simp)) hp
  let E := fun t : ℝ ↦ (∫ sample,
    ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
      textbookLangevinPeriodicRepresentative x.1‖ ^ 2 ∂P) / t
  have hE : Tendsto E (𝓝[>] 0) (𝓝 0) :=
    textbookLangevinPeriodicConfigurationLift_increment_norm_square_div_time_tendsto_zero
      B P hB U hU hp L hF γ σ hγ x
  have hbound : ∀ᶠ t in 𝓝[>] (0 : ℝ), ‖(∫ sample,
      textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ t x sample ∂P) / t‖ ≤ K * E t := by
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht0 : 0 < t := ht
    have hr := textbookLangevinPeriodicPotentialFirstRemainder_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le x
    have hq := textbookLangevinPeriodicConfigurationLift_increment_norm_square_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le x
    have hi : ‖∫ sample, textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ t x sample ∂P‖ ≤
        K * ∫ sample, ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
          textbookLangevinPeriodicRepresentative x.1‖ ^ 2 ∂P := by
      calc
        _ ≤ ∫ sample, ‖textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ t x sample‖ ∂P :=
          norm_integral_le_integral_norm _
        _ ≤ ∫ sample, K * ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
            textbookLangevinPeriodicRepresentative x.1‖ ^ 2 ∂P := by
          apply integral_mono hr.norm (hq.const_mul K)
          intro sample
          have hh := hb (textbookLangevinPeriodicRepresentative x.1)
            (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
              textbookLangevinPeriodicRepresentative x.1)
          simpa only [add_sub_cancel, textbookLangevinPeriodicPotentialFirstRemainder] using hh
        _ = _ := integral_const_mul _ _
    rw [norm_div, Real.norm_of_nonneg ht0.le]
    simpa only [E, mul_div_assoc] using div_le_div_of_nonneg_right hi ht0.le
  exact squeeze_zero_norm' hbound (by simpa only [mul_zero] using hE.const_mul K)

include hB hU hp in
/-- The true original potential increment mean derivative equals its original
potential derivative at the initial position applied to the initial momentum. -/
theorem textbookLangevinPeriodicConfigurationLift_potential_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample) -
        U (textbookLangevinPeriodicRepresentative x.1) ∂P) / T)
      (𝓝[>] 0) (𝓝 (fderiv ℝ U (textbookLangevinPeriodicRepresentative x.1) x.2)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let q0 := textbookLangevinPeriodicRepresentative x.1
  let Δ := fun (t : ℝ) sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample - q0
  let c := fun i : Fin N ↦ textbookConfigurationPartial U i q0
  let R := textbookLangevinPeriodicPotentialFirstRemainder B U L hF γ σ
  have hl : Tendsto (fun t : ℝ ↦ ∑ i : Fin N, c i * ((∫ sample, Δ t sample i ∂P) / t))
      (𝓝[>] 0) (𝓝 (fderiv ℝ U q0 x.2)) := by
    rw [textbookConfigurationPartial_fderiv_coordinate_sum]
    apply tendsto_finsetSum
    intro i _
    exact (textbookLangevinPeriodicConfigurationLift_increment_mean_div_time_tendsto
      B P hB U hU hp L hF γ σ hγ x i).const_mul (c i)
  have hr := textbookLangevinPeriodicPotentialFirstRemainder_mean_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x
  have hh := hl.add hr
  simp only [add_zero] at hh
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  have hterm (i : Fin N) : Integrable (fun sample ↦ c i * Δ t sample i) P :=
    ((textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ t ht0.le x i).integrable (by norm_num)).const_mul (c i)
  have hR := textbookLangevinPeriodicPotentialFirstRemainder_integrable
    B P hB U hU hp L hF γ σ hγ t ht0.le x
  have he : (fun sample ↦ U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample) - U q0) =
      (fun sample ↦ (∑ i : Fin N, c i * Δ t sample i) + R t x sample) := by
    funext sample
    dsimp only [c]
    rw [← textbookConfigurationPartial_fderiv_coordinate_sum]
    dsimp only [R, Δ, q0, textbookLangevinPeriodicPotentialFirstRemainder]
    ring
  rw [he, integral_add (f := fun sample ↦ ∑ i : Fin N, c i * Δ t sample i)
    (g := R t x) (integrable_finsetSum Finset.univ (fun i _ ↦ hterm i)) hR,
    integral_finsetSum Finset.univ (fun i _ ↦ hterm i)]
  simp only [integral_const_mul, add_div, Finset.sum_div, mul_div_assoc, R]


include hB hU hp in
private theorem expectedH_kinetic_coordinate_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Integrable (fun sample ↦
      (((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) ^ 2 - x.2 i ^ 2) / 2) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let Δ := fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i
  have hδ := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hl : Integrable (fun sample ↦ x.2 i * Δ sample) P :=
    (hδ.integrable (by norm_num)).const_mul _
  have hq : Integrable (fun sample ↦ Δ sample ^ 2 / 2) P := hδ.integrable_sq.div_const 2
  apply (hl.add hq).congr
  exact Eventually.of_forall (fun sample ↦ by dsimp only [Δ, Pi.add_apply]; ring)

include hB hU hp in
private theorem expectedH_potential_increment_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample) -
      U (textbookLangevinPeriodicRepresentative x.1)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let q0 := textbookLangevinPeriodicRepresentative x.1
  let Δ := fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample - q0
  let c := fun i : Fin N ↦ textbookConfigurationPartial U i q0
  have hi (i : Fin N) : Integrable (fun sample ↦ c i * Δ sample i) P :=
    ((textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x i).integrable (by norm_num)).const_mul _
  have hr := textbookLangevinPeriodicPotentialFirstRemainder_integrable
    B P hB U hU hp L hF γ σ hγ T hT x
  apply ((integrable_finsetSum Finset.univ (fun i _ ↦ hi i)).add hr).congr
  apply Eventually.of_forall
  intro sample
  simp only [Pi.add_apply]
  dsimp only [c]
  rw [← textbookConfigurationPartial_fderiv_coordinate_sum]
  dsimp only [Δ, q0, textbookLangevinPeriodicPotentialFirstRemainder]
  ring

include hB hU hp in
/-- The kinetic energy coordinate's true expectation derivative is the original
momentum drift contribution plus the original diffusion half-variance. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_kinetic_coordinate_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) ^ 2 -
        x.2 i ^ 2) / 2 ∂P) / T) (𝓝[>] 0)
      (𝓝 (x.2 i * (textbookPotentialForce U (textbookLangevinPeriodicRepresentative x.1) i -
        γ * x.2 i) + σ ^ 2 / 2)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let Δ := fun (t : ℝ) sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i
  have hm := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x i
  have hs : Tendsto (fun t : ℝ ↦ (∫ sample, Δ t sample ^ 2 ∂P) / t) (𝓝[>] 0) (𝓝 (σ ^ 2)) := by
    simpa only [Δ, pow_two, ite_true, mul_one] using
      textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_div_time_tendsto
        B P hB U hU hp L hF γ σ hγ x i i
  have hh := (hm.const_mul (x.2 i)).add (hs.div_const 2)
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  have hδ := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
    B P hB U hU hp L hF γ σ hγ t ht0.le x i
  have hl : Integrable (fun sample ↦ x.2 i * Δ t sample) P :=
    (hδ.integrable (by norm_num)).const_mul _
  have hq : Integrable (fun sample ↦ Δ t sample ^ 2 / 2) P := hδ.integrable_sq.div_const 2
  have he : (fun sample ↦
      (((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i) ^ 2 - x.2 i ^ 2) / 2) =
      (fun sample ↦ x.2 i * Δ t sample + Δ t sample ^ 2 / 2) := by
    funext sample
    dsimp only [Δ]
    ring
  rw [he, integral_add (f := fun sample ↦ x.2 i * Δ t sample) (g := fun sample ↦ Δ t sample ^ 2 / 2) hl hq,
    integral_const_mul, integral_div]
  dsimp only [Δ]
  ring

omit [MeasurableSpace Ω] in
include hp in
private theorem expectedH_increment_decomposition (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) :
    textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U 1 x =
      (∑ i : Fin N, (((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) ^ 2 -
        x.2 i ^ 2) / 2) +
      (U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample) -
        U (textbookLangevinPeriodicRepresentative x.1)) := by
  change textbookLangevinPeriodicHamiltonianPower U 1
    (textbookLangevinPeriodicProjection (textbookLangevinGlobalRandomPhase U L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample)) - _ = _
  rw [textbookLangevinPeriodicHamiltonianPower_lift U hp 1]
  simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower,
    pow_one, textbookLangevinHamiltonian]
  change ((∑ i : Fin N, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) ^ 2) / 2 +
    U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample)) -
      ((∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1)) = _
  rw [← Finset.sum_div, Finset.sum_sub_distrib, sub_div]
  ring

include hB hU hp in
/-- The actual periodic Hamiltonian increment is integrable for arbitrary original
smooth periodic potential, with no lower normalization premise. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U 1 x) P := by
  have hk (i : Fin N) := expectedH_kinetic_coordinate_integrable B P hB U hU hp L hF γ σ hγ T hT x i
  have hu := expectedH_potential_increment_integrable B P hB U hU hp L hF γ σ hγ T hT x
  apply ((integrable_finsetSum Finset.univ (fun i _ ↦ hk i)).add hu).congr
  exact Eventually.of_forall (fun sample ↦ (expectedH_increment_decomposition B U hp L hF γ σ T x sample).symm)

include hB hU hp in
/-- The true original Hamiltonian expectation derivative cancels the actual
conservative force and equals friction loss plus diffusion energy input. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U 1 x ∂P) / T)
      (𝓝[>] 0) (𝓝 (-γ * (∑ i : Fin N, x.2 i ^ 2) + (N : ℝ) * σ ^ 2 / 2)) := by
  let q0 := textbookLangevinPeriodicRepresentative x.1
  let K := fun (t : ℝ) (i : Fin N) sample ↦
    (((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i) ^ 2 - x.2 i ^ 2) / 2
  let V := fun (t : ℝ) sample ↦
    U (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample) - U q0
  have hk : Tendsto (fun t : ℝ ↦ ∑ i : Fin N, (∫ sample, K t i sample ∂P) / t) (𝓝[>] 0)
      (𝓝 (∑ i : Fin N, (x.2 i * (textbookPotentialForce U q0 i - γ * x.2 i) + σ ^ 2 / 2))) := by
    apply tendsto_finsetSum
    intro i _
    exact textbookLangevinPeriodicGlobalRandomPhase_kinetic_coordinate_increment_mean_div_time_tendsto
      B P hB U hU hp L hF γ σ hγ x i
  have hv := textbookLangevinPeriodicConfigurationLift_potential_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x
  have hh := hk.add hv
  have hc : (∑ i : Fin N, (x.2 i * (textbookPotentialForce U q0 i - γ * x.2 i) + σ ^ 2 / 2)) +
      fderiv ℝ U q0 x.2 = -γ * (∑ i : Fin N, x.2 i ^ 2) + (N : ℝ) * σ ^ 2 / 2 := by
    rw [textbookConfigurationPartial_fderiv_coordinate_sum, ← Finset.sum_add_distrib]
    calc
      _ = ∑ i : Fin N, (-γ * x.2 i ^ 2 + σ ^ 2 / 2) := by
        apply Finset.sum_congr rfl
        intro i _
        dsimp only [textbookPotentialForce, textbookConfigurationPartial]
        ring
      _ = _ := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum]
        simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
        ring
  rw [hc] at hh
  apply hh.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  have hkI (i : Fin N) : Integrable (K t i) P :=
    expectedH_kinetic_coordinate_integrable B P hB U hU hp L hF γ σ hγ t ht0.le x i
  have hVI : Integrable (V t) P :=
    expectedH_potential_increment_integrable B P hB U hU hp L hF γ σ hγ t ht0.le x
  have he : (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) -
        textbookLangevinPeriodicHamiltonianPower U 1 x) =
      (fun sample ↦ (∑ i : Fin N, K t i sample) + V t sample) := by
    funext sample
    exact expectedH_increment_decomposition B U hp L hF γ σ t x sample
  rw [he, integral_add (f := fun sample ↦ ∑ i : Fin N, K t i sample) (g := V t)
    (integrable_finsetSum Finset.univ (fun i _ ↦ hkI i)) hVI,
    integral_finsetSum Finset.univ (fun i _ ↦ hkI i)]
  simp only [add_div, Finset.sum_div, V, q0]

include hB hU hp in
/-- The actual Hamiltonian expectation derivative agrees with the previously
derived differential expression on H itself; this is not an assumed generator identity. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U 1 x ∂P) / T)
      (𝓝[>] 0) (𝓝 (textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U 1)
        (textbookLangevinPeriodicRepresentative x.1, x.2))) := by
  have he := textbookLangevinHamiltonianPower_differentialOperator U (hU.differentiable (by simp)) γ σ 1
    (by norm_num) (textbookLangevinPeriodicRepresentative x.1, x.2)
  norm_num only [Nat.sub_self, pow_zero, Nat.sub_eq_zero_of_le (by norm_num : 1 ≤ 2), Nat.cast_one,
    mul_one, one_mul, sub_self, mul_zero, zero_mul, zero_add] at he
  rw [he]
  convert textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x using 1
  ring

include hB hU hp in
/-- With the original fluctuation-dissipation amplitude, the actual Hamiltonian
expectation derivative is γ(Nβ⁻¹ − |p0|²). -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_physical_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2 * γ * β⁻¹)) x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U 1 x ∂P) / T)
      (𝓝[>] 0) (𝓝 (γ * ((N : ℝ) * β⁻¹ - ∑ i : Fin N, x.2 i ^ 2))) := by
  have hh := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) hγ x
  rw [Real.sq_sqrt (mul_nonneg (mul_nonneg (by norm_num) hγ.le) (inv_nonneg.mpr hβ.le))] at hh
  convert hh using 1
  ring

end
end MolecularDynamics
