上一部分：无 / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

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


> where $`W`$ defines a standard scalar Wiener process.

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


> where $`R_n`$ is a normal random variable with zero mean and unit variance. This method is referred to as the Euler-Maruyama method.

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

> For $`\alpha=1`$ this implies convergence of expectation. The more natural choice from the probabilistic point of view is $`\alpha=2`$ (mean square convergence).

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

> Having settled on a choice of $`\alpha`$, we say that a method has strong order $`r`$ if
> $`\mathrm{Err}_{h,\tau}^{\rm strong}\lt C(\tau)h^r`$ for some coefficient $`C(\tau)`$ depending on the time interval.

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

> The weak error is usually defined with reference to suitable test functions (observables) $`\phi(x)`$ by

$$
\mathrm{Err}^{\rm weak}_{h,\tau,\phi}=\max_{n=0,1,2,\ldots,\nu}|\mathbb E\phi(X_n)-\mathbb E\phi(X(nh))|,
$$


> and we say that a method has weak order $`r`$ if $`\mathrm{Err}^{\rm weak}_{h,\tau,\phi}\lt D(\tau)h^r`$ for some $`D(\tau)`$, for all members of the chosen class of observables.

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

> Recall that for canonical sampling, the (stationary or invariant) average of an observable $`\phi(q,p)`$ is given as

$$
\operatorname{Av}_\beta(\phi)=\int_D\phi(q,p)\rho_\beta(q,p)d\omega,\tag{7.1}
$$


> where $`\rho_\beta`$ is the canonical measure

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

> and $`Z_{\rm can}`$ is the canonical partition function

$$
Z_{\rm can}^{-1}=\int_D\exp(-\beta H(q,p))d\omega,
$$


> ensuring the integral of $`\rho_\beta`$ is unity.

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

> In this chapter, we will abbreviate the exact average of the observable $`\phi`$ to

$$
\langle\phi\rangle\overset{\rm def}=\operatorname{Av}_\beta(\phi),
$$


> and write the observed average computed in experiment (using a discretization method with step size $`h`$) as $`\langle\phi\rangle_h`$. The error in the average of $`\phi`$ due to the perfect sampling bias can be evaluated as

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

> Integrating from $`t`$ to $`t+h`$ and multiplying by $`\exp(-\gamma t)`$, we arrive at the solution

$$
p(t+h)=e^{-\gamma h}p(t)+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}Z,\tag{7.3}
$$


> where $`Z`$ is a vector of independent, standard normal random variables.

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


> with normally distributed $`R`$. For later purposes, we will think of this update as acting on both $`q`$ and $`p`$, leaving $`q`$ unchanged, i.e.

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

> Alternatively, if we ignore the physical origin of this parameter, we can think of $`\gamma`$ as an arbitrary coefficient; the sampling of the invariant measure does not depend on this choice. Thus we have a family of sampling iterations for the Gaussian distribution, defined for different choices of $`\gamma`$.

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

> Since Hamiltonian dynamics leaves invariant any function of the energy, its corresponding Fokker-Planck operator (in this case the Liouvillian, $`\mathcal L_H^\dagger=-\mathcal L_H`$) will preserve distributions that are functions of the Hamiltonian $`H`$. This implies in particular that it preserves $`\rho_\beta`$, which is proportional to $`\exp(-\beta H)`$. Thus the forward propagator associated to the Hamiltonian system automatically preserves the Gibbs distribution, and we have

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


> where $`R`$ is a vector of i.i.d. normal random numbers.

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

> For example, the method denoted $`[ABO]`$ (acting from left to right) has a resulting update

$$
\mathcal U_h^{[ABO]}=\mathcal U_h^O\circ\mathcal U_h^B\circ\mathcal U_h^A.
$$


> An alternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme denoted $`[BABO]`$ with associated map

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

> As a result we use the convention that if a letter appears $`k`$ times in a method's string, then each individual update piece uses a timestep $`h/k`$. For example, the scheme denoted $`[OABOAOBAO]`$ has an update

$$
\mathcal U_h^{[OABOAOBAO]}=\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O,
$$


> where the random numbers used in each O update are independent. This scheme will require a total of $`4N_c`$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.

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


> where $`\zeta_j=[k_BT(1-e^{-j\gamma h})]^{1/2}`$, and $`R_n,R_{n+1/2}`$ are $`N_d`$ vectors of standard independent $`\mathcal N(0,1)`$ random variables, resampled at each step.

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

> When iterated $`n+1`$ times, we can see the scheme $`[OABA]`$ produces a mapping of the form

$$
(\mathcal U_h^{[OABA]})^{n+1}=\mathcal U_{h/2}^A\circ\mathcal U_{h/2}^B\circ(\mathcal U_h^{[BAOAB]})^n\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/2}^A\circ\mathcal U_h^O;
$$


> therefore through a coordinate transformation the $`[OABA]`$ method can be morphed into the $`[BAOAB]`$ scheme.

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


> where $`\eta=(1-e^{-h\gamma})/\gamma`$, $`\zeta=[k_BT(1-e^{-2\gamma h})]^{1/2}`$.

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

> It is important to note that in the limit of infinite friction, we have $`\eta\to0`$ independent of the timestep $`h`$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $`\gamma`$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.

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


> Often $`R'`$ is chosen such that $`R'_n=R_{n+1}`$, so the random vector would be reused at the start of the following timestep, however there are many variants of this scheme that incorporate the redraw of random numbers differently. In other variants of BBK we take $`R'_n=R_n`$, reusing the random number within the step.

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

> Recall that the one-dimensional harmonic oscillator with spring constant $`\Omega^2`$ has potential energy function $`U(q)=\Omega^2q^2/2`$, with Hamiltonian

$$
H(q,p)=\frac{p^2}{2m}+\frac{\Omega^2q^2}{2},\tag{7.6}
$$


> where $`(q,p)\in\mathbb R^2`$ represent a particle's position and momentum, and $`m\gt 0`$ is the particle's mass.

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

> In this setting, the canonical distribution $`\rho_\beta`$ is the product of two Gaussian distributions, where we have invariant (stationary) averages

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


> where $`\Psi`$ is a constant matrix that depends on the stepsize $`h`$, the friction coefficient $`\gamma`$, the particle mass $`m`$ and the spring constant $`\Omega`$. Additionally $`\mu_n`$ is a vector of stochastic processes.

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

> More generally, if we define the components of $`\Psi`$ as $`\psi_{ij}`$ and denote $`\mu_n=[\mu_{n,1},\mu_{n,2}]^T`$ we can take products of the update equations defined by (7.7) to obtain

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

> Hence we have $`\mathbb E(\mu_{n,i}q_n)=\mathbb E(\mu_{n,i}p_n)=0`$, for any $`i`$ and $`n`$. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then considering the limit $`n\to\infty`$ we obtain a closed, linear system of equations

$$
Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+\bar\mu_{11},
$$



$$
P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+\bar\mu_{22},
$$



$$
C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\bar\mu_{12},\tag{7.11}
$$


> where $`\bar\mu_{11}=\mathbb E(\mu_{n,1}^2)`$, $`\bar\mu_{12}=\mathbb E(\mu_{n,1}\mu_{n,2})`$, $`\bar\mu_{22}=\mathbb E(\mu_{n,2}^2)`$.

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

> Example 7.1 Consider the scheme coded $`[ABO]`$.
> In the case of the one-dimensional harmonic oscillator, we have $`U'(q)=\Omega^2q`$, yielding the compact form of one iteration as

$$
\binom{q_{n+1}}{p_{n+1}}=\begin{bmatrix}1&h/m\\-\Omega^2he^{-h\gamma}&(1-\Omega^2h^2/m)e^{-h\gamma}\end{bmatrix}\binom{q_n}{p_n}+\binom0{\zeta m^{1/2}R_n}.\tag{7.12}
$$


> Taking expectations of (7.12) and then taking the limit as $`n\to\infty`$, we see immediately that
> $`\langle q\rangle_h^{[ABO]}=\langle p\rangle_h^{[ABO]}=0`$, as $`\mathbb E(R_n)=0`$.

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

> For example, the relative increase in the variance of position is computed for the $`[ABO]`$ scheme as

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

> For example, analysis shows that the schemes denoted $`[AOAB]`$ or $`[BAOA]`$ both exhibit a first order error in the covariance $`\langle qp\rangle_h=O(h)`$, however they give exact results for both $`\langle q^2\rangle_h`$ and $`\langle p^2\rangle_h`$.

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


> where $`R_n`$ is a vector of normal random numbers with zero mean and unit variance.

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

