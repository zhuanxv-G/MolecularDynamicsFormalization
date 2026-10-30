[上一部分](part01.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-4.1-ActualMidpointRelation · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> The Implicit Midpoint method which, for the ODE $`\dot z=f(z)`$ takes the form

$$
z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def actualMidpointRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))



/-- 修正版，对应原文 MD-4.1-ActualMidpointRelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def actualMidpointRelation_corrected {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.actualMidpointRelation`；`MD.Ch04.actualMidpointRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖摘录 MolecularDynamics/Chapter04/ReviewDefinitions.lean: Q n = Fin n → ℝ，Z n = Q n × Q n；向量运算逐坐标。 实际定义为 Z=z+h f((z+Z)/2)，而指定原页给的是 Z=z+(h/2)(f(z)+f(Z))。[EXTRA] 已坦陈这是另行更正候选，合理用于比较，但不使其成为原页忠实陈述。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.actualMidpointRelation`：定义；`MD.Ch04.actualMidpointRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L468)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ImplicitFactor · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> can be applied to $`\dot z=i\Omega z`$ and yields

$$
z_{n+1}=\frac{1+ih\Omega/2}{1-ih\Omega/2}z_n.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))

theorem implicitFactor_update (Ω h : ℝ) (z out : ℂ) :
    (out=z+(h : ℂ)*(Complex.I*Ω*z+Complex.I*Ω*out)/2) ↔
      out=implicitFactor Ω h*z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.implicitFactor`；`MD.Ch04.implicitFactor_update` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；implicitFactor 对任意实 Ω,h 定义原复比值。implicitFactor\_update 对任意复 z,out 给印刷线性隐式更新与乘因子的双向等价；iΩ 的乘法、h/2 和 out 位置正确。分母实部为1，对这些域永不为零；无需增加分母假设。在线性场上梯形与中点一致。

### 7. 状态与证明位置

incomplete；`MD.Ch04.implicitFactor`：定义；`MD.Ch04.implicitFactor_update`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L479)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ImplicitModulus · unnumbered_claim · 印刷p.142 / PDFp.164

### 2. 原文陈述

> For all real $`\Omega`$, we find

$$
\left|\frac{1+ih\Omega/2}{1-ih\Omega/2}\right|=1.
$$


> This indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
  intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by simp
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr

theorem implicitModulus_iterates (Ω h : ℝ) (z : ℂ) (k : ℕ) :
    ‖(MolecularDynamics.Chapter04Review.implicitFactor Ω h)^k*z‖=‖z‖ := by
  sorry



/-- 修正版，对应原文 MD-4.1-ImplicitModulus。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem implicitModulus_corrected :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.implicitModulus`；`MD.Ch04.implicitModulus_iterates`；`MD.Ch04.implicitModulus_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。；[EXTRA] 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；对任意实 Ω,h 的模长等式及任意复初值、自然步数的范数保持均正确，且涵盖零频率零步长。[EXTRA] 明确限定纯虚标量模态，足以表达当前振子无步长稳定阈值；不把它推广为任意线性系统有界性。原书泛称仍交人工，不以缩域签名静默消除疑误。

### 7. 状态与证明位置

incomplete；`MD.Ch04.implicitModulus`：已证；`MD.Ch04.implicitModulus_iterates`：未证（原书疑误不证）；`MD.Ch04.implicitModulus_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L491)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-PrintedModifiedFrequency · definition · 印刷p.143 / PDFp.165

### 2. 原文陈述

> If the Implicit Midpoint method is viewed as the exact solution of a perturbed harmonic oscillator, then the frequency of this oscillator is

$$
\widehat\Omega=\frac1{ih}\ln\frac{1+ih\Omega/2}{1-ih\Omega/2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)



/-- 修正版，对应原文 MD-4.1-PrintedModifiedFrequency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def printedModifiedFrequency_corrected (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedModifiedFrequency`；`MD.Ch04.printedModifiedFrequency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；MD.Ch04.printedModifiedFrequency 展开为 (i h)⁻¹ * Complex.log factor，factor 的正式定义已查明。原文 ln 的分支未指定，这是需要裁定的原文问题，并非缺失项目定义。主支候选合理：有限实 x=hΩ/2 时 factor 的连续主相位为 2 atan x ∈ (-π,π)，与实频率解释相容；其他支给频率加 2πk/h。[EXTRA] 注释写 h≠0，但实际定义没有这一资格，Lean 总化逆元在 h=0 返回0；必须显式限制物理解读到非零步长。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedModifiedFrequency`：定义；`MD.Ch04.printedModifiedFrequency_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L522)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ModifiedFrequencyLimit · unnumbered_claim · 印刷p.143 / PDFp.165

### 2. 原文陈述

> The figure shows that the frequency is only well approximated in case $`h\Omega`$ is sufficiently small. For $`h\Omega\gg1`$ the frequency is highly modified.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω) := by
  intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num <;> ring
  convert hd.tendsto_slope_zero using 1
  funext t
  simp [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv]
  ring

def midpointFrequencyRatio (x : ℝ) : ℝ := 2*Real.arctan (x/2)/x

theorem modifiedFrequencyRatio_limits :
    Tendsto midpointFrequencyRatio (nhdsWithin 0 ({0}ᶜ)) (𝓝 1) ∧
    Tendsto midpointFrequencyRatio atTop (𝓝 0) ∧
    (∀ Ω h : ℝ, h*Ω ≠ 0 →
      MolecularDynamics.Chapter04Review.modifiedFrequency Ω h/Ω=midpointFrequencyRatio (h*Ω)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.modifiedFrequencyLimit`；`MD.Ch04.midpointFrequencyRatio`；`MD.Ch04.modifiedFrequencyRatio_limits` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。 | [EXTRA] |

[EXTRA] [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。；[EXTRA] 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；modifiedFrequency=2 atan(hΩ/2)/h。∀实 Ω，沿去掉零点的 h→0 趋Ω；midpointFrequencyRatio 定义2 atan(x/2)/x，沿去零x→0趋1、x→+∞趋0；∀实Ω,h且hΩ≠0，频率比桥接正确。负频率和负步长均无代数问题。明确实连续相位，不在本条擅自断言任意复log分支或耦合系统误差估计。

### 7. 状态与证明位置

incomplete；`MD.Ch04.modifiedFrequencyLimit`：已证；`MD.Ch04.midpointFrequencyRatio`：定义；`MD.Ch04.modifiedFrequencyRatio_limits`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L534)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-MechanicalMidpoint · definition · 印刷p.144 / PDFp.166

### 2. 原文陈述

> we may reduce the equations to determining midpoint values $`\widehat q,\widehat p`$ such that

$$
\widehat q=q_n+\frac h2M^{-1}\widehat p,\qquad\widehat p=p_n-\frac h2\nabla U(\widehat q),
$$


> where, then,

$$
q_{n+1}=\widehat q+\frac h2M^{-1}\widehat p,\qquad p_{n+1}=\widehat p-\frac h2\nabla U(\widehat q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mechanicalMidpointRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖摘录 MolecularDynamics/Chapter04/ReviewDefinitions.lean: Q n = Fin n → ℝ，Z n = Q n × Q n；向量运算逐坐标。正式 grad U q = textbookConstraintGradient U q；在 MolecularDynamics/Chapter04/ConstrainedProjection.lean 展开后为 fun i => (fderiv ℝ U q) (Pi.single i 1)，是真实 Fréchet 偏导梯度。invMass m v = fun i => (m i)⁻¹*v i，是对角质量逆作用。 四个合取逐项对应 mid=(q̂,p̂)、z=(q\_n,p\_n)、out=(q_{n+1},p_{n+1})，全部正负号和 h/2 系数正确。没有交换量词或宣称解存在唯一。[EXTRA] 无新增假设；物理质量应正、势应可微，签名是代数关系的总化延伸，对合格对象限制后忠实；它没有声称任意不可微 U 的 fderiv 就是经典梯度。应明确记录此使用域，m=0 的逆元总化不代表物理质量逆。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mechanicalMidpointRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L554)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-MidpointElimination · unnumbered_claim · 印刷p.144 / PDFp.166

### 2. 原文陈述

> We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $`\widehat p`$, we find

$$
\widehat q=q_n+\frac h2M^{-1}p_n-\frac{h^2}{4}M^{-1}\nabla U(\widehat q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem midpointElimination :
  ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) h (z mid out : MolecularDynamics.Chapter04Review.Z n),
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m z.2-(h^2/4) • MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad U mid.1) := by
  intro n m U h z mid out hm
  rcases hm with ⟨hq,hp,houtq,houtp⟩
  calc
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 := hq
    _ = _ := by
      rw [hp]
      funext i
      simp [MolecularDynamics.Chapter04Review.invMass]
      ring

theorem midpointEulerHalfSteps (n : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z mid out : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out ↔
      (let f := fun w : MolecularDynamics.Chapter04Review.Z n ↦
        (MolecularDynamics.Chapter04Review.invMass m w.2,
          -MolecularDynamics.Chapter04Review.grad U w.1)
       mid=z+(h/2) • f mid ∧ out=mid+(h/2) • f mid) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.midpointElimination`；`MD.Ch04.midpointEulerHalfSteps` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。 | [EXTRA] |

[EXTRA] [EXTRA] 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n、质量函数、实势函数、实h、相空间 z,mid,out；以实际四关系为前提推出位置消元，并用同一机械向量场给隐式Euler半步后显式Euler半步的双向等价。Q和Z为有限实坐标及其乘积，grad 的 fderiv 坐标定义一致，invMass 是逐坐标乘质量倒数，故所需线性性成立。结论是关系代数式，不声称解存在、唯一或迭代收敛；对非物理质量或非光滑势的总化扩域也不使这两个代数命题变假，但不能据此解释为真实机械流。

### 7. 状态与证明位置

incomplete；`MD.Ch04.midpointElimination`：已证；`MD.Ch04.midpointEulerHalfSteps`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L561)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-SplitHamiltonian · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> In many molecular dynamics applications, the system may be decomposed as $`H(q,p)=p^TM^{-1}p/2+U_S(q)+U_F(q)`$ where $`U_S`$ is a “soft” potential, in which the natural motion would be relatively slow, whereas $`U_F`$ is a much stronger term which would give rise to relatively rapid motion.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.dot z.2 (MolecularDynamics.Chapter04Review.invMass m z.2)/2+US z.1+UF z.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.splitHamiltonian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；所读 /workspace/Ch04.lean 对应本报告逻辑路径 Blueprint/Ch04.lean；第398–399行的 MD.Ch04.splitHamiltonian 为本条实际声明。Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean 中，Q n=Fin n→ℝ，Z n=Q n×Q n，故 z.1=q、z.2=p；invMass m v 的第i分量为 (m i)⁻¹*v i，dot u v=∑i,u i*v i。完全展开后返回 (∑i,p\_i*(m\_i⁻¹*p\_i))/2+US(q)+UF(q)，在教材的正对角质量约定下正是 p^T M⁻¹p/2+US(q)+UF(q)。参数次序 n,m,US,UF,z 及势函数的配置空间自变量一致，没有遗漏公式项。定义对任意实 m 总化；m\_i=0 时的 Lean 逆元约定不能解释为物理质量矩阵的逆，但此定义没有声称这些非物理输入也是教材的系统。慢/快、软/强作为定性背景没有被改为虚构的数值假设。本条无 [EXTRA]、[ERRATUM?]。本条是无 sorry 的定义；PASS 是公式语义结论，未运行 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.splitHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L586)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-FastVerlet · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Let us $`\mathcal G_h^F`$ denote the map associated to the Verlet method for the system without $`U_S`$, using a stepsize $`h`$:

$$
\mathcal G_h^F=\mathrm e^{\frac h2\mathcal L_{U_F}}\mathrm e^{h\mathcal L_K}\mathrm e^{\frac h2\mathcal L_{U_F}},
$$


> where $`\mathcal L_K`$ is the Lie-derivative corresponding to the kinetic energy component of Hamiltonian $`(K=p^TM^{-1}p/2)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h



/-- 本地核对网站缺摘录项：动量半kick、位置整drift、动量半kick。 -/

theorem fastVerlet_kick_drift_kick {n : ℕ} (m : Fin n → ℝ)
    (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) :
    fastVerlet m UF h z =
      let F := fun q => -MolecularDynamics.Chapter04Review.grad UF q
      let pHalf := z.2+(h/2) • F z.1
      let qNew := z.1+h • Chapter02Review.invMass m pHalf
      (qNew,pHalf+(h/2) • F qNew) := by
  let F := fun q => -MolecularDynamics.Chapter04Review.grad UF q
  have hq : z.1+h • Chapter02Review.invMass m z.2+
      (h^2/2) • Chapter02Review.invMass m (F z.1) =
      z.1+h • Chapter02Review.invMass m (z.2+(h/2) • F z.1) := by
    ext i
    simp [Chapter02Review.invMass]
    <;> ring
  dsimp only [fastVerlet, Chapter02Review.verlet]
  change (z.1+h • Chapter02Review.invMass m z.2+(h^2/2) • Chapter02Review.invMass m (F z.1),
    z.2+(h/2) • (F z.1+F (z.1+h • Chapter02Review.invMass m z.2+(h^2/2) • Chapter02Review.invMass m (F z.1)))) = _
  rw [hq]
  apply Prod.ext
  · rfl
  · ext i
    simp [F]
    <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.fastVerlet`；`MD.Ch04.fastVerlet_kick_drift_kick` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本地核验通过（网站因摘录缺失未判）；须与本章最终逐声明公理结果共同读取 | [EXTRA] |

[EXTRA] [EXTRA] 本地核验通过（网站因摘录缺失未判）；须与本章最终逐声明公理结果共同读取

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；n、实质量函数、实势和步长、Q/Z及负梯度力的类型和符号可核对。关键调用 Chapter02Review.verlet 的定义未在本条、依赖摘录或本任务其他条中给出；这是项目定义，不能按Mathlib直接采信。仅凭名字不能确认它是 kick(h/2)→drift(h)→kick(h/2)、质量放置及返回(q,p)次序，因此无法完成实际映射的全依赖审校。未读取任务禁止的旧工程，未据缺失材料推断函数错误。

### 7. 状态与证明位置

self-contained；`MD.Ch04.fastVerlet`：定义；`MD.Ch04.fastVerlet_kick_drift_kick`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L591)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-RESPA · (4.2) · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Now consider the map constructed by taking $`r`$ steps using $`\mathcal G_{F,h/r}`$ and composing this with kicks from the soft force:

$$
\mathcal G_h^{\mathrm{MTS}}=\mathrm e^{\frac h2\mathcal L_{U_S}}[\mathcal G_{h/r}^F]^r\mathrm e^{\frac h2\mathcal L_{U_S}}.
$$


> One step of the multiple timestepping algorithm is then implemented as follows:
> Reversible RESPA Algorithm

$$
P:=p-(h/2)\nabla U_S(q),\quad Q:=q;
$$


> Repeat $`r`$ times:

$$
P:=P-(h/2)\nabla U_F(Q)/r,\quad Q:=Q+hM^{-1}P/r,\quad P:=P-(h/2)\nabla U_F(Q)/r;\tag{4.2}
$$



$$
P:=P-(h/2)\nabla U_S(Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def respaTotalized {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))

def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (r : ℕ) (_hr : 0 < r) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.Z n := respaTotalized m US UF r h z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.respaTotalized`；`MD.Ch04.respa` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected\_json补回。 | [EXTRA] |

[EXTRA] r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。；[EXTRA] 总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected\_json补回。

### 6. 审计结论

本轮修复：总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected\_json补回。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；r 声明为任意自然数，没有0<r或非零资格，和 extra\_assumptions 的 r为正自然数矛盾。正r时外层两次慢kick以及内部真实函数迭代的组合顺序正确；但r=0被Lean总化为跳过快步、连续两个慢半kick，已超出原文h/r与正细分数的域。另继承条目14未给出 Chapter02Review.verlet 定义的材料缺口。FAIL来自明确缺失的r资格，不来自sorry或无法检查的实现。

### 7. 状态与证明位置

self-contained；`MD.Ch04.respaTotalized`：定义；`MD.Ch04.respa`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L625)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-RESPAStructure · unnumbered_claim · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Because $`U_F`$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem respaStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z := by
  sorry



/-- 修正版，对应原文 MD-4.2.1-RESPAStructure。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem respaStructure_corrected :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.respaStructure`；`MD.Ch04.respaStructure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Ch04.lean 第412–416行量化 n、m、US、UF、r、h，要求所有 m\_i>0、US/UF 为 C²、r>0，然后结论为辛性与对所有 z 的 G_{−h}(G\_h(z))=z。所有依赖均已展开：Q n=Fin n→ℝ、Z n=Q n×Q n；dot u v=∑i u\_i v\_i；phaseForm(u,v)=dot(u.q,v.p)−dot(v.q,u.p)；symplecticMap G=∀z u v,phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)。respa、kick、fastVerlet、Chapter02Review.verlet、invMass、grad→textbookConstraintGradient 分别是两次软势半 kick 包住 r 次快势 Verlet、p↦p−t∇U、实际坐标梯度及质量 drift，不是把保辛或可逆结论预先塞入定义。n 到 h 的量词顺序没有隐藏依赖，h 可为任意实数；C²保证实际梯度的 C¹ 及 Hessian 对称。[EXTRA] 正质量与 r>0 是合理的物理/算法资格，C² 是保辛的合理充分正则性；反步恒等式本身并不需要 C²，且作为代数映射的辛性也不严格需要质量为正，只需所用对角 drift 的适当解释。它们没有制造错误结论。FAIL 的原因是当前 statement\_scope 明定仅覆盖所引原句及展示公式，而第167页这句话只是对称分裂的动机，没有断言任意 C² 势、任意步长下的全局 Jacobian 辛性与恒等式。注释把第171页的辛性及算法名称合并，扩大了来源与结论范围；[EXTRA] 可以标明补充假设，但不能自动使两项额外结论成为当前冻结原句的忠实陈述。此外 G_{−h}∘G\_h=id 表示步长反号的自伴性；若 Reversible 专指 R(q,p)=(q,−p) 的动量反射可逆，还应显式交代 R∘G\_h∘R=G_{−h}。该具体算法在这些正则性条件下的保结构命题数学上合理，此 FAIL 是来源/范围不匹配，没有声称已找到数学反例。本条无 [ERRATUM?]。第416行存在 sorry，证明仍未完成；范围 FAIL 不以 sorry 为理由，亦不把 sorry 当作命题为假的证据。

### 7. 状态与证明位置

incomplete；`MD.Ch04.respaStructure`：未证（原书疑误不证）；`MD.Ch04.respaStructure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L636)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-SlowMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> with

$$
S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅S\_h定义；合引中的F\_h由MD-4.2.1-FastMatrix承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.slowMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条明确只承担S\_h；同一展示中的F\_h由MD-4.2.1-FastMatrix承担，原合引文字保留。 | [EXTRA] |

[EXTRA] [EXTRA] 本条明确只承担S\_h；同一展示中的F\_h由MD-4.2.1-FastMatrix承担，原合引文字保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实h的2×2实矩阵[[1,0],[-h,1]]，作用于(q,p)列向量给(q,p-hq)，与质量1、U\_S=q²/2 的慢kick相符。未误把F\_h也算作本声明定义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.slowMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L657)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-FastMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> with

$$
S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅非零频率模型中的F\_h定义；S\_h由MD-4.2.1-SlowMatrix承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.fastMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] F\_h使用原Ω≫1模型的非零频率域，防止除零总化；S\_h由SlowMatrix承担，原展示不删。 | [EXTRA] |

[EXTRA] Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。；[EXTRA] F\_h使用原Ω≫1模型的非零频率域，防止除零总化；S\_h由SlowMatrix承担，原展示不删。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Ω,h∈ℝ且显式Ω≠0，矩阵对角cos(Ωh)，右上sin(Ωh)/Ω，左下-Ωsin(Ωh)，符号、坐标及分母正确。原Ω≫1背景允许推广至非零实Ω；正Ω频率是物理解释，并非本代数定义必须的附加资格。它是精确快流，不是单次Verlet。

### 7. 状态与证明位置

self-contained；`MD.Ch04.fastMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L662)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> In the limit of small inner step, we solve the system with Hamiltonian $`H_F=p^2/2+\Omega^2q^2/2`$ exactly, meanwhile punctuating with impulses from $`U_S`$, thus the MTS flow map approximation, which is linear in this case, can be written in the form of a matrix-vector multiply

$$
\begin{bmatrix}Q\\P\end{bmatrix}=W_h\begin{bmatrix}q\\p\end{bmatrix},\qquad W_h=S_{h/2}F_hS_{h/2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.impulseMatrix` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；实际 MD.Ch04.impulseMatrix 在 Ch04.lean 第427行；它使用的是依赖正式库中的 slowMatrix 与 fastMatrix，均已查体：S\_t=[[1,0],[−t,1]]，F\_h=[[cos(Ωh),sin(Ωh)/Ω],[−Ωsin(Ωh),cos(Ωh)]]。返回 Matrix (Fin 2) (Fin 2) ℝ 的乘积 S_{h/2}*F\_h*S_{h/2}；Matrix 乘法按列向量作用时右因子先作用，正是软势半 impulse、精确快振子流、软势半 impulse。任意输入 (q,p) 的输出是此矩阵乘该列向量，两分量次序与原页 [Q,P]^T 对齐，所有乘积因子和系数齐全。这里审核的是该理想 exact-inner-step 矩阵定义，原文 “In the limit of small inner step” 描述理想模型的选取，不含给定范数/收敛速率的独立极限定理；该 def 也没有把有限 r RESPA 矩阵与这个理想矩阵断言为相等。Ω 的解释域继承原 Ω≫1 模型，至少应取 Ω≠0；它没有声称除零总化后的 Ω=0 仍是精确快流。US=q²/2、UF=Ω²q²/2 与质量1已体现在查得的两个矩阵中，没有将一般势偷换成这些矩阵。本条无新增 [EXTRA] 或 [ERRATUM?]。定义无 sorry；本 PASS 是定义与模型公式的语义对应，不是对内步极限收敛或 Lean 编译的证明认证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.impulseMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L666)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseDet · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> Both of these matrices have unit determinant for any $`h`$, so the product of the eigenvalues of $`W_h`$ is $`1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem impulseDet :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 ∧ (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 ∧ (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=1 := by
  intro Ω h hΩ
  simp only [MolecularDynamics.Chapter04Review.impulseMatrix, Matrix.det_mul]
  have hs : (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hs2 : (MolecularDynamics.Chapter04Review.slowMatrix (h/2)).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hf : (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.fastMatrix, Matrix.det_fin_two]
    field_simp
    nlinarith [Real.sin_sq_add_cos_sq (Ω*h)]
  exact ⟨hs,hf,by rw [hs2,hf]; norm_num⟩

theorem impulseDet_eigenvalueProduct (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ, a*b=1 ∧ ∀ ζ : ℂ,
      (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
          (ζ-a)*(ζ-b) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.impulseDet`；`MD.Ch04.impulseDet_eigenvalueProduct` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。 | [EXTRA] |

[EXTRA] Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。；[EXTRA] 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀实Ω,h且Ω≠0，实际S\_h、F\_h、W\_h三项det=1。依赖的Chapter04Review.fastMatrix本身无非零参数，但本定理前提已正确限制，勿与条目17的MD包装定义混淆。W=S(h/2)F(h)S(h/2) 次序正确。补充存在复a,b满足ab=1，且对所有复ζ的完整首一二次分解，绑定计重的两个根，不是任取两根，正确覆盖重根。

### 7. 状态与证明位置

incomplete；`MD.Ch04.impulseDet`：已证；`MD.Ch04.impulseDet_eigenvalueProduct`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L671)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseTrace · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> On the other hand, a short calculation shows that

$$
\lambda_1+\lambda_2=\operatorname{Tr}(W_h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) := by
  intro Ω h hΩ
  simp [MolecularDynamics.Chapter04Review.impulseMatrix, MolecularDynamics.Chapter04Review.slowMatrix,
    MolecularDynamics.Chapter04Review.fastMatrix, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]
  rw [mul_comm h Ω]
  ring

theorem impulseTrace_eigenvalueSum (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ,
      a+b=(2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) : ℝ) ∧
      (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=(ζ-a)*(ζ-b)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.impulseTrace`；`MD.Ch04.impulseTrace_eigenvalueSum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。 | [EXTRA] |

[EXTRA] Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。；[EXTRA] 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀实Ω,h且Ω≠0，实际W的trace为2cos(hΩ)-(h/Ω)sin(hΩ)。补充存在复a,b给同一完整特征二次式的所有ζ分解并约束a+b为该实trace的复嵌入，正确表达按代数重数的根和，未重复选择同一简单根。与条目18的根对未要求顺序相同，完整同一多项式分解已经保证根多重集相同。

### 7. 状态与证明位置

incomplete；`MD.Ch04.impulseTrace`：已证；`MD.Ch04.impulseTrace_eigenvalueSum`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L696)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonancePower · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> For example, at $`h=\pi/\Omega`$, we have

$$
F_h=-I\Rightarrow W_h=-S_{h/2}^2=-\begin{bmatrix}1&0\\-h&1\end{bmatrix},
$$


> so that

$$
W_h^n=(-1)^n\begin{bmatrix}1&0\\-nh&1\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1] := by
  intro Ω hΩ k
  have hne : Ω ≠ 0 := ne_of_gt hΩ
  have ha : Ω*(Real.pi/Ω)=Real.pi := by field_simp
  have hm : MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω)= -!![1,0; -(Real.pi/Ω),1] := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.impulseMatrix,MolecularDynamics.Chapter04Review.slowMatrix,MolecularDynamics.Chapter04Review.fastMatrix,Matrix.mul_apply,Fin.sum_univ_two,ha] <;> ring
  induction k with
  | zero =>
    ext i j
    fin_cases i <;> fin_cases j <;> norm_num
  | succ k hk =>
    rw [pow_succ,hk,hm,pow_succ]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,Nat.cast_add,Nat.cast_one] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonancePower` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω>0；所有自然数k，不止图中有限迭代。 | [EXTRA] |

[EXTRA] Ω>0；所有自然数k，不止图中有限迭代。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意实Ω>0及每个自然数k，结论是实际S(h/2)F(h)S(h/2)的矩阵幂，而非另一种Verlet矩阵。负号标量幂、左下角−kπ/Ω、k=0均正确。k=1给出W的展示式，F(π/Ω)=−I由给定fastMatrix直接化简；此中间式也出现在当前证明中。Ω>0是合理物理资格，不需Ω≫1的定量界。

### 7. 状态与证明位置

self-contained；`MD.Ch04.resonancePower`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L714)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceTaylor · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> We can see this by expanding $`\mu(h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega)`$ in a Taylor expansion around $`h=\pi/\Omega`$:

$$
\mu(h)=-2+\varepsilon,\qquad\varepsilon=\frac\pi\Omega(h-\pi/\Omega).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
  sorry



/-- 修正版，对应原文 MD-4.2.1-ResonanceTaylor。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem resonanceTaylor_corrected :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonanceTaylor`；`MD.Ch04.resonanceTaylor_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；固定每个Ω>0后才选择C、δ，二者允许依赖Ω；对整个双侧邻域以二次余项一致控制。实际trace的常数项为−2，一阶导数为π/Ω，故与截断Taylor的合理修正版一致；不是声称对所有Ω使用同一C。sorry仅表明未完成证明，不影响本次签名审校。

### 7. 状态与证明位置

incomplete；`MD.Ch04.resonanceTaylor`：未证（原书疑误不证）；`MD.Ch04.resonanceTaylor_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L737)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

