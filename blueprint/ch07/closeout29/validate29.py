from common29 import *
from ch07_dependency_index import strip_comments

def main():
 reg=load(OUT/'RETURN_REGISTRATION.json');assert reg['counts']==dict(PASS=66,FAIL=28,NEEDS_HUMAN=24)
 assert len(load(OUT/'REPAIRS.json'))==28 and len(load(OUT/'HUMAN_REPAIRS.json'))==24
 assert load(OUT/'SCOPE_SELF_CHECK.json')['total']==118
 final=load(OUT/'compiled/FINAL-CURRENT.json');assert final['exit_code']==0 and final['canonical_sha256']==sha(LEAN)
 assert final['input_sha256']==sha(OUT/'compiled/FINAL-CURRENT.lean')
 assert final['log_sha256']==sha(OUT/'compiled/FINAL-CURRENT.log')
 # Every initial repair has immutable compiler evidence for its repaired block.
 for r in load(OUT/'REPAIRS.json'):
  q=OUT/'compiled'/(r['receipt']+'.json');v=load(q)
  assert v['exit_code']==0 and v['input_sha256']==sha(q.with_suffix('.lean')) and v['log_sha256']==sha(q.with_suffix('.log'))
 formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
 for p in formal:assert not re.search(r'\b(sorry|admit|axiom|unsafe)\b',strip_comments(p.read_text(encoding='utf-8-sig'))),p
 assert not re.search(r'\b(admit|axiom|unsafe|True)\b',strip_comments(LEAN.read_text(encoding='utf-8')))
 for rel,h in load(OUT/'FROZEN_BASELINE.json').items():assert sha(ROOT/rel)==h,rel
 report=load(OUT/'full/CHECK_REPORT.json');assert report['machine_check_status']=='passed'
 for i in report['inputs']:assert sha(ROOT/i['relative_path'])==i['sha256'],i
 for c in report['checks']:assert c['exit_code']==0 and sha(OUT/'full'/c['raw_log'])==c['raw_log_sha256'],c
 packages=load(OUT/'PACKAGE_VALIDATION.json');assert packages['covered_entries']==packages['subtasks'] and all(not c['missing'] for c in packages['checks'])
 seen=[]
 for b in load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json'):
  for sub in b['subtasks']:
   dest=ROOT/sub['path'];m=load(dest/'MANIFEST.json');assert sha(dest/'MANIFEST.json')==sub['manifest_sha256']
   assert m['input_sha256']['Blueprint/Ch07.lean']==sha(LEAN)
   assert m['input_sha256']['blueprint/ch07/ch07_source.json']==sha(BASE/'ch07_source.json')
   for p,h in m['files'].items():assert sha(dest/p)==h['sha256']
   assert not m['validation']['missing_project_definitions']
   assert (dest/'PASTE.txt').read_text(encoding='utf-8').startswith('以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信')
   assert m['total_task_bytes']==sum(p.stat().st_size for p in dest.iterdir() if p.is_file())<256000
   seen+=m['source_ids']
 assert len(seen)==len(set(seen))==packages['covered_entries']
 summary=load(OUT/'SUMMARY.json');assert summary['repairing']==0
 for name in ['BLUEPRINT','ERRATA','SUMMARY_FOR_MENTOR']:
  assert (ROOT/f'docs/review/CH07_{name}.zh-CN.md').exists()
 dump(OUT/'DELIVERY_VALIDATION.json',dict(status='PASS',entries=118,repairs=28,human_triaged=24,
   compile_axioms='PASS',full_check='PASS',formal_files=len(formal),formal_sorry=0,formal_axiom_declarations=0,
   frozen_files=len(load(OUT/'FROZEN_BASELINE.json')),reaudit_batches=packages['batches'],reaudit_entries=len(seen),missing_definitions=0,
   canonical_sha256=sha(LEAN),source_sha256=sha(BASE/'ch07_source.json'),website_submitted=False))
 print('DELIVERY PASS',packages['batches'],len(seen),flush=True)

if __name__=='__main__':main()
