import MolecularDynamics.Chapter06.LangevinHamiltonianExpectedDrift

/-! Actual higher even increments needed for the Hamiltonian power generator remainder. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem higher_integral_cauchy_square (f : ℝ → ℝ) (t : ℝ) (ht : 0 ≤ t)
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

private theorem higher_noise_coordinate_formula {N : ℕ} (γ σ t : ℝ)
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


private theorem higher_noise_remainder_path_bound {N : ℕ} (γ σ t : ℝ)
    (hγ : 0 ≤ γ) (ht : 0 ≤ t) (W : ℝ → (Fin N → ℝ)) (hW : Continuous W) (i : Fin N) :
    (textbookLangevinDampedNoise γ σ W t i - σ * W t i) ^ 2 ≤
      σ ^ 2 * γ ^ 2 * t * (∫ s in 0..t, W s i ^ 2) := by
  let f : ℝ → ℝ := fun s ↦ Real.exp (-γ * (t - s)) * W s i
  have hw : Continuous (fun s ↦ W s i) := (continuous_apply i).comp hW
  have hf : Continuous f := by dsimp [f]; fun_prop
  have hi := higher_integral_cauchy_square f t ht hf
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
      rw [higher_noise_coordinate_formula γ σ t W hW i]
      dsimp [f]
      ring
    _ ≤ (σ ^ 2 * γ ^ 2) * (t * (∫ s in 0..t, W s i ^ 2)) :=
      mul_le_mul_of_nonneg_left hi' (mul_nonneg (sq_nonneg _) (sq_nonneg _))
    _ = _ := by ring


private theorem higher_square_integral_power (f : ℝ → ℝ) (hf : Continuous f)
    (cap : ℝ) (hcap : 0 < cap) (t : ℝ) (ht : 0 ≤ t) (htc : t ≤ cap) (l : ℕ) :
    (∫ s in 0..t, f s ^ 2) ^ l ≤
      (cap ^ l / cap) * ∫ s in 0..cap, ‖f s‖ ^ (2 * l) := by
  have hmono : (∫ s in 0..t, f s ^ 2) ≤ ∫ s in 0..cap, f s ^ 2 :=
    intervalIntegral.integral_mono_interval le_rfl ht htc
      (Eventually.of_forall (fun s ↦ sq_nonneg (f s))) ((hf.pow 2).intervalIntegrable _ _)
  have hI : 0 ≤ ∫ s in 0..t, f s ^ 2 :=
    intervalIntegral.integral_nonneg ht (fun s _ ↦ sq_nonneg (f s))
  have h0 : volume (Ioc 0 cap) ≠ 0 := by
    simp only [Real.volume_Ioc, sub_zero, ne_eq, ENNReal.ofReal_eq_zero]
    exact not_le.mpr hcap
  have htop : volume (Ioc 0 cap) ≠ (∞ : ℝ≥0∞) := by
    rw [Real.volume_Ioc]
    exact ENNReal.ofReal_ne_top
  have hi : IntegrableOn (fun s ↦ f s ^ 2) (Ioc 0 cap) :=
    (hf.pow 2).continuousOn.integrableOn_Icc.mono_set Ioc_subset_Icc_self
  have hp : IntegrableOn ((fun y : ℝ ↦ y ^ l) ∘ (fun s ↦ f s ^ 2)) (Ioc 0 cap) :=
    ((hf.pow 2).pow l).continuousOn.integrableOn_Icc.mono_set Ioc_subset_Icc_self
  have hcont : Continuous (fun y : ℝ ↦ y ^ l) := by fun_prop
  have hj := (convexOn_pow (𝕜 := ℝ) l).map_set_average_le hcont.continuousOn isClosed_Ici h0 htop
    (Eventually.of_forall (fun s ↦ sq_nonneg (f s))) hi hp
  simp only [setAverage_eq, measureReal_def, Real.volume_Ioc, sub_zero,
    ENNReal.toReal_ofReal hcap.le, smul_eq_mul] at hj
  have he : (cap⁻¹ * ∫ s in Ioc 0 cap, f s ^ 2) ^ l * cap ^ l =
      (∫ s in Ioc 0 cap, f s ^ 2) ^ l := by
    rw [← mul_pow]
    congr 1
    field_simp
  calc
    _ ≤ (∫ s in 0..cap, f s ^ 2) ^ l := pow_le_pow_left₀ hI hmono l
    _ = (cap⁻¹ * ∫ s in Ioc 0 cap, f s ^ 2) ^ l * cap ^ l := by
      rw [intervalIntegral.integral_of_le hcap.le, he]
    _ ≤ (cap⁻¹ * ∫ s in Ioc 0 cap, (f s ^ 2) ^ l) * cap ^ l :=
      mul_le_mul_of_nonneg_right hj (pow_nonneg hcap.le l)
    _ = _ := by
      rw [intervalIntegral.integral_of_le hcap.le]
      simp_rw [pow_mul, Real.norm_eq_abs, sq_abs]
      ring


variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- Exact original Gaussian time scaling of every even coordinate norm moment. -/
theorem textbookWienerVector_coordinate_even_norm_moment_time_scaling
    (t : ℝ) (ht : 0 ≤ t) (i : Fin N) (r : ℕ) :
    (∫ sample, ‖B t.toNNReal sample i‖ ^ (2 * r) ∂P) =
      t ^ r * (∫ z : ℝ, ‖z‖ ^ (2 * r) ∂gaussianReal 0 1) := by
  have hc : Continuous (fun z : ℝ ↦ ‖z‖ ^ (2 * r)) := by fun_prop
  calc
    _ = ∫ z : ℝ, ‖z‖ ^ (2 * r) ∂gaussianReal 0 t.toNNReal :=
      ((textbookWienerVector_coordinate B P hB i).hasLaw_eval t.toNNReal).integral_comp hc.aestronglyMeasurable
    _ = ∫ z : ℝ, ‖Real.sqrt (t.toNNReal : ℝ) * z‖ ^ (2 * r) ∂gaussianReal 0 1 := by
      rw [← textbookBrownianGaussian_time_sqrt_map t.toNNReal]
      exact integral_map (by fun_prop) hc.aestronglyMeasurable
    _ = Real.sqrt t ^ (2 * r) * (∫ z : ℝ, ‖z‖ ^ (2 * r) ∂gaussianReal 0 1) := by
      simp_rw [Real.coe_toNNReal t ht, norm_mul, Real.norm_of_nonneg (Real.sqrt_nonneg _), mul_pow]
      exact integral_const_mul _ _
    _ = _ := by rw [pow_mul, Real.sq_sqrt ht]

include hB in
/-- Every integer power of the actual unit-time Wiener energy is integrable,
from genuine continuous-path Jensen and the original time even moment. -/
theorem textbookWienerVector_coordinate_unit_time_energy_power_integrable
    (i : Fin N) (r : ℕ) :
    Integrable (fun sample ↦ (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ r) P := by
  have hj := textbookWienerVector_coordinate_time_square_integrable B P hB 1 (by norm_num) i
  have hk := textbookWienerVector_coordinate_time_even_norm_power_integrable B P hB 1 (by norm_num) i r
  have ha := (hj.aestronglyMeasurable.aemeasurable.pow_const r).aestronglyMeasurable
  apply hk.mono_nonneg ha
  · exact Eventually.of_forall (fun sample ↦
      pow_nonneg (intervalIntegral.integral_nonneg (by norm_num) (fun _ _ ↦ sq_nonneg _)) r)
  filter_upwards [hB.cont] with sample hc
  have hw : Continuous (fun s : ℝ ↦ B s.toNNReal sample i) :=
    ((continuous_apply i).comp hc).comp continuous_real_toNNReal
  simpa using higher_square_integral_power _ hw 1 (by norm_num) 1 (by norm_num) le_rfl r

variable (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
private theorem higher_actual_coordinate_square_bounds (hγ : 0 < γ) :
    ∃ S : ℝ, 0 ≤ S ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t → t ≤ 1 → ∀ i : Fin N,
        ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i) ^ 2 ≤
          (6 * (γ ^ 2 * x.2 i ^ 2 + S)) * t ^ 2 +
          (6 * σ ^ 2 * γ ^ 2) * t *
            (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) +
          (2 * σ ^ 2) * B t.toNNReal sample i ^ 2 ∧
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
            textbookLangevinPeriodicRepresentative x.1 i) ^ 2 ≤
          2 * (6 * (γ ^ 2 * x.2 i ^ 2 + S)) * t ^ 4 +
          2 * (6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2) * t *
            (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) +
          2 * t ^ 2 * x.2 i ^ 2 := by
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
  have hn := higher_noise_remainder_path_bound γ σ t hγ.le ht W hW i
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
  dsimp only [A, D, C, J, W] at hp2 hq2
  exact ⟨hp2, hq2⟩


private theorem higher_norm_even (a : ℝ) (r : ℕ) : ‖a‖ ^ (2 * r) = a ^ (2 * r) := by
  simp only [pow_mul, Real.norm_eq_abs, sq_abs]

private theorem higher_square_power_three (a b c d : ℝ) (r : ℕ)
    (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (h : a ^ 2 ≤ b + c + d) :
    ‖a‖ ^ (2 * r) ≤ 3 ^ r * (b ^ r + c ^ r + d ^ r) := by
  let m := max b (max c d)
  have hbm : b ≤ m := le_max_left _ _
  have hcm : c ≤ m := (le_max_left c d).trans (le_max_right _ _)
  have hdm : d ≤ m := (le_max_right c d).trans (le_max_right _ _)
  have hmm : m ^ r ≤ b ^ r + c ^ r + d ^ r := by
    rcases le_total b (max c d) with hbc | hbc
    · dsimp only [m]
      rw [max_eq_right hbc]
      rcases le_total c d with hcd | hcd
      · rw [max_eq_right hcd]
        exact le_add_of_nonneg_left (add_nonneg (pow_nonneg hb _) (pow_nonneg hc _))
      · rw [max_eq_left hcd]
        nlinarith [pow_nonneg hb r, pow_nonneg hd r]
    · dsimp only [m]
      rw [max_eq_left hbc]
      nlinarith [pow_nonneg hc r, pow_nonneg hd r]
  calc
    _ = (a ^ 2) ^ r := by rw [pow_mul, Real.norm_eq_abs, sq_abs]
    _ ≤ (3 * m) ^ r := pow_le_pow_left₀ (sq_nonneg a) (by linarith) r
    _ = 3 ^ r * m ^ r := mul_pow _ _ _
    _ ≤ _ := mul_le_mul_of_nonneg_left hmm (by positivity)

include hB hU hp in
private theorem higher_actual_coordinate_even_bounds (hγ : 0 < γ) (r : ℕ) :
    ∃ S : ℝ, 0 ≤ S ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ t : ℝ, 0 ≤ t → t ≤ 1 → ∀ i : Fin N,
        ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i‖ ^ (2 * r) ≤
          3 ^ r * ((6 * (γ ^ 2 * x.2 i ^ 2 + S)) ^ r * t ^ (2 * r) +
          (6 * σ ^ 2 * γ ^ 2) ^ r * t ^ r *
            (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ r +
          (2 * σ ^ 2) ^ r * ‖B t.toNNReal sample i‖ ^ (2 * r)) ∧
        ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
            textbookLangevinPeriodicRepresentative x.1 i‖ ^ (2 * r) ≤
          3 ^ r * ((2 * (6 * (γ ^ 2 * x.2 i ^ 2 + S))) ^ r * t ^ (4 * r) +
          (2 * (6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2)) ^ r * t ^ r *
            (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ r +
          (2 * x.2 i ^ 2) ^ r * t ^ (2 * r)) := by
  obtain ⟨S, hS, hb⟩ := higher_actual_coordinate_square_bounds B P hB U hU hp L hF γ σ hγ
  refine ⟨S, hS, fun x ↦ ?_⟩
  filter_upwards [hb x] with sample hs
  intro t ht ht1 i
  have hJ : 0 ≤ ∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2 :=
    intervalIntegral.integral_nonneg (by norm_num) (fun _ _ ↦ sq_nonneg _)
  have hA : 0 ≤ 6 * (γ ^ 2 * x.2 i ^ 2 + S) := by positivity
  constructor
  · have he := higher_square_power_three
      ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i)
      ((6 * (γ ^ 2 * x.2 i ^ 2 + S)) * t ^ 2)
      ((6 * σ ^ 2 * γ ^ 2) * t * (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2))
      ((2 * σ ^ 2) * B t.toNNReal sample i ^ 2) r
      (by positivity) (by positivity) (by positivity) (hs t ht ht1 i).1
    simpa only [higher_norm_even, mul_pow, ← pow_mul] using he
  · have he := higher_square_power_three
      (textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i)
      (2 * (6 * (γ ^ 2 * x.2 i ^ 2 + S)) * t ^ 4)
      (2 * (6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2) * t *
        (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2))
      (2 * t ^ 2 * x.2 i ^ 2) r
      (by positivity) (by positivity) (by positivity) (hs t ht ht1 i).2
    simpa only [higher_norm_even, mul_pow, ← pow_mul, mul_assoc, mul_comm, mul_left_comm] using he

include hB hU hp in
/-- Both actual real coordinate increment even powers are integrable locally.
The proof derives path domination from the original SDE and Wiener energy. -/
theorem textbookLangevinPeriodicRealIncrements_coordinate_even_norm_power_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (i : Fin N) (r : ℕ) :
    Integrable (fun sample ↦
      ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i‖ ^ (2 * r)) P ∧
    Integrable (fun sample ↦
      ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i‖ ^ (2 * r)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨S, _hS, hb⟩ := higher_actual_coordinate_even_bounds B P hB U hU hp L hF γ σ hγ r
  let A := 6 * (γ ^ 2 * x.2 i ^ 2 + S)
  let D := 6 * σ ^ 2 * γ ^ 2
  let E := 2 * σ ^ 2
  let F := 6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2
  let J := fun sample ↦ (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ r
  have hj : Integrable J P :=
    textbookWienerVector_coordinate_unit_time_energy_power_integrable B P hB i r
  have hw : Integrable (fun sample ↦ ‖B T.toNNReal sample i‖ ^ (2 * r)) P :=
    ((hB.gaussian.hasGaussianLaw_eval ⟨i, T.toNNReal⟩).memLp
      (p := ((2 * r : ℕ) : ℝ≥0∞)) (ENNReal.natCast_ne_top _)).integrable_norm_pow'
  have hpU : Integrable (fun sample ↦ 3 ^ r *
      (A ^ r * T ^ (2 * r) + D ^ r * T ^ r * J sample +
        E ^ r * ‖B T.toNNReal sample i‖ ^ (2 * r))) P :=
    (((integrable_const _).add (hj.const_mul _)).add (hw.const_mul _)).const_mul _
  have hqU : Integrable (fun sample ↦ 3 ^ r *
      ((2 * A) ^ r * T ^ (4 * r) + (2 * F) ^ r * T ^ r * J sample +
        (2 * x.2 i ^ 2) ^ r * T ^ (2 * r))) P :=
    (((integrable_const _).add (hj.const_mul _)).add (integrable_const _)).const_mul _
  have hpA := ((textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ x T hT).snd.eval i).sub
      (aemeasurable_const (b := x.2 i))
  have hqA := ((textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).fst.eval i).sub
      (aemeasurable_const (b := textbookLangevinPeriodicRepresentative x.1 i))
  constructor
  · exact hpU.mono_nonneg (hpA.norm.pow_const (2 * r)).aestronglyMeasurable
      (Eventually.of_forall (fun _ ↦ pow_nonneg (norm_nonneg _) _))
      ((hb x).mono (fun _ hs ↦ (hs T hT hT1 i).1))
  · exact hqU.mono_nonneg (hqA.norm.pow_const (2 * r)).aestronglyMeasurable
      (Eventually.of_forall (fun _ ↦ pow_nonneg (norm_nonneg _) _))
      ((hb x).mono (fun _ hs ↦ (hs T hT hT1 i).2))

include hB hU hp in
/-- For every required even order, the actual real coordinate increments have
a derived O(T^r) expectation bound on [0,1]. -/
theorem textbookLangevinPeriodicRealIncrements_coordinate_even_norm_moment_bound
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) (r : ℕ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      (∫ sample, ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i -
        x.2 i‖ ^ (2 * r) ∂P) ≤ C * T ^ r ∧
      (∫ sample, ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i‖ ^ (2 * r) ∂P) ≤ C * T ^ r := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨S, hS, hb⟩ := higher_actual_coordinate_even_bounds B P hB U hU hp L hF γ σ hγ r
  let A := 6 * (γ ^ 2 * x.2 i ^ 2 + S)
  let D := 6 * σ ^ 2 * γ ^ 2
  let E := 2 * σ ^ 2
  let F := 6 * σ ^ 2 * γ ^ 2 + 2 * σ ^ 2
  let J := fun sample ↦ (∫ s in (0 : ℝ)..1, B s.toNNReal sample i ^ 2) ^ r
  let j := ∫ sample, J sample ∂P
  let m := ∫ z : ℝ, ‖z‖ ^ (2 * r) ∂gaussianReal 0 1
  let Cp := 3 ^ r * (A ^ r + D ^ r * j + E ^ r * m)
  let Cq := 3 ^ r * ((2 * A) ^ r + (2 * F) ^ r * j + (2 * x.2 i ^ 2) ^ r)
  have hj : Integrable J P :=
    textbookWienerVector_coordinate_unit_time_energy_power_integrable B P hB i r
  have hj0 : 0 ≤ j := integral_nonneg (fun _ ↦
    pow_nonneg (intervalIntegral.integral_nonneg (by norm_num) (fun _ _ ↦ sq_nonneg _)) _)
  have hm0 : 0 ≤ m := integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)
  have hA : 0 ≤ A := by dsimp only [A]; positivity
  have hD : 0 ≤ D := by dsimp only [D]; positivity
  have hE : 0 ≤ E := by dsimp only [E]; positivity
  have hF0 : 0 ≤ F := by dsimp only [F]; positivity
  have hp0 : 0 ≤ Cp := by dsimp only [Cp]; positivity
  have hq0 : 0 ≤ Cq := by dsimp only [Cq]; positivity
  refine ⟨Cp + Cq, add_nonneg hp0 hq0, fun t ht ht1 ↦ ?_⟩
  have hw : Integrable (fun sample ↦ ‖B t.toNNReal sample i‖ ^ (2 * r)) P :=
    ((hB.gaussian.hasGaussianLaw_eval ⟨i, t.toNNReal⟩).memLp
      (p := ((2 * r : ℕ) : ℝ≥0∞)) (ENNReal.natCast_ne_top _)).integrable_norm_pow'
  have hi := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_power_integrable
    B P hB U hU hp L hF γ σ hγ t ht ht1 x i r
  have hpC : Integrable (fun _sample : Ω ↦ A ^ r * t ^ (2 * r)) P := integrable_const _
  have hpJ : Integrable (fun sample ↦ D ^ r * t ^ r * J sample) P := hj.const_mul _
  have hpB : Integrable (fun sample ↦ E ^ r * ‖B t.toNNReal sample i‖ ^ (2 * r)) P := hw.const_mul _
  have hpu := ((hpC.add hpJ).add hpB).const_mul ((3 : ℝ) ^ r)
  have hpp := integral_mono_ae hi.1 hpu ((hb x).mono (fun _ hs ↦ (hs t ht ht1 i).1))
  simp only [Pi.add_apply] at hpp
  rw [integral_const_mul,
    integral_add (f := fun sample ↦ A ^ r * t ^ (2 * r) + D ^ r * t ^ r * J sample)
      (g := fun sample ↦ E ^ r * ‖B t.toNNReal sample i‖ ^ (2 * r)) (hpC.add hpJ) hpB,
    integral_add (f := fun _sample : Ω ↦ A ^ r * t ^ (2 * r))
      (g := fun sample ↦ D ^ r * t ^ r * J sample) hpC hpJ,
    integral_const, probReal_univ, one_smul, integral_const_mul, integral_const_mul,
    textbookWienerVector_coordinate_even_norm_moment_time_scaling B P hB t ht i r] at hpp
  have hqC : Integrable (fun _sample : Ω ↦ (2 * A) ^ r * t ^ (4 * r)) P := integrable_const _
  have hqJ : Integrable (fun sample ↦ (2 * F) ^ r * t ^ r * J sample) P := hj.const_mul _
  have hqP : Integrable (fun _sample : Ω ↦ (2 * x.2 i ^ 2) ^ r * t ^ (2 * r)) P := integrable_const _
  have hqu := ((hqC.add hqJ).add hqP).const_mul ((3 : ℝ) ^ r)
  have hqq := integral_mono_ae hi.2 hqu ((hb x).mono (fun _ hs ↦ (hs t ht ht1 i).2))
  simp only [Pi.add_apply] at hqq
  rw [integral_const_mul,
    integral_add (f := fun sample ↦ (2 * A) ^ r * t ^ (4 * r) + (2 * F) ^ r * t ^ r * J sample)
      (g := fun _sample : Ω ↦ (2 * x.2 i ^ 2) ^ r * t ^ (2 * r)) (hqC.add hqJ) hqP,
    integral_add (f := fun _sample : Ω ↦ (2 * A) ^ r * t ^ (4 * r))
      (g := fun sample ↦ (2 * F) ^ r * t ^ r * J sample) hqC hqJ,
    integral_const, integral_const, probReal_univ, one_smul, one_smul, integral_const_mul] at hqq
  have ht2 : t ^ (2 * r) ≤ t ^ r :=
    pow_le_pow_of_le_one ht ht1 (by omega : r ≤ 2 * r)
  have ht4 : t ^ (4 * r) ≤ t ^ r :=
    pow_le_pow_of_le_one ht ht1 (by omega : r ≤ 4 * r)
  have hpa := mul_le_mul_of_nonneg_left ht2 (pow_nonneg hA r)
  have hqa := mul_le_mul_of_nonneg_left ht4 (show 0 ≤ (2 * A) ^ r by positivity)
  have hqp := mul_le_mul_of_nonneg_left ht2 (show 0 ≤ (2 * x.2 i ^ 2) ^ r by positivity)
  have hpt : 0 ≤ Cq * t ^ r := mul_nonneg hq0 (pow_nonneg ht _)
  have hqt : 0 ≤ Cp * t ^ r := mul_nonneg hp0 (pow_nonneg ht _)
  constructor
  · have hin : A ^ r * t ^ (2 * r) + D ^ r * t ^ r * j + E ^ r * (t ^ r * m) ≤
        (A ^ r + D ^ r * j + E ^ r * m) * t ^ r := by nlinarith
    have hm := mul_le_mul_of_nonneg_left hin (show 0 ≤ (3 : ℝ) ^ r by positivity)
    dsimp only [Cp, Cq, j, m] at *
    nlinarith
  · have hin : (2 * A) ^ r * t ^ (4 * r) + (2 * F) ^ r * t ^ r * j +
        (2 * x.2 i ^ 2) ^ r * t ^ (2 * r) ≤
        ((2 * A) ^ r + (2 * F) ^ r * j + (2 * x.2 i ^ 2) ^ r) * t ^ r := by nlinarith
    have hm := mul_le_mul_of_nonneg_left hin (show 0 ≤ (3 : ℝ) ^ r by positivity)
    dsimp only [Cp, Cq, j] at *
    nlinarith

private theorem higher_moment_quotient_zero (f : ℝ → ℝ) (r : ℕ) (hr : 2 ≤ r)
    (hf : ∀ t, 0 ≤ f t) (C : ℝ) (hb : ∀ t, 0 ≤ t → t ≤ 1 → f t ≤ C * t ^ r) :
    Tendsto (fun t ↦ f t / t) (𝓝[>] 0) (𝓝 0) := by
  have hc : Continuous (fun t : ℝ ↦ C * t ^ (r - 1)) := by fun_prop
  have hcn : Tendsto (fun t : ℝ ↦ C * t ^ (r - 1)) (𝓝[>] 0) (𝓝 0) := by
    simpa only [zero_pow (by omega : r - 1 ≠ 0), mul_zero] using
      (hc.tendsto 0).mono_left nhdsWithin_le_nhds
  apply squeeze_zero' _ _ hcn
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (hf t) ht.le
  · filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    calc
      _ ≤ C * t ^ r / t := div_le_div_of_nonneg_right (hb t ht0.le ht1'.le) ht0.le
      _ = C * t ^ (r - 1) := by
        have he : t ^ r = t ^ (r - 1) * t := by
          simpa only [show r - 1 + 1 = r by omega] using pow_succ t (r - 1)
        rw [he]
        field_simp

include hB hU hp in
/-- The required higher even actual momentum increment moments divided by time vanish. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_even_norm_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) (r : ℕ) (hr : 2 ≤ r) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i‖ ^ (2 * r) ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _hC, hb⟩ := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_moment_bound
    B P hB U hU hp L hF γ σ hγ x i r
  exact higher_moment_quotient_zero _ r hr
    (fun _ ↦ integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)) C
    (fun t ht ht1 ↦ (hb t ht ht1).1)

include hB hU hp in
/-- The required higher even actual real configuration increment moments divided by time vanish. -/
theorem textbookLangevinPeriodicConfigurationLift_increment_even_norm_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (i : Fin N) (r : ℕ) (hr : 2 ≤ r) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample i -
        textbookLangevinPeriodicRepresentative x.1 i‖ ^ (2 * r) ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _hC, hb⟩ := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_moment_bound
    B P hB U hU hp L hF γ σ hγ x i r
  exact higher_moment_quotient_zero _ r hr
    (fun _ ↦ integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)) C
    (fun t ht ht1 ↦ (hb t ht ht1).2)

private theorem higher_pi_norm_le_sum {N : ℕ} (v : Fin N → ℝ) (r : ℕ) (hr : 0 < r) :
    ‖v‖ ^ (2 * r) ≤ ∑ i : Fin N, ‖v i‖ ^ (2 * r) := by
  by_cases h : Nonempty (Fin N)
  · have := h
    obtain ⟨i, _, hi⟩ := Finset.exists_mem_eq_sup Finset.univ Finset.univ_nonempty (fun j : Fin N ↦ ‖v j‖₊)
    have he : ‖v‖ = ‖v i‖ := congrArg (fun n : ℝ≥0 ↦ (n : ℝ)) hi
    rw [he]
    exact Finset.single_le_sum (fun j _ ↦ pow_nonneg (norm_nonneg (v j)) _) (Finset.mem_univ i)
  · have : IsEmpty (Fin N) := not_nonempty_iff.mp h
    simp [Pi.norm_def, show 2 * r ≠ 0 by omega]

private theorem higher_phase_norm_le_sum {N : ℕ} (v : textbookLangevinPhase N) (r : ℕ) (hr : 0 < r) :
    ‖v‖ ^ (2 * r) ≤ (∑ i : Fin N, ‖v.1 i‖ ^ (2 * r)) + (∑ i : Fin N, ‖v.2 i‖ ^ (2 * r)) := by
  rw [Prod.norm_def]
  rcases le_total ‖v.1‖ ‖v.2‖ with h | h
  · rw [max_eq_right h]
    exact (higher_pi_norm_le_sum v.2 r hr).trans
      (le_add_of_nonneg_left (Finset.sum_nonneg (fun i _ ↦ pow_nonneg (norm_nonneg _) _)))
  · rw [max_eq_left h]
    exact (higher_pi_norm_le_sum v.1 r hr).trans
      (le_add_of_nonneg_right (Finset.sum_nonneg (fun i _ ↦ pow_nonneg (norm_nonneg _) _)))

include hB hU in
private theorem higher_phase_increment_aemeasurable (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    AEMeasurable (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x) P :=
  (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2) T hT).sub
      aemeasurable_const

include hB hU hp in
/-- All required even norm powers of the same actual full real phase increment
are genuinely integrable near zero time. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (r : ℕ) (hr : 1 ≤ r) :
    Integrable (fun sample ↦ ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ (2 * r)) P := by
  have hi (i : Fin N) := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_power_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x i r
  have hu : Integrable (fun sample ↦
      (∑ i : Fin N, ‖(textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample).1 i‖ ^ (2 * r)) +
      (∑ i : Fin N, ‖(textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample).2 i‖ ^ (2 * r))) P :=
    (integrable_finsetSum Finset.univ (fun i _ ↦ (hi i).2)).add
      (integrable_finsetSum Finset.univ (fun i _ ↦ (hi i).1))
  have hm := (higher_phase_increment_aemeasurable B P hB U hU L hF γ σ T hT x).norm.pow_const (2 * r)
  exact hu.mono_nonneg hm.aestronglyMeasurable
    (Eventually.of_forall (fun _ ↦ pow_nonneg (norm_nonneg _) _))
    (Eventually.of_forall (fun _ ↦ higher_phase_norm_le_sum _ r (by omega)))

include hB hU hp in
/-- The actual full real phase increment satisfies an O(T^r) even norm moment
bound, derived from finite coordinates and the genuine Wiener time law. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_even_moment_bound
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (r : ℕ) (hr : 1 ≤ r) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ (2 * r) ∂P) ≤ C * T ^ r := by
  have h (i : Fin N) := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_moment_bound
    B P hB U hU hp L hF γ σ hγ x i r
  choose C hC hb using h
  refine ⟨2 * ∑ i : Fin N, C i, mul_nonneg (by norm_num) (Finset.sum_nonneg (fun i _ ↦ hC i)),
    fun t ht ht1 ↦ ?_⟩
  have hi (i : Fin N) := textbookLangevinPeriodicRealIncrements_coordinate_even_norm_power_integrable
    B P hB U hU hp L hF γ σ hγ t ht ht1 x i r
  have hQ := integrable_finsetSum Finset.univ (fun i _ ↦ (hi i).2)
  have hP := integrable_finsetSum Finset.univ (fun i _ ↦ (hi i).1)
  have hsum : (∫ sample,
      (∑ i : Fin N, ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
        textbookLangevinPeriodicRepresentative x.1 i‖ ^ (2 * r)) +
      (∑ i : Fin N, ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i -
        x.2 i‖ ^ (2 * r)) ∂P) ≤ (2 * ∑ i : Fin N, C i) * t ^ r := by
    rw [integral_add
      (f := fun sample ↦ ∑ i : Fin N,
        ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample i -
          textbookLangevinPeriodicRepresentative x.1 i‖ ^ (2 * r))
      (g := fun sample ↦ ∑ i : Fin N,
        ‖(textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i‖ ^ (2 * r)) hQ hP,
      integral_finsetSum Finset.univ (fun i _ ↦ (hi i).2),
      integral_finsetSum Finset.univ (fun i _ ↦ (hi i).1)]
    have hqsum := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin N))) ↦ (hb i t ht ht1).2)
    have hpsum := Finset.sum_le_sum (fun i (_ : i ∈ (Finset.univ : Finset (Fin N))) ↦ (hb i t ht ht1).1)
    calc
      _ ≤ (∑ i : Fin N, C i * t ^ r) + (∑ i : Fin N, C i * t ^ r) := add_le_add hqsum hpsum
      _ = _ := by rw [← Finset.sum_mul]; ring
  have hint := textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
    B P hB U hU hp L hF γ σ hγ t ht ht1 x r hr
  have he := integral_mono_ae hint (hQ.add hP)
    (Eventually.of_forall (fun sample ↦ higher_phase_norm_le_sum
      (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) r (by omega)))
  exact he.trans hsum

include hB hU hp in
/-- The same actual full real phase's even norm moments of all orders 2r≥4,
divided by time, tend to zero for Hamiltonian power Taylor remainders. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_norm_even_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (r : ℕ) (hr : 2 ≤ r) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ (2 * r) ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨C, _hC, hb⟩ := textbookLangevinPeriodicRealPhaseIncrement_norm_even_moment_bound
    B P hB U hU hp L hF γ σ hγ x r (by omega)
  exact higher_moment_quotient_zero _ r hr
    (fun _ ↦ integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)) C hb

end
end MolecularDynamics
