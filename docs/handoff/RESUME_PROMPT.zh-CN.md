# 当前接续：用户2026-10-16第19号指令

唯一任务第1章收口；先读AGENTS/CURRENT_STATE顶部与WORK_LOG最新，固定版本复用CLOSEOUT19编译收据。第6章WIP e1f19ef8暂停；第2–5章终验93d2d3e5和正式库冻结，不进入第7章。
完整指令见CH01_CLOSEOUT_DIRECTIVE_20261016.zh-CN.md；只有全部本地交付验收且commit+push后才写第1章收口完成并停止。

---
历史提示（冲突处以上文为准）

# 接续提示词

当前任务：继续完成第6章本地流程（印刷211–258 / PDF232–279）；第2–5章沿用已完成修复验收，不进入第7章。
下一步：复用批26的128条编译证据，从WIP 6b822a9a524f续接132条；批27无结果且原进程已结束，保留记录，以新收据完成检查后继续§6.3.4–6.4.5。

## 当前最高优先级范围（用户2026-10-16新指令）

- 恢复第6章本地①–⑤流程；第2–5章审核修复已完成，不重新展开修复队列。第1章按原规则暂停；MolecularDynamics/正式库字节冻结、0 sorry；不进入第7章。
- 每批≤8条及时落盘并单文件Lean编译；每节完整scripts/check.ps1、逐条#print axioms、七段文档及commit+push。沿用Lean/Mathlib v4.34.0。
- 仅本地PASS条目证明：现成正式桥接→短证明；三条失败路线或缺大型理论即sorry+缺项继续。Thm6.1/6.2/Prop6.4没有整条现成桥接则sorry；不恢复封存断点或长证明。
- 保留完整对象、量词、前提及全部结论；EXTRA/ERRATUM?明确，禁True、P→P、结论作假设、admit、新axiom/unsafe。JSON/旧映射/模板C/compact/完整版BATCH/INDEX齐全；每个PASTE+原页PDF+MANIFEST合计<256000字节，只生成不提交网站。
- 网站未审写待网站审计，含sorryAx必须incomplete；最终状态仅self-contained / checked+documented priors / incomplete。每检查点更新PROGRESS、LOCAL_PIPELINE及WORK_LOG≤3行，复用已通过证据，保留未提交半成品及其他任务文件。
- 全部本地流程完成后更新CURRENT_STATE终态并停止于第6章；已完成第2–5章EAUDIT网站复审与导师判断仍待用户处理。

## 历史交接（暂停第6章及停止推进已被本次新指令覆盖）

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
