| source_id | 标签 | 审计判定 | 最终状态 |
|---|---|---|---|
| MD-1.5.3-Thm1.1 | Theorem 1.1 | PENDING | incomplete |
| MD-1.2-EnergyConservation | 未编号结论 | PENDING | incomplete |
| MD-1.3-NewtonEulerLagrange | 未编号结论 | PENDING | incomplete |
| MD-1.4-LegendreHamiltonian | 未编号结论 | PENDING | incomplete |
| MD-1.5.1-FlowInverse | 未编号结论 | PENDING | incomplete |

## MD-1.5.3-Thm1.1 · Theorem 1.1 · 印刷 p.32 / PDF p.55

### 1. 原文陈述

> If $\boldsymbol{q}^*$ is a strong local minimum of smooth potential $U$ then $\boldsymbol{z}^*=(\boldsymbol{q}^*,0)$ is stable.

### 2. 原文证明

原书无完整证明，`proof_latex = null`。

原文只有以下证明思路并指向[216]，无完整证明；不把思路冒充原文证明。

原文证明思路（不计为完整证明）：

> The proof of this theorem relies on showing that if trajectories are started from a point sufficiently close to $\boldsymbol{z}^*$ they cannot wander away to infinity. Although the result holds in greater generality, it is easy to show under assumptions of local smoothness of $U$ (which we are normally happy to make in molecular dynamics). For more discussion see the text [216].

### 3. Lean 陈述

```lean
theorem MD.Ch01.theorem_1_1 {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n))
```

### 4. 对照表

| 原文成分 | Lean 对应 | 备注（[EXTRA]/[ERRATUM?]/一致） |
|---|---|---|
| 位置、动量相空间；固定质量动能+势能系统 | Position n、Momentum n、PhaseSpace n；mechanicalVectorField m (-gradient U) | 一致；n=N_c，三维原子系统n=3N |
| q*为强局部极小；存在正半径；穿孔邻域U(q)>U(q*) | hstrict : IsStrictPotentialMinOn U Q q₀ | 一致；定义展开含∀q∈Q、q≠q₀、dist<R；[EXTRA] q₀∈Q |
| smooth potential U | hU : ∀ q∈Q, ContDiffAt ℝ ∞ U q | 一致；原文smooth明确写出 |
| 正定质量的背景 | hm : ∀ i, 0<m i | [EXTRA] 定理句未重复，p.25背景明确；固定对角模型 |
| 位置域及局部邻域 | hQ : IsOpen Q | [EXTRA] 邻域在势能定义域内 |
| z*=(q*,0)是平衡状态 | IsMechanicalEquilibrium ... (q₀,0) | 一致；原文stable以前提平衡点定义，补出隐含资格 |
| ∀正ε，∃正δ，∀初值z₀；欧氏距离<δ | IsFutureMechanicalStableEuclidean的ε/δ/z₀量词 | 一致；正容差解释及欧氏phaseEuclideanDistance，非乘积最大距离 |
| 所有t≥0的流存在 | 该稳定定义中的∃a<0、∃γ、IsMechanicalSolutionOn (Ioi a)、γ0=z₀ | 一致；显式未来存在，避免无解时稳定断言空真 |
| sup(t≥0)\|\|F_t(z₀)-z*\|\|<ε | ∀同初值未来解，BddAbove(range ...) ∧ sSup(range ...)<ε | 一致；有界性保护实数sSup，严格<保留；尚待独立语义审计 |

### 5. 审计结论

原文 JSON：DRAFT；MathCopilot只读审计：PENDING；frozen=false。

等待PILOT_ALL单一返回数组，按A原文审校再C语义审计整合；模板B已取消，尚无网站PASS。

- json_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- blueprint_translation：CANCELLED_NOT_REQUIRED；任务 `T_blueprint_MD-1.5.3-Thm1.1`；返回件 尚未收到。

- semantic_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- PAGE_SPAN_CORRECTION：用户范围31–32/54–55是背景跨度；定理与证明思路均仅32/55。（local_verified）。

### 6. 最终状态与证明位置

最终状态：**incomplete**。网站语义审计与冻结未完成；此文档为待审草案，不是第5步最终交付。

Blueprint声明/证明位置：`Blueprint/Ch01.lean:54`。

本地证明状态：checked proof + documented priors。

依赖公理：`propext, Classical.choice, Quot.sound`。

直接风险：无sorry/admit/新增axiom/unsafe/True/P→P；本地5条签名逐项检查。

依赖闭包风险：传递依赖只含propext, Classical.choice, Quot.sound；导入的正式库源码无证明捷径。

- 复用证明：`MolecularDynamics/Chapter01/EuclideanStability.lean:72`，`MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_smooth`。

当前签名SHA256：`05ed1f54ee881d97a6b9acb5ecb6908b9eb7b5aed6f08b62e4b073d8db1e2e44`；原文条目SHA256：`15c882d153436a4622fba98867b6fada60a25b60c46ed413654ae763c1a28a12`。

## MD-1.2-EnergyConservation · 未编号结论 · 印刷 p.19 / PDF p.42

### 1. 原文陈述

> Along the solutions of (1.3), the energy is conserved, since its derivative vanishes:

### 2. 原文证明

> \[\frac{\mathrm{d}}{\mathrm{d}t}E=\sum_{j=1}^{N}m_j\dot{\boldsymbol{q}}_j\cdot\ddot{\boldsymbol{q}}_j+\sum_{j=1}^{N}\frac{\partial U}{\partial\boldsymbol{q}_j}\cdot\dot{\boldsymbol{q}}_j=\sum_{j=1}^{N}\left(m_j\ddot{\boldsymbol{q}}_j+\frac{\partial U}{\partial\boldsymbol{q}_j}\right)\cdot\dot{\boldsymbol{q}}_j=0.\]

原文紧接陈述给出完整导数计算；PDF字体记录确认能量函数为数学斜体E。

### 3. Lean 陈述

```lean
theorem MD.Ch01.energy_conservation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (q : ℝ → Position n)
    (hm : ∀ i, 0 < m i) (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x)
    (hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q) :
    (∀ t ∈ Ioo a b, HasDerivAt
      (fun s => nBodyTotalEnergy m U (q s) (deriv q s)) 0 t) ∧
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b,
      nBodyTotalEnergy m U (q s) (deriv q s) =
      nBodyTotalEnergy m U (q t) (deriv q t)
```

### 4. 对照表

| 原文成分 | Lean 对应 | 备注（[EXTRA]/[ERRATUM?]/一致） |
|---|---|---|
| 式(1.3) Newton解；每坐标M q̈=-∇U | hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q | 一致；真实一阶/二阶导数和位置留在Q；不把守恒作假设 |
| 粒子/坐标质量、位置、速度 | m : CoordinateMasses n；q与deriv q | 一致的展平坐标模型；任意对角质量推广待审 |
| 质量正性 | hm : ∀i,0<m i | [EXTRA] 逆质量辅助重写；可考虑直接牛顿证明是否能减少此额外前提 |
| 势能偏导/链式法则 | hU : ∀x∈Q,DifferentiableAt ℝ U x | [EXTRA] 原文导数计算的隐含前提 |
| 解的存在时间和任意比较时间 | Ioo a b；∀s∈Ioo a b，∀t∈Ioo a b | [EXTRA] 显式开连通区间；仅在同一解区间内比较 |
| 式(1.4)位置-速度总能量 | nBodyTotalEnergy m U (q t) (deriv q t) | 一致；使用massHamiltonian_massOperator证明两种表示相同 |
| its derivative vanishes；dE/dt=0 | ∀t∈Ioo a b,HasDerivAt (fun s=>nBodyTotalEnergy ...) 0 t | 一致；实际导数为零 |
| the energy is conserved | ∀s,t在区间内，nBodyTotalEnergy(s)=nBodyTotalEnergy(t) | 一致；完整守恒子句 |

### 5. 审计结论

原文 JSON：DRAFT；MathCopilot只读审计：PENDING；frozen=false。

等待PILOT_ALL单一返回数组，按A原文审校再C语义审计整合；模板B已取消，尚无网站PASS。

- json_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- blueprint_translation：CANCELLED_NOT_REQUIRED；任务 `T_blueprint_MD-1.2-EnergyConservation`；返回件 尚未收到。

- semantic_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

### 6. 最终状态与证明位置

最终状态：**incomplete**。网站语义审计与冻结未完成；此文档为待审草案，不是第5步最终交付。

Blueprint声明/证明位置：`Blueprint/Ch01.lean:72`。

本地证明状态：checked proof + documented priors。

依赖公理：`propext, Classical.choice, Quot.sound`。

直接风险：无sorry/admit/新增axiom/unsafe/True/P→P；本地5条签名逐项检查。

依赖闭包风险：传递依赖只含propext, Classical.choice, Quot.sound；导入的正式库源码无证明捷径。

- 复用证明：`MolecularDynamics/Chapter01/EnergyConservation.lean:11`，`MolecularDynamics.mechanical_energy_hasDerivAt_zero`。

- 复用证明：`MolecularDynamics/Chapter01/EnergyConservation.lean:47`，`MolecularDynamics.mechanical_energy_const_on_Ioo`。

- 复用证明：`MolecularDynamics/Chapter01/Hamiltonian.lean:86`，`MolecularDynamics.massHamiltonian_massOperator`。

- 复用证明：`MolecularDynamics/Chapter01/LocalTrajectories.lean:188`，`MolecularDynamics.newtonTrajectory_to_mechanicalSolution`。

当前签名SHA256：`f127edcebe32563ae5ff4f88df5cda69ff6ede9ecfe10bed2ee5a4dd7dc9051e`；原文条目SHA256：`602eec4ec54600d2453b232c7f51b0ab138de3d3f56be31e060fb6e6d0aed2c5`。

## MD-1.3-NewtonEulerLagrange · 未编号结论 · 印刷 p.23 / PDF p.46

### 1. 原文陈述

> The equations of motion may be expressed in terms of the Lagrangian as:
> \[\frac{\mathrm{d}}{\mathrm{d}t}\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\frac{\partial L}{\partial\boldsymbol{q}}.\]
> (Note that this must be interpreted in general as a set of $N_c=3N$ equations, one for each atomic coordinate.)

### 2. 原文证明

原书无完整证明，`proof_latex = null`。

原文给出运动方程的等价表达，没有独立证明；下一段开始讨论坐标变换，不纳入本条。

### 3. Lean 陈述

```lean
theorem MD.Ch01.newton_iff_euler_lagrange {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q
```

### 4. 对照表

| 原文成分 | Lean 对应 | 备注（[EXTRA]/[ERRATUM?]/一致） |
|---|---|---|
| 系统(1.3)，L定义于p.22 | m、U；massLagrangian=动能-U | 一致；当前条处于固定质量，未替换为之后一般坐标M(q) |
| q(t)及全部Nc个坐标 | q : ℝ→Position n；向量等式；n=N_c | 一致；三维原子场景n=3N，坐标质量展开待审 |
| 正质量 | hm | [EXTRA] 使用相空间互逆质量算子 |
| 势能位置偏导 | hU | [EXTRA] U在Q每点可微 |
| 时间导数 | hI : IsOpen I | [EXTRA] two-sided导数，避免within在边界退化 |
| Newton二阶轨迹定义 | IsNewtonTrajectoryOn；HasDerivAt q，HasDerivAt (deriv q)，M q̈=-∇U | 一致；不是仅total deriv方程 |
| Newton → d/dt(∂L/∂q̇)=∂L/∂q | ↔左到右；IsEulerLagrangeTrajectoryOn展开含真实导数 | 一致；复用mechanicalSolution_eulerLagrange |
| 运动方程可表达为Euler–Lagrange；反向等价 | ↔右到左；eulerLagrange_to_mechanicalSolution再回Newton | 一致；反向未遗漏 |
| 每条方程/位置域 | 两个轨迹谓词都要求∀t∈I,q t∈Q，随后∀t∈I | 一致；量词与域一致 |

### 5. 审计结论

原文 JSON：DRAFT；MathCopilot只读审计：PENDING；frozen=false。

等待PILOT_ALL单一返回数组，按A原文审校再C语义审计整合；模板B已取消，尚无网站PASS。

- json_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- blueprint_translation：CANCELLED_NOT_REQUIRED；任务 `T_blueprint_MD-1.3-NewtonEulerLagrange`；返回件 尚未收到。

- semantic_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

### 6. 最终状态与证明位置

最终状态：**incomplete**。网站语义审计与冻结未完成；此文档为待审草案，不是第5步最终交付。

Blueprint声明/证明位置：`Blueprint/Ch01.lean:108`。

本地证明状态：checked proof + documented priors。

依赖公理：`propext, Classical.choice, Quot.sound`。

直接风险：无sorry/admit/新增axiom/unsafe/True/P→P；本地5条签名逐项检查。

依赖闭包风险：传递依赖只含propext, Classical.choice, Quot.sound；导入的正式库源码无证明捷径。

- 复用证明：`MolecularDynamics/Chapter01/Lagrangian.lean:83`，`MolecularDynamics.mechanicalSolution_eulerLagrange`。

- 复用证明：`MolecularDynamics/Chapter01/Lagrangian.lean:102`，`MolecularDynamics.eulerLagrange_to_mechanicalSolution`。

- 复用证明：`MolecularDynamics/Chapter01/LocalTrajectories.lean:188`，`MolecularDynamics.newtonTrajectory_to_mechanicalSolution`。

- 复用证明：`MolecularDynamics/Chapter01/LocalTrajectories.lean:141`，`MolecularDynamics.hasDerivAt_deriv_position`。

- 复用证明：`MolecularDynamics/Chapter01/LocalTrajectories.lean:154`，`MolecularDynamics.solution_nBodyEquationAt`。

当前签名SHA256：`27fd7e1251d62b07011dfeab02b981ad825d1b4c505a630e04a75d5f5eabaf9f`；原文条目SHA256：`1a2246dbfd6de1a5d68c368c83933fd807672cc490097359d2afea3f40aaf4e8`。

## MD-1.4-LegendreHamiltonian · 未编号结论 · 印刷 p.24 / PDF p.47

### 1. 原文陈述

> If $\boldsymbol{M}(\boldsymbol{q})$ is invertible, the supremum is achieved precisely when
> \[\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p},\]
> which gives the standard definition of the momentum vector $\boldsymbol{p}$ in terms of velocities,
> \[\boldsymbol{p}=\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\boldsymbol{M}(\boldsymbol{q})\dot{\boldsymbol{q}},\]
> and, with $\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p}$, the Legendre transformation results in a new function
> \[H(\boldsymbol{q},\boldsymbol{p})\stackrel{\mathrm{def}}{=}\boldsymbol{p}^TM(\boldsymbol{q})^{-1}\boldsymbol{p}/2+U(\boldsymbol{q}).\]
> This is precisely the energy function, written in terms of positions and momenta.

### 2. 原文证明

> In the case of the Lagrangian $L(\boldsymbol{q},\boldsymbol{v})=\boldsymbol{v}^TM(\boldsymbol{q})\boldsymbol{v}/2-U(\boldsymbol{q})$ (which we have seen is the formulation of a mechanical system in generalized coordinates) we find
> \[\sup_{\boldsymbol{v}}(\boldsymbol{p}^T\boldsymbol{v}-(\boldsymbol{v}^TM(\boldsymbol{q})\boldsymbol{v}/2-U(\boldsymbol{q})))=\sup_{\boldsymbol{v}}(\boldsymbol{p}^T\boldsymbol{v}-\boldsymbol{v}^TM(\boldsymbol{q})\boldsymbol{v}/2)+U(\boldsymbol{q}).\]

仅有上述代数推导；原文没有证明“可逆即达到上确界”或唯一性。

### 3. Lean 陈述

```lean
theorem MD.Ch01.hamiltonian_legendre_transform {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q
```

### 4. 对照表

| 原文成分 | Lean 对应 | 备注（[EXTRA]/[ERRATUM?]/一致） |
|---|---|---|
| M(q)配置相关质量矩阵 | M : Position n → Matrix (Fin n) (Fin n) ℝ | 一致；没有缩为固定对角质量 |
| q,p；对v取上确界 | q,p后给hM；range(fun v:Velocity n=>inner p v-L) | 一致；q固定后优化v |
| If M(q) is invertible | hM : IsUnit (M q) | [ERRATUM?] 字面前提；没有静默加入正定/对称/凸性；需审计上下文是否继承它们 |
| L(q,v)=vᵀM(q)v/2-U(q) | variableMassLagrangian、matrixAction | 一致；直接矩阵二次型 |
| sup_v(pᵀv-L)且sup achieved | BddAbove(range ...) ∧ sSup(range ...)=H | 一致；有界保护避免实数sSup对无界集退化 |
| precisely when v=M(q)⁻¹p | ∀v,目标=H ↔ v=matrixAction (M q)⁻¹ p | 一致；完整唯一达到条件；但只可逆不足，未证 |
| p=∂L/∂q̇=M(q)q̇ | ∀v,HasGradientAt L (matrixAction (M q) v) v；p=M(q)(M(q)⁻¹p) | 一致；动量是真实梯度；若M非对称需审计 |
| H(q,p)=pᵀM(q)⁻¹p/2+U(q) | variableMassHamiltonian | 一致；逆矩阵作用于全矩阵 |
| This is precisely the energy function | H=逆速度ᵀM(q)逆速度/2+U(q) | 一致；替换回速度能量的子句保留 |
| 抽象Legendre的convex g及机械质量上下文 | 当前签名未并入凸性/正定，留在context_notation与issues | [ERRATUM?] 无界反例M=-1，必须先裁定/修复签名再复审冻结 |

### 5. 审计结论

原文 JSON：NEEDS_HUMAN；MathCopilot只读审计：PENDING；frozen=false。

等待PILOT_ALL单一返回数组，按A原文审校再C语义审计整合；模板B已取消，尚无网站PASS。

- json_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- blueprint_translation：CANCELLED_NOT_REQUIRED；任务 `T_blueprint_MD-1.4-LegendreHamiltonian`；返回件 尚未收到。

- semantic_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- POSSIBLE_ERRATUM：若只假设可逆，M=-1、p=0、U=0时目标=v²/2无上界；须确认同页凸性及p.23机械质量背景是否应并入假设。当前保留字面可逆陈述并标ERRATUM?，未静默加正定。（NEEDS_HUMAN）。

- REUSE_SCOPE_GAP：现有定理仅固定正对角m；本条保留任意配置相关M(q)、上界、sup、精确达到条件、动量偏导和能量对应，不能直接调用旧定理覆盖。（open）。

### 6. 最终状态与证明位置

最终状态：**incomplete**。网站语义审计与冻结未完成；此文档为待审草案，不是第5步最终交付。

Blueprint声明/证明位置：`Blueprint/Ch01.lean:147`。

本地证明状态：incomplete。

依赖公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接风险：含1处sorry；不能作为已证结论。

依赖闭包风险：传递#print axioms含sorryAx；其他先验为propext, Classical.choice, Quot.sound。

- 复用证明：`MolecularDynamics/Chapter01/LegendreTransform.lean:88`，`MolecularDynamics.massHamiltonian_eq_legendre_sup`。

- 复用证明：`MolecularDynamics/Chapter01/LegendreTransform.lean:71`，`MolecularDynamics.legendre_objective_eq_massHamiltonian_iff`。

当前签名SHA256：`2b468a3414ce493fbfab95cfca2a8569d174f3299324481d7e9a79a3444c27b5`；原文条目SHA256：`90466e97aa683c26b7f6b28282787edd8e31694292a61eae92dec3b5e0a55a00`。

## MD-1.5.1-FlowInverse · 未编号结论 · 印刷 p.26 / PDF p.49

### 1. 原文陈述

> The classical systems treated here can be solved forward or backward in time. Observe that $\mathcal{F}_{-t}\mathcal{F}_t=\operatorname{Id}$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $t$ form an Abelian group under the operation of composition ($\mathcal{F}_t\mathcal{F}_s=\mathcal{F}_s\mathcal{F}_t=\mathcal{F}_{t+s}$).

### 2. 原文证明

原书无完整证明，`proof_latex = null`。

原文用Observe that直接断言；没有独立证明。随后Hamiltonian守恒属于另一个结论，不纳入本条。

### 3. Lean 陈述

```lean
theorem MD.Ch01.flow_inverse {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n)
    (_hm : ∀ i, 0 < m i)
    (hψ : IsGlobalMechanicalFlowOn m (fun q => -gradient U q) Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∀ z ∈ S, ψ 0 z = z) ∧
    (∀ t : ℝ, ∀ z ∈ S, ψ (-t) (ψ t z) = z ∧ ψ t (ψ (-t) z) = z) ∧
    (∀ t : ℝ, BijOn (ψ t) S S) ∧
    ∀ s t : ℝ, ∀ z ∈ S,
      ψ t (ψ s z) = ψ s (ψ t z) ∧ ψ t (ψ s z) = ψ (t + s) z
```

### 4. 对照表

| 原文成分 | Lean 对应 | 备注（[EXTRA]/[ERRATUM?]/一致） |
|---|---|---|
| classical systems；自治flow map F_t(ξ)解决(1.5) | IsGlobalMechanicalFlowOn m (-gradient U) Q S ψ；ψ:ℝ→PhaseSpace→PhaseSpace | 一致；保持分子Hamiltonian的保守力对象；全m维自治ODE的一般化不纳入 |
| 固定正质量的Hamiltonian背景 | _hm : ∀i,0<m i | [EXTRA] 原文质量正定背景明确，反演段未重复；群律证明本身不使用正性 |
| forward or backward in time | hψ每z∈S都有全实时间ODE解；S不变 | [EXTRA] 显式前提；不承诺任意力的全局流存在 |
| 继承existence and uniqueness | hreg : ∀q∈Q,ContDiffAt ℝ 1 F q | [EXTRA] 唯一性的C1充分前提；正则性来源待审 |
| 初值ξ；恒等元Id | ∀z∈S,ψ 0 z=z | 一致；来自flow定义，不把群律放入假设 |
| F_{-t}F_t=Id | ∀t,∀z∈S,ψ(-t)(ψ t z)=z | 一致；量词含所有实时间 |
| flow map is invertible | ψ t(ψ(-t)z)=z ∧ BijOn(ψ t)S S | 一致；双向反演与双射，限制在不变状态域 |
| Abelian group composition F_t F_s=F_s F_t | ∀s,t,∀z∈S,ψ t(ψ s z)=ψ s(ψ t z) | 一致；闭包由hψ的MapsTo给出 |
| F_t F_s=F_{t+s} | ψ t(ψ s z)=ψ(t+s)z | 一致；identity/inverse/composition，函数复合结合律由函数操作固有 |
| 前小节的全局流存在前提 | 以实际解族hψ参数化该结论；不另断言∃ψ | 一致；需要导师确认这种条件化与正文继承前提等价 |

### 5. 审计结论

原文 JSON：DRAFT；MathCopilot只读审计：PENDING；frozen=false。

等待PILOT_ALL单一返回数组，按A原文审校再C语义审计整合；模板B已取消，尚无网站PASS。

- json_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

- blueprint_translation：CANCELLED_NOT_REQUIRED；任务 `T_blueprint_MD-1.5.1-FlowInverse`；返回件 尚未收到。

- semantic_review：PENDING；任务 `PILOT_ALL`；返回件 尚未收到。

### 6. 最终状态与证明位置

最终状态：**incomplete**。网站语义审计与冻结未完成；此文档为待审草案，不是第5步最终交付。

Blueprint声明/证明位置：`Blueprint/Ch01.lean:174`。

本地证明状态：checked proof + documented priors。

依赖公理：`propext, Classical.choice, Quot.sound`。

直接风险：无sorry/admit/新增axiom/unsafe/True/P→P；本地5条签名逐项检查。

依赖闭包风险：传递依赖只含propext, Classical.choice, Quot.sound；导入的正式库源码无证明捷径。

- 复用证明：`MolecularDynamics/Chapter01/GlobalFlow.lean:64`，`MolecularDynamics.globalMechanicalFlow_inverse`。

- 复用证明：`MolecularDynamics/Chapter01/GlobalFlow.lean:47`，`MolecularDynamics.globalMechanicalFlow_add`。

- 复用证明：`MolecularDynamics/Chapter01/GlobalFlow.lean:72`，`MolecularDynamics.globalMechanicalFlow_commute`。

- 复用证明：`MolecularDynamics/Chapter01/GlobalFlow.lean:82`，`MolecularDynamics.globalMechanicalFlow_bijOn`。

当前签名SHA256：`0612c669694cac25394cc94c88490c2844c0ae68af39ec6306d4ab0952450ee4`；原文条目SHA256：`06763b993229b5b38845e23b63eb2ada6998e9c06565145ad521876f78a4a41a`。
