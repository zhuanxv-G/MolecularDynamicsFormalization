import MolecularDynamics.Chapter06.LangevinCompactC2Generator

/-! The existing periodic C2 differential expression is independent of real
representatives, continuous, and preserves compact support. Its C0 image does
not identify a closed semigroup domain or establish Gibbs invariance. -/
open Set Filter
open scoped Topology ContDiff
namespace MolecularDynamics
noncomputable section

private theorem opC2_projection_shift {N : ℕ} (z : textbookLangevinPhase N)
    (n : Fin N → ℤ) :
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

private theorem opC2_integer_shift {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection))
    (z : textbookLangevinPhase N) (n : Fin N → ℤ) :
    textbookLangevinDifferentialOperator U γ σ (F ∘ textbookLangevinPeriodicProjection)
      (z + ((fun i ↦ (n i : ℝ)), 0)) =
      textbookLangevinDifferentialOperator U γ σ (F ∘ textbookLangevinPeriodicProjection) z := by
  let g := F ∘ textbookLangevinPeriodicProjection
  let c : textbookLangevinPhase N := ((fun i ↦ (n i : ℝ)), 0)
  have he : (fun w ↦ g (w + c)) = g :=
    funext (fun w ↦ congrArg F (opC2_projection_shift w n))
  have hd : fderiv ℝ g (z + c) = fderiv ℝ g z := by
    rw [← fderiv_comp_add_right c, he]
  have hH : iteratedFDeriv ℝ 2 g (z + c) = iteratedFDeriv ℝ 2 g z := by
    rw [← iteratedFDeriv_comp_add_right 2 c z, he]
  have hv : textbookLangevinDrift U γ (z + c) = textbookLangevinDrift U γ z := by
    apply Prod.ext
    · change z.2 + 0 = z.2
      exact add_zero _
    · change textbookPotentialForce U (z.1 + fun i ↦ (n i : ℝ)) - γ • (z.2 + 0) =
        textbookPotentialForce U z.1 - γ • z.2
      rw [add_zero, textbookUnitPeriodicPotential_force U hU hp]
  change textbookLangevinDifferentialOperator U γ σ g (z + c) =
    textbookLangevinDifferentialOperator U γ σ g z
  rw [textbookLangevinDifferentialOperator_C2_frechet U γ σ g hG,
    textbookLangevinDifferentialOperator_C2_frechet U γ σ g hG, hd, hH, hv]

/-- The existing periodic differential expression agrees with every genuine
real representative of a C2 periodic test, not merely the chosen representative. -/
theorem textbookLangevinPeriodicDifferentialOperator_C2_lift {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (z : textbookLangevinPhase N) :
    textbookLangevinPeriodicDifferentialOperator U γ σ F (textbookLangevinPeriodicProjection z) =
      textbookLangevinDifferentialOperator U γ σ (F ∘ textbookLangevinPeriodicProjection) z := by
  let Q : UnitAddTorus (Fin N) := fun i ↦ (z.1 i : UnitAddCircle)
  let r := textbookLangevinPeriodicRepresentative Q
  have hi (i : Fin N) : ∃ n : ℤ, (n : ℝ) = r i - z.1 i := by
    have hz : ((r i - z.1 i : ℝ) : UnitAddCircle) = 0 := by
      rw [AddCircle.coe_sub]
      have he := congrFun (textbookLangevinPeriodicRepresentative_projects Q) i
      change (r i : UnitAddCircle) = (z.1 i : UnitAddCircle) at he
      rw [he, sub_self]
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp hz
    exact ⟨n, by simpa only [zsmul_eq_mul, mul_one] using hn⟩
  choose n hn using hi
  have he : z + ((fun i ↦ (n i : ℝ)), 0) = (r, z.2) := by
    apply Prod.ext
    · funext i
      change z.1 i + (n i : ℝ) = r i
      rw [hn i]
      ring
    · exact add_zero _
  have hs := opC2_integer_shift U hU hp γ σ F hG z n
  rw [he] at hs
  exact hs

private theorem opC2_real_continuous {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ : ℝ)
    (g : textbookLangevinPhase N → ℝ) (hg : ContDiff ℝ 2 g) :
    Continuous (textbookLangevinDifferentialOperator U γ σ g) := by
  have hForce : Continuous (textbookPotentialForce U) :=
    (textbookLangevinForce_contDiff U hU).continuous
  have hv : Continuous (textbookLangevinDrift U γ) := by
    unfold textbookLangevinDrift
    exact continuous_snd.prodMk ((hForce.comp continuous_fst).sub (continuous_snd.const_smul γ))
  have hd := hg.continuous_fderiv (by norm_num)
  have hH := hg.continuous_iteratedFDeriv (m := 2) (by norm_num)
  have he : textbookLangevinDifferentialOperator U γ σ g =
      (fun z ↦ fderiv ℝ g z (textbookLangevinDrift U γ z) + σ ^ 2 / 2 *
        ∑ i : Fin N, iteratedFDeriv ℝ 2 g z (fun _ ↦ ((0 : Fin N → ℝ), Pi.single i 1))) :=
    funext (fun z ↦ textbookLangevinDifferentialOperator_C2_frechet U γ σ g hg z)
  rw [he]
  apply Continuous.add (hd.clm_apply hv)
  apply continuous_const.mul
  apply continuous_finsetSum
  intro i _
  fun_prop

/-- The existing periodic C2 differential expression is genuinely continuous
through the actual open quotient; no continuity of chosen representatives is used. -/
theorem textbookLangevinPeriodicDifferentialOperator_C2_continuous {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) :
    Continuous (textbookLangevinPeriodicDifferentialOperator U γ σ F) := by
  apply (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr
  have he : textbookLangevinPeriodicDifferentialOperator U γ σ F ∘ textbookLangevinPeriodicProjection =
      textbookLangevinDifferentialOperator U γ σ (F ∘ textbookLangevinPeriodicProjection) :=
    funext (fun z ↦ textbookLangevinPeriodicDifferentialOperator_C2_lift U hU hp γ σ F hG z)
  rw [he]
  exact opC2_real_continuous U hU γ σ _ hG

/-- The actual C2 periodic differential expression cannot acquire support
outside the original test observable's topological support. -/
theorem textbookLangevinPeriodicDifferentialOperator_C2_tsupport_subset {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) :
    tsupport (textbookLangevinPeriodicDifferentialOperator U γ σ F) ⊆ tsupport F := by
  apply closure_minimal _ isClosed_closure
  intro x hx
  by_contra hxs
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let g := F ∘ textbookLangevinPeriodicProjection
  have hz : textbookLangevinPeriodicProjection z = x := by
    change ((fun i ↦ (textbookLangevinPeriodicRepresentative x.1 i : UnitAddCircle)), x.2) = x
    rw [textbookLangevinPeriodicRepresentative_projects]
  have hg : z ∉ tsupport g := by
    intro hzg
    have h := tsupport_comp_subset_preimage F
      (textbookLangevinPeriodicProjection_continuous N) hzg
    change textbookLangevinPeriodicProjection z ∈ tsupport F at h
    rw [hz] at h
    exact hxs h
  have hd : fderiv ℝ g z = 0 := by
    by_contra h
    exact hg (support_fderiv_subset ℝ h)
  have hH : iteratedFDeriv ℝ 2 g z = 0 := by
    by_contra h
    exact hg (support_iteratedFDeriv_subset 2 h)
  have hzero : textbookLangevinPeriodicDifferentialOperator U γ σ F x = 0 := by
    change textbookLangevinDifferentialOperator U γ σ g z = 0
    rw [textbookLangevinDifferentialOperator_C2_frechet U γ σ g hG, hd, hH]
    simp
  exact hx hzero

/-- Compact support of the actual periodic test is preserved by the existing
C2 differential expression, for all friction and noise coefficients. -/
theorem textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F) :
    HasCompactSupport (textbookLangevinPeriodicDifferentialOperator U γ σ F) :=
  hcs.of_isClosed_subset isClosed_closure
    (textbookLangevinPeriodicDifferentialOperator_C2_tsupport_subset U γ σ F hG)

/-- The actual differential expression maps compact periodic C2 tests to
genuine continuous functions vanishing at infinity. This C0 property alone does
not establish a closed generator domain, graph core, or invariant Gibbs law. -/
theorem textbookLangevinPeriodicDifferentialOperator_compactC2_continuous_vanishing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F) :
    Continuous (textbookLangevinPeriodicDifferentialOperator U γ σ F) ∧
      Tendsto (textbookLangevinPeriodicDifferentialOperator U γ σ F)
        (cocompact (textbookLangevinPeriodicPhase N)) (𝓝 0) :=
  ⟨textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ F hG,
    (textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U γ σ F hG hcs).is_zero_at_infty⟩

end
end MolecularDynamics
