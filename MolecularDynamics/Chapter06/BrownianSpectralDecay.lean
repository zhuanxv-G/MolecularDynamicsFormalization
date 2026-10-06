import MolecularDynamics.Chapter06.BrownianSpectralGenerator

/-! Genuine equilibrium-mode preservation and exponential decay of the entire original Gibbs evolution. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private abbrev oneVector : Gibbs U β :=
  textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)

private theorem one_graph :
    (oneVector U hU hPU β, 0) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  let a := Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
    (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc 1))
  exact (LinearPMap.mem_graph_iff _).mpr
    ⟨a, rfl, textbookBrownianGibbsClosedOperator_const m U hU hPU β 1⟩

/-- The actual original Gibbs evolution is symmetric on the entire Hilbert space. -/
theorem textbookBrownianGibbsSpectralEvolution_isSymmetric (t : NNReal) :
    (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t).toLinearMap.IsSymmetric := by
  intro x y
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  have hx := b.tsum_inner_mul_inner (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) y
  have hy := b.tsum_inner_mul_inner x (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t y)
  change ⟪textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x, y⟫_ℝ =
    ⟪x, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t y⟫_ℝ
  rw [← hx, ← hy]
  congr 1
  funext j
  have hcomm : ⟪textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x, b j⟫_ℝ =
      ⟪b j, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x⟫_ℝ := real_inner_comm _ _
  have hcomm' : ⟪x, b j⟫_ℝ = ⟪b j, x⟫_ℝ := real_inner_comm _ _
  rw [hcomm, hcomm', textbookBrownianGibbsSpectralEvolution_coefficient,
    textbookBrownianGibbsSpectralEvolution_coefficient]
  ring

/-- The genuine original normalized constant mode is fixed by the actual evolution. -/
theorem textbookBrownianGibbsSpectralEvolution_one (t : NNReal) :
    textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t (oneVector U hU hPU β) =
      oneVector U hU hPU β := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  apply b.repr.injective
  apply Subtype.ext
  funext j
  rw [b.repr_apply_apply, b.repr_apply_apply, textbookBrownianGibbsSpectralEvolution_coefficient]
  by_cases hj : j.1 = 0
  · simp only [textbookBrownianGibbsEvolutionWeight, hj, zero_mul, Real.exp_zero, one_mul]
    rfl
  · have h := textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ
      (oneVector U hU hPU β) 0 (one_graph m U hU hPU β) j
    rw [inner_zero_right] at h
    have hz : ⟪b j, oneVector U hU hPU β⟫_ℝ = 0 := (mul_eq_zero.mp h.symm).resolve_left hj
    rw [hz, mul_zero]

/-- The true entire evolution preserves the actual original Gibbs constant-mode pairing. -/
theorem textbookBrownianGibbsSpectralEvolution_mean (t : NNReal) (x : Gibbs U β) :
    ⟪oneVector U hU hPU β, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x⟫_ℝ =
      ⟪oneVector U hU hPU β, x⟫_ℝ := by
  have h := textbookBrownianGibbsSpectralEvolution_isSymmetric m hm U hU hPU β hβ t
    (oneVector U hU hPU β) x
  change ⟪textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t (oneVector U hU hPU β), x⟫_ℝ =
    ⟪oneVector U hU hPU β, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x⟫_ℝ at h
  rw [textbookBrownianGibbsSpectralEvolution_one] at h
  exact h.symm

private theorem zero_eigen_coefficient (x : Gibbs U β)
    (hx : ⟪oneVector U hU hPU β, x⟫_ℝ = 0)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) (hj : j.1 = 0) :
    ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ = 0 := by
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ j)
  change (a : Gibbs U β) = textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j at ha
  change textbookBrownianGibbsClosedOperator m U hU hPU β a =
    j.1 • textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j at hAa
  rw [hj, zero_smul] at hAa
  have h := textbookBrownianGibbsClosedOperator_kernel_constant m hm U hU hPU β hβ a hAa
  rw [ha] at h
  rw [h, real_inner_smul_left, hx, mul_zero]

/-- All actual vectors orthogonal to the original equilibrium mode decay at the derived exponential rate. -/
theorem textbookBrownianGibbsSpectralEvolution_orthogonal_decay (t : NNReal)
    (x : Gibbs U β) (hx : ⟪oneVector U hU hPU β, x⟫_ℝ = 0) :
    ‖textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x‖ ≤
      Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) * ‖x‖ := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  let c := Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ))
  have hc : 0 < c := Real.exp_pos _
  have hp (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
      ‖b.repr (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) j‖ ≤
        ‖(c • b.repr x) j‖ := by
    rw [b.repr_apply_apply, textbookBrownianGibbsSpectralEvolution_coefficient]
    change ‖textbookBrownianGibbsEvolutionWeight m U hU hPU β t j * ⟪b j, x⟫_ℝ‖ ≤
      ‖c * b.repr x j‖
    rw [b.repr_apply_apply]
    by_cases hj : j.1 = 0
    · rw [zero_eigen_coefficient m hm U hU hPU β hβ x hx j hj, mul_zero, mul_zero]
    · have hw : textbookBrownianGibbsEvolutionWeight m U hU hPU β t j ≤ c :=
        Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_right
          (textbookBrownianGibbsEigenbasis_eigenvalue_gap m hm U hU hPU β hβ j hj) t.property)
      simp only [norm_mul, Real.norm_eq_abs,
        abs_of_pos (textbookBrownianGibbsEvolutionWeight_pos m U hU hPU β t j), abs_of_pos hc]
      exact mul_le_mul_of_nonneg_right hw (abs_nonneg _)
  have h := lp.norm_mono (by norm_num : (2 : ENNReal) ≠ 0) hp
  rw [b.repr.norm_map, norm_smul, b.repr.norm_map, Real.norm_eq_abs, abs_of_pos hc] at h
  exact h

/-- Every actual original Gibbs vector converges exponentially toward its true constant-mode projection in norm. -/
theorem textbookBrownianGibbsSpectralEvolution_centered_decay (t : NNReal) (x : Gibbs U β) :
    ‖textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x -
      ⟪oneVector U hU hPU β, x⟫_ℝ • oneVector U hU hPU β‖ ≤
      Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) *
        ‖x - ⟪oneVector U hU hPU β, x⟫_ℝ • oneVector U hU hPU β‖ := by
  let e := oneVector U hU hPU β
  have he : ⟪e, e⟫_ℝ = 1 := by
    rw [real_inner_self_eq_norm_sq, textbookPeriodicSmoothEmbedding_one_norm]
    norm_num
  have hx : ⟪e, x - ⟪e, x⟫_ℝ • e⟫_ℝ = 0 := by
    rw [inner_sub_right, inner_smul_right, he, mul_one, sub_self]
  have h := textbookBrownianGibbsSpectralEvolution_orthogonal_decay m hm U hU hPU β hβ t
    (x - ⟪e, x⟫_ℝ • e) hx
  rw [map_sub, map_smul, textbookBrownianGibbsSpectralEvolution_one] at h
  exact h

/-- Genuine Gibbs Hilbert correlations converge exponentially to the actual equilibrium-mode pairing. -/
theorem textbookBrownianGibbsSpectralEvolution_correlation_decay (t : NNReal) (x g : Gibbs U β) :
    |⟪g, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x⟫_ℝ -
      ⟪g, oneVector U hU hPU β⟫_ℝ * ⟪oneVector U hU hPU β, x⟫_ℝ| ≤
      Real.exp (-textbookBrownianGibbsCoercivityRate m U hU hPU β * (t : ℝ)) * ‖g‖ *
        ‖x - ⟪oneVector U hU hPU β, x⟫_ℝ • oneVector U hU hPU β‖ := by
  have he :
      ⟪g, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x⟫_ℝ -
        ⟪g, oneVector U hU hPU β⟫_ℝ * ⟪oneVector U hU hPU β, x⟫_ℝ =
      ⟪g, textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x -
        ⟪oneVector U hU hPU β, x⟫_ℝ • oneVector U hU hPU β⟫_ℝ := by
    rw [inner_sub_right, inner_smul_right, mul_comm]
  rw [he, ← Real.norm_eq_abs]
  have h := (norm_inner_le_norm (𝕜 := ℝ) g _).trans
    (mul_le_mul_of_nonneg_left
      (textbookBrownianGibbsSpectralEvolution_centered_decay m hm U hU hPU β hβ t x) (norm_nonneg g))
  simpa only [mul_assoc, mul_left_comm] using h

end
end MolecularDynamics
