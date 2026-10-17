# 第24号本地收口证据

唯一范围：第2–5章。用户完整指令见 `USER_INSTRUCTION.zh-CN.md`；全局冻结基线见 `FROZEN_BASELINE.json`。

- `register.py` 已完成380条原返回登记及输入哈希核对。源码已改后不得重新运行登记脚本；原输入快照保留在各章 `*.before.*`，原返回不改。
- `integrate_transcriptions.py` 的网站A排印更正已执行，逐字段前后值见各章 `TRANSCRIPTION_CHANGES.json`；原书数学疑误未被工作修正版覆盖。
- `repair.py` 按27项原建议串行修复，每项完整单文件与全声明公理打印有独立收据；`REPAIRS.json` 保留FAIL、建议、差异摘要和日志摘要值。
- `errata_apply.py` 每批至多8个来源，增加独立修正版；已证桥接优先，其余最多三条短证明路线，未解决者显式保留。原有疑误字面版不证明。`CORRECTIONS.json` 记录各版本。
- 编译失败必须先按日志最小修补并保存差异，再重新核验当前批；不可因已写入修正清单就认定通过，不能在失败批未核验时继续累加批次。
- `special_local.py` 核对网站缺少的项目定义或跨条摘录；FastVerlet有独立kick–drift–kick等式证明。未证时间PDE、误差阶仍标未证，不列作原书错误。
- `full_check.py` 在当前章所有源码稳定后调用标准完整检查，并绑定当前章源码。所有原生Lean/构建保持串行。已通过的同一输入证据复用。
- `finalize_chapter.py` 在完整检查通过后生成七段BLUEPRINT、合并ERRATA、导师摘要和逐条状态。网站PASS与证明完成分开；原文版、修正版和反例判定分开。
- `verify_delivery.py` 检查全部返回、27项修复、每章完整检查、冻结字节、逐条全文、七段结构、勘误覆盖及统计。Git推送由最终命令另行确认。

`full-before-A-closeout` 是第2章补记A栏“任意积分器须可逆”问题前的一次通过检查，仅作历史证据；最终验收只采用各章 `full/CHECK_REPORT.json` 与当前源码绑定。

运行状态以 `docs/handoff/CURRENT_STATE.zh-CN.md` 和最新工作日志为准。不重新提交网站、不产生新EAUDIT包；完成提交推送后停止。

第5章R1返回的附件同一性未能在网站认证；本地另行视觉核对原书PDF202并恢复FlowFieldTransport两处原印方括号，见`ch05/LOCAL_PAGE202_VERIFICATION.json`与`pdf202.png`。其余仅附件同一性问题不冒称已解决，也不误列为原书数学疑误。
