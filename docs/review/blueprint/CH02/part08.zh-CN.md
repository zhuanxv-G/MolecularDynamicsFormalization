[上一部分](part07.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part09.zh-CN.md)

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

## 1. MD-2.5.1-RK · definition · 印刷p.89 / PDFp.111

### 2. 原文陈述

> The family of Runge-Kutta methods for solving $`\dot{\boldsymbol z}=f(\boldsymbol z)`$ is defined by

$$
\boldsymbol Z=\boldsymbol z+h\sum_{i=1}^s b_i\boldsymbol F_i,
$$


> where the vectors $`\boldsymbol F_i`$, $`i=1,\ldots,s`$, are computed by solving the system

$$
\boldsymbol F_i=f\left(\boldsymbol z+h\sum_{j=1}^s a_{ij}\boldsymbol F_j\right),\qquad i=1,\ldots,s.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_rungeKuttaRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q n在deps:2816明确为Fin n→ℝ，有限维实向量空间。Ch02:1206–1209的∀i阶段方程及输出方程与deps:2900–2902和原文两式逐项相同；Fin s只是索引重编号。关系以给定F为参数，不断言隐式系统存在或唯一；无额外假设或勘误。此条为定义，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_rungeKuttaRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1728)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RK4 · definition · 印刷p.89 / PDFp.111

### 2. 原文陈述

> An example of a popular 4th order explicit method is the choice of matrix $`A`$ with coefficients $`a_{ij}\equiv 0`$ except $`a_{21}=1/2`$, $`a_{32}=1/2`$ and $`a_{43}=1`$, and $`b_1=1/6`$, $`b_2=1/3`$, $`b_3=1/3`$, $`b_4=1/6`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)

theorem bp_rk4_eq_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) :
    bp_rk4 f h z = MolecularDynamics.Chapter02Review.rk4 f h z := rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 四阶段公式定义；四阶结论由MD-2.5.1-RK4Order跨条共同覆盖，bp\_rk4\_eq\_rk4给出同一算法映射。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_rk4`；`MD.Ch02.bp_rk4_eq_rk4` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp\_rk4\_eq\_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。 | [EXTRA] |

[EXTRA] [EXTRA] 算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp\_rk4\_eq\_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。

### 6. 审计结论

本轮修复：算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp\_rk4\_eq\_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；四阶段定义正确展开a21=a32=1/2,a43=1及权重1/6,1/3,1/3,1/6，对任意有限维实向量场f、h,z有效。但本条完整当前Lean只有算法定义，未包含原句的四阶结论；context\_notation称“四阶陈述单列”，本任务给出的同一source\_id全部声明中没有该条或可核对的映射。因完整结论覆盖缺失判FAIL，而非算法公式错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_rk4`：定义；`MD.Ch02.bp_rk4_eq_rk4`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1734)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RK4Order · unnumbered_claim · 印刷p.89 / PDFp.111

### 2. 原文陈述

> An example of a popular 4th order explicit method

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rk4Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ, compactTrajectory f γ τ → globalOrder (rk4 f) γ τ 4 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.rk4Order` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]compactTrajectory实际C⁶向量场与紧窗实际轨迹；高阶资格强于原文简写。 | [EXTRA] |

[EXTRA] [EXTRA]compactTrajectory实际C⁶向量场与紧窗实际轨迹；高阶资格强于原文简写。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开deps:2816,2824–2826,2941–2945：compactTrajectory包含τ>0、f全局C⁶、γ在[0,τ]内满足HasDerivWithinAt γ (f(γ t))、γ在该窗连续；紧区间连续像为紧，未把误差作为前提。rk4为与bp\_rk4相同的实际四阶段映射。globalOrder为∃C>0 ∃ν₀>0 ∀ν≥ν₀，整个网格0,…,ν的最大误差≤C(τ/ν)^4；oneStepIterate=(G h)^[k](../../γ 0)，oneStepMaxError是实际节点范数误差的有限最大值（deps:1443–1463）。量词表达固定轨迹、固定正时间窗的全局四阶上界。[EXTRA] C⁶强于必要正则性，作为充分资格合理；不要求原文未提供的任意隐式求解。无勘误。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.rk4Order`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1747)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-ExplicitRK · unnumbered_claim · 印刷p.89 / PDFp.111

### 2. 原文陈述

> This method is not symplectic, and it is in fact impossible to find symplectic explicit methods within the Runge-Kutta family.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem explicitRK :
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ∞ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.explicitRK` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] [EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限阶段数s、严格下三角A及一致性∑b=1，存在一自由度的光滑Hamilton量、正h及满足真实RK阶段方程的全域G使G非辛。量词正确表达不能对所有Hamilton系统保辛，允许某些特殊系统恰好保辛。∑b=1是必要的非平凡一致性资格，原extra\_assumptions为空，需补记。原书“不能找到”的措辞也应按一致RK方法理解。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.explicitRK`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1754)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RKSymplectic · unnumbered_claim · 印刷p.89–90 / PDFp.111–112

### 2. 原文陈述

> Let us emphasize that, while a typical RK method is not symplectic, some implicit Runge-Kutta methods are symplectic. The precise condition that must be satisfied [325] is

$$
b_i a_{ij}+b_j a_{ji}=b_i b_j,\qquad i=1,\ldots,s,\quad j=1,\ldots,s.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rkSymplectic : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) ↔
    (∀ n (H : SymplecticCoordinates n → ℝ) (h : ℝ)
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G) := by
  sorry



/-- 修正版，对应原文 MD-2.5.1-RKSymplectic。改动：保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。 -/
```

独立修正版：

```lean
theorem rkSymplectic_corrected : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) →
    (∀ n (H : SymplecticCoordinates n → ℝ) (h : ℝ)
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.rkSymplectic`；`MD.Ch02.rkSymplectic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H C²；真实阶段函数与完整步G C¹且确实满足RK关系。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。 | [EXTRA] |

[EXTRA] H C²；真实阶段函数与完整步G C¹且确实满足RK关系。；[ERRATUM?] 保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开依赖：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，textbookJ=[[0,I],[-I,0]]；Hamilton向量场为J乘以实际fderiv的坐标梯度；textbookJacobian为实际fderiv矩阵，IsTextbookSymplecticMap为C¹且每点D Gᵀ J D G=J（deps:33–42,138–139,238–241,272–275,1921–1926）。 Ch02:1239–1248确实断言系数条件与所有维度、Hamilton量、实h及C¹实际求解映射/阶段的辛性等价；正则性[EXTRA]适于充分性，却不能修复对可约方法的必要性。正式deps:3230–3240只给充分性，不能替代Blueprint中的更强iff。无条件逆向为假，原条NECESSITY\_QUALIFICATION疑误已由展开语义下的明确反例确认。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.rkSymplectic`：未证（原书疑误不证）；`MD.Ch02.rkSymplectic_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1768)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussFamily · Example 2.7 (family) · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The Gauss-Legendre family of Runge-Kutta (GLRK) methods correspond to approximating the vector field at the Gauss points, i.e. the zeros of the orthogonal polynomials that arise in Gaussian quadrature. As these points are symmetrically distributed the GLRK schemes are symmetric, hence have even order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussFamily :
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ (∃ r : ℕ, 0 < r ∧ Even r ∧ methodLocalOrder G F r) := by
  sorry



/-- 修正版，对应原文 MD-2.5.1-GaussFamily。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem gaussFamily_corrected :
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ (∃ r : ℕ, 0 < r ∧ Even r ∧ methodLocalOrder G F r) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.gaussFamily`；`MD.Ch02.gaussFamily_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Legendre根节点、Lagrange积分系数；s>0，节点单射，C∞向量场和实际光滑G；真实唯一阶段及真实流资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际Legendre根节点、Lagrange积分系数；s>0，节点单射，C∞向量场和实际光滑G；真实唯一阶段及真实流资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Q=Fin n→ℝ、rungeKuttaRelation的实际阶段/输出方程（deps:2816,2900–2902），legendreValue按P₀=1、P₁=x及标准三项递推给出P\_s（3241–3244）；lagrangeBasis为∏_{k≠j}(t−c\_k)/(c\_j−c\_k)（3245–3246）。s>0、节点单射和P\_s(2c\_i−1)=0准确给出移位Gauss节点，积分系数准确对应配点法。methodLocalOrder（deps:3183–3186）展开为∀z ∃C>0 ∃δ>0 ∀|h|<δ，‖G h z−F h z‖≤C|h|^(r+1)，常数可依赖z；它是至少r阶的局部误差上界，不是确切阶。 Ch02:1253–1264保留反向步对称性，但∃正偶r且上述上界不表达实际阶的偶性；任意至少三阶方法也满足r=2。另[EXTRA]所有实h、所有z的唯一阶段/输出及全时间真实流远强于通常局部适用条件，实质遗漏大量光滑标准GLRK应用，不能仅称必要资格。无显式ERRATUM标记；这两项是形式化范围和结论问题。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.gaussFamily`：未证（原书疑误不证）；`MD.Ch02.gaussFamily_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1802)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-Midpoint · definition · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The simplest such method is the implicit midpoint rule:

$$
\boldsymbol Z=\boldsymbol z+h\boldsymbol F_1,\qquad\boldsymbol F_1=f\left(\boldsymbol z+\frac h2\boldsymbol F_1\right),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_midpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop :=
  w = z + h • f ((1/2 : ℝ) • (z+w))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_midpointRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q=Fin n→ℝ（deps:2816），Ch02:1267–1268与正式midpointRelation（2910–2911）相同。原关系消去阶段后为w=z+h f((z+w)/2)；反向取F₁=f((z+w)/2)，利用w=z+hF₁得到z+(h/2)F₁=(z+w)/2。包括h=0，未除以h或断言任意系统可解。对象、量词和结论均忠实，无EXTRA或勘误；定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_midpointRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1836)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-MidpointProperties · unnumbered_claim · 印刷p.90 / PDFp.112

### 2. 原文陈述

> which has order 2.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem midpointProperties
    (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (U : Set (SymplecticCoordinates n)) (δ : ℝ) (_hδ : 0 < δ)
    (_hU : IsOpen U) (_hH : ContDiff ℝ 4 H)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (textbookHamiltonianVectorField H (F t z)) t) :
    (∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    (∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3) := by
  sorry

theorem midpointProperties_generalODE (n : ℕ) (f : Q n → Q n)
    (G F : ℝ → Q n → Q n) (U : Set (Q n)) (δ : ℝ)
    (_hδ : 0 < δ) (_hU : IsOpen U) (_hf : ContDiff ℝ 3 f)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U, G h z = z+h • f ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (f (F t z)) t) :
    ∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.midpointProperties`；`MD.Ch02.midpointProperties_generalODE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。 | [EXTRA] |

[EXTRA] [EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。；[EXTRA] 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两条定理均已核对：Hamilton版H C⁴、实际联合C³分支G、开U、小步长区间、G0=id、真实隐式中点方程和真实解族F；结论是该域每点Jacobian保辛及每个初值局部O(h³)。一般ODE版使用C³场与分支，给同样二阶局部界。不要求F在所有初值联合光滑，逐点ODE及场光滑已足够。保辛为局部域上的性质，并未错误要求G在U外C¹。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.midpointProperties`：未证（缺大型理论）；`MD.Ch02.midpointProperties_generalODE`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1842)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussTwo · definition · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The 4th order method ($`s=2`$) has coefficients

$$
b_1=b_2=\frac12,\qquad A=(a_{ij})=\begin{bmatrix}\frac14&\frac14-\frac{\sqrt3}6\\\frac14+\frac{\sqrt3}6&\frac14\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def gaussTwoData : Matrix (Fin 2) (Fin 2) ℝ × (Fin 2 → ℝ) :=
  (gaussTwoCoefficients, fun _ => 1/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.gaussTwoData` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch02.lean 附件位于 /workspace/Ch02.lean，声明在1281–1282行。展开 Ch02\_deps.txt:2911–2912 的 gaussTwoCoefficients：Fin 2 按0、1索引，A₀₀=A₁₁=1/4，A₀₁=1/4−Real.sqrt 3/6，A₁₀=1/4+Real.sqrt 3/6；第二分量为两个实数权重均等于1/2。矩阵行是阶段索引i，列是求和阶段索引j，与 rungeKuttaRelation:2900–2903一致。完整A和b忠实于印刷p.90/PDFp.112展示公式；四阶结论由本批独立GaussTwoOrder条目承担。无额外假设、无ERRATUM标记或系数勘误。此def自身没有sorry；数据正确与四阶证明是否完成分开判断。

### 7. 状态与证明位置

self-contained；`MD.Ch02.gaussTwoData`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1872)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussTwoOrder · unnumbered_claim · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The 4th order method ($`s=2`$) has coefficients

$$
b_1=b_2=\frac12,\qquad A=(a_{ij})=\begin{bmatrix}\frac14&\frac14-\frac{\sqrt3}{6}\\\frac14+\frac{\sqrt3}{6}&\frac14\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussTwoOrder (n : ℕ) (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) (τ : ℝ) (_htrajectory : compactTrajectory f γ τ)
    (U : Set (Q n)) (δ : ℝ) (_hδ : 0 < δ) (_hU : IsOpen U)
    (_hcover : γ '' Icc 0 τ ⊆ U)
    (_hG : ContDiffOn ℝ 6 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (stages : ℝ → Q n → Fin 2 → Q n)
    (_hregular : ∀ i, ContDiffOn ℝ 6 (fun x : ℝ × Q n ↦ stages x.1 x.2 i)
      (Ioo (-δ) δ ×ˢ U))
    (_hstagezero : ∀ z ∈ U, ∀ i, stages 0 z i = f z)
    (_hstage : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) (stages h z)) :
    globalOrder G γ τ 4 ∧
    (∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀, ∀ k ≤ ν,
      oneStepIterate G (τ/ν) (γ 0) k ∈ U) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.gaussTwoOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。 | [EXTRA] |

[EXTRA] [EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。；[EXTRA] 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两阶段A的四项与b=(1/2,1/2)正确；真实阶段及零步阶段值均明确。compactTrajectory提供τ>0、C⁶场、真实解及闭时间段连续性；开U覆盖紧轨迹，G与stages在小步长×U内C⁶、G0=id。结论为全网格O((τ/ν)^4)及充分细网格迭代留U，能由一致性、局部误差及紧轨迹邻域稳定性获得；没有把四阶界放进前提。globalOrder仅表示至少四阶，不是每个特定ODE恰四阶。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.gaussTwoOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1878)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

