# Hamiltonian二次线性化数据语义复核

印刷32/PDF55原页已用固定PDF本地渲染并视觉查看：教材写出 H-hat=δpᵀM⁻¹δp/2+δqᵀU″(q*)δq/2，并在前页说明线性化与Hartman--Grobman背景。

本批不把矩阵公式偷换成任意对称矩阵假设；从固定mathlib的 `ContDiffAt.isSymmSndFDerivAt` 导出真实C2势能二阶Frechet导数对称，再与真实保守机械场的 `-D(gradient U)` force block 联立。尚未构造坐标矩阵转置/质量二次型的完整等价式，也未证明正定性或Hartman--Grobman拓扑共轭。

candidate01三关键退出0、无警告，仅基础公理；full-check20实际13:04:31--13:07:20退出0，8984jobs/727声明，Scratch/固定版本/源码扫描/输入SHA稳定通过。负责人最终语义签核pending、无新远端CI、全书未完成。
