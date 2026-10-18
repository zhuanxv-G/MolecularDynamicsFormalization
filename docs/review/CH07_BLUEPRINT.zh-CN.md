# 第7章 Lean Blueprint 本地审阅材料

当前已整理12条；网站尚未审阅。正文范围为印刷261–326页（PDF282–347），末页仅取Exercises之前的正文。

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

