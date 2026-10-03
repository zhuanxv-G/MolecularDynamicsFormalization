import MolecularDynamics.Notation
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Tactic.Linarith

/-!
# Euclidean distance on phase pairs

The library's ordinary product metric is the maximum of component distances.
The textbook's Euclidean phase distance is the square root of the sum of their
squares. Both comparison constants below are uniform in the dimension.
-/

namespace MolecularDynamics

/-- Euclidean distance between a position-momentum pair and another pair. -/
noncomputable def phaseEuclideanDistance {n : ℕ} (z w : PhaseSpace n) : ℝ :=
  Real.sqrt (dist z.1 w.1 ^ 2 + dist z.2 w.2 ^ 2)

theorem product_dist_le_phaseEuclideanDistance {n : ℕ} (z w : PhaseSpace n) :
    dist z w ≤ phaseEuclideanDistance z w := by
  rw [Prod.dist_eq]
  apply max_le
  · exact Real.le_sqrt_of_sq_le (le_add_of_nonneg_right (sq_nonneg _))
  · exact Real.le_sqrt_of_sq_le (le_add_of_nonneg_left (sq_nonneg _))

theorem phaseEuclideanDistance_le_two_mul_dist {n : ℕ} (z w : PhaseSpace n) :
    phaseEuclideanDistance z w ≤ 2 * dist z w := by
  apply Real.sqrt_le_iff.mpr
  refine ⟨by positivity, ?_⟩
  have hfst : dist z.1 w.1 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_left _ _
  have hsnd : dist z.2 w.2 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_right _ _
  have hfstSq : dist z.1 w.1 ^ 2 ≤ dist z w ^ 2 :=
    (sq_le_sq₀ dist_nonneg dist_nonneg).mpr hfst
  have hsndSq : dist z.2 w.2 ^ 2 ≤ dist z w ^ 2 :=
    (sq_le_sq₀ dist_nonneg dist_nonneg).mpr hsnd
  nlinarith [sq_nonneg (dist z w)]

end MolecularDynamics
