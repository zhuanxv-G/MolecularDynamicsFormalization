[上一部分](part06.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part08.zh-CN.md)

## 1. MD-5.3.3-AmbientLowerDimensionNull · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We also note that lower order objects such as a point or a curve in $`\mathbb R^2`$, or a surface in $`\mathbb R^3`$, have zero measure with respect to Lebesgue measure for the ambient space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ambientLowerDimensionNull : ∀ n d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n) (K : Set (MolecularDynamics.Chapter05Review.E d)),
  d < n → ContDiff ℝ 1 g → IsCompact K → volume (g '' K)=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ambientLowerDimensionNull` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。 | [EXTRA] |

[EXTRA] [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准数学含义，不要求在项目依赖摘录中提供Mathlib定义体。已展开项目E（Ch05\_deps.txt中MolecularDynamics/Chapter05/ReviewDefinitions.lean行5315）：E n=EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ；volume按标准含义为其Lebesgue测度，无需项目摘录另供定义体。Ch05.lean行938–939依次量化任意n,d,C¹映射g:ℝᵈ→ℝⁿ及紧K⊆ℝᵈ，并在d<n时断言volume(g''K)=0；对象、量词、维数比较及实际ambient零测结论正确。PDF第216页（印刷195页）点、ℝ²中的曲线、ℝ³中的曲面分别有d=0、(d,n)=(1,2)、(2,3)的光滑参数块模型。[EXTRA]C¹参数化紧像已明确披露，是通常光滑低维对象的合理局部形式；C¹提供局部Lipschitz性质，紧性有利于有限局部覆盖，并非零测所必需。一般光滑曲线或曲面可通过可数紧参数块/局部图覆盖归约，原文无限对象不会因局部块形式而被解释成高维对象。不扩张为任意连续曲线或任意拓扑低维集合的断言。无[ERRATUM?]。证明体含sorry，但签名的语义PASS与证明完成度分开；未运行编译。

### 7. 状态与证明位置

incomplete；`MD.Ch05.ambientLowerDimensionNull`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1318)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-TimeAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> Given an autonomous system of differential equations $`\dot z=f(z)`$ in $`\mathbb R^m`$, and a trajectory $`\Gamma=\{z(t)\mid t\in[0,\infty]\}`$, let $`g=g(z)`$ be any smooth scalar valued function of $`z`$ (an observable) and define (assuming it exists) the infinite time average of $`g`$ along $`\Gamma`$ by

$$
\bar g_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau g(z(t))dt.\tag{5.9}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.timeAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；X 是任意类型，z:ℝ→X，g:X→ℝ，T:ℝ；定义恰为 T⁻¹ 乘 0..T 的真实有向区间积分。按明确 statement\_scope 本条仅承担有限截断因子，无限极限由下一条承担，未把有限值冒充无限平均。任意路径和函数是公式层面的自然推广；原书光滑正向轨道是其适用特例。T=0 或不可积函数的 Lean 总化值不赋予原书平均意义，负 T 仅属定义延拓。

### 7. 状态与证明位置

self-contained；`MD.Ch05.timeAverage`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1324)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-HasTimeAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> define (assuming it exists) the infinite time average of $`g`$ along $`\Gamma`$ by $`\bar g_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau g(z(t))dt`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hasTimeAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 X,z,g 及候选实数 a，以 Tendsto (timeAverage z g) atTop (𝓝 a) 表达式(5.9)。使用的是摘录的 Chapter05Review.timeAverage，即真实 0..T 区间积分。a 是平均值参数，并未假设每个可观测量都有极限。atTop 的最终正时间使负时延拓和 T=0 不影响结论；原文的轨道及光滑性背景不被误写成极限自动存在的定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.hasTimeAverage`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1327)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-ConservedAverage · unnumbered_claim · 印刷p.196–197 / PDFp.217–218

### 2. 原文陈述

> Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $`I=I(z)`$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conservedAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : MolecularDynamics.Chapter05Review.timeAverage z g T=a := by
  apply MolecularDynamics.Chapter05Review.conservedAverage_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.conservedAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀X,z,g,a，前提 ∀t∈ℝ,g(z t)=a，结论对每个非零实数 T 为有限时间平均=a。任意负 T 的有向积分也满足该恒等式；T≠0 必须保留，因为 T=0 时总化平均为0。此条按 scope 是守恒观测量的有限平均辅助引理；原文第一积分及其函数的无限时间结论映射至下一条，并非遗漏后仍宣称完成全部原文结论。比正时间轨道更强的全实时间守恒前提是明确延拓，实际第一积分满足。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.conservedAverage`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1333)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-ConservedInfiniteAverage · unnumbered_claim · 印刷p.196–197 / PDFp.217–218

### 2. 原文陈述

> Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $`I=I(z)`$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conservedInfiniteAverage {X : Type*} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  MolecularDynamics.Chapter05Review.hasTimeAverage z I (I (z 0)) ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z (r ∘ I) (r (I (z 0))) := by
  have hm (g : X → ℝ) (hg : ∀ t,g (z t)=g (z 0)) :
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) := by
    apply tendsto_congr' _ |>.2 tendsto_const_nhds
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    exact MolecularDynamics.Chapter05Review.conservedAverage_proved z g (g (z 0)) hg T (ne_of_gt hT)
  exact ⟨hm I hI,hm (r ∘ I) (fun t => by simp only [Function.comp_apply,hI])⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.conservedInfiniteAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀X,z,I,r，hI 要求每个实时间的 I(z t)=I(z 0)。完整合取分别给出 I 的无限平均 I(z 0)，以及任意函数 r∘I 的无限平均 r(I(z 0))。不需 r 连续或可测，因为沿此轨道两个被积函数都恒定；不存在把“复合量有平均”作为前提的问题。结果准确表达平均由初值的积分值决定，不承诺不同初值一定产生不同平均；例如常值 r 的平均可以相同。

### 7. 状态与证明位置

self-contained；`MD.Ch05.conservedInfiniteAverage`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1338)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellEnergy · Example 5.3 · 印刷p.196 / PDFp.217

### 2. 原文陈述

> Example 5.3 Consider the double well potential $`\phi(q)=(1-q^2)^2`$. The energy $`H(q,p)=p^2/2+\phi(q)`$ will tend to $`+\infty`$ as $`q\to\infty`$ or $`p\to\infty`$, but is obviously bounded below (by zero).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E 2 是 Fin 2 上的实欧氏空间，z 0 对应 q、z 1 对应 p；定义严格为 p²/2+(1−q²)²。仅按 scope 核对公式定义：原文非负及趋于无穷的断言未包含于此定义，其映射的 DoubleWellCoercivity 不在本任务提供的声明中，因此不声称本次已核对该外部条目。定义对所有 z 总化，实数平方和不会引入额外域限制。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1351)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellCoercivity · unnumbered_claim · 印刷p.196 / PDFp.217

### 2. 原文陈述

> The energy $`H(q,p)=p^2/2+(1-q^2)^2`$ will tend to $`+\infty`$ as $`q\to\infty`$ or $`p\to\infty`$, but is obviously bounded below (by zero).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellCoercivity : (∀ z : MolecularDynamics.Chapter05Review.E 2,0 ≤ doubleWellEnergy z) ∧
  ∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} := by
  constructor
  · intro z
    unfold doubleWellEnergy
    positivity
  · intro c
    have hc : Continuous (doubleWellEnergy) := by unfold doubleWellEnergy; fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|+4)).of_isClosed_subset hclosed
    intro z hz
    have he : (z 1)^2/2+(1-(z 0)^2)^2 ≤ c := hz
    have hpos : 0 ≤ c := by nlinarith [sq_nonneg (z 1),sq_nonneg (1-(z 0)^2)]
    have hq : (z 0)^2 ≤ (c+3)/2 := by
      nlinarith [sq_nonneg (z 1),sq_nonneg ((z 0)^2-2)]
    have hp : (z 1)^2 ≤ 2*c := by nlinarith [sq_nonneg (1-(z 0)^2)]
    have hnorm : ‖z‖^2=(z 0)^2+(z 1)^2 := by
      rw [EuclideanSpace.norm_sq_eq]
      simp [Fin.sum_univ_two,Real.norm_eq_abs]
    rw [Metric.mem_closedBall,dist_zero_right,abs_of_nonneg hpos]
    nlinarith [norm_nonneg z]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellCoercivity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。 | [EXTRA] |

[EXTRA] [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义，不要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目依赖 MolecularDynamics/Chapter05/ReviewDefinitions.lean（Ch05\_deps.txt 第5315行）展开 E n=EuclideanSpace ℝ (Fin n)，按标准含义是具有欧氏内积与拓扑的 ℝⁿ；Blueprint/Ch05.lean 第968行的 MD.Ch05.doubleWellEnergy 展开为 p²/2+(1-q²)²，其中 q=z 0、p=z 1。 Blueprint/Ch05.lean 第972–993行结论为(∀z,0≤H(z))与(∀c∈ℝ,{z|H(z)≤c}紧)的合取。IsCompact 按标准欧氏紧性理解；能量为连续多项式，其闭下水平集在有限维空间紧，等价于通常的强制性，涵盖原文 q→+∞ 或 p→+∞ 时 H→+∞（另一坐标固定或任意变化），并合理推广到任意坐标逃逸。c<0 时下水平集为空，紧性仍成立，无能级遗漏。[EXTRA]实际是性质的等价表达说明，而非签名中的附加前提；没有给一般势函数添加未经论证的强制性。两个原文结论均被表达，无[ERRATUM?]。证明状态单独记录：本条实际正文未出现 sorry/admit；仅做只读语义审计，未运行 Lean 编译，也未核验整个项目的公理依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellCoercivity`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1355)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellDisconnected · Example 5.3 · 印刷p.196 / PDFp.217

### 2. 原文陈述

> From the graph it is clear that the energy surface $`H(q,p)=E`$ has more than one component if $`0\lt E\lt 1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellDisconnected : ∀ c ∈ Ioo (0 : ℝ) 1,
  ¬IsPreconnected (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by
  intro c hc hS
  let a : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![-1,Real.sqrt (2*c)]
  let b : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![1,Real.sqrt (2*c)]
  have hsqrt : (Real.sqrt (2*c))^2=2*c := Real.sq_sqrt (by linarith [hc.1])
  have ha : a ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(-1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hb : b ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hq : ContinuousOn (fun z : MolecularDynamics.Chapter05Review.E 2 => z 0)
      (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by fun_prop
  have hzero : (0 : ℝ) ∈ Icc (a 0) (b 0) := by norm_num [a,b]
  obtain ⟨z,hz,hz0⟩ := hS.intermediate_value ha hb hq hzero
  change doubleWellEnergy z=c at hz
  unfold doubleWellEnergy at hz
  change z 0=0 at hz0
  rw [hz0] at hz
  nlinarith [sq_nonneg (z 1),hc.2]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellDisconnected` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义，不要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目依赖 MolecularDynamics/Chapter05/ReviewDefinitions.lean（Ch05\_deps.txt 第5315行）展开 E n=EuclideanSpace ℝ (Fin n)，按标准含义是具有欧氏内积与拓扑的 ℝⁿ；Blueprint/Ch05.lean 第968行的 MD.Ch05.doubleWellEnergy 展开为 p²/2+(1-q²)²，其中 q=z 0、p=z 1。 项目依赖 ReviewDefinitions.lean 第5355行展开 energySurface H c={z|H(z)=c}。Blueprint/Ch05.lean 第996–1015行量词 ∀c∈Ioo 0 1 正是对所有0<c<1。标准 ¬IsPreconnected 表达该能级作为拓扑子空间不连通；这里能级非空（例如 q=±1,p=√(2c)），因而与原文“more than one component”一致，不依赖空集约定。q=0 时 H=p²/2+1≥1，且能级同时含 q<0 和 q>0 两侧点，断开对象确实是整个能量面，并非投影或子集。无额外前提、无[EXTRA]/[ERRATUM?]。标准连通定义直接采信，不因依赖摘录不含其 Mathlib 定义体而降级。证明状态单独记录：本条实际正文未出现 sorry/admit；仅做只读语义审计，未运行 Lean 编译，也未核验整个项目的公理依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellDisconnected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1379)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellBasin · unnumbered_claim · 印刷p.196 / PDFp.217

### 2. 原文陈述

> If an initial condition is taken from one of the two basins, say with energy $`E_0`$, then the trajectory through that point will remain forever in the one basin, thus the averages of many quantities, if computed using the trajectory values, would not be a good approximation of the overall average at constant energy $`E_0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellBasin : ∀ (z : ℝ → MolecularDynamics.Chapter05Review.E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0) := by
  intro z c hz hc hE t
  let q (s : ℝ) := (z s) 0
  have hq : Continuous q := by dsimp [q]; fun_prop
  have hn (s : ℝ) : q s ≠ 0 := by
    intro heq
    have hh := hE s
    unfold doubleWellEnergy at hh
    change (z s) 0=0 at heq
    rw [heq] at hh
    nlinarith [sq_nonneg ((z s) 1),hc.2]
  by_cases h0 : 0 < q 0
  · left
    refine ⟨h0,?_⟩
    by_contra ht
    have hneg : q t < 0 := lt_of_le_of_ne (le_of_not_gt ht) (hn t)
    obtain ⟨s,hs⟩ := intermediate_value_univ t 0 hq (show (0 : ℝ) ∈ Icc (q t) (q 0) from ⟨hneg.le,h0.le⟩)
    exact hn s hs
  · right
    have hneg : q 0 < 0 := lt_of_le_of_ne (le_of_not_gt h0) (hn 0)
    refine ⟨hneg,?_⟩
    by_contra ht
    have hpos : 0 < q t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm (hn t))
    obtain ⟨s,hs⟩ := intermediate_value_univ 0 t hq (show (0 : ℝ) ∈ Icc (q 0) (q t) from ⟨hneg.le,hpos.le⟩)
    exact hn s hs

theorem doubleWellBasin_average_witness (c : ℝ) (_hc : c ∈ Ioo (0 : ℝ) 1)
    (z : ℝ → MolecularDynamics.Chapter05Review.E 2) (_hz : Continuous z)
    (_hE : ∀ t,doubleWellEnergy (z t)=c) :
    ∃ g : MolecularDynamics.Chapter05Review.E 2 → ℝ,ContDiff ℝ ∞ g ∧ HasCompactSupport g ∧
      (∀ x,doubleWellEnergy x=c → g x=if 0 < x 0 then (1 : ℝ) else 0) ∧
      MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g=1/2 ∧
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) ∧
      g (z 0) ≠ MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellBasin`；`MD.Ch05.doubleWellBasin_average_witness` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。 | [EXTRA] |

[EXTRA] [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。；[EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；第一条声明量化所有连续实时间路径与 0<c<1 的守恒能量，结论对所有 t 同时保留初值及当前值的同一严格正号或同一严格负号。q=0 时能量≥1，故连续路径不能穿越，两阱结论完整。第二条声明在同样前提下存在全局 C∞ 紧支撑实值 g，在整个能量面上等于右阱的0/1分支值，且真实 microAverage=1/2、沿指定路径有无限平均 g(z0)、该平均不等于空间平均，三个结论均未作为前提。两条紧分离能量分支允许光滑截断；q↦−q 的欧氏等距对称保持能量、面测度及梯度范数，使两个分支质量相等且正有限。故该加强见证正确，不把全局不连续示性函数说成光滑函数，也未伪造“许多”的数量或误差界。

### 7. 状态与证明位置

incomplete；`MD.Ch05.doubleWellBasin`：已证；`MD.Ch05.doubleWellBasin_average_witness`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1404)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-UniformMicroErgodic · Definition 5.1 · 印刷p.197 / PDFp.218

### 2. 原文陈述

> Definition 5.1 A Hamiltonian system is said to be ergodic on an energy surface $`\Sigma_E`$ (microcanonically ergodic) if, for almost all trajectories $`\Gamma`$ emanating from initial conditions on $`\Sigma_E`$, and for any observable $`g`$, the following holds $`\bar g_\Gamma=\operatorname{Av}_{H=E}(g)`$, where $`\bar g_\Gamma`$ is defined in (5.9). By “almost all” we mean that there could be a low-dimensional subset for which the trajectory averages fail to equal the space averages.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)



/-- 修正版，对应原文 MD-5.4.1-UniformMicroErgodic。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def uniformMicroErgodic_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.uniformMicroErgodic`；`MD.Ch05.uniformMicroErgodic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ\_E零测资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ\_E零测资格。；[EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主谓词的量词顺序准确为对 microMeasure 几乎处处 z，再对每个全局 C∞ 且该测度可积的实值 g；结论是实际无限时间平均等于实际空间平均。flow 明确零时恒等、实时间群律与逐时 ODE 导数；另有 H∈C²、全空间能量保持、非空紧正则面及正有限质量，并用常可逆反对称矩阵 J 指定 f=J∇H。这些 [EXTRA] 均在接口中，紧能量面上光滑 g 可积并不实质删去原文光滑观测量。问题在原书把 almost all 用 low-dimensional subset 解释：测度零与低维条件不能一般等同，Lean 未出现维数谓词。按通常微正则零测解释签名正确；若原文要求异常集严格低维则尚不忠实，需人工确定，不能静默裁定原书。

### 7. 状态与证明位置

self-contained；`MD.Ch05.uniformMicroErgodic`：定义；`MD.Ch05.uniformMicroErgodic_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1446)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-MicroErgodicStandard · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> for almost all trajectories $`\Gamma`$ emanating from initial conditions on $`\Sigma_E`$, and for any observable $`g`$, the following holds $`\bar g_\Gamma=\operatorname{Av}_{H=E}(g)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)

def microErgodic_L1_alternative {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microErgodic`；`MD.Ch05.microErgodic_L1_alternative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。 | [EXTRA] |

[EXTRA] [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。；[EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主 microErgodic 与上一条共同满测集的 C∞ 版本相同，完整保留 AE z 后 ∀g 以及 flow、正则面、C²、能量保持、常非退化反对称 J 等所有参数前提。额外 microErgodic\_L1\_alternative 的顺序是 ∀g，Integrable g μ→AE z，允许不同 g 有不同异常集，且只要求 L¹ 而不要求光滑；该声明仅定义替代性质，不断言与主定义等价。它无 Hamiltonian/概率前提，故只能视为一般测度映射的性质，单独使用时不能保证动力系统背景；应在注释中明确。本条摘录本身没有 low-dimensional 句，故此处无该句的维数承诺。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microErgodic`：定义；`MD.Ch05.microErgodic_L1_alternative`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1476)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-FlowInvariant · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> An invariant set $`\mathcal A`$ of the flow is one such that $`\mathcal F_t(\mathcal A)=\mathcal A`$, for all $`t\ne0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flowInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。 | [EXTRA] |

[EXTRA] [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。；[EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意类型 X、任意 Φ:ℝ→X→X 和 A:Set X，定义恰为 ∀t,t≠0→Φ t''A=A，使用集合像而非原像/包含关系。没有默加 t=0，也不声称任意 Φ 自动具有流律。真实流满足 Φ0=id 时，才与全时间像不变等价。旧第一条 EXTRA 声称当前实现使用全时间条件，与实际 MD 定义冲突，已仅修正文档；Lean 声明本身通过。

### 7. 状态与证明位置

self-contained；`MD.Ch05.flowInvariant`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1495)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-SetErgodic · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> Alternatively, we may say that a dynamical system as ergodic if the probability measure of any invariant set $`\mathcal A`$ of the flow is either 0 or 1.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.setErgodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。 | [EXTRA] |

[EXTRA] [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。；[EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；X 带可测空间，μ 为概率测度；Φ 有零时恒等、所有实 s,t 的群律和联合可测性。结论只量化可测集合 A，以实际 Chapter05Review.flowInvariant（全实时间像相等）为前提，要求 μ A=0 或 μ A=1。因 h0，全时间不变与本批 MD.flowInvariant 的 t≠0 条件等价，命名空间差异不会改变真实流上的语义。可测性限制是概率集合定义的合理明确化。签名没有 MeasurePreserving 前提，因此本次仅批准原句的0/1定义，不把它当作已证明与时间平均相等的等价定理；建立这种等价通常还需保测等背景。原书 as ergodic 的语法错误应原样保留，不属数学修正。

### 7. 状态与证明位置

self-contained；`MD.Ch05.setErgodic`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1500)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InvariantIndicator · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> Then for any trajectory starting in $`\mathcal A`$, we have that the average of $`\chi`$ along $`\Gamma`$ vanishes, i.e. $`\bar\chi_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau\chi(z(t))dt=0`$, since $`\mathcal A`$ is an invariant set.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem invariantIndicator {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0 := by
  apply MolecularDynamics.Chapter05Review.invariantIndicator_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.invariantIndicator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意 X,Φ,A，全时间集合像不变 h，以及 z∈A、任意实数 t；结论为 ambient 补集 Aᶜ 的常1示性函数在 Φt z 处=0。由 Φt''A=A 即有 Φt z∈A，不需可测性、可积性或 flow 群律。此沿轨道结论与原书能量面内补集示性函数一致，因为路径始终留在 A；不宣称两个示性函数在能量面外相等。scope 明确此条只给逐点辅助结论，完整无限平均另条承担。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.invariantIndicator`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1509)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InvariantIndicatorAverage · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> $`\bar\chi_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau\chi(z(t))dt=0`$, since $`\mathcal A`$ is an invariant set.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem invariantIndicatorAverage {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (hA : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) :
  MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) (Aᶜ.indicator (fun _ => (1 : ℝ))) 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.invariantIndicatorAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数为任意 X,Φ,A、全时间集合像不变 hA、初值 z∈A；完整结论是实际 hasTimeAverage (fun t=>Φ t z) (Aᶜ.indicator 1) 0，已包含 Tendsto、0..T 积分及归一化，不仅是逐点等式或有限平均。像不变性保证轨道全时刻在 A，从而被积函数恒零，故无须额外可测或连续前提。使用全时间 Chapter05Review.flowInvariant；在真实流背景下和原印 t≠0 等价。sorry 不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch05.invariantIndicatorAverage`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1515)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-ErgodicTimeEquivalence · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> If we assume the system is ergodic, we must have $`\operatorname{Pr}(\Sigma_E\setminus\mathcal A)=0`$, thus $`\operatorname{Pr}(\mathcal A)=1`$. Since, according to the definition, equality of time and space averages is allowed to fail only on a set of probability measure zero, we have that either $`\operatorname{Pr}(\mathcal A)=0`$ or $`\operatorname{Pr}(\mathcal A)=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ergodicTimeAverage :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_common_smooth (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n))
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hμ : IsProbabilityMeasure μ) (_hpres : ∀ t,MeasurePreserving (Φ t) μ μ)
    (_h0 : ∀ z,Φ 0 z=z) (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hΦ : Continuous (Function.uncurry Φ))
    (_hK : ∃ K : Set (MolecularDynamics.Chapter05Review.E n),IsCompact K ∧ μ Kᶜ=0) :
    (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
      ∀ᵐ z ∂μ,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
        ContDiff ℝ ∞ g → Integrable g μ →
          MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z) g
            (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_positive_invariant (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_herg : MolecularDynamics.Chapter05Review.setErgodic μ Φ)
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) :
    μ A=1 ∧ (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-ErgodicTimeEquivalence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem ergodicTimeAverage_corrected :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ergodicTimeAverage`；`MD.Ch05.ergodicTimeAverage_common_smooth`；`MD.Ch05.ergodicTimeAverage_positive_invariant`；`MD.Ch05.ergodicTimeAverage_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。；[EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；已分别核对ergodicTimeAverage、ergodicTimeAverage\_common\_smooth、ergodicTimeAverage\_positive\_invariant。E n为任意有限维实欧氏空间；第一条在概率测度、每个实时间保测、零时恒等、全实时间群律及联合可测前提下，给出严格不变可测集的0/1性质与“每个L¹实观测量各自几乎处处具有空间均值时间平均”的双向等价；积分为真实0到T区间积分，极限为T→+∞。第二条另要求联合连续及紧支撑，结论确实把AE置于所有C∞实观测量之前，这些增加的条件已经[EXTRA]公开，不能把第二条当成第一条无条件交换量词。第三条显式要求可测不变集A有正概率，结论同时包含μ(A)=1、所有实时间轨道留在A、补集指标函数的实际时间平均为0；未把这些结论作假设。三条修订/扩展签名合理。本条PASS只涉及这些明确声明，不认可原书省略正概率分支的中间推理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.ergodicTimeAverage`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_common_smooth`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_positive_invariant`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1524)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

