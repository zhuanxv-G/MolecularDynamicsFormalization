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

## 需要导师判断的问题

- MD-3.1-ShadowEllipses：Lean同时保留一般a,b,ε二次曲线旋转及轴长连续性、振子正定与线性标准形；“slightly rotated”的角度趋零在a=b退化主轴时不成立，字面定量含义仍需裁定，不能记PASS。
  一般a,b,ε椭圆旋转与振子特例之间仍需完整统一；不以特例冒充全部结论。

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
