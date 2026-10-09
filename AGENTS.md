# 项目接续与形式化约定

当前任务：五步流程第1章试点（5条，见 blueprint/ch01/PILOT.md）。完成后停止等待用户。

## 当前最高优先级范围（2026-10-09）

- 2026-10-09最新任务包约定：每批一个文件，本批只提交`blueprint/ch01/mathcopilot_tasks/PILOT_ALL.md`，五条在一个Task中先A原文审校、再C只读语义审计，输出单个JSON数组；模板B已取消。原15文件归档保留。后续各章同样每批一个文件，优先<40KB，必要时最多两个；非PASS修复后只生成一个PILOT_REAUDIT.md，限需复审条目。
- 返回件为`mathcopilot_results/PILOT_ALL_result.md|json`，Codex按PILOT.md一次性整合；旧单条prepare/ingest脚本（含--freeze）本批停用，不能要求用户拆分数组或等待B。冻结只需当前原文approved、当前签名全部语义PASS、issues闭合；保留原始返回件，repair_log只追加。

- 按导师workshop五步流程：逐字原文JSON → Lean Blueprint → 只读审计、修复、复审、冻结签名 → 证明冻结陈述 → 忠实性、fresh check、直接风险和依赖闭包终验。
- 仅处理PILOT.md中5条。第1–6章已有MolecularDynamics/源码、证明和签名全部保留，作为可复用证明素材；不进入其他条目或第7章，第6章封存断点保持原样。
- MathCopilot网站仅由用户本人操作。Codex负责本地起草、任务包、接收结果、整合、本地证明和检查；不控制浏览器、网站、代发任务或轮询服务。
- heartbeat lean保持ACTIVE / 15分钟，不修改。网站返回件缺失时继续独立本地工作，最终停在“等待网站结果”，列出缺件；不得伪造PASS或冻结。
- Blueprint/目录允许by sorry表示未证陈述；MolecularDynamics/正式库仍0 sorry。禁止admit、新增axiom、unsafe证明绕过、True、P→P或把结论作为假设。
- 第2步允许直接复用既有证明或建立由既有定理推出陈述的包装。新的实质证明仅在条目frozen后开展；冻结后不改签名、不弱化、不加假设。陈述有误退回审计。
- 原文逐字核对教材PDF原页，页号从1起算，跨页拼接；不确定处记NEEDS_HUMAN。额外技术前提逐条标[EXTRA]，疑似原文错误记JSON issues并标[ERRATUM?]，不得静默改正。
- JSON修复日志只追加。只读审计与修复、复审使用不同任务。全部条目经当前文件版本审计PASS后才标记frozen；第1章最终交付后写“第1章试点已交付，等待用户/导师确认格式”，之后只确认状态。

## 接续与验收

- 每次唤醒只读本文件、CURRENT_STATE顶部、WORK_LOG最新条目及blueprint/ch01/下文件；按具体下一步读取相关源码/API。
- 首次接手检查实际Git分支、HEAD和未提交文件。保留其他任务遗留的改动和未跟踪文件，禁止直接覆盖或清理。
- scripts/check.ps1验正式库无占位及固定版本构建，并登记Blueprint输入和单独风险扫描；Blueprint逐条运行#print axioms，含sorryAx的条目必须incomplete。构建通过不等于语义审计通过。
- 终验分类只使用self-contained Lean proof / checked proof + documented priors / incomplete；明确直接占位风险与传递导入风险的区别。
- 保持Lean 4.34.0、Mathlib v4.34.0固定版本，不升级。Lean源码变化后运行pwsh -NoProfile -File scripts/check.ps1；纯文档变更不重复全检。
- scripts/render_blueprint.py从JSON、Blueprint和audit自动生成docs/review/CH01_PILOT.zh-CN.md；不能把待审草案标成最终交付。
- 每个独立小任务或长任务检查点更新CURRENT_STATE，WORK_LOG每检查点≤3行；不向STATUS、FORMALIZATION_MAP、ASSUMPTIONS追加长文。最终或待返回件检查点commit + push（用户已授权）。
- 默认中文，先说重点。明确区分原页核对、Lean编译、公理审计、网站语义审计和导师确认哪些已验证、哪些未验证。

旧章节交付流程和“只在本地、不使用MathCopilot”的旧约定已被本次指令替代；历史证据保留在日志及章节文档。
