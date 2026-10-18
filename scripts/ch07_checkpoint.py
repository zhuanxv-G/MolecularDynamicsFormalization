"""Record a completed section, commit only authorized chapter-7 files, and push."""
from ch07_pipeline import *
import argparse
p=argparse.ArgumentParser();p.add_argument('section');p.add_argument('next');args=p.parse_args()
assert json.loads((BASE/f'validation/section{args.section.replace(".","")}/CHECK_REPORT.json').read_text(encoding='utf-8'))['machine_check_status']=='passed'
verify_frozen();message=f'第7章§{args.section}检查点：{len(RECORDS)}条已落盘，本地单文件与逐声明公理核验通过；本节完整检查复用输入不变的正式库证据并核验当前全章源码。'
for name in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
    file=ROOT/name;s=file.read_text(encoding='utf-8')
    start=s.index('## 27号运行检查点');end=s.index('## 历史规则与状态',start)
    s=s[:start]+'## 27号运行检查点\n\n'+message+'\n下一步：'+args.next+'；不进入第8章。\n\n'+s[end:]
    file.write_text(s,encoding='utf-8')
(ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('# 第27号第7章接续\n\n先读AGENTS、CURRENT_STATE顶部、WORK_LOG最新及blueprint/ch07/PROGRESS.md，先git status，复用已通过证据。\n'+message+'\n下一步：'+args.next+'；第1–6章冻结，不进入第8章。\n网站任务包只生成，不提交、不等待网站。\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-18 第27号§'+args.section+'检查点\n'+message+'\n下一步：'+args.next+'；网站尚未审阅，不进入第8章。\n')
(BASE/'LOCAL_PIPELINE.md').write_text('# 第7章本地五步流程\n\n'+message+'\n下一步：'+args.next+'。\n原文JSON → Lean陈述 → 目视原页逐条对照 → 单文件与逐声明公理 → 文档。\n',encoding='utf-8')
files=['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','Blueprint/Ch07.lean','blueprint/ch07','docs/review/CH07_BLUEPRINT.zh-CN.md']
files += [p.relative_to(ROOT).as_posix() for p in (ROOT/'scripts').glob('ch07_*.py')]
subprocess.run(['git','add','--',*files],cwd=ROOT,check=True)
logs=[p.relative_to(ROOT).as_posix() for p in (BASE/'validation').rglob('*.log')]
if logs:subprocess.run(['git','add','-f','--',*logs],cwd=ROOT,check=True)
staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
for name in staged:
    assert name.casefold() in {p.casefold() for p in files} or name.casefold().startswith('blueprint/ch07/'),('Unrelated staged file',name)
subprocess.run(['git','commit','-m',f'ch07: section {args.section} local checkpoint ({len(RECORDS)} items)'],cwd=ROOT,check=True)
subprocess.run(['git','push','-u','origin','chapter07-blueprint'],cwd=ROOT,check=True)
print('COMMITTED AND PUSHED',args.section,flush=True)
