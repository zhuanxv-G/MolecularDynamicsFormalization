import MolecularDynamics.Chapter01.MatrixFlow

/-! Printed27/PDF50: real recovery of complex spectral solutions and
basis-column coordinate algebra. All identities use actual linear maps. -/

namespace MolecularDynamics
noncomputable def basisColumnMatrix {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m))) :
    Matrix (Fin m) (Fin m) 𝕜 := fun i j => b j i

theorem basisColumnMatrix_mulVec {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m))) (c : Fin m → 𝕜) :
    (basisColumnMatrix b).mulVec c = WithLp.ofLp (∑ j, c j • b j) := by
  ext i
  simp [basisColumnMatrix, Matrix.mulVec, dotProduct,
    mul_comm]

theorem basisColumnMatrix_mulVec_repr {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z := by
  rw [basisColumnMatrix_mulVec, b.sum_repr]

theorem basisColumnMatrix_isUnit {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m))) :
    IsUnit (basisColumnMatrix b) := by
  apply Matrix.mulVec_injective_iff_isUnit.mp
  intro c d hcd
  rw [basisColumnMatrix_mulVec, basisColumnMatrix_mulVec] at hcd
  have hs := congrArg (WithLp.toLp 2) hcd
  funext i
  have hr := congrArg (fun x : EuclideanSpace 𝕜 (Fin m) => b.repr x i) hs
  simpa only [WithLp.toLp_ofLp, b.repr_sum_self] using hr


theorem basisColumnMatrix_inverse_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  rw [← basisColumnMatrix_mulVec_repr b z, Matrix.mulVec_mulVec,
    Matrix.nonsing_inv_mul _ ((Matrix.isUnit_iff_isUnit_det (basisColumnMatrix b)).mp (basisColumnMatrix_isUnit b)),
    Matrix.one_mulVec]

end MolecularDynamics
