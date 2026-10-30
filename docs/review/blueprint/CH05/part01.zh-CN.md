上一部分：无 / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第5章 Lean Blueprint 本地审阅材料

183条；网站PASS 148，本地按意见修复6条（未再送网站），合并勘误26项。
统计与证明状态见[导师摘要](../../CH05_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](../../CH05_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch05/full/CHECK\_REPORT.json。

## 1. MD-5.1-LieDerivative · definition · 印刷p.180 / PDFp.201

### 2. 原文陈述

> In Chap. 3, we introduced the Lie derivative of a function $`g`$ of the phase variables with respect to a dynamical system $`\dot z=f(z)`$:

$$
\mathcal L_fg=f\cdot\nabla g.
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lie` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 实有限维欧氏空间中的 Fréchet 导数作用于 f(z)，在 g 可微处恰为 f·∇g；顺序和标量值域一致。定义本身未声明可微性，Lean 的 fderiv 在不可微处的全定义延拓不应解释为原书对不可微 g 的断言；数学作用域是有导数的可观测量。context\_notation 的 EuclideanSpace/fderiv 是实现说明，不是教材原句。无 [EXTRA]、[ERRATUM?]，定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lie`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L27)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-TrajectoryChain · unnumbered_claim · 印刷p.180 / PDFp.201

### 2. 原文陈述

> This is obtained by differentiating a composite function $`g(z(t))`$ with respect to $`t`$, along a solution trajectory. That is, describing a trajectory in terms of the flow map by $`z(t)=\mathcal F_t(\xi),t\in\mathbb R`$, we have

$$
\frac d{dt}g(\mathcal F_t(\xi))=(\mathcal L_fg)(\mathcal F_t(\xi)).
$$


> The partial derivative of $`\widetilde g(z,t)`$ with respect to $`t`$ is

$$
\frac{\partial\widetilde g}{\partial t}(t,z)=\nabla g(\mathcal F_t(z))\cdot\frac d{dt}\mathcal F_t(z)=\nabla g(\mathcal F_t(z))\cdot f(\mathcal F_t(z))=(\mathcal L_fg)(\mathcal F_t(z)).\tag{5.1}
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.trajectoryChain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。 | [EXTRA] |

[EXTRA] [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 依赖 MolecularDynamics/Chapter03/LiePoisson.lean:2527–2541 展开 textbookLieDerivative f φ z = (fderiv ℝ φ z)(f z)，并逐项读取 hasDerivAt\_textbookLieDerivative 的 hφ、hγ 和结论，未凭名称判定。E 是任意实赋范空间；f、φ、γ、t 任意，假设 φ 在 γ(t) 可微、γ 在 t 的导数为 f(γ(t))，结论给出复合函数的真实时间导数。取 γ(u)=Φ u ξ 即同时覆盖轨道式与固定 z 的式(5.1)；梯度点乘的中间计算由欧氏空间链式法则表达，未增加假设结论。局部可微 [EXTRA] 必要且合理；一般赋范空间是推广，不缩小欧氏对象。源式(5.1)的 (t,z) 保留为原书参数书写问题，Lean 固定 z 后沿时间求导消除此歧义。证明调用上述真实链式法则，无本条 sorry；未作编译认证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.trajectoryChain`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L31)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-ActualFlow · definition · 印刷p.180 / PDFp.201

### 2. 原文陈述

> describing a trajectory in terms of the flow map by $`z(t)=\mathcal F_t(\xi),t\in\mathbb R`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。 | [EXTRA] |

[EXTRA] [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 定义同时要求零时刻恒等、所有实时间的群律、每个初值上满足自治 ODE 的实际导数。对象是完整欧氏相空间上的全局流，时间与初值的全称量词对应原文 t∈ℝ 及任意初值。零时刻、群律是 flow map 的结构，ODE 条件忠实于 solution trajectory；[EXTRA] 合理而非结论循环。本条仅刻画已给定全局流，不声称任意向量场都有全局流；一般局部流需要另改定义域。定义无 sorry，无 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.flow`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L39)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-ObservablePullback · definition · 印刷p.180–181 / PDFp.201–202

### 2. 原文陈述

> Replacing $`\xi`$ by $`z`$ (it is an arbitrary point), define a function $`\widetilde g(z,t)\stackrel{\rm def}{=}g(\mathcal F_t(z))`$.
> It is intuitively appealing to define the solution of (5.2) by

$$
\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}.
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 任意 X、Φ、g、t、z 的定义直接等于 g(Φ t z)，覆盖原文的可观测量回拉。原文 G\_t=e^{t L\_f} 在 context\_notation 中明确作为此回拉解算子的记号，非收敛指数级数主张；已展开依赖 solutionOperator Φ t g = pullback Φ g t，因而符号解释有实际定义支持。将 Φ 专门化为 flow 时 Φ 0=id，使 g̃(·,0)=g，于是 G\_t g̃(·,0)=g̃(·,t)。泛型定义不要求流，是定义的自然推广；本条没有声称任意 Φ 的回拉满足 PDE。无 [EXTRA]、[ERRATUM?]，无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.pullback`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L44)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-FlowFieldTransport · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> On the other hand, viewing $`\mathcal L_f`$ as an operator on the phase variables only, we have

$$
(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))] =f(z)\cdot[\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))] =[\mathcal F_t'(z)f(z)]\cdot\nabla g(\mathcal F_t(z)) =f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z)) =(\mathcal L_fg)(\mathcal F_t(z)).
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flowFieldTransport`；`MD.Ch05.flowFieldTransport_observable` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。 | [EXTRA] |

[EXTRA] [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。；[EXTRA] 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全部对象为任意有限维实欧氏空间E n、自治向量场f、全时间实际流Φ。flow含零时恒等、群律及轨道ODE，联合C²保证初值可微。首声明保留DΦ\_t(z)f(z)=f(Φ\_t(z))；observable对任意C¹实值g及任意t,z给出链式中间式、向量场输运后的中间式及最终Lie交换式。转置/梯度写法与Fréchet导数作用等价；两条声明合并覆盖原等式链。[EXTRA]充分光滑资格明确，无循环前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.flowFieldTransport`：未证（缺大型理论）；`MD.Ch05.flowFieldTransport_observable`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L49)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-PullbackPDE · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> This is the same as the right hand side of (5.1). This means that $`\widetilde g`$ satisfies the equation

$$
\frac{\partial\widetilde g}{\partial t}=\mathcal L_f\widetilde g.\tag{5.2}
$$


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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pullbackPDE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 展开 HasDerivAt 结论中的 pullback 与 lie 后，正是 d/ds|s=t g(Φ\_s(z)) = D[g∘Φ\_t](../../z) f(z)，即式(5.2)。量词覆盖所有 n、f、Φ、g、t、z；真实 flow 排除了任意映射冒充 ODE 流。[EXTRA] 联合 C² 流和 C¹ 可观测量保证空间与时间求导合法，C² 强于所需 C¹，但合理而非循环。原文的线性/一阶输运（hyperbolic）说明是此算子的性质，不是额外 PDE 存在唯一性主张；签名覆盖本条 PDE 断言。正文有 sorry：语义 PASS，证明未完成，未编译认证。无 [ERRATUM?]。

### 7. 状态与证明位置

incomplete；`MD.Ch05.pullbackPDE`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L72)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-SteadyFirstIntegral · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The steady state solutions of this equation (defined by $`\partial\widetilde g/\partial t=0`$) are of the form $`\widetilde g(z,t)=\varphi(z)`$ where $`\varphi`$ satisfies $`\mathcal L_f\varphi(z)\equiv0`$. These are just the first integrals of the ordinary differential equation system $`\dot z=f(z)`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.steadyFirstIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。 | [EXTRA] |

[EXTRA] [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 任意 n、f、实际全局流 Φ、可微 g；结论双向：(∀z,Dg(z)f(z)=0) ↔ (∀t z,g(Φ\_t(z))=g(z))，无单向缺失或把恒定性作为前提。右边就是第一积分/回拉与时间无关，且可微轨道上时间导数为零等价于此恒定性，所以原文稳态形如 φ(z) 及 L\_fφ≡0 的两项通过该双向关系表达。[EXTRA] 对所有初值的真实 flow 与 g 可微必要且合理；群律在此证明并非必需，但作为 flow 的标准结构合理。源码含链式法则、零导数推出常值及反向导数唯一性的证明，无本条 sorry；未作编译认证。无 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.steadyFirstIntegral`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L80)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-CoordinatePullback · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The interpretation of the solution of the initial value problem in terms of the solution operator $`G_t`$ is given by

$$
(e^{t\mathcal L_f}\partial_i)(z(0))=z_i(t).
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.coordinatePullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch05.lean 对应附件为 /workspace/Ch05.lean。只读签名审计，未编译工程。依赖摘录 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5323 展开 E n = EuclideanSpace ℝ (Fin n)，lie f g z = (fderiv ℝ g z)(f z)，pullback Φ g t z = g(Φ t z)，flow f Φ = (∀z, Φ 0 z=z) ∧ (∀s t z, Φ(s+t)z=Φ s(Φ t z)) ∧ (∀t z, HasDerivAt (fun s => Φ s z) (f(Φ t z)) t)。 依赖 ReviewProofs.lean:5644–5645 的 coordinatePullback\_proved 已展开：pullback Φ (fun x => x i) t z = Φ t z i，由 rfl。E n 为实际 EuclideanSpace，i : Fin n 是坐标索引；可观测量 fun x => x i 忠实于原文明确规定的 ∂_i(z)=z\_i，绝非偏微分算子。取 z=z(0)，Φ 为实际 flow，右边为 z\_i(t)，G\_t/e^{tL\_f} 按本批 context\_notation 是回拉记号。对任意 Φ 的恒等式比实际流实例更一般，不需要流存在或算子指数收敛假设；无额外假设、无 [ERRATUM?]。源码复用 rfl 证明，无本条 sorry；未编译认证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.coordinatePullback`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L103)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-SolutionOperator · definition · 印刷p.181 / PDFp.202

### 2. 原文陈述

> $`\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.solutionOperator`；`MD.Ch05.solutionOperator_initial` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。 | [EXTRA] |

[EXTRA] [EXTRA] 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；solutionOperator对任意n,f及满足实际flow的Φ定义G\_t g=g∘Φ\_t，initial对任意g给出G₀g=g。以初值g定义g̃时，所引解算子关系由pullback直接表达。[EXTRA]与context明确e^(tL\_f)只作实际拉回算子的记号，未声称构造无界算子的指数级数；在该范围内定义忠实。

### 7. 状态与证明位置

incomplete；`MD.Ch05.solutionOperator`：定义；`MD.Ch05.solutionOperator_initial`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L109)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-CoordinateLie · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The projection onto the $`i`$th coordinate, denoted $`\partial_i`$, is itself a scalar valued function of $`z`$ ($`\partial_i(z)=z_i`$). Calculating directly we have $`\mathcal L_fz_i=f_i`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.coordinateLie` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、任意f、任意z和全部i:Fin n，真实坐标投影x↦x i的Lie导数等于f z i。坐标投影为连续线性函数，不需要f可微；没有把原书∂ᵢ误解成作用于其他函数的偏导算子。

### 7. 状态与证明位置

self-contained；`MD.Ch05.coordinateLie`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L124)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.1-LiePullbackCommutes · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

$$
(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]=f(z)\cdot[\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))]=[\mathcal F_t'(z)f(z)]\cdot\nabla g(\mathcal F_t(z))=f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))=(\mathcal L_fg)(\mathcal F_t(z))
$$

.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liePullbackCommutes` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实际自治流、联合C²的Φ及C¹实值g，对所有实时间t和z断言L\_f(g∘Φ\_t)(z)=(L\_fg)(Φ\_t z)。对象、作用变量与方向正确；原等式链的两端完整保存，中间链式法则等价，[EXTRA]为充分资格。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liePullbackCommutes`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L134)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> Let $`D\subset\mathbb R^m`$ be a suitable set comprising the collection of admissible phase space points $`z`$. A density on $`D`$ is a function $`\rho:D\to\mathbb R`$ such that (i) $`\rho(z)\geq0,z\in D`$, and (ii) $`\int_D\rho\,d\omega\lt \infty`$, where $`d\omega=dz_1dz_2\cdots dz_m`$ (i.e. $`\int_D\rho\,d\omega`$ is the integral of the measurable function $`\rho`$ in the Lebesgue sense).

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityOn` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。 | [EXTRA] |

[EXTRA] [EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182正文及脚注1要求Lebesgue可测D、可测ρ:D→ℝ、D内逐点非负与有限积分。实际定义展开为 NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧ (∀z∈D,0≤ρ z) ∧ IntegrableOn ρ D。NullMeasurableSet表达与Borel可测集几乎处处相同，恰为Lebesgue完备化可测；实值函数对受限测度的AEMeasurable对应完成测度下的可测性。IntegrableOn是对volume.restrict D的Bochner可积性，在非负实值条件下等价于原文有限Lebesgue积分，并排除了Bochner积分对不可积函数取0的误用。ρ写成全空间函数仅为域内函数选择任意域外延拓；所有资格和积分只依赖D内值，未要求域外非负或可积。n是原文m的任意有限维度重命名，无额外维数限制。[EXTRA]的可测域/函数及可积资格来自原文和脚注；AEMeasurable与IntegrableOn中的可测性部分重叠但无实质加强。无[ERRATUM?]。本条为定义，无证明占位问题。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L141)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-ProbabilityDensityOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> A probability density function (or p.d.f.) on $`D`$ is a density which is normalized so that $`\int_D\rho\,d\omega=1`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.probabilityDensityOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182给出“density which is normalized”及∫_Dρdω=1。实际 probabilityDensityOn D ρ := densityOn D ρ ∧ (∫z in D,ρ z)=1。递归展开densityOn后，完整保留Lebesgue可测D、受限可测ρ、D内逐点非负和可积，再附加同一D上的积分为1。对象为域D上的密度，不换成全空间密度；域外延拓不影响该条件。可积资格保证积分取实际值而非不可积时的默认0。无额外假设，无[ERRATUM?]。本条为定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.probabilityDensityOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L146)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityOnNormalization · unnumbered_claim · 印刷p.182 / PDFp.203

### 2. 原文陈述

> Any density (with positive total integral) can be normalized by dividing by $`\int_D\rho\,d\omega`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityOnNormalization` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182明确要求“with positive total integral”，并按∫_Dρdω相除。实际量词为∀n D ρ，假设依次为densityOn D ρ、0<∫_Dρ，结论为probabilityDensityOn D (z↦ρ(z)/∫_Dρ)。展开前后两个密度谓词，结论包含归一化函数的受限可测性、D内逐点非负、可积以及积分恰为1，全部原文结论均保留。原密度可积使分母有限，正性使分母非零；除以正常数保持资格，积分线性给出归一化。未把归一化当假设。正积分资格来自原书，非[EXTRA]；无[ERRATUM?]。本批附件附有证明且该声明无sorry；PASS仅评价签名语义，不宣称本轮已编译工程。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityOnNormalization`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L150)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityProbability · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> For any measurable subset $`A`$ of $`D`$, and probability density $`\rho`$, we define $`\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityProbability` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182定义可测A⊆D及概率密度ρ下的Pr(A)=∫_Aρdω。实际 densityProbability ρ A := ∫z in A,ρ z，恰为同一受限Lebesgue/Bochner积分。它作为总函数未把资格编码进参数，但也未声明所有输入都产生概率；本条context\_notation将资格留到后续界定理，实际densityProbabilityBounds签名确有probabilityDensityOn D ρ、A⊆D、NullMeasurableSet A volume。展开这些资格后，ρ在A上可积且非负，故定义在原书允许的输入上与Pr(A)完全一致，域外延拓无影响。对任意无资格输入的默认积分值不应解释成原书概率，当前声明及上下文没有作这种断言。无实质额外假设，无[ERRATUM?]。本条为定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityProbability`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L160)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityMeasureOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> For any measurable subset $`A`$ of $`D`$, and probability density $`\rho`$, we define $`\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityMeasureOn` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。 | [EXTRA] |

[EXTRA] [EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182同一Pr(A)=∫_Aρdω公式的测度表示。实际 densityMeasureOn D ρ := (volume.restrict D).withDensity (z↦ENNReal.ofReal (ρ z))。展开其使用的项目别名E后，在原文资格probabilityDensityOn D ρ及Lebesgue可测A⊆D下，withDensity给出对受限Lebesgue测度的非负扩展实值积分；ENNReal.ofReal在D内ρ≥0时不改变值，域外的负值或其他延拓不影响受限积分。故该测度对A的值为ENNReal.ofReal(∫_Aρ)，其toReal为densityProbability ρ A；总质量由∫_Dρ=1得到1，D外质量为0。签名允许一般ρ以定义总函数，不断言这些输入均为概率测度，也不限制任意概率测度必须有密度。[EXTRA]仅为将原书实值积分概率实现为测度的合理表示选择，无新增实质资格或遗漏原文事件公式。无[ERRATUM?]。定义的语义对应可在标准含义下判断，无需本轮补写桥接证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityMeasureOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L165)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-LebesgueClosure · unnumbered_claim · 印刷p.182 / PDFp.203

### 2. 原文陈述

> The technical requirement is that $`D`$ be Lebesgue-measurable. Open and closed sets in $`\mathbb R^m`$ are Lebesgue-measurable, for example a rectangular box. Sets which are constructed by taking countable unions or intersections of measurable sets are measurable.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lebesgueClosure` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182脚注1说明D的Lebesgue可测要求、开闭集（矩形盒示例）可测，以及可数并/交保持可测。实际∀n s (A:ℕ→Set(E n))，结论合取开集可测、闭集可测，以及若∀k A k可测则⋃k A k与⋂k A k均可测；四项均用NullMeasurableSet · volume，故是Lebesgue完备化可测族而非仅Borel族。前提顺序没有额外限制，可数族以ℕ索引覆盖可数并交，空族情形的空集与全空间同样可测。矩形盒作为示例由坐标区间的可测性及有限交给出，不要求把每种盒单独列为定理结论；D可测的上下文要求已在densityOn明确编码。无额外假设或[ERRATUM?]。本批附件有证明且该声明无sorry；本轮PASS是语义判定，不是编译结果。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lebesgueClosure`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L169)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-BorelSigma · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> A suitable family of sets on which Lebesgue measure can be defined is the so-called Borel $`\sigma`$-algebra obtained by countable unions, intersections, or relative complements of open balls in $`\mathbb R^m`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.borelSigma` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF203/印刷182脚注1末句指定由欧氏开球经σ代数生成得到的Borel族。实际 borelSigma n := borel (E n)。展开E后，标准borel是欧氏拓扑中由全部开集生成的最小σ代数；ℝⁿ有可数开球基，任意开集是该基中球的可数并，因此与由开球生成的σ代数一致。可数并、交和相对补是σ代数闭包操作，原文与定义的生成含义相同。context\_notation区分Borel与其Lebesgue完备化，与前条采用NullMeasurableSet相容；无缺失原文条件，无额外假设或[ERRATUM?]。本条为定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.borelSigma`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L179)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityProbabilityBounds · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> It is automatic that $`0\leq\operatorname{Pr}(A)\leq1`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityProbabilityBounds` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。 | [EXTRA] |

[EXTRA] 原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采用 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义。项目自定义 E 已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，其 volume 是标准Lebesgue测度。以下 MD.Ch05 自定义项按本批附件声明逐层展开；未用依赖中同名主题的全空间 density、probabilityDensity、densityMeasure 替代这些受限域定义。PDF204/印刷183首句给出0≤Pr(A)≤1，承接PDF203的可测A⊆D及概率密度ρ资格。实际∀n D A ρ，依次假设probabilityDensityOn D ρ、A⊆D、NullMeasurableSet A volume，结论同时保留0≤densityProbability ρ A及densityProbability ρ A≤1。递归展开后，前提为D Lebesgue可测、ρ受限可测、D内逐点非负、D上可积、∫_Dρ=1，以及可测A⊆D；结论为0≤∫_Aρ≤1。A上的非负与可积继承自D，积分单调性给出∫_Aρ≤∫_Dρ=1。注释中资格来自原文上下文，必要且合理，未引入实质[EXTRA]，未用“测度已是概率测度”代替密度归一化。无[ERRATUM?]。本批附件有证明且该声明无sorry；未进行本轮Lean编译，签名忠实性与证明状态分别评价。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityProbabilityBounds`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L183)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DomainL2 · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The set of functions from $`\mathcal D\subset\mathbb R^m`$ to $`\mathbb R`$ which satisfy (5.3) is referred to as the space $`L^2(\mathcal D)`$.

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
网站原返回（对应其审校版本）：NEEDS\_HUMAN；domainL2对任意n和D采用Lp ℝ 2 (volume.restrict D)，是可测平方可积函数的几乎处处等价类，数学上是合理的标准L²实现。[EXTRA]已披露AE商，然而原句字面是原生函数集合；这是原书的语义省略，不能把商空间静默当作逐字原文。修正方案合理，但忠实字面版与标准解释仍需人工确认。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2`：定义；`MD.Ch05.domainL2_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L201)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Norm · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> we define the $`L^2(\mathcal D)`$ norm by $`\|\phi\|_{L^2(\mathcal D)}\stackrel{\rm def}{=}[\int_{\mathcal D}\phi^2(z)\,d\omega]^{1/2}`$.

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
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L210)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Inner · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> for any $`\phi,\psi\in L^2(D)`$, the inner product is defined by $`\langle\phi,\psi\rangle_{L^2(D)}\stackrel{\rm def}{=}\int_D\phi(z)\psi(z)\,d\omega`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Inner` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）的 ∀φ,ψ∈L²(D)，⟨φ,ψ⟩=∫D φψ，对应 Ch05.lean:177–178 的 domainL2Inner f g := ∫ z in D, f z*g z。展开 domainL2，f、g 是同一限制测度下的实 L² 类；标准 Hölder/Cauchy–Schwarz 保证乘积可积，积分与代表选择无关。标准 L2.inner\_def 与实数内积的乘法表达表明它恰为真实 L² 内积。对象、全部输入及积分域一致，没有遗漏前提或加入额外前提。定义无 sorry，无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Inner`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L218)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2NormSquare · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> Thus $`\|\phi\|_{L^2(\mathcal D)}^2=\langle\phi,\phi\rangle_{L^2(\mathcal D)}`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2NormSquare` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对所有n,D及g:domainL2 n D断言domainL2Norm g²=domainL2Inner g g。摘录的inner确为∫_D g(z)g(z)，norm为Lp范数，实值域、平方与自内积的顺序正确；标准Lp资格已包含平方可积性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2NormSquare`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L222)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Complete · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> This is a real Hilbert space or complete inner product space in which, for any $`\phi,\psi\in L^2(\mathcal D)`$, the inner product is defined by $`\langle\phi,\psi\rangle_{L^2(\mathcal D)}\stackrel{\rm def}{=}\int_{\mathcal D}\phi(z)\psi(z)\,d\omega`$.

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
网站原返回（对应其审校版本）：NEEDS\_HUMAN；在domainL2采用标准AE商Lp解释下，∀n,D及所有Cauchy序列u存在同空间极限v的声明正确，等价于该度量空间完备性；Lp的实内积结构与积分自洽。但原书将前述原生函数集合直接称为Hilbert空间，正定性存在AE资格省略。[EXTRA]披露了修正；不能把修正版的正确性等同于原书字面正确性。所引内积积分定义不在本条主声明中，项目在条目7摘录了domainL2Inner，可作配套定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Complete`：已证；`MD.Ch05.domainL2Complete_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L231)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2SymmetricBilinear · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The inner product is a symmetric, bilinear operation: if $`\alpha,\beta`$ are real scalars and $`f,g,h\in L^2(D)`$, then $`\langle\alpha f+\beta g,h\rangle=\alpha\langle f,h\rangle+\beta\langle g,h\rangle`$, and $`\langle f,g\rangle=\langle g,f\rangle`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2SymmetricBilinear` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）的线性公式和对称公式，在 Ch05.lean:195–203 由合取同时保留：inner(a•f+b•g,h)=a*inner(f,h)+b*inner(g,h)，以及 inner(f,g)=inner(g,f)。n、D、f、g、h、a、b 均任意，全称量词中独立标量的位置换序无语义变化。展开 domainL2Inner 为乘积积分、domainL2 为真实 L² 类后，标准 Lp 的加法/实数标量乘法与代表元的逐点运算 a.e. 一致，全部乘积可积。对称性加左线性也蕴含右线性，故原文“symmetric, bilinear”完整保留。无新增前提。证明无 sorry；不将此事实与签名语义混淆，本轮未编译。无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2SymmetricBilinear`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L245)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-CompactL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The space $`L^2(\mathbb R^m)`$ includes for example the continuous functions with compact (closed, bounded) support, where the support of a function $`f`$ is the closure of the set of arguments for which the function is nonzero and is denoted $`\operatorname{supp}f`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.compactL2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）称欧氏空间上的连续紧支持实函数属于 L²，且 support 是非零集合的闭包。Ch05.lean:206–209 对任意 n 和 g:E n→ℝ，以 Continuous g 与 HasCompactSupport g 为前提，结论 MemLp g 2 volume。按标准含义 HasCompactSupport g 是 tsupport g 的紧性，tsupport=closure(Function.support g)，Function.support 是非零集合；因此与原书闭支持定义一致。在有限维欧氏空间中紧等价于闭且有界；连续紧支持函数有界且支集的 Lebesgue 测度有限，确为平方可积。MemLp 同时提供可测资格，正好表达原文包含关系，无须强行构造商类作为结论。对象、全部假设及结论一致，无额外假设。证明无 sorry，本轮未编译；无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.compactL2`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L256)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityAverageOn · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Given a density $`\rho`$, we may identify a collection of functions $`g`$ for which the integral with respect to $`\rho`$ is bounded, i.e. for which we can define the inner product $`\langle g,\rho\rangle=\int_Dg(z)\rho(z)\,d\omega`$, and thus we can define

$$
\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega.
$$


> We term this the spatial average of the function $`g`$ with respect to the probability measure associated to $`\rho`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityAverageOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.205（印刷 p.184）的空间平均定义，对应 Ch05.lean:212–213 的 densityAverageOn D ρ g := (∫D gρ)/(∫Dρ)，其中 E n 展开为欧氏 ℝⁿ。原文第一种写法 (∫Dρ)⁻¹⟨g,ρ⟩ 在本段将 ⟨g,ρ⟩定义为乘积积分，故与该比值相同；令 ρ̂(z)=ρ(z)/(∫Dρ)，Bochner 积分对常数因子的标准性质给出同一表达式 ∫D gρ̂，完整保留展示公式的两种表达，不需要要求 g、ρ 都属于 L²。原文的概率解释适用于非负可积密度、正的有限质量以及可积乘积；原 JSON 的 context\_notation 已明确这个解释范围。该 Lean 声明是比值的总化定义，并没有声称所有任意输入都生成概率测度；对零质量、负密度或不可积输入也给一个总化值不会构成对原文适用域内公式的反例，故撤回上一轮将这些输入作为 FAIL 反例的判断。Bochner 积分不可积时取0以及实数除法的总化均按标准库含义采信，未把这些扩展值解释为概率期望。项目依赖中 density（Measurable、非负、Integrable）、probabilityDensity（另要求质量1）、densityMeasure（volume.withDensity (ENNReal.ofReal∘ρ)）的定义可核对上述概率解释，但它们并不是本声明隐藏调用的前提。定义无需把所有适用域条件作为类型参数，也不额外冒称已经证明概率测度构造定理。定义无 sorry、无 [EXTRA] 或 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityAverageOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L262)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-ClosedSupport · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> the support of a function $`f`$ is the closure of the set of arguments for which the function is nonzero and is denoted $`\operatorname{supp}f`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.closedSupport` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采信 Mathlib 标准含义。已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开项目别名 E n := EuclideanSpace ℝ (Fin n)，对象为欧氏 ℝⁿ 上的实函数。附件 Blueprint/Ch05.lean 中 MD.Ch05.closedSupport f := tsupport f，展开标准含义就是 closure (Function.support f)=closure {z | f z ≠ 0}，与 PDF204/印刷183 正文支集定义完全一致。任意 n、任意 f，不添加连续性或紧性假设，不将支集误作未闭合的非零点集；完整返回该集合。本条没有 [EXTRA] 或 [ERRATUM?]。该声明是定义，无 sorry；PASS 仅评价定义语义，不声称完成 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch05.closedSupport`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L266)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-GaussianL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $`L^2(\mathbb R^m)`$ also includes many other types of functions important in molecular modelling, for example the multivariate Gaussian $`\exp(-\sum_{i=1}^m\alpha_i x_i^2)`$, where $`\alpha_i\gt 0,i=1,2,\ldots,m`$ are coefficients; such a function goes rapidly to zero as any $`x_i\to\infty`$, so the improper integral converges.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianL2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则采信标准 MemLp、EuclideanSpace 和 volume。已在 Ch05\_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)，所以体积为完整 ℝⁿ 上标准 Lebesgue 测度。签名先量化任意有限维 n、所有系数 a : Fin n → ℝ，再要求每个 a i > 0；结论 MemLp (exp(-∑ i,a i*(z i)^2)) 2 volume 恰为该实 Gaussian 可测且平方可积。与 PDF204/印刷183 脚注2所称任意正系数多元 Gaussian 属于 L²(ℝᵐ) 一致，未改为等系数径向函数、截断域或预先假设可积。原文“goes rapidly to zero”是可积性的解释，未单列为具有指定速率的极限定理；可测性由连续性自然满足，平方后仍为系数 2a i > 0 的 Gaussian，其平方积分为有限乘积 ∏ᵢ sqrt(π/(2a i))。允许 n=0 是无害扩展，空乘积为1。本条无 [EXTRA]/[ERRATUM?]。附件本条有证明正文且未含 sorry；语义 PASS 与编译及证明核验分开。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianL2`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L269)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-FiniteJumpL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $`L^2(\mathbb R^m)`$ also includes the compactly supported functions with finite “jump discontinuities” at a finite number of locations.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.finiteJumpL2` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。 | [EXTRA] |

[EXTRA] [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已从 Ch05\_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)；Mathlib 的 HasCompactSupport 表示 closure {x | g x ≠ 0} 紧，MemLp g 2 volume 表示对标准 Lebesgue 测度平方可积。签名依次量化 n、实函数 g、异常集 S，假设 S 有限、g 紧支、g 在 S 的补集连续，并在每个 z∈S 量化各自的 C>0 和邻域 U，使 U 中所有 |g x|≤C；结论只有完整 L² 归属，与 PDF204/印刷183 脚注2的结论一致。[EXTRA] 合理且不循环：有限跳跃具有有限邻域界，该条件还允许较一般的有界振荡，并不把有限跳跃当作精确定义的等价命题。它是对原文有限跳跃函数的充分资格，不排除原文中只有有限个跳跃位置的实函数。有限异常集外连续保证可测；各点局部有界和支集紧性给出统一有限界，紧集的 Lebesgue 测度有限，故平方可积。若仅要求紧支和有限异常点而省掉邻域控制，g(x)=1/x（0<x<1）、其余处为0将不平方可积；它不满足有限跳跃条件，也不是本签名反例。无 [ERRATUM?]，不修正原书。本条证明正文无 sorry；PASS 是签名语义判定，未运行编译。

### 7. 状态与证明位置

self-contained；`MD.Ch05.finiteJumpL2`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L293)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-NormalizedAverageFormula · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $`\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega`$.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalizedAverageFormula` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已从 Ch05\_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)。本条实际引用的项目定义是附件 Blueprint/Ch05.lean 中本地 MD.Ch05.densityAverageOn D ρ g := (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)，已读取并展开；它不是依赖摘录中定义在全空间的 MolecularDynamics.Chapter05Review.densityAverage。令 c=∫ x in D,ρ x，右端为 ∫ z in D,g z*(ρ z/c)，以受限 Lebesgue 测度积分。先量化 n、任意 D、ρ、g 后给出等式，保留 PDF205/印刷184 的平均积分比值和归一化密度 ρ̂=ρ/c 两种表示。按标准 Bochner 积分及实数除法的总化含义，常数因子可移出积分：c≠0 时可积性在乘以 c⁻¹ 后等价，不可积时两积分都按标准约定取0；c=0 时 ρ/c 恒0，等式两端皆0。因此无需额外密度、可积性或非零分母假设即可成立为代数恒等式。在教材的密度、正质量及有限配对条件下它就是原公式；JSON context 已明确该公式不宣称任意输入都有概率平均意义。无 [EXTRA]/[ERRATUM?]。证明正文无 sorry；PASS 评价语义，不等于 Lean 编译证明检查。

### 7. 状态与证明位置

self-contained；`MD.Ch05.normalizedAverageFormula`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L333)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MassFraction · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Let $`\rho(z,t)`$ be the probability density associated to a collection of phase points moving under a vector field $`f`$ on the phase space $`\mathbb R^m`$. Let $`\mathcal A`$ be a suitable region of volume $`V`$ within the phase space (say a rectangular $`m`$-dimensional box). The fraction $`\nu`$ of phase points present in $`\mathcal A`$ at time $`t`$ is the integral of $`\rho`$ over $`\mathcal A`$:

$$
\nu(t)=\int_\mathcal A\rho(z,t)\,d\omega,
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.massFraction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；massFraction对任意时间密度族ρ:ℝ→E n→ℝ、固定区域A及时间t定义∫_A ρ t。时间参数顺序与原ρ(z,t)仅是柯里化差异，积分域及Lebesgue体积正确。定义允许一般函数，不自行证明结果位于[0,1]；作为质量积分定义不需要把概率条件塞入定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.massFraction`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L339)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MassDerivative · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> which may be viewed as a smooth function of time. On the one hand

$$
\frac{d\nu}{dt}=\int_\mathcal A\frac{\partial\rho(z,t)}{\partial t}\,d\omega,
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
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
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L344)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-OutwardNormal · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> where $`n(z)`$ is the unit outward normal to the surface $`\partial \mathcal A`$ at the point $`z`$ and $`d\sigma`$ is the surface element.

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
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L381)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-GeneralFluxBalance · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> this same rate of change may be written as the negative of the particle flux over the boundary of $`\mathcal A`$:

$$
\frac{d\nu}{dt}=-\int_{\partial \mathcal A}f\cdot n\,\rho(z,t)\,d\sigma,
$$


> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:

$$
\frac{d\nu}{dt}=-\int_\mathcal A\nabla\cdot(f(z)\rho(z,t))\,d\omega.
$$



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
网站原返回（对应其审校版本）：PASS；两个结论本身在所列资格下合理：任意正维n、开放D与有界光滑开放A、closure A⊆D、真实外法线；f为D上C¹，Φ为全局C²实际自治流且保持D，ρ在ℝ×D上C¹，各时刻为D上的概率密度，受限密度测度按Measure.map输运。结论先给质量时间导数等于负边界通量，再给体散度积分等于边界通量，两者推出原第二式。hausdorffArea使用单位球体积/2^d归一化直径型Hausdorff测度，方向和负号正确。[EXTRA]中“不要求ρ在D外光滑或归一化”按“在D外”共同限定两项来读，与签名一致；为避免误读，corrected\_json进一步明确D内确有概率归一化要求。这是注释澄清，不构成定理签名错误。

### 7. 状态与证明位置

incomplete；`MD.Ch05.generalFluxBalance`：未证（原书疑误不证）；`MD.Ch05.generalFluxBalance_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L399)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-Divergence · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> $`\mathcal M_fw=-\nabla\cdot(wf)`$.

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
| 当前覆盖范围 | 仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M\_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.divergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M\_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | [EXTRA] |

[EXTRA] [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M\_f w=−div(wf)由MD-5.2.2-Liouvillian承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主定义对任意n、f:E n→E n和z取真实Fréchet导数的线性迹，正是可微向量场的散度。当前statement\_scope明确只是散度辅助定义，完整M\_fw=−div(wf)由本任务条目14实际提供，跨条映射可就所给文本核实，未将任意矩阵命名为Jacobian。不可微点的fderiv总化值不应被解释为经典散度存在。

### 7. 状态与证明位置

self-contained；`MD.Ch05.divergence`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L433)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-Liouvillian · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> The operator $`\mathcal M_f`$, defined for a scalar valued function $`w`$ by $`\mathcal M_fw=-\nabla\cdot(wf)`$, is called the Liouvillian operator.

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvillian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、向量场f、实值函数u与点z，liouvillian定义为−divergence(x↦u(x)•f(x))(z)。与原w的字母差异无语义影响，负号、乘积、空间导数及标量值域均正确。对经典含义需乘积向量场可微；当前定义为标准fderiv的总化扩展，没有断言任意函数经典可微。

### 7. 状态与证明位置

self-contained；`MD.Ch05.liouvillian`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L437)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleEquation · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> Therefore, since this should hold for an arbitrary domain $`\mathcal A`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\nabla\cdot(\rho f).
$$


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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleEquation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。 | [EXTRA] |

[EXTRA] [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n和开放流不变D，f在D上C¹、Φ为联合C²的实际自治流，ρ在ℝ×D上C¹且各时刻为D上的概率密度，受限密度测度由Φ\_t推前。结论对任意实t及所有z∈D给出HasDerivAt(ρ·z)(−div(ρ\_t f)(z)) t，完整对应连续性方程。输运测度等式是真实分布输运条件而非预设PDE；开放域和连续密度使AE等式可提升为点态等式。不要求D外ρ光滑，无未披露的循环前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvilleEquation`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L442)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleProduct · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> An alternative form for the continuity equation is:

$$
\frac{\partial\rho}{\partial t}=-\sum_i\left[\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right],
$$



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
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。 | [EXTRA] |

[EXTRA] [EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。；[EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；liouvilleProduct本身正确：对任意n,f、实值ρ及z，在f、ρ于z可微的条件下，−div(ρf)=−ρ div f−L\_fρ。此为静态乘积法则，且statement\_scope及[EXTRA]明确如此；它没有时间变量、HasDerivAt或任何输运前提，因此不能单独代表所引完整时间PDE。文本宣称完整坐标时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担，但该source\_id及声明不在本任务提供材料中，且用户禁止用旧工程补查，故跨条完整性待人工核实；不把正确辅助引理判为错误定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.liouvilleProduct`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L453)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LieCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

本条等式为从原页内积公式提炼的坐标辅助表达，并非原页独立展示式；完整原文时间PDE见MD-5.2.2-LiouvilleProductCoordinates。

> $`\mathcal L_fv=\sum_i f_i\frac{\partial v}{\partial z_i}`$.

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
网站原返回（对应其审校版本）：PASS；对任意n、f:E n→E n、g:E n→ℝ及z，将线性映射fderiv g z在f(z)上的值展开为所有i:Fin n的f\_i(z)乘其在真实正交规范基e\_i上的值。有限求和、系数、基向量与实值域正确；对可微g后一项即∂ᵢg。没有显式可微前提时，仍是总化Fréchet导数的线性恒等式，不是声称任意g存在经典偏导；[EXTRA]所说无需另造形式梯度成立。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lieCoordinates`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L474)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-DivergenceCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> $`\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right)`$.

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
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。 | [EXTRA] |

[EXTRA] [EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。；[EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；divergenceCoordinates正确断言任意n、f,z在f于z可微时，真实散度等于Σ\_i D(f\_i)(z)e\_i，是完整对角偏导和。它不含ρ或时间导数，statement\_scope已明确为辅助引理；所引原文却是完整连续性方程的乘积展开。其跨条承载者MD-5.2.2-LiouvilleProductCoordinates不在本任务材料，不能据名称确认该完整结论已保存；需要人工提供该声明核对。

### 7. 状态与证明位置

self-contained；`MD.Ch05.divergenceCoordinates`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L484)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleProductCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> An alternative form for the continuity equation is:

$$
\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right).
$$



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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
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
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L501)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-RectangularDomain · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Let $`A`$ be a suitable region of volume $`V`$ within the phase space (say a rectangular $`m`$-dimensional box).

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
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.rectangularDomain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。 | [EXTRA] |

[EXTRA] [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义；只从版本绑定的 Ch05\_deps.txt 展开项目自定义定义，不以 Mathlib 定义体未收录为材料不足。项目 ReviewDefinitions.lean 的 E n 展开为 EuclideanSpace ℝ (Fin n)，即欧氏 ℝⁿ，volume 是标准 Lebesgue 测度。项目 Statements.lean 的 rectangle a b={z | ∀i,a i≤z i ∧ z i≤b i}；boxFace a b i side={z | z∈rectangle a b ∧ z i=side}。展开 MD.Ch05.rectangularDomain 就是上述 rectangle。教材 PDF 页205在一般合适区域后明确给出矩形m维盒这一例子，本条将该例子的维数及坐标端点具体化，定义未冒称覆盖任意形状区域。体积V是区域体积的描述记号，不是额外数值结论。[EXTRA]矩形特化合理；本定义可用于空或退化盒是集合定义的自然延伸，后续通量定理另有a\_i<b\_i。没有漏掉本条的定理结论，也没有[ERRATUM?]。定义不含sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.rectangularDomain`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L520)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-FaceFlux · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $`\frac{d\nu}{dt}=-\int_{\partial A}f\cdot n\,\rho(z;t)\,d\sigma`$.

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
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 | [EXTRA] |

[EXTRA] [EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；按本条明确的statement\_scope审校：faceFlux是任意n、f、ρ、a、b、i及side上的单面无定向坐标通量辅助定义，而非原文整条质量守恒定理。boxFace取闭矩形中第i坐标等于side的面；hausdorffArea(n-1)采用单位球体积除2^(n-1)的Hausdorff面积归一化，积分ρ f\_i正确。side并未被限制到上下端点；作为辅助定义可总定义，实际上下端点在条目3中代入。条目3的下端减上端给出质量导数，与外法向符号一致。接受显式拆分后的矩形范围；没有据此确认本任务未提供的GeneralFluxBalance，也不将本定义认证为一般域通量定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.faceFlux`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L525)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

