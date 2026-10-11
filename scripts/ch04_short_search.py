"""Bounded chapter 4 short routes with immutable compiler evidence."""
import sys,json,subprocess,hashlib,importlib
from ch04_data import ROOT,BASE,RECORDS,NS
key,route=sys.argv[1],int(sys.argv[2]);assert 1<=route<=3
modules={'ScalarEulerStable':'4','SymplecticEulerCharacteristic':'4','EulerImaginaryGrowth':'4','MidpointElimination':'41','ImplicitModulus':'41','ImpulseDet':'421','ImpulseTrace':'421b','SymplecticEulerUnitRoots':'4b','OscillatorSpectrum':'4b','SymplecticEulerRoots':'4b'}
importlib.import_module('ch04_section'+modules[key])
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';folder.mkdir(parents=True,exist_ok=True)
state=folder/(key+'.json');routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in routes):raise SystemExit('Reuse saved proof/evidence')
proofs={
'ScalarEulerStable':'''intro h rho
  constructor
  · rintro ⟨C, hC⟩
    by_contra hn
    obtain ⟨k, hk⟩ := exists_lt_pow (lt_of_not_ge hn) C
    have hb := hC k
    rw [norm_pow] at hb
    exact (not_lt_of_ge hb) hk
  · intro ha
    refine ⟨1, ?_⟩
    intro k
    rw [norm_pow]
    exact pow_le_one₀ (norm_nonneg _) ha''',
'SymplecticEulerCharacteristic':'''intro Ω h rho
  simp [MolecularDynamics.Chapter04Review.symplecticEulerMatrix, Matrix.det_fin_two]
  push_cast
  ring''',
'EulerImaginaryGrowth':'''intro h Ω hh hΩ z hz
  have hs : ‖MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω)‖^2=1+(h*Ω)^2 := by
    simp [MolecularDynamics.Chapter04Review.eulerFactor, Complex.sq_norm]
    ring
  have hp : 0 < (h*Ω)^2 := sq_pos_of_ne_zero (mul_ne_zero hh hΩ)
  have hg : 1 < ‖MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω)‖ := by
    nlinarith [norm_nonneg (MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))]
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hg).atTop_mul_const (norm_pos_iff.mpr hz)
  simpa [norm_mul, norm_pow] using ht''',
'MidpointElimination':'''intro n m U h z mid out hm
  rcases hm with ⟨hq,hp,houtq,houtp⟩
  rw [hq,hp]
  funext i
  simp [MolecularDynamics.Chapter04Review.invMass]
  ring''',
'ImplicitModulus':'''intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor, norm_div]
  have he : (1+(Complex.I*h*Ω/2 : ℂ)) = star (1-(Complex.I*h*Ω/2 : ℂ)) := by
    simp
  rw [he, norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr''',
'ImpulseDet':'''intro Ω h hΩ
  simp only [MolecularDynamics.Chapter04Review.impulseMatrix, Matrix.det_mul]
  have hs : (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hs2 : (MolecularDynamics.Chapter04Review.slowMatrix (h/2)).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hf : (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.fastMatrix, Matrix.det_fin_two]
    field_simp
    nlinarith [Real.sin_sq_add_cos_sq (Ω*h)]
  exact ⟨hs,hf,by rw [hs2,hf]; norm_num⟩''',
'ImpulseTrace':'''intro Ω h hΩ
  simp [MolecularDynamics.Chapter04Review.impulseMatrix, MolecularDynamics.Chapter04Review.slowMatrix,
    MolecularDynamics.Chapter04Review.fastMatrix, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]
  rw [mul_comm h Ω]
  ring''',
'SymplecticEulerUnitRoots':'''intro Ω h ζ ht he
  have hr := congrArg Complex.re he
  have hi := congrArg Complex.im he
  simp [pow_two, Complex.mul_re, Complex.mul_im] at hr hi
  have hz : (2*ζ.re-(2-h^2*Ω^2))*ζ.im=0 := by nlinarith [hi]
  have hn : ζ.re^2+ζ.im^2=1 := by
    rcases mul_eq_zero.mp hz with hz|hz
    · nlinarith [hr]
    · by_cases hpos : 0 ≤ ζ.re
      · have hab : 0 ≤ h^2*Ω^2*ζ.re := mul_nonneg (mul_nonneg (sq_nonneg h) (sq_nonneg Ω)) hpos
        nlinarith [hr,sq_nonneg (ζ.re-1)]
      · have hab : 0 ≤ (4-h^2*Ω^2)*(-ζ.re) := mul_nonneg (by linarith) (by linarith)
        nlinarith [hr,sq_nonneg (ζ.re+1)]
  have hnorm := Complex.sq_norm ζ
  nlinarith [norm_nonneg ζ]'''
}
if key in {'OscillatorSpectrum','SymplecticEulerRoots'}:
    matrix='oscillatorMatrix Ω' if key=='OscillatorSpectrum' else 'symplecticEulerMatrix Ω h'
    intro='intro Ω ζ' if key=='OscillatorSpectrum' else 'intro Ω h ζ'
    poly='ζ^2+(Ω : ℂ)^2' if key=='OscillatorSpectrum' else 'ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1'
    helper=intro+'''
  let A : Matrix (Fin 2) (Fin 2) ℂ := (MolecularDynamics.Chapter04Review.MATRIX).map Complex.ofReal
  have heig : (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=0 := by
    rw [← Matrix.exists_mulVec_eq_zero_iff]
    simp only [Matrix.sub_mulVec, Matrix.smul_mulVec, Matrix.one_mulVec, sub_eq_zero]
    constructor
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
  have hd : (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=POLY := by
    simp [A, MolecularDynamics.Chapter04Review.NAME, Matrix.det_fin_two]
    push_cast
    ring
  change (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ _
  rw [heig,hd]
'''.replace('MATRIX',matrix).replace('POLY',poly).replace('NAME',matrix.split()[0])
    if key=='OscillatorSpectrum':
        tail='''  have hf : ζ^2+(Ω : ℂ)^2=(ζ-Complex.I*Ω)*(ζ+Complex.I*Ω) := by
    ring_nf
    rw [Complex.I_sq]
    ring
  rw [hf,mul_eq_zero,sub_eq_zero,add_eq_zero_iff_eq_neg]'''
    else:
        tail='''  constructor
  · intro he
    refine ⟨2*ζ-(2-h^2*Ω^2 : ℝ), ?_, Or.inl ?_⟩
    · push_cast at he ⊢
      linear_combination 4*he
    · push_cast
      ring
  · rintro ⟨d,hd,(rfl|rfl)⟩ <;> push_cast at hd ⊢ <;>
      linear_combination (1/4 : ℂ)*hd'''
    proofs[key]=helper+tail
candidate=proofs[key]
if route==2:
    candidate=candidate.replace('simp [','simp_all [').replace('field_simp','field_simp [hΩ]')
    if key=='ScalarEulerStable':candidate=candidate.replace('obtain ⟨k, hk⟩ := exists_lt_pow (lt_of_not_ge hn) C',
        '''have ht := (tendsto_pow_atTop_atTop_of_one_lt (lt_of_not_ge hn)).eventually (eventually_gt_atTop C)
    obtain ⟨k,hk⟩ := ht.exists''')
    if key=='EulerImaginaryGrowth':candidate=candidate.replace('Complex.sq_norm]', 'Complex.sq_norm, Complex.normSq_apply]')
    if key=='SymplecticEulerUnitRoots':
        candidate=proofs[key].replace('nlinarith [hr,sq_nonneg (ζ.re-1)]',
            '''have hs : (ζ.re-1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re-1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith''').replace('nlinarith [hr,sq_nonneg (ζ.re+1)]',
            '''have hs : (ζ.re+1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re+1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith''').replace('have hnorm := Complex.sq_norm ζ',
            '''have hnorm : ‖ζ‖^2=1 := by
    rw [Complex.sq_norm,Complex.normSq_apply]
    nlinarith [hn]''')
    if key=='OscillatorSpectrum':candidate=proofs[key]+'\n  simp only [neg_mul]'
    if key=='SymplecticEulerRoots':
        candidate=proofs[key].replace('have hd :','have hchar :').replace('rw [heig,hd]','rw [heig,hchar]').replace('rintro ⟨d,hd,','rintro ⟨d,hroot,').replace(' at hd ⊢',' at hroot ⊢').replace('(1/4 : ℂ)*hd','(1/4 : ℂ)*hroot')
    if key=='MidpointElimination':candidate='''intro n m U h z mid out hm
  rcases hm with ⟨hq,hp,houtq,houtp⟩
  calc
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 := hq
    _ = _ := by
      rw [hp]
      funext i
      simp [MolecularDynamics.Chapter04Review.invMass]
      ring'''
    if key=='ImplicitModulus':candidate='''intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by
    simp
    ring
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr'''
if route==3:
    candidate=candidate.replace('simp [','simp_all [').replace('field_simp','field_simp [hΩ]').replace('  ring','  ring_nf')
    if key=='ScalarEulerStable':candidate='''intro h rho
  unfold MolecularDynamics.Chapter04Review.scalarStable
  constructor
  · rintro ⟨C,hC⟩
    by_contra hn
    obtain ⟨k,hk⟩ := exists_lt_pow (lt_of_not_ge hn) C
    exact (not_lt_of_ge (by simpa [norm_pow] using hC k)) hk
  · intro ha
    exact ⟨1,fun k => by simpa [norm_pow] using pow_le_one₀ (norm_nonneg _) ha (n:=k)⟩'''
    if key=='ImplicitModulus':candidate='''intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by simp
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr'''
src=folder/f'{key}-route{route}.lean';log=src.with_suffix('.log')
src.write_text('''import MolecularDynamics.Chapter04.Statements
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Short
set_option maxHeartbeats 400000
'''+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch04Short\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout);sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
routes.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,source=src.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(src),log_sha256=sha(log)))
state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(key,route,out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding)[-2200:])
