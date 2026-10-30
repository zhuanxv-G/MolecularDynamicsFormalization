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

## 1. MD-1.1.2-AngleBond · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> When a trio of atoms with labels $`i`$, $`j`$, and $`k`$ admits a pair of length bonds, say $`(i,j)`$ and $`(j,k)`$, then an additional three-body term will need to be incorporated:

$$
\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,
$$


> where the angle $`\theta_{ijk}`$ is given in terms of the positions as

$$
\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.
$$



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
| $`\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,`$；$`\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.`$ | MD.Ch01.angleBondModel，完整展开陈述见上一行及第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.angleBondOnDomain | 总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。 |

[EXTRA] [EXTRA] 总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
公式在非零两键长上PASS，V3、内积、两范数乘积、arccos及弹簧系数均与原页一致。但当前angleBondModel接受所有三位置，没有非零键长的子类型或前提，context\_notation所说“两键长非零”没有落实，也未声明零分母仅是辅助总化扩展。Lean的除零为0会在原书角度未定义的重合构形给出实势，故按完整对象/域要求FAIL。k正也只是物理上下文，并非签名前提；本次不把原书的有向差约定自行换成通常补角约定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:489；MD.Ch01.angleBondOnDomain。

## 1. MD-1.1.2-Dihedral · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> Dihedral potentials typically are modelled using a trigonometric potential function, as

$$
\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].
$$



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
| $`\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].`$ | MD.Ch01.dihedralPotential，完整展开陈述见上一行及第4段 | 一致 |

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

$$
\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],
$$



$$
\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),
$$


> with

$$
\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\|\boldsymbol r\|-\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},
$$



$$
\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),
$$


> and

$$
W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].
$$


> Finally

$$
\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.
$$



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
| $`\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],`$；$`\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),`$；$`\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\Vert \boldsymbol r\Vert -\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},`$；$`\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),`$；$`W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].`$；$`\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.`$ | MD.Ch01.gayBerneModel，完整展开陈述见上一行及第4段 | 一致 |
| εGB=ε₁ε₂ | gayBerneEpsilonOne … * gayBerneEpsilonTwo …，没有平方ε₂ | 一致；旧正式定义平方与原页不同，未桥接 |
| ρ、χ、χ′及各向异性参数 | gayBerneModel的r/χ/χ′/Δ定义及原始定义文件 | 一致 |
| 21号网站建议修复 | MD.Ch01.gayBerneOnDomain | 原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。 |

[EXTRA] [EXTRA] 原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
全部代数展开在原书正常域上PASS：r=q₂−q₁、r̂=‖r‖⁻¹r，ε₁=ε₀/√(1−χ²(u₁·u₂)²)，ε₂=W(...,χ′)，W的两分母和正负号、χ与χ′的定义均一致。但Lean参数u₁,u₂仅为任意V3，不是原书的单位取向；q₁≠q₂、根号内严格正、σₛ/εₛ/μ及各有理式分母非零、Δ≠0均未编码。context\_notation已经明确这些域限定，却无相应[EXTRA]总化说明或有效域模型。总除法、Real.sqrt及Real.rpow会对非法参数继续返回值，因此完整域审校FAIL；不以旧库不同公式作为依据。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:526；MD.Ch01.gayBerneOnDomain。

## 1. MD-1.2-NewtonCompact · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> In this book, we shall frequently use a compact, vectorial notation, where $`\boldsymbol q`$ and $`\dot{\boldsymbol q}`$ represent vectors of the positions and velocities, and $`\boldsymbol M`$ is a diagonal mass matrix, so the equations of motion (1.2) become

$$
\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\tag{1.3}
$$



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
| $`\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\quad\text{(1.3)}`$ | MD.Ch01.compactNewton，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.compactNewton | 在原有两项真实时间导数资格后增加势能在q(t)处可微。 |

[EXTRA] 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。；[EXTRA] 在原有两项真实时间导数资格后增加势能在q(t)处可微。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：在原有两项真实时间导数资格后增加势能在q(t)处可微。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
时间一、二阶HasDerivAt确实阻止不可微q被总导数当伪解；massOperator通过Matrix.diagonal逐坐标作用，等式确为M q″=−gradient U。泛化维数n和任意对角实参数可作原式的代数模板，三维粒子物理使用须取n=3N及正质量三次重复。关键缺项是U:Position n→ℝ没有在q t可微的前提，gradient的总化定义仍可在不可微势点返回0，故未完整表达经典Newton力；[EXTRA]只修复了轨迹导数，没有修复势能梯度资格。域审校FAIL。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:540；MD.Ch01.compactNewton。

## 1. MD-1.2-DegreesFreedom · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $`N_d`$.

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

> For the N-body system in $`\mathbb R^3`$ without additional constraints there are $`N_d=N_c=3N`$ degrees of freedom. If $`r`$ independent constraints are present the number of degrees of freedom is $`N_d=N_c-r`$.

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
| 网站指出缺项及原文完整子句 | MD.Ch01.constraintdimension; MD.Ch01.constraintdimension\_unconstrained | 保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.constraintdimension; MD.Ch01.constraintdimension\_unconstrained | 保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。 |

[EXTRA] 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。；[EXTRA] 19号：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。

### 6. 审计结论

19号本地签名预审：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。

网站：网站PASS（EAUDIT复审）。
PASS。主定理的q子类型明确C¹正则可行点和fderiv满射，保证r≤n；结论degreesOfFreedom+r=n避免自然数减法截断。全部局部图分句已核对：U,V开放、q∈U、φ/ψ为C¹、双向MapsTo及两侧LeftInvOn，使U与V局部微分同胚；C x=c当且仅当φ(x)第二分量为0，给出d维自由坐标的真实层结构。constraintdimension\_unconstrained另以Position (3N)上的零个约束给核维数3N，覆盖无约束分句。局部图构造的sorry仅是证明未完成，不使正确签名FAIL。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:562；MD.Ch01.constraintdimension。

## 1. MD-1.2-TotalEnergy · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The total energy of the N-body system is a function of positions and velocities,

$$
E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\|\dot{\boldsymbol q}_j\|^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\tag{1.4}
$$



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
| $`E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\Vert \dot{\boldsymbol q}_j\Vert ^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\quad\text{(1.4)}`$ | MD.Ch01.particleTotalEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。N个三维位置q、速度v和粒子质量m，U以完整构形Fin N→V3为自变量；定义恰是Σ\_j m\_j‖v\_j‖²/2+U(q)。此为相空间能量函数定义，v是独立速度变量，不需在本定义中绑定某条轨迹导数。m允许任意实数是该代数式的扩展，物理正质量子域自然包含其中，未声称未加前提的能量正性或守恒。没有漏掉求和粒子或把势能逐粒子重复相加。

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

> and thus the three components of the total momentum vector $`\boldsymbol p_{\mathrm{tot}}:=\sum_{i=1}^{N}\boldsymbol p_i`$ will be conserved quantities.

### 3. 原文证明

> Since

$$
\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\boldsymbol F_i,
$$


> we have

$$
\sum_{i=1}^{N}\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\sum_{i=1}^{N}\boldsymbol F_i=0
$$


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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.momentum\_conservation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 两体力反向，净力相消 | F t i j = -F t j i → (∑ i, ∑ j, F t i j)=0 | 一致；净力为零是结论 |
| 全向量/每坐标动量守恒 | 真实HasDerivAt (∑ i,m i • v s i) 0及任意a,b∈I的值相等 | 一致 |
| 原文未显式量化的技术资格 | 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。 | [EXTRA] |

[EXTRA] 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。

### 6. 审计结论

审查后去掉旧桥接中净力零前提，由真实逐对作用反对称推出净力零和全向量/每坐标动量守恒，保留全部结论。

网站：网站PASS（EAUDIT复审）。
PASS。N任意，m为与时间无关的实质量，v给三维速度，pᵢ(t)=mᵢ•vᵢ(t)。I开放连通；F为全时间有序粒子对力，逐对反对称以及每个pᵢ的真实导数等于Σ\_jF\_ij为前提。三个完整结论依次是净内力零、总动量HasDerivAt零、任意a,b∈I的总动量相等；第三个向量等式同时给出三个分量守恒。质量正性不是这条代数守恒推论所必需；未把净力零或守恒偷放到假设中。[EXTRA]全部相符。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:616；MD.Ch01.momentum\_conservation。

## 1. MD-1.2-HarmonicSolution · Example 1.3 · 印刷p.19–20 / PDFp.42–43

### 2. 原文陈述

> Example 1.3 (Harmonic Oscillator) Consider the system

$$
\dot x=v,\qquad\dot v=-\Omega^2x.
$$


> This system describes the behavior of a particle with unit mass in one dimension, with energy function $`E(x,\dot x)=\dot x^2/2+\Omega^2x^2/2`$, where its motion is governed by a linear 2nd order equation $`\ddot x+\Omega^2x=0`$. The solution, for given $`x(0)=\xi`$, $`\dot x(0)=v(0)=\eta`$, is

$$
x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).
$$



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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.harmonic\_solution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot x=v,\qquad\dot v=-\Omega^2x.`$；$`x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).`$ | MD.Ch01.harmonic\_solution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.harmonic\_solution | 补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。 |

[EXTRA] Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。；[EXTRA] 补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
已写的harmonic\_solution本身正确：PASS其动力学、全实时间域、单位质量、初值和位置公式。PhaseSpace第二分量是动量，单位质量下等于速度；mechanicalVectorField的第一分量确为该速度，harmonicFlow第二分量也是位置的真实导数，n=1还原原式。按本任务“全部对象/完整结论”审校，仍有覆盖缺项：所给同source全部声明/依赖没有定义或连接原句的能量E=|v|²/2+Ω²|x|²/2；且只验证所构造的流，不含“任意满足该初值的解都由此公式给出”的唯一性结论。此FAIL是完整覆盖失败，不是现有显式式为假，不涉及sorry。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:659；MD.Ch01.harmonic\_solution。

## 1. MD-1.2-ScalarMechanical · Example 1.4 · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $`m=1`$ for simplicity) and energy function $`E(x,\dot x)=\dot x^2/2+U(x)`$ (which includes the harmonic oscillator as a special case). The equations of motion are

$$
\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.
$$



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
| $`\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.`$ | MD.Ch01.scalarMechanicalModel，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.scalarMechanicalModel | 沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.scalarMechanicalModel | 沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。 |
| 21号网站建议修复 | MD.Ch01.scalarMechanicalModel | 补E\_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。 |

[EXTRA] [EXTRA] 19号：沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。；[EXTRA] 补E\_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：补E\_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
scalarMechanicalModel的动力学部分PASS：任意实势U、实时间相轨迹z，逐时刻要求U在位置可微，HasDerivAt z (v,−U′(x))同时给出真实x′=v及v′=−U′，与单位质量方程相符，最新[EXTRA]也落实。完整条目仍FAIL：原句还定义E(x,ẋ)=ẋ²/2+U(x)，而所给全部当前声明只有ODE谓词；context\_notation提到的scalarPotentialEnergy并未给出定义或能量识别，不能把一个名字当成已经形式化。未要求本条之外的局部积分论证或能量守恒定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:689；MD.Ch01.scalarMechanicalModel。

## 1. MD-1.2-ScalarQuadrature · unnumbered_claim · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Near this point, provided $`\eta\ne0`$, let us solve the equation $`E(x,v)=E(\xi,\eta)`$ for $`v`$ as a unique smooth function of $`x,\xi,\eta`$ using the implicit function theorem: $`v=V(x,\xi,\eta)`$. Inserting this into the differential equations we then find

$$
\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).
$$


> This is a separable differential equation; it is therefore easily integrated from any provided initial value, $`x(0)=\xi`$, as a function of $`t`$, resulting in a relation $`x=X(t,\xi,\eta)`$. Then $`v=V(X(t,\xi,\eta),\xi,\eta)`$ and we see that it is possible to derive the formula for the solution $`(x,v)`$ as a function of $`t`$ and the initial conditions.

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalar\_quadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).`$ | MD.Ch01.scalar\_quadrature，完整展开陈述见上一行及第4段 | 一致 |
| V(x,ξ,η)光滑且能量式局部唯一确定速度 | 联合ContDiffOn ℝ ∞ V及隐式能量唯一性 | 一致 |
| 积分逆重建及初值参数光滑依赖 | 联合ContDiffOn ℝ ∞ X、实际ODE、X 0=ξ、积分=时间 | 一致；现有固定初值桥接不足 |
| 原文未显式量化的技术资格 | U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。 | [EXTRA] |

[EXTRA] U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。

### 6. 审计结论

已补完整x,ξ,η联合光滑参数化、局部唯一根、真实解与积分逆等式，未把固定初值局部定理当全条证明。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:697；MD.Ch01.scalar\_quadrature。

## 1. MD-1.2-UniformLJSystem · Example 1.5 · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The energy of the system is

$$
E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),
$$


> where $`r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|`$ and the mass $`m`$ of an argon atom is $`6.69\times10^{-26}`$ kg.

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
| $`E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),`$ | MD.Ch01.uniformLJSystem，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:719；MD.Ch01.uniformLJSystem。

## 1. MD-1.2-RadialLJForceLiteral · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The equations of motion are, for $`i=1,2,\ldots,N`$, using the chain rule,

$$
m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j) =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](../../\boldsymbol q_i-\boldsymbol q_j).
$$



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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.radial\_lj\_force\_literal；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j)\lt br\gt =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](../../\boldsymbol q_i-\boldsymbol q_j).`$ | MD.Ch01.radial\_lj\_force\_literal，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。 | [EXTRA] |

[EXTRA] 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。

### 6. 审计结论

Newton力为−∇U；印刷式把径向势梯度当成力，两个等号均反号。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
radial\_lj\_force\_literal：字面忠实性PASS；对象、有限和排除自粒子、正ε/σ、固定i的非碰撞和负梯度Newton前提都相符，但原书力符号与式1.3冲突，故数学陈述需NEEDS\_HUMAN，不能仅因其为假而把字面版判转录FAIL。radial\_lj\_force\_literal\_corrected：PASS；在相同全部对象、量词与前提下，第一式改为−φ′/r，第二式系数+24ε/σ，符合ljForce实际定义。对r≠0有φ′=24ε/r[(σ/r)^6−2(σ/r)^12]，两修正分句均正确；不需要额外假设a来自某条已存在轨迹。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:726；MD.Ch01.radial\_lj\_force\_literal。

## 1. MD-1.2-LJCoordinateScaling · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> Now introduce the change of variables

$$
\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,
$$


> then $`\dot{\boldsymbol q}_i=\sigma\dot{\boldsymbol Q}_i`$, $`\ddot{\boldsymbol q}_i=\sigma\ddot{\boldsymbol Q}_i`$, and $`\|\boldsymbol q_i-\boldsymbol q_j\|=\sigma\|\boldsymbol Q_i-\boldsymbol Q_j\|`$.

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lj\_coordinate\_scaling；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,`$ | MD.Ch01.lj\_coordinate\_scaling，完整展开陈述见上一行及第4段 | 一致 |
| 一阶、二阶及所有距离缩放 | 两个HasDerivAt结论及∀r s, ‖σ•r-σ•s‖=σ*‖r-s‖ | 一致 |
| 原文未显式量化的技术资格 | σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。 | [EXTRA] |

[EXTRA] σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。

### 6. 审计结论

实际导数缩放与全部距离缩放结论均已保留；σ正保证原文范数缩放不缺绝对值。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:775；MD.Ch01.lj\_coordinate\_scaling。

## 1. MD-1.2-LJTimeScaling · unnumbered_claim · 印刷p.21–22 / PDFp.44–45

### 2. 原文陈述

> Thus we see that if we make the additional time transformation

$$
\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},
$$


> then the equations become

$$
\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).
$$


> This means that a natural choice for the unit of time is

$$
\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.
$$


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
| $`\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},`$；$`\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).`$；$`\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.`$ | MD.Ch01.ljtimescaling，完整展开陈述见上一行及第4段 | 一致 |
| 时间缩放得到无参数单位质量系统 | 真实C2非碰撞Q的原Newton系统 ↔ ∀τ i,Q″=ljForce 1 1 | 一致 |
| 单位时间 | α⁻¹=σ*Real.sqrt (m/ε) | 一致 |
| 原文未显式量化的技术资格 | m,ε,σ,α正；真实C2非碰撞轨迹。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.ljtimescaling; MD.Ch01.ljtimescaling\_argon | 补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.ljtimescaling; MD.Ch01.ljtimescaling\_argon | 补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。 |
| 21号网站建议修复 | MD.Ch01.ljtimescaling | 仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。 |

[EXTRA] m,ε,σ,α正；真实C²非碰撞轨迹。；[EXTRA] 氩参数m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m；实际ljtimescaling\_argon结论采用显式容差0.01ps，非旧说明的0.005ps。给定参数下0.005ps界不成立；原书只写约2.17ps。保留双向缩放和时间单位结论。；[EXTRA] 本条采用显式容差0.01ps；两个定理保持不变。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
ljtimescaling：PASS。全部正参数、C²非碰撞Q、q(t)=σQ(αt)及α²关系明确；结论是有量纲Newton方程与全τ的单位参数方程双向等价，并给正确时间单位，反向时间覆盖由α>0保证。ljtimescaling\_argon：按其实际签名PASS，给|τ−2.17ps|<0.01ps，常数和单位换算正确。但本条最新[EXTRA]明说显式容差0.005ps，实际结论却为0.01ps；且给定精确十进制参数下0.005ps界是假的。故接收材料的[EXTRA]一致性FAIL，不能把0.01当已证明0.005。corrected\_json只将说明改成实际成立的0.01ps，不改原书近似或工程。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:789；MD.Ch01.ljtimescaling。

## 1. MD-1.3-Lagrangian · definition · 印刷p.22 / PDFp.45

### 2. 原文陈述

> For the system (1.3) with N atoms and $`N_c=3N`$ configuration coordinates, the Lagrangian is

$$
L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).
$$



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
| $`L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).`$ | MD.Ch01.fixedMassLagrangian，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:876；MD.Ch01.fixedMassLagrangian。

## 1. MD-1.3-GeneralizedCoordinates · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> When we introduce a smooth change of variables $`\boldsymbol q=\boldsymbol\Phi(\boldsymbol Q)`$, where $`\boldsymbol\Phi:\mathbb R^{N_c}\to\mathbb R^{N_c}`$, this induces a corresponding transformation of the velocity vector by

$$
\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},
$$


> where $`\boldsymbol\Phi'`$ is the $`N_c\times N_c`$ Jacobian matrix of $`\boldsymbol\Phi`$. Then the Lagrangian of the system is transformed to

$$
\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),
$$



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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.generalized\_coordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},`$；$`\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),`$ | MD.Ch01.generalized\_coordinates，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。 | [EXTRA] |

[EXTRA] 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。Φ:Position k→Position n，J为n×k矩阵；hΦ明确J是q(t)处的真实Fréchet导数，hq明确q的实际速度V。第一结论通过链式法则给d(Φ∘q)/dt=JV；第二结论把massLagrangian的Σ\_i m\_i v\_i²/2−U替换成⟨V,(Jᵀdiag(m)J)V⟩/2−U(Φ(q(t)))，矩阵排列、转置及系数均无误。标准实欧氏内积即原式行列乘积。原文smooth在点态结论中弱化至真实可微、k不必等于n，都是[EXTRA]已说明且成立的推广；本条代数恒等式不需正质量或满秩，正则可逆性由下一条另行处理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:883；MD.Ch01.generalized\_coordinates。

## 1. MD-1.3-GeneralizedMassRegular · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> We will assume that any such changes of variables are regular transformations in the sense that $`\boldsymbol\Phi'`$ is of full rank and the resulting generalized mass matrix is invertible.

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
PASS。m给n个坐标质量且逐个严格正，J为n×k矩阵，Injective J.mulVec是满列秩，自动保证k≤n，符合原书约束参数化情形。generalizedMassMatrix实为Jᵀdiag(m)J；对非零v，由Jv≠0有vᵀJᵀMJv=Σ\_i m\_i(Jv)_i²>0，因此该k×k矩阵可逆。IsUnit正是矩阵环中的可逆性，未预先假设结论；k=0情形亦正常。J作为任意满足满列秩的矩阵推广覆盖真实Jacobian的情形；[EXTRA]正质量及列单射均落实。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:898；MD.Ch01.generalizedmassregular。

## 1. MD-1.4-ConvexLegendre · definition · 印刷p.24 / PDFp.47

### 2. 原文陈述

> Abstractly, a Legendre transformation of a given convex function $`g=g(\boldsymbol\xi):\mathbb R^m\to\mathbb R`$ is a new function $`\widetilde g=\widetilde g(\boldsymbol\eta):\mathbb R^m\to\mathbb R`$ defined by

$$
\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),
$$



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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.legendreTransform；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),`$ | MD.Ch01.legendreTransform，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。 | [EXTRA] |

[EXTRA] 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。

### 6. 审计结论

凸性不能保证共轭函数每一点有限；实数sSup在无上界时的总化值不能充当真实上确界。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
legendreTransform 及 _corrected：PASS，任意 n、g:Position n→ℝ、η，EReal 的 iSup 正确实现扩展实共轭；未要求凸性是对所有实函数定义的合理推广，并未声称其处处实值。_literal：忠实性 PASS，ConvexOn univ 的任意 g 对每个 η 有实 IsLUB，正是原书实值断言，但数学上错误。_corrected\_b：PASS，固定 η 的 BddAbove 加非空 range 足以推出实 sSup 的 IsLUB；凸性不是此上确界事实所必需。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:913；MD.Ch01.legendreTransform。

## 1. MD-1.4-HamiltonEquations · definition · 印刷p.24 / PDFp.47

### 2. 原文陈述

> The equations of motion can be written

$$
\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.
$$



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
| $`\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.`$ | MD.Ch01.hamiltonEquations，完整展开陈述见上一行及第4段 | 一致 |
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

> For constant $`\boldsymbol M`$ we obtain the dynamical equations,

$$
\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.
$$



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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamilton\_fixed\_mass；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.`$ | MD.Ch01.hamilton\_fixed\_mass，完整展开陈述见上一行及第4段 | 一致 |
| 一般固定矩阵M的两Hamilton偏梯度 | M.PosDef；动量梯度matrixAction M⁻¹ p，位置梯度gradient U q | 一致；保留一般SPD矩阵 |
| 原文未显式量化的技术资格 | 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。 | [EXTRA] |

[EXTRA] 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。

### 6. 审计结论

保留一般常质量矩阵，两个实际梯度给出全部Hamilton方程分量；旧库对角特例不匹配此忠实签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:951；MD.Ch01.hamilton\_fixed\_mass。

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

> The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $`\mathbb R^3`$ is described by coordinates and positions, i.e., by a point in $`\mathbb R^{6N}`$.

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

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
finiteEnergyPhaseDomain 与 _corrected：PASS，PhaseSpace n=Position n×Momentum n，H:EReal，排除顶和底恰表示有限实能量。_corrected\_dimension：PASS，任意 N，包括0，证明的是环境向量空间 PhaseSpace(3*N) 的实维数 6*N，不是断言任意有限能量子集自身为6N维流形。修正版按前句把笔误理解成位置与动量合理；原文笔误仍需人工确认。

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
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.local\_exist\_unique；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。 | [EXTRA] |

[EXTRA] generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
固定对角质量、开放非奇异配置域 Q，z₀.1∈Q，任意 t₀；力 -∇U 在Q各点 C¹。存在 ε>0、γ(t₀)=z₀、两侧开时间区间上的真实机械积分曲线并留Q；任意共同开放时间域上的同初值解在 t₀ 邻域最终相等，正确表达局部唯一而非全函数相等。CoordinateMasses 只是实函数，未要求正/非零，故这是总化矩阵逆向量场的较广ODE定理；用于物理 Hamilton 模型须另有正质量背景，不能由本条推出零质量物理模型。数学上的局部存在唯一结论仍对该较广定义正确，未增加隐蔽结论。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1016；MD.Ch01.local\_exist\_unique。

## 1. MD-1.5-EnergySurface · definition · 印刷p.25 / PDFp.48

### 2. 原文陈述

> For given $`E_0\geq U_{\min}`$ define $`\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}`$.

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

