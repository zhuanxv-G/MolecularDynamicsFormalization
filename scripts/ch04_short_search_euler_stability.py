"""Symplectic Euler: transport the checked Verlet bound, then construct an outside root."""
import sys,json,subprocess,hashlib
from ch04_data import ROOT,BASE,RECORDS
key='SymplecticEulerStability';route=int(sys.argv[1]);assert 1<=route<=3
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
helpers=[next(x for x in RECORDS if x['source_id'].endswith('-'+k)) for k in ['VerletStability','SymplecticEulerRoots']]
assert all('sorry' not in x['code'] for x in helpers)
folder=BASE/'validation/short_search';state=folder/(key+'.json')
routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in routes):raise SystemExit('Reuse saved evidence')
candidate='''intro Ω h
  constructor
  · rintro ⟨hn,ht⟩
    obtain ⟨C,hC⟩ := verletStability Ω h hn ht
    let s : ℝ := h*Ω^2/2
    let P : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -s,1]
    let S : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; s,1]
    let A := MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h
    let B := MolecularDynamics.Chapter04Review.verletMatrix Ω h
    have hSP : S*P=1 := by
      ext i j; fin_cases i <;> fin_cases j <;>
        simp [S,P,Matrix.mul_apply,Fin.sum_univ_two]
    have hPA : P*A=B*P := by
      ext i j; fin_cases i <;> fin_cases j <;>
        simp [P,A,B,s,MolecularDynamics.Chapter04Review.symplecticEulerMatrix,
          MolecularDynamics.Chapter04Review.verletMatrix,Matrix.mul_apply,Fin.sum_univ_two] <;> ring
    have hp : ∀ k : ℕ, P*A^k=B^k*P := by
      intro k
      induction k with
      | zero => simp
      | succ k ih => rw [pow_succ',pow_succ',← mul_assoc,hPA,mul_assoc,ih,← mul_assoc]
    have hs : ∀ a : ℝ, ∀ v : Fin 2 → ℝ,
        ‖(!![1,0; a,1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ v‖ ≤ (1+|a|)*‖v‖ := by
      intro a v
      have h0 : |v 0| ≤ ‖v‖ := by simpa using norm_le_pi_norm v 0
      have h1 : |v 1| ≤ ‖v‖ := by simpa using norm_le_pi_norm v 1
      apply (pi_norm_le_iff_of_nonneg (by positivity)).mpr
      intro i
      fin_cases i
      · simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]
        nlinarith [mul_nonneg (abs_nonneg a) (norm_nonneg v)]
      · simp only [Matrix.cons_mulVec,Matrix.cons_val_one,Matrix.cons_val_zero]
        change |a*v 0+v 1| ≤ (1+|a|)*‖v‖
        calc
          _ ≤ |a|*|v 0|+|v 1| := by simpa [abs_mul] using abs_add (a*v 0) (v 1)
          _ ≤ |a|*‖v‖+‖v‖ := add_le_add (mul_le_mul_of_nonneg_left h0 (abs_nonneg a)) h1
          _ = _ := by ring
    refine ⟨(1+|s|)^2*|C|, ?_⟩
    intro k v
    have he : A^k *ᵥ v=S *ᵥ (B^k *ᵥ (P *ᵥ v)) := by
      rw [Matrix.mulVec_mulVec,← hp k,Matrix.mulVec_mulVec,← mul_assoc,hSP,one_mul]
    rw [he]
    calc
      _ ≤ (1+|s|)*‖B^k *ᵥ (P *ᵥ v)‖ := hs s _
      _ ≤ (1+|s|)*(|C|*‖P *ᵥ v‖) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        exact (hC k (P *ᵥ v)).trans (mul_le_mul_of_nonneg_right (le_abs_self C) (norm_nonneg _))
      _ ≤ (1+|s|)*(|C|*((1+|s|)*‖v‖)) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        apply mul_le_mul_of_nonneg_left _ (abs_nonneg C)
        simpa [P,abs_neg] using hs (-s) v
      _ = _ := by ring
  · intro ht
    have ht2 : 4 < h^2*Ω^2 := by
      have hs := sq_lt_sq₀ (by norm_num : (0:ℝ) ≤ 2) (abs_nonneg (h*Ω))
      have hh : (2:ℝ)^2 < |h*Ω|^2 := hs.mpr ht
      simpa [sq_abs,mul_pow] using hh
    let D : ℝ := h^4*Ω^4-4*h^2*Ω^2
    have hD : 0 < D := by dsimp [D]; nlinarith
    let d : ℝ := Real.sqrt D
    have hd : d^2=D := Real.sq_sqrt hD.le
    let ρ : ℝ := 1-h^2*Ω^2/2-d/2
    have hr : ρ < -1 := by dsimp [ρ,d]; nlinarith [Real.sqrt_nonneg D]
    have hv := (symplecticEulerRoots Ω h (ρ : ℂ)).mpr
      ⟨(d : ℂ),by exact_mod_cast hd,Or.inr (by dsimp [ρ]; push_cast; ring)⟩
    refine ⟨(ρ : ℂ), ?_, hv⟩
    rw [Complex.norm_real,Real.norm_eq_abs,abs_of_neg (by linarith)]
    linarith'''
if route==2:
    candidate=candidate.replace('simp only [Matrix.cons_mulVec,Matrix.cons_val_one,Matrix.cons_val_zero]',
        'simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]')
    candidate=candidate.replace('|*','| * ').replace('by dsimp [D]; nlinarith',
        'by dsimp [D]; nlinarith [mul_pos (sub_pos.mpr ht2) (by linarith : 0 < h^2*Ω^2)]')
if route==3:
    candidate=candidate.replace('simp only [Matrix.cons_mulVec,Matrix.cons_val_one,Matrix.cons_val_zero]',
        'simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]').replace('|*','| * ').replace('using abs_add ', 'using abs_add_le ')
    candidate=candidate.replace('rw [Matrix.mulVec_mulVec,← hp k,Matrix.mulVec_mulVec,← mul_assoc,hSP,one_mul]',
        '''have inner : B^k *ᵥ (P *ᵥ v)=(P*A^k) *ᵥ v := by rw [Matrix.mulVec_mulVec,hp k]
      rw [inner,Matrix.mulVec_mulVec,← mul_assoc,hSP,one_mul]''')
    candidate=candidate.replace('simpa [sq_abs,mul_pow] using hh','norm_num [sq_abs,mul_pow] at hh ⊢\n      exact hh')
src=folder/f'{key}-route{route}.lean';log=src.with_suffix('.log')
src.write_text('''import MolecularDynamics.Chapter04.Statements
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04EulerStable
set_option maxHeartbeats 400000
'''+ '\n'.join(x['code'] for x in helpers)+'\n'+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch04EulerStable\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout);sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
routes.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,source=src.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(src),log_sha256=sha(log)))
state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(key,route,out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding)[-3400:])
