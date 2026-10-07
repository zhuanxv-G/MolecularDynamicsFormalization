import MolecularDynamics.Chapter06.BrownianFirstVariation

/-! Genuine original-noise second variation needed for actual probability spatial C2 preservation. -/

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

include hU hp in
/-- The genuine original drift second Frechet derivative preserves the actual integer lattice. -/
theorem textbookBrownianSDEDrift_second_fderiv_periodic (x : Fin N → ℝ) (n : Fin N → ℤ) :
    fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)) (x + fun i ↦ (n i : ℝ)) =
      fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)) x :=
  periodic_derivative _ (textbookBrownianSDEDrift_fderiv_periodic m U hU hp) x n

include hU hp in
/-- True original smooth periodicity derives a global Lipschitz constant for the second drift derivative. -/
theorem textbookBrownianSDEDrift_second_fderiv_lipschitz :
    ∃ M : ℝ≥0, LipschitzWith M (fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U))) := by
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
    ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
    ContinuousLinearMap.toNormedSpace
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) :=
    ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) :=
    ContinuousLinearMap.toNormedSpace
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)))) :=
    ContinuousLinearMap.toNormedAddCommGroup
  have hd : ContDiff ℝ ∞ (fderiv ℝ (textbookBrownianSDEDrift m U)) :=
    (textbookBrownianSDEDrift_contDiff m U hU).fderiv_right (by simp)
  have hdd : ContDiff ℝ ∞ (fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U))) :=
    hd.fderiv_right (by simp)
  obtain ⟨M, hM, hb⟩ := periodic_bound
    (fderiv ℝ (fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U))))
    (hdd.continuous_fderiv (by simp))
    (periodic_derivative _ (textbookBrownianSDEDrift_second_fderiv_periodic m U hU hp))
  refine ⟨⟨M, hM⟩, lipschitzWith_of_nnnorm_fderiv_le (hdd.differentiable (by simp)) ?_⟩
  intro x
  exact_mod_cast hb x

include hU hp in
/-- The actual drift Jacobian has a genuinely derived uniform quadratic Taylor remainder. -/
theorem textbookBrownianSDEDrift_fderiv_first_taylor_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x y : Fin N → ℝ,
      ‖fderiv ℝ (textbookBrownianSDEDrift m U) (x + y) -
        fderiv ℝ (textbookBrownianSDEDrift m U) x -
        fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)) x y‖ ≤ M * ‖y‖ ^ 2 := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_second_fderiv_lipschitz m U hU hp
  have hc : ContDiff ℝ ∞ (fderiv ℝ (textbookBrownianSDEDrift m U)) :=
    (textbookBrownianSDEDrift_contDiff m U hU).fderiv_right (by simp)
  have hb := hc.differentiable (by simp)
  refine ⟨M, M.property, fun x y ↦ ?_⟩
  let b := fderiv ℝ (textbookBrownianSDEDrift m U)
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

/-- The literal true quadratic forcing in the actual second-variation equation. -/
def textbookBrownianPathSecondVariationForcing (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) :
    (Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
  ((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip
      (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t)).comp
    ((fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U))
      (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).comp
        (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t))

/-- The real second-variation forcing applies the true drift Hessian to the two true first variations. -/
theorem textbookBrownianPathSecondVariationForcing_apply (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (v w : Fin N → ℝ) :
    textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W t v w =
      fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U))
        (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)
        (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t v)
        (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t w) := rfl

/-- The actual second-variation forcing has a true global drift-derived quadratic Jacobian bound. -/
theorem textbookBrownianPathSecondVariationForcing_norm_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ (T : ℝ) (hT : 0 ≤ T) (x : Fin N → ℝ)
      (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ),
      ‖textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W t‖ ≤
        M * ‖textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t‖ ^ 2 := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  refine ⟨M, M.property, fun T hT x W t ↦ ?_⟩
  let J := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t
  let H := fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U))
    (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)
  let R := (ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip J
  have hR : ‖R‖ ≤ ‖J‖ := by
    exact (((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip).le_opNorm J).trans
      (by rw [ContinuousLinearMap.opNorm_flip]; simpa only [one_mul] using
        mul_le_mul_of_nonneg_right (ContinuousLinearMap.norm_compL_le ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)) (norm_nonneg J))
  have hH : ‖H‖ ≤ (M : ℝ) := norm_fderiv_le_of_lipschitz ℝ hM
  change ‖R.comp (H.comp J)‖ ≤ (M : ℝ) * ‖J‖ ^ 2
  calc
    _ ≤ ‖R‖ * ‖H.comp J‖ := ContinuousLinearMap.opNorm_comp_le _ _
    _ ≤ ‖J‖ * ((M : ℝ) * ‖J‖) := mul_le_mul hR
      ((ContinuousLinearMap.opNorm_comp_le _ _).trans
        (mul_le_mul_of_nonneg_right hH (norm_nonneg J)))
      (norm_nonneg (H.comp J)) (norm_nonneg J)
    _ = (M : ℝ) * ‖J‖ ^ 2 := by ring


/-- The genuine second-variation forcing is continuous in actual time on the whole true interval. -/
theorem textbookBrownianPathSecondVariationForcing_continuousOn (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    ContinuousOn (textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W) (Icc 0 T) := by
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT x W
  have hqc : ContinuousOn (fun t ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W) (Icc 0 T) := hq.1
  have hJ := (textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT x W).2
  have hJc : ContinuousOn (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W) (Icc 0 T) :=
    fun s hs ↦ (hJ s hs).continuousAt.continuousWithinAt
  have hc : ContDiff ℝ ∞ (fderiv ℝ (textbookBrownianSDEDrift m U)) :=
    (textbookBrownianSDEDrift_contDiff m U hU).fderiv_right (by simp)
  have hHc := (hc.continuous_fderiv (by simp)).comp_continuousOn hqc
  exact (((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip).continuous.comp_continuousOn hJc).clm_comp
    (hHc.clm_comp hJc)

/-- A true second variational equation has a real solution along every original path. -/
theorem textbookBrownianPathSecondVariation_exists (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    ∃ K : ℝ → ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))),
      K 0 = 0 ∧ ∀ t ∈ Icc 0 T, HasDerivAt K
        (((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)
          (fderiv ℝ (textbookBrownianSDEDrift m U)
            (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W))).comp (K t)) +
          textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W t) t := by
  let E := Fin N → ℝ
  let H := E →L[ℝ] E
  let D := E →L[ℝ] H
  let q := textbookBrownianPathSolution m hm U hU hp β hβ T hT x W
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT x W
  let A := fun t : ℝ ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (q (projIcc 0 T hT t))
  let R := fun t : ℝ ↦ textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W (projIcc 0 T hT t)
  let L := textbookBrownianDriftLipschitzConstant m U hU hp
  have hA : Continuous A :=
    ((textbookBrownianSDEDrift_contDiff m U hU).continuous_fderiv (by simp)).comp
      (hq.1.comp_continuous (continuous_subtype_val.comp continuous_projIcc)
        (fun t ↦ (projIcc 0 T hT t).property))
  have hR : Continuous R :=
    (textbookBrownianPathSecondVariationForcing_continuousOn m hm U hU hp β hβ T hT x W).comp_continuous
      (continuous_subtype_val.comp continuous_projIcc) (fun t ↦ (projIcc 0 T hT t).property)
  let C := fun t ↦ ContinuousLinearMap.compL ℝ E E E (A t)
  have hC : Continuous C := (ContinuousLinearMap.compL ℝ E E E).continuous.comp hA
  have hCb (t : ℝ) : ‖C t‖ ≤ (L : ℝ) := by
    have hh := (ContinuousLinearMap.compL ℝ E E E).le_opNorm (A t)
    exact hh.trans ((mul_le_mul_of_nonneg_right (ContinuousLinearMap.norm_compL_le ℝ E E E)
      (norm_nonneg _)).trans (by
        simpa only [one_mul] using
          (norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp) : ‖A t‖ ≤ (L : ℝ))))
  let F := fun t : ℝ ↦ fun K : D ↦ (C t).comp K + R t
  have hF (t : ℝ) : LipschitzWith L (F t) := by
    apply LipschitzWith.of_dist_le_mul
    intro J K
    rw [dist_eq_norm, dist_eq_norm]
    change ‖(C t).comp J + R t - ((C t).comp K + R t)‖ ≤ (L : ℝ) * ‖J - K‖
    rw [add_sub_add_right_eq_sub, ← ContinuousLinearMap.comp_sub]
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (mul_le_mul_of_nonneg_right (hCb t) (norm_nonneg _))
  have hFc (K : D) : Continuous (fun t ↦ F t K) := (hC.clm_comp continuous_const).add hR
  obtain ⟨δ, hδ, hl⟩ := uniform_local_exists F L hF hFc
  obtain ⟨K, hK0, hK⟩ := finite_interval_exists F δ hδ hl (0 : D) T
  refine ⟨K, hK0, fun t ht ↦ ?_⟩
  have hh := hK t ht
  simpa only [F, C, A, R, q, projIcc_of_mem hT ht, textbookBrownianPathEndpoint] using hh

/-- The actual second variation is selected from a proved true variational solution. -/
def textbookBrownianPathSecondVariation (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    ℝ → ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) :=
  Classical.choose (textbookBrownianPathSecondVariation_exists m hm U hU hp β hβ T hT x W)

/-- The genuine selected second variation has zero initial value and the actual differentiated equation. -/
theorem textbookBrownianPathSecondVariation_spec (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) :
    textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W 0 = 0 ∧
    ∀ t ∈ Icc 0 T, HasDerivAt
      (textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W)
      (((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)
        (fderiv ℝ (textbookBrownianSDEDrift m U)
          (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W))).comp
            (textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t)) +
        textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W t) t :=
  Classical.choose_spec (textbookBrownianPathSecondVariation_exists m hm U hU hp β hβ T hT x W)

/-- Actual second variations have a uniform finite bound over every true initial state and noise path. -/
theorem textbookBrownianPathSecondVariation_norm_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t‖ ≤ C := by
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
    ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
    ContinuousLinearMap.toNormedSpace
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) :=
    ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) :=
    ContinuousLinearMap.toNormedSpace
  obtain ⟨M, hM, hb⟩ := textbookBrownianPathSecondVariationForcing_norm_bound m hm U hU hp β hβ
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let G : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hG : 0 < G := by dsimp [G]; linarith
  let E : ℝ := Real.exp (G * T)
  let C : ℝ := M * E ^ 2 / G * E
  refine ⟨C, by dsimp [C]; positivity, fun x W t ht ↦ ?_⟩
  let K := textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W
  let J := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W
  obtain ⟨hK0, hK⟩ := textbookBrownianPathSecondVariation_spec m hm U hU hp β hβ T hT x W
  have hc : ContinuousOn K (Icc 0 T) := fun s hs ↦ (hK s hs).continuousAt.continuousWithinAt
  have hJb (s : ℝ) (hs : s ∈ Icc 0 T) : ‖J s‖ ≤ E := by
    exact (textbookBrownianPathJacobian_norm_le m hm U hU hp β hβ T hT x W s hs).trans
      (Real.exp_le_exp.mpr (calc
        L * s ≤ G * s := mul_le_mul_of_nonneg_right (by dsimp [G]; linarith) hs.1
        _ ≤ G * T := mul_le_mul_of_nonneg_left hs.2 hG.le))
  have hRb (s : ℝ) (hs : s ∈ Icc 0 T) :
      ‖textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W s‖ ≤ M * E ^ 2 :=
    (hb T hT x W s).trans
      (mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (norm_nonneg _) (hJb s hs) 2) hM)
  have hd (s : ℝ) (hs : s ∈ Ico 0 T) := (hK s (Ico_subset_Icc_self hs)).hasDerivWithinAt (s := Ici s)
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le hc hd
    (show ‖K 0‖ ≤ 0 by rw [show K 0 = 0 from hK0, norm_zero])
    (K := G) (ε := M * E ^ 2) (fun s hs ↦ by
      let A := fderiv ℝ (textbookBrownianSDEDrift m U)
        (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x s W)
      have hA : ‖ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ) A‖ ≤ L := by
        exact ((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).le_opNorm A).trans
          ((mul_le_mul_of_nonneg_right (ContinuousLinearMap.norm_compL_le ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ))
            (norm_nonneg A)).trans (by simpa only [one_mul] using
              (norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp) : ‖A‖ ≤ L)))
      calc
        _ ≤ ‖(ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ) A).comp (K s)‖ +
            ‖textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W s‖ := norm_add_le _ _
        _ ≤ L * ‖K s‖ + M * E ^ 2 := add_le_add
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul_of_nonneg_right hA (norm_nonneg _)))
          (hRb s (Ico_subset_Icc_self hs))
        _ ≤ G * ‖K s‖ + M * E ^ 2 := add_le_add
          (mul_le_mul_of_nonneg_right (by dsimp [G]; linarith) (norm_nonneg _)) le_rfl) t ht
  rw [sub_zero, gronwallBound_of_K_ne_0 hG.ne'] at hh
  have heT : Real.exp (G * t) - 1 ≤ E :=
    (sub_le_self _ zero_le_one).trans (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hG.le))
  have hh' : ‖K t‖ ≤ M * E ^ 2 / G * (Real.exp (G * t) - 1) := by
    simpa only [zero_mul, zero_add] using hh
  exact hh'.trans
    (mul_le_mul_of_nonneg_left heT (show 0 ≤ M * E ^ 2 / G by positivity))

/-- Genuine second variation gives a uniform quadratic initial error for the actual first variation. -/
theorem textbookBrownianPathJacobian_second_variation_error_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (x v : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathJacobian m hm U hU hp β hβ T hT (x + v) W t -
        textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t -
        textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t v‖ ≤ C * ‖v‖ ^ 2 := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  obtain ⟨D, hD, hTaylor⟩ := textbookBrownianSDEDrift_fderiv_first_taylor_bound m U hU hp
  obtain ⟨Cq, hCq, hEq⟩ := textbookBrownianPathEndpoint_jacobian_error_bound m hm U hU hp β hβ T hT
  obtain ⟨Cj, hCj, hEj⟩ := textbookBrownianPathJacobian_initial_norm_sub_bound m hm U hU hp β hβ T hT
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let G : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hG : 0 < G := by dsimp [G]; linarith
  let Q : ℝ := Real.exp (G * T)
  let B : ℝ := (D * Q ^ 2 + (M : ℝ) * Cq) * Q + (M : ℝ) * Q * Cj
  have hB : 0 ≤ B := by dsimp [B]; positivity
  let C : ℝ := B / G * Q
  refine ⟨C, by dsimp [C]; positivity, fun x v W t ht ↦ ?_⟩
  let q := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x s W
  let r := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT (x + v) s W
  let J := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W
  let R := textbookBrownianPathJacobian m hm U hU hp β hβ T hT (x + v) W
  let K := textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W
  let A := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (q s)
  let Ar := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (r s)
  let H := fun s ↦ fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)) (q s)
  obtain ⟨hJ0, hJ⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT x W
  obtain ⟨hR0, hR⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT (x + v) W
  obtain ⟨hK0, hK⟩ := textbookBrownianPathSecondVariation_spec m hm U hU hp β hβ T hT x W
  let e := fun s ↦ R s - J s - K s v
  let e' := fun s ↦ (Ar s).comp (R s) - (A s).comp (J s) -
    ((A s).comp (K s v) + (H s (J s v)).comp (J s))
  have he0 : e 0 = 0 := by
    dsimp [e, R, J, K]
    rw [hR0, hJ0, hK0, zero_apply, sub_self, sub_zero]
  have hJc : ContinuousOn J (Icc 0 T) := fun s hs ↦ (hJ s hs).continuousAt.continuousWithinAt
  have hRc : ContinuousOn R (Icc 0 T) := fun s hs ↦ (hR s hs).continuousAt.continuousWithinAt
  have hKv (s : ℝ) (hs : s ∈ Icc 0 T) :
      HasDerivAt (fun u ↦ K u v) ((A s).comp (K s v) + (H s (J s v)).comp (J s)) s := by
    have hh := (hK s hs).clm_apply (hasDerivAt_const s v)
    simpa only [K, A, H, J, q, textbookBrownianPathSecondVariationForcing,
      ContinuousLinearMap.comp_apply, ContinuousLinearMap.compL_apply, ContinuousLinearMap.flip_apply,
      add_apply, map_zero, add_zero] using hh
  have hKvc : ContinuousOn (fun s ↦ K s v) (Icc 0 T) := fun s hs ↦ (hKv s hs).continuousAt.continuousWithinAt
  have hc : ContinuousOn e (Icc 0 T) := (hRc.sub hJc).sub hKvc
  have hd (s : ℝ) (hs : s ∈ Ico 0 T) : HasDerivWithinAt e (e' s) (Ici s) s := by
    have hsT := Ico_subset_Icc_self hs
    have hh := ((hR s hsT).sub (hJ s hsT)).sub (hKv s hsT)
    simpa only [e, e', Ar, A, R, J, r, q, Pi.sub_def] using hh.hasDerivWithinAt
  have hqb (s : ℝ) (hs : s ∈ Icc 0 T) : ‖r s - q s‖ ≤ Q * ‖v‖ := by
    have hh := textbookBrownianPathEndpoint_same_noise_dist_le m hm U hU hp β hβ T hT W (x + v) x s hs
    have heQ : Real.exp (G * s) ≤ Q := Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hs.2 hG.le)
    simpa only [dist_eq_norm, add_sub_cancel_left, mul_comm] using
      hh.trans (mul_le_mul_of_nonneg_left heQ (dist_nonneg : 0 ≤ dist (x + v) x))
  have hJb (s : ℝ) (hs : s ∈ Icc 0 T) : ‖J s‖ ≤ Q :=
    (textbookBrownianPathJacobian_norm_le m hm U hU hp β hβ T hT x W s hs).trans
      (Real.exp_le_exp.mpr (calc
        L * s ≤ G * s := mul_le_mul_of_nonneg_right (by dsimp [G]; linarith) hs.1
        _ ≤ G * T := mul_le_mul_of_nonneg_left hs.2 hG.le))
  have hb (s : ℝ) (hs : s ∈ Ico 0 T) : ‖e' s‖ ≤ G * ‖e s‖ + B * ‖v‖ ^ 2 := by
    have hsT := Ico_subset_Icc_self hs
    have hAb : ‖A s‖ ≤ L := norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp)
    have hHb : ‖H s‖ ≤ (M : ℝ) := norm_fderiv_le_of_lipschitz ℝ hM
    have hAdiff : ‖Ar s - A s‖ ≤ (M : ℝ) * Q * ‖v‖ := by
      calc
        _ ≤ (M : ℝ) * ‖r s - q s‖ := hM.norm_sub_le _ _
        _ ≤ (M : ℝ) * (Q * ‖v‖) := mul_le_mul_of_nonneg_left (hqb s hsT) M.property
        _ = (M : ℝ) * Q * ‖v‖ := by ring
    have hJdiff : ‖R s - J s‖ ≤ Cj * ‖v‖ := by
      simpa only [add_sub_cancel_left] using hEj (x + v) x W s hsT
    have hrem : ‖Ar s - A s - H s (J s v)‖ ≤
        (D * Q ^ 2 + (M : ℝ) * Cq) * ‖v‖ ^ 2 := by
      have hTay : ‖Ar s - A s - H s (r s - q s)‖ ≤ D * ‖r s - q s‖ ^ 2 := by
        simpa only [add_sub_cancel, Ar, A, H] using hTaylor (q s) (r s - q s)
      have hqe : ‖r s - q s - J s v‖ ≤ Cq * ‖v‖ ^ 2 := hEq x v W s hsT
      have he : Ar s - A s - H s (J s v) =
          (Ar s - A s - H s (r s - q s)) + H s (r s - q s - J s v) := by
        simp only [map_sub]
        abel
      rw [he]
      calc
        _ ≤ ‖Ar s - A s - H s (r s - q s)‖ + ‖H s (r s - q s - J s v)‖ := norm_add_le _ _
        _ ≤ D * (Q * ‖v‖) ^ 2 + (M : ℝ) * (Cq * ‖v‖ ^ 2) := add_le_add
          (hTay.trans (mul_le_mul_of_nonneg_left
            (pow_le_pow_left₀ (norm_nonneg _) (hqb s hsT) 2) hD))
          (((H s).le_opNorm _).trans (mul_le_mul hHb hqe (norm_nonneg _) M.property))
        _ = (D * Q ^ 2 + (M : ℝ) * Cq) * ‖v‖ ^ 2 := by ring
    have he : e' s = (A s).comp (e s) +
        (Ar s - A s - H s (J s v)).comp (J s) +
        (Ar s - A s).comp (R s - J s) := by
      dsimp [e', e]
      simp only [ContinuousLinearMap.comp_sub, ContinuousLinearMap.sub_comp]
      abel
    rw [he]
    calc
      _ ≤ ‖(A s).comp (e s)‖ + ‖(Ar s - A s - H s (J s v)).comp (J s)‖ +
          ‖(Ar s - A s).comp (R s - J s)‖ := (norm_add_le _ _).trans
            (add_le_add (norm_add_le _ _) le_rfl)
      _ ≤ L * ‖e s‖ + ((D * Q ^ 2 + (M : ℝ) * Cq) * ‖v‖ ^ 2) * Q +
          ((M : ℝ) * Q * ‖v‖) * (Cj * ‖v‖) :=
        add_le_add (add_le_add
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul_of_nonneg_right hAb (norm_nonneg _)))
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hrem (hJb s hsT) (norm_nonneg _) (by positivity))))
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hAdiff hJdiff (norm_nonneg _) (by positivity)))
      _ ≤ G * ‖e s‖ + ((D * Q ^ 2 + (M : ℝ) * Cq) * ‖v‖ ^ 2) * Q +
          ((M : ℝ) * Q * ‖v‖) * (Cj * ‖v‖) :=
        add_le_add (add_le_add (mul_le_mul_of_nonneg_right (by dsimp [G]; linarith) (norm_nonneg _)) le_rfl) le_rfl
      _ = G * ‖e s‖ + B * ‖v‖ ^ 2 := by dsimp [B]; ring
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le hc hd
    (show ‖e 0‖ ≤ 0 by rw [he0, norm_zero]) hb t ht
  rw [sub_zero, gronwallBound_of_K_ne_0 hG.ne'] at hh
  have heQ : Real.exp (G * t) - 1 ≤ Q :=
    (sub_le_self _ zero_le_one).trans (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hG.le))
  calc
    _ ≤ B * ‖v‖ ^ 2 / G * (Real.exp (G * t) - 1) := by simpa only [e, R, J, K, zero_mul, zero_add] using hh
    _ ≤ B * ‖v‖ ^ 2 / G * Q := mul_le_mul_of_nonneg_left heQ (by positivity)
    _ = C * ‖v‖ ^ 2 := by dsimp [C]; ring

/-- The genuine derivative of the actual first variation is its constructed second variation. -/
theorem textbookBrownianPathJacobian_hasFDerivAt_initial (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    HasFDerivAt (fun y ↦ textbookBrownianPathJacobian m hm U hU hp β hβ T hT y W t)
      (textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t) x := by
  obtain ⟨C, _, hb⟩ := textbookBrownianPathJacobian_second_variation_error_bound m hm U hU hp β hβ T hT
  rw [hasFDerivAt_iff_isLittleO_nhds_zero]
  apply Asymptotics.isLittleO_iff.mpr
  intro ε hε
  have htC : Continuous (fun v : Fin N → ℝ ↦ (C + 1) * ‖v‖) := continuous_const.mul continuous_norm
  have ht0 : Tendsto (fun v : Fin N → ℝ ↦ (C + 1) * ‖v‖) (𝓝 0) (𝓝 0) := by
    simpa only [norm_zero, mul_zero] using htC.tendsto (0 : Fin N → ℝ)
  filter_upwards [ht0.eventually (gt_mem_nhds hε)] with v hv
  have hc' : C * ‖v‖ ≤ ε := (show C * ‖v‖ ≤ (C + 1) * ‖v‖ by nlinarith [norm_nonneg v]).trans hv.le
  calc
    _ ≤ C * ‖v‖ ^ 2 := hb x v W t ht
    _ ≤ ε * ‖v‖ := by nlinarith [mul_le_mul_of_nonneg_right hc' (norm_nonneg v)]

private theorem comp_right_norm {N : ℕ}
    (J : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :
    ‖(ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip J‖ ≤ ‖J‖ := by
  exact (((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip).le_opNorm J).trans
    (by rw [ContinuousLinearMap.opNorm_flip]; simpa only [one_mul] using
      mul_le_mul_of_nonneg_right (ContinuousLinearMap.norm_compL_le ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)) (norm_nonneg J))

/-- The actual quadratic second-variation forcing has a uniform Lipschitz initial-state bound. -/
theorem textbookBrownianPathSecondVariationForcing_initial_norm_sub_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (x y : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W t -
        textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT y W t‖ ≤ C * ‖x - y‖ := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  obtain ⟨D, hD⟩ := textbookBrownianSDEDrift_second_fderiv_lipschitz m U hU hp
  obtain ⟨Cj, hCj, hj⟩ := textbookBrownianPathJacobian_initial_norm_sub_bound m hm U hU hp β hβ T hT
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let G : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hG : 0 < G := by dsimp [G]; linarith
  let Q : ℝ := Real.exp (G * T)
  let C : ℝ := (D : ℝ) * Q ^ 3 + 2 * (M : ℝ) * Q * Cj
  refine ⟨C, by dsimp [C]; positivity, fun x y W t ht ↦ ?_⟩
  let qx := textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W
  let qy := textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W
  let Jx := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t
  let Jy := textbookBrownianPathJacobian m hm U hU hp β hβ T hT y W t
  let Hx := fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)) qx
  let Hy := fderiv ℝ (fderiv ℝ (textbookBrownianSDEDrift m U)) qy
  let R := (ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)).flip
  have hJn (z : Fin N → ℝ) :
      ‖textbookBrownianPathJacobian m hm U hU hp β hβ T hT z W t‖ ≤ Q :=
    (textbookBrownianPathJacobian_norm_le m hm U hU hp β hβ T hT z W t ht).trans
      (Real.exp_le_exp.mpr (calc
        L * t ≤ G * t := mul_le_mul_of_nonneg_right (by dsimp [G]; linarith) ht.1
        _ ≤ G * T := mul_le_mul_of_nonneg_left ht.2 hG.le))
  have hq : ‖qx - qy‖ ≤ Q * ‖x - y‖ := by
    have hh := textbookBrownianPathEndpoint_same_noise_dist_le m hm U hU hp β hβ T hT W x y t ht
    have heQ : Real.exp (G * t) ≤ Q := Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hG.le)
    simpa only [dist_eq_norm, mul_comm] using
      hh.trans (mul_le_mul_of_nonneg_left heQ (dist_nonneg : 0 ≤ dist x y))
  have hH : ‖Hx - Hy‖ ≤ (D : ℝ) * Q * ‖x - y‖ := by
    calc
      _ ≤ (D : ℝ) * ‖qx - qy‖ := hD.norm_sub_le _ _
      _ ≤ (D : ℝ) * (Q * ‖x - y‖) := mul_le_mul_of_nonneg_left hq D.property
      _ = (D : ℝ) * Q * ‖x - y‖ := by ring
  have hHy : ‖Hy‖ ≤ (M : ℝ) := norm_fderiv_le_of_lipschitz ℝ hM
  have hJ : ‖Jx - Jy‖ ≤ Cj * ‖x - y‖ := hj x y W t ht
  have he : (R Jx).comp (Hx.comp Jx) - (R Jy).comp (Hy.comp Jy) =
      (R Jx).comp ((Hx - Hy).comp Jx) +
        (R Jx).comp (Hy.comp (Jx - Jy)) +
        (R (Jx - Jy)).comp (Hy.comp Jy) := by
    simp only [map_sub, ContinuousLinearMap.comp_sub, ContinuousLinearMap.sub_comp]
    abel
  change ‖(R Jx).comp (Hx.comp Jx) - (R Jy).comp (Hy.comp Jy)‖ ≤ C * ‖x - y‖
  rw [he]
  have h1 : ‖(R Jx).comp ((Hx - Hy).comp Jx)‖ ≤
      Q * (((D : ℝ) * Q * ‖x - y‖) * Q) := by
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (mul_le_mul ((comp_right_norm Jx).trans (hJn x))
        ((ContinuousLinearMap.opNorm_comp_le _ _).trans
          (mul_le_mul hH (hJn x) (norm_nonneg Jx) (by positivity)))
        (norm_nonneg _) (by dsimp [Q]; positivity))
  have h2 : ‖(R Jx).comp (Hy.comp (Jx - Jy))‖ ≤ Q * ((M : ℝ) * (Cj * ‖x - y‖)) := by
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (mul_le_mul ((comp_right_norm Jx).trans (hJn x))
        ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hHy hJ (norm_nonneg _) M.property))
        (norm_nonneg _) (by dsimp [Q]; positivity))
  have h3 : ‖(R (Jx - Jy)).comp (Hy.comp Jy)‖ ≤ (Cj * ‖x - y‖) * ((M : ℝ) * Q) := by
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (mul_le_mul ((comp_right_norm (Jx - Jy)).trans hJ)
        ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hHy (hJn y) (norm_nonneg Jy) M.property))
        (norm_nonneg _) (by positivity))
  calc
    _ ≤ ‖(R Jx).comp ((Hx - Hy).comp Jx)‖ +
        ‖(R Jx).comp (Hy.comp (Jx - Jy))‖ +
        ‖(R (Jx - Jy)).comp (Hy.comp Jy)‖ :=
      (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ Q * (((D : ℝ) * Q * ‖x - y‖) * Q) + Q * ((M : ℝ) * (Cj * ‖x - y‖)) +
        (Cj * ‖x - y‖) * ((M : ℝ) * Q) := add_le_add (add_le_add h1 h2) h3
    _ = C * ‖x - y‖ := by dsimp [C]; ring

/-- Every true second variation is Lipschitz in the actual initial state, uniformly over the noise. -/
theorem textbookBrownianPathSecondVariation_initial_norm_sub_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (x y : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t -
        textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT y W t‖ ≤ C * ‖x - y‖ := by
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) := ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) := ContinuousLinearMap.toNormedSpace
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) := ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ))) := ContinuousLinearMap.toNormedSpace
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  obtain ⟨Ck, hCk, hk⟩ := textbookBrownianPathSecondVariation_norm_bound m hm U hU hp β hβ T hT
  obtain ⟨Cr, hCr, hr⟩ := textbookBrownianPathSecondVariationForcing_initial_norm_sub_bound m hm U hU hp β hβ T hT
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let G : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hG : 0 < G := by dsimp [G]; linarith
  let Q : ℝ := Real.exp (G * T)
  let B : ℝ := (M : ℝ) * Q * Ck + Cr
  have hB : 0 ≤ B := by dsimp [B]; positivity
  let C : ℝ := B / G * Q
  refine ⟨C, by dsimp [C]; positivity, fun x y W t ht ↦ ?_⟩
  let qx := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x s W
  let qy := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y s W
  let Kx := textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W
  let Ky := textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT y W
  let Rx := textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT x W
  let Ry := textbookBrownianPathSecondVariationForcing m hm U hU hp β hβ T hT y W
  let A := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (qx s)
  let Ay := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (qy s)
  let comp := ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)
  obtain ⟨hKx0, hKx⟩ := textbookBrownianPathSecondVariation_spec m hm U hU hp β hβ T hT x W
  obtain ⟨hKy0, hKy⟩ := textbookBrownianPathSecondVariation_spec m hm U hU hp β hβ T hT y W
  let e := fun s ↦ Kx s - Ky s
  let e' := fun s ↦ (comp (A s)).comp (Kx s) + Rx s - ((comp (Ay s)).comp (Ky s) + Ry s)
  have he0 : e 0 = 0 := by dsimp [e, Kx, Ky]; rw [hKx0, hKy0, sub_self]
  have hxc : ContinuousOn Kx (Icc 0 T) := fun s hs ↦ (hKx s hs).continuousAt.continuousWithinAt
  have hyc : ContinuousOn Ky (Icc 0 T) := fun s hs ↦ (hKy s hs).continuousAt.continuousWithinAt
  have hd (s : ℝ) (hs : s ∈ Ico 0 T) : HasDerivWithinAt e (e' s) (Ici s) s := by
    have hh := (hKx s (Ico_subset_Icc_self hs)).sub (hKy s (Ico_subset_Icc_self hs))
    simpa only [e, e', comp, A, Ay, qx, qy, Kx, Ky, Rx, Ry, Pi.sub_def] using hh.hasDerivWithinAt
  have hb (s : ℝ) (hs : s ∈ Ico 0 T) : ‖e' s‖ ≤ G * ‖e s‖ + B * ‖x - y‖ := by
    have hsT := Ico_subset_Icc_self hs
    have hq : ‖qx s - qy s‖ ≤ Q * ‖x - y‖ := by
      have hh := textbookBrownianPathEndpoint_same_noise_dist_le m hm U hU hp β hβ T hT W x y s hsT
      have heQ : Real.exp (G * s) ≤ Q := Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left hsT.2 hG.le)
      simpa only [dist_eq_norm, mul_comm] using
        hh.trans (mul_le_mul_of_nonneg_left heQ (dist_nonneg : 0 ≤ dist x y))
    have hA : ‖comp (A s)‖ ≤ L :=
      (comp.le_opNorm _).trans ((mul_le_mul_of_nonneg_right
        (ContinuousLinearMap.norm_compL_le ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ)) (norm_nonneg _)).trans
        (by simpa only [one_mul] using
          (norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp) : ‖A s‖ ≤ L)))
    have hAd : ‖comp (A s - Ay s)‖ ≤ (M : ℝ) * Q * ‖x - y‖ := by
      calc
        _ ≤ ‖A s - Ay s‖ := by
          have hh := comp.le_opNorm (A s - Ay s)
          have hb := mul_le_mul_of_nonneg_right
            (ContinuousLinearMap.norm_compL_le ℝ (Fin N → ℝ) (Fin N → ℝ) (Fin N → ℝ))
            (norm_nonneg (A s - Ay s))
          exact hh.trans (by simpa only [one_mul] using hb)
        _ ≤ (M : ℝ) * ‖qx s - qy s‖ := hM.norm_sub_le _ _
        _ ≤ (M : ℝ) * (Q * ‖x - y‖) := mul_le_mul_of_nonneg_left hq M.property
        _ = (M : ℝ) * Q * ‖x - y‖ := by ring
    have he : e' s = (comp (A s)).comp (e s) + (comp (A s - Ay s)).comp (Ky s) + (Rx s - Ry s) := by
      dsimp [e', e]
      simp only [map_sub, ContinuousLinearMap.comp_sub, ContinuousLinearMap.sub_comp]
      abel
    rw [he]
    calc
      _ ≤ ‖(comp (A s)).comp (e s)‖ + ‖(comp (A s - Ay s)).comp (Ky s)‖ + ‖Rx s - Ry s‖ :=
        (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
      _ ≤ L * ‖e s‖ + ((M : ℝ) * Q * ‖x - y‖) * Ck + Cr * ‖x - y‖ :=
        add_le_add (add_le_add
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul_of_nonneg_right hA (norm_nonneg _)))
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hAd (hk y W s hsT) (norm_nonneg _) (by positivity))))
          (hr x y W s hsT)
      _ ≤ G * ‖e s‖ + ((M : ℝ) * Q * ‖x - y‖) * Ck + Cr * ‖x - y‖ :=
        add_le_add (add_le_add (mul_le_mul_of_nonneg_right (by dsimp [G]; linarith) (norm_nonneg _)) le_rfl) le_rfl
      _ = G * ‖e s‖ + B * ‖x - y‖ := by dsimp [B]; ring
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le (hxc.sub hyc) hd
    (show ‖e 0‖ ≤ 0 by rw [he0, norm_zero]) hb t ht
  rw [sub_zero, gronwallBound_of_K_ne_0 hG.ne'] at hh
  have heQ : Real.exp (G * t) - 1 ≤ Q :=
    (sub_le_self _ zero_le_one).trans (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hG.le))
  calc
    _ ≤ B * ‖x - y‖ / G * (Real.exp (G * t) - 1) := by simpa only [e, Kx, Ky, Pi.sub_apply, zero_mul, zero_add] using hh
    _ ≤ B * ‖x - y‖ / G * Q := mul_le_mul_of_nonneg_left heQ (by positivity)
    _ = C * ‖x - y‖ := by dsimp [C]; ring

/-- The actual second initial derivative is truly continuous in the original initial state. -/
theorem textbookBrownianPathSecondVariation_initial_continuous (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun x ↦ textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianPathSecondVariation_initial_norm_sub_bound m hm U hU hp β hβ T hT
  have hLip : LipschitzWith ⟨C, hC⟩
      (fun x ↦ textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t) :=
    LipschitzWith.of_dist_le_mul (fun x y ↦ by rw [dist_eq_norm, dist_eq_norm]; exact hb x y W t ht)
  exact hLip.continuous

/-- The original genuine initial Jacobian of every actual path is truly C1. -/
theorem textbookBrownianPathJacobian_contDiff_one_initial (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    ContDiff ℝ 1 (fun x ↦ textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t) :=
  contDiff_one_iff_hasFDerivAt.mpr ⟨_,
    textbookBrownianPathSecondVariation_initial_continuous m hm U hU hp β hβ T hT W t ht,
    fun x ↦ textbookBrownianPathJacobian_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht⟩

/-- Actual spatial C2 regularity of the original selected solution follows from the true two variations. -/
theorem textbookBrownianPathEndpoint_contDiff_two_initial (T : ℝ) (hT : 0 ≤ T)
    (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    ContDiff ℝ 2 (fun x ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W) :=
  contDiff_succ_iff_hasFDerivAt.mpr ⟨_,
    textbookBrownianPathJacobian_contDiff_one_initial m hm U hU hp β hβ T hT W t ht,
    fun x ↦ textbookBrownianPathEndpoint_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht⟩

/-- The true second Frechet derivative of the original solution is exactly the actual second variation. -/
theorem textbookBrownianPathEndpoint_second_fderiv_initial_eq (T : ℝ) (hT : 0 ≤ T)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    fderiv ℝ (fderiv ℝ (fun y ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W)) x =
      textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t := by
  have he : fderiv ℝ (fun y ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W) =
      (fun y ↦ textbookBrownianPathJacobian m hm U hU hp β hβ T hT y W t) :=
    funext (fun y ↦ textbookBrownianPathEndpoint_fderiv_initial_eq m hm U hU hp β hβ T hT y W t ht)
  rw [he]
  exact (textbookBrownianPathJacobian_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht).fderiv
end
end MolecularDynamics
