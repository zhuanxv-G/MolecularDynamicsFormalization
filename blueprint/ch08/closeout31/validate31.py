from common31 import *
from ch08_dependency_index import strip_comments,index_project,tokens
from packages31 import closure
from collections import Counter
import subprocess

def main():
 reg=load(OUT/'RETURN_REGISTRATION.json');assert reg['counts']==dict(PASS=74,FAIL=5,NEEDS_HUMAN=24)
 for b in reg['bindings']:assert sha(ROOT/b['path'])==b['sha256'],b['path']
 rows=load(OUT/'RETURNS.json');assert len(rows)==len({r['source_id'] for r in rows})==103
 tasks=load(BASE/'mathcopilot_tasks/MANIFEST.json');oldtasks={t['subtask']:t for b in tasks for t in b['subtasks']}
 for row in rows:
  m=load(ROOT/oldtasks[row['subtask']]['path']/'MANIFEST.json')
  assert row['source_id'] in m['source_ids']
  for k,h in row['input_sha256'].items():assert m['input_sha256'][k]==h
 blob=subprocess.check_output(['git','show','fc19e3d6:Blueprint/Ch08.lean'],cwd=ROOT)
 assert blob.replace(b'\r\n',b'\n')==(OUT/'Ch08.before.lean').read_bytes().replace(b'\r\n',b'\n')
 dump(OUT/'ORIGINAL_COMMIT_BINDING.json',dict(commit='fc19e3d6',working_copy_raw_sha256=sha(OUT/'Ch08.before.lean'),git_blob_sha256=hashlib.sha256(blob).hexdigest(),line_ending_normalized_equal=True,note='Git blob为LF，网站及开工快照绑定的是原工作树CRLF字节；网站input_sha256始终按原始字节验证。'))
 assert len(load(OUT/'REPAIRS.json'))==5 and len(load(OUT/'HUMAN_REPAIRS.json'))==24
 for r in load(OUT/'REPAIRS.json'):
  p=OUT/'compiled'/(r['receipt']+'.json');c=load(p)
  assert c['exit_code']==0 and c['input_sha256']==sha(p.with_suffix('.lean')) and c['log_sha256']==sha(p.with_suffix('.log'))
 final=load(OUT/'FINAL_COMPILE.json');assert final['exit_code']==0 and final['canonical_sha256']==sha(LEAN)
 assert final['input_sha256']==sha(ROOT/final['probe']) and final['log_sha256']==sha(ROOT/final['log'])
 decls=load(OUT/'DECLARATIONS.json');assert len(decls)==396
 assert len({d['name'] for d in decls})==396
 assert {d['name'] for d in decls}=={n for r in load(BASE/'ch08_source.json') for n in r['lean_declarations']}
 for d in decls:
  assert d['status']=='未证' if 'sorryAx' in d['axioms'] else d['status']!='未证'
 formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
 for p in formal:assert not re.search(r'\b(sorry|admit|axiom|unsafe)\b',strip_comments(p.read_text(encoding='utf-8-sig'))),p
 assert not re.search(r'\b(admit|axiom|unsafe|True)\b',strip_comments(LEAN.read_text(encoding='utf-8')))
 # Current hashes, including preexisting user files, must match the pre-edit inventory.
 frozen=load(OUT/'FROZEN_BASELINE.json')
 for p,h in frozen.items():assert sha(ROOT/p)==h,p
 dump(OUT/'FROZEN_BYTE_CHECK.json',dict(status='PASS',files=len(frozen),baseline_sha256=sha(OUT/'FROZEN_BASELINE.json'),scope='MolecularDynamics/正式库、第1–7章Blueprint、全部章目录文件及三份审阅文档；以开工时工作树为准，未覆盖既有无关改动。'))
 report=load(OUT/'full/CHECK_REPORT.json');assert report['machine_check_status']=='passed'
 for p in report['inputs']:assert sha(ROOT/p['relative_path'])==p['sha256'],p['relative_path']
 for c in report['checks']:assert c['exit_code']==0 and sha(OUT/'full'/c['raw_log'])==c['raw_log_sha256'],c['name']
 assert 'sorryAx' not in (OUT/'full/axiom_dependencies.log').read_text(encoding='utf-8-sig')
 pkg=load(OUT/'PACKAGE_VALIDATION.json');assert (pkg['batches'],pkg['subtasks'],pkg['covered_entries'])==(4,10,10)
 assert all(not c['missing'] for c in pkg['checks'])
 index,contexts,allitems=index_project();seen=[];src={s['source_id']:s for s in load(BASE/'ch08_source.json')};gg=groups()
 for batch in load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json'):
  for sub in batch['subtasks']:
   dest=ROOT/sub['path'];m=load(dest/'MANIFEST.json');assert sha(dest/'MANIFEST.json')==sub['manifest_sha256']
   assert m['input_sha256']['Blueprint/Ch08.lean']==sha(LEAN)
   assert m['input_sha256']['blueprint/ch08/ch08_source.json']==sha(BASE/'ch08_source.json')
   for p,h in m['files'].items():assert sha(dest/p)==h['sha256']
   assert m['total_task_bytes']==sum(p.stat().st_size for p in dest.iterdir() if p.is_file())<256000
   sid=m['source_ids'][0];paste=(dest/'PASTE.txt').read_text(encoding='utf-8')
   assert paste.startswith('以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信')
   assert gg[sid]['code'] in paste
   defs=closure(gg[sid]['code'],index)
   assert {d['full_name'] for d in defs}=={d['full_name'] for d in m['definition_excerpts']}
   for d in defs:assert d['code'] in paste,(sid,d['full_name'])
   assert not m['validation']['missing_project_definitions']
   seen.append(sid)
 assert len(seen)==len(set(seen))==10
 assert {s['source_id'] for s in load(OUT/'SCOPE_SELF_CHECK.json')['checks'] if s['signature_changed']} <= set(seen)
 assert set(r['source_id'] for r in rows if r['audit']['verdict']=='FAIL')<=set(seen)
 web=load(BASE/'website_audit.json');assert len(web)==103 and all(r['effective_status'].startswith('待复审 / EAUDIT') for r in web if r['source_id'] in seen)
 summary=load(OUT/'SUMMARY.json');assert summary['repairing']==0 and summary['human_triaged']==24
 assert Counter(d['status'] for d in decls)==summary['declarations']
 for name in ['BLUEPRINT','ERRATA','SUMMARY_FOR_MENTOR']:assert (ROOT/f'docs/review/CH08_{name}.zh-CN.md').exists()
 mentor=(ROOT/'docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')
 assert not any(w in mentor for w in ['sorryAx','input_sha256','heartbeat','EAUDIT','check.ps1','commit','push','哈希','工程'])
 dump(OUT/'DELIVERY_VALIDATION.json',dict(status='PASS',entries=103,repairs=5,human_triaged=24,declarations=396,compile_axioms='PASS',full_check='PASS',formal_files=len(formal),formal_sorry=0,formal_axiom_declarations=0,frozen_files=len(frozen),reaudit_batches=4,reaudit_entries=10,signature_changed_entries=summary['signature_changed'],missing_definitions=0,canonical_sha256=sha(LEAN),source_sha256=sha(BASE/'ch08_source.json'),website_submitted=False))
 print('DELIVERY PASS: 103 entries / 5 repairs / 24 triaged / 4 packs 10 entries / frozen',len(frozen),flush=True)

if __name__=='__main__':main()
