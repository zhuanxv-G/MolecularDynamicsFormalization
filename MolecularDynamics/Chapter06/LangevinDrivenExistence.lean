import MolecularDynamics.Chapter06.LangevinPeriodicLift
import Mathlib.Analysis.ODE.ExistUnique
import Mathlib.Topology.Order.ProjIcc

/-! Actual specified-interval existence for continuous additive noise, needed in the periodic Langevin model. -/

open Set Filter Metric MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

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

/-- The actual compensated Langevin field admits a solution on every prescribed finite interval for continuous noise and globally Lipschitz force. -/
theorem textbookLangevinDrivenField_exists {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (x : textbookLangevinPhase Nc) (W : ℝ → (Fin Nc → ℝ)) (hW : Continuous W) :
    ∃ α : ℝ → textbookLangevinPhase Nc, α 0 = x ∧
      ∀ t ∈ Icc 0 T, HasDerivAt α (textbookLangevinDrivenField U γ σ W t (α t)) t := by
  have hc (z : textbookLangevinPhase Nc) : Continuous (fun t ↦ textbookLangevinDrivenField U γ σ W t z) := by
    unfold textbookLangevinDrivenField
    fun_prop
  obtain ⟨δ, hδ, hl⟩ := uniform_local_exists (textbookLangevinDrivenField U γ σ W)
    (1 + L + ‖γ‖₊) (textbookLangevinDrivenField_lipschitz U L hF γ σ W) hc
  exact finite_interval_exists _ δ hδ hl x T

/-- The true additive-noise integral equations have an actual solution on every specified nonnegative interval; noise need only be continuous on that interval. -/
theorem textbookLangevinIntegralSolution_exists_globalLip {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase Nc)
    (W : ℝ → (Fin Nc → ℝ)) (hW : ContinuousOn W (Icc 0 T)) (hW0 : W 0 = 0) :
    ∃ q p : ℝ → (Fin Nc → ℝ), textbookLangevinIntegralSolution U γ σ T x W q p := by
  let W' : ℝ → (Fin Nc → ℝ) := fun t ↦ W (projIcc 0 T hT t)
  have hWc : Continuous W' := hW.comp_continuous
    (continuous_subtype_val.comp continuous_projIcc) (fun t ↦ (projIcc 0 T hT t).property)
  have hWe (t : ℝ) (ht : t ∈ Icc 0 T) : W' t = W t := by
    dsimp [W']; rw [projIcc_of_mem hT ht]
  obtain ⟨α, hα0, hα⟩ := textbookLangevinDrivenField_exists U L hF γ σ T x W' hWc
  let q : ℝ → (Fin Nc → ℝ) := fun t ↦ (α t).1
  let p : ℝ → (Fin Nc → ℝ) := fun t ↦ (α t).2 + σ • W' t
  have hαc : ContinuousOn α (Icc 0 T) := fun t ht ↦ (hα t ht).continuousAt.continuousWithinAt
  have hqc : ContinuousOn q (Icc 0 T) := hαc.fst
  have hpc : ContinuousOn p (Icc 0 T) := hαc.snd.fun_add (hWc.continuousOn.const_smul σ)
  have hbc : ContinuousOn (fun t ↦ textbookPotentialForce U (q t) - γ • p t) (Icc 0 T) :=
    (hF.continuous.comp_continuousOn hqc).fun_sub (hpc.const_smul γ)
  have hdq (t : ℝ) (ht : t ∈ Icc 0 T) : HasDerivAt q (p t) t :=
    (ContinuousLinearMap.fst ℝ (Fin Nc → ℝ) (Fin Nc → ℝ)).hasFDerivAt.comp_hasDerivAt t (hα t ht)
  have hdv (t : ℝ) (ht : t ∈ Icc 0 T) :
      HasDerivAt (fun t ↦ (α t).2) (textbookPotentialForce U (q t) - γ • p t) t :=
    (ContinuousLinearMap.snd ℝ (Fin Nc → ℝ) (Fin Nc → ℝ)).hasFDerivAt.comp_hasDerivAt t (hα t ht)
  refine ⟨q, p, hqc, hpc, hW, hW0, ?_, ?_⟩
  · intro t ht
    have hseg : uIcc 0 t ⊆ Icc 0 T := by
      rw [uIcc_of_le ht.1]; exact Icc_subset_Icc le_rfl ht.2
    have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun s hs ↦ hdq s (hseg hs)) ((hpc.mono hseg).intervalIntegrable)
    have hq0 : q 0 = x.1 := congrArg Prod.fst hα0
    rw [he, hq0]
    abel
  · intro t ht
    have hseg : uIcc 0 t ⊆ Icc 0 T := by
      rw [uIcc_of_le ht.1]; exact Icc_subset_Icc le_rfl ht.2
    have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun s hs ↦ hdv s (hseg hs)) ((hbc.mono hseg).intervalIntegrable)
    have hv0 : (α 0).2 = x.2 := congrArg Prod.snd hα0
    rw [he, hv0, ← hWe t ht]
    dsimp [p]
    abel

/-- Genuine smooth periodicity supplies the Lipschitz force bound and hence constructs an actual periodic integral solution for every continuous driving path. -/
theorem textbookLangevinPeriodicIntegralSolution_exists {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase Nc)
    (W : ℝ → (Fin Nc → ℝ)) (hW : ContinuousOn W (Icc 0 T)) (hW0 : W 0 = 0) :
    ∃ q : ℝ → UnitAddTorus (Fin Nc), ∃ p : ℝ → (Fin Nc → ℝ),
      textbookLangevinPeriodicIntegralSolution U γ σ T x W q p := by
  obtain ⟨L, hL⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hP
  obtain ⟨q, p, hq, hp, hWc, hWzero, hqeq, hpeq⟩ :=
    textbookLangevinIntegralSolution_exists_globalLip U L hL γ σ T hT
      (textbookLangevinPeriodicRepresentative x.1, x.2) W hW hW0
  let Q : ℝ → UnitAddTorus (Fin Nc) := fun t i ↦ (q t i : UnitAddCircle)
  have hforce (s : ℝ) : textbookLangevinPeriodicForce U (Q s) = textbookPotentialForce U (q s) :=
    textbookLangevinPeriodicForce_lift U hU hP (q s)
  refine ⟨Q, p, hp, hWc, hWzero, ?_, ?_⟩
  · intro t ht
    dsimp [Q]
    rw [hqeq t ht]
    ext i
    change ((textbookLangevinPeriodicRepresentative x.1 i + (∫ s in 0..t, p s) i : ℝ) : UnitAddCircle) = _
    rw [AddCircle.coe_add]
    exact congrArg (fun z : UnitAddCircle ↦ z + ((∫ s in 0..t, p s) i : UnitAddCircle))
      (congrFun (textbookLangevinPeriodicRepresentative_projects x.1) i)
  · intro t ht
    have hint : (∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s) =
        ∫ s in 0..t, textbookLangevinPeriodicForce U (Q s) - γ • p s := by
      apply intervalIntegral.integral_congr
      intro s _
      change textbookPotentialForce U (q s) - γ • p s = textbookLangevinPeriodicForce U (Q s) - γ • p s
      rw [hforce]
    have he := hpeq t ht
    rw [hint] at he
    exact he

end MolecularDynamics
