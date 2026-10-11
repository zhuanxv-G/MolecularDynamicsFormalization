import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch04ShortRotationBodyEnergy
theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
    MolecularDynamics.Chapter04Review.rotationalEnergy (MolecularDynamics.Chapter04Review.inertiaTensor m δ) (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  let x := Θᵀ *ᵥ «ω»
  have ht : ∀ (A : Mat3) (v w : V), dot (A *ᵥ v) w=dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hx : Θ *ᵥ x=«ω» := by
    dsimp [x]
    rw [Matrix.mulVec_mulVec,mul_eq_one_comm.mp ho,Matrix.one_mulVec]
  have hn : dot «ω» «ω»=dot x x := by
    conv_lhs => rw [← hx]
    rw [ht,hi]
  have hc : ∀ v w : V, dot (cross3 w v) (cross3 w v)=dot v v*dot w w-(dot v w)^2 := by
    intro v w
    simp [cross3,dot,Fin.sum_univ_three]
    ring
  have he : ∀ v y : V, dot y ((dot v v • (1 : Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ y)=dot v v*dot y y-(dot v y)^2 := by
    intro v y
    simp [dot,Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hf : ∀ v : V, dot (cross3 «ω» (Θ *ᵥ v)) (cross3 «ω» (Θ *ᵥ v))=
      dot x ((dot v v • (1 : Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ x) := by
    intro v
    rw [hc,he]
    have hv : dot (Θ *ᵥ v) (Θ *ᵥ v)=dot v v := by rw [ht,hi]
    have hw : dot (Θ *ᵥ v) «ω»=dot v x := ht Θ v «ω»
    rw [hv,hn,hw]
  have hsum : ∀ (K : ℕ) (a : Fin K → V), dot x (∑ i,a i)=∑ i,dot x (a i) := by
    intro K a
    simp [dot,Fin.sum_univ_three,Finset.sum_apply,Finset.mul_sum,Finset.sum_add_distrib]
  have hsmul : ∀ (c : ℝ) (v : V), dot x (c • v)=c*dot x v := by
    intro c v
    simp [dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  rw [MolecularDynamics.Chapter04Review.rotationalEnergy,MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.sum_mulVec]
  change (∑ i,m i*dot (cross3 «ω» (Θ *ᵥ δ i)) (cross3 «ω» (Θ *ᵥ δ i)))/2=
      dot x (∑ i,(m i • (dot (δ i) (δ i) • (1 : Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))) *ᵥ x)/2
  simp_rw [Matrix.smul_mulVec]
  rw [hsum]
  simp_rw [hsmul,hf]
end MD.Ch04ShortRotationBodyEnergy
namespace MD.Ch04ShortRigidInvariants
theorem rigidInvariants :
  ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → MolecularDynamics.Chapter04Review.freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) ∧
      MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
  intro T π a b hT hab hπ hsol
  have hsym : (T⁻¹)ᵀ=T⁻¹ := by
    simpa [Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hcomm : ∀ u v : V, dot u v=dot v u := by
    intro u v
    simp [dot,mul_comm]
  have htrans : ∀ (B : Mat3) (u v : V), dot u (B *ᵥ v)=dot (Bᵀ *ᵥ u) v := by
    intro B u v
    simp [dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hc : ∀ u v : V, dot (cross3 u v) v=0 ∧ dot u (cross3 u v)=0 := by
    intro u v
    constructor <;> simp [cross3,dot,Fin.sum_univ_three] <;> ring
  have hd : ∀ (B : Mat3) t, t ∈ Icc a b →
      HasDerivWithinAt (fun s => dot (π s) (B *ᵥ π s))
      (dot (eulerRigidField T (π t)) (B *ᵥ π t)+dot (π t) (B *ᵥ eulerRigidField T (π t))) (Icc a b) t := by
    intro B t ht
    have hp := hsol t ht
    have hx : ∀ i, HasDerivWithinAt (fun s => (B *ᵥ π s) i) ((B *ᵥ eulerRigidField T (π t)) i) (Icc a b) t := by
      intro i
      change HasDerivWithinAt (fun s => ∑ j, B i j*π s j) (∑ j,B i j*eulerRigidField T (π t) j) (Icc a b) t
      apply HasDerivWithinAt.fun_sum
      intro j hj
      exact (hasDerivWithinAt_pi.mp hp j).const_mul (B i j)
    have h := HasDerivWithinAt.fun_sum (u := Finset.univ) (fun i _ => (hasDerivWithinAt_pi.mp hp i).mul (hx i))
    simpa [dot,Finset.sum_add_distrib] using h
  have he : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => dot (π s) (T⁻¹ *ᵥ π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : dot (eulerRigidField T (π t)) (T⁻¹ *ᵥ π t)+dot (π t) (T⁻¹ *ᵥ eulerRigidField T (π t))=0 := by
      rw [htrans T⁻¹ (π t) (eulerRigidField T (π t)),hsym,hcomm (T⁻¹ *ᵥ π t) (eulerRigidField T (π t))]
      simp [eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).1]
    simpa [hz] using hd T⁻¹ t ht
  have hn : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => dot (π s) (π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : dot (eulerRigidField T (π t)) (π t)+dot (π t) (eulerRigidField T (π t))=0 := by
      rw [hcomm (eulerRigidField T (π t)) (π t)]
      simp [eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).2]
    simpa [Matrix.one_mulVec,hz] using hd 1 t ht
  have ce : ∀ t ∈ Icc a b, dot (π t) (T⁻¹ *ᵥ π t)=dot (π a) (T⁻¹ *ᵥ π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (he t ht).continuousWithinAt)
    intro t ht
    exact (he t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  have cn : ∀ t ∈ Icc a b, dot (π t) (π t)=dot (π a) (π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (hn t ht).continuousWithinAt)
    intro t ht
    exact (hn t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  intro t ht
  exact ⟨ce t ht,cn t ht⟩
end MD.Ch04ShortRigidInvariants
