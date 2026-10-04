# 线性化 Hamiltonian 二次能量语义复核

印刷32/PDF55的公式已在上一批实际视觉核对。正式定义使用实际 `momentumKineticEnergy` 与 `fderiv (gradient U) q*`，文本展开是定义等式；正质量提供动能非负，额外显式的 Hessian 二次型非负条件提供势能块非负，因此得到二次 Hamiltonian 非负。

该批保持假设边界：没有从“严格局部极小”未经证明地推出 Hessian 正定，也没有把二次能量非负升级成非线性稳定性或 Hartman--Grobman。candidate03四关键退出0、无警告，仅基础公理；full-check21实际13:17:26--13:19:36退出0，8985jobs/733声明，Scratch/固定版本/源码扫描/输入SHA稳定通过，负责人签核pending。
