"""Resume only chapter 6 against the accepted chapter 2--5 repair snapshot."""
import hashlib,json,subprocess
from pathlib import Path
from datetime import datetime
from local_stage import stage
ROOT=Path(__file__).resolve().parents[1]
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def dump(p,x):p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
baseline=ROOT/'blueprint/ch06/BASELINE.json';b=json.loads(baseline.read_text(encoding='utf-8'))
accepted=ROOT/'docs/handoff/REPAIR_DELIVERY_VALIDATION.json'
delivery=json.loads(accepted.read_text(encoding='utf-8'))
for ch in range(2,6):
 row=delivery['chapters'][str(ch)]
 assert row['repairing']==0
 assert digest(ROOT/f'Blueprint/Ch{ch:02}.lean')==row['lean_sha256']
 assert digest(ROOT/f'blueprint/ch{ch:02}/ch{ch:02}_source.json')==row['source_sha256']
changes=[]
for rel,expected in b['protected'].items():
 current=digest(ROOT/rel)
 if expected==current:continue
 assert not rel.startswith('MolecularDynamics/'),rel
 assert rel.startswith(('Blueprint/Ch02.lean','Blueprint/Ch03.lean','blueprint/ch02/','blueprint/ch03/','docs/review/CH02_','docs/review/CH03_')) or rel=='scripts/eaudit_review_tasks.py',rel
 subprocess.run(['git','diff','--exit-code','HEAD','--',rel],cwd=ROOT,check=True,stdout=subprocess.DEVNULL)
 changes.append(dict(path=rel,before_sha256=expected,accepted_sha256=current))
 b['protected'][rel]=current
for ch in range(1,6):
 for rel in (f'Blueprint/Ch{ch:02}.lean',f'blueprint/ch{ch:02}/ch{ch:02}_source.json',f'blueprint/ch{ch:02}/local_audit.json',f'blueprint/ch{ch:02}/old_mapping.json'):
  if (ROOT/rel).exists():b['protected'][rel]=digest(ROOT/rel)
receipt=ROOT/'blueprint/ch06/validation/RESUME_20261016.json'
assert not receipt.exists(),'Immutable resume receipt already exists; do not rewrite.'
dump(receipt,dict(authorization='用户2026-10-16：第2–5章审核已完成，继续完成第6章',accepted_head=head,
 accepted_repair_delivery_sha256=digest(accepted),previous_baseline_sha256=digest(baseline),accepted_committed_repairs=changes,
 formal_library_hashes='unchanged',chapter6_wip='6b822a9a524f',last_passed_batch=26,
 next='batch27 has no result and its recorded parent/compiler are gone; preserve record and compile a new receipt',
 sealed_proofs='never restored',heartbeat='not changed by this script'))
b.setdefault('resume_snapshots',[]).append(dict(receipt=receipt.relative_to(ROOT).as_posix(),sha256=digest(receipt),accepted_head=head,authorization='用户2026-10-16恢复第6章；已完成修复快照重新冻结'))
dump(baseline,b)
task='当前任务：继续完成第6章本地流程（印刷211–258 / PDF232–279）；第2–5章沿用已完成修复验收，不进入第7章。'
next_='下一步：复用批26的128条编译证据，从WIP 6b822a9a524f续接132条；批27无结果且原进程已结束，保留记录，以新收据完成检查后继续§6.3.4–6.4.5。'
scope='''## 当前最高优先级范围（用户2026-10-16新指令）

- 恢复第6章本地①–⑤流程；第2–5章审核修复已完成，不重新展开修复队列。第1章按原规则暂停；MolecularDynamics/正式库字节冻结、0 sorry；不进入第7章。
- 每批≤8条及时落盘并单文件Lean编译；每节完整scripts/check.ps1、逐条#print axioms、七段文档及commit+push。沿用Lean/Mathlib v4.34.0。
- 仅本地PASS条目证明：现成正式桥接→短证明；三条失败路线或缺大型理论即sorry+缺项继续。Thm6.1/6.2/Prop6.4没有整条现成桥接则sorry；不恢复封存断点或长证明。
- 保留完整对象、量词、前提及全部结论；EXTRA/ERRATUM?明确，禁True、P→P、结论作假设、admit、新axiom/unsafe。JSON/旧映射/模板C/compact/完整版BATCH/INDEX齐全；每个PASTE+原页PDF+MANIFEST合计<256000字节，只生成不提交网站。
- 网站未审写待网站审计，含sorryAx必须incomplete；最终状态仅self-contained / checked+documented priors / incomplete。每检查点更新PROGRESS、LOCAL_PIPELINE及WORK_LOG≤3行，复用已通过证据，保留未提交半成品及其他任务文件。
- 全部本地流程完成后更新CURRENT_STATE终态并停止于第6章；已完成第2–5章EAUDIT网站复审与导师判断仍待用户处理。

'''
for rel in ('AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md'):
 p=ROOT/rel;old=p.read_text(encoding='utf-8');title=old.splitlines()[0]
 p.write_text(title+'\n\n'+task+'\n'+next_+'\n\n'+scope+'## 历史交接（暂停第6章及停止推进已被本次新指令覆盖）\n\n'+old,encoding='utf-8')
p=ROOT/'docs/handoff/CURRENT_STATE.zh-CN.md';old=p.read_text(encoding='utf-8')
p.write_text('# 当前可操作状态\n\n'+task+'\n'+next_+'\n\n第2–5章修复终验沿用93d2d3e5；网站复审和导师判断待用户处理。第6章已验证至128条；132条批27尚未验证。\n\n## 历史状态（旧第6章暂停已由用户恢复）\n\n'+old,encoding='utf-8')
p=ROOT/'docs/handoff/LOCAL_PIPELINE.md';s=p.read_text(encoding='utf-8');lines=s.splitlines();lines[0]=task
lines[2]='# 第2–6章本地流程总进度（第2–5章修复验收已完成）'
s='\n'.join(lines)+'\n';oldrow=next(x for x in s.splitlines() if x.startswith('| 6 |'));cells=oldrow.split('|');cells[4]=' ③–④§6.3.3恢复；128条已编译，132条WIP待验证 ';cells[-2]=' 未完成 '
p.write_text(s.replace(oldrow,'|'.join(cells)),encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
 f.write('\n## 2026-10-16 第6章恢复\n按用户新指令恢复第6章；第2–5章完成快照和正式库重新核对冻结，132条WIP保留，128条已有通过证据。\n下一步：批27旧进程已结束且无编译结果，保留原记录、用新收据验证；不恢复封存长证明。\n')
paths=['AGENTS.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/WORK_LOG.zh-CN.md',baseline.relative_to(ROOT).as_posix(),receipt.relative_to(ROOT).as_posix(),'scripts/resume_ch06_20261016.py']
stage(paths)
subprocess.run(['git','commit','-m','ch06: resume local pipeline after accepted ch02-05 repairs'],cwd=ROOT,check=True)
subprocess.run(['git','push'],cwd=ROOT,check=True)
print('Chapter 6 resumed; accepted committed repair changes:',len(changes))
