# 仓库真实性、覆盖范围与教材对应审计

报告生成时间（Asia/Shanghai）：2026-10-07T23:43:44+08:00。依据本轮实际读仓库、运行命令和渲染教材，不使用个人记忆。构建对应的 Git HEAD 为 `34a32792b55cf2ea679dc949ffcd66fe38b623f4`；存在未提交文件，不能把 HEAD 单独当作全部检查输入。精确输入由 [inputs-before.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/inputs-before.json>)、[inputs-after-build.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/inputs-after-build.json>) 和 [snapshot-hashes.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/snapshot-hashes.json>) 固定。

另一个数学聊天仍持续写入：本轮 `lake build` 前后所记录输入无增加、删除或哈希差异，见 [build-input-diff.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/build-input-diff.json>)。其后新增候选不计本报告的成功证明或数量。没有停止/改变另一个聊天、提交或推送本审计。

已验证：一次工作树 `lake build`；539份项目Lean文本扫描（排除第三方`.lake`和`.git`，包含正式、Scratch、脚本、历史草稿）；21个选定关键结论公理检查；2866个已登记声明的公理检查；5个随机样本的原页视觉核对。未验证完成：全书所有未编号定义/结论排漏、每个证明与原书的逐条语义等价、负责人最终签核。

## 1. 实际流程与提取清单

实际是“先建立候选索引，再按目标回读PDF与证明依赖，逐批实现”，不是已经完成一份完整blueprint再机械逐条执行。源码常从原页和临时API草稿直接发展成当前批次；跨章按依赖推进，未保证逐章收尾。这由 [AGENTS.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/AGENTS.md>)、[docs/CORE_SCOPE.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/CORE_SCOPE.zh-CN.md>) 和 [docs/handoff/WORK_LOG.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/WORK_LOG.zh-CN.md>) 的批次记录支持。

现有提取/规划产物：

| 文件 | 实际作用与限制 |
| --- | --- |
| [docs/TEXTBOOK_DECLARATION_CANDIDATES.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/TEXTBOOK_DECLARATION_CANDIDATES.csv>) | 21个编号标题匹配，其中2个是重复引用；状态落后，不能机械当完成表 |
| [docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv>) | 本轮读取268行，含编号、未编号结论、定义、风险及辅助依赖；Theorem1.1及Theorem6.1部分旧状态未同步 |
| [docs/CHAPTER_SECTION_INVENTORY.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/CHAPTER_SECTION_INVENTORY.csv>) | 196个目录/习题节点的逐节骨架，不是196条定理 |
| [docs/NOTATION_INVENTORY.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/NOTATION_INVENTORY.csv>) | notation登记和映射，含后来新增符号，不是完整定义总数 |
| [FORMALIZATION_MAP.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/FORMALIZATION_MAP.md>)、[ASSUMPTIONS.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/ASSUMPTIONS.md>) | 教材—Lean对应和显式模型假设，历史条目混存，需按时间/源码核实 |
| [docs/audits/2026-10-01-initial/README.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-01-initial/README.zh-CN.md>) | 明确说明这是抽样前期审计，未完成全书逐页排漏 |
| [pdf-numbered-unique-normalized.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pdf-numbered-unique-normalized.json>) | 本轮重新扫描461页、规范化字形后去重的编号结果：19个定理/引理/命题及3个编号定义 |

没有证据支持“完整的全书定义/定理blueprint已经建立”。当前CSV/Markdown是渐进台账。

## 2. 目录结构与每个Lean模块对应

```text
MolecularDynamicsFormalization/
  MolecularDynamicsFormalization.lean  # 顶层导入
  MolecularDynamics/
    BasicDefinitions.lean, BasicTheorems.lean
    Chapter01/ ... Chapter04/
    Chapter06/ Chapter07/ Chapter08/     # 没有Chapter05正式目录
  Scratch.lean                          # 接口/证明核验
  scripts/check.ps1, CheckAxioms.lean
  docs/                                 # 台账、复核、验收、交接与历史草稿
  lean-toolchain, lakefile.toml, lake-manifest.json
  .lake/packages/mathlib/                # 固定版本第三方依赖
```

证据：[MolecularDynamicsFormalization.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamicsFormalization.lean>)、[lakefile.toml](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/lakefile.toml>)、[module-map.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/module-map.csv>)。模块数及声明数由 [collect.py](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/collect.py>) 读取正式源码得到，见 [source-counts.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/source-counts.json>)。

并不是一文件对应一条书中结论：一个目标需要多个模块，有的模块跨章复用。例如第6章Definition6.1的实际Lie括号/点张成定义存于 [MolecularDynamics/Chapter08/HormanderClosure.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/HormanderClosure.lean>)；Chapter02/ActualFlowVariations也对接印刷79和154页。

逐文件280行对应表已输出到 [module-map.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/module-map.csv>)，包含储存章节、台账节号、源码页码锚点和映射状态。224份有台账节号；56份缺精确节号，其中36份有源码页码锚点、20份两者皆缺。这是现有追踪不完整，不能声称每个文件都已有可靠原文对应。映射仍未完成最终语义签核，见 [mapping-summary.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/mapping-summary.json>)。

## 3. 进度文件与更新时间

以下为本轮读取到的文件修改时间（北京时间）；运行中的数学聊天后来可能继续更新。证据：[document-metadata.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/document-metadata.json>)。

| 文件 | 实读修改时间 |
| --- | --- |
| [STATUS.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/STATUS.md>) | 2026-10-07T23:35:12+08:00 |
| [FORMALIZATION_MAP.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/FORMALIZATION_MAP.md>) | 2026-10-07T23:35:12+08:00 |
| [ASSUMPTIONS.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/ASSUMPTIONS.md>) | 2026-10-07T23:23:41+08:00 |
| [docs/handoff/CURRENT_STATE.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/CURRENT_STATE.zh-CN.md>) | 2026-10-07T23:35:25+08:00 |
| [docs/handoff/WORK_LOG.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/WORK_LOG.zh-CN.md>) | 2026-10-07T23:35:25+08:00 |
| [docs/handoff/PROGRESS_OVERVIEW.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/PROGRESS_OVERVIEW.zh-CN.md>) | 2026-10-07T20:40:57+08:00 |

## 4. 分章数量：编号目标、项目证明、辅助声明分开

正文8章，另有附录A–C；目录见本轮渲染PDF18–22及章节目录CSV。下表“书中数量”只统计本轮可检出的**编号**定义/定理/引理/命题；没有完整排漏，未编号总数未知。因此这张表不能作为整章完成率。

证据：[教材目录原页](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-022.png>)、[pdf-numbered-unique-normalized.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pdf-numbered-unique-normalized.json>)、[source-counts.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/source-counts.json>)。

| 章 | 编号定义 | 编号定理 | 编号引理 | 编号命题 | 已实现编号定义 | 有完整项目版本的编号结论 | 这些版本无sorry证明 | 正式Lean文件 | 公共theorem/lemma（含辅助） |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 63 | 371 |
| 2 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 13 | 113 |
| 3 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 4 | 38 |
| 4 | 0 | 0 | 1 | 0 | 0 | 1 | 1 | 8 | 40 |
| 5 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 6 | 1 | 2 | 1 | 4 | 1 | 4 | 4 | 180 | 1771 |
| 7 | 0 | 0 | 1 | 1 | 0 | 2 | 2 | 3 | 33 |
| 8 | 0 | 1 | 1 | 3 | 0 | 5 | 5 | 7 | 65 |

“完整项目版本”14个的分母是19个编号结论，**包含明确受限模型及形式解释**，不表示14个原书全范围结论已通过语义终审。编号定义3个中只核实Definition6.1已实现；Definition3.1（仿射不变）和5.1（微正则遍历）尚未找到对应已验收定义，不把一般共轭/其他章测度工具自动当作实现。

逐章编号版本：

| 章 | 完整项目版本或缺口 | 证据 |
| --- | --- | --- |
| 1 | Theorem1.1；其他正文缺口仍在 | [strictPotentialMin_futureStableEuclidean_of_smooth](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/EuclideanStability.lean:72>) |
| 2 | Theorem2.1；其他正文缺口仍在 | [theorem_2_1_euler](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter02/EulerConvergence.lean:328>) |
| 3 | Theorem3.1只有依赖和条件推论，没有完整原定理版本 | [textbook_energy_drift_rate_of_flow_defect](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean:129>) |
| 4 | Lemma4.1；没有因此完成SHAKE/RATTLE求解和精度 | [lemma_4_1](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter04/ConstrainedProjection.lean:162>) |
| 5 | Theorem5.1和Definition5.1未落实 | [docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv>)的CH05项；正式目录扫描 |
| 6 | Proposition6.1/6.2/6.3及单位质量/单位周期模型下Lemma6.1；Theorem6.1/6.2和Prop6.4没有全范围完整版本 | [proposition_6_1](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean:376>)、[textbookWienerQuadraticSum_meanSquare_tendsto](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:200>)、[textbookWienerDeterministicIto_proposition63](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerDeterministicLaw.lean:164>)、[textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinGlobalRandomSolution.lean:167>) |
| 7 | Lemma7.1；Prop7.1的非交换**形式幂级数解释**完成，原无界解析算子解释未完 | [textbookInvariantDistributionSwap](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter07/InvariantDistributionSwap.lean:64>)、[textbookSymmetricModifiedGenerator_logarithm](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter07/SymmetricOperatorBCH.lean:288>) |
| 8 | 五个编号目标有项目模型证明；Prop8.1实际概率版本给定联合C²解族，不含构造该解族 | [MolecularDynamics/Chapter08/StationaryDensityFlow.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/StationaryDensityFlow.lean>)、[MolecularDynamics/Chapter08/ThermostatHormander.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/ThermostatHormander.lean>)、[MolecularDynamics/Chapter08/ThermostatLieFields.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/ThermostatLieFields.lean>)、[MolecularDynamics/Chapter08/ThermostatSpan.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/ThermostatSpan.lean>) |

280份正式文件中另有2份通用基础文件；章节文件共278份。公共theorem/lemma共2431条，其中大量是辅助步骤；不能用2431/19、14/19或编号定义数量计算全书覆盖。一般定义/abbrev/structure等声明626条，同样不是626个教材定义。所有上述计数对应冻结源码快照，不包括后来候选。负责人最终教材语义签核没有已确认完成的整章，仍未完成。

## 5. 没开始、排除范围与“无法形式化”

第5章没有正式Lean模块；已有原页定位/台账登记，故准确说法是“正式实现尚未开始”，不是完全没有做任何准备。其他7章均有正式模块。证据：[source-counts.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/source-counts.json>)和[docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv>)的CH05条目。

读取当前范围、章节台账及状态，没有发现将某章正式判定为“无法形式化”的记录。未证/缺库/外部证明依赖不是不可形式化的结论。本轮有限检索不足以保证历史文档从未出现过任何类似措辞。

明确排除为独立交付的是课后题、数值实验、介绍性例子和无关一般化；正文定理实际需要的习题结果仍包含。理由是2026-10-04用户限定交付范围，见 [docs/CORE_SCOPE.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/CORE_SCOPE.zh-CN.md>)，不是证明失败后私自跳过。第5章以及前两章正文缺口仍在范围内。

## 6. 实际lake build

在正式工程目录执行固定工具链的 `lake.exe build`（路径固定为Lean4.34.0工具链），不是引用旧报告。退出0，9205jobs，error0、warning0、info9。输出保存在 [lake-build.log](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/lake-build.log>)；汇总 [build-summary.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/build-summary.json>)。

最后输出：

```text
  [apply] abel_nf
✔ [9204/9205] Built MolecularDynamicsFormalization (70s)
Build completed successfully (9205 jobs).
BUILD_EXIT=0
```

info包括`Try this: ring_nf/abel_nf`和一次尝试的ring提示；不属于Lean error或warning。构建是缓存增量构建，没有声称清空缓存重编所有mathlib。`lake build`覆盖工程库目标，不验证docs下全部历史草稿；539份扫描覆盖和构建覆盖是不同范围。

## 7. sorry/admit位置与数量

本轮排除`.lake/.git`扫描539份项目Lean文件，正式库280份、其余为入口/审计/Scratch/历史草稿；`sorry=0`、`admit=0`，位置列表为空。第一次原始命令 `rg -n --glob '*.lean' --glob '!**/.lake/**' --glob '!**/.git/**' ... .` 无匹配退出1；本轮去除嵌套注释及字符串后再扫描亦为0。证据：[source-scan.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/source-scan.json>)、[collect.py](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/collect.py>)。不把第三方Lean内核/依赖自身的axiom声明当作项目新增公理。

## 8. axiom、opaque及指定特殊机制

| 项目自有Lean源码中的项目 | 本轮数量 | 位置/解释 |
| --- | ---: | --- |
| 自定义axiom | 0 | 空列表 |
| opaque | 0 | 空列表 |
| native_decide | 0 | 空列表 |
| set_option maxHeartbeats 0 | 0 | 空列表 |
| implemented_by | 0 | 空列表 |
| unsafe | 0 | 额外扫描，空列表 |

证据：[source-scan.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/source-scan.json>)。没有这些机制，因而没有需要逐处解释的命中。

另有10处正式源码的**有限**资源设置（历史草稿另12处），保留全表如下。有限心跳只影响搜索预算，仍要求内核检查，不是新增逻辑假设；是否仍需每个旧设置没有做逐处删改实验，本轮不修改证明。

| 文件 | 行 | 设置 |
| --- | ---: | --- |
| [MolecularDynamics/Chapter01/Hamiltonian.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/Hamiltonian.lean>) | 16 | `set_option synthInstance.maxHeartbeats 2000` |
| [MolecularDynamics/Chapter01/LocalExistence.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/LocalExistence.lean>) | 7 | `set_option maxHeartbeats 100000` |
| [MolecularDynamics/Chapter01/MomentumBounds.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/MomentumBounds.lean>) | 14 | `set_option synthInstance.maxHeartbeats 2000` |
| [MolecularDynamics/Chapter01/MomentumBounds.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/MomentumBounds.lean>) | 15 | `set_option maxHeartbeats 100000` |
| [MolecularDynamics/Chapter02/ActualFlowVariations.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter02/ActualFlowVariations.lean>) | 29 | `set_option maxHeartbeats 800000 in` |
| [MolecularDynamics/Chapter06/BrownianClosedCoercivity.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/BrownianClosedCoercivity.lean>) | 134 | `set_option maxHeartbeats 800000 in` |
| [MolecularDynamics/Chapter06/LangevinInitialState.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinInitialState.lean>) | 79 | `set_option maxHeartbeats 800000 in` |
| [MolecularDynamics/Chapter06/LangevinInitialState.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinInitialState.lean>) | 125 | `set_option maxHeartbeats 800000 in` |
| [MolecularDynamics/Chapter07/SymmetricOperatorBCH.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter07/SymmetricOperatorBCH.lean>) | 126 | `set_option maxHeartbeats 800000 in` |
| [MolecularDynamics/Chapter07/SymmetricOperatorBCH.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter07/SymmetricOperatorBCH.lean>) | 138 | `set_option maxHeartbeats 800000 in` |

## 9. 各章关键结论#print axioms

第1、2、3、4、6、7、8章各选3个重要已实现结论（共21）；只有1个编号目标的章用重要依赖补足，**第3章所列不是完整Theorem3.1**。第5章没有可打印的已实现目标，不能伪造3个名字。

实际命令：`lake env lean docs/audits/2026-10-07-user-request/SelectedAxioms.lean`，exit0。每个完整结果如下；源码位置见 [selected-theorems.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/selected-theorems.json>)，命令文件 [SelectedAxioms.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/SelectedAxioms.lean>)，原输出 [selected-axioms.log](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/selected-axioms.log>)。

```text
'MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_smooth' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.mechanical_energy_const_on_Ioo' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.exists_globalMechanicalIVP_of_energy_barrier' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.theorem_2_1_euler' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.oneStepMaxError_order_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.textbookSymplecticEulerEquiv_isSymplectic' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.textbookPoissonBracket_jacobi' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbook_energy_drift_rate_of_flow_defect' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.lemma_4_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.textbookCotangentProjection_hiddenConstraint' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookConstrainedFlow_pullback_constant_of_mass_and_independence' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.proposition_6_1' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookWienerDeterministicIto_proposition63' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookInvariantDistributionSwap' depends on axioms: [propext, Classical.choice, Quot.sound]
'MolecularDynamics.textbookSymmetricModifiedGenerator_logarithm' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookSymmetricModifiedGenerator_odd_coeff_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookThermostats_additive_proposition81' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookThermostatFamily_linearIndependent' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'MolecularDynamics.textbookNHL_hormander_physicalNoise' depends on axioms: [propext, Classical.choice, Quot.sound]
```

21个均仅依赖`propext, Classical.choice, Quot.sound`。

还实际运行 `lake env lean scripts/CheckAxioms.lean`，exit0，输出 [all-registered-axioms.log](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/all-registered-axioms.log>)。2866个已登记声明中2865个仅用允许三公理，1个`textbookOperatorCommutator`无任何公理。没有非标准公理；审计脚本登记范围不自动等于源码所有声明。汇总 [axioms-summary.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/axioms-summary.json>)。公理检查不证明陈述忠实性。

## 10. 陈述调整、附加假设、弱化/部分解释：如实登记

确实存在显式受限模型、较强前提及条件性辅助定理；不能回答“没有改动陈述”。下面列出本轮确认的主要差异，而不是声称已经审完每个声明。

| 范围 | 实际差异及影响 | 证据 |
| --- | --- | --- |
| 第1章Lagrangian/广义坐标 | 多数实现固定正对角质量，而教材讨论更一般M(q)；完整一般坐标动力学未补齐 | [MolecularDynamics/Chapter01/GeneralizedCoordinates.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/GeneralizedCoordinates.lean>)、[ASSUMPTIONS.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/ASSUMPTIONS.md>) |
| Theorem1.1 | 显式正质量、开放位置域和真实解/欧氏距离；另有C²版本，smooth版本保留；不是用Hessian正定替换严格局部极小 | [strictPotentialMin_futureStableEuclidean_of_smooth](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter01/EuclideanStability.lean:72>)、[pages/pdf-055.png](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-055.png>) |
| 第2/4章流变分和第8章概率不变性 | 给定联合C²真实解族，较教材通常向量场条件强；没有从较弱条件构造该解族。因此只能计此模型版本 | [MolecularDynamics/Chapter02/ActualFlowVariations.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter02/ActualFlowVariations.lean:30>)、[MolecularDynamics/Chapter04/ConstrainedFlowSymplectic.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter04/ConstrainedFlowSymplectic.lean:128>)、[MolecularDynamics/Chapter08/StationaryDensityFlow.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/StationaryDensityFlow.lean>) |
| 第2章一般阶误差 | 条件性收敛引理假设实际数值点留域/局部误差和稳定性；Euler定理2.1则真实推出留域，无这个额外前提 | [oneStepMaxError_order_bound](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter02/OneStepConvergence.lean:146>)、[theorem_2_1_euler](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter02/EulerConvergence.lean:328>) |
| Theorem3.1依赖 | `hdefect`直接假设数值步与修正流差≤Ah^(k+1)，这正是尚需推导的核心匹配；条件推论可证明，不是完整原定理 | [textbook_energy_drift_rate_of_flow_defect](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean:129>)（实际hdefect在源码147行附近） |
| 第4章数值积分器 | 给定可微乘子/满足位置约束的真实分支，未证明初始非线性分支存在；力符号用参数a同时覆盖两种读法 | [MolecularDynamics/Chapter04/ConstrainedIntegrator.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter04/ConstrainedIntegrator.lean>)、[docs/verification/2026-10-05-ConstrainedIntegrator/STATEMENT_REVIEW.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/verification/2026-10-05-ConstrainedIntegrator/STATEMENT_REVIEW.zh-CN.md>) |
| Proposition6.1 | 增加显式归一化/加权可积性；把`|G exp(-βH)|<∞`落实为统一界C。若原文只是逐点有限，这确实是更强假设，最终解释待签核 | [proposition_6_1](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean:376>)、[pages/pdf-243.png](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-243.png>) |
| Lemma6.1 | 采用单位质量、单位周期势模型；显式Nonempty open C修复空集反例，正时间/非零噪声明确。完整任意原模型的迁移未签核 | [textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinGlobalRandomSolution.lean:167>)、[docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv>)CH06-NUM-006 |
| Theorem6.1 | 实际Hilbert闭算子/谱/概率身份等大量步骤已证，但原全部初始分布与C²表述仍未全范围收尾 | [docs/handoff/CURRENT_STATE.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/CURRENT_STATE.zh-CN.md>)、[docs/reviews/2026-10-06-BrownianContinuousHaarDensity/REVIEW.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/reviews/2026-10-06-BrownianContinuousHaarDensity/REVIEW.zh-CN.md>) |
| Theorem6.2应用 | 已构造受限Langevin真实过程和不变概率；指数界仍显式依赖实际正时间联合密度条件，未证明该条件，未做一般SDE定理 | [MolecularDynamics/Chapter06/LangevinPositiveTimeHarris.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinPositiveTimeHarris.lean>)、[MolecularDynamics/Chapter06/LangevinPositiveTimeDensity.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinPositiveTimeDensity.lean>) |
| Assumption1(ii) | 原印刷连续区间含t=0；源码保留字面版本并证明在正维/有内部点时不可能，另命名正时间版本。这是实质原文修订待签核，不是偷偷换掉 | [pages/pdf-273.png](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-273.png>)、[MolecularDynamics/Chapter06/LangevinDensityTimeZero.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinDensityTimeZero.lean>)、[docs/reviews/2026-10-07-LangevinDensityTimeZero/REVIEW.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/reviews/2026-10-07-LangevinDensityTimeZero/REVIEW.zh-CN.md>) |
| Proposition7.1 | 完整非交换形式幂级数等式；不含原无界微分算子指数的分析域/余项解释 | [textbookSymmetricModifiedGenerator_logarithm](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter07/SymmetricOperatorBCH.lean:288>)、[MolecularDynamics/Chapter07/FormalOperatorFunctionalCalculus.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter07/FormalOperatorFunctionalCalculus.lean>) |
| Theorem8.1 | μ、θ=kBT、γ正和非零物理噪声明确；正定不同特征值、排除零模域与原上下文对应；不包含遍历性结论 | [textbookNHL_hormander_physicalNoise](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/ThermostatHormander.lean:274>)、[pages/pdf-367.png](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-367.png>) |

本轮文本扫描没有发现把项目目标直接`def ... := 0`或`True`的候选；实际抽查的随机积分、Langevin积分方程、Gibbs权重和Hörmander条件均为非平凡对象，见第11节。不能凭这次关键词扫描断言全部626个定义的语义都正确。结构/条件谓词也可能携带很强前提，必须审类型，不能只看公理列表。

## 11. 随机部分实际如何处理

“Mathlib完全不支持随机部分”过于笼统。固定本地版本有Brownian、Gaussian、测度、滤过和ODE工具：[.lake/packages/mathlib/Mathlib/Probability/BrownianMotion/Basic.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/.lake/packages/mathlib/Mathlib/Probability/BrownianMotion/Basic.lean:75>)定义`IsPreBrownianReal`，302行定义`IsBrownianReal`。本次文件检索命中Gaussian/Filtration等模块，未核实一个可直接覆盖本书全部内容的通用Itô/SDE库；不把未命中关键词当作全库不存在的证明。

| 对象 | 实际处理 | 未完成边界与证据 |
| --- | --- | --- |
| Wiener/Brownian | 复用mathlib真实高斯有限维law；项目`textbookIsWienerVector` structure只列联合高斯、均值、协方差、AE连续定义条件，独立性/全路径支持另外证明 | [MolecularDynamics/Chapter06/WienerVectorSupport.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerVectorSupport.lean:13>)；不是axiom，亦不能自动当作已构造每个概率空间上的Wiener过程 |
| 确定性被积函数Itô积分 | 定义真实左端点有限和；用L²等距/共细化/Cauchy/完备性构造极限，再识别Gaussian law和矩 | [MolecularDynamics/Chapter06/WienerIntegration.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerIntegration.lean:16>)、[MolecularDynamics/Chapter06/WienerRefinement.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerRefinement.lean>)、[textbookWienerDeterministicIto_proposition63](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerDeterministicLaw.lean:164>)；没有覆盖所有随机适应被积函数的一般Itô积分 |
| 加性噪声Langevin | 明确`q=q0+∫p`及`p=p0+∫(F−γp)+σW`，用p−σW变换到连续驱动ODE，自行补实际解存在/唯一/可测性/Markov/转移等链 | [MolecularDynamics/Chapter06/LangevinNoiseStability.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinNoiseStability.lean:13>)、[MolecularDynamics/Chapter06/LangevinDrivenExistence.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinDrivenExistence.lean>)、[MolecularDynamics/Chapter06/LangevinGlobalRandomSolution.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinGlobalRandomSolution.lean>)；单位质量/周期模型，不能宣称通用乘性噪声SDE已完成 |
| Fokker–Planck | 实现真实前向微分表达式及Gibbs弱平衡/分部积分；另构造真实概率半群 | [MolecularDynamics/Chapter06/LangevinGibbsStationaryExpression.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/LangevinGibbsStationaryExpression.lean:47>)；真实密度PDE、该表达式与完整概率生成元伴随的域身份、Gibbs概率保持仍有缺口 |
| Hörmander | 实际fderiv Lie括号递归、真实点span=top；不是定义为True | [MolecularDynamics/Chapter08/HormanderClosure.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/HormanderClosure.lean:16>)、33行；未因此自动获得hypoellipticity/密度存在/遍历性 |

所以答案是“复用概率基础，自行定义并证明特定所需对象；尚未覆盖的一般理论明确留缺口”，没有用项目axiom兜底。

## 12. 随机抽5个“证完”目标的原文—Lean并排核对

本轮从13个有完整项目模型证明的编号结论中，执行`random.Random(20261007).sample(population,5)`。总体名单和抽样结果保存在 [random-five.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/random-five.json>)；未把未证的定理3.1/5.1/6.1/6.2/Prop6.4或只完成形式解释的Prop7.1放进总体。抽出的5个已逐页渲染并目视核对；不是选出最容易解释的5个后称随机。以下原文为直接目视转录，数学符号规范化；精确排版以原页图为准。

### Proposition 6.1 — 印刷222 / PDF243（1起算）

来源：[本轮原页图](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-243.png>)、[proposition_6_1](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean:376>)。冻结源码：[snapshot/MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/snapshot/MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean>)。

| 原书陈述（符号规范化转录） | Lean原始陈述 | 差异说明 |
| --- | --- | --- |
| Let H be a Hamiltonian defined on the phase space R^(2Nc) and suppose G : R^(2Nc) → R^(2Nc) is a smooth (C¹) vector field with the following properties: 0 < \|Avβ(G·∇H)\| < ∞; 0 < Avβ(∇·G) < ∞; \|G e^(−βH)\| < ∞. Then kBT = Avβ(G·∇H) / Avβ(∇·G). | <code>theorem proposition_6_1 {Nc : ℕ}<br>    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)<br>    (kB T : ℝ) (hkB : 0 &lt; kB) (hT : 0 &lt; T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)<br>    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))<br>    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))<br>    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))<br>    (C : ℝ) (hC : 0 ≤ C)<br>    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)<br>    (hpos : 0 &lt; textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :<br>    kB * T =<br>      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /<br>        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)</code> | 显式C¹ H/G、kB/T正、Gibbs归一化及加权可积；逐点有限原式按统一有界解释。这一加强/解释必须保留待签核，不能无条件宣称逐字等价。分子非零由β正和分母正实际推出。 |

### Proposition 6.3 — 印刷231 / PDF252（1起算）

来源：[本轮原页图](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-252.png>)、[textbookWienerDeterministicIto_proposition63](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerDeterministicLaw.lean:164>)。冻结源码：[snapshot/MolecularDynamics/Chapter06/WienerDeterministicLaw.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/snapshot/MolecularDynamics/Chapter06/WienerDeterministicLaw.lean>)。

| 原书陈述（符号规范化转录） | Lean原始陈述 | 差异说明 |
| --- | --- | --- |
| Let g be a smooth deterministic function and W(t) a Wiener process. The stochastic integral Y(t)=∫₀ᵗg(s)dW(s) is, for all times t≥0, a normally distributed random variable such that E(Y(t))=0, E(Y²(t))=σ²(t)=∫₀ᵗg(s)²ds. | <code>theorem textbookWienerDeterministicIto_proposition63 {W : ℝ≥0 → Ω → ℝ}<br>    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :<br>    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧<br>      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P)<br>        atTop (𝓝 0) ∧<br>      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧<br>      (∫ ω, Y ω ∂P) = 0 ∧ (∫ ω, Y ω ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2</code> | 时间参数T∈ℝ≥0显式；C¹ g足够，涵盖smooth；采用实际均方极限的存在陈述，而不是已有general Ito函数名。每个T的存在/法则/均值/二阶矩完整，但本结论没有额外证明一个对所有T的适应连续过程版本。 |

### Theorem 2.1 — 印刷56 / PDF78（1起算）

来源：[本轮原页图](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-078.png>)、[theorem_2_1_euler](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter02/EulerConvergence.lean:328>)。冻结源码：[snapshot/MolecularDynamics/Chapter02/EulerConvergence.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/snapshot/MolecularDynamics/Chapter02/EulerConvergence.lean>)。

| 原书陈述（符号规范化转录） | Lean原始陈述 | 差异说明 |
| --- | --- | --- |
| Let D be a bounded, open region in R^m such that f:D→R^m is continuously differentiable. Let ζ be an interior point of D and suppose the initial value problem (2.1) has a unique solution that remains in D for t∈[0,τ]. Then there exists a constant C(τ)>0 such that for sufficiently large ν∈N the numerical solution z_n remains in D for n=0,1,...,ν, where hν=τ, and, moreover, the maximum global error in Euler’s method satisfies ē:=max_(0≤n≤ν)e_n≤C(τ)h. | <code>theorem theorem_2_1_euler {m : ℕ} (D : Set (Position m))<br>    (_hDbounded : Bornology.IsBounded D) (hD : IsOpen D)<br>    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)<br>    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)<br>    (hγD : MapsTo γ (Icc 0 τ) D)<br>    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t) :<br>    ∃ C : ℝ, 0 &lt; C ∧ ∃ ν₀ : ℕ, 0 &lt; ν₀ ∧ ∀ ν ≥ ν₀,<br>      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧<br>        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ))</code> | 域外用total f任意延拓，域内C¹；给定真实精确解γ，初值γ0；移除无需用于误差估计的唯一性要求，未加强前提。包含数值留域和真实有限最大误差；无global Lipschitz/留域结论型假设。常数可依赖固定数据及τ，与ν无关。 |

### Proposition 6.2 — 印刷229 / PDF250（1起算）

来源：[本轮原页图](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-250.png>)、[textbookWienerQuadraticSum_meanSquare_tendsto](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:200>)。冻结源码：[snapshot/MolecularDynamics/Chapter06/WienerQuadraticVariation.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/snapshot/MolecularDynamics/Chapter06/WienerQuadraticVariation.lean>)。

| 原书陈述（符号规范化转录） | Lean原始陈述 | 差异说明 |
| --- | --- | --- |
| Let ν δt=τ then l.i.m._(ν→∞) ∑_(k=0)^(ν−1)[W((k+1)δt)−W(kδt)]²=τ, where l.i.m._(ν→∞) Aν=B ⇔ lim_(ν→∞)E(Aν−B)²=0. (Convergence in the mean square sense.) | <code>theorem textbookWienerQuadraticSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}<br>    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :<br>    Tendsto (fun K : ℕ ↦ ∫ ω,<br>      (textbookWienerQuadraticSum W T K ω - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0)</code> | 均方极限与原定义一致；只需真实Brownian有限维law，AE路径连续不是该结果的必要条件。K自然数趋∞，T非负，另有K>0时精确MSE=2T²/K。原证明交叉项符号和PDF251末行ν→0为排印问题，按数学正确式证明并登记。 |

### Theorem 8.1 — 印刷346 / PDF367（1起算）

来源：[本轮原页图](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/pages/pdf-367.png>)、[textbookNHL_hormander_physicalNoise](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/MolecularDynamics/Chapter08/ThermostatHormander.lean:274>)。冻结源码：[snapshot/MolecularDynamics/Chapter08/ThermostatHormander.lean](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/snapshot/MolecularDynamics/Chapter08/ThermostatHormander.lean>)。

| 原书陈述（符号规范化转录） | Lean原始陈述 | 差异说明 |
| --- | --- | --- |
| If A is symmetric positive definite and has distinct eigenvalues, then (8.30)–(8.32) satisfies the Hörmander condition on D×R. Context: U(q)=qᵀAq/2, M=I, no constraints, D excludes simultaneous vanishing of both position and momentum along any eigenmode. | <code>theorem textbookNHL_hormander_physicalNoise {Nc : ℕ}<br>    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)<br>    (hdist : Function.Injective hA.1.eigenvalues) (μ θ γ : ℝ)<br>    (hμ : 0 &lt; μ) (hθ : 0 &lt; θ) (hγ : 0 &lt; γ)<br>    (w : textbookThermostatPhase Nc × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :<br>    textbookHormanderAt<br>      {textbookNHLDrift A μ θ γ, textbookThermostatNoise (Real.sqrt (2 * θ * γ * μ⁻¹))} w</code> | A.PosDef携带对称与正定，不同特征值显式；μ、θ、γ正确保物理噪声非零，域排除零模；这些来自上下文/物理模型，但非原定理单句全部写出。只证明实际Lie括号点span条件，不声称已证明NHL完整遍历性。 |

共享Lean上下文（随机两积分结论）：`{Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}`，由源码variable块提供；`Position m`为欧氏空间，`SymplecticCoordinates Nc`为2Nc维实际坐标表示。完整语义没有以省略上下文的片段代替原声明。

## 13. 主要卡点与反复失败的实际记录

没有测量所有缺口剩余工时，不能给出经验证的“最难定理”排名。当前全书交付的主要障碍首先是完整目标清单/节映射/语义签核欠缺；当前数学证明链集中在Prop6.4所需弱零梯度→常数、H¹密度、真实生成元core/逆估计与Poisson存在。Theorem6.2仍缺真实正时间joint density及其PDE/Gibbs身份。其他重要缺口为Theorem3.1高阶修正匹配、Theorem5.1未实现、前两章正文收尾。证据：[docs/handoff/CURRENT_STATE.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/CURRENT_STATE.zh-CN.md>)、第10节的类型与台账。

重复失败不等于“定理不可能证明”。本轮汇总docs/verification里102个非零`.exit`记录，见 [historical-failed-exits.json](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/audits/2026-10-07-user-request/historical-failed-exits.json>)；可能含不同API草稿/重试，不能当102条教材定理失败。

| 批次 | 实读尝试 | 已知原因/状态 | 证据 |
| --- | --- | --- | --- |
| CanonicalKernelUnweighted | local01/02/03=1；local04/05=0 | 类型/函数形状与API修复；04仍有多余tactic警告，05clean；已正式验收，不是当前未证原定理本身 | [docs/verification/2026-10-07-LangevinCanonicalKernelUnweighted/local01.exit](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/verification/2026-10-07-LangevinCanonicalKernelUnweighted/local01.exit>)、[docs/reviews/2026-10-07-LangevinCanonicalKernelUnweighted/REVIEW.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/reviews/2026-10-07-LangevinCanonicalKernelUnweighted/REVIEW.zh-CN.md>) |
| CanonicalKernelShift | local01/02=1；local03=0 | AddCircle投影和函数形状；已clean/验收，不能冒认为常数性已证 | [docs/verification/2026-10-07-LangevinCanonicalKernelShift/local01.exit](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/verification/2026-10-07-LangevinCanonicalKernelShift/local01.exit>)、[docs/handoff/WORK_LOG.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/handoff/WORK_LOG.zh-CN.md>)相应条目 |
| DensityTimeZero | 多轮局部诊断及full01失败，后full02通过 | 实例/类型/警告；全检匿名实例证明重名，修唯一名称；成功结果是字面密度条件的不可能性 | [docs/reviews/2026-10-07-LangevinDensityTimeZero/REVIEW.zh-CN.md](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/docs/reviews/2026-10-07-LangevinDensityTimeZero/REVIEW.zh-CN.md>) |

审计期间最新状态23:36:35显示CanonicalKernelPairingShift的local01退出1、尚未集成验收；本报告不替另一个聊天修该候选，也不把候选当成功证明。

## 14. 额度有限时的优先级（建议，尚未改变执行顺序）

1. 先修进度可信度：完成前两章正文目标清单，把完整原目标、受限模型、条件依赖和候选分开，补56份精确节映射缺项。现有编号表不能承担全书分母，依据第1–4节。
2. 用现有验收检查点停止扩大第6章依赖链，回到第一/二章逐项收尾；优先已有证明可直接补齐原假设/结论的一批。依据已存在检查点和前两章具体缺口，不承诺“两个章已接近全部完成”。
3. 第6章仅保留一个明确正文目标的有界批次；到预算就保存真实未证缺口，不把继续写辅助引理视为无限推进的理由。Prop6.4和一般Theorem6.2需要的完整分析工具应先列依赖和估计再投入。
4. 复用未变源码的构建/公理证据；源码改变或用户要求审计才重跑对应检查。避免重复全检、重复造已经存在的mathlib工具和无关一般化。

以上为根据本轮审计提出的工作建议；没有向数学聊天发指令或修改自动化。
