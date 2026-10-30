[上一部分](part03.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## MD-6.2.1-CoarseMarkovPrinted

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> Let $`A(x)`$, $`B(x)`$ and $`C(x)`$ be three events dependent on state variable $`x`$, and let $`t_+\gt t_0\gt t_-`$ be three times, then, for a Markov process $`X(t)`$ we have (using the notation for conditional probability):

$$
\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem coarseMarkovPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∀ (a b c : Set ℝ) (past present future : ℝ≥0),
    MeasurableSet a → MeasurableSet b → MeasurableSet c → past < present → present < future →
    0 < P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) →
    P ((W future ⁻¹' a) ∩ ((W present ⁻¹' b) ∩ (W past ⁻¹' c))) /
      P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) =
    P ((W future ⁻¹' a) ∩ (W present ⁻¹' b)) / P (W present ⁻¹' b) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。字面版在真实PreBrownian下量化任意可测事件a,b,c、past<present<future及正条件事件概率，ENNReal比值忠实表达印刷条件概率式。但原书把完整当前状态换成任意粗事件，一般错误，须保留疑误而不因字面忠实判数学正确。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.coarseMarkovPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:807`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-StateMarkovMeaning

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> More generally, when we say that a stochastic process is Markovian, we mean that the probability of a future event conditioned on the current state of the process and the past history of the process is the same as the probability conditioned on the current state of the process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))

/-- 修正版，对应原文 MD-6.2.1-CoarseMarkovPrinted；改动：以完整当前状态生成的σ代数写条件期望Markov性质。 -/
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：原版及coarseMarkovPrinted\_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原版及coarseMarkovPrinted\_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。

### 6. 审计结论（含网站结论）

网站原返回：PASS。stateMarkovMeaning与coarseMarkovPrinted\_corrected完全相同：概率空间、每时X可测、history严格等于0≤r≤s的全部自然历史；对s≤t及所有可测实事件a，未来事件指标关于历史与当前状态的条件期望AE相等。指标可积且两个σ代数从X的可测性均小于环境σ代数，排除了任意history和默认零条件期望的伪性质。是实值过程标准自然历史Markov定义，两版PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stateMarkovMeaning` | 定义 | — | PASS |
| `MD.Ch06.coarseMarkovPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:819`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-RiemannTags

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> Recall that the Riemann integral of a continuous function $`g`$ on $`[0,\tau]`$ is the limit of Riemann sums constructed as follows: partition the interval $`[0,\tau]`$ into $`K`$ subintervals each of width $`\delta t=\tau/\nu`$, choose an arbitrary $`t_k`$ from the $`k`$th subinterval, $`1\leq k\leq \nu`$, and evaluate the integral as a limit of the sum of products:

$$
\int_0^\tau g(t)dt=\lim_{\nu\to\infty}\sum_{k=0}^{\nu-1}g(t_k)\delta t.
$$


> We know that this limit does not depend on where the $`t_k`$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem riemannTags : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem riemannTags_corrected : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]非负窗口和所有合法任意tags；完整标签无关性，没有缩减为仅左端点特例。
- [EXTRA] 原书文字1≤k≤ν与求和0≤k<ν冲突；本条数学修正版统一0≤k<ν，原句保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。riemannTags与riemannTags\_corrected都对任意连续于[0,T]的g、T≥0及所有合法tag族陈述均匀网格Riemann和趋于区间积分。K>0和k<K只用于标签条件，K=0单项不影响atTop极限；T=0也正确。任意端点或内部tag均包含，未降成左端点特例。两个数学签名PASS，但这是统一索引后的版本，原文索引疑误应保留NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.riemannTags` | 未证 | 时间盒止 | PASS |
| `MD.Ch06.riemannTags_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:841`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-ItoLeftSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。W,g是实时间随机函数，任意T和K的有限和；左端点kT/K与相应W增量均正确，range K精确为0到K−1；仅定义有限和，不断言存在极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.itoLeftSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:857`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StrictItoIntegral

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.
> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)

/-- 修正版，对应原文 MD-6.2.2-WeakItoAlias；改动：严格定义要求每个有限和及极限变量均属于L²；正式库冻结，只在Blueprint使用严格版。 -/
def weakItoAlias_corrected {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式所有有限和与极限的L²资格，防止Bochner非可积默认值0伪造均方收敛；真实取样和极限，不假设任何求值结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意P、W,g,T,Y；每个有限和及Y均MemLp 2，再要求误差平方积分趋零。D16取样相符。所附weakItoAlias\_corrected逐项相同，合理修复第16条非可积默认值漏洞；作为L²均方积分定义不声称所有g可积。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictItoIntegral` | 定义 | — | PASS |
| `MD.Ch06.weakItoAlias_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:863`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-WeakItoAlias

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> where the increments $`W((k+1)\delta t)-W(k\delta t)`$ identified here are the increments of a Wiener process whose properties are given above. (In particular they are normally distributed with mean zero and variance $`\delta t`$.) First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.
> Next, unlike in the case of the Riemann sums, it turns out that the result depends on where we place the points $`t_k`$. Using the properties of the Wiener process we may easily show that the choice $`t_k=k\delta t`$ (left endpoint) and the choice $`t_k=(k+1/2)\delta t`$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weakItoAlias {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weakItoAlias是任意测度P、过程W,g、实T和候选Y的均方左和极限关系：每个K的itoLeftSum及Y均为L²，平方误差积分趋0。D3的和确用左端点kT/K和相邻W增量。L²前提排除了不可积函数Bochner默认零的漏洞。作为左和极限关系定义PASS；P不是自动概率、W不是自动Wiener、g不是自动适应，此定义本身不授予标准Itô积分的存在性或一般等距性质，不能扩充解释。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weakItoAlias` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:878`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StratonovichSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实时间中点((k+1/2)T/K)处取g值，而非端点g均值；W增量及0到K−1索引均正确。只定义原书中点和，不声称对任意随机g等于一般Stratonovich积分。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stratonovichSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:884`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoFiniteIdentity

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> As an example, consider the case where $`g(t)=W(t)`$. We suppose this to be approximated by a sum

$$
\int_0^\tau W(t)dW(t)\approx\sum_{k=0}^{\nu-1}W(k\delta t)[W((k+1)\delta t)-W(k\delta t)],
$$



$$
=\frac12\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2-(W((k+1)\delta t)-W(k\delta t))^2].
$$


> Breaking this into two parts, we see that the first sum telescopes to give $`W(\tau)^2`$ (as $`W(0)=0`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoFiniteIdentity {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ sample ∂P, 2 * textbookWienerSelfItoSum W T K sample =
      W T sample ^ 2 - textbookWienerQuadraticSum W T K sample := by
  apply MolecularDynamics.textbookWienerSelfItoSum_identity <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实PreBrownian、K>0和AE W0=0；保存完整有限和望远镜恒等。

### 6. 审计结论（含网站结论）

网站原返回：PASS。K>0，PreBrownian给W0=0几乎处处；D18左和与D17平方增量和构成2S=W(T)^2−Q的AE有限恒等，完整保留望远镜结果而没有把积分极限偷当前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoFiniteIdentity` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:890`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-Proposition62

印刷p.229–230 / PDFp.250–251；§6.2.2。

### 1. 原文陈述

> Proposition 6.2 Let $`\nu\delta t=\tau`$ then

$$
\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,
$$


> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$


> (This is referred to as convergence in the mean square sense.)

### 2. 原文证明

> With $`\tau,\nu`$ fixed, we have $`\delta t=\tau/\nu`$.
> Let $`\Delta W_{\nu,k}=W((k+1)\delta t)-W(k\delta t)=W((k+1)\tau/\nu)-W(k\tau/\nu)`$ and observe that

$$
\sum_{k=0}^{\nu-1}\Delta W_{\nu,k}^2-\tau=\sum_{k=0}^{\nu-1}[\Delta W_{\nu,k}^2-\delta t].
$$


> Then

$$
I_\nu\stackrel{\rm def}=\mathbb E(\sum_{k=0}^{\nu-1}\Delta W_{\nu,k}^2-\tau)^2=\mathbb E(\sum_{k=0}^{\nu-1}[\Delta W_{\nu,k}^2-\delta t])^2.
$$


> Terms of the form $`Z_{\nu,k}\stackrel{\rm def}=\Delta W_{\nu,k}^2-\delta t`$ are independent and have mean zero. Therefore

$$
\mathbb E(\sum_{k=0}^{\nu-1}Z_{\nu,k})^2=\mathbb E\sum_{k=0}^{\nu-1}Z_{\nu,k}^2-2\mathbb E\sum_{k\ne l}Z_{\nu,k}Z_{\nu,l}=\mathbb E\sum_{k=0}^{\nu-1}Z_{\nu,k}^2,
$$


> where the last equation follows from independence of the increments ($`\mathbb E Z_kZ_l=0`$ if $`k\ne l`$).
> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$


> Thus we have

$$
I_\nu=\sum_{k=0}^{\nu-1}\mathbb E(\Delta W_{\nu,k}^2-\delta t)^2 =\sum_{k=0}^{\nu-1}\mathbb E[\Delta W_{\nu,k}^4-2\delta t\Delta W_{\nu,k}^2+\delta t^2] =\sum_{k=0}^{\nu-1}[3\delta t^2-2\delta t^2+\delta t^2]=2\nu\delta t^2=2\tau^2/\nu.
$$


> Thus $`I_\nu\to0`$ as $`\nu\to0`$, which is the desired result.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition62 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 修正版，对应原文 MD-6.2.2-Proposition62；改动：保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。 -/
theorem proposition62_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 【原书疑误】p.229错误交叉项展开；双变量形式，原文不证。 -/
def proposition62Printed (x y : ℝ) : ℝ := x^2+y^2-4*x*y

/-- 修正平方展开；有序交叉和的系数为+1。 -/
theorem proposition62Expansion_corrected (x y : ℝ) : (x+y)^2=x^2+y^2+2*x*y := by
  ring

theorem proposition62Printed_counterexample : ¬ ((1+1 : ℝ)^2=1^2+1^2-4*1*1) := by
  norm_num
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian law、τ≥0、全部均方极限；印刷最后K→0是笔误，更正K→∞。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。proposition62及proposition62\_corrected：实际IsPreBrownianReal、T≥0，均匀网格平方增量和的均方误差atTop趋0，签名正确。WienerTime=k*T/K、WienerIncrement为相邻差、QuadraticSum为Fin K平方和，均核对。proposition62Printed定义x²+y²-4xy，忠实记录按有序k≠l理解印刷展开的两变量表达；未将错误式当定理。proposition62Expansion\_corrected的普通平方展开正确；proposition62Printed\_counterexample在x=y=1正确。原书一般代数展开错误虽因独立零均值而不改变期望最终结果，仍需标疑误；末极限应为ν→∞。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition62` | 已证 | — | PASS |
| `MD.Ch06.proposition62_corrected` | 已证 | — | PASS |
| `MD.Ch06.proposition62Printed` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.proposition62Expansion_corrected` | 已证 | — | PASS |
| `MD.Ch06.proposition62Printed_counterexample` | 已证 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:900`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-MeanSquareConvergence

印刷p.229 / PDFp.250；§6.2.2。

### 1. 原文陈述

> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式L²随机变量资格防止非可积Bochner默认值；不假设收敛结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义量化所有K的L²资格、B的L²资格及误差平方期望趋零；比印刷速记补足合法均方随机变量域，[EXTRA]已明确。并非仅形式Bochner默认0。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.meanSquareConvergence` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:925`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-WienerMidpointSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> The choice $`t_k=k\delta t`$ (left endpoint) and the choice $`t_k=(k+1/2)\delta t`$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def wienerMidpointSum {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun sample ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) sample *
    textbookWienerIncrement W T K k sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Fin K上取W((2k+1)T/(2K))乘整步增量，K>0时精确时间中点；K=0为空和。虽有未使用的P隐参，不改变数学内容。仅g=W辅助定义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerMidpointSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:931`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementMean

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0 := by
  rw [hX.integral_eq, integral_id_gaussianReal]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]任意真实中心Gaussian完整法则推出零均值；增量law桥接先前已保存。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意HasLaw X (gaussianReal 0 v) P，v≥0，推出期望0；真实增量法则在第7条提供。此条只承载三项矩公式的第一项，其余分别由第23、24条承载。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementMean` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:937`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementSecond

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementSecond {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 2 ∂P) = (v : ℝ) := by
  apply MolecularDynamics.textbookCenteredGaussian_secondMoment <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同一中心Gaussian完整法则推出二阶矩v，包括v=0；未把二阶矩作为前提，网格代入v=T/K与原式一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementSecond` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:944`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementFourth

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementFourth {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 4 ∂P) = 3 * (v : ℝ) ^ 2 := by
  apply MolecularDynamics.textbookCenteredGaussian_fourthMoment <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意中心Gaussian完整法则推出四阶矩3v²，包括退化v=0；并未遗漏四次幂或误用标准差。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementFourth` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:951`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-QuadraticMeanSquareError

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Thus we have

$$
I_\nu=\mathbb E\sum_{k=0}^{\nu-1}(\Delta W_{\nu,k}^2-\tau/\nu)^2 =\sum_{k=0}^{\nu-1}\mathbb E\left(\Delta W_{\nu,k}^4-2\frac{\tau}{\nu}\Delta W_{\nu,k}^2+\frac{\tau^2}{\nu^2}\right) =\sum_{k=0}^{\nu-1}\left(3(\tau/\nu)^2-2(\tau/\nu)^2+\tau^2/\nu^2\right)=2\frac{\tau^2}{\nu^2}\nu=2\frac{\tau^2}{\nu}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem quadraticMeanSquareError {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquareError <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian且K>0；精确误差，不是仅Tendsto0。

### 6. 审计结论（含网站结论）

网站原返回：PASS。T≥0，K>0，实际PreBrownian平方增量和的整体误差平方期望精确等于2T²/K；不是仅逐项矩或仅极限。D14、15、17的网格与原书一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.quadraticMeanSquareError` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:958`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoIntegral

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> The calculation implies that

$$
\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerSelfItoSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = (W T sample ^ 2 - (T : ℝ)) / 2 := by
  apply MolecularDynamics.textbookWienerSelfItoIntegral_exists <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实L²见证、全均方收敛及AE求值三项保留；有限和L²另条补足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在Y∈L²、真实D18左和整体均方趋于Y、Y几乎处处等于(W(T)²−T)/2三项齐全。任意T≥0；没有把积分求值当前提。有限和L²不在此签名显式陈述，但对PreBrownian有限Gaussian乘积成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoIntegral` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:966`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfStratonovichIntegral

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> In contrast, the Stratonovich (midpoint) integral (denoted by $`\int_0^\tau\circ dW(t)`$) can be calculated as

$$
\int_0^\tau W(t)\circ dW(t)=\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].
$$


> Writing

$$
W(k\delta t+\delta t/2)=W(\frac{(k+1)\delta t+k\delta t}{2})=\frac12(W((k+1)\delta t)+W(k\delta t))+O(\sqrt{\delta t}),
$$


> allows us to evaluate the integral as

$$
\int_0^\tau W(t)\circ dW(t)=\frac12\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2]=\frac12W(\tau)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfStratonovichIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem selfStratonovichIntegral_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实时间中点和、L²见证、整体均方极限、AE求值；原O(√δt)单步启发不足，正式整体均方误差证明不直接丢弃逐步残项。
- [EXTRA] 仅覆盖真实时间中点和的均方结论；原单步O(√dt)推理未控制总误差，不能当成完整证明；所需Brownian桥残差估计未补建。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。selfStratonovichIntegral及\_corrected在IsPreBrownianReal、T≥0下给出L²见证Y、真实时间中点和的均方收敛及Y=W(T)²/2的AE求值，数学签名PASS。MidpointSum确取2K细网格的2k+1时刻，并非端点值平均。布朗增量Gaussian四阶矩保证各和及极限的资格。原书将单步中点桥差O(sqrt(dt))直接舍掉未控制总和，不能单凭该行作完整证明；两相同定理签名没有解决原书论证缺口。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfStratonovichIntegral` | 已证 | — | PASS |
| `MD.Ch06.selfStratonovichIntegral_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:976`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-Proposition63

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Proposition 6.3 Let $`g`$ be a smooth deterministic function and $`W(t)`$ a Wiener process. The stochastic integral $`Y(t)=\int_0^t g(s)dW(s)`$ is, for all times $`t\geq0`$, a normally distributed random variable such that

$$
\mathbb E(Y(t))=0;\quad\mathbb E(Y^2(t))=\sigma^2(t)=\int_0^t g(s)^2ds.
$$



### 2. 原文证明

> See Exercise 2.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition63 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerDeterministicSum W g T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ sample, Y sample ∂P) = 0 ∧ (∫ sample, Y sample ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  apply MolecularDynamics.textbookWienerDeterministicIto_proposition63 <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian与C¹ g已足；完整构造L²见证、均方极限、Gaussian law、零均值及二阶矩，不仅保存矩。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意T≥0、PreBrownian及C¹实确定函数g；存在Y∈L²，实际左和均方收敛；Gaussian完整法则的方差是∫g²的toNNReal（非负故不截断值）；均值0及二阶矩等于∫g²齐全。C¹比原smooth弱且足够。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition63` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:993`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-QuadraticSumExpectation

印刷p.229 / PDFp.250；§6.2.2。

### 1. 原文陈述

> On the other hand, from (6.7), we have

$$
\lim_{\nu\to\infty}\mathbb E\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem quadraticSumExpectation {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, textbookWienerQuadraticSum W T K sample ∂P) = (T : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_integral <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际上每个K>0有限和期望已经恰等于τ；均方极限在Prop6.2保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。K>0时平方增量有限和期望已经等于T，较原文极限式强并直接蕴含它；[EXTRA]准确注明。非负窗口、真实PreBrownian及完整和均保留。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.quadraticSumExpectation` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1004`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoLimitL2

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoLimitL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun sample ↦ (W T sample ^ 2 - (T : ℝ)) / 2) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoLimit_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。签名只证明候选极限(W(T)²−T)/2的MemLp 2 P，数学正确。extra\_assumptions声称“有限和/候选极限”两者L²，但此签名没有有限和L²结论，须缩减标注。引文实际在印刷228页，并不在所配附件第39页（印刷230）。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoLimitL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1011`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoSumsL2

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> The calculation implies that

$$
\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoSum_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Ω任意可测空间，P任意测度但hW给出PreBrownian资格；T非负、K正。结论仅左点有限乘积和属于L²，没有候选极限或收敛结论。有限联合Gaussian的四阶矩足够，签名正确；[EXTRA]中的“候选极限”超出本声明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoSumsL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1018`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-MidpointSumsL2

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> In contrast, the Stratonovich (midpoint) integral (denoted by $`\int_0^\tau\circ dW(t)`$) can be calculated as

$$
\int_0^\tau W(t)\circ dW(t)=\mathrm{l.i.m.}_{ u\to\infty}\sum_{k=0}^{ u-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem midpointSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerMidpointSum_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同第1条的空间/测度资格；T≥0、K>0；依D1、D2及所列定义，采样时间为(2k+1)T/(2K)，乘整段增量。仅有限和MemLp 2正确；未证明候选极限资格或收敛。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.midpointSumsL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1025`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

