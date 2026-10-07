# T2 第一批规格：局部时间轨道与点态运动方程

状态：本地准备材料已形成；原页已核对，候选定义/目标类型检查通过，陈述待 MathCopilot 和负责人审阅。这里的目标尚未成为正式库定理。

输入基准：分支 `chapter01-kinetic-energy-nonneg`，HEAD `54b75a14aaa968522903d82eef947ffdc7bbf165`；T1 数学实现提交 `c7d9778fe981c24ba7281db730206d1cfefbba4d`。Lean `v4.34.0`，mathlib `5ed2965256430c3649e86755f9576b54eca72435`。实际正式源码是基准，不沿用旧 T1 规格中的“未证明”描述。

并行状态差异：16:09实查 HEAD 已由原索引对话推进到 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f`，只增加 knowledge 资料；本轮 `git diff 54b75a1 HEAD -- MolecularDynamics MolecularDynamicsFormalization.lean Scratch.lean lean-toolchain lakefile.toml lake-manifest.json scripts` 无差异。保留该提交，T2 输入仍明确绑定54源码快照及另附未提交准备文件；本对话没有提交或推送。

## 1. 原页及本批范围

本轮重新渲染并查看印刷18–19/PDF41–42（§1.2）、印刷25–26/PDF48–49（§1.5及§1.5.1）；另查印刷24/PDF47（§1.4）确认动量定义。教材461页，SHA256 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。工作区上层 `tmp/t2-preparation/ORIGINAL_PAGES.zh-CN.md`、`pages/` 保存本轮证据。

| 原页 | 核对到的内容 | 本批处理 |
| --- | --- | --- |
| 18/41 | (1.3) `Mq̈=F(q)=-∇U(q)`；`N_c` 与 `N_d`；粒子优先的对角质量 | 与实际 `NBodyEquationAt` 对应；T1 索引和正质量桥接直接复用 |
| 19/42 | `dp_i/dt=F_i`；能量/总动量守恒的计算 | 只采用动量方程；守恒留到 T4及相互作用模型 |
| 24/47，补充 | `p=M(q)q̇`；固定 M 时 `q̇=M⁻¹p, ṗ=F=-∂U/∂q` | 采用固定对角质量，不延伸到 `M(q)` 或 Legendre/Hamiltonian 证明 |
| 25/48 | 有限能量相空间，通常局部存在唯一性；常数正定 `M⁻¹`；能量下界控制动量 | ambient 欧氏相空间与实际配置域分开；局部存在的正则性须显式补足 |
| 26/49 | (1.5) `ż=f(z), z(0)=ζ`；势能等值集一致有界；全局流和群律 | 先定义含初始时间的开区间解；不声称全局存在、最大区间或 Flow |

这几页没有给出精确的局部时间区间、碰撞排除域或完整局部 Lipschitz 假设。以下开放配置域、时间区间和正则性层级是形式化补充，并非页面已有编号定理。§1.5 的有界/能量论证不能直接当作全局解的证明。

## 2. 类型、域和质量

例如无力自由粒子，`q(t)=q₀+t v₀`，`p(t)=Mv₀`；因此位置在变化、动量固定，速度是 `M⁻¹p`。这一例子说明不能因 `Position`、`Velocity`、`Momentum` 在 Lean 中是同一透明别名而混淆速度与动量。

- `n : ℕ` 是 `N_c`；`Position n`、`Velocity n`、`Momentum n` 为 `EuclideanSpace ℝ (Fin n)`，`PhaseSpace n = Position n × Momentum n`。相空间维数为 `2n`；三维无约束粒子模型 `n=3N` 给 `6N`。
- 复用 `μ : CoordinateMasses n`，`M := diagonalMassMatrix μ`，物理质量条件 `hμ : ∀ i, 0 < μ i`。质量固定，不依赖 q 或 t。纯定义可以容许任意 μ；使用 inverse 恢复速度和动量的定理必须明确 hμ。非零质量也是逆关系的充分条件，但本批复用 T1 的正质量版本。
- 粒子应用使用 `coordinateMassesOfParticles` 和 `coordinateMassesOfParticles_pos`；不重建 T1。不将 `n` 改成约束自由度 `N_d`；约束流形、周期环面和广义坐标另设模型。
- 配置域 `Q : Set (Position n)`，局部存在阶段要求 `IsOpen Q`。全空间可取 `Set.univ`，避碰模型则取排除奇异构型的开放 Q。实际相空间域是 `Q ×ˢ Set.univ`。
- `F : Force n`、`U : PotentialEnergy n` 作为 ambient 总函数只是 Lean 表示；所有有意义的物理/正则性断言限定在 Q。`U : ... → ℝ` 不表示无穷势垒；被排除点的任意延拓不能当作物理取值。
- `n=0` 和空粒子只是代数退化；初值解必须给出 ε>0及初始域条件，避免空时间区间。物理应用另给 `N>0`，无需为纯矩阵/导数适配引理添加无用条件。

## 3. 候选定义与导数含义

拟实现文件 `MolecularDynamics/Chapter01/LocalTrajectories.lean`，本轮不创建正式模块。矩阵 `mulVec` 返回普通坐标函数；为在欧氏空间求导，先使用 `Matrix.toEuclideanLin`，再用有限维 `LinearMap.toContinuousLinearMap`。不能把前者误当作已经连续的映射。

本地适配注意：固定库在直接搜索 `ContinuousSMul ℝ (Position n/PhaseSpace n)` 时发生心跳超时。独立探针以 `NormedSpace.toIsBoundedSMul` 显式提供库已证明的实例，再使用 `IsBoundedSMul.continuousSMul`，八个适配示例与下面五个定义通过；这不是新数学假设或公理。正式实现时只在必要局部作用域添加同一适配，并验证没有改变既有空间/范数实例。语法上下文为 `open MolecularDynamics Set Filter`、`open scoped Topology`，探针隔离在 `T2Preparation` 命名空间。

候选定义草稿如下；实际类型探针见 API 报告，正式命名仍待审阅：

```lean
noncomputable def massOperator {n : ℕ} (μ : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)).toContinuousLinearMap

noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap

noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)

def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I

def IsLocalMechanicalIVP {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (t₀ : ℝ) (z₀ : PhaseSpace n)
    (ε : ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  0 < ε ∧ γ t₀ = z₀ ∧
    IsMechanicalSolutionOn μ F Q (Set.Ioo (t₀ - ε) (t₀ + ε)) γ
```

`γ : ℝ → PhaseSpace n` 是库的 ambient 曲线表示；只在 I 上要求解方程，区间外扩展没有数学结论。它不是全局解。第一批选 `I=Ioo a b` 且 `a<t₀<b`，局部初值版本选对称 ε 区间；一般集合定义只方便限制，不宣称空集合也是有效局部 IVP。

实际 `IsIntegralCurveOn γ v I` 的定义是 `∀ t∈I, HasDerivWithinAt γ (v t (γ t)) I t`。I 开且 t∈I 时，`I∈𝓝 t` 给出双侧 `HasDerivAt`。在非退化闭区间 `[a,b]` 的端点，它只断言相对区间的单侧导数，不能直接换成 ambient `deriv` 或双侧加速度；若要解释 `derivWithin` 的唯一值还须相应 `UniqueDiffWithinAt`。首批二阶桥接只在开区间内陈述，不承担端点版本。

力场解谓词不内置势能正则性或存在性。保守力层单独写 `hFU : ∀ q∈Q, F q = -gradient U q`，或直接令 `F := fun q => -gradient U q`。hFU 是力与势能的模型关系，不是从任意 F 推出的结论。使用 U 为真梯度的语义需 U 在 Q 可微；纯代数桥接可以在明确 hFU 后不再求导 U。

## 4. 第一批待证明目标

共同记号：`q := fun t => (γ t).1`，`p := fun t => (γ t).2`，`V := velocityOperator μ`，`B := massOperator μ`。表中均是候选结论，尚无正式证明，不添加占位声明。

| ID / 建议名字 | 结论与前提 | 依赖及解释 |
| --- | --- | --- |
| T2-L0 `mass_velocityOperator` / `velocity_massOperator` | hμ 下 `B (V p)=p`，`V (B v)=v`；另证 `B v`、`V p` 的坐标与矩阵 mulVec 相同 | T1 两侧逆及欧氏矩阵包装；不作为隐藏全局假设 |
| T2-S1 `isMechanicalSolutionOn_iff_components` | `IsOpen I` 下，解谓词等价于域成员条件加 `∀t∈I, HasDerivAt q (V(p t)) t ∧ HasDerivAt p (F(q t)) t` | 区间导数转换、连续线性投影、`HasDerivAt.prodMk`；不需 hμ 或 F 连续，仅展开定义 |
| T2-B1 `momentum_eq_mass_deriv_position` | hμ、IsOpen I 和解谓词推出 `∀t∈I, p t=B(deriv q t)` | S1 的位置导数与 L0；得到教材动量–速度关系，不在解假设里预塞 `p=Mq̇` |
| T2-B2 `hasDerivAt_deriv_position` | IsOpen I 和解谓词推出 `∀t∈I, HasDerivAt (deriv q) (V(F(q t))) t`；求导这一步无需 hμ | 先在 I 上得到 `deriv q=V∘p`，用开集邻域等式和 V 的连续线性链式法则；单点等式不够；把它转成 `Mq̈=F` 时才需两侧逆和 hμ |
| T2-B3 `solution_nBodyEquationAt` | 再给模型 hFU，推出 `∀t∈I, NBodyEquationAt μ F U (q t) (deriv (deriv q) t)` | B2 得真实加速度；L0 得 `Mq̈=F(q)`，hFU 得保守力符号。可以先实现 `F=-gradient U` 的特化，不假设要证明的质量–加速度等式 |
| T2-B4 `newtonTrajectory_to_mechanicalSolution` | 给 q,v,a，域成员，`∀t∈I, HasDerivAt q (v t) t`、`HasDerivAt v (a t) t` 和 `M.mulVec(a t)=F(q t)`；hμ 下令 `p=B∘v`，推出 `(q,p)` 的解谓词 | 两条导数假设将 v,a 绑定为真实速度和加速度；对固定 B 求导得 ṗ=B a=F(q)，L0 得 q̇=V p；不需要求导 F 或 U |
| T2-E1 `freeParticle_localIVP` | Q=univ、U=0、F=0、hμ、ε>0、任意 t₀：`γ t=(q₀+(t-t₀)•v₀,B v₀)` 是以 `(q₀,B v₀)` 为初值的局部 IVP | 用自由粒子核对维数、动量及符号；本轮先核对陈述，是否证明以 API 报告为准 |

桥接方向必须分开：仅给某点的 `NBodyEquationAt μ F U q a`，没有曲线导数信息，不能构造轨道、推出 q̈=a、存在唯一性或守恒。B4 的输入是已满足二阶方程并具导数关系的曲线，不是从任意点态数据凭空生成解。已有点态谓词的两个等式可以作为 B4 的动力学输入，但不得假设完整 B3 输出再称为正向桥接。

B4 的 canonical corollary 可以令 `v=deriv q`、`a=deriv (deriv q)`，但必须显式给 `DifferentiableAt ℝ q t` 和 `DifferentiableAt ℝ (deriv q) t`（对所有 t∈I），或给等价 HasDerivAt 证据；不能仅调用全定义的 deriv 而忽略不可微处。

## 5. 正则性与后续存在唯一性的分层

| 层级 | 准确条件 | 可以得到的范围 |
| --- | --- | --- |
| 定义和点态关系 | 任意 ambient F/U/μ；导数用谓词给出 | 可写出方程，不推出实际梯度/可逆性/存在性 |
| S1/B1–B4 | I 开，曲线解或所列导数证据；逆关系加 hμ；B3 加 hFU | 已有解的两种表示桥接，不需要 F 的空间导数；解本身在 I 可微且连续 |
| 经典连续力模型 | Q 开，`ContinuousOn F Q`，U 可微且 hFU | 沿解的 ṗ连续，q 至少二阶连续；这一正则性提升仍待正式证明 |
| C¹ 向量场路线 | Q 开，`ContDiffOn ℝ 1 F Q`；z₀.1∈Q | 本地构造机械场在 z₀ 的 `ContDiffAt ℝ 1`，用库局部存在结果；还需缩短时间以使曲线留在 Q |
| 势能充分条件 | `ContDiffOn ℝ 2 U Q`，`F=-gradient U` 在 Q | 通常给 F 的 C¹ 性并给局部 Lipschitz；固定库“梯度降一阶”、开放域转换和组合证明尚待落实。U 仅 C¹ 通常不足以保证唯一性 |
| 最小 Lipschitz 路线 | F 在每个 q₀∈Q 的某个邻域上 Lipschitz | 更一般的局部唯一性路线；构造 Picard–Lindelöf 所需闭球、统一常数、范数界和小时间条件仍待做 |

不要只写“势能光滑”而省略阶数。对一般力场可独立假设 F 局部 Lipschitz；对保守力才将其由 U 的充分正则性推导。函数/空间连续线性包装采用欧氏范数，`PhaseSpace` 当前乘积范数不是另建的 2n 维欧氏范数；范数估计必须按实际类型核对。

## 6. 已定位但尚未落实的依赖

1. T1 网站独立审阅及负责人签核仍待完成。正式实现前重读其报告，逐项核对质量、维数、矩阵 inverse API 是否影响本规格；源码现已有13条完整 T1 定理，不重证明。
2. T2-L0 包装的两侧 inverse 和 mulVec 坐标等式；B2 的邻域导数等式；B3 与真实二阶导数的质量桥接，均待完整证明和固定版本验收。
3. 局部存在库有 C¹ 与 Picard–Lindelöf 接口；机械向量场满足接口的证明、Q 内小闭球/时间缩短、F 或 gradient U 的正则性转换未完成。
4. 库唯一性接口使用同一 Lipschitz 常数及两条曲线的域成员证据；仅“局部 Lipschitz”到公共短区间的构造未完成。不得把唯一性预先写成解结构字段。
5. 最大存在区间、紧集内延拓、全局存在、全局 Flow/群律、T3 Hamiltonian一致性、T4守恒、Theorem1.1 都在后续范围。

网站分工：先 Lean Blueprint 审上述量词、定义域和依赖；必要时 Math Brainstorm 搜索局部桥接路线；陈述稳定后 Lean Proof 起草 L0→S1→B1→B2→B3，B4/E1随后。本轮未发送 T2 任务、未操作索引。具体可复制指令与未来验收见同目录另外三份 T2 文档。

## 7. 自由粒子核对与验证边界

取 `Q=univ`、`U(q)=0`、`F(q)=0`、`hμ`，任意 `q₀,v₀,t₀` 和 ε>0。设 `q(t)=q₀+(t-t₀)•v₀`、`p(t)=Bv₀`：q̇=v₀，q̈=0，ṗ=0；T1两侧逆给 `V p=v₀`，于是 q̇=Vp、ṗ=F(q)，并且 `Mq̈=0=F(q)=-∇U(q)`。在 t₀ 得初值 `(q₀,Bv₀)`；t₀=0 时就是用户指定样例。位置/速度/动量均有 n 个坐标，但质量乘法不可省略。

该样例已经完成数学陈述、维数和符号核对；`freeParticleGoal` 结论类型已在 Probe03 检查通过。完整自由粒子 Lean 解证明未起草或运行，不能把上述手工核对称为 T2-E1 机器证明。

本轮状态分别为：原页视觉核对通过；五组 API 声明类型通过；局部连续标量作用/导数/矩阵坐标适配通过（最初两个失败尝试另存）；候选定义和七个目标命题的类型通过。T2-L0/S1/B1–B4/E1 完整目标证明、正式构建、T2 CI、网站审阅和负责人语义签核均未完成。本轮正式 Lean 不变，因此没有重复整套构建。

## 8. 已类型检查的完整候选目标

以下是Probe03中的命题值定义，精确列出要证明的前提和结论，**没有提供其证明**。它们不是将目标假设为真，也不是正式库声明；与第4节ID顺序对应。语法环境使用第3节候选定义和API报告中的局部实例。

```lean
-- These are proposition-valued target descriptions, not theorem proofs or assumptions.
def massInverseGoal {n : ℕ} (μ : CoordinateMasses n) : Prop :=
  (∀ i, 0 < μ i) →
    (∀ p : Momentum n, massOperator μ (velocityOperator μ p) = p) ∧
    (∀ v : Velocity n, velocityOperator μ (massOperator μ v) = v)

def componentsGoal {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  IsOpen I →
    (IsMechanicalSolutionOn μ F Q I γ ↔
      (∀ t ∈ I, (γ t).1 ∈ Q) ∧
      ∀ t ∈ I,
        HasDerivAt (fun s => (γ s).1) (velocityOperator μ (γ t).2) t ∧
        HasDerivAt (fun s => (γ s).2) (F (γ t).1) t)

def momentumGoal {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ i, 0 < μ i) → IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    ∀ t ∈ I, (γ t).2 = massOperator μ (deriv (fun s => (γ s).1) t)

def secondDerivativeGoal {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    ∀ t ∈ I, HasDerivAt (deriv (fun s => (γ s).1))
      (velocityOperator μ (F (γ t).1)) t

def nBodyBridgeGoal {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ i, 0 < μ i) → IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    (∀ q ∈ Q, F q = -gradient U q) →
    ∀ t ∈ I, NBodyEquationAt μ F U (γ t).1
      (deriv (deriv (fun s => (γ s).1)) t)

def newtonToFirstOrderGoal {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ)
    (q v a : ℝ → Position n) : Prop :=
  (∀ i, 0 < μ i) → (∀ t ∈ I, q t ∈ Q) →
    (∀ t ∈ I, HasDerivAt q (v t) t ∧ HasDerivAt v (a t) t ∧
      (diagonalMassMatrix μ).mulVec (a t) = F (q t)) →
    IsMechanicalSolutionOn μ F Q I (fun t => (q t, massOperator μ (v t)))

def freeParticleGoal {n : ℕ} (μ : CoordinateMasses n)
    (q₀ : Position n) (v₀ : Velocity n) (t₀ ε : ℝ) : Prop :=
  (∀ i, 0 < μ i) → 0 < ε →
    IsLocalMechanicalIVP μ (fun _ => 0) Set.univ t₀ (q₀, massOperator μ v₀) ε
      (fun t => (q₀ + (t - t₀) • v₀, massOperator μ v₀))
```
