"""Commit only verified raw-return registration and website metadata; no Lean/source changes."""
import re,subprocess
from datetime import datetime
from register_ch01_eaudit01_returns import register,BASE,RAW,RECEIPT
from integrate_website_returns import ROOT,sha,read,dump,integrate
from render_blueprint import render
from refresh_website_baseline import refresh
from local_stage import stage

def finalize():
 frozen={p:sha(ROOT/p) for p in ('Blueprint/Ch01.lean','blueprint/ch01/ch01_source.json','Blueprint/Ch06.lean')}
 register();integrate(1)
 s=read(BASE/'WEBSITE_SUMMARY.json');receipt=read(RECEIPT)
 rows=receipt['items'];bound=[r for r in rows if r['binding']['bound']]
 note=f'第1章EAUDIT01新返回5份已登记；有效历史绑定{len(bound)}/5，原始判定保留，缺绑定列材料待复审；未合并原文或改变Lean。'
 (ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md').write_text(render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
 next_='处理第2章章首3条reaudit FAIL的EAUDIT01修复，原页75–76已重新视觉核对；完成检查/推送后回第6章§6.3.3，不重做§6.3.2。'
 state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines();lines[3]='下一步：'+next_
 summary=f'第1章：网站PASS {s["website_pass"]} / 修复中 {s["repairing"]} / 待导师 {s["awaiting_mentor"]} / 待复审 {s["awaiting_reaudit"]}。'
 lines=[summary if x.startswith('第1章：网站PASS ') else x for x in lines]
 if note not in lines:lines.insert(8,note)
 state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
 for rel in ('AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md'):
  p=ROOT/rel;p.write_text(re.sub(r'^下一步：.*$','下一步：'+next_,p.read_text(encoding='utf-8'),count=1,flags=re.M),encoding='utf-8')
 log=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';heading=f'## {datetime.now().date()} 第1章：EAUDIT01新返回登记'
 if heading not in log.read_text(encoding='utf-8'):
  with log.open('a',encoding='utf-8') as f:f.write('\n'+heading+'\n'+note+'\n下一步：第2章章首修复，随后回第6章§6.3.3；本次只有返回/元数据，复用现有Lean检查，heartbeat不变。\n')
 table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';text=table.read_text(encoding='utf-8')
 if note not in text:table.write_text(text+'\n网站新返回检查点：'+note+'\n',encoding='utf-8')
 for p,h in frozen.items():assert sha(ROOT/p)==h,p
 paths=[f'blueprint/ch01/{name}' for name in ('PROGRESS.md','local_audit.json','website_audit.json','NEEDS_HUMAN.md','WEBSITE_SUMMARY.json','SOURCE_REVIEW_QUEUE.json')]
 paths += [p.relative_to(ROOT).as_posix() for p in RAW.glob('EAUDIT01_*_result.json')]+[RECEIPT.relative_to(ROOT).as_posix(),'docs/review/CH01_BLUEPRINT.zh-CN.md']
 paths.append('scripts/integrate_website_returns.py')
 refresh(RECEIPT.relative_to(ROOT).as_posix(),paths)
 paths += ['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',
  'blueprint/ch06/BASELINE.json','scripts/integrate_website_returns.py','scripts/register_ch01_eaudit01_returns.py','scripts/finalize_ch01_eaudit01_registration.py']
 stage(paths,allow_ch01_return=True)
 staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
 assert not any(p.startswith(('Blueprint/','MolecularDynamics/')) for p in staged),staged
 subprocess.run(['git','commit','-m','ch01: register five EAUDIT01 returns with historical hash checks'],cwd=ROOT,check=True)
 subprocess.run(['git','push'],cwd=ROOT,check=True);print(note)

if __name__=='__main__':finalize()
