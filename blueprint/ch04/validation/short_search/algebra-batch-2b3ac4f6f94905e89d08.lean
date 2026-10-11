import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch04ShortRotationSkew
theorem rotationSkew :
  ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ) := by
  intro Θ t d hd ho
  have hs : ∀ i j : Fin 3, ∑ k, (d i k*Θ t j k+Θ t i k*d j k)=0 := by
    intro i j
    have hf : HasDerivAt (fun s => ∑ k, Θ s i k*Θ s j k)
        (∑ k, (d i k*Θ t j k+Θ t i k*d j k)) t := by
      apply HasDerivAt.fun_sum
      intro k hk
      exact ((hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) k).mul (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd j) k))
    have he : (fun s => ∑ k, Θ s i k*Θ s j k) =ᶠ[𝓝 t] (fun _ => (1 : Mat3) i j) := by
      filter_upwards [ho] with s h
      simpa [Matrix.mul_apply,Matrix.transpose_apply] using congrArg (fun B : Mat3 => B i j) h
    exact hf.unique ((hasDerivAt_const t ((1 : Mat3) i j)).congr_of_eventuallyEq he)
  ext i j
  have h := hs i j
  simp only [Fin.sum_univ_three] at h
  simp [Matrix.mul_apply,Matrix.transpose_apply,Fin.sum_univ_three]
  nlinarith [h]
end MD.Ch04ShortRotationSkew
namespace MD.Ch04ShortRigidVelocity
theorem rigidVelocity : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (dΘ : MolecularDynamics.Chapter04Review.Mat3) (δ «ω» : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ=MolecularDynamics.Chapter04Review.skewMatrix «ω» →
    HasDerivAt (fun s => Θ s *ᵥ δ) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ)) t := by
  intro Θ dΘ δ «ω» t hd ho hs
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,dΘ i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  have hv : HasDerivAt (fun s => Θ s *ᵥ δ) (dΘ *ᵥ δ) t := hasDerivAt_pi.mpr he
  have hi : (Θ t)ᵀ*Θ t=1 := mul_eq_one_comm.mp ho
  have hcross : MolecularDynamics.Chapter04Review.skewMatrix «ω» *ᵥ (Θ t *ᵥ δ)=
      MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ) := by
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
  rw [← hcross,← hs,Matrix.mulVec_mulVec,Matrix.mul_assoc,hi,Matrix.mul_one]
  exact hv
end MD.Ch04ShortRigidVelocity
namespace MD.Ch04ShortInertiaTraceCorrected
theorem inertiaTraceCorrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v).trace=2*MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    simp [Matrix.trace,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
    ring
  rw [MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.trace_sum]
  simp_rw [Matrix.trace_smul,he,smul_eq_mul]
  have ht : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot (δ i) (δ i)))/2=
      ∑ i, m i*MolecularDynamics.Chapter04Review.dot (δ i) (δ i) := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  rw [ht,MolecularDynamics.Chapter04Review.secondMoment]
  ext i j
  simp only [Finset.sum_apply,Pi.smul_apply,Pi.sub_apply,smul_eq_mul]
  rw [Finset.sum_mul,← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  ring
end MD.Ch04ShortInertiaTraceCorrected
namespace MD.Ch04ShortRotationTrajectory
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he
end MD.Ch04ShortRotationTrajectory
namespace MD.Ch04ShortSecondMomentDiagonal
theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
    ∃ O : MolecularDynamics.Chapter04Review.Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*MolecularDynamics.Chapter04Review.secondMoment m δ*O) i j=0 := by
  intro N m δ
  let R := MolecularDynamics.Chapter04Review.secondMoment m δ
  have hs : R.IsHermitian := by
    change Rᴴ=R
    ext i j
    simp [R,MolecularDynamics.Chapter04Review.secondMoment,MolecularDynamics.Chapter04Review.outer,Matrix.conjTranspose_apply,Finset.sum_apply,Pi.smul_apply,mul_comm]
  let O := hs.eigenvectorUnitary
  refine ⟨(O : MolecularDynamics.Chapter04Review.Mat3),?_,?_⟩
  · simpa [Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using Unitary.coe_star_mul_self O
  · have he : (O : MolecularDynamics.Chapter04Review.Mat3)ᵀ*R*(O : MolecularDynamics.Chapter04Review.Mat3)=Matrix.diagonal hs.eigenvalues := by
      simpa [O,Unitary.conjStarAlgAut_star_apply,Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using hs.conjStarAlgAut_star_eigenvectorUnitary
    intro i j hij
    simpa [Matrix.diagonal,hij] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) he
end MD.Ch04ShortSecondMomentDiagonal
