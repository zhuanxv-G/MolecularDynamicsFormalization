# T1：粒子、坐标与正质量桥接规格

状态：本地陈述/依赖准备；没有开始新教材证明。2026-10-01，Asia/Shanghai。
输入基线：`chapter01-kinetic-energy-nonneg`，HEAD `6203fc19908312faf9c40d52cb299edb42422973`。
MathCopilot 本批目标是复核陈述、假设和依赖；其本批工作尚未发送或执行。证明实现须在陈述复核后另行启动。

## 1. 原页证据与语义结论

教材为 Leimkuhler–Matthews (2015) 给定 PDF，共 461 页；SHA-256 为 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。
本轮重新从 PDF 渲染并查看了印刷 18–19 / PDF 41–42；文字提取仅用于定位，公式、下标和排列由图像核对。
局部图像保存在工作区上层 `tmp/t1-preparation/section12-041.png`、`section12-042.png`，不属正式 Git 库；可从 PDF 重建。

| 教材对象 | 原页含义 | T1 表示 |
| --- | --- | --- |
| `N` | 粒子数；教材粒子编号为 `1,…,N` | `N : ℕ`，粒子索引 `Fin N`；Lean 索引 `i` 对应书中第 `i.val + 1` 个粒子 |
| 空间维数 | 本页具体讨论实直线和三维空间 | `d : ℕ` 是实现层的统一参数；`d=1`、`d=3` 对应原页，其余维数是显式推广 |
| `N_c` | 位置坐标总数；三维笛卡尔坐标为 `3N` | 粒子模型用 `N * d`；原有通用坐标模型继续用独立 `n=N_c` |
| `N_d` | 构型状态可局部变化的独立方向数 | 无约束时等于 `N_c`；有 `r` 个独立约束时为 `N_c-r`；本批不引入约束流形 |
| `q_j`、`q̇_j` | 单粒子位置、速度；三维时都是欧氏三维向量 | `EuclideanSpace ℝ (Fin d)`；粒子族用 `Fin N → EuclideanSpace ℝ (Fin d)` |
| 质量 `m_j` | 单粒子质量，不是每个空间方向可独立选择的质量 | `Fin N → ℝ`；展开后各坐标重复所属粒子质量 |
| `M`，(1.3) | 常数对角质量矩阵；三维对角元按粒子依次重复三次 | 复用 `diagonalMassMatrix`，参数由粒子质量展开得到 |
| 动能，(1.4) | `∑ j, m_j * ‖v_j‖² / 2` | 与现有标量坐标动能的等式列为待证明桥接 |

有约束的三维笛卡尔表示仍可保留 `N_c=3N` 个环境坐标，约束减少的是独立方向 `N_d`。不能把 `Position n` 的 `n` 改成 `N_d` 后继续套用重复对角质量公式。若换成内禀广义坐标，质量矩阵还可能依赖位置且不再对角，需要另设模型。

旧审计中“不默认 `N_c=3N`”应理解为须明确坐标模型/空间维数，不能误读为约束一加入就将 `N_c` 改成 `3N-r`。`N_d=N_c-r` 的形式化还需要约束独立性/秩条件和 `r≤N_c`；仅写自然数减法不能证明自由度结论。本批只记录这一教材约定。

## 2. 与现有源码的差异

- `Notation.lean` 的模块注释把 `n` 泛称为 degrees of freedom；`NBody.lean` 的模块注释、定义及映射明确 `n=N_c`。这是注释不一致，本轮未改源码。后续实现时应把前者改为配置坐标数，并在无约束模型中说明与自由度相等。
- `CoordinateMasses n := Fin n → ℝ` 容许任意坐标质量；现有定义没有保证属于同一粒子的坐标使用同一质量。T1 要添加粒子质量到坐标质量的桥接，而不是把原 API 的任意 `n` 或任意质量悄悄收窄。
- `nBodyKineticEnergy_nonneg` 的假设仅为 `∀ i, 0≤masses i`。该证明已完成，但零质量容许出现，所以不能作为可逆性依据。
- `ASSUMPTIONS.md` 已解释重复质量后粒子式和坐标式一致；目前正式库没有对应等式定理。T1 把该等式列为具体待证明对象。
- 粒子族的普通函数空间范数不是全体坐标的欧氏范数。动能中使用的是每个粒子向量的欧氏范数；展开向量使用既有 `EuclideanSpace`。不以普通函数空间的整体范数替换这两者。
- `NBodyEquationAt` 仍仅为给定位置/加速度的点态关系。PDF 42 的沿解守恒属于 T2–T4，不能由本批正质量桥接自动得出。

## 3. 索引与定义草案

下列代码只在文档里提出；不加入正式 `.lean`，也没有定义的互逆性证明。
命名建议放在 `MolecularDynamics` 命名空间；拟实现文件为 `MolecularDynamics/Chapter01/ParticleCoordinates.lean`，导入现有 `NBody.lean`，保持原 API。

```lean
abbrev ParticleMasses (N : ℕ) := Fin N → ℝ
abbrev ParticleVectors (N d : ℕ) := Fin N → EuclideanSpace ℝ (Fin d)

def particleCoordinateEquiv (N d : ℕ) : Fin N × Fin d ≃ Fin (N * d) :=
  finProdFinEquiv

def coordinateMassesOfParticles {N d : ℕ} (m : ParticleMasses N) :
    CoordinateMasses (N * d) :=
  fun k => m ((particleCoordinateEquiv N d).symm k).1

def flattenParticleVectors {N d : ℕ} (v : ParticleVectors N d) : Velocity (N * d) :=
  WithLp.toLp 2 (fun k =>
    v ((particleCoordinateEquiv N d).symm k).1
      ((particleCoordinateEquiv N d).symm k).2)

def unflattenParticleVectors {N d : ℕ} (w : Velocity (N * d)) : ParticleVectors N d :=
  fun i => WithLp.toLp 2 (fun a => w (particleCoordinateEquiv N d (i, a)))

noncomputable def particleKineticEnergy {N d : ℕ}
    (m : ParticleMasses N) (v : ParticleVectors N d) : ℝ :=
  ∑ i, m i * ‖v i‖ ^ 2 / 2
```

`Position`、`Velocity`、`Momentum` 目前是同一欧氏空间的透明别名，上面的展开也能用于位置。但使用处须按语义标明参数；不因 Lean 类型相同就混用速度与动量。若将来需要带语义名字的位置展开，可提供透明包装，不在本批更换既有类型。

排列约定：`e(i,a).val = a.val + d*i.val`。三维 `a=0,1,2` 分别表示 `x,y,z`；故质量排列为 `m₁,m₁,m₁,m₂,m₂,m₂,…`，与原页一致。
`N*d` 与教材的 `dN` 数值相等，选择 `N*d` 是为匹配 `finProdFinEquiv` 的目标类型，不代表改变模型。

## 4. 待证明的精确陈述

以下每项都是候选结论。下列代码块是定理的**结论类型**，不是有缺口的 Lean 声明；不得用占位证明加入源码。
共同上下文：`N d n : ℕ`，`m : ParticleMasses N`，`v : ParticleVectors N d`；`μ : CoordinateMasses n`，`w : Velocity n`；`e := particleCoordinateEquiv N d`。

| ID / 建议名字 | Lean 结论类型 | 假设与教材关系 |
| --- | --- | --- |
| T1-I1 `flattenParticleVectors_apply` | `∀ i a, flattenParticleVectors v (e (i,a)) = v i a` | 无质量/维数正性；索引语义桥接 |
| T1-I2 `unflatten_flatten`、`flatten_unflatten` | `unflattenParticleVectors (flattenParticleVectors v) = v`；对 `w' : Velocity (N*d)`，`flattenParticleVectors (unflattenParticleVectors w') = w'` | 对所有 `N,d`；有限索引互逆，不是轨道定理 |
| T1-M1 `coordinateMassesOfParticles_apply` | `∀ i a, coordinateMassesOfParticles (d := d) m (e (i,a)) = m i` | 确认重复方案，与三维质量排列对应 |
| T1-M2 `coordinateMassesOfParticles_pos` | `∀ k, 0 < coordinateMassesOfParticles (d := d) m k` | 假设 `hm : ∀ i, 0<m i`；对所有 `N,d` 可作单向结论 |
| T1-M3 `coordinateMassesOfParticles_pos_iff` | `(∀ k, 0 < coordinateMassesOfParticles (d := d) m k) ↔ (∀ i, 0<m i)` | **需要 `hd : 0<d`**；从坐标恢复每粒子质量需要至少一个方向 |
| T1-E1 `nBodyKineticEnergy_particle_eq` | `nBodyKineticEnergy (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v) = particleKineticEnergy m v` | 对所有实质量成立；无须正质量。它证明 (1.4) 的两种表达一致 |
| T1-P1 `diagonalMassMatrix_posDef_iff` | `(diagonalMassMatrix μ).PosDef ↔ ∀ i, 0<μ i` | 通用坐标质量，无须限制为粒子展开 |
| T1-P2 `diagonalMassMatrix_isUnit` | `IsUnit (diagonalMassMatrix μ)` | 假设 `hμ : ∀ i, 0<μ i`；库所需的矩阵可逆性命题 |
| T1-P3 `diagonalMassMatrix_mul_inv`、`inv_mul` | `diagonalMassMatrix μ * (diagonalMassMatrix μ)⁻¹ = 1`；`(diagonalMassMatrix μ)⁻¹ * diagonalMassMatrix μ = 1` | 同一严格正质量假设；明确给出两侧逆关系，而非仅写一个名词“可逆” |
| T1-P4 `diagonalMassMatrix_inv_eq` | `(diagonalMassMatrix μ)⁻¹ = Matrix.diagonal (fun i => (μ i)⁻¹)` | 同一严格正质量假设；为 T2/T3 的坐标除法作准备 |
| T1-P5 `diagonalMassMatrix_inv_mulVec` | `∀ i, ((diagonalMassMatrix μ)⁻¹).mulVec ((diagonalMassMatrix μ).mulVec w) i = w i` | 同一严格正质量假设；逐坐标写清普通函数与欧氏向量的接口 |

T1-P1 与 T1-M2 合成粒子模型质量矩阵正定；T1-P2–P5 随之适用。合成时保留输入 `hm`，不能用“质量矩阵正定”替代需从粒子质量证明的桥接目标。

T1-E1 可以推出已有总能量的一致表达：对任意 `U : PotentialEnergy (N*d)`、粒子位置 `q`，

```lean
nBodyTotalEnergy (coordinateMassesOfParticles (d := d) m) U
    (flattenParticleVectors q) (flattenParticleVectors v)
  = particleKineticEnergy m v + U (flattenParticleVectors q)
```

这里在粒子坐标中的势能就是 `U ∘ flattenParticleVectors`；不另给一份无关的粒子势能后假装两式一致。这是定义展开的结果，不含能量沿时间不变的结论。

后续可选辅助项（由网站先评估是否应随 T1 实现，不在本轮实现）：
`(nBodyKineticEnergy μ w = 0 ↔ w = 0)`，假设 `hμ : ∀ i, 0<μ i`；它比已完成非负性强。统一范数下界、Hamiltonian、轨道、ODE 和稳定性仍按后续任务另做。

## 5. 假设、退化情形和定义域

- 核心代数桥接允许 `N=0`、`d=0`，没有自动宣称这是实际物理系统。空索引质量正性是空量词，零维矩阵正定与可逆是库中的代数约定。
- `d=0,N>0` 时没有坐标，坐标正性不能推出粒子正性：例如一个质量为零的粒子仍产生空坐标族。因此 T1-M3 要显式要求 `0<d`；不以空量词给物理质量正性背书。
- 物理应用通常为 `0<N` 且 `d=1` 或 `d=3`，这些条件应在应用处写明，不给每个纯代数引理不必要地加上它们。
- 严格正质量是物理模型条件和正定/逆矩阵结论的充分条件。本页给出质量排列，但未在显示公式 (1.3)/(1.4) 上逐项写 `m_j>0`；不能称本批正定性是原页已有编号定理。
- 对角质量在本批是常数；不引入时间或位置相关质量矩阵。T1 不需要势能可微、碰撞排除域或 ODE 初值条件；这些条件在 T2–T4 的具体结果里审阅。
- 质量非零足够可逆，但不足够正定；质量非负足够动能非负，但不足够可逆。不同结论的假设不合并为含糊的“质量良好”。

## 6. 固定版本依赖与路线

固定 Lean `v4.34.0`，commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`；mathlib `v4.34.0`、实际 checkout 与 manifest 都为 `5ed2965256430c3649e86755f9576b54eca72435`。
本轮 API 检查的精确命令、输出与范围见 `T1_API_CHECK.zh-CN.md`；API 存在/类型通过不等于上述新结论已证明。

| 路线 | 固定库候选依赖 | 需要网站确认的局部接口 |
| --- | --- | --- |
| T1-I1/I2/M1 | `finProdFinEquiv`、等价的左右互逆；`WithLp.toLp` | 以粒子优先排列展开；不要换成空间方向优先 |
| T1-M2/M3 | 上述索引桥接；`Fin d` 在 `0<d` 时可选择一个元素 | 特别保留 M3 的方向非空前提 |
| T1-E1 | `EuclideanSpace.real_norm_sq_eq`、`Equiv.sum_comp`、`Fintype.sum_prod_type`、有限和分配律 | 先换索引再按粒子归并；不添加质量正性 |
| T1-P1/P2 | `Matrix.posDef_diagonal_iff`、`Matrix.PosDef.isUnit` | 在 `Fin n`、`ℝ` 上实例化，显式展开项目包装定义 |
| T1-P3 | `Matrix.isUnit_iff_isUnit_det`、`Matrix.mul_nonsing_inv`、`Matrix.nonsing_inv_mul` | 后两者输入是 **`IsUnit M.det`**，不是直接 `M.PosDef` 或 `IsUnit M` |
| T1-P4/P5 | `Matrix.inv_diagonal`、`Matrix.mulVec_diagonal`、`Matrix.mulVec_mulVec` | `inv_diagonal` 用整条对角函数的 `Ring.inverse`；要在可逆性下桥接到逐坐标倒数，或先构造两侧逆再用唯一性 |

不能把 `Matrix.inv_diagonal` 的右边无条件读成逐项普通倒数。对角元有一个为零时，mathlib 的奇异矩阵逆返回零矩阵；例如 `diag(0,1)` 的逆不等于 `diag(0,1)`。正质量保证可逆之后才能证明 T1-P4 所写的逐项表达。这一版本接口差异应在网站报告中说明。

`Matrix.toEuclideanLin` 的实际结果是欧氏空间上的**线性映射**，不是直接给出的连续线性映射；如后续求导需要连续线性版本，还须利用有限维连续性并核对包装接口。P5 已用逐坐标等式避免把普通函数空间的范数当作欧氏范数。不在本批宣称新的线性等距结构已建好。

## 7. 两类验收状态

1. **陈述语义**：本地已逐项核对原页的 N/N_c/N_d、粒子编号、质量排列和 (1.4)；本文件列明推广与附加假设。MathCopilot 独立陈述/依赖报告及负责人对待实现陈述的复核尚未完成。
2. **Lean 验证**：本轮只检查现有 API 和候选表达式的类型，不修改正式 Lean 源码；T1 新桥接证明均未完成。后续实现仍须固定版本完整导入闭包、`lake build`、`scripts/check.ps1` 与关键定理公理依赖检查。

本轮完成的是可审阅的准备规格。下一步由用户把初始指令和输入文件交给 MathCopilot，导回报告后逐项核对并确定实现顺序。
