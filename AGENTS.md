# 项目接续与形式化约定

第2–5章修复完成，等待用户提交 EAUDIT 复审包（见各章 mathcopilot_tasks/EAUDIT*/INDEX.md）
下一步：停止本轮推进，只确认完成状态；等待用户明确新指令。第6章仍暂停，不进入第7章。

## 当前最高优先级范围（用户2026-10-14晚指令）

- 顺序第2→3→4→5章，每章按节；第1章按原规则继续登记/修复，优先级较低。第6章暂停于WIP 6b822a9a524f，第7章禁止进入。
- 修复队列docs/handoff/REPAIR_QUEUE.md为准。A漏前提/定义域：补签名或子类型并标[EXTRA]；B漏结论：优先补全，跨source_id才显式缩statement_scope并追加repair_log；C对象不忠实：按网站路线修，需路线选择或书中疑误则仅记NEEDS_HUMAN；D数学判断仅登记问题、选项、网站反例并保持现状。
- 修复阶段不写新证明。已有证明受签名影响仅尝试≤3次小修补，失败保留sorry并记录；新证明留到复审PASS冻结后。
- 每批≤8条：单文件编译、相关已有证明重查、逐条#print axioms、生成EAUDIT复审包。完整scripts/check.ps1仅每章结束一次；每节commit+push。固定Lean/Mathlib v4.34.0，正式库源码/签名冻结且0 sorry。
- 返回件按WEBSITE_AUDIT_RULES.zh-CN.md绑定快照；第2章reaudit审计优先、第一轮json_review优先。旧快照PASS不自动覆盖新签名。原始返回/旧绑定收据不改，工程外mathcopilot_bundles只读。
- CORRECTED对照PDF原页视觉复核后合并源JSON；repair_log只追加，不静默删句。[EXTRA]、[ERRATUM?]及直接/传递sorry风险明确登记。
- 每个PASTE开头声明仅以本PASTE及附件为准、忽略网站/workspace旧版本，Mathlib标准定义按标准数学含义采信；全部input_sha256值直接写出并要求原样回显。网站用代码写入/workspace/.mathcopilot/reviews/chXX_eaudit/EAUDITxx_review.json对象(batch,input_sha256,items)，json.loads自检后仅回复路径和统计。每章EAUDIT INDEX列出待提交包。
- heartbeat lean保持ACTIVE/15分钟/原target和去重机制，仅额度明确中断且恢复才接续；运行/排队安静。REPAIR_QUEUE显示第2–5章全部修复完成则停止发送。配置保存不等于恢复续接已实测。
- 每检查点更新CURRENT_STATE并追加WORK_LOG≤3行；每章一行网站PASS/已修待复审/待导师/修复中。全部完成顶部写“第2–5章修复完成，等待用户提交 EAUDIT 复审包（见各章 mathcopilot_tasks/EAUDIT*/INDEX.md）”，停止只确认状态。
- 先git status，读AGENTS、CURRENT_STATE顶部、WORK_LOG最新和REPAIR_QUEUE，复用已有通过证据。保留其他任务output/tmp/check-full06等，不动不提交。

## 第1章规则（网站审计修复时适用）

- 第1章正文印刷p.1–45，习题除外；逐字JSON → 忠实Blueprint → 每批≤8条A原文审校+C只读语义审计包 → 本地预审PASS后在Blueprint证明 → 自动渲染全章文档。模板B取消。
- 原5条试点为BATCH01，原15任务已归档。网站只由用户提交；Codex只生成任务包并整合返回件，不控制网站，不等待网站才开展本地证明。
- MolecularDynamics/正式库不改源码或签名、保持0 sorry；Blueprint/允许by sorry。禁止admit、新增axiom、unsafe绕过、True、P→P、结论作假设或凭空新增对象。
- 保留对象、量词、假设及全部结论；额外前提逐条[EXTRA]，疑似原文错误[ERRATUM?]，不确定原文NEEDS_HUMAN。必须渲染PDF原页核对；单个符号放context_notation；定性描述合并或登记excluded_qualitative。旧CH01_CLAIMS.csv全部映射。
- PROGRESS.md为唯一逐条进度表；local_audit.json使用模板C判定，只有本地PASS条目进入新证明。网站未返回写待网站审计，不伪造网站PASS或冻结。
- 优先桥接既有证明→短证明→其余；单条3次失败或缺大型理论则保留sorry、记录缺项并继续；需要导师判断的问题记录后继续，无人回复时不等待。
- 按节提交；每小批单文件lake env lean，每节结束完整scripts/check.ps1，固定Lean4.34.0/Mathlib v4.34.0，不升级。逐条#print axioms，含sorryAx必须incomplete；区分直接与传递占位风险。
- scripts/render_blueprint.py生成docs/review/CH01_BLUEPRINT.zh-CN.md；每条7段并有汇总及NEEDS_HUMAN/[ERRATUM?]列表。状态只用self-contained / checked+documented priors / incomplete。
- 每次唤醒只读AGENTS、CURRENT_STATE顶部、WORK_LOG最新、PROGRESS.md，再按下一步读相关输入。每检查点更新CURRENT_STATE，WORK_LOG≤3行；不向STATUS/FORMALIZATION_MAP/ASSUMPTIONS追加长文。
- 首次接续核验Git分支、HEAD、未提交文件，保留其他任务文件。commit+push已授权；每节一次commit。
- heartbeat lean保持ACTIVE/15分钟；prompt按2026-10-14指令限于第2–5章网站修复，原target和去重机制保留。第1章规则仅暂停时的新返回件整合适用。完成标准：全章JSON/Blueprint/本地预审/批次包齐全、能证已证、文档生成、check通过、push。完成后顶部写“第1章本地部分完成，等待用户提交 MathCopilot 批次（见 INDEX.md）”，以后只确认状态。
- mathcopilot_results/出现新返回件时优先合并JSON审校和语义审计，登记EAUDIT批次；保留原始件、repair_log只追加，签名修复后重新审计。
- 默认中文先说重点，明确原页核对、Lean编译、公理审计、网站审计、导师确认哪些已验证。本次用户新指令取代试点5条后等待及先冻结再证明限制。


## 2026-10-13网站整合补充

用户新指令及操作细则见[WEBSITE_AUDIT_RULES.zh-CN.md](docs/handoff/WEBSITE_AUDIT_RULES.zh-CN.md)。旧的缺绑定一律不提升规则已撤销；依赖闭包位于工程外，只读引用。第2章第一轮C仅参考，reaudit audit优先、json_review以第一轮为准。heartbeat不改。
