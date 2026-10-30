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

