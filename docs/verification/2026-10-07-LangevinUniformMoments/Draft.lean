import MolecularDynamics.Chapter06.LangevinHarrisSkeleton
import Mathlib.Algebra.Order.Chebyshev

/-! Actual bounded-time moments needed to pass from the original Langevin Harris skeleton to (6.48). -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

/-- The actual Wiener coordinate even moment is uniformly bounded on a fixed nonnegative time interval, by its genuine Gaussian time law. -/
theorem textbookWienerVector_coordinate_even_norm_power_bounded_time
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (cap : ℝ) (hcap : 0 ≤ cap) (l : ℕ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (t : ℝ), 0 ≤ t → t ≤ cap → ∀ i : Fin N,
      (∫ sample, ‖B t.toNNReal sample i‖ ^ (2 * l) ∂P) ≤ C := by
  let m : ℝ := ∫ z : ℝ, ‖z‖ ^ (2 * l) ∂gaussianReal 0 1
  have hm : 0 ≤ m := integral_nonneg (fun z ↦ pow_nonneg (norm_nonneg z) _)
  refine ⟨cap ^ l * m, mul_nonneg (pow_nonneg hcap _) hm, fun t ht htc i ↦ ?_⟩
  have hc : Continuous (fun z : ℝ ↦ ‖z‖ ^ (2 * l)) := by fun_prop
  have he :
      (∫ sample, ‖B t.toNNReal sample i‖ ^ (2 * l) ∂P) =
        t ^ l * m := by
    calc
      _ = ∫ z : ℝ, ‖z‖ ^ (2 * l) ∂gaussianReal 0 t.toNNReal :=
        ((textbookWienerVector_coordinate B P hB i).hasLaw_eval t.toNNReal).integral_comp hc.aestronglyMeasurable
      _ = ∫ z : ℝ, ‖Real.sqrt (t.toNNReal : ℝ) * z‖ ^ (2 * l) ∂gaussianReal 0 1 := by
        rw [← textbookBrownianGaussian_time_sqrt_map t.toNNReal]
        exact integral_map (by fun_prop) hc.aestronglyMeasurable
      _ = Real.sqrt t ^ (2 * l) * m := by
        simp_rw [Real.coe_toNNReal t ht, norm_mul, Real.norm_of_nonneg (Real.sqrt_nonneg _), mul_pow]
        exact integral_const_mul _ _
      _ = _ := by rw [pow_mul, Real.sq_sqrt ht]
  rw [he]
  exact mul_le_mul_of_nonneg_right (pow_le_pow_left₀ ht htc l) hm

private theorem bounded_time_square_integral_power (f : ℝ → ℝ) (hf : Continuous f)
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

private theorem bounded_noise_power (a b I J c d k : ℝ) (l : ℕ)
    (hc : 0 ≤ c) (hd : 0 ≤ d) (hI : 0 ≤ I)
    (ha : a ^ 2 ≤ c * (b ^ 2 + d * I)) (hp : I ^ l ≤ k * J) :
    ‖a‖ ^ (2 * l) ≤ c ^ l * 2 ^ (l - 1) * (‖b‖ ^ (2 * l) + (d ^ l * k) * J) := by
  have hs (z : ℝ) : (z ^ 2) ^ l = ‖z‖ ^ (2 * l) := by
    rw [pow_mul, Real.norm_eq_abs, sq_abs]
  calc
    _ = (a ^ 2) ^ l := (hs a).symm
    _ ≤ (c * (b ^ 2 + d * I)) ^ l := pow_le_pow_left₀ (sq_nonneg a) ha l
    _ = c ^ l * (b ^ 2 + d * I) ^ l := mul_pow _ _ _
    _ ≤ c ^ l * (2 ^ (l - 1) * ((b ^ 2) ^ l + (d * I) ^ l)) :=
      mul_le_mul_of_nonneg_left (add_pow_le (sq_nonneg b) (mul_nonneg hd hI) l) (pow_nonneg hc l)
    _ = c ^ l * 2 ^ (l - 1) * (‖b‖ ^ (2 * l) + d ^ l * I ^ l) := by
      rw [hs b, mul_pow]
      ring
    _ ≤ c ^ l * 2 ^ (l - 1) * (‖b‖ ^ (2 * l) + d ^ l * (k * J)) :=
      mul_le_mul_of_nonneg_left (add_le_add le_rfl (mul_le_mul_of_nonneg_left hp (pow_nonneg hd l)))
        (mul_nonneg (pow_nonneg hc l) (by positivity))
    _ = _ := by ring

/-- The actual convolution has a derived even coordinate moment bound uniform over every time in [0,cap] and every coordinate. -/
theorem textbookLangevinDampedNoise_coordinate_even_norm_power_bounded_time
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ cap : ℝ) (hγ : 0 ≤ γ) (hcap : 0 < cap) (l : ℕ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (t : ℝ), 0 ≤ t → t ≤ cap → ∀ i : Fin N,
      (∫ sample, ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i‖ ^ (2 * l) ∂P) ≤ C := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨E, hE0, hE⟩ := textbookWienerVector_coordinate_even_norm_power_bounded_time B P hB cap hcap.le l
  let J := fun (i : Fin N) (sample : Ω) ↦ ∫ s in 0..cap, ‖B s.toNNReal sample i‖ ^ (2 * l)
  have hJ (i : Fin N) : Integrable (J i) P :=
    textbookWienerVector_coordinate_time_even_norm_power_integrable B P hB cap hcap.le i l
  have hJ0 (i : Fin N) : 0 ≤ ∫ sample, J i sample ∂P :=
    integral_nonneg (fun sample ↦ intervalIntegral.integral_nonneg hcap.le
      (fun s _ ↦ pow_nonneg (norm_nonneg _) _))
  let M : ℝ := ∑ i : Fin N, ∫ sample, J i sample ∂P
  have hM : 0 ≤ M := Finset.sum_nonneg (fun i _ ↦ hJ0 i)
  let c : ℝ := (2 * σ ^ 2) ^ l * 2 ^ (l - 1)
  let d : ℝ := (γ ^ 2 * cap) ^ l * (cap ^ l / cap)
  have hc : 0 ≤ c := by dsimp only [c]; positivity
  have hd : 0 ≤ d := by dsimp only [d]; positivity
  refine ⟨c * (E + d * M), mul_nonneg hc (add_nonneg hE0 (mul_nonneg hd hM)), fun t ht htc i ↦ ?_⟩
  let F := fun sample ↦ ‖textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i‖ ^ (2 * l)
  let G := fun sample ↦ ‖B t.toNNReal sample i‖ ^ (2 * l)
  have hf : Integrable F P :=
    textbookLangevinDampedNoise_coordinate_even_norm_power_integrable B P hB γ σ t hγ ht i l
  have hg : Integrable G P :=
    (((textbookWienerVector_coordinate B P hB i).isGaussianProcess.hasGaussianLaw_eval _).memLp
      (p := ((2 * l : ℕ) : ℝ≥0∞)) (ENNReal.natCast_ne_top (2 * l))).integrable_norm_pow'
  have hr : Integrable (fun sample ↦ c * (G sample + d * J i sample)) P :=
    (hg.add ((hJ i).const_mul d)).const_mul c
  have hb : ∀ᵐ sample ∂P, F sample ≤ c * (G sample + d * J i sample) := by
    filter_upwards [hB.cont,
      textbookLangevinDampedNoise_coordinate_square_bound_ae B P hB γ σ t hγ ht i] with sample hW hξ
    have hw : Continuous (fun s : ℝ ↦ B s.toNNReal sample i) :=
      ((continuous_apply i).comp hW).comp continuous_real_toNNReal
    let I := ∫ s in 0..t, B s.toNNReal sample i ^ 2
    have hI : 0 ≤ I := intervalIntegral.integral_nonneg ht (fun s _ ↦ sq_nonneg _)
    have hξ' : textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i ^ 2 ≤
        (2 * σ ^ 2) * (B t.toNNReal sample i ^ 2 + (γ ^ 2 * cap) * I) :=
      hξ.trans (mul_le_mul_of_nonneg_left
        (add_le_add le_rfl (mul_le_mul_of_nonneg_right
          (mul_le_mul_of_nonneg_left htc (sq_nonneg γ)) hI)) (by positivity))
    exact bounded_noise_power _ _ I (J i sample) (2 * σ ^ 2) (γ ^ 2 * cap)
      (cap ^ l / cap) l (by positivity) (mul_nonneg (sq_nonneg γ) hcap.le) hI hξ'
      (bounded_time_square_integral_power _ hw cap hcap t ht htc l)
  calc
    _ ≤ ∫ sample, c * (G sample + d * J i sample) ∂P := integral_mono_ae hf hr hb
    _ = c * ((∫ sample, G sample ∂P) + d * ∫ sample, J i sample ∂P) := by
      rw [integral_const_mul, integral_add hg ((hJ i).const_mul d), integral_const_mul]
    _ ≤ c * (E + d * M) :=
      mul_le_mul_of_nonneg_left (add_le_add (hE t ht htc i)
        (mul_le_mul_of_nonneg_left
          (Finset.single_le_sum (fun j _ ↦ hJ0 j) (Finset.mem_univ i)) hd)) hc

/-- The physical coordinate square sum power of the actual noise has a uniform bounded-time expectation, without a supplied moment hypothesis. -/
theorem textbookLangevinDampedNoise_physical_energy_power_bounded_time
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (γ σ cap : ℝ) (hγ : 0 ≤ γ) (hcap : 0 < cap) (l : ℕ) (hl : 1 ≤ l) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (t : ℝ), 0 ≤ t → t ≤ cap →
      (∫ sample, (∑ i : Fin N,
        textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t i ^ 2) ^ l ∂P) ≤ C := by
  cases l with
  | zero => omega
  | succ n =>
    obtain ⟨C, hC0, hC⟩ := textbookLangevinDampedNoise_coordinate_even_norm_power_bounded_time
      B P hB γ σ cap hγ hcap (n + 1)
    have hN : 0 ≤ (N : ℝ) := Nat.cast_nonneg N
    refine ⟨(N : ℝ) ^ n * ((N : ℝ) * C), mul_nonneg (pow_nonneg hN n) (mul_nonneg hN hC0), fun t ht htc ↦ ?_⟩
    let ξ := fun sample ↦ textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) t
    have hi (i : Fin N) : Integrable (fun sample ↦ ‖ξ sample i‖ ^ (2 * (n + 1))) P :=
      textbookLangevinDampedNoise_coordinate_even_norm_power_integrable B P hB γ σ t hγ ht i (n + 1)
    have hsum : Integrable (fun sample ↦ ∑ i : Fin N, ‖ξ sample i‖ ^ (2 * (n + 1))) P :=
      integrable_finsetSum Finset.univ (fun i _ ↦ hi i)
    have he (a : ℝ) : (a ^ 2) ^ (n + 1) = ‖a‖ ^ (2 * (n + 1)) := by
      rw [pow_mul, Real.norm_eq_abs, sq_abs]
    have hp (sample : Ω) :
        (∑ i : Fin N, ξ sample i ^ 2) ^ (n + 1) ≤
          (N : ℝ) ^ n * ∑ i : Fin N, ‖ξ sample i‖ ^ (2 * (n + 1)) := by
      simpa only [Finset.card_univ, Fintype.card_fin, he] using
        pow_sum_le_card_mul_sum_pow (s := Finset.univ) (f := fun i : Fin N ↦ ξ sample i ^ 2)
          (fun i _ ↦ sq_nonneg _) n
    calc
      _ ≤ ∫ sample, (N : ℝ) ^ n * ∑ i : Fin N, ‖ξ sample i‖ ^ (2 * (n + 1)) ∂P :=
        integral_mono_ae
          (textbookLangevinDampedNoise_physical_energy_power_integrable B P hB γ σ t hγ ht (n + 1) hl)
          (hsum.const_mul _) (Eventually.of_forall hp)
      _ = (N : ℝ) ^ n * ∑ i : Fin N, ∫ sample, ‖ξ sample i‖ ^ (2 * (n + 1)) ∂P := by
        rw [integral_const_mul, integral_finsetSum Finset.univ (fun i _ ↦ hi i)]
      _ ≤ (N : ℝ) ^ n * ((N : ℝ) * C) := by
        apply mul_le_mul_of_nonneg_left _ (pow_nonneg hN n)
        calc
          _ ≤ ∑ _i : Fin N, C := Finset.sum_le_sum (fun i _ ↦ hC t ht htc i)
          _ = _ := by simp

private theorem fixed_coefficient_energy_power (V W A S : ℝ) (l : ℕ)
    (hV : 0 ≤ V) (hW : 0 ≤ W) (hA : 0 ≤ A) (hS : 0 ≤ S)
    (h : V ≤ 3 * W + A + (3 / 2 : ℝ) * S) :
    V ^ l ≤ 2 ^ (l - 1) * 3 ^ l * W ^ l +
      (2 ^ (l - 1)) ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * S ^ l) := by
  have hAS : 0 ≤ A + (3 / 2 : ℝ) * S := add_nonneg hA (mul_nonneg (by norm_num) hS)
  have hC : 0 ≤ (2 : ℝ) ^ (l - 1) := by positivity
  calc
    _ ≤ (3 * W + (A + (3 / 2 : ℝ) * S)) ^ l := pow_le_pow_left₀ hV (by linarith) l
    _ ≤ 2 ^ (l - 1) * ((3 * W) ^ l + (A + (3 / 2 : ℝ) * S) ^ l) :=
      add_pow_le (mul_nonneg (by norm_num) hW) hAS l
    _ ≤ 2 ^ (l - 1) * ((3 * W) ^ l +
        2 ^ (l - 1) * (A ^ l + ((3 / 2 : ℝ) * S) ^ l)) :=
      mul_le_mul_of_nonneg_left (add_le_add le_rfl
        (add_pow_le hA (mul_nonneg (by norm_num) hS) l)) hC
    _ = _ := by rw [mul_pow, mul_pow]; ring

/-- On every fixed positive time interval the same actual original kernel has a derived uniform H^l expectation bound, uniform in its initial phase. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_bounded_time
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (cap : ℝ≥0) (hcap : 0 < cap) (l : ℕ) (hl : 1 ≤ l) :
    ∃ A D : ℝ, 0 < A ∧ 0 < D ∧ ∀ (T : ℝ≥0), T ≤ cap → ∀ x : textbookLangevinPeriodicPhase N,
      (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
        A * textbookLangevinPeriodicHamiltonianPower U l x + D := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨Q, hQ0, hQ⟩ := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_path_bound_ae
    B P hB U hU hp hLower L hF γ σ hγ
  obtain ⟨C, hC0, hC⟩ := textbookLangevinDampedNoise_physical_energy_power_bounded_time
    B P hB γ σ cap hγ.le hcap l hl
  let c : ℝ := 2 ^ (l - 1)
  let A : ℝ := c * 3 ^ l
  let D : ℝ := c ^ 2 * (Q ^ l + (3 / 2 : ℝ) ^ l * C) + 1
  have hc : 0 ≤ c := by dsimp only [c]; positivity
  have hA : 0 < A := by dsimp only [A, c]; positivity
  have hD : 0 < D := by
    dsimp only [D]
    have hR := add_nonneg (pow_nonneg hQ0 l) (mul_nonneg (by positivity : 0 ≤ (3 / 2 : ℝ) ^ l) hC0)
    linarith [mul_nonneg (sq_nonneg c) hR]
  have he (z : textbookLangevinPeriodicPhase N) :
      textbookLangevinPeriodicHamiltonianPower U l z =
        textbookLangevinPeriodicHamiltonianPower U 1 z ^ l := by
    simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower, pow_one]
  refine ⟨A, D, hA, hD, fun T hTc x ↦ ?_⟩
  rw [textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_expectation B P hB U hU hp L hF γ σ T x l]
  let Y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T
  let S := fun sample ↦ ∑ i : Fin N,
    textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2
  have hS : Integrable (fun sample ↦ S sample ^ l) P :=
    textbookLangevinDampedNoise_physical_energy_power_integrable B P hB γ σ T hγ.le T.property l hl
  have hE : Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l (Y sample)) P :=
    textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ T hγ T.property x l hl
  have hR : Integrable (fun sample ↦ Q ^ l + (3 / 2 : ℝ) ^ l * S sample ^ l) P :=
    (integrable_const _).add (hS.const_mul _)
  have hdom : Integrable (fun sample ↦ A * textbookLangevinPeriodicHamiltonianPower U l x +
      c ^ 2 * (Q ^ l + (3 / 2 : ℝ) ^ l * S sample ^ l)) P :=
    (integrable_const _).add (hR.const_mul _)
  have hexp : Real.exp (-γ * (T : ℝ)) ^ 2 ≤ 1 := by
    have h0 : -γ * (T : ℝ) ≤ 0 := by
      rw [neg_mul]
      exact neg_nonpos.mpr (mul_nonneg hγ.le T.property)
    exact pow_le_one₀ (Real.exp_pos _).le (Real.exp_le_one_iff.mpr h0)
  have hb : ∀ᵐ sample ∂P, textbookLangevinPeriodicHamiltonianPower U l (Y sample) ≤
      A * textbookLangevinPeriodicHamiltonianPower U l x +
        c ^ 2 * (Q ^ l + (3 / 2 : ℝ) ^ l * S sample ^ l) := by
    filter_upwards [hQ x] with sample hs
    have hW := (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 x).le
    have hV := (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 (Y sample)).le
    have hfirst : textbookLangevinPeriodicHamiltonianPower U 1 (Y sample) ≤
        3 * textbookLangevinPeriodicHamiltonianPower U 1 x + Q + (3 / 2 : ℝ) * S sample := by
      apply (hs T T.property).trans
      exact add_le_add (add_le_add
        (mul_le_mul_of_nonneg_right (by nlinarith : 3 * Real.exp (-γ * (T : ℝ)) ^ 2 ≤ 3) hW) le_rfl) le_rfl
    simpa only [← he, c, A] using
      fixed_coefficient_energy_power _ _ Q (S sample) l hV hW hQ0
        (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) hfirst
  calc
    _ ≤ ∫ sample, A * textbookLangevinPeriodicHamiltonianPower U l x +
        c ^ 2 * (Q ^ l + (3 / 2 : ℝ) ^ l * S sample ^ l) ∂P := integral_mono_ae hE hdom hb
    _ = A * textbookLangevinPeriodicHamiltonianPower U l x +
        c ^ 2 * (Q ^ l + (3 / 2 : ℝ) ^ l * ∫ sample, S sample ^ l ∂P) := by
      rw [integral_add (integrable_const _) (hR.const_mul _), integral_const_mul (c ^ 2),
        integral_add (integrable_const _) (hS.const_mul _), integral_const_mul ((3 / 2 : ℝ) ^ l)]
      simp
    _ ≤ A * textbookLangevinPeriodicHamiltonianPower U l x +
        c ^ 2 * (Q ^ l + (3 / 2 : ℝ) ^ l * C) :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_left (add_le_add le_rfl
        (mul_le_mul_of_nonneg_left (hC T T.property hTc) (by positivity))) (sq_nonneg c))
    _ ≤ _ := by dsimp only [D]; linarith

end
end MolecularDynamics
