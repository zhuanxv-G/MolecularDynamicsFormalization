import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Short
set_option maxHeartbeats 400000
theorem scalarEulerStable :
  ∀ h rho, MolecularDynamics.Chapter04Review.scalarStable (MolecularDynamics.Chapter04Review.eulerFactor h rho) ↔ ‖MolecularDynamics.Chapter04Review.eulerFactor h rho‖ ≤ 1 := by
  intro h rho
  constructor
  · rintro ⟨C, hC⟩
    by_contra hn
    obtain ⟨k, hk⟩ := exists_lt_pow (lt_of_not_ge hn) C
    have hb := hC k
    rw [norm_pow] at hb
    exact (not_lt_of_ge hb) hk
  · intro ha
    refine ⟨1, ?_⟩
    intro k
    rw [norm_pow]
    exact pow_le_one₀ (norm_nonneg _) ha
end MD.Ch04Short
