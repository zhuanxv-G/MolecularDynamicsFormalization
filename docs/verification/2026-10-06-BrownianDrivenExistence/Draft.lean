import MolecularDynamics.Chapter06.BrownianSDECoefficients
import Mathlib.Analysis.ODE.ExistUnique
import Mathlib.Topology.Order.ProjIcc
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! Genuine specified-interval pathwise solutions for the original-mass Brownian model.
The private finite-interval ODE proof is used only for this actual additive-noise equation. -/

open Set Filter Metric MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics
noncomputable section

private theorem uniform_local_exists {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (f : ℝ → E → E) (K : ℝ≥0)
    (hK : ∀ t, LipschitzWith K (f t)) (hc : ∀ x, Continuous (fun t ↦ f t x)) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ t₀ x₀, ∃ α : ℝ → E, α t₀ = x₀ ∧
      ∀ t ∈ Ioo (t₀ - δ) (t₀ + δ), HasDerivAt α (f t (α t)) t := by
  let δ : ℝ := 1 / (2 * ((K : ℝ) + 1))
  have hδ : 0 < δ := by dsimp [δ]; positivity
  have hKd : (K : ℝ) * δ ≤ 1 / 2 := by
    have he : δ * (2 * ((K : ℝ) + 1)) = 1 := by
      dsimp [δ]; field_simp
    nlinarith [K.property]
  refine ⟨δ, hδ, fun t₀ x₀ ↦ ?_⟩
  obtain ⟨M, hM⟩ := isCompact_Icc.exists_bound_of_continuousOn
    ((hc x₀).continuousOn : ContinuousOn (fun t ↦ f t x₀) (Icc (t₀ - δ) (t₀ + δ)))
  have ht₀ : t₀ ∈ Icc (t₀ - δ) (t₀ + δ) := by constructor <;> linarith
  have hM0 : 0 ≤ M := (norm_nonneg (f t₀ x₀)).trans (hM t₀ ht₀)
  let a : ℝ≥0 := ⟨2 * δ * M + 1, by positivity⟩
  let B : ℝ≥0 := K * a + ⟨M, hM0⟩
  have hf : IsPicardLindelof f ⟨t₀, ht₀⟩ x₀ a 0 B K := by
    refine ⟨fun t _ ↦ (hK t).lipschitzOnWith, fun x _ ↦ (hc x).continuousOn, ?_, ?_⟩
    · intro t ht x hx
      calc
        ‖f t x‖ ≤ ‖f t x - f t x₀‖ + ‖f t x₀‖ := norm_le_norm_sub_add _ _
        _ ≤ (K : ℝ) * ‖x - x₀‖ + M := add_le_add ((hK t).norm_sub_le x x₀) (hM t ht)
        _ ≤ (K : ℝ) * (a : ℝ) + M :=
          add_le_add (mul_le_mul_of_nonneg_left (mem_closedBall_iff_norm.mp hx) K.property) le_rfl
        _ = B := rfl
    · have hprod := mul_le_mul_of_nonneg_right hKd a.property
      change (K * (a : ℝ) + M) * max (t₀ + δ - t₀) (t₀ - (t₀ - δ)) ≤ (a : ℝ) - 0
      have hmax : max (t₀ + δ - t₀) (t₀ - (t₀ - δ)) = δ := by
        have h1 : t₀ + δ - t₀ = δ := by ring
        have h2 : t₀ - (t₀ - δ) = δ := by ring
        rw [h1, h2, max_self]
      rw [hmax]
      change (K * (2 * δ * M + 1) + M) * δ ≤ (2 * δ * M + 1) - 0
      change (K : ℝ) * δ * (2 * δ * M + 1) ≤ (1 / 2 : ℝ) * (2 * δ * M + 1) at hprod
      nlinarith
  obtain ⟨α, hα0, hα⟩ := hf.exists_eq_forall_mem_Icc_hasDerivWithinAt₀
  refine ⟨α, hα0, fun t ht ↦ ?_⟩
  exact (hα t ⟨ht.1.le, ht.2.le⟩).hasDerivAt (Icc_mem_nhds ht.1 ht.2)

private theorem join_derivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (α β : ℝ → E) (τ : ℝ) (v : E) (hα : HasDerivAt α v τ) (hβ : HasDerivAt β v τ)
    (he : β τ = α τ) : HasDerivAt (fun t ↦ if t ≤ τ then α t else β t) v τ := by
  classical
  have hl : HasDerivWithinAt (fun t ↦ if t ≤ τ then α t else β t) v (Iic τ) τ :=
    hα.hasDerivWithinAt.congr (fun t ht ↦ by simp [show t ≤ τ from ht]) (by simp)
  have hr : HasDerivWithinAt (fun t ↦ if t ≤ τ then α t else β t) v (Ici τ) τ := by
    apply hβ.hasDerivWithinAt.congr
    · intro t ht
      by_cases h : t ≤ τ
      · have hte : t = τ := le_antisymm h ht
        subst t
        simp [he]
      · simp [h]
    · simp [he]
  simpa only [Iic_union_Ici, hasDerivWithinAt_univ] using hl.union hr

private theorem finite_interval_exists {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : ℝ → E → E) (δ : ℝ) (hδ : 0 < δ)
    (hl : ∀ t₀ x₀, ∃ α : ℝ → E, α t₀ = x₀ ∧
      ∀ t ∈ Ioo (t₀ - δ) (t₀ + δ), HasDerivAt α (f t (α t)) t)
    (x₀ : E) (T : ℝ) :
    ∃ α : ℝ → E, α 0 = x₀ ∧ ∀ t ∈ Icc 0 T, HasDerivAt α (f t (α t)) t := by
  classical
  have hn (n : ℕ) : ∃ α : ℝ → E, α 0 = x₀ ∧
      ∀ t ∈ Ioo (-δ) (((n : ℝ) + 1) * δ / 2), HasDerivAt α (f t (α t)) t := by
    induction n with
    | zero =>
      obtain ⟨α, hα0, hα⟩ := hl 0 x₀
      refine ⟨α, hα0, fun t ht ↦ hα t ?_⟩
      simp only [zero_sub, zero_add]
      exact ⟨ht.1, by norm_num at ht; linarith [ht.2]⟩
    | succ n ih =>
      obtain ⟨α, hα0, hα⟩ := ih
      let τ : ℝ := (n : ℝ) * δ / 2
      have hτ0 : 0 ≤ τ := by dsimp [τ]; positivity
      have hτ : τ ∈ Ioo (-δ) (((n : ℝ) + 1) * δ / 2) := by
        dsimp [τ]; constructor <;> nlinarith [Nat.cast_nonneg (α := ℝ) n]
      obtain ⟨β, hβ0, hβ⟩ := hl τ (α τ)
      let α' : ℝ → E := fun t ↦ if t ≤ τ then α t else β t
      refine ⟨α', by simp [α', hτ0, hα0], fun t ht ↦ ?_⟩
      have hupper : t < τ + δ := by dsimp [τ]; simp only [Nat.cast_succ] at ht; linarith [ht.2]
      by_cases hlt : t < τ
      · have hd := hα t ⟨ht.1, by dsimp [τ] at hlt; linarith⟩
        have he : α' =ᶠ[𝓝 t] α := by
          filter_upwards [Iio_mem_nhds hlt] with s hs
          simp [α', (show s < τ from hs).le]
        have hval : α' t = α t := by simp [α', hlt.le]
        simpa only [hval] using hd.congr_of_eventuallyEq he
      · by_cases heq : t = τ
        · subst t
          have hval : α' τ = α τ := by simp [α']
          have hdβ : HasDerivAt β (f τ (α τ)) τ := by
            simpa only [hβ0] using hβ τ (by constructor <;> linarith)
          simpa only [hval] using join_derivative α β τ (f τ (α τ)) (hα τ hτ) hdβ hβ0
        · have hgt : τ < t := lt_of_le_of_ne (le_of_not_gt hlt) (Ne.symm heq)
          have hd := hβ t ⟨by linarith, hupper⟩
          have he : α' =ᶠ[𝓝 t] β := by
            filter_upwards [Ioi_mem_nhds hgt] with s hs
            simp [α', not_le.mpr (show τ < s from hs)]
          have hval : α' t = β t := by simp [α', not_le.mpr hgt]
          simpa only [hval] using hd.congr_of_eventuallyEq he
  obtain ⟨n, hnT⟩ := exists_nat_gt (2 * T / δ)
  have hupper : T < ((n : ℝ) + 1) * δ / 2 := by
    have he := (div_lt_iff₀ hδ).mp hnT
    nlinarith
  obtain ⟨α, hα0, hα⟩ := hn n
  exact ⟨α, hα0, fun t ht ↦ hα t ⟨by linarith [ht.1], ht.2.trans_lt hupper⟩⟩


variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- The actual noise-compensated first-order field of the original gamma-one Brownian equation. -/
def textbookBrownianDrivenField (W : ℝ → (Fin Nc → ℝ)) (t : ℝ) (z : Fin Nc → ℝ) : Fin Nc → ℝ :=
  textbookBrownianSDEDrift m U (z + textbookBrownianSDENoise m β (W t - W 0))

include hU hPU in
/-- Original smooth periodicity gives an actual uniform-in-time Lipschitz constant for every compensated driving field. -/
theorem textbookBrownianDrivenField_lipschitz (W : ℝ → (Fin Nc → ℝ)) :
    ∃ L : ℝ≥0, ∀ t : ℝ, LipschitzWith L (textbookBrownianDrivenField m U β W t) := by
  obtain ⟨L, hL⟩ := textbookBrownianSDEDrift_lipschitz m U hU hPU
  refine ⟨L, fun t ↦ ?_⟩
  apply LipschitzWith.of_dist_le_mul
  intro x y
  let c := textbookBrownianSDENoise m β (W t - W 0)
  change dist (textbookBrownianSDEDrift m U (x + c))
      (textbookBrownianSDEDrift m U (y + c)) ≤ (L : ℝ) * dist x y
  simpa only [dist_add_right] using hL.dist_le_mul (x + c) (y + c)

include hU hPU in
/-- Every genuine continuous driving path gives a field continuous in actual time at every compensated state. -/
theorem textbookBrownianDrivenField_time_continuous
    (W : ℝ → (Fin Nc → ℝ)) (hW : Continuous W) :
    ∀ z : Fin Nc → ℝ, Continuous (fun t : ℝ ↦ textbookBrownianDrivenField m U β W t z) := by
  obtain ⟨L, hL⟩ := textbookBrownianSDEDrift_lipschitz m U hU hPU
  intro z
  exact hL.continuous.comp (continuous_const.add
    ((textbookBrownianSDENoise m β).continuous.comp (hW.sub continuous_const)))

include hU hPU in
/-- The original compensated equation has an actual solution on every prescribed finite interval, with its initial value and every genuine derivative proved. -/
theorem textbookBrownianDrivenField_exists
    (W : ℝ → (Fin Nc → ℝ)) (hW : Continuous W) (T : ℝ) (x : Fin Nc → ℝ) :
    ∃ α : ℝ → (Fin Nc → ℝ), α 0 = x ∧
      ∀ t ∈ Icc 0 T, HasDerivAt α (textbookBrownianDrivenField m U β W t (α t)) t := by
  obtain ⟨L, hL⟩ := textbookBrownianDrivenField_lipschitz m U hU hPU β W
  have hc := textbookBrownianDrivenField_time_continuous m U hU hPU β W hW
  obtain ⟨δ, hδ, hl⟩ := uniform_local_exists (textbookBrownianDrivenField m U β W) L hL hc
  exact finite_interval_exists (textbookBrownianDrivenField m U β W) δ hδ hl x T

include hm hU hPU hβ in
/-- Every actual finite continuous driving path admits a genuine original-mass additive-noise Brownian integral solution.
The original positive diagonal covariance is proved too; probability-law and stochastic-generator identification remain separate. -/
theorem textbookBrownianIntegralSolution_exists
    (T : ℝ) (hT : 0 ≤ T) (x : Fin Nc → ℝ)
    (W : ℝ → (Fin Nc → ℝ)) (hW : ContinuousOn W (Icc 0 T)) :
    ∃ q : ℝ → (Fin Nc → ℝ), ContinuousOn q (Icc 0 T) ∧ q 0 = x ∧
      (∀ t ∈ Icc 0 T, q t = x + (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) +
        textbookBrownianSDENoise m β (W t - W 0)) ∧
      (∀ i : Fin Nc, 0 < textbookBrownianSDENoiseAmplitude m β i ∧
        textbookBrownianSDENoiseAmplitude m β i ^ 2 = 2 * β⁻¹ * (m i)⁻¹) := by
  let W' : ℝ → (Fin Nc → ℝ) := fun t ↦ W (projIcc 0 T hT t)
  have hWc : Continuous W' := hW.comp_continuous
    (continuous_subtype_val.comp continuous_projIcc) (fun t ↦ (projIcc 0 T hT t).property)
  have hWe (t : ℝ) (ht : t ∈ Icc 0 T) : W' t = W t := by
    dsimp [W']; rw [projIcc_of_mem hT ht]
  obtain ⟨α, hα0, hα⟩ := textbookBrownianDrivenField_exists m U hU hPU β W' hWc T x
  let q : ℝ → (Fin Nc → ℝ) := fun t ↦ α t + textbookBrownianSDENoise m β (W' t - W' 0)
  have hαc : ContinuousOn α (Icc 0 T) := fun t ht ↦ (hα t ht).continuousAt.continuousWithinAt
  have hqc : ContinuousOn q (Icc 0 T) :=
    hαc.fun_add ((textbookBrownianSDENoise m β).continuous.comp
      (hWc.sub continuous_const)).continuousOn
  obtain ⟨L, hL⟩ := textbookBrownianSDEDrift_lipschitz m U hU hPU
  have hbc : ContinuousOn (fun t ↦ textbookBrownianSDEDrift m U (q t)) (Icc 0 T) :=
    hL.continuous.comp_continuousOn hqc
  refine ⟨q, hqc, ?_, ?_, fun i ↦ ⟨textbookBrownianSDENoiseAmplitude_pos m hm β hβ i,
    textbookBrownianSDENoiseAmplitude_sq m hm β hβ i⟩⟩
  · dsimp [q]
    rw [hα0]
    simp only [sub_self, map_zero, add_zero]
  · intro t ht
    have hseg : uIcc 0 t ⊆ Icc 0 T := by
      rw [uIcc_of_le ht.1]
      exact Icc_subset_Icc le_rfl ht.2
    have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun s hs ↦ hα s (hseg hs)) ((hbc.mono hseg).intervalIntegrable)
    change (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) = α t - α 0 at he
    rw [he, hα0]
    dsimp [q]
    rw [hWe t ht, hWe 0 ⟨le_rfl, hT⟩]
    abel

end
end MolecularDynamics
