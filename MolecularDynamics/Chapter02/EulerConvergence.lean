import MolecularDynamics.Notation
import Mathlib.Analysis.Calculus.ContDiff.Comp
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Topology.MetricSpace.Thickening
import Mathlib.Topology.Order.Compact
import Mathlib.Tactic.Abel
import Mathlib.Tactic.GCongr
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Euler convergence on an open domain

Leimkuhler--Matthews, Theorem 2.1, printed page 56 / PDF page 78.
The supporting stability/consistency argument is on printed pages 66--67 /
PDF pages 88--89. Constants will be derived from the C¹ field on a compact
neighborhood of the exact trajectory; numerical domain containment is a
conclusion, rather than an assumption.
-/

open Set Metric

namespace MolecularDynamics

section Normed

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Euler's one-step map `G_h(x) = x + h f(x)`. -/
noncomputable def eulerStep (f : E → E) (h : ℝ) (x : E) : E :=
  x + h • f x

/-- The numerical solution after `n` Euler steps from the given initial value. -/
noncomputable def eulerIterate (f : E → E) (h : ℝ) (x₀ : E) (n : ℕ) : E :=
  (eulerStep f h)^[n] x₀

@[simp] theorem eulerIterate_zero (f : E → E) (h : ℝ) (x₀ : E) :
    eulerIterate f h x₀ 0 = x₀ := rfl

@[simp] theorem eulerIterate_succ (f : E → E) (h : ℝ) (x₀ : E) (n : ℕ) :
    eulerIterate f h x₀ (n + 1) = eulerStep f h (eulerIterate f h x₀ n) := by
  exact Function.iterate_succ_apply' _ _ _

@[simp] theorem eulerIterate_zero_step (f : E → E) (x₀ : E) (n : ℕ) :
    eulerIterate f 0 x₀ n = x₀ := by
  induction n with
  | zero => rfl
  | succ n ih => simp [eulerStep, ih]

/-- The actual maximum of all errors, including both ends of the mesh. -/
noncomputable def eulerMaxError (f : E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) : ℝ :=
  (Finset.range (ν + 1)).sup' (Finset.nonempty_range_add_one)
    (fun n => ‖eulerIterate f h (γ 0) n - γ ((n : ℝ) * h)‖)

/-- A uniform nodal estimate bounds the actual finite maximum. -/
theorem eulerMaxError_le (f : E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) (B : ℝ)
    (hb : ∀ n ≤ ν, ‖eulerIterate f h (γ 0) n - γ ((n : ℝ) * h)‖ ≤ B) :
    eulerMaxError f h γ ν ≤ B := by
  apply Finset.sup'_le
  intro n hn
  exact hb n (Nat.lt_succ_iff.mp (Finset.mem_range.mp hn))

/-- Euler stability for a pair on which the field has the stated bound. -/
theorem eulerStep_norm_sub_le (f : E → E) {h L : ℝ} (hh : 0 ≤ h)
    (x y : E) (hf : ‖f x - f y‖ ≤ L * ‖x - y‖) :
    ‖eulerStep f h x - eulerStep f h y‖ ≤ (1 + h * L) * ‖x - y‖ := by
  have heq : eulerStep f h x - eulerStep f h y =
      (x - y) + h • (f x - f y) := by
    simp only [eulerStep, smul_sub]
    abel
  rw [heq]
  calc
    _ ≤ ‖x - y‖ + ‖h • (f x - f y)‖ := norm_add_le _ _
    _ = ‖x - y‖ + h * ‖f x - f y‖ := by
      rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg hh]
    _ ≤ ‖x - y‖ + h * (L * ‖x - y‖) := by gcongr
    _ = _ := by ring

/-- A derivative that is Lipschitz on the exact interval gives a quadratic
Euler defect. The constant is deliberately not optimized by a factor of two. -/
theorem euler_localDefect_of_derivative_bound (f : E → E) (γ : ℝ → E)
    {s t A : ℝ} (hst : s ≤ t)
    (hγ : ∀ u ∈ Icc s t, HasDerivWithinAt γ (f (γ u)) (Icc s t) u)
    (hf : ∀ u ∈ Icc s t, ‖f (γ u) - f (γ s)‖ ≤ A * (t - s)) :
    ‖γ t - eulerStep f (t - s) (γ s)‖ ≤ A * (t - s) ^ 2 := by
  let R : ℝ → E := fun u => γ u - γ s - (u - s) • f (γ s)
  have hR : ∀ u ∈ Icc s t,
      HasDerivWithinAt R (f (γ u) - f (γ s)) (Icc s t) u := by
    intro u hu
    simpa only [R, id_eq, one_smul] using ((hγ u hu).sub_const (γ s)).fun_sub
      (((hasDerivAt_id u).sub_const s).hasDerivWithinAt.smul_const (f (γ s)))
  have hb := (convex_Icc s t).norm_image_sub_le_of_norm_hasDerivWithin_le
    hR hf (left_mem_Icc.mpr hst) (right_mem_Icc.mpr hst)
  simpa [R, eulerStep, Real.norm_eq_abs, abs_of_nonneg (sub_nonneg.mpr hst),
    pow_two, sub_add_eq_sub_sub, mul_assoc] using hb

end Normed

section Proper

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [ProperSpace E]

/-- All constants needed by Euler's proof follow from C¹ regularity near
the compact exact trajectory. No global Lipschitz or consistency premise
is used here. -/
theorem exists_euler_trajectory_bounds (D : Set E) (hD : IsOpen D)
    (f : E → E) (hf : ContDiffOn ℝ 1 f D) (γ : ℝ → E) (τ : ℝ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t) :
    ∃ r L A : ℝ, 0 < r ∧ 0 < L ∧ 0 < A ∧
      (∀ t ∈ Icc 0 τ, ∀ x, ‖x - γ t‖ ≤ r →
        x ∈ D ∧ ‖f x - f (γ t)‖ ≤ L * ‖x - γ t‖) ∧
      (∀ s t, 0 ≤ s → s ≤ t → t ≤ τ →
        ‖γ t - eulerStep f (t - s) (γ s)‖ ≤ A * (t - s) ^ 2) := by
  have hc : ContinuousOn γ (Icc 0 τ) := fun t ht => (hγ t ht).continuousWithinAt
  let K : Set E := γ '' Icc 0 τ
  have hK : IsCompact K := isCompact_Icc.image_of_continuousOn hc
  have hKD : K ⊆ D := by
    rintro _ ⟨t, ht, rfl⟩
    exact hγD ht
  obtain ⟨r, hr, hTsub⟩ := hK.exists_cthickening_subset_open hD hKD
  have hT : IsCompact (cthickening r K) := hK.cthickening
  have hdf : ∀ x ∈ D, DifferentiableAt ℝ f x := fun x hx =>
    (hf.differentiableOn_one x hx).differentiableAt (hD.mem_nhds hx)
  obtain ⟨B, hB⟩ := hT.bddAbove_image
    (((hf.continuousOn_fderiv_of_isOpen hD (by rfl)).mono hTsub).norm)
  obtain ⟨M₀, hM₀⟩ := isCompact_Icc.bddAbove_image
    ((hf.continuousOn.comp hc hγD).norm)
  let L := max B 1
  let M := max M₀ 1
  have hL : 0 < L := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hM : 0 < M := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hDbound : ∀ x ∈ cthickening r K, ‖fderiv ℝ f x‖ ≤ L := by
    intro x hx
    exact (hB ⟨x, hx, rfl⟩).trans (le_max_left _ _)
  have hFbound : ∀ t ∈ Icc 0 τ, ‖f (γ t)‖ ≤ M := by
    intro t ht
    exact (hM₀ ⟨t, ht, rfl⟩).trans (le_max_left _ _)
  have hfg : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun u => f (γ u))
      ((fderiv ℝ f (γ t)) (f (γ t))) (Icc 0 τ) t := by
    intro t ht
    exact (hdf _ (hγD ht)).hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
  have hfgbound : ∀ t ∈ Icc 0 τ,
      ‖(fderiv ℝ f (γ t)) (f (γ t))‖ ≤ L * M := by
    intro t ht
    have htT : γ t ∈ cthickening r K :=
      self_subset_cthickening K ⟨t, ht, rfl⟩
    exact ((fderiv ℝ f (γ t)).le_opNorm _).trans
      (mul_le_mul (hDbound _ htT) (hFbound t ht) (norm_nonneg _) hL.le)
  refine ⟨r, L, L * M, hr, hL, mul_pos hL hM, ?_, ?_⟩
  · intro t ht x hx
    have hball : closedBall (γ t) r ⊆ cthickening r K :=
      closedBall_subset_cthickening (E := K) (show γ t ∈ K from ⟨t, ht, rfl⟩) r
    have hxball : x ∈ closedBall (γ t) r := by rwa [mem_closedBall, dist_eq_norm]
    refine ⟨hTsub (hball hxball), ?_⟩
    exact (convex_closedBall (γ t) r).norm_image_sub_le_of_norm_fderiv_le
      (fun y hy => hdf y (hTsub (hball hy)))
      (fun y hy => hDbound y (hball hy)) (mem_closedBall_self hr.le) hxball
  · intro s t hs hst ht
    have hsub : Icc s t ⊆ Icc 0 τ := Icc_subset_Icc hs ht
    apply euler_localDefect_of_derivative_bound f γ hst
      (fun u hu => (hγ u (hsub hu)).mono hsub)
    intro u hu
    have hsI : s ∈ Icc 0 τ := ⟨hs, hst.trans ht⟩
    have huI : u ∈ Icc 0 τ := hsub hu
    have hv := (convex_Icc (0 : ℝ) τ).norm_image_sub_le_of_norm_hasDerivWithin_le
      hfg hfgbound hsI huI
    rw [Real.norm_eq_abs, abs_of_nonneg (sub_nonneg.mpr hu.1)] at hv
    exact hv.trans (mul_le_mul_of_nonneg_left (by linarith [hu.2]) (mul_nonneg hL.le hM.le))

end Proper

/-! A finite-step scalar majorant, used while domain containment is bootstrapped. -/

private noncomputable def eulerErrorMajorant (A L h : ℝ) (n : ℕ) : ℝ :=
  A * h ^ 2 * (n : ℝ) * Real.exp ((n : ℝ) * (L * h))

private theorem eulerErrorMajorant_step {A L h : ℝ} (hA : 0 ≤ A)
    (hL : 0 ≤ L) (hh : 0 ≤ h) (n : ℕ) :
    (1 + h * L) * eulerErrorMajorant A L h n + A * h ^ 2 ≤
      eulerErrorMajorant A L h (n + 1) := by
  have hE : 1 + h * L ≤ Real.exp (L * h) := by
    simpa [mul_comm, add_comm] using Real.add_one_le_exp (L * h)
  have hpos : 0 ≤ eulerErrorMajorant A L h n := by
    dsimp [eulerErrorMajorant]
    positivity
  have heq : Real.exp (((n + 1 : ℕ) : ℝ) * (L * h)) =
      Real.exp (L * h) * Real.exp ((n : ℝ) * (L * h)) := by
    rw [Nat.cast_add_one, add_mul, one_mul, Real.exp_add]
    ring
  have he1 : 1 ≤ Real.exp (((n + 1 : ℕ) : ℝ) * (L * h)) :=
    Real.one_le_exp (by positivity)
  calc
    _ ≤ Real.exp (L * h) * eulerErrorMajorant A L h n + A * h ^ 2 := by
      gcongr
    _ = A * h ^ 2 * (n : ℝ) * Real.exp (((n + 1 : ℕ) : ℝ) * (L * h)) +
        A * h ^ 2 := by rw [heq]; dsimp [eulerErrorMajorant]; ring
    _ ≤ A * h ^ 2 * (n : ℝ) * Real.exp (((n + 1 : ℕ) : ℝ) * (L * h)) +
        A * h ^ 2 * Real.exp (((n + 1 : ℕ) : ℝ) * (L * h)) := by
      apply add_le_add le_rfl
      simpa only [mul_one] using
        mul_le_mul_of_nonneg_left he1 (mul_nonneg hA (sq_nonneg h))
    _ = _ := by dsimp [eulerErrorMajorant]; rw [Nat.cast_add_one]; ring

private theorem eulerErrorMajorant_uniform {A L h τ : ℝ} (hA : 0 ≤ A)
    (hL : 0 ≤ L) (hh : 0 ≤ h) (n : ℕ) (hn : (n : ℝ) * h ≤ τ) :
    eulerErrorMajorant A L h n ≤ (A * τ * Real.exp (L * τ)) * h := by
  have hτ : 0 ≤ τ := (mul_nonneg (Nat.cast_nonneg n) hh).trans hn
  have hexp : Real.exp ((n : ℝ) * (L * h)) ≤ Real.exp (L * τ) := by
    apply Real.exp_le_exp.mpr
    calc
      _ = L * ((n : ℝ) * h) := by ring
      _ ≤ _ := mul_le_mul_of_nonneg_left hn hL
  calc
    _ = A * h * ((n : ℝ) * h) * Real.exp ((n : ℝ) * (L * h)) := by
      dsimp [eulerErrorMajorant]
      ring
    _ ≤ A * h * τ * Real.exp (L * τ) := by gcongr
    _ = _ := by ring

section Bootstrap

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

private theorem euler_finite_error_and_domain (D : Set E) (f : E → E) (γ : ℝ → E)
    {τ h r L A : ℝ} {ν : ℕ} (hh : 0 ≤ h) (hL : 0 ≤ L) (hA : 0 ≤ A)
    (hν : (ν : ℝ) * h ≤ τ)
    (hsmall : (A * τ * Real.exp (L * τ)) * h ≤ r)
    (hnear : ∀ t ∈ Icc 0 τ, ∀ x, ‖x - γ t‖ ≤ r →
      x ∈ D ∧ ‖f x - f (γ t)‖ ≤ L * ‖x - γ t‖)
    (hdefect : ∀ s t, 0 ≤ s → s ≤ t → t ≤ τ →
      ‖γ t - eulerStep f (t - s) (γ s)‖ ≤ A * (t - s) ^ 2) :
    ∀ n ≤ ν, eulerIterate f h (γ 0) n ∈ D ∧
      ‖eulerIterate f h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
        (A * τ * Real.exp (L * τ)) * h := by
  have htime : ∀ n ≤ ν, (n : ℝ) * h ∈ Icc 0 τ := by
    intro n hn
    exact ⟨mul_nonneg (Nat.cast_nonneg n) hh,
      (mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hn) hh).trans hν⟩
  have hbound : ∀ n ≤ ν, ‖eulerIterate f h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      eulerErrorMajorant A L h n := by
    intro n
    induction n with
    | zero => intro _; simp [eulerErrorMajorant]
    | succ n ih =>
      intro hn
      have hn' : n ≤ ν := (Nat.le_succ n).trans hn
      have hp := ih hn'
      have hpUniform := hp.trans (eulerErrorMajorant_uniform hA hL hh n (htime n hn').2)
      have hpair := hnear _ (htime n hn') (eulerIterate f h (γ 0) n)
        (hpUniform.trans hsmall)
      have hstep := eulerStep_norm_sub_le f hh (eulerIterate f h (γ 0) n)
        (γ ((n : ℝ) * h)) hpair.2
      have hdt : ((n + 1 : ℕ) : ℝ) * h - (n : ℝ) * h = h := by
        rw [Nat.cast_add_one]
        ring
      have htstep : (n : ℝ) * h ≤ ((n + 1 : ℕ) : ℝ) * h := by
        rw [Nat.cast_add_one]
        nlinarith
      have hlocal := hdefect _ _ (htime n hn').1 htstep (htime (n + 1) hn).2
      rw [hdt] at hlocal
      rw [eulerIterate_succ]
      calc
        _ ≤ ‖eulerStep f h (eulerIterate f h (γ 0) n) -
              eulerStep f h (γ ((n : ℝ) * h))‖ +
            ‖eulerStep f h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ :=
          by
            simpa only [sub_add_sub_cancel] using
              norm_add_le
                (eulerStep f h (eulerIterate f h (γ 0) n) - eulerStep f h (γ ((n : ℝ) * h)))
                (eulerStep f h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h))
        _ ≤ (1 + h * L) * ‖eulerIterate f h (γ 0) n - γ ((n : ℝ) * h)‖ +
            A * h ^ 2 := add_le_add hstep (by rwa [norm_sub_rev] at hlocal)
        _ ≤ (1 + h * L) * eulerErrorMajorant A L h n + A * h ^ 2 := by gcongr
        _ ≤ _ := eulerErrorMajorant_step hA hL hh n
  intro n hn
  have hb := (hbound n hn).trans (eulerErrorMajorant_uniform hA hL hh n (htime n hn).2)
  exact ⟨(hnear _ (htime n hn) _ (hb.trans hsmall)).1, hb⟩

end Bootstrap

section Convergence

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [ProperSpace E]

/-- The full positive-horizon Euler conclusion, derived from the original
C¹ open-domain hypotheses. The constant and threshold are uniform in the
number of steps. -/
theorem euler_convergence_on_open (D : Set E) (hD : IsOpen D)
    (f : E → E) (hf : ContDiffOn ℝ 1 f D) (γ : ℝ → E) {τ : ℝ} (hτ : 0 < τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀, ∀ n ≤ ν,
      eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D ∧
        ‖eulerIterate f (τ / (ν : ℝ)) (γ 0) n - γ ((n : ℝ) * (τ / (ν : ℝ)))‖ ≤
          C * (τ / (ν : ℝ)) := by
  obtain ⟨r, L, A, hr, hL, hA, hnear, hdefect⟩ :=
    exists_euler_trajectory_bounds D hD f hf γ τ hγD hγ
  let C := A * τ * Real.exp (L * τ)
  have hC : 0 < C := mul_pos (mul_pos hA hτ) (Real.exp_pos _)
  obtain ⟨ν₀, hν₀⟩ := exists_nat_gt (max 1 (C * τ / r))
  have hν₀pos : 0 < ν₀ := by
    have hpos : (0 : ℝ) < ν₀ := lt_trans zero_lt_one ((le_max_left _ _).trans_lt hν₀)
    exact_mod_cast hpos
  refine ⟨C, hC, ν₀, hν₀pos, ?_⟩
  intro ν hν
  have hνpos : 0 < (ν : ℝ) := by exact_mod_cast (hν₀pos.trans_le hν)
  have hsmall : C * (τ / (ν : ℝ)) ≤ r := by
    rw [← mul_div_assoc, div_le_iff₀ hνpos]
    have hstrict : C * τ < (ν₀ : ℝ) * r :=
      (div_lt_iff₀ hr).mp ((le_max_right _ _).trans_lt hν₀)
    simpa only [mul_comm] using hstrict.le.trans
      (mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hν) hr.le)
  apply euler_finite_error_and_domain D f γ (div_nonneg hτ.le hνpos.le) hL.le hA.le
    (by rw [mul_div_cancel₀ _ hνpos.ne']) hsmall hnear hdefect

end Convergence

/-- Theorem 2.1, including domain retention and the maximum error on
`0,...,ν`. Boundedness of the domain is retained from the text, although
the compact-trajectory proof works for any open domain. Uniqueness is not
needed for the error estimate against an already specified exact solution.
The zero-duration interval is included explicitly. -/
theorem theorem_2_1_euler {m : ℕ} (D : Set (Position m))
    (_hDbounded : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ)) := by
  rcases hτ.eq_or_lt with hzero | hpos
  · have ht : τ = 0 := hzero.symm
    subst τ
    refine ⟨1, zero_lt_one, 1, by norm_num, ?_⟩
    intro ν _
    constructor
    · intro n _
      simpa using hγD (show (0 : ℝ) ∈ Icc 0 0 from ⟨le_rfl, le_rfl⟩)
    · apply eulerMaxError_le
      intro n _
      simp
  · obtain ⟨C, hC, ν₀, hν₀, hb⟩ := euler_convergence_on_open D hD f hf γ hpos hγD hγ
    refine ⟨C, hC, ν₀, hν₀, ?_⟩
    intro ν hν
    exact ⟨fun n hn => (hb ν hν n hn).1,
      eulerMaxError_le f (τ / (ν : ℝ)) γ ν (C * (τ / (ν : ℝ)))
        (fun n hn => (hb ν hν n hn).2)⟩

end MolecularDynamics
