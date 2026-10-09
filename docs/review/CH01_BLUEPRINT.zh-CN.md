# 第1章 Lean Blueprint 本地审阅材料

覆盖印刷p.1–45正文，习题除外。原文JSON仍为DRAFT；本地模板C预审独立于网站审计。网站未返回，所有条目均待网站审计，未冻结。编译和公理检查只验证当前Lean陈述/证明，不证明其忠于原文，也不验证物理模型。

| source_id | 页码 印刷/PDF | 本地预审 | 网站审计 | 状态 |
|---|---|---|---|---|
| MD-1.5.3-Thm1.1 | 32/55 | PASS | 待网站审计 | checked+documented priors |
| MD-1.2-EnergyConservation | 19/42 | PASS | 待网站审计 | checked+documented priors |
| MD-1.3-NewtonEulerLagrange | 23/46 | PASS | 待网站审计 | checked+documented priors |
| MD-1.4-LegendreHamiltonian | 24/47 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-1.5.1-FlowInverse | 26/49 | PASS | 待网站审计 | checked+documented priors |
| MD-1.1-Schrodinger | 5/28 | PASS | 待网站审计 | self-contained |
| MD-1.1-NewtonModel | 6/29 | PASS | 待网站审计 | self-contained |
| MD-1.1-HardSphere | 7/30 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-1.1.1-Multibody | 8/31 | PASS | 待网站审计 | self-contained |
| MD-1.1.1-Morse | 8/31 | PASS | 待网站审计 | self-contained |
| MD-1.1.1-MorseMinimum | 8/31 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-1.1.1-LengthBond | 9/32 | PASS | 待网站审计 | self-contained |
| MD-1.1.1-Dispersion | 10/33 | PASS | 待网站审计 | self-contained |
| MD-1.1.1-Buckingham | 10/33 | PASS | 待网站审计 | self-contained |
| MD-1.1.1-LennardJones | 10/33 | PASS | 待网站审计 | self-contained |
| MD-1.1.1-LJRepulsion | 11/34 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-1.1.1-HeterogeneousLJ | 11/34 | PASS | 待网站审计 | self-contained |
| MD-1.1.2-Coulomb | 12/35 | PASS | 待网站审计 | self-contained |
| MD-1.1.2-Cutoff | 12/35 | PASS | 待网站审计 | self-contained |
| MD-1.1.2-Yukawa | 12/35 | PASS | 待网站审计 | self-contained |
| MD-1.1.2-AngleBond | 13/36 | PASS | 待网站审计 | self-contained |
| MD-1.1.2-Dihedral | 13/36 | PASS | 待网站审计 | self-contained |
| MD-1.1.2-GayBerne | 16–17/39–40 | PASS | 待网站审计 | checked+documented priors |
| MD-1.2-NewtonCompact | 18/41 | PASS | 待网站审计 | self-contained |
| MD-1.2-DegreesFreedom | 18/41 | PASS | 待网站审计 | self-contained |
| MD-1.2-ConstraintDimension | 18/41 | PASS | 待网站审计 | self-contained |
| MD-1.2-TotalEnergy | 18/41 | PASS | 待网站审计 | self-contained |
| MD-1.2-PairCancellation | 19/42 | PASS | 待网站审计 | self-contained |
| MD-1.2-MomentumConservation | 19/42 | PASS | 待网站审计 | checked+documented priors |
| MD-1.2-HarmonicSolution | 19–20/42–43 | PASS | 待网站审计 | checked+documented priors |
| MD-1.2-ScalarMechanical | 20/43 | PASS | 待网站审计 | self-contained |
| MD-1.2-ScalarQuadrature | 20/43 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-1.2-UniformLJSystem | 21/44 | PASS | 待网站审计 | self-contained |
| MD-1.2-RadialLJForceLiteral | 21/44 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-1.2-LJCoordinateScaling | 21/44 | PASS | 待网站审计 | self-contained |
| MD-1.2-LJTimeScaling | 21–22/44–45 | PASS | 待网站审计 | incomplete |

## 需要导师判断的问题

- MD-1.5.3-Thm1.1：按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。
  用户范围31–32/54–55是背景跨度；定理与证明思路均仅32/55。
- MD-1.4-LegendreHamiltonian：M=-1,U=p=0时目标v²/2无界；字面可逆前提不足；配置相关一般矩阵不能由固定对角库推出。
  若只假设可逆，M=-1、p=0、U=0时目标=v²/2无上界；须确认同页凸性及p.23机械质量背景是否应并入假设。当前保留字面可逆陈述并标ERRATUM?，未静默加正定。
  现有定理仅固定正对角m；本条保留任意配置相关M(q)、上界、sup、精确达到条件、动量偏导和能量对应，不能直接调用旧定理覆盖。
- MD-1.1-HardSphere：原文standard rules含方向/法向冲量等未明说内容；当前关系保留不可穿透和两守恒量，但尚不能据此声称完整散射模型。
- MD-1.1.1-MorseMinimum：已保留最小值和井深；原文还提到a控制曲率，当前签名未含二阶导数，须补齐后进入证明。
- MD-1.1.1-LJRepulsion：数学极限对应原文论据；atoms remain well separated为定性模拟描述，须裁定是否作为严格无碰撞结论。
- MD-1.1.2-Yukawa：逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。
  原文κ称Debye length，但e^{-κr}的量纲通常对应逆长度；本定义保留字面公式。
- MD-1.2-ScalarQuadrature：旧库给定初值的真实局部quadrature已证；原文称V为x,ξ,η的smooth function，旧签名未包含联合参数光滑性。不可将点态初值解当完整参数化结论。
- MD-1.2-RadialLJForceLiteral：保留两条印刷等式，但由负梯度Newton不能推出；须导师裁定勘误，当前不证明假陈述。
  首个等式缺负号；所印次行实际为势的正梯度，不同于此前Newton负梯度。

## 1. MD-1.5.3-Thm1.1 · Theorem 1.1 · 印刷p.32 / PDFp.55

### 2. 原文陈述

> If $\boldsymbol{q}^*$ is a strong local minimum of smooth potential $U$ then $\boldsymbol{z}^*=(\boldsymbol{q}^*,0)$ is stable.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原文只有以下证明思路并指向[216]，无完整证明；不把思路冒充原文证明。

原文证明思路：

> The proof of this theorem relies on showing that if trajectories are started from a point sufficiently close to $\boldsymbol{z}^*$ they cannot wander away to infinity. Although the result holds in greater generality, it is easy to show under assumptions of local smoothness of $U$ (which we are normally happy to make in molecular dynamics). For more discussion see the text [216].

### 4. Lean陈述

```lean
theorem theorem_1_1 {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
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
| 原书疑点 | 用户范围31–32/54–55是背景跨度；定理与证明思路均仅32/55。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**PASS**。按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：`Blueprint/Ch01.lean:63`（`MD.Ch01.theorem_1_1`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_smooth。

签名SHA256：`05ed1f54ee881d97a6b9acb5ecb6908b9eb7b5aed6f08b62e4b073d8db1e2e44`；原文SHA256：`15c882d153436a4622fba98867b6fada60a25b60c46ed413654ae763c1a28a12`。

## 1. MD-1.2-EnergyConservation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> Along the solutions of (1.3), the energy is conserved, since its derivative vanishes:

### 3. 原文证明

> \[\frac{\mathrm{d}}{\mathrm{d}t}E=\sum_{j=1}^{N}m_j\dot{\boldsymbol{q}}_j\cdot\ddot{\boldsymbol{q}}_j+\sum_{j=1}^{N}\frac{\partial U}{\partial\boldsymbol{q}_j}\cdot\dot{\boldsymbol{q}}_j=\sum_{j=1}^{N}\left(m_j\ddot{\boldsymbol{q}}_j+\frac{\partial U}{\partial\boldsymbol{q}_j}\right)\cdot\dot{\boldsymbol{q}}_j=0.\]

原文紧接陈述给出完整导数计算；PDF字体记录确认能量函数为数学斜体E。

### 4. Lean陈述

```lean
theorem energy_conservation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (q : ℝ → Position n)
    (hm : ∀ i, 0 < m i) (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x)
    (hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q) :
    (∀ t ∈ Ioo a b, HasDerivAt
      (fun s => nBodyTotalEnergy m U (q s) (deriv q s)) 0 t) ∧
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b,
      nBodyTotalEnergy m U (q s) (deriv q s) =
      nBodyTotalEnergy m U (q t) (deriv q t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 式(1.3) Newton解；每坐标M q̈=-∇U | hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q | 一致；真实一阶/二阶导数和位置留在Q；不把守恒作假设 |
| 粒子/坐标质量、位置、速度 | m : CoordinateMasses n；q与deriv q | 一致的展平坐标模型；任意对角质量推广待审 |
| 质量正性 | hm : ∀i,0<m i | [EXTRA] 逆质量辅助重写；可考虑直接牛顿证明是否能减少此额外前提 |
| 势能偏导/链式法则 | hU : ∀x∈Q,DifferentiableAt ℝ U x | [EXTRA] 原文导数计算的隐含前提 |
| 解的存在时间和任意比较时间 | Ioo a b；∀s∈Ioo a b，∀t∈Ioo a b | [EXTRA] 显式开连通区间；仅在同一解区间内比较 |
| 式(1.4)位置-速度总能量 | nBodyTotalEnergy m U (q t) (deriv q t) | 一致；使用massHamiltonian_massOperator证明两种表示相同 |
| its derivative vanishes；dE/dt=0 | ∀t∈Ioo a b,HasDerivAt (fun s=>nBodyTotalEnergy ...) 0 t | 一致；实际导数为零 |
| the energy is conserved | ∀s,t在区间内，nBodyTotalEnergy(s)=nBodyTotalEnergy(t) | 一致；完整守恒子句 |

### 6. 审计结论

本地预审：**PASS**。按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：`Blueprint/Ch01.lean:81`（`MD.Ch01.energy_conservation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics.mechanical_energy_hasDerivAt_zero; MolecularDynamics.mechanical_energy_const_on_Ioo; MolecularDynamics.massHamiltonian_massOperator; MolecularDynamics.newtonTrajectory_to_mechanicalSolution。

签名SHA256：`f127edcebe32563ae5ff4f88df5cda69ff6ede9ecfe10bed2ee5a4dd7dc9051e`；原文SHA256：`602eec4ec54600d2453b232c7f51b0ab138de3d3f56be31e060fb6e6d0aed2c5`。

## 1. MD-1.3-NewtonEulerLagrange · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> The equations of motion may be expressed in terms of the Lagrangian as:
> \[\frac{\mathrm{d}}{\mathrm{d}t}\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\frac{\partial L}{\partial\boldsymbol{q}}.\]
> (Note that this must be interpreted in general as a set of $N_c=3N$ equations, one for each atomic coordinate.)

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原文给出运动方程的等价表达，没有独立证明；下一段开始讨论坐标变换，不纳入本条。

### 4. Lean陈述

```lean
theorem newton_iff_euler_lagrange {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
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

### 6. 审计结论

本地预审：**PASS**。按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：`Blueprint/Ch01.lean:117`（`MD.Ch01.newton_iff_euler_lagrange`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics.mechanicalSolution_eulerLagrange; MolecularDynamics.eulerLagrange_to_mechanicalSolution; MolecularDynamics.newtonTrajectory_to_mechanicalSolution; MolecularDynamics.hasDerivAt_deriv_position; MolecularDynamics.solution_nBodyEquationAt。

签名SHA256：`27fd7e1251d62b07011dfeab02b981ad825d1b4c505a630e04a75d5f5eabaf9f`；原文SHA256：`1a2246dbfd6de1a5d68c368c83933fd807672cc490097359d2afea3f40aaf4e8`。

## 1. MD-1.4-LegendreHamiltonian · unnumbered_claim · 印刷p.24 / PDFp.47

### 2. 原文陈述

> If $\boldsymbol{M}(\boldsymbol{q})$ is invertible, the supremum is achieved precisely when
> \[\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p},\]
> which gives the standard definition of the momentum vector $\boldsymbol{p}$ in terms of velocities,
> \[\boldsymbol{p}=\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\boldsymbol{M}(\boldsymbol{q})\dot{\boldsymbol{q}},\]
> and, with $\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p}$, the Legendre transformation results in a new function
> \[H(\boldsymbol{q},\boldsymbol{p})\stackrel{\mathrm{def}}{=}\boldsymbol{p}^TM(\boldsymbol{q})^{-1}\boldsymbol{p}/2+U(\boldsymbol{q}).\]
> This is precisely the energy function, written in terms of positions and momenta.

### 3. 原文证明

> In the case of the Lagrangian $L(\boldsymbol{q},\boldsymbol{v})=\boldsymbol{v}^TM(\boldsymbol{q})\boldsymbol{v}/2-U(\boldsymbol{q})$ (which we have seen is the formulation of a mechanical system in generalized coordinates) we find
> \[\sup_{\boldsymbol{v}}(\boldsymbol{p}^T\boldsymbol{v}-(\boldsymbol{v}^TM(\boldsymbol{q})\boldsymbol{v}/2-U(\boldsymbol{q})))=\sup_{\boldsymbol{v}}(\boldsymbol{p}^T\boldsymbol{v}-\boldsymbol{v}^TM(\boldsymbol{q})\boldsymbol{v}/2)+U(\boldsymbol{q}).\]

仅有上述代数推导；原文没有证明“可逆即达到上确界”或唯一性。

### 4. Lean陈述

```lean
theorem hamiltonian_legendre_transform {n : ℕ}
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

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
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
| 原书疑点 | 若只假设可逆，M=-1、p=0、U=0时目标=v²/2无上界；须确认同页凸性及p.23机械质量背景是否应并入假设。当前保留字面可逆陈述并标ERRATUM?，未静默加正定。 | [ERRATUM?] |
| 原书疑点 | 现有定理仅固定正对角m；本条保留任意配置相关M(q)、上界、sup、精确达到条件、动量偏导和能量对应，不能直接调用旧定理覆盖。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。M=-1,U=p=0时目标v²/2无界；字面可逆前提不足；配置相关一般矩阵不能由固定对角库推出。

网站审计：**待网站审计**。原文JSON：NEEDS_HUMAN；未冻结。

反例：n=1,M=-1,U=0,p=0

建议：导师裁定是否继承凸性/对称正定背景；当前不静默添加。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：`Blueprint/Ch01.lean:156`（`MD.Ch01.hamiltonian_legendre_transform`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：含sorryAx。

缺失/继续路线：一般配置相关正定矩阵Legendre理论；原文字面前提疑点。

已登记前置证明/定义：MolecularDynamics.massHamiltonian_eq_legendre_sup; MolecularDynamics.legendre_objective_eq_massHamiltonian_iff。

签名SHA256：`2b468a3414ce493fbfab95cfca2a8569d174f3299324481d7e9a79a3444c27b5`；原文SHA256：`90466e97aa683c26b7f6b28282787edd8e31694292a61eae92dec3b5e0a55a00`。

## 1. MD-1.5.1-FlowInverse · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The classical systems treated here can be solved forward or backward in time. Observe that $\mathcal{F}_{-t}\mathcal{F}_t=\operatorname{Id}$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $t$ form an Abelian group under the operation of composition ($\mathcal{F}_t\mathcal{F}_s=\mathcal{F}_s\mathcal{F}_t=\mathcal{F}_{t+s}$).

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原文用Observe that直接断言；没有独立证明。随后Hamiltonian守恒属于另一个结论，不纳入本条。

### 4. Lean陈述

```lean
theorem flow_inverse {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
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

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
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

### 6. 审计结论

本地预审：**PASS**。按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：`Blueprint/Ch01.lean:183`（`MD.Ch01.flow_inverse`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics.globalMechanicalFlow_inverse; MolecularDynamics.globalMechanicalFlow_add; MolecularDynamics.globalMechanicalFlow_commute; MolecularDynamics.globalMechanicalFlow_bijOn。

签名SHA256：`0612c669694cac25394cc94c88490c2844c0ae68af39ec6306d4ab0952450ee4`；原文SHA256：`06763b993229b5b38845e23b63eb2ada6998e9c06565145ad521876f78a4a41a`。

## 1. MD-1.1-Schrodinger · definition · 印刷p.5 / PDFp.28

### 2. 原文陈述

> The Schrödinger equation itself is a partial differential equation of the following form:
> \[i\hbar\frac{\partial\Phi}{\partial t}=-\hbar^2\sum_{j=1}^{13}\frac{1}{2\mu_j}\left(\frac{\partial^2\Phi}{\partial q_{j,x}^2}+\frac{\partial^2\Phi}{\partial q_{j,y}^2}+\frac{\partial^2\Phi}{\partial q_{j,z}^2}\right)+U_P(q_{1,x},q_{1,y},\ldots,q_{13,z})\Phi.\tag{1.1}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.schrodingerEquation | 一致 |
| 原文未显式量化的技术资格 | Lean质量及Planck常数以正参数给定；定义采用总导数算子，仅定义满足方程的关系，不声明存在解。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:210`（`MD.Ch01.schrodingerEquation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`a456719f3292ddf1c142e744f5f952be92a79aaa449e8eadf079382fe75f64a4`；原文SHA256：`4f1477c2e45fb4684278e4cd3632ba088f0f85bc88a68ec0eadb598073bcf5c5`。

## 1. MD-1.1-NewtonModel · definition · 印刷p.6 / PDFp.29

### 2. 原文陈述

> where the forces are determined from the potential energy function $U$. Denoting the coordinates of the $i$th nucleus of an N-atom system by $q_{i,x},q_{i,y},q_{i,z}$, and the atomic mass by $m_i$, the equations of motion for the nucleus can be written out as
> \[m_i\frac{\mathrm d^2q_{i,x}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,x}},\qquad m_i\frac{\mathrm d^2q_{i,y}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,y}},\qquad m_i\frac{\mathrm d^2q_{i,z}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,z}}.\tag{1.2}\]
> It is important to recognize that (1.2) does not, itself, give a complete description of the motion; it must be supplemented by initial conditions (positions and velocities given at some specified instant) for all atoms.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def newtonInitialValueModel {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) (t₀ : ℝ)
    (q₀ v₀ : Position n) : Prop :=
  IsNewtonTrajectoryOn m U Q I q ∧ q t₀ = q₀ ∧ HasDerivAt q v₀ t₀
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.newtonInitialValueModel | 一致 |
| 原文未显式量化的技术资格 | n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:221`（`MD.Ch01.newtonInitialValueModel`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`d9dbd769b70a2b8e1c1c617900ecef552e578fb31728e25f8e77274c18ffb5bc`；原文SHA256：`b6f92f95a5c4d8bad137ef9b1bf7c10f8c2829d4aa33e8a31b14f812217fe82c`。

## 1. MD-1.1-HardSphere · definition · 印刷p.7 / PDFp.30

### 2. 原文陈述

> The simplest model for a molecular interaction potential is the hard-sphere model. We assume that each atom is an impenetrable sphere which interacts with other atoms via perfectly elastic collision with the atoms transferring, according to standard rules, momentum and energy to one another during the collisions.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def hardSphereModel (R₁ R₂ m₁ m₂ : ℝ) (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  0 < R₁ ∧ 0 < R₂ ∧ 0 < m₁ ∧ 0 < m₂ ∧ R₁ + R₂ ≤ dist q₁ q₂ ∧
  (dist q₁ q₂ = R₁ + R₂ →
    m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
    m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 = m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.hardSphereModel | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。 | [EXTRA] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。原文standard rules含方向/法向冲量等未明说内容；当前关系保留不可穿透和两守恒量，但尚不能据此声称完整散射模型。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:230`（`MD.Ch01.hardSphereModel`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`1f6689f4c2c087032feceecd82cc53be990cb04e410dd7fd3b3de224db92185f`；原文SHA256：`15730fb9a4bf36a0a92a8cac7cafe9f5aef2ef273a48307e2738b8dae3fcd89a`。

## 1. MD-1.1.1-Multibody · definition · 印刷p.8 / PDFp.31

### 2. 原文陈述

> In the most common situations, the potential energy function consists of a sum of 2-body, 3-body and/or 4-body terms,
> \[U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\qquad U_{ijk}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k),\qquad U_{ijkl}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k,\boldsymbol q_l),\]
> where $\boldsymbol q_i$ is the position vector of atom $i$ such that $(q_{i,x},q_{i,y},q_{i,z})=\boldsymbol q_i\in\mathbb R^3$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def multibodyPotential {N : ℕ} (U₂ : Fin N → Fin N → V3 → V3 → ℝ)
    (U₃ : Fin N → Fin N → Fin N → V3 → V3 → V3 → ℝ)
    (U₄ : Fin N → Fin N → Fin N → Fin N → V3 → V3 → V3 → V3 → ℝ)
    (q : Fin N → V3) : ℝ :=
  (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, ∑ l ∈ Finset.Ioi k,
    U₄ i j k l (q i) (q j) (q k) (q l))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.multibodyPotential | 一致 |
| 原文未显式量化的技术资格 | 按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:240`（`MD.Ch01.multibodyPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`14a629971804bc42ff3c6e5d969ff08795c915c3ce9f86db6b1754bc3a299965`；原文SHA256：`a8936eba6c279b25597c34ec454fe8cd4802cf9a2e2895d10442f6fe12813c23`。

## 1. MD-1.1.1-Morse · definition · 印刷p.8 / PDFp.31

### 2. 原文陈述

> A simple potential energy function whose graph can be used to approximate the potential energy of bond dissociation is the Morse potential
> \[\varphi_{\mathrm{Morse}}(r)=D\left(1-e^{-a(r-r_e)}\right)^2.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.morsePotential | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:253`（`MD.Ch01.morsePotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`69f3f1b2e57792d4b8e571938af9ac343007494a69e059c2f3cc842bbb78d7ee`；原文SHA256：`521c2cca4e8b4677b92253c740cc5756eb972b75d7b0b66e68fb32fe15dd17c4`。

## 1. MD-1.1.1-MorseMinimum · unnumbered_claim · 印刷p.8 / PDFp.31

### 2. 原文陈述

> (See Fig. 1.5.) $r_e$ is the location of the minimum, $D$ gives the well depth, and $a$ is a shape parameter that can be used to control the curvature at the minimum.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem morse_minimum :
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.morse_minimum | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | D,a,rₑ正；well depth解释为无穷远极限减最小值。 | [EXTRA] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。已保留最小值和井深；原文还提到a控制曲率，当前签名未含二阶导数，须补齐后进入证明。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

建议：指数无穷远极限及严格最小值/曲率完整对应待补。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：`Blueprint/Ch01.lean:259`（`MD.Ch01.morse_minimum`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：含sorryAx。

缺失/继续路线：指数无穷远极限及严格最小值/曲率完整对应待补。

签名SHA256：`a2294a6a45e9a7419e8bc86a142c5794a2076af2071ef4e6e45902d1520bfdf2`；原文SHA256：`8b248ac897fa3fa116d9eb706c9c924fe362dfec4adc5acb734fa68b8edadb81`。

## 1. MD-1.1.1-LengthBond · definition · 印刷p.9 / PDFp.32

### 2. 原文陈述

> Because they often do not need to be allowed to break during simulation and are very strong compared to the other potential terms, chemical bonds such as the covalent $\mathrm H_2^+$ bond described above are sometimes treated as springs with given rest-length:
> \[\varphi_{ij}^{\mathrm{len}}(r_{ij})=\frac{k_{ij}^{\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\qquad r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def lengthBond (k r₀ r : ℝ) := k / 2 * (r-r₀)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.lengthBond | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:269`（`MD.Ch01.lengthBond`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`6dc1cbf5f5331ae35834577db64838fabe6be0c8deaf6bb503c58008f65890c6`；原文SHA256：`b1b953df47ebd7a1a71f2ef52caeb2c7a3823a5f2a5b8c3525ca131cd7ee153d`。

## 1. MD-1.1.1-Dispersion · definition · 印刷p.10 / PDFp.33

### 2. 原文陈述

> This leads to an instantaneous polarization and an attractive interaction termed London dispersion; it is most often modelled using an inverse sixth power potential:
> \[\varphi_{\mathrm{disp}}(r)\sim-\frac K{r^6},\qquad K>0.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def dispersionPotential (K r : ℝ) := -K / r^6
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.dispersionPotential | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:275`（`MD.Ch01.dispersionPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`919b6add4a110f807000c50b2d29b67741b31fdee6b861ddc391f93f7faf2f43`；原文SHA256：`59d61780210b32f0ae95c5158a004c36baaa02652b53a0c3e00684d7bbadd4e9`。

## 1. MD-1.1.1-Buckingham · definition · 印刷p.10 / PDFp.33

### 2. 原文陈述

> Buckingham [56] suggested a combined potential of the form
> \[\varphi_B(r)=Ae^{-Br}-\frac C{r^6},\qquad A>0,\ B>0,\ C>0.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def buckinghamPotential (A B C r : ℝ) := A * Real.exp (-B*r) - C/r^6
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.buckinghamPotential | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:281`（`MD.Ch01.buckinghamPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`fe661b6bad850b9c0dd6b801add0345ee27c838ce6578d471ba4e72edf28cf71`；原文SHA256：`0429119ce7ea0c140cfc1ff4492959eeb263aec07f2cc7e8a1375e553fdb8462`。

## 1. MD-1.1.1-LennardJones · definition · 印刷p.10 / PDFp.33

### 2. 原文陈述

> A more common choice in simulation is the Lennard-Jones (6–12) potential
> \[\varphi_{\mathrm{LJ}}(r)=4\epsilon\left[\left(\frac\sigma r\right)^{12}-\left(\frac\sigma r\right)^6\right].\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.lennardJonesPotential | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:287`（`MD.Ch01.lennardJonesPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`c59ecc0fa91ade5d874e80ef3f97928193bd26f8212127cea8b0cc3d03d4a91b`；原文SHA256：`93565783f8049e53567171ecf451d83bd742ba2a3494d8d45844b5d9b226f106`。

## 1. MD-1.1.1-LJRepulsion · unnumbered_claim · 印刷p.11 / PDFp.34

### 2. 原文陈述

> of short-ranged soft walls in molecular dynamics, i.e., the fact that $\varphi_{\mathrm{LJ}}$ tends rapidly to positive infinity as $r\to0$, the atoms remain well separated in long simulations. The singularity at $r=0$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem lj_repulsion :
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.lj_repulsion | NEEDS_HUMAN |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。数学极限对应原文论据；atoms remain well separated为定性模拟描述，须裁定是否作为严格无碰撞结论。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

建议：忠实范围待裁定；单侧有理函数极限可另行短证明。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：`Blueprint/Ch01.lean:293`（`MD.Ch01.lj_repulsion`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：含sorryAx。

缺失/继续路线：忠实范围待裁定；单侧有理函数极限可另行短证明。

签名SHA256：`a54df37fd50ba09697d5aeb8f871996449b24346498eae4238ec618f30fb6144`；原文SHA256：`e1c76613f863dfbd8a0765e73b8a7918e4050fb640b2b37dd8a66dda59050fe6`。

## 1. MD-1.1.1-HeterogeneousLJ · definition · 印刷p.11 / PDFp.34

### 2. 原文陈述

> When there are many atoms of different types, the parameters of the potential will depend on this, so we obtain contributions to the total potential energy of the form
> \[\varphi_{ij}^{\mathrm{LJ}}(r_{ij})=4\epsilon_{ij}\left[\left(\frac{\sigma_{ij}}{r_{ij}}\right)^{12}-\left(\frac{\sigma_{ij}}{r_{ij}}\right)^6\right],\]
> where $r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.heterogeneousLJ | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:302`（`MD.Ch01.heterogeneousLJ`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`52b91099ddd48b107a2b6e520de963b729bc69c43867ef7de9a64c6c104bb125`；原文SHA256：`e24cbaf865c2e7d34c0ff16ef534a6d872225dc62539851a1ae3efb243732098`。

## 1. MD-1.1.2-Coulomb · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> When, as in the case of the alanine dipeptide, net charges are present on the atoms, one may model this by means of Coulomb potentials:
> \[\varphi_{ij}^{\mathrm{Coulomb}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}},\]
> where $\epsilon>0$ is the dielectric constant, and $Q_i,Q_j$ are the charges on atoms $i$ and $j$, respectively. $C$ is a positive coefficient allowing the adjustment of units. Obviously the effect of the Coulombic potential depends strongly on whether the atoms have the same or oppositely signed charges.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def coulombPotential (C Qᵢ Qⱼ dielectric r : ℝ) := C*Qᵢ*Qⱼ/(dielectric*r)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.coulombPotential | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:310`（`MD.Ch01.coulombPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`c99bf55a6e57b945f6a8e304f44b235c6cf0a763db160d917d8a8cab01f7f35c`；原文SHA256：`17a48d1304dbfd41c3acd67d439d976322d81fe04d2df908c31cda98a206cb07`。

## 1. MD-1.1.2-Cutoff · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> In the simplest treatments, the Coulomb potential is simply cut off at distance $r_{\mathrm{cut}}$, i.e., is taken to be zero for $r>r_{\mathrm{cut}}$. This should be done in such a way that the potential remains at least continuously differentiable, preferably smoother (see Exercise 11).

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  ContDiff ℝ 1 φ ∧ ∀ r, r_cut < r → φ r = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.smoothCutoff | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:316`（`MD.Ch01.smoothCutoff`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`126ddf4c90c49f42cef51a781adcf940e4c1d22e13be9be5cc2146c0d61e5236`；原文SHA256：`ee199023ee64cebfab9e468ab08afd73ce51b86fd32f51b22eeb4e0db5852869`。

## 1. MD-1.1.2-Yukawa · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $\kappa$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:
> \[\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def yukawaScreened (C Qᵢ Qⱼ dielectric κ r : ℝ) : ℝ :=
  C * Qᵢ * Qⱼ / (dielectric * r) * Real.exp (-κ * r)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.yukawaScreened | 一致 |
| 原书疑点 | 原文κ称Debye length，但e^{-κr}的量纲通常对应逆长度；本定义保留字面公式。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:323`（`MD.Ch01.yukawaScreened`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`2e3930687eb550ee87abfa8443816b2c0cfa18f7b4f0abe91f247ed90ec298a1`；原文SHA256：`06df6f7c0486e07622ed701a3b0df153efd2b87a687c85928914f3b3f192341b`。

## 1. MD-1.1.2-AngleBond · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> When a trio of atoms with labels $i,j,k$ and $k$ admits a pair of length bonds, say $(i,j)$ and $(j,k)$, then an additional three-body term will need to be incorporated:
> \[\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,\]
> where the angle $\theta_{ijk}$ is given in terms of the positions as
> \[\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.angleBondModel | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:330`（`MD.Ch01.angleBondModel`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`d27b7eed4005272ea7ad565b091134ab4cdae5f057ade28898476085cde62457`；原文SHA256：`7919a1ecd1cc07e9c3350f97cc06b2fab134c3389a3df90354ae730c7c9f3e0e`。

## 1. MD-1.1.2-Dihedral · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> Dihedral potentials typically are modelled using a trigonometric potential function, as
> \[\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.dihedralPotential | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:338`（`MD.Ch01.dihedralPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`e205c138e66f0f194f170f5ac749439eb113cf4628d6f9fb812cbb86faf67cd0`；原文SHA256：`c5c036e129e00df8f081c8f078c52daf089bdd6045d8d1b44579eeb20c47be5e`。

## 1. MD-1.1.2-GayBerne · Example 1.2 · 印刷p.16–17 / PDFp.39–40

### 2. 原文陈述

> The potential energy may be written as
> \[\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],\]
> \[\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),\]
> with
> \[\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\|\boldsymbol r\|-\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},\]
> \[\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),\]
> and
> \[W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].\]
> Finally
> \[\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.gayBerneModel | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项展开辅助定义核对所有8个公式；不复用旧gayBernePotential，其ε2平方与原页不一致。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:344`（`MD.Ch01.gayBerneModel`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：ReviewDefinitions.gayBerneChi/ChiPrime/W/EpsilonOne/EpsilonTwo。

签名SHA256：`d932c5f5ca37d31eaf3ae07646dc058b169b5e8645c47a77920d2e7317847dcf`；原文SHA256：`a1fa5496e18be16a688d2ac1dc52038d5f9048c62f93db463e5d1f423dc81424`。

## 1. MD-1.2-NewtonCompact · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> In this book, we shall frequently use a compact, vectorial notation, where $\boldsymbol q$ and $\dot{\boldsymbol q}$ represent vectors of the positions and velocities, and $\boldsymbol M$ is a diagonal mass matrix, so the equations of motion (1.2) become
> \[\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\tag{1.3}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.compactNewton | 一致 |
| 原文未显式量化的技术资格 | 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:360`（`MD.Ch01.compactNewton`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`8a151b6d08e1dcf54a81eb6e37cc4f5d4a0c70974fe14ed3a0068ed089894eb2`；原文SHA256：`2c58bec418d370cb580f152e6d73d0c95b9b64b9c451cdc7312073fe09ccbbd2`。

## 1. MD-1.2-DegreesFreedom · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $N_d$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.degreesOfFreedom | 一致 |
| 原文未显式量化的技术资格 | 在可微约束C局部正则层中以导数核维数表示；无约束取零约束。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:369`（`MD.Ch01.degreesOfFreedom`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`cc1528b64168788fe6cc74e5a01fd1a0eb941ca19a083e56410a22665a16e8aa`；原文SHA256：`0aca2e65ce359efe0eed00ab59969837857ad0eaa0738950506cb944d946e0f3`。

## 1. MD-1.2-ConstraintDimension · unnumbered_claim · 印刷p.18 / PDFp.41

### 2. 原文陈述

> For the N-body system in $\mathbb R^3$ without additional constraints there are $N_d=N_c=3N$ degrees of freedom. If $r$ independent constraints are present the number of degrees of freedom is $N_d=N_c-r$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem constraintdimension :
  ∀ (n r : ℕ) (C : Position n → Position r) (q : Position n),
    DifferentiableAt ℝ C q → Function.Surjective (fderiv ℝ C q) →
    degreesOfFreedom C q + r = n
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.constraintdimension | 一致 |
| 原文未显式量化的技术资格 | 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：`Blueprint/Ch01.lean:376`（`MD.Ch01.constraintdimension`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`36fd5fab4eec12dceb32579dd6e71c53ab91205e336ff309bcfde361b2d71fe5`；原文SHA256：`c54f4247a52caf810133885bb35ac9209f44cfd6fc44bb9bb2c07acd53a7d426`。

## 1. MD-1.2-TotalEnergy · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The total energy of the N-body system is a function of positions and velocities,
> \[E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\|\dot{\boldsymbol q}_j\|^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\tag{1.4}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.particleTotalEnergy | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:391`（`MD.Ch01.particleTotalEnergy`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`2a72404f4a7daaaaec384f15625586a8dd1eaf4db3a8703f5078972fc6be343a`；原文SHA256：`145f5fed7064fd4e41575396ecf3349f86583a04bb032ab2c9d1f71d7780f3e2`。

## 1. MD-1.2-PairCancellation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> This means that the sum of all the forces will vanish.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem paircancellation :
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.paircancellation | 一致 |
| 原文未显式量化的技术资格 | Fi i=0，内部两体力反对称；无外力。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：`Blueprint/Ch01.lean:398`（`MD.Ch01.paircancellation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`5f3cc22f225bd72c6107d3754e0fa2bd3b934d4d1ef1ca63cd4ad699e0f6c0e4`；原文SHA256：`cdddbe4e3d96549ac49b80a79d94d4df19c19d0c956deb193622cf30e6f83068`。

## 1. MD-1.2-MomentumConservation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> and thus the three components of the total momentum vector $\boldsymbol p_{\mathrm{tot}}:=\sum_{i=1}^{N}\boldsymbol p_i$ will be conserved quantities.

### 3. 原文证明

> Since
> \[\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\boldsymbol F_i,\]
> we have
> \[\sum_{i=1}^{N}\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\sum_{i=1}^{N}\boldsymbol F_i=0\]

按渲染原页逐字转录原文论证。

### 4. Lean陈述

```lean
theorem momentumconservation :
  ∀ {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.momentumconservation | 一致 |
| 原文未显式量化的技术资格 | 开放连通时间区间；净力为零来自前文内部力消去，此桥接显式采用净力条件。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：local_proof。

位置：`Blueprint/Ch01.lean:423`（`MD.Ch01.momentumconservation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics/Chapter01/MomentumConservation.lean:totalMomentumCoordinate_const_on_Ioo。

签名SHA256：`e489fdec326b26fc32fb8f2988d429805a517c80db434d98e790e24c39878d5d`；原文SHA256：`27cc4a7ca391817f1701cf884703fcc94ea8f7f6cdfd2ba508331c1566cd1bcd`。

## 1. MD-1.2-HarmonicSolution · unnumbered_claim · 印刷p.19–20 / PDFp.42–43

### 2. 原文陈述

> Example 1.3 (Harmonic Oscillator) Consider the system
> \[\dot x=v,\qquad\dot v=-\Omega^2x.\]
> This system describes the behavior of a particle with unit mass in one dimension, with energy function $E(x,\dot x)=\dot x^2/2+\Omega^2x^2/2$, where its motion is governed by a linear 2nd order equation $\ddot x+\Omega^2x=0$. The solution, for given $x(0)=\xi$, $\dot x(0)=v(0)=\eta$, is
> \[x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    ∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.harmonic_solution | 一致 |
| 原文未显式量化的技术资格 | Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：local_proof。

位置：`Blueprint/Ch01.lean:440`（`MD.Ch01.harmonic_solution`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics/Chapter01/HarmonicOscillator.lean:harmonicFlow_isMechanicalSolution。

签名SHA256：`5c422857804bd00c609a866f1999af61bce74ca798fd824794b6a186a234485a`；原文SHA256：`2d53f5bd6b89ec5d3f4c57ce2eed7e6a8cbcdd327eedee80c09e5fce6f1abffe`。

## 1. MD-1.2-ScalarMechanical · definition · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $m=1$ for simplicity) and energy function $E(x,\dot x)=\dot x^2/2+U(x)$ (which includes the harmonic oscillator as a special case). The equations of motion are
> \[\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, HasDerivAt z ((z t).2, -deriv U (z t).1) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.scalarMechanicalModel | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:451`（`MD.Ch01.scalarMechanicalModel`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`d577b1c49cbefd9974c120579caf6a2bf559987950854218d5e328d9cb5d2f23`；原文SHA256：`31033e79d31bd6e41aa8f56fcfd855d98be511c88e151ab3f58efaf4d782c57a`。

## 1. MD-1.2-ScalarQuadrature · unnumbered_claim · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Near this point, provided $\eta\ne0$, let us solve the equation $E(x,v)=E(\xi,\eta)$ for $v$ as a unique smooth function of $x,\xi,\eta$ using the implicit function theorem: $v=V(x,\xi,\eta)$. Inserting this into the differential equations we then find
> \[\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).\]
> This is a separable differential equation; it is therefore easily integrated from any provided initial value, $x(0)=\xi$, as a function of $t$, resulting in a relation $x=X(t,\xi,\eta)$. Then $v=V(X(t,\xi,\eta),\xi,\eta)$ and we see that it is possible to derive the formula for the solution $(x,v)$ as a function of $t$ and the initial conditions.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem scalarquadrature :
  ∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (z₀ : ℝ × ℝ) (t₀ : ℝ),
    ∃ (ε : ℝ) (γ : ℝ → ℝ × ℝ), 0 < ε ∧ γ t₀ = z₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), HasDerivAt γ (scalarPotentialVectorField U (γ t)) t) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), scalarPotentialEnergy U (γ t) = scalarPotentialEnergy U z₀) ∧
      ScalarPotentialLocalDescription U γ (t₀ - ε) (t₀ + ε) t₀
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.scalarquadrature | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | U C2满足局部隐函数/唯一性资格；局部时间窗；非转向分支对应原文η≠0，其余分支为额外加强。 | [EXTRA] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。旧库给定初值的真实局部quadrature已证；原文称V为x,ξ,η的smooth function，旧签名未包含联合参数光滑性。不可将点态初值解当完整参数化结论。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：local_proof。

位置：`Blueprint/Ch01.lean:458`（`MD.Ch01.scalarquadrature`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics/Chapter01/ScalarLocalIVP.lean:scalarPotential_exists_localIVP_integrable。

签名SHA256：`96e9442cb7b8f1ebca0b59c9863ae3ee6402c35f0b6c0a6f1709d51ceee4ae6d`；原文SHA256：`f94c950aa36d361f24b5637c0569fadf541ed9cc28978c437fc7c343ec60de1c`。

## 1. MD-1.2-UniformLJSystem · Example 1.5 · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The energy of the system is
> \[E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),\]
> where $r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$ and the mass $m$ of an argon atom is $6.69\times10^{-26}$ kg.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
def uniformLJSystem {N : ℕ} (m ε σ : ℝ) (q v : Fin N → V3) : ℝ :=
  (∑ i, m * ‖v i‖^2 / 2) + uniformLJEnergy ε σ q
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.uniformLJSystem | 一致 |

### 6. 审计结论

本地预审：**PASS**。逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：`Blueprint/Ch01.lean:471`（`MD.Ch01.uniformLJSystem`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`641c1d0411aadc0b3626ddbcb66f694076074b08516266c596507e95712b2427`；原文SHA256：`ff2d90fbf7398359e060c68af5b3a01609dfccbf99b17200723928a3374bb9b1`。

## 1. MD-1.2-RadialLJForceLiteral · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The equations of motion are, for $i=1,2,\ldots,N$, using the chain rule,
> \[m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j)
> =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](\boldsymbol q_i-\boldsymbol q_j).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.radial_lj_force_literal | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。 | [EXTRA] |
| 原书疑点 | 首个等式缺负号；所印次行实际为势的正梯度，不同于此前Newton负梯度。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。保留两条印刷等式，但由负梯度Newton不能推出；须导师裁定勘误，当前不证明假陈述。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：`Blueprint/Ch01.lean:478`（`MD.Ch01.radial_lj_force_literal`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：含sorryAx。

签名SHA256：`2ba089514613094c530f1baf44a9df9f2b048212d0ae1f0c1a6ec71ecd33934b`；原文SHA256：`5f65365eed81be1ca6040b2bb331ce93e5f7d65cdb19c47a380474f3d277e4c2`。

## 1. MD-1.2-LJCoordinateScaling · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> Now introduce the change of variables
> \[\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,\]
> then $\dot{\boldsymbol q}_i=\sigma\dot{\boldsymbol Q}_i$, $\ddot{\boldsymbol q}_i=\sigma\ddot{\boldsymbol Q}_i$, and $\|\boldsymbol q_i-\boldsymbol q_j\|=\sigma\|\boldsymbol Q_i-\boldsymbol Q_j\|$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem lj_coordinate_scaling (Q : ℝ → V3) (σ t : ℝ) (v a : V3)
    (hσ : 0 < σ) (hv : HasDerivAt Q v t) (ha : HasDerivAt (deriv Q) a t) :
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
    HasDerivAt (fun s => σ • deriv Q s) (σ • a) t ∧
    ∀ r s : V3, ‖σ • r - σ • s‖ = σ * ‖r-s‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.lj_coordinate_scaling | 一致 |
| 原文未显式量化的技术资格 | σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。实际导数缩放与全部距离缩放结论均已保留；σ正保证原文范数缩放不缺绝对值。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：`Blueprint/Ch01.lean:493`（`MD.Ch01.lj_coordinate_scaling`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`d073c5f6bc3743abc42e40d868513e00f94eeb4283caacadd8fdabe5a7e4de74`；原文SHA256：`e868dde0ca6520a43db580ceffecf77cb6e5c749998548b6f8f59d14b443d14e`。

## 1. MD-1.2-LJTimeScaling · unnumbered_claim · 印刷p.21–22 / PDFp.44–45

### 2. 原文陈述

> Thus we see that if we make the additional time transformation
> \[\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},\]
> then the equations become
> \[\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).\]
> This means that a natural choice for the unit of time is
> \[\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.\]
> By using the units given here, we may work with a simplified form of the Lennard-Jones system involving unit masses and a parameter-independent potential energy function.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书无独立完整证明。

### 4. Lean陈述

```lean
theorem ljtimescaling :
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    (((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)) ∧
    α⁻¹ = σ * Real.sqrt (m / ε)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原页完整公式/陈述 | MD.Ch01.ljtimescaling | 一致 |
| 原文未显式量化的技术资格 | m,ε,σ,α正；真实C2非碰撞轨迹。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。修正旧遗漏后，保留真实时间二阶缩放双向等价及单位时间α⁻¹=σ√(m/ε)；原文数值近似不作为形式化精度定理。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

建议：LJ导数、时间二阶链式法则及范数缩放组合，需补单位时间等式；大型缺失理论以外可分小批证明。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：`Blueprint/Ch01.lean:506`（`MD.Ch01.ljtimescaling`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：含sorryAx。

缺失/继续路线：LJ导数、时间二阶链式法则及范数缩放组合，需补单位时间等式；大型缺失理论以外可分小批证明。

签名SHA256：`d844f266c9dadfd3edc5fb0953420de365fb2b7bacc83eb96bb08b4ad7573d05`；原文SHA256：`97d79453a1e9c07581bf0341e0ed4909b56827662873635849b19b7666c20606`。
