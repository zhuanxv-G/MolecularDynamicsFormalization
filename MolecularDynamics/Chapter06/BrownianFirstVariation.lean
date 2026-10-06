import MolecularDynamics.Chapter06.BrownianC2ClosedOperator

/-! Actual initial-state first variation for the original additive Brownian equation.
No differentiability of the driving noise or of the selected solution is assumed. -/

open Set Filter Metric MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics
noncomputable section

private theorem periodic_derivative {N : ℕ} {E : Type*} [NormedAddCommGroup E]
    [NormedSpace ℝ E] (g : (Fin N → ℝ) → E)
    (hp : ∀ (x : Fin N → ℝ) (n : Fin N → ℤ), g (x + fun i ↦ (n i : ℝ)) = g x)
    (x : Fin N → ℝ) (n : Fin N → ℤ) :
    fderiv ℝ g (x + fun i ↦ (n i : ℝ)) = fderiv ℝ g x := by
  let c : Fin N → ℝ := fun i ↦ (n i : ℝ)
  have he : (fun z ↦ g (z + c)) = g := funext (fun z ↦ hp z n)
  rw [← fderiv_comp_add_right (𝕜 := ℝ) (f := g) (x := x) c, he]

private theorem periodic_bound {N : ℕ} {E : Type*} [NormedAddCommGroup E]
    (g : (Fin N → ℝ) → E) (hc : Continuous g)
    (hp : ∀ (x : Fin N → ℝ) (n : Fin N → ℤ), g (x + fun i ↦ (n i : ℝ)) = g x) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x, ‖g x‖ ≤ M := by
  obtain ⟨M, hb⟩ := isCompact_Icc.exists_bound_of_continuousOn
    (hc.continuousOn : ContinuousOn g (Icc (0 : Fin N → ℝ) 1))
  have h0 : (0 : Fin N → ℝ) ∈ Icc 0 1 := ⟨le_rfl, fun _ ↦ zero_le_one⟩
  refine ⟨M, (norm_nonneg _).trans (hb 0 h0), fun x ↦ ?_⟩
  let a : Fin N → ℝ := fun i ↦ Int.fract (x i)
  let n : Fin N → ℤ := fun i ↦ Int.floor (x i)
  have ha : a ∈ Icc (0 : Fin N → ℝ) 1 :=
    ⟨fun i ↦ Int.fract_nonneg (x i), fun i ↦ (Int.fract_lt_one (x i)).le⟩
  have he : a + (fun i ↦ (n i : ℝ)) = x := funext (fun i ↦ Int.fract_add_floor (x i))
  have hh := hp a n
  rw [he] at hh
  rw [hh]
  exact hb a ha

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



variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

include hU in
/-- The literal original mass-weighted Brownian drift is genuinely smooth. -/
theorem textbookBrownianSDEDrift_contDiff : ContDiff ℝ ∞ (textbookBrownianSDEDrift m U) :=
  (textbookBrownianMassMobility m).contDiff.comp (textbookLangevinForce_contDiff U hU)

include hU hp in
/-- The genuine original drift Jacobian preserves the original integer lattice. -/
theorem textbookBrownianSDEDrift_fderiv_periodic (x : Fin N → ℝ) (n : Fin N → ℤ) :
    fderiv ℝ (textbookBrownianSDEDrift m U) (x + fun i ↦ (n i : ℝ)) =
      fderiv ℝ (textbookBrownianSDEDrift m U) x :=
  periodic_derivative _ (textbookBrownianSDEDrift_periodic m U hU hp) x n

include hU hp in
/-- Periodic smoothness derives a true global Lipschitz bound for the actual drift Jacobian. -/
theorem textbookBrownianSDEDrift_fderiv_lipschitz :
    ∃ M : ℝ≥0, LipschitzWith M (fderiv ℝ (textbookBrownianSDEDrift m U)) := by
  have hd : ContDiff ℝ ∞ (fderiv ℝ (textbookBrownianSDEDrift m U)) :=
    (textbookBrownianSDEDrift_contDiff m U hU).fderiv_right (by simp)
  obtain ⟨M, hM, hb⟩ := periodic_bound
    (fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)))
    (hd.continuous_fderiv (by simp))
    (periodic_derivative _ (textbookBrownianSDEDrift_fderiv_periodic m U hU hp))
  refine ⟨⟨M, hM⟩, lipschitzWith_of_nnnorm_fderiv_le (hd.differentiable (by simp)) ?_⟩
  intro x
  exact_mod_cast hb x

include hU hp in
/-- The literal drift has a derived uniform quadratic Taylor remainder, at every true initial lift. -/
theorem textbookBrownianSDEDrift_first_taylor_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x y : Fin N → ℝ,
      ‖textbookBrownianSDEDrift m U (x + y) - textbookBrownianSDEDrift m U x -
        fderiv ℝ (textbookBrownianSDEDrift m U) x y‖ ≤ M * ‖y‖ ^ 2 := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  have hb := (textbookBrownianSDEDrift_contDiff m U hU).differentiable (by simp)
  refine ⟨M, M.property, fun x y ↦ ?_⟩
  let b := textbookBrownianSDEDrift m U
  let R := fun z ↦ b z - b x - fderiv ℝ b x (z - x)
  have hd (z : Fin N → ℝ) :
      HasFDerivAt R (fderiv ℝ b z - fderiv ℝ b x) z := by
    have h := ((hb z).hasFDerivAt.sub_const (b x)).sub
      ((fderiv ℝ b x).hasFDerivAt.comp z ((hasFDerivAt_id z).sub_const x))
    simpa only [R, b, ContinuousLinearMap.comp_id, Function.comp_def, Pi.sub_def, id_eq] using h
  have hbound (z : Fin N → ℝ) (hz : z ∈ closedBall x ‖y‖) :
      ‖fderiv ℝ b z - fderiv ℝ b x‖ ≤ (M : ℝ) * ‖y‖ := by
    exact (hM.norm_sub_le z x).trans
      (mul_le_mul_of_nonneg_left (mem_closedBall_iff_norm.mp hz) M.property)
  have hh := Convex.norm_image_sub_le_of_norm_hasFDerivWithin_le
    (fun z _ ↦ (hd z).hasFDerivWithinAt) hbound (convex_closedBall x ‖y‖)
    (mem_closedBall_self (norm_nonneg y))
    (show x + y ∈ closedBall x ‖y‖ by simp only [mem_closedBall_iff_norm, add_sub_cancel_left, le_refl])
  simpa only [R, sub_self, map_zero, sub_zero, add_sub_cancel_left, pow_two, mul_assoc] using hh

/-- The actual selected path has a uniform same-noise initial perturbation bound. -/
theorem textbookBrownianPathEndpoint_same_noise_dist_le (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin N → ℝ)) (x y : Fin N → ℝ) (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)
      (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W) ≤
        dist x y * Real.exp
          ((1 + (textbookBrownianDriftLipschitzConstant m U hU hp : ℝ)) * t) := by
  have h := textbookBrownianIntegralSolution_dist_le m U hU hp β T 0 hT x y
    (textbookLangevinPathNoise T hT W) (textbookLangevinPathNoise T hT W)
    (textbookBrownianPathSolution m hm U hU hp β hβ T hT x W)
    (textbookBrownianPathSolution m hm U hU hp β hβ T hT y W)
    (textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT x W)
    (textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT y W)
    (fun _ _ ↦ by simp) t ht
  simpa only [mul_zero, add_zero, gronwallBound_ε0, textbookBrownianPathEndpoint] using h


/-- A genuine fundamental matrix exists along every actual finite continuous-noise solution. -/
theorem textbookBrownianPathJacobian_exists (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    ∃ J : ℝ → ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)),
      J 0 = ContinuousLinearMap.id ℝ (Fin N → ℝ) ∧
      ∀ t ∈ Icc 0 T, HasDerivAt J
        ((fderiv ℝ (textbookBrownianSDEDrift m U)
          (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).comp (J t)) t := by
  let q := textbookBrownianPathSolution m hm U hU hp β hβ T hT x W
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT x W
  let A := fun t : ℝ ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (q (projIcc 0 T hT t))
  let L := textbookBrownianDriftLipschitzConstant m U hU hp
  have hA : Continuous A :=
    ((textbookBrownianSDEDrift_contDiff m U hU).continuous_fderiv (by simp)).comp
      (hq.1.comp_continuous
        (continuous_subtype_val.comp continuous_projIcc)
        (fun t ↦ (projIcc 0 T hT t).property))
  have hAb (t : ℝ) : ‖A t‖ ≤ (L : ℝ) :=
    norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp)
  let F := fun t : ℝ ↦ fun J : ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) ↦ (A t).comp J
  have hF (t : ℝ) : LipschitzWith L (F t) := by
    apply LipschitzWith.of_dist_le_mul
    intro J K
    rw [dist_eq_norm, dist_eq_norm]
    change ‖(A t).comp J - (A t).comp K‖ ≤ (L : ℝ) * ‖J - K‖
    rw [← ContinuousLinearMap.comp_sub]
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (mul_le_mul_of_nonneg_right (hAb t) (norm_nonneg _))
  have hFc (J : ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) :
      Continuous (fun t ↦ F t J) := hA.clm_comp continuous_const
  obtain ⟨δ, hδ, hl⟩ := uniform_local_exists F L hF hFc
  obtain ⟨J, hJ0, hJ⟩ := finite_interval_exists F δ hδ hl (ContinuousLinearMap.id ℝ (Fin N → ℝ)) T
  refine ⟨J, hJ0, fun t ht ↦ ?_⟩
  have hj := hJ t ht
  simpa only [F, A, projIcc_of_mem hT ht, textbookBrownianPathEndpoint, q] using hj

/-- The actual original-noise Jacobian path is selected from a proved linear variational solution. -/
def textbookBrownianPathJacobian (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    ℝ → ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
  Classical.choose (textbookBrownianPathJacobian_exists m hm U hU hp β hβ T hT x W)

/-- The true selected Jacobian satisfies its actual identity initial value and variational derivative. -/
theorem textbookBrownianPathJacobian_spec (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W 0 =
      ContinuousLinearMap.id ℝ (Fin N → ℝ) ∧
    ∀ t ∈ Icc 0 T, HasDerivAt
      (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W)
      ((fderiv ℝ (textbookBrownianSDEDrift m U)
        (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).comp
          (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t)) t :=
  Classical.choose_spec (textbookBrownianPathJacobian_exists m hm U hU hp β hβ T hT x W)

/-- Every actual Jacobian is bounded uniformly over the initial state and the noise. -/
theorem textbookBrownianPathJacobian_norm_le (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    ‖textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t‖ ≤
      Real.exp ((textbookBrownianDriftLipschitzConstant m U hU hp : ℝ) * t) := by
  let J := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W
  let L := textbookBrownianDriftLipschitzConstant m U hU hp
  obtain ⟨hJ0, hJ⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT x W
  have hc : ContinuousOn J (Icc 0 T) := fun s hs ↦ (hJ s hs).continuousAt.continuousWithinAt
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le hc
    (fun s hs ↦ (hJ s (Ico_subset_Icc_self hs)).hasDerivWithinAt)
    (show ‖J 0‖ ≤ 1 by rw [show J 0 = _ from hJ0]; exact ContinuousLinearMap.norm_id_le)
    (ε := 0) (K := (L : ℝ)) (fun s _ ↦ by
      simpa only [add_zero] using (ContinuousLinearMap.opNorm_comp_le _ _).trans
        (mul_le_mul_of_nonneg_right
          (norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp))
          (norm_nonneg (J s))))
  simpa only [sub_zero, gronwallBound_ε0, one_mul] using hh t ht

/-- The actual variational matrix has a true uniform quadratic initial-state error, for all noises. -/
theorem textbookBrownianPathEndpoint_jacobian_error_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (x v : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathEndpoint m hm U hU hp β hβ T hT (x + v) t W -
        textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W -
        textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t v‖ ≤ C * ‖v‖ ^ 2 := by
  obtain ⟨M, hM, hTaylor⟩ := textbookBrownianSDEDrift_first_taylor_bound m U hU hp
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let K : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hK : 0 < K := by dsimp [K]; linarith
  let E : ℝ := Real.exp (K * T)
  let C : ℝ := M * E ^ 2 / K * E
  have hC : 0 ≤ C := by dsimp [C]; positivity
  refine ⟨C, hC, fun x v W t ht ↦ ?_⟩
  let q := textbookBrownianPathSolution m hm U hU hp β hβ T hT x W
  let r := textbookBrownianPathSolution m hm U hU hp β hβ T hT (x + v) W
  let J := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W
  let Z := textbookBrownianNoiseCompensated m β (textbookLangevinPathNoise T hT W)
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT x W
  have hr := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT (x + v) W
  obtain ⟨hJ0, hJ⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT x W
  let e := fun s ↦ Z r s - Z q s - J s v
  let e' := fun s ↦ textbookBrownianSDEDrift m U (r s) -
    textbookBrownianSDEDrift m U (q s) - (fderiv ℝ (textbookBrownianSDEDrift m U) (q s)) (J s v)
  have he (s : ℝ) : e s = r s - q s - J s v := by
    dsimp [e, Z, textbookBrownianNoiseCompensated]
    abel
  have he0 : e 0 = 0 := by
    rw [he, show q 0 = x from textbookBrownianIntegralSolution_initial m U β T hT x _ q hq,
      show r 0 = x + v from textbookBrownianIntegralSolution_initial m U β T hT (x + v) _ r hr,
      show J 0 = _ from hJ0, ContinuousLinearMap.id_apply]
    abel
  have hJc : ContinuousOn J (Icc 0 T) := fun s hs ↦ (hJ s hs).continuousAt.continuousWithinAt
  have hc : ContinuousOn e (Icc 0 T) :=
    ((textbookBrownianNoiseCompensated_continuousOn m U β T (x + v) _ r hr).sub
      (textbookBrownianNoiseCompensated_continuousOn m U β T x _ q hq)).sub
      (hJc.clm_apply continuousOn_const)
  have hd (s : ℝ) (hs : s ∈ Ico 0 T) :
      HasDerivWithinAt e (e' s) (Ici s) s := by
    have hsT := Ico_subset_Icc_self hs
    have hqr := textbookBrownianNoiseCompensated_hasDerivWithinAt m U hU hp β T x _ q hq s hs
    have hrr := textbookBrownianNoiseCompensated_hasDerivWithinAt m U hU hp β T (x + v) _ r hr s hs
    have hfield (p : ℝ → (Fin N → ℝ)) :
        textbookBrownianDrivenField m U β (textbookLangevinPathNoise T hT W) s
          (textbookBrownianNoiseCompensated m β (textbookLangevinPathNoise T hT W) p s) =
            textbookBrownianSDEDrift m U (p s) := by
      unfold textbookBrownianDrivenField textbookBrownianNoiseCompensated
      rw [sub_add_cancel]
    rw [hfield q] at hqr
    rw [hfield r] at hrr
    have hjv := (hJ s hsT).hasDerivWithinAt.clm_apply (hasDerivWithinAt_const s (Ici s) v)
    have hh := (hrr.sub hqr).sub hjv
    simpa only [e, e', Z, J, q, ContinuousLinearMap.comp_apply, map_zero, add_zero, Pi.sub_def,
      textbookBrownianPathEndpoint] using hh
  have hdiff (s : ℝ) (hs : s ∈ Icc 0 T) : ‖r s - q s‖ ≤ E * ‖v‖ := by
    have hh := textbookBrownianPathEndpoint_same_noise_dist_le m hm U hU hp β hβ T hT W (x + v) x s hs
    have heE : Real.exp (K * s) ≤ E :=
      Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hs.2 hK.le)
    simpa only [textbookBrownianPathEndpoint, dist_eq_norm, add_sub_cancel_left, mul_comm] using
      hh.trans (mul_le_mul_of_nonneg_left heE (dist_nonneg : 0 ≤ dist (x + v) x))
  have hb (s : ℝ) (hs : s ∈ Ico 0 T) :
      ‖e' s‖ ≤ K * ‖e s‖ + M * E ^ 2 * ‖v‖ ^ 2 := by
    let R := textbookBrownianSDEDrift m U (r s) - textbookBrownianSDEDrift m U (q s) -
      (fderiv ℝ (textbookBrownianSDEDrift m U) (q s)) (r s - q s)
    have hR : ‖R‖ ≤ M * ‖r s - q s‖ ^ 2 := by
      simpa only [R, add_sub_cancel] using hTaylor (q s) (r s - q s)
    have he' : e' s = (fderiv ℝ (textbookBrownianSDEDrift m U) (q s)) (e s) + R := by
      rw [he]
      dsimp [e', R]
      rw [map_sub]
      abel
    have hDb : ‖fderiv ℝ (textbookBrownianSDEDrift m U) (q s)‖ ≤ L :=
      norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp)
    rw [he']
    calc
      _ ≤ ‖(fderiv ℝ (textbookBrownianSDEDrift m U) (q s)) (e s)‖ + ‖R‖ := norm_add_le _ _
      _ ≤ L * ‖e s‖ + M * ‖r s - q s‖ ^ 2 :=
        add_le_add (((fderiv ℝ (textbookBrownianSDEDrift m U) (q s)).le_opNorm _).trans
          (mul_le_mul_of_nonneg_right hDb (norm_nonneg _))) hR
      _ ≤ K * ‖e s‖ + M * (E * ‖v‖) ^ 2 := add_le_add
        (mul_le_mul_of_nonneg_right (by dsimp [K]; linarith) (norm_nonneg _))
        (mul_le_mul_of_nonneg_left
          (pow_le_pow_left₀ (norm_nonneg _) (hdiff s (Ico_subset_Icc_self hs)) 2) hM)
      _ = K * ‖e s‖ + M * E ^ 2 * ‖v‖ ^ 2 := by ring
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le hc hd
    (show ‖e 0‖ ≤ 0 by rw [he0, norm_zero]) hb t ht
  rw [sub_zero, gronwallBound_of_K_ne_0 hK.ne'] at hh
  have heT : Real.exp (K * t) - 1 ≤ E :=
    (sub_le_self _ zero_le_one).trans
      (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hK.le))
  have hn : 0 ≤ M * E ^ 2 * ‖v‖ ^ 2 / K := by positivity
  have hh' : ‖e t‖ ≤ C * ‖v‖ ^ 2 := by
    calc
      _ ≤ M * E ^ 2 * ‖v‖ ^ 2 / K * (Real.exp (K * t) - 1) := by simpa only [zero_mul, zero_add] using hh
      _ ≤ M * E ^ 2 * ‖v‖ ^ 2 / K * E := mul_le_mul_of_nonneg_left heT hn
      _ = C * ‖v‖ ^ 2 := by dsimp [C]; ring
  simpa only [he, textbookBrownianPathEndpoint] using hh'

/-- Genuine differentiability of the original selected solution in its true initial state. -/
theorem textbookBrownianPathEndpoint_hasFDerivAt_initial (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    HasFDerivAt (fun y ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W)
      (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t) x := by
  obtain ⟨C, _, hb⟩ := textbookBrownianPathEndpoint_jacobian_error_bound m hm U hU hp β hβ T hT
  rw [hasFDerivAt_iff_isLittleO_nhds_zero]
  apply Asymptotics.isLittleO_iff.mpr
  intro ε hε
  have htC : Continuous (fun v : Fin N → ℝ ↦ (C + 1) * ‖v‖) :=
    continuous_const.mul continuous_norm
  have ht0 : Tendsto (fun v : Fin N → ℝ ↦ (C + 1) * ‖v‖) (𝓝 0) (𝓝 0) := by
    simpa only [norm_zero, mul_zero] using htC.tendsto (0 : Fin N → ℝ)
  filter_upwards [ht0.eventually (gt_mem_nhds hε)] with v hv
  have hc' : C * ‖v‖ ≤ ε := by
    have hle : C * ‖v‖ ≤ (C + 1) * ‖v‖ := by nlinarith [norm_nonneg v]
    exact hle.trans hv.le
  calc
    _ ≤ C * ‖v‖ ^ 2 := hb x v W t ht
    _ ≤ ε * ‖v‖ := by nlinarith [mul_le_mul_of_nonneg_right hc' (norm_nonneg v)]

/-- Actual first variations vary with a uniform Lipschitz bound in the true initial state. -/
theorem textbookBrownianPathJacobian_initial_norm_sub_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (x y : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t -
        textbookBrownianPathJacobian m hm U hU hp β hβ T hT y W t‖ ≤ C * ‖x - y‖ := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let K : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hK : 0 < K := by dsimp [K]; linarith
  let E : ℝ := Real.exp (K * T)
  let C : ℝ := (M : ℝ) * E ^ 2 / K * E
  have hC : 0 ≤ C := by dsimp [C]; positivity
  refine ⟨C, hC, fun x y W t ht ↦ ?_⟩
  let qx := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x s W
  let qy := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y s W
  let Jx := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W
  let Jy := textbookBrownianPathJacobian m hm U hU hp β hβ T hT y W
  obtain ⟨hJx0, hJx⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT x W
  obtain ⟨hJy0, hJy⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT y W
  let A := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (qx s)
  let B := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (qy s)
  let D := fun s ↦ Jx s - Jy s
  let D' := fun s ↦ (A s).comp (Jx s) - (B s).comp (Jy s)
  have hD0 : D 0 = 0 := by dsimp [D, Jx, Jy]; rw [hJx0, hJy0, sub_self]
  have hxc : ContinuousOn Jx (Icc 0 T) := fun s hs ↦ (hJx s hs).continuousAt.continuousWithinAt
  have hyc : ContinuousOn Jy (Icc 0 T) := fun s hs ↦ (hJy s hs).continuousAt.continuousWithinAt
  have hd (s : ℝ) (hs : s ∈ Ico 0 T) : HasDerivWithinAt D (D' s) (Ici s) s := by
    have hh := (hJx s (Ico_subset_Icc_self hs)).sub (hJy s (Ico_subset_Icc_self hs))
    simpa only [D, D', Jx, Jy, A, B, qx, qy, Pi.sub_def] using hh.hasDerivWithinAt
  have hqdiff (s : ℝ) (hs : s ∈ Icc 0 T) : ‖qx s - qy s‖ ≤ E * ‖x - y‖ := by
    have hh := textbookBrownianPathEndpoint_same_noise_dist_le m hm U hU hp β hβ T hT W x y s hs
    have heE : Real.exp (K * s) ≤ E :=
      Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hs.2 hK.le)
    simpa only [dist_eq_norm, mul_comm] using
      hh.trans (mul_le_mul_of_nonneg_left heE (dist_nonneg : 0 ≤ dist x y))
  have hJyb (s : ℝ) (hs : s ∈ Icc 0 T) : ‖Jy s‖ ≤ E := by
    have hh := textbookBrownianPathJacobian_norm_le m hm U hU hp β hβ T hT y W s hs
    exact hh.trans (Real.exp_le_exp.mpr (calc
      L * s ≤ K * s := mul_le_mul_of_nonneg_right (by dsimp [K]; linarith) hs.1
      _ ≤ K * T := mul_le_mul_of_nonneg_left hs.2 hK.le))
  have hb (s : ℝ) (hs : s ∈ Ico 0 T) :
      ‖D' s‖ ≤ K * ‖D s‖ + (M : ℝ) * E ^ 2 * ‖x - y‖ := by
    have hsT := Ico_subset_Icc_self hs
    have hAB : ‖A s - B s‖ ≤ (M : ℝ) * E * ‖x - y‖ := by
      calc
        _ ≤ (M : ℝ) * ‖qx s - qy s‖ := hM.norm_sub_le _ _
        _ ≤ (M : ℝ) * (E * ‖x - y‖) := mul_le_mul_of_nonneg_left (hqdiff s hsT) M.property
        _ = (M : ℝ) * E * ‖x - y‖ := by ring
    have hDb : ‖A s‖ ≤ L :=
      norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp)
    have he : D' s = (A s).comp (D s) + (A s - B s).comp (Jy s) := by
      dsimp [D', D]
      rw [ContinuousLinearMap.comp_sub, ContinuousLinearMap.sub_comp]
      abel
    rw [he]
    calc
      _ ≤ ‖(A s).comp (D s)‖ + ‖(A s - B s).comp (Jy s)‖ := norm_add_le _ _
      _ ≤ L * ‖D s‖ + ((M : ℝ) * E * ‖x - y‖) * E :=
        add_le_add ((ContinuousLinearMap.opNorm_comp_le _ _).trans
          (mul_le_mul_of_nonneg_right hDb (norm_nonneg _)))
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans
            (mul_le_mul hAB (hJyb s hsT) (norm_nonneg _) (by dsimp [E]; positivity)))
      _ ≤ K * ‖D s‖ + ((M : ℝ) * E * ‖x - y‖) * E :=
        add_le_add (mul_le_mul_of_nonneg_right (by dsimp [K]; linarith) (norm_nonneg _)) le_rfl
      _ = K * ‖D s‖ + (M : ℝ) * E ^ 2 * ‖x - y‖ := by ring
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le (hxc.sub hyc) hd
    (show ‖D 0‖ ≤ 0 by rw [hD0, norm_zero]) hb t ht
  rw [sub_zero, gronwallBound_of_K_ne_0 hK.ne'] at hh
  have heT : Real.exp (K * t) - 1 ≤ E :=
    (sub_le_self _ zero_le_one).trans
      (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hK.le))
  have hn : 0 ≤ (M : ℝ) * E ^ 2 * ‖x - y‖ / K := by positivity
  calc
    _ ≤ (M : ℝ) * E ^ 2 * ‖x - y‖ / K * (Real.exp (K * t) - 1) := by
      simpa only [D, Jx, Jy, Pi.sub_apply, zero_mul, zero_add] using hh
    _ ≤ (M : ℝ) * E ^ 2 * ‖x - y‖ / K * E := mul_le_mul_of_nonneg_left heT hn
    _ = C * ‖x - y‖ := by dsimp [C]; ring

/-- The genuine initial derivative of every actual path is continuous in its initial lift. -/
theorem textbookBrownianPathJacobian_initial_continuous (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun x ↦ textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianPathJacobian_initial_norm_sub_bound m hm U hU hp β hβ T hT
  have hLip : LipschitzWith ⟨C, hC⟩
      (fun x ↦ textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t) :=
    LipschitzWith.of_dist_le_mul (fun x y ↦ by rw [dist_eq_norm, dist_eq_norm]; exact hb x y W t ht)
  exact hLip.continuous

/-- The actual Frechet derivative is the constructed genuine variational matrix. -/
theorem textbookBrownianPathEndpoint_fderiv_initial_eq (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    fderiv ℝ (fun y ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W) x =
      textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t :=
  (textbookBrownianPathEndpoint_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht).fderiv

/-- The actual original Brownian solution, at each time and every noise path, is truly C1 in its initial state. -/
theorem textbookBrownianPathEndpoint_contDiff_one_initial (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    ContDiff ℝ 1 (fun x ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W) :=
  contDiff_one_iff_hasFDerivAt.mpr ⟨_, textbookBrownianPathJacobian_initial_continuous m hm U hU hp β hβ T hT W t ht,
    fun x ↦ textbookBrownianPathEndpoint_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht⟩
end
end MolecularDynamics
