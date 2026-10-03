# T4 守恒与局部存在检查点

更新时间：2026-10-03 14:00 +08:00。分支 `chapter01-kinetic-energy-nonneg`，验收时 HEAD `21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1`。

- 已实际查看教材印刷19/PDF42 的能量导数、总动量守恒，以及印刷24/PDF47 的固定质量 Hamilton 方程。三份正式模块 `EnergyConservation.lean`、`LocalExistence.lean`、`MomentumConservation.lean` 已导入顶层；Scratch 和公理审计已更新。
- 七条草稿证明及动量两条证明已在固定 Lean 单独编译；正式工程 `pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T4-first-batch` 已退出0。版本、源码扫描、8935 jobs、Scratch、182项公理依赖均通过。关键定理仅依赖 `propext`、`Classical.choice`、`Quot.sound`。受检输入 SHA 与原日志保存在检查报告中。
- 证明范围：已有保守解的能量守恒；C¹ 力场在开配置域初值处的局部解存在；全局 Lipschitz 场下共同开时间区间内的唯一性；合力逐方向为零时各总动量分量守恒。局部 C¹ 下唯一性、最大解延拓、全局存在和完整 Theorem 1.1 仍未证明。
- 网站 MathCopilot 的完整证明独立审阅尚未发送；用户称额度已更新并打开项目页，但本聊天 Browser 页面读取持续超时，额度及发送状态未实证。负责人教材语义最终签核仍待本人。
- 接续第一步：核对实际 Git 状态和本批 `CHECK_REPORT.json`，保存/推送 T4 具体文件并确认相应 CI；然后推进局部唯一性、延拓与稳定性链。保留旧 `FORMALIZATION_PLAN.md`、网站状态和其他未跟踪材料，不把它们混入 T4 提交。
