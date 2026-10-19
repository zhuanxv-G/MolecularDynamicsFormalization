# 31号：第8章网站首轮结果整合 + 修复 + 生成复审包（2026-10-19 用户指令）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第7章最终收口完成；第8章首轮网站审校中，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按31号继续第8章网站结果整合与修复”，停止条件为第6节完成标准），然后执行。

## 0. 范围
- 唯一任务：第8章，做法同25号（第6章首轮）和29号（第7章首轮）。分支 chapter08-blueprint。
- 第1–7章不动；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。交付格式照第1章。

## 1. 登记网站返回（103条全部到齐）
- 已交付到 blueprint/ch08/mathcopilot_results/BATCH01–18_result.json（用户合并成7个任务提交，任务内重复依赖定义放附录；脚本按 source_id 拆回并逐条校验 input_sha256；每个 item 带 subtask 和 input_sha256，"merged_from"、"round": "first-merged" 属正常）。Ch08.lean 自 fc19e3d6 未改。
- 合计：PASS 74 / FAIL 5 / NEEDS_HUMAN 24。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md；原文版/修正版/原书疑误分开记录。

## 2. 修复 5 条 FAIL（严格按 suggested_fix，不扩大范围）
| source_id | 网站指出的问题 |
|---|---|
| MD-8.2.1-Examples81and82 | 反馈函数转写忠实，但与正号耦合 Φ=+ξG 及 Gaussian exp[−β(H+Qξ²/2)] 组合时符号/不变性不一致；先对照原页渲染图确认是转录问题还是原书疑误，再按 suggested_fix 处理 |
| MD-8.4-AdditiveThermostatSDE | 各对象本身正确，但完整模型缺对象与参数之间的关联（独立 Wiener、SDE 与恒温器参数未绑定）；补齐关联 |
| MD-8.4.1-NHL | 三个对象公式正确，FAIL 限于声称覆盖“全SDE/二次专门化”；补短陈述或如实缩小覆盖范围 |
| MD-8.4.3-PreEquilibriumMeans | 密度只要求非负可积归一，不保证两项加权函数可积，Bochner 总化积分未必是真实平均；补可积前提 |
| MD-8.4.4-RescalingStationary | havoid 量化的是 Function.support f（f≠0 的集合），与 HasCompactSupport 所用闭包支撑不一致；按 suggested_fix 改为正确的支撑概念 |

- 只改 blueprint/。每条修完单文件编译 + #print axioms；全部修完跑一次完整 check。下游编译失败则最小调整并记录。

## 3. NEEDS_HUMAN（24条）分流
- 绝大多数是 Printed/corrected 双版本：网站判“原文版忠实PASS、修正版PASS、原书数学疑误待人工”（如 NHFirstIntegralPrinted、NoseHamiltoniansPrinted、Theorem81、LyapunovRatePrinted、SLSBracketPrinted、IsokineticDivergencePrinted、SINWeightPrinted、PistonThermostatWeightPrinted 动能缺1/2、DPDMassOrderPrinted 等）。按版本分开登记，并入 CH08_ERRATA；公式类先看原页渲染图并注明“已目视核对原页”（第6、7章都出现过把转录错误记成原书疑误的情况）。缺修正版的补 _corrected（时间盒3条路线）。
- 网站指出“有效域在说明里但没在 def 中强制”的（如 NPEquations 的 β,Q,s>0）：补有效域谓词或在 [EXTRA] 写明，改了签名的进入复审包。

## 4. 文档
- 更新 CH08_ERRATA、CH08_BLUEPRINT（第1章结构，含网站结论）、CH08_SUMMARY_FOR_MENTOR（导师语言，无工程术语和内部流程话）。

## 5. 复审包
- 为本轮改过签名的条目生成 EAUDIT 复审包，格式同第7章 EAUDIT（blueprint/ch08/mathcopilot_tasks/EAUDITxx/ 下 a/b/c，各含 MANIFEST.json、PASTE.txt、PAGES.pdf；PROGRESS 中标“待复审 / EAUDITxx”）。PASTE 开头带“以附件/PASTE 为准，忽略 /workspace 旧文件；Mathlib 定义按标准含义采信”，内嵌哈希，包含全部项目定义体（缺失数为0）。不提交、不等网站。

## 6. 完成标准
- FAIL 修复中 = 0；单文件编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry、0 axiom；第1–7章文件字节未变。
- 复审包已生成，报告包数和条数。
- 提交并 push；CURRENT_STATE 顶部写“第8章首轮结果已整合，复审包待用户提交”，然后停止。
