# T2/T5 本地补充复核

状态：本地补充复核完成。用户在原 T2 接续聊天要求“继续”；当前约定只做本地工作，不使用 MathCopilot。

范围固定为 `9baf87f89d07138a95bfbfe1f37d45dd54946cf7` 中的
`LocalTrajectories.lean` 和 `PotentialBarriers.lean`，以及它们既有的本地验收证据。
逐条检查数学假设、证明链、教材对应和证据的输入/输出哈希。

全书长期聊天 `01a102b1-a3fe-71e1-a571-347703fc09b8` 仍在推进 Kepler 分离积分；
本次复核不修改其 Lean 源码、探针、构建输入或 Git，不代为发送消息。

这是一份本地补充复核。MathCopilot 原报告尚未收件，其历史状态不改变；
负责人最终教材语义签核仍需单独完成。

输出：`LOCAL_REVIEW.zh-CN.md`、`REVIEW_LEDGER.csv`、`EVIDENCE_CHECK.json`。

实核结果：T2十五条、T5二十五条命名证明已逐项登记；未发现源码阻断问题。
两份源码与固定提交原始字节一致；两批27件冻结输入及20份原始日志SHA全部匹配。
公理审计证据已核对，未重建Lean或刷新远端CI。
原始字节及运行方式见 `VerifyEvidence.ps1`，输出清单及SHA见 `LOCAL_RETURN_METADATA.json`。
