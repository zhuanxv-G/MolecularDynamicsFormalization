[上一部分](part03.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## 1. MD-4.3-FlexiblePendulumHamiltonian · definition · 印刷p.150 / PDFp.172

### 2. 原文陈述

> We suppose the restraint to have an associated coefficient $`k=\varepsilon^{-1}`$, where $`\varepsilon`$ is a small parameter. Then we have a generalized flexible pendulum with Hamiltonian $`H=\|p\|^2/(2m)+U(q)+\varepsilon^{-1}(\|q\|-r_0)^2/2`$ (see the left panel of Fig. 4.4).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.flexiblePendulumHamiltonian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Position 3按附件定义为EuclideanSpace ℝ (Fin 3)，所以动量和位置均用欧氏范数。z.1是q、z.2是p，动能分母2m、势能U(q)、弹簧项ε⁻¹(‖q‖−r₀)²/2均正确。作为总化的数值表达式定义可接受所有实参数；物理使用应限m>0、ε>0及通常r₀>0，此定义未宣称零参数也构成物理模型。

### 7. 状态与证明位置

self-contained；`MD.Ch04.flexiblePendulumHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1045)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-RestraintPotential · definition · 印刷p.150 / PDFp.172

### 2. 原文陈述

> where the restraint potential $`\varphi_\varepsilon(q)=\varepsilon^{-1}(\|q\|-r_0)^2/2`$ has associated restoring force

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def restraintPotential (ε r₀ : ℝ) (q : Position 3) : ℝ :=
  ε⁻¹*(‖q‖-r₀)^2/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.restraintPotential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:636–637；Position 3 展开为 EuclideanSpace ℝ (Fin 3)，势为 ε⁻¹(‖q‖−r₀)²/2，与 PDF172 相同。这里只定义函数，未宣称在 q=0 可微或光滑；无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.restraintPotential`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1050)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-RestraintForcePrinted · unnumbered_claim · 印刷p.150 / PDFp.172

### 2. 原文陈述


$$
F_\varepsilon=-\nabla\varphi_\varepsilon(q)=\varphi_\varepsilon(q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem restraintForcePrinted :
    ∀ ε r₀ : ℝ, ∀ q : Position 3,
      -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q =
       gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q := by
  sorry



/-- 修正版，对应原文 MD-4.3-RestraintForcePrinted。改动：独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。 -/
```

独立修正版：

```lean
def restraintForcePrinted_corrected (ε r₀ : ℝ) (_hε : 0 < ε) (q : Position 3) : Position 3 :=
  -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.restraintForcePrinted`；`MD.Ch04.restraintForcePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将prime暂按配置梯度解释；该记号解释待审。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。 | [EXTRA] |

[EXTRA] [EXTRA]将prime暂按配置梯度解释；该记号解释待审。；[ERRATUM?] 独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Ch04.lean:642–647 实际量化所有 ε,r₀,q 并断言 −gradient φ q = gradient φ q。原 PDF172 的末项是 φε(q)，没有 prime，且 φ 为标量、力为向量，原书确有类型疑误。[EXTRA] 把 prime 解释为配置梯度既无原文依据，也产生错误等式。[ERRATUM?] 应改为原书的标量势/向量力疑误，不能把缺失的 prime 当成原书问题。Position 是欧氏空间；gradient 为真实总梯度，光滑点不是任意符号。该声明另有 sorry，但 FAIL 来自签名。

### 7. 状态与证明位置

incomplete；`MD.Ch04.restraintForcePrinted`：未证（原书疑误不证）；`MD.Ch04.restraintForcePrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1057)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstrainedPendulum · definition · 印刷p.151 / PDFp.173

### 2. 原文陈述

> The equations of motion for the constrained system take the form

$$
\dot q=v,\qquad\dot v=-\nabla U(q)-q\lambda,\qquad0=\|q\|^2-r_0^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0



/-- 修正版，对应原文 MD-4.3-ConstrainedPendulum。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def constrainedPendulum_corrected (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedPendulum`；`MD.Ch04.constrainedPendulum_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。；[EXTRA] 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；按本页字面三个方程核对：真实欧氏q,v曲线，q′=v、v′=−gradient U−λq、‖q‖²−r₀²=0，开I使within导数等同普通导数，均忠实。原前页仍保留一般质量m，本页加速度式未说明单位质量或势的重新归一化；把因子2吸收到λ可行，但吸收质量不能同时消除势力中的1/m。另U未附可微资格，gradient作为标准总化算子时，只有可微U才是经典势力语义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedPendulum`：定义；`MD.Ch04.constrainedPendulum_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1073)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintCurvature · definition · 印刷p.153 / PDFp.175

### 2. 原文陈述

> where $`\varphi`$ is an $`l`$-dimensional vector whose $`k`$th component is

$$
\varphi_k=p(t)^TM^{-1}\nabla_q^2g_k(q(t))M^{-1}p(t).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def constraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintCurvature` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:657–661；textbookInverseMassMatrix 展开为 diagonal (fun i => (m i)⁻¹)。因此每分量是 D²γ\_j(q)[M⁻¹p,M⁻¹p]，正是 pᵀM⁻¹ Hessian(γ\_j) M⁻¹p（对角质量矩阵对称）。Fin Mc 表示 l 个分量，q,p 为当前时间切片。Pi 的范数不影响有限维坐标导数及此双线性计算，未使用错误的径向 Pi 范数。fderiv 是总操作；这一定义不声称非光滑约束也具有经典 Hessian。无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintCurvature`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1089)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ReactionMultiplier · definition · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Using (4.8) in (4.10) we obtain

$$
g'(q)M^{-1}[F-g'(q)^T\lambda]+\varphi\equiv0.
$$


> This is a system of linear equations for $`\lambda`$. Assuming $`g'(q)M^{-1}g'(q)^T`$ is invertible, we may solve for $`\lambda`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def reactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | [EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.reactionMultiplier` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] [EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 不将无条件总化定义报告成唯一求解结论。 | [EXTRA] |

[EXTRA] [EXTRA] [EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 不将无条件总化定义报告成唯一求解结论。

### 6. 审计结论

本轮修复：[EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 不将无条件总化定义报告成唯一求解结论。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；reactionMultiplier给出的逆Gram公式代数符号、各域及曲率二阶导数正确，但这是对任意m、γ、q,p,F总化的函数定义。本条statement\_scope仍声称覆盖所引全部原句，而本条同source\_id并没有det≠0条件下满足线性方程或唯一可解的命题。其它条目的reactionBalance及gramInvertible\_multiplier可补这一逻辑内容，但不能冒充本条定义本身已含条件性求解结论。

### 7. 状态与证明位置

self-contained；`MD.Ch04.reactionMultiplier`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1096)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ReactionBalance · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Using (4.8) in (4.10) we obtain

$$
g'(q)M^{-1}[F-g'(q)^T\lambda]+\varphi\equiv0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reactionBalance {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (F q - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookConstrainedReactionMultiplier m γ F q p)) +
        textbookConstraintCurvature m γ q p = 0 := by
  apply MolecularDynamics.textbookConstrainedReaction_balance <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.reactionBalance` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。 | [EXTRA] |

[EXTRA] 真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对所有有限维m、γ、F,q,p，在真实Gram行列式非零条件下断言由逆Gram构造的乘子使G M⁻¹(F−Gᵀλ)+φ=0。φ由实际迭代Fréchet二阶导数沿v=M⁻¹p两次评价，次序无误。此命题是代数平衡，不宣称任意非光滑γ也具有经典Hessian；用于机械系统时再取光滑约束。一般F推广已标明，F=−grad U可实例化。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.reactionBalance`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1105)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-GramPositive · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Assuming $`g'(q)M^{-1}g'(q)^T`$ is invertible, we may solve for $`\lambda`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gramPositive {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef := by
  apply MolecularDynamics.textbookConstraintGram_posDef <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅约束Gram正定的EXTRA充分条件辅助；原句解乘子由MD-4.3-GramInvertible承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.gramPositive` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。 | [EXTRA] |

[EXTRA] [EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。；[EXTRA] 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限Nc,Mc，严格正的每个质量以及真实梯度族的实线性独立，推出G diag(m⁻¹) Gᵀ正定。对于非零a，二次型为Σ\_i m\_i⁻¹(Σ\_j a\_j G\_ji)²，独立性保证至少一项非零；这验证充分条件，不把正定当作前提。statement\_scope已明确仅为EXTRA辅助；原句乘子可解内容由第16条单独完整承担。零维情形与标准正定语义相容。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.gramPositive`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1116)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-GramInvertible · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Assuming $`g'(q)M^{-1}g'(q)^T`$ is invertible, we may solve for $`\lambda`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gramInvertible {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).det ≠ 0 := by
  apply MolecularDynamics.textbookConstraintGram_det_ne_zero <;> assumption

theorem gramInvertible_multiplier (n l : ℕ) (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q F : MolecularDynamics.Chapter04Review.Q n) (φ : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    (∃! lam : MolecularDynamics.Chapter04Review.Q l,
      textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ∧
    (∀ lam : MolecularDynamics.Chapter04Review.Q l,
      (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ↔
      lam=(textbookConstraintGram m g q)⁻¹ *ᵥ
        (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m F+φ)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.gramInvertible`；`MD.Ch04.gramInvertible_multiplier` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]质量正及梯度独立推出真实Gram det≠0；不是将该结论作为前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。 | [EXTRA] |

[EXTRA] [EXTRA]质量正及梯度独立推出真实Gram det≠0；不是将该结论作为前提。；[EXTRA] 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；gramInvertible由正质量和真实梯度独立推出实际Gram det≠0；multiplier在原本的det≠0前提下，对任意维数及给定q,F,φ同时给出存在唯一λ与所有λ的方程↔逆Gram公式。invMass与实际对角逆质量矩阵相同，线性方程整理为Gram λ=G m⁻¹F+φ，正负号及转置正确。F、φ作为给定右端数据而非所求解，不要求把λ存在作为假设；未因sorry判失败。

### 7. 状态与证明位置

incomplete；`MD.Ch04.gramInvertible`：已证；`MD.Ch04.gramInvertible_multiplier`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1126)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-CotangentInvariant · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Reinserting this expression for $`\lambda`$ into (4.8) then gives a system of ordinary differential equations whose solutions, starting from a point on $`T^*\mathcal M`$, will remain on $`T^*\mathcal M`$ for all time. The co-tangent bundle becomes an invariant manifold of this ODE system. $`\lambda`$ is defined at any time by the physical variables $`q`$ and $`p`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentInvariant {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (F : (Fin Nc → ℝ) → Fin Nc → ℝ) (q p : ℝ → Fin Nc → ℝ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q t)))
    (hq : ∀ t ∈ Icc 0 τ, HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) (Icc 0 τ) t)
    (hp : ∀ t ∈ Icc 0 τ, HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) (Icc 0 τ) t)
    (hpos₀ : ∀ j, γ j (q 0) = 0)
    (hhidden₀ : ∀ j, (fderiv ℝ (γ j) (q 0)) (textbookInverseMassMatrix m *ᵥ p 0) = 0) :
    ∀ t ∈ Icc 0 τ, ∀ j, γ j (q t) = 0 ∧
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 := by
  apply MolecularDynamics.textbookConstrainedODE_cotangent_invariant_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定闭区间实际ODE解、C²约束、正质量及沿解梯度独立；“for all time”仅在实际解定义区间，不声称任意长时域解存在。 | [EXTRA] |

[EXTRA] 给定闭区间实际ODE解、C²约束、正质量及沿解梯度独立；“for all time”仅在实际解定义区间，不声称任意长时域解存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；在给定实际q,p曲线的Icc 0 τ上，正质量、每个约束C²、沿解梯度独立保证Gram可逆；hq和hp是代入实际逆Gram乘子的ODE，初始位置约束与隐藏约束分别显式给定。结论对每个区间时刻及每个约束同时保持两条件，恰为该余切集合不变性。τ<0时区间空而结论真，τ=0由初值，均无反例。仅在给定解存在区间断言保持是合理的for all time解释，不声称全局解存在；F不必保守，作为更一般力的推广应补标EXTRA。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentInvariant`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1149)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ReducedFieldRegularity · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Reinserting this expression for $`\lambda`$ into (4.8) then gives a system of ordinary differential equations

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reducedFieldRegularity
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (z : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) z.1)) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z := by
  apply MolecularDynamics.contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.reducedFieldRegularity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C³约束/C¹位置力、质量正、真实梯度独立给局部C¹场；是隐含正则性的独立补充，不冒充构造流存在。 | [EXTRA] |

[EXTRA] [EXTRA]C³约束/C¹位置力、质量正、真实梯度独立给局部C¹场；是隐含正则性的独立补充，不冒充构造流存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意自然数 Nc、Mc，质量 m:Fin Nc→ℝ、Mc 个实值位置约束 γ、势 U 及相点 z=(q,p)，前提为逐项正质量、U 全局 C²、γ\_j 全局 C³，以及真实坐标梯度在 q 处线性独立；结论恰为代入反作用乘子后的相空间向量场在 z 处 C¹。所给依赖将逆质量实现为 diag(1/m\_i)，Jacobian 的第 j 行实现为 Dγ\_j，Gram 为 GM^{-1}G^T，曲率为 D²γ\_j[M^{-1}p,M^{-1}p]，乘子为 Gram^{-1}(GM^{-1}F+φ)，动量分量为 F−G^Tλ，符号及对象相符。上述正则性和质量/独立性均有 [EXTRA] 说明，确保局部逆矩阵有意义；本定理是所引 ODE 构造的局部正则性补充，没有声称已构造流、证明约束不变或证明全时存在。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.reducedFieldRegularity`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1166)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-RestrictedForm · definition · 印刷p.153 / PDFp.175

### 2. 原文陈述

> The simplifying concept that we exploit is that the symplectic $`2`$-form in the ambient space can be projected to the co-tangent bundle to define an associated symplectic form on the manifold.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def restrictedForm {n : ℕ} (chart : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (z u v : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)

theorem restrictedForm_nondegenerate (n l : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (z : MolecularDynamics.Chapter04Review.Z n)
    (_hz : ∀ j, g j z.1=0)
    (_hp : textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0)
    (_hind : LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1)) :
    let c := fun w : MolecularDynamics.Chapter04Review.Z n ↦
      ((fun j ↦ g j w.1), textbookConstraintJacobian g w.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m w.2)
    let T := (fderiv ℝ c z).ker
    ∀ u ∈ T, (∀ v ∈ T, MolecularDynamics.Chapter04Review.phaseForm u v=0) → u=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.restrictedForm`；`MD.Ch04.restrictedForm_nondegenerate` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。 | [EXTRA] |

[EXTRA] [EXTRA] 保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；restrictedForm 对任意 n、chart:Z n→Z n 及 z,u,v 定义 B(Dchart(z)u,Dchart(z)v)，输出实数；这是一般形式表达式，定义可总化，不暗含 chart 是坐标图、浸入或辛映射。补充定理对任意 n,l,m,g,z，在 m\_i>0、g\_j∈C²、g(z.q)=0、G(z.q)M^{-1}z.p=0、真实约束梯度独立的前提下，令 T=ker Dc(z)，完整结论为每个 u∈T 若与全部 v∈T 的标准二形式配对均为零，则 u=0。该结论是限制形式的非退化，量词次序和两个实际约束均正确。正质量与梯度独立使 GM^{-1}G^T 可逆，正是这一限制非退化的充分资格。一般拉回与实际切空间非退化分别陈述是合理的代数表述；不额外宣称抽象流形、闭性或任意 chart 的非退化已经由此定义构造。sorry 不影响本次签名结论。

### 7. 状态与证明位置

incomplete；`MD.Ch04.restrictedForm`：定义；`MD.Ch04.restrictedForm_nondegenerate`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1176)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-VariationalFormula · unnumbered_claim · 印刷p.154 / PDFp.176

### 2. 原文陈述

> Next, we interchange time derivatives and differentials, and use the chain rule to write

$$
\frac{\mathrm d}{\mathrm dt}\mathrm dq=M^{-1}\mathrm dp,\tag{4.11}
$$



$$
\frac{\mathrm d}{\mathrm dt}\mathrm dp=-U''(q)\mathrm dq-\sum_{k=1}^l[(\mathrm d\lambda_k)\nabla g_k(q)+\lambda_kg_k''\mathrm dq],\tag{4.12}
$$



$$
0=g_j'(q)\mathrm dq,\quad j=1,2,\ldots,l,\tag{4.13}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem variational :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry

theorem variational_constraints :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    ∀ (c : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ),
    c t=z → HasDerivAt c v t →
    (∀ᶠ s in 𝓝 t, ∀ j, g j (c s).1=0) →
    (∀ j, (fderiv ℝ (g j) z.1) v.1=0) ∧
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.variational`；`MD.Ch04.variational_constraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际Fréchet变分场：U/g C²、乘子ρ(z)可微；切向dg=0由tangentPhase/拉回消去条另保留，不把它漏掉或作无条件全空间结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。 | [EXTRA] |

[EXTRA] 实际Fréchet变分场：U/g C²、乘子ρ(z)可微；切向dg=0由tangentPhase/拉回消去条另保留，不把它漏掉或作无条件全空间结论。；[EXTRA] 保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两条声明均量化 n,l、对角质量 m、势 U、l 个约束 g、状态依赖乘子 rho、相点 z 与方向 v。U/g 的 C² 和 rho 在 z 可微保证实际场 X(q,p)=(M^{-1}p,−∇U(q)−G(q)^Tρ(q,p)) 可微。结论的第一分量为 M^{-1}v\_p，第二分量为 −D∇U(q)v\_q−Σ\_j[(Dρ(z)v)_j∇g\_j(q)+ρ\_j(z)D∇g\_j(q)v\_q]；每个求和域、方向、符号及乘子微分均与 (4.11)–(4.12) 的链式法则内容对应。variational 本身没有无条件声称 Gv\_q=0；variational\_constraints 通过 c(t)=z、HasDerivAt c v t 和邻域内 g\_j((c s).q)=0，另得 ∀j,Dg\_j(q)v\_q=0，并与相同的完整场导数公式合取，覆盖 (4.13)。质量只出现在固定线性映射中，代数导数公式无需再假设正质量。此为变分方程的场导数表述，未额外声称构造了随时间的变分解。

### 7. 状态与证明位置

incomplete；`MD.Ch04.variational`：未证（缺大型理论）；`MD.Ch04.variational_constraints`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1194)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-HessianPullbackCancel · unnumbered_claim · 印刷p.155 / PDFp.177

### 2. 原文陈述

> This follows from the antisymmetry of the wedge product $`(\mathrm dx\wedge\mathrm dy=-\mathrm dy\wedge\mathrm dx)`$, and the fact that the Hessian matrix of $`U`$ is symmetric. Next, note that

$$
\sum_{i=1}^{N_c}\sum_{k=1}^{l}\mathrm dq_i\wedge\lambda_k\sum_{j=1}^{N_c}(g_k^{\prime\prime})_{ij}\mathrm dq_j=\sum_{k=1}^{l}\lambda_k\sum_{i=1}^{N_c}\mathrm dq_i\wedge\sum_{j=1}^{N_c}(g_k^{\prime\prime})_{ij}\mathrm dq_j=0,
$$


> by the same reasoning, since each of $`g_k^{\prime\prime}`$ is a symmetric matrix. Finally

$$
\sum_{i=1}^{N_c}\sum_{k=1}^{l}[\mathrm dq_i\wedge(\mathrm d\lambda_k)g_{ki}^{\prime}=\sum_{k=1}^{l}\left(\sum_{i=1}^{N_c}g_{ki}^{\prime}\mathrm dq_i\right)\wedge\mathrm d\lambda_k=\sum_{k=1}^{l}\mathrm dg_k\wedge\mathrm d\lambda_k=0,
$$


> since we know that $`\mathrm dg_k=0`$ from (4.13). Therefore

$$
\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^{N_c}\mathrm dq_i\wedge\mathrm dp_i=0.
$$



### 3. 原文证明

原书无独立完整证明。
原页给出逐项消去推导，并由 Leibniz 规则得到完整二形式的时间导数为零；不是单列编号定理。原书 Finally 后首个双重求和有未闭合的排印方括号，本摘录按原页保留。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hessianPullbackCancel {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (ρ : Fin Mc → E → ℝ) (q : E → Fin Nc → ℝ) (x u v : E)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hq : DifferentiableAt ℝ q x) (hρ : ∀ j, DifferentiableAt ℝ (ρ j) x)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) :
    ∑ i : Fin Nc,
      ((fderiv ℝ q x) u i * (fderiv ℝ
        (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) v i -
        (fderiv ℝ (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) u i * (fderiv ℝ q x) v i) = 0 := by
  apply MolecularDynamics.textbookConstrainedAcceleration_pullback_zero <;> assumption

theorem hessianPullbackCancel_time (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (ρ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j)) (_hρ : ContDiff ℝ 1 ρ)
    (γ u v : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ)
    (_hγ : HasDerivAt γ
      (MolecularDynamics.Chapter04Review.invMass m (γ t).2,
       -MolecularDynamics.Chapter04Review.grad U (γ t).1-(textbookConstraintJacobian g (γ t).1)ᵀ *ᵥ ρ (γ t)) t)
    (_hu : HasDerivAt u ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (u t)) t)
    (_hv : HasDerivAt v ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (v t)) t)
    (_htu : ∀ j, (fderiv ℝ (g j) (γ t).1) (u t).1=0)
    (_htv : ∀ j, (fderiv ℝ (g j) (γ t).1) (v t).1=0) :
    HasDerivAt (fun s ↦ MolecularDynamics.Chapter04Review.phaseForm (u s) (v s)) 0 t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.hessianPullbackCancel`；`MD.Ch04.hessianPullbackCancel_time` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 完整实际C²势/约束、可微乘子和切向位置图；前文各消去项在已证正式库有限和展开中保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。 | [EXTRA] |

[EXTRA] 完整实际C²势/约束、可微乘子和切向位置图；前文各消去项在已证正式库有限和展开中保留。；[EXTRA] 保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；第一条对任意 Nc、Mc、势 U、约束族 γ，以及 E 上的位置参数化 q 和逐分量乘子 ρ，在 U/γ 为 C²、q/ρ 在 x 可微、γ\_j∘q 局部为零的前提下，陈述 Dq(u)·DA(v)−DA(u)·Dq(v)=0；给定 textbookMultiConstrainedMomentum 的实际定义使 A=−∇U(q)−Σρ\_j∇γ\_j(q)，并非未经说明的假动量。第二条对任意 n,l,m,U,g、C¹ 乘子 ρ，以及时间曲线 γ,u,v 和时刻 t，显式假定 γ 的动力学导数、u/v 的线性变分导数和两者的位置切向条件，完整结论为 HasDerivAt(s↦phaseForm(u(s),v(s))) 0 t。phaseForm 的两个位置/动量配对均保留；逆质量项因对角对称性抵消，势与各约束 Hessian 因对称性抵消，乘子微分项由两条切向条件抵消。无需正质量即可得到此固定对角映射的消去恒等式。第二条只在给定 t 陈述导数零，不自行推出全局流存在；对每一时刻应用才得到源文沿流守恒的通常解释。E 的类型类环境没有在摘录中展开，本轮依 fderiv 所要求的实赋范向量空间语义审查，未运行或宣称编译验证。sorry 不构成失败。

### 7. 状态与证明位置

incomplete；`MD.Ch04.hessianPullbackCancel`：已证；`MD.Ch04.hessianPullbackCancel_time`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1223)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-ConstrainedFlowPullback · unnumbered_claim · 印刷p.156 / PDFp.178

### 2. 原文陈述

> Thus we see that the projected version of the symplectic form in the ambient space is conserved by the differential equation system (4.7)–(4.9). This is what is meant by saying that the constrained system is analogous to a Hamiltonian system. We may also think of its flow map as being a symplectic map of the co-tangent bundle.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedFlowPullback {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (Φ : ℝ × E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, ∀ y,
      LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (Φ (t, y)).1))
    (hODE : ∀ t ∈ Icc 0 τ, ∀ y, HasDerivAt (fun s => Φ (s, y))
      (textbookConstrainedPhaseVectorField m γ U (Φ (t, y))) t)
    (hpos₀ : ∀ y j, γ j (Φ (0, y)).1 = 0)
    (hhidden₀ : ∀ y j, (fderiv ℝ (γ j) (Φ (0, y)).1)
      (textbookInverseMassMatrix m *ᵥ (Φ (0, y)).2) = 0) (x u v : E) :
    ∀ t ∈ Icc 0 τ,
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) v) =
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) v) := by
  apply MolecularDynamics.textbookConstrainedFlow_pullback_constant_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedFlowPullback` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定joint C²的真实流/时间区间、C³约束及C²势、正质量/独立梯度；完整条件见桥接签名，不假设辛性结论。 | [EXTRA] |

[EXTRA] 给定joint C²的真实流/时间区间、C³约束及C²势、正质量/独立梯度；完整条件见桥接签名，不假设辛性结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；展开 textbookCotangentChart q p=Sum.elim q p，SymplecticCoordinates=(Fin Nc⊕Fin Nc)→ℝ，textbookJ=[0,I;−I,0]，textbookSymplecticForm=J.toBilin′，坐标值 Σᵢ(u.qᵢv.pᵢ−u.pᵢv.qᵢ)。InverseMassMatrix=diag(mᵢ⁻¹)，Gⱼᵢ=Dγⱼ(q)eᵢ，Gram=GM⁻¹Gᵀ；Curvatureⱼ=D²γⱼ(q)[M⁻¹p,M⁻¹p]，ReactionMultiplier=Gram⁻¹(GM⁻¹F+Curvature)，F=−grad U。PhaseVectorField=(M⁻¹p,F−GᵀReactionMultiplier)，符号与 (4.7)–(4.9) 相合。Φ 是给定联合 C² 解族；对区间全部 t、全部 y 要求 ODE 和梯度独立，初始位置/隐藏约束全保留；x,u,v 任意，结论恰为各时刻相对于 t=0 的二形式拉回相等。无需 Φ(0,y)=y：允许任意初始约束图，等式本身正是沿流保持该图的拉回形式，换成初始局部坐标即原句。它不声称构造全局流、逆映射或流形非退化定理，原文这里的辛映射表述按形式保持解释。正质量/独立梯度保证 Gram 可逆；联合 C²、C³约束/C²势是充分且合理的技术加强，非最低必要条件，没有将辛性作为前提。Icc 0 τ 只覆盖正向所给区间；τ<0 时为空，不能解释为负时守恒。对应这一局部守恒签名 PASS；无本条 [ERRATUM?]。正文调用依赖同名桥接定理，无显式 sorry；未做编译验证，此 PASS 仅为只读签名语义审计。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.constrainedFlowPullback`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1259)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-PositionEulerPrinted · (4.14)–(4.16) · 印刷p.156 / PDFp.178

### 2. 原文陈述

> A simple example of such a method is the constrained Symplectic Euler-like method

$$
q_{n+1}=q_n+hM^{-1}p_{n+1},\tag{4.14}
$$



$$
p_{n+1}=p_n-hF_n-hg'(q_n)^T\lambda_n,\tag{4.15}
$$



$$
0=g(q_{n+1}).\tag{4.16}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2-h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.positionEulerPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:782–786 的 Prop 恰记录三式，合取换序不改变含义；rho=λₙ，z=(qₙ,pₙ)，out=(qₙ₊₁,pₙ₊₁)。它是关系而非存在唯一性断言，不要求非零步长或隐约束成立。[ERRATUM?] 与书中其他力符号确有冲突；若Fₙ解释为∇U则此式自洽，不能仅从本页断言必须改负号。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.positionEulerPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1281)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-PositionEulerForceConvention · definition · 印刷p.156 / PDFp.178

### 2. 原文陈述

> A simple example of such a method is the constrained Symplectic Euler-like method

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.2-PositionEulerForceConvention。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def positionEulerRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.positionEulerRelation`；`MD.Ch04.positionEulerRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:789–793 只给任意 F 的 +hF 更新；没有 F=−grad U 的约束，也没有 F\_printed=−F 的参数转换。额外说明属于改变力参数或修订原式，不能作为同一F下的额外假设消除负号差异。原句仅命名方法，不能证明改号公式忠实。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.positionEulerRelation`：定义；`MD.Ch04.positionEulerRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1289)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

