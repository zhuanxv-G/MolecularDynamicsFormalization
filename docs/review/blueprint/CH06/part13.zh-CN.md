[上一部分](part12.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / 下一部分：无

## MD-6.4.4-Proposition64Relative

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述


$$
\mathcal L_{LD}^{\dagger}\varphi=g
$$


> has a solution $`\varphi\in H^1(\mu)`$ which is unique up to addition of a constant multiple of the Gibbs density.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition64Relative :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-Proposition64Printed；改动：选择相对Gibbs密度坐标与真实加权伴随算子，核相应为常数；保留完整H¹解存在与唯一性目标。 -/
theorem proposition64Printed_corrected :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确相对Gibbs密度坐标，实际加权Hilbert闭算子adjoint图与完整H1、加权零均值、解存在/唯一模常数；与印刷flat-density Gibbs倍数版分列，非静默纠错。
- [EXTRA] 补H¹坐标伴随测试表达式与memLp规格；相对Gibbs密度采用闭Hilbert adjoint，唯一模常数，不是flat Gibbs倍数。
- [ERRATUM?] 原页为Gibbs density倍数，原文照录；本条Lean是相对Gibbs坐标下的明确修正版，因此唯一性改为模常数。原印刷坐标/域问题见Proposition64Printed。

### 6. 审计结论（含网站结论）

网站原返回：PASS。proposition64Relative：PASS；proposition64Printed\_corrected：PASS。二者都在归一Gibbs L²中使用实际Langevin后向算子的闭图伴随，对全部完整弱H¹且μβ零均值的g，断言存在H¹解，(value φ,value g)属于A.graph；对任意另一H¹解，差值μβ-AE为实常数。β、γ正、U光滑周期、噪声√(2γ/β)均保留，未把解空间缩成光滑或紧支函数。加权伴随作用于相对Gibbs密度r，flat密度为ρβr，所以核从Gibbs倍数变成常数是合理而明确的修正；Weighted H¹的导数测试及闭Hilbert图的算子表达式均已核对。这里认可修正版陈述与坐标选择，不认定其大型存在/正则性证明已完成。A阶段原印刷问题仍为NEEDS\_HUMAN，不静默改写原书。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition64Relative` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.proposition64Printed_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3285`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-FredholmAlternative

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> The condition is a consequence of the Fredholm Alternative which says that, for a linear operator $`A`$ with compact resolvent, we have one of the following two conditions:
> • $`A\varphi=g`$ has a solution.
> • There is a function $`y`$ with $`A^*y=0`$ and $`\langle y,g\rangle\ne0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fredholmAlternative :
  ∀ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [CompleteSpace E] (A : E →ₗ.[ℝ] E), Dense (A.domain : Set E) → IsClosed (A.graph : Set (E × E)) →
  (∃ R : E →L[ℝ] E, IsCompactOperator R ∧
    (∀ x, (R x, R x-x) ∈ A.graph) ∧
    ∀ x y, (y,y-x) ∈ A.graph → y=R x) →
  ∀ g : E, (∃ φ : E, (φ,g) ∈ A.graph) ↔ ∀ y : E, (y,0) ∈ A.adjoint.graph → ⟪y,g⟫_ℝ=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际稠密域闭Hilbert partialoperator图、actual adjoint以及shift1的完整紧resolvent（含逆的存在/唯一）；全部g可解当且仅当adjoint kernel正交，没有假设目标可解性。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实完备Hilbert空间、稠密定义域、闭图、紧R及(I−A)的存在与唯一性逆规格完整；固定实移位1是已明确的技术范围。对每个g，可解当且仅当与实际adjoint全部零模正交，等价于Fredholm二择一，不预设目标可解。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fredholmAlternative` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3324`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-BackwardKernelConstants

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> In our case, $`A=\mathcal L_{LD}^\dagger`$. The only solutions of $`\mathcal L_{LD}y=0`$ (conserved quantities of Langevin dynamics) are the constants.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem backwardKernelConstants :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ),
    (f,0) ∈ (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ, f x=c := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Gibbs加权Lp²闭backward operator图的全部粗域元素；不能用已证C0固定观测量特例替代。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有L²粗域元素f在实际闭backward图内且Af=0蕴含AE常数；域及正参数、周期光滑势正确，未把连续函数特例当全部粗域。该句“only”是必要性，当前签名未断言常数均入域，不影响所选文字。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.backwardKernelConstants` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3335`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ForwardKernelGibbs

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> If we have two solutions $`\varphi_1,\varphi_2`$ of $`\mathcal L_{LD}^\dagger\varphi=g`$, then their difference $`w`$ must be a solution of $`\mathcal L_{LD}^{\dagger}w=0`$ and the only such solution is a constant multiple of the Gibbs density $`\rho_\beta`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem forwardKernelGibbs : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ) (hβ : 0 < β),
  0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ w : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (textbookLangevinCanonicalWeakH1Value U hU hp β hβ w,0) ∈ A.graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ w x=c := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。
- [ERRATUM?] 原flat-forward核结论需自然算子域/可积性约束；当前Lean明确改为相对Gibbs闭Hilbert伴随，核为常数。原书文字保留。
- [EXTRA] 未提供\_counterexample声明，不能以“网站保留”作为形式验证证据。
- 覆盖缺口：本条只交付相对Gibbs修正版核结论，没有独立交付原flat坐标的两解差与Gibbs倍数核声明；原印刷Poisson命题在条目5保留，但不能据此称本条原核结论已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS限于EXTRA明确交付的相对Gibbs修正版。它保留所有光滑周期U、β>0、γ>0，对每个完整弱H¹零模w，在真实Langevin后向闭算子的Gibbs Hilbert伴随域内断言value(w)为常数。图成员资格不可省略，且这里没有使用旧flat紧支测试定义。这与r↦ρβr的密度转换一致，核陈述合理。原句的“两解差”可由伴随图线性化为此零模结论，但本条没有另外给出flat坐标的两解差等式；不能将常数直接说成原坐标的Gibbs密度倍数。EXTRA已经声明改动，故不当作静默纠错或签名FAIL；原书域/坐标问题在A阶段维持NEEDS\_HUMAN。本结论尚待证明与签名是否正确是两回事。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.forwardKernelGibbs` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3346`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedFunctionNorm

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述


$$
\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedFunctionNorm {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ‖f‖^2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Lp² AE类范数；Mathlib的eLpNorm定义为真实二阶积分，不把任意非可积函数的默认Bochner积分当范数。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weightedFunctionNorm命名易误读但实际返回‖f‖²，正好对应所引平方范数；f是canonical measure的实Lp² AE类，故标准L²积分等式适用，不包含不可积任意函数。β>0且真实Gibbs乘积测度明确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedFunctionNorm` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3358`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedVectorNorm

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> and, for a vector function $`w:D\to\mathbb R^{N_c}`$, we have

$$
\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedVectorNorm {n r : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (w : Fin r → Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ∑ i, ‖w i‖^2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整任意维度的所有真实L²分量，弱导数族使用同一实际Gibbs测度；不遗漏向量范数定义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。n为位置/动量坐标维数，r为向量分量数，二者独立且可任意有限；w各分量为同一真实canonical measure下的实L²等价类。返回值∑‖w i‖²恰为原公式的平方范数；并未开平方，故应按平方范数解释此名称。本条是定义而不是向量Lp范数等式定理。β>0保证动量高斯方差为正；U的平滑、周期及归一资格没有编码，因而只在原书Gibbs设置下解释为canonical probability。额外说明中的弱导数族在此声明中不存在，本条也无需弱导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedVectorNorm` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3363`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-KernelEvolution

印刷p.257 / PDFp.278；§6.4.5。

### 1. 原文陈述

> Given a collection of phase space points distributed according to the density $`\rho_0(q,p)`$, we know that its evolution (under Langevin dynamics) after a time $`t`$ will be described by

$$
\rho(q,p,t)=e^{t\mathcal L_{LD}^{\dagger}}\rho_0(q,p).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def kernelEvolutionRaw25 {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (t : ℝ≥0) : Measure D := K t ∘ₘ μ

def kernelEvolution {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (_hK : MolecularDynamics.Chapter06Review.markovSemigroup K) (t : ℝ≥0) : Measure D := K t ∘ₘ μ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：本source\_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 本source\_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。
- 覆盖缺口：特定Langevin核与前向密度半群的识别、ρt dω=Kt∘ₘ(ρ0 dω)及e^{tL†}解释未由本条给出。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A阶段APPROVED表示原文JSON与其“仅核推进”的限制说明真实。两个Lean辅助定义本身均正确：Raw25允许任意核族，主入口另要求真正Markov半群，D是任意可测类型，μ是任意测度，t≥0。即使μ未限定概率，该定义仍成立；仅在μ为概率时才得到概率推进。但原文完整结论是特定Langevin密度随前向指数算子演化。两个辅助体没有U、β、γ、ρ0、ρt、平直参考测度、生成元或密度等式。FAIL仅指该原文完整结论未由本条交付；EXTRA如实承认限制，不据此把缺失部分判成已经覆盖。条目10、13的资格定义另行审校，不能合并替代本条。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
本source\_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kernelEvolutionRaw25` | 定义 | — | PASS（仅辅助定义） |
| `MD.Ch06.kernelEvolution` | 定义 | — | PASS（仅辅助定义） |

位置：`Blueprint/Ch06.lean:3369`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-KernelAverage

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> which says that the average of a function $`\varphi`$ with respect to the distribution at time $`t`$ is equivalent to the average of the forward propagation of $`\varphi`$ with respect to the initial distribution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def kernelAverage {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (t : ℝ≥0) (x : D) : ℝ := ∫ z, f z ∂K t x

/-- 原句的两种平均相等：明确初始/演化分布及可积资格。 -/
theorem kernelAverage_distributionIdentity26 {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ0 μt : Measure D) (t : ℝ≥0) (f : D → ℝ)
    (hμ0 : IsProbabilityMeasure μ0) (hK : IsMarkovKernel (K t))
    (hμt : μt = K t ∘ₘ μ0) (hf : Measurable f) (hi : Integrable f μt) :
    (∫ x, f x ∂μt) = ∫ x, kernelAverage K f t x ∂μ0 := by
  subst μt
  letI : IsProbabilityMeasure μ0 := hμ0
  letI : IsMarkovKernel (K t) := hK
  unfold kernelAverage
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。该辅助定义正确且与EXTRA所称“总化记号”相符：D为任意可测空间、K为任意核族、f为任意实函数；Lean积分对不合格函数仍有总化值。因此本定义不能解释为任意f都有概率平均，更不能推出原句的∫f dμt=∫Kt f dμ0。原句要求分布演化、可积资格及核积分交换的等式，而这些对象和结论均未在当前声明中出现。FAIL为完整原句覆盖不足，非定义或证明错误。原文JSON没有伪称它已覆盖，故A状态APPROVED并保留既有coverage\_gaps。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kernelAverage` | 定义 | — | PASS（仅辅助定义） |
| `MD.Ch06.kernelAverage_distributionIdentity26` | 已证 | — | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3378`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-DensityEvolutionMeaning

印刷p.257–258 / PDFp.278–279；§6.4.5。

### 1. 原文陈述

> More precisely this relation should be interpreted in the variational sense, so that we have, for any suitable test function $`\varphi`$, e.g. $`\varphi\in C^\infty`$,

$$
\int_D\varphi\rho(q,p,t)d\omega=\int_D\varphi e^{t\mathcal L_{LD}^{\dagger}}\rho_0(q,p)d\omega.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def densityEvolutionMeaning {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ) (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (ρ0 : textbookLangevinPeriodicPhase n → ℝ) (ρ : ℝ≥0 → textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  langevinKernelQualification25 U β γ K ∧
  (∀ x, 0 ≤ ρ0 x) ∧ Integrable ρ0 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, ρ0 x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ x, ρ 0 x = ρ0 x) ∧
  ∀ t, (∫ x, ρ t x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
    (∀ x, 0 ≤ ρ t x) ∧ Integrable (ρ t) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
    MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ0 x))) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ t x)) ∧
    ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Integrable (fun x ↦ f x*ρ t x) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
      Integrable f (K t ∘ₘ ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity
        (fun x ↦ ENNReal.ofReal (ρ0 x)))) →
      (∫ x, f x*ρ t x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n) =
        ∫ x, f x ∂K t ∘ₘ ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity
          (fun x ↦ ENNReal.ofReal (ρ0 x)))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补Markov/初值/半群及真实右生成元识别资格，补各时刻概率质量和初值；逐点非负为所选代表，显式列可积测试的变分等式。此为语义资格定义，未声称密度存在或任意核满足它。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补Markov/初值/半群及真实右生成元识别资格，补各时刻概率质量和初值；逐点非负为所选代表，显式列可积测试的变分等式。此为语义资格定义，未声称密度存在或任意核满足它。

### 6. 审计结论（含网站结论）

网站原返回：PASS。这是对给定K、ρ0、ρ的语义资格定义，未声称任意K或任意输入都存在密度。位置与动量维数一致，t∈R≥0。langevinKernelQualification25包含真实表达式p·∇q-∇U·∇p-γp·∇p+(γ/β)Δp在0处的右导数条件，并包含Markov初值与组合律；它是明确的生成元资格，不是仅有Markov名称。密度均相对于flatPhaseMeasure；withDensity采用ofReal前已有逐点非负，不能以裁剪冒充负密度。ρ0和各ρt均为单位质量并可积，ρ(0)=ρ0逐点明确。最后对所有满足两侧明确Integrable条件的实测试函数给出积分等式，把原页模糊的suitable test function落实为可积范围，不声称所有C∞在非紧空间自动合格。没有构造指数算子或证明K唯一等于路径核；EXTRA已明确只交语义资格。这个定义的对象、条件和完整定义体正确。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.densityEvolutionMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3398`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-KernelDuality

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> This is of course an inner product, and due to the properties of the inner product, we may interpret the right hand side as

$$
\int_D\left[e^{t\mathcal L_{LD}}\varphi(q,p)\right]\rho_0(q,p)d\omega,
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem kernelDuality :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (t : ℝ≥0) (f : D → ℝ),
  IsProbabilityMeasure μ → IsMarkovKernel (K t) → Measurable f →
  Integrable f (MolecularDynamics.Chapter06Review.kernelEvolution K μ t) →
  (∫ x, f x ∂MolecularDynamics.Chapter06Review.kernelEvolution K μ t) = ∫ x, MolecularDynamics.Chapter06Review.kernelAverage K f t x ∂μ := by
  intro D _ K μ t f hμ hK hf hi
  letI : IsProbabilityMeasure μ := hμ
  letI : IsMarkovKernel (K t) := hK
  unfold MolecularDynamics.Chapter06Review.kernelEvolution MolecularDynamics.Chapter06Review.kernelAverage at *
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部实际可测可积检验、真实Markov kernel及初始概率measure；非仅Brownian谱模型配对。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对任意可测空间D、任意时刻t、初始概率μ、该时刻Markov核K t及可测实函数f，假设f对演化measure可积，结论恰是演化measure积分等于初始measure下的核平均积分。μ概率及K t Markov给出有限性，从总积分可积可获AE纤维可积，迭代积分有明确资格；无需所有时刻半群律即可证明该时刻对偶式。原文density×flat measure在此抽象为μ，泛化合理；本条未声称已把任意K识别为Langevin。所有量词、前提及等号方向与[EXTRA]一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kernelDuality` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3419`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-SmoothTestL2Printed

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> Since all the eigenvalues lie to the left of a vertical line in the left half plane, for any $`\varphi`$ in $`C^\infty`$ we have

$$
\int_D\varphi\rho(q,p,t)d\omega=\operatorname{Av}_\beta(\varphi)+\alpha e^{t\lambda_1}\int_D\varphi\rho^{(1)}d\omega.
$$


> The latter integral is bounded since both $`\varphi`$ and $`\rho^{(1)}`$ are in $`L^2`$, and since $`\operatorname{Re}(\lambda_1)\lt 0`$, we see that this converges exponentially to the desired average.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem smoothTestL2Printed : ∀ {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ),
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) →
  MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  sorry

/-- 修正版，对应原文 MD-6.4.5-SmoothTestL2Printed；改动：明确要求检验函数属于所选L²空间；给出正确检验函数域定义，不冒称所有C∞函数可积。 -/
def smoothTestL2Printed_corrected {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) ∧
    MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06\_ERRATA。
- 覆盖缺口：平均恒等式、ρ^(1)的L²资格及与测试函数配对的有界性没有在本条两声明中表达；未将这些内容标为已经形式化。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。分版审校：smoothTestL2Printed忠实地保留原页隐含的“每个光滑测试函数均在平直L²”子主张；该子主张的原书数学疑误判NEEDS\_HUMAN，而不因它为假就判Printed不忠实。smoothTestL2Printed\_corrected是正确的限定域定义C∞∩L²，修正合理，局部签名PASS；但它是def，不是有界积分定理。本条scope仍称覆盖所引原句及展示公式，coverage\_gaps却为null。实际两个声明都没有ρt、ρeq、ρ1、λ1、α、传播关系、平均恒等式或积分界，因此总audit为FAIL，理由是独立的完整结论覆盖缺口，而不是原书数学疑误或sorry。原文错误另在json\_review中保留NEEDS\_HUMAN。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.smoothTestL2Printed` | 未证 | 原书疑误不证 | 原文子主张忠实性PASS；原书数学NEEDS\_HUMAN |
| `MD.Ch06.smoothTestL2Printed_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3437`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-ComplexInitialDensity

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> For example, if we assume that $`\lambda_1,\rho^{(1)}`$ is some eigenvalue, eigenfunction pair with $`\operatorname{Re}(\lambda_1)\lt 0`$ and take the initial distribution to be

$$
\rho_0=\rho_{eq}+\alpha\rho^{(1)},
$$


> for $`\alpha\in\mathbb R`$, then we have

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def complexInitialDensity {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
def complexInitialDensity_corrected {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 只定义给定复L²候选ρeq、ρ1及实α的平衡候选与初始组合的概率资格；不单独编码本征对、Reλ<0或实际Gibbs识别，也不声称所有α合格。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确真实初始概率的实性/非负/积分1，原单复模式不自动是概率；保留复Lp空间与复本征值，未缩成实负λ玩具。复共轭成对构造可另建，但原单模式需这些资格。
- [EXTRA] 仅为给定复L²候选的概率资格辅助定义；本征关系、Reλ<0及平衡态识别须在使用处另列，单一非实模式须共轭配对后再查非负性，不能覆盖任意α的原句。
- [ERRATUM?] 原文取initial distribution需隐含实性、非负和单位质量的额外限制；不能把任意α或任意单一复模式当作概率。原句保留。
- 覆盖缺口：本条不含本征关系、Reλ<0与实际Gibbs平衡态识别；相关使用条件在ComplexEigenmodeDecay另列，不能据此称本定义包含这些条件。

### 6. 审计结论（含网站结论）

网站原返回：PASS。complexInitialDensity：作为EXTRA明确声明的概率资格辅助定义，PASS；complexInitialDensity\_corrected：同样PASS，且二者实为同体，不是一个已证另一个待证。它们要求ρeq及给定组合ρeq+αρ1各自AE实且非负，实部可积且积分1；这些是复L²候选代表概率密度所需的正确条件。不要求ρ1本身非负，亦不要求α≠0，均正确；α=0时没有从单位质量倒推ρ1零积分。定义里没有λ或A，也没有声称所有α合格、ρeq确为Gibbs或ρ1确为本征函数；这些必须由使用处如条目14另列。因此这是合理的显式限定，不是对原页任意α的无条件实现；A阶段仍须人工核定原文中“initial distribution”的隐含范围。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.complexInitialDensity` | 定义 | — | PASS |
| `MD.Ch06.complexInitialDensity_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3450`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-LangevinForwardSemigroupMeaning

印刷p.257–258 / PDFp.278–279；§6.4.5。

### 1. 原文陈述


$$
\rho(q,p,t)=e^{t\mathcal L_{LD}^{\dagger}}\rho_0(q,p).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def langevinForwardSemigroupMeaning {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ)
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (S : ℝ≥0 → Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →L[ℂ]
      Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) : Prop :=
  langevinKernelQualification25 U β γ K ∧
  S 0 = ContinuousLinearMap.id ℂ _ ∧
  (∀ s t, S (s+t) = (S s).comp (S t)) ∧
  (∀ v, Continuous (fun t ↦ S t v)) ∧
  ∀ v : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n),
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (v x).im=0 ∧ 0 ≤ (v x).re) →
    Integrable (fun x ↦ (v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
    ∀ t, (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      (S t v x).im=0 ∧ 0 ≤ (S t v x).re) ∧
      Integrable (fun x ↦ (S t v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
      MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (v x).re)) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal ((S t v x).re))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补C₀半群（初值/组合/强连续）、Markov核及实际Langevin右生成元联系；每个合格输入的输出AE实且非负并可积，排除(1+i)id和ofReal裁剪伪识别。此为资格定义，未证明存在。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补C₀半群（初值/组合/强连续）、Markov核及实际Langevin右生成元联系；每个合格输入的输出AE实且非负并可积，排除(1+i)id和ofReal裁剪伪识别。此为资格定义，未证明存在。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对给定U、β、γ、K、S定义资格，非存在定理。S t为复L²(flatPhaseMeasure)上的有界复线性算子，S0=id、组合律及对每个v的强连续性齐全。K满足β、γ正、U光滑周期、Markov半群及紧支光滑函数的0处真实Langevin右生成元资格。对每个AE实非负且L¹的v，定义要求所有t的S t v也AE实非负且L¹，并将输入、输出平直密度测度精确关联为Kt推进。输入不必质量1，因此包括全部非负可积L²密度；质量由Markov性质保留。这些条件排除了(1+i)id及ofReal裁剪假象；双线性/复线性与非负可积类的线性生成关系可延伸识别，不必错误地对所有复v使用非负withDensity。该定义没有直接写出S的全域生成元图等于L†或证明K等于某条路径核；交付范围是EXTRA声明的生成元和测度推进语义资格，本次不把资格或存在性视为已证。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinForwardSemigroupMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3473`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-ComplexEigenmodeDecay

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述


$$
\rho(q,p,t)=e^{t\mathcal L_{LD}^{\dagger}}\rho_0=e^{t\mathcal L_{LD}^{\dagger}}\rho_{eq}+\alpha e^{t\mathcal L_{LD}^{\dagger}}\rho^{(1)}=\rho_{eq}+\alpha e^{t\lambda_1}\rho^{(1)}.
$$



### 2. 原文证明

> The latter integral is bounded since both $`\varphi`$ and $`\rho^{(1)}`$ are in $`L^2`$, and since $`\operatorname{Re}(\lambda_1)\lt 0`$, we see that this converges exponentially to the desired average.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem complexEigenmodeDecay : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (β γ : ℝ)
    (hβ : 0 < β) (_hγ : 0 < γ), textbookIsWienerVector B P →
  let E := Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
  ∀ (S : ℝ≥0 → E →L[ℂ] E) (A : E →ₗ.[ℂ] E) (ρeq ρ1 : E) (α : ℝ) (ev : ℂ),
    langevinForwardSemigroupMeaning U β γ
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) S →
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      ρeq x=(textbookLangevinCanonicalDensity U β x : ℂ)) →
    S 0=ContinuousLinearMap.id ℂ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
    (∀ v, Continuous (fun t : ℝ≥0 ↦ S t v)) →
    (∀ v w, (v,w) ∈ A.graph → HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal v) w (Ici 0) 0) →
    (ρeq,0) ∈ A.graph → (ρ1,ev • ρ1) ∈ A.graph → ρ1 ≠ 0 → ev.re < 0 →
    complexInitialDensity ρeq ρ1 α →
    (∀ t : ℝ≥0, S t (ρeq+(α : ℂ) • ρ1)=ρeq+((α : ℂ)*Complex.exp ((t : ℂ)*ev)) • ρ1) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ=⟪f,ρeq⟫_ℂ+
        ((α : ℂ)*Complex.exp ((t : ℂ)*ev))*⟪f,ρ1⟫_ℂ) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ‖⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ-⟪f,ρeq⟫_ℂ‖ ≤
        |α| * ‖f‖*‖ρ1‖*Real.exp (ev.re*(t : ℝ))) ∧
    ∀ f : E, Tendsto (fun t : ℝ≥0 ↦ ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ)
      atTop (𝓝 ⟪f,ρeq⟫_ℂ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | statement\_latex只存演化展示式；proof\_discussion\_latex存不相邻的原页完整末句。二者之间的平均段落见SmoothTestL2Printed，不冒充连续引文。本条Lean结论含模式演化、全部L²测试的平均恒等式、指数界与极限。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 采用平直复L²空间、实α和完整复特征值ev，要求ev.re<0、非零本征向量及真实初始概率资格；不把所有α、所有单一非实模式视为概率扰动。
- [EXTRA] S以LangevinForwardSemigroupMeaning U β γ作用于本条真实周期Langevin路径核为前提；ρeq与归一Gibbs密度AE识别。资格已编码，实际半群存在及资格实现仍未视为已证。
- [EXTRA] 0处生成元图成员、驻定态和本征关系为前提；全时指数模式、平均恒等式、Cauchy–Schwarz界与极限全部为结论。测试对象精确为复L²，未沿用原书任意C∞的可积性推断。
- [ERRATUM?] 单个非实本征模式的初始概率资格及原页任意C∞的L²推断分别见ComplexInitialDensity和SmoothTestL2Printed；保留原书末句，不以该句证明本条。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS。对象为真实T^n×R^n周期Langevin核、平直复L²空间E、复C₀半群S及复部分线性算子A。U光滑单位周期、力全局Lipschitz、Wiener驱动、β、γ正及噪声√(2γ/β)均显式；ρeq与真实归一Gibbs密度AE相等，并有complexInitialDensity的概率资格，不是把任意复扰动当概率。S和真实核的关联是明确前提。生成元仅需A.graph中的(v,w)推出S轨道0处右导数为w；为两个指定图成员推出指数轨道已足够，不必额外假定A等于整个最大生成元。其驻定、本征条件保留完整复ev及ev.re<0，结论中的Complex.exp((t:ℂ)*ev)及|α|‖f‖‖ρ1‖exp(ev.re*t)符号、系数均正确。复内积对第二变量线性，故αexp(t ev)在右侧不取共轭；对应普通实测试平均时取实f即可。身份、组合、强连续在语义资格之外重复列出虽冗余但无误。若ev非实且仅用单一模式，要使初始密度实而α≠0通常不相容；该定理仍正确，因为概率资格显式且允许α=0，未声称任意非实模式存在非平凡概率扰动。原页任意C∞的可积性疑误已在条目11保留NEEDS\_HUMAN；本声明明确限定所有L²测试，未继承那个错误。本次只审校签名，未因sorry失败，也未把前向半群的存在与资格实现视为已证明。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.complexEigenmodeDecay` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3494`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## 公共辅助资格定义

以下共同定义由各条引用，计入定义数；定义本身不表示存在性或结论已经证明。

```lean
def naturalHistory25 {Ω V : Type*} [MeasurableSpace Ω] [MeasurableSpace V]
    (X : ℝ → Ω → V) (s : ℝ) : MeasurableSpace Ω :=
  ⨆ r : {r : ℝ // 0 ≤ r ∧ r ≤ s}, MeasurableSpace.comap (X r) inferInstance

/-- 25号：严格网格积分的充分资格；切片L²、有限和L²及局部均方Hölder控制。
不把积分公式或其所求极限作为假设。 -/
```

```lean
def gridItoQualification25 {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ Measurable (Function.uncurry g) ∧
  (∀ t : ℝ, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (g t)) ∧
  ∀ T : ℝ, 0 ≤ T →
    (∀ t ∈ Icc 0 T, MemLp (g t) 2 P) ∧
    (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
    ∃ C : ℝ, 0 ≤ C ∧ ∀ s ∈ Icc 0 T, ∀ t ∈ Icc 0 T,
      (∫ sample, (g s sample-g t sample)^2 ∂P) ≤ C*|s-t|

/-- 25号：共同向量自然过滤上的适应性与均方时间正则；不要求仅对单坐标历史适应。 -/
```

```lean
def vectorGridItoQualification25 {Ω : Type*} [MeasurableSpace Ω] {r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → (Fin r → ℝ)) (g : Fin r → ℝ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, Measurable (Function.uncurry (g j))) ∧
  (∀ j t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (g j t)) ∧
  ∀ j T, 0 ≤ T → (∀ t ∈ Icc 0 T, MemLp (g j t) 2 P) ∧
    (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum
      (fun s sample ↦ W s sample j) (g j) T K) 2 P) ∧
    ∃ C : ℝ, 0 ≤ C ∧ ∀ s ∈ Icc 0 T, ∀ t ∈ Icc 0 T,
      (∫ sample, (g j s sample-g j t sample)^2 ∂P) ≤ C*|s-t|

/-- 25号：Markov半群及紧支光滑测试的真实右生成元资格。
它是给定核与Langevin微分表达式的识别条件，不是任意核存在性定理。 -/
```

```lean
def langevinKernelQualification25 {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ)
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n)) : Prop :=
  0 < β ∧ 0 < γ ∧ ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
  MolecularDynamics.Chapter06Review.markovSemigroup K ∧
  ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) → HasCompactSupport f →
    ∀ x, HasDerivWithinAt
      (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
      (textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2*γ*β⁻¹)) f x) (Ici 0) 0
```

