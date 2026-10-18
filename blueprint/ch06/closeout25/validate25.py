from common25 import *
from collections import Counter
import subprocess

def main():
 baseline=load(OUT/'FROZEN_BASELINE.json')
 changed=[p for p,h in baseline.items() if not (ROOT/p).is_file() or sha(ROOT/p)!=h]
 assert not changed,changed
 formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
 bad=[]
 from packages25 import strip_comments
 for p in formal:
  code=strip_comments(p.read_text(encoding='utf-8-sig'))
  if re.search(r'\bsorry\b|(?m:^\s*(?:unsafe\s+)?axiom\s)',code):bad.append(str(p))
 assert not bad,bad
 rows=load(OUT/'RETURNS.json');assert Counter(r['audit']['verdict'] for r in rows)==dict(PASS=179,FAIL=25,NEEDS_HUMAN=45)
 reps=load(OUT/'REPAIRS.json');assert len(reps)==25 and all(r['exit_code']==0 for r in reps)
 for r in reps:
  key=r['source_id'].split('-')[-1];receipt=load(OUT/'compiled'/(key+'.json'))
  assert receipt['exit_code']==0 and not receipt['missing_axiom_outputs']
  assert sha(OUT/'compiled'/(key+'.log'))==receipt['log_sha256']
 final=load(OUT/'FINAL_COMPILE.json');assert final['exit_code']==0 and final['canonical_sha256']==sha(LEAN)
 assert not final['missing_axiom_outputs'] and final['log_sha256']==sha(OUT/'FINAL_COMPILE.log')
 full=load(OUT/'full/CHECK_REPORT.json');assert full['exit_code']==0 and full['machine_check_status']=='passed' and not full['paused_chapter06']
 assert load(OUT/'FULL_BINDING.json')['canonical_sha256']==sha(LEAN)
 batches=load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json');selection=load(OUT/'REAUDIT_SELECTION.json')['source_ids']
 actual=[]
 for b in batches:
  for sub in b['subtasks']:
   actual.append(sub['source_id']);folder=ROOT/sub['path'];m=load(folder/'MANIFEST.json')
   assert m['paste_sha256']==sha(folder/'PASTE.txt')
   assert m['input_sha256']['Blueprint/Ch06.lean']==sha(LEAN)
   assert m['input_sha256']['blueprint/ch06/ch06_source.json']==sha(BASE/'ch06_source.json')
   assert m['input_sha256']['PAGES.pdf']==sha(folder/'PAGES.pdf')
   assert not m['website_submitted'] and m['total_task_bytes']==sum(p.stat().st_size for p in folder.iterdir())<256000
   paste=(folder/'PASTE.txt').read_text(encoding='utf-8');assert paste.startswith('以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信')
 assert actual==selection
 bp=(ROOT/'docs/review/CH06_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
 for sid in [r['source_id'] for r in rows]:assert '## '+sid+'\n' in bp
 for n in range(1,8):assert len(re.findall(r'(?m)^### '+str(n)+r'\.',bp))==249
 err=(ROOT/'docs/review/CH06_ERRATA.zh-CN.md').read_text(encoding='utf-8');assert '网站审校结论' in err
 mentor=(ROOT/'docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')
 assert not any(w in mentor for w in ['sorryAx','checked+documented priors','字节预算','repair_log','EAUDIT'])
 summary=load(BASE/'WEBSITE_SUMMARY.json');assert summary['repairing']==0
 result=dict(status='PASS',frozen_files=len(baseline),frozen_changed=changed,formal_lean_files=len(formal),formal_sorry=0,formal_axiom=0,first_round=dict(Counter(r['audit']['verdict'] for r in rows)),fail_repaired=25,repairing=0,blueprint_items=249,blueprint_sections_per_item=7,reaudit_batches=len(batches),reaudit_items=len(actual),website_submitted=False,native_sha256=sha(OUT/'FINAL_COMPILE.json'),full_check_sha256=sha(OUT/'full/CHECK_REPORT.json'),lean_sha256=sha(LEAN),unverified=['修改版本的网站复审意见','含sorryAx声明的完整证明','导师对原书疑误及范围的裁定'])
 dump(OUT/'DELIVERY_VALIDATION.json',result);print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)

if __name__=='__main__':main()
