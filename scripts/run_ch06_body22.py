"""Finish the explicitly authorized remaining body, stopping on real diagnostics."""
import subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
plan=[
 ('6.4.2',['ch06_section642'],[], '继续§6.4.3：ch06_section643、ch06_section643b；不进入第7章。'),
 ('6.4.3',['ch06_section643','ch06_section643b'],[], '继续§6.4.4：按ch06_section644至644f顺序；不恢复封存长证明。'),
 ('6.4.4',['ch06_section644','ch06_section644b','ch06_section644c','ch06_section644d','ch06_section644e','ch06_section644f'],
  ['HamiltonianPowerMomentumDerivative','LyapunovYoungBounds','LieBracketProperties'], '继续§6.4.5：ch06_section645；随后补齐22号勘误和章末验收，不进入第7章。'),
 ('6.4.5',['ch06_section645'],['KernelDuality'], '正文全部落盘后完成22号勘误双版本、导师总结和章末完整check；通过并push后停止。'),
]
start=sys.argv[1] if len(sys.argv)>1 else '6.4.2'
for section,modules,proofs,next_step in plan:
 if section<start:continue
 command=[sys.executable,'-u','scripts/local_advance_ch06.py',section,*modules]
 if proofs:command+=['--proofs',*proofs]
 command+=['--next',next_step]
 print('START SECTION',section,flush=True)
 result=subprocess.run(command,cwd=ROOT)
 if result.returncode:raise SystemExit(result.returncode)
print('BODY CHECKPOINTS FINISHED; ERRATA AND FINAL ACCEPTANCE STILL REQUIRED',flush=True)
