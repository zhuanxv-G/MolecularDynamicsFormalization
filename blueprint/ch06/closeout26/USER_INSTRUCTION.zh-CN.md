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
