# 第7章逐条审阅材料

正文118条。最新网站返回直接通过90条；1条按意见修复并在本地核验，未再次送审。另27条原文或范围问题待导师；各版本签名意见与证明状态分别列出。

## MD-7.1-Bias

印刷页 263 / PDF页 284。

### 1. 原文陈述

> All standard methods based on discretizing SDEs introduce some stepsize-dependent error in computed averages, which we shall refer to as bias (related to the truncation error of the discretization scheme).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bias (exact computed : ℝ) : ℝ := |exact - computed|
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bias 所列对象、量词、前提和结论。范围说明：实数 exact、computed 的绝对差与本段 bias 的含义及印刷266页公式一致。原段的概述没有被错误提升为所有算法的普遍定理；由后文具体化绝对误差的范围已显式披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。实数 exact、computed 的绝对差与本段 bias 的含义及印刷266页公式一致。原段的概述没有被错误提升为所有算法的普遍定理；由后文具体化绝对误差的范围已显式披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bias 所列对象、量词、前提和结论。范围说明：实数 exact、computed 的绝对差与本段 bias 的含义及印刷266页公式一致。原段的概述没有被错误提升为所有算法的普遍定理；由后文具体化绝对误差的范围已显式披露。

### 7. 状态与证明位置

- `MD.Ch07.bias`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-ScalarSDE

印刷页 264 / PDF页 285。

### 1. 原文陈述

> Let us begin with a discussion of the first order stochastic differential equation

$$
dX=a(X)dt+b(X)dW,
$$


> where $W$ defines a standard scalar Wiener process.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 scalarSDE 所列对象、量词、前提和结论。范围说明：P、标量W、标量X、自治a,b及确定初值x0均明确。D2—D6保留初值、非负时间路径连续性、漂移路径可积、自然历史适应及扩散平方可积，并以均匀左和的L²极限表示Itô方程。这是已披露的确定初值、自然滤过及L²解范围，并非所有弱解的等价定义；未声称其一般等价性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 明确概率空间与标准连续Wiener过程；Itô积分采用第6章网格左和L²定义，扩散项适应自然历史且时间平方可积。
- X的初值、几乎处处路径连续性和积分方程在第6章定义体中全部保留；未声称一般弱解与本L²表示等价。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。P、标量W、标量X、自治a,b及确定初值x0均明确。D2—D6保留初值、非负时间路径连续性、漂移路径可积、自然历史适应及扩散平方可积，并以均匀左和的L²极限表示Itô方程。这是已披露的确定初值、自然滤过及L²解范围，并非所有弱解的等价定义；未声称其一般等价性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 scalarSDE 所列对象、量词、前提和结论。范围说明：P、标量W、标量X、自治a,b及确定初值x0均明确。D2—D6保留初值、非负时间路径连续性、漂移路径可积、自然历史适应及扩散平方可积，并以均匀左和的L²极限表示Itô方程。这是已披露的确定初值、自然滤过及L²解范围，并非所有弱解的等价定义；未声称其一般等价性。

### 7. 状态与证明位置

- `MD.Ch07.scalarSDE`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-EulerMaruyama

印刷页 264 / PDF页 285。

### 1. 原文陈述

> The natural extension of the Euler method for SDEs like this one takes the form

$$
X_{n+1}=X_n+ha(X_n)+b(X_n)\sqrt h R_n,
$$


> where $R_n$ is a normal random variable with zero mean and unit variance. This method is referred to as the Euler-Maruyama method.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 eulerMaruyamaStep, standardNormalSequence, eulerMaruyama 所列对象、量词、前提和结论。范围说明：单步系数为h*a(x)与b(x)*sqrt(h)*R，无遗漏或符号错误。递归0步为x0，第k+1步使用R k。standardNormalSequence分别要求概率测度、跨步独立及每步N(0,1)；步长为总函数参数，h>0的数值使用限制已列明。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 步长h>0用于数值解释；单步映射本身为总函数；跨步独立正态资格另由standardNormalSequence明确给出。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。单步系数为h*a(x)与b(x)*sqrt(h)*R，无遗漏或符号错误。递归0步为x0，第k+1步使用R k。standardNormalSequence分别要求概率测度、跨步独立及每步N(0,1)；步长为总函数参数，h>0的数值使用限制已列明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 eulerMaruyamaStep, standardNormalSequence, eulerMaruyama 所列对象、量词、前提和结论。范围说明：单步系数为h*a(x)与b(x)*sqrt(h)*R，无遗漏或符号错误。递归0步为x0，第k+1步使用R k。standardNormalSequence分别要求概率测度、跨步独立及每步N(0,1)；步长为总函数参数，h>0的数值使用限制已列明。

### 7. 状态与证明位置

- `MD.Ch07.eulerMaruyamaStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.standardNormalSequence`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.eulerMaruyama`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-SDEIncrement

印刷页 264 / PDF页 285。

### 1. 原文陈述

> Note that from the definition of the SDE, we may write

$$
X(t+h)=X(t)+\int_t^{t+h}a(X(s))ds+\int_t^{t+h}b(X(s))dW(s).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 sdeIncrement 所列对象、量词、前提和结论。范围说明：固定t,h≥0及scalarSDE假设，结论第一分量给出t+h的从零Itô积分资格；t处同样资格由hX定义取得。第二分量的随机增量是这两个从零积分代表之差，漂移积分用区间可加性相减，等价于所引增量式。ha在hX中已蕴含但无害；这是固定t,h的几乎处处等式，并非声称一个公共零集外对所有时刻成立。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 区间Itô积分用两个从0开始的L²积分值之差表示；t,h非负，漂移在整个区间可积；不另造未规定的随机积分。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。固定t,h≥0及scalarSDE假设，结论第一分量给出t+h的从零Itô积分资格；t处同样资格由hX定义取得。第二分量的随机增量是这两个从零积分代表之差，漂移积分用区间可加性相减，等价于所引增量式。ha在hX中已蕴含但无害；这是固定t,h的几乎处处等式，并非声称一个公共零集外对所有时刻成立。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 sdeIncrement 所列对象、量词、前提和结论。范围说明：固定t,h≥0及scalarSDE假设，结论第一分量给出t+h的从零Itô积分资格；t处同样资格由hX定义取得。第二分量的随机增量是这两个从零积分代表之差，漂移积分用区间可加性相减，等价于所引增量式。ha在hX中已蕴含但无害；这是固定t,h的几乎处处等式，并非声称一个公共零集外对所有时刻成立。

### 7. 状态与证明位置

- `MD.Ch07.sdeIncrement`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-StrongError

印刷页 264 / PDF页 285。

### 1. 原文陈述

> In the case of strong accuracy, our measure of the global error is the quantity [200]

$$
\mathrm{Err}_{h,\tau;\alpha}^{\rm strong}=\max_{n=0,1,2,\ldots,\nu} \left[\mathbb E|X_n-X(nh)|^\alpha\right]^{1/\alpha}.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def strongError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (h α : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = (∫ sample, |Xh k sample - X (k*h) sample| ^ α ∂P) ^ (1/α)}
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 strongError 所列对象、量词、前提和结论。范围说明：k取range(N+1)，包含0和N；非空有限集合的sSup确为最大值。实指数α与1/α、绝对差及期望的位置都对应原式。定义是总化公式；α>0、概率测度与矩可积的适用资格在extra\_assumptions中说明，不应将不可积时Lean的总化积分解释为误差。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- α>0且各网格误差的α次矩可积时具有误差解释；有限非空网格的sSup表示最大值；Real.rpow为实指数幂。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。k取range(N+1)，包含0和N；非空有限集合的sSup确为最大值。实指数α与1/α、绝对差及期望的位置都对应原式。定义是总化公式；α>0、概率测度与矩可积的适用资格在extra\_assumptions中说明，不应将不可积时Lean的总化积分解释为误差。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 strongError 所列对象、量词、前提和结论。范围说明：k取range(N+1)，包含0和N；非空有限集合的sSup确为最大值。实指数α与1/α、绝对差及期望的位置都对应原式。定义是总化公式；α>0、概率测度与矩可积的适用资格在extra\_assumptions中说明，不应将不可积时Lean的总化积分解释为误差。

### 7. 状态与证明位置

- `MD.Ch07.strongError`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-MeanErrorExpectation

印刷页 264 / PDF页 285。

### 1. 原文陈述

> For $\alpha=1$ this implies convergence of expectation. The more natural choice from the probabilistic point of view is $\alpha=2$ (mean square convergence).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 meanErrorExpectation, meanSquareError 所列对象、量词、前提和结论。范围说明：在X、Y均可积的前提下给出期望差绝对值≤绝对误差期望，足以传递α=1收敛；meanSquareError为二阶矩平方根，与α=2强误差的均方根惯例一致。没有把期望收敛误称为L¹收敛的逆命题。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 期望可积；不以数值方法的收敛为假设重新宣布同一收敛，只给使收敛传递成立的定量不等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。在X、Y均可积的前提下给出期望差绝对值≤绝对误差期望，足以传递α=1收敛；meanSquareError为二阶矩平方根，与α=2强误差的均方根惯例一致。没有把期望收敛误称为L¹收敛的逆命题。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 meanErrorExpectation, meanSquareError 所列对象、量词、前提和结论。范围说明：在X、Y均可积的前提下给出期望差绝对值≤绝对误差期望，足以传递α=1收敛；meanSquareError为二阶矩平方根，与α=2强误差的均方根惯例一致。没有把期望收敛误称为L¹收敛的逆命题。

### 7. 状态与证明位置

- `MD.Ch07.meanErrorExpectation`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.meanSquareError`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-StrongOrder

印刷页 264 / PDF页 285。

### 1. 原文陈述

> Having settled on a choice of $\alpha$, we say that a method has strong order $r$ if
> $\mathrm{Err}_{h,\tau}^{\rm strong}<C(\tau)h^r$ for some coefficient $C(\tau)$ depending on the time interval.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def hasStrongOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (α r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < α ∧ 0 < r ∧
  ∀ T : ℝ, 0 < T → ∃ C : ℝ, 0 < C ∧ ∃ N0 : ℕ, 0 < N0 ∧
    ∀ N : ℕ, N0 ≤ N →
      (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ |Xh (T/N) k sample - X (k*(T/N)) sample|^α) P) ∧
      strongError P (Xh (T/N)) X (T/N) α N < C * (T/N)^r
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 hasStrongOrder 所列对象、量词、前提和结论。范围说明：α,r>0，P为概率测度；对每个T>0存在正C和正N0，对所有N≥N0统一控制h=T/N的全部网格误差，并要求α次矩可积。C不依赖N，严格小于号保留。h=T/N的渐近量词及r>0均已明示，忠实于数值收敛阶的通常正阶范围。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 显式h=T/N趋零及统一常数的量词；正α、r和时间；有限矩资格作为方法适用条件不隐去。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。α,r>0，P为概率测度；对每个T>0存在正C和正N0，对所有N≥N0统一控制h=T/N的全部网格误差，并要求α次矩可积。C不依赖N，严格小于号保留。h=T/N的渐近量词及r>0均已明示，忠实于数值收敛阶的通常正阶范围。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 hasStrongOrder 所列对象、量词、前提和结论。范围说明：α,r>0，P为概率测度；对每个T>0存在正C和正N0，对所有N≥N0统一控制h=T/N的全部网格误差，并要求α次矩可积。C不依赖N，严格小于号保留。h=T/N的渐近量词及r>0均已明示，忠实于数值收敛阶的通常正阶范围。

### 7. 状态与证明位置

- `MD.Ch07.hasStrongOrder`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-WeakError

印刷页 265 / PDF页 286。

### 1. 原文陈述

> The weak error is usually defined with reference to suitable test functions (observables) $\phi(x)$ by

$$
\mathrm{Err}^{\rm weak}_{h,\tau,\phi}=\max_{n=0,1,2,\ldots,\nu}|\mathbb E\phi(X_n)-\mathbb E\phi(X(nh))|,
$$


> and we say that a method has weak order $r$ if $\mathrm{Err}^{\rm weak}_{h,\tau,\phi}<D(\tau)h^r$ for some $D(\tau)$, for all members of the chosen class of observables.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 weakError, hasWeakOrder 所列对象、量词、前提和结论。范围说明：weakError为0…N各期望差绝对值的最大值。hasWeakOrder先对测试函数再对T量化，再选择D,N0，故D可依赖f,T而不依赖N；每个测试函数两侧均要求可积。不是对整个无界函数类使用同一常数；此解释已显式披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 测试函数类明确量化；D允许依赖测试函数；积分只有在可积时解释为期望，后续误差定理显式要求可积。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。weakError为0…N各期望差绝对值的最大值。hasWeakOrder先对测试函数再对T量化，再选择D,N0，故D可依赖f,T而不依赖N；每个测试函数两侧均要求可积。不是对整个无界函数类使用同一常数；此解释已显式披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 weakError, hasWeakOrder 所列对象、量词、前提和结论。范围说明：weakError为0…N各期望差绝对值的最大值。hasWeakOrder先对测试函数再对T量化，再选择D,N0，故D可依赖f,T而不依赖N；每个测试函数两侧均要求可积。不是对整个无界函数类使用同一常数；此解释已显式披露。

### 7. 状态与证明位置

- `MD.Ch07.weakError`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.hasWeakOrder`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-StrongWeakComparison

印刷页 265 / PDF页 286。

### 1. 原文陈述

> It is easy to see that methods with high strong order give us high weak order too, but the converse is generally false.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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
  let P : Measure ℝ := (1/2 : ℝ≥0) • Measure.dirac (-1)+(1/2 : ℝ≥0) • Measure.dirac 1
  have hi (f : ℝ → ℝ) (a : ℝ) : Integrable f ((1/2 : ℝ≥0) • Measure.dirac a) :=
    (integrable_dirac (by simp)).smul_measure_nnreal
  refine ⟨P,id,Neg.neg,?_,?_,?_⟩
  · constructor
    simp only [P,Measure.add_apply,Measure.smul_apply,Measure.dirac_apply_of_mem (Set.mem_univ _),ENNReal.smul_def,smul_eq_mul,mul_one]
    exact_mod_cast (by norm_num : (1/2 : ℝ≥0)+(1/2 : ℝ≥0) = 1)
  · intro f
    dsimp [P]
    rw [integral_add_measure (hi _ _) (hi _ _),integral_add_measure (hi _ _) (hi _ _)]
    simp [integral_smul_nnreal_measure,add_comm]
  · dsimp [P]
    rw [integral_add_measure (hi _ _) (hi _ _)]
    norm_num [integral_smul_nnreal_measure]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 正向结论明确限制为全局Lipschitz可观测量及可积误差；对一般无界测试函数需额外矩条件，列为覆盖缺口。
- 反向用两点分布上交换X、Y的反例表达；同分布但耦合强误差不为零。
- 29号覆盖限定：仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。正向strongWeakLipschitz的完整签名是L≥0、全局Lipschitz且f(X)、f(Y)、|X−Y|可积时的一阶绝对误差控制，不是原句对任意测试函数类、任意α的收敛阶结论。反向声明正确：等权±1、X=id、Y=−id使所有测试函数期望相等而E|X−Y|=2；它给出耦合层面的反例，未构造一个完整数值方法族。已披露覆盖缺口，但原书无条件措辞仍须人工限定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。

### 7. 状态与证明位置

- `MD.Ch07.strongWeakLipschitz`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.weakDoesNotImplyStrong`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-CanonicalAverage

印刷页 266 / PDF页 287。

### 1. 原文陈述

> Recall that for canonical sampling, the (stationary or invariant) average of an observable $\phi(q,p)$ is given as

$$
\operatorname{Av}_\beta(\phi)=\int_D\phi(q,p)\rho_\beta(q,p)d\omega,\tag{7.1}
$$


> where $\rho_\beta$ is the canonical measure

$$
\rho_\beta(q,p)=Z_{\rm can}^{-1}\exp(-\beta H(q,p)).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def densityWithPartition {D : Type*} (H : D → ℝ) (β Z : ℝ) (x : D) : ℝ :=
  Z⁻¹ * Real.exp (-β * H x)

def canonicalAverage {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z : ℝ) : ℝ := ∫ x, f x * densityWithPartition H β Z x ∂ν

def probabilityDensity {D : Type*} [MeasurableSpace D] (ν : Measure D) (ρ : D → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ x) ∧ Integrable ρ ν ∧ (∫ x, ρ x ∂ν) = 1
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 densityWithPartition, canonicalAverage, probabilityDensity 所列对象、量词、前提和结论。范围说明：一般可测空间D和基准测度ν抽象了相空间及其积分域。densityWithPartition用Z⁻¹ exp(−βH)，canonicalAverage积分f乘密度；probabilityDensity另外检查非负、可积与归一化。Z被保持为显式参数，本条没有沿用下一条印刷错误推出归一化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 该公式先保留显式Z参数；只有probabilityDensity成立才称概率密度。正有限配分积分及其归一化见修正版，不把原页倒数疑误带入默认定义。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。一般可测空间D和基准测度ν抽象了相空间及其积分域。densityWithPartition用Z⁻¹ exp(−βH)，canonicalAverage积分f乘密度；probabilityDensity另外检查非负、可积与归一化。Z被保持为显式参数，本条没有沿用下一条印刷错误推出归一化。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 densityWithPartition, canonicalAverage, probabilityDensity 所列对象、量词、前提和结论。范围说明：一般可测空间D和基准测度ν抽象了相空间及其积分域。densityWithPartition用Z⁻¹ exp(−βH)，canonicalAverage积分f乘密度；probabilityDensity另外检查非负、可积与归一化。Z被保持为显式参数，本条没有沿用下一条印刷错误推出归一化。

### 7. 状态与证明位置

- `MD.Ch07.densityWithPartition`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.canonicalAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.probabilityDensity`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-PartitionPrinted

印刷页 266 / PDF页 287。

### 1. 原文陈述

> and $Z_{\rm can}$ is the canonical partition function

$$
Z_{\rm can}^{-1}=\int_D\exp(-\beta H(q,p))d\omega,
$$


> ensuring the integral of $\rho_\beta$ is unity.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文版严格保留倒数关系；修正版取Z\_can=配分积分，并补正性、可积性。
- 反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。
- 29号覆盖限定：原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。partitionPrinted忠实保留Z⁻¹=配分积分及其归一化结论，应按Printed规则判断忠实性而非强求错误命题成立。该原书结论数学上错误，须人工确认。partitionPrinted\_counterexample的1/4≠1正确但只是测度反例的代数核心；partitionPrinted\_corrected用Z=配分积分并显式要求正性和可积性，其非负、可积、总质量1三项结论正确。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。

### 7. 状态与证明位置

- `MD.Ch07.partitionPrinted`：未证；原书疑误不证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.partitionPrinted_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.partitionPrinted_corrected`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.2-AverageNotationBias

印刷页 266 / PDF页 287。

### 1. 原文陈述

> In this chapter, we will abbreviate the exact average of the observable $\phi$ to

$$
\langle\phi\rangle\overset{\rm def}=\operatorname{Av}_\beta(\phi),
$$


> and write the observed average computed in experiment (using a discretization method with step size $h$) as $\langle\phi\rangle_h$. The error in the average of $\phi$ due to the perfect sampling bias can be evaluated as

$$
\text{Error due to discretization}=|\langle\phi\rangle-\langle\phi\rangle_h|.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def observableBias {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z computed : ℝ) : ℝ :=
  bias (canonicalAverage ν H f β Z) computed

theorem bias_nonnegative (exact computed : ℝ) : 0 ≤ bias exact computed := abs_nonneg _
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 observableBias, bias\_nonnegative 所列对象、量词、前提和结论。范围说明：observableBias把精确canonicalAverage与computed作绝对差，bias\_nonnegative对全部实参数成立。computed按明示约定代表步长h的完美采样平均；没有将有限样本统计误差合入。h没有独立参数是因为已被computed吸收，未声称已构造长期平均。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- computed代表步长h下的不变平均，按原文忽略有限采样误差；正确Z和密度概率资格见CanonicalAverage及修正版。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。observableBias把精确canonicalAverage与computed作绝对差，bias\_nonnegative对全部实参数成立。computed按明示约定代表步长h的完美采样平均；没有将有限样本统计误差合入。h没有独立参数是因为已被computed吸收，未声称已构造长期平均。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 observableBias, bias\_nonnegative 所列对象、量词、前提和结论。范围说明：observableBias把精确canonicalAverage与computed作绝对差，bias\_nonnegative对全部实参数成立。computed按明示约定代表步长h的完美采样平均；没有将有限样本统计误差合入。h没有独立参数是因为已被computed吸收，未声称已构造长期平均。

### 7. 状态与证明位置

- `MD.Ch07.observableBias`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bias_nonnegative`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3-VectorOU

印刷页 267 / PDF页 288。

### 1. 原文陈述

> By way of illustration of what we mean by a numerical sampling method, consider the system of independent Ornstein-Uhlenbeck (OU) processes

$$
dp=-\gamma pdt+\sqrt{2k_BT\gamma}\,M^{1/2}dW.\tag{7.2}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 V, Phase, vectorWiener, momentumOU 所列对象、量词、前提和结论。范围说明：V n为Fin n→ℝ，Phase为位置动量对。vectorWiener的D20含联合高斯、零均值、min(s,t)对角协方差、路径连续，并额外要求坐标路径独立；momentumOU逐坐标系数−γp和sqrt(2γθm\_i)一致。确定初值、正对角质量、θ=k\_BT>0、γ≥0及自然滤过L²解范围均显式可见。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 显式标准多维Wiener及整个坐标路径独立，正质量、温度与非负摩擦；各坐标用真实Itô积分方程。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。V n为Fin n→ℝ，Phase为位置动量对。vectorWiener的D20含联合高斯、零均值、min(s,t)对角协方差、路径连续，并额外要求坐标路径独立；momentumOU逐坐标系数−γp和sqrt(2γθm\_i)一致。确定初值、正对角质量、θ=k\_BT>0、γ≥0及自然滤过L²解范围均显式可见。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 V, Phase, vectorWiener, momentumOU 所列对象、量词、前提和结论。范围说明：V n为Fin n→ℝ，Phase为位置动量对。vectorWiener的D20含联合高斯、零均值、min(s,t)对角协方差、路径连续，并额外要求坐标路径独立；momentumOU逐坐标系数−γp和sqrt(2γθm\_i)一致。确定初值、正对角质量、θ=k\_BT>0、γ≥0及自然滤过L²解范围均显式可见。

### 7. 状态与证明位置

- `MD.Ch07.V`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.Phase`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.vectorWiener`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumOU`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3-OUIntegratingFactor

印刷页 267 / PDF页 288。

### 1. 原文陈述

> Following the argument of Sect. 6.3.2 in the previous chapter,

$$
d[\exp(\gamma t)p]=\gamma\exp(\gamma t)pdt+\exp(\gamma t)[-\gamma pdt+\sqrt{2k_BT\gamma}M^{1/2}dW] =\exp(\gamma t)\sqrt{2k_BT\gamma}M^{1/2}dW.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem ouIntegratingFactor (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t : ℝ) (ht : 0 ≤ t) : ∀ i,
    MolecularDynamics.Chapter06Review.isItoIntegral P (fun s sample ↦ W s sample i)
      (fun s _ ↦ Real.exp (γ*s)*Real.sqrt (2*γ*θ*m i)) t
      (fun sample ↦ Real.exp (γ*t)*p t sample i-p0 i) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 ouIntegratingFactor 所列对象、量词、前提和结论。范围说明：固定t≥0，逐坐标的加权积分 integrand=exp(γs)sqrt(2γθm\_i)，终值=exp(γt)p\_i(t)−p0\_i，与乘积法则及从0积分一致。hp包含正确的OU方程与确定初值；没有用积分因子等式本身充当假设。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 把随机微分乘积法则陈述为从0到t的确定性加权Itô积分等式；有限时间和L²解资格由momentumOU明确。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。固定t≥0，逐坐标的加权积分 integrand=exp(γs)sqrt(2γθm\_i)，终值=exp(γt)p\_i(t)−p0\_i，与乘积法则及从0积分一致。hp包含正确的OU方程与确定初值；没有用积分因子等式本身充当假设。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 ouIntegratingFactor 所列对象、量词、前提和结论。范围说明：固定t≥0，逐坐标的加权积分 integrand=exp(γs)sqrt(2γθm\_i)，终值=exp(γt)p\_i(t)−p0\_i，与乘积法则及从0积分一致。hp包含正确的OU方程与确定初值；没有用积分因子等式本身充当假设。

### 7. 状态与证明位置

- `MD.Ch07.ouIntegratingFactor`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3-OUExactUpdate

印刷页 268 / PDF页 289。

### 1. 原文陈述

> Integrating from $t$ to $t+h$ and multiplying by $\exp(-\gamma t)$, we arrive at the solution

$$
p(t+h)=e^{-\gamma h}p(t)+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}Z,\tag{7.3}
$$


> where $Z$ is a vector of independent, standard normal random variables.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 等式解释为存在与过去动量独立的标准正态向量的随机表示；不是沿用同一Z表示所有时刻。
- 独立性要求使用W自然历史的适应解，见scalarSDE；θ=k\_BT，M正对角。
- 29号覆盖限定：只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。ouMomentum的衰减exp(−γh)、噪声方差θ(1−exp(−2γh))m\_i正确。ouTransitionLaw对每个固定t≥0、h>0存在标准独立坐标向量Z，与p(t)独立并几乎处处给出更新；γ=0时噪声系数为0仍可由W区间增量提供Z。原书前导文字的乘数exp(−γt)疑为笔误，应为exp(−γ(t+h))；公式(7.3)本身正确，需人工确认该原书疑误。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。

### 7. 状态与证明位置

- `MD.Ch07.ouMomentum`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.ouTransitionLaw`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3-OUPhaseIteration

印刷页 268 / PDF页 289。

### 1. 原文陈述

> Alternatively, we may write this as a discrete iteration in terms of a random map:

$$
p_{n+1}=e^{-\gamma h}p_n+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R_n,
$$


> with normally distributed $R$. For later purposes, we will think of this update as acting on both $q$ and $p$, leaving $q$ unchanged, i.e.

$$
(q_{n+1},p_{n+1})=(q_n,e^{-\gamma h}p_n+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R_n).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def ouStep (m : V n) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  (x.1, ouMomentum m γ θ h x.2 R)

def vectorNormalSequence (P : Measure Ω) (R : ℕ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 ouStep, vectorNormalSequence 所列对象、量词、前提和结论。范围说明：ouStep保持q不变，p分量完全复用ouMomentum。vectorNormalSequence规定跨步独立及每步乘积标准正态分布，涵盖分量独立；总化单步映射本身没有伪称任意R都具有正态分布。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 独立标准正态的完整概率资格由vectorNormalSequence规定；ouStep只是总化单步函数。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。ouStep保持q不变，p分量完全复用ouMomentum。vectorNormalSequence规定跨步独立及每步乘积标准正态分布，涵盖分量独立；总化单步映射本身没有伪称任意R都具有正态分布。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 ouStep, vectorNormalSequence 所列对象、量词、前提和结论。范围说明：ouStep保持q不变，p分量完全复用ouMomentum。vectorNormalSequence规定跨步独立及每步乘积标准正态分布，涵盖分量独立；总化单步映射本身没有伪称任意R都具有正态分布。

### 7. 状态与证明位置

- `MD.Ch07.ouStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.vectorNormalSequence`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3-OUForward

印刷页 268 / PDF页 289。

### 1. 原文陈述

> The Fokker-Planck operator for the OU system (7.2) can be computed directly as

$$
\mathcal L_O^\dagger\phi(q,p)=\gamma\nabla_p\cdot(p\phi)+\gamma k_BT\nabla_p\cdot M\nabla_p\phi.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 coordDerivative, ouForward, ouBackward, ouForward\_adjoint 所列对象、量词、前提和结论。范围说明：ouForward第一项是γ∑∂_i(p\_i f)，第二项γθ∑m\_i∂²\_i f；ouBackward漂移为−γ∑p\_i∂_i f，扩散符号相同。真实偏导D23已核对。两紧支撑C²函数上的积分伴随关系边界项为0，签名正确；q固定参数，未声称半群的完整强生成元域。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- partial为真实单坐标导数；给出前向表达式与后向生成元在紧支撑C²测试函数上的伴随恒等式。
- 仅p变量，q是固定参数；未声称已构造OU Markov半群的强生成元域。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。ouForward第一项是γ∑∂_i(p\_i f)，第二项γθ∑m\_i∂²\_i f；ouBackward漂移为−γ∑p\_i∂_i f，扩散符号相同。真实偏导D23已核对。两紧支撑C²函数上的积分伴随关系边界项为0，签名正确；q固定参数，未声称半群的完整强生成元域。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 coordDerivative, ouForward, ouBackward, ouForward\_adjoint 所列对象、量词、前提和结论。范围说明：ouForward第一项是γ∑∂_i(p\_i f)，第二项γθ∑m\_i∂²\_i f；ouBackward漂移为−γ∑p\_i∂_i f，扩散符号相同。真实偏导D23已核对。两紧支撑C²函数上的积分伴随关系边界项为0，签名正确；q固定参数，未声称半群的完整强生成元域。

### 7. 状态与证明位置

- `MD.Ch07.coordDerivative`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.ouForward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.ouBackward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.ouForward_adjoint`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3-OUGaussianInvariant

印刷页 268 / PDF页 289。

### 1. 原文陈述

> Alternatively, if we ignore the physical origin of this parameter, we can think of $\gamma$ as an arbitrary coefficient; the sampling of the invariant measure does not depend on this choice. Thus we have a family of sampling iterations for the Gaussian distribution, defined for different choices of $\gamma$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem ouGaussianInvariant (m : V n) (γ θ h : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : 0 ≤ γ) (hθ : 0 < θ) (hh : 0 ≤ h) :
    Measure.map (fun x : V n × V n ↦ ouMomentum m γ θ h x.1 x.2)
      ((Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩)).prod
        (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) =
      Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 ouGaussianInvariant 所列对象、量词、前提和结论。范围说明：输入分布是独立的p~⊗N(0,θm\_i)与R~⊗N(0,1)，映射逐坐标线性组合的方差为exp(−2γh)θm\_i+θ(1−exp(−2γh))m\_i=θm\_i，输出仍为独立高斯。m>0、θ>0、γ,h≥0保证全部方差合法；γ=0或h=0只表示不变性，不包含遍历收敛断言。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- γ=0允许恒等更新，仍保留Gaussian不变性；不把此时的不变性说成遍历采样收敛。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。输入分布是独立的p~⊗N(0,θm\_i)与R~⊗N(0,1)，映射逐坐标线性组合的方差为exp(−2γh)θm\_i+θ(1−exp(−2γh))m\_i=θm\_i，输出仍为独立高斯。m>0、θ>0、γ,h≥0保证全部方差合法；γ=0或h=0只表示不变性，不包含遍历收敛断言。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 ouGaussianInvariant 所列对象、量词、前提和结论。范围说明：输入分布是独立的p~⊗N(0,θm\_i)与R~⊗N(0,1)，映射逐坐标线性组合的方差为exp(−2γh)θm\_i+θ(1−exp(−2γh))m\_i=θm\_i，输出仍为独立高斯。m>0、θ>0、γ,h≥0保证全部方差合法；γ=0或h=0只表示不变性，不包含遍历收敛断言。

### 7. 状态与证明位置

- `MD.Ch07.ouGaussianInvariant`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-Langevin

印刷页 268 / PDF页 289。

### 1. 原文陈述

> Langevin dynamics:

$$
dq=M^{-1}pdt,\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{7.4}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 gradient, langevin 所列对象、量词、前提和结论。范围说明：langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p\_i/m\_i，动量漂移−∂_iU−γp\_i，噪声sqrt(2γθm\_i)(W\_i(t)−W\_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用真实坐标偏导与完整位置/动量积分方程表达；常扩散的Itô项即W增量乘系数；显式状态适应W自然历史、漂移可积。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p\_i/m\_i，动量漂移−∂_iU−γp\_i，噪声sqrt(2γθm\_i)(W\_i(t)−W\_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 gradient, langevin 所列对象、量词、前提和结论。范围说明：langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p\_i/m\_i，动量漂移−∂_iU−γp\_i，噪声sqrt(2γθm\_i)(W\_i(t)−W\_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。

### 7. 状态与证明位置

- `MD.Ch07.gradient`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.langevin`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-HamiltonianGibbs

印刷页 269 / PDF页 290。

### 1. 原文陈述

> Since Hamiltonian dynamics leaves invariant any function of the energy, its corresponding Fokker-Planck operator (in this case the Liouvillian, $\mathcal L_H^\dagger=-\mathcal L_H$) will preserve distributions that are functions of the Hamiltonian $H$. This implies in particular that it preserves $\rho_\beta$, which is proportional to $\exp(-\beta H)$. Thus the forward propagator associated to the Hamiltonian system automatically preserves the Gibbs distribution, and we have

$$
e^{t\mathcal L_H^\dagger}\rho_\beta=\rho_\beta.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem hamiltonianGibbs {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (F : D → D) (H : D → ℝ) (β : ℝ)
    (hF : Measurable F) (hv : MeasurePreserving F ν ν)
    (hH : ∀ x, H (F x) = H x) (hweight : Measurable (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) :
    Measure.map F (ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) =
      ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 hamiltonianGibbs 所列对象、量词、前提和结论。范围说明：对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- F为已存在的实际Hamiltonian流的固定时刻映射；显式体积保持与能量保持，结论为实际加权测度不变性。
- 本文未重证明一般Hamiltonian流存在；若需归一化为概率，须另补配分积分正有限。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 hamiltonianGibbs 所列对象、量词、前提和结论。范围说明：对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。

### 7. 状态与证明位置

- `MD.Ch07.hamiltonianGibbs`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABOPieces

印刷页 269–270 / PDF页 290–291。

### 1. 原文陈述

> We therefore consider dividing the Langevin system (7.4) into parts

$$
d\binom qp=\binom{M^{-1}p}{0}dt+\binom0{-\nabla U(q)}dt+\binom0{-\gamma pdt+\sigma M^{1/2}dW},\tag{7.5}
$$


> which we label A, B, and O, where each of the three parts may be solved “exactly”, with individual updates given as

$$
\mathcal U_h^A(q,p)=(q+hM^{-1}p,p),\quad \mathcal U_h^B(q,p)=(q,p-h\nabla U(q)),\quad \mathcal U_h^O(q,p)=(q,e^{-\gamma h}p+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R),
$$


> where $R$ is a vector of i.i.d. normal random numbers.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 driftStep, kickStep, aField, bField, oDrift, splittingDrift 所列对象、量词、前提和结论。范围说明：aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- M为正对角质量；σ=√(2γk\_BT)；OU单步及独立正态资格已在OUPhaseIteration写全。
- 仅最后短定理证明漂移相加；A/B确定性精确流与O分布精确性各自另列，不用漂移恒等式替代。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 driftStep, kickStep, aField, bField, oDrift, splittingDrift 所列对象、量词、前提和结论。范围说明：aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。

### 7. 状态与证明位置

- `MD.Ch07.driftStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.kickStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oDrift`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.splittingDrift`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABExactFlows

印刷页 270 / PDF页 291。

### 1. 原文陈述

> For the deterministic pieces A and B, the updates correspond to their flow maps, while the update for the O piece corresponds to the solution derived in (7.3).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem driftStep_derivative (m : V n) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (driftStep m s x).1 i) (x.2 i / m i) t := by
  simpa [driftStep, mul_div_assoc] using ((hasDerivAt_id t).mul_const (x.2 i / m i)).const_add (x.1 i)

theorem kickStep_derivative (U : V n → ℝ) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (kickStep U s x).2 i) (-gradient U x.1 i) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 driftStep\_derivative, kickStep\_derivative 所列对象、量词、前提和结论。范围说明：driftStep\_derivative和kickStep\_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 逐坐标A位置/B动量真实时间导数；另一个分量由更新定义恒定；O精确性引用OUTransitionLaw未证陈述，不冒称全部已证。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。driftStep\_derivative和kickStep\_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 driftStep\_derivative, kickStep\_derivative 所列对象、量词、前提和结论。范围说明：driftStep\_derivative和kickStep\_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。

### 7. 状态与证明位置

- `MD.Ch07.driftStep_derivative`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.kickStep_derivative`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABForward

印刷页 270 / PDF页 291。

### 1. 原文陈述

> The relevant forward propagators for each piece of the Hamiltonian part are computed through the adjoint of the Lie derivatives as

$$
\mathcal L_A^\dagger=-M^{-1}p\cdot\nabla_q,\qquad \mathcal L_B^\dagger=\nabla U(q)\cdot\nabla_p.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def aForward (m : V n) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  -∑ i, x.2 i / m i * coordDerivative (fun q ↦ f (q,x.2)) x.1 i
def bForward (U : V n → ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, gradient U x.1 i * coordDerivative (fun p ↦ f (x.1,p)) x.2 i
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 aForward, bForward 所列对象、量词、前提和结论。范围说明：aForward为−∑(p\_i/m\_i)∂_{q\_i}f，bForward为+∑∂_{q\_i}U ∂_{p\_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 以真实偏导定义所印微分表达式；形式伴随解释要求足够光滑及边界通量消失，未声称一般强算子域。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。aForward为−∑(p\_i/m\_i)∂_{q\_i}f，bForward为+∑∂_{q\_i}U ∂_{p\_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 aForward, bForward 所列对象、量词、前提和结论。范围说明：aForward为−∑(p\_i/m\_i)∂_{q\_i}f，bForward为+∑∂_{q\_i}U ∂_{p\_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。

### 7. 状态与证明位置

- `MD.Ch07.aForward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bForward`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABOBABO

印刷页 270 / PDF页 291。

### 1. 原文陈述

> For example, the method denoted $[ABO]$ (acting from left to right) has a resulting update

$$
\mathcal U_h^{[ABO]}=\mathcal U_h^O\circ\mathcal U_h^B\circ\mathcal U_h^A.
$$


> An alternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme denoted $[BABO]$ with associated map

$$
\mathcal U_h^{[BABO]}=\mathcal U_h^O\circ\mathcal U_{h/2}^B\circ\mathcal U_h^A\circ\mathcal U_{h/2}^B.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def abo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U h ∘ driftStep m h
def babo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 abo, babo 所列对象、量词、前提和结论。范围说明：从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 字母从左到右执行，函数复合从右到左；随机变量独立资格由vectorNormalSequence约束。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 abo, babo 所列对象、量词、前提和结论。范围说明：从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。

### 7. 状态与证明位置

- `MD.Ch07.abo`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.babo`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-WordConvention

印刷页 270 / PDF页 291。

### 1. 原文陈述

> As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABOAOBAO]$ has an update

$$
\mathcal U_h^{[OABOAOBAO]}=\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O,
$$


> where the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 3) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘
  ouStep m γ θ (h/4) (R 1) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

/-- 恢复原页的兼容名称；原书此处没有计数勘误。 -/
def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n := oabaobaoPrinted m U γ θ h R

theorem oabaobaoCount : (["O","A","B","O","A","O","B","A","O"] : List String).count "O" = 4 := by decide
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。
- 29号覆盖限定：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。
- PDF291已目视核对：原书九字母OABOAOBAO、四次O(h/4)、4N\_c均正确；撤销转录造成的假疑误。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。原页实际为九字母OABOAOBAO，四个O、三个A、两个B；所印复合也有九个因子，四个O(h/4)，并明确需4N\_c正态数，完全符合每字母总时长h的约定。本条JSON及三个Lean声明却删掉第三、第四字母间的O，形成八字母OABAOBAO。Printed版不忠实；_corrected版仅使另一个八字母算法内部一致，不能作为原页勘误；oabaobaoCount对八字母列表计数为3本身正确，但对象不是原书例子。
网站复审结论：PASS。任意n及实参数m,U,γ,θ,h和R:Fin 4→V n给出总化的确定性映射。三次A各h/3、两次B各h/2、四次O各h/4，与原页一致；计数定理无前提且结论正确。物理随机方法需正质量、适用时间/温度及联合独立标准正态噪声，当前定义不附带这些概率断言；此限制不使字面映射签名失败。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。

### 7. 状态与证明位置

- `MD.Ch07.oabaobaoPrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oabaobaoPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oabaobaoCount`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-SixSchemes

印刷页 271 / PDF页 292。

### 1. 原文陈述

> For reference and to remove any ambiguity, we write out some of these algorithms below as single timestep maps.

$$
\begin{array}{ll} [ABAO]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\quad p_{n+1/2}=p_n-h\nabla U(q_{n+1/2}),\\ &q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1/2},\quad p_{n+1}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n;\\ [BABO]:&p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\ &\hat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=e^{-h\gamma}\hat p_{n+1/2}+\zeta_2M^{1/2}R_n;\\ [ABOBA]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\quad p_{n+1/2}=p_n-(h/2)\nabla U(q_{n+1/2}),\\ &\hat p_{n+1/2}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n,\\ &p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1/2}),\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1};\\ [BAOAB]:&p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\ &\hat p_{n+1/2}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n,\\ &q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\hat p_{n+1/2},\quad p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1});\\ [OABAO]:&p_{n+1/2}=e^{-h\gamma/2}p_n+\zeta_1M^{1/2}R_n,\\ &q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\quad\hat p_{n+1/2}=p_{n+1/2}-h\nabla U(q_{n+1/2}),\\ &q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\hat p_{n+1/2},\quad p_{n+1}=e^{-h\gamma/2}\hat p_{n+1/2}+\zeta_1M^{1/2}R_{n+1/2};\\ [OBABO]:&p_{n+1/2}=e^{-h\gamma/2}p_n+\zeta_1M^{1/2}R_n,\quad\hat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),\\ &q_{n+1}=q_n+hM^{-1}\hat p_{n+1/2},\quad\hat p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\\ &p_{n+1}=e^{-h\gamma/2}\hat p_{n+1}+\zeta_1M^{1/2}R_{n+1/2}, \end{array}
$$


> where $\zeta_j=[k_BT(1-e^{-j\gamma h})]^{1/2}$, and $R_n,R_{n+1/2}$ are $N_d$ vectors of standard independent $\mathcal N(0,1)$ random variables, resampled at each step.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 abao, aboba, baoab, oabao, obabo 所列对象、量词、前提和结论。范围说明：逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- BABO已定义于ABOBABO；其余5个完整复合依次对应所列中间步。
- R与S为同一步两次O的独立标准正态向量；跨步也独立，用vectorNormalSequence提供资格。
- 原文最后“single evaluation”使用跨步缓存；实现成本不列为待证数学命题。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 abao, aboba, baoab, oabao, obabo 所列对象、量词、前提和结论。范围说明：逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。

### 7. 状态与证明位置

- `MD.Ch07.abao`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aboba`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.baoab`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oabao`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obabo`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ConjugateIteration

印刷页 272 / PDF页 293。

### 1. 原文陈述

> When iterated $n+1$ times, we can see the scheme $[OABA]$ produces a mapping of the form

$$
(\mathcal U_h^{[OABA]})^{n+1}=\mathcal U_{h/2}^A\circ\mathcal U_{h/2}^B\circ(\mathcal U_h^{[BAOAB]})^n\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/2}^A\circ\mathcal U_h^O;
$$


> therefore through a coordinate transformation the $[OABA]$ method can be morphed into the $[BAOAB]$ scheme.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

def conjugateNoiseS (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (z : Phase n × ℕ) : Phase n × ℕ :=
  ((kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h (R z.2)) z.1,z.2+1)

def conjugateNoiseT (m : V n) (U : V n → ℝ) (h : ℝ)
    (z : Phase n × ℕ) : Phase n × ℕ :=
  ((driftStep m (h/2) ∘ kickStep U (h/2)) z.1,z.2)

theorem oaba_baoab_noiseShift (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (k : ℕ) :
    (fun z : Phase n × ℕ ↦ (oaba m U γ θ h (R z.2) z.1,z.2+1))^[k+1] =
      conjugateNoiseT m U h ∘
      (fun z : Phase n × ℕ ↦ (baoab m U γ θ h (R z.2) z.1,z.2+1))^[k] ∘
      conjugateNoiseS m U γ θ h R := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- compositionIterate是任意确定性映射的真实复合恒等式；实际随机迭代应在扩展噪声序列空间中使用更新映射，不能把固定R重复使用当独立重抽样。
- 对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。
- 29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。
- 覆盖缺口：29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。compositionIterate 对任意类型 D、任意自映射 S,T 和自然数 k 的恒等式正确；oaba 的右到左顺序为 O,A/2,B,A/2。未给出将该通用恒等式特化为所印 BAOAB 的声明，也没有独立噪声序列上的共轭。
网站复审结论：PASS。所有对象和量词匹配：状态空间为Phase n×ℕ，R:ℕ→V n任意，k任意自然数；不需概率假设即可陈述精确代数关系。采用T∘S为OABA、S∘T为BAOAB时，原文外侧A/B半步分别由T及S给出，端点和噪声移位正确。一般compositionIterate中的S/T字母与具体conjugateNoiseS/T的角色对调不影响结论。不变测度、可逆坐标变换和遍历性没有被该恒等式证明，已按范围限制保留。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。

### 7. 状态与证明位置

- `MD.Ch07.compositionIterate`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.oaba`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.conjugateNoiseS`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.conjugateNoiseT`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oaba_baoab_noiseShift`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.2-SPVPrinted

印刷页 272 / PDF页 293。

### 1. 原文陈述

> Stochastic Position Verlet (SPV)

$$
q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\qquad p_{n+1}=e^{-h\gamma}p_n-\eta\nabla U(q_n)+\zeta M^{1/2}R_n,\qquad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}
$$


> where $\eta=(1-e^{-h\gamma})/\gamma$, $\zeta=[k_BT(1-e^{-2\gamma h})]^{1/2}$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def spvPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U x.1 i
  driftStep m (h/2) (qhalf,pnew)

def spvPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U qhalf i
  driftStep m (h/2) (qhalf,pnew)

/-- 两个总化映射的物理适用域；γ=0另需定义η=h，此处不含该延拓。 -/
def spvQualification (m : V n) (γ θ h : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ 0 ≤ h
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。
- 29号覆盖限定：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。
- 覆盖缺口：29号覆盖限定：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。spvPrinted 忠实采用 q\_n 计算梯度；spvPrinted\_corrected 改为 qhalf，符合先漂移半步再精确求解冻结位置的 OU/力子步。θ 对应 k\_BT，逐坐标质量为对角 M。两版均未单独限制物理参数，视为代数定义可接受；γ=0 时商的总化值不能代表连续延拓。
网站复审结论：NEEDS\_HUMAN。Printed及corrected的输入均为m,U,γ,θ,h,R,x，输出为Phase n；前者忠实原印q\_n，后者实现先A半步、再冻结位置的受力OU整步、再A半步。候选修正符合本页对称分裂的推导，但原印与文字说明存在真实冲突，因此整条保留NEEDS\_HUMAN。spvQualification只是独立Prop，不会自动成为两个def的前提；应在物理解释时显式引用。
按版本登记：修正版仅作为对称分裂的候选定义获认可；物理使用须引用spvQualification，γ=0延拓未覆盖。原印取力点仍待导师。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。

### 7. 状态与证明位置

- `MD.Ch07.spvPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spvPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.spvQualification`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.2-SPVLargeFriction

印刷页 272–273 / PDF页 293–294。

### 1. 原文陈述

> It is important to note that in the limit of infinite friction, we have $\eta\to0$ independent of the timestep $h$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $\gamma$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem spvEtaLimit (h : ℝ) (hh : 0 < h) :
    Tendsto (fun γ : ℝ ↦ (1-Real.exp (-h*γ))/γ) atTop (𝓝 0) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只表达明确的η极限；采样不一致的定性判断缺统一模型、时标与测试函数量化，不作为已证结论。
- 29号覆盖限定：固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。spvEtaLimit 对每个固定 h>0 断言 γ→+∞ 时 η→0，正确，且未把任意负 h 包含在内。没有陈述分布采样不一致或随机游走极限，extra\_assumptions 已披露此范围。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。

### 7. 状态与证明位置

- `MD.Ch07.spvEtaLimit`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.2-BBK

印刷页 273 / PDF页 294。

### 1. 原文陈述

> Brünger-Brooks-Karplus (BBK)

$$
p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,
$$



$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R'_n]/(1+h\gamma/2).
$$


> Often $R'$ is chosen such that $R'_n=R_{n+1}$, so the random vector would be reused at the start of the following timestep, however there are many variants of this scheme that incorporate the redraw of random numbers differently. In other variants of BBK we take $R'_n=R_n$, reusing the random number within the step.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbk (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) (x : Phase n) : Phase n :=
  let ph := fun i ↦ (1-h*γ/2)*x.2 i - (h/2)*gradient U x.1 i +
    (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*R i
  let q := (driftStep m h (x.1,ph)).1
  (q, fun i ↦ (ph i-(h/2)*gradient U q i + (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*S i)/(1+h*γ/2))

def bbkSameNoise (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) := bbk m U γ θ h R R
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbk, bbkSameNoise 所列对象、量词、前提和结论。范围说明：bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- h>0、γ≥0、θ>0、m\_i>0时分母非零及噪声方差有效；不同R′耦合方案分别处理，不把独立与重用噪声混为一谈。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbk, bbkSameNoise 所列对象、量词、前提和结论。范围说明：bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。

### 7. 状态与证明位置

- `MD.Ch07.bbk`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bbkSameNoise`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-HarmonicHamiltonian

印刷页 273 / PDF页 294。

### 1. 原文陈述

> Recall that the one-dimensional harmonic oscillator with spring constant $\Omega^2$ has potential energy function $U(q)=\Omega^2q^2/2$, with Hamiltonian

$$
H(q,p)=\frac{p^2}{2m}+\frac{\Omega^2q^2}{2},\tag{7.6}
$$


> where $(q,p)\in\mathbb R^2$ represent a particle's position and momentum, and $m>0$ is the particle's mass.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def harmonicHamiltonian (m Ω : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/(2*m)+Ω^2*x.1^2/2
def harmonicLaw (m Ω θ : ℝ) : Measure (ℝ × ℝ) :=
  (gaussianReal 0 (Real.toNNReal (θ/Ω^2))).prod (gaussianReal 0 (Real.toNNReal (θ*m)))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 harmonicHamiltonian, harmonicLaw 所列对象、量词、前提和结论。范围说明：harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 正m、正θ、Ω≠0时为可归一化的正则谐振子Gibbs分布；θ=k\_BT。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 harmonicHamiltonian, harmonicLaw 所列对象、量词、前提和结论。范围说明：harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。

### 7. 状态与证明位置

- `MD.Ch07.harmonicHamiltonian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.harmonicLaw`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-HarmonicMoments

印刷页 273–274 / PDF页 294–295。

### 1. 原文陈述

> In this setting, the canonical distribution $\rho_\beta$ is the product of two Gaussian distributions, where we have invariant (stationary) averages

$$
\langle q\rangle=\langle p\rangle=0,\qquad\langle\Omega^2q^2\rangle=\langle p^2/m\rangle=k_BT,\qquad\langle qp\rangle=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem harmonicMoments (m Ω θ : ℝ) (hm : 0 < m) (hΩ : Ω ≠ 0) (hθ : 0 < θ) :
    (∫ x, x.1 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, x.2 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, Ω^2*x.1^2 ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.2^2/m ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.1*x.2 ∂harmonicLaw m Ω θ) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 harmonicMoments 所列对象、量词、前提和结论。范围说明：五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- harmonicLaw给出实际正态乘积，未把所需各矩值作为假设；与Hamiltonian的密度识别另列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 harmonicMoments 所列对象、量词、前提和结论。范围说明：五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。

### 7. 状态与证明位置

- `MD.Ch07.harmonicMoments`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-LinearIteration

印刷页 274 / PDF页 295。

### 1. 原文陈述

> Thus, denoting the iteration index as a subscript, we may explicitly write one iteration of a general numerical method for evolving the dynamics as

$$
\binom{q_{n+1}}{p_{n+1}}=\Psi\binom{q_n}{p_n}+\mu_n,\tag{7.7}
$$


> where $\Psi$ is a constant matrix that depends on the stepsize $h$, the friction coefficient $\gamma$, the particle mass $m$ and the spring constant $\Omega$. Additionally $\mu_n$ is a vector of stochastic processes.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def linearUpdate (a b c d : ℝ) (x noise : ℝ × ℝ) : ℝ × ℝ :=
  (a*x.1+b*x.2+noise.1,c*x.1+d*x.2+noise.2)
def momentQ (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1^2 ∂μ
def momentP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.2^2 ∂μ
def momentQP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1*x.2 ∂μ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 linearUpdate, momentQ, momentP, momentQP 所列对象、量词、前提和结论。范围说明：linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 具体2×2矩阵用四个真实系数，噪声不假定自动独立；后续陈述分别补独立或相关结构。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 linearUpdate, momentQ, momentP, momentQP 所列对象、量词、前提和结论。范围说明：linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。

### 7. 状态与证明位置

- `MD.Ch07.linearUpdate`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentQ`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentP`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentQP`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-BBKLinearForm

印刷页 274 / PDF页 295。

### 1. 原文陈述

> For example, in the BBK method we can compute directly from its update scheme that

$$
\Psi^{\rm BBK}=\begin{bmatrix}1-\frac{h^2\Omega^2}{2m}&\frac hm(1-\frac{\gamma h}2)\\ \frac{h\Omega^2}{2m}\frac{h^2\Omega^2-4m}{2+\gamma h}&\frac{(2-\gamma h)(2m-h^2\Omega^2)}{2m(2+\gamma h)}\end{bmatrix},
$$



$$
\mu_n^{\rm BBK}=\begin{bmatrix}\sqrt{\frac{k_BT\gamma h^3}{2m}}R_n\\ \frac{\sqrt{2k_BT\gamma hm}}{2+\gamma h}[(1-\frac{h^2\Omega^2}{2m})R_n+R'_n]\end{bmatrix}.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbkMatrix (m Ω γ h : ℝ) : ℝ × ℝ × ℝ × ℝ :=
  (1-h^2*Ω^2/(2*m), h/m*(1-γ*h/2),
    h*Ω^2/(2*m)*((h^2*Ω^2-4*m)/(2+γ*h)),
    (2-γ*h)*(2*m-h^2*Ω^2)/(2*m*(2+γ*h)))
def bbkNoise (m Ω γ θ h R S : ℝ) : ℝ × ℝ :=
  (Real.sqrt (θ*γ*h^3/(2*m))*R,
    Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*((1-h^2*Ω^2/(2*m))*R+S))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkMatrix, bbkNoise 所列对象、量词、前提和结论。范围说明：bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra\_assumptions 已明确此缺口。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。
- 覆盖缺口：完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra\_assumptions 已明确此缺口。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkMatrix, bbkNoise 所列对象、量词、前提和结论。范围说明：bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra\_assumptions 已明确此缺口。

### 7. 状态与证明位置

- `MD.Ch07.bbkMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bbkNoise`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-QuadraticProducts

印刷页 274 / PDF页 295。

### 1. 原文陈述

> More generally, if we define the components of $\Psi$ as $\psi_{ij}$ and denote $\mu_n=[\mu_{n,1},\mu_{n,2}]^T$ we can take products of the update equations defined by (7.7) to obtain

$$
q_{n+1}^2=\psi_{11}^2q_n^2+\psi_{12}^2p_n^2+\mu_{n,1}^2+2\psi_{11}\psi_{12}q_np_n+2\psi_{11}\mu_{n,1}q_n+2\psi_{12}\mu_{n,1}p_n,\tag{7.8}
$$



$$
p_{n+1}^2=\psi_{21}^2q_n^2+\psi_{22}^2p_n^2+\mu_{n,2}^2+2\psi_{21}\psi_{22}q_np_n+2\psi_{21}\mu_{n,2}q_n+2\psi_{22}\mu_{n,2}p_n,\tag{7.9}
$$



$$
q_{n+1}p_{n+1}=\psi_{11}\psi_{21}q_n^2+\psi_{12}\psi_{22}p_n^2+\mu_{n,1}\mu_{n,2}+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})q_np_n +(\psi_{11}\mu_{n,2}+\psi_{21}\mu_{n,1})q_n+(\psi_{22}\mu_{n,1}+\psi_{12}\mu_{n,2})p_n.\tag{7.10}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 quadraticProducts 所列对象、量词、前提和结论。范围说明：对全部八个任意实数，三个合取项分别展开 q\_new²、p\_new²、q\_new p\_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对全部八个任意实数，三个合取项分别展开 q\_new²、p\_new²、q\_new p\_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 quadraticProducts 所列对象、量词、前提和结论。范围说明：对全部八个任意实数，三个合取项分别展开 q\_new²、p\_new²、q\_new p\_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。

### 7. 状态与证明位置

- `MD.Ch07.quadraticProducts`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-StationaryMomentSystem

印刷页 275 / PDF页 296。

### 1. 原文陈述

> Hence we have $\mathbb E(\mu_{n,i}q_n)=\mathbb E(\mu_{n,i}p_n)=0$, for any $i$ and $n$. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then considering the limit $n\to\infty$ we obtain a closed, linear system of equations

$$
Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+\bar\mu_{11},
$$



$$
P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+\bar\mu_{22},
$$



$$
C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\bar\mu_{12},\tag{7.11}
$$


> where $\bar\mu_{11}=\mathbb E(\mu_{n,1}^2)$, $\bar\mu_{12}=\mathbb E(\mu_{n,1}\mu_{n,2})$, $\bar\mu_{22}=\mathbb E(\mu_{n,2}^2)$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 momentSystem, invariantLinearLaw, stationaryMomentSystem 所列对象、量词、前提和结论。范围说明：momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 使用独立乘积μ.prodη及实际推前不变性，不把所求矩方程当作该定理假设；所有坐标L²、噪声中心化明示。
- 只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。
- 覆盖缺口：只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 momentSystem, invariantLinearLaw, stationaryMomentSystem 所列对象、量词、前提和结论。范围说明：momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。

### 7. 状态与证明位置

- `MD.Ch07.momentSystem`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.invariantLinearLaw`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.stationaryMomentSystem`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-ABOHarmonic

印刷页 275–276 / PDF页 296–297。

### 1. 原文陈述

> Example 7.1 Consider the scheme coded $[ABO]$.
> In the case of the one-dimensional harmonic oscillator, we have $U'(q)=\Omega^2q$, yielding the compact form of one iteration as

$$
\binom{q_{n+1}}{p_{n+1}}=\begin{bmatrix}1&h/m\\-\Omega^2he^{-h\gamma}&(1-\Omega^2h^2/m)e^{-h\gamma}\end{bmatrix}\binom{q_n}{p_n}+\binom0{\zeta m^{1/2}R_n}.\tag{7.12}
$$


> Taking expectations of (7.12) and then taking the limit as $n\to\infty$, we see immediately that
> $\langle q\rangle_h^{[ABO]}=\langle p\rangle_h^{[ABO]}=0$, as $\mathbb E(R_n)=0$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 aboHarmonic, aboStationaryMean 所列对象、量词、前提和结论。范围说明：aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 aboHarmonic, aboStationaryMean 所列对象、量词、前提和结论。范围说明：aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。

### 7. 状态与证明位置

- `MD.Ch07.aboHarmonic`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aboStationaryMean`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-ABOVariance

印刷页 276 / PDF页 297。

### 1. 原文陈述

> For example, the relative increase in the variance of position is computed for the $[ABO]$ scheme as

$$
\frac{\langle q^2\rangle_h^{[ABO]}}{\langle q^2\rangle}=\frac{e^{h\gamma}m(1+e^{-h\gamma})^2}{2m(1+e^{-h\gamma})-h^2\Omega^2e^{-h\gamma}} =1+\gamma h/2+(\Omega^2+\gamma^2m)h^2/(4m)+O(h^3).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 aboVarianceRatio, aboVarianceRatio\_expansion, aboStationaryVariance 所列对象、量词、前提和结论。范围说明：有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 aboVarianceRatio, aboVarianceRatio\_expansion, aboStationaryVariance 所列对象、量词、前提和结论。范围说明：有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。

### 7. 状态与证明位置

- `MD.Ch07.aboVarianceRatio`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aboVarianceRatio_expansion`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.aboStationaryVariance`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-Table71

印刷页 277 / PDF页 298。

### 1. 原文陈述

> Table 7.1 The expected long-time computed average using the given second-order Langevin dynamics discretization scheme

$$
\begin{array}{c|ccc} \text{Scheme}&\langle q^2\rangle_h/\langle q^2\rangle&\langle p^2\rangle_h/\langle p^2\rangle&\langle qp\rangle\\ [ABOBA]&1&[1-h^2\Omega^2/(4m)]^{-1}&0\\ [OBABO]&[1-h^2\Omega^2/(4m)]^{-1}&1&0\\ [BAOAB]&1&1-h^2\Omega^2/(4m)&0\\ [OABAO]&1-h^2\Omega^2/(4m)&1&0 \end{array}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 scalarLift, symmetricHarmonicStep, symmetricInvariant, table71 所列对象、量词、前提和结论。范围说明：Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。
- 4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。
- 只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。
- 覆盖缺口：只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 scalarLift, symmetricHarmonicStep, symmetricInvariant, table71 所列对象、量词、前提和结论。范围说明：Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。

### 7. 状态与证明位置

- `MD.Ch07.scalarLift`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricHarmonicStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricInvariant`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.table71`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-NonsymmetricExactMoments

印刷页 277 / PDF页 298。

### 1. 原文陈述

> For example, analysis shows that the schemes denoted $[AOAB]$ or $[BAOA]$ both exhibit a first order error in the covariance $\langle qp\rangle_h=O(h)$, however they give exact results for both $\langle q^2\rangle_h$ and $\langle p^2\rangle_h$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m ∧
    (∫ x, x.1*x.2 ∂μ) = (if flip then -θ*h/2 else θ*h/2) := by
  sorry

theorem nonsymmetricMixedMoment_order (θ : ℝ) (flip : Bool) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ if flip then -θ*h/2 else θ*h/2) (fun h : ℝ ↦ h) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。
- 本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。
- 29号覆盖限定：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。flip=true 执行 AOAB（两段 A 各 h/2），false 执行 BAOA；正参数、稳定范围、L² 和不变推前下两个精确二阶矩结论合理。但是原文另外断言的 ⟨qp⟩_h=O(h) 完全未出现在结论中，尽管 extra\_assumptions 承认缺口，仍不是原文完整结论的形式化。
网站复审结论：PASS。所有概率、积分和稳定性前提均显式。MemLp二阶在概率测度下足以保证q²、p²及qp的可积性；μ的不变性使用新独立标量标准高斯。两个精确二阶矩及混合矩符号与定义的两个算法一致，Big-O声明适用于固定参数。原文将混合矩称协方差；在此非退化稳定谐振子模型中平稳一阶矩为零，表述相容。未因sorry判失败。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。

### 7. 状态与证明位置

- `MD.Ch07.nonsymmetricHarmonicStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.nonsymmetricExactMoments`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.nonsymmetricMixedMoment_order`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStar

印刷页 277–278 / PDF页 298–299。

### 1. 原文陈述

> Example 7.2 Consider the variant of the BBK integrator that recycles the random number between steps:
> Brünger-Brooks-Karplus with post-step re-use of random number (BBK*)

$$
p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,
$$



$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_{n+1}]/(1+h\gamma/2),
$$


> where $R_n$ is a vector of normal random numbers with zero mean and unit variance.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkStarTrajectory, bbkStarNoise 所列对象、量词、前提和结论。范围说明：递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkStarTrajectory, bbkStarNoise 所列对象、量词、前提和结论。范围说明：递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarTrajectory`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bbkStarNoise`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStarCorrelations

印刷页 278 / PDF页 299。

### 1. 原文陈述

> Denoting the entries of $\Psi^{\rm BBK*}$ by $\psi_{ij}$ we have

$$
\mathbb E(\mu_{n,2}p_n)=\mathbb E((\kappa_2R_n+\kappa_3R_{n+1})(\psi_{21}q_{n-1}+\psi_{22}p_{n-1}+\kappa_2R_{n-1}+\kappa_3R_n))=\kappa_2\kappa_3.
$$


> Additionally it is easily shown that

$$
\mathbb E(\mu_{n,1}q_n)=\mathbb E(\mu_{n,2}q_n)=0,\quad \mathbb E(\mu_{n,1}p_n)=\kappa_1\kappa_3,
$$


> with $\mathbb E(\mu_{n,1}^2)=\kappa_1^2$, $\mathbb E(\mu_{n,1}\mu_{n,2})=\kappa_1\kappa_2$, $\mathbb E(\mu_{n,2}^2)=\kappa_2^2+\kappa_3^2$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkStarCorrelations 所列对象、量词、前提和结论。范围说明：七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Qold/Pold代表吸收R_{n-1}后仍独立于未来R\_n,R_{n+1}的旧状态组合；不把当前p与R\_n假设独立。
- 所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkStarCorrelations 所列对象、量词、前提和结论。范围说明：七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarCorrelations`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStarMomentSystemPrinted

印刷页 278–279 / PDF页 299–300。

### 1. 原文陈述

> Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives

$$
Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+2\psi_{12}\kappa_1 2\psi_{12}\kappa_1\kappa_3+\kappa_1^2,
$$



$$
P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+2\psi_{22}\kappa_2 2\psi_{22}\kappa_2\kappa_3+\kappa_2^2+\kappa_3^2,
$$



$$
C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\kappa_1\kappa_2+\psi_{12}\kappa_2\kappa_3+\psi_{22}\kappa_1\kappa_3.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。
- 29号覆盖限定：保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。Printed 前两式忠实保留原页相邻重复因子，第三式亦一致。corrected 用条目16及(7.8)–(7.10)恢复 2bκ1κ3、2dκ2κ3，改动正确。counterexample 的实数不等式是 4≠2，正确，说明重复因子不能一般删除为恒等变形；它不是完整随机平稳模型的反例。原文版忠实性 PASS、修正版代数正确性 PASS，原书排印勘误交人工。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarMomentSystemPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.bbkStarMomentSystemPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.bbkStarExtraFactor_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStarStationary

印刷页 279 / PDF页 300。

### 1. 原文陈述

> Finally, solving the simultaneous equations gives the stationary observed averages as

$$
\langle q^2\rangle_h^{\rm BBK*}=\frac{k_BT}{\Omega^2}(1-\frac{\Omega^2h^2}{4m})^{-1},\qquad \langle p^2\rangle_h^{\rm BBK*}=k_BTm(1+\frac{\gamma h}2)^{-1},\qquad \langle qp\rangle_h^{\rm BBK*}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkStarStationaryAlgebra 所列对象、量词、前提和结论。范围说明：hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkStarStationaryAlgebra 所列对象、量词、前提和结论。范围说明：hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarStationaryAlgebra`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.5-PerturbedHamiltonian

印刷页 279 / PDF页 300。

### 1. 原文陈述

> We consider sampling canonically the Hamiltonian

$$
H(q,p)=p^2/2+q^2/2+\epsilon q^4/4,\tag{7.13}
$$


> using Langevin dynamics, where $q,p\in\mathbb R$, with a small nonlinearity parameter $\epsilon>0$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 perturbedPotential, perturbedHamiltonian, perturbedGibbs, perturbedStep, perturbedStationary 所列对象、量词、前提和结论。范围说明：势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。
- 分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 perturbedPotential, perturbedHamiltonian, perturbedGibbs, perturbedStep, perturbedStationary 所列对象、量词、前提和结论。范围说明：势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。

### 7. 状态与证明位置

- `MD.Ch07.perturbedPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedHamiltonian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedStationary`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.5-PerturbedErrorExpansion

印刷页 280 / PDF页 301。

### 1. 原文陈述

> We find that truncating the update equations to $O(\epsilon^3)$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:

$$
\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle=\frac{3h^2\epsilon[48\epsilon-4+3\gamma^2(9\epsilon-1)]}{12\gamma^2+16}+O(\epsilon h^4+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle=-\frac{9h^2\epsilon^2}{6\gamma^2+8}-\frac{3h^4\epsilon^2[6\gamma^4+19\gamma^2+16]}{8(3\gamma^2+4)^2}+O(\epsilon^2h^6+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle=h^2\left(\frac14+\frac{\epsilon[144\epsilon+81\epsilon\gamma^2-9\gamma^2-12]}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle=-h^2\left(\frac14+\frac{18\epsilon^2}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2).\tag{7.14}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | (7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。
- 实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。
- 29号覆盖限定：(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。四种 leading 和 remainder 的所有系数、正负号、幂次与(7.14)一致。positivePairLimit 是 (ε,h) 同时从正象限趋零；γ固定且为正。hinv 仅要求最终存在实际平稳 L² 概率分布；结论却给出任意该类族的统一双参数 Big-O。原页说明的是形式截断计算，未提供如此强的严格余项控制，不能以系数抄写一致批准严格定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。

### 7. 状态与证明位置

- `MD.Ch07.perturbedLeading`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.perturbedRemainder`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.positivePairLimit`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.perturbedErrorExpansion`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.5-PerturbedErrorOrders

印刷页 280 / PDF页 301。

### 1. 原文陈述

> The behavior of the methods can thus be summarized as

$$
|\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle|=O(\epsilon h^2),\qquad |\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle|=O\left(\frac{\epsilon^2h^2}{1+\gamma^2}+\epsilon^2h^4\right),
$$



$$
|\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle|=O(h^2),\qquad |\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle|=O(h^2).\tag{7.15}
$$


> The twofold surprising result though, is that (a) the leading error of the $[BAOAB]$ scheme has behavior proportional to $\epsilon^2$, while (b) the leading order term of the $[BAOAB]$ scheme is annihilated for large $\gamma$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 29号覆盖限定：固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。perturbedErrorScale 四种公式对应(7.15)，绝对值与 IsBigO 的固定 γ 正向双参数极限一致。baoabLeading\_largeFriction 只针对 -9h²ε²/(6γ²+8) 的大摩擦极限，正确；不证明完整误差关于 γ 的一致界。extra\_assumptions 中称 ε³h² 余项不足以推出固定 γ 的 ε²h²+ε²h⁴ 界不正确：ε→0 时 ε³≤ε²，且固定 γ 的 1/(1+γ²)>0 是常数。严格平稳分布渐近仍继承条目20的待确认问题。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。

### 7. 状态与证明位置

- `MD.Ch07.perturbedErrorScale`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.perturbedErrorOrders`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.baoabLeading_largeFriction`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-GibbsComposition

印刷页 282 / PDF页 303。

### 1. 原文陈述

> The flows of each of these systems individually preserves the Gibbs distribution: denoting the Fokker-Planck operators associated to these flows by $\mathcal L_H^\dagger$ and $\mathcal L_O^\dagger$ we have

$$
\mathcal L_H^\dagger\rho_\beta=0,\qquad\mathcal L_O^\dagger\rho_\beta=0,
$$


> and hence

$$
\exp(t\mathcal L_H^\dagger)\rho_\beta=\exp(t\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.
$$


> For a scheme $[HO]$, we have

$$
\exp(h\mathcal L_O^\dagger)[\exp(h\mathcal L_H^\dagger)\rho_\beta]=\exp(h\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。
- 29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。
- 覆盖缺口：29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。gibbsComposition 对任意 E、自映射 P,Q 及共同固定点 ρ 的复合固定点恒等式正确。但原文包含 H/O 的实际生成元、Gibbs 密度、两个生成元为零及其半群固定点关系；这些对象均未在本条声明出现。把两种不变性直接当作 hP,hQ 只覆盖最后一步，extra\_assumptions 的承认不补足整条结论。
网站复审结论：PASS。gibbsComposition PASS，正确形式化原页最后一步的抽象固定点论证。其hP、hQ是已给定假设，不是由H/O微分方程推得；类型E无测度或半群结构。statement\_scope和coverage\_gaps对此作了明确限制，因此只在该范围内通过，不将此定理当作H/O各自Gibbs不变性的证明。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。

### 7. 状态与证明位置

- `MD.Ch07.gibbsComposition`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-DivergenceFreeInvariant

印刷页 282 / PDF页 303。

### 1. 原文陈述

> Given any divergence free vector field $f$, we have

$$
-\nabla\cdot(f\rho)=-f\cdot\nabla\rho,
$$


> thus $\mathcal L_f^\dagger\rho=-\mathcal L_f\rho$.
> If $\mathcal L_f$ preserves a first integral $I$, then $\mathcal L_f$ preserves any distribution which is a function of $I$. It follows that any energy-preserving, divergence free vector field will always preserve the Gibbs distribution.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。
- 不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。
- 29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。
- 覆盖缺口：29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。lieField 为实际 Fréchet 导数沿 f 的作用；coordDerivative、divergenceField、forwardField 定义给出的符号和负号正确。C¹ 前提足以推出散度乘积公式；firstIntegral\_density 用 I,g 可微及第一积分零给出复合第一积分，正确。结论只到生成元为零，没有 Gibbs 密度的特化、概率归一化或全局流保持测度的陈述，因而未覆盖原文最后的分布不变结论。
网站复审结论：PASS。两个定理的对象、正则性、全称量词及负号都正确。firstIntegral\_density本身只给Lie导数为零；与前一个散度自由恒等式组合后才能得到生成元湮灭相应密度。非负、归一化和全局流存在条件在extra\_assumptions中明确另列，未被省略成无条件概率不变性。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。

### 7. 状态与证明位置

- `MD.Ch07.lieField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.divergenceField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.forwardField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.divergenceFreeInvariant`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.firstIntegral_density`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-GeMarsdenRestriction

印刷页 282 / PDF页 303。

### 1. 原文陈述

> All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。
- 辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。
- 29号覆盖限定：只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。onlyEnergyIntegrals在Fin n→ℝ上量化全部光滑第一积分，并要求全局分解I=g∘H；g没有光滑性条件。timeReparametrizes允许τ依赖步长和初值且无连续/单调/非退化条件。geMarsdenConclusion只定义“辛且保能量⇒沿给定flow轨道”，未包含onlyEnergyIntegrals，也未约束flow为H的精确流；三个定义没有连成原文限定定理，辛映射保体积亦未陈述。D3–D8的辛条件是C¹且DΦᵀJDΦ=J，含义本身正确。JSON已承认主要缺口，但原书简述的定理技术条件不能由本页确定，保留原文并交人工。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。

### 7. 状态与证明位置

- `MD.Ch07.onlyEnergyIntegrals`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.timeReparametrizes`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.geMarsdenConclusion`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-JSplitting

印刷页 282–283 / PDF页 303–304。

### 1. 原文陈述

> Let $J$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $J$ into a finite number $K$ of skew-symmetric matrices $J_i$, $i=1,\ldots,K$. This induces a splitting of the Hamiltonian vector field into $K$ vector fields $f_i=J_i\nabla H$. Each of these vector fields preserves $H$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

theorem jField_finiteDecomposition {K : ℕ} (J : Fin K → Matrix (Fin n) (Fin n) ℝ)
    (H : V n → ℝ) (hJ : ∀ k i j, J k i j = -J k j i) :
    jField (∑ k, J k) H = fun x ↦ ∑ k, jField (J k) H x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。
- 体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。
- 29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。
- 覆盖缺口：29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。jField是常矩阵乘坐标梯度；jSplitting\_energy在H∈C²、J反对称下给出每一点Lie导数为零及散度为零，符号正确。composition\_preservesEnergy对任意两个已保H的映射复合也正确。但无K族、∑Ji=J、∑fi=J∇H，没有流满足ODE及流保体积结论，也无复合流对原动力学的一致近似。散度零不等于签名已声明流保体积。extra\_assumptions说明缺口，却不补齐“本条全部对象与公式”的覆盖。
网站复审结论：PASS。所列定义与三个定理完整覆盖明示的常反对称矩阵代数、微分结论及已保能映射复合，不把散度为零直接冒称为已建立全局保体积流。有限分解定理没有将矩阵和固定为标准J，但适用于原文J=∑J\_i的代入；hJ对线性求和恒等式虽非必要，仍与原文条件一致。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。

### 7. 状态与证明位置

- `MD.Ch07.jField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.jSplitting_energy`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.composition_preservesEnergy`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.jField_finiteDecomposition`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-CoordinateJSplitting

印刷页 283 / PDF页 304。

### 1. 原文陈述

> As an example of such a $J$-splitting, we may take $K=N_c$ with each $J_i$ to be defined by the components of the canonical symplectic structure matrix having to do with the $i$th position and momentum pair, thus the equations of motion for the $i$th vector field become

$$
\dot q_i=p_i/m_i,\qquad \dot p_i=-\frac{\partial U}{\partial q_i}(\bar q_1,\ldots,\bar q_{i-1},q_i,\bar q_{i+1},\ldots,\bar q_{N_c}),
$$


> where components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)

def coordinateJQualification (m : V n) (U : V n → ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 U

theorem frozenPotential_deriv (m : V n) (U : V n → ℝ)
    (hq : coordinateJQualification m U) (q : V n) (i : Fin n) :
    deriv (frozenPotential U q i) (q i) = gradient U q i := rfl
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。
- 29号覆盖限定：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。
- 覆盖缺口：完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。Phase n=V n×V n，coordinateJField只在第i对分量非零，速度pi/mi和力−∂iU正确；frozenPotential正确使用Function.update冻结其余位置。没有mi>0或至少mi≠0以及U光滑性的物理资格，但这两个总函数定义可在更大域定义。未陈述冻结势的导数等于该力，亦没有一自由度求积可积性或流/顺序更新结论。JSON已承认求积缺口；完整所引陈述仍未覆盖。
网站复审结论：PASS。对象均为Phase n或V n，索引i:Fin n，未遗漏冻结坐标。资格命题不自动限制coordinateJField的所有调用，物理使用时需引用。Lean的结论只是冻结势的导数识别，分支、转折点、积分反演和全局流未覆盖，已披露；不因此否定当前限定范围内的正确签名。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。

### 7. 状态与证明位置

- `MD.Ch07.coordinateJField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.frozenPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.coordinateJQualification`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.frozenPotential_deriv`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7-ModifiedGenerator

印刷页 284 / PDF页 305。

### 1. 原文陈述

> We begin by defining the generator $\widehat{\mathcal L}$ associated to the propagation of averages under the numerical method for an SDE. We think of this generator as a perturbation of the exact Langevin dynamics generator $\mathcal L_{LD}$, or

$$
\widehat{\mathcal L}=\mathcal L_{LD}+h\mathcal L_1+h^2\mathcal L_2+h^3\mathcal L_3+O(h^4).\tag{7.16}
$$


> However, the operators involved are not equivalent to the operators that would arise from any stochastic differential equation (see [403]), so we must give up the direct analogy between the formal series and continuous SDE models (which is available in the deterministic setting).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def formalModifiedGenerator {R : Type*} [Ring R] [Algebra ℝ R]
    (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun k ↦ PowerSeries.coeff (k+1) (MolecularDynamics.textbookFormalOperatorLogarithm S))
def formalGeneratorExpansion {R : Type*} [Ring R] [Algebra ℝ R]
    (L : PowerSeries R) (L0 L1 L2 L3 : R) : Prop :=
  PowerSeries.coeff 0 L = L0 ∧ PowerSeries.coeff 1 L = L1 ∧
  PowerSeries.coeff 2 L = L2 ∧ PowerSeries.coeff 3 L = L3
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只取形式幂级数系数；O(h⁴)在此意为0–3阶系数相等，不宣称无界算符级数收敛，也不声称是另一SDE的生成元。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。

### 7. 状态与证明位置

- `MD.Ch07.formalModifiedGenerator`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.formalGeneratorExpansion`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7-InvariantDensityExpansion

印刷页 284 / PDF页 305。

### 1. 原文陈述

> We write this invariant distribution as a perturbation of the (target) canonical distribution

$$
\widehat\rho=\rho_\beta[1+hf_1+h^2f_2+h^3f_3+O(h^4)],\tag{7.17}
$$


> with each correction function $f_k(q,p)$ satisfying

$$
\int_{\mathcal D} f_k(q,p)\rho_\beta(q,p)d\omega=0,
$$


> ensuring a useful equivalence in the partition function

$$
\int_{\mathcal D}\widehat\rho(q,p)d\omega=\int_{\mathcal D}\rho_\beta(q,p)d\omega.
$$


> Our computed average is therefore $\langle\phi\rangle_h\stackrel{\rm def}=\int_{\mathcal D}\phi(q,p)\widehat\rho(q,p)d\omega$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion\_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 系数零质量不等于任意h的截断密度非负；概率密度仍须非负、可积且归一。余项质量也为零或完整级数可交换积分时才推出精确总质量一致。
- 此处证明所有形式系数的质量约束；未把有限截断表达式假称实际不变概率。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion\_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。

### 7. 状态与证明位置

- `MD.Ch07.densityExpansion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.centeredCorrections`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.computedAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.densityExpansion_zeroMass`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-ExactABOPropagators

印刷页 285 / PDF页 306。

### 1. 原文陈述


$$
(e^{t\mathcal L_A}\phi)(q,p)=\phi(q+tM^{-1}p,p),\qquad (e^{t\mathcal L_B}\phi)(q,p)=\phi(q,p-t\nabla U(q)),
$$



$$
(e^{t\mathcal L_O}\phi)(q,p)=\int_{\mathcal P}\phi(q,e^{-\gamma t}p+\zeta M^{1/2}x)\frac{e^{-|x|^2/2}}{(2\pi)^{N_c/2}}dx,
$$


> where $\zeta=[k_BT(1-e^{-2\gamma t})]^{1/2}$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。
- 半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。

### 7. 状态与证明位置

- `MD.Ch07.propagateA`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.propagateB`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.propagateO`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-OperatorOrderReversal

印刷页 285 / PDF页 306。

### 1. 原文陈述

> For example, for the method labelled by the string $[ABAO]$, we have

$$
\exp(h\widehat{\mathcal L}_{[ABAO]})=\exp((h/2)\mathcal L_A)\exp(h\mathcal L_B)\exp((h/2)\mathcal L_A)\exp(h\mathcal L_O),
$$


> where importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $\widehat{\mathcal L}^\dagger$, which we may compute as

$$
\exp(h\widehat{\mathcal L}_{[ABAO]}^\dagger)=\exp(h\mathcal L_O^\dagger)\exp((h/2)\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp((h/2)\mathcal L_A^\dagger).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))

theorem fourStage_duality {E : Type*} [AddCommGroup E] [Module ℝ E]
    (pair : E → E → ℝ) (A B C D a b c d : Module.End ℝ E)
    (hA : ∀ x y, pair (A x) y = pair x (a y))
    (hB : ∀ x y, pair (B x) y = pair x (b y))
    (hC : ∀ x y, pair (C x) y = pair x (c y))
    (hD : ∀ x y, pair (D x) y = pair x (d y)) (x y : E) :
    pair (A (B (C (D x)))) y = pair x (d (c (b (a y)))) := by
  rw [hA,hB,hC,hD]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。
- 伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。
- 29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。
- 覆盖缺口：29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。pullback\_order是φ∘(B∘A)=(φ∘B)∘A；结合拉回算子定义可说明顺序反转，但它本身仅为复合结合律。abaoBackward的嵌套次序和h/2系数正确。没有任何伴随对象或前向O A B A四段乘积，因而原文明确给出的第二条主等式未覆盖；extra\_assumptions只登记缺口。也未将此定义与实际离散随机映射的期望识别。
网站复审结论：PASS。后向定义、拉回等式及抽象反序对偶定理的对象和顺序正确。propagateO作为积分的总化定义对任意实参数和φ都有Lean值，但物理Markov半群解释还需适用参数、可测/可积资格；本条没有提出无条件半群识别定理。fourStage\_duality的结论完全由已给出的hA–hD推出，没有将未定义的密度伴随或无界算子域隐含为已完成。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.pullback_order`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.abaoBackward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fourStage_duality`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-StationaryModifiedPDE

印刷页 285–286 / PDF页 306–307。

### 1. 原文陈述

> Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $\rho$ is given by

$$
\frac\partial{\partial t}\rho(z,t)=\widehat{\mathcal L}^\dagger\rho,
$$


> with the important case of its invariant distribution satisfying the partial differential equation

$$
\widehat{\mathcal L}^\dagger\widehat\rho=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。
- Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。
- 29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。
- 覆盖缺口：29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。formalDensityEvolution对所有实t用HasDerivAt，且L为有界连续线性算子E→L[ℝ]E；原书Langevin/修改微分算子通常无界并需定义域，时间通常t≥0。stationaryModifiedDensity只是任意代数线性自映射的核条件，无密度资格，也未与前一个L识别。二者作为抽象定义有意义，不能据此确认原离散分布真实满足连续Fokker–Planck演化。原页把离散传播与连续方程直接联结需要形式解释或嵌入条件；JSON已提醒，须人工限定，不能静默改成普遍真实PDE。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。

### 7. 状态与证明位置

- `MD.Ch07.formalDensityEvolution`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.stationaryModifiedDensity`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-TwoOperatorBCH

印刷页 286 / PDF页 307。

### 1. 原文陈述

> Recall that for linear operators $X$ and $Y$, we can write the composition of their exponentials as

$$
\exp(hX)\exp(hY)=\exp(hZ),
$$


> where we have the expansion

$$
Z=X+Y+\frac h2[X,Y]+\frac{h^2}{12}([X,[X,Y]]+[Y,[Y,X]])+O(h^3).
$$


> The notation $[X,Y]\stackrel{\rm def}=XY-YX$ represents the commutator of the operators $X$ and $Y$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。

### 7. 状态与证明位置

- `MD.Ch07.comm`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.twoStage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.twoOperatorBCH`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-TaylorRemainder

印刷页 286–287 / PDF页 307–308。

### 1. 原文陈述

> We can make use of Taylor’s theorem to write the identity

$$
P_h=P_0+h\left.\frac{dP_t}{dt}\right|_{t=0}+\cdots+\frac{h^n}{n!}\left.\frac{d^nP_t}{dt^n}\right|_{t=0} +\frac{h^{n+1}}{n!}\int_0^1(1-\lambda)^n\left.\frac{d^{n+1}P_t}{dt^{n+1}}\right|_{t=\lambda h}d\lambda,
$$


> for some finite truncation index $n\in\{1,2,3,\ldots\}$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

theorem propagatedObservable_remainder {E : Type*} (P : ℝ → (E → ℝ) → E → ℝ)
    (φ : E → ℝ) (z : E) (k : ℕ)
    (htime : ContDiff ℝ (k+1) (fun t ↦ P t φ z)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ P h φ z-∑ j ∈ Finset.range (k+1),
        h^j/(Nat.factorial j : ℝ)*iteratedDeriv j (fun t ↦ P t φ z) 0)
      (fun h ↦ h^(k+1)) := taylorRemainder_bound _ k htime
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。
- 29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。
- 覆盖缺口：29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。taylorRemainder对标量F∈C^(k+1)、所有实h给出正确积分余项，k∈ℕ还合法扩展到0阶。taylorRemainder\_bound是h→0的标量局部O(h^(k+1))，正确但其常数可依赖F。没有P\_t作用在紧支撑可观测量后满足这些假设的桥，也无相空间/算子范数意义下的余项界；不能把逐点标量结论作为原文算子/观测量余项资格的完整审校通过。extra\_assumptions已承认范围缩减。
网站复审结论：PASS。三个声明量化所有k:ℕ；原文n≥1的情形包含其中，额外k=0情形合法。最后一个结论对给定φ,z成立，Big-O常数可依赖它们；并不提供对空间点或测试函数族的统一控制。P是任意时间算子族而不是已识别的ABO半群，htime没有被悄然由紧支撑推得；与明示限定范围一致。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。

### 7. 状态与证明位置

- `MD.Ch07.taylorRemainder`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.taylorRemainder_bound`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.propagatedObservable_remainder`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-ThreeOperatorBCH

印刷页 287 / PDF页 308。

### 1. 原文陈述


$$
\exp(hS)=\exp(hZ)\exp(hY)\exp(hX).\tag{7.18}
$$



$$
S=X+Y+Z+\frac h2([Z,Y]+[Z,X]+[Y,X])+\frac{h^2}{4}[Z,Y,X] +\frac{h^2}{12}([Y,Y,X]+[X,X,Y]+[Z,Z,Y]+[Z,Z,X]+[Y+X,Y+X,Z])+\cdots
$$


> where the notation $[A,B,C]$ is notation for $[A,[B,C]]$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。

### 7. 状态与证明位置

- `MD.Ch07.threeStage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.threeOperatorBCH`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-ScalarForwardOperators

印刷页 288 / PDF页 309。

### 1. 原文陈述

> In this one dimensional example, we substitute

$$
Z=\mathcal L_A^\dagger=-p\frac\partial{\partial q},\quad Y=\mathcal L_B^\dagger=U'(q)\frac\partial{\partial p},\quad X=\mathcal L_O^\dagger=\gamma\left({\rm Id}+p\frac\partial{\partial p}\right)+\frac{\sigma^2}{2}\frac{\partial^2}{\partial p^2},
$$


> where $\sigma=\sqrt{2\gamma k_BT}$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 所有偏导都是实际deriv，单位质量、θ=k\_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。

### 7. 状态与证明位置

- `MD.Ch07.Density1`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.dq`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.dp`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opA`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opB`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opO`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opLD`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opComm`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-CommutatorAB

印刷页 288 / PDF页 309。

### 1. 原文陈述


$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-p\frac\partial{\partial q}\left(U'(q)\frac{\partial\rho}{\partial p}\right)-U'(q)\frac\partial{\partial p}\left(-p\frac{\partial\rho}{\partial q}\right) =-pU''(q)\rho_p-pU'(q)\rho_{pq}+U'(q)\rho_q+U'(q)p\rho_{qp}.
$$


> As this is the commutator of two 1st order differential operators, the mixed partial term vanishes, leaving

$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-pU''(q)\rho_p+U'(q)\rho_q.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。

### 7. 状态与证明位置

- `MD.Ch07.commutatorAB`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-CommutatorsAOBO

印刷页 289 / PDF页 310。

### 1. 原文陈述

> Similar computations give

$$
[\mathcal L_A^\dagger,\mathcal L_O^\dagger]\rho=\gamma p\rho_q+\sigma^2\rho_{qp},\qquad [\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho=\gamma U'(q)\rho_p.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。

### 7. 状态与证明位置

- `MD.Ch07.commutatorsAOBO`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-OBAModifiedOperator

印刷页 288–289 / PDF页 309–310。

### 1. 原文陈述


$$
\exp(h\widehat{\mathcal L}_{[OBA]}^\dagger)=\exp(h\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp(h\mathcal L_O^\dagger).
$$



$$
\widehat{\mathcal L}_{[OBA]}^\dagger\rho=\mathcal L_{LD}^\dagger\rho+\frac h2[-pU''(q)\rho_p+U'(q)\rho_q+\gamma p\rho_q+\sigma^2\rho_{qp}+\gamma U'(q)\rho_p]+O(h^2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。
- 29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。
- 覆盖缺口：29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。obaFirstCorrection以θ替代kBT，五项各乘1/2，正确。obaFirstCorrection\_commutators在C³下仅证明此表达式等于三个实际交换子之和的一半，完全正确。但没有OBA前向乘积对象、log/h系数、LLD零阶或余项陈述，未把该函数认定为数值方案修改生成元的一阶系数。extra\_assumptions承认该桥未做，因而完整两条原式的覆盖仍FAIL；不是因sorry或证明状态。
网站复审结论：PASS。单位质量的一维设定下，θ=k\_BT给σ²=2γθ，五个导数项的符号和系数全部一致。U、ρ的C³资格足以展开三项真实交换子和交换混合偏导；γ、θ无需正性即可成立该纯微分代数恒等式。公式中的O(h²)属于源文的形式修改生成元展开，当前Lean并无关于h、乘积对数或余项范数的结论，且已准确披露。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。

### 7. 状态与证明位置

- `MD.Ch07.obaFirstCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obaFirstCorrection_commutators`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-SpectralQualification

印刷页 289 / PDF页 310。

### 1. 原文陈述

> The assumption of validity becomes more credible as we find that the operator $\mathcal L_{LD}^\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\rho_\beta$ and all the remaining eigenvalues lie in the negative half plane.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)

def spectralConclusionPrinted {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop := printedSpectralConclusion L ρ

def spectralConclusionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧
  (∀ v : E, L v = 0 → v ∈ Submodule.span ℂ ({ρ} : Set E)) ∧
  ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    FiniteDimensional ℂ (Module.End.eigenspace L eigen) ∧ (eigen = 0 ∨ eigen.re < 0)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
- 29号覆盖限定：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。
- 覆盖缺口：只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。分别审校：simpleEigenvalue定义的是特征空间维数1（几何单重），不是通常谱论的代数单重。printedSpectralConclusion及spectralConclusionPrinted忠实保留“所有特征值单重、0对应ρ、其他实部负”的点谱目标，但没有紧预解式或完整谱的对象，也没有代数重数。_corrected把所有特征空间改为有限维，改掉“离散⇒单重”的错误方向是合理的；然而同时删掉零特征值应为唯一不变密度方向的约束，且有限维几何特征空间不等同于离散谱及有限代数重数。它只是较弱目标谓词，不是已得到的Langevin谱定理，也不是完整修正。由于原书错误及应保留哪些额外结论需人工决定，总判NEEDS\_HUMAN。
网站复审结论：NEEDS\_HUMAN。按已披露的范围，三个Printed/别名定义忠实记录原文的“点谱、几何单重”部分，corrected是较弱的点谱候选而不是已经证明的结论。原文“离散谱即单重谱”是实质数学疑误；此外几何单重不能代替代数单重，完整的原书谱论含义仍需人工选定，因此整体NEEDS\_HUMAN，不将源文错误隐改后判PASS。
按版本登记：网站仅认可已披露的点谱/几何单重定义；corrected仍是较弱候选Prop，未获完整紧预解式谱定理的PASS，不计为修正版定理通过。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。

### 7. 状态与证明位置

- `MD.Ch07.simpleEigenvalue`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.printedSpectralConclusion`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spectralConclusionPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spectralConclusionPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.3-PerturbationCoefficientEquation

印刷页 289–290 / PDF页 310–311。

### 1. 原文陈述

> Inserting this ansatz into the stationary Fokker-Planck equation $\widehat{\mathcal L}^\dagger\widehat\rho=0$, we obtain

$$
(\mathcal L_{LD}^\dagger+h\mathcal L_1^\dagger+h^2\mathcal L_2^\dagger+O(h^3))(\rho_\beta[1+hf_1+h^2f_2+O(h^3)])=0.
$$


> Combining like powers, we have at zero’th order, the equation $\mathcal L_{LD}^\dagger\rho_\beta=0$.
> At first order we obtain

$$
\mathcal L_{LD}^\dagger(\rho_\beta f_1)+\mathcal L_1^\dagger\rho_\beta=0.\tag{7.19}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 actionCoefficient, perturbationCoefficientEquation 所列对象、量词、前提和结论。范围说明：actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 在真实线性作用的形式系数卷积上推导0阶和1阶必要方程；并未由这些必要方程证明原离散链存在不变分布。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 actionCoefficient, perturbationCoefficientEquation 所列对象、量词、前提和结论。范围说明：actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。

### 7. 状态与证明位置

- `MD.Ch07.actionCoefficient`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbationCoefficientEquation`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.3-ObservableCorrectionExpansion

印刷页 290 / PDF页 311。

### 1. 原文陈述

> For some observable $\vartheta(q,p)$, we have that

$$
\langle\vartheta\rangle_h=\int_{\mathcal D}\vartheta(q,p)\widehat\rho(q,p)d\omega =\int_{\mathcal D}\vartheta(q,p)\rho_\beta(q,p)(1+hf_1(q,p)+h^2f_2(q,p)+\cdots)d\omega =\langle\vartheta\rangle+h\langle\vartheta f_1\rangle+h^2\langle\vartheta f_2\rangle+\cdots.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 observableCorrectionExpansion 所列对象、量词、前提和结论。范围说明：observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra\_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整覆盖0–2阶有限截断积分；无限级数交换与实际误差余项仍需支配收敛及弱展开理论，明确不声称已证。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra\_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 observableCorrectionExpansion 所列对象、量词、前提和结论。范围说明：observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra\_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。

### 7. 状态与证明位置

- `MD.Ch07.observableCorrectionExpansion`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.3-PerturbativeSolvabilityCaution

印刷页 290 / PDF页 311。

### 1. 原文陈述

> It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $\mathcal L_{LD}^\dagger$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def correctionSolvable {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (rhs : E) : Prop := ∃ u : E, L u = rhs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。
- 不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。
- 29号覆盖限定：仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。correctionSolvable是任意实模线性自映射L下rhs属于range(L)的命题，数学含义正确。但没有ρβf1结构、零质量归一条件、Fredholm相容性、紧预解式/定义域、指数稳定或全局半群存在。JSON明确只登记目标，不证明预期；原书也明确未给严格结果，必须保留并NEEDS\_HUMAN，不能把紧预解式及有界扰动升级为无条件可解性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。

### 7. 状态与证明位置

- `MD.Ch07.correctionSolvable`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8-FirstOrderOperator

印刷页 291 / PDF页 312。

### 1. 原文陈述

> By composing the semigroup operators

$$
\exp(h\widehat{\mathcal L}_{[XYZ]}^\dagger)=\exp(h\mathcal L_Z^\dagger)\exp(h\mathcal L_Y^\dagger)\exp(h\mathcal L_X^\dagger),
$$


> and computing the terms in the BCH expansion, we have

$$
\widehat{\mathcal L}_{[XYZ]}^\dagger=\mathcal L_{LD}^\dagger+h\mathcal L_{1,[XYZ]}^\dagger+O(h^2),
$$


> where

$$
\mathcal L_{1,[XYZ]}^\dagger=-\frac12([\mathcal L_X^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_X^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]).\tag{7.20}
$$


> The first order correction function for this scheme is then given by the particular solution to the PDE,

$$
\mathcal L_{LD}^\dagger(f_{1,[XYZ]}\rho_\beta)=-\mathcal L_{1,[XYZ]}^\dagger\rho_\beta.\tag{7.21}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def firstOrderOperator {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : R :=
  (-1/2 : ℝ) • (comm X Y+comm X Z+comm Y Z)
theorem firstOrderOperator_coefficient {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) = firstOrderOperator X Y Z := by
  sorry
def correctionEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L L1 : Module.End ℝ E) (ρ ρf : E) : Prop := L ρf = -L1 ρ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 firstOrderOperator, firstOrderOperator\_coefficient, correctionEquation 所列对象、量词、前提和结论。范围说明：C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator\_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 前向组合采用Z,Y,X顺序；正式级数系数推论覆盖所有六个排列，L0为三者和。修正方程为必要形式方程，可解性独立。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator\_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 firstOrderOperator, firstOrderOperator\_coefficient, correctionEquation 所列对象、量词、前提和结论。范围说明：C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator\_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。

### 7. 状态与证明位置

- `MD.Ch07.firstOrderOperator`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstOrderOperator_coefficient`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.correctionEquation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8-HomogeneousNormalization

印刷页 291 / PDF页 312。

### 1. 原文陈述

> The general solution of (7.21) will consist of the sum of the homogeneous solution $f_{1,[XYZ]}^{[HS]}(q,p)$ and particular solution $f_{1,[XYZ]}^{[PS]}(q,p)$ in the usual way. However, since $\mathcal L_{LD}^\dagger\vartheta=0$ has as its only solution $\vartheta\propto\rho_\beta$, the homogeneous solution of (7.21) is $f_{1,[XYZ]}^{[HS]}(q,p)=c$, for some constant $c$. Our assumption that $\langle f_{1,[XYZ]}\rangle=0$ means that $c=-\langle f_{1,[XYZ]}^{[PS]}\rangle$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 homogeneousNormalization, centeredParticular 所列对象、量词、前提和结论。范围说明：C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 核恰为ρ的一维空间是明确前提；不把Langevin核唯一性当作已证明。第二条为实际概率归一化的中心化恒等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 homogeneousNormalization, centeredParticular 所列对象、量词、前提和结论。范围说明：C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。

### 7. 状态与证明位置

- `MD.Ch07.homogeneousNormalization`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.centeredParticular`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-CommutatorPermutationRelations

印刷页 292 / PDF页 313。

### 1. 原文陈述


$$
([\mathcal L_O^\dagger,\mathcal L_A^\dagger]+[\mathcal L_O^\dagger,\mathcal L_B^\dagger])\rho_\beta=[\mathcal L_O^\dagger,\mathcal L_A^\dagger+\mathcal L_B^\dagger]\rho_\beta=0.
$$



$$
\mathcal L_{1,[ABO]}^\dagger\rho_\beta=\mathcal L_{1,[OAB]}^\dagger\rho_\beta=-\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\mathcal L_{1,[BAO]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta.\tag{7.22}
$$



$$
f_{1,[ABO]}=f_{1,[OAB]}=-f_{1,[OBA]}=-f_{1,[BAO]}.\tag{7.23}
$$



$$
\mathcal L_{1,[AOB]}^\dagger\rho_\beta=-\mathcal L_{1,[BOA]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger-\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho_\beta+\mathcal L_{1,[ABO]}^\dagger\rho_\beta.\tag{7.24}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。
- 29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。
- 覆盖缺口：实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。
- 覆盖缺口：29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：现有commutatorPermutationRelations的七个结论在Oρ=0和(A+B)ρ=0下均正确；实模、线性自同态与ρ的量词没有错误，交换子按复合定义。FAIL仅针对本条完整原文结论的覆盖：没有从相同PDE右端推出零均值解相等及相反的桥接定理。不能以“需要唯一性”为由把(7.23)当作已核对通过。
网站复审结论：PASS。七项结论为在两项明确湮灭条件下的真实线性算子代数恒等式，所有ρ和算子量词均保留；并未把它写成只对标量常数成立的替身。所用A,B,O是抽象算子，不自动等同实际Gibbs微分算子；源文(7.23)的解函数关系也没有被仅凭右端相等就冒称已证明。上述范围限制均有明示。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。

### 7. 状态与证明位置

- `MD.Ch07.commutatorPermutationRelations`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-GibbsDerivativeIdentities

印刷页 292–293 / PDF页 313–314。

### 1. 原文陈述

> If we define the function $g(q,p)$ as $g(q,p)=\beta p^TM^{-1}\nabla U(q)$, then through simple computation we have

$$
\mathcal L_A^\dagger\rho_\beta=-\mathcal L_B^\dagger\rho_\beta=g(q,p)\rho_\beta.
$$



$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=-(\mathcal L_A^\dagger+\mathcal L_B^\dagger)(g\rho_\beta)=(\mathcal L_O^\dagger-\mathcal L_{LD}^\dagger)(g\rho_\beta).
$$


> For a function $\psi(q)$ purely of position, we have

$$
\mathcal L_{LD}^\dagger(\psi(q)\rho_\beta)=-(p^TM^{-1}\nabla\psi(q))\rho_\beta(q,p),
$$


> and hence we can compute

$$
\mathcal L_O^\dagger(g(q,p)\rho_\beta)=\gamma\rho_\beta(-p\cdot\nabla_pg+\beta^{-1}\nabla_p\cdot M\nabla_pg) =-\gamma g\rho_\beta=\gamma\beta\mathcal L_{LD}^\dagger(U(q)\rho_\beta).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- ρ为未归一Gibbs权，所有微分等式对常数归一化同样成立；实际概率还要正有限配分积分。所有质量正、β>0、光滑资格明示。
- 覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。
- 29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。
- 覆盖缺口：29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：现有五项结论在m\_i>0、β>0、U和ψ光滑的全称量词下均正确；γ任意实数不影响这些代数微分恒等式。未归一权与归一密度只差常数，额外资格明确。FAIL源于原文含有但Lean未陈述的交换子等式及OU中间公式，非sorry问题。
网站复审结论：PASS。全部质量和β的非退化条件明确，C∞资格足以处理全部实际导数；γ的正性对这些代数微分恒等式非必要。Lean函数乘法g*ρ为逐点乘法，与源文相符。原段交换子及OU中间式仍为覆盖缺口，不因恢复源文中间项而宣称已由这五个结论形式化；配分积分的正有限性也不在本条结论中。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。

### 7. 状态与证明位置

- `MD.Ch07.mechanicalHamiltonian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.gibbsWeight`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.gFunction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.phaseO`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.phaseLD`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.gibbsDerivativeIdentities`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-FirstCorrectionTablePrinted

印刷页 293–294 / PDF页 314–315。

### 1. 原文陈述

> In summary, we find that

$$
f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25a}
$$



$$
f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25b}
$$



$$
f_{1,[AOB]}(q,p)=-\frac\beta2(\gamma U(q)+p^TM^{-1}\nabla U(q)-c),\tag{7.25c}
$$



$$
f_{1,[BOA]}(q,p)=\frac\beta2(\gamma U(q)+p^TM^{-1}\nabla U(q)-c),\tag{7.25d}
$$


> where the constant $c$ is chosen to ensure each correction function has average 0, giving $c=\gamma\langle U(q)\rangle$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 then -β/2*(γ*U x.1-v-c)
  else if s = 4 then -β/2*(γ*U x.1+v-c)
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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。
- 29号覆盖限定：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。
- PDF314–315已目视核对原页：(7.25c)括号内为+v；旧负号是转录错误，撤销原书疑误。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C分项：Printed定义FAIL（s=4字面符号错误）；_corrected定义PASS（其数学公式就是PDF字面正确式）；firstCorrection\_sign\_counterexample的实数不等式PASS，但仅说明错误转写与正确转写不等；phaseComm与firstCorrectionRHS PASS；firstCorrectionTable\_pde的正质量、正β、光滑U、任意常数c下的全部六个PDE签名PASS。汇总FAIL因为Printed不忠实且完整零均值结论缺失。不能把本条问题归为原书勘误。
网站复审结论：PASS。六个排列的完整分支、PDE及其所有前提与结论均正确。Printed与corrected当前完全相同，原书正号应保留；数值不等式本身成立，但其用途限于说明旧误录。任意常数c的PDE不等于已实现平均为零：后者需存在归一Gibbs概率、U和v可积及动量奇性消去后，才能取c=γ〈U〉。本条仅修补覆盖元数据，不改Lean。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。

### 7. 状态与证明位置

- `MD.Ch07.firstCorrectionTablePrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrectionTablePrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrection_sign_counterexample`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.phaseComm`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrectionRHS`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrectionTable_pde`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-PositionMomentumCorrections

印刷页 294–295 / PDF页 315–316。

### 1. 原文陈述

> If $\vartheta=\vartheta_1(p)$ then this $O(\gamma)$ term will not trouble us, as

$$
\langle\vartheta_1(p)f_1(q,p)\rangle=\pm\frac\beta2\langle(\gamma U(q)-c)\vartheta_1(p)\pm p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle =\pm\frac\beta2\langle p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle.
$$


> However, if we instead set $\vartheta=\vartheta_2(q)$, then

$$
\langle\vartheta_2(q)f_1(q,p)\rangle=\pm\frac{\gamma\beta}{2}\langle(U(q)-\langle U(q)\rangle)\vartheta_2(q)\rangle.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 positionGibbs, momentumGibbs, productGibbs, positionMomentumCorrections 所列对象、量词、前提和结论。范围说明：C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m\_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 产品Gibbs实际含位置概率及独立中心Gaussian动量；所有显示期望需可积，未把待求修正值作为假设。
- 六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。
- 覆盖缺口：六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m\_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 positionGibbs, momentumGibbs, productGibbs, positionMomentumCorrections 所列对象、量词、前提和结论。范围说明：C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m\_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。

### 7. 状态与证明位置

- `MD.Ch07.positionGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.productGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.positionMomentumCorrections`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-OverdampedFirstOrderCaution

印刷页 295 / PDF页 316。

### 1. 原文陈述

> When considering the limit of infinite friction in the $[XYZ]$ schemes we obtain an inconsistent discretization. Hence these first-order schemes will be unsuitable for the integration of overdamped Langevin dynamics.
> This is not always the case for first order schemes, however. For example the scheme denoted $[AOAB]$ is consistent with the dynamics, and may be used for integrating the overdamped ($\gamma=\infty$) Langevin equation.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
    Filter.Tendsto (fun γ : ℝ ↦ aoab m U γ θ h R x) Filter.atTop (𝓝 (aoabInfiniteFriction m U θ h R x)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。
- 29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。
- 覆盖缺口：29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：aoab、aoabInfiniteFriction、aoabFrictionLimit彼此匹配；h>0确保指数衰减，U为C¹保证最终kick中梯度连续，θ>0明示。m没有正性前提，但作为Lean全定义实函数的单步极限仍成立，不能据此把任意m解释为物理质量。该极限定理本身PASS。完整原文断言的汇总FAIL，因为单步噪声替换极限不能替代对过阻尼SDE的一致性，更没有陈述六种XYZ的否定结论。
网站复审结论：PASS。AOAB两段A各h/2、O与B各h，完整映射、极限映射和Tendsto方向均正确。所有参数在极限中固定，仅γ变化；正时间保证exp(−γh)趋零，正质量/温度给出原物理噪声幅度，C¹势足以使梯度连续。结论只覆盖已声明的逐路径单步极限，不能据此宣告原文六种XYZ判断和AOAB有效时标一致性已形式化。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.aoab`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aoabInfiniteFriction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aoabFrictionLimit`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.2-BiasedDoubleWellExact

印刷页 295–297 / PDF页 316–318。

### 1. 原文陈述

> Let $M=\beta=1$ and define the biased double-well potential as

$$
U(q)=(q^2-1)^2+q/2.
$$


> We choose the observable

$$
\vartheta(q,p)=p^2-qU'(q)+2qp,\qquad\langle\vartheta\rangle=0.
$$


> The first order correction term for the $[BOA]$ scheme is given by the formula

$$
\langle\vartheta f_{1,[BOA]}\rangle=\frac\beta2\int_{\mathcal D}(p^2-qU'(q)+2qp)(pU'(q)+\gamma U(q)-c)\rho_\beta d\omega =\frac1\beta+\frac\gamma2\langle U\rangle-\frac{\gamma\beta}{2}\langle qUU'\rangle=\frac{2-\gamma}{2\beta}.
$$


> Hence for the critical value of $\gamma=2$, the leading order correction will be zero, giving

$$
\langle\vartheta\rangle_h^{[BOA]}=\langle\vartheta\rangle+O(h^2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

theorem doubleWellCritical_integral (β : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β 2 x ∂doubleWellGibbs β) = 0 := by
  simpa using (doubleWellExact β 2 hβ).2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 保留数值例中的精确数学积分和解析消项；原文虽起初β=1，推导中保留β，本条正β形式需同样积分分部理论。
- 中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。
- 29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。
- 覆盖缺口：29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：biasedDoubleWell、doubleWellObservable、doubleWellGibbs、doubleWellBOACorrection全部正确，密度以整个ℝ²积分归一且c=γ〈U〉。doubleWellExact的两个结论在β>0、γ任意下正确；没有把目标积分当作前提。doubleWellCritical代数等式虽对所有β成立，却未把β>0和doubleWellExact连接成积分消项推论。原文最后声称的真实算法平均O(h²)需要离散不变平均、h→0及弱展开余项，这些对象均不存在；因此完整覆盖FAIL。
网站复审结论：PASS。对象是ℝ×ℝ，q=x.1、p=x.2；Gibbs权为exp[−β(p²/2+U)]，以全相空间积分归一。修正中的中心常数γ∫U与〈ϑ〉=0相容。doubleWellExact全称β,γ∈ℝ并假设β>0，给出两个实际积分的合取；对任意实γ仍成立。分部积分给〈qU′〉=1/β、〈qUU′〉=〈U〉/β+1/β²，独立Gaussian给〈p²〉=1/β，故完整结果(2−γ)/(2β)正确。doubleWellCritical仅实数代数式，β=0亦按总化除法成立；integral推论确实接到Exact的第二分量。任意β>0是[EXTRA]推广，未覆盖真实算法O(h²)和中间积分链已如实声明。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.biasedDoubleWell`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellBOACorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellExact`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellCritical`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellCritical_integral`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9-Proposition71

印刷页 297 / PDF页 318。

### 1. 原文陈述

> Proposition 7.1 Let $\mathcal L_X^\dagger$, $\mathcal L_Y^\dagger$ and $\mathcal L_Z^\dagger$ be general operators to which BCH can be applied, then defining

$$
e^{h\widehat{\mathcal L}^\dagger}=e^{\frac h2\mathcal L_X^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{h\mathcal L_Z^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{\frac h2\mathcal L_X^\dagger},\tag{7.26}
$$


> gives $\widehat{\mathcal L}^\dagger=\mathcal L_0^\dagger+h^2\mathcal L_2^\dagger+O(h^4)$, where

$$
\mathcal L_0^\dagger=\mathcal L_X^\dagger+\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,
$$



$$
\mathcal L_2^\dagger=\frac1{12}([\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_X^\dagger]) -\frac1{24}([\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_X^\dagger,\mathcal L_X^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger]).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 proposition71, symmetricOddCorrections 所列对象、量词、前提和结论。范围说明：C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 proposition71, symmetricOddCorrections 所列对象、量词、前提和结论。范围说明：C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。

### 7. 状态与证明位置

- `MD.Ch07.proposition71`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricOddCorrections`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9-EvenDensityPerturbation

印刷页 298 / PDF页 319。

### 1. 原文陈述

> If we suppose that the odd order correction functions are zero, then we are left with

$$
\widehat\rho=\rho_\beta(1+h^2f_2+h^4f_4+\cdots),\tag{7.27}
$$


> where each $\langle f_i\rangle=0$ as usual. Equating the second order terms we obtain

$$
\mathcal L_{LD}^\dagger(\rho_\beta f_2)=-\mathcal L_2^\dagger\rho_\beta.\tag{7.28}
$$


> The condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $\mathcal L_2^\dagger\rho_\beta$ integrates to zero.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。
- 29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。
- 覆盖缺口：29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：evenDensityExpansion在k=0给ρ，在正偶数k给ρ f\_k，奇数k给零，定义正确。evenPerturbationEquation在任意实模上正确，hL1与hρ1同时列出虽可弱化但不造成错误。FAIL是完整原文覆盖不足：所有修正项的零均值缺失，且未陈述在适当域/边界下由方程导出的∫L2ρ=0。Fredholm可解性需函数空间、核/余核及算符域，原文并未提供足以在任意空间中采信的充分性框架；这里不能声称已证明Fredholm结论。
网站复审结论：PASS。evenDensityExpansion在k=0取ρ、正偶数取ρ·f k、奇数取零。actionCoefficient的和域是j=0,…,k；k=2恰为L₀ρ₂+L₁ρ₁+L₂ρ₀。在线性ℝ模上hL1、hρ1、h2足以推出L₀ρ₂=−L₂ρ₀，无遗漏负号；hL1与hρ1可冗余但不使结论错误。E是局部任意模，不应误识为附列Chapter05Review.E。零均值、Fredholm资格和可解性明确不在覆盖范围。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.evenDensityExpansion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.evenPerturbationEquation`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-OYZYOInhomogeneity

印刷页 298–299 / PDF页 319–320。

### 1. 原文陈述

> For methods $[OYZYO]$, substituting $\mathcal L_X^\dagger=\mathcal L_O^\dagger$, $\mathcal L_Y^\dagger+\mathcal L_Z^\dagger=\mathcal L_A^\dagger+\mathcal L_B^\dagger=\mathcal L_H^\dagger$ simplifies the computation to

$$
\mathcal L_{2,[OYZYO]}^\dagger\rho_\beta=\frac1{12}[\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]\rho_\beta-\frac1{24}[\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]\rho_\beta.\tag{7.29}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 oyzyoInhomogeneity 所列对象、量词、前提和结论。范围说明：C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 oyzyoInhomogeneity 所列对象、量词、前提和结论。范围说明：C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。

### 7. 状态与证明位置

- `MD.Ch07.oyzyoInhomogeneity`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-TripleCommutatorPrinted

印刷页 299 / PDF页 320。

### 1. 原文陈述


$$
[\mathcal L_A^\dagger,\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=(2\beta p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,
$$



$$
[\mathcal L_B^\dagger,\mathcal L_B^\dagger,\mathcal L_A^\dagger]\rho_\beta=-(2\beta p^T(\nabla^2U)\nabla U)\rho_\beta.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。
- 29号覆盖限定：字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C分项：hessianU、thirdU、hessianGrad、cubicThird的对象、域与求和指标正确；tripleCommutatorPrinted作为字面表达式PASS；_corrected以及其实际双重phaseComm定理在β>0、光滑U、单位质量下PASS。factor\_counterexample的代数断言PASS但并未声称构造势函数。原书首式缺β是真正的数学疑误，按任务要求保留原文并汇总NEEDS\_HUMAN；不能因修正版正确就把字面原书公式判为数学定理通过。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。

### 7. 状态与证明位置

- `MD.Ch07.hessianU`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.thirdU`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hessianGrad`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.cubicThird`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutatorPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutatorPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutator_corrected`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutator_factor_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-SymmetricRHS

印刷页 299 / PDF页 320。

### 1. 原文陈述


$$
\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OABAO]})=\frac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,
$$



$$
\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OBABO]})=\frac\beta{24}(2\nabla^3U:p\otimes p\otimes p-6p^T(\nabla^2U)\nabla U)\rho_\beta.
$$


> We can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $p$, and hence will average to 0.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。
- 29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。
- 覆盖缺口：29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C分项：symmetricRHS的两种标量多项式PASS；odd对所有flip,U,β,x成立，PASS；zeroMean带可积性时PASS。完整原文覆盖FAIL：未将多项式乘Gibbs权识别为−L2ρ或LD(ρf2)，也未建立真实原页积分和productGibbs积分的正有限归一化桥。奇性与零均值不构成给定闭算符的Fredholm替代定理。A中的原书充分性措辞另外判NEEDS\_HUMAN，保留而不篡改。
网站复审结论：NEEDS\_HUMAN。V n=Fin n→ℝ、Phase n=V n×V n；Hessian/三阶张量按附录D3–D11真实坐标导数定义。flip=false对应OABAO、true对应OBABO；β/24及张量收缩正确。odd声明对全部U、β和x成立，代数奇性无需正则性。zeroMean只加实际productGibbs的可积性，Gaussian动量反射不变足够；即使β≤0发生退化也仍对称，故无须据此判缺β>0。没有断言其为归一概率或完整PDE/Fredholm充分可解性；原书的后者存在函数空间资格疑点。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：所列函数、奇性及零积分签名PASS；零均值只是必要兼容条件，函数空间、算子域与核/余核资格仍待确认。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.symmetricRHS`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricRHS_odd`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricRHS_zeroMean`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-Lemma71

印刷页 299–300 / PDF页 320–321。

### 1. 原文陈述

> Lemma 7.1 Consider two numerical schemes with associated operators governing the evolution of measure $ST$ and $TS$, with unique associated invariant distributions $\widehat\rho_{ST}$ and $\widehat\rho_{TS}$ respectively, such that

$$
ST\widehat\rho_{ST}=\widehat\rho_{ST},\qquad TS\widehat\rho_{TS}=\widehat\rho_{TS}.
$$


> Under suitable ergodicity assumptions (such that in the long-time limit, all distributions converge to the invariant distribution), we have

$$
\widehat\rho_{ST}=S\widehat\rho_{TS},\qquad\widehat\rho_{TS}=T\widehat\rho_{ST}.
$$



### 2. 原文证明

> If we assume that $\lim_{n\to\infty}(ST)^n\rho=\widehat\rho_{ST}$, for any initial distribution $\rho$, then we have
> $\widehat\rho_{ST}=\lim_{n\to\infty}(ST)^n\widehat\rho_{ST}=\lim_{n\to\infty}S(TS)^{n-1}T\widehat\rho_{ST}=S\widehat\rho_{TS}$.
> A similar statement holds for $\widehat\rho_{ST}$.

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 lemma71 所列对象、量词、前提和结论。范围说明：C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 lemma71 所列对象、量词、前提和结论。范围说明：C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。

### 7. 状态与证明位置

- `MD.Ch07.lemma71`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-ConjugateSymmetricCorrections

印刷页 300–301 / PDF页 321–322。

### 1. 原文陈述


$$
\widehat\rho_{[ZYOYZ]}=\exp((h/2)\mathcal L_Z^\dagger)\exp((h/2)\mathcal L_Y^\dagger)\exp((h/2)\mathcal L_O^\dagger)\widehat\rho_{[OYZYO]}.
$$



$$
f_{2,[ZYOYZ]}\rho_\beta=f_{2,[OYZYO]}\rho_\beta+\tfrac14\mathcal L_{1,[OYZ]}^\dagger\rho_\beta.
$$



$$
\mathcal L_{1,[OAB]}^\dagger\rho_\beta=\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\qquad \mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\tfrac12\mathcal L_H^\dagger(g\rho_\beta),
$$



$$
\mathcal L_H^\dagger(g\rho_\beta)=\beta(|\nabla U|^2-p^T\nabla^2Up)\rho_\beta,
$$



$$
f_{2,[ABOBA]}=f_{2,[OBABO]}-\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up),\tag{7.30a}
$$



$$
f_{2,[BAOAB]}=f_{2,[OABAO]}+\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up).\tag{7.30b}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

def conjugateExpansionPrinted {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/2) • L0

def conjugateExpansionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/8) • (L0*L0)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。
- 29号覆盖限定：两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。
- 覆盖缺口：Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：V n=Fin n→ℝ，Phase n为位置/动量对；梯度、Hessian及pᵀHess(U)p的下标收缩正确，conjugateCorrections完整记录两条函数等式。coefficient对任意实模E及线性自同态L0,L1量化，在L0(p0)=0、p1=0和明确的二阶传递假设下消项正确。[EXTRA]这些是假设的系数，不是具体分裂传播子的系数识别；ρβ、具体ST/TS不变分布传递及Hamiltonian微分恒等式没有相应完整声明。Printed逐字保留原印，忠实性PASS；_corrected的1/8及平方修正合理，作为二阶截断定义PASS，不能当作完整指数等式。因原印疑误本条综合NEEDS\_HUMAN。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。

### 7. 状态与证明位置

- `MD.Ch07.gradNormSq`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hessianQuadratic`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateCorrectionChange`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateCorrections`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateCorrection_coefficient`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateExpansionPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateExpansionPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-ReciprocalFrictionExpansion

印刷页 301–302 / PDF页 322–323。

### 1. 原文陈述

> We will denote

$$
f_2(q,p)=f_{2,0}(q,p)+\epsilon f_{2,1}(q,p)+\epsilon^2f_{2,2}(q,p)+\cdots,\tag{7.31}
$$


> with each $\langle f_{2,i}\rangle=0$. Dividing by the friction in (7.28) we obtain

$$
(\overline{\mathcal L}_O^\dagger+\epsilon\mathcal L_H^\dagger)(f_2\rho_\beta)=-\epsilon\mathcal L_2^\dagger\rho_\beta,
$$


> where $\overline{\mathcal L}_O^\dagger\vartheta=\epsilon\mathcal L_O^\dagger\vartheta=\nabla_p\cdot(p\vartheta)+\beta^{-1}\Delta_p\vartheta$.

$$
w(q,p)=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p).
$$


> Equating powers gives

$$
\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,0})=0,\quad \mathcal L_H^\dagger(\rho_\beta f_{2,0})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,1})=-w\rho_\beta,\tag{7.32}
$$



$$
\mathcal L_H^\dagger(\rho_\beta f_{2,1})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2})=0,\quad \mathcal L_H^\dagger(\rho_\beta f_{2,2})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,3})=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。
- 29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。
- 覆盖缺口：29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：phaseH采用单位质量，aForward为−p·∇q，bForward为∇U·∇p；phaseO以γ=1、θ=β⁻¹给出缩放OU。symmetricRHS false=β(6pH∇U−U‴:p³)/24=−w，故双负号右端确实为−wρβ；k>0覆盖所有后续阶。FAIL在完整性：reciprocalHierarchy只定义层级，没有(7.31)级数/形式系数对象、ε=1/γ缩放方程或每阶Gibbs零均值。extra\_assumptions提及centeredCorrections，但该定义既未提供也未并入本条命题；β>0也未进入此签名。对任意实β的裸形式表达式可以定义，但不能声称已含物理域资格。
网站复审结论：PASS。phaseH=aForward(单位质量)+bForward，符号为−p·∇q+∇U·∇p；phaseO单位摩擦、β⁻¹温度正好是Ō†。ρ为未归一Gibbs，方程齐次于该常数。二阶层级右端−(−symmetricRHS)ρ=+symmetricRHSρ=−wρ，双负号正确。后续∀k>0包含k=1,2及全部更高阶；f₀、f₁位置正确。此处只有Prop定义，不证明存在解、级数收敛、ε=1/γ桥或各阶中心化；任意β的总化与物理β>0已区分。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.phaseH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.reciprocalHierarchy`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-OUKernelQualification

印刷页 302 / PDF页 323。

### 1. 原文陈述

> The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\overline{\mathcal L}_O^\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\nu(q)$, where $\langle\nu\rangle=0$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry

theorem ouKernelCentered_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hi : Integrable f (productGibbs (fun _ ↦ 1) U β))
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0)
    (hmean : ∫ x, f x ∂productGibbs (fun _ ↦ 1) U β = 0) :
    ∃ ν : V n → ℝ, (∀ q p, f (q,p)=ν q) ∧
      Integrable ν (positionGibbs U β) ∧ (∫ q, ν q ∂positionGibbs U β)=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。
- 29号覆盖限定：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：ouKernelPrinted对任意V n→ℝ函数量化，原印核的错误忠实保留，literal忠实性PASS。_corrected作用于ρβf，要求β>0、f全局光滑、每个q的f(q,·)属于动量Gaussian L²，结论对所有q,p给出f(q,p)=ν(q)，该共轭后核陈述正确；Gaussian L²是必要的域限定而非原印已有前提，应标[EXTRA]。结论不含⟨ν⟩=0，原页中心化须另行加上，不能由核自动推出。sorry不影响本次判断。
网站复审结论：NEEDS\_HUMAN。ouKernelPrinted逐字面保留裸前向OU核断言，作为Prop而非定理，不因原印错误判转写FAIL。corrected假设β>0、f全相空间C∞、每个q切片在非退化Gaussian L²中，且Ō†(ρf)=0；Gibbs共轭得到β⁻¹Δpf−p·∇pf=0，L²核为常数，光滑性使结论从几乎处处提升为∀q,p。U无需对q光滑，因为本式只对p微分。centered版额外给位置概率、全空间可积与零均值，结论含ν可积及其零均值，未从核条件凭空推出中心化。两修正版陈述合理，原印疑误需人工确认。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：密度共轭与Gaussian L²域的两个修正版签名PASS；裸前向OU核原印疑误待导师。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。

### 7. 状态与证明位置

- `MD.Ch07.ouKernelPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.ouKernelPrinted_corrected`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.ouKernelCentered_corrected`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-OUHermiteIdentities

印刷页 302 / PDF页 323。

### 1. 原文陈述


$$
\overline{\mathcal L}_O^\dagger(\rho_\beta\nabla^3U:p\otimes p\otimes p)=-3\rho_\beta\nabla^3U:p\otimes p\otimes p+\tfrac{6\rho_\beta}{\beta}p^T\nabla_q\Delta_qU,
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta p^T\nabla_q\Delta_qU)=-\rho_\beta p^T\nabla_q\Delta_qU,
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta p^T(\nabla^2U)\nabla U)=-\rho_\beta p^T(\nabla^2U)\nabla U.
$$



$$
w\rho_\beta=\tfrac\beta{24}\overline{\mathcal L}_O^\dagger([6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU]\rho_\beta).\tag{7.33}
$$



$$
\mathcal L_H^\dagger(\rho_\beta\nu)=-p^T\nabla\nu\rho_\beta=\overline{\mathcal L}_O^\dagger([p^T\nabla\nu+\mu(q)]\rho_\beta).\tag{7.34}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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
      (fun x ↦ -(∑ i, x.2 i*gradient ν x.1 i)*ρ x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。
- 29号覆盖限定：所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：β>0、U和ν全局光滑足以使三阶张量对称并合法交换所需偏导；μ只依赖q，OU不对q微分，故不要求μ光滑合理。三个Hermite等式及wρβ的符号正确，最后phaseH(ρν)=O((p·∇ν+μ)ρ)也正确。但完整(7.34)中的中间结论phaseH(ρν)=−p·∇νρ未出现在合取中；现有两端等式不能作为已列出该独立等式。此为完整结论缺项，不是sorry或数学错误。光滑性和β>0是合理[EXTRA]资格。
网站复审结论：PASS。ouHermiteIdentities全称U,ν,μ及β，β>0，U、ν C∞，无须μ光滑因为仅在p方向被微分。完整六个合取依次为三阶Hermite式、p·∇ΔU式、pᵀH∇U式、w的OU原函数、H(ρν)=−p·∇νρ和其OU表示。ρ用单位质量Gibbs，O用单位摩擦，正确。共轭OU作用于三次多项式为−3T+(6/β)p·∇ΔU，故primitive中−1/3及−2/β恰消额外线性项，得到−symmetricRHSρ。未以sorry为失败理由；本项仅是微分恒等式，不宣称唯一解。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。

### 7. 状态与证明位置

- `MD.Ch07.laplacian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.pGradLaplacian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.hermitePrimitive`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.ouHermiteIdentities`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-FirstReciprocalCorrection

印刷页 303–304 / PDF页 324–325。

### 1. 原文陈述


$$
f_{2,1,[OABAO]}=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU)-p^T\nabla\nu-\mu.
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})=-\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]}).\tag{7.35}
$$



$$
\int_{\mathcal P}\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})d\omega_p=0,\qquad \int_{\mathcal P}\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]})d\omega_p=\overline\pi\mathcal L_H^\dagger f_{2,1,[OABAO]}=0,\tag{7.36}
$$


> where $(\overline\pi f)(q)=\int_{\mathcal P}f(q,p)\rho_\beta d\omega_p$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted_corrected (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  momentumAverage β f q

def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*(gibbsWeight (fun _ ↦ 1) U β (q,p)/
    (∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x))
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry

def conjugatedPhaseH (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  phaseH U (gibbsWeight (fun _ ↦ 1) U β*f) x/gibbsWeight (fun _ ↦ 1) U β x

def jointGibbsQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ Integrable (gibbsWeight (fun _ ↦ 1) U β) volume ∧
  0 < ∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
- 29号覆盖限定：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。
- 覆盖缺口：给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
- 覆盖缺口：29号覆盖限定：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：firstReciprocalCorrection和一阶PDE的正负号正确；β>0、U/ν光滑足够，μ任意q函数不会影响OU动量微分。momentumAverage是归一条件Gaussian平均；Printed是Lebesgue动量积分乘未归一gibbsWeight，原书ρβ则为归一联合密度，因此一般还差总配分常数。_corrected作为条件平均定义合理，但与Printed不是同一算符，必须说明位置边际因子及归一常数。完整声明没有f2,2对象、(7.35)、OU通量零积分或(7.36)的相容结论；extra\_assumptions虽承认未证明，实际缺的是签名而非证明。
网站复审结论：NEEDS\_HUMAN。候选f₂,₁=−β·primitive/24−p·∇ν−μ，与原印一致；PDE的完整结论Ō(ρf₂,₁)+H(ρν)=+symmetricRHSρ=−wρ，符号正确，所加β>0及U、ν C∞合理。Printed是带全相空间配分函数的联合归一密度积分；corrected是独立Gaussian条件平均，不是同一算子。conjugatedPhaseH=H(ρf)/ρ，ρ严格正可除。jointGibbsQualification只定义β>0、可积及配分函数正，不是证明其成立。二阶方程和通量条件已列未覆盖。本项目Hamiltonian输运满足Hρ=0，因此H(ρf)=ρHf；不能将(7.36)该等式本身判错。真正的原书疑点在随后M的归一化与算子解释，需保留该限定。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：所列限定签名PASS；联合权平均与条件平均分别登记。本项目Hρ=0，故H(ρf)=ρHf，撤销把该Hamiltonian乘积等式本身判错的解释；疑点在后续M归一化与算子解释。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.firstReciprocalCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumAveragePrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumAveragePrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstReciprocalCorrection_pde`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.conjugatedPhaseH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.jointGibbsQualification`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-OverdampedSolvabilityOperators

印刷页 304 / PDF页 325。

### 1. 原文陈述

> We abbreviate

$$
\mathcal M\psi(q)=\overline\pi\mathcal L_H^\dagger\mathcal L_A^\dagger\psi(q) =\overline\pi((\mathcal L_A^\dagger)^2+\mathcal L_B^\dagger\mathcal L_A^\dagger)\psi(q) =\beta^{-1}\Delta_q\psi(q)-\nabla U\cdot\nabla_q\psi(q),
$$



$$
\mathcal N\psi(q)=\overline\pi\mathcal L_H^\dagger(\mathcal L_A^\dagger)^3\psi(q) =\overline\pi((\mathcal L_A^\dagger)^4+\mathcal L_B^\dagger(\mathcal L_A^\dagger)^3)\psi(q) =\tfrac3\beta\mathcal M(\Delta_q\psi(q)).
$$


> Thus we have

$$
\overline\pi\mathcal L_H^\dagger\rho_\beta f_{2,1,[OABAO]}=\tfrac\beta8\mathcal M(|\nabla U|^2-\beta^{-1}\Delta_qU)+\mathcal M\nu,
$$


> and hence by (7.36) we finally obtain $\nu(q)=\tfrac18(\Delta_qU-\beta|\nabla U|^2)$, where $\langle\nu\rangle=0$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。
- 只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。
- 29号覆盖限定：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。
- 覆盖缺口：29号覆盖限定：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：overdampedM正确记录β⁻¹Δψ−∇U·∇ψ，N正确记录3M(Δψ)/β，候选ν正确。choice仅在β≠0时对所有q证明同一公式的代数改写，真实但远弱于可解性：没有M/N的平均算符识别、相容方程、ν的核唯一性或零均值声明。[EXTRA]β≠0足够代数运算，但物理Gaussian与积分分部需β>0、正则性、可积和边界资格。原印的算符不一致需人工决定采用哪一共轭约定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。

### 7. 状态与证明位置

- `MD.Ch07.overdampedM`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.overdampedN`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.highFrictionOABAO`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.overdampedSolvability_choice`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-HighFrictionCorrectionTable

印刷页 304–305 / PDF页 325–326。

### 1. 原文陈述


$$
f_{2,0,[OABAO]}=\tfrac18(\Delta_qU-\beta|\nabla U|^2),
$$



$$
f_{2,0,[OBABO]}=\tfrac18(\beta|\nabla U|^2-2\Delta_qU+c),
$$


> where $c=\langle\Delta U\rangle$ is a constant chosen to ensure zero average.

$$
f_{2,0,[ABOBA]}=\tfrac18(\beta p^T\nabla^2U(q)p-2\Delta_qU+c),
$$



$$
f_{2,0,[BAOAB]}=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p).
$$



$$
\langle\vartheta\rangle_h=\langle\vartheta\rangle+h^2\langle\vartheta f_{2,0}\rangle+O(\epsilon h^2+h^4).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

def highFrictionMeanLaplacian (U : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, laplacian U q ∂positionGibbs U β

def highFrictionCenteredQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧
  Integrable (laplacian U) (positionGibbs U β) ∧
  ∀ s : Fin 4, Integrable (highFrictionCorrection s U β (highFrictionMeanLaplacian U β))
    (productGibbs (fun _ ↦ 1) U β) ∧
    (∫ x, highFrictionCorrection s U β (highFrictionMeanLaplacian U β) x
      ∂productGibbs (fun _ ↦ 1) U β) = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。
- 候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。
- 29号覆盖限定：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。
- 覆盖缺口：29号覆盖限定：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：s=0,1,2,3依次为OABAO、OBABO、ABOBA、BAOAB，四个公式及共轭关系正确；任意β,c的纯代数定理无需物理资格。positivePairLimit是(ε,h)从正象限趋于(0,0)，doublyAsymptoticAverage的幂次和变量顺序正确。但c只是任意实数，未定义/限制为⟨ΔU⟩，也无四种候选的零均值签名；A、exact、correction完全抽象，未与真实数值均值、Gibbs均值及⟨ϑf2,0⟩建立联系。其为平稳系数和余项尚未证明与尚未声明应分别记录。
网站复审结论：PASS。Fin 4的0/1/2/3精确对应OABAO/OBABO/ABOBA/BAOAB，四分支完整；c参数保留。conjugateCorrectionChange=β(|∇U|²−pᵀHp)/8，两条conjugateCorrections方向分别为减、加，四式满足该纯代数关系。positivePairLimit为(ε,h)从双正侧到(0,0)，余项参数z.1*z.2²+z.2⁴正确。MeanLaplacian为实际位置Gibbs积分；CenteredQualification把概率、可积及四项零均值列成资格，并未证明资格。A、exact、correction为抽象量，没有被误称为真实四算法平稳均值定理，缺口已披露。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.highFrictionCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doublyAsymptoticAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.highFrictionCorrection_conjugacy`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.highFrictionMeanLaplacian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.highFrictionCenteredQualification`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-BAOABMarginalCancellation

印刷页 305 / PDF页 326。

### 1. 原文陈述


$$
\langle\vartheta\rangle=\langle\vartheta\rangle_h-h^2\langle\vartheta f_{2,0}\rangle+O(h^2/\gamma+h^4).\tag{7.37}
$$


> The $[BAOAB]$ scheme has leading order correction

$$
f_{2,0,[BAOAB]}(q,p)=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p),
$$


> which has the interesting property that its marginal average with respect to momentum is zero:

$$
\overline\pi f_{2,0,[BAOAB]}=\int_{\mathcal P}f_{2,0,[BAOAB]}(q,p)\rho_\beta(q,p)d\omega_p=0.
$$



$$
\langle\vartheta(q)f_{2,0,[BAOAB]}\rangle=\int_{\mathcal Q}\vartheta(q)\int_{\mathcal P}f_{2,0,[BAOAB]}\rho_\beta d\omega_p d\omega_q=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。
- 29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。
- 覆盖缺口：29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：两个零积分声明正确：单位质量Gaussian协方差β⁻¹I使平均βpᵀHess(U)p=ΔU；对配置任意U的逐q系数无需U光滑。构型声明显式要求被积函数可积，足以使用条件零均值。productGibbs未要求位置分布为概率，U=0等情况下positionGibbs可退化为零测度，因此它并不自动是原文的canonical expectation。更主要的是完整(7.37)没有在本条出现，既无真实均值对象也无余项声明；不能用前条未实例化的抽象定义当作本条已覆盖。
网站复审结论：PASS。条件动量Gaussian协方差β⁻¹I，故〈βpᵀHp〉p=tr H=ΔU；U任意也可，因为固定q的有限导数值只是二次多项式系数。Marginal声明∀U,β,q且β>0，结论正确。Configurational声明额外位置Gibbs概率、φ乘修正可积，结论是实际productGibbs下的零积分，足够使用Fubini。原书联合权边际和条件平均相差位置密度，但其零值一致；并未由此推出(7.37)的真实算法误差界。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.baoabMarginalCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.baoabConfigurationalCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-SuperconvergenceScope

印刷页 306 / PDF页 327。

### 1. 原文陈述

> Thus we expect that the $[BAOAB]$ scheme recovers $O(h^4)$ configurational averages in the limit of infinite friction.
> Its conjugate method, the $[OABAO]$ scheme, has the property

$$
\int_{\mathcal Q}f_{2,0,[OABAO]}(q,p)\rho_\beta(q,p)d\omega_q=0,
$$


> implying that we obtain high-order averages for functions purely of the momenta in the limit of infinite friction.
> It is important to note that this superconvergence property is only present in the limit of large time, i.e. this is an attribute of the invariant distribution of the discretization schemes $\widehat\rho$. As such, there are no bonuses to the weak or strong order of the superconvergent schemes.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

theorem oabaoMomentumCancellation (U χ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hf : Integrable (highFrictionOABAO U β) (positionGibbs U β))
    (hχ : Integrable χ (momentumGibbs (fun _ ↦ 1) β))
    (hc : ∫ q, highFrictionOABAO U β q ∂positionGibbs U β = 0) :
    (∫ x, χ x.2*highFrictionOABAO U β x.1 ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。
- 四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。
- 29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。
- 覆盖缺口：29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：oabaoPositionCancellation中β>0、U光滑、权重与每项通量可积、各坐标两端通量消失，是可执行积分分部资格，结论合理。[EXTRA]这些条件原页省略。superconvergence\_fromBound对任意A和exact假设的h⁴余项界仅消去h²·0，正确但没有BAOAB、γ→∞、实际平稳分布或OABAO任意动量观测对象；它将主要结论所需阶数直接放入前提。缺少由双渐近界及积分消项推出实际方法四阶的完整签名，也未表达有限时间弱/强阶的范围。
网站复审结论：PASS。oabaoPositionCancellation的β>0、U C∞、权可积、各(∂iiU−β(∂iU)²)e^(−βU)可积及每条坐标线两端通量零，足以逐坐标分部积分给零；n=0情形求和亦为零。superconvergence\_fromBound把已有h⁴界中的h²·0消掉，既不建立该界也不识别真实数值误差。MomentumCancellation另假设χ及位置修正可积、位置概率和已知零积分，乘积积分结论正确。无限摩擦、长期和h→0三种范围未混淆，真实四阶桥已列缺口。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.oabaoPositionCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.superconvergence_fromBound`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.oabaoMomentumCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-MomentumRedrawLimit

印刷页 306 / PDF页 327。

### 1. 原文陈述

> We now consider schemes in the limit $\gamma\to\infty$, where the exact solution of the vector OU process reduces to redrawing momenta from the canonical distribution, so $p_{n+1}=\sqrt{k_BT}M^{1/2}R$, where $R$ is a vector of i.i.d. normal random numbers.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry

theorem redrawMomentum_law (P : Measure Ω) (m : V n) (θ : ℝ) (R : Ω → V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ)
    (hR : HasLaw R (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ redrawMomentum m θ (R sample)) (momentumGibbs m θ⁻¹) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。
- 29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。
- 覆盖缺口：29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：固定h>0、θ>0，对任意固定p,R的逐噪声路径极限正确，有限维逐坐标拓扑也匹配。m不需正值即可使这个经Real.sqrt截断的纯实函数极限成立；但要忠实表达M正质量与canonical重抽，应加∀i m\_i>0，并给随机R及独立标准Gaussian的分布对象。当前R只是确定向量，无P、HasLaw或随机变量资格；extra\_assumptions称“实际独立Gaussian R”超出了签名。此FAIL是原文分布结论缺失，不否认现有确定性极限定理。
网站复审结论：PASS。ouMomentum完整公式exp(−γh)p+√[θ(1−exp(−2γh))]√m R；固定h>0、正质量、θ>0，γ→∞逐坐标极限正好为√θ√m R。law声明的标准Gaussian乘积分布是独立坐标，输出momentumGibbs m θ⁻¹的方差为m/(θ⁻¹)=mθ，正确。HasLaw使用给定P，不额外把任意确定R声称为随机Gaussian。位置未改变；质量零极限及弱收敛未冒充已证内容。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.redrawMomentum`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.redrawStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumRedrawLimit`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.redrawMomentum_law`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-OBABOOverdampedEuler

印刷页 307 / PDF页 328。

### 1. 原文陈述

> For the method denoted $[OBABO]$, we have the limiting scheme

$$
p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad \widehat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),
$$



$$
q_{n+1}=q_n+hM^{-1}\widehat p_{n+1/2},\quad \widehat p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=\sqrt{k_BT}M^{1/2}R_{n+1/2}.
$$



$$
q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+h\sqrt{k_BT}M^{-1/2}R_n.\tag{7.38}
$$


> Denoting $\tau=h^2/2$, the update scheme (7.38) becomes the Euler-Maruyama scheme

$$
q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}R_n.\tag{7.39}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite\_position, overdampedEuler\_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite\_position, overdampedEuler\_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。

### 7. 状态与证明位置

- `MD.Ch07.obaboInfinite`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEulerH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEuler`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obaboInfinite_position`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEuler_rescale`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-BAOABLimitMethod

印刷页 307–308 / PDF页 328–329。

### 1. 原文陈述


$$
p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},
$$



$$
\widehat p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\widehat p_{n+1/2},\quad p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}).
$$


> Expressing this as an update solely for the configurations, we obtain

$$
q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+\tfrac h2\sqrt{k_BT}M^{-1/2}(R_n+R_{n-1}),
$$


> and substituting $\tau=h^2/2$ gives the BAOAB Limit Method (Leimkuhler-Matthews method)

$$
q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}\left(\tfrac{R_n+R_{n-1}}2\right).\tag{7.40}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

theorem lmStepH_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    lmStepH m U θ h R S q = lmStep m U θ (h^2/2) R S q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。
- 完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。
- 29号覆盖限定：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：组合次序正确；baoabInfinite\_position显式把初始p写为上一步redraw S减半kick，恰好避免对任意初始p错误地声称位置闭合。lmStepH与lmStep的两个公式正确；但只证明/声明了h形式消元，没有在正质量、θ≥0、h≥0下声明lmStepH=lmStep(τ=h²/2)。前条rescale只作用单噪声Euler，不能自动成为此双噪声声明。该完整结论缺项已在extra\_assumptions承认，但未给目标签名。
网站复审结论：PASS。函数复合从右至左是kick、drift、redraw、drift、kick，符合五段原文。position定理明确以p=redraw(S)−h∇U(q)/2为初值，因此第一个kick后p=redraw(S)−h∇U(q)，消元得到−h²∇U/(2m)及h(redraw R+redraw S)/(2m)。该代数恒等式对所有实参数在Lean总化下成立；rescale另加m>0、θ≥0、h≥0以正确识别√(h²θ)=h√θ，和τ=h²/2一致。没有无条件对任意初始动量声称闭合，也没有声称长期精度。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。

### 7. 状态与证明位置

- `MD.Ch07.baoabInfinite`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmStepH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.baoabInfinite_position`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.lmStepH_rescale`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-ColoredNoiseAndExtension

印刷页 308 / PDF页 329。

### 1. 原文陈述

> We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $p_n$).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)

def lmExtendedKernel (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦
      lmExtendedStep m U θ τ z.2 z.1)) : Kernel (V n × V n) (V n × V n) :=
  (Kernel.id.prod (Kernel.const (V n × V n) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)))).map
    (fun z ↦ lmExtendedStep m U θ τ z.2 z.1)

def lmExtendedChain (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n) : ℕ → Ω → V n × V n
  | 0 => X0
  | k+1 => fun sample ↦ lmExtendedStep m U θ τ (R k sample)
      (lmExtendedChain m U θ τ R X0 k sample)

/-- 每次新噪声独立于初始状态及所有先前噪声；集合积分式给出扩展过程的Markov条件分布。 -/
theorem lmExtendedChain_markov (P : Measure Ω) (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (hτ : 0 < τ)
    (hR : vectorNormalSequence P R) (hX0 : Measurable X0)
    (hfresh : ∀ k, IndepFun (R k)
      (fun sample ↦ (X0 sample,fun j : Fin k ↦ R j sample)) P)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦ lmExtendedStep m U θ τ z.2 z.1)) :
    let X := lmExtendedChain m U θ τ R X0
    ∀ k (A : Set (V n × V n)) (hA : MeasurableSet A) (B : Set Ω),
    MeasurableSet[⨆ j : Fin (k+1), MeasurableSpace.comap (X j) inferInstance] B →
    P (B ∩ (X (k+1)) ⁻¹' A) =
      ∫⁻ sample in B, lmExtendedKernel m U θ τ hstep (X k sample) A ∂P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。
- 覆盖缺口：一般位置过程非Markov需额外非退化参数与初态；此处未作无条件断言。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：coloredNoise采用相邻标准独立Gaussian平均，索引(R\_k,R_{k+1})与原页(R\_n,R_{n−1})仅差移位；covariance对概率P、iIndepFun和HasLaw量化，方差1/2、邻接协方差1/4、其余0正确，应标[EXTRA]推导结论。lmExtendedStep把(q,R旧)映射到(lmStep(R新,R旧,q),R新)正确。但未有新噪声独立于过去的过程条件、Markov核/条件分布或扩展Markov性声明；只给一个确定性状态映射不能覆盖原页的核心Markov断言。一般位置过程非Markov也不宜无条件量化。
网站复审结论：NEEDS\_HUMAN。coloredNoise=(Rk+Rk+1)/2是对原文相邻噪声的移位记号；独立标准正态使其均值零，二阶矩分别为1/2、1/4、0，故covariance名虽结论写E[ηjηk]仍正确。这是[EXTRA]协方差结论。extendedStep输入状态(q,旧噪声)，输出(lmStep(新,旧,q),新)，Kernel为δ状态×标准Gaussian的可测推前，确为转移核。chain递归k=0起，markov的hfresh要求Rk独立于X0及R0,…,Rk−1，hstep、hX0与vectorNormalSequence足以保证对X0,…,Xk历史中所有可测B的集合积分恒等式；索引Fin(k+1)正确。metadata却仍称Markov定理未覆盖，须订正。原书由有色噪声直接推非Markov也须保留例外资格。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：fresh独立性下Markov集合积分式签名PASS；删去过时的同名缺口。协方差为额外推论，位置非Markov仍需限定。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。

### 7. 状态与证明位置

- `MD.Ch07.coloredNoise`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.coloredNoise_covariance`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedKernel`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedChain`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedChain_markov`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-LimitMethodAccuracy

印刷页 308 / PDF页 329。

### 1. 原文陈述

> We would expect that this scheme should have an $O(h^4)=O(\tau^2)$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $O(h^2)$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
def limitAccuracyPrinted (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^2)

def limitAccuracyPrinted_corrected (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^4)

theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring

def limitAccuracyInfiniteTime_corrected (error : ℝ → ℝ → ℝ) (longtime : ℝ → ℝ) : Prop :=
  (∀ h, 0 < h → Tendsto (fun T ↦ error (h^2/2) T) atTop (𝓝 (longtime h))) ∧
  limitAccuracyPrinted_corrected longtime
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。
- 原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。
- 29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
- 覆盖缺口：29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：Printed忠实保留h²幂次，PASS；_corrected给h⁴合理对应无限时间不变平均，但必须限定该error为长期误差，不能直接用于固定有限T。lmTransientErrorBound正确记录C(e^(−aT)τ+τ²)的一种充分界，正C/a/δ及所有小τ、T≥0的量词明确，属于[EXTRA]精确定量目标；原书文字本身不保证该统一界。rescale恒等式正确。缺少LM真实平均误差与error的联系、势/观测/初值条件和实际误差满足该界的签名。
网站复审结论：NEEDS\_HUMAN。瞬态界的量词是存在统一C>0、衰减率>0、δ>0，∀0<τ<δ及∀T≥0，界C(e^(−λT)τ+τ²)；它只是error的性质定义。Printed保留h→0正侧的O(h²)，corrected改为O(h⁴)，rescale代数式τ²=h⁴/4正确。InfiniteTime\_corrected显式把固定h先T→∞的longtime接到O(h⁴)，防止把固定有限T误判四阶。任何声明都未证明真实LM误差满足瞬态界。原书末句符号歧义保留，孤立corrected定义应仅在长期语境中解释。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：限定定义和长期极限连接签名PASS；h⁴仅在先取长期极限的解释下适用，不表示固定有限时间四阶或真实LM误差界已证。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.lmTransientErrorBound`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracyPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.limitAccuracyPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracy_rescale`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracyInfiniteTime_corrected`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-ZeroFrictionVerlet

印刷页 306 / PDF页 327。

### 1. 原文陈述

> An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $\gamma=0$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  funext x
  have ha : driftStep m (h/2) (driftStep m (h/2) (kickStep U (h/2) x)) =
      driftStep m h (kickStep U (h/2) x) := by
    ext i <;> dsimp [driftStep] <;> ring
  simp only [baoab,Function.comp_apply,zeroFrictionOU]
  rw [ha]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。

### 7. 状态与证明位置

- `MD.Ch07.zeroFrictionOU`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.zeroFrictionBAOAB`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.11.1-TemperatureObservables

印刷页 310 / PDF页 331。

### 1. 原文陈述

> Indeed, calculating the temperature of the system from an average of kinetic energy by

$$
N_dk_BT=\langle p^TM^{-1}p\rangle,\tag{7.41}
$$


> gives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature

$$
N_dk_BT=\langle q\cdot\nabla U(q)\rangle.\tag{7.42}
$$


> Were one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。
- 构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。

### 7. 状态与证明位置

- `MD.Ch07.kineticTemperatureObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.configurationTemperatureObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.kineticTemperature`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.configurationTemperature`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.11.1-VelocityAutocorrelationDefinition

印刷页 310 / PDF页 331。

### 1. 原文陈述

> The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation\_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。
- 已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。
- 覆盖缺口：已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation\_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。

### 7. 状态与证明位置

- `MD.Ch07.velocityAutocorrelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.greenKuboDiffusion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.autocorrelation_rescale`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedLangevin

印刷页 317 / PDF页 338。

### 1. 原文陈述


$$
dq=M^{-1}pdt,\tag{7.43}
$$



$$
dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\tag{7.44}
$$



$$
0=g(q).\tag{7.45}
$$


> The vector of $l$ constraints is given by $g:\mathbb R^{N_c}\to\mathbb R^l$ and $\lambda$ is an $l$-dimensional vector of Lagrange multipliers. $W$ is a vector of standard Wiener processes, with the usual friction parameter $\gamma>0$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint

$$
g(q)=0,\qquad g'(q)M^{-1}p=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

/-- 限制到单位质量、常正交投影的线性约束修正版；未声称一般非线性情形。 -/
def constrainedLangevin_corrected {l : ℕ} (P : Measure Ω) (C : Matrix (Fin l) (Fin n) ℝ)
    (proj : Matrix (Fin n) (Fin n) ℝ) (U : V n → ℝ) (γ θ : ℝ)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 U ∧
  proj*proj=proj ∧ proj.transpose=proj ∧ C*proj=0 ∧
  (∀ v : V n, C *ᵥ v=0 → proj *ᵥ v=v) ∧
  C *ᵥ x0.1=0 ∧ C *ᵥ x0.2=0 ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    C *ᵥ (X t sample).1=0 ∧ C *ᵥ (X t sample).2=0 ∧
    (∀ i, (X t sample).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i) ∧
    ∀ i, (X t sample).2 i=x0.2 i+
      (∫ s in (0 : ℝ)..t, -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i)+
      Real.sqrt (2*γ*θ)*(proj *ᵥ (W t sample-W 0 sample)) i
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。
- 定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
- 29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。
- 覆盖缺口：定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
- 覆盖缺口：29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：Jacobian、反力求和、g′M⁻¹p=0和约束相空间定义正确；vectorWiener确含概率、联合Gaussian、标准协方差、连续路径和坐标过程独立。积分式的m\_i、γ、θ、W增量及初值无误。[EXTRA]正质量/温度、C²约束、自然W历史适应、确定初值及逐sample可积都是对解类的额外限制，非原页已给定全部资格。关键问题：Λ被限定为普通时间可积过程，反力只有有限变差∫g′ᵀΛds，无法抵消标准环境W的法向Brownian分量而保持隐藏约束；若原书λdt意指随机冲量，当前定义就不忠实于通常约束Langevin。若严格照字面则继承原印问题，不能据此断言有解。
网站复审结论：NEEDS\_HUMAN。V n、V l、Jacobian(j,i)、Reaction=JacobianᵀΛ及hiddenConstraint中的p\_i/m\_i均对应原式；θ=kBT，质量为正对角质量而非一般非对角矩阵，是[EXTRA]范围限制。vectorWiener的联合Gaussian、零均值、min协方差、连续路径和坐标独立规格确为标准向量Wiener。原版限定正时间，X和Λ适应W的自然历史、X路径连续/确定初值几乎处处，漂移逐路径可积，∀t≥0几乎处处满足完整约束和两个积分方程；λ确以dt积分，仅保留原印解类，不宣称存在。corrected仅单位质量、线性齐次约束Cq=0：proj自伴幂等、Cproj=0且恒等于ker C，故正是到ker C的正交投影；投影力和噪声、摩擦−γp与两条约束一致，修正合理。原印一般非退化噪声与有限变差反作用难以保持隐藏约束，应加[ERRATUM?]。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：单位质量线性约束投影修正版签名PASS；原印有限变差乘子模型不声称一般存在。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.constraintJacobian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constraintReaction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.hiddenConstraint`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.cotangentConstraint`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedLangevin`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedLangevin_corrected`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedCanonicalErgodicity

印刷页 317 / PDF页 338。

### 1. 原文陈述

> In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\widetilde\rho_\beta$ ergodically, such that

$$
\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,
$$


> where $\widetilde\rho_\beta$ is the normalized constrained canonical distribution

$$
\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],
$$


> for normalizing constant $Z$ and where $\delta[z]:=\prod_i\delta[z_i]$ for a vector $z$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

def constrainedCanonicalQualification {l : ℕ} (ν : Measure (Phase n))
    (m : V n) (g : V n → V l) (U : V n → ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ContDiff ℝ 2 g ∧ constrainedReference ν m g ∧
  Integrable (gibbsWeight m U β) ν ∧ (0 < ∫ x, gibbsWeight m U β x ∂ν)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。
- 实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。
- 29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。
- 覆盖缺口：29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：constrainedReference用(πε)^(−l)对2l个标量约束同时正则化，常数和ε幂正确，且显式要求支撑于cotangentConstraint；作为所印delta乘积的弱极限目标是忠实的。constrainedCanonical接受任意ν，未要求它满足constrainedReference、配分积分正有限或β>0，因此并非自动归一约束canonical。constrainedErgodicAverages仅是对任意P/X/μ的遍历目标定义，没有将μ连接到该canonical、也没有X满足约束SDE的前提或相应蕴涵声明。原书delta参考测度与自然约束相空间体积的Jacobian因子和遍历性条件需人工处理；extra\_assumptions的提醒不足以连接这些签名。
网站复审结论：NEEDS\_HUMAN。四个声明作为已缩小范围的定义基本忠实且内部合理，但没有完整的受约束SDE遍历结论。原书无条件遍历采样及delta参考的解释存在实质疑问，必须依任务规则保留原印并判NEEDS\_HUMAN；本判定不是因没有补证明或因sorry。
按版本登记：四个参考与遍历目标定义的限定范围获认可；没有完整受约束SDE遍历定理，几何参考体积和连通/不可约资格仍待导师。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。

### 7. 状态与证明位置

- `MD.Ch07.constrainedCanonical`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedReference`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedErgodicAverages`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedCanonicalQualification`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedHOSplitting

印刷页 318 / PDF页 339。

### 1. 原文陈述

> We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses

$$
H_c:\quad dq=M^{-1}pdt,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> We solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $h$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $h/2$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)

def constrainedONoise (m : V n) (γ θ : ℝ) (j : Fin n) : Phase n :=
  (0,fun i ↦ if i=j then Real.sqrt (2*γ*θ*m i) else 0)

def constrainedHIntegralStep {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (X : ℝ → Phase n) (Λ : ℝ → V l) (x0 : Phase n) (T : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 g ∧ ContDiff ℝ 1 U ∧ 0 ≤ T ∧
  ContinuousOn X (Icc 0 T) ∧ X 0=x0 ∧
  (∀ t ∈ Icc 0 T, X t ∈ cotangentConstraint m g) ∧
  ∀ i, IntervalIntegrable (fun t ↦ (X t).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun t ↦ -gradient U (X t).1 i-
      constraintReaction g (X t).1 (Λ t) i) volume 0 T ∧
    ∀ t ∈ Icc 0 T,
      (X t).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s).2 i/m i ∧
      (X t).2 i=x0.2 i+∫ s in (0 : ℝ)..t,
        -gradient U (X s).1 i-constraintReaction g (X s).1 (Λ s) i

/-- O乘子冲量允许含随机部分；不把它限为有限变差的λdt。 -/
def constrainedOIntegralStep {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (reactionImpulse : ℝ → Ω → V n) (x0 : Phase n) (T : ℝ) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧ 0 ≤ T ∧
  (∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P, X t sample ∈ cotangentConstraint m g) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Icc 0 T) ∧
    X 0 sample=x0 ∧ reactionImpulse 0 sample=0) ∧
  (∀ sample i, IntervalIntegrable (fun t ↦ -γ*(X t sample).2 i) volume 0 T) ∧
  (∀ sample t, ∃ impulseCoeff : V l, reactionImpulse t sample=constraintReaction g x0.1 impulseCoeff) ∧
  (∀ t ∈ Icc 0 T, Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
      (reactionImpulse t)) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1 ∧ ∀ i,
      (X t sample).2 i=x0.2 i+(∫ s in (0 : ℝ)..t, -γ*(X s sample).2 i)-
        reactionImpulse t sample i+Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

def constrainedHMapQualification {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (H : ℝ → Phase n → Phase n) : Prop :=
  (∀ T, 0 ≤ T → Measurable (H T)) ∧
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ Λ : ℝ → V l,
    constrainedHIntegralStep m U g (fun t ↦ H t x) Λ x T

def constrainedOMapQualification {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (O : ℝ → Ω → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure P ∧ vectorWiener P W ∧
  (∀ T, 0 ≤ T → Measurable (fun z : Ω × Phase n ↦ O T z.1 z.2)) ∧
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ reaction : ℝ → Ω → V n,
    constrainedOIntegralStep P m g γ θ W (fun t sample ↦ O t sample x) reaction x T

/-- 非负步长、合规确定初值下的输出；底层概率测度明确为P.prod P。 -/
def constrainedHOQualifiedComposition {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) : Ω × Ω → Phase n :=
  fun sample ↦ O (h/2) sample.2 (H h (O (h/2) sample.1 x))

theorem constrainedHOQualifiedComposition_measurable {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    Measurable (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx) := by
  have hhalf : 0 ≤ h/2 := by positivity
  have hmO := hO.2.2.1 (h/2) hhalf
  have hfirst : Measurable (fun sample : Ω × Ω ↦ O (h/2) sample.1 x) :=
    hmO.comp (measurable_fst.prodMk measurable_const)
  exact hmO.comp (measurable_snd.prodMk ((hH.1 h hh).comp hfirst))

/-- 输出律由乘积概率上的可测推前给出；不声称已识别条件积分解。 -/
def constrainedHOOutputLaw {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) : Measure (Phase n) :=
  (P.prod P).map (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx)

theorem constrainedHOOutput_hasLaw {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    HasLaw (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx)
      (constrainedHOOutputLaw P m U g γ θ W H O hH hO h hh x hx) (P.prod P) := by
  exact hasLaw_map (constrainedHOQualifiedComposition_measurable P m U g γ θ W H O hH hO h hh x hx).aemeasurable

theorem constrainedHOOutputLaw_probability {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    IsProbabilityMeasure (constrainedHOOutputLaw P m U g γ θ W H O hH hO h hh x hx) := by
  letI : IsProbabilityMeasure P := hO.1
  exact (constrainedHOOutput_hasLaw P m U g γ θ W H O hH hO h hh x hx).isProbabilityMeasure_iff.mp inferInstance
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。
- 每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。
- 30号修复：P为概率及W为向量Wiener独立于约束集非空性；H的初值可测与O的样本/初值联合可测。
- H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。
- 覆盖缺口：未建立随机初值代入后的条件积分解、几乎处处约束保持及完整条件转移核识别；未构造分段解存在唯一性、Oc半群律或约束Gaussian不变性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：HField正确记录dq=M⁻¹p与−∇U−g′ᵀλ，OField只记录dq=0和−γp−g′ᵀλ的漂移。composition在任意类型E及任意映射H/O上实现右至左O半步、H全步、O半步，顺序正确。然而完整Oc噪声√(2γkBTM)dW没有参数或扩散对象，本条也没有H/O满足各自受约束方程、g=0及隐藏约束保持的资格。映射E→E还不能直接表达随机OU核及两次独立新噪声；不能以extra\_assumptions中“前条噪声”替代本条缺失的连接签名。FAIL是完整对象/结论缺项，不要求实际流的存在证明。
网站复审结论：FAIL。漂移、扩散、分段积分解及O-H-O时间次序核对正确，且hH/hO确已连接分段规格。FAIL限于本条声明要覆盖的独立随机映射组合：规格只逐确定初值可测，没有H/O联合可测性，也未指定P.prod P上的输出随机变量/条件分布。两个坐标的函数不足以保证随机初值下的有效组合。另有原印λdt解释疑义，因此A部分仍NEEDS\_HUMAN。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：按网站审校意见修复，本地核验通过（未再送网站）。
本条实际覆盖：H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。

### 7. 状态与证明位置

- `MD.Ch07.constrainedHField`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOField`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOComposition`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedONoise`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHIntegralStep`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOIntegralStep`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHMapQualification`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOMapQualification`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOQualifiedComposition`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOQualifiedComposition_measurable`：已证；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutputLaw`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutput_hasLaw`：已证；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutputLaw_probability`：已证；网站：按意见修复，本地核验通过（未再送网站）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-MEVMEAlgorithm

印刷页 318–319 / PDF页 339–340。

### 1. 原文陈述

> Midpoint Euler - Verlet - Midpoint Euler (see [232])

$$
p_{n+1/4}=p_n-\tfrac{h\gamma}4(p_n+p_{n+1/4})+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4},\quad g'(q_n)M^{-1}p_{n+1/4}=0.
$$



$$
p_{n+1/2}=p_{n+1/4}-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/2},\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},
$$



$$
p_{n+3/4}=p_{n+1/2}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+3/4},\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\quad g(q_{n+1})=0.
$$



$$
p_{n+1}=p_{n+3/4}-\tfrac{h\gamma}4(p_{n+3/4}+p_{n+1})+\sqrt{h\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。

### 7. 状态与证明位置

- `MD.Ch07.midpointConstrainedORelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedVerletRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.mevmeRelation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-MidpointStabilityPrinted

印刷页 319 / PDF页 340。

### 1. 原文陈述

> The Lagrange multiplier $\lambda_{n+1/4}$ (and likewise $\lambda_{n+1}$) can be obtained by solving the linear system

$$
g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,
$$


> which is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion

$$
\gamma h<4.\tag{7.46}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。

### 7. 状态与证明位置

- `MD.Ch07.multiplierLinearSystem`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointAmplification`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStabilityPrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStabilityPrinted_corrected`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStability_counterexample`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ConstrainedABOSplitting

印刷页 319–320 / PDF页 340–341。

### 1. 原文陈述


$$
A_c:\quad dq=M^{-1}pdt,\quad dp=-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
B_c:\quad dq=0,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> Observe that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $g(q)=0$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。
- 正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。

### 7. 状态与证明位置

- `MD.Ch07.constrainedAField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedBField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.geodesicConstraintFlow`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedKickRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedExactORelation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ConstrainedBAOABAlgorithm

印刷页 320 / PDF页 341。

### 1. 原文陈述

> c-$[BAOAB]$

$$
p_{n+1/5}=p_n-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/3},\quad g'(q_n)M^{-1}p_{n+1/5}=0.
$$


> Solve the geodesic flow $A_c$ for $h/2$, and map $[q_n,p_{n+1/5}]\to[q_{n+1/2},p_{n+2/5}]$.

$$
p_{n+3/5}=e^{-\gamma h}p_{n+2/5}+\sqrt{(1-e^{-2\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\lambda_{n+2/3},\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.
$$


> Solve the geodesic flow $A_c$ for $h/2$, and map $[q_{n+1/2},p_{n+3/5}]\to[q_{n+1},p_{n+4/5}]$.

$$
p_{n+1}=p_{n+4/5}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 constrainedBAOABRelation, constrainedBAOAB\_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 constrainedBAOABRelation, constrainedBAOAB\_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。

### 7. 状态与证明位置

- `MD.Ch07.constrainedBAOABRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedBAOAB_constraint`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ApproximateGeodesicOrder

印刷页 320 / PDF页 341。

### 1. 原文陈述

> We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $A_c$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。
- 29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。
- 覆盖缺口：29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。localMapErrorBound对同一C≥0、δ>0以及全部0<h<δ、x∈D给出O(h^(r+1))误差；r=2即局部O(h³)，定义本身合理。但geodesicReplacementSecondOrder只是该定义的别名，无任何组合方法、随机强/弱误差、稳定性前提或整体二阶结论。EXTRA诚实说明缺口，却不能使“本条全部数学对象与公式”的statement\_scope成立。FAIL基于完整结论缺失，与是否有sorry无关。
网站复审结论：PASS。按本条明确声明的“一致局部O(h³)误差资格定义”范围，域、范数、全部量词和r+1指数均正确。两个def未声称替换后整体二阶，故不以缺少该定理否定其已缩小范围的签名。原文完整保阶论断仍未形式化，不能由本PASS消除该覆盖缺口。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。

### 7. 状态与证明位置

- `MD.Ch07.localMapErrorBound`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.geodesicReplacementSecondOrder`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-FastSlowHarmonicModel

印刷页 323 / PDF页 344。

### 1. 原文陈述


$$
H(q,p)=p^2/2+U(q),\qquad U(q)=U_F(q)+U_S(q),
$$



$$
U_S(q)=q^2/2,\qquad U_F(q)=\Omega^2q^2/2,\tag{7.47}
$$


> where $\Omega\gg1$.

$$
\binom{dq}{dp}=\underbrace{\binom{pdt}{-\Omega^2qdt-\gamma pdt+\sqrt{2\gamma/\beta}dW}}_{\rm Fast}+\underbrace{\binom0{-qdt}}_{\rm Slow}.\tag{7.48}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
abbrev Mat2 := Matrix (Fin 2) (Fin 2) ℝ
def fastPotential (Ω q : ℝ) : ℝ := Ω^2*q^2/2
def slowPotential (q : ℝ) : ℝ := q^2/2
def fastMatrix (Ω γ : ℝ) : Mat2 := !![0,1;-Ω^2,-γ]
def slowMatrix (h : ℝ) : Mat2 := !![1,0;-h,1]
def fastLangevin (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β : ℝ) (x0 : Phase 1) : Prop :=
  0 < frequency ∧ 0 < β ∧ langevin P W X (fun q ↦ fastPotential frequency (q 0)) (fun _ ↦ 1) γ β⁻¹ x0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 单位质量、实际标准Wiener、状态适应、正β及完整积分方程由langevin定义体保留；Ω≫1在定量结论中分别改成明确不等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。

### 7. 状态与证明位置

- `MD.Ch07.Mat2`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.slowPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.slowMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastLangevin`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-ExactFastGaussianLaw

印刷页 323–324 / PDF页 344–345。

### 1. 原文陈述

> Writing $F=\begin{bmatrix}0&1\\-\Omega^2&-\gamma\end{bmatrix}$, we can write down the solution to the fast dynamics as

$$
\binom{q(t)}{p(t)}=\exp(Ft)\binom{q(0)}{p(0)}+B_tR,
$$


> where $R$ is a column vector of two i.i.d. random normal numbers distributed as $\mathcal N(0,1)$, and

$$
B_tB_t^T=\frac{2\gamma}\beta\int_0^t\exp(F(t-s))\begin{bmatrix}0&0\\0&1\end{bmatrix}\exp(F^T(t-s))ds.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def fastExponential (Ω γ t : ℝ) : Mat2 := NormedSpace.exp (t • fastMatrix Ω γ)
def fastCovariance (Ω γ β t : ℝ) : Mat2 := fun i j ↦ 2*γ/β*∫ s in (0 : ℝ)..t,
  (fastExponential Ω γ (t-s)* (!![0,0;0,1] : Mat2)*(fastExponential Ω γ (t-s))ᵀ) i j
theorem exactFastGaussianLaw (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β t : ℝ) (x0 : Phase 1) (B : Mat2)
    (hX : fastLangevin P W X frequency γ β x0) (ht : 0 ≤ t)
    (hB : B*Bᵀ = fastCovariance frequency γ β t) :
    HasLaw (fun sample ↦ (![ (X t sample).1 0, (X t sample).2 0] : Fin 2 → ℝ))
      (Measure.map (fun R : Fin 2 → ℝ ↦
        fastExponential frequency γ t *ᵥ (![x0.1 0,x0.2 0] : Fin 2 → ℝ)+B*ᵥ R)
        (Measure.pi (fun _ : Fin 2 ↦ gaussianReal 0 1))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 陈述真实过程的转移分布，不将强解等于一组新独立R假设成结论。Bt只需给定平方根因子；正半定矩阵平方根存在性未另证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。

### 7. 状态与证明位置

- `MD.Ch07.fastExponential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastCovariance`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.exactFastGaussianLaw`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-MultipleTimestepUpdate

印刷页 324 / PDF页 345。

### 1. 原文陈述

> The solution to the slow part of our splitting is just

$$
\binom{q(t)}{p(t)}=\begin{bmatrix}1&0\\-t&1\end{bmatrix}\binom{q(0)}{p(0)}.
$$


> For a method taking one step of the fast system followed by a step of the slow system, using fixed step size $h>0$, we can write the update scheme for $z=[q,p]^T$ as

$$
z_{n+1}=Xz_n+YR_n,\qquad X=\begin{bmatrix}1&0\\-h&1\end{bmatrix}\exp(hF),\quad Y=\begin{bmatrix}1&0\\-h&1\end{bmatrix}B_h.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def multipleX (Ω γ h : ℝ) : Mat2 := slowMatrix h*fastExponential Ω γ h
def multipleY (h : ℝ) (B : Mat2) : Mat2 := slowMatrix h*B
def multipleStep (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) : Fin 2 → ℝ :=
  multipleX Ω γ h *ᵥ z+multipleY h B *ᵥ R
theorem multipleStep_composition (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) :
    multipleStep Ω γ h B R z = slowMatrix h *ᵥ (fastExponential Ω γ h *ᵥ z+B*ᵥ R) := by
  simp [multipleStep,multipleX,multipleY,Matrix.mulVec_add,Matrix.mulVec_mulVec]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 multipleX, multipleY, multipleStep, multipleStep\_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Rn为每步独立标准二维Gaussian；稳定分布分析仍要求真实独立序列及有限协方差，不能只以更新定义宣称存在平稳解。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 multipleX, multipleY, multipleStep, multipleStep\_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。

### 7. 状态与证明位置

- `MD.Ch07.multipleX`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleY`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleStep_composition`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-DeterminantTrace

印刷页 324 / PDF页 345。

### 1. 原文陈述

> Denoting $\eta=\sqrt{\gamma^2-4\Omega^2}$, then we compute

$$
\det(X)=e^{-\gamma h},\qquad \operatorname{tr}(X)=\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def traceFormula (γ h : ℝ) (η : ℂ) : ℂ :=
  (η-(h : ℂ))/η*Complex.exp ((η-(γ : ℂ))*(h : ℂ)/2)+
  (η+(h : ℂ))/η*Complex.exp ((-η-(γ : ℂ))*(h : ℂ)/2)
theorem determinantTrace (Ω γ h : ℝ) (η : ℂ) (hη : η^2 = (γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    Matrix.det (multipleX Ω γ h) = Real.exp (-γ*h) ∧
    ((Matrix.trace (multipleX Ω γ h) : ℝ) : ℂ) = traceFormula γ h η := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- η允许纯虚数；显式排除临界η=0，避免除零假公式。临界阻尼应取连续极限，另列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。

### 7. 状态与证明位置

- `MD.Ch07.traceFormula`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.determinantTrace`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-SpectralRadiusStability

印刷页 324 / PDF页 345。

### 1. 原文陈述

> The stability of the method therefore depends solely on the spectral radius of the matrix $X$. This gives a stability condition

$$
\left|\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}\right|\le1+e^{-\gamma h}.
$$


> Multiplying by $e^{\gamma h/2}$ gives

$$
|\cosh(\eta h/2)+(h/\eta)\sinh(-\eta h/2)|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def characteristicUnitDisk (X : Mat2) : Prop :=
  ∀ z : ℂ, z^2-((Matrix.trace X : ℝ) : ℂ)*z+((Matrix.det X : ℝ) : ℂ) = 0 → ‖z‖ ≤ 1
theorem spectralRadiusStability (X : Mat2) (hd : 0 < Matrix.det X) (hd1 : Matrix.det X < 1) :
    characteristicUnitDisk X ↔ |Matrix.trace X| ≤ 1+Matrix.det X := by
  sorry
def hyperbolicStability (γ h : ℝ) (η : ℂ) : Prop :=
  ‖Complex.cosh (η*(h : ℂ)/2)+(h : ℂ)/η*Complex.sinh (-η*(h : ℂ)/2)‖ ≤ Real.cosh (γ*h/2)

theorem multipleX_spectral_hyperbolic (Ω γ h : ℝ) (η : ℂ)
    (hγ : 0 < γ) (hh : 0 < h)
    (hη : η^2=(γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    characteristicUnitDisk (multipleX Ω γ h) ↔ hyperbolicStability γ h η := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述谱半径≤1的确定性边界资格；有非退化随机驱动时平稳二阶矩一般要求严格谱半径<1，等号并不自动给随机长期稳定。
- 正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。
- 29号覆盖限定：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。
- 覆盖缺口：正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。characteristicUnitDisk量化所有复特征根的模≤1；对实2×2矩阵且0<det<1，与|tr|≤1+det等价，抽象定理签名正确。hyperbolicStability只定义不等式；没有把multipleX、traceFormula、η²关系及η≠0联结到该条件的等价定理，故原条完整结论尚缺桥梁。EXTRA已说明此缺口，不能替代完整形式化。谱边界不等于Gaussian驱动的平稳有限方差条件。
网站复审结论：NEEDS\_HUMAN。四条Lean声明的对象、域、全部假设与结论均核对正确；在0<det X<1及γ>0,h>0,η²=γ²−4Ω²,η≠0的前提下，两个等价定理的签名成立。若只看明确缩小的确定性谱范围，可判PASS。全条依任务“原书数学疑误保留并判NEEDS\_HUMAN”的规则，仍需人工界定原印随机系统中的稳定性；不能把闭圆盘条件当成有限方差平稳性，也不能因sorry判FAIL。
按版本登记：四条闭单位圆谱声明签名PASS；不可把≤边界等同Gaussian噪声下有限二阶矩平稳性，η=0另留缺口。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。

### 7. 状态与证明位置

- `MD.Ch07.characteristicUnitDisk`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.spectralRadiusStability`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.hyperbolicStability`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleX_spectral_hyperbolic`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-HyperbolicPhaseTransform

印刷页 324 / PDF页 345。

### 1. 原文陈述

> For $\gamma>0$, we can simplify to

$$
\left|\cosh\left(\frac{\eta h}{2}-\operatorname{atanh}\left(\frac h\eta\right)\right)\sqrt{1-\frac{h^2}{\eta^2}}\right|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def hyperbolicPhase (η h : ℝ) : ℝ :=
  Real.cosh (η*h/2-Real.artanh (h/η))*Real.sqrt (1-h^2/η^2)
theorem hyperbolicPhase_identity (η h : ℝ) (hη : η ≠ 0) (hr : |h/η| < 1) :
    hyperbolicPhase η h = Real.cosh (η*h/2)-h/η*Real.sinh (η*h/2) := by
  have hh : h/η ∈ Set.Ioo (-1 : ℝ) 1 := abs_lt.mp hr
  have hs : Real.sqrt (1-(h/η)^2) ≠ 0 := by
    apply ne_of_gt
    apply Real.sqrt_pos.2
    have hsq : (h/η)^2 < 1 := (sq_lt_one_iff_abs_lt_one (h/η)).2 hr
    linarith
  simp only [hyperbolicPhase,Real.cosh_sub,Real.cosh_artanh hh,Real.sinh_artanh hh]
  rw [← div_pow]
  calc
    _ = (Real.cosh (η*h/2)-(h/η)*Real.sinh (η*h/2))/Real.sqrt (1-(h/η)^2)*Real.sqrt (1-(h/η)^2) := by ring
    _ = _ := div_mul_cancel₀ _ hs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅实η≠0、/h/η/<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实η版本必须补|h/η|<1，γ>0本身不足；复η需选择sqrt/artanh分支，原文未说明。只覆盖明确实域上的等式，不把所有γ>0都纳入。
- 29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。
- 覆盖缺口：29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。hyperbolicPhase\_identity对实η≠0及|h/η|<1的等式正确，额外实域前提明确且必要；展开cosh差公式即得cosh(a)−r sinh(a)。它没有覆盖纯虚η或实|h/η|≥1，也未给整个稳定不等式的全参数等价声明。不能由这个有效的受限等式确认原书对所有γ>0的措辞。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。

### 7. 状态与证明位置

- `MD.Ch07.hyperbolicPhase`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hyperbolicPhase_identity`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-UnderdampedPhasePrinted

印刷页 325 / PDF页 346。

### 1. 原文陈述

> We consider the case with $\gamma\ll\Omega$, allowing us to write $\eta=i\widehat\eta$ for $\widehat\eta\in\mathbb R$, and

$$
\left|\cos\left(\frac{\widehat\eta h}{2}-\operatorname{atanh}\left(\frac h{\widehat\eta}\right)\right)\sqrt{1+\frac{h^2}{\widehat\eta^2}}\right|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def underdampedPhasePrinted (η h : ℝ) : ℝ :=
  Real.cos (η*h/2-Real.artanh (h/η))*Real.sqrt (1+h^2/η^2)
def underdampedPhasePrinted_corrected (η h : ℝ) : ℝ :=
  Real.sqrt (1+(h/η)^2)*Real.cos (η*h/2+Real.arctan (h/η))
theorem underdampedPhase_identity (a r : ℝ) :
    Real.cos a-r*Real.sin a = Real.sqrt (1+r^2)*Real.cos (a+Real.arctan r) := by
  rw [Real.cos_add,Real.cos_arctan,Real.sin_arctan]
  have hs : Real.sqrt (1+r^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by positivity))
  field_simp
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文版与修正版分别定义，原文版不证明；直接用幅相恒等式绕过复函数分支。η̂=√(4Ω²-γ²)>0需要明确欠阻尼条件。
- 29号覆盖限定：字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。Printed定义忠实表达字面公式。corrected定义以及对任意实a,r的underdampedPhase\_identity均正确：cos(a)−r sin(a)=√(1+r²)cos(a+arctan(r))。这是代入η=iη̂后应得形式；η̂>0及η̂²=4Ω²−γ²的模型衔接未在该独立三角恒等式内声明。EXTRA正确承认这一点。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。

### 7. 状态与证明位置

- `MD.Ch07.underdampedPhasePrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.underdampedPhasePrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.underdampedPhase_identity`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-StabilityEnvelope

印刷页 325 / PDF页 346。

### 1. 原文陈述

> The oscillatory cosine term is bounded between $\pm1$, implying that we have stability for all step sizes provided the condition

$$
\sqrt{1+h^2/\widehat\eta^2}\le\cosh(\gamma h/2),\tag{7.49}
$$


> holds. We have guaranteed stability where (7.49) holds, which we can simplify to

$$
\frac h{\sqrt{4\Omega^2-\gamma^2}}\le\sinh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def stabilityEnvelope (η γ h : ℝ) : Prop := Real.sqrt (1+h^2/η^2) ≤ Real.cosh (γ*h/2)
theorem stabilityEnvelope_sufficient (η γ h : ℝ) (he : stabilityEnvelope η γ h) :
    |underdampedPhasePrinted_corrected η h| ≤ Real.cosh (γ*h/2) := by
  dsimp [underdampedPhasePrinted_corrected]
  calc
    _ ≤ Real.sqrt (1+(h/η)^2)*1 := by
      rw [abs_mul,abs_of_nonneg (Real.sqrt_nonneg _)]
      exact mul_le_mul_of_nonneg_left (Real.abs_cos_le_one _) (Real.sqrt_nonneg _)
    _ = Real.sqrt (1+h^2/η^2) := by rw [div_pow,mul_one]
    _ ≤ _ := he
theorem stabilityEnvelope_iff (η γ h : ℝ) (hη : 0 < η) (hγ : 0 ≤ γ) (hh : 0 ≤ h) :
    stabilityEnvelope η γ h ↔ h/η ≤ Real.sinh (γ*h/2) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 stabilityEnvelope, stabilityEnvelope\_sufficient, stabilityEnvelope\_iff 所列对象、量词、前提和结论。范围说明：sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用/cos/≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- “所有步长”指对每个h满足该条件；一次h的包络条件不能声称自动覆盖所有h。仍仅为谱模不超过1的充分条件，严格随机平稳性另需严格不等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用|cos|≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 stabilityEnvelope, stabilityEnvelope\_sufficient, stabilityEnvelope\_iff 所列对象、量词、前提和结论。范围说明：sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用|cos|≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。

### 7. 状态与证明位置

- `MD.Ch07.stabilityEnvelope`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.stabilityEnvelope_sufficient`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.stabilityEnvelope_iff`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-FrictionThresholdPrinted

印刷页 325 / PDF页 346。

### 1. 原文陈述

> The minimum required friction for stability can be found by considering the case of small timestep. This gives a bound

$$
\frac1{\sqrt{4\Omega^2-\gamma^2}}\le\frac\gamma2,
$$


> which gives a stability condition for all step sizes $h$ as long as

$$
\gamma\ge\Omega\sqrt{2-2\sqrt{1-\Omega^{-4}}}\ge\sqrt2/\Omega.
$$


> Therefore we expect that the minimum friction value required for stability for all timesteps $h>0$, scales with the value of inverse $\Omega$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def frictionThresholdPrinted (Ω : ℝ) : ℝ := Ω*Real.sqrt (2-2*Real.sqrt (1-Ω⁻¹^4))
def frictionThresholdPrinted_corrected (Ω : ℝ) : ℝ := Real.sqrt (2/(Ω^2+Real.sqrt (Ω^4-1)))
def frictionBoundPrinted (Ω γ : ℝ) : Prop :=
  frictionThresholdPrinted Ω ≤ γ ∧ Real.sqrt 2/Ω ≤ frictionThresholdPrinted Ω

def frictionBoundPrinted_corrected (Ω γ : ℝ) : Prop :=
  0 < γ ∧ γ < 2*Ω ∧ 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2

theorem frictionThreshold_rationalized (Ω : ℝ) (hΩ : 1 ≤ Ω) :
    frictionThresholdPrinted Ω = frictionThresholdPrinted_corrected Ω := by
  sorry
theorem frictionThreshold_allSteps (Ω γ : ℝ) (hΩ : 1 ≤ Ω) (hγ : 0 < γ) (hu : γ < 2*Ω)
    (hb : 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2) :
    ∀ h, 0 ≤ h → stabilityEnvelope (Real.sqrt (4*Ω^2-γ^2)) γ h := by
  sorry
theorem frictionThreshold_asymptotic :
    Filter.Tendsto (fun Ω : ℝ ↦ Ω*frictionThresholdPrinted_corrected Ω) Filter.atTop (𝓝 1) := by
  sorry
theorem frictionThreshold_squared_counterexample : (1 : ℝ) < 2/(5/4 : ℝ) := by norm_num
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 保留原精确根式，它本身与有理化修正版相同；疑误在后续比较方向/系数。欠阻尼上界γ<2Ω显式，不把该范围内的代数条件推广到任意大γ。
- 所有h包络由sinh x≥x推出，严格稳定与随机矩界仍需另证。反例给出有理平方数值，完整根式代入识别未另证明。
- 29号覆盖限定：字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。Printed定义及frictionBoundPrinted忠实保留错误链。rationalized在Ω≥1时正确；allSteps在Ω≥1、0<γ<2Ω及小步长包络斜率条件下推出所有h≥0的包络，正确；asymptotic极限为1正确。corrected的frictionBound保留隐式条件，避免仅用γ≥低根而漏掉高根上界。squared\_counterexample只有1<8/5的数值真命题，并未将其联结至Ω=√5/2的根式，所以不是Lean中完整的原命题反例；EXTRA已说明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。

### 7. 状态与证明位置

- `MD.Ch07.frictionThresholdPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThresholdPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionBoundPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionBoundPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_rationalized`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_allSteps`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_asymptotic`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_squared_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.1-ConfigurationalSampling

印刷页 262 / PDF页 283。

### 1. 原文陈述

> we often only wish to know the average of a given function $\phi(q)$ with respect the configurational density $\exp(-\beta U(q))$, where $U$ is the potential energy function of a molecular system.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def configurationalSamplingAverage (U φ : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, φ q ∂positionGibbs U β

def configurationalSamplingQualified (U φ : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧ Integrable φ (positionGibbs U β)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 configurationalSamplingAverage, configurationalSamplingQualified 所列对象、量词、前提和结论。范围说明：positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文省略归一常数；positionGibbs定义体保留实际配分积分。可积性与概率归一资格单列，不把未归一指数直接视为概率密度。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 configurationalSamplingAverage, configurationalSamplingQualified 所列对象、量词、前提和结论。范围说明：positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。

### 7. 状态与证明位置

- `MD.Ch07.configurationalSamplingAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.configurationalSamplingQualified`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.1-HamiltonianSamplingObstruction

印刷页 262 / PDF页 283。

### 1. 原文陈述

> Note that deterministic methods (e.g. Hamiltonian dynamics itself) can sometimes be used for molecular sampling, but without stochastic perturbation, such methods are not rigorously ergodic, since the Liouvillian operator does not possess a spectral gap and does not provide a unique stationary solution.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def energyConservingFlow (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧ ∀ t x, H (F t x) = H x

theorem energySublevel_invariant (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n)
    (hf : energyConservingFlow H F) (a t : ℝ) :
    (F t) ⁻¹' {x | H x ≤ a} = {x | H x ≤ a} := by
  ext x
  change H (F t x) ≤ a ↔ H x ≤ a
  rw [hf.2.2 t x]

def energyObstructionQualified (μ : Measure (Phase n)) (H : Phase n → ℝ)
    (F : ℝ → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure μ ∧ energyConservingFlow H F ∧
    (∀ t, MeasurePreserving (F t) μ μ) ∧
    ∃ a, MeasurableSet {x | H x ≤ a} ∧ 0 < μ {x | H x ≤ a} ∧ μ {x | H x ≤ a} < 1
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 本条只证明保能流的能量子水平集不变；结合非平凡概率质量可形成遍历性障碍。能量壳上的遍历性不能由原句否定。
- 原句未指定Liouvillian定义域、函数空间与参考概率。谱隙缺失和多个平稳解的完整算子陈述列为覆盖缺口，不把子水平集恒等式标作整段谱理论的证明。
- 29号覆盖限定：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。
- 覆盖缺口：29号覆盖限定：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。energyConservingFlow具有F0=id、全实时间流合成律及保能；energySublevel\_invariant对任意a,t给出原像集合相等，正确。Qualified补上概率、测度保持及一个可测且质量严格介于0和1的能量子水平集，足以解释全相空间遍历障碍，但它只是资格定义，不是非遍历性定理；尤其没有Liouvillian定义域、谱隙或多个平稳解的声明。statement\_scope已经诚实缩小，不据此声称整段谱理论已形式化。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。

### 7. 状态与证明位置

- `MD.Ch07.energyConservingFlow`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.energySublevel_invariant`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.energyObstructionQualified`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

