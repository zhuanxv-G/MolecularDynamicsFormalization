[上一部分](part03.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## 1. MD-4.3.6-SETTLE · definition · 印刷p.165 / PDFp.187

### 2. 原文陈述

> SETTLE The SETTLE method [274] is just the SHAKE approach applied to a small system combined with an exact solve of the nonlinear equations. It is usually applied to treat rigid bodies (as discussed in the following section).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def settleRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop := MolecularDynamics.Chapter04Review.projectionResidual m g q base η=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.settleRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正文没有闭式算法细节，仅登记真实小系统residual=0关系；不发明SETTLE闭式或存在定理。 | [EXTRA] |

[EXTRA] [EXTRA]正文没有闭式算法细节，仅登记真实小系统residual=0关系；不发明SETTLE闭式或存在定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 projectionResidual、Q、invMass、textbookConstraintJacobian、textbookConstraintGradient 和 textbookInverseMassMatrix，具体表达同上一条：settleRelation m g q base η 等价于 ∀j, g j(base−M⁻¹G(q)ᵀη)=0。这是 SHAKE 消元后的真实非线性方程的精确解关系；等号是精确等号，没有误差容限。全部 n,l,m,g,q,base,η 为参数；无解的输入可以使关系为假，不宣称存在、唯一性、闭式求解器或输出算法。[EXTRA] 是明确的范围说明而非额外逻辑前提：正文没有给出 SETTLE 的专门求解公式，故记录解关系是合理的最小数学登记。小系统与通常用于刚体是应用范围描述，书中没有给出维数上界或只允许刚体的全称限制；不应自行添加 n 或 l 的数值界。此泛化关系不区分 SETTLE 与其他精确求解同一方程的方法，不能单凭此定义宣称已经形式化 SETTLE 的专门算法，但附件已明确只登记关系，因此本条按该范围 PASS。无 [ERRATUM?]，定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.settleRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2282)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-LINCSInverse · definition · 印刷p.165 / PDFp.187

### 2. 原文陈述

> LINCS In solving the Eqs. (4.27)–(4.29) by Newton iteration, the largest cost and the most significant barrier to parallelization is the linear solve. The LINCS method [119, 175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.lincsInverse` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。 | [EXTRA] |

[EXTRA] [EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限阶实方阵C和自然数k，range(k+1)给出从0至k共k+1项，含单位阵C⁰。定义的是归一化逆(I−C)⁻¹的Neumann截断，不是原始Newton矩阵逆的完整LINCS实现；原书仅定性提及级数，没有该公式。作为显式EXTRA的标准模型合理，需补明归一化及范围。

### 7. 状态与证明位置

self-contained；`MD.Ch04.lincsInverse`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2287)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-LINCSConvergence · unnumbered_claim · 印刷p.165 / PDFp.187

### 2. 原文陈述

> The LINCS method [119, 175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lincsConvergence :
  ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (MolecularDynamics.Chapter04Review.lincsInverse C) atTop (𝓝 ((1-C)⁻¹)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.lincsConvergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。 | [EXTRA] |

[EXTRA] [EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意l及实方阵C；假设是C在Fin l→ℝ上的连续线性算子范数<1，而非逐元素最大值。结论是k→∞时Σ(j=0..k)C^j在矩阵空间收敛到(I−C)⁻¹，逆是矩阵逆。有限维下算子与矩阵拓扑相容，条件足以保证可逆与收敛；包含l=0也无矛盾。只是充分条件，不断言必要性，也未证明实际LINCS矩阵必满足此条件。

### 7. 状态与证明位置

incomplete；`MD.Ch04.lincsConvergence`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2291)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-WaterPairPotential · definition · 印刷p.166–167 / PDFp.188–189

### 2. 原文陈述

> The potential energy for the interaction of a pair of such molecules, the sets of whose charge sites are denoted by $`A`$ and $`B`$, takes the form

$$
\varphi^{\rm water-water}=\sum_{i\in A}\sum_{j\in B}\frac{k_1Q_iQ_j}{r_{ij}}+\frac{k_2}{r_{OO}^{12}}-\frac{k_3}{r_{OO}^{6}},
$$


> where $`r_{OO}`$ represents the distance between the oxygen atoms of the two molecules, and $`k_1,k_2,k_3`$ are positive constants.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.waterPairPotential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。 | [EXTRA] |

[EXTRA] 有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两个有限电荷集合用Fin a、Fin b参数化；Coulomb双和、氧间12次排斥和6次吸引的符号、指数及系数均对应原式。签名接受所有实数，实际没有k1,k2,k3及距离的正性前提；这是Lean实数除法的全定义代数表达式，在正文正参数、正距离域上解释为势能。应纠正EXTRA中仿佛已限制形式定义域的表述，不应把零距离处的形式值解释为物理势。

### 7. 状态与证明位置

self-contained；`MD.Ch04.waterPairPotential`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2298)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-TotalMass · definition · 印刷p.167 / PDFp.189

### 2. 原文陈述

> where $`M=\sum_{i=1}^Nm_i`$ is the total mass.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.totalMass` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3 → ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；有限和按 Fin N 编号，对应原文1至N。 展开正式库 totalMass m=∑ i,m i；本地定义相同，准确表达总质量。没有额外假设或勘误。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.totalMass`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2303)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CenterMass · definition · 印刷p.167 / PDFp.189

### 2. 原文陈述

> The atomic positions may be referred to a coordinate system placed at the center of mass of the collection $`q_{\rm cm}=\frac{\sum_{i=1}^Nm_iq_i}{M}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.centerMass` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；位置是三维实向量，质量是任意实权重；totalMass确为Σm\_i。逆总质量的标量作用等于原式向量除以M。定义无M≠0前提，Lean取0⁻¹=0；在物理应用域M>0时忠实，在M=0时只是代数延拓。原文没有给零总质量情形赋予质心含义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.centerMass`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2306)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RelativePositions · definition · 印刷p.167 / PDFp.189

### 2. 原文陈述

> We write $`q_i=q_{\rm cm}+\delta_i`$, where $`\sum_{i=1}^Nm_i\delta_i=0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : Fin N → MolecularDynamics.Chapter04Review.V :=
  fun i => q i-MolecularDynamics.Chapter04Review.centerMass m q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅q\_i=q\_cm+δ\_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.relativePositions` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅q\_i=q\_cm+δ\_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅q\_i=q\_cm+δ\_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意N、实质量和三维位置，逐项定义δ\_i=q\_i−centerMass m q，故q\_i=q\_cm+δ\_i恒成立。仅定义相对位置；未在本声明得出Σm\_iδ\_i=0。该后件已明确分配给RelativeWeightedZero，未在本任务给出，不能声称已核验该外部定理；尤其不能在任意总质量为零的实权重上无条件推广零和。

### 7. 状态与证明位置

self-contained；`MD.Ch04.relativePositions`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2311)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RelativeWeightedZero · unnumbered_claim · 印刷p.167 / PDFp.189

### 2. 原文陈述

> We write $`q_i=q_{\rm cm}+\delta_i`$, where $`\sum_{i=1}^Nm_i\delta_i=0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem relativeWeightedZero : ∀ N (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V),
    MolecularDynamics.Chapter04Review.totalMass m ≠ 0 → (∑ i, m i • MolecularDynamics.Chapter04Review.relativePositions m q i)=0 := by
  intro N m q hm
  simp only [MolecularDynamics.Chapter04Review.relativePositions,smul_sub,Finset.sum_sub_distrib,← Finset.sum_smul]
  rw [MolecularDynamics.Chapter04Review.centerMass,smul_smul]
  change (∑ i, m i • q i)-(MolecularDynamics.Chapter04Review.totalMass m * (MolecularDynamics.Chapter04Review.totalMass m)⁻¹) • (∑ i, m i • q i)=0
  rw [mul_inv_cancel₀ hm,one_smul,sub_self]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.relativeWeightedZero` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 总质量非零；原物理正质量给此资格，空体系排除。 | [EXTRA] |

[EXTRA] 总质量非零；原物理正质量给此资格，空体系排除。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3 → ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；有限和按 Fin N 编号，对应原文1至N。 展开 relativePositions、centerMass、totalMass 后，结论就是∑m\_i(q\_i-(∑m\_j q\_j)/M)=0，前提M≠0。该[EXTRA]合理且对任意实权重的推广一般必要：两权重1,-1、位置e1,0时M=0而加权和非零。正物理质量非空体系满足它；空体系零和本身成立，注释“空体系排除”只说明本签名不覆盖空体系而非其为反例。原句位置分解由展开减法自动成立，结论零和完整。该定理有实际by证明，无sorry；未运行编译，签名审计不等于编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.relativeWeightedZero`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2316)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-KineticSplit · unnumbered_claim · 印刷p.167 / PDFp.189

### 2. 原文陈述

> Thus the kinetic energy becomes

$$
K=\frac12\sum_{i=1}^Nm_i\|\dot q_{\rm cm}\|^2+\sum_{i=1}^Nm_i\dot q_{\rm cm}\cdot\dot\delta_i+\frac12\sum_{i=1}^Nm_i\|\dot\delta_i\|^2 =\frac M2\|\dot q_{\rm cm}\|^2+\frac12\sum_{i=1}^Nm_i\|\dot\delta_i\|^2,
$$


> where we have used the fact that $`\sum_{i=1}^Nm_i\delta_i\equiv0`$, hence that the time derivative also vanishes, in order to remove the middle term.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kineticSplit :
  ∀ N (m : Fin N → ℝ) (v : MolecularDynamics.Chapter04Review.V) (w : Fin N → MolecularDynamics.Chapter04Review.V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i))/2=MolecularDynamics.Chapter04Review.totalMass m*MolecularDynamics.Chapter04Review.dot v v/2+(∑ i,m i*MolecularDynamics.Chapter04Review.dot (w i) (w i))/2 := by
  intro N m v w hz
  have h0 := congrFun hz 0
  have h1 := congrFun hz 1
  have h2 := congrFun hz 2
  simp only [Finset.sum_apply,Pi.smul_apply,smul_eq_mul,Pi.zero_apply] at h0 h1 h2
  have he : ∀ i, MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i)=
      MolecularDynamics.Chapter04Review.dot v v+2*MolecularDynamics.Chapter04Review.dot v (w i)+MolecularDynamics.Chapter04Review.dot (w i) (w i) := by
    intro i
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have ht : ∀ a : Fin 3, (∑ i, m i*(v a*w i a))=v a*∑ i,m i*w i a := by
    intro a
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  have hc : ∑ i, m i*MolecularDynamics.Chapter04Review.dot v (w i)=0 := by
    simp only [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,mul_add,Finset.sum_add_distrib]
    rw [ht 0,ht 1,ht 2,h0,h1,h2]
    ring
  simp_rw [he,mul_add,Finset.sum_add_distrib]
  rw [← Finset.sum_mul]
  have hx : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=0 := by
    rw [show (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=2*∑ i,m i*MolecularDynamics.Chapter04Review.dot v (w i) by rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i hi; ring,hc,mul_zero]
  rw [hx]
  simp [MolecularDynamics.Chapter04Review.totalMass]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.kineticSplit` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意N、实权重、公共速度v及相对速度w\_i，以Σm\_i w\_i=0为前提，给出Σm\_i|v+w\_i|²/2=M|v|²/2+Σm\_i|w\_i|²/2。dot实际为坐标乘积和，确为欧氏内积；代数上不需要质量正性。签名没有时间变量、轨道或求导，故原文从Σm\_iδ\_i恒零推导其时间导数为零这一解释应明确属于应用背景，前提hz是其速度层面的代数输入。

### 7. 状态与证明位置

self-contained；`MD.Ch04.kineticSplit`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2325)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SecondMoment · definition · 印刷p.168 / PDFp.190

### 2. 原文陈述

> where the fixed matrix $`R`$ is given by $`R=\sum_{i=1}^Nm_i\delta_i(0)\delta_i(0)^T`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.secondMoment` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限N、实权重及三维参考向量δ，outer v的(i,j)分量为v\_i v\_j，有限和正是R=Σm\_iδ\_i(0)δ\_i(0)ᵀ。δ参数应解释为固定初始参考位置，不是随时间的当前位置；定义没有错误引入时间依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch04.secondMoment`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2358)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationKinetic · definition · 印刷p.168 / PDFp.190

### 2. 原文陈述

> $`K_{\rm rot}=\frac12\sum_{i=1}^Nm_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0)`$. This expression may be rewritten as $`K_{\rm rot}=\frac12\operatorname{Tr}[\dot\Theta R\dot\Theta^T]`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationKinetic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意两个实3×3矩阵R、dΘ，定义trace(dΘ R dΘᵀ)/2。R的质量外积结构及dΘ为旋转轨道导数是应用解释，并非此代数定义的前提。有限粒子和与trace的等价已在明确scope中分给下一条RotationTraceIdentity；本条不单独声称两式等价。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationKinetic`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2362)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationTraceIdentity · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> $`K_{\rm rot}=\frac12\sum_{i=1}^Nm_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0)`$. This expression may be rewritten as $`K_{\rm rot}=\frac12\operatorname{Tr}[\dot\Theta R\dot\Theta^T]`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (dΘ : MolecularDynamics.Chapter04Review.Mat3),
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      MolecularDynamics.Chapter04Review.rotationKinetic (MolecularDynamics.Chapter04Review.secondMoment m δ) dΘ := by
  intro N m δ dΘ
  unfold MolecularDynamics.Chapter04Review.rotationKinetic MolecularDynamics.Chapter04Review.secondMoment
  rw [Matrix.mul_sum,Matrix.sum_mul,Matrix.trace_sum]
  rw [Finset.sum_div,Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  simp [Matrix.trace,Matrix.mul_apply,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationTraceIdentity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意N、实权重m、三维参考向量δ和任意实3×3矩阵dΘ，结论将Σm\_i dot(dΘδ\_i,dΘδ\_i)/2等于rotationKinetic(secondMoment m δ,dΘ)。展开后恰是δ\_iᵀdΘᵀdΘδ\_i与trace形式的恒等式；不需正交或正质量，使用任意矩阵比物理应用更一般且正确。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationTraceIdentity`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2365)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationSkew · unnumbered_claim · 印刷p.168–169 / PDFp.190–191

### 2. 原文陈述

> Moreover, since $`\Theta\Theta^T=I`$, we have $`\dot\Theta\Theta^T+\Theta\dot\Theta^T=0`$, which indicates that $`\dot\Theta\Theta^T`$ is a skew symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationSkew :
  ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ) := by
  intro Θ t d hd ho
  have hs : ∀ i j : Fin 3, ∑ k, (d i k*Θ t j k+Θ t i k*d j k)=0 := by
    intro i j
    have hf : HasDerivAt (fun s => ∑ k, Θ s i k*Θ s j k)
        (∑ k, (d i k*Θ t j k+Θ t i k*d j k)) t := by
      apply HasDerivAt.fun_sum
      intro k hk
      exact ((hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) k).mul (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd j) k))
    have he : (fun s => ∑ k, Θ s i k*Θ s j k) =ᶠ[𝓝 t] (fun _ => (1 : MolecularDynamics.Chapter04Review.Mat3) i j) := by
      filter_upwards [ho] with s h
      simpa [Matrix.mul_apply,Matrix.transpose_apply] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) h
    exact hf.unique ((hasDerivAt_const t ((1 : MolecularDynamics.Chapter04Review.Mat3) i j)).congr_of_eventuallyEq he)
  ext i j
  have h := hs i j
  simp only [Fin.sum_univ_three] at h
  simp [Matrix.mul_apply,Matrix.transpose_apply,Fin.sum_univ_three]
  nlinarith [h]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationSkew` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。 | [EXTRA] |

[EXTRA] 真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词为真实矩阵轨道Θ、时刻t及导数d；HasDerivAt给出真实导数，邻域eventually正交条件足以对ΘΘᵀ=I求导。结论是(d*(Θ t)ᵀ)ᵀ=−(d*(Θ t)ᵀ)，即乘积d*(Θ t)ᵀ反对称。由矩阵转置乘法公式，它等价于d*(Θ t)ᵀ+Θ t*dᵀ=0，故同时涵盖原文中间恒等式；未将待证导数恒等式放入假设。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationSkew`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2379)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SkewMatrix · (4.38) · 印刷p.169 / PDFp.191

### 2. 原文陈述

> Any $`3\times3`$ skew matrix may be written as

$$
\dot\Theta\Theta^T=\operatorname{skew}(\omega)\equiv\begin{bmatrix}0&-\omega_3&\omega_2\\\omega_3&0&-\omega_1\\-\omega_2&\omega_1&0\end{bmatrix}.\tag{4.38}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.skewMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；三维实向量映为实3×3矩阵，0基坐标v 0、v 1、v 2分别对应原书ω₁、ω₂、ω₃；六个非对角元的符号全部正确，主对角为0。scope仅定义；任意反对称矩阵的表示由本批第15条给出，旋转导数反对称性由第12条给出。

### 7. 状态与证明位置

self-contained；`MD.Ch04.skewMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2402)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CrossProduct · definition · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`\frac d{dt}\delta_i=\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cross3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意三维实向量u、v，三个分量依次是u₂v₃−u₃v₂、u₃v₁−u₁v₃、u₁v₂−u₂v₁，符合右手叉积。定义本身不涉及真实时间导数或完整三个等号；scope已明确，第17条承担导数结论。外部CrossIdentityFull未在本任务给出，不能把本条定义当作已核验该外部完整声明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cross3`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2406)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SkewRepresentation · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> Any $`3\times3`$ skew matrix may be written as

$$
\dot\Theta\Theta^T=\operatorname{skew}(\omega)\equiv\begin{bmatrix}0&-\omega_3&\omega_2\\\omega_3&0&-\omega_1\\-\omega_2&\omega_1&0\end{bmatrix}.\tag{4.38}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem skewRepresentation : ∀ A : MolecularDynamics.Chapter04Review.Mat3, Aᵀ = -A → ∃! «ω» : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix «ω»=A := by
  intro A ha
  have hs : ∀ i j : Fin 3, A j i= -A i j := by
    intro i j
    simpa using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) ha
  refine ⟨![A 2 1,A 0 2,A 1 0],?_,?_⟩
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.skewMatrix] <;> nlinarith [hs 0 0,hs 0 1,hs 0 2,hs 1 1,hs 1 2,hs 2 2]
  · intro w hw
    ext i
    fin_cases i
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 2 1) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 0 2) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 1 0) hw
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.skewRepresentation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意实3×3矩阵A，在Aᵀ=−A前提下，存在唯一实三维向量ω使Chapter04Review.skewMatrix ω=A。该依赖的坐标定义与本批MD版本相同。原文只说可表示，唯一性是正确加强：ω=(A₃₂,A₁₃,A₂₁)，与Lean的![A 2 1,A 0 2,A 1 0]相同；无额外隐藏前提。

### 7. 状态与证明位置

self-contained；`MD.Ch04.skewRepresentation`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2409)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CrossMatrix · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem crossMatrix :
  ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v := by
  intro u v
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.crossMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。 | [EXTRA] |

[EXTRA] [EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。；[EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意三维实向量u、v，证明skewMatrix u *ᵥ v=cross3 u v，类型、乘法方向及右手符号均正确。结论仅为原文代数链首等式；另一等式等价于叉积反交换性。本条scope和EXTRA已声明此分工；未提供的CrossIdentityFull签名不在本批认证范围。

### 7. 状态与证明位置

self-contained；`MD.Ch04.crossMatrix`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2427)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RigidVelocity · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`\frac d{dt}\delta_i=\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega`$, which is the usual definition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidVelocity : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (dΘ : MolecularDynamics.Chapter04Review.Mat3) (δ «ω» : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ=MolecularDynamics.Chapter04Review.skewMatrix «ω» →
    HasDerivAt (fun s => Θ s *ᵥ δ) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ)) t := by
  intro Θ dΘ δ «ω» t hd ho hs
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,dΘ i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  have hv : HasDerivAt (fun s => Θ s *ᵥ δ) (dΘ *ᵥ δ) t := hasDerivAt_pi.mpr he
  have hi : (Θ t)ᵀ*Θ t=1 := mul_eq_one_comm.mp ho
  have hcross : MolecularDynamics.Chapter04Review.skewMatrix «ω» *ᵥ (Θ t *ᵥ δ)=
      MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ) := by
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
  rw [← hcross,← hs,Matrix.mulVec_mulVec,Matrix.mul_assoc,hi,Matrix.mul_one]
  exact hv
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidVelocity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。 | [EXTRA] |

[EXTRA] 给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。；[EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意矩阵轨道Θ、候选导数dΘ、固定参考向量δ、空间角速度ω及t；前提HasDerivAt、时刻t的ΘΘᵀ=I以及dΘΘᵀ=skew(ω)足以推出真实轨道s↦Θ(s)δ的导数为ω×(Θ(t)δ)。参考δ与原文δ\_i(0)对应，结果中的Θ(t)δ才是当前δ\_i。方阵单侧正交足以推出反侧正交，不需另加邻域正交。已明示只承担导数与叉积的等式；完整代数链所指外部CrossIdentityFull未提供，不作额外认证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidVelocity`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2436)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaTensor · definition · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`K_{\rm rot}=\frac12\omega_b^TT\omega_b`$, where the matrix $`T=-\sum_{i=1}^Nm_i\operatorname{skew}(\delta_i(0))^2`$ is referred to as the moment of inertia tensor or simply the inertia tensor and can be written as

$$
T=\sum_{i=1}^Nm_i[\|\delta_i(0)\|^2I-\delta_i(0)\delta_i(0)^T].
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω\_b关系由MD-4.4-RotationBodyEnergy承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaTensor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω\_b关系由MD-4.4-RotationBodyEnergy承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω\_b关系由MD-4.4-RotationBodyEnergy承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限N、实质量权m和三维参考向量δ，返回3×3实矩阵Σm\_i((δ\_i·δ\_i)I−δ\_iδ\_iᵀ)。dot、outer和单位矩阵展开均吻合欧氏公式；无需正质量前提即可定义。按显式statement\_scope仅核对该定义；本声明不证明skew平方或动能恒等式，跨条目分工不当作本声明已经证明的内容。

### 7. 状态与证明位置

self-contained；`MD.Ch04.inertiaTensor`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2456)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CrossIdentityFull · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem crossIdentityFull : ∀ u v : MolecularDynamics.Chapter04Review.V,
    MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v ∧
    MolecularDynamics.Chapter04Review.cross3 u v= -(MolecularDynamics.Chapter04Review.skewMatrix v *ᵥ u) := by
  intro u v
  constructor <;> ext i <;> fin_cases i <;>
    simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.crossIdentityFull` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 skewMatrix u 展开为 [[0,−u₂,u₁],[u₂,0,−u₀],[−u₁,u₀,0]]；cross3 u v 展开为 (u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)。∀u v 的合取恰含两条等式，Lean 0基索引对应原书1基索引。任意实向量的代数恒等式无需运动学假设。没有 [EXTRA]/[ERRATUM?]。该声明有显式证明且未见 sorry；此与签名 PASS 分开记录。

### 7. 状态与证明位置

self-contained；`MD.Ch04.crossIdentityFull`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2460)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationalEnergy · definition · 印刷p.169 / PDFp.191

### 2. 原文陈述

> It is convenient to express this in terms of the so-called body angular velocity $`\omega_b=\Theta^T\omega`$ in which case it becomes $`K_{\rm rot}=\frac12\omega_b^TT\omega_b`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) (ωb : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot ωb (T *ᵥ ωb)/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅体角速度ω\_b的二次型能量定义；ω\_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationalEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅体角速度ω\_b的二次型能量定义；ω\_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅体角速度ω\_b的二次型能量定义；ω\_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意3×3实矩阵T与三维实向量ωb映到ωb·(Tωb)/2，完整表达所声明的二次型定义。ωb=Θᵀω及真实粒子动能由本批第8条实际核对；这里不把任意T、ωb当作已满足刚体运动关系的对象。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationalEnergy`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2469)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaSkewIdentity · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`T=-\sum_{i=1}^Nm_i\operatorname{skew}(\delta_i(0))^2`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem inertiaSkewIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.inertiaTensor m δ= -∑ i, m i • (MolecularDynamics.Chapter04Review.skewMatrix (δ i))^2 := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v= -(MolecularDynamics.Chapter04Review.skewMatrix v)^2 := by
    intro v
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mul_apply,Fin.sum_univ_three,pow_two] <;> ring
  simp [MolecularDynamics.Chapter04Review.inertiaTensor,he,Finset.sum_neg_distrib]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaSkewIdentity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 inertiaTensor m δ 展开为 ∑i m\_i( (∑j δ\_ij²)I−δ\_iδ\_iᵀ)。skewMatrix 的矩阵平方恰为 δ\_iδ\_iᵀ−(∑jδ\_ij²)I，因此所有有限 N、实 m、实 δ 都满足签名。δ 参数可直接取参考构型 δ\_i(0)，无需时间参数；Fin N 覆盖原书1至N。无需正质量假设，推广到实权重合理；无额外假设或勘误。显式证明体未见 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.inertiaSkewIdentity`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2472)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaTracePrinted · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> This matrix is closely related to the matrix $`R`$:

$$
R=\sum_{i=1}^Nm_i\delta_i\delta_i^T=\sum_{i=1}^Nm_i\|\delta_i\|^2I-T=(T_{11}+T_{22}+T_{33})I-T.\tag{4.40}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem inertiaTracePrinted :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=(MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  sorry



/-- 修正版，对应原文 MD-4.4-InertiaTracePrinted。改动：二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。 -/
```

独立修正版：

```lean
theorem inertiaTracePrinted_corrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaTracePrinted`；`MD.Ch04.inertiaTracePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。 | [EXTRA] |

[EXTRA] [ERRATUM?] 二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 secondMoment 展开为 ∑i m\_iδ\_iδ\_iᵀ；inertiaTensor 如上述定义，trace(T)=2∑i m\_i dot δ\_i δ\_i。签名忠实保留原书错误的末式，故并非转录系数错误，但该全称命题为假；还未显式列出原句中间等式。原书 ERRATUM? 成立，应改系数为 trace(T)/2。实际证明体为 sorry；FAIL 的数学反例独立于 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch04.inertiaTracePrinted`：未证（原书疑误不证）；`MD.Ch04.inertiaTracePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2486)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaTraceCorrected · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $`R=\sum_{i=1}^Nm_i\delta_i\delta_i^T=\sum_{i=1}^Nm_i\|\delta_i\|^2I-T`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem inertiaTraceCorrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v).trace=2*MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    simp [Matrix.trace,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
    ring
  rw [MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.trace_sum]
  simp_rw [Matrix.trace_smul,he,smul_eq_mul]
  have ht : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot (δ i) (δ i)))/2=
      ∑ i, m i*MolecularDynamics.Chapter04Review.dot (δ i) (δ i) := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  rw [ht,MolecularDynamics.Chapter04Review.secondMoment]
  ext i j
  simp only [Matrix.sum_apply,Matrix.smul_apply,Matrix.sub_apply,smul_eq_mul]
  rw [Finset.sum_mul,← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaTraceCorrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。 | [EXTRA] |

[EXTRA] [EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全称量化任意N、实权m和三维δ，无额外前提；secondMoment=Σm\_iδ\_iδ\_iᵀ，inertiaTensor=Σm\_i((δ\_i·δ\_i)I−δ\_iδ\_iᵀ)。三维时trace(T)=2Σm\_i||δ\_i||²，所以R=(trace(T)/2)I−T正确。/2已明确标为纠正，不伪称原书印式。

### 7. 状态与证明位置

self-contained；`MD.Ch04.inertiaTraceCorrected`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2505)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarHamiltonian · Example 4.1 · 印刷p.169–170 / PDFp.191–192

### 2. 原文陈述

> Example 4.1 (Dipolar Molecular Liquid) The Hamiltonian for a more general dipolar system can be written

$$
H=K_{\rm rot}(\pi_1,\ldots,\pi_N)+K_{\rm trans}(p_1,\ldots,p_N)+U(q_1,\ldots,q_N,\mu_1,\ldots,\mu_N).
$$


> The vectors $`\mu_k`$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $`\|\mu_k\|\equiv1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarHamiltonian {N : ℕ} (mass : Fin N → ℝ) (inertia : MolecularDynamics.Chapter04Review.V) (_hm : ∀ i, 0 < mass i) (_hI : ∀ j, 0 < inertia j)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.V) → ℝ)
    (q p μ πbody : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1) : ℝ :=
  (∑ i, ∑ j, (πbody i j)^2/(2*inertia j))+(∑ i, MolecularDynamics.Chapter04Review.dot (p i) (p i)/(2*mass i))+U q μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 真实物理接口补质量/主惯性正性和每个μ单位长度；πbody明确为体坐标角动量，数值公式不变。 | [EXTRA] |

[EXTRA] 所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。；[EXTRA] 真实物理接口补质量/主惯性正性和每个μ单位长度；πbody明确为体坐标角动量，数值公式不变。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；N个位置、平移动量、单位方向和体角动量均为Fin N→ℝ³；共同三个正惯量给出Σ\_iΣ\_j π\_ij²/(2I\_j)，正质量给出Σ\_i||p\_i||²/(2m\_i)，再加U q μ。逐i单位约束由dot=1实现，正性均已披露。允许质量随i变化是相同椭球模型的代数推广；在相同质量实例上完全一致，不影响定义公式。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2533)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarPairPotential · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> The total dipole-dipole interaction potential then takes the form $`\varphi^{\rm dip}_{ij}=\varphi_{\rm LJ}(r_{ij})+\mu_i^TL(q_{ij})\mu_j`$, with $`U`$ given as the sum of these over pairs. The $`3\times3`$ matrix $`L`$ is given by

$$
L(q_{ij})=\frac1{r_{ij}^3}-\frac3{r_{ij}^5}q_{ij}q_{ij}^T,\qquad q_{ij}=q_i-q_j.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)

def dipolarPairPotential_particles {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V) (i j : Fin N)
    (_hij : i ≠ j) (_hnoncollision : q i ≠ q j) : ℝ :=
  let r := q i-q j
  dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)

def dipolarSystemPotential {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hnoncollision : ∀ i j, i ≠ j → q i ≠ q j) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i<j),
    let r := q i-q j
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarPairPotential`；`MD.Ch04.dipolarPairPotential_particles`；`MD.Ch04.dipolarSystemPotential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留代数核；新增实际非碰撞粒子对q\_i−q\_j、r\_ij=√(r·r)实例和仅i<j的完整系统势能求和，避免任意r与q脱钩。 | [EXTRA] |

[EXTRA] r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。；[EXTRA] 保留代数核；新增实际非碰撞粒子对q\_i−q\_j、r\_ij=√(r·r)实例和仅i<j的完整系统势能求和，避免任意r与q脱钩。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；共三个声明：代数核保留独立r及q，故该核单独不宣称r=||q||；particles接口以q\_i−q\_j及sqrt(dot r r)绑定距离，并要求不同指标且不碰撞；system接口对所有非碰撞构形仅求i<j一次。矩阵核的幂次、负号、outer顺序及μᵀLν都正确；非碰撞保证物理实例距离正。lj是径向势参数，实例化为φ\_LJ即原模型。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarPairPotential`：定义；`MD.Ch04.dipolarPairPotential_particles`：定义；`MD.Ch04.dipolarSystemPotential`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2542)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarRotationalPrinted · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> Then $`K_{\rm rot}=\sum_{i=1}^N\operatorname{Tr}[\dot\Theta_iR\dot\Theta_i^T]`$, with $`R`$ defined in terms of $`T=\operatorname{diag}(I_1,I_2,I_3)`$ by (4.40).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarRotationalPrinted {N : ℕ} (R : MolecularDynamics.Chapter04Review.Mat3) (dΘ : Fin N → MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace



/-- 修正版，对应原文 MD-4.4-DipolarRotationalPrinted。改动：转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted_corrected共同核查。 -/
```

独立修正版：

```lean
def dipolarRotationalPrinted_corrected {N : ℕ} (R : MolecularDynamics.Chapter04Review.Mat3) (dΘ : Fin N → MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  (1/2 : ℝ) * ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarRotationalPrinted`；`MD.Ch04.dipolarRotationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted\_corrected共同核查。 | [EXTRA] |

[EXTRA] [ERRATUM?] 转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted\_corrected共同核查。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 函数准确保留印刷求和式且未擅自补1/2；但本条还明确要求 R 由 T=diag(I₁,I₂,I₃) 经(4.40)定义，签名 R 为自由矩阵，未含 T、I 或关系，dΘ 也不绑定旋转矩阵的导数。故全部原句的语义未覆盖；印刷动能缺1/2的 ERRATUM? 成立，并且所引(4.40)另有系数错误。此为 def，无 sorry；并非因没有证明而 FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarRotationalPrinted`：定义；`MD.Ch04.dipolarRotationalPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2561)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RigidHamiltonian · definition · 印刷p.170–171 / PDFp.192–193

### 2. 原文陈述

> The Hamiltonian is (for a single rigid body):

$$
H_{\rm RB}=\frac{\|p_{\rm cm}\|^2}{2M}+\frac{\operatorname{Tr}[\Pi R^{-1}\Pi^T]}2+U(q_{\rm cm},\Theta),
$$


> subject to the orthogonality constraint $`\Theta^T\Theta=I`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidHamiltonian (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q p : MolecularDynamics.Chapter04Review.V) (Θ mom : MolecularDynamics.Chapter04Review.Mat3) (_hΘ : Θᵀ*Θ=1) : ℝ :=
  MolecularDynamics.Chapter04Review.dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主接口增加M>0、R可逆及ΘᵀΘ=I的实际受约束域，公式不再将任意矩阵姿态当刚体状态。 | [EXTRA] |

[EXTRA] M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。；[EXTRA] 主接口增加M>0、R可逆及ΘᵀΘ=I的实际受约束域，公式不再将任意矩阵姿态当刚体状态。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数M>0、R.det≠0已披露；q,p∈ℝ³，Θ,Π∈Mat3，并由实参证明ΘᵀΘ=I限定姿态。返回||p||²/(2M)+trace(ΠR⁻¹Πᵀ)/2+U(q,Θ)，乘法顺序和系数完整。R作为给定参考二阶矩使用；函数未断言任意可逆R都可由某个物理构形实现。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2573)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SecondMomentDiagonal · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> By choosing an appropriate coordinate frame, it is possible to insure that the symmetric matrix $`R`$ is a diagonal matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
    ∃ O : MolecularDynamics.Chapter04Review.Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*MolecularDynamics.Chapter04Review.secondMoment m δ*O) i j=0 := by
  intro N m δ
  let R := MolecularDynamics.Chapter04Review.secondMoment m δ
  have hs : R.IsHermitian := by
    change Rᴴ=R
    ext i j
    simp [R,MolecularDynamics.Chapter04Review.secondMoment,MolecularDynamics.Chapter04Review.outer,Matrix.conjTranspose_apply,Matrix.sum_apply,Matrix.smul_apply,mul_comm]
  let O := hs.eigenvectorUnitary
  refine ⟨(O : MolecularDynamics.Chapter04Review.Mat3),?_,?_⟩
  · simpa [Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using Unitary.coe_star_mul_self O
  · have he : (O : MolecularDynamics.Chapter04Review.Mat3)ᵀ*R*(O : MolecularDynamics.Chapter04Review.Mat3)=Matrix.diagonal hs.eigenvalues := by
      simpa [O,Unitary.conjStarAlgAut_star_apply,Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using hs.conjStarAlgAut_star_eigenvectorUnitary
    intro i j hij
    simpa [Matrix.diagonal,hij] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) he
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.secondMomentDiagonal` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限实权构形，存在O∈Mat3满足OᵀO=I且OᵀRO所有非对角元为零，正是选择正交坐标使实对称R对角化。无质量正性也成立；无须把特征值非负或det O=1另作原文结论。

### 7. 状态与证明位置

self-contained；`MD.Ch04.secondMomentDiagonal`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2577)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationBodyEnergy · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> It is convenient to express this in terms of the so-called body angular velocity $`\omega_b=\Theta^T\omega`$ in which case it becomes $`K_{\rm rot}=\frac12\omega_b^TT\omega_b`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
    MolecularDynamics.Chapter04Review.rotationalEnergy (MolecularDynamics.Chapter04Review.inertiaTensor m δ) (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  let x := Θᵀ *ᵥ «ω»
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hx : Θ *ᵥ x=«ω» := by
    dsimp [x]
    rw [Matrix.mulVec_mulVec,mul_eq_one_comm.mp ho,Matrix.one_mulVec]
  have hn : MolecularDynamics.Chapter04Review.dot «ω» «ω»=MolecularDynamics.Chapter04Review.dot x x := by
    conv_lhs => rw [← hx]
    rw [ht,hi]
  have hc : ∀ v w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 w v) (MolecularDynamics.Chapter04Review.cross3 w v)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot w w-(MolecularDynamics.Chapter04Review.dot v w)^2 := by
    intro v w
    simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot y ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ y)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot y y-(MolecularDynamics.Chapter04Review.dot v y)^2 := by
    intro v y
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hf : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      MolecularDynamics.Chapter04Review.dot x ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ x) := by
    intro v
    rw [hc,he]
    have hv : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by rw [ht,hi]
    have hw : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) «ω»=MolecularDynamics.Chapter04Review.dot v x := ht Θ v «ω»
    rw [hv,hn,hw]
  have hsum : ∀ (K : ℕ) (a : Fin K → MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (∑ i,a i)=∑ i,MolecularDynamics.Chapter04Review.dot x (a i) := by
    intro K a
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Finset.sum_apply,Finset.mul_sum,Finset.sum_add_distrib]
  have hsmul : ∀ (c : ℝ) (v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (c • v)=c*MolecularDynamics.Chapter04Review.dot x v := by
    intro c v
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  rw [MolecularDynamics.Chapter04Review.rotationalEnergy,MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.sum_mulVec]
  change (∑ i,m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
      MolecularDynamics.Chapter04Review.dot x (∑ i,(m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))) *ᵥ x)/2
  simp_rw [Matrix.smul_mulVec]
  rw [hsum]
  simp_rw [hsmul,hf]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationBodyEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实SO3旋转；不把动能等式/叉积协变当假设。 | [EXTRA] |

[EXTRA] 真实SO3旋转；不把动能等式/叉积协变当假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意N,m,参考δ及SO(3)矩阵Θ和空间角速度ω，左边是Σm\_i||ω×(Θδ\_i)||²/2，右边用真实inertiaTensor及rotationalEnergy展开为(Θᵀω)ᵀT(Θᵀω)/2。正交与det=1均显式前提，未把能量相等本身当前提。该代数身份允许任意实权，覆盖物理质量。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationBodyEnergy`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2596)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarConstraint · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> The vectors $`\mu_k`$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $`\|\mu_k\|\equiv1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarConstraint {N : ℕ} (μ : Fin N → MolecularDynamics.Chapter04Review.V) : Prop :=
  ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarConstraint` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；有限族三维实方向向量的Prop为∀i, μ\_i·μ\_i=1，与每个方向的欧氏长度为1等价。它是瞬时构形约束；沿轨道每时刻满足该Prop即可表达原文恒等号，不另声称由运动方程自动保持。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarConstraint`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2645)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarPotentialSum · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> $`\varphi^{\rm dip}_{ij}=\varphi_{\rm LJ}(r_{ij})+\mu_i^TL(q_{ij})\mu_j`$, with $`U`$ given as the sum of these over pairs.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarPotentialSumTotalized {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0

def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hq : ∀ i j, i ≠ j → q i ≠ q j)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i) = 1) : ℝ :=
  dipolarPotentialSumTotalized lj q μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarPotentialSumTotalized`；`MD.Ch04.dipolarPotentialSum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。 | [EXTRA] |

[EXTRA] 对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。；[EXTRA] 原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。

### 6. 审计结论

本轮修复：原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；求和指标i,j均遍历Fin N，if i<j确保每个无序不同粒子对恰计一次；q差与sqrt(dot差差)确实绑定实际距离，pair核依赖也正确。但签名没有位置非碰撞前提，也没有μ单位约束，而context\_notation及EXTRA明确声称无重叠位置和单位方向。Lean实数逆在0处仍有总值，故碰撞状态被实际纳入定义域；这不能表述为已实现r\_ij>0的物理接口。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarPotentialSumTotalized`：定义；`MD.Ch04.dipolarPotentialSum`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2651)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationTrajectory · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> $`\delta_i(t)=\Theta(t)\delta_i(0)`$, see Fig. 4.7, thus we have

$$
K_{\rm rot}=\frac12\sum_{i=1}^N m_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅δ\_i(t)=Θ(t)δ\_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationTrajectory` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅δ\_i(t)=Θ(t)δ\_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅δ\_i(t)=Θ(t)δ\_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意矩阵轨道Θ、导数d、固定三维向量δ及实t，HasDerivAt Θ d t蕴含HasDerivAt (Θ(·)δ) (dδ) t，是真实时间导数的线性映射规则。按显式statement\_scope这是运动学辅助；不含原段动能有限和或trace结论，也不把未提供的RotationTraceIdentity当作已审校。正交性并非此导数规则所需。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationTrajectory`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2664)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationDerivativePrinted · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> An alternative form for the rotational kinetic energy may be obtained by writing

$$
\dot\delta_i=\dot\Theta\delta_i(0)=\dot\Theta\Theta^T\Theta\delta_i(0)=\dot\Theta\Theta^T\dot\delta_i,
$$


> where we have used the fact that $`\Theta`$ is orthogonal.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationDerivativePrinted : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (d *ᵥ δ) := by
  sorry



/-- 修正版，对应原文 MD-4.4-RotationDerivativePrinted。改动：右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。 -/
```

独立修正版：

```lean
theorem rotationDerivativePrinted_corrected : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (Θ t *ᵥ δ) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationDerivativePrinted`；`MD.Ch04.rotationDerivativePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。 | [EXTRA] |

[EXTRA] [ERRATUM?] 右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；签名忠实再现印刷末项：设δ=δ\_i(0)、d=dotΘ(t)，右端确为(dΘ(t)^T)(dδ)。ERRATUM?成立，印刷末项应使用当前配置Θ(t)δ而非速度dδ。它不是正交性和可微性推得的真命题，即使Θ整条轨道属于SO(3)仍失败。HasDerivAt为实际矩阵时间导数；ΘΘ^T=I是正确的正交条件。该decl明确含sorry；此处FAIL来自反例，不是因为sorry，原文忠实性单独为通过。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rotationDerivativePrinted`：未证（原书疑误不证）；`MD.Ch04.rotationDerivativePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2677)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RigidMatrixRelation · definition · 印刷p.171 / PDFp.193

### 2. 原文陈述

> The constraint may be enforced using Lagrange multipliers with the following equations

$$
\frac d{dt}q_{\rm cm}=p_{\rm cm}/M,\quad\frac d{dt}\Theta=\Pi R^{-1},
$$



$$
\frac d{dt}p_{\rm cm}=-\nabla_{q_{\rm cm}}U,\quad\frac d{dt}\Pi=-\nabla_\Theta U-\Theta\Lambda,\quad I=\Theta^T\Theta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidMatrixRelation (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.V) (Θ mom Λ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (I : Set ℝ) (_hI : IsOpen I)
    (_hU : Differentiable ℝ (fun z : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 ↦ U z.1 z.2)) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-MolecularDynamics.Chapter04Review.grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-MolecularDynamics.Chapter04Review.matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidMatrixRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 增加开放时间域、势能联合经典可微、M>0及R可逆，使within导数等于真实时间导数，排除单点域伪运动；姿态正交约束仍逐t保留。 | [EXTRA] |

[EXTRA] [EXTRA] 增加开放时间域、势能联合经典可微、M>0及R可逆，使within导数等于真实时间导数，排除单点域伪运动；姿态正交约束仍逐t保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义Prop而非存在性定理；对开放实时间域I逐t要求四个HasDerivWithinAt及ΘᵀΘ=I。开放域内within导数等同通常导数；M>0、R可逆、U在ℝ³×Mat3联合可微均已披露。grad和matrixGrad实际为按标准基取fderiv分量，四个右端的符号、矩阵乘法次序和势能冻结参数正确。Λ为给定矩阵乘子轨道，原摘录未另写对称条件；此处不新增解存在或唯一性断言。空开放域只给空域关系，不构成解存在断言。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidMatrixRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2696)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AngularMomentum · definition · 印刷p.171 / PDFp.193

### 2. 原文陈述

> The angular momentum vector in the reference frame is given by $`l=\sum_{i=1}^Nm_i\delta_i\times\dot\delta_i`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.angularMomentum` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限实权m及三维δ、速度v映到Σm\_i cross3(δ\_i,v\_i)。cross3三分量为标准右手叉积，质量作为标量乘法，完全吻合瞬时角动量定义；v作为输入代表dotδ，无须为定义引入全局轨道。

### 7. 状态与证明位置

self-contained；`MD.Ch04.angularMomentum`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2704)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-BodyMomentum · definition · 印刷p.171 / PDFp.193

### 2. 原文陈述

> Define $`\pi=\Theta^Tl`$, the angular momentum vector referred to the body frame of reference.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.bodyMomentum` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Mat3与三维空间角动量l映到Θᵀl，正是体坐标角动量的代数定义。正交旋转的物理解释已在context给出；这个线性算式可定义在更广矩阵域，不声称任意矩阵都为方向矩阵。

### 7. 状态与证明位置

self-contained；`MD.Ch04.bodyMomentum`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2708)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AngularInertia · unnumbered_claim · 印刷p.171 / PDFp.193

### 2. 原文陈述

> From Eq. (4.39) we may write this as $`l=\sum_im_i\delta_i\times\omega\times\delta_i`$, from which, using the vector triple product identity $`a\times b\times c=(a\cdot c)b-(a\cdot b)c`$, we obtain $`l=\sum_im_i[\|\delta_i\|^2I-\delta_i\delta_i^T]\omega`$. Define $`\pi=\Theta^Tl`$, then we have (using $`\delta_i=\Theta\delta_i(0)`$): $`\pi=T\omega_b`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem angularInertia :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 → MolecularDynamics.Chapter04Review.bodyMomentum Θ
    (MolecularDynamics.Chapter04Review.angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i))) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hn : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    rw [ht,hi]
  have hc : ∀ u w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.cross3 u (MolecularDynamics.Chapter04Review.cross3 w u)=MolecularDynamics.Chapter04Review.dot u u • w-MolecularDynamics.Chapter04Review.dot u w • u := by
    intro u w
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul] <;> ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.outer v *ᵥ y=MolecularDynamics.Chapter04Review.dot v y • v := by
    intro v y
    ext i
    simp [MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  have hterm : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ MolecularDynamics.Chapter04Review.cross3 (Θ *ᵥ v) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ (Θᵀ *ᵥ «ω») := by
    intro v
    rw [hc,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_smul,hn,ht,hi,
      Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,he]
  simp only [MolecularDynamics.Chapter04Review.bodyMomentum,MolecularDynamics.Chapter04Review.angularMomentum,
    MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.mulVec_sum,Matrix.mulVec_smul,Matrix.sum_mulVec,Matrix.smul_mulVec]
  apply Finset.sum_congr rfl
  intro i hii
  rw [hterm]

theorem vectorTripleProduct (a b c : MolecularDynamics.Chapter04Review.V) :
    MolecularDynamics.Chapter04Review.cross3 a (MolecularDynamics.Chapter04Review.cross3 b c) =
      MolecularDynamics.Chapter04Review.dot a c • b-MolecularDynamics.Chapter04Review.dot a b • c := by
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,
    MolecularDynamics.Chapter04Review.dot, Fin.sum_univ_three, Pi.smul_apply, smul_eq_mul] <;> ring

theorem spatialAngularInertia (N : ℕ) (m : Fin N → ℝ)
    (δ : Fin N → MolecularDynamics.Chapter04Review.V) (omegaVec : MolecularDynamics.Chapter04Review.V) :
    MolecularDynamics.Chapter04Review.angularMomentum m δ
      (fun i => MolecularDynamics.Chapter04Review.cross3 omegaVec (δ i)) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ omegaVec := by
  simpa [MolecularDynamics.Chapter04Review.bodyMomentum] using
    (angularInertia N m δ (1 : MolecularDynamics.Chapter04Review.Mat3) omegaVec (by simp) (by simp))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.angularInertia`；`MD.Ch04.vectorTripleProduct`；`MD.Ch04.spatialAngularInertia` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。 | [EXTRA] |

[EXTRA] 真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。；[EXTRA] 原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。

### 6. 审计结论

本轮修复：原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；全称N,m,参考δ,Θ,ω，并以前提ΘᵀΘ=I及detΘ=1，结论确实是ΘᵀΣm\_i[(Θδ\_i)×(ω×Θδ\_i)]=T(Θᵀω)，右嵌套与原文给出的三重积公式一致。然而本条statement\_scope声称覆盖全部引文，签名仅给最终体坐标等式；未陈述一般三重积恒等式以及空间角动量等于Σm\_i[||δ\_i||²I−δ\_iδ\_iᵀ]ω的中间等式。证明体中的局部hc只给u×(w×u)特例，不是可替代完整结论的声明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.angularInertia`：已证；`MD.Ch04.vectorTripleProduct`：已证；`MD.Ch04.spatialAngularInertia`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2713)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-EulerRigidField · (4.41) · 印刷p.172 / PDFp.194

### 2. 原文陈述

> but since $`\omega_b=T^{-1}\pi`$, we may conclude $`\dot\pi=\pi\times T^{-1}\pi`$. These are the so-called Euler equations for the free rigid body.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.eulerRigidField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；MD.Ch04.eulerRigidField 的对象为实3×3矩阵T和实三维列向量π，返回同域向量。展开 cross3 的三个分量，恰为π×(T⁻¹π)，次序及符号与(4.41)一致。本条是右端向量场定义，未冒称已经构造轨道或证明ODE。Mat3上的矩阵逆为全定义运算，但可逆惯性张量上的限制完全忠实；定义本身不宣称奇异T有物理意义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.eulerRigidField`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2766)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-FreeRigidSolution · definition · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $`\dot\pi=\pi\times T^{-1}\pi`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) (_hI : IsOpen I) (_hT : T.PosDef) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.freeRigidSolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 采用开放时间域和正定惯性张量，明确within导数就是实际经典导数；Mathlib标准定义按用户约定直接采信，不再因未复制定义体待人工。 | [EXTRA] |

[EXTRA] [EXTRA] 采用开放时间域和正定惯性张量，明确within导数就是实际经典导数；Mathlib标准定义按用户约定直接采信，不再因未复制定义体待人工。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；freeRigidSolution 显式接收T、π:ℝ→V、I:Set ℝ、IsOpen I和T.PosDef，定义为每个t∈I的实际向量导数等于Euler场。开放性使点内within导数等价于经典导数；实PosDef含对称性且保证可逆。没有把零导数、守恒性或存在性作为替代。原书没有命名此解关系，context\_notation已明示这是形式化选择。

### 7. 状态与证明位置

self-contained；`MD.Ch04.freeRigidSolution`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2770)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidInvariants · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> Thus the Euler equations are in the form of a Hamiltonian system on a three-dimensional phase space. The symplectic structure matrix is dependent on the phase variables, and it is degenerate: $`\widetilde J\pi=\pi\times\pi=0`$, signifying that total angular momentum is conserved: $`\|\pi\|=\mathrm{constant}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidInvariants :
  ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → MolecularDynamics.Chapter04Review.freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) ∧
      MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
  intro T π a b hT hab hπ hsol
  have hsym : (T⁻¹)ᵀ=T⁻¹ := by
    simpa [Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hcomm : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot u v=MolecularDynamics.Chapter04Review.dot v u := by
    intro u v
    simp [MolecularDynamics.Chapter04Review.dot,mul_comm]
  have htrans : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) (u v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot u (B *ᵥ v)=MolecularDynamics.Chapter04Review.dot (Bᵀ *ᵥ u) v := by
    intro B u v
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hc : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 u v) v=0 ∧ MolecularDynamics.Chapter04Review.dot u (MolecularDynamics.Chapter04Review.cross3 u v)=0 := by
    intro u v
    constructor <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three] <;> ring
  have hd : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) t, t ∈ Icc a b →
      HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (B *ᵥ π s))
      (MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (B *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))) (Icc a b) t := by
    intro B t ht
    have hp := hsol t ht
    have hx : ∀ i, HasDerivWithinAt (fun s => (B *ᵥ π s) i) ((B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) i) (Icc a b) t := by
      intro i
      change HasDerivWithinAt (fun s => ∑ j, B i j*π s j) (∑ j,B i j*MolecularDynamics.Chapter04Review.eulerRigidField T (π t) j) (Icc a b) t
      apply HasDerivWithinAt.fun_sum
      intro j hj
      exact (hasDerivWithinAt_pi.mp hp j).const_mul (B i j)
    have h := HasDerivWithinAt.fun_sum (u := Finset.univ) (fun i _ => (hasDerivWithinAt_pi.mp hp i).mul (hx i))
    simpa [MolecularDynamics.Chapter04Review.dot,Finset.sum_add_distrib] using h
  have he : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (T⁻¹ *ᵥ π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (T⁻¹ *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [htrans T⁻¹ (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)),hsym,hcomm (T⁻¹ *ᵥ π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).1]
    simpa [hz] using hd T⁻¹ t ht
  have hn : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)+MolecularDynamics.Chapter04Review.dot (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [hcomm (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).2]
    simpa [Matrix.one_mulVec,hz] using hd 1 t ht
  have ce : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (he t ht).continuousWithinAt)
    intro t ht
    exact (he t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  have cn : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (hn t ht).continuousWithinAt)
    intro t ht
    exact (hn t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  intro t ht
  exact ⟨ce t ht,cn t ht⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅能量与角动量模长守恒；同段Hamiltonian表示及结构矩阵反对称性由MD-4.4.1-RigidPoissonMatrix、退化由MD-4.4.1-PoissonDegeneracy承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidInvariants` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅保留原页的能量与角动量模长守恒，实际Hamiltonian梯度表示/反对称性由RigidPoissonMatrix补全，退化由PoissonDegeneracy原已有声明承担，完整原文保留。 | [EXTRA] |

[EXTRA] 对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。；[EXTRA] 本条仅保留原页的能量与角动量模长守恒，实际Hamiltonian梯度表示/反对称性由RigidPoissonMatrix补全，退化由PoissonDegeneracy原已有声明承担，完整原文保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；rigidInvariants 对所有T、π、实数a,b，在T.PosDef、a≤b、闭区间连续和真实Euler方程前提下，断言每个t∈[a,b]的π(t)ᵀT⁻¹π(t)及π(t)ᵀπ(t)等于a时刻值。前者是2H̃，后者是欧氏长度平方，缩放和平方均不丢失守恒结论。实际调用的是Chapter04Review.freeRigidSolution，而非条目2带开放域参数的MD.Ch04.freeRigidSolution；不存在把非平凡闭区间强迫为开放集的空前提问题。Hamiltonian表示与退化分别由本批条目4、5覆盖，符合显式statement\_scope。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidInvariants`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2776)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidPoissonMatrix · definition · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $`\dot\pi=\widetilde J(\pi)\nabla\widetilde H`$, where $`\widetilde J(\pi)=\operatorname{skew}(\pi)`$ is obviously skew symmetric, and $`\widetilde H=\pi^TT^{-1}\pi/2`$ is the energy function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π

def rigidBodyHamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (mom : MolecularDynamics.Chapter04Review.V) : ℝ :=
  MolecularDynamics.Chapter04Review.dot mom (T⁻¹ *ᵥ mom)/2

theorem rigidPoissonMatrix_hamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (_hT : T.PosDef) (mom : MolecularDynamics.Chapter04Review.V) :
    (rigidPoissonMatrix mom)ᵀ= -rigidPoissonMatrix mom ∧
    MolecularDynamics.Chapter04Review.eulerRigidField T mom=
      rigidPoissonMatrix mom *ᵥ MolecularDynamics.Chapter04Review.grad (rigidBodyHamiltonian T) mom := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidPoissonMatrix`；`MD.Ch04.rigidBodyHamiltonian`；`MD.Ch04.rigidPoissonMatrix_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留J定义，补实际二次能量定义、真实fderiv梯度Hamiltonian表示及反对称性；正定惯性是物理充分资格，不预设所求梯度公式。 | [EXTRA] |

[EXTRA] [EXTRA] 保留J定义，补实际二次能量定义、真实fderiv梯度Hamiltonian表示及反对称性；正定惯性是物理充分资格，不预设所求梯度公式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已合并审校同一source\_id下三项声明：J̃定义为skewMatrix；H̃定义为dot mom (T⁻¹*ᵥmom)/2；对每个正定实矩阵T和每个mom，给出J̃ᵀ=−J̃与Euler场=J̃乘真实fderiv坐标梯度的合取。正定性提供所需对称性，梯度不是公理化替代。三项共同覆盖原句的能量函数、反对称性与Hamiltonian表示；sorry不改变签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rigidPoissonMatrix`：定义；`MD.Ch04.rigidBodyHamiltonian`：定义；`MD.Ch04.rigidPoissonMatrix_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2832)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-PoissonDegeneracy · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $`\widetilde J\pi=\pi\times\pi=0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonDegeneracy : ∀ π : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ π=0 := by
  intro π
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.poissonDegeneracy` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；poissonDegeneracy 对每个π:V断言Chapter04Review.rigidPoissonMatrix π *ᵥπ=0。该矩阵实际为skewMatrix π，故此结论就是原式π×π=0，并非仅由名称猜测退化。π=0时矩阵本身为零，亦无遗漏；本条选取的是核向量等式，不宣称恒定秩为2或额外Casimir定理。

### 7. 状态与证明位置

self-contained；`MD.Ch04.poissonDegeneracy`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2846)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AxisRotation · definition · 印刷p.173–174 / PDFp.195–196

### 2. 原文陈述

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7). The notation $`\Theta^x(\phi)`$ refers to a rotation around the x-axis by an angle $`\phi`$, that is

$$
\Theta^x(\phi)=\begin{bmatrix}1&0&0\\0&\cos(\phi)&-\sin(\phi)\\0&\sin(\phi)&\cos(\phi)\end{bmatrix},
$$


> with corresponding formulae for $`\Theta^y`$ and $`\Theta^z`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.axisRotation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 不以矩阵名字推断ODE解。 | [EXTRA] |
| 尚未覆盖的结论 | 原印正角是否等于π×ω场的时间h子流，见AxisFlowFormal/ExactPlanarRotation勘误 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA] 三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 不以矩阵名字推断ODE解。

### 6. 审计结论

本轮修复：三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 不以矩阵名字推断ODE解。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；axisRotation 本身的三支矩阵完全正确：i=0给出所印x轴矩阵，i=1与i=2分别是对应右手y、z轴矩阵，且∀φ:ℝ无额外前提。但原JSON的完整statement\_scope包含“Each of these ... easily integrated as a planar rotation”这一单轴ODE可积性结论；同一source\_id所给全部Lean只有矩阵定义，未出现子场、时间、初值、解或积分关系，extra\_assumptions也没有将该句排除/分配。故完整范围的签名FAIL，原因是结论遗漏；不是矩阵符号错误，也不是sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.axisRotation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2853)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-SecondAxisPrinted · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $`\dot\pi=\pi\times[0,T_2^{-1}\pi,0]^T`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def secondAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,a/I 1,0]



/-- 修正版，对应原文 MD-4.4.1-SecondAxisPrinted。改动：将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。 -/
```

独立修正版：

```lean
def secondAxisPrinted_corrected (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (_hI : 0 < I 1) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,π 1/I 1,0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.secondAxisPrinted`；`MD.Ch04.secondAxisPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 为未定义标量引入a供审校，不声称它等于π₂。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。 | [EXTRA] |

[EXTRA] 为未定义标量引入a供审校，不声称它等于π₂。；[ERRATUM?] 将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开Ch04.lean定义得到π×e\_2·(a/I\_2)。依赖没有缺失定义。a是新增独立实参数；若原书无下标π意为独立标量，此参数化可用；若意为动量分量π\_2则a应绑定该分量。原书此标量未定义，不能以参数占位宣称已忠实翻译。惯量由T\_j映射为I\_j符合前文T=diag(I₁,I₂,I₃)的意图，但原式T\_j记法本身也应保留解释记录。[ERRATUM?]缺下标外观确认，数学裁定仍需明确原文标量π含义。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.secondAxisPrinted`：定义；`MD.Ch04.secondAxisPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2862)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-ThirdAxisPrinted · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $`\dot\pi=\pi\times[0,0,T_3^{-1}\pi]^T`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def thirdAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,0,a/I 2]



/-- 修正版，对应原文 MD-4.4.1-ThirdAxisPrinted。改动：将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。 -/
```

独立修正版：

```lean
def thirdAxisPrinted_corrected (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (_hI : 0 < I 2) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,0,π 2/I 2]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.thirdAxisPrinted`；`MD.Ch04.thirdAxisPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]a只为缺下标的印刷标量供审校。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。 | [EXTRA] |

[EXTRA] [EXTRA]a只为缺下标的印刷标量供审校。；[ERRATUM?] 将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开Ch04.lean定义得到π×e\_3·(a/I\_3)。依赖没有缺失定义。a是新增独立实参数；若原书无下标π意为独立标量，此参数化可用；若意为动量分量π\_3则a应绑定该分量。原书此标量未定义，不能以参数占位宣称已忠实翻译。惯量由T\_j映射为I\_j符合前文T=diag(I₁,I₂,I₃)的意图，但原式T\_j记法本身也应保留解释记录。[ERRATUM?]缺下标外观确认，数学裁定仍需明确原文标量π含义。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.thirdAxisPrinted`：定义；`MD.Ch04.thirdAxisPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2875)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-PrincipalAxisField · definition · 印刷p.172 / PDFp.194

### 2. 原文陈述

> If $`T`$ is a diagonal matrix, $`T=\operatorname{diag}(I_1,I_2,I_3)`$, then we split the Euler equations and approximate the solution by successive rotations around the three axes of inertia,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def principalAxisField (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))



/-- 修正版，对应原文 MD-4.4.1-PrincipalAxisField。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def principalAxisField_corrected (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅各单轴子向量场的定义；完整印刷五次复合由MD-4.4.1-PrintedSpinStep承担，精确平面子流解释由MD-4.4.1-ExactPlanarRotation单列待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.principalAxisField`；`MD.Ch04.principalAxisField_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条为单轴分裂场定义；完整印刷五次轴复合由PrintedSpinStep承担，实际子流的负角与原印正角冲突保留AxisFlowFormal/ExactPlanarRotation待导师。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。；[EXTRA] 本条为单轴分裂场定义；完整印刷五次轴复合由PrintedSpinStep承担，实际子流的负角与原印正角冲突保留AxisFlowFormal/ExactPlanarRotation待导师。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；数学上，定义cross3 π (Pi.single i (π i/I i))是对角惯性下合理且正确的单轴分裂场；在I各分量为正的物理域，三个子场之和对应Euler右端，轴编号0,1,2也正确。不得把这个分裂等式推广到任意奇异对角矩阵，因为矩阵总逆与逐分量总除法在奇异处可能不同。本条仅定义场，不声称已证明正角印刷旋转就是其时间h子流。但原书后续第二、第三项确实缺分量下标，当前非明确\_corrected名称的定义采用了补义版本。按原书数学疑误保留并分流要求，整条标NEEDS\_HUMAN，而非将正确的补义场判成数学反例型FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.principalAxisField`：定义；`MD.Ch04.principalAxisField_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2888)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-PrintedSpinAxis · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> $`\pi^k:=\Theta\pi^k;\quad\Theta^k:=\Theta^k\Theta^T`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedSpinAxis (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (h : ℝ) (s : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  let R := MolecularDynamics.Chapter04Review.axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedSpinAxis` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。axisRotation 的三个分支分别是标准正角 x/y/z 旋转矩阵；角度为 hπ\_i/I\_i，返回 (Rπ,ΘRᵀ)，与 PDF196 五行中共同的赋值逐项一致。Fin 3 的 0/1/2 对应印刷 1/2/3；原书物理惯量非零，Lean 对除零的总化并不被声称为物理子流。[ERRATUM?] 成立：对 x 轴 I₁=1、π=(1,1,0)，R\_x(h)π 在 h=0 导数为 (0,0,1)，而 π×(1,0,0)=(0,0,-1)；这里只保留字面算法，没有声称精确求解(4.41)。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedSpinAxis`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2899)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-PrintedSpinStep · definition · 印刷p.174 / PDFp.196

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
def printedSpinStep (I : MolecularDynamics.Chapter04Review.V) (h : ℝ) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 → MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedSpinStep` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。展开 printedSpinAxis 与正式库 axisRotation；函数复合从右向左执行，回文链实际为 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。每次角度使用当前更新后的 π，姿态使用当前 Θ；与 PDF196 Step 3 全部五行一致。该定义没有附加精确子流或几何结构结论；正角符号疑误仍保留。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedSpinStep`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2904)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

