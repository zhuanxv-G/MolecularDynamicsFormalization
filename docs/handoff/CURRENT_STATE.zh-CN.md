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

第7章§7.4检查点：44条已落盘，本地单文件与逐声明公理核验通过；本节完整检查复用输入不变的正式库证据并核验当前全章源码。
下一步：继续§7.5扰动谐振子与§7.6精确Gibbs采样，再按顺序推进。；不进入第8章。

## 历史规则与状态（冲突处以27号为准）

# 第6章最终收口完成，等待用户新指令

26号验收：60条复审已核验输入绑定（25 PASS / 8 FAIL / 27 NEEDS_HUMAN）；8项按网站建议处理，修复中0。逐项单文件编译、全部324声明的#print axioms及一次完整check通过。正式库298个Lean文件0 sorry、0 axiom；正式库和第1–5章冻结字节一致。

最新网站直接PASS203条；复审27个NEEDS_HUMAN组中22组的正确版本另行保留PASS。原网站FAIL和suggested_fix原文、逐条diff摘要完整保存；八项当前修改状态为“按网站审校意见修复，本地核验通过（未再送网站）”。未再送网站，未生成新EAUDIT包，旧包保留。

CH06_ERRATA、CH06_BLUEPRINT、CH06_SUMMARY_FOR_MENTOR已更新：32项合并原书疑误/论证或范围待核问题，另1项解释记录；123定义、110已证、91未证。未证原因21项原书疑误不证、52项缺大型理论或必要衔接、18项时间盒止；两条新增L²短陈述按许可保留待证。

证据：blueprint/ch06/closeout26/DELIVERY_VALIDATION.json、FINAL_COMPILE.json/.log、full/CHECK_REPORT.json。原页PDF265/273/276/279本轮目视核过，转录纠正与原书疑误分别记录。

本终态和日志随交付提交推送后停止，Git实际提交与origin一致性由终验命令确认。导师裁定及91项完整证明尚未完成；八项本地修改不作再次网站审校。heartbeat保留ACTIVE/15分钟/原target/去重，26号第5节完成后停发；自动额度恢复续接未端到端实测。

---

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
当前进度：26号本地及文档总验收PASS；随本终态提交push后停止，不再送网站，不进入第7章。

## 历史规则与状态（冲突处以26号为准）

# 第6章首轮结果已整合，复审包待用户提交

25号完成：249条首轮返回已登记（179 PASS / 25 FAIL / 45 NEEDS_HUMAN）；25条FAIL按建议处理，修复中0；45条待人工项已分流。逐项单文件编译、最终321个声明的公理检查和一次完整check均通过。

CH06_BLUEPRINT、CH06_ERRATA、CH06_SUMMARY_FOR_MENTOR已更新；34项合并疑误/范围解释。123个定义、109个已证陈述、89个未证陈述分别记录；未证陈述没有当作已证明。

复审材料：blueprint/ch06/mathcopilot_tasks/EAUDIT01–20，共20包、60条，含1条下游最小接口适配；每包a/b/c各含MANIFEST.json、PASTE.txt、PAGES.pdf。索引为EAUDIT_INDEX.md。本轮未提交网站，不等待网站。

验收：blueprint/ch06/closeout25/DELIVERY_VALIDATION.json；最终单文件/公理证据FINAL_COMPILE.json、FINAL_COMPILE.log；完整check为full/CHECK_REPORT.json。正式库0 sorry/0 axiom；正式库与第1–5章冻结文件字节一致。

下一步：停止，复审包待用户合并提交。修改版复审、未证结论证明和导师裁定仍未完成，等待用户新指令；不进入第7章。heartbeat保留ACTIVE/15分钟/原target/去重，25号第6节完成后停止接续发送。

---

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


24号最终验收：671条审阅稿、四章BLUEPRINT/ERRATA/SUMMARY_FOR_MENTOR共12份文件齐全；380条网站返回已登记，27条FAIL全部按建议本地修复，修复中0。四章单文件、逐声明公理及最终完整check全部通过。正式库298个Lean文件0 sorry/0 axiom，3084个冻结文件字节一致；第1章、第6章不改，未进入第7章，未再送网站。

| 章节 | 网站PASS（含此前） | 本地修复 | 合并勘误 | 定义 / 已证 / 未证 | 导师摘要 |
|---|---:|---:|---:|---|---|
| 第2章 | 126 | 4 | 25 | 85 / 59 / 78 | [CH02](../review/CH02_SUMMARY_FOR_MENTOR.zh-CN.md) |
| 第3章 | 106 | 10 | 30 | 73 / 59 / 103 | [CH03](../review/CH03_SUMMARY_FOR_MENTOR.zh-CN.md) |
| 第4章 | 133 | 7 | 26 | 130 / 65 / 79 | [CH04](../review/CH04_SUMMARY_FOR_MENTOR.zh-CN.md) |
| 第5章 | 148 | 6 | 26 | 97 / 57 / 100 | [CH05](../review/CH05_SUMMARY_FOR_MENTOR.zh-CN.md) |

总验收证据：`blueprint/closeout24/DELIVERY_VALIDATION.json`；分章完整检查见各`ch0x/full/CHECK_REPORT.json`。FastVerlet已证明为半kick→整drift→半kick，不算原书疑误。360条未证声明按三类原因逐条保留，编译通过不等于它们已证明；新增/修改版本未再送网站，勘误待导师裁定。heartbeat保留ACTIVE/15分钟/原target/去重，完成条件已满足，后续唤醒应停止。

本状态随最终提交保存并推送至`origin/chapter06-blueprint`；提交身份以本文件所属的最新Git提交为准。当前停止，不回第6章，不进入第7章。

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

249条正文全部落盘；章末完整check通过；详见CH06_SUMMARY_FOR_MENTOR与CLOSEOUT22。

249条正文及全部勘误配对已通过单文件和逐声明检查；最后批errata22-06-0a02a34ec6。章末完整check待执行。

§6.4.5检查点：249条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§6.4.4检查点：241条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§6.4.3检查点：196条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§6.4.2检查点：180条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§6.4.1检查点：172条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
§6.3.8检查点：156条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。
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



# 当前可操作状态



当前任务：继续完成第6章本地①–⑤流程；第1–5章已完成交付保持冻结，不进入第7章。

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



本次用户明确恢复第6章，覆盖19号对第6章的暂停。正式库字节冻结、0 sorry，固定Lean/Mathlib v4.34.0。

每批≤8条落盘/单文件编译，每节完整check、逐声明公理检查、文档和commit+push；复用通过证据。

仅本地PASS证明；现成桥接优先，单条三次失败或缺大型理论则保留sorry并记录，不恢复封存证明。

Thm6.1/6.2/Prop6.4无整条现成桥接则sorry。网站仅生成compact及完整包，不提交，统一待网站审计。

全部本地流程完成后停止于第6章；第1–5章网站复审/导师裁定仍待用户处理。



## 历史状态（暂停已由本次用户明确恢复）



第1章收口完成，等待用户提交第1章 EAUDIT 复审包（见 EAUDIT_INDEX.md）



现行入口：[EAUDIT_INDEX.md](../../blueprint/ch01/mathcopilot_tasks/EAUDIT_INDEX.md)；[导师总结](../review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md)；[20项勘误双版本](../review/CH01_ERRATA.zh-CN.md)。

141条：48网站PASS / 93待复审（20批）；FAIL修复中0。194声明：79定义 / 69已证 / 46sorry（原书疑误不证13、缺大型理论或桥接30、时间盒止3）。

已验：单文件、194项公理、唯一完整check、现行包哈希/裁页/预算、正式库及第2–5章冻结。交付已推送4bf78a07，正式库0 sorry。

未验：网站新复审、导师裁定、占位证明和heartbeat实际额度恢复。停止本轮，不自动返回第6章，不进入第7章；等待用户新指令。



---

以下为本轮指令及历史检查点（以上方完成状态为准）



第1章收口本地验收通过；待提交推送后写完成终态。

48条网站PASS / 93条待复审（20批，含20项导师疑误）；单文件、194项公理、唯一完整check、302个冻结源文件及第2–5章源码/JSON哈希均已验。

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



当前进展：第6章批27 WIP检查点e1f19ef8已保存并暂停；第1章单文件/194项公理已通过初验，20项双版本与21项FAIL签名处理已落盘。最终快照补查、93项复审包和唯一章末完整check尚待完成。

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



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



# 当前可操作状态



当前任务：继续完成第6章本地流程（印刷211–258 / PDF232–279）；第2–5章沿用已完成修复验收，不进入第7章。

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



第2–5章修复终验沿用93d2d3e5；网站复审和导师判断待用户处理。第6章已验证至128条；132条批27尚未验证。



## 历史状态（旧第6章暂停已由用户恢复）



# 当前可操作状态



第2–5章修复完成，等待用户提交 EAUDIT 复审包（见各章 mathcopilot_tasks/EAUDIT*/INDEX.md）

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



第2章：网站PASS 67 / 已修待复审 75 / 待导师 18 / 修复中 0。

第3章：网站PASS 51 / 已修待复审 78 / 待导师 20 / 修复中 0。

第4章：网站PASS 42 / 已修待复审 110 / 待导师 27 / 修复中 0。

第5章：网站PASS 51 / 已修待复审 117 / 待导师 15 / 修复中 0。

第6章：暂停，§6.3.3 WIP 6b822a9a524f；批27未验证，不重跑；batch26裁页document closed只记录。

heartbeat lean：新授权范围已保存，ACTIVE/15分钟/target/去重哈希已读回核对，未实测额度恢复接续。



最终交付：671条；800项声明公理已核对；380个逐条复审包、86个现行批次，哈希/预算/完整结论/定义闭包已验。

已验证：原PDF页、相关既有证明重查、固定版本单文件及各章完整check；未验证：网站新复审、导师裁定、额度恢复自动接续实测。

提交入口：[EAUDIT_SUBMISSION_INDEX.md](EAUDIT_SUBMISSION_INDEX.md)；终验：[REPAIR_DELIVERY_VALIDATION.json](REPAIR_DELIVERY_VALIDATION.json)。



## 历史状态（以下推进第6章、交替修复及旧停止条件均被2026-10-14指令覆盖）



# 当前可操作状态



当前任务：第2–6章本地流程继续；按2026-10-13规则交替修复第1→3→2章网站审计（第2章reaudit已到齐）。

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



网站版本绑定与修复规则：docs/handoff/WEBSITE_AUDIT_RULES.zh-CN.md；以下旧日期登记保留作历史，不代表当前有效状态。

第2章：网站PASS 108 / 已修待复审 5 / 待导师 2 / 修复中 45。

第3章：网站PASS 91 / 已修待复审 4 / 待导师 5 / 修复中 49。

第2章EAUDIT01：章首3条reaudit FAIL完整修复；原页75–76、单文件、完整check/160条公理、3份compact通过；仅定义，未新增定量误差或实际解存在证明，网站复审待提交。

第1章EAUDIT01新返回5份已登记；有效历史绑定5/5，原始判定保留，缺绑定列材料待复审；未合并原文或改变Lean。

§6.3.2检查点：112条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§6.3.1检查点：104条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第3章EAUDIT01：四条完整签名修复，一般振子能量差/两条例外直线/不守恒已证；原页/单文件/完整check/149条公理/4份compact已验，网站复审待提交。

§6.2检查点：96条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第1章EAUDIT03：§1.1.1两条签名修复与两条材料补齐；原页/单文件/完整check/141条公理/4份compact已验；LJ经验语义待导师。

第1章：网站PASS 49 / 修复中 21 / 待导师 9 / 待复审 62。

第1章EAUDIT02：§1.1两条FAIL签名已修、Schrodinger补材料；PDF28–30/单文件/完整check/141条公理/compact字节及裁页均已验；网站复审待提交。

顺序：第2章完成且复用 → 第3章 → 第4章 → 第5章 → 第6章；不进入第7章。

跨章唯一总进度：docs/handoff/LOCAL_PIPELINE.md；当前章逐条进度：blueprint/ch06/PROGRESS.md。

约束：正式库0 sorry且源码/签名不改；第1章交付冻结；其他任务文件保留不动。

第2章reaudit BATCH01–05共20条已登记；BATCH及Lean SHA匹配，依赖附件未找到；修订未应用，网站仍待审。

§6.1检查点：48条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.6检查点：183条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第5章全部本地流程完成：183条、旧映射全覆盖、七段文档、compact预算/哈希/裁页、全部节完整检查已验；网站和导师审校待完成。

§5.5检查点：149条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.4.1检查点：137条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.4检查点：110条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第2章BATCH01–32的160条新返回已登记（15 PASS/130 NEEDS/15 FAIL）；版本绑定未验，修订未应用，原文/Lean及已通过本地交付不变。继续第5章。

§5.3.3检查点：101条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.3.2检查点：97条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.3.1检查点：68条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.2.3检查点：55条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.2.2检查点：50条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§5.2.1检查点：31条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第1章2026-10-12 BATCH02–23新返回136条已登记；44 PASS/66 NEEDS/26 FAIL为原返回，缺版本绑定不提升网站PASS；原文JSON及Lean不改，提案留待原页复核。回第5章§5.2.1。

§5.1检查点：11条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.4.2检查点：179条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第4章全部本地流程完成：179条、旧映射全覆盖、七段文档、compact预算/哈希/裁页、全部节完整检查已验；网站和导师审校待完成。

§4.4.1检查点：160条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.4检查点：141条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.6检查点：110条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.5.1检查点：106条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.5检查点：100条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.4检查点：90条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.3检查点：79条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.2检查点：76条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.3.1检查点：65条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.2检查点：42条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§4.1检查点：24条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第1章2026-10-11返回件例外：四条NEEDS与旧Legendre FAIL原样保留，来源/输入绑定未验证；仅Legendre原页字段及hPositive修订，141条公理与完整check通过，五份EAUDIT01预算/裁页已核，无网站PASS或冻结。

§4检查点：16条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§3.7检查点：149条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

第3章全部本地流程完成：149条、旧映射全覆盖、七段文档、compact预算/哈希/裁页、全部节完整检查已验；网站和导师审校待完成。

§3.6检查点：128条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§3.5检查点：101条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§3.4检查点：88条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§3.3检查点：65条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§3.2检查点：25条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

§3.1检查点：9条已编译并逐条#print axioms；完整check及当前章补充检查通过；网站待审。

自动续接：lean保持ACTIVE/15分钟及原target/去重记录；仅明确额度中断且恢复时发送，同一失败轮一次、间隔≥30分钟；同章同检查点连续3次无进展中断则停发并通知。

最近已验收：第2章160条、32批/160份compact，5节check通过且已推送8ca2ccf；网站审计与导师问题未验证。

启动预检：PDF章界已视觉核对；第3–6章旧清单分别143/100/86/126条，正文逐页核对尚待推进。



## 历史第2章交付（以下停止条件已被2026-10-10新指令取代）



# 当前可操作状态



第2章本地部分完成；第1、2章均等待用户提交 MathCopilot 批次（见 blueprint/ch01|ch02/mathcopilot_tasks/INDEX.md）

下一步：停止并等待用户新指令；不进入第7章；网站与导师审阅待用户安排。



范围：正文印刷p.53–94（PDF75–116），p.94 Exercises起排除；第3章PDF119起，不进入。

分支：chapter02-blueprint；起点8fac966abdc551c63ddaea7c8504f80f89ff812d。其他任务文件保留、不删不提交。

约束：正式库及第1章交付字节冻结，基线见blueprint/ch02/BASELINE.json；heartbeat lean ACTIVE/15分钟不修改。

§2.5检查点：160条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。

本地汇总：self-contained 65；checked+documented priors 40；incomplete 55。直接sorry 47，仅传递sorry 0；导师疑点20项。

交付：160旧条目全部映射；32批/160份compact，最大228893字节；终验见blueprint/ch02/DELIVERY_VALIDATION.json。

§2.4检查点：135条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。

§2.3检查点：110条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。

§2.2检查点：56条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。

§2.1检查点：12条已编译并逐条审计公理；完整check通过，compact原页像素与字节预算已核验。

验证：42页正文原页已渲染并视觉核对；全章逐字转录、本地预审、Lean编译及公理检查完成。网站审计和导师裁定尚未验证。
