# 项目接续与形式化约定

当前任务：第1章本地部分完成，等待用户提交 MathCopilot 批次（见 INDEX.md）
下一步：BATCH01使用mathcopilot_tasks/compact/BATCH01/README.md的a/b/c小Task（853字节指令+对应两附件，总<256000字节）；无网站新件确认等待，有新件优先整合并登记EAUDIT批次。

## 当前最高优先级范围（2026-10-09用户夜间指令）

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
- heartbeat lean保持ACTIVE/15分钟、不修改；不进入第2章。完成标准：全章JSON/Blueprint/本地预审/批次包齐全、能证已证、文档生成、check通过、push。完成后顶部写“第1章本地部分完成，等待用户提交 MathCopilot 批次（见 INDEX.md）”，以后只确认状态。
- mathcopilot_results/出现新返回件时优先合并JSON审校和语义审计，登记EAUDIT批次；保留原始件、repair_log只追加，签名修复后重新审计。
- 默认中文先说重点，明确原页核对、Lean编译、公理审计、网站审计、导师确认哪些已验证。本次用户新指令取代试点5条后等待及先冻结再证明限制。
