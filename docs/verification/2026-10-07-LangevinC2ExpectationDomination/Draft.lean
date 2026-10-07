import MolecularDynamics.Chapter06.LangevinSmallTimeGrowth

/-! True initial-momentum domination of compact periodic C2 expectation quotients.
The domination is derived; exchange with invariant-law integrals remains separate. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem domC2_projection_integer_shift {N : ℕ}
    (z : textbookLangevinPhase N) (n : Fin N → ℤ) :
    textbookLangevinPeriodicProjection (z + ((fun i ↦ (n i : ℝ)), 0)) =
      textbookLangevinPeriodicProjection z := by
  apply Prod.ext
  · funext i
    change ((z.1 i + (n i : ℝ) : ℝ) : UnitAddCircle) = (z.1 i : UnitAddCircle)
    have hn : ((n i : ℝ) : UnitAddCircle) = 0 :=
      (AddCircle.coe_eq_zero_iff (1 : ℝ)).mpr ⟨n i, by simp [zsmul_eq_mul]⟩
    rw [AddCircle.coe_add, hn, add_zero]
  · change z.2 + 0 = z.2
    exact add_zero _

private theorem domC2_fderiv_integer_shift {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (z : textbookLangevinPhase N)
    (n : Fin N → ℤ) :
    fderiv ℝ (F ∘ textbookLangevinPeriodicProjection)
      (z + ((fun i ↦ (n i : ℝ)), 0)) =
      fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z := by
  have he : (fun w ↦ (F ∘ textbookLangevinPeriodicProjection)
      (w + ((fun i ↦ (n i : ℝ)), 0))) = F ∘ textbookLangevinPeriodicProjection := by
    funext w
    exact congrArg F (domC2_projection_integer_shift w n)
  rw [← fderiv_comp_add_right ((fun i ↦ (n i : ℝ)), 0), he]

/-- A genuinely compactly supported observable on the periodic phase space
with a C2 real lift has a globally bounded lift first derivative. The real periodic lift
itself is not assumed to be compactly supported. -/
theorem textbookLangevinPeriodicCompactC2_lift_fderiv_bound {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection))
    (hcs : HasCompactSupport F) :
    ∃ M : ℝ, 0 ≤ M ∧
      ∀ z, ‖fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z‖ ≤ M := by
  let g := F ∘ textbookLangevinPeriodicProjection
  let K : Set (Fin N → ℝ) := Prod.snd '' tsupport F
  let D : Set (textbookLangevinPhase N) := Icc (0 : Fin N → ℝ) 1 ×ˢ K
  have hK : IsCompact K := hcs.isCompact.image continuous_snd
  have hD : IsCompact D := isCompact_Icc.prod hK
  have hc : Continuous (fderiv ℝ g) := hG.continuous_fderiv (by norm_num)
  obtain ⟨C, hC⟩ := hD.exists_bound_of_continuousOn hc.continuousOn
  refine ⟨max C 0, le_max_right _ _, ?_⟩
  intro z
  by_cases hz : z.2 ∈ K
  · let a : textbookLangevinPhase N := ((fun i ↦ Int.fract (z.1 i)), z.2)
    let n : Fin N → ℤ := fun i ↦ Int.floor (z.1 i)
    have ha : a ∈ D := by
      refine ⟨?_, hz⟩
      constructor
      · intro i
        exact Int.fract_nonneg _
      · intro i
        exact (Int.fract_lt_one _).le
    have he : a + ((fun i ↦ (n i : ℝ)), 0) = z := by
      apply Prod.ext
      · funext i
        exact Int.fract_add_floor _
      · change z.2 + 0 = z.2
        exact add_zero _
    have hh := domC2_fderiv_integer_shift F a n
    rw [he] at hh
    exact (hh ▸ hC a ha).trans (le_max_left _ _)
  · have hg : z ∉ tsupport g := by
      intro hzg
      have hFz : textbookLangevinPeriodicProjection z ∈ tsupport F :=
        tsupport_comp_subset_preimage F (textbookLangevinPeriodicProjection_continuous N) hzg
      exact hz ⟨textbookLangevinPeriodicProjection z, hFz, rfl⟩
    have hzero : fderiv ℝ g z = 0 := by
      by_contra h
      exact hg (support_fderiv_subset ℝ h)
    change ‖fderiv ℝ g z‖ ≤ max C 0
    rw [hzero, norm_zero]
    exact le_max_right C 0
private def domC2_coord {N : ℕ} (v : textbookLangevinPhase N) : Fin N ⊕ Fin N → ℝ :=
  Sum.elim v.1 v.2

private def domC2_basis {N : ℕ} : Fin N ⊕ Fin N → textbookLangevinPhase N :=
  Sum.elim (fun i ↦ (Pi.single i 1, 0)) (fun i ↦ (0, Pi.single i 1))

private theorem domC2_expand {N : ℕ} (v : textbookLangevinPhase N) :
    v = ∑ a : Fin N ⊕ Fin N, domC2_coord v a • domC2_basis a := by
  have he : (∑ a : Fin N ⊕ Fin N, domC2_coord v a • domC2_basis a) =
      (∑ i : Fin N, v.1 i • (Pi.single i 1, (0 : Fin N → ℝ))) +
        (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), Pi.single i 1)) := by
    rw [Fintype.sum_sum_type]
    rfl
  rw [he]
  apply Prod.ext
  · change v.1 = (LinearMap.fst ℝ (Fin N → ℝ) (Fin N → ℝ))
      ((∑ i : Fin N, v.1 i • (Pi.single i 1, (0 : Fin N → ℝ))) +
        (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), Pi.single i 1)))
    rw [map_add, map_sum, map_sum]
    simp only [map_smul, LinearMap.fst_apply, smul_zero, Finset.sum_const_zero, add_zero]
    exact pi_eq_sum_univ' v.1
  · change v.2 = (LinearMap.snd ℝ (Fin N → ℝ) (Fin N → ℝ))
      ((∑ i : Fin N, v.1 i • (Pi.single i 1, (0 : Fin N → ℝ))) +
        (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), Pi.single i 1)))
    rw [map_add, map_sum, map_sum]
    simp only [map_smul, LinearMap.snd_apply, smul_zero, Finset.sum_const_zero, zero_add]
    exact pi_eq_sum_univ' v.2

private theorem domC2_linear_expand {N : ℕ}
    (A : textbookLangevinPhase N →L[ℝ] ℝ) (v : textbookLangevinPhase N) :
    A v = ∑ a : Fin N ⊕ Fin N, A (domC2_basis a) * domC2_coord v a := by
  calc
    _ = A (∑ a : Fin N ⊕ Fin N, domC2_coord v a • domC2_basis a) :=
      congrArg A (domC2_expand v)
    _ = _ := by simp only [map_sum, map_smul, smul_eq_mul, mul_comm]


private theorem domC2_mean_norm_from_square (a C S T : ℝ)
    (hC : 0 ≤ C) (hS : 1 ≤ S) (hT : 0 ≤ T) (ha : a ^ 2 ≤ C * S * T ^ 2) :
    ‖a‖ ≤ (C + 1) * S * T := by
  have hS0 : 0 ≤ S := by linarith
  have hSS : S ≤ S ^ 2 := by nlinarith
  have hCC : C ≤ (C + 1) ^ 2 := by nlinarith [sq_nonneg C]
  have he : C * S * T ^ 2 ≤ ((C + 1) * S * T) ^ 2 := by
    calc
      _ ≤ (C + 1) ^ 2 * S * T ^ 2 :=
        mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hCC hS0) (sq_nonneg T)
      _ ≤ (C + 1) ^ 2 * S ^ 2 * T ^ 2 :=
        mul_le_mul_of_nonneg_right
          (mul_le_mul_of_nonneg_left hSS (sq_nonneg (C + 1))) (sq_nonneg T)
      _ = _ := by ring
  have hbound : 0 ≤ (C + 1) * S * T := by positivity
  rw [Real.norm_eq_abs]
  nlinarith [sq_abs a, abs_nonneg a]

private theorem domC2_basis_norm {N : ℕ} (a : Fin N ⊕ Fin N) :
    ‖domC2_basis a‖ ≤ 1 := by
  have hs (i : Fin N) : ‖(Pi.single i (1 : ℝ) : Fin N → ℝ)‖ ≤ 1 := by
    apply (pi_norm_le_iff_of_nonneg (by norm_num : (0 : ℝ) ≤ 1)).mpr
    intro j
    by_cases hij : i = j
    · subst j
      simp
    · simp [hij]
  cases a with
  | inl i =>
    simpa only [domC2_basis, Sum.elim_inl, Sum.elim_inr, Prod.fst, Prod.snd, Prod.norm_def, norm_zero, max_le_iff] using
      (show ‖(Pi.single i (1 : ℝ) : Fin N → ℝ)‖ ≤ 1 ∧ (0 : ℝ) ≤ 1 from ⟨hs i, zero_le_one⟩)
  | inr i =>
    simpa only [domC2_basis, Sum.elim_inl, Sum.elim_inr, Prod.fst, Prod.snd, Prod.norm_def, norm_zero, max_le_iff] using
      (show (0 : ℝ) ≤ 1 ∧ ‖(Pi.single i (1 : ℝ) : Fin N → ℝ)‖ ≤ 1 from ⟨zero_le_one, hs i⟩)

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
include hB hU hp in
private theorem domC2_coordinate_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (a : Fin N ⊕ Fin N) :
    MemLp (fun sample ↦ domC2_coord
      (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a) 2 P := by
  cases a with
  | inl i =>
    exact textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x i
  | inr i =>
    exact textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x i

include hB hU hp in
private theorem domC2_linear_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (A : textbookLangevinPhase N →L[ℝ] ℝ) :
    Integrable (fun sample ↦
      A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi (a : Fin N ⊕ Fin N) : Integrable (fun sample ↦ A (domC2_basis a) *
      domC2_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a) P :=
    ((domC2_coordinate_memLp B P hB U hU hp L hF γ σ hγ T hT x a).integrable
      (by norm_num)).const_mul _
  apply (integrable_finsetSum Finset.univ (fun a _ ↦ hi a)).congr
  exact Eventually.of_forall (fun sample ↦ (domC2_linear_expand A _).symm)


include hB hU hp in
/-- Actual expectation of every bounded linear Taylor coefficient has one
quadratic initial-momentum growth constant, uniform in initial phase and time. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_linear_mean_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N, ∀ D : ℝ, 0 ≤ D →
      ∀ A : textbookLangevinPhase N →L[ℝ] ℝ, ‖A‖ ≤ D →
      ‖∫ sample, A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) ∂P‖ ≤
        D * C * (1 + ‖x.2‖ ^ 2) * T := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨Cp, hCp, hpB⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_mean_square_growth_bound
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨Cq, hCq, hqB⟩ := textbookLangevinPeriodicConfigurationLift_mean_square_growth_bound
    B P hB U hU hp L hF γ σ hγ
  let C := 2 * N * (Cp + Cq + 1)
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  refine ⟨C, hC, fun T hT hT1 x D hD A hA ↦ ?_⟩
  let S := 1 + ‖x.2‖ ^ 2
  have hS : 1 ≤ S := by dsimp only [S]; nlinarith [sq_nonneg ‖x.2‖]
  have hcoordSquare (a : Fin N ⊕ Fin N) :
      (∫ sample, domC2_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a ∂P) ^ 2 ≤
        (Cp + Cq) * S * T ^ 2 := by
    have hn (i : Fin N) : 1 + x.2 i ^ 2 ≤ S := by
      apply add_le_add le_rfl
      simpa only [Real.norm_eq_abs, sq_abs] using
        (sq_le_sq₀ (norm_nonneg (x.2 i)) (norm_nonneg x.2)).mpr (norm_le_pi_norm x.2 i)
    cases a with
    | inl i =>
      have hb := hqB T hT hT1 x i
      have hm := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left (hn i) hCq) (sq_nonneg T)
      have he : Cq * S * T ^ 2 ≤ (Cp + Cq) * S * T ^ 2 := mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_right (show Cq ≤ Cp + Cq from le_add_of_nonneg_left hCp) (show 0 ≤ S by positivity)) (sq_nonneg T)
      exact hb.trans (hm.trans he)
    | inr i =>
      have hb := hpB T hT hT1 x i
      have hm := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left (hn i) hCp) (sq_nonneg T)
      have he : Cp * S * T ^ 2 ≤ (Cp + Cq) * S * T ^ 2 := mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_right (show Cp ≤ Cp + Cq from le_add_of_nonneg_right hCq) (show 0 ≤ S by positivity)) (sq_nonneg T)
      exact hb.trans (hm.trans he)
  have hcoordNorm (a : Fin N ⊕ Fin N) :
      ‖∫ sample, domC2_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a ∂P‖ ≤
        (Cp + Cq + 1) * S * T :=
    domC2_mean_norm_from_square _ (Cp + Cq) S T (add_nonneg hCp hCq) hS hT (hcoordSquare a)
  have hi (a : Fin N ⊕ Fin N) : Integrable (fun sample ↦ A (domC2_basis a) *
      domC2_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a) P :=
    ((domC2_coordinate_memLp B P hB U hU hp L hF γ σ hγ T hT x a).integrable
      (by norm_num)).const_mul _
  have hefun : (fun sample ↦ A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)) =
      (fun sample ↦ ∑ a : Fin N ⊕ Fin N, A (domC2_basis a) *
        domC2_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a) :=
    funext (fun sample ↦ domC2_linear_expand A _)
  rw [hefun, integral_finsetSum Finset.univ (fun a _ ↦ hi a)]
  simp only [integral_const_mul]
  have hac (a : Fin N ⊕ Fin N) : ‖A (domC2_basis a)‖ ≤ D :=
    (A.le_opNorm _).trans
      ((mul_le_mul_of_nonneg_left (domC2_basis_norm a) (norm_nonneg A)).trans
        (by simpa only [mul_one] using hA))
  calc
    _ ≤ ∑ a : Fin N ⊕ Fin N, ‖A (domC2_basis a) *
        (∫ sample, domC2_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a ∂P)‖ :=
      norm_sum_le _ _
    _ ≤ ∑ _a : Fin N ⊕ Fin N, D * ((Cp + Cq + 1) * S * T) := by
      apply Finset.sum_le_sum
      intro a _
      rw [norm_mul]
      exact mul_le_mul (hac a) (hcoordNorm a) (norm_nonneg _) hD
    _ = D * C * (1 + ‖x.2‖ ^ 2) * T := by
      simp only [Finset.sum_const, Finset.card_univ, Fintype.card_sum, Fintype.card_fin, nsmul_eq_mul]
      dsimp only [C, S]
      push_cast
      ring


private theorem domC2_first_remainder_bound {N : ℕ}
    (g : textbookLangevinPhase N → ℝ) (hg : ContDiff ℝ 2 g)
    (M : ℝ) (hM : 0 ≤ M) (hH : ∀ z, ‖iteratedFDeriv ℝ 2 g z‖ ≤ M)
    (z y : textbookLangevinPhase N) :
    ‖g (z + y) - g z - fderiv ℝ g z y‖ ≤ (3 * M) * ‖y‖ ^ 2 := by
  have hR := textbookLangevinC2ObservableTaylorRemainder_quadratic_bound g hg M hH z y
  have hV : ‖iteratedFDeriv ℝ 2 g z (fun _ ↦ y)‖ ≤ M * ‖y‖ ^ 2 := by
    simpa using (iteratedFDeriv ℝ 2 g z).le_of_opNorm_le (hH z) (fun _ ↦ y)
  have he : g (z + y) - g z - fderiv ℝ g z y =
      (2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 g z (fun _ ↦ y) +
        textbookLangevinC2ObservableTaylorRemainder g z y := by
    unfold textbookLangevinC2ObservableTaylorRemainder
    ring
  rw [he]
  calc
    _ ≤ ‖(2 : ℝ)⁻¹ * iteratedFDeriv ℝ 2 g z (fun _ ↦ y)‖ +
        ‖textbookLangevinC2ObservableTaylorRemainder g z y‖ := norm_add_le _ _
    _ ≤ (2 : ℝ)⁻¹ * (M * ‖y‖ ^ 2) + (2 * M) * ‖y‖ ^ 2 := by
      rw [norm_mul, Real.norm_of_nonneg (by norm_num : 0 ≤ (2 : ℝ)⁻¹)]
      exact add_le_add (mul_le_mul_of_nonneg_left hV (by norm_num)) hR
    _ ≤ (3 * M) * ‖y‖ ^ 2 := by nlinarith [sq_nonneg ‖y‖]

variable (F : textbookLangevinPeriodicPhase N → ℝ)
  (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F)

include hB hU hp hG hcs in
/-- The true compact C2 observable increment expectation has one derived
quadratic initial-momentum domination constant, uniform over all initial phases.
The Brownian first term is averaged before taking norms. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_compactC2_mean_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 ≤ T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N,
      ‖∫ sample, F (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) -
        F x ∂P‖ ≤ C * (1 + ‖x.2‖ ^ 2) * T := by
  obtain ⟨D, hD, hDg⟩ := textbookLangevinPeriodicCompactC2_lift_fderiv_bound F hG hcs
  obtain ⟨M, hM, hHg⟩ := textbookLangevinPeriodicCompactC2_lift_hessian_bound F hG hcs
  obtain ⟨Cl, hCl, hl⟩ := textbookLangevinPeriodicRealPhaseIncrement_linear_mean_growth_bound
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨Cs, hCs, hs⟩ := textbookLangevinPeriodicRealPhaseIncrement_second_growth_bound
    B P hB U hU hp L hF γ σ hγ
  let C := D * Cl + 3 * M * Cs
  have hC : 0 ≤ C := by dsimp only [C]; positivity
  refine ⟨C, hC, fun T hT hT1 x ↦ ?_⟩
  let g := F ∘ textbookLangevinPeriodicProjection
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let δ := textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x
  let A := fderiv ℝ g z
  let R := fun sample ↦ g (z + δ sample) - g z - A (δ sample)
  have hiA : Integrable (fun sample ↦ A (δ sample)) P :=
    domC2_linear_integrable B P hB U hU hp L hF γ σ hγ T hT x A
  have hiSq : Integrable (fun sample ↦ ‖δ sample‖ ^ 2) P := by
    simpa only [mul_one] using textbookLangevinPeriodicRealPhaseIncrement_norm_even_integrable
      B P hB U hU hp L hF γ σ hγ T hT hT1 x 1 (by norm_num)
  have hδ : AEMeasurable δ P := (textbookLangevinGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ z T hT).sub aemeasurable_const
  have hRc : Continuous (fun y ↦ g (z + y) - g z - A y) := by
    have hgc : Continuous g := hG.continuous
    fun_prop
  have hRb : ∀ sample, ‖R sample‖ ≤ (3 * M) * ‖δ sample‖ ^ 2 :=
    fun sample ↦ domC2_first_remainder_bound g hG M hM hHg z (δ sample)
  have hiR : Integrable R P := (hiSq.const_mul (3 * M)).mono'
    (hRc.measurable.comp_aemeasurable hδ).aestronglyMeasurable (Eventually.of_forall hRb)
  have hRmean : ‖∫ sample, R sample ∂P‖ ≤ (3 * M) * (∫ sample, ‖δ sample‖ ^ 2 ∂P) := by
    calc
      _ ≤ ∫ sample, ‖R sample‖ ∂P := norm_integral_le_integral_norm _
      _ ≤ ∫ sample, (3 * M) * ‖δ sample‖ ^ 2 ∂P :=
        integral_mono hiR.norm (hiSq.const_mul (3 * M)) hRb
      _ = _ := integral_const_mul _ _
  have hz : g z = F x := by
    apply congrArg F
    change ((fun i ↦ (textbookLangevinPeriodicRepresentative x.1 i : UnitAddCircle)), x.2) = x
    rw [textbookLangevinPeriodicRepresentative_projects]
  have hEnd (sample : Ω) : z + δ sample =
      textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample := by
    dsimp only [δ, textbookLangevinPeriodicRealPhaseIncrement, z]
    abel
  have he : (fun sample ↦ F
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - F x) =
      (fun sample ↦ A (δ sample) + R sample) := by
    funext sample
    change g (textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample) - F x = _
    rw [← hEnd sample, ← hz]
    dsimp only [R]
    ring
  rw [he, integral_add hiA hiR]
  have hLinear := hl T hT hT1 x D hD A (hDg z)
  have hSecond := mul_le_mul_of_nonneg_left (hs T hT hT1 x)
    (show 0 ≤ 3 * M by positivity)
  calc
    _ ≤ ‖∫ sample, A (δ sample) ∂P‖ + ‖∫ sample, R sample ∂P‖ := norm_add_le _ _
    _ ≤ D * Cl * (1 + ‖x.2‖ ^ 2) * T + (3 * M) * (Cs * (1 + ‖x.2‖ ^ 2) * T) :=
      add_le_add hLinear (hRmean.trans hSecond)
    _ = C * (1 + ‖x.2‖ ^ 2) * T := by dsimp only [C]; ring

include hB hG hcs in
/-- The same original kernel's genuine compact C2 expectation quotient has
a derived C(1+norm p0²) dominator for all initial phases and 0<t≤1.
This is the domination input, not an assumed exchange of invariant integrals. -/
theorem textbookLangevinPeriodicTransitionKernel_compactC2_quotient_growth_bound
    (hγ : 0 < γ) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ T : ℝ, 0 < T → T ≤ 1 →
      ∀ x : textbookLangevinPeriodicPhase N,
      ‖((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) -
        F x) / T‖ ≤ C * (1 + ‖x.2‖ ^ 2) := by
  obtain ⟨C, hC, hb⟩ := textbookLangevinPeriodicGlobalRandomPhase_compactC2_mean_growth_bound
    B P hB U hU hp L hF γ σ F hG hcs hγ
  obtain ⟨M, _, hH⟩ := textbookLangevinPeriodicCompactC2_lift_hessian_bound F hG hcs
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  refine ⟨C, hC, fun T hT hT1 x ↦ ?_⟩
  have hNN : T.toNNReal ≤ 1 := by
    exact_mod_cast (show (T.toNNReal : ℝ) ≤ (1 : ℝ) by
      simpa only [Real.coe_toNNReal T hT.le] using hT1)
  have he := textbookLangevinPeriodicTransitionKernel_C2_observable_actual_increment_expectation
    B P hB U hU hp L hF γ σ F hFc hG M hH hγ T.toNNReal hNN x
  have he' : (∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) - F x =
      ∫ sample, F (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) - F x ∂P := by
    simpa only [Real.coe_toNNReal T hT.le] using he
  rw [he', norm_div, Real.norm_of_nonneg hT.le]
  exact (div_le_iff₀ hT).mpr (hb T hT.le hT1 x)

end
end MolecularDynamics
