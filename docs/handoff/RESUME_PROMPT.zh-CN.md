# 接续提示词

当前任务：第2–6章本地流程连续推进（见 docs/handoff/LOCAL_PIPELINE.md）；第1章暂停等待网站审校。
下一步：继续第3章§3.5；复用§3.4完整检查及短证明；scripts/ch03_section35*.py为已核原页的预备输入，尚未生成计数。

先git status，读取AGENTS、CURRENT_STATE顶部、WORK_LOG最新、LOCAL_PIPELINE及当前章PROGRESS。从最近落盘批次接续，核验已有结果后复用，不重做已通过的JSON、Blueprint、证明或构建；未提交半成品核对后继续。
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
