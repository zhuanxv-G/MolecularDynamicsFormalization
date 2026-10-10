"""Commit a checked Chapter 2 section and push only the task's explicit files."""
import json,sys,subprocess
from datetime import datetime
from zoneinfo import ZoneInfo
from ch02_pipeline import ROOT,BASE,checked,generate,verify_protected
from render_ch02_blueprint import render
from ch02_stage import stage
section,report,next_step=sys.argv[1:4]
day=datetime.now(ZoneInfo('Asia/Shanghai')).strftime('%Y-%m-%d')
rp=ROOT/report
data=json.loads((rp/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
assert data['machine_check_status']=='passed'
for x in data['inputs']:
    from ch02_pipeline import sha
    assert sha(ROOT/x['relative_path'])==x['sha256'],x['relative_path']
checked(rp/'chapter02_axiom_dependencies.log');generate()
out=ROOT/'docs/review/CH02_BLUEPRINT.zh-CN.md'
out.write_text(render(BASE/'ch02_source.json',ROOT/'Blueprint/Ch02.lean',BASE/'local_audit.json'),encoding='utf-8')
state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
lines[3]='下一步：'+next_step
lines[8:8]=[f'§{section}检查点：{len(json.loads((BASE/"ch02_source.json").read_text(encoding="utf-8")))}条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。']
state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write(f'\n## {day} 第2章：§{section}检查点\nJSON/Blueprint/本地预审/compact包与7段文档已生成；完整check和逐条公理通过，第1章与正式库字节不变。\n下一步：{next_step}；网站待审，heartbeat原样。\n')
verify_protected()
paths=['.gitattributes','AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md',
       'Blueprint/Ch02.lean','blueprint/ch02','docs/review/CH02_BLUEPRINT.zh-CN.md','lakefile.toml','scripts/check.ps1',
       'scripts/ch02_bootstrap.py','scripts/ch02_data.py','scripts/ch02_pipeline.py','scripts/ch02_checkpoint.py','scripts/ch02_stage.py','scripts/render_ch02_blueprint.py']
paths += [p.relative_to(ROOT).as_posix() for p in (ROOT/'scripts').glob('ch02_section*.py') if p.stem in sys.modules]
stage(paths)
staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
assert not any(p.startswith(('output/','tmp/','docs/review/check-full06/','scripts/__pycache__/','blueprint/ch01/','MolecularDynamics/','docs/review/CH01_')) for p in staged)
subprocess.run(['git','commit','-m',f'ch02 sec{section}: faithful sources and verified local blueprint checkpoint'],cwd=ROOT,check=True)
subprocess.run(['git','push','-u','origin','chapter02-blueprint'],cwd=ROOT,check=True)
print('Checkpoint committed and pushed; protected files unchanged.')
