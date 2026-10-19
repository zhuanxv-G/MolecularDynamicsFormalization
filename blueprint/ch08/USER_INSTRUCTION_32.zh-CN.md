# 32号：第8章复审结果整合 + 收口（2026-10-19 用户指令；第8章不再送网站）

请先把以下全文写进 AGENTS.md 顶部规则和 docs/handoff/CURRENT_STATE.zh-CN.md 顶部（替换“第8章首轮结果已整合，复审包待用户提交”），并同步 heartbeat lean 的接续 prompt（保留 ACTIVE/15分钟/target/去重；接续消息改为“按32号继续第8章收口”，停止条件为第5节完成标准），然后执行。

## 0. 范围
- 唯一任务：第8章最终收口，做法同26号（第6章）和30号（第7章）。分支 chapter08-blueprint。
- 第1–7章不动；正式库 MolecularDynamics/ 保持 0 sorry、字节冻结。

## 1. 登记网站复审返回（10条全部到齐）
- 已交付到 blueprint/ch08/mathcopilot_results/eaudit/EAUDIT01–04_result.json（用户合并成3个任务提交，脚本按 source_id 拆回并逐条校验 input_sha256；"merged_from" 属正常）。Ch08.lean 自 718f75f0 未改（sha256 a58849c4…）。
- 合计：PASS 2 / FAIL 0 / NEEDS_HUMAN 8。登记入 website_audit.json、WEBSITE_SUMMARY.json、PROGRESS.md。
- PASS：PreEquilibriumMeans、RescalingStationary（网站确认首轮 FAIL 已修好，旧报告过期，Lean 无需改）。

## 2. NEEDS_HUMAN 8条：只改元数据和文档，不改 Lean 签名
网站对 8 条的 Lean 声明逐个判 PASS，NEEDS_HUMAN 只来自原书疑误、过时备注和标注不清。按版本分开登记（修正版=网站PASS，原文=原书疑误待导师），并入 CH08_ERRATA。逐条按 suggested_fix 处理：

| source_id | 要做的 |
|---|---|
| MD-8.1.2.1-NPEquations | 原页 delta 指代矛盾**未消除**，删去“已目视排除”之类表述；写明 n 版是修正选择；使用 npField 时须另带 npValidDomain、U 可微、EN=H_N^(n)(z₀) |
| MD-8.2.1-Examples81and82 | Printed（+ξG）标原书符号疑误，不得被其他条目当有效定理依赖；corrected（−ξG）保留 |
| MD-8.4-AdditiveThermostatSDE | 更新过时备注（“未组装/未绑定”已不成立）；原书缺 dt、矩阵噪声相容条件记疑误；描述改为“对角物理质量、交换涨落耗散特例”，不冒充一般模型 |
| MD-8.4.1-NHL | 原书质量重缩放疑误，写出正确方向和变换后的势；不得把 harmonicPotential 说成已完成 (8.30)–(8.32) 的正定二次特化或定理8.1 |
| MD-8.5-SLSLeapfrog | 原书约化式漏 μ⁻¹（一般 μ 下应为 ξ̇=−μ⁻¹∂ηU），标疑误；_corrected 保留 |
| MD-8.6.2-SINLyapunov | 原书有符号尾项上界疑误；写明单位质量与噪声关系 σ²=2γθ；不把局部生成元陈述升级为遍历性定理 |
| MD-8.7.1-PronyOUStationarity | 平稳初态（方差 θc/τ、与 W 独立）是补充前提，[EXTRA] 明确标出；摘要写清 t,s≥0 和 Fin K 求和范围 |
| MD-8.8.1-PistonHamiltonianSubfield | 原印场 (p,−∇U,0,0,0) 在一般质量下为疑误；摘要写明哪个是原印场、哪个是修正场；补充前提标 [EXTRA] |

- 所有 STALE_* 类问题（过期的验证引用、R4 来源、页码核对说明）一并刷新。
- 公式类疑误先看原页渲染图，确认是原书问题后再写“已目视核对原页”；看不清的如实写“待人工”。
- 若某条确实必须改签名才能满足 suggested_fix：单文件编译 + #print axioms，状态记“按网站审校意见修复，本地核验通过（未再送网站）”。预期不需要。
- 最后跑一次完整 check。不生成新 EAUDIT 包。

## 3. 文档
- 更新 CH08_ERRATA（第1章字段，每项“网站复审结论”行）、CH08_BLUEPRINT、CH08_SUMMARY_FOR_MENTOR（导师语言，无工程术语和内部流程话；统计口径同第1章：网站PASS数、本地按意见修复数、原书疑误数、已证/未证声明数及未证原因分类）。

## 4. 不做的事
- 不改第1–7章；不为未证陈述建大型理论；不再送网站；不做习题。

## 5. 完成标准
- 第8章 FAIL 修复中 = 0；一次完整 check 通过；正式库 0 sorry、0 axiom；第1–7章文件字节未变。
- 提交并 push；CURRENT_STATE 顶部写“第8章最终收口完成；全书第1–8章正文收口，等待用户新指令”，然后停止。
