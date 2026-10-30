[上一部分](part01.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-3.2-PoissonCoordinates · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述


$$
\{g_1,g_2\}=\sum_{i=1}^{N_c}\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonCoordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1)) := by
  apply MolecularDynamics.textbookPoissonBracket_coordinates <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonCoordinates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,z 的坐标恒等式：inl 是 q，inr 是 p，求和 i:Fin Nc；第一项 F\_q G\_p，第二项 G\_q F\_p，符号及两个因子均与原式一致。fderiv 本身总是连续线性映射，所以即使未假设可微，有限维坐标展开仍成立；在原文光滑域上得到标准偏导公式。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonCoordinates`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L270)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonBilinearity · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
> Bilinearity $`\{g_1,\alpha g_2+\beta g_3\}=\alpha\{g_1,g_2\}+\beta\{g_1,g_3\}`$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z) := by
  exact ⟨MolecularDynamics.textbookPoissonBracket_linear_right F G H α β z hG hH,
    MolecularDynamics.textbookPoissonBracket_linear_left F H G α β z hF hG⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonBilinearity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。 | [EXTRA] |

[EXTRA] 原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,H,α,β,z，分别假设三个函数在 z 可微；合取右变量与左变量的实线性。原文只显示右变量线性，额外左线性明确记录且可由反对称性推出；没有遗漏系数或错用函数顺序。逐点可微比原 smooth 弱，足以应用 fderiv 的加法与数乘规则。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonBilinearity`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L281)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonSkew · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Skew symmetry $`\{g_1,g_2\}=-\{g_2,g_1\}`$

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonSkew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z := by
  apply MolecularDynamics.textbookPoissonBracket_skew <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonSkew` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,z，无额外前提，结论 {F,G}(z)=−{G,F}(z)。项目 J 的两个非零块互为负转置，因此两个总化 fderiv 的配对也满足反对称；对非可微函数的扩张不妨碍原 smooth 域上的忠实性。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonSkew`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L293)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonSelf · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> and this implies $`\{g_1,g_1\}=0`$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonSelf (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_self <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonSelf` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,z，结论 {F,F}(z)=0；底域 ℝ，反对称性可推出 2{F,F}=0。与原文 and this implies 的结论一致，未增加无关域或前提。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonSelf`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L299)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonJacobi · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Jacobi identity $`\{g_1,\{g_2,g_3\}\}+\{g_3,\{g_1,g_2\}\}+\{g_2,\{g_3,g_1\}\}=0`$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_jacobi <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonJacobi` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 显式各函数在z为C²；真实二阶导数对称性支持Jacobi。 | [EXTRA] |

[EXTRA] 显式各函数在z为C²；真实二阶导数对称性支持Jacobi。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,H,z，每个函数在 z 为 ContDiffAt ℝ 2；三个嵌套括号的次序严格为 {F,{G,H}}+{H,{F,G}}+{G,{H,F}}。C² 局部资格足以保证内层括号可微及 Hessian 对称性，原文 smooth 可以满足；不是对任意不可微函数无条件宣称 Jacobi。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonJacobi`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L305)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianObservableDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> More generally, if $`F(\boldsymbol q,\boldsymbol p)`$ is any smooth, scalar-valued function of the phase variables, we may write

$$
\dot F=\frac{\mathrm d}{\mathrm dt}F(\boldsymbol q(t),\boldsymbol p(t))=\{F,H\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianObservableDerivative
    (F H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (t : ℝ) (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) t := by
  exact MolecularDynamics.hasDerivAt_textbookLieDerivative
    (textbookHamiltonianVectorField H) F γ t hF hγ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianObservableDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | smooth只需在γ(t)可微；ODE真实导数明示。 | [EXTRA] |

[EXTRA] smooth只需在γ(t)可微；ODE真实导数明示。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 中 MolecularDynamics/Chapter02/SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ（inl 为 q、inr 为 p），textbookJ=fromBlocks 0 1 (-1) 0；Chapter02/SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e\_i))；Chapter03/LiePoisson.lean 的 textbookPoissonBracket F G z=DF(z)[J∇G(z)]、textbookLieDerivative f F z=DF(z)[f(z)]。Ch03.lean 同名局部定义与库定义一致。hγ是γ在t的真实导数等于J∇H(γ(t))，忠实表达Hamiltonian轨道的点态ODE；hF是smooth所需的局部可微资格。HasDerivAt结论同时给出复合函数可微及其导数为{F,H}(γ(t))。不需要额外假设H全局光滑来证明此点态链式法则；对原文光滑H当然适用。 本条无[ERRATUM?]。证明状态单独记录：Ch03.lean本条无直接sorry；所调用的相关库证明在依赖摘录中也给出了证明体。此PASS仅是签名语义判定，本任务未运行Lean编译，不据此宣称整个工程无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianObservableDerivative`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L315)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianLie · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:

$$
\mathcal L_{J\nabla H}F\equiv \{F,H\}.
$$


> For a Hamiltonian flow, we typically simplify notation by writing $`\mathcal L_H`$ in place of $`\mathcal L_{J\nabla H}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H := by
  apply MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianLie_eq_poisson` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,H，结论是两个相空间函数相等，故包括所有 z；左边 L_(J∇H) F，右边 {F,H}，与两个项目定义逐字展开后相同。L\_H 的简写由左边的 Hamiltonian 向量场参数实现，没有误取 {H,F}。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianLie_eq_poisson`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L324)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianCoordinateDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> In terms of the Poisson bracket, it is possible to write the differential equation corresponding to a coordinate $`q_i`$, say, as

$$
\dot q_i=\{q_i,H\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianCoordinateDerivative
    (H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (i : Fin Nc) (t : ℝ)
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => γ u (Sum.inl i))
      (textbookPoissonBracket (fun z => z (Sum.inl i)) H (γ t)) t := by
  exact hamiltonianObservableDerivative (fun z => z (Sum.inl i)) H γ t
    (differentiableAt_pi.mp differentiableAt_id (Sum.inl i)) hγ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianCoordinateDerivative` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 中 MolecularDynamics/Chapter02/SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ（inl 为 q、inr 为 p），textbookJ=fromBlocks 0 1 (-1) 0；Chapter02/SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e\_i))；Chapter03/LiePoisson.lean 的 textbookPoissonBracket F G z=DF(z)[J∇G(z)]、textbookLieDerivative f F z=DF(z)[f(z)]。Ch03.lean 同名局部定义与库定义一致。观测量固定为z↦z(Sum.inl i)，而非任意F；HasDerivAt轨道坐标函数给出q̇_i={q\_i,H}。hγ明示原文隐含Hamiltonian方程；坐标函数自动可微，无遗漏假设或结论。 本条无[ERRATUM?]。证明状态单独记录：Ch03.lean本条无直接sorry；所调用的相关库证明在依赖摘录中也给出了证明体。此PASS仅是签名语义判定，本任务未运行Lean编译，不据此宣称整个工程无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianCoordinateDerivative`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L331)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianLieAdditivity · unnumbered_claim · 印刷p.103 / PDFp.125

### 2. 原文陈述

> As the relation

$$
\mathcal L_H\phi=\{\phi,H\}
$$


> is linear in $`H`$, we may write, for Hamiltonians $`H_1,H_2`$,

$$
\mathcal L_{H_1+H_2}=\mathcal L_{H_1}+\mathcal L_{H_2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianLieAdditivity (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_add <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianLieAdditivity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H₁,H₂在z可微；原文smooth资格显式化。 | [EXTRA] |

[EXTRA] H₁,H₂在z可微；原文smooth资格显式化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,H₁,H₂,z，仅需 H₁,H₂ 在 z 可微；结论逐点为 L_(X_(H₁+H₂))F=L_(X\_H₁)F+L_(X\_H₂)F。fderiv H 的加法给出向量场加法，再由 fderiv F 的线性推出，F 即使没有可微前提也可使用总化导数，原文光滑对象当然涵盖。全称 F,z 对应算子等式。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianLieAdditivity`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L342)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-FormalSplitting · definition · 印刷p.103 / PDFp.125

### 2. 原文陈述

> The flow map of the system with Hamiltonian $`H=H_1+H_2`$ is

$$
\mathcal F_t=e^{t(\mathcal L_{H_1}+\mathcal L_{H_2})}.
$$


> On the other hand, the splitting method based on a composition of flows on $`H_1`$ and $`H_2`$ is

$$
\mathcal G_h=e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B

def formalExactSplit {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential (A+B)

def hamiltonianSplittingObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun k ↦ ∑ i ∈ Finset.range (k+1),
    ((textbookLieDerivative (textbookHamiltonianVectorField A))^[i]
      ((textbookLieDerivative (textbookHamiltonianVectorField B))^[k-i] φ)) z /
      ((Nat.factorial i : ℝ)*(Nat.factorial (k-i) : ℝ)))

def hamiltonianExactObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j ↦
    ((textbookLieDerivative (textbookHamiltonianVectorField (fun x ↦ A x+B x)))^[j] φ) z /
      (Nat.factorial j : ℝ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalSplitting`；`MD.Ch03.formalExactSplit`；`MD.Ch03.hamiltonianSplittingObservable`；`MD.Ch03.hamiltonianExactObservable` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L\_H1、B=L\_H2；仅形式系数，不宣称解析收敛。 | [EXTRA] |

[EXTRA] [EXTRA] 同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L\_H1、B=L\_H2；仅形式系数，不宣称解析收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；formalExactSplit 在任意实结合环代数中取 exp(A+B)，formalSplitting 取 exp(A)exp(B)，未增加 AB=BA。指数第 j 系数为 A^j/j!。Hamiltonian 实例的 split 系数为 Σ_(i=0)^k (L\_A^i L\_B^(k−i)φ)(z)/(i!(k−i)!)，顺序与原显示一致；exact 实例为 L_(A+B)^jφ/j!。这些是定义，不是关于所有非光滑函数的算子加法定理；在原文光滑域用第14条连接。状态流与 pullback 的组合顺序不同，当前定义采用原文形式算子顺序，并未错误声称相反状态组合。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalSplitting`：定义；`MD.Ch03.formalExactSplit`：定义；`MD.Ch03.hamiltonianSplittingObservable`：定义；`MD.Ch03.hamiltonianExactObservable`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L352)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-ExactExponentialCubic · unnumbered_claim · 印刷p.103 / PDFp.125

### 2. 原文陈述

> Expanding these out using the exponential series we have

$$
\begin{aligned}e^{h(A+B)}&=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(A+B)^2+\frac{h^3}{6}(A+B)^3+O(h^4)\\ &=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(AB+BA+A^2+B^2)\\ &\quad+\frac{h^3}{6}(A^3+A^2B+AB^2+ABA+B^2A+BA^2+BAB+B^3)+O(h^4),\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactExponentialCubic (A B : R) :
    (∀ j < 4, PowerSeries.coeff j (textbookFormalOperatorExponential (A+B)) =
      (1/(j.factorial : ℝ)) • (A+B)^j) ∧
    ((A+B)^2 = A*B+B*A+A^2+B^2) ∧
    ((A+B)^3 = A^3+A^2*B+A*B^2+A*B*A+B^2*A+B*A^2+B*A*B+B^3) := by
  refine ⟨fun j _ => textbookFormalOperatorExponential_coeff (A+B) j, ?_, ?_⟩
  · noncomm_ring
  · noncomm_ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.exactExponentialCubic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实结合环代数的 A,B，不设交换性；∀j<4 给出 exp(A+B) 的系数，另合取平方的四个词和立方的八个词展开。常数与一次系数由 j=0,1 实例得到，平方与立方恰对应 1/2、1/6，八个词各出现一次。PowerSeries 语境中余项的次数至少四，不暗中断言范数 O(h⁴) 或解析收敛。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.exactExponentialCubic`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L372)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-ProductExponentialCubic · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述

> whereas,

$$
\begin{aligned}e^{hA}e^{hB}&=(\mathrm{Id}+hA+\frac{h^2A^2}{2}+\frac{h^3A^3}{6}+O(h^4))\times(\mathrm{Id}+hB+\frac{h^2B^2}{2}+\frac{h^3B^3}{6}+O(h^4))\\ &=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(2AB+A^2+B^2)+\frac{h^3}{6}(A^3+B^3+3AB^2+3A^2B)+O(h^4).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem productExponentialCubic (A B : R) :
    PowerSeries.coeff 0 (formalSplitting A B)=1 ∧
    PowerSeries.coeff 1 (formalSplitting A B)=A+B ∧
    PowerSeries.coeff 2 (formalSplitting A B)=
      (1/2:ℝ) • A^2+A*B+(1/2:ℝ) • B^2 ∧
    PowerSeries.coeff 3 (formalSplitting A B)=
      (1/6:ℝ) • A^3+(1/2:ℝ) • (A^2*B)+(1/2:ℝ) • (A*B^2)+(1/6:ℝ) • B^3 := by
  exact ⟨textbookFormalOperatorProduct_coeff_zero A B,
    textbookFormalOperatorProduct_coeff_one A B,
    textbookFormalOperatorProduct_coeff_two A B,
    textbookFormalOperatorProduct_coeff_three A B⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.productExponentialCubic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；审阅Ch03.lean:259–269。MD.Ch03.formalSplitting A B展开为textbookFormalOperatorExponential A * textbookFormalOperatorExponential B；FormalOperatorSeries.lean把后者指数定义为PowerSeries.mk(n↦(1/(n! : ℝ))•A^n)，两个因子的低次展开由定义确定，乘法是真实的形式Cauchy乘积。R为任意实结合环代数，不预设交换；1\_R对应Id，形式变量对应h。四个合取覆盖系数0、1、2、3：1，A+B，A²/2+AB+B²/2，A³/6+A²B/2+AB²/2+B³/6。它们分别等于原页(2AB+A²+B²)/2及(A³+B³+3AB²+3A²B)/6，只有加法项的排列变化，没有把AB改成BA或改变因子顺序。所有低于4次的项都已包括，形式O(h⁴)解释充分，不涉及收敛。无[EXTRA]、[ERRATUM?]。证明状态另记：调用FormalOperatorSeries.lean四个Product\_coeff引理，本条与相应引理未见sorry；此次未编译，不以证明状态代替签名审计。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.productExponentialCubic`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L382)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-DifferenceCommutator · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述

> So the difference is

$$
\begin{aligned}e^{hA}e^{hB}-e^{h(A+B)}&=\frac{h^2}{2}(AB-BA)\\&\quad+\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4)\\&=\frac{h^2}{2}[A,B]+O(h^3),\end{aligned}
$$


> where $`[A,B]=AB-BA`$ is the commutator of $`A`$ and $`B`$.
> For a splitting method, we have, replacing $`A`$ by $`\mathcal L_{H_1}`$ and $`B`$ by $`\mathcal L_{H_2}`$,

$$
e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}-e^{h\mathcal L_H}=\frac{h^2}{2}[\mathcal L_{H_1},\mathcal L_{H_2}]+O(h^3).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem differenceCommutator (A B : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1/2 : ℝ) • (A*B-B*A) := by
  sorry

theorem differenceCommutator_coeff2 (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_two <;> assumption

theorem differenceCommutator_hamiltonian (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ∞ A) (_hB : ContDiff ℝ ∞ B) (_hφ : ContDiff ℝ ∞ φ)
    (z : SymplecticCoordinates n) :
    let S := hamiltonianSplittingObservable A B φ z-hamiltonianExactObservable A B φ z
    PowerSeries.coeff 0 S = 0 ∧ PowerSeries.coeff 1 S = 0 ∧
    PowerSeries.coeff 2 S = (1/2 : ℝ)*
      (textbookLieDerivative (textbookHamiltonianVectorField A)
        (textbookLieDerivative (textbookHamiltonianVectorField B) φ) z -
       textbookLieDerivative (textbookHamiltonianVectorField B)
        (textbookLieDerivative (textbookHamiltonianVectorField A) φ) z) := by
  sorry

theorem differenceCommutator_coeff3 (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) =
      (1/6 : ℝ) • ((2 : ℝ) • (A*B^2)+(2 : ℝ) • (A^2*B)-
        B*A^2-B*A*B-B^2*A-A*B*A) := by
  rw [map_sub, textbookFormalOperatorProduct_coeff_three,
    textbookFormalOperatorExponential_coeff]
  norm_num
  have hp : (A+B)^3 = A^3+A^2*B+A*B*A+A*B^2+
      B*A^2+B*A*B+B^2*A+B^3 := by noncomm_ring
  rw [hp]
  module

theorem differenceCommutator_hamiltonian_coeff3 (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ∞ A) (_hB : ContDiff ℝ ∞ B) (_hφ : ContDiff ℝ ∞ φ)
    (z : SymplecticCoordinates n) :
    let LA := textbookLieDerivative (textbookHamiltonianVectorField A)
    let LB := textbookLieDerivative (textbookHamiltonianVectorField B)
    PowerSeries.coeff 3 (hamiltonianSplittingObservable A B φ z-
      hamiltonianExactObservable A B φ z) = (1/6 : ℝ)*
      (2*LA (LB (LB φ)) z+2*LA (LA (LB φ)) z-
        LB (LA (LA φ)) z-LB (LA (LB φ)) z-LB (LB (LA φ)) z-LA (LB (LA φ)) z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.differenceCommutator`；`MD.Ch03.differenceCommutator_coeff2`；`MD.Ch03.differenceCommutator_hamiltonian`；`MD.Ch03.differenceCommutator_coeff3`；`MD.Ch03.differenceCommutator_hamiltonian_coeff3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。 | [EXTRA] |

[EXTRA] [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[EXTRA] 保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。

### 6. 审计结论

本轮修复：保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；已逐一核对 differenceCommutator、differenceCommutator\_coeff2 与 differenceCommutator\_hamiltonian。一般代数版包含差的零、一次系数为零及二次系数 (AB−BA)/2；辅助版仅二次系数；Hamiltonian 版在 n 自由度、A,B,φ 全域 C∞ 下对所有 z 给出同样三项，右边是 (L\_A L\_Bφ−L\_B L\_Aφ)(z)/2。它们正确覆盖 JSON 当前摘录的 O(h³) 结论。但 [EXTRA] 明确声称还包含三次系数，三份声明均没有该项；原页同一个差的展示式还给出三次项及 O(h⁴)，JSON 将该行省略。不能把二次系数辅助定理当作三次结论。

### 7. 状态与证明位置

incomplete；`MD.Ch03.differenceCommutator`：未证（缺大型理论）；`MD.Ch03.differenceCommutator_coeff2`：已证；`MD.Ch03.differenceCommutator_hamiltonian`：未证（缺大型理论）；`MD.Ch03.differenceCommutator_coeff3`：已证；`MD.Ch03.differenceCommutator_hamiltonian_coeff3`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L398)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-DifferenceCubic · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述


$$
e^{hA}e^{hB}-e^{h(A+B)}=\frac{h^2}{2}(AB-BA)+\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem differenceCubic (A B : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1/2 : ℝ) • (A*B-B*A) ∧
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  sorry

theorem differenceCubic_coeff3 (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_three <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.differenceCubic`；`MD.Ch03.differenceCubic_coeff3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：differenceCubic对任意环境实代数中的A、B，合取差式0、1次系数为0、2次系数为(AB−BA)/2及完整3次六项系数；differenceCubic\_coeff3是同一3次等式的辅助声明。项目指数定义的第n项为A^n/n!，乘法次序为先A后B；没有交换性前提。形式O(h^4)恰为0至3次这些系数约束，不涉及解析收敛。[EXTRA]增加低次合取恢复了完整差式，合理。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.differenceCubic`：未证（缺大型理论）；`MD.Ch03.differenceCubic_coeff3`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L451)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianCommutator · unnumbered_claim · 印刷p.104–105 / PDFp.126–127

### 2. 原文陈述

> Observe that, for any real-valued functions $`f`$ and $`H`$ of phase space,

$$
\mathcal L_Hf=\nabla f^TJ\nabla H=\{f,H\}.
$$


> Hence $`\mathcal L_{H_1}\mathcal L_{H_2}f=\{\{f,H_2\},H_1\}`$, and, using this and skew-symmetry of the Poisson bracket,

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=\{\{f,H_2\},H_1\}-\{\{f,H_1\},H_2\}=\{\{f,H_2\},H_1\}+\{\{H_1,f\},H_2\}.
$$


> By the Jacobi identity, $`\{\{f,H_2\},H_1\}+\{\{H_2,H_1\},f\}+\{\{H_1,f\},H_2\}=0`$.
> Therefore

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=-\{\{H_2,H_1\},f\}=\{f,\{H_2,H_1\}\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianCommutator
    (F H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiffAt ℝ 2 F z) (hH₁ : ContDiffAt ℝ 2 H₁ z)
    (hH₂ : ContDiffAt ℝ 2 H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField H₁)
        (textbookLieDerivative (textbookHamiltonianVectorField H₂) F) z -
      textbookLieDerivative (textbookHamiltonianVectorField H₂)
        (textbookLieDerivative (textbookHamiltonianVectorField H₁) F) z =
      textbookLieDerivative (textbookHamiltonianVectorField
        (textbookPoissonBracket H₂ H₁)) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_commutator <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianCommutator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F,H₁,H₂在z为C²；原文smooth资格显式化。 | [EXTRA] |

[EXTRA] F,H₁,H₂在z为C²；原文smooth资格显式化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；审阅Ch03.lean:288–298。依赖SymplecticForm.lean中相空间是q、p标记的有限维实坐标，textbookJ=[0,I;-I,0]；SplittingError.lean的Hamiltonian场是J乘实际Fréchet导数的坐标梯度。LiePoisson.lean及本文件的textbookLieDerivative f F z均为DF(z)[f(z)]，textbookPoissonBracket G H z=DG(z)[J∇H(z)]，即{G,H}，不是顺序倒置的定义。故本声明左边确为L\_H₁L\_H₂F−L\_H₂L\_H₁F，右边确为{F,{H₂,H₁}}。它对任意Nc、F、H₁、H₂、z及局部C²假设量化，完整对应原文跨页推导的最终结论；第一识别、反对称及Jacobi等中间行是该结论的推导步骤，不是被改成假设。所用实际定义给出L\_HF={F,H}，依赖中skew与Jacobi也按此J约定展开，未省略独立的结论。[EXTRA] 三个ContDiffAt ℝ 2是自然且充分的局部正则资格，使嵌套导数及Hessian对称可用；原文smooth情形满足这些资格，不引入解析性、全局流或结论本身。C²是充分条件，不主张它对每组特例都是最弱条件。本条无[ERRATUM?]，它对应PDF127第一式的正确顺序；紧接的印刷反序公式另属本批下一条。证明状态另记：本条调用textbookHamiltonianLieDerivative\_commutator，其依赖证明使用实际二阶导数和Hessian对称，本条及相应引理未见sorry；此次未编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianCommutator`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L468)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianCommutatorPrinted · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> This means that it is possible to relate the commutator of Lie derivatives of Hamiltonian vector fields to the Lie derivative of the Poisson bracket of the corresponding Hamiltonians, i.e.,

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=\mathcal L_{\{H_1,H_2\}}f.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingShadowPrinted :
  ∀ (n : ℕ) (A B F : SymplecticCoordinates n → ℝ), ContDiff ℝ 2 A →
    ContDiff ℝ 2 B → ContDiff ℝ 2 F → ∀ z,
    hamiltonianLie A (hamiltonianLie B F) z-hamiltonianLie B (hamiltonianLie A F) z=
      hamiltonianLie (textbookPoissonBracket A B) F z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingShadowPrinted` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F,H₁,H₂取C²，原文smooth资格明示。 | [EXTRA] |

[EXTRA] F,H₁,H₂取C²，原文smooth资格明示。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；签名忠实性PASS，原命题的数学真伪另外判为错误，二者不混同。审阅Ch03.lean:303–308，并展开Ch03\_deps.txt中ReviewDefinitions.lean的hamiltonianLie H φ=textbookLieDerivative (textbookHamiltonianVectorField H) φ；LiePoisson.lean中textbookLieDerivative f φ z=Dφ(z)[f(z)]、textbookPoissonBracket A B z=DA(z)[J∇B(z)]；SplittingError.lean实际场为J梯度，SymplecticForm.lean实际J=[0,I;-I,0]，相空间为(Fin n ⊕ Fin n)→ℝ。因而∀n,A,B,F，C² A→C² B→C² F→∀z的结论实际就是[L\_A,L\_B]F(z)=L_{ {A,B} }F(z)，与本条印刷式逐项一致，未暗改为正确的{B,A}。[EXTRA] 全局ContDiff ℝ 2是对原文smooth资格的合理充分表达，保证任意z的二阶计算；它比逐点资格强，但符合全空间∀z的陈述，且不能挽救下述光滑多项式反例。[ERRATUM?]确实成立：按这些实际定义正确公式是[L\_A,L\_B]F=L_{ {B,A} }F=−L_{ {A,B} }F。因此PASS仅表示签名忠实于所冻结的印刷来源，绝不表示该错误印刷断言可以证明。证明状态另记：本条证明体显式为sorry；没有把sorry当作签名不忠实的理由，也没有把它当作原书错误的验证。实际反例独立确立原式为假。此次未编译或补证明。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingShadowPrinted`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L483)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-LeadingModifiedExponential · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> Because of this, we may interpret the first term in the expansion of the error as itself being derived from a Hamiltonian. This is a crucial observation which suggests an alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:

$$
e^{hA}e^{hB}=e^{h(A+B+hR)},
$$


> for some operator $`R`$. Expanding out the right hand side gives

$$
\begin{aligned}e^{h(A+B+hR)}&=\mathrm{Id}+h(A+B+hR)+\frac{h^2}{2}(A+B+hR)^2+\cdots\\ &=\mathrm{Id}+hA+hB+h^2R+\frac{h^2}{2}\bigl(A^2+AB+BA+B^2+h^2R^2+h(A+B)R+hR(A+B)\bigr)+\cdots.\end{aligned}
$$


> Comparing this to our expansion for $`e^{hA}e^{hB}`$, for agreement to $`O(h^2)`$ we must have

$$
\frac12(2AB+A^2+B^2)=R+\frac12(A^2+AB+BA+B^2)=O(h),
$$


> or

$$
R=AB-\frac12(AB+BA)=\frac12[A,B]+O(h),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingModifiedExponential (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
  sorry



/-- 修正版，对应原文 MD-3.3-LeadingModifiedExponential。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem leadingModifiedExponential_corrected (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingModifiedExponential`；`MD.Ch03.leadingModifiedExponential_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：A、B属于同一实代数；n为自然数且n<3，即全部低于3次的系数相等。modifiedGenerator为(A+B)X+CX²；textbookFormalZeroConstantExponential确为零常项形式级数的指数，故C=(AB−BA)/2时结论正确。没有假设完整R(h)存在，更未形式化原书错误的系数比较链。context已披露该限制，但extra\_assumptions空列表未列出这一范围缩减；整段原文的数学问题需人工保留处理。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingModifiedExponential`：未证（原书疑误不证）；`MD.Ch03.leadingModifiedExponential_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L493)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-LeadingShadowHamiltonian · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> and from this it follows that

$$
e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}=e^{h\mathcal L_G},
$$


> where

$$
G=H_1+H_2+\frac h2\{H_1,H_2\}+O(h^2).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingShadowHamiltonian :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3 := by
  sorry



/-- 修正版，对应原文 MD-3.3-LeadingShadowHamiltonian。改动：默认保留状态复合Φ_h∘Ψ_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL_B)exp(hL_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。 -/
```

独立修正版：

```lean
theorem leadingShadowHamiltonian_corrected :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ∞ A D → ContDiffOn ℝ ∞ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingShadowHamiltonian`；`MD.Ch03.leadingShadowHamiltonian_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。 | [EXTRA] |

[EXTRA] D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。；[ERRATUM?] 默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已读取 Ch03.lean 实际声明和 Ch03\_deps.txt 对应 -- FILE 段，审计针对签名语义；该 theorem 的证明体为 sorry，不据此判断签名 PASS/FAIL，亦不声称已获 Lean 验证。依赖展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，inl 为 q、inr 为 p；textbookJ=[[0,I],[-I,0]]；X\_H=textbookHamiltonianVectorField H=J∇H；textbookPoissonBracket F G=DF(X\_G)=Σ(F\_q G\_p−G\_q F\_p)。actualFlow f D Φ η 展开为 η>0，且每个 z∈D 有 Φ(0,z)=z，对全部 |t|<η 有 Φ(t,z)∈D 和时间方向 HasDerivAt Φ(·,z) f(Φ(t,z)) t；未把复合相等或匹配放进假设。solution f γ 0 h 展开为在整个闭区间 [0,h] 的 HasDerivWithinAt γ (f(γ(t)))。按原页及 PDF124/印刷102 的 L\_H F={F,H}，exp(hL\_A) 是 Φ\_A 的 pullback；exp(hL\_A)exp(hL\_B)F=F∘Ψ\_B∘Φ\_A，而 Lean 端点是 Φ\_A∘Ψ\_B。实际 [L\_A,L\_B]=L_{ {B,A} }=−L_{ {A,B} }，PDF127 顶部第一式也给出 {B,A}，紧接的第二式却改成 {A,B}，故该原书符号疑误可确定。Lean 的正号 Hamiltonian 对 Φ\_A∘Ψ\_B 是合理的，但这不是所引原文算子等式的逐义形式化。 [EXTRA] 开放域和无限光滑保证局部 ODE 唯一及 Taylor 控制，紧 K⊆D 用于统一 C、δ，均合理；无限光滑高于此低阶估计所需但符合原书 smooth 语境。actualFlow 要求全 D 统一时间且保持 D，是强于普通局部流的实质限制，应披露；不能仅解释为给定一点的局部流。结论 C、δ、Γ 先于 h,z，确为统一端点 O(h³)，但只是首阶截断的有限近似，并非原文全部形式等式。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingShadowHamiltonian`：未证（原书疑误不证）；`MD.Ch03.leadingShadowHamiltonian_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L518)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

