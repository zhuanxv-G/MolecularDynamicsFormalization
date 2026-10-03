# T3 固定版本 API 与候选类型检查

状态：本轮最终采用7份独立探针退出0。它们验证候选定义/目标类型、实际API完整声明及小型适配；没有完成T3七项规格的正式完整证明。退出0包含非错误提示，具体列在原始日志。

## 1. 输入、运行与证据

- 分支 `chapter01-kinetic-energy-nonneg`，源码HEAD `121a9d02ad15500c630e505b363d5f04106d617f`；实际 `Lean (version 4.34.0, x86_64-w64-windows-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)`；mathlib checkout `5ed2965256430c3649e86755f9576b54eca72435`，不更新依赖。
- 临时源/log/result在工作区 `tmp/t3-preparation-20261002/`，cwd为正式工程。精确Lean命令由每份result.json记录：已安装固定bin/lake.exe env lean <独立探针绝对路径>。
- Python运行器：bundled Python的 `python.exe -X utf8 ../tmp/t3-preparation-20261002/run_probe.py <相对探针路径>`。它不改共享Scratch，子进程PATH只前置已安装固定bin。
- `PROBE_AUDIT.json` 重核全部已运行源/输出哈希、命令、时间、状态与是否最终采用；未运行旧草稿只保留文件，不算尝试通过。
- 根坐标探针打印11个声明；导数代理打印5组37个声明。声明/接口计数不是教材定理或正式证明数量。

| 探针 | 实际秒数 | 保存的Lean/超时退出码 | 是否最终采用 | warning行数 |
| --- | --- | --- | --- | --- |
| api-derivative/Probe01_API | 314.766 | 124 | 历史尝试 | 0 |
| api-derivative/Probe02_SlicesAndScalar | 228.859 | 124 | 历史尝试 | 2 |
| Probe01_CoordinateAPI | 197.032 | 124 | 历史尝试 | 2 |
| api-derivative/Probe01b_API | 16.266 | 1 | 历史尝试 | 0 |
| Probe01b_CoordinateAPI | 20.782 | 0 | 最终采用 | 1 |
| api-derivative/Probe01c_API | 12.047 | 0 | 最终采用 | 0 |
| Probe02_BoundaryAdapters | 20.546 | 1 | 历史尝试 | 0 |
| api-derivative/Probe02b_SlicesAndScalar | 12.469 | 0 | 最终采用 | 4 |
| api-derivative/Probe03b_CoordinateAndProduct | 12.781 | 0 | 最终采用 | 4 |
| api-derivative/Probe04_DualRepresentation | 12.375 | 0 | 历史尝试 | 3 |
| Probe03_TargetTypes | 20.406 | 0 | 最终采用 | 0 |
| Probe02b_BoundaryAdapters | 20.546 | 0 | 最终采用 | 0 |
| api-derivative/Probe04b_DualRepresentationAxioms | 12.234 | 0 | 最终采用 | 0 |

根Probe01首次180秒超时，保存实际197.032秒/124，前版Python输出另有GBK编码异常，因此终端运行器退出1不能解释为Lean正常退出1。导数全库首次两次超时也保留，其314.766/228.859秒不是180秒门限按时结束；旧Windows subprocess仅处理Lake父进程，继承输出管道的Lean子进程可继续阻塞。后来运行器改为stdout直接写日志、timeout时对已知PID清理进程树，并设UTF8输出。新成功文件的runner hash单列；旧版本不可追溯时不伪填。

导数窄导入01b只缺 `Deriv.Mul` 引入的 `HasDerivAt.div_const`，新01c通过；根Boundary首版错误为把 `Finset.sum_empty` 当函数多传参数，新02b通过。根API首版未限制合成搜索，成功版将 `synthInstance.maxHeartbeats` 设2000，导数版改用实际所需窄imports；未测量导入、搜索和并发开销各自占比，不把恢复后的成功当根因已完整诊断。

最终根01b有1条letI文风提示，导数02b/03b有文风及弃用声明提示；对应通过而非无警告。根TargetTypes、Boundary最终版及04b公理探针无错误/警告。失败的源/日志/JSON未覆盖。

## 2. 坐标/矩阵接口和实际用途

| 声明 | 本地模块 | 已验证适配/边界 |
| --- | --- | --- |
| Matrix.toEuclideanLin / LinearMap.toContinuousLinearMap | Analysis.InnerProductSpace.PiL2 / Topology.Algebra.Module.FiniteDimension | 将M/M⁻¹包装到现有欧氏类型；源端有限维等要求见完整类型 |
| Matrix.mulVec_diagonal | Data.Matrix.Mul | massOperator第i坐标=mᵢvᵢ；正质量下velocityOperator第i坐标=pᵢ/mᵢ |
| PiLp.inner_apply / EuclideanSpace.real_norm_sq_eq | Analysis.InnerProductSpace.PiL2 | 矩阵内积表示化为有限和；不能默认普通Prod就是内积空间 |
| MolecularDynamics.diagonalMassMatrix_inv_eq / diagonalMassMatrix_inv_mulVec | Chapter01.ParticleCoordinates | 复用T1正质量逆矩阵；一般H能量命题仍未证明 |
| MolecularDynamics.nBodyKineticEnergy_particle_eq | Chapter01.ParticleCoordinates | P1粒子/坐标桥接；现有证明真实前提无正质量 |
| Matrix.nonsing_inv_apply_not_isUnit / Matrix.det_diagonal | LinearAlgebra.Matrix.NonsingularInverse / LinearAlgebra.Matrix.Determinant.Basic | 混合零质量反例M⁻¹=0；配套坐标K=4与矩阵K=0已编译 |
| MolecularDynamics.SeparableEnergy.hamiltonian | BasicDefinitions | 候选具体K+U接入已有抽象能量，定义展开已通过 |

根坐标适配5个example；Boundary包括命名奇异逆小引理、坐标K/速度/矩阵K反例和n=0空和4个example。它们不是一般T3目标的完整证明。命名 `T3BoundaryAdapters.mixedMass_inv_zero` 的公理仅 propext/Classical.choice/Quot.sound。

以下为实际根API完整输出（只去除文档行尾空白，原始日志按字节保留；首段文风提示亦保留）：

```text
C:\Users\ustc\Desktop\formal math\tmp\t3-preparation-20261002\Probe01b_CoordinateAPI.lean:12:2: warning: Try this:
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
Matrix.toEuclideanLin.{u_3, u_7, u_8} {𝕜 : Type u_3} [RCLike 𝕜] {m : Type u_7} {n : Type u_8} [Fintype n]
  [DecidableEq n] : Matrix m n 𝕜 ≃ₗ[𝕜] EuclideanSpace 𝕜 n →ₗ[𝕜] EuclideanSpace 𝕜 m
LinearMap.toContinuousLinearMap.{u, v, x} {𝕜 : Type u} [hnorm : NontriviallyNormedField 𝕜] {E : Type v} [AddCommGroup E]
  [Module 𝕜 E] [TopologicalSpace E] [IsTopologicalAddGroup E] [ContinuousSMul 𝕜 E] {F' : Type x} [AddCommGroup F']
  [Module 𝕜 F'] [TopologicalSpace F'] [IsTopologicalAddGroup F'] [ContinuousSMul 𝕜 F'] [CompleteSpace 𝕜] [T2Space E]
  [FiniteDimensional 𝕜 E] : (E →ₗ[𝕜] F') ≃ₗ[𝕜] E →L[𝕜] F'
Matrix.mulVec_diagonal.{v, u_2} {m : Type u_2} {α : Type v} [NonUnitalNonAssocSemiring α] [Fintype m] [DecidableEq m]
  (v w : m → α) (x : m) : (Matrix.diagonal v).mulVec w x = v x * w x
PiLp.inner_apply.{u_3, u_7, u_8} {𝕜 : Type u_3} [RCLike 𝕜] {ι : Type u_7} [Fintype ι] {f : ι → Type u_8}
  [(i : ι) → NormedAddCommGroup (f i)] [(i : ι) → InnerProductSpace 𝕜 (f i)] (x y : PiLp 2 f) :
  ⟪x, y⟫_𝕜 = ∑ i, ⟪x.ofLp i, y.ofLp i⟫_𝕜
MolecularDynamics.diagonalMassMatrix_inv_eq {n : ℕ} (m : CoordinateMasses n) (hm : ∀ (i : Fin n), 0 < m i) :
  (diagonalMassMatrix m)⁻¹ = Matrix.diagonal fun i => (m i)⁻¹
MolecularDynamics.diagonalMassMatrix_inv_mulVec {n : ℕ} (m : CoordinateMasses n) (hm : ∀ (i : Fin n), 0 < m i)
  (w : Velocity n) (i : Fin n) :
  Matrix.mulVec (diagonalMassMatrix m)⁻¹ (Matrix.mulVec (diagonalMassMatrix m) w.ofLp) i = w.ofLp i
MolecularDynamics.nBodyKineticEnergy_particle_eq {N d : ℕ} (m : ParticleMasses N) (v : ParticleVectors N d) :
  nBodyKineticEnergy (coordinateMassesOfParticles m) (flattenParticleVectors v) = particleKineticEnergy m v
EuclideanSpace.real_norm_sq_eq.{u_7} {n : Type u_7} [Fintype n] (x : EuclideanSpace ℝ n) : ‖x‖ ^ 2 = ∑ i, x.ofLp i ^ 2
MolecularDynamics.SeparableEnergy.hamiltonian {n : ℕ} (energy : SeparableEnergy n) : Hamiltonian n
Matrix.nonsing_inv_apply_not_isUnit.{u', v} {n : Type u'} {α : Type v} [Fintype n] [DecidableEq n] [CommRing α]
  (A : Matrix n n α) (h : ¬IsUnit A.det) : A⁻¹ = 0
Matrix.det_diagonal.{v, u_2} {n : Type u_2} [DecidableEq n] [Fintype n] {R : Type v} [CommRing R] {d : n → R} :
  (Matrix.diagonal d).det = ∏ i, d i
```

## 3. 候选定义与九个目标的实际类型

CandidateDefs.lean定义7个候选，其中massOperator/velocityOperator与T2候选兼容；T3_SPEC代码和Probe03通过源码按字节片段核对。九个Prop目标对应七个规格ID，仅登记待证命题。实际完整打印：

```text
def T3Preparation.matrixKineticGoal : {n : ℕ} → CoordinateMasses n → Momentum n → Prop :=
fun {n} m p => (∀ (i : Fin n), 0 < m i) → momentumKineticEnergy m p = ⟪p, (velocityOperator m) p⟫_ℝ / 2
def T3Preparation.velocityEnergyGoal : {n : ℕ} →
  CoordinateMasses n → PotentialEnergy n → Position n → Velocity n → Prop :=
fun {n} m U q v => massHamiltonian m U (q, (massOperator m) v) = nBodyTotalEnergy m U q v
def T3Preparation.particleEnergyGoal : {N d : ℕ} →
  ParticleMasses N → PotentialEnergy (N * d) → ParticleVectors N d → ParticleVectors N d → Prop :=
fun {N d} m U q v =>
  massHamiltonian (coordinateMassesOfParticles m) U
      (flattenParticleVectors q, (massOperator (coordinateMassesOfParticles m)) (flattenParticleVectors v)) =
    particleKineticEnergy m v + U (flattenParticleVectors q)
def T3Preparation.coordinateGradientGoal : {n : ℕ} → CoordinateMasses n → Momentum n → Prop :=
fun {n} m p => HasGradientAt (momentumKineticEnergy m) (coordinateVelocity m p) p
def T3Preparation.matrixGradientGoal : {n : ℕ} → CoordinateMasses n → Momentum n → Prop :=
fun {n} m p => (∀ (i : Fin n), 0 < m i) → gradient (momentumKineticEnergy m) p = (velocityOperator m) p
def T3Preparation.positionGradientGoal : {n : ℕ} →
  CoordinateMasses n → PotentialEnergy n → Position n → Momentum n → Prop :=
fun {n} m U q p => DifferentiableAt ℝ U q → HasGradientAt (fun x => massHamiltonian m U (x, p)) (gradient U q) q
def T3Preparation.positionTotalGradientGoal : {n : ℕ} →
  CoordinateMasses n → PotentialEnergy n → Position n → Momentum n → Prop :=
fun {n} m U q p => gradient (fun x => massHamiltonian m U (x, p)) q = gradient U q
def T3Preparation.vectorFieldGoal : {n : ℕ} → CoordinateMasses n → PotentialEnergy n → PhaseSpace n → Prop :=
fun {n} m U z => (∀ (i : Fin n), 0 < m i) → hamiltonianVectorField m U z = ((velocityOperator m) z.2, -gradient U z.1)
def T3Preparation.inverseEnergyGoal : {n : ℕ} →
  CoordinateMasses n → PotentialEnergy n → Position n → Momentum n → Prop :=
fun {n} m U q p =>
  (∀ (i : Fin n), 0 < m i) → massHamiltonian m U (q, p) = nBodyTotalEnergy m U q ((velocityOperator m) p)
```

## 4. 导数分工的完整报告与类型附录

以下合并已完成的独立导数报告，完整实际类型和适配源码/输出SHA在其中；原文件及API_DERIVATIVE_INPUTS.json也保持不变。没有把候选完整梯度链标为证明通过。

# T3 导数与梯度 API 准备报告

本分工只修改 `../tmp/t3-preparation-20261002/api-derivative/`，没有改正式 Lean、Scratch、handoff、固定版本或 Git。固定 Lean4.34.0；mathlib5ed2965256430c3649e86755f9576b54eca72435。

## 已验证与适用边界

- `Probe01c_API` 实际退出0，打印5组声明的完整类型（完整原始输出见附录；所有宇宙和类型类要求均保留）。
- `Probe02b_SlicesAndScalar` 实际退出0：2个候选定义、5个完整小例子。包括 q/p 两个切片梯度的**无条件等式**，带真实 `HasGradientAt U g q` 的位置切片梯度证据，以及质量2时 `p²/4` 的实导数/gradient。
- `Probe03b_CoordinateAndProduct` 实际退出0：4个完整小例子。欧氏坐标平方的 Frechet 导数、有限求和、通过 `fst/snd` 合成普通乘积空间上 H 的 Frechet 导数、从 `toDual g` 导数恢复实际 gradient。
- `Probe04b_DualRepresentationAxioms` 实际退出0、无警告：命名完整小型引理`T3DerivativePreparation.coordinateDualRepresentation`证明坐标 CLM 有限和等于 `toDual g`，另有任意实质量（含0）下 `(2*p)*(2*m)⁻¹ = p/m` 的完整小例子。`#print axioms`实查仅`propext, Classical.choice, Quot.sound`；完整原始输出已保留。此前04初稿也实际退出0，但有3条未用simp/tactic提示；04b保留旧证据并修正这些文风提示。
- 通过文件含文风/弃用名/未用 tactic 提示，详见原始日志；“退出0”不意味着“无警告”。原始证据没有覆盖或删改。所有成功文件已重核源码/输出SHA，并扫描无占位、新公理或unsafe。

**未验证**：T3 动量动能任意 n 的完整 Frechet/gradient 目标；与质量矩阵逆CLM的一致性；正式源码集成后的全工程构建和公理审计；Hamilton/Newton 真实时间轨道等价；MathCopilot独立审阅与负责人教材语义签核。下面是经过局部适配支撑的证明路线，不能计作上述完整目标已证明。

窄导入探针引入 `MolecularDynamics.BasicDefinitions`（并间接使用正式 `Notation`），将质量参数写成底层 `Fin n → ℝ`，与正式 `CoordinateMasses n` 的 abbrev 定义一致。正式 NBody 导入全 Mathlib，因此本次为避免全库载入超时没有让窄导入探针导入 NBody/工程顶层；后续正式集成必须重新验收。

## 五组接口与精确模块

|组|已检查的关键声明|声明所在模块|
|---|---|---|
|D1 梯度/导数|`hasGradientAt_iff_hasFDerivAt`, `hasFDerivAt_iff_hasGradientAt`, `HasGradientAt.hasFDerivAt`, `HasFDerivAt.hasGradientAt`, `HasGradientAt.gradient`, `HasGradientAt.unique`, `DifferentiableAt.hasGradientAt`, `toDual_gradient`|`Mathlib.Analysis.Calculus.Gradient.Basic`|
|D1 Riesz|`InnerProductSpace.toDual_apply_apply`|`Mathlib.Analysis.InnerProductSpace.Dual`|
|D2 欧氏坐标|`EuclideanSpace.proj`, `EuclideanSpace.coe_proj`, `EuclideanSpace.inner_eq_star_dotProduct`|`Mathlib.Analysis.InnerProductSpace.PiL2`|
|D2 WithLp/CLM|`PiLp.hasFDerivAt_apply`; `ContinuousLinearMap.hasFDerivAt`|`Mathlib.Analysis.Calculus.FDeriv.WithLp`; `Mathlib.Analysis.Calculus.FDeriv.Linear`|
|D3 构造|`HasFDerivAt.prodMk`, `HasFDerivAt.comp`, `hasFDerivAt_const`, `HasFDerivAt.mul`, `HasFDerivAt.const_smul`, `HasFDerivAt.add`, `HasFDerivAt.fun_sum`, `HasFDerivAt.sum`|分别 `FDeriv.Prod`, `.Comp`, `.Const`, `.Mul`；const_smul/add/两个有限和都在`Mathlib.Analysis.Calculus.FDeriv.Add`|
|D4 偏导/乘积|`fderiv_fst`, `fderiv_snd`, `HasFDerivAt.fst`, `HasFDerivAt.snd`; `ContinuousLinearMap.inl/inr`|`Mathlib.Analysis.Calculus.FDeriv.Prod`; `Mathlib.Topology.Algebra.Module.ContinuousLinearMap.PiProd`|
|D4 切片|`hasFDerivAt_const_add_iff`, `fderiv_const_add`, `fderiv_add_const`|`Mathlib.Analysis.Calculus.FDeriv.Add`|
|D4 一般偏导合成|`hasStrictFDerivAt_uncurry_coprod`|`Mathlib.Analysis.Calculus.FDeriv.Partial`|
|D5 一维|`HasDerivAt.hasGradientAt'`, `gradient_eq_deriv'`; `HasDerivAt.pow`; `HasDerivAt.div_const`; `HasDerivAt.deriv`|`Gradient.Basic`; `Deriv.Pow`; `Deriv.Mul`; `Deriv.Basic`|

当前配对构造名是 `HasFDerivAt.prodMk`，不是 `HasFDerivAt.prod`。`HasFDerivAt.mul` 的输入域为 normed space，输出为 normed commutative algebra；实标量输出实例满足这些要求。`HasFDerivAt.const_smul` 的完整类型另要求作用兼容和 `ContinuousConstSMul`，不能将其适用条件省略。

`HasFDerivAt.fun_sum` 的实际 finset 形式是 `(h : ∀ i ∈ u, HasFDerivAt (A i) (A' i) x)`；结果为 `HasFDerivAt (fun y => ∑ i ∈ u, A i y) (∑ i ∈ u, A' i) x`。Probe03b将u实例化为`Finset.univ`验证了目标中普通`∑ i`写法。

一般 `hasStrictFDerivAt_uncurry_coprod` 需要两套偏导在邻域存在、两套导数映射在点连续；本次只检查完整类型，没有实例化或证明这些强前提。可分离H无需使用它：直接合成两套CLM导数即可。

## 后续梯度动能可靠路线（完整目标尚未证明）

取 `K m p = ∑ i, (p i)^2/(2*m i)`，候选向量

```lean
WithLp.toLp 2 (fun i => p i / m i) : Momentum n
```

1. 对每个i，`EuclideanSpace.proj (𝕜 := ℝ) i` 是动量欧氏空间的连续线性坐标泛函，`.hasFDerivAt`给坐标导数。Probe03b实际验证平方项导数是`(2*p i) • proj i`。
2. 乘以常数`(2*m i)⁻¹`可用`HasFDerivAt.const_smul`；实值点wise scalar需适配`div_eq_mul_inv`。这一步完整质量加权平方项尚未单独编译，但接口类型已检查。
3. Probe04b实际证明任意实m（含0）下系数`(2*p)*(2*m)⁻¹ = p/m`。零质量分支用实数总除法，不能说这代表合法物理质量；正式物理模型仍记录正质量假设。
4. `HasFDerivAt.fun_sum`合成候选CLM`∑ i, (p i/m i) • proj i`。有限和适配已编译。
5. Probe04b实际证明任意向量g下`∑ i, g i • proj i = InnerProductSpace.toDual ℝ (Momentum n) g`；代入候选向量得到Riesz表示。欧氏内积API的实际坐标次序为`ofLp y ⬝ᵥ star(ofLp x)`，在实数情况下用`mul_comm`整理。
6. `hasGradientAt_iff_hasFDerivAt.mpr`获得`HasGradientAt K g p`，其`.gradient`恢复总函数`gradient K p = g`。桥接小例子已编译；整链目标未编译。

该坐标梯度候选对任意实质量可成立。与T2采用的**非奇异矩阵逆** `velocityOperator m` 桥接时必须加正质量（或另设计足够的非零/可逆假设）；两种倒数定义在奇异质量下不能混同。

## Hamiltonian 切片与普通乘积空间

Probe02b具体H复用现有定义：

```lean
noncomputable def momentumKineticEnergy {n : ℕ} (m : Fin n → ℝ)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)
noncomputable def concreteHamiltonian {n : ℕ} (m : Fin n → ℝ)
    (U : PotentialEnergy n) : Hamiltonian n :=
  SeparableEnergy.hamiltonian ⟨momentumKineticEnergy m, U⟩
```

现有`SeparableEnergy.hamiltonian`求值为K(p)+U(q)。q固定p切片和p固定q切片分别是常数加U、K加常数。展开`gradient`并使用`fderiv_const_add/fderiv_add_const`，**无需质量正性或U可微假设**即可得到两条总gradient等式。Probe02b已编译：

```lean
gradient (fun q' => concreteHamiltonian m U (q', p)) q = gradient U q
gradient (fun p' => concreteHamiltonian m U (q, p')) p =
  gradient (momentumKineticEnergy m) p
```

这是总导数函数的等式，不代表U在q可微。要获得真实一阶展开/物理力语义，用`hU : HasGradientAt U g q`再经`hU.hasFDerivAt.const_add`返回q切片`HasGradientAt`；该适配也已编译。

当前`PhaseSpace n = Position n × Momentum n`是普通Prod，默认乘积范数使用max；`Mathlib.Analysis.InnerProductSpace.ProdL2`的内积实例明确给`WithLp 2 (E × F)`。所以本批采用两个欧氏切片gradient和普通Prod上的full `HasFDerivAt`。未给PhaseSpace重新定义Hilbert实例，未编译声称其全gradient存在的陈述。

Probe03b对任意已证可微K/U实际合成：

```lean
HasFDerivAt (fun z : PhaseSpace n => K z.2 + U z.1)
  (K'.comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n)) +
   U'.comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))) (q,p)
```

真实时间轨道桥接不在本准备范围。

## 失败与未运行文件

1. Probe01_API全Mathlib版本：180s阈值超时，旧runner的继承stdout管道等待子Lean，实际314.766s。源/log/result完整保留，log只有TIMEOUT。20:26:43结束其已确认的孤留Lean10136后返回124；没有把此文件或其声明算通过。
2. Probe02_SlicesAndScalar全Mathlib版本：180s阈值超时，实际228.859s，返回124；捕获到noncomputable定义和一维函数幂简化的错误。q/p切片部分未报错不等于整个文件通过。
3. Probe01b_API窄导入版本：实际16.266s，退出1，唯一声明检查错误为`HasDerivAt.div_const`没有导入`Deriv.Mul`；01c补充该module后整文件成功。
4. 旧runner打印后因GBK不能编码Lean Unicode出现`UnicodeEncodeError`，已有源码、UTF8日志和结果JSON仍保存。root修改runner为UTF8标准输出、直接落日志、有限Popen.wait与超时终止子进程；新成功结果保存runner SHA。
5. Probe03_CoordinateAndProduct为最初全Mathlib草稿，**从未运行**；后续03b有新的独立证据。未运行稿不可列为失败或通过。

首轮超时不是证明结论不成立的证据，实际环境载入慢的根因未确认；全Mathlib多个并行进程映射约14.25GB虚拟地址/单进程仅约296MB工作集，不能据此断言物理内存耗尽。后续串行窄导入各约12秒；不再重复全Mathlib超时方法。

## 命令、退出码、时长与哈希

运行工作目录：`C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization`。
统一命令（每个实际源文件各运行一次）：

```powershell
& 'C:/Users/ustc/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe' '../tmp/t3-preparation-20261002/run_probe.py' 'api-derivative/<实际文件名>.lean'
```

真实底层命令记录于每个`.result.json`：固定toolchain的`lake.exe env lean <绝对源码路径>`。表中exit_code为Lean/runner记录，首轮runner输出Unicode错误的壳层退出1不替代已保存的Lean退出码。

|实际文件|退出码|时长(秒)|源码SHA256|UTF8输出SHA256|
|---|---:|---:|---|---|
|Probe01_API.lean|124|314.766|`ec3bc37a5de7b1f7c26d3c28fad86dbd5e9aa3c516ea6b0e82f7f11288b6b81e`|`f1288d6ba9da90a4597e42b85745f2458e3d2a15cf26d6212bb50fac85e9eae9`|
|Probe01b_API.lean|1|16.266|`fe2c7c4f86e99a26e928d1fc7c6fa8115ba7093b6b87037d7dbdbb7e9aa48c18`|`9d59f9926a895a7a3de9da5c09ded2f9a4c176eed2be0ebd854501061d40941b`|
|Probe01c_API.lean|0|12.047|`730e0e1a1c614324d7ca7f1bdf8e3f1a7db9d1bd7c81b2040557fc343735e7ee`|`9412626b48ee74d526b82384c121607d9d9666d2d2b97d8e83cec5b633c0c34a`|
|Probe02_SlicesAndScalar.lean|124|228.859|`7b22b616d6edf1ca7b2b2169c242b639ee4a0381e6c56b83ecdb7aebd7fa5802`|`6cd528cde418ef13280f6feed50b8f3ae20c0531065a9d28f2f4452124a4477c`|
|Probe02b_SlicesAndScalar.lean|0|12.469|`f4250df0d4dda1f0b932e6e38cbeac943d7d924573a4e6785e6c5be3e7d67346`|`d973c55c10ba0bddb83fc59bdb042d85e4382ddfeaeb9b82607bb0e1a844c994`|
|Probe03b_CoordinateAndProduct.lean|0|12.781|`cba00ec4fad34580682d25396c8e6b02811110eae930a94fbd48f71bb434404c`|`1279ae82a09853de22226f6eea4a88471700b416699daa002dbc15f0fb0d31f3`|
|Probe04_DualRepresentation.lean|0|12.375|`7d0351784ad7f0d186c96dc1485b39bbc34e3822e06d99334467babea9ce6ff5`|`5a815e135f514965f3ffd9d9c940b95cdf18378a4597f712ed6a799e1cba1fad`|
|Probe04b_DualRepresentationAxioms.lean|0|12.234|`9ccb05b1b1419b13d98f453dfe7deb7a875323200146720ea5ad821b1cb3e76e`|`ce207055fa7dd70da66984b328e01d25bb5bf7d8286cb078d25f89c18f345c2d`|

每个结果文件哈希、输入库源码哈希及源码/输出重核结果见`API_DERIVATIVE_INPUTS.json`。最后成功runner SHA：`80047315612112b6a0d1be3af639e5ef431c0f337e77127d9665435028b39353`。

命名小型引理公理原始输出（Probe04b）：

```text
'T3DerivativePreparation.coordinateDualRepresentation' depends on axioms: [propext, Classical.choice, Quot.sound]

```

## 完整实际API类型输出（Probe01c_API.log原文）

```text
@hasGradientAt_iff_hasFDerivAt.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {f' x : F},
  HasGradientAt.{u_1, u_2} f f' x ↔ HasFDerivAt.{u_1, u_2, u_1} f ((InnerProductSpace.toDual.{u_1, u_2} 𝕜 F) f') x
@hasFDerivAt_iff_hasGradientAt.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {x : F}
  {frechet : StrongDual.{u_1, u_2} 𝕜 F},
  HasFDerivAt.{u_1, u_2, u_1} f frechet x ↔
    HasGradientAt.{u_1, u_2} f
      ((LinearIsometryEquiv.symm.{u_1, u_1, u_2, max u_1 u_2} (InnerProductSpace.toDual.{u_1, u_2} 𝕜 F)) frechet) x
@HasGradientAt.hasFDerivAt.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {f' x : F},
  HasGradientAt.{u_1, u_2} f f' x → HasFDerivAt.{u_1, u_2, u_1} f ((InnerProductSpace.toDual.{u_1, u_2} 𝕜 F) f') x
@HasFDerivAt.hasGradientAt.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {x : F}
  {frechet : StrongDual.{u_1, u_2} 𝕜 F},
  HasFDerivAt.{u_1, u_2, u_1} f frechet x →
    HasGradientAt.{u_1, u_2} f
      ((LinearIsometryEquiv.symm.{u_1, u_1, u_2, max u_1 u_2} (InnerProductSpace.toDual.{u_1, u_2} 𝕜 F)) frechet) x
@HasGradientAt.gradient.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {f' x : F},
  HasGradientAt.{u_1, u_2} f f' x → Eq.{u_2 + 1} (gradient.{u_1, u_2} f x) f'
@HasGradientAt.unique.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {x gradf gradg : F},
  HasGradientAt.{u_1, u_2} f gradf x → HasGradientAt.{u_1, u_2} f gradg x → Eq.{u_2 + 1} gradf gradg
@DifferentiableAt.hasGradientAt.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {x : F},
  DifferentiableAt.{u_1, u_2, u_1} 𝕜 f x → HasGradientAt.{u_1, u_2} f (gradient.{u_1, u_2} f x) x
@toDual_gradient.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {F : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} F]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 F] [inst_3 : CompleteSpace.{u_2} F] {f : F → 𝕜} {x : F},
  Eq.{max (u_1 + 1) (u_2 + 1)} ((InnerProductSpace.toDual.{u_1, u_2} 𝕜 F) (gradient.{u_1, u_2} f x))
    (fderiv.{u_1, u_2, u_1} 𝕜 f x)
@InnerProductSpace.toDual_apply_apply.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {E : Type u_2} [inst : RCLike.{u_1} 𝕜] [inst_1 : NormedAddCommGroup.{u_2} E]
  [inst_2 : InnerProductSpace.{u_1, u_2} 𝕜 E] [inst_3 : CompleteSpace.{u_2} E] {x y : E},
  Eq.{u_1 + 1} (((InnerProductSpace.toDual.{u_1, u_2} 𝕜 E) x) y) (Inner.inner.{u_1, u_2} 𝕜 x y)
@EuclideanSpace.proj.{u_1,
    u_2} : {ι : Type u_1} →
  {𝕜 : Type u_2} → [inst : RCLike.{u_2} 𝕜] → ι → StrongDual.{u_2, max u_1 u_2} 𝕜 (EuclideanSpace.{u_2, u_1} 𝕜 ι)
@EuclideanSpace.coe_proj.{u_1,
    u_2} : ∀ {ι : Type u_1} (𝕜 : Type u_2) [inst : RCLike.{u_2} 𝕜] {i : ι},
  Eq.{max (u_1 + 1) (u_2 + 1)} ⇑(EuclideanSpace.proj.{u_1, u_2} i) fun x => WithLp.ofLp.{max u_1 u_2} x i
@PiLp.hasFDerivAt_apply.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} {ι : Type u_2} {E : ι → Type u_3} [inst : NontriviallyNormedField.{u_1} 𝕜]
  [inst_1 : (i : ι) → NormedAddCommGroup.{u_3} (E i)] [inst_2 : (i : ι) → NormedSpace.{u_1, u_3} 𝕜 (E i)]
  [Finite.{u_2 + 1} ι] (p : ENNReal) [Fact (LE.le.{0} 1 p)] (f : PiLp.{u_2, u_3} p E) (i : ι),
  HasFDerivAt.{u_1, max u_2 u_3, u_3} (fun f => WithLp.ofLp.{max u_2 u_3} f i) (PiLp.proj.{u_1, u_2, u_3} p E i) f
@ContinuousLinearMap.hasFDerivAt.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2} [inst_1 : AddCommGroup.{u_2} E]
  [inst_2 : Module.{u_1, u_2} 𝕜 E] [inst_3 : TopologicalSpace.{u_2} E] {F : Type u_3} [inst_4 : AddCommGroup.{u_3} F]
  [inst_5 : Module.{u_1, u_3} 𝕜 F] [inst_6 : TopologicalSpace.{u_3} F]
  (f : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F) {x : E}, HasFDerivAt.{u_1, u_2, u_3} (⇑f) f x
@EuclideanSpace.inner_eq_star_dotProduct.{u_1,
    u_2} : ∀ {ι : Type u_1} {𝕜 : Type u_2} [inst : RCLike.{u_2} 𝕜] [inst_1 : Fintype.{u_1} ι]
  (x y : EuclideanSpace.{u_2, u_1} 𝕜 ι),
  Eq.{u_2 + 1} (Inner.inner.{u_2, max u_1 u_2} 𝕜 x y)
    (dotProduct.{u_2, u_1} (WithLp.ofLp.{max u_1 u_2} y) (Star.star.{max u_1 u_2} (WithLp.ofLp.{max u_1 u_2} x)))
@HasFDerivAt.prodMk.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {G : Type u_4}
  [inst_5 : NormedAddCommGroup.{u_4} G] [inst_6 : NormedSpace.{u_1, u_4} 𝕜 G] {f₁ : E → F}
  {f₁' : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F} {x : E} {f₂ : E → G}
  {f₂' : ContinuousLinearMap.{u_1, u_1, u_2, u_4} (RingHom.id.{u_1} 𝕜) E G},
  HasFDerivAt.{u_1, u_2, u_3} f₁ f₁' x →
    HasFDerivAt.{u_1, u_2, u_4} f₂ f₂' x →
      HasFDerivAt.{u_1, u_2, max u_4 u_3} (fun x => Prod.mk.{u_3, u_4} (f₁ x) (f₂ x))
        (ContinuousLinearMap.prod.{u_1, u_2, u_3, u_4} f₁' f₂') x
@HasFDerivAt.comp.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {G : Type u_4}
  [inst_5 : NormedAddCommGroup.{u_4} G] [inst_6 : NormedSpace.{u_1, u_4} 𝕜 G] {f : E → F}
  {f' : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F} (x : E) {g : F → G}
  {g' : ContinuousLinearMap.{u_1, u_1, u_3, u_4} (RingHom.id.{u_1} 𝕜) F G},
  HasFDerivAt.{u_1, u_3, u_4} g g' (f x) →
    HasFDerivAt.{u_1, u_2, u_3} f f' x →
      HasFDerivAt.{u_1, u_2, u_4} (Function.comp.{u_2 + 1, u_3 + 1, u_4 + 1} g f)
        (ContinuousLinearMap.comp.{u_1, u_1, u_1, u_2, u_3, u_4} g' f') x
@hasFDerivAt_const.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2} [inst_1 : AddCommGroup.{u_2} E]
  [inst_2 : Module.{u_1, u_2} 𝕜 E] [inst_3 : TopologicalSpace.{u_2} E] {F : Type u_3} [inst_4 : AddCommGroup.{u_3} F]
  [inst_5 : Module.{u_1, u_3} 𝕜 F] [inst_6 : TopologicalSpace.{u_3} F] (c : F) (x : E),
  HasFDerivAt.{u_1, u_2, u_3} (fun x => c) 0 x
@HasFDerivAt.mul.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {x : E} {𝔸' : Type u_3}
  [inst_3 : NormedCommRing.{u_3} 𝔸'] [inst_4 : NormedAlgebra.{u_1, u_3} 𝕜 𝔸'] {c d : E → 𝔸'}
  {c' d' : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E 𝔸'},
  HasFDerivAt.{u_1, u_2, u_3} c c' x →
    HasFDerivAt.{u_1, u_2, u_3} d d' x →
      HasFDerivAt.{u_1, u_2, u_3} (HMul.hMul.{max u_2 u_3, max u_2 u_3, max u_2 u_3} c d)
        (HAdd.hAdd.{max u_2 u_3, max u_2 u_3, max u_2 u_3} (HSMul.hSMul.{u_3, max u_2 u_3, max u_2 u_3} (c x) d')
          (HSMul.hSMul.{u_3, max u_2 u_3, max u_2 u_3} (d x) c'))
        x
@HasFDerivAt.const_smul.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {f : E → F}
  {f' : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F} {x : E} {R : Type u_4}
  [inst_5 : Monoid.{u_4} R] [inst_6 : DistribMulAction.{u_4, u_3} R F] [inst_7 : SMulCommClass.{u_1, u_4, u_3} 𝕜 R F]
  [inst_8 : ContinuousConstSMul.{u_4, u_3} R F],
  HasFDerivAt.{u_1, u_2, u_3} f f' x →
    ∀ (c : R),
      HasFDerivAt.{u_1, u_2, u_3} (HSMul.hSMul.{u_4, max u_2 u_3, max u_2 u_3} c f)
        (HSMul.hSMul.{u_4, max u_2 u_3, max u_2 u_3} c f') x
@HasFDerivAt.add.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {f g : E → F}
  {f' g' : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F} {x : E},
  HasFDerivAt.{u_1, u_2, u_3} f f' x →
    HasFDerivAt.{u_1, u_2, u_3} g g' x →
      HasFDerivAt.{u_1, u_2, u_3} (HAdd.hAdd.{max u_2 u_3, max u_2 u_3, max u_2 u_3} f g)
        (HAdd.hAdd.{max u_2 u_3, max u_2 u_3, max u_2 u_3} f' g') x
@HasFDerivAt.fun_sum.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {x : E} {ι : Type u_4}
  {u : Finset.{u_4} ι} {A : ι → E → F} {A' : ι → ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F},
  (∀ (i : ι), Membership.mem.{u_4, u_4} u i → HasFDerivAt.{u_1, u_2, u_3} (A i) (A' i) x) →
    HasFDerivAt.{u_1, u_2, u_3} (fun y => ∑ i ∈ u, A i y) (∑ i ∈ u, A' i) x
@HasFDerivAt.sum.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {x : E} {ι : Type u_4}
  {u : Finset.{u_4} ι} {A : ι → E → F} {A' : ι → ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F},
  (∀ (i : ι), Membership.mem.{u_4, u_4} u i → HasFDerivAt.{u_1, u_2, u_3} (A i) (A' i) x) →
    HasFDerivAt.{u_1, u_2, u_3} (∑ i ∈ u, A i) (∑ i ∈ u, A' i) x
@fderiv_fst.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {p : Prod.{u_2, u_3} E F},
  Eq.{max (u_2 + 1) (u_3 + 1)} (fderiv.{u_1, max u_3 u_2, u_2} 𝕜 Prod.fst.{u_2, u_3} p)
    (ContinuousLinearMap.fst.{u_1, u_2, u_3} 𝕜 E F)
@fderiv_snd.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {p : Prod.{u_2, u_3} E F},
  Eq.{max (u_2 + 1) (u_3 + 1)} (fderiv.{u_1, max u_3 u_2, u_3} 𝕜 Prod.snd.{u_2, u_3} p)
    (ContinuousLinearMap.snd.{u_1, u_2, u_3} 𝕜 E F)
@HasFDerivAt.fst.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {G : Type u_4}
  [inst_5 : NormedAddCommGroup.{u_4} G] [inst_6 : NormedSpace.{u_1, u_4} 𝕜 G] {x : E} {f₂ : E → Prod.{u_3, u_4} F G}
  {f₂' : ContinuousLinearMap.{u_1, u_1, u_2, max u_4 u_3} (RingHom.id.{u_1} 𝕜) E (Prod.{u_3, u_4} F G)},
  HasFDerivAt.{u_1, u_2, max u_3 u_4} f₂ f₂' x →
    HasFDerivAt.{u_1, u_2, u_3} (fun x => (f₂ x).1)
      (ContinuousLinearMap.comp.{u_1, u_1, u_1, u_2, max u_3 u_4, u_3} (ContinuousLinearMap.fst.{u_1, u_3, u_4} 𝕜 F G)
        f₂')
      x
@HasFDerivAt.snd.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {G : Type u_4}
  [inst_5 : NormedAddCommGroup.{u_4} G] [inst_6 : NormedSpace.{u_1, u_4} 𝕜 G] {x : E} {f₂ : E → Prod.{u_3, u_4} F G}
  {f₂' : ContinuousLinearMap.{u_1, u_1, u_2, max u_4 u_3} (RingHom.id.{u_1} 𝕜) E (Prod.{u_3, u_4} F G)},
  HasFDerivAt.{u_1, u_2, max u_3 u_4} f₂ f₂' x →
    HasFDerivAt.{u_1, u_2, u_4} (fun x => (f₂ x).2)
      (ContinuousLinearMap.comp.{u_1, u_1, u_1, u_2, max u_3 u_4, u_4} (ContinuousLinearMap.snd.{u_1, u_3, u_4} 𝕜 F G)
        f₂')
      x
ContinuousLinearMap.inl.{u_1, u_2,
  u_3} : (R : Type u_1) →
  [inst : Semiring.{u_1} R] →
    (M₁ : Type u_2) →
      [inst_1 : TopologicalSpace.{u_2} M₁] →
        [inst_2 : AddCommMonoid.{u_2} M₁] →
          [inst_3 : Module.{u_1, u_2} R M₁] →
            (M₂ : Type u_3) →
              [inst_4 : TopologicalSpace.{u_3} M₂] →
                [inst_5 : AddCommMonoid.{u_3} M₂] →
                  [inst_6 : Module.{u_1, u_3} R M₂] →
                    ContinuousLinearMap.{u_1, u_1, u_2, max u_3 u_2} (RingHom.id.{u_1} R) M₁ (Prod.{u_2, u_3} M₁ M₂)
ContinuousLinearMap.inr.{u_1, u_2,
  u_3} : (R : Type u_1) →
  [inst : Semiring.{u_1} R] →
    (M₁ : Type u_2) →
      [inst_1 : TopologicalSpace.{u_2} M₁] →
        [inst_2 : AddCommMonoid.{u_2} M₁] →
          [inst_3 : Module.{u_1, u_2} R M₁] →
            (M₂ : Type u_3) →
              [inst_4 : TopologicalSpace.{u_3} M₂] →
                [inst_5 : AddCommMonoid.{u_3} M₂] →
                  [inst_6 : Module.{u_1, u_3} R M₂] →
                    ContinuousLinearMap.{u_1, u_1, u_3, max u_3 u_2} (RingHom.id.{u_1} R) M₂ (Prod.{u_2, u_3} M₁ M₂)
@hasFDerivAt_const_add_iff.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {f : E → F}
  {f' : ContinuousLinearMap.{u_1, u_1, u_2, u_3} (RingHom.id.{u_1} 𝕜) E F} {x : E} (c : F),
  HasFDerivAt.{u_1, u_2, u_3} (fun x => HAdd.hAdd.{u_3, u_3, u_3} c (f x)) f' x ↔ HasFDerivAt.{u_1, u_2, u_3} f f' x
@HasDerivAt.hasGradientAt' : ∀ {g : ℝ → ℝ} {g' u : ℝ}, HasDerivAt.{0, 0} g g' u → HasGradientAt.{0, 0} g g' u
@gradient_eq_deriv' : ∀ {g : ℝ → ℝ} {u : ℝ}, Eq.{1} (gradient.{0, 0} g u) (deriv.{0, 0} g u)
@HasDerivAt.pow.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} {𝔸 : Type u_2} [inst : NontriviallyNormedField.{u_1} 𝕜] [inst_1 : NormedCommRing.{u_2} 𝔸]
  [inst_2 : NormedAlgebra.{u_1, u_2} 𝕜 𝔸] {f : 𝕜 → 𝔸} {f' : 𝔸} {x : 𝕜},
  HasDerivAt.{u_1, u_2} f f' x →
    ∀ (n : ℕ),
      HasDerivAt.{u_1, u_2} (HPow.hPow.{max u_1 u_2, 0, max u_1 u_2} f n)
        (HMul.hMul.{u_2, u_2, u_2}
          (HMul.hMul.{u_2, u_2, u_2} (↑n) (HPow.hPow.{u_2, 0, u_2} (f x) (HSub.hSub.{0, 0, 0} n 1))) f')
        x
@HasDerivAt.div_const.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {x : 𝕜} {𝕜' : Type u_2}
  [inst_1 : NormedDivisionRing.{u_2} 𝕜'] [inst_2 : NormedAlgebra.{u_1, u_2} 𝕜 𝕜'] {c : 𝕜 → 𝕜'} {c' : 𝕜'},
  HasDerivAt.{u_1, u_2} c c' x →
    ∀ (d : 𝕜'), HasDerivAt.{u_1, u_2} (fun x => HDiv.hDiv.{u_2, u_2, u_2} (c x) d) (HDiv.hDiv.{u_2, u_2, u_2} c' d) x
@HasDerivAt.deriv.{u_1,
    u_2} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {F : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} F] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 F] {f : 𝕜 → F} {f' : F} {x : 𝕜},
  HasDerivAt.{u_1, u_2} f f' x → Eq.{u_2 + 1} (deriv.{u_1, u_2} f x) f'
@fderiv_const_add.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {f : E → F} {x : E} (c : F),
  Eq.{max (u_2 + 1) (u_3 + 1)} (fderiv.{u_1, u_2, u_3} 𝕜 (fun y => HAdd.hAdd.{u_3, u_3, u_3} c (f y)) x)
    (fderiv.{u_1, u_2, u_3} 𝕜 f x)
@fderiv_add_const.{u_1, u_2,
    u_3} : ∀ {𝕜 : Type u_1} [inst : NontriviallyNormedField.{u_1} 𝕜] {E : Type u_2}
  [inst_1 : NormedAddCommGroup.{u_2} E] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] {F : Type u_3}
  [inst_3 : NormedAddCommGroup.{u_3} F] [inst_4 : NormedSpace.{u_1, u_3} 𝕜 F] {f : E → F} {x : E} (c : F),
  Eq.{max (u_2 + 1) (u_3 + 1)} (fderiv.{u_1, u_2, u_3} 𝕜 (fun y => HAdd.hAdd.{u_3, u_3, u_3} (f y) c) x)
    (fderiv.{u_1, u_2, u_3} 𝕜 f x)
@hasStrictFDerivAt_uncurry_coprod.{u_1, u_2, u_3,
    u_4} : ∀ {𝕜 : Type u_1} {E₁ : Type u_2} {E₂ : Type u_3} {F : Type u_4} [inst : NontriviallyNormedField.{u_1} 𝕜]
  [inst_1 : NormedAddCommGroup.{u_2} E₁] [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E₁] [inst_3 : NormedAddCommGroup.{u_3} E₂]
  [inst_4 : NormedSpace.{u_1, u_3} 𝕜 E₂] [inst_5 : NormedAddCommGroup.{u_4} F] [inst_6 : NormedSpace.{u_1, u_4} 𝕜 F]
  [IsRCLikeNormedField.{u_1} 𝕜] {u : Prod.{u_2, u_3} E₁ E₂} {f : E₁ → E₂ → F}
  {f₁ : E₁ → E₂ → ContinuousLinearMap.{u_1, u_1, u_2, u_4} (RingHom.id.{u_1} 𝕜) E₁ F}
  {f₂ : E₁ → E₂ → ContinuousLinearMap.{u_1, u_1, u_3, u_4} (RingHom.id.{u_1} 𝕜) E₂ F},
  (∀ᶠ (v : Prod.{u_2, u_3} E₁ E₂) in nhds.{max u_2 u_3} u,
      HasFDerivAt.{u_1, u_2, u_4} (fun x => f x v.2)
        (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, max u_2 u_4} f₁ v) v.1) →
    (∀ᶠ (v : Prod.{u_2, u_3} E₁ E₂) in nhds.{max u_2 u_3} u,
        HasFDerivAt.{u_1, u_3, u_4} (fun x => f v.1 x)
          (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, max u_3 u_4} f₂ v) v.2) →
      ContinuousAt.{max u_2 u_3, max u_2 u_4}
          (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, max u_2 u_4} f₁) u →
        ContinuousAt.{max u_2 u_3, max u_3 u_4}
            (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, max u_3 u_4} f₂) u →
          HasStrictFDerivAt.{u_1, max u_2 u_3, u_4}
            (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, u_4} f)
            (ContinuousLinearMap.coprod.{u_1, u_4, u_2, u_3}
              (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, max u_2 u_4} f₁ u)
              (Function.HasUncurry.uncurry.{max (max u_2 u_3) u_4, max u_2 u_3, max u_3 u_4} f₂ u))
            u

```

