from common26 import *
from collections import Counter
def main():
 baseline=load(OUT/'FROZEN_BASELINE.json')
 changed=[p for p,h in baseline.items() if not (ROOT/p).is_file() or sha(ROOT/p)!=h];assert not changed,changed
 formal=list((ROOT/'MolecularDynamics').rglob('*.lean'));bad=[]
 for p in formal:
  if re.search(r'\b(sorry|admit|unsafe)\b|(?m:^\s*axiom\s)',strip_comments(p.read_text(encoding='utf-8-sig'))):bad.append(p.relative_to(ROOT).as_posix())
 assert not bad,bad
 returns=load(OUT/'RETURNS.json');assert Counter(r['audit']['verdict'] for r in returns)==dict(PASS=25,FAIL=8,NEEDS_HUMAN=27)
 for b in load(OUT/'RETURN_REGISTRATION.json')['bindings']:assert sha(ROOT/b['path'])==b['sha256']
 reps=load(OUT/'REPAIRS.json');assert len(reps)==8
 for r in reps:
  assert r['exit_code']==0 and not r['missing_axiom_outputs']
  p=OUT/'compiled'/(r['source_id'].split('-')[-1]+'.json');d=load(p)
  assert d['log_sha256']==sha(p.with_suffix('.log'))
  assert d['input_sha256']==sha(p.with_suffix('.lean'))
  assert (ROOT/r['diff_file']).is_file()
 final=load(OUT/'FINAL_COMPILE.json');assert final['exit_code']==0 and not final['missing_axiom_outputs']
 assert final['input_sha256']==sha(OUT/'FINAL_COMPILE.lean') and final['canonical_sha256']==sha(LEAN) and final['log_sha256']==sha(OUT/'FINAL_COMPILE.log')
 full=load(OUT/'full/CHECK_REPORT.json');assert full['machine_check_status']=='passed' and full['exit_code']==0 and not full['paused_chapter06']
 assert load(OUT/'FULL_BINDING.json')['canonical_sha256']==sha(LEAN)
 src=load(BASE/'ch06_source.json');gg=groups();assert len(src)==len(gg)==249
 summary=load(BASE/'WEBSITE_SUMMARY.json');assert summary['repairing']==summary['awaiting_reaudit']==0 and summary['website_pass']==203 and summary['local_repairs']==8
 assert summary['current_lean_sha256']==sha(LEAN)
 assert all('versions26' in w for w in load(BASE/'website_audit.json'))
 for w in load(BASE/'website_audit.json'):
  if w.get('closeout26_return',{}).get('audit',{}).get('verdict')=='FAIL':
   assert w['audit']['verdict']=='FAIL' and w['closeout26_return']['audit']['suggested_fix']==w['local_repair26']['suggested_fix']
   assert w['effective_status']=='按网站审校意见修复，本地核验通过（未再送网站）'
 theorem62=next(s for s in src if s['source_id'].endswith('-Theorem62'))
 assert theorem62['statement_latex'].count('\\kappa')==2 and '$k$' not in theorem62['statement_latex']
 assert next(s for s in src if s['source_id'].endswith('-Lemma61Printed'))['kind']=='lemma'
 assert 'theorem theorem61Printed :' not in LEAN.read_text(encoding='utf-8')
 decls=load(OUT/'DECLARATIONS.json');assert len(decls)==len(final['declarations'])==sum(summary['declarations'].values())
 assert sum(d['status']=='未证' for d in decls)==sum(summary['unproved_reasons'].values())
 bp=(ROOT/'docs/review/CH06_BLUEPRINT.zh-CN.md').read_text(encoding='utf-8')
 for s in src:assert '## '+s['source_id']+'\n' in bp and gg[s['source_id']]['code'] in bp
 for n in range(1,8):assert len(re.findall(r'(?m)^### '+str(n)+r'\.',bp))==249
 err=(ROOT/'docs/review/CH06_ERRATA.zh-CN.md').read_text(encoding='utf-8');assert err.count('- 网站复审结论：')>=40
 for g in load(OUT/'ERRATA_INDEX.json'):
  for sid in g['source_ids']:assert sid in err
 mentor=(ROOT/'docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')
 assert not any(t in mentor for t in ['sorryAx','checked+documented priors','字节预算','repair_log','EAUDIT','等待用户','target','heartbeat'])
 assert all(str(n) in mentor for n in [203,8,summary['declarations']['已证'],summary['declarations']['未证']])
 import tomllib
 heartbeat=tomllib.loads(Path(r'C:\Users\ustc\.codex\automations\lean-2\automation.toml').read_text(encoding='utf-8-sig'))
 assert heartbeat['status']=='ACTIVE' and heartbeat['rrule']=='FREQ=MINUTELY;INTERVAL=15' and heartbeat['target_thread_id']=='01a10bc0-bc8d-7043-8df9-21a6b0bde09a'
 assert heartbeat['prompt'].startswith('按26号继续第6章收口。') and '第26号全文第5节全部完成' in heartbeat['prompt'] and '每个失败轮最多成功发送一次' in heartbeat['prompt']
 result=dict(status='PASS',frozen_files=len(baseline),frozen_changed=changed,formal_lean_files=len(formal),formal_sorry=0,formal_axiom=0,reaudit=dict(PASS=25,FAIL=8,NEEDS_HUMAN=27),latest_website_pass=203,fail_repaired=8,repairing=0,blueprint_items=249,blueprint_sections_per_item=7,declarations=summary['declarations'],unproved_reasons=summary['unproved_reasons'],errata=summary['errata'],context_records=summary['context_records'],new_eaudit_packages=0,website_resubmitted=False,final_compile_sha256=sha(OUT/'FINAL_COMPILE.json'),full_check_sha256=sha(OUT/'full/CHECK_REPORT.json'),lean_sha256=sha(LEAN),unverified=['八项修复后的再次网站审校（按用户决定不进行）','未证声明的完整证明','导师对原书疑误和限定解释的裁定','heartbeat额度中断自动接续端到端行为'])
 dump(OUT/'DELIVERY_VALIDATION.json',result);print(json.dumps(result,ensure_ascii=False,indent=2),flush=True)
if __name__=='__main__':main()
