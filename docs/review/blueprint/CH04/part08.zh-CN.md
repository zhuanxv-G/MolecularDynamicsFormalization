[上一部分](part07.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part09.zh-CN.md)

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

