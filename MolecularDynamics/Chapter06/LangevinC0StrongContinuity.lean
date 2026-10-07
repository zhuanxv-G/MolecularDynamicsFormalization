import MolecularDynamics.Chapter06.LangevinC0Preservation
import MolecularDynamics.Chapter06.LangevinSmallTimeGrowth
import Mathlib.Topology.Algebra.IsUniformGroup.Basic

/-! True strong C0 continuity of the original Langevin transition.
Uniform initial-state estimates and genuine C0 tails control the full sup norm. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty

namespace MolecularDynamics
noncomputable section

private def strongC0_projectionHom (N : ℕ) :
    textbookLangevinPhase N →+ textbookLangevinPeriodicPhase N where
  toFun := textbookLangevinPeriodicProjection
  map_zero' := by
    apply Prod.ext
    · funext i
      change ((0 : ℝ) : UnitAddCircle) = 0
      simp
    · rfl
  map_add' z w := by
    apply Prod.ext
    · funext i
      change ((z.1 i + w.1 i : ℝ) : UnitAddCircle) =
        (z.1 i : UnitAddCircle) + (w.1 i : UnitAddCircle)
      exact AddCircle.coe_add (1 : ℝ) (z.1 i) (w.1 i)
    · rfl

/-- The original periodic projection is genuinely uniformly continuous by its
true additive homomorphism and the existing quotient continuity. -/
theorem textbookLangevinPeriodicProjection_uniformContinuous (N : ℕ) :
    UniformContinuous (textbookLangevinPeriodicProjection :
      textbookLangevinPhase N → textbookLangevinPeriodicPhase N) :=
  uniformContinuous_addMonoidHom_of_continuous
    (f := strongC0_projectionHom N) (textbookLangevinPeriodicProjection_continuous N)

private theorem strongC0_pi_square {N : ℕ} (v : Fin N → ℝ) :
    ‖v‖ ^ 2 ≤ ∑ i : Fin N, v i ^ 2 := by
  by_cases h : Nonempty (Fin N)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin N ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun r : ℝ≥0 ↦ (r : ℝ)) hi
    rw [he, Real.norm_eq_abs, sq_abs]
    exact Finset.single_le_sum (fun j _ ↦ sq_nonneg (v j)) (Finset.mem_univ i)
  · have : IsEmpty (Fin N) := not_nonempty_iff.mp h
    simp [Pi.norm_def]

private theorem strongC0_uniform_quadratic_modulus {N : ℕ}
    (g : textbookLangevinPhase N → ℝ) (hg : UniformContinuous g)
    (A : ℝ) (hA : 0 ≤ A) (hb : ∀ z, ‖g z‖ ≤ A) (ε : ℝ) (hε : 0 < ε) :
    ∃ K : ℝ, 0 ≤ K ∧ ∀ z y, ‖g (z + y) - g z‖ ≤ ε + K * ‖y‖ ^ 2 := by
  obtain ⟨η, hη, hm⟩ := Metric.uniformContinuous_iff.mp hg ε hε
  let K := (2 * A) / η ^ 2
  have hK : 0 ≤ K := div_nonneg (by positivity) (sq_nonneg η)
  refine ⟨K, hK, fun z y ↦ ?_⟩
  by_cases hy : ‖y‖ < η
  · have hd : dist (z + y) z < η := by
      rw [dist_eq_norm]
      simpa only [add_sub_cancel_left] using hy
    have hh : ‖g (z + y) - g z‖ < ε := by simpa only [dist_eq_norm] using hm hd
    exact hh.le.trans (le_add_of_nonneg_right (mul_nonneg hK (sq_nonneg ‖y‖)))
  · have hys : η ^ 2 ≤ ‖y‖ ^ 2 :=
      (sq_le_sq₀ hη.le (norm_nonneg y)).mpr (le_of_not_gt hy)
    have he : 2 * A = K * η ^ 2 := by dsimp only [K]; field_simp
    calc
      _ ≤ ‖g (z + y)‖ + ‖g z‖ := norm_sub_le _ _
      _ ≤ 2 * A := by linarith [hb (z + y), hb z]
      _ = K * η ^ 2 := he
      _ ≤ K * ‖y‖ ^ 2 := mul_le_mul_of_nonneg_left hys hK
      _ ≤ ε + K * ‖y‖ ^ 2 := le_add_of_nonneg_left hε.le

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The same actual damped Wiener convolution has a genuine norm-square
expectation bound C t for 0≤t≤1, including zero dimension. -/
theorem textbookLangevinDampedNoise_norm_second_small_time_bound
    (γ σ : ℝ) (hγ : 0 ≤ γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      (∫ sample, ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖ ^ 2 ∂P) ≤ C * T := by
  let C := (N : ℝ) * (2 * σ ^ 2 + σ ^ 2 * γ ^ 2)
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  refine ⟨C, hC, fun T hT hT1 ↦ ?_⟩
  have hi : Integrable (fun sample ↦
      ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T‖ ^ 2) P :=
    (textbookLangevinDampedNoise_memLp B P hB γ σ T hγ hT).integrable_norm_pow (by norm_num)
  have hs := textbookLangevinDampedNoise_sum_square_integrable B P hB γ σ T hγ hT
  have ht2 : T ^ 2 ≤ 1 := pow_le_one₀ hT hT1
  have ht3 : T ^ 3 ≤ T := by
    calc
      _ = T ^ 2 * T := by ring
      _ ≤ 1 * T := mul_le_mul_of_nonneg_right ht2 hT
      _ = T := one_mul T
  have hm := mul_le_mul_of_nonneg_left
    (mul_le_mul_of_nonneg_left ht3 (show 0 ≤ σ ^ 2 * γ ^ 2 by positivity))
    (Nat.cast_nonneg N : (0 : ℝ) ≤ N)
  calc
    _ ≤ ∫ sample, ∑ i : Fin N,
        textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2 ∂P :=
      integral_mono hi hs (fun sample ↦ strongC0_pi_square _)
    _ ≤ (N : ℝ) * (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3) :=
      textbookLangevinDampedNoise_sum_secondMoment_bound B P hB γ σ T hγ hT
    _ ≤ C * T := by dsimp only [C]; nlinarith


private theorem strongC0_momentum_tail {N : ℕ}
    (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) (ε : ℝ) (hε : 0 < ε) :
    ∃ R : ℝ, 0 ≤ R ∧ ∀ x : textbookLangevinPeriodicPhase N, R ≤ ‖x.2‖ → ‖f x‖ ≤ ε := by
  obtain ⟨K, hK, hOut⟩ := mem_cocompact.mp
    ((zero_at_infty f) (Metric.ball_mem_nhds (0 : ℝ) hε))
  obtain ⟨A, hA⟩ := hK.exists_bound_of_continuousOn continuous_snd.continuousOn
  let R := max A 0 + 1
  have hR : 0 ≤ R := by dsimp only [R]; positivity
  refine ⟨R, hR, fun x hx ↦ ?_⟩
  have hNot : x ∉ K := by
    intro hxK
    have ha := hA x hxK
    have hh : A < R := by dsimp only [R]; linarith [le_max_left A 0]
    linarith
  have hb := hOut hNot
  change dist (f x) 0 < ε at hb
  simpa only [dist_zero_right] using hb.le

variable (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU in
private theorem strongC0_observable_integrable
    (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) (T : ℝ) (hT : 0 ≤ T)
    (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  exact (integrable_const ‖f.toBCF‖).mono'
    (f.continuous.aestronglyMeasurable.comp_aemeasurable
      (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
        (hU.of_le (by simp)) L hF γ σ x T hT))
    (Eventually.of_forall (fun sample ↦ f.toBCF.norm_coe_le_norm _))

private theorem strongC0_observable_increment_expectation
    (hγ : 0 < γ) (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) (T : ℝ≥0)
    (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f x - f x =
      ∫ sample, f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - f x ∂P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  change textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f.toBCF x - f x = _
  rw [textbookLangevinPeriodicTransitionExpectation_actual_process B P hB U hU hp L hF γ σ T f.toBCF,
    integral_sub (strongC0_observable_integrable B P hB U hU L hF γ σ f T T.property x) (integrable_const _)]
  simp

/-- The actual C0 transition has a true uniform epsilon-plus-Ct small-time
sup-norm bound. The initial phase is unrestricted and no target continuity or
uniform estimate is assumed. The damping condition holds genuinely near zero. -/
theorem textbookLangevinPeriodicC0Transition_small_time_norm_bound
    (hγ : 0 < γ) (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ≥0, T ≤ 1 → (1 / 2 : ℝ) ≤ Real.exp (-γ * (T : ℝ)) →
      ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f - f‖ ≤ ε + C * (T : ℝ) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let A := ‖f.toBCF‖
  have hA : 0 ≤ A := norm_nonneg _
  let e := ε / 4
  have he : 0 < e := by dsimp only [e]; positivity
  let g := (f : textbookLangevinPeriodicPhase N → ℝ) ∘ textbookLangevinPeriodicProjection
  have hg : UniformContinuous g :=
    (ZeroAtInftyContinuousMap.uniformContinuous f).comp (textbookLangevinPeriodicProjection_uniformContinuous N)
  obtain ⟨K, hK, hMod⟩ := strongC0_uniform_quadratic_modulus g hg A hA
    (fun z ↦ f.toBCF.norm_coe_le_norm _) e he
  obtain ⟨Cs, hCs, hPhase⟩ := textbookLangevinPeriodicRealPhaseIncrement_second_growth_bound
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨Cn, hCn, hNoise⟩ := textbookLangevinDampedNoise_norm_second_small_time_bound B P hB γ σ hγ.le
  obtain ⟨M, hM, hRev⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_initial_bound_ae
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨R, hR, hTail⟩ := strongC0_momentum_tail f e he
  let D := 2 * (M / γ + R + 1)
  have hD : 0 ≤ D := by dsimp only [D]; positivity
  have hRD : R ≤ D := by dsimp only [D]; nlinarith [div_nonneg hM hγ.le]
  let C := K * Cs * (1 + D ^ 2) + A * Cn
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  refine ⟨C, hC, fun T hT1 hDamping ↦ ?_⟩
  have ht1 : (T : ℝ) ≤ 1 := by exact_mod_cast hT1
  have hNear (x : textbookLangevinPeriodicPhase N) :
      ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f x - f x‖ ≤
        e + K * (Cs * (1 + ‖x.2‖ ^ 2) * (T : ℝ)) := by
    let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
    let δ := textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x
    have hiSq : Integrable (fun sample ↦ ‖δ sample‖ ^ 2) P := by
      simpa only [mul_one] using textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
        B P hB U hU hp L hF γ σ hγ T T.property ht1 x 1 (by norm_num)
    have hiF := strongC0_observable_integrable B P hB U hU L hF γ σ f T T.property x
    have hiI := hiF.sub (integrable_const (f x))
    have hz : textbookLangevinPeriodicProjection z = x := by
      change ((fun i ↦ (textbookLangevinPeriodicRepresentative x.1 i : UnitAddCircle)), x.2) = x
      rw [textbookLangevinPeriodicRepresentative_projects]
    have hSample (sample : Ω) :
        ‖f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - f x‖ ≤ e + K * ‖δ sample‖ ^ 2 := by
      have hEnd : z + δ sample = textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample := by
        dsimp only [δ, textbookLangevinPeriodicRealPhaseIncrement, z]
        abel
      have hh := hMod z (δ sample)
      change ‖f (textbookLangevinPeriodicProjection (z + δ sample)) -
        f (textbookLangevinPeriodicProjection z)‖ ≤ _ at hh
      rw [hEnd, hz] at hh
      exact hh
    rw [strongC0_observable_increment_expectation B P hB U hU hp L hF γ σ hγ f T x]
    calc
      _ ≤ ∫ sample, ‖f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - f x‖ ∂P :=
        norm_integral_le_integral_norm _
      _ ≤ ∫ sample, e + K * ‖δ sample‖ ^ 2 ∂P :=
        integral_mono hiI.norm ((integrable_const e).add (hiSq.const_mul K)) hSample
      _ = e + K * (∫ sample, ‖δ sample‖ ^ 2 ∂P) := by
        rw [integral_add (integrable_const e) (hiSq.const_mul K), integral_const_mul]
        simp
      _ ≤ e + K * (Cs * (1 + ‖x.2‖ ^ 2) * (T : ℝ)) :=
        add_le_add le_rfl (mul_le_mul_of_nonneg_left (hPhase T T.property ht1 x) hK)
  have hFar (x : textbookLangevinPeriodicPhase N) (hx : D ≤ ‖x.2‖) :
      ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f x - f x‖ ≤
        2 * e + A * (Cn * (T : ℝ)) := by
    let ξ := fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T
    have hiSq : Integrable (fun sample ↦ ‖ξ sample‖ ^ 2) P :=
      (textbookLangevinDampedNoise_memLp B P hB γ σ T hγ.le T.property).integrable_norm_pow (by norm_num)
    have hiF := strongC0_observable_integrable B P hB U hU L hF γ σ f T T.property x
    have hInitial : M / γ + R + 1 ≤ Real.exp (-γ * (T : ℝ)) * ‖x.2‖ := by
      have hh := mul_le_mul_of_nonneg_right hDamping (norm_nonneg x.2)
      dsimp only [D] at hx
      nlinarith
    have hBound : ∀ᵐ sample ∂P,
        ‖f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)‖ ≤ e + A * ‖ξ sample‖ ^ 2 := by
      filter_upwards [hRev x] with sample hs
      let y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample
      by_cases hy : R ≤ ‖y.2‖
      · exact (hTail y hy).trans (le_add_of_nonneg_right (mul_nonneg hA (sq_nonneg ‖ξ sample‖)))
      · have hm := hs T T.property
        change Real.exp (-γ * (T : ℝ)) * ‖x.2‖ ≤ ‖y.2‖ + M / γ + ‖ξ sample‖ at hm
        have hξ : 1 ≤ ‖ξ sample‖ := by linarith
        have hξs : 1 ≤ ‖ξ sample‖ ^ 2 := by nlinarith [norm_nonneg (ξ sample)]
        have hb := f.toBCF.norm_coe_le_norm y
        have hh := mul_le_mul_of_nonneg_left hξs hA
        change ‖f y‖ ≤ A at hb
        change ‖f y‖ ≤ e + A * ‖ξ sample‖ ^ 2
        have hh' : A ≤ A * ‖ξ sample‖ ^ 2 := by simpa only [mul_one] using hh
        exact hb.trans (hh'.trans (le_add_of_nonneg_left he.le))
    have hMean : ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f x‖ ≤
        e + A * (Cn * (T : ℝ)) := by
      change ‖textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f.toBCF x‖ ≤ _
      rw [textbookLangevinPeriodicTransitionExpectation_actual_process B P hB U hU hp L hF γ σ T f.toBCF x]
      calc
        _ ≤ ∫ sample, ‖f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)‖ ∂P :=
          norm_integral_le_integral_norm _
        _ ≤ ∫ sample, e + A * ‖ξ sample‖ ^ 2 ∂P :=
          integral_mono_ae hiF.norm ((integrable_const e).add (hiSq.const_mul A)) hBound
        _ = e + A * (∫ sample, ‖ξ sample‖ ^ 2 ∂P) := by
          rw [integral_add (integrable_const e) (hiSq.const_mul A), integral_const_mul]
          simp
        _ ≤ e + A * (Cn * (T : ℝ)) :=
          add_le_add le_rfl (mul_le_mul_of_nonneg_left (hNoise T T.property ht1) hA)
    have hxF := hTail x (hRD.trans hx)
    exact (norm_sub_le _ _).trans (by linarith)
  change ‖(textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f - f).toBCF‖ ≤ _
  apply (BoundedContinuousFunction.norm_le (show 0 ≤ ε + C * (T : ℝ) by positivity)).mpr
  intro x
  change ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f x - f x‖ ≤ _
  by_cases hx : ‖x.2‖ ≤ D
  · have hp2 : ‖x.2‖ ^ 2 ≤ D ^ 2 := (sq_le_sq₀ (norm_nonneg x.2) hD).mpr hx
    have hh : K * (Cs * (1 + ‖x.2‖ ^ 2) * (T : ℝ)) ≤ K * (Cs * (1 + D ^ 2) * (T : ℝ)) :=
      mul_le_mul_of_nonneg_left
      (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left (add_le_add le_rfl hp2) hCs) T.property) hK
    have hb := hNear x
    dsimp only [C, e] at ⊢ hb
    have hn : 0 ≤ A * Cn * (T : ℝ) := by positivity
    nlinarith
  · have hb := hFar x (le_of_not_ge hx)
    have hn : 0 ≤ K * Cs * (1 + D ^ 2) * (T : ℝ) := by positivity
    dsimp only [C, e] at ⊢ hb
    nlinarith


/-- The actual original C0 contraction semigroup is strongly continuous at
zero in the genuine sup norm, using derived uniform initial-state estimates. -/
theorem textbookLangevinPeriodicC0Transition_strong_continuous_zero
    (hγ : 0 < γ) (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) :
    Tendsto (fun T : ℝ≥0 ↦ textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f)
      (𝓝 0) (𝓝 f) := by
  apply Metric.tendsto_nhds.mpr
  intro ε hε
  obtain ⟨C, hC, hb⟩ := textbookLangevinPeriodicC0Transition_small_time_norm_bound
    B P hB U hU hp L hF γ σ hγ f (ε / 2) (half_pos hε)
  have hExp : Continuous (fun T : ℝ≥0 ↦ Real.exp (-γ * (T : ℝ))) := by fun_prop
  have hHalf : (1 / 2 : ℝ) < Real.exp (-γ * ((0 : ℝ≥0) : ℝ)) := by norm_num
  have hDamping : ∀ᶠ T : ℝ≥0 in 𝓝 0, (1 / 2 : ℝ) < Real.exp (-γ * (T : ℝ)) :=
    hExp.continuousAt.tendsto.eventually (Ioi_mem_nhds hHalf)
  have hδ : 0 < (ε / 2) / (C + 1) := by positivity
  have hSmall : ∀ᶠ T : ℝ≥0 in 𝓝 0, (T : ℝ) < min 1 ((ε / 2) / (C + 1)) :=
    (continuous_subtype_val.tendsto (0 : ℝ≥0)).eventually
      (Iio_mem_nhds (lt_min zero_lt_one hδ))
  filter_upwards [hDamping, hSmall] with T he ht
  have ht1 : T ≤ 1 := by exact_mod_cast (lt_of_lt_of_le ht (min_le_left _ _)).le
  have htδ : (T : ℝ) < (ε / 2) / (C + 1) := lt_of_lt_of_le ht (min_le_right _ _)
  have hm := (lt_div_iff₀ (show 0 < C + 1 by positivity)).mp htδ
  rw [dist_eq_norm]
  exact (hb T ht1 he.le).trans_lt (by nlinarith [T.property])

private theorem strongC0_transition_variation
    (hγ : 0 < γ) (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) (S T : ℝ≥0) :
    ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ S f -
      textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f‖ ≤
      ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ (max S T - min S T) f - f‖ := by
  have hContract (R : ℝ≥0) (g : C₀(textbookLangevinPeriodicPhase N, ℝ)) :
      ‖textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ R g‖ ≤ ‖g‖ :=
    ((textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ R).le_opNorm g).trans
      ((mul_le_mul_of_nonneg_right
        (textbookLangevinPeriodicC0Transition_norm_le B P hB U hU hp L hF γ σ hγ R)
        (norm_nonneg g)).trans_eq (one_mul _))
  by_cases hST : S ≤ T
  · rw [max_eq_right hST, min_eq_left hST, norm_sub_rev]
    have hc := congrArg (fun A : C₀(textbookLangevinPeriodicPhase N, ℝ) →L[ℝ]
        C₀(textbookLangevinPeriodicPhase N, ℝ) ↦ A f)
      (textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ S (T - S))
    rw [add_tsub_cancel_of_le hST] at hc
    rw [hc, ContinuousLinearMap.comp_apply, ← map_sub]
    exact hContract S _
  · have hTS : T ≤ S := le_of_not_ge hST
    rw [max_eq_left hTS, min_eq_right hTS]
    have hc := congrArg (fun A : C₀(textbookLangevinPeriodicPhase N, ℝ) →L[ℝ]
        C₀(textbookLangevinPeriodicPhase N, ℝ) ↦ A f)
      (textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ T (S - T))
    rw [add_tsub_cancel_of_le hTS] at hc
    rw [hc, ContinuousLinearMap.comp_apply, ← map_sub]
    exact hContract T _

/-- Every original C0 orbit is genuinely continuous in all nonnegative times
in the sup norm. The true contraction semigroup propagates the proved norm
continuity at zero; no closed-generator or Gibbs premise is used. -/
theorem textbookLangevinPeriodicC0Transition_strong_continuous
    (hγ : 0 < γ) (f : C₀(textbookLangevinPeriodicPhase N, ℝ)) :
    Continuous (fun T : ℝ≥0 ↦ textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ T f) := by
  apply continuous_iff_continuousAt.mpr
  intro T
  have hδ : Continuous (fun S : ℝ≥0 ↦ max S T - min S T) := by fun_prop
  have hδ0 : Tendsto (fun S : ℝ≥0 ↦ max S T - min S T) (𝓝 T) (𝓝 0) := by
    simpa only [max_self, min_self, tsub_self] using (hδ.tendsto T)
  have hRight := (textbookLangevinPeriodicC0Transition_strong_continuous_zero
    B P hB U hU hp L hF γ σ hγ f).comp hδ0
  apply Metric.tendsto_nhds.mpr
  intro ε hε
  filter_upwards [Metric.tendsto_nhds.mp hRight ε hε] with S hs
  rw [dist_eq_norm] at hs ⊢
  exact (strongC0_transition_variation B P hB U hU hp L hF γ σ hγ f S T).trans_lt hs

end
end MolecularDynamics
