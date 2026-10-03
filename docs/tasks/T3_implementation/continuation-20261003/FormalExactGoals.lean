import MolecularDynamics.Chapter01.Hamiltonian

open scoped InnerProductSpace


namespace MolecularDynamics

-- Proposition-valued descriptions only: no proof placeholders or target
-- conclusions disguised as premises.
def matrixKineticGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) →
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2

def velocityEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : Prop :=
  massHamiltonian m U (q, massOperator m v) = nBodyTotalEnergy m U q v

def particleEnergyGoal {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) : Prop :=
  massHamiltonian (coordinateMassesOfParticles (d := d) m) U
      (flattenParticleVectors q,
        massOperator (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q)

def coordinateGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p

def matrixGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) → gradient (momentumKineticEnergy m) p = velocityOperator m p

def positionGradientGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  DifferentiableAt ℝ U q →
    HasGradientAt (fun x => massHamiltonian m U (x, p)) (gradient U q) q

def positionTotalGradientGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  gradient (fun x => massHamiltonian m U (x, p)) q = gradient U q

def vectorFieldGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z : PhaseSpace n) : Prop :=
  (∀ i, 0 < m i) →
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1)

def inverseEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) →
    massHamiltonian m U (q, p) = nBodyTotalEnergy m U q (velocityOperator m p)

#print matrixKineticGoal
#print velocityEnergyGoal
#print particleEnergyGoal
#print coordinateGradientGoal
#print matrixGradientGoal
#print positionGradientGoal
#print positionTotalGradientGoal
#print vectorFieldGoal
#print inverseEnergyGoal

end MolecularDynamics

namespace MolecularDynamics

theorem prove_matrixKineticGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) :
    matrixKineticGoal m p := fun hm => momentumKineticEnergy_eq_inner m hm p

theorem prove_velocityEnergyGoal {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    velocityEnergyGoal m U q v := massHamiltonian_massOperator m U q v

theorem prove_particleEnergyGoal {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) :
    particleEnergyGoal m U q v := massHamiltonian_particle m U q v

theorem prove_coordinateGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) :
    coordinateGradientGoal m p := hasGradientAt_momentumKineticEnergy m p

theorem prove_matrixGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) :
    matrixGradientGoal m p :=
  fun hm => gradient_momentumKineticEnergy_eq_velocityOperator m hm p

theorem prove_positionGradientGoal {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    positionGradientGoal m U q p := fun hU => hasGradientAt_position_slice m U q p hU

theorem prove_positionTotalGradientGoal {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (p : Momentum n) :
    positionTotalGradientGoal m U q p := gradient_position_slice m U q p

theorem prove_vectorFieldGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z : PhaseSpace n) : vectorFieldGoal m U z := fun hm => hamiltonianVectorField_eq m hm U z

theorem prove_inverseEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : inverseEnergyGoal m U q p :=
  fun hm => massHamiltonian_velocityOperator m hm U q p

#print axioms prove_matrixKineticGoal
#print axioms prove_velocityEnergyGoal
#print axioms prove_particleEnergyGoal
#print axioms prove_coordinateGradientGoal
#print axioms prove_matrixGradientGoal
#print axioms prove_positionGradientGoal
#print axioms prove_positionTotalGradientGoal
#print axioms prove_vectorFieldGoal
#print axioms prove_inverseEnergyGoal

end MolecularDynamics
