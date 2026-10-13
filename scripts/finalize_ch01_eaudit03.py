"""Full Ch01 repair acceptance, licensed baseline refresh, and return to Ch06."""
import json,subprocess,re
from datetime import datetime
from integrate_website_returns import ROOT,sha,read,dump,integrate
from ch01_full_tools import declarations,mark_checked
from render_blueprint import render
from refresh_website_baseline import refresh
from local_stage import stage
BASE=ROOT/'blueprint/ch01';TASK=BASE/'mathcopilot_tasks/EAUDIT03';REPORT=BASE/'validation/EAUDIT03-full'
TARGETS={'MD-1.1.1-MorseMinimum','MD-1.1.1-LengthBond'}

def finalize():
 full=read(REPORT/'CHECK_REPORT.json');assert full['machine_check_status']=='passed'
 for row in full['inputs']:assert sha(ROOT/row['relative_path'])==row['sha256'],row['relative_path']
 for row in full['checks']:assert row['exit_code']==0 and sha(REPORT/row['raw_log'])==row['raw_log_sha256']
 compile_=read(BASE/'validation/EAUDIT03/FINAL_COMPILE.json')
 assert compile_['exit_code']==0 and compile_['input_sha256']==sha(ROOT/'Blueprint/Ch01.lean')
 prep=read(BASE/'mathcopilot_results/EAUDIT03_PREPARATION.json');assert sha(ROOT/'Blueprint/Ch01.lean')==prep['lean_sha256']
 assert sha(BASE/'ch01_source.json')==prep['source_sha256']
 for path,h in prep['raw_returns'].items():assert sha(ROOT/path)==h
 task=read(TASK/'MANIFEST.json')
 for sub in task['subtasks']:
  folder=ROOT/sub['path'];mp=folder/'MANIFEST.json';m=read(mp)
  assert sha(mp)==sub['manifest_sha256'] and sha(folder/'PASTE.txt')==m['paste_sha256']
  total=sum(p.stat().st_size for p in folder.iterdir() if p.is_file());assert total==m['total_task_bytes']==sub['total_bytes']<256000
  assert m['crop_pixel_identity']=='PASS'
  for e in m['dependency_excerpts']:assert sha(ROOT/e['path'])==e['file_sha256']
 audit=read(BASE/'local_audit.json');ds=declarations();changes=[]
 for sid,a in audit['items'].items():
  if sid in TARGETS:
   changes.append(dict(source_id=sid,old_signature_sha256=prep['old_signature_sha256'][sid],new_signature_sha256=ds[sid]['signature_sha256']))
   a.update(verdict='PASS',signature_sha256=ds[sid]['signature_sha256'],checked=False,
     proof_status='placeholder' if 'sorry' in ds[sid]['block'] else 'definition',
     missing='原完整Morse最小值/阱深/实际二阶导数与曲率单调性尚有sorry；不恢复第1章长证明。' if sid.endswith('MorseMinimum') else None,
     explanation='EAUDIT03本地预审：完整最小值、阱深及实际二阶曲率2Da²和固定D的正a严格单调性。' if sid.endswith('MorseMinimum') else
       'EAUDIT03本地预审：真实V3三维EuclideanSpace，主定义实际代入两粒子距离；径向剖面辅助定义保留。')
   correspondence=dict(source='网站FAIL指出全部曲率/实际粒子距离缺项',lean=ds[sid]['name'],note='完整签名补齐；新增计算明确EXTRA，不回填成原书句子；网站复审尚未验证')
   if correspondence not in a['correspondence']:a['correspondence'].append(correspondence)
  else:assert a['signature_sha256']==ds[sid]['signature_sha256'],sid
 dump(BASE/'local_audit.json',audit);mark_checked(REPORT/'blueprint_axiom_dependencies.log')
 for ch in (1,3,2):integrate(ch)
 audit=read(BASE/'local_audit.json');assert all(a['checked'] for a in audit['items'].values())
 assert all(a['final_status']=='incomplete' for a in audit['items'].values() if 'sorryAx' in a['axioms'])
 (ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text(render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
 acceptance=dict(eaudit='EAUDIT03',section='1.1.1',source_ids=prep['source_ids'],mentor_ids=prep['mentor_ids'],signature_changes=changes,
  full_check_sha256=sha(REPORT/'CHECK_REPORT.json'),axiom_count=len(audit['items']),compact_bytes=[s['total_bytes'] for s in task['subtasks']],
  source_pages_verified=[31,32,33,34],website_reaudit='pending',lean_sha256=sha(ROOT/'Blueprint/Ch01.lean'),source_sha256=sha(BASE/'ch01_source.json'),
  historical_batch_files='unchanged',formal_library='unchanged',curvature_proof='incomplete; full statement retained',lj_empirical_choice='awaiting mentor')
 dump(BASE/'validation/EAUDIT03/ACCEPTANCE.json',acceptance)
 registry=read(BASE/'EAUDIT_REGISTRY.json');existing=next((x for x in registry if x['eaudit']=='EAUDIT03'),None)
 if existing:assert existing==acceptance
 else:registry.append(acceptance);dump(BASE/'EAUDIT_REGISTRY.json',registry)
 for path,note in [(BASE/'EAUDIT.md','EAUDIT03：§1.1.1 Morse完整曲率和长度键真实距离已补；Multibody/Heterogeneous补真实V3/pairDistance材料及非碰撞域；LJ经验语义待导师。4份compact已本地验证，网站复审待提交。'),
    (BASE/'mathcopilot_tasks/INDEX.md','## EAUDIT03：§1.1.1修复\n\n[4份compact与实际输出文件要求](EAUDIT03/INDEX.md)。历史BATCH03/04仍保持字节，不代表新签名网站PASS。')]:
  if note not in path.read_text(encoding='utf-8'):
   with path.open('a',encoding='utf-8') as f:f.write('\n'+note+'\n')
 progress=BASE/'PROGRESS.md';lines=progress.read_text(encoding='utf-8').splitlines()
 for i,line in enumerate(lines):
  if line.startswith('| MD-'):
   cells=line.split('|')
   if cells[1].strip() in TARGETS:cells[3]=' 陈述已修；已编译/公理已核 ';lines[i]='|'.join(cells)
 if '## 2026-10-13 EAUDIT03检查点' not in lines:
  lines+=['','## 2026-10-13 EAUDIT03检查点','','§1.1.1两条FAIL补齐完整签名、两条缺材料补实际定义；原页31–34、单文件、全工程、141条公理及4份compact通过。Morse仍incomplete；LJ经验数学选择待导师；网站复审未提交。']
 progress.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 next_='继续第6章§6.3，激活scripts/ch06_section63.py首8条；§6.2完整检查与96条证据复用。下一次本地节提交后处理第3章一批网站修复，再回当前章。'
 state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines();lines[3]='下一步：'+next_
 for ch in (1,3,2):
  s=read(ROOT/f'blueprint/ch{ch:02}/WEBSITE_SUMMARY.json');row=f'第{ch}章：网站PASS {s["website_pass"]} / 修复中 {s["repairing"]} / 待导师 {s["awaiting_mentor"]} / 待复审 {s["awaiting_reaudit"]}。'
  lines=[row if x.startswith(f'第{ch}章：网站PASS ') else x for x in lines]
 note='第1章EAUDIT03：§1.1.1两条签名修复与两条材料补齐；原页/单文件/完整check/141条公理/4份compact已验；LJ经验语义待导师。'
 if note not in lines:lines.insert(9,note)
 state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 for rel in ('AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md'):
  path=ROOT/rel;text=path.read_text(encoding='utf-8');path.write_text(re.sub(r'^下一步：.*$','下一步：'+next_,text,count=1,flags=re.M),encoding='utf-8')
 log=ROOT/'docs/handoff/WORK_LOG.zh-CN.md'
 if '## 2026-10-13 第1章：§1.1.1网站修复EAUDIT03' not in log.read_text(encoding='utf-8'):
  with log.open('a',encoding='utf-8') as f:
   f.write('\n## 2026-10-13 第1章：§1.1.1网站修复EAUDIT03\nMorse曲率/长度键距离签名补齐、两条补材料；原页31–34、单文件/完整check/141条公理/4份compact通过；LJ经验语义待导师，网站复审未提交。\n下一步：回第6章§6.3，复用§6.2证据；下节提交后处理第3章一批，heartbeat不变。\n')
 table=ROOT/'docs/handoff/LOCAL_PIPELINE.md'
 note='网站修复检查点：第1章§1.1.1 EAUDIT03已本地检验，4份复审包；回第6章§6.3。网站计数见CURRENT_STATE。'
 if note not in table.read_text(encoding='utf-8'):
  with table.open('a',encoding='utf-8') as f:f.write('\n'+note+'\n')
 paths=['Blueprint/Ch01.lean','blueprint/ch01/ch01_source.json','blueprint/ch01/EAUDIT.md','blueprint/ch01/EAUDIT_REGISTRY.json',
  'blueprint/ch01/mathcopilot_tasks/INDEX.md','docs/review/CH01_BLUEPRINT.zh-CN.md','blueprint/ch01/mathcopilot_results/EAUDIT03_PREPARATION.json','scripts/integrate_website_returns.py']
 for ch in (1,3,2):paths += [f'blueprint/ch{ch:02}/{n}' for n in ('PROGRESS.md','local_audit.json','website_audit.json','NEEDS_HUMAN.md','WEBSITE_SUMMARY.json','SOURCE_REVIEW_QUEUE.json')]
 for folder in (TASK,BASE/'validation/EAUDIT03',REPORT):paths += [p.relative_to(ROOT).as_posix() for p in folder.rglob('*') if p.is_file()]
 refresh('blueprint/ch01/validation/EAUDIT03/ACCEPTANCE.json',paths)
 paths += ['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',
   'scripts/prepare_ch01_eaudit03.py','scripts/finalize_ch01_eaudit03.py','blueprint/ch06/BASELINE.json']
 stage(paths,allow_ch01_return=True)
 staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
 assert not any(p.startswith(('Blueprint/Ch06.lean','blueprint/ch06/')) and p!='blueprint/ch06/BASELINE.json' for p in staged)
 subprocess.run(['git','commit','-m','ch01 sec1.1.1: restore full curvature and bond objects; prepare EAUDIT03'],cwd=ROOT,check=True)
 subprocess.run(['git','push'],cwd=ROOT,check=True);print('EAUDIT03 committed and pushed; re-audit pending.')

if __name__=='__main__':finalize()
