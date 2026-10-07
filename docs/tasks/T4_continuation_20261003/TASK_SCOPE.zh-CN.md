# T4-C1：紧性控制下的有限右端点延拓

状态：2026-10-03 23:01 +08:00，任务包已准备；正式 Lean 证明尚未开始，本批不计为完成。

## 为什么这是下一步

当前 T4 已能对一个已经给定的开区间 `Ioo a b` 上的机械解证明能量守恒、位置留在势垒球内和相空间距离界。教材第一章剩下的关键断点是：如果有限右端点 `b` 尚未到达，而轨道一直留在一个安全的有界/紧相空间区域内，为什么解不能在 `b` 处突然终止。把这个断点补上，才可以把“区间内控制”接到“全未来时间”。

## 本批只做的数学接口

设 `γ : ℝ → PhaseSpace n` 是 `Ioo a b` 上的 `IsMechanicalSolutionOn`，其中 `a < b`。先不把“由势垒自动得到紧集”和“统一局部存在半径”偷偷塞进定理，而是把它们作为明确输入或后续批次：

1. **端点极限小步（优先）**：在 `Ioc t₀ b` 上给出显式的 `LipschitzOnWith`，或给出足以推出统一导数界的假设，证明存在 `z_b` 使
   `Tendsto γ (𝓝[<] b) (𝓝 z_b)`。
2. **局部拼接小步**：假设端点局部 IVP 在 `z_b` 有正半径解，并有固定版本可用的局部唯一性；构造某个 `δ > 0` 和延拓曲线，使其在 `Ioo a (b + δ)` 上满足同一个机械 ODE，并在原区间上与 `γ` 相等。

如果一次完成两个小步会引入过多 API 风险，先只实现第 1 步，或先实现带显式 `z_b`、局部曲线和重叠相等条件的抽象拼接引理。所有假设必须出现在 Lean 类型中，不能把待证的全局结论作为假设。

## 固定输入

- 代码基准：`7c61e9d001887066bfa03771343ce91e7ce68ddb`（当前文档 HEAD 可更高，但 `*.lean` 与该提交一致）。
- Lean：`leanprover/lean4:v4.34.0`。
- mathlib：`5ed2965256430c3649e86755f9576b54eca72435`。
- 相关源码：`MolecularDynamics/Chapter01/LocalTrajectories.lean`、`LocalExistence.lean`、`MechanicalConfinement.lean`、`MomentumBounds.lean`。
- 现有定理只能作为输入：`IsMechanicalSolutionOn.continuousOn`、`mechanicalSolution_unique_on_Ioo`、`exists_localMechanicalIVP_open_of_force_contDiffAt`、`mechanicalSolution_phase_dist_lt`。它们不表示已经完成延拓。

## 明确不在本批

不证明全局解、最大解存在、Theorem 1.1 的完整稳定性、严格的全时间 `sup` 上界、Chapter 1 §1.3 及以后，也不把 MathCopilot 的草稿或网站摘要当作本地验证。正式集成前必须在固定版本本地编译，并区分机器通过和教材语义签核。

## 本批验收

只有以下条件同时满足才可把本批标为完成：

- 新声明没有 `sorry`、`admit`、新公理或 `unsafe`；
- 目标文件和最小 `Scratch` 探针在固定 Lean/mathlib 上退出 0；
- 针对性检查后只运行一次完整 `scripts/check.ps1`，并保存实际日志；
- 关键声明做 `#print axioms`，并在 `FORMALIZATION_MAP.md`、`ASSUMPTIONS.md`、`STATUS.md` 中标明假设边界；
- MathCopilot 返回件（若有）只作为路线/API 输入，最终结论以本地源码和本地日志为准。
