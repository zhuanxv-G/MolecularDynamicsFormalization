# 第5章 Lean Blueprint 本地审阅材料

183条；网站PASS 148，本地按意见修复6条（未再送网站），合并勘误26项。
统计与证明状态见[导师摘要](CH05_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](CH05_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch05/full/CHECK_REPORT.json。

## 1. MD-5.1-LieDerivative · definition · 印刷p.180 / PDFp.201

### 2. 原文陈述

> In Chap. 3, we introduced the Lie derivative of a function $g$ of the phase variables with respect to a dynamical system $\dot z=f(z)$:
> \[\mathcal L_fg=f\cdot\nabla g.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lie` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 实有限维欧氏空间中的 Fréchet 导数作用于 f(z)，在 g 可微处恰为 f·∇g；顺序和标量值域一致。定义本身未声明可微性，Lean 的 fderiv 在不可微处的全定义延拓不应解释为原书对不可微 g 的断言；数学作用域是有导数的可观测量。context_notation 的 EuclideanSpace/fderiv 是实现说明，不是教材原句。无 [EXTRA]、[ERRATUM?]，定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lie`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L27)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-TrajectoryChain · unnumbered_claim · 印刷p.180 / PDFp.201

### 2. 原文陈述

> This is obtained by differentiating a composite function $g(z(t))$ with respect to $t$, along a solution trajectory. That is, describing a trajectory in terms of the flow map by $z(t)=\mathcal F_t(\xi),t\in\mathbb R$, we have
> \[\frac d{dt}g(\mathcal F_t(\xi))=(\mathcal L_fg)(\mathcal F_t(\xi)).\]
> The partial derivative of $\widetilde g(z,t)$ with respect to $t$ is
> \[\frac{\partial\widetilde g}{\partial t}(t,z)=\nabla g(\mathcal F_t(z))\cdot\frac d{dt}\mathcal F_t(z)=\nabla g(\mathcal F_t(z))\cdot f(\mathcal F_t(z))=(\mathcal L_fg)(\mathcal F_t(z)).\tag{5.1}\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.trajectoryChain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。 | [EXTRA] |

[EXTRA] [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 依赖 MolecularDynamics/Chapter03/LiePoisson.lean:2527–2541 展开 textbookLieDerivative f φ z = (fderiv ℝ φ z)(f z)，并逐项读取 hasDerivAt_textbookLieDerivative 的 hφ、hγ 和结论，未凭名称判定。E 是任意实赋范空间；f、φ、γ、t 任意，假设 φ 在 γ(t) 可微、γ 在 t 的导数为 f(γ(t))，结论给出复合函数的真实时间导数。取 γ(u)=Φ u ξ 即同时覆盖轨道式与固定 z 的式(5.1)；梯度点乘的中间计算由欧氏空间链式法则表达，未增加假设结论。局部可微 [EXTRA] 必要且合理；一般赋范空间是推广，不缩小欧氏对象。源式(5.1)的 (t,z) 保留为原书参数书写问题，Lean 固定 z 后沿时间求导消除此歧义。证明调用上述真实链式法则，无本条 sorry；未作编译认证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.trajectoryChain`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L31)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-ActualFlow · definition · 印刷p.180 / PDFp.201

### 2. 原文陈述

> describing a trajectory in terms of the flow map by $z(t)=\mathcal F_t(\xi),t\in\mathbb R$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。 | [EXTRA] |

[EXTRA] [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 定义同时要求零时刻恒等、所有实时间的群律、每个初值上满足自治 ODE 的实际导数。对象是完整欧氏相空间上的全局流，时间与初值的全称量词对应原文 t∈ℝ 及任意初值。零时刻、群律是 flow map 的结构，ODE 条件忠实于 solution trajectory；[EXTRA] 合理而非结论循环。本条仅刻画已给定全局流，不声称任意向量场都有全局流；一般局部流需要另改定义域。定义无 sorry，无 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.flow`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L39)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-ObservablePullback · definition · 印刷p.180–181 / PDFp.201–202

### 2. 原文陈述

> Replacing $\xi$ by $z$ (it is an arbitrary point), define a function $\widetilde g(z,t)\stackrel{\rm def}{=}g(\mathcal F_t(z))$.
> It is intuitively appealing to define the solution of (5.2) by
> \[\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 任意 X、Φ、g、t、z 的定义直接等于 g(Φ t z)，覆盖原文的可观测量回拉。原文 G_t=e^{t L_f} 在 context_notation 中明确作为此回拉解算子的记号，非收敛指数级数主张；已展开依赖 solutionOperator Φ t g = pullback Φ g t，因而符号解释有实际定义支持。将 Φ 专门化为 flow 时 Φ 0=id，使 g̃(·,0)=g，于是 G_t g̃(·,0)=g̃(·,t)。泛型定义不要求流，是定义的自然推广；本条没有声称任意 Φ 的回拉满足 PDE。无 [EXTRA]、[ERRATUM?]，无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.pullback`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L44)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-FlowFieldTransport · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> On the other hand, viewing $\mathcal L_f$ as an operator on the phase variables only, we have
> \[(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]
> =f(z)\cdot[\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))]
> =[\mathcal F_t'(z)f(z)]\cdot\nabla g(\mathcal F_t(z))
> =f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))
> =(\mathcal L_fg)(\mathcal F_t(z)).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowFieldTransport :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z) := by
  sorry

theorem flowFieldTransport_observable (n : ℕ)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hΦ : ContDiff ℝ 2 (Function.uncurry Φ))
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) (_hg : ContDiff ℝ 1 g) (t : ℝ)
    (z : MolecularDynamics.Chapter05Review.E n) :
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z)) ∧
    (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z))=
      (fderiv ℝ g (Φ t z)) (f (Φ t z)) ∧
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flowFieldTransport`；`MD.Ch05.flowFieldTransport_observable` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。 | [EXTRA] |

[EXTRA] [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。；[EXTRA] 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全部对象为任意有限维实欧氏空间E n、自治向量场f、全时间实际流Φ。flow含零时恒等、群律及轨道ODE，联合C²保证初值可微。首声明保留DΦ_t(z)f(z)=f(Φ_t(z))；observable对任意C¹实值g及任意t,z给出链式中间式、向量场输运后的中间式及最终Lie交换式。转置/梯度写法与Fréchet导数作用等价；两条声明合并覆盖原等式链。[EXTRA]充分光滑资格明确，无循环前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.flowFieldTransport`：未证（缺大型理论）；`MD.Ch05.flowFieldTransport_observable`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L49)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-PullbackPDE · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> This is the same as the right hand side of (5.1). This means that $\widetilde g$ satisfies the equation
> \[\frac{\partial\widetilde g}{\partial t}=\mathcal L_f\widetilde g.\tag{5.2}\]
> This is a time-dependent, linear (hyperbolic) partial differential equation.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem pullbackPDE :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => MolecularDynamics.Chapter05Review.pullback Φ g s z) (MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pullbackPDE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 展开 HasDerivAt 结论中的 pullback 与 lie 后，正是 d/ds|s=t g(Φ_s(z)) = D[g∘Φ_t](z) f(z)，即式(5.2)。量词覆盖所有 n、f、Φ、g、t、z；真实 flow 排除了任意映射冒充 ODE 流。[EXTRA] 联合 C² 流和 C¹ 可观测量保证空间与时间求导合法，C² 强于所需 C¹，但合理而非循环。原文的线性/一阶输运（hyperbolic）说明是此算子的性质，不是额外 PDE 存在唯一性主张；签名覆盖本条 PDE 断言。正文有 sorry：语义 PASS，证明未完成，未编译认证。无 [ERRATUM?]。

### 7. 状态与证明位置

incomplete；`MD.Ch05.pullbackPDE`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L72)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-SteadyFirstIntegral · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The steady state solutions of this equation (defined by $\partial\widetilde g/\partial t=0$) are of the form $\widetilde g(z,t)=\varphi(z)$ where $\varphi$ satisfies $\mathcal L_f\varphi(z)\equiv0$. These are just the first integrals of the ordinary differential equation system $\dot z=f(z)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem steadyFirstIntegral :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → Differentiable ℝ g → ((∀ z,MolecularDynamics.Chapter05Review.lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z) := by
  intro n f Φ g hflow hg
  constructor
  · intro hz t z
    have ht : ∀ s : ℝ,HasDerivAt (fun u => g (Φ u z)) 0 s := by
      intro s
      have hc := (hg (Φ s z)).hasFDerivAt.comp_hasDerivAt s (hflow.2.2 s z)
      change HasDerivAt (fun u => g (Φ u z)) (MolecularDynamics.Chapter05Review.lie f g (Φ s z)) s at hc
      rw [hz] at hc
      exact hc
    have hh := is_const_of_deriv_eq_zero (fun s => (ht s).differentiableAt) (fun s => (ht s).deriv)
    simpa only [hflow.1] using hh t 0
  · intro hh z
    have hd := (hg (Φ 0 z)).hasFDerivAt.comp_hasDerivAt 0 (hflow.2.2 0 z)
    have heq : (fun s => g (Φ s z))=(fun _ : ℝ => g z) := funext (fun s => hh s z)
    simp only [Function.comp_def] at hd
    rw [heq] at hd
    simpa only [MolecularDynamics.Chapter05Review.lie,hflow.1] using
      hd.unique (hasDerivAt_const 0 (g z))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.steadyFirstIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。 | [EXTRA] |

[EXTRA] [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 任意 n、f、实际全局流 Φ、可微 g；结论双向：(∀z,Dg(z)f(z)=0) ↔ (∀t z,g(Φ_t(z))=g(z))，无单向缺失或把恒定性作为前提。右边就是第一积分/回拉与时间无关，且可微轨道上时间导数为零等价于此恒定性，所以原文稳态形如 φ(z) 及 L_fφ≡0 的两项通过该双向关系表达。[EXTRA] 对所有初值的真实 flow 与 g 可微必要且合理；群律在此证明并非必需，但作为 flow 的标准结构合理。源码含链式法则、零导数推出常值及反向导数唯一性的证明，无本条 sorry；未作编译认证。无 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.steadyFirstIntegral`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L80)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-CoordinatePullback · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The interpretation of the solution of the initial value problem in terms of the solution operator $G_t$ is given by
> \[(e^{t\mathcal L_f}\partial_i)(z(0))=z_i(t).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i := by
  apply MolecularDynamics.Chapter05Review.coordinatePullback_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.coordinatePullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 依赖 ReviewProofs.lean:5644–5645 的 coordinatePullback_proved 已展开：pullback Φ (fun x => x i) t z = Φ t z i，由 rfl。E n 为实际 EuclideanSpace，i : Fin n 是坐标索引；可观测量 fun x => x i 忠实于原文明确规定的 ∂_i(z)=z_i，绝非偏微分算子。取 z=z(0)，Φ 为实际 flow，右边为 z_i(t)，G_t/e^{tL_f} 按本批 context_notation 是回拉记号。对任意 Φ 的恒等式比实际流实例更一般，不需要流存在或算子指数收敛假设；无额外假设、无 [ERRATUM?]。源码复用 rfl 证明，无本条 sorry；未编译认证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.coordinatePullback`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L103)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-SolutionOperator · definition · 印刷p.181 / PDFp.202

### 2. 原文陈述

> $\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def solutionOperator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.pullback Φ g t

theorem solutionOperator_initial {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (hf : MolecularDynamics.Chapter05Review.flow f Φ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) :
    solutionOperator f Φ hf 0 g=g := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.solutionOperator`；`MD.Ch05.solutionOperator_initial` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。 | [EXTRA] |

[EXTRA] [EXTRA] 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；solutionOperator对任意n,f及满足实际flow的Φ定义G_t g=g∘Φ_t，initial对任意g给出G₀g=g。以初值g定义g̃时，所引解算子关系由pullback直接表达。[EXTRA]与context明确e^(tL_f)只作实际拉回算子的记号，未声称构造无界算子的指数级数；在该范围内定义忠实。

### 7. 状态与证明位置

incomplete；`MD.Ch05.solutionOperator`：定义；`MD.Ch05.solutionOperator_initial`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L109)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-CoordinateLie · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The projection onto the $i$th coordinate, denoted $\partial_i$, is itself a scalar valued function of $z$ ($\partial_i(z)=z_i$). Calculating directly we have $\mathcal L_fz_i=f_i$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i := by
  intro n f z i
  change (fderiv ℝ (fun x : MolecularDynamics.Chapter05Review.E n => x i) z) (f z)=f z i
  change (fderiv ℝ (PiLp.proj 2 (fun _ : Fin n => ℝ) i : MolecularDynamics.Chapter05Review.E n →L[ℝ] ℝ) z) (f z)=f z i
  rw [ContinuousLinearMap.fderiv]
  rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.coordinateLie` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、任意f、任意z和全部i:Fin n，真实坐标投影x↦x i的Lie导数等于f z i。坐标投影为连续线性函数，不需要f可微；没有把原书∂ᵢ误解成作用于其他函数的偏导算子。

### 7. 状态与证明位置

self-contained；`MD.Ch05.coordinateLie`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L124)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-LiePullbackCommutes · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> $ (\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]
> =f(z)\cdot[\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))]
> =[\mathcal F_t'(z)f(z)]\cdot\nabla g(\mathcal F_t(z))
> =f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))
> =(\mathcal L_fg)(\mathcal F_t(z))$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liePullbackCommutes : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liePullbackCommutes` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实际自治流、联合C²的Φ及C¹实值g，对所有实时间t和z断言L_f(g∘Φ_t)(z)=(L_fg)(Φ_t z)。对象、作用变量与方向正确；原等式链的两端完整保存，中间链式法则等价，[EXTRA]为充分资格。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liePullbackCommutes`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L134)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> Let $D\subset\mathbb R^m$ be a suitable set comprising the collection of admissible phase space points $z$. A density on $D$ is a function $\rho:D\to\mathbb R$ such that (i) $\rho(z)\geq0,z\in D$, and (ii) $\int_D\rho\,d\omega<\infty$, where $d\omega=dz_1dz_2\cdots dz_m$ (i.e. $\int_D\rho\,d\omega$ is the integral of the measurable function $\rho$ in the Lebesgue sense).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def densityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityOn` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。 | [EXTRA] |

[EXTRA] [EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182正文及脚注1要求Lebesgue可测D、可测ρ:D→ℝ、D内逐点非负与有限积分。实际定义展开为 NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧ (∀z∈D,0≤ρ z) ∧ IntegrableOn ρ D。NullMeasurableSet表达与Borel可测集几乎处处相同，恰为Lebesgue完备化可测；实值函数对受限测度的AEMeasurable对应完成测度下的可测性。IntegrableOn是对volume.restrict D的Bochner可积性，在非负实值条件下等价于原文有限Lebesgue积分，并排除了Bochner积分对不可积函数取0的误用。ρ写成全空间函数仅为域内函数选择任意域外延拓；所有资格和积分只依赖D内值，未要求域外非负或可积。n是原文m的任意有限维度重命名，无额外维数限制。[EXTRA]的可测域/函数及可积资格来自原文和脚注；AEMeasurable与IntegrableOn中的可测性部分重叠但无实质加强。无[ERRATUM?]。本条为定义，无证明占位问题。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityOn`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L141)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-ProbabilityDensityOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> A probability density function (or p.d.f.) on $D$ is a density which is normalized so that $\int_D\rho\,d\omega=1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def probabilityDensityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.probabilityDensityOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182给出“density which is normalized”及∫_Dρdω=1。实际 probabilityDensityOn D ρ := densityOn D ρ ∧ (∫z in D,ρ z)=1。递归展开densityOn后，完整保留Lebesgue可测D、受限可测ρ、D内逐点非负和可积，再附加同一D上的积分为1。对象为域D上的密度，不换成全空间密度；域外延拓不影响该条件。可积资格保证积分取实际值而非不可积时的默认0。无额外假设，无[ERRATUM?]。本条为定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.probabilityDensityOn`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L146)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityOnNormalization · unnumbered_claim · 印刷p.182 / PDFp.203

### 2. 原文陈述

> Any density (with positive total integral) can be normalized by dividing by $\int_D\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem densityOnNormalization : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityOn D ρ → 0 < (∫ z in D,ρ z) →
    probabilityDensityOn D (fun z => ρ z/(∫ x in D,ρ x)) := by
  intro n D ρ hd hp
  refine ⟨⟨hd.1,hd.2.1.div_const _,?_,hd.2.2.2.div_const _⟩,?_⟩
  · intro z hz
    exact div_nonneg (hd.2.2.1 z hz) hp.le
  · rw [integral_div,div_self hp.ne']
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityOnNormalization` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182明确要求“with positive total integral”，并按∫_Dρdω相除。实际量词为∀n D ρ，假设依次为densityOn D ρ、0<∫_Dρ，结论为probabilityDensityOn D (z↦ρ(z)/∫_Dρ)。展开前后两个密度谓词，结论包含归一化函数的受限可测性、D内逐点非负、可积以及积分恰为1，全部原文结论均保留。原密度可积使分母有限，正性使分母非零；除以正常数保持资格，积分线性给出归一化。未把归一化当假设。正积分资格来自原书，非[EXTRA]；无[ERRATUM?]。本批附件附有证明且该声明无sorry；PASS仅评价签名语义，不宣称本轮已编译工程。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityOnNormalization`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L150)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityProbability · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> For any measurable subset $A$ of $D$, and probability density $\rho$, we define $\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def densityProbability {n : ℕ} (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) : ℝ :=
  ∫ z in A,ρ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityProbability` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182定义可测A⊆D及概率密度ρ下的Pr(A)=∫_Aρdω。实际 densityProbability ρ A := ∫z in A,ρ z，恰为同一受限Lebesgue/Bochner积分。它作为总函数未把资格编码进参数，但也未声明所有输入都产生概率；本条context_notation将资格留到后续界定理，实际densityProbabilityBounds签名确有probabilityDensityOn D ρ、A⊆D、NullMeasurableSet A volume。展开这些资格后，ρ在A上可积且非负，故定义在原书允许的输入上与Pr(A)完全一致，域外延拓无影响。对任意无资格输入的默认积分值不应解释成原书概率，当前声明及上下文没有作这种断言。无实质额外假设，无[ERRATUM?]。本条为定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityProbability`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L160)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityMeasureOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> For any measurable subset $A$ of $D$, and probability density $\rho$, we define $\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def densityMeasureOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityMeasureOn` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。 | [EXTRA] |

[EXTRA] [EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182同一Pr(A)=∫_Aρdω公式的测度表示。实际 densityMeasureOn D ρ := (volume.restrict D).withDensity (z↦ENNReal.ofReal (ρ z))。展开其使用的项目别名E后，在原文资格probabilityDensityOn D ρ及Lebesgue可测A⊆D下，withDensity给出对受限Lebesgue测度的非负扩展实值积分；ENNReal.ofReal在D内ρ≥0时不改变值，域外的负值或其他延拓不影响受限积分。故该测度对A的值为ENNReal.ofReal(∫_Aρ)，其toReal为densityProbability ρ A；总质量由∫_Dρ=1得到1，D外质量为0。签名允许一般ρ以定义总函数，不断言这些输入均为概率测度，也不限制任意概率测度必须有密度。[EXTRA]仅为将原书实值积分概率实现为测度的合理表示选择，无新增实质资格或遗漏原文事件公式。无[ERRATUM?]。定义的语义对应可在标准含义下判断，无需本轮补写桥接证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityMeasureOn`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L165)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-LebesgueClosure · unnumbered_claim · 印刷p.182 / PDFp.203

### 2. 原文陈述

> The technical requirement is that $D$ be Lebesgue-measurable. Open and closed sets in $\mathbb R^m$ are Lebesgue-measurable, for example a rectangular box. Sets which are constructed by taking countable unions or intersections of measurable sets are measurable.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lebesgueClosure : ∀ n (s : Set (MolecularDynamics.Chapter05Review.E n)) (A : ℕ → Set (MolecularDynamics.Chapter05Review.E n)),
  (IsOpen s → NullMeasurableSet s volume) ∧ (IsClosed s → NullMeasurableSet s volume) ∧
  ((∀ k,NullMeasurableSet (A k) volume) →
    NullMeasurableSet (⋃ k,A k) volume ∧ NullMeasurableSet (⋂ k,A k) volume) := by
  intro n s A
  refine ⟨fun h => h.measurableSet.nullMeasurableSet,fun h => h.measurableSet.nullMeasurableSet,?_⟩
  intro h
  exact ⟨NullMeasurableSet.iUnion h,NullMeasurableSet.iInter h⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lebesgueClosure` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182脚注1说明D的Lebesgue可测要求、开闭集（矩形盒示例）可测，以及可数并/交保持可测。实际∀n s (A:ℕ→Set(E n))，结论合取开集可测、闭集可测，以及若∀k A k可测则⋃k A k与⋂k A k均可测；四项均用NullMeasurableSet · volume，故是Lebesgue完备化可测族而非仅Borel族。前提顺序没有额外限制，可数族以ℕ索引覆盖可数并交，空族情形的空集与全空间同样可测。矩形盒作为示例由坐标区间的可测性及有限交给出，不要求把每种盒单独列为定理结论；D可测的上下文要求已在densityOn明确编码。无额外假设或[ERRATUM?]。本批附件有证明且该声明无sorry；本轮PASS是语义判定，不是编译结果。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lebesgueClosure`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L169)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-BorelSigma · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> A suitable family of sets on which Lebesgue measure can be defined is the so-called Borel $\sigma$-algebra obtained by countable unions, intersections, or relative complements of open balls in $\mathbb R^m$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def borelSigma (n : ℕ) : MeasurableSpace (MolecularDynamics.Chapter05Review.E n) := borel (MolecularDynamics.Chapter05Review.E n)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.borelSigma` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182脚注1末句指定由欧氏开球经σ代数生成得到的Borel族。实际 borelSigma n := borel (E n)。展开E后，标准borel是欧氏拓扑中由全部开集生成的最小σ代数；ℝⁿ有可数开球基，任意开集是该基中球的可数并，因此与由开球生成的σ代数一致。可数并、交和相对补是σ代数闭包操作，原文与定义的生成含义相同。context_notation区分Borel与其Lebesgue完备化，与前条采用NullMeasurableSet相容；无缺失原文条件，无额外假设或[ERRATUM?]。本条为定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.borelSigma`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L179)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityProbabilityBounds · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> It is automatic that $0\leq\operatorname{Pr}(A)\leq1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem densityProbabilityBounds : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  probabilityDensityOn D ρ → A ⊆ D → NullMeasurableSet A volume →
    0 ≤ densityProbability ρ A ∧ densityProbability ρ A ≤ 1 := by
  intro n D A ρ hp hAD hA
  have hnD : 0 ≤ᵐ[volume.restrict D] ρ := by
    filter_upwards [ae_restrict_mem₀ hp.1.1] with z hz
    exact hp.1.2.2.1 z hz
  have hnA : 0 ≤ᵐ[volume.restrict A] ρ := by
    filter_upwards [ae_restrict_mem₀ hA] with z hz
    exact hp.1.2.2.1 z (hAD hz)
  refine ⟨setIntegral_nonneg_of_ae_restrict hnA,?_⟩
  change (∫ z in A,ρ z) ≤ 1
  rw [← hp.2]
  exact setIntegral_mono_set hp.1.2.2.2 hnD (Filter.Eventually.of_forall hAD)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityProbabilityBounds` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。 | [EXTRA] |

[EXTRA] 原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF204/印刷183首句给出0≤Pr(A)≤1，承接PDF203的可测A⊆D及概率密度ρ资格。实际∀n D A ρ，依次假设probabilityDensityOn D ρ、A⊆D、NullMeasurableSet A volume，结论同时保留0≤densityProbability ρ A及densityProbability ρ A≤1。递归展开后，前提为D Lebesgue可测、ρ受限可测、D内逐点非负、D上可积、∫_Dρ=1，以及可测A⊆D；结论为0≤∫_Aρ≤1。A上的非负与可积继承自D，积分单调性给出∫_Aρ≤∫_Dρ=1。注释中资格来自原文上下文，必要且合理，未引入实质[EXTRA]，未用“测度已是概率测度”代替密度归一化。无[ERRATUM?]。本批附件有证明且该声明无sorry；未进行本轮Lean编译，签名忠实性与证明状态分别评价。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityProbabilityBounds`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L183)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DomainL2 · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The set of functions from $\mathcal D\subset\mathbb R^m$ to $\mathbb R$ which satisfy (5.3) is referred to as the space $L^2(\mathcal D)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)



/-- 修正版，对应原文 MD-5.2.1-DomainL2。改动：明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。 -/
```

独立修正版：

```lean
@[reducible] def domainL2_corrected (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2`；`MD.Ch05.domainL2_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。 | [EXTRA] |

[EXTRA] [EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。；[ERRATUM?] 明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；domainL2对任意n和D采用Lp ℝ 2 (volume.restrict D)，是可测平方可积函数的几乎处处等价类，数学上是合理的标准L²实现。[EXTRA]已披露AE商，然而原句字面是原生函数集合；这是原书的语义省略，不能把商空间静默当作逐字原文。修正方案合理，但忠实字面版与标准解释仍需人工确认。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2`：定义；`MD.Ch05.domainL2_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L201)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Norm · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> we define the $L^2(\mathcal D)$ norm by $\|\phi\|_{L^2(\mathcal D)}\stackrel{\rm def}{=}[\int_{\mathcal D}\phi^2(z)\,d\omega]^{1/2}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖



/-- 修正版，对应原文 MD-5.2.1-L2Norm。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def domainL2Norm_corrected {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Norm`；`MD.Ch05.domainL2Norm_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；domainL2Norm的g属于先前标准Lp实现的domainL2 n D，定义为其真实范数。按用户允许直接采信Mathlib标准含义，该实L²范数正是积分平方的平方根；不需要额外假设g的可积性或另造范数。所给定义没有独立积分公式定理，不能据此宣称该独立接口已经提供；这不改变定义的数学签名正确性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Norm`：定义；`MD.Ch05.domainL2Norm_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L210)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Inner · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> for any $\phi,\psi\in L^2(D)$, the inner product is defined by $\langle\phi,\psi\rangle_{L^2(D)}\stackrel{\rm def}{=}\int_D\phi(z)\psi(z)\,d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Inner` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）的 ∀φ,ψ∈L²(D)，⟨φ,ψ⟩=∫D φψ，对应 Ch05.lean:177–178 的 domainL2Inner f g := ∫ z in D, f z*g z。展开 domainL2，f、g 是同一限制测度下的实 L² 类；标准 Hölder/Cauchy–Schwarz 保证乘积可积，积分与代表选择无关。标准 L2.inner_def 与实数内积的乘法表达表明它恰为真实 L² 内积。对象、全部输入及积分域一致，没有遗漏前提或加入额外前提。定义无 sorry，无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Inner`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L218)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2NormSquare · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> Thus $\|\phi\|_{L^2(\mathcal D)}^2=\langle\phi,\phi\rangle_{L^2(\mathcal D)}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g := by
  intro n D g
  change ‖g‖^2=∫ z in D,g z*g z
  simpa only [MeasureTheory.L2.inner_def,Real.inner_apply] using (real_inner_self_eq_norm_sq g).symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2NormSquare` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对所有n,D及g:domainL2 n D断言domainL2Norm g²=domainL2Inner g g。摘录的inner确为∫_D g(z)g(z)，norm为Lp范数，实值域、平方与自内积的顺序正确；标准Lp资格已包含平方可积性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2NormSquare`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L222)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Complete · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> This is a real Hilbert space or complete inner product space in which, for any $\phi,\psi\in L^2(\mathcal D)$, the inner product is defined by $\langle\phi,\psi\rangle_{L^2(\mathcal D)}\stackrel{\rm def}{=}\int_{\mathcal D}\phi(z)\psi(z)\,d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu



/-- 修正版，对应原文 MD-5.2.1-L2Complete。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem domainL2Complete_corrected : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Complete`；`MD.Ch05.domainL2Complete_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；在domainL2采用标准AE商Lp解释下，∀n,D及所有Cauchy序列u存在同空间极限v的声明正确，等价于该度量空间完备性；Lp的实内积结构与积分自洽。但原书将前述原生函数集合直接称为Hilbert空间，正定性存在AE资格省略。[EXTRA]披露了修正；不能把修正版的正确性等同于原书字面正确性。所引内积积分定义不在本条主声明中，项目在条目7摘录了domainL2Inner，可作配套定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Complete`：已证；`MD.Ch05.domainL2Complete_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L231)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2SymmetricBilinear · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The inner product is a symmetric, bilinear operation: if $\alpha,\beta$ are real scalars and $f,g,h\in L^2(D)$, then $\langle\alpha f+\beta g,h\rangle=\alpha\langle f,h\rangle+\beta\langle g,h\rangle$, and $\langle f,g\rangle=\langle g,f\rangle$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem domainL2SymmetricBilinear : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f := by
  intro n D f g h a b
  have hi : ∀ u v : domainL2 n D,domainL2Inner u v=inner ℝ u v := by
    intro u v
    simp only [domainL2Inner,MeasureTheory.L2.inner_def,Real.inner_apply]
  simp only [hi,inner_add_left,inner_smul_left,real_inner_comm]
  simp
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2SymmetricBilinear` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）的线性公式和对称公式，在 Ch05.lean:195–203 由合取同时保留：inner(a•f+b•g,h)=a*inner(f,h)+b*inner(g,h)，以及 inner(f,g)=inner(g,f)。n、D、f、g、h、a、b 均任意，全称量词中独立标量的位置换序无语义变化。展开 domainL2Inner 为乘积积分、domainL2 为真实 L² 类后，标准 Lp 的加法/实数标量乘法与代表元的逐点运算 a.e. 一致，全部乘积可积。对称性加左线性也蕴含右线性，故原文“symmetric, bilinear”完整保留。无新增前提。证明无 sorry；不将此事实与签名语义混淆，本轮未编译。无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2SymmetricBilinear`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L245)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-CompactL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The space $L^2(\mathbb R^m)$ includes for example the continuous functions with compact (closed, bounded) support, where the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\operatorname{supp}f$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compactL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume := by
  intro n g hg hs
  exact hg.memLp_of_hasCompactSupport hs
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.compactL2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）称欧氏空间上的连续紧支持实函数属于 L²，且 support 是非零集合的闭包。Ch05.lean:206–209 对任意 n 和 g:E n→ℝ，以 Continuous g 与 HasCompactSupport g 为前提，结论 MemLp g 2 volume。按标准含义 HasCompactSupport g 是 tsupport g 的紧性，tsupport=closure(Function.support g)，Function.support 是非零集合；因此与原书闭支持定义一致。在有限维欧氏空间中紧等价于闭且有界；连续紧支持函数有界且支集的 Lebesgue 测度有限，确为平方可积。MemLp 同时提供可测资格，正好表达原文包含关系，无须强行构造商类作为结论。对象、全部假设及结论一致，无额外假设。证明无 sorry，本轮未编译；无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.compactL2`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L256)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityAverageOn · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Given a density $\rho$, we may identify a collection of functions $g$ for which the integral with respect to $\rho$ is bounded, i.e. for which we can define the inner product $\langle g,\rho\rangle=\int_Dg(z)\rho(z)\,d\omega$, and thus we can define
> \[\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega.\]
> We term this the spatial average of the function $g$ with respect to the probability measure associated to $\rho$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityAverageOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.205（印刷 p.184）的空间平均定义，对应 Ch05.lean:212–213 的 densityAverageOn D ρ g := (∫D gρ)/(∫Dρ)，其中 E n 展开为欧氏 ℝⁿ。原文第一种写法 (∫Dρ)⁻¹⟨g,ρ⟩ 在本段将 ⟨g,ρ⟩定义为乘积积分，故与该比值相同；令 ρ̂(z)=ρ(z)/(∫Dρ)，Bochner 积分对常数因子的标准性质给出同一表达式 ∫D gρ̂，完整保留展示公式的两种表达，不需要要求 g、ρ 都属于 L²。原文的概率解释适用于非负可积密度、正的有限质量以及可积乘积；原 JSON 的 context_notation 已明确这个解释范围。该 Lean 声明是比值的总化定义，并没有声称所有任意输入都生成概率测度；对零质量、负密度或不可积输入也给一个总化值不会构成对原文适用域内公式的反例，故撤回上一轮将这些输入作为 FAIL 反例的判断。Bochner 积分不可积时取0以及实数除法的总化均按标准库含义采信，未把这些扩展值解释为概率期望。项目依赖中 density（Measurable、非负、Integrable）、probabilityDensity（另要求质量1）、densityMeasure（volume.withDensity (ENNReal.ofReal∘ρ)）的定义可核对上述概率解释，但它们并不是本声明隐藏调用的前提。定义无需把所有适用域条件作为类型参数，也不额外冒称已经证明概率测度构造定理。定义无 sorry、无 [EXTRA] 或 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityAverageOn`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L262)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-ClosedSupport · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\operatorname{supp}f$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def closedSupport {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) : Set (MolecularDynamics.Chapter05Review.E n) := tsupport f
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.closedSupport` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采信 Mathlib 标准含义。已在 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开项目别名 E n := EuclideanSpace ℝ (Fin n)，对象为欧氏 ℝⁿ 上的实函数。附件 Blueprint/Ch05.lean 中 MD.Ch05.closedSupport f := tsupport f，展开标准含义就是 closure (Function.support f)=closure {z | f z ≠ 0}，与 PDF204/印刷183 正文支集定义完全一致。任意 n、任意 f，不添加连续性或紧性假设，不将支集误作未闭合的非零点集；完整返回该集合。本条没有 [EXTRA] 或 [ERRATUM?]。该声明是定义，无 sorry；PASS 仅评价定义语义，不声称完成 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch05.closedSupport`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L266)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-GaussianL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $L^2(\mathbb R^m)$ also includes many other types of functions important in molecular modelling, for example the multivariate Gaussian $\exp(-\sum_{i=1}^m\alpha_i x_i^2)$, where $\alpha_i>0,i=1,2,\ldots,m$ are coefficients; such a function goes rapidly to zero as any $x_i\to\infty$, so the improper integral converges.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume := by
  intro n a ha
  have hc : Continuous (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) := by fun_prop
  rw [memLp_two_iff_integrable_sq hc.aestronglyMeasurable]
  have hi := GaussianFourier.integrable_cexp_neg_sum_mul_add (ι := Fin n) (b := fun i => ((2*a i : ℝ) : ℂ))
    (by intro i; simpa using (mul_pos (by norm_num : (0 : ℝ)<2) (ha i))) (fun _ => (0 : ℂ))
  have hr : Integrable (fun v : Fin n → ℝ => Real.exp (-(∑ i,(2*a i)*(v i)^2))) volume := by
    have hreal := hi.re
    change Integrable (fun v : Fin n → ℝ => (Complex.exp (-(∑ i,((2*a i : ℝ) : ℂ)*(v i : ℂ)^2)+(∑ i,(0 : ℂ)*(v i : ℂ)))).re) volume at hreal
    simpa only [zero_mul,Finset.sum_const_zero,add_zero,← Complex.ofReal_pow,← Complex.ofReal_mul,
      ← Complex.ofReal_sum,← Complex.ofReal_neg,Complex.exp_ofReal_re] using hreal
  have he : Integrable (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,(2*a i)*(z i)^2))) volume := by
    rw [← (PiLp.volume_preserving_toLp (Fin n)).integrable_comp_emb (MeasurableEquiv.toLp 2 _).measurableEmbedding]
    exact hr
  convert he using 1
  funext z
  rw [← Real.exp_nat_mul]
  congr 1
  simp only [mul_assoc,← Finset.mul_sum]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianL2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则采信标准 MemLp、EuclideanSpace 和 volume。已在 Ch05_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)，所以体积为完整 ℝⁿ 上标准 Lebesgue 测度。签名先量化任意有限维 n、所有系数 a : Fin n → ℝ，再要求每个 a i > 0；结论 MemLp (exp(-∑ i,a i*(z i)^2)) 2 volume 恰为该实 Gaussian 可测且平方可积。与 PDF204/印刷183 脚注2所称任意正系数多元 Gaussian 属于 L²(ℝᵐ) 一致，未改为等系数径向函数、截断域或预先假设可积。原文“goes rapidly to zero”是可积性的解释，未单列为具有指定速率的极限定理；可测性由连续性自然满足，平方后仍为系数 2a i > 0 的 Gaussian，其平方积分为有限乘积 ∏ᵢ sqrt(π/(2a i))。允许 n=0 是无害扩展，空乘积为1。本条无 [EXTRA]/[ERRATUM?]。附件本条有证明正文且未含 sorry；语义 PASS 与编译及证明核验分开。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianL2`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L269)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-FiniteJumpL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $L^2(\mathbb R^m)$ also includes the compactly supported functions with finite “jump discontinuities” at a finite number of locations.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem finiteJumpL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ) (S : Set (MolecularDynamics.Chapter05Review.E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume := by
  intro n g S hS hs hc hb
  have hm : Measurable g := hc.measurable_of_countable_compl (by simpa only [compl_compl] using hS.countable)
  have hl : ∀ z,∃ C > 0,∀ᶠ x in 𝓝 z,|g x| ≤ C := by
    intro z
    by_cases hz : z ∈ S
    · obtain ⟨C,hC,U,hU,hbU⟩ := hb z hz
      exact ⟨C,hC,Filter.mem_of_superset hU hbU⟩
    · have hcont := hc.continuousAt (hS.isClosed.isOpen_compl.mem_nhds hz)
      refine ⟨|g z|+1,by positivity,?_⟩
      exact (hcont.abs.eventually_lt_const (lt_add_one _)).mono (fun _ h => h.le)
  have hbound : ∃ C > 0,∀ x ∈ tsupport g,|g x| ≤ C := by
    apply hs.induction_on (p := fun A => ∃ C > 0,∀ x ∈ A,|g x| ≤ C)
    · exact ⟨1,by norm_num,by simp⟩
    · intro A B hAB hB
      obtain ⟨C,hC,hCB⟩ := hB
      exact ⟨C,hC,fun x hx => hCB x (hAB hx)⟩
    · intro A B hA hB
      obtain ⟨C,hC,hCA⟩ := hA
      obtain ⟨D,hD,hDB⟩ := hB
      refine ⟨max C D,lt_of_lt_of_le hC (le_max_left _ _),?_⟩
      intro x hx
      rcases hx with hx|hx
      · exact (hCA x hx).trans (le_max_left _ _)
      · exact (hDB x hx).trans (le_max_right _ _)
    · intro z hz
      obtain ⟨C,hC,hCL⟩ := hl z
      exact ⟨{x | |g x| ≤ C},mem_nhdsWithin_of_mem_nhds hCL,C,hC,fun _ hx => hx⟩
  obtain ⟨C,hC,hBC⟩ := hbound
  apply hs.memLp_of_bound hm.aestronglyMeasurable C
  filter_upwards [] with x
  by_cases hx : x ∈ tsupport g
  · simpa only [Real.norm_eq_abs] using hBC x hx
  · rw [image_eq_zero_of_notMem_tsupport hx,norm_zero]
    exact hC.le
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.finiteJumpL2` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。 | [EXTRA] |

[EXTRA] [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已从 Ch05_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)；Mathlib 的 HasCompactSupport 表示 closure {x | g x ≠ 0} 紧，MemLp g 2 volume 表示对标准 Lebesgue 测度平方可积。签名依次量化 n、实函数 g、异常集 S，假设 S 有限、g 紧支、g 在 S 的补集连续，并在每个 z∈S 量化各自的 C>0 和邻域 U，使 U 中所有 |g x|≤C；结论只有完整 L² 归属，与 PDF204/印刷183 脚注2的结论一致。[EXTRA] 合理且不循环：有限跳跃具有有限邻域界，该条件还允许较一般的有界振荡，并不把有限跳跃当作精确定义的等价命题。它是对原文有限跳跃函数的充分资格，不排除原文中只有有限个跳跃位置的实函数。有限异常集外连续保证可测；各点局部有界和支集紧性给出统一有限界，紧集的 Lebesgue 测度有限，故平方可积。若仅要求紧支和有限异常点而省掉邻域控制，g(x)=1/x（0<x<1）、其余处为0将不平方可积；它不满足有限跳跃条件，也不是本签名反例。无 [ERRATUM?]，不修正原书。本条证明正文无 sorry；PASS 是签名语义判定，未运行编译。

### 7. 状态与证明位置

self-contained；`MD.Ch05.finiteJumpL2`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L293)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-NormalizedAverageFormula · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalizedAverageFormula : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x))) := by
  intro n D ρ g
  simp only [densityAverageOn,← mul_div_assoc,integral_div]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalizedAverageFormula` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已从 Ch05_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)。本条实际引用的项目定义是附件 Blueprint/Ch05.lean 中本地 MD.Ch05.densityAverageOn D ρ g := (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)，已读取并展开；它不是依赖摘录中定义在全空间的 MolecularDynamics.Chapter05Review.densityAverage。令 c=∫ x in D,ρ x，右端为 ∫ z in D,g z*(ρ z/c)，以受限 Lebesgue 测度积分。先量化 n、任意 D、ρ、g 后给出等式，保留 PDF205/印刷184 的平均积分比值和归一化密度 ρ̂=ρ/c 两种表示。按标准 Bochner 积分及实数除法的总化含义，常数因子可移出积分：c≠0 时可积性在乘以 c⁻¹ 后等价，不可积时两积分都按标准约定取0；c=0 时 ρ/c 恒0，等式两端皆0。因此无需额外密度、可积性或非零分母假设即可成立为代数恒等式。在教材的密度、正质量及有限配对条件下它就是原公式；JSON context 已明确该公式不宣称任意输入都有概率平均意义。无 [EXTRA]/[ERRATUM?]。证明正文无 sorry；PASS 评价语义，不等于 Lean 编译证明检查。

### 7. 状态与证明位置

self-contained；`MD.Ch05.normalizedAverageFormula`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L333)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MassFraction · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Let $\rho(z,t)$ be the probability density associated to a collection of phase points moving under a vector field $f$ on the phase space $\mathbb R^m$. Let $\mathcal A$ be a suitable region of volume $V$ within the phase space (say a rectangular $m$-dimensional box). The fraction $\nu$ of phase points present in $\mathcal A$ at time $t$ is the integral of $\rho$ over $\mathcal A$:
> \[\nu(t)=\int_\mathcal A\rho(z,t)\,d\omega,\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def massFraction {n : ℕ} (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) := ∫ z in A,ρ t z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.massFraction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；massFraction对任意时间密度族ρ:ℝ→E n→ℝ、固定区域A及时间t定义∫_A ρ t。时间参数顺序与原ρ(z,t)仅是柯里化差异，积分域及Lebesgue体积正确。定义允许一般函数，不自行证明结果位于[0,1]；作为质量积分定义不需要把概率条件塞入定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.massFraction`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L339)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MassDerivative · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> which may be viewed as a smooth function of time. On the one hand
> \[\frac{d\nu}{dt}=\int_\mathcal A\frac{\partial\rho(z,t)}{\partial t}\,d\omega,\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem massDerivative :
  ∀ n (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) t,
  MeasurableSet A → (∀ s,IntegrableOn (ρ s) A) →
  (∃ δ > 0, ∃ b : MolecularDynamics.Chapter05Review.E n → ℝ, IntegrableOn b A ∧
    (∀ s ∈ Ioo (t-δ) (t+δ), ∀ z ∈ A, HasDerivAt (fun u => ρ u z) (deriv (fun u => ρ u z) s) s ∧
      |deriv (fun u => ρ u z) s| ≤ b z)) →
  HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A) (∫ z in A,deriv (fun u => ρ u z) t) t := by
  intro n ρ A t hA hint hloc
  obtain ⟨δ,hδ,b,hb,hlocal⟩ := hloc
  have ht : t ∈ Ioo (t-δ) (t+δ) := ⟨by linarith,by linarith⟩
  have hm : AEStronglyMeasurable (fun z => deriv (fun u => ρ u z) t) (volume.restrict A) := by
    apply aestronglyMeasurable_of_tendsto_ae (𝓝[≠] (0 : ℝ))
      (f := fun h z => h⁻¹*(ρ (t+h) z-ρ t z))
    · intro h
      exact ((hint (t+h)).aestronglyMeasurable.sub (hint t).aestronglyMeasurable).const_mul _
    · filter_upwards [ae_restrict_mem hA] with z hz
      simpa only [smul_eq_mul] using (hlocal t ht z hz).1.tendsto_slope_zero
  have he := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume.restrict A) (F := ρ) (F' := fun s z => deriv (fun u => ρ u z) s)
    (bound := b) (Ioo_mem_nhds (by linarith) (by linarith))
    (Filter.Eventually.of_forall (fun s => (hint s).aestronglyMeasurable)) (hint t) hm
    ((ae_restrict_mem hA).mono (fun z hz s hs => by
      simpa only [Real.norm_eq_abs] using (hlocal s hs z hz).2)) hb
    ((ae_restrict_mem hA).mono (fun z hz s hs => (hlocal s hs z hz).1))
  simpa only [MolecularDynamics.Chapter05Review.massFraction] using! he.2

theorem massDerivative_smooth (n : ℕ)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ)
    (A : Set (MolecularDynamics.Chapter05Review.E n))
    (_hA : MeasurableSet A) (_hc : IsCompact A)
    (_hρ : ContDiff ℝ ∞ (Function.uncurry ρ)) :
    ContDiff ℝ ∞ (MolecularDynamics.Chapter05Review.massFraction ρ A) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.massDerivative`；`MD.Ch05.massDerivative_smooth` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。 | [EXTRA] |

[EXTRA] [EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。；[EXTRA] 保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；massDerivative在任意n、固定可测A与时间t下，显式要求每一时刻ρ可积，存在δ>0和A上可积支配b，邻域每个s及A上每个z具有真实时间导数并满足绝对值界，结论是质量函数在t的HasDerivAt及积分内偏导。没有把交换公式作为前提。smooth另在紧A与全局联合C∞密度下断言质量函数C∞，确为原smooth措辞的充分资格；两声明量词、局部区间及[EXTRA]一致。

### 7. 状态与证明位置

incomplete；`MD.Ch05.massDerivative`：已证；`MD.Ch05.massDerivative_smooth`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L344)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-OutwardNormal · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> where $n(z)$ is the unit outward normal to the surface $\partial \mathcal A$ at the point $z$ and $d\sigma$ is the surface element.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def outwardNormalFor {n : ℕ} (A : Set (MolecularDynamics.Chapter05Review.E n)) (ν : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set (MolecularDynamics.Chapter05Review.E n),∃ r : MolecularDynamics.Chapter05Review.E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ MolecularDynamics.Chapter05Review.grad r z ≠ 0 ∧
    ν z=‖MolecularDynamics.Chapter05Review.grad r z‖⁻¹ • MolecularDynamics.Chapter05Review.grad r z



/-- 修正版，对应原文 MD-5.2.2-OutwardNormal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def outwardNormalFor_corrected {n : ℕ} (A : Set (MolecularDynamics.Chapter05Review.E n)) (ν : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set (MolecularDynamics.Chapter05Review.E n),∃ r : MolecularDynamics.Chapter05Review.E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ MolecularDynamics.Chapter05Review.grad r z ≠ 0 ∧
    ν z=‖MolecularDynamics.Chapter05Review.grad r z‖⁻¹ • MolecularDynamics.Chapter05Review.grad r z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.outwardNormalFor`；`MD.Ch05.outwardNormalFor_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；outwardNormalFor在每个z∈frontier A要求开邻域O、C²局部定义函数r、A在O内恰为r<0、非零真实梯度及ν z=∇r/‖∇r‖。边界点连续性迫使r(z)=0，正梯度方向指向A外，范数为1；资格确实限定光滑开放域。矩形角点不满足此全点条件，但[EXTRA]明确分面版本另列，未将角点假称光滑。dσ的具体测度在条目12定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.outwardNormalFor`：定义；`MD.Ch05.outwardNormalFor_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L381)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-GeneralFluxBalance · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> this same rate of change may be written as the negative of the particle flux over the boundary of $\mathcal A$:
> \[\frac{d\nu}{dt}=-\int_{\partial \mathcal A}f\cdot n\,\rho(z,t)\,d\sigma,\]
> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:
> \[\frac{d\nu}{dt}=-\int_\mathcal A\nabla\cdot(f(z)\rho(z,t))\,d\omega.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem generalFluxBalance : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ν f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
  (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)))) t ∧
    (∫ z in A,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)) := by
  sorry



/-- 修正版，对应原文 MD-5.2.2-GeneralFluxBalance。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem generalFluxBalance_corrected : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ν f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
  (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)))) t ∧
    (∫ z in A,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.generalFluxBalance`；`MD.Ch05.generalFluxBalance_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；两个结论本身在所列资格下合理：任意正维n、开放D与有界光滑开放A、closure A⊆D、真实外法线；f为D上C¹，Φ为全局C²实际自治流且保持D，ρ在ℝ×D上C¹，各时刻为D上的概率密度，受限密度测度按Measure.map输运。结论先给质量时间导数等于负边界通量，再给体散度积分等于边界通量，两者推出原第二式。hausdorffArea使用单位球体积/2^d归一化直径型Hausdorff测度，方向和负号正确。[EXTRA]中“不要求ρ在D外光滑或归一化”按“在D外”共同限定两项来读，与签名一致；为避免误读，corrected_json进一步明确D内确有概率归一化要求。这是注释澄清，不构成定理签名错误。

### 7. 状态与证明位置

incomplete；`MD.Ch05.generalFluxBalance`：未证（原书疑误不证）；`MD.Ch05.generalFluxBalance_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L399)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-Divergence · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> $\mathcal M_fw=-\nabla\cdot(wf)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.divergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | [EXTRA] |

[EXTRA] [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M_f w=−div(wf)由MD-5.2.2-Liouvillian承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主定义对任意n、f:E n→E n和z取真实Fréchet导数的线性迹，正是可微向量场的散度。当前statement_scope明确只是散度辅助定义，完整M_fw=−div(wf)由本任务条目14实际提供，跨条映射可就所给文本核实，未将任意矩阵命名为Jacobian。不可微点的fderiv总化值不应被解释为经典散度存在。

### 7. 状态与证明位置

self-contained；`MD.Ch05.divergence`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L433)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-Liouvillian · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> The operator $\mathcal M_f$, defined for a scalar valued function $w$ by $\mathcal M_fw=-\nabla\cdot(wf)$, is called the Liouvillian operator.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvillian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、向量场f、实值函数u与点z，liouvillian定义为−divergence(x↦u(x)•f(x))(z)。与原w的字母差异无语义影响，负号、乘积、空间导数及标量值域均正确。对经典含义需乘积向量场可微；当前定义为标准fderiv的总化扩展，没有断言任意函数经典可微。

### 7. 状态与证明位置

self-contained；`MD.Ch05.liouvillian`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L437)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleEquation · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> Therefore, since this should hold for an arbitrary domain $\mathcal A$, we must have
> \[\frac{\partial\rho}{\partial t}=-\nabla\cdot(\rho f).\]
> This is called the Liouville equation or continuity equation. It tells us how the distribution of phase points varies in time and space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvilleEquation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleEquation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。 | [EXTRA] |

[EXTRA] [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n和开放流不变D，f在D上C¹、Φ为联合C²的实际自治流，ρ在ℝ×D上C¹且各时刻为D上的概率密度，受限密度测度由Φ_t推前。结论对任意实t及所有z∈D给出HasDerivAt(ρ·z)(−div(ρ_t f)(z)) t，完整对应连续性方程。输运测度等式是真实分布输运条件而非预设PDE；开放域和连续密度使AE等式可提升为点态等式。不要求D外ρ光滑，无未披露的循环前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvilleEquation`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L442)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleProduct · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> An alternative form for the continuity equation is:
> \[\frac{\partial\rho}{\partial t}=-\sum_i\left[\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right],\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvilleProduct :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z = -ρ z*MolecularDynamics.Chapter05Review.divergence f z-MolecularDynamics.Chapter05Review.lie f ρ z := by
  intro n f ρ z hf hρ
  have hd := hρ.hasFDerivAt.smul hf.hasFDerivAt
  change HasFDerivAt (fun x => ρ x • f x)
    (ρ z • fderiv ℝ f z+(fderiv ℝ ρ z).smulRight (f z)) z at hd
  unfold MolecularDynamics.Chapter05Review.liouvillian MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.lie
  rw [hd.fderiv]
  change -(LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
    (ρ z • (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z).toLinearMap.smulRight (f z))) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-
      (fderiv ℝ ρ z) (f z)
  simp only [map_add,map_smul,LinearMap.trace_smulRight,smul_eq_mul]
  change -(ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z) (f z)) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-(fderiv ℝ ρ z) (f z)
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleProduct` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。 | [EXTRA] |

[EXTRA] [EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。；[EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS_HUMAN；liouvilleProduct本身正确：对任意n,f、实值ρ及z，在f、ρ于z可微的条件下，−div(ρf)=−ρ div f−L_fρ。此为静态乘积法则，且statement_scope及[EXTRA]明确如此；它没有时间变量、HasDerivAt或任何输运前提，因此不能单独代表所引完整时间PDE。文本宣称完整坐标时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担，但该source_id及声明不在本任务提供材料中，且用户禁止用旧工程补查，故跨条完整性待人工核实；不把正确辅助引理判为错误定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.liouvilleProduct`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L453)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LieCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

本条等式为从原页内积公式提炼的坐标辅助表达，并非原页独立展示式；完整原文时间PDE见MD-5.2.2-LiouvilleProductCoordinates。

> $\mathcal L_fv=\sum_i f_i\frac{\partial v}{\partial z_i}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lieCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  MolecularDynamics.Chapter05Review.lie f g z=∑ i,f z i*(fderiv ℝ g z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f g z
  unfold MolecularDynamics.Chapter05Review.lie
  have h := congrArg (fderiv ℝ g z) ((EuclideanSpace.basisFun (Fin n) ℝ).toBasis.sum_repr (f z)).symm
  simpa only [map_sum,map_smul,smul_eq_mul,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis] using h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 从原页内积公式提炼的坐标辅助表达，非原页逐字独立展示式；完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates另列。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lieCoordinates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 返回A已指出该坐标等式是提炼的辅助表达，不将它标为原页独立逐字展示式。 | [EXTRA] |

[EXTRA] [EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。；[EXTRA] 返回A已指出该坐标等式是提炼的辅助表达，不将它标为原页独立逐字展示式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、f:E n→E n、g:E n→ℝ及z，将线性映射fderiv g z在f(z)上的值展开为所有i:Fin n的f_i(z)乘其在真实正交规范基e_i上的值。有限求和、系数、基向量与实值域正确；对可微g后一项即∂ᵢg。没有显式可微前提时，仍是总化Fréchet导数的线性恒等式，不是声称任意g存在经典偏导；[EXTRA]所说无需另造形式梯度成立。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lieCoordinates`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L474)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-DivergenceCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> $\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem divergenceCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) z,
  DifferentiableAt ℝ f z → MolecularDynamics.Chapter05Review.divergence f z=
    ∑ i,(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f z hf
  unfold MolecularDynamics.Chapter05Review.divergence
  rw [LinearMap.trace_eq_matrix_trace ℝ (EuclideanSpace.basisFun (Fin n) ℝ).toBasis]
  simp only [Matrix.trace,Matrix.diag,LinearMap.toMatrix_apply,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis]
  apply Finset.sum_congr rfl
  intro i hi
  have hc := (PiLp.proj 2 (fun _ : Fin n => ℝ) i).hasFDerivAt.comp z hf.hasFDerivAt
  change HasFDerivAt (fun x => f x i) _ z at hc
  rw [hc.fderiv]
  rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.divergenceCoordinates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。 | [EXTRA] |

[EXTRA] [EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。；[EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS_HUMAN；divergenceCoordinates正确断言任意n、f,z在f于z可微时，真实散度等于Σ_i D(f_i)(z)e_i，是完整对角偏导和。它不含ρ或时间导数，statement_scope已明确为辅助引理；所引原文却是完整连续性方程的乘积展开。其跨条承载者MD-5.2.2-LiouvilleProductCoordinates不在本任务材料，不能据名称确认该完整结论已保存；需要人工提供该声明核对。

### 7. 状态与证明位置

self-contained；`MD.Ch05.divergenceCoordinates`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L484)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleProductCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> An alternative form for the continuity equation is:
> \[\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvilleProductCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z=-(∑ i : Fin n,(ρ z*(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+
    f z i*(fderiv ℝ ρ z) (EuclideanSpace.basisFun (Fin n) ℝ i))) := by
  intro n f ρ z hf hρ
  rw [liouvilleProduct n f ρ z hf hρ,divergenceCoordinates n f z hf,lieCoordinates n f ρ z]
  rw [Finset.sum_add_distrib,← Finset.mul_sum]
  ring

theorem liouvilleProductCoordinates_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (-(∑ i : Fin n,(ρ t z*(fderiv ℝ (fun x ↦ f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+f z i*(fderiv ℝ (ρ t) z) (EuclideanSpace.basisFun (Fin n) ℝ i)))) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleProductCoordinates`；`MD.Ch05.liouvilleProductCoordinates_evolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。 | [EXTRA] |

[EXTRA] [EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。；[EXTRA] 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；同时核对两个声明。E n为实n维欧氏空间；第一式对任意n、f、ρ及z在点可微条件下展开-div(ρf)，两个坐标项和总负号正确。evolution对开且全时流不变的D、C¹场、实际全时间自治流及其C²联合正则性、D上的联合C¹密度逐点给出所有t及z∈D的时间导数。probabilityDensityOn要求非负、可积及积分1；densityMeasureOn是限制体积上的真实密度测度。推前等式是输运条件，并非把所求PDE作为假设；开域与连续性使测度层面的相等能确定点态密度。两个声明合起来保留完整时间导数和有限坐标和。[EXTRA]的强化足够且未循环；第一条EXTRA关于其他条目的旧说明不影响本条已有evolution覆盖。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvilleProductCoordinates`：已证；`MD.Ch05.liouvilleProductCoordinates_evolution`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L501)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-RectangularDomain · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Let $A$ be a suitable region of volume $V$ within the phase space (say a rectangular $m$-dimensional box).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rectangularDomain {n : ℕ} (a b : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.rectangle a b
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.rectangularDomain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。 | [EXTRA] |

[EXTRA] [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义；只从版本绑定的 Ch05_deps.txt 展开项目自定义定义，不以 Mathlib 定义体未收录为材料不足。项目 ReviewDefinitions.lean 的 E n 展开为 EuclideanSpace ℝ (Fin n)，即欧氏 ℝⁿ，volume 是标准 Lebesgue 测度。项目 Statements.lean 的 rectangle a b={z | ∀i,a i≤z i ∧ z i≤b i}；boxFace a b i side={z | z∈rectangle a b ∧ z i=side}。展开 MD.Ch05.rectangularDomain 就是上述 rectangle。教材 PDF 页205在一般合适区域后明确给出矩形m维盒这一例子，本条将该例子的维数及坐标端点具体化，定义未冒称覆盖任意形状区域。体积V是区域体积的描述记号，不是额外数值结论。[EXTRA]矩形特化合理；本定义可用于空或退化盒是集合定义的自然延伸，后续通量定理另有a_i<b_i。没有漏掉本条的定理结论，也没有[ERRATUM?]。定义不含sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.rectangularDomain`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L520)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-FaceFlux · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $\frac{d\nu}{dt}=-\int_{\partial A}f\cdot n\,\rho(z;t)\,d\sigma$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.faceFlux` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 | [EXTRA] |

[EXTRA] [EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；按本条明确的statement_scope审校：faceFlux是任意n、f、ρ、a、b、i及side上的单面无定向坐标通量辅助定义，而非原文整条质量守恒定理。boxFace取闭矩形中第i坐标等于side的面；hausdorffArea(n-1)采用单位球体积除2^(n-1)的Hausdorff面积归一化，积分ρ f_i正确。side并未被限制到上下端点；作为辅助定义可总定义，实际上下端点在条目3中代入。条目3的下端减上端给出质量导数，与外法向符号一致。接受显式拆分后的矩形范围；没有据此确认本任务未提供的GeneralFluxBalance，也不将本定义认证为一般域通量定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.faceFlux`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L525)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-BoxFluxBalance · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:
> \[\frac{d\nu}{dt}=-\int_A\nabla\cdot(f(z)\rho(z;t))\,d\omega.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem fluxBalance :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,MolecularDynamics.Chapter05Review.probabilityDensity (ρ t)) →
  (∀ t,MolecularDynamics.Chapter05Review.densityMeasure (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.fluxBalance` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。 | [EXTRA] |

[EXTRA] [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对所有n>0、严格非退化矩形a_i<b_i、C¹场、满足群律和ODE的实际流、联合C²流与联合C¹密度、每时概率密度及Measure.map输运。结论同时含所有t的真实质量函数导数和散度积分等于上面减下面通量。两式合起来正好是dν/dt=-∫_A div(ρf)，无符号错误、无PDE前提。紧矩形及连续导数足够支撑积分求导和散度定理。原书允许矩形例子，[EXTRA]公开了矩形特化，故按此特化PASS；未审核未附的一般域条目。

### 7. 状态与证明位置

incomplete；`MD.Ch05.fluxBalance`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L530)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-BoundaryTerm · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> where the term $B=\sum_i\int_{\partial A_\ell}uf_iv\nu_i\,d\sigma$, is a surface integral over the boundary of $A_\ell$, where $\nu_i$ is the $i$’th component of the unit outward normal to the surface $\partial A_\ell$ bounding the region $A_\ell$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.boxBoundaryTerm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对f、u、v、ell及维数参数；a=(-ell,…), b=(ell,…)。每坐标上面减下面的通量作用于ρ=uv，正是∑∫uf_i v ν_i；u v f_i与原文u f_i v相同。n≥1、ell>0的原文盒子语境下，棱角是面积零集合，不妨碍面分解；n=1时0维面积是计数测度。函数作为总定义允许其他ell及任意数据，没有额外断言这些情形存在原文的光滑外法向。[EXTRA]为空不影响其作为积分表达式的定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.boxBoundaryTerm`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L543)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-TruncatedIntegrationByParts · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> We truncate the domain to a large box $A_\ell$ with edge of length $2\ell$ centered at the origin, approximating the inner product by:
> \[\langle u,\mathcal L_fv\rangle\approx\int_{A_\ell}u\mathcal L_fv\,d\omega=\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega.\]
> Splitting this sum up, we treat each term by integration by parts
> \[\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega=\sum_i\int_{A_\ell}uf_i\frac{\partial v}{\partial z_i}\,d\omega\tag{5.4}\]
> \[=B-\sum_i\int_{A_\ell}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega.\tag{5.5}\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem truncatedIntegrationByParts : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := MolecularDynamics.Chapter05Review.rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*MolecularDynamics.Chapter05Review.lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.truncatedIntegrationByParts` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。 | [EXTRA] |

[EXTRA] [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对所有n>0、ell>0、全空间C¹场和标量u,v，以及实际盒A。lie f v=Dv[f]，liouvillian f u=-div(uf)，故右侧B+∫liouvillian(f,u)v正好是B-∫v div(uf)。有限维坐标展开和积分的有限和分配在紧盒与C¹条件下等价于(5.4)，结论编码(5.5)。原文≈没有被编码成精确全空间等号；本条局部积分恒等式不需要无穷远衰减，[EXTRA]的局部C¹及正边长条件合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.truncatedIntegrationByParts`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L551)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-RapidAdjoint · unnumbered_claim · 印刷p.185–186 / PDFp.206–207

### 2. 原文陈述

> Let $u,v$ be two scalar valued functions in $\mathbb R^m$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $u$ and $v$ are rapidly decaying we know that $B\to0$, as $\ell\to\infty$. Taking the limit, we are thus left with the equation
> \[\langle u,\mathcal L_fv\rangle=-\sum_i\int_{\mathbb R^m}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega=\langle M_fu,v\rangle.\]
> We refer to $M_f$ as the adjoint operator of $\mathcal L_f$ and we write $M_f=\mathcal L_f^\dagger$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rapidAdjoint : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry



/-- 修正版，对应原文 MD-5.2.2-RapidAdjoint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem rapidAdjoint_corrected : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.rapidAdjoint`；`MD.Ch05.rapidAdjoint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；声明本身是正确的条件化版本：n>0，f为C¹，u,v为SchwartzMap，两个实际混合乘积分别可积，且真实盒边界项B趋0，才推出全空间积分配对相等。由紧盒分部积分和两个可积函数的盒截断极限可得该结论；没有将最终配对相等作为假设。但原页声称仅由u,v迅速衰减便知B→0，未明确f的增长控制；[EXTRA]把B→0改为前提是实质补充，不能据此宣布原书推论已成立。按任务规定保留原句并将原书条件疑点交人工；形式伴随记号也不等于闭Hilbert算子伴随的定义域识别。

### 7. 状态与证明位置

incomplete；`MD.Ch05.rapidAdjoint`：未证（原书疑误不证）；`MD.Ch05.rapidAdjoint_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L561)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-CompactAdjoint · unnumbered_claim · 印刷p.185–186 / PDFp.206–207

### 2. 原文陈述

> $\langle u,\mathcal L_fv\rangle=\langle M_fu,v\rangle$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvillianAdjoint :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvillianAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。 | [EXTRA] |

[EXTRA] [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对任意n、C¹向量场及C¹实函数u,v，二者均有紧支持；结论为真实Lebesgue积分的配对相等。相关乘积及导数连续且有紧支持，故可积、边界项在充分大盒上消失。n=0时导数场为零，仍成立。此为已明确另列的紧支持版本，不宣称所有C¹紧支持函数属于SchwartzMap，也不把形式配对等同于闭算子伴随。与原页所摘等式及[EXTRA]范围一致。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvillianAdjoint`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L586)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MeasurePropagator · definition · 印刷p.186 / PDFp.207

### 2. 原文陈述

> The density $\rho$ evolves as the solution of the partial differential equation $\partial\rho/\partial t=\mathcal L_f^\dagger\rho$, where we interpret $\rho$ as a function of both $z$ and $t$ and view $\mathcal L_f^\dagger$ as only operating on the spatial components. This means, formally, $\rho(\boldsymbol z,t)=e^{t\mathcal L_f^\dagger}\rho(\boldsymbol z,0)$. We can think of $\exp(t\mathcal L_f^\dagger)$ as defining the propagator of measure.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ

def measurePropagator_general {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ

theorem measurePropagator_density_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.measurePropagator`；`MD.Ch05.measurePropagator_general`；`MD.Ch05.measurePropagator_density_evolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。 | [EXTRA] |

[EXTRA] [EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐一核对主定义、general辅助定义和density_evolution。主接口包含真实自治流资格并作正时间Φ_t推前；general仅为任意可测空间上Measure.map的总定义，不额外宣称任意Φ都是物理流。evolution对任意开且流不变D、C¹场、联合C²实际流、联合C¹且各时为概率密度的ρ，假设各时密度测度是初始密度的推前，推出每个t及z∈D处∂tρ=liouvillian f (ρ t)。ρ初值为ρ 0而非任意强加解；时间符号正确。形式指数只是演化算子记号，未声称已经构造一般无界算子的指数；[EXTRA]与实际编码相符。

### 7. 状态与证明位置

incomplete；`MD.Ch05.measurePropagator`：定义；`MD.Ch05.measurePropagator_general`：定义；`MD.Ch05.measurePropagator_density_evolution`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L594)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianDivergence · unnumbered_claim · 印刷p.186 / PDFp.207

### 2. 原文陈述

> The term $\nabla\cdot f$ vanishes for $f=J\nabla H$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。 | [EXTRA] |

[EXTRA] [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS：依赖 SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ，按 q,p 排列，textbookJ=[[0,I],[-I,0]]；SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e_i))_i；SymplecticMaps.lean 的 textbookJacobian=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，其 trace 正是坐标散度。因此任意 Nc,H,z 下的结论是 div(J∇H)(z)=0。[EXTRA]局部 C² 保证真实二阶导数对称，是合理的光滑性资格，不假设结论。原书无本条 [ERRATUM?]。本声明调用依赖 HamiltonianVolume.lean 中已给出 Hessian 对称性与 trace(JS)=−trace(JS) 的证明，声明本体无 sorry；此为静态语义审阅，未运行 Lean 编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.hamiltonianDivergence`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L613)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianSkewExpression · unnumbered_claim · 印刷p.186 / PDFp.207

### 2. 原文陈述

> From the above we know that for a smooth scalar function $u=u(z)$, $\mathcal L_f^\daggeru=-\nabla\cdot(uf)=-f\cdot\nabla u-u\nabla\cdot f$. The term $\nabla\cdot f$ vanishes for $f=J\nabla H$. Thus we have $\mathcal L_f^\daggeru=-f\cdot\nabla u=-\mathcal L_fu$. If this holds for all smooth $u$, we write $\mathcal L_f^\dagger=-\mathcal L_f$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianSkewExpression :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  ∀ z,MolecularDynamics.Chapter05Review.liouvillian f u z= -MolecularDynamics.Chapter05Review.lie f u z := by
  intro n f u hf hu hdiv z
  rw [liouvilleProduct n f u z (hf z) (hu z),hdiv z]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianSkewExpression` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。 | [EXTRA] |
| 尚未覆盖的结论 | C² Hamiltonian的真实Hamilton场散度零桥接与本条实例化；正式库HamiltonianVolume的维数/坐标转换尚未在本条展开核对 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。；[EXTRA] 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。

### 6. 审计结论

本轮修复：零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；所列定理作为一般零散度场的条件命题正确：∀n,f,u，f和u可微，假设∀z div f z=0，再得∀z -div(uf)=-Du[f]。但本条statement_scope覆盖整个原段，其中还包含f=J∇H时散度为零这一实质结论。当前所有声明既无H、J或Phase，也无从HamiltonianField推出div f=0的桥接。将散度零直接列为前提不能覆盖该结论。[EXTRA]称正式库另有桥接，却未给出其声明及所需正则性，不能按本任务的唯一输入核实。因此就完整原句覆盖判FAIL，并非认为已列的条件恒等式为假。

### 7. 状态与证明位置

self-contained；`MD.Ch05.hamiltonianSkewExpression`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L622)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianDensityPropagation · unnumbered_claim · 印刷p.187 / PDFp.208

### 2. 原文陈述

> An important consequence of the skew symmetry of $\mathcal L_f$ for a divergence-free system is that the propagator $e^{t\mathcal L_f^\dagger}$ preserves the integral over the whole phase space, i.e.
> \[\int_D e^{t\mathcal L_f^\dagger}\rho(z)d\omega=\int_D e^{-t\mathcal L_f}\rho(z)d\omega=\int_D\rho(\mathcal F_{-t}(z))d\omega=\int_D\rho(z)d\omega,\]
> since we can view $\mathcal F_{-t}(z)$ as a change of variables by a volume-preserving map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianDensityPropagation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D ρ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianDensityPropagation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。 | [EXTRA] |

[EXTRA] [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对∀n、D、f、Φ、ρ；D仅需Lebesgue零可测而不强制开，C¹场具有联合C²全时间实际流，全空间div f=0，D对每个时间流不变；densityOn要求D上非负、可测及可积而不要求归一化。结论对每个实t同时给出D上ρ∘Φ_{-t}的积分不变及其密度测度等于Φ_t推前初始密度测度。全局流的逆是Φ_{-t}，散度零和正则性足以推出Jacobian行列式1，继而体积保持；未将体积保持作为前提。正负时间方向和限制域均正确。形式指数用实际拉回/推前表达，[EXTRA]合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.hamiltonianDensityPropagation`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L632)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-MechanicalLiouvillian · definition · 印刷p.187 / PDFp.208

### 2. 原文陈述

> The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})$ can be written
> \[\mathcal L_H^\dagger=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},\]
> where $F_i=-\partial U/\partial q_i$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mechanicalLiouvillian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对Phase n=E n×E n、m为固定坐标质量、F仅依赖q、u和z为完整相空间标量函数与点。负Fréchet导数作用于(p_i/m_i,F(q))，在u可微处恰为-∑(p_i/m_i)∂q_i u-∑F_i∂p_i u，两个负号正确。这是可复用的微分表达式定义，不自身断言任意F均由势生成。其Hamiltonian特化F=-gradient U、正质量和C²势由本批条目12明确给出并核对，故结合该显式特化可接受；单独此定义不构成从H推出身份的证明。零质量或不可微u下Lean的总定义扩展不解释为原书物理算子。

### 7. 状态与证明位置

self-contained；`MD.Ch05.mechanicalLiouvillian`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L642)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-MechanicalLiouvillianIdentity · unnumbered_claim · 印刷p.187 / PDFp.208

### 2. 原文陈述

> The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})$ can be written
> \[\mathcal L_H^\dagger=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},\]
> where $F_i=-\partial U/\partial q_i$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : MolecularDynamics.Chapter05Review.Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) (MolecularDynamics.Chapter05Review.hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    MolecularDynamics.Chapter05Review.mechanicalLiouvillian m (fun q => -gradient U q) u z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mechanicalLiouvillianIdentity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。 | [EXTRA] |

[EXTRA] [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对∀n、所有坐标正质量m、任意C²势U、任意全空间可微实函数u及所有z∈Phase n。H为∑p_i²/(2m_i)+U(q)，hamiltonianField实际定义是(∇pH,-∇qH)；由固定非零m及势仅依赖q，恰得(p_i/m_i,-∇U(q))。结论将此场的负方向导数等同于mechanicalLiouvillian m (-gradient U)，完整保留一般势、所有q,p和所有u，并无只测二次势的弱化。[EXTRA]明确这是负Lie表达式身份而非无界Hilbert算子域的识别；正质量和C²强化合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mechanicalLiouvillianIdentity`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L648)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-TestSpace · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> The functions on which the generalized function acts are called test functions. Some choices for the space of test functions $\mathcal T^m$ defined on $\mathbb R^m$ include: the $C^\infty$ functions with compact support in $\mathbb R^m$, denoted $C_0^\infty(\mathbb R^m)$; the space $\mathcal S(\mathbb R^m)$ of $C^\infty$ functions on $\mathbb R^m$ whose derivatives decay rapidly at infinity (the so-called Schwarz space).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}

/-- 原文第二选项，独立保留Schwartz空间。 -/

def testSpaceSchwartz (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.testSpace`；`MD.Ch05.testSpaceSchwartz` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 紧支持C∞选项保留，并在同一source_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。 | [EXTRA] |

[EXTRA] [EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。；[EXTRA] 紧支持C∞选项保留，并在同一source_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。

### 6. 审计结论

本轮修复：紧支持C∞选项保留，并在同一source_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；当前仅有testSpace n这一声明：实n维欧氏空间上的实值函数子类型，ContDiff ℝ ∞与HasCompactSupport正确编码第一选项C∞紧支持，未误用Cω。但原文及本条statement_scope还完整列出第二选项S(R^m)，且context_notation声称两个选项都保留。所给本source_id全部声明与依赖里没有SchwartzMap/Schwartz空间选项、二选一接口或对应映射；不能因其他条目6引用过schwartzSpace就认定本条已经覆盖第二选项。因此完整覆盖FAIL；第一选项自身PASS。

### 7. 状态与证明位置

self-contained；`MD.Ch05.testSpace`：定义；`MD.Ch05.testSpaceSchwartz`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L659)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-SchwartzSpace · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> The formal definition of $\mathcal S$ is
> \[\mathcal S(\mathbb R^m)\stackrel{\rm def}{=}\{f\in C^\infty(\mathbb R^m)\mid\|f\|_{\alpha,\beta}<\infty\},\]
> where $\alpha$ and $\beta$ are arbitrary multi-indices, i.e. vectors of non-negative integers, and
> \[\|f\|_{\alpha,\beta}\stackrel{\rm def}{=}\sup_{z\in\mathbb R^m}\left|z_1^{\alpha_1}z_2^{\alpha_2}\cdots z_m^{\alpha_m}\frac{\partial^{\beta_1+\beta_2+\cdots+\beta_m}f}{\partial z_1^{\beta_1}\partial z_2^{\beta_2}\cdots\partial z_m^{\beta_m}}\right|.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def schwartzTestSpace (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.schwartzTestSpace` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。 | [EXTRA] |

[EXTRA] [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。项目 E n 已在 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)；MD.Ch05.schwartzTestSpace n 为 SchwartzMap (E n) ℝ。依用户补充规则，采信 SchwartzMap 的标准意义：实际实值 C∞ 函数，任意自然数 k 与微分阶数 r 的 ‖x‖^k‖D^r f(x)‖ 有统一有限上界。该标准空间自身使用 C∞ 阶数 ∞，不能因项目 testSpace 中另有 ⊤ 误用而把它当成解析函数空间。在有限维 ℝⁿ 上，全阶 Fréchet 导数范数的多项式权界与原书任意多重指标 α、β 的坐标单项式加权偏导数界等价：正向由坐标偏导受全阶导数范数控制，反向由有限坐标展开及有限维范数等价保证。n 任意，标量及函数值均为 ℝ，全部微分阶数与全部权的量词均保留。[EXTRA] 是等价的标准实现说明，没有增加数学限制，合理；无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.schwartzTestSpace`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L667)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GeneralizedFunction · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def generalizedFunction (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.generalizedFunction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。MD.Ch05.generalizedFunction 的完整定义是 (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ；该声明没有调用待展开的 MolecularDynamics 自定义定义。按标准含义，结果恰为 T 上满足加法及实数标量作用的实值代数线性泛函。量词／参数顺序为测试空间 T、其加法群及实模块结构，随后构成所有这些线性泛函的类型；这些结构编码原文所需的实向量空间。T 作为适当测试函数空间的抽象参数，无需给测试函数选定拓扑。原文只要求 real-valued linear operation，没有连续性要求，本签名亦没有连续性前提或字段，符合 context_notation。[EXTRA] 与 [ERRATUM?] 均无。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.generalizedFunction`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L670)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-SchwartzFunctional · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def schwartzFunctional (n : ℕ) := (MolecularDynamics.Chapter05Review.schwartzSpace n) →ₗ[ℝ] ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.schwartzFunctional` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。 | [EXTRA] |

[EXTRA] [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已从依赖附件展开 MolecularDynamics.Chapter05Review.schwartzSpace n := SchwartzMap (E n) ℝ 与 E n := EuclideanSpace ℝ (Fin n)。因此 MD.Ch05.schwartzFunctional n 是 ℝⁿ 上实际 Schwartz 实值测试函数空间到 ℝ 的实线性泛函类型。变量 n 任意，实标量、实值域及完整线性要求均保留，没有附加连续性。[EXTRA] 明确选择原书列出的第二种测试空间，是合理专门化，泛型 generalizedFunction 与另一测试空间条目在本批分别保留。另一条 testSpace 的阶数偏差由该条的 FAIL 单独记录，不影响此处 Schwartz 专门化与原文的对应。无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.schwartzFunctional`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L674)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-RegularDistribution · definition · 印刷p.188–189 / PDFp.209–210

### 2. 原文陈述

> If $f$ is a bounded, smooth function on $\mathbb R^m$, we may define a generalized function $T_f$ by reference to its action on a test function $\phi\in\mathcal T$ via integration:
> \[T_f(\phi)=\int_{\mathbb R^m}f(z)\phi(z)d\omega.\]
> This is very like the $L^2$ inner product, but the functions involved do not both need to lie in $L^2$. Nevertheless, we write $T_f(\phi)=\langle f,\phi\rangle$, as a helpful shorthand.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.regularDistribution` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E n 是实 n 维欧氏空间，schwartzSpace n 是实值 SchwartzMap。声明对任意 n、任意实函数 f 及 Schwartz 测试函数 φ 定义体积积分 ∫ fφ，积分域和被积式正确。它把原书的有界光滑 f 定义式延伸到更大的函数类型；总化积分在这一定义中不声称任意 f 都产生线性分布。在原书有界 C∞ 范围，可积性和完整实线性由本批条目2的 regularDistributionLinearity 承担；本定义无需把这些结论充当参数。原页明列 Schwartz 为一种可选测试空间，因此所选测试域忠实。

### 7. 状态与证明位置

self-contained；`MD.Ch05.regularDistribution`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L677)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-RegularDistributionLinearity · unnumbered_claim · 印刷p.188 / PDFp.209

### 2. 原文陈述

> If $f$ is a bounded, smooth function on $\mathbb R^m$, we may define a generalized function $T_f$ by reference to its action on a test function $\phi\in\mathcal T$ via integration: $T_f(\phi)=\int_{\mathbb R^m}f(z)\phi(z)d\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem regularDistributionLinearity : ∀ n (f : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ ∞ f → (∃ C : ℝ,∀ z,|f z| ≤ C) →
  (∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,Integrable (fun z => f z*φ z) volume) ∧
  (∀ (φ ψ : MolecularDynamics.Chapter05Review.schwartzSpace n) (a b : ℝ),
    MolecularDynamics.Chapter05Review.regularDistribution f (a • φ+b • ψ)=a*MolecularDynamics.Chapter05Review.regularDistribution f φ+b*MolecularDynamics.Chapter05Review.regularDistribution f ψ) := by
  intro n f hf hb
  obtain ⟨C,hC⟩ := hb
  have hi : ∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,
      Integrable (fun z => f z*φ z) volume := by
    intro φ
    apply Integrable.mono' (φ.integrable.norm.mul_const C)
    · exact hf.continuous.measurable.aestronglyMeasurable.mul φ.continuous.measurable.aestronglyMeasurable
    · filter_upwards [] with z
      simpa only [norm_mul,Real.norm_eq_abs,mul_comm] using mul_le_mul_of_nonneg_right (hC z) (abs_nonneg (φ z))
  refine ⟨hi,?_⟩
  intro φ ψ a b
  simp only [MolecularDynamics.Chapter05Review.regularDistribution,SchwartzMap.add_apply,SchwartzMap.smul_apply,smul_eq_mul]
  simp_rw [mul_add,← mul_assoc,mul_comm (f _) a,mul_comm (f _) b]
  simp_rw [mul_assoc]
  rw [integral_add ((hi φ).const_mul a) ((hi ψ).const_mul b),integral_const_mul,integral_const_mul]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.regularDistributionLinearity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。 | [EXTRA] |

[EXTRA] [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。；[EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全部量词为 ∀ n、∀ f，随后要求 ContDiff ℝ ∞ f 和一个对所有 z 通用的实上界 C。∞ 是 C∞，不是实解析。结论保留两个部分：每个 Schwartz φ 的 fφ 体积可积，以及对任意 φ、ψ 和任意实标量 a、b 的完整线性等式。regularDistribution 的依赖是真实积分；没有将可积性或线性改放进假设。有界光滑是原书条件，Schwartz 是书中明列的测试选择；[EXTRA] 的实质与签名一致。审校不将已有证明文本当作本次编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch05.regularDistributionLinearity`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L682)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracAction · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> For the Dirac delta $\delta$, its action on a function $\phi\in\mathcal T$ is $\delta[\phi]=\phi(0)$. We write this also as $\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def diracAction {n : ℕ} (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := φ 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracAction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已展开项目 schwartzSpace n := SchwartzMap (E n) ℝ 与 E n := EuclideanSpace ℝ (Fin n)，MD.Ch05.diracAction {n} φ 与依赖同名定义均直接返回 φ 0。按标准 SchwartzMap 函数作用，0 是 ℝⁿ 的零向量，返回实际实数 φ(0)，n 与 φ 均任意，恰为原页 δ[φ]=φ(0)。评价对测试函数加法和实数倍具有标准线性意义，原页 ⟨δ,φ⟩ 和形式积分表示同一动作，没有要求普通 Lebesgue 密度。选择原书列出的 Schwartz 测试空间是合理专门化；本条未单列 [EXTRA]，但这一选择由参数类型及本批相关定义明确，不附加排除 Schwartz 成员的条件。无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracAction`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L704)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracMeasure · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> For the Dirac delta $\delta$, its action on a function $\phi\in\mathcal T$ is $\delta[\phi]=\phi(0)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracMeasure` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已展开项目 E n := EuclideanSpace ℝ (Fin n)，并核对 MD.Ch05.diracMeasure n 与依赖同名定义均为 Measure.dirac 0 : Measure (E n)。按补充规则采信标准零点 Dirac 测度：单位质量集中于0；其对本批连续 Schwartz 测试函数的积分作用为 ∫ φ(z) d(δ_0)(z)=φ(0)。因此测度对象、零点、单位质量、任意维度以及原文的全部评价动作均一致，与同批 diracAction 的实现相符。它实现原文的点分布，没有将形式 δ(z)dω 解释成普通光滑 Lebesgue 密度。不存在必要而未提供的项目自定义定义。[EXTRA] 与 [ERRATUM?] 均无。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracMeasure`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L707)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracApproximation · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> This concept of the delta function (that appears in the integral) may be motivated by introducing a sequence of continuous functions $d_\varepsilon$ having the properties (i) $\int d_\varepsilon d\omega=1$, (ii) $\operatorname{supp}(d_\varepsilon)\to0$, as $\varepsilon\to0$. Then the action of the delta function can be seen as the limit of the actions of the functions $d_\varepsilon$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem diracApproximation :
  ∀ n (r : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ ε > 0,Continuous (r ε)) →
  (∀ ε > 0,MolecularDynamics.Chapter05Review.probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro n r hr hp hs φ hφ
  apply Metric.tendsto_nhds.mpr
  intro e he
  obtain ⟨δ,hδ,hφδ⟩ := Metric.continuousAt_iff.mp hφ.continuousAt (e/2) (by positivity)
  obtain ⟨η,hη,hsη⟩ := hs δ hδ
  filter_upwards [Ioo_mem_nhdsGT hη] with ε hε
  have hd := (hp ε hε.1).1
  have hmass := (hp ε hε.1).2
  have hb : ∀ z,‖(φ z-φ 0)*r ε z‖ ≤ (e/2)*r ε z := by
    intro z
    by_cases hz : r ε z=0
    · simp [hz]
    · have hzball := hsη ε hε (show z ∈ Function.support (r ε) from hz)
      have heφ := hφδ (by simpa only [Metric.mem_ball] using hzball)
      simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hd.2.1 z),Real.dist_eq] using
        mul_le_mul_of_nonneg_right heφ.le (hd.2.1 z)
  have hdiff : Integrable (fun z => (φ z-φ 0)*r ε z) volume := by
    apply Integrable.mono' (hd.2.2.const_mul (e/2))
    · exact ((hφ.sub continuous_const).mul (hr ε hε.1)).measurable.aestronglyMeasurable
    · exact ae_of_all _ hb
  have hpr : Integrable (fun z => φ z*r ε z) volume := by
    convert hdiff.add (hd.2.2.const_mul (φ 0)) using 1
    funext z
    change φ z*r ε z=(φ z-φ 0)*r ε z+φ 0*r ε z
    ring
  have hi : (∫ z,(φ z-φ 0)*r ε z)=(∫ z,φ z*r ε z)-φ 0 := by
    simp_rw [sub_mul]
    rw [integral_sub hpr (hd.2.2.const_mul (φ 0)),integral_const_mul,hmass,mul_one]
  have hle := norm_integral_le_of_norm_le (hd.2.2.const_mul (e/2)) (ae_of_all _ hb)
  rw [integral_const_mul,hmass,mul_one,hi] at hle
  rw [dist_eq_norm]
  exact hle.trans_lt (by linarith)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracApproximation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。 | [EXTRA] |

[EXTRA] [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已读取并展开 Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean（5315–5348行）：E n = EuclideanSpace ℝ (Fin n)；density ρ = Measurable ρ ∧ (∀ z,0 ≤ ρ z) ∧ Integrable ρ volume；probabilityDensity ρ = density ρ ∧ (∫ z,ρ z)=1；schwartzSpace n = SchwartzMap (E n) ℝ；diracAction φ = φ 0；diracMeasure n = Measure.dirac 0；gaussianDelta ε z = Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)。 量词顺序为任意维数、任意参数族，依次给出正参数下连续性、概率密度资格及统一最终支撑收缩，最后对每个连续测试函数断言 ε→0+ 的积分收敛到 φ(0)。Function.support 是非零点集合；对所有 δ>0 的该收缩条件与闭支持收缩等价（先用 δ/2）。连续测试函数虽可全局无界，但最终支持位于零点附近，局部有界足以保证乘积可积。非负性是明确披露、合理的 [EXTRA]；原文只列质量1与支撑收缩，若允许带符号函数，其推论不成立。例如取非负偶光滑紧支撑概率密度 b，令 rε(x)=ε⁻¹b(x/ε)+ε⁻²b((x−2ε)/ε)−ε⁻²b((x+2ε)/ε)，则质量1、支持收缩，而对在零附近等于 x 的光滑紧支撑 φ，积分最终等于4而 φ(0)=0。统一 L¹ 界可作为非负性的替代条件；当前签名已作显式修补，不应把这一修补回写为原书已有假设。无 [ERRATUM?] 标签。 签名语义与证明状态分别判断：已读 Ch05.lean 对应声明及其证明块，本条无 sorry/admit；本轮只读语义审计，没有运行 Lean 编译，PASS 不表示编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracApproximation`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L711)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDelta · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $\{d_\varepsilon\}$, such as, in one dimension,
> \[d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDelta` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数 ε、z 均为实数，Real.exp (−z²/(2ε))/Real.sqrt (2*pi*ε) 与原式仅相差乘法因子次序。作为函数的总化定义允许所有 ε；其概率或逼近单位元含义只在 ε>0 下使用，已由 context_notation 说明，并由条目5、6分别审校。高斯对 ε>0 的支撑是全实线；原页用 Alternatively 引入另一种近似族，并未把紧支撑收缩作为本定义的条件。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDelta`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L752)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracEvaluates · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> $\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem diracEvaluates : ∀ n (φ : MolecularDynamics.Chapter05Review.schwartzSpace n),
  (∫ z,φ z ∂(MolecularDynamics.Chapter05Review.diracMeasure n))=MolecularDynamics.Chapter05Review.diracAction φ := by
  intro n φ
  simp [MolecularDynamics.Chapter05Review.diracMeasure,MolecularDynamics.Chapter05Review.diracAction]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracEvaluates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀ n 和 ∀ 实值 Schwartz φ 的量化完整。diracMeasure n 展开为 E n 上的 Measure.dirac 0，diracAction φ 展开为 φ 0，故结论是真实 Dirac 测度积分等于在原点取值。δ 处的书面形式积分被正确解释为测度／分布配对，没有把 δ 换成普通 Lebesgue 密度。Schwartz 是前页给出的可选测试空间；无附加可积性假设，也没有漏掉右端的取值结论。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracEvaluates`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L755)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDeltaProbability · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $\{d_\varepsilon\}$, such as, in one dimension,
> \[d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ MolecularDynamics.Chapter05Review.gaussianDelta ε x) ∧ Integrable (MolecularDynamics.Chapter05Review.gaussianDelta ε) volume ∧
  (∫ x,MolecularDynamics.Chapter05Review.gaussianDelta ε x)=1 := by
  intro ε hε
  have he0 : ε ≠ 0 := ne_of_gt hε
  have hcoef : 0 < (1 : ℝ)/(2*ε) := by positivity
  have heq : MolecularDynamics.Chapter05Review.gaussianDelta ε=
      (fun x : ℝ => Real.exp (-(1/(2*ε))*x^2)/Real.sqrt (2*Real.pi*ε)) := by
    funext x
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    congr 2
    ring
  rw [heq]
  refine ⟨fun x => by positivity,?_,?_⟩
  · exact (integrable_exp_neg_mul_sq hcoef).div_const _
  · rw [integral_div,integral_gaussian]
    have hp0 : 0 ≤ 2*Real.pi*ε := by positivity
    have hratio : Real.pi/(1/(2*ε))=2*Real.pi*ε := by field_simp
    rw [hratio,div_self (ne_of_gt (Real.sqrt_pos.2 (by positivity)))]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDeltaProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。 | [EXTRA] |

[EXTRA] [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；声明对每个实 ε，在 0<ε 的明确条件下，同时断言对所有实 x 的非负性、相对于实线 Lebesgue 体积的可积性以及完整全空间积分等于1。依赖 gaussianDelta 的指数为 −x²/(2ε)，归一化为 √(2πε)；这是真实的方差 ε 高斯密度。三个概率密度资格都在结论里，未由总化定义或预设积分等于1替代。[EXTRA] 的正参数条件必要且合理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDeltaProbability`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L762)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDeltaWeak · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $\{d_\varepsilon\}$, such as, in one dimension,
> \[d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro φ hφ hb
  have hg := gaussianDeltaProbability 1 (by norm_num)
  obtain ⟨C,hC,hBC⟩ := hb.exists_pos_norm_le
  have ht : Tendsto (fun ε : ℝ => ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (𝓝[>] 0) (𝓝 (φ 0)) := by
    have hc := tendsto_integral_filter_of_dominated_convergence
      (fun x : ℝ => C*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (F:=fun ε x => φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (f:=fun x => φ 0*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (Filter.Eventually.of_forall (fun ε => by
        apply Continuous.aestronglyMeasurable
        unfold MolecularDynamics.Chapter05Review.gaussianDelta
        fun_prop))
      (Filter.Eventually.of_forall (fun ε => ae_of_all _ (fun x => by
        simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hg.1 x)] using
          mul_le_mul_of_nonneg_right (hBC (φ (Real.sqrt ε*x)) (mem_range_self _)) (hg.1 x))))
      (hg.2.1.const_mul C) (ae_of_all _ (fun x => by
        have hs : Tendsto (fun ε : ℝ => Real.sqrt ε*x) (𝓝[>] 0) (𝓝 0) := by
          simpa using! ((Real.continuous_sqrt.tendsto 0).mono_left inf_le_left).mul_const x
        exact (hφ.tendsto 0 |>.comp hs).mul_const _))
    simpa only [integral_const_mul,hg.2.2,mul_one] using hc
  apply tendsto_congr' _ |>.2 ht
  filter_upwards [self_mem_nhdsWithin] with ε hε
  have hεpos : 0 < ε := hε
  have hspos : 0 < Real.sqrt ε := Real.sqrt_pos.2 hεpos
  have hs0 : Real.sqrt ε ≠ 0 := ne_of_gt hspos
  have hpoint (x : ℝ) : Real.sqrt ε*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)=
      MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    rw [mul_pow,Real.sq_sqrt hεpos.le]
    have hexp : -(ε*x^2)/(2*ε)= -x^2/2 := by field_simp
    rw [hexp,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
    simp only [mul_one]
    field_simp
  calc
    (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=
      Real.sqrt ε*(∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)) := by
        change (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=Real.sqrt ε*(∫ x,(fun y => φ y*MolecularDynamics.Chapter05Review.gaussianDelta ε y) (Real.sqrt ε*x))
        have hchange : (∫ x : ℝ,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x))=
            (Real.sqrt ε)⁻¹*(∫ x : ℝ,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) := by
          simpa only [smul_eq_mul,abs_of_pos (inv_pos.mpr hspos)] using!
            (Measure.integral_comp_mul_left (fun x : ℝ => φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (Real.sqrt ε))
        rw [hchange]
        field_simp
    _ = ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
      rw [←integral_const_mul]
      apply integral_congr_ae
      filter_upwards [] with x
      rw [←hpoint]
      ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDeltaWeak` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。 | [EXTRA] |

[EXTRA] [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化所有 φ:ℝ→ℝ，要求 Continuous φ 及 Bornology.IsBounded (range φ)，即有界连续测试函数。对真实配对 ∫φ(x)dε(x) 的结论使用 𝓝[>]0，正确表示 ε 从正侧趋于0，目标是 φ 0。它覆盖书中 Schwartz 和光滑紧支撑测试函数，并合理推广到有界连续测试；没有错误地要求高斯支撑收缩。正侧滤子、全实线积分、乘法配对及极限值均完整；[EXTRA] 没有把所求极限作为假设。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDeltaWeak`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L784)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-WeakStationary · definition · 印刷p.189–190 / PDFp.210–211

### 2. 原文陈述

> We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of
> \[\mathcal L_f^\dagger\rho=0.\]
> However, this requires a little care. In general, we would like to be able to apply $\mathcal L_f^\dagger$ to nonsmooth distributions such as Dirac delta functions for which the application of the Liouville operator does not make obvious sense (as we have not mentioned how to differentiate delta functions). Instead we will define the stationary solution in terms of integrals against test functions.
> this suggests that the condition for the invariant probability density function $\rho_\infty$ should be
> \[\int_{\mathcal D}\phi\mathcal L_f^\dagger\rho_\infty\,d\omega=0,\]
> for all suitable functions $\phi\in C_0^\infty(\mathbb R^m)$. We say that $\rho_\infty$ satisfies
> \[\mathcal L^\dagger\rho_\infty=0,\]
> in the weak or variational sense.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。 | [EXTRA] |

[EXTRA] [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。；[EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；testSpace n 展开后恰为所有满足 ContDiff ℝ ∞ 和 HasCompactSupport 的实函数，不是 Cω 类型。lie f φ z 是真实 fderiv ℝ φ z 作用于 f z。weakStationary 对每个这样的 φ 同时要求 lie 的 μ 可积性和积分为0，因此保留全部测试量词及非平凡弱方程；没有依赖不可积 Bochner 积分的默认0。全空间测度 μ 可取受限域 D 上密度测度的零延拓，分布伴随的边界作用由该配对保留。μ 类型允许一般正测度，是稳态方程本身的推广；若要称为原书的概率分布，还应另有 μ(univ)=1 的资格。本定义没有声称每个 weakStationary μ 都已经归一化，也未声称在任意不规则 f 下与某个流的不变性等价。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakStationary`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L840)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnsembleAverage · 5.6 · 印刷p.190 / PDFp.211

### 2. 原文陈述

> Let $\phi$ be a $C^\infty$ function of the phase variables with compact support and define the time $t$ average by
> \[\bar\phi(t)=\frac{\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho(\mathbf q,\mathbf p,t)\,d\omega}{\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega}.\tag{5.6}\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ensembleAverageOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；ensembleAverageOn 的参数完整含 n、域 D、随时间变化的 ρ:ℝ→E n→ℝ、观测函数 φ 和时刻 t。densityAverageOn 展开后为 (∫_D φ(z)ρ(t,z))/(∫_D ρ(t,z))，没有漏掉分母、域或时间参数。定义的函数类型较原书的概率密度和 C∞ 紧支撑观测函数更宽；在原书资格下恰为(5.6)。这是时刻 t 的系综平均，没有换成时间轨道平均；对总质量0或不可积输入的总化值不赋予概率平均含义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.ensembleAverageOn`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L847)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ConvergenceHeuristic · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> As the flow is Hamiltonian, $\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega\equiv\int_{\mathcal D}\rho(\mathbf q,\mathbf p,0)\,d\omega$. Thus the condition for $\bar\phi$ to converge is just that
> \[\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\frac{\partial\rho}{\partial t}(\mathbf q,\mathbf p,t)\,d\omega\to0.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem convergenceHeuristic : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → MolecularDynamics.Chapter05Review.flow f Φ → (∀ t,Φ t '' D=D) →
  (∀ t,MeasurePreserving (Φ t) volume volume) →
  ContDiff ℝ 1 (Function.uncurry ρ) → ContDiff ℝ ⊤ φ → HasCompactSupport φ →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0) →
    ∃ L : ℝ,Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ConvergenceHeuristic。改动：导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。 -/
```

独立修正版：

```lean
theorem convergenceHeuristic_corrected (A : ℝ → ℝ)
    (_hA : ContDiff ℝ 1 A) (_hint : IntegrableOn (deriv A) (Ici (0 : ℝ))) :
    ∃ L : ℝ, Tendsto A atTop (𝓝 L) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.convergenceHeuristic`；`MD.Ch05.convergenceHeuristic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。 | [EXTRA] |

[EXTRA] [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。；[ERRATUM?] 导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x_source.json。核对 Ch05.lean:707–716，并展开项目 flow、measurePropagator 以及本文件的 densityOn、probabilityDensityOn、densityMeasureOn、densityAverageOn。flow 含 Φ0=id、实时间群律及每条轨道的真实 ODE 导数；measurePropagator 是 Measure.map；densityOn 是受限体积下的可测、非负、可积资格，probabilityDensityOn 另含 ∫_Dρ=1；densityMeasureOn 是 (volume.restrict D).withDensity(ofReal ρ)；densityAverageOn 是实际积分商。标准定义足以确认这些对象，无缺失 Mathlib 定义问题。量词先给 n,D,f,Φ,ρ,φ，前提为零可测 D、真实流、D 流不变、每个 Φt 保体积、联合 C¹ 密度、C∞ 紧支撑 φ、各时刻实际概率密度及从初始测度的真实输运；最后假设导数配对趋零，并得依赖 φ 的某个平均极限。[EXTRA] 域不变、输运与保体积均合理，未假设最终平均收敛。质量等式可由各时刻概率归一化直接读出，两端都是 1，不因其未重复列在结论而判失败。保留 FAIL 的具体原因是 statement_scope 的完整条件措辞：“the condition ... is just that”的条件读法包含必要方向，当前签名只有导数配对趋零 ⇒ 平均收敛；缺少反向，而且没有在映射中登记为单向子命题。原文未写显式 iff，这一范围问题不能通过默认把“condition”缩成充分性来静默消除；若采用这种作者解释，需明确登记缩窄范围。此 FAIL 不表示目前充分方向在上述动力学背景中为假，也不依据 Mathlib 缺失。一般标量导数趋零却不收敛的例子不是满足该签名全部前提的反例。证明体为 sorry，单独记录，不用于决定语义 verdict；无 [ERRATUM?] 标注。

### 7. 状态与证明位置

incomplete；`MD.Ch05.convergenceHeuristic`：未证（原书疑误不证）；`MD.Ch05.convergenceHeuristic_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L853)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HamiltonianEnergyIntegral · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> In the case of a Hamiltonian system, we know that $\mathcal L_f^\dagger=-\mathcal L_f$, and, moreover, $\mathcal L_fH=0$, so that $H$ is a first integral.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0 := by
  rw [MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson]
  exact MolecularDynamics.textbookPoissonBracket_self H z

theorem hamiltonianEnergyIntegral_full (k : ℕ)
    (H u : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (_hH : ContDiff ℝ 2 H) (_hu : ContDiff ℝ 1 u)
    (z : MolecularDynamics.SymplecticCoordinates k)
    (γ : ℝ → MolecularDynamics.SymplecticCoordinates k) (a b : ℝ) (_hab : a ≤ b)
    (_hγ : ∀ t ∈ Icc a b,HasDerivWithinAt γ
      (MolecularDynamics.textbookHamiltonianVectorField H (γ t)) (Icc a b) t) :
    -(LinearMap.trace ℝ (MolecularDynamics.SymplecticCoordinates k)
      (fderiv ℝ (fun x ↦ u x • MolecularDynamics.textbookHamiltonianVectorField H x) z).toLinearMap)=
        -MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) u z ∧
    (∀ t ∈ Icc a b,H (γ t)=H (γ a)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianEnergyIntegral`；`MD.Ch05.hamiltonianEnergyIntegral_full` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实Hamiltonian场的−div(u f)=−L_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L_fH=0，不把散度零/能量守恒当假设。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实Hamiltonian场的−div(u f)=−L_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L_fH=0，不把散度零/能量守恒当假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；本条两项声明均已核对。hamiltonianEnergyIntegral 对任意 Nc、实 Hamiltonian H 及 z 给出真实 Hamiltonian 向量场的 L_f H(z)=0；J 的项目定义为块矩阵 [0,I;−I,0]，Lie 导数为实际 Fréchet 导数沿 f 的作用。这个基础等式允许任意 H，是导数总化下的代数恒等式。hamiltonianEnergyIntegral_full 另量化 k、H、u、z、实际轨道 γ、闭区间端点 a,b；要求 H 为 C²、u 为 C¹、a≤b，并在 Icc a b 每点满足正确的 HasDerivWithinAt Hamiltonian 轨道方程。其合取结论完整包含 −trace D(u f)(z)=−L_f u(z)，以及对每个 t∈Icc a b 的 H(γ t)=H(γ a)。前者是书中形式伴随的点态表达，后者落实真实轨道上的第一积分；未把散度零或能量守恒当成假设。闭区间退化为单点时结论也正确。

### 7. 状态与证明位置

incomplete；`MD.Ch05.hamiltonianEnergyIntegral`：已证；`MD.Ch05.hamiltonianEnergyIntegral_full`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L878)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnergyDensityInvariant · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> Any probability distribution whose density is a smooth function of $H$ will also be an invariant distribution.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyDensityInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    Φ (r : ℝ → ℝ), MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,MolecularDynamics.Chapter05Review.lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ H) → ∀ t,
    MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H))=MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.energyDensityInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。 | [EXTRA] |

[EXTRA] [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x_source.json。已展开 Chapter05/ReviewDefinitions 中 E、flow、lie、density、probabilityDensity、densityMeasure、measurePropagator，并核对 Ch05.lean:726–732。项目 probabilityDensity(r∘H) 要求其可测、非负、对标准体积可积且积分为 1；densityMeasure 是实际 withDensity(ofReal(r∘H))，推前是 Measure.map。全称量词对 n,H,f,Φ,r，假设 H,r 为 C¹、Φ 是真实自治流、DH[f]=0、每个 Φt 保体积和真实概率资格；结论是对全部实时间 t 密度测度推前等于原测度。[EXTRA] 能量第一积分与保体积是 Hamiltonian 背景的实际结构属性，抽象登记后给出更一般的同结论命题，并未把待证的不变密度测度当成假设。C¹ 足以支持链式法则，概率资格保留了源文对 distribution 的限制；未声称任意 r∘H 自动可积。对象、量词、假设及不变结论忠实；PASS。证明体为 sorry；该 PASS 只指签名语义，不表示证明完成。无 [ERRATUM?] 标注。

### 7. 状态与证明位置

incomplete；`MD.Ch05.energyDensityInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L898)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeight · definition · 印刷p.190 / PDFp.211

### 2. 原文陈述

> In particular, consider the density $\rho_\varepsilon(\mathbf q,\mathbf p)=Z_\varepsilon^{-1}e^{-(H(\mathbf q,\mathbf p)-E)^2/(2\varepsilon)}$, where $\varepsilon$ is an arbitrary small positive constant and $E$ is an accessible energy level.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeight` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellWeight 对 n、H:E n→ℝ、实 c、ε 以及 z 定义 exp(−(H(z)−c)²/(2ε))。能级 c 对应原文 E；平方、负号和2ε均正确。它确实只是未归一化权，没有被错认成 ρε；按已明示的范围，由 shellPartition 和 shellDensity 分别处理 Z 和完整密度。ε>0、可达性和增长性是原书的使用资格，裸函数定义的总化参数域并不声称任意输入都是概率密度。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellWeight`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L908)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellPartition · definition · 印刷p.190–191 / PDFp.211–212

### 2. 原文陈述

> We assume that $H$ tends to infinity sufficiently rapidly as $\|\mathbf z\|\to\infty$ so that the exponential decays sufficiently rapidly (and thus the total integral exists) and take $Z_\varepsilon$ to be a normalization factor that insures that we have, for each $\varepsilon$, a well defined probability density function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellPartition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellPartition 的 n、H、能级 c、ε 与实际 shellWeight 一致；定义的是全 E n 上未归一化权的 Lebesgue 体积积分，正是原书归一化要求确定的 Zε。原文把增长足够快、从而总积分存在作为假定；当前声明是归一化因子的定义，没有另外声称从一个未指定速率的定量增长条件推出可积性。在原书的正 ε、可积权语境下指数处处为正，因此该积分是有限正归一化因子。context_notation 已明确区分总化定义和实际概率使用资格；不能据此定义推断任意 H 的归一化可行。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellPartition`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L911)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellDensity · definition · 印刷p.190 / PDFp.211

### 2. 原文陈述

> $\rho_\varepsilon(\mathbf q,\mathbf p)=Z_\varepsilon^{-1}e^{-(H(\mathbf q,\mathbf p)-E)^2/(2\varepsilon)}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellDensity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellDensity 使用真实 shellWeight H c ε z 除以真实 shellPartition H c ε，展开后恰为 Zε⁻¹ exp(−(H(z)−c)²/(2ε))；只除一次 Zε，所有参数和同一能级均保持。它没有偷换成另一个函数或常数，也未重复归一化。作为定义允许较大参数类型；概率密度的非负可积及正分母资格仍按原书及 context_notation 使用，不由总化除法自动提供。此项没有额外宣称任意 H 或非正 ε 都是概率密度。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellDensity`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L914)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnergySurface · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> We assume the level sets $\Sigma_E=\{(q,p)\mid H(q,p)=E\}$ to be bounded.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.energySurface` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。 MD.Ch05.energySurface {n} H c = {z | H z=c}，与原文Σ_E完全相同，n为环境维度，c为能量值。此条kind=definition，只形式化能量等值集合；原书有界性是使用假设，原条context_notation已明确单列，不从def推出。没有额外假设或ERRATUM；定义体无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.energySurface`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L917)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-SurfaceMeasure · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> where $d\sigma$ is the “area element” of the energy surface. (The term “area” in this context might be replaced by “hyperarea” or “volume” since we are in many dimensions.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.surfaceMeasure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。 | [EXTRA] |

[EXTRA] [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v_d/2^d) • Measure.hausdorffMeasure d，其中v_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。 MD.Ch05.surfaceMeasure直接采用上述项目曲面面积定义，所取维度n−1与原文m−1一致，测度对象位于整个相空间而其质量受限于能量面，这是dσ的标准测度实现。EXTRA的Hausdorff规范化选择合理，与Gram图公式的识别是后续证明义务；缺少该证明并不使定义的数学对象失真。正维光滑正则面是几何解释的背景，n=0仅是总化扩展。无ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.surfaceMeasure`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L921)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroRaw · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> define the invariant measure of a set $M\subset\Sigma_E$ by
> \[\mu(M)=\int_M\frac1{\|\nabla H\|}d\sigma.\]
> Thus the invariant measure of interest to us is a rescaling of the indicated metric by the factor $1/\|\nabla H\|$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microRaw` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v_d/2^d) • Measure.hausdorffMeasure d，其中v_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。 MD.Ch05.microRaw以非负权ofReal(‖grad H z‖⁻¹)给surfaceMeasure加密度。因此在非零梯度的原文使用范围内，对面上可测M确有μ(M)=∫_M 1/‖∇H‖ dσ，未加概率归一化因子。withDensity、restrict与ofReal按标准含义已足以判定这一对象，不需要它们的库内实现。零梯度处逆元总化为0，不能解释成奇异权；原文PDF213另设梯度远离0。context_notation关于raw与概率的区别正确。此def记录原文测度，不独立证明Hamiltonian动力学下的invariant属性；没有将该属性冒充已证。无EXTRA/ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microRaw`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L925)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeakPrinted · unnumbered_claim · 印刷p.191 / PDFp.212

### 2. 原文陈述

> As we decrease $\varepsilon$, the density remains invariant under Liouville's equation. The prefactor means that we can think of a sequence of smooth densities taken with successively smaller values of $\varepsilon$ as approaching the limiting distribution defined in terms of the delta function by
> \[\rho_0(q,p)=Z_{H=E}^{-1}\delta[H(q,p)-E].\tag{5.7}\]
> To make this statement precise, the definition of the limit must be taken here in the weak sense, that is, we need to study the limit
> \[\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega,\tag{5.8}\]
> taken in relation to a test function $\phi\in\mathcal T$.

### 3. 原文证明

原书无独立完整证明。
> The proof that (5.8) can be taken and that the stated weak-limit identity holds may be found in the PhD thesis of Hartmann [171, Appendix D].（对原页转引的摘要；该恒等式含原书重复归一化及以ρ₀(q,p)代替分布配对的记号疑误，未在此修正。）
原书未给独立完整证明；PDF212转引Hartmann博士论文[171, Appendix D]。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellWeakPrinted :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (MolecularDynamics.Chapter05Review.shellPartition H c ε)⁻¹*(∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ShellWeakPrinted。改动：删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。 -/
```

独立修正版：

```lean
theorem shellWeakPrinted_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧
    ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakPrinted`；`MD.Ch05.shellWeakPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。 | [EXTRA] |

[EXTRA] [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。；[ERRATUM?] 删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v_d/2^d) • Measure.hausdorffMeasure d，其中v_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。shellWeight H c ε z = exp(−(H z−c)²/(2ε))；shellPartition H c ε = ∫shellWeight；shellDensity = shellWeight/shellPartition。testSpace n = {φ : ℝⁿ→ℝ | φ为C∞且有紧支撑}。microRaw = surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure = ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage = average microMeasure，average μ g = ∫g dμ。regularEnergy H c展开为能量面非空、紧、每点grad≠0，以及raw总质量严格正且有限。 量词为∀n,H,c，在C²与regularEnergy前提后对每个C∞紧支φ，主张ε↓0时Z_ε⁻¹∫φρ_ε趋向microAverage。PDF211已将ρ_ε定义为归一化密度，PDF212式(5.8)再次出现外层Z_ε⁻¹；项目定义展开确认该签名确实重复归一化。全相空间D=ℝⁿ的EXTRA是合理范围选择，但不能消除反例；原书的尾部可积性也未由regularEnergy单独保证。原文所引Liouville不变性不在本签名结论中。相关原书疑误成立；FAIL来自错误极限和缺失结论，不是Mathlib材料不足。实际声明含sorry，此事实与语义判定分开。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellWeakPrinted`：未证（原书疑误不证）；`MD.Ch05.shellWeakPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L931)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeakLimitCorrected · 5.8 · 印刷p.191 / PDFp.212

### 2. 原文陈述

> \[\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho_\varepsilon\,d\omega,\tag{5.8}\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellWeakLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ShellWeakLimitCorrected。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shellWeakLimit_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakLimit`；`MD.Ch05.shellWeakLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正版：不再对已归一化ρ_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正版：不再对已归一化ρ_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；这是 source_id 明示的独立勘误版本，不能按字面(5.8)要求它再除一次 Zε。声明完整量化 n、H、c，要求 n>0、H 为 C²、regularEnergy H c、能级可达，以及存在正 δ 的紧能带与所有 ε∈(0,δ) 的真实权可积及正分母。regularEnergy 展开后含非空紧能量面、其上处处非零的真实梯度、microRaw 有限正总质量；单列可达条件虽冗余但无害。测试空间确为全部 C∞ 紧支撑函数。被积式是 φ乘已经归一化的 shellDensity，ε 从正侧趋零。microAverage 展开为将曲面 Hausdorff 面积按 1/‖∇H‖ 加权后，再以该 raw 总质量归一化的真实测度积分。所有对象和归一化均匹配正确的 coarea 弱极限；紧带及一个较大正参数下的权可积控制带外尾部，所以假设足够，没有把极限当假设。未缩放的 Zε 通常趋零，曲面质量对应 Zε/√(2πε) 的极限而非 Zε 的普通极限。故当前勘误签名 PASS；原书重复归一化仍作为独立疑误 NEEDS_HUMAN 保留。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellWeakLimit`：未证（原书疑误不证）；`MD.Ch05.shellWeakLimit_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L958)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-SurfaceAreaFormula · unnumbered_claim · 印刷p.191 / PDFp.212

### 2. 原文陈述

> If we can represent the $m-1$-dimensional set $\mathcal M$ as the image of an open set $\mathcal U\in\mathbb R^{m-1}$ under a smooth mapping $\mathbf g:\mathbb R^{m-1}\to\Sigma_E$, then we have
> \[\operatorname{Vol}(\mathcal M)=\int_{\mathcal U}\sqrt{\det[(\mathbf g^{\prime}(\boldsymbol\zeta))^T\mathbf g^{\prime}(\boldsymbol\zeta)]}\,d\zeta_1d\zeta_2\cdots d\zeta_{m-1}.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem surfaceAreaFormula :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-SurfaceAreaFormula。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem surfaceAreaFormula_corrected :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.surfaceAreaFormula`；`MD.Ch05.surfaceAreaFormula_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；限定后的 Lean 面积公式在数学上正确：∀ d、g:E d→E(d+1)、开集 U，要求 U 上 C¹、g 全局单射，并要求 U 上每点的真实 fderiv 单射。结论左边使用项目 hausdorffArea d 在 g像U 上的测度，右边由标准欧氏基的导数向量内积构成完整 d×d Gram 矩阵，取 determinant 的非负平方根并在 U 上积分；正是 m=d+1 的无重数面积公式。hausdorffArea 的项目缩放为 d维单位球体积/2^d，落实标准欧氏面积。由于两边分别使用 ENNReal.toReal 和实值 Bochner 积分，非有限情形是总化解释，并不额外宣称面积有限；有限面积时即通常数值公式。未要求像落在某一特定能量面，是对与 H 无关的局部面积公式的合理推广。须明确的是 Function.Injective g 为全局单射，比仅在 U 上单射更强，且 C¹ 比原书 smooth 所需的正则性更弱；这两点都不使受限公式错误。[EXTRA] 确实补入了单射浸入资格，但原书仅凭任意 smooth mapping 的原句不成立，另有 ∈ 的类型错误；按任务要求原书疑误不能静默按 chart 解读，因此本条整体 NEEDS_HUMAN，而非因 sorry 或限定后公式错误判 FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch05.surfaceAreaFormula`：未证（原书疑误不证）；`MD.Ch05.surfaceAreaFormula_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L986)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalField · definition · 印刷p.192 / PDFp.213

### 2. 原文陈述

> We suppose $\|\nabla H\|$ to be bounded away from zero on $\Sigma_E$. At each point of $M$ we let $n=\nabla H/\|\nabla H\|$ be the unit normal to the energy surface and define a local coordinate $\xi$ measuring distance along the direction of the unit normal.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def normalField {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := ‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹ • MolecularDynamics.Chapter05Review.grad H z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。 展开MD.Ch05.normalField与项目normalField均为‖grad H z‖⁻¹ • grad H z，对非零梯度正是原文n=∇H/‖∇H‖，范数1并与能量面切空间正交。原文梯度在面上远离0是使用资格；context_notation明确零梯度处总化向量0不具有单位法线意义。作为normalField定义，此条形式化n，局部距离坐标ξ为引用背景，不自动宣称其存在性。没有EXTRA/ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.normalField`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1014)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalEnergyTaylor · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $\Delta E=H(\mathbf z+\mathbf n\xi)-H(\mathbf z)=\nabla H\cdot\mathbf n\xi+\mathcal O(\Delta E^2)$, and $\mathbf n=\nabla H/\|\nabla H\|$, we have $\xi=\Delta E/\|\nabla H\|+\mathcal O(\Delta E^2)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalEnergyTaylor :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • MolecularDynamics.Chapter05Review.normalField H z)-H z-s*‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*s^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalEnergyTaylor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | [EXTRA] |

[EXTRA] [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀ 维数 n、H:E n→ℝ 和基点 z，C² 及 grad H z≠0 后给出 ∃C>0、∃δ>0，再对每个 |s|<δ 断言二阶余项估计。grad 是实际 gradient，normalField 是 ‖grad‖⁻¹•grad，故线性项确为 s‖∇H(z)‖，位置 z+s•normalField 正确。此结论是固定基点的实际 O(s²) 正向 Taylor 子引理；它没有单独给出以 e=ΔE 为参数的逆坐标或 O(e²)。输入 statement_scope 和 [EXTRA] 已将这些剩余结论明确映射到本批条目16，后者确实完整包含，所以不把子引理冒充整句。C² 和非零梯度是合理的局部资格；没有从总化 gradient 推断任意 H 的 Taylor 展开。

### 7. 状态与证明位置

incomplete；`MD.Ch05.normalEnergyTaylor`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1019)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalInverseTaylor · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $\Delta E=H(\mathbf z+\mathbf n\xi)-H(\mathbf z)=\nabla H\cdot\mathbf n\xi+\mathcal O(\Delta E^2)$, and $\mathbf n=\nabla H/\|\nabla H\|$, we have $\xi=\Delta E/\|\nabla H\|+\mathcal O(\Delta E^2)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalInverseTaylor : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0,∃ δ > 0,
  ∀ e : ℝ,|e| < δ → ∃ ξ : ℝ,
    H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)=H z+e ∧
    |ξ-e/‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*e^2 ∧
    |H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)-H z-‖MolecularDynamics.Chapter05Review.grad H z‖*ξ| ≤ C*e^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalInverseTaylor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；声明对每个 n、C² 函数 H 和非临界基点 z，先选择依赖 H,z 的 C>0 和 δ>0，再对每个实 |e|<δ 选择 ξ。三个合取结论都保留：真实能量方程 H(z+ξn)=H(z)+e；|ξ−e/‖∇H(z)‖|≤Ce²；以及同一 ξ 上 |H(z+ξn)−H(z)−‖∇H(z)‖ξ|≤Ce²。最后一项正是原文以 ΔE 为变量的正向余项，而不是只提供 O(ξ²)。同一 C 可通过增大常数同时控制两项；非零梯度给出一维法向能量映射的非零导数，C² 局部逆资格足够。估计还使 ξ 在 e→0 时趋0，故存在性不是无关的远处能量交点。原文 E 在此为 H(z)，法向取在固定基点；本条不声称对整个能量面有统一的常数。

### 7. 状态与证明位置

incomplete；`MD.Ch05.normalInverseTaylor`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1027)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-PatchShellVolume · unnumbered_claim · 印刷p.192–193 / PDFp.213–214

### 2. 原文陈述

> The volume of this thickened shell is clearly $\Delta V=\int_M\xi d\sigma$, but since $\Delta E=H(z+n\xi)-H(z)=\nabla H\cdot n\xi+O(\Delta E^2)$, and $n=\nabla H/\|\nabla H\|$, we have $\xi=\Delta E/\|\nabla H\|+O(\Delta E^2)$, and $\Delta V=\int_M\frac{\Delta E}{\|\nabla H\|}d\sigma+O(\Delta E^2)$. Taking the ratio of $\Delta V$ to $\Delta E$ we find $\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)$. The limit of this as $\Delta E\to0$ defines a quantity $\mu(M)=\int_M\|\nabla H\|^{-1}d\sigma$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem patchShellVolume : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (M : Set (MolecularDynamics.Chapter05Review.E n)),
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ MolecularDynamics.Chapter05Review.energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • MolecularDynamics.Chapter05Review.normalField H z ∧ H x-H z ≤ e}).toReal/e-
        ((MolecularDynamics.Chapter05Review.microRaw H c) M).toReal| ≤ C*e := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-PatchShellVolume。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem patchShellVolume_corrected : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (M : Set (MolecularDynamics.Chapter05Review.E n)),
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ MolecularDynamics.Chapter05Review.energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • MolecularDynamics.Chapter05Review.normalField H z ∧ H x-H z ≤ e}).toReal/e-
        ((MolecularDynamics.Chapter05Review.microRaw H c) M).toReal| ≤ C*e := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.patchShellVolume`；`MD.Ch05.patchShellVolume_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.patchShellVolume（810–817行）及PDF213–214/印刷192–193。在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。regularEnergy 并非仅正则值条件，而是能量面非空、紧、处处grad≠0、raw总质量严格正且有限的合取。实际签名对每个紧可测M⊂Σ_c，先选C,δ>0，再对所有0<e<δ，给由x=z+s n(z)、0≤s<δ、H(x)−H(z)≤e定义的真实法线薄壳满足|vol(S_e)/e−μ(M)|≤Ce。C²、紧正则面与可测片足以保证小管几何，额外全能量面非空及质量正并非局部估计的最小要求，但作为明确的物理背景合理。最终O(e)结论以及由它推出的极限正确；乘以e也得到体积的O(e²)式。然而本条statement_scope覆盖所引整段，其“clearly ΔV=∫_M ξdσ”精确等式既未编码也一般不成立；[EXTRA]关于Jacobian的勘误判断成立，不能将该错误原印刷式视为已经保留。此FAIL针对完整引用范围的覆盖，不是否定修正后最终渐近估计。附件对应theorem的证明体仍为sorry；这里只判断签名语义，PASS不表示Lean证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.patchShellVolume`：未证（原书疑误不证）；`MD.Ch05.patchShellVolume_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1038)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-WholeShellVolumeLimit · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellVolumeLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microPartition H c)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-WholeShellVolumeLimit。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shellVolumeLimit_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microPartition H c)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellVolumeLimit`；`MD.Ch05.shellVolumeLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.shellVolumeLimit（821–827行）及所引PDF213/印刷192比值式。在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。regularEnergy 并非仅正则值条件，而是能量面非空、紧、处处grad≠0、raw总质量严格正且有限的合取。microPartition H c=((microRaw H c) univ).toReal；regularEnergy确保有限性，在此处toReal无损。签名表达整能量面全壳{c≤H≤c+ε}的体积比值在ε→0+时收敛到该总质量。额外紧正则能量带避免远处分支贡献，是合理的全壳控制；其邻域∀z梯度非零明确且非循环。但所引式对任意片M并含O(ΔE)，而本签名无M且仅Tendsto，没有O(ε)误差界。[EXTRA]诚实标明这是特例，不能使较弱特例等同于所引全部结论；别条保留片定理也不改变本声明。附件对应theorem的证明体仍为sorry；这里只判断签名语义，PASS不表示Lean证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellVolumeLimit`：未证（原书疑误不证）；`MD.Ch05.shellVolumeLimit_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1066)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroRawInvariant · unnumbered_claim · 印刷p.193 / PDFp.214

### 2. 原文陈述

> As both volume and energy are invariant under the Hamiltonian flow, $\mu(\mathcal M)$ must be invariant under the flow, thus $\mu(\mathcal F_t(\mathcal M))=\mu(\mathcal M)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem microRawInvariant : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microRaw H c) (MolecularDynamics.Chapter05Review.microRaw H c) ∧
    ∀ M,MeasurableSet M → (MolecularDynamics.Chapter05Review.microRaw H c) (Φ t '' M)=(MolecularDynamics.Chapter05Review.microRaw H c) M := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microRawInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。 | [EXTRA] |

[EXTRA] [EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。光滑全流、体积保持和能量保持是本条的实际输入，待证的加权曲面测度不变性没有被假设。联合光滑性及逆时间使像集合结论与 MeasurePreserving 相容。原书只写 M⊂Σ_E；Lean 对任意可测环境 M 陈述等式是支持于能级的测度的自然扩展。regularEnergy 的额外限制较原句强，已在 corrected_json 明示。

### 7. 状态与证明位置

incomplete；`MD.Ch05.microRawInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1091)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroInvariant · unnumbered_claim · 印刷p.193 / PDFp.214

### 2. 原文陈述

> $\mu(\mathcal F_t(\mathcal M))=\mu(\mathcal M)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem microInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.microMeasure H c) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。 | [EXTRA] |

[EXTRA] [EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS（按已明示的归一化变体及跨条目映射审校）。当前声明的对象确为 microMeasure，并未冒称其定义就是原页 μ。正有限的总质量使这一变体与 raw 不变性相容；原页 raw 的像集合等式已经由本批第1条 microRawInvariant 完整保留。MeasurePreserving 虽按逆像表述，在此光滑可逆全流下不会丢失原书的像集合含义。

### 7. 状态与证明位置

incomplete；`MD.Ch05.microInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1101)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroPartition · definition · 印刷p.193 / PDFp.214

### 2. 原文陈述

> The invariant measure of the whole level set $\Sigma_E$ is defined as the microcanonical partition function $Z_E=\mu(\Sigma_E)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := ((MolecularDynamics.Chapter05Review.microRaw H c) univ).toReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microPartition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS（有限质量的实值实现）。原注释已经明确 ENNReal 转实只在有限总质量时适用，因此这里没有把 ∞ 解释成有限配分函数。univ 与能级的差别由 raw 测度受限于能级解释。定义本身允许任意 H,c，是一个总化函数；审校通过不包含“所有能级的 Z_E 都有限”的额外结论。概率用途还需正质量，见第9、10条。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microPartition`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1109)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellPointValuePrinted · notation · 印刷p.191 / PDFp.212

### 2. 原文陈述

> The proof that (5.8) can be taken and that
> \[\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega=\rho_0(q,p)=Z_{H=E}^{-1}\int_D\phi(q,p)\delta[H(q,p)-E]d\omega\]
> may be found in the PhD thesis of Hartmann [171, Appendix D].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellWeakPairing {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.microAverage H c φ



/-- 修正版，对应原文 MD-5.3.2-ShellPointValuePrinted。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def shellWeakPairing_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.microAverage H c φ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakPairing`；`MD.Ch05.shellWeakPairing_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.shellWeakPairing（853–854行）及PDF212/印刷191展示式。在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。项目定义链为shellWeakPairing H c φ=microAverage H c φ=average(microMeasure H c)φ，average μ φ=∫z,φ z ∂μ，microMeasure=(raw univ)⁻¹ • raw。故它是一个实值归一化曲面测试函数配对；标准Bochner积分不可积时取0，无测试函数或Integrable限制的def不能额外承诺其物理弱配对对所有φ都有效。本条实际没有ε、D、Z_ε、ρ_ε及Tendsto，不表达所引弱极限等式。[EXTRA]如实承认这里只给notation；这不够覆盖当前statement_scope的整条原式。原式把依赖φ的标量配对写成分布ρ₀(q,p)点值，ERRATUM判断成立；重复的Z_ε⁻¹按原印刷保留，其解释不得从本notation的类型正确性推出。此def本身无sorry，但也无待验证的弱极限定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellWeakPairing`：定义；`MD.Ch05.shellWeakPairing_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1114)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HarmonicEnergy · Example 5.1 · 印刷p.193 / PDFp.214

### 2. 原文陈述

> Example 5.1 Consider the harmonic oscillator $H(q,p)=p^2/2+\Omega^2q^2/2$. The energy surface $H=E>0$ is an ellipse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def harmonicEnergy (Ω : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) := (z 1)^2/2+Ω^2*(z 0)^2/2

theorem harmonicEnergy_ellipse (Ω c : ℝ) (_hΩ : Ω ≠ 0) (_hc : 0 < c)
    (z : MolecularDynamics.Chapter05Review.E 2) :
    harmonicEnergy Ω z=c ↔
      (z 0/(Real.sqrt (2*c)/|Ω|))^2+(z 1/Real.sqrt (2*c))^2=1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicEnergy`；`MD.Ch05.harmonicEnergy_ellipse` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。 | [EXTRA] |

[EXTRA] [EXTRA] 补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。能量定义和椭圆等价式均忠实；|Ω| 正确处理负的形式参数。Ω=0 会退化，原文的 oscillator 语境及已有 [EXTRA] 已将其排除在椭圆断言的适用范围之外，没有静默改写原句。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicEnergy`：定义；`MD.Ch05.harmonicEnergy_ellipse`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1125)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HarmonicQuadraturePrinted · unnumbered_claim · 印刷p.193 / PDFp.214

### 2. 原文陈述

> Parameterizing the surface by $q$, we have $p=\sqrt{2E-\Omega^2q^2}$, then
> \[\mu(\Sigma_E)=4\int_0^{\sqrt{2E}}\frac{\sqrt{1+p_q^2}}{\sqrt{H_p^2+H_q^2}}dq
> =4\int_0^{\sqrt{2E}/\Omega}\frac{\sqrt{1+\frac{\Omega^4q^2}{2E-\Omega^2q^2}}}{\sqrt{p^2+\Omega^4q^2}}dq
> =4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem harmonicQuadraturePrinted : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c),
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-HarmonicQuadraturePrinted。改动：首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。 -/
```

独立修正版：

```lean
theorem harmonicQuadraturePrinted_corrected : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicQuadraturePrinted`；`MD.Ch05.harmonicQuadraturePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。 | [EXTRA] |

[EXTRA] [EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。；[ERRATUM?] 首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按补充规则，Mathlib v4.34.0 的 EuclideanSpace、volume、gradient、Hausdorff 测度、restrict、withDensity、ENNReal.ofReal、toReal、实平方根、实数幂、Gamma 和区间 Bochner 积分均直接采用标准数学含义，不要求在 Ch05_deps.txt 查找其定义体。只对项目自定义逐层展开；判断签名是否覆盖本 source_id 的全部原文结论，与是否存在 sorry 分开。 PDF214/印刷193的第一积分上界确为√(2E)，后两项为√(2E)/Ω。附件签名量化所有Ω,c>0，将图形上的p_q²展开为(Ω²q/√(2c−Ω²q²))²，将H_p²+H_q²展开为2c−Ω²q²+Ω⁴q²；这些在实图形内部正确，但不同上界的两积分一般不等。[EXTRA]正c在原页已有，正Ω为合理频率约定且排除退化；端点总化只修改零测点，不能修复区间长度的差异。原书首上界应为√(2E)/Ω的疑误可由下述反例确认；未静默修改原书。所引完整链的μ(Σ_E)及2π/Ω还没有出现在本签名中。失败依据是假命题和缺失子句，并非Mathlib定义缺失；该theorem的sorry仅说明证明尚未完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicQuadraturePrinted`：未证（原书疑误不证）；`MD.Ch05.harmonicQuadraturePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1136)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HarmonicPartition · Example 5.1 · 印刷p.193 / PDFp.214

### 2. 原文陈述

> $\mu(\Sigma_E)=4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega$.

### 3. 原文证明

原书无独立完整证明。
> The partition function is obtained by integrating in the standard way. Parameterizing the surface by $q$, we have $p=\sqrt{2E-\Omega^2q^2}$, then
> \[\begin{aligned}\mu(\Sigma_E)&=4\int_0^{\sqrt{2E}}\frac{\sqrt{1+p_q^2}}{\sqrt{H_p^2+H_q^2}}\,dq\\&=4\int_0^{\sqrt{2E}/\Omega}\frac{\sqrt{1+\frac{\Omega^4q^2}{2E-\Omega^2q^2}}}{\sqrt{p^2+\Omega^4q^2}}\,dq\\&=4\int_0^{\sqrt{2E}/\Omega}\frac{1}{\sqrt{2E-\Omega^2q^2}}\,dq\\&=2\pi/\Omega.\end{aligned}\]
原页给出 Example 5.1 的参数积分计算，未另设命题证明；首个参数积分上限有原印疑点，保留待人工确认。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem harmonicPartition : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω := by
  sorry

theorem harmonicPartition_quadrature (Ω c : ℝ) (_hΩ : 0 < Ω) (_hc : 0 < c) :
    MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=
      4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) ∧
    4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2))=2*Real.pi/Ω := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-HarmonicPartition。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem harmonicPartition_corrected : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicPartition`；`MD.Ch05.harmonicPartition_quadrature`；`MD.Ch05.harmonicPartition_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。；[EXTRA] 保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；NEEDS_HUMAN 是原页推导疑误的分流，不是因 sorry 或因当前两个签名错误。两条 Lean 签名在 Ω,c>0 下均通过；quadrature 实现原印后两行的正确积分。原印第一行另有不一致上限，不能用这两条签名声称整段印刷推导已经逐字正确。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicPartition`：未证（原书疑误不证）；`MD.Ch05.harmonicPartition_quadrature`：未证（原书疑误不证）；`MD.Ch05.harmonicPartition_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1159)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-IdealGasEnergy · Example 5.2 · 印刷p.193 / PDFp.214

### 2. 原文陈述

> Example 5.2 Consider a system of $N$ non-interacting particles of mass $m$ moving in periodic boundary conditions within a box of volume $V$. The Hamiltonian is
> \[H=\frac1{2m}\sum_{i=1}^N\|p_i\|^2.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def idealGasEnergy (N : ℕ) (m : ℝ) (z : MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  (∑ i : Fin (3*N),(z (Fin.natAdd (3*N) i))^2)/(2*m)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.idealGasEnergy` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。周期边界不影响局部动能公式，展平坐标没有改变粒子数或质量因子。定义在所有形式参数上的总化扩展不产生质量为0时的物理断言；后续配分函数明确要求 N,m,c,L>0。

### 7. 状态与证明位置

self-contained；`MD.Ch05.idealGasEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1181)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-IdealGasPositionDomain · definition · 印刷p.193–194 / PDFp.214–215

### 2. 原文陈述

> $Z_E=V^N\int_{\mathcal S}(m/r)d\sigma$, where $\mathcal S$ is the $3N-1$ dimensional sphere in $3N$ dimensions of radius $r=\sqrt{2mE}$, and $d\sigma$ is the surface area element on this sphere. $V^N$ is the contribution due to integration over positions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.idealGasPositionDomain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。 | [EXTRA] |

[EXTRA] [EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS（仅按已明示的辅助域范围）。此定义没有单独证明原文球面积分公式，也没有声称原文逐点定义了闭胞；statement_scope 和 [EXTRA] 已明确将剩余原文映射到第8条。该映射在本批可核对：idealGasPartition_factors 给出同一半径球面、(L³)^N 因子和真实 raw 曲面质量的积分分解。因映射明确且实际存在，不以辅助定义替代整段原文。

### 7. 状态与证明位置

self-contained；`MD.Ch05.idealGasPositionDomain`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1187)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-IdealGasPartition · Example 5.2 · 印刷p.194 / PDFp.215

### 2. 原文陈述

> Thus we have
> \[Z_E=V^N\frac{m}{\sqrt{2mE}}A(\mathcal S)
> =V^N\frac{\sqrt m}{\sqrt{2E}}\frac{3N\pi^{3N/2}(2mE)^{(3N-1)/2}}{\Gamma(3N/2+1)}
> =V^N\frac{(2\pi mE)^{3N/2}}{E\Gamma(3N/2)}.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem idealGasPartition : ∀ (N : ℕ) (m c L : ℝ),0 < N → 0 < m → 0 < c → 0 < L →
  ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal=
    (L^3)^N*Real.rpow (2*Real.pi*m*c) ((3*N : ℝ)/2)/(c*Real.Gamma ((3*N : ℝ)/2)) := by
  sorry

theorem idealGasPartition_factors (N : ℕ) (m c L : ℝ)
    (_hN : 0 < N) (_hm : 0 < m) (_hc : 0 < c) (_hL : 0 < L) :
    let S := Metric.sphere (0 : MolecularDynamics.Chapter05Review.E (3*N)) (Real.sqrt (2*m*c))
    let A := (MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1) S).toReal
    let Z := ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal
    Z=(L^3)^N*(∫ p in S,m/Real.sqrt (2*m*c)
      ∂(MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1))) ∧
    Z=(L^3)^N*(m/Real.sqrt (2*m*c))*A ∧
    Z=(L^3)^N*(Real.sqrt m/Real.sqrt (2*c))*
      ((3*N : ℝ)*Real.rpow Real.pi ((3*N : ℝ)/2)*Real.rpow (2*m*c) (((3*N : ℝ)-1)/2)/
      Real.Gamma ((3*N : ℝ)/2+1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.idealGasPartition`；`MD.Ch05.idealGasPartition_factors` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。 | [EXTRA] |

[EXTRA] [EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。；[EXTRA] 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。对象、全部前提和各步结论吻合；位置体积(L³)^N、球面半径及其面积系数都保留。3N·π^(3N/2)/Γ(3N/2+1) 是正确球面积系数，代入梯度权重得到所列最终式。[EXTRA] 未把因子分解结论作为假设，也未用参数积分定义 microRaw。有限基本胞是明确且合理的实现范围。

### 7. 状态与证明位置

incomplete；`MD.Ch05.idealGasPartition`：未证（缺大型理论）；`MD.Ch05.idealGasPartition_factors`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1193)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-MicroMeasure · definition · 印刷p.194 / PDFp.215

### 2. 原文陈述

> Let $d\mu_E=Z_E^{-1}\|\nabla H\|^{-1}d\sigma$. We refer to this as the microcanonical probability density and write, for an “appropriate” set $\mathcal A$, $\operatorname{Pr}(\mathcal A)=\mu_E(\mathcal A)=\int_{\mathcal A} d\mu_E$. The only requirement for this to make sense is that the set $\mathcal A$ be a measurable subset of the $H=E$ energy surface, i.e. that it be possible to compute its surface area.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c



/-- 修正版，对应原文 MD-5.3.3-MicroMeasure。改动：归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。 -/
```

独立修正版：

```lean
def microMeasure_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (_hpos : 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ)
    (_hfinite : (MolecularDynamics.Chapter05Review.microRaw H c) univ < ⊤) :
    Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microMeasure`；`MD.Ch05.microMeasure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]总raw质量正且有限是使用概率意义的必要资格；定义用实际ENNReal标量归一化，不把无穷总质量逆值0解释成概率测度。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。 | [EXTRA] |

[EXTRA] [EXTRA]总raw质量正且有限是使用概率意义的必要资格；定义用实际ENNReal标量归一化，不把无穷总质量逆值0解释成概率测度。；[ERRATUM?] 归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；NEEDS_HUMAN 针对原书“唯一要求”及可测性解释的资格问题。Lean 定义作为一个总化测度通过签名审校，[EXTRA] 也正确声明了概率解释必须有正有限 raw 总质量；不能因此把原书未写出的条件说成已在原句中出现。当前定义的每个值都是测度，而它成为概率测度的范围由第10条严格规定。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microMeasure`：定义；`MD.Ch05.microMeasure_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1214)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-MicroProbability · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We have the standard properties of a probability function: $0\leq\operatorname{Pr}(\mathcal A)\leq1$ for all measurable sets $\mathcal A$; $\operatorname{Pr}(\Sigma_E)=1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem microProbability : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 1 H → 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ → (MolecularDynamics.Chapter05Review.microRaw H c) univ < (⊤ : ENNReal) →
  (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 ∧
    (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.energySurface H c)=1 ∧
    ∀ A : Set (MolecularDynamics.Chapter05Review.E n),0 ≤ (MolecularDynamics.Chapter05Review.microMeasure H c) A ∧ (MolecularDynamics.Chapter05Review.microMeasure H c) A ≤ 1 := by
  intro n H c hH hpos hfin
  let σ := MolecularDynamics.Chapter05Review.energySurface H c
  have hσ : MeasurableSet σ := by
    exact (isClosed_eq hH.continuous continuous_const).measurableSet
  have hzero : (MolecularDynamics.Chapter05Review.microRaw H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microRaw
    apply withDensity_absolutelyContinuous
    unfold MolecularDynamics.Chapter05Review.surfaceMeasure
    rw [Measure.restrict_apply hσ.compl]
    simp [σ]
  have hu : (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,smul_eq_mul]
    exact ENNReal.inv_mul_cancel (ne_of_gt hpos) (ne_of_lt hfin)
  have hz : (MolecularDynamics.Chapter05Review.microMeasure H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,hzero,smul_zero]
  refine ⟨hu,?_,?_⟩
  · have hh := measure_add_measure_compl hσ (μ:=MolecularDynamics.Chapter05Review.microMeasure H c)
    simpa only [hz,add_zero,hu] using hh
  · intro A
    exact ⟨bot_le,(measure_mono (subset_univ A)).trans_eq hu⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原H光滑背景及正有限总质量明示；ΣE总概率1也保留，不仅证明ambient univ质量1。 | [EXTRA] |

[EXTRA] [EXTRA]原H光滑背景及正有限总质量明示；ΣE总概率1也保留，不仅证明ambient univ质量1。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。两个正有限质量前提保证逆标量合法，闭能级及支持性质保证能级本身的质量为1。Measure 的集合函数对所有集合按外测度取值，因此把界限推广到任意 A 是正确加强，包含原文所有可测子集。[EXTRA] 完整登记了这些资格；没有靠缺失的证明将签名判为失败。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microProbability`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1228)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-LowerDimensionNull · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We also note that lower order objects such as a point or a curve in $\mathbb R^2$, or a surface in $\mathbb R^3$, have zero measure with respect to Lebesgue measure for the ambient space. Similarly, for a Hamiltonian system with $N_d$ degrees of freedom, the energy surface is of dimension $2N_d-1$ and the probability measure of sets of lower dimension than this will vanish.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lowerDimensionNull :
  ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : Set (MolecularDynamics.Chapter05Review.E d)), d+1 < n → ContDiff ℝ 1 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
    ContDiff ℝ 1 g → IsCompact K →
    g '' K ⊆ MolecularDynamics.Chapter05Review.energySurface H c → (MolecularDynamics.Chapter05Review.microMeasure H c) (g '' K)=0 := by
  sorry

theorem lowerDimensionNull_countable (n d : ℕ)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d+1 < n)
    (_hH : ContDiff ℝ 1 H)
    (_hreg : ∀ z,MolecularDynamics.Chapter05Review.energySurface H c z →
      MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (_hblocks : ∀ k,ContDiff ℝ 1 (g k) ∧ IsCompact (K k) ∧
      g k '' K k ⊆ MolecularDynamics.Chapter05Review.energySurface H c) :
    (MolecularDynamics.Chapter05Review.microMeasure H c) (⋃ k,g k '' K k)=0 ∧
      volume (⋃ k,g k '' K k)=0 := by
  sorry

theorem lowerDimensionNull_level_dimension (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 1 H)
    (c : ℝ) (_hreg : ∀ z,H z=c → MolecularDynamics.Chapter05Review.grad H z ≠ 0) :
    ∀ z,H z=c → ∃ U : Set (MolecularDynamics.Chapter05Review.E n),
      IsOpen U ∧ z ∈ U ∧ ∃ V : Set (MolecularDynamics.Chapter05Review.E (n-1)),
      IsOpen V ∧ Nonempty (V ≃ₜ ↥(MolecularDynamics.Chapter05Review.energySurface H c ∩ U)) := by
  sorry
```

独立修正版：

```lean
theorem lowerDimensionNull_ambient_corrected (n d : ℕ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d < n)
    (_hblocks : ∀ k, ContDiff ℝ 1 (g k) ∧ IsCompact (K k)) :
    volume (⋃ k, g k '' K k) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lowerDimensionNull`；`MD.Ch05.lowerDimensionNull_countable`；`MD.Ch05.lowerDimensionNull_level_dimension`；`MD.Ch05.lowerDimensionNull_ambient_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]低维光滑参数化的紧像、正则C¹能量面，维数严格小于能量面；未将任意“拓扑低维集合”自动视为零测。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N_d）。环境Lebesgue零测也在本批同列。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。 | [EXTRA] |

[EXTRA] [EXTRA]低维光滑参数化的紧像、正则C¹能量面，维数严格小于能量面；未将任意“拓扑低维集合”自动视为零测。；[EXTRA] 保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N_d）。环境Lebesgue零测也在本批同列。；[EXTRA] 保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。；[ERRATUM?] 本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。

### 6. 审计结论

本轮修复：保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；FAIL（整条原文的完整覆盖），同时原书的未限定维数语言需人工确认。三个现有 Lean 声明本身均数学正确，且第二条确有环境 volume=0；但这只覆盖位于能级且 d<n−1 的集合，不能冒称原文第一句的一般环境低维零测已覆盖。n=2,d=1 的曲线及 n=3,d=2 的曲面都不满足其严格维数前提，而它们恰是原文列举对象。第二句的正则能级、光滑低维零测已有合理受限实现；该部分通过不能补上第一句的缺口。

### 7. 状态与证明位置

incomplete；`MD.Ch05.lowerDimensionNull`：未证（原书疑误不证）；`MD.Ch05.lowerDimensionNull_countable`：未证（原书疑误不证）；`MD.Ch05.lowerDimensionNull_level_dimension`：未证（原书疑误不证）；`MD.Ch05.lowerDimensionNull_ambient_corrected`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1260)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-MicroAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> As we mentioned in motivating the microcanonical distribution, we could alternatively view microcanonical averages as integrals with respect to the singular measure on the ambient space $\mathcal D$ defined by $\rho'_Ed\omega=Z_E^{-1}\delta[H-E]d\omega$, where $\delta$ represents the Dirac delta function. The notation $d\omega$ represents the volume element in the Euclidean space defined by all coordinates and momenta. This is the more common definition of the microcanonical distribution encountered in physics treatments.
> 
> Regardless of which formulation is adopted, we may use the probability measure to compute expectations (averages) of (suitable) functions defined on the phase space. We write such an expectation as
> \[\operatorname{Av}_{H=E}(g)=\int_{\Sigma_E}g(z)d\mu_E=\int_{\mathcal D}g(z)\rho'_Ed\omega.\]
> Incidentally, any such function is referred to as an observable function (or, simply, an observable) of the system in this context.
> 
> As shorthand, where the underlying space and probability density are assumed, one may write such an average more simply as $\operatorname{Av}_{H=E}(g)=\langle g\rangle$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g

theorem microAverage_surface_and_delta_limit (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 2 H)
    (c : ℝ) (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hband : ∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧
      ∀ z,|H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hφ : ContDiff ℝ ∞ φ)
    (_hc : HasCompactSupport φ) :
    microAverage H c φ=(MolecularDynamics.Chapter05Review.microPartition H c)⁻¹*
      (∫ z in MolecularDynamics.Chapter05Review.energySurface H c,
        φ z/‖MolecularDynamics.Chapter05Review.grad H z‖
        ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))) ∧
    Tendsto (fun ε : ℝ ↦
      (∫ z in {z | |H z-c| < ε},φ z)/
      (volume {z | |H z-c| < ε}).toReal) (𝓝[>] 0) (𝓝 (microAverage H c φ)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microAverage`；`MD.Ch05.microAverage_surface_and_delta_limit` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。 | [EXTRA] |

[EXTRA] [EXTRA] 补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对象为 n 维实欧氏空间，H,c,g 的类型正确；average 是实际 Bochner 积分，microRaw 是能量面上归一化 Hausdorff 面积的逆梯度密度，microMeasure 用总质量归一化，并非把 Dirac δ 当普通函数。定义在任意 H,c 上总化；只有正有限总质量时才解释为概率平均。附加定理明确 n>0、H∈C²、非空紧正则能量面及正有限原始质量，并进一步要求整个闭能量带紧且无临界点；φ 为全局 C∞ 紧支撑函数。完整结论既有曲面积分等式，也有正 ε 趋零的真实体积薄壳积分比极限。紧正则能量带足以排除远端薄壳质量，归一化使分子分母的 2ε 因子抵消；签名合理。该定理只覆盖所列测试函数，不宣称所有可测 g 都有 δ 配对极限。未检查或补写 sorry 证明。

### 7. 状态与证明位置

incomplete；`MD.Ch05.microAverage`：定义；`MD.Ch05.microAverage_surface_and_delta_limit`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1298)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-AmbientLowerDimensionNull · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We also note that lower order objects such as a point or a curve in $\mathbb R^2$, or a surface in $\mathbb R^3$, have zero measure with respect to Lebesgue measure for the ambient space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ambientLowerDimensionNull : ∀ n d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n) (K : Set (MolecularDynamics.Chapter05Review.E d)),
  d < n → ContDiff ℝ 1 g → IsCompact K → volume (g '' K)=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ambientLowerDimensionNull` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。 | [EXTRA] |

[EXTRA] [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准数学含义，不要求在项目依赖摘录中提供Mathlib定义体。已展开项目E（Ch05_deps.txt中MolecularDynamics/Chapter05/ReviewDefinitions.lean行5315）：E n=EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ；volume按标准含义为其Lebesgue测度，无需项目摘录另供定义体。Ch05.lean行938–939依次量化任意n,d,C¹映射g:ℝᵈ→ℝⁿ及紧K⊆ℝᵈ，并在d<n时断言volume(g''K)=0；对象、量词、维数比较及实际ambient零测结论正确。PDF第216页（印刷195页）点、ℝ²中的曲线、ℝ³中的曲面分别有d=0、(d,n)=(1,2)、(2,3)的光滑参数块模型。[EXTRA]C¹参数化紧像已明确披露，是通常光滑低维对象的合理局部形式；C¹提供局部Lipschitz性质，紧性有利于有限局部覆盖，并非零测所必需。一般光滑曲线或曲面可通过可数紧参数块/局部图覆盖归约，原文无限对象不会因局部块形式而被解释成高维对象。不扩张为任意连续曲线或任意拓扑低维集合的断言。无[ERRATUM?]。证明体含sorry，但签名的语义PASS与证明完成度分开；未运行编译。

### 7. 状态与证明位置

incomplete；`MD.Ch05.ambientLowerDimensionNull`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1318)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-TimeAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> Given an autonomous system of differential equations $\dot z=f(z)$ in $\mathbb R^m$, and a trajectory $\Gamma=\{z(t)\mid t\in[0,\infty]\}$, let $g=g(z)$ be any smooth scalar valued function of $z$ (an observable) and define (assuming it exists) the infinite time average of $g$ along $\Gamma$ by
> \[\bar g_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau g(z(t))dt.\tag{5.9}\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.timeAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；X 是任意类型，z:ℝ→X，g:X→ℝ，T:ℝ；定义恰为 T⁻¹ 乘 0..T 的真实有向区间积分。按明确 statement_scope 本条仅承担有限截断因子，无限极限由下一条承担，未把有限值冒充无限平均。任意路径和函数是公式层面的自然推广；原书光滑正向轨道是其适用特例。T=0 或不可积函数的 Lean 总化值不赋予原书平均意义，负 T 仅属定义延拓。

### 7. 状态与证明位置

self-contained；`MD.Ch05.timeAverage`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1324)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-HasTimeAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> define (assuming it exists) the infinite time average of $g$ along $\Gamma$ by $\bar g_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau g(z(t))dt$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hasTimeAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 X,z,g 及候选实数 a，以 Tendsto (timeAverage z g) atTop (𝓝 a) 表达式(5.9)。使用的是摘录的 Chapter05Review.timeAverage，即真实 0..T 区间积分。a 是平均值参数，并未假设每个可观测量都有极限。atTop 的最终正时间使负时延拓和 T=0 不影响结论；原文的轨道及光滑性背景不被误写成极限自动存在的定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.hasTimeAverage`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1327)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-ConservedAverage · unnumbered_claim · 印刷p.196–197 / PDFp.217–218

### 2. 原文陈述

> Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $I=I(z)$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conservedAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : MolecularDynamics.Chapter05Review.timeAverage z g T=a := by
  apply MolecularDynamics.Chapter05Review.conservedAverage_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.conservedAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀X,z,g,a，前提 ∀t∈ℝ,g(z t)=a，结论对每个非零实数 T 为有限时间平均=a。任意负 T 的有向积分也满足该恒等式；T≠0 必须保留，因为 T=0 时总化平均为0。此条按 scope 是守恒观测量的有限平均辅助引理；原文第一积分及其函数的无限时间结论映射至下一条，并非遗漏后仍宣称完成全部原文结论。比正时间轨道更强的全实时间守恒前提是明确延拓，实际第一积分满足。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.conservedAverage`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1333)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-ConservedInfiniteAverage · unnumbered_claim · 印刷p.196–197 / PDFp.217–218

### 2. 原文陈述

> Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $I=I(z)$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conservedInfiniteAverage {X : Type*} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  MolecularDynamics.Chapter05Review.hasTimeAverage z I (I (z 0)) ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z (r ∘ I) (r (I (z 0))) := by
  have hm (g : X → ℝ) (hg : ∀ t,g (z t)=g (z 0)) :
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) := by
    apply tendsto_congr' _ |>.2 tendsto_const_nhds
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    exact MolecularDynamics.Chapter05Review.conservedAverage_proved z g (g (z 0)) hg T (ne_of_gt hT)
  exact ⟨hm I hI,hm (r ∘ I) (fun t => by simp only [Function.comp_apply,hI])⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.conservedInfiniteAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀X,z,I,r，hI 要求每个实时间的 I(z t)=I(z 0)。完整合取分别给出 I 的无限平均 I(z 0)，以及任意函数 r∘I 的无限平均 r(I(z 0))。不需 r 连续或可测，因为沿此轨道两个被积函数都恒定；不存在把“复合量有平均”作为前提的问题。结果准确表达平均由初值的积分值决定，不承诺不同初值一定产生不同平均；例如常值 r 的平均可以相同。

### 7. 状态与证明位置

self-contained；`MD.Ch05.conservedInfiniteAverage`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1338)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellEnergy · Example 5.3 · 印刷p.196 / PDFp.217

### 2. 原文陈述

> Example 5.3 Consider the double well potential $\phi(q)=(1-q^2)^2$. The energy $H(q,p)=p^2/2+\phi(q)$ will tend to $+\infty$ as $q\to\infty$ or $p\to\infty$, but is obviously bounded below (by zero).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E 2 是 Fin 2 上的实欧氏空间，z 0 对应 q、z 1 对应 p；定义严格为 p²/2+(1−q²)²。仅按 scope 核对公式定义：原文非负及趋于无穷的断言未包含于此定义，其映射的 DoubleWellCoercivity 不在本任务提供的声明中，因此不声称本次已核对该外部条目。定义对所有 z 总化，实数平方和不会引入额外域限制。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1351)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellCoercivity · unnumbered_claim · 印刷p.196 / PDFp.217

### 2. 原文陈述

> The energy $H(q,p)=p^2/2+(1-q^2)^2$ will tend to $+\infty$ as $q\to\infty$ or $p\to\infty$, but is obviously bounded below (by zero).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellCoercivity : (∀ z : MolecularDynamics.Chapter05Review.E 2,0 ≤ doubleWellEnergy z) ∧
  ∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} := by
  constructor
  · intro z
    unfold doubleWellEnergy
    positivity
  · intro c
    have hc : Continuous (doubleWellEnergy) := by unfold doubleWellEnergy; fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|+4)).of_isClosed_subset hclosed
    intro z hz
    have he : (z 1)^2/2+(1-(z 0)^2)^2 ≤ c := hz
    have hpos : 0 ≤ c := by nlinarith [sq_nonneg (z 1),sq_nonneg (1-(z 0)^2)]
    have hq : (z 0)^2 ≤ (c+3)/2 := by
      nlinarith [sq_nonneg (z 1),sq_nonneg ((z 0)^2-2)]
    have hp : (z 1)^2 ≤ 2*c := by nlinarith [sq_nonneg (1-(z 0)^2)]
    have hnorm : ‖z‖^2=(z 0)^2+(z 1)^2 := by
      rw [EuclideanSpace.norm_sq_eq]
      simp [Fin.sum_univ_two,Real.norm_eq_abs]
    rw [Metric.mem_closedBall,dist_zero_right,abs_of_nonneg hpos]
    nlinarith [norm_nonneg z]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellCoercivity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。 | [EXTRA] |

[EXTRA] [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义，不要求 Ch05_deps.txt 提供 Mathlib 定义体。项目依赖 MolecularDynamics/Chapter05/ReviewDefinitions.lean（Ch05_deps.txt 第5315行）展开 E n=EuclideanSpace ℝ (Fin n)，按标准含义是具有欧氏内积与拓扑的 ℝⁿ；Blueprint/Ch05.lean 第968行的 MD.Ch05.doubleWellEnergy 展开为 p²/2+(1-q²)²，其中 q=z 0、p=z 1。 Blueprint/Ch05.lean 第972–993行结论为(∀z,0≤H(z))与(∀c∈ℝ,{z|H(z)≤c}紧)的合取。IsCompact 按标准欧氏紧性理解；能量为连续多项式，其闭下水平集在有限维空间紧，等价于通常的强制性，涵盖原文 q→+∞ 或 p→+∞ 时 H→+∞（另一坐标固定或任意变化），并合理推广到任意坐标逃逸。c<0 时下水平集为空，紧性仍成立，无能级遗漏。[EXTRA]实际是性质的等价表达说明，而非签名中的附加前提；没有给一般势函数添加未经论证的强制性。两个原文结论均被表达，无[ERRATUM?]。证明状态单独记录：本条实际正文未出现 sorry/admit；仅做只读语义审计，未运行 Lean 编译，也未核验整个项目的公理依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellCoercivity`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1355)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellDisconnected · Example 5.3 · 印刷p.196 / PDFp.217

### 2. 原文陈述

> From the graph it is clear that the energy surface $H(q,p)=E$ has more than one component if $0<E<1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellDisconnected : ∀ c ∈ Ioo (0 : ℝ) 1,
  ¬IsPreconnected (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by
  intro c hc hS
  let a : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![-1,Real.sqrt (2*c)]
  let b : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![1,Real.sqrt (2*c)]
  have hsqrt : (Real.sqrt (2*c))^2=2*c := Real.sq_sqrt (by linarith [hc.1])
  have ha : a ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(-1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hb : b ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hq : ContinuousOn (fun z : MolecularDynamics.Chapter05Review.E 2 => z 0)
      (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by fun_prop
  have hzero : (0 : ℝ) ∈ Icc (a 0) (b 0) := by norm_num [a,b]
  obtain ⟨z,hz,hz0⟩ := hS.intermediate_value ha hb hq hzero
  change doubleWellEnergy z=c at hz
  unfold doubleWellEnergy at hz
  change z 0=0 at hz0
  rw [hz0] at hz
  nlinarith [sq_nonneg (z 1),hc.2]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellDisconnected` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义，不要求 Ch05_deps.txt 提供 Mathlib 定义体。项目依赖 MolecularDynamics/Chapter05/ReviewDefinitions.lean（Ch05_deps.txt 第5315行）展开 E n=EuclideanSpace ℝ (Fin n)，按标准含义是具有欧氏内积与拓扑的 ℝⁿ；Blueprint/Ch05.lean 第968行的 MD.Ch05.doubleWellEnergy 展开为 p²/2+(1-q²)²，其中 q=z 0、p=z 1。 项目依赖 ReviewDefinitions.lean 第5355行展开 energySurface H c={z|H(z)=c}。Blueprint/Ch05.lean 第996–1015行量词 ∀c∈Ioo 0 1 正是对所有0<c<1。标准 ¬IsPreconnected 表达该能级作为拓扑子空间不连通；这里能级非空（例如 q=±1,p=√(2c)），因而与原文“more than one component”一致，不依赖空集约定。q=0 时 H=p²/2+1≥1，且能级同时含 q<0 和 q>0 两侧点，断开对象确实是整个能量面，并非投影或子集。无额外前提、无[EXTRA]/[ERRATUM?]。标准连通定义直接采信，不因依赖摘录不含其 Mathlib 定义体而降级。证明状态单独记录：本条实际正文未出现 sorry/admit；仅做只读语义审计，未运行 Lean 编译，也未核验整个项目的公理依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellDisconnected`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1379)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellBasin · unnumbered_claim · 印刷p.196 / PDFp.217

### 2. 原文陈述

> If an initial condition is taken from one of the two basins, say with energy $E_0$, then the trajectory through that point will remain forever in the one basin, thus the averages of many quantities, if computed using the trajectory values, would not be a good approximation of the overall average at constant energy $E_0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellBasin : ∀ (z : ℝ → MolecularDynamics.Chapter05Review.E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0) := by
  intro z c hz hc hE t
  let q (s : ℝ) := (z s) 0
  have hq : Continuous q := by dsimp [q]; fun_prop
  have hn (s : ℝ) : q s ≠ 0 := by
    intro heq
    have hh := hE s
    unfold doubleWellEnergy at hh
    change (z s) 0=0 at heq
    rw [heq] at hh
    nlinarith [sq_nonneg ((z s) 1),hc.2]
  by_cases h0 : 0 < q 0
  · left
    refine ⟨h0,?_⟩
    by_contra ht
    have hneg : q t < 0 := lt_of_le_of_ne (le_of_not_gt ht) (hn t)
    obtain ⟨s,hs⟩ := intermediate_value_univ t 0 hq (show (0 : ℝ) ∈ Icc (q t) (q 0) from ⟨hneg.le,h0.le⟩)
    exact hn s hs
  · right
    have hneg : q 0 < 0 := lt_of_le_of_ne (le_of_not_gt h0) (hn 0)
    refine ⟨hneg,?_⟩
    by_contra ht
    have hpos : 0 < q t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm (hn t))
    obtain ⟨s,hs⟩ := intermediate_value_univ 0 t hq (show (0 : ℝ) ∈ Icc (q 0) (q t) from ⟨hneg.le,hpos.le⟩)
    exact hn s hs

theorem doubleWellBasin_average_witness (c : ℝ) (_hc : c ∈ Ioo (0 : ℝ) 1)
    (z : ℝ → MolecularDynamics.Chapter05Review.E 2) (_hz : Continuous z)
    (_hE : ∀ t,doubleWellEnergy (z t)=c) :
    ∃ g : MolecularDynamics.Chapter05Review.E 2 → ℝ,ContDiff ℝ ∞ g ∧ HasCompactSupport g ∧
      (∀ x,doubleWellEnergy x=c → g x=if 0 < x 0 then (1 : ℝ) else 0) ∧
      MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g=1/2 ∧
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) ∧
      g (z 0) ≠ MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellBasin`；`MD.Ch05.doubleWellBasin_average_witness` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。 | [EXTRA] |

[EXTRA] [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。；[EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；第一条声明量化所有连续实时间路径与 0<c<1 的守恒能量，结论对所有 t 同时保留初值及当前值的同一严格正号或同一严格负号。q=0 时能量≥1，故连续路径不能穿越，两阱结论完整。第二条声明在同样前提下存在全局 C∞ 紧支撑实值 g，在整个能量面上等于右阱的0/1分支值，且真实 microAverage=1/2、沿指定路径有无限平均 g(z0)、该平均不等于空间平均，三个结论均未作为前提。两条紧分离能量分支允许光滑截断；q↦−q 的欧氏等距对称保持能量、面测度及梯度范数，使两个分支质量相等且正有限。故该加强见证正确，不把全局不连续示性函数说成光滑函数，也未伪造“许多”的数量或误差界。

### 7. 状态与证明位置

incomplete；`MD.Ch05.doubleWellBasin`：已证；`MD.Ch05.doubleWellBasin_average_witness`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1404)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-UniformMicroErgodic · Definition 5.1 · 印刷p.197 / PDFp.218

### 2. 原文陈述

> Definition 5.1 A Hamiltonian system is said to be ergodic on an energy surface $\Sigma_E$ (microcanonically ergodic) if, for almost all trajectories $\Gamma$ emanating from initial conditions on $\Sigma_E$, and for any observable $g$, the following holds $\bar g_\Gamma=\operatorname{Av}_{H=E}(g)$, where $\bar g_\Gamma$ is defined in (5.9). By “almost all” we mean that there could be a low-dimensional subset for which the trajectory averages fail to equal the space averages.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)



/-- 修正版，对应原文 MD-5.4.1-UniformMicroErgodic。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def uniformMicroErgodic_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.uniformMicroErgodic`；`MD.Ch05.uniformMicroErgodic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ_E零测资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ_E零测资格。；[EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；主谓词的量词顺序准确为对 microMeasure 几乎处处 z，再对每个全局 C∞ 且该测度可积的实值 g；结论是实际无限时间平均等于实际空间平均。flow 明确零时恒等、实时间群律与逐时 ODE 导数；另有 H∈C²、全空间能量保持、非空紧正则面及正有限质量，并用常可逆反对称矩阵 J 指定 f=J∇H。这些 [EXTRA] 均在接口中，紧能量面上光滑 g 可积并不实质删去原文光滑观测量。问题在原书把 almost all 用 low-dimensional subset 解释：测度零与低维条件不能一般等同，Lean 未出现维数谓词。按通常微正则零测解释签名正确；若原文要求异常集严格低维则尚不忠实，需人工确定，不能静默裁定原书。

### 7. 状态与证明位置

self-contained；`MD.Ch05.uniformMicroErgodic`：定义；`MD.Ch05.uniformMicroErgodic_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1446)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-MicroErgodicStandard · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> for almost all trajectories $\Gamma$ emanating from initial conditions on $\Sigma_E$, and for any observable $g$, the following holds $\bar g_\Gamma=\operatorname{Av}_{H=E}(g)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)

def microErgodic_L1_alternative {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microErgodic`；`MD.Ch05.microErgodic_L1_alternative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。 | [EXTRA] |

[EXTRA] [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。；[EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主 microErgodic 与上一条共同满测集的 C∞ 版本相同，完整保留 AE z 后 ∀g 以及 flow、正则面、C²、能量保持、常非退化反对称 J 等所有参数前提。额外 microErgodic_L1_alternative 的顺序是 ∀g，Integrable g μ→AE z，允许不同 g 有不同异常集，且只要求 L¹ 而不要求光滑；该声明仅定义替代性质，不断言与主定义等价。它无 Hamiltonian/概率前提，故只能视为一般测度映射的性质，单独使用时不能保证动力系统背景；应在注释中明确。本条摘录本身没有 low-dimensional 句，故此处无该句的维数承诺。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microErgodic`：定义；`MD.Ch05.microErgodic_L1_alternative`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1476)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-FlowInvariant · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> An invariant set $\mathcal A$ of the flow is one such that $\mathcal F_t(\mathcal A)=\mathcal A$, for all $t\ne0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flowInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。 | [EXTRA] |

[EXTRA] [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。；[EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意类型 X、任意 Φ:ℝ→X→X 和 A:Set X，定义恰为 ∀t,t≠0→Φ t''A=A，使用集合像而非原像/包含关系。没有默加 t=0，也不声称任意 Φ 自动具有流律。真实流满足 Φ0=id 时，才与全时间像不变等价。旧第一条 EXTRA 声称当前实现使用全时间条件，与实际 MD 定义冲突，已仅修正文档；Lean 声明本身通过。

### 7. 状态与证明位置

self-contained；`MD.Ch05.flowInvariant`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1495)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-SetErgodic · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> Alternatively, we may say that a dynamical system as ergodic if the probability measure of any invariant set $\mathcal A$ of the flow is either 0 or 1.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.setErgodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。 | [EXTRA] |

[EXTRA] [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。；[EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；X 带可测空间，μ 为概率测度；Φ 有零时恒等、所有实 s,t 的群律和联合可测性。结论只量化可测集合 A，以实际 Chapter05Review.flowInvariant（全实时间像相等）为前提，要求 μ A=0 或 μ A=1。因 h0，全时间不变与本批 MD.flowInvariant 的 t≠0 条件等价，命名空间差异不会改变真实流上的语义。可测性限制是概率集合定义的合理明确化。签名没有 MeasurePreserving 前提，因此本次仅批准原句的0/1定义，不把它当作已证明与时间平均相等的等价定理；建立这种等价通常还需保测等背景。原书 as ergodic 的语法错误应原样保留，不属数学修正。

### 7. 状态与证明位置

self-contained；`MD.Ch05.setErgodic`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1500)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InvariantIndicator · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> Then for any trajectory starting in $\mathcal A$, we have that the average of $\chi$ along $\Gamma$ vanishes, i.e. $\bar\chi_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau\chi(z(t))dt=0$, since $\mathcal A$ is an invariant set.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem invariantIndicator {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0 := by
  apply MolecularDynamics.Chapter05Review.invariantIndicator_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.invariantIndicator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意 X,Φ,A，全时间集合像不变 h，以及 z∈A、任意实数 t；结论为 ambient 补集 Aᶜ 的常1示性函数在 Φt z 处=0。由 Φt''A=A 即有 Φt z∈A，不需可测性、可积性或 flow 群律。此沿轨道结论与原书能量面内补集示性函数一致，因为路径始终留在 A；不宣称两个示性函数在能量面外相等。scope 明确此条只给逐点辅助结论，完整无限平均另条承担。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.invariantIndicator`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1509)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InvariantIndicatorAverage · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> $\bar\chi_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau\chi(z(t))dt=0$, since $\mathcal A$ is an invariant set.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem invariantIndicatorAverage {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (hA : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) :
  MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) (Aᶜ.indicator (fun _ => (1 : ℝ))) 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.invariantIndicatorAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数为任意 X,Φ,A、全时间集合像不变 hA、初值 z∈A；完整结论是实际 hasTimeAverage (fun t=>Φ t z) (Aᶜ.indicator 1) 0，已包含 Tendsto、0..T 积分及归一化，不仅是逐点等式或有限平均。像不变性保证轨道全时刻在 A，从而被积函数恒零，故无须额外可测或连续前提。使用全时间 Chapter05Review.flowInvariant；在真实流背景下和原印 t≠0 等价。sorry 不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch05.invariantIndicatorAverage`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1515)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-ErgodicTimeEquivalence · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> If we assume the system is ergodic, we must have $\operatorname{Pr}(\Sigma_E\setminus\mathcal A)=0$, thus $\operatorname{Pr}(\mathcal A)=1$. Since, according to the definition, equality of time and space averages is allowed to fail only on a set of probability measure zero, we have that either $\operatorname{Pr}(\mathcal A)=0$ or $\operatorname{Pr}(\mathcal A)=1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ergodicTimeAverage :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_common_smooth (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n))
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hμ : IsProbabilityMeasure μ) (_hpres : ∀ t,MeasurePreserving (Φ t) μ μ)
    (_h0 : ∀ z,Φ 0 z=z) (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hΦ : Continuous (Function.uncurry Φ))
    (_hK : ∃ K : Set (MolecularDynamics.Chapter05Review.E n),IsCompact K ∧ μ Kᶜ=0) :
    (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
      ∀ᵐ z ∂μ,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
        ContDiff ℝ ∞ g → Integrable g μ →
          MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z) g
            (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_positive_invariant (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_herg : MolecularDynamics.Chapter05Review.setErgodic μ Φ)
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) :
    μ A=1 ∧ (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-ErgodicTimeEquivalence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem ergodicTimeAverage_corrected :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ergodicTimeAverage`；`MD.Ch05.ergodicTimeAverage_common_smooth`；`MD.Ch05.ergodicTimeAverage_positive_invariant`；`MD.Ch05.ergodicTimeAverage_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。；[EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；已分别核对ergodicTimeAverage、ergodicTimeAverage_common_smooth、ergodicTimeAverage_positive_invariant。E n为任意有限维实欧氏空间；第一条在概率测度、每个实时间保测、零时恒等、全实时间群律及联合可测前提下，给出严格不变可测集的0/1性质与“每个L¹实观测量各自几乎处处具有空间均值时间平均”的双向等价；积分为真实0到T区间积分，极限为T→+∞。第二条另要求联合连续及紧支撑，结论确实把AE置于所有C∞实观测量之前，这些增加的条件已经[EXTRA]公开，不能把第二条当成第一条无条件交换量词。第三条显式要求可测不变集A有正概率，结论同时包含μ(A)=1、所有实时间轨道留在A、补集指标函数的实际时间平均为0；未把这些结论作假设。三条修订/扩展签名合理。本条PASS只涉及这些明确声明，不认可原书省略正概率分支的中间推理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.ergodicTimeAverage`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_common_smooth`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_positive_invariant`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1524)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-NonergodicSet · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> If a system is not ergodic, then there will be an invariant set $\mathcal A$ whose probability measure is strictly between zero and one. The trajectories emanating from this set are unable to explore the entire energy surface and the corresponding trajectory averages will, at least for some observables, be different than the spatial average of that observable.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem nonergodicSet :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (¬MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
    ∃ A : Set (MolecularDynamics.Chapter05Review.E n),MeasurableSet A ∧ MolecularDynamics.Chapter05Review.flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1) := by
  sorry

theorem nonergodicSet_average_witness (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) (_hlt : μ A < 1) :
    (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) ∧
    MolecularDynamics.Chapter05Review.average μ (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) ≠ 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.nonergodicSet`；`MD.Ch05.nonergodicSet_average_witness` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。 | [EXTRA] |

[EXTRA] [EXTRA] 补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对nonergodicSet及nonergodicSet_average_witness。第一条对任意n、概率μ及实时间作用Φ，把非setErgodic准确展开为存在可测、严格流不变且0<μ A<1的集合；概率性保证不存在大于1或无限质量的遗漏分支。第二条对任意这样的A和实际群作用，结论逐一包含所有z∈A及所有t的轨道保持、补集实值指标的0到T时间平均趋于0，以及该指标的空间积分非0。后者由μ(Aᶜ)>0给出，与源文“至少某些观测量”相符；没有把平均不等式预先作假设。测度可集中在能量面，E n的环境空间参数化没有把μ误当Lebesgue测度。

### 7. 状态与证明位置

incomplete；`MD.Ch05.nonergodicSet`：未证（缺大型理论）；`MD.Ch05.nonergodicSet_average_witness`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1577)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-HarmonicFlow · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def harmonicFlow (Ω t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicFlow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。 | [EXTRA] |

[EXTRA] [EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；本条只有harmonicFlow定义，输入Ω,t∈ℝ和z∈E 2，输出仍为E 2；坐标顺序为(q,p)。两个分量分别为q cos(Ωt)+(p/Ω)sin(Ωt)和p cos(Ωt)−Ωq sin(Ωt)，非零频率时是单位质量振子的正确解析流，正负非零频率均适用。[EXTRA]与statement_scope已明确本条只是辅助定义，原句的能量面遍历性分配给MD-5.4.1-HarmonicErgodic，故不把这个def当成遍历定理。该外部source_id的声明未在R6给出，本次未核查其结论或证明。Ω=0处Lean除零总化得到恒等映射，不代表零频自由粒子的流；原有正频率使用限定是必要的。

### 7. 状态与证明位置

self-contained；`MD.Ch05.harmonicFlow`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1598)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-HarmonicErgodic · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem harmonicErgodic : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microErgodic (harmonicEnergy Ω) c (harmonicFlow Ω) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicErgodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。 | [EXTRA] |

[EXTRA] [EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目依赖Chapter05/ReviewDefinitions.lean实际展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z|H z=c}；grad H=gradient H；hausdorffArea d=[vol(B₁⊂Rᵈ)/2ᵈ]·HausdorffMeasure d；surfaceMeasure=(hausdorffArea(n−1)).restrict(energySurface H c)；microRaw=surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure=(microRaw univ)⁻¹·microRaw；average μ g=∫g dμ；microAverage H c g=average(microMeasure H c)g。附件本地harmonicEnergy=(p²+Ω²q²)/2，harmonicFlow是上条解析流。项目timeAverage=T⁻¹∫₀ᵀg(Φt z)dt，hasTimeAverage是该函数在atTop收敛到指定平均。microErgodic实际量词为∀g,Integrable g μ→∀ᵐz,hasTimeAverage(Φ·z)g(∫g dμ)。量词没有被误读为∀ᵐz∀g；[EXTRA]明确选取标准逐个L¹观测量版本。Ω>0排除退化频率，符号限制可由Ω↦|Ω|消除；c>0限定非退化能量曲线，在该椭圆上梯度非零，microRaw有限正，microMeasure是真概率测度。轨道覆盖整条椭圆且周期为2π/Ω；ds/‖∇H‖等于时间元，所以空间平均等于归一化周期平均。光滑观测量在所有初值上都得到该周期平均，亦符合原文共同满测集的光滑解释。或者以紧椭圆上连续函数的可数一致稠密族及一致逼近恢复共同满测集。因此量词改为标准L¹版本在此具体系统中没有导致语义反例。PASS范围为声明的正频率、正能量；不声称梯度零的零能量点也适用此microMeasure构造。证明体为sorry，故PASS仅指签名语义，不指Lean证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicErgodic`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1604)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorEnergy · Example 5.4 · 印刷p.198–199 / PDFp.219–220

### 2. 原文陈述

> Example 5.4 (2D Harmonic System) Consider a two-dimensional harmonic system, i.e. the system with Hamiltonian
> \[H=p_1^2/2+p_2^2/2+\Omega_1^2q_1^2/2+\Omega_2^2q_2^2/2;\]
> where $\Omega_1,\Omega_2$ are two nonzero parameters. Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1=p_1^2/2+\Omega_1^2q_1^2/2$ and $H_2=p_2^2/2+\Omega_2^2q_2^2/2$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；twoOscillatorEnergy的Ω:Fin 2→ℝ、i:Fin 2、z:E 4均与两个子系统相符。Fin.castAdd 2 i取下标0、1的q_i，Fin.natAdd 2 i取下标2、3的p_i，故在(q₁,q₂,p₁,p₂)顺序下确为p_i²/2+Ω_i²q_i²/2。这个多项式定义对零频率也有意义，较原非零参数域的总延拓不造成虚假动力学结论。本条公开范围仅是H₁、H₂定义；总能量用两项求和表示（条目7），全初值不变性已经由本批条目5的定理承担。未把单个def当作独立证明总能量守恒或二维环面拓扑。

### 7. 状态与证明位置

self-contained；`MD.Ch05.twoOscillatorEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1610)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorFlow · unnumbered_claim · 印刷p.199 / PDFp.220

### 2. 原文陈述

> Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1=p_1^2/2+\Omega_1^2q_1^2/2$ and $H_2=p_2^2/2+\Omega_2^2q_2^2/2$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E 4) : MolecularDynamics.Chapter05Review.E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]

theorem twoOscillatorFlow_invariants (Ω : Fin 2 → ℝ) (_hΩ : ∀ i,Ω i ≠ 0)
    (z : MolecularDynamics.Chapter05Review.E 4) (t : ℝ) (i : Fin 2) :
    twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=twoOscillatorEnergy Ω i z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorFlow`；`MD.Ch05.twoOscillatorFlow_invariants` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留解析流并补任意初值（包括零分能量退化层）的两个真实分能量不变量，不再只依赖正共同层的Tori结论。原非零频率资格显式。 | [EXTRA] |

[EXTRA] [EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。；[EXTRA] 保留解析流并补任意初值（包括零分能量退化层）的两个真实分能量不变量，不再只依赖正共同层的Tori结论。原非零频率资格显式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对twoOscillatorFlow及twoOscillatorFlow_invariants。四维状态确按(q₁,q₂,p₁,p₂)排列；每个q分量只使用相应p和Ω，两个p分量分别带−Ω_i q_i sin(Ω_i t)，未交换下标或符号。不变量定理要求∀i,Ω_i≠0，随后对任意初值z、任意实时间t和任意i断言H_i(Φ_t z)=H_i(z)，包含零分能量的退化层，并非仅在正能量共同层上给出条件结论。这覆盖了原句的两个不变量；源文没有给出显式流公式，该公式是已公开的派生构造。

### 7. 状态与证明位置

incomplete；`MD.Ch05.twoOscillatorFlow`：定义；`MD.Ch05.twoOscillatorFlow_invariants`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1616)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorTori · Example 5.4 · 印刷p.199 / PDFp.220

### 2. 原文陈述

> For any $E_1,E_2>0$, the set of points satisfying $H_1=E_1,H_2=E_2$ is a two-dimensional torus. If the frequencies $\Omega_1$ and $\Omega_2$ are not rationally related (i.e. $\Omega_1/\Omega_2$ is an irrational number), then for any $E_1,E_2$ the torus will eventually be filled in by any trajectory. On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem twoOscillatorTori : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {z : MolecularDynamics.Chapter05Review.E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1 × Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬MolecularDynamics.Chapter05Review.setErgodic (MolecularDynamics.Chapter05Review.microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω)) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-TwoOscillatorTori。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem twoOscillatorTori_corrected : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {z : MolecularDynamics.Chapter05Review.E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1 × Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬MolecularDynamics.Chapter05Review.setErgodic (MolecularDynamics.Chapter05Review.microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorTori`；`MD.Ch05.twoOscillatorTori_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目依赖Chapter05/ReviewDefinitions.lean实际展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z|H z=c}；grad H=gradient H；hausdorffArea d=[vol(B₁⊂Rᵈ)/2ᵈ]·HausdorffMeasure d；surfaceMeasure=(hausdorffArea(n−1)).restrict(energySurface H c)；microRaw=surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure=(microRaw univ)⁻¹·microRaw；average μ g=∫g dμ；microAverage H c g=average(microMeasure H c)g。本地Hᵢ和Φ分别展开为上述分能量及无耦合旋转。签名∀Ω,c，∀i Ωᵢ≠0且cᵢ>0，然后令T={z|∀i,Hᵢ(z)=cᵢ}；其合取项分别是T与两个欧氏单位圆的积同胚、∀z∈T∀t∀i的分能量保持、Ω₁/Ω₂无理时每条全实时间轨道闭包等于T、以及∀E>0的总能量微正则非遍历性。项目flowInvariant Φ A=∀t,Φt ''A=A；setErgodic μ Φ=∀可测A,flowInvariant Φ A→μA=0∨μA=1。这些对象和量词均准确；正分能量及非零频率是非退化2-torus所需，“filled in”解释为稠密而非有限时间覆盖合理。但原文“总能量面是全部这类层的并”的分解结论不在本定理的四个合取项中；[EXTRA]指出退化圆，却没有在本lean_decl写出包括它们的分解。原书按正分能量2-tori穷尽整面存在确定边界漏项，须明示勘误而非静默改变原文。FAIL是结论缺项；证明体sorry单独记录，标准Hausdorff测度/积分未提供定义体不是判定理由。

### 7. 状态与证明位置

incomplete；`MD.Ch05.twoOscillatorTori`：未证（原书疑误不证）；`MD.Ch05.twoOscillatorTori_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1630)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-Mixing · definition · 印刷p.199 / PDFp.220

### 2. 原文陈述

> An even stronger property than the ergodic property is the concept of a mixing system. For a mixing system, the finite time density $\rho(z;t)$ converges, in the weak sense, to the invariant distribution $\rho_\infty(z)$, as $t\to\infty$. That is, we have, for all test functions $\phi$ in some chosen space
> \[\lim_{t\to\infty}\langle\phi,\rho(\cdot;t)\rangle=\langle\phi,\rho_\infty\rangle.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (IsProbabilityMeasure μ ∧ (∀ t, MeasurePreserving (Φ t) μ μ) ∧ (∀ z,Φ 0 z=z) ∧
    (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) ∧ Measurable (Function.uncurry Φ)) ∧
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakMixing` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。 | [EXTRA] |

[EXTRA] [EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。；[EXTRA] 混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。；[EXTRA] 补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。

### 6. 审计结论

本轮修复：补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；weakMixing的概率μ、零时恒等、全实时间群律、联合可测均已写在第一合取内。第二合取对所有L¹、逐点非负、积分为1的初始密度r，以及所有有界连续实测试函数φ，要求∫φ(Φ_t z)r(z)dμ→∫φdμ；这准确表达了AC初始概率分布的弱收敛，测试函数与初始密度的量词及极限方向正确。但定义既没有∀t,MeasurePreserving (Φ t) μ μ，也没有足以从弱收敛推出不变性的空间连续性条件。因此μ不一定是源文及[EXTRA]所说的不变参考分布。下面的联合可测群作用满足整个当前谓词，却不保持μ。此外weakMixing这个名称不能按标准术语读作“弱混合”；这里本来意图表达的是混合导致分布弱收敛。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakMixing`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1661)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-KAMPersistence · unnumbered_claim · 印刷p.200 / PDFp.221

### 2. 原文陈述

> The energy surface is three-dimensional (represented as the zero-set of a single constraint in four-dimensional space), but apparently it bifurcates into a collection of isolated components (bounded by two-dimensional closed surfaces). These are none other than the tori predicted by the KAM theory [386].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kam :
  ∀ n (H0 : MolecularDynamics.Chapter05Review.E n → ℝ) (P : MolecularDynamics.Chapter05Review.Phase n → ℝ) (I0 : MolecularDynamics.Chapter05Review.E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → MolecularDynamics.Chapter05Review.periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → MolecularDynamics.Chapter05Review.diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=MolecularDynamics.Chapter05Review.hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-KAMPersistence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem kam_corrected :
  ∀ n (H0 : MolecularDynamics.Chapter05Review.E n → ℝ) (P : MolecularDynamics.Chapter05Review.Phase n → ℝ) (I0 : MolecularDynamics.Chapter05Review.E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → MolecularDynamics.Chapter05Review.periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → MolecularDynamics.Chapter05Review.diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=MolecularDynamics.Chapter05Review.hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.kam`；`MD.Ch05.kam_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目E n=Rⁿ，Phase n=E n×E n。依赖hamiltonianField H(q,p)=(∇pH,−∇qH)；periodicPerturbation P为P(q+k,p)=P(q,p)（∀整数向量k）；diophantine ω κ τ为κ>0、τ>n−1及∀k≠0,κ/(1+‖k‖)^τ≤|k·ω|。附件1146–1158在n>0、全域解析H₀,P、周期扰动、I₀处频率映射导数双射、上述Diophantine条件下，量化∃δ>0∀|ε|<δ∃K；K为C¹、导数逐点单射、整数平移等变、DK·∇H₀(I₀)=X_{H₀+εP}∘K，且作用量距I₀<1。[EXTRA]的解析近可积资格和非退化性合理；这是通用KAM背景命题。但所引原文是特定双摆的三维能量面、隔离区域及图示环面的叙述；本签名没有该双摆、指定能量或其KAM适用资格的验证，[EXTRA]还明确不声称双摆参数满足资格。因此并非当前statement_scope下完整原句的忠实形式化。导数单射本身只表示浸入；半共轭等式还须结合周期等变、Diophantine稠密性及光滑ODE唯一性来理解全局嵌入/共轭，不能用任意自交浸入充当满足全部条件的反例。本轮FAIL仅由确切来源对象与结论缺失支撑。原书components也未被静默提升为拓扑连通分支断言。证明体为sorry；标准解析性或导数定义未出现在摘录中不影响上述审计。

### 7. 状态与证明位置

incomplete；`MD.Ch05.kam`：未证（原书疑误不证）；`MD.Ch05.kam_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1671)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicPotential · Example 5.6 · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Example 5.6 (Anisotropic Oscillator) The anisotropic oscillator was used in Chap. 1 to illustrate the concept of a chaotic dynamical system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def anisotropicPotential (κ l ε : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicPotential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。附件1161–1162调用项目Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0。依赖Chapter01/ReviewDefinitions.lean实际展开anisotropicAngular：r=√(x²+y²)，c=x/r，c₃=4c³−3c；anisotropicParameters=(κ(1−εc₃/2),l(1+εc₃/2))；anisotropicEnergy=(v²+w²)/2+κ(1−εc₃/2)(r−l(1+εc₃/2))²/2。令v=w=0取得原第1章模型的势能，E 2为位置欧氏平面；与context_notation明确限定的零速度势一致。不把历史性的混沌模型回引误当作本def证明混沌。原点的总化除法是既有定义的延拓约定，本条没有声称原点解析性，也没有额外物理假设。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.anisotropicPotential`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1707)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicAxisPrinted · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\le x\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$. The set $y=0$, $\dot y=0$ is invariant under the differential equations of the perturbed central force problem, since the force acts in the radial direction; our choice of initial conditions ensures that trajectories explore the larger $H=E_0$ energy surface.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem anisotropicAxisPrinted : ∀ (κ l ε : ℝ) (z : ℝ → MolecularDynamics.Chapter05Review.Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0 := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-AnisotropicAxisPrinted。改动：只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。 -/
```

独立修正版：

```lean
theorem anisotropicAxisPrinted_corrected : ∀ (κ l ε : ℝ) (z : ℝ → MolecularDynamics.Chapter05Review.Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (∀ t, (z t).1 ≠ 0) → (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicAxisPrinted`；`MD.Ch05.anisotropicAxisPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。 | [EXTRA] |

[EXTRA] [EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。；[ERRATUM?] 只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ_eff=κ₀(1−εc₃/2)、l_eff=l₀(1+εc₃/2)，U=κ_eff(r−l_eff)²/2。声明对任意 κ₀,l₀>0、任意实 ε 以及任意全实时间 C¹ 相空间轨道 z，假定 z′=(p,−∇U(q))、y(0)=p_y(0)=0，推出所有实 t 的 y(t)=p_y(t)=0。该签名刻画轴不变性，没有把该结论作前提；但原文 statement_scope 包含能量 E₀、给定短区间初值与“ensures ... explore the larger H=E₀ energy surface”，本声明不含这些初值约束和探索条款，不能把整段原句判为覆盖完整。初值构造已另有条目，不等于此声明包含了缺失结论。[EXTRA]正基准参数是合理物理资格，全时间轨道限制须区分于经典局部解；并且正基准参数不保证任意 ε 下有效参数为正。展开的势含角向依赖，故原书径向力理由一般不成立；远离原点的轴上则有反射对称性，可用于局部轴不变结论。全局签名未区分原点处总定义的 Lean gradient 与经典可微势，宜另加有效定义域资格。FAIL 的确定依据是全条覆盖缺失和原书理由的显式问题，无须因标准库定义缺失转为 NEEDS_HUMAN。声明体为 sorry；这与签名语义分开记录。

### 7. 状态与证明位置

incomplete；`MD.Ch05.anisotropicAxisPrinted`：未证（原书疑误不证）；`MD.Ch05.anisotropicAxisPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1713)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorEnergyDecomposition · unnumbered_claim · 印刷p.199 / PDFp.220

### 2. 原文陈述

> On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem twoOscillatorEnergyDecomposition : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-TwoOscillatorEnergyDecomposition。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem twoOscillatorEnergyDecomposition_corrected : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorEnergyDecomposition`；`MD.Ch05.twoOscillatorEnergyDecomposition_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]包括c_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]包括c_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；twoOscillatorEnergyDecomposition逐点量化任意实频率Ω、任意实E和z:E 4。左侧是两个真实分能量之和等于E；右侧存在c:Fin 2→ℝ，各c_i非负、总和等于E且逐项H_i(z)=c_i。各H_i是平方项之和，故取c_i=H_i(z)得到这一双向分解；E<0时两侧均不能成立，E=0时也没有被排除。这是正确的、含边界退化层的静态修订。[EXTRA]与statement_scope已明确不在本条断言各层都是二维环面、轨道稠密性或非遍历性；这些额外结论不能由当前静态等价式获得。本条签名PASS不改变原书关于“all such 2-tori”的疑误，外部TwoOscillatorTori未在本批复核。

### 7. 状态与证明位置

incomplete；`MD.Ch05.twoOscillatorEnergyDecomposition`：未证（原书疑误不证）；`MD.Ch05.twoOscillatorEnergyDecomposition_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1736)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CurveImageDimension · unnumbered_claim · 印刷p.202 / PDFp.223

### 2. 原文陈述

> The segment of initial conditions, a one-dimensional object, when transformed by the smooth map defined by solving initial value problems, should result, again, in a one-dimensional object, i.e. a curve. Yet it appears also to provide a dense covering of a two-dimensional region in the position projection.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem curveImageDimension : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (γ : ℝ → MolecularDynamics.Chapter05Review.E n),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ ∞ (Function.uncurry Φ) → ContDiff ℝ ∞ γ →
  (∀ s,deriv γ s ≠ 0) → ∀ t,
  ContDiff ℝ ∞ (fun s => Φ t (γ s)) ∧ (∀ s,deriv (fun r => Φ t (γ r)) s ≠ 0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.curveImageDimension` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |

[EXTRA] [EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；curveImageDimension对任意n、向量场f、全实时间流Φ和γ:ℝ→E n量化。flow依赖确实包含零时恒等、群律及轨道微分方程；另有Φ的联合C∞、γ的C∞和所有参数处deriv γ≠0。结论对每个固定实时间t给出像参数曲线的C∞及处处非零导数。群律使Φ_t与Φ_−t互为逆，其光滑微分互逆，故不会把非零切向量压为0；这不是把结论正则性预先作为假设。γ全实参数及正则性是已公开的精确版本，蕴含区间上的局部曲线结论。[EXTRA]准确区分相空间的正则曲线和位置投影；没有断言投影仍浸入或有限时间曲线覆盖二维开集。原句“appears”是数值外观的描述，未被强化为数学稠密性定理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.curveImageDimension`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1756)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-PendulumPotential · Example 5.5 · 印刷p.200 / PDFp.221

### 2. 原文陈述

> Example 5.5 (Double Pendulum) To explore some of the issues related to ergodicity, let us return to the double pendulum considered in Chap. 3.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : MolecularDynamics.Chapter05Review.E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pendulumPotential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。 | [EXTRA] |

[EXTRA] [EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；pendulumPotential输入四个实参数及二维位置q，给出k₁/2·(r₁−l₁)²+k₂/2·(r₂−l₂)²。r₁²=x²+y²，r₂²=x²+(y+2)²，故第二固定端确为(0,−2)，不是(0,2)。与本条context_notation及[EXTRA]摘录的第3章真实双弹簧势完全一致。函数对任意实参数作多项式/平方根表达式的总延拓；物理使用时要求正弹簧系数和正自然长度，不影响定义本身的正确性。本条没有形式化整个Example 5.5的数值非遍历现象。本次另查同目录原书PDF148只用于核实已在本条明确回指的公式；没有使用旧项目定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.pendulumPotential`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1764)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-PendulumRegionPrinted · unnumbered_claim · 印刷p.200 / PDFp.221

### 2. 原文陈述

> For given positive values of the coefficients, the region swept out in the plane by trajectories can be seen to be a union of intersections of pairs of disks centered at the origin and $(0,-2)$, with radii $r_1,r_2$ respectively, which themselves represent a point on an ellipse in the first quadrant. Determining the boundary of this region analytically is difficult but it is easy to find it numerically. For the special case $k_1=k_2=2$, $l_1=l_2=1$, and $E=4$ that the projected region covered by positions at this energy is the interior of the level set $U=E$ shown as a dark oval curve in the three panels of Fig. 5.4.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem pendulumRegionPrinted : ∀ k₁ k₂ l₁ l₂ c : ℝ,
  0 < k₁ → 0 < k₂ → 0 < l₁ → 0 < l₂ → 0 < c →
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c}=
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ r₁ > 0,∃ r₂ > 0,
    k₁/2*(r₁-l₁)^2+k₂/2*(r₂-l₂)^2=c ∧
    Real.sqrt ((q 0)^2+(q 1)^2) ≤ r₁ ∧ Real.sqrt ((q 0)^2+(q 1+2)^2) ≤ r₂} := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-PendulumRegionPrinted。改动：能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。 -/
```

独立修正版：

```lean
theorem pendulumRegionPrinted_corrected (k₁ k₂ l₁ l₂ c : ℝ) :
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c} =
  {q : MolecularDynamics.Chapter05Review.E 2 | pendulumPotential k₁ k₂ l₁ l₂ q ≤ c} := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pendulumRegionPrinted`；`MD.Ch05.pendulumRegionPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。 | [EXTRA] |

[EXTRA] [EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。；[ERRATUM?] 能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件:1189–1191 的 pendulumPotential 逐项为双弹簧势 U(q)=k₁(d₁−l₁)²/2+k₂(d₂−l₂)²/2，其中 d₁=√(x²+y²)、d₂=√(x²+(y+2)²)。声明量化所有严格正 k₁,k₂,l₁,l₂,c。左集是存在动量使 |p|²/2+U(q)=c 的位置投影，按标准实欧氏语义恰为 {U≤c}；右集是存在正 r₁,r₂ 处于半径能量椭圆，且 d₁≤r₁、d₂≤r₂ 的圆盘交之并。平方项(r−l)²在 r<l 时并不单调递增，故半径上界不足以控制实际势。[EXTRA]单位质量及将可达区域解释为所有能量初值的位置投影合理，全部正参数也未把结论作前提，但它们不能消除下列反例。原书特例及 interior 的边界问题亦应区分；闭能量投影包含零动量边界。FAIL 是展开后等式为假的确定判定，无需查看 Mathlib 定义体。声明体为 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch05.pendulumRegionPrinted`：未证（原书疑误不证）；`MD.Ch05.pendulumRegionPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1771)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicInitialCurve · definition · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\le x\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def anisotropicInitialCurve (κ l ε c x : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![0,Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicInitialCurve` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ_eff=κ₀(1−εc₃/2)、l_eff=l₀(1+εc₃/2)，U=κ_eff(r−l_eff)²/2。展开目标附件:1205–1206 的 anisotropicInitialCurve 得 γ(x)=((x,0),(0,√(2(c−U(x,0)))))，WithLp.toLp 2 仅将指定坐标放入标准欧氏空间；c 对应 E₀，单位质量下动量等于速度。此项是参数化公式定义，原区间[1.05,1.15]已在 context_notation 明示，集合使用时应限制到该区间，映射本身在整个实线上定义并不改变受限初值集。Real.sqrt 在负参数上取0的总定义按标准语义理解：本 def 自身没有断言所有参数下能量恒等式成立，实初值能量资格由下一条明确约束。因此不将缺少定义体或总定义延拓误判为缺失对象或数学错误。extra_assumptions 为空，def 无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.anisotropicInitialCurve`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1794)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicInitialEnergy · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem anisotropicInitialEnergy : ∀ κ l ε c x : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := anisotropicInitialCurve κ l ε c x
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicInitialEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。 | [EXTRA] |

[EXTRA] [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ_eff=κ₀(1−εc₃/2)、l_eff=l₀(1+εc₃/2)，U=κ_eff(r−l_eff)²/2。目标附件:1205–1206 的初值定义展开为 q=(x,0)、p=(0,√(2(c−U(q))))。本声明量化所有实 κ₀,l₀,ε,c,x，在唯一前提 c−U(q)≥0 下推出 |p|²/2+U(q)=c；前提正好保证实平方根的平方等于根号内量。[EXTRA]非负根号资格必要且合理，单位质量已体现于动能系数1/2；参数正性和短区间约束不是这个代数能量恒等式所必需，省去它们是有效的一般化。本项没有声称轨道覆盖或遍历整个能量面，也未将能量结论作为前提。PASS 只批准签名语义，theorem 主体仍为 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch05.anisotropicInitialEnergy`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1799)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InitialSegmentPrinted · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> The set of initial conditions forms a line segment in the four-dimensional phase space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem initialSegmentPrinted : ∀ κ l ε c : ℝ,
  (∀ x ∈ Icc (105/100 : ℝ) (115/100),0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])) →
  ∃ a b : MolecularDynamics.Chapter05Review.Phase 2,anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)=segment ℝ a b := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-InitialSegmentPrinted。改动：四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。 -/
```

独立修正版：

```lean
def initialSegmentPrinted_corrected (κ l ε c : ℝ) : Set (MolecularDynamics.Chapter05Review.Phase 2) :=
  anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.initialSegmentPrinted`；`MD.Ch05.initialSegmentPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。 | [EXTRA] |

[EXTRA] [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。；[ERRATUM?] 四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ_eff=κ₀(1−εc₃/2)、l_eff=l₀(1+εc₃/2)，U=κ_eff(r−l_eff)²/2。目标附件:1205–1206 的实际初值是 γ(x)=((x,0),(0,√(2(c−U(x,0)))))；1218–1220 量化任意实 κ₀,l₀,ε,c，假定闭区间 I=[21/20,23/20] 上 c−U≥0，结论存在 a,b∈Phase 2 使 γ(I)=segment ℝ a b。标准 Mathlib segment ℝ a b 是 {(1−s)a+s b | 0≤s≤1} 的仿射闭线段，不能理解成任意拓扑弧或参数曲线。[EXTRA]保留真实相空间对象、区间与非负根号资格正确且无循环，但不能使平方根动量关于 x 为仿射函数。该签名忠实复现原书 line segment 的字面措辞，同时把原书疑误写成了假的数学定理，应 FAIL；问题与 Mathlib 定义体是否提供无关。没有显式 [ERRATUM?] 标签可据此默认接受错误，疑误及修复必须明示。声明体为 sorry，独立记录。

### 7. 状态与证明位置

incomplete；`MD.Ch05.initialSegmentPrinted`：未证（原书疑误不证）；`MD.Ch05.initialSegmentPrinted_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1808)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialPoints · definition · 印刷p.202 / PDFp.223

### 2. 原文陈述

> Now consider an alternative initial set. Begin, as before, with a line segment on the $x$-axis, but now choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$. In this way we again get initial conditions on the $H=E_0$ energy surface, but this time the points are not close to one another in phase space, since the momenta of successive points may differ greatly.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def circleInitialPoints (κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100)) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])

def circleInitialPoints_total (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialPoints`；`MD.Ch05.circleInitialPoints_total` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。 | [EXTRA] |

[EXTRA] [EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对circleInitialPoints及circleInitialPoints_total。Phase 2确为E 2×E 2，位置为(x,0)，动量为(R cos θ,R sin θ)，R=√(2(c−U(x,0)))。实际接口显式要求c−U(x,0)≥0及x∈[1.05,1.15]，与可行能量及“as before”的原位置区间相符；κ,l,ε,c,x,θ均为实参数，θ没有在本定义中被伪称随机变量的概率律。U实际调用给出的anisotropicPotential→anisotropicEnergy，零速度消去了动能；角向参数是4 cos³α−3 cosα，对应给出的各向异性参数定义，没有换成双弹簧势。total接口明确是无前提的辅助总延拓，负能差时不能称为能量c上的初值。均匀性在条目11另作测度定义，能量等式在条目12另作结论；[EXTRA]没有将样本可能相距很远强化为所有θ、所有样本都分离。

### 7. 状态与证明位置

self-contained；`MD.Ch05.circleInitialPoints`：定义；`MD.Ch05.circleInitialPoints_total`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1821)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialLaw · definition · 印刷p.202 / PDFp.223

### 2. 原文陈述

> choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def circleInitialLaw (κ l ε c x : ℝ)
    (hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (hx : x ∈ Icc (105/100 : ℝ) (115/100)) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (fun θ ↦ circleInitialPoints κ l ε c x θ hfeas hx)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialLaw` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。 | [EXTRA] |

[EXTRA] [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。；[EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；circleInitialLaw对固定κ,l,ε,c,x及其可行性、区间资格，定义Phase 2上的真实Measure.map。原测度是(2π)⁻¹倍的Lebesgue测度在(0,2π]上的限制；π>0，区间长度为2π，归一化系数和端点选择正确。推前映射恰是条目10的实际可行接口，关于θ连续，因此推前确有概率总质量1；没有把“尚未证明概率实例”误作公式错误。当R>0，这给出固定位置下对动量圆的均匀角/归一化弧长概率分布；R=0时退化为该固定相点的Dirac概率。原文没有指定跨x的联合抽样规律，本定义也没有擅加x均匀性或不同x之间的独立性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.circleInitialLaw`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1834)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialEnergy · unnumbered_claim · 印刷p.202 / PDFp.223

### 2. 原文陈述

> In this way we again get initial conditions on the $H=E_0$ energy surface,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints_total κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。 | [EXTRA] |

[EXTRA] [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。；[EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；circleInitialEnergy对所有κ,l,ε,c,x,θ∈ℝ，仅要求c−U(x,0)≥0，在circleInitialPoints_total上断言两动量平方和的一半加同一势能等于c。cos²θ+sin²θ=1及非负根号平方给出该恒等式，动能系数与圆半径的因子2相抵；R=0同样成立。本条作为辅助总定义的结论不限制x区间是正确的推广，实际书中抽样接口的区间限制在条目10、11，且两种点定义在其共同可行域的表达式相同。没有偷换势能，未把能量等式本身作前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.circleInitialEnergy`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1843)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-Correlation · definition · 印刷p.203–204 / PDFp.224–225

### 2. 原文陈述

> Let $a$ and $b$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $a$ and $b$ (on the surface of energy $E$) by
> \[C_{ab}(\tau)\stackrel{\rm def}{=}k\operatorname{Av}_{H=E}(a(\mathcal F_t(z))\cdot b(z))
> =kZ_E^{-1}\int_{\Sigma_E}a(\mathcal F_t(z))\cdot b(z)\delta[H-E]d\omega;\]
> where $k$ is a normalization constant that is often incorporated to ensure that $C_{ab}(0)=1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)



/-- 修正版，对应原文 MD-5.5-Correlation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def correlation_corrected {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlation`；`MD.Ch05.correlation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；correlation对任意状态维n、共同输出维d，接受μ、Φ及a,b:E n→E d和实k,t，返回k乘以真实实欧氏内积的μ积分；只在a上施加Φ_t，b取初始状态，次序与源文相符。这里定义的是通用测度下的相关核，取μ为已归一化微正则概率测度时才对应原Av_(H=E)；不能据此声称对任意μ都等于原δ积分，也未在此定义或证明微正则测度构造。积分定义可以总延拓至任意观测量；作通常统计相关解释时仍须有相关乘积的可积性。k任意是正确的，“often”并未要求无条件C(0)=1；零lag积分非零时才能取其倒数归一化。Lean统一用一个lag参数t，是对源文τ/t混用的已公开合理修订。

### 7. 状态与证明位置

self-contained；`MD.Ch05.correlation`：定义；`MD.Ch05.correlation_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1851)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationPullback · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Using the notation developed earlier for the propagator, this has the alternative formulation
> \[C_{ab}(t)=k\operatorname{Av}_{H=E}\left[b(z)\cdot(e^{t\mathcal L}a)(z)\right].\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationPullback {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t :
    MolecularDynamics.Chapter05Review.correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ) := by
  apply MolecularDynamics.Chapter05Review.correlationPullback_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationPullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目pullback Φ g t z := g(Φ t z)，solutionOperator Φ t g := pullback Φ g t。两者在定义中为实标量观测；向量观测的逐坐标传播就是a(Φt z)。主声明对任意n,d,μ,Φ,a,b,k,t断言correlation等于其展开积分，保留k及全部配对项；欧氏实内积对称，故与原b(z)·(e^{tL}a)(z)相同。没有凭函数名字假定它是微分算子的指数：这里使用原flow拉回的传播含义，实际展开体已核对。无额外假设或新增勘误。Ch05_deps.txt的ReviewProofs.lean中correlationPullback_proved为rfl，主声明调用它；本条无sorry。无编译验证声明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.correlationPullback`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1861)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationTimePrinted · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:
> \[C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationTimePrinted : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
  sorry



/-- 修正版，对应原文 MD-5.5-CorrelationTimePrinted。改动：any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。 -/
```

独立修正版：

```lean
theorem correlationTimePrinted_corrected : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.regularEnergy H c →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationTimePrinted`；`MD.Ch05.correlationTimePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。 | [EXTRA] |

[EXTRA] [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。；[ERRATUM?] any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 energySurface H c := {z | H z=c}；grad H := gradient H；hausdorffArea m := ofReal(volume(单位ℝ^m球).toReal/2^m) • hausdorffMeasure m；surfaceMeasure H c := (hausdorffArea (n-1)).restrict(energySurface H c)；microRaw H c := (surfaceMeasure H c).withDensity(fun z => ofReal(‖grad H z‖⁻¹))；microMeasure H c := ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage H c g := average(microMeasure H c)g。timeAverage z g T := T⁻¹*(∫s in 0..T,g(z s))；hasTimeAverage z g a := Tendsto(timeAverage z g) atTop (𝓝 a)；microErgodic H c Φ := ∀g, Integrable g (microMeasure H c) → ∀ᵐz∂microMeasure H c, hasTimeAverage(fun s=>Φs z)g(microAverage H c g)。签名依次全称量化n,d,H,c,Φ,a,b,k,t，假设Φ0=id、flow加法群律、microErgodic及给定lag观测的可积性，结论为所有z∈{H=c}的相关时间积分极限。原文any trajectory确实对应这个全点结论；但本项目microErgodic只提供对每个可积观测的AE性质，不能推出全能量面点性质。[EXTRA]给定lag可积和群律合理，却不足以支持原any；没有正有限微正则质量、正则能量资格或全点平均假设。原文any在通常测度遍历含义下应公开作AE勘误，不能由名字ergodic获得全点结论。下面给出当前签名的直接反例，不因未给Mathlib定义而待裁定。主声明有sorry，但签名失败独立于证明完成度。

### 7. 状态与证明位置

incomplete；`MD.Ch05.correlationTimePrinted`：未证（原书疑误不证）；`MD.Ch05.correlationTimePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1868)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationTimeAE · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:
> \[C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationTime :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh



/-- 修正版，对应原文 MD-5.5-CorrelationTimeAE。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem correlationTime_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationTime`；`MD.Ch05.correlationTime_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；correlationTime已逐项核对全部n,d,μ,Φ,a,b,k,t量词、零时恒等及群律。遍历资格在此作为“每个L¹实观测量有各自AE时间平均”的标准性质传入，并要求给定lag的相关观测量可积；在条目1的概率保测可测流条件下，这个资格可由setErgodic取得，未把特定相关等式直接作为假设。结论对给定t几乎处处z，保留k、T⁻¹、真实0到T积分以及a(Φ_(s+t)z)与b(Φ_s z)的实内积。群律和实数加法交换保证该 integrand 是固定观测量g_t沿Φ_s的值，极限目标是同一μ、Φ、a、b、k、t的correlation。没有交换∀t与AE z；也没有从一般遍历性推出每个初值。因此AE修订版完整签名PASS，原书any trajectory仍独立标为待人工。

### 7. 状态与证明位置

self-contained；`MD.Ch05.correlationTime`：已证；`MD.Ch05.correlationTime_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1897)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-VelocityCorrelation · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> The velocity autocorrelation function is often written in the shorthand notation
> \[C_{v,v}(t)\stackrel{\rm def}{=}\frac{\langle v(t)\cdot v(0)\rangle}{\langle v(0)\cdot v(0)\rangle},\]
> where the averaging may be assumed to be against the microcanonical measure, if otherwise unspecified.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def velocityCorrelation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (v : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (t : ℝ) := MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 t/MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.velocityCorrelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 velocityCorrelation μ Φ v t := correlation μ Φ v v 1 t / correlation μ Φ v v 1 0；MD.Ch05中的定义调用同一项目correlation。展开为∫inner(v(Φt z))(v z)∂μ除以∫inner(v(Φ0 z))(v z)∂μ。在原轨迹/flow上下文Φ0=id时分母正是〈v(0)·v(0)〉，输出空间ℝ^d及真实dot均保留。μ参数允许原otherwise unspecified的微正则选择及其他指定测度。此定义不声称任意Φ为flow，不自动证明分母非零或可积；context已明确除零总化没有归一化意义，合法使用时须非零零lag平均。无[EXTRA]/[ERRATUM?]假设；定义无sorry。标准Bochner积分/除法定义不造成NEEDS_HUMAN。

### 7. 状态与证明位置

self-contained；`MD.Ch05.velocityCorrelation`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1931)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-PositionTransition · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Now let $A$ and $B$ be subsets of configuration space (i.e. subsets in the position space) of nonzero measure, and define $T_{AB}(\tau)\stackrel{\rm def}{=}C_{1_B,1_A}(\tau)$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (k t : ℝ) :=
  k*
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.positionTransition` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。 | [EXTRA] |

[EXTRA] [EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；positionTransition接受同一μ、Φ、实k和t，位置映射π:E n→E d，以及配置集合A、B。被积函数是1_B(π(Φ_t z))·1_A(π z)，并在积分外完整保留k，正对应C_(1_B,1_A)的顺序；没有交换始发集合A和目标集合B。π作为参数是通用观测映射，实际原文用法须选为位置投影；原非零测度和可测性要求在一般定义中可以放宽，因为本条没有做除法或断言条件概率。若作概率解释则还须相应概率测度、可测集/映射；特别应取k=1，再除以起始事件的正概率。当前定义本身不是首次到达分布，也不保证对任意k其值都在[0,1]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.positionTransition`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1936)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-TransitionProbability · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Dividing $T_{AB}$ by the measure of the set $A$, we obtain the probability for a trajectory to make this transition in the given time, which we may write as
> \[\operatorname{Pr}_\tau(A\to B)=\frac{\langle1_B(z(\tau))1_A(z(0))\rangle}{\langle1_A(z(0))\rangle},\]
> where the averaging is assumed to be with respect to the microcanonical distribution at given energy $E$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def transitionProbability {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (A B : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.transitionProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。 | [EXTRA] |

[EXTRA] [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 transitionProbability μ Φ A B t := (μ(A ∩ (Φt)⁻¹' B)).toReal/(μA).toReal。量化n及指定μ、Φ、相空间集合A/B和时刻t，事件是初始在A且终时在B，没有交换方向或替换为首次到达。按[EXTRA]，A/B解释为配置集合在实际位置投影下的逆像；这与上一条位置配置对象兼容。对微正则概率μ、可测/μ零可测的事件、可测flow及0<μA，指标乘积是A∩(Φt)⁻¹B的指标，故Bochner积分比值就是该测度比值；Φ0=id对应原初始轨迹记号。定义泛化到其他μ/集合不声称这些输入均有原条件概率解释；零分母及无限测度toReal的总化不是概率性结论。在原有限概率、正分母域内，所有分子分母子句完整，[EXTRA]逆像解释必要且合理。上一条T_AB的k歧义不影响这里直接写出的无k比值公式。定义无sorry；未要求项目附件重给Mathlib指标积分定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.transitionProbability`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1944)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MeasureDuality · (5.10) · 印刷p.205 / PDFp.226

### 2. 原文陈述

> \[\int_{\Sigma_E}\phi(z)\rho(z;t)d\omega
> =\int_{\Sigma_E}\phi(z)e^{t\mathcal L^\dagger}\rho(z,0)d\omega
> =\int_{\Sigma_E}[e^{t\mathcal L}\phi(z)]\rho(z,0)d\omega
> =\int_{\Sigma_E}\phi(\mathcal F_t(z))\rho(z,0)d\omega
> =\int_{\Sigma_E}\phi(\mathcal F_t(z))\frac{\rho(z,0)}{\rho_E(z)}\rho_E(z)d\omega.\tag{5.10}\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem measureDuality :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (φ : MolecularDynamics.Chapter05Review.E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) →
    MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) φ=MolecularDynamics.Chapter05Review.average μ (MolecularDynamics.Chapter05Review.pullback Φ φ t) := by
  intro n μ Φ φ t hm hi
  exact integral_map hm.aemeasurable hi.aestronglyMeasurable

theorem measureDuality_RN (n : ℕ)
    (ν : Measure (MolecularDynamics.Chapter05Review.E n)) (_hν : IsProbabilityMeasure ν)
    (r : MolecularDynamics.Chapter05Review.E n → ℝ) (_hr : Integrable r ν)
    (_hrpos : ∀ z,0 ≤ r z) (_hrmass : (∫ z,r z ∂ν)=1)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (t : ℝ) (_hΦ : Measurable (Φ t))
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hc : Continuous φ)
    (_hb : Bornology.IsBounded (range φ)) :
    let μ₀ := ν.withDensity (fun z ↦ ENNReal.ofReal (r z))
    MolecularDynamics.Chapter05Review.average (Measure.map (Φ t) μ₀) φ=
      MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t) ∧
    MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t)=
      ∫ z,φ (Φ t z)*r z ∂ν := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.measureDuality`；`MD.Ch05.measureDuality_RN` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ_E的RN解释，不对奇异δ作函数相除。 | [EXTRA] |

[EXTRA] [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。；[EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ_E的RN解释，不对奇异δ作函数相除。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已分别核对measureDuality和measureDuality_RN。前者对任意n、μ、Φ、实值φ和实t，在Φ_t可测且φ对推前measurePropagator可积时，断言推前积分等于初始测度下的pullback积分。实际measurePropagator定义确为Measure.map，pullback确为φ∘Φ_t，方向与原配对链相符，未把最终等式作前提；这一单时刻换元无需额外流群律。后者对概率参考ν、非负L¹密度r且∫r=1，置μ₀=ν.withDensity(ofReal∘r)，对可测Φ_t及有界连续φ，依次给出推前配对=μ₀下pullback配对=∫φ(Φ_t z)r(z)dν。非负性确保ofReal不截去密度，归一化确保μ₀为概率，有界连续φ使所需配对可积。这里的r是相对于ν的RN密度，对应原ρ₀/ρ_E的已公开测度解释，不是对Dirac分布作函数相除。原来有界密度的语境被推广为非负L¹概率密度，仍足以保证本条有界测试函数的配对链。PASS限于推前/拉回及加权积分的这套明示解释；本条没有定义生成元或证明算子指数e^(tL)、e^(tL†)的解析半群理论。

### 7. 状态与证明位置

incomplete；`MD.Ch05.measureDuality`：已证；`MD.Ch05.measureDuality_RN`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1951)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingMemoryLoss · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> We assume $\psi(z)\stackrel{\rm def}{=}\rho(z;0)/\rho_E(z)$ is bounded on $\Sigma_E$, and moreover $\operatorname{Av}_{H=E}(\psi)=\int_{\Sigma_E}\frac{\rho(z;0)}{\rho_E(z)}\rho_E(z)\,d\omega=1$ (i.e., the initial density is a probability density on the energy surface), and that the system is mixing. Then the integral (5.10) is well defined and we may view it as a two-point correlation function of $\phi$ and $\psi$. By the mixing property it must converge to $\int_{\Sigma_E}\phi(z)\rho_Ed\omega$, thus the average value of $\phi$ is ultimately independent of the initial conditions. We have
> \[\lim_{t\to\infty}\int_{\Sigma_E}\phi(\mathcal F_t(z))(\psi(z)-1)\rho_Ed\omega=0.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingMemoryLoss : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (β φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0) := by
  intro n μ Φ β φ hμ hm hβ hβbound hβpos hβmass hφ hb hΦ
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hi : Integrable φ μ := Integrable.mono' (integrable_const C)
    hφ.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (φ z) (mem_range_self z)))
  have he (t : ℝ) : (∫ z,φ (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ φ := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable φ (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact hi.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have hp (t : ℝ) : Integrable (fun z => φ (Φ t z)*β z) μ :=
    hβ.bdd_mul (hφ.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hB (φ (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : (∫ z,φ (Φ t z)*(β z-1) ∂μ)=
      (∫ z,φ (Φ t z)*β z ∂μ)-MolecularDynamics.Chapter05Review.average μ φ := by
    simp_rw [mul_sub,mul_one]
    have hip : Integrable (fun z => φ (Φ t z)) μ := by
      simpa only [Function.comp_def] using (hΦ t).integrable_comp_of_integrable hi
    rw [integral_sub (hp t) hip,he]
  simp_rw [heq]
  simpa only [sub_self] using (hm.2 β φ hβ hβpos hβmass hφ hb).sub (tendsto_const_nhds : Tendsto (fun _ : ℝ => MolecularDynamics.Chapter05Review.average μ φ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingMemoryLoss` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。 | [EXTRA] |

[EXTRA] [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。；[EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：n任意，E n为有限维实欧氏空间；μ是表示能量面参考概率的环境测度，未额外假设Lebesgue密度。Φ为实时间流，weakMixing第一合取规定概率、单位元、群律及联合可测，第二合取是对任意可积非负质量1密度和有界连续测试函数的弱收敛；这是混合的密度测试刻画，并非标准仅Cesàro意义的weak mixing。β可积、有界、非负且积分1，φ有界连续，各时Φ保持μ，结论是整个中心化积分随实t→+∞趋0。由测度保持和质量1亦恢复非中心化极限；[EXTRA]限制明确且充分，未把本条特定中心化结论作假设。 本条全部本地声明：MD.Ch05.mixingMemoryLoss。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.mixingMemoryLoss`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L1976)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingCorrelationPrinted · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> More generally, in a mixing system, if $a$ and $b$ are two arbitrary functions of the phase variables, then
> \[\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\operatorname{Av}_{H=E}(b).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingCorrelationPrinted :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → weakMixing μ Φ → Continuous a → Continuous b →
    Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
    Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  sorry



/-- 修正版，对应原文 MD-5.5-MixingCorrelationPrinted。改动：独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。 -/
```

独立修正版：

```lean
theorem mixingCorrelationPrinted_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingCorrelationPrinted`；`MD.Ch05.mixingCorrelationPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。 | [EXTRA] |

[EXTRA] [EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。；[ERRATUM?] 独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按本轮规则，Mathlib标准定义直接按Lean 4.34.0 / Mathlib v4.34.0的标准数学含义采信：EuclideanSpace ℝ (Fin n)是欧氏ℝⁿ；integral为Bochner积分且不可积时取0；IsProbabilityMeasure μ表示μ全空间质量1；MeasurePreserving表示可测且推前测度等于μ；Integrable表示相对于指定μ可积；Continuous及IsBounded(range f)分别为连续和全局有界；Tendsto ... atTop (𝓝 L)为实时间趋向+∞时趋向L。不要求Ch05_deps.txt提供这些Mathlib定义体。 已展开本项目定义：Ch05_deps.txt的-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean中，E n:=EuclideanSpace ℝ (Fin n)，average μ g:=∫g dμ，correlation μ Φ a b k t:=k∫inner ℝ (a(Φ t z)) (b z)dμ，其中a,b:E n→E d且d任意。Ch05.lean中本地MD.Ch05.weakMixing的定义为：∀ r φ:E n→ℝ，Integrable r μ→(∀z,0≤r z)→∫r dμ=1→Continuous φ→IsBounded(range φ)→∫φ(Φ t z)r z dμ趋向average μ φ。它是原书PDF220（印刷199）所述概率初值弱收敛的测试函数版本，不因名称weakMixing而解释成通常Cesàro弱混合。它没有引用deps中那个使用Lebesgue可积density r的旧mixing定义。μ任意量化是对微正则参考概率测度的抽象推广；不额外断言任意μ就是微正则测度。 所有项目自定义符号均有定义可核对，无缺失定义导致的NEEDS_HUMAN。 Ch05.lean:1335起量化任意实数k，结论左端为k∫a(Φ_t z)b(z)dμ而右端为average μ a·average μ b，确实照录PDF226（印刷205）的漏k公式。PDF224–225（印刷203–204）的C_ab定义含k；故原印归一化疑误成立，字面签名即使在全部函数可积的情形仍为假。[EXTRA]概率测度及有界连续函数是合理的统计/测试资格，不能弥补漏k。此条没有独立保测前提；下列反例甚至满足保测，所以添加保测也不能修复。另有对象范围遗漏：原C_ab及项目correlation允许任意同一Euclidean空间值a,b，而本声明仅量化实值a,b。这与Mathlib定义是否提供无关。签名失败不由sorry推断；声明正文有sorry，须另外记为证明未完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mixingCorrelationPrinted`：未证（原书疑误不证）；`MD.Ch05.mixingCorrelationPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2007)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingCorrelation · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> $\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\cdot\operatorname{Av}_{H=E}(b)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingCorrelation :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
  sorry

theorem mixingCorrelation_scalar :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hbb.exists_pos_norm_le
  obtain ⟨R,hR,hA⟩ := hba.exists_pos_norm_le
  have ib : Integrable b μ := Integrable.mono' (integrable_const C)
    hb.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (b z) (mem_range_self z)))
  have ia : Integrable a μ := Integrable.mono' (integrable_const R)
    ha.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hA (a z) (mem_range_self z)))
  have ibound : |∫ z,b z ∂μ| ≤ C := by
    simpa only [Real.norm_eq_abs,probReal_univ,mul_one] using
      norm_integral_le_of_norm_le_const (ae_of_all μ (fun z => hB (b z) (mem_range_self z)))
  let D := C+1
  let M := (∫ z,b z ∂μ)+D
  have hM : 0 < M := by dsimp [M,D];linarith [neg_le_of_abs_le ibound]
  let r (z) := (b z+D)/M
  have ir : Integrable r μ := (ib.add (integrable_const D)).div_const M
  have rpos (z) : 0 ≤ r z := by
    have hx : |b z| ≤ C := by simpa only [Real.norm_eq_abs] using hB (b z) (mem_range_self z)
    dsimp [r,D]
    apply div_nonneg _ hM.le
    linarith [neg_le_of_abs_le hx]
  have rmass : (∫ z,r z ∂μ)=1 := by
    dsimp [r]
    rw [integral_div,integral_add ib (integrable_const D)]
    simp [integral_const,M,ne_of_gt hM]
  have ht := hm r a ir rpos rmass ha hba
  have iap (t : ℝ) : Integrable (fun z => a (Φ t z)) μ :=
    (hΦ t).integrable_comp_of_integrable ia
  have ie (t : ℝ) : (∫ z,a (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ a := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable a (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact ia.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have ipr (t : ℝ) : Integrable (fun z => a (Φ t z)*r z) μ :=
    ir.bdd_mul (ha.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hA (a (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : M*(∫ z,a (Φ t z)*r z ∂μ)-D*MolecularDynamics.Chapter05Review.average μ a=
      (∫ z,a (Φ t z)*b z ∂μ) := by
    rw [←ie t,←integral_const_mul,←integral_const_mul,
      ←integral_sub ((ipr t).const_mul M) ((iap t).const_mul D)]
    apply integral_congr_ae
    filter_upwards [] with z
    dsimp [r]
    field_simp [ne_of_gt hM] <;> ring
  have hh := (ht.const_mul M).sub (tendsto_const_nhds : Tendsto
    (fun _ : ℝ => D*MolecularDynamics.Chapter05Review.average μ a) atTop
    (𝓝 (D*MolecularDynamics.Chapter05Review.average μ a)))
  simp_rw [heq] at hh
  convert hh.const_mul k using 1
  unfold MolecularDynamics.Chapter05Review.average
  dsimp [M]
  ring



/-- 修正版，对应原文 MD-5.5-MixingCorrelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem mixingCorrelation_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingCorrelation`；`MD.Ch05.mixingCorrelation_scalar`；`MD.Ch05.mixingCorrelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。；[EXTRA] 修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；C：主声明量化n,d、任意实k、概率μ、各时保持测度的Φ和有界连续向量a,b；密度测试混合前提作用于所有标量r,φ。有限维逐分量推出带k的内积均值极限，数学正确；scalar声明是相应d=1公式，k*Av(a)*Av(b)括号无误。未要求Φ群律不妨碍此蕴含。全部[EXTRA]与修正版相符，sorry不影响签名审核。但名为mixingCorrelation的结论是带k的修正版，不能同时认证为原书无k字面版本；需人工确认原文/勘误分流。 本条全部本地声明：MD.Ch05.mixingCorrelation, MD.Ch05.mixingCorrelation_scalar。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mixingCorrelation`：未证（原书疑误不证）；`MD.Ch05.mixingCorrelation_scalar`：已证；`MD.Ch05.mixingCorrelation_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2034)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CenteredCorrelation · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> So if either property has mean zero, then the absolute value of the autocorrelation function decays with time to zero.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem centeredCorrelation : ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  ((∫ z,a z ∂μ)=0 ∨ (∫ z,b z ∂μ)=0) →
  Tendsto (fun t => |k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)|) atTop (𝓝 0) := by
  sorry

theorem centeredCorrelation_scalar : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  (MolecularDynamics.Chapter05Review.average μ a=0 ∨ MolecularDynamics.Chapter05Review.average μ b=0) →
  Tendsto (fun t => |k*(∫ z,a (Φ t z)*b z ∂μ)|) atTop (𝓝 0) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb hzero
  have ht := mixingCorrelation_scalar n μ Φ a b k hμ hΦ hm.2 ha hb hba hbb
  have hl : k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b=0 := by
    rcases hzero with h | h <;> rw [h] <;> ring
  rw [hl] at ht
  simpa only [abs_zero] using ht.abs
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.centeredCorrelation`；`MD.Ch05.centeredCorrelation_scalar` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。 | [EXTRA] |

[EXTRA] [EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。；[EXTRA] 扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：主声明对任意n,d,k、概率μ、测度保持Φ、weakMixing及有界连续向量a,b，要求任一Bochner均值为零，结论是带k内积相关的绝对值趋0。scalar声明相同地使用实均值及乘积。两种均值零的析取及绝对值均未遗漏；衰减解释为趋零而非单调性，与[EXTRA]一致。标准混合前提通过所摘weakMixing的密度测试合取落实。 本条全部本地声明：MD.Ch05.centeredCorrelation, MD.Ch05.centeredCorrelation_scalar。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.centeredCorrelation`：未证（缺大型理论）；`MD.Ch05.centeredCorrelation_scalar`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2125)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DiscreteAveragePrinted · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> If $z_n$ represents the approximation to $z(t_n)$, then we might attempt to estimate $\bar g_\Gamma$ by
> \[\bar g_\Gamma\approx\lim_{n\to\infty}n^{-1}\sum_{k=0}^ng(z_k).\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.discreteAveragePrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：对任意类型X、自治步进G、实观测量g、初值z及自然数N，range(N+1)精确包含0,…,N，前因子为实N的逆元；Printed定义忠实给出有限统计量。N=0因实数逆元总化而得0，只是形式定义，不宣称统计意义或极限存在。原页只是尝试估计并随即警告极限可能不存在，因此无需补一个无条件收敛定理。 本条全部本地声明：MD.Ch05.discreteAveragePrinted。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.discreteAveragePrinted`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2146)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DiscreteAverage · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> $\bar g_\Gamma\approx\lim_{n\to\infty}n^{-1}\sum_{k=0}^ng(z_k)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.discreteAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。 | [EXTRA] |

[EXTRA] [EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：X,G,g,z,N的域同Printed，range N只有0,…,N−1；这是[EXTRA]及statement_scope明确标出的独立标准N项变体，并非原式逐字形式化。N=0总化为0，未断言两有限统计量相同、极限存在或等于原时间平均。该范围划分合理，原字面版本在本批条目4可核实。 本条全部本地声明：MD.Ch05.discreteAverage。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.discreteAverage`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2151)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DiscretePropagator · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> In a similar way, a numerical method $z_{n+1}=\mathcal F_h(z_n)$ induces an effective distributional propagator.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (_hG : Measurable G) (μ : Measure X) := Measure.map G μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.discretePropagator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。 | [EXTRA] |

[EXTRA] [EXTRA] 离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：任意可测空间X、可测自映射G、任意测度μ，返回Measure.map G μ，恰是一个数值步的分布推前；G可取F_h，h不必作为独立参数。μ不要求概率是合法推广，若μ概率则可测推前仍概率；显式Measurable G排除了不可测map的总化问题。[EXTRA]落实，不声称精确modified流或存在密度。 本条全部本地声明：MD.Ch05.discretePropagator。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.discretePropagator`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2156)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ModifiedField · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> One way to understand this propagator is to interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation
> \[\frac{dz}{dt}=f(z)+h^rf_{(r)}(z)\equiv\widetilde f_h(z).\]
> The perturbation term may be viewed as the finite truncation of the perturbative expansion obtained from the backward error analysis using the methods of the previous chapter. ($r$ is the order of the numerical method.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.modifiedField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：n自然数，f,fr:E n→E n，h实数，r自然数，返回z↦f z+h^r •fr z，向量加法及标量乘法正确。此为修正场的定义，允许r=0是代数扩域，不是声称0阶方法的数值分析结论；上下文仍应把实际方法阶数取正整数。没有证明或假设数值步与ODE近似程度、余项界或形式级数收敛；context已明示这些不由定义推出，故不把定义夸大为误差定理。 本条全部本地声明：MD.Ch05.modifiedField。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.modifiedField`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2159)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ModifiedLiouvillian · unnumbered_claim · 印刷p.206 / PDFp.227

### 2. 原文陈述

> Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by
> \[\frac{\partial\rho}{\partial t}=\mathcal L_{\widetilde f}^{\dagger}\rho
> \stackrel{\rm def}{=}\mathcal L_f^{\dagger}\rho+h^r\mathcal L_{f_{(r)}}^{\dagger}\rho.\]

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem modifiedLiouvillian :
  ∀ n (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=MolecularDynamics.Chapter05Review.liouvillian f u z+h^r*MolecularDynamics.Chapter05Review.liouvillian fr u z := by
  intro n f fr u h r hf hfr hu z
  have hx : DifferentiableAt ℝ (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z :=
    (hf z).add ((hfr z).const_smul (h^r))
  rw [liouvilleProduct n _ u z hx (hu z),liouvilleProduct n f u z (hf z) (hu z),
    liouvilleProduct n fr u z (hfr z) (hu z)]
  have hd : MolecularDynamics.Chapter05Review.divergence (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z=
      MolecularDynamics.Chapter05Review.divergence f z+(h^r)*MolecularDynamics.Chapter05Review.divergence fr z := by
    unfold MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.modifiedField
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      (fderiv ℝ (f+(h^r) • fr) z).toLinearMap=_
    rw [((hf z).hasFDerivAt.add ((hfr z).hasFDerivAt.const_smul (h^r))).fderiv]
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      ((fderiv ℝ f z).toLinearMap+(h^r) • (fderiv ℝ fr z).toLinearMap)=_
    simp only [map_add,map_smul,smul_eq_mul]
  have hl : MolecularDynamics.Chapter05Review.lie (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=
      MolecularDynamics.Chapter05Review.lie f u z+(h^r)*MolecularDynamics.Chapter05Review.lie fr u z := by
    simp [MolecularDynamics.Chapter05Review.lie,MolecularDynamics.Chapter05Review.modifiedField,
      map_add,map_smul,smul_eq_mul]
  rw [hd,hl]
  ring

def modifiedDensityEquation {n : ℕ}
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (h : ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  ∀ t z,HasDerivAt (fun s ↦ ρ s z)
    (MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) (ρ t) z) t

theorem modifiedLiouvillian_model_equivalence (n : ℕ)
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : Differentiable ℝ f) (_hfr : Differentiable ℝ fr)
    (h : ℝ) (r : ℕ) (hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (_hρ : ∀ t,Differentiable ℝ (ρ t)) :
    modifiedDensityEquation f fr h r hr ρ ↔
      ∀ t z,HasDerivAt (fun s ↦ ρ s z)
        (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z+
          h^r*MolecularDynamics.Chapter05Review.liouvillian fr (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.modifiedLiouvillian`；`MD.Ch05.modifiedDensityEquation`；`MD.Ch05.modifiedLiouvillian_model_equivalence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。 | [EXTRA] |

[EXTRA] [EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。；[EXTRA] 保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：liouvillian f u=−div(u f)，div由Fréchet导数的trace定义，是密度侧伴随生成元，不是观测量侧lie。首定理对任意n、可微f,fr,u、实h及自然r、每点z断言场线性，符号及h^r正确。modifiedDensityEquation对r≥1和所有t,z，以HasDerivAt精确规定ρ时间导数等于修正场密度生成元；equivalence在f,fr及每个ρ_t空间可微时等价于展开PDE。全部新增声明完整涵盖模型定义及展开，未假装任意ρ自动解PDE，也未声称O(h^r)分布误差。[EXTRA]准确。 本条全部本地声明：MD.Ch05.modifiedLiouvillian, MD.Ch05.modifiedDensityEquation, MD.Ch05.modifiedLiouvillian_model_equivalence。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.modifiedLiouvillian`：已证；`MD.Ch05.modifiedDensityEquation`：定义；`MD.Ch05.modifiedLiouvillian_model_equivalence`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2164)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardEuler · definition · 印刷p.206–207 / PDFp.227–228

### 2. 原文陈述

> Applying Forward Euler to the harmonic oscillator, we have
> \[q_{n+1}=q_n+hp_n,\qquad p_{n+1}=p_n-hq_n,\]
> or $\binom{q_{n+1}}{p_{n+1}}=\begin{pmatrix}1&h\\-h&1\end{pmatrix}\binom{q_n}{p_n}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮以BATCH24附件签名及哈希绑定的Blueprint/Ch05.lean为准；Mathlib标准定义按补充规则直接采信，无须在Ch05_deps.txt中展开。项目E在ReviewDefinitions.lean:5315为实二维欧氏空间（n=2）；forwardEuler在:5401及附件声明是WithLp.toLp 2 ![z 0+h*z 1,z 1−h*z 0]。标准WithLp转换保留坐标，因此将z 0=q、z 1=p后得到q_next=q+h p、p_next=p−h q，等价于矩阵[[1,h],[−h,1]]，完整覆盖PDF227–228／印刷206–207的两种写法。h为任意实定义参数，不需要渐近增长所需的h≠0。单位频率由原文H=(p²+q²)/2固定；没有把质量或频率引入额外资格。没有[EXTRA]或字面[ERRATUM?]标签；它是def，未涉及sorry证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.forwardEuler`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2208)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardComponentsPrinted · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardComponentsPrinted : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 0|) atTop atTop ∧
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 1|) atTop atTop := by
  sorry



/-- 修正版，对应原文 MD-5.6-ForwardComponentsPrinted。改动：两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。 -/
```

独立修正版：

```lean
theorem forwardComponentsPrinted_corrected : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardComponentsPrinted`；`MD.Ch05.forwardComponentsPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。 | [EXTRA] |

[EXTRA] [EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。；[ERRATUM?] 两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮以BATCH24附件签名及哈希绑定的Blueprint/Ch05.lean为准；Mathlib标准定义按补充规则直接采信，无须在Ch05_deps.txt中展开。ReviewDefinitions.lean:5315、5401展开后，对象为实际欧氏平面的A_h=[[1,h],[−h,1]]迭代。量词为所有非零实h、所有非零初值z；两个Tendsto atTop atTop按标准意义分别要求每个坐标绝对值最终超过任意实阈值。[EXTRA]h≠0、z≠0对增长是合理必要资格，绝对值解释也明确，但两坐标各自趋于+∞仍有反例，故原书疑误能够确定，不需NEEDS_HUMAN。PDF228／印刷207的谱外扩子句亦未单独表达；特征值模大于1可导致范数发散，不保证每个坐标绝对值发散。不存在字面[ERRATUM?]标签，但应明确保留原句并报告此疑误。附件中本声明证明体直接含sorry；反例与遗漏子句是FAIL依据，sorry另记，不能混淆。

### 7. 状态与证明位置

incomplete；`MD.Ch05.forwardComponentsPrinted`：未证（原书疑误不证）；`MD.Ch05.forwardComponentsPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2213)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardEnergyGrowth · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the eigenvalues of the propagation matrix are outside the unit disk.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardEnergyGrowth : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 1)^2=
    (1+h^2)^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.forwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.forwardEuler h x 1)^2=(1+h^2)*((x 0)^2+(x 1)^2) := by
    simp [MolecularDynamics.Chapter05Review.forwardEuler]
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

theorem forwardEnergyGrowth_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔
      ζ=1+Complex.I*h ∨ ζ=1-Complex.I*h) ∧
    ‖(1 : ℂ)+Complex.I*h‖=Real.sqrt (1+h^2) ∧
    ‖(1 : ℂ)-Complex.I*h‖=Real.sqrt (1+h^2) ∧ 1 < Real.sqrt (1+h^2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardEnergyGrowth`；`MD.Ch05.forwardEnergyGrowth_spectrum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。 | [EXTRA] |

[EXTRA] [EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。；[EXTRA] 保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：forwardEuler=(q+hp,p−hq)。首声明对所有实h、二维实z、自然k给平方范数精确因子(1+h²)^k，k=0及h=0均正确。spectrum另对h≠0给复矩阵[[1,h],[-h,1]]全部非零向量特征值的充要刻画1±ih、两个模均sqrt(1+h²)、以及严格大于1；无遗漏另一特征值。[EXTRA]条件与量词合理，谱外扩并非假设，sorry不构成FAIL。 本条全部本地声明：MD.Ch05.forwardEnergyGrowth, MD.Ch05.forwardEnergyGrowth_spectrum。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.forwardEnergyGrowth`：已证；`MD.Ch05.forwardEnergyGrowth_spectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2232)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerInvariant · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> This means that with the single exception $\rho(q,p;0)=\delta[q]\delta[p]$ there is no limiting (invariant) distribution for Forward Euler. To put it another way, the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$ is the point distribution $\delta[q]\delta[p]$, and this solution is not “asymptotically stable.”

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerInvariant :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2 := by
  intro h hh μ hμ hΦ
  letI := hμ
  have heq : ∀ᵐ z ∂μ,z=(0 : MolecularDynamics.Chapter05Review.E 2) := by
    filter_upwards [hΦ.conservative.ae_frequently_mem_of_mem_nhds] with z hz
    by_contra hn
    have hs : 0 < (z 0)^2+(z 1)^2 := by
      have hs' : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hn) _
      rw [EuclideanSpace.norm_sq_eq] at hs'
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hs'
    have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
    have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
    have hret := hz (Metric.ball 0 (‖z‖+1))
      (Metric.isOpen_ball.mem_nhds (by simp [Metric.mem_ball,dist_zero_right]))
    obtain ⟨k,hk,hlarge⟩ := (hret.and_eventually
      (ht.eventually (eventually_ge_atTop ((‖z‖+1)^2+1)))).exists
    have hen : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
        (1+h^2)^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
    rw [←hen] at hlarge
    rw [Metric.mem_ball,dist_zero_right] at hk
    nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),norm_nonneg z]
  have hm : Measure.map (fun z : MolecularDynamics.Chapter05Review.E 2 => z) μ =
      Measure.map (fun _ : MolecularDynamics.Chapter05Review.E 2 => (0 : MolecularDynamics.Chapter05Review.E 2)) μ := Measure.map_congr heq
  simpa [MolecularDynamics.Chapter05Review.diracMeasure,Measure.map_id,Measure.map_const] using hm

theorem eulerInvariant_no_probability_limit (h : ℝ) (_hh : h ≠ 0)
    (μ : Measure (MolecularDynamics.Chapter05Review.E 2)) (_hμ : IsProbabilityMeasure μ)
    (_hne : μ ≠ MolecularDynamics.Chapter05Review.diracMeasure 2) :
    ¬∃ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure ν ∧
      ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun k : ℕ ↦ ∫ z,φ ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) ∂μ)
          atTop (𝓝 (∫ z,φ z ∂ν)) := by
  sorry



/-- 修正版，对应原文 MD-5.6-EulerInvariant。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem eulerInvariant_corrected :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅离散Euler唯一不变概率及非Dirac初始概率无弱概率极限（补列）；实际modified模型一步对应由MD-5.6-EulerLogCorrespondence，弱稳态唯一/非吸引由MD-5.6-ForwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerInvariant`；`MD.Ch05.eulerInvariant_no_probability_limit`；`MD.Ch05.eulerInvariant_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。；[EXTRA] 除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；C：eulerInvariant量化非零h及所有概率μ，以真实forwardEuler保持μ为前提，结论μ=δ₀正确；no_probability_limit对每个非Dirac概率μ排除任何概率ν的全部有界连续测试函数弱极限，强度和量词正确，部分质量留在0也仍不紧。已给[EXTRA]诚实限定为离散概率测度，并将连续模型/弱稳态分配外部source_id；这些外部声明未在本任务摘录，不能认证其覆盖。原书声称唯一弱解若指所有分布而非概率测度，必须人工限定类别；亦不能把离散不变性直接当连续生成元核。故两条已给Lean声明本身通过，但整条原书弱稳态/稳定性尚不能PASS。 本条全部本地声明：MD.Ch05.eulerInvariant, MD.Ch05.eulerInvariant_no_probability_limit。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.eulerInvariant`：已证；`MD.Ch05.eulerInvariant_no_probability_limit`：未证（原书疑误不证）；`MD.Ch05.eulerInvariant_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2259)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardEuler · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$. Then it is easily shown that both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardEuler` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。 | [EXTRA] |

[EXTRA] [EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：本条statement_scope明确只定义解出的映射，任意实h和z=(q,p)返回((q+hp)/(1+h²),(p−hq)/(1+h²))。分母始终正，代回q′=q+hp′、p′=p−hq′成立；h=0是恒等映射。没有把原句谱或趋零含混放入定义，跨条目12和13在本批可直接核实且均补h≠0。[EXTRA]落实。 本条全部本地声明：MD.Ch05.backwardEuler。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.backwardEuler`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2312)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardEnergyDecay · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $n$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem backwardEnergyDecay : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 1)^2=
    (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.backwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.backwardEuler h x 1)^2=(1+h^2)⁻¹*((x 0)^2+(x 1)^2) := by
    have hd : 1+h^2 ≠ 0 := ne_of_gt (by positivity)
    simp [MolecularDynamics.Chapter05Review.backwardEuler]
    field_simp
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

theorem backwardEnergyDecay_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    let B := ((1+h^2 : ℝ)⁻¹ : ℂ) • A
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ B *ᵥ v=ζ • v) ↔
      ζ=(1+Complex.I*h)/(1+h^2) ∨ ζ=(1-Complex.I*h)/(1+h^2)) ∧
    ‖((1 : ℂ)+Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    ‖((1 : ℂ)-Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    1/Real.sqrt (1+h^2) < 1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 能量衰减与复谱/模；全部离散迭代趋零由MD-5.6-BackwardEulerLimit，连续模型对应和稳态由MD-5.6-EulerLogCorrespondence/BackwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardEnergyDecay`；`MD.Ch05.backwardEnergyDecay_spectrum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。 | [EXTRA] |

[EXTRA] [EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。；[EXTRA] 保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：首声明对所有h,z,k给平方范数乘((1+h²)⁻¹)^k，逆元与幂括号正确。spectrum在h≠0下以复矩阵B=(1+h²)⁻¹[[1,h],[-h,1]]刻画全部特征值(1±ih)/(1+h²)，两模1/sqrt(1+h²)且严格小于1；实分母转为复数无歧义。迭代趋零按scope归条目13且可核实，外部连续模型不在此条承诺范围。[EXTRA]与定义一致。 本条全部本地声明：MD.Ch05.backwardEnergyDecay, MD.Ch05.backwardEnergyDecay_spectrum。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.backwardEnergyDecay`：已证；`MD.Ch05.backwardEnergyDecay_spectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2318)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardEulerLimit · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point). In this case, all densities evolve toward the Dirac distribution centered at the origin: $\delta[q]\delta[p]$. The only (distributional) solution of $\mathcal L_{\widetilde f}\rho=0$ is again $\delta[q]\delta[p]$, which in this case is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem backwardEulerLimit :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0)) := by
  intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      simp only [Function.comp_apply]
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd



/-- 修正版，对应原文 MD-5.6-BackwardEulerLimit。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem backwardEulerLimit_corrected :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0)) := by
  intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      simp only [Function.comp_apply]
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardEulerLimit`；`MD.Ch05.backwardEulerLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；C：声明对每个h≠0同时给所有二维初值的离散轨道趋0，以及对任意初始概率μ、任意有界连续φ的积分随自然k趋φ(0)，即概率推前弱趋δ₀；无矩条件需求，量词和结论完整，[EXTRA]准确。没有给连续密度生成元稳态唯一性/连续吸引性，scope将其交外部两个source_id，本任务无其签名不可审。所给离散签名正确，但原页L无dagger和未限定分布类别是必须人工裁定的原书疑误。 本条全部本地声明：MD.Ch05.backwardEulerLimit。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.backwardEulerLimit`：已证；`MD.Ch05.backwardEulerLimit_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2349)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEuler · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> Now consider the application of the Symplectic Euler method, $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_n$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；复审采用用户指定的 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义：EuclideanSpace ℝ (Fin 2) 是二维欧氏相空间，WithLp.toLp 2 只是相同坐标的欧氏空间包装，volume 是 Lebesgue 测度，MeasurePreserving G μ μ 表示 G 可测且 Measure.map G μ=μ，IsProbabilityMeasure 表示总质量为1，Function.iterate 表示非负整数次迭代，Tendsto 表示相应拓扑/滤子的收敛，integral 是 Bochner 积分。不要求 Ch05_deps.txt 提供这些 Mathlib 定义体。项目定义已展开：Ch05_deps.txt:5315 的 MolecularDynamics.Chapter05Review.E n=EuclideanSpace ℝ (Fin n)。 MD.Ch05.symplecticEuler（Ch05.lean:1585）与项目库 symplecticEuler（Ch05_deps.txt:5402）都展开为 S_h(q,p)=((1−h²)q+hp,p−hq)。给定任意实步长和二维初值，先 p′=p−hq，再 q′=q+hp′，恰为原页两式，无量词限制、符号差异或额外假设。本引文只有方法定义，没有需要另行纳入的谱、椭圆或密度结论。证明状态单独记录：本声明文本不含 sorry；本轮未编译 Lean，也未据此声明完成传递依赖的公理审计。

### 7. 状态与证明位置

self-contained；`MD.Ch05.symplecticEuler`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2431)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEulerShadow · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\widetilde H_h(q,p)=\widetilde H_h(q_0,p_0)$, where $\widetilde H_h$ is the perturbed Hamiltonian defined by the backward error analysis.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerShadow : symplecticEulerShadow_statement := by
  apply MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved <;> assumption

def symplecticEulerLogScale (h : ℝ) : ℝ :=
  if h=0 then 1 else (2*Real.arcsin (h/2))/(h*Real.sqrt (1-h^2/4))

def symplecticEulerModifiedHamiltonian (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : ℝ :=
  symplecticEulerLogScale h*MolecularDynamics.Chapter05Review.shadowOscillator h z

def symplecticEulerModifiedFlow (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :
    MolecularDynamics.Chapter05Review.E 2 :=
  let A : Matrix (Fin 2) (Fin 2) ℝ := symplecticEulerLogScale h • !![-h/2,1;-1,h/2]
  WithLp.toLp 2 (NormedSpace.exp (t • A) *ᵥ WithLp.ofLp z)

theorem symplecticEulerShadow_modified_model (h : ℝ) (_hh : |h| < 2) :
    0 < symplecticEulerLogScale h ∧
    (∀ z,symplecticEulerModifiedFlow h h z=MolecularDynamics.Chapter05Review.symplecticEuler h z) ∧
    MolecularDynamics.Chapter05Review.flow
      (fun z : MolecularDynamics.Chapter05Review.E 2 ↦ WithLp.toLp 2
        ![(gradient (symplecticEulerModifiedHamiltonian h) z) 1,
          -(gradient (symplecticEulerModifiedHamiltonian h) z) 0])
      (symplecticEulerModifiedFlow h) := by
  sorry

theorem symplecticEulerShadow_modified_scale_order (R : ℝ) (_hR : 0 < R) :
    ∃ C > 0,∃ δ > 0,δ < 2 ∧ ∀ h : ℝ,|h| < δ →
      ∀ z : MolecularDynamics.Chapter05Review.E 2,‖z‖ ≤ R →
        |symplecticEulerModifiedHamiltonian h z-MolecularDynamics.Chapter05Review.shadowOscillator h z| ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-5.6-SymplecticEulerShadow。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticEulerShadow_corrected : symplecticEulerShadow_statement := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 一步二次不变量与实际主对数modified Hamiltonian/流对应及比例阶次；全部k和椭圆/零退化由MD-5.6-SymplecticEulerEllipse、连续概率稳态/非吸引由MD-5.6-SymplecticWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEulerShadow`；`MD.Ch05.symplecticEulerLogScale`；`MD.Ch05.symplecticEulerModifiedHamiltonian`；`MD.Ch05.symplecticEulerModifiedFlow`；`MD.Ch05.symplecticEulerShadow_modified_model`；`MD.Ch05.symplecticEulerShadow_modified_scale_order`；`MD.Ch05.symplecticEulerShadow_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留一步不变量证明，补稳定区内主对数Hamiltonian=c(h)·二次不变量、c>0、实际矩阵指数Hamiltonian流及其时间h恰为离散步，并给两能量有界域O(h²)比例差；全部k/椭圆由SymplecticEulerEllipse、弱稳态由SymplecticWeakStationary承担。新增模型是显式技术选择，不冒称唯一修正能量。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。；[EXTRA] 保留一步不变量证明，补稳定区内主对数Hamiltonian=c(h)·二次不变量、c>0、实际矩阵指数Hamiltonian流及其时间h恰为离散步，并给两能量有界域O(h²)比例差；全部k/椭圆由SymplecticEulerEllipse、弱稳态由SymplecticWeakStationary承担。新增模型是显式技术选择，不冒称唯一修正能量。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；C：symplecticEulerShadow_statement是所有实h、所有z的一步Q_h保持，Q_h=(q²+p²−hqp)/2；对摘录辛Euler步[[1−h²,h],[-h,1]]此恒等式正确。新增c(h)在h=0特判1，|h|<2内为正；A=c(h)[[-h/2,1],[-1,h/2]]正是cQ_h的Hamilton向量场。设s=sqrt(1−h²/4)，该未缩放矩阵平方=−s²I，角θ=2arcsin(h/2)满足sinθ=hs、cosθ=1−h²/2，故exp(hA)精确给数值步。flow定义含初值、群律和每时刻ODE，主模型全部合取正确，h=0亦成立。c(h)=1+h²/6+O(h⁴)，有界球上差界C h²合理，量词C,δ可依赖R。[EXTRA]准确；但原书无条件椭圆说法不成立，需保留疑误人工处理，新增正确模型不消除此原文问题。 本条全部本地声明：MD.Ch05.symplecticEulerShadow, MD.Ch05.symplecticEulerLogScale, MD.Ch05.symplecticEulerModifiedHamiltonian, MD.Ch05.symplecticEulerModifiedFlow, MD.Ch05.symplecticEulerShadow_modified_model, MD.Ch05.symplecticEulerShadow_modified_scale_order。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticEulerShadow`：已证；`MD.Ch05.symplecticEulerLogScale`：定义；`MD.Ch05.symplecticEulerModifiedHamiltonian`：定义；`MD.Ch05.symplecticEulerModifiedFlow`：定义；`MD.Ch05.symplecticEulerShadow_modified_model`：未证（原书疑误不证）；`MD.Ch05.symplecticEulerShadow_modified_scale_order`：未证（原书疑误不证）；`MD.Ch05.symplecticEulerShadow_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2437)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEulerEllipse · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the solution through any given initial point remains confined to an ellipse for all $n$ defined by $\widetilde H_h(q,p)=\widetilde H_h(q_0,p_0)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerEllipse : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z) := by
  intro h hh
  let d := 2-|h|
  have hd : 0 < d := by dsimp [d];linarith
  have lower (z : MolecularDynamics.Chapter05Review.E 2) :
      d*((z 0)^2+(z 1)^2) ≤ 4*MolecularDynamics.Chapter05Review.shadowOscillator h z := by
    unfold MolecularDynamics.Chapter05Review.shadowOscillator
    dsimp [d]
    by_cases hp : 0 ≤ h
    · rw [abs_of_nonneg hp]
      nlinarith [mul_nonneg hp (sq_nonneg (z 0-z 1))]
    · rw [abs_of_neg (lt_of_not_ge hp)]
      nlinarith [mul_nonneg (neg_nonneg.mpr (le_of_lt (lt_of_not_ge hp))) (sq_nonneg (z 0+z 1))]
  have normeq (z : MolecularDynamics.Chapter05Review.E 2) : ‖z‖^2=(z 0)^2+(z 1)^2 := by
    rw [EuclideanSpace.norm_sq_eq]
    simp [Fin.sum_univ_two,Real.norm_eq_abs]
  refine ⟨?_,?_,?_⟩
  · intro z hz
    have hnorm : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    have hl := lower z
    rw [←normeq] at hl
    nlinarith [mul_pos hd hnorm]
  · intro c
    have hc : Continuous (MolecularDynamics.Chapter05Review.shadowOscillator h) := by
      unfold MolecularDynamics.Chapter05Review.shadowOscillator;fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|/d+1)).of_isClosed_subset hclosed
    intro z hz
    have hl := lower z
    rw [←normeq] at hl
    change MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c at hz
    have hle : ‖z‖^2 ≤ 4*|c|/d := (le_div_iff₀ hd).mpr (by nlinarith [le_abs_self c])
    have hB : 0 ≤ 4*|c|/d := by positivity
    rw [Metric.mem_closedBall,dist_zero_right]
    nlinarith [norm_nonneg z]
  · intro z k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply',MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved,ih]

theorem symplecticEulerEllipse_geometry (h : ℝ) (_hh : |h| < 2) :
    {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=0}={0} ∧
    (∀ c : ℝ,0 < c → Nonempty
      (↥{z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=c} ≃ₜ
        ↥(Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) := by
  sorry



/-- 修正版，对应原文 MD-5.6-SymplecticEulerEllipse。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticEulerEllipse_corrected : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEulerEllipse`；`MD.Ch05.symplecticEulerEllipse_geometry`；`MD.Ch05.symplecticEulerEllipse_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]稳定条件\|h\|<2；原不加资格的椭圆说法在\|h\|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]稳定条件|h|<2；原不加资格的椭圆说法在|h|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。；[EXTRA] 保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS_HUMAN；C：修正版主定理对所有|h|<2给非零点Q_h>0、每个实c的次水平集紧性、每个z及全部自然k的能量保持；包含负c时空集和k=0。geometry另断言零能级={0}，每个c>0的能级与单位圆同胚，数学正确。二次型矩阵[[1,−h/2],[-h/2,1]]特征值1±h/2均正，结合显式二次型可认定几何椭圆；单独同胚本身只表达拓扑圆，不能作为一般集合是几何椭圆的充分定义。条目14还提供与主对数Hamiltonian的正比例联系，故修正版范围内能级与modified模型一致。[EXTRA]明确，sorry不构成签名FAIL。原文无稳定区及零初值例外须人工裁定。 本条全部本地声明：MD.Ch05.symplecticEulerEllipse, MD.Ch05.symplecticEulerEllipse_geometry。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticEulerEllipse`：已证；`MD.Ch05.symplecticEulerEllipse_geometry`：未证（原书疑误不证）；`MD.Ch05.symplecticEulerEllipse_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2481)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEulerDensity · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> This implies that a density which is a function of $\widetilde H_h$ will remain invariant under the associated Liouville equation. There are many solutions of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$, none of which is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerDensity :
  ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h) →
    MeasurePreserving (MolecularDynamics.Chapter05Review.symplecticEuler h) (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h))
      (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEulerDensity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。 | [EXTRA] |

[EXTRA] [EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对象为实二维欧氏相空间；对所有实 h 满足 |h|<2 及所有 r:ℝ→ℝ，前提要求 r∘shadowOscillator 可测、非负、可积且积分为1，结论为实际辛Euler映射对该密度测度的 MeasurePreserving。矩阵为 [[1-h²,h],[-h,1]]，行列式为1，保持 (q²+p²-hqp)/2，故结论正确；h=0亦无问题。能量与原modified Hamiltonian只差可能的h依赖常数因子，不改变“能量的函数”这一类。这里只通过已明示的离散密度不变范围；连续弱稳态、多解和非吸引不在该签名内，跨条映射仅记录，未以未提供的声明作为已核验证据。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticEulerDensity`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2551)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-VerletShadow2 · definition · 印刷p.208 / PDFp.229

### 2. 原文陈述

> For the Verlet scheme the modified Hamiltonian is
> \[\widetilde H_h=H+\frac{h^2}{24}\left(2p^TM^{-1}U''(q)M^{-1}p-\nabla U(q)M^{-1}\nabla U(q)\right)+O(h^4).\]
> Actually, as explained previously, we must interpret this carefully: a finite truncation of this expansion may characterize the discrete trajectories observed in practice, but the series expansion itself does not typically converge.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def verletShadow2 {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ) (h : ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  let v : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 fun i => z.2 i/m i
  (∑ i,z.2 i^2/m i)/2+U z.1+h^2/24*
    (2*(fderiv ℝ (fderiv ℝ U) z.1) v v-∑ i,(MolecularDynamics.Chapter05Review.grad U z.1 i)^2/m i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.verletShadow2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean4.34.0/Mathlibv4.34.0 的标准定义；未要求 Ch05_deps.txt 提供 Mathlib 定义体。项目自定义已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开：E n=EuclideanSpace ℝ (Fin n)，Phase n=E n×E n，grad H=gradient H，energySurface H c={z | H z=c}。附件声明和项目同名定义均展开为 v_i=p_i/m_i，H₂(q,p)=∑p_i²/(2m_i)+U(q)+(h²/24)(2D²U(q)[v,v]−∑(∂_iU(q))²/m_i)。fderiv、欧氏 gradient 与 WithLp.toLp 2 的标准含义直接给出矩阵式 pᵀM⁻¹U″M⁻¹p 和力平方项。对原书正对角质量矩阵、光滑 U，逐项系数、负号、对象一致；任意 n、m、U、h、z 的定义没有额外命题量词。本条 context_notation 明确是有限 h² 截断定义，PASS 限于该表达式：未证明原算法的 O(h⁴) 余项、近似轨道性质或形式级数不收敛。零质量/不可微函数上的总化值不被当作物理 Hamiltonian。无 [EXTRA] 或 [ERRATUM?]；定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.verletShadow2`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2559)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-Theorem51 · Theorem 5.1 · 印刷p.208–209 / PDFp.229–230

### 2. 原文陈述

> Theorem 5.1 Let $H(q,p)$ and $\widetilde H(q,p)=H(q,p)+\varepsilon\eta(q,p)$ be two Hamiltonian functions. Suppose the energy surface $\Sigma_E=\{(q,p)\mid H(q,p)=E\}$ to be compact and define the perturbed energy surface by $\widetilde\Sigma_E=\{(q,p)\mid\widetilde H(q,p)=E\}$, also assumed compact.
> Suppose that $w$ is an arbitrary smooth vector field such that $w\cdot\nabla H\ne0$ on $\Sigma_E$. Then the perturbation of the microcanonical average of a smooth function $g$ is given by
> \[\operatorname{Av}_{H=E}(g)-\operatorname{Av}_{\widetilde H=E}(g)=\operatorname{Av}_{\widetilde H=E}(\nabla\cdot gu)-\operatorname{Av}_{\widetilde H=E}(g)\operatorname{Av}_{\widetilde H=E}(\nabla\cdot u)+O(\varepsilon^2),\]
> where $u=\varepsilon\eta w/(w\cdot\nabla H)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem theorem51 :
  ∀ n (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c,
    0 < n → ContDiff ℝ ∞ H → ContDiff ℝ ∞ η → ContDiff ℝ ∞ g → ContDiff ℝ ∞ w →
    MolecularDynamics.Chapter05Review.regularEnergy H c → (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.theorem51` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |

[EXTRA] [EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化所有正维实欧氏空间、H/η/g/w及能量c；四个对象均C∞。regularEnergy明确含非空、紧、梯度非零及微正则原始质量有限正。统一紧集K同时包含ε邻域内全部扰动能量面（ε=0亦包含原面），其上分母不为零；这些是已披露的加强条件，防止从无穷远产生未控制分支。microRaw为面积测度乘1/‖∇H‖，microMeasure按总质量归一。结论完整保留平均差、校正项和存在C>0、δ>0对所有|ε|<δ成立的Cε²界。u的分母使用原H，两个右端平均使用H+εη，div(gu)包含g div u；符号及归一化协方差项与原式一致。任意正维推广不依赖辛结构，属合法几何推广。

### 7. 状态与证明位置

incomplete；`MD.Ch05.theorem51`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2567)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-PerturbationDisplacement · definition · 印刷p.209 / PDFp.230

### 2. 原文陈述

> $u=\varepsilon\frac{\eta}{w\cdot\nabla H}w$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def perturbationDisplacement {n : ℕ} (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  (ε*η z/inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)) • w z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.perturbationDisplacement` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean4.34.0/Mathlibv4.34.0 的标准定义；未要求 Ch05_deps.txt 提供 Mathlib 定义体。项目自定义已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开：E n=EuclideanSpace ℝ (Fin n)，Phase n=E n×E n，grad H=gradient H，energySurface H c={z | H z=c}。附件声明与项目同名定义逐点均为 u(z)=(εη(z)/⟨w(z),∇H(z)⟩)w(z)，与 PDF230 的分数、乘法和向量方向完全相同；H、η、w、ε 先作参数，再取 z。原书横截条件及 context_notation 明示相关带内分母非零，这属于该表达式的数学适用域，定义并未另断言位移公式在分母零处成立。Lean 实数除法的总化不构成此合格域上的差异。无 [EXTRA] 或 [ERRATUM?]；定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.perturbationDisplacement`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2581)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-PerturbationCorrection · definition · 印刷p.209 / PDFp.230

### 2. 原文陈述

> $\operatorname{Av}_{H=E}(g)-\operatorname{Av}_{\widetilde H=E}(g)=\operatorname{Av}_{\widetilde H=E}(\nabla\cdot gu)-\operatorname{Av}_{\widetilde H=E}(g)\operatorname{Av}_{\widetilde H=E}(\nabla\cdot u)+O(\varepsilon^2)$;

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.perturbationCorrection` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意维数、实值H/η/g、向量场w及实c/ε，定义Hε=H+εη、u=(εη/⟨w,∇H⟩)w，返回Av_Hε(div(gu))−Av_Hε(g)Av_Hε(div u)。乘法次序、负号、两处能量面及完整散度均正确。该定义是总函数，未假设光滑、正则或分母非零；这些条件应由使用它的定理提供，不能仅凭定义推得原公式。已披露范围仅为校正项。

### 7. 状态与证明位置

self-contained；`MD.Ch05.perturbationCorrection`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2586)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DenominatorBound · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> Suppose that $w$ is an arbitrary smooth vector field such that $w\cdot\nabla H\ne0$ on $\Sigma_E$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem denominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|) (MolecularDynamics.Chapter05Review.energySurface H c))
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.denominatorBound_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.denominatorBound` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数及H/w/c，假设原能量面紧、绝对分母在该面连续且分母逐点非零，结论是存在统一a>0使面上绝对分母≥a。非空情形用紧集上正连续函数的最小值；空面情形结论真空成立，故无需增补非空性。无需H光滑即可作为已明示的衍生引理成立；不替代Theorem5.1。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.denominatorBound`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2595)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SmoothDenominatorBound · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> Suppose that $w$ is an arbitrary smooth vector field such that $w\cdot\nabla H\ne0$ on $\Sigma_E$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem smoothDenominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c)) (hH : ContDiff ℝ 2 H) (hw : Continuous w)
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.smoothDenominatorBound_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.smoothDenominatorBound` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]由C² H、连续w自动得到实际连续分母和紧性下界；正式已证特殊后果，不当完整微正则扰动定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA]由C² H、连续w自动得到实际连续分母和紧性下界；正式已证特殊后果，不当完整微正则扰动定理。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数H/w/c；H为C²、w连续、能量面紧、横截分母非零。C²保证∇H连续，因而绝对内积连续，得到统一正下界；空能量面亦成立。C²/连续条件弱于原smooth，是合理的一般化且已在[EXTRA]披露；完整扰动公式不属于此条。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.smoothDenominatorBound`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2605)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ZeroPerturbation · unnumbered_claim · 印刷p.208–209 / PDFp.229–230

### 2. 原文陈述

> $\widetilde H(q,p)=H(q,p)+\varepsilon\eta(q,p)$; $u=\varepsilon\eta w/(w\cdot\nabla H)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem zeroPerturbation {n : ℕ} (H g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c ε :
    MolecularDynamics.Chapter05Review.perturbationCorrection H (fun _ => 0) g w c ε=0 := by
  apply MolecularDynamics.Chapter05Review.zeroPerturbation_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.zeroPerturbation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]η恒0时实际校正函数为0的直接后果；不将零扰动特例冒充任意η的平均误差定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA]η恒0时实际校正函数为0的直接后果；不将零扰动特例冒充任意η的平均误差定理。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数、H/g/w及c/ε，无额外正则假设，η恒0时位移恒为零。Lean实数除法的总化约定使0/0也为0；零向量场及g乘零场的导数、散度为零，两个零函数积分为零。因此实际perturbationCorrection恒0，对奇异面或零分母亦成立。结论严格限于校正量的零扰动特例。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.zeroPerturbation`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2614)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-GradientTransverse · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> A natural choice of the function $w$ that appears in the theorem is $w=\nabla H$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gradientTransverse :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
    ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (MolecularDynamics.Chapter05Review.grad H z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0 := by
  intro n H c hn z hz
  exact inner_self_ne_zero.mpr (hn z hz)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gradientTransverse` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正则能量面grad H非零，实际平方范数保证横截；不是任意能量处的无条件结论。 | [EXTRA] |

[EXTRA] [EXTRA]正则能量面grad H非零，实际平方范数保证横截；不是任意能量处的无条件结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean4.34.0/Mathlibv4.34.0 的标准定义；未要求 Ch05_deps.txt 提供 Mathlib 定义体。项目自定义已在 Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开：E n=EuclideanSpace ℝ (Fin n)，Phase n=E n×E n，grad H=gradient H，energySurface H c={z | H z=c}。先固定 n、H、c，要求能量面上 ∇H≠0，再对所有该面上的 z 得 ⟨∇H(z),∇H(z)⟩≠0。这是欧氏内积平方范数的标准性质，确实验证选取 w=∇H 的横截资格；任意正则 H 都适用。[EXTRA] 梯度非零必要且合理，也由原定理任何横截 w 的存在推出。原文光滑 H 的上下文使 ∇H 光滑，本声明没有声称对不光滑 H 的梯度也光滑；在该上下文中保留了选择及其适用条件。无 [ERRATUM?]；附件展示证明仅用 inner_self_ne_zero，无 sorry，本轮不编译、不补证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gradientTransverse`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2620)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DynamicalCorrection · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> The interpretation of a dynamical average (e.g. an autocorrelation function) as a stationary average means that we can apply the perturbation result to such computations as well.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dynamicalCorrection :
  ∀ n d (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c t,
    0 < n → ContDiff ℝ ∞ H → ContDiff ℝ ∞ η → ContDiff ℝ ∞ w →
    ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ (Φ t) → MolecularDynamics.Chapter05Review.regularEnergy H c →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧ MolecularDynamics.Chapter05Review.energySurface H c ⊆ K ∧
      (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) ∧
      ∀ ε ∈ Ioo (-δ) δ,MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K) →
    let g := fun z => inner ℝ (a (Φ t z)) (b z)
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.dynamicalCorrection` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |

[EXTRA] [EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化n/d、H/η/w、向量观测a/b、任意时间族Φ及固定c/t；n>0，相关函数及Φ t均C∞，原面regularEnergy，扰动面由同一紧K容纳且K上分母非零。g(z)=⟨a(Φ(t,z)),b(z)⟩光滑，对这个固定且不随ε变化的g，完整Cε²平均差结论是Theorem5.1的实例。不要求Φ为H的流，是对固定光滑pullback的合法推广；不证明H与Hε各自不同动力学之间的相关函数误差。[EXTRA]已明确这一限制，不能据此推广到随ε变化的Φ。

### 7. 状态与证明位置

incomplete；`MD.Ch05.dynamicalCorrection`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2630)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardNormDivergence · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> and we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardNormDivergence : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
  intro h hh z hz
  have hs : 0 < (z 0)^2+(z 1)^2 := by
    have hn : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    rw [EuclideanSpace.norm_sq_eq] at hn
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hn
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
      (1+h^2)^k*((z 0)^2+(z 1)^2) := by
    rw [EuclideanSpace.norm_sq_eq]
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
  apply tendsto_atTop.2
  intro b
  filter_upwards [ht.eventually (eventually_ge_atTop ((max b 0)^2+1))] with k hk
  rw [←he] at hk
  nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),le_max_left b 0,le_max_right b 0]



/-- 修正版，对应原文 MD-5.6-ForwardNormDivergence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem forwardNormDivergence_corrected : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
  intro h hh z hz
  have hs : 0 < (z 0)^2+(z 1)^2 := by
    have hn : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    rw [EuclideanSpace.norm_sq_eq] at hn
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hn
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
      (1+h^2)^k*((z 0)^2+(z 1)^2) := by
    rw [EuclideanSpace.norm_sq_eq]
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
  apply tendsto_atTop.2
  intro b
  filter_upwards [ht.eventually (eventually_ge_atTop ((max b 0)^2+1))] with k hk
  rw [←he] at hk
  nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),le_max_left b 0,le_max_right b 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardNormDivergence`；`MD.Ch05.forwardNormDivergence_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；C复审规则：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、内积、梯度、导数、Hausdorff测度、volume、Bochner integral、withDensity、restrict、ContDiff、HasCompactSupport、Tendsto 等均直接按其标准数学含义采信；未在依赖摘录中寻找Mathlib定义体，也不以缺少这些定义体为理由判NEEDS_HUMAN。实际读取的三个文件已重新计算SHA256，并与上一轮附件哈希逐一相等；不使用其他旧版Ch0x.lean或source.json。项目自定义项已按依赖的ReviewDefinitions文件和当前附件MD.Ch05本地定义展开核对。 依赖展开依据：Ch05_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean，E n=EuclideanSpace ℝ (Fin n)，采用欧氏范数；不是坐标上确界范数。 Lean只给非零步长、非零初值下欧氏范数趋于+∞，既没有特征值位于单位圆外的结论，也没有原文“两分量趋于无穷”的结论。[EXTRA]h≠0必要，非原点对应原文例外；修正为范数发散在数学上正确，但不能作为原句全部结论的忠实形式化。没有显式ERRATUM标签，必须明确登记原书疑误。此定理正文未见sorry，但证明存在不消除语义偏差。 复审仍判FAIL的原因是与原书结论的绑定差异，而非Mathlib范数或Tendsto含义不明。[EXTRA]已明确承认是独立修正，修正合理不等于原句语义相同。

### 7. 状态与证明位置

self-contained；`MD.Ch05.forwardNormDivergence`：已证；`MD.Ch05.forwardNormDivergence_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2647)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-WeakStationary · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$ is the point distribution $\delta[q]\delta[p]$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakStationaryModel {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  weakStationary f μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 从弱方程引用抽出的辅助技术定义；不是原书另立定义，唯一性结论由MD-5.6-ForwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakStationaryModel` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 仅弱PDE技术谓词，实际使用Blueprint修正后的C∞测试空间；原唯一概率断言由MD-5.6-ForwardWeakStationary承担。 | [EXTRA] |

[EXTRA] [EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。；[EXTRA] 仅弱PDE技术谓词，实际使用Blueprint修正后的C∞测试空间；原唯一概率断言由MD-5.6-ForwardWeakStationary承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数、向量场f及任意正测度μ，weakStationaryModel展开为对每个C∞紧支测试函数φ，Lie导数Dφ(f)可积且其μ积分为0；Lie使用fderiv的正确方向作用。这是弱散度方程的技术定义，允许Dirac且不强制绝对连续或概率归一化。定义本身不宣称唯一稳态，未把离散map不变性偷换为弱PDE；原书唯一概率结论已明确分流至另一source_id，此次不核验未给出的声明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakStationaryModel`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2691)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-WeakAttractor · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> this solution is not “asymptotically stable.”

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  IsProbabilityMeasure μ ∧ ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakAttractor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。 | [EXTRA] |

[EXTRA] [EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。；[EXTRA] 目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。

### 6. 审计结论

本轮修复：目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；有限族有界连续ψ、共同ε>0、对邻域内所有概率ν及所有有界连续φ的t→+∞收敛，正确编码了局部弱吸引的收敛部分。但是目标μ的域是所有Measure，签名既没有IsProbabilityMeasure μ参数，也没有将其作为合取条件。因此可选择不含任何概率测度的所谓邻域而令全称命题真空成立，与[EXTRA]“概率弱拓扑中某邻域”的承诺不符。该缺陷独立于原书否定吸引的断言；辅助定义分流不能补足目标对象的域。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakAttractor`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2698)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerLogField · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$ is the point distribution $\delta[q]\delta[p]$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerLogField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。 | [EXTRA] |

[EXTRA] [EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义在Bool、所有实h和二维z上：a=±log(1+h²)/(2h)，b=arctan(h)/h，场为(aq+bp,ap−bq)。h>0时forward径向增长、backward径向衰减，旋转方向均为(q̇,ṗ)=(p,−q)方向；对应矩阵分别I+hJ及(I−hJ)⁻¹的主实对数除以h。h=0的Lean总化值为零场，不是物理极限Jz，[EXTRA]明确排除该解释，故不判失败。定义未证明一步对应、ODE资格或一般BEA级数收敛，范围已披露。

### 7. 状态与证明位置

self-contained；`MD.Ch05.eulerLogField`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2709)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerLogFlow · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerLogFlow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。 | [EXTRA] |

[EXTRA] [EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。；[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对Bool、实h/t和二维z，返回exp(at)倍角度bt的顺时针旋转；在t=0恒为z，对t求导给出所列对数场，指数和旋转均满足时间加法。h>0时t=h的倍率为sqrt(1+h²)或其倒数，角为arctan h，分别得到前/后Euler一步。h=0时为恒等流，属已披露的总延拓。该技术定义不等同于任意数值方法有限截断的精确流，原文近似措辞及跨条对应义务均被保留。

### 7. 状态与证明位置

self-contained；`MD.Ch05.eulerLogFlow`：定义。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2717)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerLogCorrespondence · unnumbered_claim · 印刷p.206–207 / PDFp.227–228

### 2. 原文陈述

> Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by $\frac{\partial\rho}{\partial t}=\mathcal L_{\widetilde f}^{\dagger}\rho\overset{\mathrm{def}}{\equiv}\mathcal L_f^{\dagger}\rho+h^r\mathcal L_{f_{(r)}}^{\dagger}\rho$. […] Applying Forward Euler to the harmonic oscillator, we have $q_{n+1}=q_n+hp_n$, $p_{n+1}=p_n-hq_n$. […] As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerLogCorrespondence : ∀ h : ℝ,0 < h →
  (∀ z,eulerLogFlow false h h z=MolecularDynamics.Chapter05Review.forwardEuler h z ∧
    eulerLogFlow true h h z=MolecularDynamics.Chapter05Review.backwardEuler h z) ∧
  (∀ backward z t,HasDerivAt (fun s => eulerLogFlow backward h s z)
    (eulerLogField backward h (eulerLogFlow backward h t z)) t) := by
  intro h hh
  have hn : h ≠ 0 := ne_of_gt hh
  have hp : 0 < 1+h^2 := by positivity
  have hs : Real.sqrt (1+h^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hp)
  have he : Real.exp (Real.log (1+h^2)/2)=Real.sqrt (1+h^2) := by
    have he2 : (Real.exp (Real.log (1+h^2)/2))^2=1+h^2 := by
      rw [pow_two,←Real.exp_add]
      convert Real.exp_log hp using 1 <;> congr 1 <;> ring
    nlinarith [Real.exp_pos (Real.log (1+h^2)/2),Real.sqrt_nonneg (1+h^2),Real.sq_sqrt hp.le]
  have hbh : Real.arctan h/h*h=Real.arctan h := by field_simp [hn]
  have haf : (Real.log (1+h^2)/(2*h))*h=Real.log (1+h^2)/2 := by field_simp [hn] <;> ring
  have hab : (-(Real.log (1+h^2))/(2*h))*h= -(Real.log (1+h^2)/2) := by field_simp [hn] <;> ring
  constructor
  · intro z
    constructor <;> ext i <;> fin_cases i <;>
      simp [eulerLogFlow,MolecularDynamics.Chapter05Review.forwardEuler,
        MolecularDynamics.Chapter05Review.backwardEuler,hbh,haf,hab,Real.exp_neg,
        he,Real.cos_arctan,Real.sin_arctan]
    all_goals field_simp [hs] <;> simp only [Real.sq_sqrt hp.le] <;> ring
  · intro backward z t
    let a := (if backward then (-1 : ℝ) else 1)*Real.log (1+h^2)/(2*h)
    let b := Real.arctan h/h
    have ha := ((hasDerivAt_id t).const_mul a).exp
    have hc := ((hasDerivAt_id t).const_mul b).cos
    have hs := ((hasDerivAt_id t).const_mul b).sin
    have hq := ha.mul ((hc.const_mul (z 0)).add (hs.const_mul (z 1)))
    have hp := ha.mul ((hc.const_mul (z 1)).sub (hs.const_mul (z 0)))
    have hv : HasDerivAt (fun s : ℝ => ![Real.exp (a*s)*(z 0*Real.cos (b*s)+z 1*Real.sin (b*s)),
        Real.exp (a*s)*(z 1*Real.cos (b*s)-z 0*Real.sin (b*s))])
        ![a*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))+
            b*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t))),
          a*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t)))-
            b*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))] t := by
      apply hasDerivAt_pi.mpr
      intro i
      fin_cases i
      · convert hq using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
      · convert hp using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
    convert (PiLp.hasFDerivAt_toLp (𝕜:=ℝ) 2 _).comp_hasDerivAt t hv using 1
    · funext s
      ext i
      fin_cases i <;> simp [eulerLogFlow,a,b]
    · ext i
      fin_cases i <;> simp [eulerLogField,eulerLogFlow,a,b] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerLogCorrespondence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。 | [EXTRA] |
| 尚未覆盖的结论 | 原文密度Liouville演化 | 覆盖缺口，未声称已证明 |
| 尚未覆盖的结论 | 密度侧伴随算子及生成元线性分解 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。；[EXTRA] Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。

### 6. 审计结论

本轮修复：Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；两Euler更新和全时间线性ODE部分的对象、量词、正步长前提与计算均正确；对数场是合理的精确单步插值。整条引文还明确包含密度Liouville演化及生成元分解，当前签名未表达该部分，故按完整结论审校FAIL。此结论与证明是否含sorry无关。

### 7. 状态与证明位置

self-contained；`MD.Ch05.eulerLogCorrespondence`：已证。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2726)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardWeakStationary · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> To put it another way, the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$ is the point distribution $\delta[q]\delta[p]$, and this solution is not “asymptotically stable.”

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField false h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  ¬weakAttractor (eulerLogFlow false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardWeakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。 | [EXTRA] |

[EXTRA] [EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全体对象、域、量词、0<h前提、三项完整结论和[EXTRA]一致。以概率分布解读原书的distribution符合本节密度语境；不宣称所有未归一化或任意Schwartz分布的唯一性。签名正确，sorry不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch05.forwardWeakStationary`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2778)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardWeakStationary · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> The only (distributional) solution of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$ is again $\delta[q]\delta[p]$, which in this case is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem backwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField true h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  weakAttractor (eulerLogFlow true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardWeakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。 | [EXTRA] |

[EXTRA] [EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；除原文JSON的伴随上标转写外，签名完整、正确：所有正h，实际Backward Euler对数场及流，唯一概率弱稳态和弱吸引性均匹配。sorry不作FAIL依据。

### 7. 状态与证明位置

incomplete；`MD.Ch05.backwardWeakStationary`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2787)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticWeakStationary · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> This implies that a density which is a function of $\widetilde H_h$ will remain invariant under the associated Liouville equation. There are many solutions of $\mathcal L_{\widetilde f}^{\dagger}\rho=0$, none of which is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticWeakStationary : ∀ h : ℝ,|h| < 2 →
  let f := fun z : MolecularDynamics.Chapter05Review.E 2 => WithLp.toLp 2
    ![(gradient (symplecticEulerModifiedHamiltonian h) z) 1,-(gradient (symplecticEulerModifiedHamiltonian h) z) 0]
  ∀ Φ : ℝ → MolecularDynamics.Chapter05Review.E 2 → MolecularDynamics.Chapter05Review.E 2,MolecularDynamics.Chapter05Review.flow f Φ →
    (∀ r : ℝ → ℝ,MolecularDynamics.Chapter05Review.probabilityDensity (fun z => r (symplecticEulerModifiedHamiltonian h z)) →
      weakStationary f (MolecularDynamics.Chapter05Review.densityMeasure (fun z => r (symplecticEulerModifiedHamiltonian h z)))) ∧
    (∃ μ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ ∧ IsProbabilityMeasure ν ∧
      μ ≠ ν ∧ weakStationary f μ ∧ weakStationary f ν) ∧
    (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → weakStationary f μ → ¬weakAttractor Φ μ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticWeakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]稳定区\|h\|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 弱稳态接口使用前条实际一步对应的主对数modified Hamiltonian及其梯度场；函数能量密度、多种概率稳态和非吸引结论齐全，不把未按时间缩放的不变量场冒充数值步的时间h模型。 | [EXTRA] |

[EXTRA] [EXTRA]稳定区|h|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。；[EXTRA] 弱稳态接口使用前条实际一步对应的主对数modified Hamiltonian及其梯度场；函数能量密度、多种概率稳态和非吸引结论齐全，不把未按时间缩放的不变量场冒充数值步的时间h模型。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；稳定区内主对数Hamiltonian、梯度场、全时间真实流条件均正确。能量函数概率密度的弱稳态、至少两种不同概率稳态及全部概率稳态无弱吸引性三项完整。只需修正原文JSON的伴随上标；无需因sorry判FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticWeakStationary`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../Blueprint/Ch05.lean#L2797)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

