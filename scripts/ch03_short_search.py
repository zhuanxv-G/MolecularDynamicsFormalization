"""Bounded finite algebra search; only local PASS entries, at most three routes."""
from pathlib import Path
import sys,json,subprocess
from local_blueprint import pipeline,ROOT
p=pipeline(3);r=next(x for x in p.RECORDS if x['source_id']=='MD-3.3.2-StrangCubic')
assert r['local_verdict']=='PASS'
folder=p.BASE/'validation/short_search';folder.mkdir(exist_ok=True)
routes=[
'''intro R _ _ A B
  norm_num [formalLog, formalStrang, textbookFormalOperatorExponential,
    PowerSeries.coeff_mk, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Nat.factorial_succ, pow_succ, Finset.sum_Icc_succ_top]
  simp only [commutator, mul_add, add_mul, mul_sub, sub_mul,
    smul_mul_assoc, mul_smul_comm, smul_add, smul_sub, smul_smul]
  module''',
'''intro R _ _ A B
  norm_num [formalLog, formalStrang, textbookFormalOperatorExponential,
    PowerSeries.coeff_mk, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Nat.factorial_succ, pow_succ, Finset.sum_Icc_succ_top, commutator,
    mul_add, add_mul, mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
    smul_add, smul_sub, smul_smul]
  module''',
'''intro R _ _ A B
  norm_num [formalLog, formalStrang, textbookFormalOperatorExponential,
    PowerSeries.coeff_mk, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Nat.factorial_succ, pow_succ, Finset.sum_Icc_succ_top, commutator,
    mul_add, add_mul, mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
    smul_add, smul_sub, smul_smul]
  simp only [mul_assoc]
  module''']
state=folder/'StrangCubic.json';results=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
route=int(sys.argv[1]);assert 1<=route<=3
if any(x['exit_code']==0 for x in results):print('Already proved; reuse saved proof.');raise SystemExit(0)
if any(x['route']==route for x in results):print('Route already recorded; do not repeat.');raise SystemExit(0)
source=folder/f'StrangCubic-route{route}.lean';log=source.with_suffix('.log')
candidate=routes[route-1]
if route>=2:candidate=candidate.replace('commutator,','MolecularDynamics.Chapter03Review.commutator,')
body=r['code'].replace('by\n  sorry','by\n  '+candidate)
header='''import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology
noncomputable section
namespace MD.Ch03Short
set_option maxHeartbeats 400000
'''
source.write_text(header+body+'\nend MD.Ch03Short\n',encoding='utf-8')
out=subprocess.run(['lake','env','lean',str(source.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log.write_bytes(out.stdout)
results.append(dict(route=route,exit_code=out.returncode,proof=candidate if out.returncode==0 else None,
    source=source.relative_to(ROOT).as_posix(),log=log.relative_to(ROOT).as_posix(),source_sha256=p.sha(source),log_sha256=p.sha(log)))
p.dump(state,results)
print('StrangCubic route',route,'exit',out.returncode)
if out.returncode:print(out.stdout.decode('utf-8',errors='replace')[-3000:])
