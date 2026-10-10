"""Check, document and commit one authorized chapter section; never stage other tasks."""
import json,sys,subprocess,re
from datetime import datetime
from local_blueprint import ROOT,pipeline,render,landing
from local_stage import stage
ch=int(sys.argv[1]);section,report,next_step=sys.argv[2:5]
p=pipeline(ch);rp=ROOT/report
full=json.loads((rp/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
local=json.loads((rp/'LOCAL_CHECK_REPORT.json').read_text(encoding='utf-8-sig'))
assert full['machine_check_status']==local['machine_check_status']=='passed'
assert p.sha(rp/'CHECK_REPORT.json')==local['shared_check_sha256']
for r in [full,local]:
    for x in r['inputs']:assert p.sha(ROOT/x['relative_path'])==x['sha256'],x['relative_path']
    for x in r['checks']:assert x['exit_code']==0 and p.sha(rp/x['raw_log'])==x['raw_log_sha256']
p.checked(rp/'chapter_axioms.log');p.generate();render(ch,p)
landing(ch,p,section,'①–⑤§'+section+'已检验')
state=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';lines=state.read_text(encoding='utf-8').splitlines()
lines[3]='下一步：'+next_step
lines.insert(8,f'§{section}检查点：{len(p.RECORDS)}条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。')
state.write_text('\n'.join(lines)+'\n',encoding='utf-8')
for relative in ['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md']:
    path=ROOT/relative;text=path.read_text(encoding='utf-8')
    text=re.sub(r'^下一步：.*$','下一步：'+next_step,text,count=1,flags=re.M)
    path.write_text(text,encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write(f'\n## {datetime.now().date()} 第{ch}章：§{section}检查点\n{len(p.RECORDS)}条JSON/Blueprint/本地预审/compact/7段文档；完整check与逐条公理通过，冻结文件不变。\n下一步：{next_step}；网站待审，原模型及heartbeat调度保留。\n')
p.verify_protected()
paths=['.gitattributes','AGENTS.md','lakefile.toml','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md',f'Blueprint/Ch{ch:02}.lean',f'blueprint/ch{ch:02}',f'docs/review/CH{ch:02}_BLUEPRINT.zh-CN.md',
    'scripts/blueprint_source.py','scripts/local_blueprint.py','scripts/local_stage.py','scripts/local_chapter_check.ps1','scripts/local_checkpoint.py',f'scripts/ch{ch:02}_data.py']
paths += [x.relative_to(ROOT).as_posix() for x in (ROOT/'scripts').glob(f'ch{ch:02}_section*.py') if x.stem in sys.modules]
paths += [x.relative_to(ROOT).as_posix() for x in (ROOT/'scripts').glob(f'ch{ch:02}_short_search*.py')]
paths += [x.relative_to(ROOT).as_posix() for x in (ROOT/'scripts').glob(f'ch{ch:02}_bracket_search*.py')]
stage(paths)
subprocess.run(['git','commit','-m',f'ch{ch:02} sec{section}: faithful local blueprint and checked checkpoint'],cwd=ROOT,check=True)
subprocess.run(['git','push','-u','origin',f'chapter{ch:02}-blueprint'],cwd=ROOT,check=True)
commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';text=table.read_text(encoding='utf-8');old=next(x for x in text.splitlines() if x.startswith(f'| {ch} |'));parts=old.split('|');parts[-3]=' '+commit[:12]+' ';text=text.replace(old,'|'.join(parts));table.write_text(text,encoding='utf-8')
# This live pointer is incorporated by the next small batch/section commit.
print('Committed and pushed',commit,'; live cross-chapter pointer updated.')
