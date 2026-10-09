# 第1章五步流程试点（5条）

当前等待一个网站结果文件。将`mathcopilot_tasks/PILOT_ALL.md`整段复制到MathCopilot一个Task，按开头清单上传/@引用文件。该任务一次处理五条，先模板A原文审校，再模板C只读语义审计。模板B独立翻译已取消。

| source_id | 范围 | 印刷页 / PDF页 |
|---|---|---|
| MD-1.5.3-Thm1.1 | Theorem 1.1 | 32 / 55；背景31 / 54 |
| MD-1.2-EnergyConservation | 能量导数为零及守恒 | 19 / 42 |
| MD-1.3-NewtonEulerLagrange | Newton ⇔ Euler–Lagrange | 23 / 46；L定义22 / 45 |
| MD-1.4-LegendreHamiltonian | 配置相关M(q)的Legendre变换 | 24 / 47 |
| MD-1.5.1-FlowInverse | 反演、可逆性及Abelian群律 | 26 / 49 |

## 当前任务与归档

- 唯一活动任务：`mathcopilot_tasks/PILOT_ALL.md`（24486字节UTF-8，小于40KB）。输入版本、五条哈希和任务哈希登记在`tasks.json`的PILOT_ALL项。
- 唯一所需返回件：`mathcopilot_results/PILOT_ALL_result.md`或`.json`，含五个对象的JSON数组；字段结构见任务末尾。
- 原15个A/B/C文件已原样移动到`mathcopilot_tasks/archive/`；tasks.json保留其历史登记并标为被替代/取消。
- `ch01_source.json`、`Blueprint/Ch01.lean`及其依赖是本次原有数学输入，内容未变。`audit.json`保留既有验证和未冻结状态，仅同步合并任务、取消B的流程元数据。
- `docs/review/CH01_PILOT.zh-CN.md`继续由三个输入自动生成，仍是待审草案，五条最终状态incomplete。

## 收到一个数组后的整合

1. 读取原始返回件一次，保留原文件；核对五个source_id各出现一次、声明名正确、输入与PILOT_ALL登记的原文/签名/定义/依赖哈希相符。若.md包裹JSON，先提取唯一数组；格式错误、缺条或重复不得静默忽略。
2. 逐条合并json_review：状态为PASS/REPAIRED/NEEDS_HUMAN；corrected_json只按原页证据合并，保持source_id，不覆盖既有repair_log，只追加每次修复前后值、来源和原因。保留旧issues及解决记录，不静默删除疑点。
3. 将audit判定、解释、反例、修复建议和返回件出处写入audit.json及review_history；A修订原文时，确认C实际依据修订原文审计的是现有Lean签名，不是网站建议的未来签名。任何不确定项不算PASS。
4. 非PASS或仍有未决问题的条目本地修复后，只生成一个`mathcopilot_tasks/PILOT_REAUDIT.md`，包含所有需复审条目和其修订依据，不重复已PASS条目。它沿用A后C及单数组格式；返回件为`PILOT_REAUDIT_result.md`或`.json`。再次复审前将上轮任务/返回件归档保存，不覆盖历史证据。
5. 仅当全部原文已approved、全部当前签名语义PASS、issues已闭合，才记录冻结签名/输入哈希并标frozen=true。模板B已取消，不是冻结条件。冻结后新实质证明不改签名；陈述有误则退回审计。

旧`scripts/prepare_ch01_tasks.py`、`scripts/ingest_ch01_results.py`（含--freeze）面向旧单条A/B/C格式，本批停用；不要让它们忽略PILOT_ALL数组或再次要求B。由Codex按上述规则一次性整合，不需要用户拆分返回件。本轮是纯文档/任务登记变更，不改这些脚本。

## 后续各章规则

每批一个文件，合并该批全部条目，先A再C，不再生成每条一个任务或模板B任务。优先控制在40KB以内；必要时最多拆成两个文件。非PASS条目的每轮复审也只用一个文件。此约定不授权当前试点扩展到其他条目或章节。

## 验证与等待

本轮未改Lean源码，未运行完整scripts/check.ps1；只检查任务长度、五条输入/签名保真、输出结构、15个归档文件原样保留、活动任务/入口一致性及Git差异。
既有本地Lean证据仍为`validation/local-20261009-final/CHECK_REPORT.json`：完整check、fresh check和逐条公理审计已通过；4条无sorryAx，Legendre仍有1处sorry及疑似原文前提问题。网站语义审计、冻结和第4–5步最终交付尚未完成，全部frozen=false。
收到结果后如只改JSON或文档，不重跑Lean全检；只有Lean源码变化才运行完整check。审阅文档可用`python scripts/render_blueprint.py`更新。heartbeat lean保持ACTIVE / 15分钟不修改。当前停止等待PILOT_ALL_result；无新返回件只确认状态。
