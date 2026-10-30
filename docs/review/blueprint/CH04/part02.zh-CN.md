[上一部分](part01.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-4.2.2-MollifiedStructure · unnumbered_claim · 印刷p.149 / PDFp.171

### 2. 原文陈述

> In each of the mollified multiple timestepping methods, since only the potential energy is modified, and by a smooth mapping of positions, the forces derived by differentiating $`\overline U`$ are still conservative, and, just as with the MTS method, the scheme remains symplectic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mollifiedStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (MolecularDynamics.Chapter04Review.mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m (MolecularDynamics.Chapter04Review.mollifiedPotential US A) UF r h) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mollifiedStructure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。 | [EXTRA] |

[EXTRA] 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；结论：PASS，针对实际RESPA/Verlet实现及任意C²位置映射；原文的两项结构结论均可由所用真实定义读取，不靠名称或sorry判断。实际附件是 /workspace/Ch04.lean；在 input\_sha256 中按请求使用逻辑键 Blueprint/Ch04.lean。以下为只读签名及定义审计，未编辑附件、未补证明、未将compact摘录作为独立工程编译。
全部对象与量词顺序：∀n:ℕ、m:Fin n→ℝ、US UF:Q n→ℝ、A:Q n→Q n、r:ℕ、h:ℝ，随后依次假设∀i,0<m i、ContDiff ℝ 2 US、ContDiff ℝ 2 UF、ContDiff ℝ 2 A、0<r。结论为链式法则与辛性之合取；链式法则再对所有q,v:Q n量化。h未被要求为小正数，无隐藏依赖顺序或先假设结论。
复合势与保守力展开：库 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean 的mollifiedPotential US A=US∘A，Q n=Fin n→ℝ。第一合取为D(US∘A)(q)[v]=DUS(A(q))[DA(q)[v]]。同文件grad U q=textbookConstraintGradient U q，而 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean 的后者逐分量给出DU(q)[e\_i]。kick U t(q,p)=(q,p−t grad U(q))，故实际慢力F\_i(q)=−D(US∘A)(q)[e\_i]=−DUS(A(q))[DA(q)e\_i]，即全局标量势的负梯度。原文 conservative 虽未单独引入谓词，但实际力及其势的关系已被这些定义直接表达，未漏用DA，也未把力保守作为前提。
算法展开：respa m U UF r h(q,p)=kick U(h/2)((fastVerlet m UF(h/r))^[r](../../kick U(h/2)(q,p)))，其中U=US∘A。fastVerlet=Chapter02Review.verlet m(−grad UF)；展开 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 的verlet及invMass，给出q⁺=q+tM⁻¹p−t²M⁻¹grad UF(q)/2和p⁺=p−t(grad UF(q)+grad UF(q⁺))/2。快势和快步未被复合映射替换，只有慢势kick使用复合势，符合原页紧接着的 only applied ... modifying the slow impulse 的解释。任意C²的A覆盖本批所谈位置映射，不要求A为可逆映射、辛映射或平均构造。
辛性结论展开：同一库文件Z n=Q n×Q n，dot a b=Σ\_i a\_i b\_i，phaseForm(u,v)=Σ\_i u\_qi v\_pi−Σ\_i v\_qi u\_pi。symplecticMap G真正声明∀z,u,v，phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)，即标准辛形式的实际Fréchet导数拉回。该算法在给定C²假设下有C¹梯度和C¹更新，故不存在靠不可微点的fderiv默认值空洞表达辛性的情形。此处不是只检验行列式或抽象性质。
[EXTRA]逐项评估：正质量为原物理常质量的合理资格，数学上非零质量已足够，正性不是最弱假设；US、UF、A的C²确保复合势C²、梯度C¹及Hessian对称，是保结构所需的合理充分光滑性，比原 smooth 的无限光滑要求更弱而不损失该结论；r>0保证自然数细分及h/r有实际步数意义，排除了无快步的r=0退化情形，虽该退化代数映射也可单独保辛。上述条件均未假设待证链式法则、保守性或辛性。以实际RESPA和fastVerlet表达是批次明确采用的实现范围，不声称证明了未指定的任意快积分器也辛。
[ERRATUM?]：本条无该标注，所引原文未发现需要改写的数学错误。证明状态独立记录：Ch04.lean中mollifiedStructure的证明体是by sorry；依赖Statements.lean的mollifiedStructure\_statement只是对应Prop定义。PASS仅指签名和展开后语义忠实，不表示证明已完成或编译验证通过。

### 7. 状态与证明位置

incomplete；`MD.Ch04.mollifiedStructure`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L911)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-HolonomicRelation · (4.3) · 印刷p.149–150 / PDFp.171–172

### 2. 原文陈述

> In this section we consider holonomic constraints which may be expressed in terms of positions only, and perhaps time, i.e.

$$
g(q,t)=0.\tag{4.3}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.holonomicRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；g的位置参数为Q n、显式时间参数为ℝ、值为Q l；沿给定位置曲线对每个实时间要求g(q(t),t)=0。没有独立动量参数或错误地删除显式时间依赖。它是全实轴曲线满足完整约束的定义，不是声称任意曲线均满足约束。

### 7. 状态与证明位置

self-contained；`MD.Ch04.holonomicRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L919)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-TimeConstraintDerivative · unnumbered_claim · 印刷p.150 / PDFp.172

### 2. 原文陈述

> Note that by differentiating (4.3) with respect to time, we obtain $`\nabla_q g(q,t)\cdot\dot q+\partial g/\partial t=0`$ which involves velocities.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem timeConstraintDerivative :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0 := by
  intro n l g q t v hg hq hz
  have hp : HasDerivAt (fun s : ℝ => (q s,s)) (v,1) t := hq.prodMk (hasDerivAt_id t)
  have hd : HasDerivAt (fun s => g (q s) s)
      ((fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)) t :=
    hg.hasFDerivAt.comp_hasDerivAt (f := fun s : ℝ => (q s,s)) t hp
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz
  exact hd.unique hzero
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.timeConstraintDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。 | [EXTRA] |

[EXTRA] g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 Function.uncurry g 的对象是位置×时间；量词为任意 n,l,g,q,t,v，依次要求联合可微、q 在 t 的实际导数为 v、局部约束恒等于零，结论为 Dg(q(t),t)(v,1)=0。该结论按线性性展开正是 D\_qg·q̇+∂_tg=0；联合可微和曲线可微是原文链式求导所需的合理 [EXTRA]，局部恒零足以且比全时恒零弱，没有把所求结论作前提。Ch04.lean:576–587 给出链式法则和导数唯一性证明，无 sorry；本结论仍为签名审计而非编译验证。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.timeConstraintDerivative`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L924)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstrainedSolution · (4.4)–(4.9) · 印刷p.152 / PDFp.174

### 2. 原文陈述

> the equations of motion may be written

$$
\dot q=M^{-1}p,\tag{4.4}
$$



$$
\dot p=-\nabla U(q)-\sum_{k=1}^l\lambda_k\nabla g_k(q),\tag{4.5}
$$



$$
0=g_j(q),\quad j=1,2,\ldots,l.\tag{4.6}
$$


> then we may write the constrained equations of motion in the form

$$
\dot q=M^{-1}p,\quad\text{(4.7)}\qquad\dot p=-\nabla U(q)-g'(q)^T\lambda,\quad\text{(4.8)}\qquad0=g(q).\quad\text{(4.9)}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

def constrainedSolution_generalForce {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedSolution`；`MD.Ch04.constrainedSolution_generalForce` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。 | [EXTRA] |

[EXTRA] [EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主定义在开时间域I逐时要求真实HasDerivAt：q′=m⁻¹p、p′=−grad U−Gᵀρ及每个标量约束为零。m分量严格正、U及所有g\_j可微都显式给出；grad和G来自实际Fréchet导数，矩阵转置乘法正是逐约束求和。ρ是待检验曲线的参数而非已假设存在的乘子。generalForce允许任意F及within导数，作为明确命名的辅助定义保留合理；一般域包含退化域，因此不可单独当经典运动的主接口。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedSolution`：定义；`MD.Ch04.constrainedSolution_generalForce`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L939)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintSet · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> Constraints such as those described above define a manifold in the configuration space $`\mathcal M=\{q\mid g(q)=0\}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry



/-- 修正版，对应原文 MD-4.3-ConstraintSet。改动：修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。 -/
```

独立修正版：

```lean
theorem constraintSet_corrected (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintSet`；`MD.Ch04.constraintSet_regularLevel`；`MD.Ch04.constraintSet_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。 | [EXTRA] |

[EXTRA] 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。；[EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；零点集合定义忠实。regularLevel在l≤n、各g\_j光滑、q为零点及真实向量导数满射的EXTRA条件下给出开邻域、双向光滑互逆坐标、q映至0及前l个坐标为零的完整等价，确实是余维l局部嵌入流形正规形。∞用于C∞符合目标。修正版签名正确，但原句未注明正则性即泛称流形，不能用增加前提消除原书疑误。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constraintSet`：定义；`MD.Ch04.constraintSet_regularLevel`：未证（原书疑误不证）；`MD.Ch04.constraintSet_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L961)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-CotangentSet · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> The set of pairs $`(q,p)`$ satisfying, simultaneously, the equations

$$
g(q)=0,\qquad g'(q)M^{-1}p=0,
$$


> is called the co-tangent bundle associated to the manifold $`\mathcal M`$, and we refer to it as $`T^*\mathcal M`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentSet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量及独立梯度为几何解释资格。 | [EXTRA] |

[EXTRA] 正质量及独立梯度为几何解释资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 定义的元素确为相空间中的(q,p)，两个且仅两个集合成员条件逐分量展开为 g(q)=0 与 g′(q)M⁻¹p=0；未漏掉同时满足要求。原文在这里用这两个等式命名其嵌入相空间的余切集合，该集合实现忠实，不能据此宣称已经构造抽象余切丛。正质量保证质量逆的物理解释，梯度独立和光滑性保证基底流形及通常余切丛解释；[EXTRA] 为这些解释资格而非成员条件中额外过滤条件，合理。任意 m,g 的总化扩展不能单独承载上述几何解释，但不改变本条所给集合等式。定义无 sorry。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cotangentSet`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L998)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintJacobian · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> It is often convenient to combine all the constraints and to describe them by a single vector-valued function $`g:\mathbb R^{N_c}\to\mathbb R^l`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i

def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintJacobian`；`MD.Ch04.combineConstraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 在同一source\_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。 | [EXTRA] |

[EXTRA] [EXTRA] 在同一source\_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；combineConstraints把Fin l族标量函数按q↦(j↦g\_j(q))组合成Q n→Q l，完整覆盖原句。constraintJacobian的行j列i为真实Fréchet导数在第i个基向量上的取值，尺寸l×n，作为相邻(4.8)的附加对象已被EXTRA区分；没有只交付Jacobian而遗漏向量函数。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintJacobian`：定义；`MD.Ch04.combineConstraints`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1003)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-JacobianActualDerivative · unnumbered_claim · 印刷p.152 / PDFp.174

### 2. 原文陈述

> Given a motion $`(q(t),p(t),\lambda(t))`$ of (4.7)–(4.9) we note that $`g(q(t))\equiv0`$ at all times $`t`$, hence, by differentiation

$$
g'(q(t))\dot q(t)\equiv0,
$$


> which we may rephrase as

$$
g'(q(t))M^{-1}p(t)\equiv0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem jacobianActualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap := by
  apply MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative <;> assumption

theorem jacobianActualDerivative_curve (n l : ℕ)
    (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (p v : MolecularDynamics.Chapter04Review.Q n) (t : ℝ)
    (_hg : ∀ j, DifferentiableAt ℝ (g j) (q t)) (_hq : HasDerivAt q v t)
    (_hv : v=MolecularDynamics.Chapter04Review.invMass m p)
    (_hc : ∀ᶠ s in 𝓝 t, ∀ j, g j (q s)=0) :
    textbookConstraintJacobian g (q t) *ᵥ v=0 ∧
    textbookConstraintJacobian g (q t) *ᵥ MolecularDynamics.Chapter04Review.invMass m p=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.jacobianActualDerivative`；`MD.Ch04.jacobianActualDerivative_curve` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。 | [EXTRA] |

[EXTRA] [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。；[EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；首声明在各标量函数于q可微时把实际Jacobian等同向量函数Fréchet导数的标准矩阵。curve声明在任意时刻t、实际速度v、v=m⁻¹p及邻域内所有约束恒零的前提下，同时给出Gv=0和Gm⁻¹p=0。局部邻域恒零是从完整运动中抽取的足够条件；未循环假设隐藏约束。只需速度方程，不需无关的加速度/乘子前提。

### 7. 状态与证明位置

incomplete；`MD.Ch04.jacobianActualDerivative`：已证；`MD.Ch04.jacobianActualDerivative_curve`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1015)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintDegrees · unnumbered_claim · 印刷p.151 / PDFp.173

### 2. 原文陈述

> Note that with $`l`$ constraints the actual number of degrees of freedom, which is needed for things like the computation of temperature, is $`N_d=N_c-l`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constraintDegrees :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l) (q : MolecularDynamics.Chapter04Review.Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n := by
  intro n l g q hg hs
  have hh := LinearMap.finrank_range_add_finrank_ker (fderiv ℝ g q).toLinearMap
  rw [LinearMap.range_eq_top.mpr hs] at hh
  simpa [add_comm] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintDegrees` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。 | [EXTRA] |

[EXTRA] [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 量词依次为维数 n,l、真实向量约束 g 和点 q，再给可微及真实导数满射条件；结论 dim ker Dg+l=n 等价于独立约束下 Nd=Nc−l。满射保证 l≤n，避免自然数截断伪装维数关系；没有把维数关系作为前提。原文未显式说独立约束，但这是自由度公式必要而合理的 [EXTRA]，例如重复约束不应重复扣减。当前结论是线性化可行速度空间的维数；如进一步声称零集为光滑流形，还需合适邻域光滑性，当前定理不含此额外几何声称。Ch04.lean:621–630 的证明用秩零化度公式，无 sorry。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintDegrees`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1035)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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

## 1. MD-4.3.2-HiddenEulerError · unnumbered_claim · 印刷p.156 / PDFp.178

### 2. 原文陈述

> The hidden constraint $`g'(q_0)M^{-1}p_0=0`$ will be violated, but one hopes it remains approximately satisfied. The justification for the latter assumption is that if we expand $`g`$ in a Taylor series, we may write

$$
g(q_n)\approx g(q_{n+1})+g'(q_{n+1})(q_n-q_{n+1}).
$$


> Then since we maintain $`g(q_n)=0`$ for all $`n`$, we have

$$
g'(q_{n+1})M^{-1}p_{n+1}\approx0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hiddenEulerError :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (out : ℝ → MolecularDynamics.Chapter04Review.Z n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 out → out 0=z →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, MolecularDynamics.Chapter04Review.positionEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (out h) (rho h)) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      ‖textbookConstraintJacobian g (out h).1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (out h).2‖ ≤ C*h := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.hiddenEulerError` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。 | [EXTRA] |

[EXTRA] C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:796–803 全称量化固定旧状态z及真实out(h),rho(h)，随后给存在C,δ及全体0<h<δ的O(h)界。依赖4445–4448展开为+ h(−grad U)动量更新、q(h)=q₀+h invMass p(h)、全部位置约束。区间含0且out(0)=z，故初位置合法已蕴含；对位置恒等式在0求导并对g(q(h))=0求导得初隐约束，再由C²约束及分支得到残差C¹、在0为0，因而O(h)。C²实际分支是合理的局部条件，但比原文更强，且只论单步局部h界，不保证长时间一致误差。力符号不影响这个几何论证。原文“will be violated”是泛指通常不精确保持，非所有例子必非零（线性约束可精确保持）。签名合理形式化该近似结论；证明体为 sorry，未验证证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.hiddenEulerError`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1304)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-ProjectionResidual · (4.17) · 印刷p.156 / PDFp.178

### 2. 原文陈述

> To solve the Eqs. (4.14)–(4.16), insert the second in the first and the first then in the third to obtain the simplified equation

$$
g(Q_n-M^{-1}G_n^T\Lambda)=0,\tag{4.17}
$$


> where

$$
Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n,\qquad G_n=g'(q_n),\qquad\Lambda=h^2\lambda_n.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))

def projectionEquation {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  projectionResidual m g q base η=0

theorem projectionResidual_elimination {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Fprinted : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n)
    (lam : MolecularDynamics.Chapter04Review.Q l)
    (_hp : out.2=z.2-h • Fprinted z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ lam))
    (_hq : out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2) :
    (out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g) ↔
      projectionEquation m g z.1
        (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-
          h^2 • MolecularDynamics.Chapter04Review.invMass m (Fprinted z.1)) (h^2 • lam) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectionResidual`；`MD.Ch04.projectionEquation`；`MD.Ch04.projectionResidual_elimination` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m、l 个位置约束 g、旧位置 q、给定预测位置 base 和乘子 η，projectionResidual 的值域为 Q l，逐分量为 g\_j(base−M^{-1}G(q)^Tη)；projectionEquation 正确规定该向量等于零，不宣称根存在。消元声明另量化 Fprinted、实步长 h、旧/新相点 z/out 和 lam；前提完整保留原印 out.p=z.p−hFprinted(z.q)−hG(z.q)^Tlam 与 out.q=z.q+hM^{-1}out.p，结论将 out.q 的全部位置约束为零等价为 base=z.q+hM^{-1}z.p−h²M^{-1}Fprinted(z.q)、η=h²lam 的零残差方程。固定对角逆质量的线性性使该等价对全部实 h 成立，含 h=0；未除以 h，亦不需要正质量或可逆 Gram 才能陈述此代数等价。Fprinted 明确按原印符号使用，不在本条擅改为常见力记号；[EXTRA] 补充消元等价与零残差资格准确。

### 7. 状态与证明位置

incomplete；`MD.Ch04.projectionResidual`：定义；`MD.Ch04.projectionEquation`：定义；`MD.Ch04.projectionResidual_elimination`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1315)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-ProjectionJacobian · definition · 印刷p.157 / PDFp.179

### 2. 原文陈述

> $`R^{(l)}\Delta\Lambda^{(l)}=g(Q^{(l)}),\qquad R^{(l)}\stackrel{\mathrm{def}}=g'(Q^{(l)})M^{-1}G_n^T`$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ

def projectionNewtonIncrement {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n)
    (η ηnext : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  let Δ := ηnext-η
  projectionJacobian m g q base η *ᵥ Δ=projectionResidual m g q base η
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectionJacobian`；`MD.Ch04.projectionNewtonIncrement` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η\_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。 | [EXTRA] |

[EXTRA] [EXTRA] 保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η\_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m,g、q/base∈Q n、η∈Q l，projectionJacobian 的行列均索引于 Fin l，实际为 G(base−M^{-1}G(q)^Tη)M^{-1}G(q)^T；各乘法维数正确且当前 Jacobian 的求值点为 Q^(l)，右侧固定 Jacobian 的求值点为旧 q。projectionNewtonIncrement 对额外的 ηnext 定义 Δ=ηnext−η，完整命题为 R(η)Δ=r(η)，同时保留源文线性方程和增量含义。R 为残差对 η 的负 Jacobian，因此 Newton 更新是加号；没有把 R 误称为正的残差导数。两个都是定义，不要求矩阵可逆，也不宣称增量存在、唯一或已求解。[EXTRA] 对线性方程的补充说明准确。

### 7. 状态与证明位置

self-contained；`MD.Ch04.projectionJacobian`：定义；`MD.Ch04.projectionNewtonIncrement`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1339)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-NewtonConstraint · (4.18)–(4.19) · 印刷p.157 / PDFp.179

### 2. 原文陈述

> The simplest is Gauss-Newton iteration, which may be written

$$
\Lambda^{(l+1)}=\Lambda^{(l)}+[g'(Q^{(l)})M^{-1}G_n^T]^{-1}g(Q^{(l)}),\tag{4.18}
$$



$$
Q^{(l)}:=Q_n-M^{-1}G_n^T\Lambda^{(l)},\tag{4.19}
$$


> which might be initialized with $`\Lambda^{(0)}=0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η

def newtonConstraintSequence {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ)
    (_hvalid : ∀ i < k,
      (MolecularDynamics.Chapter04Review.projectionJacobian m g q base
        ((MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[i] 0)).det ≠ 0) :
    MolecularDynamics.Chapter04Review.Q l :=
  (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.newtonConstraint`；`MD.Ch04.newtonConstraintSequence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。 | [EXTRA] |

[EXTRA] [EXTRA] 真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主接口对任意 n,l,m,g、q/base 和 η，显式要求当前 R(η).det≠0，返回 η+R(η)^{-1}r(η)，与原印公式完全一致；该前提是合法求解步所需的 [EXTRA] 资格，不是假设误差结论。有限序列另量化 k∈ℕ，使用带完整命名空间的 MolecularDynamics.Chapter04Review.newtonConstraint（无证明参数的底层总函数）从 0 迭代 k 次；_hvalid 要求每个 i<k 时该实际轨道上的 R 均非奇异。因此前 k 次更新均合法，k=0 返回 0 且条件空真，不误要求最终第 k 个点处还需可逆。已区分底层函数与 MD.Ch04.newtonConstraint 的签名，未把带 det 证明参数的接口直接当作可迭代自映射，也未因逆矩阵总化而接受奇异点为合法 Newton 步。

### 7. 状态与证明位置

self-contained；`MD.Ch04.newtonConstraint`：定义；`MD.Ch04.newtonConstraintSequence`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1353)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-FrozenNewtonConstraint · definition · 印刷p.157 / PDFp.179

### 2. 原文陈述

> we may be able to fix $`R`$ at the beginning of the timestep, factor it once only, and then solve at each iteration with the same factors. Moreover, in case we have chosen $`\Lambda^{(0)}=0`$, we have

$$
R^{(0)}=G_nM^{-1}G_n^T,
$$


> which is a symmetric matrix,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η



/-- 修正版，对应原文 MD-4.3.2-FrozenNewtonConstraint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def frozenNewtonConstraint_corrected {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.frozenNewtonConstraint`；`MD.Ch04.frozenNewtonConstraint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:823–825及依赖4459–4461固定的是R(0)=G(base)DG(q)ᵀ。这属于合理的冻结Newton实现，但未忠实表达原文另外声称的旧位置Gram等式、对称性以及一次分解复用。所标[ERRATUM?]一般成立；不能把正确的交叉矩阵版本当作已表达错误原式。若显式采用修订语义，可保留实现并对原式另标疑误。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.frozenNewtonConstraint`：定义；`MD.Ch04.frozenNewtonConstraint_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1370)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-NewtonQuadratic · unnumbered_claim · 印刷p.157 / PDFp.179

### 2. 原文陈述

> When the solution is unique, the constraints sufficiently smooth, and the determinant of $`R`$ is bounded well away from zero, Newton’s method has a very rapid asymptotic convergence property. It is possible to show that, if $`\Lambda_*`$ is the solution of (4.17), then sufficiently near the zero we have

$$
\|\Lambda^{(l+1)}-\Lambda_*\|\le C\|\Lambda^{(l)}-\Lambda_*\|^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newtonQuadratic :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ → ‖MolecularDynamics.Chapter04Review.newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.newtonQuadratic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。 | [EXTRA] |

[EXTRA] 局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m,g、固定 q/base 和 root，前提为每个 g\_j∈C²、r(root)=0、R(root).det≠0；结论的量词为 ∃C>0,∃δ>0,∀η,‖η−root‖<δ→‖N(η)−root‖≤C‖η−root‖²。这里 r(η)=g(base−M^{-1}G(q)^Tη)，Dr(η)=−R(η)，N(η)=η+R(η)^{-1}r(η)，因而确为通常 Newton 映射而非反号更新。C² 及根处非奇异可在缩小的邻域给出有界逆矩阵和二阶 Taylor 余项，足以支持完整二次界；无需把全局唯一性和全域 determinant 下界作为额外前提。m 不要求逐项正也不破坏该一般方程的局部 Newton 结论，因为有效正则性由 R(root) 非奇异直接给出。该声明是局部一步误差估计；继续缩小 δ 可用于迭代收敛，但本次不冒充已另建收敛序列或已完成 sorry 证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.newtonQuadratic`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1383)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-FrozenNewtonLinear · unnumbered_claim · 印刷p.157 / PDFp.179

### 2. 原文陈述

> When $`R`$ is evaluated only once per step, the asymptotic convergence of Newton’s method is linear, i.e. we have instead

$$
\|\Lambda^{(l+1)}-\Lambda_*\|\le\widehat C\|\Lambda^{(l)}-\Lambda_*\|,
$$


> sufficiently near to the solution.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenNewtonLinear :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0).det ≠ 0 →
    ‖fderiv ℝ (MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base) root‖ < 1 →
    ∃ C ∈ Ioo (0 : ℝ) 1, ∃ δ > 0, ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ →
      ‖MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base η-root‖ ≤ C*‖η-root‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.frozenNewtonLinear` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。 | [EXTRA] |

[EXTRA] [EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m,g、q/base、root，前提完整包括 g\_j∈C²、真实根 r(root)=0、固定矩阵 R(0).det≠0，以及实际冻结映射 T(η)=η+R(0)^{-1}r(η) 在 root 的 Fréchet 导数算子范数严格小于 1。结论为存在 0<C<1 和 δ>0，使所有 ‖η−root‖<δ 的 η 满足 ‖T(η)−root‖≤C‖η−root‖。根条件给 T(root)=root，光滑性与根处导数范数严格小于 1 足以支持邻域的一步收缩界，未直接把待证误差界放进前提。冻结点是乘子 η=0，矩阵不随 η 更新，与零初值语境一致。[EXTRA] 正确限制了源文的 small-step 收敛说法；本声明给“至少有线性收缩界”，没有断言精确收敛阶必为 1，也没有声称所有冻结迭代都自动收敛。

### 7. 状态与证明位置

incomplete；`MD.Ch04.frozenNewtonLinear`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1392)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-ProjectionScale · unnumbered_claim · 印刷p.158 / PDFp.180

### 2. 原文陈述

> It is worth noting that $`\Lambda(h)=\mathcal{O}(h^2)`$, i.e. for small steps $`\Lambda`$ will also be small. This justifies the initial guess $`\Lambda^{(0)}=0`$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem projectionScale :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (η : ℝ → MolecularDynamics.Chapter04Review.Q l), z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectionResidual m g z.1 (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-h^2 • MolecularDynamics.Chapter04Review.invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-4.3.2-ProjectionScale。改动：独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。 -/
```

独立修正版：

```lean
theorem projectionScale_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (η : ℝ → MolecularDynamics.Chapter04Review.Q l), z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectionResidual m g z.1 (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-h^2 • MolecularDynamics.Chapter04Review.invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectionScale`；`MD.Ch04.projectionScale_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] F按原印F\_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。 | [EXTRA] |

[EXTRA] 给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。；[EXTRA] F按原印F\_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。；[ERRATUM?] 独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。

### 6. 审计结论

本轮修复：F按原印F\_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；签名量化任意 n,l,m、位置力 F:Q n→Q n、约束 g、初始相点 z 及分支 η:ℝ→Q l；假设 z∈cotangentSet、g\_j∈C²、η∈C²、η(0)=0、Gram(z.q).det≠0，以及某个双侧开邻域内的实际零残差根方程。完整结论为存在 C>0、δ>0，对全部 h∈(−δ,δ) 有 ‖η(h)‖≤Ch²，包含 h=0。作为当前所写“加号预测器”的条件数学定理，该结论正确：由根方程在 0 的一阶微分、初始隐藏约束和 Gram 可逆得到 η′(0)=0，再由 C² 分支得到二阶界；F 只在固定 z.q 处取值，故无需 F 对位置可微。没有循环假设 O(h²)，也没有宣称已找到根分支。然而原文/notation 的预测器是 z.q+hM^{-1}z.p−h²M^{-1}F\_n，当前签名却写成加号，且未注明反号变量关系或修正版，故源文对应审校为 FAIL，而非数学定理本身被反例否定。原书 O(h²) 适用范围的疑问另在 json\_review 标记 NEEDS\_HUMAN，保持原文并交由人工判断。

### 7. 状态与证明位置

incomplete；`MD.Ch04.projectionScale`：未证（原书疑误不证）；`MD.Ch04.projectionScale_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1405)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-FrozenGramPrinted · unnumbered_claim · 印刷p.157 / PDFp.179

### 2. 原文陈述

> Moreover, in case we have chosen $`\Lambda^{(0)}=0`$, we have

$$
R^{(0)}=G_nM^{-1}G_n^T,
$$


> which is a symmetric matrix,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenGramPrinted :
    ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n),
      MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0 = textbookConstraintGram m g q := by
  sorry



/-- 修正版，对应原文 MD-4.3.2-FrozenGramPrinted。改动：真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。 -/
```

独立修正版：

```lean
theorem frozenGramPrinted_corrected :
    ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n),
      MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0 = textbookConstraintJacobian g base * textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.frozenGramPrinted`；`MD.Ch04.frozenGramPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。 | [EXTRA] |

[EXTRA] [ERRATUM?] 真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；核对位置：Ch04.lean LF 859–864。Q n 在 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean LF 4377 展开为 Fin n → ℝ。正式库 projectionJacobian 的完整定义位于同文件 LF 4452–4455：R(η)=J(base−D J(q)ᵀη)D J(q)ᵀ，其中 invMass 的坐标式在 LF 4381，等价于 D=diag((m i)⁻¹) 的乘向量作用。J(x) 的每项为真实偏导 (fderiv ℝ (g j) x)(Pi.single i 1)，来自 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean LF 2975–2977 及 -- FILE: MolecularDynamics/Chapter04/CotangentProjection.lean LF 3385–3387；D 的定义在后者 LF 3413–3414，textbookConstraintGram 在 LF 3417–3420 实际为 J(q)D J(q)ᵀ。令 η=0 后，左边是 J(base)D J(q)ᵀ；右边则是 J(q)D J(q)ᵀ。
对象与量词：签名先对 n,l,m,g,q,base 全称量化，随后无任何假设就断言两矩阵相等。这逐字承接了原书所印等式，但原书 (4.19) 和同页 R 的定义并不支持它；本条 [ERRATUM?] 成立，问题已可由完整定义和反例判定，无需因“缺定义”转交人工。正质量、C² 约束、旧点满足约束、约束 Jacobian 满行秩、预测点任意接近旧点、甚至 R(0) 可逆，都不能补救该无条件等式。
缺失结论：原摘录还明确说“which is a symmetric matrix”，Lean 签名仅给等式，没有列出 R(0) 的对称性断言。右端 Gram 的确对称，因为 D 为实对角矩阵；但实际左端是两个不同位置 Jacobian 的交叉乘积，一般连对称性也不成立。在正确的同点或同 Jacobian 限定下，等式可用于推导对称性；要审查全部结论子句，应把这一性质在对应正确声明中显式列出，而不能靠错误等式充当其依据。
本条没有 [EXTRA] 假设；修复必须清楚区分“保留原书勘误记录”和“新增可证明的正确声明”，不得直接修改 corrected\_json 的原文等式。
证明状态单独记录：Ch04.lean LF 863–864 为 := by / sorry。FAIL 来自展开定义后的错误普遍等式及缺失结论，与 sorry 是否存在是两个独立问题。

### 7. 状态与证明位置

incomplete；`MD.Ch04.frozenGramPrinted`：未证（原书疑误不证）；`MD.Ch04.frozenGramPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1435)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.3-ComponentPrinted · definition · 印刷p.158 / PDFp.180

### 2. 原文陈述

> In general, we perform a sequence of updates

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
def componentPrinted {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)



/-- 修正版，对应原文 MD-4.3.3-ComponentPrinted。改动：把一般分量式分母中的G_j^1明确改为当前约束在旧点的梯度G_n^j，与分子所用方向一致；原Gsup1参数版完整保留。 -/
```

独立修正版：

```lean
def componentPrinted_corrected {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.componentPrinted`；`MD.Ch04.componentPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Gsup1是未定义印刷G\_j^1的显式参数，未假设它等于已定义梯度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 把一般分量式分母中的G\_j^1明确改为当前约束在旧点的梯度G\_n^j，与分子所用方向一致；原Gsup1参数版完整保留。 | [EXTRA] |

[EXTRA] [EXTRA]Gsup1是未定义印刷G\_j^1的显式参数，未假设它等于已定义梯度。；[EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。；[ERRATUM?] 把一般分量式分母中的G\_j^1明确改为当前约束在旧点的梯度G\_n^j，与分子所用方向一致；原Gsup1参数版完整保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；位置域为Fin n→ℝ，约束族Fin l，j任意；质量逐坐标为正，旧点q与当前点Qnow可微，当前标量分母非零。dot、grad、invMass展开后，返回值正是Qnow−[g\_j(Qnow)/(∇g\_j(Qnow)ᵀM⁻¹Gsup1\_j)]M⁻¹∇g\_j(q)。未把Gsup1认作梯度；这忠实保留原印分母G\_j^1，与更新方向G\_n^j分开。[EXTRA]均已明示，单步范围明确；但原印G\_j^1未定义，数学含义仍需人工确认。

### 7. 状态与证明位置

self-contained；`MD.Ch04.componentPrinted`：定义；`MD.Ch04.componentPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1457)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.3-ComponentConstraintStep · definition · 印刷p.158 / PDFp.180

### 2. 原文陈述


$$
\Delta\Lambda_1=[\nabla g_1(Q)^TM^{-1}G_n^1]^{-1}g_1(Q).
$$


> We then update $`Q`$ by

$$
Q:=Q-M^{-1}G_n^1\Delta\Lambda_1,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.componentConstraintStep` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。 | [EXTRA] |

[EXTRA] [EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。；[EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n,l、正对角质量、约束族、旧位置q、当前位置Qnow和j，返回当前梯度与旧梯度形成的非零标量分母所给Newton分量更新。j=0对应印刷首项1，一般j是已披露的统一梯度解释；不是断言一步达到g\_j=0。旧点/当前点可微及分母非零均显式限定。[EXTRA]中提Gsup1属于串入的另一条注释，不是本声明参数。

### 7. 状态与证明位置

self-contained；`MD.Ch04.componentConstraintStep`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1479)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

