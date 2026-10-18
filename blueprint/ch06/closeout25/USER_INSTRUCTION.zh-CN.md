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
