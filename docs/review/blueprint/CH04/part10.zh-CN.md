[上一部分](part09.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part11.zh-CN.md)

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

