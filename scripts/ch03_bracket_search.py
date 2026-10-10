"""Three bounded routes for the actual mechanical Poisson double bracket."""
import subprocess,json,sys
from local_blueprint import pipeline,ROOT
p=pipeline(3);r=next(x for x in p.RECORDS if x['source_id']=='MD-3.3.4-PotentialDoubleBracket')
assert r['local_verdict']=='PASS'
routes=[
'''intro n m U hm hU z
  rw [textbookPoissonBracket_coordinates]
  simp [grad, invMass, unpack, pack, quadraticKinetic,
    textbookPoissonBracket_coordinates]
  ring''',
'''intro n m U hm hU z
  simp_rw [textbookPoissonBracket_coordinates]
  dsimp [grad, invMass, unpack, pack, quadraticKinetic]
  simp [fderiv_fun_sum, fderiv_comp, fderiv_const_mul, fderiv_fun_mul,
    Pi.single_apply]
  ring''',
'''intro n m U hm hU z
  have hDU := hU.differentiable (by norm_num)
  have hgrad : ContDiff ℝ 1 (grad U) := by
    unfold grad
    fun_prop
  simp_rw [textbookPoissonBracket_coordinates]
  simp [grad, invMass, unpack, pack, quadraticKinetic, fderiv_comp,
    fderiv_fun_sum, fderiv_const_mul, fderiv_fun_mul, Pi.single_apply]
  ring''']
folder=p.BASE/'validation/short_search';folder.mkdir(exist_ok=True)
state=folder/'PotentialDoubleBracket.json';results=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
route=int(sys.argv[1]);assert 1<=route<=3
if any(x['exit_code']==0 or x['route']==route for x in results):print('Saved result already exists; do not repeat.');raise SystemExit(0)
source=folder/f'PotentialDoubleBracket-route{route}.lean';log=source.with_suffix('.log')
header='''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology
noncomputable section
namespace MD.Ch03BracketSearch
set_option maxHeartbeats 200000
'''
source.write_text(header+r['code'].replace('by\n  sorry','by\n  '+routes[route-1])+'\nend MD.Ch03BracketSearch\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(source.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout)
results.append(dict(route=route,exit_code=out.returncode,proof=routes[route-1] if out.returncode==0 else None,source=source.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=p.sha(source),log_sha256=p.sha(log)))
p.dump(state,results);print('PotentialDoubleBracket route',route,'exit',out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace')[-1200:])
