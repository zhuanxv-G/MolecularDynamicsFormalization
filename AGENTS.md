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


---

## 27号运行检查点

第7章§7.5检查点：47条已落盘，本地单文件与逐声明公理核验通过；本节完整检查复用输入不变的正式库证据并核验当前全章源码。
下一步：继续§7.6精确Gibbs采样，再§7.7形式算符展开。；不进入第8章。

## 历史规则与状态（冲突处以27号为准）

# 26号：第6章复审结果整合 + 最后一轮本地修复 + 收口（2026-10-18 用户指令；第6章不再送网站）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第6章首轮结果已整合，复审包待用户提交”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按26号继续第6章收口”，停止条件为本文第5节完成标准），然后执行。

## 0. 范围
- 唯一任务：第6章最终收口，做法同21号（第1章）和24号（第2–5章）。第1–5章不动；不进入第7章；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站复审返回（60条全部到齐）
- 已交付到 blueprint/ch06/mathcopilot_results/eaudit/EAUDIT01–20_result.json（用户合并成3个任务提交，脚本按 source_id 拆回并逐条校验 input_sha256；"merged_from" 属正常）。Ch06.lean 自打包（30aa0ce4）后未改。
- 合计：PASS 25 / FAIL 8 / NEEDS_HUMAN 27。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。
- NEEDS_HUMAN 27条中绝大多数网站写的是“签名PASS/修正版PASS，原书疑误保留”：按版本分开登记（修正版=网站PASS，原文=原书疑误待导师），不要整组记成未通过。

## 2. 修复 8 条 FAIL（严格按 suggested_fix，不扩大范围）
| source_id | 要点 |
|---|---|
| MD-6.3.6-FPEquation | 按 suggested_fix 处理 |
| MD-6.4.3-Theorem61 | 按 suggested_fix；原书“分布平均 vs 轨道时间平均”冲突与 negative definite 措辞保留为原书疑误 |
| MD-6.4.4-Theorem62 | 签名已 PASS；把 ch06_source.json 中两处 k 改为原页的 κ（转录纠正），并处理 suggested_fix 其余要求 |
| MD-6.4.4-Lemma61Printed | kind 改为编号 lemma；Printed 版缺 C.Nonempty 的空集漏洞保留为原书疑误；按 suggested_fix 处理其余 |
| MD-6.4.4-WeightedH1Norm | 覆盖不全：在 [EXTRA]/docstring 如实缩小覆盖范围，或按 suggested_fix 补两项短陈述（‖f‖²=∫f²dμ 与向量函数分量平方和），可 sorry |
| MD-6.4.5-KernelEvolution | 按 suggested_fix 处理 |
| MD-6.4.5-KernelAverage | 覆盖不全：原句“∫f dμt=∫Kt f dμ0”未表达；按 suggested_fix 补陈述或如实缩小覆盖 |
| MD-6.4.5-SmoothTestL2Printed | 按 suggested_fix 处理（分版审校结论分开登记） |

- 修复只改 blueprint/。每条修完单文件编译 + #print axioms；全部修完跑一次完整 check。下游若编译失败，最小调整并记录。
- 不再送网站：状态记为“按网站审校意见修复，本地核验通过（未再送网站）”；website_audit.json 保留原 FAIL 返回、suggested_fix 原文和逐条改动 diff 摘要。不生成新的 EAUDIT 包。

## 3. 勘误与文档
- 把本轮新确认的原书疑误补入 docs/review/CH06_ERRATA.zh-CN.md（同 CH01_ERRATA 字段），每项更新“网站复审结论”行。
- 重新生成 CH06_BLUEPRINT.zh-CN.md 与 CH06_SUMMARY_FOR_MENTOR.zh-CN.md（第1章格式，导师语言，无工程术语和内部流程话），统计口径同第1章：网站PASS数、本地按意见修复数、原书疑误数、已证/未证声明数及未证原因分类。

## 4. 不做的事
- 不为未证陈述新建大型理论；不再送网站；不进入第7章；不改第1–5章。

## 5. 完成标准
- FAIL 修复中 = 0；单文件编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry、0 axiom。
- ERRATA、BLUEPRINT、SUMMARY_FOR_MENTOR 已更新。
- 提交并 push；CURRENT_STATE 顶部写“第6章最终收口完成，等待用户新指令”，然后停止。


---

## 26号运行检查点

当前任务：第6章复审结果整合与最后一轮本地修复；完成标准以26号第5节为准。
当前进度：26号总验收PASS；本终态随交付提交push后停止，等待用户新指令；不再送网站、不进入第7章。

## 历史规则与状态（冲突处以26号为准）

# 25号：第6章网站首轮审校结果整合 + 修复 + 生成复审包（2026-10-17 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第2–5章最终收口完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按25号继续第6章网站结果整合与修复”，停止条件为本文第6节完成标准），然后执行。

## 0. 范围
- 唯一任务：第6章。第1–5章不动；不进入第7章；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。
- 交付格式一律照第1章（导师已确认）：BLUEPRINT 逐条结构、ERRATA 勘误清单、SUMMARY_FOR_MENTOR。

## 1. 登记网站返回（249条全部到齐）
- 已交付到 blueprint/ch06/mathcopilot_results/BATCH01–42_result.json。用户把42批合并成9个任务提交（任务内重复的依赖定义放在附录，内容逐字相同），再由脚本按 source_id 拆回并逐条校验了 input_sha256；每个 item 自带 subtask 和 input_sha256 字段，文件里的 "merged_from"、"round": "first-merged" 属正常。Ch06.lean 自打包后未改。
- 合计：PASS 179 / FAIL 25 / NEEDS_HUMAN 45。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。原文版/修正版/原书疑误分开记录（同21号）。

## 2. 修复 25 条 FAIL（严格按 suggested_fix，不扩大范围）
网站返回分三类，处理不同：
- **覆盖不全**（statement_scope 声称覆盖整段原文，Lean 只表达一部分；如 WalkIncrement、OUVarianceIntegral、ZeroNoise、HamiltonianPowerMomentumLaplacian、WeightedH1Norm、KernelAverage、BrownianDiscreteSpectrum、Theorem61 漏“全谱点均为特征值”）：优先在 [EXTRA]/docstring 把覆盖范围如实缩小，并把未覆盖结论列入覆盖缺口；只有 suggested_fix 明确要求、且是短陈述时才补声明（可 sorry）。
- **对象资格缺失**（VectorSDE、MomentumOU、VectorIto 未要求 W 为 Wiener/坐标独立；StateMarkovMeaning 的 history 未要求是自然过滤；StationaryDensity 缺非负/归一；KernelEvolution、LangevinForwardSemigroupMeaning 缺 Markov/半群资格；DensityEvolutionMeaning）：补上资格前提或资格谓词，保留总化定义作辅助并在 docstring 说明。
- **陈述本身错误**，必须改签名：
  - WeakItoAlias：补有限和与平方误差的可积资格（采纳网站所指 _corrected 的 L² 条件）。
  - ScalarItoFormula、TimeItoFormula：网站给了反例（D20 只给时间积分平方可积，不能保证网格左和 MemLp 2）。按 suggested_fix 补足前提；补不上就把当前版本标为“前提不足、已知反例”，不要继续证明。
  - OULawPrinted：原页方差是 σ²(1−e^{−2γT})/(2γ)，Lean 把 (1−e^{−2γT}) 平方了——这是转录错误，不是原书疑误。按 PDF 原页重新核对并改正 Printed 版。
  - DeterministicStrobePrinted：gaussianReal 第二参数是方差，按原书标准差读法换算；增量取区间积分。
  - CylinderForwardPrinted：补上原页印出的 1/2。
  - FPDiffusionPrinted：网站认为原页负号转录不忠实。先对照 PDF：若原页确为负号则保留并判原书疑误、修正版取正号；若原页本为正号则改正转录。在 website_audit.json 里写明核对结论。
  - MinorizationCorrectedImplication、ForwardKernelGibbs：网站指出即使修正后仍为假（缺 Chapman–Kolmogorov/半群结构；零通量/平坦可积条件缺失导致存在非 Gibbs 零模）。按 suggested_fix 补结构假设；若补后仍无把握，降为“缺大型理论”的陈述并记录，不证明。
- 修复只改 blueprint/。每条修完单文件编译 + #print axioms；全部修完跑一次完整 check。下游若编译失败，最小调整并记录。

## 3. NEEDS_HUMAN（45条）分流
- **任务包摘录缺失**（不是原书问题）：多条因 D52 `actual_path_solution_exists` 的规格、`textbookIteratedBracket`、`Chapter06Review.invariantKernel`、`textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp` 等项目定义没摘录进任务包，网站无法核定语义（LangevinHormander、LangevinTransitionDensity、Lemma61Nonempty、LangevinGeometricErgodicity、LangevinTimeAverage、WeightedH1、Proposition64Relative、Definition61、StationaryInvariant 等）。修复打包脚本，确保这些定义体进入摘录，这些条目进入第5节复审包。
- **原书疑误**（网站写“签名忠实/修正版正确，仅原书表述有疑”）：并入 CH06_ERRATA，原文版+修正版+反例照第1章格式；缺修正版的补 _corrected（时间盒3条路线，原文版不证）。BrownianRealEigenvalue 按网站意见补 negative definite 勘误标记。
- **签名需加强/范围需签核**（如 Lemma61Printed 把相空间扩大、BrownianClosedSelfAdjoint 替换了 C₀² 核心域、Theorem62 的 kernelGenerator 只是 derivWithin 总定义）：按网站意见收紧或在 [EXTRA] 写明，记入勘误或覆盖缺口，进入复审包。

## 4. 勘误与文档
- 更新 docs/review/CH06_ERRATA.zh-CN.md（同 CH01_ERRATA 字段，每项加“网站审校结论”行；同一问题多条合并并注明 source_id）。
- 重新生成 CH06_BLUEPRINT.zh-CN.md（第1章结构，含网站结论）和 CH06_SUMMARY_FOR_MENTOR.zh-CN.md（导师语言，不出现工程术语和内部流程话）。

## 5. 复审包（第6章是首轮，修复后需送网站复审一次）
- 为本轮改过签名的条目（25条FAIL修复 + 摘录缺失的 NEEDS_HUMAN + 签名收紧的 NEEDS_HUMAN）生成 EAUDIT 复审包，格式与第2–5章 EAUDIT 相同（blueprint/ch06/mathcopilot_tasks/EAUDITxx/ 下 a/b/c 子任务，各含 MANIFEST.json、PASTE.txt、PAGES.pdf；PROGRESS 中这些条目标“待复审 / EAUDITxx”）。PASTE 开头带“以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”，内嵌哈希，且必须包含本条用到的全部项目定义体。
- 不提交、不等网站；用户会合并提交。

## 6. 完成标准
- FAIL 修复中 = 0；单文件编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry、0 axiom。
- ERRATA、BLUEPRINT、SUMMARY_FOR_MENTOR 已更新；EAUDIT 复审包已生成，列出包数和条数。
- 提交并 push；CURRENT_STATE 顶部写“第6章首轮结果已整合，复审包待用户提交”，然后停止。不进入第7章。


---

## 历史规则与状态（冲突处以25号为准）


# 24号：第2–5章网站复审结果整合 + 最后一轮修复 + 按第1章格式收口（2026-10-17 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第6章本地流程完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按24号继续第2–5章收口”，停止条件为本文第6节完成标准），然后执行。

## 0. 背景与范围
- 导师已确认：第1章的交付格式（CH01_BLUEPRINT 逐条结构、CH01_ERRATA 勘误清单、CH01_SUMMARY_FOR_MENTOR 摘要）完全可以，后续章节一律按此格式。
- 本轮唯一任务：第2–5章最终收口，做法与21号（第1章）相同。
- 第1章、第6章不动；不进入第7章；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站返回（380条全部到齐）
- 已交付到 blueprint/ch0{2,3,4,5}/mathcopilot_results/eaudit/EAUDITxx_result.json（第2章 EAUDIT74–96，第3章 67–85，第4章 69–91，第5章 43–62）。用户把它们合并成28个任务提交，再由脚本按 source_id 拆回并逐条校验了 input_sha256；文件里的 "merged_from" 字段属正常，原始合并返回在仓库外，无需读取。
- 合计：
  - 第2章 75条：PASS 59 / FAIL 4 / NEEDS_HUMAN 12
  - 第3章 78条：PASS 55 / FAIL 10 / NEEDS_HUMAN 13
  - 第4章 110条：PASS 91 / FAIL 7 / NEEDS_HUMAN 12
  - 第5章 117条：PASS 97 / FAIL 6 / NEEDS_HUMAN 14
- 登记入各章 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。含原文版/修正版/反例的条目，原文版、修正版、原书疑误三者分开记录（同21号）。

## 2. 修复 27 条 FAIL
- 严格按各条返回中的 suggested_fix 修改，不自由发挥、不扩大范围。典型两类：
  - 覆盖不全（statement_scope 声称覆盖整段原文，但 Lean 只表达了其中一部分）：优先在 [EXTRA]/docstring 里把本条覆盖范围如实缩小，并把未覆盖的结论列入覆盖缺口记录；只有 suggested_fix 明确要求、且是短陈述时才补声明（补的声明可以 sorry，不建大型理论）。
  - 缺前提/有效域（如 RESPA 的 r>0、DipolarPotentialSum 的非碰撞、WeakAttractor 的 IsProbabilityMeasure μ、HardCoreDomain 的半径非负）：补上前提，保留总化定义作辅助并在 docstring 说明。
- 修复只改 blueprint/。每条修完单文件编译 + #print axioms；每章修完跑一次完整 check。下游声明若因签名变化编译失败，最小调整并记录。
- 不再送网站：状态记为“按网站审校意见修复，本地核验通过（未再送网站）”；website_audit.json 保留原 FAIL 返回、suggested_fix 原文和逐条改动 diff 摘要。不生成新的 EAUDIT 包。

## 3. 特殊条目
- MD-4.2.1-FastVerlet（NEEDS_HUMAN）：网站只因任务包没摘录 Chapter02Review.verlet 的定义体而无法确认。请本地核对该定义确为 kick(h/2)→drift(h)→kick(h/2)，若是，记为“本地核验通过（网站因摘录缺失未判）”，不算原书疑误。
- 其余 NEEDS_HUMAN 若网站正文写的是“签名忠实/修正版正确，仅原书表述有疑”，按原书疑误处理（第4节）。

## 4. 勘误清单（与 CH01_ERRATA 同格式）
- 为每章新建 docs/review/CH0{2,3,4,5}_ERRATA.zh-CN.md。字段与 CH01_ERRATA 相同：原文逐字、页码、问题所在、反例、原文版/修正版声明名及状态、核查点、选项，并加一行“网站复审结论”（原文版/修正版/反例各自的 verdict）。
- 收录：此前已登记的“待导师”条目（PROGRESS 中第2章18、第3章20、第4章27、第5章15条）+ 本轮新的原书疑误类 NEEDS_HUMAN。同一问题出现在多条时合并为一项，注明涉及的 source_id。
- 原文版与修正版都要保留：缺修正版的疑误条目补一个 _corrected 声明（正常尝试证明，时间盒3条路线）；原文版不证明。

## 5. 文档统一为第1章格式
- 各章 CH0x_BLUEPRINT.zh-CN.md 的每条按 CH01_BLUEPRINT 的结构重新生成：原文陈述 → 原文证明 → 完整当前Lean（原文与修正版独立列出）→ 对照表 → [EXTRA] → 审计结论（含网站结论）→ 状态与证明位置。
- 各章写 docs/review/CH0x_SUMMARY_FOR_MENTOR.zh-CN.md，结构照 CH01_SUMMARY_FOR_MENTOR：用导师能读懂的语言（不出现 sorryAx、checked+documented priors、字节预算、历史绑定哈希等工程术语，也不写“等待用户指令/第6章暂停”之类内部流程），给出：网站PASS数、本地按意见修复数、原书疑误数（附勘误清单链接）、已证/未证声明数及未证原因分类（缺大型理论 / 原书疑误不证 / 时间盒止）。
- CH0x_REVIEW_SHORT.zh-CN.md 若统计已过时，按新数字更新或在文件开头标明“已过时，以 SUMMARY_FOR_MENTOR 为准”。

## 6. 完成标准
- 第2–5章 FAIL 修复中 = 0；单文件编译、逐条 #print axioms、每章一次完整 check 通过；正式库 0 sorry、0 axiom。
- 四章各有 BLUEPRINT（第1章格式）、ERRATA、SUMMARY_FOR_MENTOR。
- 提交并 push；CURRENT_STATE 顶部写“第2–5章最终收口完成，等待用户新指令”，然后停止。不回第6章，不进入第7章。

---

## 历史规则与状态（冲突处以24号为准）

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


---

## 22号运行检查点

当前任务：第6章本地流程，从148条已验证检查点接续；第1–5章冻结，不进入第7章。
下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。

## 历史规则与状态（冲突处以22号为准）

# 21号：第1章网站复审结果整合 + 最后一轮修复（2026-10-16 用户指令；第1章不再送网站）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部，并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重），然后执行。

## 0. 优先级
- 第6章：当前批次到最近的已验证检查点提交后暂停。
- 唯一任务：第1章最终收口。第2–5章不动；不进入第7章；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站返回（93条全部到齐）
- 已交付到 blueprint/ch01/mathcopilot_results/eaudit/EAUDIT04–23_result.json（用户为减少上传次数，把20批合并成5个任务R1–R5，再由脚本按 source_id 拆回各 EAUDIT 并校验了每条 input_sha256，原始合并返回在仓库外 mathcopilot_inbox/ch01_merged/，无需读取）。文件里有 "merged_from" 字段，属正常。
- 合计：PASS 62 / FAIL 10 / NEEDS_HUMAN 21。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。
- 对含原文版/修正版/反例的条目，网站普遍给出“原文版忠实 PASS、修正版 PASS、原书疑误 NEEDS_HUMAN”。登记时把这三者分开记录（例如 修正版=网站PASS，原文=原书疑误待导师），不要把整组记成未通过。

## 2. 修复 10 条 FAIL（严格按网站 suggested_fix，不自由发挥、不扩大范围）
| source_id | 修复要求 |
|---|---|
| MD-1.1.2-AngleBond | 加两键长非零/正的有效域谓词（或子类型）；保留现有公式作为总化辅助并在 docstring 说明；同时采纳 corrected_json（删除多余 k）。不改原书有向差约定。 |
| MD-1.1.2-GayBerne | 加 Gay–Berne 有效域谓词：u₁,u₂ 单位、q₁≠q₂、根号内严格正、σₛ/εₛ/μ 及各分母非零、Δ≠0；在该域上给出模型。不改 ε₂ 次数和 Δ。 |
| MD-1.2-NewtonCompact | compactNewton 加 DifferentiableAt ℝ U (q t)（或 HasFDerivAt）；保留现有时间导数条件。 |
| MD-1.2-HarmonicSolution | 补谐振子能量定义 E=‖v‖²/2+Ω²‖x‖²/2 并与本条连接。唯一性：若现有材料能短证（时间盒3次）则补；否则在 [EXTRA]/docstring 明确“本条正式覆盖不含唯一性”，不建大理论。 |
| MD-1.2-ScalarMechanical | 补标量能量定义 E_U(x,v)=v²/2+U(x) 并在本条中显式出现。 |
| MD-1.2-LJTimeScaling | 只把 [EXTRA] 中容差 0.005ps 改为与签名一致的 0.01ps（采纳 corrected_json）；不改定理。 |
| MD-1.5.2-ScalarFirstIntegral | 不补转向点/平衡点理论；在 [EXTRA]/docstring 明确本条为“能量守恒 + 非转向点局部求积”的部分形式化，并把转向点、平衡点列入覆盖缺口记录。 |
| MD-1.6-PeriodicTranslationMomentum | 键能量改为 φ ‖y−x+(if closing then L else 0)‖（即 φ∘|·|），第三定律对 ψ=φ∘|·| 在该差值处的可微性陈述；主定理不动。 |
| MD-1.6-RhombicLattice | 为作为二维格的入口加 a>0、b>0、sin θ≠0（或 0<θ<π）；保留一般生成集合作为辅助定义。不强加 a=b。 |
| MD-1.6-UnitCell | 要求 B 可逆（det B≠0 或列线性无关），motif 有限非空且位于 B([0,1)³)；保留一般平移并集作为辅助定义。 |

修复只改 blueprint/，每条修完单文件编译 + #print axioms；10条全部完成后跑一次完整 check。下游若有声明因签名变化编译失败，最小调整并记录。

## 3. 不再送网站（用户决定）
- 本轮修复的10条状态记为“按网站审校意见修复，本地核验通过（未再送网站）”，在 website_audit.json 中保留原 FAIL 返回和对应 suggested_fix 原文，并逐条记录实际改动 diff 摘要，供人工核对。
- 不生成新的 EAUDIT 复审包。

## 4. 勘误清单补充
- 把本轮 NEEDS_HUMAN 中原清单未覆盖的原书问题补进 docs/review/CH01_ERRATA.zh-CN.md（同样字段：原文逐字、页码、问题、反例、原文版/修正版名称和状态、核查点、选项）。至少核对以下是否已覆盖，未覆盖的新增：
  - MD-1.6-PeriodicImages：原书 vᵢ 类型前后矛盾（全构型重复块 vs 三维位移），Lean 采用按粒子三维块解释。
  - MD-1.6.1-RealNormalMode：原书称任意复系数解可“改写”为实式，仅对实值解（b=ā）成立。
  - MD-1.6.1-MinimumGradientZero：原句“regardless of boundary”对约束边界极小不成立（U(x)=x 在 [0,1] 于 0 处）。
  - MD-1.4-PhaseSpace：“positions and velocities”笔误为 positions and momenta（若已在清单中则补网站结论）。
  - MD-1.1.2-Yukawa：κ 称为长度与 −κr 量纲冲突（同上）。
- 每个勘误条目追加一行“网站复审结论”（原文版/修正版/反例各自的 verdict）。

## 5. 完成标准
- FAIL 修复中 = 0；单文件编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry。
- 更新 docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md：用导师能读懂的语言（不出现 sorryAx、checked+documented priors、字节预算等工程术语），给出：网站PASS数、本地按意见修复数、原书疑误数（附勘误清单链接）、已证/未证数及未证原因分类。
- 提交并 push；CURRENT_STATE 顶部写“第1章最终收口完成，等待用户新指令”，然后停止，不自动回第6章。

---

## 历史规则与状态（冲突处以21号为准）

# 当前任务与约定

当前任务：继续完成第6章本地①–⑤流程；第1–5章已完成交付保持冻结，不进入第7章。
下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。

本次用户明确恢复第6章，覆盖19号对第6章的暂停。正式库字节冻结、0 sorry，固定Lean/Mathlib v4.34.0。
每批≤8条落盘/单文件编译，每节完整check、逐声明公理检查、文档和commit+push；复用通过证据。
仅本地PASS证明；现成桥接优先，单条三次失败或缺大型理论则保留sorry并记录，不恢复封存证明。
Thm6.1/6.2/Prop6.4无整条现成桥接则sorry。网站仅生成compact及完整包，不提交，统一待网站审计。
全部本地流程完成后停止于第6章；第1–5章网站复审/导师裁定仍待用户处理。

## 历史状态（暂停已由本次用户明确恢复）

当前终态：第1章收口完成，等待用户提交第1章 EAUDIT 复审包（见 EAUDIT_INDEX.md）。本轮已结束；只有用户明确新指令才恢复推进。第6章暂停，不进入第7章。

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


---

## 历史规则与状态（冲突处以19号指令为准）

# 项目接续与形式化约定

当前任务：继续完成第6章本地流程（印刷211–258 / PDF232–279）；第2–5章沿用已完成修复验收，不进入第7章。
下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。

## 当前最高优先级范围（用户2026-10-16新指令）

- 恢复第6章本地①–⑤流程；第2–5章审核修复已完成，不重新展开修复队列。第1章按原规则暂停；MolecularDynamics/正式库字节冻结、0 sorry；不进入第7章。
- 每批≤8条及时落盘并单文件Lean编译；每节完整scripts/check.ps1、逐条#print axioms、七段文档及commit+push。沿用Lean/Mathlib v4.34.0。
- 仅本地PASS条目证明：现成正式桥接→短证明；三条失败路线或缺大型理论即sorry+缺项继续。Thm6.1/6.2/Prop6.4没有整条现成桥接则sorry；不恢复封存断点或长证明。
- 保留完整对象、量词、前提及全部结论；EXTRA/ERRATUM?明确，禁True、P→P、结论作假设、admit、新axiom/unsafe。JSON/旧映射/模板C/compact/完整版BATCH/INDEX齐全；每个PASTE+原页PDF+MANIFEST合计<256000字节，只生成不提交网站。
- 网站未审写待网站审计，含sorryAx必须incomplete；最终状态仅self-contained / checked+documented priors / incomplete。每检查点更新PROGRESS、LOCAL_PIPELINE及WORK_LOG≤3行，复用已通过证据，保留未提交半成品及其他任务文件。
- 全部本地流程完成后更新CURRENT_STATE终态并停止于第6章；已完成第2–5章EAUDIT网站复审与导师判断仍待用户处理。

## 历史交接（暂停第6章及停止推进已被本次新指令覆盖）

# 项目接续与形式化约定

第2–5章修复完成，等待用户提交 EAUDIT 复审包（见各章 mathcopilot_tasks/EAUDIT*/INDEX.md）
下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。

## 当前最高优先级范围（用户2026-10-14晚指令）

- 顺序第2→3→4→5章，每章按节；第1章按原规则继续登记/修复，优先级较低。第6章暂停于WIP 6b822a9a524f，第7章禁止进入。
- 修复队列docs/handoff/REPAIR_QUEUE.md为准。A漏前提/定义域：补签名或子类型并标[EXTRA]；B漏结论：优先补全，跨source_id才显式缩statement_scope并追加repair_log；C对象不忠实：按网站路线修，需路线选择或书中疑误则仅记NEEDS_HUMAN；D数学判断仅登记问题、选项、网站反例并保持现状。
- 修复阶段不写新证明。已有证明受签名影响仅尝试≤3次小修补，失败保留sorry并记录；新证明留到复审PASS冻结后。
- 每批≤8条：单文件编译、相关已有证明重查、逐条#print axioms、生成EAUDIT复审包。完整scripts/check.ps1仅每章结束一次；每节commit+push。固定Lean/Mathlib v4.34.0，正式库源码/签名冻结且0 sorry。
- 返回件按WEBSITE_AUDIT_RULES.zh-CN.md绑定快照；第2章reaudit审计优先、第一轮json_review优先。旧快照PASS不自动覆盖新签名。原始返回/旧绑定收据不改，工程外mathcopilot_bundles只读。
- CORRECTED对照PDF原页视觉复核后合并源JSON；repair_log只追加，不静默删句。[EXTRA]、[ERRATUM?]及直接/传递sorry风险明确登记。
- 每个PASTE开头声明仅以本PASTE及附件为准、忽略网站/workspace旧版本，Mathlib标准定义按标准数学含义采信；全部input_sha256值直接写出并要求原样回显。网站用代码写入/workspace/.mathcopilot/reviews/chXX_eaudit/EAUDITxx_review.json对象(batch,input_sha256,items)，json.loads自检后仅回复路径和统计。每章EAUDIT INDEX列出待提交包。
- heartbeat lean保持ACTIVE/15分钟/原target和去重机制，仅额度明确中断且恢复才接续；运行/排队安静。REPAIR_QUEUE显示第2–5章全部修复完成则停止发送。配置保存不等于恢复续接已实测。
- 每检查点更新CURRENT_STATE并追加WORK_LOG≤3行；每章一行网站PASS/已修待复审/待导师/修复中。全部完成顶部写“第2–5章修复完成，等待用户提交 EAUDIT 复审包（见各章 mathcopilot_tasks/EAUDIT*/INDEX.md）”，停止只确认状态。
- 先git status，读AGENTS、CURRENT_STATE顶部、WORK_LOG最新和REPAIR_QUEUE，复用已有通过证据。保留其他任务output/tmp/check-full06等，不动不提交。

## 第1章规则（网站审计修复时适用）

- 第1章正文印刷p.1–45，习题除外；逐字JSON → 忠实Blueprint → 每批≤8条A原文审校+C只读语义审计包 → 本地预审PASS后在Blueprint证明 → 自动渲染全章文档。模板B取消。
- 原5条试点为BATCH01，原15任务已归档。网站只由用户提交；Codex只生成任务包并整合返回件，不控制网站，不等待网站才开展本地证明。
- MolecularDynamics/正式库不改源码或签名、保持0 sorry；Blueprint/允许by sorry。禁止admit、新增axiom、unsafe绕过、True、P→P、结论作假设或凭空新增对象。
- 保留对象、量词、假设及全部结论；额外前提逐条[EXTRA]，疑似原文错误[ERRATUM?]，不确定原文NEEDS_HUMAN。必须渲染PDF原页核对；单个符号放context_notation；定性描述合并或登记excluded_qualitative。旧CH01_CLAIMS.csv全部映射。
- PROGRESS.md为唯一逐条进度表；local_audit.json使用模板C判定，只有本地PASS条目进入新证明。网站未返回写待网站审计，不伪造网站PASS或冻结。
- 优先桥接既有证明→短证明→其余；单条3次失败或缺大型理论则保留sorry、记录缺项并继续；需要导师判断的问题记录后继续，无人回复时不等待。
- 按节提交；每小批单文件lake env lean，每节结束完整scripts/check.ps1，固定Lean4.34.0/Mathlib v4.34.0，不升级。逐条#print axioms，含sorryAx必须incomplete；区分直接与传递占位风险。
- scripts/render_blueprint.py生成docs/review/CH01_BLUEPRINT.zh-CN.md；每条7段并有汇总及NEEDS_HUMAN/[ERRATUM?]列表。状态只用self-contained / checked+documented priors / incomplete。
- 每次唤醒只读AGENTS、CURRENT_STATE顶部、WORK_LOG最新、PROGRESS.md，再按下一步读相关输入。每检查点更新CURRENT_STATE，WORK_LOG≤3行；不向STATUS/FORMALIZATION_MAP/ASSUMPTIONS追加长文。
- 首次接续核验Git分支、HEAD、未提交文件，保留其他任务文件。commit+push已授权；每节一次commit。
- heartbeat lean保持ACTIVE/15分钟；prompt按2026-10-14指令限于第2–5章网站修复，原target和去重机制保留。第1章规则仅暂停时的新返回件整合适用。完成标准：全章JSON/Blueprint/本地预审/批次包齐全、能证已证、文档生成、check通过、push。完成后顶部写“第1章本地部分完成，等待用户提交 MathCopilot 批次（见 INDEX.md）”，以后只确认状态。
- mathcopilot_results/出现新返回件时优先合并JSON审校和语义审计，登记EAUDIT批次；保留原始件、repair_log只追加，签名修复后重新审计。
- 默认中文先说重点，明确原页核对、Lean编译、公理审计、网站审计、导师确认哪些已验证。本次用户新指令取代试点5条后等待及先冻结再证明限制。


## 2026-10-13网站整合补充

用户新指令及操作细则见[WEBSITE_AUDIT_RULES.zh-CN.md](docs/handoff/WEBSITE_AUDIT_RULES.zh-CN.md)。旧的缺绑定一律不提升规则已撤销；依赖闭包位于工程外，只读引用。第2章第一轮C仅参考，reaudit audit优先、json_review以第一轮为准。heartbeat不改。
