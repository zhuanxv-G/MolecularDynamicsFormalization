# 项目接续与形式化约定

当前任务：第2章本地五步流程（见 blueprint/ch02/PROGRESS.md）；第1章暂停在等待网站审校（见 blueprint/ch01/mathcopilot_tasks/INDEX.md）。
下一步：完成§2.5 Runge–Kutta、PRK、Newmark及多导数/多步法，补齐160旧条目映射并做全章终验。

## 第1章规则（暂停；仅新返回件整合时适用）

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
- heartbeat lean保持ACTIVE/15分钟、不修改；第1章暂停，按下述第2章范围继续，不进入第3章。完成标准：全章JSON/Blueprint/本地预审/批次包齐全、能证已证、文档生成、check通过、push。完成后顶部写“第1章本地部分完成，等待用户提交 MathCopilot 批次（见 INDEX.md）”，以后只确认状态。
- mathcopilot_results/出现新返回件时优先合并JSON审校和语义审计，登记EAUDIT批次；保留原始件、repair_log只追加，签名修复后重新审计。
- 默认中文先说重点，明确原页核对、Lean编译、公理审计、网站审计、导师确认哪些已验证。本次用户新指令取代试点5条后等待及先冻结再证明限制。

## 当前最高优先级范围（2026-10-09第2章新指令）

- 第2章正文印刷p.53–94/PDF75–116，习题和参考文献排除；逐字JSON→忠实Blueprint→本地模板C预审与A+C包→PASS条目本地证明→终验与7段文档。旧CH02_CLAIMS.csv的160条全部映射。
- 唯一逐条进度blueprint/ch02/PROGRESS.md；每批≤8条，直接生成compact子任务PASTE.txt、裁原页PDF和SHA256 MANIFEST，指令加附件<256000字节；保留完整版BATCH。
- 第1章全部交付冻结，BASELINE.json保存字节哈希；没有新返回件不碰第1章。新件在第2章当前节提交后按原EAUDIT及repair_log追加规则整合，随后回第2章。
- 共享脚本不改生成器，另写ch02版本；正式库源码和签名不改、保持0 sorry。Blueprint可sorry；其余禁止项、[EXTRA]、[ERRATUM?]、NEEDS_HUMAN和原页渲染要求同第1章。
- 每节一次commit并push已授权；每小批单文件lake env lean，每节完整scripts/check.ps1及逐条#print axioms。单条3次失败或缺大型理论记录继续，不等待导师。
- 每次唤醒只读本文件、CURRENT_STATE顶部、WORK_LOG最新、ch02/PROGRESS，再按下一步读取输入。每检查点更新状态、日志≤3行；不向STATUS/FORMALIZATION_MAP/ASSUMPTIONS追加长文。
- 固定Lean4.34.0/Mathlibv4.34.0，heartbeat lean ACTIVE/15分钟原样，不进入第3章；完成全章及push后第1、2章均等待用户提交MathCopilot批次，仅有新件时整合。
