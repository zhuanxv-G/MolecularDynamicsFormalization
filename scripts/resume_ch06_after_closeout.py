"""Resume Ch6 only after the human confirms the Ch1 closeout is complete."""
import hashlib,json,subprocess
from pathlib import Path
from local_stage import stage
ROOT=Path(__file__).resolve().parents[1]
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
bpath=ROOT/'blueprint/ch06/BASELINE.json';b=json.loads(bpath.read_text(encoding='utf-8'))
delivery=ROOT/'blueprint/ch01/validation/CLOSEOUT19/DELIVERY_VALIDATION.json'
d=json.loads(delivery.read_text(encoding='utf-8'))
assert d['repairing']==0 and d['full_check']=='passed'
assert sha(ROOT/'Blueprint/Ch01.lean')==d['lean_sha256']
assert sha(ROOT/'blueprint/ch01/ch01_source.json')==d['source_sha256']
changes=[]
for rel,h in b['protected'].items():
    actual=sha(ROOT/rel)
    if h==actual:continue
    assert rel.startswith(('Blueprint/Ch01.lean','blueprint/ch01/','docs/review/CH01_')),rel
    subprocess.run(['git','diff','--quiet','HEAD','--',rel],cwd=ROOT,check=True)
    changes.append(dict(path=rel,before_sha256=h,accepted_sha256=actual))
    b['protected'][rel]=actual
for rel in ('blueprint/ch01/validation/CLOSEOUT19/DELIVERY_VALIDATION.json',
            'docs/review/CH01_ERRATA.zh-CN.md','docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md'):
    subprocess.run(['git','diff','--quiet','HEAD','--',rel],cwd=ROOT,check=True)
    b['protected'][rel]=sha(ROOT/rel)
receipt=ROOT/'blueprint/ch06/validation/RESUME_AFTER_CH01_20261016.json'
assert not receipt.exists()
accept=ROOT/'blueprint/ch06/validation/SECTION633_ACCEPTANCE_20261016.json'
for rel,h in json.loads(accept.read_text(encoding='utf-8'))['inputs'].items():assert sha(ROOT/rel)==h,rel
record=dict(authorization='用户：第一章已经弄完了，继续第六章',accepted_head=head,
    chapter1_delivery_sha256=sha(delivery),accepted_committed_ch01_changes=changes,
    reused_ch06_section633_acceptance_sha256=sha(accept),formal_library='unchanged',
    scope='Chapter6 local steps only; Chapters1-5 frozen; no Chapter7',
    next='Activate section635 (8 entries); full preflight28 already passed; do not repeat identical checks.',
    heartbeat='not modified or claimed tested by this resume script')
receipt.write_text(json.dumps(record,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
b.setdefault('resume_snapshots',[]).append(dict(receipt=receipt.relative_to(ROOT).as_posix(),sha256=sha(receipt),accepted_head=head))
bpath.write_text(json.dumps(b,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
task='当前任务：继续完成第6章本地①–⑤流程；第1–5章已完成交付保持冻结，不进入第7章。'
next_='下一步：从已验132条继续§6.3.4–6.4.5；激活ch06_section635.py下一8条，核对并复用完整预编译收据。'
scope='''本次用户明确恢复第6章，覆盖19号对第6章的暂停。正式库字节冻结、0 sorry，固定Lean/Mathlib v4.34.0。
每批≤8条落盘/单文件编译，每节完整check、逐声明公理检查、文档和commit+push；复用通过证据。
仅本地PASS证明；现成桥接优先，单条三次失败或缺大型理论则保留sorry并记录，不恢复封存证明。
Thm6.1/6.2/Prop6.4无整条现成桥接则sorry。网站仅生成compact及完整包，不提交，统一待网站审计。
全部本地流程完成后停止于第6章；第1–5章网站复审/导师裁定仍待用户处理。
'''
for rel,title in [('AGENTS.md','# 当前任务与约定'),('docs/handoff/CURRENT_STATE.zh-CN.md','# 当前可操作状态'),('docs/handoff/RESUME_PROMPT.zh-CN.md','# 接续提示词')]:
    p=ROOT/rel;old=p.read_text(encoding='utf-8')
    p.write_text(title+'\n\n'+task+'\n'+next_+'\n\n'+scope+'\n## 历史状态（暂停已由本次用户明确恢复）\n\n'+old,encoding='utf-8')
p=ROOT/'docs/handoff/LOCAL_PIPELINE.md';lines=p.read_text(encoding='utf-8').splitlines()
lines[0]=task
for i,line in enumerate(lines):
    if line.startswith('| 6 |'):
        c=line.split('|');c[4]=' ⑤§6.3.3已验132条；恢复后续本地流程 ';lines[i]='|'.join(c)
p.write_text('\n'.join(lines)+'\n',encoding='utf-8')
p=ROOT/'blueprint/ch06/PROGRESS.md';s=p.read_text(encoding='utf-8')
s=s.replace('下一步：按用户确认的19号指令暂停第6章；保留现有检查结果，不启动证明、编译或后续批次，等待明确恢复指令。',next_)
p.write_text(s,encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-16 第1章交付后恢复第6章\n第1章收口与第2–5章已完成快照核对并冻结；132条§6.3.3收据复用，正式库不变。\n下一步：激活下一8条；恢复第6章本地流程，覆盖19号暂停，不进入第7章。\n')
paths=['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md',
       'docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',
       'blueprint/ch06/BASELINE.json','blueprint/ch06/PROGRESS.md','blueprint/ch06/local_audit.json',
       'docs/review/CH06_BLUEPRINT.zh-CN.md',receipt.relative_to(ROOT).as_posix(),
       accept.relative_to(ROOT).as_posix(),'blueprint/ch06/validation/PAUSE_CONFIRMED_20261016.json',
       'blueprint/ch06/validation/section633-resume1/LOCAL_CHECK_REPORT.json',
       'scripts/resume_ch06_after_closeout.py']
stage(paths)
subprocess.run(['git','commit','-m','ch06: resume after accepted ch01 closeout; retain checked 132-entry checkpoint'],cwd=ROOT,check=True)
subprocess.run(['git','push'],cwd=ROOT,check=True)
print('Resumed Chapter6; accepted committed Ch1 changes:',len(changes))
