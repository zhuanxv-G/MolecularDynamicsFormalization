"""A concrete symplectic-Euler reversal counterexample; three routes maximum."""
import sys,json,subprocess,hashlib
from ch03_data import ROOT,BASE,RECORDS
route=int(sys.argv[1]);assert 1<=route<=3
key='SymplecticNotReversible'
r=next(x for x in RECORDS if x['source_id'].endswith('-'+key));assert r['local_verdict']=='PASS'
folder=BASE/'validation/short_search';state=folder/(key+'.json')
routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in routes):raise SystemExit('Reuse saved evidence')
candidate='''have hf : ∀ q : Q 1, textbookPotentialForce (fun x : Q 1 => x 0^2/2) q = fun i => -q i := by
    intro q
    have hd := ((hasFDerivAt_apply (0 : Fin 1) q).pow 2).div_const 2
    funext i
    fin_cases i
    simp [textbookPotentialForce, hd.fderiv]
  refine ⟨1, ((fun _ => 1), (fun _ => 0)), ?_⟩
  intro he
  have hc := congrFun he (Sum.inl (0 : Fin 1))
  norm_num [textbookSymplecticEuler, Function.comp_apply, textbookMomentumKick,
    textbookPositionDrift, textbookPositionProjection, canonicalReversal, pack, hf] at hc'''
if route==2:candidate=candidate.replace('have hd := ((hasFDerivAt_apply (0 : Fin 1) q).pow 2).div_const 2','have hd := ((hasFDerivAt_apply (0 : Fin 1) q).pow 2).const_mul (1/2 : ℝ)').replace('simp [textbookPotentialForce, hd.fderiv]','have heq : (fun x : Q 1 => x 0^2/2) = fun x => (1/2 : ℝ)*x 0^2 := by funext x; ring\n    rw [textbookPotentialForce, heq, hd.fderiv]\n    simp')
if route==3:
    candidate=candidate.replace('have hd := ((hasFDerivAt_apply (0 : Fin 1) q).pow 2).div_const 2',
        '''have hp : HasFDerivAt (fun x : Q 1 => x 0) (ContinuousLinearMap.proj (0 : Fin 1)) q :=
      hasFDerivAt_apply 0 q
    have hd := (hp.pow 2).const_mul (1/2 : ℝ)''').replace('simp [textbookPotentialForce, hd.fderiv]',
        '''have heq : (fun x : Q 1 => x 0^2/2) = fun x => (1/2 : ℝ)*x 0^2 := by funext x; ring
    rw [textbookPotentialForce, heq, hd.fderiv]
    simp''').replace('Sum.inl (0 : Fin 1)','Sum.inr (0 : Fin 1)')
src=folder/f'{key}-route{route}.lean';log=src.with_suffix('.log')
src.write_text('''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology
noncomputable section
namespace MD.Ch03Counter
set_option maxHeartbeats 400000
'''+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch03Counter\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout);sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
routes.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,source=src.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(src),log_sha256=sha(log)))
state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(key,route,out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding)[-2400:])
