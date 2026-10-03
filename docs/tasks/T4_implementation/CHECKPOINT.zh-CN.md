# T4 守恒与局部存在检查点

更新时间：2026-10-03 15:30 +08:00。分支 `chapter01-kinetic-energy-nonneg`，T4 代码最近已推送提交 `4d55e405c665ddfd9fcc5d4d0de1084a3a691b04`，交接文档提交为 `264f1280b041a01c4f973d8e1879b75f194c079b`。

- 已实际查看教材印刷19/PDF42 的能量导数、总动量守恒，以及印刷24/PDF47 的固定质量 Hamilton 方程。三份正式模块 `EnergyConservation.lean`、`LocalExistence.lean`、`MomentumConservation.lean` 已导入顶层；Scratch 和公理审计已更新。
- 七条首批草稿、动量两条证明及新增 C¹ 初始状态附近唯一性证明已在固定 Lean 编译；正式工程第三次检查 `pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T4-third-batch` 已退出0。版本、源码扫描、8935 jobs、Scratch、184项公理依赖均通过。关键定理仅依赖 `propext`、`Classical.choice`、`Quot.sound`。失败的第二次选项语法尝试保存在 `T4-second-batch`，不作成功证据。
- 证明范围：已有保守解的能量守恒；C¹ 力场在开配置域初值处的局部解存在；机械场在共同初始状态 C¹ 时初始时刻附近唯一；全局 Lipschitz 场下共同开时间区间内的唯一性；合力逐方向为零时各总动量分量守恒。最大解延拓、全局存在和完整 Theorem 1.1 仍未证明。
- 新增 `Equilibrium.lean`：在开配置域、严格相对势能极小及负梯度力条件下，证明 `(q₀,0)` 是固定质量机械向量场的平衡点。该桥接不包含稳定性或全局延拓。
- 网站 MathCopilot 的完整证明独立审阅尚未发送；用户称额度已更新并打开项目页，但本聊天 Browser 页面读取持续超时，额度及发送状态未实证。负责人教材语义最终签核仍待本人。
- C¹ 唯一性文件和第三次验收证据已提交为 `522f82de4863f9ef64f0a9a2f3cf3dbb8f02b1bc` 并推送；GitHub Actions run `37104591425` / job `111150531699` 已成功。平衡点桥接已提交为 `4d55e405c665ddfd9fcc5d4d0de1084a3a691b04`，第四批本地验收及远端 run `37105793203` / job `111153920486` 也已成功。接续推进最大延拓与稳定性链。保留旧 `FORMALIZATION_PLAN.md`、网站状态和其他未跟踪材料，不把它们混入 T4 提交。
