import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03Short34
set_option maxHeartbeats 400000
theorem exponentialFlat :
  ∀ γ > 0, ∀ k : ℕ, Tendsto (fun h : ℝ => Real.exp (-γ/h)/h^k) (𝓝[>] 0) (𝓝 0) := by
  intro γ hγ k
  have ht : Tendsto (fun h : ℝ => γ / h) (𝓝[>] 0) atTop := by
    simpa only [div_eq_mul_inv] using tendsto_inv_nhdsGT_zero.const_mul_atTop hγ
  have hp := ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero k).comp ht).div_const (γ^k)
  convert hp using 1
  · ext h
    by_cases hh : h = 0
    · subst h; cases k <;> simp
    · have hg : γ ≠ 0 := ne_of_gt hγ
      simp only [Function.comp_apply, div_pow, neg_div]
      field_simp
  · simp
end MD.Ch03Short34
