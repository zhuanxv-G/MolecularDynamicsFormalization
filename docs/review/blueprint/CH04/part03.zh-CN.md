[上一部分](part02.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## 1. MD-4.3.3-ComponentSweep · definition · 印刷p.158 / PDFp.180

### 2. 原文陈述

> and continue to update $`\Lambda_2`$ in the same manner (using the second constraint). In general, we perform a sequence of updates

$$
\Delta\Lambda_j=[\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\qquad Q:=Q-M^{-1}G_n^j\Delta\Lambda_j,
$$


> as $`j`$ cycles repeatedly from $`1`$ to $`m`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow

def componentPrintedDelta {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Q : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : ℝ :=
  g j Q/MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
    (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))

def componentPrintedTrajectory {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) : ℕ → MolecularDynamics.Chapter04Review.Q n
  | 0 => Q₀
  | k+1 =>
    let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
    if hl : 0 < l then
      let j : Fin l := ⟨k%l,Nat.mod_lt k hl⟩
      Q-componentPrintedDelta m g Q Gsup1 j •
        MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
    else Q

def componentPrintedIteration {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (rounds : ℕ) (_hm : ∀ i, 0 < m i) (_hl : 0 < l)
    (_hvalid : ∀ k < rounds*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) :
    MolecularDynamics.Chapter04Review.Q n :=
  componentPrintedTrajectory m g q Q₀ Gsup1 (rounds*l)

def componentPrintedStop {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (round : ℕ) (tol : ℝ) (_hl : 0 < l)
    (_hvalid : ∀ k < (round+1)*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : Prop :=
  ∀ j : Fin l, |componentPrintedDelta m g
    (componentPrintedTrajectory m g q Q₀ Gsup1 (round*l+j.val)) Gsup1 j| ≤ tol



/-- 修正版，对应原文 MD-4.3.3-ComponentSweep。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def componentSweep_corrected {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.componentSweep`；`MD.Ch04.componentPrintedDelta`；`MD.Ch04.componentPrintedTrajectory`；`MD.Ch04.componentPrintedIteration`；`MD.Ch04.componentPrintedStop`；`MD.Ch04.componentSweep_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G\_j^1索引疑误保留待导师。没有更改逐分量更新次序。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。；[EXTRA] 保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。；[EXTRA] 停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G\_j^1索引疑误保留待导师。没有更改逐分量更新次序。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本轮修复：停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G\_j^1索引疑误保留待导师。没有更改逐分量更新次序。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；componentSweep按finRange l升序foldl，每次用刚更新的Qcur，使用梯度修订方向；它调用的是Chapter04Review.componentConstraintStep，无有效域假设，是实数逆零总化下的辅助函数。componentPrintedDelta忠实保留Gsup1；Trajectory以k mod l循环、旧q不变，l=0时恒等；Iteration在正质量、l>0和每个已执行步骤可微/分母非零条件下返回rounds*l步位置。Stop检查round*l+j处、更新前计算的一整轮各分量增量，顺序正确，却使用<tol，原页是≤tol；故本条全部声明不能整体PASS。原印索引疑误另需人工裁定。

### 7. 状态与证明位置

self-contained；`MD.Ch04.componentSweep`：定义；`MD.Ch04.componentPrintedDelta`：定义；`MD.Ch04.componentPrintedTrajectory`：定义；`MD.Ch04.componentPrintedIteration`：定义；`MD.Ch04.componentPrintedStop`：定义；`MD.Ch04.componentSweep_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1492)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-ProjectedEulerPrinted · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> On the other hand it is not too difficult to correct this defect by incorporating an additional projection onto the cotangent space:

$$
q_{n+1}=q_n+hM^{-1}\bar p_{n+1},\tag{4.20}
$$



$$
\bar p_{n+1}=p_n-hF_n-hg'(q_n)^T\lambda_n,\tag{4.21}
$$



$$
0=g(q_{n+1}),\tag{4.22}
$$



$$
p_{n+1}=\bar p_{n+1}-g'(q_{n+1})^T\mu_{n+1},\tag{4.23}
$$



$$
0=g'(q_{n+1})M^{-1}p_{n+1}.\tag{4.24}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectedEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • (-F z.1)-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectedEulerPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i项为(m i)⁻¹v\_i；Jacobian的(j,i)项为fderiv(g j)(q)(e\_i)。constraintSet是所有g\_j(q)=0；cotangentSet同时含位置约束及GM⁻¹p=0。因此五个合取依次等价于(4.21)、(4.20)、(4.22)、(4.23)、(4.24)，重复位置约束不改变关系。输入与输出及两组乘子均为显式参数，不声称存在。保留−hF符合印刷本。[ERRATUM?]成立：PDF185印刷163为+hF；这不影响逐字版通过。

### 7. 状态与证明位置

self-contained；`MD.Ch04.projectedEulerPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1553)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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

## 1. MD-4.3.5-ConstrainedOrders · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> The projected symplectic constrained method (4.20)–(4.24) is only first order accurate. We forego providing a detailed proof of this fact, but note that it could be demonstrated using standard methods [164]. There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedOrders :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  sorry

theorem constrainedOrders_global (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 4 U) (_hg : ∀ j, ContDiff ℝ 4 (g j))
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      (textbookConstraintGram m g z.1).det ≠ 0)
    (E R : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (pE pR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (η : ℝ) (_hη : 0 < η)
    (_hE : ContDiffOn ℝ 3 (Function.uncurry E) (Ioo (-η) η ×ˢ D))
    (_hR : ContDiffOn ℝ 3 (Function.uncurry R) (Ioo (-η) η ×ˢ D))
    (_hrhoE : ContDiffOn ℝ 2 (Function.uncurry rhoE) (Ioo (-η) η ×ˢ D))
    (_hμE : ContDiffOn ℝ 2 (Function.uncurry μE) (Ioo (-η) η ×ˢ D))
    (_hrhoR : ContDiffOn ℝ 2 (Function.uncurry rhoR) (Ioo (-η) η ×ˢ D))
    (_hμR : ContDiffOn ℝ 2 (Function.uncurry μR) (Ioo (-η) η ×ˢ D))
    (_hzero : ∀ z ∈ D, E 0 z=z ∧ R 0 z=z ∧ μE 0 z=0 ∧ μR 0 z=0)
    (_hsteps : ∀ h ∈ Ioo (-η) η, ∀ z ∈ D,
      z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (R h z) (pR h z) (rhoR h z) (μR h z))
    (T : ℝ) (_hT : 0 < T) (Φ : ℝ → MolecularDynamics.Chapter04Review.Z n)
    (_hΦ : ∀ t ∈ Icc 0 T, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t)
    (_hc : ∀ t ∈ Icc 0 T, Φ t ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hcompact : ∃ B, IsCompact B ∧ B ⊆ D ∧ ∀ t ∈ Icc 0 T, Φ t ∈ B) :
    ∃ C > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      let h := T/(N:ℝ)
      ∀ k ≤ N, ‖(E h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h ∧
        ‖(R h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h^2 := by
  sorry

theorem constrainedOrders_firstOrderSharp :
    ∃ c > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      c/(N:ℝ) ≤ ‖(MolecularDynamics.Chapter04Review.symplecticEulerMatrix 1 (1/(N:ℝ)))^N *ᵥ
        (![1,0] : Fin 2 → ℝ)-![Real.cos 1,-Real.sin 1]‖ := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-ConstrainedOrders。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem constrainedOrders_corrected :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 投影Euler全局一阶（含非二阶实例）及RATTLE全局二阶；SHAKE位置全局二阶由MD-4.3.5-SHAKEPositionOrder承担，其原印质量约定待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedOrders`；`MD.Ch04.constrainedOrders_global`；`MD.Ch04.constrainedOrders_firstOrderSharp`；`MD.Ch04.constrainedOrders_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。；[EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；constrainedOrders：正质量、C⁴势/约束、初点余切约束及Gram非零；E/R/Φ为C³步长曲线且在0等于z，乘子为C²，末投影μE、μR在0为零；真实步关系与精确ODE在双侧小窗口成立。结论是同一起点单步Euler O(h²)、RATTLE O(h³)，并非全局阶。pE/pR未单列光滑性，但步关系已给其光滑表达式。global另在开放D上设联合C³ E/R、联合C²乘子、零步恒等及正则余切域；精确轨道在[0,T]落于D内紧集。结论对充分大正整数N、全部k≤N给Euler Ch和RATTLE Ch²全局误差；没有将误差作为假设。firstOrderSharp对T=1振子初值(1,0)给全步误差c/N下界，确实排除该方法统一二阶。以上对正力号修订方法数学上合理，但与原印负力号不能无标记等同。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedOrders`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_global`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_firstOrderSharp`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1865)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-RATTLESymplectic · unnumbered_claim · 印刷p.162 / PDFp.184

### 2. 原文陈述

> Moreover, the symplecticness of (4.30)–(4.34) may be demonstrated using a very similar approach to that used to demonstrate the symplectic condition for (4.20)–(4.24). Given the above discussion and derivation, the proof of symplecticness of the RATTLE method (4.30)–(4.34) is now a formality. For details refer to [229].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rattleSymplectic (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j))
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D) (h : ℝ)
    (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1))
    (_hG : ContDiffOn ℝ 1 G D) (_hp : ContDiffOn ℝ 1 half D)
    (_hr : ContDiffOn ℝ 1 rho D) (_hμ : ContDiffOn ℝ 1 μ D)
    (_hstep : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) :
    ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      ∀ u v, MolecularDynamics.Chapter04Review.tangentPhase m g z u →
      MolecularDynamics.Chapter04Review.tangentPhase m g z v →
        MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=
          MolecularDynamics.Chapter04Review.phaseForm u v := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rattleSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。 | [EXTRA] |

[EXTRA] 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。；[EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意n/l、正质量、C² U/g、开放D及固定实步长h；仅在D与余切约束集交上要求位置梯度独立。G、half、rho、μ均在D上C¹；真实RATTLE关系只对约束初点要求，输出由关系保证位置及隐藏约束。tangentPhase准确包含g的一阶切条件及g′M⁻¹p的一阶切条件。结论对每个该初点及任意两条切向量给phaseForm(DG u,DG v)=phaseForm(u,v)，是完整受限辛性。正质量和满秩使该受限域为正则余切流形，允许由约束集上的关系沿切向量微分。h=0亦无问题。未要求全局单值求解或分支存在。[EXTRA]与签名一致；sorry不参与判错。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rattleSymplectic`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1945)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-StaggeredConstraint · definition · 印刷p.162 / PDFp.184

### 2. 原文陈述

> the iterations generated by them can be related to the following staggered iteration

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.35}
$$



$$
p_{n+1/2}=p_{n-1/2}+hF_n-hg'(q_n)^T\widetilde\lambda_n,\tag{4.36}
$$



$$
0=g(q_{n+1}),\tag{4.37}
$$


> where, for SHAKE, $`\widetilde\lambda_n=\lambda_n`$, while, in case of RATTLE, we must define $`\widetilde\lambda_n=(\lambda_n+\mu_n)/2`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.5-StaggeredConstraint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def staggeredConstraintRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.staggeredConstraintRelation`；`MD.Ch04.staggeredConstraintRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。参数rho是独立的交错乘子，关系完整记录(4.35)–(4.37)，无sorry。但原文还有SHAKE的tildeλ=λ和RATTLE的tildeλ=(λ+μ)/2及两种迭代可归约为此关系，签名没有原方法乘子、无换算公式、无归约断言，遗漏实质子句。[ERRATUM?]成立：合并上一RATTLE末步和当前首步得newHalf=oldHalf+hF−Gᵀ(μₙ+(h/2)λₙ)，故h≠0时tildeλ=λₙ/2+μₙ/h，非印刷平均。

### 7. 状态与证明位置

self-contained；`MD.Ch04.staggeredConstraintRelation`：定义；`MD.Ch04.staggeredConstraintRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1970)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKERATTLEEquivalence · unnumbered_claim · 印刷p.162 / PDFp.184

### 2. 原文陈述

> Given an initial condition $`(q_0^S,p_0^S)`$ for the SHAKE discretization, we easily determine $`\lambda_0^S`$ by taking a step. Then it follows that

$$
p_{-1/2}=p_0-(h/2)F(q_0^S)-(h/2)g'(q_0^S)^T\lambda_0^S,
$$


> by solving (4.29). Next we obtain $`p_0^R`$ by solving (4.33)–(4.34) with $`n=-1`$. Then the sequences generated using $`(q_0^S,p_0^S)`$ as the initial point for SHAKE and that generated using $`(q_0^S,p_0^R)`$ in RATTLE will have identical positions (the momenta can be made compatible by simply projecting the SHAKE momenta onto the constraints).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakeRattlePositions :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-SHAKERATTLEEquivalence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakeRattlePositions_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeRattlePositions`；`MD.Ch04.shakeRattlePositions_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。；[EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。已展开projectionResidual\_j=g\_j(base−M⁻¹G(q)ᵀeta)、Gram=GM⁻¹Gᵀ、cotangentMultiplier=Gram⁻¹GM⁻¹p、cotangentProjection=p−GᵀGram⁻¹GM⁻¹p。两套真实步骤、qS0=qR0、halfS0=halfR0推出位置相同及k+1动量投影关系，是合理的条件版本，未直接假设位置相同。正质量及约束上梯度独立为实际投影所需，合理。但原文从给定SHAKE初态构造RATTLE初态，签名把半步兼容直接作假设，没有构造pR0，也无k=0的动量投影结论。宣称“同一局部唯一投影分支”的[EXTRA]实际却量化所有q、所有base、所有eta/nu，要求全局根的法向修正唯一；未限制邻域或分支，远强于局部资格并排除常见非线性约束。[ERRATUM?]初始反力符号疑误成立：由(4.29)应得oldHalf=p0−(h/2)F+(h/2)Gᵀλ0，而印刷为负号。定理体为sorry；本FAIL针对原文初始化缺项与不合理全局资格，不声称这个强假设下的条件定理必然为假。

### 7. 状态与证明位置

incomplete；`MD.Ch04.shakeRattlePositions`：未证（原书疑误不证）；`MD.Ch04.shakeRattlePositions_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1988)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEElimination · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakeElimination :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1



/-- 修正版，对应原文 MD-4.3.5-SHAKEElimination。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakeElimination_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeElimination`；`MD.Ch04.shakeElimination_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 shakeRelation 展开为 half=p+(h/2)(F(q)−G(q)ᵀrho)，qnew=q+hM⁻¹half，g(qnew)=0，pnew=half+(h/2)(F(qnew)−G(qnew)ᵀrhonew)。签名全称量化 n,l,m,F,g,h 及四套序列，假设每一步满足该关系；用连续两步消去 p，结论以 k+1 为中心、乘子 rho(k+1)，并包含 g(q(k+2))=0；指标及量词正确，代数不需 h≠0、质量正性或光滑性。[EXTRA] 实际是更换结论公式，非额外假设；质量一致消元在数学上正确，但并非原句声称的印刷 (4.25)。[ERRATUM?] 反力缺失 M⁻¹ 的判断成立，不能对一般非标量对角质量仅重命名乘子解决。故原文忠实性 FAIL，非判定修正式为假。Ch04.lean:1120 有显式代数证明，无 sorry；未运行 Lean 编译，证明完成状态与语义结论分开。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakeElimination`：已证；`MD.Ch04.shakeElimination_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2032)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionOrder · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakePositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-SHAKEPositionOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakePositionOrder_corrected :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionOrder`；`MD.Ch04.shakePositionOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 grad U=textbookConstraintGradient U，所以 F=−∇U。constrainedSolution 在 I=[0,tau] 的每个 t 要求 q 的区间导数为 M⁻¹p，p 的区间导数为 −∇U−Gᵀrho，且 g(q)=0；textbookInverseMassMatrix=diag(m\_i⁻¹)，textbookConstraintGram=G diag(m\_i⁻¹) Gᵀ。全称量化数据与精确解后，先要求 tau>0、正质量、U/g/q 为 C⁴、p 为 C³、实际受约束解、沿紧区间 Gram 行列式非零；然后存在与 N 无关的 C>0,N0≥2，每个 N≥N0 存在离散位置及乘子，精确两步初值 qn0=q0,qn1=q(h)，满足 k+2≤N 的递推与全部 k≤N 的误差 C h²。这是真实有限区间二阶位置误差及存在性结论，不是把误差作假设。[EXTRA] 正质量、正则性、独立约束和相容起步对通常二阶收敛论述合理，但 C⁴ 全局正则及精确第二初值属于较强的充分条件，不应称为最小必要条件；结论仅选择存在的好分支，不声称所有隐式根均收敛，也不含动量误差。主要忠实性问题仍是：原页 symmetry 句紧接印刷 (4.25)，Lean 却对质量一致修正式给阶数，改变了方法；一般质量下两者甚至不逼近同一受约束解。因此 FAIL 不由 sorry 引起。Ch04.lean:1142 的证明为 sorry，二阶修正式的证明仍待完成，本审计不把它视为已验证定理。

### 7. 状态与证明位置

incomplete；`MD.Ch04.shakePositionOrder`：未证（原书疑误不证）；`MD.Ch04.shakePositionOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2078)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-AdjointEuler · definition · 印刷p.163 / PDFp.185

### 2. 原文陈述

> Now replace $`h`$ by $`-h`$ and then swap $`Q`$ with $`q`$ and $`P`$ with $`p`$, resulting in

$$
\widehat P=p-hg'(q)^T\lambda,\quad Q=q+hM^{-1}\widehat P,\quad P=\widehat P+hF(Q)-hg'(Q)^T\mu,
$$


> where $`\lambda,\mu`$ are again defined by the constraint conditions. This defines the adjoint method, another first order method for the constrained system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

theorem adjointEuler_inverseRelation (n l : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (_hh : h ≠ 0)
    (z out : MolecularDynamics.Chapter04Review.Z n)
    (_hz : z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hout : out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g) :
    (∃ half rho μ, adjointEulerRelation m F g h z out half rho μ) ↔
      ∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (-h) out z pbar rho μ := by
  sorry

theorem adjointEulerLocalOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E A : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 A → ContDiff ℝ 3 Φ → E 0=z → A 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖A h-Φ h‖ ≤ C*h^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.adjointEulerRelation`；`MD.Ch04.adjointEuler_inverseRelation`；`MD.Ch04.adjointEulerLocalOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；adjointEulerRelation对任意n/l、质量、F、约束、h和输入输出相点及三个辅助向量定义三式，并要求输出位置约束、输出隐藏约束。定义自身未要求输入在余切域，使用时另给；这不等同自动存在求解。inverseRelation在h≠0且两端余切约束下，对存在乘子的伴随关系与反向步长−h的正向关系给双向等价，质量无需正性，因为这里只作代数改写；乘子交换并缩放即可。该关系等价不声称局部分支唯一或逆映射存在。adjointEulerLocalOrder另设正质量、C⁴ U/g、初点Gram非零、C³ E/A/Φ、C²乘子、零步初值及μE(0)=μR(0)=0，配真实步关系和ODE，结论Euler与伴随各自局部O(h²)，数学合理且符合[EXTRA]所限定局部精度范围。未提供全局一阶或严格非二阶下界，不将局部结论冒称这些更强命题。

### 7. 状态与证明位置

incomplete；`MD.Ch04.adjointEulerRelation`：定义；`MD.Ch04.adjointEuler_inverseRelation`：未证（缺大型理论）；`MD.Ch04.adjointEulerLocalOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2117)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedComposition · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> By composing the maps $`G_{h/2}`$ and $`G^*_{h/2}`$ we get a second order symplectic method. In the sense that it is defined by first order maps which reduce to the Symplectic Euler method and its adjoint, this is an analogous scheme to the Störmer-Verlet method. Interestingly, this method is not equivalent to SHAKE or RATTLE.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedComposition :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoA μA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ q ∈ MolecularDynamics.Chapter04Review.constraintSet g, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) q)) →
    (∀ h ∈ Ioo (-η) η, ContDiff ℝ 1 (E h) ∧ ContDiff ℝ 1 (A h) ∧
      ContDiff ℝ 1 (pE h) ∧ ContDiff ℝ 1 (pA h) ∧ ContDiff ℝ 1 (rhoE h) ∧
      ContDiff ℝ 1 (μE h) ∧ ContDiff ℝ 1 (rhoA h) ∧ ContDiff ℝ 1 (μA h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h ∈ Ioo (-η) η, MolecularDynamics.Chapter04Review.restrictedSymplectic m g (A (h/2) ∘ E (h/2)) := by
  sorry

theorem constrainedComposition_circleExample :
    let m : Fin 2 → ℝ := fun _ ↦ 1
    let g : Fin 1 → (Fin 2 → ℝ) → ℝ := fun _ q ↦ (q 0)^2+(q 1)^2-1
    let F : (Fin 2 → ℝ) → Fin 2 → ℝ := fun _ ↦ 0
    let z : MolecularDynamics.Chapter04Review.Z 2 := (![1,0],![0,1])
    let e : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 15/4,1/4],![-1/4,Real.sqrt 15/4])
    let a : MolecularDynamics.Chapter04Review.Z 2 :=
      (![7/8,Real.sqrt 15/8],![-Real.sqrt 15/8,7/8])
    let r : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 3/2,1/2],![-1/2,Real.sqrt 3/2])
    ∃ pE pA pR pS ρE μE ρA μA ρR μR ρS ρSnew pSout,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (1/4) z e pE ρE μE ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m F g (1/4) e a pA ρA μA ∧
      MolecularDynamics.Chapter04Review.rattleRelation m F g (1/2) z r pR ρR μR ∧
      MolecularDynamics.Chapter04Review.shakeRelation m F g (1/2) z (r.1,pSout) pS ρS ρSnew ∧
      a.1 ≠ r.1 := by
  sorry

theorem constrainedComposition_noConstraints (n : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) :
    ((∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out pbar rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m (z.2+h • F z.1),z.2+h • F z.1)) ∧
    ((∃ half rho μ, MolecularDynamics.Chapter04Review.adjointEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out half rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2,
        z.2+h • F (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 小h光滑分支上的组合辛性、无约束退化及非等价实例；二阶精度子句由MD-4.3.5.1-ConstrainedCompositionOrder承担，原文保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedComposition`；`MD.Ch04.constrainedComposition_circleExample`；`MD.Ch04.constrainedComposition_noConstraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的固定步长、存在乘子的非等价位置实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。 | [EXTRA] |

[EXTRA] U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。；[EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的固定步长、存在乘子的非等价位置实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。；[EXTRA] 完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主定理量化n/l、正质量、C³ U/g、约束集上梯度独立以及η>0；E/A和所有辅助输出在每个|h|<η上对空间为C¹；对所有余切初点满足真实正向/伴随关系。结论仅组合在每个|h|<η上受限辛；h/2仍在窗口内，E输出在余切域，可再次应用A，故几何结论合理。这里无需步长光滑性，也没有步长光滑性，故不能由该签名附带得出二阶或对称性。circleExample：自由单位圆、m=1、初点((1,0),(0,1))，正向1/4得到e，伴随1/4得到a，RATTLE1/2得到r，SHAKE1/2存在同r位置的输出；a位置不同，确实给一组非等价候选更新。noConstraints准确退化为kick-drift Euler和drift-kick伴随，对任意质量/F/h成立，未声称任意F下辛。完整原文二阶子句仍须外部委托声明，按本任务材料不能核验；实例单值近分支资格也未覆盖。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedComposition`：未证（缺大型理论）；`MD.Ch04.constrainedComposition_circleExample`：未证（缺大型理论）；`MD.Ch04.constrainedComposition_noConstraints`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2153)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedCompositionOrder · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> By composing the maps $`G_{h/2}`$ and $`G^*_{h/2}`$ we get a second order symplectic method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedCompositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE muE rhoA muA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → MolecularDynamics.Chapter04Review.Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 组合方法O(h³)局部误差（二阶精度）子句；辛性、退化及非等价实例由MD-4.3.5.1-ConstrainedComposition承担；不冒充全局二阶收敛。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedCompositionOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。 | [EXTRA] |

[EXTRA] 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。；[EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词覆盖任意有限维n、约束数l、正质量、C⁴势和约束，以及在同一对称步长窗口内满足两种离散关系的C³相空间映射E、A。初值恒等且muE在零步长为零；起点属于余切约束集且Gram行列式非零。对任意同初值C³精确局部ODE轨道，结论是正小步长局部误差≤C h³；不是全局误差估计。辛性不在本签名中，已由statement\_scope明确分出，外部ConstrainedComposition未在本任务提供，不能据本条认证它。projectedEulerRelation末次修正未乘h，是将原页乘子hμ吸收到muE中的参数化；muE 0 z=0与该参数化相容。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedCompositionOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2201)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-MomentumProjector · definition · 印刷p.163 / PDFp.185

### 2. 原文陈述

> where $`\Pi`$ is a mass-weighted projector onto the tangent space of the constraints at the point $`q`$ defined by

$$
\Pi=I-g'(q)^T[g'(q)M^{-1}g'(q)^T]^{-1}g'(q)M^{-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def momentumProjector {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q : MolecularDynamics.Chapter04Review.Q n) :=
  (1 : Matrix (Fin n) (Fin n) ℝ)-(textbookConstraintJacobian g q)ᵀ *
    (textbookConstraintGram m g q)⁻¹ * textbookConstraintJacobian g q * textbookInverseMassMatrix m
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.momentumProjector` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 MolecularDynamics.Chapter04Review 的 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v=(m\_i⁻¹ v\_i)、constraintSet g={q|∀j,g\_j(q)=0}、cotangentSet m g={z|g(z.1)=0且G(z.1)M⁻¹z.2=0}。G=textbookConstraintJacobian，其(j,i)项为 fderiv ℝ (g j) q (Pi.single i 1)；grad U 同样取 U 的实际坐标 Fréchet 导数；textbookInverseMassMatrix=diag(m\_i⁻¹)；textbookConstraintGram=GM⁻¹Gᵀ。出处：依赖摘录 ConstrainedProjection.lean:2975–2977、CotangentProjection.lean:3385–3420、ReviewDefinitions.lean:4377–4444（行号均为附件行号）。 Ch04.lean:1198–1200 与依赖 ReviewDefinitions.lean:4503–4505 同为 I−Gᵀ(GM⁻¹Gᵀ)⁻¹GM⁻¹，矩阵顺序与 PDF185 完全一致。原文 tangent space 的措辞须按动量/速度的质量识别解释：Π 的像是 ker(GM⁻¹)，并非一般的速度切空间 ker G；context\_notation 已明确此点，未静默更改书中公式。正质量、Gram非奇异时 Π²=Π、GM⁻¹Π=0，对 M⁻¹ 内积自伴；M⁻¹Πp 对应切速度。具体地 G=(1,1), M=diag(1,2) 时 Π(1,0)=(1/3,−2/3)，GΠ(1,0)=−1/3 而 GM⁻¹Π(1,0)=0。这排除了把书中语句误读成欧氏正交速度投影。这里审核的是带已有 context 资格的公式定义，不是无条件投影定理；Lean 的总定义在奇异Gram、零质量处依然有值，不能据此宣称那些点也是投影。没有 [EXTRA] 或 [ERRATUM?] 标记，也没有 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.momentumProjector`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2217)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedPotentialFlow · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> For the potential energy term, an exact solution is given by $`Q=q,\quad P=p-h\Pi(q)\nabla U(q)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedPotentialFlow :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n),
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    (∀ j, Differentiable ℝ (g j)) → ∀ t : ℝ,
    let P := fun s : ℝ => z.2-s • (MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1)
    (z.1,P t) ∈ MolecularDynamics.Chapter04Review.cotangentSet m g ∧ HasDerivAt P (-MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1) t := by
  intro n l m U g z hz hdet hg t
  rcases hz with ⟨hq,hp⟩
  let u := MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1
  have hi : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.invMass m v=textbookInverseMassMatrix m *ᵥ v := by
    intro v
    ext i
    simp [MolecularDynamics.Chapter04Review.invMass,textbookInverseMassMatrix,Matrix.mulVec_diagonal]
  have hproj : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ v=textbookCotangentProjection m g z.1 v := by
    intro v
    simp only [MolecularDynamics.Chapter04Review.momentumProjector,Matrix.sub_mulVec,Matrix.one_mulVec,
      textbookCotangentProjection,textbookCotangentMultiplier,Matrix.mulVec_mulVec,Matrix.mul_assoc]
  have hu : textbookConstraintJacobian g z.1 *ᵥ (textbookInverseMassMatrix m *ᵥ u)=0 := by
    dsimp [u]
    rw [hproj]
    exact textbookCotangentProjection_hiddenConstraint m g z.1 _ hdet
  rw [hi] at hp
  constructor
  · change z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
      textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (z.2-t • u)=0
    refine ⟨hq,?_⟩
    rw [hi,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_sub,Matrix.mulVec_smul,hp,hu]
    simp
  · simpa [u,Matrix.neg_mulVec] using (((hasDerivAt_id t).smul_const u).const_sub z.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedPotentialFlow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]签名采用真实Gram行列式非零、可微约束及初始余切约束；正质量和独立约束是通常物理资格的充分条件。只证势能子流的固定位置与投影动量ODE。 | [EXTRA] |

[EXTRA] [EXTRA]签名采用真实Gram行列式非零、可微约束及初始余切约束；正质量和独立约束是通常物理资格的充分条件。只证势能子流的固定位置与投影动量ODE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 MolecularDynamics.Chapter04Review 的 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v=(m\_i⁻¹ v\_i)、constraintSet g={q|∀j,g\_j(q)=0}、cotangentSet m g={z|g(z.1)=0且G(z.1)M⁻¹z.2=0}。G=textbookConstraintJacobian，其(j,i)项为 fderiv ℝ (g j) q (Pi.single i 1)；grad U 同样取 U 的实际坐标 Fréchet 导数；textbookInverseMassMatrix=diag(m\_i⁻¹)；textbookConstraintGram=GM⁻¹Gᵀ。出处：依赖摘录 ConstrainedProjection.lean:2975–2977、CotangentProjection.lean:3385–3420、ReviewDefinitions.lean:4377–4444（行号均为附件行号）。 Ch04.lean:1204–1210 的 let P(s)=p−sΠ(q)∇U(q) 显式固定 q；∀t 的结论既保留 g(q)=0 和 GM⁻¹P(t)=0，也给出 P′(t)=−Π(q)∇U(q)。因此 Q=q、P=p−tΠ∇U 的具体解以及投影动量ODE均已表达。q 常值的零导数是该表达的直接语义，不需要把公式改成泛称 solution。乘子可取 −(GM⁻¹Gᵀ)⁻¹GM⁻¹∇U，故 P′=−∇U−Gᵀlambda，与势能子流一致。[EXTRA] 初始余切域和非奇异Gram是自然资格，可微约束合理（实际该证明只用代数关系，可弱化）；不需要势能 Hessian，固定位置使斜率常值。U 没有可微假设，fderiv 在不可微点取总化默认值，故作为 Lean 代数恒等式结论仍成立；物理 Hamiltonian 解释应限制 U 在 q 可微，这是语义域资格，不把该总化扩展误当非光滑经典流。原文没有要求流的唯一性/全局存在性定理。无 [ERRATUM?]。此 theorem 的附件正文有实际证明且未出现 sorry，但本次未运行 Lean 编译，不作编译通过声明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedPotentialFlow`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2223)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-GeodesicRelation · definition · 印刷p.164 / PDFp.186

### 2. 原文陈述

> The constrained flow on the kinetic energy term, on the other hand, is generated by the equations of motion

$$
\frac{dq}{dt}=M^{-1}p,\quad\frac{dp}{dt}=-g'(q)^T\lambda,\quad0=g(q).
$$


> This is nothing other than the mass-weighted geodesic flow on the given constraint surface.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) (_hm : ∀ i, 0 < m i)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) : Prop :=
  MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ => 0) g q p rho I

def massMetric {n : ℕ} (m : Fin n → ℝ) (u v : Fin n → ℝ) : ℝ :=
  ∑ i, m i*u i*v i

theorem geodesicRelation_massMetric (n l : ℕ) (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (I : Set ℝ) (_hI : IsOpen I)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n) (_hq : ContDiff ℝ 2 q)
    (_hc : ∀ t ∈ I, ∀ j, g j (q t)=0)
    (_hreg : ∀ t ∈ I, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) (q t))) :
    (∀ t ∈ I, ∀ ξ : MolecularDynamics.Chapter04Review.Q n,
      textbookConstraintJacobian g (q t) *ᵥ ξ=0 →
        massMetric m (deriv (deriv q) t) ξ=0) ↔
    ∃ p rho, (∀ t ∈ I, p t=fun i ↦ m i*deriv q t i) ∧
      MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ ↦ 0) g q p rho I := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.geodesicRelation`；`MD.Ch04.massMetric`；`MD.Ch04.geodesicRelation_massMetric` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补正质量诱导度量∑m\_i u\_i v\_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。 | [EXTRA] |

[EXTRA] [EXTRA] 补正质量诱导度量∑m\_i u\_i v\_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Q=Fin n→ℝ；constrainedSolution实际被引用的是Chapter04Review中以力F为参数的版本，而非同名MD中以势U为参数的版本。F=0展开后正好是qdot=M⁻¹p、pdot=−Dgᵀrho及g(q)=0。IsOpen使within导数与普通导数一致。massMetric为Σm\_i u\_i v\_i；等价定理在C²约束、C²轨道、轨道留在约束面且梯度线性无关条件下，将质量正交加速度与存在p=M qdot及乘子对应。量词顺序允许选取整条轨道上的p、rho；不要求额外全局流存在。

### 7. 状态与证明位置

incomplete；`MD.Ch04.geodesicRelation`：定义；`MD.Ch04.massMetric`：定义；`MD.Ch04.geodesicRelation_massMetric`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2255)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-MShakeIteration · definition · 印刷p.164 / PDFp.186

### 2. 原文陈述

> M-Shake This is Newton-iteration-based implementation of SHAKE, using (4.18)–(4.19) to solve Eqs. (4.27)–(4.29).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mShakeIteration {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ) := (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mShakeIteration` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean、ConstrainedProjection.lean 与 CotangentProjection.lean：Q n=Fin n→ℝ；textbookConstraintGradient (g j) x i=(fderiv ℝ (g j) x)(Pi.single i 1)；G(x) 的 j,i 元为该梯度；invMass m v i=(m i)⁻¹v i，textbookInverseMassMatrix m=diag((m i)⁻¹)。令 x(η)=base−M⁻¹G(q)ᵀη，则 residual(η)=g(x(η))，projectionJacobian(η)=G(x(η))M⁻¹G(q)ᵀ，newtonConstraint(η)=η+projectionJacobian(η)⁻¹residual(η)。残差的真正导数为上述矩阵的负值，故更新中的加号正确，逐项对应 PDF179/印刷157 的(4.18)–(4.19)。mShakeIteration 将此实际更新从零复合 k 次，k=0 返回零，不是恒等占位或冻结雅可比更新。这里 base 是已消去显式动力学更新后的无约束位置，η 吸收步长因子；在 SHAKE 中可取 base=q+hM⁻¹p+(h²/2)M⁻¹F(q)，η=(h²/2)ρ，对应 PDF183 的(4.27)–(4.28)。正文允许零初值，context\_notation 明确本条仅记录有限次迭代，未声称已经精确求解、收敛或构成完整相空间时间步。自然数 n,l,k 与 m,g,q,base 均为定义参数，无存在性或全称收敛命题。定义没有假设正质量、可微性或每步可逆；Lean 的逆与 fderiv 在退化输入上是总化运算，这只扩展定义域，不能将退化输入解释为有效物理 Newton 求解。没有 [EXTRA] 或 [ERRATUM?] 标签；本定义无 sorry。签名在所标明有限迭代范围内忠实。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mShakeIteration`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2277)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

