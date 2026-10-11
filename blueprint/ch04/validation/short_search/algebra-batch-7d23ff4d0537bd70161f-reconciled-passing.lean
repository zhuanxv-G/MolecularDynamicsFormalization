import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch04ShortRotationTraceIdentity
theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (dΘ : MolecularDynamics.Chapter04Review.Mat3),
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      MolecularDynamics.Chapter04Review.rotationKinetic (MolecularDynamics.Chapter04Review.secondMoment m δ) dΘ := by
  intro N m δ dΘ
  unfold MolecularDynamics.Chapter04Review.rotationKinetic MolecularDynamics.Chapter04Review.secondMoment
  rw [Matrix.mul_sum,Matrix.sum_mul,Matrix.trace_sum]
  rw [Finset.sum_div,Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  simp [Matrix.trace,Matrix.mul_apply,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
  ring
end MD.Ch04ShortRotationTraceIdentity
namespace MD.Ch04ShortInertiaSkewIdentity
theorem inertiaSkewIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.inertiaTensor m δ= -∑ i, m i • (MolecularDynamics.Chapter04Review.skewMatrix (δ i))^2 := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v= -(MolecularDynamics.Chapter04Review.skewMatrix v)^2 := by
    intro v
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mul_apply,Fin.sum_univ_three,pow_two] <;> ring
  simp [MolecularDynamics.Chapter04Review.inertiaTensor,he,Finset.sum_neg_distrib]
end MD.Ch04ShortInertiaSkewIdentity
namespace MD.Ch04ShortAngularInertia
theorem angularInertia :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 → MolecularDynamics.Chapter04Review.bodyMomentum Θ
    (MolecularDynamics.Chapter04Review.angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i))) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : V), dot (A *ᵥ v) w=dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hn : ∀ v : V, dot (Θ *ᵥ v) (Θ *ᵥ v)=dot v v := by
    intro v
    rw [ht,hi]
  have hc : ∀ u w : V, cross3 u (cross3 w u)=dot u u • w-dot u w • u := by
    intro u w
    ext i
    fin_cases i <;> simp [cross3,dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul] <;> ring
  have he : ∀ v y : V, MolecularDynamics.Chapter04Review.outer v *ᵥ y=dot v y • v := by
    intro v y
    ext i
    simp [MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  have hterm : ∀ v : V, Θᵀ *ᵥ cross3 (Θ *ᵥ v) (cross3 «ω» (Θ *ᵥ v))=
      (dot v v • (1 : Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ (Θᵀ *ᵥ «ω») := by
    intro v
    rw [hc,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_smul,hn,ht,hi,
      Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,he]
  simp only [MolecularDynamics.Chapter04Review.bodyMomentum,MolecularDynamics.Chapter04Review.angularMomentum,
    MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.mulVec_sum,Matrix.mulVec_smul,Matrix.sum_mulVec,Matrix.smul_mulVec]
  apply Finset.sum_congr rfl
  intro i hii
  rw [hterm]
end MD.Ch04ShortAngularInertia
