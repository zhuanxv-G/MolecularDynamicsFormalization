# MathCopilot 短提示词（第一轮只做 A）

下面代码块中的内容直接复制到 MathCopilot。B（局部解拼接）等 A 的 API 确定后再单独发送。

```text
请只读审阅固定提交 7c61e9d001887066bfa03771343ce91e7ce68ddb 的一个 Lean API 问题。环境：Lean 4.34.0，mathlib 5ed2965256430c3649e86755f9576b54eca72435。相关文件：MolecularDynamics/Chapter01/LocalTrajectories.lean、LocalExistence.lean、MechanicalConfinement.lean、MomentumBounds.lean。

目标 A：在 Euclidean PhaseSpace n 中，γ 是 Ioo a b 上的 IsMechanicalSolutionOn，并且在 Ioc t₀ b 上满足明确的 LipschitzOnWith（或等价的统一连续/导数界假设）。请设计一个可编译的定理，证明存在 z_b，使 Tendsto γ (𝓝[<] b) (𝓝 z_b)。

请只返回：
1. 完整 Lean 定理声明（所有假设）；
2. 固定版本真实存在的 import、引理名和签名；
3. 最小证明骨架或隔离探针；
4. 实际检查命令、退出码和未解决 API 缺口。

不要修改仓库或 Git，不要讨论全局稳定性，不要声称 Theorem 1.1 完成。若该假设不足以推出端点极限，请明确指出缺少的有界性/完整性条件，不要用“有界所以收敛”代替证明。
```

收到 A 的原始回复和日志后，再准备第二条只讨论局部 IVP 拼接的短提示词。
