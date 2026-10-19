# 第8章逐条审阅材料

正文103条；首轮74条通过、5条未通过、24条需人工判断。5条已按意见处理，修订稿尚未复审。
原文忠实性、修正版正确性与完整证明状态分别列出；原书疑误未因编译通过而视为正确。

## MD-8.1-CanonicalCorrelation

印刷页 329–330 / PDF页 350–351。

### 1. 原文陈述

> Av_β(φ)=∫φρ_β/∫ρ_β, ρ_β=exp(-βH); C_β(τ)=∫ A(z)·B(F^H_τ(z))ρ_β dω / ∫ A(z)·B(z)ρ_β dω. Thus C(0)=1.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 相关分母非零才有C(0)=1；向量观测的点积由标量乘积表示，其余分量情形未展开。
- [EXTRA/范围说明] 无需修改签名；将flow 0=id及分母非零也显式列入[EXTRA]，不要把标量特例说成已覆盖任意向量观测。

### 6. 审计结论（含网站结论）

网站首轮：PASS。任意可测空间E和测度μ上的实值ρ,A,B，相关函数分子为A(z)B(flow t z)ρ(z)，分母为同刻乘积；h0与hden正好保证零时归一。canonicalAverage、gibbsWeight、概率密度谓词、Fin n实坐标、点积和Fréchet坐标梯度均与摘录定义一致。标量特例及非零分母已披露；未证明混合极限。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

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

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1-HamiltonianStationary

印刷页 330 / PDF页 351。

### 1. 原文陈述

> The Liouvillian satisfies Lφ(H)=0; L is skew-adjoint. Hence any density which is a function of H will be preserved, including exp(-βH).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只桥接光滑Hamiltonian的Gibbs权重驻定方程；一般φ(H)、算子偏斜伴随及流的保测性未由本条覆盖。
- [EXTRA/范围说明] 保留有限范围说明；若以后声称完整覆盖原文，应另列一般φ(H)、形式伴随及流不变性。

### 6. 审计结论（含网站结论）

网站首轮：PASS。SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ；textbookJ为[0 I;-I 0]，向量场为J∇H，权重为exp(-βH)。对每个C² Hamiltonian及任意实β，结论是全空间div(ρF)=0，与所引项目先验类型一致。此局部驻定不要求β>0或可归一；一般φ(H)、算子伴随及全局流保测未由本签名覆盖，已有范围说明。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.hamiltonianField`：定义
- `MD.Ch08.hamiltonianGibbsStationary`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1-ExtendedDensity

印刷页 331 / PDF页 352。

### 1. 原文陈述

> ρ̃(q,p,ξ)=ρ_β(q,p)ρ̂(ξ). Then ∫g(q,p)ρ̃ ∝ ∫g(q,p)ρ_β.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 辅助密度归一、乘积积分可积；使用有限/σ有限测度条件。
- [EXTRA/范围说明] 保留[EXTRA]辅助归一、可积、SFinite条件；不要据此声称已证明遍历性或采样正确。

### 6. 审计结论（含网站结论）

网站首轮：PASS。E×B乘积权为ρ(x)a(y)；两个测度均SFinite，辅助因子积分等于1且被积函数在乘积测度上可积。结论为边缘积分精确相等，是原文比例式在归一条件下的正确特例；未要求ρ和a非负，故此签名是积分恒等式而非概率密度证明。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.extendedDensity`：定义
- `MD.Ch08.extendedAverage`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.1-NoseHoover

印刷页 331 / PDF页 352。

### 1. 原文陈述

> q̇=M⁻¹p, ṗ=-∇U(q)-ξp, μξ̇=pᵀM⁻¹p-N_dβ⁻¹.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- μ记为Q且Q>0，β>0，正质量，热浴变量ξ∈ℝ；总函数nhField配合资格谓词使用。
- [EXTRA/范围说明] 补充[EXTRA]采用对角质量、C¹经典解及全实时间解规格；局部解应用需另作区间版本。

### 6. 审计结论（含网站结论）

网站首轮：PASS。n对应N_d，invm为对角逆质量，Q对应μ。nhField三分量逐一对应(8.2)–(8.4)；kineticTwice确为pᵀM⁻¹p。thermostatParameters要求每个逆质量、β和Q为正。isNHSolution量化所有实t且带参数资格，是全实时间经典解规格；定义本身不宣称全局存在。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.thermostatParameters`：定义
- `MD.Ch08.kineticTwice`：定义
- `MD.Ch08.nhField`：定义
- `MD.Ch08.isNHSolution`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.1-NHDensitySplit

印刷页 332 / PDF页 353。

### 1. 原文陈述

> ρ̃=ρ_β exp(-βμξ²/2); f=f₁+f₂, L_f†=L_f₁†+L_f₂†; f₂ preserves ρ̃.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 指数为未归一权重；若称概率密度还要求有限正配分积分并归一化。
- [EXTRA/范围说明] 可保留现有范围；把热浴单独驻定未单列也写入覆盖缺口。权重未归一。

### 6. 审计结论（含网站结论）

网站首轮：PASS。nhWeight是exp[-β(K+U+Qξ²/2)]，nhBathField的q分量为0；点态分裂结论正确。正质量、β,Q及U∈C²下，完整场的局部Liouville驻定是正确命题。其热浴部分div F₂=-nξ、D logρ[F₂]=nξ相消；签名没有单列热浴驻定或伴随算子分裂，不能将其算作已形式覆盖。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhWeight`：定义
- `MD.Ch08.nhBathField`：定义
- `MD.Ch08.nhField_split`：已证
- `MD.Ch08.nhWeight_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.1-NHFirstIntegralPrinted

印刷页 333 / PDF页 354。

### 1. 原文陈述

> ds/dt=ξ. I_NH=H+μξ²/2+N_dβ⁻¹ ln s is conserved.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- s>0；原文版不证明，修正版另列；两版均保留原文H形式。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。nhIntegral逐项忠实于(8.8)。nhIntegralPrinted的hs忠实于原印s′=ξ，结论忠实于所印守恒声称；不因原书错误判忠实签名FAIL。但原印命题通常不成立：沿NH解，I′=(n/β)ξ(1/s−1)。nhIntegral_corrected只将hs改为s′=sξ，保持s>0、正参数、U∈C²和全实时间解量词，其零导数结论正确。
原文版：原印忠实性PASS；s′=ξ与log s守恒不相容，数学真值待导师。
修正版：原送审s′=sξ的_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。

### 7. 状态与证明位置

- `MD.Ch08.nhIntegral`：定义
- `MD.Ch08.nhIntegralPrinted`：未证；原书疑误不证
- `MD.Ch08.nhIntegral_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2-NHReversal

印刷页 333 / PDF页 354。

### 1. 原文陈述

> Nosé-Hoover is time-reversible: changing the sign of p and ξ is equivalent to reversing time.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站结论）

网站首轮：PASS。nhReversal仅翻转p和ξ且为对合。nhReversal_field右端符号是−DR·F：q速度取负，p与ξ速度不变；与F(Rz)逐分量一致。所有实参数和任意U均可作代数核对，不需ODE解存在条件；结论没有冒称全局流可逆。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhReversal`：定义
- `MD.Ch08.nhReversal_involutive`：已证
- `MD.Ch08.nhReversal_field`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2-NHTimestep

印刷页 333 / PDF页 354。

### 1. 原文陈述

> Nosé-Hoover Timestep Map: drift(h/2), damped force(h/2), ξ-update(h), damped force(h/2), drift(h/2). c(t,ξ)=(1-e^{-tξ})/ξ=t-t²ξ/2+⋯.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- c在ξ=0处取连续延拓t；系数Taylor级数与二阶全局误差未由单步定义证明。
- [EXTRA/范围说明] 保留零点连续延拓[EXTRA]及Taylor/收敛阶覆盖缺口；有效物理域仍是正质量、β,Q。

### 6. 审计结论（含网站结论）

网站首轮：PASS。c(t,ξ)在ξ≠0时为(1−exp(−tξ))/ξ，在ξ=0取t。drift、带阻尼force、feedback五段更新参数依次h/2,h/2,h,h/2,h/2，符合原页原位更新顺序；函数复合从右至左执行，回文顺序无歧义。反馈使用已经更新的动量。dampedCoefficient_zero仅断言可去奇点值，未证明Taylor展开和二阶误差。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.dampedCoefficient`：定义
- `MD.Ch08.nhDrift`：定义
- `MD.Ch08.nhKick`：定义
- `MD.Ch08.nhFeedback`：定义
- `MD.Ch08.nhStep`：定义
- `MD.Ch08.dampedCoefficient_zero`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2-NHTimestepReversible

印刷页 333 / PDF页 354。

### 1. 原文陈述

> R∘G_h∘R=G_h^{-1}, R(q,p,ξ)=(q,-p,-ξ).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 逆映射以负步长映射及LeftInverse表达；不假设算法可逆作为结论的前提。

### 6. 审计结论（含网站结论）

网站首轮：PASS。对每个invm,U,β,Q,h，反演共轭等于负步长映射，负步长为原映射左逆，均正确。每个子步具有相反步长逆，回文复合保证结论；将h替换为−h即可获得另一侧逆。因此LeftInverse加全h量词足够支持原文逆映射式，不存在假设可逆来证明可逆的问题。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhStep_reversible`：未证；缺大型理论
- `MD.Ch08.nhStep_inverse`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2.1-NoseHamiltoniansPrinted

印刷页 334 / PDF页 355。

### 1. 原文陈述

> H_N= p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+(N_d+1)k_BT ln s; H_NP=s[H_N-E_N]=s[p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+N_d k_BT ln s-E_N].

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 物理定义域s>0、β,Q及质量正；总函数在此域外不作物理解释。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。noseHamiltonian的对数系数(n+1)/β与原页第一式一致；npHamiltonian的n/β与(8.9)展开一致。nosePoincarePrinted忠实保留两个原印公式间不相容的等号。nosePoincare_corrected显式减去log s/β，代数正确；其无正参数/正s假设是Lean总函数上的代数恒等式，不代表物理域扩展。
原文版：两个原印H_N的对数系数不一致；Printed忠实性PASS。
修正版：原送审显式减log s/β的代数修正版PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。

### 7. 状态与证明位置

- `MD.Ch08.noseHamiltonian`：定义
- `MD.Ch08.npHamiltonian`：定义
- `MD.Ch08.nosePoincarePrinted`：未证；原书疑误不证
- `MD.Ch08.nosePoincare_corrected`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2.1-NPEquations

印刷页 334 / PDF页 355。

### 1. 原文陈述

> q̇=M⁻¹p̃/s, p̃̇=sF, ṡ=sp_s/μ, ṗ_s=p̃ᵀM⁻¹p̃/s²-N_d k_BT-ΔH_N.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- ΔH采用(8.9)展开内的N_d版本；β,Q>0及s>0为有效域；尚未桥接实际Hamiltonian梯度。
- 已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。
- [EXTRA] npValidDomain明确列有效物理域；使用npField作NP方程时必须另具此资格，总函数自身不强制。
- 覆盖缺口：NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。四个分量形式逐项匹配(8.10)–(8.13)，s为z.2.1、π为z.2.2，力为−∇U。有效域β,Q,s>0与对角逆质量已说明，但没有在总函数def中强制。delta明确取(8.9)展开的n/β版本；原页却把ΔH_N定义成先前H_N−H_N⁰，若沿用(n+1)/β版本就不同。因此这是合理而已披露的展开式选择，仍需人工解决原书同名歧义，不判签名FAIL。
原文版：四个分量形式匹配；n/β与(n+1)/β同名歧义待导师。
修正版：原送审n/β展开选择合理；本轮命名delta与有效域谓词待复审。
当前：待复审 / EAUDIT01。
原书疑点：[ERRATUM?] ΔH_N采用(8.9)展开中的N_d版本，与前一定义(N_d+1)版本不同，须明确区分。；已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。

### 7. 状态与证明位置

- `MD.Ch08.npDeltaN_corrected`：定义
- `MD.Ch08.npValidDomain`：定义
- `MD.Ch08.npField`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2.1-NPtoNH

印刷页 335 / PDF页 356。

### 1. 原文陈述

> p=p̃/s, ξ=p_s/μ; ṡ=sξ, ξ̇=μ⁻¹(pᵀM⁻¹p-N_d k_BT-ΔH_N). The perturbation vanishes along the exact solution.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 明确零能量面及s>0；零能量守恒本身未假作普遍结论。
- [EXTRA/范围说明] 保留[EXTRA]全时零能量与s>0；标明这是采用第11条展开式定义的NP版本。原文“沿精确解消失”须理解为正确初始化的零能量解。

### 6. 审计结论（含网站结论）

网站首轮：PASS。npProjection保持q，将p̃除以s，将π除以Q。对正参数、全实时间NP经典解、所有时间s>0及H_NP=0，delta=H_NP/s=0；商求导给出p′=−∇U−ξp，ξ′=(pᵀM⁻¹p−n/β)/Q，故结论isNHSolution包括参数资格与全部NH方程。显式全时零能量前提足以成立，未把“任意NP解均零能量”当结论。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.npProjection`：定义
- `MD.Ch08.npProjection_equations`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.1.2.1-NPShadowDensity

印刷页 335 / PDF页 356。

### 1. 原文陈述

> H̃_h=H_NP+h²H_[2]+O(h⁴); ρ̃=ρ_βζ(q,p,h)+O(h⁴). Canonical averages are approximated by (ν+1)⁻¹Σg_nζ_n⁻¹+O(h⁴).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。
- [EXTRA/范围说明] 补充[EXTRA]：这里Phase n是示意状态域，未桥接实际扩展NP域Phase n×(ℝ×ℝ)；仅逐点O(h⁴)，非一致估计。实际重加权需ζ_k≠0；有限样本统计误差不能并入单独O(h⁴)。
- 覆盖缺口：三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。
- 覆盖缺口：[EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。fourthOrderRemainder正C、正ε与∀|h|<ε的界正确表达零点四阶大O；两个ansatz均为逐状态命题，常数可依赖z。有限平均包含k=0,…,N共N+1项，除以实数N+1。它们只是谓词和公式定义，没有声称存在修正Hamiltonian/密度或有限采样误差为O(h⁴)，范围已明确。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.fourthOrderRemainder`：定义
- `MD.Ch08.correctedFiniteAverage`：定义
- `MD.Ch08.npShadowAnsatz`：定义
- `MD.Ch08.npDensityAnsatz`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2-GeneralThermostat

印刷页 336 / PDF页 357。

### 1. 原文陈述

> ż=J∇H, J constant skew-symmetric; ż=J∇H+Φ(ξ,z), ξ̇=g(ξ,z).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- J为常矩阵，Jᵀ=-J；z、ξ为实向量，光滑资格在结论中给出。
- [EXTRA/范围说明] 补充[EXTRA]辅助维数k可独立于n；不要把任意J的总函数定义视为已满足Hamiltonian资格或已驻定。
- 覆盖缺口：常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。

### 6. 审计结论（含网站结论）

网站首轮：PASS。generalThermostat定义在Vec n×Vec k，使用常实矩阵J、实值H及同状态上的Φ,g，返回(J∇H+Φ,g)；skewMatrix确为Jᵀ=−J。把原文输入顺序(ξ,z)改为(z,ξ)一致。允许k独立于n是已选的一般化，应明确[EXTRA]；def本身不带反对称假设，由资格谓词及后续定理限定。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.generalThermostat`：定义
- `MD.Ch08.skewMatrix`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2.1-ContinuityProductRule

印刷页 336–337 / PDF页 357–358。

### 1. 原文陈述

> ∂tρ=-div_z[ρ(J∇H+Φ)]-div_ξ(ρg)=L†ρ; the product rule gives four terms W₁+W₂+W₃+W₄.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。
- [EXTRA/范围说明] 保留总散度展开的范围说明；四项分块恒等式和完整连续性方程不得算作本条已形式覆盖。

### 6. 审计结论（含网站结论）

网站首轮：PASS。F是整个乘积空间上的任意向量场，ρ实值，二者仅需在给定z可微。continuityRHS为−div(ρF)，所断言−Dρ[F]−ρ div F符号和乘积次序正确，依赖项目textbookDivergence_density类型精确匹配。把F代入一般热浴场并按两个坐标块拆开可得四项，但本声明未实际列四项、未陈述时间依赖PDE解。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.continuityRHS`：定义
- `MD.Ch08.continuity_productRule`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2.1-ThermostatCriterion

印刷页 337 / PDF页 358。

### 1. 原文陈述

> - [∇z-β∇zH]·Φ + βξᵀμ⁻¹g - ∇ξ·g=0 is the fundamental equation for deterministic thermostats.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 原文μ_i在指数中是热质量，统一写Q_i；矩阵μ⁻¹的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。
- [EXTRA/范围说明] 补充明确记号字典Q_i=原文标量μ_i，原文矩阵μ⁻¹=diag(Q_i)，矩阵μ=diag(1/Q_i)。若原书 intended μ=diag(μ_i)，则该矩阵记号需[ERRATUM?]人工确认。

### 6. 审计结论（含网站结论）

网站首轮：PASS。thermalWeight用exp[−β(H+ΣQ_i ξ_i²/2)]。驻定等价条件含−div_z Φ+βDH[Φ]+βΣQ_i ξ_i g_i−div_ξ g=0，符号、权重系数和全状态量词均正确；J常反对称、H∈C²、Φ,g∈C¹及正β,Q均明确。原文同时写Σμ_iξ_i²和ξᵀμ⁻¹ξ，须把矩阵μ⁻¹解释为diag(Q_i)，而非把同一个对角矩阵及其逆混用；代码选定标量质量系数，解释已披露。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.thermalWeight`：定义
- `MD.Ch08.thermostatCriterion`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2.1-Examples81and82

印刷页 337–338 / PDF页 358–359。

### 1. 原文陈述

> Example 8.1 Φ=-ξ(0,p), g=μ⁻¹(p·∇pH-N_d k_BT). Example 8.2 Φ=ξG(z), g=μ⁻¹[∇H-k_BT∇]·G. Configurational choice G=(∇qK,0).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。
- generalizedFeedback/configurationalFeedback忠实保留原式；corrected将Φ改为−ξG。构型反馈在正号耦合下同样须反号。
- 覆盖缺口：原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。

### 6. 审计结论（含网站结论）

网站首轮：FAIL。generalizedFeedback和configurationalFeedback逐项忠实转写例8.2与构型公式；但与正号耦合Φ=+ξG及高斯exp[−β(H+Qξ²/2)]组合时，generalizedFeedback_stationary是错误命题，不能因有sorry而忽略其签名问题。令A=βDH[G]−div G，驻定条件变成ξA+βQξg=2ξA，而不是0。原书例8.2的正号组合本身也有数学疑误，须NEEDS_HUMAN；额外驻定定理没有Printed/literal标识，故该签名判FAIL。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：待复审 / EAUDIT01。
原书疑点：已目视核对原页PDF358–359：例8.2确实印为正号耦合与正反馈，驻定声称有符号疑误，不是转录错误。；[ERRATUM?] 例8.2正号耦合与所印正反馈不能保持所列高斯Gibbs权；额外generalizedFeedback_stationary签名错误，见本次审校反例。

### 7. 状态与证明位置

- `MD.Ch08.generalizedFeedback`：定义
- `MD.Ch08.configurationalFeedback`：定义
- `MD.Ch08.generalizedFeedback_stationaryPrinted`：未证；原书疑误不证
- `MD.Ch08.generalizedFeedback_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2.1-TemperatureIdentity

印刷页 338 / PDF页 359。

### 1. 原文陈述

> ∫ divG ρ dω = -∫∇ρ·G dω = β∫∇H·G ρ dω. T=k_B⁻¹〈∇H·G〉/〈divG〉.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求k_B>0、分母非零。
- [EXTRA/范围说明] 保留紧支撑替代衰减的[EXTRA]；若解释归一平均或推导T，须另外有有限正配分函数、kB>0、分母非零及β⁻¹=kB T。

### 6. 审计结论（含网站结论）

网站首轮：PASS。Vec n上的Lebesgue积分；H∈C²、G∈C¹且紧支撑，正β。紧支撑使Gρ及其散度相关被积函数具有紧支撑，足够保证积分分部边界项为零；结论∫divG ρ=β∫DH[G]ρ正确，不需全空间配分函数有限。phaseTemperature为numerator/(kB*denominator)，等于原页比值，但只是总函数定义，没有证明等于给定物理T。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.temperatureIdentity`：未证；缺大型理论
- `MD.Ch08.phaseTemperature`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2.1-Proposition81

印刷页 338–339 / PDF页 359–360。

### 1. 原文陈述

> Two thermostats preserving a(ξ)ρ_β and b(η)ρ_β can be added and preserve a(ξ)b(η)ρ_β.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。
- 覆盖缺口：两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。
- 覆盖缺口：两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS（所声明的两个实标量热浴、局部Liouville驻定范围）。n为任意自然数；物理空间是(Fin n⊕Fin n)→ℝ，J的分块为(0,I;-I,0)，故HamiltonianVectorField确为J∇H。H∈C²、φ₁/φ₂/g₁/g₂/a/b∈C¹；β,c任意实数。两前提分别是(z,ξ)与(z,η)上a(ξ)c exp(-βH)和b(η)c exp(-βH)的加权散度为零。合并场在((z,ξ),η)上为((J∇H+φ₁(z,ξ)+φ₂(z,η),g₁(z,ξ)),g₂(z,η))，结论密度恰为a(ξ)b(η)c exp(-βH)，没有错误地把Gibbs因子平方。与原命题的辅助变量次序差异只是参数重排。[EXTRA]光滑性为合理分析资格；非负、归一化、全局流存在和多维辅助变量均已明确排除，故不冒称不变概率测度。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.proposition81`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.2.2-NHChains

印刷页 339–340 / PDF页 360–361。

### 1. 原文陈述

> The Nosé–Hoover chain (8.16)–(8.21) preserves ρ_β exp(-βΣμ_iξ_i²/2).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
- [EXTRA] M⁻¹=diag(invm)，∀i,invm_i>0，N_d=n；U∈C²。仅形式化正对角质量、无约束情形。
- 覆盖缺口：任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。
- 覆盖缺口：链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS（对角质量、N_d=n的特例；JSON范围须按审校修正）。k>0，β>0，Q_j>0，invm_i>0，U∈C²均在驻定定理中量化。j=0给出(pᵀM⁻¹p-n/β)/Q₀；j>0给出(Q_{j-1}ξ_{j-1}²-1/β)/Q_j；非末端减ξ_jξ_{j+1}，末端无此项。物理分量是q̇_i=invm_i p_i、ṗ_i=-∂_iU-ξ₀p_i；密度为exp[-β(动能+U+ΣQ_jξ_j²/2)]。零起始索引、Q_j对应μ_{j+1}，β⁻¹=k_BT，全部符号和末端边界相符；k=1自然退化为单NH。k=0只允许定义场，不在驻定结论量词中。结论为加权散度零，未声称遍历性。sorry不影响本次签名PASS。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhChainField`：定义
- `MD.Ch08.nhChain_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.3-ArrheniusRate

印刷页 342 / PDF页 363。

### 1. 原文陈述

> k ∼ A e^{-ΔE/(k_BT)}.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。
- 覆盖缺口：Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。
- 覆盖缺口：A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS。附件5页确为k∼A exp(-ΔE/(k_BT))，不是精确动力学定理。arrheniusRate仅定义右侧模型函数，四参数均为实数；非负定理仅要求A≥0，利用exp恒正，对任何ΔE,kB,T均成立。JSON已说明物理解释取kB,T>0且不宣称渐近率定理；该解释域没有被误写为非负定理的必要条件。零分母的Lean全定义值不能作物理解释，但不影响此代数非负结论。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.arrheniusRate`：定义
- `MD.Ch08.arrheniusRate_nonneg`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4-AdditiveThermostatSDE

印刷页 342–343 / PDF页 363–364。

### 1. 原文陈述

> dq=M⁻¹pdt; dp=-∇Udt-Φ(ξ,z)-Γpdt+√(2k_BT)M^{1/2}Γ^{1/2}dW; dξ=gdt-Γ̂ξdt+√(2k_BT)M̂^{1/2}Γ̂^{1/2}dŴ. All Wiener coordinates are independent.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 常噪声积分SDE模板与正对角物理质量的统一恒温器解规格；同一n+k维独立Wiener、分块噪声、两组协方差和漂移质量已绑定。未含一般非对角物理质量、存在唯一性或不变律。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 加性噪声用独立Wiener路径增量的精确积分方程；漂移可积、路径连续且适应自然历史。完整矩阵噪声给因子B和涨落耗散资格，物理/热浴两组坐标共同独立。
- [EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。
- [EXTRA]漂移采用M⁻¹=diag(invm)的正对角、无约束特例；现有定义尚未把独立的M参数绑定到invm。
- [ERRATUM?]原矩阵平方根噪声须补半正定性及协方差相容条件。fluctuationDissipation规定BBᵀ=(2/β)ΓM，对称M、Γ下还强制ΓM=MΓ，是明确限制后的修正资格。
- 完整两组SDE需要一个统一的n+k维独立Wiener向量、分块噪声因子、对应漂移及两组协方差约束；本条尚无这项组装声明。
- 覆盖缺口：[EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。
- 覆盖缺口：完整两组SDE需要一个统一的n+k维独立Wiener向量、分块噪声因子、对应漂移及两组协方差约束；本条尚无这项组装声明。

### 6. 审计结论（含网站结论）

网站首轮：FAIL。FAIL源于完整模型对象与参数关联缺失，非sorry。independentWiener本身正确地要求概率测度、逐坐标标准Brownian及全路径独立；additiveSDE本身是确定初值、连续路径、自然噪声历史可测、可积漂移和非负时刻积分方程的合理模板。stochasticThermostatDrift符号正确；原书(8.23)的-Φ项漏写dt确实印在原页，statement_latex忠实保留，不能把它误判为转录漏字。作为漂移定义加入dt解释是合理勘误，须注明。四个组件没有共同量化和连接成具体两组SDE；额外的一般M协方差谓词也未与对角漂移连接，故不能认证所称完整模型。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：待复审 / EAUDIT01。
原书疑点：已目视核对原页PDF364：(8.23)的−Φ项确实漏dt；漂移解释补dt。矩阵不交换时原平方根噪声与驻定协方差未必相容。；[ERRATUM?]原书矩阵噪声的对称性不足以保证Gibbs相容。；现有声明只是未组装的定义组件。

### 7. 状态与证明位置

- `MD.Ch08.independentWiener`：定义
- `MD.Ch08.additiveSDE`：定义
- `MD.Ch08.stochasticThermostatDrift`：定义
- `MD.Ch08.fluctuationDissipation`：定义
- `MD.Ch08.thermostatBlockNoise`：定义
- `MD.Ch08.stochasticThermostatSolution`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4-OUStationarityPrinted

印刷页 343–344 / PDF页 364–365。

### 1. 原文陈述

> The OU momentum process with drift -Γp and noise √(2k_BT) M^{1/2}Γ^{1/2} preserves exp(-βpᵀM⁻¹p/2). The displayed diffusion term is β⁻¹Tr(Γ^{1/2}M^{1/2}[βM⁻¹ppᵀM⁻¹-M⁻¹]M^{1/2}Γ^{1/2})ρ̄=-drift.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。逐声明：ouFokkerPlanck PASS，采用正div(ρΓp)对应漂移-Γp，扩散项为½ΣC_ij∂_i∂_jρ；ouStationarity_corrected PASS，β>0、M正定、Γ半正定与BBᵀ=(2/β)ΓM使M、Γ交换，Gaussian协方差M/β满足Lyapunov方程，结论是∀p局部Fokker–Planck算子为零。diffusionPrinted是原错误等式M=Γ=1,p=0的忠实标量实例，忠实性PASS、原书真值NEEDS_HUMAN。diffusionPrinted_counterexample PASS。没有把局部算子恒零升级为全局过程存在或唯一不变律；没有因sorry判FAIL。整条因原书疑误NEEDS_HUMAN。
原文版：diffusionPrinted忠实性PASS；原印β因子和矩阵相容性待导师。
修正版：原送审ouStationarity_corrected及标量反例PASS；仅局部算子恒零。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。；[ERRATUM?]保留原所印等式及β=2反例；修正版的BBᵀ=(2/β)ΓM为明确额外资格，在对称情形蕴含交换性。

### 7. 状态与证明位置

- `MD.Ch08.ouFokkerPlanck`：定义
- `MD.Ch08.ouStationarity_corrected`：未证；缺大型理论
- `MD.Ch08.diffusionPrinted`：未证；原书疑误不证
- `MD.Ch08.diffusionPrinted_counterexample`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4-LiftedThermostat

印刷页 344–345 / PDF页 365–366。

### 1. 原文陈述

> dz=F(z)dt+ξG(z)dt, dξ=g(z)dt-γξdt+σdW. The lifted fields are b₀=(F+ξG,g-γξ), b₁=(0,σ).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 真实Wiener、适应性和可积性由additiveSDE给出；σ≠0在Hörmander结论中单列。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS（确定初值、t≥0的实际加性Wiener积分解规格）。F,G:ℝⁿ→ℝⁿ，g:ℝⁿ→ℝ，γ,σ任意实数；P、W、X、x₀全部显式量化。D17展开给漂移(F(z)+ξG(z),g(z)-γξ)，唯一噪声列为(0,σ)，恰对应(8.25)–(8.26)。D14赋予W标准Brownian、连续路径、自然历史可测性以及漂移积分方程。σ=0允许定义退化方程，不与本条冲突；σ≠0只应在需要非退化噪声的Hörmander结论出现。没有暗含SDE解存在或遍历性。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.liftedThermostat`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4-Proposition82

印刷页 344–345 / PDF页 365–366。

### 1. 原文陈述

> If the Lie algebra generated by F and G in (8.25) spans R^m, then the Hörmander condition holds for (8.25)–(8.26).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- 覆盖缺口：所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。
- 覆盖缺口：Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。Printed忠实性PASS、原命题数学资格NEEDS_HUMAN；corrected PASS。n任意，F/G/g均C∞，γ任意实数，w是ℝⁿ×ℝ中的任意点，hspan在w.1点要求{F,G}的Lie点值张成全空间，结论在同一提升点w要求{b₀,b₁}张成全空间。原文“spans ℝᵐ”以点态方式表达，适用于相应点。σ≠0时可从b₁得到垂直方向，从[b₀,b₁]得到G的水平提升，再通过光滑系数组合得到F的水平提升；迭代括号的点值张成保留全部方向。改正的前提不是假定目标结论，也未引入无关遍历性结论。
原文版：Printed忠实性PASS；σ=0使原结论失效。
修正版：原送审C∞且σ≠0的_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。；[ERRATUM?]σ=0反例；Printed仅作忠实记录，corrected在σ≠0下通过。

### 7. 状态与证明位置

- `MD.Ch08.proposition82Printed`：未证；原书疑误不证
- `MD.Ch08.proposition82_corrected`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-NHL

印刷页 345–346 / PDF页 366–367。

### 1. 原文陈述

> dq=M⁻¹pdt, dp=-∇Udt-ξpdt, dξ=μ⁻¹[pᵀM⁻¹p-N_dk_BT]dt-γξdt+√(2k_BTγμ⁻¹)dW. Quadratic specialization: U=qᵀAq/2, M=I.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Q>0、β>0、γ>0及单独立Wiener；二次系统A对称正定、M=I；高维无约束自由度n。
- [EXTRA/覆盖缺口] invm_i,β,Q,γ均正；不宣称覆盖一般M或已把isNHLSolution特化到正定二次势(8.30)–(8.32)。原印重缩放疑误另列。
- [EXTRA]M⁻¹=diag(invm)，N_d=n；一般非对角M未覆盖。harmonicPotential本身未要求A对称正定，相关物理资格在应用时另加。
- 覆盖缺口：仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。
- 覆盖缺口：[EXTRA]M⁻¹=diag(invm)，N_d=n；一般非对角M未覆盖。harmonicPotential本身未要求A对称正定，相关物理资格在应用时另加。

### 6. 审计结论（含网站结论）

网站首轮：FAIL。FAIL限于其“全SDE/二次专门化”覆盖声明；三个对象的自身公式正确。nhlDrift展开为((diag(invm)p,-∇U-ξp),(Σinvm_i p_i²-n/β)/Q-γξ)。isNHLSolution明确invm_i,β,Q,γ均正，噪声只作用于ξ且幅度sqrt(2γ/(βQ))，对应μ=Q、k_BT=1/β及无约束N_d=n的正对角质量特例。harmonicPotential(A,q)=qᵀAq/2对任意实矩阵有定义；仅A对称时梯度等于Aq。当前声明没有一般M对象，也没有以invm=1和A正定把SDE专门化为(8.30)–(8.32)的规格。原书重缩放另列NEEDS_HUMAN，不把原书错误归咎于Lean公式。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：待复审 / EAUDIT02。
原书疑点：已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p不产生单位质量方程；正确方向相反并须同步变换势。；[ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。

### 7. 状态与证明位置

- `MD.Ch08.nhlDrift`：定义
- `MD.Ch08.isNHLSolution`：定义
- `MD.Ch08.harmonicPotential`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-Lemma81

印刷页 347 / PDF页 368。

### 1. 原文陈述

> C_k=(A^{k-1}p,A^kq), D_k=(A^kq,-A^kp) belong to the Lie algebra generated by F=(p,-Aq), G=(0,p), k=1,2,...

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Lean索引k=0对应原文k=1；完整实际线性场、导数括号与End括号约定均摘录；生成子代数在相反括号下相同。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS。对任意n、任意实n×n矩阵A及k∈ℕ，结论同时要求C_A(k)、D_A(k)属于由F=(p,-Aq)、G=(0,p)生成的End Lie子代数，未把任一归属放进前提。D31/D32给C_A(k)=(A^k p,A^{k+1}q)、D_A(k)=(A^{k+1}q,-A^{k+1}p)，正好对应原文C_{k+1},D_{k+1}。D29/D30与原F/G一致。End的交换子AB-BA和向量场导数括号对线性场至多差一负号；对Lie子代数生成与归属没有影响。原上下文使用正定A，Lean推广为任意A仍正确：该归属由纯代数括号生成，不需谱条件。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.lemma81`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-Proposition83

印刷页 347–348 / PDF页 368–369。

### 1. 原文陈述

> If A is symmetric positive definite with distinct eigenvalues, the 2N_c vectors C₁,D₁,...,C_Nc,D_Nc are linearly independent on D=R^{2Nc}\⋃V_k.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS（签名与正确命题一致；原证明疑误另在json_review中NEEDS_HUMAN）。A.PosDef在实域提供对称正定，hdist是全部n个本征值的单射性。z∈D严格要求每一模态(q̂_i,p̂_i)不同时为零。Family的Fin n⊕Fin n族是C₁..C_n和D₁..D_n，和书中交错顺序仅差排列。结论LinearIndependent ℝ同时消去两组任意实系数，并非仅证明其中一组。每个模态的两列系数矩阵行列式为-λ_i(p̂_i²+λ_i q̂_i²)，由λ_i>0和域条件非零，继而两个次数<n的多项式在n个不同本征值上为零，均恒零。因此项目结论合理且完整；不能照抄书中未处理第二组系数的论证来替代这一检查。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：[ERRATUM?]原证明下标、模态标量式及第二组系数消去需核对；命题与Lean签名正确。

### 7. 状态与证明位置

- `MD.Ch08.proposition83`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-Theorem81

印刷页 346–348 / PDF页 367–369。

### 1. 原文陈述

> If A is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on D×R.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
- [EXTRA]θ=k_BT，Q=μ；corrected的Q,θ,γ>0是物理资格，括号结论本身只额外需要σ≠0。σ在此是独立实参数，未声明满足NHL涨落耗散幅度。
- [EXTRA] 当前_corrected为σ独立非零的括号结论；如解释为物理NHL，还须σ²=2γθ/Q。未推到全局遍历性。
- 覆盖缺口：所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。逐声明：theorem81Printed按所印定理字面保留正定、不同本征值、D×ℝ及任意Q,θ,γ,σ，字面对应PASS，但未限定参数的数学真值NEEDS_HUMAN。theorem81_corrected PASS：A正定、谱单射、Q,θ,γ正、σ非零，w.1∈D；结论是同一点w的实际迭代Lie括号张成全空间。D29/D30及textbookNHLDrift展开为((p,-Aq-ξp),Q⁻¹(Σp_i²-nθ)-γξ)，噪声是(0,σ)。负号G与书中正G生成同一个Lie代数。结论强度限于包含漂移的Hörmander点态条件，不是解存在、转移核光滑、可达性或几何遍历性。corrected将σ视为独立非零参数是有效的更一般括号结论，物理NHL需再作σ=sqrt(2γθ/Q)专门化。
原文版：Printed忠实性PASS；缺非零噪声资格。
修正版：原送审正参数与σ≠0的_corrected点态括号结论PASS，非全局遍历性。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。；[ERRATUM?]字面版含σ=0反例；物理上下文的参数资格与字面版分开。原质量重缩放与所引证明的局部排印/推导疑误亦应保留。

### 7. 状态与证明位置

- `MD.Ch08.theorem81Printed`：未证；原书疑误不证
- `MD.Ch08.theorem81_corrected`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-ZeroModeInvariant

印刷页 346 / PDF页 367。

### 1. 原文陈述

> V_k={ (q,p) | u_k·q=0, u_k·p=0 } is an invariant submanifold. D=R^{2Nc}\⋃V_k.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 任意紧时间区间上的实际模态ODE；连续随机热浴路径可逐路径应用，不额外声称SDE解存在。

### 6. 审计结论（含网站结论）

网站首轮：PASS。PASS。modeDomain_complement对任意实对称A陈述D=(⋃_{i:Fin n}V_i)ᶜ，D33/D34与V_i定义都使用同一正交本征坐标，因此量词、补集所在的完整(q,p)空间与原文一致。zeroMode_invariant对任意i、任意实a,b、任意连续q,p,ξ在Icc a b上，要求Ico a b内右侧导数q̇=p、ṗ=-Aq-ξp，以及a时零模态；结论为该闭区间所有t保持同一零模态。这是原不变性沿每条连续热浴轨道的正确表达；所需ODE正则性写全，不暗含SDE解存在。a>b时结论区间空，a=b时由初始条件成立，端点量词无遗漏。原文假定正定、谱简单；本结论只需对称性，是合理且正确的推广。未额外声称形式化了光滑子流形结构或D的全局随机流不变性。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.modeDomain_complement`：已证
- `MD.Ch08.zeroMode_invariant`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-NHLGenerator

印刷页 348 / PDF页 369。

### 1. 原文陈述

> L_NHL f=M⁻¹p·∇qf-∇U·∇pf-ξp·∇pf+[μ⁻¹(pᵀM⁻¹p-N_dk_BT)-γξ]∂ξf+k_BTγμ⁻¹∂ξ²f.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 采用实际一阶、二阶Fréchet导数；原文省略f的-ξp·∇p理解为作用于f；Q,β,γ须正。

### 6. 审计结论（含网站结论）

网站首轮：PASS。Vec=Fin n→ℝ，Phase=Vec×Vec；invm表示对角逆质量，β⁻¹=k_BT，Q=μ，n=N_d（无约束）。展开nhField/nhlDrift得到原页所有一阶项；常噪声B=(0,√(2γ/(βQ)))的二阶项为γ/(βQ)∂ξ²。nhlLyapunov采用M=I；geometricDriftBound完整含V>0及α,δ>0。它们是总定义，正参数及合适测试函数是物理解释的限定，而非定义自动保证。原页−ξp·∇p漏f，JSON补f已在extra_assumptions披露。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.additiveGenerator`：定义
- `MD.Ch08.nhlGenerator`：定义
- `MD.Ch08.nhlLyapunov`：定义
- `MD.Ch08.geometricDriftBound`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-LyapunovCalculation

印刷页 348–349 / PDF页 369–370。

### 1. 原文陈述

> For M=I, φ=‖p‖²/2+U+μ(ξ-a)²/2, Lφ=-a‖p‖²-γμξ(ξ-a)-N_dk_BT(ξ-a)+k_BTγ.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- U下界>1且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需C²。

### 6. 审计结论（含网站结论）

网站首轮：PASS。对所有n、C²势U、β,Q,γ>0、任意a与z，恒等式各项完整一致。势能一阶项与动能力项相消，Q消去反馈分母，二阶ξ项给γ/β；得到−aP²−γQξ(ξ−a)−n(ξ−a)/β+γ/β。Expression的U参数未使用是正确的势能消去。shiftedSquare_bound对任意ξ,a成立，等价于(ξ+a)²≥0；不要求U上下界，也没有暗含遍历结论。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhlLyapunovExpression`：定义
- `MD.Ch08.nhlLyapunov_calculation`：未证；缺大型理论
- `MD.Ch08.shiftedSquare_bound`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-LyapunovRatePrinted

印刷页 349 / PDF页 370。

### 1. 原文陈述

> Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书α=min(2a,γμ)及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为min(2a,γ)合理且正确：ξ能量的系数是Q/2，故须α≤γ；结合平方不等式及U≤Umax得所写δ。修正版没有额外宣称几何遍历。
原文版：Printed忠实性PASS；min(2a,γμ)一般不正确。
修正版：原送审min(2a,γ)修正版及反例PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。；{"codes": ["ERRATUM_LYAPUNOV_RATE"], "detail": "lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书α=min(2a,γμ)及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为min(2a,γ)合理且正确：ξ能量的系数是Q/2，故须α≤γ；结合平方不等式及U≤Umax得所写δ。修正版没有额外宣称几何遍历。", "suggested_fix": "原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，α=min(2a,γ)。"}

### 7. 状态与证明位置

- `MD.Ch08.lyapunovAlphaPrinted`：定义
- `MD.Ch08.lyapunovAlpha_corrected`：定义
- `MD.Ch08.lyapunovRatePrinted`：未证；原书疑误不证
- `MD.Ch08.lyapunovRate_counterexample`：已证
- `MD.Ch08.lyapunovRate_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.2-NHLTimestep

印刷页 350 / PDF页 371。

### 1. 原文陈述

> The symmetric NHL splitting uses kick, drift, feedback, damping, exact OU, damping, feedback, drift, kick. ζ=√(k_BTμ⁻¹(1-e^{-2γh})).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- R_n独立标准正态；h≥0、β,Q>0、γ≥0用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。
- 覆盖缺口：实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。

### 6. 审计结论（含网站结论）

网站首轮：PASS。复合从右向左作用，九阶段正好为半kick、半drift、半feedback、半damping、全OU、半damping、半feedback、半drift、半kick；第二次damping使用OU更新后的ξ，第二次feedback使用更新后的p。OU系数与ζ逐项一致。standardNormalSequence含概率测度、全序列独立和每项N(0,1)。定义未将无限摩擦稳定性扩大成整体算法无条件稳定定理；h≥0、β,Q>0、γ≥0作为噪声解释限定已披露。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhlOU`：定义
- `MD.Ch08.forceKick`：定义
- `MD.Ch08.bathDamping`：定义
- `MD.Ch08.nhlStep`：定义
- `MD.Ch08.standardNormalSequence`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.1-NHLWeakStationary

印刷页 345–346 / PDF页 366–367。

### 1. 原文陈述

> The NHL method preserves the extended canonical distribution ρ_β exp(-βμξ²/2), by adding an OU thermostat in ξ.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。
- 覆盖缺口：归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：PASS。在无约束欧氏全空间，正逆质量、β,Q,γ,Z，C²势及权重可积、积分为Z前提下，ρ=nhWeight/Z非负归一且对所有C∞紧支撑测试函数满足∫Lfρ=0。展开漂移，Nosé–Hoover加权散度相消，ξ上的OU高斯分部积分相消。前提、测试函数量词及归一结论完整。这里只是弱驻定；没有声称Markov半群不变性、唯一性或遍历性。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.weakStationaryNHL`：定义
- `MD.Ch08.nhlWeakStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.3-PreEquilibriumMeans

印刷页 354–355 / PDF页 375–376。

### 1. 原文陈述

> θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。
- [EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。
- 覆盖缺口：任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。
- 覆盖缺口：[EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。

### 6. 审计结论（含网站结论）

网站首轮：FAIL。两积分的变量、2K=kineticTwice invm p及ξ权重与原页一致，preEquilibriumDensity仅要求每个t≥0非负可积归一。该条件不保证两项加权函数可积，因而Lean总化Bochner积分未必代表原文有限分布平均；还没有限定ρ满足原文明说的NHL Fokker–Planck演化。局部稳定性/闭合方程缺口已披露，但不应将上述资格定义称为完整的预平衡密度资格。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：待复审 / EAUDIT02。
原书疑点：{"codes": ["MISSING_MOMENT_INTEGRABILITY", "MISSING_DENSITY_EVOLUTION_SPEC"], "detail": "两积分的变量、2K=kineticTwice invm p及ξ权重与原页一致，preEquilibriumDensity仅要求每个t≥0非负可积归一。该条件不保证两项加权函数可积，因而Lean总化Bochner积分未必代表原文有限分布平均；还没有限定ρ满足原文明说的NHL Fokker–Planck演化。局部稳定性/闭合方程缺口已披露，但不应将上述资格定义称为完整的预平衡密度资格。", "suggested_fix": "增加每个t≥0的Integrable (kineticTwice invm z.1.2*ρ t z)与Integrable (z.2*ρ t z)，并明确正质量。若保留pre-equilibrium命名，应添加FP演化规格；否则声明仅定义任意随时间概率密度的形式积分，并明确演化未覆盖。"}

### 7. 状态与证明位置

- `MD.Ch08.meanKineticTwice`：定义
- `MD.Ch08.meanBath`：定义
- `MD.Ch08.preEquilibriumDensity`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.4-VelocityRescaling

印刷页 355 / PDF页 376。

### 1. 原文陈述

> dq=pdt, dp=-∇Udt-Ψ(K)pdt+√(2k_BTΦ(K))p dW; Ψ=(2K-(1+N_d)k_BT)Φ-2k_BTKΦ′. Φ(K)=γ_VR/(2K).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Φ在K>0光滑正，KΦ在0附近有界且多项式增长；原始Φ在K=0奇异，未声称全空间光滑扩散或遍历性。

### 6. 审计结论（含网站结论）

网站首轮：PASS。M=I，n=N_d。漂移−∇U−Ψp与同一标量W驱动的径向扩散√(2θΦ(K))p完全一致。Admissible用K>0的C∞及正性、KΦ在0右侧有界与Φ的多项式增长准确表达限制。对K≠0，Φ′=−γ/(2K²)，代入得γ(1−(n−1)θ/(2K))；化简定理无需γ,θ正，物理解释要求γ>0。零动量处的Lean总定义不等于奇异SDE在该处已获合理延拓。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.rescalingPsi`：定义
- `MD.Ch08.rescalingDrift`：定义
- `MD.Ch08.rescalingNoise`：定义
- `MD.Ch08.originalRescalingPhi`：定义
- `MD.Ch08.rescalingAdmissible`：定义
- `MD.Ch08.rescalingPsi_original`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.4-RescalingStationary

印刷页 355 / PDF页 376。

### 1. 原文陈述

> With these definitions, the method preserves the canonical probability density ρ_β. The book does not prove ergodicity.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。
- havoid现对tsupport f量化，与HasCompactSupport的闭包支撑一致；未扩大到闭包接触p=0的测试函数。
- 应要求tsupport f避开p=0（或K有统一正下界），当前Lean havoid尚未实现这一条件。
- 二阶项冻结噪声方向，正确表示Itô Hessian；完整随机解、奇异边界与半群不变性未覆盖。
- 覆盖缺口：闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。
- 覆盖缺口：二阶项冻结噪声方向，正确表示Itô Hessian；完整随机解、奇异边界与半群不变性未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：FAIL。Itô二阶项确实冻结rescalingNoise Φ θ z，不含噪声导数，正确；C²势、正θ,Z和归一密度亦正确。但havoid量化Function.support f，即f≠0的集合，而HasCompactSupport约束的是其闭包；这不保证闭包与p=0分离。JSON所称“支撑远离K=0”比实际前提强。Admissible不控制Φ′在0附近的增长，因此不能直接用避开奇点的紧支撑分部积分论证覆盖所有给定测试函数。本项FAIL指所宣称的域/边界规格不足，并非已提供该Lean等式的数值反例。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：待复审 / EAUDIT02。
原书疑点：{"codes": ["SUPPORT_NOT_SEPARATED_FROM_ZERO", "SINGULAR_BOUNDARY_CONTROL_MISSING"], "detail": "Itô二阶项确实冻结rescalingNoise Φ θ z，不含噪声导数，正确；C²势、正θ,Z和归一密度亦正确。但havoid量化Function.support f，即f≠0的集合，而HasCompactSupport约束的是其闭包；这不保证闭包与p=0分离。JSON所称“支撑远离K=0”比实际前提强。Admissible不控制Φ′在0附近的增长，因此不能直接用避开奇点的紧支撑分部积分论证覆盖所有给定测试函数。本项FAIL指所宣称的域/边界规格不足，并非已提供该Lean等式的数值反例。", "suggested_fix": "将havoid改为∀z∈tsupport f,z.2≠0，或明确存在ε>0使f的支撑上K≥ε。若希望包含接触p=0的测试函数，应另设边界、噪声正则性及生成元可积性条件并论证；不能静默扩大弱驻定范围。"}

### 7. 状态与证明位置

- `MD.Ch08.rescalingStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.4.5-ThermostatEfficiency

印刷页 356–357 / PDF页 377–378。

### 1. 原文陈述

> efficiency = rate of convergence to equilibrium / rate of growth of perturbation of dynamics. Table 8.1 gives analytic lowest-order estimates; NHL has initially quadratic error.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的O(N)含义；外引估计定理未证，经验曲线排除。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。
- γ>0、θ,Q>0、N>0用于物理解释；一般VR的O(N)给出确切渐近性质定义，没有声称任意Φ族满足它。
- 覆盖缺口：效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的O(N)含义；外引估计定理未证，经验曲线排除。

### 6. 审计结论（含网站结论）

网站首轮：PASS。效率定义为两速率之比；四行的γ、4⟨K²Φ⟩/(θN)、γ_VR、√(Nθ/Q)，及对应线性/二次低阶误差全部与表8.1一致。1,N,2N是估计值定义，不是精确动力学效率定理；NHL速率仅在临界阻尼解释下使用，原文效率列为≈。rescalingEfficiencyOrder只定义N→∞的O(N)性质，没有断言任意Φ族满足。N>0及正温度、质量、摩擦作为表格物理解释条件已注明。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

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

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.5-SLS

印刷页 357–358 / PDF页 378–379。

### 1. 原文陈述

> dq=ξM⁻¹pdt, dp=-γpdt+σM^{1/2}dW, dξ=-[(M⁻¹p)·∇U/μ+γ′ξ]dt+σ′dZ; σ=√(2k_BTγ), σ′=√(2k_BTγ′/μ).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 全部n+1个Wiener坐标独立，Q、质量、温度及两摩擦参数正；总漂移和常噪声用实际积分方程解释。

### 6. 审计结论（含网站结论）

网站首轮：PASS。invm为正对角逆质量；p噪声√(2γ/(β invm_i))=σ√m_i，ξ噪声√(2γb/(βQ))=σ′，n+1个方向与原页吻合。isSLSSolution完整展开包含正参数、概率测度、各坐标Brownian及作为整条路径的独立性，X的样本连续性、对噪声自然历史的可测性，以及每个t≥0几乎处处的漂移可积与积分方程；确定初值x0。确定性子场p固定，去除两OU漂移，保留q和ξ能量耦合。未断言解存在/唯一。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.slsDrift`：定义
- `MD.Ch08.slsNoise`：定义
- `MD.Ch08.isSLSSolution`：定义
- `MD.Ch08.slsDeterministic`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.5-SLSBracketPrinted

印刷页 358 / PDF页 379。

### 1. 原文陈述

> D=(ξp,-p,-p·∇U-ξ), D′=[D,Y_{Nc+1}]=(p,0,1), [D′,Y_i]=e_i.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只纠正第一括号；二次括号的整体符号不影响生成空间张成。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。slsBracketPrinted逐字对应原书(p,0,1)，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按VectorField.lieBracket V W=DW·V−DV·W，常向量Yξ给[D,Yξ]=−∂ξD=(−p,0,1)，故_corrected签名正确。反向括号会整体变为(p,0,−1)，不能仅靠约定得到原书(p,0,1)。二次括号的整体符号不影响张成。
原文版：Printed忠实性PASS；括号首分量符号不一致。
修正版：原送审−p首分量_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。；{"codes": ["ERRATUM_LIE_BRACKET_SIGN"], "detail": "slsBracketPrinted逐字对应原书(p,0,1)，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按VectorField.lieBracket V W=DW·V−DV·W，常向量Yξ给[D,Yξ]=−∂ξD=(−p,0,1)，故_corrected签名正确。反向括号会整体变为(p,0,−1)，不能仅靠约定得到原书(p,0,1)。二次括号的整体符号不影响张成。", "suggested_fix": "保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为−p。"}

### 7. 状态与证明位置

- `MD.Ch08.slsBathNoise`：定义
- `MD.Ch08.slsBracketPrinted`：未证；原书疑误不证
- `MD.Ch08.slsBracket_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.5-SLSHormander

印刷页 357–358 / PDF页 378–379。

### 1. 原文陈述

> All basis vectors are in the Lie algebra generated by the drift and the N_c+1 noise directions, so Hörmander holds.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。
- 覆盖缺口：单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。

### 6. 审计结论（含网站结论）

网站首轮：PASS。所有n、C∞势及所有点z上，seed含实际SLS漂移及n+1个单位常噪声（β=2使√(2/β)=1）。textbookIteratedBracket确实由seed和反复实际Lie括号生成；textbookBracketPointSpan在z取值后作实线性张成，结论为整个切空间。噪声已给p_i、ξ方向，[D,Yξ]=(−p,0,1)，再与Yp_i括号给q_i方向，故原书第一括号符号疑误不损害该结论。仅为单位参数点态Lie张成，不是一般参数下的半群几何遍历结论。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.slsHormander`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.5-SLSConservation

印刷页 358 / PDF页 379。

### 1. 原文陈述

> The deterministic part preserves volume and U(q)+μξ²/2, and the full dynamics preserves the extended canonical measure.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 完整权重含p高斯项，确定性p固定；只保留驻定及零散度，完整SDE概率不变和离散迭代收敛列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。stationary对正逆质量、β,Q及C²势断言实际ρF的Fréchet导数迹处处为0；divergence对任意Q（含0时Lean除法总化）断言实际子场散度为0，因q分量不依赖q，p分量为0，ξ分量不依赖ξ而成立，无需Q>0。正Q时∇U·(ξ invm p)+Qξ(−dot(invm p,∇U)/Q)=0，p固定，所以包含p高斯项的完整nhWeight加权散度也为0。独立第一积分、完整SDE概率不变与离散迭代收敛未形式化，已明确披露，不视作完整原文结论已证。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.slsDeterministic_stationary`：未证；缺大型理论
- `MD.Ch08.slsDeterministic_divergence`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.5-SLSLeapfrog

印刷页 358–359 / PDF页 379–380。

### 1. 原文陈述

> q=q₀+ηM⁻¹p; η̇=ξ, ξ̇=-∂ηU(q₀+ηM⁻¹p). Leapfrog: ξ_{1/2}=ξ-h(M⁻¹p)·∇U(q)/(2μ), q′=q+hξ_{1/2}M⁻¹p, ξ′=ξ_{1/2}-h(M⁻¹p)·∇U(q′)/(2μ).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 原文η约化方程漏μ⁻¹，算法保留Q⁻¹；本条覆盖原页算法及逐坐标场，不声称二阶不变分布误差或精确求积实现。
- 已目视核对原页PDF379：η约化式的ξ导数漏μ⁻¹，新增Printed与恢复1/Q的_corrected；Q>0、正质量与U可微为物理域。分裂映射原有定义未改。
- 覆盖缺口：原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。
- 覆盖缺口：原文η约化方程漏μ⁻¹，算法保留Q⁻¹；本条覆盖原页算法及逐坐标场，不声称二阶不变分布误差或精确求积实现。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。Vec n=Fin n→ℝ，Phase n=(q,p)，z.2=ξ，invm为对角逆质量，Q对应原书μ。slsBathKick对任意n、invm、U、Q、h、z只更新ξ；slsDriftStep只更新q且保留p、ξ。函数复合从右往左执行，slsLeapfrog精确给出半kick、全drift、半kick，第二次梯度在新q处。slsCoordinateField只激活所选i的q分量，并给出−invm_i p_i ∂iU/Q。四个定义均忠实对应算法；未把有疑误的η约化方程作为已证结论。 半kick、drift、半kick和逐坐标场：PASS。 [EXTRA] Q≠0、正质量及U可微是物理解释的域；Lean定义作总函数，不据此声称Q=0时有物理意义。 覆盖边界：无η约化方程定理、体积/面积保持定理、二阶稳态误差或OU随机步骤定理。
原文版：原送审四个算法/坐标场定义PASS；原书η约化漏μ⁻¹待导师。
修正版：本轮另列η约化Printed与1/Q修正版，待复审。
当前：待复审 / EAUDIT03。
原书疑点：原书PDF379末段确实印作 ξ̇=−∂ηU，未带μ⁻¹；PDF380的两次kick及逐坐标场则都含μ⁻¹。statement_latex忠实保留了这个不一致。；已目视核对原页PDF379：η约化式的ξ导数漏μ⁻¹，新增Printed与恢复1/Q的_corrected；Q>0、正质量与U可微为物理域。分裂映射原有定义未改。

### 7. 状态与证明位置

- `MD.Ch08.slsBathKick`：定义
- `MD.Ch08.slsDriftStep`：定义
- `MD.Ch08.slsLeapfrog`：定义
- `MD.Ch08.slsCoordinateField`：定义
- `MD.Ch08.slsReducedPrinted`：定义
- `MD.Ch08.slsReduced_corrected`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.5-SLSDoubleWell

印刷页 359 / PDF页 380。

### 1. 原文陈述

> The one-dimensional example has U(q)=(q²−1)².

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 保留试验中的数学势函数；轨迹、直方图和采样优劣是经验观测，另列排除。

### 6. 审计结论（含网站结论）

网站首轮：PASS。slsDoubleWell的域为全部实数q，值为(q²−1)²；slsDoubleWell_nonneg对每个实数q断言0≤该值，无额外前提，结论正确。非负性为直接代数推论，不涉及原页的数值采样实验。 slsDoubleWell：PASS；slsDoubleWell_nonneg：PASS。 未把原页的q(0)=p(0)=1、ξ(0)=0.5、δt=0.01或采样性能作为本条定理。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.slsDoubleWell`：定义
- `MD.Ch08.slsDoubleWell_nonneg`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6-IsokineticField

印刷页 361–362 / PDF页 382–383。

### 1. 原文陈述

> q̇=M⁻¹p, ṗ=F(q)-[pᵀM⁻¹F(q)/(pᵀM⁻¹p)]p; K(p)=pᵀM⁻¹p is constant.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 正质量、K>0作为物理有效域；本条实际证明瞬时动能平衡，不将之扩大为全局解存在性。

### 6. 审计结论（含网站结论）

网站首轮：PASS。kineticTwice=Σinvm_i p_i²；isoMultiplier=Σinvm_i p_i F_i/K；isoField的输入输出均为Phase n，位置速度invm_i p_i，动量速度F_i−λp_i。isoKinetic_balance对任意n、invm、p、F向量，在K≠0下断言Σinvm_i p_i(F_i−λp_i)=0，恰为K导数的一半；无需正质量或力场可微即可成立。 isoMultiplier、isoField、isoKinetic_balance：PASS。 [EXTRA] 正质量、K>0是原物理模型的域；代数定理只需K≠0，是合理推广。 完整沿解第一积分未被当前签名冒充。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.isoMultiplier`：定义
- `MD.Ch08.isoField`：定义
- `MD.Ch08.isoKinetic_balance`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6-IsokineticProjector

印刷页 362 / PDF页 383。

### 1. 原文陈述

> H=p(pᵀM⁻¹p)⁻¹pᵀM⁻¹; H²=H, Hp=p.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 分母K非零；范围为span(p)的完整线性映射子空间等式列覆盖缺口。
- 覆盖缺口：实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：PASS。isoProjection以任意v为自变量，给出p_i(Σinvm_j p_j v_j/K)，正是H作用于v。isoProjection_self在K≠0下断言H(p)=p；isoProjection_idempotent在同一前提下对每个v断言H(H(v))=H(v)。n、invm、p均任意，结论在该非零分母域成立；无需正质量。sorry不影响本次签名判定。 isoProjection、isoProjection_self、isoProjection_idempotent：PASS。 并非声称欧氏正交投影；非单位质量下该投影一般不对称。 原页像空间刻画未形式化，已在scope披露。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.isoProjection`：定义
- `MD.Ch08.isoProjection_self`：已证
- `MD.Ch08.isoProjection_idempotent`：未证；时间盒止

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6-IsokineticDivergencePrinted

印刷页 362–363 / PDF页 383–384。

### 1. 原文陈述

> ρ=e^{-w(q,p)}Φ(K(p)); div f_iso=(N_c-1)pᵀM⁻¹F/(pᵀM⁻¹p), w=(N_c-1)U/K.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Φ为正光滑非零函数时称权重；使用K≠0域上的实际散度。
- 已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。isoAnsatz对任意实函数w、Φ给exp(−w)Φ(K)，是权重表达式而非已归一概率密度。isoDivergencePrinted以任意n、invm、C¹力场F和K≠0为前提，完整保留原印正号：字面忠实PASS，数学疑误NEEDS_HUMAN。isoDivergence_corrected使用完全相同的对象和前提，仅改为−(n−1)λ，数学陈述PASS。textbookDivergence是fderiv的迹，不是负散度约定；λ对p为−1次齐次，故div_p(F−λp)=−nλ−p·∇pλ=−(n−1)λ。 isoAnsatz：PASS；isoDivergencePrinted：忠实PASS/数学NEEDS_HUMAN；isoDivergence_corrected：PASS。 [EXTRA] C¹和K≠0支持实际散度的定义与局部微分；Φ的正性、光滑性未由裸权重定义保证，未据此推出概率不变性。 w方程、不变曲面测度和归一化均不在当前完整结论中。
原文版：Printed忠实性PASS；原印散度正号有误。
修正版：原送审负号_corrected签名PASS；w本身保留正号。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。；PDF383确实印正号div f=(Nc−1)λ，PDF384随后仍用正号的∇w·f等式并给w=(Nc−1)U/K；原文逐字内容应保留。；已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。

### 7. 状态与证明位置

- `MD.Ch08.isoAnsatz`：定义
- `MD.Ch08.isoDivergencePrinted`：未证；原书疑误不证
- `MD.Ch08.isoDivergence_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6-IsokineticGibbsShell

印刷页 363 / PDF页 384。

### 1. 原文陈述

> ρ=Z⁻¹exp(-(N_c-1)U/K)δ[K-K₀]; K₀=β⁻¹(N_c-1) gives the configurational Gibbs distribution.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。
- 覆盖缺口：动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。

### 6. 审计结论（含网站结论）

网站首轮：PASS。isokineticShell为Phase n中K=K0的集合；isoShellWeight为exp(−(n−1)U/K)。isoShell_gibbsFactor量化任意U、invm、β、z，在1<n、β>0和z位于K=(n−1)/β的壳面上时，断言权重逐点等于exp(−βU(q))；前提保证n−1与β非零，结论完整且正确。 isokineticShell、isoShellWeight、isoShell_gibbsFactor：PASS。 [EXTRA] n>1、β>0是正温度非退化壳面的合理显式前提。 δ仅在原文记号中出现，Lean未把它伪装成Lebesgue密度。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.isokineticShell`：定义
- `MD.Ch08.isoShellWeight`：定义
- `MD.Ch08.isoShell_gibbsFactor`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.1-StochasticIsokinetic

印刷页 364–365 / PDF页 385–386。

### 1. 原文陈述

> dq=pdt, dp=(F-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=μ₂⁻¹(μ₁ξ₁²-k_BT)dt-γξ₂dt+σdW; p²+μ₁ξ₁²/2=k_BT.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 热浴变量ξ₁,ξ₂∈ℝ，各质量、温度、摩擦正；随机噪声只在ξ₂；约束正值排除奇点。

### 6. 审计结论（含网站结论）

网站首轮：PASS。四坐标依次(q,p,ξ₁,ξ₂)，sinConstraint=p²+Q1 ξ₁²/2；sinMultiplier=(pF−Q1 ξ₁²ξ₂/2)/K；sinDrift完整四分量与原书相符。isSINSolution要求Q1,Q2,θ,γ>0及初值K=θ，并通过additiveSDE给出一维独立Wiener驱动、几乎处处连续轨道、截至t的噪声可测性、漂移区间可积性以及每个t≥0的积分等式；噪声只在第四坐标，振幅√(2γθ/Q2)。sinConstraint_balance对任意参数及F、z在K≠0时断言2p b_p+Q1 ξ₁ b_ξ₁=0，正确。 sinConstraint、sinMultiplier、sinDrift、isSINSolution、sinConstraint_balance：PASS。 D8/D9中的概率测度、Brownian、独立性、适应性和积分量词均已审读；一维时独立族条件为平凡独立性。 [EXTRA] 严格正参数为物理有效域；代数平衡本身只需K≠0。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.sinConstraint`：定义
- `MD.Ch08.sinMultiplier`：定义
- `MD.Ch08.sinDrift`：定义
- `MD.Ch08.isSINSolution`：定义
- `MD.Ch08.sinConstraint_balance`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.1-SINWeightPrinted

印刷页 365 / PDF页 386。

### 1. 原文陈述

> w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
- 覆盖缺口：原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。sinWeightPrinted是原印exp(−w)，没有把w和密度混淆。sinWeight_corrected把二次项改成Q2 ξ₂²/2，合理且正确。sinWeight_stationary_corrected量化C²势U、Q1,Q2,θ>0和K(z)=θ，在γ=0且F=−U′时断言div(ρb)(z)=0；这是环境空间通量散度在壳面处的逐点等式，不是曲面测度不变性或包含OU的完整Fokker–Planck定理。沿b有K̇=0；div b=−pF/K+Q1ξ₁²ξ₂/K−ξ₂，而b·∇logρ=(pF−ξ₂(Q1ξ₁²−θ))/K，两者相加为ξ₂(θ/K−1)，壳面上为0。 sinWeightPrinted：忠实PASS/一般质量数学NEEDS_HUMAN；sinWeight_corrected、sinWeight_stationary_corrected：PASS。 正约束保证分母非零；C²假设略强但不构成偷换。 印刷式在μ₂=1时消除此项疑误，但原节并未把μ₂固定为1。
原文版：Printed忠实性PASS；原印二次项缺μ₂。
修正版：原送审补Q2的权重与壳面局部驻定签名PASS，非曲面测度不变性。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。；PDF386确实印w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2)，未含μ₂；statement_latex忠实，不能静默把原印式改成修正式。

### 7. 状态与证明位置

- `MD.Ch08.sinWeightPrinted`：定义
- `MD.Ch08.sinWeight_corrected`：定义
- `MD.Ch08.sinWeight_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.2-SINHarmonic

印刷页 366 / PDF页 387。

### 1. 原文陈述

> For μ₁=μ₂=1, dq=pdt, dp=(-q-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=(ξ₁²-k_BT-γξ₂)dt+σdW, λ=(-qp-ξ₂ξ₁²/2)/(p²+ξ₁²/2), σ=√(2γk_BT). (8.45)–(8.47).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- θ=k_BT>0、γ>0、标量Wiener由isSINSolution给全；零ξ₁面不变和两个半柱的轨道符号保持需要ODE唯一性，列覆盖缺口。
- 覆盖缺口：谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。

### 6. 审计结论（含网站结论）

网站首轮：PASS。sinHarmonicF用Q1=Q2=1及F(q)=−q实例化sinDrift；sinHarmonicG仅第四分量为√(2γθ)；isSINHarmonicSolution沿用全部正参数、初始壳面和SDE积分量词。sinExceptional为q=p=0、ξ₁²=2θ且ξ₂任意；sinHalfCylinder要求K=θ并按Bool选择ξ₁>0或ξ₁<0。sinHalfCylinder_disjoint对任意实θ断言两集合不交，结论成立，θ非正时也不会出现反例。 sinHarmonicF、sinHarmonicG、isSINHarmonicSolution、sinExceptional、sinHalfCylinder、sinHalfCylinder_disjoint：PASS。 [EXTRA] 半柱集合及不交性是对原书两半空间的准确数学表达。 全局唯一性、ξ₁=0面不变性及半柱内遍历性均已排除。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.sinHarmonicF`：定义
- `MD.Ch08.sinHarmonicG`：定义
- `MD.Ch08.isSINHarmonicSolution`：定义
- `MD.Ch08.sinExceptional`：定义
- `MD.Ch08.sinHalfCylinder`：定义
- `MD.Ch08.sinHalfCylinder_disjoint`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.2-SINProjectedBracketsPrinted

印刷页 367 / PDF页 388。

### 1. 原文陈述

> u₀=Πf, u₁=Π[f,g], u₂=Π[f,[f,g]], u₃=Π[f,[f,[f,g]]]. The displayed equations (8.48)–(8.53) give their components, with D=2p²+ξ₁².

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 总化分式只在θ>0的约束面D=2θ>0使用；实际交换子先在四维完整计算再投影。
- 本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
- 已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
- 覆盖缺口：本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。bracket4采用Dg·f−Df·g；sinBracket的0=f、1=[f,g]、k+2=[f,sinBracket(k+1)]递归及projectFirstThree均正确。sinU0Printed是(8.48)展开式；sinU1Printed重复它，忠实于(8.50)；sinU2Printed忠实于(8.51)；sinU1DerivativePrinted的d=∂ξ₂λ且第三分量未乘σ，忠实于(8.49)。sinProjected_corrected先在完整四维计算再投影，对j:Fin 4给出真实迭代括号的定义，无冒充显式公式等式。sinU2LongPrinted逐项对应(8.52)，sinU2Long_at_p0对所有σ、γ、z只假设p=0，得到[0,σξ₁²q/D²,0]，即(8.53)，在Lean总除法约定下也成立。 真实括号与投影定义：PASS；所有Printed表达式的字面忠实性：PASS。 sinU2Long_at_p0：内部代数特化PASS；它没有断言Printed长式等于真实二重括号。 原页“any pair”也应人工复核：p=0时首括号投影为0，并非任意一对均独立。 [EXTRA] θ>0且K=θ时D=2θ>0，裸Printed定义对零分母的总化不代表物理延拓。
原文版：Printed各表达式忠实性PASS；(8.49)–(8.53)疑误待导师。
修正版：原送审完整四维真实括号再投影定义PASS，长式未声称等于真实括号。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。；PDF388逐式核对：(8.48)为u0；(8.49)ξ₁分量前确无共同σ；(8.50)印u1却重复u0展开式；(8.51)印u2却是首交换子的投影。(8.52)的p分量确为−σa而非−σξ₁²a，故Lean忠实保留了原印式，不应替书改系数。；已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。

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

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.2-SINThirdBracketPrinted

印刷页 368 / PDF页 389。

### 1. 原文陈述

> The third projected commutator is displayed in (8.54), with polynomial η in (8.55); its p=0 specialization is printed as u₃=-2σq∂q-σq(-γ+ξ₂)∂p in (8.56).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 原印三重交换子候选及p=0内部代数核对；真实三重交换子等式列覆盖缺口。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
- _corrected只修正(8.54)在p=0的内部代数特化，不能据此声称Printed长式等于真实三重括号。
- 覆盖缺口：ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。sinEtaPrinted完整保留γ²、ξ₁幂次及各交叉项；sinU3Printed的三个分量完整对应(8.54)。sinU3ZeroPrinted忠实于(8.56)；sinU3Zero_corrected仅修正从(8.54)出发的p=0内部代数特化，q分量为−2σq/ξ₁²，p分量仍为−σq(−γ+ξ₂)。sinU3Zero_specialize量化任意σ、γ、z，假设p=0和ξ₁≠0，断言Printed长式等于上述内部修正版，陈述正确。该修正版没有宣称已校正真实三重括号；scope的这一限制必不可少。 sinEtaPrinted、sinU3Printed、sinU3ZeroPrinted：忠实PASS；sinU3Zero_corrected及sinU3Zero_specialize：在明确的内部代数意义下PASS。 ξ₁≠0是约去幂次所需的有效前提；无θ、γ、σ正性需求。 原印长式是否等于真实三重括号未由本条签名断言或证明。
原文版：Printed忠实性PASS；(8.54)/(8.56)内部不一致。
修正版：原送审_corrected及specialize在内部代数特化意义下PASS，非真实三重括号校正。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。；PDF389的(8.54)q分量分母为D²，(8.55)的13项多项式逐项与sinEtaPrinted一致；(8.56)原印q分量为−2σq，确无ξ₁²分母。

### 7. 状态与证明位置

- `MD.Ch08.sinEtaPrinted`：定义
- `MD.Ch08.sinU3Printed`：定义
- `MD.Ch08.sinU3ZeroPrinted`：定义
- `MD.Ch08.sinU3Zero_corrected`：定义
- `MD.Ch08.sinU3Zero_specialize`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.2-SINBracketRank

印刷页 366–368 / PDF页 387–389。

### 1. 原文陈述

> For θ>0, γ>0, on p²+ξ₁²/2=θ with ξ₁≠0 and outside M₀, the fields f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]] span the three-dimensional tangent space of the isokinetic cylinder.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
- 覆盖缺口：θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：PASS。sinBracket_tangentSpan假设θ>0、γ>0、K(z)=θ、ξ₁≠0及z∉M0。左侧是噪声g与j=0,1,2,3四个真实sinBracket值的实线性张成；右侧是实际K微分的核，即三维切空间。它没有使用Printed错式作定义。γ、θ正使σ非零，ξ₁≠0排除不受噪声横向驱动的边界；在p≠0时f的q分量与首括号的非零p分量提供两个独立投影，在p=0且不在M0时q≠0，f及真实三重括号提供两个独立投影，连同g张成三维。该签名正确；sorry不使签名FAIL。 sinBracket_tangentSpan：PASS，完整结论是子模等式，而非只给出向量数目或rank下界。 [EXTRA] 正参数和非零ξ₁已列在extra_assumptions；其作用须在摘要可见。 未声称已从括号条件推出密度光滑、可达性或遍历性。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：PDF387–389列出的五个场和M0吻合。原页先说明运动限制在ξ₁>0或ξ₁<0半空间；statement_latex应显式带上这一域，避免把“除M0外”误读为包含ξ₁=0的整个圆柱。

### 7. 状态与证明位置

- `MD.Ch08.sinBracket_tangentSpan`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.2-SINLyapunov

印刷页 368–369 / PDF页 389–390。

### 1. 原文陈述

> For φ=ξ₂²/2, L_isok φ=(ξ₁²-β⁻¹)ξ₂-γξ₂²+σ²/2, and the isokinetic constraint bounds ξ₁. The negative tail drift supports the ergodicity argument with further assumptions.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 仅生成元作用和约束界；原文有符号ξ₂的Kξ₂上界须区分尾部方向，严谨负漂移应使用K|ξ₂|并要求γ>0。
- 紧性、正密度、小集与Markov半群遍历定理均列覆盖缺口。
- 已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。
- 覆盖缺口：局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。
- 覆盖缺口：已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。additiveGenerator= Df(z)[b(z)]+D(Df(·)[B])(z)[B]/2；sinGenerator用单位热浴质量的sinDrift和第四坐标噪声B。sinGenerator_lyapunov对θ,γ>0、任意F和K(z)≠0断言L(ξ₂²/2)=(ξ₁²−θ)ξ₂−γξ₂²+γθ，正确；无需F可微，因为被求导的测试函数仅依赖ξ₂。sinConstraint_bathBound对任意θ和满足K=θ的z给ξ₁²≤2θ，正确。两个定理均未断言原印有符号尾界或遍历性。 sinGenerator、sinGenerator_lyapunov、sinConstraint_bathBound：PASS。 [EXTRA] hθ,hγ保证扩散平方为2γθ；hK排除物理奇点，未用它替代完整约束面结论。 原文正开集候选测度、周期边界及收缩性论证未被当作已形式化的遍历定理。
原文版：原送审局部生成元与约束界签名PASS；原页有符号尾项待导师。
修正版：本轮新增绝对值尾界修正版待复审；依赖未证生成元恒等式。
当前：待复审 / EAUDIT03。
原书疑点：PDF390生成元计算与statement_latex吻合；但原书随后给−γξ₂²+Kξ₂+σ²/2作为全局上界，未对ξ₂正负分情况。原文须保留并注明此上界疑误。仅在ξ₂方向的负漂移也不能单独推出非紧q方向的遍历性。；原文从局部负漂移到遍历性的论证需要额外全局条件；现有Lean没有此结论。；已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。

### 7. 状态与证明位置

- `MD.Ch08.sinGenerator`：定义
- `MD.Ch08.sinGenerator_lyapunov`：未证；缺大型理论
- `MD.Ch08.sinConstraint_bathBound`：已证
- `MD.Ch08.sinLyapunovTailPrinted`：定义
- `MD.Ch08.sinLyapunovTail_corrected`：未证；缺大型理论；证明体已写完，但传递依赖未证陈述

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.3-SINForceSplitting

印刷页 370–371 / PDF页 391–392。

### 1. 原文陈述

> U=U_S+U_F and F=F_S+F_F. The generators split into kinetic, isokinetic fast force, isokinetic slow force, Nosé and OU terms; each preserves Λ=p²+μ₁ξ₁²/2.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Q₁,Q₂,θ>0且Λ=θ为物理域，总化场保留作辅助；本条含完整漂移和分解及力子场瞬时约束平衡，其他子场的流存在/保约束列缺口。
- 覆盖缺口：五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。

### 6. 审计结论（含网站结论）

网站首轮：PASS。sinKField仅q分量p；sinForceField(Q1,F)给p速度F−p²F/K与ξ₁速度−pξ₁F/K；sinNField给三个Nosé分量，保留Q1与Q2因子；sinOField给第四分量−γξ₂。sinSplit_fields对任意Q1,Q2,θ,γ、快慢力函数和K≠0的z，断言完整sinDrift(FF+FS)等于K、两个力场、N、O五场之和，代数正确。sinForce_constraintBalance对任意Q1、标量F及K≠0断言2p b_p+Q1ξ₁ b_ξ₁=0，完整结论正确。 sinKField、sinForceField、sinNField、sinOField、sinSplit_fields、sinForce_constraintBalance：PASS。 [EXTRA] 任意实参数的代数推广不会改变正参数物理域结论；分母非零前提清楚。 未把五个漂移场之和冒称为包含二阶噪声的生成元等式。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.sinKField`：定义
- `MD.Ch08.sinForceField`：定义
- `MD.Ch08.sinNField`：定义
- `MD.Ch08.sinOField`：定义
- `MD.Ch08.sinSplit_fields`：已证
- `MD.Ch08.sinForce_constraintBalance`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.3-SINRAlgorithm

印刷页 371 / PDF页 392。

### 1. 原文陈述

> The SIN(R) algorithm uses h̃=h/r, r−2 repeated inner blocks, outer Nosé half-steps, combined fast/slow force half-steps and independent OU substeps.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 算法有效域h>0、r≥2；一组中多个场表示同一次合并传播，并非擅自换为两个非交换流。每次OU用独立标准正态新噪声。
- 这里只记录精确阶段表，具体随机核实现、保约束及全局误差/阶数列覆盖缺口。
- 覆盖缺口：原印算法的阶段顺序与步长；不声称构造了各非线性子流。

### 6. 审计结论（含网站结论）

网站首轮：PASS。SINStage的五个构造子对应K/F/S/N/OU。sinRStages输出List(List(stage×步长))；内层含fast和slow两个条目表示同一次合并指数传播。a=h/r，开头N(h/2)、[F(a/2),S(h/2)]、K(a)、OU(a)、F(a/2)；重复r−2次F(a/2)、K(a/2)、OU(a)、K(a/2)、F(a/2)；结尾F(a/2)、OU(a)、K(a)、[F(a/2),S(h/2)]、N(h/2)，全部吻合。r:ℕ的减法截断和实数零除使定义在r<2也有总化值，但本条有效算法域已明确h>0、r≥2，不把其他值解释为原书算法。 SINStage、sinRStages：PASS。 合并传播未被替换为非交换流的顺序复合。 [EXTRA] 独立OU噪声是执行时要求；当前List未构造随机核、正态变量、子流或收敛阶数。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.sinRStages`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.3-SINNoseSubsplitting

印刷页 372 / PDF页 393。

### 1. 原文陈述

> L_N=L_N^(1)+L_N^(2). The first term acts on p,ξ₁, the second has μ₂⁻¹(μ₁ξ₁²-β⁻¹)∂ξ₂.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 正质量、温度及Λ>0作为物理资格；高阶Yoshida/Suzuki组合的系数和误差阶未在原页给出，列覆盖缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。Q1、Q2、θ及z∈Fin 4→ℝ均全称量化。z=(q,p,ξ₁,ξ₂)，Λ=p²+Q1 ξ₁²/2。sinN1Field的p、ξ₁两分量分别为Q1 ξ₁²ξ₂p/(2Λ)、Q1 ξ₁³ξ₂/(2Λ)−ξ₂ξ₁；sinN2Field仅ξ₂分量为(Q1 ξ₁²−θ)/Q2。sinNField恰为两者逐分量和，完整结论无遗漏。恒等式在Lean总化除法下对零分母也成立；物理正域属已披露[EXTRA]。Yoshida/Suzuki阶数未声明，属于明示范围外。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.sinN1Field`：定义
- `MD.Ch08.sinN2Field`：定义
- `MD.Ch08.sinN_split`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.3-SINForceExactPrinted

印刷页 372 / PDF页 393。

### 1. 原文陈述

> ṗ=F−p²F/Λ, ξ̇₁=pξ₁F/Λ. The printed solution is p(h)=(p(0)+(F/m)s(h))/ṡ(h), ξ₁(h)=ξ₁(0)/ṡ(h), with s(t)=b⁻¹/²sinh(t√b)+(a/b)(cosh(t√b)−1), a=Fp(0)/Λ, b=F²/Λ.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 质量按本节假设取1；Q₁、Λ正，排除ṡ=0；F=0用b=0的解析延拓，避免总化除法假装极限。
- 只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。Printed正号ODE忠实于原页；sinForceAux在b≠0为所印双曲函数，b=0分支为解析延拓；sinForceFlow以m=1省去F/m，属于已披露[EXTRA]，不得称一般质量字面解。corrected定义为负号sinForceField。导数定理对任意Q1,F,z,t，在Q1>0、Λ(z)>0和s′(t)≠0下声明完整四维HasDerivAt，数学正确：校正场保持Λ，候选在0时返回z，其他q、ξ₂不动。没有全局流或误差阶结论。原印正号与显式候选冲突，须人工确认勘误。
原文版：Printed正号ODE忠实性PASS；与候选导数冲突。
修正版：原送审负号_corrected及局部解签名PASS；限m=1与非零分母。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。；[ERRATUM?] 保留Printed，给ξ₁负号版添加[ERRATUM?]；保留m=1的[EXTRA]，不要把工作修正版回填为原文。

### 7. 状态与证明位置

- `MD.Ch08.sinForceAux`：定义
- `MD.Ch08.sinForceFlow`：定义
- `MD.Ch08.sinForceODEPrinted`：定义
- `MD.Ch08.sinForceODE_corrected`：定义
- `MD.Ch08.sinForceFlow_solution_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.6.4-SINThreeLevelPotential

印刷页 373 / PDF页 394。

### 1. 原文陈述

> U_Total=U_bonds+U_s.r.+U_l.r.; h_outer and h_mid are integer multiples of the next smaller stepsizes.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 仅保留势的三项分解和整数时标嵌套；SPME实现、99fs稳定性及水分子径向分布等属于数值观察，逐项排除。

### 6. 审计结论（含网站结论）

网站首轮：PASS。三势为任意Vec n→ℝ，threeLevelPotential逐点等于bond+short+long。nestedTimeSteps量化inner,middle,outer∈ℝ，要求inner>0并存在正自然数r,s使middle=r·inner、outer=s·middle，故三时步均正；r或s等于1允许相邻层等步长，符合整数倍条件。仅编码抽象分解与嵌套，不断言SPME实现或99fs稳定性，相关范围排除已披露。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.threeLevelPotential`：定义
- `MD.Ch08.nestedTimeSteps`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7-GeneralizedLangevin

印刷页 374 / PDF页 395。

### 1. 原文陈述

> dq=M⁻¹pdt, dp=−∇U(q)dt−∫₀ᵗΓ(t−s)p(s)ds dt+dB, q(0)=q₀,p(0)=p₀. Γ is the memory kernel and B is colored noise. (8.57)–(8.58).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。
- 本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。
- [EXTRA] generalizedLangevin仅为给定B的方程规格；未在此谓词约束有色性、非Gaussian性或涨落耗散关系。
- 已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
- [EXTRA] generalizedLangevin仅为给定加性驱动B的积分方程，噪声分布、有色性及FD未在本定义内强制，由另条规格给出。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。memoryDrag对矩阵核Γ和动量p取负区间卷积；generalizedLangevin在任意概率空间Ω上，以正逆质量、C¹势、非负时间连续核及a.s.连续路径为[EXTRA]强解资格。对每个t≥0要求自然B历史可测性、漂移可积性和a.s.两条积分等式；t=0推出X0=x0，动量增量B(t)−B(0)正确，未将B当作Brownian。定义没有FD或有色性资格，也不要求非Gaussian，因而只应视为给定B的方程规格。原页将colored-noise与non-Gaussian并列，容易误导，原书疑误保留。
原文版：原送审给定B的积分方程规格可接受；有色/非Gaussian同义说法待导师。
修正版：本轮文字修正：有色Gaussian可以存在；不新增分布或FD结论。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：[ERRATUM?] 保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。；已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。

### 7. 状态与证明位置

- `MD.Ch08.memoryDrag`：定义
- `MD.Ch08.generalizedLangevin`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7-GLEFluctuationDissipationPrinted

印刷页 374 / PDF页 395。

### 1. 原文陈述

> ⟨Rᵢ(t+s)Rⱼ(t)⟩=k_BT γᵢⱼ(s)δᵢⱼ, s≥0. Γ(t)=γ(t)I in the scalar-kernel specialization. (8.59).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- 覆盖缺口：Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。
- 覆盖缺口：修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。P、R、矩阵Γ及θ全称作为定义参数。randomForceQualification含概率性、所有t≥0各坐标L²及零均值。gleFDPrinted对所有t,s≥0及i,j使用if i=j then θΓij(s) else 0，忠实编码原印δij；gleFD_corrected去掉δ，作为单位质量一般矩阵协方差目标合理，但不声称任意Γ存在实现。scalarMemoryMatrix为γ(t)I，因此两版本在标量核特化相同。θ>0及零均值、L²均为明确资格，不是原文额外定理。
原文版：Printed的δ忠实于原页；一般矩阵解释有疑。
修正版：原送审去δ的矩阵协方差目标PASS；可实现性另需正定资格。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。；[ERRATUM?] 保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。

### 7. 状态与证明位置

- `MD.Ch08.randomForceQualification`：定义
- `MD.Ch08.gleFDPrinted`：定义
- `MD.Ch08.gleFD_corrected`：定义
- `MD.Ch08.scalarMemoryMatrix`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7-PronyKernel

印刷页 375 / PDF页 396。

### 1. 原文陈述

> γ(t)=Σₖ(cₖ/τₖ)exp(−t/τₖ), t≥0. (8.60).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。
- 覆盖缺口：正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。
- 覆盖缺口：正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。

### 6. 审计结论（含网站结论）

网站首轮：PASS。K为任意自然数，c,τ:Fin K→ℝ；有限求和核与原印c/τ·exp(−t/τ)一致。qualification逐k要求c>0、τ>0；nonneg对所有实t成立，比原文t≥0更广且仍正确，因为每个指数恒正。K=0时空和为0，结论仍成立。未声称逼近任意核的误差或无穷级数收敛。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pronyKernel`：定义
- `MD.Ch08.pronyQualification`：定义
- `MD.Ch08.pronyKernel_nonneg`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7.1-PronyMemoryODE

印刷页 375 / PDF页 396。

### 1. 原文陈述

> ηᵢₖ(t)=−∫₀ᵗ(cₖ/τₖ)exp(−(t−s)/τₖ)pᵢ(s)ds, dηᵢₖ=−ηᵢₖdt/τₖ−cₖpᵢdt/τₖ. Equations (8.61)–(8.64) remove the convolution history.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- p连续、τ正保证有限区间卷积合法；仅消去有限Prony历史，未声称无限Prony极限或解分布等价。

### 6. 审计结论（含网站结论）

网站首轮：PASS。pronyMemory为实标量负卷积。derivative量化任意c∈ℝ、τ>0、连续p:ℝ→ℝ及任意实t，导数为−η/τ−(c/τ)p；负时间采用定向区间积分，结论亦成立。pronyMomentumDrift为任意F、η、R的F+Ση+R。sum定理对有限K、正cτ、连续向量p及任意t，结论是各坐标卷积和等于对角Prony核的memoryDrag，有限求和可交换积分。未给整个GLE解等价或存在性定理，已披露。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pronyMemory`：定义
- `MD.Ch08.pronyMemory_derivative`：未证；缺大型理论
- `MD.Ch08.pronyMomentumDrift`：定义
- `MD.Ch08.pronyMemory_sum`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7.1-PronyOUStationarity

印刷页 376 / PDF页 397。

### 1. 原文陈述

> dRᵢₖ=−Rᵢₖdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ; E Rᵢₖ=0 and E[Rᵢₖ(t+s)Rᵢₖ(t)]=(k_BT cₖ/τₖ)e^(−s/τₖ). Rᵢ=ΣₖRᵢₖ. (8.65)–(8.67).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 单个Prony OU的完整资格及平稳均值/协方差目标、总随机力定义。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 为(8.66)补平稳Gaussian初态及其与未来整条W独立；确定初态OU一般没有所印不依赖t的协方差。多分量实际实现使用独立W坐标。
- 已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。
- 覆盖缺口：已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。stationaryPronyOU明确含概率及标准Wiener资格、cτθ>0、R0~N(0,θc/τ)、R0与整条W独立、非负时间a.s.连续及各时刻L²，并以积分方程表示噪声系数sqrt(2θc)/τ。covariance在这些假设及t,s≥0下给出零均值和θc/τ·exp(−s/τ)，正确。totalPronyRandomForce只定义有限和，不证明跨模式独立或总协方差。原页未写平稳初态，原印无条件均值与相关性断言需人工确认；所加初态属于必要[EXTRA]，不是照录原文前提。
原文版：原印无初态的相关式待导师；原送审已补平稳初态的签名PASS。
修正版：本轮增加同一有效结论的_corrected独立名称，待复审；非总随机力协方差。
当前：待复审 / EAUDIT03。
原书疑点：[ERRATUM?] 保留原印相关式并加[ERRATUM?]，明确它在平稳初态下成立；保留已写入Lean的Gaussian初态及独立性。；[ERRATUM?] 原页(8.66)省略平稳初态；Lean补入的初始Gaussian律及其与W独立是必要资格。；已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。

### 7. 状态与证明位置

- `MD.Ch08.stationaryPronyOU`：定义
- `MD.Ch08.pronyOU_covariance`：未证；缺大型理论
- `MD.Ch08.totalPronyRandomForce`：定义
- `MD.Ch08.pronyOU_covariance_corrected`：未证；缺大型理论；证明体已写完，但传递依赖未证陈述

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7.1-CombinedPronyVariable

印刷页 376 / PDF页 397。

### 1. 原文陈述

> σᵢₖ=ηᵢₖ+Rᵢₖ yields dσᵢₖ=−σᵢₖdt/τₖ−cₖpᵢdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ. (8.68)–(8.70).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 有限维扩展SDE完整积分规格及σ=η+R的漂移恒等式。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 额外变量取实数；正质量、c、τ、温度和独立标准向量Wiener写入解规格。e仅把有限噪声坐标编号为(k,i)。
- 本条实际是加性扩展SDE和漂移合并恒等式；Markov半群构造、解存在唯一及与非Markov GLE分布等价列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。GLEState=(q,p,σ)，共有n个位置、n个动量和K·n个辅助分量。gleDrift三块为invm·p、−∇U+Σσ、−σ/τ−cp/τ；gleNoise仅在由等价e编号的(k,i)辅助分量注入sqrt(2θc_k)/τ_k。isExtendedGLESolution要求正逆质量、温度、Prony资格、C¹势，并展开additiveSDE的独立Wiener、路径连续、自然历史可测、漂移可积和每个非负t的积分方程；x0为确定态。additiveSDE额外对整个实轴要求连续，虽较物理半轴范围强，属于选定解规格。combinedProny_drift是所有实η,R,c,τ,p上的代数恒等式，包括总化τ=0。未把确定初态规格声称为平稳GLE的分布等价。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.GLEState`：定义
- `MD.Ch08.gleDrift`：定义
- `MD.Ch08.gleNoise`：定义
- `MD.Ch08.isExtendedGLESolution`：定义
- `MD.Ch08.combinedProny_drift`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7.1-PronyLangevinLimit

印刷页 376–377 / PDF页 397–398。

### 1. 原文陈述

> Formally τₖ→0 gives σᵢₖdt=−cₖpᵢdt+√(2k_BT cₖ)dWᵢₖ and Langevin friction γ̂=Σₖcₖ. Independent Gaussian variances add.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 仅形式极限系数与真实有限个独立Gaussian线性组合；τ→0过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。pronyEffectiveFriction是任意有限系数和。drift对任意实c,F,p给F−Σ(c_kp)=F−(Σc_k)p，是形式系数合并。Gaussian定理要求c_k≥0和R的完整联合分布为标准正态乘积，故其sqrt(c)加权和确为均值0、方差Σc的Gaussian；K=0退化为δ0亦正确。HasLaw结论不是仅方差计算。没有τ参数或过程收敛断言；原页τ→0只属informal sense，现有缺口标注准确。原页求和上限kmax、ℓ、N_k书写不统一，本条统一有限K，不据此添加实际极限定理。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pronyEffectiveFriction`：定义
- `MD.Ch08.pronyLimit_drift`：已证
- `MD.Ch08.independentGaussian_varianceSum`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7.1-GeneralizedLangevinIntegrator

印刷页 377 / PDF页 398。

### 1. 原文陈述

> The four-step method updates p_half, q_new, σ_new,k=θₖσₖ−(1−θₖ)cₖp_half+αₖ√(2k_BT cₖ)Zₖ, then p_new with the new force and new σ.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- h>0，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。
- 此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。
- 覆盖缺口：此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。

### 6. 审计结论（含网站结论）

网站首轮：PASS。gleIntegrator定义四步完整映射：旧σ与旧力得到ph；正向位置用invm·ph；sn使用旧σ、ph和各Z分量；新动量使用新位置力及sn。decay对应原θ_k，noise对应α_k，θ参数对应kBT，避免同名混淆。gleNormalSequence包含概率性、跨步iIndepFun及每步模式×坐标的标准正态乘积律；由此保证所有有限噪声坐标独立。单步函数本身对任意实参数定义，物理h、质量、c、τ、温度正域在[EXTRA]中明示，未声明任意参数下的精度、稳定或采样定理。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.gleIntegrator`：定义
- `MD.Ch08.gleNormalSequence`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.7.1-GLEConsistentCoefficients

印刷页 377 / PDF页 398。

### 1. 原文陈述

> For consistency θₖ=1−h/τₖ+O(h²), αₖ=√h/τₖ+O(h). Choose θₖ=exp(−h/τₖ), αₖ=√((1−θₖ)²/h).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 两项一致性渐近和所选单步系数的τ→0极限。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- h从正侧趋0、τ固定正；小记忆极限另固定h>0，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。

### 6. 审计结论（含网站结论）

网站首轮：PASS。gleDecay=exp(−h/τ)，gleNoiseCoefficient=sqrt((1−decay)²/h)，平方位置与原页一致。consistency谓词两项BigO均取h→0⁺：decay−(1−h/τ)=O(h²)，noise−sqrt(h)/τ=O(h)。τ固定正时noise=(1−exp(−h/τ))/sqrt(h)，余项实际O(h^(3/2))，故所要求O(h)成立。smallMemory固定h>0取τ→0⁺，极限为(0,1/sqrt(h))，结论正确。未把两个不同参数极限混为过程极限或长期采样结论。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.gleDecay`：定义
- `MD.Ch08.gleNoiseCoefficient`：定义
- `MD.Ch08.gleCoefficientConsistency`：定义
- `MD.Ch08.gleCoefficients_consistent`：未证；缺大型理论
- `MD.Ch08.gleCoefficient_smallMemory`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8-NPTThermodynamics

印刷页 378 / PDF页 399。

### 1. 原文陈述

> P=−(∂E/∂V)_{S,N}; the Maxwell cyclic relation gives (∂S/∂V)_{E,N}=P/T and (∂S/∂E)_{V,N}=1/T.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- E的熵、体积、粒子数参数固定顺序明示；Maxwell循环作为热力学可逆导数资格，并非从任意E无条件推出。

### 6. 审计结论（含网站结论）

网站首轮：PASS。thermodynamicPressure的E参数顺序S,V,N明确，固定S,N对V取导再取负，忠实。maxwellCycle只是三个实数乘积等于−1的资格；maxwellPressureRelation量化T,P,dVdS，前提T≠0及(1/T)(−P)dVdS=−1，推出(dVdS)⁻¹=P/T，正确且前提自动排除P和dVdS为0。这里未从任意E构造熵反函数，也未独立证明dSdE=1/T；将其作为热力学识别及循环资格的[EXTRA]是已披露的范围选择。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.thermodynamicPressure`：定义
- `MD.Ch08.maxwellCycle`：定义
- `MD.Ch08.maxwellPressureRelation`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8-NPTBathTaylor

印刷页 378 / PDF页 399。

### 1. 原文陈述

> S(N₂,V₂,E₂)=S(Ñ−N,Ṽ−V,Ẽ−E)≈S(N₂,Ṽ,Ẽ)−(E+PV)/T.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 固定粒子数参数，只对E,V的小扰动；显式Fréchet可微及热力学导数识别，不把原文≈当作精确等式。

### 6. 审计结论（含网站结论）

网站首轮：PASS。nptBathLinear=S0−(E+PV)/T，与原页正压力项及整体负号相符。定理固定E0,V0,T,P，以T>0、S在(E0,V0)可微及完整Fréchet导数v↦v1/T+(P/T)v2为前提，结论对z→0的二维扰动给出误差o(‖z‖)。参数顺序在Lean为(E,V)，与原页S(N,V,E)的固定N切片需对应，已有说明；没有把≈强化成精确等号或O(‖z‖²)，亦不涉及粒子数变化。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nptBathLinear`：定义
- `MD.Ch08.nptEntropy_firstOrder`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8-NPTDensity

印刷页 378–379 / PDF页 399–400。

### 1. 原文陈述

> ρ_NPT=Z_NPT⁻¹ exp[−β(H+PV)], β⁻¹=k_BT; physical volume V is positive.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 三维N粒子时n=3N；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。

### 6. 审计结论（含网站结论）

网站首轮：PASS。Phase n为n个实坐标及动量；nptBox要求V>0且各坐标位于边长V^(1/3)盒内，动量无限制。nptWeight以H(q,p,V)+PV为能量，nptDensity的Z确为同一受限Lebesgue测度积分。normalizes只在β>0、权重可积及Z>0下给非负、可积、积分1的probabilityDensity完整结论，未无条件断言配分函数有限。物理n=3N时质量需按粒子三坐标重复，属坐标解释；不需要在此引入误用Pi最大范数。原页只给密度形状，所选盒域及可积性是披露的[EXTRA]。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.volumeScale`：定义
- `MD.Ch08.nptBox`：定义
- `MD.Ch08.nptWeight`：定义
- `MD.Ch08.nptDensity`：定义
- `MD.Ch08.nptDensity_normalizes`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8-AndersenCoordinates

印刷页 379–380 / PDF页 400–401。

### 1. 原文陈述

> qᵢ=V^{1/3}q̄ᵢ; q̇ᵢ=(1/3)V^{−2/3}V̇q̄ᵢ+V^{1/3}q̄̇ᵢ; p̄ᵢ=mᵢV^{1/3}q̇ᵢ. (8.71),(8.72).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- V>0用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。
- 覆盖缺口：V>0用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。

### 6. 审计结论（含网站结论）

网站首轮：PASS。andersenPosition=V^(1/3)qbar；Velocity两项系数1/3·V^(−2/3)Vdot、V^(1/3)正确。Momentum两项幂为−1/3和2/3，正是mV^(1/3)·Velocity。导数定理对任意曲线V,qbar、时刻t及给定导数Vdot,vbar，要求V(t)>0并给两个HasDerivAt前提，完整结论正确；第二定理任意m,Vdot,qbar,vbar且V>0，给逐分量动量等式。m不要求正不妨碍这些代数恒等式；未证明共轭动量的变分定义或完整正则变换，范围已限定为坐标关系。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.andersenPosition`：定义
- `MD.Ch08.andersenVelocity`：定义
- `MD.Ch08.andersenMomentum`：定义
- `MD.Ch08.andersenPosition_derivative`：未证；缺大型理论
- `MD.Ch08.andersenMomentum_velocity`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8-AndersenKineticEnergy

印刷页 379 / PDF页 400。

### 1. 原文陈述

> After q=V^{1/3}q̄, K̄=Σᵢ(mᵢ/2)[(1/9)V^{−4/3}V̇²|q̄ᵢ|²+(2/3)V^{−1/3}V̇q̄ᵢ·q̄̇ᵢ+V^{2/3}|q̄̇ᵢ|²].

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 坐标逐分量求和就是三维点积展开，避免把Pi类型的最大范数误作物理Euclidean长度；V正。

### 6. 审计结论（含网站结论）

网站首轮：PASS。andersenKinetic按坐标求Σm_i v_i²/2，Expanded三项指数−4/3、−1/3、2/3和系数1/9、2/3、1均正确。任意n,m,Vdot,qbar,vbar及V>0下展开成立；m无需正才能证明恒等式。把三维粒子逐分量展开时需n=3N并让同一粒子三坐标使用相同m_i，避免将Pi的默认范数误作Euclidean范数。没有漏掉交叉项或误把内积写成逐分量最大值。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.andersenKinetic`：定义
- `MD.Ch08.andersenKineticExpanded`：定义
- `MD.Ch08.andersenKinetic_expansion`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8-AndersenHamiltonianPrinted

印刷页 380 / PDF页 401。

### 1. 原文陈述

> Ĥ=Σᵢ|p̄ᵢ|²/(2mᵢV^{2/3})+Ū(q̄;V)+p_V²/(2μ_V)+PV, and ρ_NPT=√(β/(2πμ_V))∫exp(−βĤ)dp_V. (8.73).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。
- [EXTRA] andersenMarginal_corrected本身仅为除以Z的函数定义；要解释为概率密度须另证明Z等于正确域上正有限配分积分。
- [EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。
- 覆盖缺口：[EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。Hamiltonian对象z=((qbar,pbar),V),pV的嵌套投影正确，包含Σpbar_i²/(2m_i V^(2/3))、U(V^(1/3)qbar)、pV²/(2QV)、PV。Printed定义忠实于原印平方根系数及实pV的Lebesgue积分。Gaussian_marginal在QV,β,V>0下给未归一权重，点态积分消元正确；m正性并非该高斯消元恒等式必要条件。corrected除以独立参数Z，作为权重公式合理，但定义无Z>0或Z等于配分积分条件，不能单凭名称称归一概率。原印把该未归一权重称ρ_NPT，与前页Z_NPT⁻¹相差因子，保留并交人工确认。
原文版：Printed忠实性PASS；相对归一NPT密度缺配分因子。
修正版：原送审Gaussian消元及除Z权重合理；正有限配分积分未保证，不宣称概率归一。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。；[ERRATUM?] 保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意Z>0。

### 7. 状态与证明位置

- `MD.Ch08.andersenHamiltonian`：定义
- `MD.Ch08.andersenMarginalPrinted`：定义
- `MD.Ch08.andersenMarginal_corrected`：定义
- `MD.Ch08.andersenGaussian_marginal`：未证；原书疑误不证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.1-NHLPistonEquations

印刷页 381–382 / PDF页 402–403。

### 1. 原文陈述

> q̇=M⁻¹p+ηq, ṗ=F−ηp−ξp, V̇=ηV; dξ=(h_T−γ_Tξ)dt+√(2k_BTγ_T/μ_T)dW_T, dη=(h_P−γ_Pη)dt+√(2k_BTγ_P/μ_P)dW_P, with h_T=(pᵀM⁻¹p−N_dk_BT)/μ_T and h_P=(VΠ−PV+k_BT)/μ_P. (8.75)–(8.79).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- z.2=(V,ξ,η)，V>0、热浴/活塞质量正、独立二维Wiener明确；所有辅助变量除V均为实数。
- 选择正体积域内的积分解类，不声明该类存在唯一或必然遍历；n=3N为物理情形。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 PistonState=Phase n×Vec 3，辅助坐标依次为V、ξ、η；pistonPressure含动能二倍项、位置virial项及显式体积偏导，分母V。pistonDrift的q、p、V及两个反馈/OU漂移均对应(8.75)–(8.79)，pistonNoise仅在ξ、η给出两条独立噪声。isNHLPistonSolution对逆质量、温度、QT、QP、γ、U的光滑性、初值与每个非负时刻几乎处处正体积逐项限定，并展开additiveSDE检查了概率测度、独立Brownian、连续路径、自然历史可测性、漂移积分及积分等式。它是选定解类的定义，不是存在唯一或遍历定理；n推广为一般自由度数合理。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.PistonState`：定义
- `MD.Ch08.pistonPressure`：定义
- `MD.Ch08.pistonDrift`：定义
- `MD.Ch08.pistonNoise`：定义
- `MD.Ch08.isNHLPistonSolution`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.1-PistonHamiltonianSubfield

印刷页 381 / PDF页 402。

### 1. 原文陈述

> ρ₁=φ₁(pᵀM⁻¹p/2+U(q))ψ(V,ξ,η) is stationary for the Hamiltonian part.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 原印p子场、M⁻¹p修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只陈述实际通量散度为零；φ,ψ是权重而非自动概率密度，归一、可积和全局保测流不在本条。
- 已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。pistonHamiltonianPart实际使用(M⁻¹p,−∇qU,0)，权重使用K/2+U及任意C¹冻结变量乘子；U为C²、φ与ψ为C¹，结论为任意z处真实通量散度为零，对任意逆质量参数该恒等式成立，无需概率资格。但是原页在文字中把向量场印为(p,−∇U,0,0,0)，不是Lean中的M⁻¹p。原JSON只称Hamiltonian part，未揭示这个原印与合理修正的差别，不能将修正默认为逐字忠实。
原文版：原书印为p，旧Lean采用M⁻¹p的合理修正，不能混称忠实。
修正版：旧修正场及其局部驻定数学签名获认可；本轮新增Printed/修正版名称待复审。
当前：待复审 / EAUDIT04。
原书疑点：保留原页文字；在issues显式标[ERRATUM?]：原印p应为M⁻¹p（或注明单位质量约定）。给现有Hamiltonian子场标为合理修正，不将其与原印向量场混同。；已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。

### 7. 状态与证明位置

- `MD.Ch08.pistonHamiltonianPart`：定义
- `MD.Ch08.pistonHamiltonianWeight_stationary`：未证；缺大型理论
- `MD.Ch08.pistonHamiltonianPartPrinted`：定义
- `MD.Ch08.pistonHamiltonianPart_corrected`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.1-PistonThermostatWeightPrinted

印刷页 381 / PDF页 402。

### 1. 原文陈述

> The book prints ρ₂=exp(−β[pᵀM⁻¹p+μ_Tξ²/2])ψ₂(q,η,V) for ṗ=−ξp, ξ̇=(pᵀM⁻¹p−N_dk_BT)/μ_T.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 本条数学成分 | 原印/修正权重及ψ₂=1时的实际子场驻定目标。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 仅取ψ₂=1的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。pistonThermostatPart在p上为−ξp、ξ上为(K−nθ)/QT，其他坐标冻结。pistonRho2Printed忠实保留原页动能项缺少1/2；pistonRho2_corrected恢复K/2。stationary_corrected量化所有正逆质量、β、QT和任意z，并把θ设为β⁻¹，结论div(ρF)=0正确。ψ₂=1的覆盖缩减在extra_assumptions已明示，不要求补任意冻结乘子或归一性。原印驻定断言数学错误仍须人工确认勘误；Printed定义自身忠实，修正版签名正确。
原文版：Printed忠实性PASS；原印动能缺1/2。
修正版：原送审恢复1/2的_corrected及局部驻定签名PASS，ψ₂=1。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。；保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。

### 7. 状态与证明位置

- `MD.Ch08.pistonThermostatPart`：定义
- `MD.Ch08.pistonRho2Printed`：定义
- `MD.Ch08.pistonRho2_corrected`：定义
- `MD.Ch08.pistonRho2_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.1-PistonReducedPDE

印刷页 382 / PDF页 403。

### 1. 原文陈述

> −q·∇qψ+p·∇pψ−ψ−V∂Vψ+(βVΠ−βPV+1)ψ=0, solved by ψ∝exp(−β(H+PV)). (8.74).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。
- 覆盖缺口：只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。

### 6. 审计结论（含网站结论）

网站首轮：PASS。pistonReducedOperator的两个方向导数分别是−q·∇qψ和p·∇pψ，独立的−ψ及−V∂Vψ均保留，末项是(βVΠ−βPV+1)ψ。boltzmann对任意逆质量、P及C²势，在β>0、V>0下断言所给指数权的算子值为零；代入得到βq·∇U−βK−1+βV∂VU+βPV+βVΠ−βPV+1=0。没有把局部PDE扩展为全局不变概率。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pistonReducedOperator`：定义
- `MD.Ch08.pistonReduced_boltzmann`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.1-PistonStationaryWeight

印刷页 382 / PDF页 403。

### 1. 原文陈述

> Adding the two independent OU thermostats to ξ,η preserves the candidate weight exp[−β(H+PV+μ_Tξ²/2+μ_Pη²/2)].

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只陈述正V内的真实Fokker–Planck微分表达式为零；候选正权重并不自动可积/归一。
- 盒边界/体积边界的通量、Markov半群不变概率及唯一遍历性需要NPT理论，明确列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。pistonWeight包含K/2、U(q,V)、PV及两个辅助二次能量；pistonForward为−div(ρa)+(1/2)ΣD²ρ[Bj,Bj]，扩散常量而无需额外导数项。定理量化全部物理参数、正逆质量、C²势和任意正体积状态，θ=β⁻¹、γ允许零。Hamiltonian、修正热浴、活塞及两OU部分分别消去，结论是局部前向表达式零。可积性、边界通量和半群不变性均未声称且已标明缺口。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pistonWeight`：定义
- `MD.Ch08.pistonForward`：定义
- `MD.Ch08.pistonWeight_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.2-PistonIntegrator

印刷页 383 / PDF页 404。

### 1. 原文陈述

> The printed algorithm interleaves feedback half-updates, exponentially damped momentum kicks, exponential position/volume drifts, feedback recomputation and final independent OU steps. ψ(α,t)=(e^{αt}−1)/α, extended by t at α=0.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 正β、QT、QP、质量、体积及h≥0是物理有效域；R取独立标准二维正态且跨步独立，参照independentWiener/standardNormalSequence所列资格。
- 零指数分支按原页连续延拓；周期位置在每次q/V更新后按当前盒长映射。只定义完整算法，不证明二阶、可逆或不变分布精度。

### 6. 审计结论（含网站结论）

网站首轮：PASS。expIntegrated的零参数分支和非零公式与原页一致；pistonMomentumKick符号及两个半步位置、pistonFeedback先后计算所用状态、q指数全步、第二个动量半步、V指数全步、反馈重算和最终两OU步的顺序一致。pistonWrap使用当前V^(1/3)的居中周期代表，每次q或V更新后调用，原书未固定基本立方体原点，此选择合理。pistonOU_volume对全部参数成立；pistonVolume_positive只需V>0，因为指数恒正。积分器本体是以R为输入的确定映射；独立标准正态及跨步独立是外部采样约定，不是此Lean定义已经编码的概率断言。物理参数资格也是使用域约定，不是定义的前提。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.expIntegrated`：定义
- `MD.Ch08.pistonWrap`：定义
- `MD.Ch08.pistonMomentumKick`：定义
- `MD.Ch08.pistonFeedback`：定义
- `MD.Ch08.pistonOU`：定义
- `MD.Ch08.pistonIntegrator`：定义
- `MD.Ch08.pistonOU_volume`：已证
- `MD.Ch08.pistonVolume_positive`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.8.3-ParrinelloRahman

印刷页 385 / PDF页 406。

### 1. 原文陈述

> For cell matrix h=[a b c], V=det(h)=a·(b×c), qᵢ=hq̄ᵢ, G=hᵀh, L=(1/2)Σmᵢq̄̇ᵢᵀGq̄̇ᵢ−Ū(q̄)+(μ/2)Tr(ḣᵀḣ)−PV.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 选定正定向非退化盒det(h)>0及正质量；U为缩放坐标势，必要时由实际h映射后势复合而得。
- 拉氏方程、与热浴耦合和防止盒塌缩均未在原页给完整条件，列覆盖缺口，不把内部结构的经验稳定性当定理。

### 6. 审计结论（含网站结论）

网站首轮：PASS。cellVolume、cellMetric、cellPosition、cross3及cellVolume_triple的对象、列向量顺序和行列式符号均与原页相同；三重积恒等式对全部3×3实矩阵成立。Lagrangian的粒子质量系数1/2、G=hᵀh、缩放速度、势能负号、Q/2迹项和−Pdet(h)逐项一致。cellQualification明确正质量、正人工质量及正行列式；它与代数定义分开合理。原页缩放坐标在[0,1]的盒内资格没有写入cellPosition，但一般坐标线性映射及Lagrangian公式仍有效，不能从这些定义推导粒子始终在盒内或防塌缩结论。势函数按原页Ū(qbar)记为输入函数，本条未形式化随h变化的一般实际势。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.cellVolume`：定义
- `MD.Ch08.cellMetric`：定义
- `MD.Ch08.cellPosition`：定义
- `MD.Ch08.cross3`：定义
- `MD.Ch08.cellVolume_triple`：已证
- `MD.Ch08.parrinelloRahmanLagrangian`：定义
- `MD.Ch08.cellQualification`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9-TotalMomentum

印刷页 386 / PDF页 407。

### 1. 原文陈述

> With central conservative forces ΣᵢFᵢ=0, Nosé dynamics gives d p_tot/dt=−ξ p_tot. Zero total momentum is formally invariant.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只证明瞬时总力恒等式；沿连续轨道的零动量不变需要ODE唯一性，有限精度“飞冰块”属经验现象，列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。totalMomentum是所有粒子的d维向量和。noseTotalForce量化任意F、p及ξ，唯一力前提为ΣF=0，结论Σ(F−ξp)=−ξΣp正确；noseTotalForce_zero增加Σp=0后得到瞬时总力零。N、d允许零不损害此代数恒等式。没有把瞬时恒等式冒充沿轨迹不变性；ODE及数值误差现象已列覆盖缺口。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.ParticleConfig`：定义
- `MD.Ch08.ParticlePhase`：定义
- `MD.Ch08.totalMomentum`：定义
- `MD.Ch08.noseTotalForce`：已证
- `MD.Ch08.noseTotalForce_zero`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.1-DPDSoftPotential

印刷页 387–388 / PDF页 408–409。

### 1. 原文陈述

> rᵢⱼ=|qᵢ−qⱼ|, eᵢⱼ=(qᵢ−qⱼ)/rᵢⱼ. Fᶜᵢⱼ=α(1−rᵢⱼ/r_c)eᵢⱼ for rᵢⱼ<r_c, zero otherwise; φ_DPD=(αr_c/2)(1−r/r_c)² below cutoff, U=Σᵢ<ⱼφ(rᵢⱼ). (8.80)–(8.84).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- d维Euclidean距离由坐标平方和开方，避免Pi最大范数；只在非碰撞且离开截断接缝的有效域声明梯度关系。N、d为物理正整数，mᵢ>0在动力学资格另列。

### 6. 审计结论（含网站结论）

网站首轮：PASS。pairDistance通过坐标平方和开方表示欧氏距离，pairDirection给出差向量除距离。软势和成对保守力的r<rc/otherwise分支、系数αrc/2与α(1−r/rc)一致；dpdPotential按i<j只数一次，dpdConservative按j≠i求总力。particleGradient逐坐标取Fréchet导数。梯度定理对非负α、正rc、任意配置，并假设所有异粒子非碰撞且不在截断接缝，结论总保守力=−势梯度正确。r=0处的总化不声称物理方向存在。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pairDistance`：定义
- `MD.Ch08.pairDirection`：定义
- `MD.Ch08.dpdSoftPotential`：定义
- `MD.Ch08.dpdPairConservative`：定义
- `MD.Ch08.dpdPotential`：定义
- `MD.Ch08.dpdConservative`：定义
- `MD.Ch08.particleGradient`：定义
- `MD.Ch08.dpdConservative_gradient`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.1-DPDPairForces

印刷页 388 / PDF页 409。

### 1. 原文陈述

> Fᴰᵢⱼ=−γ ωᴰ(rᵢⱼ)(eᵢⱼ·vᵢⱼ)eᵢⱼ, Fᴿᵢⱼ=σ ωᴿ(rᵢⱼ)θᵢⱼeᵢⱼ, ωᴿ(r)=1−r/r_c below cutoff. vᵢⱼ=pᵢ/mᵢ−pⱼ/mⱼ. (8.85)–(8.87).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 白噪声θᵢⱼ不作为逐点函数使用；随机力的实际意义是下一条无序对独立Wiener驱动、双方相反的扩散向量。总化r=0只作辅助，在动力学中要求非碰撞。

### 6. 审计结论（含网站结论）

网站首轮：PASS。dpdWeightR正确实现(8.87)的两个分支；relativeVelocity是pi/mi−pj/mj；耗散力的负γ、权函数、内积和方向乘子及总和无漏项。dpdPairRandom以标量R表示形式随机振幅；dpdNoise以一个无序对坐标给双方相反的动量冲量、位置分量为零，是后续Wiener驱动的扩散系数。这里没有把白噪声当作逐点可微随机过程；正质量及非碰撞资格由后续解定义承接。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.dpdWeightR`：定义
- `MD.Ch08.relativeVelocity`：定义
- `MD.Ch08.dpdPairDissipative`：定义
- `MD.Ch08.dpdPairRandom`：定义
- `MD.Ch08.dpdDissipative`：定义
- `MD.Ch08.pairImpulseVector`：定义
- `MD.Ch08.dpdNoise`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.1-DPDPairWiener

印刷页 388–389 / PDF页 409–410。

### 1. 原文陈述

> θᵢⱼ=θⱼᵢ; E θᵢⱼ=0 and E[θᵢⱼ(t)θₖₗ(t′)]=(δᵢₖδⱼₗ+δᵢₗδⱼₖ)δ(t−t′). Distinct unordered pairs are independent. (8.88).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只对无序对使用独立标准Wiener；Wᵢⱼ=Wⱼᵢ由同一坐标实现，不能把有序对全部设独立。Dirac白噪声公式通过有限时间增量协方差表达。

### 6. 审计结论（含网站结论）

网站首轮：PASS。pairEnumeration完整要求i<j、单射及覆盖全部i<j无序对。pairNoiseIncrement同一坐标用于两种方向，故对称性对任意pairs及W都成立。协方差定理要求概率独立标准Wiener、s≥0、s≤t、两个粒子对均无自配对，结论同一无序对为t−s、不同无序对为0，正是(8.88)在共同时间区间上的积分形式；两个Kronecker项在这些前提下不同时为1。零均值和跨坐标独立由Wiener定义承接，不额外声称已证明任意两区间的协方差公式。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pairEnumeration`：定义
- `MD.Ch08.pairNoiseIncrement`：定义
- `MD.Ch08.pairNoiseIncrement_symmetric`：未证；时间盒止
- `MD.Ch08.pairNoiseIncrement_covariance`：未证；时间盒止

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.1-DPDIntegralSystem

印刷页 389 / PDF页 410。

### 1. 原文陈述

> dq=M⁻¹pdt, dp=−∇Udt−Δ(q)pdt+Σ(q)dW. (8.90).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 实际多维独立Wiener、共同自然历史适应、联合可测、路径连续、漂移可积、所有网格左和及积分代表L²均明示。
- 选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。
- 覆盖缺口：选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。

### 6. 审计结论（含网站结论）

网站首轮：PASS。strictItoIntegral8展开itoLeftSum后是K等分网格的左端点评价乘W增量；明确所有左和与Y属于L²，平方误差积分趋零，K=0项不影响atTop极限。multiplicativeSDE8包含共同自然历史适应、联合可测、扩散可测、非负时间连续路径及初值、漂移可积，并对每个非负T及连续线性泛函ell指定各噪声积分代表与完整积分等式；在本条有限维实状态空间中足以按坐标解释积分方程。dpdDrift逐项使用正质量速度、保守总力和耗散总力；isDPDSolution明示正N、d、质量、rc、温度，非负α、γ，FD关系及完整无序对枚举。它选择强L²解类，不断言所有弱解均满足此规格。非碰撞条款的精确量词是每个确定t几乎处处，并非已经证明存在一个公共满测集上对全部t同时非碰撞。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.strictItoIntegral8`：定义
- `MD.Ch08.multiplicativeSDE8`：定义
- `MD.Ch08.dpdDrift`：定义
- `MD.Ch08.isDPDSolution`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.1-DPDCanonicalLeaf

印刷页 389 / PDF页 410。

### 1. 原文陈述

> ωᴰ=(ωᴿ)², σ²=2γk_BT. The canonical density is restricted to fixed total momentum π by δ(Σp−π). (8.89).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

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
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Dirac乘积解释为指定动量叶上的参考测度，未伪造Lebesgue密度；参考测度需另指定几何/周期体积。
- 只是权重与概率资格目标；DPD保持该测度、流体力学保持及高密度一维遍历性的大型定理均列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。dpdFluctuationDissipation记录γ≥0、θ>0、σ²=2γθ和全部r的wD=wR²；momentumLeaf是总动量等于π的相空间子集，d维推广与原三维δ约束一致。particleHamiltonian逐粒子给出|pi|²/(2mi)+U。momentumCanonical相对于输入参考测度ν作归一指数加权；qualification要求ν集中于该叶、正质量、β>0、权重可积且配分函数严格正，并显式要求所定义测度为概率。它未自动选定几何叶测度，也未把FD资格与βθ=1、DPD解或不变性定理连接起来；这些覆盖缺口已经明示，不能把定义当作不变性证明。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.dpdFluctuationDissipation`：定义
- `MD.Ch08.momentumLeaf`：定义
- `MD.Ch08.particleHamiltonian`：定义
- `MD.Ch08.momentumCanonical`：定义
- `MD.Ch08.momentumCanonicalQualification`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.1-DPDMassOrderPrinted

印刷页 389 / PDF页 410。

### 1. 原文陈述

> For dp=−∇Udt−Δ(q)pdt+Σ(q)dW, the book gives Δ=M⁻¹ΣΣᵀ/(2k_BT).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdMatrixFDPrinted {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • (M⁻¹*(B*B.transpose))
def dpdMatrixFD_corrected {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • ((B*B.transpose)*M⁻¹)
theorem dpdMassOrder_counterexample :
    (!![1,0;0,(1/2 : ℝ)]) * (!![1,-1;-1,1]) ≠
      (!![1,-1;-1,1]) * (!![1,0;0,(1/2 : ℝ)]) := by
  intro h
  have hh := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ ↦ A 0 1) h
  norm_num [Matrix.mul_apply,Fin.sum_univ_two] at hh
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/校正的质量矩阵次序及具体代数反例。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- 覆盖缺口：M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。dpdMatrixFDPrinted保留原印左乘M⁻¹，dpdMatrixFD_corrected将其放在右侧；两者只定义矩阵等式，无正定性或θ>0前提并不使定义失真，物理解释须使用标出的资格。dpdMassOrder_counterexample量化的是两个明确2×2矩阵的不交换性，(0,1)元已足以区分。对于成对DPD的对称阻尼核A=BBᵀ/(2θ)，作用于速度M⁻¹p的耗散给Γ=AM⁻¹，修正合理。原印关系对一般不等质量不成立，需保留并人工确认；此处没有声称该右乘关系是所有可能非对称OU阻尼的唯一驻定条件。
原文版：Printed忠实性PASS；一般不等质量的乘法次序错误。
修正版：原送审右乘M⁻¹修正版与不交换反例PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。；保留Printed等式；[ERRATUM?]记录一般质量情形改为ΣΣᵀM⁻¹/(2kBT)，标注等质量或交换条件下两者相同。

### 7. 状态与证明位置

- `MD.Ch08.dpdMatrixFDPrinted`：定义
- `MD.Ch08.dpdMatrixFD_corrected`：定义
- `MD.Ch08.dpdMassOrder_counterexample`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.2-DPDVelocityVerlet

印刷页 389–391 / PDF页 410–412。

### 1. 原文陈述

> p½=p+hFᶜ(q)/2+hFᴰ(q,p)/2+√h Fᴿ(q,Rold)/2; q'=q+hM⁻¹p½; p'=p½+hFᶜ(q')/2+hFᴰ(q',p½)/2+√h Fᴿ(q',Rnew)/2. Reuse Rnew next step. (8.91)–(8.93).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdRandomForce {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ)
    (wR : ℝ → ℝ) (q : ParticleConfig N d) (R : Vec K) : ParticleConfig N d :=
  ∑ k, R k • (dpdNoise pairs σ wR q k).2

def dpdVerlet {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ)
    (state : ParticlePhase N d × Vec K) (Rnew : Vec K) : ParticlePhase N d × Vec K :=
  let q := state.1.1
  let p := state.1.2
  let ph := p+(h/2) • dpdConservative α rc q+(h/2) • dpdDissipative m γ wD q p+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR q state.2
  let qn := fun i ↦ q i+(h/m i) • ph i
  let pn := ph+(h/2) • dpdConservative α rc qn+(h/2) • dpdDissipative m γ wD qn ph+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR qn Rnew
  ((qn,pn),Rnew)

theorem dpdVerlet_reuse {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ) (z : ParticlePhase N d × Vec K) (R : Vec K) :
    (dpdVerlet pairs m α rc γ σ h wD wR z R).2=R := rfl
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 三条更新式和新噪声在下一步复用的状态机制。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 物理用法要求mᵢ>0、h≥0、无序对枚举、每步Rnew独立标准正态并与历史独立；本条确定性给定输入的扩展状态映射。
- 尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。
- 覆盖缺口：尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 dpdRandomForce、dpdVerlet、dpdVerlet_reuse：N,d,K 均为自然数，配置为 Fin N → Fin d → ℝ，扩展状态为 ((q,p),Rold)，Rnew 为显式输入。成对噪声使用 σwR、反向等量冲量；两次动量半步的系数分别为 h/2、sqrt(h)/2，第二次耗散使用更新配置及半步动量；位置步 h/m_i 与 hM⁻¹ 一致。返回 Rnew，复用定理对全部实参数无条件成立。物理域正质量、非负步长、每个无序对恰枚举一次及独立标准正态输入已在 extra_assumptions 说明；这些不是定义自身的前提。按声明范围只审给定随机输入的状态映射，不把复用恒等式当作分布或收敛定理。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.dpdRandomForce`：定义
- `MD.Ch08.dpdVerlet`：定义
- `MD.Ch08.dpdVerlet_reuse`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.2-DPDSplitGenerator

印刷页 391 / PDF页 412。

### 1. 原文陈述

> The DPD system splits into A: free transport, B: conservative force, O: dissipative plus pair noise. L_DPD=L_A+L_B+L_O. (8.94)–(8.98).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdA {N d : ℕ} (m : Fin N → ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),0)
def dpdB {N d : ℕ} (α rc : ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  (0,dpdConservative α rc z.1)
def dpdO {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d := (0,dpdDissipative m γ wD z.1 z.2)
def firstOrder8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (f : E → ℝ) (z : E) : ℝ := fderiv ℝ f z (F z)
def dpdLO {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdO m γ wD) f z+
    (∑ k, fderiv ℝ (fun x ↦ fderiv ℝ f x) z (dpdNoise pairs σ wR z.1 k)
      (dpdNoise pairs σ wR z.1 k))/2
def dpdGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdA m) f z+firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
theorem dpdDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : dpdDrift m α rc γ wD z=dpdA m z+dpdB α rc z+dpdO m γ wD z := by
  ext <;> simp [dpdDrift,dpdA,dpdB,dpdO]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际三个漂移、无序对扩散生成元和漂移分解恒等式。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。
- 光滑测试函数上的形式生成元定义不等同于已建立Markov半群，Fₜ=eᵗᴸ及其定义域列缺口。
- 覆盖缺口：采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 dpdA/B/O、firstOrder8、dpdLO、dpdGenerator、dpdDrift_split：三个场的坐标和动量分量与(8.94)一致；firstOrder8 是 fderiv 沿场作用；dpdLO 是耗散一阶项加每个独立无序对噪声方向的 Hessian/2，dpdGenerator 再加入 A、B。漂移分解对任意 N,d、质量函数及实参数、状态成立，不需要正性。对于 i≠j 的无序对完整枚举和二阶光滑测试函数，原印(8.97)中两方向有序项合并成 −γωD u D_ij+(σ²ωR²/2)D_ij²，与定义一致；没有把外层仅 ∂pi 的单个有序项误判为完整成对算子。枚举性质、测试函数光滑性、半群及算子定义域未进入裸定义，已在文字规格限定，不存在相应已证等价定理。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.dpdA`：定义
- `MD.Ch08.dpdB`：定义
- `MD.Ch08.dpdO`：定义
- `MD.Ch08.firstOrder8`：定义
- `MD.Ch08.dpdLO`：定义
- `MD.Ch08.dpdGenerator`：定义
- `MD.Ch08.dpdDrift_split`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.2-DPDPairGeneratorPrinted

印刷页 392 / PDF页 413。

### 1. 原文陈述

> (8.100) prints L_Oij=[−γωᴰu+(σ²/2)(ωᴿ)² e·(∂pi−∂pj)] e·∂pi for each unordered pair i<j.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairDerivative {N d : ℕ} (i j : Fin N) (e : Vec d)
    (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  fderiv ℝ f p (pairImpulseVector i j e)
def dpdPairGeneratorPrinted {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*fderiv ℝ f p (Pi.single i e)+
    σ^2*wr^2/2*pairDerivative i j e (fun x ↦ fderiv ℝ f x (Pi.single i e)) p
def dpdPairGenerator_corrected {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*pairDerivative i j e f p+
    σ^2*wr^2/2*pairDerivative i j e (pairDerivative i j e f) p
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 冻结配置下单对动量生成元的原式和守恒方向修正版。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
- 覆盖缺口：本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。分别审校：pairDerivative 是沿 e 在 i 增、j 减的方向导数。dpdPairGeneratorPrinted 的漂移只沿 Pi.single i e，扩散为 (σ²wr²/2)D_ij∂i，忠实保留(8.100)的最外层 ∂pi；该原文版忠实性 PASS。dpdPairGenerator_corrected 将漂移和扩散的最外层都换为 D_ij，得到 −γwd u D_ij+(σ²wr²/2)D_ij²，符合独立单对守恒 SDE，修正版数学陈述 PASS。i,j、e及实参数在两定义中均无物理资格限制；单对物理解释须 i≠j、单位方向、正质量及涨落耗散条件，定义本身并未声称不变分布。原书紧随其后的单对保动量叶不变密度说法与原印算子冲突，需保留原式并人工确认勘误；不能因忠实原式存在疑误而判该 Printed 定义 FAIL。
原文版：Printed忠实性PASS；单对解释下最外层∂pi不保总动量。
修正版：原送审改用Dij的_corrected签名PASS；不据此否定完整有序双和。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。

### 7. 状态与证明位置

- `MD.Ch08.pairDerivative`：定义
- `MD.Ch08.dpdPairGeneratorPrinted`：定义
- `MD.Ch08.dpdPairGenerator_corrected`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.2-DPDSplittingCompositions

印刷页 392–393 / PDF页 413–414。

### 1. 原文陈述

> Shardlow: O(h) B(h/2) A(h) B(h/2); S=B+O and Trotter: S(h/2) A(h) S(h/2). Pair products use the printed fixed unordered-pair order. (8.99),(8.101),(8.102).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdShardlowComposition {E : Type*} (A B O : ℝ → E → E) (h : ℝ) : E → E :=
  O h ∘ B (h/2) ∘ A h ∘ B (h/2)
def dpdTrotterComposition {E : Type*} (A S : ℝ → E → E) (h : ℝ) : E → E :=
  S (h/2) ∘ A h ∘ S (h/2)
def sequentialPairComposition {E : Type*} (steps : List (E → E)) : E → E :=
  fun x ↦ steps.foldl (fun y F ↦ F y) x
def dpdSGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 两种外层组合、固定顺序逐对执行及S形式生成元；实际OU单对步骤见后条。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- A/B/O/S为调用者指定的映射；只保留所印组合顺序。尚未实现BBK成对近似或其误差、全O/S流及生成元指数关系。
- 两次S同顺序的非交换成对乘积不能仅凭外层回文判为对称；不作该声称。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 dpdShardlowComposition、dpdTrotterComposition、sequentialPairComposition、dpdSGenerator。任意类型 E 上的实时间输入映射按 Lean 函数组合从右向左作用，正好保留(8.99) O B½ A B½ 和原印 S½ A S½；foldl 将列表中的第一对最先执行，等于书中最后写在右侧的首个对因子先作用。S 的形式生成元为 B+O。没有增加 i<j 的自动枚举机制；列表内容和顺序由调用者给定。未实现 BBK、全 O/S 精确流或指数映射，也未声称相同逐对顺序的两次 S 自动产生对称法；这些范围限制均明确列在 extra_assumptions。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.dpdShardlowComposition`：定义
- `MD.Ch08.dpdTrotterComposition`：定义
- `MD.Ch08.sequentialPairComposition`：定义
- `MD.Ch08.dpdSGenerator`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.2-DPDPairOUUpdate

印刷页 393 / PDF页 414。

### 1. 原文陈述

> mred=mi mj/(mi+mj); mred du=Fdt−γωᴰu dt+σωᴿdW. a=γωᴰ/mred. u(t)=F/(a mred)+exp(−at)(u0−F/(a mred))+√[θ(1−exp(−2at))/mred]R. Δu=u(t)−u0; pi+=mred Δu e, pj−=mred Δu e. (8.103)–(8.107).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def reducedMass8 (mi mj : ℝ) : ℝ := mi*mj/(mi+mj)
theorem reducedMass8_pos (mi mj : ℝ) (hi : 0 < mi) (hj : 0 < mj) : 0 < reducedMass8 mi mj :=
  div_pos (mul_pos hi hj) (add_pos hi hj)
def dpdPairOUPrinted (mr a F θ t u R : ℝ) : ℝ :=
  F/(a*mr)+Real.exp (-a*t)*(u-F/(a*mr))+Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
def dpdPairOU_corrected (mr a F θ t u R : ℝ) : ℝ :=
  Real.exp (-a*t)*u+(F/mr)*(if a=0 then t else (1-Real.exp (-a*t))/a)+
    Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
theorem dpdPairOU_zeroRate (mr F θ t u R : ℝ) :
    dpdPairOU_corrected mr 0 F θ t u R=u+(F/mr)*t := by simp [dpdPairOU_corrected]
def dpdPairMomentumStep {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : ParticleConfig N d := p+pairImpulseVector i j ((mr*du) • e)
theorem dpdPairMomentumStep_conserves {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : totalMomentum (dpdPairMomentumStep i j e mr du p)=totalMomentum p := by
  simp [dpdPairMomentumStep,pairImpulseVector,totalMomentum,Finset.sum_add_distrib,Finset.sum_sub_distrib]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 原印转移律要求mr>0、a>0、θ>0、t≥0及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。
- 单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。
- [EXTRA] 零率分支仅用于涨落耗散使噪声同时退化的情形；不用于任意独立非零扩散的零漂移OU。物理转移需正约化质量、正温度、a,t≥0及独立标准正态R。
- 覆盖缺口：单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。

### 6. 审计结论（含网站结论）

网站首轮：NEEDS_HUMAN。分别审校 reducedMass8、其正性定理、dpdPairOUPrinted、dpdPairOU_corrected、零率定理、dpdPairMomentumStep 及其守恒定理。约化质量 mi*mj/(mi+mj) 及正质量前提正确；Printed 完全忠实(8.104)。a≠0 时修正版将确定性项改写为 exp(−at)u+(F/mr)(1−exp(−at))/a，与原式相同；a=0 分支为 u+(F/mr)t，噪声根号退化为零，符合涨落耗散关联下的连续零率延拓。动量更新为 ±mr*du*e，总动量等式对任意 i,j,e,mr,du,p 都成立；不需要单位方向或质量正性。要解释为相对速度精确流还需不同粒子、单位方向及正质量；物理 OU 转移还需 mr,θ>0、a,t≥0 和独立标准正态 R。原印公式在零率没有通常实数意义，而本条已正确另设修正版；原书边界域约定应人工确认，Printed 忠实性和 corrected 数学正确性均 PASS。
原文版：Printed忠实性PASS；零率原式通常未定义。
修正版：原送审正率改写与FDT噪声同时退化的零率_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项见下。
原书疑点：已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。

### 7. 状态与证明位置

- `MD.Ch08.reducedMass8`：定义
- `MD.Ch08.reducedMass8_pos`：已证
- `MD.Ch08.dpdPairOUPrinted`：定义
- `MD.Ch08.dpdPairOU_corrected`：定义
- `MD.Ch08.dpdPairOU_zeroRate`：已证
- `MD.Ch08.dpdPairMomentumStep`：定义
- `MD.Ch08.dpdPairMomentumStep_conserves`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.3-PairwiseNoseHoover

印刷页 394 / PDF页 415。

### 1. 原文陈述

> dqᵢ=pᵢdt/mᵢ, dpᵢ=Fᶜᵢdt+ξ F̃ᴰᵢdt, dξ=Gdt; G=Q⁻¹Σᵢ<ⱼωᴰ(rᵢⱼ)[(vᵢⱼ·eᵢⱼ)²−θ/mred]. (8.108),(8.109).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev PNHLState (N d : ℕ) := ParticlePhase N d × ℝ
def pairwiseFeedback {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ℝ :=
  (∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), wD (pairDistance q i j)*
    ((dot (relativeVelocity m p i j) (pairDirection q i j))^2-θ/reducedMass8 (m i) (m j)))/Q
def pnhDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ (m i)⁻¹ • z.1.2 i),
    dpdConservative α rc z.1.1+z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),
   pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def isPNHSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (X : ℝ → PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧
  ∀ t, 0 ≤ t → HasDerivWithinAt X (pnhDrift m α rc θ Q wD (X t)) (Ici 0) t
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | PNH场、反馈和正质量/正热浴质量的ODE规格。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- Q为原文μ，F̃ᴰ是γ=1的相对速度耗散；排除i=j，物理轨道另需非碰撞且ωᴰ≥0。
- 只落盘实际ODE规格；Galilean不变性、总动量沿轨道守恒、存在唯一性及遍历性列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 PNHLState、pairwiseFeedback、pnhDrift、isPNHSolution。扩展态 ((q,p),ξ)；位置速度 p_i/m_i；动量场 Fᶜ+ξF̃ᴰ，其中 F̃ᴰ 使用 γ=1；反馈按 i<j 单次求和并除 Q，热修正为 θ/mred，Q 对应原文 μ、θ 对应 kBT，符合(8.108)–(8.109)。isPNHSolution 明列 N,d>0、每个质量正、rc,θ,Q>0，并对每个 t≥0 使用 Ici 0 上的导数。未把 wD 非负及全轨道非碰撞写进该 Prop，这两项只在 extra_assumptions 说明物理解释；因此该总化 ODE 规格本身也包含非物理解，不能从它直接宣称所有解非碰撞。此限定与已给 statement_scope 一致；不变性、守恒沿轨道及存在唯一性均未冒充已证。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.PNHLState`：定义
- `MD.Ch08.pairwiseFeedback`：定义
- `MD.Ch08.pnhDrift`：定义
- `MD.Ch08.isPNHSolution`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.3-PairwiseCanonicalWeight

印刷页 394 / PDF页 415。

### 1. 原文陈述

> ρ̂β=Ẑ⁻¹exp(−βH(q,p))exp(−βQξ²/2), on accessible fixed-momentum space. (8.110).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairwiseWeight {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  Real.exp (-β*particleHamiltonian m U z.1)*Real.exp (-β*Q*z.2^2/2)
def pairwiseCanonicalDensity {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  pairwiseWeight m U β Q z/(∫ x, pairwiseWeight m U β Q x ∂ν)
def pairwiseCanonicalQualification {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ 0 < Q ∧ ν {z | totalMomentum z.1.2 ≠ π}=0 ∧
  Integrable (pairwiseWeight m U β Q) ν ∧ (0 < ∫ z, pairwiseWeight m U β Q z ∂ν) ∧
  probabilityDensity ν (pairwiseCanonicalDensity ν m U β Q)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 动量约束下扩展Gibbs权、配分积分和概率密度资格。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- ν是需指定的动量叶参考测度；正有限配分积分和概率资格显式列出。
- 这里只定义权重及归一目标，不把任意支持在动量叶上的测度称为PNH不变测度。完整不变性和归一存在理论列缺口。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 pairwiseWeight、pairwiseCanonicalDensity、pairwiseCanonicalQualification。Hamiltonian 为 Σ|p_i|²/(2m_i)+U(q)，扩展权是 exp(−βH)exp(−βQξ²/2)，无遗漏 1/2 或负号；归一分母为对给定 ν 的真实积分。qualification 明列质量、β,Q 正，ν 几乎处处支持在总动量 π 的叶上、权重可积、配分积分严格正及 probabilityDensity 的非负/可积/积分为1条件。所有 N,d、U、ν、π 都显式量化，未把任意 ν 当作标准叶体积，亦未声称 ν 下所得密度自动为动力学不变测度。概率资格是定义的合取条件而不是已经证明的存在性结论；与本条限定范围一致。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pairwiseWeight`：定义
- `MD.Ch08.pairwiseCanonicalDensity`：定义
- `MD.Ch08.pairwiseCanonicalQualification`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.4-PairwiseNHLSDE

印刷页 395 / PDF页 416。

### 1. 原文陈述

> PNHL adds dξ=(G−γ̂ξ)dt+σ̂dW, σ̂²=2γ̂θ/Q, to PNH. W is standard Wiener. (8.111),(8.112).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pnhlDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  ((pnhDrift m α rc θ Q wD z).1,pairwiseFeedback m θ Q wD z.1.1 z.1.2-γ*z.2)
def pnhlNoise {N d : ℕ} (σ : ℝ) (_ : Fin 1) : PNHLState N d := ((0,0),σ)
def isPNHLSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → PNHLState N d)
    (x0 : PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧ 0 ≤ γ ∧
  σ^2=2*γ*θ/Q ∧ (∀ r, 0 ≤ wD r) ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1.1 i j) ∧
  additiveSDE P 1 W X x0 (pnhlDrift m α rc θ Q γ wD) (pnhlNoise σ)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 带正质量资格、涨落耗散关系及真实独立标准Wiener的PNHL积分解规格。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 实际一维标准Wiener由通用积分解规格明示；扩散仅作用ξ。
- 未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。
- 覆盖缺口：未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 pnhlDrift、pnhlNoise、isPNHLSolution 及 independentWiener、additiveSDE。只在 ξ 分量增加 −γξ 漂移及 σ 噪声，粒子 q,p 无直接随机项；σ²=2γθ/Q 与(8.112)一致。Prop 明列 N,d、质量、rc,θ,Q 正，γ≥0，wD 全域非负，且每个 t≥0 几乎处处不同粒子距离正。additiveSDE 要求概率测度、各分量标准 Brownian、分量过程独立、几乎处处连续路径、相对噪声历史的可测性、每个非负时刻的漂移可积及完整积分等式（包含 x0 与 W_t−W_0）；Fin 1 表明只有一个实 Wiener。非碰撞使用 ∀t ∀ᵐ 的逐时刻资格，而非定义中直接写出的共同满测集全时刻非碰撞；未将前者夸大为后者。声明是解规格，没有隐含解存在、唯一或遍历结论。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pnhlDrift`：定义
- `MD.Ch08.pnhlNoise`：定义
- `MD.Ch08.isPNHLSolution`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.4-PairwiseNHLGenerator

印刷页 395 / PDF页 416。

### 1. 原文陈述

> PNHL splits A,B,C,D,O, with C:ξF̃ᴰ, D:G∂ξ, O:−γ̂ξ∂ξ+σ̂²∂ξ²/2. LPNHL=LA+LB+LC+LD+LO. (8.113),(8.114).

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pnhlA {N d : ℕ} (m : Fin N → ℝ) (z : PNHLState N d) : PNHLState N d := (dpdA m z.1,0)
def pnhlB {N d : ℕ} (α rc : ℝ) (z : PNHLState N d) : PNHLState N d := (dpdB α rc z.1,0)
def pnhlC {N d : ℕ} (m : Fin N → ℝ) (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((0,z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),0)
def pnhlD {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d := ((0,0),pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlO {N d : ℕ} (γ : ℝ) (z : PNHLState N d) : PNHLState N d := ((0,0),-γ*z.2)
def pnhlGenerator {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (f : PNHLState N d → ℝ) (z : PNHLState N d) : ℝ :=
  firstOrder8 (pnhlA m) f z+firstOrder8 (pnhlB α rc) f z+firstOrder8 (pnhlC m wD) f z+
    firstOrder8 (pnhlD m θ Q wD) f z+additiveGenerator (pnhlO γ) (pnhlNoise σ 0) f z
theorem pnhlDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : pnhlDrift m α rc θ Q γ wD z=
      pnhlA m z+pnhlB α rc z+pnhlC m wD z+pnhlD m θ Q wD z+pnhlO γ z := by
  ext <;> simp [pnhlDrift,pnhDrift,pnhlA,pnhlB,pnhlC,pnhlD,pnhlO,dpdA,dpdB,sub_eq_add_neg]
theorem pairwiseWeight_localStationary {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ)
    (hm : ∀ i, 0 < m i) (hrc : 0 < rc) (hθ : 0 < θ) (hQ : 0 < Q)
    (hγ : 0 ≤ γ) (hσ : σ^2=2*γ*θ/Q) (z : PNHLState N d)
    (hq : ∀ i j, i ≠ j → 0 < pairDistance z.1.1 i j)
    (hcut : ∀ i j, i ≠ j → pairDistance z.1.1 i j ≠ rc) :
    -textbookDivergence (fun x ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q x •
      pnhlDrift m α rc θ Q γ (fun r ↦ (dpdWeightR rc r)^2) x) z+
      σ^2/2*deriv (deriv (fun s ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q (z.1,s))) z.2=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 五子场、形式生成元、漂移分解；扩展权的局部驻定目标。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 驻定式只为非碰撞、离开截断界面的局部光滑目标；全局保测需边界、半群等理论。
- 没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 pnhlA/B/C/D/O、pnhlGenerator、pnhlDrift_split、pairwiseWeight_localStationary。五子场逐坐标对应(8.113)，O 仅作用 ξ；additiveGenerator 的一阶项加噪声方向二阶项/2 给出 σ²∂ξ²/2，漂移分解对任意实参数和状态成立。局部驻定定理完整保留正质量、rc,θ,Q>0、γ≥0、σ²=2γθ/Q、不同粒子不碰撞且距离不等于 rc 的前提；使用特定 wD=(dpdWeightR rc)²、U=dpdPotential、β=θ⁻¹。textbookDivergence 为 fderiv 的线性迹，结论正是 −div(ρb)+(σ²/2)∂ξ²ρ=0。该式局部成立：Hamiltonian 项抵消；每个对的耗散对密度的贡献由 ξ 反馈项抵消；剩下 ξ 的 OU 项由 FDT 抵消。没有将局部式升级成全局归一、不变概率或遍历性；sorry 不影响本次签名审校。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pnhlA`：定义
- `MD.Ch08.pnhlB`：定义
- `MD.Ch08.pnhlC`：定义
- `MD.Ch08.pnhlD`：定义
- `MD.Ch08.pnhlO`：定义
- `MD.Ch08.pnhlGenerator`：定义
- `MD.Ch08.pnhlDrift_split`：已证
- `MD.Ch08.pairwiseWeight_localStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.9.4-PNHLSplittingAlgorithms

印刷页 396 / PDF页 417。

### 1. 原文陈述

> PNHL-S: A½B½C½D½OD½C½B½A½; PNHL-N: A½B½C½D½OD½C½A½B½.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pnhlAStep {N d : ℕ} (m : Fin N → ℝ) (h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ z.1.1 i+(h/m i) • z.1.2 i),z.1.2),z.2)
def pnhlBStep {N d : ℕ} (α rc h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((z.1.1,z.1.2+h • dpdConservative α rc z.1.1),z.2)
def pnhlDStep {N d : ℕ} (m : Fin N → ℝ) (θ Q h : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (z.1,z.2+h*pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlOStep {N d : ℕ} (θ Q γ h R : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (z.1,Real.exp (-γ*h)*z.2+Real.sqrt (θ/Q*(1-Real.exp (-2*γ*h)))*R)
def pnhlPairCStep {N d : ℕ} (i j : Fin N) (m : Fin N → ℝ) (h : ℝ)
    (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  let mr := reducedMass8 (m i) (m j)
  let e := pairDirection z.1.1 i j
  let u := dot e (relativeVelocity m z.1.2 i j)
  let du := u*(Real.exp (-z.2*wD (pairDistance z.1.1 i j)*h/mr)-1)
  ((z.1.1,dpdPairMomentumStep i j e mr du z.1.2),z.2)
def pnhlSComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ B (h/2) ∘ A (h/2)
def pnhlNComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ A (h/2) ∘ B (h/2)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | A/B/D/O实际更新、单对C更新和S/N的原印外层组合；全C指数与误差理论列缺口。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- O需θ,Q>0、γ,h≥0及R独立标准正态；A/B/D给实际子步。C仅给逐对精确更新，全C需有序逐对近似，未冒称精确全流。
- 两组合保留原印因子顺序；不证明全方法弱阶、不变分布误差或非对称方法更优的经验结论。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 pnhlAStep/BStep/DStep/OStep/PairCStep 和 pnhlSComposition/NComposition。A 为 q+=h p/m；B 为 p+=hFᶜ；D 为 ξ+=hG；O 衰减 exp(−γh)，方差 θ/Q*(1−exp(−2γh)) 正确。单对 C 冻结 q,ξ，由 du=u(exp(−ξwD h/mred)−1) 及 ±mred du e 更新，物理解释需不同粒子、非碰撞单位 e、正质量；ξ 可以为任意实数。S 的九因子和 N 的末尾 A½B½ 均与原页从左至右列出的因子一致，Lean 实际执行为从右向左，未把印刷顺序误称时间顺序。E 为任意类型、子流为调用者提供的映射，未在组合定义中额外绑定具体子步；随机 OU 的资格、全 C 的逐对近似及误差缺口均明列，未宣称单对 C 是全 C 的精确流。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.pnhlAStep`：定义
- `MD.Ch08.pnhlBStep`：定义
- `MD.Ch08.pnhlDStep`：定义
- `MD.Ch08.pnhlOStep`：定义
- `MD.Ch08.pnhlPairCStep`：定义
- `MD.Ch08.pnhlSComposition`：定义
- `MD.Ch08.pnhlNComposition`：定义

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.10-BerendsenRelaxation

印刷页 396–397 / PDF页 417–418。

### 1. 原文陈述

> Ṫ(t)=γ_T(Ttarget−T(t)), γ_T>0. After Verlet, p←√[1+γ_Th(N_d k_BT/‖p‖²−1)]p.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def berendsenTemperature (θ T0 γ t : ℝ) : ℝ := θ+(T0-θ)*Real.exp (-γ*t)
theorem berendsenTemperature_derivative (θ T0 γ t : ℝ) :
    HasDerivAt (berendsenTemperature θ T0 γ) (γ*(θ-berendsenTemperature θ T0 γ t)) t := by
  convert (hasDerivAt_const t θ).add (((hasDerivAt_id t).const_mul (-γ)).exp.const_mul (T0-θ)) using 1
  · ext x
    dsimp [berendsenTemperature]
  · dsimp [berendsenTemperature]
    ring
def berendsenRadicand (nd θ γ h E : ℝ) : ℝ := 1+γ*h*(nd*θ/E-1)
def berendsenScale {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Vec n :=
  Real.sqrt (berendsenRadicand n θ γ h (dot p p)) • p
def berendsenScaleQualification {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Prop :=
  0 < n ∧ 0 < θ ∧ 0 < γ ∧ 0 ≤ h ∧ 0 < dot p p ∧ 0 ≤ berendsenRadicand n θ γ h (dot p p)
theorem dot_smul_same {n : ℕ} (c : ℝ) (p : Vec n) : dot (c • p) (c • p)=c^2*dot p p := by
  simp only [dot,Pi.smul_apply,smul_eq_mul,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  ring
theorem berendsenScale_energy {n : ℕ} (θ γ h : ℝ) (p : Vec n)
    (hq : berendsenScaleQualification θ γ h p) :
    dot (berendsenScale θ γ h p) (berendsenScale θ γ h p)=
      (1-γ*h)*dot p p+γ*h*n*θ := by
  rw [berendsenScale,dot_smul_same,Real.sq_sqrt hq.2.2.2.2.2]
  dsimp [berendsenRadicand]
  field_simp [ne_of_gt hq.2.2.2.2.1]
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Berendsen温度方程的显式解、动量缩放、有效域和单次能量恒等式。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 取单位粒子质量的Euclidean动量平方和；有效域显式要求非零动量及非负根号，避免将总化sqrt/division当作物理方法。
- 只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。
- 覆盖缺口：只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 berendsenTemperature、导数定理、berendsenRadicand/Scale/ScaleQualification、dot_smul_same、berendsenScale_energy。温度解为 θ+(T0−θ)exp(−γt)，导数等于 γ(θ−T(t))，对任意实参数成立；物理衰减另需 γ>0。缩放使用 n 个实动量坐标（n=Nd）、单位质量、θ=kBT，根号 1+γh(nθ/Σp²−1) 与原页相符。能量定理完整保留 n,θ,γ>0、h≥0、Σp²>0 和根号非负的 qualification，结论为 (1−γh)Σp²+γh nθ，未遗漏根号或分母的有效域。dot_smul_same 是任意实缩放的代数恒等式。没有将单次缩放恒等式当成完整 Verlet 耦合后真实温度必然满足连续 ODE，也没有声称正则采样。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.berendsenTemperature`：定义
- `MD.Ch08.berendsenTemperature_derivative`：已证
- `MD.Ch08.berendsenRadicand`：定义
- `MD.Ch08.berendsenScale`：定义
- `MD.Ch08.berendsenScaleQualification`：定义
- `MD.Ch08.dot_smul_same`：已证
- `MD.Ch08.berendsenScale_energy`：已证

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.10-CanonicalTotalMomentumGaussian

印刷页 397–398 / PDF页 418–419。

### 1. 原文陈述

> In Euclidean canonical equilibrium, total momenta are sums of independent centered normal particle momenta and hence are centered normal.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem totalMomentum_gaussian {N d : ℕ} (P : Measure Ω) [IsProbabilityMeasure P]
    (p : Ω → ParticleConfig N d) (m : Fin N → ℝ) (θ : ℝ)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (a : Fin d)
    (hind : iIndepFun (fun i sample ↦ p sample i a) P)
    (hlaw : ∀ i, HasLaw (fun sample ↦ p sample i a)
      (gaussianReal 0 (Real.toNNReal (m i*θ))) P) :
    HasLaw (fun sample ↦ totalMomentum (p sample) a)
      (gaussianReal 0 (Real.toNNReal ((∑ i, m i)*θ))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际独立Gaussian动量假设下的一坐标总动量分布；非采样收敛定理。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 结论明确以各粒子坐标的独立正则Gaussian分布为前提；不从“系统遍历”直接推出有限时刻分布。
- 原页比较直方图和轨迹属于经验试验，未转为普适数学断言。

### 6. 审计结论（含网站结论）

网站首轮：PASS。核对 totalMomentum_gaussian 的全部量化：Ω 可测、P 概率测度，N,d 自然数，粒子随机动量 p、正质量 m、θ>0、坐标 a:Fin d；hind 明确该坐标跨粒子独立，hlaw 明确各粒子该坐标服从均值0、方差 m_iθ 的 gaussianReal。结论为该坐标的总动量均值0、方差 (Σm_i)θ 的 HasLaw，gaussianReal 的第二参数是非负方差；Real.toNNReal 在所给正性条件下未改变方差。N=0 时是退化零方差正态，d=0 时不存在待选 a，均无逻辑例外。不需要跨坐标独立；结论也没有声称整个向量的联合高斯性或采样收敛。独立性是从正则平衡动量模型中明确补出的前提，不是由仅有各边缘正态推出。sorry 不构成签名 FAIL。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.totalMomentum_gaussian`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

## MD-8.10-NHLTotalMomentumSign

印刷页 398 / PDF页 419。

### 1. 原文陈述

> With central forces and an NHL thermostat, total momentum obeys Ṗ=−ξP, so each component keeps the sign of its initial value.

对应原页全文逐字保留在原文JSON；数学排版以附页为准。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlMomentumFactor (ξ : ℝ → ℝ) (t : ℝ) : ℝ := Real.exp (-(∫ s in (0 : ℝ)..t, ξ s))
theorem nhlMomentumFactor_pos (ξ : ℝ → ℝ) (t : ℝ) : 0 < nhlMomentumFactor ξ t := Real.exp_pos _
theorem nhlMomentum_sign (ξ : ℝ → ℝ) (P0 : ℝ) (t : ℝ) :
    (0 < nhlMomentumFactor ξ t*P0 ↔ 0 < P0) ∧
    (nhlMomentumFactor ξ t*P0 < 0 ↔ P0 < 0) := by
  constructor
  · exact mul_pos_iff_of_pos_left (nhlMomentumFactor_pos ξ t)
  · constructor
    · intro h
      by_contra hp
      have hp' : 0 ≤ P0 := le_of_not_gt hp
      have hn := mul_nonneg (le_of_lt (nhlMomentumFactor_pos ξ t)) hp'
      linarith
    · intro h
      exact mul_neg_of_pos_of_neg (nhlMomentumFactor_pos ξ t) h
theorem nhlTotalMomentum_odeSolution (ξ P : ℝ → ℝ) (hξ : Continuous ξ)
    (hP : ∀ t, HasDerivAt P (-ξ t*P t) t) (t : ℝ) :
    P t=nhlMomentumFactor ξ t*P 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 总动量标量ODE解目标、正指数因子及显式表达式的符号保持。 |
| 对象、量词、前提及全部结论 | 见完整声明；新增资格见[EXTRA] |

### 5. [EXTRA] 与覆盖缺口

- 只对连续ξ及实际标量ODE声明解公式，正指数乘子的符号结论已证；从NHL粒子SDE推出总动量ODE仍需成对力抵消及积分方程桥接。
- 欧氏空间正负动量不变与特殊初值下遍历性的讨论不扩展为任意系统的遍历性反例。

### 6. 审计结论（含网站结论）

网站首轮：PASS。逐一核对 nhlMomentumFactor、其正性定理、nhlMomentum_sign、nhlTotalMomentum_odeSolution。因子 exp(−∫₀ᵗξ) 对任意实函数 ξ 和实 t 的 Lean 总化积分均严格正，因此显式表达式与 P0 的正、负符号分别等价；P0=0 时表达式也为0。真正的解公式定理另外要求 ξ 连续、对所有实 t 有 HasDerivAt P (−ξ(t)P(t)) t，结论 P(t)=factor(t)P(0) 的起点、符号及量词均正确，可由积分因子法推出。未把任意 ξ 上正性定理误当成任意 ξ 上的 ODE 解定理；从 NHL 粒子系统到总动量 ODE 的桥接在 extra_assumptions 已列缺口，原页关于符号及遍历性限定的说法被保留。sorry 不影响签名审校。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。

### 7. 状态与证明位置

- `MD.Ch08.nhlMomentumFactor`：定义
- `MD.Ch08.nhlMomentumFactor_pos`：已证
- `MD.Ch08.nhlMomentum_sign`：已证
- `MD.Ch08.nhlTotalMomentum_odeSolution`：未证；缺大型理论

位置：Blueprint/Ch08.lean。每条声明公理输出均已核对；含占位依赖的声明保留未证状态。

