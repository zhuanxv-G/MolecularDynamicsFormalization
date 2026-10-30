[上一部分](part04.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

## 1. MD-2.3.2-AsymmetricArea · unnumbered_claim · 印刷p.75–76 / PDFp.97–98

### 2. 原文陈述

> In the event that the vector field is divergence free, we have $`f_u+g_v=0`$ which implies that the numerator and denominator are identical, and it follows that $`\det\mathcal G_h'=1`$. Thus the asymmetric variant of the Euler method is area preserving, even though the standard Euler method is not.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem asymmetricArea :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.asymmetricArea` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。 | [EXTRA] |

[EXTRA] f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。；[EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:674–685；展开Q、真实asymmetricEulerRelation和标准坐标Jacobian（合集2816、2880–2881、2365–2370行），volume为有限实乘积空间的无向Lebesgue体积。先任意f,g,Ψ,h，再三项C¹、处处更新关系、∀u v的真实偏导和为零、解取值点的处处分母非零及Ψ单射；结论同时保留∀z det=1与全部可测T的像面积相等。偏导均在(U,v)取值；散度零给1+h g\_v=1-h f\_u，因此点态det=1；C¹、单射及绝对行列式换元给全局集合面积保存。[EXTRA]C¹、实际解映射和分母非零是合理的可微分支条件，全球版本强于原书局部计算但解释清楚。单射是保证全局换元的合理明确充分条件；不是声称这些其余假设必然不能推出它，不能泛称其独立必要性。仅det=1的一般映射不足以推出全局像面积相等，因此此额外条件与所选全球结论相称。无ERRATUM。证明体含sorry；语义与证明完成分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.asymmetricArea`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L905)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticMap · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> Let $`m=2N_c`$. A symplectic map $`\Phi:\mathbb R^m\to\mathbb R^m`$ is one that preserves the symplectic differential 2-form. The simplest way to write this is as the following algebraic condition on the Jacobian matrix of $`\Phi`$:

$$
\Phi'^TJ\Phi'=J.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  Differentiable ℝ Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_IsSymplecticMap` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。 | [EXTRA] |

[EXTRA] [EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷76页从Let m=2Nc到Φ′ᵀJΦ′=J的定义逐字一致。bp\_IsSymplecticMap对两个Fin Nc块上的实际映射要求全局可微，且每个z的真实Jacobian满足AᵀJA=J；J块矩阵符号正确。没有要求额外C¹，也没有把抽象矩阵当作无关实际映射的Jacobian。此处只审教材局部导数/保形式意义的定义，不从非奇异Jacobian擅推全局可逆。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_IsSymplecticMap`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L918)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-OneForm · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> A 1-form $`\alpha`$ defined on $`\mathbb R^m`$ is a family of linear mappings from $`\mathbb R^m`$ to $`\mathbb R`$, defined for each point of $`\mathbb R^m`$. Let $`\boldsymbol a:\mathbb R^m\to\mathbb R^m`$, then we may define a one-form associated to this vector by $`\alpha(\boldsymbol x)(\boldsymbol\xi)=\boldsymbol a(\boldsymbol x)^T\boldsymbol\xi`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ

def oneFormOfCoefficients {n : ℕ} (a : Q n → Q n) (z : Q n) : Q n →L[ℝ] ℝ :=
  ∑ i : Fin n, (a z i) • ContinuousLinearMap.proj i

theorem oneFormOfCoefficients_apply {n : ℕ} (a : Q n → Q n) (z ξ : Q n) :
    oneFormOfCoefficients a z ξ = ∑ i : Fin n, a z i * ξ i := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.oneFormFamily`；`MD.Ch02.oneFormOfCoefficients`；`MD.Ch02.oneFormOfCoefficients_apply` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷76页1-form线性映射族定义以及α(x)(ξ)=a(x)ᵀξ逐字一致。oneFormFamily对每个基点给一个连续线性实泛函；有限维中连续性自动成立，不是额外光滑条件。oneFormOfCoefficients是逐坐标投影的有限线性组合，对任意a,z,ξ，辅助定理断言评价恰为Σ\_i a(z)_i ξ\_i；对象、基点及完整评价式均覆盖。未错误要求a对z可微。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.oneFormFamily`：定义；`MD.Ch02.oneFormOfCoefficients`：定义；`MD.Ch02.oneFormOfCoefficients_apply`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L924)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-Differential · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> The differential of a function $`g:\mathbb R^m\to\mathbb R`$, denoted $`dg`$, is a family of linear mappings (one for each point in phase space) from vectors $`\boldsymbol\xi\in\mathbb R^m`$ into the reals defined by

$$
dg(\boldsymbol q,\boldsymbol p)(\boldsymbol\xi)=\nabla g(\boldsymbol q,\boldsymbol p)^T\boldsymbol\xi.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_differential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Q n=Fin n→ℝ（依赖:2816）和 oneForm n=Q n→Q n→L[ℝ]ℝ（:2882）。bp\_differential g=fderiv ℝ g，是每个底点的真实 Fréchet 导数，方向 ξ 进入线性泛函，在可微点评价为 ∑i,∂ᵢg(z)ξᵢ，正对应 ∇g(z)ᵀξ。默认坐标范数不改变有限维导数或此坐标等式；n 是总坐标数，可取 2Nc。fderiv 在不可微点取默认零是总化扩展，不能解释为不可微函数存在原文微分；原文 ∇g 隐含可微资格，在该资格下未改变定义。没有额外正则性限制或 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_differential`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L934)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-CoordinateDifferentials · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> So, denoting the $`i`$th position coordinate by $`q_i`$, we have $`dq_i(\boldsymbol\xi)=\xi_i`$; the differential is thus an example of a 1-form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def coordinateDifferentials (n : ℕ) :
    (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) × (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) :=
  (textbookDq,textbookDp)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.coordinateDifferentials` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33 的坐标空间分拆 q,p；:55–65 展开 textbookDq i u=u(Sum.inl i)、textbookDp i u=u(Sum.inr i)，map\_add/map\_smul 为逐坐标线性。蓝图配对这两个族，Fin n 对应教材 1,…,Nc，inr 对应 i+Nc，正负号、维数均正确。底点省略合理：坐标函数导数是与底点无关的固定评价泛函。dp 项来自本条 context 的 PDF99，合理且无额外假设；无 [ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.coordinateDifferentials`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L937)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-Wedge · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> It is written $`\alpha\wedge\beta`$ and is defined, for vectors $`\boldsymbol\xi,\boldsymbol\eta\in\mathbb R^m`$ by

$$
\alpha\wedge\beta(\boldsymbol\xi,\boldsymbol\eta)=\alpha(\boldsymbol\xi)\beta(\boldsymbol\eta)-\alpha(\boldsymbol\eta)\beta(\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_wedge {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_wedge`；`MD.Ch02.textbookWedgeOneForms_apply` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33 明确空间是 ℝ^(2Nc)，:73–77 的 textbookWedgeOneForms 与 bp\_wedge 函数体相同。双线性乘法复合与减法展开得到 α(u)β(v)−β(u)α(v)，实数交换律化为 α(u)β(v)−α(v)β(u)，完整对应原式。参数 α,β 为固定底点的线性泛函，与 context 相符；结果双线性且交替，没有暗加光滑条件。邻接 apply 定理虽使用库名称，实际定义相同，不再有对象不明问题。无 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_wedge`：定义；`MD.Ch02.textbookWedgeOneForms_apply`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L942)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticForm · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> Summing these terms results in the symplectic 2-form, denoted $`\psi_S`$:

$$
\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_symplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33–40 展开坐标及 J=[[0,I],[-I,0]]；bp\_symplecticForm 与依赖:85–87 的 textbookSymplecticForm 同为 J.toBilin'，评价是 ∑a∑b u(a)J(a,b)v(b)=∑i[u(inl i)v(inr i)−u(inr i)v(inl i)]。依赖:55–77 的 dq,dp 与楔积展开给出同一和，:90–107 明确登记坐标式和求和等式。故作为辛形式的定义，确实指定原文完整公式中的同一对象，没有符号、因子或维数错位；J^(i) 就是各 i 的两非零元素矩阵，其和为此 J。无 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticForm`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L954)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-FormSumWedges · unnumbered_claim · 印刷p.77 / PDFp.99

### 2. 原文陈述

> The wedge product of the coordinate differentials $`dq_i,dp_i`$ may be written

$$
dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\xi_i\eta_{i+N_c}-\xi_{i+N_c}\eta_i=\boldsymbol\xi^TJ^{(i)}\boldsymbol\eta.
$$


> where $`J^{(i)}`$ is the matrix which has zeros everywhere except for $`(J^{(i)})_{i,i+N_c}=1`$, $`(J^{(i)})_{i+N_c,i}=-1`$. Summing these terms results in the symplectic 2-form, denoted $`\psi_S`$:

$$
\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem formSumWedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i) := by
  apply MolecularDynamics.textbookSymplecticForm_eq_sum_wedges <;> assumption

def symplecticComponentMatrix {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinateMatrix Nc :=
  fun a b ↦ if a = Sum.inl i ∧ b = Sum.inr i then 1
    else if a = Sum.inr i ∧ b = Sum.inl i then -1 else 0

theorem formSumWedges_components (Nc : ℕ) :
    (∀ (i : Fin Nc) (u v : SymplecticCoordinates Nc),
      textbookWedgeOneForms (textbookDq i) (textbookDp i) u v =
        ∑ a, u a * ((symplecticComponentMatrix i) *ᵥ v) a) ∧
    (∑ i : Fin Nc, symplecticComponentMatrix i) = textbookJ Nc := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.formSumWedges`；`MD.Ch02.symplecticComponentMatrix`；`MD.Ch02.formSumWedges_components` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原页17（印刷77页）两条展示式的符号和求和一致，但两式之间where J^(i) is the matrix…的定义句被无省略标志地删去。修正JSON补回该句，明确两个非零位置和正负号。Lean主定理给双线性形式等式；symplecticComponentMatrix逐点定义q\_i,p\_i交叉元+1和−1，其余0。components定理对每个i,u,v给楔积等于uᵀJ^(i)v，并给Σ\_i J^(i)=J。textbookDq/Dp分别取q/p坐标，wedge=α(u)β(v)−α(v)β(u)，textbookSymplecticForm=J.toBilin，故单项坐标式及最终uᵀJv没有符号或二倍因子错误。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.formSumWedges`：已证；`MD.Ch02.symplecticComponentMatrix`：定义；`MD.Ch02.formSumWedges_components`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L960)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-GeneralTwoForm · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> In general, a differential 2-form $`\psi`$ is represented in coordinates by

$$
\psi_{\boldsymbol z}=\sum_{i,j}a_{ij}(\boldsymbol z)\,dz_i\wedge dz_j,
$$


> with matrix of coefficients $`A(\boldsymbol z)=(a_{ij}(\boldsymbol z))`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def coefficientTwoForm {n : ℕ} (A : Q n → Matrix (Fin n) (Fin n) ℝ)
    (z u v : Q n) : ℝ :=
  ∑ i, ∑ j, A z i j * (u i*v j-v i*u j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.coefficientTwoForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q n 已展开为 Fin n→ℝ（依赖:2816）。蓝图 coefficientTwoForm 对任意底点依赖系数 A，评价精确为 ∑i∑j A(z)ij[u\_i v\_j−v\_i u\_j]，逐项就是 a\_ij(z)dz\_i∧dz\_j；底点、两个方向和双和顺序无遗漏。无需假设 A 反对称；该表达自动双线性反对称，不把 A 直接当双线性矩阵。[ERRATUM?] 的代数部分成立：实际矩阵为 A−Aᵀ，A 反对称时为2A。但本条原文只称 A 为双和的系数矩阵，这本身无错；关于后文直接使用 A 的疑点不能在本批 scope 内确认，故不认定本条有已证实勘误，也不改双和。无 [EXTRA]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.coefficientTwoForm`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L978)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackOne · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> It is written $`\Phi^*\psi`$, so

$$
(\Phi^*\psi_{\boldsymbol z})(\boldsymbol\xi)=\psi_{\Phi(\boldsymbol z)}(\Phi'(\boldsymbol z)\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_pullbackOne` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816 的 Q n=Fin n→ℝ；:2882 的 oneForm n=Q n→(Q n→L[ℝ]ℝ)，即底点参数化的实线性泛函（有限维下连续性不额外收窄线性对象）。展开 .comp 得 ∀z ξ，bp\_pullbackOne Φ α z ξ=α(Φ z)((fderiv ℝ Φ z)ξ)，底点、方向与原式完全一致。依赖:2886–2887 的 pullbackOne 同体。没有把 α 错取在 z，也无额外假设。Φ 不带可微条件是用总化 fderiv 扩展定义的域：在教材实际导数存在的全部点，公式正是原定义；不可微点的默认值不能解释为教材的真实导数，但不使可微范围上的定义失真。无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_pullbackOne`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L983)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackTwo · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> The pull-back of a differential 2-form $`\psi_1\wedge\psi_2`$ is consequently defined as

$$
\Phi^*(\psi_1\wedge\psi_2)=(\Phi^*\psi_1)\wedge(\Phi^*\psi_2).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_pullbackTwo` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816、:2882–2889 展开 Q、oneForm、twoForm、pullbackOne、pullbackTwo。twoForm 是逐点连续双线性映射 A 加 ∀z u v，A z u v=−A z v u 的子类型；实数域上这也保证 A z u u=0，确为交替2-形式。蓝图与库 pullbackTwo 同体，两个方向均用同一底点的 DΦ(z)，A 在 Φ(z) 取值。依赖:73–82 的楔积展开是 α(u)β(v)−α(v)β(u)；对 α,β 的逐点族作同样展开，左侧拉回为 α(Φz)(DΦz u)β(Φz)(DΦz v)−α(Φz)(DΦz v)β(Φz)(DΦz u)，右侧两条拉回1-形式的楔积完全相同。因此本定义在可分解形式上实现原文乘法性，并合理推广到所有2-形式；不需要凭缺少单独定理把定义判缺失。没有额外光滑性要求；fderiv 的总化扩展在可微范围上正确。无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_pullbackTwo`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L987)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackMatrix · unnumbered_claim · 印刷p.77–78 / PDFp.99–100

### 2. 原文陈述

> Given a differential 2-form $`\psi_{\boldsymbol z}`$ represented by the matrix $`A(\boldsymbol z)=(a_{ij}(\boldsymbol z))`$, the pull-back of $`\psi_{\boldsymbol z}`$ under $`\Phi`$ is defined by

$$
\Phi^*\psi_{\boldsymbol z}=\sum_{ij}b_{ij}(\boldsymbol z)dz_i\wedge dz_j,
$$


> where the matrix $`B(\boldsymbol z)=(b_{ij}(\boldsymbol z))`$ is related to $`A(\boldsymbol z)`$ by

$$
B(\boldsymbol z)=\Phi'^T(\boldsymbol z)A(\Phi(\boldsymbol z))\Phi'(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem pullbackMatrix :
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v) := by
  intro n Φ A z u v
  rw [← textbookCoordinateJacobian_mulVec Φ z u,
    ← textbookCoordinateJacobian_mulVec Φ z v]
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
    Matrix.dotProduct_transpose_mulVec]
  exact dotProduct_comm _ _
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.pullbackMatrix` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816 的 Q 和 :2365–2376 的 textbookCoordinateJacobian 展开为标准基下 LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，且 mulVec u=DΦ(z)u。蓝图全称量化 n,Φ,A,z,u,v，完整表达 (DΦu)ᵀA(Φz)(DΦv)=uᵀ[DΦᵀA(Φz)DΦ]v；所有方向上的双线性评价唯一确定矩阵 B，故 B(z)=DΦ(z)ᵀA(Φz)DΦ(z)，底点无误。对原文全指标楔积系数，coefficientTwoForm 展开为 uᵀ(A−Aᵀ)v；将本等式在 (u,v) 和 (v,u) 上相减，恰得拉回系数形式等于 B 的全指标楔积形式，故归一差异不损害本夹乘公式。A 无须反对称，可推广为任意矩阵；不添加假设，无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.pullbackMatrix`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L991)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PreservesForm · definition · 印刷p.78 / PDFp.100

### 2. 原文陈述

> We say that a 2-form $`\psi`$ is conserved under mapping $`\Phi`$ if

$$
\Phi^*\psi=\psi.
$$


> In coordinates, the conservation of the 2-form represented by matrix $`A`$ under a mapping $`\Phi`$ means that

$$
\Phi'^TA\Phi'=A.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_preservesTwoForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2884–2891 展开 twoForm 及实际调用的 pullbackTwo：A 是逐点交替双线性形式，拉回值为 A(Φz)(DΦz u)(DΦz v)，与 bp\_pullbackTwo 同体。蓝图 ∀z u v 的等式是 Φ*ψ=ψ 的完整逐点评价，量词顺序与对象正确。若 M(z) 是 A.val 的实际双线性矩阵，则它等价于 DΦ(z)ᵀM(Φz)DΦ(z)=M(z)。[ERRATUM?] 指出的底点补全正确，但原文前一式已明确 A(Φz)，因而当前省略底点可按上下文理解，不能确认是错误。若把原文 A 当任意全指标楔积系数，则严格只保存反对称部分；选实际交替双线性矩阵才得到字面矩阵等式。这是表示约定说明，不影响本条形式守恒定义。没有额外假设。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_preservesTwoForm`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1005)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticIffForm · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> In the particular case of the symplectic 2-form $`\psi_S`$, we have $`A=J`$, and the following condition for conservation under the mapping $`\Phi`$

$$
\Phi'^TJ\Phi'=J.\tag{2.17}
$$


> A map that conserves the symplectic 2-form, or, in coordinates, satisfies (2.17), is termed a symplectic map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticIffForm {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    bp_IsSymplecticMap Φ ↔ Differentiable ℝ Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  sorry

theorem symplecticIffForm_C1 {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  apply MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticIffForm`；`MD.Ch02.symplecticIffForm_C1` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。 | [EXTRA] |

[EXTRA] [EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷78页专门辛2形式A=J、式(2.17)、末句命名定义一致。symplecticIffForm使用任意实际Φ，左侧教材可微谓词，右侧可微且对每个基点z及向量u,v有ψ(DΦ\_z u,DΦ\_z v)=ψ(u,v)，完整双向等价。辅助\_C1版本两侧一致使用ContDiff ℝ 1；没有将C¹版和仅可微版混用。实际J矩阵与双线性形式相符，未遗漏任何基点或切向量。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.symplecticIffForm`：未证（缺大型理论）；`MD.Ch02.symplecticIffForm_C1`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1010)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticDet · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> Taking the determinant of both sides of (2.17), we have

$$
\det(\Phi'^TJ\Phi')=\det(J)\Rightarrow\det(\Phi'^T)\det(J)\det(\Phi')=\det(J),
$$


> hence

$$
\det(\Phi')^2=1,
$$


> so $`|\det(\Phi')|=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticDet {n : ℕ} (A : SymplecticCoordinateMatrix n) (hA : IsTextbookSymplectic A) :
    A.det^2=1 ∧ |A.det|=1 := by
  exact ⟨hA.det_square,hA.abs_det⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticDet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33–40、:138–139 展开 SymplecticCoordinateMatrix n 为实2n×2n矩阵、J=[[0,I],[−I,0]]、hA 为 AᵀJA=J；:49–52 的 J²=−I 给出逆矩阵 −J，取消 det J 合法，包括 n=0 的空矩阵情形。蓝图同时包含 det(A)²=1 与 |det(A)|=1，两项原文结论均保留。把导数矩阵推广为任意辛矩阵不收窄教材结论，无 [EXTRA]。依赖:183–197 的 det\_square/abs\_det 使用更强的辛矩阵 det=1 结果，证明途径强于教材不改变本条签名语义。无 [ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticDet`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1025)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-HamiltonDet · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> If the system is Hamiltonian, the map is symplectic for all $`t`$, and the determinant will be a continuous function of $`t`$, so the cases of interest have $`\det(\mathcal F_t')=+1`$. The flow map of a Hamiltonian system is volume preserving.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z ↦ Φ (t,z))) ∧
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S) := by
  constructor
  · exact MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit
  · constructor
    · exact MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 H hH Φ hΦ τ hODE hinit
    · exact MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 H hH Φ hΦ τ hODE hinit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。 | [EXTRA] |

[EXTRA] [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。；[EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷78页Hamiltonian流辛性、行列式随t连续、det=+1及体积保存句均逐字一致。Lean给任意n、C² Hamiltonian和联合C²实际流、恒等初值及窗内ODE，结论有三项：每个时刻流为C¹辛映射；每点Jacobian det=1；每个可测集合体积保存。行列式的时间连续性由联合C²正则性得到，并且窗内恒等于1也直接给其限制连续。旧extra\_assumptions一条称τ>0、一条说不假称τ>0，自相矛盾；实际无该前提，已统一修正。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonDet`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1032)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-Hessian · definition · 印刷p.79 / PDFp.101

### 2. 原文陈述

> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_hessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_hessian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。Ch02.lean:779–783 的 bp\_hessian 与 HamiltonianVariational.lean 中 textbookHamiltonianHessian 逐字相同：第(i,j)项为 D(DH)(z)[e\_i][e\_j]，e\_i=Pi.single i 1。这是实际二阶Fréchet导数的坐标矩阵；取z=Φ(t,ζ)即得到原文S(t)，点参数化未丢失轨迹取值语义。对称性另由本批HessianSymmetry承担。本定义无额外假设、无sorry；不在本条强求时间函数封装。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_hessian`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1049)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HessianSymmetry · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hessianSymmetry {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm := by
  apply MolecularDynamics.textbookHamiltonianHessian_isSymm <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hessianSymmetry` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H在所取点C²，混合偏导相等。 | [EXTRA] |

[EXTRA] H在所取点C²，混合偏导相等。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。HamiltonianVariational.lean 展开的 textbookHamiltonianHessian 与 bp\_hessian 定义相同；Matrix.IsSymm断言转置等于自身，恰为全部混合二阶导数互换。Ch02.lean:786–790 对所有H和z，在ContDiffAt ℝ 2 H z下断言该对称性，因而也适用于任意轨迹点。点处C²是合理的充分正则性补充，非最弱必要条件；“混合偏导相等”不是另加假设，而是推出的结论。库证明使用二阶导数对称性，本地及该依赖证明无sorry；本次仅审签名，未运行Lean编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hessianSymmetry`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1056)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HamiltonVariationalPrinted · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> For the Hamiltonian system $`\dot{\boldsymbol z}=J\nabla H(\boldsymbol z)`$, these take the form:

$$
\dot W=JS(t)W,
$$


> where $`S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))`$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonVariationalPrinted : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t := by
  sorry



/-- 修正版，对应原文 MD-2.3.4-HamiltonVariationalPrinted。改动：固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。 -/
```

独立修正版：

```lean
theorem hamiltonVariationalPrinted_corrected : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) ζ)
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) ζ) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonVariationalPrinted`；`MD.Ch02.hamiltonVariationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。 | [EXTRA] |

[EXTRA] [ERRATUM?] 固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。SymplecticMaps.lean 的 textbookJacobian Φ z=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，第(i,j)项为DΦ(z)[e\_j]_i；SplittingError.lean 的 textbookHamiltonianVectorField H z=J乘以各基方向的DH，故确为(q̇,ṗ)=(H\_p,-H\_q)。HamiltonianVariational.lean 的 Hessian为实际二阶导数。Ch02.lean:793–803 对所有n,H,Φ,τ,ζ，在H C²、Φ联合C¹、Φ₀=id、闭区间所有初值满足真实ODE下，宣称移动点W(s)=DΦ\_s(Φ\_s(ζ))满足Ẇ=J Hzz(Φ\_t(ζ))W。它忠实保留印刷疑误，却不是正确变分方程；[ERRATUM?]由下列全局光滑反例确定成立。即使加强Φ为C∞也不能补救。通常固定初值W=DΦ\_t(ζ)才满足该式；移动点同时产生空间链式项，且固定底点的变分系数在Φ\_t(Φ\_t(ζ))取值。C¹本身也不足以直接保证所需二阶混合导数。τ≤0时开区间为空，不影响τ>0的反例。签名FAIL与证明体显式sorry分别记录；该sorry不作为判FAIL的理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.hamiltonVariationalPrinted`：未证（原书疑误不证）；`MD.Ch02.hamiltonVariationalPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1064)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-MatrixCancellation · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> hence

$$
\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.
$$



### 3. 原文证明

> Computing

$$
W^TJ\dot W=W^TJ^2SW=-W^TSW,
$$


> whereas

$$
\dot W^TJW=W^TS^TJ^TJW=W^TSW,
$$


> hence

$$
\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.
$$


原文Computing、whereas和hence的矩阵计算按原页保留于proof\_latex；本条matrixCancellation\_time已登记实际乘积求导及零导数，时间区间上推出常值是后续步骤。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem matrixCancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0 := by
  apply MolecularDynamics.hamiltonian_variational_matrix_cancellation <;> assumption

theorem matrixCancellation_time {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (I : Set ℝ) (t : ℝ)
    (_hS : (S t).IsSymm)
    (_hW : HasDerivWithinAt W (textbookJ Nc * S t * W t) I t) :
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s)
      ((textbookJ Nc * S t * W t)ᵀ * textbookJ Nc * W t +
        (W t)ᵀ * textbookJ Nc * (textbookJ Nc * S t * W t)) I t ∧
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s) 0 I t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.matrixCancellation`；`MD.Ch02.matrixCancellation_time` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | S对称；任意矩阵W。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。 | [EXTRA] |

[EXTRA] S对称；任意矩阵W。；[EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原页20（印刷79页）Computing、whereas及两条中间矩阵等式一致；statement开头原页是小写hence，当前写成Hence，已作字面修正。代数主定理对任意W和对称S断言(JSW)ᵀJW+WᵀJ(JSW)=0。time版本对任意集合I和点t，假设S(t)对称及W在I内真实导数JS(t)W(t)，同时给乘积导数的完整两项表达式和零导数结论。交换的是相加项顺序，不是矩阵乘积顺序；J²=−I和JᵀJ=I的消去符号正确。任意I无需额外可微性，因为HasDerivWithinAt已提供所需局部资格。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.matrixCancellation`：已证；`MD.Ch02.matrixCancellation_time`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1096)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

