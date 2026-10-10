"""Install the explicitly authorized continuous local workflow; no Lean source changes."""
from pathlib import Path
import json,hashlib,tomllib
ROOT=Path(__file__).resolve().parents[1]
H=ROOT/'docs/handoff'
TASK='当前任务：第2–6章本地流程连续推进（见 docs/handoff/LOCAL_PIPELINE.md）；第1章暂停等待网站审校。'
NEXT='下一步：从第2章已完成检查点8ca2ccf接续；建立chapter03-blueprint，按≤8条落盘批次完成第3章。'
ranges={2:('53–94','75–116'),3:('97–136','119–158'),4:('139–174','161–196'),5:('179–209','200–230'),6:('211–258','232–279')}
lines=['# 第2–6章本地流程总进度','',
    '| 章 | 范围（印刷/PDF页） | 分支 | 当前步骤（①–⑤） | 最近检查点 commit | 完成/未完成 |',
    '|---|---|---|---|---|---|']
for ch,(printed,pdf) in ranges.items():
    lines.append(f'| {ch} | {printed} / {pdf} | chapter{ch:02}-blueprint'+('' if ch==2 else '（待建）')+
        ' | '+('⑤终验完成' if ch==2 else '①待开始')+' | '+('8ca2ccf' if ch==2 else '未开始')+' | '+('完成' if ch==2 else '未完成')+' |')
lines+=['','页界已渲染核对：第3章p.136/PDF158的Exercises之前保留；第4章正文至p.174/PDF196，Exercises为PDF197–199；第5章p.209/PDF230的Exercises之前保留；第6章正文至p.258/PDF279，Exercises为PDF280–281；第7章PDF282起不进入。',
    '第5、6章PDF偏移为+21，与第3、4章的+22不同，不套用旧偏移。范围证据见blueprint/local_pipeline/boundaries.png。',
    '此表为跨章唯一总进度；逐条状态仅在blueprint/chXX/PROGRESS.md。每完成≤8条即落盘并更新两者；每节完整check及commit+push。',
    '第2章已完成证据复用：blueprint/ch02/DELIVERY_VALIDATION.json与五节CHECK_REPORT；不重做。未提交半成品核对后续做，不丢弃。',
    '第1章与正式库字节冻结；新第1章返回件在当前节提交后按EAUDIT整合。网站一律待网站审计。',
    '第5章不新建Mathlib缺失的大型理论，单节2小时；第6章不恢复封存断点/长证明，Thm6.1/6.2/Prop6.4无现成桥接则sorry。',
    '全部完成后停止于第6章；入口改为第2–6章本地流程全部完成，各章等待用户提交网站批次。']
(H/'LOCAL_PIPELINE.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
state=H/'CURRENT_STATE.zh-CN.md';old=state.read_text(encoding='utf-8')
top=['# 当前可操作状态','',TASK,NEXT,'',
     '顺序：第2章完成且复用 → 第3章 → 第4章 → 第5章 → 第6章；不进入第7章。',
     '跨章唯一总进度：docs/handoff/LOCAL_PIPELINE.md；当前章逐条进度：blueprint/ch03/PROGRESS.md（第3章创建时落盘）。',
     '约束：正式库0 sorry且源码/签名不改；第1章交付冻结；其他任务文件保留不动。',
     '自动续接：lean保持ACTIVE/15分钟及原target/去重记录；仅明确额度中断且恢复时发送，同一失败轮一次、间隔≥30分钟；同章同检查点连续3次无进展中断则停发并通知。',
     '最近已验收：第2章160条、32批/160份compact，5节check通过且已推送8ca2ccf；网站审计与导师问题未验证。',
     '启动预检：PDF章界已视觉核对；第3–6章旧清单分别143/100/86/126条，正文逐页核对尚待推进。',
     '', '## 历史第2章交付（以下停止条件已被2026-10-10新指令取代）','',old]
state.write_text('\n'.join(top)+'\n',encoding='utf-8')
agents=ROOT/'AGENTS.md';old_agents=agents.read_text(encoding='utf-8')
paused=old_agents.split('## 第1章规则')[1].split('## 当前最高优先级范围')[0]
paused=paused.replace('heartbeat lean保持ACTIVE/15分钟、不修改；第1章暂停，按下述第2章范围继续，不进入第3章。','heartbeat lean保持ACTIVE/15分钟；prompt已按用户新指令扩大为第2–6章，原target和去重机制保留。第1章规则仅暂停时的新返回件整合适用。')
rules='''## 当前最高优先级范围（2026-10-10用户新指令）

- 第2章复用已完成证据，随后第3→4→5→6章自动推进，不等网站，不进入第7章。范围见LOCAL_PIPELINE，习题/参考文献除外，以PDF原页为准。
- 每章①逐字JSON及全部旧CSV映射；②忠实Blueprint加入构建；③模板C本地预审及完整BATCH/compact的PASTE.txt+原页PDF+SHA256 MANIFEST（实际磁盘字节<256000）；④仅本地PASS证明，已有桥接→短证明→其余；⑤逐条公理、7段文档及终验。
- [EXTRA]逐项注明，疑误[ERRATUM?]与NEEDS_HUMAN；禁止True、P→P、结论作假设、admit、新增axiom、unsafe、偷换对象/量词/结论。网站列仅待网站审计，不伪造PASS或冻结。
- MolecularDynamics/正式库不改源码或签名、0 sorry；第1章交付逐字节冻结。仅出现第1章新返回件时，当前节提交后按原EAUDIT及repair_log只追加整合，修签名后重审，再回当前章。
- 第5章Mathlib缺失的微正则/遍历/KAM等大型理论不建设，忠实陈述后sorry+缺项；每节2小时时间盒。第6章仅可桥接已有定理，不恢复封存断点/长证明；Thm6.1/6.2/Prop6.4无现成桥接则sorry。
- 每章从上章最后commit新建chapterXX-blueprint；每节一次commit+push已授权。每小批≤8条及时落盘，更新该章PROGRESS与跨章唯一总表LOCAL_PIPELINE；每小批单文件lake env lean，每节完整scripts/check.ps1。固定Lean4.34.0/Mathlibv4.34.0。
- 单条3条失败路线或缺大型理论即sorry+缺项继续；不等待导师。最终状态仅self-contained / checked+documented priors / incomplete，含sorryAx必须incomplete，区分直接和传递占位。
- 唤醒先git status，再只读AGENTS、CURRENT_STATE顶部、WORK_LOG最新、LOCAL_PIPELINE及当前章PROGRESS；核对现有编译/验证证据，复用已通过工作；未提交半成品核对后续做，不丢弃。每检查点WORK_LOG≤3行；不向STATUS/FORMALIZATION_MAP/ASSUMPTIONS追加长文；其他任务output/tmp/check-full06等不动、不提交。
- heartbeat lean prompt已授权扩大为第2–6章；ACTIVE/15分钟、原target及resume_state.json去重保留。只在明确usage limit/quota/rate limit中断且get_usage_limits恢复后发送；运行/排队则安静；同失败轮一次，间隔≥30分钟；不购买/切账号/切模型。同章同检查点连续3次无进展中断后停止自动发送并通知，配置成功不等于恢复已实测。
- 全部完成后CURRENT_STATE顶部写“第2–6章本地流程全部完成；第1–6章均等待用户提交 MathCopilot 批次（见各章 mathcopilot_tasks/INDEX.md）”，停止；以后仅确认状态或整合新返回件。
'''
agents.write_text('# 项目接续与形式化约定\n\n'+TASK+'\n'+NEXT+'\n\n'+rules+'\n## 第1章规则'+paused,encoding='utf-8')
(H/'RESUME_PROMPT.zh-CN.md').write_text('# 接续提示词\n\n'+TASK+'\n'+NEXT+'\n\n'+
    '先git status，读取AGENTS、CURRENT_STATE顶部、WORK_LOG最新、LOCAL_PIPELINE及当前章PROGRESS。从最近落盘批次接续，核验已有结果后复用，不重做已通过的JSON、Blueprint、证明或构建；未提交半成品核对后继续。\n'+rules,encoding='utf-8')
with (H/'WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-10 第2–6章连续本地流程：第0步\n入口与跨章总表已改写；第2章证据复用；第3–6章页界已核。heartbeat仅扩大prompt，原调度/目标/去重保留。\n下一步建立chapter03-blueprint，从≤8条批次接续；第1章与正式库冻结，网站待审。\n')
a=Path('C:/Users/ustc/.codex/automations/lean');current=tomllib.loads((a/'automation.toml').read_text(encoding='utf-8-sig'))
base=json.loads((H/'LEAN_HEARTBEAT_BASELINE.json').read_text(encoding='utf-8'))
for key in ['id','kind','name','status','rrule','target_thread_id','created_at']:assert current[key]==base[key],key
assert hashlib.sha256((a/'resume_state.json').read_bytes()).hexdigest()==base['resume_state_sha256']
out=dict(prompt_first_3_lines=current['prompt'].splitlines()[:3],status=current['status'],schedule='每15分钟',
    target_thread_id=current['target_thread_id'],execution_thread_id='01a120c8-80e1-7c73-b0a4-04346ac02d16',
    resume_state_sha256=base['resume_state_sha256'],unchanged_fields_verified=True,automatic_resume_end_to_end='NOT_TESTED')
(H/'LEAN_HEARTBEAT_UPDATE.json').write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,ensure_ascii=False,indent=2))
