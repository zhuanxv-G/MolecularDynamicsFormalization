# 28号：第8章本地五步流程（与第7章网站审校并行），做到第8章章末后停止（2026-10-18 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第7章本地流程完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt，然后执行。

## 0. 范围
- 唯一任务：第8章 Extended Variable Methods，原书 PDF 第350–436页（印刷约329–415页；PDF页 = 印刷页 + 21），正文 §8.1–§8.10。Exercises（开工时按原页确定起始页）与参考文献（PDF437起）排除。
- 本章编号对象至少包括 Lemma 8.1、Proposition 8.1、8.2、8.3、Theorem 8.1，开工后逐页核对不得遗漏。
- 第8章完成后停止并等待用户指令；全书正文到此结束，不做任何附加章节。

## 1. 并行约束（重要）
- 用户正在把第7章任务包提交网站审校。网站返回要按打包时的哈希校验，所以本轮**禁止修改** Blueprint/Ch07.lean、blueprint/ch07/ 下的任何文件（含 ch07_source.json、mathcopilot_tasks/）。第7章返回后另有指令。
- 第1–6章不动：正式库 MolecularDynamics/ 保持 0 sorry、字节冻结；blueprint/ch01–ch06 不改。现有 MolecularDynamics/Chapter08/ 七个文件可作为桥接引用，不改。
- 分支：从 chapter07-blueprint 当前 HEAD 新建 chapter08-blueprint；后续第7章修复也将在此分支上进行。

## 2. heartbeat 与入口
- heartbeat lean 保持 ACTIVE、15分钟、target、去重机制不变；接续消息改为：“按用户已授权的第8章本地流程继续（28号）。先核对AGENTS、CURRENT_STATE顶部、WORK_LOG最新及blueprint/ch08/PROGRESS.md，从最近已验证检查点接续；先 git status 并复用已通过证据。第1–7章不动（第7章文件网站审校中，禁止修改），完成第8章后停止。”停止条件：blueprint/ch08/PROGRESS.md 显示第8章正文全部条目已落盘、章末完整check通过。改完把新 prompt 前3行贴给用户。

## 3. 流程与格式
- 照第7章（27号）的本地五步流程：原文 JSON（逐字、页码）→ Lean 陈述 → 本地逐条对照原页 → 编译与公理检查 → 文档。
- 交付格式照第1章（导师已确认）：CH08_BLUEPRINT.zh-CN.md、CH08_ERRATA.zh-CN.md、CH08_SUMMARY_FOR_MENTOR.zh-CN.md。
- 范围取舍同前：保留定义、记号、编号与未编号数学结论及证明；§8.10 Numerical Experiments 及其他小节中的图、表、经验数值结果不作待证对象，在 excluded 记录中逐项写理由。章末自检：本章所有编号公式 (8.x) 都出现在 source 或 excluded 中。

## 4. 证明策略
- 每条短证明最多3种路线；失败保留 sorry，在 proof_attempts.json 记原因，归类为“缺大型理论 / 原书疑误不证 / 时间盒止”，立即转下一条。不为单条证明新建大型理论（Nosé–Hoover 遍历性、Hörmander 条件推出的光滑性/唯一不变测度、广义 Langevin 的马尔可夫化极限、NPT 系综理论等）。
- 单文件编译 + 逐条 #print axioms 每批做；完整 check 每个小节检查点一次。PDF 裁页工具连续报错2次就换整页渲染。

## 5. 沿用第6、7章的要求
- 判公式类原书疑误前必须看原页渲染图，并在勘误条目写“已目视核对原页”。
- 对象资格写全：随机过程写明 Wiener（多维坐标独立）；核族为 Markov 半群；密度非负且归一；扩展变量（热浴变量、质量参数 Q、活塞等）的取值域与正性条件写明。
- statement_scope 与 Lean 覆盖一致；只覆盖一部分时在 [EXTRA] 写明并列入覆盖缺口。
- 原书疑误：原文逐字版（XxxPrinted）+ 修正版（Xxx_corrected）+ 能做时的反例；原文版不证明。

## 6. 网站任务包
- 照第7章首轮格式生成（mathcopilot_tasks/MANIFEST.json + compact/BATCHxx/a… 子任务，各含 MANIFEST.json、PASTE.txt、*PAGES.pdf），不提交、不等网站。
- PASTE 开头带“以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”并内嵌哈希；必须包含本条用到的全部项目定义体（含跨章 ChapterXXReview 定义和 Classical.choose 所用存在命题）。生成 PACKAGE_VALIDATION.json，缺失定义数必须为 0。

## 7. 完成标准
- 第8章正文全部条目落盘；单文件编译、逐条 #print axioms、章末一次完整 check 通过；正式库 0 sorry、0 axiom；第1–7章文件字节未变（含第7章审校中的文件）。
- CH08_BLUEPRINT、CH08_ERRATA、CH08_SUMMARY_FOR_MENTOR 已写（导师语言，不出现工程术语和内部流程话）。
- 任务包已生成，报告批数、子包数、覆盖条数和缺失定义数。
- 提交并 push；CURRENT_STATE 顶部写“第8章本地流程完成，等待用户新指令”，然后停止。
