上一部分：无 / [目录](../../CH08_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第8章逐条审阅材料

第8章最终收口：正文103条；最新网站整体PASS 76条、NEEDS_HUMAN 27条、FAIL 0条。复审10条原始结论为2 PASS / 0 FAIL / 8 NEEDS_HUMAN。
修正版、原印忠实性、原书疑误及证明完成情况分列。网站认可陈述不等于证明完成；NP的npField仍有原印指代限定。

## MD-8.1-CanonicalCorrelation

印刷页 329–330 / PDF页 350–351。

### 1. 原文陈述

> $`Av_\beta(\varphi)=\int\varphi\rho_\beta/\int\rho_\beta`$, $`\rho_\beta=\exp(-\beta H)`$; $`C_\beta(\tau)=\int A(z)\cdot B(F^H_\tau(z))\rho_\beta\,d\omega / \int A(z)\cdot B(z)\rho_\beta\,d\omega`$. Thus $`C(0)=1`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev Vec (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := Vec n × Vec n
def dot (v w : Vec n) : ℝ := ∑ i, v i * w i
def gradient (U : Vec n → ℝ) (q : Vec n) : Vec n := fun i ↦ fderiv ℝ U q (Pi.single i 1)
def gibbsWeight {E : Type*} (H : E → ℝ) (β : ℝ) (z : E) : ℝ := Real.exp (-β * H z)
def canonicalAverage {E : Type*} [MeasurableSpace E] (μ : Measure E)
    (ρ g : E → ℝ) : ℝ := (∫ z, g z * ρ z ∂μ) / ∫ z, ρ z ∂μ
def probabilityDensity {E : Type*} [MeasurableSpace E] (μ : Measure E) (ρ : E → ℝ) : Prop :=
  (∀ z, 0 ≤ ρ z) ∧ Integrable ρ μ ∧ ∫ z, ρ z ∂μ = 1
def correlation {E : Type*} [MeasurableSpace E] (μ : Measure E) (ρ A B : E → ℝ)
    (flow : ℝ → E → E) (t : ℝ) : ℝ :=
  (∫ z, A z * B (flow t z) * ρ z ∂μ) / ∫ z, A z * B z * ρ z ∂μ
theorem correlation_zero {E : Type*} [MeasurableSpace E] (μ : Measure E)
    (ρ A B : E → ℝ) (flow : ℝ → E → E) (h0 : flow 0 = id)
    (hden : (∫ z, A z * B z * ρ z ∂μ) ≠ 0) : correlation μ ρ A B flow 0 = 1 := by
  simp [correlation, h0, hden]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 规范平均、标量相关函数及零时归一；混合时的大时间极限定性说明另列。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 相关分母非零才有C(0)=1；向量观测的点积由标量乘积表示，其余分量情形未展开。
- [EXTRA/范围说明] 无需修改签名；将flow 0=id及分母非零也显式列入[EXTRA]，不要把标量特例说成已覆盖任意向量观测。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页350–351。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.Vec`：定义
- `MD.Ch08.Phase`：定义
- `MD.Ch08.dot`：定义
- `MD.Ch08.gradient`：定义
- `MD.Ch08.gibbsWeight`：定义
- `MD.Ch08.canonicalAverage`：定义
- `MD.Ch08.probabilityDensity`：定义
- `MD.Ch08.correlation`：定义
- `MD.Ch08.correlation_zero`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1-HamiltonianStationary

印刷页 330 / PDF页 351。

### 1. 原文陈述

> The Liouvillian satisfies $`L\varphi(H)=0`$; $`L`$ is skew-adjoint. Hence any density which is a function of $`H`$ will be preserved, including $`\exp(-\beta H)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def hamiltonianField (invm : Vec n) (U : Vec n → ℝ) (z : Phase n) : Phase n :=
  (fun i ↦ invm i * z.2 i, fun i ↦ - gradient U z.1 i)
theorem hamiltonianGibbsStationary (H : SymplecticCoordinates n → ℝ)
    (β : ℝ) (hH : ContDiff ℝ 2 H) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H)
      (textbookHamiltonianGibbsWeight H β) := by
  exact textbookHamiltonianGibbsWeight_stationary hH β
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 光滑Hamiltonian Gibbs权重的Liouville驻定方程；其余三项列覆盖缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只桥接光滑Hamiltonian的Gibbs权重驻定方程；一般$`\varphi(H)`$、算子偏斜伴随及流的保测性未由本条覆盖。
- [EXTRA/范围说明] 保留有限范围说明；若以后声称完整覆盖原文，应另列一般$`\varphi(H)`$、形式伴随及流不变性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页351。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.hamiltonianField`：定义
- `MD.Ch08.hamiltonianGibbsStationary`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1-ExtendedDensity

印刷页 331 / PDF页 352。

### 1. 原文陈述

> $`\tilde\rho(q,p,\xi)=\rho_\beta(q,p)\hat\rho(\xi)`$. Then $`\int g(q,p)\tilde\rho \propto \int g(q,p)\rho_\beta`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def extendedDensity {E B : Type*} (ρ : E → ℝ) (a : B → ℝ) (z : E × B) : ℝ := ρ z.1 * a z.2
theorem extendedAverage {E B : Type*} [MeasurableSpace E] [MeasurableSpace B]
    (μ : Measure E) (ν : Measure B) [SFinite μ] [SFinite ν]
    (ρ g : E → ℝ) (a : B → ℝ) (ha : ∫ y, a y ∂ν = 1)
    (hi : Integrable (fun z : E × B ↦ g z.1 * extendedDensity ρ a z) (μ.prod ν)) :
    (∫ z, g z.1 * extendedDensity ρ a z ∂μ.prod ν) = ∫ x, g x * ρ x ∂μ := by
  calc
    _ = (∫ x, g x * ρ x ∂μ) * ∫ y, a y ∂ν := by
      simpa only [extendedDensity, mul_assoc] using
        (integral_prod_mul (μ:=μ) (ν:=ν) (fun x ↦ g x * ρ x) a)
    _ = _ := by rw [ha, mul_one]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 乘积权定义及辅助因子积分为1时的边缘积分等式；不额外证明概率正性或一般流不变性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 辅助密度归一、乘积积分可积；使用有限/σ有限测度条件。
- [EXTRA/范围说明] 保留[EXTRA]辅助归一、可积、SFinite条件；不要据此声称已证明遍历性或采样正确。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页352。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.extendedDensity`：定义
- `MD.Ch08.extendedAverage`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.1-NoseHoover

印刷页 331 / PDF页 352。

### 1. 原文陈述

> $`\dot q=M^{-1}p`$, $`\dot p=-\nabla U(q)-\xi p`$, $`\mu\dot\xi=p^{\mathsf T}M^{-1}p-N_d\beta^{-1}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def thermostatParameters (invm : Vec n) (β Q : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q
def kineticTwice (invm p : Vec n) : ℝ := ∑ i, invm i * p i ^ 2
def nhField (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ invm i * z.1.2 i, fun i ↦ -gradient U z.1.1 i - z.2 * z.1.2 i),
   (kineticTwice invm z.1.2 - (n : ℝ)/β)/Q)
def isNHSolution (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (z : ℝ → Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ ∀ t, HasDerivAt z (nhField invm U β Q (z t)) t
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 正参数资格、动能平方和、NH实际向量场及全实时间ODE规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- μ记为Q且$`Q\gt 0`$，$`\beta\gt 0`$，正质量，热浴变量$`\xi\in\mathbb R`$；总函数nhField配合资格谓词使用。
- [EXTRA/范围说明] 补充[EXTRA]采用对角质量、$`C^1`$经典解及全实时间解规格；局部解应用需另作区间版本。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页352。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.thermostatParameters`：定义
- `MD.Ch08.kineticTwice`：定义
- `MD.Ch08.nhField`：定义
- `MD.Ch08.isNHSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.1-NHDensitySplit

印刷页 332 / PDF页 353。

### 1. 原文陈述

> $`\tilde\rho=\rho_\beta\exp(-\beta\mu\xi^2/2)`$; $`f=f_1+f_2`$, $`L_f^\dagger=L_{f_1}^\dagger+L_{f_2}^\dagger`$; $`f_2`$ preserves $`\tilde\rho`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhWeight (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β * (kineticTwice invm z.1.2 / 2 + U z.1.1 + Q*z.2^2/2))
def nhBathField (invm : Vec n) (β Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((0, fun i ↦ -z.2 * z.1.2 i), (kineticTwice invm z.1.2 - (n : ℝ)/β)/Q)
theorem nhField_split (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q z = (hamiltonianField invm U z.1, (0 : ℝ)) + nhBathField invm β Q z := by
  ext <;> simp [nhField, hamiltonianField, nhBathField, sub_eq_add_neg]
theorem nhWeight_stationary (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhField invm U β Q) (nhWeight invm U β Q) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 权重、分裂及完整场驻定；伴随算子分裂可由散度线性导出但未另作声明。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 指数为未归一权重；若称概率密度还要求有限正配分积分并归一化。
- [EXTRA/范围说明] 可保留现有范围；把热浴单独驻定未单列也写入覆盖缺口。权重未归一。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页353。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhWeight`：定义
- `MD.Ch08.nhBathField`：定义
- `MD.Ch08.nhField_split`：已证
- `MD.Ch08.nhWeight_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.1-NHFirstIntegralPrinted

印刷页 333 / PDF页 354。

### 1. 原文陈述

> $`ds/dt=\xi`$. $`I_{NH}=H+\mu\xi^2/2+N_d\beta^{-1}\ln s`$ is conserved.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhIntegral (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) (s : ℝ) : ℝ :=
  kineticTwice invm z.1.2 / 2 + U z.1.1 + Q*z.2^2/2 + (n : ℝ)/β*Real.log s
theorem nhIntegralPrinted (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U)
    (z : ℝ → Phase n × ℝ) (s : ℝ → ℝ) (hz : isNHSolution invm U β Q z)
    (hs : ∀ t, HasDerivAt s (z t).2 t) (hpos : ∀ t, 0 < s t) :
    ∀ t, HasDerivAt (fun r ↦ nhIntegral invm U β Q (z r) (s r)) 0 t := by
  sorry
theorem nhIntegral_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U)
    (z : ℝ → Phase n × ℝ) (s : ℝ → ℝ) (hz : isNHSolution invm U β Q z)
    (hs : ∀ t, HasDerivAt s (s t * (z t).2) t) (hpos : ∀ t, 0 < s t) :
    ∀ t, HasDerivAt (fun r ↦ nhIntegral invm U β Q (z r) (s r)) 0 t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 第一积分候选、原印s导数与修正s导数各自对应的沿解零导数目标；原印版不证。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`s\gt 0`$；原文版不证明，修正版另列；两版均保留原文H形式。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：原印忠实性PASS；$`s'=\xi`$与log s守恒不相容，数学真值待导师。
修正版：原送审$`s'=s\xi`$的_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF354：上行$`ds/dt=\xi`$，与(8.8)的$`\ln s`$不相容；改为$`ds/dt=s\xi`$（亦见PDF356和Exercise2）。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页354。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhIntegral`：定义
- `MD.Ch08.nhIntegralPrinted`：未证；原书疑误不证
- `MD.Ch08.nhIntegral_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2-NHReversal

印刷页 333 / PDF页 354。

### 1. 原文陈述

> Nosé-Hoover is time-reversible: changing the sign of $`p`$ and $`\xi`$ is equivalent to reversing time.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhReversal (z : Phase n × ℝ) : Phase n × ℝ := ((z.1.1, -z.1.2), -z.2)
theorem nhReversal_involutive : Function.Involutive (nhReversal (n:=n)) := by
  intro z; ext <;> simp [nhReversal]
theorem nhReversal_field (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q (nhReversal z) =
    ((fun i ↦ -(nhField invm U β Q z).1.1 i, (nhField invm U β Q z).1.2), (nhField invm U β Q z).2) := by
  ext <;> simp [nhField, nhReversal, kineticTwice] <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 反演为对合及向量场反演等式；不另称一般ODE流的全局反演定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页354。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhReversal`：定义
- `MD.Ch08.nhReversal_involutive`：已证
- `MD.Ch08.nhReversal_field`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2-NHTimestep

印刷页 333 / PDF页 354。

### 1. 原文陈述

> Nosé-Hoover Timestep Map: drift($`h/2`$), damped force($`h/2`$), ξ-update($`h`$), damped force($`h/2`$), drift($`h/2`$). $`c(t,\xi)=(1-e^{-t\xi})/\xi=t-t^2\xi/2+\cdots`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dampedCoefficient (t ξ : ℝ) : ℝ := if ξ = 0 then t else (1-Real.exp (-t*ξ))/ξ
def nhDrift (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i + h*invm i*z.1.2 i, z.1.2), z.2)
def nhKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i - dampedCoefficient h z.2*gradient U z.1.1 i), z.2)
def nhFeedback (invm : Vec n) (β Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2 + h/Q*(kineticTwice invm z.1.2 - (n : ℝ)/β))
def nhStep (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  nhDrift invm (h/2) ∘ nhKick U (h/2) ∘ nhFeedback invm β Q h ∘ nhKick U (h/2) ∘ nhDrift invm (h/2)
theorem dampedCoefficient_zero (t : ℝ) : dampedCoefficient t 0 = t := by simp [dampedCoefficient]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 五段单步算法与c的可去奇点延拓；Taylor展开及二阶收敛列覆盖缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- c在$`\xi=0`$处取连续延拓t；系数Taylor级数与二阶全局误差未由单步定义证明。
- [EXTRA/范围说明] 保留零点连续延拓[EXTRA]及Taylor/收敛阶覆盖缺口；有效物理域仍是正质量、β,Q。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页354。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dampedCoefficient`：定义
- `MD.Ch08.nhDrift`：定义
- `MD.Ch08.nhKick`：定义
- `MD.Ch08.nhFeedback`：定义
- `MD.Ch08.nhStep`：定义
- `MD.Ch08.dampedCoefficient_zero`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2-NHTimestepReversible

印刷页 333 / PDF页 354。

### 1. 原文陈述

> $`R\circ G_h\circ R=G_h^{-1}`$, $`R(q,p,\xi)=(q,-p,-\xi)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nhStep_reversible (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    nhReversal ∘ nhStep invm U β Q h ∘ nhReversal = nhStep invm U β Q (-h) := by
  sorry
theorem nhStep_inverse (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    Function.LeftInverse (nhStep invm U β Q (-h)) (nhStep invm U β Q h) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 五段单步的反演等式及负步长左逆两个目标；未建立误差阶数。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 逆映射以负步长映射及LeftInverse表达；不假设算法可逆作为结论的前提。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页354。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhStep_reversible`：未证；缺大型理论
- `MD.Ch08.nhStep_inverse`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2.1-NoseHamiltoniansPrinted

印刷页 334 / PDF页 355。

### 1. 原文陈述

> $`H_N=\tilde p^{\mathsf T}M^{-1}\tilde p/(2s^2)+\pi^2/(2\mu)+U(q)+(N_d+1)k_B T\ln s`$; $`H_{NP}=s[H_N-E_N]=s[\tilde p^{\mathsf T}M^{-1}\tilde p/(2s^2)+\pi^2/(2\mu)+U(q)+N_d k_B T\ln s-E_N]`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def noseHamiltonian (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (q p : Vec n) (s π : ℝ) : ℝ :=
  kineticTwice invm p / (2*s^2) + π^2/(2*Q) + U q + ((n : ℝ)+1)/β*Real.log s
def npHamiltonian (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (q p : Vec n) (s π : ℝ) : ℝ :=
  s*(kineticTwice invm p/(2*s^2) + π^2/(2*Q) + U q + (n : ℝ)/β*Real.log s - EN)
theorem nosePoincarePrinted (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (hp : thermostatParameters invm β Q) (q p : Vec n) (s π : ℝ) (hs : 0 < s) :
    npHamiltonian invm U β Q EN q p s π = s*(noseHamiltonian invm U β Q q p s π-EN) := by
  sorry
theorem nosePoincare_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (q p : Vec n) (s π : ℝ) :
    npHamiltonian invm U β Q EN q p s π = s*(noseHamiltonian invm U β Q q p s π-Real.log s/β-EN) := by
  unfold npHamiltonian noseHamiltonian
  ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 两个原印Hamiltonian定义、所印等式目标及减去对数差项后的代数修正。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 物理定义域$`s\gt 0`$、β,Q及质量正；总函数在此域外不作物理解释。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：两个原印$`H_N`$的对数系数不一致；Printed忠实性PASS。
修正版：原送审显式减log s/β的代数修正版PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF355：$`H_N`$先用$`(N_d+1)`$，(8.9)展开却用$`N_d`$；同名$`H_N`$等号不一致。工作修正显式减去$`\beta^{-1}\ln s`$。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页355。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.noseHamiltonian`：定义
- `MD.Ch08.npHamiltonian`：定义
- `MD.Ch08.nosePoincarePrinted`：未证；原书疑误不证
- `MD.Ch08.nosePoincare_corrected`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2.1-NPEquations

印刷页 334 / PDF页 355。

### 1. 原文陈述

> $`\dot q=M^{-1}\tilde p/s`$, $`\dot{\tilde p}=sF`$, $`\dot s=sp_s/\mu`$, $`\dot p_s=\tilde p^{\mathsf T}M^{-1}\tilde p/s^2-N_d k_B T-\Delta H_N`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
/- 修正版采用(8.9)展开中的n/β版本，区别于前文(n+1)/β的同名H_N。 -/
def npDeltaN_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : ℝ :=
  kineticTwice invm z.1.2/(2*z.2.1^2) + z.2.2^2/(2*Q) + U z.1.1 +
    (n : ℝ)/β*Real.log z.2.1 - EN

def npValidDomain (invm : Vec n) (β Q : ℝ) (z : Phase n × (ℝ × ℝ)) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q ∧ 0 < z.2.1

def npField (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : Phase n × (ℝ × ℝ) :=
  let s := z.2.1
  let π := z.2.2
  let delta := npDeltaN_corrected invm U β Q EN z
  ((fun i ↦ invm i*z.1.2 i/s, fun i ↦ -s*gradient U z.1.1 i),
   (s*π/Q, kineticTwice invm z.1.2/s^2-(n : ℝ)/β-delta))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 正对角逆质量、$`N_d=n`$下的NP四漂移分量；$`n/\beta`$版命名能量差修正；有效域另列。未绑定初始能量、未证明Hamilton梯度关系。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`N_d=n`$，$`\beta^{-1}=k_B T`$，$`Q=\mu`$，状态$`z=((q,\tilde p),(s,p_s))`$。
- [EXTRA] npValidDomain单列所有$`invm_i\gt 0`$及$`\beta,Q,s\gt 0`$；npField自身为总函数，未把该资格作为参数或合取条件。
- [ERRATUM?] `npDeltaN_corrected`选择(8.9)展开中的$`n/\beta`$版本；与上方原印$`(n+1)/\beta`$版$`H_N`$区分。应用时EN应取该n版能量在初值处的值；声明并未绑定初值。
- gradient用fderiv定义，未假设U可微；欲解释为经典力场须另加适当可微性。未证明Hamilton方程。
- [EXTRA] 使用npField作为经典NP方程必须另带`npValidDomain invm β Q z`、U可微及$`EN=H_N^{(n)}(z_0)`$；这些条件没有被npField总函数自动强制。原页$`\Delta H_N`$指代冲突未消除。
- 覆盖缺口：正对角逆质量、$`N_d=n`$下的NP四漂移分量；$`n/\beta`$版命名能量差修正；有效域另列。未绑定初始能量、未证明Hamilton梯度关系。
- 覆盖缺口：[ERRATUM?] `npDeltaN_corrected`选择(8.9)展开中的$`n/\beta`$版本；与上方原印$`(n+1)/\beta`$版$`H_N`$区分。应用时EN应取该n版能量在初值处的值；声明并未绑定初值。
- 覆盖缺口：gradient用fderiv定义，未假设U可微；欲解释为经典力场须另加适当可微性。未证明Hamilton方程。
- 覆盖缺口：[EXTRA] 使用npField作为经典NP方程必须另带`npValidDomain invm β Q z`、U可微及$`EN=H_N^{(n)}(z_0)`$；这些条件没有被npField总函数自动强制。原页$`\Delta H_N`$指代冲突未消除。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；逐一展开`Vec=Fin n→ℝ`、`Phase=Vec n×Vec n`、gradient与kineticTwice。npDeltaN_corrected依次为$`\tilde p^{\mathsf T}\operatorname{diag}(invm)\tilde p/(2s^2)`$、$`p_s^2/(2Q)`$、$`U(q)`$、$`(n/\beta)\log s`$及$`-EN`$，修正选择合理。npValidDomain全部四组正性条件完整。npField返回$`((\dot q,\dot{\tilde p}),(\dot s,\dot p_s))`$，四分量与(8.10)–(8.13)在所列字典及n版delta下相符；符号、分母和括号正确。定义总域允许$`\beta,Q,s=0`$，不能自动声称有效物理域。原页delta指代矛盾未消除，故总体NEEDS_HUMAN，并非由sorry或缺少Hamilton证明判FAIL。
原文版：原印$`\Delta H_N`$指代冲突未消除，待导师。
修正版：npDeltaN_corrected及npValidDomain网站PASS；npField在n版修正解释下分量正确，但网站逐声明仍保留NEEDS_HUMAN的指代限定。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原页$`H_N`$在$`(N_d+1)`$与$`N_d`$系数之间不一致，须人工确认；修正版按(8.9)展开选择n版。；已目视核对原页PDF355：上方$`H_N`$用$`(n+1)/\beta`$，(8.9)展开用$`n/\beta`$，末行$`\Delta H_N`$仍引用同名$`H_N`$；指代矛盾未消除。n版仅为依(8.9)展开采用的修正选择。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页355。

### 7. 状态与证明位置

- `MD.Ch08.npDeltaN_corrected`：定义
- `MD.Ch08.npValidDomain`：定义
- `MD.Ch08.npField`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2.1-NPtoNH

印刷页 335 / PDF页 356。

### 1. 原文陈述

> $`p=\tilde p/s`$, $`\xi=p_s/\mu`$; $`\dot s=s\xi`$, $`\dot\xi=\mu^{-1}(p^{\mathsf T}M^{-1}p-N_d k_B T-\Delta H_N)`$. The perturbation vanishes along the exact solution.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def npProjection (z : Phase n × (ℝ × ℝ)) (Q : ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i/z.2.1), z.2.2/Q)
theorem npProjection_equations (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (hp : thermostatParameters invm β Q) (z : ℝ → Phase n × (ℝ × ℝ))
    (hz : ∀ t, HasDerivAt z (npField invm U β Q EN (z t)) t)
    (hs : ∀ t, 0 < (z t).2.1)
    (henergy : ∀ t, npHamiltonian invm U β Q EN (z t).1.1 (z t).1.2 (z t).2.1 (z t).2.2 = 0) :
    isNHSolution invm U β Q (fun t ↦ npProjection (z t) Q) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 给定零能量NP解投影为NH解；NP零能量初值传播和非零能量修正列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 明确零能量面及$`s\gt 0`$；零能量守恒本身未假作普遍结论。
- [EXTRA/范围说明] 保留[EXTRA]全时零能量与$`s\gt 0`$；标明这是采用第11条展开式定义的NP版本。原文“沿精确解消失”须理解为正确初始化的零能量解。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页356。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.npProjection`：定义
- `MD.Ch08.npProjection_equations`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.1.2.1-NPShadowDensity

印刷页 335 / PDF页 356。

### 1. 原文陈述

> $`\tilde H_h=H_{NP}+h^2H_{[2]}+O(h^4)`$; $`\tilde\rho=\rho_\beta\zeta(q,p,h)+O(h^4)`$. Canonical averages are approximated by $`(\nu+1)^{-1}\sum g_n\zeta_n^{-1}+O(h^4)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def fourthOrderRemainder (r : ℝ → ℝ) : Prop :=
  ∃ C ε : ℝ, 0 < C ∧ 0 < ε ∧ ∀ h, |h| < ε → |r h| ≤ C*|h|^4
def correctedFiniteAverage (g ζ : ℕ → ℝ) (N : ℕ) : ℝ :=
  (∑ k ∈ Finset.range (N+1), g k / ζ k) / ((N : ℝ)+1)
def npShadowAnsatz (H H2 : Phase n → ℝ) (Htilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ Htilde h z-H z-h^2*H2 z)
def npDensityAnsatz (ρ : Phase n → ℝ) (ζ ρtilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ ρtilde h z-ρ z*ζ h z)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。
- [EXTRA/范围说明] 补充[EXTRA]：这里Phase n是示意状态域，未桥接实际扩展NP域Phase n×(ℝ×ℝ)；仅逐点O(h⁴)，非一致估计。实际重加权需ζ_k≠0；有限样本统计误差不能并入单独O(h⁴)。
- 覆盖缺口：三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。
- 覆盖缺口：[EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页356。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.fourthOrderRemainder`：定义
- `MD.Ch08.correctedFiniteAverage`：定义
- `MD.Ch08.npShadowAnsatz`：定义
- `MD.Ch08.npDensityAnsatz`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2-GeneralThermostat

印刷页 336 / PDF页 357。

### 1. 原文陈述

> $`\dot z=J\nabla H`$, $`J`$ constant skew-symmetric; $`\dot z=J\nabla H+\Phi(\xi,z)`$, $`\dot\xi=g(\xi,z)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def generalThermostat {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (z : Vec n × Vec k) : Vec n × Vec k := (J *ᵥ gradient H z.1 + Φ z, g z)
def skewMatrix (J : Matrix (Fin n) (Fin n) ℝ) : Prop := J.transpose = -J
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- J为常矩阵，$`J^{\mathsf T}=-J`$；z、ξ为实向量，光滑资格在结论中给出。
- [EXTRA/范围说明] 补充[EXTRA]辅助维数k可独立于n；不要把任意J的总函数定义视为已满足Hamiltonian资格或已驻定。
- 覆盖缺口：常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页357。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.generalThermostat`：定义
- `MD.Ch08.skewMatrix`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2.1-ContinuityProductRule

印刷页 336–337 / PDF页 357–358。

### 1. 原文陈述

> $`\partial_t\rho=-\operatorname{div}_z[\rho(J\nabla H+\Phi)]-\operatorname{div}_\xi(\rho g)=L^\dagger\rho`$; the product rule gives four terms $`W_1+W_2+W_3+W_4`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def continuityRHS {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • F x) z
theorem continuity_productRule {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k)
    (hF : DifferentiableAt ℝ F z) (hρ : DifferentiableAt ℝ ρ z) :
    continuityRHS F ρ z = -(fderiv ℝ ρ z (F z)) - ρ z*textbookDivergence F z := by
  rw [continuityRHS, textbookDivergence_density hρ hF]; ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际Fréchet散度的乘积展开；未声称连续性方程解的存在唯一性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。
- [EXTRA/范围说明] 保留总散度展开的范围说明；四项分块恒等式和完整连续性方程不得算作本条已形式覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页357–358。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.continuityRHS`：定义
- `MD.Ch08.continuity_productRule`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2.1-ThermostatCriterion

印刷页 337 / PDF页 358。

### 1. 原文陈述

> $`-[\nabla_z-\beta\nabla_z H]\cdot\Phi+\beta\xi^{\mathsf T}\mu^{-1}g-\nabla_\xi\cdot g=0`$ is the fundamental equation for deterministic thermostats.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def thermalWeight {k : ℕ} (H : Vec n → ℝ) (Q : Vec k) (β : ℝ)
    (z : Vec n × Vec k) : ℝ := Real.exp (-β*(H z.1 + (∑ i, Q i*z.2 i^2)/2))
theorem thermostatCriterion {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (Q : Vec k) (β : ℝ) (hβ : 0 < β) (hQ : ∀ i, 0 < Q i) (hJ : skewMatrix J)
    (hH : ContDiff ℝ 2 H) (hΦ : ContDiff ℝ 1 Φ) (hg : ContDiff ℝ 1 g) :
    textbookLiouvilleStationary (generalThermostat J H Φ g) (thermalWeight H Q β) ↔
    ∀ z, -(textbookDivergence (fun x ↦ Φ (x,z.2)) z.1) +
      β*fderiv ℝ H z.1 (Φ z) + β*(∑ i, Q i*z.2 i*g z i) -
      textbookDivergence (fun y ↦ g (z.1,y)) z.2 = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 给定正参数与光滑性后，局部Liouville驻定与所列标量散度条件的等价目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 原文$`\mu_i`$在指数中是热质量，统一写$`Q_i`$；矩阵$`\mu^{-1}`$的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。
- [EXTRA/范围说明] 补充明确记号字典$`Q_i=`$原文标量$`\mu_i`$，原文矩阵$`\mu^{-1}=\operatorname{diag}(Q_i)`$，矩阵$`\mu=\operatorname{diag}(1/Q_i)`$。若原书 intended $`\mu=\operatorname{diag}(\mu_i)`$，则该矩阵记号需[ERRATUM?]人工确认。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页358。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.thermalWeight`：定义
- `MD.Ch08.thermostatCriterion`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2.1-Examples81and82

印刷页 337–338 / PDF页 358–359。

### 1. 原文陈述

> Example 8.1 $`\Phi=-\xi(0,p)`$, $`g=\mu^{-1}(p\cdot\nabla_p H-N_d k_B T)`$. Example 8.2 $`\Phi=\xi G(z)`$, $`g=\mu^{-1}[\nabla H-k_B T\nabla]\cdot G`$. Configurational choice $`G=(\nabla_q K,0)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
/-- 原文正号组合的驻定声称；原书疑误，保留字面版，不作为有效定理。 -/
theorem generalizedFeedback_stationaryPrinted (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry

/-- 修正版：仅将耦合改为负号，反馈保留原式；原文例8.2另存。 -/
theorem generalizedFeedback_stationary_corrected (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 - z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`\beta^{-1}=k_B T`$，$`Q=\mu`$；一般G定义中的n是相空间维数，不能将此处n一律解释为物理自由度数。
- generalizedFeedback和configurationalFeedback为原式总函数；经典导数解释需相应可微性。
- [EXTRA] 两个驻定定理假设常矩阵J反对称、H为$`C^3`$、G为$`C^2`$、$`\beta,Q\gt 0`$，结论为所有点的$`\operatorname{div}(\rho F)=0`$；不是全局流不变概率测度或遍历性。
- Example8.1的物理系统、构型完整场及其独立驻定定理未在本条四声明中单列。
- [ERRATUM?] Printed仅供原文忠实记录，不作为任何其他条目的有效定理依赖；实际局部驻定采用负号耦合_corrected。
- 覆盖缺口：原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：NEEDS_HUMAN；generalizedFeedback为$`(DH[G]-\operatorname{div}G/\beta)/Q`$，与原印括号算子完全相符；configurationalFeedback为$`(\nabla U\cdot\nabla K-\Delta K/\beta)/Q`$，亦忠实。两个定理所有参数和前提相同：任意n、常反对称J、$`C^3`$实函数H、$`C^2`$向量场G、正β,Q，密度$`\rho=\exp(-\beta(H+Q\xi^2/2))`$，完整结论为$`\forall(z,\xi),\operatorname{div}(\rho F)=0`$。Printed取$`+\xi G`$，与原印隐含驻定声称忠实，按任务判字面PASS，但数学内容有原书符号疑误。corrected仅取$`-\xi G`$，成立：Hamilton项加权散度为零，$`-\xi G`$项贡献$`\rho\xi(\beta DH[G]-\operatorname{div}G)`$，ξ方向贡献其负值，逐点相消。无须归一化或增长条件即可作此局部结论；也未据此声称全局采样。
原文版：Printed字面忠实性PASS；$`+\xi G`$驻定声称为原书符号疑误，禁止作为有效定理依赖。
修正版：$`-\xi G`$的_corrected局部驻定签名网站PASS。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原印例8.2的Φ=$`+\xi G`$与正反馈一般不保持所列高斯Gibbs密度；Printed忠实保留该声称。负号耦合corrected为合理修正。；已目视核对原页PDF358：例8.2印为Φ=$`+\xi G`$及正反馈；Printed仅保留原印疑误，不得被其他条目作为有效数学定理依赖；corrected采用$`-\xi G`$。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页358–359。

### 7. 状态与证明位置

- `MD.Ch08.generalizedFeedback`：定义
- `MD.Ch08.configurationalFeedback`：定义
- `MD.Ch08.generalizedFeedback_stationaryPrinted`：未证；原书疑误不证
- `MD.Ch08.generalizedFeedback_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2.1-TemperatureIdentity

印刷页 338 / PDF页 359。

### 1. 原文陈述

> $`\int\operatorname{div}G\,\rho\,d\omega=-\int\nabla\rho\cdot G\,d\omega=\beta\int\nabla H\cdot G\,\rho\,d\omega`$. $`T=k_B^{-1}\langle\nabla H\cdot G\rangle/\langle\operatorname{div}G\rangle`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem temperatureIdentity (H : Vec n → ℝ) (G : Vec n → Vec n) (β : ℝ)
    (hH : ContDiff ℝ 2 H) (hG : ContDiff ℝ 1 G) (hcompact : HasCompactSupport G)
    (hβ : 0 < β) :
    (∫ z, textbookDivergence G z * gibbsWeight H β z) =
      β * ∫ z, fderiv ℝ H z (G z) * gibbsWeight H β z := by
  sorry
def phaseTemperature (kB numerator denominator : ℝ) : ℝ := numerator/(kB*denominator)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 紧支撑G的Gibbs积分分部目标及温度比值定义；一般边界衰减条件和比值推导未另证。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求$`k_B\gt 0`$、分母非零。
- [EXTRA/范围说明] 保留紧支撑替代衰减的[EXTRA]；若解释归一平均或推导T，须另外有有限正配分函数、$`k_B\gt 0`$、分母非零及$`\beta^{-1}=k_B T`$。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页359。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.temperatureIdentity`：未证；缺大型理论
- `MD.Ch08.phaseTemperature`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2.1-Proposition81

印刷页 338–339 / PDF页 359–360。

### 1. 原文陈述

> Two thermostats preserving $`a(\xi)\rho_\beta`$ and $`b(\eta)\rho_\beta`$ can be added and preserve $`a(\xi)b(\eta)\rho_\beta`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> The proof is an immediate consequence of the linearity of the divergence
> operator, since the Liouville operator is constructed from this.

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition81 {H : SymplecticCoordinates n → ℝ} (hH : ContDiff ℝ 2 H) (β c : ℝ)
    {φ₁ φ₂ : SymplecticCoordinates n × ℝ → SymplecticCoordinates n}
    {g₁ g₂ : SymplecticCoordinates n × ℝ → ℝ} {a b : ℝ → ℝ}
    (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (hs₁ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₁ g₁)
      (fun w ↦ a w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (hs₂ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₂ g₂)
      (fun w ↦ b w.2 * textbookHamiltonianGibbsDensity H β c w.1)) :
    textbookLiouvilleStationary
      (textbookCombinedThermostatField (textbookHamiltonianVectorField H) φ₁ φ₂ g₁ g₂)
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) := by
  exact textbookThermostats_additive_proposition81 hH β c hφ₁ hφ₂ hg₁ hg₂ ha hb hs₁ hs₂
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。
- 覆盖缺口：两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。
- 覆盖缺口：两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页359–360。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.proposition81`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.2.2-NHChains

印刷页 339–340 / PDF页 360–361。

### 1. 原文陈述

> The Nosé–Hoover chain (8.16)–(8.21) preserves $`\rho_\beta\exp(-\beta\sum\mu_i\xi_i^2/2)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhChainField (k : ℕ) (invm : Vec n) (U : Vec n → ℝ) (β : ℝ)
    (Q : Fin k → ℝ) (z : Phase n × (Fin k → ℝ)) : Phase n × (Fin k → ℝ) :=
  ((fun i ↦ invm i*z.1.2 i,
    fun i ↦ -gradient U z.1.1 i - (if hk : 0 < k then z.2 ⟨0,hk⟩ else 0)*z.1.2 i),
   fun j ↦ (if hj : j.val = 0 then (kineticTwice invm z.1.2-(n : ℝ)/β)/Q j
     else (Q ⟨j.val-1,by omega⟩ * z.2 ⟨j.val-1,by omega⟩ ^2 - 1/β)/Q j) -
     (if hj : j.val+1 < k then z.2 j * z.2 ⟨j.val+1,hj⟩ else 0))
theorem nhChain_stationary (k : ℕ) (hk : 0 < k) (invm : Vec n) (U : Vec n → ℝ)
    (β : ℝ) (Q : Fin k → ℝ) (hβ : 0 < β) (hQ : ∀ j, 0 < Q j)
    (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhChainField k invm U β Q)
      (fun z ↦ Real.exp (-β*(kineticTwice invm z.1.2/2+U z.1.1+(∑ j, Q j*z.2 j^2)/2))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 链长$`k\gt 0`$，各热质量$`Q_j\gt 0`$、$`\beta\gt 0`$，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`\forall i,invm_i\gt 0`$，$`N_d=n`$；$`U\in C^2`$。仅形式化正对角质量、无约束情形。
- 覆盖缺口：任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。
- 覆盖缺口：链长$`k\gt 0`$，各热质量$`Q_j\gt 0`$、$`\beta\gt 0`$，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页360–361。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhChainField`：定义
- `MD.Ch08.nhChain_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.3-ArrheniusRate

印刷页 342 / PDF页 363。

### 1. 原文陈述

> $`k\sim A e^{-\Delta E/(k_B T)}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Arrhenius指数速率公式定义及$`A\ge0`$时非负性；不含亚稳跃迁率渐近定理或温度单调性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`A\ge0,k_B\gt 0,T\gt 0`$为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。
- 覆盖缺口：Arrhenius指数速率公式定义及$`A\ge0`$时非负性；不含亚稳跃迁率渐近定理或温度单调性。
- 覆盖缺口：$`A\ge0,k_B\gt 0,T\gt 0`$为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页363。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.arrheniusRate`：定义
- `MD.Ch08.arrheniusRate_nonneg`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-AdditiveThermostatSDE

印刷页 342–343 / PDF页 363–364。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$; $`dp=-\nabla U\,dt-\Phi(\xi,z)-\Gamma p\,dt+\sqrt{2k_B T}M^{1/2}\Gamma^{1/2}dW`$; $`d\xi=g\,dt-\hat\Gamma\xi\,dt+\sqrt{2k_B T}\hat M^{1/2}\hat\Gamma^{1/2}d\hat W`$. All Wiener coordinates are independent.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def independentWiener (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, IsBrownianReal (fun t sample ↦ W t sample j) P) ∧
    iIndepFun (fun j sample ↦ fun t : ℝ ↦ W t sample j) P
def additiveSDE {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [MeasurableSpace E]
    (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k)
    (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : Fin k → E) : Prop :=
  independentWiener P k W ∧ (∀ᵐ sample ∂P, Continuous (fun t ↦ X t sample)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ t : ℝ, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 t) ∧
    ∀ᵐ sample ∂P, X t sample = x0 + (∫ s in 0..t, a (X s sample)) +
      ∑ j, (W t sample j-W 0 sample j) • B j
def stochasticThermostatDrift {k : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ : Matrix (Fin n) (Fin n) ℝ) (Γhat : Matrix (Fin k) (Fin k) ℝ)
    (z : Phase n × Vec k) : Phase n × Vec k :=
  ((fun i ↦ invm i*z.1.2 i, fun i ↦ -gradient U z.1.1 i-Φ z i-(Γ *ᵥ z.1.2) i),
   g z - Γhat *ᵥ z.2)
def fluctuationDissipation (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ) : Prop :=
  0 < β ∧ M.PosDef ∧ Γ.PosSemidef ∧ B*B.transpose = (2/β) • (Γ*M)

/-- 两组噪声共用一个n+k维独立Wiener过程，分块只作用于p和ξ。 -/
def thermostatBlockNoise {k : ℕ}
    (B : Matrix (Fin n) (Fin n) ℝ) (Bhat : Matrix (Fin k) (Fin k) ℝ)
    (j : Fin (n+k)) : Phase n × Vec k :=
  if hj : j.val < n then
    ((0,fun i ↦ B i ⟨j.val,hj⟩),0)
  else ((0,0),fun i ↦ Bhat i ⟨j.val-n,by omega⟩)

/-- 正对角物理质量特例的统一积分解规格；两组协方差与实际漂移使用同一质量。
不含一般非对角物理质量，也不声称由此已证明存在、唯一或不变分布。 -/
def stochasticThermostatSolution {k : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → Vec (n+k)) (X : ℝ → Ω → Phase n × Vec k)
    (x0 : Phase n × Vec k) (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ B : Matrix (Fin n) (Fin n) ℝ)
    (Mhat Γhat Bhat : Matrix (Fin k) (Fin k) ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧
  fluctuationDissipation (Matrix.diagonal (fun i ↦ (invm i)⁻¹)) Γ B β ∧
  fluctuationDissipation Mhat Γhat Bhat β ∧
  additiveSDE P (n+k) W X x0 (stochasticThermostatDrift invm U Φ g Γ Γhat)
    (thermostatBlockNoise B Bhat)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 已组装的对角物理质量、交换涨落耗散特例：同一$`n+k`$维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，所有$`invm_i\gt 0`$，$`N_c=N_d=n`$；U为$`C^1`$。$`\beta^{-1}=k_B T`$。
- [EXTRA] stochasticThermostatSolution已用同一$`n+k`$维独立Wiener过程、thermostatBlockNoise和实际漂移组装完整积分解规格。物理质量明确绑定$`\operatorname{diag}(invm^{-1})`$，热浴质量为Mhat，两组使用同β。
- [EXTRA] fluctuationDissipation要求$`\beta\gt 0`$、M正定、Γ半正定及$`BB^{\mathsf T}=(2/\beta)\Gamma M`$。实对称矩阵下由左右对称性强制$`\Gamma M=M\Gamma`$，属于明确限制后的充分相容条件。热浴同理。
- [ERRATUM?] 原印$`-\Phi`$未附$`dt`$；漂移按$`-\Phi\,dt`$解释。原印对称性条件不足以保证矩阵平方根噪声的Gibbs相容性。
- 未要求或证明确定性Φ,g部分保权；未构造矩阵平方根，未证明完整解存在、唯一、不变分布或遍历性。
- [EXTRA] additiveSDE要求几乎处处全实时间连续；每个$`t\ge0`$的X t对W在[0,t]历史可测，漂移在[0,t]几乎处处可积，且逐个t的积分方程几乎处处成立；x0固定而非随机。
- [EXTRA] 对一般矩阵的匹配应为$`BB^{\mathsf T}=(\Gamma M+M\Gamma^{\mathsf T})/\beta`$并须协方差可实现；当前采用$`BB^{\mathsf T}=(2/\beta)\Gamma M`$，在实对称条件下限制为$`\Gamma M=M\Gamma`$的充分特例，不扩充Lean模型。
- 覆盖缺口：已组装的对角物理质量、交换涨落耗散特例：同一$`n+k`$维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。
- 覆盖缺口：未要求或证明确定性Φ,g部分保权；未构造矩阵平方根，未证明完整解存在、唯一、不变分布或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：NEEDS_HUMAN；independentWiener对每个Fin k坐标要求IsBrownianReal，并对整个路径随机变量iIndepFun，P为概率测度，故跨组独立性由统一$`n+k`$坐标给出。additiveSDE的对象E、固定x0、常因子B、几乎处处连续、自然噪声历史可测、$`t\ge0`$逐时可积及积分恒等式全部明确；不是存在性定理。stochasticThermostatDrift在$`(q,p,\xi)`$上恰为$`(\operatorname{diag}(invm)p,-\nabla U-\Phi-\Gamma p,g-\hat\Gamma\xi)`$，把原书缺失dt解释为漂移。thermostatBlockNoise前n列只作用p，后k列只作用ξ，q噪声为零。stochasticThermostatSolution已将该漂移、分块噪声、同一个独立W、同β两组资格及实际对角物理质量绑定，旧未组装/未绑定指控不成立。fluctuationDissipation为充分但较强的交换情形，不能冒充原印仅对称的一般模型。没有确定性保权前提，因而不能从该解谓词推出Gibbs不变性；声明本身未作此结论，故不是签名错误。原书dt和矩阵条件疑误总体保留NEEDS_HUMAN。
原文版：原印缺dt及矩阵噪声相容疑误待导师。
修正版：已组装的对角物理质量、交换涨落耗散特例网站PASS；不代表一般矩阵模型。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原印(8.23)的−Φ缺dt。；[ERRATUM?] 原印矩阵对称性不足以保证实噪声及Gibbs相容；当前Lean是半正定、交换资格下的限制模型。；已目视核对原页PDF364：(8.23)的−Φ缺dt；矩阵仅对称不足以保证所印噪声与目标Gibbs协方差相容。当前模型已组装，是对角物理质量、交换涨落耗散特例。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页363–364。

### 7. 状态与证明位置

- `MD.Ch08.independentWiener`：定义
- `MD.Ch08.additiveSDE`：定义
- `MD.Ch08.stochasticThermostatDrift`：定义
- `MD.Ch08.fluctuationDissipation`：定义
- `MD.Ch08.thermostatBlockNoise`：定义
- `MD.Ch08.stochasticThermostatSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-OUStationarityPrinted

印刷页 343–344 / PDF页 364–365。

### 1. 原文陈述

> The OU momentum process with drift $`-\Gamma p`$ and noise $`\sqrt{2k_B T}M^{1/2}\Gamma^{1/2}`$ preserves $`\exp(-\beta p^{\mathsf T}M^{-1}p/2)`$. The displayed diffusion term is $`\beta^{-1}\operatorname{Tr}(\Gamma^{1/2}M^{1/2}[\beta M^{-1}pp^{\mathsf T}M^{-1}-M^{-1}]M^{1/2}\Gamma^{1/2})\bar\rho=-\text{drift}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def ouFokkerPlanck (A C : Matrix (Fin n) (Fin n) ℝ) (ρ : Vec n → ℝ) (p : Vec n) : ℝ :=
  textbookDivergence (fun x ↦ ρ x • (A *ᵥ x)) p +
    (∑ i, ∑ j, C i j * fderiv ℝ (fun x ↦ gradient ρ x j) p (Pi.single i 1))/2
theorem ouStationarity_corrected (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ)
    (hf : fluctuationDissipation M Γ B β) :
    ∀ p, ouFokkerPlanck Γ (B*B.transpose)
      (fun x ↦ Real.exp (-β * dot x (M⁻¹ *ᵥ x)/2)) p = 0 := by
  sorry
theorem diffusionPrinted (β : ℝ) (hβ : 0 < β) : (1/β)*(-1) = -(1 : ℝ) := by
  sorry
theorem diffusionPrinted_counterexample : ¬ ((1/(2:ℝ))*(-1) = -(1:ℝ)) := by norm_num
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Printed保留显示抵消式的$`M=\Gamma=1,p=0`$标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：diffusionPrinted忠实性PASS；原印β因子和矩阵相容性待导师。
修正版：原送审ouStationarity_corrected及标量反例PASS；仅局部算子恒零。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加$`\Gamma M=M\Gamma`$或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留$`\beta^{-1}`$，标量$`\beta=2`$,$`p=0`$已反例。；[ERRATUM?]保留原所印等式及$`\beta=2`$反例；修正版的$`BB^{\mathsf T}=(2/\beta)\Gamma M`$为明确额外资格，在对称情形蕴含交换性。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页364–365。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.ouFokkerPlanck`：定义
- `MD.Ch08.ouStationarity_corrected`：未证；缺大型理论
- `MD.Ch08.diffusionPrinted`：未证；原书疑误不证
- `MD.Ch08.diffusionPrinted_counterexample`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-LiftedThermostat

印刷页 344–345 / PDF页 365–366。

### 1. 原文陈述

> $`dz=F(z)\,dt+\xi G(z)\,dt`$, $`d\xi=g(z)\,dt-\gamma\xi\,dt+\sigma\,dW`$. The lifted fields are $`b_0=(F+\xi G,g-\gamma\xi)`$, $`b_1=(0,\sigma)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def liftedThermostat (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec n × ℝ)
    (x0 : Vec n × ℝ) : Prop :=
  additiveSDE P 1 W X x0 (textbookThermostatDrift F G g γ)
    (fun _ ↦ (0, σ))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 一般单热浴提升场的实际加性Wiener积分解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 真实Wiener、适应性和可积性由additiveSDE给出；$`\sigma\ne0`$在Hörmander结论中单列。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页365–366。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.liftedThermostat`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-Proposition82

印刷页 344–345 / PDF页 365–366。

### 1. 原文陈述

> If the Lie algebra generated by $`F`$ and $`G`$ in (8.25) spans $`\mathbb R^m`$, then the Hörmander condition holds for (8.25)–(8.26).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition82Printed (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g)
    (w : Vec n × ℝ) (hspan : textbookHormanderAt {F,G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  sorry
theorem proposition82_corrected (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g)
    (hσ : σ ≠ 0) (w : Vec n × ℝ) (hspan : textbookHormanderAt {F,G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  exact textbookThermostatHormanderLift F G g γ σ hF hG hg hσ w hspan
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印及补$`\sigma\ne0`$后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- 覆盖缺口：所印及补$`\sigma\ne0`$后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。
- 覆盖缺口：Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；$`\sigma=0`$使原结论失效。
修正版：原送审$`C^\infty`$且$`\sigma\ne0`$的_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF365–366：证明除以σ，定理需$`\sigma\ne0`$；光滑向量场资格明确补足。；[ERRATUM?]$`\sigma=0`$反例；Printed仅作忠实记录，corrected在$`\sigma\ne0`$下通过。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页365–366。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.proposition82Printed`：未证；原书疑误不证
- `MD.Ch08.proposition82_corrected`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-NHL

印刷页 345–346 / PDF页 366–367。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$, $`dp=-\nabla U\,dt-\xi p\,dt`$, $`d\xi=\mu^{-1}[p^{\mathsf T}M^{-1}p-N_d k_B T]dt-\gamma\xi\,dt+\sqrt{2k_B T\gamma\mu^{-1}}dW`$. Quadratic specialization: $`U=q^{\mathsf T}Aq/2`$, $`M=I`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlDrift (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (nhField invm U β Q z).1 |> fun physical ↦ (physical, (nhField invm U β Q z).2-γ*z.2)
def isNHLSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Phase n × ℝ)
    (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧
    additiveSDE P 1 W X x0 (nhlDrift invm U β Q γ)
      (fun _ ↦ (0, Real.sqrt (2*γ/(β*Q))))
def harmonicPotential (A : Matrix (Fin n) (Fin n) ℝ) (q : Vec n) : ℝ := dot q (A *ᵥ q)/2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 仅正对角质量、无约束$`N_d=n`$的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`N_d=n`$；$`invm_i,\beta,Q,\gamma`$均正；$`\beta^{-1}=k_B T`$，$`Q=\mu`$。一般非对角物理质量未覆盖。
- isNHLSolution采用一个实Wiener坐标，噪声只作用ξ，幅度$`\sqrt{2\gamma/(\beta Q)}`$；解的可测、连续、可积与固定初值规格由additiveSDE给出。
- harmonicPotential对任意实方阵A定义$`q^{\mathsf T}Aq/2`$；没有在该def中要求A对称正定，也未把isNHLSolution绑定到该二次势或$`M=I`$。
- 不含原页定理8.1、特征值互异、D的模态排除及Hörmander/遍历性结论；不得由本条声明推断这些性质。
- [ERRATUM?] 原印质量重缩放方向有误，保留原文，正确方向须同步变换势。
- [ERRATUM?] 正确重缩放为$`\tilde q=M^{1/2}q`$、$`\tilde p=M^{-1/2}p`$；$`\tilde U(\tilde q)=U(M^{-1/2}\tilde q)`$，二次势矩阵变为$`M^{-1/2}AM^{-1/2}`$。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。
- 覆盖缺口：仅正对角质量、无约束$`N_d=n`$的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。
- 覆盖缺口：[EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`N_d=n`$；$`invm_i,\beta,Q,\gamma`$均正；$`\beta^{-1}=k_B T`$，$`Q=\mu`$。一般非对角物理质量未覆盖。
- 覆盖缺口：harmonicPotential对任意实方阵A定义$`q^{\mathsf T}Aq/2`$；没有在该def中要求A对称正定，也未把isNHLSolution绑定到该二次势或$`M=I`$。
- 覆盖缺口：不含原页定理8.1、特征值互异、D的模态排除及Hörmander/遍历性结论；不得由本条声明推断这些性质。
- 覆盖缺口：[ERRATUM?] 正确重缩放为$`\tilde q=M^{1/2}q`$、$`\tilde p=M^{-1/2}p`$；$`\tilde U(\tilde q)=U(M^{-1/2}\tilde q)`$，二次势矩阵变为$`M^{-1/2}AM^{-1/2}`$。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：NEEDS_HUMAN；展开nhField可得$`nhlDrift=((invm\cdot p,-\nabla U-\xi p),(\sum invm_i p_i^2-n/\beta)/Q-\gamma\xi)`$，故三个漂移分量对应(8.27)–(8.29)。isNHLSolution在任意带可测空间Ω上量化概率测度P、单坐标W、状态过程X及固定x0，要求全部逆质量、β,Q、γ正；常噪声向量的物理Phase分量为0，热浴分量$`\sqrt{2\gamma/(\beta Q)}`$，与原印根号覆盖范围完全一致。additiveSDE的完整积分解前提已核对，不声称存在、不变性或遍历性。harmonicPotential对任意A只定义二次函数；只有A对称时梯度才是Aq，不能凭def推断正定或定理8.1。原页D用于后续Hörmander结论，本条未形式化它，不应将此归为一般NHL漂移错误。当前明确缩小范围的三个声明本身可PASS，原书重缩放疑误使条目总体NEEDS_HUMAN。
原文版：原印质量重缩放方向疑误待导师。
修正版：正对角质量NHL漂移及单噪声积分解规格网站PASS；harmonicPotential仅定义函数，不含(8.30)–(8.32)特化或定理8.1。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：已目视核对原页PDF367：原印$`\tilde q=M^{-1/2}q`$、$`\tilde p=M^{1/2}p`$不产生单位质量方程；正确方向相反并须同步变换势。；[ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。；已目视核对原页PDF367：原印$`\tilde q=M^{-1/2}q`$、$`\tilde p=M^{1/2}p`$方向有误。正确为$`\tilde q=M^{1/2}q`$、$`\tilde p=M^{-1/2}p`$，势变为$`\tilde U(\tilde q)=U(M^{-1/2}\tilde q)`$；若$`U(q)`$=$`q^{\mathsf T}Aq/2`$，则$`\tilde A=M^{-1/2}AM^{-1/2}`$。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页366–367。

### 7. 状态与证明位置

- `MD.Ch08.nhlDrift`：定义
- `MD.Ch08.isNHLSolution`：定义
- `MD.Ch08.harmonicPotential`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-Lemma81

印刷页 347 / PDF页 368。

### 1. 原文陈述

> $`C_k=(A^{k-1}p,A^kq)`$, $`D_k=(A^kq,-A^kp)`$ belong to the Lie algebra generated by $`F=(p,-Aq)`$, $`G=(0,p)`$, $`k=1,2,\ldots`$

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> The proof of this is straightforward by induction on k. (See exercises.)

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lemma81 (A : Matrix (Fin n) (Fin n) ℝ) (k : ℕ) :
    textbookThermostatC A k ∈ textbookThermostatLieSpan A ∧
    textbookThermostatD A k ∈ textbookThermostatLieSpan A := by
  exact textbookThermostat_C_D_mem_lieSpan A k
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 线性向量场C、D在实际Lie生成空间中的归属；Lean零起始索引对应原文正索引。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Lean索引$`k=0`$对应原文$`k=1`$；完整实际线性场、导数括号与End括号约定均摘录；生成子代数在相反括号下相同。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页368。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.lemma81`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-Proposition83

印刷页 347–348 / PDF页 368–369。

### 1. 原文陈述

> If $`A`$ is symmetric positive definite with distinct eigenvalues, the $`2N_c`$ vectors $`C_1,D_1,\ldots,C_{N_c},D_{N_c}`$ are linearly independent on $`D=\mathbb R^{2N_c}\setminus\bigcup V_k`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition83 (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase n)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    LinearIndependent ℝ (textbookThermostatFamily A z) := by
  exact textbookThermostatFamily_linearIndependent A hA hdist z hz
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 指定模态域内的2n个实际线性场值线性无关；不扩大到例外零模态。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：[ERRATUM?]原证明下标、模态标量式及第二组系数消去需核对；命题与Lean签名正确。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页368–369。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.proposition83`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-Theorem81

印刷页 346–348 / PDF页 367–369。

### 1. 原文陈述

> If $`A`$ is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on $`D\times\mathbb R`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem theorem81Printed (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  sorry
theorem theorem81_corrected (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ) (hQ : 0 < Q)
    (hθ : 0 < θ) (hγ : 0 < γ) (hσ : σ ≠ 0)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  exact textbookNHL_hormander A hA hdist Q θ γ σ hσ w hw
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
- [EXTRA]$`\theta=k_B T`$，$`Q=\mu`$；corrected的$`Q,\theta,\gamma\gt 0`$是物理资格，括号结论本身只额外需要$`\sigma\ne0`$。σ在此是独立实参数，未声明满足NHL涨落耗散幅度。
- [EXTRA] 当前`_corrected`为σ独立非零的括号结论；如解释为物理NHL，还须$`\sigma^2=2\gamma\theta/Q`$。未推到全局遍历性。
- 覆盖缺口：所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；缺非零噪声资格。
修正版：原送审正参数与$`\sigma\ne0`$的_corrected点态括号结论PASS，非全局遍历性。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除$`\sigma=0`$；只证明Hörmander张成，不自动获得全局几何遍历性。；[ERRATUM?]字面版含$`\sigma=0`$反例；物理上下文的参数资格与字面版分开。原质量重缩放与所引证明的局部排印/推导疑误亦应保留。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页367–369。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.theorem81Printed`：未证；原书疑误不证
- `MD.Ch08.theorem81_corrected`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-ZeroModeInvariant

印刷页 346 / PDF页 367。

### 1. 原文陈述

> $`V_k=\{(q,p)\mid u_k\cdot q=0,\ u_k\cdot p=0\}`$ is an invariant submanifold. $`D=\mathbb R^{2N_c}\setminus\bigcup V_k`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem modeDomain_complement {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian) :
    textbookThermostatModeDomain hA = (⋃ i, textbookNHLZeroMode hA i)ᶜ :=
  textbookThermostatModeDomain_eq_compl_zeroModes hA
theorem zeroMode_invariant {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian)
    (i : Fin n) {a b : ℝ} (q p : ℝ → Vec n) (ξ : ℝ → ℝ)
    (hcq : ContinuousOn q (Icc a b)) (hcp : ContinuousOn p (Icc a b))
    (hξ : ContinuousOn ξ (Icc a b))
    (hq : ∀ t ∈ Ico a b, HasDerivWithinAt q (p t) (Ici t) t)
    (hp : ∀ t ∈ Ico a b, HasDerivWithinAt p (-(A *ᵥ q t)-ξ t • p t) (Ici t) t)
    (hzero : (q a,p a) ∈ textbookNHLZeroMode hA i) :
    ∀ t ∈ Icc a b, (q t,p t) ∈ textbookNHLZeroMode hA i := by
  exact textbookNHL_zeroMode_invariant hA i q p ξ hcq hcp hξ hq hp hzero
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 模态域的补集表达及连续热浴路径驱动的模态ODE零模态不变。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 任意紧时间区间上的实际模态ODE；连续随机热浴路径可逐路径应用，不额外声称SDE解存在。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页367。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.modeDomain_complement`：已证
- `MD.Ch08.zeroMode_invariant`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-NHLGenerator

印刷页 348 / PDF页 369。

### 1. 原文陈述

> $`L_{NHL}f=M^{-1}p\cdot\nabla_q f-\nabla U\cdot\nabla_p f-\xi p\cdot\nabla_p f+[\mu^{-1}(p^{\mathsf T}M^{-1}p-N_d k_B T)-\gamma\xi]\partial_\xi f+k_B T\gamma\mu^{-1}\partial_\xi^2f`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def additiveGenerator {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (B : E) (f : E → ℝ) (z : E) : ℝ :=
  fderiv ℝ f z (F z) + fderiv ℝ (fun x ↦ fderiv ℝ f x B) z B / 2
def nhlGenerator (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (f : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  additiveGenerator (nhlDrift invm U β Q γ) (0, Real.sqrt (2*γ/(β*Q))) f z
def nhlLyapunov (U : Vec n → ℝ) (Q a : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∑ i, z.1.2 i^2)/2 + U z.1.1 + Q*(z.2-a)^2/2
def geometricDriftBound {E : Type*} (L : (E → ℝ) → E → ℝ) (V : E → ℝ) : Prop :=
  (∀ z, 0 < V z) ∧ ∃ α δ : ℝ, 0 < α ∧ 0 < δ ∧ ∀ z, L V z ≤ -α*V z+δ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际加性扩散的Fréchet形式生成元、Lyapunov候选及漂移界性质的定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 采用实际一阶、二阶Fréchet导数；原文省略f的$`-\xi p\cdot\nabla_p`$理解为作用于f；Q,β,γ须正。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页369。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.additiveGenerator`：定义
- `MD.Ch08.nhlGenerator`：定义
- `MD.Ch08.nhlLyapunov`：定义
- `MD.Ch08.geometricDriftBound`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-LyapunovCalculation

印刷页 348–349 / PDF页 369–370。

### 1. 原文陈述

> For $`M=I`$, $`\varphi=\lVert p\rVert^2/2+U+\mu(\xi-a)^2/2`$, $`L\varphi=-a\lVert p\rVert^2-\gamma\mu\xi(\xi-a)-N_d k_B T(\xi-a)+k_B T\gamma`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlLyapunovExpression (P2 U ξ Q θ γ a N : ℝ) : ℝ :=
  -a*P2-γ*Q*ξ*(ξ-a)-N*θ*(ξ-a)+θ*γ
theorem nhlLyapunov_calculation (U : Vec n → ℝ) (β Q γ a : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (hQ : 0 < Q) (hγ : 0 < γ)
    (z : Phase n × ℝ) :
    nhlGenerator (fun _ ↦ 1) U β Q γ (nhlLyapunov U Q a) z =
      nhlLyapunovExpression (∑ i, z.1.2 i^2) (U z.1.1) z.2 Q (1/β) γ a n := by
  sorry
theorem shiftedSquare_bound (ξ a : ℝ) : -ξ^2-a^2 ≤ -(ξ-a)^2/2 := by
  nlinarith [sq_nonneg (ξ+a)]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际NHL生成元作用于平移二次能量的目标及标量平方不等式；未据此证明遍历。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- U下界$`\gt 1`$且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需$`C^2`$。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页369–370。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhlLyapunovExpression`：定义
- `MD.Ch08.nhlLyapunov_calculation`：未证；缺大型理论
- `MD.Ch08.shiftedSquare_bound`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-LyapunovRatePrinted

印刷页 349 / PDF页 370。

### 1. 原文陈述

> Choose $`a\gamma\mu-N_d k_B T=0`$, $`\alpha=\min(2a,\gamma\mu)`$, $`\delta=\alpha U_{max}+\gamma\mu a^2+aN_d k_B T+k_B T\gamma`$; then $`L\varphi\le-\alpha\varphi+\delta`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovAlphaPrinted (a γ Q : ℝ) : ℝ := min (2*a) (γ*Q)
def lyapunovAlpha_corrected (a γ : ℝ) : ℝ := min (2*a) γ
theorem lyapunovRatePrinted (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlphaPrinted a γ Q * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlphaPrinted a γ Q*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
theorem lyapunovRate_counterexample :
    ¬ (nhlLyapunovExpression 0 2 10 4 1 1 2 8 ≤
      -lyapunovAlphaPrinted 2 1 4 * ((0:ℝ)/2+2+4*(10-2)^2/2) +
      (lyapunovAlphaPrinted 2 1 4*2+1*4*2^2+2*8*1+1*1)) := by
  norm_num [nhlLyapunovExpression, lyapunovAlphaPrinted]
theorem lyapunovRate_corrected (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlpha_corrected a γ * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlpha_corrected a γ*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 修正为$`\min(2a,\gamma)`$，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；$`\min(2a,\gamma\mu)`$一般不正确。
修正版：原送审$`\min(2a,\gamma)`$修正版及反例PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF370：与φ热浴项$`\mu(\xi-a)^2/2`$比较时衰减系数应$`\le\gamma`$，所印$`\min(2a,\gamma\mu)`$对一般μ不足；正参数数值反例已列。；{"codes": ["ERRATUM_LYAPUNOV_RATE"], "detail": "lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书$`\alpha=\min(2a,\gamma\mu)`$及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为$`\min(2a,\gamma)`$合理且正确：ξ能量的系数是Q/2，故须$`\alpha\le\gamma`$；结合平方不等式及$`U\le U_{max}`$得所写δ。修正版没有额外宣称几何遍历。", "suggested_fix": "原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，$`\alpha=\min(2a,\gamma)`$。"}
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页370。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.lyapunovAlphaPrinted`：定义
- `MD.Ch08.lyapunovAlpha_corrected`：定义
- `MD.Ch08.lyapunovRatePrinted`：未证；原书疑误不证
- `MD.Ch08.lyapunovRate_counterexample`：已证
- `MD.Ch08.lyapunovRate_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.2-NHLTimestep

印刷页 350 / PDF页 371。

### 1. 原文陈述

> The symmetric NHL splitting uses kick, drift, feedback, damping, exact OU, damping, feedback, drift, kick. $`\zeta=\sqrt{k_B T\mu^{-1}(1-e^{-2\gamma h})}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlOU (β Q γ h R : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, Real.exp (-γ*h)*z.2 + Real.sqrt ((1-Real.exp (-2*γ*h))/(β*Q))*R)
def forceKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i-h*gradient U z.1.1 i), z.2)
def bathDamping (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i), z.2)
def nhlStep (invm : Vec n) (U : Vec n → ℝ) (β Q γ h R : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  forceKick U (h/2) ∘ nhDrift invm (h/2) ∘ nhFeedback invm β Q (h/2) ∘ bathDamping (h/2) ∘
  nhlOU β Q γ h R ∘ bathDamping (h/2) ∘ nhFeedback invm β Q (h/2) ∘ nhDrift invm (h/2) ∘ forceKick U (h/2)
def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧ ∀ k, HasLaw (R k) (gaussianReal 0 1) P
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`R_n`$独立标准正态；$`h\ge0`$、$`\beta,Q\gt 0`$、$`\gamma\ge0`$用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。
- 覆盖缺口：实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。
- 覆盖缺口：$`R_n`$独立标准正态；$`h\ge0`$、$`\beta,Q\gt 0`$、$`\gamma\ge0`$用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页371。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhlOU`：定义
- `MD.Ch08.forceKick`：定义
- `MD.Ch08.bathDamping`：定义
- `MD.Ch08.nhlStep`：定义
- `MD.Ch08.standardNormalSequence`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-NHLWeakStationary

印刷页 345–346 / PDF页 366–367。

### 1. 原文陈述

> The NHL method preserves the extended canonical distribution $`\rho_\beta\exp(-\beta\mu\xi^2/2)`$, by adding an OU thermostat in $`\xi`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def weakStationaryNHL (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (ρ : Phase n × ℝ → ℝ) : Prop :=
  probabilityDensity volume ρ ∧ ∀ f : Phase n × ℝ → ℝ,
    ContDiff ℝ ∞ f → HasCompactSupport f →
    (∫ z, nhlGenerator invm U β Q γ f z * ρ z) = 0
theorem nhlWeakStationary (invm : Vec n) (U : Vec n → ℝ) (β Q γ Z : ℝ)
    (hp : thermostatParameters invm β Q) (hγ : 0 < γ) (hZ : 0 < Z)
    (hU : ContDiff ℝ 2 U) (hi : Integrable (nhWeight invm U β Q))
    (hpart : ∫ z, nhWeight invm U β Q z = Z) :
    weakStationaryNHL invm U β Q γ (fun z ↦ nhWeight invm U β Q z/Z) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。
- 覆盖缺口：归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页366–367。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.weakStationaryNHL`：定义
- `MD.Ch08.nhlWeakStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.3-PreEquilibriumMeans

印刷页 354–355 / PDF页 375–376。

### 1. 原文陈述

> $`\bar\theta(t)=\int 2K\rho(q,p,\xi,t)\,d\omega\,d\xi`$, $`\bar\xi(t)=\int\xi\rho(q,p,\xi,t)\,d\omega\,d\xi`$, with normalized pre-equilibrium density $`\rho`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ∀ t, 0 ≤ t →
    probabilityDensity volume (ρ t) ∧
    Integrable (fun z : Phase n × ℝ ↦ kineticTwice invm z.1.2 * ρ t z) volume ∧
    Integrable (fun z : Phase n × ℝ ↦ z.2 * ρ t z) volume
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] preEquilibriumDensity要求所有逆质量严格为正，且对每个$`t\ge0`$，$`\rho\,t`$逐点非负、可积、积分为1，两项加权函数均Integrable。正质量与有限矩资格均已在当前Lean定义中出现。
- meanKineticTwice和meanBath本身是任意实数t上的总化积分定义；仅在上述资格及$`t\ge0`$下解释为有限平均。
- preEquilibriumDensity为历史名称：不要求NHL Fokker–Planck演化；本条范围仅为两平均的定义与资格。闭合动力学和局部稳定性不在所列Lean声明中。
- 覆盖缺口：任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：PASS；逐一审查meanKineticTwice、meanBath、preEquilibriumDensity：任意n，状态$`z=((q,p),\xi)`$，标准体积积分，动能权重$`\sum invm_i p_i^2`$与浴权重ξ均忠实。均值def对任意实数t总化；资格def仅对$`t\ge0`$要求概率密度、正逆质量和两项矩可积。已在范围内明确未形式化原页NHL Fokker–Planck演化及稳定性，因此不将定义误称完整动力学资格。旧issues是元数据过期，当前声明无该缺陷。未编译或补证明。
原文版：原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS。
修正版：当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定。
当前：网站复审PASS（Lean未改）。
原书疑点：[RESOLVED] 旧issues中的MISSING_MOMENT_INTEGRABILITY与当前摘录不符：两项Integrable及正逆质量均已补入；不能沿用旧缺失判定。；[COVERAGE_GAP] 原页明确要求ρ按扩展NHL系统的Fokker–Planck方程演化；当前定义未表达该演化，已按statement_scope缩限为任意随时间概率密度的有限平均，不将其称作完整预平衡动力学形式化。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页375–376。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.meanKineticTwice`：定义
- `MD.Ch08.meanBath`：定义
- `MD.Ch08.preEquilibriumDensity`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.4-VelocityRescaling

印刷页 355 / PDF页 376。

### 1. 原文陈述

> $`dq=p\,dt`$, $`dp=-\nabla U\,dt-\Psi(K)p\,dt+\sqrt{2k_B T\Phi(K)}p\,dW`$; $`\Psi=(2K-(1+N_d)k_B T)\Phi-2k_B TK\Phi'`$. $`\Phi(K)=\gamma_{VR}/(2K)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def rescalingPsi (Φ : ℝ → ℝ) (θ K : ℝ) : ℝ :=
  (2*K-((n:ℝ)+1)*θ)*Φ K-2*θ*K*deriv Φ K
def rescalingDrift (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (z.2, fun i ↦ -gradient U z.1 i-rescalingPsi (n:=n) Φ θ ((∑ j, z.2 j^2)/2)*z.2 i)
def rescalingNoise (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (0, fun i ↦ Real.sqrt (2*θ*Φ ((∑ j, z.2 j^2)/2))*z.2 i)
def originalRescalingPhi (γ K : ℝ) : ℝ := γ/(2*K)
def rescalingAdmissible (Φ : ℝ → ℝ) : Prop :=
  ContDiffOn ℝ ∞ Φ (Ioi 0) ∧ (∀ K, 0 < K → 0 < Φ K) ∧
  (∃ C ε : ℝ, 0 < ε ∧ ∀ K, 0 < K → K < ε → |K*Φ K| ≤ C) ∧
  ∃ C : ℝ, ∃ m : ℕ, ∀ K, 1 ≤ K → |Φ K| ≤ C*K^m
theorem rescalingPsi_original (γ θ K : ℝ) (hK : K ≠ 0) :
    rescalingPsi (n:=n) (originalRescalingPhi γ) θ K =
      (1-((n:ℝ)-1)*θ/(2*K))*γ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Φ在$`K\gt 0`$光滑正，$`K\Phi`$在0附近有界且多项式增长；原始Φ在$`K=0`$奇异，未声称全空间光滑扩散或遍历性。
- 覆盖缺口：实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页376。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.rescalingPsi`：定义
- `MD.Ch08.rescalingDrift`：定义
- `MD.Ch08.rescalingNoise`：定义
- `MD.Ch08.originalRescalingPhi`：定义
- `MD.Ch08.rescalingAdmissible`：定义
- `MD.Ch08.rescalingPsi_original`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.4-RescalingStationary

印刷页 355 / PDF页 376。

### 1. 原文陈述

> With these definitions, the method preserves the canonical probability density $`\rho_\beta`$. The book does not prove ergodicity.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ tsupport f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] hU要求U为$`C^2`$；$`\theta,Z\gt 0`$且hρ完整要求正则概率密度归一与可积。Φ仅在$`K\gt 0`$上光滑、正，另有$`K\Phi`$在0附近有界及Φ无穷远至多多项式增长的原页条件。
- [EXTRA] f为$`C^\infty`$紧支撑测试函数；当前havoid已对闭包支撑`tsupport f`量化，要求其中每点$`p\ne0`$。有限维紧性确保非空闭包支撑与$`p=0`$分离，K在该支撑上具有严格正下界。
- 二阶项中rescalingNoise Φ θ z对内层变量x保持固定，得到Itô Hessian项的一半，不包含噪声方向的导数。
- 结论仅为$`\int Lf\cdot\rho_\beta=0`$的局部弱驻定目标；未断言随机解存在、零动量边界控制、Markov半群不变性或遍历性。
- 覆盖缺口：闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：PASS；审查rescalingPsi、Drift、Noise、Admissible及完整rescalingStationary类型：$`M=I`$、$`n=N_d`$、$`\theta=k_B T`$，Ψ及漂移/扩散系数符号与因子正确；单个噪声给出秩一扩散。二阶项冻结噪声为正确Itô项。$`C^2`$势、Φ在$`K\gt 0`$的光滑正性与增长条件、正θ,Z、概率归一、$`C^\infty`$紧支撑及tsupport避零前提齐全。结论仅为$`\int Lf\rho_\beta=0`$；紧闭包支撑避零已修复旧报告的问题，Φ在$`K=0`$任意的总化值不妨碍该限定范围。完整不变性和遍历性缺口已明确。sorry不影响本次签名判定，未编译或补证明。
原文版：原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS。
修正版：当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定。
当前：网站复审PASS（Lean未改）。
原书疑点：[RESOLVED] 旧issues及extra_assumptions中“havoid只量化Function.support f/尚未实现tsupport”的描述已过期；当前完整Lean与依赖规格均明确使用tsupport f。；[COVERAGE_GAP] 零动量边界、全局随机过程及半群不变性尚未形式化；此项是明确披露的覆盖限制，不是当前远离边界的弱驻定声明错误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页376。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.rescalingStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.5-ThermostatEfficiency

印刷页 356–357 / PDF页 377–378。

### 1. 原文陈述

> efficiency = rate of convergence to equilibrium / rate of growth of perturbation of dynamics. Table 8.1 gives analytic lowest-order estimates; NHL has initially quadratic error.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2

def langevinRateEstimate (γ : ℝ) : ℝ := γ
def langevinEfficiencyEstimate : ℝ := 1
def originalRescalingRateEstimate (γVR : ℝ) : ℝ := γVR
def originalRescalingErrorEstimate (N : ℕ) (γVR t : ℝ) : ℝ := γVR/(N:ℝ)*t
def originalRescalingEfficiencyEstimate (N : ℕ) : ℝ := N
def nhlCriticalEfficiencyEstimate (N : ℕ) : ℝ := 2*N
def rescalingEfficiencyOrder (efficiency : ℕ → ℝ) : Prop :=
  efficiency =O[atTop] (fun N : ℕ ↦ (N : ℝ))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的$`O(N)`$含义；外引估计定理未证，经验曲线排除。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。
- $`\gamma\gt 0`$、$`\theta,Q\gt 0`$、$`N\gt 0`$用于物理解释；一般VR的$`O(N)`$给出确切渐近性质定义，没有声称任意Φ族满足它。
- 覆盖缺口：$`\gamma\gt 0`$、$`\theta,Q\gt 0`$、$`N\gt 0`$用于物理解释；一般VR的$`O(N)`$给出确切渐近性质定义，没有声称任意Φ族满足它。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页377–378。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.thermostatEfficiency`：定义
- `MD.Ch08.langevinErrorEstimate`：定义
- `MD.Ch08.rescalingRateEstimate`：定义
- `MD.Ch08.rescalingErrorEstimate`：定义
- `MD.Ch08.nhlRateEstimate`：定义
- `MD.Ch08.nhlErrorEstimate`：定义
- `MD.Ch08.langevinRateEstimate`：定义
- `MD.Ch08.langevinEfficiencyEstimate`：定义
- `MD.Ch08.originalRescalingRateEstimate`：定义
- `MD.Ch08.originalRescalingErrorEstimate`：定义
- `MD.Ch08.originalRescalingEfficiencyEstimate`：定义
- `MD.Ch08.nhlCriticalEfficiencyEstimate`：定义
- `MD.Ch08.rescalingEfficiencyOrder`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLS

印刷页 357–358 / PDF页 378–379。

### 1. 原文陈述

> $`dq=\xi M^{-1}p\,dt`$, $`dp=-\gamma p\,dt+\sigma M^{1/2}dW`$, $`d\xi=-[(M^{-1}p)\cdot\nabla U/\mu+\gamma'\xi]dt+\sigma'dZ`$; $`\sigma=\sqrt{2k_B T\gamma}`$, $`\sigma'=\sqrt{2k_B T\gamma'/\mu}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsDrift (invm : Vec n) (U : Vec n → ℝ) (Q γ γb : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, fun i ↦ -γ*z.1.2 i),
   -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q-γb*z.2)
def slsNoise (invm : Vec n) (β Q γ γb : ℝ) (j : Fin (n+1)) : Phase n × ℝ :=
  if hj : j.val < n then
    ((0, Pi.single ⟨j.val,hj⟩ (Real.sqrt (2*γ/(β*invm ⟨j.val,hj⟩)))), 0)
  else ((0,0), Real.sqrt (2*γb/(β*Q)))
def isSLSSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ γb : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec (n+1))
    (X : ℝ → Ω → Phase n × ℝ) (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧ 0 < γb ∧
  additiveSDE P (n+1) W X x0 (slsDrift invm U Q γ γb) (slsNoise invm β Q γ γb)
def slsDeterministic (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, 0), -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 完整SLS加性SDE积分解规格、噪声方向与确定性子场定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 全部n+1个Wiener坐标独立，Q、质量、温度及两摩擦参数正；总漂移和常噪声用实际积分方程解释。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页378–379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsDrift`：定义
- `MD.Ch08.slsNoise`：定义
- `MD.Ch08.isSLSSolution`：定义
- `MD.Ch08.slsDeterministic`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSBracketPrinted

印刷页 358 / PDF页 379。

### 1. 原文陈述

> $`D=(\xi p,-p,-p\cdot\nabla U-\xi)`$, $`D'=[D,Y_{N_c+1}]=(p,0,1)`$, $`[D',Y_i]=e_i`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsBathNoise : Phase n × ℝ → Phase n × ℝ := fun _ ↦ ((0,0),1)
theorem slsBracketPrinted (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((z.1.2,0),1) := by
  sorry
theorem slsBracket_corrected (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((-z.1.2,0),1) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只纠正第一括号；二次括号的整体符号不影响生成空间张成。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；括号首分量符号不一致。
修正版：原送审$`-p`$首分量_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF379：沿用Proposition8.2所用括号约定$`[D,Y]=DY\cdot D-DD\cdot Y`$，q分量应为$`-p`$；整体反号也不能同时保留热浴分量+1。；{"codes": ["ERRATUM_LIE_BRACKET_SIGN"], "detail": "slsBracketPrinted逐字对应原书$`(p,0,1)`$，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按$`\mathrm{VectorField.lieBracket}\,V\,W=DW\cdot V-DV\cdot W`$，常向量Yξ给$`[D,Y_\xi]=-\partial_\xi D=(-p,0,1)`$，故_corrected签名正确。反向括号会整体变为$`(p,0,-1)`$，不能仅靠约定得到原书$`(p,0,1)`$。二次括号的整体符号不影响张成。", "suggested_fix": "保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为$`-p`$。"}
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsBathNoise`：定义
- `MD.Ch08.slsBracketPrinted`：未证；原书疑误不证
- `MD.Ch08.slsBracket_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSHormander

印刷页 357–358 / PDF页 378–379。

### 1. 原文陈述

> All basis vectors are in the Lie algebra generated by the drift and the N_c+1 noise directions, so Hörmander holds.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem slsHormander (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    textbookHormanderAt
      (insert (slsDrift (fun _ ↦ 1) U 1 1 1)
        (Set.range (fun j : Fin (n+1) ↦ fun _ : Phase n × ℝ ↦ slsNoise (fun _ ↦ 1) 2 1 1 1 j))) z := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。
- 覆盖缺口：单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页378–379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsHormander`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSConservation

印刷页 358 / PDF页 379。

### 1. 原文陈述

> The deterministic part preserves volume and $`U(q)+\mu\xi^2/2`$, and the full dynamics preserves the extended canonical measure.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem slsDeterministic_stationary (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (slsDeterministic invm U Q) (nhWeight invm U β Q) := by
  sorry
theorem slsDeterministic_divergence (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (hU : ContDiff ℝ 2 U) (z : Phase n × ℝ) :
    textbookDivergence (slsDeterministic invm U Q) z = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 确定性SLS子场的局部驻定及零散度目标；完整SDE概率不变、独立第一积分未另证。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 完整权重含p高斯项，确定性p固定；只保留驻定及零散度，完整SDE概率不变和离散迭代收敛列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsDeterministic_stationary`：未证；缺大型理论
- `MD.Ch08.slsDeterministic_divergence`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSLeapfrog

印刷页 358–359 / PDF页 379–380。

### 1. 原文陈述

> $`q=q_0+\eta M^{-1}p`$; $`\dot\eta=\xi`$, $`\dot\xi=-\partial_\eta U(q_0+\eta M^{-1}p)`$. Leapfrog: $`\xi_{1/2}=\xi-h(M^{-1}p)\cdot\nabla U(q)/(2\mu)`$, $`q'=q+h\xi_{1/2}M^{-1}p`$, $`\xi'=\xi_{1/2}-h(M^{-1}p)\cdot\nabla U(q')/(2\mu)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsBathKick (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2-h*dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
def slsDriftStep (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i+h*z.2*invm i*z.1.2 i,z.1.2),z.2)
def slsLeapfrog (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  slsBathKick invm U Q (h/2) ∘ slsDriftStep invm h ∘ slsBathKick invm U Q (h/2)
def slsCoordinateField (i : Fin n) (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((Pi.single i (z.2*invm i*z.1.2 i),0), -invm i*z.1.2 i*gradient U z.1.1 i/Q)

/-- 原印η约化方程，ξ导数未含μ⁻¹；保留原书字面式。 -/
def slsReducedPrinted (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1)

/-- 修正版：恢复热浴质量因子1/Q，对应(8.36)的η方向导数。 -/
def slsReduced_corrected (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (Q : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1/Q)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [ERRATUM?] 原页379的η约化式确实印为$`\dot\xi=-\partial_\eta U`$，漏写了同页(8.36)及下一页kick公式中的$`\mu^{-1}`$；Printed版逐字保留，`_corrected`版单独恢复$`1/Q`$。
- 本条仅定义半kick–drift–半kick、逐坐标场及两种约化场；OU耦合、体积保持、二阶不变分布误差、精确求积与坐标变换定理均未形式化。
- [EXTRA] 物理域与总化导数/除法的区别见context_notation；这些限制不是现有def的Lean参数前提。
- [EXTRA] 物理解释另需$`Q=\mu\gt 0`$、各$`invm_i\gt 0`$及U可微；现有def不强制这些资格。
- 覆盖缺口：原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。
- 覆盖缺口：本条仅定义半kick–drift–半kick、逐坐标场及两种约化场；OU耦合、体积保持、二阶不变分布误差、精确求积与坐标变换定理均未形式化。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；六个def逐一审查均通过：slsBathKick、slsDriftStep、slsLeapfrog、slsCoordinateField对应原页算法，p始终固定；slsReducedPrinted忠实保留原印漏因子式，slsReduced_corrected恢复1/Q，符合(8.36)的方向导数。物理解释以$`Q\gt 0`$、正对角逆质量及相关可微性为域，def本身为全域总函数，无物理域或误差结论的量词断言。原印版忠实性PASS、修正版合理性PASS、算法定义PASS；条目总体NEEDS_HUMAN仅因原书$`\mu^{-1}`$遗漏待人工确认，不是这些Lean定义FAIL。
原文版：Printed忠实性PASS；一般μ下约化式漏$`\mu^{-1}`$待导师。
修正版：算法定义及恢复1/Q的_corrected网站PASS。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?][SOURCE_MISSING_MU_IN_REDUCTION] 原页η约化式缺$`\mu^{-1}`$，和(8.36)及两次kick不一致。原文及statement_latex保持不动，勘误须人工确认。；[DOMAIN_CLARIFICATION] $`Q\gt 0`$、正质量及可微性只是物理解释域说明，没有作为Lean def的前提；不把总函数误读为所有参数上的经典动力学定理。；已目视核对原页PDF379：η约化式确实漏$`\mu^{-1}`$，一般μ下应为$`\dot\xi=-\mu^{-1}\partial_\eta U`$；原印与Printed保留，_corrected恢复1/Q。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页379–380。

### 7. 状态与证明位置

- `MD.Ch08.slsBathKick`：定义
- `MD.Ch08.slsDriftStep`：定义
- `MD.Ch08.slsLeapfrog`：定义
- `MD.Ch08.slsCoordinateField`：定义
- `MD.Ch08.slsReducedPrinted`：定义
- `MD.Ch08.slsReduced_corrected`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSDoubleWell

印刷页 359 / PDF页 380。

### 1. 原文陈述

> The one-dimensional example has $`U(q)=(q^2-1)^2`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsDoubleWell (q : ℝ) : ℝ := (q^2-1)^2
theorem slsDoubleWell_nonneg (q : ℝ) : 0 ≤ slsDoubleWell q := sq_nonneg _
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 一维双阱势定义与非负性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 保留试验中的数学势函数；轨迹、直方图和采样优劣是经验观测，另列排除。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页380。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsDoubleWell`：定义
- `MD.Ch08.slsDoubleWell_nonneg`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

