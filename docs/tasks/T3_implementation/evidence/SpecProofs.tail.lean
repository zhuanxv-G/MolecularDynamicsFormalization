namespace T3Implementation

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

end T3Implementation
