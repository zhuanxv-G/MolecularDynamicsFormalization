"""Final native acceptance and reviewable stop state for user directive 22."""
import json,hashlib,re,subprocess,sys
from pathlib import Path
from datetime import datetime
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'scripts'))
from local_blueprint import pipeline
from local_stage import stage
from ch06_errata import SPECS
p=pipeline(6);B=p.BASE;V=B/'validation/RESUME22'
assert len(p.RECORDS)==249
assert set(json.loads((B/'errata_enabled.json').read_text(encoding='utf-8'))['enabled'])==set(SPECS)
def call(args):
    print('RUN',*args,flush=True);subprocess.run(list(map(str,args)),cwd=ROOT,check=True)
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def frozen():
    initial=json.loads((V/'FROZEN_INPUTS.json').read_text(encoding='utf-8'))
    bad=[q for q,h in initial.items() if not (ROOT/q).exists() or sha(ROOT/q)!=h]
    assert not bad,bad
    return len(initial)
frozen()
full=B/'validation/CLOSEOUT22/full'
if not (full/'CHECK_REPORT.json').exists():
    call(['pwsh','-NoProfile','-File','scripts/check.ps1','-ReportDirectory',full])
else:assert json.loads((full/'CHECK_REPORT.json').read_text(encoding='utf-8-sig'))['machine_check_status']=='passed'
call([sys.executable,'scripts/local_section_check.py','6','blueprint/ch06/validation/CLOSEOUT22','--reuse-shared','blueprint/ch06/validation/CLOSEOUT22/full'])
call([sys.executable,'scripts/ch06_sync22.py'])
call(['pwsh','-NoProfile','-File','scripts/local_archive_obsolete.ps1','-Chapter','6'])
sections=sorted(q.parent.name for q in (B/'validation').glob('section*/LOCAL_CHECK_REPORT.json'))+['CLOSEOUT22']
call([sys.executable,'scripts/validate_local_delivery.py','6','--sections',*sections])
c=json.loads((V/'COUNTS.json').read_text(encoding='utf-8'))
attempts=json.loads((B/'proof_attempts.json').read_text(encoding='utf-8'))
declarations={k:v for entry in attempts['items'].values() for k,v in entry['declarations'].items()}
for r in p.RECORDS:
    key=r['source_id'].split('-')[-1]
    if key in SPECS:
        name=r['lean_decl']+'_corrected'
        assert name in declarations and declarations[name]['axioms'] is not None,name
header='以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信'
manifest=json.loads((B/'mathcopilot_tasks/MANIFEST.json').read_text(encoding='utf-8'))
tasks=[ROOT/t['path'] for batch in manifest for t in batch['subtasks']]
for folder in tasks:
    text=(folder/'PASTE.txt').read_text(encoding='utf-8')
    assert text.startswith(header) and sha(B/'ch06_source.json') in text and sha(ROOT/'Blueprint/Ch06.lean') in text,folder
formal=list((ROOT/'MolecularDynamics').rglob('*.lean'))
for path in formal:
    code=re.sub(r'(?s)/-.*?-/','',path.read_text(encoding='utf-8'))
    code=re.sub(r'(?m)--.*$','',code)
    assert not re.search(r'\b(sorry|admit)\b',code),path
    assert not re.search(r'(?m)^\s*(?:private\s+|protected\s+)?axiom\s',code),path
proofs=c['declarations']['已证'];unproved=c['declarations']['未证'];defs=c['declarations']['定义']
reason=c['unproved_reasons'];delivery=json.loads((B/'DELIVERY_VALIDATION.json').read_text(encoding='utf-8'))
summary=f'''# 第6章本地审阅总结（供导师）

第6章正文已整理至印刷第258页（PDF第279页），共 **249条**；习题和参考文献不在本轮范围内。本地流程已经完成并停止，没有进入第7章。第1—5章和正式证明库均保持原有文件内容。

本地逐条对照中，**{c['local_PASS']}条通过**，**{c['local_NEEDS_HUMAN']}条需人工核查**。这里的“通过”表示原文、数学含义和Lean陈述的本地对照通过，并不表示每条定理均已证明；网站审计尚未提交，导师尚未裁定疑误。

勘误清单涉及 **{c['source_errata_records']}个原书疑误关联条目**（同一问题在不同条目重复出现时分别登记），另有 **1个既有Lean辅助定义的问题**。详见[第6章勘误清单](CH06_ERRATA.zh-CN.md)。每条均列原文、页码、问题、反例或理由、原文版与修正版名称及状态、核查点和导师选项。原文中的错误断言保留但不证明；建议修正版尚待导师确认。

Lean文件中共有 **{proofs}个已证声明、{unproved}个未证声明、{defs}个定义**。这些数字包括同一原书条目的原文版、修正版、反例和辅助结论，因此与249条原文条目不是同一种计数。已证声明均经过Lean类型检查及逐声明的依赖检查；定义仅表示对象已经精确写出，不计作证明。

未证声明的原因分为：

- 缺少大型理论：**{reason.get('缺大型理论',0)}个**。主要涉及一般Itô公式、随机微分方程、遍历与谱理论、弱收敛、密度正则性及Poisson方程等；本轮没有为单条断言建立这些理论。
- 原书疑误不证明：**{reason.get('原书疑误不证',0)}个**。保留原文以便审阅，修正版另列。
- 短证明时间限制内未完成：**{reason.get('时间盒止',0)}个**。逐条保留失败原因和检查记录，单条尝试最多三种路线。

本轮已验证：每批单文件编译和逐声明依赖检查、各剩余小节检查点、章末一次重新执行的完整工程检查，以及249条原文映射、全文档和任务包覆盖。正式证明库的未完成证明数和新增公理声明数均为0。第1—5章与正式库共{frozen()}个受保护文件已逐一核对，内容与本轮开始时一致。

MathCopilot任务包已生成，共{delivery['full_batches']}批、{delivery['compact_subtasks']}个可提交子包，覆盖全部249条；入口见[任务清单](../../blueprint/ch06/mathcopilot_tasks/MANIFEST.json)。用户自行合并并提交，本轮没有向网站提交或等待返回。尚未验证的事项包括网站结论、导师对疑误的裁定，以及上述未证声明的完整证明。

逐条原文和Lean位置见[第6章逐条文档](CH06_BLUEPRINT.zh-CN.md)；机器检查证据见[章末验收](../../blueprint/ch06/DELIVERY_VALIDATION.json)。
'''
(ROOT/'docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md').write_text(summary,encoding='utf-8')
stop='第6章本地流程完成，等待用户新指令'
next_step='停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。'
for rel in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
    path=ROOT/rel;text=path.read_text(encoding='utf-8')
    if not text.startswith('# '+stop):text='# '+stop+'\n\n'+text
    text=re.sub(r'^下一步：.*$','下一步：'+next_step,text,flags=re.M)
    if rel.endswith('CURRENT_STATE.zh-CN.md'):
        text=text.replace('## 22号运行检查点','## 22号运行检查点\n\n249条正文全部落盘；章末完整check通过；详见CH06_SUMMARY_FOR_MENTOR与CLOSEOUT22。',1)
    path.write_text(text,encoding='utf-8')
resume=ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md'
text=resume.read_text(encoding='utf-8')
resume.write_text('# '+stop+'\n\n当前22号任务已经完成。先读取CURRENT_STATE顶部和第6章PROGRESS；没有用户新指令时停止，不进入第7章。\n\n---\n\n'+text,encoding='utf-8')
progress=B/'PROGRESS.md';text=progress.read_text(encoding='utf-8')
progress.write_text('# '+stop+'\n\n第6章正文全部条目已落盘；章末完整check通过。249条；印刷p.258/PDF279正文结束。Exercises与参考文献排除。\n\n下一步：'+next_step+'\n\n验证：validation/CLOSEOUT22；DELIVERY_VALIDATION.json；proof_attempts.json。网站未提交。\n\n---\n\n'+text.replace('下一章按LOCAL_PIPELINE自动接续。',next_step),encoding='utf-8')
pointer=B/'validation/CONTINUE_NEXT.json';saved=json.loads(pointer.read_text(encoding='utf-8'))
saved.update(active_records=249,status='complete_directive22',remaining_sections=[],current_verified_section='第6章正文结束',current_native=None,current_check='blueprint/ch06/validation/CLOSEOUT22',next_after_pass=next_step)
p.dump(pointer,saved)
table=ROOT/'docs/handoff/LOCAL_PIPELINE.md';text=table.read_text(encoding='utf-8')
old=next(s for s in text.splitlines() if s.startswith('| 6 |'));parts=old.split('|')
parts[4]=' ⑤第6章本地流程完成，等待用户新指令 ';parts[-3]=' 章末CLOSEOUT22（本提交） ';parts[-2]=' 完成 '
table.write_text(text.replace(old,'|'.join(parts)),encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write(f'\n## {datetime.now().date()} 22号：第6章章末本地流程完成并停止\n249条正文、勘误双版本、导师总结与网站待提交包全部落盘；章末完整check和交付验收通过，冻结{frozen()}文件不变。\n停止于印刷p.258/PDF279；不进入第7章；未证原因逐条记录，网站和导师结论待用户安排。\n')
p.dump(V/'FINAL_PRESERVATION.json',dict(frozen_files=frozen(),unchanged=True,formal_sorry=0,formal_new_axiom_declarations=0,source_entries=249,website_submitted=False,chapter7_started=False,all_pairs_checked=True,task_packages=len(tasks),final_complete_check='blueprint/ch06/validation/CLOSEOUT22/full/CHECK_REPORT.json'))
owned=['AGENTS.md','Blueprint/Ch06.lean','blueprint/ch06','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/LOCAL_PIPELINE.md','docs/handoff/LEAN_HEARTBEAT_UPDATE.json','docs/review/CH06_BLUEPRINT.zh-CN.md','docs/review/CH06_ERRATA.zh-CN.md','docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md']
owned += [q.relative_to(ROOT).as_posix() for q in (ROOT/'scripts').glob('*ch06*22.py')]
owned += ['scripts/ch06_data.py','scripts/ch06_errata.py','scripts/ch06_sync22.py','scripts/ch06_batch_axioms.py','scripts/local_section_check.py','scripts/local_checkpoint.py','scripts/local_advance_ch06.py','scripts/local_blueprint.py','scripts/ch06_short_candidates.py']
owned += [q.relative_to(ROOT).as_posix() for q in (ROOT/'scripts').glob('ch06_section*.py') if q.stem in sys.modules]
paths=[]
for rel in owned:
    q=ROOT/rel
    if q.is_dir():paths.extend(f.relative_to(ROOT).as_posix() for f in q.rglob('*') if f.is_file() and not ('-commit' in f.name and f.suffix=='.log') and not f.name.startswith('INACTIVE_DRAFT_PLAN_'))
    else:paths.append(rel)
stage(sorted(set(paths)))
removed=subprocess.check_output(['git','diff','--name-only','--diff-filter=D','--','blueprint/ch06'],cwd=ROOT,text=True).splitlines()
assert all(q.startswith('blueprint/ch06/mathcopilot_tasks/compact/') for q in removed),removed
if removed:
    # The archive operation already checked containment and every moved hash.
    payload=''.join('0 '+'0'*40+'\t'+q+'\0' for q in removed).encode('utf-8')
    subprocess.run(['git','update-index','-z','--index-info'],cwd=ROOT,input=payload,check=True)
    paths+=removed
staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
assert all(q in paths for q in staged),set(staged)-set(paths)
assert not any(q.startswith(('MolecularDynamics/','blueprint/ch01/','blueprint/ch02/','blueprint/ch03/','blueprint/ch04/','blueprint/ch05/','Blueprint/Ch01','Blueprint/Ch02','Blueprint/Ch03','Blueprint/Ch04','Blueprint/Ch05')) for q in staged)
call(['git','commit','-m','ch06: complete directive22 local workflow and stop at chapter end'])
call(['git','push','-u','origin','chapter06-blueprint'])
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
remote=subprocess.check_output(['git','ls-remote','origin','refs/heads/chapter06-blueprint'],cwd=ROOT,text=True).split()[0]
assert head==remote
frozen()
print('COMPLETE, PUSH VERIFIED',head,flush=True)
