[上一部分](part05.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

## 1. MD-4.3.4-ProjectedEulerRelation · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> The demonstration that the method is symplectic can be seen as a consequence of the following lemma.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g



/-- 修正版，对应原文 MD-4.3.4-ProjectedEulerRelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def projectedEulerRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectedEulerRelation`；`MD.Ch04.projectedEulerRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。展开与逐字版相同，唯一变化为+hF，但所绑定原句是方法辛性的论断；此定义只有五条更新约束，没有任何拉回二形式不变结论，也没有F来自势的限制。[EXTRA]符号修正版可以作为另一个算法定义，但不能充当所引辛性原句的形式化。

### 7. 状态与证明位置

self-contained；`MD.Ch04.projectedEulerRelation`：定义；`MD.Ch04.projectedEulerRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1562)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-Lemma41 · Lemma 4.1 · 印刷p.159–160 / PDFp.181–182

### 2. 原文陈述

> Lemma 4.1 Let $`\gamma:\mathbb R^{N_c}\to\mathbb R`$ be $`C^2`$. Let $`q,p\in\mathbb R^{N_c}`$ be constrained to the manifold defined by

$$
\gamma(q)=0,\quad p\cdot\nabla\gamma(q)=0,
$$


> and suppose $`P,\mu`$ satisfy $`P=p-\mu\nabla\gamma(q)`$. Then

$$
\sum_{j=1}^{N_c}dq_j\wedge dP_j=\sum_{j=1}^{N_c}dq_j\wedge dp_j.
$$



### 3. 原文证明

> Clearly the result follows provided

$$
\sum_{j=1}^{N_c}dq_j\wedge d[\mu\nabla\gamma(q)]_j=0,
$$


> where $`[\ldots]_j`$ indicates the jth component of the term in brackets. We have

$$
\sum_{j=1}^{N_c}dq_j\wedge d[\mu\nabla\gamma(q)]_j=\sum_{j=1}^{N_c}dq_j\wedge\left(\frac{\partial\gamma}{\partial q_j}d\mu+\mu\sum_{i=1}^{N_c}\gamma''_{ij}dq_j\right).
$$


> Then we note

$$
\sum_{j=1}^{N_c}dq_j\wedge\frac{\partial\gamma}{\partial q_j}d\mu=\sum_{j=1}^{N_c}\frac{\partial\gamma}{\partial q_j}dq_j\wedge d\mu=0,
$$


> since $`\gamma(q)\equiv0`$ implies $`d\gamma(q)=\sum_{j=1}^{N_c}\frac{\partial\gamma}{\partial q_j}dq_j\equiv0`$. Moreover

$$
\sum_{j=1}^{N_c}dq_j\wedge\sum_{i=1}^{N_c}\gamma''_{ij}dq_j=0,
$$


> since the Hessian matrix $`\gamma''`$ is symmetric.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lemma41 {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0 ∧
      p y ⬝ᵥ textbookConstraintGradient γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.lemma_4_1 <;> assumption



/-- 修正版，对应原文 MD-4.3.4-Lemma41。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem lemma41_corrected {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0 ∧
      p y ⬝ᵥ textbookConstraintGradient γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.lemma_4_1 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.lemma41`；`MD.Ch04.lemma41_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；任意Nc及实赋范空间E，γ全局C²，q,p,μ在x可微；hchart在x邻域同时保留γ(q)=0和p·∇γ(q)=0。ConstrainedMomentum定义P=p−μ∇γ(q)，CotangentChart把位置与动量合并；J=[0 I;−I 0]所得双线性形式即Σdq\_j∧dp\_j。结论对任意u,v比较两个参数图的完整拉回二形式，符合原引理。局部图及可微性是明确资格，不把点约束误当微分约束。签名匹配，但原书证明两处dq\_j链式指标疑误须保留并人工确认。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.lemma41`：已证；`MD.Ch04.lemma41_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1581)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-MultiMomentumPullback · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Observe that $`g'(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^l\mu_{n+1,k}\nabla g_k(q_{n+1})`$. Thus we may apply Lemma 4.1 with $`\gamma`$ replaced by each $`g_k`$ to demonstrate

$$
\sum_jdq_{n+1,j}\wedge dp_{n+1,j}=\sum_jdq_{n+1,j}\wedge d\bar p_{n+1,j}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem multiMomentumPullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q : E → Fin Nc → ℝ) (x : E) (hq : DifferentiableAt ℝ q x)
    (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hconstraint : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (p : E → Fin Nc → ℝ) (hp : DifferentiableAt ℝ p x) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookMultiConstrainedMomentum_preserves_pullback <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.multiMomentumPullback` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。 | [EXTRA] |

[EXTRA] 有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。multiConstrainedMomentum=p−Σ_{j∈s}μ\_j∇γ\_j(q)，chart与SymplecticForm如Lemma41展开，结论正是新位置的Σdq∧dp等于Σdq∧d pbar。有限指标集推广Fin l合理，s中每条约束C²、乘子与q,p在x可微，且邻域位置约束确保dγ\_j(q)=0。无需假设pbar满足动量隐藏约束：该拉回恒等式对任意pbar成立，属于有效加强。[EXTRA]合理，不声称分支存在。调用依赖中的同名拉回定理。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.multiMomentumPullback`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1616)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-ProjectedEulerPullback · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Using similar argumentation based on the properties of the wedge product, we next show

$$
\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j};
$$


> and, finally, invoking Lemma 4.1 again,

$$
\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge dp_{n,j}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem projectedEulerPullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x)
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hold : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q (textbookProjectedEulerPreMomentum s γ lam U h a q p) y) = 0)
    (u v : E) :
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookProjectedEulerChart_preserves_pullback <;> assumption

theorem projectedEulerPullback_intermediate {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x)
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hold : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q (textbookProjectedEulerPreMomentum s γ lam U h a q p) y) = 0)
    (u v : E) :
    let Pbar := textbookProjectedEulerPreMomentum s γ lam U h a q p
    let Q := textbookProjectedEulerPosition m h q Pbar
    (textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart Q Pbar) x u) (fderiv ℝ (textbookCotangentChart Q Pbar) x v) = textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q Pbar) x u) (fderiv ℝ (textbookCotangentChart q Pbar) x v)) ∧
    (textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q Pbar) x u) (fderiv ℝ (textbookCotangentChart q Pbar) x v) = textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u) (fderiv ℝ (textbookCotangentChart q p) x v)) ∧
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectedEulerPullback`；`MD.Ch04.projectedEulerPullback_intermediate` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。 | [EXTRA] |

[EXTRA] 真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。；[EXTRA] 原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限指标集s、位置维数Nc、实赋范参数空间E、实系数h,a和对角质量m；q,p及各乘子在x可微，U和约束C²，旧/新位置约束在x邻域成立。PreMomentum=p+a(−∇U)−hΣλ\_j∇γ\_j，Position=q+hM⁻¹Pbar，Chart再减Σμ\_j∇γ\_j(Q)。intermediate的第一合取项准确比较(Q,Pbar)与(q,Pbar)，第二项比较(q,Pbar)与(q,p)，第三项及主声明是总拉回相等，均对任意u,v成立。任意a覆盖印刷力项的相应选择；逆质量为常数对角算子，代数二形式恒等式不需正质量。未声称乘子分支存在或自动满足隐藏动量约束。intermediate虽为sorry，本任务只审签名，不因此判FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch04.projectedEulerPullback`：已证；`MD.Ch04.projectedEulerPullback_intermediate`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1634)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentMultiplier · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> $`0=g'(q_{n+1})M^{-1}p_{n+1}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def cotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))

theorem cotangentMultiplier_hidden {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : MolecularDynamics.Chapter04Review.Q n)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    let μ := textbookCotangentMultiplier m g q p
    (textbookConstraintGram m g q) *ᵥ μ=
      textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ p) ∧
    textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (p-(textbookConstraintJacobian g q)ᵀ *ᵥ μ))=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentMultiplier`；`MD.Ch04.cotangentMultiplier_hidden` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。 | [EXTRA] |

[EXTRA] [EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。；[EXTRA] Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；令G为Mc×Nc约束Jacobian，D=diag(m\_i⁻¹)，A=GDGᵀ。对任意q、预投影p，在det A≠0资格下定义μ=A⁻¹GDp；hidden的第一合取项是Aμ=GDp，第二项是GD(p−Gᵀμ)=0，精确覆盖(4.23–24)在此资格下的构造。未把值函数冒充隐藏约束证明结论；未添加位置约束或质量正性，它们对此代数恒等式不是必要条件。任意γ用fderiv构造G，总化后恒等式仍成立；若解释为经典Jacobian须处于可微情形。hidden含sorry不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch04.cotangentMultiplier`：定义；`MD.Ch04.cotangentMultiplier_hidden`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1679)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentProjection · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> $`p_{n+1}=\bar p_{n+1}-g'(q_{n+1})^T\mu_{n+1}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p P : Fin Nc → ℝ) (μ : Fin Mc → ℝ) : Prop :=
  P=p-(textbookConstraintJacobian γ q)ᵀ *ᵥ μ

noncomputable def cotangentProjection_gram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentProjection`；`MD.Ch04.cotangentProjection_gram` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。 | [EXTRA] |

[EXTRA] [EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。；[EXTRA] 主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主声明在任意Nc,Mc、m、约束族γ、新位置q、预动量p、投影动量P及任意μ下定义Prop：P=p−G(q)ᵀμ，忠实对应(4.23)；m在主等式中未使用，无隐含求解。_gram是独立的特定构造，增加det(GDGᵀ)≠0并代入实际Gram逆乘子。隐藏约束由上一条承担，主等式本身未误称任意μ均投影到余切空间。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cotangentProjection`：定义；`MD.Ch04.cotangentProjection_gram`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1699)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentHidden · unnumbered_claim · 印刷p.159 / PDFp.181

### 2. 原文陈述

> $`0=g'(q_{n+1})M^{-1}p_{n+1}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentHidden {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0 := by
  apply MolecularDynamics.textbookCotangentProjection_hiddenConstraint_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentHidden` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。 | [EXTRA] |

[EXTRA] [EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。展开输出为P=pbar−Gᵀ(GDGᵀ)⁻¹GDpbar，结论GP\_mass=GDP=0逐分量正是(4.24)。hm要求所有质量严格正，hind要求实际fderiv梯度行线性独立；依赖ConstrainedGram.lean给出Gram.det≠0，再调用CotangentProjection.lean隐藏约束定理。[EXTRA]是确保Gram可逆的充分且合理资格，未假设目标结论。q,pbar任意；此条只处理隐藏动量约束，原(4.24)本身也不包含位置约束，不应额外要求γ(q)=0。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentHidden`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1710)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentRegularity · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Thus we may apply Lemma 4.1 with $`\gamma`$ replaced by each $`g_k`$ to demonstrate $`\sum_{j=1}^{N_c}dq_{n+1,j}\wedge dp_{n+1,j}=\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}`$.

### 3. 原文证明

原书无独立完整证明。
> Observe that $`g^{\prime}(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^{l}\mu_{n+1,k}\nabla g_k(q_{n+1})`$. Thus we may apply Lemma 4.1 with $`\gamma`$ replaced by each $`g_k`$.
原书以有限梯度和及 Lemma 4.1 给出本等式的简短论证；未另列独立定理或完整重复证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentRegularity {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentProjection m γ (q y) (p y)) x := by
  apply MolecularDynamics.contDiffAt_textbookCotangentProjection <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | Gram专项投影C¹正则性辅助；原句位置约束下完整二形式等式由MD-4.3.4-CotangentPullback承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentRegularity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际逆Gram投影的一阶正则性资格：C²约束、C¹参数图、Gram非奇异；非另印定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。 | [EXTRA] |

[EXTRA] [EXTRA]实际逆Gram投影的一阶正则性资格：C²约束、C¹参数图、Gram非奇异；非另印定理。；[EXTRA] 本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc,Mc、固定实对角逆质量、C²约束族、在x为C¹的q,p和点上非奇异Gram，结论仅为实际Gram投影复合图在x的C¹正则性。梯度为C¹，Gram及其逆在非奇异点局部C¹，故陈述合理；无需位置约束。该声明不含任何二形式等式，也不是原页独立定理；本条statement\_scope及[EXTRA]已明确将其定位为辅助，完整原句由第9条承担，按此已披露范围PASS，不将C¹结论算作原句等式的证明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentRegularity`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1721)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentPullback · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Thus we may apply Lemma 4.1 with $`\gamma`$ replaced by each $`g_k`$ to demonstrate $`\sum_{j=1}^{N_c}dq_{n+1,j}\wedge dp_{n+1,j}=\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}`$.

### 3. 原文证明

原书无独立完整证明。
> Observe that $`g^{\prime}(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^{l}\mu_{n+1,k}\nabla g_k(q_{n+1})`$. Thus we may apply Lemma 4.1 with $`\gamma`$ replaced by each $`g_k`$.
原书以有限梯度和及 Lemma 4.1 给出本等式的简短论证；未另列独立定理或完整重复证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentPullback {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x u)
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookCotangentProjection_preserves_pullback <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentPullback` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际逆Gram投影、C²约束、C¹参数图、Gram非奇异及邻域位置约束；可微乘子由正式库导出，不作新假设。 | [EXTRA] |

[EXTRA] 实际逆Gram投影、C²约束、C¹参数图、Gram非奇异及邻域位置约束；可微乘子由正式库导出，不作新假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc,Mc、C²约束族γ、C¹局部q,p、点上非奇异Gram、每个位置约束γ\_j(q(y))在x邻域为零，对任意u,v比较(q,Gram投影(q,p))与(q,p)的完整拉回辛二形式。邻域约束足以导出dγ\_j(q)=0；可微乘子由非奇异Gram和C²/C¹资格导出，不另假设。p在此表示原页Pbar，投影值为p_{n+1}；J块矩阵和坐标图定义给出正确Σdq∧dp符号及全部坐标求和。属于已披露的Gram专项实现；未证明一般任意μ版本，也未声称求解分支存在。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentPullback`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1730)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-GramProjectedEuler · unnumbered_claim · 印刷p.159 / PDFp.181

### 2. 原文陈述

> The demonstration that the method is symplectic can be seen as a consequence of the following lemma.

### 3. 原文证明

原书无独立完整证明。
> On printed p.160 (PDF p.182), Lemma 4.1 first gives $`\sum_{j=1}^{N_c}dq_{n+1,j}\wedge dp_{n+1,j}=\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}`$. The wedge-product argument next gives $`\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j}`$; invoking Lemma 4.1 again gives $`\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge dp_{n,j}`$.
所引句位于印刷第159页；方法的三段二形式论证在印刷第160页，未另列独立完整定理证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gramProjectedEuler {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption

theorem gramProjectedEuler_general {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption



/-- 修正版，对应原文 MD-4.3.4-GramProjectedEuler。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem gramProjectedEuler_corrected {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.gramProjectedEuler`；`MD.Ch04.gramProjectedEuler_general`；`MD.Ch04.gramProjectedEuler_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将(4.20–24)实际Gram末投影同时证明隐藏约束与完整拉回形式不变；给定C¹位置投影分支，非解的存在理论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]将(4.20–24)实际Gram末投影同时证明隐藏约束与完整拉回形式不变；给定C¹位置投影分支，非解的存在理论。；[EXTRA] 教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；签名逐项核对：Nc、Mc任意有限维，q、p及各λ在x为C¹，U和各γ为C²；旧、新位置约束在x邻域成立；新位置Gram行列式非零。结论第一合取是实际Gram末投影满足 g′M⁻¹pnew=0，第二合取对任意u、v给整个chart的辛形式拉回等式。Gram逆定义实现μ，未假设辛性。m未要求正或非零，但质量逆按实数总逆定义，M⁻¹仍对称，Gram非退化足够支持该几何结论；不能由此声称物理正质量或全局辛微分同胚。旧p不需隐藏约束是有效加强。general允许任意a且未冒充原印。就字面辛性声明可通过；整体因教材力号疑误分流人工。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.gramProjectedEuler`：已证；`MD.Ch04.gramProjectedEuler_general`：已证；`MD.Ch04.gramProjectedEuler_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1748)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionPrinted · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> In the presence of the constraint, we consider the scheme

$$
q_{n+1}-2q_n+q_{n-1}=h^2M^{-1}F(q_n)-h^2g'(q_n)^T\lambda_n,\tag{4.25}
$$



$$
g(q_{n+1})=0.\tag{4.26}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shakePositionPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b)-h^2 • ((textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。签名按参数a=qₙ₋₁、b=qₙ、c=qₙ₊₁、rho=λₙ，完整记录(4.25)和(4.26)，没有额外假设或存在性结论，定义无sorry。[ERRATUM?]成立：从(4.27)–(4.29)消元得h²M⁻¹(F−Gᵀλ)，原印刷反力缺M⁻¹；非标量质量下两种法向空间一般不同。本PASS仅指忠实保留原印刷。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakePositionPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1825)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionMass · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shakePositionRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.5-SHAKEPositionMass。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def shakePositionRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionRelation`；`MD.Ch04.shakePositionRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]质量一致位置式h²M⁻¹(F−Gᵀλ)，非原印刷(4.25)。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]质量一致位置式h²M⁻¹(F−Gᵀλ)，非原印刷(4.25)。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。该签名只是质量一致位置关系的定义，不是“由相空间方法消去动量得到(4.25)–(4.26)”这一断言：无SHAKE步骤前提、无序列、无消元蕴含，且它的反力为M⁻¹Gᵀρ而非原印刷Gᵀρ。[EXTRA]是合理的勘误候选，但属于改变公式而不是额外假设；不能代替原句的形式化。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakePositionRelation`：定义；`MD.Ch04.shakePositionRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1833)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPhase · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> A natural choice is to consider the phase space formulation of the Störmer-Verlet method for $`\dot q=M^{-1}p,\dot p=F(q)`$, then replace $`F`$ by $`F-g'(q)^T\lambda`$, resulting in

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.27}
$$



$$
p_{n+1/2}=p_n+(h/2)F(q_n)-(h/2)g'(q_n)^T\lambda_n,\tag{4.28}
$$



$$
p_{n+1}=p_{n+1/2}+(h/2)F(q_{n+1})-(h/2)g'(q_{n+1})^T\lambda_{n+1}.\tag{4.29}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho rhonew : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。half=pₙ₊½、z=(qₙ,pₙ)、out=(qₙ₊₁,pₙ₊₁)，四个合取项分别为(4.28)、(4.27)、实际位置约束、(4.29)。位置约束来自同页(4.26)的算法上下文，属于必要且合理的补全；两个乘子均按h/2缩放。未要求隐藏约束、未断言求解分支存在。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakeRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1847)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-RATTLE · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> A method that automatically preserves both the constraint and hidden constraint is the RATTLE method [12] which consists of the following steps:

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.30}
$$



$$
p_{n+1/2}=p_n+(h/2)F_n-(h/2)g'(q_n)^T\lambda_n,\tag{4.31}
$$



$$
0=g(q_{n+1}),\tag{4.32}
$$



$$
p_{n+1}=p_{n+1/2}+(h/2)F_{n+1}-g'(q_{n+1})^T\mu_{n+1},\tag{4.33}
$$



$$
0=g'(q_{n+1})M^{-1}p_{n+1}.\tag{4.34}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rattleRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。half、rho、μ依次代表pₙ₊½、λₙ、μₙ₊₁。依赖rattleRelation和本地同名定义一致；合取完整包含(4.30)–(4.34)。cotangentSet重复位置约束并包含隐藏约束，故并未漏掉“自动保持两种约束”。末步μ前无h/2，忠实原书不同缩放。无额外假设、无sorry；关系本身不承诺隐式解存在。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rattleRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1854)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

