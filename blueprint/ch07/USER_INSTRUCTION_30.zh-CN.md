# 30号：第7章复审结果整合 + 最后修复 + 收口（2026-10-19 用户指令；第7章不再送网站）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第8章本地流程完成，等待用户新指令”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按30号继续第7章收口”，停止条件为第5节完成标准），然后执行。

## 0. 范围
- 唯一任务：第7章最终收口，做法同26号（第6章）。分支 chapter08-blueprint。
- **禁止修改第8章**：Blueprint/Ch08.lean 和 blueprint/ch08/ 正在网站首轮审校中，返回要按哈希校验。
- 第1–6章不动；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站复审返回（35条全部到齐）
- 已交付到 blueprint/ch07/mathcopilot_results/eaudit/EAUDIT01–12_result.json（用户合并成3个任务提交，脚本按 source_id 拆回并逐条校验 input_sha256；"merged_from" 属正常）。Ch07.lean 自 bf0f8b8a 未改。
- 合计：PASS 24 / FAIL 1 / NEEDS_HUMAN 10。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。
- NEEDS_HUMAN 10条多为“签名/修正版正确，原书疑误或原文范围需人工选定”：按版本分开登记（修正版=网站PASS，原文=原书疑误待导师），并入 CH07_ERRATA。

## 2. 修复 1 条 FAIL
- MD-7.12-ConstrainedHOSplitting：网站认可漂移、扩散、分段解和 O-H-O 次序；FAIL 仅因组合随机映射缺 H/O 的联合可测性，且未指定 P.prod P 上的输出随机变量/条件分布。按 suggested_fix 补联合可测前提和输出随机变量规格；不建新理论，补不上的部分在 [EXTRA] 写明并列入覆盖缺口。
- 单文件编译 + #print axioms，再跑一次完整 check。状态记为“按网站审校意见修复，本地核验通过（未再送网站）”，website_audit.json 保留原返回、suggested_fix 原文和 diff 摘要。不生成新 EAUDIT 包。

## 3. 文档
- 更新 CH07_ERRATA（第1章字段，每项“网站复审结论”行）、CH07_BLUEPRINT、CH07_SUMMARY_FOR_MENTOR（导师语言，统计口径同第1章：网站PASS数、本地按意见修复数、原书疑误数、已证/未证声明数及未证原因分类）。

## 4. 不做的事
- 不改第8章；不为未证陈述建大型理论；不再送网站。

## 5. 完成标准
- 第7章 FAIL 修复中 = 0；编译、逐条 #print axioms、一次完整 check 通过；正式库 0 sorry、0 axiom；Ch08 文件字节未变。
- 提交并 push；CURRENT_STATE 顶部写“第7章最终收口完成；第8章首轮网站审校中，等待用户新指令”，然后停止。
