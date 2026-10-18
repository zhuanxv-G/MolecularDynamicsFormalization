# 第7章 Lean Blueprint 本地审阅材料

当前已整理107条；网站尚未审阅。正文范围为印刷261–326页（PDF282–347），末页仅取Exercises之前的正文。

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

## 1. MD-7.4-HarmonicHamiltonian · (7.6) · 印刷p.273 / PDFp.294

### 2. 原文陈述

Recall that the one-dimensional harmonic oscillator with spring constant $\Omega^2$ has potential energy function $U(q)=\Omega^2q^2/2$, with Hamiltonian
\[H(q,p)=\frac{p^2}{2m}+\frac{\Omega^2q^2}{2},\tag{7.6}\]
where $(q,p)\in\mathbb R^2$ represent a particle's position and momentum, and $m>0$ is the particle's mass.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def harmonicHamiltonian (m Ω : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/(2*m)+Ω^2*x.1^2/2
def harmonicLaw (m Ω θ : ℝ) : Measure (ℝ × ℝ) :=
  (gaussianReal 0 (Real.toNNReal (θ/Ω^2))).prod (gaussianReal 0 (Real.toNNReal (θ*m)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.harmonicHamiltonian, MD.Ch07.harmonicLaw | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 正m、正θ、Ω≠0时为可归一化的正则谐振子Gibbs分布；θ=k_BT。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.harmonicHamiltonian, MD.Ch07.harmonicLaw。

## 1. MD-7.4-HarmonicMoments · unnumbered_claim · 印刷p.273–274 / PDFp.294–295

### 2. 原文陈述

In this setting, the canonical distribution $\rho_\beta$ is the product of two Gaussian distributions, where we have invariant (stationary) averages
\[\langle q\rangle=\langle p\rangle=0,\qquad\langle\Omega^2q^2\rangle=\langle p^2/m\rangle=k_BT,\qquad\langle qp\rangle=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem harmonicMoments (m Ω θ : ℝ) (hm : 0 < m) (hΩ : Ω ≠ 0) (hθ : 0 < θ) :
    (∫ x, x.1 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, x.2 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, Ω^2*x.1^2 ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.2^2/m ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.1*x.2 ∂harmonicLaw m Ω θ) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.harmonicMoments | 实际正态乘积的全部五个矩；其Lebesgue密度等于归一Gibbs权的识别未另作定理。 |

[EXTRA] harmonicLaw给出实际正态乘积，未把所需各矩值作为假设；与Hamiltonian的密度识别另列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要正态二阶矩和乘积测度积分的完整短桥；不重建Gaussian理论。
位置：Blueprint/Ch07.lean；MD.Ch07.harmonicMoments。

## 1. MD-7.4-LinearIteration · (7.7) · 印刷p.274 / PDFp.295

### 2. 原文陈述

Thus, denoting the iteration index as a subscript, we may explicitly write one iteration of a general numerical method for evolving the dynamics as
\[\binom{q_{n+1}}{p_{n+1}}=\Psi\binom{q_n}{p_n}+\mu_n,\tag{7.7}\]
where $\Psi$ is a constant matrix that depends on the stepsize $h$, the friction coefficient $\gamma$, the particle mass $m$ and the spring constant $\Omega$. Additionally $\mu_n$ is a vector of stochastic processes.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def linearUpdate (a b c d : ℝ) (x noise : ℝ × ℝ) : ℝ × ℝ :=
  (a*x.1+b*x.2+noise.1,c*x.1+d*x.2+noise.2)
def momentQ (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1^2 ∂μ
def momentP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.2^2 ∂μ
def momentQP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1*x.2 ∂μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.linearUpdate, MD.Ch07.momentQ, MD.Ch07.momentP, MD.Ch07.momentQP | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 具体2×2矩阵用四个真实系数，噪声不假定自动独立；后续陈述分别补独立或相关结构。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.linearUpdate, MD.Ch07.momentQ, MD.Ch07.momentP, MD.Ch07.momentQP。

## 1. MD-7.4-BBKLinearForm · definition · 印刷p.274 / PDFp.295

### 2. 原文陈述

For example, in the BBK method we can compute directly from its update scheme that
\[\Psi^{\rm BBK}=\begin{bmatrix}1-\frac{h^2\Omega^2}{2m}&\frac hm(1-\frac{\gamma h}2)\\
\frac{h\Omega^2}{2m}\frac{h^2\Omega^2-4m}{2+\gamma h}&\frac{(2-\gamma h)(2m-h^2\Omega^2)}{2m(2+\gamma h)}\end{bmatrix},\]
\[\mu_n^{\rm BBK}=\begin{bmatrix}\sqrt{\frac{k_BT\gamma h^3}{2m}}R_n\\
\frac{\sqrt{2k_BT\gamma hm}}{2+\gamma h}[(1-\frac{h^2\Omega^2}{2m})R_n+R'_n]\end{bmatrix}.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def bbkMatrix (m Ω γ h : ℝ) : ℝ × ℝ × ℝ × ℝ :=
  (1-h^2*Ω^2/(2*m), h/m*(1-γ*h/2),
    h*Ω^2/(2*m)*((h^2*Ω^2-4*m)/(2+γ*h)),
    (2-γ*h)*(2*m-h^2*Ω^2)/(2*m*(2+γ*h)))
def bbkNoise (m Ω γ θ h R S : ℝ) : ℝ × ℝ :=
  (Real.sqrt (θ*γ*h^3/(2*m))*R,
    Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*((1-h^2*Ω^2/(2*m))*R+S))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bbkMatrix, MD.Ch07.bbkNoise | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.bbkMatrix, MD.Ch07.bbkNoise。

## 1. MD-7.4-QuadraticProducts · (7.8)–(7.10) · 印刷p.274 / PDFp.295

### 2. 原文陈述

More generally, if we define the components of $\Psi$ as $\psi_{ij}$ and denote $\mu_n=[\mu_{n,1},\mu_{n,2}]^T$ we can take products of the update equations defined by (7.7) to obtain
\[q_{n+1}^2=\psi_{11}^2q_n^2+\psi_{12}^2p_n^2+\mu_{n,1}^2+2\psi_{11}\psi_{12}q_np_n+2\psi_{11}\mu_{n,1}q_n+2\psi_{12}\mu_{n,1}p_n,\tag{7.8}\]
\[p_{n+1}^2=\psi_{21}^2q_n^2+\psi_{22}^2p_n^2+\mu_{n,2}^2+2\psi_{21}\psi_{22}q_np_n+2\psi_{21}\mu_{n,2}q_n+2\psi_{22}\mu_{n,2}p_n,\tag{7.9}\]
\[q_{n+1}p_{n+1}=\psi_{11}\psi_{21}q_n^2+\psi_{12}\psi_{22}p_n^2+\mu_{n,1}\mu_{n,2}+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})q_np_n
+(\psi_{11}\mu_{n,2}+\psi_{21}\mu_{n,1})q_n+(\psi_{22}\mu_{n,1}+\psi_{12}\mu_{n,2})p_n.\tag{7.10}\]

### 3. 原文证明

Take products of the update equations defined by (7.7).

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem quadraticProducts (a b c d q p r s : ℝ) :
    (linearUpdate a b c d (q,p) (r,s)).1^2 =
      a^2*q^2+b^2*p^2+r^2+2*a*b*q*p+2*a*r*q+2*b*r*p ∧
    (linearUpdate a b c d (q,p) (r,s)).2^2 =
      c^2*q^2+d^2*p^2+s^2+2*c*d*q*p+2*c*s*q+2*d*s*p ∧
    (linearUpdate a b c d (q,p) (r,s)).1*(linearUpdate a b c d (q,p) (r,s)).2 =
      a*c*q^2+b*d*p^2+r*s+(a*d+b*c)*q*p+(a*s+c*r)*q+(d*r+b*s)*p := by
  dsimp [linearUpdate]
  constructor
  · ring
  constructor <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.quadraticProducts | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 本条没有另加数学前提。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.quadraticProducts。

## 1. MD-7.4.1-StationaryMomentSystem · (7.11) · 印刷p.275 / PDFp.296

### 2. 原文陈述

Hence we have $\mathbb E(\mu_{n,i}q_n)=\mathbb E(\mu_{n,i}p_n)=0$, for any $i$ and $n$. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then considering the limit $n\to\infty$ we obtain a closed, linear system of equations
\[Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+\bar\mu_{11},\]
\[P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+\bar\mu_{22},\]
\[C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\bar\mu_{12},\tag{7.11}\]
where $\bar\mu_{11}=\mathbb E(\mu_{n,1}^2)$, $\bar\mu_{12}=\mathbb E(\mu_{n,1}\mu_{n,2})$, $\bar\mu_{22}=\mathbb E(\mu_{n,2}^2)$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def momentSystem (a b c d u v w Q P C : ℝ) : Prop :=
  Q = a^2*Q+b^2*P+2*a*b*C+u ∧
  P = c^2*Q+d^2*P+2*c*d*C+w ∧
  C = a*c*Q+b*d*P+(a*d+b*c)*C+v

def invariantLinearLaw (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ IsProbabilityMeasure η ∧
  Measure.map (fun z ↦ linearUpdate a b c d z.1 z.2) (μ.prod η) = μ

theorem stationaryMomentSystem (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ)
    (hinv : invariantLinearLaw μ η a b c d)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hr : MemLp (fun x ↦ x.1) 2 η) (hs : MemLp (fun x ↦ x.2) 2 η)
    (hmean : (∫ x, x.1 ∂η) = 0 ∧ (∫ x, x.2 ∂η) = 0) :
    momentSystem a b c d (momentQ η) (momentQP η) (momentP η)
      (momentQ μ) (momentP μ) (momentQP μ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.momentSystem, MD.Ch07.invariantLinearLaw, MD.Ch07.stationaryMomentSystem | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 使用独立乘积μ.prodη及实际推前不变性，不把所求矩方程当作该定理假设；所有坐标L²、噪声中心化明示。；只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需乘积测度、可积多项式与推前矩计算的桥接；不建立一般Markov链遍历理论。
位置：Blueprint/Ch07.lean；MD.Ch07.momentSystem, MD.Ch07.invariantLinearLaw, MD.Ch07.stationaryMomentSystem。

## 1. MD-7.4.1-ABOHarmonic · Example 7.1 / (7.12) · 印刷p.275–276 / PDFp.296–297

### 2. 原文陈述

Example 7.1 Consider the scheme coded $[ABO]$.
In the case of the one-dimensional harmonic oscillator, we have $U'(q)=\Omega^2q$, yielding the compact form of one iteration as
\[\binom{q_{n+1}}{p_{n+1}}=\begin{bmatrix}1&h/m\\-\Omega^2he^{-h\gamma}&(1-\Omega^2h^2/m)e^{-h\gamma}\end{bmatrix}\binom{q_n}{p_n}+\binom0{\zeta m^{1/2}R_n}.\tag{7.12}\]
Taking expectations of (7.12) and then taking the limit as $n\to\infty$, we see immediately that
$\langle q\rangle_h^{[ABO]}=\langle p\rangle_h^{[ABO]}=0$, as $\mathbb E(R_n)=0$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def aboHarmonic (m Ω γ θ h R : ℝ) (x : ℝ × ℝ) : ℝ × ℝ :=
  linearUpdate 1 (h/m) (-Ω^2*h*Real.exp (-h*γ)) ((1-Ω^2*h^2/m)*Real.exp (-h*γ)) x
    (0, Real.sqrt (θ*(1-Real.exp (-2*γ*h)))*Real.sqrt m*R)

theorem aboStationaryMean (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : Integrable (fun x ↦ x.1) μ) (hp : Integrable (fun x ↦ x.2) μ)
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    (∫ x, x.1 ∂μ) = 0 ∧ (∫ x, x.2 ∂μ) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.aboHarmonic, MD.Ch07.aboStationaryMean | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需推前期望方程与二元线性系统短桥；不建立Markov遍历性。
位置：Blueprint/Ch07.lean；MD.Ch07.aboHarmonic, MD.Ch07.aboStationaryMean。

## 1. MD-7.4.1-ABOVariance · unnumbered_claim · 印刷p.276 / PDFp.297

### 2. 原文陈述

For example, the relative increase in the variance of position is computed for the $[ABO]$ scheme as
\[\frac{\langle q^2\rangle_h^{[ABO]}}{\langle q^2\rangle}=\frac{e^{h\gamma}m(1+e^{-h\gamma})^2}{2m(1+e^{-h\gamma})-h^2\Omega^2e^{-h\gamma}}
=1+\gamma h/2+(\Omega^2+\gamma^2m)h^2/(4m)+O(h^3).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def aboVarianceRatio (m Ω γ h : ℝ) : ℝ :=
  Real.exp (h*γ)*m*(1+Real.exp (-h*γ))^2 /
    (2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))

theorem aboVarianceRatio_expansion (m Ω γ : ℝ) (hm : 0 < m) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ aboVarianceRatio m Ω γ h - (1+γ*h/2+(Ω^2+γ^2*m)*h^2/(4*m)))
      (fun h ↦ h^3) := by
  sorry

theorem aboStationaryVariance (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hden : 0 < 2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ / (θ/Ω^2) = aboVarianceRatio m Ω γ h := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.aboVarianceRatio, MD.Ch07.aboVarianceRatio_expansion, MD.Ch07.aboStationaryVariance | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需实际平稳矩方程求解及三阶Taylor余项；各路线超出短桥，保留未证。
位置：Blueprint/Ch07.lean；MD.Ch07.aboVarianceRatio, MD.Ch07.aboVarianceRatio_expansion, MD.Ch07.aboStationaryVariance。

## 1. MD-7.4.1-Table71 · Table 7.1 · 印刷p.277 / PDFp.298

### 2. 原文陈述

Table 7.1 The expected long-time computed average using the given second-order Langevin dynamics discretization scheme
\[\begin{array}{c|ccc}
\text{Scheme}&\langle q^2\rangle_h/\langle q^2\rangle&\langle p^2\rangle_h/\langle p^2\rangle&\langle qp\rangle\\
[ABOBA]&1&[1-h^2\Omega^2/(4m)]^{-1}&0\\
[OBABO]&[1-h^2\Omega^2/(4m)]^{-1}&1&0\\
[BAOAB]&1&1-h^2\Omega^2/(4m)&0\\
[OABAO]&1-h^2\Omega^2/(4m)&1&0
\end{array}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def scalarLift (F : Phase 1 → Phase 1) (x : ℝ × ℝ) : ℝ × ℝ :=
  let y := F ((fun _ ↦ x.1),(fun _ ↦ x.2))
  (y.1 0,y.2 0)

def symmetricHarmonicStep (scheme : Fin 4) (m Ω γ θ h : ℝ) (R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if scheme = 0 then aboba masses U γ θ h (fun _ ↦ R)
    else if scheme = 1 then obabo masses U γ θ h (fun _ ↦ R) (fun _ ↦ S)
    else if scheme = 2 then baoab masses U γ θ h (fun _ ↦ R)
    else oabao masses U γ θ h (fun _ ↦ R) (fun _ ↦ S))

def symmetricInvariant (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ symmetricHarmonicStep scheme m Ω γ θ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

theorem table71 (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hinv : symmetricInvariant scheme m Ω γ θ h μ) :
    momentQ μ/(θ/Ω^2) = (if scheme = 1 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 3 then 1-h^2*Ω^2/(4*m) else 1) ∧
    momentP μ/(θ*m) = (if scheme = 0 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 2 then 1-h^2*Ω^2/(4*m) else 1) ∧ momentQP μ = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.scalarLift, MD.Ch07.symmetricHarmonicStep, MD.Ch07.symmetricInvariant, MD.Ch07.table71 | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。；4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。；只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：四种真实分裂映射的Gaussian矩输运与线性方程求解；不建立一般离散遍历理论。
位置：Blueprint/Ch07.lean；MD.Ch07.scalarLift, MD.Ch07.symmetricHarmonicStep, MD.Ch07.symmetricInvariant, MD.Ch07.table71。

## 1. MD-7.4.1-NonsymmetricExactMoments · unnumbered_claim · 印刷p.277 / PDFp.298

### 2. 原文陈述

For example, analysis shows that the schemes denoted $[AOAB]$ or $[BAOA]$ both exhibit a first order error in the covariance $\langle qp\rangle_h=O(h)$, however they give exact results for both $\langle q^2\rangle_h$ and $\langle p^2\rangle_h$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.nonsymmetricHarmonicStep, MD.Ch07.nonsymmetricExactMoments | 两个非对称算法精确位置/动量二阶矩；协方差阶数暂缺。 |

[EXTRA] AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。；本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要真实平稳矩输运及代数求解；不建立通用弱误差理论。
位置：Blueprint/Ch07.lean；MD.Ch07.nonsymmetricHarmonicStep, MD.Ch07.nonsymmetricExactMoments。

## 1. MD-7.4.2-BBKStar · Example 7.2 · 印刷p.277–278 / PDFp.298–299

### 2. 原文陈述

Example 7.2 Consider the variant of the BBK integrator that recycles the random number between steps:
Brünger-Brooks-Karplus with post-step re-use of random number (BBK*)
\[p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,\]
\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad
p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_{n+1}]/(1+h\gamma/2),\]
where $R_n$ is a vector of normal random numbers with zero mean and unit variance.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bbkStarTrajectory, MD.Ch07.bbkStarNoise | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.bbkStarTrajectory, MD.Ch07.bbkStarNoise。

## 1. MD-7.4.2-BBKStarCorrelations · unnumbered_claim · 印刷p.278 / PDFp.299

### 2. 原文陈述

Denoting the entries of $\Psi^{\rm BBK*}$ by $\psi_{ij}$ we have
\[\mathbb E(\mu_{n,2}p_n)=\mathbb E((\kappa_2R_n+\kappa_3R_{n+1})(\psi_{21}q_{n-1}+\psi_{22}p_{n-1}+\kappa_2R_{n-1}+\kappa_3R_n))=\kappa_2\kappa_3.\]
Additionally it is easily shown that
\[\mathbb E(\mu_{n,1}q_n)=\mathbb E(\mu_{n,2}q_n)=0,\quad \mathbb E(\mu_{n,1}p_n)=\kappa_1\kappa_3,\]
with $\mathbb E(\mu_{n,1}^2)=\kappa_1^2$, $\mathbb E(\mu_{n,1}\mu_{n,2})=\kappa_1\kappa_2$, $\mathbb E(\mu_{n,2}^2)=\kappa_2^2+\kappa_3^2$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem bbkStarCorrelations (P : Measure Ω) [IsProbabilityMeasure P]
    (R S Qold Pold : Ω → ℝ) (a b c d κ1 κ2 κ3 : ℝ)
    (hR : HasLaw R (gaussianReal 0 1) P) (hS : HasLaw S (gaussianReal 0 1) P)
    (hind : IndepFun (fun sample ↦ (Qold sample,Pold sample)) (fun sample ↦ (R sample,S sample)) P)
    (hRS : IndepFun R S P) (hq : MemLp Qold 2 P) (hp : MemLp Pold 2 P) :
    let q := fun sample ↦ a*Qold sample+b*Pold sample
    let p := fun sample ↦ c*Qold sample+d*Pold sample+κ3*R sample
    let u := fun sample ↦ κ1*R sample
    let v := fun sample ↦ κ2*R sample+κ3*S sample
    (∫ sample, v sample*p sample ∂P) = κ2*κ3 ∧
    (∫ sample, u sample*q sample ∂P) = 0 ∧
    (∫ sample, v sample*q sample ∂P) = 0 ∧
    (∫ sample, u sample*p sample ∂P) = κ1*κ3 ∧
    (∫ sample, (u sample)^2 ∂P) = κ1^2 ∧
    (∫ sample, u sample*v sample ∂P) = κ1*κ2 ∧
    (∫ sample, (v sample)^2 ∂P) = κ2^2+κ3^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bbkStarCorrelations | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] Qold/Pold代表吸收R_{n-1}后仍独立于未来R_n,R_{n+1}的旧状态组合；不把当前p与R_n假设独立。；所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要实际独立随机变量的乘积积分和Gaussian矩展开；不建设历史扩展Markov链理论。
位置：Blueprint/Ch07.lean；MD.Ch07.bbkStarCorrelations。

## 1. MD-7.4.2-BBKStarMomentSystemPrinted · definition · 印刷p.278–279 / PDFp.299–300

### 2. 原文陈述

Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives
\[Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+2\psi_{12}\kappa_1 2\psi_{12}\kappa_1\kappa_3+\kappa_1^2,\]
\[P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+2\psi_{22}\kappa_2 2\psi_{22}\kappa_2\kappa_3+\kappa_2^2+\kappa_3^2,\]
\[C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\kappa_1\kappa_2+\psi_{12}\kappa_2\kappa_3+\psi_{22}\kappa_1\kappa_3.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bbkStarMomentSystemPrinted, MD.Ch07.bbkStarMomentSystemPrinted_corrected, MD.Ch07.bbkStarExtraFactor_counterexample | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.bbkStarMomentSystemPrinted, MD.Ch07.bbkStarMomentSystemPrinted_corrected, MD.Ch07.bbkStarExtraFactor_counterexample。

## 1. MD-7.4.2-BBKStarStationary · unnumbered_claim · 印刷p.279 / PDFp.300

### 2. 原文陈述

Finally, solving the simultaneous equations gives the stationary observed averages as
\[\langle q^2\rangle_h^{\rm BBK*}=\frac{k_BT}{\Omega^2}(1-\frac{\Omega^2h^2}{4m})^{-1},\qquad
\langle p^2\rangle_h^{\rm BBK*}=k_BTm(1+\frac{\gamma h}2)^{-1},\qquad
\langle qp\rangle_h^{\rm BBK*}=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.bbkStarStationaryAlgebra | 给定正确矩方程的代数求解及全部三矩值；未证明BBK*长期收敛。 |

[EXTRA] 只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：含平方根的非退化线性系统求解超过本轮短证明；保留未证。
位置：Blueprint/Ch07.lean；MD.Ch07.bbkStarStationaryAlgebra。

## 1. MD-7.5-PerturbedHamiltonian · (7.13) · 印刷p.279 / PDFp.300

### 2. 原文陈述

We consider sampling canonically the Hamiltonian
\[H(q,p)=p^2/2+q^2/2+\epsilon q^4/4,\tag{7.13}\]
using Langevin dynamics, where $q,p\in\mathbb R$, with a small nonlinearity parameter $\epsilon>0$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def perturbedPotential (ε q : ℝ) : ℝ := q^2/2+ε*q^4/4
def perturbedHamiltonian (ε : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/2+perturbedPotential ε x.1
def perturbedGibbs (ε : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-perturbedHamiltonian ε x)
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def perturbedStep (s : Fin 4) (ε γ h R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let m : V 1 := fun _ ↦ 1
  let U : V 1 → ℝ := fun q ↦ perturbedPotential ε (q 0)
  scalarLift (if s = 0 then aboba m U γ 1 h (fun _ ↦ R)
    else if s = 1 then baoab m U γ 1 h (fun _ ↦ R)
    else if s = 2 then obabo m U γ 1 h (fun _ ↦ R) (fun _ ↦ S)
    else oabao m U γ 1 h (fun _ ↦ R) (fun _ ↦ S))
def perturbedStationary (s : Fin 4) (ε γ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ perturbedStep s ε γ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.perturbedPotential, MD.Ch07.perturbedHamiltonian, MD.Ch07.perturbedGibbs, MD.Ch07.perturbedStep, MD.Ch07.perturbedStationary | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。；分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.perturbedPotential, MD.Ch07.perturbedHamiltonian, MD.Ch07.perturbedGibbs, MD.Ch07.perturbedStep, MD.Ch07.perturbedStationary。

## 1. MD-7.5-PerturbedErrorExpansion · (7.14) · 印刷p.280 / PDFp.301

### 2. 原文陈述

We find that truncating the update equations to $O(\epsilon^3)$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:
\[\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle=\frac{3h^2\epsilon[48\epsilon-4+3\gamma^2(9\epsilon-1)]}{12\gamma^2+16}+O(\epsilon h^4+\epsilon^3h^2),\]
\[\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle=-\frac{9h^2\epsilon^2}{6\gamma^2+8}-\frac{3h^4\epsilon^2[6\gamma^4+19\gamma^2+16]}{8(3\gamma^2+4)^2}+O(\epsilon^2h^6+\epsilon^3h^2),\]
\[\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle=h^2\left(\frac14+\frac{\epsilon[144\epsilon+81\epsilon\gamma^2-9\gamma^2-12]}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2),\]
\[\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle=-h^2\left(\frac14+\frac{18\epsilon^2}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2).\tag{7.14}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def perturbedLeading (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then 3*h^2*ε*(48*ε-4+3*γ^2*(9*ε-1))/(12*γ^2+16)
  else if s = 1 then -9*h^2*ε^2/(6*γ^2+8)-3*h^4*ε^2*(6*γ^4+19*γ^2+16)/(8*(3*γ^2+4)^2)
  else if s = 2 then h^2*(1/4+ε*(144*ε+81*ε*γ^2-9*γ^2-12)/(12*γ^2+16))
  else -h^2*(1/4+18*ε^2/(12*γ^2+16))
def perturbedRemainder (s : Fin 4) (ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^4+ε^3*h^2
  else if s = 1 then ε^2*h^6+ε^3*h^2 else h^4+ε^3*h^2
def positivePairLimit : Filter (ℝ × ℝ) :=
  𝓝[Set.Ioi (0 : ℝ) ×ˢ Set.Ioi (0 : ℝ)] (0,0)
theorem perturbedErrorExpansion (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)-perturbedLeading s γ z.1 z.2)
      (fun z ↦ perturbedRemainder s z.1 z.2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.perturbedLeading, MD.Ch07.perturbedRemainder, MD.Ch07.positivePairLimit, MD.Ch07.perturbedErrorExpansion | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。；实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要非线性平稳矩层级截断及一致余项控制的大型理论；本轮不建设。
位置：Blueprint/Ch07.lean；MD.Ch07.perturbedLeading, MD.Ch07.perturbedRemainder, MD.Ch07.positivePairLimit, MD.Ch07.perturbedErrorExpansion。

## 1. MD-7.5-PerturbedErrorOrders · (7.15) · 印刷p.280 / PDFp.301

### 2. 原文陈述

The behavior of the methods can thus be summarized as
\[|\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle|=O(\epsilon h^2),\qquad
|\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle|=O\left(\frac{\epsilon^2h^2}{1+\gamma^2}+\epsilon^2h^4\right),\]
\[|\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle|=O(h^2),\qquad
|\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle|=O(h^2).\tag{7.15}\]
The twofold surprising result though, is that (a) the leading error of the $[BAOAB]$ scheme has behavior proportional to $\epsilon^2$, while (b) the leading order term of the $[BAOAB]$ scheme is annihilated for large $\gamma$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def perturbedErrorScale (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^2 else if s = 1 then ε^2*h^2/(1+γ^2)+ε^2*h^4 else h^2
theorem perturbedErrorOrders (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ |momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)|)
      (fun z ↦ perturbedErrorScale s γ z.1 z.2) := by
  sorry
theorem baoabLeading_largeFriction (ε h : ℝ) :
    Filter.Tendsto (fun γ : ℝ ↦ -9*h^2*ε^2/(6*γ^2+8)) Filter.atTop (𝓝 0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.perturbedErrorScale, MD.Ch07.perturbedErrorOrders, MD.Ch07.baoabLeading_largeFriction | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 双参数正向极限已明确；γ固定的常数不等于γ一致误差界。原书(7.14)的ε³h²余项不足以单独推出BAOAB的ε²h²+ε²h⁴界，需要额外结构；保留为待证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：首项衰减需有理函数极限短桥；四个误差阶需要非线性平稳弱误差与一致余项理论。
位置：Blueprint/Ch07.lean；MD.Ch07.perturbedErrorScale, MD.Ch07.perturbedErrorOrders, MD.Ch07.baoabLeading_largeFriction。

## 1. MD-7.6-GibbsComposition · unnumbered_claim · 印刷p.282 / PDFp.303

### 2. 原文陈述

The flows of each of these systems individually preserves the Gibbs distribution: denoting the Fokker-Planck operators associated to these flows by $\mathcal L_H^\dagger$ and $\mathcal L_O^\dagger$ we have
\[\mathcal L_H^\dagger\rho_\beta=0,\qquad\mathcal L_O^\dagger\rho_\beta=0,\]
and hence
\[\exp(t\mathcal L_H^\dagger)\rho_\beta=\exp(t\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.\]
For a scheme $[HO]$, we have
\[\exp(h\mathcal L_O^\dagger)[\exp(h\mathcal L_H^\dagger)\rho_\beta]=\exp(h\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.gibbsComposition | 传播子共同固定点的组合推论；前两条生成元及半群识别未新增证明。 |

[EXTRA] 只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.gibbsComposition。

## 1. MD-7.6-DivergenceFreeInvariant · unnumbered_claim · 印刷p.282 / PDFp.303

### 2. 原文陈述

Given any divergence free vector field $f$, we have
\[-\nabla\cdot(f\rho)=-f\cdot\nabla\rho,\]
thus $\mathcal L_f^\dagger\rho=-\mathcal L_f\rho$.
If $\mathcal L_f$ preserves a first integral $I$, then $\mathcal L_f$ preserves any distribution which is a function of $I$. It follows that any energy-preserving, divergence free vector field will always preserve the Gibbs distribution.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lieField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  (fderiv ℝ ρ x) (f x)
def divergenceField (f : V n → V n) (x : V n) : ℝ :=
  ∑ i, coordDerivative (fun y ↦ f y i) x i
def forwardField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  -∑ i, coordDerivative (fun y ↦ f y i*ρ y) x i
theorem divergenceFreeInvariant (f : V n → V n) (ρ : V n → ℝ)
    (hf : ContDiff ℝ 1 f) (hρ : ContDiff ℝ 1 ρ)
    (hdiv : ∀ x, divergenceField f x = 0) : ∀ x, forwardField f ρ x = -lieField f ρ x := by
  sorry
theorem firstIntegral_density (f : V n → V n) (I : V n → ℝ) (g : ℝ → ℝ)
    (hI : Differentiable ℝ I) (hg : Differentiable ℝ g)
    (hfirst : ∀ x, lieField f I x = 0) : ∀ x, lieField f (g ∘ I) x = 0 := by
  intro x
  rw [lieField, fderiv_comp x (hg (I x)) (hI x)]
  simp only [ContinuousLinearMap.comp_apply]
  change (fderiv ℝ g (I x)) (lieField f I x) = 0
  rw [hfirst x, map_zero]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.lieField, MD.Ch07.divergenceField, MD.Ch07.forwardField, MD.Ch07.divergenceFreeInvariant, MD.Ch07.firstIntegral_density | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。；不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：散度乘积法则与坐标导数求和需短桥；全局流测度输运另列。
位置：Blueprint/Ch07.lean；MD.Ch07.lieField, MD.Ch07.divergenceField, MD.Ch07.forwardField, MD.Ch07.divergenceFreeInvariant, MD.Ch07.firstIntegral_density。

## 1. MD-7.6-GeMarsdenRestriction · definition · 印刷p.282 / PDFp.303

### 2. 原文陈述

All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def onlyEnergyIntegrals (H : V n → ℝ) (f : V n → V n) : Prop :=
  ∀ I : V n → ℝ, ContDiff ℝ ⊤ I → (∀ x, lieField f I x = 0) →
    ∃ g : ℝ → ℝ, I = g ∘ H
def timeReparametrizes {E : Type*} (G flow : ℝ → E → E) : Prop :=
  ∃ τ : ℝ → E → ℝ, ∀ h x, G h x = flow (τ h x) x
def geMarsdenConclusion {k : ℕ}
    (H : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (G flow : ℝ → MolecularDynamics.SymplecticCoordinates k → MolecularDynamics.SymplecticCoordinates k) : Prop :=
  MolecularDynamics.Chapter02Review.symplecticIntegrator G →
  (∀ h x, H (G h x) = H x) → timeReparametrizes G flow
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.onlyEnergyIntegrals, MD.Ch07.timeReparametrizes, MD.Ch07.geMarsdenConclusion | 原文数学主张已登记；Lean给出结论形式和第一积分资格，尚缺可核定的完整定理前提与定理陈述。 |

[EXTRA] 原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。；辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.onlyEnergyIntegrals, MD.Ch07.timeReparametrizes, MD.Ch07.geMarsdenConclusion。

## 1. MD-7.6-JSplitting · unnumbered_claim · 印刷p.282–283 / PDFp.303–304

### 2. 原文陈述

Let $J$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $J$ into a finite number $K$ of skew-symmetric matrices $J_i$, $i=1,\ldots,K$. This induces a splitting of the Hamiltonian vector field into $K$ vector fields $f_i=J_i\nabla H$. Each of these vector fields preserves $H$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.jField, MD.Ch07.jSplitting_energy, MD.Ch07.composition_preservesEnergy | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。；体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：反对称二次型为零、混合偏导对称与坐标散度的短桥；全局流体积保持另列。
位置：Blueprint/Ch07.lean；MD.Ch07.jField, MD.Ch07.jSplitting_energy, MD.Ch07.composition_preservesEnergy。

## 1. MD-7.6-CoordinateJSplitting · definition · 印刷p.283 / PDFp.304

### 2. 原文陈述

As an example of such a $J$-splitting, we may take $K=N_c$ with each $J_i$ to be defined by the components of the canonical symplectic structure matrix having to do with the $i$th position and momentum pair, thus the equations of motion for the $i$th vector field become
\[\dot q_i=p_i/m_i,\qquad \dot p_i=-\frac{\partial U}{\partial q_i}(\bar q_1,\ldots,\bar q_{i-1},q_i,\bar q_{i+1},\ldots,\bar q_{N_c}),\]
where components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.coordinateJField, MD.Ch07.frozenPotential | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.coordinateJField, MD.Ch07.frozenPotential。

## 1. MD-7.7-ModifiedGenerator · (7.16) · 印刷p.284 / PDFp.305

### 2. 原文陈述

We begin by defining the generator $\widehat{\mathcal L}$ associated to the propagation of averages under the numerical method for an SDE. We think of this generator as a perturbation of the exact Langevin dynamics generator $\mathcal L_{LD}$, or
\[\widehat{\mathcal L}=\mathcal L_{LD}+h\mathcal L_1+h^2\mathcal L_2+h^3\mathcal L_3+O(h^4).\tag{7.16}\]
However, the operators involved are not equivalent to the operators that would arise from any stochastic differential equation (see [403]), so we must give up the direct analogy between the formal series and continuous SDE models (which is available in the deterministic setting).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def formalModifiedGenerator {R : Type*} [Ring R] [Algebra ℝ R]
    (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun k ↦ PowerSeries.coeff (k+1) (MolecularDynamics.textbookFormalOperatorLogarithm S))
def formalGeneratorExpansion {R : Type*} [Ring R] [Algebra ℝ R]
    (L : PowerSeries R) (L0 L1 L2 L3 : R) : Prop :=
  PowerSeries.coeff 0 L = L0 ∧ PowerSeries.coeff 1 L = L1 ∧
  PowerSeries.coeff 2 L = L2 ∧ PowerSeries.coeff 3 L = L3
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.formalModifiedGenerator, MD.Ch07.formalGeneratorExpansion | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 只取形式幂级数系数；O(h⁴)在此意为0–3阶系数相等，不宣称无界算符级数收敛，也不声称是另一SDE的生成元。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.formalModifiedGenerator, MD.Ch07.formalGeneratorExpansion。

## 1. MD-7.7-InvariantDensityExpansion · (7.17) · 印刷p.284 / PDFp.305

### 2. 原文陈述

We write this invariant distribution as a perturbation of the (target) canonical distribution
\[\widehat\rho=\rho_\beta[1+hf_1+h^2f_2+h^3f_3+O(h^4)],\tag{7.17}\]
with each correction function $f_k(q,p)$ satisfying
\[\int_{\mathcal D} f_k(q,p)\rho_\beta(q,p)d\omega=0,\]
ensuring a useful equivalence in the partition function
\[\int_{\mathcal D}\widehat\rho(q,p)d\omega=\int_{\mathcal D}\rho_\beta(q,p)d\omega.\]
Our computed average is therefore $\langle\phi\rangle_h\stackrel{\rm def}=\int_{\mathcal D}\phi(q,p)\widehat\rho(q,p)d\omega$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def densityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => ρ
  | k+1 => fun x ↦ ρ x*f (k+1) x
def centeredCorrections (μ : Measure Ω) (f : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ k, 0 < k → Integrable (f k) μ ∧ (∫ x, f k x ∂μ) = 0
def computedAverage (ν : Measure Ω) (φ ρhat : Ω → ℝ) : ℝ := ∫ x, φ x*ρhat x ∂ν
theorem densityExpansion_zeroMass (ν : Measure Ω) (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ)
    (hρ : Integrable ρ ν)
    (hf : ∀ k, 0 < k → Integrable (fun x ↦ ρ x*f k x) ν ∧ (∫ x, ρ x*f k x ∂ν) = 0) :
    ∀ k, (∫ x, densityExpansion ρ f k x ∂ν) = if k = 0 then ∫ x, ρ x ∂ν else 0 := by
  intro k
  cases k with
  | zero => simp [densityExpansion]
  | succ k => simpa [densityExpansion] using (hf (k+1) (Nat.zero_lt_succ k)).2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.densityExpansion, MD.Ch07.centeredCorrections, MD.Ch07.computedAverage, MD.Ch07.densityExpansion_zeroMass | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 系数零质量不等于任意h的截断密度非负；概率密度仍须非负、可积且归一。余项质量也为零或完整级数可交换积分时才推出精确总质量一致。；此处证明所有形式系数的质量约束；未把有限截断表达式假称实际不变概率。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.densityExpansion, MD.Ch07.centeredCorrections, MD.Ch07.computedAverage, MD.Ch07.densityExpansion_zeroMass。

## 1. MD-7.7.1-ExactABOPropagators · definition · 印刷p.285 / PDFp.306

### 2. 原文陈述

\[(e^{t\mathcal L_A}\phi)(q,p)=\phi(q+tM^{-1}p,p),\qquad
(e^{t\mathcal L_B}\phi)(q,p)=\phi(q,p-t\nabla U(q)),\]
\[(e^{t\mathcal L_O}\phi)(q,p)=\int_{\mathcal P}\phi(q,e^{-\gamma t}p+\zeta M^{1/2}x)\frac{e^{-|x|^2/2}}{(2\pi)^{N_c/2}}dx,\]
where $\zeta=[k_BT(1-e^{-2\gamma t})]^{1/2}$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.propagateA, MD.Ch07.propagateB, MD.Ch07.propagateO | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。；半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.propagateA, MD.Ch07.propagateB, MD.Ch07.propagateO。

## 1. MD-7.7.1-OperatorOrderReversal · unnumbered_claim · 印刷p.285 / PDFp.306

### 2. 原文陈述

For example, for the method labelled by the string $[ABAO]$, we have
\[\exp(h\widehat{\mathcal L}_{[ABAO]})=\exp((h/2)\mathcal L_A)\exp(h\mathcal L_B)\exp((h/2)\mathcal L_A)\exp(h\mathcal L_O),\]
where importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $\widehat{\mathcal L}^\dagger$, which we may compute as
\[\exp(h\widehat{\mathcal L}_{[ABAO]}^\dagger)=\exp(h\mathcal L_O^\dagger)\exp((h/2)\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp((h/2)\mathcal L_A^\dagger).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.pullback_order, MD.Ch07.abaoBackward | 确定性拉回顺序及ABAO后向传播定义；无界算符指数/伴随识别尚缺。 |

[EXTRA] 覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。；伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.pullback_order, MD.Ch07.abaoBackward。

## 1. MD-7.7.1-StationaryModifiedPDE · definition · 印刷p.285–286 / PDFp.306–307

### 2. 原文陈述

Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $\rho$ is given by
\[\frac\partial{\partial t}\rho(z,t)=\widehat{\mathcal L}^\dagger\rho,\]
with the important case of its invariant distribution satisfying the partial differential equation
\[\widehat{\mathcal L}^\dagger\widehat\rho=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.formalDensityEvolution, MD.Ch07.stationaryModifiedDensity | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。；Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.formalDensityEvolution, MD.Ch07.stationaryModifiedDensity。

## 1. MD-7.7.1-TwoOperatorBCH · unnumbered_claim · 印刷p.286 / PDFp.307

### 2. 原文陈述

Recall that for linear operators $X$ and $Y$, we can write the composition of their exponentials as
\[\exp(hX)\exp(hY)=\exp(hZ),\]
where we have the expansion
\[Z=X+Y+\frac h2[X,Y]+\frac{h^2}{12}([X,[X,Y]]+[Y,[Y,X]])+O(h^3).\]
The notation $[X,Y]\stackrel{\rm def}=XY-YX$ represents the commutator of the operators $X$ and $Y$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def comm {R : Type*} [Ring R] (X Y : R) : R := X*Y-Y*X
def twoStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential X * MolecularDynamics.textbookFormalOperatorExponential Y
theorem twoOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (twoStage X Y)) = X+Y ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (twoStage X Y)) = (1/2 : ℝ) • comm X Y ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (twoStage X Y)) =
      (1/12 : ℝ) • (comm X (comm X Y)+comm Y (comm Y X)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.comm, MD.Ch07.twoStage, MD.Ch07.twoOperatorBCH | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：已有log与exp低阶系数，但非交换乘积展开到三阶的桥接仍未证明；不建立一般BCH理论。
位置：Blueprint/Ch07.lean；MD.Ch07.comm, MD.Ch07.twoStage, MD.Ch07.twoOperatorBCH。

## 1. MD-7.7.1-TaylorRemainder · unnumbered_claim · 印刷p.286–287 / PDFp.307–308

### 2. 原文陈述

We can make use of Taylor’s theorem to write the identity
\[P_h=P_0+h\left.\frac{dP_t}{dt}\right|_{t=0}+\cdots+\frac{h^n}{n!}\left.\frac{d^nP_t}{dt^n}\right|_{t=0}
+\frac{h^{n+1}}{n!}\int_0^1(1-\lambda)^n\left.\frac{d^{n+1}P_t}{dt^{n+1}}\right|_{t=\lambda h}d\lambda,\]
for some finite truncation index $n\in\{1,2,3,\ldots\}$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.taylorRemainder, MD.Ch07.taylorRemainder_bound | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要Mathlib实函数Taylor积分余项桥；不建立通用弱误差展开。
位置：Blueprint/Ch07.lean；MD.Ch07.taylorRemainder, MD.Ch07.taylorRemainder_bound。

## 1. MD-7.7.2-ThreeOperatorBCH · (7.18) · 印刷p.287 / PDFp.308

### 2. 原文陈述

\[\exp(hS)=\exp(hZ)\exp(hY)\exp(hX).\tag{7.18}\]
\[S=X+Y+Z+\frac h2([Z,Y]+[Z,X]+[Y,X])+\frac{h^2}{4}[Z,Y,X]
+\frac{h^2}{12}([Y,Y,X]+[X,X,Y]+[Z,Z,Y]+[Z,Z,X]+[Y+X,Y+X,Z])+\cdots\]
where the notation $[A,B,C]$ is notation for $[A,[B,C]]$.

### 3. 原文证明

Apply the two-operator BCH formula first to exp(hY)exp(hX), and then to exp(hZ)exp(h(Y+X+...)); combine equal powers of h.

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def threeStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential Z *
    MolecularDynamics.textbookFormalOperatorExponential Y * MolecularDynamics.textbookFormalOperatorExponential X
theorem threeOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (threeStage X Y Z)) = X+Y+Z ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/2 : ℝ) • (comm Z Y+comm Z X+comm Y X) ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/4 : ℝ) • comm Z (comm Y X)+(1/12 : ℝ) •
        (comm Y (comm Y X)+comm X (comm X Y)+comm Z (comm Z Y)+
          comm Z (comm Z X)+comm (Y+X) (comm (Y+X) Z)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.threeStage, MD.Ch07.threeOperatorBCH | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需三重形式指数乘积的低阶log系数展开；不建设无界算符BCH收敛理论。
位置：Blueprint/Ch07.lean；MD.Ch07.threeStage, MD.Ch07.threeOperatorBCH。

## 1. MD-7.7.2-ScalarForwardOperators · definition · 印刷p.288 / PDFp.309

### 2. 原文陈述

In this one dimensional example, we substitute
\[Z=\mathcal L_A^\dagger=-p\frac\partial{\partial q},\quad Y=\mathcal L_B^\dagger=U'(q)\frac\partial{\partial p},\quad
X=\mathcal L_O^\dagger=\gamma\left({\rm Id}+p\frac\partial{\partial p}\right)+\frac{\sigma^2}{2}\frac{\partial^2}{\partial p^2},\]
where $\sigma=\sqrt{2\gamma k_BT}$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev Density1 := (ℝ × ℝ) → ℝ
def dq (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun q ↦ f (q,x.2)) x.1
def dp (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun p ↦ f (x.1,p)) x.2
def opA (f : Density1) (x : ℝ × ℝ) : ℝ := -x.2*dq f x
def opB (U : ℝ → ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := deriv U x.1*dp f x
def opO (γ θ : ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := γ*(f x+x.2*dp f x)+γ*θ*dp (dp f) x
def opLD (U : ℝ → ℝ) (γ θ : ℝ) (f : Density1) : Density1 := opA f+opB U f+opO γ θ f
def opComm (A B : Density1 → Density1) (f : Density1) : Density1 := A (B f)-B (A f)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.Density1, MD.Ch07.dq, MD.Ch07.dp, MD.Ch07.opA, MD.Ch07.opB, MD.Ch07.opO, MD.Ch07.opLD, MD.Ch07.opComm | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 所有偏导都是实际deriv，单位质量、θ=k_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.Density1, MD.Ch07.dq, MD.Ch07.dp, MD.Ch07.opA, MD.Ch07.opB, MD.Ch07.opO, MD.Ch07.opLD, MD.Ch07.opComm。

## 1. MD-7.7.2-CommutatorAB · unnumbered_claim · 印刷p.288 / PDFp.309

### 2. 原文陈述

\[[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-p\frac\partial{\partial q}\left(U'(q)\frac{\partial\rho}{\partial p}\right)-U'(q)\frac\partial{\partial p}\left(-p\frac{\partial\rho}{\partial q}\right)
=-pU''(q)\rho_p-pU'(q)\rho_{pq}+U'(q)\rho_q+U'(q)p\rho_{qp}.\]
As this is the commutator of two 1st order differential operators, the mixed partial term vanishes, leaving
\[[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-pU''(q)\rho_p+U'(q)\rho_q.\]

### 3. 原文证明

Expand both product derivatives and cancel the mixed partials using equality of mixed partials.

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.commutatorAB | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 本条没有另加数学前提。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需实二变量偏导乘积与混合偏导交换的短桥；不重建一般微分算符理论。
位置：Blueprint/Ch07.lean；MD.Ch07.commutatorAB。

## 1. MD-7.7.2-CommutatorsAOBO · unnumbered_claim · 印刷p.289 / PDFp.310

### 2. 原文陈述

Similar computations give
\[[\mathcal L_A^\dagger,\mathcal L_O^\dagger]\rho=\gamma p\rho_q+\sigma^2\rho_{qp},\qquad
[\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho=\gamma U'(q)\rho_p.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.commutatorsAOBO | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 本条没有另加数学前提。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需三阶偏导乘积展开与交换桥接；最多短路线，不建大型算符理论。
位置：Blueprint/Ch07.lean；MD.Ch07.commutatorsAOBO。

## 1. MD-7.7.2-OBAModifiedOperator · unnumbered_claim · 印刷p.288–289 / PDFp.309–310

### 2. 原文陈述

\[\exp(h\widehat{\mathcal L}_{[OBA]}^\dagger)=\exp(h\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp(h\mathcal L_O^\dagger).\]
\[\widehat{\mathcal L}_{[OBA]}^\dagger\rho=\mathcal L_{LD}^\dagger\rho+\frac h2[-pU''(q)\rho_p+U'(q)\rho_q+\gamma p\rho_q+\sigma^2\rho_{qp}+\gamma U'(q)\rho_p]+O(h^2).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.obaFirstCorrection, MD.Ch07.obaFirstCorrection_commutators | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.obaFirstCorrection, MD.Ch07.obaFirstCorrection_commutators。

## 1. MD-7.7.2-SpectralQualification · definition · 印刷p.289 / PDFp.310

### 2. 原文陈述

The assumption of validity becomes more credible as we find that the operator $\mathcal L_{LD}^\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\rho_\beta$ and all the remaining eigenvalues lie in the negative half plane.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.simpleEigenvalue, MD.Ch07.printedSpectralConclusion | 原文谱断言已登记，Lean定义其点谱目标；尚缺无界算符对象和完整限定定理。 |

[EXTRA] 只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.simpleEigenvalue, MD.Ch07.printedSpectralConclusion。

## 1. MD-7.7.3-PerturbationCoefficientEquation · (7.19) · 印刷p.289–290 / PDFp.310–311

### 2. 原文陈述

Inserting this ansatz into the stationary Fokker-Planck equation $\widehat{\mathcal L}^\dagger\widehat\rho=0$, we obtain
\[(\mathcal L_{LD}^\dagger+h\mathcal L_1^\dagger+h^2\mathcal L_2^\dagger+O(h^3))(\rho_\beta[1+hf_1+h^2f_2+O(h^3)])=0.\]
Combining like powers, we have at zero’th order, the equation $\mathcal L_{LD}^\dagger\rho_\beta=0$.
At first order we obtain
\[\mathcal L_{LD}^\dagger(\rho_\beta f_1)+\mathcal L_1^\dagger\rho_\beta=0.\tag{7.19}\]

### 3. 原文证明

Insert the two formal series into the stationary equation and combine like powers of h.

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def actionCoefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E) (k : ℕ) : E :=
  ∑ j ∈ Finset.range (k+1), L j (ρ (k-j))
theorem perturbationCoefficientEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (h0 : actionCoefficient L ρ 0 = 0) (h1 : actionCoefficient L ρ 1 = 0) :
    L 0 (ρ 0) = 0 ∧ L 0 (ρ 1)+L 1 (ρ 0) = 0 := by
  constructor
  · simpa [actionCoefficient] using h0
  · simpa [actionCoefficient, Finset.sum_range_succ] using h1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.actionCoefficient, MD.Ch07.perturbationCoefficientEquation | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 在真实线性作用的形式系数卷积上推导0阶和1阶必要方程；并未由这些必要方程证明原离散链存在不变分布。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.actionCoefficient, MD.Ch07.perturbationCoefficientEquation。

## 1. MD-7.7.3-ObservableCorrectionExpansion · unnumbered_claim · 印刷p.290 / PDFp.311

### 2. 原文陈述

For some observable $\vartheta(q,p)$, we have that
\[\langle\vartheta\rangle_h=\int_{\mathcal D}\vartheta(q,p)\widehat\rho(q,p)d\omega
=\int_{\mathcal D}\vartheta(q,p)\rho_\beta(q,p)(1+hf_1(q,p)+h^2f_2(q,p)+\cdots)d\omega
=\langle\vartheta\rangle+h\langle\vartheta f_1\rangle+h^2\langle\vartheta f_2\rangle+\cdots.\]

### 3. 原文证明

Distribute the product and use linearity of integration at each finite order.

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem observableCorrectionExpansion (ν : Measure Ω) (φ ρ f1 f2 : Ω → ℝ) (h : ℝ)
    (h0 : Integrable (fun x ↦ φ x*ρ x) ν)
    (h1 : Integrable (fun x ↦ φ x*ρ x*f1 x) ν)
    (h2 : Integrable (fun x ↦ φ x*ρ x*f2 x) ν) :
    (∫ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) ∂ν) =
      (∫ x, φ x*ρ x ∂ν)+h*(∫ x, φ x*ρ x*f1 x ∂ν)+h^2*(∫ x, φ x*ρ x*f2 x ∂ν) := by
  have heq : ∀ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) =
      (φ x*ρ x+h*(φ x*ρ x*f1 x))+h^2*(φ x*ρ x*f2 x) := by intro x; ring
  simp_rw [heq]
  have hout := integral_add (h0.add (h1.const_mul h)) (h2.const_mul (h^2))
  have hin := integral_add h0 (h1.const_mul h)
  simp only [Pi.add_apply] at hout hin
  rw [hout, hin, integral_const_mul, integral_const_mul]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.observableCorrectionExpansion | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整覆盖0–2阶有限截断积分；无限级数交换与实际误差余项仍需支配收敛及弱展开理论，明确不声称已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.observableCorrectionExpansion。

## 1. MD-7.7.3-PerturbativeSolvabilityCaution · definition · 印刷p.290 / PDFp.311

### 2. 原文陈述

It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $\mathcal L_{LD}^\dagger$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def correctionSolvable {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (rhs : E) : Prop := ∃ u : E, L u = rhs
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.correctionSolvable | 可解性目标与原书未证明的预期已登记；指数稳定和全局半群存在不作为已获定理。 |

[EXTRA] 原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。；不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.correctionSolvable。

## 1. MD-7.8-FirstOrderOperator · (7.20)–(7.21) · 印刷p.291 / PDFp.312

### 2. 原文陈述

By composing the semigroup operators
\[\exp(h\widehat{\mathcal L}_{[XYZ]}^\dagger)=\exp(h\mathcal L_Z^\dagger)\exp(h\mathcal L_Y^\dagger)\exp(h\mathcal L_X^\dagger),\]
and computing the terms in the BCH expansion, we have
\[\widehat{\mathcal L}_{[XYZ]}^\dagger=\mathcal L_{LD}^\dagger+h\mathcal L_{1,[XYZ]}^\dagger+O(h^2),\]
where
\[\mathcal L_{1,[XYZ]}^\dagger=-\frac12([\mathcal L_X^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_X^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]).\tag{7.20}\]
The first order correction function for this scheme is then given by the particular solution to the PDE,
\[\mathcal L_{LD}^\dagger(f_{1,[XYZ]}\rho_\beta)=-\mathcal L_{1,[XYZ]}^\dagger\rho_\beta.\tag{7.21}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def firstOrderOperator {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : R :=
  (-1/2 : ℝ) • (comm X Y+comm X Z+comm Y Z)
theorem firstOrderOperator_coefficient {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) = firstOrderOperator X Y Z := by
  sorry
def correctionEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L L1 : Module.End ℝ E) (ρ ρf : E) : Prop := L ρf = -L1 ρ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.firstOrderOperator, MD.Ch07.firstOrderOperator_coefficient, MD.Ch07.correctionEquation | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 前向组合采用Z,Y,X顺序；正式级数系数推论覆盖所有六个排列，L0为三者和。修正方程为必要形式方程，可解性独立。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：直接系数归约的短路线超过时间盒；保留未证。
位置：Blueprint/Ch07.lean；MD.Ch07.firstOrderOperator, MD.Ch07.firstOrderOperator_coefficient, MD.Ch07.correctionEquation。

## 1. MD-7.8-HomogeneousNormalization · unnumbered_claim · 印刷p.291 / PDFp.312

### 2. 原文陈述

The general solution of (7.21) will consist of the sum of the homogeneous solution $f_{1,[XYZ]}^{[HS]}(q,p)$ and particular solution $f_{1,[XYZ]}^{[PS]}(q,p)$ in the usual way. However, since $\mathcal L_{LD}^\dagger\vartheta=0$ has as its only solution $\vartheta\propto\rho_\beta$, the homogeneous solution of (7.21) is $f_{1,[XYZ]}^{[HS]}(q,p)=c$, for some constant $c$. Our assumption that $\langle f_{1,[XYZ]}\rangle=0$ means that $c=-\langle f_{1,[XYZ]}^{[PS]}\rangle$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem homogeneousNormalization {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ u v rhs : E)
    (hker : ∀ w, L w = 0 → ∃ c : ℝ, w = c • ρ)
    (hu : L u = rhs) (hv : L v = rhs) : ∃ c : ℝ, u = v+c • ρ := by
  obtain ⟨c,hc⟩ := hker (u-v) (by rw [map_sub,hu,hv,sub_self])
  exact ⟨c,by rw [← hc]; abel⟩
theorem centeredParticular (μ : Measure Ω) [IsProbabilityMeasure μ] (f : Ω → ℝ)
    (hf : Integrable f μ) : (∫ x, f x-(∫ y, f y ∂μ) ∂μ) = 0 := by
  rw [integral_sub hf (integrable_const _)]
  simp
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.homogeneousNormalization, MD.Ch07.centeredParticular | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 核恰为ρ的一维空间是明确前提；不把Langevin核唯一性当作已证明。第二条为实际概率归一化的中心化恒等式。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.homogeneousNormalization, MD.Ch07.centeredParticular。

## 1. MD-7.8.1-CommutatorPermutationRelations · (7.22)–(7.24) · 印刷p.292 / PDFp.313

### 2. 原文陈述

\[([\mathcal L_O^\dagger,\mathcal L_A^\dagger]+[\mathcal L_O^\dagger,\mathcal L_B^\dagger])\rho_\beta=[\mathcal L_O^\dagger,\mathcal L_A^\dagger+\mathcal L_B^\dagger]\rho_\beta=0.\]
\[\mathcal L_{1,[ABO]}^\dagger\rho_\beta=\mathcal L_{1,[OAB]}^\dagger\rho_\beta=-\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\mathcal L_{1,[BAO]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta.\tag{7.22}\]
\[f_{1,[ABO]}=f_{1,[OAB]}=-f_{1,[OBA]}=-f_{1,[BAO]}.\tag{7.23}\]
\[\mathcal L_{1,[AOB]}^\dagger\rho_\beta=-\mathcal L_{1,[BOA]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger-\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho_\beta+\mathcal L_{1,[ABO]}^\dagger\rho_\beta.\tag{7.24}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem commutatorPermutationRelations {E : Type*} [AddCommGroup E] [Module ℝ E]
    (A B O : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (A+B) ρ = 0) :
    (comm O A+comm O B) ρ = 0 ∧
    firstOrderOperator A B O ρ = firstOrderOperator O A B ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator O B A ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator B A O ρ ∧
    firstOrderOperator A B O ρ = (-1/2 : ℝ) • comm A B ρ ∧
    firstOrderOperator A O B ρ = -firstOrderOperator B O A ρ ∧
    firstOrderOperator A O B ρ = (-1/2 : ℝ) • comm (A-B) O ρ+firstOrderOperator A B O ρ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.commutatorPermutationRelations | 首式及(7.22),(7.24)全部算符作用关系；(7.23)需归一解唯一性桥，未另作Lean定理。 |

[EXTRA] 实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：线性算符非交换代数作用桥接；本轮保留未证，不建设一般弱误差理论。
位置：Blueprint/Ch07.lean；MD.Ch07.commutatorPermutationRelations。

## 1. MD-7.8.1-GibbsDerivativeIdentities · unnumbered_claim · 印刷p.292–293 / PDFp.313–314

### 2. 原文陈述

If we define the function $g(q,p)$ as $g(q,p)=\beta p^TM^{-1}\nabla U(q)$, then through simple computation we have
\[\mathcal L_A^\dagger\rho_\beta=-\mathcal L_B^\dagger\rho_\beta=g(q,p)\rho_\beta.\]
\[[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=-(\mathcal L_A^\dagger+\mathcal L_B^\dagger)(g\rho_\beta)=(\mathcal L_O^\dagger-\mathcal L_{LD}^\dagger)(g\rho_\beta).\]
For a function $\psi(q)$ purely of position, we have
\[\mathcal L_{LD}^\dagger(\psi(q)\rho_\beta)=-(p^TM^{-1}\nabla\psi(q))\rho_\beta(q,p),\]
and hence we can compute
\[\mathcal L_O^\dagger(g(q,p)\rho_\beta)=\gamma\rho_\beta(-p\cdot\nabla_pg+\beta^{-1}\nabla_p\cdot M\nabla_pg)
=-\gamma g\rho_\beta=\gamma\beta\mathcal L_{LD}^\dagger(U(q)\rho_\beta).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def mechanicalHamiltonian (m : V n) (U : V n → ℝ) (x : Phase n) : ℝ :=
  (∑ i, x.2 i^2/(2*m i))+U x.1
def gibbsWeight (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  Real.exp (-β*mechanicalHamiltonian m U x)
def gFunction (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*∑ i, x.2 i/m i*gradient U x.1 i
def phaseO (m : V n) (γ β : ℝ) (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ouForward m γ β⁻¹ (fun p ↦ ρ (x.1,p)) x.2
def phaseLD (m : V n) (U : V n → ℝ) (γ β : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  aForward m ρ+bForward U ρ+phaseO m γ β ρ
theorem gibbsDerivativeIdentities (m : V n) (U ψ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) (hψ : ContDiff ℝ ⊤ ψ) :
    let ρ := gibbsWeight m U β
    let g := gFunction m U β
    aForward m ρ = g*ρ ∧ bForward U ρ = -(g*ρ) ∧
    phaseLD m U γ β (fun x ↦ ψ x.1*ρ x) =
      (fun x ↦ -(∑ i, x.2 i/m i*gradient ψ x.1 i)*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ -γ*g x*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ γ*β*phaseLD m U γ β (fun y ↦ U y.1*ρ y) x) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.mechanicalHamiltonian, MD.Ch07.gibbsWeight, MD.Ch07.gFunction, MD.Ch07.phaseO, MD.Ch07.phaseLD, MD.Ch07.gibbsDerivativeIdentities | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] ρ为未归一Gibbs权，所有微分等式对常数归一化同样成立；实际概率还要正有限配分积分。所有质量正、β>0、光滑资格明示。；覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：实际多维Gibbs指数微分、二阶OU乘积法则与求和桥，超过短证明；不建SDE解或遍历理论。
位置：Blueprint/Ch07.lean；MD.Ch07.mechanicalHamiltonian, MD.Ch07.gibbsWeight, MD.Ch07.gFunction, MD.Ch07.phaseO, MD.Ch07.phaseLD, MD.Ch07.gibbsDerivativeIdentities。

## 1. MD-7.8.1-FirstCorrectionTablePrinted · (7.25a)–(7.25d) · 印刷p.293–294 / PDFp.314–315

### 2. 原文陈述

In summary, we find that
\[f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25a}\]
\[f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25b}\]
\[f_{1,[AOB]}(q,p)=-\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25c}\]
\[f_{1,[BOA]}(q,p)=\frac\beta2(\gamma U(q)+p^TM^{-1}\nabla U(q)-c),\tag{7.25d}\]
where the constant $c$ is chosen to ensure each correction function has average 0, giving $c=\gamma\langle U(q)\rangle$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 ∨ s = 4 then -β/2*(γ*U x.1-v-c)
  else β/2*(γ*U x.1+v-c)
def firstCorrectionTablePrinted_corrected (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  if s = 4 then -β/2*(γ*U x.1+(∑ i, x.2 i/m i*gradient U x.1 i)-c)
  else firstCorrectionTablePrinted s m U β γ c x
theorem firstCorrection_sign_counterexample :
    (-(1 : ℝ)/2*(1-1-0)) ≠ -(1 : ℝ)/2*(1+1-0) := by norm_num
def phaseComm (A B : (Phase n → ℝ) → Phase n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := A (B ρ)-B (A ρ)
def firstCorrectionRHS (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  let A := aForward m
  let B := bForward U
  let O := phaseO m γ β
  let ops := if s = 0 then (A,B,O) else if s = 1 then (O,A,B)
    else if s = 2 then (O,B,A) else if s = 3 then (B,A,O)
    else if s = 4 then (A,O,B) else (B,O,A)
  fun x ↦ (1/2)*(phaseComm ops.1 ops.2.1 ρ x+phaseComm ops.1 ops.2.2 ρ x+phaseComm ops.2.1 ops.2.2 ρ x)
theorem firstCorrectionTable_pde (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    phaseLD m U γ β (fun x ↦ firstCorrectionTablePrinted_corrected s m U β γ c x*gibbsWeight m U β x) =
      firstCorrectionRHS s m U β γ (gibbsWeight m U β) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.firstCorrectionTablePrinted, MD.Ch07.firstCorrectionTablePrinted_corrected, MD.Ch07.firstCorrection_sign_counterexample, MD.Ch07.phaseComm, MD.Ch07.firstCorrectionRHS, MD.Ch07.firstCorrectionTable_pde | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF315／印刷294：(7.25c)中动量梯度项印为负号，与同页上一段推导给出的正号及f_AOB=-f_BOA矛盾；修正为括号内正号。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：完整多维指数微分及二阶算符乘积展开需较大桥接；保留PDE未证。
位置：Blueprint/Ch07.lean；MD.Ch07.firstCorrectionTablePrinted, MD.Ch07.firstCorrectionTablePrinted_corrected, MD.Ch07.firstCorrection_sign_counterexample, MD.Ch07.phaseComm, MD.Ch07.firstCorrectionRHS, MD.Ch07.firstCorrectionTable_pde。

## 1. MD-7.8.1-PositionMomentumCorrections · unnumbered_claim · 印刷p.294–295 / PDFp.315–316

### 2. 原文陈述

If $\vartheta=\vartheta_1(p)$ then this $O(\gamma)$ term will not trouble us, as
\[\langle\vartheta_1(p)f_1(q,p)\rangle=\pm\frac\beta2\langle(\gamma U(q)-c)\vartheta_1(p)\pm p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle
=\pm\frac\beta2\langle p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle.\]
However, if we instead set $\vartheta=\vartheta_2(q)$, then
\[\langle\vartheta_2(q)f_1(q,p)\rangle=\pm\frac{\gamma\beta}{2}\langle(U(q)-\langle U(q)\rangle)\vartheta_2(q)\rangle.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def positionGibbs (U : V n → ℝ) (β : ℝ) : Measure (V n) :=
  volume.withDensity (fun q ↦ ENNReal.ofReal (Real.exp (-β*U q)/(∫ y, Real.exp (-β*U y))))
def momentumGibbs (m : V n) (β : ℝ) : Measure (V n) := Measure.pi (fun i ↦ gaussianReal 0 (Real.toNNReal (m i/β)))
def productGibbs (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  (positionGibbs U β).prod (momentumGibbs m β)
theorem positionMomentumCorrections (m : V n) (U ψ χ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hU : Integrable U (positionGibbs U β))
    (hψ : Integrable ψ (positionGibbs U β)) (hχ : Integrable χ (momentumGibbs m β))
    (hgrad : ∀ i, Integrable (fun q ↦ gradient U q i) (positionGibbs U β))
    (hint : ∀ s : Fin 6,
      Integrable (fun x ↦ ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β) ∧
      Integrable (fun x ↦ χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β)) :
    ∀ s : Fin 6, let sign : ℝ := if s = 0 ∨ s = 1 ∨ s = 5 then 1 else -1
    let vsign : ℝ := if s = 0 ∨ s = 1 ∨ s = 4 then -1 else 1
    (∫ x, ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      sign*γ*β/2*∫ q, (U q-(∫ y, U y ∂positionGibbs U β))*ψ q ∂positionGibbs U β ∧
    (∫ x, χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      vsign*β/2*∫ x, (∑ i, x.2 i/m i*gradient U x.1 i)*χ x.2 ∂productGibbs m U β := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.positionGibbs, MD.Ch07.momentumGibbs, MD.Ch07.productGibbs, MD.Ch07.positionMomentumCorrections | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 产品Gibbs实际含位置概率及独立中心Gaussian动量；所有显示期望需可积，未把待求修正值作为假设。；六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需乘积积分和Gaussian奇矩归零的多维短桥；不建设Talay–Tubaro理论。
位置：Blueprint/Ch07.lean；MD.Ch07.positionGibbs, MD.Ch07.momentumGibbs, MD.Ch07.productGibbs, MD.Ch07.positionMomentumCorrections。

## 1. MD-7.8.1-OverdampedFirstOrderCaution · unnumbered_claim · 印刷p.295 / PDFp.316

### 2. 原文陈述

When considering the limit of infinite friction in the $[XYZ]$ schemes we obtain an inconsistent discretization. Hence these first-order schemes will be unsuitable for the integration of overdamped Langevin dynamics.
This is not always the case for first order schemes, however. For example the scheme denoted $[AOAB]$ is consistent with the dynamics, and may be used for integrating the overdamped ($\gamma=\infty$) Langevin equation.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
    Filter.Tendsto (fun γ : ℝ ↦ aoab m U γ θ h R x) Filter.atTop (𝓝 (aoabInfiniteFriction m U θ h R x)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.aoab, MD.Ch07.aoabInfiniteFriction, MD.Ch07.aoabFrictionLimit | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：OU指数衰减、sqrt连续及∇U连续的有限维极限短桥；过阻尼时间重标度理论不新建。
位置：Blueprint/Ch07.lean；MD.Ch07.aoab, MD.Ch07.aoabInfiniteFriction, MD.Ch07.aoabFrictionLimit。

## 1. MD-7.8.2-BiasedDoubleWellExact · unnumbered_claim · 印刷p.295–297 / PDFp.316–318

### 2. 原文陈述

Let $M=\beta=1$ and define the biased double-well potential as
\[U(q)=(q^2-1)^2+q/2.\]
We choose the observable
\[\vartheta(q,p)=p^2-qU'(q)+2qp,\qquad\langle\vartheta\rangle=0.\]
The first order correction term for the $[BOA]$ scheme is given by the formula
\[\langle\vartheta f_{1,[BOA]}\rangle=\frac\beta2\int_{\mathcal D}(p^2-qU'(q)+2qp)(pU'(q)+\gamma U(q)-c)\rho_\beta d\omega
=\frac1\beta+\frac\gamma2\langle U\rangle-\frac{\gamma\beta}{2}\langle qUU'\rangle=\frac{2-\gamma}{2\beta}.\]
Hence for the critical value of $\gamma=2$, the leading order correction will be zero, giving
\[\langle\vartheta\rangle_h^{[BOA]}=\langle\vartheta\rangle+O(h^2).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def biasedDoubleWell (q : ℝ) : ℝ := (q^2-1)^2+q/2
def doubleWellObservable (x : ℝ × ℝ) : ℝ := x.2^2-x.1*deriv biasedDoubleWell x.1+2*x.1*x.2
def doubleWellGibbs (β : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-β*(x.2^2/2+biasedDoubleWell x.1))
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def doubleWellBOACorrection (β γ : ℝ) (x : ℝ × ℝ) : ℝ :=
  β/2*(x.2*deriv biasedDoubleWell x.1+γ*biasedDoubleWell x.1-
    γ*(∫ y, biasedDoubleWell y.1 ∂doubleWellGibbs β))
theorem doubleWellExact (β γ : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x ∂doubleWellGibbs β) = 0 ∧
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β γ x ∂doubleWellGibbs β) = (2-γ)/(2*β) := by
  sorry
theorem doubleWellCritical (β : ℝ) : (2-(2 : ℝ))/(2*β) = 0 := by ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.biasedDoubleWell, MD.Ch07.doubleWellObservable, MD.Ch07.doubleWellGibbs, MD.Ch07.doubleWellBOACorrection, MD.Ch07.doubleWellExact, MD.Ch07.doubleWellCritical | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 保留数值例中的精确数学积分和解析消项；原文虽起初β=1，推导中保留β，本条正β形式需同样积分分部理论。；中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要四次势Gibbs权可积性、积分分部与Gaussian矩的桥；不建设通用弱误差理论。
位置：Blueprint/Ch07.lean；MD.Ch07.biasedDoubleWell, MD.Ch07.doubleWellObservable, MD.Ch07.doubleWellGibbs, MD.Ch07.doubleWellBOACorrection, MD.Ch07.doubleWellExact, MD.Ch07.doubleWellCritical。

## 1. MD-7.9-Proposition71 · Proposition 7.1 / (7.26) · 印刷p.297 / PDFp.318

### 2. 原文陈述

Proposition 7.1 Let $\mathcal L_X^\dagger$, $\mathcal L_Y^\dagger$ and $\mathcal L_Z^\dagger$ be general operators to which BCH can be applied, then defining
\[e^{h\widehat{\mathcal L}^\dagger}=e^{\frac h2\mathcal L_X^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{h\mathcal L_Z^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{\frac h2\mathcal L_X^\dagger},\tag{7.26}\]
gives $\widehat{\mathcal L}^\dagger=\mathcal L_0^\dagger+h^2\mathcal L_2^\dagger+O(h^4)$, where
\[\mathcal L_0^\dagger=\mathcal L_X^\dagger+\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\]
\[\mathcal L_2^\dagger=\frac1{12}([\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_X^\dagger])
-\frac1{24}([\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_X^\dagger,\mathcal L_X^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger]).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition71 {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    ∃ Q : PowerSeries R, MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z =
      PowerSeries.C (X+Y+Z)+
      PowerSeries.C (MolecularDynamics.textbookSymmetricOperatorCorrection X Y Z)*PowerSeries.X^2+
      PowerSeries.X^4*Q := MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71 X Y Z
theorem symmetricOddCorrections {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) (k : ℕ) :
    PowerSeries.coeff (2*k+1) (MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z) = 0 :=
  MolecularDynamics.textbookSymmetricModifiedGenerator_odd_coeff_zero X Y Z k
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.proposition71, MD.Ch07.symmetricOddCorrections | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.proposition71, MD.Ch07.symmetricOddCorrections。

## 1. MD-7.9-EvenDensityPerturbation · (7.27)–(7.28) · 印刷p.298 / PDFp.319

### 2. 原文陈述

If we suppose that the odd order correction functions are zero, then we are left with
\[\widehat\rho=\rho_\beta(1+h^2f_2+h^4f_4+\cdots),\tag{7.27}\]
where each $\langle f_i\rangle=0$ as usual. Equating the second order terms we obtain
\[\mathcal L_{LD}^\dagger(\rho_\beta f_2)=-\mathcal L_2^\dagger\rho_\beta.\tag{7.28}\]
The condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $\mathcal L_2^\dagger\rho_\beta$ integrates to zero.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def evenDensityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) (k : ℕ) : Ω → ℝ :=
  if k = 0 then ρ else if Even k then fun x ↦ ρ x*f k x else 0
theorem evenPerturbationEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (hL1 : L 1 = 0) (hρ1 : ρ 1 = 0) (h2 : actionCoefficient L ρ 2 = 0) :
    L 0 (ρ 2) = -L 2 (ρ 0) := by
  have he : L 0 (ρ 2)+L 2 (ρ 0) = 0 := by
    simpa [actionCoefficient,Finset.sum_range_succ,hL1,hρ1] using h2
  exact eq_neg_of_add_eq_zero_left he
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.evenDensityExpansion, MD.Ch07.evenPerturbationEquation | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.evenDensityExpansion, MD.Ch07.evenPerturbationEquation。

## 1. MD-7.9.1-OYZYOInhomogeneity · (7.29) · 印刷p.298–299 / PDFp.319–320

### 2. 原文陈述

For methods $[OYZYO]$, substituting $\mathcal L_X^\dagger=\mathcal L_O^\dagger$, $\mathcal L_Y^\dagger+\mathcal L_Z^\dagger=\mathcal L_A^\dagger+\mathcal L_B^\dagger=\mathcal L_H^\dagger$ simplifies the computation to
\[\mathcal L_{2,[OYZYO]}^\dagger\rho_\beta=\frac1{12}[\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]\rho_\beta-\frac1{24}[\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]\rho_\beta.\tag{7.29}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.oyzyoInhomogeneity | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 本条没有另加数学前提。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需展开两个含O和H的嵌套交换子在共同核上的相消短桥；保留未证。
位置：Blueprint/Ch07.lean；MD.Ch07.oyzyoInhomogeneity。

## 1. MD-7.9.1-TripleCommutatorPrinted · unnumbered_claim · 印刷p.299 / PDFp.320

### 2. 原文陈述

\[[\mathcal L_A^\dagger,\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=(2\beta p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,\]
\[[\mathcal L_B^\dagger,\mathcal L_B^\dagger,\mathcal L_A^\dagger]\rho_\beta=-(2\beta p^T(\nabla^2U)\nabla U)\rho_\beta.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hessianU (U : V n → ℝ) (q : V n) (i j : Fin n) : ℝ := coordDerivative (fun y ↦ gradient U y j) q i
def thirdU (U : V n → ℝ) (q : V n) (i j k : Fin n) : ℝ := coordDerivative (fun y ↦ hessianU U y j k) q i
def hessianGrad (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*gradient U x.1 j
def cubicThird (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, ∑ k, thirdU U x.1 i j k*x.2 i*x.2 j*x.2 k
def tripleCommutatorPrinted (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  (2*β*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
def tripleCommutatorPrinted_corrected (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*(2*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
theorem tripleCommutator_corrected (U : V n → ℝ) (β : ℝ) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    let m : V n := fun _ ↦ 1
    let ρ := gibbsWeight m U β
    phaseComm (aForward m) (phaseComm (aForward m) (bForward U)) ρ = tripleCommutatorPrinted_corrected U β ∧
    phaseComm (bForward U) (phaseComm (bForward U) (aForward m)) ρ =
      (fun x ↦ -2*β*hessianGrad U x*ρ x) := by
  sorry
theorem tripleCommutator_factor_counterexample : (2*(2 : ℝ)*0-1) ≠ 2*(2*0-1) := by norm_num
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.hessianU, MD.Ch07.thirdU, MD.Ch07.hessianGrad, MD.Ch07.cubicThird, MD.Ch07.tripleCommutatorPrinted, MD.Ch07.tripleCommutatorPrinted_corrected, MD.Ch07.tripleCommutator_corrected, MD.Ch07.tripleCommutator_factor_counterexample | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要多维三阶Gibbs微分与交换子展开；不建设通用算符理论。
位置：Blueprint/Ch07.lean；MD.Ch07.hessianU, MD.Ch07.thirdU, MD.Ch07.hessianGrad, MD.Ch07.cubicThird, MD.Ch07.tripleCommutatorPrinted, MD.Ch07.tripleCommutatorPrinted_corrected, MD.Ch07.tripleCommutator_corrected, MD.Ch07.tripleCommutator_factor_counterexample。

## 1. MD-7.9.1-SymmetricRHS · unnumbered_claim · 印刷p.299 / PDFp.320

### 2. 原文陈述

\[\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OABAO]})=\frac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,\]
\[\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OBABO]})=\frac\beta{24}(2\nabla^3U:p\otimes p\otimes p-6p^T(\nabla^2U)\nabla U)\rho_\beta.\]
We can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $p$, and hence will average to 0.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def symmetricRHS (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/24*(if flip then 2*cubicThird U x-6*hessianGrad U x else 6*hessianGrad U x-cubicThird U x)
theorem symmetricRHS_odd (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) :
    symmetricRHS flip U β (x.1,-x.2) = -symmetricRHS flip U β x := by
  have hG : hessianGrad U (x.1,-x.2) = -hessianGrad U x := by
    simp [hessianGrad,Finset.sum_neg_distrib]
  have hT : cubicThird U (x.1,-x.2) = -cubicThird U x := by
    simp [cubicThird,Finset.sum_neg_distrib]
  cases flip <;> simp [symmetricRHS,hG,hT] <;> ring
theorem symmetricRHS_zeroMean (flip : Bool) (U : V n → ℝ) (β : ℝ)
    (hint : Integrable (symmetricRHS flip U β) (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, symmetricRHS flip U β x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.symmetricRHS, MD.Ch07.symmetricRHS_odd, MD.Ch07.symmetricRHS_zeroMean | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需Gaussian乘积测度在p↦-p下不变与可积奇函数积分为零的短桥；不建设Fredholm理论。
位置：Blueprint/Ch07.lean；MD.Ch07.symmetricRHS, MD.Ch07.symmetricRHS_odd, MD.Ch07.symmetricRHS_zeroMean。

## 1. MD-7.9.1-Lemma71 · Lemma 7.1 · 印刷p.299–300 / PDFp.320–321

### 2. 原文陈述

Lemma 7.1 Consider two numerical schemes with associated operators governing the evolution of measure $ST$ and $TS$, with unique associated invariant distributions $\widehat\rho_{ST}$ and $\widehat\rho_{TS}$ respectively, such that
\[ST\widehat\rho_{ST}=\widehat\rho_{ST},\qquad TS\widehat\rho_{TS}=\widehat\rho_{TS}.\]
Under suitable ergodicity assumptions (such that in the long-time limit, all distributions converge to the invariant distribution), we have
\[\widehat\rho_{ST}=S\widehat\rho_{TS},\qquad\widehat\rho_{TS}=T\widehat\rho_{ST}.\]

### 3. 原文证明

If we assume that $\lim_{n\to\infty}(ST)^n\rho=\widehat\rho_{ST}$, for any initial distribution $\rho$, then we have
$\widehat\rho_{ST}=\lim_{n\to\infty}(ST)^n\widehat\rho_{ST}=\lim_{n\to\infty}S(TS)^{n-1}T\widehat\rho_{ST}=S\widehat\rho_{TS}$.
A similar statement holds for $\widehat\rho_{ST}$.

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.lemma71 | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.lemma71。

## 1. MD-7.9.1-ConjugateSymmetricCorrections · (7.30a)–(7.30b) · 印刷p.300–301 / PDFp.321–322

### 2. 原文陈述

\[\widehat\rho_{[ZYOYZ]}=\exp((h/2)\mathcal L_Z^\dagger)\exp((h/2)\mathcal L_Y^\dagger)\exp((h/2)\mathcal L_O^\dagger)\widehat\rho_{[OYZYO]}.\]
\[f_{2,[ZYOYZ]}\rho_\beta=f_{2,[OYZYO]}\rho_\beta+\tfrac14\mathcal L_{1,[OYZ]}^\dagger\rho_\beta.\]
\[\mathcal L_{1,[OAB]}^\dagger\rho_\beta=\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\qquad
\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\]
\[\mathcal L_H^\dagger(g\rho_\beta)=\beta(|\nabla U|^2-p^T\nabla^2Up)\rho_\beta,\]
\[f_{2,[ABOBA]}=f_{2,[OBABO]}-\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up),\tag{7.30a}\]
\[f_{2,[BAOAB]}=f_{2,[OABAO]}+\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up).\tag{7.30b}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def gradNormSq (U : V n → ℝ) (q : V n) : ℝ := ∑ i, gradient U q i^2
def hessianQuadratic (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*x.2 j
def conjugateCorrectionChange (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/8*(gradNormSq U x.1-hessianQuadratic U x)
def conjugateCorrections (U : V n → ℝ) (β : ℝ) (fABOBA fOBABO fBAOAB fOABAO : Phase n → ℝ) : Prop :=
  fABOBA = fOBABO-conjugateCorrectionChange U β ∧ fBAOAB = fOABAO+conjugateCorrectionChange U β
theorem conjugateCorrection_coefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (p : ℕ → E) (q2 : E)
    (hL : L0 (p 0) = 0) (hp : p 1 = 0)
    (htransfer : q2 = p 2+(1/2 : ℝ) • L0 (p 1)+
      (1/4 : ℝ) • L1 (p 0)+(1/8 : ℝ) • (L0*L0) (p 0)) :
    q2 = p 2+(1/4 : ℝ) • L1 (p 0) := by
  simpa [hp,hL,Module.End.mul_apply] using htransfer
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.gradNormSq, MD.Ch07.hessianQuadratic, MD.Ch07.conjugateCorrectionChange, MD.Ch07.conjugateCorrections, MD.Ch07.conjugateCorrection_coefficient | 形式传递系数的消项及(7.30)全部目标；未证明从具体分裂映射导出这些系数。 |

[EXTRA] Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF321：所印传播子展开末项为(h²/2)L_LD，按exp的二阶展开应为(h²/8)(L_LD)²；该项作用ρβ为零，不改变后续修正关系。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.gradNormSq, MD.Ch07.hessianQuadratic, MD.Ch07.conjugateCorrectionChange, MD.Ch07.conjugateCorrections, MD.Ch07.conjugateCorrection_coefficient。

## 1. MD-7.9.2-ReciprocalFrictionExpansion · (7.31) / (7.32) · 印刷p.301–302 / PDFp.322–323

### 2. 原文陈述

We will denote
\[f_2(q,p)=f_{2,0}(q,p)+\epsilon f_{2,1}(q,p)+\epsilon^2f_{2,2}(q,p)+\cdots,\tag{7.31}\]
with each $\langle f_{2,i}\rangle=0$. Dividing by the friction in (7.28) we obtain
\[(\overline{\mathcal L}_O^\dagger+\epsilon\mathcal L_H^\dagger)(f_2\rho_\beta)=-\epsilon\mathcal L_2^\dagger\rho_\beta,\]
where $\overline{\mathcal L}_O^\dagger\vartheta=\epsilon\mathcal L_O^\dagger\vartheta=\nabla_p\cdot(p\vartheta)+\beta^{-1}\Delta_p\vartheta$.
\[w(q,p)=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p).\]
Equating powers gives
\[\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,0})=0,\quad
\mathcal L_H^\dagger(\rho_\beta f_{2,0})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,1})=-w\rho_\beta,\]
\[\mathcal L_H^\dagger(\rho_\beta f_{2,1})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2})=0,\quad
\mathcal L_H^\dagger(\rho_\beta f_{2,2})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,3})=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.phaseH, MD.Ch07.reciprocalHierarchy | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.phaseH, MD.Ch07.reciprocalHierarchy。

## 1. MD-7.9.2-OUKernelQualification · unnumbered_claim · 印刷p.302 / PDFp.323

### 2. 原文陈述

The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\overline{\mathcal L}_O^\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\nu(q)$, where $\langle\nu\rangle=0$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.ouKernelPrinted, MD.Ch07.ouKernelPrinted_corrected | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要OU生成元加权Dirichlet型、域闭包及核刻画理论，本轮不建设。
位置：Blueprint/Ch07.lean；MD.Ch07.ouKernelPrinted, MD.Ch07.ouKernelPrinted_corrected。

## 1. MD-7.9.2-OUHermiteIdentities · (7.33)–(7.34) · 印刷p.302 / PDFp.323

### 2. 原文陈述

\[\overline{\mathcal L}_O^\dagger(\rho_\beta\nabla^3U:p\otimes p\otimes p)=-3\rho_\beta\nabla^3U:p\otimes p\otimes p+\tfrac{6\rho_\beta}{\beta}p^T\nabla_q\Delta_qU,\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta p^T\nabla_q\Delta_qU)=-\rho_\beta p^T\nabla_q\Delta_qU,\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta p^T(\nabla^2U)\nabla U)=-\rho_\beta p^T(\nabla^2U)\nabla U.\]
\[w\rho_\beta=\tfrac\beta{24}\overline{\mathcal L}_O^\dagger([6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU]\rho_\beta).\tag{7.33}\]
\[\mathcal L_H^\dagger(\rho_\beta\nu)=-p^T\nabla\nu\rho_\beta=\overline{\mathcal L}_O^\dagger([p^T\nabla\nu+\mu(q)]\rho_\beta).\tag{7.34}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def laplacian (U : V n → ℝ) (q : V n) : ℝ := ∑ i, hessianU U q i i
def pGradLaplacian (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, x.2 i*gradient (laplacian U) x.1 i
def hermitePrimitive (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  6*hessianGrad U x-(1/3)*cubicThird U x-2/β*pGradLaplacian U x
theorem ouHermiteIdentities (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    let O := phaseO (fun _ ↦ 1) 1 β
    O (ρ*cubicThird U) = (fun x ↦ -3*ρ x*cubicThird U x+6*ρ x/β*pGradLaplacian U x) ∧
    O (ρ*pGradLaplacian U) = -(ρ*pGradLaplacian U) ∧
    O (ρ*hessianGrad U) = -(ρ*hessianGrad U) ∧
    (fun x ↦ -symmetricRHS false U β x*ρ x) = (fun x ↦ β/24*O (hermitePrimitive U β*ρ) x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.laplacian, MD.Ch07.pGradLaplacian, MD.Ch07.hermitePrimitive, MD.Ch07.ouHermiteIdentities | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需三阶张量的Gaussian共轭微分与混合导数交换；保留未证，不发展一般Hermite谱理论。
位置：Blueprint/Ch07.lean；MD.Ch07.laplacian, MD.Ch07.pGradLaplacian, MD.Ch07.hermitePrimitive, MD.Ch07.ouHermiteIdentities。

## 1. MD-7.9.2-FirstReciprocalCorrection · (7.35)–(7.36) · 印刷p.303–304 / PDFp.324–325

### 2. 原文陈述

\[f_{2,1,[OABAO]}=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU)-p^T\nabla\nu-\mu.\]
\[\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})=-\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]}).\tag{7.35}\]
\[\int_{\mathcal P}\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})d\omega_p=0,\qquad
\int_{\mathcal P}\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]})d\omega_p=\overline\pi\mathcal L_H^\dagger f_{2,1,[OABAO]}=0,\tag{7.36}\]
where $(\overline\pi f)(q)=\int_{\mathcal P}f(q,p)\rho_\beta d\omega_p$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*gibbsWeight (fun _ ↦ 1) U β (q,p)
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.firstReciprocalCorrection, MD.Ch07.momentumAverage, MD.Ch07.momentumAveragePrinted, MD.Ch07.firstReciprocalCorrection_pde | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要OU线性、Hermite恒等式应用和边界通量桥接；不建设Fredholm替代理论。
位置：Blueprint/Ch07.lean；MD.Ch07.firstReciprocalCorrection, MD.Ch07.momentumAverage, MD.Ch07.momentumAveragePrinted, MD.Ch07.firstReciprocalCorrection_pde。

## 1. MD-7.9.2-OverdampedSolvabilityOperators · unnumbered_claim · 印刷p.304 / PDFp.325

### 2. 原文陈述

We abbreviate
\[\mathcal M\psi(q)=\overline\pi\mathcal L_H^\dagger\mathcal L_A^\dagger\psi(q)
=\overline\pi((\mathcal L_A^\dagger)^2+\mathcal L_B^\dagger\mathcal L_A^\dagger)\psi(q)
=\beta^{-1}\Delta_q\psi(q)-\nabla U\cdot\nabla_q\psi(q),\]
\[\mathcal N\psi(q)=\overline\pi\mathcal L_H^\dagger(\mathcal L_A^\dagger)^3\psi(q)
=\overline\pi((\mathcal L_A^\dagger)^4+\mathcal L_B^\dagger(\mathcal L_A^\dagger)^3)\psi(q)
=\tfrac3\beta\mathcal M(\Delta_q\psi(q)).\]
Thus we have
\[\overline\pi\mathcal L_H^\dagger\rho_\beta f_{2,1,[OABAO]}=\tfrac\beta8\mathcal M(|\nabla U|^2-\beta^{-1}\Delta_qU)+\mathcal M\nu,\]
and hence by (7.36) we finally obtain $\nu(q)=\tfrac18(\Delta_qU-\beta|\nabla U|^2)$, where $\langle\nu\rangle=0$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def overdampedM (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  β⁻¹*laplacian ψ q-(∑ i, gradient U q i*gradient ψ q i)
def overdampedN (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  3/β*overdampedM U (laplacian ψ) β q
def highFrictionOABAO (U : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  (laplacian U q-β*gradNormSq U q)/8
theorem overdampedSolvability_choice (U : V n → ℝ) (β : ℝ) (hβ : β ≠ 0) :
    ∀ q, highFrictionOABAO U β q =
      -β/8*(gradNormSq U q-β⁻¹*laplacian U q) := by
  intro q
  dsimp [highFrictionOABAO]
  field_simp
  <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.overdampedM, MD.Ch07.overdampedN, MD.Ch07.highFrictionOABAO, MD.Ch07.overdampedSolvability_choice | M,N及ν全部显式公式和ν代数识别；平均算符等价与可解性未证明。 |

[EXTRA] M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。；只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.overdampedM, MD.Ch07.overdampedN, MD.Ch07.highFrictionOABAO, MD.Ch07.overdampedSolvability_choice。

## 1. MD-7.9.2-HighFrictionCorrectionTable · unnumbered_claim · 印刷p.304–305 / PDFp.325–326

### 2. 原文陈述

\[f_{2,0,[OABAO]}=\tfrac18(\Delta_qU-\beta|\nabla U|^2),\]
\[f_{2,0,[OBABO]}=\tfrac18(\beta|\nabla U|^2-2\Delta_qU+c),\]
where $c=\langle\Delta U\rangle$ is a constant chosen to ensure zero average.
\[f_{2,0,[ABOBA]}=\tfrac18(\beta p^T\nabla^2U(q)p-2\Delta_qU+c),\]
\[f_{2,0,[BAOAB]}=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p).\]
\[\langle\vartheta\rangle_h=\langle\vartheta\rangle+h^2\langle\vartheta f_{2,0}\rangle+O(\epsilon h^2+h^4).\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def highFrictionCorrection (s : Fin 4) (U : V n → ℝ) (β c : ℝ) (x : Phase n) : ℝ :=
  if s = 0 then highFrictionOABAO U β x.1
  else if s = 1 then (β*gradNormSq U x.1-2*laplacian U x.1+c)/8
  else if s = 2 then (β*hessianQuadratic U x-2*laplacian U x.1+c)/8
  else (laplacian U x.1-β*hessianQuadratic U x)/8
def doublyAsymptoticAverage (A : ℝ → ℝ → ℝ) (exact correction : ℝ) : Prop :=
  Asymptotics.IsBigO positivePairLimit
    (fun z ↦ A z.1 z.2-exact-z.2^2*correction) (fun z ↦ z.1*z.2^2+z.2^4)
theorem highFrictionCorrection_conjugacy (U : V n → ℝ) (β c : ℝ) :
    conjugateCorrections U β (highFrictionCorrection 2 U β c) (highFrictionCorrection 1 U β c)
      (highFrictionCorrection 3 U β c) (highFrictionCorrection 0 U β c) := by
  constructor <;> funext x <;>
    norm_num [conjugateCorrections,highFrictionCorrection,highFrictionOABAO,conjugateCorrectionChange]
    <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.highFrictionCorrection, MD.Ch07.doublyAsymptoticAverage, MD.Ch07.highFrictionCorrection_conjugacy | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。；候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.highFrictionCorrection, MD.Ch07.doublyAsymptoticAverage, MD.Ch07.highFrictionCorrection_conjugacy。

## 1. MD-7.9.3-BAOABMarginalCancellation · (7.37) · 印刷p.305 / PDFp.326

### 2. 原文陈述

\[\langle\vartheta\rangle=\langle\vartheta\rangle_h-h^2\langle\vartheta f_{2,0}\rangle+O(h^2/\gamma+h^4).\tag{7.37}\]
The $[BAOAB]$ scheme has leading order correction
\[f_{2,0,[BAOAB]}(q,p)=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p),\]
which has the interesting property that its marginal average with respect to momentum is zero:
\[\overline\pi f_{2,0,[BAOAB]}=\int_{\mathcal P}f_{2,0,[BAOAB]}(q,p)\rho_\beta(q,p)d\omega_p=0.\]
\[\langle\vartheta(q)f_{2,0,[BAOAB]}\rangle=\int_{\mathcal Q}\vartheta(q)\int_{\mathcal P}f_{2,0,[BAOAB]}\rho_\beta d\omega_p d\omega_q=0.\]

### 3. 原文证明

Integrate first over the Gaussian momenta; the quadratic Gaussian moment contracts the Hessian to β⁻¹ΔU. Then use Fubini.

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.baoabMarginalCancellation, MD.Ch07.baoabConfigurationalCancellation | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需Gaussian协方差矩阵、Hessian缩并与乘积Fubini桥；不发展Talay–Tubaro余项理论。
位置：Blueprint/Ch07.lean；MD.Ch07.baoabMarginalCancellation, MD.Ch07.baoabConfigurationalCancellation。

## 1. MD-7.9.3-SuperconvergenceScope · unnumbered_claim · 印刷p.306 / PDFp.327

### 2. 原文陈述

Thus we expect that the $[BAOAB]$ scheme recovers $O(h^4)$ configurational averages in the limit of infinite friction.
Its conjugate method, the $[OABAO]$ scheme, has the property
\[\int_{\mathcal Q}f_{2,0,[OABAO]}(q,p)\rho_\beta(q,p)d\omega_q=0,\]
implying that we obtain high-order averages for functions purely of the momenta in the limit of infinite friction.
It is important to note that this superconvergence property is only present in the limit of large time, i.e. this is an attribute of the invariant distribution of the discretization schemes $\widehat\rho$. As such, there are no bonuses to the weak or strong order of the superconvergent schemes.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem oabaoPositionCancellation (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U)
    (hweight : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hgrad : ∀ i, Integrable (fun q ↦ (hessianU U q i i-β*gradient U q i^2)*Real.exp (-β*U q)) volume)
    (hboundary : ∀ q i, Filter.Tendsto
      (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, highFrictionOABAO U β q ∂positionGibbs U β) = 0 := by
  sorry
theorem superconvergence_fromBound (A : ℝ → ℝ) (exact : ℝ)
    (hA : Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact-h^2*(0 : ℝ)) (fun h ↦ h^4)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact) (fun h ↦ h^4) := by
  simpa using hA
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.oabaoPositionCancellation, MD.Ch07.superconvergence_fromBound | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。；四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需要逐坐标积分分部及Fubini边界桥；不建设一般无限时间弱展开。
位置：Blueprint/Ch07.lean；MD.Ch07.oabaoPositionCancellation, MD.Ch07.superconvergence_fromBound。

## 1. MD-7.10-MomentumRedrawLimit · unnumbered_claim · 印刷p.306 / PDFp.327

### 2. 原文陈述

We now consider schemes in the limit $\gamma\to\infty$, where the exact solution of the vector OU process reduces to redrawing momenta from the canonical distribution, so $p_{n+1}=\sqrt{k_BT}M^{1/2}R$, where $R$ is a vector of i.i.d. normal random numbers.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.redrawMomentum, MD.Ch07.redrawStep, MD.Ch07.momentumRedrawLimit | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：指数衰减、sqrt连续与有限维逐坐标极限短桥；不建立Smoluchowski–Kramers理论。
位置：Blueprint/Ch07.lean；MD.Ch07.redrawMomentum, MD.Ch07.redrawStep, MD.Ch07.momentumRedrawLimit。

## 1. MD-7.10-OBABOOverdampedEuler · (7.38)–(7.39) · 印刷p.307 / PDFp.328

### 2. 原文陈述

For the method denoted $[OBABO]$, we have the limiting scheme
\[p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad \widehat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),\]
\[q_{n+1}=q_n+hM^{-1}\widehat p_{n+1/2},\quad
\widehat p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=\sqrt{k_BT}M^{1/2}R_{n+1/2}.\]
\[q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+h\sqrt{k_BT}M^{-1/2}R_n.\tag{7.38}\]
Denoting $\tau=h^2/2$, the update scheme (7.38) becomes the Euler-Maruyama scheme
\[q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}R_n.\tag{7.39}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def obaboInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  redrawStep m θ S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ redrawStep m θ R
def overdampedEulerH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-h^2/2/m i*gradient U q i+h/m i*redrawMomentum m θ R i
def overdampedEuler (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*R i
theorem obaboInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) (x : Phase n) :
    (obaboInfinite m U θ h R S x).1 = overdampedEulerH m U θ h R x.1 := by
  funext i
  dsimp [obaboInfinite,redrawStep,kickStep,driftStep,overdampedEulerH,Function.comp_def]
  ring
theorem overdampedEuler_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    overdampedEulerH m U θ h R q = overdampedEuler m U θ (h^2/2) R q := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.obaboInfinite, MD.Ch07.overdampedEulerH, MD.Ch07.overdampedEuler, MD.Ch07.obaboInfinite_position, MD.Ch07.overdampedEuler_rescale | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：时间尺度替换需实平方根、质量正性与根号乘积的短桥。
位置：Blueprint/Ch07.lean；MD.Ch07.obaboInfinite, MD.Ch07.overdampedEulerH, MD.Ch07.overdampedEuler, MD.Ch07.obaboInfinite_position, MD.Ch07.overdampedEuler_rescale。

## 1. MD-7.10-BAOABLimitMethod · (7.40) · 印刷p.307–308 / PDFp.328–329

### 2. 原文陈述

\[p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\]
\[\widehat p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\widehat p_{n+1/2},\quad
p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}).\]
Expressing this as an update solely for the configurations, we obtain
\[q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+\tfrac h2\sqrt{k_BT}M^{-1/2}(R_n+R_{n-1}),\]
and substituting $\tau=h^2/2$ gives the BAOAB Limit Method (Leimkuhler-Matthews method)
\[q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}\left(\tfrac{R_n+R_{n-1}}2\right).\tag{7.40}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def baoabInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ redrawStep m θ R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def lmStepH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-h^2/(2*m i)*gradient U q i+h/(2*m i)*(redrawMomentum m θ R i+redrawMomentum m θ S i)
def lmStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*((R i+S i)/2)
theorem baoabInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) :
    (baoabInfinite m U θ h R (q,fun i ↦ redrawMomentum m θ S i-h/2*gradient U q i)).1 =
      lmStepH m U θ h R S q := by
  funext i
  dsimp [baoabInfinite,lmStepH,kickStep,driftStep,redrawStep,Function.comp_def]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.baoabInfinite, MD.Ch07.lmStepH, MD.Ch07.lmStep, MD.Ch07.baoabInfinite_position | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。；完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.baoabInfinite, MD.Ch07.lmStepH, MD.Ch07.lmStep, MD.Ch07.baoabInfinite_position。

## 1. MD-7.10-ColoredNoiseAndExtension · unnumbered_claim · 印刷p.308 / PDFp.329

### 2. 原文陈述

We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $p_n$).

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.coloredNoise, MD.Ch07.coloredNoise_covariance, MD.Ch07.lmExtendedStep | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] MA(1)噪声以相邻两独立Gaussian平均定义；定义扩展状态(q,R旧)的完整一步映射。非Markov性的普遍表述依赖具体势和初值，未把任意位置过程都判非Markov；扩展Markov核与半群律仍是覆盖缺口。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需独立Gaussian一二阶矩的全部相邻/不相邻组合积分；不建一般时间序列理论。
位置：Blueprint/Ch07.lean；MD.Ch07.coloredNoise, MD.Ch07.coloredNoise_covariance, MD.Ch07.lmExtendedStep。

## 1. MD-7.10-LimitMethodAccuracy · definition · 印刷p.308 / PDFp.329

### 2. 原文陈述

We would expect that this scheme should have an $O(h^4)=O(\tau^2)$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $O(h^2)$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.lmTransientErrorBound, MD.Ch07.limitAccuracy_rescale | 误差界目标和步长幂次转换；尚缺LM算法到该界的完整定理。 |

[EXTRA] 用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。；原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.lmTransientErrorBound, MD.Ch07.limitAccuracy_rescale。

## 1. MD-7.9.3-ZeroFrictionVerlet · unnumbered_claim · 印刷p.306 / PDFp.327

### 2. 原文陈述

An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $\gamma=0$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.zeroFrictionOU, MD.Ch07.zeroFrictionBAOAB | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：两个A半步合并及函数组合化简的短桥尚未完成。
位置：Blueprint/Ch07.lean；MD.Ch07.zeroFrictionOU, MD.Ch07.zeroFrictionBAOAB。

## 1. MD-7.11.1-TemperatureObservables · (7.41)–(7.42) · 印刷p.310 / PDFp.331

### 2. 原文陈述

Indeed, calculating the temperature of the system from an average of kinetic energy by
\[N_dk_BT=\langle p^TM^{-1}p\rangle,\tag{7.41}\]
gives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature
\[N_dk_BT=\langle q\cdot\nabla U(q)\rangle.\tag{7.42}\]
Were one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.kineticTemperatureObservable, MD.Ch07.configurationTemperatureObservable, MD.Ch07.kineticTemperature, MD.Ch07.configurationTemperature | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。；构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

未证陈述；单文件编译与逐声明公理核对通过。
未证原因：需Gaussian二阶矩和多维Gibbs积分分部桥；不新建遍历性理论。
位置：Blueprint/Ch07.lean；MD.Ch07.kineticTemperatureObservable, MD.Ch07.configurationTemperatureObservable, MD.Ch07.kineticTemperature, MD.Ch07.configurationTemperature。

## 1. MD-7.11.1-VelocityAutocorrelationDefinition · definition · 印刷p.310 / PDFp.331

### 2. 原文陈述

The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.velocityAutocorrelation, MD.Ch07.greenKuboDiffusion, MD.Ch07.autocorrelation_rescale | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。；已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.velocityAutocorrelation, MD.Ch07.greenKuboDiffusion, MD.Ch07.autocorrelation_rescale。

## 1. MD-7.12-ConstrainedLangevin · (7.43)–(7.45) · 印刷p.317 / PDFp.338

### 2. 原文陈述

\[dq=M^{-1}pdt,\tag{7.43}\]
\[dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\tag{7.44}\]
\[0=g(q).\tag{7.45}\]
The vector of $l$ constraints is given by $g:\mathbb R^{N_c}\to\mathbb R^l$ and $\lambda$ is an $l$-dimensional vector of Lagrange multipliers. $W$ is a vector of standard Wiener processes, with the usual friction parameter $\gamma>0$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint
\[g(q)=0,\qquad g'(q)M^{-1}p=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (multiplier : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*multiplier j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.constraintJacobian, MD.Ch07.constraintReaction, MD.Ch07.hiddenConstraint, MD.Ch07.cotangentConstraint, MD.Ch07.constrainedLangevin | 全部约束积分方程及隐约束资格；适应性作为解资格显式保留，存在唯一性未证明。 |

[EXTRA] 实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。；定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.constraintJacobian, MD.Ch07.constraintReaction, MD.Ch07.hiddenConstraint, MD.Ch07.cotangentConstraint, MD.Ch07.constrainedLangevin。

## 1. MD-7.12-ConstrainedCanonicalErgodicity · definition · 印刷p.317 / PDFp.338

### 2. 原文陈述

In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\widetilde\rho_\beta$ ergodically, such that
\[\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,\]
where $\widetilde\rho_\beta$ is the normalized constrained canonical distribution
\[\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],\]
for normalizing constant $Z$ and where $\delta[z]:=\prod_i\delta[z_i]$ for a vector $z$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.constrainedCanonical, MD.Ch07.constrainedReference, MD.Ch07.constrainedErgodicAverages | 全部分布及遍历平均目标的测度定义；约束参考测度存在与具体过程的遍历定理仍缺。 |

[EXTRA] δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。；实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.constrainedCanonical, MD.Ch07.constrainedReference, MD.Ch07.constrainedErgodicAverages。

## 1. MD-7.12-ConstrainedHOSplitting · definition · 印刷p.318 / PDFp.339

### 2. 原文陈述

We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses
\[H_c:\quad dq=M^{-1}pdt,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,\]
\[O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.\]
We solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $h$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $h/2$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.constrainedHField, MD.Ch07.constrainedOField, MD.Ch07.constrainedHOComposition | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。；每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.constrainedHField, MD.Ch07.constrainedOField, MD.Ch07.constrainedHOComposition。

## 1. MD-7.12-MEVMEAlgorithm · definition · 印刷p.318–319 / PDFp.339–340

### 2. 原文陈述

Midpoint Euler - Verlet - Midpoint Euler (see [232])
\[p_{n+1/4}=p_n-\tfrac{h\gamma}4(p_n+p_{n+1/4})+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4},\quad g'(q_n)M^{-1}p_{n+1/4}=0.\]
\[p_{n+1/2}=p_{n+1/4}-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/2},\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\]
\[p_{n+3/4}=p_{n+1/2}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+3/4},\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\quad g(q_{n+1})=0.\]
\[p_{n+1}=p_{n+3/4}-\tfrac{h\gamma}4(p_{n+3/4}+p_{n+1})+\sqrt{h\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (multiplier : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (multiplier μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ multipliera multiplierb multiplierc multiplierd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa multipliera ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph multiplierb multiplierc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 multiplierd
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.midpointConstrainedORelation, MD.Ch07.constrainedVerletRelation, MD.Ch07.mevmeRelation | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.midpointConstrainedORelation, MD.Ch07.constrainedVerletRelation, MD.Ch07.mevmeRelation。

## 1. MD-7.12-MidpointStabilityPrinted · (7.46) · 印刷p.319 / PDFp.340

### 2. 原文陈述

The Lagrange multiplier $\lambda_{n+1/4}$ (and likewise $\lambda_{n+1}$) can be obtained by solving the linear system
\[g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,\]
which is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion
\[\gamma h<4.\tag{7.46}\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (multiplier : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor
  · apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
  · apply (div_le_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.multiplierLinearSystem, MD.Ch07.midpointAmplification, MD.Ch07.midpointStabilityPrinted, MD.Ch07.midpointStabilityPrinted_corrected, MD.Ch07.midpointStability_counterexample | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：已目视核对PDF340／印刷319：所印γh<4保留为原书给出的限制。它保证中点OU放大因子为正；OU线性绝对稳定性本身对γh≥0均成立。原文没有写充要关系，不能把本条当作已确认的原书错误。完整耦合Verlet仍有独立步长限制。
网站：尚未送审。

### 7. 状态与证明位置

已证；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.multiplierLinearSystem, MD.Ch07.midpointAmplification, MD.Ch07.midpointStabilityPrinted, MD.Ch07.midpointStabilityPrinted_corrected, MD.Ch07.midpointStability_counterexample。

## 1. MD-7.12.1-ConstrainedABOSplitting · definition · 印刷p.319–320 / PDFp.340–341

### 2. 原文陈述

\[A_c:\quad dq=M^{-1}pdt,\quad dp=-g'(q)^T\lambda dt,\quad g(q)=0,\]
\[B_c:\quad dq=0,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,\]
\[O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.\]
Observe that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $g(q)=0$.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 multiplier i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ multiplier : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (multiplier t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.constrainedAField, MD.Ch07.constrainedBField, MD.Ch07.geodesicConstraintFlow, MD.Ch07.constrainedKickRelation, MD.Ch07.constrainedExactORelation | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。；正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.constrainedAField, MD.Ch07.constrainedBField, MD.Ch07.geodesicConstraintFlow, MD.Ch07.constrainedKickRelation, MD.Ch07.constrainedExactORelation。

## 1. MD-7.12.1-ConstrainedBAOABAlgorithm · definition · 印刷p.320 / PDFp.341

### 2. 原文陈述

c-$[BAOAB]$
\[p_{n+1/5}=p_n-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/3},\quad g'(q_n)M^{-1}p_{n+1/5}=0.\]
Solve the geodesic flow $A_c$ for $h/2$, and map $[q_n,p_{n+1/5}]\to[q_{n+1/2},p_{n+2/5}]$.
\[p_{n+3/5}=e^{-\gamma h}p_{n+2/5}+\sqrt{(1-e^{-2\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\lambda_{n+2/3},\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.\]
Solve the geodesic flow $A_c$ for $h/2$, and map $[q_{n+1/2},p_{n+3/5}]\to[q_{n+1},p_{n+4/5}]$.
\[p_{n+1}=p_{n+4/5}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\]

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.constrainedBAOABRelation, MD.Ch07.constrainedBAOAB_constraint | 本条逐字引用的全部数学对象与公式；未纳入的上下文另列。 |

[EXTRA] 完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.constrainedBAOABRelation, MD.Ch07.constrainedBAOAB_constraint。

## 1. MD-7.12.1-ApproximateGeodesicOrder · definition · 印刷p.320 / PDFp.341

### 2. 原文陈述

We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $A_c$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.

### 3. 原文证明

原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 本条引用的对象与公式 | MD.Ch07.localMapErrorBound, MD.Ch07.geodesicReplacementSecondOrder | 局部二阶替换的目标资格；从该资格推出随机全局/不变分布阶数尚未陈述完整定理。 |

[EXTRA] 用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。
记号与上下文：见所列原文与Lean量化变量。

### 6. 审计结论

本地：已对照目视原页核对对象、量词、技术资格和所列覆盖范围；网站尚未审阅。
疑点：本条暂未发现需单列的原书疑误。
网站：尚未送审。

### 7. 状态与证明位置

定义；单文件编译与逐声明公理核对通过。
本条未登记待证缺项。
位置：Blueprint/Ch07.lean；MD.Ch07.localMapErrorBound, MD.Ch07.geodesicReplacementSecondOrder。

