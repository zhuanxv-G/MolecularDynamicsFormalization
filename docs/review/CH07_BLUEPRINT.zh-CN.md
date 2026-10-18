# 第8章 Lean Blueprint 本地审阅材料

当前已整理13条；网站尚未审阅。正文范围为印刷329–399页（PDF350–420），末页仅取Exercises之前的正文；PDF423起附录不在本轮范围。

## 1. MD-8.1-CanonicalCorrelation · definition · 印刷p.329–330 / PDFp.350–351

### 2. 原文陈述

Av_β(φ)=∫φρ_β/∫ρ_β, ρ_β=exp(-βH); C_β(τ)=∫ A(z)·B(F^H_τ(z))ρ_β dω / ∫ A(z)·B(z)ρ_β dω. Thus C(0)=1.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.Vec, MD.Ch08.Phase, MD.Ch08.dot, MD.Ch08.gradient, MD.Ch08.gibbsWeight, MD.Ch08.canonicalAverage, MD.Ch08.probabilityDensity, MD.Ch08.correlation, MD.Ch08.correlation_zero | 规范平均、标量相关函数及零时归一；混合时的大时间极限定性说明另列。 |

[EXTRA] 相关分母非零才有C(0)=1；向量观测的点积由标量乘积表示，其余分量情形未展开。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.Vec, MD.Ch08.Phase, MD.Ch08.dot, MD.Ch08.gradient, MD.Ch08.gibbsWeight, MD.Ch08.canonicalAverage, MD.Ch08.probabilityDensity, MD.Ch08.correlation, MD.Ch08.correlation_zero。

## 1. MD-8.1-HamiltonianStationary · unnumbered_claim · 印刷p.330 / PDFp.351

### 2. 原文陈述

The Liouvillian satisfies Lφ(H)=0; L is skew-adjoint. Hence any density which is a function of H will be preserved, including exp(-βH).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hamiltonianField (invm : Vec n) (U : Vec n → ℝ) (z : Phase n) : Phase n :=
  (fun i ↦ invm i * z.2 i, fun i ↦ - gradient U z.1 i)
theorem hamiltonianGibbsStationary (H : SymplecticCoordinates n → ℝ)
    (β : ℝ) (hH : ContDiff ℝ 2 H) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H)
      (textbookHamiltonianGibbsWeight H β) := by
  exact textbookHamiltonianGibbsWeight_stationary hH β
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.hamiltonianField, MD.Ch08.hamiltonianGibbsStationary | 光滑Hamiltonian Gibbs权重的Liouville驻定方程；其余三项列覆盖缺口。 |

[EXTRA] 只桥接光滑Hamiltonian的Gibbs权重驻定方程；一般φ(H)、算子偏斜伴随及流的保测性未由本条覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.hamiltonianField, MD.Ch08.hamiltonianGibbsStationary。

## 1. MD-8.1-ExtendedDensity · unnumbered_claim · 印刷p.331 / PDFp.352

### 2. 原文陈述

ρ̃(q,p,ξ)=ρ_β(q,p)ρ̂(ξ). Then ∫g(q,p)ρ̃ ∝ ∫g(q,p)ρ_β.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.extendedDensity, MD.Ch08.extendedAverage | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 辅助密度归一、乘积积分可积；使用有限/σ有限测度条件。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.extendedDensity, MD.Ch08.extendedAverage。

## 1. MD-8.1.1-NoseHoover · definition · 印刷p.331 / PDFp.352

### 2. 原文陈述

q̇=M⁻¹p, ṗ=-∇U(q)-ξp, μξ̇=pᵀM⁻¹p-N_dβ⁻¹.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.thermostatParameters, MD.Ch08.kineticTwice, MD.Ch08.nhField, MD.Ch08.isNHSolution | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] μ记为Q且Q>0，β>0，正质量，热浴变量ξ∈ℝ；总函数nhField配合资格谓词使用。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.thermostatParameters, MD.Ch08.kineticTwice, MD.Ch08.nhField, MD.Ch08.isNHSolution。

## 1. MD-8.1.1-NHDensitySplit · unnumbered_claim · 印刷p.332 / PDFp.353

### 2. 原文陈述

ρ̃=ρ_β exp(-βμξ²/2); f=f₁+f₂, L_f†=L_f₁†+L_f₂†; f₂ preserves ρ̃.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhWeight, MD.Ch08.nhBathField, MD.Ch08.nhField_split, MD.Ch08.nhWeight_stationary | 权重、分裂及完整场驻定；伴随算子分裂可由散度线性导出但未另作声明。 |

[EXTRA] 指数为未归一权重；若称概率密度还要求有限正配分积分并归一化。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：完整NH散度/链式法则计算及伴随算子桥接；保留驻定陈述，不推遍历性。
位置：Blueprint/Ch08.lean；MD.Ch08.nhWeight, MD.Ch08.nhBathField, MD.Ch08.nhField_split, MD.Ch08.nhWeight_stationary。

## 1. MD-8.1.1-NHFirstIntegralPrinted · unnumbered_claim · 印刷p.333 / PDFp.354

### 2. 原文陈述

ds/dt=ξ. I_NH=H+μξ²/2+N_dβ⁻¹ ln s is conserved.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhIntegral, MD.Ch08.nhIntegralPrinted, MD.Ch08.nhIntegral_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] s>0；原文版不证明，修正版另列；两版均保留原文H形式。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Printed版疑误不证；修正版需沿NH解的能量求导，未建设通用ODE守恒量理论。
位置：Blueprint/Ch08.lean；MD.Ch08.nhIntegral, MD.Ch08.nhIntegralPrinted, MD.Ch08.nhIntegral_corrected。

## 1. MD-8.1.2-NHReversal · unnumbered_claim · 印刷p.333 / PDFp.354

### 2. 原文陈述

Nosé-Hoover is time-reversible: changing the sign of p and ξ is equivalent to reversing time.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def nhReversal (z : Phase n × ℝ) : Phase n × ℝ := ((z.1.1, -z.1.2), -z.2)
theorem nhReversal_involutive : Function.Involutive (nhReversal (n:=n)) := by
  intro z; ext <;> simp [nhReversal]
theorem nhReversal_field (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q (nhReversal z) =
    ((fun i ↦ -(nhField invm U β Q z).1.1 i, (nhField invm U β Q z).1.2), (nhField invm U β Q z).2) := by
  ext <;> simp [nhField, nhReversal, kineticTwice] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhReversal, MD.Ch08.nhReversal_involutive, MD.Ch08.nhReversal_field | 反演为对合及向量场反演等式；不另称一般ODE流的全局反演定理。 |

[EXTRA] 本条没有另加数学前提。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.nhReversal, MD.Ch08.nhReversal_involutive, MD.Ch08.nhReversal_field。

## 1. MD-8.1.2-NHTimestep · definition · 印刷p.333 / PDFp.354

### 2. 原文陈述

Nosé-Hoover Timestep Map: drift(h/2), damped force(h/2), ξ-update(h), damped force(h/2), drift(h/2). c(t,ξ)=(1-e^{-tξ})/ξ=t-t²ξ/2+⋯.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.dampedCoefficient, MD.Ch08.nhDrift, MD.Ch08.nhKick, MD.Ch08.nhFeedback, MD.Ch08.nhStep, MD.Ch08.dampedCoefficient_zero | 五段单步算法与c的可去奇点延拓；Taylor展开及二阶收敛列覆盖缺口。 |

[EXTRA] c在ξ=0处取连续延拓t；系数Taylor级数与二阶全局误差未由单步定义证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.dampedCoefficient, MD.Ch08.nhDrift, MD.Ch08.nhKick, MD.Ch08.nhFeedback, MD.Ch08.nhStep, MD.Ch08.dampedCoefficient_zero。

## 1. MD-8.1.2-NHTimestepReversible · unnumbered_claim · 印刷p.333 / PDFp.354

### 2. 原文陈述

R∘G_h∘R=G_h^{-1}, R(q,p,ξ)=(q,-p,-ξ).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nhStep_reversible (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    nhReversal ∘ nhStep invm U β Q h ∘ nhReversal = nhStep invm U β Q (-h) := by
  sorry
theorem nhStep_inverse (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    Function.LeftInverse (nhStep invm U β Q (-h)) (nhStep invm U β Q h) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhStep_reversible, MD.Ch08.nhStep_inverse | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 逆映射以负步长映射及LeftInverse表达；不假设算法可逆作为结论的前提。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：含ξ=0延拓的指数函数五段映射代数消去；三条短路线内未完成。
位置：Blueprint/Ch08.lean；MD.Ch08.nhStep_reversible, MD.Ch08.nhStep_inverse。

## 1. MD-8.1.2.1-NoseHamiltoniansPrinted · unnumbered_claim · 印刷p.334 / PDFp.355

### 2. 原文陈述

H_N= p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+(N_d+1)k_BT ln s; H_NP=s[H_N-E_N]=s[p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+N_d k_BT ln s-E_N].

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.noseHamiltonian, MD.Ch08.npHamiltonian, MD.Ch08.nosePoincarePrinted, MD.Ch08.nosePoincare_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 物理定义域s>0、β,Q及质量正；总函数在此域外不作物理解释。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：原文相等式的对数系数矛盾，不证；修正代数恒等式已证。
位置：Blueprint/Ch08.lean；MD.Ch08.noseHamiltonian, MD.Ch08.npHamiltonian, MD.Ch08.nosePoincarePrinted, MD.Ch08.nosePoincare_corrected。

## 1. MD-8.1.2.1-NPEquations · definition · 印刷p.334 / PDFp.355

### 2. 原文陈述

q̇=M⁻¹p̃/s, p̃̇=sF, ṡ=sp_s/μ, ṗ_s=p̃ᵀM⁻¹p̃/s²-N_d k_BT-ΔH_N.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def npField (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : Phase n × (ℝ × ℝ) :=
  let s := z.2.1
  let π := z.2.2
  let delta := kineticTwice invm z.1.2/(2*s^2) + π^2/(2*Q) + U z.1.1 + (n : ℝ)/β*Real.log s - EN
  ((fun i ↦ invm i*z.1.2 i/s, fun i ↦ -s*gradient U z.1.1 i),
   (s*π/Q, kineticTwice invm z.1.2/s^2-(n : ℝ)/β-delta))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.npField | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] ΔH采用(8.9)展开内的N_d版本；β,Q>0及s>0为有效域；尚未桥接实际Hamiltonian梯度。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.npField。

## 1. MD-8.1.2.1-NPtoNH · unnumbered_claim · 印刷p.335 / PDFp.356

### 2. 原文陈述

p=p̃/s, ξ=p_s/μ; ṡ=sξ, ξ̇=μ⁻¹(pᵀM⁻¹p-N_d k_BT-ΔH_N). The perturbation vanishes along the exact solution.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.npProjection, MD.Ch08.npProjection_equations | 给定零能量NP解投影为NH解；NP零能量初值传播和非零能量修正列缺口。 |

[EXTRA] 明确零能量面及s>0；零能量守恒本身未假作普遍结论。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：商法则、有限维ODE投影及零能量面守恒的通用桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.npProjection, MD.Ch08.npProjection_equations。

## 1. MD-8.1.2.1-NPShadowDensity · definition · 印刷p.335 / PDFp.356

### 2. 原文陈述

H̃_h=H_NP+h²H_[2]+O(h⁴); ρ̃=ρ_βζ(q,p,h)+O(h⁴). Canonical averages are approximated by (ν+1)⁻¹Σg_nζ_n⁻¹+O(h⁴).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.fourthOrderRemainder, MD.Ch08.correctedFiniteAverage, MD.Ch08.npShadowAnsatz, MD.Ch08.npDensityAnsatz | 三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。 |

[EXTRA] [EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.fourthOrderRemainder, MD.Ch08.correctedFiniteAverage, MD.Ch08.npShadowAnsatz, MD.Ch08.npDensityAnsatz。

