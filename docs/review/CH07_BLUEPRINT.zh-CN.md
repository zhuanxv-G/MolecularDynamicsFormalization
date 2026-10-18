# 第7章 Lean Blueprint 本地审阅材料

当前已整理47条；网站尚未审阅。正文范围为印刷261–326页（PDF282–347），末页仅取Exercises之前的正文。

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

