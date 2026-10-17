"""Accept committed Ch1 closeout and resume only the human's Chapter 6 scope."""
from pathlib import Path
import hashlib,json,subprocess,tomllib
R=Path(__file__).resolve().parents[1]
B=R/'blueprint/ch06';OUT=B/'validation/RESUME22'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
dump=lambda p,v:p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=R,text=True).strip()
status=subprocess.check_output(['git','status','--short'],cwd=R,text=True)
baseline=json.loads((B/'BASELINE.json').read_text(encoding='utf-8'))
changes=[]
for rel,h in baseline['protected'].items():
    actual=sha(R/rel)
    if h==actual:continue
    assert rel.startswith(('Blueprint/Ch01.lean','blueprint/ch01/','docs/review/CH01_')),rel
    subprocess.run(['git','diff','--quiet','HEAD','--',rel],cwd=R,check=True)
    changes.append(dict(path=rel,before=h,accepted=actual));baseline['protected'][rel]=actual
receipt=R/'blueprint/ch01/validation/CLOSEOUT21/DELIVERY_VALIDATION.json'
delivery=json.loads(receipt.read_text(encoding='utf-8'));assert delivery['full_check']=='passed'
check=R/'blueprint/ch01/validation/CLOSEOUT21/full/CHECK_REPORT.json'
report=json.loads(check.read_text(encoding='utf-8-sig'));assert report['machine_check_status']=='passed'
for f in report['inputs']:assert sha(R/f['relative_path'])==f['sha256'],f['relative_path']
for c in report['checks']:assert c['exit_code']==0 and sha(check.parent/c['raw_log'])==c['raw_log_sha256']
oldcheck=B/'validation/section634-637-final/LOCAL_CHECK_REPORT.json'
old=json.loads(oldcheck.read_text(encoding='utf-8-sig'));assert old['machine_check_status']=='passed'
for f in old['inputs']:assert sha(R/f['relative_path'])==f['sha256'],f['relative_path']
for c in old['checks']:assert c['exit_code']==0 and sha(oldcheck.parent/c['raw_log'])==c['raw_log_sha256']
assert len(json.loads((B/'ch06_source.json').read_text(encoding='utf-8')))==148
paths=subprocess.check_output(['git','ls-files','-z'],cwd=R).decode().split('\0')
frozen={p:sha(R/p) for p in paths if p and p.startswith(('MolecularDynamics/','Blueprint/Ch01.lean','Blueprint/Ch02.lean','Blueprint/Ch03.lean','Blueprint/Ch04.lean','Blueprint/Ch05.lean','blueprint/ch01/','blueprint/ch02/','blueprint/ch03/','blueprint/ch04/','blueprint/ch05/')) and (R/p).is_file()}
dump(OUT/'FROZEN_INPUTS.json',frozen)
snapshot=dict(authorization='用户2026-10-17第22号全文',head=head,initial_status=status,
    accepted_ch01_changes=changes,chapter1_delivery=sha(receipt),reused_ch06_check=sha(oldcheck),
    shared_check=check.relative_to(R).as_posix(),shared_check_sha256=sha(check),frozen_files=len(frozen),
    scope='Chapter6 local only; Chapters1-5 frozen; no Chapter7')
dump(OUT/'RESUME_VALIDATION.json',snapshot)
baseline.setdefault('resume_snapshots',[]).append(dict(receipt='blueprint/ch06/validation/RESUME22/RESUME_VALIDATION.json',sha256=sha(OUT/'RESUME_VALIDATION.json'),accepted_head=head))
dump(B/'BASELINE.json',baseline)
auto=tomllib.loads(Path('C:/Users/ustc/.codex/automations/lean-2/automation.toml').read_text(encoding='utf-8'))
assert auto['status']=='ACTIVE' and auto['rrule']=='FREQ=MINUTELY;INTERVAL=15'
assert auto['target_thread_id']=='01a10bc0-bc8d-7043-8df9-21a6b0bde09a'
auto.update(dedup_rules_preserved=True,resume_state_file_available=False,automatic_resume_end_to_end='NOT_TESTED',resume_messages_sent_this_turn=0,
    execution_note='原lean-2在应用缺失，按原name/target/频率恢复；配置已实读，原去重路径未修改；自动恢复未实测。')
dump(R/'docs/handoff/LEAN_HEARTBEAT_UPDATE.json',auto)
dump(OUT/'HEARTBEAT_UPDATE.json',auto)
next_='下一步：激活§6.3.8的8条；复用已通过证据，按CONTINUE_NEXT顺序至§6.4.5章末停止。'
p=R/'docs/handoff/RESUME_PROMPT.zh-CN.md';s=p.read_text(encoding='utf-8')
p.write_text('# 22号第6章接续\n\n'+auto['prompt'].split('\n\n')[0]+'\n\n'+next_+'\n\n---\n历史接续提示（冲突处以22号为准）：\n'+s,encoding='utf-8')
p=R/'docs/handoff/LOCAL_PIPELINE.md';s=p.read_text(encoding='utf-8');lines=s.splitlines();lines[0]='当前任务：22号第6章本地流程，148条检查点恢复；第1–5章冻结，不进入第7章。'
for i,x in enumerate(lines):
    if x.startswith('| 6 |'):lines[i]=x.replace('⑤已验证148条后暂停（21号）','⑤已验证148条；22号恢复后续正文')
p.write_text('\n'.join(lines)+'\n',encoding='utf-8')
p=B/'PROGRESS.md';s=p.read_text(encoding='utf-8').replace('下一步：按21号指令暂停于148条已验证检查点；不再推进、不自动恢复。网站待审。',next_)
p.write_text(s,encoding='utf-8')
p=B/'validation/CONTINUE_NEXT.json';v=json.loads(p.read_text(encoding='utf-8'));v.update(status='active_directive22',next_after_pass=next_);dump(p,v)
with (R/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-17 第22号恢复第6章\n22号全文置双入口顶部；原148条编译/公理收据与第1章21号终验哈希复用，第1–5章当前字节冻结。\nlean-2缺失后按原target/15分钟/去重恢复ACTIVE并读回，自动恢复未实测；下一步§6.3.8，不进入第7章。\n')
print('Resume22 verified; frozen files:',len(frozen),'accepted Ch1 changes:',len(changes))
