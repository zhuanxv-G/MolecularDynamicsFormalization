import MolecularDynamics.Chapter06.LangevinC2KernelGenerator

/-! Compactly supported periodic C2 tests for the actual original kernel.
The lift's global Hessian bound is derived from compact support and periodicity;
only the pointwise expectation generator is claimed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem compactC2_projection_integer_shift {N : ℕ}
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

private theorem compactC2_hessian_integer_shift {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (z : textbookLangevinPhase N)
    (n : Fin N → ℤ) :
    iteratedFDeriv ℝ 2 (F ∘ textbookLangevinPeriodicProjection)
      (z + ((fun i ↦ (n i : ℝ)), 0)) =
      iteratedFDeriv ℝ 2 (F ∘ textbookLangevinPeriodicProjection) z := by
  have he : (fun w ↦ (F ∘ textbookLangevinPeriodicProjection)
      (w + ((fun i ↦ (n i : ℝ)), 0))) = F ∘ textbookLangevinPeriodicProjection := by
    funext w
    exact congrArg F (compactC2_projection_integer_shift w n)
  rw [← iteratedFDeriv_comp_add_right 2 ((fun i ↦ (n i : ℝ)), 0) z, he]

/-- A genuinely compactly supported observable on the periodic phase space
with a C2 real lift has a globally bounded lift Hessian. The real periodic lift
itself is not assumed to be compactly supported. -/
theorem textbookLangevinPeriodicCompactC2_lift_hessian_bound {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection))
    (hcs : HasCompactSupport F) :
    ∃ M : ℝ, 0 ≤ M ∧
      ∀ z, ‖iteratedFDeriv ℝ 2 (F ∘ textbookLangevinPeriodicProjection) z‖ ≤ M := by
  let g := F ∘ textbookLangevinPeriodicProjection
  let K : Set (Fin N → ℝ) := Prod.snd '' tsupport F
  let D : Set (textbookLangevinPhase N) := Icc (0 : Fin N → ℝ) 1 ×ˢ K
  have hK : IsCompact K := hcs.isCompact.image continuous_snd
  have hD : IsCompact D := isCompact_Icc.prod hK
  have hc : Continuous (iteratedFDeriv ℝ 2 g) := hG.continuous_iteratedFDeriv (by norm_num)
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
    have hh := compactC2_hessian_integer_shift F a n
    rw [he] at hh
    exact (hh ▸ hC a ha).trans (le_max_left _ _)
  · have hg : z ∉ tsupport g := by
      intro hzg
      have hFz : textbookLangevinPeriodicProjection z ∈ tsupport F :=
        tsupport_comp_subset_preimage F (textbookLangevinPeriodicProjection_continuous N) hzg
      exact hz ⟨textbookLangevinPeriodicProjection z, hFz, rfl⟩
    have hzero : iteratedFDeriv ℝ 2 g z = 0 := by
      by_contra h
      exact hg (support_iteratedFDeriv_subset 2 h)
    change ‖iteratedFDeriv ℝ 2 g z‖ ≤ max C 0
    rw [hzero, norm_zero]
    exact le_max_right C 0

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)
  (F : textbookLangevinPeriodicPhase N → ℝ) (hFc : Continuous F)
  (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F)

include hB hFc hG hcs in
/-- The actual original kernel integrates a compactly supported periodic C2
test near zero, with no externally supplied Hessian bound. -/
theorem textbookLangevinPeriodicTransitionKernel_compactC2_local_integrable
    (hγ : 0 < γ) (T : ℝ≥0) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    Integrable F (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) := by
  obtain ⟨M, _, hH⟩ := textbookLangevinPeriodicCompactC2_lift_hessian_bound F hG hcs
  exact textbookLangevinPeriodicTransitionKernel_C2_observable_local_integrable
    B P hB U hU hp L hF γ σ F hFc hG M hH hγ T hT1 x

include hB hFc hG hcs in
/-- The actual original periodic kernel's pointwise expectation generator on
genuine compact periodic C2 tests equals the existing differential expression.
This does not assert a closed semigroup domain or graph-core theorem. -/
theorem textbookLangevinPeriodicTransitionKernel_compactC2_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦
      ((∫ y, F y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T.toNNReal x) - F x) / T)
      (𝓝[>] 0) (𝓝 (textbookLangevinPeriodicDifferentialOperator U γ σ F x)) := by
  obtain ⟨M, hM, hH⟩ := textbookLangevinPeriodicCompactC2_lift_hessian_bound F hG hcs
  exact textbookLangevinPeriodicTransitionKernel_C2_actual_differentialOperator_limit
    B P hB U hU hp L hF γ σ F hFc hG M hM hH hγ x

end
end MolecularDynamics
