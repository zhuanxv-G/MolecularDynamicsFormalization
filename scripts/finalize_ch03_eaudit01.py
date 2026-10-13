"""Accept actual fresh Chapter 3 checks, append the EAUDIT and return to Chapter 6."""
import json,re,subprocess
from datetime import datetime
from integrate_website_returns import ROOT,sha,read,dump,integrate
from eaudit_review_tasks import declarations,render_document
from refresh_website_baseline import refresh
from local_stage import stage
BASE=ROOT/'blueprint/ch03';REPORT=BASE/'validation/EAUDIT01-full';TASK=BASE/'mathcopilot_tasks/EAUDIT01'

def finalize():
 full=read(REPORT/'CHECK_REPORT.json');local=read(REPORT/'LOCAL_CHECK_REPORT.json')
 assert full['machine_check_status']==local['machine_check_status']=='passed'
 assert local['shared_check_sha256']==sha(REPORT/'CHECK_REPORT.json')
 for r in (full,local):
  for row in r['inputs']:assert sha(ROOT/row['relative_path'])==row['sha256'],row['relative_path']
  for row in r['checks']:assert row['exit_code']==0 and sha(REPORT/row['raw_log'])==row['raw_log_sha256']
 compile_=read(BASE/'validation/EAUDIT01/FINAL_COMPILE.json')
 assert compile_['exit_code']==0 and compile_['input_sha256']==sha(ROOT/'Blueprint/Ch03.lean')
 prep=read(BASE/'mathcopilot_results/EAUDIT01_PREPARATION.json')
 assert prep['lean_sha256']==sha(ROOT/'Blueprint/Ch03.lean') and prep['source_sha256']==sha(BASE/'ch03_source.json')
 for path,h in prep['raw_returns'].items():assert sha(ROOT/path)==h
 task=read(TASK/'MANIFEST.json')
 for sub in task['subtasks']:
  folder=ROOT/sub['path'];mp=folder/'MANIFEST.json';m=read(mp)
  assert sha(mp)==sub['manifest_sha256'] and sha(folder/'PASTE.txt')==m['paste_sha256']
  total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file());assert total==m['total_task_bytes']==sub['total_bytes']<256000
  assert m['crop_pixel_identity']=='PASS'
  for e in m['dependency_excerpts']:assert sha(ROOT/e['path'])==e['file_sha256']
 ds=declarations(3);audit=read(BASE/'local_audit.json');changes=[]
 for sid,a in audit['items'].items():
  if sid in prep['source_ids']:
   changes.append(dict(source_id=sid,old_signature_sha256=prep['old_signature_sha256'][sid],new_signature_sha256=ds[sid]['signature_sha256']))
   a.update(verdict='PASS',signature_sha256=ds[sid]['signature_sha256'],block_sha256=ds[sid]['block_sha256'],
     direct_placeholder='sorry' in ds[sid]['block'],proof_status='placeholder' if 'sorry' in ds[sid]['block'] else ('definition' if ds[sid]['block'].startswith('def ') else 'local_proof'),
     documented_priors=[],missing='完整流辛性与共同修正Hamiltonian有限匹配组合仍待完整证明；保留sorry，不建设大型理论。' if sid=='MD-3-ModifiedConstruction' else None,
     explanation={'MD-3-ModifiedConstruction':'EAUDIT01本地预审：两方向完整结论，以真实Hamiltonian流辛性及原修正构造命题合取，不把遗漏结论作前提。',
       'MD-3.1-EnergyFailure':'EAUDIT01本地预审：每个Ω>0与非零h的精确能量差、两条例外直线及非守恒见证；完整短证明已验。',
       'MD-3.1-FormalHamiltonian':'EAUDIT01本地预审：显式1≤r，逐系数实际形式Hamiltonian，不断言无限收敛。',
       'MD-3.1-FormalHamiltonianField':'EAUDIT01本地预审：显式1≤r及H/Hj C∞，真实Fréchet梯度逐坐标系数。'}[sid])
   c=dict(source='绑定网站FAIL指出的缺失结论/实际资格',lean=ds[sid]['name'],note='四条完整签名修复及EXTRA已明确；网站仍待复审，原文数学选择未静默裁定。')
   if c not in a['correspondence']:a['correspondence'].append(c)
  else:assert a['signature_sha256']==ds[sid]['signature_sha256'],sid
 log=(REPORT/'chapter_axioms.log').read_text(encoding='utf-8-sig')
 for a in audit['items'].values():
  m=re.search("'"+re.escape(a['lean_decl'])+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log);assert m,a['lean_decl']
  a['axioms']=[x.strip() for x in (m.group(1) or '').split(',') if x.strip()];a['checked']=True
  a['final_status']='incomplete' if 'sorryAx' in a['axioms'] or a['verdict']!='PASS' else ('checked+documented priors' if a.get('documented_priors') else 'self-contained')
  a['transitive_placeholder']='sorryAx' in a['axioms'] and not a['direct_placeholder']
  a['axiom_log']=(REPORT/'chapter_axioms.log').relative_to(ROOT).as_posix()
 dump(BASE/'local_audit.json',audit)
 for ch in (1,3,2):integrate(ch)
 audit=read(BASE/'local_audit.json');assert len(audit['items'])==149 and all(a['checked'] for a in audit['items'].values())
 assert all(a['final_status']=='incomplete' for a in audit['items'].values() if 'sorryAx' in a['axioms'])
 doc=ROOT/'docs/review/CH03_BLUEPRINT.zh-CN.md';doc.write_text(render_document(3),encoding='utf-8')
 acceptance=dict(eaudit='EAUDIT01',section='3–3.1',source_ids=prep['source_ids'],signature_changes=changes,
  lean_sha256=sha(ROOT/'Blueprint/Ch03.lean'),source_sha256=sha(BASE/'ch03_source.json'),full_check_sha256=sha(REPORT/'CHECK_REPORT.json'),
  local_check_sha256=sha(REPORT/'LOCAL_CHECK_REPORT.json'),axiom_count=149,source_pages_verified=[119,120,122],
  compact_bytes=[s['total_bytes'] for s in task['subtasks']],energy_proof='complete new general algebra proof; route2 PASS',
  modified_construction='incomplete; full two-part statement retained',website_reaudit='pending',historical_batch_files='unchanged',formal_library='unchanged')
 dump(BASE/'validation/EAUDIT01/ACCEPTANCE.json',acceptance)
 registry=BASE/'EAUDIT_REGISTRY.json';entries=read(registry) if registry.exists() else [];existing=next((e for e in entries if e['eaudit']=='EAUDIT01'),None)
 if existing:assert existing==acceptance
 else:entries.append(acceptance);dump(registry,entries)
 for path,note in [(BASE/'EAUDIT.md','EAUDIT01：章首/§3.1四条FAIL完整修复；能量差/两条例外直线/非守恒见证已证；构造大定理仍incomplete。原页、单文件、完整check和149条公理以及4份compact已验，网站复审待提交。'),
  (BASE/'mathcopilot_tasks/INDEX.md','## EAUDIT01：章首/§3.1修复\n\n[4份compact及实际输出文件要求](EAUDIT01/INDEX.md)。历史BATCH01/02字节保持，仅绑定原输入，不能表示新签名已网站PASS。')]:
  if not path.exists():path.write_text('# 网站修复复审登记\n',encoding='utf-8')
  if note not in path.read_text(encoding='utf-8'):
   with path.open('a',encoding='utf-8') as f:f.write('\n'+note+'\n')
 progress=BASE/'PROGRESS.md';lines=progress.read_text(encoding='utf-8').splitlines()
 for i,line in enumerate(lines):
  if line.startswith('| MD-'):
   cells=line.split('|')
   if cells[1].strip() in prep['source_ids']:
    a=audit['items'][cells[1].strip()];cells[3]=' 已修/已编译/公理已核 ';cells[-2]=' '+a['proof_status']+' / '+a['final_status']+' ';lines[i]='|'.join(cells)
 if '## 2026-10-13 EAUDIT01检查点' not in lines:lines+=['','## 2026-10-13 EAUDIT01检查点','','四条FAIL完整签名修复；能量一般结论已证，构造大定理仍incomplete；原页119/120/122、单文件、完整check/149条公理及4份compact通过；网站复审未提交。旧DELIVERY_VALIDATION只对应原433a13ca版本，新修复验收见本次ACCEPTANCE.json。']
 progress.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 next_='回第6章§6.3.2，激活scripts/ch06_section632.py的8条OU完整陈述，复用§6.3.1/104条检查结果；该节提交后处理第2章reaudit一批，再回当前章。'
 state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines();lines[3]='下一步：'+next_
 for ch in (1,3,2):
  s=read(ROOT/f'blueprint/ch{ch:02}/WEBSITE_SUMMARY.json');row=f'第{ch}章：网站PASS {s["website_pass"]} / 修复中 {s["repairing"]} / 待导师 {s["awaiting_mentor"]} / 待复审 {s["awaiting_reaudit"]}。'
  lines=[row if x.startswith(f'第{ch}章：网站PASS ') else x for x in lines]
 note='第3章EAUDIT01：四条完整签名修复，一般振子能量差/两条例外直线/不守恒已证；原页/单文件/完整check/149条公理/4份compact已验，网站复审待提交。'
 if note not in lines:lines.insert(9,note)
 state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 for rel in ('AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md'):
  p=ROOT/rel;text=p.read_text(encoding='utf-8');p.write_text(re.sub(r'^下一步：.*$','下一步：'+next_,text,count=1,flags=re.M),encoding='utf-8')
 logpath=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
 if '## 2026-10-13 第3章：章首/§3.1网站修复EAUDIT01' not in logpath.read_text(encoding='utf-8'):
  with logpath.open('a',encoding='utf-8') as f:f.write('\n## 2026-10-13 第3章：章首/§3.1网站修复EAUDIT01\n四条完整签名修复，一般能量/两条例外直线/非守恒已证；原页/单文件/完整check/149条公理/4份compact通过；构造仍sorry，网站待复审。\n下一步：回第6章§6.3.2，复用104条/§6.3.1证据；下节处理第2章reaudit一批，heartbeat不变。\n')
 table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';text=table.read_text(encoding='utf-8');text='\n'.join(x for x in text.splitlines() if not x.startswith('当前网站小批：第3章EAUDIT01'))+'\n'
 note='网站修复检查点：第3章章首/§3.1 EAUDIT01已本地检验，4份复审包；回第6章§6.3.2。历史第3章本地交付433a13ca不覆盖新签名，当前网站修复验收见EAUDIT01/ACCEPTANCE。'
 if note not in text:text+='\n'+note+'\n'
 table.write_text(text,encoding='utf-8')
 paths=['Blueprint/Ch03.lean','blueprint/ch03/ch03_source.json','blueprint/ch03/website_signature_overrides.json',
  'blueprint/ch03/EAUDIT.md','blueprint/ch03/EAUDIT_REGISTRY.json','blueprint/ch03/mathcopilot_tasks/INDEX.md','docs/review/CH03_BLUEPRINT.zh-CN.md',
  'blueprint/ch03/mathcopilot_results/EAUDIT01_PREPARATION.json','scripts/ch03_data.py']
 for ch in (1,3,2):paths += [f'blueprint/ch{ch:02}/{name}' for name in ('PROGRESS.md','local_audit.json','website_audit.json','NEEDS_HUMAN.md','WEBSITE_SUMMARY.json','SOURCE_REVIEW_QUEUE.json')]
 for folder in (TASK,BASE/'validation/EAUDIT01',REPORT):paths += [p.relative_to(ROOT).as_posix() for p in folder.rglob('*') if p.is_file()]
 refresh('blueprint/ch03/validation/EAUDIT01/ACCEPTANCE.json',paths)
 paths += ['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',
  'scripts/eaudit_review_tasks.py','scripts/prepare_ch03_eaudit01.py','scripts/ch03_eaudit_energy_proof.py','scripts/finalize_ch03_eaudit01.py','blueprint/ch06/BASELINE.json']
 stage(paths,allow_ch01_return=True)
 staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
 assert not any(p.startswith(('Blueprint/Ch06.lean','blueprint/ch06/')) and p!='blueprint/ch06/BASELINE.json' for p in staged)
 subprocess.run(['git','commit','-m','ch03 sec3.1: repair full source claims and verify general oscillator energy'],cwd=ROOT,check=True)
 subprocess.run(['git','push'],cwd=ROOT,check=True);print('Ch03 EAUDIT01 committed/pushed; re-audit pending.')

if __name__=='__main__':finalize()
