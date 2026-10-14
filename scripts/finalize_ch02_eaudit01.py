"""Accept Ch02 whole-file/native checks for three complete source repairs and return to Ch06."""
import re,subprocess,sys
from datetime import datetime
from integrate_website_returns import ROOT,sha,read,dump,integrate
from eaudit_review_tasks import declarations,render_document
from refresh_website_baseline import refresh
from local_stage import stage
BASE=ROOT/'blueprint/ch02';REPORT=BASE/'validation/EAUDIT01-full';TASK=BASE/'mathcopilot_tasks/EAUDIT01'
if len(sys.argv)>1:REPORT=ROOT/sys.argv[1]

def finalize():
 full=read(REPORT/'CHECK_REPORT.json');assert full['machine_check_status']=='passed'
 for x in full['inputs']:assert sha(ROOT/x['relative_path'])==x['sha256'],x['relative_path']
 for x in full['checks']:assert x['exit_code']==0 and sha(REPORT/x['raw_log'])==x['raw_log_sha256']
 assert {'blueprint_fresh_Ch02','chapter02_axiom_dependencies'}<={x['name'] for x in full['checks']}
 compiled=read(BASE/'validation/EAUDIT01/FINAL_COMPILE.json');assert compiled['exit_code']==0 and compiled['input_sha256']==sha(ROOT/'Blueprint/Ch02.lean')
 prep=read(BASE/'mathcopilot_results/EAUDIT01_PREPARATION.json');assert prep['lean_sha256']==sha(ROOT/'Blueprint/Ch02.lean') and prep['source_sha256']==sha(BASE/'ch02_source.json')
 for p,h in prep['raw_returns'].items():assert sha(ROOT/p)==h
 manifest=read(TASK/'MANIFEST.json')
 for sub in manifest['subtasks']:
  folder=ROOT/sub['path'];m=read(folder/'MANIFEST.json')
  assert sha(folder/'MANIFEST.json')==sub['manifest_sha256'] and sha(folder/'PASTE.txt')==m['paste_sha256']
  assert sum(p.stat().st_size for p in folder.iterdir() if p.is_file())==sub['total_bytes']==m['total_task_bytes']<256000
  assert m['crop_pixel_identity']=='PASS'
  for x in m['dependency_excerpts']:assert sha(ROOT/x['path'])==x['file_sha256']
 audit=read(BASE/'local_audit.json');ds=declarations(2);assert len(audit['items'])==160
 log=(REPORT/'chapter02_axiom_dependencies.log').read_text(encoding='utf-8-sig')
 changes=[]
 for sid,a in audit['items'].items():
  if sid in prep['source_ids']:
   changes.append(dict(source_id=sid,old_signature_sha256=prep['old_signature_sha256'][sid],new_signature_sha256=ds[sid]['signature_sha256']))
   a.update(signature_sha256=ds[sid]['signature_sha256'],block_sha256=ds[sid]['block_sha256'],direct_placeholder=False,proof_status='definition',verdict='PASS',compiled=True,documented_priors=[],missing=None)
   c=dict(source='原全部机械ODE/可逆质量/给定流和单步域',lean=ds[sid]['name'],note='EAUDIT01完整签名修复；定义和实际对象资格已核，网站C复审未返回。')
   if c not in a['correspondence']:a['correspondence'].append(c)
  else:assert a['signature_sha256']==ds[sid]['signature_sha256'],sid
  m=re.search("'"+re.escape(a['lean_decl'])+r"' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)",log);assert m,a['lean_decl']
  a.update(axioms=[x.strip() for x in (m.group(1) or '').split(',') if x.strip()],checked=True,axiom_log=(REPORT/'chapter02_axiom_dependencies.log').relative_to(ROOT).as_posix())
  a['final_status']='incomplete' if 'sorryAx' in a['axioms'] or a['verdict']!='PASS' else ('checked+documented priors' if a.get('documented_priors') else 'self-contained')
  a['transitive_placeholder']='sorryAx' in a['axioms'] and not a['direct_placeholder']
 dump(BASE/'local_audit.json',audit)
 for ch in (1,3,2):integrate(ch)
 (ROOT/'docs/review/CH02_BLUEPRINT.zh-CN.md').write_text(render_document(2),encoding='utf-8')
 acceptance=dict(eaudit='EAUDIT01',section='2',source_ids=prep['source_ids'],signature_changes=changes,lean_sha256=prep['lean_sha256'],source_sha256=prep['source_sha256'],
  full_check_sha256=sha(REPORT/'CHECK_REPORT.json'),single_file_compile_sha256=sha(BASE/'validation/EAUDIT01/FINAL_COMPILE.json'),axiom_count=160,source_pages_verified=[75,76],
  compact_bytes=[s['total_bytes'] for s in manifest['subtasks']],website_reaudit='pending',historical_batches='unchanged',formal_library='unchanged',
  scope='经典可微机械ODE全部分量及J形式、显式正质量、正规相空间实际流及完整单步/迭代关联；无额外精度定理或存在性宣称')
 ap=BASE/'validation/EAUDIT01/ACCEPTANCE.json';dump(ap,acceptance)
 registry=BASE/'EAUDIT_REGISTRY.json';entries=read(registry) if registry.exists() else []
 existing=next((e for e in entries if e['eaudit']=='EAUDIT01'),None)
 if existing:assert existing==acceptance
 else:entries.append(acceptance);dump(registry,entries)
 note='EAUDIT01：章首3条reaudit FAIL完整修复；原页75–76、单文件、完整check/160条公理、3份compact通过；仅定义，未新增定量误差或实际解存在证明，网站复审待提交。'
 for path,text in ((BASE/'EAUDIT.md',note),(BASE/'mathcopilot_tasks/INDEX.md','## EAUDIT01：章首3条修复\n\n[3份compact及实际输出要求](EAUDIT01/INDEX.md)。旧BATCH保留绑定原快照，当前修复待网站复审。')):
  if not path.exists():path.write_text('# 网站修复复审登记\n',encoding='utf-8')
  if text not in path.read_text(encoding='utf-8'):
   with path.open('a',encoding='utf-8') as f:f.write('\n'+text+'\n')
 progress=BASE/'PROGRESS.md';lines=[x for x in progress.read_text(encoding='utf-8').splitlines() if not x.startswith('当前网站小批：EAUDIT01')]
 for i,line in enumerate(lines):
  if line.startswith('| MD-') and line.split('|')[1].strip() in prep['source_ids']:
   cells=line.split('|');a=audit['items'][cells[1].strip()];cells[3]=' 已修/已编译/公理已核 ';cells[-2]=' definition / '+a['final_status']+' ';lines[i]='|'.join(cells)
 if note not in lines:lines+=['',note,'历史DELIVERY_VALIDATION仅对应8ca2ccf原版本；当前修复验收见validation/EAUDIT01/ACCEPTANCE.json。']
 progress.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 next_='回第6章§6.3.3，激活scripts/ch06_section633.py首8条热浴完整陈述；复用112条/§6.3.2检查和方差积分证明。节提交后继续第1章一批网站修复，不恢复封存长证明。'
 state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines();lines[3]='下一步：'+next_
 for ch in (1,3,2):
  s=read(ROOT/f'blueprint/ch{ch:02}/WEBSITE_SUMMARY.json');row=f'第{ch}章：网站PASS {s["website_pass"]} / 修复中 {s["repairing"]} / 待导师 {s["awaiting_mentor"]} / 待复审 {s["awaiting_reaudit"]}。';lines=[row if x.startswith(f'第{ch}章：网站PASS ') else x for x in lines]
 state_note='第2章'+note
 if state_note not in lines:lines.insert(8,state_note)
 state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 for rel in ('AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md'):
  p=ROOT/rel;p.write_text(re.sub(r'^下一步：.*$','下一步：'+next_,p.read_text(encoding='utf-8'),count=1,flags=re.M),encoding='utf-8')
 heading=f'## {datetime.now().date()} 第2章：章首网站修复EAUDIT01';work=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
 if heading not in work.read_text(encoding='utf-8'):
  with work.open('a',encoding='utf-8') as f:f.write('\n'+heading+'\n'+note+'\n下一步：回第6章§6.3.3，复用112条；heartbeat不变，网站复审未提交。\n')
 table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';text='\n'.join(x for x in table.read_text(encoding='utf-8').splitlines() if not x.startswith('当前网站小批：第2章EAUDIT01'))+'\n'
 if state_note not in text:table.write_text(text+'\n网站修复检查点：'+state_note+'\n',encoding='utf-8')
 paths=['Blueprint/Ch02.lean','blueprint/ch02/ch02_source.json','blueprint/ch02/website_signature_overrides.json','blueprint/ch02/EAUDIT.md','blueprint/ch02/EAUDIT_REGISTRY.json',
  'blueprint/ch02/mathcopilot_tasks/INDEX.md','blueprint/ch02/mathcopilot_results/EAUDIT01_PREPARATION.json','docs/review/CH02_BLUEPRINT.zh-CN.md','scripts/eaudit_review_tasks.py']
 for ch in (1,3,2):paths += [f'blueprint/ch{ch:02}/{name}' for name in ('PROGRESS.md','local_audit.json','website_audit.json','NEEDS_HUMAN.md','WEBSITE_SUMMARY.json','SOURCE_REVIEW_QUEUE.json')]
 for folder in (TASK,BASE/'validation/EAUDIT01',REPORT):paths += [p.relative_to(ROOT).as_posix() for p in folder.rglob('*') if p.is_file()]
 refresh(ap.relative_to(ROOT).as_posix(),paths)
 paths+=['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',
  'blueprint/ch06/BASELINE.json','scripts/prepare_ch02_eaudit01.py','scripts/finalize_ch02_eaudit01.py']
 stage(paths,allow_ch01_return=True)
 staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
 assert not any(p.startswith(('MolecularDynamics/','Blueprint/Ch06.lean')) or (p.startswith('blueprint/ch06/') and p!='blueprint/ch06/BASELINE.json') for p in staged)
 subprocess.run(['git','commit','-m','ch02 sec2: restore complete mechanical ODE and actual one-step flow objects'],cwd=ROOT,check=True)
 subprocess.run(['git','push'],cwd=ROOT,check=True);print('Ch02 EAUDIT01 committed and pushed; re-audit pending.')

if __name__=='__main__':finalize()
