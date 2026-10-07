import MolecularDynamics.Chapter06.LangevinC2OperatorSupport

/-! Actual small-time moment controls with constants uniform over initial phase
and explicit quadratic initial-momentum growth. Necessary domination inputs for
weak generator balance; no exchange of limits and invariant-law integrals yet. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem growth_mean_square_le_second {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) [IsProbabilityMeasure P] (f : Ω → ℝ) (hf : MemLp f 2 P) :
    (∫ sample, f sample ∂P) ^ 2 ≤ ∫ sample, f sample ^ 2 ∂P := by
  have hv := variance_nonneg f P
  rw [variance_eq_sub hf] at hv
  simpa only [Pi.pow_apply] using (sub_nonneg.mp hv)

private theorem growth_integral_add_square {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (f g : Ω → ℝ) (hf : MemLp f 2 P) (hg : MemLp g 2 P) :
    (∫ sample, (f sample + g sample) ^ 2 ∂P) ≤
      2 * (∫ sample, f sample ^ 2 ∂P) + 2 * (∫ sample, g sample ^ 2 ∂P) := by
  have hu := (hf.integrable_sq.const_mul (2 : ℝ)).add (hg.integrable_sq.const_mul (2 : ℝ))
  have he := integral_mono_ae (hf.add hg).integrable_sq hu
    (Eventually.of_forall (fun sample ↦ by
      change (f sample + g sample) ^ 2 ≤ 2 * f sample ^ 2 + 2 * g sample ^ 2
      nlinarith [sq_nonneg (f sample - g sample)]))
  simpa only [Pi.add_apply, integral_add (hf.integrable_sq.const_mul (2 : ℝ))
    (hg.integrable_sq.const_mul (2 : ℝ)), integral_const_mul] using he

private theorem growth_coefficient (a b c p : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    a * p ^ 2 + b + c ≤ (a + b + c) * (1 + p ^ 2) := by
  nlinarith [mul_nonneg hb (sq_nonneg p), mul_nonneg hc (sq_nonneg p)]

private theorem growth_pi_norm_square {N : ℕ} (v : Fin N → ℝ) :
    ‖v‖ ^ 2 ≤ ∑ i : Fin N, v i ^ 2 := by
  by_cases h : Nonempty (Fin N)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin N ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun r : ℝ≥0 ↦ (r : ℝ)) hi
    rw [he, Real.norm_eq_abs, sq_abs]
    exact Finset.single_le_sum (fun j _ ↦ sq_nonneg (v j)) (Finset.mem_univ i)
  · have : IsEmpty (Fin N) := not_nonempty_iff.mp h
    simp [Pi.norm_def]

private theorem growth_phase_norm_square {N : ℕ} (v : textbookLangevinPhase N) :
    ‖v‖ ^ 2 ≤ (∑ i : Fin N, v.1 i ^ 2) + (∑ i : Fin N, v.2 i ^ 2) := by
  rw [Prod.norm_def]
  rcases le_total ‖v.1‖ ‖v.2‖ with h | h
  · rw [max_eq_right h]
    exact (growth_pi_norm_square v.2).trans
      (le_add_of_nonneg_left (Finset.sum_nonneg (fun i _ ↦ sq_nonneg (v.1 i))))
  · rw [max_eq_left h]
    exact (growth_pi_norm_square v.1).trans
      (le_add_of_nonneg_right (Finset.sum_nonneg (fun i _ ↦ sq_nonneg (v.2 i))))

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
private theorem growth_wiener_second (T : ℝ) (hT : 0 ≤ T) (i : Fin N) :
    (∫ sample, B T.toNNReal sample i ^ 2 ∂P) = T := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi := (hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two
  have hc := (covariance_eq_sub hi hi).symm.trans (hB.covariance i i T.toNNReal T.toNNReal)
  simpa only [Pi.mul_apply, hB.mean, mul_zero, sub_zero, ite_true, min_self,
    Real.coe_toNNReal T hT, pow_two] using hc

include hB hU hp in
/-- One true constant works for every initial phase and coordinate: the
actual expected momentum increment has quadratic time and initial-momentum growth. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_mean_square_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N, ∀ i : Fin N,
      (∫ sample, (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i ∂P) ^ 2 ≤ C * (1 + x.2 i ^ 2) * T ^ 2 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hb⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  let C := 3 * γ ^ 2 + 3 * M ^ 2 + (3 / 2 : ℝ) * σ ^ 2 * γ ^ 2
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  refine ⟨C, hC, fun T hT hT1 x i ↦ ?_⟩
  let R := fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
    x.2 i - σ * B T.toNNReal sample i
  let W := fun sample ↦ σ * B T.toNNReal sample i
  have hr := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hw := (hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.const_mul σ
  have he : (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
      x.2 i) = (fun sample ↦ R sample + W sample) := by
    funext sample
    exact (sub_add_cancel _ _).symm
  rw [he, integral_add (hr.integrable (by norm_num)) (hw.integrable (by norm_num))]
  simp only [integral_const_mul, hB.mean, mul_zero, add_zero]
  have hm := growth_mean_square_le_second P R hr
  have ht3 : T ^ 3 ≤ T ^ 2 := pow_le_pow_of_le_one hT hT1 (by omega)
  have ht3' := mul_le_mul_of_nonneg_left ht3 (show 0 ≤ (3 / 2 : ℝ) * σ ^ 2 * γ ^ 2 by positivity)
  have ha := growth_coefficient (3 * γ ^ 2) (3 * M ^ 2)
    ((3 / 2 : ℝ) * σ ^ 2 * γ ^ 2) (x.2 i) (by positivity) (by positivity) (by positivity)
  have hac := mul_le_mul_of_nonneg_right ha (sq_nonneg T)
  dsimp only [C] at *
  exact hm.trans (by dsimp only [R] at *; nlinarith [hb T hT x i])

include hB hU hp in
/-- The actual expected configuration-lift increment has the same true
uniform quadratic-time, quadratic-initial-momentum control. -/
theorem textbookLangevinPeriodicConfigurationLift_mean_square_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N, ∀ i : Fin N,
      (∫ sample, textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i ∂P) ^ 2 ≤ C * (1 + x.2 i ^ 2) * T ^ 2 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hb⟩ := textbookLangevinPeriodicConfigurationLift_residual_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  let C := 12 * γ ^ 2 + 2 + 12 * M ^ 2 + 2 * σ ^ 2 + 6 * σ ^ 2 * γ ^ 2
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  refine ⟨C, hC, fun T hT hT1 x i ↦ ?_⟩
  let R := fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
    textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i
  have hr := textbookLangevinPeriodicConfigurationLift_residual_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have he : (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i) = (fun sample ↦ R sample + T * x.2 i) := by
    funext sample
    exact (sub_add_cancel _ _).symm
  rw [he, integral_add (hr.integrable (by norm_num)) (integrable_const _),
    integral_const, probReal_univ, one_smul]
  have hm := growth_mean_square_le_second P R hr
  have ht3 : T ^ 3 ≤ T ^ 2 := pow_le_pow_of_le_one hT hT1 (by omega)
  have ht4 : T ^ 4 ≤ T ^ 2 := pow_le_pow_of_le_one hT hT1 (by omega)
  have ht5 : T ^ 5 ≤ T ^ 2 := pow_le_pow_of_le_one hT hT1 (by omega)
  have ha4 := mul_le_mul_of_nonneg_left ht4 (show 0 ≤ 6 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) by positivity)
  have ha3 := mul_le_mul_of_nonneg_left ht3 (sq_nonneg σ)
  have ha5 := mul_le_mul_of_nonneg_left ht5 (show 0 ≤ 3 * σ ^ 2 * γ ^ 2 by positivity)
  have hcoef := growth_coefficient (12 * γ ^ 2 + 2) (12 * M ^ 2)
    (2 * σ ^ 2 + 6 * σ ^ 2 * γ ^ 2) (x.2 i) (by positivity) (by positivity) (by positivity)
  have hac := mul_le_mul_of_nonneg_right hcoef (sq_nonneg T)
  have hs := sq_nonneg ((∫ sample, R sample ∂P) - T * x.2 i)
  dsimp only [C, R] at *
  nlinarith [hb T hT x i]

include hB hU hp in
/-- The original coordinate increment second moments have one constant for
all initial phases, with explicit quadratic initial-momentum growth. -/
theorem textbookLangevinPeriodicRealIncrements_coordinate_second_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N, ∀ i : Fin N,
      (∫ sample, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i) ^ 2 ∂P) ≤ C * (1 + x.2 i ^ 2) * T ∧
      (∫ sample, (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ∂P) ≤ C * (1 + x.2 i ^ 2) * T := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hpB⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨S, _, hqB⟩ := textbookLangevinPeriodicConfigurationLift_residual_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  let Cp := 6 * γ ^ 2 + 6 * M ^ 2 + 3 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2
  let Cq := 12 * γ ^ 2 + 2 + 12 * S ^ 2 + 2 * σ ^ 2 + 6 * σ ^ 2 * γ ^ 2
  have hCp : 0 ≤ Cp := by dsimp only [Cp]; positivity
  have hCq : 0 ≤ Cq := by dsimp only [Cq]; positivity
  refine ⟨Cp + Cq, add_nonneg hCp hCq, fun T hT hT1 x i ↦ ?_⟩
  let Rp := fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
    x.2 i - σ * B T.toNNReal sample i
  let W := fun sample ↦ σ * B T.toNNReal sample i
  let Rq := fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
    textbookLangevinPeriodicRepresentative x.1 i - T * x.2 i
  have hpR := textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hW := (hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp_two.const_mul σ
  have hqR := textbookLangevinPeriodicConfigurationLift_residual_memLp
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hpp := growth_integral_add_square P Rp W hpR hW
  have hqq := growth_integral_add_square P Rq (fun _ ↦ T * x.2 i) hqR (memLp_const _)
  have hep : (fun sample ↦ Rp sample + W sample) =
      (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) :=
    funext (fun _ ↦ sub_add_cancel _ _)
  have heq : (fun sample ↦ Rq sample + T * x.2 i) =
      (fun sample ↦ textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) :=
    funext (fun _ ↦ sub_add_cancel _ _)
  have hep' (sample : Ω) := congrFun hep sample
  have heq' (sample : Ω) := congrFun heq sample
  simp_rw [hep'] at hpp
  simp_rw [heq'] at hqq
  have hw2 : (∫ sample, W sample ^ 2 ∂P) = σ ^ 2 * T := by
    simp only [W, mul_pow, integral_const_mul, growth_wiener_second B P hB T hT i]
  rw [hw2] at hpp
  rw [integral_const, probReal_univ, one_smul] at hqq
  have ht2 : T ^ 2 ≤ T := by nlinarith
  have ht3 : T ^ 3 ≤ T := by simpa using pow_le_pow_of_le_one hT hT1 (by omega : 1 ≤ 3)
  have ht4 : T ^ 4 ≤ T := by simpa using pow_le_pow_of_le_one hT hT1 (by omega : 1 ≤ 4)
  have ht5 : T ^ 5 ≤ T := by simpa using pow_le_pow_of_le_one hT hT1 (by omega : 1 ≤ 5)
  have hp2 := mul_le_mul_of_nonneg_left ht2 (show 0 ≤ 3 * (γ ^ 2 * x.2 i ^ 2 + M ^ 2) by positivity)
  have hp3 := mul_le_mul_of_nonneg_left ht3 (show 0 ≤ (3 / 2 : ℝ) * σ ^ 2 * γ ^ 2 by positivity)
  have hq4 := mul_le_mul_of_nonneg_left ht4 (show 0 ≤ 6 * (γ ^ 2 * x.2 i ^ 2 + S ^ 2) by positivity)
  have hq3 := mul_le_mul_of_nonneg_left ht3 (sq_nonneg σ)
  have hq5 := mul_le_mul_of_nonneg_left ht5 (show 0 ≤ 3 * σ ^ 2 * γ ^ 2 by positivity)
  have hqp := mul_le_mul_of_nonneg_left ht2 (sq_nonneg (x.2 i))
  have hpc := mul_le_mul_of_nonneg_right
    (growth_coefficient (6 * γ ^ 2) (6 * M ^ 2) (3 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2)
      (x.2 i) (by positivity) (by positivity) (by positivity)) hT
  have hqc := mul_le_mul_of_nonneg_right
    (growth_coefficient (12 * γ ^ 2 + 2) (12 * S ^ 2) (2 * σ ^ 2 + 6 * σ ^ 2 * γ ^ 2)
      (x.2 i) (by positivity) (by positivity) (by positivity)) hT
  have hpn : 0 ≤ Cp * (1 + x.2 i ^ 2) * T := by positivity
  have hqn : 0 ≤ Cq * (1 + x.2 i ^ 2) * T := by positivity
  dsimp only [Cp, Cq, Rp, Rq] at *
  constructor
  · nlinarith [hpB T hT x i]
  · nlinarith [hqB T hT x i]

include hB hU hp in
/-- The genuine full real phase second moment is bounded by C(1+norm p0²)T
with one constant for all initial phases. This is a true domination input,
rather than an initial-state-dependent existential constant. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_second_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N,
      (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 2 ∂P) ≤
        C * (1 + ‖x.2‖ ^ 2) * T := by
  obtain ⟨C, hC, hb⟩ := textbookLangevinPeriodicRealIncrements_coordinate_second_growth_bound
    B P hB U hU hp L hF γ σ hγ
  refine ⟨2 * N * C, by positivity, fun T hT hT1 x ↦ ?_⟩
  have hi (i : Fin N) := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_power_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x i 1
  have hq (i : Fin N) : Integrable (fun sample ↦
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 2) P := by
    simpa only [mul_one, Real.norm_eq_abs, sq_abs] using (hi i).2
  have hpI (i : Fin N) : Integrable (fun sample ↦
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) ^ 2) P := by
    simpa only [mul_one, Real.norm_eq_abs, sq_abs] using (hi i).1
  have hQ := integrable_finsetSum Finset.univ (fun i _ ↦ hq i)
  have hP := integrable_finsetSum Finset.univ (fun i _ ↦ hpI i)
  have hint : Integrable (fun sample ↦
      ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 2) P := by
    simpa only [mul_one] using textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
      B P hB U hU hp L hF γ σ hγ T hT hT1 x 1 (by norm_num)
  have he := integral_mono_ae hint (hQ.add hP)
    (Eventually.of_forall (fun sample ↦ growth_phase_norm_square
      (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)))
  change (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 2 ∂P) ≤
    (∫ sample, (∑ i : Fin N,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 2) +
      (∑ i : Fin N, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i) ^ 2) ∂P) at he
  rw [integral_add hQ hP, integral_finsetSum Finset.univ (fun i _ ↦ hq i),
    integral_finsetSum Finset.univ (fun i _ ↦ hpI i)] at he
  have hc (i : Fin N) : C * (1 + x.2 i ^ 2) * T ≤ C * (1 + ‖x.2‖ ^ 2) * T := by
    have hnorm : x.2 i ^ 2 ≤ ‖x.2‖ ^ 2 := by
      simpa only [Real.norm_eq_abs, sq_abs] using
        (sq_le_sq₀ (norm_nonneg (x.2 i)) (norm_nonneg x.2)).mpr (norm_le_pi_norm x.2 i)
    exact mul_le_mul_of_nonneg_right
      (mul_le_mul_of_nonneg_left (add_le_add le_rfl hnorm) hC) hT
  have hqsum := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin N))) ↦
    (hb T hT hT1 x i).2.trans (hc i))
  have hpsum := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin N))) ↦
    (hb T hT hT1 x i).1.trans (hc i))
  calc
    _ ≤ _ := he
    _ ≤ (∑ _i : Fin N, C * (1 + ‖x.2‖ ^ 2) * T) +
        (∑ _i : Fin N, C * (1 + ‖x.2‖ ^ 2) * T) := add_le_add hqsum hpsum
    _ = _ := by simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]; ring

end
end MolecularDynamics
