namespace T3BoundaryVerification

open T3Implementation

def mixedMass : CoordinateMasses 2 := ![0, 2]
def mixedMomentum : Momentum 2 := WithLp.toLp 2 ![0, 4]

theorem mixedMass_inv_zero : (diagonalMassMatrix mixedMass)⁻¹ = 0 := by
  apply Matrix.nonsing_inv_apply_not_isUnit
  simp [diagonalMassMatrix, Matrix.det_diagonal, mixedMass, Fin.prod_univ_two]

theorem mixed_coordinate_kinetic : momentumKineticEnergy mixedMass mixedMomentum = 4 := by
  norm_num [momentumKineticEnergy, mixedMass, mixedMomentum, Fin.sum_univ_two]

theorem mixed_matrix_kinetic : inner ℝ mixedMomentum (velocityOperator mixedMass mixedMomentum) / 2 = 0 := by
  have hz : velocityOperator mixedMass mixedMomentum = 0 := by
    ext i
    change ((diagonalMassMatrix mixedMass)⁻¹).mulVec mixedMomentum i = 0
    rw [mixedMass_inv_zero]
    simp
  rw [hz]
  simp

theorem empty_kinetic (m : CoordinateMasses 0) (p : Momentum 0) :
    momentumKineticEnergy m p = 0 := by
  unfold momentumKineticEnergy
  exact Finset.sum_empty

theorem empty_hamiltonian (m : CoordinateMasses 0) (U : PotentialEnergy 0)
    (q : Position 0) (p : Momentum 0) : massHamiltonian m U (q,p) = U q := by
  change momentumKineticEnergy m p + U q = U q
  rw [empty_kinetic, zero_add]

def oneMass : CoordinateMasses 1 := fun _ => 2
def oneVelocity : Velocity 1 := WithLp.toLp 2 (fun _ => 3)

theorem scalar_example : massHamiltonian oneMass (fun _ => 7)
    (0, massOperator oneMass oneVelocity) = 16 := by
  rw [massHamiltonian_massOperator]
  norm_num [nBodyTotalEnergy, nBodyKineticEnergy, oneMass, oneVelocity, Fin.sum_univ_one]

theorem negative_mass_example :
    momentumKineticEnergy (fun _ : Fin 1 => -1) (WithLp.toLp 2 (fun _ => 2)) = -2 := by
  norm_num [momentumKineticEnergy, Fin.sum_univ_one]

#print axioms mixedMass_inv_zero
#print axioms mixed_coordinate_kinetic
#print axioms mixed_matrix_kinetic
#print axioms empty_kinetic
#print axioms empty_hamiltonian
#print axioms scalar_example
#print axioms negative_mass_example

end T3BoundaryVerification
