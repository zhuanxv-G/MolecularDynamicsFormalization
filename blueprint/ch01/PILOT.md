# 第1章五步流程试点（5条）

当前是第1–3步的本地待审任务包，网站结果尚未返回，全部frozen=false。只有全部当前版本语义PASS后才能冻结；未冻结时不开展新实质证明。正式库第1–6章全部保留，heartbeat lean ACTIVE / 15分钟不修改。

| source_id | 范围 | 实际印刷页 / PDF页 | 原文证明 | 当前本地材料 |
|---|---|---|---|---|
| MD-1.5.3-Thm1.1 | Theorem 1.1 | 32 / 55；背景31 / 54 | 仅思路，完整证明null | 直接复用现有欧氏稳定定理 |
| MD-1.2-EnergyConservation | 能量导数为零及守恒 | 19 / 42 | 展示导数计算 | Newton位置-速度能量包装 |
| MD-1.3-NewtonEulerLagrange | Newton ⇔ Euler–Lagrange | 23 / 46；L定义22 / 45 | 无独立证明 | 双向轨迹等价包装 |
| MD-1.4-LegendreHamiltonian | M(q)的Legendre变换 | 24 / 47 | 代数推导；最大值条件无证明 | 字面前提草稿，含sorry/[ERRATUM?] |
| MD-1.5.1-FlowInverse | 反演、可逆性、Abelian群律 | 26 / 49 | 无独立证明 | 复用现有反演/双射/群律 |

用户给出的Theorem1.1页跨度含前页背景；不把Hartman–Grobman陈述收入本条。单个符号和定义背景置context_notation。Legendre原文不能以固定对角质量结果代替；原文“可逆”是否继承凸性/正定需独立裁决。

## 文件和顺序

- `ch01_source.json`：5条逐字原文、页码、记号、疑点；初稿DRAFT，修复日志只追加。
- `Blueprint/Ch01.lean`（工程根）：5条marked声明及必要辅助定义；独立Lake库，允许by sorry；正式库仍0 sorry。
- `mathcopilot_tasks/`：15个初始任务，模板A/B/C每条各一个；可直接复制正文，所需上传文件和原页范围已列明。
- `tasks.json`：每个任务的source_id、类别、正式库基线commit、原文/签名/定义前导/项目依赖哈希。
- `mathcopilot_results/`：用户保存网站原始返回件；没有返回件时不等待、不轮询、不登记PASS。
- `audit.json`：只读审计、独立翻译比较、冻结信息、每条对照表及本地验证证据。
- `dependency_inventory.json`：实际传递导入的项目文件；`LOCAL_PDF_CHECK.json`记录本地原页核对。
- `validation/`：完整check及实际逐条#print axioms；含sorryAx的条目不能归为已证。
- `docs/review/CH01_PILOT.zh-CN.md`：从三个输入自动生成；当前为待审草案，最终状态全部incomplete。

先把模板A的5个任务交给网站逐字审校。用户把结果以任务名.json或.md放回后，Codex整合；若原文修复，必须重新生成后续B/C新版本任务。模板B独立翻译后，Codex逐条比较签名并记录，不自动执行返回的Lean代码。最后使用approved JSON执行模板C只读语义审计。非PASS条目在本地修复后另开审计任务，不在审计任务内修改。

JSON返回件可由`python scripts/ingest_ch01_results.py`整合；它只处理本目录对应任务结果，检查任务名/source_id/当前哈希，幂等保留原始件和审计历史，repair_log只追加。不符合结构的.md须人工读取并整合，不能因解析失败视为通过。

独立翻译经本地比较后，在audit条目`blueprint_translation`记录`status="COMPARED"`、详细`comparison`及当前`input_fingerprint`。审计原始输出保存于`review_history`；JSON issues逐项由PDF/陈述证据关闭（status=closed/resolved）。任何疑点未解决均不能冻结。

需要修复时，修改未冻结的本地草稿及对应JSON issues/repair_log，使用例如：

```powershell
python scripts/prepare_ch01_tasks.py --source-id MD-1.4-LegendreHamiltonian --revision r2
```

旧任务/旧返回件保留。新的审计任务在tasks.json注册；确认audit的task字段指向新任务，待其返回。只有五条全部JSON approved、独立翻译已比较、当前哈希的语义PASS、issues已闭合，才执行`python scripts/ingest_ch01_results.py --freeze`。该命令缺任一条件就拒绝冻结。冻结快照记录签名及定义/依赖哈希；以后只改证明体。陈述有误则显式将frozen撤回并重走第3步。

## 本地验收与最终交付

```powershell
pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory blueprint/ch01/validation/<新目录>
python scripts/validate_ch01_pilot.py blueprint/ch01/validation/<新目录>
python scripts/render_blueprint.py
```

check保持固定Lean/Mathlib版本，正式库证明捷径仍拒绝；Blueprint占位单独登记，不冒充完整证明。validate复核报告输入与日志哈希、正式库与起始commit相同、5条实际传递公理，并保留独立语义审计状态。风险扫描包含sorry/admit/axiom/unsafe/True和P→P候选；P→P的语义平凡化仍需逐条人工审计。Lean内置propext/Classical.choice/Quot.sound为明确先验，含它们的完整证明归为checked proof + documented priors。

第4步仅处理frozen条目，签名保持原样。终验仍须有当前版本的语义PASS、fresh check、直接风险和依赖闭包风险。完成后commit/push，CURRENT_STATE顶部写“第1章试点已交付，等待用户/导师确认格式”，停止且不扩展范围。当前阶段只能写“等待网站结果”，不能提前使用最终交付措辞。

## 缺件（当前全部15件）

| 条目 | 原文审校A | 独立翻译B | 只读审计C |
|---|---|---|---|
| MD-1.5.3-Thm1.1 | T_json_review_MD-1.5.3-Thm1.1 | T_blueprint_MD-1.5.3-Thm1.1 | T_audit_MD-1.5.3-Thm1.1 |
| MD-1.2-EnergyConservation | T_json_review_MD-1.2-EnergyConservation | T_blueprint_MD-1.2-EnergyConservation | T_audit_MD-1.2-EnergyConservation |
| MD-1.3-NewtonEulerLagrange | T_json_review_MD-1.3-NewtonEulerLagrange | T_blueprint_MD-1.3-NewtonEulerLagrange | T_audit_MD-1.3-NewtonEulerLagrange |
| MD-1.4-LegendreHamiltonian | T_json_review_MD-1.4-LegendreHamiltonian | T_blueprint_MD-1.4-LegendreHamiltonian | T_audit_MD-1.4-LegendreHamiltonian |
| MD-1.5.1-FlowInverse | T_json_review_MD-1.5.1-FlowInverse | T_blueprint_MD-1.5.1-FlowInverse | T_audit_MD-1.5.1-FlowInverse |

## 已验证与未验证

本地已对照9张渲染原页核对5条及上下文；Blueprint单文件和最终完整scripts/check.ps1通过（Legendre占位警告）。最终证据为validation/local-20261009-final/CHECK_REPORT.json，首轮r1仅记录调整前版本的检查点。实际#print axioms表明4条无sorryAx，Legendre含1处sorry及sorryAx；4条本地证明为checked proof + documented priors，但五步流程最终状态全部incomplete。无返回件时冻结拒绝保护已实测；15个当前任务哈希和自动生成陈述无证明体、重复生成一致性已检查。MathCopilot原文审校、独立翻译、语义PASS、冻结及导师确认均未完成。参考workshop URL无法通过当前检索工具读取；本地严格按用户给出的五步规则及claude-notes模板A/B/C执行，未控制网站。
