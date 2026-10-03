# T4 平衡点桥接验收

- 时间：2026-10-03 15:20–15:23 +08:00。
- 新增 `MolecularDynamics/Chapter01/Equilibrium.lean`，定义 `IsMechanicalEquilibrium` 并证明 `strictPotentialMin_mechanicalEquilibrium`。
- 完整命令：`pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T4-fourth-batch`；固定 Lean 4.34.0 与 mathlib `5ed2965256430c3649e86755f9576b54eca72435`，源码扫描通过，`lake build` 8936 jobs、Scratch、186 项项目声明公理依赖均成功。新定理依赖只含 `propext`、`Classical.choice`、`Quot.sound`。完整输入和日志见 `CHECK_REPORT.json`。
- 数学范围：开配置域的严格相对势能极小点给出普通局部极小；Fermat 导数结论使总梯度为零；若 `F=-gradient U`，则 `(q₀,0)` 是固定质量机械场的平衡点。这只完成平衡步骤，不涉及正向解存在、能量屏障延拓或 Lyapunov 稳定。
- 远端 CI 已在提交 `4d55e405c665ddfd9fcc5d4d0de1084a3a691b04` 上成功：GitHub Actions run `37105793203` / job `111153920486` 于 2026-10-03 15:18:48 +08:00 完成，元数据见 `REMOTE_CI_RESULT.json`。MathCopilot 独立证明审阅、最大/全局解延拓、完整 Theorem 1.1 与负责人语义签核仍未完成。
