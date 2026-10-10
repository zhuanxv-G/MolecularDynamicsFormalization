# 项目接续与形式化约定

当前任务：第2–6章本地流程连续推进（见 docs/handoff/LOCAL_PIPELINE.md）；第1章暂停等待网站审校。
下一步：继续第3章§3.4长期能量守恒；复用现有65条及§3.3完整检查，从已渲染PDF135–142补齐≤8条批次。

## 当前最高优先级范围（2026-10-10用户新指令）

- 第2章复用已完成证据，随后第3→4→5→6章自动推进，不等网站，不进入第7章。范围见LOCAL_PIPELINE，习题/参考文献除外，以PDF原页为准。
- 每章①逐字JSON及全部旧CSV映射；②忠实Blueprint加入构建；③模板C本地预审及完整BATCH/compact的PASTE.txt+原页PDF+SHA256 MANIFEST（实际磁盘字节<256000）；④仅本地PASS证明，已有桥接→短证明→其余；⑤逐条公理、7段文档及终验。
- [EXTRA]逐项注明，疑误[ERRATUM?]与NEEDS_HUMAN；禁止True、P→P、结论作假设、admit、新增axiom、unsafe、偷换对象/量词/结论。网站列仅待网站审计，不伪造PASS或冻结。
- MolecularDynamics/正式库不改源码或签名、0 sorry；第1章交付逐字节冻结。仅出现第1章新返回件时，当前节提交后按原EAUDIT及repair_log只追加整合，修签名后重审，再回当前章。
- 第5章Mathlib缺失的微正则/遍历/KAM等大型理论不建设，忠实陈述后sorry+缺项；每节2小时时间盒。第6章仅可桥接已有定理，不恢复封存断点/长证明；Thm6.1/6.2/Prop6.4无现成桥接则sorry。
- 每章从上章最后commit新建chapterXX-blueprint；每节一次commit+push已授权。每小批≤8条及时落盘，更新该章PROGRESS与跨章唯一总表LOCAL_PIPELINE；每小批单文件lake env lean，每节完整scripts/check.ps1。固定Lean4.34.0/Mathlibv4.34.0。
- 单条3条失败路线或缺大型理论即sorry+缺项继续；不等待导师。最终状态仅self-contained / checked+documented priors / incomplete，含sorryAx必须incomplete，区分直接和传递占位。
- 唤醒先git status，再只读AGENTS、CURRENT_STATE顶部、WORK_LOG最新、LOCAL_PIPELINE及当前章PROGRESS；核对现有编译/验证证据，复用已通过工作；未提交半成品核对后续做，不丢弃。每检查点WORK_LOG≤3行；不向STATUS/FORMALIZATION_MAP/ASSUMPTIONS追加长文；其他任务output/tmp/check-full06等不动、不提交。
- heartbeat lean prompt已授权扩大为第2–6章；ACTIVE/15分钟、原target及resume_state.json去重保留。只在明确usage limit/quota/rate limit中断且get_usage_limits恢复后发送；运行/排队则安静；同失败轮一次，间隔≥30分钟；不购买/切账号/切模型。同章同检查点连续3次无进展中断后停止自动发送并通知，配置成功不等于恢复已实测。
- 全部完成后CURRENT_STATE顶部写“第2–6章本地流程全部完成；第1–6章均等待用户提交 MathCopilot 批次（见各章 mathcopilot_tasks/INDEX.md）”，停止；以后仅确认状态或整合新返回件。

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
- heartbeat lean保持ACTIVE/15分钟；prompt已按用户新指令扩大为第2–6章，原target和去重机制保留。第1章规则仅暂停时的新返回件整合适用。完成标准：全章JSON/Blueprint/本地预审/批次包齐全、能证已证、文档生成、check通过、push。完成后顶部写“第1章本地部分完成，等待用户提交 MathCopilot 批次（见 INDEX.md）”，以后只确认状态。
- mathcopilot_results/出现新返回件时优先合并JSON审校和语义审计，登记EAUDIT批次；保留原始件、repair_log只追加，签名修复后重新审计。
- 默认中文先说重点，明确原页核对、Lean编译、公理审计、网站审计、导师确认哪些已验证。本次用户新指令取代试点5条后等待及先冻结再证明限制。

