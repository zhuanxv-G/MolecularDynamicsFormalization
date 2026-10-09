# 接续提示词

当前任务：五步流程第1章试点（5条，见 blueprint/ch01/PILOT.md）。完成后停止等待用户。

先读AGENTS、CURRENT_STATE顶部、WORK_LOG最新条目及blueprint/ch01/。当前只等待一个`mathcopilot_results/PILOT_ALL_result.md`或`.json`。
用户将`mathcopilot_tasks/PILOT_ALL.md`整段复制到网站一个Task，依次执行五条A审校和C只读语义审计，输出一个数组。模板B取消，原15任务归档；不要再要求15个返回件或独立翻译。
收到后按PILOT.md一次性整合；旧单条prepare/ingest脚本本批停用。非PASS本地修复后仅生成一个PILOT_REAUDIT.md，限需复审条目。全部当前版本PASS及issues闭合才冻结；冻结后只改证明，陈述有误退回审计。
以后各章任务包同样每批一个文件，尽量<40KB、最多两个。当前不扩展五条范围。
纯文档不运行完整check；Lean源码变化才跑。正式库与heartbeat保持原约定，网站由用户操作。无新返回件只确认等待；WORK_LOG每检查点≤3行。
