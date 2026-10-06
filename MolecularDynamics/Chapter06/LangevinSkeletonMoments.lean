import MolecularDynamics.Chapter06.LangevinHamiltonianPowerDrift
import Mathlib.MeasureTheory.Measure.Tight
import Mathlib.Probability.Kernel.Composition.IntegralCompProd

/-! Actual skeleton moment and tightness dependencies for original Langevin Theorem 6.2, without any density or drift premise. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
/-- The true Chapman–Kolmogorov law and the derived physical H^l drift give an actual geometric moment bound along one common skeleton for every required l. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_moment_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D : ℝ, 0 < D ∧ ∀ (n : ℕ) (x : textbookLangevinPeriodicPhase N),
        (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
          ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) ≤
          (1 / 2 : ℝ) ^ n * textbookLangevinPeriodicHamiltonianPower U l x +
            2 * D * (1 - (1 / 2 : ℝ) ^ n) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_common_skeleton_drift
    B P hB U hU hp hLower L hF γ σ hγ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, hD, hd⟩ := h l hl
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
  let V := textbookLangevinPeriodicHamiltonianPower U l
  have hInt (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) : Integrable V (K T x) :=
    textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable
      B P hB U hU hp hLower L hF γ σ hγ T x l hl
  refine ⟨D, hD, fun n x ↦ ?_⟩
  induction n with
  | zero =>
    rw [Nat.cast_zero, zero_mul, textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ,
      Kernel.id_apply, integral_dirac]
    simp
  | succ n hn =>
    let S : ℝ≥0 := (n : ℝ≥0) * τ
    have : IsMarkovKernel (K S) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
    have : IsMarkovKernel (K τ) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ τ
    have hstep : ((n + 1 : ℕ) : ℝ≥0) * τ = S + τ := by
      dsimp only [S]
      push_cast
      ring
    have hCK : K (S + τ) = K τ ∘ₖ K S :=
      textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ S τ
    have hc : Integrable V ((K τ ∘ₖ K S) x) := by rw [← hCK]; exact hInt (S + τ) x
    have hi : Integrable (fun y ↦ ∫ z, V z ∂K τ y) (K S x) := hc.integral_comp
    have hb : Integrable (fun y ↦ (1 / 2 : ℝ) * V y + D) (K S x) :=
      ((hInt S x).const_mul (1 / 2 : ℝ)).add (integrable_const D)
    calc
      _ = ∫ y, ∫ z, V z ∂K τ y ∂K S x := by
        change (∫ y, V y ∂K (((n + 1 : ℕ) : ℝ≥0) * τ) x) = _
        rw [hstep, hCK]
        exact Kernel.integral_comp hc
      _ ≤ ∫ y, (1 / 2 : ℝ) * V y + D ∂K S x := integral_mono hi hb hd
      _ = (1 / 2 : ℝ) * (∫ y, V y ∂K S x) + D := by
        rw [integral_add ((hInt S x).const_mul (1 / 2 : ℝ)) (integrable_const D),
          integral_const_mul (1 / 2 : ℝ)]
        simp
      _ ≤ (1 / 2 : ℝ) * ((1 / 2 : ℝ) ^ n * V x + 2 * D * (1 - (1 / 2 : ℝ) ^ n)) + D :=
        add_le_add (mul_le_mul_of_nonneg_left hn (by norm_num)) le_rfl
      _ = _ := by change _ = (1 / 2 : ℝ) ^ (n + 1) * V x + 2 * D * (1 - (1 / 2 : ℝ) ^ (n + 1)); rw [pow_succ]; ring

include hB in
/-- The same genuine skeleton laws have a uniform physical compact-energy tail estimate, derived from the actual geometric moments and Markov's inequality. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_tail_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D : ℝ, 0 < D ∧ ∀ (n : ℕ) (x : textbookLangevinPeriodicPhase N) (R : ℝ), 0 < R →
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x
          {y : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l y ≤ R}ᶜ ≤
          ENNReal.ofReal ((textbookLangevinPeriodicHamiltonianPower U l x + 2 * D) / R) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_moment_bound
    B P hB U hU hp L hF γ σ hLower hγ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, hD, hd⟩ := h l hl
  refine ⟨D, hD, fun n x R hR ↦ ?_⟩
  let μ := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x
  let V := textbookLangevinPeriodicHamiltonianPower U l
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
  have : IsProbabilityMeasure μ := by dsimp only [μ]; infer_instance
  have hV0 (y : textbookLangevinPeriodicPhase N) : 0 ≤ V y :=
    (textbookLangevinPeriodicHamiltonianPower_pos U hLower l y).le
  have hVint : Integrable V μ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable
    B P hB U hU hp hLower L hF γ σ hγ _ x l hl
  have hpn : 0 ≤ (1 / 2 : ℝ) ^ n := by positivity
  have hpone : (1 / 2 : ℝ) ^ n ≤ 1 := pow_le_one₀ (by norm_num) (by norm_num)
  have hm : (∫ y, V y ∂μ) ≤ V x + 2 * D := by
    have hpv := mul_le_mul_of_nonneg_right hpone (hV0 x)
    have hpD := mul_nonneg hpn hD.le
    have hh := hd n x
    change (∫ y, V y ∂μ) ≤ (1 / 2 : ℝ) ^ n * V x + 2 * D * (1 - (1 / 2 : ℝ) ^ n) at hh
    nlinarith
  have hmark := mul_meas_ge_le_integral_of_nonneg (Eventually.of_forall hV0) hVint R
  have htail : μ.real {y | V y ≤ R}ᶜ ≤ (V x + 2 * D) / R := by
    have hsub : {y | V y ≤ R}ᶜ ⊆ {y | R ≤ V y} := fun y hy ↦ (lt_of_not_ge (show ¬ V y ≤ R from hy)).le
    have hmono := measureReal_mono (μ := μ) hsub
    have hbound : μ.real {y | R ≤ V y} ≤ (V x + 2 * D) / R := by
      apply (le_div_iff₀ hR).mpr
      nlinarith
    exact hmono.trans hbound
  calc
    _ = ENNReal.ofReal (μ.real {y | V y ≤ R}ᶜ) := (ENNReal.ofReal_toReal (measure_ne_top μ _)).symm
    _ ≤ _ := ENNReal.ofReal_le_ofReal htail

include hB in
/-- For every original initial phase, the actual skeleton transition laws form a tight family, derived from the true physical energy moments without a density premise or an invariant-law conclusion. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_isTight
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ x : textbookLangevinPeriodicPhase N,
      IsTightMeasureSet (Set.range (fun n : ℕ ↦
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x)) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_tail_bound
    B P hB U hU hp L hF γ σ hLower hγ
  obtain ⟨D, hD, ht⟩ := h 1 le_rfl
  refine ⟨τ, hτ, fun x ↦ ?_⟩
  rw [isTightMeasureSet_iff_exists_isCompact_measure_compl_le]
  intro ε hε
  by_cases he : ε = ⊤
  · subst ε
    exact ⟨∅, isCompact_empty, fun μ _ ↦ le_top⟩
  have hε0 : 0 < ε.toReal := ENNReal.toReal_pos hε.ne' he
  let M := textbookLangevinPeriodicHamiltonianPower U 1 x + 2 * D
  have hM : 0 < M := by
    have hx := textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 x
    dsimp only [M]
    linarith
  let R := M / ε.toReal + 1
  have hR : 0 < R := by dsimp only [R]; positivity
  have hcancel : ε.toReal * R = M + ε.toReal := by
    dsimp only [R]
    field_simp
  have hratio : M / R ≤ ε.toReal := by
    apply (div_le_iff₀ hR).mpr
    linarith
  refine ⟨{y : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U 1 y ≤ R},
    textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower 1 le_rfl R, ?_⟩
  rintro μ ⟨n, rfl⟩
  calc
    _ ≤ ENNReal.ofReal (M / R) := ht n x R hR
    _ ≤ ENNReal.ofReal ε.toReal := ENNReal.ofReal_le_ofReal hratio
    _ = ε := ENNReal.ofReal_toReal he

end
end MolecularDynamics
