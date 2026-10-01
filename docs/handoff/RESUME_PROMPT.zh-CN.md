# 给另一个 Codex 账户的提示词

## 用法

在另一个账户中打开同一个本地工作区 `C:\Users\ustc\Desktop\formal math` 或其中的正式工程，再复制下面的提示词。进度由当前状态文件维护，本提示词不复制易过时的进度。

若换电脑或使用另一份工程，先转移完整项目（包括未提交/未跟踪文档）及教材 PDF，再将提示词里的路径替换为新路径。`.lake` 可由固定版本环境重建；上层 `tmp/textbook-plan/` 是可选辅助数据。只克隆当前远端旧提交不包含尚未提交的本地记忆。

本方案靠本地文件交接；不依赖账户聊天互通。正常保存的检查点可以恢复，额度突然中断前尚未保存的推理与操作不能保证恢复。因此平时也应持续更新。

## 完整接续提示词（直接复制）

```text
请接续我的分子动力学教材 Lean 形式化项目，并为下一批正式工作准备准确陈述与 MathCopilot 任务。

工作区：C:\Users\ustc\Desktop\formal math
正式工程：C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization

这是跨 Codex 账户交接。请不要假定你有上一账户的聊天记录，先读取：
1. 工作区根和正式工程根的 AGENTS.md。
2. 正式工程内 docs/handoff/CURRENT_STATE.zh-CN.md。
3. 正式工程内 docs/handoff/WORK_LOG.zh-CN.md 的最新工作条目。

然后检查实际 Git 分支、HEAD、工作树和相关 Lean 源码，与交接记录核对。保留所有未提交和未跟踪文件；如果上次中断留下了改动，先判断它们的状态再继续。

按当前状态中记录的首个未完成任务继续；若记录已过时，以实际代码和最新有效工作日志核实后更新。任务相关范围和验收阅读 docs/WHOLE_BOOK_ROADMAP.zh-CN.md，现有成果及假设阅读 FORMALIZATION_MAP.md、ASSUMPTIONS.md、STATUS.md；下一批任务参考 docs/audits/2026-10-01-initial/NEXT_TASKS.zh-CN.md 和相关依赖/API 审计。

目标已经明确：整本给定教材 PDF 的数学内容，含附录、数学类习题、未编号结论和必要外部依赖。没有硬性截止日期，准确性优先。不要根据旧草案中的“selected results”“习题待确认”重新缩小范围或泛泛等待确认。

用中文简短说明你理解的目标、真正已完成的成果和本次第一动作，然后继续工作，不要只返回计划。先核对教材陈述与必要假设，再进行 Lean 实现；关键数学歧义需提出具体问题。采用仓库固定版本，禁止 sorry、admit、项目新公理或通过假设目标结论冒充证明。定义、已核对原页、已证明、构建成功和负责人语义复核分别记录。

师兄明确要求借助 MathCopilot 完成任务，请将网站作为正式流程中的重要参与工具。网站负责证明路线探索、Lean 陈述/依赖整理、证明起草、托管检查与报告；本地负责教材语义复核、源码集成、固定版本正式构建和 Git 保存。每批明确网站的目标、输入提交、交付文件和验收方式，不要默认改成完全本地实施。网站历史环境限制见 CURRENT_STATE.zh-CN.md，不能把托管检查版本未知或单文件成功当正式工程已验证。

如果工作仍停留在交接记录的 T1 前，本轮先：
1. 对照 Chapter 1 §1.2 原页和已有源码，核对 N、N_d、N_c 与质量重复方案。
2. 列出 T1 的准确 Lean 陈述、假设及需要的固定版本 mathlib 结果，并说明与教材的对应。
3. 准备一条可复制给 MathCopilot 的初始任务指令及输入文件清单，先整理陈述和依赖，核对后再进入证明实现。
4. 给出 MathCopilot 成果导回本地后的检查流程，保留现有 API 和未提交文件。
若已有更新的已授权任务，按实际源码与最新记录接续，不重复已完成的工作。

本提示词授权完成上述本地核对、陈述整理、必要 API 检查和网站指令准备；没有授权直接发送外部任务、上传文件、提交、推送、合并、重置或启动尚未审阅的新证明。如我在新会话另行明确授权，遵照它执行。缺少网站会话时仍完成可做的本地准备，不声称网站已参与未实际执行的任务。

开始小任务前写入当前检查点。每完成一个定义、引理、审计项或可复核失败尝试，更新 CURRENT_STATE.zh-CN.md 并追加 WORK_LOG.zh-CN.md；长任务每 20–30 分钟至少保存一次。修改 Lean 后运行项目检查并记录实际结果，不能将旧成功套在新源码上。每次结束前保存当前进度、未完成项、错误和恢复后的第一条具体动作，以便下一账户继续。
```

## 最短接续提示词

```text
请打开 C:\Users\ustc\Desktop\formal math，读取根目录 AGENTS.md，以及 MolecularDynamicsFormalization 内的 AGENTS.md、docs/handoff/CURRENT_STATE.zh-CN.md 和 WORK_LOG.zh-CN.md 最新条目，核对真实代码与 Git 状态，按 docs/handoff/RESUME_PROMPT.zh-CN.md 的完整接续要求准备 T1 的准确陈述和 MathCopilot 任务。MathCopilot 纳入证明探索与起草流程，本地承担复核、正式验收和 Git 保存。持续保存交接记忆；未获明确授权不发送外部任务、不提交或推送。
```

## 主动换账户前的保存提示词

```text
我准备换 Codex 账户。请把目前进度保存到 docs/handoff/CURRENT_STATE.zh-CN.md，并在 WORK_LOG.zh-CN.md 追加交接检查点：实际分支/HEAD、已完成 declaration、修改及未提交文件、验证命令和真实结果、当前失败/阻塞、尚未保存或尚未验证的草稿，以及下一账户接手后第一条具体动作。保存相关工作文件，不为交接临时新增公理/占位证明，不擅自提交、推送或重置。完成后告诉我接续入口。
```

## 只恢复理解、暂不推进代码的提示词

```text
请读取 C:\Users\ustc\Desktop\formal math\MolecularDynamicsFormalization\docs\handoff\CURRENT_STATE.zh-CN.md 和 WORK_LOG.zh-CN.md 最新条目，以及适用的 AGENTS.md，核对真实工程。用中文告诉我目标、已完成成果、当前未完成任务与建议第一步。本次只恢复背景，不开始新的形式化实现。
```
