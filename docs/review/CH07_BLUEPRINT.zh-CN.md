# 第7章 Lean Blueprint 本地审阅材料

当前已整理30条；网站尚未审阅。正文范围为印刷261–326页（PDF282–347），末页仅取Exercises之前的正文。

## 1. MD-7.1-Bias · definition · 印刷p.263 / PDFp.284

### 2. 原文陈述

All standard methods based on discretizing SDEs introduce some stepsize-dependent error in computed averages, which we shall refer to as bias (related to the truncation error of the discretization scheme).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def bias (exact computed : ℝ) : ℝ := |exact - computed|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bias | 离散平均值偏差的定义；本段关于标准方法的概述不作为普遍量化结论。 |

[EXTRA] 将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.bias。

## 1. MD-7.2-ScalarSDE · definition · 印刷p.264 / PDFp.285

### 2. 原文陈述

Let us begin with a discussion of the first order stochastic differential equation
\[dX=a(X)dt+b(X)dW,\]
where $W$ defines a standard scalar Wiener process.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def scalarSDE (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ IsBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ T : ℝ, 0 ≤ T → ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W
    (fun t sample ↦ b (X t sample)) ∧
  MolecularDynamics.Chapter06Review.scalarSDE P W X
    (fun x _ ↦ a x) (fun x _ ↦ b x) x0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.scalarSDE | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 明确概率空间与标准连续Wiener过程；Itô积分采用第6章网格左和L²定义，扩散项适应自然历史且时间平方可积。；X的初值、几乎处处路径连续性和积分方程在第6章定义体中全部保留；未声称一般弱解与本L²表示等价。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.scalarSDE。

## 1. MD-7.2-EulerMaruyama · definition · 印刷p.264 / PDFp.285

### 2. 原文陈述

The natural extension of the Euler method for SDEs like this one takes the form
\[X_{n+1}=X_n+ha(X_n)+b(X_n)\sqrt h R_n,\]
where $R_n$ is a normal random variable with zero mean and unit variance. This method is referred to as the Euler-Maruyama method.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def eulerMaruyamaStep (a b : ℝ → ℝ) (h x R : ℝ) : ℝ :=
  x + h * a x + b x * Real.sqrt h * R

def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (gaussianReal 0 1) P

def eulerMaruyama (a b : ℝ → ℝ) (h x0 : ℝ) (R : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | k+1 => fun sample ↦ eulerMaruyamaStep a b h (eulerMaruyama a b h x0 R k sample) (R k sample)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.eulerMaruyamaStep, MD.Ch07.standardNormalSequence, MD.Ch07.eulerMaruyama | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 步长h>0用于数值解释；单步映射本身为总函数；跨步独立正态资格另由standardNormalSequence明确给出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.eulerMaruyamaStep, MD.Ch07.standardNormalSequence, MD.Ch07.eulerMaruyama。

## 1. MD-7.2-SDEIncrement · unnumbered_claim · 印刷p.264 / PDFp.285

### 2. 原文陈述

Note that from the definition of the SDE, we may write
\[X(t+h)=X(t)+\int_t^{t+h}a(X(s))ds+\int_t^{t+h}b(X(s))dW(s).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem sdeIncrement (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 t h : ℝ) (ht : 0 ≤ t) (hh : 0 ≤ h)
    (hX : scalarSDE P W X a b x0)
    (ha : ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 (t+h)) :
    MolecularDynamics.Chapter06Review.isItoIntegral P W (fun s sample ↦ b (X s sample)) (t+h)
      (fun sample ↦ X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) ∧
    ∀ᵐ sample ∂P, X (t+h) sample - X t sample =
      (∫ s in t..(t+h), a (X s sample)) +
      ((X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) -
       (X t sample - x0 - ∫ s in 0..t, a (X s sample))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.sdeIncrement | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 区间Itô积分用两个从0开始的L²积分值之差表示；t,h非负，漂移在整个区间可积；不另造未规定的随机积分。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需对第6章L²积分定义补区间可加性及积分几乎处处组合桥接；本轮不建立一般随机积分理论。
位置：Blueprint/Ch07.lean；MD.Ch07.sdeIncrement。

## 1. MD-7.2-StrongError · definition · 印刷p.264 / PDFp.285

### 2. 原文陈述

In the case of strong accuracy, our measure of the global error is the quantity [200]
\[\mathrm{Err}_{h,\tau;\alpha}^{\rm strong}=\max_{n=0,1,2,\ldots,\nu}
\left[\mathbb E|X_n-X(nh)|^\alpha\right]^{1/\alpha}.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def strongError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (h α : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = (∫ sample, |Xh k sample - X (k*h) sample| ^ α ∂P) ^ (1/α)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.strongError | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] α>0且各网格误差的α次矩可积时具有误差解释；有限非空网格的sSup表示最大值；Real.rpow为实指数幂。
记号与上下文：τ=νh固定；Xh与X在同一概率空间耦合。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.strongError。

## 1. MD-7.2-MeanErrorExpectation · unnumbered_claim · 印刷p.264 / PDFp.285

### 2. 原文陈述

For $\alpha=1$ this implies convergence of expectation. The more natural choice from the probabilistic point of view is $\alpha=2$ (mean square convergence).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem meanErrorExpectation (P : Measure Ω) (X Y : Ω → ℝ)
    (hX : Integrable X P) (hY : Integrable Y P) :
    |(∫ sample, X sample ∂P) - ∫ sample, Y sample ∂P| ≤
      ∫ sample, |X sample - Y sample| ∂P := by
  rw [← integral_sub hX hY]
  simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun sample ↦ X sample - Y sample)

def meanSquareError (P : Measure Ω) (X Y : Ω → ℝ) : ℝ :=
  Real.sqrt (∫ sample, (X sample - Y sample)^2 ∂P)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.meanErrorExpectation, MD.Ch07.meanSquareError | α=1所需期望误差不等式，及α=2均方误差的记号；网格极限通过此界立即归约。 |

[EXTRA] 期望可积；不以数值方法的收敛为假设重新宣布同一收敛，只给使收敛传递成立的定量不等式。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.meanErrorExpectation, MD.Ch07.meanSquareError。

## 1. MD-7.2-StrongOrder · definition · 印刷p.264 / PDFp.285

### 2. 原文陈述

Having settled on a choice of $\alpha$, we say that a method has strong order $r$ if
$\mathrm{Err}_{h,\tau}^{\rm strong}<C(\tau)h^r$ for some coefficient $C(\tau)$ depending on the time interval.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hasStrongOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (α r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < α ∧ 0 < r ∧
  ∀ T : ℝ, 0 < T → ∃ C : ℝ, 0 < C ∧ ∃ N0 : ℕ, 0 < N0 ∧
    ∀ N : ℕ, N0 ≤ N →
      (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ |Xh (T/N) k sample - X (k*(T/N)) sample|^α) P) ∧
      strongError P (Xh (T/N)) X (T/N) α N < C * (T/N)^r
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.hasStrongOrder | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 显式h=T/N趋零及统一常数的量词；正α、r和时间；有限矩资格作为方法适用条件不隐去。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.hasStrongOrder。

## 1. MD-7.2-WeakError · definition · 印刷p.265 / PDFp.286

### 2. 原文陈述

The weak error is usually defined with reference to suitable test functions (observables) $\phi(x)$ by
\[\mathrm{Err}^{\rm weak}_{h,\tau,\phi}=\max_{n=0,1,2,\ldots,\nu}|\mathbb E\phi(X_n)-\mathbb E\phi(X(nh))|,\]
and we say that a method has weak order $r$ if $\mathrm{Err}^{\rm weak}_{h,\tau,\phi}<D(\tau)h^r$ for some $D(\tau)$, for all members of the chosen class of observables.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def weakError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (f : ℝ → ℝ) (h : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = |(∫ sample, f (Xh k sample) ∂P) - ∫ sample, f (X (k*h) sample) ∂P|}

def hasWeakOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (tests : Set (ℝ → ℝ)) (r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < r ∧ ∀ f ∈ tests, ∀ T : ℝ, 0 < T →
    ∃ D : ℝ, 0 < D ∧ ∃ N0 : ℕ, 0 < N0 ∧
      ∀ N : ℕ, N0 ≤ N →
        (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ f (Xh (T/N) k sample)) P ∧
          Integrable (fun sample ↦ f (X (k*(T/N)) sample)) P) ∧
        weakError P (Xh (T/N)) X f (T/N) N < D*(T/N)^r
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.weakError, MD.Ch07.hasWeakOrder | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 测试函数类明确量化；D允许依赖测试函数；积分只有在可积时解释为期望，后续误差定理显式要求可积。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.weakError, MD.Ch07.hasWeakOrder。

## 1. MD-7.2-StrongWeakComparison · unnumbered_claim · 印刷p.265 / PDFp.286

### 2. 原文陈述

It is easy to see that methods with high strong order give us high weak order too, but the converse is generally false.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem strongWeakLipschitz (P : Measure Ω) (X Y : Ω → ℝ)
    (f : ℝ → ℝ) (L : ℝ) (hL : 0 ≤ L)
    (hf : ∀ x y, |f x - f y| ≤ L * |x-y|)
    (hfx : Integrable (fun sample ↦ f (X sample)) P)
    (hfy : Integrable (fun sample ↦ f (Y sample)) P)
    (hxy : Integrable (fun sample ↦ |X sample-Y sample|) P) :
    |(∫ sample, f (X sample) ∂P) - ∫ sample, f (Y sample) ∂P| ≤
      L * ∫ sample, |X sample-Y sample| ∂P := by
  calc
    _ ≤ ∫ sample, |f (X sample)-f (Y sample)| ∂P :=
      meanErrorExpectation P _ _ hfx hfy
    _ ≤ ∫ sample, L * |X sample-Y sample| ∂P :=
      integral_mono (hfx.sub hfy).abs (hxy.const_mul L) (fun sample ↦ hf _ _)
    _ = _ := integral_const_mul _ _

theorem weakDoesNotImplyStrong : ∃ (P : Measure ℝ) (X Y : ℝ → ℝ),
    IsProbabilityMeasure P ∧
    (∀ f : ℝ → ℝ, (∫ sample, f (X sample) ∂P) = ∫ sample, f (Y sample) ∂P) ∧
    0 < ∫ sample, |X sample-Y sample| ∂P := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.strongWeakLipschitz, MD.Ch07.weakDoesNotImplyStrong | Lipschitz测试函数的逐步定量界与反向不成立的存在性；未证明一般多项式增长测试类的阶数传递。 |

[EXTRA] 正向结论明确限制为全局Lipschitz可观测量及可积误差；对一般无界测试函数需额外矩条件，列为覆盖缺口。；反向用两点分布上交换X、Y的反例表达；同分布但耦合强误差不为零。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：反向反例还需两点概率测度的积分化简；下一批限三条短路线。
位置：Blueprint/Ch07.lean；MD.Ch07.strongWeakLipschitz, MD.Ch07.weakDoesNotImplyStrong。

## 1. MD-7.2-CanonicalAverage · (7.1) · 印刷p.266 / PDFp.287

### 2. 原文陈述

Recall that for canonical sampling, the (stationary or invariant) average of an observable $\phi(q,p)$ is given as
\[\operatorname{Av}_\beta(\phi)=\int_D\phi(q,p)\rho_\beta(q,p)d\omega,\tag{7.1}\]
where $\rho_\beta$ is the canonical measure
\[\rho_\beta(q,p)=Z_{\rm can}^{-1}\exp(-\beta H(q,p)).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def densityWithPartition {D : Type*} (H : D → ℝ) (β Z : ℝ) (x : D) : ℝ :=
  Z⁻¹ * Real.exp (-β * H x)

def canonicalAverage {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z : ℝ) : ℝ := ∫ x, f x * densityWithPartition H β Z x ∂ν

def probabilityDensity {D : Type*} [MeasurableSpace D] (ν : Measure D) (ρ : D → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ x) ∧ Integrable ρ ν ∧ (∫ x, ρ x ∂ν) = 1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.densityWithPartition, MD.Ch07.canonicalAverage, MD.Ch07.probabilityDensity | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 该公式先保留显式Z参数；只有probabilityDensity成立才称概率密度。正有限配分积分及其归一化见修正版，不把原页倒数疑误带入默认定义。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.densityWithPartition, MD.Ch07.canonicalAverage, MD.Ch07.probabilityDensity。

## 1. MD-7.2-PartitionPrinted · unnumbered_claim · 印刷p.266 / PDFp.287

### 2. 原文陈述

and $Z_{\rm can}$ is the canonical partition function
\[Z_{\rm can}^{-1}=\int_D\exp(-\beta H(q,p))d\omega,\]
ensuring the integral of $\rho_\beta$ is unity.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem partitionPrinted {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β Z : ℝ) (hZ : 0 < Z)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hPrinted : Z⁻¹ = ∫ x, Real.exp (-β*H x) ∂ν) :
    (∫ x, densityWithPartition H β Z x ∂ν) = 1 := by
  sorry

theorem partitionPrinted_counterexample :
    (2 : ℝ)⁻¹ * (2 : ℝ)⁻¹ ≠ 1 := by norm_num

theorem partitionPrinted_corrected {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hZ : 0 < ∫ x, Real.exp (-β*H x) ∂ν) :
    probabilityDensity ν (densityWithPartition H β (∫ x, Real.exp (-β*H x) ∂ν)) := by
  refine ⟨fun x ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ)) (le_of_lt (Real.exp_pos _)),
    hi.const_mul _, ?_⟩
  simp only [densityWithPartition, integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.partitionPrinted, MD.Ch07.partitionPrinted_counterexample, MD.Ch07.partitionPrinted_corrected | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 原文版严格保留倒数关系；修正版取Z_can=配分积分，并补正性、可积性。；反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF287／印刷266：原书确为Z_can^{-1}=积分，和紧接的归一化断言不相容；不是转录错误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：原文倒数关系导致归一化错误，原文版不证明；修正版正常证明。
位置：Blueprint/Ch07.lean；MD.Ch07.partitionPrinted, MD.Ch07.partitionPrinted_counterexample, MD.Ch07.partitionPrinted_corrected。

## 1. MD-7.2-AverageNotationBias · notation · 印刷p.266 / PDFp.287

### 2. 原文陈述

In this chapter, we will abbreviate the exact average of the observable $\phi$ to
\[\langle\phi\rangle\overset{\rm def}=\operatorname{Av}_\beta(\phi),\]
and write the observed average computed in experiment (using a discretization method with step size $h$) as $\langle\phi\rangle_h$. The error in the average of $\phi$ due to the perfect sampling bias can be evaluated as
\[\text{Error due to discretization}=|\langle\phi\rangle-\langle\phi\rangle_h|.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def observableBias {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z computed : ℝ) : ℝ :=
  bias (canonicalAverage ν H f β Z) computed

theorem bias_nonnegative (exact computed : ℝ) : 0 ≤ bias exact computed := abs_nonneg _
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.observableBias, MD.Ch07.bias_nonnegative | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] computed代表步长h下的不变平均，按原文忽略有限采样误差；正确Z和密度概率资格见CanonicalAverage及修正版。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.observableBias, MD.Ch07.bias_nonnegative。

## 1. MD-7.3-VectorOU · (7.2) · 印刷p.267 / PDFp.288

### 2. 原文陈述

By way of illustration of what we mean by a numerical sampling method, consider the system of independent Ornstein-Uhlenbeck (OU) processes
\[dp=-\gamma pdt+\sqrt{2k_BT\gamma}\,M^{1/2}dW.\tag{7.2}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev V (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := V n × V n

def vectorWiener (P : Measure Ω) (W : ℝ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  iIndepFun (fun i sample t ↦ W t sample i) P

def momentumOU (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  ∀ i, scalarSDE P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i)
    (fun x ↦ -γ*x) (fun _ ↦ Real.sqrt (2*γ*θ*m i)) (p0 i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.V, MD.Ch07.Phase, MD.Ch07.vectorWiener, MD.Ch07.momentumOU | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 显式标准多维Wiener及整个坐标路径独立，正质量、温度与非负摩擦；各坐标用真实Itô积分方程。
记号与上下文：θ=k_BT；M为正对角质量矩阵，m i为其对角元。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.V, MD.Ch07.Phase, MD.Ch07.vectorWiener, MD.Ch07.momentumOU。

## 1. MD-7.3-OUIntegratingFactor · unnumbered_claim · 印刷p.267 / PDFp.288

### 2. 原文陈述

Following the argument of Sect. 6.3.2 in the previous chapter,
\[d[\exp(\gamma t)p]=\gamma\exp(\gamma t)pdt+\exp(\gamma t)[-\gamma pdt+\sqrt{2k_BT\gamma}M^{1/2}dW]
=\exp(\gamma t)\sqrt{2k_BT\gamma}M^{1/2}dW.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem ouIntegratingFactor (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t : ℝ) (ht : 0 ≤ t) : ∀ i,
    MolecularDynamics.Chapter06Review.isItoIntegral P (fun s sample ↦ W s sample i)
      (fun s _ ↦ Real.exp (γ*s)*Real.sqrt (2*γ*θ*m i)) t
      (fun sample ↦ Real.exp (γ*t)*p t sample i-p0 i) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.ouIntegratingFactor | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 把随机微分乘积法则陈述为从0到t的确定性加权Itô积分等式；有限时间和L²解资格由momentumOU明确。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要第6章Itô积分定义与积分因子法的桥接；不新建一般随机乘积法则。
位置：Blueprint/Ch07.lean；MD.Ch07.ouIntegratingFactor。

## 1. MD-7.3-OUExactUpdate · (7.3) · 印刷p.268 / PDFp.289

### 2. 原文陈述

Integrating from $t$ to $t+h$ and multiplying by $\exp(-\gamma t)$, we arrive at the solution
\[p(t+h)=e^{-\gamma h}p(t)+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}Z,\tag{7.3}\]
where $Z$ is a vector of independent, standard normal random variables.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def ouMomentum (m : V n) (γ θ h : ℝ) (p R : V n) : V n :=
  fun i ↦ Real.exp (-γ*h)*p i + Real.sqrt (θ*(1-Real.exp (-2*γ*h))) * Real.sqrt (m i) * R i

theorem ouTransitionLaw (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t h : ℝ) (ht : 0 ≤ t) (hh : 0 < h) :
    ∃ Z : Ω → V n, HasLaw Z (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P ∧
      IndepFun (p t) Z P ∧ ∀ᵐ sample ∂P,
        p (t+h) sample = ouMomentum m γ θ h (p t sample) (Z sample) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.ouMomentum, MD.Ch07.ouTransitionLaw | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 等式解释为存在与过去动量独立的标准正态向量的随机表示；不是沿用同一Z表示所有时刻。；独立性要求使用W自然历史的适应解，见scalarSDE；θ=k_BT，M正对角。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要加权Wiener增量的联合Gaussian分布及相对过去的独立性；不建设一般SDE转移核理论。
位置：Blueprint/Ch07.lean；MD.Ch07.ouMomentum, MD.Ch07.ouTransitionLaw。

## 1. MD-7.3-OUPhaseIteration · definition · 印刷p.268 / PDFp.289

### 2. 原文陈述

Alternatively, we may write this as a discrete iteration in terms of a random map:
\[p_{n+1}=e^{-\gamma h}p_n+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R_n,\]
with normally distributed $R$. For later purposes, we will think of this update as acting on both $q$ and $p$, leaving $q$ unchanged, i.e.
\[(q_{n+1},p_{n+1})=(q_n,e^{-\gamma h}p_n+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R_n).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def ouStep (m : V n) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  (x.1, ouMomentum m γ θ h x.2 R)

def vectorNormalSequence (P : Measure Ω) (R : ℕ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.ouStep, MD.Ch07.vectorNormalSequence | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 独立标准正态的完整概率资格由vectorNormalSequence规定；ouStep只是总化单步函数。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.ouStep, MD.Ch07.vectorNormalSequence。

## 1. MD-7.3-OUForward · unnumbered_claim · 印刷p.268 / PDFp.289

### 2. 原文陈述

The Fokker-Planck operator for the OU system (7.2) can be computed directly as
\[\mathcal L_O^\dagger\phi(q,p)=\gamma\nabla_p\cdot(p\phi)+\gamma k_BT\nabla_p\cdot M\nabla_p\phi.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def coordDerivative (f : V n → ℝ) (x : V n) (i : Fin n) : ℝ :=
  deriv (fun z ↦ f (Function.update x i z)) (x i)

def ouForward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  γ * (∑ i, coordDerivative (fun x ↦ x i*f x) p i) +
    γ*θ * ∑ i, m i * coordDerivative (fun x ↦ coordDerivative f x i) p i

def ouBackward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  -γ * (∑ i, p i * coordDerivative f p i) +
    γ*θ * ∑ i, m i * coordDerivative (fun x ↦ coordDerivative f x i) p i

theorem ouForward_adjoint (m : V n) (γ θ : ℝ) (f g : V n → ℝ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) :
    (∫ p, f p * ouBackward m γ θ g p) = ∫ p, ouForward m γ θ f p * g p := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.coordDerivative, MD.Ch07.ouForward, MD.Ch07.ouBackward, MD.Ch07.ouForward_adjoint | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] partial为真实单坐标导数；给出前向表达式与后向生成元在紧支撑C²测试函数上的伴随恒等式。；仅p变量，q是固定参数；未声称已构造OU Markov半群的强生成元域。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要任意有限维逐坐标两次分部积分；本轮仅陈述，不为此建设大型算子域理论。
位置：Blueprint/Ch07.lean；MD.Ch07.coordDerivative, MD.Ch07.ouForward, MD.Ch07.ouBackward, MD.Ch07.ouForward_adjoint。

## 1. MD-7.3-OUGaussianInvariant · unnumbered_claim · 印刷p.268 / PDFp.289

### 2. 原文陈述

Alternatively, if we ignore the physical origin of this parameter, we can think of $\gamma$ as an arbitrary coefficient; the sampling of the invariant measure does not depend on this choice. Thus we have a family of sampling iterations for the Gaussian distribution, defined for different choices of $\gamma$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem ouGaussianInvariant (m : V n) (γ θ h : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : 0 ≤ γ) (hθ : 0 < θ) (hh : 0 ≤ h) :
    Measure.map (fun x : V n × V n ↦ ouMomentum m γ θ h x.1 x.2)
      ((Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩)).prod
        (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) =
      Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.ouGaussianInvariant | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] γ=0允许恒等更新，仍保留Gaussian不变性；不把此时的不变性说成遍历采样收敛。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需实际独立Gaussian向量线性变换与指数/方差恒等式的桥接；不建立一般随机核理论。
位置：Blueprint/Ch07.lean；MD.Ch07.ouGaussianInvariant。

## 1. MD-7.3.1-Langevin · (7.4) · 印刷p.268 / PDFp.289

### 2. 原文陈述

Langevin dynamics:
\[dq=M^{-1}pdt,\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{7.4}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def gradient (U : V n → ℝ) (q : V n) : V n := fun i ↦ coordDerivative U q i

def langevin (P : Measure Ω) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (U : V n → ℝ) (m : V n) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → ∀ i,
    IntervalIntegrable (fun s ↦ (X s sample).2 i / m i) volume 0 t ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i - γ*(X s sample).2 i) volume 0 t ∧
    (X t sample).1 i = x0.1 i + (∫ s in 0..t, (X s sample).2 i / m i) ∧
    (X t sample).2 i = x0.2 i + (∫ s in 0..t, -gradient U (X s sample).1 i - γ*(X s sample).2 i) +
      Real.sqrt (2*γ*θ*m i) * (W t sample i - W 0 sample i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.gradient, MD.Ch07.langevin | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 用真实坐标偏导与完整位置/动量积分方程表达；常扩散的Itô项即W增量乘系数；显式状态适应W自然历史、漂移可积。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.gradient, MD.Ch07.langevin。

## 1. MD-7.3.1-HamiltonianGibbs · unnumbered_claim · 印刷p.269 / PDFp.290

### 2. 原文陈述

Since Hamiltonian dynamics leaves invariant any function of the energy, its corresponding Fokker-Planck operator (in this case the Liouvillian, $\mathcal L_H^\dagger=-\mathcal L_H$) will preserve distributions that are functions of the Hamiltonian $H$. This implies in particular that it preserves $\rho_\beta$, which is proportional to $\exp(-\beta H)$. Thus the forward propagator associated to the Hamiltonian system automatically preserves the Gibbs distribution, and we have
\[e^{t\mathcal L_H^\dagger}\rho_\beta=\rho_\beta.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamiltonianGibbs {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (F : D → D) (H : D → ℝ) (β : ℝ)
    (hF : Measurable F) (hv : MeasurePreserving F ν ν)
    (hH : ∀ x, H (F x) = H x) (hweight : Measurable (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) :
    Measure.map F (ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) =
      ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.hamiltonianGibbs | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] F为已存在的实际Hamiltonian流的固定时刻映射；显式体积保持与能量保持，结论为实际加权测度不变性。；本文未重证明一般Hamiltonian流存在；若需归一化为概率，须另补配分积分正有限。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需map与withDensity的测度输运短桥；现有Hamiltonian体积保持可作为流资格，不新建流存在理论。
位置：Blueprint/Ch07.lean；MD.Ch07.hamiltonianGibbs。

## 1. MD-7.3.1-ABOPieces · (7.5) · 印刷p.269–270 / PDFp.290–291

### 2. 原文陈述

We therefore consider dividing the Langevin system (7.4) into parts
\[d\binom qp=\binom{M^{-1}p}{0}dt+\binom0{-\nabla U(q)}dt+\binom0{-\gamma pdt+\sigma M^{1/2}dW},\tag{7.5}\]
which we label A, B, and O, where each of the three parts may be solved “exactly”, with individual updates given as
\[\mathcal U_h^A(q,p)=(q+hM^{-1}p,p),\quad
\mathcal U_h^B(q,p)=(q,p-h\nabla U(q)),\quad
\mathcal U_h^O(q,p)=(q,e^{-\gamma h}p+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R),\]
where $R$ is a vector of i.i.d. normal random numbers.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def driftStep (m : V n) (h : ℝ) (x : Phase n) : Phase n :=
  (fun i ↦ x.1 i + h * x.2 i / m i, x.2)

def kickStep (U : V n → ℝ) (h : ℝ) (x : Phase n) : Phase n :=
  (x.1, fun i ↦ x.2 i - h * gradient U x.1 i)

def aField (m : V n) (x : Phase n) : Phase n := (fun i ↦ x.2 i / m i, 0)
def bField (U : V n → ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -gradient U x.1 i)
def oDrift (γ : ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -γ*x.2 i)

theorem splittingDrift (m : V n) (U : V n → ℝ) (γ : ℝ) (x : Phase n) :
    aField m x + bField U x + oDrift γ x =
      (fun i ↦ x.2 i / m i, fun i ↦ -gradient U x.1 i - γ*x.2 i) := by
  ext i <;> simp [aField, bField, oDrift] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.driftStep, MD.Ch07.kickStep, MD.Ch07.aField, MD.Ch07.bField, MD.Ch07.oDrift, MD.Ch07.splittingDrift | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] M为正对角质量；σ=√(2γk_BT)；OU单步及独立正态资格已在OUPhaseIteration写全。；仅最后短定理证明漂移相加；A/B确定性精确流与O分布精确性各自另列，不用漂移恒等式替代。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.driftStep, MD.Ch07.kickStep, MD.Ch07.aField, MD.Ch07.bField, MD.Ch07.oDrift, MD.Ch07.splittingDrift。

## 1. MD-7.3.1-ABExactFlows · unnumbered_claim · 印刷p.270 / PDFp.291

### 2. 原文陈述

For the deterministic pieces A and B, the updates correspond to their flow maps, while the update for the O piece corresponds to the solution derived in (7.3).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem driftStep_derivative (m : V n) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (driftStep m s x).1 i) (x.2 i / m i) t := by
  simpa [driftStep, mul_div_assoc] using ((hasDerivAt_id t).mul_const (x.2 i / m i)).const_add (x.1 i)

theorem kickStep_derivative (U : V n → ℝ) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (kickStep U s x).2 i) (-gradient U x.1 i) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.driftStep_derivative, MD.Ch07.kickStep_derivative | A/B非恒定坐标的精确微分关系；O部分见MD-7.3-OUExactUpdate。 |

[EXTRA] 逐坐标A位置/B动量真实时间导数；另一个分量由更新定义恒定；O精确性引用OUTransitionLaw未证陈述，不冒称全部已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：kickStep导数三条短路线均未通过；停止该条，保留陈述。
位置：Blueprint/Ch07.lean；MD.Ch07.driftStep_derivative, MD.Ch07.kickStep_derivative。

## 1. MD-7.3.1-ABForward · definition · 印刷p.270 / PDFp.291

### 2. 原文陈述

The relevant forward propagators for each piece of the Hamiltonian part are computed through the adjoint of the Lie derivatives as
\[\mathcal L_A^\dagger=-M^{-1}p\cdot\nabla_q,\qquad
\mathcal L_B^\dagger=\nabla U(q)\cdot\nabla_p.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def aForward (m : V n) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  -∑ i, x.2 i / m i * coordDerivative (fun q ↦ f (q,x.2)) x.1 i
def bForward (U : V n → ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, gradient U x.1 i * coordDerivative (fun p ↦ f (x.1,p)) x.2 i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.aForward, MD.Ch07.bForward | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 以真实偏导定义所印微分表达式；形式伴随解释要求足够光滑及边界通量消失，未声称一般强算子域。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.aForward, MD.Ch07.bForward。

## 1. MD-7.3.1-ABOBABO · definition · 印刷p.270 / PDFp.291

### 2. 原文陈述

For example, the method denoted $[ABO]$ (acting from left to right) has a resulting update
\[\mathcal U_h^{[ABO]}=\mathcal U_h^O\circ\mathcal U_h^B\circ\mathcal U_h^A.\]
An alternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme denoted $[BABO]$ with associated map
\[\mathcal U_h^{[BABO]}=\mathcal U_h^O\circ\mathcal U_{h/2}^B\circ\mathcal U_h^A\circ\mathcal U_{h/2}^B.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def abo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U h ∘ driftStep m h
def babo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.abo, MD.Ch07.babo | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 字母从左到右执行，函数复合从右到左；随机变量独立资格由vectorNormalSequence约束。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.abo, MD.Ch07.babo。

## 1. MD-7.3.1-WordConvention · definition · 印刷p.270 / PDFp.291

### 2. 原文陈述

As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABAOBAO]$ has an update
\[\mathcal U_h^{[OABAOBAO]}=\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O,\]
where the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/3) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/3) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/3) (R 0)

theorem oabaobaoCount : (["O","A","B","A","O","B","A","O"] : List String).count "O" = 3 := by decide
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.oabaobaoPrinted, MD.Ch07.oabaobaoPrinted_corrected, MD.Ch07.oabaobaoCount | 完整复合图式、O计数及时间分配修正；力求值说明列于上下文，不声称已证明计算成本。 |

[EXTRA] 原文图式照录3个h/4的O；修正版改3个h/3和3N_c随机数。力求值次数为实现说明，未形式化成本模型。；每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF291／印刷270：字串OABAOBAO有3个O，所印复合也仅3个O，却各用h/4并称4N_c个正态数；不符前句每字母总时长h的约定。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.oabaobaoPrinted, MD.Ch07.oabaobaoPrinted_corrected, MD.Ch07.oabaobaoCount。

## 1. MD-7.3.1-SixSchemes · definition · 印刷p.271 / PDFp.292

### 2. 原文陈述

For reference and to remove any ambiguity, we write out some of these algorithms below as single timestep maps.
\[\begin{array}{ll}
[ABAO]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\quad p_{n+1/2}=p_n-h\nabla U(q_{n+1/2}),\\
&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1/2},\quad p_{n+1}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n;\\
[BABO]:&p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\
&\hat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=e^{-h\gamma}\hat p_{n+1/2}+\zeta_2M^{1/2}R_n;\\
[ABOBA]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\quad p_{n+1/2}=p_n-(h/2)\nabla U(q_{n+1/2}),\\
&\hat p_{n+1/2}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n,\\
&p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1/2}),\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1};\\
[BAOAB]:&p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\
&\hat p_{n+1/2}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n,\\
&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\hat p_{n+1/2},\quad p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1});\\
[OABAO]:&p_{n+1/2}=e^{-h\gamma/2}p_n+\zeta_1M^{1/2}R_n,\\
&q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\quad\hat p_{n+1/2}=p_{n+1/2}-h\nabla U(q_{n+1/2}),\\
&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\hat p_{n+1/2},\quad p_{n+1}=e^{-h\gamma/2}\hat p_{n+1/2}+\zeta_1M^{1/2}R_{n+1/2};\\
[OBABO]:&p_{n+1/2}=e^{-h\gamma/2}p_n+\zeta_1M^{1/2}R_n,\quad\hat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),\\
&q_{n+1}=q_n+hM^{-1}\hat p_{n+1/2},\quad\hat p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\\
&p_{n+1}=e^{-h\gamma/2}\hat p_{n+1}+\zeta_1M^{1/2}R_{n+1/2},
\end{array}\]
where $\zeta_j=[k_BT(1-e^{-j\gamma h})]^{1/2}$, and $R_n,R_{n+1/2}$ are $N_d$ vectors of standard independent $\mathcal N(0,1)$ random variables, resampled at each step.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def abao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2)
def aboba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U (h/2) ∘ ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m (h/2)
def baoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def oabao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ (h/2) R
def obabo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ ouStep m γ θ (h/2) R
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.abao, MD.Ch07.aboba, MD.Ch07.baoab, MD.Ch07.oabao, MD.Ch07.obabo | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] BABO已定义于ABOBABO；其余5个完整复合依次对应所列中间步。；R与S为同一步两次O的独立标准正态向量；跨步也独立，用vectorNormalSequence提供资格。；原文最后“single evaluation”使用跨步缓存；实现成本不列为待证数学命题。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.abao, MD.Ch07.aboba, MD.Ch07.baoab, MD.Ch07.oabao, MD.Ch07.obabo。

## 1. MD-7.3.1-ConjugateIteration · unnumbered_claim · 印刷p.272 / PDFp.293

### 2. 原文陈述

When iterated $n+1$ times, we can see the scheme $[OABA]$ produces a mapping of the form
\[(\mathcal U_h^{[OABA]})^{n+1}=\mathcal U_{h/2}^A\circ\mathcal U_{h/2}^B\circ(\mathcal U_h^{[BAOAB]})^n\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/2}^A\circ\mathcal U_h^O;\]
therefore through a coordinate transformation the $[OABA]$ method can be morphed into the $[BAOAB]$ scheme.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem compositionIterate {D : Type*} (S T : D → D) (k : ℕ) :
    (S ∘ T)^[k+1] = S ∘ (T ∘ S)^[k] ∘ T := by
  funext x
  induction k with
  | zero => rfl
  | succ k ih =>
    simp only [Function.iterate_succ_apply', Function.comp_apply] at *
    rw [ih]

def oaba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.compositionIterate, MD.Ch07.oaba | 有限复合恒等式及OABA单步映射；独立随机序列上的共轭解释未形式化。 |

[EXTRA] compositionIterate是任意确定性映射的真实复合恒等式；实际随机迭代应在扩展噪声序列空间中使用更新映射，不能把固定R重复使用当独立重抽样。；对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.compositionIterate, MD.Ch07.oaba。

## 1. MD-7.3.2-SPVPrinted · definition · 印刷p.272 / PDFp.293

### 2. 原文陈述

Stochastic Position Verlet (SPV)
\[q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\qquad
p_{n+1}=e^{-h\gamma}p_n-\eta\nabla U(q_n)+\zeta M^{1/2}R_n,\qquad
q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}\]
where $\eta=(1-e^{-h\gamma})/\gamma$, $\zeta=[k_BT(1-e^{-2\gamma h})]^{1/2}$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def spvPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U x.1 i
  driftStep m (h/2) (qhalf,pnew)

def spvPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U qhalf i
  driftStep m (h/2) (qhalf,pnew)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.spvPrinted, MD.Ch07.spvPrinted_corrected | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.spvPrinted, MD.Ch07.spvPrinted_corrected。

## 1. MD-7.3.2-SPVLargeFriction · unnumbered_claim · 印刷p.272–273 / PDFp.293–294

### 2. 原文陈述

It is important to note that in the limit of infinite friction, we have $\eta\to0$ independent of the timestep $h$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $\gamma$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem spvEtaLimit (h : ℝ) (hh : 0 < h) :
    Tendsto (fun γ : ℝ ↦ (1-Real.exp (-h*γ))/γ) atTop (𝓝 0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.spvEtaLimit | 固定正h的η→0；随后的数值方法失效说明登记为适用范围讨论。 |

[EXTRA] 只表达明确的η极限；采样不一致的定性判断缺统一模型、时标与测试函数量化，不作为已证结论。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：指数衰减及除以γ的实极限短桥尚待尝试，不建立采样收敛理论。
位置：Blueprint/Ch07.lean；MD.Ch07.spvEtaLimit。

## 1. MD-7.3.2-BBK · definition · 印刷p.273 / PDFp.294

### 2. 原文陈述

Brünger-Brooks-Karplus (BBK)
\[p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,\]
\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad
p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R'_n]/(1+h\gamma/2).\]
Often $R'$ is chosen such that $R'_n=R_{n+1}$, so the random vector would be reused at the start of the following timestep, however there are many variants of this scheme that incorporate the redraw of random numbers differently. In other variants of BBK we take $R'_n=R_n$, reusing the random number within the step.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def bbk (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) (x : Phase n) : Phase n :=
  let ph := fun i ↦ (1-h*γ/2)*x.2 i - (h/2)*gradient U x.1 i +
    (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*R i
  let q := (driftStep m h (x.1,ph)).1
  (q, fun i ↦ (ph i-(h/2)*gradient U q i + (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*S i)/(1+h*γ/2))

def bbkSameNoise (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) := bbk m U γ θ h R R
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bbk, MD.Ch07.bbkSameNoise | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] h>0、γ≥0、θ>0、m_i>0时分母非零及噪声方差有效；不同R′耦合方案分别处理，不把独立与重用噪声混为一谈。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.bbk, MD.Ch07.bbkSameNoise。

