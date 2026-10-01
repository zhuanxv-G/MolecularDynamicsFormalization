import MolecularDynamics.Chapter01.NBody

/-!
# Particle and coordinate representations

Leimkuhler--Matthews, Section 1.2, printed page 18 (PDF page 41).
For `N` particles in `d` spatial dimensions there are `N * d` configuration
coordinates. Independent constraints may reduce the degrees of freedom but
do not change this ambient coordinate indexing.

The coordinate equivalence lists all directions of each particle together;
in three dimensions each particle mass is repeated three times. The kinetic
energy identity holds for arbitrary real masses. Positive masses are explicit
hypotheses for the positive-definiteness and inverse-matrix results.
-/

namespace MolecularDynamics

/-- Scalar particle masses, before repeating them across spatial directions. -/
abbrev ParticleMasses (N : ℕ) := Fin N → ℝ
/-- A Euclidean vector for each particle; the outer function norm is not used. -/
abbrev ParticleVectors (N d : ℕ) := Fin N → EuclideanSpace ℝ (Fin d)

/-- Particle-first ordering: the coordinate of `(i, a)` is `a.val + d * i.val`. -/
def particleCoordinateEquiv (N d : ℕ) : Fin N × Fin d ≃ Fin (N * d) :=
  finProdFinEquiv

def coordinateMassesOfParticles {N d : ℕ} (m : ParticleMasses N) :
    CoordinateMasses (N * d) :=
  fun k => m ((particleCoordinateEquiv N d).symm k).1

def flattenParticleVectors {N d : ℕ} (v : ParticleVectors N d) : Velocity (N * d) :=
  WithLp.toLp 2 (fun k =>
    v ((particleCoordinateEquiv N d).symm k).1
      ((particleCoordinateEquiv N d).symm k).2)

def unflattenParticleVectors {N d : ℕ} (w : Velocity (N * d)) : ParticleVectors N d :=
  fun i => WithLp.toLp 2 (fun a => w (particleCoordinateEquiv N d (i, a)))

noncomputable def particleKineticEnergy {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) : ℝ :=
  ∑ i, m i * ‖v i‖ ^ 2 / 2

@[simp] theorem flattenParticleVectors_apply {N d : ℕ} (v : ParticleVectors N d)
    (i : Fin N) (a : Fin d) :
    flattenParticleVectors v (particleCoordinateEquiv N d (i, a)) = v i a := by
  simp [flattenParticleVectors]

@[simp] theorem unflatten_flatten {N d : ℕ} (v : ParticleVectors N d) :
    unflattenParticleVectors (flattenParticleVectors v) = v := by
  funext i
  ext a
  simp [unflattenParticleVectors]

@[simp] theorem flatten_unflatten {N d : ℕ} (w : Velocity (N * d)) :
    flattenParticleVectors (unflattenParticleVectors w) = w := by
  ext k
  simp [flattenParticleVectors, unflattenParticleVectors]

@[simp] theorem coordinateMassesOfParticles_apply {N d : ℕ} (m : ParticleMasses N)
    (i : Fin N) (a : Fin d) :
    coordinateMassesOfParticles m (particleCoordinateEquiv N d (i, a)) = m i := by
  simp [coordinateMassesOfParticles]

theorem coordinateMassesOfParticles_pos {N d : ℕ} (m : ParticleMasses N)
    (hm : ∀ i, 0 < m i) : ∀ k, 0 < coordinateMassesOfParticles (d := d) m k := by
  intro k
  exact hm ((particleCoordinateEquiv N d).symm k).1

/-- Recovering each particle mass from its coordinates requires a direction. -/
theorem coordinateMassesOfParticles_pos_iff {N d : ℕ} (m : ParticleMasses N)
    (hd : 0 < d) :
    (∀ k, 0 < coordinateMassesOfParticles (d := d) m k) ↔ (∀ i, 0 < m i) := by
  constructor
  · intro h i
    simpa using h (particleCoordinateEquiv N d (i, (⟨0, hd⟩ : Fin d)))
  · exact coordinateMassesOfParticles_pos m

/-- The scalar-coordinate kinetic term equals the particle expression in (1.4).
No positivity hypothesis is needed for this algebraic identity. -/
theorem nBodyKineticEnergy_particle_eq {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) :
    nBodyKineticEnergy (coordinateMassesOfParticles (d := d) m)
      (flattenParticleVectors v) = particleKineticEnergy m v := by
  unfold nBodyKineticEnergy
  rw [← (particleCoordinateEquiv N d).sum_comp]
  rw [Fintype.sum_prod_type]
  simp only [coordinateMassesOfParticles_apply, flattenParticleVectors_apply]
  unfold particleKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [EuclideanSpace.real_norm_sq_eq]
  rw [Finset.mul_sum, Finset.sum_div]

theorem diagonalMassMatrix_posDef_iff {n : ℕ} (m : CoordinateMasses n) :
    (diagonalMassMatrix m).PosDef ↔ ∀ i, 0 < m i := by
  exact Matrix.posDef_diagonal_iff

theorem diagonalMassMatrix_isUnit {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) : IsUnit (diagonalMassMatrix m) :=
  ((diagonalMassMatrix_posDef_iff m).2 hm).isUnit

theorem diagonalMassMatrix_mul_inv {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    diagonalMassMatrix m * (diagonalMassMatrix m)⁻¹ = 1 := by
  exact Matrix.mul_nonsing_inv _ ((Matrix.isUnit_iff_isUnit_det _).1
    (diagonalMassMatrix_isUnit m hm))

theorem diagonalMassMatrix_inv_mul {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    (diagonalMassMatrix m)⁻¹ * diagonalMassMatrix m = 1 := by
  exact Matrix.nonsing_inv_mul _ ((Matrix.isUnit_iff_isUnit_det _).1
    (diagonalMassMatrix_isUnit m hm))

/-- Strictly positive diagonal masses have the coordinatewise reciprocal inverse.
The singular-matrix inverse convention does not justify this without hypotheses. -/
theorem diagonalMassMatrix_inv_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) :
    (diagonalMassMatrix m)⁻¹ = Matrix.diagonal (fun i => (m i)⁻¹) := by
  apply Matrix.inv_eq_left_inv
  change Matrix.diagonal (fun i => (m i)⁻¹) * Matrix.diagonal m = 1
  rw [Matrix.diagonal_mul_diagonal]
  ext i j
  by_cases hij : i = j
  · subst j
    simp [ne_of_gt (hm i)]
  · simp [Matrix.diagonal, hij]

theorem diagonalMassMatrix_inv_mulVec {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (w : Velocity n) (i : Fin n) :
    ((diagonalMassMatrix m)⁻¹).mulVec ((diagonalMassMatrix m).mulVec w) i = w i := by
  rw [Matrix.mulVec_mulVec, diagonalMassMatrix_inv_mul m hm, Matrix.one_mulVec]

end MolecularDynamics
