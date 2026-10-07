from pathlib import Path
import re

root = Path(__file__).resolve().parents[1]
handoff = root / 'docs/handoff'
priority = '当前任务：第1章完成与审阅交付（见 docs/review/CH01_CLAIMS.csv）。第6章已暂停，未经用户明确指令不得恢复。'
agents = root / 'AGENTS.md'
s = agents.read_text(encoding='utf-8-sig')
s = s.replace('## 工作标准', '## 工作标准\n\n- 2026-10-08 用户最高优先级新指令：当前阶段只做第1章完整正文清单、忠实 Lean 陈述与人工审阅交付；第6章暂停。完成第1章后停下来等待用户，不自动开始其他章节。本条优先于所有旧范围、路线图和接续提示。\n- 第1章尚未证明的结论允许放在 `MolecularDynamics/Chapter01/Statements.lean`，写成 `def name_statement : Prop := ...`；不得用 True、不得把结论藏进假设。每项最多三次失败，缺大型理论则登记并继续下一项。\n- 本阶段进度只记 `docs/review/CH01_CLAIMS.csv`；不向 STATUS、FORMALIZATION_MAP、ASSUMPTIONS、PROGRESS_OVERVIEW 追加长篇。每次唤醒只读本文件、CURRENT_STATE 顶部、WORK_LOG 最新条目和 CH01_CLAIMS.csv。每检查点日志不超过3行，不复制 Draft、不重算未变历史源码哈希。', 1)
s = s.replace('尚未证明的陈述放在文档中，不用占位证明塞进正式库。', '尚未证明的结论遵循上面的第1章 Prop 陈述规则，不使用占位证明。')
s = s.replace('实现时同步更新 `FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md`。', '当前阶段只更新第1章清单和简短交接。')
agents.write_text(s, encoding='utf-8')
(handoff / 'CURRENT_STATE.zh-CN.md').write_text('# 当前可操作状态\n\n## 最新数学检查点\n' + priority + '\n\n2026-10-08：本聊天正在执行优先级切换与第1章审阅交付；其他聊天不得并发写入共享工程。\n第0步：旧聊天仍在运行第6章 full-check01，尚未完成；等待停止共享写入后判定验收或封存，不做新数学。\n下一步：完成第6章封存/备份，然后逐页读取第1章并先提交完整清单。\n完成后写「第1章已交付审阅，等待用户指示」，之后只确认该状态。\n', encoding='utf-8')
old = (handoff / 'RESUME_PROMPT.zh-CN.md').read_text(encoding='utf-8-sig')
archive = handoff / 'archive'
archive.mkdir(parents=True, exist_ok=True)
(archive / 'RESUME_PROMPT_before_ch01_20261008.zh-CN.md').write_text(old, encoding='utf-8')
(handoff / 'RESUME_PROMPT.zh-CN.md').write_text('# 接续提示词\n\n## 最新接续入口：2026-10-08 第1章优先\n\n' + priority + '\n\n只读取 AGENTS.md、CURRENT_STATE 顶部、WORK_LOG 最新条目、CH01_CLAIMS.csv。旧提示词全部降为历史，不恢复第6章。\n先检查其他聊天是否正在执行，不并发写工程。第1章范围：全部正文 notation、定义、编号/未编号定理与正文论证的数学结论；排除习题、数值实验、介绍性数值例子。先清单并提交，后补忠实 Lean 陈述与限时证明，复用现有成果；Prop 陈述不等于证明。\n最后完整检查、公理审计、两份审阅文档、commit 与 push。完成后 CURRENT_STATE 写「第1章已交付审阅，等待用户指示」；heartbeat 保持 ACTIVE/15分钟，只确认完成状态，不自动开其他章节。\n', encoding='utf-8')
log = handoff / 'WORK_LOG.zh-CN.md'
text = log.read_text(encoding='utf-8-sig')
parts = re.split(r'(?m)(?=^## )', text)
older, recent = [], []
for part in parts:
    match = re.search(r'^## (2026-\d\d-\d\d)', part, re.M)
    (recent if match and match[1] >= '2026-10-08' else older).append(part)
target = archive / 'WORK_LOG_until_20261007.zh-CN.md'
if target.exists():
    raise RuntimeError('Archive already exists; inspect before rerunning')
target.write_text(''.join(older), encoding='utf-8')
log.write_text('# 工作日志（2026-10-08起；旧记录见 archive/WORK_LOG_until_20261007.zh-CN.md）\n\n' + ''.join(recent) + '\n## 2026-10-08 第1章优先级切换\n入口已改为第1章；heartbeat ACTIVE/15分钟保持，提示已更新；旧聊天第6章写入协调中。\n下一步：第6章收尾与push，随后逐页完整清单。\n', encoding='utf-8')
print('Priority entry points saved; historical log archived.')
