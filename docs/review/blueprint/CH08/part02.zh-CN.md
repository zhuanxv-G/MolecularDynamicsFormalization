[上一部分](part01.zh-CN.md) / [目录](../../CH08_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## MD-8.6-IsokineticField

印刷页 361–362 / PDF页 382–383。

### 1. 原文陈述

> $`\dot q=M^{-1}p`$, $`\dot p=F(q)-[p^{\mathsf T}M^{-1}F(q)/(p^{\mathsf T}M^{-1}p)]p`$; $`K(p)=p^{\mathsf T}M^{-1}p`$ is constant.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isoMultiplier (invm p F : Vec n) : ℝ :=
  (∑ i, invm i*p i*F i)/kineticTwice invm p
def isoField (invm : Vec n) (F : Vec n → Vec n) (z : Phase n) : Phase n :=
  (fun i ↦ invm i*z.2 i, fun i ↦ F z.1 i-isoMultiplier invm z.2 (F z.1)*z.2 i)
theorem isoKinetic_balance (invm p F : Vec n) (hK : kineticTwice invm p ≠ 0) :
    (∑ i, invm i*p i*(F i-isoMultiplier invm p F*p i)) = 0 := by
  simp only [mul_sub, Finset.sum_sub_distrib]
  have hsum : (∑ i, invm i*p i*(isoMultiplier invm p F*p i)) =
      isoMultiplier invm p F*kineticTwice invm p := by
    simp only [kineticTwice, Finset.mul_sum]
    apply Finset.sum_congr rfl; intro i hi; ring
  rw [hsum, isoMultiplier, div_mul_cancel₀ _ hK, sub_self]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 无约束向量场与瞬时动能导数的代数消去；沿解的完整第一积分列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正质量、$`K\gt 0`$作为物理有效域；本条实际证明瞬时动能平衡，不将之扩大为全局解存在性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页382–383。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isoMultiplier`：定义
- `MD.Ch08.isoField`：定义
- `MD.Ch08.isoKinetic_balance`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticProjector

印刷页 362 / PDF页 383。

### 1. 原文陈述

> $`H=p(p^{\mathsf T}M^{-1}p)^{-1}p^{\mathsf T}M^{-1}`$; $`H^2=H`$, $`Hp=p`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isoProjection (invm p : Vec n) (v : Vec n) : Vec n :=
  fun i ↦ p i*((∑ j, invm j*p j*v j)/kineticTwice invm p)
theorem isoProjection_self (invm p : Vec n) (hK : kineticTwice invm p ≠ 0) :
    isoProjection invm p p = p := by
  have hs : (∑ j, invm j*p j*p j) = kineticTwice invm p := by
    simp only [kineticTwice]; apply Finset.sum_congr rfl; intro i hi; ring
  ext i; simp [isoProjection, hs, hK]
theorem isoProjection_idempotent (invm p : Vec n) (hK : kineticTwice invm p ≠ 0)
    (v : Vec n) : isoProjection invm p (isoProjection invm p v) = isoProjection invm p v := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 分母K非零；范围为span(p)的完整线性映射子空间等式列覆盖缺口。
- 覆盖缺口：实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页383。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isoProjection`：定义
- `MD.Ch08.isoProjection_self`：已证
- `MD.Ch08.isoProjection_idempotent`：未证；时间盒止

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticDivergencePrinted

印刷页 362–363 / PDF页 383–384。

### 1. 原文陈述

> $`\rho=e^{-w(q,p)}\Phi(K(p))`$; $`\operatorname{div}f_{iso}=(N_c-1)p^{\mathsf T}M^{-1}F/(p^{\mathsf T}M^{-1}p)`$, $`w=(N_c-1)U/K`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isoAnsatz (w : Phase n → ℝ) (Φ : ℝ → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-w z)*Φ (kineticTwice invm z.2)
theorem isoDivergencePrinted (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = ((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry
theorem isoDivergence_corrected (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = -((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 一般光滑力的原印/符号修正散度目标及权重ansatz；w方程和概率不变另列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Φ为正光滑非零函数时称权重；使用$`K\ne0`$域上的实际散度。
- 已目视核对原页PDF383–384：散度与$`\nabla w\cdot f`$等式须同时改负号，$`w=(n-1)U/K`$的正号保留。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；原印散度正号有误。
修正版：原送审负号_corrected签名PASS；w本身保留正号。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF383–384：$`\dot p=F-\lambda p`$的散度应为$`-(N_c-1)\lambda`$，所印正号与后续$`w=(N_c-1)U/K`$也冲突。；PDF383确实印正号$`\operatorname{div}f=(N_c-1)\lambda`$，PDF384随后仍用正号的$`\nabla w\cdot f`$等式并给$`w=(N_c-1)U/K`$；原文逐字内容应保留。；已目视核对原页PDF383–384：散度与$`\nabla w\cdot f`$等式须同时改负号，$`w=(n-1)U/K`$的正号保留。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页383–384。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isoAnsatz`：定义
- `MD.Ch08.isoDivergencePrinted`：未证；原书疑误不证
- `MD.Ch08.isoDivergence_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticGibbsShell

印刷页 363 / PDF页 384。

### 1. 原文陈述

> $`\rho=Z^{-1}\exp(-(N_c-1)U/K)\delta[K-K_0]`$; $`K_0=\beta^{-1}(N_c-1)`$ gives the configurational Gibbs distribution.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isokineticShell (invm : Vec n) (K0 : ℝ) : Set (Phase n) := {z | kineticTwice invm z.2=K0}
def isoShellWeight (U : Vec n → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-((n:ℝ)-1)*U z.1/kineticTwice invm z.2)
theorem isoShell_gibbsFactor (U : Vec n → ℝ) (invm : Vec n) (β : ℝ)
    (hn : 1 < n) (hβ : 0 < β) (z : Phase n)
    (hz : z ∈ isokineticShell invm (((n:ℝ)-1)/β)) :
    isoShellWeight U invm z = Real.exp (-β*U z.1) := by
  have hnR : (1 : ℝ) < (n : ℝ) := by exact_mod_cast hn
  have hn' : (n:ℝ)-1 ≠ 0 := ne_of_gt (sub_pos.mpr hnR)
  change kineticTwice invm z.2 = ((n:ℝ)-1)/β at hz
  unfold isoShellWeight
  rw [hz]
  congr 1
  field_simp [hn', ne_of_gt hβ]
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。
- 覆盖缺口：动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页384。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isokineticShell`：定义
- `MD.Ch08.isoShellWeight`：定义
- `MD.Ch08.isoShell_gibbsFactor`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.1-StochasticIsokinetic

印刷页 364–365 / PDF页 385–386。

### 1. 原文陈述

> $`dq=p\,dt`$, $`dp=(F-\lambda p)dt`$, $`d\xi_1=(-\lambda\xi_1-\xi_2\xi_1)dt`$, $`d\xi_2=\mu_2^{-1}(\mu_1\xi_1^2-k_B T)dt-\gamma\xi_2\,dt+\sigma\,dW`$; $`p^2+\mu_1\xi_1^2/2=k_B T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinConstraint (Q1 : ℝ) (z : Vec 4) : ℝ := z 1^2+Q1*z 2^2/2
def sinMultiplier (Q1 : ℝ) (F : ℝ → ℝ) (z : Vec 4) : ℝ :=
  (z 1*F (z 0)-Q1*z 2^2*z 3/2)/sinConstraint Q1 z
def sinDrift (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinMultiplier Q1 F z
  ![z 1, F (z 0)-lam*z 1, -lam*z 2-z 3*z 2, (Q1*z 2^2-θ)/Q2-γ*z 3]
def isSINSolution (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  0 < Q1 ∧ 0 < Q2 ∧ 0 < θ ∧ 0 < γ ∧ sinConstraint Q1 x0=θ ∧
  additiveSDE P 1 W X x0 (sinDrift Q1 Q2 θ γ F)
    (fun _ ↦ ![0,0,0,Real.sqrt (2*γ*θ/Q2)])
theorem sinConstraint_balance (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinDrift Q1 Q2 θ γ F z) 1+Q1*z 2*(sinDrift Q1 Q2 θ γ F z) 2=0 := by
  have hden : 2*z 1^2+Q1*z 2^2 ≠ 0 := by
    intro h
    apply hK
    dsimp [sinConstraint]
    linarith
  simp [sinDrift, sinMultiplier, sinConstraint]
  field_simp [hden]
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际SIN漂移、正参数Wiener积分解和瞬时约束平衡；约束沿全路径保持未另证。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 热浴变量$`\xi_1,\xi_2\in\mathbb R`$，各质量、温度、摩擦正；随机噪声只在$`\xi_2`$；约束正值排除奇点。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页385–386。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinConstraint`：定义
- `MD.Ch08.sinMultiplier`：定义
- `MD.Ch08.sinDrift`：定义
- `MD.Ch08.isSINSolution`：定义
- `MD.Ch08.sinConstraint_balance`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.1-SINWeightPrinted

印刷页 365 / PDF页 386。

### 1. 原文陈述

> $`w=(U+\xi_2^2/2)/(p^2+\mu_1\xi_1^2/2)`$; integration over the isokinetic surface gives the Gibbs configurational density.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinWeightPrinted (U : ℝ → ℝ) (Q1 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+z 3^2/2)/sinConstraint Q1 z)
def sinWeight_corrected (U : ℝ → ℝ) (Q1 Q2 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+Q2*z 3^2/2)/sinConstraint Q1 z)
theorem sinWeight_stationary_corrected (U : ℝ → ℝ) (Q1 Q2 θ : ℝ)
    (hU : ContDiff ℝ 2 U) (hQ1 : 0 < Q1) (hQ2 : 0 < Q2) (hθ : 0 < θ)
    (z : Vec 4) (hz : sinConstraint Q1 z=θ) :
    textbookDivergence
      (fun x ↦ sinWeight_corrected U Q1 Q2 x • sinDrift Q1 Q2 θ 0 (fun q ↦ -deriv U q) x) z = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
- 覆盖缺口：原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；原印二次项缺$`\mu_2`$。
修正版：原送审补Q2的权重与壳面局部驻定签名PASS，非曲面测度不变性。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF386：$`\xi_2`$方程含$`\mu_2^{-1}`$，而w的$`\xi_2`$二次项缺$`\mu_2`$；一般$`\mu_2`$时应为$`\mu_2\xi_2^2/2`$。；PDF386确实印$`w=(U+\xi_2^2/2)/(p^2+\mu_1\xi_1^2/2)`$，未含$`\mu_2`$；statement_latex忠实，不能静默把原印式改成修正式。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页386。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinWeightPrinted`：定义
- `MD.Ch08.sinWeight_corrected`：定义
- `MD.Ch08.sinWeight_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINHarmonic

印刷页 366 / PDF页 387。

### 1. 原文陈述

> For $`\mu_1=\mu_2=1`$, $`dq=p\,dt`$, $`dp=(-q-\lambda p)dt`$, $`d\xi_1=(-\lambda\xi_1-\xi_2\xi_1)dt`$, $`d\xi_2=(\xi_1^2-k_B T-\gamma\xi_2)dt+\sigma\,dW`$, $`\lambda=(-qp-\xi_2\xi_1^2/2)/(p^2+\xi_1^2/2)`$, $`\sigma=\sqrt{2\gamma k_B T}`$. (8.45)–(8.47).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinHarmonicF (θ γ : ℝ) : Vec 4 → Vec 4 := sinDrift 1 1 θ γ (fun q ↦ -q)
def sinHarmonicG (θ γ : ℝ) : Vec 4 := ![0,0,0,Real.sqrt (2*γ*θ)]
def isSINHarmonicSolution (θ γ : ℝ) (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  isSINSolution 1 1 θ γ (fun q ↦ -q) P W X x0
def sinExceptional (θ : ℝ) : Set (Vec 4) :=
  {z | z 0=0 ∧ z 1=0 ∧ z 2^2=2*θ}
def sinHalfCylinder (θ : ℝ) (positive : Bool) : Set (Vec 4) :=
  {z | sinConstraint 1 z=θ ∧ (if positive then 0 < z 2 else z 2 < 0)}
theorem sinHalfCylinder_disjoint (θ : ℝ) :
    Disjoint (sinHalfCylinder θ true) (sinHalfCylinder θ false) := by
  apply Set.disjoint_left.mpr
  intro z hpos hneg
  exact (not_lt_of_ge (le_of_lt hpos.2)) hneg.2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`\theta=k_B T\gt 0`$、$`\gamma\gt 0`$、标量Wiener由isSINSolution给全；零$`\xi_1`$面不变和两个半柱的轨道符号保持需要ODE唯一性，列覆盖缺口。
- 覆盖缺口：谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页387。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinHarmonicF`：定义
- `MD.Ch08.sinHarmonicG`：定义
- `MD.Ch08.isSINHarmonicSolution`：定义
- `MD.Ch08.sinExceptional`：定义
- `MD.Ch08.sinHalfCylinder`：定义
- `MD.Ch08.sinHalfCylinder_disjoint`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINProjectedBracketsPrinted

印刷页 367 / PDF页 388。

### 1. 原文陈述

> $`u_0=\Pi f`$, $`u_1=\Pi[f,g]`$, $`u_2=\Pi[f,[f,g]]`$, $`u_3=\Pi[f,[f,[f,g]]]`$. The displayed equations (8.48)–(8.53) give their components, with $`D=2p^2+\xi_1^2`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def bracket4 (f g : Vec 4 → Vec 4) (z : Vec 4) : Vec 4 :=
  fderiv ℝ g z (f z)-fderiv ℝ f z (g z)
def sinBracket (θ γ : ℝ) : ℕ → Vec 4 → Vec 4
  | 0 => sinHarmonicF θ γ
  | 1 => bracket4 (sinHarmonicF θ γ) (fun _ ↦ sinHarmonicG θ γ)
  | k+2 => bracket4 (sinHarmonicF θ γ) (sinBracket θ γ (k+1))
def projectFirstThree (z : Vec 4) : Vec 3 := ![z 0,z 1,z 2]
def sinD (z : Vec 4) : ℝ := 2*z 1^2+z 2^2
def sinU0Printed (z : Vec 4) : Vec 3 :=
  ![z 1,z 2^2*(-z 0+z 1*z 3)/sinD z,-2*z 2*z 1*(-z 0+z 1*z 3)/sinD z]
def sinU1Printed (z : Vec 4) : Vec 3 := sinU0Printed z
def sinU2Printed (σ : ℝ) (z : Vec 4) : Vec 3 :=
  ![0,-σ*z 2^2*z 1/sinD z,2*σ*z 2*z 1^2/sinD z]
def sinU1DerivativePrinted (σ : ℝ) (z : Vec 4) : Vec 3 :=
  let d := fderiv ℝ (sinMultiplier 1 (fun q ↦ -q)) z (Pi.single 3 1)
  ![0,σ*z 1*d,z 2*(1+d)]
def sinProjected_corrected (θ γ : ℝ) (j : Fin 4) (z : Vec 4) : Vec 3 :=
  projectFirstThree (sinBracket θ γ j z)
def sinU2LongPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  let a := (2*γ*z 1^3+γ*z 2^2*z 1-z 2^2*z 0)/(sinD z)^2
  ![σ*z 2^2*z 1/sinD z,-σ*a,2*σ*z 2*z 1*a]
theorem sinU2Long_at_p0 (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) :
    sinU2LongPrinted σ γ z = ![0,σ*z 2^2*z 0/(sinD z)^2,0] := by
  ext i; fin_cases i <;> simp [sinU2LongPrinted,hp] <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 总化分式只在$`\theta\gt 0`$的约束面$`D=2\theta\gt 0`$使用；实际交换子先在四维完整计算再投影。
- 本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
- 已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
- 覆盖缺口：本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed各表达式忠实性PASS；(8.49)–(8.53)疑误待导师。
修正版：原送审完整四维真实括号再投影定义PASS，长式未声称等于真实括号。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF388：(8.50)的$`u_1`$公式实际重写$`u_0`$，(8.51)的$`u_2`$公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。；PDF388逐式核对：(8.48)为u0；(8.49)$`\xi_1`$分量前确无共同σ；(8.50)印u1却重复u0展开式；(8.51)印u2却是首交换子的投影。(8.52)的p分量确为$`-\sigma a`$而非$`-\sigma\xi_1^2a`$，故Lean忠实保留了原印式，不应替书改系数。；已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页388。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.bracket4`：定义
- `MD.Ch08.sinBracket`：定义
- `MD.Ch08.projectFirstThree`：定义
- `MD.Ch08.sinD`：定义
- `MD.Ch08.sinU0Printed`：定义
- `MD.Ch08.sinU1Printed`：定义
- `MD.Ch08.sinU2Printed`：定义
- `MD.Ch08.sinU1DerivativePrinted`：定义
- `MD.Ch08.sinProjected_corrected`：定义
- `MD.Ch08.sinU2LongPrinted`：定义
- `MD.Ch08.sinU2Long_at_p0`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINThirdBracketPrinted

印刷页 368 / PDF页 389。

### 1. 原文陈述

> The third projected commutator is displayed in (8.54), with polynomial $`\eta`$ in (8.55); its $`p=0`$ specialization is printed as $`u_3=-2\sigma q\partial_q-\sigma q(-\gamma+\xi_2)\partial_p`$ in (8.56).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinEtaPrinted (γ : ℝ) (z : Vec 4) : ℝ :=
  4*z 1^5*γ^2-8*z 1^5*z 2^2-4*z 2^2*z 1^3+4*z 1^3*γ^2*z 2^2-4*z 1^3*z 2^4-
  2*γ*z 2^2*z 1^2*z 0+4*z 1^2*z 0*z 3*z 2^2-4*z 2^2*z 0^2*z 1-
  2*z 2^4*z 1+z 1*γ^2*z 2^4-z 0*γ*z 2^4+z 2^4*z 3*z 0
def sinU3Printed (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![σ*(2*γ*z 1^3-4*z 1^3*z 3+4*z 1^2*z 0+z 2^2*z 1*z 3+γ*z 2^2*z 1-2*z 2^2*z 0)/(sinD z)^2,
    -σ*z 2^2*sinEtaPrinted γ z/(sinD z)^3,2*σ*z 2*z 1*sinEtaPrinted γ z/(sinD z)^3]
def sinU3ZeroPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0,-σ*z 0*(-γ+z 3),0]
def sinU3Zero_corrected (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0/z 2^2,-σ*z 0*(-γ+z 3),0]
theorem sinU3Zero_specialize (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) (hξ : z 2 ≠ 0) :
    sinU3Printed σ γ z = sinU3Zero_corrected σ γ z := by
  ext i; fin_cases i <;> simp [sinU3Printed,sinU3Zero_corrected,sinEtaPrinted,sinD,hp]
    <;> field_simp [hξ] <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印三重交换子候选及$`p=0`$内部代数核对；真实三重交换子等式列覆盖缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`\xi_1\ne0`$用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
- `_corrected`只修正(8.54)在$`p=0`$的内部代数特化，不能据此声称Printed长式等于真实三重括号。
- 覆盖缺口：$`\xi_1\ne0`$用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；(8.54)/(8.56)内部不一致。
修正版：原送审_corrected及specialize在内部代数特化意义下PASS，非真实三重括号校正。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF389：(8.54)q分量代$`p=0`$得到$`-2\sigma q/\xi_1^2`$，(8.56)遗漏$`\xi_1^2`$分母；原印多项式的其他系数仍待独立微分核对。；PDF389的(8.54)q分量分母为$`D^2`$，(8.55)的13项多项式逐项与sinEtaPrinted一致；(8.56)原印q分量为$`-2\sigma q`$，确无$`\xi_1^2`$分母。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页389。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinEtaPrinted`：定义
- `MD.Ch08.sinU3Printed`：定义
- `MD.Ch08.sinU3ZeroPrinted`：定义
- `MD.Ch08.sinU3Zero_corrected`：定义
- `MD.Ch08.sinU3Zero_specialize`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINBracketRank

印刷页 366–368 / PDF页 387–389。

### 1. 原文陈述

> For $`\theta\gt 0`$, $`\gamma\gt 0`$, on $`p^2+\xi_1^2/2=\theta`$ with $`\xi_1\ne0`$ and outside $`M_0`$, the fields $`f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]]`$ span the three-dimensional tangent space of the isokinetic cylinder.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem sinBracket_tangentSpan (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (z : Vec 4) (hz : sinConstraint 1 z=θ) (hξ : z 2 ≠ 0)
    (hout : z ∉ sinExceptional θ) :
    Submodule.span ℝ ({sinHarmonicG θ γ} ∪
      Set.range (fun j : Fin 4 ↦ sinBracket θ γ j z)) =
      LinearMap.ker (fderiv ℝ (sinConstraint 1) z).toLinearMap := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 例外直线外的有限括号张成目标；非完整遍历性定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- θ,γ正，$`\xi_1\ne0`$且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
- 覆盖缺口：θ,γ正，$`\xi_1\ne0`$且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：PDF387–389列出的五个场和M0吻合。原页先说明运动限制在$`\xi_1\gt 0`$或$`\xi_1\lt 0`$半空间；statement_latex应显式带上这一域，避免把“除M0外”误读为包含$`\xi_1=0`$的整个圆柱。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页387–389。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinBracket_tangentSpan`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINLyapunov

印刷页 368–369 / PDF页 389–390。

### 1. 原文陈述

> For $`\varphi=\xi_2^2/2`$, $`L_{isok}\varphi=(\xi_1^2-\beta^{-1})\xi_2-\gamma\xi_2^2+\sigma^2/2`$, and the isokinetic constraint bounds $`\xi_1`$. The negative tail drift supports the ergodicity argument with further assumptions.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinGenerator (θ γ : ℝ) (F : ℝ → ℝ) (f : Vec 4 → ℝ) (z : Vec 4) : ℝ :=
  additiveGenerator (sinDrift 1 1 θ γ F) (sinHarmonicG θ γ) f z
theorem sinGenerator_lyapunov (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hK : sinConstraint 1 z ≠ 0) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z =
      (z 2^2-θ)*z 3-γ*z 3^2+γ*θ := by
  sorry
theorem sinConstraint_bathBound (θ : ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    z 2^2 ≤ 2*θ := by
  dsimp [sinConstraint] at hz
  nlinarith [sq_nonneg (z 1)]

/-- 原页带有符号的线性尾项，只保留其表达式。 -/
def sinLyapunovTailPrinted (θ γ C : ℝ) (z : Vec 4) : ℝ :=
  -γ*z 3^2+C*z 3+γ*θ

/-- 修正版：对两侧尾部均适用的绝对值界。 -/
theorem sinLyapunovTail_corrected (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z ≤
      -γ*z 3^2+θ*|z 3|+γ*θ := by
  have hk : sinConstraint 1 z ≠ 0 := by rw [hz]; exact ne_of_gt hθ
  rw [sinGenerator_lyapunov θ γ hθ hγ F z hk]
  have hb := sinConstraint_bathBound θ z hz
  rcases le_total 0 (z 3) with h | h
  · rw [abs_of_nonneg h]
    nlinarith [mul_nonneg (sub_nonneg.mpr hb) h]
  · rw [abs_of_nonpos h]
    nlinarith [mul_nonneg (sq_nonneg (z 2)) (neg_nonneg.mpr h)]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] `sinGenerator_lyapunov`要求$`\theta\gt 0`$、$`\gamma\gt 0`$与$`\Lambda\ne0`$；`sinLyapunovTail_corrected`要求$`\Lambda=\theta`$，因$`\theta\gt 0`$自动排除$`\Lambda=0`$。
- `sinConstraint_bathBound`允许任意θ，但约束等式本身蕴含$`\theta\ge0`$及$`\xi_1^2\le2\theta`$；无需漏加$`\theta\gt 0`$。
- [ERRATUM?] 原页的固定有符号$`K\xi_2`$项不能统一支配两侧尾部；Printed仅存原印表达式，不断言其为上界；修正版为$`-\gamma\xi_2^2+\theta\lvert\xi_2\rvert+\gamma\theta`$。
- 仅覆盖生成元恒等式与约束界；局部计算尚有sorry，此项不据此判签名FAIL。未形式化遍历性的全局条件或充分性。
- [EXTRA] 当前生成元固定单位质量$`Q1=Q2=1`$，并使用$`\sigma^2=2\gamma\theta`$；常数$`\gamma\theta`$来自$`\sigma^2/2`$。局部生成元和约束界不等于全局遍历性。
- 覆盖缺口：局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。
- 覆盖缺口：仅覆盖生成元恒等式与约束界；局部计算尚有sorry，此项不据此判签名FAIL。未形式化遍历性的全局条件或充分性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；五项声明及全部依赖定义逐一审查：单位Q1,Q2及$`\sigma^2=2\gamma\theta`$下，sinGenerator和Lyapunov恒等式正确；hθ,hγ,hK与结论对象完整。sinConstraint_bathBound由$`p^2+\xi_1^2/2=\theta`$得到$`\xi_1^2\le2\theta`$，允许θ为任意实数没有遗漏。Printed只保存有符号尾项表达式，字面忠实性PASS；_corrected在$`\Lambda=\theta`$、$`\theta,\gamma\gt 0`$下给双侧有效界，陈述正确PASS，不包含遍历性结论。总体NEEDS_HUMAN源于原书固定有符号尾项上界疑误及全局遍历性论证尚需核实；不因恒等式sorry或依赖该恒等式的修正版而判签名FAIL。未编译或补证明。
原文版：Printed表达式忠实性PASS；有符号尾界疑误待导师。
修正版：单位质量、$`\sigma^2=2\gamma\theta`$下生成元与绝对值尾界签名网站PASS，非遍历性。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?][SOURCE_LYAPUNOV_SIGNED_BOUND] 原页390以$`\xi_1`$有界推出固定有符号$`K\xi_2`$全局上界，未区分$`\xi_2`$正负。需保留原文并由人工确认勘误；绝对值修正版正确。；[SOURCE_ERGODICITY_GAP] 原页还提出周期/有界配置、约束及候选测度在开集上为正等全局条件，并援引其他论证；当前局部Lean声明没有遍历性结论，不能将其当作完整遍历性证明。；已目视核对原页PDF390：原印有符号$`K\xi_2`$界不能统一控制正负两侧。单位质量$`Q1=Q2=1`$、$`\sigma^2=2\gamma\theta`$下修正版为$`-\gamma\xi_2^2+\theta\lvert\xi_2\rvert+\gamma\theta`$；仅为局部生成元和约束界，不推出遍历性。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页389–390。

### 7. 状态与证明位置

- `MD.Ch08.sinGenerator`：定义
- `MD.Ch08.sinGenerator_lyapunov`：未证；缺大型理论
- `MD.Ch08.sinConstraint_bathBound`：已证
- `MD.Ch08.sinLyapunovTailPrinted`：定义
- `MD.Ch08.sinLyapunovTail_corrected`：未证；缺大型理论；传递依赖未证陈述

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINForceSplitting

印刷页 370–371 / PDF页 391–392。

### 1. 原文陈述

> $`U=U_S+U_F`$ and $`F=F_S+F_F`$. The generators split into kinetic, isokinetic fast force, isokinetic slow force, Nosé and OU terms; each preserves $`\Lambda=p^2+\mu_1\xi_1^2/2`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinKField (z : Vec 4) : Vec 4 := ![z 1,0,0,0]
def sinForceField (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,-z 1*z 2*F/sinConstraint Q1 z,0]
def sinNField (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,(Q1*z 2^2-θ)/Q2]
def sinOField (γ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,-γ*z 3]
theorem sinSplit_fields (Q1 Q2 θ γ : ℝ) (FF FS : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    sinDrift Q1 Q2 θ γ (fun q ↦ FF q+FS q) z =
      sinKField z+sinForceField Q1 (FF (z 0)) z+
      sinForceField Q1 (FS (z 0)) z+sinNField Q1 Q2 θ z+sinOField γ z := by
  ext i; fin_cases i <;> simp [sinDrift,sinMultiplier,sinKField,sinForceField,sinNField,sinOField]
    <;> field_simp <;> ring
theorem sinForce_constraintBalance (Q1 F : ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinForceField Q1 F z) 1+Q1*z 2*(sinForceField Q1 F z) 2=0 := by
  change 2*z 1*(F-z 1^2*F/sinConstraint Q1 z)+
    Q1*z 2*(-z 1*z 2*F/sinConstraint Q1 z)=0
  generalize hd : sinConstraint Q1 z = lam at *
  field_simp [hK]
  rw [← hd]
  dsimp [sinConstraint]
  ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`Q_1,Q_2,\theta\gt 0`$且$`\Lambda=\theta`$为物理域，总化场保留作辅助；本条含完整漂移和分解及力子场瞬时约束平衡，其他子场的流存在/保约束列缺口。
- 覆盖缺口：五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页391–392。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinKField`：定义
- `MD.Ch08.sinForceField`：定义
- `MD.Ch08.sinNField`：定义
- `MD.Ch08.sinOField`：定义
- `MD.Ch08.sinSplit_fields`：已证
- `MD.Ch08.sinForce_constraintBalance`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINRAlgorithm

印刷页 371 / PDF页 392。

### 1. 原文陈述

> The SIN(R) algorithm uses $`\tilde h=h/r`$, $`r-2`$ repeated inner blocks, outer Nosé half-steps, combined fast/slow force half-steps and independent OU substeps.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
inductive SINStage where
  | kinetic | fast | slow | nose | ou
  deriving DecidableEq
def sinRStages (h : ℝ) (r : ℕ) : List (List (SINStage × ℝ)) :=
  let a := h/(r:ℝ)
  [[(.nose,h/2)],[(.fast,a/2),(.slow,h/2)],[(.kinetic,a)],[(.ou,a)],[(.fast,a/2)]] ++
  List.flatten (List.replicate (r-2)
    [[(.fast,a/2)],[(.kinetic,a/2)],[(.ou,a)],[(.kinetic,a/2)],[(.fast,a/2)]]) ++
  [[(.fast,a/2)],[(.ou,a)],[(.kinetic,a)],[(.fast,a/2),(.slow,h/2)],[(.nose,h/2)]]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印算法的阶段顺序与步长；不声称构造了各非线性子流。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 算法有效域$`h\gt 0`$、$`r\ge2`$；一组中多个场表示同一次合并传播，并非擅自换为两个非交换流。每次OU用独立标准正态新噪声。
- 这里只记录精确阶段表，具体随机核实现、保约束及全局误差/阶数列覆盖缺口。
- 覆盖缺口：原印算法的阶段顺序与步长；不声称构造了各非线性子流。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页392。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinRStages`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINNoseSubsplitting

印刷页 372 / PDF页 393。

### 1. 原文陈述

> $`L_N=L_N^{(1)}+L_N^{(2)}`$. The first term acts on $`p,\xi_1`$, the second has $`\mu_2^{-1}(\mu_1\xi_1^2-\beta^{-1})\partial_{\xi_2}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinN1Field (Q1 : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,0]
def sinN2Field (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,(Q1*z 2^2-θ)/Q2]
theorem sinN_split (Q1 Q2 θ : ℝ) (z : Vec 4) :
    sinNField Q1 Q2 θ z=sinN1Field Q1 z+sinN2Field Q1 Q2 θ z := by
  ext i; fin_cases i <;> simp [sinNField,sinN1Field,sinN2Field]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Nosé场的两项分解恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正质量、温度及$`\Lambda\gt 0`$作为物理资格；高阶Yoshida/Suzuki组合的系数和误差阶未在原页给出，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页393。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinN1Field`：定义
- `MD.Ch08.sinN2Field`：定义
- `MD.Ch08.sinN_split`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINForceExactPrinted

印刷页 372 / PDF页 393。

### 1. 原文陈述

> $`\dot p=F-p^2F/\Lambda`$, $`\dot\xi_1=p\xi_1F/\Lambda`$. The printed solution is $`p(h)=(p(0)+(F/m)s(h))/\dot s(h)`$, $`\xi_1(h)=\xi_1(0)/\dot s(h)`$, with $`s(t)=b^{-1/2}\sinh(t\sqrt b)+(a/b)(\cosh(t\sqrt b)-1)`$, $`a=Fp(0)/\Lambda`$, $`b=F^2/\Lambda`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinForceAux (a b t : ℝ) : ℝ :=
  if b=0 then t+a*t^2/2 else Real.sinh (t*Real.sqrt b)/Real.sqrt b+a/b*(Real.cosh (t*Real.sqrt b)-1)
def sinForceFlow (Q1 F t : ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinConstraint Q1 z
  let s := sinForceAux (F*z 1/lam) (F^2/lam)
  ![z 0,(z 1+F*s t)/deriv s t,z 2/deriv s t,z 3]
def sinForceODEPrinted (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,z 1*z 2*F/sinConstraint Q1 z,0]
def sinForceODE_corrected (Q1 F : ℝ) : Vec 4 → Vec 4 := sinForceField Q1 F
theorem sinForceFlow_solution_corrected (Q1 F : ℝ) (z : Vec 4)
    (hQ1 : 0 < Q1) (hK : 0 < sinConstraint Q1 z) (t : ℝ)
    (hden : deriv (sinForceAux (F*z 1/sinConstraint Q1 z) (F^2/sinConstraint Q1 z)) t ≠ 0) :
    HasDerivAt (fun s ↦ sinForceFlow Q1 F s z)
      (sinForceField Q1 F (sinForceFlow Q1 F t z)) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印子场、显式候选与校正ODE的局部导数目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 质量按本节假设取1；$`Q_1`$、Λ正，排除$`\dot s=0`$；$`F=0`$用$`b=0`$的解析延拓，避免总化除法假装极限。
- 只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed正号ODE忠实性PASS；与候选导数冲突。
修正版：原送审负号_corrected及局部解签名PASS；限$`m=1`$与非零分母。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF393：所印$`\dot\xi_1`$为正号，与前页力子场及$`\xi_1(h)=\xi_1(0)/\dot s(h)`$的负号导数冲突。保留原印和负号工作修正版。；[ERRATUM?] 保留Printed，给$`\xi_1`$负号版添加[ERRATUM?]；保留$`m=1`$的[EXTRA]，不要把工作修正版回填为原文。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页393。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinForceAux`：定义
- `MD.Ch08.sinForceFlow`：定义
- `MD.Ch08.sinForceODEPrinted`：定义
- `MD.Ch08.sinForceODE_corrected`：定义
- `MD.Ch08.sinForceFlow_solution_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.4-SINThreeLevelPotential

印刷页 373 / PDF页 394。

### 1. 原文陈述

> $`U_{Total}=U_{bonds}+U_{s.r.}+U_{l.r.}`$; $`h_{outer}`$ and $`h_{mid}`$ are integer multiples of the next smaller stepsizes.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def threeLevelPotential (bond short long : Vec n → ℝ) : Vec n → ℝ := bond+short+long
def nestedTimeSteps (inner middle outer : ℝ) : Prop :=
  0 < inner ∧ ∃ r s : ℕ, 0 < r ∧ 0 < s ∧ middle=r*inner ∧ outer=s*middle
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 三层势与步长嵌套的定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅保留势的三项分解和整数时标嵌套；SPME实现、99fs稳定性及水分子径向分布等属于数值观察，逐项排除。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页394。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.threeLevelPotential`：定义
- `MD.Ch08.nestedTimeSteps`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7-GeneralizedLangevin

印刷页 374 / PDF页 395。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$, $`dp=-\nabla U(q)dt-\int_0^t\Gamma(t-s)p(s)ds\,dt+dB`$, $`q(0)=q_0,p(0)=p_0`$. $`\Gamma`$ is the memory kernel and $`B`$ is colored noise. (8.57)–(8.58).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def memoryDrag (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (p : ℝ → Vec n) (t : ℝ) : Vec n :=
  -∫ s in (0 : ℝ)..t, Γ (t-s) *ᵥ p s
def generalizedLangevin (P : Measure Ω) (invm : Vec n) (U : Vec n → ℝ)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (B : ℝ → Ω → Vec n)
    (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  IsProbabilityMeasure P ∧ (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧ ContinuousOn Γ (Ici 0) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ B t sample) (Ici 0)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ B s sample) inferInstance] (X t)) ∧
  ∀ t, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable
      (fun s ↦ -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s) volume 0 t) ∧
    ∀ᵐ sample ∂P,
      (X t sample).1=x0.1+∫ s in (0 : ℝ)..t, (fun i ↦ invm i*(X s sample).2 i) ∧
      (X t sample).2=x0.2+(∫ s in (0 : ℝ)..t,
        -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s)+B t sample-B 0 sample
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 连续矩阵记忆核下的卷积及GLE积分解类定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。
- 本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。
- [EXTRA] generalizedLangevin仅为给定B的方程规格；未在此谓词约束有色性、非Gaussian性或涨落耗散关系。
- 已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
- [EXTRA] generalizedLangevin仅为给定加性驱动B的积分方程，噪声分布、有色性及FD未在本定义内强制，由另条规格给出。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：原送审给定B的积分方程规格可接受；有色/非Gaussian同义说法待导师。
修正版：本轮文字修正：有色Gaussian可以存在；不新增分布或FD结论。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：[ERRATUM?] 保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。；已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页395。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.memoryDrag`：定义
- `MD.Ch08.generalizedLangevin`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7-GLEFluctuationDissipationPrinted

印刷页 374 / PDF页 395。

### 1. 原文陈述

> $`\langle R_i(t+s)R_j(t)\rangle=k_B T\gamma_{ij}(s)\delta_{ij}`$, $`s\ge0`$. $`\Gamma(t)=\gamma(t)I`$ in the scalar-kernel specialization. (8.59).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def randomForceQualification (P : Measure Ω) (R : ℝ → Ω → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ ∀ t, 0 ≤ t → ∀ i, MemLp (fun sample ↦ R t sample i) 2 P ∧
    (∫ sample, R t sample i ∂P)=0
def gleFDPrinted (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=if i=j then θ*Γ s i j else 0
def gleFD_corrected (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=θ*Γ s i j
def scalarMemoryMatrix (γ : ℝ → ℝ) (t : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal (fun _ ↦ γ t)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- 覆盖缺口：修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed的δ忠实于原页；一般矩阵解释有疑。
修正版：原送审去δ的矩阵协方差目标PASS；可实现性另需正定资格。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF395：一般矩阵核后额外乘$`\delta_{ij}`$会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。；[ERRATUM?] 保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页395。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.randomForceQualification`：定义
- `MD.Ch08.gleFDPrinted`：定义
- `MD.Ch08.gleFD_corrected`：定义
- `MD.Ch08.scalarMemoryMatrix`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7-PronyKernel

印刷页 375 / PDF页 396。

### 1. 原文陈述

> $`\gamma(t)=\sum_k(c_k/\tau_k)\exp(-t/\tau_k)`$, $`t\ge0`$. (8.60).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pronyKernel {K : ℕ} (c τ : Fin K → ℝ) (t : ℝ) : ℝ :=
  ∑ k, c k/τ k*Real.exp (-t/τ k)
def pronyQualification {K : ℕ} (c τ : Fin K → ℝ) : Prop :=
  ∀ k, 0 < c k ∧ 0 < τ k
theorem pronyKernel_nonneg {K : ℕ} (c τ : Fin K → ℝ)
    (h : pronyQualification c τ) (t : ℝ) : 0 ≤ pronyKernel c τ t := by
  apply Finset.sum_nonneg
  intro k hk
  exact mul_nonneg (le_of_lt (div_pos (h k).1 (h k).2)) (le_of_lt (Real.exp_pos _))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正$`c_k`$、$`\tau_k`$为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。
- 覆盖缺口：正$`c_k`$、$`\tau_k`$为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页396。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pronyKernel`：定义
- `MD.Ch08.pronyQualification`：定义
- `MD.Ch08.pronyKernel_nonneg`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-PronyMemoryODE

印刷页 375 / PDF页 396。

### 1. 原文陈述

> $`\eta_{ik}(t)=-\int_0^t(c_k/\tau_k)\exp(-(t-s)/\tau_k)p_i(s)ds`$, $`d\eta_{ik}=-\eta_{ik}dt/\tau_k-c_kp_i\,dt/\tau_k`$. Equations (8.61)–(8.64) remove the convolution history.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pronyMemory (c τ : ℝ) (p : ℝ → ℝ) (t : ℝ) : ℝ :=
  -∫ s in (0 : ℝ)..t, c/τ*Real.exp (-(t-s)/τ)*p s
theorem pronyMemory_derivative (c τ : ℝ) (hτ : 0 < τ)
    (p : ℝ → ℝ) (hp : Continuous p) (t : ℝ) :
    HasDerivAt (pronyMemory c τ p) (-pronyMemory c τ p t/τ-c/τ*p t) t := by
  sorry
def pronyMomentumDrift {K : ℕ} (F : Vec n) (η : Fin K → Vec n) (R : Vec n) : Vec n :=
  F+(∑ k, η k)+R
theorem pronyMemory_sum {K : ℕ} (c τ : Fin K → ℝ) (p : ℝ → Vec n)
    (hq : pronyQualification c τ) (hp : Continuous p) (t : ℝ) :
    (∑ k, fun i ↦ pronyMemory (c k) (τ k) (fun s ↦ p s i) t) =
      memoryDrag (scalarMemoryMatrix (n:=n) (pronyKernel c τ)) p t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 卷积辅助定义、微分关系和有限和等式；与扩展随机解的完整等价列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- p连续、τ正保证有限区间卷积合法；仅消去有限Prony历史，未声称无限Prony极限或解分布等价。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页396。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pronyMemory`：定义
- `MD.Ch08.pronyMemory_derivative`：未证；缺大型理论
- `MD.Ch08.pronyMomentumDrift`：定义
- `MD.Ch08.pronyMemory_sum`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-PronyOUStationarity

印刷页 376 / PDF页 397。

### 1. 原文陈述

> $`dR_{ik}=-R_{ik}dt/\tau_k+\sqrt{2\theta c_k}dW_{ik}/\tau_k`$；原印$`E[R_{ik}(t)]=0`$、$`E[R_{ik}(t+s)R_{ik}(t)]=(\theta c_k/\tau_k)\exp(-s/\tau_k)`$，$`t,s\ge0`$；$`R_i=\sum_{k\in\mathrm{Fin}\,K}R_{ik}`$（书中$`k=1,\ldots,k_{max}`$，$`K=k_{max}`$）。[EXTRA] 两个Lean相关式均补平稳初态及独立性，不是无条件原印结论。

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def stationaryPronyOU (P : Measure Ω) (W : ℝ → Ω → Vec 1) (R : ℝ → Ω → ℝ)
    (c τ θ : ℝ) : Prop :=
  independentWiener P 1 W ∧ 0 < c ∧ 0 < τ ∧ 0 < θ ∧
  HasLaw (R 0) (gaussianReal 0 (Real.toNNReal (θ*c/τ))) P ∧
  IndepFun (R 0) (fun sample t ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ R t sample) (Ici 0)) ∧
  (∀ t, 0 ≤ t → MemLp (R t) 2 P) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    R t sample=R 0 sample+(∫ s in (0 : ℝ)..t, -R s sample/τ)+
      Real.sqrt (2*θ*c)/τ*(W t sample 0-W 0 sample 0)
theorem pronyOU_covariance (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := by
  sorry
def totalPronyRandomForce {K : ℕ} (R : Fin K → ℝ → Ω → ℝ) (t : ℝ) (sample : Ω) : ℝ :=
  ∑ k, R k t sample

/-- 修正版显式使用已定义的平稳Gaussian初态及与W独立资格；原印未写该前提。 -/
theorem pronyOU_covariance_corrected (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := pronyOU_covariance P W R c τ θ hR t s ht hs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | (8.65)–(8.67)的单分量OU方程、原印均值/相关式及有限和；Lean的两个covariance定理均为显式带平稳资格的修正版；保留原印缺省资格疑误。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] θ代表$`k_B T`$，c、τ、θ严格为正；W为一个实Brownian坐标（Vec 1）。
- [EXTRA] $`R(0)`$具有$`N(0,\theta c/\tau)`$律且与整条W独立；非负时间路径几乎处处连续，各非负时刻$`R(t)`$属于$`L^2`$；积分方程逐个非负时刻几乎处处成立。
- [EXTRA] 这里没有对多个模式的W作联合独立假设；totalPronyRandomForce仅为有限和定义，不声称总协方差公式。
- [EXTRA] $`t,s\ge0`$；totalPronyRandomForce的求和为$`k\in\mathrm{Fin}\,K`$（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。
- 覆盖缺口：[EXTRA] 这里没有对多个模式的W作联合独立假设；totalPronyRandomForce仅为有限和定义，不声称总协方差公式。
- 覆盖缺口：[EXTRA] $`t,s\ge0`$；totalPronyRandomForce的求和为$`k\in\mathrm{Fin}\,K`$（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；{"overall": "NEEDS_HUMAN仅针对原书缺省平稳初态及其解释；所列修正版签名在数学上合理，不因sorry判FAIL。", "objects_and_domains": "Ω为任意可测空间，P为Measure Ω；independentWiener在hR内保证P为概率测度。$`W:\mathbb R\to\Omega\to(\mathrm{Fin}\,1\to\mathbb R)`$，$`R:\mathbb R\to\Omega\to\mathbb R`$，c、τ、θ为实数且均严格正。只对$`t\ge0`$、$`s\ge0`$作结论，不断言负时间驻定。", "declarations": [{"lean_decl": "MD.Ch08.stationaryPronyOU", "verdict": "PASS", "explanation": "一维Brownian、方差$`\theta c/\tau`$的中心Gaussian初态、初态与整条W独立、非负时间连续与$`L^2`$、积分OU方程齐全。漂移$`-R/\tau`$及噪声$`\sqrt{2\theta c}/\tau`$与(8.65)吻合；Gaussian第二参数为方差且因正参数toNNReal不截断。此定义是补充资格，不是原印逐字前提。"}, {"lean_decl": "MD.Ch08.pronyOU_covariance", "verdict": "PASS", "explanation": "全称量化P,W,R,c,τ,θ及非负t,s；hR已包含全部平稳资格。完整结论同时给出$`E R(t)=0`$及$`E[R(t+s)R(t)]=(\theta c/\tau)e^{-s/\tau}`$，不是只给单边不等式或仅$`s=0`$。该陈述数学正确；没有Printed/literal标识，不要求它保留无资格的错误断言。"}, {"lean_decl": "MD.Ch08.totalPronyRandomForce", "verdict": "PASS", "explanation": "任意自然数K与$`R:\mathrm{Fin}\,K\to\mathbb R\to\Omega\to\mathbb R`$，在任意t、sample逐点有限求和。Fin K对应原书1至kmax的K个模式的重编号，$`K=0`$为自然空和扩展；未偷加独立性或总协方差结论。"}, {"lean_decl": "MD.Ch08.pronyOU_covariance_corrected", "verdict": "PASS", "explanation": "与前一定理完全相同的量词、hR、时间域及完整二联结论；通过引用前一定理复用补充资格，并非另行证明更强无条件断言。"}]}
原文版：原印无初态资格的(8.66)待导师。
修正版：pronyOU_covariance及_corrected均为[EXTRA]平稳初态版本，签名网站PASS；非无条件原印定理。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原页(8.66)断言零均值及与t无关的二阶矩，页内未声明初始律；仅由(8.65)不能推出。原印原句必须保留，是否上下文已默认平稳解释需人工确认。；[EXTRA] stationaryPronyOU补充了正参数、平稳Gaussian初态、与整条W独立、路径连续及各非负时刻$`L^2`$资格；应显式标记其为修正版前提。pronyOU_covariance和_corrected签名相同，前者也已经是带补充资格的版本，不能当作无条件原印断言。；已目视核对原页PDF397：(8.66)印出$`s\ge0`$但未说明平稳初态。修正版另加[EXTRA]初态$`N(0,\theta c/\tau)`$且与整条W独立；$`t,s\ge0`$；有限和用$`k\in\mathrm{Fin}\,K`$，不宣称跨模式总协方差。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页397。

### 7. 状态与证明位置

- `MD.Ch08.stationaryPronyOU`：定义
- `MD.Ch08.pronyOU_covariance`：未证；缺大型理论
- `MD.Ch08.totalPronyRandomForce`：定义
- `MD.Ch08.pronyOU_covariance_corrected`：未证；缺大型理论；传递依赖未证陈述

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-CombinedPronyVariable

印刷页 376 / PDF页 397。

### 1. 原文陈述

> $`\sigma_{ik}=\eta_{ik}+R_{ik}`$ yields $`d\sigma_{ik}=-\sigma_{ik}dt/\tau_k-c_kp_i\,dt/\tau_k+\sqrt{2k_B T c_k}dW_{ik}/\tau_k`$. (8.68)–(8.70).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev GLEState (n K : ℕ) := Phase n × (Fin K → Vec n)
def gleDrift {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c τ : Fin K → ℝ)
    (z : GLEState n K) : GLEState n K :=
  ((fun i ↦ invm i*z.1.2 i,-gradient U z.1.1+∑ k, z.2 k),
   fun k i ↦ -z.2 k i/τ k-c k/τ k*z.1.2 i)
def gleNoise {K : ℕ} (c τ : Fin K → ℝ) (θ : ℝ)
    (e : Fin (K*n) ≃ Fin K × Fin n) (j : Fin (K*n)) : GLEState n K :=
  ((0,0),fun k i ↦ if (k,i)=e j then Real.sqrt (2*θ*c k)/τ k else 0)
def isExtendedGLESolution {K : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (c τ : Fin K → ℝ) (θ : ℝ) (e : Fin (K*n) ≃ Fin K × Fin n)
    (P : Measure Ω) (W : ℝ → Ω → Vec (K*n))
    (X : ℝ → Ω → GLEState n K) (x0 : GLEState n K) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ pronyQualification c τ ∧ ContDiff ℝ 1 U ∧
  additiveSDE P (K*n) W X x0 (gleDrift invm U c τ) (gleNoise c τ θ e)
theorem combinedProny_drift (η R c τ p : ℝ) :
    (-η/τ-c/τ*p)+(-R/τ)=-(η+R)/τ-c/τ*p := by ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 有限维扩展SDE完整积分规格及$`\sigma=\eta+R`$的漂移恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 额外变量取实数；正质量、c、τ、温度和独立标准向量Wiener写入解规格。e仅把有限噪声坐标编号为(k,i)。
- 本条实际是加性扩展SDE和漂移合并恒等式；Markov半群构造、解存在唯一及与非Markov GLE分布等价列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页397。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.GLEState`：定义
- `MD.Ch08.gleDrift`：定义
- `MD.Ch08.gleNoise`：定义
- `MD.Ch08.isExtendedGLESolution`：定义
- `MD.Ch08.combinedProny_drift`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-PronyLangevinLimit

印刷页 376–377 / PDF页 397–398。

### 1. 原文陈述

> Formally $`\tau_k\to0`$ gives $`\sigma_{ik}dt=-c_kp_i\,dt+\sqrt{2k_B T c_k}dW_{ik}`$ and Langevin friction $`\hat\gamma=\sum_kc_k`$. Independent Gaussian variances add.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pronyEffectiveFriction {K : ℕ} (c : Fin K → ℝ) : ℝ := ∑ k, c k
theorem pronyLimit_drift {K : ℕ} (c : Fin K → ℝ) (F p : ℝ) :
    F-∑ k, c k*p=F-pronyEffectiveFriction c*p := by
  simp [pronyEffectiveFriction,Finset.sum_mul]
theorem independentGaussian_varianceSum {K : ℕ} (P : Measure Ω)
    (R : Ω → (Fin K → ℝ)) (c : Fin K → ℝ) (hc : ∀ k, 0 ≤ c k)
    (hR : HasLaw R (Measure.pi (fun _ : Fin K ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ ∑ k, Real.sqrt (c k)*R sample k)
      (gaussianReal 0 (Real.toNNReal (pronyEffectiveFriction c))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 有效摩擦定义、合并漂移和有限Gaussian求和分布，不是小记忆时间极限定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅形式极限系数与真实有限个独立Gaussian线性组合；$`\tau\to0`$过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页397–398。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pronyEffectiveFriction`：定义
- `MD.Ch08.pronyLimit_drift`：已证
- `MD.Ch08.independentGaussian_varianceSum`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-GeneralizedLangevinIntegrator

印刷页 377 / PDF页 398。

### 1. 原文陈述

> The four-step method updates $`p_{half}`$, $`q_{new}`$, $`\sigma_{new,k}=\theta_k\sigma_k-(1-\theta_k)c_kp_{half}+\alpha_k\sqrt{2k_B T c_k}Z_k`$, then $`p_{new}`$ with the new force and new $`\sigma`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def gleIntegrator {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c decay noise : Fin K → ℝ)
    (θ h : ℝ) (Z : Fin K → Vec n) (z : GLEState n K) : GLEState n K :=
  let ph := z.1.2+(h/2) • (-gradient U z.1.1+∑ k, z.2 k)
  let qn := z.1.1+(h • fun i ↦ invm i*ph i)
  let sn := fun k i ↦ decay k*z.2 k i-(1-decay k)*c k*ph i+
    noise k*Real.sqrt (2*θ*c k)*Z k i
  ((qn,ph+(h/2) • (-gradient U qn+∑ k, sn k)),sn)
def gleNormalSequence {K : ℕ} (P : Measure Ω) (Z : ℕ → Ω → Fin K → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun Z P ∧ ∀ j,
    HasLaw (Z j) (Measure.pi (fun _ : Fin K ↦ Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) P
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 四个实际更新及其全部噪声资格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`h\gt 0`$，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。
- 此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页398。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.gleIntegrator`：定义
- `MD.Ch08.gleNormalSequence`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-GLEConsistentCoefficients

印刷页 377 / PDF页 398。

### 1. 原文陈述

> For consistency $`\theta_k=1-h/\tau_k+O(h^2)`$, $`\alpha_k=\sqrt h/\tau_k+O(h)`$. Choose $`\theta_k=\exp(-h/\tau_k)`$, $`\alpha_k=\sqrt{(1-\theta_k)^2/h}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def gleDecay (τ h : ℝ) : ℝ := Real.exp (-h/τ)
def gleNoiseCoefficient (τ h : ℝ) : ℝ := Real.sqrt ((1-gleDecay τ h)^2/h)
def gleCoefficientConsistency (τ : ℝ) (decay noise : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ decay h-(1-h/τ)) (fun h ↦ h^2) ∧
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ noise h-Real.sqrt h/τ) (fun h ↦ h)
theorem gleCoefficients_consistent (τ : ℝ) (hτ : 0 < τ) :
    gleCoefficientConsistency τ (gleDecay τ) (gleNoiseCoefficient τ) := by
  sorry
theorem gleCoefficient_smallMemory (h : ℝ) (hh : 0 < h) :
    Tendsto (fun τ ↦ (gleDecay τ h,gleNoiseCoefficient τ h))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 ((0 : ℝ),1/Real.sqrt h)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 两项一致性渐近和所选单步系数的$`\tau\to0`$极限。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- h从正侧趋0、τ固定正；小记忆极限另固定$`h\gt 0`$，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页398。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.gleDecay`：定义
- `MD.Ch08.gleNoiseCoefficient`：定义
- `MD.Ch08.gleCoefficientConsistency`：定义
- `MD.Ch08.gleCoefficients_consistent`：未证；缺大型理论
- `MD.Ch08.gleCoefficient_smallMemory`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-NPTThermodynamics

印刷页 378 / PDF页 399。

### 1. 原文陈述

> $`P=-(\partial E/\partial V)_{S,N}`$; the Maxwell cyclic relation gives $`(\partial S/\partial V)_{E,N}=P/T`$ and $`(\partial S/\partial E)_{V,N}=1/T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def thermodynamicPressure (E : ℝ → ℝ → ℝ → ℝ) (S V N : ℝ) : ℝ :=
  -deriv (fun v ↦ E S v N) V
def maxwellCycle (dSdE dEdV dVdS : ℝ) : Prop := dSdE*dEdV*dVdS = -1
theorem maxwellPressureRelation (T P dVdS : ℝ) (hT : T ≠ 0)
    (hcycle : maxwellCycle (1/T) (-P) dVdS) : dVdS⁻¹=P/T := by
  have hprod : P*dVdS=T := by
    dsimp [maxwellCycle] at hcycle
    field_simp [hT] at hcycle
    linarith
  have hz : dVdS ≠ 0 := by
    intro hz; rw [hz,mul_zero] at hprod; exact hT hprod.symm
  apply (eq_div_iff hT).2
  rw [← hprod]
  field_simp [hz]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 压力定义和给定非零温度/循环关系后的代数推论。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- E的熵、体积、粒子数参数固定顺序明示；Maxwell循环作为热力学可逆导数资格，并非从任意E无条件推出。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页399。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.thermodynamicPressure`：定义
- `MD.Ch08.maxwellCycle`：定义
- `MD.Ch08.maxwellPressureRelation`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-NPTBathTaylor

印刷页 378 / PDF页 399。

### 1. 原文陈述

> $`S(N_2,V_2,E_2)=S(\tilde N-N,\tilde V-V,\tilde E-E)\approx S(N_2,\tilde V,\tilde E)-(E+PV)/T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nptBathLinear (S0 T P E V : ℝ) : ℝ := S0-(E+P*V)/T
theorem nptEntropy_firstOrder (S : ℝ × ℝ → ℝ) (E0 V0 T P : ℝ) (hT : 0 < T)
    (hS : DifferentiableAt ℝ S (E0,V0))
    (hderiv : ∀ v : ℝ × ℝ, fderiv ℝ S (E0,V0) v=v.1/T+(P/T)*v.2) :
    Asymptotics.IsLittleO (𝓝 (0 : ℝ × ℝ))
      (fun z ↦ S (E0-z.1,V0-z.2)-nptBathLinear (S (E0,V0)) T P z.1 z.2)
      (fun z : ℝ × ℝ ↦ ‖z‖) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 线性熵近似与明确的一阶小o余项目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 固定粒子数参数，只对E,V的小扰动；显式Fréchet可微及热力学导数识别，不把原文≈当作精确等式。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页399。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nptBathLinear`：定义
- `MD.Ch08.nptEntropy_firstOrder`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-NPTDensity

印刷页 378–379 / PDF页 399–400。

### 1. 原文陈述

> $`\rho_{NPT}=Z_{NPT}^{-1}\exp[-\beta(H+PV)]`$, $`\beta^{-1}=k_B T`$; physical volume $`V`$ is positive.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def volumeScale (V : ℝ) : ℝ := Real.rpow V (1/3 : ℝ)
def nptBox (n : ℕ) : Set (Phase n × ℝ) :=
  {z | 0 < z.2 ∧ ∀ i, |z.1.1 i| ≤ volumeScale z.2/2}
def nptWeight (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β*(H z+P*z.2))
def nptDensity (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∫ y, nptWeight H β P y ∂volume.restrict (nptBox n))⁻¹*nptWeight H β P z
theorem nptDensity_normalizes (H : Phase n × ℝ → ℝ) (β P : ℝ) (hβ : 0 < β)
    (hi : Integrable (nptWeight H β P) (volume.restrict (nptBox n)))
    (hZ : 0 < ∫ z, nptWeight H β P z ∂volume.restrict (nptBox n)) :
    probabilityDensity (volume.restrict (nptBox n)) (nptDensity H β P) := by
  refine ⟨fun z ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ))
    (le_of_lt (Real.exp_pos _)),hi.const_mul _,?_⟩
  simp only [nptDensity,integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 正体积盒内NPT权重和有资格时的概率归一化。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 三维N粒子时$`n=3N`$；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。
- 覆盖缺口：三维N粒子时$`n=3N`$；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页399–400。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.volumeScale`：定义
- `MD.Ch08.nptBox`：定义
- `MD.Ch08.nptWeight`：定义
- `MD.Ch08.nptDensity`：定义
- `MD.Ch08.nptDensity_normalizes`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-AndersenCoordinates

印刷页 379–380 / PDF页 400–401。

### 1. 原文陈述

> $`q_i=V^{1/3}\bar q_i`$; $`\dot q_i=(1/3)V^{-2/3}\dot V\bar q_i+V^{1/3}\dot{\bar q}_i`$; $`\bar p_i=m_iV^{1/3}\dot q_i`$. (8.71),(8.72).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def andersenPosition (V : ℝ) (qbar : Vec n) : Vec n := volumeScale V • qbar
def andersenVelocity (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  ((1/3 : ℝ)*Real.rpow V (-2/3 : ℝ)*Vdot) • qbar+volumeScale V • vbar
def andersenMomentum (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  fun i ↦ m i*((1/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i+
    Real.rpow V (2/3 : ℝ)*vbar i)
theorem andersenPosition_derivative (V : ℝ → ℝ) (qbar : ℝ → Vec n)
    (t Vdot : ℝ) (vbar : Vec n) (hV : 0 < V t)
    (hdV : HasDerivAt V Vdot t) (hdq : HasDerivAt qbar vbar t) :
    HasDerivAt (fun s ↦ andersenPosition (V s) (qbar s))
      (andersenVelocity (V t) Vdot (qbar t) vbar) t := by
  sorry
theorem andersenMomentum_velocity (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) :
    andersenMomentum m V Vdot qbar vbar =
      fun i ↦ m i*volumeScale V*andersenVelocity V Vdot qbar vbar i := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 位置、速度、共轭动量的实际变换式与两个局部等式目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`V\gt 0`$用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页400–401。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.andersenPosition`：定义
- `MD.Ch08.andersenVelocity`：定义
- `MD.Ch08.andersenMomentum`：定义
- `MD.Ch08.andersenPosition_derivative`：未证；缺大型理论
- `MD.Ch08.andersenMomentum_velocity`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-AndersenKineticEnergy

印刷页 379 / PDF页 400。

### 1. 原文陈述

> After $`q=V^{1/3}\bar q`$, $`\bar K=\sum_i(m_i/2)[(1/9)V^{-4/3}\dot V^2\lvert\bar q_i\rvert^2+(2/3)V^{-1/3}\dot V\bar q_i\cdot\dot{\bar q}_i+V^{2/3}\lvert\dot{\bar q}_i\rvert^2]`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def andersenKinetic (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i*(andersenVelocity V Vdot qbar vbar i)^2/2
def andersenKineticExpanded (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i/2*((1/9 : ℝ)*Real.rpow V (-4/3 : ℝ)*Vdot^2*qbar i^2+
    (2/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i*vbar i+
    Real.rpow V (2/3 : ℝ)*vbar i^2)
theorem andersenKinetic_expansion (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) : andersenKinetic m V Vdot qbar vbar =
      andersenKineticExpanded m V Vdot qbar vbar := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印动能展开的逐标量坐标版本。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 坐标逐分量求和就是三维点积展开，避免把Pi类型的最大范数误作物理Euclidean长度；V正。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页400。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.andersenKinetic`：定义
- `MD.Ch08.andersenKineticExpanded`：定义
- `MD.Ch08.andersenKinetic_expansion`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-AndersenHamiltonianPrinted

印刷页 380 / PDF页 401。

### 1. 原文陈述

> $`\hat H=\sum_i\lvert\bar p_i\rvert^2/(2m_iV^{2/3})+\bar U(\bar q;V)+p_V^2/(2\mu_V)+PV`$, and $`\rho_{NPT}=\sqrt{\beta/(2\pi\mu_V)}\int\exp(-\beta\hat H)dp_V`$. (8.73).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def andersenHamiltonian (m : Vec n) (U : Vec n → ℝ) (QV P : ℝ)
    (z : (Phase n × ℝ) × ℝ) : ℝ :=
  (∑ i, z.1.1.2 i^2/(2*m i*Real.rpow z.1.2 (2/3 : ℝ)))+
    U (andersenPosition z.1.2 z.1.1.1)+z.2^2/(2*QV)+P*z.1.2
def andersenMarginalPrinted (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (z : Phase n × ℝ) : ℝ :=
  Real.sqrt (β/(2*Real.pi*QV))*∫ pV, Real.exp (-β*andersenHamiltonian m U QV P (z,pV))
def andersenMarginal_corrected (m : Vec n) (U : Vec n → ℝ) (QV P β Z : ℝ)
    (z : Phase n × ℝ) : ℝ := andersenMarginalPrinted m U QV P β z/Z
theorem andersenGaussian_marginal (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (hQV : 0 < QV) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    andersenMarginalPrinted m U QV P β z =
      Real.exp (-β*((∑ i, z.1.2 i^2/(2*m i*Real.rpow z.2 (2/3 : ℝ)))+
        U (andersenPosition z.2 z.1.1)+P*z.2)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。
- [EXTRA] andersenMarginal_corrected本身仅为除以Z的函数定义；要解释为概率密度须另证明Z等于正确域上正有限配分积分。
- [EXTRA] `andersenMarginal_corrected`仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和$`V\gt 0`$域上可积，且Z为相同权重的正有限配分积分；任意$`Z\gt 0`$不足。
- 覆盖缺口：[EXTRA] `andersenMarginal_corrected`仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和$`V\gt 0`$域上可积，且Z为相同权重的正有限配分积分；任意$`Z\gt 0`$不足。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；相对归一NPT密度缺配分因子。
修正版：原送审Gaussian消元及除Z权重合理；正有限配分积分未保证，不宣称概率归一。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF401：边缘公式未写此前$`\rho_{NPT}`$定义中的$`Z_{NPT}^{-1}`$；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。；[ERRATUM?] 保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意$`Z\gt 0`$。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页401。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.andersenHamiltonian`：定义
- `MD.Ch08.andersenMarginalPrinted`：定义
- `MD.Ch08.andersenMarginal_corrected`：定义
- `MD.Ch08.andersenGaussian_marginal`：未证；原书疑误不证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-NHLPistonEquations

印刷页 381–382 / PDF页 402–403。

### 1. 原文陈述

> $`\dot q=M^{-1}p+\eta q`$, $`\dot p=F-\eta p-\xi p`$, $`\dot V=\eta V`$; $`d\xi=(h_T-\gamma_T\xi)dt+\sqrt{2k_B T\gamma_T/\mu_T}dW_T`$, $`d\eta=(h_P-\gamma_P\eta)dt+\sqrt{2k_B T\gamma_P/\mu_P}dW_P`$, with $`h_T=(p^{\mathsf T}M^{-1}p-N_d k_B T)/\mu_T`$ and $`h_P=(V\Pi-PV+k_B T)/\mu_P`$. (8.75)–(8.79).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev PistonState (n : ℕ) := Phase n × Vec 3
def pistonPressure (invm : Vec n) (U : Vec n × ℝ → ℝ) (q p : Vec n) (V : ℝ) : ℝ :=
  (kineticTwice invm p-dot q (gradient (fun x ↦ U (x,V)) q)-
    V*deriv (fun v ↦ U (q,v)) V)/V
def pistonDrift (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i+z.2 2*z.1.1 i,
    fun i ↦ -gradient (fun q ↦ U (q,z.2 0)) z.1.1 i-(z.2 2+z.2 1)*z.1.2 i),
   ![z.2 2*z.2 0,(kineticTwice invm z.1.2-n*θ)/QT-γT*z.2 1,
     (z.2 0*pistonPressure invm U z.1.1 z.1.2 (z.2 0)-P*z.2 0+θ)/QP-γP*z.2 2])
def pistonNoise (θ QT QP γT γP : ℝ) (j : Fin 2) : PistonState n :=
  ((0,0),if j=0 then ![0,Real.sqrt (2*θ*γT/QT),0] else ![0,0,Real.sqrt (2*θ*γP/QP)])
def isNHLPistonSolution (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (μ : Measure Ω) (W : ℝ → Ω → Vec 2) (X : ℝ → Ω → PistonState n)
    (x0 : PistonState n) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ 0 < QT ∧ 0 < QP ∧ 0 ≤ γT ∧ 0 ≤ γP ∧
  ContDiff ℝ 2 U ∧ 0 < x0.2 0 ∧ (∀ t, 0 ≤ t → ∀ᵐ sample ∂μ, 0 < (X t sample).2 0) ∧
  additiveSDE μ 2 W X x0 (pistonDrift invm U θ P QT QP γT γP) (pistonNoise θ QT QP γT γP)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际压力、反馈、漂移扩散和正体积NHL活塞积分解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`z.2=(V,\xi,\eta)`$，$`V\gt 0`$、热浴/活塞质量正、独立二维Wiener明确；所有辅助变量除V均为实数。
- 选择正体积域内的积分解类，不声明该类存在唯一或必然遍历；$`n=3N`$为物理情形。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页402–403。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.PistonState`：定义
- `MD.Ch08.pistonPressure`：定义
- `MD.Ch08.pistonDrift`：定义
- `MD.Ch08.pistonNoise`：定义
- `MD.Ch08.isNHLPistonSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonHamiltonianSubfield

印刷页 381 / PDF页 402。

### 1. 原文陈述

> $`\rho_1=\varphi_1(p^{\mathsf T}M^{-1}p/2+U(q))\psi(V,\xi,\eta)`$ is stated to be stationary for the Liouvillian of the printed vector field $`(p,-\nabla U,0,0,0)`$. [ERRATUM?] For general mass the Hamiltonian field should have first component $`M^{-1}p`$; the Lean stationarity target uses this corrected field.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonHamiltonianPart (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)
theorem pistonHamiltonianWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (φ : ℝ → ℝ) (ψ : Vec 3 → ℝ) (hU : ContDiff ℝ 2 U)
    (hφ : ContDiff ℝ 1 φ) (hψ : ContDiff ℝ 1 ψ) (z : PistonState n) :
    textbookDivergence (fun x : PistonState n ↦
      (φ (kineticTwice invm x.1.2/2+U (x.1.1,x.2 0))*ψ x.2) •
        pistonHamiltonianPart invm U x) z=0 := by
  sorry

/-- 原印Hamiltonian子场：第一分量为p，忠实保留其一般质量疑误。 -/
def pistonHamiltonianPartPrinted (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((z.1.2,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)

/-- 修正版第一分量为M⁻¹p；现有驻定目标已采用此场。 -/
def pistonHamiltonianPart_corrected (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n := pistonHamiltonianPart invm U z
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印p子场、$`M^{-1}p`$修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] invm:Fin n→ℝ表示固定对角逆质量系数；Lean全称允许任意实系数，不要求正性，散度恒等式仍成立。
- [EXTRA] $`U:(\mathrm{Vec}\,n\times\mathbb R)\to\mathbb R`$为$`C^2`$，$`\varphi:\mathbb R\to\mathbb R`$和$`\psi:\mathrm{Vec}\,3\to\mathbb R`$为$`C^1`$；U允许依赖作为冻结参数的V。
- [EXTRA] 状态为$`((q,p),(V,\xi,\eta))`$，后三坐标在子场下全为零。Lean仅陈述局部通量散度零，不要求权非负、归一或可积，也不证明全局流或边界性质。
- [ERRATUM?] 原印子场首分量p，仅单位质量等特殊情形与所印能量一致；修正版采用$`M^{-1}p`$。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；{"overall": "原印场的一般质量疑误判NEEDS_HUMAN；Printed定义忠实、修正场及其散度恒等式签名PASS。未依据sorry否定签名。", "objects_and_domains": "n为任意自然数；`Vec n=Fin n→ℝ`，`Phase n=Vec n×Vec n`，`PistonState n=Phase n×Vec 3`。z任意，无$`V\ge0`$限制；x.2 0是V，ξ、η为另外两冻结坐标。invm为常实对角系数；质量正性对恒等式不必要。", "declarations": [{"lean_decl": "MD.Ch08.pistonHamiltonianPart", "verdict": "PASS", "explanation": "场为$`((invm\cdot p,-\nabla_q U(q,V)),0)`$，梯度按标准坐标方向fderiv定义，后三分量为零。与一般对角质量的Hamiltonian修正一致，但不能叫原印逐字场。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianWeight_stationary", "verdict": "PASS", "explanation": "对任意invm、$`C^2`$的U、$`C^1`$的φ及ψ和任意z，全结论为$`\operatorname{div}([\varphi(H)\psi]F)(z)=0`$，其中$`H=\sum invm_i p_i^2/2+U(q,V)`$，div为完整状态空间上导数线性映射的trace。F自身散度为零，$`F\cdot\nabla H=\sum(U_{qi}invm_i p_i-invm_i p_i U_{qi})=0`$，ψ只依赖冻结坐标故沿场导数零。U依赖V不会引入额外通量项，因为V方向场分量恒为零。结论不要求质量正性或权可积，亦不推出概率归一化。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianPartPrinted", "verdict": "PASS", "explanation": "完整场$`((p,-\nabla_q U(q,V)),0)`$与原印$`(p,-\nabla U,0,0,0)`$逐分量一致；没有附带错误的驻定定理，故原印疑误不构成本定义忠实性的FAIL。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianPart_corrected", "verdict": "PASS", "explanation": "定义展开即pistonHamiltonianPart invm U z，明确把首分量修正为对角$`M^{-1}p`$，其余力及冻结坐标正确。"}]}
原文版：Printed的p场忠实性PASS；一般质量下原驻定声称疑误待导师。
修正版：$`M^{-1}p`$修正场及局部散度目标签名网站PASS；非概率平稳分布或全局保测流。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原页先给$`\dot q=M^{-1}p+\eta q`$，随后驻定子场却明确印为$`(p,-\nabla U,0,0,0)`$。对于一般质量及所印能量，二者不一致；不可将原印首分量静默改为$`M^{-1}p`$。；[EXTRA] Lean只陈述全实坐标空间上的局部加权通量散度为零；φ、ψ可取有符号光滑权，未要求非负、归一化或$`V\ge0`$上的可积性。因此不能解释为已构造概率平稳分布或全局保测流。；已目视核对原页PDF402：原印场为$`(p,-\nabla U,0,0,0)`$，一般质量的修正场为$`(M^{-1}p,-\nabla U,0,0,0)`$。原印p与本页$`\dot q=M^{-1}p+\eta q`$不一致，修正版仅给局部通量散度目标。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页402。

### 7. 状态与证明位置

- `MD.Ch08.pistonHamiltonianPart`：定义
- `MD.Ch08.pistonHamiltonianWeight_stationary`：未证；缺大型理论
- `MD.Ch08.pistonHamiltonianPartPrinted`：定义
- `MD.Ch08.pistonHamiltonianPart_corrected`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonThermostatWeightPrinted

印刷页 381 / PDF页 402。

### 1. 原文陈述

> The book prints $`\rho_2=\exp(-\beta[p^{\mathsf T}M^{-1}p+\mu_T\xi^2/2])\psi_2(q,\eta,V)`$ for $`\dot p=-\xi p`$, $`\dot\xi=(p^{\mathsf T}M^{-1}p-N_d k_B T)/\mu_T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonThermostatPart (invm : Vec n) (θ QT : ℝ) (z : PistonState n) : PistonState n :=
  ((0,fun i ↦ -z.2 1*z.1.2 i),![0,(kineticTwice invm z.1.2-n*θ)/QT,0])
def pistonRho2Printed (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2+QT*(z.2 1)^2/2))
def pistonRho2_corrected (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+QT*(z.2 1)^2/2))
theorem pistonRho2_stationary_corrected (invm : Vec n) (β QT : ℝ)
    (hm : ∀ i, 0 < invm i) (hβ : 0 < β) (hQT : 0 < QT) (z : PistonState n) :
    textbookDivergence (fun x ↦ pistonRho2_corrected invm β QT x •
      pistonThermostatPart invm β⁻¹ QT x) z=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/修正权重及$`\psi_2=1`$时的实际子场驻定目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅取$`\psi_2=1`$的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；原印动能缺1/2。
修正版：原送审恢复1/2的_corrected及局部驻定签名PASS，$`\psi_2=1`$。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF402：$`\rho_2`$动能项缺1/2；所印反馈仍为$`p^{\mathsf T}M^{-1}p-N_d k_B T`$。原印权重保留，工作修正采用标准动能的一半。；保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页402。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pistonThermostatPart`：定义
- `MD.Ch08.pistonRho2Printed`：定义
- `MD.Ch08.pistonRho2_corrected`：定义
- `MD.Ch08.pistonRho2_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonReducedPDE

印刷页 382 / PDF页 403。

### 1. 原文陈述

> $`-q\cdot\nabla_q\psi+p\cdot\nabla_p\psi-\psi-V\partial_V\psi+(\beta V\Pi-\beta PV+1)\psi=0`$, solved by $`\psi\propto\exp(-\beta(H+PV))`$. (8.74).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonReducedOperator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (ψ : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  -fderiv ℝ ψ z ((z.1.1,0),0)+fderiv ℝ ψ z ((0,z.1.2),0)-ψ z-
  z.2*fderiv ℝ ψ z ((0,0),1)+
    (β*z.2*pistonPressure invm U z.1.1 z.1.2 z.2-β*P*z.2+1)*ψ z
theorem pistonReduced_boltzmann (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    pistonReducedOperator invm U β P
      (fun x ↦ Real.exp (-β*(kineticTwice invm x.1.2/2+U (x.1.1,x.2)+P*x.2))) z=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 完整(8.74)及Boltzmann权代入目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。
- 覆盖缺口：只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页403。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pistonReducedOperator`：定义
- `MD.Ch08.pistonReduced_boltzmann`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonStationaryWeight

印刷页 382 / PDF页 403。

### 1. 原文陈述

> Adding the two independent OU thermostats to $`\xi,\eta`$ preserves the candidate weight $`\exp[-\beta(H+PV+\mu_T\xi^2/2+\mu_P\eta^2/2)]`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonWeight (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP : ℝ)
    (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+U (z.1.1,z.2 0)+P*z.2 0+
    QT*(z.2 1)^2/2+QP*(z.2 2)^2/2))
def pistonForward (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (ρ : PistonState n → ℝ) (z : PistonState n) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • pistonDrift invm U θ P QT QP γT γP x) z+
    (∑ j : Fin 2, fderiv ℝ (fun x ↦ fderiv ℝ ρ x (pistonNoise θ QT QP γT γP j))
      z (pistonNoise θ QT QP γT γP j))/2
theorem pistonWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (β P QT QP γT γP : ℝ) (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U)
    (hβ : 0 < β) (hQT : 0 < QT) (hQP : 0 < QP) (hγT : 0 ≤ γT) (hγP : 0 ≤ γP)
    (z : PistonState n) (hV : 0 < z.2 0) :
    pistonForward invm U β⁻¹ P QT QP γT γP (pistonWeight invm U β P QT QP) z=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 候选权重与实际局部前向算子的驻定目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述正V内的真实Fokker–Planck微分表达式为零；候选正权重并不自动可积/归一。
- 盒边界/体积边界的通量、Markov半群不变概率及唯一遍历性需要NPT理论，明确列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页403。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pistonWeight`：定义
- `MD.Ch08.pistonForward`：定义
- `MD.Ch08.pistonWeight_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.2-PistonIntegrator

印刷页 383 / PDF页 404。

### 1. 原文陈述

> The printed algorithm interleaves feedback half-updates, exponentially damped momentum kicks, exponential position/volume drifts, feedback recomputation and final independent OU steps. $`\psi(\alpha,t)=(e^{\alpha t}-1)/\alpha`$, extended by $`t`$ at $`\alpha=0`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def expIntegrated (a t : ℝ) : ℝ := if a=0 then t else (Real.exp (a*t)-1)/a
def pistonWrap (V : ℝ) (q : Vec n) : Vec n := fun i ↦
  volumeScale V*(q i/volumeScale V+1/2-(Int.floor (q i/volumeScale V+1/2) : ℝ)-1/2)
def pistonMomentumKick (U : Vec n × ℝ → ℝ) (h : ℝ) (z : PistonState n) : PistonState n :=
  ((z.1.1,fun i ↦ Real.exp (-(z.2 1+z.2 2)*h)*z.1.2 i-
    expIntegrated (-(z.2 1+z.2 2)) h*gradient (fun q ↦ U (q,z.2 0)) z.1.1 i),z.2)
def pistonFeedback (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP h : ℝ)
    (z : PistonState n) : PistonState n :=
  let f := pistonDrift invm U θ P QT QP 0 0 z
  (z.1,![z.2 0,z.2 1+h*f.2 1,z.2 2+h*f.2 2])
def pistonOU (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) : PistonState n :=
  (z.1,![z.2 0,Real.exp (-γT*h)*z.2 1+Real.sqrt ((1-Real.exp (-2*γT*h))/(β*QT))*R 0,
    Real.exp (-γP*h)*z.2 2+Real.sqrt ((1-Real.exp (-2*γP*h))/(β*QP))*R 1])
def pistonIntegrator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP γT γP h : ℝ)
    (R : Vec 2) (z : PistonState n) : PistonState n :=
  let a := pistonFeedback invm U β⁻¹ P QT QP (h/2) z
  let b := pistonMomentumKick U (h/2) a
  let q := pistonWrap (b.2 0) (fun i ↦ Real.exp (b.2 2*h)*b.1.1 i+
    expIntegrated (b.2 2) h*invm i*b.1.2 i)
  let c := pistonMomentumKick U (h/2) ((q,b.1.2),b.2)
  let V := Real.exp (c.2 2*h)*c.2 0
  let d : PistonState n := ((pistonWrap V c.1.1,c.1.2),![V,c.2 1,c.2 2])
  pistonOU β QT QP γT γP h R (pistonFeedback invm U β⁻¹ P QT QP (h/2) d)
theorem pistonOU_volume (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) :
    (pistonOU β QT QP γT γP h R z).2 0=z.2 0 := rfl
theorem pistonVolume_positive (V η h : ℝ) (hV : 0 < V) : 0 < Real.exp (η*h)*V :=
  mul_pos (Real.exp_pos _) hV
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 完整分步算法、周期映射及OU保持V和指数体积正性的短结论。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正β、QT、QP、质量、体积及$`h\ge0`$是物理有效域；R取独立标准二维正态且跨步独立，参照independentWiener/standardNormalSequence所列资格。
- 零指数分支按原页连续延拓；周期位置在每次q/V更新后按当前盒长映射。只定义完整算法，不证明二阶、可逆或不变分布精度。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页404。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.expIntegrated`：定义
- `MD.Ch08.pistonWrap`：定义
- `MD.Ch08.pistonMomentumKick`：定义
- `MD.Ch08.pistonFeedback`：定义
- `MD.Ch08.pistonOU`：定义
- `MD.Ch08.pistonIntegrator`：定义
- `MD.Ch08.pistonOU_volume`：已证
- `MD.Ch08.pistonVolume_positive`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.3-ParrinelloRahman

印刷页 385 / PDF页 406。

### 1. 原文陈述

> For cell matrix $`h=[a\ b\ c]`$, $`V=\det(h)=a\cdot(b\times c)`$, $`q_i=h\bar q_i`$, $`G=h^{\mathsf T}h`$, $`L=(1/2)\sum m_i\dot{\bar q}_i^{\mathsf T}G\dot{\bar q}_i-\bar U(\bar q)+(\mu/2)\operatorname{Tr}(\dot h^{\mathsf T}\dot h)-PV`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def cellVolume (h : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := Matrix.det h
def cellMetric (h : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ := h.transpose*h
def cellPosition (h : Matrix (Fin 3) (Fin 3) ℝ) (qbar : Vec 3) : Vec 3 := h *ᵥ qbar
def cross3 (a b : Vec 3) : Vec 3 := ![a 1*b 2-a 2*b 1,a 2*b 0-a 0*b 2,a 0*b 1-a 1*b 0]
theorem cellVolume_triple (h : Matrix (Fin 3) (Fin 3) ℝ) :
    cellVolume h=dot (fun i ↦ h i 0) (cross3 (fun i ↦ h i 1) (fun i ↦ h i 2)) := by
  simp [cellVolume,Matrix.det_fin_three,dot,Fin.sum_univ_succ,cross3]
  ring
def parrinelloRahmanLagrangian {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → Vec 3) → ℝ)
    (Q P : ℝ) (h hdot : Matrix (Fin 3) (Fin 3) ℝ) (qbar vbar : Fin N → Vec 3) : ℝ :=
  (∑ i, m i/2*dot (vbar i) (cellMetric h *ᵥ vbar i))-U qbar+
    Q/2*Matrix.trace (hdot.transpose*hdot)-P*cellVolume h
def cellQualification {N : ℕ} (m : Fin N → ℝ) (Q : ℝ)
    (h : Matrix (Fin 3) (Fin 3) ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < Q ∧ 0 < Matrix.det h
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 各向异性盒的体积/位置/度量/Lagrangian及标量三重积恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 选定正定向非退化盒det(h)>0及正质量；U为缩放坐标势，必要时由实际h映射后势复合而得。
- 拉氏方程、与热浴耦合和防止盒塌缩均未在原页给完整条件，列覆盖缺口，不把内部结构的经验稳定性当定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页406。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.cellVolume`：定义
- `MD.Ch08.cellMetric`：定义
- `MD.Ch08.cellPosition`：定义
- `MD.Ch08.cross3`：定义
- `MD.Ch08.cellVolume_triple`：已证
- `MD.Ch08.parrinelloRahmanLagrangian`：定义
- `MD.Ch08.cellQualification`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9-TotalMomentum

印刷页 386 / PDF页 407。

### 1. 原文陈述

> With central conservative forces $`\sum_iF_i=0`$, Nosé dynamics gives $`d p_{tot}/dt=-\xi p_{tot}`$. Zero total momentum is formally invariant.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev ParticleConfig (N d : ℕ) := Fin N → Vec d
abbrev ParticlePhase (N d : ℕ) := ParticleConfig N d × ParticleConfig N d
def totalMomentum {N d : ℕ} (p : ParticleConfig N d) : Vec d := ∑ i, p i
theorem noseTotalForce {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) :
    totalMomentum (fun i ↦ F i-ξ • p i) = -ξ • totalMomentum p := by
  simp only [totalMomentum,Finset.sum_sub_distrib,← Finset.smul_sum] at *
  rw [hF]; simp
theorem noseTotalForce_zero {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) (hp : totalMomentum p=0) :
    totalMomentum (fun i ↦ F i-ξ • p i)=0 := by rw [noseTotalForce F p ξ hF,hp,smul_zero]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 总动量定义和Nosé瞬时总力/零总动量时总力为零。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只证明瞬时总力恒等式；沿连续轨道的零动量不变需要ODE唯一性，有限精度“飞冰块”属经验现象，列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页407。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.ParticleConfig`：定义
- `MD.Ch08.ParticlePhase`：定义
- `MD.Ch08.totalMomentum`：定义
- `MD.Ch08.noseTotalForce`：已证
- `MD.Ch08.noseTotalForce_zero`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDSoftPotential

印刷页 387–388 / PDF页 408–409。

### 1. 原文陈述

> $`r_{ij}=\lvert q_i-q_j\rvert`$, $`e_{ij}=(q_i-q_j)/r_{ij}`$. $`F^c_{ij}=\alpha(1-r_{ij}/r_c)e_{ij}`$ for $`r_{ij}\lt r_c`$, zero otherwise; $`\varphi_{DPD}=(\alpha r_c/2)(1-r/r_c)^2`$ below cutoff, $`U=\sum_{i\lt j}\varphi(r_{ij})`$. (8.80)–(8.84).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairDistance {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : ℝ :=
  Real.sqrt (dot (q i-q j) (q i-q j))
def pairDirection {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (pairDistance q i j)⁻¹ • (q i-q j)
def dpdSoftPotential (α rc r : ℝ) : ℝ := if r < rc then α*rc/2*(1-r/rc)^2 else 0
def dpdPairConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  if pairDistance q i j < rc then (α*(1-pairDistance q i j/rc)) • pairDirection q i j else 0
def dpdPotential {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), dpdSoftPotential α rc (pairDistance q i j)
def dpdConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairConservative α rc q i j
def particleGradient {N d : ℕ} (U : ParticleConfig N d → ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i a ↦ fderiv ℝ U q (Pi.single i (Pi.single a 1))
theorem dpdConservative_gradient {N d : ℕ} (α rc : ℝ) (hα : 0 ≤ α) (hrc : 0 < rc)
    (q : ParticleConfig N d) (hnocoll : ∀ i j, i ≠ j → 0 < pairDistance q i j)
    (hcut : ∀ i j, i ≠ j → pairDistance q i j ≠ rc) :
    dpdConservative α rc q = -particleGradient (dpdPotential α rc) q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 软势、保守成对力/总力与光滑有效域的梯度目标；完整SDE见后条。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- d维Euclidean距离由坐标平方和开方，避免Pi最大范数；只在非碰撞且离开截断接缝的有效域声明梯度关系。N、d为物理正整数，$`m_i\gt 0`$在动力学资格另列。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页408–409。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pairDistance`：定义
- `MD.Ch08.pairDirection`：定义
- `MD.Ch08.dpdSoftPotential`：定义
- `MD.Ch08.dpdPairConservative`：定义
- `MD.Ch08.dpdPotential`：定义
- `MD.Ch08.dpdConservative`：定义
- `MD.Ch08.particleGradient`：定义
- `MD.Ch08.dpdConservative_gradient`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDPairForces

印刷页 388 / PDF页 409。

### 1. 原文陈述

> $`F^D_{ij}=-\gamma\omega^D(r_{ij})(e_{ij}\cdot v_{ij})e_{ij}`$, $`F^R_{ij}=\sigma\omega^R(r_{ij})\theta_{ij}e_{ij}`$, $`\omega^R(r)=1-r/r_c`$ below cutoff. $`v_{ij}=p_i/m_i-p_j/m_j`$. (8.85)–(8.87).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdWeightR (rc r : ℝ) : ℝ := if r < rc then 1-r/rc else 0
def relativeVelocity {N d : ℕ} (m : Fin N → ℝ) (p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (m i)⁻¹ • p i-(m j)⁻¹ • p j
def dpdPairDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (-γ*wD (pairDistance q i j)*dot (pairDirection q i j) (relativeVelocity m p i j)) • pairDirection q i j
def dpdPairRandom {N d : ℕ} (σ : ℝ) (wR : ℝ → ℝ) (q : ParticleConfig N d)
    (i j : Fin N) (R : ℝ) : Vec d := (σ*wR (pairDistance q i j)*R) • pairDirection q i j
def dpdDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairDissipative m γ wD q p i j
def pairImpulseVector {N d : ℕ} (i j : Fin N) (v : Vec d) : ParticleConfig N d :=
  Pi.single i v-Pi.single j v
def dpdNoise {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ) (wR : ℝ → ℝ)
    (q : ParticleConfig N d) (k : Fin K) : ParticlePhase N d :=
  (0,pairImpulseVector (pairs k).1 (pairs k).2
    ((σ*wR (pairDistance q (pairs k).1 (pairs k).2)) • pairDirection q (pairs k).1 (pairs k).2))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 全部成对/总耗散力、软随机权与成对守恒扩散方向。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 白噪声$`\theta_{ij}`$不作为逐点函数使用；随机力的实际意义是下一条无序对独立Wiener驱动、双方相反的扩散向量。总化$`r=0`$只作辅助，在动力学中要求非碰撞。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页409。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdWeightR`：定义
- `MD.Ch08.relativeVelocity`：定义
- `MD.Ch08.dpdPairDissipative`：定义
- `MD.Ch08.dpdPairRandom`：定义
- `MD.Ch08.dpdDissipative`：定义
- `MD.Ch08.pairImpulseVector`：定义
- `MD.Ch08.dpdNoise`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDPairWiener

印刷页 388–389 / PDF页 409–410。

### 1. 原文陈述

> $`\theta_{ij}=\theta_{ji}`$; $`E\theta_{ij}=0`$ and $`E[\theta_{ij}(t)\theta_{kl}(t')]=(\delta_{ik}\delta_{jl}+\delta_{il}\delta_{jk})\delta(t-t')`$. Distinct unordered pairs are independent. (8.88).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairEnumeration {N K : ℕ} (pairs : Fin K → Fin N × Fin N) : Prop :=
  (∀ k, (pairs k).1 < (pairs k).2) ∧ Function.Injective pairs ∧
  ∀ i j, i < j → ∃ k, pairs k=(i,j)
def pairNoiseIncrement {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) (sample : Ω) : ℝ :=
  ∑ k, if pairs k=(i,j) ∨ pairs k=(j,i) then W t sample k-W s sample k else 0
theorem pairNoiseIncrement_symmetric {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) :
    pairNoiseIncrement pairs W s t i j=pairNoiseIncrement pairs W s t j i := by
  sorry
theorem pairNoiseIncrement_covariance {N K : ℕ} (P : Measure Ω)
    (pairs : Fin K → Fin N × Fin N) (he : pairEnumeration pairs)
    (W : ℝ → Ω → Vec K) (hW : independentWiener P K W)
    (s t : ℝ) (hs : 0 ≤ s) (hst : s ≤ t) (i j k l : Fin N) (hij : i ≠ j) (hkl : k ≠ l) :
    (∫ sample, pairNoiseIncrement pairs W s t i j sample*pairNoiseIncrement pairs W s t k l sample ∂P)=
      if (i=k ∧ j=l) ∨ (i=l ∧ j=k) then t-s else 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 对称噪声增量和对应所印δ协方差的积分版本。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只对无序对使用独立标准Wiener；$`W_{ij}=W_{ji}`$由同一坐标实现，不能把有序对全部设独立。Dirac白噪声公式通过有限时间增量协方差表达。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页409–410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pairEnumeration`：定义
- `MD.Ch08.pairNoiseIncrement`：定义
- `MD.Ch08.pairNoiseIncrement_symmetric`：未证；时间盒止
- `MD.Ch08.pairNoiseIncrement_covariance`：未证；时间盒止

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDIntegralSystem

印刷页 389 / PDF页 410。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$, $`dp=-\nabla U\,dt-\Delta(q)p\,dt+\Sigma(q)dW`$. (8.90).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def strictItoIntegral8 (P : Measure Ω) (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ k, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T k) 2 P) ∧ MemLp Y 2 P ∧
  Tendsto (fun k ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T k sample-Y sample)^2 ∂P)
    atTop (𝓝 0)
def multiplicativeSDE8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (P : Measure Ω) (r : ℕ)
    (W : ℝ → Ω → Vec r) (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : E → Fin r → E) : Prop :=
  independentWiener P r W ∧ Measurable (Function.uncurry X) ∧ (∀ j, Measurable (fun x ↦ B x j)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ T, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
    ∀ ell : E →L[ℝ] ℝ, ∃ Y : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral8 P (fun s sample ↦ W s sample j)
        (fun s sample ↦ ell (B (X s sample) j)) T (Y j)) ∧
      ∀ᵐ sample ∂P, ell (X T sample-x0-(∫ s in (0 : ℝ)..T, a (X s sample)))=∑ j, Y j sample
def dpdDrift {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),dpdConservative α rc z.1+dpdDissipative m γ wD z.1 z.2)
def isDPDSolution {N d K : ℕ} (m : Fin N → ℝ) (α rc γ σ θ : ℝ) (wD wR : ℝ → ℝ)
    (pairs : Fin K → Fin N × Fin N) (P : Measure Ω) (W : ℝ → Ω → Vec K)
    (X : ℝ → Ω → ParticlePhase N d) (x0 : ParticlePhase N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 ≤ α ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ r, wD r=(wR r)^2) ∧ σ^2=2*γ*θ ∧ pairEnumeration pairs ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1 i j) ∧
  multiplicativeSDE8 P K W X x0 (dpdDrift m α rc γ wD)
    (fun z ↦ dpdNoise pairs σ wR z.1)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 配置依赖扩散的真实积分解规格及正质量/涨落耗散/无序噪声资格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 实际多维独立Wiener、共同自然历史适应、联合可测、路径连续、漂移可积、所有网格左和及积分代表$`L^2`$均明示。
- 选择强$`L^2`$、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。
- 覆盖缺口：选择强$`L^2`$、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.strictItoIntegral8`：定义
- `MD.Ch08.multiplicativeSDE8`：定义
- `MD.Ch08.dpdDrift`：定义
- `MD.Ch08.isDPDSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDCanonicalLeaf

印刷页 389 / PDF页 410。

### 1. 原文陈述

> $`\omega^D=(\omega^R)^2`$, $`\sigma^2=2\gamma k_B T`$. The canonical density is restricted to fixed total momentum $`\pi`$ by $`\delta(\sum p-\pi)`$. (8.89).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdFluctuationDissipation (γ σ θ : ℝ) (wD wR : ℝ → ℝ) : Prop :=
  0 ≤ γ ∧ 0 < θ ∧ σ^2=2*γ*θ ∧ ∀ r, wD r=(wR r)^2
def momentumLeaf {N d : ℕ} (π : Vec d) : Set (ParticlePhase N d) :=
  {z | totalMomentum z.2=π}
def particleHamiltonian {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (z : ParticlePhase N d) : ℝ := (∑ i, dot (z.2 i) (z.2 i)/(2*m i))+U z.1
def momentumCanonical {N d : ℕ} (ν : Measure (ParticlePhase N d)) (m : Fin N → ℝ)
    (U : ParticleConfig N d → ℝ) (β : ℝ) : Measure (ParticlePhase N d) :=
  ν.withDensity (fun z ↦ ENNReal.ofReal (Real.exp (-β*particleHamiltonian m U z)/
    (∫ x, Real.exp (-β*particleHamiltonian m U x) ∂ν)))
def momentumCanonicalQualification {N d : ℕ} (ν : Measure (ParticlePhase N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ν (momentumLeaf π)ᶜ=0 ∧
  Integrable (fun z ↦ Real.exp (-β*particleHamiltonian m U z)) ν ∧
  (0 < ∫ z, Real.exp (-β*particleHamiltonian m U z) ∂ν) ∧
  IsProbabilityMeasure (momentumCanonical ν m U β)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 涨落耗散资格、动量约束叶及其可归一canonical测度定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Dirac乘积解释为指定动量叶上的参考测度，未伪造Lebesgue密度；参考测度需另指定几何/周期体积。
- 只是权重与概率资格目标；DPD保持该测度、流体力学保持及高密度一维遍历性的大型定理均列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdFluctuationDissipation`：定义
- `MD.Ch08.momentumLeaf`：定义
- `MD.Ch08.particleHamiltonian`：定义
- `MD.Ch08.momentumCanonical`：定义
- `MD.Ch08.momentumCanonicalQualification`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

