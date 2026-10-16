# 第1章 Lean Blueprint 本地审阅材料

141条；网站PASS110、本地按意见修复10（未再送网站）、原书疑误待导师21。全部复审返回已登记；本轮不再送网站。完整检查见CLOSEOUT21/full/CHECK_REPORT.json。

## 1. MD-1.5.3-Thm1.1 · Theorem 1.1 · 印刷p.32 / PDFp.55

### 2. 原文陈述

> If $\boldsymbol{q}^*$ is a strong local minimum of smooth potential $U$ then $\boldsymbol{z}^*=(\boldsymbol{q}^*,0)$ is stable.

### 3. 原文证明

原书无独立完整证明。
原文只有以下证明思路并指向[216]，无完整证明；不把思路冒充原文证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem theorem_1_1 {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n)) := by
  exact strictPotentialMin_futureStableEuclidean_of_smooth m U Q q₀ hm hQ hU hstrict
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.theorem_1_1；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | hm: 每个固定对角质量正；来自§1.5正定背景，定理句未重复。 | [EXTRA] |
| 原文未显式量化的技术资格 | hQ: 势能位置域Q开放；局部ODE和极小值邻域须位于定义域。 | [EXTRA] |
| 原文未显式量化的技术资格 | hstrict包含q₀∈Q；补出原文默认的定义域资格。 | [EXTRA] |

[EXTRA] hm: 每个固定对角质量正；来自§1.5正定背景，定理句未重复。；hQ: 势能位置域Q开放；局部ODE和极小值邻域须位于定义域。；hstrict包含q₀∈Q；补出原文默认的定义域资格。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:111；MD.Ch01.theorem_1_1。

## 1. MD-1.2-EnergyConservation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> Along the solutions of (1.3), the energy is conserved, since its derivative vanishes:

### 3. 原文证明

> \[\frac{\mathrm{d}}{\mathrm{d}t}E=\sum_{j=1}^{N}m_j\dot{\boldsymbol{q}}_j\cdot\ddot{\boldsymbol{q}}_j+\sum_{j=1}^{N}\frac{\partial U}{\partial\boldsymbol{q}_j}\cdot\dot{\boldsymbol{q}}_j=\sum_{j=1}^{N}\left(m_j\ddot{\boldsymbol{q}}_j+\frac{\partial U}{\partial\boldsymbol{q}_j}\right)\cdot\dot{\boldsymbol{q}}_j=0.\]
原文紧接陈述给出完整导数计算；PDF字体记录确认能量函数为数学斜体E。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem energy_conservation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (q : ℝ → Position n)
    (hm : ∀ i, 0 < m i) (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x)
    (hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q) :
    (∀ t ∈ Ioo a b, HasDerivAt
      (fun s => nBodyTotalEnergy m U (q s) (deriv q s)) 0 t) ∧
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b,
      nBodyTotalEnergy m U (q s) (deriv q s) =
      nBodyTotalEnergy m U (q t) (deriv q t) := by
  have hγ : IsMechanicalSolutionOn m (fun x => -gradient U x) Q (Ioo a b)
      (fun t => (q t, massOperator m (deriv q t))) := by
    apply newtonTrajectory_to_mechanicalSolution m (fun x => -gradient U x) Q
      (Ioo a b) q (deriv q) (deriv (deriv q)) hm hq.1
    intro t ht
    refine ⟨(hq.2 t ht).1, (hq.2 t ht).2.1, ?_⟩
    ext i
    exact congrArg (fun v : Position n => v i) ((hq.2 t ht).2.2)
  constructor
  · intro t ht
    simpa only [massHamiltonian_massOperator] using
      mechanical_energy_hasDerivAt_zero m (fun x => -gradient U x) U Q (Ioo a b)
        (fun t => (q t, massOperator m (deriv q t))) hm isOpen_Ioo hγ hU
        (fun _ _ => rfl) t ht
  · intro s hs t ht
    simpa only [massHamiltonian_massOperator] using
      mechanical_energy_const_on_Ioo m (fun x => -gradient U x) U Q a b
        (fun t => (q t, massOperator m (deriv q t))) hm hγ hU
        (fun _ _ => rfl) s t hs ht
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energy_conservation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | hm: 固定对角质量正；牛顿相空间重写使用逆质量。 | [EXTRA] |
| 原文未显式量化的技术资格 | hU: U在Q每点可微；保证原文链式法则有意义。 | [EXTRA] |
| 原文未显式量化的技术资格 | 时间取开连通区间Ioo a b；能量比较仅对s,t属于该区间，不作越过解存在区间的结论。 | [EXTRA] |

[EXTRA] hm: 固定对角质量正；牛顿相空间重写使用逆质量。；hU: U在Q每点可微；保证原文链式法则有意义。；时间取开连通区间Ioo a b；能量比较仅对s,t属于该区间，不作越过解存在区间的结论。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:129；MD.Ch01.energy_conservation。

## 1. MD-1.3-NewtonEulerLagrange · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> The equations of motion may be expressed in terms of the Lagrangian as:
> \[\frac{\mathrm{d}}{\mathrm{d}t}\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\frac{\partial L}{\partial\boldsymbol{q}}.\]
> (Note that this must be interpreted in general as a set of $N_c=3N$ equations, one for each atomic coordinate.)

### 3. 原文证明

原书无独立完整证明。
原文给出运动方程的等价表达，没有独立证明；下一段开始讨论坐标变换，不纳入本条。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem newton_iff_euler_lagrange {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q := by
  constructor
  · intro hq
    have hγ : IsMechanicalSolutionOn m (fun x => -gradient U x) Q I
        (fun t => (q t, massOperator m (deriv q t))) := by
      apply newtonTrajectory_to_mechanicalSolution m (fun x => -gradient U x) Q I
        q (deriv q) (deriv (deriv q)) hm hq.1
      intro t ht
      refine ⟨(hq.2 t ht).1, (hq.2 t ht).2.1, ?_⟩
      ext i
      exact congrArg (fun v : Position n => v i) ((hq.2 t ht).2.2)
    exact mechanicalSolution_eulerLagrange m U Q I _ hm hI hγ hU
  · intro hq
    have hγ := eulerLagrange_to_mechanicalSolution m U Q I q hm hq hU
    refine ⟨hq.1, ?_⟩
    intro t ht
    refine ⟨(hq.2 t ht).1, ?_, ?_⟩
    · have hacc := hasDerivAt_deriv_position m (fun x => -gradient U x) Q I
        (fun t => (q t, massOperator m (deriv q t))) hI hγ t ht
      simpa only [hacc.deriv] using hacc
    · have hnewton := solution_nBodyEquationAt m (fun x => -gradient U x) U Q I
        (fun t => (q t, massOperator m (deriv q t))) hm hI hγ (fun _ _ => rfl) t ht
      ext i
      exact congrFun hnewton.1 i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.newton_iff_euler_lagrange；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\frac{\mathrm{d}}{\mathrm{d}t}\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\frac{\partial L}{\partial\boldsymbol{q}}.\] | MD.Ch01.newton_iff_euler_lagrange，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | hm: 每个固定对角质量正；用于从相空间方程回到牛顿方程。 | [EXTRA] |
| 原文未显式量化的技术资格 | hI: 时间域开放；把within导数还原为原文双侧时间导数。 | [EXTRA] |
| 原文未显式量化的技术资格 | hU: U在Q可微；保证位置偏导是实际导数。 | [EXTRA] |

[EXTRA] hm: 每个固定对角质量正；用于从相空间方程回到牛顿方程。；hI: 时间域开放；把within导数还原为原文双侧时间导数。；hU: U在Q可微；保证位置偏导是实际导数。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:165；MD.Ch01.newton_iff_euler_lagrange。

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

原书无独立完整证明。
原文仅展示将U(q)从上确界中移出的代数恒等式，未独立证明上界、达到条件及唯一性；该段原文完整保存于proof_discussion_latex。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamiltonian_legendre_transform {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q))
    (hPositive : (M q).PosDef) :
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
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry

/-- 修正版，对应原文 MD-1.4-LegendreHamiltonian，改动：新增仅可逆的原文字面版；修正版继承正定质量背景并保留上界、精确上确界、唯一达到点、动量梯度与能量全部结论。 -/
theorem hamiltonian_legendre_transform_literal {n : ℕ}
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
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry

/-- 修正版，对应原文 MD-1.4-LegendreHamiltonian，改动：显式继承对称正定机械质量背景。 -/
theorem hamiltonian_legendre_transform_corrected {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q))
    (hPositive : (M q).PosDef) :
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
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamiltonian_legendre_transform；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| \[\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p},\]；\[\boldsymbol{p}=\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\boldsymbol{M}(\boldsymbol{q})\dot{\boldsymbol{q}},\]；\[H(\boldsymbol{q},\boldsymbol{p})\stackrel{\mathrm{def}}{=}\boldsymbol{p}^TM(\boldsymbol{q})^{-1}\boldsymbol{p}/2+U(\boldsymbol{q}).\] | MD.Ch01.hamiltonian_legendre_transform，完整展开陈述见上一行及第4段 | NEEDS_HUMAN |

[EXTRA] [EXTRA] hPositive : (M q).PosDef；展开p23正物理质量及满秩Jacobian继承的对称正定背景，任意可逆矩阵反例不属于此子类。字面可逆原句保留，配置相关M及全部六项结论不变。

### 6. 审计结论

任意可逆矩阵不足以保证凹二次目标有最大值；需继承机械质量的对称正定背景。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
逐项核对任意 n、配置相关 M、实值 U、q/p、IsUnit 和 PosDef。主声明及 _corrected：PASS，六项依次给有上界、sup=H、唯一达到点、全部速度处真实梯度 Mv、逆变换动量、能量对应；PosDef 含实对称性，是合理且已披露的机械背景补充。_literal：字面忠实性 PASS，仅可逆原句及其全部意涵被保留；数学有效性有原书疑误，不能作为任意可逆矩阵定理采信。没有把 sorry 当作失败依据。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:206；MD.Ch01.hamiltonian_legendre_transform。

## 1. MD-1.5.1-FlowInverse · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The classical systems treated here can be solved forward or backward in time. Observe that $\mathcal{F}_{-t}\mathcal{F}_t=\operatorname{Id}$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $t$ form an Abelian group under the operation of composition ($\mathcal{F}_t\mathcal{F}_s=\mathcal{F}_s\mathcal{F}_t=\mathcal{F}_{t+s}$).

### 3. 原文证明

原书无独立完整证明。
原文用Observe that直接断言；没有独立证明。随后Hamiltonian守恒属于另一个结论，不纳入本条。

### 4. 完整当前Lean（原文与修正版独立列出）

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
      ψ t (ψ s z) = ψ s (ψ t z) ∧ ψ t (ψ s z) = ψ (t + s) z := by
  refine ⟨fun z hz => (hψ.1 z hz).2, ?_, ?_, ?_⟩
  · intro t z hz
    exact ⟨globalMechanicalFlow_inverse hψ hreg hz t,
      by simpa only [neg_neg] using globalMechanicalFlow_inverse hψ hreg hz (-t)⟩
  · intro t
    exact globalMechanicalFlow_bijOn hψ hreg t
  · intro s t z hz
    exact ⟨globalMechanicalFlow_commute hψ hreg hz s t,
      (globalMechanicalFlow_add hψ hreg hz s t).symm⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flow_inverse；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | hψ: 显式全实时间解及S不变，落实正文双向可解和flow map前提；本条不证明全局流存在。 | [EXTRA] |
| 原文未显式量化的技术资格 | hreg: F在Q为C¹，用于ODE唯一性，落实正文继承的存在唯一性前提。 | [EXTRA] |
| 原文未显式量化的技术资格 | _hm: 正固定质量，使对象限于原文分子Hamiltonian系统。 | [EXTRA] |

[EXTRA] hψ: 显式全实时间解及S不变，落实正文双向可解和flow map前提；本条不证明全局流存在。；hreg: F在Q为C¹，用于ODE唯一性，落实正文继承的存在唯一性前提。；_hm: 正固定质量，使对象限于原文分子Hamiltonian系统。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:271；MD.Ch01.flow_inverse。

## 1. MD-1.1-Schrodinger · definition · 印刷p.5 / PDFp.28

### 2. 原文陈述

> The Schrödinger equation itself is a partial differential equation of the following form:
> \[i\hbar\frac{\partial\Phi}{\partial t}=-\hbar^2\sum_{j=1}^{13}\frac{1}{2\mu_j}\left(\frac{\partial^2\Phi}{\partial q_{j,x}^2}+\frac{\partial^2\Phi}{\partial q_{j,y}^2}+\frac{\partial^2\Phi}{\partial q_{j,z}^2}\right)+U_P(q_{1,x},q_{1,y},\ldots,q_{13,z})\Phi.\tag{1.1}\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  (∀ q, ContDiff ℝ 1 (fun t => Φ t q)) ∧
  (∀ t q (i : Fin 39), ContDiff ℝ 2 (fun s : ℝ => Φ t (q + s • coordinateDirection i))) ∧
  Continuous (fun tq : ℝ × Q13 => deriv (fun t => Φ t tq.2) tq.1) ∧
  (∀ i, Continuous (fun tq : ℝ × Q13 => secondPartial (Φ tq.1) tq.2 i)) ∧
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.schrodingerEquation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[i\hbar\frac{\partial\Phi}{\partial t}=-\hbar^2\sum_{j=1}^{13}\frac{1}{2\mu_j}\left(\frac{\partial^2\Phi}{\partial q_{j,x}^2}+\frac{\partial^2\Phi}{\partial q_{j,y}^2}+\frac{\partial^2\Phi}{\partial q_{j,z}^2}\right)+U_P(q_{1,x},q_{1,y},\ldots,q_{13,z})\Phi.\tag{1.1}\] | MD.Ch01.schrodingerEquation，完整展开陈述见上一行及第4段 | 一致 |
| 13粒子的3分量二阶偏导与质量权重 | Fin 39; μ ⟨i.val / 3, …⟩; secondPartial (Φ t) q i / (2 * μᵢ) | 一致 |
| 时间导数与势项 | Complex.I * h * deriv (fun s => Φ s q) t; (U q : ℂ) * Φ t q | 一致 |
| 原文未显式量化的技术资格 | 正质量及正Planck参数；按经典解解释，Φ在时间/位置联合C2，保证总导数算子表示实际偏导数；不声明解存在。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.schrodingerEquation | 按EAUDIT02新返回，将联合全域C²改为连续时间一阶/逐空间坐标二阶经典导数；不要求二阶时间或混合偏导。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.schrodingerEquation | 按EAUDIT02新返回，将联合全域C²改为连续时间一阶/逐空间坐标二阶经典导数；不要求二阶时间或混合偏导。 |

[EXTRA] 正质量及正Planck参数；按经典解解释，Φ在时间/位置联合C2，保证总导数算子表示实际偏导数；不声明解存在。；[EXTRA] 19号：按EAUDIT02新返回，将联合全域C²改为连续时间一阶/逐空间坐标二阶经典导数；不要求二阶时间或混合偏导。

### 6. 审计结论

19号本地签名预审：按EAUDIT02新返回，将联合全域C²改为连续时间一阶/逐空间坐标二阶经典导数；不要求二阶时间或混合偏导。

网站：网站PASS（EAUDIT复审）。
PASS。Q13=EuclideanSpace ℝ (Fin 39)，Φ:ℝ→Q13→ℂ，U为实势；h与13个μ均为正子类型。coordinateDirection是标准坐标向量，secondPartial是在该坐标直线上的二阶实导数；Fin 39索引i经i.val/3取粒子质量，恰好每质量重复三次。时间C¹、每空间坐标C²、时间一阶与空间二阶导数的联合连续性明确保证经典偏导解释，不要求时间二阶或混合偏导。末项与全部t,q的方程逐项相符；没有解存在断言。最新[EXTRA]与签名相符，旧的联合C²文字应标历史。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:298；MD.Ch01.schrodingerEquation。

## 1. MD-1.1-NewtonModel · definition · 印刷p.6 / PDFp.29

### 2. 原文陈述

> where the forces are determined from the potential energy function $U$. Denoting the coordinates of the $i$th nucleus of an N-atom system by $q_{i,x},q_{i,y},q_{i,z}$, and the atomic mass by $m_i$, the equations of motion for the $i$th nucleus can be written out as
> \[m_i\frac{\mathrm d^2q_{i,x}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,x}},\qquad m_i\frac{\mathrm d^2q_{i,y}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,y}},\qquad m_i\frac{\mathrm d^2q_{i,z}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,z}}.\tag{1.2}\]
> It is important to recognize that (1.2) does not, itself, give a complete description of the motion; it must be supplemented by initial conditions (positions and velocities given at some specified instant) for all atoms.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def newtonInitialValueModel {N : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N * 3)) (Q : Set (Position (N * 3)))
    (I : Set ℝ) (q : ℝ → Position (N * 3)) (t₀ : ℝ)
    (q₀ v₀ : Position (N * 3)) : Prop :=
  classicalNewtonInitialValueModel (coordinateMassesOfParticles (d := 3) m)
    U Q I q t₀ q₀ v₀
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.newtonInitialValueModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[m_i\frac{\mathrm d^2q_{i,x}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,x}},\qquad m_i\frac{\mathrm d^2q_{i,y}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,y}},\qquad m_i\frac{\mathrm d^2q_{i,z}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,z}}.\tag{1.2}\] | MD.Ch01.newtonInitialValueModel，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。 | [EXTRA] |
| 网站FAIL指出的缺失资格与动力学 | MD.Ch01.newtonInitialValueModel及EAUDIT02辅助定义 | 修复；所有新技术范围明确[EXTRA]，原文未弱化，网站复审未验证 |

[EXTRA] n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。；[EXTRA] EAUDIT02：精确N*3维与逐粒子重复质量；正质量；含初始时刻的开放连通时间域；势能沿轨迹可微，资格保证实际梯度而非总化默认值。一般n维定义仅为辅助。

### 6. 审计结论

EAUDIT02本地预审：精确三维粒子质量重复，初始时刻在开放连通域内；势能沿轨迹可微并保留真实二阶时间导数和两类初值。

网站：网站PASS（附件绑定 EAUDIT02；定义/签名未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:314；MD.Ch01.newtonInitialValueModel。

## 1. MD-1.1-HardSphere · definition · 印刷p.7 / PDFp.30

### 2. 原文陈述

> The simplest model for a molecular interaction potential is the hard-sphere model. We assume that each atom is an impenetrable sphere which interacts with other atoms via perfectly elastic collision with the atoms transferring, according to standard rules, momentum and energy to one another during the collisions.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hardSphereModel {N : ℕ} (R m : Fin N → ℝ) (I C : Set ℝ)
    (q v before after : ℝ → Fin N → V3) (pair : ℝ → Fin N × Fin N) : Prop :=
  (∀ i, 0 < R i ∧ 0 < m i) ∧ IsOpen I ∧ IsPreconnected I ∧ C ⊆ I ∧
  (∀ t ∈ I, ∃ δ > 0, ∀ s ∈ I, |s - t| < δ → s ∈ C → s = t) ∧
  (∀ t ∈ I, ∀ i j, i ≠ j → R i + R j ≤ dist (q t i) (q t j)) ∧
  (∀ i, ContinuousOn (fun t => q t i) I) ∧
  (∀ t ∈ I \ C, ∀ i,
    HasDerivAt (fun s => q s i) (v t i) t ∧
    HasDerivAt (fun s => v s i) (0 : V3) t) ∧
  (∀ t ∈ C,
    let i := (pair t).1
    let j := (pair t).2
    i ≠ j ∧
    binaryElasticSphereCollision (R i) (R j) (m i) (m j)
      (q t i) (q t j) (before t i) (before t j) (after t i) (after t j) ∧
    (∀ k, Tendsto (fun s => v s k) (𝓝[I ∩ Iio t] t) (𝓝 (before t k)) ∧
      Tendsto (fun s => v s k) (𝓝[I ∩ Ioi t] t) (𝓝 (after t k))) ∧
    (∀ k, k ≠ i → k ≠ j → after t k = before t k))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hardSphereModel；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。 | [EXTRA] |
| 网站FAIL指出的缺失资格与动力学 | MD.Ch01.hardSphereModel及EAUDIT02辅助定义 | 修复；所有新技术范围明确[EXTRA]，原文未弱化，网站复审未验证 |

[EXTRA] [历史签名，EAUDIT02已替换] 只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。；[EXTRA] EAUDIT02：以标准无摩擦孤立二体弹性碰撞展开standard rules；同时多接触需另有规则。碰撞时刻在整个开放时间域局部孤立，排除稠密事件集使动力学真空化；全粒子对全时间不可穿透；位置连续，碰撞外真实自由运动；实际速度左右极限接入法向冲量、法向速度反转、碰后分离及全部动量/动能守恒。旧只含瞬时必要守恒关系的说明为历史版本。

### 6. 审计结论

EAUDIT02本地预审：全时间全粒子对不可穿透；局部孤立碰撞、位置连续、碰撞外真实自由运动，速度实际左右极限接入二体法向冲量、反转、分离及动量/能量守恒。无摩擦孤立二体范围[EXTRA]已披露，网站仍待复审，不声明解存在。

网站：网站PASS（EAUDIT复审）。
PASS。N个三维粒子，逐粒子正半径和正质量；I开放连通，C⊆I且在I的每点附近至多有该点一个碰撞事件，排除了稠密事件造成的自由运动条件真空化。全时间全粒子对距离≥半径和，位置连续；I\C上q′=v及v′=0是真实导数。每个C中事件指定不同粒子i,j并接触；正半径保证单位法向有定义。binaryElasticSphereCollision的入射法向符号、两速度的标准质量加权法向冲量、法向反转、碰后分离、动量及动能守恒均一致；所有粒子的实际速度左右极限接入before/after，非碰撞粒子速度不变。[EXTRA]已明确限制为孤立二体无摩擦碰撞，未声称处理同时多碰撞或解存在。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:330；MD.Ch01.hardSphereModel。

## 1. MD-1.1.1-Multibody · definition · 印刷p.8 / PDFp.31

### 2. 原文陈述

> In the most common situations, the potential energy function consists of a sum of 2-body, 3-body and/or 4-body terms,
> \[U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\qquad U_{ijk}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k),\qquad U_{ijkl}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k,\boldsymbol q_l),\]
> where $\boldsymbol q_i$ is the position vector of atom $i$ such that $(q_{i,x},q_{i,y},q_{i,z})=\boldsymbol q_i\in\mathbb R^3$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

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

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.multibodyPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\qquad U_{ijk}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k),\qquad U_{ijkl}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k,\boldsymbol q_l),\] | MD.Ch01.multibodyPotential，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。 | [EXTRA] |

[EXTRA] 按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。；[EXTRA] EAUDIT03补真实V3=Position 3=EuclideanSpace ℝ(Fin 3)及求和依赖，仅补材料，不改多体定义。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（附件绑定 EAUDIT03；定义/签名未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:353；MD.Ch01.multibodyPotential。

## 1. MD-1.1.1-Morse · definition · 印刷p.8 / PDFp.31

### 2. 原文陈述

> A simple potential energy function whose graph can be used to approximate the potential energy of bond dissociation is the Morse potential
> \[\varphi_{\mathrm{Morse}}(r)=D\left(1-e^{-a(r-r_e)}\right)^2.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.morsePotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{\mathrm{Morse}}(r)=D\left(1-e^{-a(r-r_e)}\right)^2.\] | MD.Ch01.morsePotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:366；MD.Ch01.morsePotential。

## 1. MD-1.1.1-MorseMinimum · unnumbered_claim · 印刷p.8 / PDFp.31

### 2. 原文陈述

> (See Fig. 1.5.) $r_e$ is the location of the minimum, $D$ gives the well depth, and $a$ is a shape parameter that can be used to control the curvature at the minimum.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem morse_minimum :
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D) ∧
    deriv (deriv (morsePotential D a rₑ)) rₑ = 2*D*a^2 ∧
    (∀ a₁ a₂ : ℝ, 0 < a₁ → a₁ < a₂ →
      deriv (deriv (morsePotential D a₁ rₑ)) rₑ < deriv (deriv (morsePotential D a₂ rₑ)) rₑ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.morse_minimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| rₑ处极小、井深D | ∀ r>0, 0≤morsePotential…; morsePotential…rₑ=0; Tendsto … atTop (𝓝 D) | 一致 |
| a controls curvature | 定性形状参数合并context_notation；原书未给二阶导数公式 | 一致（定性背景） |
| 原文未显式量化的技术资格 | D,a,rₑ正；well depth解释为无穷远极限减最小值。 | [EXTRA] |
| 网站FAIL指出全部曲率/实际粒子距离缺项 | MD.Ch01.morse_minimum | 完整签名补齐；新增计算明确EXTRA，不回填成原书句子；网站复审尚未验证 |

[EXTRA] D,a,rₑ正；well depth解释为无穷远极限减最小值。；[EXTRA] EAUDIT03补原曲率子句的实际展开φ″(rₑ)=2Da²，并表达固定D>0时正a增大曲率严格增大；公式为形式化展开，不回填成教材原句。

### 6. 审计结论

EAUDIT03本地预审：完整最小值、阱深及实际二阶曲率2Da²和固定D的正a严格单调性。

网站：网站PASS（EAUDIT复审）。
PASS。对所有D,a,rₑ>0，势D(1−exp(−a(r−rₑ)))²在r>0非负、在rₑ为零，且r→+∞极限为D，正好给出最小点及井深。二阶导在rₑ为2Da²；固定D>0及rₑ，0<a₁<a₂时2Da₁²<2Da₂²，正确落实曲率控制。rₑ>0保证最小点在径向域内。全部五个合取分句及[EXTRA]都正确；sorry不参与签名判定。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:372；MD.Ch01.morse_minimum。

## 1. MD-1.1.1-LengthBond · definition · 印刷p.9 / PDFp.32

### 2. 原文陈述

> Because they often do not need to be allowed to break during simulation and are very strong compared to other potential terms, chemical bonds such as the covalent $\mathrm H_2^+$ bond described above are sometimes treated as springs with given rest-length:
> \[\varphi_{ij}^{\mathrm{len}}(r_{ij})=\frac{k_{ij}^{\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\qquad r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lengthBond (k r₀ : ℝ) (qᵢ qⱼ : V3) := k / 2 * (‖qᵢ-qⱼ‖-r₀)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lengthBond；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{ij}^{\mathrm{len}}(r_{ij})=\frac{k_{ij}^{\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\qquad r_{ij}=\\|\boldsymbol q_i-\boldsymbol q_j\\|.\] | MD.Ch01.lengthBond，完整展开陈述见上一行及第4段 | 一致 |
| 网站FAIL指出全部曲率/实际粒子距离缺项 | MD.Ch01.lengthBond | 完整签名补齐；新增计算明确EXTRA，不回填成原书句子；网站复审尚未验证 |

[EXTRA] [EXTRA] EAUDIT03保留原径向剖面为lengthBondRadial；主定义以真实三维粒子位置为参数，rᵢⱼ=‖qᵢ−qⱼ‖代入原弹簧能。

### 6. 审计结论

EAUDIT03本地预审：真实V3三维EuclideanSpace，主定义实际代入两粒子距离；径向剖面辅助定义保留。

网站：网站PASS（EAUDIT复审）。
PASS。V3为真正三维欧氏空间，输入为两个粒子位置；lengthBond直接代入其欧氏距离，系数k/2与静长r₀无误。k,r₀的签名允许所有实数，是无奇点代数公式的扩展；物理使用中的k>0不被误作已编码的前提，也没有正性或最小值定理。当前源要求的弹簧势公式及[EXTRA]真实位置代入均已覆盖；不要求历史径向辅助函数参与此声明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:385；MD.Ch01.lengthBond。

## 1. MD-1.1.1-Dispersion · definition · 印刷p.10 / PDFp.33

### 2. 原文陈述

> This leads to an instantaneous polarization and an attractive interaction termed London dispersion; it is most often modelled using an inverse sixth power potential:
> \[\varphi_{\mathrm{disp}}(r)\sim-\frac K{r^6},\qquad K>0.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def dispersionPotential (K r : ℝ) := -K / r^6
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.dispersionPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{\mathrm{disp}}(r)\sim-\frac K{r^6},\qquad K>0.\] | MD.Ch01.dispersionPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:391；MD.Ch01.dispersionPotential。

## 1. MD-1.1.1-Buckingham · definition · 印刷p.10 / PDFp.33

### 2. 原文陈述

> Buckingham [56] suggested a combined potential of the form
> \[\varphi_B(r)=Ae^{-Br}-\frac C{r^6},\qquad A>0,\ B>0,\ C>0.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def buckinghamPotential (A B C r : ℝ) := A * Real.exp (-B*r) - C/r^6
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.buckinghamPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_B(r)=Ae^{-Br}-\frac C{r^6},\qquad A>0,\ B>0,\ C>0.\] | MD.Ch01.buckinghamPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:397；MD.Ch01.buckinghamPotential。

## 1. MD-1.1.1-LennardJones · definition · 印刷p.10 / PDFp.33

### 2. 原文陈述

> A more common choice in simulation is the Lennard-Jones (6–12) potential
> \[\varphi_{\mathrm{LJ}}(r)=4\epsilon\left[\left(\frac\sigma r\right)^{12}-\left(\frac\sigma r\right)^6\right].\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lennardJonesPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{\mathrm{LJ}}(r)=4\epsilon\left[\left(\frac\sigma r\right)^{12}-\left(\frac\sigma r\right)^6\right].\] | MD.Ch01.lennardJonesPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:403；MD.Ch01.lennardJonesPotential。

## 1. MD-1.1.1-LJRepulsion · unnumbered_claim · 印刷p.10–11 / PDFp.33–34

### 2. 原文陈述

> Because of the strongly repulsive character of short-ranged soft walls in molecular dynamics, i.e., the fact that $\varphi_{\mathrm{LJ}}$ tends rapidly to positive infinity as $r\to0$, the atoms remain well separated in long simulations. The singularity at $r=0$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lj_repulsion :
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop := by
  intro ε σ hε hσ
  have h₁ : Tendsto (fun r : ℝ => σ/r) (𝓝[>] (0:ℝ)) atTop := by
    simpa [div_eq_mul_inv] using (tendsto_inv_nhdsGT_zero (𝕜 := ℝ)).const_mul_atTop hσ
  have h₂ : Tendsto (fun r : ℝ => (σ/r)^6) (𝓝[>] (0:ℝ)) atTop := by
    simpa only [Function.comp_def] using (tendsto_pow_atTop (by decide : (6:ℕ) ≠ 0)).comp h₁
  have h₃ : Tendsto (fun r : ℝ => 2*(σ/r)^6-1) (𝓝[>] (0:ℝ)) atTop := by
    simpa only [sub_eq_add_neg] using (h₂.const_mul_atTop (by norm_num : (0:ℝ) < 2)).atTop_add
      (tendsto_const_nhds (x := (-1:ℝ)))
  have h₄ : Tendsto (fun r : ℝ => ε*(2*(σ/r)^6-1)^2-ε) (𝓝[>] (0:ℝ)) atTop := by
    simpa only [Function.comp_def, sub_eq_add_neg] using
      (((tendsto_pow_atTop (by decide : (2:ℕ) ≠ 0)).comp h₃).const_mul_atTop hε).atTop_add
        (tendsto_const_nhds (x := -ε))
  convert h₄ using 1
  funext r
  unfold lennardJonesPotential
  ring

/-- 修正版，对应原文 MD-1.1.1-LJRepulsion，改动：保留已证单侧极限；把可严格陈述的内容写成任意有限能级对应正距离屏障，不声称数值模拟rarely的概率。 -/
theorem lj_repulsion_corrected (ε σ : ℝ) (hε : 0 < ε) (hσ : 0 < σ) (E : ℝ) :
    ∃ δ > 0, ∀ r ∈ Ioo 0 δ, E < lennardJonesPotential ε σ r := by
  have h := (lj_repulsion ε σ hε hσ).eventually (eventually_gt_atTop E)
  obtain ⟨δ,hδ,hh⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp h
  exact ⟨δ,hδ,fun r hr => hh hr⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lj_repulsion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| r→0时趋正无穷 | Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop | 一致 |
| 长模拟中通常保持分离 | context_notation；严格有限能量无碰撞旧CH01-198排除 | 一致（定性经验） |

[EXTRA] 

### 6. 审计结论

有限能量的精确轨道和长时间数值模拟的经验频率是不同命题；缺算法、步长、时间窗和概率模型。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
lj_repulsion：PASS，对全部ε,σ>0，使用从正距离趋零的𝓝[>]0而非把总函数在0的值当极限，结论正确。lj_repulsion_corrected：PASS，对任意有限实能级E，存在δ>0使所有0<r<δ的势值>E，正是该极限的严格屏障表述。两条均不提供轨迹、数值算法、能量上界、长时间区间或概率模型，因而不能覆盖整段原文的long simulations/well separated/rarely经验断言。修正版没有冒称已推出无条件无碰撞；原文经验量词如何纳入正式结论须人工确定，故条目汇总NEEDS_HUMAN。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:409；MD.Ch01.lj_repulsion。

## 1. MD-1.1.1-HeterogeneousLJ · definition · 印刷p.11 / PDFp.34

### 2. 原文陈述

> When there are many atoms of different types, the parameters of the potential will depend on this, so we obtain contributions to the total potential energy of the form
> \[\varphi_{ij}^{\mathrm{LJ}}(r_{ij})=4\epsilon_{ij}\left[\left(\frac{\sigma_{ij}}{r_{ij}}\right)^{12}-\left(\frac{\sigma_{ij}}{r_{ij}}\right)^6\right],\]
> where $r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.heterogeneousLJ；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{ij}^{\mathrm{LJ}}(r_{ij})=4\epsilon_{ij}\left[\left(\frac{\sigma_{ij}}{r_{ij}}\right)^{12}-\left(\frac{\sigma_{ij}}{r_{ij}}\right)^6\right],\] | MD.Ch01.heterogeneousLJ，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] [EXTRA] EAUDIT03补真实V3和pairDistance=‖qᵢ−qⱼ‖；总函数公式对应域为pairDistance>0，零距离的总化取值不解释为物理势。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。N任意，ε、σ均为Fin N×Fin N上的实参数表，q给出每个粒子的真实V3位置；i,j的势为4ε_ij[(σ_ij/‖q_i−q_j‖)^12−(σ_ij/‖q_i−q_j‖)^6]。pairDistance定义正是该欧氏距离。原文未在此声明混合规则、参数表对称性或总势求和，Lean也未额外声称这些。距离零处Lean总除法给出有限扩展值；本条[EXTRA]已明确只在pairDistance>0解释为原势，故不把该扩展当作物理碰撞势。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:440；MD.Ch01.heterogeneousLJ。

## 1. MD-1.1.2-Coulomb · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> When, as in the case of the alanine dipeptide, net charges are present on the atoms, one may model this by means of Coulomb potentials:
> \[\varphi_{ij}^{\mathrm{Coulomb}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}},\]
> where $\epsilon>0$ is the dielectric constant, and $Q_i,Q_j$ are the charges on atoms $i$ and $j$, respectively. $C$ is a positive coefficient allowing the adjustment of units. Obviously the effect of the Coulombic potential depends strongly on whether the atoms have the same or oppositely signed charges.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def coulombPotential (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric r : {x : ℝ // 0 < x}) : ℝ := C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.coulombPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{ij}^{\mathrm{Coulomb}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}},\] | MD.Ch01.coulombPotential，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.coulombPotential | 正C、介电常数与距离落实到子类型；电荷仍可正负，未另造吸引排斥结论。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.coulombPotential | 正C、介电常数与距离落实到子类型；电荷仍可正负，未另造吸引排斥结论。 |

[EXTRA] [EXTRA] 19号：正C、介电常数与距离落实到子类型；电荷仍可正负，未另造吸引排斥结论。

### 6. 审计结论

19号本地签名预审：正C、介电常数与距离落实到子类型；电荷仍可正负，未另造吸引排斥结论。

网站：网站PASS（EAUDIT复审）。
PASS。C、介电常数和距离是严格正实数子类型，电荷Qᵢ,Qⱼ为任意实数；返回值恰为C QᵢQⱼ/(dielectric·r)。分母严格正且原电荷符号未受限制，[EXTRA]全部落实。此为径向势的定义，原文电荷同号/异号影响作为定性背景，没有把吸引排斥当作已证明的动力学结论。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:448；MD.Ch01.coulombPotential。

## 1. MD-1.1.2-Cutoff · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> In the simplest treatments, the Coulomb potential is simply cut off at distance $r_{\mathrm{cut}}$, i.e., is taken to be zero for $r>r_{\mathrm{cut}}$. This should be done in such a way that the potential remains at least continuously differentiable, preferably smoother (see Exercise 11).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  0 < r_cut ∧ ContDiffOn ℝ 1 φ (Ioi 0) ∧ ∀ r, r_cut < r → φ r = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.smoothCutoff；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.smoothCutoff | C¹只要求正距离域，保留严格r_cut<r截零及正截断半径。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.smoothCutoff | C¹只要求正距离域，保留严格r_cut<r截零及正截断半径。 |

[EXTRA] [EXTRA] 19号：C¹只要求正距离域，保留严格r_cut<r截零及正截断半径。

### 6. 审计结论

19号本地签名预审：C¹只要求正距离域，保留严格r_cut<r截零及正截断半径。

网站：网站PASS（EAUDIT复审）。
PASS。smoothCutoff是修饰后势φ的性质：r_cut>0、φ在正距离域C¹、对所有r>r_cut取零；没有在r=0要求C¹，故不排除Coulomb原点奇性。由于r_cut位于正距离域内部，C¹与右侧恒零还蕴含截断点的函数和一阶导数接零，无须另把边界点写入截零量词。原文没有给出具体开关函数或要求在整个截断半径以下精确等于未修饰Coulomb势；未引入这些额外结论。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:455；MD.Ch01.smoothCutoff。

## 1. MD-1.1.2-Yukawa · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $\kappa$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:
> \[\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def yukawaScreened (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric : {x : ℝ // 0 < x}) (κ : ℝ) (r : {x : ℝ // 0 < x}) : ℝ :=
  C.val * Qᵢ * Qⱼ / (dielectric.val * r.val) * Real.exp (-κ * r.val)

/-- 修正版，对应原文 MD-1.1.2-Yukawa，改动：a保留−κr但把κ解释为逆屏蔽长度；b若保留Debye length称谓则用−r/ℓ。正参数为物理域补充。 -/
def yukawaScreened_corrected_a (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric κ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-κ.val*r.val)

/-- 修正版，对应原文 MD-1.1.2-Yukawa，改动：若参数称Debye长度，指数应为−r/ℓ。 -/
def yukawaScreened_corrected_b (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric ℓ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-r.val/ℓ.val)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.yukawaScreened；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.\] | MD.Ch01.yukawaScreened，完整展开陈述见上一行及第4段 | 一致 |
| exp(-κr) | Real.exp (-κ * r) | 一致；κ称屏蔽长度的量纲疑点见原文issues |
| 网站指出缺项及原文完整子句 | MD.Ch01.yukawaScreened; MD.Ch01.yukawaScreened_corrected_a; MD.Ch01.yukawaScreened_corrected_b | 正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.yukawaScreened; MD.Ch01.yukawaScreened_corrected_a; MD.Ch01.yukawaScreened_corrected_b | 正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。 |

[EXTRA] [EXTRA] 19号：正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。

### 6. 审计结论

原文称κ为长度，但无量纲指数−κr通常要求κ为逆长度。Lean实数类型不携带量纲，此疑点必须文字核查。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
yukawaScreened：字面公式及C、dielectric、r的正子类型PASS；κ按实参数保留，未暗改原书指数。原文称κ为长度，而指数−κr若无量纲则κ应有逆长度量纲，此矛盾需人工确认。yukawaScreened_corrected_a：PASS，κ>0解释为逆屏蔽长度，保留−κr；yukawaScreened_corrected_b：PASS，ℓ>0解释为长度，使用−r/ℓ。两修正版在κ=1/ℓ时一致，电荷仍任意实数，其他正域条件相符。汇总NEEDS_HUMAN来自原书参数称谓与公式的冲突，不来自修正版的代数。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:462；MD.Ch01.yukawaScreened。

## 1. MD-1.1.2-AngleBond · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> When a trio of atoms with labels $i$, $j$, and $k$ admits a pair of length bonds, say $(i,j)$ and $(j,k)$, then an additional three-body term will need to be incorporated:
> \[\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,\]
> where the angle $\theta_{ijk}$ is given in terms of the positions as
> \[\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2

/-- Physical angle domain; both directed bonds have strictly positive length. -/
def AngleBondValidDomain (qᵢ qⱼ qₖ : V3) : Prop :=
  0 < ‖qᵢ-qⱼ‖ ∧ 0 < ‖qⱼ-qₖ‖

def angleBondOnDomain (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3)
    (_h : AngleBondValidDomain qᵢ qⱼ qₖ) : ℝ := angleBondModel k θ₀ qᵢ qⱼ qₖ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.angleBondOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,\]；\[\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.\] | MD.Ch01.angleBondModel，完整展开陈述见上一行及第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.angleBondOnDomain | 总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。 |

[EXTRA] [EXTRA] 总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
公式在非零两键长上PASS，V3、内积、两范数乘积、arccos及弹簧系数均与原页一致。但当前angleBondModel接受所有三位置，没有非零键长的子类型或前提，context_notation所说“两键长非零”没有落实，也未声明零分母仅是辅助总化扩展。Lean的除零为0会在原书角度未定义的重合构形给出实势，故按完整对象/域要求FAIL。k正也只是物理上下文，并非签名前提；本次不把原书的有向差约定自行换成通常补角约定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:489；MD.Ch01.angleBondOnDomain。

## 1. MD-1.1.2-Dihedral · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> Dihedral potentials typically are modelled using a trigonometric potential function, as
> \[\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.dihedralPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].\] | MD.Ch01.dihedralPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:497；MD.Ch01.dihedralPotential。

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

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)

/-- Effective Gay--Berne domain: all divisions and both square roots are physical. -/
def GayBerneValidDomain (σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : Prop :=
  let r := q₂-q₁
  let rhat := ‖r‖⁻¹ • r
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  ‖u₁‖ = 1 ∧ ‖u₂‖ = 1 ∧ q₁ ≠ q₂ ∧
  σₛ ≠ 0 ∧ εₛ ≠ 0 ∧ μ ≠ 0 ∧
  ((σₑ/σₛ)^2+1) ≠ 0 ∧ (1+Real.rpow (εₑ/εₛ) (1/μ)) ≠ 0 ∧
  (1+χ*inner ℝ u₁ u₂) ≠ 0 ∧ (1-χ*inner ℝ u₁ u₂) ≠ 0 ∧
  (1+χ'*inner ℝ u₁ u₂) ≠ 0 ∧ (1-χ'*inner ℝ u₁ u₂) ≠ 0 ∧
  0 < 1-χ^2*(inner ℝ u₁ u₂)^2 ∧ 0 < gayBerneW rhat u₁ u₂ χ ∧
  (‖r‖-σ₀/Real.sqrt (gayBerneW rhat u₁ u₂ χ)) ≠ 0

def gayBerneOnDomain (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3)
    (_h : GayBerneValidDomain σ₀ σₑ σₛ εₑ εₛ μ q₁ q₂ u₁ u₂) : ℝ :=
  gayBerneModel ε₀ σ₀ σₑ σₛ εₑ εₛ μ q₁ q₂ u₁ u₂
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.gayBerneOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],\]；\[\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),\]；\[\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\\|\boldsymbol r\\|-\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},\]；\[\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),\]；\[W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].\]；\[\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.\] | MD.Ch01.gayBerneModel，完整展开陈述见上一行及第4段 | 一致 |
| εGB=ε₁ε₂ | gayBerneEpsilonOne … * gayBerneEpsilonTwo …，没有平方ε₂ | 一致；旧正式定义平方与原页不同，未桥接 |
| ρ、χ、χ′及各向异性参数 | gayBerneModel的r/χ/χ′/Δ定义及原始定义文件 | 一致 |
| 21号网站建议修复 | MD.Ch01.gayBerneOnDomain | 原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。 |

[EXTRA] [EXTRA] 原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
全部代数展开在原书正常域上PASS：r=q₂−q₁、r̂=‖r‖⁻¹r，ε₁=ε₀/√(1−χ²(u₁·u₂)²)，ε₂=W(...,χ′)，W的两分母和正负号、χ与χ′的定义均一致。但Lean参数u₁,u₂仅为任意V3，不是原书的单位取向；q₁≠q₂、根号内严格正、σₛ/εₛ/μ及各有理式分母非零、Δ≠0均未编码。context_notation已经明确这些域限定，却无相应[EXTRA]总化说明或有效域模型。总除法、Real.sqrt及Real.rpow会对非法参数继续返回值，因此完整域审校FAIL；不以旧库不同公式作为依据。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:526；MD.Ch01.gayBerneOnDomain。

## 1. MD-1.2-NewtonCompact · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> In this book, we shall frequently use a compact, vectorial notation, where $\boldsymbol q$ and $\dot{\boldsymbol q}$ represent vectors of the positions and velocities, and $\boldsymbol M$ is a diagonal mass matrix, so the equations of motion (1.2) become
> \[\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\tag{1.3}\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  DifferentiableAt ℝ U (q t) ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.compactNewton；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\tag{1.3}\] | MD.Ch01.compactNewton，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.compactNewton | 在原有两项真实时间导数资格后增加势能在q(t)处可微。 |

[EXTRA] 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。；[EXTRA] 在原有两项真实时间导数资格后增加势能在q(t)处可微。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：在原有两项真实时间导数资格后增加势能在q(t)处可微。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
时间一、二阶HasDerivAt确实阻止不可微q被总导数当伪解；massOperator通过Matrix.diagonal逐坐标作用，等式确为M q″=−gradient U。泛化维数n和任意对角实参数可作原式的代数模板，三维粒子物理使用须取n=3N及正质量三次重复。关键缺项是U:Position n→ℝ没有在q t可微的前提，gradient的总化定义仍可在不可微势点返回0，故未完整表达经典Newton力；[EXTRA]只修复了轨迹导数，没有修复势能梯度资格。域审校FAIL。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:540；MD.Ch01.compactNewton。

## 1. MD-1.2-DegreesFreedom · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $N_d$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
/- Linear algebra auxiliary; geometric validity is stated by constraintdimension. -/
def linearizedConstraintDimension {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)

def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) : ℕ := linearizedConstraintDimension C q.val
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.degreesOfFreedom；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 在可微约束C局部正则层中以导数核维数表示；无约束取零约束。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedConstraintDimension; MD.Ch01.degreesOfFreedom | 只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedConstraintDimension; MD.Ch01.degreesOfFreedom | 只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。 |

[EXTRA] 在可微约束C局部正则层中以导数核维数表示；无约束取零约束。；[EXTRA] 19号：只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。

### 6. 审计结论

19号本地签名预审：只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。

网站：网站PASS（EAUDIT复审）。
PASS。linearizedConstraintDimension仅是线性代数辅助量，等于实线性映射fderiv C q的核的finrank。degreesOfFreedom的q不是任意点，而是C q=c、C在q为C¹、导数满射的可行点子类型；在该正则层由隐函数定理，核正是局部可行方向空间。n为构形维数、r为独立约束数，值为自然数；r=0包含无约束情形。没有把奇异点的线性化核维数冒充真实几何维数。与最新[EXTRA]及下一条局部坐标解释一致。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:554；MD.Ch01.degreesOfFreedom。

## 1. MD-1.2-ConstraintDimension · unnumbered_claim · 印刷p.18 / PDFp.41

### 2. 原文陈述

> For the N-body system in $\mathbb R^3$ without additional constraints there are $N_d=N_c=3N$ degrees of freedom. If $r$ independent constraints are present the number of degrees of freedom is $N_d=N_c-r$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constraintdimension {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) :
    degreesOfFreedom C c q + r = n ∧
    ∃ (U : Set (Position n)) (V : Set (Position (degreesOfFreedom C c q) × Position r))
      (φ : Position n → Position (degreesOfFreedom C c q) × Position r)
      (ψ : Position (degreesOfFreedom C c q) × Position r → Position n),
      IsOpen U ∧ IsOpen V ∧ q.val ∈ U ∧
      ContDiffOn ℝ 1 φ U ∧ ContDiffOn ℝ 1 ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      (∀ x ∈ U, C x = c ↔ (φ x).2 = 0) := by
  sorry

/-- Unconstrained three-dimensional N-particle specialization, not a geometry assumption. -/
theorem constraintdimension_unconstrained (N : ℕ) :
    linearizedConstraintDimension (fun _ : Position (3*N) => (0 : Position 0)) 0 = 3*N := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constraintdimension；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.constraintdimension; MD.Ch01.constraintdimension_unconstrained | 保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.constraintdimension; MD.Ch01.constraintdimension_unconstrained | 保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。 |

[EXTRA] 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。；[EXTRA] 19号：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。

### 6. 审计结论

19号本地签名预审：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。

网站：网站PASS（EAUDIT复审）。
PASS。主定理的q子类型明确C¹正则可行点和fderiv满射，保证r≤n；结论degreesOfFreedom+r=n避免自然数减法截断。全部局部图分句已核对：U,V开放、q∈U、φ/ψ为C¹、双向MapsTo及两侧LeftInvOn，使U与V局部微分同胚；C x=c当且仅当φ(x)第二分量为0，给出d维自由坐标的真实层结构。constraintdimension_unconstrained另以Position (3N)上的零个约束给核维数3N，覆盖无约束分句。局部图构造的sorry仅是证明未完成，不使正确签名FAIL。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:562；MD.Ch01.constraintdimension。

## 1. MD-1.2-TotalEnergy · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The total energy of the N-body system is a function of positions and velocities,
> \[E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\|\dot{\boldsymbol q}_j\|^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\tag{1.4}\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.particleTotalEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\\|\dot{\boldsymbol q}_j\\|^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\tag{1.4}\] | MD.Ch01.particleTotalEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。N个三维位置q、速度v和粒子质量m，U以完整构形Fin N→V3为自变量；定义恰是Σ_j m_j‖v_j‖²/2+U(q)。此为相空间能量函数定义，v是独立速度变量，不需在本定义中绑定某条轨迹导数。m允许任意实数是该代数式的扩展，物理正质量子域自然包含其中，未声称未加前提的能量正性或守恒。没有漏掉求和粒子或把势能逐粒子重复相加。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:584；MD.Ch01.particleTotalEnergy。

## 1. MD-1.2-PairCancellation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> This means that the sum of all the forces will vanish.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem paircancellation :
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0 := by
  intro N F _ hanti
  have h : (∑ i, ∑ j, F i j) = -(∑ i, ∑ j, F i j) := by
    calc
      (∑ i, ∑ j, F i j) = ∑ j, ∑ i, F i j := Finset.sum_comm
      _ = ∑ j, ∑ i, -F j i := by
        apply Finset.sum_congr rfl
        intro j _
        apply Finset.sum_congr rfl
        intro i _
        exact hanti i j
      _ = -(∑ j, ∑ i, F j i) := by simp only [Finset.sum_neg_distrib]
  have hcoord (k : Fin 3) : (∑ i, ∑ j, F i j) k = 0 := by
    have hk := congrArg (fun v : V3 => v k) h
    simp only [PiLp.neg_apply] at hk
    linarith
  ext k
  exact hcoord k
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.paircancellation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | Fi i=0，内部两体力反对称；无外力。 | [EXTRA] |

[EXTRA] Fi i=0，内部两体力反对称；无外力。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
PASS。对任意自然数N和V3值的全有序粒子对力表F，假设对角零及所有i,j反对称，结论全双和为零，恰是全部内力合力抵消。对角零其实由反对称在实向量空间已推出，冗余不改变意义；全双和与无自力的j≠i求和相符。无外力的解释已在前提力表及[EXTRA]中明确，没有把结论净力零预先当假设。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:591；MD.Ch01.paircancellation。

## 1. MD-1.2-MomentumConservation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> and thus the three components of the total momentum vector $\boldsymbol p_{\mathrm{tot}}:=\sum_{i=1}^{N}\boldsymbol p_i$ will be conserved quantities.

### 3. 原文证明

> Since
> \[\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\boldsymbol F_i,\]
> we have
> \[\sum_{i=1}^{N}\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\sum_{i=1}^{N}\boldsymbol F_i=0\]
按渲染原页逐字转录原文论证。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem momentum_conservation :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  intro N m v F I ho hi hanti hNewton
  have hz (t : ℝ) (ht : t ∈ I) : (∑ i, ∑ j, F t i j) = 0 := by
    apply paircancellation N (F t)
    · intro i
      ext k
      have h := congrArg (fun u : V3 => u k) (hanti t ht i i)
      simp only [PiLp.neg_apply] at h
      change (F t i i) k = 0
      linarith
    · exact hanti t ht
  have hd (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • v s i) 0 t := by
    have h := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hNewton t ht i)
    rwa [hz t ht] at h
  refine ⟨hz,hd,?_⟩
  intro a ha b hb
  exact ho.is_const_of_deriv_eq_zero hi
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.momentum_conservation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 两体力反向，净力相消 | F t i j = -F t j i → (∑ i, ∑ j, F t i j)=0 | 一致；净力为零是结论 |
| 全向量/每坐标动量守恒 | 真实HasDerivAt (∑ i,m i • v s i) 0及任意a,b∈I的值相等 | 一致 |
| 原文未显式量化的技术资格 | 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。 | [EXTRA] |

[EXTRA] 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。

### 6. 审计结论

审查后去掉旧桥接中净力零前提，由真实逐对作用反对称推出净力零和全向量/每坐标动量守恒，保留全部结论。

网站：网站PASS（EAUDIT复审）。
PASS。N任意，m为与时间无关的实质量，v给三维速度，pᵢ(t)=mᵢ•vᵢ(t)。I开放连通；F为全时间有序粒子对力，逐对反对称以及每个pᵢ的真实导数等于Σ_jF_ij为前提。三个完整结论依次是净内力零、总动量HasDerivAt零、任意a,b∈I的总动量相等；第三个向量等式同时给出三个分量守恒。质量正性不是这条代数守恒推论所必需；未把净力零或守恒偷放到假设中。[EXTRA]全部相符。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:616；MD.Ch01.momentum_conservation。

## 1. MD-1.2-HarmonicSolution · Example 1.3 · 印刷p.19–20 / PDFp.42–43

### 2. 原文陈述

> Example 1.3 (Harmonic Oscillator) Consider the system
> \[\dot x=v,\qquad\dot v=-\Omega^2x.\]
> This system describes the behavior of a particle with unit mass in one dimension, with energy function $E(x,\dot x)=\dot x^2/2+\Omega^2x^2/2$, where its motion is governed by a linear 2nd order equation $\ddot x+\Omega^2x=0$. The solution, for given $x(0)=\xi$, $\dot x(0)=v(0)=\eta$, is
> \[x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def harmonicEnergy {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) : ℝ :=
  ‖z.2‖^2 / 2 + Ω^2 * ‖z.1‖^2 / 2

theorem harmonicEnergy_eq_massHamiltonian {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) :
    harmonicEnergy Ω z = massHamiltonian (fun _ : Fin n => (1 : ℝ))
      (harmonicPotential Ω) z := by
  simp [harmonicEnergy, massHamiltonian, massSeparableEnergy,
    SeparableEnergy.hamiltonian, momentumKineticEnergy, harmonicPotential,
    nBodyKineticEnergy, EuclideanSpace.real_norm_sq_eq, Finset.sum_div,
    Finset.mul_sum, mul_div_assoc]

theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    (∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2) ∧
    (∀ t, harmonicEnergy Ω (harmonicFlow Ω t z) = harmonicEnergy Ω z) ∧
    (∀ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
        univ univ γ → γ 0 = z → ∀ t, γ t = harmonicFlow Ω t z) := by
  refine ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z,
    (fun _ => rfl), ?_, ?_⟩
  · intro t
    simpa only [harmonicEnergy_eq_massHamiltonian] using harmonicFlow_energy Ω hΩ z t
  · intro γ hγ hinit t
    have heq := mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_univ isPreconnected_univ (mem_univ (0 : ℝ)) hγ
      (harmonicFlow_isMechanicalSolution Ω hΩ z)
      (fun s _ => mechanicalVectorField_contDiffAt _ _ (γ s) (by fun_prop))
      (by simpa using hinit)
    exact heq (mem_univ t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.harmonic_solution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot x=v,\qquad\dot v=-\Omega^2x.\]；\[x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).\] | MD.Ch01.harmonic_solution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.harmonic_solution | 补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。 |

[EXTRA] Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。；[EXTRA] 补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
已写的harmonic_solution本身正确：PASS其动力学、全实时间域、单位质量、初值和位置公式。PhaseSpace第二分量是动量，单位质量下等于速度；mechanicalVectorField的第一分量确为该速度，harmonicFlow第二分量也是位置的真实导数，n=1还原原式。按本任务“全部对象/完整结论”审校，仍有覆盖缺项：所给同source全部声明/依赖没有定义或连接原句的能量E=|v|²/2+Ω²|x|²/2；且只验证所构造的流，不含“任意满足该初值的解都由此公式给出”的唯一性结论。此FAIL是完整覆盖失败，不是现有显式式为假，不涉及sorry。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:659；MD.Ch01.harmonic_solution。

## 1. MD-1.2-ScalarMechanical · Example 1.4 · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $m=1$ for simplicity) and energy function $E(x,\dot x)=\dot x^2/2+U(x)$ (which includes the harmonic oscillator as a special case). The equations of motion are
> \[\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def scalarMechanicalEnergy (U : ℝ → ℝ) (z : ℝ × ℝ) : ℝ :=
  z.2^2 / 2 + U z.1

/-- E explicitly names this model's prescribed mechanical energy. -/
def scalarMechanicalModel (U : ℝ → ℝ) (E : ℝ × ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  E = scalarMechanicalEnergy U ∧
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalarMechanicalModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.\] | MD.Ch01.scalarMechanicalModel，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.scalarMechanicalModel | 沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.scalarMechanicalModel | 沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。 |
| 21号网站建议修复 | MD.Ch01.scalarMechanicalModel | 补E_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。 |

[EXTRA] [EXTRA] 19号：沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。；[EXTRA] 补E_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：补E_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
scalarMechanicalModel的动力学部分PASS：任意实势U、实时间相轨迹z，逐时刻要求U在位置可微，HasDerivAt z (v,−U′(x))同时给出真实x′=v及v′=−U′，与单位质量方程相符，最新[EXTRA]也落实。完整条目仍FAIL：原句还定义E(x,ẋ)=ẋ²/2+U(x)，而所给全部当前声明只有ODE谓词；context_notation提到的scalarPotentialEnergy并未给出定义或能量识别，不能把一个名字当成已经形式化。未要求本条之外的局部积分论证或能量守恒定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:689；MD.Ch01.scalarMechanicalModel。

## 1. MD-1.2-ScalarQuadrature · unnumbered_claim · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Near this point, provided $\eta\ne0$, let us solve the equation $E(x,v)=E(\xi,\eta)$ for $v$ as a unique smooth function of $x,\xi,\eta$ using the implicit function theorem: $v=V(x,\xi,\eta)$. Inserting this into the differential equations we then find
> \[\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).\]
> This is a separable differential equation; it is therefore easily integrated from any provided initial value, $x(0)=\xi$, as a function of $t$, resulting in a relation $x=X(t,\xi,\eta)$. Then $v=V(X(t,\xi,\eta),\xi,\eta)$ and we see that it is possible to derive the formula for the solution $(x,v)$ as a function of $t$ and the initial conditions.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem scalar_quadrature (U : ℝ → ℝ) (hU : ContDiff ℝ ∞ U)
    (ξ η : ℝ) (hη : η ≠ 0) :
    ∃ δ > 0, ∃ ε > 0, ∃ V X : ℝ → ℝ → ℝ → ℝ,
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => V z.1 z.2.1 z.2.2)
        {z | |z.1-ξ| < δ ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => X z.1 z.2.1 z.2.2)
        {z | |z.1| < ε ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      (∀ ζ κ, |ζ-ξ| < δ → |κ-η| < δ → V ζ ζ κ = κ ∧ X 0 ζ κ = ζ) ∧
      (∀ x ζ κ, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ →
        scalarPotentialEnergy U (x,V x ζ κ) = scalarPotentialEnergy U (ζ,κ)) ∧
      (∀ x ζ κ v, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ → |v-η| < δ →
        scalarPotentialEnergy U (x,v) = scalarPotentialEnergy U (ζ,κ) → v = V x ζ κ) ∧
      ∀ t ζ κ, |t| < ε → |ζ-ξ| < δ → |κ-η| < δ →
        HasDerivAt (fun s => X s ζ κ) (V (X t ζ κ) ζ κ) t ∧
        HasDerivAt (fun s => V (X s ζ κ) ζ κ) (-deriv U (X t ζ κ)) t ∧
        separableTimePrimitive (fun x => V x ζ κ) ζ (X t ζ κ) = t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalar_quadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).\] | MD.Ch01.scalar_quadrature，完整展开陈述见上一行及第4段 | 一致 |
| V(x,ξ,η)光滑且能量式局部唯一确定速度 | 联合ContDiffOn ℝ ∞ V及隐式能量唯一性 | 一致 |
| 积分逆重建及初值参数光滑依赖 | 联合ContDiffOn ℝ ∞ X、实际ODE、X 0=ξ、积分=时间 | 一致；现有固定初值桥接不足 |
| 原文未显式量化的技术资格 | U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。 | [EXTRA] |

[EXTRA] U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。

### 6. 审计结论

已补完整x,ξ,η联合光滑参数化、局部唯一根、真实解与积分逆等式，未把固定初值局部定理当全条证明。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:697；MD.Ch01.scalar_quadrature。

## 1. MD-1.2-UniformLJSystem · Example 1.5 · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The energy of the system is
> \[E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),\]
> where $r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|$ and the mass $m$ of an argon atom is $6.69\times10^{-26}$ kg.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def uniformLJSystem {N : ℕ} (m ε σ : ℝ) (q v : Fin N → V3) : ℝ :=
  (∑ i, m * ‖v i‖^2 / 2) + uniformLJEnergy ε σ q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.uniformLJSystem；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),\] | MD.Ch01.uniformLJSystem，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:719；MD.Ch01.uniformLJSystem。

## 1. MD-1.2-RadialLJForceLiteral · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The equations of motion are, for $i=1,2,\ldots,N$, using the chain rule,
> \[m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j)
> =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](\boldsymbol q_i-\boldsymbol q_j).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  sorry

/-- 修正版，对应原文 MD-1.2-RadialLJForceLiteral，改动：第一式补负梯度负号，第二式外系数由−24ε/σ改为+24ε/σ；其余对象和量词不变。 -/
theorem radial_lj_force_literal_corrected {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (-deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  have hphi (r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential ε σ) r =
        (24*ε/r)*((σ/r)^6-2*(σ/r)^12) := by
    have hx := (hasDerivAt_const r σ).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*ε)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  constructor
  · exact hnewton
  · rw [hnewton]
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : ‖q i-q j‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr (hnc j hij))
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) = _
    rw [hphi _ hr,smul_smul]
    congr 1
    field_simp [hr,hσ.ne'] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.radial_lj_force_literal；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| \[m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j)<br>=-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](\boldsymbol q_i-\boldsymbol q_j).\] | MD.Ch01.radial_lj_force_literal，完整展开陈述见上一行及第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。 | [EXTRA] |

[EXTRA] 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。

### 6. 审计结论

Newton力为−∇U；印刷式把径向势梯度当成力，两个等号均反号。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
radial_lj_force_literal：字面忠实性PASS；对象、有限和排除自粒子、正ε/σ、固定i的非碰撞和负梯度Newton前提都相符，但原书力符号与式1.3冲突，故数学陈述需NEEDS_HUMAN，不能仅因其为假而把字面版判转录FAIL。radial_lj_force_literal_corrected：PASS；在相同全部对象、量词与前提下，第一式改为−φ′/r，第二式系数+24ε/σ，符合ljForce实际定义。对r≠0有φ′=24ε/r[(σ/r)^6−2(σ/r)^12]，两修正分句均正确；不需要额外假设a来自某条已存在轨迹。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:726；MD.Ch01.radial_lj_force_literal。

## 1. MD-1.2-LJCoordinateScaling · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> Now introduce the change of variables
> \[\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,\]
> then $\dot{\boldsymbol q}_i=\sigma\dot{\boldsymbol Q}_i$, $\ddot{\boldsymbol q}_i=\sigma\ddot{\boldsymbol Q}_i$, and $\|\boldsymbol q_i-\boldsymbol q_j\|=\sigma\|\boldsymbol Q_i-\boldsymbol Q_j\|$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lj_coordinate_scaling (Q : ℝ → V3) (σ t : ℝ) (v a : V3)
    (hσ : 0 < σ) (hv : HasDerivAt Q v t) (ha : HasDerivAt (deriv Q) a t) :
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
    HasDerivAt (fun s => σ • deriv Q s) (σ • a) t ∧
    ∀ r s : V3, ‖σ • r - σ • s‖ = σ * ‖r-s‖ := by
  refine ⟨hv.const_smul σ, ha.const_smul σ, ?_⟩
  intro r s
  rw [← smul_sub, norm_smul, Real.norm_eq_abs, abs_of_pos hσ]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lj_coordinate_scaling；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,\] | MD.Ch01.lj_coordinate_scaling，完整展开陈述见上一行及第4段 | 一致 |
| 一阶、二阶及所有距离缩放 | 两个HasDerivAt结论及∀r s, ‖σ•r-σ•s‖=σ*‖r-s‖ | 一致 |
| 原文未显式量化的技术资格 | σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。 | [EXTRA] |

[EXTRA] σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。

### 6. 审计结论

实际导数缩放与全部距离缩放结论均已保留；σ正保证原文范数缩放不缺绝对值。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:775；MD.Ch01.lj_coordinate_scaling。

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

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem ljtimescaling :
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    (((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)) ∧
    α⁻¹ = σ * Real.sqrt (m / ε) := by
  intro N m ε σ α Q hm he hs ha hscale hQ hnc
  have hfirst (i : Fin N) (t : ℝ) :
      deriv (fun s => σ • Q (α*s) i) t = (σ*α) • deriv (fun s => Q s i) (α*t) := by
    have hd := ((hQ i).differentiable (by norm_num) (α*t)).hasDerivAt.scomp t
      ((hasDerivAt_id t).const_mul α)
    simpa [Function.comp_def, Pi.smul_def, smul_smul] using (hd.const_smul σ).deriv
  have hsecond (i : Fin N) (t : ℝ) :
      deriv (deriv (fun s => σ • Q (α*s) i)) t =
        (σ*α^2) • deriv (deriv (fun s => Q s i)) (α*t) := by
    have hf : deriv (fun s => σ • Q (α*s) i) = fun s => (σ*α) • deriv (fun s => Q s i) (α*s) :=
      funext (hfirst i)
    rw [hf]
    have hQi : ContDiff ℝ (1+1) (fun s => Q s i) := hQ i
    have hd := (hQi.deriv'.differentiable (by norm_num) (α*t)).hasDerivAt.scomp t
      ((hasDerivAt_id t).const_mul α)
    simpa [Function.comp_def, Pi.smul_def, smul_smul,pow_two,mul_assoc] using (hd.const_smul (σ*α)).deriv
  have hphi (e s r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential e s) r =
        (24*e/r)*((s/r)^6-2*(s/r)^12) := by
    have hx := (hasDerivAt_const r s).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*e)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  have hforce (t : ℝ) (i : Fin N) :
      ljForce ε σ (fun j => σ • Q t j) i = (ε/σ) • ljForce 1 1 (Q t) i := by
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : 0 < ‖Q t i-Q t j‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (hnc t i j hij))
    have hd : pairDistance (σ • Q t i) (σ • Q t j) = σ * pairDistance (Q t i) (Q t j) := by
      simp [pairDistance,← smul_sub,norm_smul,Real.norm_eq_abs,abs_of_pos hs]
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) (pairDistance (σ • Q t i) (σ • Q t j)) / pairDistance (σ • Q t i) (σ • Q t j)) • (σ • Q t i - σ • Q t j) = _
    rw [hphi _ _ _ (by rw [hd]; exact ne_of_gt (mul_pos hs hr)),hphi 1 1 (pairDistance (Q t i) (Q t j)) (ne_of_gt hr),hd]
    rw [← smul_sub,smul_smul,smul_smul]
    congr 1
    dsimp [pairDistance]
    field_simp [hs.ne',hr.ne'] <;> ring
  have hcoeff : m*(σ*α^2) = ε/σ := by
    rw [hscale]
    field_simp [hs.ne',hm.ne'] <;> ring
  have hunit : α⁻¹ = σ*Real.sqrt (m/ε) := by
    apply (sq_eq_sq₀ (inv_nonneg.mpr ha.le) (mul_nonneg hs.le (Real.sqrt_nonneg _))).mp
    rw [mul_pow,Real.sq_sqrt (div_nonneg hm.le he.le),inv_pow,hscale]
    field_simp [hm.ne',hs.ne',he.ne'] <;> ring
  refine ⟨?_,hunit⟩
  constructor
  · intro h τ i
    have hh := h (τ/α) i
    rw [hsecond,hforce,smul_smul,hcoeff] at hh
    have ht : α*(τ/α) = τ := by field_simp [ha.ne']
    rw [ht] at hh
    have hc := congrArg (fun v : V3 => (σ/ε) • v) hh
    simpa [smul_smul,div_eq_mul_inv,hs.ne',he.ne',mul_assoc,mul_comm,mul_left_comm] using hc
  · intro h t i
    rw [hsecond,hforce,smul_smul,hcoeff,h (α*t) i]

/- Argon SI specialization: the printed approximation uses an explicit 0.01 ps tolerance. -/
theorem ljtimescaling_argon :
    |(3.4 / 10^10 : ℝ) * Real.sqrt ((6.69 / 10^26) / (1.65 / 10^21)) -
      2.17 / 10^12| < 0.01 / 10^12 := by
  have hs := Real.sq_sqrt (show (0 : ℝ) ≤ (6.69 / 10^26) / (1.65 / 10^21) by norm_num)
  have hp := Real.sqrt_nonneg ((6.69 / 10^26 : ℝ) / (1.65 / 10^21))
  rw [abs_lt]
  constructor <;> nlinarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.ljtimescaling；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},\]；\[\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).\]；\[\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.\] | MD.Ch01.ljtimescaling，完整展开陈述见上一行及第4段 | 一致 |
| 时间缩放得到无参数单位质量系统 | 真实C2非碰撞Q的原Newton系统 ↔ ∀τ i,Q″=ljForce 1 1 | 一致 |
| 单位时间 | α⁻¹=σ*Real.sqrt (m/ε) | 一致 |
| 原文未显式量化的技术资格 | m,ε,σ,α正；真实C2非碰撞轨迹。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.ljtimescaling; MD.Ch01.ljtimescaling_argon | 补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.ljtimescaling; MD.Ch01.ljtimescaling_argon | 补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。 |
| 21号网站建议修复 | MD.Ch01.ljtimescaling | 仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。 |

[EXTRA] m,ε,σ,α正；真实C²非碰撞轨迹。；[EXTRA] 氩参数m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m；实际ljtimescaling_argon结论采用显式容差0.01ps，非旧说明的0.005ps。给定参数下0.005ps界不成立；原书只写约2.17ps。保留双向缩放和时间单位结论。；[EXTRA] 本条采用显式容差0.01ps；两个定理保持不变。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
ljtimescaling：PASS。全部正参数、C²非碰撞Q、q(t)=σQ(αt)及α²关系明确；结论是有量纲Newton方程与全τ的单位参数方程双向等价，并给正确时间单位，反向时间覆盖由α>0保证。ljtimescaling_argon：按其实际签名PASS，给|τ−2.17ps|<0.01ps，常数和单位换算正确。但本条最新[EXTRA]明说显式容差0.005ps，实际结论却为0.01ps；且给定精确十进制参数下0.005ps界是假的。故接收材料的[EXTRA]一致性FAIL，不能把0.01当已证明0.005。corrected_json只将说明改成实际成立的0.01ps，不改原书近似或工程。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:789；MD.Ch01.ljtimescaling。

## 1. MD-1.3-Lagrangian · definition · 印刷p.22 / PDFp.45

### 2. 原文陈述

> For the system (1.3) with N atoms and $N_c=3N$ configuration coordinates, the Lagrangian is
> \[L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def fixedMassLagrangian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := nBodyKineticEnergy m v - U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.fixedMassLagrangian；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).\] | MD.Ch01.fixedMassLagrangian，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:876；MD.Ch01.fixedMassLagrangian。

## 1. MD-1.3-GeneralizedCoordinates · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> When we introduce a smooth change of variables $\boldsymbol q=\boldsymbol\Phi(\boldsymbol Q)$, where $\boldsymbol\Phi:\mathbb R^{N_c}\to\mathbb R^{N_c}$, this induces a corresponding transformation of the velocity vector by
> \[\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},\]
> where $\boldsymbol\Phi'$ is the $N_c\times N_c$ Jacobian matrix of $\boldsymbol\Phi$. Then the Lagrangian of the system is transformed to
> \[\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem generalized_coordinates {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t ∧
    massLagrangian m U (Φ (q t)) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ (q t)) := by
  exact ⟨hasDerivAt_coordinateChange Φ J q V t hΦ hq,
    massLagrangian_coordinateChange m U Φ J (q t) V⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.generalized_coordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},\]；\[\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),\] | MD.Ch01.generalized_coordinates，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。 | [EXTRA] |

[EXTRA] 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。Φ:Position k→Position n，J为n×k矩阵；hΦ明确J是q(t)处的真实Fréchet导数，hq明确q的实际速度V。第一结论通过链式法则给d(Φ∘q)/dt=JV；第二结论把massLagrangian的Σ_i m_i v_i²/2−U替换成⟨V,(Jᵀdiag(m)J)V⟩/2−U(Φ(q(t)))，矩阵排列、转置及系数均无误。标准实欧氏内积即原式行列乘积。原文smooth在点态结论中弱化至真实可微、k不必等于n，都是[EXTRA]已说明且成立的推广；本条代数恒等式不需正质量或满秩，正则可逆性由下一条另行处理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:883；MD.Ch01.generalized_coordinates。

## 1. MD-1.3-GeneralizedMassRegular · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> We will assume that any such changes of variables are regular transformations in the sense that $\boldsymbol\Phi'$ is of full rank and the resulting generalized mass matrix is invertible.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem generalizedmassregular :
  ∀ {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec),
    IsUnit (generalizedMassMatrix m J) := by
  exact @MolecularDynamics.generalizedMassMatrix_isUnit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.generalizedmassregular；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 正粒子质量；full rank为Jacobian列单射，符合n≥k。 | [EXTRA] |

[EXTRA] 正粒子质量；full rank为Jacobian列单射，符合n≥k。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
PASS。m给n个坐标质量且逐个严格正，J为n×k矩阵，Injective J.mulVec是满列秩，自动保证k≤n，符合原书约束参数化情形。generalizedMassMatrix实为Jᵀdiag(m)J；对非零v，由Jv≠0有vᵀJᵀMJv=Σ_i m_i(Jv)_i²>0，因此该k×k矩阵可逆。IsUnit正是矩阵环中的可逆性，未预先假设结论；k=0情形亦正常。J作为任意满足满列秩的矩阵推广覆盖真实Jacobian的情形；[EXTRA]正质量及列单射均落实。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:898；MD.Ch01.generalizedmassregular。

## 1. MD-1.4-ConvexLegendre · definition · 印刷p.24 / PDFp.47

### 2. 原文陈述

> Abstractly, a Legendre transformation of a given convex function $g=g(\boldsymbol\xi):\mathbb R^m\to\mathbb R$ is a new function $\widetilde g=\widetilde g(\boldsymbol\eta):\mathbb R^m\to\mathbb R$ defined by
> \[\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：新增原书“任意凸函数的变换处处实值”的literal陈述；默认EReal扩展实数，并给有界时实值备选。 -/
theorem legendreTransform_literal {n : ℕ} (g : Position n → ℝ)
    (hg : ConvexOn ℝ univ g) :
    ∀ η : Position n, ∃ r : ℝ, IsLUB (Set.range (fun θ => inner ℝ η θ - g θ)) r := by
  sorry

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：允许上确界为+∞。 -/
def legendreTransform_corrected {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：实值版显式要求有上界。 -/
theorem legendreTransform_corrected_b {n : ℕ} (g : Position n → ℝ) (η : Position n)
    (hb : BddAbove (Set.range (fun θ => inner ℝ η θ - g θ))) :
    IsLUB (Set.range (fun θ => inner ℝ η θ - g θ))
      (sSup (Set.range (fun θ => inner ℝ η θ - g θ))) := by
  exact isLUB_csSup (Set.range_nonempty _) hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.legendreTransform；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| \[\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),\] | MD.Ch01.legendreTransform，完整展开陈述见上一行及第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。 | [EXTRA] |

[EXTRA] 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。

### 6. 审计结论

凸性不能保证共轭函数每一点有限；实数sSup在无上界时的总化值不能充当真实上确界。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
legendreTransform 及 _corrected：PASS，任意 n、g:Position n→ℝ、η，EReal 的 iSup 正确实现扩展实共轭；未要求凸性是对所有实函数定义的合理推广，并未声称其处处实值。_literal：忠实性 PASS，ConvexOn univ 的任意 g 对每个 η 有实 IsLUB，正是原书实值断言，但数学上错误。_corrected_b：PASS，固定 η 的 BddAbove 加非空 range 足以推出实 sSup 的 IsLUB；凸性不是此上确界事实所必需。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:913；MD.Ch01.legendreTransform。

## 1. MD-1.4-HamiltonEquations · definition · 印刷p.24 / PDFp.47

### 2. 原文陈述

> The equations of motion can be written
> \[\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hamiltonEquationsOn {n : ℕ} (H : PhaseSpace n → ℝ)
    (I : Set ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t ∈ I, DifferentiableAt ℝ (fun v => H (q t,v)) (p t) ∧
    DifferentiableAt ℝ (fun x => H (x,p t)) (q t) ∧
    HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t

def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  hamiltonEquationsOn H univ q p
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamiltonEquations；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.\] | MD.Ch01.hamiltonEquations，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.hamiltonEquationsOn; MD.Ch01.hamiltonEquations | 沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.hamiltonEquationsOn; MD.Ch01.hamiltonEquations | 沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。 |

[EXTRA] [EXTRA] 19号：沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。

### 6. 审计结论

19号本地签名预审：沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。

网站：网站PASS（EAUDIT复审）。
hamiltonEquationsOn：任意 n、实值 H、任意时间集合 I 和 q/p 曲线；对每个 t∈I，要求两个冻结变量偏函数真实可微及 q′=∇pH、p′=-∇qH，符号、求值点及量词正确。时间导数用 HasDerivAt（不是总化 deriv），边界仍要求环境导数，与所披露资格一致。hamiltonEquations 恰为 I=univ。没有把偏导存在或全时间解存在当作自动结论。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:944；MD.Ch01.hamiltonEquations。

## 1. MD-1.4-HamiltonFixedMass · unnumbered_claim · 印刷p.24 / PDFp.47

### 2. 原文陈述

> For constant $\boldsymbol M$ we obtain the dynamical equations,
> \[\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamilton_fixed_mass {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun v => variableMassHamiltonian (fun _ => M) U q v)
      (matrixAction M⁻¹ p) p ∧
    HasGradientAt (fun x => variableMassHamiltonian (fun _ => M) U x p)
      (gradient U q) q := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hsym := Matrix.isSymmetric_toEuclideanLin_iff.mpr hM.inv.isHermitian
  have hKD : HasFDerivAt (fun v : Position n => inner ℝ v (B v)/2)
      (InnerProductSpace.toDual ℝ (Position n) (B p)) p := by
    have hd := (hasFDerivAt_id (𝕜 := ℝ) p).inner ℝ B.hasFDerivAt
    convert hd.mul_const ((2:ℝ)⁻¹) using 1
    · simp only [div_eq_mul_inv, id_eq]
    · ext v
      simp [fderivInnerCLM_apply, InnerProductSpace.toDual_apply_apply]
      have hs : inner ℝ p (B v) = inner ℝ (B p) v := (hsym p v).symm
      rw [hs, real_inner_comm v (B p)]
      ring
  constructor
  · rw [hasGradientAt_iff_hasFDerivAt]
    exact hKD.add_const (U q)
  · rw [hasGradientAt_iff_hasFDerivAt]
    exact hU.hasGradientAt.hasFDerivAt.const_add (inner ℝ p (B p)/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamilton_fixed_mass；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.\] | MD.Ch01.hamilton_fixed_mass，完整展开陈述见上一行及第4段 | 一致 |
| 一般固定矩阵M的两Hamilton偏梯度 | M.PosDef；动量梯度matrixAction M⁻¹ p，位置梯度gradient U q | 一致；保留一般SPD矩阵 |
| 原文未显式量化的技术资格 | 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。 | [EXTRA] |

[EXTRA] 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。

### 6. 审计结论

保留一般常质量矩阵，两个实际梯度给出全部Hamilton方程分量；旧库对角特例不匹配此忠实签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:951；MD.Ch01.hamilton_fixed_mass。

## 1. MD-1.4-HamiltonLagrangeEquivalence · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> More generally, for molecular models, the Hamiltonian and Lagrangian formulations are interchangeable, but the use of the Hamiltonian form is preferred for allowing simplified description of the geometric character of the solutions of the system as we discuss in Chaps. 2–4.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamiltonlagrangeequivalence :
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamiltonlagrangeequivalence；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。 | [EXTRA] |

[EXTRA] 一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
任意 n、配置相关 M/U、q/v 及开放 I；C² 和逐点对称正定 M 保证 Legendre 可逆及所用偏梯度真实。q′=v 单独为前提；左侧是 d/dt ∇vL=∇qL，右侧以 p(s)=M(q(s))v(s) 同时要求两条 Hamilton 方程，符号和冻结速度/动量位置正确。不是仅常质量特例，未假设待证等价。C²为充分的偏强资格，已披露；关于几何描述偏好的文字是说明而非额外可形式化定理。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:980；MD.Ch01.hamiltonlagrangeequivalence。

## 1. MD-1.4-PhaseSpace · definition · 印刷p.25 / PDFp.48

### 2. 原文陈述

> The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $\mathbb R^3$ is described by coordinates and positions, i.e., by a point in $\mathbb R^{6N}$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}





/-- 修正版，对应原文 MD-1.4-PhaseSpace，改动：有限能量位置×动量定义保留；把后句coordinates and positions按前句解释为位置与动量，并显式核验6N维。 -/
def finiteEnergyPhaseDomain_corrected {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}

theorem finiteEnergyPhaseDomain_corrected_dimension (N : ℕ) :
    Module.finrank ℝ (PhaseSpace (3*N)) = 6*N := by
  simp [PhaseSpace,Position,Momentum]
  omega
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.finiteEnergyPhaseDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。 | [EXTRA] |

[EXTRA] 采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。

### 6. 审计结论

后句重复位置，疑为positions/momenta文字笔误；前句定义及R^{6N}支持位置×动量解释。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
finiteEnergyPhaseDomain 与 _corrected：PASS，PhaseSpace n=Position n×Momentum n，H:EReal，排除顶和底恰表示有限实能量。_corrected_dimension：PASS，任意 N，包括0，证明的是环境向量空间 PhaseSpace(3*N) 的实维数 6*N，不是断言任意有限能量子集自身为6N维流形。修正版按前句把笔误理解成位置与动量合理；原文笔误仍需人工确认。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:996；MD.Ch01.finiteEnergyPhaseDomain。

## 1. MD-1.5-LocalExistUnique · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> One of the most important properties of a typical classical molecular Hamiltonian system is the existence and uniqueness of solutions started from a generic initial condition.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem local_exist_unique {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (hQ : IsOpen Q) (t₀ : ℝ) (z₀ : PhaseSpace n) (hz : z₀.1 ∈ Q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∃ ε γ, IsLocalMechanicalIVP m (fun q => -gradient U q) Q t₀ z₀ ε γ) ∧
    ∀ I γ η, IsOpen I → t₀ ∈ I →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I η →
      γ t₀ = z₀ → η t₀ = z₀ → γ =ᶠ[𝓝 t₀] η := by
  constructor
  · exact exists_localMechanicalIVP_open_of_force_contDiffAt m _ Q hQ t₀ z₀ hz (hreg _ hz)
  · intro I γ η hI ht hγ hη hi hj
    exact mechanicalSolution_eventually_unique_of_contDiffAt m _ Q I t₀ γ η z₀ hI ht hγ hη hi hj
      (mechanicalVectorField_contDiffAt m _ z₀ (hreg _ hz))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.local_exist_unique；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。 | [EXTRA] |

[EXTRA] generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
固定对角质量、开放非奇异配置域 Q，z₀.1∈Q，任意 t₀；力 -∇U 在Q各点 C¹。存在 ε>0、γ(t₀)=z₀、两侧开时间区间上的真实机械积分曲线并留Q；任意共同开放时间域上的同初值解在 t₀ 邻域最终相等，正确表达局部唯一而非全函数相等。CoordinateMasses 只是实函数，未要求正/非零，故这是总化矩阵逆向量场的较广ODE定理；用于物理 Hamilton 模型须另有正质量背景，不能由本条推出零质量物理模型。数学上的局部存在唯一结论仍对该较广定义正确，未增加隐蔽结论。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1016；MD.Ch01.local_exist_unique。

## 1. MD-1.5-EnergySurface · definition · 印刷p.25 / PDFp.48

### 2. 原文陈述

> For given $E_0\geq U_{\min}$ define $\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def energySurface {n : ℕ} (H : PhaseSpace n → ℝ) (E : ℝ) := {z | H z = E}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energySurface；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1034；MD.Ch01.energySurface。

## 1. MD-1.5-EnergyBounds · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> Assume that $U$ is a potential energy function which is bounded below, $U\geq U_{\min}$. For given $E_0\geq U_{\min}$ define $\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}$. Then, for $(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}$ we have
> \[\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.\]
> $\boldsymbol M^{-1}$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $E_0$,
> \[U_{\min}\leq U(\boldsymbol q)\leq E_0.\]

### 3. 原文证明

> Then, for $(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}$ we have
> \[\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.\]
> $\boldsymbol M^{-1}$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $E_0$,
> \[U_{\min}\leq U(\boldsymbol q)\leq E_0.\]
原页能量不等式及正定推界论证逐字引用；与陈述合引部分保留，未添加原书没有的证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem energy_bounds {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : ∀ q, Umin ≤ U q) :
    (∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ →
      inner ℝ p (matrixAction M⁻¹ p) / 2 = E₀ - U q ∧
      inner ℝ p (matrixAction M⁻¹ p) / 2 ≤ E₀ - Umin ∧ Umin ≤ U q ∧ U q ≤ E₀) ∧
    ∃ R : ℝ, ∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ → ‖p‖ ≤ R := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energy_bounds；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.\]；\[U_{\min}\leq U(\boldsymbol q)\leq E_0.\] | MD.Ch01.energy_bounds，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。 | [EXTRA] |

[EXTRA] U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1040；MD.Ch01.energy_bounds。

## 1. MD-1.5-UniformLevelsCompact · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> What is needed is an assumption that the level sets $\widehat\Sigma_\alpha=\{\boldsymbol q\mid U(\boldsymbol q)=\alpha\}$ are bounded uniformly for $\alpha\in[U_{\min},E_0]$. Then it follows that solutions satisfying the energy constraint remain confined to a compact (closed and bounded) set.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem uniform_levels_compact {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : Continuous U) (hlower : ∀ q, Umin ≤ U q)
    (hlevels : ∃ R : ℝ, ∀ α ∈ Icc Umin E₀, ∀ q, U q = α → ‖q‖ ≤ R) :
    IsCompact {z : PhaseSpace n | variableMassHamiltonian (fun _ => M) U z.1 z.2 = E₀} := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.uniform_levels_compact；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。 | [EXTRA] |

[EXTRA] U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1053；MD.Ch01.uniform_levels_compact。

## 1. MD-1.5-CompactContinuation · unnumbered_claim · 印刷p.25–26 / PDFp.48–49

### 2. 原文陈述

> The uniqueness of solutions is easily verified in the usual way (as for the local result for uniqueness of solutions). The key point is that, with the energy constraint, solutions typically remain bounded for all time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
/- General confinement helper retained separately from the Hamiltonian result. -/
theorem compact_continuation_aux {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry

theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z₀ : PhaseSpace n) (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U)
    (hlower : ∃ b : ℝ, ∀ q, b ≤ U q)
    (hconfine : ∀ E : ℝ, Bornology.IsBounded {q : Position n | U q ≤ E}) :
    ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ γ ∧ γ 0 = z₀ ∧
      (∀ t, massHamiltonian m U (γ t) = massHamiltonian m U z₀) ∧
      Bornology.IsBounded (Set.range γ) ∧
      (∀ η : ℝ → PhaseSpace n,
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ η → η 0 = z₀ → η = γ) ∧
      (∀ a b η, 0 ∈ Ioo a b →
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ (Ioo a b) η → η 0 = z₀ →
        ∀ t ∈ Ioo a b, η t = γ t) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.compact_continuation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.compact_continuation_aux; MD.Ch01.compact_continuation | 主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.compact_continuation_aux; MD.Ch01.compact_continuation | 主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。 |

[EXTRA] 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。；[EXTRA] 19号：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。

### 6. 审计结论

19号本地签名预审：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。

网站：网站PASS（EAUDIT复审）。
aux：正质量、开放Q、C¹力、紧K⊂Q×P、初值在K，hconfine只量化已有局部解，不循环假设全局存在；结论是全实时间解且留K。主条：任意初值、正对角质量、全域C²实势、统一下界以及每个次水平集有界；结论同时含全时间机械解、初值、能量守恒、轨道有界、全局解函数唯一以及含0开区间上的局部解逐点唯一。闭次水平集由连续性给出，有限维闭有界给紧性；动量界由能量和正质量给出。原书p26的能级集在α区间上一致有界正对应次水平集有界，已展开背景，不把仅能量守恒误作普遍位置有界。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1074；MD.Ch01.compact_continuation。

## 1. MD-1.5-Nonconfining · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The assumption on $U$ is not satisfied by some simple potentials. For example consider $U(x,y)=x^2$ which is completely independent of $y$ and so places no restriction on that variable for constant energy.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nonconfining :
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1} := by
  intro h
  obtain ⟨R,hR⟩ := h.exists_norm_le
  let q : Position 2 := WithLp.toLp 2 ![1,|R|+1]
  have hb : ‖q‖ ≤ R := hR q (by simp [q])
  have hv : |R|+1 ≤ ‖q‖ := by
    simpa [q, abs_of_nonneg (by positivity : 0 ≤ |R|+1)] using PiLp.norm_apply_le q (1 : Fin 2)
  have := le_abs_self R
  linarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nonconfining；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1093；MD.Ch01.nonconfining。

## 1. MD-1.5.1-FlowMap · definition · 印刷p.26 / PDFp.49

### 2. 原文陈述

> Consider now the initial value problem
> \[\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\tag{1.5}\]
> in a $m$-dimensional space. If we assume that $f$ corresponds to a molecular Hamiltonian system satisfying the assumptions of the existence and uniqueness result of the previous subsection, then we may define a mapping from a point in phase space to the point $t$ units later along the time-evolution starting from the initial point. We refer to this map as the flow map and denote it by $\mathcal F_t$. $\mathcal F_t(\boldsymbol\xi)=\boldsymbol z(t)$ solves the initial value problem (1.5).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def flowMap {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ ξ, F 0 ξ = ξ) ∧ ∀ ξ t, HasDerivAt (fun s => F s ξ) (f (F t ξ)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flowMap；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\tag{1.5}\] | MD.Ch01.flowMap，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1108；MD.Ch01.flowMap。

## 1. MD-1.5.1-FlowEnergy · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The flow map of a Hamiltonian system conserves its Hamiltonian, thus
> \[H(\mathcal F_t(\boldsymbol\xi))\equiv H(\boldsymbol\xi).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ := by
  intro ξ t
  have hd (s : ℝ) : HasDerivAt (fun u => H (F u ξ)) 0 s := by
    let z := F s ξ
    let A := fderiv ℝ H z
    have hA : HasFDerivAt H A z := (hH z).hasFDerivAt
    have hq := hA.comp z.1 ((hasFDerivAt_id (𝕜 := ℝ) z.1).prodMk (hasFDerivAt_const (𝕜 := ℝ) z.2 z.1))
    have hp := hA.comp z.2 ((hasFDerivAt_const (𝕜 := ℝ) z.1 z.2).prodMk (hasFDerivAt_id (𝕜 := ℝ) z.2))
    simp only [Function.comp_def, id_eq] at hq hp
    let gq := gradient (fun q => H (q,z.2)) z.1
    let gp := gradient (fun p => H (z.1,p)) z.2
    have eqQ (v : Position n) : A (v,0) = inner ℝ gq v := by
      rw [inner_gradient_left, hq.fderiv]
      rfl
    have eqP (v : Position n) : A (0,v) = inner ℝ gp v := by
      rw [inner_gradient_left, hp.fderiv]
      rfl
    have hz : A (symplecticGradient H z) = 0 := by
      change A (gp,-gq) = 0
      have he : (gp,-gq) = (gp,0)+(0,-gq) := by simp
      rw [he, map_add, eqQ, eqP, inner_neg_right, real_inner_comm gq gp]
      ring
    have hh := hA.comp_hasDerivAt s ((hF ξ).2 s)
    have he : A (symplecticGradient H (F s ξ)) = 0 := hz
    rw [he] at hh
    simpa only [Function.comp_def] using hh
  have hc := is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
  simpa [(hF ξ).1] using hc
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flow_energy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[H(\mathcal F_t(\boldsymbol\xi))=H(\boldsymbol\xi).\] | MD.Ch01.flow_energy，完整展开陈述见上一行及第4段 | 一致 |
| 一般Hamilton流保能量，所有初值与时间 | ∀ξ t,H(F t ξ)=H ξ；hF为实际symplecticGradient H的ODE | 一致；守恒未作前提 |
| 原文未显式量化的技术资格 | H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。 | [EXTRA] |

[EXTRA] H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。

### 6. 审计结论

已改一般H和一般Hamilton流，保留所有初值/时间守恒，未把机械可分离特例当通用证明。

网站：网站PASS（EAUDIT复审）。
任意有限维相空间、可微实H、全时间F。hF只含F(0,ξ)=ξ及真实Hamilton ODE，不预设守恒。结论对每个初值和每个实t均为H(F(t,ξ))=H(ξ)；symplecticGradient 的两个偏梯度及负号正确。可微H足以链式求导得到沿轨道导数为零，不必额外C¹。声明数学等号正确，源JSON恢复书面恒等号。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1115；MD.Ch01.flow_energy。

## 1. MD-1.5.1-HarmonicPhaseFlow · definition · 印刷p.27 / PDFp.50

### 2. 原文陈述

> for which the solution subject to initial values $q(0)=q_0,p(0)=p_0$ is
> \[\begin{pmatrix}q(t)\\p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\\p_0\end{pmatrix}\equiv\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\\-q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)

theorem harmonicPhaseFlow_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    harmonicPhaseFlow Ω 0 z = z ∧
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω^2)) • q) univ univ (fun t => harmonicPhaseFlow Ω t z) := by
  constructor
  · simp [harmonicPhaseFlow]
  · exact harmonicFlow_isMechanicalSolution Ω hΩ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.harmonicPhaseFlow；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\begin{pmatrix}q(t)\\p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\\p_0\end{pmatrix}=\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\\-q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.\] | MD.Ch01.harmonicPhaseFlow，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.harmonicPhaseFlow; MD.Ch01.harmonicPhaseFlow_solution | 保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.harmonicPhaseFlow; MD.Ch01.harmonicPhaseFlow_solution | 保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。 |

[EXTRA] [EXTRA] 19号：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。

### 6. 审计结论

19号本地签名预审：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。

网站：网站PASS（EAUDIT复审）。
harmonicPhaseFlow 的两个分量与原式一致，n维共同频率推广合法。总函数本身允许Ω=0，但 harmonicPhaseFlow_solution 明确 hΩ:Ω≠0，结论含初值及单位质量、力 -(Ω²)q 的全时间真实积分曲线；没有声称零频总化式仍满足自由粒子方程。全部 [EXTRA] 已兑现。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1152；MD.Ch01.harmonicPhaseFlow。

## 1. MD-1.5.1-SpectralSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> If $\boldsymbol A$ has a basis of eigenvectors $\boldsymbol\eta_i$, $i=1,\ldots,m$, with corresponding eigenvalues $\lambda_1,\lambda_2,\ldots,\lambda_m$, then we may write the solution at time $t$ as
> \[\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i\]
> where the coefficients $c_i$ are obtained by solving the equation
> \[\boldsymbol z(t_0)\equiv \boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem spectralsolution :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E] {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ),
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i := by
  exact @MolecularDynamics.complexExponentialFlow_eigenbasis
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.spectralsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i\]；\[\boldsymbol z(t_0)=\boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.\] | MD.Ch01.spectralsolution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。 | [EXTRA] |

[EXTRA] 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意完备复赋范空间、有穷索引全基 b，A复连续线性、各基向量对应复特征值ν。有限基保证有限维；没有偷换实谱。公式对所有实elapsed time t和初值z，以b.repr z为系数，给复算子流的谱展开。将t实例化为目标时间减t₀即可得到原式；基坐标本身满足初值展开，省去显式t₀是时间平移的等价参数化。complexExponentialFlow 经 restrictScalars ℝ 的算子指数仍是原复线性系统的真实流。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1168；MD.Ch01.spectralsolution。

## 1. MD-1.5.1-BasisCoefficients · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> (ii) with our assumption that the $\{\boldsymbol\eta_i\}$ form a basis, the calculation of the coefficients is always possible, since the matrix $\boldsymbol X$ whose columns are the eigenvectors will be invertible, that is, the coefficients $c_i$ can be enumerated as the components of a vector $\boldsymbol c$ which satisfies the square linear system
> \[\boldsymbol\xi=\boldsymbol X\boldsymbol c.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  exact ⟨basisColumnMatrix_isUnit b, basisColumnMatrix_mulVec_repr b z,
    basisColumnMatrix_inverse_coefficients b z⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.basis_coefficients；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol\xi=\boldsymbol X\boldsymbol c.\] | MD.Ch01.basis_coefficients，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | RCLike域包含实/复两种；真实有限基。 | [EXTRA] |

[EXTRA] RCLike域包含实/复两种；真实有限基。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意m、RCLike域、EuclideanSpace 的完整 Fin m 基。basisColumnMatrix i j=b j i 确实以基向量作列；结论同时给矩阵可逆、X(b.repr z)=z以及X⁻¹z=b.repr z，包含可计算坐标及其唯一性依据，实复均覆盖。不要求特征向量性质是此线性代数子命题的合理推广。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1180；MD.Ch01.basis_coefficients。

## 1. MD-1.5.1-MatrixExponentialSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> An alternative expression for the solution is in terms of the exponential of the matrix $\boldsymbol A$ scaled by time,
> \[\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem matrixexponentialsolution :
  ∀ {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z),
    γ = fun t => matrixExponentialFlow A (t - t₀) z := by
  exact @MolecularDynamics.matrixExponentialFlow_unique
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.matrixexponentialsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.\] | MD.Ch01.matrixexponentialsolution，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意实m×m矩阵A、初值z、实t₀及全时间γ；hγ给真实导数γ′=Aγ，hinit给初值。结论是整个函数等于t↦matrixExponentialFlow A(t-t₀)z。依摘录展开为 exp((t-t₀)•A的连续算子表示)作用于z；有限维矩阵和连续线性算子代数同构保存指数，确为原式e^{A(t-t₀)}z。无对角化或实谱额外假设；本条是任意已给解的表示/唯一性，不单独新增存在结论。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1192；MD.Ch01.matrixexponentialsolution。

## 1. MD-1.5.1-MatrixExpSeries · unnumbered_claim · 印刷p.27–28 / PDFp.50–51

### 2. 原文陈述

> Alternatively, we may think of $\exp(\boldsymbol A)$ as the sum of the exponential series
> \[e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots\]
> although this is seldom the most efficient method to compute it (this series converges for all matrices $\boldsymbol A$, and so in fact the exponential expression for the solution of the linear system is well defined even in the absence of a full set of eigenvectors).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem matrix_exp_series {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A) := by
  exact MolecularDynamics.Chapter01Review.matrixExponentialSeries_hasSum A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.matrix_exp_series；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots\] | MD.Ch01.matrix_exp_series，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1204；MD.Ch01.matrix_exp_series。

## 1. MD-1.5.2-FirstIntegral · definition · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Another term for constant of motion is first integral. In general, if we have a dynamical system $\dot{\boldsymbol z}=f(\boldsymbol z)$, a first integral is a smooth function $I(\boldsymbol z)$ which is constant along solutions, for all values of the initial condition.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.smoothFirstIntegral；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
smoothFirstIntegral 的对象是有限维实欧氏空间上的向量场 f、区域 Q 和实值 I；结论同时要求 Q 上 C∞ 及 IsFirstIntegralOn。后者遍历所有开放时间区间、所有留在 Q 中并满足真实 HasDerivAt 的解，再量化任意两时刻，准确表达所有初值解上的常性，不偷加全局存在。Q 是原文定义的区域化参数；取 univ 即全空间版本。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1212；MD.Ch01.smoothFirstIntegral。

## 1. MD-1.5.2-FirstIntegralCriterion · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Since this should hold everywhere, the condition for $I$ to be a first integral is that $\nabla I\cdot f\equiv0$.

### 3. 原文证明

> Let $\boldsymbol z(t):t\in\mathbb R$ be a solution, then
> \[I(\boldsymbol z(t))\equiv I(\boldsymbol z(0))\Rightarrow0\equiv\frac{\mathrm d}{\mathrm dt}I(\boldsymbol z(t))=\nabla I(\boldsymbol z(t))\cdot\dot{\boldsymbol z}(t)=\nabla I(\boldsymbol z(t))\cdot f(\boldsymbol z(t)).\]
按渲染原页逐字转录原文论证。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem firstintegralcriterion :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x),
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0 := by
  exact @MolecularDynamics.isFirstIntegralOn_iff_differential
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.firstintegralcriterion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral_gradient_criterion。 | [EXTRA] |

[EXTRA] 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral_gradient_criterion。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
对任意完备实赋范空间 E，开放 Q、Q 上局部 C¹ 向量场和可微 J，给出第一积分与每点 dJ(f)=0 的双向等价。完备性、局部 C¹ 和开放域提供从每个初值出发的局部解，从而必要方向不因缺乏解而真空成立；充分方向由链式法则及区间连通性成立。以连续线性微分替代梯度内积是等价且更一般的表达，未把梯度相等式当作额外结论。原文 smooth 类的判据在更弱可微类中仍成立。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1219；MD.Ch01.firstintegralcriterion。

## 1. MD-1.5.2-PlanarGraphReduction · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> In principle such an equation can be solved (locally at least) for $y$ as a function of $x$ due to the implicit function theorem. Hence one may write $y=\psi(x)$. Reinsert this into the first differential equation to get a reduced equation in just one dependent variable:
> \[\frac{\mathrm dx}{\mathrm dt}=g(x,\psi(x)).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem planargraphreduction :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0),
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t) := by
  exact @MolecularDynamics.planarFirstIntegral_localGraph_reduction
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planargraphreduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\frac{\mathrm dx}{\mathrm dt}=g(x,\psi(x)).\] | MD.Ch01.planargraphreduction，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。 | [EXTRA] |

[EXTRA] 对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
量词覆盖任意平面向量场、区域、第一积分、真实解及区间内基点。hJ 是该点严格微分，hpartial 精确为 y 方向微分非零。结论给出可微图、附近整个水平集与图的双向等价、原轨道在局部时间窗的图表示及第一坐标的约化 ODE，非仅假设了所需结论。条件化签名正确；原句无条件措辞另标 NEEDS_HUMAN。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1230；MD.Ch01.planargraphreduction。

## 1. MD-1.5.2-PlanarQuadrature · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Such an ordinary differential equation is said to be separable, and theoretically can be solved, given an initial condition, for x as a function of t.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem planarquadrature :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (f (γ t₀)).1 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1,
        g (separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (γ t).1 = t - t₀) := by
  exact @MolecularDynamics.planarFirstIntegral_nonturning_quadrature
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarquadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 正则第一积分图及非转向速度非零；真实C2、局部积分逆。 | [EXTRA] |

[EXTRA] 正则第一积分图及非转向速度非零；真实C2、局部积分逆。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
原文句子与第4页相符。hfirst 不是约化结论假设；真实解、区间内基点、C¹ 正则性、y 偏导非零及 x 速度非零均明确。结论给局部 ψ、时间逆 g、g′(0)=f₁、解的局部参数化、积分原函数与 g 双向局部互逆以及整个小时间窗积分恒等式。δ 虽未用于邻域界，仅冗余存在量，不影响正确性。此为非转向点上的分离变量结论，额外非退化资格已披露。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1248；MD.Ch01.planarquadrature。

## 1. MD-1.5.2-ScalarFirstIntegral · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Example 1.6 The single degree of freedom model of Example 1.4 has the energy as a first integral. The system is therefore integrable.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem scalar_first_integral_and_quadrature :
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U),
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U)) ∧
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : (γ t₀).2 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (γ t₀).2 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1, g (separableTimePrimitive ψ (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive ψ (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive ψ (γ t₀).1 (γ t).1 = t - t₀)) := by
  exact ⟨@MolecularDynamics.scalarPotentialEnergy_isFirstIntegral, @MolecularDynamics.scalarPotential_nonturning_quadrature⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalar_first_integral_and_quadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| energy as a first integral | scalarPotentialEnergy_isFirstIntegral的完整签名 | 一致 |
| therefore integrable | scalarPotential_nonturning_quadrature的实际局部积分逆重建 | 一致；非转向资格显式 |
| 原文未显式量化的技术资格 | U C2；开放时间段真实解、积分逆图使用速度非零点；转向点全局拼接不声称已有证明。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.scalar_first_integral_and_quadrature | 本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。 |

[EXTRA] U C2；开放时间段真实解、积分逆图使用速度非零点；转向点全局拼接不声称已有证明。；[EXTRA] 本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
第5页 Example 1.6 转录相符。第一合取对任意 C² 势能证明能量 v²/2+U(x) 为 (v,−U′(x)) 的第一积分；第二合取的积分逆、局部参数化及速度符号均正确，但只量化速度非零点。相较原文“system is therefore integrable”的完整覆盖，缺少真实解在转向点的改用速度坐标求积、平衡点常解及相应重建说明。不是命题本身为假，也不是因 sorry 判 FAIL，而是覆盖不全。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1271；MD.Ch01.scalar_first_integral_and_quadrature。

## 1. MD-1.5.1-RealSpectralSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> Observations: (i) eigenvectors, eigenvalues, and coefficients $c_i$ may be complex, but if $\boldsymbol A$ and $\boldsymbol\xi$ have real coefficients, it is nonetheless possible to obtain a real solution,

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem realspectralsolution :
  ∀ {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ)
    (b : Module.Basis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (ν : Fin m → ℂ)
    (hb : ∀ j, Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)
      (b j) = ν j • b j)
    (z : EuclideanSpace ℂ (Fin m)) (hz : ∀ j, (z j).im = 0) (t : ℝ) (i : Fin m),
    ((∑ j, (b.repr z j * Complex.exp (ν j * (t : ℂ))) • b j) i).im = 0 := by
  exact @MolecularDynamics.realMatrix_complexSpectral_sum_isReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.realspectralsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1292；MD.Ch01.realspectralsolution。

## 1. MD-1.5.2-KeplerEnergy · definition · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Example 1.7 The Kepler problem describes the motion of a body in the plane moving under gravitational force exerted by a second, fixed body (located at the origin); it has the energy $E(x,y,\dot x,\dot y)=\dot x^2/2+\dot y^2/2-1/\sqrt{x^2+y^2}$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def planarKeplerEnergy (x y v w : ℝ) : ℝ :=
  v^2/2 + w^2/2 - 1/Real.sqrt (x^2+y^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarKeplerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1306；MD.Ch01.planarKeplerEnergy。

## 1. MD-1.5.2-KeplerConservedEnergy · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> The two conserved quantities, energy and angular momentum, mean that the Kepler problem is an integrable system.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem kepler_energy_angular_integrability :
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t)) ∧
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t)) ∧
  (∀ (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z),
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = (fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = (((fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀])) := by
  refine ⟨@MolecularDynamics.kepler_energy_const_on_Ioo 2, @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo, ?_⟩
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.kepler_energy_angular_integrability；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| energy and angular momentum | 平面真实解的kepler_energy_const_on_Ioo与kepler_planarAngularMomentum_const_on_Ioo完整签名 | 一致；两结论已桥接 |
| mean that … is an integrable system | 整个非碰撞存在区间的径向quadrature、角积分与初值重建合取 | 一致；未以只证明能量守恒代替全部结论 |
| 原文未显式量化的技术资格 | 真实平面非碰撞机械解；积分重建的整个存在区间含0，角为连续实提升；不声称穿越碰撞的全局轨道。 | [EXTRA] |

[EXTRA] 真实平面非碰撞机械解；积分重建的整个存在区间含0，角为连续实提升；不声称穿越碰撞的全局轨道。

### 6. 审计结论

逐字整句含能量守恒、角动量守恒与可积性三结论；已扩为完整合取。两守恒量用既有证明，完整极坐标/quadrature重建保持占位。

网站：网站PASS（EAUDIT复审）。
第6页整句转录相符。签名三重合取覆盖单位质量非碰撞平面解的能量常性、平面角动量常性，以及含0存在区间的径向—角向重建。massHamiltonian 展开为各动量平方/2减范数倒数；planarAngularMomentum 是 q₀p₁−q₁p₀。重建给 r>0、r′=v、有效势径向 ODE、角积分及位置；ScalarPotentialLocalDescription 覆盖径向非转向、转向及平衡三类，并用初始位置和动量公式联系初值，未将重建当作假设。有效势在 r=0 的总化不影响 r>0 上局部分类。原文可积性按求积与逆函数理解，未额外声称碰撞后的延拓。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1313；MD.Ch01.kepler_energy_angular_integrability。

## 1. MD-1.5.2-KeplerAngularMomentum · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> however, due to the fact that the potential energy is rotationally invariant (dependent only on the distance of the moving particle from the origin), the angular momentum of the system is conserved.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerangularmomentum :
  ∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) := by
  exact @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerangularmomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第7页转录相符。任意非碰撞单位质量平面机械解、任意同一开放区间内 s,t，结论 q₀p₁−q₁p₀ 相等。velocityOperator 在单位质量下为恒等，故动量就是速度，与原文 xẏ−yẋ 一致。keplerForce 是径向中心力，力矩为零；这里只专门化原书 Kepler 例，未声称已形式化任意旋转不变势的 Noether 定理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1346；MD.Ch01.keplerangularmomentum。

## 1. MD-1.5.2-KeplerMomentum · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Note that a consequence of fixing one of the bodies in the Kepler problem is that the two components of the total momentum vector, i.e. $(m\dot x,m\dot y)$, are obviously no longer conserved;

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplermomentum :
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0 := by
  intro q hq
  simp [keplerForce, smul_eq_zero, hq, norm_ne_zero_iff.mpr hq]

theorem keplermomentum_not_first_integrals :
    ∀ i : Fin 2, ¬ IsFirstIntegralOn
      (mechanicalVectorField (fun _ : Fin 2 => (1 : ℝ)) keplerForce)
      {z : PhaseSpace 2 | z.1 ≠ 0} (fun z : PhaseSpace 2 => z.2 i) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplermomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | q≠0；单位质量。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.keplermomentum; MD.Ch01.keplermomentum_not_first_integrals | 保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.keplermomentum; MD.Ch01.keplermomentum_not_first_integrals | 保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。 |

[EXTRA] q≠0；单位质量。；[EXTRA] 19号：保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。

### 6. 审计结论

19号本地签名预审：保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。

网站：网站PASS（EAUDIT复审）。
第8页转录相符。主声明对每个 q≠0 给非零向心力，正确但单独不足以证明两个坐标分别不是第一积分。[EXTRA] keplermomentum_not_first_integrals 对每个 i∈Fin 2 分别否定坐标动量在整个非碰撞相空间上、对所有真解的常性，补齐原文语义。取初始 q=eᵢ 时该坐标动量导数为−1，因此否定成立；不误称每条轨道的每个分量都变化。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1358；MD.Ch01.keplermomentum。

## 1. MD-1.5.2-PolarCoordinates · definition · 印刷p.29 / PDFp.52

### 2. 原文陈述

> In polar coordinates $(x,y)=(r\cos\theta,r\sin\theta)$, the Lagrangian $L$ for the Kepler problem is

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def polarCoordinates (r θ : ℝ) : Position 2 := WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.polarCoordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1373；MD.Ch01.polarCoordinates。

## 1. MD-1.5.2-KeplerPolarLagrangian · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> \[L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.\]

### 3. 原文证明

> \[L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.\]
原页三角/代数恒等式计算即原文论证，逐字引用；原文陈述中的同一计算保留。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerpolarlagrangian :
  ∀ (r θ v omega : ℝ),
    ((v * Real.cos θ - r * omega * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * omega * Real.cos θ) ^ 2) / 2 + 1 / r =
    v ^ 2 / 2 + r ^ 2 * omega ^ 2 / 2 + 1 / r := by
  exact @MolecularDynamics.keplerPolarLagrangian_identity
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerpolarlagrangian；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.\] | MD.Ch01.keplerpolarlagrangian，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1379；MD.Ch01.keplerpolarlagrangian。

## 1. MD-1.5.2-KeplerPolarODE · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Working these out directly, one gets
> \[\ddot r=-\frac1{r^2}+r\dot\theta^2,\qquad0=\frac{\mathrm d}{\mathrm dt}(r^2\dot\theta).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerpolarode :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ),
    IsKeplerPolarEulerLagrangeOn I r θ v omega ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (omega t) t ∧
        HasDerivAt v (r t * omega t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * omega u) 0 t := by
  exact @MolecularDynamics.keplerPolar_eulerLagrange_iff
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerpolarode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\ddot r=-\frac1{r^2}+r\dot\theta^2,\qquad0=\frac{\mathrm d}{\mathrm dt}(r^2\dot\theta).\] | MD.Ch01.keplerpolarode，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第9页两式转录相符。对任意时间集合 I 和 r,θ,v,omega，左侧完整展开为正半径、r′=v、θ′=omega 及 L=v²/2+r²omega²/2+1/r 的两条 Euler–Lagrange 方程。对速度和半径的偏导分别为 v、r omega²−r⁻²；角动量偏导为 r²omega，角偏导为0。右侧恰给这两式及真实一阶导数，故不是用同义命名掩盖缺失运动方程。context_notation 的“r≠0”可加强精确写为“r>0”，签名本身无误。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1390；MD.Ch01.keplerpolarode。

## 1. MD-1.5.2-PolarAngularIdentity · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Expressed in polar coordinates this is
> \[l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta)
> =r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,\]

### 3. 原文证明

> Expressed in polar coordinates this is
> \[l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta)
> =r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,\]
原页三角/代数恒等式计算即原文论证，逐字引用；原文陈述中的同一计算保留。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem polarangularidentity :
  ∀ (r θ v omega : ℝ),
    (r * Real.cos θ) * (v * Real.sin θ + r * omega * Real.cos θ) -
      (r * Real.sin θ) * (v * Real.cos θ - r * omega * Real.sin θ) = r ^ 2 * omega := by
  exact @MolecularDynamics.polarAngularMomentum_identity
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.polarangularidentity；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta)<br>=r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,\] | MD.Ch01.polarangularidentity，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1402；MD.Ch01.polarangularidentity。

## 1. MD-1.5.2-KeplerRadialReduction · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Taking this quantity as fixed, we may write the remaining equation as $\ddot r=-1/r^2+l_z^2/r^3$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerradialreduction :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v omega) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * omega t = l),
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t := by
  exact @MolecularDynamics.keplerPolar_radial_reduction
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerradialreduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。 | [EXTRA] |

[EXTRA] r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第10页转录相符。任意极坐标 Euler–Lagrange 真解、任意 t∈I、任意等于当时 r²omega 的 l，结论 v′=−r⁻²+l²/r³。由正半径及 omega=l/r² 代入径向式直接成立。hl 虽是单时刻相等而非全区间常数，已经足够推出本条点态结论；作为固定守恒角动量的应用需再结合上一条在连通时间区间的常性，未虚构全局常性。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1412；MD.Ch01.keplerradialreduction。

## 1. MD-1.5.2-KeplerRadialEnergy · definition · 印刷p.29–30 / PDFp.52–53

### 2. 原文陈述

> The equation for $r$ is that of a one-degree-of-freedom system with energy
> \[\widehat E(r,\dot r)=\frac{\dot r^2}2-\frac1r+\frac{l_z^2}{2r^2}.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def radialKeplerEnergy (ℓ r v : ℝ) : ℝ := v^2/2-1/r+ℓ^2/(2*r^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.radialKeplerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\widehat E(r,\dot r)=\frac{\dot r^2}2-\frac1r+\frac{l_z^2}{2r^2}.\] | MD.Ch01.radialKeplerEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1423；MD.Ch01.radialKeplerEnergy。

## 1. MD-1.5.2-KeplerFullSolution · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> From our previous work, we know that this system (a single degree of freedom system) can be solved for $r$ as a function of $t$ and the initial conditions. Once $r=r(t)$ is known, we may obtain $\theta$ by integration:
> \[\theta=\theta(0)+\int_0^t\frac{l_z}{r^2(s)}\,\mathrm ds.\]
> The example shows that the full solution of the Kepler problem can be worked out given the initial conditions, as long as we are happy to express the solution in terms of antiderivatives of simple functions (and their inverses).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem kepler_full_solution (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z) :
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = polarCoordinates (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = ((polarCoordinates (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀]) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.kepler_full_solution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\theta=\theta(0)+\int_0^t\frac{l_z}{r^2(s)}\,\mathrm ds.\] | MD.Ch01.kepler_full_solution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。 | [EXTRA] |

[EXTRA] 完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
第11页三段原文及角积分转录相符。任意含0非碰撞平面真解产生全区间正半径、径向真导数和有效势方程、连续实角提升的积分表达、位置重建以及初始全相空间公式。ScalarPotentialLocalDescription 展开覆盖每个 t₀ 的非转向积分逆、转向交换坐标积分逆或径向常解；后者包括圆轨道，不误作整个二维轨道静止。θ₀ 与 z(0) 的对应由初始公式给定。声明不单独断言从任意初值构造解/唯一解，但在已有真解语境下完整给出本条求积表示和重建，符合披露的存在区间资格。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1429；MD.Ch01.kepler_full_solution。

## 1. MD-1.5.2-ActionAngleCoordinates · definition · 印刷p.30 / PDFp.53

### 2. 原文陈述

> Define new variables
> \[x=\sqrt{2I/\Omega}\cos\theta,\qquad v=\sqrt{2I\Omega}\sin\theta.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def oscillatorActionAngle (Ω I θ : ℝ) : ℝ × ℝ :=
  (Real.sqrt (2*I/Ω)*Real.cos θ, Real.sqrt (2*I*Ω)*Real.sin θ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.oscillatorActionAngle；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[x=\sqrt{2I/\Omega}\cos\theta,\qquad v=\sqrt{2I\Omega}\sin\theta.\] | MD.Ch01.oscillatorActionAngle，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1449；MD.Ch01.oscillatorActionAngle。

## 1. MD-1.5.2-ActionEnergy · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> In these variables, the energy is $E=I\Omega$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem actionenergy :
  ∀ (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J),
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω := by
  exact @MolecularDynamics.harmonicAction_energy
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.actionenergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω>0，I≥0；harmonicActionVelocity_formula保证v的sqrt(2IΩ)形式一致。 | [EXTRA] |

[EXTRA] Ω>0，I≥0；harmonicActionVelocity_formula保证v的sqrt(2IΩ)形式一致。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第12页原文 E=IΩ 相符。对 Ω>0、J≥0 及任意实角 θ，位置 A cosθ、速度 ΩA sinθ，A=√(2J/Ω)，代入 v²/2+Ω²x²/2 得 JΩ。Ω>0 保证 ΩA=√(2JΩ)，与原书速度坐标一致；允许 J=0 的能量等式正确，不需要此处定义非退化角。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1456；MD.Ch01.actionenergy。

## 1. MD-1.5.2-ActionODE · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> Introducing these formulas into the equations of motion and simplifying leads to $\dot I=0$, $\dot\theta=-\Omega$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem actionode :
  ∀ (Ω : ℝ) (J θ : ℝ → ℝ) (d omega t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ omega t),
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ omega = -Ω := by
  exact @MolecularDynamics.harmonicAction_ode_iff
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.actionode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω,I正；真实I′、θ′，非退化局部角坐标。 | [EXTRA] |

[EXTRA] Ω,I正；真实I′、θ′，非退化局部角坐标。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第13页转录相符。Ω>0、J(t)>0，给 J 和 θ 在 t 的真实导数 d、omega；双向等价将重建位置速度的两条谐振子 ODE 精确化为 d=0、omega=−Ω。正 J 保证角坐标非退化且振幅平方根可微，消去二元线性系统合法；原书正号速度与负号角速度一致，没有符号翻转。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1466；MD.Ch01.actionode。

## 1. MD-1.5.2-ActionSolution · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> The first equation expresses the constancy of energy; the second describes a rotation with frequency $\Omega$, i.e., the solution is $\theta(t)=\theta(0)-\Omega t$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem actionsolution :
  ∀ (Ω a b : ℝ) (J θ : ℝ → ℝ)
    (hΩ : 0 < Ω) (hJ : ∀ t ∈ Ioo a b, 0 < J t)
    (hreg : ∀ t ∈ Ioo a b, DifferentiableAt ℝ J t ∧ DifferentiableAt ℝ θ t)
    (hODE : ∀ t ∈ Ioo a b,
      HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    J t = J s ∧ θ t = θ s - Ω * (t - s) := by
  exact @MolecularDynamics.harmonicAction_time_formula
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.actionsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 连通开放时间窗含起始s；正action及Ω，真实坐标解。 | [EXTRA] |

[EXTRA] 连通开放时间窗含起始s；正action及Ω，真实坐标解。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第14页转录相符。Ω>0、全开放区间正 J、J 和实角提升处处可微及重建量满足两条谐振子 ODE，推出任意 s,t∈同一区间的 J(t)=J(s)、θ(t)=θ(s)−Ω(t−s)。区间连通性排除跳支；无需额外假定全局实角定义以外的周期连续选择。s=0 且0在区间内即原书公式；同时保留第一方程的能量常性。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1479；MD.Ch01.actionsolution。

## 1. MD-1.5.2-HarmonicTorus · definition · 印刷p.30 / PDFp.53

### 2. 原文陈述

> The simple change of variables $((x_j,v_j)\to(I_j,\theta_j))$, applied to each oscillator, would yield equations of motion $\dot I_j=0$, $\dot\theta_j=-\Omega_j$. This describes a point winding about a $d$-dimensional torus defined by angular rotation frequencies $\Omega_j$ and radii $|I_j|$ (Fig. 1.14).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.oscillatorTorusMotion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
oscillatorTorusMotion 为任意 d、固定实 action 向量 I、频率 Ω、初始模2π角向量定义 (I, θ₀−Ωt)。展开 HarmonicTorus 和 rotation 可核对全部分量，确实保持每个 action 并以负频率旋转；这是原文作用角运动的定义层表示，而非已证明原相空间与该环面的微分同胚。原书“radii |I_j|”在此由固定 action 参数记录，未给额外几何嵌入；当 action 为0时不应由本定义推出原相空间等能层仍有 d 维。作为 definition 审校通过，不能将其引用为无退化条件的坐标变换定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1496；MD.Ch01.oscillatorTorusMotion。

## 1. MD-1.5.2-TorusPeriod · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> Depending on the ratio of frequencies such motions may be periodic or quasi-periodic;

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem torusperiod :
  ∀ {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n),
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T := by
  exact @MolecularDynamics.harmonicTorusRotation_periodic_iff_integer

/-- Finite-dimensional torus translation: a quasiperiodic representation allows resonances. -/
def torusQuasiperiodic {n : ℕ} (γ : ℝ → HarmonicTorus n) : Prop :=
  ∃ (Ω : Fin n → ℝ) (θ : HarmonicTorus n), γ = fun t => harmonicTorusRotation Ω t θ

theorem torusperiod_classification {n : ℕ} (Ω : Fin n → ℝ) (θ : HarmonicTorus n) :
    (∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) ∨
    (torusQuasiperiodic (fun t => harmonicTorusRotation Ω t θ) ∧
      ¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) := by
  classical
  by_cases h : ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T
  · exact Or.inl h
  · exact Or.inr ⟨⟨Ω,θ,rfl⟩,h⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.torusperiod；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.torusperiod; MD.Ch01.torusQuasiperiodic; MD.Ch01.torusperiod_classification | 保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.torusperiod; MD.Ch01.torusQuasiperiodic; MD.Ch01.torusperiod_classification | 保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。 |

[EXTRA] 给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。；[EXTRA] 19号：保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。

### 6. 审计结论

19号本地签名预审：保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。

网站：网站PASS（EAUDIT复审）。
第16页原文相符。torusperiod 对任意有限 n、频率向量、实 T 和初角，给指定 T 是周期当且仅当每个 ΩⱼT 是2π整数倍；T=0、负T、零频率及 n=0 均正确。[EXTRA] torusQuasiperiodic 明示采用允许共振的有限环面平移表示定义；classification 用存在正周期与其否定给互斥完备二分。该定义比要求有理独立基频的某些惯例更宽，但已披露，结论没有声称非周期必稠密整个 n 维环面。原书按频率比的非形式化措辞在此有整数圈精确判据，不把 classification 的排中律误作独立无共振定理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1503；MD.Ch01.torusperiod。

## 1. MD-1.5.2-TorusDense · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> in the latter case the paths do not “close up” but instead we the curve gradually fills in the surface of the torus.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem torusdense :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：另补原句“非周期即充满整个环面”的literal；修正版显式全整数无共振，原有带资格陈述不变。 -/
theorem torusdense_literal :
    ∀ (n : ℕ) (Ω : Fin n → ℝ) (θ : HarmonicTorus n),
      (¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) →
      DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：明确全整数无共振资格。 -/
theorem torusdense_corrected :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.torusdense；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。 | [EXTRA] |

[EXTRA] 高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。

### 6. 审计结论

高维准周期运动可能只在真子环面稠密；无正周期不等于全维无共振。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
torusdense 与 torusdense_corrected 完全量化所有整数向量 k，要求 k·Ω=0 仅有零解；在连续实时间的模2π环面平移下这是全环面稠密的正确条件，不需要离散时间版本的额外常数项。torusdense_literal 只假设无正周期，忠实表达上下文 quasi-periodic 的字面推论，但 n≥3 时为假。分别结论：torusdense PASS；torusdense_literal 原文忠实性 PASS、原书数学 NEEDS_HUMAN；torusdense_corrected PASS。不能因 literal 带 sorry 判签名失败，也不能把修正版正确等同于原书无误。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1527；MD.Ch01.torusdense。

## 1. MD-1.5.2-LocalActionAngleReduction · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> More generally, one finds occasional examples of nonlinear systems which possesses as many independent first integrals as degrees of freedom (satisfying a certain “involution” condition); such systems may be reduced via coordinate transformation to action-angle variables, i.e. they exhibit tori motion.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem local_action_angle_reduction :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：原书无紧性资格的环面推断另记literal；默认紧、连通、非空、正则共同水平集，保留局部正则坐标与全局环面结论。 -/
theorem local_action_angle_reduction_literal :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：紧连通非空正则共同水平集。 -/
theorem local_action_angle_reduction_corrected :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.local_action_angle_reduction；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。 | [EXTRA] |

[EXTRA] 全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。

### 6. 审计结论

独立对合第一积分只给局部正则结构；非紧共同水平集未必为环面。IsConnected含非空。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
三个声明均核对：对象为2d维标准实相空间、d个C∞积分、全空间两两 Poisson 括号为零、共同水平集 S 及 S 上每点微分映射满射。symplecticGradient=(∂pH,−∂qH)，canonicalBilinear=dq∧dp，符号自洽。localActionAngle 要求开邻域上的双向光滑逆、保辛微分及全部 Hamilton 向量场被送到(0,Ωᵢ(q))，给局部正则坐标中的角向运动；它未明确规定新 action 就是原 I，属于合适的局部规约表达。主声明与 corrected 的 S 紧且 IsConnected（含非空）加正则性正好提供 Liouville–Arnold 环面资格；同一 e:S≃ₜTᵈ 同时线性化各个积分的流，Ω 的负号可吸收进选择的频率，不要求预指定正频率。literal 去掉紧连通资格而仍要 S≃ₜTᵈ，在非紧或空水平集上为假，但忠实反映原句过强措辞。分别：主声明 PASS；literal 忠实性 PASS、数学 NEEDS_HUMAN；corrected PASS。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1551；MD.Ch01.local_action_angle_reduction。

## 1. MD-1.5.3-Equilibrium · definition · 印刷p.31 / PDFp.54

### 2. 原文陈述

> An equilibrium point of such system is a solution of $f(\boldsymbol z)=0$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def equilibriumDefinition {n : ℕ} (f : Position n → Position n) (z : Position n) : Prop := f z = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilibriumDefinition；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1598；MD.Ch01.equilibriumDefinition。

## 1. MD-1.5.3-ConstantEquilibrium · unnumbered_claim · 印刷p.31 / PDFp.54

### 2. 原文陈述

> An equilibrium point $\boldsymbol z^*$ corresponds to an equilibrium solution, since if we define a constant function $\boldsymbol z(t)=\boldsymbol z^*$ then we have $\dot{\boldsymbol z}(t)=f(\boldsymbol z^*)=0$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constantequilibrium :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (f : E → E) (z₀ : E) (t : ℝ),
    HasDerivAt (fun _ : ℝ => z₀) (f z₀) t ↔ f z₀ = 0 := by
  exact @MolecularDynamics.equilibrium_constant_ode_iff
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constantequilibrium；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1604；MD.Ch01.constantequilibrium。

## 1. MD-1.5.3-EquilibriumLinearization · unnumbered_claim · 印刷p.31 / PDFp.54

### 2. 原文陈述

> We assume that $f$ is continuously differentiable in the vicinity of the equilibrium point $\boldsymbol z^*$ and make use of the fact that $f(\boldsymbol z)\approx f(\boldsymbol z^*)+f'(\boldsymbol z^*)(\boldsymbol z-\boldsymbol z^*)$ for $\|\boldsymbol z-\boldsymbol z^*\|$ sufficiently small. Since $f(\boldsymbol z^*)=0$ we have, defining $\delta\boldsymbol z:=\boldsymbol z-\boldsymbol z^*$,
> \[\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}\approx\boldsymbol A\delta\boldsymbol z,\qquad\boldsymbol A=f'(\boldsymbol z^*).\]
> The symbol $\approx$ is not very precise. In general, the approximation of solutions is only local in time meaning that solutions of the nonlinear system and the linear approximation may diverge. We refer to the system
> \[\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}=f'(\boldsymbol z^*)\delta\boldsymbol z\]
> as the linearization of the system (1.6) around $\boldsymbol z^*$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem equilibriumlinearization :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0),
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h) := by
  exact @MolecularDynamics.equilibrium_linearized_IVP
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilibriumlinearization；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}=\boldsymbol A\delta\boldsymbol z,\qquad\boldsymbol A=f'(\boldsymbol z^*).\] | MD.Ch01.equilibriumlinearization，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意实完备赋范空间（较原书有限维推广）、f在z₀处C¹、f(z₀)=0，以及任意初始扰动h₀和t₀。结论存在独立的线性曲线δ，δ(t₀)=h₀且δ′=Df(z₀)δ，并给 f(z₀+h)-Df(z₀)h=o(h)。heq使余项不用再减f(z₀)。没有把δ定义成任意非线性轨道减z₀，故Lean正确地区分一阶近似和线性化ODE。A阶段等号转录必须修正，不能据此给正确Lean判FAIL。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1613；MD.Ch01.equilibriumlinearization。

## 1. MD-1.5.3-Hyperbolic · definition · 印刷p.31–32 / PDFp.54–55

### 2. 原文陈述

> In case the equilibrium point is hyperbolic, meaning that the real parts of the eigenvalues of $\boldsymbol A=f'(\boldsymbol z^*)$ are nonzero,

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hyperbolic；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1625；MD.Ch01.hyperbolic。

## 1. MD-1.5.3-HartmanGrobmanLiteral · unnumbered_claim · 印刷p.31–32 / PDFp.54–55

### 2. 原文陈述

> then one can infer that the solutions of the nonlinear and linear systems are in fact topologically conjugate: if $\boldsymbol z$ is the solution of the nonlinear system and $\delta\boldsymbol z$ is the solution of the linear system, then there is a smooth, invertible map $\boldsymbol\Phi$ of $\mathbb R^m$ defined in a neighborhood of the origin such that
> \[\boldsymbol z(t)=\boldsymbol z^*+\boldsymbol\Phi(\delta\boldsymbol z(t)).\]
> This is referred to as the Hartman-Grobman theorem (for more discussion, see [177], where this result is referred to as the “Linearization Theorem”; a proof may be found in [362]).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hartmangrobmanliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry

/-- 修正版，对应原文 MD-1.5.3-HartmanGrobmanLiteral，改动：C∞可逆坐标替换改为连续互逆局部同胚；保留零点、邻域与留域期间共轭公式。 -/
theorem hartmangrobmanliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContinuousOn φ U ∧ ContinuousOn ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hartmangrobmanliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| \[\boldsymbol z(t)=\boldsymbol z^*+\boldsymbol\Phi(\delta\boldsymbol z(t)).\] | MD.Ch01.hartmangrobmanliteral，完整展开陈述见上一行及第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。 | [EXTRA] |

[EXTRA] C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。

### 6. 审计结论

C¹双曲系统的一般Hartman–Grobman结论为拓扑共轭，不保证C∞线性化。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
hyperbolic定义用实x/y表示复特征向量，(x≠0∨y≠0)及a≠0正确排除纯虚谱。isFlowOf只含初值和真实ODE，C¹提供唯一性；全局流是已披露的较强技术资格。主 literal：忠实性 PASS，开邻域U/V均含0、φ(0)=0、双向映射和逆关系，φ/ψ均C∞；在整个连接0至t的线性轨道留U期间给F(t,z+φx)=z+φ(e^{tA}x)。其数学真值有原书疑误。_corrected：PASS，完全相同量词、留域条件和公式，仅把坐标正则性改为连续互逆，正确为局部拓扑共轭。没有以“某一对解”代替共同坐标映射。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1633；MD.Ch01.hartmangrobmanliteral。

## 1. MD-1.5.3-LyapunovStability · definition · 印刷p.32 / PDFp.55

### 2. 原文陈述

> Let $\boldsymbol z^*$ be an equilibrium point. We say that $\boldsymbol z^*$ is stable (“in the sense of Lyapunov”) if, for all $\epsilon$, there exists $\delta$ such that, for all $\boldsymbol z_0$ such that $\|\boldsymbol z_0-\boldsymbol z^*\|<\delta$,
> \[\sup_{t\geq0}\|\mathcal F_t(\boldsymbol z_0)-\boldsymbol z^*\|<\epsilon.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovStable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, ‖x-z‖ < δ →
    BddAbove (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) ∧
    sSup (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) < ε
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lyapunovStable；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\sup_{t\geq0}\\|\mathcal F_t(\boldsymbol z_0)-\boldsymbol z^*\\|<\epsilon.\] | MD.Ch01.lyapunovStable，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。 | [EXTRA] |

[EXTRA] ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1664；MD.Ch01.lyapunovStable。

## 1. MD-1.5.3-HyperbolicStabilityTransfer · unnumbered_claim · 印刷p.32 / PDFp.55

### 2. 原文陈述

> The Hartman-Grobman theorem clearly implies that the stability of a given hyperbolic equilibrium point $\boldsymbol z^*$ of a nonlinear system can be inferred from the stability of the origin for the linearization of the system around $\boldsymbol z^*$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hyperbolicstabilitytransfer :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry

/-- 修正版，对应原文 MD-1.5.3-HyperbolicStabilityTransfer，改动：显式独立登记以拓扑共轭为依据的稳定性转移，不调用光滑literal。 -/
theorem hyperbolicstabilitytransfer_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hyperbolicstabilitytransfer；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。 | [EXTRA] |

[EXTRA] C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。

### 6. 审计结论

结论本身是标准推论，但原证明链不能依赖原书过强的光滑共轭。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：网站PASS（EAUDIT复审）。
两条声明主名和_corrected签名相同，均PASS。量化所有n、C¹ f、平衡z、双曲Df(z)、真实全局流F；结论为非线性平衡与线性指数流原点稳定性的双向等价。stable展开为每ε>0选δ>0，对每个近初值存在该轨道统一B<ε，全部t≥0距离≤B；这准确实现书面严格sup<ε，亦与通常Lyapunov稳定等价（缩小ε可得统一余量）。局部同胚及首次离域论证足以转移稳定性，无需错误的C∞共轭。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1673；MD.Ch01.hyperbolicstabilitytransfer。

## 1. MD-1.5.3-HamiltonEquilibrium · unnumbered_claim · 印刷p.32 / PDFp.55

### 2. 原文陈述

> Observe that an equilibrium point $\boldsymbol z^*=(\boldsymbol q^*,\boldsymbol p^*)$ of a Hamiltonian system in “kinetic plus potential” form
> \[H(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)\]
> will always have $\boldsymbol p^*=0$ and $\nabla U(\boldsymbol q^*)=0$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamilton_equilibrium {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q)
    (heq : gradient (fun v => variableMassHamiltonian (fun _ => M) U q v) p = 0 ∧
      gradient (fun x => variableMassHamiltonian (fun _ => M) U x p) q = 0) :
    p = 0 ∧ gradient U q = 0 := by
  have hg := hamilton_fixed_mass M U q p hM hU
  have hv : matrixAction M⁻¹ p = 0 := hg.1.gradient.symm.trans heq.1
  have hc : M⁻¹.mulVec (WithLp.ofLp p) = M⁻¹.mulVec 0 := by
    have hh := congrArg WithLp.ofLp hv
    simpa [matrixAction] using hh
  have hinj := Matrix.mulVec_injective_iff_isUnit.mpr hM.inv.isUnit
  have hp : p = 0 := by
    have hh := hinj hc
    simpa using hh
  exact ⟨hp,hg.2.gradient.symm.trans heq.2⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamilton_equilibrium；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[H(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)\] | MD.Ch01.hamilton_equilibrium，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。 | [EXTRA] |

[EXTRA] 一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1692；MD.Ch01.hamilton_equilibrium。

## 1. MD-1.5.3-StrongLocalMinimum · definition · 印刷p.32 / PDFp.55

### 2. 原文陈述

> We say that $\boldsymbol q^*$ is a strong local minimum of the potential if there exists $\epsilon>0$ such that
> \[0<\|\boldsymbol q-\boldsymbol q^*\|<\epsilon\Rightarrow U(\boldsymbol q)>U(\boldsymbol q^*).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def strongLocalMinimum {n : ℕ} (U : PotentialEnergy n) (qstar : Position n) : Prop :=
  ∃ ε > 0, ∀ q, 0 < ‖q-qstar‖ → ‖q-qstar‖ < ε → U qstar < U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.strongLocalMinimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[0<\\|\boldsymbol q-\boldsymbol q^*\\|<\epsilon\Rightarrow U(\boldsymbol q)>U(\boldsymbol q^*).\] | MD.Ch01.strongLocalMinimum，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1713；MD.Ch01.strongLocalMinimum。

## 1. MD-1.5.3-LinearizedHamiltonian · definition · 印刷p.32 / PDFp.55

### 2. 原文陈述

> If the potential is $C^2$, the linearized version of this system has “kinetic plus potential” form with Hamiltonian
> \[\widetilde H=\frac{\delta\boldsymbol p^T\boldsymbol M^{-1}\delta\boldsymbol p}2+\frac{\delta\boldsymbol q^T U''(\boldsymbol q^*)\delta\boldsymbol q}2.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def linearizedHamiltonian {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (δq δp : Position n) : ℝ :=
  inner ℝ δp (matrixAction M⁻¹ δp)/2 + inner ℝ δq (fderiv ℝ (gradient U) qstar δq)/2

theorem linearizedHamiltonian_field {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hM : M.PosDef)
    (hU : ContDiff ℝ 2 U) (heq : gradient U qstar = 0) :
    ∀ δz : PhaseSpace n,
      fderiv ℝ (symplecticGradient (fun z : PhaseSpace n =>
        inner ℝ z.2 (matrixAction M⁻¹ z.2)/2 + U z.1)) (qstar,0) δz =
      symplecticGradient (fun z : PhaseSpace n => linearizedHamiltonian M U qstar z.1 z.2) δz := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.linearizedHamiltonian；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\widetilde H=\frac{\delta\boldsymbol p^T\boldsymbol M^{-1}\delta\boldsymbol p}2+\frac{\delta\boldsymbol q^T U''(\boldsymbol q^*)\delta\boldsymbol q}2.\] | MD.Ch01.linearizedHamiltonian，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedHamiltonian; MD.Ch01.linearizedHamiltonian_field | 保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedHamiltonian; MD.Ch01.linearizedHamiltonian_field | 保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。 |

[EXTRA] [EXTRA] 19号：保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。

### 6. 审计结论

19号本地签名预审：保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。

网站：网站PASS（EAUDIT复审）。
linearizedHamiltonian定义精确给动量M⁻¹二次型加位置Hessian二次型，各1/2，M为常矩阵。单独定义使用总化fderiv，但field声明同时加M.PosDef、U全域C²及∇U(q*)=0，故Hessian为真实自伴Hessian。field对每个δz要求原Hamilton向量场在(q*,0)的Fréchet导数作用于δz等于该二次Hamilton向量场；这兑现“linearized version”的完整动力学对应，非仅同名函数。C²/正质量及平衡背景充分，未漏负号或交换相空间分量。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1720；MD.Ch01.linearizedHamiltonian。

## 1. MD-1.5.3-PositiveHessianQuadratic · unnumbered_claim · 印刷p.33 / PDFp.56

### 2. 原文陈述

> A condition for this system to have a strong local minimum at $\delta\boldsymbol p=0$, $\delta\boldsymbol q=0$ is that the Hessian matrix $U''(\boldsymbol q^*)$ be positive definite.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positivehessianquadratic :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    IsStrictPotentialMin (fun z : PhaseSpace n =>
      inner ℝ z.2 (M⁻¹.toEuclideanLin z.2)/2 + inner ℝ z.1 (K.toEuclideanLin z.1)/2) 0 := by
  intro n M K hM hK
  have hn (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosSemidef) (v : Position n) :
      0 ≤ inner ℝ v (A.toEuclideanLin v) := by
    change 0 ≤ inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    simpa using ha.dotProduct_mulVec_nonneg (x := WithLp.ofLp v)
  have hp (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosDef) (v : Position n) (hv : v ≠ 0) :
      0 < inner ℝ v (A.toEuclideanLin v) := by
    change 0 < inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    have hv' : WithLp.ofLp v ≠ 0 := by simpa using hv
    simpa using ha.dotProduct_mulVec_pos hv'
  refine ⟨1,by norm_num,?_⟩
  intro z hz _
  have hzn : z ≠ 0 := dist_pos.mp hz
  have hq := hn K hK.posSemidef z.1
  have hpp := hn M⁻¹ hM.inv.posSemidef z.2
  have hz0 : inner ℝ ((0:PhaseSpace n).2) (M⁻¹.toEuclideanLin (0:PhaseSpace n).2)/2 +
      inner ℝ ((0:PhaseSpace n).1) (K.toEuclideanLin (0:PhaseSpace n).1)/2 = 0 := by
    change inner ℝ (0:Position n) (M⁻¹.toEuclideanLin 0)/2 + inner ℝ (0:Position n) (K.toEuclideanLin 0)/2 = 0
    simp
  dsimp only
  rw [hz0]
  by_cases hqz : z.1 = 0
  · have hpz : z.2 ≠ 0 := by
      intro h; exact hzn (Prod.ext hqz h)
    nlinarith [hp M⁻¹ hM.inv z.2 hpz]
  · nlinarith [hp K hK z.1 hqz]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positivehessianquadratic；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | M正定，K=U″对称正定；一般矩阵。 | [EXTRA] |

[EXTRA] M正定，K=U″对称正定；一般矩阵。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
任意n、一般实矩阵M/K，M.PosDef和K.PosDef包含实对称性。结论IsStrictPotentialMin展开为某R>0内所有非零相点的二次Hamilton值严格高于原点；动量项M⁻¹及位置项K、1/2系数均正确。至少一个分量非零给严格正，故实际上全局严格最小，局部结论充分；零维结论真且无非零点。K是Hessian值的抽象替代，命题是充分条件，不误称必要条件，也不把“strong”误读为统一强凸常数。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1737；MD.Ch01.positivehessianquadratic。

## 1. MD-1.5.3-PositiveHessianMinimum · unnumbered_claim · 印刷p.33 / PDFp.56

### 2. 原文陈述

> In case the eigenvalues of $U''(\boldsymbol q^*)$ are all distinct and positive, then the strong local minimum property will also follow for $\boldsymbol q^*$ in relation to the original potential.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positive_hessian_minimum {n : ℕ} (U : PotentialEnergy n) (q : Position n)
    (hU : ContDiff ℝ 2 U) (hq : gradient U q = 0)
    (B : Module.Basis (Fin n) ℝ (Position n)) (freq : Fin n → ℝ)
    (hdistinct : Function.Injective freq) (hpos : ∀ i, 0 < freq i)
    (heig : ∀ i, fderiv ℝ (gradient U) q (B i) = freq i • B i) :
    IsStrictPotentialMin U q := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positive_hessian_minimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| distinct positive eigenvalues | Function.Injective freq；∀i,0<freq i；实特征基完整heig | 一致 |
| 势的严格局部极小 | IsStrictPotentialMin U q | 一致；未替换为纯二次型 |
| 原文未显式量化的技术资格 | C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。 | [EXTRA] |

[EXTRA] C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。

### 6. 审计结论

保留distinct及positive全部谱前提、平衡点与C2背景；不把distinct删掉。实Hessian对称确保可取实特征基。

网站：网站PASS（EAUDIT复审）。
任意n、实势U全域C²、平衡∇U(q)=0，实全基B、实特征值freq、Injective freq和每项>0，并要求Df(gradient U)q作用于B i等于freq i倍基向量。全部distinct positive eigenvalues经完整基覆盖；C²保证Hessian自伴，虽未给正交基也可由正谱推出正定。IsStrictPotentialMin恰为原书穿孔邻域严格最小，C²及平衡资格来自同节且已披露。特征值互异虽不必要但忠实保留，没有静默削弱或把正频率替代平方特征值。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1774；MD.Ch01.positive_hessian_minimum。

## 1. MD-1.6-UniformPairLattice · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> Let us suppose we have a uniform pair potential $\varphi$ and define the total potential energy of a system of N atoms by
> \[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi(|x_i-x_j|).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def latticePairPotential {N : ℕ} (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i, ∑ j ∈ Finset.Ioi i, φ |x i-x j|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.latticePairPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi(\|x_i-x_j\|).\] | MD.Ch01.latticePairPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1790；MD.Ch01.latticePairPotential。

## 1. MD-1.6-UnorderedPairCount · unnumbered_claim · 印刷p.33 / PDFp.56

### 2. 原文陈述

> The computation of the energy requires $N(N-1)/2$ separate calculations, which could be very expensive if N is large.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem unorderedpaircount :
  ∀ N : ℕ, (Finset.univ.filter (fun p : Fin N × Fin N => p.1 < p.2)).card = N*(N-1)/2 := by
  intro N
  simpa [Nat.choose_two_right] using Finset.card_product_filter_lt (s := (Finset.univ : Finset (Fin N)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.unorderedpaircount；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1797；MD.Ch01.unorderedpaircount。

## 1. MD-1.6-NearestNeighbor · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> We can reduce this by assuming only nearest neighbor forces, which means the energy becomes
> \[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def nearestNeighborModel {N : ℕ} (φ : ℝ → ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ |x i.succ-x i.castSucc|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nearestNeighborModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(\|x_{i+1}-x_i\|).\] | MD.Ch01.nearestNeighborModel，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1806；MD.Ch01.nearestNeighborModel。

## 1. MD-1.6-WalledChain · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> In order to keep such a system bounded we might then introduce walls at the ends of the chain, e.g. by adding confining potentials to $U$:
> \[U(x_1,x_2,\ldots,x_N)=\varphi_c(|x_1|)+\varphi_c(|L-x_N|)+\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|).\tag{1.7}\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def walledChainModel {N : ℕ} (φ φc : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  φc |x 0| + φc |L-x (Fin.last N)| + nearestNeighborModel φ x
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.walledChainModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U(x_1,x_2,\ldots,x_N)=\varphi_c(\|x_1\|)+\varphi_c(\|L-x_N\|)+\sum_{i=1}^{N-1}\varphi(\|x_{i+1}-x_i\|).\tag{1.7}\] | MD.Ch01.walledChainModel，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1813；MD.Ch01.walledChainModel。

## 1. MD-1.6-PeriodicChain · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> Alternatively one could restrict to a bounded domain by use of periodic boundary conditions, introducing the potential energy:
> \[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|)+\varphi(|L+x_1-x_N|).\tag{1.8}\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicChainModel {N : ℕ} (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  nearestNeighborModel φ x + φ |L+x 0-x (Fin.last N)|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicChainModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(\|x_{i+1}-x_i\|)+\varphi(\|L+x_1-x_N\|).\tag{1.8}\] | MD.Ch01.periodicChainModel，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1820；MD.Ch01.periodicChainModel。

## 1. MD-1.6-PeriodicBoundary · definition · 印刷p.34 / PDFp.57

### 2. 原文陈述

> If a particle moves to the right of $x=L$ we simply shift its position to $x-L$; likewise any particle exiting to the left of $x=0$ has its position shifted to $x+L$ (see Fig. 1.15).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicPositionEquivalent (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L

def periodicBoundary (L : {x : ℝ // 0 < x}) (x y : ℝ) : Prop :=
  y = if L.val < x then x-L.val else if x < 0 then x+L.val else x
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicBoundary；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodicPositionEquivalent; MD.Ch01.periodicBoundary | 原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodicPositionEquivalent; MD.Ch01.periodicBoundary | 原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。 |

[EXTRA] [EXTRA] 19号：原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。

### 6. 审计结论

19号本地签名预审：原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.periodicBoundary：PASS。对任意 L>0 及 x,y∈ℝ，结论恰为 y=(x−L 若 x>L；x+L 若 x<0；否则 x)。当 x=0 或 x=L 时保持原值，与 moves to the right / exiting to the left 的严格越界相符。它不声称任意大越界经一步后已落入盒内。MD.Ch01.periodicPositionEquivalent：PASS，∃k∈ℤ, y=x+kL 是独立辅助关系；L=0 或 L<0 时该关系仍有定义，但主更新明确只接受正 L。[EXTRA] 对一步更新和辅助等价关系的区分准确。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1829；MD.Ch01.periodicBoundary。

## 1. MD-1.6-PeriodicTranslationMomentum · unnumbered_claim · 印刷p.34 / PDFp.57

### 2. 原文陈述

> Periodic boundary conditions allow us to preserve Newton’s third law, the translational symmetry, and thus the conservation of momentum.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem periodic_translation_momentum :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ),
    let U := boxPeriodicNearestNeighborPotentialEnergy φ L
    (∀ q c, U (fun i => q i+c) = U q) ∧
    (∀ q, DifferentiableAt ℝ U q → fderiv ℝ U q (fun _ => 1) = 0) ∧
    ∀ (m : Fin (N+1) → ℝ) (q v : ℝ → Fin (N+1) → ℝ) (I : Set ℝ),
      IsOpen I → IsPreconnected I → (∀ i, 0 < m i) →
      (∀ t ∈ I, DifferentiableAt ℝ U (q t)) →
      (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t ∧
        HasDerivAt (fun s => m i*v s i) (-fderiv ℝ U (q t) (Pi.single i 1)) t) →
      (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i*v s i) 0 t) ∧
      ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i*v a i) = ∑ i, m i*v b i := by
  sorry

/-- Both endpoint forces of each norm-based periodic bond, including the closing bond. -/
def periodicBondEnergy (φ : ℝ → ℝ) (L : ℝ) (x y : ℝ) (closing : Bool) : ℝ :=
  φ ‖y-x + if closing then L else 0‖

theorem periodic_translation_third_law (φ : ℝ → ℝ) (L x y : ℝ) (closing : Bool)
    (hφ : DifferentiableAt ℝ (fun s => φ ‖s‖) (y-x + if closing then L else 0)) :
    -deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -(-deriv (fun u => periodicBondEnergy φ L x u closing) y) := by
  have hx := hφ.hasDerivAt.scomp x
    (((hasDerivAt_const x y).sub (hasDerivAt_id x)).add_const (if closing then L else 0))
  have hy := hφ.hasDerivAt.scomp y
    (((hasDerivAt_id y).sub_const x).add_const (if closing then L else 0))
  have hx' : deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -deriv (fun s => φ ‖s‖) (y-x + if closing then L else 0) := by
    simpa [periodicBondEnergy, Function.comp_def] using hx.deriv
  have hy' : deriv (fun u => periodicBondEnergy φ L x u closing) y =
      deriv (fun s => φ ‖s‖) (y-x + if closing then L else 0) := by
    simpa [periodicBondEnergy, Function.comp_def] using hy.deriv
  rw [hx',hy']
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodic_translation_momentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 平移不变及方向导数为零 | ∀q c,U(q+c)=U q；fderiv U q (fun _=>1)=0 | 一致 |
| 真实Newton系统总动量守恒 | 有限和HasDerivAt 0及∀a b∈I动量相等 | 一致 |
| 原文未显式量化的技术资格 | 一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodic_translation_momentum; MD.Ch01.periodicBondEnergy; MD.Ch01.periodic_translation_third_law | 完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodic_translation_momentum; MD.Ch01.periodicBondEnergy; MD.Ch01.periodic_translation_third_law | 完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。 |
| 21号网站建议修复 | MD.Ch01.periodic_translation_momentum | 键能量补范数，第三定律改对ψ=φ∘\|·\|在有向差处可微；平移/动量主定理逐字未改。 |

[EXTRA] 一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。；[EXTRA] 19号：完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。；[EXTRA] 键能量补范数，第三定律改对ψ=φ∘|·|在有向差处可微；平移/动量主定理逐字未改。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：键能量补范数，第三定律改对ψ=φ∘|·|在有向差处可微；平移/动量主定理逐字未改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.periodic_translation_momentum：PASS（签名语义）。N∈ℕ，系统有 N+1 个实坐标；φ:ℝ→ℝ 与 L∈ℝ 任意。真实 U 的 N 个相邻键及闭合键只依赖坐标差，故同时平移不变；可微时沿全1向量的导数为0。对正质量 m、轨迹 q,v、开且预连通的 I，给出的势可微性和逐粒子速度/动量 Newton 导数足以推出总动量导数0及任意 a,b∈I 的总动量相等；全部结论均保留。MD.Ch01.periodicBondEnergy：FAIL（与实际依赖的对应关系），其定义是有向差的 φ 值，没有真实 U 中的范数。MD.Ch01.periodic_translation_third_law：作为这个有向辅助能量的两端力相反定理，签名本身 PASS；hφ 也恰好是有向参数处的可微性。然而，它未针对实际 U 的 φ∘|·| 键作陈述。没有 φ 偶性、键方向/位置资格或替换势的桥接，不能将其认作实际周期链中每条键的第三定律。[EXTRA] 中“真实每条周期键”“含闭合键”的覆盖说法因此不成立。总 verdict=FAIL 源于模型对应错误，不源于 sorry。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1837；MD.Ch01.periodic_translation_momentum。

## 1. MD-1.6-RegularLattice · definition · 印刷p.34 / PDFp.57

### 2. 原文陈述

> On the line, we think of a (finite) lattice as a sequence of discrete points separated by a fixed distance $\Delta x$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.regularLattice；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1875；MD.Ch01.regularLattice。

## 1. MD-1.6-RegularLatticeMinimizerLiteral · unnumbered_claim · 印刷p.34 / PDFp.57

### 2. 原文陈述

> An obvious benefit of using periodic boundary conditions is that, with a uniform pair potential, the energy minimizers are points of a regular lattice; with confining potentials this is unlikely to be the case.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem regularlatticeminimizerliteral :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x := by
  sorry

/-- 修正版，对应原文 MD-1.6-RegularLatticeMinimizerLiteral，改动：改为一维周期有序粒子的正间距和L固定、严格凸最近邻势；Jensen给等间距最小且仅等间距等号。 -/
theorem regularlatticeminimizerliteral_corrected (N : ℕ) (φ : ℝ → ℝ)
    (L : ℝ) (hL : 0 < L) (hφ : StrictConvexOn ℝ (Ioi 0) φ) :
    let d := L / (N+1)
    ∀ gaps : Fin (N+1) → ℝ, (∀ i, 0 < gaps i) → (∑ i, gaps i) = L →
      (N+1 : ℝ) * φ d ≤ ∑ i, φ (gaps i) ∧
      ((∑ i, φ (gaps i)) = (N+1 : ℝ) * φ d ↔ ∀ i, gaps i = d) := by
  dsimp only
  intro gaps hg hs
  have hc : 0 < (N+1 : ℝ) := by positivity
  have hw : (∑ _ : Fin (N+1), (N+1 : ℝ)⁻¹) = 1 := by
    simp [Nat.cast_add, Nat.cast_one, hc.ne']
  have hm : (∑ i, (N+1 : ℝ)⁻¹ * gaps i) = L/(N+1) := by
    rw [← Finset.mul_sum,hs]
    ring
  have hv : (∑ i, (N+1 : ℝ)⁻¹ * φ (gaps i)) = (∑ i,φ (gaps i))/(N+1) := by
    rw [← Finset.mul_sum]
    ring
  have hpos : ∀ i ∈ (Finset.univ : Finset (Fin (N+1))), 0 < (N+1 : ℝ)⁻¹ :=
    fun _ _ => inv_pos.mpr hc
  have hmem : ∀ i ∈ (Finset.univ : Finset (Fin (N+1))), gaps i ∈ Ioi (0 : ℝ) :=
    fun i _ => hg i
  have hi := hφ.convexOn.map_sum_le (fun i hi => (hpos i hi).le) hw hmem
  have he := hφ.map_sum_eq_iff hpos hw hmem
  simp only [smul_eq_mul] at hi he
  rw [hm,hv] at hi he
  refine ⟨?_,?_⟩
  · simpa [mul_comm] using (le_div_iff₀ hc).mp hi
  · constructor
    · intro hh
      have hh' : φ (L/(N+1)) = (∑ i,φ (gaps i))/(N+1) := by
        apply (eq_div_iff hc.ne').mpr
        nlinarith
      exact fun i => he.mp hh' i (Finset.mem_univ i)
    · intro hh
      have hh' : φ (L/(N+1)) = (∑ i,φ (gaps i))/(N+1) :=
        he.mpr (by simpa using hh)
      have := (eq_div_iff hc.ne').mp hh'
      nlinarith

theorem regularlatticeminimizerliteral_counterexample :
    (∀ x y : Fin 2 → ℝ,
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 x ≤
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 y) ∧
    ¬ ∃ a : ℝ, regularLattice a (1/2) (fun _ : Fin 2 => 0) := by
  constructor
  · intro x y; simp [boxPeriodicNearestNeighborPotentialEnergy,nearestNeighborPotentialEnergy]
  · rintro ⟨a,ha⟩
    have h0 := ha.2 (0 : Fin 2)
    have h1 := ha.2 (1 : Fin 2)
    norm_num at h0 h1
    linarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.regularlatticeminimizerliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |

[EXTRA] 

### 6. 审计结论

任意uniform pair potential不保证晶格最小；还缺排序、盒域和势的凸性等资格。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
MD.Ch01.regularlatticeminimizerliteral：字面意旨保留，但数学疑误 NEEDS_HUMAN。它对任意 N、任意 φ、L>0 及所有实配置 x，在全空间全局最小的前提下断言 ∃a, xᵢ=a+iL/(N+1)，其中 regularLattice 还要求正间距。该签名确实保留了原书无势资格的极强断言，不应因已知反例或 sorry 将“忠实版”判作实现 FAIL。须注意 Lean 进一步选择了周期最近邻、固定标号递增和固定环长间距的解释，不能据此宣称已经处理任意标号重排或任意多维 pair potential。MD.Ch01.regularlatticeminimizerliteral_corrected：PASS。φ 在 (0,∞) 严格凸、L>0、每个 gapsᵢ>0 且 ∑gapsᵢ=L，使 d=L/(N+1)>0。结论是 (N+1)φ(d)≤∑φ(gapsᵢ)，且等号当且仅当全部 gapsᵢ=d；这是有限等权严格 Jensen 的准确陈述，包括 N=0 的单项情形。它是明确改变问题域的合理勘误，不是任意原始配置的无条件结论。MD.Ch01.regularlatticeminimizerliteral_counterexample：PASS。零势下所有 Fin 2 配置能量均为0；常零配置不可能满足间距1/2的有标号 regularLattice。[EXTRA] 为空不能被理解为原命题因此获得凸性或顺序条件。总判 NEEDS_HUMAN，需人工确认原书的隐藏势与配置资格。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1882；MD.Ch01.regularlatticeminimizerliteral。

## 1. MD-1.6-PeriodicImages · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> periodic boundary conditions involve an extended potential energy of the form
> \[U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),\]
> where $k,l,m$ run over $-1,0,1$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $\boldsymbol v_i^T=(L\boldsymbol e_i^T,L\boldsymbol e_i^T,\ldots,L\boldsymbol e_i^T)$, $i=1,2,3$, where $\boldsymbol e_i$ is the $i$th Euclidean basis vector in $\mathbb R^3$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicImageEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),\] | MD.Ch01.periodicImageEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.periodicImageEnergy：对“将原页 v_i 解释为其对应粒子三维块 L e_i”的解释，签名 PASS。对任意自然数 N、实 L、所有二体项 φᵢⱼ 与三维配置 q，定义恰枚举27个位移和全部无序不同标签对 i<j，逐项计算 φᵢⱼ(qᵢ,qⱼ+L(k,l,m))。N=0 或1时空配对求和为0，忠实于印刷的 i<j；没有擅加 i=j 的自镜像，也没有擅加1/2。构造公式本身可推广到任意 L,q，物理盒长正且坐标位于盒内是书中背景，而非这一定义声称的额外定理。未解决之处是原页把 v_i 定义为全配置重复块，和此处二体参数三维之间存在类型冲突；JSON 的“等价”说明只能给出一种修复解释，不能消除原书符号问题。因此总判 NEEDS_HUMAN，而非声称已逐类型忠实形式化了原公式。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1947；MD.Ch01.periodicImageEnergy。

## 1. MD-1.6-MinimumImage · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> The minimum image convention states that, in computing the force, a given atom interacts only with the nearest replica of any other atom.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖

def minimumImageForce {N : ℕ} (L : ℝ) (q : Fin N → V3)
    (image : Fin N → Fin N → V3) (pairForce : Fin N → Fin N → V3 → V3 → V3)
    (force : Fin N → V3) : Prop :=
  0 < L ∧ (∀ i j, i ≠ j → minimumImage L (q i) (q j) (image i j)) ∧
    ∀ i, force i = ∑ j ∈ Finset.univ.erase i, pairForce i j (q i) (image i j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumImage；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.minimumImage; MD.Ch01.minimumImageForce | 最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.minimumImage; MD.Ch01.minimumImageForce | 最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。 |

[EXTRA] [EXTRA] 19号：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。

### 6. 审计结论

19号本地签名预审：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.minimumImage：PASS。L∈ℝ，q,r,image∈V3；存在 k∈ℤ³ 使 image=r+Lk，且对所有 l∈ℤ³ 有 ‖q−image‖≤‖q−(r+Ll)‖。最小性使用≤，允许距离并列；关系自身不含 L>0，但下述完整模型补足。MD.Ch01.minimumImageForce：PASS。对 N 个标签的位置 q、每对标签的选中像 image、二体力回调 pairForce 以及总力 force，要求0<L；对 i≠j 要求对应最小像关系；对每个 i 总力恰为 j≠i 上 pairForce(i,j,qᵢ,imageᵢⱼ) 的和。因此“other”不包括自标签，“only”通过每个其他标签只出现一个选中复制体落实。并未错误断言距离最小者在数学上唯一，也不将并列的所有像一起相加。pairForce 是输入的二体力，原句未给它另一个解析表达式。[EXTRA] 与这两层定义一致。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1956；MD.Ch01.minimumImage。

## 1. MD-1.6-RhombicLattice · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> In 2D, the typical geometry observed at low temperature is defined by a rhombic lattice with sides of fixed length $n_x,n_y$ and the angle between them ($\theta$), see Fig. 1.17.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}

def RhombicLatticeValidDomain (a b θ : ℝ) : Prop :=
  0 < a ∧ 0 < b ∧ Real.sin θ ≠ 0

def rhombicLatticeOnDomain (a b θ : ℝ) (_h : RhombicLatticeValidDomain a b θ) :
    Set (Position 2) := rhombicLattice a b θ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.rhombicLatticeOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.rhombicLatticeOnDomain | 一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。 |

[EXTRA] [EXTRA] 一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.rhombicLattice：FAIL（参数域/几何资格）。集合公式 x=k(a,0)+l(b cosθ,b sinθ)，k,l∈ℤ，方向、索引及二维实欧氏对象均正确；旋转/平移选定坐标本身不是问题。缺陷是 a,b,θ 无任何资格，不能保证两条边的长度为正或两个生成方向独立：行列式为 ab sinθ，可能为0。原文及图1.17描述的是二维格，而当前构造连秩0、秩1的退化集合也全部接收。[EXTRA] 为空，不能从“基向量”这个中文名称推入 Lean 中没有的线性无关性。作为一般整数生成集合的辅助定义它是合法的，但作为未加资格的二维 rhombic lattice 完整对应不足。没有把“低温典型”误审为必须额外证明的普遍低温定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1977；MD.Ch01.rhombicLatticeOnDomain。

## 1. MD-1.6-HexagonalLattice · unnumbered_claim · 印刷p.35 / PDFp.58

### 2. 原文陈述

> it can be viewed as a rhombic lattice with $n_x=n_y$ and $\theta=120^\circ$; it can also be viewed as a rhombic lattice with $\theta=60^\circ$

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hexagonal_lattice_two_bases (a : ℝ) :
    rhombicLattice a a (2*Real.pi/3) = rhombicLattice a a (Real.pi/3) := by
  ext x
  have hc : Real.cos (2*Real.pi/3) = -(1/2:ℝ) := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hs : Real.sin (2*Real.pi/3) = Real.sqrt 3/2 := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  constructor
  · rintro ⟨k,l,rfl⟩
    refine ⟨k-l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
  · rintro ⟨k,l,rfl⟩
    refine ⟨k+l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hexagonal_lattice_two_bases；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1985；MD.Ch01.hexagonal_lattice_two_bases。

## 1. MD-1.6-UnitCell · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> The unit cell is a description of the arrangement of atoms within a box; unit cells may be stacked in each direction to describe an atomic lattice.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}

/-- Half-open cell B([0,1)^3), with boundary representatives fixed by coordinates. -/
def unitCellBox (B : Matrix (Fin 3) (Fin 3) ℝ) : Set V3 :=
  B.toEuclideanLin '' {x : V3 | ∀ i, 0 ≤ x i ∧ x i < 1}

def UnitCellValidDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Prop :=
  B.det ≠ 0 ∧ motif.Finite ∧ motif.Nonempty ∧ motif ⊆ unitCellBox B

def unitCellOnDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3)
    (_h : UnitCellValidDomain B motif) : Set V3 := unitCellLattice B motif
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.unitCellOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.unitCellOnDomain | 一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。 |

[EXTRA] [EXTRA] 一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。

### 6. 审计结论

21号按网站suggested_fix修复并本地核验：一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.unitCellLattice：FAIL（对象域/晶胞资格）。平移公式和存在量词准确编码了以三个生成向量重复 motif 的操作，但 B:Matrix (Fin 3) (Fin 3) ℝ 不是三维基的类型；B 可以奇异或为0。motif:Set V3 也未声明为盒内有限原子排列，甚至允许 motif=整个ℝ³。故定义输出不一定是三维离散原子晶格，不能仅靠 context_notation 的自然语言声称已经落实原书的“within a box”和“each direction”。此构造可保留为平移并集函数；缺失的是作为原书 unit cell 的有效输入资格，而非要求每个晶胞只能有一个原子。[EXTRA] 为空，未提供这些资格。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2022；MD.Ch01.unitCellOnDomain。

## 1. MD-1.6-FCCStacking · definition · 印刷p.36 / PDFp.59

### 2. 原文陈述

> The fcc lattice corresponds to the common arrangement by which cannonballs are stacked into pyramidal structures; it can be viewed as a periodic stacking (ABCABC. . . ) of three hexagonally structured planar layers, as illustrated in Fig. 1.18.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.fccStacking；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。 | [EXTRA] |

[EXTRA] 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。

### 6. 审计结论

ABC三周期保留；旧库附带具体几何层高和偏移不是正文逐字公式，需要导师确认图示编码。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.fccStacking：PASS。x∈ℝ³，当且仅当存在任意整数 k，使 z=k√(2/3)，且平面坐标落在 triangularLayer(j/2,j√3/6)，j=k mod3。triangularLayer(u,v) 的点为 (p+r/2+u,r√3/2+v)，p,r∈ℤ，是单位最近邻间距的等边三角点阵。余数0,1,2分别给 A、B、C 三个不同平移类；其顺序每三层重复。设 s=(1/2,√3/6)，则3s=(3/2,√3/2)为底层格向量，所以 C 后回到 A 正合 ABC 堆积；层高√(2/3)与水平孔位偏移共同给单位接触距离。k 可负，正模数的整数余数仍遍历0,1,2，覆盖双向无限晶格。固定尺度、坐标与取向是[EXTRA]明确说明的图示具体实现，并非正文声称给出了这些数值公式。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2030；MD.Ch01.fccStacking。

## 1. MD-1.6-HCPStacking · definition · 印刷p.36 / PDFp.59

### 2. 原文陈述

> Also shown in Fig. 1.18 is the hcp lattice, which, on the other hand, alternates two distinct planar lattices.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hcpStacking；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。 | [EXTRA] |

[EXTRA] 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。

### 6. 审计结论

AB两周期保留；具体几何参数来源图示而非正文公式，需导师确认编码。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.hcpStacking：PASS。任意整数 k 给定高度 k√(2/3)，j=k mod2∈{0,1}，其平面层为 triangularLayer(j/2,j√3/6)。展开 triangularLayer，A 是零偏移的单位三角层，B 相对 A 偏移 (1/2,√3/6)，该偏移不在底层三角格中，故确为两种不同层；k+2 与 k 的平面位置一致而高度相差2√(2/3)，实现 ABAB。层高及孔位偏移给正确密堆积单位接触尺度。不存在误用三余数造成ABC的问题。[EXTRA]已说明单位化数值来自图示的具体密堆积编码，正文的两层交替信息得到完整保存。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2039；MD.Ch01.hcpStacking。

## 1. MD-1.6.1-MinimumGradientZero · unnumbered_claim · 印刷p.36–37 / PDFp.59–60

### 2. 原文陈述

> Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where
> \[\nabla U=0,\]
> which gives in general a nonlinear system of $N_c$ equations in $N_c$ unknowns to be solved for the position vector $\boldsymbol q^*$ associated to mechanical equilibrium.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem minimumgradientzero :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved

/-- 修正版，对应原文 MD-1.6.1-MinimumGradientZero，改动：显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。 -/
theorem minimumgradientzero_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumgradientzero；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\nabla U=0,\] | MD.Ch01.minimumgradientzero，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。 | [EXTRA] |

[EXTRA] 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。

### 6. 审计结论

约束边界极小一般不能推出全梯度为零；原上下文若含边界须区分可行方向。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.minimumgradientzero：在[EXTRA]明示的无约束内点解释下，数学签名 PASS。n∈ℕ，U:EuclideanSpace ℝ (Fin n)→ℝ，q 属于同一空间；DifferentiableAt ℝ U q 与全空间 IsLocalMin U q 足以推出 gradient U q=0。它给必要条件，没有将驻点偷换为充分极小条件；n 维梯度等于0等价于 n 个分量方程，不需另断言这些方程对每个 U 都非线性。MD.Ch01.minimumgradientzero_corrected：PASS，为同一个正确的无约束内点必要条件；其“修正”是解释范围的更正而非新签名。原书“Regardless of boundary”若包括受约束边界极小则过强，现有 Lean 也未覆盖这种解释。[EXTRA]已诚实披露可微、内点及边界限制，但不能据此认定原书无条件原句成立。故源文及总 verdict 保持 NEEDS_HUMAN。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2048；MD.Ch01.minimumgradientzero。

## 1. MD-1.6.1-ForceLinearization · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> At the equilibrium point, we can linearize the system of differential equations by computing the Hessian matrix, then we find
> \[\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).\]
> Then, letting $\delta\boldsymbol q=\boldsymbol q-\boldsymbol q^*$, $\delta\boldsymbol p$ represent small deviations from the equilibrium point at $(\boldsymbol q,\boldsymbol p)=(\boldsymbol q^*,0)$, we have
> \[\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar) := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  constructor
  · change HasFDerivAt (fun z : PhaseSpace n => (B z.2, -gradient U z.1)) _ (qstar,0)
    have hn : HasFDerivAt (fun q => -gradient U q) (-fderiv ℝ (gradient U) qstar) qstar :=
      hg.hasFDerivAt.neg
    have h₂ := hn.comp (qstar,0)
      ((ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    have h₁ := B.hasFDerivAt.comp (qstar,0)
      ((ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    exact h₁.prodMk h₂
  · have h := hasFDerivAt_iff_isLittleO.mp hg.hasFDerivAt
    simpa only [heq, sub_zero] using h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.force_linearization；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).\]；\[\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.\] | MD.Ch01.force_linearization，完整展开陈述见上一行及第4段 | 一致 |
| 一般质量Hamilton向量场的块导数 | (M⁻¹∘snd).prod ((-D∇U)∘fst)的HasFDerivAt | 一致 |
| 梯度线性化误差 | ∇U(q)-D∇U(q*)(q-q*) =o[𝓝 q*] (q-q*) | 一致 |
| 原文未显式量化的技术资格 | 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。 | [EXTRA] |

[EXTRA] 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。

### 6. 审计结论

一般质量矩阵、真实块Frechet导数及完整小o梯度线性化全部保留，未假设结论。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.force_linearization：PASS。对任意有限维 n、常实方阵 M、实势 U、qstar，ContDiffAt ℝ 2 U qstar 保证梯度可微，heq 要求平衡梯度为0。相空间为位置×动量的两个相同维欧氏空间，matrixAction 是矩阵的真实线性作用。所列导数将任意(δq,δp)送到(M⁻¹δp,−D(gradient U)(qstar)δq)，完整保留两条线性化运动方程，后者的 D gradient 即 Hessian。第二结论为 gradient U(q)−D(gradient U)(qstar)(q−qstar)=o(‖q−qstar‖)，因此保留原文的平衡点梯度近似且没有把非线性系统和线性系统宣称为全局精确相同。M 不要求正定或可逆，是对取定线性系数 Matrix.inv M 的数学推广；原机械质量矩阵取正定可逆时正好回到正文。该推广与[EXTRA]已披露的一般常 M 一致，不会使这个导数/小o结论失真；不能据此反称奇异 M 是合法机械质量矩阵。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2063；MD.Ch01.force_linearization。

## 1. MD-1.6.1-MinimumHessianLiteral · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> At the minimum of the potential energy, $U''$ is a positive definite symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem minimumhessianliteral :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

/-- 修正版，对应原文 MD-1.6.1-MinimumHessianLiteral，改动：正定改为半正定；仍保留Hessian对称性及所有非零方向。 -/
theorem minimumhessianliteral_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 ≤ inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

theorem minimumhessianliteral_counterexample :
    IsLocalMin (fun x : ℝ => x^4) 0 ∧ deriv (deriv (fun x : ℝ => x^4)) 0 = 0 := by
  constructor
  · change ∀ᶠ x in 𝓝 (0 : ℝ), (0 : ℝ)^4 ≤ x^4
    exact Filter.Eventually.of_forall (fun x => by norm_num only [zero_pow]; positivity)
  · have hd : deriv (fun x : ℝ => x^4) = fun x => 4*x^3 := by
      funext x
      convert ((hasDerivAt_id x).pow 4).deriv using 1 <;> simp
    rw [hd]
    simpa using (((hasDerivAt_id (0 : ℝ)).pow 3).const_mul 4).deriv
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumhessianliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |

[EXTRA] 

### 6. 审计结论

局部极小只能推出Hessian半正定，严格极小也不能保证非退化。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
MD.Ch01.minimumhessianliteral：字面忠实性 PASS，但原书数学疑误 NEEDS_HUMAN。对任意 n、U:Position n→ℝ、q，以全局 ContDiff ℝ 2 U 和 IsLocalMin U q 为前提；合取结论确实完整包括 Hessian 的所有 u,v 对称性，以及对所有非零 v 的正定性，没有把正定偷换成半正定。该正定结论在原书资格下不成立，依任务不把忠实版或 sorry 本身判成实现 FAIL。MD.Ch01.minimumhessianliteral_corrected：PASS。相同 C²、全空间局部极小前提下 Hessian 对称且二次型非负，是正确必要条件；仍逐一覆盖所有非零方向，零方向亦自动为0。MD.Ch01.minimumhessianliteral_counterexample：PASS。U(x)=x⁴ 在0有局部极小且二阶导数为0，足以反驳正定；该函数实际甚至是严格全局极小，因而增加“严格极小”也救不了字面版。标量例经一维欧氏空间的标准识别对应 n=1。总判 NEEDS_HUMAN；未因修正版含 sorry 否定其签名。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2090；MD.Ch01.minimumhessianliteral。

## 1. MD-1.6.1-ImaginarySpectrum · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> The eigenvalues of the matrix
> \[\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\\-U''(\boldsymbol q^*)&0\end{bmatrix}\]
> are therefore all purely imaginary ($\pm i\Omega$, $\Omega^2\in\mathbb R^+$).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem imaginary_spectrum :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2, -K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y →
      a = 0 ∧ 0 < b^2 ∧ A x = -b • y ∧ A (-y) = -b • x := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.imaginary_spectrum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\\-U''(\boldsymbol q^*)&0\end{bmatrix}\] | MD.Ch01.imaginary_spectrum，完整展开陈述见上一行及第4段 | 一致 |
| 全部特征值±iΩ与Ω²>0 | 任意非零实虚特征对推出a=0、0<b²及A x=-b•y、A(-y)=-b•x | 一致；全部三个结论保留 |
| 原文未显式量化的技术资格 | M和Hessian K正定；复谱实虚向量编码。 | [EXTRA] |

[EXTRA] M和Hessian K正定；复谱实虚向量编码。

### 6. 审计结论

补齐实部零、非零频率平方正及共轭实虚特征对给出的±ib配对；一般SPD M,K保留。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2120；MD.Ch01.imaginary_spectrum。

## 1. MD-1.6.1-ComplexNormalMode · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> Associated to each eigenvalue pair we have a pair of complex conjugate eigenvectors $\boldsymbol\xi,\overline{\boldsymbol\xi}$ and also a pair of solutions which can be written in the complex form
> \[\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},\]
> ($a,b$ complex coefficients),

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem complexnormalmode :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    η ≠ 0 → (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    (fun i => star (η i)) ≠ 0 ∧
    (A.map (algebraMap ℝ ℂ)).mulVec (fun i => star (η i)) =
      (-Complex.I * Ω) • (fun i => star (η i)) ∧
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.complexnormalmode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},\] | MD.Ch01.complexnormalmode，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.complexnormalmode | 增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.complexnormalmode | 增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。 |

[EXTRA] [EXTRA] 19号：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。

### 6. 审计结论

19号本地签名预审：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.complexnormalmode：PASS。n∈ℕ，A 是实 n×n 矩阵，η∈ℂⁿ 非零，Ω∈ℝ；前提 A_Cη=(iΩ)η，A_C 是 A 的逐项实到复嵌入。结论先确认 conjugate η 非零，再确认 A_C conjugate η=(−iΩ)conjugate η，实性正是此推论所需；最后对任意 a,b∈ℂ 和任意 t∈ℝ，给出 z(t)=a exp(iΩt)η+b exp(−iΩt)conjugate η 的真实导数为 A_C z(t)。该表述完整覆盖共轭特征对及其复线性组合解，未以零向量充当特征向量，也未把 a,b 限制为实。Ω=0 时共轭解可退化/重合，签名没有多声称其线性独立，故仍正确。A 泛化为任何实矩阵而非限定机械块矩阵，是由同一特征方程导出解公式的有效推广。[EXTRA] 中非零及共轭特征方程均真实出现在声明里。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2132；MD.Ch01.complexnormalmode。

## 1. MD-1.6.1-RealNormalMode · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> or recast in real form as ($\alpha,\beta$ real coefficients):
> \[\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem realnormalmode :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ),
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t := by
  exact @MolecularDynamics.hasDerivAt_realNormalMode
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.realnormalmode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].\] | MD.Ch01.realnormalmode，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.realnormalmode：就所陈述的实解公式而言 PASS。对任意实赋范向量空间 E、A:E→L[ℝ]E、Ω,α,β∈ℝ、u,v∈E，只需 Au=−Ωv 和 Av=Ωu，即对所有实 t 得 z′(t)=Az(t)。展开 MolecularDynamics.realNormalMode，z 恰为 α(sin(Ωt)u+cos(Ωt)v)+β(cos(Ωt)u−sin(Ωt)v)，与原式相同；取 u=Re ξ、v=Im ξ 时 hu,hv 正是实矩阵 +iΩ 特征方程的实虚部。不需要额外的非零/独立条件来使这一解公式成立，泛化到赋范空间也合理。需要区分的是：前一条 a,b 为任意复数的 z 不一定为实，不能全部直接“改写”为此 α,β 为实的式子。当前声明没有给出系数约束或取实部的桥接，因此不能把它的 PASS 扩展为已证明原书无条件的复实全族等价。原文若意指真实物理解则正确，但省略了适用范围；依“原书疑误/歧义保留”要求，总判 NEEDS_HUMAN，非把正确的 ODE 声明判成 FAIL。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2151；MD.Ch01.realnormalmode。

## 1. MD-1.7-PlanarTrimerModel · Example 1.8 (Planar Lennard-Jones Trimer) · 印刷p.38 / PDFp.61

### 2. 原文陈述

> One of the simplest illustrations of the chaotic nature of molecular systems is given by the Lennard-Jones model consisting of just three atoms with motion restricted to the plane. The energy is
> \[E=K+U=\frac{\|\dot{\boldsymbol q}_1\|^2}{2}+\frac{\|\dot{\boldsymbol q}_2\|^2}{2}+\frac{\|\dot{\boldsymbol q}_3\|^2}{2}+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_2\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_2-\boldsymbol q_3\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_3\|),\]
> with the interatomic interaction given by $\hat\varphi_{\mathrm{LJ}}(r)=4[r^{-12}-r^{-6}]$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarTrimerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[E=K+U=\frac{\\|\dot{\boldsymbol q}_1\\|^2}{2}+\frac{\\|\dot{\boldsymbol q}_2\\|^2}{2}+\frac{\\|\dot{\boldsymbol q}_3\\|^2}{2}+\hat\varphi_{\mathrm{LJ}}(\\|\boldsymbol q_1-\boldsymbol q_2\\|)+\hat\varphi_{\mathrm{LJ}}(\\|\boldsymbol q_2-\boldsymbol q_3\\|)+\hat\varphi_{\mathrm{LJ}}(\\|\boldsymbol q_1-\boldsymbol q_3\\|),\] | MD.Ch01.planarTrimerEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
平面单位质量三粒子；Fin 3逐项动能及01、12、02三对势均一致。Position 2确为二维欧氏空间；ε=σ=1给出4(r⁻¹²−r⁻⁶)。碰撞点的Lean总函数值仅为延拓，不能解释为物理势。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2167；MD.Ch01.planarTrimerEnergy。

## 1. MD-1.7-CentralPairPotential · definition · 印刷p.38 / PDFp.61

### 2. 原文陈述

> In general, when the total potential is a sum of distance potentials
> \[U=\frac12\sum_{i\ne j}U_{ij},\]
> where $U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=\varphi_{ij}(\|\boldsymbol q_i-\boldsymbol q_j\|)$, we say that the system has central forces.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralPairEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U=\frac12\sum_{i\ne j}U_{ij},\] | MD.Ch01.centralPairEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
Fin N、三维位置和任意径向φ；erase i恰排除自相互作用，有序双和除以2与原式一致。该定义本身无需可微性或φ对称性；若要把φ解释为同一无序对的势，需采用context_notation的对称约定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2175；MD.Ch01.centralPairEnergy。

## 1. MD-1.7-CentralPairGradient · unnumbered_claim · 印刷p.38 / PDFp.61

### 2. 原文陈述

> In this case,
> \[\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centralpairgradient :
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r := by
  intro φ q r hqr hφ
  have hn : ‖q-r‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr hqr)
  have h₁ := (((hasFDerivAt_id q).sub_const r).norm_sq).sqrt (pow_ne_zero 2 hn)
  have h₂ := (((hasFDerivAt_const q r).sub (hasFDerivAt_id r)).norm_sq).sqrt (pow_ne_zero 2 hn)
  simp only [Real.sqrt_sq_eq_abs, abs_norm] at h₁ h₂
  have g₁ := hφ.hasDerivAt.comp_hasFDerivAt q h₁
  have g₂ := hφ.hasDerivAt.comp_hasFDerivAt r h₂
  apply ext_inner_right ℝ
  intro v
  simp only [Function.comp_def, id_eq, Pi.sub_apply] at g₁ g₂
  rw [inner_gradient_left, inner_neg_left, inner_gradient_left, g₁.fderiv, g₂.fderiv]
  simp [ContinuousLinearMap.comp_apply, innerSL_apply_apply, inner_neg_right]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralpairgradient；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\] | MD.Ch01.centralpairgradient，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 势在非碰撞距离可微；partial为欧氏梯度。 | [EXTRA] |

[EXTRA] 势在非碰撞距离可微；partial为欧氏梯度。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
全称φ、q、r；q≠r及φ在距离处可微是合法微分资格。两侧均为同一二体势分别对两个位置的欧氏梯度，负号、取值点和结论完整。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2182；MD.Ch01.centralpairgradient。

## 1. MD-1.7-CentralMomentum · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> and so, for central forces,
> \[\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,\]
> which expresses the constancy of the momentum.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem central_momentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  exact @momentum_conservation
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.central_momentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,\] | MD.Ch01.central_momentum，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。 | [EXTRA] |

[EXTRA] 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。

### 6. 审计结论

审查后去掉旧桥接中净力零前提，由真实逐对作用反对称推出净力零和全向量/每坐标动量守恒，保留全部结论。

网站：网站PASS（EAUDIT复审）。
任意N、质量、速度、逐对力和开放预连通时间域；逐对力反对称与每个动量的真实导数推出净力为零、总动量真实零导数及任意两时刻相等。结论没有被用作假设。以p=mv编码Newton动量，未另设q不影响这一动量层面的陈述。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2203；MD.Ch01.central_momentum。

## 1. MD-1.7-CentralAngularMomentum · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> Moreover, viewing the $\boldsymbol q_i$ as vectors in $\mathbb R^3$ (with 0 as their third component),
> \[\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\]
> which implies
> \[\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,\]
> and tells us that the total angular momentum is also conserved.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centralangularmomentum_derivative :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t := by
  intro N m q v F I _ hq hp hanti hcenter
  have hsub (u v w : V3) : cross3 (u-v) w = cross3 u w-cross3 v w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hneg (u w : V3) : cross3 u (-w) = -cross3 u w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have ht (t : ℝ) (h : t ∈ I) (i j : Fin N) :
      cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i) := by
    have hc := hcenter t h i j
    rw [hsub] at hc
    rw [hanti t h j i,hneg,neg_neg]
    exact sub_eq_zero.mp hc
  have hcross (u w : ℝ → V3) (du dw : V3) (t : ℝ)
      (hu : HasDerivAt u du t) (hw : HasDerivAt w dw t) :
      HasDerivAt (fun s => cross3 (u s) (w s)) (cross3 du (w t)+cross3 (u t) dw) t := by
    have huc (k : Fin 3) : HasDerivAt (fun s => u s k) (du k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hu
    have hwc (k : Fin 3) : HasDerivAt (fun s => w s k) (dw k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hw
    have hc (k : Fin 3) : HasDerivAt (fun s => cross3 (u s) (w s) k)
        ((cross3 du (w t)+cross3 (u t) dw) k) t := by
      fin_cases k
      · convert! ((huc 1).mul (hwc 2)).sub ((huc 2).mul (hwc 1)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 2).mul (hwc 0)).sub ((huc 0).mul (hwc 2)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 0).mul (hwc 1)).sub ((huc 1).mul (hwc 0)) using 1 <;> simp [cross3] <;> ring
    let b : Fin 3 → V3 := fun k => WithLp.toLp 2 (Pi.single k 1)
    have hre (z : V3) : (∑ k, z k • b k) = z := by
      ext k; fin_cases k <;> simp [b,Fin.sum_univ_three]
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun k _ => (hc k).smul_const (b k))
    simpa only [hre] using hh
  have hself (a : ℝ) (u : V3) : cross3 u (a • u) = 0 := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hsum (u : V3) (f : Fin N → V3) : cross3 u (∑ j,f j) = ∑ j,cross3 u (f j) := by
    ext k; fin_cases k <;> simp [cross3,Finset.mul_sum,Finset.sum_sub_distrib]
  refine ⟨ht,?_⟩
  intro t h
  have hz : (∑ i, ∑ j,cross3 (q t i) (F t i j)) = 0 := by
    apply paircancellation N (fun i j => cross3 (q t i) (F t i j))
    · intro i
      ext k
      have he := congrArg (fun u : V3 => u k) (ht t h i i)
      simp only [PiLp.neg_apply] at he
      change (cross3 (q t i) (F t i i)) k = 0
      linarith
    · exact ht t h
  have hd (i : Fin N) : HasDerivAt (fun s => cross3 (q s i) (m i • v s i))
      (∑ j,cross3 (q t i) (F t i j)) t := by
    simpa only [hself,zero_add,hsum] using hcross (fun s => q s i) (fun s => m i • v s i)
      (v t i) (∑ j,F t i j) t (hq t h i) (hp t h i)
  have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hd i)
  rwa [hz] at hh

theorem centralangularmomentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, cross3 (q a i) (m i • v a i)) =
      ∑ i, cross3 (q b i) (m i • v b i) := by
  intro N m q v F I hI hc hq hp ha hf
  obtain ⟨ht,hd⟩ := centralangularmomentum_derivative N m q v F I hI hq hp ha hf
  refine ⟨ht,hd,?_⟩
  intro a ha b hb
  exact hI.is_const_of_deriv_eq_zero hc
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralangularmomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\]；\[\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,\] | MD.Ch01.centralangularmomentum，完整展开陈述见上一行及第4段 | 一致 |
| 逐对力矩相消 | ∀t i j,cross3(qᵢ,Fᵢⱼ)=-cross3(qⱼ,Fⱼᵢ) | 一致 |
| 角动量守恒 | HasDerivAt (∑i,cross3(qᵢ,mᵢ•vᵢ)) 0 | 一致 |
| 原文未显式量化的技术资格 | 真实位置和动量导数；反对称内力和沿位移方向中心力。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.centralangularmomentum_derivative; MD.Ch01.centralangularmomentum | 保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.centralangularmomentum_derivative; MD.Ch01.centralangularmomentum | 保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。 |

[EXTRA] 真实位置和动量导数；反对称内力和沿位移方向中心力。；[EXTRA] 19号：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。

### 6. 审计结论

19号本地签名预审：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。

网站：网站PASS（EAUDIT复审）。
已核对derivative和主定理两声明：位置导数为v，动量导数为逐对力和，力反对称且位移叉力为零；cross3三个分量是标准叉积。逐对力矩抵消、角动量真实零导数及任意a,b∈I守恒俱全。[EXTRA]19号要求已落实为主定理的IsPreconnected I与两时刻相等；derivative辅助版不要求连通是合理的。三维结果包含原文平面嵌入。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2277；MD.Ch01.centralangularmomentum。

## 1. MD-1.7-CenterOfMassMotion · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> This means that the system will translate and rotate at a constant rate in time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centerofmassmotion :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i)) := by
  intro N m q v I a ho hi ha hm hM hq hp
  let P := ∑ i, m i • v a i
  have hPc (t : ℝ) (ht : t ∈ I) : (∑ i, m i • v t i) = P :=
    ho.is_const_of_deriv_eq_zero hi
      (fun s hs => (hp s hs).differentiableAt.differentiableWithinAt)
      (fun s hs => (hp s hs).deriv) ht ha
  have hQ (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • q s i) P t := by
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => (hq t ht i).const_smul (m i))
    rwa [hPc t ht] at hh
  have hR (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => (∑ i, m i • q s i)-s • P) 0 t := by
    simpa only [one_smul, sub_self, id_eq] using (hQ t ht).fun_sub ((hasDerivAt_id t).smul_const P)
  intro t ht
  have hc := ho.is_const_of_deriv_eq_zero hi
    (fun s hs => (hR s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hR s hs).deriv) ht ha
  have he : (∑ i, m i • q t i) = (∑ i, m i • q a i)+(t-a) • P := by
    calc
      _ = ((∑ i, m i • q a i)-a • P)+t • P := (sub_eq_iff_eq_add).mp hc
      _ = _ := by simp [sub_smul, sub_eq_add_neg, add_smul, neg_smul, add_assoc, add_comm, add_left_comm]
  have hh := congrArg (fun u => (∑ i,m i)⁻¹ • u) he
  simpa [P, smul_add, smul_smul, mul_comm] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centerofmassmotion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。 | [EXTRA] |

[EXTRA] 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
范围按context_notation只审translation。质量正且总质量正、a∈开放预连通I、q′=v、总动量真实零导数，推出每个t∈I质心为初始质心加(t−a)乘初始质心速度，分母和各求和均正确。旋转断言另交第7条；这里不能将整句的旋转部分视为已证明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2300；MD.Ch01.centerofmassmotion。

## 1. MD-1.7-ConstantRotationLiteral · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> This means that the system will translate and rotate at a constant rate in time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constantrotationliteral :
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  sorry

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。 -/
theorem constantrotationliteral_corrected_a (R ℓ : ℝ) (θ : ℝ → ℝ)
    (hR : 0 < R) (h : ∀ t, R^2 * deriv θ t = ℓ) :
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  refine ⟨ℓ/R^2,fun t => ?_⟩
  apply (eq_div_iff (pow_ne_zero 2 hR.ne')).mpr
  simpa [mul_comm] using h t

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：角速度随半径变化。 -/
theorem constantrotationliteral_corrected_b (r θ : ℝ → ℝ) (ℓ : ℝ)
    (h : ∀ t, 0 < r t ∧ (r t)^2 * deriv θ t = ℓ) :
    ∀ t, deriv θ t = ℓ/(r t)^2 := by
  intro t
  apply (eq_div_iff (pow_ne_zero 2 (h t).1.ne')).mpr
  simpa [mul_comm] using (h t).2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constantrotationliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |

[EXTRA] 

### 6. 审计结论

守恒的是角动量，转动惯量或半径可变时角速度可变。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal完整编码“r²θ′=ℓ且r>0推出恒角速”，忠实于原书旋转断言，但数学上不成立。corrected_a增加固定正半径后结论正确；corrected_b只作除以正r²的代数推导，正确且更贴近应保留的守恒律。两修正版均未假设所求恒角速。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2336；MD.Ch01.constantrotationliteral。

## 1. MD-1.7-IsoscelesCoordinates · definition · 印刷p.39 / PDFp.62

### 2. 原文陈述

> Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,
> \[\boldsymbol q_1=\begin{bmatrix}x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\\2y/3\\0\end{bmatrix},\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

/-- 修正版，对应原文 MD-1.7-IsoscelesCoordinates，改动：把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。 -/
def isoscelesCoordinates_corrected (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

theorem isoscelesCoordinates_corrected_center (x y : ℝ) :
    (∑ i : Fin 3, isoscelesCoordinates_corrected x y i) = 0 := by
  ext k
  fin_cases k <;> simp [isoscelesCoordinates_corrected,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isoscelesCoordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\boldsymbol q_1=\begin{bmatrix}x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\\2y/3\\0\end{bmatrix},\] | MD.Ch01.isoscelesCoordinates，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

零平动、零角动量不强迫任意三角形等腰；必须额外选择对称初态及证明对称性保持。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
三个向量分量、Fin 3次序及三维平面嵌入完全吻合。corrected定义数值上与原定义相同；corrected_center的三坐标和为零，单位质量下即质心零。修正的是适用范围而非坐标公式。原段由动量约束导出等腰的暗示不成立，必须由人工保留勘误说明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2362；MD.Ch01.isoscelesCoordinates。

## 1. MD-1.7-IsoscelesEnergyReduction · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> reducing the energy to
> \[E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),\]
> which describes the vibrational motion.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w := by
  have h01 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 1 =
      WithLp.toLp 2 ![2*x,0,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h02 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h12 : isoscelesCoordinates x y 1-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![-x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have hsq (z : V3) : ‖z‖^2 = (z 0)^2+(z 1)^2+(z 2)^2 := by
    simpa only [Fin.sum_univ_three,Real.norm_eq_abs,sq_abs] using
      PiLp.norm_sq_eq_of_L2 (fun _ : Fin 3 => ℝ) z
  have hn (a b : ℝ) : ‖(WithLp.toLp 2 ![a,b,0] : V3)‖ = Real.sqrt (a^2+b^2) := by
    rw [norm_eq_sqrt_real_inner,real_inner_self_eq_norm_sq,hsq]
    simp
  have hK : (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) = v^2+w^2/3 := by
    simp only [Fin.sum_univ_three,hsq]
    simp [isoscelesCoordinates]
    ring
  have h0 : Finset.Ioi (0:Fin 3) = {1,2} := by decide
  have h1 : Finset.Ioi (1:Fin 3) = {2} := by decide
  have h2 : Finset.Ioi (2:Fin 3) = ∅ := by decide
  rw [hK]
  unfold uniformLJEnergy
  simp only [Fin.sum_univ_three,h0,h1,h2,Finset.sum_singleton,Finset.sum_empty]
  rw [Finset.sum_pair (show (1:Fin 3) ≠ 2 by decide)]
  simp [pairDistance,h01,h02,h12,hn,Real.sqrt_sq_eq_abs,abs_of_pos hx,abs_mul,
    isoscelesEnergy,isoscelesPotential]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isosceles_energy_reduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),\] | MD.Ch01.isosceles_energy_reduction，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。 | [EXTRA] |

[EXTRA] 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
x>0使01距离为2x，另两距离为√(x²+y²)；速度坐标取(v,w)后动能为v²+w²/3。uniformLJEnergy用Ioi每对只计一次，等式不是前提。定义的总函数延拓在本x>0域不触及碰撞。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2378；MD.Ch01.isosceles_energy_reduction。

## 1. MD-1.7-IsoscelesAccessibleRegion · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> kinetic energy is non-negative, we must have
> \[2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem isoscelesaccessibleregion :
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E := by
  exact MolecularDynamics.Chapter01Review.isoscelesEnergyBound_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isoscelesaccessibleregion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.\] | MD.Ch01.isoscelesaccessibleregion，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
全称x,y,v,w,E，仅假设能量等于E；由v²+w²/3≥0推出isoscelesPotential≤E。势的两倍斜边项与底边项完整，无需额外动态或正性前提。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2415；MD.Ch01.isoscelesaccessibleregion。

## 1. MD-1.7-EquilateralTrimerMinimum · Example 1.8 (Planar Lennard-Jones Trimer) · 印刷p.38 / PDFp.61

### 2. 原文陈述

> The global minimum of this simple system must be radially symmetric. Placing the atoms at the vertices of an equilateral triangle, we have
> \[U=3\hat\varphi_{\mathrm{LJ}}(r),\]
> where $r$ is the length of a side. This is minimized when $r=2^{1/6}\approx1.1225$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem equilateraltrimerminimum :
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilateraltrimerminimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[U=3\hat\varphi_{\mathrm{LJ}}(r),\] | MD.Ch01.equilateraltrimerminimum，完整展开陈述见上一行及第4段 | 一致 |
| 全局极小值-3 | -3≤uniformLJEnergy 1 1 q | 一致 |
| 达到极小当且仅当三边等于2^(1/6) | 能量=-3 ↔ ∀i≠j,pairDistance…=Real.rpow 2 (1/6) | 一致 |
| 原文未显式量化的技术资格 | 单位LJ；非碰撞配置。 | [EXTRA] |

[EXTRA] 单位LJ；非碰撞配置。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
对任意三维非碰撞三点，势≥−3且等号当且仅当全部非同标距离为2^(1/6)。这是原文全局最低势与等边构型的正确精确化；三维三个点仍共面。每对φ+1=(2/r⁶−1)²≥0，等号恰在r⁶=2；未把约1.1225当精确值，未因sorry扣分。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2423；MD.Ch01.equilateraltrimerminimum。

## 1. MD-1.7-TrimerEnergyLowerBound · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> (When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimerenergylowerbound :
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q := by
  exact MolecularDynamics.Chapter01Review.trimerLowerBound_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimerenergylowerbound；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
任意非碰撞三粒子配置和任意速度，结论是动能加三对势≥−3；动能非负及每对势≥−1给出。与原文E<−3不可达一致；E>0部分按范围交第14条处理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2434；MD.Ch01.trimerenergylowerbound。

## 1. MD-1.7-CollinearTrimer · definition · 印刷p.40 / PDFp.63

### 2. 原文陈述

> Arranging the three atoms in a collinear configuration ($y=0$) the potential energy becomes $\hat U=\hat U(x)=2\hat\varphi_{\mathrm{LJ}}(x)+\hat\varphi_{\mathrm{LJ}}(2x)$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.collinearTrimer；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2443；MD.Ch01.collinearTrimer。

## 1. MD-1.7-TrimerSaddle · unnumbered_claim · 印刷p.40–41 / PDFp.63–64

### 2. 原文陈述

> Minimizing the potential in the collinear configuration allows us to determine the saddle point $(x^*,0)$. Near this point, $U$ decreases if we move in the $\pm y$ direction and increases if we move in the $\pm x$ direction.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimersaddle :
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimersaddle；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。 | [EXTRA] |

[EXTRA] x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
存在正x为全部正共线参数的全局极小，且存在同一个正δ，横向任何足够小非零位移严格增势、纵向任何足够小非零位移严格减势，量词及严格性符合原文。δ可缩至小于x排除u=0。令A=2+2⁻¹²，B=2+2⁻⁶，则共线势=4(Ax⁻¹²−Bx⁻⁶)，唯一极小满足x⁶=2A/B<2；故φ′(x)<0，纵向二阶项φ′(x)y²/x为负，横向二阶项为正。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2450；MD.Ch01.trimersaddle。

## 1. MD-1.7-TrimerEscapeLiteral · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> (When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimerescapeliteral :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop := by
  sorry

/-- 修正版，对应原文 MD-1.7-TrimerEscapeLiteral，改动：把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。 -/
theorem trimerescapeliteral_corrected :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => dist (q t i) (q t j)) atTop atTop := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimerescapeliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |

[EXTRA] 

### 6. 审计结论

总能量正并不直接推出每个粒子相对固定原点趋于无穷；系统分离与逐粒子逃逸不同。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=NEEDS_HUMAN（待独立散射论证）。
literal保留逐粒子范数趋∞的字面解释；签名具真实Newton导数、单位LJ力、全时非碰撞、正能量、零质心/动量/角动量及等腰约束，无循环前提，但逐粒子结论过强。corrected保留全部资格并改为存在固定一对距离趋∞，改动方向合理；此候选的强极限结论尚需独立散射论证，不能由能量非负或现有反例直接认证。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2461；MD.Ch01.trimerescapeliteral。

## 1. MD-1.7.1-ChaosConditions · definition · 印刷p.41–42 / PDFp.64–65

### 2. 原文陈述

> Typical definitions of a “chaotic dynamical system” [103] require at least the following conditions to be satisfied on the phase space $D$:
> • The solutions depend sensitively on the initial data taken from $D$;
> • The flow is topologically transitive in $D$.
> The second condition states that given arbitrarily small neighborhoods $D_1$ and $D_2$ of two different points in $D$ then it is possible to find a trajectory that goes from some point of $D_1$ to some point of $D_2$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.chaosConditions；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。 | [EXTRA] |
| 原文未显式量化的技术资格 | topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。 | [EXTRA] |

[EXTRA] 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。；topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。

### 6. 审计结论

两必要性质及transitivity邻域关系保留；敏感依赖正文随后“given pair rapidly grows”不是标准存在扰动量词，需导师确认数学化选择。

网站：网站PASS（EAUDIT复审）。
chaosConditions准确为敏感依赖和拓扑传递的合取。敏感依赖依次量化∃ε>0、∀x∈D、∀δ>0、∃y∈D、∃t≥0，近邻及分离不等号正确；ε>0已自动排除y=x。传递用环境开集与D交等价于相对开集形式，起终点都在D。作为两个条件的谓词可用于任意F,D；解释为混沌真实系统时还须外部限定F为流、D不变。原文说at least，不能把本谓词称为混沌的充分必要定义；已有注释明确这只是选定的严格化。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2491；MD.Ch01.chaosConditions。

## 1. MD-1.7.1-TransitivityErgodicityLiteral · unnumbered_claim · 印刷p.42 / PDFp.65

### 2. 原文陈述

> We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem transitivityergodicityliteral :
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.1-TransitivityErgodicityLiteral，改动：改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。 -/
theorem transitivityergodicityliteral_corrected {n : ℕ}
    (f : Position n → Position n) (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) [IsFiniteMeasure μ]
    (hf : ContDiff ℝ 1 f) (hflow : isFlowOf f F) (hcont : Continuous (Function.uncurry F))
    (hfull : ∀ U : Set (Position n), IsOpen U → U.Nonempty → μ U ≠ 0)
    (he : flowErgodic F μ) : topologicalTransitivity F univ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.transitivityergodicityliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。 | [EXTRA] |

[EXTRA] 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。

### 6. 审计结论

拓扑传递依赖拓扑，遍历性依赖选定不变测度；一般不能直接等价。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal在连续真实流和不变测度下断言拓扑传递↔测度遍历，忠实表达原句但普遍错误。corrected限制有限满支撑测度，仅断言遍历⇒拓扑传递，方向与条件正确；flowErgodic已含全部时间的测度保持。hf:C¹确保ODE唯一性，由isFlowOf得到群性质，故不缺流合成资格；连续性使开集时间饱和为开可测，有限测度复现可保证正向时间的传递。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2498；MD.Ch01.transitivityergodicityliteral。

## 1. MD-1.7.1-AnisotropicOscillator · Example 1.9 (Anisotropic Oscillator) · 印刷p.42 / PDFp.65

### 2. 原文陈述

> Consider the system with energy
> \[E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\tag{1.9}\]
> where
> \[c_3=\cos(3\theta)\]
> is defined in terms of the angular coordinate of the position $(x,y)$ with respect to the $(1,0)$-direction,
> \[\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,\]
> and we have defined
> \[\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.anisotropicEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\tag{1.9}\]；\[c_3=\cos(3\theta)\]；\[\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,\]；\[\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).\] | MD.Ch01.anisotropicEnergy，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 定义在r=0用Lean总函数延拓，物理域r>0。 | [EXTRA] |

[EXTRA] 定义在r=0用Lean总函数延拓，物理域r>0。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PDF字形确认κ及κ₀。anisotropicAngular以x/√(x²+y²)代入4c³−3c，与cos3θ一致；参数分别κ₀(1−εc₃/2)、l₀(1+εc₃/2)，势的κ/2及平方和动能全部正确。r>0物理域与r=0总函数延拓已注明，未把数值实验参数或轨迹观察误作全称定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2519；MD.Ch01.anisotropicEnergy。

## 1. MD-1.7.2-FlowJacobianLiteral · definition · 印刷p.44 / PDFp.67

### 2. 原文陈述

> Let a dynamical system $\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)$ be given in $\mathbb R^m$ with flow map $F_t:\mathbb R^m\to\mathbb R^m$ which we assume to be continuously differentiable. Let $\boldsymbol z(t,\boldsymbol\xi)$ represent the solution of initial value problem
> \[\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.\]
> We then compute the $m\times m$ Jacobian matrix of $F_t(\boldsymbol z(t,\boldsymbol\xi))$:
> \[\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)

/-- 修正版，对应原文 MD-1.7.2-FlowJacobianLiteral，改动：DF_t取值点从F_t(ξ)改为初值ξ。 -/
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.variationalMatrixLiteral；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.\]；\[\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).\] | MD.Ch01.variationalMatrixLiteral，完整展开陈述见上一行及第4段 | 一致 |
| W的取值点为z(t,ξ)=Ftξ | fderiv ℝ (F t) (F t ξ) | [ERRATUM?] 字面保留，未换为ξ |

[EXTRA] 

### 6. 审计结论

对初值求导的Jacobian应在初值取值；把演化后位置再次代入是复合了不同取值点。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal确为fderiv(F t)在F t ξ处的取值，忠实保留PDF的z(t,ξ)取值点；导数作为连续线性算子与欧氏Jacobian矩阵等价。corrected改为在ξ处取值是标准初值变分矩阵。两者为定义，可对任意F作总函数定义；真实流和C¹资格用于后续理论。作为原文变分理论基础有取值点疑误，保留人工裁定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2527；MD.Ch01.variationalMatrixLiteral。

## 1. MD-1.7.2-VariationalEquationLiteral · unnumbered_claim · 印刷p.44–45 / PDFp.67–68

### 2. 原文陈述

> Differentiating $\boldsymbol W(t)$ with respect to $t$ and using the differential equation and the chain rule, we have
> \[\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\tag{1.10}\]
> The system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $\mathrm d\boldsymbol z/\mathrm dt=\boldsymbol f(\boldsymbol z)$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem variationalequationliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-VariationalEquationLiteral，改动：采用W(t)=DF_t(ξ)，保留C¹向量场及真实流资格。 -/
theorem variationalequationliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral_corrected F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral_corrected F ξ t)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.variationalequationliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| \[\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\tag{1.10}\] | MD.Ch01.variationalequationliteral，完整展开陈述见上一行及第4段 | NEEDS_HUMAN |

[EXTRA] 

### 6. 审计结论

原W的取值点多复合一次F_t，时间微分产生额外链式项，不满足标准变分方程。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal完整保留C¹向量场、每个F_t为C¹、真实流初值和时间ODE，以及全部ξ,t上的算子导数；右端复合顺序Df(F_tξ)∘W正确，但原文字面W使方程失效。corrected使用DF_t(ξ)后为正确标准变分方程。C¹向量场和全局真实解以唯一性及局部参数依赖给出所需时间可微性，无需额外假设F联合C²；sorry不构成签名失败。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2538；MD.Ch01.variationalequationliteral。

## 1. MD-1.7.2-NearbyTrajectoryLiteral · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> If we have two solutions started from nearby initial conditions $\boldsymbol\xi,\hat{\boldsymbol\xi}$, then their difference is approximated by the solution of the variational equations
> \[\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).\]

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-NearbyTrajectoryLiteral，改动：线性化在初值ξ处取DF_t，固定t的余项为o(扰动)。 -/
theorem nearby_trajectory_literal_corrected :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral_corrected F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  intro n F hF t ξ
  exact ((hF t).differentiable (by norm_num) ξ).hasFDerivAt.isLittleO
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nearby_trajectory_literal；完整当前陈述及同组辅助定义见本条第4段 | NEEDS_HUMAN |
| \[\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).\] | MD.Ch01.nearby_trajectory_literal，完整展开陈述见上一行及第4段 | NEEDS_HUMAN |
| 原文未显式量化的技术资格 | ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。 | [EXTRA] |

[EXTRA] ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。

### 6. 审计结论

错误取值点的导数通常与真实DF_t(ξ)不同，差额线性项不是小o。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
固定t、ξ时以x→ξ的Fréchet小o严格化≈，扰动、基点、线性算子作用顺序均忠实。literal沿用错误取值点，不能成立。corrected改用DF_t(ξ)后正是HasFDerivAt的小o结论；只需每个F_t可微，故未要求真实流是合法推广，不是缺失的必要前提。未声称此结论关于t一致或对长时间有效。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2557；MD.Ch01.nearby_trajectory_literal。

## 1. MD-1.7.2-SingularValues · definition · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The square roots of the eigenvalues of $\boldsymbol A^T\boldsymbol A$, also called the singular values of $\boldsymbol A$, then give the axes of the image ellipsoid.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.singularValues；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。 | [EXTRA] |

[EXTRA] 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2575；MD.Ch01.singularValues。

## 1. MD-1.7.2-SingularEllipsoid · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> We may view a regular linear mapping $\boldsymbol v\mapsto\boldsymbol A\boldsymbol v$, where $\boldsymbol A\in\mathbb R^{m\times m}$, as a mapping of an $m-1$-dimensional sphere (embedded in the $m$-dimensional Euclidean space) to an ellipsoid in the same space (Fig. 1.26). The square roots of the eigenvalues of $\boldsymbol A^T\boldsymbol A$, also called the singular values of $\boldsymbol A$, then give the axes of the image ellipsoid.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem singularellipsoid :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1} := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.singularellipsoid；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。 | [EXTRA] |

[EXTRA] regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2584；MD.Ch01.singularellipsoid。

## 1. MD-1.7.2-LyapunovExponents · definition · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The Lyapunov exponents $\lambda_1,\lambda_2,\ldots,\lambda_m$ are defined by
> \[\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),\]
> where $\sigma_i$ represents the ith singular value of the given matrix (to maintain continuity, these should be ordered in some way, say largest to smallest).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lyapunovExponent；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| \[\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),\] | MD.Ch01.lyapunovExponent，完整展开陈述见上一行及第4段 | 一致 |
| limsup与有序奇异值 | Filter.limsup ((Real.log (σ t)/t : ℝ) : EReal) atTop；σ为singularValues关系的第i分量 | 一致 |
| 原文未显式量化的技术资格 | 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。 | [EXTRA] |

[EXTRA] 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2596；MD.Ch01.lyapunovExponent。

## 1. MD-1.7.2-PositiveLyapunovGrowth · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The presence of a positive Lyapunov exponent implies exponential growth of perturbations, which, as we have seen, is one of the hallmarks of chaos.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positivelyapunovgrowth :
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t := by
  intro σ hσ hpos
  obtain ⟨c,hc,hclim⟩ := EReal.exists_between_coe_real hpos
  refine ⟨c,EReal.coe_pos.mp hc,?_⟩
  intro T
  change (c : EReal) < Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop at hclim
  have hf := Filter.frequently_lt_of_lt_limsup (h := hclim)
  obtain ⟨t,htc,htt⟩ := (hf.and_eventually (eventually_gt_atTop (max T 0))).exists
  have ht : 0 < t := lt_of_le_of_lt (le_max_right T 0) htt
  refine ⟨t,lt_of_le_of_lt (le_max_left T 0) htt,?_⟩
  have hl : c < Real.log (σ t)/t := EReal.coe_lt_coe_iff.mp htc
  have he : c*t < Real.log (σ t) := (lt_div_iff₀ ht).mp hl
  exact (Real.exp_lt_exp.mpr he).trans_eq (Real.exp_log (hσ t ht))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positivelyapunovgrowth；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 正limsup蕴涵指数放大 | ∃c>0,∀T,∃t>T,Real.exp(c*t)<σ t | 一致；任意晚子列，不增强为全部晚时刻 |
| 原文未显式量化的技术资格 | 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。 | [EXTRA] |

[EXTRA] 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2603；MD.Ch01.positivelyapunovgrowth。

