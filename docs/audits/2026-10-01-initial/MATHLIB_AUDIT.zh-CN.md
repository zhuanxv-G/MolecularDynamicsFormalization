# 固定版本 mathlib 能力审计

基准：仓库 `lean-toolchain` 为 `leanprover/lean4:v4.34.0`；`lakefile.toml` 要求 mathlib `v4.34.0`；`lake-manifest.json` 和本地 `.lake/packages/mathlib` 均指向提交 `5ed2965256430c3649e86755f9576b54eca72435`。以下是对**该本地源码**的 `rg` 检索和声明原文阅读；本轮没有写 Lean 源码、没有跑 `#check` 或新构建。类型摘要按源码保留关键前提；调用前仍须在目标模块中做类型检查。

## 第一章直接可用的声明

| 能力 | 实际声明、类型/条件 | 本地源码位置 | 使用界限 |
| --- | --- | --- | --- |
| 有限维实欧氏空间 | `EuclideanSpace 𝕜 n := PiLp 2 (fun _ : n => 𝕜)`；`EuclideanSpace ℝ (Fin n)` 与连续线性等价 `EuclideanSpace.equiv` | `Mathlib/Analysis/InnerProductSpace/PiL2.lean:114,279` | 仓库已将位置、速度、动量别名设为此类型；标量坐标质量和粒子索引需桥接 |
| 梯度 | `gradient (f : F → 𝕜) (x : F) : F`，在完备内积空间中由 `fderiv` 与 `toDual` 构成；`HasGradientAt f f' x`；`HasGradientAt.gradient : gradient f x = f'` | `Mathlib/Analysis/Calculus/Gradient/Basic.lean:69,84,175` | `gradient` 在不可微点仍返回零值定义；导数规则需先证 `DifferentiableAt`/`HasGradientAt`。`hasGradientAt_iff_hasFDerivAt` 在同文件 104 行 |
| 非严格局部极小 | `IsLocalMin f a := IsMinFilter f (𝓝 a) a`；可微函数在局部极小点的 `fderiv` 为零 | `Mathlib/Topology/Order/LocalExtr.lean:63`；`Mathlib/Analysis/Calculus/LocalExtr/Basic.lean:181` | 使用 `≤`，不足以表示教材 PDF 55 页的去心邻域严格不等式；需要专用谓词/等价引理 |
| 正定质量矩阵 | `Matrix.PosDef M` 包含 Hermitian 和非零向量的正二次型；`Matrix.posDef_diagonal_iff` 将对角矩阵正定与各对角元严格正关联 | `Mathlib/LinearAlgebra/Matrix/PosDef.lean:162,203` | 定理受文件中的环、指标类型、`DecidableEq` 等类型类条件约束；这比现有 `0≤mᵢ` 强 |
| 局部轨道 | `IsIntegralCurveOn γ v s := ∀ t∈s, HasDerivWithinAt γ (v t (γ t)) s t`；另有局部点态 `IsIntegralCurveAt` 和全时域 `IsIntegralCurve` | `Mathlib/Analysis/ODE/Basic.lean:44,49,54` | 向量场 API 是时间依赖 `ℝ → E → E`，自治场可包装为常值时间参数；端点内导数与开区间导数需区分 |
| 局部存在 | `IsPicardLindelof.exists_eq_forall_mem_Icc_hasDerivWithinAt` 给在闭时间区间上、指定初值的局部解；`ContDiffAt.exists_eventually_eq_hasDerivAt` 给 C¹ 向量场的邻域局部流 | `Mathlib/Analysis/ODE/ExistUnique.lean:56,167`；假设结构在 `Mathlib/Analysis/ODE/PicardLindelof.lean:73` | `IsPicardLindelof` 含球内空间 Lipschitz、时间连续、向量场有界与时间长度界；局部定理不自动给全局流 |
| 唯一性 | `ODE_solution_unique`：全局 Lipschitz、两解在闭区间连续且满足 ODE、初值相等时在闭区间相等；`ODE_solution_unique_univ` 是全时域版本 | `Mathlib/Analysis/ODE/ExistUnique.lean:326,340` | 具体版本有较强 Lipschitz 假设；需比对书中局部 C¹ 条件，避免把全局 Lipschitz 偷加到原命题 |
| 连续流结构 | `Flow τ α` 有联合连续性、`t₁+t₂` 组合律、零时恒等；`IsForwardInvariant` 表示非负时间下集合不变 | `Mathlib/Dynamics/Flow.lean:57,85` | 这是**已给定**连续全局作用的结构，不会自动从局部 ODE 生成；逆流还需群结构/反向存在 |
| Lyapunov 稳定性 | 对 `Mathlib/Dynamics`、`Mathlib/Analysis/ODE` 用 `Lyapunov`、`stability`、`Stable` 检索，未确认与教材 PDF 55 页等价的直接谓词 | 本地上述两个目录的 `rg` 检索 | 可先在项目中精确定义正向全时轨道和 `sup` 严格界；这不是断言整个 mathlib 没有相关 API |
| 能量常值与紧性 | `is_const_of_deriv_eq_zero`：全域可微且导数恒零则函数常值；`IsOpen.is_const_of_deriv_eq_zero` 用开且预连通域；`isCompact_of_isClosed_isBounded`；`isCompact_sphere` | `Mathlib/Analysis/Calculus/MeanValue.lean:751,767`；`Mathlib/Topology/MetricSpace/Bounded.lean:320`；`Mathlib/Topology/MetricSpace/ProperSpace.lean:47` | 需先证明沿解的导数零；球面紧性用于严格局部极小值的能量屏障；紧困轨道到全局延拓的完整组合仍待确认 |

`gradient` 与 `HasGradientAt` 的基本类型中还有 `[RCLike 𝕜]`、内积空间及完备性前提（源码同文件 47–49 行）；此处项目选 `𝕜=ℝ` 的有限维空间。ODE 局部存在定理还要求状态空间为实 Banach 空间（`NormedAddCommGroup`、`NormedSpace ℝ E`、`CompleteSpace E`）。

## 后半本初步检索

| 主题 | 已确认的本地声明/文件 | 尚未确认的桥接 |
| --- | --- | --- |
| 测度与密度 | `MeasureTheory.ProbabilityMeasure`：`Mathlib/MeasureTheory/Measure/ProbabilityMeasure.lean:103`；`Measure.withDensity` 的应用性质在 `Mathlib/MeasureTheory/Measure/WithDensity.lean:44` 起 | Gibbs 密度归一化、能量面表面测度/Dirac 分布、Liouville 弱解均需逐项研究 |
| Brownian 与适应性 | `ProbabilityTheory.IsPreBrownianReal`、`ProbabilityTheory.IsBrownianReal`（后者含有限维分布与几乎处处连续样本路径）：`Mathlib/Probability/BrownianMotion/Basic.lean:75,302`；`Filtration` 与 `Adapted` 在 `Mathlib/Probability/Process/Filtration.lean:50`、`Adapted.lean:60` | 从实 Brownian 到多维 Wiener、随机积分、Itô 公式和 SDE 解的接口未确认 |
| 遍历 | `Ergodic f μ` 是测度保持加前遍历性的结构：`Mathlib/Dynamics/Ergodic/Ergodic.lean:49`；测度保持见 `Dynamics/Ergodic/MeasurePreserving.lean` | 这是单映射的遍历性；与教材的连续时间 Hamiltonian/Markov 过程、几何遍历率不是同一命题 |
| 随机积分与 SDE | 对 `Mathlib/Probability`、`Mathlib/Analysis/ODE` 的文件名及关键词 `stochastic integral`、`Ito`/`Itô`、`SDE` 检索未确认可直接复用的 SDE 求解或 Itô 积分接口 | 只能记录“当前检索未确认”；不能断言整个 mathlib 不存在。正式实施 Chapter 6–8 前需更广的版本匹配检索与小样例检查 |
| 辛结构 | `Mathlib/LinearAlgebra/SymplecticGroup.lean` 存在；`Dynamics.Flow` 和矩阵微分 API 可作基础 | 此轮未确认与教材 `DΦᵀJDΦ=J`、微分形式、约束流形的直接等价 API；Chapter 2–4 需单独审计 |

检索边界：使用本地源码 `rg`，看了列出的实际定义/定理头部和部分证明；没有全库声明穷举。尤其“当前检索未确认”绝不等于“不存在”。没有借助网页版本、没有升级依赖或改变工具链。源文件中的注释与 `#check` 一样不能代替项目内实际实例化；开始 Lean 实施时应将必要的检查合成一批版本匹配测试。
