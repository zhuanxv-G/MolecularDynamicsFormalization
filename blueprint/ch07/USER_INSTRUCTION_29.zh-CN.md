# 29号：插入第7章网站首轮结果整合与修复，完成后回到第8章（2026-10-18 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（28号保留在其下，作为本轮完成后的续接任务），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“先按29号完成第7章整合与修复，再按28号继续第8章”），然后执行。

## 0. 顺序
1. 第8章：把当前进行中的批次做到最近的已验证检查点并提交，然后暂停第8章。
2. 执行本文第1–5节（第7章）。
3. 第7章复审包生成并提交后，回到28号继续第8章，直至28号完成标准。
- 第1–6章不动；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。分支仍为 chapter08-blueprint。
- 28号“禁止修改 Ch07”的限制在本轮第1–5节期间解除；第7章复审包生成后重新生效（用户将提交复审，返回要按哈希校验）。

## 1. 登记网站返回（118条全部到齐）
- 已交付到 blueprint/ch07/mathcopilot_results/BATCH01–20_result.json。用户把20批合并成6个任务提交（任务内重复的依赖定义放在附录，内容逐字相同），再由脚本按 source_id 拆回并逐条校验 input_sha256；每个 item 自带 subtask 和 input_sha256，"merged_from"、"round": "first-merged" 属正常。Ch07.lean 自打包（033a7eb5）后未改。
- 合计：PASS 66 / FAIL 28 / NEEDS_HUMAN 24。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md；原文版/修正版/原书疑误分开记录。

## 2. 修复 28 条 FAIL（严格按 suggested_fix，不扩大范围）
网站返回分三类：
- **转录错误（先对照原页渲染图改正，不算原书疑误）**：
  - MD-7.3.1-WordConvention：原页为九字母 OABOAOBAO（四个O、三个A、两个B），JSON 与三个 Lean 声明漏了第三、第四字母间的 O。按原页改正 JSON 与全部相关声明。
  - MD-7.8.1-FirstCorrectionTablePrinted：网站指出 _corrected 的公式才是 PDF 字面式，Printed 版 s=4 的符号是转录错误。看原页核实：若原页本来就对，改正 Printed 版、撤销该疑误；在 ERRATA 与 website_audit.json 写明核对结论。
- **覆盖不全（占多数）**：statement_scope 声称覆盖整段原文，Lean 只有通用辅助引理或代数恒等式（如 ConjugateIteration、GibbsComposition、DivergenceFreeInvariant、JSplitting、OperatorOrderReversal、TaylorRemainder、OBAModifiedOperator、CommutatorPermutationRelations、GibbsDerivativeIdentities、EvenDensityPerturbation、SymmetricRHS、OUHermiteIdentities、BAOABMarginalCancellation、SuperconvergenceScope、BAOABLimitMethod、ApproximateGeodesicOrder、SpectralRadiusStability、NonsymmetricExactMoments 漏 ⟨qp⟩_h=O(h) 等）。处理：
  - suggested_fix 要求的、能用一条短陈述写出的结论（特化到所印方法、补漏掉的结论），补声明（可 sorry）；
  - 需要无界生成元、半群、Fredholm 可解性等大型理论的，不建理论：在 [EXTRA]/docstring 如实缩小覆盖范围，并把未覆盖结论列入覆盖缺口；statement_scope 同步改为实际覆盖范围。
  - 这是第27号第4节第3条要求的重复问题，本轮修完后对第7章全部118条自检一遍 statement_scope 与 Lean 结论是否一致。
- **对象资格缺失**：如 CoordinateJSplitting、MomentumRedrawLimit 缺 m_i>0，ConstrainedHOSplitting 缺 O 步噪声项，ColoredNoiseAndExtension 等：按 suggested_fix 补前提，保留总化定义作辅助并在 docstring 说明。
- 修复只改 blueprint/。每条修完单文件编译 + #print axioms；全部修完跑一次完整 check。下游若编译失败，最小调整并记录。

## 3. NEEDS_HUMAN（24条）分流
- 网站写“签名忠实/修正版正确，仅原书表述有疑”的：并入 CH07_ERRATA（第1章字段；公式类先看原页渲染图并注明“已目视核对原页”）；缺修正版的补 _corrected（时间盒3条路线）。
- 网站写“签名正确但远弱于原文/范围需签核”的（如 GeMarsdenRestriction、StationaryModifiedPDE、PerturbativeSolvabilityCaution、OverdampedSolvabilityOperators、HyperbolicPhaseTransform）：在 [EXTRA] 写明覆盖范围并列入覆盖缺口；若改了签名，进入复审包。

## 4. 文档
- 更新 CH07_ERRATA、CH07_BLUEPRINT（第1章结构，含网站结论）、CH07_SUMMARY_FOR_MENTOR（导师语言，无工程术语和内部流程话）。

## 5. 复审包
- 为本轮改过签名的条目生成 EAUDIT 复审包，格式同第6章 EAUDIT（blueprint/ch07/mathcopilot_tasks/EAUDITxx/ 下 a/b/c，各含 MANIFEST.json、PASTE.txt、PAGES.pdf；PROGRESS 中标“待复审 / EAUDITxx”）。PASTE 开头带“以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”，内嵌哈希，包含全部项目定义体（缺失数为0）。不提交、不等网站。
- 完成标准：第7章 FAIL 修复中 = 0；单文件编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry、0 axiom；复审包已生成（报告包数和条数）。提交并 push，CURRENT_STATE 写“第7章首轮结果已整合，复审包待用户提交；继续第8章”，然后回到28号继续第8章（此后 Ch07 文件再次冻结）。
