[上一部分](part10.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part12.zh-CN.md)

## MD-6.4.4-Theorem62

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Theorem 6.2 (Geometric Ergodicity) Let the solution to (6.43) be denoted $`X(t)`$. If Assumption 1 and Assumption 2 are satisfied for

$$
C=\{X\in D\mid\varphi(X)\le K_{\alpha,\delta}\},
$$


> where $`K_{\alpha,\delta}`$ is a particular positive value depending on $`\alpha`$ and $`\delta`$, then
> (i) there exists a unique invariant measure $`\rho_*`$, with $`\mathcal L^*\rho_*=0`$, and
> (ii) there exist positive constants $`\kappa`$ and $`\lambda`$ such that for all suitable functions $`f`$ with $`|f|\le\varphi`$,

$$
|e^{t\mathcal L}f(X_0)-\operatorname{Av}(f)|\le \kappa e^{-\lambda t}\varphi(X_0);\tag{6.48}
$$


> where $`\operatorname{Av}(f)=\int_D f(z)\rho_*(z)dz`$ is the spatial average.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem62 :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    (∀ (t : ℝ≥0) (x : D), Integrable φ (K t x) ∧
      MolecularDynamics.Chapter06Review.kernelAverage K φ t x ≤
        Real.exp (-α*(t : ℝ))*φ x+δ/α) →
    MolecularDynamics.Chapter06Review.assumption1 ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-Theorem62；改动：明示实际Markov/Feller演化、正确正时刻密度、generator联系和先于过程选择的阈值；整条仍未证明。 -/
theorem theorem62_corrected :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    (∀ (t : ℝ≥0) (x : D), Integrable φ (K t x) ∧
      MolecularDynamics.Chapter06Review.kernelAverage K φ t x ≤
        Real.exp (-α*(t : ℝ))*φ x+δ/α) →
    MolecularDynamics.Chapter06Review.assumption1 ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry

/-- 【原书疑误】采用印刷Assumption1的版本；技术量词仍显式保留，不证。 -/
theorem theorem62Printed :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    MolecularDynamics.Chapter06Review.assumption1Printed ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06\_ERRATA。
- 覆盖缺口：原Assumption 1(ii)在t=0要求连续密度的疑误保留；Printed含明确的实际生成元测试资格，并非无技术前提的整条字面翻译。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：节号、页码、阈值集合、唯一不变测度、弱平稳意图、加权指数界及空间平均均核对；原页的正系数为κ，JSON两处写为k，应作转录纠正，其余原文数学措辞保留。C：theorem62及corrected作为加强的半群版本，签名PASS：阈值函数先于状态空间、过程及φ量化；完整Markov/Feller、局部紧Polish状态、σ有限ν、每个正时刻全部初值的绝对连续性；φ正连续且子水平紧，α、δ正；另有实际积分可积性和半群漂移估计；结论保留全部不变概率的唯一性、相对于ν的密度、受真实右导数及局部可积差商支配限制的弱平稳检验，以及统一于所有可测|f|≤φ、t≥0、x的指数界。没有把不变性或收敛结论作假设，也没有把有限个检验或单一初态替代全部量词。Printed保留[0,∞)连续密度的原书疑误，这一点本身应NEEDS\_HUMAN；但其弱平稳分句量化所有有界连续f，仅假设kernelGenerator f可积，没有要求该f存在真实右导数/属于生成元测试域。D中kernelGenerator是总定义的derivWithin，不能把其无导数时的默认值当成原书实际SDE生成元。该超出原生成元域的Printed弱平稳断言不属于原书字面陈述，忠实性FAIL。主版新增的测试域保护没有在Printed中保留，这一偏差不是sorry问题，也不能全标成原书疑误。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem62` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem62_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem62Printed` | 未证 | 原书疑误不证 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:2636`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-PeriodicPotentialBound

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> We also consider the potential energy to be smooth ($`C^\infty`$) with $`U(q)\to\infty`$ as $`|q|\to\infty`$. As we have a smooth potential on a bounded (position) domain, we have

$$
1\lt U_{\min}\le U(q)\le U_{\max}\lt \infty,\quad\forall q\in\mathcal Q,
$$


> for some constants $`U_{\min}`$ and $`U_{\max}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem periodicPotentialBound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M := by
  apply MolecularDynamics.textbookUnitPeriodicPotential_bound <;> assumption

/-- 修正版，对应原文 MD-6.4.4-PeriodicPotentialBound；改动：保留周期势有界结论；正下界通过加常数归一单独实现。 -/
theorem periodicPotentialBound_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M := by
  apply MolecularDynamics.textbookUnitPeriodicPotential_bound <;> assumption

/-- 【原书疑误】光滑周期势本身不能推出印刷的严格正下界；不证。 -/
theorem periodicPotentialBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
    ContDiff ℝ ∞ U → textbookUnitPeriodicPotential U →
    ∃ Umin Umax : ℝ, 1 < Umin ∧ ∀ q, Umin ≤ U q ∧ U q ≤ Umax := by
  sorry

/-- 零势的下界不可能严格大于1。 -/
theorem periodicPotentialBoundPrinted_counterexample :
    ¬ (∃ Umin Umax : ℝ, 1 < Umin ∧ ∀ q : Fin 1 → ℝ,
      Umin ≤ (fun _ ↦ (0 : ℝ)) q ∧ (fun _ ↦ (0 : ℝ)) q ≤ Umax) := by
  rintro ⟨Umin,Umax,hmin,hbound⟩
  have hzero := (hbound 0).1
  dsimp only at hzero
  linarith
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整全域有限范数界，给上下界±M；正下界>1需实际势能平移，另条给出。原周期与q→∞围束资格冲突另留字面记录，不由本条消去。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。连续周期势全域有界的签名正确，M≥0的范数界给−M≤U≤M。它未包含原1<Umin；该要求由下一条平移解释而非本条证明。原文同时要求周期与配置无穷远围束，本条[ERRATUM?]正确保留。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicPotentialBound` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.periodicPotentialBound_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.periodicPotentialBoundPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |
| `MD.Ch06.periodicPotentialBoundPrinted_counterexample` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2735`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-PotentialNormalization

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> We also consider the potential energy to be smooth ($`C^\infty`$) with $`U(q)\to\infty`$ as $`|q|\to\infty`$. As we have a smooth potential on a bounded (position) domain, we have

$$
1\lt U_{\min}\le U(q)\le U_{\max}\lt \infty,\quad\forall q\in\mathcal Q,
$$


> for some constants $`U_{\min}`$ and $`U_{\max}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem potentialNormalization {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Continuous U) (hp : textbookUnitPeriodicPotential U) :
  ∃ c : ℝ, (∀ q, 1 < U q+c) ∧
    textbookPotentialForce (fun q ↦ U q+c)=textbookPotentialForce U := by
  obtain ⟨c,hc⟩ := textbookUnitPeriodicPotential_normalization U hU hp
  refine ⟨c+1, ?_, textbookPotentialForce_add_const U (c+1)⟩
  intro q
  linarith [hc q]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]将Umin>1解释为实际加常数归一；严格>1与真实力不变全部保留，而非直接假定任何原势已大于1。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在单一c使所有q严格U(q)+c>1，且真实fderiv所定义势能力作为函数相等。连续周期已足以给有限下界，导数总定义对加常数保持相同，故不需额外假设原势处处可微。此为[EXTRA]明确的归一解释。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.potentialNormalization` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2763`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-UnitLangevinModel

印刷p.251 / PDFp.272；§6.4.4。

### 1. 原文陈述

> In Langevin dynamics, taking $`M=I`$ for simplicity,

$$
dq=pdt;\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}dW;\tag{6.47}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def unitLangevinModel {n : ℕ} {A : Type*} [MeasurableSpace A] (P : Measure A)
    (W : ℝ → A → (Fin n → ℝ)) (X : ℝ → A → ((Fin n → ℝ) × (Fin n → ℝ)))
    (U : (Fin n → ℝ) → ℝ) (γ β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  0 < β ∧ ContDiff ℝ ∞ U ∧ MD.Ch06.langevinMassSDE P W X (fun _ ↦ 1) U γ β⁻¹ x0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实单位质量完整耦合路径方程；β>0及光滑势保证原梯度存在，γ>0由实际MassLangevin资格保留。Wiener law在对应定理另给，不宣称任意W是Wiener。

### 6. 审计结论（含网站结论）

网站原返回：PASS。展开langevinMassSDE后有正γ、正温度β⁻¹、单位质量、完整两分量积分方程、AE连续/可积资格以及textbookIsWienerVector。故σ=√(2γβ⁻¹)、dq=pdt均正确。元数据说Wiener law另给与实际定义不符，须纠正。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.unitLangevinModel` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2774`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-PeriodicConfiningPrinted

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> The whole phase space is $`D=\mathbb T^{N_c}\times\mathbb R^{N_c}`$. We also consider the potential energy to be smooth ($`C^\infty`$) with $`U(q)\to\infty`$ as $`|q|\to\infty`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def periodicConfiningPrinted {n : ℕ} (_hn : 0 < n) (U : (Fin n → ℝ) → ℝ) : Prop :=
  ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
    Tendsto U (cocompact (Fin n → ℝ)) atTop
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem periodicConfiningPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际正维单位周期lift，cocompact表达配置无穷远；不是动量Hamiltonian的围束。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed对正维欧氏lift同时要求C∞、整数平移周期、cocompact处趋∞，确实忠实表达原矛盾资格；hn排除零维真空情况。不应要求构造满足它的势。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicConfiningPrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:2783`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPower

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> For the Lyapunov condition (Assumption 2), we choose the Lyapunov function

$$
\varphi(q,p)=H^l(q,p)=\left[\tfrac12\|p\|^2+U(q)\right]^l;
$$


> for a fixed positive integer $`l`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def hamiltonianPower {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (_hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) : ℝ := textbookLangevinHamiltonian U z ^ l
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]l≥1编码，真实单位质量Hamiltonian，未把形式jet当真实函数；正性与柱形proper在后续实际桥接证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实相空间为两个Fin Nc→ℝ之积，Hamiltonian为坐标平方和/2+U；l:ℕ及1≤l表达固定正整数。定义只给候选函数，不断言它无条件满足全部Assumption2。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPower` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2789`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerCancellation

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> we can see that

$$
p\cdot\nabla_q\varphi-\nabla U(q)\cdot\nabla_p\varphi=\mathcal L_H\varphi=0;
$$


> where $`\mathcal L_H`$ is the Lie derivative of our original Hamiltonian system (which preserves all functions of the Hamiltonian).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerCancellation {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Differentiable ℝ U) (l : ℕ) (_hl : 1 ≤ l) (z : textbookLangevinPhase n) :
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
    (z+t • textbookLangevinDrift U 0 z)) 0 0 := by
  simpa using textbookLangevinHamiltonianPower_drift_hasDerivAt U hU (0 : ℝ) l z
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际沿Hamiltonian方向的真实导数为0；γ=0只在此Hamiltonian部分，非把整个物理Langevin摩擦设零。

### 6. 审计结论（含网站结论）

网站原返回：PASS。γ=0时真实drift=(p,−∇U)，HasDerivAt对直线z+t drift在t=0给导数0，正是Lie方向导数；不是声称直线轨道的Hamiltonian在所有t常值。全域Differentiable U足以给链式法则，l≥1。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerCancellation` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2794`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerMomentumDerivative

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> Using $`\|p\|^2\lt 2H`$, we compute derivatives to find

$$
p\cdot\nabla_p\varphi=lH^{l-1}\|p\|^2=2l\varphi-2lH^{l-1}U(q).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerMomentumDerivative : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (l : ℕ) (z : textbookLangevinPhase n), 1 ≤ l →
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z.1,(1+t) • z.2))
    ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2)) 0 ∧
  (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2) =
    2*(l : ℝ)*textbookLangevinHamiltonianPower U l z -
      2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1 := by
  intro n U l z hl
  let S : ℝ := ∑ i, z.2 i^2
  have he : ∀ t : ℝ, textbookLangevinHamiltonian U (z.1,(1+t) • z.2)=
      (1+t)^2*S/2+U z.1 := by
    intro t
    simp only [textbookLangevinHamiltonian, Pi.smul_apply, smul_eq_mul, mul_pow,
      ← Finset.mul_sum]
    rfl
  have hd : HasDerivAt (fun t : ℝ ↦ ((1+t)^2*S/2+U z.1)^l)
      ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S) 0 := by
    convert! (((((hasDerivAt_id (0 : ℝ)).const_add 1).pow 2).mul_const S).div_const 2 |>.add_const (U z.1)).pow l using 1 <;>
      simp [textbookLangevinHamiltonian, S] <;> ring
  constructor
  · simpa only [textbookLangevinHamiltonianPower, he] using hd
  · change (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S=
      2*(l : ℝ)*textbookLangevinHamiltonian U z^l-
        2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1
    rw [show textbookLangevinHamiltonian U z^l=
      textbookLangevinHamiltonian U z^(l-1)*textbookLangevinHamiltonian U z by
      rw [← pow_succ, Nat.sub_add_cancel hl]]
    dsimp [textbookLangevinHamiltonian, S]
    ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实沿动量p方向的导数及全部两个表达式，不仅登记事先给定的导数值；实际所有坐标平方和。

### 6. 审计结论（含网站结论）

网站原返回：PASS。动量曲线(1+t)p在t=0的切向量为p，HasDerivAt给实际p·∇p H^l；第二合取保留2lH^l−2lH^(l−1)U的完整恒等式。U仅在固定q取值，故动量导数不需U光滑，l=1及H=0亦成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerMomentumDerivative` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2802`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerMomentumLaplacian

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述


$$
\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerMomentumLaplacian {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) =
      (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (∑ i, z.2 i ^ 2) +
        (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian <;> assumption
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem laplacianBoundCorrect {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption

/-- 修正版，对应原文 MD-6.4.4-LaplacianBoundPrinted；改动：系数l(l+Nc−1)改为2l(l−1)+Nc·l。 -/
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原印刷等式及错误上界均保留。目标主声明只给精确等式；随包关联声明laplacianBoundPrinted和laplacianBoundCorrect分别作字面忠实性与修正正确性审校。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证精确Laplacian等式；原错误上界Printed与修正系数分别由MD-6.4.4-LaplacianBoundPrinted/LaplacianBoundCorrect保存，不能把等式视为已覆盖原印刷不等式。
- [ERRATUM?] 原上界缺少由‖p‖²<2H产生的因子2；正确的统一系数为2l(l−1)+Ncl。
- [EXTRA] 复审范围：精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。
- 覆盖缺口：Printed上界存在明确反例，不能被视为已成立；上界修正须人工认可。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：原页的动量Laplacian精确等式和上界系数l(l+Nc−1)均准确转录，应保留原错误系数作疑误。C分版本：hamiltonianPowerMomentumLaplacian为PASS；相空间两分量确为(q,p)，H=Σpᵢ²/2+U(q)，沿(0,eᵢ)作两次一元导数再求和，结论是完整精确等式。l为正自然数；l=1时(l−2)的自然数截断无害，因为前系数l(l−1)=0；对任意U也合理，因为只对动量微分。附带给出的laplacianBoundPrinted忠实保留原上界，但该不等式错误，应NEEDS\_HUMAN而非因数学错误将字面忠实版判FAIL。laplacianBoundCorrect的系数2l(l−1)+Ncl，在U≥1前提下是正确上界，签名PASS。JSON现称上界“不属于本条”，但本包又列出了两份上界声明；应明确它们是随包核对的关联声明，不能只审等式后声称原不等式已成立。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerMomentumLaplacian` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2834`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LaplacianBoundPrinted

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述


$$
\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem laplacianBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
  (∀ q, 1 ≤ U q) → ∀ (l : ℕ), 1 ≤ l → ∀ z : textbookLangevinPhase n,
    (∑ i : Fin n, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z+t • ((0 : Fin n → ℝ), Pi.single i 1)))) 0) ≤
      (l : ℝ)*((l : ℝ)+(n : ℝ)-1)*textbookLangevinHamiltonian U z^(l-1) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem laplacianBoundPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption
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

网站原返回：NEEDS\_HUMAN。原字面上界的量词n、U≥1、l≥1、全部相点及系数l(l+n−1)忠实；原数学断言错误，按要求保留而不把原书错误算作转录失败。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.laplacianBoundPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:2845`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LaplacianBoundCounterexample

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述


$$
\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem laplacianBoundCounterexample :
    deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 = 52 ∧
      ¬ deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 ≤
        (2 : ℝ) * (2 + 1 - 1) * (4 ^ 2 / 2 + 2) ^ (2 - 1 : ℕ) := by
  apply MolecularDynamics.textbookLangevinLyapunov_printed_laplacian_bound_counterexample <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]现成具体n=1、U=2、l=2、p=4反例52>40；仅差异证据，未用它替代原全量词界或完整Lyapunov论证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实一元二阶导数在p=4等于52，右侧40；n=1、U=2、l=2均由公式固定。[EXTRA]正确说明它仅是反例，不能替代全量词界。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.laplacianBoundCounterexample` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2854`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerGenerator

印刷p.253–254 / PDFp.274–275；§6.4.4。

### 1. 原文陈述

> Computing the generator of Langevin dynamics as

$$
\mathcal L_{LD}f=p\cdot\nabla_qf-\nabla U(q)\cdot\nabla_pf-\gamma p\cdot\nabla_pf+\gamma k_BT\Delta_p\varphi,
$$


> we can see that $`\mathcal L_H\varphi=0`$. Hence

$$
\mathcal L_{LD}\varphi=-\gamma p\cdot\nabla_p\varphi+\gamma k_BT\Delta_p\varphi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerGenerator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z =
      -γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2) +
        σ ^ 2 / 2 * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) *
          (∑ i, z.2 i ^ 2) + (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1)) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_differentialOperator <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际全坐标一二阶导数与完整H^l，现成通用σ算子取σ=√(2γkBT)使σ²/2=γkBT；不是给定目标导数再改写。物理热参数代入在下一完整Lyapunov桥接实际出现。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D1–D5给出真实H、H^l、力和全相空间方向导数算子；hU仅一阶可微已足够，动量二阶导数来自多项式。l=1时(l−1)系数为零，Nat截断l−2无误；σ²/2保留通用参数，物理代入已明确标注。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerGenerator` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2862`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LaplacianBoundCorrect

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述


$$
\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem laplacianBoundCorrect {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption

/-- 修正版，对应原文 MD-6.4.4-LaplacianBoundPrinted；改动：系数l(l+Nc−1)改为2l(l−1)+Nc·l。 -/
theorem laplacianBoundPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]修正上界系数为2l(l−1)+Nc l；原错误l(l+Nc−1)另列NEEDS，未静默更换JSON原句。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐坐标动量二阶导数总和，n与l全量词，U≥1确保H≥1。由∑p\_i²≤2H得正确系数2l(l−1)+nl；l=1也成立。[EXTRA]已明确这是勘误版。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.laplacianBoundCorrect` | 已证 | — | PASS |
| `MD.Ch06.laplacianBoundPrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2873`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LyapunovYoungBounds

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> As $`H^l`$ grows faster than $`H^{l-1}`$, for any fixed $`l`$ we are able to find positive constants $`c`$ and $`d`$ such that

$$
l(l+N_c-1)H^{l-1}\le\tfrac l2H^l+c;\qquad 2lH^{l-1}U(q)\lt 2lH^{l-1}U_{\max}\le\tfrac l2H^l+d.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lyapunovYoungBounds : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) := by
  intro l n Umax hl hU
  have hlpos : (0 : ℝ) < l := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hl)
  let A1 : ℝ := (l : ℝ)*((l : ℝ)+(n : ℝ)-1)
  let A2 : ℝ := 2*(l : ℝ)*Umax
  let A3 : ℝ := 2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l
  let A : ℝ := max 0 (max A1 (max A2 A3))
  let ε : ℝ := (l : ℝ)/2
  have hε : 0 < ε := by dsimp [ε]; positivity
  have hA : 0 ≤ A := le_max_left _ _
  let M : ℝ := max 1 (A/ε)
  have hM : 0 ≤ M := le_trans zero_le_one (le_max_left _ _)
  have hAM : A ≤ ε*M := by
    have hd : A/ε ≤ M := le_max_right _ _
    simpa only [mul_comm] using (div_le_iff₀ hε).mp hd
  let C : ℝ := A*M^(l-1)+1
  have hC : 0 < C := by dsimp [C]; positivity
  have hbound : ∀ H : ℝ, 1 ≤ H → A*H^(l-1) ≤ ε*H^l+C := by
    intro H hH
    have hH0 : 0 ≤ H := le_trans zero_le_one hH
    by_cases h : M ≤ H
    · have hAH := hAM.trans (mul_le_mul_of_nonneg_left h hε.le)
      calc
        _ ≤ (ε*H)*H^(l-1) := mul_le_mul_of_nonneg_right hAH (pow_nonneg hH0 _)
        _ = ε*(H^(l-1)*H) := by ring
        _ = ε*H^l := by rw [← pow_succ, Nat.sub_add_cancel hl]
        _ ≤ ε*H^l+C := le_add_of_nonneg_right hC.le
    · have hpow := pow_le_pow_left₀ hH0 (le_of_lt (lt_of_not_ge h)) (l-1)
      have hb := mul_le_mul_of_nonneg_left hpow hA
      have hp : 0 ≤ ε*H^l := mul_nonneg hε.le (pow_nonneg hH0 _)
      dsimp [C]
      linarith
  have h1 : A1 ≤ A := (le_max_left _ _).trans (le_max_right _ _)
  have h2 : A2 ≤ A := (le_max_left _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  have h3 : A3 ≤ A := (le_max_right _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  refine ⟨C,C,hC,hC,fun H hH ↦ ?_⟩
  have hp : 0 ≤ H^(l-1) := pow_nonneg (le_trans zero_le_one hH) _
  exact ⟨(mul_le_mul_of_nonneg_right h1 hp).trans (hbound H hH),
    (by simpa only [A2, mul_assoc, mul_left_comm, mul_comm] using (mul_le_mul_of_nonneg_right h2 hp).trans (hbound H hH)),
    (mul_le_mul_of_nonneg_right h3 hp).trans (hbound H hH)⟩

/-- 修正版，对应原文 MD-6.4.4-LyapunovYoungBounds；改动：采用非严格上界，并列原有效标量界和正确Laplacian系数所需界；若另选严格外上界才可写原严格号。 -/
theorem lyapunovYoungBounds_corrected :
  ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H → ∀ Uq : ℝ, Uq ≤ Umax →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Uq ≤ 2*(l : ℝ)*H^(l-1)*Umax) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) := by
  intro l n Umax hl hU
  obtain ⟨c,d,hc,hd,hbounds⟩ := lyapunovYoungBounds l n Umax hl hU
  refine ⟨c,d,hc,hd,?_⟩
  intro H hH Uq hUq
  have hH0 : 0 ≤ H := le_trans zero_le_one hH
  have hb := hbounds H hH
  exact ⟨hb.1,mul_le_mul_of_nonneg_left hUq (by positivity),hb.2.1,hb.2.2⟩

/-- 【原书疑误】保留印刷严格中间不等号，仅有Uq≤Umax时不证明此版。 -/
theorem lyapunovYoungBoundsPrinted : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H → ∀ Uq : ℝ, Uq ≤ Umax →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Uq < 2*(l : ℝ)*H^(l-1)*Umax) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) := by
  sorry

theorem lyapunovYoungBoundsPrinted_counterexample :
    ¬ (2*(1 : ℝ)*1^(1-1)*1 < 2*(1 : ℝ)*1^(1-1)*1) := by
  norm_num
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整同时覆盖原两个标量界与修正系数界，常数可依赖l/n/Umax但不依赖H；H≥1来自已归一物理势。原U(q)<Umax一环需选择严格外界，本条没有从≤假推出<。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量词顺序正确：c,d依赖l,n,Umax，独立于所有H≥1；正性、两条原有效非严格标量界及修正系数界同时覆盖。未编码U(q)的严格不等式，已在EXTRA/ERRATUM?说明是修正版；应保留该范围说明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lyapunovYoungBounds` | 已证 | — | PASS |
| `MD.Ch06.lyapunovYoungBounds_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.lyapunovYoungBoundsPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |
| `MD.Ch06.lyapunovYoungBoundsPrinted_counterexample` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2893`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinLyapunov

印刷p.253–254 / PDFp.274–275；§6.4.4。

### 1. 原文陈述

> giving

$$
\mathcal L_{LD}\varphi\le-2\gamma l\varphi+2\gamma lH^{l-1}U(q)+\gamma l(l+N_c-1)H^{l-1} \le-\gamma l\varphi+\gamma c+\gamma d \le-\alpha\varphi+\delta,
$$


> satisfying Assumption 2. The purpose of using the $`l`$ exponent in the Lyapunov function is to ensure that we can apply the theorem to a wide enough class of observables, as (6.48) is only valid for functions $`f`$ with magnitude less than or equal to the Lyapunov function.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinLyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption

/-- 修正版，对应原文 MD-6.4.4-PeriodicConfiningPrinted；改动：围束对象改为环面×动量空间上的Hamiltonian幂；无穷远只涉及动量方向。 -/
theorem periodicConfiningPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际单位质量周期模型、归一U≥1、γ/β>0及l≥1；完整正性/紧子水平集/无穷远proper/正δ全域线性恢复界，采用真实更正系数2。原证明计算的错系数仍按原句保留；不是整个Thm6.2或canonical invariance桥接。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际周期相空间、正γ和β、归一U≥1、l≥1、热系数恒等式、正性、全部子水平紧性、cocompact无穷远增长以及全域漂移界均完整。δ位于z之前；γl>0。结论为合理修正版，未声称证明原错误中间链。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinLyapunov` | 已证 | — | PASS |
| `MD.Ch06.periodicConfiningPrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2968`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LieBracket

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> The Lie bracket of a pair of vector fields $`u(z),v(z)`$ is another vector field

$$
[u,v]=v'u-u'v;
$$


> where $`u'`$ is the Jacobian matrix of the vector field $`u`$. In coordinates, if we let $`w=[u,v]`$, then the coordinates of $`w`$ are

$$
w_i=\sum_{j=1}^m\left(\frac{\partial v_i}{\partial z_j}u_j-\frac{\partial u_i}{\partial z_j}v_j\right).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def lieBracket {n : ℕ} (D : Set (Fin n → ℝ)) (_hD : IsOpen D)
    (u v : (Fin n → ℝ) → (Fin n → ℝ)) (_hu : ContDiffOn ℝ 1 u D)
    (_hv : ContDiffOn ℝ 1 v D) (x : D) : (Fin n → ℝ) :=
  MolecularDynamics.Chapter06Review.lieBracket u v x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Fréchet导数括号，具体性质/迭代均要求适当可微字段；其通用辅助函数的非可微总化值不作经典Jacobian解释。有限坐标式由真实fderiv在basis上取分量。
- [EXTRA]实际字段仅需原开域内C¹，输出点属于D，非可微/域外的总化fderiv值不作为经典Jacobian。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D36连接标准VectorField.lieBracket，符号为Dv·u−Du·v；D开、x∈D及域内C¹保证真实局部导数。坐标表达可由基展开得到，未把域外总化值作经典导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lieBracket` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3000`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

