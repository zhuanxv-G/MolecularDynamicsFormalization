# 第5章 Lean Blueprint 本地审阅材料

覆盖印刷p.179–209正文，习题除外。原文JSON审校状态见各条；本地模板C预审独立于网站审计。已整合网站返回0条，其余待网站审计；未冻结。编译和公理检查验证当前Lean陈述/证明，原文忠实性由独立审校核验。

| source_id | 页码 印刷/PDF | 本地预审 | 网站审计 | 状态 |
|---|---|---|---|---|
| MD-5.1-LieDerivative | 180/201 | PASS | 待网站审计 | self-contained |
| MD-5.1-TrajectoryChain | 180/201 | PASS | 待网站审计 | checked+documented priors |
| MD-5.1-ActualFlow | 180/201 | PASS | 待网站审计 | self-contained |
| MD-5.1-ObservablePullback | 180–181/201–202 | PASS | 待网站审计 | self-contained |
| MD-5.1-FlowFieldTransport | 181/202 | PASS | 待网站审计 | incomplete |
| MD-5.1-PullbackPDE | 181/202 | PASS | 待网站审计 | incomplete |
| MD-5.1-SteadyFirstIntegral | 181/202 | PASS | 待网站审计 | self-contained |
| MD-5.1-CoordinatePullback | 181/202 | PASS | 待网站审计 | checked+documented priors |
| MD-5.1-SolutionOperator | 181/202 | PASS | 待网站审计 | self-contained |
| MD-5.1-CoordinateLie | 181/202 | PASS | 待网站审计 | self-contained |
| MD-5.1-LiePullbackCommutes | 181/202 | PASS | 待网站审计 | incomplete |

## 需要导师判断的问题


## 1. MD-5.1-LieDerivative · definition · 印刷p.180 / PDFp.201

### 2. 原文陈述

> In Chap. 3, we introduced the Lie derivative of a function $g$ of the phase variables with respect to a dynamical system $\dot z=f(z)$:
> \[\mathcal L_fg=f\cdot\nabla g.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.lie；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:19](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:19>)（`MD.Ch05.lie`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`0684392412c84cacdec9c590f59e55fa11729b1be3ec126251217014993b7e6c`；原文SHA256：`49e117629a622193c0531983409012da6b4cdab4615bcca5733e3e73513809ef`。

## 1. MD-5.1-TrajectoryChain · unnumbered_claim · 印刷p.180 / PDFp.201

### 2. 原文陈述

> This is obtained by differentiating a composite function $g(z(t))$ with respect to $t$, along a solution trajectory. That is, describing a trajectory in terms of the flow map by $z(t)=\mathcal F_t(\xi),t\in\mathbb R$, we have
> \[\frac d{dt}g(\mathcal F_t(\xi))=(\mathcal L_fg)(\mathcal F_t(\xi)).\]
> The partial derivative of $\widetilde g(z,t)$ with respect to $t$ is
> \[\frac{\partial\widetilde g}{\partial t}(t,z)=\nabla g(\mathcal F_t(z))\cdot\frac d{dt}\mathcal F_t(z)=\nabla g(\mathcal F_t(z))\cdot f(\mathcal F_t(z))=(\mathcal L_fg)(\mathcal F_t(z)).\tag{5.1}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.trajectoryChain；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch05.lean:23](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:23>)（`MD.Ch05.trajectoryChain`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.hasDerivAt_textbookLieDerivative。

签名SHA256：`7983df7758a34f4cacdee3b7d8bd2f2641a912fd51f928af4244152992edef77`；原文SHA256：`9c7f3a9ba0309b5b21731c9719a692397ac3bf7779336cd501f18090436edc08`。

## 1. MD-5.1-ActualFlow · definition · 印刷p.180 / PDFp.201

### 2. 原文陈述

> describing a trajectory in terms of the flow map by $z(t)=\mathcal F_t(\xi),t\in\mathbb R$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.flow；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:31](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:31>)（`MD.Ch05.flow`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`46dd6bdf99871cab9c761b8d78d4d62dc74c03c80d2755a604b83fafa6edb74c`；原文SHA256：`8bcfbeb58dfdb3166c2211f9c25182fadd141a09d551f9362648fa16712079c6`。

## 1. MD-5.1-ObservablePullback · definition · 印刷p.180–181 / PDFp.201–202

### 2. 原文陈述

> Replacing $\xi$ by $z$ (it is an arbitrary point), define a function $\widetilde g(z,t)\stackrel{\rm def}{=}g(\mathcal F_t(z))$.
> It is intuitively appealing to define the solution of (5.2) by
> \[\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.pullback；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:36](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:36>)（`MD.Ch05.pullback`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`01eb19a48ae4e19a25031fc06f858585c16c6871cb882b49bf8ae9cc9bcb8810`；原文SHA256：`6554d58b5e37984f131124e332f98c8d3602cbc73c65ecf2f97a7e1caf1b5b96`。

## 1. MD-5.1-FlowFieldTransport · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> On the other hand, viewing $\mathcal L_f$ as an operator on the phase variables only, we have
> \[(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]
> =f(z)\cdot\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))
> =\mathcal F_t'(z)f(z)\cdot\nabla g(\mathcal F_t(z))
> =f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))
> =(\mathcal L_fg)(\mathcal F_t(z)).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem flowFieldTransport :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.flowFieldTransport；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch05.lean:40](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:40>)（`MD.Ch05.flowFieldTransport`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：三条短证明路线失败，停止该条；保存证据见validation/short_search/FlowFieldTransport.json。

本地路线尝试3次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/FlowFieldTransport.json；blueprint/ch05/validation/short_search/route-f1a939afe7f0f9c8af2f.lean；blueprint/ch05/validation/short_search/route-f1a939afe7f0f9c8af2f.log；blueprint/ch05/validation/short_search/route-6b1502d076f0e3c4ba8d.lean；blueprint/ch05/validation/short_search/route-6b1502d076f0e3c4ba8d.log；blueprint/ch05/validation/short_search/route-a62427897b1bc14d6e97.lean；blueprint/ch05/validation/short_search/route-a62427897b1bc14d6e97.log。

签名SHA256：`e5231ca58f9dc6b3ba1d99969c090d9e5a139230cad45f4e3e93e80a96a7121a`；原文SHA256：`5dbfd7f22c4becc79bf8987273b40c79e85cda43a47e7dd1022fc15d77f5cdd5`。

## 1. MD-5.1-PullbackPDE · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> This is the same as the right hand side of (5.1). This means that $\widetilde g$ satisfies the equation
> \[\frac{\partial\widetilde g}{\partial t}=\mathcal L_f\widetilde g.\tag{5.2}\]
> This is a time-dependent, linear (hyperbolic) partial differential equation.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem pullbackPDE :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => MolecularDynamics.Chapter05Review.pullback Φ g s z) (MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.pullbackPDE；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch05.lean:48](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:48>)（`MD.Ch05.pullbackPDE`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：所需FlowFieldTransport短桥已失败3条路线并停止；本条保留sorry，不以含sorryAx的引理伪造已证，不建设一般输运PDE适定性理论。

签名SHA256：`a06133924403bf8f2e3c857ae796abba38b3b37931cf8bdd6fe048de55bd6c79`；原文SHA256：`9e57734a6af69e7f81956d718a0328c1862aacab8f3cc32ca070d2ab53252306`。

## 1. MD-5.1-SteadyFirstIntegral · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The steady state solutions of this equation (defined by $\partial\widetilde g/\partial t=0$) are of the form $\widetilde g(z,t)=\varphi(z)$ where $\varphi$ satisfies $\mathcal L_f\varphi(z)\equiv0$. These are just the first integrals of the ordinary differential equation system $\dot z=f(z)$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem steadyFirstIntegral :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → Differentiable ℝ g → ((∀ z,MolecularDynamics.Chapter05Review.lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.steadyFirstIntegral；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:56](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:56>)（`MD.Ch05.steadyFirstIntegral`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/SteadyFirstIntegral.json；blueprint/ch05/validation/short_search/route-f1a939afe7f0f9c8af2f.lean；blueprint/ch05/validation/short_search/route-f1a939afe7f0f9c8af2f.log；blueprint/ch05/validation/short_search/route-6b1502d076f0e3c4ba8d-SteadyFirstIntegral.lean；blueprint/ch05/validation/short_search/route-6b1502d076f0e3c4ba8d-SteadyFirstIntegral.log。

签名SHA256：`616399a2c23ed0c9ba9fdc2af71dd5628f25b354e45b89c03d96d4155ec12e4d`；原文SHA256：`c0ddbd35803bfdbe0a53cf773cac68b0d6e7096f514c0b68ca2d7ecddb376dc6`。

## 1. MD-5.1-CoordinatePullback · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> The interpretation of the solution of the initial value problem in terms of the solution operator $G_t$ is given by
> \[(e^{t\mathcal L_f}\partial_i)(z(0))=z_i(t).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.coordinatePullback；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch05.lean:79](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:79>)（`MD.Ch05.coordinatePullback`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.Chapter05Review.coordinatePullback_proved。

签名SHA256：`83b95e784eac58dd520ee4703487e0efd1cae65f7f0a62b0b8dbf9493ea0f6fb`；原文SHA256：`18b1e43073b9571aaf2d08e589765b75f663a383f44f2d51f1608d8b881a3f7c`。

## 1. MD-5.1-SolutionOperator · definition · 印刷p.181 / PDFp.202

### 2. 原文陈述

> $\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := MolecularDynamics.Chapter05Review.pullback Φ g t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.solutionOperator；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:84](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:84>)（`MD.Ch05.solutionOperator`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`e2c6c1d6e6a46a560b295325352e0e12c173517d094d400cb0118249ea6afbde`；原文SHA256：`cae83b8c1b4de1b44cacf96edfd72490b20739f3b497226fcc258a234a687437`。

## 1. MD-5.1-CoordinateLie · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> In this notation, the symbol $\partial_i$ refers to the $i$th coordinate function of $z$ ($\partial_i(z)=z_i$). Calculating directly we have $\mathcal L_fz_i=f_i$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.coordinateLie；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:87](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:87>)（`MD.Ch05.coordinateLie`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/CoordinateLie.json；blueprint/ch05/validation/short_search/route-f1a939afe7f0f9c8af2f-CoordinateLie.lean；blueprint/ch05/validation/short_search/route-f1a939afe7f0f9c8af2f-CoordinateLie.log。

签名SHA256：`4481af43480dbc711d3c0f69c9183e7a09aa636aa74a59105b9f8c34bac5009a`；原文SHA256：`5d7de24de475425f5c5abc6b848ecd01634a70527e36c81c3b59831150b10ce7`。

## 1. MD-5.1-LiePullbackCommutes · unnumbered_claim · 印刷p.181 / PDFp.202

### 2. 原文陈述

> $(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]
> =f(z)\cdot\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))
> =\mathcal F_t'(z)f(z)\cdot\nabla g(\mathcal F_t(z))
> =f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))
> =(\mathcal L_fg)(\mathcal F_t(z))$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem liePullbackCommutes : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=MolecularDynamics.Chapter05Review.lie f g (Φ t z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.liePullbackCommutes；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch05.lean:97](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:97>)（`MD.Ch05.liePullbackCommutes`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：所需FlowFieldTransport短桥已失败3条路线并停止；本条保留sorry，不以含sorryAx的引理伪造已证。

签名SHA256：`a82277477e3a09fadc4e119f854e7b7e3e1e17761d293d3832840fa96a5dae51`；原文SHA256：`a1f21729195e8b4ea56a9e0bb3387d3092c4bb7f510dfb761e027535400add78`。
