[上一部分](part04.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / 下一部分：无

## 1. MD-4.4.1-AxisFlowFormal · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem axisFlow :
  ∀ (I π : MolecularDynamics.Chapter04Review.V) i, 0 < I i → ∀ t : ℝ,
  HasDerivAt (fun s : ℝ => (MolecularDynamics.Chapter04Review.spinAxis I i s (π,1)).1)
    (MolecularDynamics.Chapter04Review.cross3 ((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1) (Pi.single i (((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1 i)/I i))) t := by
  sorry



/-- 修正版，对应原文 MD-4.4.1-AxisFlowFormal。改动：采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。 -/
```

独立修正版：

```lean
theorem axisFlow_corrected : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.axisFlow`；`MD.Ch04.axisFlow_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。 | [EXTRA] |

[EXTRA] [EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。；[ERRATUM?] 采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 spinAxis展开为R=axisRotation i(tπ\_i/I\_i)，输出(Rπ,ΘRᵀ)；HasDerivAt对实时间求整个三维动量的导数，∀I,π,i且I\_i>0，∀t。正角导数为ω×π，签名右端为π×ω，符号相反；[ERRATUM?]在原矩阵与列动量约定下成立。I\_i>0合理且足够，但不能修复符号。axisFlow含sorry，仅记录证明未完成，FAIL依据签名反例。

### 7. 状态与证明位置

incomplete；`MD.Ch04.axisFlow`：未证（原书疑误不证）；`MD.Ch04.axisFlow_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2912)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-SpinPoissonFormal · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> This yields a simple, efficient algorithm for the free rigid body which is symplectic in a generalized sense.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem spinPoisson :
  ∀ I : MolecularDynamics.Chapter04Review.V, (∀ i, 0 < I i) → ∀ h : ℝ,
  poissonMap (fun π => (MolecularDynamics.Chapter04Review.spinStep I h (π,1)).1) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.spinPoisson` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。 | [EXTRA] |

[EXTRA] [EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开spinStep为x(h/2)∘y(h/2)∘z(h)∘y(h/2)∘x(h/2)五步，spinAxis的动量部分为正角Rπ，初始姿态1不影响动量。Statements.lean中poissonMap展开为∀π，D\_ij=(fderiv ℝ G π)(e\_j)_i，D skewMatrix(π) Dᵀ=skewMatrix(Gπ)。这确实是自由刚体三维约化动量上的Poisson保持，不是空谓词或抽象替代；对应本条generalized symplectic的几何结论。正角各步是相应负时间Hamiltonian子流，同样Poisson；故axisFlow符号FAIL不推出本条FAIL。∀I正主惯量、∀h合理；[EXTRA]明确约化动量范围，与自由刚体段落一致，不覆盖后续含姿态的完整算法。简单/高效为定性描述，无定量复杂度命题。spinPoisson含sorry；PASS只判签名语义，不声称已验证其证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.spinPoisson`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2933)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidPoissonSkew · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $`\widetilde J(\pi)=\operatorname{skew}(\pi)`$ is obviously skew symmetric.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidPoissonSkew : ∀ π : MolecularDynamics.Chapter04Review.V, (MolecularDynamics.Chapter04Review.rigidPoissonMatrix π)ᵀ= -MolecularDynamics.Chapter04Review.rigidPoissonMatrix π := by
  intro π
  ext i j
  fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidPoissonSkew` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 rigidPoissonMatrix展开为skewMatrix(π)=[[0,−π₂,π₁],[π₂,0,−π₀],[−π₁,π₀,0]]。∀π，矩阵转置等于负矩阵，恰是原书skew symmetric，无Jacobi或非退化附加断言；无额外假设。Ch04.lean该声明有逐分量证明，无sorry；本次只读，不作编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidPoissonSkew`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2939)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidHamiltonianField · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> Let us observe that (4.41) is in the form $`\dot\pi=\widetilde J(\pi)\nabla\widetilde H`$, where $`\widetilde J(\pi)=\operatorname{skew}(\pi)`$ is obviously skew symmetric, and $`\widetilde H=\pi^TT^{-1}\pi/2`$ is the energy function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidHamiltonianField : ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V), T.PosDef →
  MolecularDynamics.Chapter04Review.eulerRigidField T π=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ
    MolecularDynamics.Chapter04Review.grad (fun x => MolecularDynamics.Chapter04Review.dot x (T⁻¹ *ᵥ x)/2) π := by
  intro T π hT
  let B := T⁻¹
  have hsym : Bᵀ=B := by
    simpa [B,Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hs : ∀ i j : Fin 3, B i j=B j i := by
    intro i j
    simpa using congrArg (fun A : MolecularDynamics.Chapter04Review.Mat3 => A j i) hsym
  let row : Fin 3 → (MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ) := fun i => ∑ j, B i j • (ContinuousLinearMap.proj j : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ)
  let L : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ := (2 : ℝ)⁻¹ • ∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ))
  have hb : ∀ i, HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => (B *ᵥ x) i) (row i) π := by
    intro i
    change HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => ∑ j,B i j*x j) (∑ j,B i j • (ContinuousLinearMap.proj j : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ)) π
    apply HasFDerivAt.fun_sum
    intro j hj
    exact (hasFDerivAt_apply j π).const_mul (B i j)
  have hh : HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => ∑ i,x i*(B *ᵥ x) i)
      (∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ))) π := by
    apply HasFDerivAt.fun_sum
    intro i hii
    exact (hasFDerivAt_apply i π).mul (hb i)
  have hd : HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) L π := by
    convert hh.const_mul ((2 : ℝ)⁻¹) using 1
    funext x
    simp only [MolecularDynamics.Chapter04Review.dot,div_eq_mul_inv]
    ring
  have hg : MolecularDynamics.Chapter04Review.grad (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π=B *ᵥ π := by
    ext i
    change (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π) (Pi.single i 1)=(B *ᵥ π) i
    rw [hd.fderiv]
    fin_cases i <;> simp [L,row,ContinuousLinearMap.sum_apply,ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.proj_apply,Fin.sum_univ_three,Pi.single_apply,Matrix.mulVec,dotProduct,hs 1 0,hs 2 0,hs 2 1] <;> ring
  change MolecularDynamics.Chapter04Review.cross3 π (B *ᵥ π)=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ MolecularDynamics.Chapter04Review.grad (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π
  rw [hg]
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidHamiltonianField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。 | [EXTRA] |

[EXTRA] 正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 eulerRigidField=π×(T⁻¹π)，rigidPoissonMatrix=skewMatrix(π)；dot=Σ\_i x\_i y\_i；grad= textbookConstraintGradient，后者在ConstrainedProjection.lean展开为i↦(fderiv ℝ H π)(Pi.single i 1)，为真实坐标梯度而非假设。原式的对象、所有能量因子及梯度位置完整保留。∀T,π，T.PosDef是物理非退化惯量的合理资格，提供对称与可逆性；对称性保证此二次型梯度为T⁻¹π，无把结论作假设。skew性质已由单列RigidPoissonSkew覆盖。[EXTRA]正定性强于此等式所需的对称性，但在使用T⁻¹的物理惯量范围合理。Ch04.lean有Fréchet微分和逐分量证明，无sorry；本次未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidHamiltonianField`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2946)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidForce · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The relevant expressions are:

$$
F^k=-\partial U/\partial q^k,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidForce` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；rigidForce 对任意单体/固定其他变量后的势切片U:V→Mat3→ℝ、位置q和方向Θ，返回−grad(fun x=>U x Θ) q。逐坐标即−∂U/∂q\_i，方向及其他变量在求导中固定；不是独立给定的力公理。原书的k只是指定刚体指标，冻结其他体坐标即可应用此任意切片定义，不必假设势能无耦合。总fderiv在不可微函数上的约定不等于证明物理势可微，现明确记入注释。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidForce`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2986)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-MatrixRot · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> for a $`3\times3`$ matrix $`A`$, $`\operatorname{rot}(A)=\operatorname{skew}^{-1}(A-A^T)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def matrixRot (A : MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.matrixRot` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。skewMatrix(v)=[[0,-v₂,v₁],[v₂,0,-v₀],[-v₁,v₀,0]]。对 B=A−Aᵀ，skew 的逆为 (B₂₁,B₀₂,B₁₀)；展开后正是 Lean 三个坐标 (A₂₁−A₁₂,A₀₂−A₂₀,A₁₀−A₀₁)。没有额外 1/2，无新增假设。

### 7. 状态与证明位置

self-contained；`MD.Ch04.matrixRot`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2989)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidTorque · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $`\tau^k=-\operatorname{rot}(\Theta^{kT}\partial U/\partial\Theta^k)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidTorque` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；rigidTorque 的实矩阵梯度逐元素取真实fderiv，A=ΘᵀmatrixGrad(U q) Θ；matrixRot(A)=(A₃₂−A₂₃,A₁₃−A₃₁,A₂₁−A₁₂)，故正是原书skew⁻¹(A−Aᵀ)，外层负号正确。这里rot本身不带1/2；rbForm中另用1/2取斜对称矩阵的轴向量，不能混淆。任意势切片也能表示多体中固定其余变量后的第k个力矩，无须无耦合假设。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidTorque`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2992)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrinted · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> DLM Rigid Body Molecular Dynamics Step
> 1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$


> 2. “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$


> 3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.
$$


> 4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $`F^k`$ and torques $`\tau^k`$ evaluated at the current $`q,\Theta`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dlmPrinted (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)



/-- 修正版，对应原文 MD-4.4.2-DLMPrinted。改动：独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。 -/
```

独立修正版：

```lean
def dlmPrinted_corrected (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 原DLM完整算法的N=1实例；任意N耦合系统的原算法由MD-4.4.2-DLMPrintedSystem承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrinted`；`MD.Ch04.dlmPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留N=1字面算法作为单体实例；完整任意N、耦合势、逐阶段重算所有力矩的原算法已由DLMPrintedSystem覆盖，显式跨条目映射，不以单体冒充全系统。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。 | [EXTRA] |

[EXTRA] [EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。；[EXTRA] 保留N=1字面算法作为单体实例；完整任意N、耦合势、逐阶段重算所有力矩的原算法已由DLMPrintedSystem覆盖，显式跨条目映射，不以单体冒充全系统。；[ERRATUM?] 独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；按Printed的字面忠实性标准PASS，限明确声明的N=1实例。右侧先作用的复合依次是Kick(h/2)、Drift(1,h)、Spin(h)、Kick(h/2)，与原表顺序一致。printedSpinStep虽为函数复合，回文轴序使实际顺序仍为x半、y半、z全、y半、x半；每一步角度从当前s.1分量重新取值。动量用Rπ，方向用ΘRᵀ；最后Kick在更新后的q、Θ处重新求力和力矩。没有擅自加入质量因子或改正角。原书质量和符号疑点在json\_review标NEEDS\_HUMAN，不作为字面定义的FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dlmPrinted`：定义；`MD.Ch04.dlmPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2999)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMMassOnly · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Drift”: step forward a whole step in positions $`q^k:=q^k+hp^k`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dlmMassOnly (M : ℝ) (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)



/-- 修正版，对应原文 MD-4.4.2-DLMMassOnly。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def dlmMassOnly_corrected (M : ℝ) (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmMassOnly`；`MD.Ch04.dlmMassOnly_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]只将drift质量修为q+h p/M；仍保留原spin，不能据此称完整正确几何积分器。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]只将drift质量修为q+h p/M；仍保留原spin，不能据此称完整正确几何积分器。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。展开 rigidDrift M h 得 q+(h/M)p，并且 dlmMassOnly 是含两次 Kick 和五轴 Spin 的完整单体映射。所绑定原文却只有 Step 2 的 q+hp，既引入质量分母，又扩大对象到完整算法。[EXTRA] 描述的是修订算法而非额外数学假设，不能使陈述忠实于所引原句。质量修订有 PDF193 的 dq/dt=p/M 依据，但必须与原式分开；无论证明是否完成均属签名不一致。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dlmMassOnly`：定义；`MD.Ch04.dlmMassOnly_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3013)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DriftSpinCommute · unnumbered_claim · 印刷p.174 / PDFp.196

### 2. 原文陈述

> Note that the symmetric character of the algorithm could be revealed more clearly by dividing the “Drift” step into two half steps sandwiched around the Spin step (Kick, Drift, Spin, Drift, Kick), but as the updates Drift/Spin are decoupled, the order they are performed is not important.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem driftSpinCommute : ∀ M h (I : MolecularDynamics.Chapter04Review.V) (z : MolecularDynamics.Chapter04Review.RBState),
  MolecularDynamics.Chapter04Review.rigidDrift M h (z.1,printedSpinStep I h z.2)=
    ((MolecularDynamics.Chapter04Review.rigidDrift M h z).1,printedSpinStep I h (MolecularDynamics.Chapter04Review.rigidDrift M h z).2) := by
  intro M h I z
  rfl

theorem driftSpinCommute_halves (M h : ℝ) (I : MolecularDynamics.Chapter04Review.V)
    (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) :
    MolecularDynamics.Chapter04Review.rigidDrift M h=
      MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘ MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∧
    (MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘
      (fun z : MolecularDynamics.Chapter04Review.RBState ↦ (z.1,printedSpinStep I h z.2)) ∘
      MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2))=
    (MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘
      (fun z : MolecularDynamics.Chapter04Review.RBState ↦ (z.1,printedSpinStep I h z.2)) ∘
      MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.driftSpinCommute`；`MD.Ch04.driftSpinCommute_halves` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原交换性证明，并补漂移半步合成与完整Kick/Drift/Spin/Drift/Kick排列恒等式；M=1即字面原算法，新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原交换性证明，并补漂移半步合成与完整Kick/Drift/Spin/Drift/Kick排列恒等式；M=1即字面原算法，新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两个声明均已审校。driftSpinCommute 对任意实M,h、I和全状态z给出Drift∘Spin=Spin∘Drift的全状态等式：Drift只改变q，Spin只改变(π,Θ)。driftSpinCommute\_halves同时给出两个半步drift合成一步，以及含两端Kick的K(h/2)∘S(h)∘D(h)∘K(h/2)=K(h/2)∘D(h/2)∘S(h)∘D(h/2)∘K(h/2)。角度仍用整个spin步h，未误减半。M=1正是原印算法，任意M的代数推广不依赖旋转符号勘误；sorry不构成签名FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch04.driftSpinCommute`：已证；`MD.Ch04.driftSpinCommute_halves`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3026)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMStructureFormal · unnumbered_claim · 印刷p.173–174 / PDFp.195–196

### 2. 原文陈述

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dlmStructure :
  ∀ M (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h) ∧ ∀ z : MolecularDynamics.Chapter04Review.RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      MolecularDynamics.Chapter04Review.dlmMassConsistent M I U (-h) (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z)=z ∧
      (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2ᵀ*(MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2=1 := by
  sorry



/-- 修正版，对应原文 MD-4.4.2-DLMStructureFormal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem dlmStructure_corrected :
  ∀ M (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h) ∧ ∀ z : MolecularDynamics.Chapter04Review.RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      MolecularDynamics.Chapter04Review.dlmMassConsistent M I U (-h) (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z)=z ∧
      (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2ᵀ*(MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2=1 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmStructure`；`MD.Ch04.dlmStructure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。rbTangent(z,v) 为 ΘᵀδΘ+δΘᵀΘ=0；rbForm 用 ξ=rot(ΘᵀδΘ)/2、η=rot(Θᵀδ′Θ)/2，取 δq·δ′p−δ′q·δp+ξ·δ′π−η·δπ+π·(ξ×η)。rbSymplectic 量化所有满足 ΘᵀΘ=1、det Θ=1 的输入和两个实际切向量，要求真实 fderiv 的两形式拉回等式；它本身未要求输出 SO(3) 或输出导数切向性，不能仅凭谓词名字推断这些结论。axisRotation 的 x 轴矩阵为 [[1,0,0],[0,cos φ,−sin φ],[0,sin φ,cos φ]]，y、z 为对应标准主动旋转。spinAxis 每次由当前 π\_i 计算 φ=hπ\_i/I\_i，更新 (Rπ,ΘRᵀ)；spinStep 的函数复合从右向左执行 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。rigidKick 同时以 −grad U 和 −rot(ΘᵀmatrixGrad U) 更新两种动量；rigidDrift 使用 q+h p/M；dlmMassConsistent 是半 kick、drift、spin、半 kick。签名量词为任意正 M、正主惯性 I、C³ 单体势 U、任意 h；另对每个 SO(3) 输入要求逆步复合为恒等及输出正交性。正质量和正惯性合理，C³ 是较强但合理的技术资格；回逆与正交性是原引用句以外的算法性质，不应当作该句逐字结论。该对象是质量修订的 N=1 实例，而原文为全部刚体、可耦合势的完整系统；[EXTRA] 明示单体并不能补足原结论。签名中的质量一致也只修订 drift，spin 仍是印刷正角，名称不能当作精确原动力学流的证据。正角子步可看作负旋转动能的 Hamilton 子流，因此与原方程符号不符本身不反证辛性。此 FAIL 针对原文对象范围与陈述对应，而非由 sorry 推断数学命题为假。实际证明体含 sorry，独立于签名审计。

### 7. 状态与证明位置

incomplete；`MD.Ch04.dlmStructure`：未证（原书疑误不证）；`MD.Ch04.dlmStructure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3047)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrintedStructure · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dlmPrintedStructure : ∀ (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (dlmPrinted I U h) := by
    sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅N=1字面算法两形式拉回等式；原全系统含SO(3)域的结构断言由MD-4.4.2-DLMPrintedSystemStructure承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrintedStructure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅为字面单体辛性实例；原句任意N耦合算法与输入/输出SO(3)域由DLMPrintedSystemStructure承担，不再把rbSymplectic名字当作完整输出约束。 | [EXTRA] |

[EXTRA] 明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。；[EXTRA] 本条仅为字面单体辛性实例；原句任意N耦合算法与输入/输出SO(3)域由DLMPrintedSystemStructure承担，不再把rbSymplectic名字当作完整输出约束。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；就明确限定的N=1两形式拉回等式PASS。定理量化所有I、U，在逐项正惯性与联合C³势前提下，对任意实h断言实际dlmPrinted映射满足rbSymplectic。已展开该谓词：初态ΘᵀΘ=1且detΘ=1，对任意满足ΘᵀδΘ+δΘᵀΘ=0的u,v，实际fderiv像上的rbForm等于输入rbForm；并非只检查一个叫symplectic的标签。rbForm中的1/2·matrixRot给出正确体坐标切向量，叉积项符号与标准刚体余切形式一致。正角Printed spin对应负旋转动能子流，符号疑点不破坏子步的辛性，因此不能据条目10的物理一致性疑点把此签名判为假。

### 7. 状态与证明位置

incomplete；`MD.Ch04.dlmPrintedStructure`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3075)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemState · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> Procedures given below for rigid body $`k`$ are meant to be performed for all rigid bodies in the system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
@[reducible] def rigidSystemState (N : ℕ) := Fin N → MolecularDynamics.Chapter04Review.RBState
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemState` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。 | [EXTRA] |

[EXTRA] [EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。Fin N→RBState 确实为所有刚体同时保存 q、p、π、Θ；N 任意自然数，允许 N=0 是无害的空系统推广。[EXTRA] 是透明表示选择，并未强迫 U 为独立势。这里是承载状态的环境空间，不是 SO(3) 合法态子类型；原文旋转矩阵约束需在使用该状态的几何断言中施加，不能宣称这个类型自动满足它。作为本条“所有刚体执行”的状态表示忠实；无证明义务、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemState`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3082)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemForce · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The relevant expressions are:

$$
F^k=-\frac{\partial U}{\partial q^k},
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemForce` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；签名和定义体忠实于F^k = −∂U/∂q^k。V = Fin 3 → ℝ，Mat3 = Matrix (Fin 3) (Fin 3) ℝ；结果为三维力。对任意N、输入状态z和k，切片x ↦ U(update q k x) Θ在当前q^k处求负梯度，允许U耦合所有刚体，未将U替换为逐体可分势，也未改变或冻结其他刚体的当前状态。没有额外Lean前提或被遗漏的定理结论；这是一个定义。fderiv总化所带来的域外取值只作为形式定义的延拓，不据此宣称不可微势具有物理力。原文句末逗号属JSON摘录问题，不构成Lean签名FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemForce`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3085)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemTorque · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $`\tau^k=-\operatorname{rot}([\Theta^k]^T\partial U/\partial\Theta^k)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemTorque` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐项核对通过。N为自然数，k取Fin N，U为完整位置/方向数组上的实值耦合势，输出为V。矩阵切片A ↦ U(q, update Θ k A)只改变第k个方向矩阵，在当前Θ^k处求matrixGrad，再左乘(Θ^k)^T并施加外层负matrixRot；所有位置及其余方向均保持当前状态。Fin 3从0起编号，所给三个反对称差分正对应原书从1起编号的(A32−A23,A13−A31,A21−A12)。未误加1/2、未交换乘法次序、未用当前角动量代替方向矩阵；无额外前提或结论。与原书导数的数学对应在相应切片可微处读取，fderiv的总化规则并非新增物理断言。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemTorque`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3091)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemKick · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemKick` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；签名及完整输出通过。N、U与前两项相同，新增实数子步参数和整个N体状态输入/输出；没有隐含的逐体顺序更新。q=(z k).1.1与Θ=(z k).2.2保持，p与π分别加相同子步长度乘当前力及力矩。源文h表示整体步长，Lean中同名局部参数表示子步时长；已给context\_notation说明且dlmPrintedSystem实际传入h/2，因此不存在半步遗漏或两倍系数错误。参数重命名属于记号对应，不是额外物理假设。没有新增前提或超出定义的定理结论。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemKick`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3098)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemDriftPrinted · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemDriftPrinted {N : ℕ} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemDriftPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。对所有 k 更新 q\_k+h p\_k，保持 p、π、Θ；与 PDF196 第2步字面完全一致。[ERRATUM?] 有依据：p 在 PDF195 被定义为线动量；由质心动能 p²/(2M\_k) 得 dq/dt=p/M\_k，故一般质量应为 q+h p/M\_k。例 M\_k=2、p=e₁、h=1，原表给位移 e₁，物理平移流给 e₁/2。定义明确是 Printed 且保留疑误，不静默修改，所以签名忠实于印刷式，PASS 不代表原算法对任意质量动力学一致。无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemDriftPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3106)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemSpinPrinted · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemSpinPrinted {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemSpinPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。axisRotation 的 x 轴矩阵为 [[1,0,0],[0,cos φ,−sin φ],[0,sin φ,cos φ]]，y、z 为对应标准主动旋转。spinAxis 每次由当前 π\_i 计算 φ=hπ\_i/I\_i，更新 (Rπ,ΘRᵀ)；spinStep 的函数复合从右向左执行 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。MD.Ch04.printedSpinStep 与依赖展开的 spinStep 同式；每体调用 I k，可有不同主惯性，各子步用已更新动量。保持 q,p，按表更新 π,Θ，全部五子步均包含。[ERRATUM?] 成立：i=x、I₁=1、π=(1,1,0)、Θ=1 时，正角旋转的初始 π 导数为 (0,0,1)，而 π×(π₁e₁/I₁)=(0,0,−1)；Θ 导数也为 −Θ skew(π₁e₁/I₁)，与 PDF195 的恢复方程反号。这不妨碍它是印刷表的忠实定义，也不单独否定辛性。未冒充精确原 Euler 子流，无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemSpinPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3111)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrintedSystem · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> DLM Rigid Body Molecular Dynamics Step
> 1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$


> 2. “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$


> 3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$


> 4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $`F^k`$ and torques $`\tau^k`$ evaluated at the current $`q,\Theta`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)



/-- 修正版，对应原文 MD-4.4.2-DLMPrintedSystem。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def dlmPrintedSystem_corrected {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrintedSystem`；`MD.Ch04.dlmPrintedSystem_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；字面忠实性核对通过，未发现应判FAIL的Lean语义偏差：Drift确为q+h p，未私补质量；Spin保留正角及配对的Rπ、ΘRᵀ，矩阵乘法方向正确。每个子步从其输入重新计算角度，不冻结初始π；所有刚体均执行。两次kick分别从各自输入完整状态计算耦合力/力矩，末kick使用Drift/Spin后的全部q、Θ，不复用旧力。定义域包括N : ℕ、逐体三维惯性I、任意实数h及任意所给U；定义无I>0或光滑性前提，这些物理资格不能假称已在定义中。总体NEEDS\_HUMAN仅依任务对原书数学疑点的分流规则：质量归一化及旋转动力学约定待确认。Printed版忠实，故不判FAIL；质量/旋转方向疑点也不是不辛反例。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dlmPrintedSystem`：定义；`MD.Ch04.dlmPrintedSystem_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3118)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-SystemDriftSpinCommute · unnumbered_claim · 印刷p.174 / PDFp.196

### 2. 原文陈述

> as the updates Drift/Spin are decoupled, the order they are performed is not important.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem systemDriftSpinCommute : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V) h (z : rigidSystemState N),
    rigidSystemDriftPrinted h (rigidSystemSpinPrinted I h z)=
      rigidSystemSpinPrinted I h (rigidSystemDriftPrinted h z) := by
  intro N I h z
  rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.systemDriftSpinCommute` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开Ch04.lean:1860、1884–1891的rigidSystemState、rigidSystemDriftPrinted和rigidSystemSpinPrinted，以及1739–1747的printedSpinAxis/printedSpinStep；正式库V、Mat3及RBState的实际定义已在Ch04\_deps.txt的-- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean中读到。全状态每体为((q,p),(π,Θ))。drift把(q,p)改为(q+h p,p)，完整保持(π,Θ)；spin完整保持(q,p)，其R角度只依赖当前π、该体I及h，输出(Rπ,ΘR^T)的五步组合，不读取q或p。两种复合逐体均为((q+h p,p),printedSpinStep(I\_k,h,(π,Θ)))，故原文的“decoupled”被表达为真正全N体函数值相等。量词∀N、∀I、∀h、∀z没有偷加独立势或N=1限制，也没有交换依赖全体构型的kick；无需惯性正性、SO(3)或势能正则性才能成立，因为该等式是分量独立性的恒等式。质量与Spin符号的印刷问题也不影响此交换性。Ch04.lean:1902–1907实际证明为intro N I h z; rfl，无sorry；签名忠实与该现有证明的状态分别核对。

### 7. 状态与证明位置

self-contained；`MD.Ch04.systemDriftSpinCommute`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3134)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemSymplectic · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅全系统辛性辅助谓词定义；原文算法性质由MD-4.4.2-DLMPrintedSystemStructure承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅定义全系统受约束两形式拉回性质，原句算法确实满足该性质由已有DLMPrintedSystemStructure断言，区分性质定义与算法定理。 | [EXTRA] |

[EXTRA] [EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。；[EXTRA] 本条仅定义全系统受约束两形式拉回性质，原句算法确实满足该性质由已有DLMPrintedSystemStructure断言，区分性质定义与算法定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；在输入明确限定的“辅助谓词定义”范围内PASS，不把def当作原句算法定理。参数为任意全系统映射G；对所有输入z，全部k的ΘᵀΘ=1及detΘ=1作为蕴含前件，结论明确包含全部输出SO(3)约束。随后量化完整u、v，分别要求每体rbTangent，再比较∑k rbForm(Gz\_k,(DG\_z u)_k,(DG\_z v)_k)与∑k rbForm(z\_k,u\_k,v\_k)。DG是整个G在整个z上的fderiv，故保留所有跨体耦合导数，未偷换为逐体局部导数。rbForm包含dq·δp−δq·dp及ξ·δπ−η·dπ+π·(ξ×η)；ξ、η中的1/2正确地抵消matrixRot对反对称矩阵的倍数。已列[EXTRA]准确揭示SO(3)、实际切向量、有限和与真实导数的形式化内容，没有以假设辛性替代结论。定义未单独断言G光滑或全局可逆，按既定scope只把它当作约束保持及拉回性质；实际算法性质仍须由条目6的theorem承担。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemSymplectic`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3143)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrintedSystemStructure · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dlmPrintedSystemStructure : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
  sorry



/-- 修正版，对应原文 MD-4.4.2-DLMPrintedSystemStructure。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem dlmPrintedSystemStructure_corrected : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrintedSystemStructure`；`MD.Ch04.dlmPrintedSystemStructure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；签名的字面忠实性核对通过。全部对象、域、量词及两个实质前提与给定定义相容：任意有限N体、逐体正主惯性矩、联合全局C³耦合势、任意实h。结论是该具体完整Printed组合对每一个SO(3)输入保持SO(3)输出，并对任意两条全系统切向量保持∑rbForm的真实Fréchet拉回；没有缩为单体、没有遗漏末次力/力矩重算、没有以预设辛性或抽象占位形式替换目标。正惯性和全环境全局C³属于显式[EXTRA]限缩，已细化披露。原句的可靠性解释不是额外定量定理，未形式化为误差界不构成结论遗漏。theorem中sorry仅表示证明未交付，不作为FAIL理由，本轮也不声称Lean证明已完成。总体NEEDS\_HUMAN依任务对原书质量及Spin动力学约定疑点的保留规则；这与签名忠实性通过并存。特别是无质量Drift及正角配对Spin本身都不能推出映射不辛，未据此提出辛性反例。

### 7. 状态与证明位置

incomplete；`MD.Ch04.dlmPrintedSystemStructure`：未证（原书疑误不证）；`MD.Ch04.dlmPrintedSystemStructure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3153)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-ExactPlanarRotation · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactPlanarRotation : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  sorry



/-- 修正版，对应原文 MD-4.4.1-ExactPlanarRotation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem exactPlanarRotation_corrected : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.exactPlanarRotation`；`MD.Ch04.exactPlanarRotation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；依赖已展开：Ch04\_deps.txt中MolecularDynamics/Chapter04/ReviewDefinitions.lean的V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)。axisRotation的三分支分别是主动Rx=[[1,0,0],[0,cosφ,−sinφ],[0,sinφ,cosφ]]、Ry=[[cosφ,0,sinφ],[0,1,0],[−sinφ,0,cosφ]]、Rz=[[cosφ,−sinφ,0],[sinφ,cosφ,0],[0,0,1]]。Pi.single i a在i处为a，其余处为0；矩阵*ᵥ为逐行点积，HasDerivAt断言实际实参数向量导数。量词为任意I、初值π、轴i，在0<I\_i下，所有实t；γ(t)=R\_i(−tπ\_i/I\_i)π。旋转固定第i分量并在t=0为恒等，导数为−(π\_i/I\_i)e\_i×γ=γ×e\_i(γ\_i/I\_i)，因此该签名完整表达了预期主轴子场的精确平面旋转，三个结论均正确；不需要其它轴惯量的正性，选中惯量正性符合物理背景但数学上非零已足够。[EXTRA]负角是该主动矩阵与(4.41)叉积方向下必要的符号选择，并未将p.174正角算法替代为正确精确流。[EXTRA]把第二、第三子场的无下标π解释为π₂/π₃合理且符合p.172对角惯量分裂，但原页字面第二、第三式把向量π放在单个标量分量中，含义未定义；无法对原样展示公式无条件给PASS。需人工确认原书缺下标及T\_i与I\_i的意图；这是原文数学含义问题，不是缺库定义。[ERRATUM?]本条无独立该标签，所涉及缺下标确实存在；正角方向疑点由以上导数支持。签名语义与证明完成度分开：实际exactPlanarRotation的证明体为sorry，本次未写证明、未声称Lean已验证此结论。

### 7. 状态与证明位置

incomplete；`MD.Ch04.exactPlanarRotation`：未证（原书疑误不证）；`MD.Ch04.exactPlanarRotation_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L3175)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

