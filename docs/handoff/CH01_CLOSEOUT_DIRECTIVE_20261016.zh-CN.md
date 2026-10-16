# 19号：第1章收口 + 原文/修正版双版本（2026-10-16 用户指令，覆盖此前“第1章暂停/低优先级”）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部，并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重），然后再开始执行。

## 0. 优先级
- 第6章：把当前 WIP（批27）提交为 WIP 检查点后暂停，不再推进；不进入第7章。
- 第2–5章：修复已完成（终验 93d2d3e5），保持不动，等待用户提交 EAUDIT 复审包。
- 当前唯一任务：第1章收口，目标是可以交给导师（师兄）审阅的完整版本。
- 正式库 MolecularDynamics/ 仍保持 0 sorry、字节冻结；所有改动在 blueprint/ 内。

## 1. 先登记未处理的网站返回
- blueprint/ch01/mathcopilot_results/eaudit/EAUDIT02_result.json、EAUDIT03_result.json（目前 untracked）以及 ch01/validation/EAUDIT01-return-registration/ 登记入库。
- 注意：EAUDIT02 的 HardSphere、EAUDIT03 的 MorseMinimum/LengthBond/HeterogeneousLJ 曾被网站 /workspace 中的旧 Ch01.lean 干扰；判定时以返回中对附件签名的语义结论为准，哈希不一致仅由旧文件引起的，记为“需复审”，不要记为 FAIL。
- 更新 WEBSITE_SUMMARY.json、PROGRESS.md。

## 2. 修复第1章 21 条网站 FAIL
- 按第2–5章相同做法（REPAIR_QUEUE 四类：漏前提/漏结论/对象不忠实/原书疑误）修签名，每节完成后生成 EAUDIT 复审包，PASTE 开头沿用第2–5章的“以本 PASTE 和附件为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”，并内嵌哈希。
- 62 条“已修待复审”中凡尚无现行复审包的，一并生成；最后写 ch01/mathcopilot_tasks/EAUDIT_INDEX.md，只列现行待提交包。

## 3. 原书疑误条目：原文版 + 修正版 + 问题标注（导师明确要求）
导师意见：“既要留原文和修正后的，也要标注一下问题所在，方便找人来 check。”
适用范围：NEEDS_HUMAN.md (ii) 的 9 条，以及 PROGRESS.md 中所有标注“字面假命题/待导师裁定/勘误”的条目（如 MinimumHessianLiteral、HartmanGrobmanLiteral、ConstantRotationLiteral、TransitivityErgodicityLiteral、VariationalEquationLiteral、NearbyTrajectoryLiteral、TrimerEscapeLiteral、TorusDense、LocalActionAngleReduction、ConvexLegendre、LJRepulsion 等）。对每一条：
1. 原文版：保留现有 *Literal 声明，签名逐字忠实，不改；仍为 sorry；docstring 首行加【原书疑误】。
2. 修正版：新增独立声明（命名 `<原名>_corrected`，若有两种合理修正可加 `_corrected_a/_b`，对应 NEEDS_HUMAN 中的两个选项），docstring 写“修正版，对应原文 <source_id>，改动：……”。修正版能用现有材料证明的就证明（遵守时间盒：同一路线失败3次即止，保留 sorry 并记录原因）；需要大型缺失理论（一般 Hartman–Grobman、一般 Kronecker 稠密、Liouville–Arnold 等）的只写陈述、保留 sorry，不建设大理论。
3. 若某条原文按字面实际可以被反驳，尽量给出 Lean 反例证明（如极小点 Hessian 只能半正定：U(x)=x⁴ 在 0），声明命名 `<原名>_counterexample`；做不出就在文档里写数学反例。
4. 问题标注：新建 docs/review/CH01_ERRATA.zh-CN.md，每条一节，固定字段：
   - source_id；印刷页 / PDF 页；原文引文（逐字）
   - 问题所在（一两句话，说清楚哪里不严谨）
   - 反例或理由
   - 原文版 Lean 名称及状态（sorry，不证）
   - 修正版 Lean 名称、改动内容、证明状态（已证 / sorry + 原因）
   - 待人工核查点（请核查人重点看什么）
   - 导师选项（沿用 NEEDS_HUMAN 的选项，标注我们默认采用哪个）
   该文件要能脱离仓库单独发给第三方核查人阅读。
5. 修正版也纳入网站复审包（与原文版同包，PASTE 中说明“原文版为忠实转录，修正版为勘误版本，请分别审校”）。

## 4. 第1章完成标准
- 网站 FAIL 修复中 = 0；所有待复审条目都有现行复审包且列在 EAUDIT_INDEX.md。
- CH01_ERRATA.zh-CN.md 完成，覆盖第3节全部条目。
- 单文件编译 + 逐条 #print axioms + 一次完整 check 通过（只在第1章做完后跑一次完整 check）。
- 生成一份给导师的总结 docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md（≤2页）：条目总数、网站 PASS/待复审数、已证/sorry 数及 sorry 分类（原书疑误不证 / 缺大型理论 / 时间盒止）、勘误清单链接。
- 提交并 push 后，CURRENT_STATE 顶部写“第1章收口完成，等待用户提交第1章 EAUDIT 复审包（见 EAUDIT_INDEX.md）”，然后停止，不自动回第6章，等待用户新指令。
