[上一部分](part01.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-2.2.3-VerletExpansion · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> Combining terms of like powers of $`h`$, we have

$$
P=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{4}[F'F+p^2F'']+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletExpansion :
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletExpansion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F C³，使O(h⁴)余项有实际意义。 | [EXTRA] |

[EXTRA] F C³，使O(h⁴)余项有实际意义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；展开scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2。F C³足以在固定q,p处产生O(h⁴)动量余项；所减多项式逐项为p+hF+(h²/2)pF′+(h³/4)(F′F+p²F″)，系数、求导点和双侧h→0均正确。不把邻近页位置误差符号疑误归到本条动量公式。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletExpansion`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L488)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ExactExpansion · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> Since $`\dot q=p`$, we have $`\ddot q=\dot p=F(q)`$, and the third derivative is $`q^{(3)}=F'(q)p`$. On the other hand $`\dot p=F(q)`$ implies that $`\ddot p=F'(q)\dot q=pF'`$, and thus

$$
p^{(3)}=p^2F''+F'F.
$$


> The Taylor expansion of the solution is (taking $`q(t)=q`$, $`p(t)=p`$):

$$
q(t+h)=q+hp+\frac{h^2}{2}F+\frac{h^3}{6}F'p+O(h^4),
$$



$$
p(t+h)=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{6}[p^2F''+F'F]+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactExpansion :
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.exactExpansion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。 | [EXTRA] |

[EXTRA] F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；F C³、全时实际轨迹γ且γ′=(p,F(q))；在t=0处同时给出位置和动量的三阶Taylor多项式，余项均为双侧O(h⁴)。位置三阶项F′p/6，动量三阶项(p²F″+F′F)/6，全部导数在初始q上取值。原文先写的q″、q⁽³⁾、p″、p⁽³⁾为展开的链式法则推导，已由同一实际ODE与正则性支持，并未改为任意指定Taylor系数。时间原点平移资格已披露。

### 7. 状态与证明位置

incomplete；`MD.Ch02.exactExpansion`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L498)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-DefectPrinted · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> We now examine the series expansions for the exact and Verlet solutions and find that these differ in the third (and higher) order terms.

$$
Q-q(t+h)=\frac{h^3}{6}F'p+O(h^4),
$$


> and

$$
P-p(t+h)=\frac{h^3}{12}[p^2F''+F'F]+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem defectPrinted : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
  sorry



/-- 修正版，对应原文 MD-2.2.3-DefectPrinted。改动：位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。 -/
```

独立修正版：

```lean
theorem defectPrinted_corrected : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1+
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.defectPrinted`；`MD.Ch02.defectPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际轨迹、F C³；t=0归一。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。 | [EXTRA] |

[EXTRA] 实际轨迹、F C³；t=0归一。；[ERRATUM?] 位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt:3026–3028，MolecularDynamics/Chapter02/Statements.lean 的正式 scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2，确与教材算法对应。Ch02.lean:386–392 的对象、量词、C³ 及实际标量轨迹假设与原印一致；两个残差也字面保留原印正号。然而正式定义给 Q−q(h)=−h³F′p/6+O(h⁴)，故位置残差中再减 h³F′p/6 不成立。动量三阶缺陷 (p²F″+F′F)/12 正确。原印的字面忠实与命题的数学错误须区分：本条 FAIL 是确认原书错误已被写成假定理；[ERRATUM?] 成立，不是翻译错号。依赖内另有 verletDefectExpansion\_statement（3043–3048）明确采用修正符号，但本次判断来自展开计算，而非仅凭该名字。[EXTRA] C³、实际轨迹及自治时间平移合理，全轴条件强于必要。本声明体为 sorry；该事实独立于数学反例。

### 7. 状态与证明位置

incomplete；`MD.Ch02.defectPrinted`：未证（原书疑误不证）；`MD.Ch02.defectPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L512)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletConsistency · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> These relations can be summarized as telling us that

$$
\|\mathscr G_h(\boldsymbol z)-\mathscr F_h(\boldsymbol z)\|=\kappa(\boldsymbol z)h^3+O(h^4),
$$


> where $`\kappa(\boldsymbol z)=\kappa(q,p)`$ is a function of the position and momentum. We may then define

$$
\bar K=\max_{t\in[0,\tau]}\kappa(\boldsymbol z(t))
$$


> bounding the local error by (with neglect of the fourth order terms) $`\bar K h^3`$. Thus the Verlet method is consistent of order two.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletConsistency : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
  sorry



/-- 修正版，对应原文 MD-2.2.3-VerletConsistency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem verletConsistency_corrected : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletConsistency`；`MD.Ch02.verletConsistency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；检查全部量词与四部分结论：F C³、τ和δ正、γ在闭窗连续；Φ从每个z出发在统一局部时间窗满足实际ODE且Φ₀z=z；γ与Φ在所需正步长内一致。κ在range γ上连续非负并逐z给正侧h→0的h³主项及O(h⁴)；闭窗上存在真正达到的最大值K；另有统一C、δ₀使闭窗全部t的局部误差≤Ch³。正侧避免|h|³与h³混淆，C吸收余项而不强称C=max κ。该严格修正版合理，但来源忽略余项的界仍需人工确认。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletConsistency`：未证（原书疑误不证）；`MD.Ch02.verletConsistency_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L541)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletStability · unnumbered_claim · 印刷p.68–69 / PDFp.90–91

### 2. 原文陈述

> To complete the convergence proof for Verlet’s method, we would still need to verify the second assumption. This requires the assumption that the force field $`F`$ satisfy a Lipschitz condition:

$$
\|F(\boldsymbol u)-F(\boldsymbol w)\|\le\hat L\|\boldsymbol u-\boldsymbol w\|\tag{2.15}
$$


> for all $`\boldsymbol u,\boldsymbol w`$. Generally speaking this could be taken to hold in a neighborhood of the solution where all approximate solutions for $`h\lt \bar h`$ are assumed to lie. With a bit of effort, it is then possible to demonstrate the stability condition for the numerical method (see Exercise 4).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletStability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。 | [EXTRA] |

[EXTRA] 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐字核对印刷68页末段、式(2.15)和69页续段，一致。全空间力F的Lipschitz条件、正质量、L≥0、δ>0均在前提；C在h之前存在，故同一C适用于[0,δ]全部步长及全部相点z,w。Q是有限维坐标空间的上确界范数，Z是乘积最大范数；verlet确为含逆质量的速度Verlet位置/动量更新。更新为恒等映射加O(h)的全局Lipschitz扰动，有限步长窗吸收h²、h³项，因子1+hC合理。采用全空间版本而非局部邻域版本已明确披露，且h=0结论为恒等式。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletStability`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L580)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-FirstIntegral · definition · 印刷p.70 / PDFp.92

### 2. 原文陈述

> Recall that the condition for a given function $`I:\mathbb R^m\to\mathbb R`$ to be a first integral is that

$$
\nabla I(\boldsymbol z)\cdot f(\boldsymbol z)=\sum_{j=1}^m\frac{\partial I}{\partial z_j}(\boldsymbol z)f_j(\boldsymbol z)\equiv 0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  IsOpen D ∧ DifferentiableOn ℝ I D ∧ ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_firstIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。 | [EXTRA] |

[EXTRA] [EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原句、梯度点积、求和指标j=1,…,m及恒零号逐字一致。n为任意自然数，I:Q n→ℝ、f:Q n→Q n，D为开放域。谓词同时要求IsOpen D、I在D可微，以及每个z∈D的真实导数作用于f(z)为0；在开放域可微保证fderiv是经典导数，与原坐标求和相同。开放域是原文下一句明许的范围；未把不可微点总化导数为零误当条件。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_firstIntegral`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L590)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralPreserved · unnumbered_claim · 印刷p.70 / PDFp.92

### 2. 原文陈述

> It is important in this definition that this is an equivalence that holds everywhere (or at least in some open set in $`\mathbb R^m`$), so the statement is not just that $`I(\boldsymbol z(t))=I(\boldsymbol z(0))`$ for some particular trajectory, but, moreover, $`I`$ is conserved for all nearby initial conditions. The flow map preserves the first integral, thus $`I(\mathcal F_t(\boldsymbol z))\equiv I(\boldsymbol z)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem firstIntegralPreserved :
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a) := by
  intro n I f D γ a b hab hI hD hfirst hγD hγ
  have hd : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => I (γ s)) 0 (Icc a b) t := by
    intro t ht
    have hIt : DifferentiableAt ℝ I (γ t) :=
      (hI (γ t) (hγD ht)).differentiableAt (hD.mem_nhds (hγD ht))
    have hc : HasDerivWithinAt (fun s => I (γ s))
        ((fderiv ℝ I (γ t)) (f (γ t))) (Icc a b) t :=
      hIt.hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
    rw [hfirst (γ t) (hγD ht)] at hc
    exact hc
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.firstIntegralPreserved` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。 | [EXTRA] |

[EXTRA] 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷70页从It is important到I(F\_t(z))≡I(z)的原文、括号及所有初始条件措辞一致。量化任意n,I,f,D,γ,a,b，要求a≤b、I可微、D开放、firstIntegral逐点为零、γ在整个闭窗留域并满足真实ODE。结论对全部t∈[a,b]为I(γ(t))=I(γ(a))。任意γ的全称量化覆盖任意初始条件；a替代0为时间平移推广。a=b退化窗结论仍正确，端点没有遗漏。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.firstIntegralPreserved`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L595)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-EnergyPreserved · unnumbered_claim · 印刷p.70 / PDFp.92

### 2. 原文陈述

> For example, in a Hamiltonian system, the flow map conserves the energy:

$$
H\circ\mathcal F_t=H.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyPreserved (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.energyPreserved` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。 | [EXTRA] |

[EXTRA] 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Ch02\_deps.txt:33 的 SymplecticCoordinates Nc=(Fin Nc⊕Fin Nc)→ℝ；:41 的 textbookJ=fromBlocks 0 1 (-1) 0；:1921 的 textbookHamiltonianVectorField H z=J*ᵥ(fun i=>(fderiv ℝ H z)(Pi.single i 1))。依次为 (q,p) 坐标，基向量导数为 (H\_q,H\_p)，场为 (H\_p,−H\_q)，并非依名称推测。故 dH(场)=Σ(H\_q H\_p−H\_p H\_q)=0。任意 H、γ、τ，在轨道全部窗内点 H 可微及 γ 满足该场的实际闭窗ODE关系后，全部 t 得 H(γ t)=H(γ 0)，完整表达 H∘流=H。[EXTRA] 轨道可微和实际解是合理资格，未假定能量守恒；τ<0 空窗，τ=0 平凡。已读取 :2728 起复用定理的同一签名及链式求导论证。Ch02 正文调用库定理、无直接 sorry；不据此认证证明工程。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.energyPreserved`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L615)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-AngularMomentum · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> There may, in specific instances, be additional first integrals present. For example, in a planar 2-body system in central forces, the angular momentum $`xp_y-yp_x=l`$ is a conserved quantity, thus $`l\circ\mathcal F_t=l`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem centralAngularMomentum :
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.centralAngularMomentum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。 | [EXTRA] |

[EXTRA] 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已重读实际声明。右结合 ℝ×ℝ×ℝ×ℝ 为 (x,y,p\_x,p\_y)，全部投影和导数元组展开为 x′=p\_x、y′=p\_y、p\_x′=ρ(x²+y²)x、p\_y′=ρ(x²+y²)y。任意ρ、实际γ及 a<b，全部闭窗时间守恒 xp\_y−yp\_x；导数为 p\_x p\_y+xρy−p\_y p\_x−yρx=0。中心力相对坐标和单位约化质量是合理模型资格，固定正约化质量版本同样抵消动量交叉项，可通过单位选择对应；a<b 排除仅需平凡处理的退化窗。未宣称存在解，故不必为给定的实际可微解另加ρ正则性。[EXTRA] 合理，无 ERRATUM 标记。正文有直接 sorry，证明未完成与签名 PASS 分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.centralAngularMomentum`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L625)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralMeanValue · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> Now if $`I:\mathbb R^m\to\mathbb R`$ has continuous partial derivatives, we may conclude directly that

$$
I(\boldsymbol a)=I(\boldsymbol b)+\nabla I(\boldsymbol z_*)\cdot(\boldsymbol a-\boldsymbol b),
$$


> where $`\boldsymbol z_*`$ is a point on the line in $`\mathbb R^m`$ connecting $`\boldsymbol a`$ to $`\boldsymbol b`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem integralMeanValue :
  ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b = (fderiv ℝ I c) (a-b) := by
  intro n I D a b hD hs hI
  have hd : ∀ x ∈ segment ℝ a b, HasFDerivWithinAt I (fderiv ℝ I x) (segment ℝ a b) x := by
    intro x hx
    exact ((hI.differentiableOn (by norm_num) x (hs hx)).differentiableAt (hD.mem_nhds (hs hx))).hasFDerivAt.hasFDerivWithinAt
  obtain ⟨c,hc,heq⟩ := domain_mvt hd (convex_segment a b)
    (right_mem_segment ℝ a b) (left_mem_segment ℝ a b)
  refine ⟨c, ?_, heq⟩
  rw [segment_symm] at hc
  exact hc
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.integralMeanValue` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。 | [EXTRA] |

[EXTRA] 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际对象为 EuclideanSpace ℝ (Fin n)，即带欧氏内积的有限坐标空间，未使用 Q 的 Pi 最大范数。对所有 n,I,D,a,b，先假设开放D、整段 segment ℝ a b⊆D、ContDiffOn ℝ 1 I D（C¹），再存在 c∈segment，满足 I a−I b=(fderiv ℝ I c)(a−b)。在可微点该连续线性泛函作用就是 Σ∂ᵢI(c)(aᵢ−bᵢ)，故对象、量词顺序、同一见证及精确差值等式均忠实。闭线段是端点凸组合 {(1−s)a+s b:0≤s≤1}；a=b 亦有见证。[EXTRA] 局部开放域含整段是均值定理合理资格，D=univ 恢复原文全空间C¹假设；没有人为加强结论或偷添误差前提。正文无直接 sorry，不认证证明编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.integralMeanValue`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L637)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralLipschitz · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> Hence

$$
|I(\boldsymbol a)-I(\boldsymbol b)|\le\|\nabla I(\boldsymbol z_*)\|\|\boldsymbol a-\boldsymbol b\|.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem integralPointwiseBound : ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b=(fderiv ℝ I c) (a-b) ∧
      |I a-I b| ≤ ‖fderiv ℝ I c‖*‖a-b‖ := by
  intro n I D a b hD hs hI
  obtain ⟨c,hc,heq⟩ := integralMeanValue n I D a b hD hs hI
  refine ⟨c,hc,heq,?_⟩
  rw [heq, ← Real.norm_eq_abs]
  exact (fderiv ℝ I c).le_opNorm (a-b)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.integralPointwiseBound` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。 | [EXTRA] |

[EXTRA] 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷71页Hence及不等式的绝对值、梯度范数和a−b次序一致。采用实际EuclideanSpace而非Pi最大范数；D开放、包含闭线段且I在D为C¹。存在同一个c在线段上，既满足均值等式I(a)−I(b)=DI(c)(a−b)，又满足所需点态上界。在实Euclidean空间标量泛函的算子范数就是梯度的Euclidean范数；没有换成其他点或擅加统一梯度界。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.integralPointwiseBound`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L653)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralErrorPrinted · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> This means if we know that $`\|\nabla I(\boldsymbol z)\|`$ remains bounded, say less than $`B`$, in an open domain containing the solution, we could conclude that the error in $`I`$-values computed along a numerical trajectory is of order $`h^p`$,

$$
|I(\boldsymbol z(t_n))-I(\boldsymbol z_n)|\le\frac{\bar K B}{2L}e^{nLh}h^p,\qquad h\lt \bar h,\tag{2.16}
$$


> with the same assumptions as are needed to characterize the convergence of the method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem integralErrorPrinted :
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/(2*L))*Real.exp (L*k*h)*h^p := by
  sorry



/-- 修正版，对应原文 MD-2.2.4-IntegralErrorPrinted。改动：由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。 -/
```

独立修正版：

```lean
theorem integralErrorPrinted_corrected :
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/L)*Real.exp (L*k*h)*h^p := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.integralErrorPrinted`；`MD.Ch02.integralErrorPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。 | [EXTRA] |

[EXTRA] 域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。；[ERRATUM?] 由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；展开 Q n=Fin n→ℝ（Ch02\_deps.txt:2816），因此 n=1 的范数为绝对值、坐标评价的 Fréchet 导数算子范数为1。任意 n,I,D,B,K,L,h,p,k,a,b，在正性、开放域含整段、C¹、域内导数算子范数≤B 和先前点误差≤(K/L)exp(Lkh)h^p 后，结论要求 (KB/(2L))exp(Lkh)h^p。这一1/2无法由这些假设推出，以下反例完全落实到实际 Q。B,K≥0、L>0、h≥0、整段留域及C¹均合理，但不能产生额外1/2；以任意点替代实际轨迹也是更强的断言，且签名未显式保留 h<hbar 的窗口。[ERRATUM?] 对固定同一 K 的推导缺口成立；本审计不把它扩大为对教材所有可能常数约定的裁定。Q 的 Pi 范数在 n>1 时不是欧氏范数，导数算子范数界应明确为相应对偶范数或改用 EuclideanSpace。正文有 sorry，FAIL 与此独立。

### 7. 状态与证明位置

incomplete；`MD.Ch02.integralErrorPrinted`：未证（原书疑误不证）；`MD.Ch02.integralErrorPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L667)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-Divergence · definition · 印刷p.72 / PDFp.94

### 2. 原文陈述

> the divergence of $`f`$ vanishes, i.e.

$$
\nabla\cdot f=\sum_{i=1}^m\frac{\partial f_i}{\partial z_i}=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace

def divergenceFree {n : ℕ} (f : Q n → Q n) : Prop :=
  Differentiable ℝ f ∧ ∀ z, bp_divergence f z = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_divergence`；`MD.Ch02.divergenceFree` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。 | [EXTRA] |

[EXTRA] [EXTRA] 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原文散度消失句及从i=1到m的对角偏导和为零一致。bp\_divergence是实际Fréchet导数坐标矩阵的trace；divergenceFree补充全局可微并对所有z要求trace=0，覆盖原句完整零条件。bp\_divergence作为辅助函数未单独声明可微，但组合谓词提供资格。context\_notation所称f C¹强于实际Differentiable，已在修正JSON中改为可微。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_divergence`：定义；`MD.Ch02.divergenceFree`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L692)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-Liouville · Liouville’s theorem · 印刷p.72 / PDFp.94

### 2. 原文陈述

> Consider a set of points $`S(t)`$ in phase space with evolution associated to a differential equation $`\dot{\boldsymbol z}=f(\boldsymbol z)`$ described by the flow map $`\mathcal F_t(S(0))=S(t)`$. Liouville’s theorem [16] states that the volume of such a set is invariant with respect to $`t`$ if the divergence of $`f`$ vanishes, i.e.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouville
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set ((Fin n) → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.liouville` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。 | [EXTRA] |

[EXTRA] [EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原文描述S(t)=F\_t(S(0))、Liouville定理[16]及体积不变措辞一致；末尾原页为vanishes, i.e.，当前摘录截去i.e.而未标明省略，修正JSON补回，散度展示式仍归相邻条目。Lean对任意维数、C¹向量场f、处处trace=0、联合C²实际解族Φ、Φ(0,·)=id、t∈[0,τ]和任意可测s断言真实Lebesgue像集体积相等。C¹给局部唯一性，实际流在该时间窗单射，未用体积结论作为前提。签名没有0<τ；τ<0时无t可取，τ=0时由恒等初值成立。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.liouville`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L699)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-HamiltonDivergence · unnumbered_claim · 印刷p.72 / PDFp.94

### 2. 原文陈述

> It is a simple exercise to show that for a Hamiltonian system the divergence vanishes, since

$$
\nabla\cdot f=\sum_{i=1}^{N_c}\frac{\partial^2 H}{\partial q_i\partial p_i}-\sum_{i=1}^{N_c}\frac{\partial^2 H}{\partial p_i\partial q_i}=0,
$$


> by equality of mixed partials.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H C²，保证混合偏导对称。 | [EXTRA] |

[EXTRA] H C²，保证混合偏导对称。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；SymplecticForm.lean 展开 SymplecticCoordinates Nc=(Fin Nc⊕Fin Nc)→ℝ，前一组为 q，后一组为 p；textbookJ=fromBlocks 0 1 (-1) 0。SplittingError.lean 的 textbookHamiltonianVectorField H z=J·(i↦DH(z)e\_i)，因此分量恰为 (∂pH,−∂qH)。SymplecticMaps.lean 的 textbookJacobian 是实际 fderiv 的标准坐标矩阵。逐项取迹即 ∑ᵢ∂qᵢ∂pᵢH−∑ᵢ∂pᵢ∂qᵢH；点态 ContDiffAt ℝ 2 H z 保证混合偏导交换，故零迹覆盖原句最终断言，展示的计算链是该展开与混合偏导对称的推导。H、z 任意；C² 是合理充分资格而非最弱必要条件。HamiltonianVariational.lean 的 textbookHamiltonianHessian 使用真实二阶 fderiv，HamiltonianVolume.lean 的零散度定理据此证明该结论。本声明调用库定理、无直接 sorry；未运行编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonDivergence`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L711)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-HamiltonVolume · unnumbered_claim · 印刷p.72 / PDFp.94

### 2. 原文陈述

> Thus Hamiltonian systems always have volume preserving flows.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonVolume {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonVolume` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。 | [EXTRA] |

[EXTRA] [EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原文Thus Hamiltonian systems always have volume preserving flows.逐字一致。任意Nc和H:C^{2}，坐标为q/p两个Fin Nc块，J=[[0,I],[-I,0]]；向量场J∇H的符号与教材相同。Φ联合C²、在[0,τ]满足实际ODE且Φ0=id，对每个窗内t和每个可测s给出Lebesgue像集体积相等。没有额外假设散度零或体积守恒；前者由Hamilton结构产生。签名没有τ>0，需修正说明。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonVolume`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L719)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-VolumeChange · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> If we view the map $`\mathcal F_t`$ as a change of variables, we have

$$
\operatorname{Vol}(S(t))=\int_S |D|\,d\omega,
$$


> where $`D=\det\left(\frac{\partial\mathcal F_t}{\partial\boldsymbol z}\right)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem volumeChange :
  ∀ n (Φ : Q n → Q n) (S : Set (Q n)), ContDiff ℝ 1 Φ → Function.Injective Φ → MeasurableSet S →
    volume (Φ '' S) = ∫⁻ z in S, ENNReal.ofReal |(textbookCoordinateJacobian Φ z).det| ∂volume := by
  intro n Φ S hΦ hinj hS
  have hd : ∀ z ∈ S, HasFDerivWithinAt Φ (fderiv ℝ Φ z) S z := by
    intro z hz
    exact (hΦ.differentiable_one z).hasFDerivAt.hasFDerivWithinAt
  have hcv := lintegral_abs_det_fderiv_eq_addHaar_image
    (volume : Measure (Q n)) hS hd hinj.injOn
  have heq : ∀ z, (fderiv ℝ Φ z).det=(textbookCoordinateJacobian Φ z).det := by
    intro z
    change LinearMap.det (fderiv ℝ Φ z).toLinearMap=_
    rw [← LinearMap.det_toMatrix']
    rfl
  simpa only [heq] using hcv.symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.volumeChange` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。 | [EXTRA] |

[EXTRA] Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Q n=Fin n→ℝ，textbookCoordinateJacobian Φ z=toMatrix' (fderiv ℝ Φ z).toLinearMap，所以 det 是实际空间导数的行列式。量词为任意 n、映射 Φ、集合 S，在 Φ C¹、全局单射、S 可测的资格下，像集 Lebesgue 体积等于 S 上 |det DΦ| 的非负 lintegral；ENNReal.ofReal 将非负实绝对值转为扩展非负实数，故覆盖无限体积。固定时刻流映射可代入；全局单射强于仅在 S 上单射，但合理地避免多重覆盖，C¹ 和可测性是明确充分资格。证明体通过 det\_toMatrix' 对接实际换元公式，无直接 sorry；本次未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.volumeChange`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L732)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-VariationalPrinted · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> To understand where Liouville’s theorem comes from, recall that the variational equations of the last chapter are a system of ordinary differential equations for $`W(t)=\mathcal F_t'(\boldsymbol z(t))`$:

$$
\frac{\mathrm dW}{\mathrm dt}=f'(\boldsymbol z(t))W.
$$


> Thus

$$
\dot W W^{-1}=f'(\boldsymbol z(t)).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem variationalPrinted : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ))) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ)))⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ)) := by
  sorry



/-- 修正版，对应原文 MD-2.3.1-VariationalPrinted。改动：Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。 -/
```

独立修正版：

```lean
theorem variationalPrinted_corrected : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ContDiff ℝ 2 Φ →
    (∀ t ∈ Ioo 0 τ, (textbookCoordinateJacobian (fun y => Φ (t,y)) ζ).det ≠ 0) → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) ζ)
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) ζ) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) ζ) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) ζ)⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.variationalPrinted`；`MD.Ch02.variationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。 | [EXTRA] |

[EXTRA] [ERRATUM?] Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已实际展开 Statements.lean 的 flowC1：f C¹、Φ 联合 C¹、∀z Φ(0,z)=z、∀t∈[0,τ]∀z 时间导数为 f(Φ(t,z))；没有把待证变分公式作为前提。Q 与 Jacobian 为真实有限实坐标空间与真实空间导数。签名忠实保留原书移动取值点 W(t)=D\_yΦ(t,Φ(t,ζ))，同时要求 W′=Df(Φ(t,ζ))W 及 W′W⁻¹=Df(Φ(t,ζ))。这两条一般均错误；移动点的链式项和 Df 的取值点均不能省略。以下全实线 C∞ 完整流满足所有前提且 W 可逆，排除了正则性不足或域问题，确证 ERRATUM? 成立。正确变分矩阵应取固定初值 D\_yΦ(t,ζ)。原签名只有联合 C¹，也未显式登记空间导数关于时间可微的更强充分资格；修正时可用联合 C²。当前证明体是 sorry，但 FAIL 来源于反例而非 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch02.variationalPrinted`：未证（原书疑误不证）；`MD.Ch02.variationalPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L751)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-DeterminantODE · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> Now let $`D=\det(W)`$. One can show (see Exercise 5) that

$$
\frac{\dot D}{D}=\operatorname{tr}(\dot W W^{-1}).
$$


> This implies that

$$
\dot D=\operatorname{div}(f(\boldsymbol z(t)))D,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem determinantODE : ∀ n (A W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    HasDerivAt W (A t * W t) t → (W t).det ≠ 0 →
    HasDerivAt (fun s => (W s).det) ((A t).trace*(W t).det) t ∧
      deriv (fun s => (W s).det) t/(W t).det =
        Matrix.trace ((A t*W t)*(W t)⁻¹) := by
  intro n A W t hW hdet
  have hd := MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE W (A t) t hW
  refine ⟨hd,?_⟩
  rw [hd.deriv, mul_div_cancel_right₀ _ hdet, Matrix.mul_assoc,
    Matrix.mul_nonsing_inv _ (isUnit_iff_ne_zero.mpr hdet), Matrix.mul_one]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.determinantODE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。 | [EXTRA] |

[EXTRA] 实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷73页Now let D=det(W)、Ḋ/D=tr(ẆW⁻¹)、This implies that及最终Ḋ=div(f(z(t)))D均一致。A,W是任意n维实矩阵曲线，在指定t要求真实导数W′=A(t)W(t)且det W(t)≠0；结论同时给det曲线的HasDerivAt以及导数除det等于trace((AW)W⁻¹)。取A=f′(z(t))即为教材实例；非零行列式正好许可原文两处除法。A不被签名限定为某个f的Jacobian，是已披露的线性变分方程推广。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.determinantODE`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L781)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-DeterminantExponential · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> and thus

$$
D(t)=D(0)e^{\int_0^t\operatorname{div}(f(\boldsymbol z(s)))\,ds}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem determinantExponential :
  ∀ n (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    Continuous A → (∀ s, HasDerivAt W (A s * W s) s) →
    (W t).det = (W 0).det * Real.exp (∫ s in (0 : ℝ)..t, (A s).trace) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.determinantExponential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。 | [EXTRA] |

[EXTRA] 实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；A、W 是实际实方阵路径，D(t)=det W(t)；Continuous A 与逐点全实线 HasDerivAt W (A(s)W(s)) s 给出 D′=tr(A)D。结论保留任意 t、D(0) 因子及方向积分 ∫₀ᵗtr A，没有暗设 D(0)=1、t≥0 或 detW≠0，奇异初值亦适用。以已展开的真实 textbookCoordinateJacobian f (z(s)) 代入 A，即 tr A=div f(z(s))，得到原式；此实例须自身满足资格，不由前条错误移动点公式自动获得。A 连续是合理充分条件，全实线 ODE 比单个积分区间资格强，是明确登记的全局版本；局部流须另限其存在区间。当前证明体为 sorry，与签名语义 PASS 分开，未声称证明完成或编译通过。

### 7. 状态与证明位置

incomplete；`MD.Ch02.determinantExponential`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L794)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-FlowDet · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> In particular, if $`\operatorname{div}f\equiv0`$, we see that $`D\equiv D(0)=1`$ and it follows that the volume is constant. Liouville’s theorem may be summarized compactly as:

$$
\nabla\cdot f=0\Rightarrow\det\mathcal F_t'=1.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowDet
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (_hτ : 0 < τ) :
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1 ) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (Q n), MeasurableSet S →
      volume ((fun z ↦ Φ (t,z)) '' S) = volume S) := by
  constructor
  · apply MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2 <;> assumption
  · exact MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 f hf hdiv Φ hΦ τ hODE hinit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.flowDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。 | [EXTRA] |

[EXTRA] [EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。；[EXTRA] 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷73页In particular至紧凑展示式逐字一致，保留D≡D(0)=1及体积恒定。签名任意维数，f为C¹且全局散度零，Φ联合C²、真实ODE、恒等初值，另明确0<τ。结论在整个[0,τ]上对每个初值给实际流Jacobian det=1，并对每个可测S给实际体积保存。D(0)=1来自初值；没有把Jacobian、det或体积结论放进假设。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.flowDet`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L803)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-LJOscillator · Example 2.3 (model) · 印刷p.73 / PDFp.95

### 2. 原文陈述

> A 1-d oscillator with Lennard-Jones potential is described by the equations

$$
\dot q=p,\qquad\dot p=-\varphi_{LJ}'(q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def ljOscillatorEquation (σ ε : ℝ) (_hσ : 0 < σ) (_hε : 0 < ε)
    (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  (∀ t ∈ I, 0 < (γ t).1) ∧
  ∀ t ∈ I, HasDerivAt γ
    ((γ t).2,-deriv (fun q : ℝ ↦ 4*ε*((σ/q)^12-(σ/q)^6)) (γ t).1) t

def oscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.ljOscillatorEquation`；`MD.Ch02.oscillatorEquation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。 | [EXTRA] |

[EXTRA] [EXTRA] 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷73页Example 2.3的模型句和q̇=p、ṗ=−φ′_LJ(q)一致；74页只提供后续例子背景。主定义绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、σ>0、ε>0，要求每个t∈I的位置正且γ在该时刻有真实二分量导数(p,−φ′)。这是单位质量振子，两个方程及负号完整。一般oscillatorEquation是额外辅助定义，不代替主定义的LJ资格。正q使显式势光滑，排除了q=0除法总化。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.ljOscillatorEquation`：定义；`MD.Ch02.oscillatorEquation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L818)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-LJBoundedPeriodic · unnumbered_claim · 印刷p.74 / PDFp.96

### 2. 原文陈述

> As a consequence of energy conservation, any bounded individual trajectory of this system will be a periodic orbit.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ljBoundedPeriodic : ∀ (σ ε : ℝ) (γ : ℝ → ℝ × ℝ),
    0 < σ → 0 < ε →
    oscillatorEquation (fun q => 4*ε*((σ/q)^12-(σ/q)^6)) γ Set.univ →
    (∀ t, 0 < (γ t).1) → Bornology.IsBounded (Set.range γ) →
    ∃ T > 0, ∀ t, γ (t+T) = γ t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.ljBoundedPeriodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。 | [EXTRA] |

[EXTRA] LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。；[EXTRA] 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷74页原句逐字一致。Lean对正参数σ,ε、定义于全部实时间的实际LJ解γ、始终q>0、整条相轨迹范围有界，推出存在T>0且对所有实t有γ(t+T)=γ(t)。全时量化避免仅在有限时间窗内有界的逃逸解成为反例。LJ势在正半轴只有一个有限临界点（极小值）；非平衡有界全轨道处于两个有限转向点之间的闭能量曲线，平衡轨迹也满足存在正周期。没有将一般一维势的有界必周期误用为无条件命题，签名明确绑定LJ。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.ljBoundedPeriodic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L830)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-LinearDivergence · unnumbered_claim · 印刷p.74–75 / PDFp.96–97

### 2. 原文陈述

> Consider a linear differential equation system in $`\mathbb R^m`$,

$$
\dot{\boldsymbol z}=S\boldsymbol z,
$$


> for some matrix $`S\in\mathbb R^{m\times m}`$. The condition for the flow of this system to conserve volume is just that the trace of $`S`$ (which is the divergence of the vector field $`f(\boldsymbol z)=S\boldsymbol z`$) be zero.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem linearDivergence : ∀ n (S : Matrix (Fin n) (Fin n) ℝ)
    (Φ : ℝ × Q n → Q n), ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t z, HasDerivAt (fun s => Φ (s,z)) (S.mulVec (Φ (t,z))) t) →
    (∀ z, divergence S.mulVec z=S.trace) ∧
    ((∀ t, ∀ T : Set (Q n), MeasurableSet T →
      volume ((fun z => Φ (t,z)) '' T)=volume T) ↔ S.trace=0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.linearDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。 | [EXTRA] |

[EXTRA] [EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:618–626；依赖 ReviewDefinitions.lean（合集2816、2877行）展开 Q n=Fin n→ℝ，divergence f z=(textbookCoordinateJacobian f z).trace；LiouvilleVolume.lean（2365–2370行）展开 Jacobian=LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap，条目(i,j)是 Df(z)(e\_j) 的第i输出分量。因此线性向量场的 Jacobian 正是S，散度等于迹。volume 在有限实函数空间采用标准乘积 Lebesgue 体积；不是有向体积，合集2488–2492行换元明确使用绝对行列式。量词先任意n、S和实际解族Φ，再C²、初值恒等和逐时逐点ODE；结论同时保留散度公式及全时全部可测集合体积保存↔trace=0。线性解族由ODE唯一性为exp(tS)z，其行列式exp(t trace S)，所以两个方向均正确。n=0也无例外。[EXTRA]全时C²对线性系统自动可满足；初值和ODE必要地标识所说的流，可测集合限制合理。Ch02.lean证明体含sorry；此PASS仅指签名语义，不指证明完成。

### 7. 状态与证明位置

incomplete；`MD.Ch02.linearDivergence`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L839)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-LinearEuler · definition · 印刷p.75 / PDFp.97

### 2. 原文陈述

> Applying Euler’s method to the same system results in

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+hS\boldsymbol z_n=(I+hS)\boldsymbol z_n,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_linearEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:629–630 的 bp\_linearEuler=1+h • S；并展开依赖 ReviewDefinitions.lean:2878–2879 的正式 linearEuler，二者完全相同。矩阵1为单位矩阵，标量作用逐项相乘，故其乘向量的第i分量是z\_i+h∑_j S\_ij z\_j，恰为原文z_{n+1}=z\_n+hSz\_n=(I+hS)z\_n。隐式n及任意实矩阵S、实步长h无附加限制。这里定义更新矩阵而非另添迭代存在性断言，忠实于展示式；无EXTRA、ERRATUM或sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_linearEuler`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L848)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-EulerVolumePrinted · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> and the condition for Euler’s method to conserve volume is that $`\det(I+hS)=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerVolumePrinted : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ (linearEuler S h).det=1 := by
  sorry



/-- 修正版，对应原文 MD-2.3.2-EulerVolumePrinted。改动：标准无向体积的判据为绝对行列式1；原det=1不作必要条件。 -/
```

独立修正版：

```lean
theorem eulerVolumePrinted_corrected : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ |(linearEuler S h).det|=1 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerVolumePrinted`；`MD.Ch02.eulerVolumePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 标准无向体积的判据为绝对行列式1；原det=1不作必要条件。 | [EXTRA] |

[EXTRA] [ERRATUM?] 标准无向体积的判据为绝对行列式1；原det=1不作必要条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；实际读取 Ch02.lean:634–638；展开依赖Q n=Fin n→ℝ及linearEuler S h=1+h • S（合集2816、2878–2879行）。volume是标准无向Lebesgue体积，合集LiouvilleVolume换元使用|det|；依赖Statements.lean:3129–3132的linearEulerVolume\_statement本身也明确写|det|=1，但当前Blueprint定理并未引用这个修正版，而是↔det=1。任意n、S、h且全部可测T的量词忠实照录原文，却产生数学错误：det=1是充分条件而非必要条件。[ERRATUM?]在当前明确的无向体积解释下成立，无须再NEEDS\_HUMAN。没有方向或小步长假设；仅h>0不能修复。证明体含sorry，不能使错误签名有效。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerVolumePrinted`：未证（原书疑误不证）；`MD.Ch02.eulerVolumePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L854)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-EulerVolumeCounterexample · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> The conditions for volume preservation by the flow map and its Euler approximation are essentially unrelated. Thus Euler’s method does not in general conserve phase space volume (it conserves volume only in very special cases—see Exercise 6).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerVolumeCounterexample :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → |(linearEuler S h).det| ≠ 1 := by
  sorry

theorem eulerVolumeCounterexample_det_only :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1 := by
  exact MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerVolumeCounterexample`；`MD.Ch02.eulerVolumeCounterexample_det_only` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 强化见证为每个h≠0时\|det(I+hS)\|≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det\_only辅助定理并重查，强化结论暂sorry，不写新证明。 | [EXTRA] |

[EXTRA] [EXTRA] 强化见证为每个h≠0时|det(I+hS)|≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det\_only辅助定理并重查，强化结论暂sorry，不写新证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷75页关于Euler一般不保体积的两句逐字一致。linearEuler=I+hS。主定理要求一个固定二维实矩阵S满足trace S=0，同时对每个非零实h有|det(I+hS)|≠1，确实区别真实体积与带符号行列式。辅定理只断言det≠1，并未冒称单凭它即可推出体积不保。取S=[[0,1],[-1,0]]，trace=0且det(I+hS)=1+h²>1，为两个声明的共同见证；这说明新增绝对值版本陈述正确。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerVolumeCounterexample`：未证（缺大型理论）；`MD.Ch02.eulerVolumeCounterexample_det_only`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L873)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-AsymmetricEuler · definition · 印刷p.75 / PDFp.97

### 2. 原文陈述

> the asymmetrical variant of Euler’s method defined by

$$
u_{n+1}=u_n+hf(u_{n+1},v_n),\qquad v_{n+1}=v_n+hg(u_{n+1},v_n).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_asymmetricEulerRelation (f g : ℝ → ℝ → ℝ) (h u v U V : ℝ) : Prop :=
  U = u + h*f U v ∧ V = v + h*g U v
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_asymmetricEulerRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:645–646，bp\_asymmetricEulerRelation f g h u v U V展开为U=u+h*f U v ∧ V=v+h*g U v；依赖ReviewDefinitions.lean:2880–2881正式asymmetricEulerRelation为同一表达式。f,g均为ℝ→ℝ→ℝ，所有变量为实数，新第一坐标U、旧第二坐标v的取值位置与原文两条更新式完全一致，且两条等式完整保留。只定义隐式关系，未宣称全局存在唯一求解器；无额外假设，不含sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_asymmetricEulerRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L882)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-AsymmetricJacobian · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> Solving for the various entries we have

$$
\mathcal G_h'=\begin{bmatrix}1/(1-hf_u)&hf_v/(1-hf_u)\\hg_u/(1-hf_u)&1+hg_v+h^2g_uf_v/(1-hf_u)\end{bmatrix},
$$


> and calculating the determinant of the Jacobian results in

$$
\det\mathcal G_h'=\frac{1+hg_v}{1-hf_u}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem asymmetricDet :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z) =
        !![(1/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) : ℝ),
          h*deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0));
          h*deriv (fun u => g u (z 1)) (Ψ z 0)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)),
          1+h*deriv (g (Ψ z 0)) (z 1)+h^2*deriv (fun u => g u (z 1)) (Ψ z 0)*
            deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))] ∧
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.asymmetricDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。 | [EXTRA] |

[EXTRA] f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:650–669；展开Q 2=Fin 2→ℝ、asymmetricEulerRelation两条实际等式（合集2816、2880–2881行），以及textbookCoordinateJacobian=LinearMap.toMatrix' (fderiv ℝ Ψ z).toLinearMap（2365–2370行），确认行i是输出坐标、列j是输入坐标，未转置。令U=Ψ z 0、v=z 1、a=∂u f(U,v)、b=∂v f(U,v)、c=∂u g(U,v)、d=∂v g(U,v)、D=1-ha。签名四项依次为1/D、hb/D、hc/D、1+hd+h²cb/D，并同时给出det=(1+hd)/D，逐项与原文相符。deriv(fun u=>f u v) U与deriv(f U) v分别准确表示上述偏导；g同理。先任意f,g,Ψ,h，再C¹及处处真实解关系，再任意z及该点D≠0，量词正确，无需散度零假设。[EXTRA]正则性和D≠0保障隐式微分，合理；全局C¹与关系较局部推导强，可局部化但无对象或公式改变。证明体含sorry；语义PASS不代表已证明。

### 7. 状态与证明位置

incomplete；`MD.Ch02.asymmetricDet`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L887)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-AsymmetricArea · unnumbered_claim · 印刷p.75–76 / PDFp.97–98

### 2. 原文陈述

> In the event that the vector field is divergence free, we have $`f_u+g_v=0`$ which implies that the numerator and denominator are identical, and it follows that $`\det\mathcal G_h'=1`$. Thus the asymmetric variant of the Euler method is area preserving, even though the standard Euler method is not.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem asymmetricArea :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.asymmetricArea` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。 | [EXTRA] |

[EXTRA] f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。；[EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:674–685；展开Q、真实asymmetricEulerRelation和标准坐标Jacobian（合集2816、2880–2881、2365–2370行），volume为有限实乘积空间的无向Lebesgue体积。先任意f,g,Ψ,h，再三项C¹、处处更新关系、∀u v的真实偏导和为零、解取值点的处处分母非零及Ψ单射；结论同时保留∀z det=1与全部可测T的像面积相等。偏导均在(U,v)取值；散度零给1+h g\_v=1-h f\_u，因此点态det=1；C¹、单射及绝对行列式换元给全局集合面积保存。[EXTRA]C¹、实际解映射和分母非零是合理的可微分支条件，全球版本强于原书局部计算但解释清楚。单射是保证全局换元的合理明确充分条件；不是声称这些其余假设必然不能推出它，不能泛称其独立必要性。仅det=1的一般映射不足以推出全局像面积相等，因此此额外条件与所选全球结论相称。无ERRATUM。证明体含sorry；语义与证明完成分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.asymmetricArea`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L905)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticMap · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> Let $`m=2N_c`$. A symplectic map $`\Phi:\mathbb R^m\to\mathbb R^m`$ is one that preserves the symplectic differential 2-form. The simplest way to write this is as the following algebraic condition on the Jacobian matrix of $`\Phi`$:

$$
\Phi'^TJ\Phi'=J.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  Differentiable ℝ Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_IsSymplecticMap` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。 | [EXTRA] |

[EXTRA] [EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷76页从Let m=2Nc到Φ′ᵀJΦ′=J的定义逐字一致。bp\_IsSymplecticMap对两个Fin Nc块上的实际映射要求全局可微，且每个z的真实Jacobian满足AᵀJA=J；J块矩阵符号正确。没有要求额外C¹，也没有把抽象矩阵当作无关实际映射的Jacobian。此处只审教材局部导数/保形式意义的定义，不从非奇异Jacobian擅推全局可逆。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_IsSymplecticMap`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L918)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-OneForm · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> A 1-form $`\alpha`$ defined on $`\mathbb R^m`$ is a family of linear mappings from $`\mathbb R^m`$ to $`\mathbb R`$, defined for each point of $`\mathbb R^m`$. Let $`\boldsymbol a:\mathbb R^m\to\mathbb R^m`$, then we may define a one-form associated to this vector by $`\alpha(\boldsymbol x)(\boldsymbol\xi)=\boldsymbol a(\boldsymbol x)^T\boldsymbol\xi`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ

def oneFormOfCoefficients {n : ℕ} (a : Q n → Q n) (z : Q n) : Q n →L[ℝ] ℝ :=
  ∑ i : Fin n, (a z i) • ContinuousLinearMap.proj i

theorem oneFormOfCoefficients_apply {n : ℕ} (a : Q n → Q n) (z ξ : Q n) :
    oneFormOfCoefficients a z ξ = ∑ i : Fin n, a z i * ξ i := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.oneFormFamily`；`MD.Ch02.oneFormOfCoefficients`；`MD.Ch02.oneFormOfCoefficients_apply` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷76页1-form线性映射族定义以及α(x)(ξ)=a(x)ᵀξ逐字一致。oneFormFamily对每个基点给一个连续线性实泛函；有限维中连续性自动成立，不是额外光滑条件。oneFormOfCoefficients是逐坐标投影的有限线性组合，对任意a,z,ξ，辅助定理断言评价恰为Σ\_i a(z)_i ξ\_i；对象、基点及完整评价式均覆盖。未错误要求a对z可微。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.oneFormFamily`：定义；`MD.Ch02.oneFormOfCoefficients`：定义；`MD.Ch02.oneFormOfCoefficients_apply`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L924)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-Differential · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> The differential of a function $`g:\mathbb R^m\to\mathbb R`$, denoted $`dg`$, is a family of linear mappings (one for each point in phase space) from vectors $`\boldsymbol\xi\in\mathbb R^m`$ into the reals defined by

$$
dg(\boldsymbol q,\boldsymbol p)(\boldsymbol\xi)=\nabla g(\boldsymbol q,\boldsymbol p)^T\boldsymbol\xi.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_differential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Q n=Fin n→ℝ（依赖:2816）和 oneForm n=Q n→Q n→L[ℝ]ℝ（:2882）。bp\_differential g=fderiv ℝ g，是每个底点的真实 Fréchet 导数，方向 ξ 进入线性泛函，在可微点评价为 ∑i,∂ᵢg(z)ξᵢ，正对应 ∇g(z)ᵀξ。默认坐标范数不改变有限维导数或此坐标等式；n 是总坐标数，可取 2Nc。fderiv 在不可微点取默认零是总化扩展，不能解释为不可微函数存在原文微分；原文 ∇g 隐含可微资格，在该资格下未改变定义。没有额外正则性限制或 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_differential`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L934)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-CoordinateDifferentials · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> So, denoting the $`i`$th position coordinate by $`q_i`$, we have $`dq_i(\boldsymbol\xi)=\xi_i`$; the differential is thus an example of a 1-form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def coordinateDifferentials (n : ℕ) :
    (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) × (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) :=
  (textbookDq,textbookDp)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.coordinateDifferentials` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33 的坐标空间分拆 q,p；:55–65 展开 textbookDq i u=u(Sum.inl i)、textbookDp i u=u(Sum.inr i)，map\_add/map\_smul 为逐坐标线性。蓝图配对这两个族，Fin n 对应教材 1,…,Nc，inr 对应 i+Nc，正负号、维数均正确。底点省略合理：坐标函数导数是与底点无关的固定评价泛函。dp 项来自本条 context 的 PDF99，合理且无额外假设；无 [ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.coordinateDifferentials`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L937)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-Wedge · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> It is written $`\alpha\wedge\beta`$ and is defined, for vectors $`\boldsymbol\xi,\boldsymbol\eta\in\mathbb R^m`$ by

$$
\alpha\wedge\beta(\boldsymbol\xi,\boldsymbol\eta)=\alpha(\boldsymbol\xi)\beta(\boldsymbol\eta)-\alpha(\boldsymbol\eta)\beta(\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_wedge {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_wedge`；`MD.Ch02.textbookWedgeOneForms_apply` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33 明确空间是 ℝ^(2Nc)，:73–77 的 textbookWedgeOneForms 与 bp\_wedge 函数体相同。双线性乘法复合与减法展开得到 α(u)β(v)−β(u)α(v)，实数交换律化为 α(u)β(v)−α(v)β(u)，完整对应原式。参数 α,β 为固定底点的线性泛函，与 context 相符；结果双线性且交替，没有暗加光滑条件。邻接 apply 定理虽使用库名称，实际定义相同，不再有对象不明问题。无 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_wedge`：定义；`MD.Ch02.textbookWedgeOneForms_apply`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L942)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticForm · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> Summing these terms results in the symplectic 2-form, denoted $`\psi_S`$:

$$
\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_symplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33–40 展开坐标及 J=[[0,I],[-I,0]]；bp\_symplecticForm 与依赖:85–87 的 textbookSymplecticForm 同为 J.toBilin'，评价是 ∑a∑b u(a)J(a,b)v(b)=∑i[u(inl i)v(inr i)−u(inr i)v(inl i)]。依赖:55–77 的 dq,dp 与楔积展开给出同一和，:90–107 明确登记坐标式和求和等式。故作为辛形式的定义，确实指定原文完整公式中的同一对象，没有符号、因子或维数错位；J^(i) 就是各 i 的两非零元素矩阵，其和为此 J。无 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticForm`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L954)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-FormSumWedges · unnumbered_claim · 印刷p.77 / PDFp.99

### 2. 原文陈述

> The wedge product of the coordinate differentials $`dq_i,dp_i`$ may be written

$$
dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\xi_i\eta_{i+N_c}-\xi_{i+N_c}\eta_i=\boldsymbol\xi^TJ^{(i)}\boldsymbol\eta.
$$


> where $`J^{(i)}`$ is the matrix which has zeros everywhere except for $`(J^{(i)})_{i,i+N_c}=1`$, $`(J^{(i)})_{i+N_c,i}=-1`$. Summing these terms results in the symplectic 2-form, denoted $`\psi_S`$:

$$
\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem formSumWedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i) := by
  apply MolecularDynamics.textbookSymplecticForm_eq_sum_wedges <;> assumption

def symplecticComponentMatrix {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinateMatrix Nc :=
  fun a b ↦ if a = Sum.inl i ∧ b = Sum.inr i then 1
    else if a = Sum.inr i ∧ b = Sum.inl i then -1 else 0

theorem formSumWedges_components (Nc : ℕ) :
    (∀ (i : Fin Nc) (u v : SymplecticCoordinates Nc),
      textbookWedgeOneForms (textbookDq i) (textbookDp i) u v =
        ∑ a, u a * ((symplecticComponentMatrix i) *ᵥ v) a) ∧
    (∑ i : Fin Nc, symplecticComponentMatrix i) = textbookJ Nc := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.formSumWedges`；`MD.Ch02.symplecticComponentMatrix`；`MD.Ch02.formSumWedges_components` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原页17（印刷77页）两条展示式的符号和求和一致，但两式之间where J^(i) is the matrix…的定义句被无省略标志地删去。修正JSON补回该句，明确两个非零位置和正负号。Lean主定理给双线性形式等式；symplecticComponentMatrix逐点定义q\_i,p\_i交叉元+1和−1，其余0。components定理对每个i,u,v给楔积等于uᵀJ^(i)v，并给Σ\_i J^(i)=J。textbookDq/Dp分别取q/p坐标，wedge=α(u)β(v)−α(v)β(u)，textbookSymplecticForm=J.toBilin，故单项坐标式及最终uᵀJv没有符号或二倍因子错误。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.formSumWedges`：已证；`MD.Ch02.symplecticComponentMatrix`：定义；`MD.Ch02.formSumWedges_components`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L960)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-GeneralTwoForm · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> In general, a differential 2-form $`\psi`$ is represented in coordinates by

$$
\psi_{\boldsymbol z}=\sum_{i,j}a_{ij}(\boldsymbol z)\,dz_i\wedge dz_j,
$$


> with matrix of coefficients $`A(\boldsymbol z)=(a_{ij}(\boldsymbol z))`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def coefficientTwoForm {n : ℕ} (A : Q n → Matrix (Fin n) (Fin n) ℝ)
    (z u v : Q n) : ℝ :=
  ∑ i, ∑ j, A z i j * (u i*v j-v i*u j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.coefficientTwoForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q n 已展开为 Fin n→ℝ（依赖:2816）。蓝图 coefficientTwoForm 对任意底点依赖系数 A，评价精确为 ∑i∑j A(z)ij[u\_i v\_j−v\_i u\_j]，逐项就是 a\_ij(z)dz\_i∧dz\_j；底点、两个方向和双和顺序无遗漏。无需假设 A 反对称；该表达自动双线性反对称，不把 A 直接当双线性矩阵。[ERRATUM?] 的代数部分成立：实际矩阵为 A−Aᵀ，A 反对称时为2A。但本条原文只称 A 为双和的系数矩阵，这本身无错；关于后文直接使用 A 的疑点不能在本批 scope 内确认，故不认定本条有已证实勘误，也不改双和。无 [EXTRA]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.coefficientTwoForm`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L978)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackOne · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> It is written $`\Phi^*\psi`$, so

$$
(\Phi^*\psi_{\boldsymbol z})(\boldsymbol\xi)=\psi_{\Phi(\boldsymbol z)}(\Phi'(\boldsymbol z)\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_pullbackOne` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816 的 Q n=Fin n→ℝ；:2882 的 oneForm n=Q n→(Q n→L[ℝ]ℝ)，即底点参数化的实线性泛函（有限维下连续性不额外收窄线性对象）。展开 .comp 得 ∀z ξ，bp\_pullbackOne Φ α z ξ=α(Φ z)((fderiv ℝ Φ z)ξ)，底点、方向与原式完全一致。依赖:2886–2887 的 pullbackOne 同体。没有把 α 错取在 z，也无额外假设。Φ 不带可微条件是用总化 fderiv 扩展定义的域：在教材实际导数存在的全部点，公式正是原定义；不可微点的默认值不能解释为教材的真实导数，但不使可微范围上的定义失真。无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_pullbackOne`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L983)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackTwo · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> The pull-back of a differential 2-form $`\psi_1\wedge\psi_2`$ is consequently defined as

$$
\Phi^*(\psi_1\wedge\psi_2)=(\Phi^*\psi_1)\wedge(\Phi^*\psi_2).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_pullbackTwo` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816、:2882–2889 展开 Q、oneForm、twoForm、pullbackOne、pullbackTwo。twoForm 是逐点连续双线性映射 A 加 ∀z u v，A z u v=−A z v u 的子类型；实数域上这也保证 A z u u=0，确为交替2-形式。蓝图与库 pullbackTwo 同体，两个方向均用同一底点的 DΦ(z)，A 在 Φ(z) 取值。依赖:73–82 的楔积展开是 α(u)β(v)−α(v)β(u)；对 α,β 的逐点族作同样展开，左侧拉回为 α(Φz)(DΦz u)β(Φz)(DΦz v)−α(Φz)(DΦz v)β(Φz)(DΦz u)，右侧两条拉回1-形式的楔积完全相同。因此本定义在可分解形式上实现原文乘法性，并合理推广到所有2-形式；不需要凭缺少单独定理把定义判缺失。没有额外光滑性要求；fderiv 的总化扩展在可微范围上正确。无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_pullbackTwo`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L987)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackMatrix · unnumbered_claim · 印刷p.77–78 / PDFp.99–100

### 2. 原文陈述

> Given a differential 2-form $`\psi_{\boldsymbol z}`$ represented by the matrix $`A(\boldsymbol z)=(a_{ij}(\boldsymbol z))`$, the pull-back of $`\psi_{\boldsymbol z}`$ under $`\Phi`$ is defined by

$$
\Phi^*\psi_{\boldsymbol z}=\sum_{ij}b_{ij}(\boldsymbol z)dz_i\wedge dz_j,
$$


> where the matrix $`B(\boldsymbol z)=(b_{ij}(\boldsymbol z))`$ is related to $`A(\boldsymbol z)`$ by

$$
B(\boldsymbol z)=\Phi'^T(\boldsymbol z)A(\Phi(\boldsymbol z))\Phi'(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem pullbackMatrix :
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v) := by
  intro n Φ A z u v
  rw [← textbookCoordinateJacobian_mulVec Φ z u,
    ← textbookCoordinateJacobian_mulVec Φ z v]
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
    Matrix.dotProduct_transpose_mulVec]
  exact dotProduct_comm _ _
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.pullbackMatrix` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816 的 Q 和 :2365–2376 的 textbookCoordinateJacobian 展开为标准基下 LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，且 mulVec u=DΦ(z)u。蓝图全称量化 n,Φ,A,z,u,v，完整表达 (DΦu)ᵀA(Φz)(DΦv)=uᵀ[DΦᵀA(Φz)DΦ]v；所有方向上的双线性评价唯一确定矩阵 B，故 B(z)=DΦ(z)ᵀA(Φz)DΦ(z)，底点无误。对原文全指标楔积系数，coefficientTwoForm 展开为 uᵀ(A−Aᵀ)v；将本等式在 (u,v) 和 (v,u) 上相减，恰得拉回系数形式等于 B 的全指标楔积形式，故归一差异不损害本夹乘公式。A 无须反对称，可推广为任意矩阵；不添加假设，无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.pullbackMatrix`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L991)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PreservesForm · definition · 印刷p.78 / PDFp.100

### 2. 原文陈述

> We say that a 2-form $`\psi`$ is conserved under mapping $`\Phi`$ if

$$
\Phi^*\psi=\psi.
$$


> In coordinates, the conservation of the 2-form represented by matrix $`A`$ under a mapping $`\Phi`$ means that

$$
\Phi'^TA\Phi'=A.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_preservesTwoForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2884–2891 展开 twoForm 及实际调用的 pullbackTwo：A 是逐点交替双线性形式，拉回值为 A(Φz)(DΦz u)(DΦz v)，与 bp\_pullbackTwo 同体。蓝图 ∀z u v 的等式是 Φ*ψ=ψ 的完整逐点评价，量词顺序与对象正确。若 M(z) 是 A.val 的实际双线性矩阵，则它等价于 DΦ(z)ᵀM(Φz)DΦ(z)=M(z)。[ERRATUM?] 指出的底点补全正确，但原文前一式已明确 A(Φz)，因而当前省略底点可按上下文理解，不能确认是错误。若把原文 A 当任意全指标楔积系数，则严格只保存反对称部分；选实际交替双线性矩阵才得到字面矩阵等式。这是表示约定说明，不影响本条形式守恒定义。没有额外假设。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_preservesTwoForm`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1005)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticIffForm · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> In the particular case of the symplectic 2-form $`\psi_S`$, we have $`A=J`$, and the following condition for conservation under the mapping $`\Phi`$

$$
\Phi'^TJ\Phi'=J.\tag{2.17}
$$


> A map that conserves the symplectic 2-form, or, in coordinates, satisfies (2.17), is termed a symplectic map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticIffForm {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    bp_IsSymplecticMap Φ ↔ Differentiable ℝ Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  sorry

theorem symplecticIffForm_C1 {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  apply MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticIffForm`；`MD.Ch02.symplecticIffForm_C1` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。 | [EXTRA] |

[EXTRA] [EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷78页专门辛2形式A=J、式(2.17)、末句命名定义一致。symplecticIffForm使用任意实际Φ，左侧教材可微谓词，右侧可微且对每个基点z及向量u,v有ψ(DΦ\_z u,DΦ\_z v)=ψ(u,v)，完整双向等价。辅助\_C1版本两侧一致使用ContDiff ℝ 1；没有将C¹版和仅可微版混用。实际J矩阵与双线性形式相符，未遗漏任何基点或切向量。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.symplecticIffForm`：未证（缺大型理论）；`MD.Ch02.symplecticIffForm_C1`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1010)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticDet · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> Taking the determinant of both sides of (2.17), we have

$$
\det(\Phi'^TJ\Phi')=\det(J)\Rightarrow\det(\Phi'^T)\det(J)\det(\Phi')=\det(J),
$$


> hence

$$
\det(\Phi')^2=1,
$$


> so $`|\det(\Phi')|=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticDet {n : ℕ} (A : SymplecticCoordinateMatrix n) (hA : IsTextbookSymplectic A) :
    A.det^2=1 ∧ |A.det|=1 := by
  exact ⟨hA.det_square,hA.abs_det⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticDet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33–40、:138–139 展开 SymplecticCoordinateMatrix n 为实2n×2n矩阵、J=[[0,I],[−I,0]]、hA 为 AᵀJA=J；:49–52 的 J²=−I 给出逆矩阵 −J，取消 det J 合法，包括 n=0 的空矩阵情形。蓝图同时包含 det(A)²=1 与 |det(A)|=1，两项原文结论均保留。把导数矩阵推广为任意辛矩阵不收窄教材结论，无 [EXTRA]。依赖:183–197 的 det\_square/abs\_det 使用更强的辛矩阵 det=1 结果，证明途径强于教材不改变本条签名语义。无 [ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticDet`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1025)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-HamiltonDet · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> If the system is Hamiltonian, the map is symplectic for all $`t`$, and the determinant will be a continuous function of $`t`$, so the cases of interest have $`\det(\mathcal F_t')=+1`$. The flow map of a Hamiltonian system is volume preserving.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z ↦ Φ (t,z))) ∧
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S) := by
  constructor
  · exact MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit
  · constructor
    · exact MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 H hH Φ hΦ τ hODE hinit
    · exact MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 H hH Φ hΦ τ hODE hinit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。 | [EXTRA] |

[EXTRA] [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。；[EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷78页Hamiltonian流辛性、行列式随t连续、det=+1及体积保存句均逐字一致。Lean给任意n、C² Hamiltonian和联合C²实际流、恒等初值及窗内ODE，结论有三项：每个时刻流为C¹辛映射；每点Jacobian det=1；每个可测集合体积保存。行列式的时间连续性由联合C²正则性得到，并且窗内恒等于1也直接给其限制连续。旧extra\_assumptions一条称τ>0、一条说不假称τ>0，自相矛盾；实际无该前提，已统一修正。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonDet`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1032)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-Hessian · definition · 印刷p.79 / PDFp.101

### 2. 原文陈述

> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_hessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_hessian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。Ch02.lean:779–783 的 bp\_hessian 与 HamiltonianVariational.lean 中 textbookHamiltonianHessian 逐字相同：第(i,j)项为 D(DH)(z)[e\_i][e\_j]，e\_i=Pi.single i 1。这是实际二阶Fréchet导数的坐标矩阵；取z=Φ(t,ζ)即得到原文S(t)，点参数化未丢失轨迹取值语义。对称性另由本批HessianSymmetry承担。本定义无额外假设、无sorry；不在本条强求时间函数封装。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_hessian`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1049)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HessianSymmetry · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hessianSymmetry {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm := by
  apply MolecularDynamics.textbookHamiltonianHessian_isSymm <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hessianSymmetry` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H在所取点C²，混合偏导相等。 | [EXTRA] |

[EXTRA] H在所取点C²，混合偏导相等。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。HamiltonianVariational.lean 展开的 textbookHamiltonianHessian 与 bp\_hessian 定义相同；Matrix.IsSymm断言转置等于自身，恰为全部混合二阶导数互换。Ch02.lean:786–790 对所有H和z，在ContDiffAt ℝ 2 H z下断言该对称性，因而也适用于任意轨迹点。点处C²是合理的充分正则性补充，非最弱必要条件；“混合偏导相等”不是另加假设，而是推出的结论。库证明使用二阶导数对称性，本地及该依赖证明无sorry；本次仅审签名，未运行Lean编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hessianSymmetry`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1056)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HamiltonVariationalPrinted · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> For the Hamiltonian system $`\dot{\boldsymbol z}=J\nabla H(\boldsymbol z)`$, these take the form:

$$
\dot W=JS(t)W,
$$


> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonVariationalPrinted : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t := by
  sorry



/-- 修正版，对应原文 MD-2.3.4-HamiltonVariationalPrinted。改动：固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。 -/
```

独立修正版：

```lean
theorem hamiltonVariationalPrinted_corrected : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) ζ)
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) ζ) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonVariationalPrinted`；`MD.Ch02.hamiltonVariationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。 | [EXTRA] |

[EXTRA] [ERRATUM?] 固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。SymplecticMaps.lean 的 textbookJacobian Φ z=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，第(i,j)项为DΦ(z)[e\_j]_i；SplittingError.lean 的 textbookHamiltonianVectorField H z=J乘以各基方向的DH，故确为(q̇,ṗ)=(H\_p,-H\_q)。HamiltonianVariational.lean 的 Hessian为实际二阶导数。Ch02.lean:793–803 对所有n,H,Φ,τ,ζ，在H C²、Φ联合C¹、Φ₀=id、闭区间所有初值满足真实ODE下，宣称移动点W(s)=DΦ\_s(Φ\_s(ζ))满足Ẇ=J Hzz(Φ\_t(ζ))W。它忠实保留印刷疑误，却不是正确变分方程；[ERRATUM?]由下列全局光滑反例确定成立。即使加强Φ为C∞也不能补救。通常固定初值W=DΦ\_t(ζ)才满足该式；移动点同时产生空间链式项，且固定底点的变分系数在Φ\_t(Φ\_t(ζ))取值。C¹本身也不足以直接保证所需二阶混合导数。τ≤0时开区间为空，不影响τ>0的反例。签名FAIL与证明体显式sorry分别记录；该sorry不作为判FAIL的理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.hamiltonVariationalPrinted`：未证（原书疑误不证）；`MD.Ch02.hamiltonVariationalPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1064)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

