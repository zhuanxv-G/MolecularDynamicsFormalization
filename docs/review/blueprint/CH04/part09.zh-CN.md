[上一部分](part08.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part10.zh-CN.md)

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

