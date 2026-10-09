# 接续提示词

当前任务：五步流程第1章试点（5条，见 blueprint/ch01/PILOT.md）。完成后停止等待用户。

先读AGENTS、CURRENT_STATE顶部、WORK_LOG最新条目、blueprint/ch01/。新指令覆盖旧等待状态。
只处理5条：原文JSON → Blueprint → 只读审计/修复/复审/冻结 → 证明冻结陈述 → 终验。
MathCopilot网站由用户本人操作；不操作浏览器或网站，不等待/轮询。读取mathcopilot_results的新返回件，按PILOT规定整合并记录。
Blueprint允许by sorry；正式库0 sorry。第1–6章源码、证明、签名原样保留。冻结后不得改签名；新实质证明仅处理frozen条目。
缺网站结果时完成所有可独立本地工作，保存检查点commit/push，写清缺件并停在“等待网站结果”。
全部PASS才冻结；终验及自动审阅材料最终完成后写“第1章试点已交付，等待用户/导师确认格式”，以后只确认状态，不扩展。
heartbeat lean保持ACTIVE / 15分钟，不修改。WORK_LOG每检查点≤3行，不向历史进度文档追加长文。
