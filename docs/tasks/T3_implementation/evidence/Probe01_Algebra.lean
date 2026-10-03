import MolecularDynamics.Chapter01.ParticleCoordinates

/-!
Complete isolated T3 draft for the fixed diagonal mass Hamiltonian.
Printed pages 18--19 and 24--25, PDF pages 41--42 and 47--48.
This module does not change the formal library. Operator definitions match
T2-L0 and will be replaced by shared names on coordinated integration.
-/

open MolecularDynamics
open scoped InnerProductSpace

set_option synthInstance.maxHeartbeats 2000

namespace T3Implementation

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def massOperator {n : ℕ} (m : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)).toContinuousLinearMap

noncomputable def velocityOperator {n : ℕ} (m : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)⁻¹).toContinuousLinearMap

noncomputable def coordinateVelocity {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : Velocity n := WithLp.toLp 2 (fun i => p i / m i)

noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)

noncomputable def massSeparableEnergy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : SeparableEnergy n := ⟨momentumKineticEnergy m, U⟩

noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian

noncomputable def hamiltonianVectorField {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) : PhaseSpace n :=
  (gradient (fun p => massHamiltonian m U (z.1, p)) z.2,
    -gradient (fun q => massHamiltonian m U (q, z.2)) z.1)

@[simp] theorem massOperator_apply {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) (i : Fin n) : massOperator m v i = m i * v i := by
  change (Matrix.diagonal m).mulVec v i = _
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal]

@[simp] theorem coordinateVelocity_apply {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) : coordinateVelocity m p i = p i / m i := rfl

theorem velocityOperator_apply {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) (i : Fin n) :
    velocityOperator m p i = p i / m i := by
  change ((diagonalMassMatrix m)⁻¹).mulVec p i = _
  rw [diagonalMassMatrix_inv_eq m hm]
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal, div_eq_mul_inv, mul_comm]

theorem coordinateVelocity_eq_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    coordinateVelocity m p = velocityOperator m p := by
  ext i
  rw [coordinateVelocity_apply, velocityOperator_apply m hm]

theorem massOperator_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    massOperator m (velocityOperator m p) = p := by
  ext i
  rw [massOperator_apply, velocityOperator_apply m hm]
  field_simp

/-- T3-K1: the matrix expression uses the whole inverse and positive masses. -/
theorem momentumKineticEnergy_eq_inner {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2 := by
  rw [EuclideanSpace.inner_eq_star_dotProduct]
  simp only [star_trivial, dotProduct, Finset.sum_div]
  unfold momentumKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [velocityOperator_apply m hm]
  ring

/-- T3-E1: total coordinate division makes the algebra valid for all real masses. -/
theorem momentumKineticEnergy_massOperator {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) : momentumKineticEnergy m (massOperator m v) =
    nBodyKineticEnergy m v := by
  unfold momentumKineticEnergy nBodyKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [massOperator_apply]
  by_cases h : m i = 0
  · simp [h]
  · field_simp
    <;> ring

theorem massHamiltonian_massOperator {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    massHamiltonian m U (q, massOperator m v) = nBodyTotalEnergy m U q v := by
  change momentumKineticEnergy m (massOperator m v) + U q = _
  rw [momentumKineticEnergy_massOperator]
  rfl

/-- T3-P1: particle energy is the coordinate model under the established flattening. -/
theorem massHamiltonian_particle {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) :
    massHamiltonian (coordinateMassesOfParticles (d := d) m) U
      (flattenParticleVectors q,
        massOperator (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q) := by
  rw [massHamiltonian_massOperator]
  unfold nBodyTotalEnergy
  rw [nBodyKineticEnergy_particle_eq]

/-- T3-R1: recover the velocity energy for an arbitrary momentum. -/
theorem massHamiltonian_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    massHamiltonian m U (q,p) = nBodyTotalEnergy m U q (velocityOperator m p) := by
  have h := massHamiltonian_massOperator m U q (velocityOperator m p)
  rw [massOperator_velocityOperator m hm] at h
  exact h

#print axioms momentumKineticEnergy_eq_inner
#print axioms massHamiltonian_massOperator
#print axioms massHamiltonian_particle
#print axioms massHamiltonian_velocityOperator

end T3Implementation
