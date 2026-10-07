import MolecularDynamics.Chapter06.LangevinHamiltonianIncrementVariance
import Mathlib.Data.Nat.Choose.Cast

/-! Actual expectation generator identification on the original H^l Lyapunov
family, via literal binomial expansion and genuine original process moments. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem hpExpected_binomial_remove_zero (a b : ℝ) (l : ℕ) :
    (a + b) ^ l - b ^ l =
      ∑ k ∈ Finset.range l, a ^ (k + 1) * b ^ (l - (k + 1)) * (l.choose (k + 1) : ℝ) := by
  have hh := add_pow a b l
  rw [Finset.sum_range_succ'] at hh
  simp only [pow_zero, one_mul, Nat.sub_zero, Nat.choose_zero_right, Nat.cast_one, mul_one] at hh
  rw [hh]
  ring

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

omit [MeasurableSpace Ω] in
/-- The exact actual periodic Hamiltonian power increment is its true finite
binomial sum in the same original Hamiltonian increment. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_binomial
    (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) (l : ℕ) :
    textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U l x =
      ∑ k ∈ Finset.range l,
        textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample ^ (k + 1) *
        textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - (k + 1)) * (l.choose (k + 1) : ℝ) := by
  have hh := hpExpected_binomial_remove_zero
    (textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample)
    (textbookLangevinPeriodicHamiltonianPower U 1 x) l
  have he : textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample +
      textbookLangevinPeriodicHamiltonianPower U 1 x =
      textbookLangevinPeriodicHamiltonianPower U 1
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) := by
    exact sub_add_cancel _ _
  rw [he] at hh
  simpa only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower, pow_one] using hh

include hB hU hp in
/-- Actual periodic H^l increments are genuinely integrable near zero time,
for every natural l, from actual signed Hamiltonian moments and the binomial identity. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (l : ℕ) :
    Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U l x) P := by
  have hi (k : ℕ) := ((textbookLangevinPeriodicHamiltonianIncrement_integer_power_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x (k + 1)).mul_const
      (textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - (k + 1)))).mul_const (l.choose (k + 1) : ℝ)
  apply (integrable_finsetSum (Finset.range l) (fun k _ ↦ hi k)).congr
  exact Eventually.of_forall (fun sample ↦
    (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_binomial B U L hF γ σ T x sample l).symm)

include hB hU hp in
private theorem hpExpected_original_moment_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (k : ℕ) (hk : 1 ≤ k) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample ^ k ∂P) / T)
      (𝓝[>] 0) (𝓝
        (if k = 1 then -γ * (∑ i : Fin N, x.2 i ^ 2) + (N : ℝ) * σ ^ 2 / 2
         else if k = 2 then σ ^ 2 * (∑ i : Fin N, x.2 i ^ 2) else 0)) := by
  by_cases hk1 : k = 1
  · subst k
    simpa only [ite_true, pow_one, textbookLangevinPeriodicHamiltonianIncrement] using
      textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_mean_div_time_tendsto
        B P hB U hU hp L hF γ σ hγ x
  · by_cases hk2 : k = 2
    · subst k
      simpa using
        textbookLangevinPeriodicHamiltonianIncrement_second_moment_div_time_tendsto
          B P hB U hU hp L hF γ σ hγ x
    · simpa only [hk1, hk2, ite_false] using
        textbookLangevinPeriodicHamiltonianIncrement_integer_div_time_tendsto_zero
          B P hB U hU hp L hF γ σ hγ x k (by omega)

private theorem hpExpected_binomial_limit_sum (b A V : ℝ) (l : ℕ) (hl : 1 ≤ l) :
    (∑ k ∈ Finset.range l, b ^ (l - (k + 1)) * (l.choose (k + 1) : ℝ) *
      (if k + 1 = 1 then A else if k + 1 = 2 then V else 0)) =
      (l : ℝ) * b ^ (l - 1) * A +
        ((l : ℝ) * ((l : ℝ) - 1) / 2) * b ^ (l - 2) * V := by
  by_cases hl2 : 2 ≤ l
  · have hterm (k : ℕ) :
        b ^ (l - (k + 1)) * (l.choose (k + 1) : ℝ) *
          (if k + 1 = 1 then A else if k + 1 = 2 then V else 0) =
        (if k = 0 then (l : ℝ) * b ^ (l - 1) * A else 0) +
          (if k = 1 then (l.choose 2 : ℝ) * b ^ (l - 2) * V else 0) := by
      by_cases hk0 : k = 0
      · subst k
        simp [Nat.choose_one_right, mul_comm]
      · by_cases hk1 : k = 1
        · subst k
          simp [mul_comm]
        · have hj1 : k + 1 ≠ 1 := by omega
          have hj2 : k + 1 ≠ 2 := by omega
          simp [hk0, hk1, hj2]
    have h0sum : (∑ k ∈ Finset.range l,
        if k = 0 then (l : ℝ) * b ^ (l - 1) * A else 0) =
        (l : ℝ) * b ^ (l - 1) * A := by
      rw [Finset.sum_eq_single 0]
      · simp
      · intro k _ hk
        simp [hk]
      · intro hn
        exact False.elim (hn (Finset.mem_range.mpr (by omega)))
    have h1sum : (∑ k ∈ Finset.range l,
        if k = 1 then (l.choose 2 : ℝ) * b ^ (l - 2) * V else 0) =
        (l.choose 2 : ℝ) * b ^ (l - 2) * V := by
      rw [Finset.sum_eq_single 1]
      · simp
      · intro k _ hk
        simp [hk]
      · intro hn
        exact False.elim (hn (Finset.mem_range.mpr (by omega)))
    simp_rw [hterm]
    rw [Finset.sum_add_distrib, h0sum, h1sum, Nat.cast_choose_two ℝ l]
  · have he : l = 1 := by omega
    subst l
    simp

include hB hU hp in
/-- The actual original H^l expectation increment derivative, for every l≥1,
is derived from the true first, second, and higher Hamiltonian increment moments. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (l : ℕ) (hl : 1 ≤ l) :
    Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U l x ∂P) / T)
      (𝓝[>] 0) (𝓝
        ((l : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 1) *
          (-γ * (∑ i : Fin N, x.2 i ^ 2) + (N : ℝ) * σ ^ 2 / 2) +
        ((l : ℝ) * ((l : ℝ) - 1) / 2) *
          textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 2) *
            (σ ^ 2 * ∑ i : Fin N, x.2 i ^ 2))) := by
  let H0 := textbookLangevinPeriodicHamiltonianPower U 1 x
  let A := -γ * (∑ i : Fin N, x.2 i ^ 2) + (N : ℝ) * σ ^ 2 / 2
  let V := σ ^ 2 * ∑ i : Fin N, x.2 i ^ 2
  let c := fun k : ℕ ↦ H0 ^ (l - (k + 1)) * (l.choose (k + 1) : ℝ)
  let a := fun k : ℕ ↦ if k + 1 = 1 then A else if k + 1 = 2 then V else 0
  let E := fun (t : ℝ) (k : ℕ) ↦ c k *
    ((∫ sample, textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ t x sample ^ (k + 1) ∂P) / t)
  have hE (k : ℕ) : Tendsto (fun t ↦ E t k) (𝓝[>] 0) (𝓝 (c k * a k)) := by
    exact (hpExpected_original_moment_limit B P hB U hU hp L hF γ σ hγ x (k + 1) (by omega)).const_mul (c k)
  have hsum := tendsto_finsetSum (Finset.range l) (fun k _ ↦ hE k)
  have hvalue : (∑ k ∈ Finset.range l, c k * a k) =
      (l : ℝ) * H0 ^ (l - 1) * A + ((l : ℝ) * ((l : ℝ) - 1) / 2) * H0 ^ (l - 2) * V :=
    hpExpected_binomial_limit_sum H0 A V l hl
  rw [hvalue] at hsum
  apply hsum.congr'
  filter_upwards [self_mem_nhdsWithin,
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have hi (k : ℕ) : Integrable (fun sample ↦ c k *
      textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ t x sample ^ (k + 1)) P :=
    (textbookLangevinPeriodicHamiltonianIncrement_integer_power_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x (k + 1)).const_mul _
  have he : (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) -
        textbookLangevinPeriodicHamiltonianPower U l x) =
      (fun sample ↦ ∑ k ∈ Finset.range l, c k *
        textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ t x sample ^ (k + 1)) := by
    funext sample
    rw [textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_binomial B U L hF γ σ t x sample l]
    apply Finset.sum_congr rfl
    intro k _
    dsimp only [c, H0]
    ring
  symm
  rw [he, integral_finsetSum (Finset.range l) (fun k _ ↦ hi k)]
  simp_rw [integral_const_mul]
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro k _
  dsimp only [E]
  ring

include hB hU hp in
/-- The original Langevin differential expression is truly the actual expectation
generator on every original Hamiltonian power H^l, without assuming that identity. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (l : ℕ) (hl : 1 ≤ l) :
    Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U l x ∂P) / T)
      (𝓝[>] 0) (𝓝
        (textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l)
          (textbookLangevinPeriodicRepresentative x.1, x.2))) := by
  have hh := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x l hl
  rw [textbookLangevinHamiltonianPower_differentialOperator U (hU.differentiable (by simp)) γ σ l hl]
  convert hh using 1
  simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower, pow_one]
  ring

include hB hU hp in
/-- The physical original H^l expectation derivative uses the genuine
fluctuation-dissipation coefficient γβ⁻¹, for every l≥1. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_physical_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) (l : ℕ) (hl : 1 ≤ l) :
    Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2 * γ * β⁻¹)) x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U l x ∂P) / T)
      (𝓝[>] 0) (𝓝
        (γ * (-(l : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 1) *
          (∑ i : Fin N, x.2 i ^ 2) +
          β⁻¹ * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 2) *
            (∑ i : Fin N, x.2 i ^ 2) +
            (N : ℝ) * (l : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 1))))) := by
  have hh := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) hγ x l hl
  have hs : Real.sqrt (2 * γ * β⁻¹) ^ 2 = 2 * γ * β⁻¹ := Real.sq_sqrt (by positivity)
  rw [hs] at hh
  convert hh using 1
  ring

include hB hU hp in
/-- For the original normalized periodic potential, the actual infinitesimal
H^l expectation drift satisfies the derived Lyapunov inequality. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_actual_infinitesimal_lyapunov
    (hγ : 0 < γ) (hLower : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ x : textbookLangevinPeriodicPhase N, ∃ c : ℝ,
      Tendsto (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U l
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
          textbookLangevinPeriodicHamiltonianPower U l x ∂P) / T) (𝓝[>] 0) (𝓝 c) ∧
      c ≤ -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l x + δ := by
  obtain ⟨δ, hδ, hb⟩ := textbookLangevinHamiltonianPower_periodic_lyapunov U hU hp hLower γ σ hγ l hl
  refine ⟨δ, hδ, fun x ↦ ⟨
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l)
      (textbookLangevinPeriodicRepresentative x.1, x.2), ?_, ?_⟩⟩
  · exact textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_actual_differentialOperator_limit
      B P hB U hU hp L hF γ σ hγ x l hl
  · exact hb (textbookLangevinPeriodicRepresentative x.1, x.2)

end
end MolecularDynamics
