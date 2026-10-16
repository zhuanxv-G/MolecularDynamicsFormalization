"""Final acceptance: actual compiler receipts, original reports and unchanged protected bytes."""
from pathlib import Path
import json, hashlib, re, subprocess
ROOT=Path(__file__).resolve().parents[4];BASE=ROOT/'blueprint/ch01';OUT=BASE/'validation/CLOSEOUT21'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
def load(p):return json.loads(p.read_text(encoding='utf-8-sig'))
def dump(p,d):p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def main():
 full=load(OUT/'full/CHECK_REPORT.json')
 assert full['machine_check_status']=='passed' and full['exit_code']==0
 assert full['paused_chapter06']
 for f in full['inputs']:assert sha(ROOT/f['relative_path'])==f['sha256'],f['relative_path']
 for c in full['checks']:assert c['exit_code']==0 and sha(OUT/'full'/c['raw_log'])==c['raw_log_sha256'],c['name']
 protected=load(OUT/'FROZEN_INPUTS.json')
 for p,h in protected.items():assert sha(ROOT/p)==h,p
 for p in (ROOT/'MolecularDynamics').rglob('*.lean'):
  assert not re.search(r'\b(sorry|admit|axiom|unsafe)\b',p.read_text(encoding='utf-8-sig')),p
 repairs=load(OUT/'REPAIRS.json');assert len(repairs)==10
 for r in repairs:
  assert r['exit_code']==0 and sha(OUT/(r['key']+'.log'))==r['log_sha256']
  assert r['suggested_fix']==r['original_fail']['suggested_fix']
 assert repairs[-1]['input_sha256']==sha(ROOT/'Blueprint/Ch01.lean')
 packets=load(OUT/'EAUDIT_PACKETS_BEFORE.json');now={p.relative_to(ROOT).as_posix():sha(p) for p in (BASE/'mathcopilot_tasks').rglob('*') if p.is_file()}
 assert set(packets)==set(now)
 assert [p for p in packets if packets[p]!=now[p]]==['blueprint/ch01/mathcopilot_tasks/EAUDIT_INDEX.md']
 website=load(BASE/'website_audit.json');wb={w['source_id']:w for w in website};raw={}
 reg=load(OUT/'RETURN_REGISTRATION.json')
 for b in reg['batches']:
  p=BASE/'mathcopilot_results/eaudit'/(b['batch']+'_result.json');assert sha(p)==b['result_sha256']
  for item in load(p)['items']:raw[item['source_id']]=item
 assert len(raw)==93 and len(wb)==141
 for sid,item in raw.items():assert wb[sid]['closeout21_return']==item,sid
 for r in repairs:
  w=wb[r['source_id']];assert w['effective_status']=='按网站审校意见修复，本地核验通过（未再送网站）'
  assert w['local_repair21']['suggested_fix']==raw[r['source_id']]['audit']['suggested_fix']
 summary=load(BASE/'WEBSITE_SUMMARY.json');assert (summary['website_pass'],summary['locally_repaired_not_resubmitted'],summary['awaiting_mentor'],summary['repairing'])==(110,10,21,0)
 ds=load(OUT/'DECLARATION_STATUS.json');assert len(ds)==206
 printed=re.findall(r'(?m)^#print axioms MD\.Ch01\.(\w+)',(ROOT/'Blueprint/Ch01.lean').read_text(encoding='utf-8'));assert len(printed)==206 and set(printed)==set(ds)
 assert sum(d['transitive_placeholder'] for d in ds.values())==46
 es=(ROOT/'docs/review/CH01_ERRATA.zh-CN.md').read_text(encoding='utf-8');assert es.count('- 网站复审结论：')==22
 assert all(sid in es for sid,item in raw.items() if item['audit']['verdict']=='NEEDS_HUMAN')
 mentor=(ROOT/'docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8');assert not any(s in mentor for s in ['sorry','checked+documented priors','字节预算'])
 assert load(OUT/'MENTOR_SUMMARY_LAYOUT.json')['pages']<=2
 # No changes to the four delivered chapters, including their source JSONs.
 for n in range(2,6):
  paths=[f'Blueprint/Ch{n:02}.lean',f'blueprint/ch{n:02}/ch{n:02}_source.json',f'docs/review/CH{n:02}_BLUEPRINT.zh-CN.md']
  assert not subprocess.check_output(['git','diff','--name-only','--',*paths],cwd=ROOT,text=True)
 d=dict(status='local_final_acceptance_passed',website_pass=110,latest_return_counts=reg['counts'],local_repairs_not_resubmitted=10,awaiting_mentor=21,errata_records=22,repairing=0,new_website_packages=0,full_check='passed',full_check_report_sha256=sha(OUT/'full/CHECK_REPORT.json'),lean_sha256=sha(ROOT/'Blueprint/Ch01.lean'),source_sha256=sha(BASE/'ch01_source.json'),formal_library_sorry=0,frozen_inputs=len(protected),declarations=load(OUT/'DECLARATION_COUNTS.json'),single_file_compiles=10,all_declarations_axiom_checked=206,raw_returns_preserved=93,mathematical_scope_check=load(OUT/'MATHEMATICAL_SCOPE_CHECK.json'),heartbeat_end_to_end='NOT_TESTED',not_verified=['修复后网站复审（用户决定不再进行）','导师裁定','46项未证陈述'],chapter6='148条已验证检查点f32c2974后暂停；不自动恢复')
 dump(OUT/'DELIVERY_VALIDATION.json',d)
 meta=load(OUT/'METADATA_FINALIZED.json');meta.update(full_check='passed',source_sha256=d['source_sha256']);dump(OUT/'METADATA_FINALIZED.json',meta)
 print('FINAL ACCEPTANCE PASSED: 10 repairs, 206 axioms, full check, 302 frozen files, raw returns and no new review packets.')
if __name__=='__main__':main()
