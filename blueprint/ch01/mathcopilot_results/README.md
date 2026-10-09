# 第1章网站返回件

提交顺序和上传文件见 `../mathcopilot_tasks/INDEX.md`。BATCH01–BATCH23每批是一个Task，包含原文审校A和只读语义审计C；模板B已取消。网站由用户提交。

原样保存返回数组为 `BATCH01_result.json`、`BATCH02_result.json`……。若网站返回带文字或围栏，可先保存同名 `.md`；保留原始件再解析。

每项字段：`source_id`、`json_review{status,issue_codes,corrected_json,issues,evidence}`、`audit{lean_decl,verdict,explanation,counterexample,suggested_fix}`。输入版本以对应批次 `MANIFEST.json` 的文件哈希为准。

新返回件优先整合：合并原文修订并追加repair_log，保存网站审计结果，核对声明与输入版本；修改过的声明重新审计并登记EAUDIT批次，相关本地证明重新检查。缺条、版本不符或未决项不能记PASS，未返回项保持“待网站审计”。

当前进度只看 `../PROGRESS.md`。未来整合的网站审计写入 `../website_audit.json`（数组或按source_id组织的items），渲染脚本会读取它。旧单条格式prepare/ingest脚本不用于这些批次数组，不自动freeze。没有新件时只确认等待，不控制网站，不改heartbeat，不进入第2章。
