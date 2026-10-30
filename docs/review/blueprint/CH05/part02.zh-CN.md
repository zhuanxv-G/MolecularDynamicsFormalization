[上一部分](part01.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-5.2.2-BoxFluxBalance · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:

$$
\frac{d\nu}{dt}=-\int_A\nabla\cdot(f(z)\rho(z;t))\,d\omega.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem fluxBalance :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,MolecularDynamics.Chapter05Review.probabilityDensity (ρ t)) →
  (∀ t,MolecularDynamics.Chapter05Review.densityMeasure (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.fluxBalance` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。 | [EXTRA] |

[EXTRA] [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对所有n>0、严格非退化矩形a\_i<b\_i、C¹场、满足群律和ODE的实际流、联合C²流与联合C¹密度、每时概率密度及Measure.map输运。结论同时含所有t的真实质量函数导数和散度积分等于上面减下面通量。两式合起来正好是dν/dt=-∫_A div(ρf)，无符号错误、无PDE前提。紧矩形及连续导数足够支撑积分求导和散度定理。原书允许矩形例子，[EXTRA]公开了矩形特化，故按此特化PASS；未审核未附的一般域条目。

### 7. 状态与证明位置

incomplete；`MD.Ch05.fluxBalance`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L530)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-BoundaryTerm · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> where the term $`B=\sum_i\int_{\partial A_\ell}uf_iv\nu_i\,d\sigma`$, is a surface integral over the boundary of $`A_\ell`$, where $`\nu_i`$ is the $`i`$’th component of the unit outward normal to the surface $`\partial A_\ell`$ bounding the region $`A_\ell`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.boxBoundaryTerm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对f、u、v、ell及维数参数；a=(-ell,…), b=(ell,…)。每坐标上面减下面的通量作用于ρ=uv，正是∑∫uf\_i v ν\_i；u v f\_i与原文u f\_i v相同。n≥1、ell>0的原文盒子语境下，棱角是面积零集合，不妨碍面分解；n=1时0维面积是计数测度。函数作为总定义允许其他ell及任意数据，没有额外断言这些情形存在原文的光滑外法向。[EXTRA]为空不影响其作为积分表达式的定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.boxBoundaryTerm`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L543)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-TruncatedIntegrationByParts · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> We truncate the domain to a large box $`A_\ell`$ with edge of length $`2\ell`$ centered at the origin, approximating the inner product by:

$$
\langle u,\mathcal L_fv\rangle\approx\int_{A_\ell}u\mathcal L_fv\,d\omega=\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega.
$$


> Splitting this sum up, we treat each term by integration by parts

$$
\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega=\sum_i\int_{A_\ell}uf_i\frac{\partial v}{\partial z_i}\,d\omega\tag{5.4}
$$



$$
=B-\sum_i\int_{A_\ell}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega.\tag{5.5}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem truncatedIntegrationByParts : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := MolecularDynamics.Chapter05Review.rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*MolecularDynamics.Chapter05Review.lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.truncatedIntegrationByParts` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。 | [EXTRA] |

[EXTRA] [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对所有n>0、ell>0、全空间C¹场和标量u,v，以及实际盒A。lie f v=Dv[f]，liouvillian f u=-div(uf)，故右侧B+∫liouvillian(f,u)v正好是B-∫v div(uf)。有限维坐标展开和积分的有限和分配在紧盒与C¹条件下等价于(5.4)，结论编码(5.5)。原文≈没有被编码成精确全空间等号；本条局部积分恒等式不需要无穷远衰减，[EXTRA]的局部C¹及正边长条件合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.truncatedIntegrationByParts`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L551)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-RapidAdjoint · unnumbered_claim · 印刷p.185–186 / PDFp.206–207

### 2. 原文陈述

> Let $`u,v`$ be two scalar valued functions in $`\mathbb R^m`$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $`u`$ and $`v`$ are rapidly decaying we know that $`B\to0`$, as $`\ell\to\infty`$. Taking the limit, we are thus left with the equation

$$
\langle u,\mathcal L_fv\rangle=-\sum_i\int_{\mathbb R^m}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega=\langle M_fu,v\rangle.
$$


> We refer to $`M_f`$ as the adjoint operator of $`\mathcal L_f`$ and we write $`M_f=\mathcal L_f^\dagger`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rapidAdjoint : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry



/-- 修正版，对应原文 MD-5.2.2-RapidAdjoint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem rapidAdjoint_corrected : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.rapidAdjoint`；`MD.Ch05.rapidAdjoint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；声明本身是正确的条件化版本：n>0，f为C¹，u,v为SchwartzMap，两个实际混合乘积分别可积，且真实盒边界项B趋0，才推出全空间积分配对相等。由紧盒分部积分和两个可积函数的盒截断极限可得该结论；没有将最终配对相等作为假设。但原页声称仅由u,v迅速衰减便知B→0，未明确f的增长控制；[EXTRA]把B→0改为前提是实质补充，不能据此宣布原书推论已成立。按任务规定保留原句并将原书条件疑点交人工；形式伴随记号也不等于闭Hilbert算子伴随的定义域识别。

### 7. 状态与证明位置

incomplete；`MD.Ch05.rapidAdjoint`：未证（原书疑误不证）；`MD.Ch05.rapidAdjoint_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L561)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-CompactAdjoint · unnumbered_claim · 印刷p.185–186 / PDFp.206–207

### 2. 原文陈述

> $`\langle u,\mathcal L_fv\rangle=\langle M_fu,v\rangle`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvillianAdjoint :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvillianAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。 | [EXTRA] |

[EXTRA] [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对任意n、C¹向量场及C¹实函数u,v，二者均有紧支持；结论为真实Lebesgue积分的配对相等。相关乘积及导数连续且有紧支持，故可积、边界项在充分大盒上消失。n=0时导数场为零，仍成立。此为已明确另列的紧支持版本，不宣称所有C¹紧支持函数属于SchwartzMap，也不把形式配对等同于闭算子伴随。与原页所摘等式及[EXTRA]范围一致。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvillianAdjoint`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L586)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MeasurePropagator · definition · 印刷p.186 / PDFp.207

### 2. 原文陈述

> The density $`\rho`$ evolves as the solution of the partial differential equation $`\partial\rho/\partial t=\mathcal L_f^\dagger\rho`$, where we interpret $`\rho`$ as a function of both $`z`$ and $`t`$ and view $`\mathcal L_f^\dagger`$ as only operating on the spatial components. This means, formally, $`\rho(\boldsymbol z,t)=e^{t\mathcal L_f^\dagger}\rho(\boldsymbol z,0)`$. We can think of $`\exp(t\mathcal L_f^\dagger)`$ as defining the propagator of measure.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ

def measurePropagator_general {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ

theorem measurePropagator_density_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.measurePropagator`；`MD.Ch05.measurePropagator_general`；`MD.Ch05.measurePropagator_density_evolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。 | [EXTRA] |

[EXTRA] [EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐一核对主定义、general辅助定义和density\_evolution。主接口包含真实自治流资格并作正时间Φ\_t推前；general仅为任意可测空间上Measure.map的总定义，不额外宣称任意Φ都是物理流。evolution对任意开且流不变D、C¹场、联合C²实际流、联合C¹且各时为概率密度的ρ，假设各时密度测度是初始密度的推前，推出每个t及z∈D处∂tρ=liouvillian f (ρ t)。ρ初值为ρ 0而非任意强加解；时间符号正确。形式指数只是演化算子记号，未声称已经构造一般无界算子的指数；[EXTRA]与实际编码相符。

### 7. 状态与证明位置

incomplete；`MD.Ch05.measurePropagator`：定义；`MD.Ch05.measurePropagator_general`：定义；`MD.Ch05.measurePropagator_density_evolution`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L594)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianDivergence · unnumbered_claim · 印刷p.186 / PDFp.207

### 2. 原文陈述

> The term $`\nabla\cdot f`$ vanishes for $`f=J\nabla H`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。 | [EXTRA] |

[EXTRA] [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS：依赖 SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ，按 q,p 排列，textbookJ=[[0,I],[-I,0]]；SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e\_i))_i；SymplecticMaps.lean 的 textbookJacobian=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，其 trace 正是坐标散度。因此任意 Nc,H,z 下的结论是 div(J∇H)(z)=0。[EXTRA]局部 C² 保证真实二阶导数对称，是合理的光滑性资格，不假设结论。原书无本条 [ERRATUM?]。本声明调用依赖 HamiltonianVolume.lean 中已给出 Hessian 对称性与 trace(JS)=−trace(JS) 的证明，声明本体无 sorry；此为静态语义审阅，未运行 Lean 编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.hamiltonianDivergence`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L613)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianSkewExpression · unnumbered_claim · 印刷p.186 / PDFp.207

### 2. 原文陈述

> From the above we know that for a smooth scalar function $`u=u(z)`$, $`\mathcal L_f^\dagger u=-\nabla\cdot(uf)=-f\cdot\nabla u-u\nabla\cdot f`$. The term $`\nabla\cdot f`$ vanishes for $`f=J\nabla H`$. Thus we have $`\mathcal L_f^\dagger u=-f\cdot\nabla u=-\mathcal L_fu`$. If this holds for all smooth $`u`$, we write $`\mathcal L_f^\dagger=-\mathcal L_f`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianSkewExpression :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  ∀ z,MolecularDynamics.Chapter05Review.liouvillian f u z= -MolecularDynamics.Chapter05Review.lie f u z := by
  intro n f u hf hu hdiv z
  rw [liouvilleProduct n f u z (hf z) (hu z),hdiv z]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianSkewExpression` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。 | [EXTRA] |
| 尚未覆盖的结论 | C² Hamiltonian的真实Hamilton场散度零桥接与本条实例化；正式库HamiltonianVolume的维数/坐标转换尚未在本条展开核对 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。；[EXTRA] 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。

### 6. 审计结论

本轮修复：零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；所列定理作为一般零散度场的条件命题正确：∀n,f,u，f和u可微，假设∀z div f z=0，再得∀z -div(uf)=-Du[f]。但本条statement\_scope覆盖整个原段，其中还包含f=J∇H时散度为零这一实质结论。当前所有声明既无H、J或Phase，也无从HamiltonianField推出div f=0的桥接。将散度零直接列为前提不能覆盖该结论。[EXTRA]称正式库另有桥接，却未给出其声明及所需正则性，不能按本任务的唯一输入核实。因此就完整原句覆盖判FAIL，并非认为已列的条件恒等式为假。

### 7. 状态与证明位置

self-contained；`MD.Ch05.hamiltonianSkewExpression`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L622)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianDensityPropagation · unnumbered_claim · 印刷p.187 / PDFp.208

### 2. 原文陈述

> An important consequence of the skew symmetry of $`\mathcal L_f`$ for a divergence-free system is that the propagator $`e^{t\mathcal L_f^\dagger}`$ preserves the integral over the whole phase space, i.e.

$$
\int_D e^{t\mathcal L_f^\dagger}\rho(z)d\omega=\int_D e^{-t\mathcal L_f}\rho(z)d\omega=\int_D\rho(\mathcal F_{-t}(z))d\omega=\int_D\rho(z)d\omega,
$$


> since we can view $`\mathcal F_{-t}(z)`$ as a change of variables by a volume-preserving map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianDensityPropagation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D ρ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianDensityPropagation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。 | [EXTRA] |

[EXTRA] [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对∀n、D、f、Φ、ρ；D仅需Lebesgue零可测而不强制开，C¹场具有联合C²全时间实际流，全空间div f=0，D对每个时间流不变；densityOn要求D上非负、可测及可积而不要求归一化。结论对每个实t同时给出D上ρ∘Φ_{-t}的积分不变及其密度测度等于Φ\_t推前初始密度测度。全局流的逆是Φ_{-t}，散度零和正则性足以推出Jacobian行列式1，继而体积保持；未将体积保持作为前提。正负时间方向和限制域均正确。形式指数用实际拉回/推前表达，[EXTRA]合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.hamiltonianDensityPropagation`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L632)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-MechanicalLiouvillian · definition · 印刷p.187 / PDFp.208

### 2. 原文陈述

> The Liouvillian of a Hamiltonian system with $`N_c`$ degrees of freedom and a Hamiltonian of the form $`H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})`$ can be written

$$
\mathcal L_H^\dagger=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},
$$


> where $`F_i=-\partial U/\partial q_i`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mechanicalLiouvillian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对Phase n=E n×E n、m为固定坐标质量、F仅依赖q、u和z为完整相空间标量函数与点。负Fréchet导数作用于(p\_i/m\_i,F(q))，在u可微处恰为-∑(p\_i/m\_i)∂q\_i u-∑F\_i∂p\_i u，两个负号正确。这是可复用的微分表达式定义，不自身断言任意F均由势生成。其Hamiltonian特化F=-gradient U、正质量和C²势由本批条目12明确给出并核对，故结合该显式特化可接受；单独此定义不构成从H推出身份的证明。零质量或不可微u下Lean的总定义扩展不解释为原书物理算子。

### 7. 状态与证明位置

self-contained；`MD.Ch05.mechanicalLiouvillian`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L642)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-MechanicalLiouvillianIdentity · unnumbered_claim · 印刷p.187 / PDFp.208

### 2. 原文陈述

> The Liouvillian of a Hamiltonian system with $`N_c`$ degrees of freedom and a Hamiltonian of the form $`H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})`$ can be written

$$
\mathcal L_H^\dagger=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},
$$


> where $`F_i=-\partial U/\partial q_i`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : MolecularDynamics.Chapter05Review.Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) (MolecularDynamics.Chapter05Review.hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    MolecularDynamics.Chapter05Review.mechanicalLiouvillian m (fun q => -gradient U q) u z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mechanicalLiouvillianIdentity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。 | [EXTRA] |

[EXTRA] [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对∀n、所有坐标正质量m、任意C²势U、任意全空间可微实函数u及所有z∈Phase n。H为∑p\_i²/(2m\_i)+U(q)，hamiltonianField实际定义是(∇pH,-∇qH)；由固定非零m及势仅依赖q，恰得(p\_i/m\_i,-∇U(q))。结论将此场的负方向导数等同于mechanicalLiouvillian m (-gradient U)，完整保留一般势、所有q,p和所有u，并无只测二次势的弱化。[EXTRA]明确这是负Lie表达式身份而非无界Hilbert算子域的识别；正质量和C²强化合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mechanicalLiouvillianIdentity`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L648)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-TestSpace · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> The functions on which the generalized function acts are called test functions. Some choices for the space of test functions $`\mathcal T^m`$ defined on $`\mathbb R^m`$ include: the $`C^\infty`$ functions with compact support in $`\mathbb R^m`$, denoted $`C_0^\infty(\mathbb R^m)`$; the space $`\mathcal S(\mathbb R^m)`$ of $`C^\infty`$ functions on $`\mathbb R^m`$ whose derivatives decay rapidly at infinity (the so-called Schwarz space).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}

/-- 原文第二选项，独立保留Schwartz空间。 -/

def testSpaceSchwartz (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.testSpace`；`MD.Ch05.testSpaceSchwartz` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 紧支持C∞选项保留，并在同一source\_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。 | [EXTRA] |

[EXTRA] [EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。；[EXTRA] 紧支持C∞选项保留，并在同一source\_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。

### 6. 审计结论

本轮修复：紧支持C∞选项保留，并在同一source\_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；当前仅有testSpace n这一声明：实n维欧氏空间上的实值函数子类型，ContDiff ℝ ∞与HasCompactSupport正确编码第一选项C∞紧支持，未误用Cω。但原文及本条statement\_scope还完整列出第二选项S(R^m)，且context\_notation声称两个选项都保留。所给本source\_id全部声明与依赖里没有SchwartzMap/Schwartz空间选项、二选一接口或对应映射；不能因其他条目6引用过schwartzSpace就认定本条已经覆盖第二选项。因此完整覆盖FAIL；第一选项自身PASS。

### 7. 状态与证明位置

self-contained；`MD.Ch05.testSpace`：定义；`MD.Ch05.testSpaceSchwartz`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L659)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-SchwartzSpace · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> The formal definition of $`\mathcal S`$ is

$$
\mathcal S(\mathbb R^m)\stackrel{\rm def}{=}\{f\in C^\infty(\mathbb R^m)\mid\|f\|_{\alpha,\beta}\lt \infty\},
$$


> where $`\alpha`$ and $`\beta`$ are arbitrary multi-indices, i.e. vectors of non-negative integers, and

$$
\|f\|_{\alpha,\beta}\stackrel{\rm def}{=}\sup_{z\in\mathbb R^m}\left|z_1^{\alpha_1}z_2^{\alpha_2}\cdots z_m^{\alpha_m}\frac{\partial^{\beta_1+\beta_2+\cdots+\beta_m}f}{\partial z_1^{\beta_1}\partial z_2^{\beta_2}\cdots\partial z_m^{\beta_m}}\right|.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def schwartzTestSpace (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.schwartzTestSpace` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。 | [EXTRA] |

[EXTRA] [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。项目 E n 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)；MD.Ch05.schwartzTestSpace n 为 SchwartzMap (E n) ℝ。依用户补充规则，采信 SchwartzMap 的标准意义：实际实值 C∞ 函数，任意自然数 k 与微分阶数 r 的 ‖x‖^k‖D^r f(x)‖ 有统一有限上界。该标准空间自身使用 C∞ 阶数 ∞，不能因项目 testSpace 中另有 ⊤ 误用而把它当成解析函数空间。在有限维 ℝⁿ 上，全阶 Fréchet 导数范数的多项式权界与原书任意多重指标 α、β 的坐标单项式加权偏导数界等价：正向由坐标偏导受全阶导数范数控制，反向由有限坐标展开及有限维范数等价保证。n 任意，标量及函数值均为 ℝ，全部微分阶数与全部权的量词均保留。[EXTRA] 是等价的标准实现说明，没有增加数学限制，合理；无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.schwartzTestSpace`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L667)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GeneralizedFunction · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def generalizedFunction (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.generalizedFunction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。MD.Ch05.generalizedFunction 的完整定义是 (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ；该声明没有调用待展开的 MolecularDynamics 自定义定义。按标准含义，结果恰为 T 上满足加法及实数标量作用的实值代数线性泛函。量词／参数顺序为测试空间 T、其加法群及实模块结构，随后构成所有这些线性泛函的类型；这些结构编码原文所需的实向量空间。T 作为适当测试函数空间的抽象参数，无需给测试函数选定拓扑。原文只要求 real-valued linear operation，没有连续性要求，本签名亦没有连续性前提或字段，符合 context\_notation。[EXTRA] 与 [ERRATUM?] 均无。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.generalizedFunction`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L670)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-SchwartzFunctional · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def schwartzFunctional (n : ℕ) := (MolecularDynamics.Chapter05Review.schwartzSpace n) →ₗ[ℝ] ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.schwartzFunctional` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。 | [EXTRA] |

[EXTRA] [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已从依赖附件展开 MolecularDynamics.Chapter05Review.schwartzSpace n := SchwartzMap (E n) ℝ 与 E n := EuclideanSpace ℝ (Fin n)。因此 MD.Ch05.schwartzFunctional n 是 ℝⁿ 上实际 Schwartz 实值测试函数空间到 ℝ 的实线性泛函类型。变量 n 任意，实标量、实值域及完整线性要求均保留，没有附加连续性。[EXTRA] 明确选择原书列出的第二种测试空间，是合理专门化，泛型 generalizedFunction 与另一测试空间条目在本批分别保留。另一条 testSpace 的阶数偏差由该条的 FAIL 单独记录，不影响此处 Schwartz 专门化与原文的对应。无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.schwartzFunctional`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L674)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-RegularDistribution · definition · 印刷p.188–189 / PDFp.209–210

### 2. 原文陈述

> If $`f`$ is a bounded, smooth function on $`\mathbb R^m`$, we may define a generalized function $`T_f`$ by reference to its action on a test function $`\phi\in\mathcal T`$ via integration:

$$
T_f(\phi)=\int_{\mathbb R^m}f(z)\phi(z)d\omega.
$$


> This is very like the $`L^2`$ inner product, but the functions involved do not both need to lie in $`L^2`$. Nevertheless, we write $`T_f(\phi)=\langle f,\phi\rangle`$, as a helpful shorthand.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.regularDistribution` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E n 是实 n 维欧氏空间，schwartzSpace n 是实值 SchwartzMap。声明对任意 n、任意实函数 f 及 Schwartz 测试函数 φ 定义体积积分 ∫ fφ，积分域和被积式正确。它把原书的有界光滑 f 定义式延伸到更大的函数类型；总化积分在这一定义中不声称任意 f 都产生线性分布。在原书有界 C∞ 范围，可积性和完整实线性由本批条目2的 regularDistributionLinearity 承担；本定义无需把这些结论充当参数。原页明列 Schwartz 为一种可选测试空间，因此所选测试域忠实。

### 7. 状态与证明位置

self-contained；`MD.Ch05.regularDistribution`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L677)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-RegularDistributionLinearity · unnumbered_claim · 印刷p.188 / PDFp.209

### 2. 原文陈述

> If $`f`$ is a bounded, smooth function on $`\mathbb R^m`$, we may define a generalized function $`T_f`$ by reference to its action on a test function $`\phi\in\mathcal T`$ via integration: $`T_f(\phi)=\int_{\mathbb R^m}f(z)\phi(z)d\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem regularDistributionLinearity : ∀ n (f : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ ∞ f → (∃ C : ℝ,∀ z,|f z| ≤ C) →
  (∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,Integrable (fun z => f z*φ z) volume) ∧
  (∀ (φ ψ : MolecularDynamics.Chapter05Review.schwartzSpace n) (a b : ℝ),
    MolecularDynamics.Chapter05Review.regularDistribution f (a • φ+b • ψ)=a*MolecularDynamics.Chapter05Review.regularDistribution f φ+b*MolecularDynamics.Chapter05Review.regularDistribution f ψ) := by
  intro n f hf hb
  obtain ⟨C,hC⟩ := hb
  have hi : ∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,
      Integrable (fun z => f z*φ z) volume := by
    intro φ
    apply Integrable.mono' (φ.integrable.norm.mul_const C)
    · exact hf.continuous.measurable.aestronglyMeasurable.mul φ.continuous.measurable.aestronglyMeasurable
    · filter_upwards [] with z
      simpa only [norm_mul,Real.norm_eq_abs,mul_comm] using mul_le_mul_of_nonneg_right (hC z) (abs_nonneg (φ z))
  refine ⟨hi,?_⟩
  intro φ ψ a b
  simp only [MolecularDynamics.Chapter05Review.regularDistribution,SchwartzMap.add_apply,SchwartzMap.smul_apply,smul_eq_mul]
  simp_rw [mul_add,← mul_assoc,mul_comm (f _) a,mul_comm (f _) b]
  simp_rw [mul_assoc]
  rw [integral_add ((hi φ).const_mul a) ((hi ψ).const_mul b),integral_const_mul,integral_const_mul]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.regularDistributionLinearity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。 | [EXTRA] |

[EXTRA] [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。；[EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全部量词为 ∀ n、∀ f，随后要求 ContDiff ℝ ∞ f 和一个对所有 z 通用的实上界 C。∞ 是 C∞，不是实解析。结论保留两个部分：每个 Schwartz φ 的 fφ 体积可积，以及对任意 φ、ψ 和任意实标量 a、b 的完整线性等式。regularDistribution 的依赖是真实积分；没有将可积性或线性改放进假设。有界光滑是原书条件，Schwartz 是书中明列的测试选择；[EXTRA] 的实质与签名一致。审校不将已有证明文本当作本次编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch05.regularDistributionLinearity`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L682)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracAction · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> For the Dirac delta $`\delta`$, its action on a function $`\phi\in\mathcal T`$ is $`\delta[\phi]=\phi(0)`$. We write this also as $`\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def diracAction {n : ℕ} (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := φ 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracAction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已展开项目 schwartzSpace n := SchwartzMap (E n) ℝ 与 E n := EuclideanSpace ℝ (Fin n)，MD.Ch05.diracAction {n} φ 与依赖同名定义均直接返回 φ 0。按标准 SchwartzMap 函数作用，0 是 ℝⁿ 的零向量，返回实际实数 φ(0)，n 与 φ 均任意，恰为原页 δ[φ]=φ(0)。评价对测试函数加法和实数倍具有标准线性意义，原页 ⟨δ,φ⟩ 和形式积分表示同一动作，没有要求普通 Lebesgue 密度。选择原书列出的 Schwartz 测试空间是合理专门化；本条未单列 [EXTRA]，但这一选择由参数类型及本批相关定义明确，不附加排除 Schwartz 成员的条件。无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracAction`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L704)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracMeasure · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> For the Dirac delta $`\delta`$, its action on a function $`\phi\in\mathcal T`$ is $`\delta[\phi]=\phi(0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracMeasure` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已展开项目 E n := EuclideanSpace ℝ (Fin n)，并核对 MD.Ch05.diracMeasure n 与依赖同名定义均为 Measure.dirac 0 : Measure (E n)。按补充规则采信标准零点 Dirac 测度：单位质量集中于0；其对本批连续 Schwartz 测试函数的积分作用为 ∫ φ(z) d(δ\_0)(z)=φ(0)。因此测度对象、零点、单位质量、任意维度以及原文的全部评价动作均一致，与同批 diracAction 的实现相符。它实现原文的点分布，没有将形式 δ(z)dω 解释成普通光滑 Lebesgue 密度。不存在必要而未提供的项目自定义定义。[EXTRA] 与 [ERRATUM?] 均无。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracMeasure`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L707)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracApproximation · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> This concept of the delta function (that appears in the integral) may be motivated by introducing a sequence of continuous functions $`d_\varepsilon`$ having the properties (i) $`\int d_\varepsilon d\omega=1`$, (ii) $`\operatorname{supp}(d_\varepsilon)\to0`$, as $`\varepsilon\to0`$. Then the action of the delta function can be seen as the limit of the actions of the functions $`d_\varepsilon`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem diracApproximation :
  ∀ n (r : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ ε > 0,Continuous (r ε)) →
  (∀ ε > 0,MolecularDynamics.Chapter05Review.probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro n r hr hp hs φ hφ
  apply Metric.tendsto_nhds.mpr
  intro e he
  obtain ⟨δ,hδ,hφδ⟩ := Metric.continuousAt_iff.mp hφ.continuousAt (e/2) (by positivity)
  obtain ⟨η,hη,hsη⟩ := hs δ hδ
  filter_upwards [Ioo_mem_nhdsGT hη] with ε hε
  have hd := (hp ε hε.1).1
  have hmass := (hp ε hε.1).2
  have hb : ∀ z,‖(φ z-φ 0)*r ε z‖ ≤ (e/2)*r ε z := by
    intro z
    by_cases hz : r ε z=0
    · simp [hz]
    · have hzball := hsη ε hε (show z ∈ Function.support (r ε) from hz)
      have heφ := hφδ (by simpa only [Metric.mem_ball] using hzball)
      simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hd.2.1 z),Real.dist_eq] using
        mul_le_mul_of_nonneg_right heφ.le (hd.2.1 z)
  have hdiff : Integrable (fun z => (φ z-φ 0)*r ε z) volume := by
    apply Integrable.mono' (hd.2.2.const_mul (e/2))
    · exact ((hφ.sub continuous_const).mul (hr ε hε.1)).measurable.aestronglyMeasurable
    · exact ae_of_all _ hb
  have hpr : Integrable (fun z => φ z*r ε z) volume := by
    convert hdiff.add (hd.2.2.const_mul (φ 0)) using 1
    funext z
    change φ z*r ε z=(φ z-φ 0)*r ε z+φ 0*r ε z
    ring
  have hi : (∫ z,(φ z-φ 0)*r ε z)=(∫ z,φ z*r ε z)-φ 0 := by
    simp_rw [sub_mul]
    rw [integral_sub hpr (hd.2.2.const_mul (φ 0)),integral_const_mul,hmass,mul_one]
  have hle := norm_integral_le_of_norm_le (hd.2.2.const_mul (e/2)) (ae_of_all _ hb)
  rw [integral_const_mul,hmass,mul_one,hi] at hle
  rw [dist_eq_norm]
  exact hle.trans_lt (by linarith)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracApproximation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。 | [EXTRA] |

[EXTRA] [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已读取并展开 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean（5315–5348行）：E n = EuclideanSpace ℝ (Fin n)；density ρ = Measurable ρ ∧ (∀ z,0 ≤ ρ z) ∧ Integrable ρ volume；probabilityDensity ρ = density ρ ∧ (∫ z,ρ z)=1；schwartzSpace n = SchwartzMap (E n) ℝ；diracAction φ = φ 0；diracMeasure n = Measure.dirac 0；gaussianDelta ε z = Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)。 量词顺序为任意维数、任意参数族，依次给出正参数下连续性、概率密度资格及统一最终支撑收缩，最后对每个连续测试函数断言 ε→0+ 的积分收敛到 φ(0)。Function.support 是非零点集合；对所有 δ>0 的该收缩条件与闭支持收缩等价（先用 δ/2）。连续测试函数虽可全局无界，但最终支持位于零点附近，局部有界足以保证乘积可积。非负性是明确披露、合理的 [EXTRA]；原文只列质量1与支撑收缩，若允许带符号函数，其推论不成立。例如取非负偶光滑紧支撑概率密度 b，令 rε(x)=ε⁻¹b(x/ε)+ε⁻²b((x−2ε)/ε)−ε⁻²b((x+2ε)/ε)，则质量1、支持收缩，而对在零附近等于 x 的光滑紧支撑 φ，积分最终等于4而 φ(0)=0。统一 L¹ 界可作为非负性的替代条件；当前签名已作显式修补，不应把这一修补回写为原书已有假设。无 [ERRATUM?] 标签。 签名语义与证明状态分别判断：已读 Ch05.lean 对应声明及其证明块，本条无 sorry/admit；本轮只读语义审计，没有运行 Lean 编译，PASS 不表示编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracApproximation`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L711)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDelta · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $`\{d_\varepsilon\}`$, such as, in one dimension,

$$
d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDelta` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数 ε、z 均为实数，Real.exp (−z²/(2ε))/Real.sqrt (2*pi*ε) 与原式仅相差乘法因子次序。作为函数的总化定义允许所有 ε；其概率或逼近单位元含义只在 ε>0 下使用，已由 context\_notation 说明，并由条目5、6分别审校。高斯对 ε>0 的支撑是全实线；原页用 Alternatively 引入另一种近似族，并未把紧支撑收缩作为本定义的条件。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDelta`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L752)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracEvaluates · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> $`\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem diracEvaluates : ∀ n (φ : MolecularDynamics.Chapter05Review.schwartzSpace n),
  (∫ z,φ z ∂(MolecularDynamics.Chapter05Review.diracMeasure n))=MolecularDynamics.Chapter05Review.diracAction φ := by
  intro n φ
  simp [MolecularDynamics.Chapter05Review.diracMeasure,MolecularDynamics.Chapter05Review.diracAction]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracEvaluates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀ n 和 ∀ 实值 Schwartz φ 的量化完整。diracMeasure n 展开为 E n 上的 Measure.dirac 0，diracAction φ 展开为 φ 0，故结论是真实 Dirac 测度积分等于在原点取值。δ 处的书面形式积分被正确解释为测度／分布配对，没有把 δ 换成普通 Lebesgue 密度。Schwartz 是前页给出的可选测试空间；无附加可积性假设，也没有漏掉右端的取值结论。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracEvaluates`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L755)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDeltaProbability · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $`\{d_\varepsilon\}`$, such as, in one dimension,

$$
d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ MolecularDynamics.Chapter05Review.gaussianDelta ε x) ∧ Integrable (MolecularDynamics.Chapter05Review.gaussianDelta ε) volume ∧
  (∫ x,MolecularDynamics.Chapter05Review.gaussianDelta ε x)=1 := by
  intro ε hε
  have he0 : ε ≠ 0 := ne_of_gt hε
  have hcoef : 0 < (1 : ℝ)/(2*ε) := by positivity
  have heq : MolecularDynamics.Chapter05Review.gaussianDelta ε=
      (fun x : ℝ => Real.exp (-(1/(2*ε))*x^2)/Real.sqrt (2*Real.pi*ε)) := by
    funext x
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    congr 2
    ring
  rw [heq]
  refine ⟨fun x => by positivity,?_,?_⟩
  · exact (integrable_exp_neg_mul_sq hcoef).div_const _
  · rw [integral_div,integral_gaussian]
    have hp0 : 0 ≤ 2*Real.pi*ε := by positivity
    have hratio : Real.pi/(1/(2*ε))=2*Real.pi*ε := by field_simp
    rw [hratio,div_self (ne_of_gt (Real.sqrt_pos.2 (by positivity)))]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDeltaProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。 | [EXTRA] |

[EXTRA] [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；声明对每个实 ε，在 0<ε 的明确条件下，同时断言对所有实 x 的非负性、相对于实线 Lebesgue 体积的可积性以及完整全空间积分等于1。依赖 gaussianDelta 的指数为 −x²/(2ε)，归一化为 √(2πε)；这是真实的方差 ε 高斯密度。三个概率密度资格都在结论里，未由总化定义或预设积分等于1替代。[EXTRA] 的正参数条件必要且合理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDeltaProbability`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L762)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDeltaWeak · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $`\{d_\varepsilon\}`$, such as, in one dimension,

$$
d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro φ hφ hb
  have hg := gaussianDeltaProbability 1 (by norm_num)
  obtain ⟨C,hC,hBC⟩ := hb.exists_pos_norm_le
  have ht : Tendsto (fun ε : ℝ => ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (𝓝[>] 0) (𝓝 (φ 0)) := by
    have hc := tendsto_integral_filter_of_dominated_convergence
      (fun x : ℝ => C*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (F:=fun ε x => φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (f:=fun x => φ 0*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (Filter.Eventually.of_forall (fun ε => by
        apply Continuous.aestronglyMeasurable
        unfold MolecularDynamics.Chapter05Review.gaussianDelta
        fun_prop))
      (Filter.Eventually.of_forall (fun ε => ae_of_all _ (fun x => by
        simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hg.1 x)] using
          mul_le_mul_of_nonneg_right (hBC (φ (Real.sqrt ε*x)) (mem_range_self _)) (hg.1 x))))
      (hg.2.1.const_mul C) (ae_of_all _ (fun x => by
        have hs : Tendsto (fun ε : ℝ => Real.sqrt ε*x) (𝓝[>] 0) (𝓝 0) := by
          simpa using! ((Real.continuous_sqrt.tendsto 0).mono_left inf_le_left).mul_const x
        exact (hφ.tendsto 0 |>.comp hs).mul_const _))
    simpa only [integral_const_mul,hg.2.2,mul_one] using hc
  apply tendsto_congr' _ |>.2 ht
  filter_upwards [self_mem_nhdsWithin] with ε hε
  have hεpos : 0 < ε := hε
  have hspos : 0 < Real.sqrt ε := Real.sqrt_pos.2 hεpos
  have hs0 : Real.sqrt ε ≠ 0 := ne_of_gt hspos
  have hpoint (x : ℝ) : Real.sqrt ε*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)=
      MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    rw [mul_pow,Real.sq_sqrt hεpos.le]
    have hexp : -(ε*x^2)/(2*ε)= -x^2/2 := by field_simp
    rw [hexp,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
    simp only [mul_one]
    field_simp
  calc
    (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=
      Real.sqrt ε*(∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)) := by
        change (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=Real.sqrt ε*(∫ x,(fun y => φ y*MolecularDynamics.Chapter05Review.gaussianDelta ε y) (Real.sqrt ε*x))
        have hchange : (∫ x : ℝ,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x))=
            (Real.sqrt ε)⁻¹*(∫ x : ℝ,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) := by
          simpa only [smul_eq_mul,abs_of_pos (inv_pos.mpr hspos)] using!
            (Measure.integral_comp_mul_left (fun x : ℝ => φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (Real.sqrt ε))
        rw [hchange]
        field_simp
    _ = ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
      rw [←integral_const_mul]
      apply integral_congr_ae
      filter_upwards [] with x
      rw [←hpoint]
      ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDeltaWeak` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。 | [EXTRA] |

[EXTRA] [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化所有 φ:ℝ→ℝ，要求 Continuous φ 及 Bornology.IsBounded (range φ)，即有界连续测试函数。对真实配对 ∫φ(x)dε(x) 的结论使用 𝓝[>]0，正确表示 ε 从正侧趋于0，目标是 φ 0。它覆盖书中 Schwartz 和光滑紧支撑测试函数，并合理推广到有界连续测试；没有错误地要求高斯支撑收缩。正侧滤子、全实线积分、乘法配对及极限值均完整；[EXTRA] 没有把所求极限作为假设。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDeltaWeak`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L784)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-WeakStationary · definition · 印刷p.189–190 / PDFp.210–211

### 2. 原文陈述

> We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of

$$
\mathcal L_f^\dagger\rho=0.
$$


> However, this requires a little care. In general, we would like to be able to apply $`\mathcal L_f^\dagger`$ to nonsmooth distributions such as Dirac delta functions for which the application of the Liouville operator does not make obvious sense (as we have not mentioned how to differentiate delta functions). Instead we will define the stationary solution in terms of integrals against test functions.
> this suggests that the condition for the invariant probability density function $`\rho_\infty`$ should be

$$
\int_{\mathcal D}\phi\mathcal L_f^\dagger\rho_\infty\,d\omega=0,
$$


> for all suitable functions $`\phi\in C_0^\infty(\mathbb R^m)`$. We say that $`\rho_\infty`$ satisfies

$$
\mathcal L^\dagger\rho_\infty=0,
$$


> in the weak or variational sense.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。 | [EXTRA] |

[EXTRA] [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。；[EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；testSpace n 展开后恰为所有满足 ContDiff ℝ ∞ 和 HasCompactSupport 的实函数，不是 Cω 类型。lie f φ z 是真实 fderiv ℝ φ z 作用于 f z。weakStationary 对每个这样的 φ 同时要求 lie 的 μ 可积性和积分为0，因此保留全部测试量词及非平凡弱方程；没有依赖不可积 Bochner 积分的默认0。全空间测度 μ 可取受限域 D 上密度测度的零延拓，分布伴随的边界作用由该配对保留。μ 类型允许一般正测度，是稳态方程本身的推广；若要称为原书的概率分布，还应另有 μ(univ)=1 的资格。本定义没有声称每个 weakStationary μ 都已经归一化，也未声称在任意不规则 f 下与某个流的不变性等价。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakStationary`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L840)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnsembleAverage · 5.6 · 印刷p.190 / PDFp.211

### 2. 原文陈述

> Let $`\phi`$ be a $`C^\infty`$ function of the phase variables with compact support and define the time $`t`$ average by

$$
\bar\phi(t)=\frac{\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho(\mathbf q,\mathbf p,t)\,d\omega}{\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega}.\tag{5.6}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ensembleAverageOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；ensembleAverageOn 的参数完整含 n、域 D、随时间变化的 ρ:ℝ→E n→ℝ、观测函数 φ 和时刻 t。densityAverageOn 展开后为 (∫_D φ(z)ρ(t,z))/(∫_D ρ(t,z))，没有漏掉分母、域或时间参数。定义的函数类型较原书的概率密度和 C∞ 紧支撑观测函数更宽；在原书资格下恰为(5.6)。这是时刻 t 的系综平均，没有换成时间轨道平均；对总质量0或不可积输入的总化值不赋予概率平均含义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.ensembleAverageOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L847)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ConvergenceHeuristic · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> As the flow is Hamiltonian, $`\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega\equiv\int_{\mathcal D}\rho(\mathbf q,\mathbf p,0)\,d\omega`$. Thus the condition for $`\bar\phi`$ to converge is just that

$$
\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\frac{\partial\rho}{\partial t}(\mathbf q,\mathbf p,t)\,d\omega\to0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem convergenceHeuristic : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → MolecularDynamics.Chapter05Review.flow f Φ → (∀ t,Φ t '' D=D) →
  (∀ t,MeasurePreserving (Φ t) volume volume) →
  ContDiff ℝ 1 (Function.uncurry ρ) → ContDiff ℝ ⊤ φ → HasCompactSupport φ →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0) →
    ∃ L : ℝ,Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ConvergenceHeuristic。改动：导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。 -/
```

独立修正版：

```lean
theorem convergenceHeuristic_corrected (A : ℝ → ℝ)
    (_hA : ContDiff ℝ 1 A) (_hint : IntegrableOn (deriv A) (Ici (0 : ℝ))) :
    ∃ L : ℝ, Tendsto A atTop (𝓝 L) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.convergenceHeuristic`；`MD.Ch05.convergenceHeuristic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。 | [EXTRA] |

[EXTRA] [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。；[ERRATUM?] 导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05\_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input\_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x\_source.json。核对 Ch05.lean:707–716，并展开项目 flow、measurePropagator 以及本文件的 densityOn、probabilityDensityOn、densityMeasureOn、densityAverageOn。flow 含 Φ0=id、实时间群律及每条轨道的真实 ODE 导数；measurePropagator 是 Measure.map；densityOn 是受限体积下的可测、非负、可积资格，probabilityDensityOn 另含 ∫_Dρ=1；densityMeasureOn 是 (volume.restrict D).withDensity(ofReal ρ)；densityAverageOn 是实际积分商。标准定义足以确认这些对象，无缺失 Mathlib 定义问题。量词先给 n,D,f,Φ,ρ,φ，前提为零可测 D、真实流、D 流不变、每个 Φt 保体积、联合 C¹ 密度、C∞ 紧支撑 φ、各时刻实际概率密度及从初始测度的真实输运；最后假设导数配对趋零，并得依赖 φ 的某个平均极限。[EXTRA] 域不变、输运与保体积均合理，未假设最终平均收敛。质量等式可由各时刻概率归一化直接读出，两端都是 1，不因其未重复列在结论而判失败。保留 FAIL 的具体原因是 statement\_scope 的完整条件措辞：“the condition ... is just that”的条件读法包含必要方向，当前签名只有导数配对趋零 ⇒ 平均收敛；缺少反向，而且没有在映射中登记为单向子命题。原文未写显式 iff，这一范围问题不能通过默认把“condition”缩成充分性来静默消除；若采用这种作者解释，需明确登记缩窄范围。此 FAIL 不表示目前充分方向在上述动力学背景中为假，也不依据 Mathlib 缺失。一般标量导数趋零却不收敛的例子不是满足该签名全部前提的反例。证明体为 sorry，单独记录，不用于决定语义 verdict；无 [ERRATUM?] 标注。

### 7. 状态与证明位置

incomplete；`MD.Ch05.convergenceHeuristic`：未证（原书疑误不证）；`MD.Ch05.convergenceHeuristic_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L853)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HamiltonianEnergyIntegral · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> In the case of a Hamiltonian system, we know that $`\mathcal L_f^\dagger=-\mathcal L_f`$, and, moreover, $`\mathcal L_fH=0`$, so that $`H`$ is a first integral.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0 := by
  rw [MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson]
  exact MolecularDynamics.textbookPoissonBracket_self H z

theorem hamiltonianEnergyIntegral_full (k : ℕ)
    (H u : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (_hH : ContDiff ℝ 2 H) (_hu : ContDiff ℝ 1 u)
    (z : MolecularDynamics.SymplecticCoordinates k)
    (γ : ℝ → MolecularDynamics.SymplecticCoordinates k) (a b : ℝ) (_hab : a ≤ b)
    (_hγ : ∀ t ∈ Icc a b,HasDerivWithinAt γ
      (MolecularDynamics.textbookHamiltonianVectorField H (γ t)) (Icc a b) t) :
    -(LinearMap.trace ℝ (MolecularDynamics.SymplecticCoordinates k)
      (fderiv ℝ (fun x ↦ u x • MolecularDynamics.textbookHamiltonianVectorField H x) z).toLinearMap)=
        -MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) u z ∧
    (∀ t ∈ Icc a b,H (γ t)=H (γ a)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianEnergyIntegral`；`MD.Ch05.hamiltonianEnergyIntegral_full` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实Hamiltonian场的−div(u f)=−L\_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L\_fH=0，不把散度零/能量守恒当假设。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实Hamiltonian场的−div(u f)=−L\_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L\_fH=0，不把散度零/能量守恒当假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；本条两项声明均已核对。hamiltonianEnergyIntegral 对任意 Nc、实 Hamiltonian H 及 z 给出真实 Hamiltonian 向量场的 L\_f H(z)=0；J 的项目定义为块矩阵 [0,I;−I,0]，Lie 导数为实际 Fréchet 导数沿 f 的作用。这个基础等式允许任意 H，是导数总化下的代数恒等式。hamiltonianEnergyIntegral\_full 另量化 k、H、u、z、实际轨道 γ、闭区间端点 a,b；要求 H 为 C²、u 为 C¹、a≤b，并在 Icc a b 每点满足正确的 HasDerivWithinAt Hamiltonian 轨道方程。其合取结论完整包含 −trace D(u f)(z)=−L\_f u(z)，以及对每个 t∈Icc a b 的 H(γ t)=H(γ a)。前者是书中形式伴随的点态表达，后者落实真实轨道上的第一积分；未把散度零或能量守恒当成假设。闭区间退化为单点时结论也正确。

### 7. 状态与证明位置

incomplete；`MD.Ch05.hamiltonianEnergyIntegral`：已证；`MD.Ch05.hamiltonianEnergyIntegral_full`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L878)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnergyDensityInvariant · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> Any probability distribution whose density is a smooth function of $`H`$ will also be an invariant distribution.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyDensityInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    Φ (r : ℝ → ℝ), MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,MolecularDynamics.Chapter05Review.lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ H) → ∀ t,
    MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H))=MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.energyDensityInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。 | [EXTRA] |

[EXTRA] [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05\_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input\_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x\_source.json。已展开 Chapter05/ReviewDefinitions 中 E、flow、lie、density、probabilityDensity、densityMeasure、measurePropagator，并核对 Ch05.lean:726–732。项目 probabilityDensity(r∘H) 要求其可测、非负、对标准体积可积且积分为 1；densityMeasure 是实际 withDensity(ofReal(r∘H))，推前是 Measure.map。全称量词对 n,H,f,Φ,r，假设 H,r 为 C¹、Φ 是真实自治流、DH[f]=0、每个 Φt 保体积和真实概率资格；结论是对全部实时间 t 密度测度推前等于原测度。[EXTRA] 能量第一积分与保体积是 Hamiltonian 背景的实际结构属性，抽象登记后给出更一般的同结论命题，并未把待证的不变密度测度当成假设。C¹ 足以支持链式法则，概率资格保留了源文对 distribution 的限制；未声称任意 r∘H 自动可积。对象、量词、假设及不变结论忠实；PASS。证明体为 sorry；该 PASS 只指签名语义，不表示证明完成。无 [ERRATUM?] 标注。

### 7. 状态与证明位置

incomplete；`MD.Ch05.energyDensityInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L898)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeight · definition · 印刷p.190 / PDFp.211

### 2. 原文陈述

> In particular, consider the density $`\rho_\varepsilon(\mathbf q,\mathbf p)=Z_\varepsilon^{-1}e^{-(H(\mathbf q,\mathbf p)-E)^2/(2\varepsilon)}`$, where $`\varepsilon`$ is an arbitrary small positive constant and $`E`$ is an accessible energy level.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeight` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellWeight 对 n、H:E n→ℝ、实 c、ε 以及 z 定义 exp(−(H(z)−c)²/(2ε))。能级 c 对应原文 E；平方、负号和2ε均正确。它确实只是未归一化权，没有被错认成 ρε；按已明示的范围，由 shellPartition 和 shellDensity 分别处理 Z 和完整密度。ε>0、可达性和增长性是原书的使用资格，裸函数定义的总化参数域并不声称任意输入都是概率密度。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellWeight`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L908)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellPartition · definition · 印刷p.190–191 / PDFp.211–212

### 2. 原文陈述

> We assume that $`H`$ tends to infinity sufficiently rapidly as $`\|\mathbf z\|\to\infty`$ so that the exponential decays sufficiently rapidly (and thus the total integral exists) and take $`Z_\varepsilon`$ to be a normalization factor that insures that we have, for each $`\varepsilon`$, a well defined probability density function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellPartition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellPartition 的 n、H、能级 c、ε 与实际 shellWeight 一致；定义的是全 E n 上未归一化权的 Lebesgue 体积积分，正是原书归一化要求确定的 Zε。原文把增长足够快、从而总积分存在作为假定；当前声明是归一化因子的定义，没有另外声称从一个未指定速率的定量增长条件推出可积性。在原书的正 ε、可积权语境下指数处处为正，因此该积分是有限正归一化因子。context\_notation 已明确区分总化定义和实际概率使用资格；不能据此定义推断任意 H 的归一化可行。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellPartition`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L911)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellDensity · definition · 印刷p.190 / PDFp.211

### 2. 原文陈述

> $`\rho_\varepsilon(\mathbf q,\mathbf p)=Z_\varepsilon^{-1}e^{-(H(\mathbf q,\mathbf p)-E)^2/(2\varepsilon)}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellDensity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellDensity 使用真实 shellWeight H c ε z 除以真实 shellPartition H c ε，展开后恰为 Zε⁻¹ exp(−(H(z)−c)²/(2ε))；只除一次 Zε，所有参数和同一能级均保持。它没有偷换成另一个函数或常数，也未重复归一化。作为定义允许较大参数类型；概率密度的非负可积及正分母资格仍按原书及 context\_notation 使用，不由总化除法自动提供。此项没有额外宣称任意 H 或非正 ε 都是概率密度。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellDensity`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L914)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnergySurface · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> We assume the level sets $`\Sigma_E=\{(q,p)\mid H(q,p)=E\}`$ to be bounded.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.energySurface` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。 MD.Ch05.energySurface {n} H c = {z | H z=c}，与原文Σ\_E完全相同，n为环境维度，c为能量值。此条kind=definition，只形式化能量等值集合；原书有界性是使用假设，原条context\_notation已明确单列，不从def推出。没有额外假设或ERRATUM；定义体无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.energySurface`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L917)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-SurfaceMeasure · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> where $`d\sigma`$ is the “area element” of the energy surface. (The term “area” in this context might be replaced by “hyperarea” or “volume” since we are in many dimensions.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.surfaceMeasure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。 | [EXTRA] |

[EXTRA] [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。 MD.Ch05.surfaceMeasure直接采用上述项目曲面面积定义，所取维度n−1与原文m−1一致，测度对象位于整个相空间而其质量受限于能量面，这是dσ的标准测度实现。EXTRA的Hausdorff规范化选择合理，与Gram图公式的识别是后续证明义务；缺少该证明并不使定义的数学对象失真。正维光滑正则面是几何解释的背景，n=0仅是总化扩展。无ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.surfaceMeasure`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L921)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroRaw · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> define the invariant measure of a set $`M\subset\Sigma_E`$ by

$$
\mu(M)=\int_M\frac1{\|\nabla H\|}d\sigma.
$$


> Thus the invariant measure of interest to us is a rescaling of the indicated metric by the factor $`1/\|\nabla H\|`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microRaw` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。 MD.Ch05.microRaw以非负权ofReal(‖grad H z‖⁻¹)给surfaceMeasure加密度。因此在非零梯度的原文使用范围内，对面上可测M确有μ(M)=∫_M 1/‖∇H‖ dσ，未加概率归一化因子。withDensity、restrict与ofReal按标准含义已足以判定这一对象，不需要它们的库内实现。零梯度处逆元总化为0，不能解释成奇异权；原文PDF213另设梯度远离0。context\_notation关于raw与概率的区别正确。此def记录原文测度，不独立证明Hamiltonian动力学下的invariant属性；没有将该属性冒充已证。无EXTRA/ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microRaw`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L925)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeakPrinted · unnumbered_claim · 印刷p.191 / PDFp.212

### 2. 原文陈述

> As we decrease $`\varepsilon`$, the density remains invariant under Liouville's equation. The prefactor means that we can think of a sequence of smooth densities taken with successively smaller values of $`\varepsilon`$ as approaching the limiting distribution defined in terms of the delta function by

$$
\rho_0(q,p)=Z_{H=E}^{-1}\delta[H(q,p)-E].\tag{5.7}
$$


> To make this statement precise, the definition of the limit must be taken here in the weak sense, that is, we need to study the limit

$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega,\tag{5.8}
$$


> taken in relation to a test function $`\phi\in\mathcal T`$.

### 3. 原文证明

原书无独立完整证明。
> The proof that (5.8) can be taken and that the stated weak-limit identity holds may be found in the PhD thesis of Hartmann [171, Appendix D].（对原页转引的摘要；该恒等式含原书重复归一化及以ρ₀(q,p)代替分布配对的记号疑误，未在此修正。）
原书未给独立完整证明；PDF212转引Hartmann博士论文[171, Appendix D]。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellWeakPrinted :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (MolecularDynamics.Chapter05Review.shellPartition H c ε)⁻¹*(∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ShellWeakPrinted。改动：删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。 -/
```

独立修正版：

```lean
theorem shellWeakPrinted_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧
    ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakPrinted`；`MD.Ch05.shellWeakPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。 | [EXTRA] |

[EXTRA] [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。；[ERRATUM?] 删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。shellWeight H c ε z = exp(−(H z−c)²/(2ε))；shellPartition H c ε = ∫shellWeight；shellDensity = shellWeight/shellPartition。testSpace n = {φ : ℝⁿ→ℝ | φ为C∞且有紧支撑}。microRaw = surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure = ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage = average microMeasure，average μ g = ∫g dμ。regularEnergy H c展开为能量面非空、紧、每点grad≠0，以及raw总质量严格正且有限。 量词为∀n,H,c，在C²与regularEnergy前提后对每个C∞紧支φ，主张ε↓0时Z\_ε⁻¹∫φρ\_ε趋向microAverage。PDF211已将ρ\_ε定义为归一化密度，PDF212式(5.8)再次出现外层Z\_ε⁻¹；项目定义展开确认该签名确实重复归一化。全相空间D=ℝⁿ的EXTRA是合理范围选择，但不能消除反例；原书的尾部可积性也未由regularEnergy单独保证。原文所引Liouville不变性不在本签名结论中。相关原书疑误成立；FAIL来自错误极限和缺失结论，不是Mathlib材料不足。实际声明含sorry，此事实与语义判定分开。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellWeakPrinted`：未证（原书疑误不证）；`MD.Ch05.shellWeakPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L931)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeakLimitCorrected · 5.8 · 印刷p.191 / PDFp.212

### 2. 原文陈述


$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho_\varepsilon\,d\omega,\tag{5.8}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellWeakLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ShellWeakLimitCorrected。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shellWeakLimit_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakLimit`；`MD.Ch05.shellWeakLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正版：不再对已归一化ρ\_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正版：不再对已归一化ρ\_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；这是 source\_id 明示的独立勘误版本，不能按字面(5.8)要求它再除一次 Zε。声明完整量化 n、H、c，要求 n>0、H 为 C²、regularEnergy H c、能级可达，以及存在正 δ 的紧能带与所有 ε∈(0,δ) 的真实权可积及正分母。regularEnergy 展开后含非空紧能量面、其上处处非零的真实梯度、microRaw 有限正总质量；单列可达条件虽冗余但无害。测试空间确为全部 C∞ 紧支撑函数。被积式是 φ乘已经归一化的 shellDensity，ε 从正侧趋零。microAverage 展开为将曲面 Hausdorff 面积按 1/‖∇H‖ 加权后，再以该 raw 总质量归一化的真实测度积分。所有对象和归一化均匹配正确的 coarea 弱极限；紧带及一个较大正参数下的权可积控制带外尾部，所以假设足够，没有把极限当假设。未缩放的 Zε 通常趋零，曲面质量对应 Zε/√(2πε) 的极限而非 Zε 的普通极限。故当前勘误签名 PASS；原书重复归一化仍作为独立疑误 NEEDS\_HUMAN 保留。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellWeakLimit`：未证（原书疑误不证）；`MD.Ch05.shellWeakLimit_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L958)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-SurfaceAreaFormula · unnumbered_claim · 印刷p.191 / PDFp.212

### 2. 原文陈述

> If we can represent the $`m-1`$-dimensional set $`\mathcal M`$ as the image of an open set $`\mathcal U\in\mathbb R^{m-1}`$ under a smooth mapping $`\mathbf g:\mathbb R^{m-1}\to\Sigma_E`$, then we have

$$
\operatorname{Vol}(\mathcal M)=\int_{\mathcal U}\sqrt{\det[(\mathbf g^{\prime}(\boldsymbol\zeta))^T\mathbf g^{\prime}(\boldsymbol\zeta)]}\,d\zeta_1d\zeta_2\cdots d\zeta_{m-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem surfaceAreaFormula :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-SurfaceAreaFormula。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem surfaceAreaFormula_corrected :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.surfaceAreaFormula`；`MD.Ch05.surfaceAreaFormula_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；限定后的 Lean 面积公式在数学上正确：∀ d、g:E d→E(d+1)、开集 U，要求 U 上 C¹、g 全局单射，并要求 U 上每点的真实 fderiv 单射。结论左边使用项目 hausdorffArea d 在 g像U 上的测度，右边由标准欧氏基的导数向量内积构成完整 d×d Gram 矩阵，取 determinant 的非负平方根并在 U 上积分；正是 m=d+1 的无重数面积公式。hausdorffArea 的项目缩放为 d维单位球体积/2^d，落实标准欧氏面积。由于两边分别使用 ENNReal.toReal 和实值 Bochner 积分，非有限情形是总化解释，并不额外宣称面积有限；有限面积时即通常数值公式。未要求像落在某一特定能量面，是对与 H 无关的局部面积公式的合理推广。须明确的是 Function.Injective g 为全局单射，比仅在 U 上单射更强，且 C¹ 比原书 smooth 所需的正则性更弱；这两点都不使受限公式错误。[EXTRA] 确实补入了单射浸入资格，但原书仅凭任意 smooth mapping 的原句不成立，另有 ∈ 的类型错误；按任务要求原书疑误不能静默按 chart 解读，因此本条整体 NEEDS\_HUMAN，而非因 sorry 或限定后公式错误判 FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch05.surfaceAreaFormula`：未证（原书疑误不证）；`MD.Ch05.surfaceAreaFormula_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L986)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalField · definition · 印刷p.192 / PDFp.213

### 2. 原文陈述

> We suppose $`\|\nabla H\|`$ to be bounded away from zero on $`\Sigma_E`$. At each point of $`M`$ we let $`n=\nabla H/\|\nabla H\|`$ be the unit normal to the energy surface and define a local coordinate $`\xi`$ measuring distance along the direction of the unit normal.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def normalField {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := ‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹ • MolecularDynamics.Chapter05Review.grad H z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。 展开MD.Ch05.normalField与项目normalField均为‖grad H z‖⁻¹ • grad H z，对非零梯度正是原文n=∇H/‖∇H‖，范数1并与能量面切空间正交。原文梯度在面上远离0是使用资格；context\_notation明确零梯度处总化向量0不具有单位法线意义。作为normalField定义，此条形式化n，局部距离坐标ξ为引用背景，不自动宣称其存在性。没有EXTRA/ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.normalField`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1014)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalEnergyTaylor · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $`\Delta E=H(\mathbf z+\mathbf n\xi)-H(\mathbf z)=\nabla H\cdot\mathbf n\xi+\mathcal O(\Delta E^2)`$, and $`\mathbf n=\nabla H/\|\nabla H\|`$, we have $`\xi=\Delta E/\|\nabla H\|+\mathcal O(\Delta E^2)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalEnergyTaylor :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • MolecularDynamics.Chapter05Review.normalField H z)-H z-s*‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*s^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalEnergyTaylor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | [EXTRA] |

[EXTRA] [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀ 维数 n、H:E n→ℝ 和基点 z，C² 及 grad H z≠0 后给出 ∃C>0、∃δ>0，再对每个 |s|<δ 断言二阶余项估计。grad 是实际 gradient，normalField 是 ‖grad‖⁻¹•grad，故线性项确为 s‖∇H(z)‖，位置 z+s•normalField 正确。此结论是固定基点的实际 O(s²) 正向 Taylor 子引理；它没有单独给出以 e=ΔE 为参数的逆坐标或 O(e²)。输入 statement\_scope 和 [EXTRA] 已将这些剩余结论明确映射到本批条目16，后者确实完整包含，所以不把子引理冒充整句。C² 和非零梯度是合理的局部资格；没有从总化 gradient 推断任意 H 的 Taylor 展开。

### 7. 状态与证明位置

incomplete；`MD.Ch05.normalEnergyTaylor`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1019)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalInverseTaylor · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $`\Delta E=H(\mathbf z+\mathbf n\xi)-H(\mathbf z)=\nabla H\cdot\mathbf n\xi+\mathcal O(\Delta E^2)`$, and $`\mathbf n=\nabla H/\|\nabla H\|`$, we have $`\xi=\Delta E/\|\nabla H\|+\mathcal O(\Delta E^2)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalInverseTaylor : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0,∃ δ > 0,
  ∀ e : ℝ,|e| < δ → ∃ ξ : ℝ,
    H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)=H z+e ∧
    |ξ-e/‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*e^2 ∧
    |H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)-H z-‖MolecularDynamics.Chapter05Review.grad H z‖*ξ| ≤ C*e^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalInverseTaylor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；声明对每个 n、C² 函数 H 和非临界基点 z，先选择依赖 H,z 的 C>0 和 δ>0，再对每个实 |e|<δ 选择 ξ。三个合取结论都保留：真实能量方程 H(z+ξn)=H(z)+e；|ξ−e/‖∇H(z)‖|≤Ce²；以及同一 ξ 上 |H(z+ξn)−H(z)−‖∇H(z)‖ξ|≤Ce²。最后一项正是原文以 ΔE 为变量的正向余项，而不是只提供 O(ξ²)。同一 C 可通过增大常数同时控制两项；非零梯度给出一维法向能量映射的非零导数，C² 局部逆资格足够。估计还使 ξ 在 e→0 时趋0，故存在性不是无关的远处能量交点。原文 E 在此为 H(z)，法向取在固定基点；本条不声称对整个能量面有统一的常数。

### 7. 状态与证明位置

incomplete；`MD.Ch05.normalInverseTaylor`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1027)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

