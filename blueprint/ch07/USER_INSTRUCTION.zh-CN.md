# 27号：第7章本地五步流程，做到第7章章末后停止（2026-10-18 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第6章最终收口完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt，然后执行。

## 0. 范围
- 唯一任务：第7章 Numerical Methods for Stochastic Molecular Dynamics，原书 PDF 第282–349页（印刷约261–328页；PDF页 = 印刷页 + 21，开工前用原页核对首末页）。正文 §7.1–§7.13 全部；Exercises 与参考文献排除。
- 第1–6章不动：正式库 MolecularDynamics/ 保持 0 sorry、字节冻结（新内容只写 blueprint/ 及第7章相关新文件；现有 MolecularDynamics/Chapter07/ 三个文件可作为桥接引用，不改）；blueprint/ch01–ch06 不改。
- 第7章完成后不进入第8章，停止并等待用户指令。
- 分支：沿用此前每章的分支惯例（如新建 chapter07-blueprint），第6章收口提交保持原样。

## 1. heartbeat 与入口
- heartbeat lean 保持 ACTIVE、15分钟、target、去重机制不变；接续消息改为：“按用户已授权的第7章本地流程继续（27号）。先核对AGENTS、CURRENT_STATE顶部、WORK_LOG最新及blueprint/ch07/PROGRESS.md，从最近已验证检查点接续；先 git status 并复用已通过证据。第1–6章不动，不进入第8章。”停止条件：blueprint/ch07/PROGRESS.md 显示第7章正文全部条目已落盘、章末完整check通过。改完把新 prompt 前3行贴给用户。

## 2. 流程与格式
- 照第6章（22号）的本地五步流程：原文 JSON（逐字、页码）→ Lean 陈述 → 本地逐条对照原页 → 编译与公理检查 → 文档。
- 交付格式一律照第1章（导师已确认）：CH07_BLUEPRINT.zh-CN.md 逐条结构、CH07_ERRATA.zh-CN.md、CH07_SUMMARY_FOR_MENTOR.zh-CN.md。
- 范围取舍同前几章：保留定义、记号、编号与未编号的数学结论及其证明；数值实验的曲线、表格、经验数值结果（如 §7.11 生物分子算例的观测结果）不作为待证对象，只在 excluded 记录中列出。

## 3. 证明策略
- 每条短证明时间盒：最多3种路线；仍失败保留 sorry，在 proof_attempts.json 记失败原因，归类为“缺大型理论 / 原书疑误不证 / 时间盒止”，立即转下一条。不为单条证明新建大型理论（弱误差展开的一般理论、SDE 解存在唯一、遍历性、Talay–Tubaro 展开等）。
- 编译：单文件编译 + 逐条 #print axioms 每批做；完整 check 只在每个小节检查点做一次。
- PDF 裁页工具连续报错2次就换整页渲染，不反复重试同一脚本。

## 4. 第6章的教训（务必遵守）
- **判原书疑误前必须看原页渲染图**：第6章 OULawPrinted 曾把自己的转录错误（根号范围看错）记成原书疑误。凡公式类疑误，先渲染原页核对根号/分式/上下标范围，在勘误条目中写明“已目视核对原页”。
- **对象资格写全**：随机过程类定义必须写明 W 为 Wiener 过程（多维时各坐标独立）、核族为 Markov 半群（K 0 = id、半群律）、密度非负且归一等；第6章因缺这些被判 FAIL 多次。
- **statement_scope 与 Lean 覆盖一致**：一条原文含多个结论时，要么全部陈述，要么在 [EXTRA] 明确只覆盖哪部分并把其余列入覆盖缺口；不要声称覆盖整段而只表达一部分。
- 原书疑误：原文逐字版（XxxPrinted）+ 修正版（Xxx_corrected）+ 能做时的反例；原文版不证明，修正版正常尝试。

## 5. 网站任务包
- 照第6章首轮格式生成 MathCopilot 任务包（mathcopilot_tasks/MANIFEST.json + compact/BATCHxx/a… 子任务，各含 MANIFEST.json、PASTE.txt、*PAGES.pdf），不提交、不等网站；用户会合并提交。
- PASTE 开头带“以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”并内嵌哈希。
- **必须包含本条用到的全部项目定义体**（含跨章引用的 ChapterXXReview 定义和选择规格，如 Classical.choose 所用存在命题）；第6章有约10条因缺定义摘录被判 NEEDS_HUMAN。打包后自检：每个子任务里出现的 MolecularDynamics./MD. 项目常量都有定义体摘录。

## 6. 完成标准
- 第7章正文全部条目落盘；单文件编译、逐条 #print axioms、章末一次完整 check 通过；正式库 0 sorry、0 axiom，第1–6章冻结文件字节一致。
- CH07_BLUEPRINT、CH07_ERRATA、CH07_SUMMARY_FOR_MENTOR 已写（导师语言，不出现 sorryAx、checked+documented priors、字节预算、历史绑定哈希等工程术语和内部流程话）。
- 任务包已生成，报告批数、子包数和覆盖条数。
- 提交并 push；CURRENT_STATE 顶部写“第7章本地流程完成，等待用户新指令”，然后停止，不进入第8章。
