# T1 收尾审阅：本地复核

日期：2026-10-02，Asia/Shanghai。审阅范围仅为既有 T1 陈述、13 条完整证明及对 T2 的依赖影响。本文件不是 MathCopilot 返回，也不是负责人语义签核。

实际分支 `chapter01-kinetic-energy-nonneg`，HEAD `121a9d02ad15500c630e505b363d5f04106d617f`。数学实现输入为 `c7d9778fe981c24ba7281db730206d1cfefbba4d`；已验证的固定源码目录为 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f`。Lean 固定 v4.34.0，mathlib checkout/manifest `5ed2965256430c3649e86755f9576b54eca72435`。

## 输入和验证边界

- 本轮实际读取 `ParticleCoordinates.lean`、`NBody.lean`、`Notation.lean`、`BasicDefinitions.lean`、顶层导入、T1 规格和既有验收记录。12 项当前输入 SHA256 全部匹配 `docs/verification/2026-10-02-T1/CHECK_REPORT.json`；本轮复核结果保存于工作区上层 `tmp/t1-t2-review-20261002/INPUT_RECHECK.json`。
- 重看已有教材原页图像印刷 18–19/PDF41–42，确认 (1.3)/(1.4)、粒子优先的重复质量、N/N_c/N_d 以及动量方程；守恒计算不属于 T1 的代数桥接证明。
- 既有固定版本本地检查和对应 c7d9778 的远端 CI 成功是历史机器证据。本轮未重新构建、未查询远端 CI、未修改证明，不把本轮阅读写成新的机器验收。
- MathCopilot 页面控制超时；截至本报告首次保存，审阅任务尚未发送。网站检查、技能实际参与和负责人最终语义签核均保持待完成。

## 逐 ID 复核

| ID | 已有定理 | 本地结论及必要前提 |
| --- | --- | --- |
| T1-I1 | `flattenParticleVectors_apply` | 与索引定义一致；任意 N,d，无质量条件。`a.val+d*i.val` 是粒子优先排列。 |
| T1-I2 | `unflatten_flatten`、`flatten_unflatten` | 两方向互逆完整给出；使用逐坐标外延性，没有将普通函数空间范数当作欧氏范数。 |
| T1-M1 | `coordinateMassesOfParticles_apply` | 每个粒子的 d 个坐标重复同一质量；不是独立指定 d 个质量。 |
| T1-M2 | `coordinateMassesOfParticles_pos` | 由严格正粒子质量得到严格正坐标质量；d=0 时只是空索引结论。 |
| T1-M3 | `coordinateMassesOfParticles_pos_iff` | 反向明确使用 `0<d`，以第 0 个方向读取每粒子质量；没有空量词漏洞。 |
| T1-E1 | `nBodyKineticEnergy_particle_eq` | 任意实质量的代数等式；按等价换索引、有限乘积求和和每粒子欧氏范数平方展开，没有多加质量正性。 |
| T1-P1 | `diagonalMassMatrix_posDef_iff` | 固定库 `Matrix.posDef_diagonal_iff` 给出正定与全部对角质量严格正的等价。零维情形是库的代数约定。 |
| T1-P2 | `diagonalMassMatrix_isUnit` | 严格正质量先给 PosDef，再用其 isUnit。非负质量不能替代此假设。 |
| T1-P3 | `diagonalMassMatrix_mul_inv`、`diagonalMassMatrix_inv_mul` | 将矩阵 IsUnit 显式转成 `IsUnit M.det`，符合 `mul_nonsing_inv`/`nonsing_inv_mul` 的实际前提。 |
| T1-P4 | `diagonalMassMatrix_inv_eq` | 先证明逐坐标倒数组成的矩阵为左逆，再用 `Matrix.inv_eq_left_inv`；`ne_of_gt (hm i)` 明确排除零质量。没有无条件使用奇异矩阵逆。 |
| T1-P5 | `diagonalMassMatrix_inv_mulVec` | 由两侧逆及 mulVec 复合得到逐坐标恒等式；输出是普通坐标函数的等式，T2 仍需连续线性包装。 |

共 11 个 ID、13 条 theorem。本地审阅未发现需要改变上述正式陈述或假设的阻塞问题；这是阅读结论，仍须网站独立审阅和负责人签核。

## 对 T2 的影响

可以沿用粒子质量正性桥接、正定/可逆性、两侧逆和逐坐标倒数表达。T2-L0 应新增矩阵与欧氏连续线性包装之间的作用等式，并从已有两侧逆导出包装互逆；这些尚未证明。

`NBodyEquationAt` 只约束给定位置/加速度。它不能替代轨道的导数证据。现有 Position/Velocity/Momentum 透明别名相同不意味着速度等于动量。T1 不提供局部存在唯一性、Hamiltonian 一致性或沿解守恒。

旧 T1_SPEC 的“未证明”、旧 HEAD 和旧 Notation 注释差异是准备历史；当前正式源码已完成对应实现及注释修正。送审必须说明这一时间差，不据旧文档重做 T1。

下一具体动作：MathCopilot 连接恢复后，发送本目录外的专用 T1 只读审阅指令；取得逐 ID 网站结论并核对是否影响 T2，然后保持负责人签核为独立项目。
