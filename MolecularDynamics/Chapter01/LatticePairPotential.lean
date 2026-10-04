import MolecularDynamics.Chapter01.LinearizedHamiltonian

open Set Filter
open scoped BigOperators
namespace MolecularDynamics

/-! Uniform pair-potential energy for a finite one-dimensional lattice.

The upper-triangular sum represents each unordered pair once, matching the
uniform interaction formula on printed page 33/PDF56 of the textbook.
-/
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

theorem uniformPairPotentialEnergy_two (φ : ℝ → ℝ) (x : Fin 2 → ℝ) :
    uniformPairPotentialEnergy φ x = φ ‖x 0 - x 1‖ := by
  unfold uniformPairPotentialEnergy
  have h0 : Finset.Ioi (0 : Fin 2) = {1} := by decide
  have h1 : Finset.Ioi (1 : Fin 2) = ∅ := by decide
  rw [Fin.sum_univ_two, h0, h1]
  simp

/-! Nearest-neighbor chain energy on `N + 1` ordered lattice sites. -/
noncomputable def nearestNeighborPotentialEnergy {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin (N + 1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ ‖x i.succ - x i.castSucc‖

theorem nearestNeighborPotentialEnergy_translate {N : ℕ}
    (φ : ℝ → ℝ) (x : Fin (N + 1) → ℝ) (c : ℝ) :
    nearestNeighborPotentialEnergy φ (fun i => x i + c) =
      nearestNeighborPotentialEnergy φ x := by
  unfold nearestNeighborPotentialEnergy
  apply Finset.sum_congr rfl
  intro i hi
  congr 1
  congr 1
  ring

theorem nearestNeighborPotentialEnergy_two (φ : ℝ → ℝ) (x : Fin 2 → ℝ) :
    nearestNeighborPotentialEnergy φ x = φ ‖x 1 - x 0‖ := by
  unfold nearestNeighborPotentialEnergy
  rw [Fin.sum_univ_one]
  rfl

/-! Periodic nearest-neighbor energy on a cyclic lattice. -/
noncomputable def periodicNearestNeighborPotentialEnergy {N : ℕ} [NeZero N]
    (φ : ℝ → ℝ) (x : ZMod N → ℝ) : ℝ :=
  ∑ i : ZMod N, φ ‖x (i + 1) - x i‖

theorem periodicNearestNeighborPotentialEnergy_translate {N : ℕ} [NeZero N]
    (φ : ℝ → ℝ) (x : ZMod N → ℝ) (c : ℝ) :
    periodicNearestNeighborPotentialEnergy φ (fun i => x i + c) =
      periodicNearestNeighborPotentialEnergy φ x := by
  unfold periodicNearestNeighborPotentialEnergy
  apply Finset.sum_congr rfl
  intro i hi
  congr 1
  congr 1
  ring

end MolecularDynamics
