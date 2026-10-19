from pathlib import Path
import sys,json,tomllib,subprocess
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'closeout31'))
from common31 import ROOT,load,dump,sha
OUT=Path(__file__).resolve().parent;BASE=OUT.parent
v=load(OUT/'DELIVERY_VALIDATION.json');assert v['status']=='PASS' and load(OUT/'full/CHECK_REPORT.json')['machine_check_status']=='passed'
hb=tomllib.loads(Path('C:/Users/ustc/.codex/automations/lean-2/automation.toml').read_text(encoding='utf-8'))
request=load(OUT/'HEARTBEAT_REQUEST.json')
assert hb['prompt']==request['prompt'] and hb['status']=='ACTIVE' and hb['rrule']==request['rrule'] and hb['target_thread_id']==request['targetThreadId']
dump(OUT/'HEARTBEAT.json',dict(status='PASS',configuration_status='ACTIVE',interval_minutes=15,target_thread_id=hb['target_thread_id'],prompt=hb['prompt'],deduplication='原resume_state.json路径及规则未改',automatic_resume_end_to_end_tested=False))
done='第8章最终收口完成；全书第1–8章正文收口，等待用户新指令'
checkpoint=done+'。\n10条复审输入绑定通过（2 PASS/0 FAIL/8 NEEDS_HUMAN）；8条按版本分流，FAIL修复中=0。\n本轮仅更新元数据和文档，Ch08.lean SHA256 a58849c4…未改；396声明编译/公理证据绑定复核通过，一次新完整check通过；正式库298文件0 sorry、0 axiom声明，17010冻结文件字节一致。\n全章最新整体网站PASS 76、NEEDS_HUMAN 27；285定义、54已证、57未证。27条原书表述疑误另加1证明核查/3域说明；导师裁定及57项证明未完成。未再送网站、未生成新EAUDIT包；本终态随提交push交付后停止。'
for rel in ['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md']:
 p=ROOT/rel;s=p.read_text(encoding='utf-8-sig')
 start=s.index('## 32号运行检查点')+len('## 32号运行检查点')
 end=s.index('## 历史指令与检查点（冲突处以32号为准）',start)
 s=s[:start]+'\n\n'+checkpoint+'\n\n'+s[end:]
 if rel.endswith('CURRENT_STATE.zh-CN.md') and not s.startswith(done):s=done+'\n\n'+s
 p.write_text(s,encoding='utf-8')
(ROOT/'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('# 第32号已完成，停止\n\n'+checkpoint+'\n\n若heartbeat唤醒，先核对32号第5节、blueprint/ch08/closeout32/DELIVERY_VALIDATION.json及Git远端；满足后只确认完成，不发送续接。ACTIVE、15分钟、原target和既存去重机制保留。\n未再送网站，不继续证明，不做习题或附加章节。\n',encoding='utf-8')
(BASE/'LOCAL_PIPELINE.md').write_text('# 第8章本地流程及最终收口\n\n'+checkpoint+'\n\n原文JSON及原页 → Lean陈述 → 原页核对 → 编译与公理检查 → 导师材料。\n本次复审原件保存在mathcopilot_results/eaudit/；历史EAUDIT包保持原始字节，只作已审存档，不再提交。\n验收：closeout32/DELIVERY_VALIDATION.json；新完整检查：closeout32/full/CHECK_REPORT.json。\n',encoding='utf-8')
p=BASE/'PROGRESS.md';s=p.read_text(encoding='utf-8');s=s.replace('# 第8章逐条进度\n','# 第8章逐条进度\n\n'+done+'。一次完整check通过；17010冻结文件字节一致；正式库0 sorry、0 axiom声明。\n',1);p.write_text(s,encoding='utf-8')
p=ROOT/'docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md';s=p.read_text(encoding='utf-8');s=s.replace('已验证：上述关键公式','已验证：固定Lean 4.34.0及对应Mathlib的统一检查通过。上述关键公式');p.write_text(s,encoding='utf-8')
p=ROOT/'docs/handoff/WORK_LOG.zh-CN.md';s=p.read_text(encoding='utf-8');s+='\n## 2026-10-19 第32号第8章最终收口\n10条复审绑定通过（2 PASS/0 FAIL/8 NEEDS_HUMAN），元数据/三份文档更新，Lean字节未改；396声明编译公理证据绑定复核、新一次完整check与17010冻结文件逐字核验通过。\n全章最新76 PASS/27 NEEDS_HUMAN/0 FAIL；正式库0 sorry/0 axiom；54已证/57未证及导师疑误裁定保留，未再送网站、无新包；本终态随提交push交付后停止。\n';p.write_text(s,encoding='utf-8')
dump(OUT/'COMPLETION.json',dict(status='PASS',instruction=32,state=done,lean_unchanged=True,delivery_validation_sha256=sha(OUT/'DELIVERY_VALIDATION.json'),full_report_sha256=sha(OUT/'full/CHECK_REPORT.json'),frozen_check_sha256=sha(OUT/'FROZEN_BYTE_CHECK.json'),heartbeat='ACTIVE/15分钟/原target/原去重保留，达到32号第5节停止发送',website_resubmitted=False,new_eaudit_packages=0,remaining_proofs=57,mentor_decisions='pending',publication='本终态由交付提交推送；远端哈希在提交后核验，不写入自指提交'))
print(done,flush=True)
