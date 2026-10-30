[上一部分](part04.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

## MD-6.2.2-DeterministicIntegralProcess

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Also it is natural to view the stochastic integral as the solution of the stochastic differential equation (SDE) with zero initial condition:

$$
dY(t)=g(t)dW(t);\quad Y(0)=0.\tag{6.8}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部非负时间真实严格L²积分关系；Y0=0从零时间L²极限导出，不能把单时Gaussian独立采样当同一过程。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对同一W,Y以及确定g，量化全部T≥0，D5要求每个有限左点和及Y T的L²资格和均方收敛。T=0的和恒零，所以Y 0=0几乎处处。作为积分关系定义正确；未独立断言W是Wiener、过程路径连续或同时逐样本等式，使用时须另给W资格。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicIntegralProcess` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1032`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicStrobePrinted

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Finally, we observe that by calculating $`\sigma^2(t_n)`$ and generating random increments $`R_n\sim N(0,\sigma(t_n))`$ we have a discrete representation of the continuous time stochastic process $`Y(t)`$, effectively an exact stroboscopic representation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem deterministicStrobePrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  ∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 ((Real.sqrt (∫ s in (0 : ℝ)..times k, g s^2))^2).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Printed保留原书累计尺度N(0,σ(t\_n))；将第二参数解释为标准差并平方传入gaussianReal是额外约定，需确认。本条未摘录所称相邻区间方差与整族独立性的修正版，不能认证该修正版。
- [EXTRA] 复审范围：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
- 覆盖缺口：本条未提供[EXTRA]声称的独立修正版完整声明，无法审校其相邻区间方差及整族独立性。
- 覆盖缺口：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。deterministicIntegralProcess为每个T≥0的严格均方积分资格，已核对。deterministicStrobePrinted把第k到k+1观测的增量分布方差写成0到times k的累计∫g²（对sqrt再平方），保留了原书增量/边际混淆。N(0,σ)按标准差理解是额外约定；此前书中W(t)∼N(0,t)使用方差式习惯，更需人工确认。[EXTRA]与statement\_scope声称独立修正版包含相邻区间方差和整族独立性，但本条全部摘录没有任何相应\_corrected声明；不能认证未提供的修正版，coverage\_gaps=[]不实。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicStrobePrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1039`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicStrobeCorrected

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Finally, we observe that by calculating $`\sigma^2(t_n)`$ and generating random increments $`R_n\sim N(0,\sigma(t_n))`$ we have a discrete representation of the continuous time stochastic process $`Y(t)`$, effectively an exact stroboscopic representation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem deterministicStrobeCorrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry

/-- 修正版，对应原文 MD-6.2.2-DeterministicStrobePrinted；改动：采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。 -/
theorem deterministicStrobePrinted_corrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]相邻时间积分g²为完整增量方差，并保存整个增量族独立性；不是仅单时law；强L²模型。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PreBrownian、C¹确定g、全部时间严格积分关系、非负单调times足够；各相邻增量的variance为∫[times k,times(k+1)]g²，并断言整个族iIndepFun。允许相等时刻，退化零增量正确。修正数学合理；若称完整stroboscopic表示，应从实际Y(times 0)初始化，或另设times 0=0。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicStrobeCorrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.deterministicStrobePrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1049`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StochasticDifferentialIntegral

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Importantly, with appropriate regularity we have the familiar relation from calculus:

$$
\int_0^t dY(s)=Y(t)-Y(0).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)
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

网站原返回：PASS。P,Y及integralOfDifferential均任意，对全部T≥0断言两随机变量几乎处处相等。按context\_notation，这是积分符号的语义定义；没有循环地声称已构造一般积分或证明链式法则。无需样本普通导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stochasticDifferentialIntegral` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1069`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalk

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> We introduce a pair of smooth functions $`a(x,t)`$ and $`b(x,t)`$, where $`a`$ represents a drift tendency and $`b`$ the average magnitude of the random jump. In the interval $`[n\delta t,(n+1)\delta t]`$, a step $`\delta X_n=X_{n+1}-X_n`$ of the random walk will be given by

$$
\delta X_n=a(X_n,t_n)h+b(X_n,t_n)J_n\delta x.\tag{6.9}
$$


> where the random increment $`J_n`$ was introduced in Sect. 6.2.1.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]按正文h=δt及δx=√δt解释真实递归与x0初值；印刷h/δt记号不一致已保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。递归以x0起始；第n步在n*dt取a,b，漂移a*dt，噪声b*sqrt(dt)*J\_n，次序和乘法正确。MD包装调用Chapter06Review的旧步值，按D10/D11展开逐步一致。作为确定性递归定义允许任意dt,a,b,J；随机游走解释另需dt>0和Rademacher资格。[EXTRA]将h解释为δt需标为解释而非书中显式等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1075`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalkSum

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Choose a positive $`t`$ and sum (6.9) from $`n=0`$ to $`\nu-1`$, where $`\nu=\lfloor t/\delta t\rfloor`$, obtaining

$$
X_\nu-X_0=\sum_{n=0}^{\nu-1}\delta X_n=\sum_{n=0}^{\nu-1}a(X_n,t_n)\delta t+\sum_{n=0}^{\nu-1}b(X_n,t_n)J_n\delta x.\tag{6.10}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem biasedWalkSum : ∀ {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) (K : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 K sample-x0 =
    (∑ k ∈ Finset.range K, a (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*dt) +
    ∑ k ∈ Finset.range K, b (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*Real.sqrt dt*J k sample := by
  intro Ω a b J dt x0 K sample
  induction K with
  | zero => simp [MolecularDynamics.Chapter06Review.biasedWalk]
  | succ K ih =>
    simp only [MolecularDynamics.Chapter06Review.biasedWalk, Finset.sum_range_succ]
    linarith [ih]
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

网站原返回：PASS。对任意K∈ℕ、任意sample作递归望远镜求和，K=0也成立。K泛化原ν，不丢失原结论；dt和系数无正性/随机性限制也不影响此代数恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalkSum` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1082`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-ScalarSDE

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Take the diffusion limit $`\delta t\to0`$, $`\delta x^2/\delta t\to1`$ with $`\nu\delta t=t`$ fixed, then we obtain, under the Itô convention,

$$
X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).\tag{6.11}
$$



$$
dX=a(X,t)dt+b(X,t)dW.\tag{6.14}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实连续路径、实际可积漂移及全部有限和L²的Ito极限；是方程意义，不计随机游走扩散极限已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D19保留连续路径和确定初值的共同AE集合；每个T≥0漂移路径区间可积，并以完整残差作严格Ito积分。a,b仍状态和时间依赖。作为方程关系定义可接受；[EXTRA]正确说明未由此证明游走极限，W及适应性资格应由使用环境另给。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictScalarSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1096`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-VectorSDE

印刷p.232–233 / PDFp.253–254；§6.3。

### 1. 原文陈述

> We mention in passing the extension to systems of SDEs. Let $`a(z,t)`$ and $`b^{(i)}(z,t)`$, $`i=1,2,\ldots,r`$ be a set of $`r+1`$ vector fields in $`\mathbb R^m`$, and let $`W_1,W_2,\ldots,W_r`$ be a collection of $`r`$ independent Wiener processes, then we may write a system of SDEs in $`\mathbb R^m`$ in the form

$$
dZ=a(Z,t)dt+\sum_{i=1}^r b^{(i)}(Z,t)dW_i.\tag{6.15}
$$


> alternatively, if $`B`$ is the matrix with columns $`b^{(1)},b^{(2)},\ldots,b^{(r)}`$, and $`W`$ represents the $`r`$-component vector of Wiener processes, then

$$
dZ=a(Z,t)dt+B(Z,t)dW.\tag{6.16}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictVectorSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → ℝ → (Fin n → ℝ))
    (B : (Fin n → ℝ) → ℝ → Matrix (Fin n) (Fin r) ℝ) (x0 : Fin n → ℝ) : Prop :=
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s i) volume 0 T) ∧
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ B (X s sample) s i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, X T sample i-x0 i-(∫ s in 0..T, a (X s sample) s i)=∑ j, integrals j sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。
- [EXTRA] 复审范围：strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。
- 覆盖缺口：strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。strictVectorSDE对任意n,r、样本空间、实时间W和X、时变向量a与n×r矩阵B、确定初态x0，要求真实联合Gaussian向量Wiener、AE连续初态、逐坐标逐T漂移可积与各列严格左和积分，增量等于列积分和。D9的Gaussian、零均值、全部跨时协方差和AE连续确可给坐标过程独立，D10、D11已核对，未仅以同一时刻独立代替。但定义不要求X联合可测或相对共同W历史适应，不能未经限定当作标准适应Itô解的完整定义；第28条另外加这些资格印证区别。作为积分方程关系签名正确，作为完整SDE资格仍需人工确认范围。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictVectorSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1105`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-ScalarItoFormula

印刷p.233 / PDFp.254；§6.3.1。

### 1. 原文陈述

> Let $`\phi(\cdot)`$ be any continuously twice differentiable function and let $`X_n\in\mathbb R`$ represent the state of a biased random walk as considered in Sect. 6.3, i.e., with state $`X_{n+1}=X_n+a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x`$.

$$
d\phi(X)=\phi'(X)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi''(X)b(X,t)^2dt.\tag{6.17}
$$



### 2. 原文证明

> Let $`\phi_n=\phi(X_n)`$, then Taylor's theorem gives

$$
\delta\phi\stackrel{\rm def}=\phi_{n+1}-\phi_n=\phi'(X_n)\delta X_n+\tfrac12\phi''(X_n)\delta X_n^2+o(\delta X_n^2) =\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x) +\tfrac12\phi''(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)^2+o(\delta X_n^2).
$$


> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $`\delta x^2\sim\delta t`$, thus we have

$$
\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).
$$


> Passing to the limit, this leads to the SDE.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem scalarItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。scalarItoFormula：P上的preBrownian、strictScalarSDE（AE连续、确定初态、逐终点漂移可积和严格均方左和关系）、φ为C²、a,b在状态时间上C¹，再加φ′(X)b适应平方可积、X联合可测及自然历史适应、gridItoQualification25。后者含P概率、联合可测和适应、每时L²、每个左和L²以及局部均方Hölder控制，并未假设所求结论。结论为每T≥0下φ(X\_T)-φ(x0)-∫(φ′a+φ″b²/2)等于φ′b的严格均方积分，系数、初项、时变量和量词正确。限定签名PASS，不因sorry判FAIL；原文C²余项推成O(dt^(3/2))及直接过极限缺口保留NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarItoFormula` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1120`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-DiffusiveTaylorPrinted

印刷p.233 / PDFp.254；§6.3.1。

### 1. 原文陈述

> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $`\delta x^2\sim\delta t`$, thus we have

$$
\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem diffusiveTaylorPrinted : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 2 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-DiffusiveTaylorPrinted；改动：C²加强为C³，使三阶Taylor余项与扩散缩放匹配。 -/
theorem diffusiveTaylorPrinted_corrected : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 3 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。diffusiveTaylorPrinted：任意C² φ、任意实x,a,b，沿dt→0+对增量a*dt+b*sqrt(dt)宣称三阶扩散余项BigO，忠实记录原书J=+1特例但断言过强。diffusiveTaylorPrinted\_corrected：C³提供局部三阶Taylor界，混合二阶项也为O(dt^(3/2))，对固定实x,a,b正确。右滤子和实rpow的指数3/2均正确；b可负；此式只包含J=+1分支，J=-1可用替换b覆盖，但不是显式随机极限定理。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.diffusiveTaylorPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.diffusiveTaylorPrinted_corrected` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1138`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-TimeItoFormula

印刷p.234 / PDFp.255；§6.3.1。

### 1. 原文陈述

> We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $`\phi(x,t)`$:

$$
d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem timeItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-TimeItoFormula；改动：原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。 -/
theorem timeItoFormula_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 【原书疑误】(6.17)逐字右端形式表达，dX/dXX为形式微分占位；不宣称它是正确积分等式。 -/
def timeItoFormulaPrinted (φ : ℝ×ℝ → ℝ) (x t dX dXX : ℝ) : ℝ :=
  fderiv ℝ φ (x,t) (0,1)+fderiv ℝ φ (x,t) (1,0)*dX+
    fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (x,t) (1,0)*dXX/2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。timeItoFormula及timeItoFormula\_corrected签名相同：在与标量版一致的preBrownian、严格SDE、C¹ a,b、C²联合φ、联合可测及自然适应X、被积过程适应平方可积和网格L²/Hölder资格下，给出任意T≥0完整积分公式。方向(1,0)为x偏导，(0,1)为t偏导，二次方向导数给φ\_xx；漂移积分已正确包含φ\_t，初值φ(x0,0)，扩散φ\_x*b，系数b²/2均正确，两数学签名PASS。timeItoFormulaPrinted以dX,dXX形式占位保留漏dt的右端，是表达式定义，不是正确积分定理，其文档误标(6.17)，应为(6.18)。原书疑误与已修正主签名不能混认。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.timeItoFormula` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.timeItoFormula_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.timeItoFormulaPrinted` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1154`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalkDiffusion

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Take the diffusion limit $`\delta t\to0`$, $`\delta x^2/\delta t\to1`$ with $`\nu\delta t=t`$ fixed, then we obtain, under the Itô convention,

$$
X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem biasedWalkDiffusion : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (W : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 T : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J →
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ W t sample) (Ici 0)) →
  (∃ L : ℝ≥0, LipschitzWith L (Function.uncurry a) ∧ LipschitzWith L (Function.uncurry b)) → 0 < T →
  ∃ X : ℝ → Ω → ℝ, strictScalarSDE P W X a b x0 ∧
    ∃ paths : Ω → C(Icc 0 T, ℝ),
      (∀ᵐ sample ∂P, ∀ t : Icc 0 T, paths sample t=X t sample) ∧
      ∃ walks : ℕ → Ω → C(Icc 0 T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample (t : Icc 0 T),
          walks K sample t = let dt := T/K; let k := Nat.floor ((t : ℝ)/dt);
            MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample +
            ((t : ℝ)-k*dt)/dt*(MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 (k+1) sample-
              MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample)) ∧
        (∀ F : C(Icc 0 T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
          Tendsto (fun K ↦ ∫ sample, F (walks K sample) ∂P) atTop (𝓝 (∫ sample, F (paths sample) ∂P))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确全局Lipschitz技术资格及AE连续W版本；完整SDE解存在与真实偏置有限游走线性插值的路径空间弱极限，没有只以定义取代扩散极限。

### 6. 审计结论（含网站结论）

网站原返回：PASS。rademacherJumps含概率测度、独立、可测、±1、均值零。W另有PreBrownian和AE连续资格；a,b对(x,t)全局Lipschitz是明示[EXTRA]。结论含全时间严格标量SDE解、[0,T]连续路径版本、dt=T/K的线性插值及所有有界连续路径泛函积分收敛；不是仅参数或单时边际收敛。T>0且K=0不约束无碍atTop。J与W无需互相独立，因为结论只作分布极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalkDiffusion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1196`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUProcess

印刷p.234 / PDFp.255；§6.3.2。

### 1. 原文陈述

> For now we will examine the special case of a scalar equation

$$
dX=-\gamma Xdt+\sigma dW;\tag{6.19}
$$


> where $`\gamma\gt 0`$ and $`\sigma`$ are constants. We term Eq. (6.19) the Ornstein-Uhlenbeck SDE.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原显式γ>0保留在真实严格L²积分方程的资格中，不将分布式解作方程前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D21明列γ>0并把a(x,t)=−γx、b(x,t)=σ、固定x0代入D19。保留负漂移、实常σ和严格积分语义；不是用Gaussian law定义OU。W资格仍需在使用处给出。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictOUProcess` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1217`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUIntegratingFactor

印刷p.234 / PDFp.255；§6.3.2。

### 1. 原文陈述

> Multiply both sides of (6.19) by the integrating factor $`\exp(\gamma t)`$, and observe that

$$
d(\exp(\gamma t)X)=\exp(\gamma t)(dX+\gamma Xdt);
$$


> thus (6.19) becomes

$$
d(\exp(\gamma t)X)=\sigma\exp(\gamma t)dW(t).
$$


> We then integrate both sides to obtain

$$
\exp(\gamma t)X(t)=X(0)+\int_0^t\sigma\exp(\gamma s)dW(s).
$$


> Multiplying by $`e^{-\gamma t}`$ gives

$$
X(t)=e^{-\gamma t}X(0)+\sigma e^{-\gamma t}\int_0^t\exp(\gamma s)dW(s).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouIntegratingFactor :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, strictItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian、严格OU与严格确定性Ito积分见证、γ>0和t≥0；完整求值，不以解公式作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意概率样本空间和PreBrownian W，真实OU关系、γ>0、T≥0；存在Y为exp(γs)的严格确定积分且X T几乎处处等于完整变常数解。σ=0也成立；额外重复γ>0无害。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouIntegratingFactor` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1223`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUVarianceIntegral

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> Using Proposition 6.3, we know that for a Wiener process $`W(t)`$, $`Y(t)\stackrel{\rm def}=\int_0^t\exp(\gamma s)dW(s)`$ is a Gaussian random variable with mean zero and variance

$$
\operatorname{Var}\{Y(t)\}=\int_0^t e^{2\gamma s}ds=\frac{e^{2\gamma t}-1}{2\gamma}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouVarianceIntegral : ∀ (γ T : ℝ), 0 < γ → 0 ≤ T →
  (∫ s in (0 : ℝ)..T, Real.exp (2*γ*s))=(Real.exp (2*γ*T)-1)/(2*γ) := by
  intro γ T hγ hT
  have hc : 2*γ ≠ 0 := mul_ne_zero (by norm_num) hγ.ne'
  have hd : ∀ x : ℝ, HasDerivAt (fun s : ℝ ↦ Real.exp (2*γ*s)/(2*γ))
      (Real.exp (2*γ*x)) x := by
    intro x
    simpa [hc] using
      ((Real.hasDerivAt_exp (2*γ*x)).comp x
        ((hasDerivAt_id x).const_mul (2*γ))).div_const (2*γ)
  have hi : IntervalIntegrable (fun s : ℝ ↦ Real.exp (2*γ*s)) volume 0 T :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ ↦ hd x) hi]
  simp only [mul_zero, Real.exp_zero]
  ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。
- 覆盖缺口：仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouVarianceIntegral对任意γ>0、T≥0断言确定性区间积分∫exp(2γs)=(exp(2γT)-1)/(2γ)，签名正确。明确排除γ=0以免总化除零给错误值。scope和coverage\_gaps已声明不覆盖随机积分Gaussian法则、均值或方差的识别；按此范围PASS。条目中额外列出的SymplecticCoordinates、textbookJ及复合辛映射声明与本积分结论无关，不把它们当证据。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouVarianceIntegral` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1233`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OULawPrinted

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> The solution with equivalent distribution is therefore

$$
X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}(1-e^{-2\gamma t})}\widehat Y(t).
$$


> where $`\widehat Y(t)`$ should be interpreted as random process which at every time $`t`$ evaluates to a normal random variable ($`\widehat Y(t)\sim N(0,1)`$). This is what we mean by the exact distributional solution of the Ornstein-Uhlenbeck SDE with prescribed initial value $`X(0)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouLawPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 →
  0 < γ → 0 ≤ T → HasLaw (X T)
    (gaussianReal (Real.exp (-γ*T)*x0)
      (σ^2*(1-Real.exp (-2*γ*T))/(2*γ)).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouLawPrinted：对实际preBrownian驱动与strictOUProcess（γ>0及线性漂移-γx、常扩散σ、确定初态x0的严格积分方程），任意T≥0，X\_T有Gaussian法则，均值exp(-γT)x0、方差σ²(1-exp(-2γT))/(2γ)。方差非负，toNNReal不截掉任何合法量；σ为任意实数、T=0退化为初态Dirac也正确。原文只规定每时刻正态边际，签名没有错误声称各时刻独立或整路径法则，因此PASS；sorry不影响签名审校。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouLawPrinted` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1251`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OULawCorrect

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> The solution with equivalent distribution is therefore

$$
X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}(1-e^{-2\gamma t})}\widehat Y(t).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouLawCorrect :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry

/-- 修正版，对应原文 MD-6.3.2-OULawPrinted；改动：把整个(1−e^(−2γt))/(2γ)放入根号；只断言同一OU过程的单时刻法则。 -/
theorem ouLawPrinted_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]修正标准差σ√((1−e⁻²γt)/(2γ))，完整真实单时Gaussian法则；均值e⁻γtx0、方差σ²(1−e⁻²γt)/(2γ)，不预置law结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouMean和ouVariance的实际定义已给，完整均值及variance正确；PreBrownian、严格OU、γ>0及T≥0足够。σ任意实数由σ²消除符号，T=0退化为点质量正确。这一law忠实于实际PDF公式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouLawCorrect` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.ouLawPrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1261`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUGibbsLimit

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> Let $`\sigma=\sqrt{2\gamma k_BT m}`$; then for large $`t`$ the exponentials of the form $`e^{-\gamma t}`$ tend to zero, and we have

$$
X(t)\approx\sqrt{k_BT m}\widehat Y(t);
$$


>  in which case $`X(t)`$ is drawn from the probability density

$$
\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouGibbsLimit :
  ∀ (γ θ m x0 : ℝ), 0 < γ → 0 < θ → 0 < m →
  ∀ f : ℝ → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ x, f x ∂gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 t)
      (MolecularDynamics.Chapter06Review.ouVariance γ (Real.sqrt (2*γ*θ*m)) t).toNNReal) atTop
      (𝓝 (∫ x, f x ∂gaussianReal 0 (θ*m).toNNReal)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]θ=kBT>0,m>0,γ>0；完整弱收敛，全部有界连续检验函数；不只证明均值/方差参数极限。

### 6. 审计结论（含网站结论）

网站原返回：PASS。γ,θ,m均正，σ=√(2γθm)，全部实t沿atTop；对所有有界连续f检验Gaussian测度积分，极限variance θm，均值0。完整弱收敛，不只均值方差参数收敛。负t的toNNReal总化不影响长时极限；本条未声称随机路径几乎处处收敛。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouGibbsLimit` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1278`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-MomentumOU

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> For a system with $`N_c`$ configurational variables we may write

$$
dp_i=-\gamma p_i dt+\sqrt{2\gamma k_BT m_i}\,dW_i;\tag{6.20}
$$


> where $`W_1(t),W_2(t),\ldots,W_{N_c}(t)`$ represent $`N_c`$ independent Wiener processes, or, in vectorial notation, denoting $`W=[W_1,W_2,\ldots,W_{N_c}]^T`$, we have

$$
dp=-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{6.21}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (γ θ : ℝ) (p0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧
  ∀ i, strictOUProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。

### 6. 审计结论（含网站结论）

网站原返回：PASS。momentumOU在任意n上要求整族向量Wiener（联合Gaussian、全跨时协方差、连续路径）、逐质量正、γ>0、θ>0，其中θ表示kBT；每坐标为γ相同、σ\_i=sqrt(2γθm\_i)、初态p0\_i的strictOUProcess。各噪声来自同一真实独立坐标Wiener，并非任意彼此相关标量过程。常系数线性方程对应对角M^(1/2)，签名PASS；不把该定义当作长期采样或不变性定理。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.momentumOU` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1288`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-GibbsGaussianDensity

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> in which case $`X(t)`$ is drawn from the probability density

$$
\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def gibbsGaussianDensity (θ m u : ℝ) : ℝ :=
  Real.exp (-(u^2/(2*m))/θ)/Real.sqrt (2*Real.pi*m*θ)
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

网站原返回：PASS。θ=kBT；exp(−(u²/(2m))/θ)/√(2πmθ)与原式相同。θ,m,u为实数；context明确θ,m>0才称概率密度。仅定义函数，不声称已证归一化或非正参数为密度，数学范围已注明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gibbsGaussianDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1295`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

