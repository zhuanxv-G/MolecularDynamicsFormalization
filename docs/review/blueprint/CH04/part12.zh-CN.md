[上一部分](part11.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / 下一部分：无

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

