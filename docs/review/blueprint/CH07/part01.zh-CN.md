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

