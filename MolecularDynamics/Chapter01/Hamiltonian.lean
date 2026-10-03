import MolecularDynamics.Chapter01.LocalTrajectories

/-!
# Fixed diagonal mass Hamiltonian

Printed pages 18--19 and 24--25, PDF pages 41--42 and 47--48.
Mass operators are reused from the shared T2 LocalTrajectories module.
Positive masses interpret the coordinate formula as the inverse-matrix
Hamiltonian. Real derivative statements are separate from total-gradient
identities. This module proves static energy and vector-field identities.
-/

open MolecularDynamics
open scoped InnerProductSpace

set_option synthInstance.maxHeartbeats 2000

namespace MolecularDynamics

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

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

@[simp] theorem massOperator_coordinate {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) (i : Fin n) : massOperator m v i = m i * v i := by
  change (Matrix.diagonal m).mulVec v i = _
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal]

@[simp] theorem coordinateVelocity_apply {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) : coordinateVelocity m p i = p i / m i := rfl

theorem velocityOperator_coordinate {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) (i : Fin n) :
    velocityOperator m p i = p i / m i := by
  change ((diagonalMassMatrix m)⁻¹).mulVec p i = _
  rw [diagonalMassMatrix_inv_eq m hm]
  simp [Matrix.mulVec, dotProduct, Matrix.diagonal, div_eq_mul_inv, mul_comm]

theorem coordinateVelocity_eq_velocityOperator {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    coordinateVelocity m p = velocityOperator m p := by
  ext i
  rw [coordinateVelocity_apply, velocityOperator_coordinate m hm]

/-- T3-K1: the matrix expression uses the whole inverse and positive masses. -/
theorem momentumKineticEnergy_eq_inner {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (p : Momentum n) :
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2 := by
  rw [EuclideanSpace.inner_eq_star_dotProduct]
  simp only [star_trivial, dotProduct, Finset.sum_div]
  unfold momentumKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [velocityOperator_coordinate m hm]
  ring

/-- T3-E1: total coordinate division makes the algebra valid for all real masses. -/
theorem momentumKineticEnergy_massOperator {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) : momentumKineticEnergy m (massOperator m v) =
    nBodyKineticEnergy m v := by
  unfold momentumKineticEnergy nBodyKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  rw [massOperator_coordinate]
  by_cases h : m i = 0
  · simp [h]
  · field_simp

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

theorem coordinateDualRepresentation {n : ℕ} (g : Momentum n) :
    (∑ i : Fin n, g i • EuclideanSpace.proj (𝕜 := ℝ) i) =
      InnerProductSpace.toDual ℝ (Momentum n) g := by
  ext w
  simp [InnerProductSpace.toDual_apply_apply, EuclideanSpace.inner_eq_star_dotProduct,
    dotProduct, mul_comm]

/-- Each term is a fixed coefficient polynomial, including the mass-zero convention. -/
theorem hasFDerivAt_kinetic_term {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) :
    HasFDerivAt (fun x : Momentum n => (x i)^2 / (2 * m i))
      ((p i / m i) • EuclideanSpace.proj (𝕜 := ℝ) i) p := by
  have hi : HasFDerivAt (fun x : Momentum n => x i)
      (EuclideanSpace.proj (𝕜 := ℝ) i) p :=
    (EuclideanSpace.proj (𝕜 := ℝ) i).hasFDerivAt
  have hcoeff : (2 * m i)⁻¹ * (p i + p i) = p i / m i := by
    by_cases h : m i = 0
    · simp [h]
    · field_simp; ring
  convert (hi.mul hi).mul_const ((2 * m i)⁻¹) using 1
  · ext x
    simp only [div_eq_mul_inv, pow_two, Pi.mul_apply]
  · ext x
    simp only [smul_apply, add_apply,
      smul_eq_mul, EuclideanSpace.coe_proj]
    rw [← hcoeff]
    ring

/-- T3-G1: a genuine Frechet derivative identifies the coordinate gradient. -/
theorem hasGradientAt_momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) :
    HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p := by
  rw [hasGradientAt_iff_hasFDerivAt]
  have hsum : HasFDerivAt (momentumKineticEnergy m)
      (∑ i : Fin n, (p i / m i) • EuclideanSpace.proj (𝕜 := ℝ) i) p :=
    HasFDerivAt.fun_sum (fun i _ => hasFDerivAt_kinetic_term m p i)
  have hdual := coordinateDualRepresentation (coordinateVelocity m p)
  simp only [coordinateVelocity_apply] at hdual
  rw [hdual] at hsum
  exact hsum

theorem gradient_momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : gradient (momentumKineticEnergy m) p = coordinateVelocity m p :=
  (hasGradientAt_momentumKineticEnergy m p).gradient

theorem gradient_momentumKineticEnergy_eq_velocityOperator {n : ℕ}
    (m : CoordinateMasses n) (hm : ∀ i, 0 < m i) (p : Momentum n) :
    gradient (momentumKineticEnergy m) p = velocityOperator m p := by
  rw [gradient_momentumKineticEnergy, coordinateVelocity_eq_velocityOperator m hm]

/-- T3-G2: this total-operation identity does not assert that U is differentiable. -/
theorem gradient_position_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    gradient (fun x => massHamiltonian m U (x,p)) q = gradient U q := by
  simp only [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    gradient, fderiv_const_add]

theorem gradient_momentum_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    gradient (fun x => massHamiltonian m U (q,x)) p =
      gradient (momentumKineticEnergy m) p := by
  simp only [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    gradient, fderiv_add_const]

/-- A differentiability premise supplies the classical position partial derivative. -/
theorem hasGradientAt_position_slice {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun x => massHamiltonian m U (x,p)) (gradient U q) q := by
  rw [hasGradientAt_iff_hasFDerivAt]
  exact hU.hasGradientAt.hasFDerivAt.const_add (momentumKineticEnergy m p)

/-- T3-V1 is a static field identity, not a theorem about time trajectories. -/
theorem hamiltonianVectorField_eq {n : ℕ} (m : CoordinateMasses n)
    (hm : ∀ i, 0 < m i) (U : PotentialEnergy n) (z : PhaseSpace n) :
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1) := by
  unfold hamiltonianVectorField
  rw [gradient_position_slice, gradient_momentum_slice,
    gradient_momentumKineticEnergy_eq_velocityOperator m hm]


end MolecularDynamics
