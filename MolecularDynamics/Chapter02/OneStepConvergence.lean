import MolecularDynamics.Notation
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.Pow.Continuity
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Tactic.Abel
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Stability, consistency, and convergence of one-step methods

Leimkuhler--Matthews, §2.2.3, printed pages 66--67 / PDF pages 88--89.
The numerical iterates and exact nodes satisfy the stated domain assumptions.
The actual error recurrence is derived from (2.10)--(2.11), and then solved
to obtain the displayed bound (2.12), including a uniform finite maximum.
-/

open Set Filter
open scoped Topology

namespace MolecularDynamics

section Iterate

variable {E : Type*}

/-- Successive applications of the given step map, from the actual initial value. -/
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _

end Iterate

section Normed

variable {E : Type*} [NormedAddCommGroup E]

/-- The maximum of the actual norm errors over the entire finite mesh. -/
noncomputable def oneStepMaxError (G : ℝ → E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) : ℝ :=
  (Finset.range (ν + 1)).sup' Finset.nonempty_range_add_one
    (fun n => ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖)

theorem oneStepMaxError_nonneg (G : ℝ → E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) :
    0 ≤ oneStepMaxError G h γ ν := by
  unfold oneStepMaxError
  exact le_trans (norm_nonneg _) (Finset.le_sup'
    (fun n => ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖)
    (show 0 ∈ Finset.range (ν + 1) from by simp))

theorem oneStepMaxError_le (G : ℝ → E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) (B : ℝ)
    (hb : ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤ B) :
    oneStepMaxError G h γ ν ≤ B := by
  apply Finset.sup'_le
  intro n hn
  exact hb n (Nat.lt_succ_iff.mp (Finset.mem_range.mp hn))

/-- The error recurrence comes from the actual iterates and local defects. -/
theorem oneStep_error_recursion (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    (h L K p : ℝ) (ν : ℕ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1))
    (n : ℕ) (hn : n < ν) :
    ‖oneStepIterate G h (γ 0) (n + 1) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤
      (1 + h * L) * ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ +
        K * h ^ (p + 1) := by
  rw [oneStepIterate_succ]
  calc
    _ = ‖(G h (oneStepIterate G h (γ 0) n) - G h (γ ((n : ℝ) * h))) +
        (G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h))‖ := by
          congr 1
          abel
    _ ≤ ‖G h (oneStepIterate G h (γ 0) n) - G h (γ ((n : ℝ) * h))‖ +
        ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ := norm_add_le _ _
    _ ≤ _ := add_le_add
      (hstable _ (hnum n (Nat.le_of_lt hn)) _ (hexact n (Nat.le_of_lt hn)))
      (hconsistent n hn)

private theorem finite_error_recurrence_bound (e : ℕ → ℝ) (ν : ℕ)
    {h L K p : ℝ} (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hzero : e 0 = 0)
    (hrec : ∀ n < ν, e (n + 1) ≤ (1 + h * L) * e n + K * h ^ (p + 1)) :
    ∀ n ≤ ν, e n ≤ (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  let δ := (K / L) * h ^ p
  have hδ : 0 ≤ δ := mul_nonneg (div_nonneg hK hL.le) (Real.rpow_nonneg hh.le p)
  have ha : 0 ≤ 1 + h * L := by positivity
  have hdefect : K * h ^ (p + 1) = h * L * δ := by
    dsimp [δ]
    rw [Real.rpow_add_one hh.ne']
    field_simp
  have hshift : ∀ n ≤ ν, e n + δ ≤ δ * (1 + h * L) ^ n := by
    intro n
    induction n with
    | zero => intro _; simp [hzero]
    | succ n ih =>
      intro hn
      have hn' : n < ν := Nat.lt_of_lt_of_le (Nat.lt_succ_self n) hn
      calc
        e (n + 1) + δ ≤ (1 + h * L) * e n + K * h ^ (p + 1) + δ :=
          add_le_add (hrec n hn') le_rfl
        _ = (1 + h * L) * (e n + δ) := by rw [hdefect]; ring
        _ ≤ (1 + h * L) * (δ * (1 + h * L) ^ n) :=
          mul_le_mul_of_nonneg_left (ih (Nat.le_of_lt hn')) ha
        _ = δ * (1 + h * L) ^ (n + 1) := by rw [pow_succ]; ring
  intro n hn
  have hexp : (1 + h * L) ^ n ≤ Real.exp (L * ((n : ℝ) * h)) := by
    calc
      _ ≤ (Real.exp (h * L)) ^ n :=
        pow_le_pow_left₀ ha (by simpa [add_comm] using Real.add_one_le_exp (h * L)) n
      _ = Real.exp (L * ((n : ℝ) * h)) := by
        rw [← Real.exp_nat_mul]
        congr 1
        ring
  calc
    e n ≤ e n + δ := le_add_of_nonneg_right hδ
    _ ≤ δ * (1 + h * L) ^ n := hshift n hn
    _ ≤ δ * Real.exp (L * ((n : ℝ) * h)) := mul_le_mul_of_nonneg_left hexp hδ
    _ = _ := by dsimp [δ]; ring

/-- Equation (2.12), for every node of the actual numerical solution. -/
theorem oneStep_error_bound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply finite_error_recurrence_bound _ ν hh hL hK
  · simp
  · exact oneStep_error_recursion G γ D h L K p ν hnum hexact hstable hconsistent

/-- Uniform order-p error on a fixed time interval, including the actual maximum. -/
theorem oneStepMaxError_order_bound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p τ : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (horizon : (ν : ℝ) * h ≤ τ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    oneStepMaxError G h γ ν ≤ (K / L) * Real.exp (L * τ) * h ^ p := by
  apply oneStepMaxError_le
  intro n hn
  have htime : (n : ℝ) * h ≤ τ := le_trans
    (mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hn) hh.le) horizon
  calc
    _ ≤ (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p :=
      oneStep_error_bound G γ D ν hh hL hK hnum hexact hstable hconsistent n hn
    _ ≤ _ := by
      gcongr

/-- Consistency and stability imply convergence of the actual maximum
error as the mesh of the fixed positive time interval is refined. The domain
retention here is precisely the simplifying assumption of §2.2.3. -/
theorem oneStep_converges_of_consistency_stability
    (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {τ δ L K p : ℝ} (hτ : 0 < τ) (hδ : 0 < δ) (hL : 0 < L)
    (hK : 0 ≤ K) (hp : 0 < p)
    (hexact : MapsTo γ (Icc 0 τ) D)
    (hnum : ∀ ν : ℕ, 0 < ν → τ / (ν : ℝ) ≤ δ →
      ∀ n ≤ ν, oneStepIterate G (τ / (ν : ℝ)) (γ 0) n ∈ D)
    (hstable : ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
      ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ h ∈ Ioo 0 δ, ∀ t ∈ Icc 0 τ, t + h ≤ τ →
      ‖G h (γ t) - γ (t + h)‖ ≤ K * h ^ (p + 1)) :
    Tendsto (fun ν : ℕ => oneStepMaxError G (τ / (ν : ℝ)) γ ν) atTop (𝓝 0) := by
  have hstep : Tendsto (fun ν : ℕ => τ / (ν : ℝ)) atTop (𝓝 0) :=
    tendsto_const_div_atTop_nhds_zero_nat τ
  have hbound : ∀ᶠ ν : ℕ in atTop,
      oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
        ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
    filter_upwards [eventually_gt_atTop (0 : ℕ), hstep.eventually_lt_const hδ]
      with ν hν hsmall
    have hνR : 0 < (ν : ℝ) := Nat.cast_pos.mpr hν
    have hh : 0 < τ / (ν : ℝ) := div_pos hτ hνR
    have hend : (ν : ℝ) * (τ / (ν : ℝ)) = τ := mul_div_cancel₀ _ hνR.ne'
    have htime : ∀ n ≤ ν, (n : ℝ) * (τ / (ν : ℝ)) ∈ Icc 0 τ := by
      intro n hn
      refine ⟨mul_nonneg (Nat.cast_nonneg n) hh.le, ?_⟩
      calc
        _ ≤ (ν : ℝ) * (τ / (ν : ℝ)) :=
          mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hn) hh.le
        _ = τ := hend
    apply oneStepMaxError_order_bound G γ D ν hh hL hK hend.le
      (hnum ν hν hsmall.le) (fun n hn => hexact (htime n hn))
      (hstable _ ⟨hh, hsmall.le⟩)
    intro n hn
    have ht := htime n (Nat.le_of_lt hn)
    have hnext := (htime (n + 1) (Nat.succ_le_of_lt hn)).2
    simp only [Nat.cast_add, Nat.cast_one, add_mul, one_mul] at hnext ⊢
    exact hconsistent _ ⟨hh, hsmall⟩ _ ht hnext
  apply squeeze_zero' (Eventually.of_forall (fun ν => oneStepMaxError_nonneg G _ γ ν)) hbound
  simpa only [mul_zero] using
    (hstep.rpow_const_nhds_zero hp).const_mul ((K / L) * Real.exp (L * τ))

end Normed

end MolecularDynamics
