# 第8章 Lean Blueprint 本地审阅材料

当前已整理39条；网站尚未审阅。正文范围为印刷329–399页（PDF350–420），末页仅取Exercises之前的正文；PDF423起附录不在本轮范围。

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

## 1. MD-8.2-GeneralThermostat · definition · 印刷p.336 / PDFp.357

### 2. 原文陈述

ż=J∇H, J constant skew-symmetric; ż=J∇H+Φ(ξ,z), ξ̇=g(ξ,z).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def generalThermostat {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (z : Vec n × Vec k) : Vec n × Vec k := (J *ᵥ gradient H z.1 + Φ z, g z)
def skewMatrix (J : Matrix (Fin n) (Fin n) ℝ) : Prop := J.transpose = -J
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.generalThermostat, MD.Ch08.skewMatrix | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] J为常矩阵，Jᵀ=-J；z、ξ为实向量，光滑资格在结论中给出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.generalThermostat, MD.Ch08.skewMatrix。

## 1. MD-8.2.1-ContinuityProductRule · unnumbered_claim · 印刷p.336–337 / PDFp.357–358

### 2. 原文陈述

∂tρ=-div_z[ρ(J∇H+Φ)]-div_ξ(ρg)=L†ρ; the product rule gives four terms W₁+W₂+W₃+W₄.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.continuityRHS, MD.Ch08.continuity_productRule | 实际Fréchet散度的乘积展开；未声称连续性方程解的存在唯一性。 |

[EXTRA] 覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.continuityRHS, MD.Ch08.continuity_productRule。

## 1. MD-8.2.1-ThermostatCriterion · unnumbered_claim · 印刷p.337 / PDFp.358

### 2. 原文陈述

- [∇z-β∇zH]·Φ + βξᵀμ⁻¹g - ∇ξ·g=0 is the fundamental equation for deterministic thermostats.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.thermalWeight, MD.Ch08.thermostatCriterion | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 原文μ_i在指数中是热质量，统一写Q_i；矩阵μ⁻¹的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：一般高维Gaussian链式法则、常反对称矩阵的零散度和变量分裂。
位置：Blueprint/Ch08.lean；MD.Ch08.thermalWeight, MD.Ch08.thermostatCriterion。

## 1. MD-8.2.1-Examples81and82 · Examples 8.1, 8.2 · 印刷p.337–338 / PDFp.358–359

### 2. 原文陈述

Example 8.1 Φ=-ξ(0,p), g=μ⁻¹(p·∇pH-N_d k_BT). Example 8.2 Φ=ξG(z), g=μ⁻¹[∇H-k_BT∇]·G. Configurational choice G=(∇qK,0).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
theorem generalizedFeedback_stationary (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.generalizedFeedback, MD.Ch08.configurationalFeedback, MD.Ch08.generalizedFeedback_stationary | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Bulgac–Kusnezov一般散度抵消计算。
位置：Blueprint/Ch08.lean；MD.Ch08.generalizedFeedback, MD.Ch08.configurationalFeedback, MD.Ch08.generalizedFeedback_stationary。

## 1. MD-8.2.1-TemperatureIdentity · unnumbered_claim · 印刷p.338 / PDFp.359

### 2. 原文陈述

∫ divG ρ dω = -∫∇ρ·G dω = β∫∇H·G ρ dω. T=k_B⁻¹〈∇H·G〉/〈divG〉.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem temperatureIdentity (H : Vec n → ℝ) (G : Vec n → Vec n) (β : ℝ)
    (hH : ContDiff ℝ 2 H) (hG : ContDiff ℝ 1 G) (hcompact : HasCompactSupport G)
    (hβ : 0 < β) :
    (∫ z, textbookDivergence G z * gibbsWeight H β z) =
      β * ∫ z, fderiv ℝ H z (G z) * gibbsWeight H β z := by
  sorry
def phaseTemperature (kB numerator denominator : ℝ) : ℝ := numerator/(kB*denominator)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.temperatureIdentity, MD.Ch08.phaseTemperature | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求k_B>0、分母非零。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：高维散度定理与Gibbs权重积分分部。
位置：Blueprint/Ch08.lean；MD.Ch08.temperatureIdentity, MD.Ch08.phaseTemperature。

## 1. MD-8.2.1-Proposition81 · Proposition 8.1 · 印刷p.338–339 / PDFp.359–360

### 2. 原文陈述

Two thermostats preserving a(ξ)ρ_β and b(η)ρ_β can be added and preserve a(ξ)b(η)ρ_β.

### 3. 原文证明

The proof is an immediate consequence of the linearity of the divergence
operator, since the Liouville operator is constructed from this.

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.proposition81 | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.proposition81。

## 1. MD-8.2.2-NHChains · unnumbered_claim · 印刷p.339–340 / PDFp.360–361

### 2. 原文陈述

The Nosé–Hoover chain (8.16)–(8.21) preserves ρ_β exp(-βΣμ_iξ_i²/2).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhChainField, MD.Ch08.nhChain_stationary | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：任意链长的散度抵消与有限和组合；不建确定性遍历理论。
位置：Blueprint/Ch08.lean；MD.Ch08.nhChainField, MD.Ch08.nhChain_stationary。

## 1. MD-8.3-ArrheniusRate · definition · 印刷p.342 / PDFp.363

### 2. 原文陈述

k ∼ A e^{-ΔE/(k_BT)}.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.arrheniusRate, MD.Ch08.arrheniusRate_nonneg | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.arrheniusRate, MD.Ch08.arrheniusRate_nonneg。

## 1. MD-8.4-AdditiveThermostatSDE · definition · 印刷p.342–343 / PDFp.363–364

### 2. 原文陈述

dq=M⁻¹pdt; dp=-∇Udt-Φ(ξ,z)-Γpdt+√(2k_BT)M^{1/2}Γ^{1/2}dW; dξ=gdt-Γ̂ξdt+√(2k_BT)M̂^{1/2}Γ̂^{1/2}dŴ. All Wiener coordinates are independent.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.independentWiener, MD.Ch08.additiveSDE, MD.Ch08.stochasticThermostatDrift, MD.Ch08.fluctuationDissipation | 一般漂移、常噪声SDE与协方差关系；未构造矩阵平方根。 |

[EXTRA] 加性噪声用独立Wiener路径增量的精确积分方程；漂移可积、路径连续且适应自然历史。完整矩阵噪声给因子B和涨落耗散资格，物理/热浴两组坐标共同独立。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.independentWiener, MD.Ch08.additiveSDE, MD.Ch08.stochasticThermostatDrift, MD.Ch08.fluctuationDissipation。

## 1. MD-8.4-OUStationarityPrinted · unnumbered_claim · 印刷p.343–344 / PDFp.364–365

### 2. 原文陈述

The OU momentum process with drift -Γp and noise √(2k_BT) M^{1/2}Γ^{1/2} preserves exp(-βpᵀM⁻¹p/2). The displayed diffusion term is β⁻¹Tr(Γ^{1/2}M^{1/2}[βM⁻¹ppᵀM⁻¹-M⁻¹]M^{1/2}Γ^{1/2})ρ̄=-drift.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.ouFokkerPlanck, MD.Ch08.ouStationarity_corrected, MD.Ch08.diffusionPrinted, MD.Ch08.diffusionPrinted_counterexample | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Printed代数疑误不证；修正版需Gaussian梯度/Hessian矩阵计算。
位置：Blueprint/Ch08.lean；MD.Ch08.ouFokkerPlanck, MD.Ch08.ouStationarity_corrected, MD.Ch08.diffusionPrinted, MD.Ch08.diffusionPrinted_counterexample。

## 1. MD-8.4-LiftedThermostat · definition · 印刷p.344–345 / PDFp.365–366

### 2. 原文陈述

dz=F(z)dt+ξG(z)dt, dξ=g(z)dt-γξdt+σdW. The lifted fields are b₀=(F+ξG,g-γξ), b₁=(0,σ).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def liftedThermostat (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec n × ℝ)
    (x0 : Vec n × ℝ) : Prop :=
  additiveSDE P 1 W X x0 (textbookThermostatDrift F G g γ)
    (fun _ ↦ (0, σ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.liftedThermostat | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 真实Wiener、适应性和可积性由additiveSDE给出；σ≠0在Hörmander结论中单列。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.liftedThermostat。

## 1. MD-8.4-Proposition82 · Proposition 8.2 · 印刷p.344–345 / PDFp.365–366

### 2. 原文陈述

If the Lie algebra generated by F and G in (8.25) spans R^m, then the Hörmander condition holds for (8.25)–(8.26).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.proposition82Printed, MD.Ch08.proposition82_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Printed缺非零噪声不证；修正版完整桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.proposition82Printed, MD.Ch08.proposition82_corrected。

## 1. MD-8.4.1-NHL · definition · 印刷p.345–346 / PDFp.366–367

### 2. 原文陈述

dq=M⁻¹pdt, dp=-∇Udt-ξpdt, dξ=μ⁻¹[pᵀM⁻¹p-N_dk_BT]dt-γξdt+√(2k_BTγμ⁻¹)dW. Quadratic specialization: U=qᵀAq/2, M=I.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhlDrift, MD.Ch08.isNHLSolution, MD.Ch08.harmonicPotential | NHL全SDE与二次势；一般质量重缩放和NHL概率不变性在其他条目/缺口中列。 |

[EXTRA] Q>0、β>0、γ>0及单独立Wiener；二次系统A对称正定、M=I；高维无约束自由度n。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.nhlDrift, MD.Ch08.isNHLSolution, MD.Ch08.harmonicPotential。

## 1. MD-8.4.1-Lemma81 · Lemma 8.1 · 印刷p.347 / PDFp.368

### 2. 原文陈述

C_k=(A^{k-1}p,A^kq), D_k=(A^kq,-A^kp) belong to the Lie algebra generated by F=(p,-Aq), G=(0,p), k=1,2,...

### 3. 原文证明

The proof of this is straightforward by induction on k. (See exercises.)

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lemma81 (A : Matrix (Fin n) (Fin n) ℝ) (k : ℕ) :
    textbookThermostatC A k ∈ textbookThermostatLieSpan A ∧
    textbookThermostatD A k ∈ textbookThermostatLieSpan A := by
  exact textbookThermostat_C_D_mem_lieSpan A k
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.lemma81 | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] Lean索引k=0对应原文k=1；完整实际线性场、导数括号与End括号约定均摘录；生成子代数在相反括号下相同。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.lemma81。

## 1. MD-8.4.1-Proposition83 · Proposition 8.3 · 印刷p.347–348 / PDFp.368–369

### 2. 原文陈述

If A is symmetric positive definite with distinct eigenvalues, the 2N_c vectors C₁,D₁,...,C_Nc,D_Nc are linearly independent on D=R^{2Nc}\⋃V_k.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition83 (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase n)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    LinearIndependent ℝ (textbookThermostatFamily A z) := by
  exact textbookThermostatFamily_linearIndependent A hA hdist z hz
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.proposition83 | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.proposition83。

## 1. MD-8.4.1-Theorem81 · Theorem 8.1 · 印刷p.346–348 / PDFp.367–369

### 2. 原文陈述

If A is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on D×R.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.theorem81Printed, MD.Ch08.theorem81_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：原文未明确σ≠0的强版本不证；修正版完整桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.theorem81Printed, MD.Ch08.theorem81_corrected。

## 1. MD-8.4.1-ZeroModeInvariant · unnumbered_claim · 印刷p.346 / PDFp.367

### 2. 原文陈述

V_k={ (q,p) | u_k·q=0, u_k·p=0 } is an invariant submanifold. D=R^{2Nc}\⋃V_k.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.modeDomain_complement, MD.Ch08.zeroMode_invariant | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 任意紧时间区间上的实际模态ODE；连续随机热浴路径可逐路径应用，不额外声称SDE解存在。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.modeDomain_complement, MD.Ch08.zeroMode_invariant。

## 1. MD-8.4.1-NHLGenerator · definition · 印刷p.348 / PDFp.369

### 2. 原文陈述

L_NHL f=M⁻¹p·∇qf-∇U·∇pf-ξp·∇pf+[μ⁻¹(pᵀM⁻¹p-N_dk_BT)-γξ]∂ξf+k_BTγμ⁻¹∂ξ²f.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.additiveGenerator, MD.Ch08.nhlGenerator, MD.Ch08.nhlLyapunov, MD.Ch08.geometricDriftBound | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 采用实际一阶、二阶Fréchet导数；原文省略f的-ξp·∇p理解为作用于f；Q,β,γ须正。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.additiveGenerator, MD.Ch08.nhlGenerator, MD.Ch08.nhlLyapunov, MD.Ch08.geometricDriftBound。

## 1. MD-8.4.1-LyapunovCalculation · unnumbered_claim · 印刷p.348–349 / PDFp.369–370

### 2. 原文陈述

For M=I, φ=‖p‖²/2+U+μ(ξ-a)²/2, Lφ=-a‖p‖²-γμξ(ξ-a)-N_dk_BT(ξ-a)+k_BTγ.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhlLyapunovExpression, MD.Ch08.nhlLyapunov_calculation, MD.Ch08.shiftedSquare_bound | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] U下界>1且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需C²。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：实际扩散生成元作用于二次能量的链式法则。
位置：Blueprint/Ch08.lean；MD.Ch08.nhlLyapunovExpression, MD.Ch08.nhlLyapunov_calculation, MD.Ch08.shiftedSquare_bound。

## 1. MD-8.4.1-LyapunovRatePrinted · unnumbered_claim · 印刷p.349 / PDFp.370

### 2. 原文陈述

Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.lyapunovAlphaPrinted, MD.Ch08.lyapunovAlpha_corrected, MD.Ch08.lyapunovRatePrinted, MD.Ch08.lyapunovRate_counterexample, MD.Ch08.lyapunovRate_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Printed有反例不证；修正版代数二次型估计待短证。
位置：Blueprint/Ch08.lean；MD.Ch08.lyapunovAlphaPrinted, MD.Ch08.lyapunovAlpha_corrected, MD.Ch08.lyapunovRatePrinted, MD.Ch08.lyapunovRate_counterexample, MD.Ch08.lyapunovRate_corrected。

## 1. MD-8.4.2-NHLTimestep · definition · 印刷p.350 / PDFp.371

### 2. 原文陈述

The symmetric NHL splitting uses kick, drift, feedback, damping, exact OU, damping, feedback, drift, kick. ζ=√(k_BTμ⁻¹(1-e^{-2γh})).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nhlOU, MD.Ch08.forceKick, MD.Ch08.bathDamping, MD.Ch08.nhlStep, MD.Ch08.standardNormalSequence | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] R_n独立标准正态；h≥0、β,Q>0、γ≥0用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.nhlOU, MD.Ch08.forceKick, MD.Ch08.bathDamping, MD.Ch08.nhlStep, MD.Ch08.standardNormalSequence。

## 1. MD-8.4.1-NHLWeakStationary · unnumbered_claim · 印刷p.345–346 / PDFp.366–367

### 2. 原文陈述

The NHL method preserves the extended canonical distribution ρ_β exp(-βμξ²/2), by adding an OU thermostat in ξ.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.weakStationaryNHL, MD.Ch08.nhlWeakStationary | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Gibbs积分分部及OU对称性，未将局部生成元式冒充保测流或遍历定理。
位置：Blueprint/Ch08.lean；MD.Ch08.weakStationaryNHL, MD.Ch08.nhlWeakStationary。

## 1. MD-8.4.3-PreEquilibriumMeans · definition · 印刷p.354–355 / PDFp.375–376

### 2. 原文陈述

θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  ∀ t, 0 ≤ t → probabilityDensity volume (ρ t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.meanKineticTwice, MD.Ch08.meanBath, MD.Ch08.preEquilibriumDensity | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.meanKineticTwice, MD.Ch08.meanBath, MD.Ch08.preEquilibriumDensity。

## 1. MD-8.4.4-VelocityRescaling · unnumbered_claim · 印刷p.355 / PDFp.376

### 2. 原文陈述

dq=pdt, dp=-∇Udt-Ψ(K)pdt+√(2k_BTΦ(K))p dW; Ψ=(2K-(1+N_d)k_BT)Φ-2k_BTKΦ′. Φ(K)=γ_VR/(2K).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.rescalingPsi, MD.Ch08.rescalingDrift, MD.Ch08.rescalingNoise, MD.Ch08.originalRescalingPhi, MD.Ch08.rescalingAdmissible, MD.Ch08.rescalingPsi_original | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] Φ在K>0光滑正，KΦ在0附近有界且多项式增长；原始Φ在K=0奇异，未声称全空间光滑扩散或遍历性。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：导数γ/(2K)的商法则短桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.rescalingPsi, MD.Ch08.rescalingDrift, MD.Ch08.rescalingNoise, MD.Ch08.originalRescalingPhi, MD.Ch08.rescalingAdmissible, MD.Ch08.rescalingPsi_original。

## 1. MD-8.4.4-RescalingStationary · unnumbered_claim · 印刷p.355 / PDFp.376

### 2. 原文陈述

With these definitions, the method preserves the canonical probability density ρ_β. The book does not prove ergodicity.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ Function.support f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.rescalingStationary | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：退化乘性扩散的Gibbs积分分部；不建设一般Fokker–Planck与遍历理论。
位置：Blueprint/Ch08.lean；MD.Ch08.rescalingStationary。

## 1. MD-8.4.5-ThermostatEfficiency · definition · 印刷p.356–357 / PDFp.377–378

### 2. 原文陈述

efficiency = rate of convergence to equilibrium / rate of growth of perturbation of dynamics. Table 8.1 gives analytic lowest-order estimates; NHL has initially quadratic error.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.thermostatEfficiency, MD.Ch08.langevinErrorEstimate, MD.Ch08.rescalingRateEstimate, MD.Ch08.rescalingErrorEstimate, MD.Ch08.nhlRateEstimate, MD.Ch08.nhlErrorEstimate | 效率记号与表8.1的主要解析速率/误差公式；经验曲线逐项排除。 |

[EXTRA] 表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.thermostatEfficiency, MD.Ch08.langevinErrorEstimate, MD.Ch08.rescalingRateEstimate, MD.Ch08.rescalingErrorEstimate, MD.Ch08.nhlRateEstimate, MD.Ch08.nhlErrorEstimate。

