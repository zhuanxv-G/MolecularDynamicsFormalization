上一部分：无 / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第1章 Lean Blueprint 本地审阅材料

141条；网站PASS110、本地按意见修复10（未再送网站）、原书疑误待导师21。全部复审返回已登记；本轮不再送网站。完整检查见CLOSEOUT21/full/CHECK\_REPORT.json。

## 1. MD-1.5.3-Thm1.1 · Theorem 1.1 · 印刷p.32 / PDFp.55

### 2. 原文陈述

> If $`\boldsymbol{q}^*`$ is a strong local minimum of smooth potential $`U`$ then $`\boldsymbol{z}^*=(\boldsymbol{q}^*,0)`$ is stable.

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.theorem\_1\_1；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | hm: 每个固定对角质量正；来自§1.5正定背景，定理句未重复。 | [EXTRA] |
| 原文未显式量化的技术资格 | hQ: 势能位置域Q开放；局部ODE和极小值邻域须位于定义域。 | [EXTRA] |
| 原文未显式量化的技术资格 | hstrict包含q₀∈Q；补出原文默认的定义域资格。 | [EXTRA] |

[EXTRA] hm: 每个固定对角质量正；来自§1.5正定背景，定理句未重复。；hQ: 势能位置域Q开放；局部ODE和极小值邻域须位于定义域。；hstrict包含q₀∈Q；补出原文默认的定义域资格。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:111；MD.Ch01.theorem\_1\_1。

## 1. MD-1.2-EnergyConservation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> Along the solutions of (1.3), the energy is conserved, since its derivative vanishes:

### 3. 原文证明


$$
\frac{\mathrm{d}}{\mathrm{d}t}E=\sum_{j=1}^{N}m_j\dot{\boldsymbol{q}}_j\cdot\ddot{\boldsymbol{q}}_j+\sum_{j=1}^{N}\frac{\partial U}{\partial\boldsymbol{q}_j}\cdot\dot{\boldsymbol{q}}_j=\sum_{j=1}^{N}\left(m_j\ddot{\boldsymbol{q}}_j+\frac{\partial U}{\partial\boldsymbol{q}_j}\right)\cdot\dot{\boldsymbol{q}}_j=0.
$$


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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energy\_conservation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | hm: 固定对角质量正；牛顿相空间重写使用逆质量。 | [EXTRA] |
| 原文未显式量化的技术资格 | hU: U在Q每点可微；保证原文链式法则有意义。 | [EXTRA] |
| 原文未显式量化的技术资格 | 时间取开连通区间Ioo a b；能量比较仅对s,t属于该区间，不作越过解存在区间的结论。 | [EXTRA] |

[EXTRA] hm: 固定对角质量正；牛顿相空间重写使用逆质量。；hU: U在Q每点可微；保证原文链式法则有意义。；时间取开连通区间Ioo a b；能量比较仅对s,t属于该区间，不作越过解存在区间的结论。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:129；MD.Ch01.energy\_conservation。

## 1. MD-1.3-NewtonEulerLagrange · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> The equations of motion may be expressed in terms of the Lagrangian as:

$$
\frac{\mathrm{d}}{\mathrm{d}t}\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\frac{\partial L}{\partial\boldsymbol{q}}.
$$


> (Note that this must be interpreted in general as a set of $`N_c=3N`$ equations, one for each atomic coordinate.)

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.newton\_iff\_euler\_lagrange；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\mathrm{d}}{\mathrm{d}t}\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\frac{\partial L}{\partial\boldsymbol{q}}.`$ | MD.Ch01.newton\_iff\_euler\_lagrange，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | hm: 每个固定对角质量正；用于从相空间方程回到牛顿方程。 | [EXTRA] |
| 原文未显式量化的技术资格 | hI: 时间域开放；把within导数还原为原文双侧时间导数。 | [EXTRA] |
| 原文未显式量化的技术资格 | hU: U在Q可微；保证位置偏导是实际导数。 | [EXTRA] |

[EXTRA] hm: 每个固定对角质量正；用于从相空间方程回到牛顿方程。；hI: 时间域开放；把within导数还原为原文双侧时间导数。；hU: U在Q可微；保证位置偏导是实际导数。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:165；MD.Ch01.newton\_iff\_euler\_lagrange。

## 1. MD-1.4-LegendreHamiltonian · unnumbered_claim · 印刷p.24 / PDFp.47

### 2. 原文陈述

> If $`\boldsymbol{M}(\boldsymbol{q})`$ is invertible, the supremum is achieved precisely when

$$
\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p},
$$


> which gives the standard definition of the momentum vector $`\boldsymbol{p}`$ in terms of velocities,

$$
\boldsymbol{p}=\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\boldsymbol{M}(\boldsymbol{q})\dot{\boldsymbol{q}},
$$


> and, with $`\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p}`$, the Legendre transformation results in a new function

$$
H(\boldsymbol{q},\boldsymbol{p})\stackrel{\mathrm{def}}{=}\boldsymbol{p}^TM(\boldsymbol{q})^{-1}\boldsymbol{p}/2+U(\boldsymbol{q}).
$$


> This is precisely the energy function, written in terms of positions and momenta.

### 3. 原文证明

原书无独立完整证明。
原文仅展示将U(q)从上确界中移出的代数恒等式，未独立证明上界、达到条件及唯一性；该段原文完整保存于proof\_discussion\_latex。

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamiltonian\_legendre\_transform；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p},`$；$`\boldsymbol{p}=\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\boldsymbol{M}(\boldsymbol{q})\dot{\boldsymbol{q}},`$；$`H(\boldsymbol{q},\boldsymbol{p})\stackrel{\mathrm{def}}{=}\boldsymbol{p}^TM(\boldsymbol{q})^{-1}\boldsymbol{p}/2+U(\boldsymbol{q}).`$ | MD.Ch01.hamiltonian\_legendre\_transform，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |

[EXTRA] [EXTRA] hPositive : (M q).PosDef；展开p23正物理质量及满秩Jacobian继承的对称正定背景，任意可逆矩阵反例不属于此子类。字面可逆原句保留，配置相关M及全部六项结论不变。

### 6. 审计结论

任意可逆矩阵不足以保证凹二次目标有最大值；需继承机械质量的对称正定背景。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
逐项核对任意 n、配置相关 M、实值 U、q/p、IsUnit 和 PosDef。主声明及 _corrected：PASS，六项依次给有上界、sup=H、唯一达到点、全部速度处真实梯度 Mv、逆变换动量、能量对应；PosDef 含实对称性，是合理且已披露的机械背景补充。_literal：字面忠实性 PASS，仅可逆原句及其全部意涵被保留；数学有效性有原书疑误，不能作为任意可逆矩阵定理采信。没有把 sorry 当作失败依据。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:206；MD.Ch01.hamiltonian\_legendre\_transform。

## 1. MD-1.5.1-FlowInverse · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The classical systems treated here can be solved forward or backward in time. Observe that $`\mathcal{F}_{-t}\mathcal{F}_t=\operatorname{Id}`$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $`t`$ form an Abelian group under the operation of composition ($`\mathcal{F}_t\mathcal{F}_s=\mathcal{F}_s\mathcal{F}_t=\mathcal{F}_{t+s}`$).

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flow\_inverse；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | hψ: 显式全实时间解及S不变，落实正文双向可解和flow map前提；本条不证明全局流存在。 | [EXTRA] |
| 原文未显式量化的技术资格 | hreg: F在Q为C¹，用于ODE唯一性，落实正文继承的存在唯一性前提。 | [EXTRA] |
| 原文未显式量化的技术资格 | _hm: 正固定质量，使对象限于原文分子Hamiltonian系统。 | [EXTRA] |

[EXTRA] hψ: 显式全实时间解及S不变，落实正文双向可解和flow map前提；本条不证明全局流存在。；hreg: F在Q为C¹，用于ODE唯一性，落实正文继承的存在唯一性前提。；_hm: 正固定质量，使对象限于原文分子Hamiltonian系统。

### 6. 审计结论

按原页核对所有量词、实际导数及完整结论；显式技术前提与范围见[EXTRA]和对应表；既有桥接适用于该签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:271；MD.Ch01.flow\_inverse。

## 1. MD-1.1-Schrodinger · definition · 印刷p.5 / PDFp.28

### 2. 原文陈述

> The Schrödinger equation itself is a partial differential equation of the following form:

$$
i\hbar\frac{\partial\Phi}{\partial t}=-\hbar^2\sum_{j=1}^{13}\frac{1}{2\mu_j}\left(\frac{\partial^2\Phi}{\partial q_{j,x}^2}+\frac{\partial^2\Phi}{\partial q_{j,y}^2}+\frac{\partial^2\Phi}{\partial q_{j,z}^2}\right)+U_P(q_{1,x},q_{1,y},\ldots,q_{13,z})\Phi.\tag{1.1}
$$



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
| $`i\hbar\frac{\partial\Phi}{\partial t}=-\hbar^2\sum_{j=1}^{13}\frac{1}{2\mu_j}\left(\frac{\partial^2\Phi}{\partial q_{j,x}^2}+\frac{\partial^2\Phi}{\partial q_{j,y}^2}+\frac{\partial^2\Phi}{\partial q_{j,z}^2}\right)+U_P(q_{1,x},q_{1,y},\ldots,q_{13,z})\Phi.\quad\text{(1.1)}`$ | MD.Ch01.schrodingerEquation，完整展开陈述见上一行及第4段 | 一致 |
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

> where the forces are determined from the potential energy function $`U`$. Denoting the coordinates of the $`i`$th nucleus of an N-atom system by $`q_{i,x},q_{i,y},q_{i,z}`$, and the atomic mass by $`m_i`$, the equations of motion for the $`i`$th nucleus can be written out as

$$
m_i\frac{\mathrm d^2q_{i,x}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,x}},\qquad m_i\frac{\mathrm d^2q_{i,y}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,y}},\qquad m_i\frac{\mathrm d^2q_{i,z}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,z}}.\tag{1.2}
$$


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
| $`m_i\frac{\mathrm d^2q_{i,x}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,x}},\qquad m_i\frac{\mathrm d^2q_{i,y}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,y}},\qquad m_i\frac{\mathrm d^2q_{i,z}}{\mathrm dt^2}=-\frac{\partial U}{\partial q_{i,z}}.\quad\text{(1.2)}`$ | MD.Ch01.newtonInitialValueModel，完整展开陈述见上一行及第4段 | 一致 |
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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hardSphereModel；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
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

$$
U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\qquad U_{ijk}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k),\qquad U_{ijkl}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k,\boldsymbol q_l),
$$


> where $`\boldsymbol q_i`$ is the position vector of atom $`i`$ such that $`(q_{i,x},q_{i,y},q_{i,z})=\boldsymbol q_i\in\mathbb R^3`$.

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
| $`U_{ij}(\boldsymbol q_i,\boldsymbol q_j),\qquad U_{ijk}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k),\qquad U_{ijkl}(\boldsymbol q_i,\boldsymbol q_j,\boldsymbol q_k,\boldsymbol q_l),`$ | MD.Ch01.multibodyPotential，完整展开陈述见上一行及第4段 | 一致 |
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

$$
\varphi_{\mathrm{Morse}}(r)=D\left(1-e^{-a(r-r_e)}\right)^2.
$$



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
| $`\varphi_{\mathrm{Morse}}(r)=D\left(1-e^{-a(r-r_e)}\right)^2.`$ | MD.Ch01.morsePotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:366；MD.Ch01.morsePotential。

## 1. MD-1.1.1-MorseMinimum · unnumbered_claim · 印刷p.8 / PDFp.31

### 2. 原文陈述

> (See Fig. 1.5.) $`r_e`$ is the location of the minimum, $`D`$ gives the well depth, and $`a`$ is a shape parameter that can be used to control the curvature at the minimum.

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.morse\_minimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| rₑ处极小、井深D | ∀ r>0, 0≤morsePotential…; morsePotential…rₑ=0; Tendsto … atTop (𝓝 D) | 一致 |
| a controls curvature | 定性形状参数合并context\_notation；原书未给二阶导数公式 | 一致（定性背景） |
| 原文未显式量化的技术资格 | D,a,rₑ正；well depth解释为无穷远极限减最小值。 | [EXTRA] |
| 网站FAIL指出全部曲率/实际粒子距离缺项 | MD.Ch01.morse\_minimum | 完整签名补齐；新增计算明确EXTRA，不回填成原书句子；网站复审尚未验证 |

[EXTRA] D,a,rₑ正；well depth解释为无穷远极限减最小值。；[EXTRA] EAUDIT03补原曲率子句的实际展开φ″(rₑ)=2Da²，并表达固定D>0时正a增大曲率严格增大；公式为形式化展开，不回填成教材原句。

### 6. 审计结论

EAUDIT03本地预审：完整最小值、阱深及实际二阶曲率2Da²和固定D的正a严格单调性。

网站：网站PASS（EAUDIT复审）。
PASS。对所有D,a,rₑ>0，势D(1−exp(−a(r−rₑ)))²在r>0非负、在rₑ为零，且r→+∞极限为D，正好给出最小点及井深。二阶导在rₑ为2Da²；固定D>0及rₑ，0<a₁<a₂时2Da₁²<2Da₂²，正确落实曲率控制。rₑ>0保证最小点在径向域内。全部五个合取分句及[EXTRA]都正确；sorry不参与签名判定。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:372；MD.Ch01.morse\_minimum。

## 1. MD-1.1.1-LengthBond · definition · 印刷p.9 / PDFp.32

### 2. 原文陈述

> Because they often do not need to be allowed to break during simulation and are very strong compared to other potential terms, chemical bonds such as the covalent $`\mathrm H_2^+`$ bond described above are sometimes treated as springs with given rest-length:

$$
\varphi_{ij}^{\mathrm{len}}(r_{ij})=\frac{k_{ij}^{\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\qquad r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|.
$$



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
| $`\varphi_{ij}^{\mathrm{len}}(r_{ij})=\frac{k_{ij}^{\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\qquad r_{ij}=\Vert \boldsymbol q_i-\boldsymbol q_j\Vert .`$ | MD.Ch01.lengthBond，完整展开陈述见上一行及第4段 | 一致 |
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

$$
\varphi_{\mathrm{disp}}(r)\sim-\frac K{r^6},\qquad K\gt 0.
$$



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
| $`\varphi_{\mathrm{disp}}(r)\sim-\frac K{r^6},\qquad K\gt 0.`$ | MD.Ch01.dispersionPotential，完整展开陈述见上一行及第4段 | 一致 |

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

$$
\varphi_B(r)=Ae^{-Br}-\frac C{r^6},\qquad A\gt 0,\ B\gt 0,\ C\gt 0.
$$



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
| $`\varphi_B(r)=Ae^{-Br}-\frac C{r^6},\qquad A\gt 0,\ B\gt 0,\ C\gt 0.`$ | MD.Ch01.buckinghamPotential，完整展开陈述见上一行及第4段 | 一致 |

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

$$
\varphi_{\mathrm{LJ}}(r)=4\epsilon\left[\left(\frac\sigma r\right)^{12}-\left(\frac\sigma r\right)^6\right].
$$



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
| $`\varphi_{\mathrm{LJ}}(r)=4\epsilon\left[\left(\frac\sigma r\right)^{12}-\left(\frac\sigma r\right)^6\right].`$ | MD.Ch01.lennardJonesPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:403；MD.Ch01.lennardJonesPotential。

## 1. MD-1.1.1-LJRepulsion · unnumbered_claim · 印刷p.10–11 / PDFp.33–34

### 2. 原文陈述

> Because of the strongly repulsive character of short-ranged soft walls in molecular dynamics, i.e., the fact that $`\varphi_{\mathrm{LJ}}`$ tends rapidly to positive infinity as $`r\to0`$, the atoms remain well separated in long simulations. The singularity at $`r=0`$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lj\_repulsion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| r→0时趋正无穷 | Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop | 一致 |
| 长模拟中通常保持分离 | context\_notation；严格有限能量无碰撞旧CH01-198排除 | 一致（定性经验） |

[EXTRA] 

### 6. 审计结论

有限能量的精确轨道和长时间数值模拟的经验频率是不同命题；缺算法、步长、时间窗和概率模型。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
lj\_repulsion：PASS，对全部ε,σ>0，使用从正距离趋零的𝓝[>]0而非把总函数在0的值当极限，结论正确。lj\_repulsion\_corrected：PASS，对任意有限实能级E，存在δ>0使所有0<r<δ的势值>E，正是该极限的严格屏障表述。两条均不提供轨迹、数值算法、能量上界、长时间区间或概率模型，因而不能覆盖整段原文的long simulations/well separated/rarely经验断言。修正版没有冒称已推出无条件无碰撞；原文经验量词如何纳入正式结论须人工确定，故条目汇总NEEDS\_HUMAN。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:409；MD.Ch01.lj\_repulsion。

## 1. MD-1.1.1-HeterogeneousLJ · definition · 印刷p.11 / PDFp.34

### 2. 原文陈述

> When there are many atoms of different types, the parameters of the potential will depend on this, so we obtain contributions to the total potential energy of the form

$$
\varphi_{ij}^{\mathrm{LJ}}(r_{ij})=4\epsilon_{ij}\left[\left(\frac{\sigma_{ij}}{r_{ij}}\right)^{12}-\left(\frac{\sigma_{ij}}{r_{ij}}\right)^6\right],
$$


> where $`r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|`$.

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
| $`\varphi_{ij}^{\mathrm{LJ}}(r_{ij})=4\epsilon_{ij}\left[\left(\frac{\sigma_{ij}}{r_{ij}}\right)^{12}-\left(\frac{\sigma_{ij}}{r_{ij}}\right)^6\right],`$ | MD.Ch01.heterogeneousLJ，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] [EXTRA] EAUDIT03补真实V3和pairDistance=‖qᵢ−qⱼ‖；总函数公式对应域为pairDistance>0，零距离的总化取值不解释为物理势。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。N任意，ε、σ均为Fin N×Fin N上的实参数表，q给出每个粒子的真实V3位置；i,j的势为4ε\_ij[(σ\_ij/‖q\_i−q\_j‖)^12−(σ\_ij/‖q\_i−q\_j‖)^6]。pairDistance定义正是该欧氏距离。原文未在此声明混合规则、参数表对称性或总势求和，Lean也未额外声称这些。距离零处Lean总除法给出有限扩展值；本条[EXTRA]已明确只在pairDistance>0解释为原势，故不把该扩展当作物理碰撞势。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:440；MD.Ch01.heterogeneousLJ。

## 1. MD-1.1.2-Coulomb · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> When, as in the case of the alanine dipeptide, net charges are present on the atoms, one may model this by means of Coulomb potentials:

$$
\varphi_{ij}^{\mathrm{Coulomb}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}},
$$


> where $`\epsilon\gt 0`$ is the dielectric constant, and $`Q_i,Q_j`$ are the charges on atoms $`i`$ and $`j`$, respectively. $`C`$ is a positive coefficient allowing the adjustment of units. Obviously the effect of the Coulombic potential depends strongly on whether the atoms have the same or oppositely signed charges.

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
| $`\varphi_{ij}^{\mathrm{Coulomb}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}},`$ | MD.Ch01.coulombPotential，完整展开陈述见上一行及第4段 | 一致 |
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

> In the simplest treatments, the Coulomb potential is simply cut off at distance $`r_{\mathrm{cut}}`$, i.e., is taken to be zero for $`r\gt r_{\mathrm{cut}}`$. This should be done in such a way that the potential remains at least continuously differentiable, preferably smoother (see Exercise 11).

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
| 网站指出缺项及原文完整子句 | MD.Ch01.smoothCutoff | C¹只要求正距离域，保留严格r\_cut<r截零及正截断半径。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.smoothCutoff | C¹只要求正距离域，保留严格r\_cut<r截零及正截断半径。 |

[EXTRA] [EXTRA] 19号：C¹只要求正距离域，保留严格r\_cut<r截零及正截断半径。

### 6. 审计结论

19号本地签名预审：C¹只要求正距离域，保留严格r\_cut<r截零及正截断半径。

网站：网站PASS（EAUDIT复审）。
PASS。smoothCutoff是修饰后势φ的性质：r\_cut>0、φ在正距离域C¹、对所有r>r\_cut取零；没有在r=0要求C¹，故不排除Coulomb原点奇性。由于r\_cut位于正距离域内部，C¹与右侧恒零还蕴含截断点的函数和一阶导数接零，无须另把边界点写入截零量词。原文没有给出具体开关函数或要求在整个截断半径以下精确等于未修饰Coulomb势；未引入这些额外结论。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:455；MD.Ch01.smoothCutoff。

## 1. MD-1.1.2-Yukawa · definition · 印刷p.12 / PDFp.35

### 2. 原文陈述

> More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $`\kappa`$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:

$$
\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.
$$



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
| $`\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.`$ | MD.Ch01.yukawaScreened，完整展开陈述见上一行及第4段 | 一致 |
| exp(-κr) | Real.exp (-κ * r) | 一致；κ称屏蔽长度的量纲疑点见原文issues |
| 网站指出缺项及原文完整子句 | MD.Ch01.yukawaScreened; MD.Ch01.yukawaScreened\_corrected\_a; MD.Ch01.yukawaScreened\_corrected\_b | 正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.yukawaScreened; MD.Ch01.yukawaScreened\_corrected\_a; MD.Ch01.yukawaScreened\_corrected\_b | 正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。 |

[EXTRA] [EXTRA] 19号：正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。

### 6. 审计结论

原文称κ为长度，但无量纲指数−κr通常要求κ为逆长度。Lean实数类型不携带量纲，此疑点必须文字核查。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
yukawaScreened：字面公式及C、dielectric、r的正子类型PASS；κ按实参数保留，未暗改原书指数。原文称κ为长度，而指数−κr若无量纲则κ应有逆长度量纲，此矛盾需人工确认。yukawaScreened\_corrected\_a：PASS，κ>0解释为逆屏蔽长度，保留−κr；yukawaScreened\_corrected\_b：PASS，ℓ>0解释为长度，使用−r/ℓ。两修正版在κ=1/ℓ时一致，电荷仍任意实数，其他正域条件相符。汇总NEEDS\_HUMAN来自原书参数称谓与公式的冲突，不来自修正版的代数。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:462；MD.Ch01.yukawaScreened。

