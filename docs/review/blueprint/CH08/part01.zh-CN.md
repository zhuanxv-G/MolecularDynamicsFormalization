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

