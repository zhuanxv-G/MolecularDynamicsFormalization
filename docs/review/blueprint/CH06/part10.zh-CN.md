[上一部分](part09.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part11.zh-CN.md)

## MD-6.4.3-Theorem61

印刷p.250–251 / PDFp.271–272；§6.4.3。

### 1. 原文陈述

> Theorem 6.1 Define the generator of Brownian dynamics by

$$
\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.
$$


> Suppose that $`U`$ is smooth with periodic boundary conditions $`\mathcal Q=\mathbb T^{N_c}`$ ($`\mathbb T^{N_c}`$ an $`N_c`$-dimensional torus). Then, with respect to the space $`C_0^2(\mu_\beta)`$ with inner product $`\langle f,g\rangle_\beta`$ as defined above, we have:
> 1. $`\mathcal L`$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $`(-\infty,0]`$.
> 2. $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};
$$


> for some positive $`K`$ and $`\alpha`$, where recall $`\bar\varphi(t)`$ denotes the time average of $`\varphi`$ defined in (5.6).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem61 :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.4.3-Theorem61；改动：明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。 -/
theorem theorem61_corrected :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 【限定摘录，非原域字面版】保留严格负定及(5.6)轨道时间平均的疑误，但算子为闭Gibbs复L²实现；不把另列质量表达式当成本声明的算子，不证明此版。 -/
theorem theorem61ClosedRealizationExcerpt :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  (∀ f : (Fin n → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube n)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω), textbookIsWienerVector B P →
    ∀ x : UnitAddTorus (Fin n), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
      ∀ f : textbookPeriodicSmoothSpace n, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
        |t⁻¹*(∫ s in (0 : ℝ)..t,
            textbookConfigurationTorusObservable f
              (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hp β hβ x B s sample)) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K*‖textbookPeriodicSmoothEmbedding U hU hp β f‖*Real.exp (-α*t) := by
  sorry

/-- 【原书疑误】在ΔM=Σmi∂ii这一记号解释下的条件性代数表达；原页记号尚待核定，不宣称它是整个原定理或Brownian过程生成元。 -/
def brownianMassGeneratorPrinted {n : ℕ} (m : Fin n → ℝ) (U f : (Fin n → ℝ) → ℝ)
    (β : ℝ) (x : Fin n → ℝ) : ℝ :=
  ∑ i, (-(m i)⁻¹*fderiv ℝ U x (Pi.single i 1)*fderiv ℝ f x (Pi.single i 1)+
    β⁻¹*m i*fderiv ℝ (fun y ↦ fderiv ℝ f y (Pi.single i 1)) x (Pi.single i 1))

/-- 修正版，Brownian扩散使用逆质量权重；实际生成元的表达式定义。 -/
noncomputable def brownianMassGeneratorPrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06\_ERRATA。
- 覆盖缺口：原C₀²域及原ΔM生成元对应的整条字面形式化未提供；独立质量表达式不补足此联系。
- 覆盖缺口：严格负定与几乎处处轨道时间平均的固定指数界不作为成立结论。
- 覆盖缺口：本轮已目视核定印刷244/PDF265：ΔM=Σmi∂²/∂pi²。质量表达式注释中的“原页记号尚待核定”是复审时旧状态；核页不等于已建立原域/整条生成元联系。Theorem6.1的构型逆质量解释仍待导师。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：Theorem 6.1的生成元、三款结论及最后明确指向(5.6)的time average均准确转录；书中分布平均与轨道时间平均的冲突以及negative definite措辞须保留为原书疑误。C分版本：theorem61和theorem61\_corrected作为限定修正版均PASS，包含完整闭自伴、全部复谱实且非正、可数、每点有非零图特征向量、孤立、非零谱隙及对所有非负归一L²相对初始密度的演化分布平均指数界。K、α在ρ之后、在所有f和t之前选择，量词正确；DensityLaw为真实Brownian核作用初始ρμβ，DensityAverage的分母在这些概率条件下为1。修正生成元的扩散和漂移均用逆质量，匹配给出的实际Brownian路径系数。theorem61Printed的严格负定及几乎处处轨道平均指数界保留了原文疑误，但它仍使用与corrected相同的闭复L²算子，而原文明确以C₀²(μβ)为域；其全部谱/自伴断言也未与另列的brownianMassGeneratorPrinted建立对象联系。因此该名字为Printed的整条声明不是原域及原生成元的字面实现，忠实性FAIL；这与原书数学错误本身的NEEDS\_HUMAN及sorry无关。brownianMassGeneratorPrinted的代数表达与其注释一致，但附件没有印刷244页，无法据本附件独立确认ΔM在该页的既定含义，应保留记号歧义而不能假称已逐页核实。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem61` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem61_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem61ClosedRealizationExcerpt` | 未证 | 原书疑误不证 | 修复后未再送网站 |
| `MD.Ch06.brownianMassGeneratorPrinted` | 定义 | — | 修复后未再送网站 |
| `MD.Ch06.brownianMassGeneratorPrinted_corrected` | 定义 | — | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:2373`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-Theorem61TimeAveragePrinted

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> Theorem 6.1 Define the generator of Brownian dynamics by

$$
\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.
$$


> Suppose that $`U`$ is smooth with periodic boundary conditions $`\mathcal Q=\mathbb T^{N_c}`$ ($`\mathbb T^{N_c}`$ an $`N_c`$-dimensional torus). Then, with respect to the space $`C_0^2(\mu_\beta)`$ with inner product $`\langle f,g\rangle_\beta`$ as defined above, we have:
> 1. $`\mathcal L`$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $`(-\infty,0]`$.
> 2. $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};
$$


> for some positive $`K`$ and $`\alpha`$, where recall $`\bar\varphi(t)`$ denotes the time average of $`\varphi`$ defined in (5.6).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem61TimeAveragePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
  ∀ x : UnitAddTorus (Fin Nc), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
    ∀ f : textbookPeriodicSmoothSpace Nc, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
      |t⁻¹*(∫ s in (0 : ℝ)..t,
          textbookConfigurationTorusObservable f
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) -
        (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
          K*‖textbookPeriodicSmoothEmbedding U hU hPU β f‖*Real.exp (-α*t) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Brownian全时torus过程、任意点初值、AE路径资格和t>0明确；原C∞紧支检验在紧torus周期表示。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。按Printed规则核查：任意点初值、K,α先于f与AE样本、全部t>0的轨道时间积分，确为原末句时间平均读法的明确化。AE资格是额外选择；原文本身与前句分布平均冲突且该指数路径界一般错误。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem61TimeAveragePrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2476`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianEnsembleExponential

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianEnsembleExponential {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption

/-- 修正版，对应原文 MD-6.4.3-Theorem61TimeAveragePrinted；改动：选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。 -/
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]选择实际演化分布平均；真实Wiener/kernel和非负质量1的L²初始相对密度，所有光滑周期检验同时受界。范围限定不覆盖singular点初始law，不是原轨道时间平均证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Wiener驱动转移kernel推动非负质量1的L²相对密度；DensityAverage是总质量归一的演化分布平均，右侧Z⁻¹积分与torus Gibbs平均一致。K,α统一于所有光滑周期f与t≥0；归一范数与原范数的常数差可吸收进K。[EXTRA]明确非轨道平均及不含奇异初始law。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianEnsembleExponential` | 已证 | — | PASS |
| `MD.Ch06.theorem61TimeAveragePrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2492`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianNegativeDefinitePrinted

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianNegativeDefinitePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∀ f : (Fin Nc → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0 := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem brownianNegativeDefinitePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确严格负定含全部非零周期光滑L²函数的读法。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed严格负定版准确编码任意非零周期光滑f的二次型<0；虽为假，按原文字面版规则不以不忠实判FAIL。已有[ERRATUM?]正确。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianNegativeDefinitePrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:2531`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-OUDensityPrinted

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> The solution $`p(t)`$ to the Ornstein-Uhlenbeck equation, for any finite time $`t`$, is always normally distributed

$$
\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}
$$


> where

$$
\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-MolecularDynamics.Chapter06Review.ouMean γ x0 t)^2/(2*MolecularDynamics.Chapter06Review.ouVariance γ σ t))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]定义中使用通用噪声σ，取σ=√(2γkBTm)即6.45；t=0资格另记录。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Printed定义保留了原书未归一化指数。ouMean=exp(−γt)x0，ouVariance=σ\_noise²(1−exp(−2γt))/(2γ)；取σ\_noise²=2γkBTm就得到6.45。[EXTRA]已经说明参数转换。作为字面公式定义PASS，不把原书缺归一化或t=0问题算成该字面定义的签名错误。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouDensityPrinted` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2542`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-OUDensityCorrect

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> The solution $`p(t)`$ to the Ornstein-Uhlenbeck equation, for any finite time $`t`$, is always normally distributed

$$
\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}
$$


> where

$$
\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)

/-- 修正版，对应原文 MD-6.4.2-OUDensityPrinted；改动：增加(2πσ²(t))⁻¹/²，并限γ>0、噪声非零、t>0的密度解释。 -/
def ouDensityPrinted_corrected (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]补归一化系数，正γ/温度/质量且t>0使用；仅实际密度公式定义，原OU严格law结论在§6.3.2保留，不计密度积分或过程law已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouDensity与ouDensityPrinted\_corrected均用完整指数除以sqrt(2πv)，修正合理。γ>0、σ\_noise≠0、t>0时v>0，得到通常正态密度；注释明确密度解释只在这一域成立。定义对全部实数全定义不意味着声称退化参数下也是密度；没有积分归一化或过程HasLaw定理可被误计为已证。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouDensity` | 定义 | — | PASS |
| `MD.Ch06.ouDensityPrinted_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2547`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption1Printed

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $`C\in\mathcal B(D)`$, the conditions:
> (i) For some $`y\in\operatorname{int}(C)`$, we have that for any $`\delta\gt 0`$ there is a $`t_0\gt 0`$ such that

$$
\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)\gt 0,\quad\forall X_0\in C.
$$


> (ii) For $`t\gt 0`$, the transition kernel possesses a density $`\widehat\rho(X,z,t)`$ such that

$$
\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);
$$


> and $`\widehat\rho(X,z,t)`$ is jointly continuous in $`C\times C\times[0,\infty)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption1Printed {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ici 0)
```

同问题的独立限定/修正版（位于另一条）：
```lean
def assumption1Printed_corrected {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Borel Markov kernel与局部参考测度；完整同一内点可达、全部初值与可测子集及联合连续资格。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed保留紧C、同一内点y、δ后选统一t、全部x和可测A⊆C及联合连续时间Ici 0；与原[0,∞)一致。ν是披露的参考测度推广，但Kernel本身不含Markov/半群资格；此定义只编码局部条件。原零时连续性疑误保留。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption1Printed` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2558`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption1Correct

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $`C\in\mathcal B(D)`$, the conditions:
> (i) For some $`y\in\operatorname{int}(C)`$, we have that for any $`\delta\gt 0`$ there is a $`t_0\gt 0`$ such that

$$
\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)\gt 0,\quad\forall X_0\in C.
$$


> (ii) For $`t\gt 0`$, the transition kernel possesses a density $`\widehat\rho(X,z,t)`$ such that

$$
\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);
$$


> and $`\widehat\rho(X,z,t)`$ is jointly continuous in $`C\times C\times[0,\infty)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption1 {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)

/-- 修正版，对应原文 MD-6.4.4-Assumption1Printed；改动：联合连续性的时间域由[0,∞)改为(0,∞)。 -/
def assumption1Printed_corrected {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]联合连续域改为C×C×(0,∞)，正时刻实际密度与全部可达资格保留；只定义修正版，未计任何具体SDE已满足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。assumption1与assumption1Printed\_corrected两定义一致，唯一实质修正为Ici 0→Ioi 0；密度公式仍仅正时、x∈C及可测A⊆C，内点可达量词未变。作为修正条件定义合理，不是具体SDE满足它的断言。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption1` | 定义 | — | PASS |
| `MD.Ch06.assumption1Printed_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2569`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption2

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 2 There is a function $`\varphi:D\to(0,\infty)`$, with $`\varphi(X)\to\infty`$ as $`|X|\to\infty`$ such that

$$
\mathcal L\varphi\le-\alpha\varphi+\delta
$$


> for positive constants $`\alpha`$ and $`\delta`$, where $`\mathcal L`$ is the generator of the stochastic process (6.43). The function $`\varphi`$ is known as a Lyapunov function.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption2 {D : Type*} [TopologicalSpace D] (L : (D → ℝ) → D → ℝ)
    (φ : D → ℝ) (α δ : ℝ) : Prop :=
  (∀ x, 0 < φ x) ∧ Continuous φ ∧ (∀ R : ℝ, IsCompact {x | φ x ≤ R}) ∧
    0 < α ∧ 0 < δ ∧ ∀ x, L φ x ≤ -α*φ x+δ
local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]柱形相空间以真实compact sublevels表达趋无穷；连续正Lyapunov及正α/δ，未把Harris结论藏进定义。具体generator域资格在对应命题明确。

### 6. 审计结论（含网站结论）

网站原返回：PASS。φ处处严格正、连续、所有实数水平的次水平集紧，α,δ>0及逐点漂移不等式完整。在欧氏/torus×欧氏常用状态空间上，这是披露的proper Lyapunov解释；一般拓扑上仅是所选推广。L的域资格未由该定义提供。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption2` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2590`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-MinorizationPrinted

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem minorizationPrinted : ∀ {S : Type*} [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (ν : Measure S) (K : ℝ≥0 → Kernel S S) (C : Set S),
  MolecularDynamics.Chapter06Review.assumption1Printed ν K C ↔
    ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure S,
      IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem minorizationPrinted_corrected :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
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

网站原返回：NEEDS\_HUMAN。Printed将tantamount忠实读为↔，右侧给一个正时刻、正ENNReal下界系数和同一概率μ，对全部x∈C作完整测度序下界。左侧仍为原零时连续版；抽象签名没有SDE或Markov半群假设，等价一般错误。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.minorizationPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:2599`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-MinorizationCorrectedImplication

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem minorizationCorrectedImplication :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-MinorizationPrinted；改动：只保留在明确正时刻密度、可达性条件下到小集下界的充分方向。 -/
theorem minorizationPrinted_corrected :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 只覆盖加强假设下由Assumption 1到共同小集下界的充分方向；不覆盖原tantamount所可能表示的必要方向。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 主版与minorizationPrinted\_corrected同时补Chapman–Kolmogorov/Markov半群及参考测度全支撑。两步核局部共同下界仍需大型小集理论，未证明、未宣称数学结论已核定；审阅结论按各版本分别记录。
- [EXTRA] 还独立假设：对所有t>0、所有x及所有非空开集A，K t x A>0；这比原Assumption 1(i)强，不能省略于假设说明。
- [EXTRA] assumption1中的密度联合连续性只在t>0要求；原书写到t=0的端点问题另见条目10、14。
- [EXTRA] 复审范围：仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
- 覆盖缺口：未声明或认证minorization反推原Assumption 1的必要方向。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：关于“tantamount”及small sets的两句原文准确。C：两份声明签名相同，作为明确加强前提的充分方向均PASS。逐项包含实际概率核半群/Chapman–Kolmogorov、参考测度对所有非空开集为正、紧C及其内点可达条件、仅正时刻在C×C上联合连续的实非负密度；此外还另行假设所有点、所有正时刻对每个非空开集都有正概率。这一全局开放集可达性是实质性加强，不能由原Assumption 1(i)的固定内点可达性直接冒充。结论的时间、ε>0及概率μ先于所有x∈C选择，测度序ε•μ≤K t x正是共同小集下界；ε不必额外假设≤1，因为K t x和μ为概率。连续局部密度、紧性和真实核合成足以支持此加强版的共同下界；未以sorry是否消除作为签名判据。这里只认证充分方向，未把原文“tantamount”解读为已经认证了必要方向。JSON须补记遗漏的全局可达前提。
当前处理：网站PASS（复审）。
仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.minorizationCorrectedImplication` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.minorizationPrinted_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2608`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

