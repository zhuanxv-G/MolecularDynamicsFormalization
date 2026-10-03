import MolecularDynamics.Chapter01.Lagrangian

/-!
# The fixed-mass Legendre supremum

Leimkuhler--Matthews Section 1.4, printed page 24 / PDF page 47.
Completing the square proves the upper bound, unique maximizing velocity
and actual supremum. Positive masses supply positive definiteness; mere
invertibility is insufficient for the textbook's maximum assertion.
-/

open Set
open scoped InnerProductSpace

namespace MolecularDynamics

theorem massHamiltonian_legendre_gap {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) (v : Velocity n)
    (hm : ∀ i, 0 < m i) :
    massHamiltonian m U (q, p) - (inner ℝ p v - massLagrangian m U q v) =
      nBodyKineticEnergy m (v - velocityOperator m p) := by
  change momentumKineticEnergy m p + U q -
    (inner ℝ p v - (nBodyKineticEnergy m v - U q)) = _
  rw [real_inner_comm, EuclideanSpace.inner_eq_star_dotProduct]
  simp only [star_trivial, dotProduct]
  unfold momentumKineticEnergy nBodyKineticEnergy
  have hsum : (∑ i, (p i ^ 2 / (2 * m i) - p i * v i + m i * v i ^ 2 / 2)) =
      ∑ i, m i * ((v - velocityOperator m p) i) ^ 2 / 2 := by
    apply Finset.sum_congr rfl
    intro i _
    rw [PiLp.sub_apply, velocityOperator_coordinate m hm]
    field_simp [ne_of_gt (hm i)]
    ring
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib] at hsum
  linarith [hsum]

theorem legendre_objective_le_massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) (v : Velocity n)
    (hm : ∀ i, 0 < m i) :
    inner ℝ p v - massLagrangian m U q v ≤ massHamiltonian m U (q, p) := by
  have hgap := massHamiltonian_legendre_gap m U q p v hm
  have hnonneg := nBodyKineticEnergy_nonneg m (v - velocityOperator m p) (fun i => (hm i).le)
  linarith

theorem legendre_objective_attains_massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n)
    (hm : ∀ i, 0 < m i) :
    inner ℝ p (velocityOperator m p) - massLagrangian m U q (velocityOperator m p) =
      massHamiltonian m U (q, p) := by
  have hgap := massHamiltonian_legendre_gap m U q p (velocityOperator m p) hm
  simp only [sub_self, nBodyKineticEnergy, PiLp.zero_apply, zero_pow (by norm_num : (2 : ℕ) ≠ 0),
    mul_zero, zero_div, Finset.sum_const_zero] at hgap
  linarith

theorem nBodyKineticEnergy_eq_zero_iff {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) (hm : ∀ i, 0 < m i) : nBodyKineticEnergy m v = 0 ↔ v = 0 := by
  constructor
  · intro hz
    have hn : ∀ i ∈ (Finset.univ : Finset (Fin n)), 0 ≤ m i * (v i) ^ 2 / 2 := by
      intro i _
      exact div_nonneg (mul_nonneg (hm i).le (sq_nonneg _)) (by norm_num)
    have hterms := (Finset.sum_eq_zero_iff_of_nonneg hn).mp hz
    ext i
    have hi := hterms i (Finset.mem_univ i)
    have hmul : m i * (v i) ^ 2 = 0 := by linarith [hi]
    have hsq : (v i) ^ 2 = 0 := (mul_eq_zero.mp hmul).resolve_left (ne_of_gt (hm i))
    exact sq_eq_zero_iff.mp hsq
  · intro hz
    simp [hz, nBodyKineticEnergy]

theorem legendre_objective_eq_massHamiltonian_iff {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) (v : Velocity n)
    (hm : ∀ i, 0 < m i) :
    inner ℝ p v - massLagrangian m U q v = massHamiltonian m U (q, p) ↔
      v = velocityOperator m p := by
  constructor
  · intro heq
    have hgap := massHamiltonian_legendre_gap m U q p v hm
    have hz : nBodyKineticEnergy m (v - velocityOperator m p) = 0 := by
      rw [heq, sub_self] at hgap
      exact hgap.symm
    exact sub_eq_zero.mp ((nBodyKineticEnergy_eq_zero_iff m _ hm).mp hz)
  · intro heq
    rw [heq]
    exact legendre_objective_attains_massHamiltonian m U q p hm

/-- The Legendre objective is bounded above and its real supremum is H. -/
theorem massHamiltonian_eq_legendre_sup {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n)
    (hm : ∀ i, 0 < m i) :
    BddAbove (range (fun v : Velocity n => inner ℝ p v - massLagrangian m U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - massLagrangian m U q v)) =
      massHamiltonian m U (q, p) := by
  have hbound : ∀ v, inner ℝ p v - massLagrangian m U q v ≤ massHamiltonian m U (q, p) :=
    fun v => legendre_objective_le_massHamiltonian m U q p v hm
  have hbdd : BddAbove (range (fun v : Velocity n => inner ℝ p v - massLagrangian m U q v)) := by
    refine ⟨massHamiltonian m U (q, p), ?_⟩
    rintro d ⟨v, rfl⟩
    exact hbound v
  refine ⟨hbdd, le_antisymm ?_ ?_⟩
  · apply csSup_le (range_nonempty _)
    rintro d ⟨v, rfl⟩
    exact hbound v
  · apply le_csSup hbdd
    exact ⟨velocityOperator m p, legendre_objective_attains_massHamiltonian m U q p hm⟩


end MolecularDynamics
