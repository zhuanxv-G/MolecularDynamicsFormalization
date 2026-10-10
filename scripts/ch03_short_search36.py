"""Finite partitioned stage transport; at most three saved routes."""
import sys,json,subprocess,hashlib
from ch03_data import ROOT,BASE,RECORDS
import ch03_section36c
r=next(x for x in RECORDS if x['source_id']=='MD-3.6.2-PartitionedAffine');assert r['local_verdict']=='PASS'
route=int(sys.argv[1]);assert 1<=route<=3
folder=BASE/'validation/short_search';folder.mkdir(exist_ok=True)
state=folder/'PartitionedAffine.json';results=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
if any(x['exit_code']==0 or x['route']==route for x in results):raise SystemExit('Reuse existing route; no repeat.')
candidate='''intro n s Lq Lp fq fp Aq Ap bq bp h z w Fq Fp hq hp hw
  have tq : ∀ a : Fin s → ℝ,
      Lq.symm (Lq z.1+h • ∑ j, a j • Lq (Fq j)) = z.1+h • ∑ j, a j • Fq j := by
    intro a
    apply Lq.injective
    simp
  have tp : ∀ a : Fin s → ℝ,
      Lp.symm (Lp z.2+h • ∑ j, a j • Lp (Fp j)) = z.2+h • ∑ j, a j • Fp j := by
    intro a
    apply Lp.injective
    simp
  refine ⟨?_, ?_, ?_⟩
  · intro i
    rw [tq, tp]
    exact congrArg Lq (hq i)
  · intro i
    rw [tq, tp]
    exact congrArg Lp (hp i)
  · rw [hw]
    simp'''
if route==2:candidate=candidate.replace('    simp','    simp only [ContinuousLinearEquiv.apply_symm_apply, map_add, map_smul, map_sum]')
if route==3:candidate=candidate.replace('    simp','    simp [map_sum, map_smul, map_add]')
source=folder/f'PartitionedAffine-route{route}.lean';log=source.with_suffix('.log')
source.write_text('''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03Short36
set_option maxHeartbeats 400000
'''+r['code'].replace('by\n  sorry','by\n  '+candidate)+'\nend MD.Ch03Short36\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(source.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout);sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
results.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,
    source=source.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=sha(source),log_sha256=sha(log)))
state.write_text(json.dumps(results,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print('PartitionedAffine route',route,'exit',out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace').encode(sys.stdout.encoding,errors='replace').decode(sys.stdout.encoding)[-3200:])
