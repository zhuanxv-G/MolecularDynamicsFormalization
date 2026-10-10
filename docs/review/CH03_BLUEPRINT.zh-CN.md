# 第3章 Lean Blueprint 本地审阅材料

覆盖印刷p.97–136正文，习题除外。原文JSON审校状态见各条；本地模板C预审独立于网站审计。已整合网站返回0条，其余待网站审计；未冻结。编译和公理检查验证当前Lean陈述/证明，原文忠实性由独立审校核验。

| source_id | 页码 印刷/PDF | 本地预审 | 网站审计 | 状态 |
|---|---|---|---|---|
| MD-3-ModifiedConstruction | 97/119 | PASS | 待网站审计 | incomplete |
| MD-3.1-AdjointEulerOscillator | 98/120 | PASS | 待网站审计 | self-contained |
| MD-3.1-ShadowHamiltonian | 98/120 | PASS | 待网站审计 | self-contained |
| MD-3.1-EnergyFailure | 98/120 | PASS | 待网站审计 | checked+documented priors |
| MD-3.1-ShadowInvariant | 99/121 | PASS | 待网站审计 | checked+documented priors |
| MD-3.1-ShadowEllipses | 99/121 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-3.1-EulerGrowth | 100/122 | PASS | 待网站审计 | self-contained |
| MD-3.1-FormalHamiltonian | 100/122 | PASS | 待网站审计 | self-contained |
| MD-3.1-FormalHamiltonianField | 100/122 | PASS | 待网站审计 | self-contained |
| MD-3.2-LieDerivative | 100/122 | PASS | 待网站审计 | self-contained |
| MD-3.2-ObservableDerivative | 100–101/122–123 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-ObservableSecondDerivative | 101/123 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-OperatorExponential | 101/123 | PASS | 待网站审计 | self-contained |
| MD-3.2-FormalObservable | 101/123 | PASS | 待网站审计 | self-contained |
| MD-3.2-FiniteLieTaylor | 101/123 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-3.2-FlowCoordinates | 101/123 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-3.2-PoissonBracket | 102/124 | PASS | 待网站审计 | self-contained |
| MD-3.2-PoissonCoordinates | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-PoissonBilinearity | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-PoissonSkew | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-PoissonSelf | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-PoissonJacobi | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-HamiltonianObservableDerivative | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-HamiltonianLie | 102/124 | PASS | 待网站审计 | checked+documented priors |
| MD-3.2-HamiltonianCoordinateDerivative | 102/124 | PASS | 待网站审计 | checked+documented priors |

## 需要导师判断的问题

- MD-3.1-ShadowEllipses：Lean同时保留一般a,b,ε二次曲线旋转及轴长连续性、振子正定与线性标准形；“slightly rotated”的角度趋零在a=b退化主轴时不成立，字面定量含义仍需裁定，不能记PASS。
  一般a,b,ε椭圆旋转与振子特例之间仍需完整统一；不以特例冒充全部结论。
- MD-3.2-FiniteLieTaylor：旧清单添加了原书未显式写出的有限Taylor余项；完整有限签名保留并标EXTRA，独立审校前不将其称为原书逐字定理。
  是否将额外有限余项定理作为原文的忠实严格化，由导师/网站裁定；本地不进入证明。
- MD-3.2-FlowCoordinates：保留真实流、坐标、实际Lie形式系数及任意有限截断余项；原文形式等式与此额外有限解释的范围待独立审校，未把只证明坐标ODE当作整个结论。
  形式exp作用于坐标的等式无实际收敛主张；严格化为有限Taylor余项是否超出原文需裁定。

## 1. MD-3-ModifiedConstruction · unnumbered_claim · 印刷p.97 / PDFp.119

### 2. 原文陈述

> We can express the fundamental consequence as follows: not only are Hamiltonian flow maps symplectic, but also near-identity symplectic maps are (in an approximate sense) Hamiltonian flow maps [31]. The fact leads to the existence of a modified (perturbed) Hamiltonian from which the discrete trajectory may be derived (as snapshots of continuous trajectories). In some cases we may derive this perturbed Hamiltonian as an expansion in powers of the stepsize.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem modifiedConstruction :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.modifiedConstruction；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 近恒等、光滑、阶r≥1用smoothSymplecticData实际定义表达：开放凸D、紧凸B⊆D、H及(h,z)↦G_h(z)无限可微、G₀=id、逐h辛、实际原始ODE流和局部阶。 | [EXTRA] |
| 原文省略/技术资格 | 按任意有限截断匹配解释“in an approximate sense”；不将形式无限级数当实际收敛解，不将finiteMatching结论作前提。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch03.lean:21](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:21>)（`MD.Ch03.modifiedConstruction`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：缺形式jet的Hamiltonian构造、逐阶匹配及实际截断ODE的统一余项；属于大型向后误差分析理论，保留sorry。

签名SHA256：`26d8194741dfb244f0cc42e7f7fd0239a7edce61b68aacca039f8fc252aad899`；原文SHA256：`6172396c1a8ccaf362e87370db94fbb7b43d3654feaa980c0b88a4a3fd23e237`。

## 1. MD-3.1-AdjointEulerOscillator · definition · 印刷p.98 / PDFp.120

### 2. 原文陈述

> Let us begin with an illustrative example. Consider the harmonic oscillator with frequency $\Omega$ which has Hamiltonian $H(q,p)=p^2/2+\Omega^2q^2/2$, and consider the adjoint symplectic Euler method
> \[Q=q+hp,\qquad P=p-h\Omega^2Q,\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.oscillatorAdjointEuler；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:30](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:30>)（`MD.Ch03.oscillatorAdjointEuler`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`0c1bb261811e2f1dde9f82a5327bfb54d18c34d773330c0b0c991d8e2e97d994`；原文SHA256：`dd41553eac539488a8693f4be0a947792071092c4dbe8e33e24239e38a8f3bc7`。

## 1. MD-3.1-ShadowHamiltonian · (3.1) · 印刷p.98 / PDFp.120

### 2. 原文陈述

> However, if we modify the Hamiltonian from $H(q,p)=p^2/2+\Omega^2q^2/2$ to
> \[\widetilde H(q,p)=\frac{p^2+h\Omega^2pq+\Omega^2q^2}{2},\tag{3.1}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.oscillatorShadow；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:35](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:35>)（`MD.Ch03.oscillatorShadow`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`55e1272f00a4662019171c20d999abbc2a18c3c083849be650f11214838f897a`；原文SHA256：`2665546b8cf2df16e5eb2877036462285fadb330e0b3f9549a7c63fe8c8e09e1`。

## 1. MD-3.1-EnergyFailure · unnumbered_claim · 印刷p.98 / PDFp.120

### 2. 原文陈述

> If $H(q,p)=E$, then, for typical steps, we cannot expect $H(Q,P)=E$. (Just insert the formulas for $Q$ and $P$ into the Hamiltonian and check that the value is not the same as $H(q,p)$.)

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem oscillatorEnergyFailure :
    ∃ Ω h : ℝ, 0 < Ω ∧ h ≠ 0 ∧ ∃ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.oscillatorEnergyFailure；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。原文一般不守恒按存在实反例表达，不误称所有初值都不守恒；Ω=h=1,z=(1,0)给具体反例。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:38](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:38>)（`MD.Ch03.oscillatorEnergyFailure`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_proved。

签名SHA256：`c3931e29537f656ca3f1c15cf891c755cde21369f6e51af8cd95436b752f6b8c`；原文SHA256：`5f6068c438af8569c7ba973c03dec88acd8dab0e9cb1bf64f20b1a6e6881bab2`。

## 1. MD-3.1-ShadowInvariant · unnumbered_claim · 印刷p.99 / PDFp.121

### 2. 原文陈述

> This means that $\widetilde H$ is a conserved quantity of the numerical method.

### 3. 原文证明

> \[\begin{aligned}\widetilde H(Q,P)&=\frac{P^2}{2}+\frac{h\Omega^2PQ}{2}+\frac{\Omega^2Q^2}{2}\\
> &=\frac12p^2-\frac{h\Omega^2pQ}{2}+\frac{\Omega^2Q^2}{2}\\&=\widetilde H(q,p).\end{aligned}\]

原书计算按原页转录。

### 4. Lean陈述

```lean
theorem oscillatorShadowInvariant :
  ∀ Ω h z, oscillatorShadow Ω h (oscillatorAdjointEuler Ω h z)=oscillatorShadow Ω h z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.oscillatorShadowInvariant；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:45](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:45>)（`MD.Ch03.oscillatorShadowInvariant`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved。

签名SHA256：`53220a26b50d31d685a18d6b8ccdad370aaa54c5bf00fa101c196c8eed5a17b6`；原文SHA256：`b6287ea39e929689b1ce3b17227f667357233820fbff5aaee81a8b5c207b0ed0`。

## 1. MD-3.1-ShadowEllipses · unnumbered_claim · 印刷p.99 / PDFp.121

### 2. 原文陈述

> Recall that the graph of
> \[\frac{x^2}{a^2}+\frac{y^2}{b^2}=1\]
> is an ellipse with major and minor axes aligned to the coordinate axes. If $\epsilon$ is a small value, then,
> \[\frac{x^2}{a^2}+\frac{y^2}{b^2}+\epsilon xy=1\]
> will be a slightly rotated ellipse (with slightly different major and minor axes). Thus we can think of the energy surface of the numerical method as being a small perturbation of the ellipse which represents the ‘energy surface’ (energy curve, in this case) of the harmonic oscillator itself.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem shadowEllipses :
    (∀ a b : ℝ, a ≠ 0 → b ≠ 0 →
      ∃ δ > 0, ∃ θ A B : ℝ → ℝ,
        Tendsto A (𝓝 0) (𝓝 |a|) ∧ Tendsto B (𝓝 0) (𝓝 |b|) ∧
        (∀ ε ∈ Ioo (-δ) δ, 0 < A ε ∧ 0 < B ε ∧ ∀ x y : ℝ,
          x^2/a^2+y^2/b^2+ε*x*y =
            (Real.cos (θ ε)*x+Real.sin (θ ε)*y)^2/(A ε)^2+
            (-Real.sin (θ ε)*x+Real.cos (θ ε)*y)^2/(B ε)^2)) ∧
    (∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
      (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
      ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z,
        oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.shadowEllipses；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原文省略/技术资格 | 显式Ω>0、\|hΩ\|<2，排除退化与不稳定步长；线性等价给出振子二次型标准形。 | [EXTRA] |
| 原页核对/疑点 | 一般a,b,ε椭圆旋转与振子特例之间仍需完整统一；不以特例冒充全部结论。 | NEEDS_HUMAN |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。Lean同时保留一般a,b,ε二次曲线旋转及轴长连续性、振子正定与线性标准形；“slightly rotated”的角度趋零在a=b退化主轴时不成立，字面定量含义仍需裁定，不能记PASS。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch03.lean:52](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:52>)（`MD.Ch03.shadowEllipses`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：需一般正定二维二次型的轴长/旋转、小扰动连续性及与振子参数的完整对应；本地非PASS不进入证明。

签名SHA256：`2950fb774f3e8755df903baf21f0aa224b009872cd7f24928e3657142a125112`；原文SHA256：`4457c76ad555aa6eeeed74d12df3e97d6998346f36291916327c9f3c861b83b2`。

## 1. MD-3.1-EulerGrowth · unnumbered_claim · 印刷p.100 / PDFp.122

### 2. 原文陈述

> Obviously this conservation property (the existence of a perturbed energy surface) is a special feature of the method we have considered. If we used Euler’s method to solve the harmonic oscillator we would find that energy grows without bound.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem eulerOscillatorGrowth :
  ∀ Ω h : ℝ, Ω ≠ 0 → h ≠ 0 → ∀ z : ℝ × ℝ, 0 < oscillatorEnergy Ω z →
    Tendsto (fun ν : ℕ => oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z)) atTop atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.eulerOscillatorGrowth；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | Ω≠0、固定h≠0且初始能量>0，排除平衡点和零步长。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch03.lean:68](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:68>)（`MD.Ch03.eulerOscillatorGrowth`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`6b414991931764830cf3b1a8f87ee3faa08b5b5cc843e33981bc5cc9160c0b31`；原文SHA256：`35ad7e0995cba51751507d327ac7274d21beb3da22bc6be29910bc6bed5972b6`。

## 1. MD-3.1-FormalHamiltonian · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> Now consider the more general Hamiltonian setting. Let $\mathcal G_h$ be a $r$th order symplectic integrator, $r\ge1$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $\widetilde H_h$. If the method order is $r$, we may expect this Hamiltonian to be a $O(h^r)$ approximation of $H$, thus we posit an expansion of the form
> \[\widetilde H_h=H+h^rH^{(r)}+h^{r+1}H^{(r+1)}+\cdots.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.formalHamiltonian；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。仅定义原文所设形式展开；实际近似流的存在另列ModifiedConstruction，未借定义宣称向后误差理论成立。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:92](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:92>)（`MD.Ch03.formalHamiltonian`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`c7308ae7abc466efbd717aa8231d7529856efd97bd2a7311606add213a96d61c`；原文SHA256：`ca771d4563a622a4c41f1add5b9cc9d9029446d7e8bec19a53618f87e570a69b`。

## 1. MD-3.1-FormalHamiltonianField · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> To determine the terms $H^{(r)},H^{(r+1)},\ldots$, we write the differential equations on $\widetilde H_h$:
> \[\dot{\boldsymbol z}=J\nabla H+h^rJ\nabla H^{(r)}+h^{r+1}J\nabla H^{(r+1)}+\cdots.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

原文证明思路：

> The solution of this system can be expanded in powers of h and equated term-by-term with the expansion of G_h in powers of h. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.

### 4. Lean陈述

```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n)
    (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.formalHamiltonianField；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:97](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:97>)（`MD.Ch03.formalHamiltonianField`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`586d130fe17d7289bbc60ed3aca1a5727c9861b434b69cac9051b12b96bb0ce4`；原文SHA256：`499fdc69f73f2adcbb1551a9b6790607f6bc23e0023102940c11e0dc45a5693e`。

## 1. MD-3.2-LieDerivative · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> The right hand side suggests a shorthand notation. If we define the Lie derivative $\mathcal L_f$ by
> \[\mathcal L_f\phi=f\cdot\nabla\phi,\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.textbookLieDerivative；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:104](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:104>)（`MD.Ch03.textbookLieDerivative`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`568897e0d038d7a64bb00948ec5045c2014446c16bba7bc93488b691f9d2e415`；原文SHA256：`df4d1384eaf194b1998a0129abf0596fa1e220a56c5d6f7ab88c1162cc7a8444`。

## 1. MD-3.2-ObservableDerivative · (3.2) · 印刷p.100–101 / PDFp.122–123

### 2. 原文陈述

> At any point $\boldsymbol z=\boldsymbol\zeta$ in phase space assume that there is a unique solution $\boldsymbol z(t;\boldsymbol\zeta)$ such that $\dot{\boldsymbol z}(t)=f(\boldsymbol z(t))$, $\boldsymbol z(0)=\boldsymbol\zeta$ that is globally defined for all $t$. Now differentiate $\phi(t)=\phi(\boldsymbol z(t))$ with respect to time, using the chain rule, to see how $\phi(\boldsymbol z(t))$ is changing as $t$ is varied:
> \[\left.\frac{\mathrm d}{\mathrm dt}\phi\right|_{t=0}=\left[\sum_{i=1}^m\frac{\partial\phi}{\partial z_i}\dot z_i\right]_{\boldsymbol z=\boldsymbol\zeta}=\nabla\phi(\boldsymbol\zeta)\cdot f(\boldsymbol\zeta).\]
> and note that the origin of time is irrelevant, then the equation for the evolution of $\phi$ could be written
> \[\frac{\mathrm d}{\mathrm dt}\phi=(\mathcal L_f\phi)(\boldsymbol z).\tag{3.2}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem observableDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.observableDerivative；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。用任意实际解及任意时间点的真实链式法则表达；原文全局唯一性强于此局部结论所需，未新增解存在结论。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:108](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:108>)（`MD.Ch03.observableDerivative`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.hasDerivAt_textbookLieDerivative。

签名SHA256：`714e6477f16bacc079bf619047d96de6ffb311cd38ab94c0365077b6400648ba`；原文SHA256：`71f3f1bd0296a34a47854d5d29a17cf53510b07be8eb109ded9864d2606e4d01`。

## 1. MD-3.2-ObservableSecondDerivative · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> Similarly,
> \[\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))=(\mathcal L_f^2\phi)(\boldsymbol z(t)).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem observableSecondDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ)
    (hγ : ∀ t, HasDerivAt γ (f (γ t)) t) (t : ℝ) :
    HasDerivAt (fun u => deriv (fun v => φ (γ v)) u)
      (textbookLieDerivative f (textbookLieDerivative f φ) (γ t)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.observableSecondDerivative；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | f全域C¹、φ全域C²，显式化原文smooth及第二次求导资格。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:116](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:116>)（`MD.Ch03.observableSecondDerivative`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.hasDerivAt_textbookLieDerivative_second。

签名SHA256：`4f0579405e3800d20901e83140a41ad23ee7fdf0c682a235f73f205f9f627e66`；原文SHA256：`88f1ce70043560ccc14c265e04c85bd864275dc5927fc4e9ca2ca33e054a36f6`。

## 1. MD-3.2-OperatorExponential · definition · 印刷p.101 / PDFp.123

### 2. 原文陈述

> By analogy with the derivation of the matrix exponential, it is tempting to express the exponential as a series expansion in powers of $t$:
> \[e^{t\mathcal L_f}=\mathrm{Id}+t\mathcal L_f+\frac{t^2}{2}\mathcal L_f^2+\cdots.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
noncomputable def formalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.formalOperatorExponential；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:124](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:124>)（`MD.Ch03.formalOperatorExponential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`d8303f6a62fc6cb0979dc77a74cb3ccd4407e95ebd38a702de2ced3c21339030`；原文SHA256：`5fed55add00ff669250aef0227f44800c21d7aafda204b7ffd2b93ff12a98844`。

## 1. MD-3.2-FormalObservable · definition · 印刷p.101 / PDFp.123

### 2. 原文陈述

> The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as
> \[\begin{aligned}\phi(\boldsymbol z(t))&=\phi(\boldsymbol z(0))+t\left.\frac{\mathrm d}{\mathrm dt}\phi(\boldsymbol z(t))\right|_{t=0}+\frac{t^2}{2}\left.\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))\right|_{t=0}+\cdots\\
> &=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots\\
> &=(e^{t\mathcal L_f}\phi)(\boldsymbol z(0)).\end{aligned}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

原文证明思路：

> However, as $\mathcal L_f$ is a first order operator, this series involves high order mixed partial derivatives, and the convergence of the expansion has to be considered in connection with its application to given initial data, that is, we should consider the expansion
> \[e^{t\mathcal L_f}\phi=\phi+t\mathcal L_f\phi+\frac{t^2}{2}\mathcal L_f^2\phi+\cdots\]
> then the primary issue is the boundedness of the terms with respect to functions $\phi$ of a certain space of functions; we ignore the convergence issue here and treat the operator exponential as a formal series expansion.

### 4. Lean陈述

```lean
def formalObservable {n : ℕ} (f : Q n → Q n) (φ : Q n → ℝ) (z : Q n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => ((textbookLieDerivative f)^[j] φ) z/(Nat.factorial j : ℝ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.formalObservable；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:128](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:128>)（`MD.Ch03.formalObservable`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`10c8070f852dab6d1a5ac64c4144b83196579fb635db04f7f8dae8424c985c82`；原文SHA256：`2f4dd320b19f856d9942173d7ff3a267f2c082fde4e601eb58cbd79123b17fd7`。

## 1. MD-3.2-FiniteLieTaylor · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as
> \[\phi(\boldsymbol z(t))=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem lieTaylor :
  ∀ (n k : ℕ) (f : Q n → Q n) (φ : Q n → ℝ) (γ : ℝ → Q n),
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ φ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∃ C > 0, ∃ δ > 0, ∀ t ∈ Ioo (-δ) δ,
      |φ (γ t)-∑ j ∈ Finset.range (k+1), t^j/(Nat.factorial j:ℝ)*
        ((textbookLieDerivative f)^[j] φ) (γ 0)| ≤ C*|t|^(k+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.lieTaylor；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原文省略/技术资格 | [EXTRA]有限阶k+1统一局部余项是原文形式展开的额外严格有限解释，原文未明写常数C与δ。 | [EXTRA] |
| 原文省略/技术资格 | [EXTRA]f与φ取全域C∞并给定实际ODE解；不预设无限级数收敛。 | [EXTRA] |
| 原页核对/疑点 | 是否将额外有限余项定理作为原文的忠实严格化，由导师/网站裁定；本地不进入证明。 | NEEDS_HUMAN |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。旧清单添加了原书未显式写出的有限Taylor余项；完整有限签名保留并标EXTRA，独立审校前不将其称为原书逐字定理。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch03.lean:135](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:135>)（`MD.Ch03.lieTaylor`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：任意阶Lie迭代正则性与实际Taylor一致余项桥接尚缺；非PASS不证明。

签名SHA256：`6d05a317cf8151a341ecdf4195e6d6977eac82b2db946e15ac2fcdf5a5c58912`；原文SHA256：`db2ebeeac555b49c454879c99d1e7af9670501bcd7751772589c3dafdedc92d0`。

## 1. MD-3.2-FlowCoordinates · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> This gives a concise formula for the evolution of any function of the phase variables, including, in particular, any solution component $z_i$. Thus the flow map for the system can be represented by $\exp(t\mathcal L_f)$. When one writes $\mathcal F_t=\exp(t\mathcal L_f)$, what is actually meant is that the individual components satisfy
> \[z_i(t,\boldsymbol\zeta)=[\mathcal F_t(\boldsymbol\zeta)]_i=\left.(\exp(t\mathcal L_f)z_i)\right|_{\boldsymbol z=\boldsymbol\zeta}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem flowCoordinates :
    ∀ (n k : ℕ) (f : Q n → Q n) (D : Set (Q n))
      (Φ : ℝ → Q n → Q n) (η : ℝ),
      ContDiff ℝ ⊤ f → actualFlow f D Φ η →
      ∀ ζ ∈ D, ∀ i : Fin n, ∃ C > 0, ∃ δ > 0, δ ≤ η ∧
        ∀ t ∈ Ioo (-δ) δ,
          |Φ t ζ i - ∑ j ∈ Finset.range (k+1),
            t^j * PowerSeries.coeff j (formalObservable f (fun z => z i) ζ)|
            ≤ C * |t|^(k+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.flowCoordinates；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原文省略/技术资格 | 有限截断阶k+1真实余项是额外严格化，原文没有此显式不等式；f全域C∞。 | [EXTRA] |
| 原页核对/疑点 | 形式exp作用于坐标的等式无实际收敛主张；严格化为有限Taylor余项是否超出原文需裁定。 | NEEDS_HUMAN |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。保留真实流、坐标、实际Lie形式系数及任意有限截断余项；原文形式等式与此额外有限解释的范围待独立审校，未把只证明坐标ODE当作整个结论。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch03.lean:147](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:147>)（`MD.Ch03.flowCoordinates`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：缺实际流与高阶Lie Taylor系数的完整有限余项桥接；本地非PASS不证明。

签名SHA256：`7735f5d7b0be3e1a9c7a6df4e4402f4d51bf4237e0bc3494dfac3b2945484805`；原文SHA256：`9910a4b9224558593efeab041f3767cac066d80f2749ca77b44ffc6a23dd1667`。

## 1. MD-3.2-PoissonBracket · definition · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Another common notation for performing computations involving Hamiltonian systems is the Poisson bracket which is defined for two smooth scalar-valued functions $g_1$ and $g_2$ of the phase variables $(\boldsymbol q,\boldsymbol p)$ of a Hamiltonian system in $\mathbb R^m$ by
> \[\{g_1,g_2\}=\sum_{i=1}^N\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2,\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.textbookPoissonBracket；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch03.lean:159](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:159>)（`MD.Ch03.textbookPoissonBracket`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`8266f6e26328af2f7adab2f4687c220f4d9a91cec52c49dc8827ae913a282f63`；原文SHA256：`781873dac26b26126a19984d9988c81721f31dd72aeca762f61e1c317535909e`。

## 1. MD-3.2-PoissonCoordinates · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> \[\{g_1,g_2\}=\sum_{i=1}^N\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem poissonCoordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.poissonCoordinates；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:164](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:164>)（`MD.Ch03.poissonCoordinates`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.textbookPoissonBracket_coordinates。

签名SHA256：`fc204e4a12085afbf6e165072880e696ea62f0e05afbfed21dd312b67c8be055`；原文SHA256：`173c2c917b25d4f4394147907234c025a3b97316f2633d46cddca3879a692876`。

## 1. MD-3.2-PoissonBilinearity · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
> Bilinearity $\{g_1,\alpha g_2+\beta g_3\}=\alpha\{g_1,g_2\}+\beta\{g_1,g_3\}$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.poissonBilinearity；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:175](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:175>)（`MD.Ch03.poissonBilinearity`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.textbookPoissonBracket_linear_right; MolecularDynamics.textbookPoissonBracket_linear_left。

签名SHA256：`0ce95fe3b6022c4037005bcb781aaec02a78e5ed260027a064213f0ecc5bc97c`；原文SHA256：`dc2bbf27c4d8526148d09b04321fa83b070b939223eacb9651fc2c8947a1da61`。

## 1. MD-3.2-PoissonSkew · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Skew symmetry $\{g_1,g_2\}=-\{g_2,g_1\}$

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem poissonSkew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.poissonSkew；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:187](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:187>)（`MD.Ch03.poissonSkew`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.textbookPoissonBracket_skew。

签名SHA256：`0bcee02b8c56518d7993572a4832ddb0f5ada91b6b8a418c6f8cf52b8356b856`；原文SHA256：`d9096833d5e368b630706ab0ef31a622c53dae3929d5478b8271531d913d9ebe`。

## 1. MD-3.2-PoissonSelf · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> and this implies $\{g_1,g_1\}=0$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem poissonSelf (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.poissonSelf；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:193](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:193>)（`MD.Ch03.poissonSelf`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.textbookPoissonBracket_self。

签名SHA256：`ec538ae95cb7e2493014039e67bc9c8f098c5d267b5a55d386375a44e64d5a7f`；原文SHA256：`159f251282e8624f5b113750aa7b37f50e4afbeef00f95ed2312bda168afe42d`。

## 1. MD-3.2-PoissonJacobi · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Jacobi identity $\{g_1,\{g_2,g_3\}\}+\{g_3,\{g_1,g_2\}\}+\{g_2,\{g_3,g_1\}\}=0$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.poissonJacobi；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 显式各函数在z为C²；真实二阶导数对称性支持Jacobi。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:199](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:199>)（`MD.Ch03.poissonJacobi`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.textbookPoissonBracket_jacobi。

签名SHA256：`59b81a2dc289d562b491e7520921f3afd82560ba6dd761cd7e8ead98e3fb5782`；原文SHA256：`b9486d516b6c14dcb0f4ccb46471220ce487caec38eaeeb89438ad9950a2c89b`。

## 1. MD-3.2-HamiltonianObservableDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> More generally, if $F(\boldsymbol q,\boldsymbol p)$ is any smooth, scalar-valued function of the phase variables, we may write
> \[\dot F=\frac{\mathrm d}{\mathrm dt}F(\boldsymbol q(t),\boldsymbol p(t))=\{F,H\}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem hamiltonianObservableDerivative
    (F H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (t : ℝ) (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.hamiltonianObservableDerivative；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | smooth只需在γ(t)可微；ODE真实导数明示。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:209](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:209>)（`MD.Ch03.hamiltonianObservableDerivative`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.hasDerivAt_textbookLieDerivative。

签名SHA256：`c81326f54f8c48b94a66a5ab8143f38fe8d2a7355da400e934484701ce6a715b`；原文SHA256：`f911182cf8aad1932087e9b698a10598311ed146efc3be027012b75635801204`。

## 1. MD-3.2-HamiltonianLie · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:
> \[\mathcal L_{J\nabla H}F=\{F,H\}.\]
> For a Hamiltonian flow, we typically simplify notation by writing $\mathcal L_H$ in place of $\mathcal L_{J\nabla H}$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.hamiltonianLie_eq_poisson；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:218](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:218>)（`MD.Ch03.hamiltonianLie_eq_poisson`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson。

签名SHA256：`48399597724088ca0b52574346737cfd41019baa390d440f842b2e73732704cd`；原文SHA256：`e409dea4ea3a5a81d1b32ee6fef81b46a7683815ca64e03b4e0c9f507b137a17`。

## 1. MD-3.2-HamiltonianCoordinateDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> In terms of the Poisson bracket, it is possible to write the differential equation corresponding to a coordinate $q_i$, say, as
> \[\dot q_i=\{q_i,H\}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem hamiltonianCoordinateDerivative
    (H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (i : Fin Nc) (t : ℝ)
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => γ u (Sum.inl i))
      (textbookPoissonBracket (fun z => z (Sum.inl i)) H (γ t)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch03.hamiltonianCoordinateDerivative；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch03.lean:225](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch03.lean:225>)（`MD.Ch03.hamiltonianCoordinateDerivative`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

已登记前置证明/定义：MolecularDynamics.hasDerivAt_textbookLieDerivative。

签名SHA256：`4ddf5df53b67b123207eb2530ac9271cd849ffb9cb373904dc47cb84e105f38e`；原文SHA256：`cf42092e80ee12672718603bab998face577ae3439bdce34af2e5560eee0dfc7`。
