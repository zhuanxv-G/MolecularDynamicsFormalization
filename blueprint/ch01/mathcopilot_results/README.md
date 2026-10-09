# 网站返回件

本批只需一个文件：`PILOT_ALL_result.md`或`PILOT_ALL_result.json`，内容是PILOT_ALL任务输出的五对象JSON数组。
Codex收到后一次性校验五个source_id和声明名，整合json_review与audit；原始返回件保留，repair_log只追加，缺条/版本不符/未决项不得记PASS或冻结。
非PASS条目本地修复后只生成一个`mathcopilot_tasks/PILOT_REAUDIT.md`，仅含需复审条目；输出保存为`PILOT_REAUDIT_result.md`或`.json`。
模板B已取消，旧分散任务已归档，不再等待15个文件。旧prepare/ingest脚本仅适用于旧单条格式，本批不调用它们（包括--freeze），由Codex读取数组按PILOT.md整合。
