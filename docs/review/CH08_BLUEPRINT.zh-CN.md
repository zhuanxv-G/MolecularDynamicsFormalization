# 第8章 Lean Blueprint 本地审阅材料

当前已整理82条；网站尚未审阅。正文范围为印刷329–399页（PDF350–420），末页仅取Exercises之前的正文；PDF423起附录不在本轮范围。

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

## 1. MD-8.5-SLS · definition · 印刷p.357–358 / PDFp.378–379

### 2. 原文陈述

dq=ξM⁻¹pdt, dp=-γpdt+σM^{1/2}dW, dξ=-[(M⁻¹p)·∇U/μ+γ′ξ]dt+σ′dZ; σ=√(2k_BTγ), σ′=√(2k_BTγ′/μ).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.slsDrift, MD.Ch08.slsNoise, MD.Ch08.isSLSSolution, MD.Ch08.slsDeterministic | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 全部n+1个Wiener坐标独立，Q、质量、温度及两摩擦参数正；总漂移和常噪声用实际积分方程解释。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.slsDrift, MD.Ch08.slsNoise, MD.Ch08.isSLSSolution, MD.Ch08.slsDeterministic。

## 1. MD-8.5-SLSBracketPrinted · unnumbered_claim · 印刷p.358 / PDFp.379

### 2. 原文陈述

D=(ξp,-p,-p·∇U-ξ), D′=[D,Y_{Nc+1}]=(p,0,1), [D′,Y_i]=e_i.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def slsBathNoise : Phase n × ℝ → Phase n × ℝ := fun _ ↦ ((0,0),1)
theorem slsBracketPrinted (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((z.1.2,0),1) := by
  sorry
theorem slsBracket_corrected (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((-z.1.2,0),1) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.slsBathNoise, MD.Ch08.slsBracketPrinted, MD.Ch08.slsBracket_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 只纠正第一括号；二次括号的整体符号不影响生成空间张成。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Printed括号符号疑误不证；修正版需实际方向导数计算。
位置：Blueprint/Ch08.lean；MD.Ch08.slsBathNoise, MD.Ch08.slsBracketPrinted, MD.Ch08.slsBracket_corrected。

## 1. MD-8.5-SLSHormander · unnumbered_claim · 印刷p.357–358 / PDFp.378–379

### 2. 原文陈述

All basis vectors are in the Lie algebra generated by the drift and the N_c+1 noise directions, so Hörmander holds.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem slsHormander (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    textbookHormanderAt
      (insert (slsDrift (fun _ ↦ 1) U 1 1 1)
        (Set.range (fun j : Fin (n+1) ↦ fun _ : Phase n × ℝ ↦ slsNoise (fun _ ↦ 1) 2 1 1 1 j))) z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.slsHormander | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：实际向量场二重括号与点态张成闭包。
位置：Blueprint/Ch08.lean；MD.Ch08.slsHormander。

## 1. MD-8.5-SLSConservation · unnumbered_claim · 印刷p.358 / PDFp.379

### 2. 原文陈述

The deterministic part preserves volume and U(q)+μξ²/2, and the full dynamics preserves the extended canonical measure.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.slsDeterministic_stationary, MD.Ch08.slsDeterministic_divergence | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 完整权重含p高斯项，确定性p固定；只保留驻定及零散度，完整SDE概率不变和离散迭代收敛列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：一般U的方向能量守恒与实际散度计算。
位置：Blueprint/Ch08.lean；MD.Ch08.slsDeterministic_stationary, MD.Ch08.slsDeterministic_divergence。

## 1. MD-8.5-SLSLeapfrog · definition · 印刷p.358–359 / PDFp.379–380

### 2. 原文陈述

q=q₀+ηM⁻¹p; η̇=ξ, ξ̇=-∂ηU(q₀+ηM⁻¹p). Leapfrog: ξ_{1/2}=ξ-h(M⁻¹p)·∇U(q)/(2μ), q′=q+hξ_{1/2}M⁻¹p, ξ′=ξ_{1/2}-h(M⁻¹p)·∇U(q′)/(2μ).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.slsBathKick, MD.Ch08.slsDriftStep, MD.Ch08.slsLeapfrog, MD.Ch08.slsCoordinateField | 线方向与两种确定性分裂公式；原文η方程、体积/面积保持和二阶长时误差有明确覆盖缺口。 |

[EXTRA] 原文η约化方程漏μ⁻¹，算法保留Q⁻¹；本条覆盖原页算法及逐坐标场，不声称二阶不变分布误差或精确求积实现。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.slsBathKick, MD.Ch08.slsDriftStep, MD.Ch08.slsLeapfrog, MD.Ch08.slsCoordinateField。

## 1. MD-8.6-IsokineticField · unnumbered_claim · 印刷p.361–362 / PDFp.382–383

### 2. 原文陈述

q̇=M⁻¹p, ṗ=F(q)-[pᵀM⁻¹F(q)/(pᵀM⁻¹p)]p; K(p)=pᵀM⁻¹p is constant.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.isoMultiplier, MD.Ch08.isoField, MD.Ch08.isoKinetic_balance | 无约束向量场与瞬时动能导数的代数消去；沿解的完整第一积分列缺口。 |

[EXTRA] 正质量、K>0作为物理有效域；本条实际证明瞬时动能平衡，不将之扩大为全局解存在性。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.isoMultiplier, MD.Ch08.isoField, MD.Ch08.isoKinetic_balance。

## 1. MD-8.6-IsokineticProjector · unnumbered_claim · 印刷p.362 / PDFp.383

### 2. 原文陈述

H=p(pᵀM⁻¹p)⁻¹pᵀM⁻¹; H²=H, Hp=p.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.isoProjection, MD.Ch08.isoProjection_self, MD.Ch08.isoProjection_idempotent | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 分母K非零；范围为span(p)的完整线性映射子空间等式列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：有限和提取标量后的投影复合代数短证明。
位置：Blueprint/Ch08.lean；MD.Ch08.isoProjection, MD.Ch08.isoProjection_self, MD.Ch08.isoProjection_idempotent。

## 1. MD-8.6-IsokineticDivergencePrinted · unnumbered_claim · 印刷p.362–363 / PDFp.383–384

### 2. 原文陈述

ρ=e^{-w(q,p)}Φ(K(p)); div f_iso=(N_c-1)pᵀM⁻¹F/(pᵀM⁻¹p), w=(N_c-1)U/K.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.isoAnsatz, MD.Ch08.isoDivergencePrinted, MD.Ch08.isoDivergence_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] Φ为正光滑非零函数时称权重；使用K≠0域上的实际散度。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Printed散度符号疑误不证；修正版需商法则与有限维散度。
位置：Blueprint/Ch08.lean；MD.Ch08.isoAnsatz, MD.Ch08.isoDivergencePrinted, MD.Ch08.isoDivergence_corrected。

## 1. MD-8.6-IsokineticGibbsShell · unnumbered_claim · 印刷p.363 / PDFp.384

### 2. 原文陈述

ρ=Z⁻¹exp(-(N_c-1)U/K)δ[K-K₀]; K₀=β⁻¹(N_c-1) gives the configurational Gibbs distribution.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.isokineticShell, MD.Ch08.isoShellWeight, MD.Ch08.isoShell_gibbsFactor | 动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。 |

[EXTRA] δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.isokineticShell, MD.Ch08.isoShellWeight, MD.Ch08.isoShell_gibbsFactor。

## 1. MD-8.6.1-StochasticIsokinetic · definition · 印刷p.364–365 / PDFp.385–386

### 2. 原文陈述

dq=pdt, dp=(F-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=μ₂⁻¹(μ₁ξ₁²-k_BT)dt-γξ₂dt+σdW; p²+μ₁ξ₁²/2=k_BT.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinConstraint, MD.Ch08.sinMultiplier, MD.Ch08.sinDrift, MD.Ch08.isSINSolution, MD.Ch08.sinConstraint_balance | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 热浴变量ξ₁,ξ₂∈ℝ，各质量、温度、摩擦正；随机噪声只在ξ₂；约束正值排除奇点。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.sinConstraint, MD.Ch08.sinMultiplier, MD.Ch08.sinDrift, MD.Ch08.isSINSolution, MD.Ch08.sinConstraint_balance。

## 1. MD-8.6.1-SINWeightPrinted · unnumbered_claim · 印刷p.365 / PDFp.386

### 2. 原文陈述

w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinWeightPrinted, MD.Ch08.sinWeight_corrected, MD.Ch08.sinWeight_stationary_corrected | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：原文权重仅逐字保留不证；修正版通量散度的商法则计算。
位置：Blueprint/Ch08.lean；MD.Ch08.sinWeightPrinted, MD.Ch08.sinWeight_corrected, MD.Ch08.sinWeight_stationary_corrected。

## 1. MD-8.6.2-SINHarmonic · definition · 印刷p.366 / PDFp.387

### 2. 原文陈述

For μ₁=μ₂=1, dq=pdt, dp=(-q-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=(ξ₁²-k_BT-γξ₂)dt+σdW, λ=(-qp-ξ₂ξ₁²/2)/(p²+ξ₁²/2), σ=√(2γk_BT). (8.45)–(8.47).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinHarmonicF, MD.Ch08.sinHarmonicG, MD.Ch08.isSINHarmonicSolution, MD.Ch08.sinExceptional, MD.Ch08.sinHalfCylinder, MD.Ch08.sinHalfCylinder_disjoint | 谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。 |

[EXTRA] θ=k_BT>0、γ>0、标量Wiener由isSINSolution给全；零ξ₁面不变和两个半柱的轨道符号保持需要ODE唯一性，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.sinHarmonicF, MD.Ch08.sinHarmonicG, MD.Ch08.isSINHarmonicSolution, MD.Ch08.sinExceptional, MD.Ch08.sinHalfCylinder, MD.Ch08.sinHalfCylinder_disjoint。

## 1. MD-8.6.2-SINProjectedBracketsPrinted · unnumbered_claim · 印刷p.367 / PDFp.388

### 2. 原文陈述

u₀=Πf, u₁=Π[f,g], u₂=Π[f,[f,g]], u₃=Π[f,[f,[f,g]]]. The displayed equations (8.48)–(8.53) give their components, with D=2p²+ξ₁².

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.bracket4, MD.Ch08.sinBracket, MD.Ch08.projectFirstThree, MD.Ch08.sinD, MD.Ch08.sinU0Printed, MD.Ch08.sinU1Printed, MD.Ch08.sinU2Printed, MD.Ch08.sinU1DerivativePrinted, MD.Ch08.sinProjected_corrected, MD.Ch08.sinU2LongPrinted, MD.Ch08.sinU2Long_at_p0 | 原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。 |

[EXTRA] 总化分式只在θ>0的约束面D=2θ>0使用；实际交换子先在四维完整计算再投影。；本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.bracket4, MD.Ch08.sinBracket, MD.Ch08.projectFirstThree, MD.Ch08.sinD, MD.Ch08.sinU0Printed, MD.Ch08.sinU1Printed, MD.Ch08.sinU2Printed, MD.Ch08.sinU1DerivativePrinted, MD.Ch08.sinProjected_corrected, MD.Ch08.sinU2LongPrinted, MD.Ch08.sinU2Long_at_p0。

## 1. MD-8.6.2-SINThirdBracketPrinted · unnumbered_claim · 印刷p.368 / PDFp.389

### 2. 原文陈述

The third projected commutator is displayed in (8.54), with polynomial η in (8.55); its p=0 specialization is printed as u₃=-2σq∂q-σq(-γ+ξ₂)∂p in (8.56).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinEtaPrinted, MD.Ch08.sinU3Printed, MD.Ch08.sinU3ZeroPrinted, MD.Ch08.sinU3Zero_corrected, MD.Ch08.sinU3Zero_specialize | 原印三重交换子候选及p=0内部代数核对；真实三重交换子等式列覆盖缺口。 |

[EXTRA] ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.sinEtaPrinted, MD.Ch08.sinU3Printed, MD.Ch08.sinU3ZeroPrinted, MD.Ch08.sinU3Zero_corrected, MD.Ch08.sinU3Zero_specialize。

## 1. MD-8.6.2-SINBracketRank · unnumbered_claim · 印刷p.366–368 / PDFp.387–389

### 2. 原文陈述

The fields f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]] span the three-dimensional tangent space of the isokinetic cylinder except on M₀.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem sinBracket_tangentSpan (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (z : Vec 4) (hz : sinConstraint 1 z=θ) (hξ : z 2 ≠ 0)
    (hout : z ∉ sinExceptional θ) :
    Submodule.span ℝ ({sinHarmonicG θ γ} ∪
      Set.range (fun j : Fin 4 ↦ sinBracket θ γ j z)) =
      LinearMap.ker (fderiv ℝ (sinConstraint 1) z).toLinearMap := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinBracket_tangentSpan | 例外直线外的有限括号张成目标；非完整遍历性定理。 |

[EXTRA] θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：真实迭代Fréchet导数及有限维秩/切核桥接；原印的错标公式不能直接充当证明。
位置：Blueprint/Ch08.lean；MD.Ch08.sinBracket_tangentSpan。

## 1. MD-8.6.2-SINLyapunov · unnumbered_claim · 印刷p.368–369 / PDFp.389–390

### 2. 原文陈述

For φ=ξ₂²/2, L_isok φ=(ξ₁²-β⁻¹)ξ₂-γξ₂²+σ²/2, and the isokinetic constraint bounds ξ₁. The negative tail drift supports the ergodicity argument with further assumptions.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinGenerator, MD.Ch08.sinGenerator_lyapunov, MD.Ch08.sinConstraint_bathBound | 真实局部生成元Lyapunov计算及热浴变量界；不包含由此推出遍历性的充分性。 |

[EXTRA] 仅生成元作用和约束界；原文有符号ξ₂的Kξ₂上界须区分尾部方向，严谨负漂移应使用K|ξ₂|并要求γ>0。；紧性、正密度、小集与Markov半群遍历定理均列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：二次测试函数的实际二阶Fréchet计算；不建设遍历理论。
位置：Blueprint/Ch08.lean；MD.Ch08.sinGenerator, MD.Ch08.sinGenerator_lyapunov, MD.Ch08.sinConstraint_bathBound。

## 1. MD-8.6.3-SINForceSplitting · unnumbered_claim · 印刷p.370–371 / PDFp.391–392

### 2. 原文陈述

U=U_S+U_F and F=F_S+F_F. The generators split into kinetic, isokinetic fast force, isokinetic slow force, Nosé and OU terms; each preserves Λ=p²+μ₁ξ₁²/2.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinKField, MD.Ch08.sinForceField, MD.Ch08.sinNField, MD.Ch08.sinOField, MD.Ch08.sinSplit_fields, MD.Ch08.sinForce_constraintBalance | 五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。 |

[EXTRA] Q₁,Q₂,θ>0且Λ=θ为物理域，总化场保留作辅助；本条含完整漂移和分解及力子场瞬时约束平衡，其他子场的流存在/保约束列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.sinKField, MD.Ch08.sinForceField, MD.Ch08.sinNField, MD.Ch08.sinOField, MD.Ch08.sinSplit_fields, MD.Ch08.sinForce_constraintBalance。

## 1. MD-8.6.3-SINRAlgorithm · definition · 印刷p.371 / PDFp.392

### 2. 原文陈述

The SIN(R) algorithm uses h̃=h/r, r−2 repeated inner blocks, outer Nosé half-steps, combined fast/slow force half-steps and independent OU substeps.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.SINStage, MD.Ch08.sinRStages | 原印算法的阶段顺序与步长；不声称构造了各非线性子流。 |

[EXTRA] 算法有效域h>0、r≥2；一组中多个场表示同一次合并传播，并非擅自换为两个非交换流。每次OU用独立标准正态新噪声。；这里只记录精确阶段表，具体随机核实现、保约束及全局误差/阶数列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.SINStage, MD.Ch08.sinRStages。

## 1. MD-8.6.3-SINNoseSubsplitting · unnumbered_claim · 印刷p.372 / PDFp.393

### 2. 原文陈述

L_N=L_N^(1)+L_N^(2). The first term acts on p,ξ₁, the second has μ₂⁻¹(μ₁ξ₁²-β⁻¹)∂ξ₂.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def sinN1Field (Q1 : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,0]
def sinN2Field (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,(Q1*z 2^2-θ)/Q2]
theorem sinN_split (Q1 Q2 θ : ℝ) (z : Vec 4) :
    sinNField Q1 Q2 θ z=sinN1Field Q1 z+sinN2Field Q1 Q2 θ z := by
  ext i; fin_cases i <;> simp [sinNField,sinN1Field,sinN2Field]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinN1Field, MD.Ch08.sinN2Field, MD.Ch08.sinN_split | Nosé场的两项分解恒等式。 |

[EXTRA] 正质量、温度及Λ>0作为物理资格；高阶Yoshida/Suzuki组合的系数和误差阶未在原页给出，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.sinN1Field, MD.Ch08.sinN2Field, MD.Ch08.sinN_split。

## 1. MD-8.6.3-SINForceExactPrinted · unnumbered_claim · 印刷p.372 / PDFp.393

### 2. 原文陈述

ṗ=F−p²F/Λ, ξ̇₁=pξ₁F/Λ. The printed solution is p(h)=(p(0)+(F/m)s(h))/ṡ(h), ξ₁(h)=ξ₁(0)/ṡ(h), with s(t)=b⁻¹/²sinh(t√b)+(a/b)(cosh(t√b)−1), a=Fp(0)/Λ, b=F²/Λ.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.sinForceAux, MD.Ch08.sinForceFlow, MD.Ch08.sinForceODEPrinted, MD.Ch08.sinForceODE_corrected, MD.Ch08.sinForceFlow_solution_corrected | 原印子场、显式候选与校正ODE的局部导数目标。 |

[EXTRA] 质量按本节假设取1；Q₁、Λ正，排除ṡ=0；F=0用b=0的解析延拓，避免总化除法假装极限。；只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：双曲函数求导、分式约束及F=0分支；最多三条短路线后保留待证。
位置：Blueprint/Ch08.lean；MD.Ch08.sinForceAux, MD.Ch08.sinForceFlow, MD.Ch08.sinForceODEPrinted, MD.Ch08.sinForceODE_corrected, MD.Ch08.sinForceFlow_solution_corrected。

## 1. MD-8.6.4-SINThreeLevelPotential · definition · 印刷p.373 / PDFp.394

### 2. 原文陈述

U_Total=U_bonds+U_s.r.+U_l.r.; h_outer and h_mid are integer multiples of the next smaller stepsizes.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def threeLevelPotential (bond short long : Vec n → ℝ) : Vec n → ℝ := bond+short+long
def nestedTimeSteps (inner middle outer : ℝ) : Prop :=
  0 < inner ∧ ∃ r s : ℕ, 0 < r ∧ 0 < s ∧ middle=r*inner ∧ outer=s*middle
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.threeLevelPotential, MD.Ch08.nestedTimeSteps | 三层势与步长嵌套的定义。 |

[EXTRA] 仅保留势的三项分解和整数时标嵌套；SPME实现、99fs稳定性及水分子径向分布等属于数值观察，逐项排除。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.threeLevelPotential, MD.Ch08.nestedTimeSteps。

## 1. MD-8.7-GeneralizedLangevin · definition · 印刷p.374 / PDFp.395

### 2. 原文陈述

dq=M⁻¹pdt, dp=−∇U(q)dt−∫₀ᵗΓ(t−s)p(s)ds dt+dB, q(0)=q₀,p(0)=p₀. Γ is the memory kernel and B is colored noise. (8.57)–(8.58).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.memoryDrag, MD.Ch08.generalizedLangevin | 连续矩阵记忆核下的卷积及GLE积分解类定义。 |

[EXTRA] B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。；本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.memoryDrag, MD.Ch08.generalizedLangevin。

## 1. MD-8.7-GLEFluctuationDissipationPrinted · definition · 印刷p.374 / PDFp.395

### 2. 原文陈述

⟨Rᵢ(t+s)Rⱼ(t)⟩=k_BT γᵢⱼ(s)δᵢⱼ, s≥0. Γ(t)=γ(t)I in the scalar-kernel specialization. (8.59).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.randomForceQualification, MD.Ch08.gleFDPrinted, MD.Ch08.gleFD_corrected, MD.Ch08.scalarMemoryMatrix | Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。 |

[EXTRA] 修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.randomForceQualification, MD.Ch08.gleFDPrinted, MD.Ch08.gleFD_corrected, MD.Ch08.scalarMemoryMatrix。

## 1. MD-8.7-PronyKernel · unnumbered_claim · 印刷p.375 / PDFp.396

### 2. 原文陈述

γ(t)=Σₖ(cₖ/τₖ)exp(−t/τₖ), t≥0. (8.60).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pronyKernel, MD.Ch08.pronyQualification, MD.Ch08.pronyKernel_nonneg | 本条列出的数学对象与结论全部；上下文见逐字原页。 |

[EXTRA] 正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.pronyKernel, MD.Ch08.pronyQualification, MD.Ch08.pronyKernel_nonneg。

## 1. MD-8.7.1-PronyMemoryODE · unnumbered_claim · 印刷p.375 / PDFp.396

### 2. 原文陈述

ηᵢₖ(t)=−∫₀ᵗ(cₖ/τₖ)exp(−(t−s)/τₖ)pᵢ(s)ds, dηᵢₖ=−ηᵢₖdt/τₖ−cₖpᵢdt/τₖ. Equations (8.61)–(8.64) remove the convolution history.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pronyMemory, MD.Ch08.pronyMemory_derivative, MD.Ch08.pronyMomentumDrift, MD.Ch08.pronyMemory_sum | 卷积辅助定义、微分关系和有限和等式；与扩展随机解的完整等价列缺口。 |

[EXTRA] p连续、τ正保证有限区间卷积合法；仅消去有限Prony历史，未声称无限Prony极限或解分布等价。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：带参指数卷积微分与有限和换积分；不建立一般Volterra随机解理论。
位置：Blueprint/Ch08.lean；MD.Ch08.pronyMemory, MD.Ch08.pronyMemory_derivative, MD.Ch08.pronyMomentumDrift, MD.Ch08.pronyMemory_sum。

## 1. MD-8.7.1-PronyOUStationarity · unnumbered_claim · 印刷p.376 / PDFp.397

### 2. 原文陈述

dRᵢₖ=−Rᵢₖdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ; E Rᵢₖ=0 and E[Rᵢₖ(t+s)Rᵢₖ(t)]=(k_BT cₖ/τₖ)e^(−s/τₖ). Rᵢ=ΣₖRᵢₖ. (8.65)–(8.67).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.stationaryPronyOU, MD.Ch08.pronyOU_covariance, MD.Ch08.totalPronyRandomForce | 单个Prony OU的完整资格及平稳均值/协方差目标、总随机力定义。 |

[EXTRA] 为(8.66)补平稳Gaussian初态及其与未来整条W独立；确定初态OU一般没有所印不依赖t的协方差。多分量实际实现使用独立W坐标。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：平稳OU随机初态协方差与当前积分解规格的桥接；不新建Gaussian过程理论。
位置：Blueprint/Ch08.lean；MD.Ch08.stationaryPronyOU, MD.Ch08.pronyOU_covariance, MD.Ch08.totalPronyRandomForce。

## 1. MD-8.7.1-CombinedPronyVariable · definition · 印刷p.376 / PDFp.397

### 2. 原文陈述

σᵢₖ=ηᵢₖ+Rᵢₖ yields dσᵢₖ=−σᵢₖdt/τₖ−cₖpᵢdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ. (8.68)–(8.70).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.GLEState, MD.Ch08.gleDrift, MD.Ch08.gleNoise, MD.Ch08.isExtendedGLESolution, MD.Ch08.combinedProny_drift | 有限维扩展SDE完整积分规格及σ=η+R的漂移恒等式。 |

[EXTRA] 额外变量取实数；正质量、c、τ、温度和独立标准向量Wiener写入解规格。e仅把有限噪声坐标编号为(k,i)。；本条实际是加性扩展SDE和漂移合并恒等式；Markov半群构造、解存在唯一及与非Markov GLE分布等价列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.GLEState, MD.Ch08.gleDrift, MD.Ch08.gleNoise, MD.Ch08.isExtendedGLESolution, MD.Ch08.combinedProny_drift。

## 1. MD-8.7.1-PronyLangevinLimit · unnumbered_claim · 印刷p.376–377 / PDFp.397–398

### 2. 原文陈述

Formally τₖ→0 gives σᵢₖdt=−cₖpᵢdt+√(2k_BT cₖ)dWᵢₖ and Langevin friction γ̂=Σₖcₖ. Independent Gaussian variances add.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pronyEffectiveFriction, MD.Ch08.pronyLimit_drift, MD.Ch08.independentGaussian_varianceSum | 有效摩擦定义、合并漂移和有限Gaussian求和分布，不是小记忆时间极限定理。 |

[EXTRA] 仅形式极限系数与真实有限个独立Gaussian线性组合；τ→0过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：有限乘积Gaussian线性映射的现成定理桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.pronyEffectiveFriction, MD.Ch08.pronyLimit_drift, MD.Ch08.independentGaussian_varianceSum。

## 1. MD-8.7.1-GeneralizedLangevinIntegrator · definition · 印刷p.377 / PDFp.398

### 2. 原文陈述

The four-step method updates p_half, q_new, σ_new,k=θₖσₖ−(1−θₖ)cₖp_half+αₖ√(2k_BT cₖ)Zₖ, then p_new with the new force and new σ.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.gleIntegrator, MD.Ch08.gleNormalSequence | 四个实际更新及其全部噪声资格。 |

[EXTRA] h>0，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。；此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.gleIntegrator, MD.Ch08.gleNormalSequence。

## 1. MD-8.7.1-GLEConsistentCoefficients · unnumbered_claim · 印刷p.377 / PDFp.398

### 2. 原文陈述

For consistency θₖ=1−h/τₖ+O(h²), αₖ=√h/τₖ+O(h). Choose θₖ=exp(−h/τₖ), αₖ=√((1−θₖ)²/h).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.gleDecay, MD.Ch08.gleNoiseCoefficient, MD.Ch08.gleCoefficientConsistency, MD.Ch08.gleCoefficients_consistent, MD.Ch08.gleCoefficient_smallMemory | 两项一致性渐近和所选单步系数的τ→0极限。 |

[EXTRA] h从正侧趋0、τ固定正；小记忆极限另固定h>0，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：指数Taylor余项、平方根正侧渐近及指数衰减的短桥接；不建设广义Langevin极限理论。
位置：Blueprint/Ch08.lean；MD.Ch08.gleDecay, MD.Ch08.gleNoiseCoefficient, MD.Ch08.gleCoefficientConsistency, MD.Ch08.gleCoefficients_consistent, MD.Ch08.gleCoefficient_smallMemory。

## 1. MD-8.8-NPTThermodynamics · unnumbered_claim · 印刷p.378 / PDFp.399

### 2. 原文陈述

P=−(∂E/∂V)_{S,N}; the Maxwell cyclic relation gives (∂S/∂V)_{E,N}=P/T and (∂S/∂E)_{V,N}=1/T.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.thermodynamicPressure, MD.Ch08.maxwellCycle, MD.Ch08.maxwellPressureRelation | 压力定义和给定非零温度/循环关系后的代数推论。 |

[EXTRA] E的熵、体积、粒子数参数固定顺序明示；Maxwell循环作为热力学可逆导数资格，并非从任意E无条件推出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.thermodynamicPressure, MD.Ch08.maxwellCycle, MD.Ch08.maxwellPressureRelation。

## 1. MD-8.8-NPTBathTaylor · unnumbered_claim · 印刷p.378 / PDFp.399

### 2. 原文陈述

S(N₂,V₂,E₂)=S(Ñ−N,Ṽ−V,Ẽ−E)≈S(N₂,Ṽ,Ẽ)−(E+PV)/T.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.nptBathLinear, MD.Ch08.nptEntropy_firstOrder | 线性熵近似与明确的一阶小o余项目标。 |

[EXTRA] 固定粒子数参数，只对E,V的小扰动；显式Fréchet可微及热力学导数识别，不把原文≈当作精确等式。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：可微定义的线性近似及负号仿射换元；短桥接未完成。
位置：Blueprint/Ch08.lean；MD.Ch08.nptBathLinear, MD.Ch08.nptEntropy_firstOrder。

## 1. MD-8.8-NPTDensity · unnumbered_claim · 印刷p.378–379 / PDFp.399–400

### 2. 原文陈述

ρ_NPT=Z_NPT⁻¹ exp[−β(H+PV)], β⁻¹=k_BT; physical volume V is positive.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.volumeScale, MD.Ch08.nptBox, MD.Ch08.nptWeight, MD.Ch08.nptDensity, MD.Ch08.nptDensity_normalizes | 正体积盒内NPT权重和有资格时的概率归一化。 |

[EXTRA] 三维N粒子时n=3N；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.volumeScale, MD.Ch08.nptBox, MD.Ch08.nptWeight, MD.Ch08.nptDensity, MD.Ch08.nptDensity_normalizes。

## 1. MD-8.8-AndersenCoordinates · unnumbered_claim · 印刷p.379–380 / PDFp.400–401

### 2. 原文陈述

qᵢ=V^{1/3}q̄ᵢ; q̇ᵢ=(1/3)V^{−2/3}V̇q̄ᵢ+V^{1/3}q̄̇ᵢ; p̄ᵢ=mᵢV^{1/3}q̇ᵢ. (8.71),(8.72).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.andersenPosition, MD.Ch08.andersenVelocity, MD.Ch08.andersenMomentum, MD.Ch08.andersenPosition_derivative, MD.Ch08.andersenMomentum_velocity | 位置、速度、共轭动量的实际变换式与两个局部等式目标。 |

[EXTRA] V>0用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：正数实幂求导与指数和法则的短桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.andersenPosition, MD.Ch08.andersenVelocity, MD.Ch08.andersenMomentum, MD.Ch08.andersenPosition_derivative, MD.Ch08.andersenMomentum_velocity。

## 1. MD-8.8-AndersenKineticEnergy · unnumbered_claim · 印刷p.379 / PDFp.400

### 2. 原文陈述

After q=V^{1/3}q̄, K̄=Σᵢ(mᵢ/2)[(1/9)V^{−4/3}V̇²|q̄ᵢ|²+(2/3)V^{−1/3}V̇q̄ᵢ·q̄̇ᵢ+V^{2/3}|q̄̇ᵢ|²].

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.andersenKinetic, MD.Ch08.andersenKineticExpanded, MD.Ch08.andersenKinetic_expansion | 所印动能展开的逐标量坐标版本。 |

[EXTRA] 坐标逐分量求和就是三维点积展开，避免把Pi类型的最大范数误作物理Euclidean长度；V正。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：正V的rpow乘法与有限和平方展开桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.andersenKinetic, MD.Ch08.andersenKineticExpanded, MD.Ch08.andersenKinetic_expansion。

## 1. MD-8.8-AndersenHamiltonianPrinted · unnumbered_claim · 印刷p.380 / PDFp.401

### 2. 原文陈述

Ĥ=Σᵢ|p̄ᵢ|²/(2mᵢV^{2/3})+Ū(q̄;V)+p_V²/(2μ_V)+PV, and ρ_NPT=√(β/(2πμ_V))∫exp(−βĤ)dp_V. (8.73).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.andersenHamiltonian, MD.Ch08.andersenMarginalPrinted, MD.Ch08.andersenMarginal_corrected, MD.Ch08.andersenGaussian_marginal | 活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。 |

[EXTRA] m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：一维Gaussian积分及常数因子桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.andersenHamiltonian, MD.Ch08.andersenMarginalPrinted, MD.Ch08.andersenMarginal_corrected, MD.Ch08.andersenGaussian_marginal。

## 1. MD-8.8.1-NHLPistonEquations · definition · 印刷p.381–382 / PDFp.402–403

### 2. 原文陈述

q̇=M⁻¹p+ηq, ṗ=F−ηp−ξp, V̇=ηV; dξ=(h_T−γ_Tξ)dt+√(2k_BTγ_T/μ_T)dW_T, dη=(h_P−γ_Pη)dt+√(2k_BTγ_P/μ_P)dW_P, with h_T=(pᵀM⁻¹p−N_dk_BT)/μ_T and h_P=(VΠ−PV+k_BT)/μ_P. (8.75)–(8.79).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.PistonState, MD.Ch08.pistonPressure, MD.Ch08.pistonDrift, MD.Ch08.pistonNoise, MD.Ch08.isNHLPistonSolution | 实际压力、反馈、漂移扩散和正体积NHL活塞积分解规格。 |

[EXTRA] z.2=(V,ξ,η)，V>0、热浴/活塞质量正、独立二维Wiener明确；所有辅助变量除V均为实数。；选择正体积域内的积分解类，不声明该类存在唯一或必然遍历；n=3N为物理情形。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.PistonState, MD.Ch08.pistonPressure, MD.Ch08.pistonDrift, MD.Ch08.pistonNoise, MD.Ch08.isNHLPistonSolution。

## 1. MD-8.8.1-PistonHamiltonianSubfield · unnumbered_claim · 印刷p.381 / PDFp.402

### 2. 原文陈述

ρ₁=φ₁(pᵀM⁻¹p/2+U(q))ψ(V,ξ,η) is stationary for the Hamiltonian part.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pistonHamiltonianPart, MD.Ch08.pistonHamiltonianWeight_stationary | Hamiltonian子场和其光滑复合权的局部驻定式。 |

[EXTRA] 只陈述实际通量散度为零；φ,ψ是权重而非自动概率密度，归一、可积和全局保测流不在本条。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：有限维Hamiltonian散度与冻结辅助变量的链式法则桥接。
位置：Blueprint/Ch08.lean；MD.Ch08.pistonHamiltonianPart, MD.Ch08.pistonHamiltonianWeight_stationary。

## 1. MD-8.8.1-PistonThermostatWeightPrinted · unnumbered_claim · 印刷p.381 / PDFp.402

### 2. 原文陈述

The book prints ρ₂=exp(−β[pᵀM⁻¹p+μ_Tξ²/2])ψ₂(q,η,V) for ṗ=−ξp, ξ̇=(pᵀM⁻¹p−N_dk_BT)/μ_T.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pistonThermostatPart, MD.Ch08.pistonRho2Printed, MD.Ch08.pistonRho2_corrected, MD.Ch08.pistonRho2_stationary_corrected | 原印/修正权重及ψ₂=1时的实际子场驻定目标。 |

[EXTRA] 仅取ψ₂=1的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：权重指数链式法则与实际散度计算。
位置：Blueprint/Ch08.lean；MD.Ch08.pistonThermostatPart, MD.Ch08.pistonRho2Printed, MD.Ch08.pistonRho2_corrected, MD.Ch08.pistonRho2_stationary_corrected。

## 1. MD-8.8.1-PistonReducedPDE · unnumbered_claim · 印刷p.382 / PDFp.403

### 2. 原文陈述

−q·∇qψ+p·∇pψ−ψ−V∂Vψ+(βVΠ−βPV+1)ψ=0, solved by ψ∝exp(−β(H+PV)). (8.74).

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pistonReducedOperator, MD.Ch08.pistonReduced_boltzmann | 完整(8.74)及Boltzmann权代入目标。 |

[EXTRA] 只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：实际Fréchet导数代入及压力定义消项。
位置：Blueprint/Ch08.lean；MD.Ch08.pistonReducedOperator, MD.Ch08.pistonReduced_boltzmann。

## 1. MD-8.8.1-PistonStationaryWeight · unnumbered_claim · 印刷p.382 / PDFp.403

### 2. 原文陈述

Adding the two independent OU thermostats to ξ,η preserves the candidate weight exp[−β(H+PV+μ_Tξ²/2+μ_Pη²/2)].

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.pistonWeight, MD.Ch08.pistonForward, MD.Ch08.pistonWeight_stationary | 候选权重与实际局部前向算子的驻定目标。 |

[EXTRA] 只陈述正V内的真实Fokker–Planck微分表达式为零；候选正权重并不自动可积/归一。；盒边界/体积边界的通量、Markov半群不变概率及唯一遍历性需要NPT理论，明确列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；Lean陈述可检查，证明完整性按本条状态区分。
未证原因：Hamiltonian/热浴/活塞/OU四部分的局部通量与二阶导数计算；不建立NPT半群理论。
位置：Blueprint/Ch08.lean；MD.Ch08.pistonWeight, MD.Ch08.pistonForward, MD.Ch08.pistonWeight_stationary。

## 1. MD-8.8.2-PistonIntegrator · definition · 印刷p.383 / PDFp.404

### 2. 原文陈述

The printed algorithm interleaves feedback half-updates, exponentially damped momentum kicks, exponential position/volume drifts, feedback recomputation and final independent OU steps. ψ(α,t)=(e^{αt}−1)/α, extended by t at α=0.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.expIntegrated, MD.Ch08.pistonWrap, MD.Ch08.pistonMomentumKick, MD.Ch08.pistonFeedback, MD.Ch08.pistonOU, MD.Ch08.pistonIntegrator, MD.Ch08.pistonOU_volume, MD.Ch08.pistonVolume_positive | 完整分步算法、周期映射及OU保持V和指数体积正性的短结论。 |

[EXTRA] 正β、QT、QP、质量、体积及h≥0是物理有效域；R取独立标准二维正态且跨步独立，参照independentWiener/standardNormalSequence所列资格。；零指数分支按原页连续延拓；周期位置在每次q/V更新后按当前盒长映射。只定义完整算法，不证明二阶、可逆或不变分布精度。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.expIntegrated, MD.Ch08.pistonWrap, MD.Ch08.pistonMomentumKick, MD.Ch08.pistonFeedback, MD.Ch08.pistonOU, MD.Ch08.pistonIntegrator, MD.Ch08.pistonOU_volume, MD.Ch08.pistonVolume_positive。

## 1. MD-8.8.3-ParrinelloRahman · definition · 印刷p.385 / PDFp.406

### 2. 原文陈述

For cell matrix h=[a b c], V=det(h)=a·(b×c), qᵢ=hq̄ᵢ, G=hᵀh, L=(1/2)Σmᵢq̄̇ᵢᵀGq̄̇ᵢ−Ū(q̄)+(μ/2)Tr(ḣᵀḣ)−PV.

### 3. 原文证明

对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

原页文字及推导保存在原文JSON的original_page_text；网站子包附对应完整原页PDF。

### 4. 完整当前Lean（原文与修正版独立列出）

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

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch08.cellVolume, MD.Ch08.cellMetric, MD.Ch08.cellPosition, MD.Ch08.cross3, MD.Ch08.cellVolume_triple, MD.Ch08.parrinelloRahmanLagrangian, MD.Ch08.cellQualification | 各向异性盒的体积/位置/度量/Lagrangian及标量三重积恒等式。 |

[EXTRA] 选定正定向非退化盒det(h)>0及正质量；U为缩放坐标势，必要时由实际h映射后势复合而得。；拉氏方程、与热浴耦合和防止盒塌缩均未在原页给完整条件，列覆盖缺口，不把内部结构的经验稳定性当定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；Lean陈述可检查，证明完整性按本条状态区分。
本条未登记待证缺项。
位置：Blueprint/Ch08.lean；MD.Ch08.cellVolume, MD.Ch08.cellMetric, MD.Ch08.cellPosition, MD.Ch08.cross3, MD.Ch08.cellVolume_triple, MD.Ch08.parrinelloRahmanLagrangian, MD.Ch08.cellQualification。

