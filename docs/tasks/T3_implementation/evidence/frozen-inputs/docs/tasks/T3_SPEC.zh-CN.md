# T3 准备规格：固定对角质量的具体 Hamiltonian 一致性

日期：2026-10-02（Asia/Shanghai）。**本轮为本地准备；七个候选定义、七项规格 ID 对应的九个目标类型已在固定版本独立探针通过，不表示目标已经证明。** 原页审计、API 小型适配另有证据。MathCopilot 独立审阅、负责人语义签核及正式库集成均待完成。

例如单坐标 `m=2,v=3,p=6,U(q)=7`：速度动能为9，动量动能也为9，总能量与具体Hamiltonian均为16。本批整理这种一致性的准确一般命题，以及静态 Hamilton 向量场的偏梯度；真实时间轨道的解等价留待 T2。

## 1. 固定输入与教材原页

- 源码基准：分支 `chapter01-kinetic-energy-nonneg`，HEAD `121a9d02ad15500c630e505b363d5f04106d617f`；实际 Lean4.34.0，mathlib `5ed2965256430c3649e86755f9576b54eca72435`。版本不升级。
- 教材：461页，SHA256 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。
- 本轮渲染并视觉核对印刷18-19/PDF41-42、22-26/PDF45-49七页。主代理另重看核心印刷24/PDF47及25/PDF48。
- `../tmp/t3-preparation-20261002/source-audit/SOURCE_AUDIT.zh-CN.md` 记录提取、140 DPI渲染、实际视觉审阅和哈希；不是仅据文本提取声称看过公式。

| 印刷页 / 从1起PDF页 | 原页支持的内容 | 本批采用/边界 |
| --- | --- | --- |
| 18-19 / 41-42 | 粒子/坐标质量、Newton点态方程、速度动能与总能量 | 复用正式NBody/ParticleCoordinates；时间导数与守恒不由静态等式自动得出 |
| 22-23 / 45-46 | Lagrangian、广义坐标及位置相关质量M(q)背景 | 用于区分模型；不引入变质量或约束坐标 |
| 24 / 47 | p=M(q)q̇、H=pᵀM(q)⁻¹p/2+U、Hamilton偏导形式；常M时q̇=M⁻¹p、ṗ=-∂U/∂q | 只选择固定正对角质量模型；不把一般Legendre上确界证明纳入本批 |
| 25 / 48 | 常数正定M⁻¹、有限能量相空间及局部/全局讨论 | 正质量是本批物理模型条件；不从能量有界直接推全局存在 |
| 26 / 49 | 有界位置/动量及最大解延拓的后续语境 | 不进入T3静态目标 |

教材印刷24/PDF47的上确界讨论处于凸性背景。只有可逆性不足以保证极大值：m=-1,p=0时相应表达随v²/2无界。本批不形式化一般Legendre对偶，准确区分所采用物理正质量与纯代数最小假设。

## 2. 定义、质量与配置域

`n : ℕ` 是配置坐标数；无约束N粒子d维时 `n=N*d`。不强加n>0、N>0或d>0来证明本批代数/切片目标；物理模型可另外登记，不能把边界遗漏。`Position/Velocity/Momentum n` 已是同一有限维欧氏类型的透明别名，物理含义仍分别保留。粒子展开沿T1既有粒子优先排列。

以 `m : CoordinateMasses n`、`M=diagonalMassMatrix m` 为固定实质量。

- `massOperator` 与 `velocityOperator` 按T2候选写法将M/M⁻¹包装为连续线性作用；本批只验证兼容写法，正式实现应复用T2最终名称，避免重复定义。
- `coordinateVelocity m p` 的第i坐标是pᵢ/mᵢ，与整个矩阵非奇异逆不可无条件混同。
- `momentumKineticEnergy m p = Σ pᵢ²/(2mᵢ)` 是首选总函数定义，具体 `massSeparableEnergy` 接入已有抽象 `SeparableEnergy`，`massHamiltonian` 是其Hamiltonian。
- `hamiltonianVectorField` 使用固定q或p的两个欧氏切片梯度，返回现有 `PhaseSpace n`。不把普通乘积范数静默换成ℓ²范数，也不假定 `InnerProductSpace ℝ (PhaseSpace n)`，不直接定义整个乘积空间的gradient H。

以下是本轮独立探针中实际通过的候选定义；只有临时目录中的准备代码，不在正式库新增定义：

```lean
import Mathlib
import MolecularDynamicsFormalization

open MolecularDynamics
open scoped InnerProductSpace
set_option synthInstance.maxHeartbeats 2000

namespace T3Preparation

-- Explicit instances follow the fixed library, as in the T2 preparation.
local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def massOperator {n : ℕ} (m : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)).toContinuousLinearMap

noncomputable def velocityOperator {n : ℕ} (m : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix m)⁻¹).toContinuousLinearMap

noncomputable def coordinateVelocity {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : Velocity n := WithLp.toLp 2 (fun i => p i / m i)

-- Total division is a formal convention; positive mass is the physical scope.
noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)

noncomputable def massSeparableEnergy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : SeparableEnergy n :=
  ⟨momentumKineticEnergy m, U⟩

noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n :=
  (massSeparableEnergy m U).hamiltonian

-- Each slice lives in the existing EuclideanSpace. The product is not silently
-- assigned a different norm or an unestablished inner product structure.
noncomputable def hamiltonianVectorField {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) : PhaseSpace n :=
  (gradient (fun p => massHamiltonian m U (z.1, p)) z.2,
    -gradient (fun q => massHamiltonian m U (q, z.2)) z.1)

end T3Preparation
```

Lean实数采用总除法，0⁻¹=0。因此逐坐标K允许任意实m，但“可定义”不表示零/负质量是本批物理模型。

| 结果 | 最小/本批假设 | 解释 |
| --- | --- | --- |
| K(Mv)=速度动能、H(q,Mv)=现有总能量、粒子桥接 | 任意实质量；不需要U可微 | mᵢ=0时该坐标两边贡献均0；不添加多余正质量前提 |
| K(p)=½⟨p,M⁻¹p⟩、matrix gradient桥接、任意p的速度恢复 | 本批∀i,0<mᵢ | 非零质量其实足以代数可逆，但本批直接复用T1正质量逆矩阵结果；不替换成非负质量 |
| HasGradientAt K 的坐标p/m形式 | 任意实质量 | m固定，系数是实数常数；零质量系数为0仍是二次多项式 |
| gradient位置切片=gradient U | 无需可微性，作为总函数等式 | 只使用加常数的总fderiv恒等式；不能代替真实导数证据 |
| 位置切片HasGradientAt、真实F=-∇U解释 | U在q可微，或直接HasGradientAt U g q | 势能正则性须显式提供，不将目标梯度公式塞进假设 |

`U : Position n → ℝ` 沿既有正式类型保持总函数；物理配置域另记 `Q : Set (Position n)`。代数目标对任意q成立。若只在Q内有 `DifferentiableOn ℝ U Q`，在q∈Q用普通双侧gradient解释时须Q开放（或明确Q∈𝓝q）以转成 `DifferentiableAt`。碰撞排除域、U在Q外的任意延伸不自动给全局可微性。当前规格不引入时间区间；日后沿轨道证明必须接入T2的区间/导数/域条件。

## 3. 七项规格与九个完整Lean目标类型

| ID | 目标 | 已落地的T1/库依赖 | 实施依赖和状态 |
| --- | --- | --- | --- |
| T3-K1 | 动量动能的矩阵内积表达 | diagonalMassMatrix_inv_eq、欧氏内积有限和 | 正质量；未证明 |
| T3-E1 | H(q,Mv)=nBodyTotalEnergy(m,U,q,v) | mass作用坐标、已有速度动能定义 | 任意实质量；标量适配已验证，一般目标未证明 |
| T3-P1 | 粒子状态H与粒子动能+原U展开一致 | nBodyKineticEnergy_particle_eq、flatten质量排列 | E1；不需反向正性桥接的d>0；未证明 |
| T3-G1 | K的真实坐标梯度，以及正质量下矩阵梯度形式 | 坐标CLM、平方/有限和导数、toDual与HasGradientAt | 两个目标；一般n梯度未证明，关键适配已验证 |
| T3-G2 | 位置切片总gradient等式，以及可微U下真实梯度 | fderiv_const_add、DifferentiableAt.hasGradientAt | 两个目标；总gradient规则不需可微，但真实语义需可微证据 |
| T3-V1 | 静态Hamilton向量场=(M⁻¹p,-gradient U q) | G1、G2及矩阵作用包装 | 总函数静态等式不需要U可微；物理Hamilton方程语义另登记可微性；不是沿轨道解等价 |
| T3-R1 | H(q,p)=现有总能量(q,M⁻¹p) | T1质量逆与两侧逆、E1 | 正质量；未证明 |

下面的 `def ...Goal : Prop` 只是完整待证类型，不是项目定理、公理、假设或占位证明。实际 `Probe03_TargetTypes.lean` 已退出0，记录20.406秒；源/输出哈希见API报告。

```lean
namespace T3Preparation

-- Proposition-valued descriptions only: no proof placeholders or target
-- conclusions disguised as premises.
def matrixKineticGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) →
    momentumKineticEnergy m p = inner ℝ p (velocityOperator m p) / 2

def velocityEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : Prop :=
  massHamiltonian m U (q, massOperator m v) = nBodyTotalEnergy m U q v

def particleEnergyGoal {N d : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N*d)) (q v : ParticleVectors N d) : Prop :=
  massHamiltonian (coordinateMassesOfParticles (d := d) m) U
      (flattenParticleVectors q,
        massOperator (coordinateMassesOfParticles (d := d) m) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q)

def coordinateGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p

def matrixGradientGoal {n : ℕ} (m : CoordinateMasses n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) → gradient (momentumKineticEnergy m) p = velocityOperator m p

def positionGradientGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  DifferentiableAt ℝ U q →
    HasGradientAt (fun x => massHamiltonian m U (x, p)) (gradient U q) q

def positionTotalGradientGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  gradient (fun x => massHamiltonian m U (x, p)) q = gradient U q

def vectorFieldGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z : PhaseSpace n) : Prop :=
  (∀ i, 0 < m i) →
    hamiltonianVectorField m U z = (velocityOperator m z.2, -gradient U z.1)

def inverseEnergyGoal {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : Prop :=
  (∀ i, 0 < m i) →
    massHamiltonian m U (q, p) = nBodyTotalEnergy m U q (velocityOperator m p)

#print matrixKineticGoal
#print velocityEnergyGoal
#print particleEnergyGoal
#print coordinateGradientGoal
#print matrixGradientGoal
#print positionGradientGoal
#print positionTotalGradientGoal
#print vectorFieldGoal
#print inverseEnergyGoal

end T3Preparation
```

完整命题量词由{n : ℕ}等参数及显式参数给出；质量条件只出现在需要的位置。没有把能量/梯度/向量场目标预置进前提。

## 4. 样例、反例与具体检查

- 单坐标m=2,v=3,p=6：速度/动量动能都为9。给U(q)=7则两种总能量都是16；本轮标量等式用norm_num验证。
- n=0：有限和为空，K=0；H=U(q)。无需因空维数给目标增加n>0。本轮独立空和例子验证K=0。
- 混合零质量m=(0,2),p=(0,4)：坐标K=4、coordinateVelocity第2坐标为2；M奇异，Lean整个矩阵逆为0，故½⟨p,M⁻¹p⟩=0。这说明矩阵桥接缺少可逆假设会错；独立探针验证了这一反例及所用矩阵逆事实的公理依赖。
- 在同一零质量模型用p=(1,4)，任何v都不能满足p=Mv的第1坐标；不能凭坐标总除法假称能恢复任意p。
- 负质量可以保留纯代数桥接，却不能推物理动能非负、凸Legendre极值或稳定性。
- N=0或d=0可用空维数类型处理；反向粒子质量正性另需d>0，P1不使用那条反向结论。

一般目标类型通过不等于目标证明通过；小型样例/适配不替代一般证明。数值和零质量反例的实际成功证据以API报告中的退出0探针为准。

## 5. 顺序、依赖与后续验收

建议先K1/E1→P1/R1，再完成G1坐标梯度→正质量矩阵桥接，接G2→V1。实施前核对T1独立审阅有无影响质量/坐标/inverse依赖，并与T2确定共享mass/velocityOperator最终名称。T3静态准备及能量代数不依赖真实时间轨道，但不在本轮推进正式实现。

MathCopilot下一阶段目标是逐ID审阅本规格、假设/定义域、已核实API及未证明缺口，返回独立报告；输入必须明确提供本轮尚未提交的T3文档/探针，不能只给HEAD就声称网站已读本地材料。网站任务发送仍待后续明确安排，原T1/T2由原对话协调。

尚未完成：七项一般目标的正式完整证明、粒子/多维完整样例集、真实轨道Hamilton/Newton双向解等价、沿解能量守恒(T4)、局部存在唯一性/延拓/全局流、一般非对角/变质量/约束模型、一般Legendre变换。没有正式Lean修改、全工程新构建或CI查询；MathCopilot独立审阅与负责人语义签核待完成。
