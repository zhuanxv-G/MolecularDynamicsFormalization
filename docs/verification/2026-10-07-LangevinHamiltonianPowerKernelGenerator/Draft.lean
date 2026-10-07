import MolecularDynamics.Chapter06.LangevinHamiltonianPowerExpectedDrift
import MolecularDynamics.Chapter06.LangevinHamiltonianPowerDrift

/-! The actual original transition kernel has the pointwise expectation generator
on its unbounded H^l family. No density or generator identity is assumed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
/-- Near zero time every actual H^l endpoint is integrable without a lower
bound on U, by its genuine integrable increment and its finite initial value. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_local_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (l : ℕ) :
    Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_increment_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x l
  apply (hi.add (integrable_const (textbookLangevinPeriodicHamiltonianPower U l x))).congr
  exact Eventually.of_forall (fun sample ↦ sub_add_cancel _ _)

include hB in
/-- The same original kernel has genuine locally finite H^l moments for every
natural l, derived through the actual endpoint law without requiring U≥1. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_local_integrable
    (hγ : 0 < γ) (T : ℝ≥0) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (l : ℕ) :
    Integrable (textbookLangevinPeriodicHamiltonianPower U l)
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact (integrable_map_measure
    (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l).aestronglyMeasurable
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)).mpr
    (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_local_integrable
      B P hB U hU hp L hF γ σ hγ T T.property (by exact_mod_cast hT1) x l)

include hB in
/-- For the actual unbounded H^l observable, the original kernel expectation
minus its initial value is exactly the genuine process increment expectation. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_increment_expectation
    (hγ : 0 < γ) (T : ℝ≥0) (hT1 : T ≤ 1)
    (x : textbookLangevinPeriodicPhase N) (l : ℕ) :
    (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
        textbookLangevinPeriodicHamiltonianPower U l x =
      ∫ sample, textbookLangevinPeriodicHamiltonianPower U l
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
          textbookLangevinPeriodicHamiltonianPower U l x ∂P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_local_integrable
    B P hB U hU hp L hF γ σ hγ T T.property (by exact_mod_cast hT1) x l
  rw [textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_expectation
    B P hB U hU hp L hF γ σ T x l, integral_sub hi (integrable_const _)]
  simp

include hB in
private theorem hpKernel_eventually_eq
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (l : ℕ) :
    (fun T : ℝ ↦ (∫ sample, textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        textbookLangevinPeriodicHamiltonianPower U l x ∂P) / T) =ᶠ[𝓝[>] 0]
    (fun T : ℝ ↦ ((∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
        textbookLangevinPeriodicHamiltonianPower U l x) / T) := by
  filter_upwards [self_mem_nhdsWithin,
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have htNN : t.toNNReal ≤ 1 := by
    exact_mod_cast (show (t.toNNReal : ℝ) ≤ (1 : ℝ) by
      simpa only [Real.coe_toNNReal t ht0.le] using ht1'.le)
  have he := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_increment_expectation
    B P hB U hU hp L hF γ σ hγ t.toNNReal htNN x l
  have he' : (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ t.toNNReal x) -
        textbookLangevinPeriodicHamiltonianPower U l x =
      ∫ sample, textbookLangevinPeriodicHamiltonianPower U l
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample) -
          textbookLangevinPeriodicHamiltonianPower U l x ∂P := by
    simpa only [Real.coe_toNNReal t ht0.le] using he
  exact congrArg (fun a : ℝ ↦ a / t) he'.symm

include hB in
/-- Every original H^l, l≥1, has the actual pointwise expectation generator of
the original transition kernel, identified with the Langevin differential expression. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (l : ℕ) (hl : 1 ≤ l) :
    Tendsto (fun T : ℝ ↦ ((∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
        textbookLangevinPeriodicHamiltonianPower U l x) / T)
      (𝓝[>] 0) (𝓝
        (textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l)
          (textbookLangevinPeriodicRepresentative x.1, x.2))) := by
  exact (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_actual_differentialOperator_limit
    B P hB U hU hp L hF γ σ hγ x l hl).congr'
      (hpKernel_eventually_eq B P hB U hU hp L hF γ σ hγ x l)

include hB in
/-- The true physical fluctuation-dissipation coefficient gives the all-H^l
pointwise infinitesimal expectation formula for the same original kernel. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_physical_increment_mean_div_time_tendsto
    (hγ : 0 < γ) (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) (l : ℕ) (hl : 1 ≤ l) :
    Tendsto (fun T : ℝ ↦ ((∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
        (Real.sqrt (2 * γ * β⁻¹)) T.toNNReal x) -
        textbookLangevinPeriodicHamiltonianPower U l x) / T)
      (𝓝[>] 0) (𝓝
        (γ * (-(l : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 1) *
          (∑ i : Fin N, x.2 i ^ 2) +
          β⁻¹ * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 2) *
            (∑ i : Fin N, x.2 i ^ 2) +
            (N : ℝ) * (l : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x ^ (l - 1))))) := by
  exact (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_physical_increment_mean_div_time_tendsto
    B P hB U hU hp L hF γ hγ β hβ x l hl).congr'
      (hpKernel_eventually_eq B P hB U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) hγ x l)

include hB in
/-- With the original potential normalized to U≥1, the actual original kernel
satisfies the genuine infinitesimal H^l Lyapunov bound. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_infinitesimal_lyapunov
    (hγ : 0 < γ) (hLower : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ x : textbookLangevinPeriodicPhase N, ∃ c : ℝ,
      Tendsto (fun T : ℝ ↦ ((∫ y, textbookLangevinPeriodicHamiltonianPower U l y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
          textbookLangevinPeriodicHamiltonianPower U l x) / T) (𝓝[>] 0) (𝓝 c) ∧
      c ≤ -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l x + δ := by
  obtain ⟨δ, hδ, hb⟩ := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_actual_infinitesimal_lyapunov
    B P hB U hU hp L hF γ σ hγ hLower l hl
  refine ⟨δ, hδ, fun x ↦ ?_⟩
  obtain ⟨c, hc, hbound⟩ := hb x
  exact ⟨c, hc.congr' (hpKernel_eventually_eq B P hB U hU hp L hF γ σ hγ x l), hbound⟩

end
end MolecularDynamics
