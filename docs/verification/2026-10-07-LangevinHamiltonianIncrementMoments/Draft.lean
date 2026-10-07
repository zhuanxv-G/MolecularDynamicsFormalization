import MolecularDynamics.Chapter06.LangevinTaylorMomentControl

/-! Genuine Hamiltonian increment moment control needed for the original H^l
expectation generator. No moment, remainder limit, or generator identity is assumed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem hamIncrement_real_growth {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (M : ℝ≥0) (hU : LipschitzWith M U) (z y : textbookLangevinPhase N) :
    ‖textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z‖ ≤
      ((∑ i : Fin N, ‖z.2 i‖) + (M : ℝ)) * ‖y‖ + ((N : ℝ) / 2) * ‖y‖ ^ 2 := by
  have hq : ‖y.1‖ ≤ ‖y‖ := by rw [Prod.norm_def]; exact le_max_left _ _
  have hp : ‖y.2‖ ≤ ‖y‖ := by rw [Prod.norm_def]; exact le_max_right _ _
  have hcoord (i : Fin N) : ‖y.2 i‖ ≤ ‖y‖ := (norm_le_pi_norm _ i).trans hp
  have hlinear : ‖∑ i : Fin N, z.2 i * y.2 i‖ ≤ (∑ i : Fin N, ‖z.2 i‖) * ‖y‖ := by
    calc
      _ ≤ ∑ i : Fin N, ‖z.2 i * y.2 i‖ := norm_sum_le _ _
      _ = ∑ i : Fin N, ‖z.2 i‖ * ‖y.2 i‖ := by simp only [norm_mul]
      _ ≤ ∑ i : Fin N, ‖z.2 i‖ * ‖y‖ :=
        Finset.sum_le_sum (fun i _ ↦ mul_le_mul_of_nonneg_left (hcoord i) (norm_nonneg _))
      _ = _ := (Finset.sum_mul _ _ _).symm
  have hsq (i : Fin N) : y.2 i ^ 2 ≤ ‖y‖ ^ 2 := by
    have hh := pow_le_pow_left₀ (norm_nonneg (y.2 i)) (hcoord i) 2
    simpa only [Real.norm_eq_abs, sq_abs] using hh
  have henergy : (∑ i : Fin N, y.2 i ^ 2) ≤ (N : ℝ) * ‖y‖ ^ 2 := by
    calc
      _ ≤ ∑ _i : Fin N, ‖y‖ ^ 2 := Finset.sum_le_sum (fun i _ ↦ hsq i)
      _ = _ := by simp
  have he0 : 0 ≤ (∑ i : Fin N, y.2 i ^ 2) / 2 :=
    div_nonneg (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) (by norm_num)
  have hpot : ‖U (z.1 + y.1) - U z.1‖ ≤ (M : ℝ) * ‖y‖ := by
    calc
      _ ≤ (M : ℝ) * ‖(z.1 + y.1) - z.1‖ := by simpa only [dist_eq_norm] using hU.dist_le_mul (z.1 + y.1) z.1
      _ = (M : ℝ) * ‖y.1‖ := by rw [add_sub_cancel_left]
      _ ≤ _ := mul_le_mul_of_nonneg_left hq M.coe_nonneg
  have he : textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z =
      (∑ i : Fin N, z.2 i * y.2 i) + (∑ i : Fin N, y.2 i ^ 2) / 2 +
        (U (z.1 + y.1) - U z.1) := by
    simp only [textbookLangevinHamiltonian, Prod.fst_add, Prod.snd_add, Pi.add_apply]
    have heq : (∑ i : Fin N, (z.2 i + y.2 i) ^ 2) =
        (∑ i : Fin N, z.2 i ^ 2) + 2 * (∑ i : Fin N, z.2 i * y.2 i) +
          (∑ i : Fin N, y.2 i ^ 2) := by
      simp_rw [show ∀ i : Fin N, (z.2 i + y.2 i) ^ 2 =
        z.2 i ^ 2 + 2 * (z.2 i * y.2 i) + y.2 i ^ 2 by intro i; ring]
      rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.mul_sum]
    rw [heq]
    ring
  rw [he]
  calc
    _ ≤ ‖∑ i : Fin N, z.2 i * y.2 i‖ +
        ‖(∑ i : Fin N, y.2 i ^ 2) / 2‖ + ‖U (z.1 + y.1) - U z.1‖ :=
      (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ (∑ i : Fin N, ‖z.2 i‖) * ‖y‖ +
        ((N : ℝ) * ‖y‖ ^ 2) / 2 + (M : ℝ) * ‖y‖ := by
      rw [Real.norm_of_nonneg he0]
      exact add_le_add (add_le_add hlinear (div_le_div_of_nonneg_right henergy (by norm_num))) hpot
    _ = _ := by ring

private theorem hamIncrement_power_growth (a d A C : ℝ) (k : ℕ)
    (hd : 0 ≤ d) (hA : 0 ≤ A) (hC : 0 ≤ C) (hb : ‖a‖ ≤ A * d + C * d ^ 2) :
    ‖a‖ ^ k ≤ 2 ^ (k - 1) * (A ^ k * d ^ k + C ^ k * d ^ (2 * k)) := by
  calc
    _ ≤ (A * d + C * d ^ 2) ^ k := pow_le_pow_left₀ (norm_nonneg a) hb k
    _ ≤ 2 ^ (k - 1) * ((A * d) ^ k + (C * d ^ 2) ^ k) :=
      add_pow_le (mul_nonneg hA hd) (mul_nonneg hC (sq_nonneg _)) k
    _ = _ := by rw [mul_pow, mul_pow, ← pow_mul]

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- The increment of the actual periodic Hamiltonian of the same original process. -/
def textbookLangevinPeriodicHamiltonianIncrement (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) : ℝ :=
  textbookLangevinPeriodicHamiltonianPower U 1
    (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
      textbookLangevinPeriodicHamiltonianPower U 1 x

omit [MeasurableSpace Ω] in
include hU hp in
/-- The actual Hamiltonian increment has a derived linear plus quadratic norm
growth bound in the original real phase increment. -/
theorem textbookLangevinPeriodicHamiltonianIncrement_norm_growth_bound
    (x : textbookLangevinPeriodicPhase N) :
    ∃ A C : ℝ, 0 ≤ A ∧ 0 ≤ C ∧ ∀ T sample,
      ‖textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample‖ ≤
        A * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ +
        C * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 2 := by
  obtain ⟨M, hM, hbM⟩ := textbookUnitPeriodicC2Observable_iteratedFDeriv_bound U (hU.of_le (by simp)) hp 1 (by norm_num)
  let Mn : ℝ≥0 := ⟨M, hM⟩
  have hLip : LipschitzWith Mn U := by
    apply lipschitzWith_of_nnnorm_fderiv_le (hU.differentiable (by simp))
    intro q
    have hh : ‖fderiv ℝ U q‖ ≤ M := by simpa only [norm_iteratedFDeriv_one] using hbM q
    exact_mod_cast hh
  refine ⟨(∑ i : Fin N, ‖x.2 i‖) + M, (N : ℝ) / 2,
    add_nonneg (Finset.sum_nonneg (fun _ _ ↦ norm_nonneg _)) hM,
    div_nonneg (Nat.cast_nonneg N) (by norm_num), fun T sample ↦ ?_⟩
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let y := textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample
  have he : textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample =
      textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z := by
    change textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicProjection (textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample)) -
        textbookLangevinPeriodicHamiltonianPower U 1 x = _
    rw [textbookLangevinPeriodicHamiltonianPower_lift U hp 1]
    simp only [textbookLangevinHamiltonianPower, textbookLangevinPeriodicHamiltonianPower, pow_one]
    have hz : z + y = textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample := by
      dsimp only [z, y, textbookLangevinPeriodicRealPhaseIncrement]
      abel
    rw [hz]
  rw [he]
  exact hamIncrement_real_growth U Mn hLip z y

include hB hU hp in
/-- Every integer norm power of the genuine actual Hamiltonian increment is
integrable near zero time, with no supplied process-moment hypothesis. -/
theorem textbookLangevinPeriodicHamiltonianIncrement_norm_integer_power_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (k : ℕ) :
    Integrable (fun sample ↦ ‖textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample‖ ^ k) P := by
  obtain ⟨A, C, hA, hC, hb⟩ :=
    textbookLangevinPeriodicHamiltonianIncrement_norm_growth_bound B U hU hp L hF γ σ x
  have hi1 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x k
  have hi2 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x (2 * k)
  have hu : Integrable (fun sample ↦ 2 ^ (k - 1) *
      (A ^ k * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ k +
      C ^ k * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ (2 * k))) P :=
    ((hi1.const_mul _).add (hi2.const_mul _)).const_mul _
  have ha : AEStronglyMeasurable (textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x) P := by
    exact (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_integrable
      B P hB U hU hp L hF γ σ hγ T hT x).aestronglyMeasurable
  exact hu.mono_nonneg (ha.norm.pow k)
    (Eventually.of_forall (fun _ ↦ pow_nonneg (norm_nonneg _) _))
    (Eventually.of_forall (fun sample ↦ hamIncrement_power_growth _ _ A C k (norm_nonneg _) hA hC (hb T sample)))

include hB hU hp in
/-- Every actual Hamiltonian increment norm moment of integer order k≥3,
divided by time, vanishes for the original H^l binomial remainder. -/
theorem textbookLangevinPeriodicHamiltonianIncrement_norm_integer_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (k : ℕ) (hk : 3 ≤ k) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      ‖textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample‖ ^ k ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨A, C, hA, hC, hb⟩ :=
    textbookLangevinPeriodicHamiltonianIncrement_norm_growth_bound B U hU hp L hF γ σ x
  have h1 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x k hk
  have h2 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x (2 * k) (by omega)
  have hlim := (h1.const_mul (2 ^ (k - 1) * A ^ k)).add (h2.const_mul (2 ^ (k - 1) * C ^ k))
  apply squeeze_zero' _ _ (by simpa only [mul_zero, zero_add] using hlim)
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ pow_nonneg (norm_nonneg _) _)) ht.le
  · filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    have hi := textbookLangevinPeriodicHamiltonianIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x k
    have hi1 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x k
    have hi2 := textbookLangevinPeriodicRealPhaseIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x (2 * k)
    have ha := (hi1.const_mul (A ^ k)).add (hi2.const_mul (C ^ k))
    have hu := ha.const_mul ((2 : ℝ) ^ (k - 1))
    have he := integral_mono_ae hi hu (Eventually.of_forall (fun sample ↦
      hamIncrement_power_growth _ _ A C k (norm_nonneg _) hA hC (hb t sample)))
    simp only [Pi.add_apply] at he
    rw [integral_const_mul,
      integral_add
        (f := fun sample ↦ A ^ k * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ k)
        (g := fun sample ↦ C ^ k * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ (2 * k))
        (hi1.const_mul _) (hi2.const_mul _),
      integral_const_mul, integral_const_mul] at he
    calc
      _ ≤ (2 ^ (k - 1) *
        (A ^ k * (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ k ∂P) +
         C ^ k * (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ (2 * k) ∂P))) / t :=
        div_le_div_of_nonneg_right he ht0.le
      _ = _ := by ring

include hB hU hp in
/-- Every actual signed integer power of the Hamiltonian increment is integrable
near zero, from its derived absolute integer moment. -/
theorem textbookLangevinPeriodicHamiltonianIncrement_integer_power_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (k : ℕ) :
    Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample ^ k) P := by
  have ha : AEStronglyMeasurable (textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x) P :=
    (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_integrable
      B P hB U hU hp L hF γ σ hγ T hT x).aestronglyMeasurable
  have hi : Integrable (fun sample ↦ ‖textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample ^ k‖) P := by
    simpa only [norm_pow] using textbookLangevinPeriodicHamiltonianIncrement_norm_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ T hT hT1 x k
  exact (integrable_norm_iff (ha.pow k)).mp hi

include hB hU hp in
/-- Every actual signed Hamiltonian increment moment of integer order k≥3,
divided by time, tends to zero for the literal H^l binomial remainder. -/
theorem textbookLangevinPeriodicHamiltonianIncrement_integer_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (k : ℕ) (hk : 3 ≤ k) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample ^ k ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  have hlim := textbookLangevinPeriodicHamiltonianIncrement_norm_integer_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x k hk
  apply tendsto_zero_iff_norm_tendsto_zero.mpr
  apply squeeze_zero' (Eventually.of_forall (fun _ ↦ norm_nonneg _)) _ hlim
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  calc
    _ = ‖∫ sample, textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ t x sample ^ k ∂P‖ / t := by
      rw [norm_div, Real.norm_of_nonneg ht0.le]
    _ ≤ (∫ sample, ‖textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ t x sample ^ k‖ ∂P) / t :=
      div_le_div_of_nonneg_right (norm_integral_le_integral_norm _) ht0.le
    _ = _ := by simp only [norm_pow]

end
end MolecularDynamics
