"""At most three compiler-backed short attempts per finite algebra assertion."""
import sys,json,hashlib,subprocess,importlib
from ch04_data import ROOT,BASE,RECORDS,NS
key=sys.argv[1]
mods={'RelativeWeightedZero':'44','KineticSplit':'44','SkewRepresentation':'44b',
      'InertiaSkewIdentity':'44c','InertiaTraceCorrected':'44c','RotationTraceIdentity':'44b',
      'SHAKEElimination':'435extra','RotationTrajectory':'44extras','CrossIdentityFull':'44cross',
      'ConstrainedPotentialFlow':'4351','RotationSkew':'44b','RigidVelocity':'44b'}
importlib.import_module('ch04_section'+mods[key])
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';state=folder/f'{key}.json'
routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 for x in routes) or len(routes)>=3:print(key,'saved evidence reused');sys.exit()
route=len(routes)+1
proofs={
'ExactPlanarRotation':'''intro I π i hI
  dsimp only
  refine ⟨?_,?_,?_⟩
  · fin_cases i <;> ext j <;> fin_cases j <;>
      simp [axisRotation,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
  · intro t
    fin_cases i <;> simp [axisRotation,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
  · intro t
    have ha : HasDerivAt (fun s : ℝ => -s*π i/I i) (-π i/I i) t := by
      convert ((hasDerivAt_id t).neg.mul_const (π i)).div_const (I i) using 1 <;> simp
    have hc := ha.cos
    have hs := ha.sin
    apply hasDerivAt_pi.mpr
    intro j
    fin_cases i <;> fin_cases j <;>
      simp [axisRotation,cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three,Pi.single_apply]
    all_goals first
      | convert hasDerivAt_const t (π 0) using 1 <;> ring
      | convert hasDerivAt_const t (π 1) using 1 <;> ring
      | convert hasDerivAt_const t (π 2) using 1 <;> ring
      | convert (hc.mul_const (π 0)).sub (hs.mul_const (π 1)) using 1 <;> ring
      | convert (hs.mul_const (π 0)).add (hc.mul_const (π 1)) using 1 <;> ring
      | convert (hc.mul_const (π 1)).sub (hs.mul_const (π 2)) using 1 <;> ring
      | convert (hs.mul_const (π 1)).add (hc.mul_const (π 2)) using 1 <;> ring
      | convert (hc.mul_const (π 0)).add (hs.mul_const (π 2)) using 1 <;> ring
      | convert (hc.mul_const (π 2)).sub (hs.mul_const (π 0)) using 1 <;> ring''',
'RigidHamiltonianField':'''intro T π hT
  let B := T⁻¹
  have hsym : Bᵀ=B := by
    simpa [B,Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hs : ∀ i j : Fin 3, B i j=B j i := by
    intro i j
    simpa using congrArg (fun A : Mat3 => A j i) hsym
  let row : Fin 3 → (V →L[ℝ] ℝ) := fun i => ∑ j, B i j • (ContinuousLinearMap.proj j : V →L[ℝ] ℝ)
  let L : V →L[ℝ] ℝ := (2 : ℝ)⁻¹ • ∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : V →L[ℝ] ℝ))
  have hb : ∀ i, HasFDerivAt (fun x : V => (B *ᵥ x) i) (row i) π := by
    intro i
    change HasFDerivAt (fun x : V => ∑ j,B i j*x j) (∑ j,B i j • (ContinuousLinearMap.proj j : V →L[ℝ] ℝ)) π
    apply HasFDerivAt.fun_sum
    intro j hj
    exact (hasFDerivAt_apply j π).const_mul (B i j)
  have hh : HasFDerivAt (fun x : V => ∑ i,x i*(B *ᵥ x) i)
      (∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : V →L[ℝ] ℝ))) π := by
    apply HasFDerivAt.fun_sum
    intro i hii
    exact (hasFDerivAt_apply i π).mul (hb i)
  have hd : HasFDerivAt (fun x : V => dot x (B *ᵥ x)/2) L π := by
    simpa [dot,L,smul_eq_mul,div_eq_mul_inv,mul_comm] using hh.const_smul ((2 : ℝ)⁻¹)
  have hg : MolecularDynamics.Chapter04Review.grad (fun x : V => dot x (B *ᵥ x)/2) π=B *ᵥ π := by
    ext i
    change (fderiv ℝ (fun x : V => dot x (B *ᵥ x)/2) π) (Pi.single i 1)=(B *ᵥ π) i
    rw [hd.fderiv]
    fin_cases i <;> simp [L,row,ContinuousLinearMap.sum_apply,ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.proj_apply,Fin.sum_univ_three,Pi.single_apply,Matrix.mulVec,dotProduct,hs 1 0,hs 2 0,hs 2 1] <;> ring
  change cross3 π (B *ᵥ π)=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ MolecularDynamics.Chapter04Review.grad (fun x : V => dot x (B *ᵥ x)/2) π
  rw [hg]
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring''',
'RigidInvariants':'''intro T π a b hT hab hπ hsol
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
      rw [htrans,hsym,hcomm (T⁻¹ *ᵥ π t) (eulerRigidField T (π t))]
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
  exact ⟨ce t ht,cn t ht⟩''',
'RotationBodyEnergy':'''intro N m δ Θ «ω» ho hdet
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
    rw [hc,ht,hi,hn,ht,he]
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
  simp_rw [hsmul,hf]''',
'AngularInertia':'''intro N m δ Θ «ω» ho hdet
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
  rw [hterm]''',
'SecondMomentDiagonal':'''intro N m δ
  let R := MolecularDynamics.Chapter04Review.secondMoment m δ
  have hs : R.IsHermitian := by
    change Rᴴ=R
    ext i j
    simp [R,MolecularDynamics.Chapter04Review.secondMoment,MolecularDynamics.Chapter04Review.outer,Matrix.conjTranspose_apply,mul_comm]
  let O := hs.eigenvectorUnitary
  refine ⟨(O : MolecularDynamics.Chapter04Review.Mat3),?_,?_⟩
  · simpa [Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using Unitary.coe_star_mul_self O
  · have he : (O : MolecularDynamics.Chapter04Review.Mat3)ᵀ*R*(O : MolecularDynamics.Chapter04Review.Mat3)=Matrix.diagonal hs.eigenvalues := by
      simpa [O,Matrix.conjStarAlgAut_star_apply,Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using hs.conjStarAlgAut_star_eigenvectorUnitary
    intro i j hij
    simpa [Matrix.diagonal,hij] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) he''',
'RotationSkew':'''intro Θ t d hd ho
  have hs : ∀ i j : Fin 3, ∑ k, (d i k*Θ t j k+Θ t i k*d j k)=0 := by
    intro i j
    have hf : HasDerivAt (fun s => ∑ k, Θ s i k*Θ s j k)
        (∑ k, (d i k*Θ t j k+Θ t i k*d j k)) t := by
      apply HasDerivAt.fun_sum
      intro k hk
      exact (((hd.apply i).apply k).mul ((hd.apply j).apply k))
    have he : (fun s => ∑ k, Θ s i k*Θ s j k) =ᶠ[𝓝 t] (fun _ => (1 : Mat3) i j) := by
      filter_upwards [ho] with s h
      simpa [Matrix.mul_apply,Matrix.transpose_apply] using congrArg (fun B : Mat3 => B i j) h
    exact hf.unique ((hasDerivAt_const t ((1 : Mat3) i j)).congr_of_eventuallyEq he.symm)
  ext i j
  have h := hs i j
  simp only [Fin.sum_univ_three] at h
  simp [Matrix.mul_apply,Matrix.transpose_apply,Fin.sum_univ_three]
  nlinarith [h]''',
'RigidVelocity':'''intro Θ dΘ δ «ω» t hd ho hs
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,dΘ i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact ((hd.apply i).apply j).mul_const (δ j)
  have hv : HasDerivAt (fun s => Θ s *ᵥ δ) (dΘ *ᵥ δ) t := hasDerivAt_pi.mpr he
  have hi : (Θ t)ᵀ*Θ t=1 := Matrix.mul_eq_one_comm.mp ho
  have hcross : MolecularDynamics.Chapter04Review.skewMatrix «ω» *ᵥ (Θ t *ᵥ δ)=
      MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ) := by
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
  rw [← hcross,← hs,Matrix.mulVec_mulVec,Matrix.mul_assoc,hi,Matrix.mul_one]
  exact hv''',
'ConstrainedPotentialFlow':'''intro n l m U g z hz hdet hg t
  rcases hz with ⟨hq,hp⟩
  let u := MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1
  have hi : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.invMass m v=textbookInverseMassMatrix m *ᵥ v := by
    intro v
    ext i
    simp [MolecularDynamics.Chapter04Review.invMass,textbookInverseMassMatrix]
  have hproj : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ v=textbookCotangentProjection m g z.1 v := by
    intro v
    simp only [MolecularDynamics.Chapter04Review.momentumProjector,Matrix.sub_mulVec,Matrix.one_mulVec,
      textbookCotangentProjection,textbookCotangentMultiplier,Matrix.mulVec_mulVec,Matrix.mul_assoc]
  have hu : textbookConstraintJacobian g z.1 *ᵥ (textbookInverseMassMatrix m *ᵥ u)=0 := by
    dsimp [u]
    rw [hproj]
    exact textbookCotangentProjection_hiddenConstraint m g z.1 _ hdet
  rw [hi] at hp
  constructor
  · change z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
      textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (z.2-t • u)=0
    refine ⟨hq,?_⟩
    rw [hi,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_sub,Matrix.mulVec_smul,hp,hu]
    simp
  · simpa [u,Matrix.neg_mulVec] using (((hasDerivAt_id t).smul_const u).const_sub z.2)''',
'CrossIdentityFull':'''intro u v
  constructor <;> ext i <;> fin_cases i <;>
    simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring''',
'RelativeWeightedZero':'''intro N m q hm
  simp only [MolecularDynamics.Chapter04Review.relativePositions,smul_sub,Finset.sum_sub_distrib,← Finset.sum_smul]
  rw [MolecularDynamics.Chapter04Review.centerMass,smul_smul]
  change (∑ i, m i • q i)-(MolecularDynamics.Chapter04Review.totalMass m * (MolecularDynamics.Chapter04Review.totalMass m)⁻¹) • (∑ i, m i • q i)=0
  rw [mul_inv_cancel₀ hm,one_smul,sub_self]''',
'KineticSplit':'''intro N m v w hz
  have h0 := congrFun hz 0
  have h1 := congrFun hz 1
  have h2 := congrFun hz 2
  simp only [Finset.sum_apply,Pi.smul_apply,smul_eq_mul,Pi.zero_apply] at h0 h1 h2
  have he : ∀ i, MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i)=
      MolecularDynamics.Chapter04Review.dot v v+2*MolecularDynamics.Chapter04Review.dot v (w i)+MolecularDynamics.Chapter04Review.dot (w i) (w i) := by
    intro i
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have hc : ∑ i, m i*MolecularDynamics.Chapter04Review.dot v (w i)=0 := by
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,mul_add,Finset.sum_add_distrib,← mul_assoc,← Finset.mul_sum,mul_comm] 
    linear_combination v 0*h0+v 1*h1+v 2*h2
  simp_rw [he,mul_add,Finset.sum_add_distrib]
  rw [← Finset.sum_mul]
  have hx : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=0 := by
    rw [show (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=2*∑ i,m i*MolecularDynamics.Chapter04Review.dot v (w i) by rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i hi; ring,hc,mul_zero]
  rw [hx]
  simp [MolecularDynamics.Chapter04Review.totalMass]
  ring''',
'SkewRepresentation':'''intro A ha
  have hs : ∀ i j : Fin 3, A j i= -A i j := by
    intro i j
    simpa using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) ha
  refine ⟨![A 2 1,A 0 2,A 1 0],?_,?_⟩
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.skewMatrix] <;> nlinarith [hs 0 0,hs 0 1,hs 0 2,hs 1 1,hs 1 2,hs 2 2]
  · intro w hw
    ext i
    fin_cases i
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 2 1) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 0 2) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 1 0) hw''',
'InertiaSkewIdentity':'''intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v= -(MolecularDynamics.Chapter04Review.skewMatrix v)^2 := by
    intro v
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mul_apply,Fin.sum_univ_three,pow_two] <;> ring
  simp [MolecularDynamics.Chapter04Review.inertiaTensor,he,Finset.sum_neg_distrib]''',
'InertiaTraceCorrected':'''intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v).trace=2*MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    simp [Matrix.trace,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
    ring
  rw [MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.trace_sum]
  simp_rw [Matrix.trace_smul,he]
  have ht : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot (δ i) (δ i)))/2=
      ∑ i, m i*MolecularDynamics.Chapter04Review.dot (δ i) (δ i) := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  rw [ht,MolecularDynamics.Chapter04Review.secondMoment]
  rw [Finset.sum_smul,← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  simp [smul_sub,smul_smul]
  module''',
'RotationTraceIdentity':'''intro N m δ dΘ
  unfold MolecularDynamics.Chapter04Review.rotationKinetic MolecularDynamics.Chapter04Review.secondMoment
  rw [Matrix.mul_sum,Matrix.sum_mul,Matrix.trace_sum]
  rw [Finset.sum_div,Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  simp [Matrix.trace,Matrix.mul_apply,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
  ring''',
'SHAKEElimination':'''intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hq0,hh0,hp0,hg0⟩
  rcases h1 with ⟨hq1,hh1,hp1,hg1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,MolecularDynamics.Chapter04Review.reaction,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1''',
'RotationTrajectory':'''intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact ((hd.apply i).apply j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he'''
}
candidate=proofs[key]
if route==2:
    if key=='ConstrainedPotentialFlow':
        candidate=candidate.replace('textbookInverseMassMatrix]','textbookInverseMassMatrix,Matrix.mulVec_diagonal]')
    candidate=candidate.replace('Matrix.trace_sum','Matrix.trace_sum').replace('HasDerivAt.fun_sum','HasDerivAt.sum')
    candidate=candidate.replace('MolecularDynamics.Chapter04Review.reaction','textbookConstraintJacobian')
    if key=='SHAKEElimination':
        candidate=proofs[key].replace('⟨hq0,hh0,hp0,hg0⟩','⟨hh0,hq0,hg0,hp0⟩').replace('⟨hq1,hh1,hp1,hg1⟩','⟨hh1,hq1,hg1,hp1⟩')
    if key=='KineticSplit':
        begin=candidate.index('  have hc :');end=candidate.index('  simp_rw [he',begin)
        candidate=candidate[:begin]+'''  have ht : ∀ a : Fin 3, (∑ i, m i*(v a*w i a))=v a*∑ i,m i*w i a := by
    intro a
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  have hc : ∑ i, m i*MolecularDynamics.Chapter04Review.dot v (w i)=0 := by
    simp only [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,mul_add,Finset.sum_add_distrib]
    rw [ht 0,ht 1,ht 2,h0,h1,h2]
    ring
'''+candidate[end:]
if route==3:
    candidate=candidate.replace('HasDerivAt.fun_sum','HasDerivAt.sum')
    if key=='SHAKEElimination':
        candidate=proofs[key].replace('⟨hq0,hh0,hp0,hg0⟩','⟨hh0,hq0,hg0,hp0⟩').replace('⟨hq1,hh1,hp1,hg1⟩','⟨hh1,hq1,hg1,hp1⟩').replace('MolecularDynamics.Chapter04Review.reaction,','')
src=folder/f'{key}-route{route}.lean';log=src.with_suffix('.log')
src.write_text('''import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Algebra
set_option maxHeartbeats 500000
'''+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch04Algebra\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT);log.write_bytes(out.stdout)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
routes.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,source=src.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(src),log_sha256=sha(log)))
state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8');print(key,route,out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace')[-3200:])
