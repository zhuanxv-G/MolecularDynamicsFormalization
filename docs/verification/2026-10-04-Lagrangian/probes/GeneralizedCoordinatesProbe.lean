import MolecularDynamics.Chapter01.Lagrangian

open scoped InnerProductSpace
open Matrix

namespace MolecularDynamics

noncomputable def generalizedMassMatrix {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) : MassMatrix k :=
  J.transpose * diagonalMassMatrix m * J

theorem massLagrangian_coordinateChange {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (Q : Position k) (V : Velocity k) :
    massLagrangian m U (Φ Q) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ Q) := by
  unfold massLagrangian
  rw [nBodyKineticEnergy_eq_inner]
  have hinner : inner ℝ (J.toEuclideanLin V) (massOperator m (J.toEuclideanLin V)) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) := by
    rw [EuclideanSpace.inner_eq_star_dotProduct, EuclideanSpace.inner_eq_star_dotProduct]
    simp only [star_trivial]
    change (diagonalMassMatrix m *ᵥ (J *ᵥ V)) ⬝ᵥ (J *ᵥ V) =
      ((J.transpose * diagonalMassMatrix m * J) *ᵥ V) ⬝ᵥ V
    rw [dotProduct_comm ((J.transpose * diagonalMassMatrix m * J) *ᵥ V) V]
    rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
      Matrix.dotProduct_transpose_mulVec]
  rw [hinner]

theorem hasDerivAt_coordinateChange {n k : ℕ}
    (Φ : Position k → Position n) (J : Matrix (Fin n) (Fin k) ℝ)
    (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t :=
  hΦ.comp_hasDerivAt t hq

theorem generalizedMassMatrix_posDef {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec) : (generalizedMassMatrix m J).PosDef := by
  have h := ((diagonalMassMatrix_posDef_iff m).mpr hm).conjTranspose_mul_mul_same hJ
  simpa only [generalizedMassMatrix, Matrix.conjTranspose_eq_transpose_of_trivial] using h

theorem generalizedMassMatrix_isUnit {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec) : IsUnit (generalizedMassMatrix m J) :=
  (generalizedMassMatrix_posDef m J hm hJ).isUnit

#print axioms massLagrangian_coordinateChange
#print axioms hasDerivAt_coordinateChange
#print axioms generalizedMassMatrix_posDef
#print axioms generalizedMassMatrix_isUnit

end MolecularDynamics
