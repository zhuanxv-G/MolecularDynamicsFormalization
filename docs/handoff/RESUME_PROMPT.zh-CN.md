# 接续提示词

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
