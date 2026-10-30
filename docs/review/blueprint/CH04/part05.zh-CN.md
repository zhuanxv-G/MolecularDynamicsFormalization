[上一部分](part04.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

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

