# 接续提示词

第2章本地部分完成；第1、2章均等待用户提交 MathCopilot 批次（见 blueprint/ch01|ch02/mathcopilot_tasks/INDEX.md）
下一步：仅确认等待状态；有新返回件则按EAUDIT与追加repair_log规则整合、修签名后重审；不进入第3章。

每次唤醒只读AGENTS、CURRENT_STATE顶部、WORK_LOG最新和blueprint/ch02/PROGRESS.md，再按下一步读取相关输入。
第2章按第1章本地五步流程逐节工作，正式库不改且0 sorry；Blueprint允许by sorry。每小批单文件Lean，每节完整scripts/check.ps1及逐条公理审计，每节一次commit并push。
第1章暂停等待网站审校，blueprint/ch01/、Blueprint/Ch01.lean及docs/review/CH01_*逐字节冻结；仅新返回件可在第2章当前节提交后按原EAUDIT规则整合，repair_log只追加，修签名后重审。
第2章每批≤8条A原文审校+C只读语义审计；直接生成PASTE.txt+原页PDF+SHA256 MANIFEST，合计<256000字节，同时保留完整版BATCH。网站未返回写待网站审计，不伪造PASS或冻结。
只证本地PASS；优先桥接→短证明；单条3次失败或缺大型理论保留sorry并继续，导师问题记录后继续。
固定Lean4.34.0/Mathlibv4.34.0。状态仅self-contained / checked+documented priors / incomplete，含sorryAx必须incomplete；唯一逐条表blueprint/ch02/PROGRESS.md。
每检查点更新CURRENT_STATE，WORK_LOG条目≤3行。heartbeat lean保持ACTIVE/15分钟，不进入第3章。
完成标准：全章JSON/Blueprint/本地预审/compact批次齐全、能证已证、7段文档生成、完整check通过、push；完成后第1、2章均等待用户提交批次。
