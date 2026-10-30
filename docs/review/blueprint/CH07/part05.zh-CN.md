[上一部分](part04.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

## MD-7.7.3-PerturbationCoefficientEquation

印刷页 289–290 / PDF页 310–311。

### 1. 原文陈述

> Inserting this ansatz into the stationary Fokker-Planck equation $`\widehat{\mathcal L}^\dagger\widehat\rho=0`$, we obtain

$$
(\mathcal L_{LD}^\dagger+h\mathcal L_1^\dagger+h^2\mathcal L_2^\dagger+O(h^3))(\rho_\beta[1+hf_1+h^2f_2+O(h^3)])=0.
$$


> Combining like powers, we have at zero’th order, the equation $`\mathcal L_{LD}^\dagger\rho_\beta=0`$.
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

> For some observable $`\vartheta(q,p)`$, we have that

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

> It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $`\mathcal L_{LD}^\dagger`$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.

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

> The general solution of (7.21) will consist of the sum of the homogeneous solution $`f_{1,[XYZ]}^{[HS]}(q,p)`$ and particular solution $`f_{1,[XYZ]}^{[PS]}(q,p)`$ in the usual way. However, since $`\mathcal L_{LD}^\dagger\vartheta=0`$ has as its only solution $`\vartheta\propto\rho_\beta`$, the homogeneous solution of (7.21) is $`f_{1,[XYZ]}^{[HS]}(q,p)=c`$, for some constant $`c`$. Our assumption that $`\langle f_{1,[XYZ]}\rangle=0`$ means that $`c=-\langle f_{1,[XYZ]}^{[PS]}\rangle`$.

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

> If we define the function $`g(q,p)`$ as $`g(q,p)=\beta p^TM^{-1}\nabla U(q)`$, then through simple computation we have

$$
\mathcal L_A^\dagger\rho_\beta=-\mathcal L_B^\dagger\rho_\beta=g(q,p)\rho_\beta.
$$



$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=-(\mathcal L_A^\dagger+\mathcal L_B^\dagger)(g\rho_\beta)=(\mathcal L_O^\dagger-\mathcal L_{LD}^\dagger)(g\rho_\beta).
$$


> For a function $`\psi(q)`$ purely of position, we have

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


> where the constant $`c`$ is chosen to ensure each correction function has average 0, giving $`c=\gamma\langle U(q)\rangle`$.

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

> If $`\vartheta=\vartheta_1(p)`$ then this $`O(\gamma)`$ term will not trouble us, as

$$
\langle\vartheta_1(p)f_1(q,p)\rangle=\pm\frac\beta2\langle(\gamma U(q)-c)\vartheta_1(p)\pm p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle =\pm\frac\beta2\langle p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle.
$$


> However, if we instead set $`\vartheta=\vartheta_2(q)`$, then

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

> When considering the limit of infinite friction in the $`[XYZ]`$ schemes we obtain an inconsistent discretization. Hence these first-order schemes will be unsuitable for the integration of overdamped Langevin dynamics.
> This is not always the case for first order schemes, however. For example the scheme denoted $`[AOAB]`$ is consistent with the dynamics, and may be used for integrating the overdamped ($`\gamma=\infty`$) Langevin equation.

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

> Let $`M=\beta=1`$ and define the biased double-well potential as

$$
U(q)=(q^2-1)^2+q/2.
$$


> We choose the observable

$$
\vartheta(q,p)=p^2-qU'(q)+2qp,\qquad\langle\vartheta\rangle=0.
$$


> The first order correction term for the $`[BOA]`$ scheme is given by the formula

$$
\langle\vartheta f_{1,[BOA]}\rangle=\frac\beta2\int_{\mathcal D}(p^2-qU'(q)+2qp)(pU'(q)+\gamma U(q)-c)\rho_\beta d\omega =\frac1\beta+\frac\gamma2\langle U\rangle-\frac{\gamma\beta}{2}\langle qUU'\rangle=\frac{2-\gamma}{2\beta}.
$$


> Hence for the critical value of $`\gamma=2`$, the leading order correction will be zero, giving

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

> Proposition 7.1 Let $`\mathcal L_X^\dagger`$, $`\mathcal L_Y^\dagger`$ and $`\mathcal L_Z^\dagger`$ be general operators to which BCH can be applied, then defining

$$
e^{h\widehat{\mathcal L}^\dagger}=e^{\frac h2\mathcal L_X^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{h\mathcal L_Z^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{\frac h2\mathcal L_X^\dagger},\tag{7.26}
$$


> gives $`\widehat{\mathcal L}^\dagger=\mathcal L_0^\dagger+h^2\mathcal L_2^\dagger+O(h^4)`$, where

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


> where each $`\langle f_i\rangle=0`$ as usual. Equating the second order terms we obtain

$$
\mathcal L_{LD}^\dagger(\rho_\beta f_2)=-\mathcal L_2^\dagger\rho_\beta.\tag{7.28}
$$


> The condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $`\mathcal L_2^\dagger\rho_\beta`$ integrates to zero.

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

> For methods $`[OYZYO]`$, substituting $`\mathcal L_X^\dagger=\mathcal L_O^\dagger`$, $`\mathcal L_Y^\dagger+\mathcal L_Z^\dagger=\mathcal L_A^\dagger+\mathcal L_B^\dagger=\mathcal L_H^\dagger`$ simplifies the computation to

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

