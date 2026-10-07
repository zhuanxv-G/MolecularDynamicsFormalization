import MolecularDynamics.Chapter06.LangevinUniformMoments
import Mathlib.Algebra.Order.Floor.Semiring

/-! The genuine continuous-time original Langevin weighted expectation bound (6.48), conditional on the original density clause on the derived energy set. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem floor_geometric_exponential (a tau : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (htau : 0 < tau) :
    ∃ rate : ℝ, 0 < rate ∧ ∀ t : ℝ, 0 ≤ t →
      a ^ (Nat.floor (t / tau)) ≤ a⁻¹ * Real.exp (-rate * t) := by
  let rate : ℝ := -Real.log a / tau
  have hlog : Real.log a < 0 := Real.log_neg ha ha1
  have hr : 0 < rate := div_pos (neg_pos.mpr hlog) htau
  refine ⟨rate, hr, fun t _ht ↦ ?_⟩
  let n := Nat.floor (t / tau)
  have hn : t / tau - 1 ≤ (n : ℝ) := by
    have hh := Nat.lt_floor_add_one (t / tau)
    dsimp only [n]
    linarith
  have hprod : (n : ℝ) * Real.log a ≤ (t / tau - 1) * Real.log a :=
    mul_le_mul_of_nonpos_right hn hlog.le
  calc
    _ = Real.exp ((n : ℝ) * Real.log a) := by rw [Real.exp_nat_mul, Real.exp_log ha]
    _ ≤ Real.exp ((t / tau - 1) * Real.log a) := Real.exp_le_exp.mpr hprod
    _ = a⁻¹ * Real.exp (-rate * t) := by
      have he : (t / tau - 1) * Real.log a = -Real.log a + -rate * t := by
        dsimp only [rate]
        ring
      rw [he, Real.exp_add, Real.exp_neg, Real.exp_log ha]

private theorem energy_weight_one_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hLower : ∀ q, 1 ≤ U q) (l : ℕ)
    (x : textbookLangevinPeriodicPhase N) :
    1 ≤ textbookLangevinPeriodicHamiltonianPower U l x := by
  have hk : 0 ≤ ∑ i : Fin N, x.2 i ^ 2 := Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)
  have hh : 1 ≤ (∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1) := by
    linarith [hLower (textbookLangevinPeriodicRepresentative x.1)]
  change 1 ≤ ((∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1)) ^ l
  simpa only [one_pow] using pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 1) hh l

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
/-- For the original measurable observables |f|≤H^l, the same actual original kernel satisfies the genuine all-time exponential bound (6.48) with constants uniform in f, time and initial phase. The invariant moment is derived; the density clause on the derived set remains explicit. -/
theorem textbookLangevinPeriodicDensityClause_original_observable_exponential_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∀ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
            (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
              (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
            ∃ M rate : ℝ, 0 < M ∧ 0 < rate ∧
              ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower U l x) →
                ∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    M * Real.exp (-rate * (T : ℝ)) * textbookLangevinPeriodicHamiltonianPower U l x := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicDensityClause_original_observable_skeleton_geometric_bound
    B P hB U hU hp L hF γ σ hLower hγ hσ
  have htau : 0 < (τ : ℝ) := hτ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  obtain ⟨A, Q, hA, hQ, hmoment⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_bounded_time
    B P hB U hU hp hLower L hF γ σ hγ τ hτ l hl
  refine ⟨D, R, hD, hR, fun ρ hρ μ hμ ↦ ?_⟩
  obtain ⟨a, ha, ha1, hsk⟩ := hd ρ hρ
  obtain ⟨C, hC, hbound⟩ := hsk μ hμ
  obtain ⟨rate, hrate, hexp⟩ := floor_geometric_exponential a τ ha ha1 htau
  let M : ℝ := C * (A + Q) * a⁻¹
  have hM : 0 < M := mul_pos (mul_pos hC (add_pos hA hQ)) (inv_pos.mpr ha)
  refine ⟨M, rate, hM, hrate, fun f hf hdom T x ↦ ?_⟩
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
  let V := textbookLangevinPeriodicHamiltonianPower U l
  have hVi (s : ℝ≥0) (z : textbookLangevinPeriodicPhase N) : Integrable V (K s z) :=
    textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ hγ s z l hl
  have hfi (s : ℝ≥0) (z : textbookLangevinPeriodicPhase N) : Integrable f (K s z) := by
    apply (hVi s z).mono' hf.aestronglyMeasurable
    exact Eventually.of_forall (fun y ↦ by simpa only [Real.norm_eq_abs] using hdom y)
  let n := Nat.floor ((T : ℝ) / (τ : ℝ))
  let S : ℝ≥0 := (n : ℝ≥0) * τ
  have hST : S ≤ T := by
    change (n : ℝ) * (τ : ℝ) ≤ (T : ℝ)
    exact (le_div_iff₀ htau).mp (Nat.floor_le (div_nonneg T.property htau.le))
  let r : ℝ≥0 := T - S
  have hrS : r + S = T := tsub_add_cancel_of_le hST
  have hrτ : r ≤ τ := by
    change ((T - S : ℝ≥0) : ℝ) ≤ (τ : ℝ)
    rw [NNReal.coe_sub hST]
    change (T : ℝ) - (n : ℝ) * (τ : ℝ) ≤ (τ : ℝ)
    have hh : (T : ℝ) < ((n : ℝ) + 1) * (τ : ℝ) :=
      (div_lt_iff₀ htau).mp (Nat.lt_floor_add_one ((T : ℝ) / (τ : ℝ)))
    nlinarith
  have : IsMarkovKernel (K r) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ r
  have : IsMarkovKernel (K S) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
  have hCK : K T = K S ∘ₖ K r := by
    rw [← hrS]
    exact textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ r S
  have hi : Integrable f ((K S ∘ₖ K r) x) := by rw [← hCK]; exact hfi T x
  let F := fun z ↦ ∫ y, f y ∂K S z
  let m := ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))
  have hF : Integrable F (K r x) := hi.integral_comp
  have hdiff : Integrable (fun z ↦ F z - m) (K r x) := hF.sub (integrable_const m)
  have hEq : (∫ y, f y ∂K T x) - m = ∫ z, F z - m ∂K r x := by
    rw [hCK, Kernel.integral_comp hi, integral_sub hF (integrable_const m)]
    simp only [F, integral_const, probReal_univ, one_smul]
  have hVx : 1 ≤ V x := energy_weight_one_le U hLower l x
  have hAQ : A * V x + Q ≤ (A + Q) * V x := by
    have hh := mul_le_mul_of_nonneg_left hVx hQ.le
    nlinarith
  have hb (z : textbookLangevinPeriodicPhase N) : ‖F z - m‖ ≤ C * a ^ n * V z :=
    hbound f hf hdom n z
  have hCV : Integrable (fun z ↦ C * a ^ n * V z) (K r x) := (hVi r x).const_mul _
  have hp : 0 ≤ C * a ^ n := mul_nonneg hC.le (pow_nonneg ha.le n)
  have hV0 : 0 ≤ V x := le_trans (by norm_num) hVx
  calc
    _ = ‖∫ z, F z - m ∂K r x‖ := congrArg norm hEq
    _ ≤ ∫ z, ‖F z - m‖ ∂K r x := norm_integral_le_integral_norm _
    _ ≤ ∫ z, C * a ^ n * V z ∂K r x := integral_mono_ae hdiff.norm hCV (Eventually.of_forall hb)
    _ = C * a ^ n * ∫ z, V z ∂K r x := integral_const_mul _ _
    _ ≤ C * a ^ n * (A * V x + Q) := mul_le_mul_of_nonneg_left (hmoment r hrτ x) hp
    _ ≤ C * a ^ n * ((A + Q) * V x) := mul_le_mul_of_nonneg_left hAQ hp
    _ = (C * (A + Q) * V x) * a ^ n := by ring
    _ ≤ (C * (A + Q) * V x) * (a⁻¹ * Real.exp (-rate * (T : ℝ))) :=
      mul_le_mul_of_nonneg_left (hexp T T.property) (mul_nonneg (mul_nonneg hC.le (add_nonneg hA.le hQ.le)) hV0)
    _ = _ := by dsimp only [M]; ring

include hB in
/-- A genuinely constructed full-time invariant law has the original all-time H^l-observable exponential bound whenever the original density clause holds on the corresponding derived energy set. No existence, invariant-moment or exponential-bound premise is used. -/
theorem textbookLangevinPeriodicDensityClause_invariant_exists_with_original_exponential_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
      (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
      ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
        ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
          ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
            textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
              {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
            ∃ M rate : ℝ, 0 < M ∧ 0 < rate ∧
              ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower U l x) →
                ∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    M * Real.exp (-rate * (T : ℝ)) * textbookLangevinPeriodicHamiltonianPower U l x := by
  obtain ⟨μ, hμ⟩ := textbookLangevinPeriodicTransitionKernel_invariant_exists
    B P hB U hU hp L hF γ σ hLower hγ
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicDensityClause_original_observable_exponential_bound
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨μ, hμ, τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hb⟩ := h l hl
  exact ⟨D, R, hD, hR, fun ρ hρ ↦ hb ρ hρ μ hμ⟩


include hB in
/-- For any original smooth periodic U, a genuinely derived additive energy normalization gives the same original kernel and a genuinely constructed invariant law with the all-time weighted exponential bound. The weight is H(U+c)^l, explicitly. -/
theorem textbookLangevinPeriodicDensityClause_original_exponential_bound_unrestricted_potential
    (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ c : ℝ, (∀ q, 1 ≤ U q + c) ∧
      ∃ hFc : LipschitzWith L (textbookPotentialForce (fun q ↦ U q + c)),
        ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
          (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
          ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
            ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
              ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
                textbookLangevinPeriodicDensityClause B P (fun q ↦ U q + c) (hU.add contDiff_const)
                  (textbookUnitPeriodicPotential_add_const U hp c) L hFc γ σ
                  {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l z ≤ R} ρ →
                ∃ M rate : ℝ, 0 < M ∧ 0 < rate ∧
                  ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                    (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l x) →
                    ∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                      ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) -
                          ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                        M * Real.exp (-rate * (T : ℝ)) * textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l x := by
  obtain ⟨c, hc⟩ := textbookUnitPeriodicPotential_normalization U hU.continuous hp
  let V := fun q ↦ U q + c
  have hV : ContDiff ℝ ∞ V := hU.add contDiff_const
  have hpV : textbookUnitPeriodicPotential V := textbookUnitPeriodicPotential_add_const U hp c
  have hFV : LipschitzWith L (textbookPotentialForce V) := by
    dsimp only [V]
    rw [textbookPotentialForce_add_const]
    exact hF
  obtain ⟨μ, hμ, τ, hτ, hg⟩ := textbookLangevinPeriodicDensityClause_invariant_exists_with_original_exponential_bound
    B P hB V hV hpV L hFV γ σ hc hγ hσ
  have hK (T : ℝ≥0) :
      textbookLangevinPeriodicTransitionKernel B P V hV hpV L hFV γ σ T =
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T :=
    textbookLangevinPeriodicTransitionKernel_add_const B P hB U hU hp L hF c L hFV γ σ T
  refine ⟨c, hc, hFV, μ, (fun T ↦ ?_), τ, hτ, fun l hl ↦ ?_⟩
  · rw [← hK]
    exact hμ T
  · obtain ⟨D, R, hD, hR, hh⟩ := hg l hl
    refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
    obtain ⟨M, rate, hM, hr, hb⟩ := hh ρ hρ
    refine ⟨M, rate, hM, hr, fun f hf hdom T x ↦ ?_⟩
    rw [← hK]
    exact hb f hf hdom T x

end
end MolecularDynamics
