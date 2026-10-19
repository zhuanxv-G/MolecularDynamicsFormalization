from pathlib import Path
import sys,re,json,hashlib,subprocess
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'closeout31'))
from common31 import ROOT,load,dump,sha,groups
sys.path.insert(0,str(ROOT/'scripts'))
from ch08_dependency_index import strip_comments
OUT=Path(__file__).resolve().parent;BASE=OUT.parent
reg=load(OUT/'RETURN_REGISTRATION.json');assert reg['counts']==dict(PASS=2,FAIL=0,NEEDS_HUMAN=8)
for b in reg['bindings']:assert sha(ROOT/b['path'])==b['sha256']
assert sha(ROOT/'Blueprint/Ch08.lean')==reg['lean_sha256']=='a58849c40e30a4a6b189163f42a49e0cbdf00bd48a39a77048bfd04ff88f8a16'
assert sha(OUT/'ch08_source.before.json')=='c7fea45d785f740f26c7b50c5e37abd14cb1a8b05b51f4e7ad215cd5059ebdd5'
old=load(OUT/'ch08_source.before.json');src=load(BASE/'ch08_source.json');assert len(src)==len(old)==103
immutable=['source_id','kind','label','section','printed_page','pdf_page','statement_verbatim','original_page_text','numbered_equations','lean_declarations']
for r,o in zip(src,old):
 for k in immutable:assert r.get(k)==o.get(k),(r['source_id'],k)
 current=json.dumps({k:r.get(k) for k in ['issues','extra_assumptions','context_notation','coverage_gaps','transcription_note','source_page_verification']},ensure_ascii=False)
 assert not re.search(r'R4[_：]|R5[_：]|只是未组装|尚未组装成|delta取H_N',current),r['source_id']
web=load(BASE/'website_audit.json');assert len(web)==103
assert all(w['audit']==w['closeout32_return']['audit'] and w['json_review']==w['closeout32_return']['json_review'] for w in web if 'closeout32_return' in w)
for w in web:
 assert w['actual_scope']==next(r for r in src if r['source_id']==w['source_id'])['statement_scope']
 assert not w['effective_status'].startswith('待复审')
assert not subprocess.check_output(['git','diff','--','Blueprint/Ch08.lean'],cwd=ROOT)
canonical=strip_comments((ROOT/'Blueprint/Ch08.lean').read_text(encoding='utf-8-sig'))
assert len(re.findall(r'\bgeneralizedFeedback_stationaryPrinted\b',canonical))==1
dump(OUT/'PRINTED_DEPENDENCY_CHECK.json',dict(status='PASS',name='MD.Ch08.generalizedFeedback_stationaryPrinted',canonical_occurrences=1,scope='Ch08去注释正文只出现本身声明，没有其他条目引用其为有效定理；已证/未证按公理依赖另行统计。'))
final=load(BASE/'closeout31/FINAL_COMPILE.json')
assert final['exit_code']==0 and final['canonical_sha256']==sha(ROOT/'Blueprint/Ch08.lean')
assert sha(ROOT/final['probe'])==final['input_sha256'] and sha(ROOT/final['log'])==final['log_sha256']
decls=load(BASE/'closeout31/DECLARATIONS.json');assert len(decls)==396
assert {d['name'] for d in decls}=={n for r in src for n in r['lean_declarations']}
assert all((d['status']=='未证')==('sorryAx' in d['axioms']) for d in decls)
dump(OUT/'COMPILE_AXIOMS_REUSE.json',dict(status='PASS',declarations=396,lean_sha256=sha(ROOT/'Blueprint/Ch08.lean'),receipt='blueprint/ch08/closeout31/FINAL_COMPILE.json',receipt_sha256=sha(BASE/'closeout31/FINAL_COMPILE.json'),probe_sha256=final['input_sha256'],log_sha256=final['log_sha256'],reason='本轮Lean原始字节未变，复用已通过单文件编译和396声明逐条公理证据；本轮另执行一次完整check。'))
formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
for p in formal:assert not re.search(r'\b(sorry|admit|axiom|unsafe)\b',strip_comments(p.read_text(encoding='utf-8-sig'))),p
for p in load(OUT/'PDF_VISUAL_CHECKS.json')['pages']:assert sha(ROOT/p['image'])==p['sha256']
frozen=load(OUT/'FROZEN_BASELINE.json');diff=[]
if '--reuse-frozen' in sys.argv:
 receipt=load(OUT/'FROZEN_BYTE_CHECK.json')
 assert receipt['status']=='PASS' and receipt['files']==len(frozen) and receipt['baseline_sha256']==sha(OUT/'FROZEN_BASELINE.json')
 print('FROZEN: 已通过17010文件逐字核验，后续仅改第8章文档及收口脚本；复用本轮证据。',flush=True)
else:
 for i,(p,h) in enumerate(frozen.items(),1):
  if sha(ROOT/p)!=h:diff.append(p)
  if i%4000==0:print('FROZEN',i,'/',len(frozen),flush=True)
 assert not diff,diff
 dump(OUT/'FROZEN_BYTE_CHECK.json',dict(status='PASS',files=len(frozen),baseline_sha256=sha(OUT/'FROZEN_BASELINE.json'),scope='正式库、第1–7章全部现存文件（含本轮之前的无关改动）、Ch08.lean及既有网站包字节一致。'))
report=load(OUT/'full/CHECK_REPORT.json');assert report['machine_check_status']=='passed'
for p in report['inputs']:assert sha(ROOT/p['relative_path'])==p['sha256'],p['relative_path']
for c in report['checks']:assert c['exit_code']==0 and sha(OUT/'full'/c['raw_log'])==c['raw_log_sha256'],c['name']
assert 'sorryAx' not in (OUT/'full/axiom_dependencies.log').read_text(encoding='utf-8-sig')
summary=load(OUT/'SUMMARY.json');assert summary['repairing']==summary['awaiting_reaudit']==summary['local_repairs']==0
assert summary['declarations']==dict(定义=285,已证=54,未证=57)
assert summary['unproved_reasons']==dict(缺大型理论=44,原书疑误不证=10,时间盒止=3)
assert len(load(OUT/'ERRATA_INDEX.json'))==31
err=(ROOT/'docs/review/CH08_ERRATA.zh-CN.md').read_text(encoding='utf-8');assert err.count('- 网站复审结论：')==31
mentor=(ROOT/'docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md').read_text(encoding='utf-8')
assert not any(w in mentor for w in ['sorryAx','heartbeat','EAUDIT','check.ps1','commit','push','哈希','工程','待用户'])
summary.update(full_check_passed=True,full_check_report_sha256=sha(OUT/'full/CHECK_REPORT.json'))
dump(OUT/'SUMMARY.json',summary);dump(BASE/'WEBSITE_SUMMARY.json',summary)
dump(OUT/'DELIVERY_VALIDATION.json',dict(status='PASS',instruction=32,entries=103,reaudit=dict(PASS=2,FAIL=0,NEEDS_HUMAN=8),latest_website_pass=76,latest_needs_human=27,repairing=0,metadata_updates=10,lean_changed=False,declarations=396,proved=54,unproved=57,formal_files=len(formal),formal_sorry=0,formal_axiom_declarations=0,frozen_files=len(frozen),compile_axioms='PASS (unchanged-byte receipt verified)',full_check='PASS (new run)',canonical_sha256=sha(ROOT/'Blueprint/Ch08.lean'),source_sha256=sha(BASE/'ch08_source.json'),new_eaudit_packages=0,website_resubmitted=False,mentor_decisions='pending',remaining_proofs=57))
print('DELIVERY PASS',flush=True)
