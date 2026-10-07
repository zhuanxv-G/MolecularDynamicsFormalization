import MolecularDynamics.Chapter06.LangevinSmallTimePosition

/-! Genuine actual fourth moments needed for the original Langevin generator's
Taylor expectation remainder. No process moment or infinitesimal limit is assumed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem fourth_integral_cauchy_square (f : ℝ → ℝ) (t : ℝ) (ht : 0 ≤ t)
    (hf : Continuous f) :
    (∫ s in 0..t, f s) ^ 2 ≤ t * (∫ s in 0..t, f s ^ 2) := by
  rcases ht.eq_or_lt with he | ht
  · subst t
    simp
  let I := ∫ s in 0..t, f s
  let J := ∫ s in 0..t, f s ^ 2
  let m := I / t
  have hi : IntervalIntegrable f volume 0 t := hf.intervalIntegrable 0 t
  have hj : IntervalIntegrable (fun s ↦ f s ^ 2) volume 0 t := (hf.pow 2).intervalIntegrable 0 t
  have he : (∫ s in 0..t, (f s - m) ^ 2) = J - (2 * m) * I + m ^ 2 * t := by
    have hp : (fun s ↦ (f s - m) ^ 2) = (fun s ↦ (f s ^ 2 - (2 * m) * f s) + m ^ 2) := by
      funext s
      ring
    rw [hp, intervalIntegral.integral_add (hj.sub (hi.const_mul (2 * m))) intervalIntegrable_const,
      intervalIntegral.integral_sub hj (hi.const_mul (2 * m)), intervalIntegral.integral_const_mul,
      intervalIntegral.integral_const]
    simp only [smul_eq_mul, sub_zero]
    dsimp [I, J]
    ring
  have hn : 0 ≤ ∫ s in 0..t, (f s - m) ^ 2 :=
    intervalIntegral.integral_nonneg_of_ae ht.le (Eventually.of_forall (fun s ↦ sq_nonneg _))
  have hmul := mul_nonneg ht.le hn
  rw [he] at hmul
  have hh : t * (J - (2 * m) * I + m ^ 2 * t) = t * J - I ^ 2 := by
    dsimp [m]
    field_simp
    ring
  rw [hh] at hmul
  exact sub_nonneg.mp hmul

private theorem fourth_noise_coordinate_formula {N : ℕ} (γ σ t : ℝ)
    (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    textbookLangevinDampedNoise γ σ W t i =
      σ * (W t i - γ * (∫ s in 0..t, Real.exp (-γ * (t - s)) * W s i)) := by
  have hc : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s)) • W s) :=
    (by fun_prop : Continuous (fun s : ℝ ↦ Real.exp (-γ * (t - s)))).smul hW
  have hf : IntervalIntegrable (fun s : ℝ ↦ Real.exp (-γ * (t - s)) • W s) volume 0 t := hc.intervalIntegrable 0 t
  have he := (ContinuousLinearMap.proj i : (Fin N → ℝ) →L[ℝ] ℝ).intervalIntegral_comp_comm hf
  simp only [ContinuousLinearMap.proj_apply, Pi.smul_apply, smul_eq_mul] at he
  change σ * (W t i - γ * ((∫ s in 0..t, Real.exp (-γ * (t - s)) • W s) i)) = _
  rw [← he]


private theorem fourth_noise_remainder_path_bound {N : ℕ} (γ σ t : ℝ)
    (hγ : 0 ≤ γ) (ht : 0 ≤ t) (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    (textbookLangevinDampedNoise γ σ W t i - σ * W t i) ^ 2 ≤
      σ ^ 2 * γ ^ 2 * t * (∫ s in 0..t, W s i ^ 2) := by
  let f : ℝ → ℝ := fun s ↦ Real.exp (-γ * (t - s)) * W s i
  have hw : Continuous (fun s ↦ W s i) := (continuous_apply i).comp hW
  have hf : Continuous f := by dsimp [f]; fun_prop
  have hi := fourth_integral_cauchy_square f t ht hf
  have hb : (∫ s in 0..t, f s ^ 2) ≤ ∫ s in 0..t, W s i ^ 2 := by
    apply intervalIntegral.integral_mono_on ht ((hf.pow 2).intervalIntegrable 0 t)
      ((hw.pow 2).intervalIntegrable 0 t)
    intro s hs
    have he : Real.exp (-γ * (t - s)) ≤ 1 := Real.exp_le_one_iff.mpr (by nlinarith [hs.2])
    have he2 : Real.exp (-γ * (t - s)) ^ 2 ≤ 1 :=
      pow_le_one₀ (Real.exp_pos _).le he
    dsimp [f]
    rw [mul_pow]
    simpa only [one_mul] using mul_le_mul_of_nonneg_right he2 (sq_nonneg (W s i))
  have hi' := hi.trans (mul_le_mul_of_nonneg_left hb ht)
  calc
    _ = (σ ^ 2 * γ ^ 2) * (∫ s in 0..t, f s) ^ 2 := by
      rw [fourth_noise_coordinate_formula γ σ t W hW i]
      dsimp [f]
      ring
    _ ≤ (σ ^ 2 * γ ^ 2) * (t * (∫ s in 0..t, W s i ^ 2)) :=
      mul_le_mul_of_nonneg_left hi' (mul_nonneg (sq_nonneg _) (sq_nonneg _))
    _ = _ := by ring


private theorem fourth_norm_real (a : ℝ) : ‖a‖ ^ 4 = a ^ 4 := by
  calc
    _ = (‖a‖ ^ 2) ^ 2 := by ring
    _ = (a ^ 2) ^ 2 := by rw [Real.norm_eq_abs, sq_abs]
    _ = _ := by ring

private theorem fourth_square_three_bound (a b c d : ℝ)
    (h : a ^ 2 ≤ b + c + d) :
    a ^ 4 ≤ 3 * b ^ 2 + 3 * c ^ 2 + 3 * d ^ 2 := by
  calc
    _ = (a ^ 2) ^ 2 := by ring
    _ ≤ (b + c + d) ^ 2 := pow_le_pow_left₀ (sq_nonneg a) h 2
    _ ≤ _ := by nlinarith [sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d)]

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The fourth moment of an original Wiener coordinate has its genuine Gaussian
time scaling, with the standard Gaussian moment already derived as finite. -/
theorem textbookWienerVector_coordinate_fourth_moment (t : ℝ) (ht : 0 ≤ t) (i : Fin N) :
    (∫ sample, B t.toNNReal sample i ^ 4 ∂P) =
      t ^ 2 * textbookBrownianStandardGaussianFourthMoment := by
  have hc : Continuous (fun z : ℝ ↦ ‖z‖ ^ 4) := by fun_prop
  have he : (∫ sample, ‖B t.toNNReal sample i‖ ^ 4 ∂P) =
      t ^ 2 * textbookBrownianStandardGaussianFourthMoment := by
    calc
      _ = ∫ z : ℝ, ‖z‖ ^ 4 ∂gaussianReal 0 t.toNNReal :=
        ((textbookWienerVector_coordinate B P hB i).hasLaw_eval t.toNNReal).integral_comp hc.aestronglyMeasurable
      _ = ∫ z : ℝ, ‖Real.sqrt (t.toNNReal : ℝ) * z‖ ^ 4 ∂gaussianReal 0 1 := by
        rw [← textbookBrownianGaussian_time_sqrt_map t.toNNReal]
        exact integral_map (by fun_prop) hc.aestronglyMeasurable
      _ = Real.sqrt t ^ 4 * textbookBrownianStandardGaussianFourthMoment := by
        simp_rw [Real.coe_toNNReal t ht, norm_mul, Real.norm_of_nonneg (Real.sqrt_nonneg _), mul_pow]
        exact integral_const_mul _ _
      _ = _ := by
        rw [show (4 : ℕ) = 2 * 2 by decide, pow_mul, Real.sq_sqrt ht]
  simpa only [fourth_norm_real] using he

include hB in
/-- The square of the genuine unit-time Wiener energy is integrable, by actual
continuous-path Jensen domination with the original fourth-power time integral. -/
theorem textbookWienerVector_coordinate_unit_time_energy_square_integrable (i : Fin N) :
    Integrable (fun sample ↦ (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ 2) P := by
  have hj := textbookWienerVector_coordinate_time_square_integrable B P hB 1 (by norm_num) i
  have hk := textbookWienerVector_coordinate_time_even_norm_power_integrable B P hB 1 (by norm_num) i 2
  have ha := (hj.aestronglyMeasurable.aemeasurable.pow_const 2).aestronglyMeasurable
  apply hk.mono_nonneg ha (Eventually.of_forall (fun _ ↦ sq_nonneg _))
  filter_upwards [hB.cont] with sample hc
  have hw : Continuous (fun s : ℝ ↦ B s.toNNReal sample i ^ 2) :=
    (((continuous_apply i).comp hc).comp continuous_real_toNNReal).pow 2
  have hh := fourth_integral_cauchy_square (fun s : ℝ ↦ B s.toNNReal sample i ^ 2) 1 (by norm_num) hw
  have he : (fun s : ℝ ↦ (B s.toNNReal sample i ^ 2) ^ 2) =
      (fun s : ℝ ↦ ‖B s.toNNReal sample i‖ ^ (2 * 2)) := by
    funext s
    rw [show (2 * 2 : ℕ) = 4 by decide, fourth_norm_real]
    ring
  simpa only [one_mul, he] using hh

variable (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
private theorem fourth_actual_coordinate_path_bounds (hγ : 0 < γ) :
    ∃ S : ℝ, 0 ≤ S ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t → t ≤ 1 → ∀ i : Fin N,
        ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i) ^ 4 ≤
          3 * (6 * (γ ^ 2 * x.2 i ^ 2 + S)) ^ 2 * t ^ 4 +
          3 * (6 * σ ^ 2 * γ ^ 2) ^ 2 * t ^ 2 *
            (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ 2 +
          3 * (2 * σ ^ 2) ^ 2 * B t.toNNReal sample i ^ 4 ∧
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
            textbookLangevinPeriodicRepresentative x.1 i) ^ 4 ≤
          12 * (6 * (γ ^ 2 * x.2 i ^ 2 + S)) ^ 2 * t ^ 8 +
          12 * (6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2) ^ 2 * t ^ 2 *
            (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ 2 +
          12 * t ^ 4 * x.2 i ^ 4 := by
  obtain ⟨M1, _hM1, hpr⟩ :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_Brownian_remainder_square_bound_ae
      B P hB U hU hp L hF γ σ hγ
  obtain ⟨M2, _hM2, hqr⟩ := textbookLangevinPeriodicConfigurationLift_residual_square_bound_ae
    B P hB U hU hp L hF γ σ hγ
  let S := M1 ^ 2 + M2 ^ 2
  refine ⟨S, add_nonneg (sq_nonneg _) (sq_nonneg _), fun x ↦ ?_⟩
  filter_upwards [hpr x, hqr x, hB.cont] with sample hpr hqr hc
  intro t ht ht1 i
  let W : ℝ → (Fin N → ℝ) := fun s ↦ B s.toNNReal sample
  let J : ℝ → ℝ := fun s ↦ ∫ r in 0..s, W r i ^ 2
  let A := 6 * (γ ^ 2 * x.2 i ^ 2 + S)
  let D := 6 * σ ^ 2 * γ ^ 2
  let C := 6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2
  have hW : Continuous W := hc.comp continuous_real_toNNReal
  have hWi : Continuous (fun s ↦ W s i ^ 2) := ((continuous_apply i).comp hW).pow 2
  have hJ0 : 0 ≤ J t := intervalIntegral.integral_nonneg ht (fun _ _ ↦ sq_nonneg _)
  have hJ1 : 0 ≤ J 1 := intervalIntegral.integral_nonneg (by norm_num) (fun _ _ ↦ sq_nonneg _)
  have hJle : J t ≤ J 1 :=
    intervalIntegral.integral_mono_interval le_rfl ht ht1
      (Eventually.of_forall (fun _ ↦ sq_nonneg _)) (hWi.intervalIntegrable (μ := volume) 0 1)
  have hpbase := hpr t ht i
  have hn := fourth_noise_remainder_path_bound γ σ t hγ.le ht W hW i
  have hn' := mul_le_mul_of_nonneg_left hJle (show 0 ≤ σ ^ 2 * γ ^ 2 * t by positivity)
  have hM : M1 ^ 2 * t ^ 2 ≤ S * t ^ 2 := by dsimp only [S]; nlinarith [sq_nonneg M2]
  have hp2 :
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i) ^ 2 ≤
        A * t ^ 2 + D * t * J 1 + (2 * σ ^ 2) * W t i ^ 2 := by
    dsimp only [A, D]
    dsimp only [W, J] at hn hn' ⊢
    nlinarith [sq_nonneg ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i -
      x.2 i - 2 * σ * B t.toNNReal sample i)]
  have hqbase := hqr t ht i
  have ht3 : t ^ 3 ≤ t := by nlinarith [sq_nonneg t, mul_nonneg ht (sub_nonneg.mpr ht1)]
  have hqcoeff : (6 * σ ^ 2 * γ ^ 2 * t ^ 3 + 2 * σ ^ 2 * t) * J t ≤ C * t * J 1 := by
    have h1 : 6 * σ ^ 2 * γ ^ 2 * t ^ 3 + 2 * σ ^ 2 * t ≤ C * t := by
      have hm := mul_le_mul_of_nonneg_left ht3 (show 0 ≤ 6 * σ ^ 2 * γ ^ 2 by positivity)
      dsimp only [C]
      nlinarith
    exact mul_le_mul h1 hJle hJ0 (show 0 ≤ C * t by dsimp only [C]; positivity)
  have hMq : M2 ^ 2 * t ^ 4 ≤ S * t ^ 4 := by
    dsimp only [S]
    nlinarith [sq_nonneg M1, pow_nonneg ht 4]
  have hqres :
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i - t * x.2 i) ^ 2 ≤ A * t ^ 4 + C * t * J 1 := by
    dsimp only [A]
    dsimp only [J, W] at hqcoeff ⊢
    nlinarith
  have hq2 :
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ≤
          2 * A * t ^ 4 + 2 * C * t * J 1 + 2 * t ^ 2 * x.2 i ^ 2 := by
    nlinarith [sq_nonneg (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
      textbookLangevinPeriodicRepresentative x.1 i - 2 * t * x.2 i)]
  have hA : 0 ≤ A := by dsimp only [A, S]; positivity
  have hD : 0 ≤ D := by dsimp only [D]; positivity
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  constructor
  · have hh := fourth_square_three_bound
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i)
      (A * t ^ 2) (D * t * J 1) ((2 * σ ^ 2) * W t i ^ 2)
      hp2
    dsimp only [A, D, J, W] at hh
    calc
      _ ≤ _ := hh
      _ = _ := by ring
  · have hh := fourth_square_three_bound
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i)
      (2 * A * t ^ 4) (2 * C * t * J 1) (2 * t ^ 2 * x.2 i ^ 2)
      hq2
    dsimp only [A, C, J, W] at hh
    calc
      _ ≤ _ := hh
      _ = _ := by ring


include hB hU hp in
/-- Each actual momentum increment fourth power is integrable, from genuine
finite-order moments of the same process rather than a moment premise. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_fourth_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Integrable (fun sample ↦ ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
      x.2 i) ^ 4) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hv : MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2) 4 P := by
    simpa using textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp_even
      B P hB U hU hp L hF γ σ T hγ hT x 2 (by norm_num)
  have hm := (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ x T hT).snd.eval i
  have hi : MemLp (fun sample ↦ (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) 4 P :=
    hv.norm.mono' hm.aestronglyMeasurable (Eventually.of_forall (fun _ ↦ norm_le_pi_norm _ i))
  have hr := (hi.sub (memLp_const (x.2 i))).integrable_norm_pow (by norm_num : (4 : ℕ) ≠ 0)
  simpa only [Pi.sub_apply, fourth_norm_real] using hr

include hB hU hp in
/-- The actual real configuration increment fourth power is integrable locally
in time by original Wiener-energy domination. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_fourth_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Integrable (fun sample ↦ (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
      textbookLangevinPeriodicRepresentative x.1 i) ^ 4) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨S, _hS, hb⟩ := fourth_actual_coordinate_path_bounds B P hB U hU hp L hF γ σ hγ
  have hj := textbookWienerVector_coordinate_unit_time_energy_square_integrable B P hB i
  let A := 6 * (γ ^ 2 * x.2 i ^ 2 + S)
  let C := 6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2
  have hu : Integrable (fun sample ↦ 12 * A ^ 2 * T ^ 8 +
      12 * C ^ 2 * T ^ 2 * (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ 2 +
      12 * T ^ 4 * x.2 i ^ 4) P :=
    ((integrable_const _).add (hj.const_mul _)).add (integrable_const _)
  have hm := ((textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).fst.eval i).sub
    (aemeasurable_const (b := textbookLangevinPeriodicRepresentative x.1 i))
  exact hu.mono_nonneg (hm.pow_const 4).aestronglyMeasurable
    (Eventually.of_forall (fun _ ↦ by positivity))
    ((hb x).mono (fun _ hs ↦ (hs T hT hT1 i).2))

include hB hU hp in
/-- A true local O(T²) fourth-moment bound holds for both actual configuration
and momentum increments. All constants come from the original process. -/
theorem textbookLangevinPeriodicRealIncrements_coordinate_fourth_moment_bound
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      (∫ sample, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i) ^ 4 ∂P) ≤ C * T ^ 2 ∧
      (∫ sample, (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 4 ∂P) ≤ C * T ^ 2 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨S, _hS, hb⟩ := fourth_actual_coordinate_path_bounds B P hB U hU hp L hF γ σ hγ
  let A := 6 * (γ ^ 2 * x.2 i ^ 2 + S)
  let D := 6 * σ ^ 2 * γ ^ 2
  let E := 2 * σ ^ 2
  let F := 6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2
  let J := fun sample ↦ (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ 2
  let j := ∫ sample, J sample ∂P
  let m := textbookBrownianStandardGaussianFourthMoment
  let Cp := 3 * A ^ 2 + 3 * D ^ 2 * j + 3 * E ^ 2 * m
  let Cq := 12 * A ^ 2 + 12 * F ^ 2 * j + 12 * x.2 i ^ 4
  have hj : Integrable J P := textbookWienerVector_coordinate_unit_time_energy_square_integrable B P hB i
  have hj0 : 0 ≤ j := integral_nonneg (fun _ ↦ sq_nonneg _)
  have hm0 : 0 ≤ m := textbookBrownianStandardGaussianFourthMoment_nonneg
  have hp0 : 0 ≤ Cp := by dsimp only [Cp]; positivity
  have hq0 : 0 ≤ Cq := by dsimp only [Cq]; positivity
  refine ⟨Cp + Cq, add_nonneg hp0 hq0, fun t ht ht1 ↦ ?_⟩
  have hb4 : Integrable (fun sample ↦ B t.toNNReal sample i ^ 4) P := by
    have hlp : MemLp (fun sample ↦ B t.toNNReal sample i) 4 P :=
      (hB.gaussian.hasGaussianLaw_eval ⟨i, t.toNNReal⟩).memLp (by norm_num)
    simpa only [fourth_norm_real] using hlp.integrable_norm_pow (by norm_num : (4 : ℕ) ≠ 0)
  have hpi := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_fourth_integrable
    B P hB U hU hp L hF γ σ hγ t ht x i
  have hqi := textbookLangevinPeriodicConfigurationLift_increment_fourth_integrable
    B P hB U hU hp L hF γ σ hγ t ht ht1 x i
  have hpC : Integrable (fun _sample : Ω ↦ 3 * A ^ 2 * t ^ 4) P := integrable_const _
  have hpJ : Integrable (fun sample ↦ 3 * D ^ 2 * t ^ 2 * J sample) P := hj.const_mul _
  have hpB : Integrable (fun sample ↦ 3 * E ^ 2 * B t.toNNReal sample i ^ 4) P := hb4.const_mul _
  have hpu : Integrable (fun sample ↦ 3 * A ^ 2 * t ^ 4 +
      3 * D ^ 2 * t ^ 2 * J sample + 3 * E ^ 2 * B t.toNNReal sample i ^ 4) P :=
    (hpC.add hpJ).add hpB
  have hpp := integral_mono_ae hpi hpu ((hb x).mono (fun _ hs ↦ (hs t ht ht1 i).1))
  rw [integral_add (f := fun sample ↦ 3 * A ^ 2 * t ^ 4 + 3 * D ^ 2 * t ^ 2 * J sample)
    (g := fun sample ↦ 3 * E ^ 2 * B t.toNNReal sample i ^ 4) (hpC.add hpJ) hpB,
    integral_add (f := fun _sample : Ω ↦ 3 * A ^ 2 * t ^ 4)
      (g := fun sample ↦ 3 * D ^ 2 * t ^ 2 * J sample) hpC hpJ,
    integral_const, probReal_univ, one_smul, integral_const_mul, integral_const_mul,
    textbookWienerVector_coordinate_fourth_moment B P hB t ht i] at hpp
  have hqC : Integrable (fun _sample : Ω ↦ 12 * A ^ 2 * t ^ 8) P := integrable_const _
  have hqJ : Integrable (fun sample ↦ 12 * F ^ 2 * t ^ 2 * J sample) P := hj.const_mul _
  have hqP : Integrable (fun _sample : Ω ↦ 12 * t ^ 4 * x.2 i ^ 4) P := integrable_const _
  have hqu : Integrable (fun sample ↦ 12 * A ^ 2 * t ^ 8 +
      12 * F ^ 2 * t ^ 2 * J sample + 12 * t ^ 4 * x.2 i ^ 4) P :=
    (hqC.add hqJ).add hqP
  have hqq := integral_mono_ae hqi hqu ((hb x).mono (fun _ hs ↦ (hs t ht ht1 i).2))
  rw [integral_add (f := fun sample ↦ 12 * A ^ 2 * t ^ 8 + 12 * F ^ 2 * t ^ 2 * J sample)
    (g := fun _sample : Ω ↦ 12 * t ^ 4 * x.2 i ^ 4) (hqC.add hqJ) hqP,
    integral_add (f := fun _sample : Ω ↦ 12 * A ^ 2 * t ^ 8)
      (g := fun sample ↦ 12 * F ^ 2 * t ^ 2 * J sample) hqC hqJ,
    integral_const, integral_const, probReal_univ, one_smul, one_smul, integral_const_mul] at hqq
  have ht4 : t ^ 4 ≤ t ^ 2 := pow_le_pow_of_le_one ht ht1 (by norm_num : (2 : ℕ) ≤ 4)
  have ht8 : t ^ 8 ≤ t ^ 2 := pow_le_pow_of_le_one ht ht1 (by norm_num : (2 : ℕ) ≤ 8)
  have hpa := mul_le_mul_of_nonneg_left ht4 (show 0 ≤ 3 * A ^ 2 by positivity)
  have hqa := mul_le_mul_of_nonneg_left ht8 (show 0 ≤ 12 * A ^ 2 by positivity)
  have hqp := mul_le_mul_of_nonneg_left ht4 (show 0 ≤ 12 * x.2 i ^ 4 by positivity)
  have hpt : 0 ≤ Cq * t ^ 2 := mul_nonneg hq0 (sq_nonneg t)
  have hqt : 0 ≤ Cp * t ^ 2 := mul_nonneg hp0 (sq_nonneg t)
  constructor
  · dsimp only [Cp, Cq, j, m] at *
    nlinarith
  · dsimp only [Cp, Cq, j] at *
    nlinarith

include hB hU hp in
/-- The actual momentum fourth moment divided by time tends to zero. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_fourth_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) ^ 4 ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _hC, hb⟩ := textbookLangevinPeriodicRealIncrements_coordinate_fourth_moment_bound
    B P hB U hU hp L hF γ σ hγ x i
  have hc : Continuous (fun t : ℝ ↦ C * t) := by fun_prop
  apply squeeze_zero' _ _ (by simpa using (hc.tendsto 0).mono_left nhdsWithin_le_nhds)
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ by positivity)) ht.le
  · filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))]
      with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    calc
      _ ≤ C * t ^ 2 / t := div_le_div_of_nonneg_right (hb t ht0.le ht1'.le).1 ht0.le
      _ = _ := by field_simp

include hB hU hp in
/-- The same continuous real configuration increment fourth moment divided by time tends to zero. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_fourth_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 4 ∂P) / T) (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _hC, hb⟩ := textbookLangevinPeriodicRealIncrements_coordinate_fourth_moment_bound
    B P hB U hU hp L hF γ σ hγ x i
  have hc : Continuous (fun t : ℝ ↦ C * t) := by fun_prop
  apply squeeze_zero' _ _ (by simpa using (hc.tendsto 0).mono_left nhdsWithin_le_nhds)
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ by positivity)) ht.le
  · filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))]
      with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    calc
      _ ≤ C * t ^ 2 / t := div_le_div_of_nonneg_right (hb t ht0.le ht1'.le).2 ht0.le
      _ = _ := by field_simp


private theorem fourth_pi_norm_le_sum {N : ℕ} (v : Fin N → ℝ) :
    ‖v‖ ^ 4 ≤ ∑ i : Fin N, v i ^ 4 := by
  by_cases h : Nonempty (Fin N)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin N ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun r : ℝ≥0 ↦ (r : ℝ)) hi
    rw [he, fourth_norm_real]
    exact Finset.single_le_sum (fun j _ ↦ show 0 ≤ v j ^ 4 by positivity) (Finset.mem_univ i)
  · have : IsEmpty (Fin N) := not_nonempty_iff.mp h
    simp [Pi.norm_def]

private theorem fourth_phase_norm_le_sum {N : ℕ} (v : textbookLangevinPhase N) :
    ‖v‖ ^ 4 ≤ (∑ i : Fin N, v.1 i ^ 4) + (∑ i : Fin N, v.2 i ^ 4) := by
  rw [Prod.norm_def]
  rcases le_total ‖v.1‖ ‖v.2‖ with h | h
  · rw [max_eq_right h]
    exact (fourth_pi_norm_le_sum v.2).trans
      (le_add_of_nonneg_left (Finset.sum_nonneg (fun i _ ↦ by positivity)))
  · rw [max_eq_left h]
    exact (fourth_pi_norm_le_sum v.1).trans
      (le_add_of_nonneg_right (Finset.sum_nonneg (fun i _ ↦ by positivity)))

/-- The increment of the same actual full real phase, from its fixed periodic
initial representative, for local generator calculations. -/
def textbookLangevinPeriodicRealPhaseIncrement (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) :
    textbookLangevinPhase N :=
  textbookLangevinGlobalRandomPhase U L hF γ σ
    (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample -
      (textbookLangevinPeriodicRepresentative x.1, x.2)

include hB hU in
private theorem fourth_phase_increment_aemeasurable (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    AEMeasurable (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x) P :=
  (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).sub
      aemeasurable_const

include hB hU hp in
/-- The fourth norm power of the actual full real phase increment is integrable locally in time. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 4) P := by
  have hq (i : Fin N) := textbookLangevinPeriodicConfigurationLift_increment_fourth_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x i
  have hpmom (i : Fin N) := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_fourth_integrable
    B P hB U hU hp L hF γ σ hγ T hT x i
  have hu : Integrable (fun sample ↦
      (∑ i : Fin N, (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample).1 i ^ 4) +
      (∑ i : Fin N, (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample).2 i ^ 4)) P :=
    (integrable_finsetSum Finset.univ (fun i _ ↦ hq i)).add
      (integrable_finsetSum Finset.univ (fun i _ ↦ hpmom i))
  have hm := (fourth_phase_increment_aemeasurable B P hB U hU L hF γ σ T hT x).norm.pow_const 4
  exact hu.mono_nonneg hm.aestronglyMeasurable
    (Eventually.of_forall (fun _ ↦ pow_nonneg (norm_nonneg _) 4))
    (Eventually.of_forall (fun sample ↦ fourth_phase_norm_le_sum _))

include hB hU hp in
/-- The actual full real phase increment has a derived local O(T²) fourth norm moment. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_moment_bound
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 4 ∂P) ≤ C * T ^ 2 := by
  have h (i : Fin N) := textbookLangevinPeriodicRealIncrements_coordinate_fourth_moment_bound
    B P hB U hU hp L hF γ σ hγ x i
  choose C hC hb using h
  refine ⟨2 * ∑ i : Fin N, C i, mul_nonneg (by norm_num) (Finset.sum_nonneg (fun i _ ↦ hC i)),
    fun t ht ht1 ↦ ?_⟩
  have hq (i : Fin N) := textbookLangevinPeriodicConfigurationLift_increment_fourth_integrable
    B P hB U hU hp L hF γ σ hγ t ht ht1 x i
  have hpmom (i : Fin N) := textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_fourth_integrable
    B P hB U hU hp L hF γ σ hγ t ht x i
  have hQ := integrable_finsetSum Finset.univ (fun i _ ↦ hq i)
  have hP := integrable_finsetSum Finset.univ (fun i _ ↦ hpmom i)
  have hsum : (∫ sample,
      (∑ i : Fin N, (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i) ^ 4) +
      (∑ i : Fin N, ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i -
        x.2 i) ^ 4) ∂P) ≤ (2 * ∑ i : Fin N, C i) * t ^ 2 := by
    rw [integral_add (f := fun sample ↦ ∑ i : Fin N,
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
          textbookLangevinPeriodicRepresentative x.1 i) ^ 4)
      (g := fun sample ↦ ∑ i : Fin N,
        ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i) ^ 4) hQ hP,
      integral_finsetSum Finset.univ (fun i _ ↦ hq i), integral_finsetSum Finset.univ (fun i _ ↦ hpmom i)]
    have hqsum := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin N))) ↦ (hb i t ht ht1).2)
    have hpsum := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin N))) ↦ (hb i t ht ht1).1)
    calc
      _ ≤ (∑ i : Fin N, C i * t ^ 2) + (∑ i : Fin N, C i * t ^ 2) := add_le_add hqsum hpsum
      _ = _ := by rw [← Finset.sum_mul]; ring
  have hi := textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_integrable
    B P hB U hU hp L hF γ σ hγ t ht ht1 x
  have he := integral_mono_ae hi (hQ.add hP)
    (Eventually.of_forall (fun sample ↦ fourth_phase_norm_le_sum
      (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)))
  exact he.trans hsum

include hB hU hp in
/-- The genuine fourth norm moment of the same actual full real phase increment
divided by time tends to zero, as required for the Taylor expectation remainder. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 4 ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _hC, hb⟩ := textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_moment_bound
    B P hB U hU hp L hF γ σ hγ x
  have hc : Continuous (fun t : ℝ ↦ C * t) := by fun_prop
  apply squeeze_zero' _ _ (by simpa using (hc.tendsto 0).mono_left nhdsWithin_le_nhds)
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) 4)) ht.le
  · filter_upwards [self_mem_nhdsWithin, nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))]
      with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    calc
      _ ≤ C * t ^ 2 / t := div_le_div_of_nonneg_right (hb t ht0.le ht1'.le) ht0.le
      _ = _ := by field_simp

end
end MolecularDynamics
