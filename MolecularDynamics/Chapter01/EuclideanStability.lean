import MolecularDynamics.Chapter01.Stability
import MolecularDynamics.Chapter01.PhaseMetric

/-!
# Theorem 1.1 in the Euclidean phase distance

Leimkuhler--Matthews, printed page 32 / PDF page 55. Future existence and
bounds for every same-initial-state future solution are both explicit. Every
real supremum is guarded by boundedness of its distance range.
-/

open Set
open scoped ContDiff

namespace MolecularDynamics

/-- Future mechanical stability using the Euclidean phase distance. -/
def IsFutureMechanicalStableEuclidean {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (zstar : PhaseSpace n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ z₀ : PhaseSpace n, phaseEuclideanDistance z₀ zstar < δ →
    (∃ a < (0 : ℝ), ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ 0 = z₀) ∧
    ∀ a < (0 : ℝ), ∀ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ → γ 0 = z₀ →
      BddAbove (range (fun t : Ici (0 : ℝ) => phaseEuclideanDistance (γ t) zstar)) ∧
      sSup (range (fun t : Ici (0 : ℝ) => phaseEuclideanDistance (γ t) zstar)) < ε

/-- Product-metric stability transfers with a uniform strict margin. -/
theorem IsFutureMechanicalStable.euclidean {n : ℕ}
    {m : CoordinateMasses n} {F : Force n} {Q : Set (Position n)} {zstar : PhaseSpace n}
    (hstable : IsFutureMechanicalStable m F Q zstar) :
    IsFutureMechanicalStableEuclidean m F Q zstar := by
  intro ε hε
  obtain ⟨δ, hδ, hbound⟩ := hstable (ε / 2) (by linarith)
  refine ⟨δ, hδ, ?_⟩
  intro z₀ hz₀
  obtain ⟨hexists, hforall⟩ := hbound z₀
    (lt_of_le_of_lt (product_dist_le_phaseEuclideanDistance z₀ zstar) hz₀)
  refine ⟨hexists, ?_⟩
  intro a ha γ hγ hinit
  obtain ⟨hbounded, hsup⟩ := hforall a ha γ hγ hinit
  let D := range (fun t : Ici (0 : ℝ) => dist (γ t) zstar)
  have hpoint : ∀ t : Ici (0 : ℝ), phaseEuclideanDistance (γ t) zstar ≤ 2 * sSup D := by
    intro t
    exact (phaseEuclideanDistance_le_two_mul_dist (γ t) zstar).trans
      (mul_le_mul_of_nonneg_left (le_csSup hbounded (mem_range_self t)) (by norm_num))
  have hsupE : sSup (range (fun t : Ici (0 : ℝ) =>
      phaseEuclideanDistance (γ t) zstar)) ≤ 2 * sSup D := by
    apply csSup_le (range_nonempty _)
    rintro d ⟨t, rfl⟩
    exact hpoint t
  have hmargin : 2 * sSup D < ε := by dsimp only [D]; linarith [hsup]
  refine ⟨⟨2 * sSup D, ?_⟩, hsupE.trans_lt hmargin⟩
  rintro d ⟨t, rfl⟩
  exact hpoint t

/-- Local C2 potential regularity suffices for the Euclidean stability result. -/
theorem strictPotentialMin_futureStableEuclidean_of_potential_contDiffAt_two {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ 2 U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n)) := by
  obtain ⟨heq, hstable⟩ :=
    strictPotentialMin_futureStable_of_potential_contDiffAt_two m U Q q₀ hm hQ hU hstrict
  exact ⟨heq, hstable.euclidean⟩

/-- Textbook Theorem 1.1 for the fixed positive diagonal mass model. -/
theorem strictPotentialMin_futureStableEuclidean_of_smooth {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n)) := by
  exact strictPotentialMin_futureStableEuclidean_of_potential_contDiffAt_two
    m U Q q₀ hm hQ (fun q hq => (hU q hq).of_le (by simp)) hstrict


end MolecularDynamics

