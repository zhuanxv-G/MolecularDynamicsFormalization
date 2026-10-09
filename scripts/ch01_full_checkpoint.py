"""Save a verified section checkpoint without staging unrelated work."""
import sys,json,subprocess
from pathlib import Path
from ch01_full_data import ROOT,BASE
from ch01_full_tools import mark_checked,sync
from render_blueprint import render

section, report, next_step=sys.argv[1:4]
rp=ROOT/report
assert json.loads((rp/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))['machine_check_status']=='passed'
mark_checked(rp/'blueprint_axiom_dependencies.log');sync()
out=ROOT/'docs/review/CH01_BLUEPRINT.zh-CN.md'
out.write_text(render(BASE/'ch01_source.json',ROOT/'Blueprint/Ch01.lean',BASE/'local_audit.json'),encoding='utf-8')
state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md'
text=state.read_text(encoding='utf-8');i=text.index('下一步：');j=text.index('\n',i)
text=text[:i]+'下一步：'+next_step+text[j:];state.write_text(text,encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write(f'\n## 2026-10-09 第1章全章：§{section}检查点\n逐字JSON/忠实Blueprint/本地自审/批次包更新；完整check及逐条公理审计通过，正式库不改。\n下一步：{next_step}；网站未返回，heartbeat原样。\n')
paths=['Blueprint/Ch01.lean','blueprint/ch01','scripts/ch01_full_data.py','scripts/ch01_full_tools.py',
       'scripts/ch01_full_checkpoint.py','scripts/render_blueprint.py','docs/review/CH01_BLUEPRINT.zh-CN.md',
       'docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md']
subprocess.run(['git','add',*paths],cwd=ROOT,check=True)
logs=[str(p.relative_to(ROOT)).replace('\\','/') for p in rp.glob('*.log')]
if logs:subprocess.run(['git','add','-f',*logs],cwd=ROOT,check=True)
subprocess.run(['git','commit','-m',f'ch01 sec{section}: source, faithful blueprints and checked local checkpoint'],cwd=ROOT,check=True)
