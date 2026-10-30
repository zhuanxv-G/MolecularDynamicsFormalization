[上一部分](part08.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / 下一部分：无

## MD-7.13-UnderdampedPhasePrinted

印刷页 325 / PDF页 346。

### 1. 原文陈述

> We consider the case with $`\gamma\ll\Omega`$, allowing us to write $`\eta=i\widehat\eta`$ for $`\widehat\eta\in\mathbb R`$, and

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

> The oscillatory cosine term is bounded between $`\pm1`$, implying that we have stability for all step sizes provided the condition

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


> which gives a stability condition for all step sizes $`h`$ as long as

$$
\gamma\ge\Omega\sqrt{2-2\sqrt{1-\Omega^{-4}}}\ge\sqrt2/\Omega.
$$


> Therefore we expect that the minimum friction value required for stability for all timesteps $`h\gt 0`$, scales with the value of inverse $`\Omega`$.

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

> we often only wish to know the average of a given function $`\phi(q)`$ with respect the configurational density $`\exp(-\beta U(q))`$, where $`U`$ is the potential energy function of a molecular system.

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

