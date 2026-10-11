"""At most three compiler-backed short attempts per finite algebra assertion."""
import sys,json,hashlib,subprocess,importlib
from ch04_data import ROOT,BASE,RECORDS,NS
key=sys.argv[1]
mods={'RelativeWeightedZero':'44','KineticSplit':'44','SkewRepresentation':'44b',
      'InertiaSkewIdentity':'44c','InertiaTraceCorrected':'44c','RotationTraceIdentity':'44b',
      'SHAKEElimination':'4351','RotationTrajectory':'44extras'}
importlib.import_module('ch04_section'+mods[key])
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';state=folder/f'{key}.json'
routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 for x in routes) or len(routes)>=3:print(key,'saved evidence reused');sys.exit()
route=len(routes)+1
proofs={
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
    candidate=candidate.replace('Matrix.trace_sum','Matrix.trace_sum').replace('HasDerivAt.fun_sum','HasDerivAt.sum')
    candidate=candidate.replace('MolecularDynamics.Chapter04Review.reaction','textbookConstraintJacobian')
if route==3:
    candidate=candidate.replace('HasDerivAt.fun_sum','HasDerivAt.sum')
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
