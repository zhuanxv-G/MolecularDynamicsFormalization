# 线性算子、矩阵指数与实谱展开本地语义复核

- 原页印刷27/PDF50本轮再次实际查看：z'=Az、任意初时z(t₀)=ζ，exp(A(t-t₀))ζ与指数级数，以及特征基展开/可能出现复系数的说明。
- LinearFlow用真实Banach代数exp(t•A)，其导数通过固定mathlib非交换指数导数与CLM作用链式法则得到z'=Az；实际初值、全时间唯一性用CLM全局Lipschitz推出。联合(t,z)连续性实际填充Flow，无群律或连续性假定作为存在证明。
- MatrixFlow把矩阵经标准toEuclideanCLM映射到算子；连续代数同态map_exp证明与矩阵exp(tA)mulVec的真实等式。因此不是把一条重新命名的算子式冒充未经桥接的矩阵公式。任意初时真导数/初值唯一性、矩阵Flow、矩阵幂级数已独立退出0。
- finite dimension含0，不要求A对称/可对角化/可逆。指数公式及其ODE成立无需特征基假设。所用NormedAlgebra ℚ仅限制标量实例，无新公理，保持固定版本。
- 实谱探针尚在验证：模式由真实exp(νt)导数与已证唯一性连接；有限初值谱分解及Basis.repr系数拟给显式式。该版本只涉及实特征值/实特征向量，不计复谱/复系数到实解的原文补充完成。
- 独立Linear attempt03、Matrix attempt03已通过；正式全项目验收尚未运行。负责人最终语义签核pending，新远端CI未运行。

实谱SpectralProbe attempt03已退出0，四项关键声明仅三项允许基础公理；Module.Basis命名空间修复后，repr实际给出系数且sum_repr证明初值分解。三模块已正式集成，开始full-check01。复谱及实解恢复仍未证明。

正式full-check01已实际退出0：8958jobs、Scratch、348导入声明审计、固定版本/源码扫描/输入SHA稳定，18项新增关键依赖仅三项允许基础公理。起止时间直接见CHECK_REPORT.json。负责人最终签核pending，远端新CI未运行。
