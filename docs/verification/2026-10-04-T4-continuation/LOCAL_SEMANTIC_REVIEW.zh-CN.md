# Theorem 1.1 本地陈述与证明审计

原页：Leimkuhler--Matthews，印刷32 / PDF55（从1起）。2026-10-04 05:57再次查看既有原页渲染 `../tmp/t4-implementation-20261003/pdf/theorem11.png`。

## 教材对应

教材 strong local minimum 使用邻域内每个非中心点的严格势能不等式；库中 `IsStrictPotentialMinOn U Q q₀` 记录中心Q成员及相对域Q的严格邻域条件。Q为开集把它转换成普通局部极小值。固定正对角质量模型下，`(q₀,0)` 由梯度为零成为机械平衡点。

教材的stable要求任意ε>0，存在δ>0使任意δ邻域初值的未来解满足全时间上确界严格小于ε。正式候选用真实ODE谓词陈述，并同时包含未来解存在和对每个同初值未来解的界。这是流值陈述的解语义版本；没有假设一个已存在的全局流。

## 证明链与无循环前提

1. Complete-space/Lipschitz极限、FTC恢复端点导数、C1局部匹配推出有限右端点延拓。原轨道在端点的环境函数值任意，拼接的重叠相等由局部唯一性推出。
2. 连通域唯一性保证各个可延拓右端点的解在重叠处相等；开覆盖拼接得到并集曲线。若右端点集合有有限sSup，未来紧留集给出端点极限并允许超出sSup的延拓，矛盾。
3. 全局依赖的hconfine只限定已经存在的局部IVP。能量势垒模块从机械能量守恒、位置屏障和紧能量子水平集实际推出hconfine，没有把全局存在放进假设。
4. 从strict minimum选安全势垒半径和更小控制半径r<ε；质量上界M由1+sum(abs masses)导出。Hamiltonian在平衡点连续给出所有足够近初值的能量预算；未来存在由第3步构造。
5. 得到每个未来距离<r，明确给出BddAbove及sSup≤r<ε。只给逐点<ε无法推出严格sSup<ε；仅写实数sSup而不证明BddAbove还可能受到条件完备实数sSup默认值干扰。两者都已在最终Stability候选中处理。
6. 任意同初值未来解在公共Ioi区间由连通域唯一性等于构造解，故转移距离range及sup。
7. 默认PhaseSpace乘积距离为max(dq,dp)。欧氏相空间距离明确为sqrt(dq²+dp²)，有max≤欧氏≤2max。以ε/2的乘积严格sup界可给欧氏range的有界性和严格sup<ε；EuclideanStabilityProbe attempt03实际退出0，已集成EuclideanStability正式模块。

## 正则性、范围与验证边界

- 质量逐坐标严格正且固定；不是广义坐标的可变质量矩阵模型。n=0仍允许，质量正性在空索引上是空条件，极小值/势垒与相界处理退化情况。
- 势能特化使用每个q∈Q的ContDiffAt ℝ 2 U q。C2足以给C1力；教材smooth是更强假设，结论因此适用。没有把gradient的总运算恒等式当作无需可微的经典梯度证明。
- 平衡与未来稳定性分别证明；a<0的Ioi a包含0及所有t≥0。环境曲线在a之外不要求ODE。
- 该结果不包含全体初值的全时间流群、任意系统的抽象最大解API、Chapter1所有其它内容或全书完成。
- 当前已通过GlobalContinuation、EnergyGlobalExistence、PotentialRegularity、Stability独立构建以及相关探针。整合后完整check03已于06:07:48--06:10:29退出0：8947jobs、Scratch、231项声明公理审计、固定版本与输入哈希稳定。关键公理依赖允许propext/Classical.choice/Quot.sound；失败探针的自动sorryAx诊断不计为接受证明。
- 原页及本地陈述审计由Codex完成；负责人最终独立语义签核pending。按当前本地范围未运行新远端CI，未访问MathCopilot。
