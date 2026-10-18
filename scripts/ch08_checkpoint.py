"""Record a completed section, commit only authorized chapter-8 files, and push."""
from ch08_pipeline import *
import argparse
p=argparse.ArgumentParser();p.add_argument('section');p.add_argument('next');args=p.parse_args()
assert json.loads((BASE/f'validation/section{args.section.replace(".","")}/CHECK_REPORT.json').read_text(encoding='utf-8'))['machine_check_status']=='passed'
verify_frozen();message=f'第8章§{args.section}检查点：{len(RECORDS)}条已落盘，本地单文件与逐声明公理核验通过；本节完整检查复用输入不变的正式库证据并核验当前全章源码。'
for name in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
    file=ROOT/name;s=file.read_text(encoding='utf-8')
    start=s.index('## 28号运行检查点');end=s.index('## 历史规则与状态',start)
    s=s[:start]+'## 28号运行检查点\n\n'+message+'\n下一步：'+args.next+'；不做附加章节。\n\n'+s[end:]
    file.write_text(s,encoding='utf-8')
(ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('# 第28号第8章接续\n\n先读AGENTS、CURRENT_STATE顶部、WORK_LOG最新及blueprint/ch08/PROGRESS.md，先git status，复用已通过证据。\n'+message+'\n下一步：'+args.next+'；第1–7章冻结，不做附加章节。\n网站任务包只生成，不提交、不等待网站。\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-18 第28号§'+args.section+'检查点\n'+message+'\n下一步：'+args.next+'；网站尚未审阅，不做附加章节。\n')
(BASE/'LOCAL_PIPELINE.md').write_text('# 第8章本地五步流程\n\n'+message+'\n下一步：'+args.next+'。\n原文JSON → Lean陈述 → 目视原页逐条对照 → 单文件与逐声明公理 → 文档。\n',encoding='utf-8')
files=['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','Blueprint/Ch08.lean','blueprint/ch08','docs/review/CH07_BLUEPRINT.zh-CN.md']
files += [p.relative_to(ROOT).as_posix() for p in (ROOT/'scripts').glob('ch08_*.py')]
# Normalize only chapter-8 metadata index paths on the case-insensitive filesystem.
for line in subprocess.check_output(['git','ls-files','--stage'],cwd=ROOT,text=True).splitlines():
    meta,name=line.split('\t',1)
    if name.startswith('Blueprint/ch08/'):
        mode,blob,stage=meta.split();assert stage=='0'
        subprocess.run(['git','update-index','--force-remove','--',name],cwd=ROOT,check=True)
        subprocess.run(['git','update-index','--add','--cacheinfo',mode,blob,'blueprint/ch08/'+name[len('Blueprint/ch08/'):]],cwd=ROOT,check=True)
subprocess.run(['git','-c','core.ignorecase=false','add','--',*files],cwd=ROOT,check=True)
logs=[p.relative_to(ROOT).as_posix() for p in (BASE/'validation').rglob('*.log')]
if logs:subprocess.run(['git','-c','core.ignorecase=false','add','-f','--',*logs],cwd=ROOT,check=True)
staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
for name in staged:
    assert name.casefold() in {p.casefold() for p in files} or name.casefold().startswith('blueprint/ch08/'),('Unrelated staged file',name)
subprocess.run(['git','commit','-m',f'ch08: section {args.section} local checkpoint ({len(RECORDS)} items)'],cwd=ROOT,check=True)
subprocess.run(['git','push','-u','origin','chapter08-blueprint'],cwd=ROOT,check=True)
print('COMMITTED AND PUSHED',args.section,flush=True)
