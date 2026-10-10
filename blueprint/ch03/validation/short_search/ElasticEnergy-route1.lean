import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03ShortMore
set_option maxHeartbeats 400000
theorem elasticEnergy :
  ∀ (n : ℕ) (m : Fin n → ℝ) (u p : Position n), positiveMass m → u ≠ 0 →
    kinetic m (elasticReflection m u p)=kinetic m p ∧
      (∑ i, u i*elasticReflection m u p i/m i)=-(∑ i, u i*p i/m i) := by
  intro n m u p hm hu
  have hex : ∃ i, u i ≠ 0 := by
    by_contra! h
    apply hu
    ext i
    exact h i
  let S : ℝ := ∑ i, u i^2/m i
  let T : ℝ := ∑ i, u i*p i/m i
  have hS : 0 < S := by
    apply Finset.sum_pos'
    · intro i _; exact div_nonneg (sq_nonneg _) (le_of_lt (hm i))
    · obtain ⟨i, hi⟩ := hex
      exact ⟨i, Finset.mem_univ i, div_pos (sq_pos_of_ne_zero hi) (hm i)⟩
  let a := -2*T/S
  have hid : ∀ i, (p i+a*u i)^2/m i =
      p i^2/m i+2*a*(u i*p i/m i)+a^2*(u i^2/m i) := by
    intro i; ring
  have hnormal : ∀ i, u i*(p i+a*u i)/m i =
      u i*p i/m i+a*(u i^2/m i) := by
    intro i; ring
  constructor
  · change (∑ i, (p i+a*u i)^2/m i)/2 = (∑ i, p i^2/m i)/2
    simp_rw [hid, Finset.sum_add_distrib, ← Finset.mul_sum]
    change ((∑ i, p i^2/m i)+2*a*T+a^2*S)/2 = _
    dsimp [a]
    field_simp
    ring
  · change (∑ i, u i*(p i+a*u i)/m i) = -T
    simp_rw [hnormal, Finset.sum_add_distrib, ← Finset.mul_sum]
    change T+a*S = -T
    dsimp [a]
    field_simp
    ring
end MD.Ch03ShortMore
