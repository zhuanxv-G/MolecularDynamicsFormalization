import MolecularDynamics.Chapter01.LinearizedHamiltonian

open Set Filter
open scoped BigOperators
namespace MolecularDynamics

/-- Uniform one-dimensional pair-potential energy from the upper-triangular pair sum
shown on printed page 33/PDF56. -/
noncomputable def uniformPairPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i : Fin N, Finset.sum (Finset.Ioi i) (fun j => φ ‖x i - x j‖)

theorem uniformPairPotentialEnergy_translate {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin N → ℝ) (c : ℝ) :
    uniformPairPotentialEnergy φ (fun i => x i + c) =
      uniformPairPotentialEnergy φ x := by
  unfold uniformPairPotentialEnergy
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  congr 1
  congr 1
  ring

/-- For two atoms the upper-triangular pair sum is exactly one pair term. -/
theorem uniformPairPotentialEnergy_two (φ : ℝ → ℝ) (x : Fin 2 → ℝ) :
    uniformPairPotentialEnergy φ x = φ ‖x 0 - x 1‖ := by
  unfold uniformPairPotentialEnergy
  have h0 : Finset.Ioi (0 : Fin 2) = {1} := by decide
  have h1 : Finset.Ioi (1 : Fin 2) = ∅ := by decide
  rw [Fin.sum_univ_two, h0, h1]
  simp

end MolecularDynamics
#print axioms MolecularDynamics.uniformPairPotentialEnergy
#print axioms MolecularDynamics.uniformPairPotentialEnergy_translate
#print axioms MolecularDynamics.uniformPairPotentialEnergy_two
