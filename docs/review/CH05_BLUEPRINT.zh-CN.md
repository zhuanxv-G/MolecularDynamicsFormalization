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
| MD-5.2.1-DensityOn | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-ProbabilityDensityOn | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-DensityOnNormalization | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-DensityProbability | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-DensityMeasureOn | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-LebesgueClosure | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-BorelSigma | 182/203 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-DensityProbabilityBounds | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-DomainL2 | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-L2Norm | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-L2Inner | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-L2NormSquare | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-L2Complete | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-L2SymmetricBilinear | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-CompactL2 | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-DensityAverageOn | 184/205 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-ClosedSupport | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-GaussianL2 | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-FiniteJumpL2 | 183/204 | PASS | 待网站审计 | self-contained |
| MD-5.2.1-NormalizedAverageFormula | 184/205 | PASS | 待网站审计 | self-contained |

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

位置：[Blueprint/Ch05.lean:20](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:20>)（`MD.Ch05.lie`）。

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

位置：[Blueprint/Ch05.lean:24](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:24>)（`MD.Ch05.trajectoryChain`）。

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

位置：[Blueprint/Ch05.lean:32](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:32>)（`MD.Ch05.flow`）。

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

位置：[Blueprint/Ch05.lean:37](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:37>)（`MD.Ch05.pullback`）。

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

位置：[Blueprint/Ch05.lean:41](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:41>)（`MD.Ch05.flowFieldTransport`）。

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

位置：[Blueprint/Ch05.lean:49](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:49>)（`MD.Ch05.pullbackPDE`）。

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

位置：[Blueprint/Ch05.lean:57](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:57>)（`MD.Ch05.steadyFirstIntegral`）。

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

位置：[Blueprint/Ch05.lean:80](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:80>)（`MD.Ch05.coordinatePullback`）。

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

位置：[Blueprint/Ch05.lean:85](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:85>)（`MD.Ch05.solutionOperator`）。

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

位置：[Blueprint/Ch05.lean:88](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:88>)（`MD.Ch05.coordinateLie`）。

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

位置：[Blueprint/Ch05.lean:98](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:98>)（`MD.Ch05.liePullbackCommutes`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：所需FlowFieldTransport短桥已失败3条路线并停止；本条保留sorry，不以含sorryAx的引理伪造已证。

签名SHA256：`a82277477e3a09fadc4e119f854e7b7e3e1e17761d293d3832840fa96a5dae51`；原文SHA256：`a1f21729195e8b4ea56a9e0bb3387d3092c4bb7f510dfb761e027535400add78`。

## 1. MD-5.2.1-DensityOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> Let $D\subset\mathbb R^m$ be a suitable set comprising the collection of admissible phase space points $z$. A density on $D$ is a function $\rho:D\to\mathbb R$ such that (i) $\rho(z)\geq0,z\in D$, and (ii) $\int_D\rho\,d\omega<\infty$, where $d\omega=dz_1dz_2\cdots dz_m$ (i.e. $\int_D\rho\,d\omega$ is the integral of the measurable function $\rho$ in the Lebesgue sense).

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def densityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.densityOn；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:105](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:105>)（`MD.Ch05.densityOn`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`98b8e21182a24882ee9eeff0d0cc09baa4f2803ca20f42f2e4a7a32f2aeabd80`；原文SHA256：`4734355ec17700d6600c85bc496f39eb05c195bb19f4d0ab37efec0387ec9a21`。

## 1. MD-5.2.1-ProbabilityDensityOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> A probability density function (or p.d.f.) on $D$ is a density which is normalized so that $\int_D\rho\,d\omega=1$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def probabilityDensityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.probabilityDensityOn；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:110](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:110>)（`MD.Ch05.probabilityDensityOn`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`805015f8d69ea57c33a45b089fff62b97c4dd2105fa515fdc524ba00b61da552`；原文SHA256：`031e048b8d2afacd3029a99961a7b4fd529cb74c74b76d7452b74aa4cb33d64a`。

## 1. MD-5.2.1-DensityOnNormalization · unnumbered_claim · 印刷p.182 / PDFp.203

### 2. 原文陈述

> Any density (with positive total integral) can be normalized by dividing by $\int_D\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem densityOnNormalization : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityOn D ρ → 0 < (∫ z in D,ρ z) →
    probabilityDensityOn D (fun z => ρ z/(∫ x in D,ρ x))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.densityOnNormalization；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:114](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:114>)（`MD.Ch05.densityOnNormalization`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/DensityOnNormalization.json；blueprint/ch05/validation/short_search/route-9fac6262bb578b4ca64f.lean；blueprint/ch05/validation/short_search/route-9fac6262bb578b4ca64f.log。

签名SHA256：`ba1e9f0186f42af9a0ae509476532b3238b52f987b8d4ad417d6fa6d78ecc912`；原文SHA256：`45f6efed66034de3f41c6974dfe3e1496572321ed1e465dba051250d7a3f0eb6`。

## 1. MD-5.2.1-DensityProbability · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> For any measurable subset $A$ of $D$, and probability density $\rho$, we define $\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def densityProbability {n : ℕ} (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) : ℝ :=
  ∫ z in A,ρ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.densityProbability；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:124](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:124>)（`MD.Ch05.densityProbability`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`60da129be5a4e193c0beafee3d1583498a0d1a3e72f21a52b26d666f4d3e38a3`；原文SHA256：`ffbcb17d95fdd005853e83767e1cdb84d681cc0ba111d471081af4112c9a4408`。

## 1. MD-5.2.1-DensityMeasureOn · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> For any measurable subset $A$ of $D$, and probability density $\rho$, we define $\operatorname{Pr}(A)\stackrel{\rm def}{=}\int_A\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def densityMeasureOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.densityMeasureOn；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:129](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:129>)（`MD.Ch05.densityMeasureOn`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`5314dd5226170b725353d384e15bc27680da60e39b5dc61a57c7c3a9c4dcf3f7`；原文SHA256：`b4c17486456eeaf7e573899ff37b32c343ff6a658aa580e583408c8141ba1616`。

## 1. MD-5.2.1-LebesgueClosure · unnumbered_claim · 印刷p.182 / PDFp.203

### 2. 原文陈述

> The technical requirement is that $D$ be Lebesgue-measurable. Open and closed sets in $\mathbb R^m$ are Lebesgue-measurable, for example a rectangular box. Sets which are constructed by taking countable unions or intersections of measurable sets are measurable.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem lebesgueClosure : ∀ n (s : Set (MolecularDynamics.Chapter05Review.E n)) (A : ℕ → Set (MolecularDynamics.Chapter05Review.E n)),
  (IsOpen s → NullMeasurableSet s volume) ∧ (IsClosed s → NullMeasurableSet s volume) ∧
  ((∀ k,NullMeasurableSet (A k) volume) →
    NullMeasurableSet (⋃ k,A k) volume ∧ NullMeasurableSet (⋂ k,A k) volume)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.lebesgueClosure；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:133](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:133>)（`MD.Ch05.lebesgueClosure`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/LebesgueClosure.json；blueprint/ch05/validation/short_search/route-9fac6262bb578b4ca64f.lean；blueprint/ch05/validation/short_search/route-9fac6262bb578b4ca64f.log。

签名SHA256：`b72c4766c1b4d691e23f867352b5c6a862f390947843af5adabf9909fbe78273`；原文SHA256：`ec657829a9b635047743588658375a3d83f6d142e9bcd5f0a56a9bf5660f29c7`。

## 1. MD-5.2.1-BorelSigma · definition · 印刷p.182 / PDFp.203

### 2. 原文陈述

> A suitable family of sets on which Lebesgue measure can be defined is the so-called Borel $\sigma$-algebra obtained by countable unions, intersections, or relative complements of open balls in $\mathbb R^m$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def borelSigma (n : ℕ) : MeasurableSpace (MolecularDynamics.Chapter05Review.E n) := borel (MolecularDynamics.Chapter05Review.E n)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.borelSigma；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:143](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:143>)（`MD.Ch05.borelSigma`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`bd0833b2d4b403751e99e1cedfc1f585d3a9eff4d3afaca5029ddad5570e0108`；原文SHA256：`7c5cd8da6f455fb755491b3856eaee7a0800590ff403b58d445d756419a0ee9c`。

## 1. MD-5.2.1-DensityProbabilityBounds · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> It is automatic that $0\leq\operatorname{Pr}(A)\leq1$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem densityProbabilityBounds : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  probabilityDensityOn D ρ → A ⊆ D → NullMeasurableSet A volume →
    0 ≤ densityProbability ρ A ∧ densityProbability ρ A ≤ 1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.densityProbabilityBounds；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:147](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:147>)（`MD.Ch05.densityProbabilityBounds`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/DensityProbabilityBounds.json；blueprint/ch05/validation/short_search/route-9fac6262bb578b4ca64f.lean；blueprint/ch05/validation/short_search/route-9fac6262bb578b4ca64f.log。

签名SHA256：`8381f809ad5005032ca8e82f9179c9ec55c8f22033477112f0a8a8054b658a7e`；原文SHA256：`81f3342d0dbe2beeeead0a387da678174ec5a614d26f1cb2e5200279e0aecffa`。

## 1. MD-5.2.1-DomainL2 · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The set of functions from $D\subset\mathbb R^m$ to $\mathbb R$ which satisfy $\int_D\rho^2(z)\,d\omega<\infty$ is referred to as the space $L^2(D)$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.domainL2；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:164](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:164>)（`MD.Ch05.domainL2`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`0d715d1b5e97defffa21b24bd2903ff6b078caec04c7e482bf65004e6cca124c`；原文SHA256：`10ae9561349dad4a979e41e473822e2447330a46a4a8af03d530bcd8700187aa`。

## 1. MD-5.2.1-L2Norm · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> we define the $L^2(D)$ norm by $\|\rho\|_{L^2(D)}\stackrel{\rm def}{=}[\int_D\rho^2(z)\,d\omega]^{1/2}$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.domainL2Norm；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:167](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:167>)（`MD.Ch05.domainL2Norm`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`2ea5a2d7007015fe3646c8d6804cb808a031d0e7e1f1f3ae3981c123e6116776`；原文SHA256：`bbae12d61f657592c62ec0c22cf791f83e549a8fb09951edc723ea7127070509`。

## 1. MD-5.2.1-L2Inner · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> for any $\phi,\psi\in L^2(D)$, the inner product is defined by $\langle\phi,\psi\rangle_{L^2(D)}\stackrel{\rm def}{=}\int_D\phi(z)\psi(z)\,d\omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.domainL2Inner；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:170](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:170>)（`MD.Ch05.domainL2Inner`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`748ad005dc148616529498a7b693195eab16c5ec52ee2e0d8eb3e6c5c2aa0307`；原文SHA256：`168cc07fd487538bd499d16ae3870a735486217752d189160d0ce9ff4699768c`。

## 1. MD-5.2.1-L2NormSquare · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> Thus $\|\rho\|_{L^2(D)}^2=\langle\rho,\rho\rangle_{L^2(D)}$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.domainL2NormSquare；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:174](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:174>)（`MD.Ch05.domainL2NormSquare`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/L2NormSquare.json；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.lean；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.log。

签名SHA256：`fb866d12914ca47dfefd21332593236ec8d330aefda7321c7f68a63067804c8d`；原文SHA256：`48a1c19f1edee248201e6daebb42ca2aaa47bdb830ae026114d2fe5cd5e99522`。

## 1. MD-5.2.1-L2Complete · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> This is a real Hilbert space or complete inner product space.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.domainL2Complete；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:182](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:182>)（`MD.Ch05.domainL2Complete`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/L2Complete.json；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.lean；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.log。

签名SHA256：`bad5b576ee5f24f9e5489c13b9602cb5bd38e1b0ac6f7ab01d18aeedbc759a2f`；原文SHA256：`8ad31a215f4fdb2da5f8d916671698f2e7bacdb539af1ee2669b239a95a95a4b`。

## 1. MD-5.2.1-L2SymmetricBilinear · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The inner product is a symmetric, bilinear operation: if $\alpha,\beta$ are real scalars and $f,g,h\in L^2(D)$, then $\langle\alpha f+\beta g,h\rangle=\alpha\langle f,h\rangle+\beta\langle g,h\rangle$, and $\langle f,g\rangle=\langle g,f\rangle$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem domainL2SymmetricBilinear : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.domainL2SymmetricBilinear；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:188](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:188>)（`MD.Ch05.domainL2SymmetricBilinear`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/L2SymmetricBilinear.json；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.lean；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.log。

签名SHA256：`79dfc97b2f400c9c79f93b19534d64875caed6e74b0a9f74c9d4066c5d1577b0`；原文SHA256：`beb2af9b07e6aa63bcd0d8c5038dbeaf1d989165d4dd617ac97ca5e0e28b19f1`。

## 1. MD-5.2.1-CompactL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The space $L^2(\mathbb R^m)$ includes for example the continuous functions with compact (closed, bounded) support, where the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\operatorname{supp}f$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem compactL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.compactL2；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:199](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:199>)（`MD.Ch05.compactL2`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/CompactL2.json；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.lean；blueprint/ch05/validation/short_search/route-feabf35b719e6458f825.log。

签名SHA256：`f3fa335eb925af2162f5f8502036698ce664eea35edd39a534497a58479a64ed`；原文SHA256：`484aa24d1376f361807e82c71117a8549ef1755c3cafcea55edb1a23cccabc84`。

## 1. MD-5.2.1-DensityAverageOn · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Given a density $\rho$, we may identify a collection of functions $g$ for which the integral with respect to $\rho$ is bounded, i.e. for which we can define the inner product $\langle g,\rho\rangle=\int_Dg(z)\rho(z)\,d\omega$, and thus we can define
> \[\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega.\]
> We term this the spatial average of the function $g$ with respect to the probability measure associated to $\rho$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.densityAverageOn；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:205](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:205>)（`MD.Ch05.densityAverageOn`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`d1318fce9f64601f8a64d2558db41fef14c5bb0efc16f33206264b8c0067bafb`；原文SHA256：`a494cffbd0ddd571ab41b072abf1b7f06fdd6c1b96f536c1004ec4e820121a4e`。

## 1. MD-5.2.1-ClosedSupport · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\operatorname{supp}f$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def closedSupport {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) : Set (MolecularDynamics.Chapter05Review.E n) := tsupport f
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.closedSupport；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch05.lean:209](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:209>)（`MD.Ch05.closedSupport`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`7627bf18c22980c6c06f514f5574bab21f9ec50e8bd2ec3f9eb333b2b3bd103e`；原文SHA256：`9b1e6818eff8dc848e086c96cc11ccffa90e134d2cf02d26b597cf6855f5a192`。

## 1. MD-5.2.1-GaussianL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $L^2(\mathbb R^m)$ also includes many other types of functions important in molecular modelling, for example the multivariate Gaussian $\exp(-\sum_{i=1}^m\alpha_i x_i^2)$, where $\alpha_i>0,i=1,2,\ldots,m$ are coefficients; such a function goes rapidly to zero as any $x_i\to\infty$, so the improper integral converges.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.gaussianL2；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:212](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:212>)（`MD.Ch05.gaussianL2`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试3次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/GaussianL2.json；blueprint/ch05/validation/short_search/route-fc6c1508639bdba0254e.lean；blueprint/ch05/validation/short_search/route-fc6c1508639bdba0254e.log；blueprint/ch05/validation/short_search/route-33ad787e469546a83948.lean；blueprint/ch05/validation/short_search/route-33ad787e469546a83948.log；blueprint/ch05/validation/short_search/route-0ee23dfd17269a60820f.lean；blueprint/ch05/validation/short_search/route-0ee23dfd17269a60820f.log。

签名SHA256：`4418de09c191bdd9a21eb59cc3ac45df9495a63ed26393a7a8dc392a59414e31`；原文SHA256：`f3e0632b0f69b9d96b1f9e040f1c2c64632abc6622e3b1c7f09839b25cd61b0e`。

## 1. MD-5.2.1-FiniteJumpL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $L^2(\mathbb R^m)$ also includes the compactly supported functions with finite “jump discontinuities” at a finite number of locations.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem finiteJumpL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ) (S : Set (MolecularDynamics.Chapter05Review.E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.finiteJumpL2；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:236](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:236>)（`MD.Ch05.finiteJumpL2`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/FiniteJumpL2.json；blueprint/ch05/validation/short_search/route-fc6c1508639bdba0254e-FiniteJumpL2.lean；blueprint/ch05/validation/short_search/route-fc6c1508639bdba0254e-FiniteJumpL2.log。

签名SHA256：`dd551bf5445c7ba67fd7d7b9f48489baf3a69a101eec3e563a594cfc36f7068a`；原文SHA256：`9d774fd8e36eec8398b657103febdc70a0e9306858f1ba50adb21420f20bfe0b`。

## 1. MD-5.2.1-NormalizedAverageFormula · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem normalizedAverageFormula : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch05.normalizedAverageFormula；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch05.lean:276](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch05.lean:276>)（`MD.Ch05.normalizedAverageFormula`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch05/validation/short_search/NormalizedAverageFormula.json；blueprint/ch05/validation/short_search/route-fc6c1508639bdba0254e-NormalizedAverageFormula.lean；blueprint/ch05/validation/short_search/route-fc6c1508639bdba0254e-NormalizedAverageFormula.log。

签名SHA256：`6095e512284727b5375d85a473e327d3d42144ac57adc2e9e1cdf03be846fcdc`；原文SHA256：`f68dc526bb4055973dd1b6db66ba854e81d142da8c57c876178ec65f9f257a53`。
