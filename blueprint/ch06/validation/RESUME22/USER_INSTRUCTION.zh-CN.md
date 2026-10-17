# 22号：恢复第6章本地流程，做到第6章章末后停止（2026-10-17 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第1章最终收口完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt，然后执行。

## 0. 优先级与范围
- 唯一任务：第6章本地五步流程，从已验证的148条检查点（§6.1–§6.3.7 已完成）接续，做完第6章剩余小节（§6.3.7 之后至第6章正文结束，印刷p.258/PDF279；Exercises 与参考文献排除）。
- 第1–5章不动：正式库 MolecularDynamics/ 保持 0 sorry、字节冻结；blueprint/ch01–ch05 不改。第2–5章复审包由用户提交网站，返回后另有指令，期间不要处理。
- 第6章完成后不进入第7章，停止并等待用户指令。

## 1. heartbeat 与入口
- heartbeat lean 保持 ACTIVE、15分钟、target、去重机制不变；接续消息改为：“按用户已授权的第6章本地流程继续（22号）。先核对AGENTS、CURRENT_STATE顶部、WORK_LOG最新及blueprint/ch06/PROGRESS.md，从最近已验证检查点接续；先 git status 并复用已通过证据。第1–5章不动，不进入第7章。”停止条件：blueprint/ch06/PROGRESS.md 显示第6章正文全部条目已落盘、章末完整check通过。改完把新 prompt 前3行贴给用户。
- 开始前 git status：工作区现有未跟踪文件（scripts/ch06_section6xx.py、tmp/、output/、各章 repair_20261014/ 等）不要删除；确认与第6章无关的不提交，第6章需要的随批次提交。

## 2. 证明策略（第6章 Mathlib 支持弱，避免空转）
- 每条短证明时间盒：最多3种路线；仍失败则保留 sorry，在 proof_attempts.json 记失败原因，归类为“缺大型理论 / 原书疑误不证 / 时间盒止”之一，立即转下一条。不为单条证明新建大型理论（一般Itô公式、SDE解存在唯一性、遍历定理、弱收敛等）。
- 编译：单文件编译 + 逐条 #print axioms 每批做；完整 check 只在每个小节检查点做一次（不是每批）。
- PDF 裁页工具若连续报错2次，改用整页渲染或跳过裁页、直接引用页码，不要反复重试同一脚本。

## 3. 原书疑误处理（与第1章同一规则，导师要求）
- 发现原书疑误时：保留原文逐字版（XxxPrinted）+ 修正版（Xxx_corrected）+ 能做时的反例；原文版不证明；修正版正常尝试证明。
- 新建 docs/review/CH06_ERRATA.zh-CN.md，字段同 CH01_ERRATA：原文逐字、页码、问题所在、反例、原文版/修正版声明名及状态、核查点、选项。已有的 NEEDS_HUMAN 疑误条目（如 CanonicalAveragePrinted 式(6.4)重复Z⁻¹、PartitionInversePrinted、OULawPrinted 漏根号、BathForcePrinted 负号、FPDiffusionPrinted 负号、DiffusiveTaylorPrinted 等）一并补录。

## 4. 网站任务包
- 照现有流程为第6章生成 MathCopilot 任务包，但不提交、不等网站；PASTE 开头必须带“以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”并内嵌哈希。用户会自行合并提交。

## 5. 完成标准
- 第6章正文全部条目落盘；单文件编译、逐条 #print axioms、章末一次完整 check 通过；正式库 0 sorry、0 axiom。
- 写 docs/review/CH06_SUMMARY_FOR_MENTOR.zh-CN.md：用导师能读懂的语言（不出现 sorryAx、checked+documented priors、字节预算等工程术语），给出：总条数、本地PASS数、原书疑误数（附勘误清单链接）、已证/未证数及未证原因分类。
- 提交并 push；CURRENT_STATE 顶部写“第6章本地流程完成，等待用户新指令”，然后停止，不进入第7章。
