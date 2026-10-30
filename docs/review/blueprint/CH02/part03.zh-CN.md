[上一部分](part02.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## 1. MD-2.3.4-MatrixCancellation · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> hence

$$
\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.
$$



### 3. 原文证明

> Computing

$$
W^TJ\dot W=W^TJ^2SW=-W^TSW,
$$


> whereas

$$
\dot W^TJW=W^TS^TJ^TJW=W^TSW,
$$


> hence

$$
\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.
$$


原文Computing、whereas和hence的矩阵计算按原页保留于proof\_latex；本条matrixCancellation\_time已登记实际乘积求导及零导数，时间区间上推出常值是后续步骤。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem matrixCancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0 := by
  apply MolecularDynamics.hamiltonian_variational_matrix_cancellation <;> assumption

theorem matrixCancellation_time {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (I : Set ℝ) (t : ℝ)
    (_hS : (S t).IsSymm)
    (_hW : HasDerivWithinAt W (textbookJ Nc * S t * W t) I t) :
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s)
      ((textbookJ Nc * S t * W t)ᵀ * textbookJ Nc * W t +
        (W t)ᵀ * textbookJ Nc * (textbookJ Nc * S t * W t)) I t ∧
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s) 0 I t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.matrixCancellation`；`MD.Ch02.matrixCancellation_time` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | S对称；任意矩阵W。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。 | [EXTRA] |

[EXTRA] S对称；任意矩阵W。；[EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原页20（印刷79页）Computing、whereas及两条中间矩阵等式一致；statement开头原页是小写hence，当前写成Hence，已作字面修正。代数主定理对任意W和对称S断言(JSW)ᵀJW+WᵀJ(JSW)=0。time版本对任意集合I和点t，假设S(t)对称及W在I内真实导数JS(t)W(t)，同时给乘积导数的完整两项表达式和零导数结论。交换的是相加项顺序，不是矩阵乘积顺序；J²=−I和JᵀJ=I的消去符号正确。任意I无需额外可微性，因为HasDerivWithinAt已提供所需局部资格。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.matrixCancellation`：已证；`MD.Ch02.matrixCancellation_time`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1096)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-FormConstant · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> This means that $`W^TJW`$ is a constant matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem formConstant {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, (W t)ᵀ * textbookJ Nc * W t = (W 0)ᵀ * textbookJ Nc * W 0 := by
  apply MolecularDynamics.hamiltonian_variational_form_constant <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.formConstant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。 | [EXTRA] |

[EXTRA] S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。Ch02.lean:814–821 对所有时间矩阵S,W及τ，在Icc 0 τ各点S对称且W具有实际区间内导数JSW下，推出每一t的W(t)ᵀJW(t)等于初始值；恰为连通时间窗常矩阵的全部结论。S逐点对称、真实矩阵ODE和连通区间是原推导合理背景；不要求S可微或连续，这是合理且更一般的陈述。端点采用HasDerivWithinAt适当；τ=0平凡，τ<0结论为空，无须τ>0。依赖HamiltonianVariational.lean实际利用乘积法则得到零导数，再用均值定理推常值；无sorry。本条独立量化W，不声称错误移动点Jacobian已满足ODE，因此前项FAIL不否定此条件命题。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.formConstant`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1114)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HamiltonSymplectic · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> hence

$$
W^TJW\equiv W(0)^TJW(0)=J.
$$


> This proves that the flow map of a Hamiltonian system is a symplectic map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonSymplectic {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 <;> assumption



/-- 修正版，对应原文 MD-2.3.4-HamiltonSymplectic。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem hamiltonSymplectic_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonSymplectic`；`MD.Ch02.hamiltonSymplectic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；原页21（印刷79页）hence、WᵀJW≡W(0)ᵀJW(0)=J及最后流为辛映射原句忠实。Lean对象为真实H和联合C²实际解族Φ，Φ0=id且满足Hamilton ODE；结论对每个t∈[0,τ]为IsTextbookSymplecticMap，展开即C¹与每初值点的Jacobian辛恒等式，初始Jacobian由Φ0=id为I。该签名本身数学正确，且没有τ>0前提。但原页紧邻上下文实际写W(t)=F′_t(z(t,ξ))，而变分矩阵通常应为D\_ξF\_t(ξ)；随移动点评价的全导数另有空间链式项。当前context只称疑点另项记录，未具体登记；按照保留原书数学疑误要求，本条需人工明确W的约定，不将正确Lean结论冒充对原书该推导的逐字证明。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonSymplectic`：已证；`MD.Ch02.hamiltonSymplectic_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1125)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-ChainRule · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> Let $`\Phi_1`$ and $`\Phi_2`$ be any pair of symplectic maps. Then

$$
(\Phi_1\circ\Phi_2)'=\Phi_1'\Phi_2',
$$


> by the chain rule,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem chainRule {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  apply MolecularDynamics.textbookJacobian_comp <;> assumption



/-- 修正版，对应原文 MD-2.3.5-ChainRule。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem chainRule_corrected {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  apply MolecularDynamics.textbookJacobian_comp <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.chainRule`；`MD.Ch02.chainRule_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；原页22（印刷79页）两辛映射、链式展示式和by the chain rule,逐字一致。Lean对任意两个全局可微实际映射Φ,Ψ及每个z，明确给Jacobian(Φ∘Ψ)(z)=Jacobian Φ(Ψ(z))·Jacobian Ψ(z)，矩阵乘法顺序正确。辛性对链式法则不必要，去掉该前提是有效推广；hΦ,hΨ是全局可微而不是extra说明中的仅在相应点可微。原文外导数评价点省略的NEEDS\_HUMAN问题已存在，本次保留：按标准简写约定可解释正确，若按同一z字面解释则不正确，需人工确认原文约定；不改动原文展示式。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.chainRule`：已证；`MD.Ch02.chainRule_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1152)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-SymplecticComposition · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> Thus the composition of any pair of symplectic maps is a symplectic map.

### 3. 原文证明

原书无独立完整证明。
> by the chain rule, hence

$$
[(\Phi_1\circ\Phi_2)^\prime]^T J(\Phi_1\circ\Phi_2)^\prime=[\Phi_1^\prime\Phi_2^\prime]^T J\Phi_1^\prime\Phi_2^\prime=\Phi_2^{\prime T}\Phi_1^{\prime T}J\Phi_1^\prime\Phi_2^\prime=\Phi_2^{\prime T}J\Phi_2^\prime=J.
$$


原书在结论前给出链式法则和保持辛矩阵的连续等式推导，无独立编号证明；推导记录于 proof\_discussion\_latex。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticComposition {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ) := by
  apply MolecularDynamics.IsTextbookSymplecticMap.comp <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticComposition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意自然数Nc（含0），相空间为(Fin Nc⊕Fin Nc)→ℝ；Φ、Ψ为同一空间自映射，两个前提各含全局C¹及每一点DΦᵀJDΦ=J，结论是Φ∘Ψ全局C¹且逐点保J。textbookJacobian为标准基下Fréchet导数矩阵，J=[0 I;-I 0]，与dq∧dp一致。复合次序正确，无额外假设。原书省略Jacobian求值点的记号按链式法则解释。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticComposition`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1168)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-SymplecticInverse · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> and the inverse of a symplectic map is symplectic since $`\Phi'^TJ\Phi'=J`$ implies $`J=\Phi'^{-T}J\Phi'^{-1}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticInverse {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  apply MolecularDynamics.IsTextbookSymplecticEquiv.symm <;> assumption



/-- 修正版，对应原文 MD-2.3.5-SymplecticInverse。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticInverse_corrected {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  apply MolecularDynamics.IsTextbookSymplecticEquiv.symm <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticInverse`；`MD.Ch02.symplecticInverse_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Lean对任意Nc、实际双射e，假设e全局C¹且保J，并另有e.symm全局C¹，结论给出逆映射保J以及其逆C¹；这个受限定理正确，[EXTRA]已披露。可是本页上下文把Jacobian非奇异当作全局可逆的理由；此Lean没有证明原文所暗含的任意保辛自映射均有全球逆。矩阵恒等式与映射可逆性必须分开，保留原书疑误供人工处理。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticInverse`：已证；`MD.Ch02.symplecticInverse_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1177)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-GlobalGroupPrinted · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> The determinant of a symplectic map is $`\pm1`$, hence these maps are always invertible, and the inverse of a symplectic map is symplectic since $`\Phi'^TJ\Phi'=J`$ implies $`J=\Phi'^{-T}J\Phi'^{-1}`$. Thus the symplectic maps form a group under composition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem globalGroupPrinted : ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n),
    IsTextbookSymplecticMap Φ → Function.Bijective Φ ∧
      IsTextbookSymplecticMap (Function.invFun Φ) := by
  sorry



/-- 修正版，对应原文 MD-2.3.5-GlobalGroupPrinted。改动：只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。 -/
```

独立修正版：

```lean
theorem globalGroupPrinted_corrected (n : ℕ)
    (e : SymplecticCoordinates n ≃ SymplecticCoordinates n)
    (he : IsTextbookSymplecticMap e) (hi : ContDiff ℝ 1 e.symm) :
    IsTextbookSymplecticMap e.symm := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.globalGroupPrinted`；`MD.Ch02.globalGroupPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。 | [EXTRA] |

[EXTRA] [ERRATUM?] 只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt：SymplecticForm.lean 第33–41行将 SymplecticCoordinates n 定义为 (Fin n ⊕ Fin n) → ℝ（q 后 p），矩阵为该指标上的实方阵，textbookJ=[[0,I],[-I,0]]；第138–139行 IsTextbookSymplectic A 是 AᵀJA=J。SymplecticMaps.lean 第238–241行 textbookJacobian 是实际 Fréchet 导数 fderiv 的坐标矩阵，第272–274行 IsTextbookSymplecticMap Φ 是 ContDiff ℝ 1 Φ ∧ ∀ z, DΦ(z)ᵀJDΦ(z)=J，不含全球双射。 Ch02.lean 第859–862行量词为所有 n、所有 C¹ 辛自映射，推出全球双射及选择逆 Function.invFun Φ 为 C¹ 辛映射。在双射假设成立时 invFun 是真实唯一逆，但辛假设本身不保证双射。[ERRATUM?] 成立，正式谓词确实允许下面 n=1 的光滑反例。这一假命题保留了原书全球可逆性疑误，命题为假本身不等于错误转录；独立的签名忠实性问题是本条 statement\_scope 包含原句全部展示主张，而签名没有明示“Jacobian 行列式 ±1”子句，也未给实际群对象/群结构。行列式由 deps 第312–316行可推出更强的逐点 det=1，闭合、单位与逆可另由本批前项及库群构造组合，但这些未成为本声明的完整结论。故按全部结论子句审计 FAIL。deps 第366–382行已经提供由真正全球辛微分同胚构成的 Subgroup 及其复合运算，可用于另列修正版。正文直接 sorry：这单独表示证明未完成，不作为 FAIL 的理由，也不尝试补证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.globalGroupPrinted`：未证（原书疑误不证）；`MD.Ch02.globalGroupPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1193)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-SymplecticIntegrator · definition · 印刷p.80 / PDFp.102

### 2. 原文陈述

> A symplectic integrator is an approximation of the flow map that conserves the symplectic 2-form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_symplecticIntegrator {n : ℕ}
    (H : SymplecticCoordinates n → ℝ) (F : Flow ℝ (SymplecticCoordinates n))
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ContDiff ℝ 2 H ∧
  (∀ t z, HasDerivAt (fun s ↦ F s z) (textbookHamiltonianVectorField H (F t z)) t) ∧
  ∃ δ > 0, (∀ h ∈ Ioo 0 δ, bp_IsSymplecticMap (G h)) ∧
    ∃ r : ℝ, 0 < r ∧ ∀ z, ∃ K ≥ 0, ∃ d > 0, d ≤ δ ∧
      ∀ h ∈ Ioo 0 d, ‖G h z - F h z‖ ≤ K * h^(r+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticIntegrator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。 | [EXTRA] |

[EXTRA] [EXTRA] 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；n任意；H在整个相空间C²，F是已给全球Flow并在所有t,z满足Hamilton方程。存在统一δ>0，对每个0<h<δ的G h要求可微且逐点保J；存在一个对所有z通用的实数r>0，每个z另有K≥0和0<d≤δ，使0<h<d时误差≤K*h^(r+1)。这确实把保辛与实际流的正阶局部近似合取；G 0、负步长、全局误差、对z一致误差没有被声称。全球流、C²及正步长范围均属已明示的充分限定。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticIntegrator`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1213)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-SymplecticEuler · definition · 印刷p.80 / PDFp.102

### 2. 原文陈述

> The following scheme is a slight modification of the Euler method.

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\tag{2.18}
$$



$$
\boldsymbol P=\boldsymbol p+hF(\boldsymbol q).\tag{2.19}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_symplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Ch02\_deps.txt:568–571，positionProjection z i=z(inl i)；583–586，PotentialForce U q i=−DU(q)(e\_i)；619–630，kick 保持 q 并在旧 q 计算 P\_i=p\_i+hF\_i(q)，drift 保持 P 并给 Q\_i=q\_i+h(m\_i)⁻¹P\_i。Ch02.lean:869–872 的复合先 kick 后 drift，与 PDF102/印刷80 的(2.18)、(2.19)两式及 F=−∇U 完全相符，且与 deps:733–737 的 textbookSymplecticEuler 同一定义。m,U,h 是固定参数，不存在质量对位置的隐含依赖或隐式求解存在性承诺。定义对任意实数质量及任意 U 总化：零质量逆元为0，不可微处 fderiv 为0；这是教材有效域外的扩展，在可逆对角质量及可微势的教材域内没有改变公式，不作为额外物理实例宣称。无 [EXTRA]/[ERRATUM?]，本定义无 sorry；原书正文小写 q 疑误仍由原样保留的 A 审阅记录，不影响原两式。版本绑定：Blueprint/Ch02.lean 的实际附件副本为 /workspace/Ch02.lean，按该副本原始字节计算哈希；未修改附件。本次为定义展开后的只读签名语义审计，未编译工程，不将无直接 sorry 等同于全部依赖证明已验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticEuler`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1223)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-KickDifferential · unnumbered_claim · 印刷p.81 / PDFp.103

### 2. 原文陈述

> then

$$
dQ_i=dq_i+hm_i^{-1}dP_i,\tag{2.20}
$$



$$
dP_i=dp_i-h\sum_{j=1}^{N_c}\frac{\partial^2U}{\partial q_j\partial q_i}dq_j.\tag{2.21}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kickDifferential : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    ContDiff ℝ 2 U → ∀ ξ : SymplecticCoordinates n, ∀ i : Fin n,
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inl i) =
        ξ (Sum.inl i)+h*(m i)⁻¹*((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) ∧
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) =
        ξ (Sum.inr i)-h*((fderiv ℝ (grad U) (z ∘ Sum.inl)) (ξ ∘ Sum.inl)) i := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.kickDifferential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²，实际Hessian。 | [EXTRA] |

[EXTRA] U C²，实际Hessian。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:876–882 的量词顺序为任意 n,m,U,h,z，在 U C² 后任意切向量 ξ、任意 i，结论为两式合取。已展开 Q=Fin n→ℝ（deps:2816）、坐标 inl=q/inr=p（33）、grad U q i=DU(q)(e\_i)（2932）、实际完整 Euler 步（733–737）及负梯度（583–586）。令 δq=ξ∘inl，则 D(grad U)(q)[δq]_i=∑_j ∂_j∂_i U(q)δq\_j：由有限维基展开及实际梯度导数得出，不是任意假设 Hessian。第一结论为 δQ\_i=δq\_i+h(m\_i)⁻¹δP\_i，第二为 δP\_i=δp\_i−h∑_j ∂_j∂_i U δq\_j，完整覆盖 PDF103/印刷81 的(2.20)、(2.21)，均针对整个步映射的实际 fderiv。[EXTRA] 全局 C² 保证势力 C¹及二阶导数，是合理充分条件，但强于单点计算所需，不能称为最低必要条件。固定对角质量来自模型；任意 m 的总化扩展在非零质量域完全一致，零质量仍满足扩展后的导数恒等式。无 [ERRATUM?]。该声明体有 sorry，证明未完成，独立于签名 PASS。版本绑定：Blueprint/Ch02.lean 的实际附件副本为 /workspace/Ch02.lean，按该副本原始字节计算哈希；未修改附件。本次为定义展开后的只读签名语义审计，未编译工程，不将无直接 sorry 等同于全部依赖证明已验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.kickDifferential`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1230)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-WedgeSelf · unnumbered_claim · 印刷p.81 / PDFp.103

### 2. 原文陈述

> but $`du\wedge du\equiv0`$ for any $`u`$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem wedgeSelf :
  ∀ n (α : SymplecticCoordinates n →ₗ[ℝ] ℝ) u v, textbookWedgeOneForms α α u v = 0 := by
  exact MolecularDynamics.Chapter02Review.wedgeSelf_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.wedgeSelf` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；deps:73–76 实际定义为 mul 双线性形式经 α,β 复合减去经 β,α 复合，故值为 α(u)β(v)−β(u)α(v)，等于78–82中的 α(u)β(v)−α(v)β(u)。取 β=α，实数乘法交换给零。Ch02.lean:885–887 对所有 n、线性一形式 α 及两切向量 u,v 量化，是 PDF103/印刷81 的 du∧du≡0 的正确逐点推广；在任一点取 α=du 即涵盖原句，不需要额外正则性假设来证明该代数恒等式。无 [EXTRA]/[ERRATUM?]。本体 exact wedgeSelf\_proved；deps:3172–3173 的 statement 和3360起的证明已提供，不以名称替代展开。声明无直接 sorry，未运行编译。版本绑定：Blueprint/Ch02.lean 的实际附件副本为 /workspace/Ch02.lean，按该副本原始字节计算哈希；未修改附件。本次为定义展开后的只读签名语义审计，未编译工程，不将无直接 sorry 等同于全部依赖证明已验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.wedgeSelf`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1239)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-SymplecticEulerPreserves · unnumbered_claim · 印刷p.81 / PDFp.103

### 2. 原文陈述

> This implies that

$$
\sum_{i=1}^{N_c}dQ_i\wedge dP_i=\sum_{i=1}^{N_c}dq_i\wedge dp_i,
$$


> which means that the method is symplectic.

### 3. 原文证明

原书无独立完整证明。
> Computing the 2-form,

$$
dQ_i\wedge dP_i=dq_i\wedge dP_i+hm_i^{-1}dP_i\wedge dP_i;
$$


> but $`du\wedge du\equiv0`$ for any $`u`$, hence

$$
dQ_i\wedge dP_i=dq_i\wedge dP_i;
$$


> and (2.21) implies

$$
dQ_i\wedge dP_i=dq_i\wedge dp_i-h\sum_{j=1}^{N_c}dq_i\wedge\frac{\partial^2U}{\partial q_j\partial q_i}dq_j.
$$


> It is then a simple exercise to show that

$$
\sum_{i=1}^{N_c}\sum_{j=1}^{N_c}dq_i\wedge\frac{\partial^2U}{\partial q_j\partial q_i}dq_j=0,
$$


> using the skew-symmetry of the wedge product and the fact that the Hessian matrix is symmetric.
原书给出保辛结论的计算性论证；其中 Hessian 双重求和为零明示留作 simple exercise，未逐项展开该消去计算。原论证完整转录在 proof\_discussion\_latex 中，不补写原书省略的演算。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerPreserves {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h) := by
  apply MolecularDynamics.textbookSymplecticEuler_isSymplectic <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticEulerPreserves` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²，固定对角质量；真实完整步映射。 | [EXTRA] |

[EXTRA] U C²，固定对角质量；真实完整步映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、固定对角系数m、势U、实步长h；hU要求U全局C²。完整步映射先动量kick p-h∇U(q)，后位置drift q+h m⁻¹P，输出保辛且C¹，与楔积求和结论一致。未假设正质量或非零质量；在教材非零质量域成立，Lean还把m=0按实数逆的总化定义扩展，保辛结论仍成立，不构成虚假定理。C²为充分[EXTRA]，应统一标记。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticEulerPreserves`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1245)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-Adjoint · definition · 印刷p.81 / PDFp.103

### 2. 原文陈述

> Given any numerical integrator $`\mathcal G_h`$, consider the map

$$
\mathcal G_h^\dagger=\mathcal G_{-h}^{-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_adjoint {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm



/-- 修正版，对应原文 MD-2.3.7-Adjoint。改动：把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。 -/
```

独立修正版：

```lean
noncomputable def bp_adjoint_corrected {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_adjoint`；`MD.Ch02.bp_adjoint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。 | [EXTRA] |

[EXTRA] [EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。；[ERRATUM?] 把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；E任意类型，G为每个实数步长都取实际置换的族；对任意h输出(G(-h)).symm，负号及求逆顺序完全符合定义。全球双射族比教材局部可逆方法强，[EXTRA]已披露，不会把任意非可逆一步法直接变成置换。这个定义只给伴随运算，不主张其精度或所有数值法可逆。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_adjoint`：定义；`MD.Ch02.bp_adjoint_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1253)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-FlowSelfAdjoint · unnumbered_claim · 印刷p.82 / PDFp.104

### 2. 原文陈述

> For the flow map $`\mathcal F_h`$, we know that the inverse map is precisely $`\mathcal F_{-h}`$, so $`\mathcal F_h^\dagger=\mathcal F_h`$, i.e. the flow map is in the normal sense “self-adjoint,” i.e. symmetric.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F := by
  apply MolecularDynamics.textbookFlowMethod_isSelfAdjoint <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.flowSelfAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。 | [EXTRA] |

[EXTRA] [EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意拓扑空间E及实参数全球Flow F；textbookFlowMethod F h=(F.toHomeomorph h).toEquiv。结论是整族函数相等，对全部实h有(F(-h))⁻¹=F(h)，完整表达自伴随。Flow按标准群作用含义采信；全球存在是已披露[EXTRA]，并非给任意ODE无条件断言全球存在。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.flowSelfAdjoint`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1264)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-BackwardEuler · definition · 印刷p.82 / PDFp.104

### 2. 原文陈述

> The adjoint method is defined by

$$
\boldsymbol Z=\boldsymbol z+hf(\boldsymbol Z),
$$


> and where the first was explicit, the second is implicit (it is the so-called backward Euler method).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_backwardEulerRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限维Q n=Fin n→ℝ、任意向量场f、实h及输入z、输出w，关系w=z+h•f(w)逐分量正是隐式Euler方程。原文只给隐式方程，context\_notation明确不声称存在唯一解，因而用Prop关系而非无条件的输出函数合适；first/second指代与前句显式Euler一致。它不证明全局逆存在，也没有作此断言。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_backwardEulerRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1269)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-EulerAdjoint · unnumbered_claim · 印刷p.82 / PDFp.104

### 2. 原文陈述

> In particular, consider Euler’s method

$$
\boldsymbol Z=\boldsymbol z+hf(\boldsymbol z).
$$


> The adjoint method is defined by

$$
\boldsymbol Z=\boldsymbol z+hf(\boldsymbol Z),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerAdjoint (f : E → E) (G : ℝ → Equiv.Perm E)
    (h : ℝ) (hG : ∀ Z, G (-h) Z = eulerStep f (-h) Z) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ Z = z + h • f Z := by
  apply MolecularDynamics.euler_adjoint_iff_backward <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。 | [EXTRA] |

[EXTRA] [EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:14、912–916给出实赋范向量空间E及任意f、双射族G、h；先要求∀Z,G(-h)Z=eulerStep f (-h)Z，再对任意z,Z给出双向等价。Ch02\_deps.txt:897–898展开eulerStep为x+h•f x，1240–1245展开负步逆，所以左式等价于Z-h•f Z=z，移项恰为Z=z+h•f Z。没有颠倒初态/终态或量词，也未要求正步Euler等于G(h)。[EXTRA]只需负步Euler可逆；全步双射族为已明示的接口加强。可逆性不能省，例如E=ℝ,f(x)=x,h=1时负步Euler恒零。无[ERRATUM?]；包装证明及1284–1288复用证明无显式sorry，语义判断独立于证明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.eulerAdjoint`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1273)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-AdjointSymplecticEuler · definition · 印刷p.82 / PDFp.104

### 2. 原文陈述

> Its adjoint method has a similar structure:

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\tag{2.22}
$$



$$
\boldsymbol P=\boldsymbol p+hF(\boldsymbol Q).\tag{2.23}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h

theorem bp_adjointSymplecticEuler_coordinates {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (h : ℝ) (z : SymplecticCoordinates Nc) :
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inl i) =
      z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i)) ∧
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inr i) =
      z (Sum.inr i) - h * fderiv ℝ U
        (fun j ↦ z (Sum.inl j) + h*(m j)⁻¹*z (Sum.inr j)) (Pi.single i 1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_adjointSymplecticEuler`；`MD.Ch02.bp_adjointSymplecticEuler_coordinates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。 | [EXTRA] |

[EXTRA] [EXTRA] 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；同时审查定义bp\_adjointSymplecticEuler和定理bp\_adjointSymplecticEuler\_coordinates。任意Nc，正质量hm、全局可微势hU、任意实h与初态z；伴随是原kick后drift置换在-h处的逆，故正步先drift后kick。结论两个∀i分别为Q\_i=q\_i+h m\_i⁻¹p\_i与P\_i=p\_i-h DU(Q)e\_i，求值位置Q及负号均正确。定义中的\_hm、_hU虽不参与计算，但定理显式携带这些前提。[EXTRA]充分且合理；sorry只表示未证明，不据此判签名失败。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_adjointSymplecticEuler`：定义；`MD.Ch02.bp_adjointSymplecticEuler_coordinates`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1280)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-AdjointInvolution · unnumbered_claim · 印刷p.82 / PDFp.104

### 2. 原文陈述

> the adjoint of the adjoint is the original method:

$$
\mathcal G_h^{\dagger\dagger}=[\mathcal G_{-h}^\dagger]^{-1}=[\mathcal G_h^{-1}]^{-1}=\mathcal G_h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem adjointInvolution {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G := by
  apply MolecularDynamics.textbookAdjointMethod_involutive <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.adjointInvolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际可逆步方法族Equiv.Perm；负步及双逆确实存在。 | [EXTRA] |

[EXTRA] 实际可逆步方法族Equiv.Perm；负步及双逆确实存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E任意类型，G:ℝ→Equiv.Perm E为全实步长实际可逆族；结论是伴随算子连续作用两次后的整族等式。逐h计算为((G(-(-h))).symm).symm=G h，量词、负步长及双逆齐全。全实可逆族为充分[EXTRA]，当前元数据应加统一标记。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.adjointInvolution`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1299)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-Splitting · definition · 印刷p.83 / PDFp.105

### 2. 原文陈述

> Let $`H(\boldsymbol q,\boldsymbol p)=H_1(\boldsymbol q,\boldsymbol p)+H_2(\boldsymbol q,\boldsymbol p)`$ have flow map $`\mathcal F_h`$, and indicate by $`\mathcal F_h^1,\mathcal F_h^2`$ the flow maps for the systems with Hamiltonians $`H_1,H_2`$, respectively. The proposal is that the map

$$
\mathcal G_h=\mathcal F_h^1\circ\mathcal F_h^2
$$


> is an approximation of $`\mathcal F_h`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h

theorem bp_splittingMap_eq (F₁ F₂ : ℝ → E → E) (h : ℝ) :
    bp_splittingMap F₁ F₂ h = splittingMap F₁ F₂ h := rfl

theorem bp_splittingMap_apply (F₁ F₂ : ℝ → E → E) (h : ℝ) (u : E) :
    bp_splittingMap F₁ F₂ h u = F₁ h (F₂ h u) := rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 组合构造定义；与MD-2.4.1-SplittingLocal跨条共同覆盖带真实Hamilton子流前提的近似结论。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_splittingMap`；`MD.Ch02.bp_splittingMap_eq`；`MD.Ch02.bp_splittingMap_apply` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。 | [EXTRA] |

[EXTRA] [EXTRA] 本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。

### 6. 审计结论

本轮修复：本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_splittingMap仅对任意类型E和任意两个函数族F₁、F₂定义F₁ h∘F₂ h，复合公式本身正确。但本条statement\_scope含整个引句：H=H₁+H₂、三者Hamilton流及近似结论；当前声明没有H、H₁、H₂、总流F、ODE/Flow前提或任何近似性质。context\_notation把精度交给下一条是合理分工说明，却没有建立本条定义与下一条splittingLocal的形式联系；该定理还使用独立的splittingMap定义。按要求核对完整结论，不能把纯组合构造视作全部数学断言已形式化。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_splittingMap`：定义；`MD.Ch02.bp_splittingMap_eq`：已证；`MD.Ch02.bp_splittingMap_apply`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1305)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-FieldAdd · unnumbered_claim · 印刷p.83 / PDFp.105

### 2. 原文陈述

> $`J\nabla H=J\nabla H_1+J\nabla H_2`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem fieldAdd {Nc : ℕ}
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (h₁ : DifferentiableAt ℝ H₁ z) (h₂ : DifferentiableAt ℝ H₂ z) :
    textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) z =
      textbookHamiltonianVectorField H₁ z + textbookHamiltonianVectorField H₂ z := by
  apply MolecularDynamics.textbookHamiltonianVectorField_add <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.fieldAdd` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H₁,H₂在实际点可微，实际Fréchet梯度。 | [EXTRA] |

[EXTRA] H₁,H₂在实际点可微，实际Fréchet梯度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开deps:33、38–39、1921附近：坐标为(Fin Nc ⊕ Fin Nc)→ℝ，inl为q、inr为p；J为块矩阵[0,I;−I,0]；向量场为J乘以各基向量Pi.single i 1上的实际Fréchet导数。因此正是J∇H，而非任意名为梯度的参数。两项在同一点z可微保证fderiv(H₁+H₂)=fderiv H₁+fderiv H₂，结论逐坐标为所需加法。H由H₁+H₂直接构造，无遗漏H分解条件。[EXTRA]可微是原文梯度存在的合理资格，避免不可微处fderiv总化；无[ERRATUM?]。正文调用库定理，无直接sorry，未作编译或全依赖无sorry认证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.fieldAdd`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1316)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SplittingLocal · unnumbered_claim · 印刷p.83 / PDFp.105

### 2. 原文陈述

> For this to be a first order method, we need at least $`\|\mathcal G_h(\boldsymbol u)-\mathcal F_h(\boldsymbol u)\|\le C(\boldsymbol u)h^2`$.

### 3. 原文证明

> Expand $`\mathcal F_h(\boldsymbol u)`$ in a Taylor series:

$$
\mathcal F_h(\boldsymbol u)=\boldsymbol u+hJ\nabla H+\mathcal O(h^2)=\boldsymbol u+h(J\nabla H_1+J\nabla H_2)+\mathcal O(h^2).\tag{2.24}
$$


> On the other hand,

$$
\mathcal F_h^1(\boldsymbol u)=\boldsymbol u+hJ\nabla H_1(\boldsymbol u)+\mathcal O(h^2),\qquad\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+\mathcal O(h^2).
$$


> Composing the maps we have

$$
\mathcal F_h^1\circ\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+hJ\nabla H_1(\boldsymbol u+hJ\nabla H_2(\boldsymbol u))+\mathcal O(h^2).
$$


> Assuming $`H_1`$ is $`C^2`$, we have

$$
\mathcal F_h^1\circ\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+h(J\nabla H_2(\boldsymbol u)+J\nabla H_1(\boldsymbol u))+\mathcal O(h^2),
$$


> which agrees with the expansion (2.24) of the flow map through the terms of first order. Thus the splitting method does indeed provide a second order local approximation of the flow map.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem splittingLocal {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2)) := by
  exact MolecularDynamics.exists_hamiltonian_splitting_localError_bound
    D hD H₁ H₂ hH₁ hH₂ F F₁ F₂ u hτ hFD hF₂D hF₁D hF hF₂ hF₁ hc hinit hinit₂ hinit₁
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.splittingLocal` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。 | [EXTRA] |

[EXTRA] 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、开放域D，H₁,H₂在D上C²；u任意但由F 0 u=u与留域条件保证u∈D。τ≥0，F在[0,τ]上满足H₁+H₂的ODE，F₂满足H₂，F₁在F₂(s,u)出发的整矩形轨道满足H₁；初值、留域、矩形联合连续条件齐备。结论存在C>0使所有0≤h≤τ的实际复合与总流差≤C h²，τ>0还给右侧h→0的O(h²)。常数可依赖u及固定输入，未假设待证误差。τ=0时只需初值相等，BigO有τ>0前提，未把退化区间当作局部渐近结论。C²双势、留域及连续性均为充分[EXTRA]；原书second order local指O(h²)，不误读成全局二阶。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.splittingLocal`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1325)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-KineticFlow · Example 2.4 · 印刷p.83 / PDFp.105

### 2. 原文陈述

> Let

$$
H_1(\boldsymbol q,\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2,\qquad H_2(\boldsymbol q,\boldsymbol p)=U(\boldsymbol q),
$$


> then a splitting method for $`H=H_1+H_2`$ may be obtained by determining the flow maps for each of the two parts. For $`H_1`$ we have the differential equations

$$
\dot{\boldsymbol q}=M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol0.
$$


> The second equation tells us that $`\boldsymbol p`$ is constant, so it is fixed at its initial value, whereas the first equation says that $`\boldsymbol q`$ evolves on a linear path, hence its flow map is

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\qquad\boldsymbol P=\boldsymbol p.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)

def kineticHamiltonian {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  ∑ i, (z (Sum.inr i))^2/(2*m i)

theorem bp_kineticFlow_initial {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_kineticFlow m 0 z = z := by
  funext i
  cases i <;> simp [bp_kineticFlow]

theorem bp_kineticFlow_hamiltonian {Nc : ℕ} (m : Fin Nc → ℝ)
    (_hm : ∀ i, 0 < m i) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_kineticFlow m s z)
      (textbookHamiltonianVectorField (kineticHamiltonian m) (bp_kineticFlow m t z)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_kineticFlow`；`MD.Ch02.momentumKickDerivative`；`MD.Ch02.momentumKick_hasFDerivAt`；`MD.Ch02.kineticHamiltonian`；`MD.Ch02.bp_kineticFlow_initial`；`MD.Ch02.bp_kineticFlow_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。 | [EXTRA] |

[EXTRA] [EXTRA] 保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。

### 6. 审计结论

本轮修复：保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_kineticFlow对任意Nc、m、h、z给出Q\_i=q\_i+h(m\_i)⁻¹p\_i与P\_i=p\_i，坐标公式正确。另两条private声明momentumKickDerivative和momentumKick\_hasFDerivAt只论任意C¹力F的kick导数：位置投影不变，动量导数为dp+h DF(q)dq，其类型及前提合理，但与动能Hamilton流识别无关。全部声明均没有H₁=pᵀM⁻¹p/2、H=H₁+H₂、时间ODE或流初值/群律结论，不能核验引句的完整Hamilton流断言。m非零只在context文字中，不是Lean前提；零质量总化可作代数扩展，不能被称为教材M的实际逆。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_kineticFlow`：定义；`MD.Ch02.momentumKickDerivative`：定义；`MD.Ch02.momentumKick_hasFDerivAt`：已证；`MD.Ch02.kineticHamiltonian`：定义；`MD.Ch02.bp_kineticFlow_initial`：已证；`MD.Ch02.bp_kineticFlow_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1352)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-PotentialFlow · definition · 印刷p.84 / PDFp.106

### 2. 原文陈述

> Similarly, the flow map of the system with Hamiltonian $`H_2=U`$ is

$$
\boldsymbol Q=\boldsymbol q,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_potentialFlow {Nc : ℕ} (U : Q Nc → ℝ)
    (h : ℝ) : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookMomentumKick (textbookPotentialForce U) h

def potentialHamiltonian {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  U (textbookPositionProjection Nc z)

theorem bp_potentialFlow_initial {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_potentialFlow U 0 z = z := by
  funext i
  cases i <;> simp [bp_potentialFlow, textbookMomentumKick]

theorem bp_potentialFlow_hamiltonian {Nc : ℕ} (U : Q Nc → ℝ)
    (_hU : ContDiff ℝ 1 U) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_potentialFlow U s z)
      (textbookHamiltonianVectorField (potentialHamiltonian U) (bp_potentialFlow U t z)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_potentialFlow`；`MD.Ch02.potentialHamiltonian`；`MD.Ch02.bp_potentialFlow_initial`；`MD.Ch02.bp_potentialFlow_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。 | [EXTRA] |

[EXTRA] [EXTRA] 原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。

### 6. 审计结论

本轮修复：原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_potentialFlow对任意Nc、任意势U及实h返回kick(-fderiv U)。展开得到Q=q、P\_i=p\_i-h(fderiv ℝ U q)e\_i，符号、坐标次序正确。但是声明没有U可微前提，也没有H₂=U∘位置投影及HasDerivAt/Flow性质；fderiv在不可微点总化，不能无条件等同经典梯度。因此它只定义候选公式，没有完整覆盖原书“system with Hamiltonian H₂=U”的实际流断言。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_potentialFlow`：定义；`MD.Ch02.potentialHamiltonian`：定义；`MD.Ch02.bp_potentialFlow_initial`：已证；`MD.Ch02.bp_potentialFlow_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1399)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SplitEuler · unnumbered_claim · 印刷p.84 / PDFp.106

### 2. 原文陈述

> The composition of these maps simplifies to

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q),
$$


> which is precisely the Symplectic Euler method. Similarly, composing the same two maps in the opposite order gives the adjoint Symplectic Euler method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem splitEuler :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z) := by
  exact MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.splitEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n,m,U,h，两个函数等式均审查：splittingMap drift kick=原辛Euler（先kick后drift），splittingMap kick drift=伴随辛Euler（先drift后kick）。textbookSymplecticEulerEquiv采用置换乘法即函数复合，逆使顺序交换；输出P在原法drift中使用，伴随法在新位置Q施力。Q n和坐标直和空间转换无混淆。结论只是代数函数相等，故不需要U可微或m≠0来保证这个总化恒等式；物理质量/经典梯度解释应限定教材域。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.splitEuler`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1419)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-VerletComposition · Example 2.5 (Verlet is Symplectic) · 印刷p.84–85 / PDFp.106–107

### 2. 原文陈述

> For the Symplectic Euler method $`\mathcal G_h`$ and its adjoint method $`\mathcal G_h^\dagger`$, consider the composition

$$
\mathcal K_h:=\mathcal G_{h/2}^\dagger\circ\mathcal G_{h/2}.
$$



### 3. 原文证明

> Let

$$
\begin{bmatrix}\bar{\boldsymbol q}\\\bar{\boldsymbol p}\end{bmatrix}=\mathcal G_{h/2}\begin{bmatrix}\boldsymbol q\\\boldsymbol p\end{bmatrix},
$$


> i.e.,

$$
\bar{\boldsymbol q}=\boldsymbol q+(h/2)M^{-1}\bar{\boldsymbol p},\qquad\bar{\boldsymbol p}=\boldsymbol p-(h/2)\nabla U(\boldsymbol q).
$$


> and set

$$
\begin{bmatrix}\boldsymbol Q\\\boldsymbol P\end{bmatrix}=\mathcal G_{h/2}^\dagger\begin{bmatrix}\bar{\boldsymbol q}\\\bar{\boldsymbol p}\end{bmatrix},
$$


> i.e.,

$$
\boldsymbol Q=\bar{\boldsymbol q}+(h/2)M^{-1}\bar{\boldsymbol p},\qquad\boldsymbol P=\bar{\boldsymbol p}-(h/2)\nabla U(\boldsymbol Q).
$$


> The composition simplifies to

$$
\bar{\boldsymbol p}=\boldsymbol p-\frac h2\nabla U(\boldsymbol q),\qquad\boldsymbol Q=\boldsymbol q+hM^{-1}\bar{\boldsymbol p},\qquad\boldsymbol P=\bar{\boldsymbol p}-\frac h2\nabla U(\boldsymbol Q).
$$


> This is just the leapfrog/Verlet method in its Hamiltonian form.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletComposition :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z) := by
  exact MolecularDynamics.Chapter02Review.verletComposition_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletComposition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n,m,U,h,z，两个合取均正确：coordinateVerlet=pack(verlet(...)(unpack z))，且等于G†_(h/2)(G_(h/2)z)。前者的位置更新q+h m⁻¹p+(h²/2)m⁻¹F(q)，动量更新p+(h/2)(F(q)+F(Q))与两次半kick一次全drift一致；后者是kick(h/2)∘drift(h/2)∘drift(h/2)∘kick(h/2)，次序没有倒置。任意力函数的代数恒等式不需要正则性；U、零质量的总化扩展同上一条，不在本结论中声称实际Hamilton流或精度。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.verletComposition`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1428)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-VerletSymplectic · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Since we have obtained the method as the composition of two symplectic maps, and the symplectic maps form a group, we know that this method will also be symplectic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletSymplectic :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) := by
  exact MolecularDynamics.Chapter02Review.verletSymplectic_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²；真实完整步映射。 | [EXTRA] |

[EXTRA] U C²；真实完整步映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n、任意固定对角m、任意势U、实h，在U全局C²下，coordinateVerlet的完整kick(h/2)∘drift(h)∘kick(h/2)是C¹且逐点DΦᵀJDΦ=J。不是只验证某个子步。U C²为充分[EXTRA]，各实步长及零维均包括；零质量的总化仍使drift为保辛剪切，不使定理为假。原句借群性说明结论，在本例两个子法确有显式逆；保辛结论不需要一般保辛自映射都全球可逆。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.verletSymplectic`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1438)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SymmetricComposition · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> When we construct a composition of a method with its adjoint method, we see readily that it is symmetric, i.e. self-adjoint, since

$$
\mathcal K_h^{\dagger}:=[\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2}]^{\dagger}=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2}=\mathcal K_h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricComposition {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G := by
  apply MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symmetricComposition` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际可逆步Equiv.Perm；完整伴随半步组合。 | [EXTRA] |

[EXTRA] 实际可逆步Equiv.Perm；完整伴随半步组合。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意类型E及所有实步长的实际可逆映射；伴随为G(-h)的逆，组合为G†(h/2)乘G(h/2)，Perm乘法对应先右后左。结论为整个步族的自伴随等式，半步、次序和负步长均正确。Equiv.Perm为已披露的可逆资格。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symmetricComposition`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1445)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SymmetricEven · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Self-adjoint, or symmetric schemes have unique features; in particular they have even order [164, 227].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricEven :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
  sorry



/-- 修正版，对应原文 MD-2.4.1-SymmetricEven。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symmetricEven_corrected :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.symmetricEven`；`MD.Ch02.symmetricEven_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Q n为有限维实空间；r为正自然数，G、F均实际可逆且联合C∞，F具有群律。逐点局部误差O(|h|^(r+1))且非O(|h|^(r+2))编码有限确切阶；光滑自伴随族的首个非零局部误差次数为奇数，故r偶。群律与可逆性推出F 0=id；正阶误差推出G 0=id。加强条件已标EXTRA，结论合理；原句省略有限确切阶资格须保留提醒。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.symmetricEven`：未证（原书疑误不证）；`MD.Ch02.symmetricEven_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1455)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.2-CompositionSymplectic · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> More generally, if we have any two symplectic numerical methods, say $`\mathcal G_h^1`$ and $`\mathcal G_h^2`$, then the composition

$$
\mathcal G_h:=\mathcal G_{h/2}^1\circ\mathcal G_{h/2}^2
$$


> is another symplectic numerical method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compositionSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h) := by
  apply MolecularDynamics.textbookComposeMaps_isSymplectic <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.compositionSymplectic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、两族全实步长C¹辛映射，h为任意实数。项目定义用标准J及DΦᵀ J DΦ=J；textbookComposeMaps确为G₁(h/2)∘G₂(h/2)。结论包括复合C¹及每点Jacobian保辛，域和复合方向完整。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.compositionSymplectic`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1483)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.2-CompositionOrder · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> The order of this method is typically the minimum of the orders of the two methods involved, but it can be higher, as the example of the Verlet method (constructed by composing symplectic Euler and its adjoint) shows.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compositionOrder :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
  sorry



/-- 修正版，对应原文 MD-2.4.2-CompositionOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem compositionOrder_corrected :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.compositionOrder`；`MD.Ch02.compositionOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]两个方法逼近同一实际流；第一个方法1+L\|h\|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]两个方法逼近同一实际流；第一个方法1+L|h|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开全部本条自定义对象：Chapter02Review.Q n = Fin n → ℝ，r、s为自然数；F是每个实时间的双射族，假设∀h k z, F h(F k z)=F(h+k)z，因此F 0=id。G₁、G₂是任意方法族，不要求辛；这是阶数估计的合理推广。methodLocalOrder G F r 实为 ∀z, ∃C>0, ∃δ>0, ∀h, |h|<δ → ‖G h z−F h z‖≤C|h|^(r+1)，是每个固定初值的局部截断误差下界，C与δ可依赖z，既非确切阶也非全局误差阶。textbookComposeMaps 展开为G₁(h/2)∘G₂(h/2)。实际量词顺序为n,F,G₁,G₂,r,s，然后流律、两条逐点局部阶假设、G₁稳定假设，结论只有同一逐点局部意义的min r s阶下界。[EXTRA]同一实际流合理，误差传播稳定条件合理作为充分条件，但实际稳定性为∀δ>0 ∃L≥0 ∀|h|<δ ∀u v，与原文未言明的全域空间稳定性及每个有限步长区间要求相比明显更强；证明局部阶通常只需某个小δ，不能称该全部额外强度必要。逐点误差常数不能直接用于随h移动的初值F(h/2)z，若采用通常的误差分解证明，还需补足邻域一致性或另给严格论证；本审计不据此断言定理数学上为假。确定的FAIL理由是全部结论未覆盖：至少min阶仅允许、没有断言或展示严格更高阶的实例；原文明确的Verlet由辛Euler及其伴随复合并达到更高阶未表达，typically也未形式化为任何泛型结论。原文statement\_scope覆盖整句，不能以[EXTRA]注释把整句缩成下界定理而仍判完全忠实。无[ERRATUM?]，未发现需要据此修改原书的错误。Ch02.lean 1059–1065与本批签名一致，含直接sorry；证明缺口与上述签名语义FAIL分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.compositionOrder`：未证（原书疑误不证）；`MD.Ch02.compositionOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1493)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.3-HarmonicSplit · definition · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Some systems can be decomposed into a harmonic (quadratic) part $`H_0(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T M^{-1}\boldsymbol p/2+\boldsymbol q^T A\boldsymbol q/2`$ and an anharmonic part $`H_1(\boldsymbol q,\boldsymbol p)=\breve U(\boldsymbol q)`$. Then a splitting method can be formulated based on exact solution of the linear system together with “kicks” representing impulses defined by the anharmonic part. For a simple system consisting of a harmonic oscillator $`H_0(q,p)=p^2/2+\Omega^2q^2/2`$, such a method can be written

$$
\begin{bmatrix}Q\\\hat p\end{bmatrix}=\begin{bmatrix}\cos h\Omega&\frac{1}{\Omega}\sin h\Omega\\-\Omega\sin h\Omega&\cos h\Omega\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix},\qquad P=\hat p-h\breve U'(Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_harmonicAnharmonic (Ω : ℝ) (_hΩ : Ω ≠ 0) (U : ℝ → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_harmonicAnharmonic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。 | [EXTRA] |

[EXTRA] [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。；[EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义仅承担已明确限域的标量简例：Ω非零、U全域可微，任意实h及(q,p)。先按振子矩阵计算Q，再以同一Q计算P=−Ωsin(hΩ)q+cos(hΩ)p−h U′(Q)。不是在旧q施加kick。非零频率和可微资格均已披露；一般M,A分裂作为背景，不误作已形式化。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_harmonicAnharmonic`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1519)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-ImplicitLocal · unnumbered_claim · 印刷p.86 / PDFp.108

### 2. 原文陈述

> An implicit method will typically result in a system of nonlinear equations of the form

$$
g(\boldsymbol z_{n+1})=\boldsymbol\tau_n,\tag{2.25}
$$


> which will need to be solved at each timestep. The right hand side $`\boldsymbol\tau_n`$ is a vector that depends on the previous time-step $`\boldsymbol z_n`$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the space where $`\boldsymbol z`$ is defined, so we have a square nonlinear system. Typically $`g`$ will depend on the stepsize and coefficients of the method and will have the property that for $`h`$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $`\boldsymbol\tau_n`$, that is the mapping $`g`$ has a bounded and smooth inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem implicitLocal : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
  sorry



/-- 修正版，对应原文 MD-2.4.4-ImplicitLocal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem implicitLocal_corrected : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.implicitLocal`；`MD.Ch02.implicitLocal_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补g\_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。；[EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。；[EXTRA] 补g\_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；对每个n、联合C∞的g(h,x)、基点x及零步可逆导数A，存在统一小步长δ；每个小步长有开U,V包含x,g\_h(x)，MapsTo及双向逆等式。inv在V内C∞且函数值有界；可通过缩小局部邻域取得该界，不等于宣称全域逆有界。前提和局部性均明确，未假设所需逆已经存在。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.implicitLocal`：未证（原书疑误不证）；`MD.Ch02.implicitLocal_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1528)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-BackwardEulerSolve · Example 2.6 · 印刷p.86 / PDFp.108

### 2. 原文陈述

> The Backward Euler method,

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_{n+1}),
$$


> is an example of an implicit method. The calculation of a timestep involves solving a system of equations of the form

$$
g(\boldsymbol w)\equiv\boldsymbol w-\boldsymbol z_n-hf(\boldsymbol w)=\boldsymbol0.
$$


> The map $`\mathcal G_t`$ is defined implicitly by the equation

$$
\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\mathcal G_h(\boldsymbol z)).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w

theorem backwardEulerResidual_zero_iff (f : E → E) (h : ℝ) (z w : E) :
    backwardEulerResidual f h z w = 0 ↔ w = z + h • f w := by
  sorry

def backwardEulerMapRelation (f : E → E) (h : ℝ) (G : E → E) : Prop :=
  ∀ z, G z = z + h • f (G z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.backwardEulerResidual`；`MD.Ch02.backwardEulerResidual_zero_iff`；`MD.Ch02.backwardEulerMapRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。 | [EXTRA] |

[EXTRA] [EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；残差w−z−h•f(w)、其零点等价式、以及给定G的逐点隐式关系均吻合；未从定义推断解的存在唯一性。E的减法和实数作用按该表达式所需的实向量空间背景解释；摘录没有完整外围变量声明，本次仅作所给签名的语义核对。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.backwardEulerResidual`：定义；`MD.Ch02.backwardEulerResidual_zero_iff`：未证（缺大型理论）；`MD.Ch02.backwardEulerMapRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1559)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-Newton · definition · 印刷p.86–87 / PDFp.108–109

### 2. 原文陈述

> Solving the system may then proceed, from an initial guess $`\boldsymbol z_{n+1}^{(0)}`$ by use of Newton’s method:

$$
\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),
$$


> where $`J^{(k)}`$ is the Jacobian matrix of the mapping $`g`$ evaluated at $`\boldsymbol z_n^{(k)}`$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form

$$
\boldsymbol b_k=-(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),\quad J^{(k)}\Delta\boldsymbol z_k=\boldsymbol b_k,\quad\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}+\Delta\boldsymbol z_k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)



/-- 修正版，对应原文 MD-2.4.4-Newton。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def newtonPrinted_corrected {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newtonPrinted`；`MD.Ch02.newtonPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；newtonPrinted特意把当前被更新量xNext与残差求值量xPrev分开：xNext−J⁻¹(g(xPrev)−τ)，忠实保留原页n+1/n的混用，未擅改为标准Newton。J为连续线性同构对应可逆矩阵，也容纳所述可逆近似矩阵。原书的线性求解重写与该公式代数等价；未提供该等价的Lean定理，但定义没有错误变更字面公式。原书索引及“可逆映射所以Jacobian非奇异”的理由另须人工处理。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.newtonPrinted`：定义；`MD.Ch02.newtonPrinted_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1571)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-NewtonQuadratic · unnumbered_claim · 印刷p.87 / PDFp.109

### 2. 原文陈述

> Newton’s method (without approximation of the Jacobian matrix) has a remarkable quadratic convergence property, meaning that, when the initial guess is close the solution, the errors $`e_k,e_{k+1}`$ at the $`k`$th and $`k+1`$st iterations satisfy the relation

$$
e_{k+1}\le Ke_k^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newtonQuadratic :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newtonQuadratic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。 | [EXTRA] |

[EXTRA] [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意n、C²映射g、简单零点x及其可逆实际导数A；存在统一C,δ，对每个邻点y提供该点的可逆实际导数B，并给标准newtonStep g 0 y B的一步二次误差界。不是近似Jacobian，且不复用Printed版的错位索引。缩小δ可保证Cδ<1而获得持续迭代；所列EXTRA充分。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.newtonQuadratic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1582)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-FrozenNewton · unnumbered_claim · 印刷p.87 / PDFp.109

### 2. 原文陈述

> For example, if the Jacobian matrix is large and can be written in the form

$$
J(\boldsymbol z)=D+E(\boldsymbol z),
$$


> where $`E`$ is small in norm and $`D`$ is a constant sparse matrix, then, in many cases, the Jacobian matrix may be replaced by the constant matrix $`D`$ and the iteration will still converge.
> This rapid convergence is typically lost when the Jacobian matrix is approximated in some way, and one finds instead

$$
e_{k+1}\le\rho e_k,
$$


> where $`0\lt \rho\lt 1`$, i.e., quadratic convergence is replaced by geometric convergence.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenNewton :
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 < ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.frozenNewton` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。 | [EXTRA] |

[EXTRA] [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1106–1111；依赖展开Q n=Fin n→ℝ及newtonStep g 0 y A=y−A.symm(g y)。A为固定D的可逆线性算子，x为残差零点；先固定δ,ρ，再要求δ>0、0<ρ<1、g为C¹以及整个球内‖I−A⁻¹g′(y)‖≤ρ，最后对每个球内y断言一步误差收缩。fderiv为实际导数，C¹保证其不是不可微时的默认值；comp表示先作用g′再作用A⁻¹。若g′=D+E，界等于‖−D⁻¹E‖≤ρ，明确了small必须相对于D的逆尺度，属于合理[EXTRA]，不是仅把所求误差界重写为前提。凸球上的导数界给出一步界，ρ<1保证球不变，归纳得e\_k≤ρ^k e\_0，涵盖几何收敛。常数矩阵稀疏和维数大是计算成本背景，不是收敛所必需；任意近似Jacobian均收敛并未被断言。依赖frozenNewton\_statement使用0≤ρ，实际声明使用原文0<ρ，按实际声明审计。定理含sorry，签名PASS与证明完成无关。

### 7. 状态与证明位置

incomplete；`MD.Ch02.frozenNewton`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1591)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-Conjugacy · definition · 印刷p.88 / PDFp.110

### 2. 原文陈述

> In general, we say that two maps $`A`$ and $`B`$ are conjugate if there is a homeomorphism $`\chi`$ such that

$$
A=\chi^{-1}\circ B\circ\chi.
$$


> A homeomorphism is a continuous bijection which has a continuous inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_conjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_conjugateMap` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1114 的正文为 χ.symm ∘ B ∘ χ。E 是实赋范空间，其拓扑已由实例给定；χ:E≃ₜE 包含双逆律及正逆连续性。构造函数明确给出原文共轭关系的右端，关系本身可由 ∃χ, A=bp\_conjugateMap χ B 表示；作为此定义的构造型编码可以接受。依赖 ProcessedMethods.lean 的 textbookConjugateMap（合集:1652）正文完全相同，不凭名称推断。无额外动力学假设，无[ERRATUM?]；定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_conjugateMap`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1599)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ConjugateIterates · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> Conjugate maps have the property that their iterates are also conjugate, since

$$
A^n=(\chi^{-1}\circ B\circ\chi)^n=(\chi^{-1}\circ B\circ\chi)\circ(\chi^{-1}\circ B\circ\chi)\circ\cdots\circ(\chi^{-1}\circ B\circ\chi)=\chi^{-1}\circ B^n\circ\chi.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.conjugateIterates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；χ为实际Homeomorph，A、B为同一E上的自映射，假设A=χ⁻¹∘B∘χ；对任意自然数n（包括0），结论为函数等式A^[n]=χ⁻¹∘B^[n]∘χ。抵消方向和复合顺序正确。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.conjugateIterates`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1602)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ConjugateLimits · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> If $`A`$ and $`B`$ are maps of phase space, then the conjugacy implies that they have equivalent stability properties under iteration, since if $`B^n(\boldsymbol z_0)\to\boldsymbol z^*`$, as $`n\to\infty`$, for all initial points $`\boldsymbol z_0`$, then also $`A^n(\boldsymbol z_0)\to\chi^{-1}(\boldsymbol z^*)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conjugateLimits (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar)) := by
  intro z
  apply (MolecularDynamics.textbook_conjugate_iterates_tendsto_iff χ A B hA z (χ.symm zStar)).mpr
  simpa using hB (χ z)



/-- 修正版，对应原文 MD-2.4.5-ConjugateLimits。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem conjugateLimits_corrected (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar)) := by
  intro z
  apply (MolecularDynamics.textbook_conjugate_iterates_tendsto_iff χ A B hA z (χ.symm zStar)).mpr
  simpa using hB (χ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.conjugateLimits`；`MD.Ch02.conjugateLimits_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；展开 textbookConjugateMap 后，签名的具体收敛命题忠实：先固定共同极限zStar，再假设∀z，B^[k] z→zStar，最后∀z，A^[k] z→χ⁻¹zStar。B轨道应从χ z出发；全称hB使这一换初值合法。ProcessedMethods.lean 的 textbook\_conjugate\_iterates\_tendsto\_iff（合集:1672附近）确实给对应初值和对应极限的双向收敛，并利用χ及χ⁻¹的连续性。所有实际用到的项目定义已找到，缺的不是库定义。需要数学判断的原文问题是 statement\_scope 中“equivalent stability properties under iteration”是否只指随后给出的全局共同极限例子，还是还要求一般Lyapunov稳定性、吸引性等性质的双向等价；签名仅明确形式化随后例子的单向结论，没有这些一般稳定性谓词。若来源范围只限该例子可判PASS；若包含一般稳定性断言则缺条款。无[ERRATUM?]；本地与所引收敛定理均无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.conjugateLimits`：已证；`MD.Ch02.conjugateLimits_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1609)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-EulerConjugacy · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerConjugacy :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h := by
  intro n m U h
  funext z
  let F := textbookPotentialForce U
  let q : Q n := fun i => z (Sum.inl i)+h*(m i)⁻¹*
    (z (Sum.inr i)+(h/2)*F (textbookPositionProjection n z) i)
  have hl : textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))=q := by
    funext i
    simp [q,F,textbookPositionProjection,textbookSymplecticEuler,
      textbookMomentumKick,textbookPositionDrift,Function.comp_def]
    ring <;> simp
  have hr : textbookPositionProjection n
      (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))=q := by
    funext i
    simp [q,textbookPositionProjection,textbookPositionDrift,textbookMomentumKick]
  funext i
  rcases i with i | i
  · change textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z)) i =
        textbookPositionProjection n (textbookPositionDrift m h (textbookMomentumKick F (h/2) z)) i
    rw [hl,hr]
  · change textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z) (Sum.inr i)+
      (h/2)*F (textbookPositionProjection n
        (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))) i =
      textbookMomentumKick F (h/2) z (Sum.inr i)+(h/2)*F (textbookPositionProjection n
        (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))) i
    rw [hl,hr,textbookSymplecticEuler_momentum,textbookPositionProjection_momentumKick]
    simp [F,textbookMomentumKick]
    ring

theorem eulerConjugacy_homeomorph (n : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : Q n → ℝ)
    (_hF : Continuous (textbookPotentialForce U)) (h : ℝ) :
    ∃ χ : SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ z, χ z = textbookMomentumKick (textbookPotentialForce U) (-h/2) z) ∧
      (∀ z, χ.symm z = textbookMomentumKick (textbookPotentialForce U) (h/2) z) ∧
      coordinateVerlet m (textbookPotentialForce U) h =
        χ.symm ∘ textbookSymplecticEuler m U h ∘ χ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerConjugacy`；`MD.Ch02.eulerConjugacy_homeomorph` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；同时审查代数恒等式与homeomorph版本。kick记为K、drift为D，Euler=D\_h∘K\_h；K_(h/2)∘Euler∘K_(-h/2)=K_(h/2)∘D\_h∘K_(h/2)=Verlet。后一定理取χ=K_(-h/2)，连续力保证正负kick连续且互逆；正质量已明列。所有n,m,U,h量词及共轭方向正确。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerConjugacy`：已证；`MD.Ch02.eulerConjugacy_homeomorph`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1628)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-Processing · definition · 印刷p.88 / PDFp.110

### 2. 原文陈述

> Let us suppose that we have such a conjugacy between two numerical methods $`\mathcal G_h`$ and $`\tilde{\mathcal G}_h`$, that is

$$
\mathcal G_h=\chi_h^{-1}\circ\tilde{\mathcal G}_h\circ\chi_h,
$$


> defined in such a way that $`\mathcal G_h`$ has order $`r`$ and $`\tilde{\mathcal G}_h`$ has order $`s`$ where $`s\lt r`$. Then, given an initial condition $`\boldsymbol z_0`$, we first modify (“pre-process”) this to $`\tilde{\boldsymbol z}_0=\chi_h(\boldsymbol z_0)`$, then take multiple steps with the method $`\tilde{\mathcal G}_h`$, and finally transform (“post-process”) the end result by $`\chi_h^{-1}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_processedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)

def processingData (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (F : Flow ℝ E) (f : E → E) (r s : ℕ) : Prop :=
  0 < s ∧ s < r ∧
  (∀ t z, HasDerivAt (fun u ↦ F u z) (f (F t z)) t) ∧
  (∀ h, G h = textbookProcessedMethod χ B h) ∧
  methodLocalOrder G (fun h ↦ F h) r ∧ methodLocalOrder B (fun h ↦ F h) s ∧
  ¬ methodLocalOrder B (fun h ↦ F h) (s+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_processedIterate`；`MD.Ch02.processingData` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。 | [EXTRA] |

[EXTRA] [EXTRA] 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；bp\_processedIterate为χ\_h⁻¹(B\_h^[n](../../χ_h z₀))，先预处理再迭代再后处理；n=0也恢复z₀。processingData增加共同实际ODE流F、共轭关系、0<s<r、G的至少r阶及B的确切s阶局部误差资格。属于原文所假设的数据，未凭共轭无条件推出任意提高阶数。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_processedIterate`：定义；`MD.Ch02.processingData`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1674)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ProcessingIterates · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> The resulting approximation will be of order $`r`$ even though all timestepping was performed using a lower order method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem processingIterates (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n := by
  apply MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅预处理/迭代/后处理与G的精确迭代恒等式；同一所引原句的阶数结论及低阶资格由MD-2.4.5-ProcessingOrder完整承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.processingIterates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。 | [EXTRA] |

[EXTRA] [EXTRA] 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；该条已在statement\_scope明确只承担精确迭代恒等式；所有χ,B,G,h,z₀,n及逐h共轭假设均完整。等式左端按同一步长先χ\_h、迭代B\_h、后χ\_h⁻¹，右端迭代G\_h；阶数部分由紧邻第13条单独承接，未在这里误声称已从恒等式推出误差估计。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.processingIterates`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1688)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ProcessingOrder · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> The resulting approximation will be of order $`r`$ even though all timestepping was performed using a lower order method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem processingOrder (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (hG : ∀ h, G h=textbookProcessedMethod χ B h) (γ : ℝ → E) (τ : ℝ) (_hτ : 0 < τ) (r s : ℕ) (_hs : 0 < s) (_hsr : s < r)
    (F : Flow ℝ E) (f : E → E) (_hdata : processingData χ B G F f r s)
    (_hγ : ∀ t, γ t = F t (γ 0))
    (_hB : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError B (τ/ν) γ ν ≤ C*(τ/ν)^s)
    (horder : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError G (τ/ν) γ ν ≤ C*(τ/ν)^r) :
    (∀ h ν, textbookProcessedMaxError χ B h γ ν=oneStepMaxError G h γ ν) ∧
    (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      textbookProcessedMaxError χ B (τ/ν) γ ν ≤ C*(τ/ν)^r) := by
  have heq := MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy χ B G hG
  refine ⟨fun h ν => heq h γ ν, ?_⟩
  simpa only [heq] using horder
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.processingOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r自然数有限时间窗误差界；χh为实际Homeomorph。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。 | [EXTRA] |

[EXTRA] r自然数有限时间窗误差界；χh为实际Homeomorph。；[EXTRA] 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；正时间窗τ、0<s<r、实际共轭与共同ODE流及轨迹资格均有列出。horder假定G的全网格全局r阶，这是原文“G有r阶”的资格，结论通过精确迭代恒等式转移给后处理算法；不是从B的s阶单独推出r阶。额外\_hB和processingData提供低阶背景但不用于等式转移，逻辑上可冗余。最大误差包括0至ν所有节点；两个结论与该范围一致。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.processingOrder`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1697)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-EulerEffectiveOrder · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> One sometimes refers to the “effective order” of a numerical method as the order attainable via processing, thus the effective order of the Symplectic Euler method would be two.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerEffectiveOrder : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) τ,
    positiveMass m → ContDiff ℝ 4 U → 0 < τ →
    (∀ t ∈ Icc 0 τ, HasDerivWithinAt γ
      (textbookHamiltonianVectorField (fun z => (∑ i, z (Sum.inr i)^2/m i)/2+
        U (z ∘ Sum.inl)) (γ t)) (Icc 0 τ) t) → ContinuousOn γ (Icc 0 τ) →
    ∃ χ : ℝ → SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ h, textbookProcessedMethod χ (textbookSymplecticEuler m U) h =
        coordinateVerlet m (textbookPotentialForce U) h) ∧
      (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        textbookProcessedMaxError χ (textbookSymplecticEuler m U) (τ/ν) γ ν ≤ C*(τ/ν)^2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerEffectiveOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。 | [EXTRA] |

[EXTRA] [EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开全部项目定义：Q n=Fin n→ℝ；SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ，以inl为q、inr为p；positiveMass m=∀i,0<m\_i；J=[[0,I],[−I,0]]；Hamilton场=J∇H。因此H=Σp\_i²/(2m\_i)+U(q)产生q′_i=p\_i/m\_i、p′_i=−∂_i U，与Euler及Verlet的质量和力符号一致。Euler=D\_h K\_h，Verlet=K_{h/2} D\_h K_{h/2}。processed一步法是χ\_h⁻¹ Euler\_h χ\_h，可取χ\_h=K_{−h/2}；C⁴势能确保力连续，正逆kick均连续，故存在的χ确可为Homeomorph。量词先固定n/m/U/真实轨迹γ及正时间τ，满足全部轨迹假设后再存在处理器与误差常数。processed最大误差覆盖从γ(0)出发的全部0≤k≤ν、物理时间kτ/ν；结论为至少二阶的整个网格误差界，不循环假设二阶收敛。[EXTRA]正固定质量排除机械奇异质量，C⁴为足够而非最弱光滑性，τ>0和真实轨迹给有限正时间窗；ContinuousOn提供紧轨迹像（在此导数条件下可冗余）；均合理。原文“order attainable via processing”在此表示可达到二阶，不声称任何特殊系统的最高可能阶恰为二，无需阶上界。无[ERRATUM?]。签名语义PASS独立于证明完成度：Ch02.lean:1206附近的该证明有sorry，本次未证明、编译或消除这一义务；依赖正文检索未发现sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerEffectiveOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1714)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

