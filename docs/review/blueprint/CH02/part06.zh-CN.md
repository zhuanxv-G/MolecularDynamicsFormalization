[上一部分](part05.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

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

