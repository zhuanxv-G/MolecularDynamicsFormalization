[上一部分](part04.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

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

## MD-6.4.4-LieBracketProperties

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> The Lie bracket is a bilinear and skew-symmetric operation:
> • $`[\alpha u+\beta v,w]=\alpha[u,w]+\beta[v,w]`$,
> • $`[u,v]=-[v,u]`$ and $`[u,u]=0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lieBracketProperties : ∀ {n : ℕ} (u v w : (Fin n → ℝ) → (Fin n → ℝ)) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (MolecularDynamics.Chapter06Review.lieBracket (fun x ↦ a • u x+b • v x) w =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u w x+b • MolecularDynamics.Chapter06Review.lieBracket v w x) ∧
  (MolecularDynamics.Chapter06Review.lieBracket u (fun x ↦ a • v x+b • w x) =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u v x+b • MolecularDynamics.Chapter06Review.lieBracket u w x) ∧
  MolecularDynamics.Chapter06Review.lieBracket u v = -MolecularDynamics.Chapter06Review.lieBracket v u ∧
  MolecularDynamics.Chapter06Review.lieBracket u u=0 := by
  intro n u v w a b hu hv hw
  have hb : ∀ (u v : (Fin n → ℝ) → (Fin n → ℝ)),
      MolecularDynamics.Chapter06Review.lieBracket u v=VectorField.lieBracket ℝ u v :=
    fun u v ↦ rfl
  simp_rw [hb]
  refine ⟨?_,?_,?_,?_⟩
  · funext x
    change VectorField.lieBracket ℝ (a • u+b • v) w x = _
    rw [VectorField.lieBracket_add_left ((hu x).const_smul a) ((hv x).const_smul b),
      VectorField.lieBracket_const_smul_left (hu x),
      VectorField.lieBracket_const_smul_left (hv x)]
  · funext x
    change VectorField.lieBracket ℝ u (a • v+b • w) x = _
    rw [VectorField.lieBracket_add_right ((hv x).const_smul a) ((hw x).const_smul b),
      VectorField.lieBracket_const_smul_right (hv x),
      VectorField.lieBracket_const_smul_right (hw x)]
  · funext x
    exact VectorField.lieBracket_swap
  · exact VectorField.lieBracket_self
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部双槽线性、skew及自身零明确，真实全域可微资格；不只保存某一固定字段或单槽例子。

### 6. 审计结论（含网站结论）

网站原返回：PASS。两槽所有实线性组合、反对称、自括号零同时给出，字段全局可微确保导数线性；全局版本为已标注技术范围。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lieBracketProperties` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3007`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Definition61

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> Definition 6.1 (Hörmander's Condition) Let $`U\subset\mathbb R^m`$ be open. The SDE (6.43) with $`C^\infty`$ vector fields $`b_0,b_1,\ldots,b_r:U\to\mathbb R^m`$ are said to satisfy Hörmander's condition at $`z\in U`$ if the vector space spanned by the collection of iterated Lie brackets

$$
b_0,b_1,\ldots,b_r,[b_0,b_1],[b_0,b_2],\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\ldots
$$


> (evaluated at $`z`$) is $`\mathbb R^m`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def definition61 {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x

/-- 修正版，对应原文 MD-6.4.4-Definition61；改动：用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。 -/
def parabolicNoiseBracketLevels {m S : ℕ}
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) : ℕ → Set ((Fin m → ℝ) → (Fin m → ℝ))
  | 0 => Set.range (fun i : Fin S ↦ b i.succ)
  | k+1 => parabolicNoiseBracketLevels b k ∪
      {w | ∃ u ∈ parabolicNoiseBracketLevels b k, ∃ i : Fin (S+1),
        w=MolecularDynamics.Chapter06Review.lieBracket (b i) u}

def definition61_corrected {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧
    Submodule.span ℝ {v | ∃ k : ℕ, ∃ w ∈ parabolicNoiseBracketLevels b k, v=w x}=⊤

/-- 【原书疑误】保留原含漂移的张成条件，不能据此推出一般转移密度。 -/
def definition61Printed {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]Fin(S+1)完整包含原drift b0与全部噪声，实际无限次括号及实span；明确C∞字段资格。保留原定义含b0，不冒充一般parabolic噪声生成条件；具体Langevin rank另证。
- [EXTRA]原开域U和域内点完整保留；坐标字段全空间任意总化只用于函数表示，C∞仅要求在原开域，不要求全局光滑延拓。开域内真实fderiv/全部迭代括号是局部对象。
- [EXTRA] 补textbookIteratedBracket定义体；原含漂移版仅为原书括号秩定义，密度用途必须用噪声起始的抛物型修正版。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：Definition 6.1的开域、光滑向量场、域内点、包括b0的迭代括号及实线性张成等于ℝm均准确转录，省略号保持同一完整有限生成族。C：definition61与Printed逐项保留开域D、x∈D、所有Fin(S+1)字段在D上C∞以及包括漂移b0的全部迭代Lie括号；D95不是有限深度截断，D96–D97在x处取实span=⊤。全空间总化函数只用于表示局部字段，D开且光滑性只要求ContDiffOn D，因此不要求原书没有的全局光滑延拓。Bracket符号与原文v′u−u′v一致。corrected的第0层只用b1,…,bS，后续允许与任一bᵢ取括号再取并，最后量化所有自然数层并取实span，正确区分用于正时刻密度的抛物型条件。原定义包含漂移作为一个数学定义本身并不矛盾；不能据此对一般SDE断言转移密度，而本条也没有这样的定理结论。四个定义的角色及[EXTRA]一致。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.definition61` | 定义 | — | PASS |
| `MD.Ch06.parabolicNoiseBracketLevels` | 定义 | — | PASS |
| `MD.Ch06.definition61_corrected` | 定义 | — | PASS |
| `MD.Ch06.definition61Printed` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3040`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinFields

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> In the case of Langevin dynamics, we identify the vectors $`b_i`$ in (6.43) with the terms in (6.47). One puts Langevin dynamics into the correct form by using

$$
b_0=\begin{bmatrix}p\\-\nabla U(q)-\gamma p\end{bmatrix},\qquad b_i=\sigma\begin{bmatrix}0\\e_i\end{bmatrix},\quad i=1,2,\ldots,N_c,
$$


> where $`e_i`$ is the $`i`$th Euclidean basis vector in $`\mathbb R^{N_c}`$ and $`\sigma=\sqrt{2\gamma k_BT}`$ is constant.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def langevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) (_hU : ContDiff ℝ ∞ U) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

def langevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际全部2Nc相空间坐标的真实drift/noise，C∞势资格编码，通用σ在物理定理取√(2γkBT)；不把noise定义计作独立Wiener law或密度存在证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Drift为(p,−∇U−γp)，Noise为(0,σe\_i)，Fin Nc覆盖全部坐标。C∞资格和通用σ/物理代入均已说明；噪声定义自身不是Wiener定律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinDrift` | 定义 | — | PASS |
| `MD.Ch06.langevinNoise` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:3064`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinNoiseBracket

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> For $`i=1,2,\ldots,N_c`$, we have, using the fact that $`b_i`$ is a constant vector field and so its Jacobian matrix vanishes,

$$
[b_0,b_i]=-\begin{bmatrix}0&I\\-U''(q)&-\gamma I\end{bmatrix}b_i =-\sigma\begin{bmatrix}e_i\\-\gamma e_i\end{bmatrix}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinNoiseBracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) := by
  apply MolecularDynamics.textbookLangevinDrift_noise_bracket <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C²势的Fréchet Jacobian、全部噪声坐标；σ任意，非零条件在独立性条明确。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C²势足以使力可微；常字段导数为零，−Db0·bi=(−σe\_i,σγe\_i)，与原符号和全部i,z吻合；σ=0也允许本恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinNoiseBracket` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3073`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinBracketIndependent

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> As these $`N_c`$ vectors, taken together with the original $`b_i`$, clearly provide a linearly independent set of $`2N_c`$ vectors,

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinBracketIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ) := by
  apply MolecularDynamics.textbookLangevinBracketFamily_linearIndependent <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Fin Nc⊕Fin Nc的全部2Nc向量族、σ≠0；不以维数计数代替独立性。

### 6. 审计结论（含网站结论）

网站原返回：PASS。族定义Sum.elim分别为全部噪声及全部括号，Fin Nc⊕Fin Nc恰有2Nc个向量；σ≠0保证位置块再动量块消元独立，n=0为空族也正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinBracketIndependent` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3082`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinHormander

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> we have verified Hörmander’s condition. Thus Assumption 1(ii) holds in the case of Langevin dynamics.

### 2. 原文证明

> 原书在结论前给出漂移、噪声、Lie括号计算及线性无关论证；本条仅摘录最后的结论句。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinHormander {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z := by
  apply MolecularDynamics.textbookLangevin_hormander_physicalNoise <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Lean仅覆盖实际Langevin向量场的原书括号秩条件；转移密度由条目14的正时刻修正版承接。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整物理σ=√(2γθ)、γ/θ>0、C∞ U的实际噪声及括号span；本桥只证rank，转移密度存在另条未证。
- [EXTRA] scope仅实际Langevin向量场括号rank；密度结论由LangevinTransitionDensity承接，补全部迭代括号定义。
- [ERRATUM?] 原Assumption 1(ii)中的零时刻端点不能由此rank核验推出；仅正时刻密度可由相应抛物型条件讨论。
- [EXTRA] 复审范围：原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。
- 覆盖缺口：本条rank签名不包含密度存在或连续性。
- 覆盖缺口：原Assumption 1(ii)包含t=0的端点仍需人工处理。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：所引两句与原页相符；原页在此前已明确计算漂移、噪声及第一层括号并说明2Nc个向量线性无关，proof\_note不应让人误以为没有这段论证。C：rank声明自身PASS：状态为实配置×实动量，漂移(p,−∇U−γp)，噪声(0,σeᵢ)，σ=√(2γθ)且γ、θ正；给出每个z处的全部迭代括号span=整个相空间。Nc=0时是零维的无害情形。D95–D97以及实际seed均已展开，不是把rank结论当作假设。签名只给含漂移种子族的原书秩条件，没有直接给出转移密度或Assumption 1(ii)的联合连续性；这种拆分在EXTRA已有说明，需同步修正statement\_scope和coverage\_gaps。引文后半句的原Assumption 1(ii)实际写到t=0，正时刻密度即使正确，也不能自动覆盖这个端点，故原书层面的合并断言仍NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinHormander` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3089`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinTransitionDensity

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Thus Assumption 1(ii) holds in the case of Langevin dynamics.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinTransitionDensity :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原引文保留；Lean覆盖实际周期单位质量Langevin核在t>0的联合连续转移密度及全部可测集合表示。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]具体实际单位周期Langevin、C∞势、正γ/β，全部点初值的正时间连续转移密度及真实平坦相空间测度表示；没有从含drift的任意原Definition6.1断言一般parabolic密度定理。
- [EXTRA] 补actual\_path\_solution\_exists完整存在类型及所选解满足初值/积分方程的规格；不把缺摘录误记原书问题。
- [ERRATUM?] 原Assumption 1(ii)的[0,∞)应就转移密度连续性改为(0,∞)；点初值在零时刻是Dirac测度。
- [EXTRA] 复审范围：网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。
- 覆盖缺口：原Assumption 1(ii)在t=0的联合连续端点不成立/未按原文形式化，须勘误签核。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：所引“Thus Assumption 1(ii) holds in the case of Langevin dynamics.”原句准确；须连同其所引用的Assumption 1(ii)核对，不能只看该短句。C：当前正时刻限定签名PASS：真实周期单位质量Langevin端点核、C∞周期势和Lipschitz力、β和γ正、物理幅度√(2γ/β)、真实Wiener过程。D17、D19–D23及D28–D31说明是实际积分解的推前核；flatPhaseMeasure为真实平坦相空间测度。ρ先于所有t>0、x、可测A选择，在(x,z,t)联合变量上ContinuousOn(univ×(0,∞))，并给出全部可测集合上的限制积分表示；这是全密度结论，不是仅有限检验函数相等，也未把密度存在当作假设。原书Assumption 1(ii)却要求C×C×[0,∞)联合连续，当前声明有意改成t>0。该修改合理且必要，但应明标[ERRATUM?]并由人工认可；它不是原Assumption 1(ii)端点的完整忠实实现。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinTransitionDensity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3098`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Lemma61Printed

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Lemma 6.1 For all $`t\gt 0`$ and all open $`C\subset D`$, we have that

$$
\Pr(X(t)\in C\mid X(0)=X_0)\gt 0,\quad\forall X_0\in D,
$$


> where $`X(t)=(q(t),p(t))^T`$ is a solution to Langevin dynamics (6.47).

### 2. 原文证明

> 原书给出证明论述；本条仅摘录命题，相关论述见相邻原页，未在此补写。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lemma61Printed {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ θ : ℝ) (hγ : 0 < γ) (hθ : 0 < θ)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*θ)) T x C := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06\_ERRATA。
- 覆盖缺口：原书漏非空目标；Printed忠实保留空集漏洞。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：Lemma 6.1的标题、所有t>0、所有开集、全部点初值及原式准确；kind应为编号lemma而不是unnumbered\_claim。C：缺少C.Nonempty忠实保留了原文的空集漏洞，这个数学错误应NEEDS\_HUMAN，不能仅因此判Printed签名FAIL。实际端点核的定义、时间正性、全部点初值及周期单位质量相空间均已核对。不过原页把过程指定为(6.47)，其γ为正且噪声为√(2γkBT)；当前Printed却量化任意实γ和任意非零实σ，额外覆盖γ≤0及不满足物理噪声关系的过程。它们可用于有限时刻开放集可达性的正确推广，但该推广没有在本条EXTRA中完整披露，也不是(6.47)的字面参数域。按Printed必须审忠实性的要求，本条因参数域扩张FAIL；原书空集错误仍独立标NEEDS\_HUMAN。此结论不依据sorry。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lemma61Printed` | 未证 | 原书疑误不证 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3117`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Lemma61Nonempty

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述


$$
\Pr(X(t)\in C\mid X(0)=X_0)\gt 0,\quad\forall X_0\in D,
$$



### 2. 原文证明

> 原书给出Lemma 6.1的Proof论述；本条只摘录展示式，未重录证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lemma61Nonempty {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption

/-- 修正版，对应原文 MD-6.4.4-Lemma61Printed；改动：增加目标开集非空；保留任意点初值、任意t>0的实际核正概率。 -/
theorem lemma61Printed_corrected {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原展示式保持原文；两份Lean声明均为增加目标非空条件、并将γ及σ参数推广后的实际周期单位质量核正概率命题。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]补非空目标；桥接实际单位周期相空间、原单位质量、真实Wiener/实际完整Langevin核，σ≠0。原一般质量扩大版不计已证。
- [EXTRA] 补所选解存在规格；目标开集非空修正保持。
- [EXTRA] γ可为任意实数，σ可为任意非零实数，是有限正时刻支持性质的推广；原物理(6.47)为其中的特例。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：该展示式来自同一Lemma 6.1；原页展示式以逗号承接where句，JSON改成句号，已还原。公式单独摘录时需补上原来的t>0、开集C、Langevin解及任意初值的上下文。原页下面有Proof段，当前proof\_note应说明仅摘录命题，而不是遗漏这段原书论述。C：两份签名相同且作为修正/推广版均PASS：真实Wiener过程、C∞单位周期势及Lipschitz力、实际单位质量周期端点核；T>0、σ≠0、任意初值x以及非空开集C给出严格正概率。已展开路径存在规格和初值/积分方程、推前核定义，并核对所引open\_pos定理的完整文件参数。增加C.Nonempty恰好消除条目15的空集漏洞；γ任意实数、σ任意非零实数是有限时刻可达性的合理推广，不需要为此引入规范不变测度或正摩擦。修正版并未声称一般质量矩阵版本已经覆盖。[EXTRA]应补全该参数推广，不把nonempty写进原文引文冒充原书已印出。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lemma61Nonempty` | 已证 | — | PASS |
| `MD.Ch06.lemma61Printed_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3129`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ControlPath

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Consider the ODE

$$
\frac{d^2q}{dt^2}+\nabla U(q)+\gamma\frac{dq}{dt}=\sigma\frac{dR}{dt}.\tag{6.49}
$$


> for some positive constants $`\gamma`$ and $`\sigma`$. This is precisely Langevin dynamics (6.47), substituting a process $`R(t)`$ in place of the Wiener process. Choose $`q`$ to be a $`C^\infty`$ path such that for a given $`t\gt 0`$

$$
(q(0),\dot q(0))^T=X_0;\quad(q(t),\dot q(t))^T=y.
$$


> Taking $`R(0)=0`$, we can obtain a $`C^\infty`$ function $`dR/dt`$ by substitution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem controlPath {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整实际任意位置/速度端点、q/p/R全光滑、R0=0及真实全时ODE；σ≠0，未冒充随机正概率。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有x,y、T>0、σ≠0，存在全光滑q,p,R，四个端点及R0=0，逐时q′=p与p′=−∇U−γp+σR′全部保留。欧氏提升的可控性足够用于环面投影，EXTRA范围清楚。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.controlPath` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3150`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ControlEndpointStable

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Using the results of [257, Lemma 3.4], we can deduce that for any $`\delta\gt 0`$, there exists a sufficiently small $`\varepsilon\gt 0`$ such that if a realization of the Wiener process $`W`$ remains close to our solution $`R`$

$$
\sup_{0\le s\le t}\|W(s)-R(s)\|\le\varepsilon,\tag{6.50}
$$


> then $`X(t)\in\mathcal B_\delta(y)`$. 

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem controlEndpointStable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint_stable <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际完整受控积分方程和原平滑势局部cutoff稳定性，全部端点/δ/ε；未假设全局Lipschitz势，原环面投影由上一真实核桥接。

### 6. 审计结论（含网站结论）

网站原返回：PASS。δ后选统一ε，再量化所有连续W,q,p；积分解定义包含初值、W0和两条真实积分方程。给定controlPosition/Momentum/Rate为Hermite三次路径及ODE反解，R为其积分；sup管道用逐时≤表达，端点严格dist<δ正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.controlEndpointStable` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3162`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WienerControlTube

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> The event (6.50) is shown in [349] to have positive probability for any $`\varepsilon\gt 0`$, and hence the required property is shown for any open set.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerControlTube {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε) := by
  apply MolecularDynamics.textbookWienerVectorRealControlTube_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整实际标准多维Wiener法则、真实连续控制R0=0、T/ε>0及sup管道事件；非仅某单时Gaussian边际。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D50规定联合高斯、均值、独立坐标Brownian协方差与几乎处处连续，管道定义在闭时间区间逐时≤ε，T/ε>0且连续R起于0。对象、时间和事件完整，未以单时边际替代路径规律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerControlTube` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3173`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinCanonicalStationary

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Langevin dynamics is geometrically ergodic with respect to the canonical distribution

$$
\rho_\beta(q,p)=\exp(-\beta H(q,p)),
$$


> where it is easily checked that

$$
\mathcal L_{LD}^\dagger\rho_\beta=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinCanonicalStationary {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际归一canonical density（原式缺Z为未归一权重，常数不影响微分式）、全部相空间点及物理噪声；这里只证stationary differential expression，真实invariance/ergodicity在下一条。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际forward算子全文为−DF·b−div(b)F+σ²Δ\_pF/2；散度由全部位置/动量对角方向导数定义，确为平坦前向算子。D56–D57给归一canonical密度，正β、γ及σ=√(2γ/β)完整，逐点平稳式正确。原几何遍历性另列21，本条scope已限stationary differential expression。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinCanonicalStationary` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3182`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinGeometricErgodicity

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Hence Langevin dynamics is geometrically ergodic with respect to the canonical distribution

$$
\rho_\beta(q,p)=\exp(-\beta H(q,p)),
$$


> where it is easily checked that

$$
\mathcal L_{LD}^{\dagger}\rho_\beta=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinGeometricErgodicity :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  MolecularDynamics.Chapter06Review.invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  (∀ ν : Measure (textbookLangevinPeriodicPhase n), IsProbabilityMeasure ν →
    MolecularDynamics.Chapter06Review.invariantKernel
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) ν →
    ν=textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ l : ℕ, 1 ≤ l → ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧
    ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Measurable f → (∀ y, |f y| ≤ (1+‖y.2‖^2)^l) → ∀ t : ℝ≥0,
      |MolecularDynamics.Chapter06Review.kernelAverage
        (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) f t x
        -(∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
        C*(1+‖x.2‖^2)^l*Real.exp (-lambdaParam*(t : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Lean采用单位周期、单位质量的实际Langevin核与归一Gibbs概率，显式要求U光滑周期、力全局Lipschitz及β,γ>0。
- [EXTRA] 对每个l≥1，常数在x、f、t之外；f精确限定为可测且|f(y)|≤(1+‖p‖²)^l的点态权界类。一般常数倍由缩放处理；不能称任意仅加权可积函数。
- [EXTRA] 固定有限维时可使用正平移后的Hamiltonian权重与(1+‖p‖²)^l比较，不能对未平移H^l作全局双边比较。
- [ERRATUM?] 原页exp(-βH)未显示归一因子；保留原式，需人工确认省略Z的约定。Lean实际采用归一Gibbs概率。
- [EXTRA] 复审范围：权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS指所交Lean签名的语义审校。相空间确为T^n×R^n；U光滑且单位周期，力全局Lipschitz，β、γ严格为正，噪声幅度√(2γ/β)。核来自有限窗真实Langevin积分解及Wiener路径分布；结论依次是归一Gibbs不变、全部不变概率的唯一性、每个整数l≥1上的统一加权指数估计。观测量为所有可测且逐点满足|f(y)|≤(1+‖p‖²)^l的实函数，既不是仅紧支函数，也不是任意加权L¹函数。C、λ可依赖n、U、β、γ、l等此前参数，但不依赖x、f、t；t=0包括在内。Fin n→R的标准范数与欧氏范数在固定有限维可比，不改变这一增长类。归一Gibbs与原页未写Z的exp(-βH)有明确区别，因此A阶段保留归一约定疑问为NEEDS\_HUMAN；该疑问及过时EXTRA措辞不构成此正确签名的FAIL。未检查证明完成度。
当前处理：网站PASS（复审）。
权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinGeometricErgodicity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3192`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinTimeAverage

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Hence averages along solutions to (6.47) will converge to the spatial average with respect to $`\rho_\beta`$. Thus, Langevin dynamics is a useful tool for sampling the canonical distribution, as we may sample $`\rho_\beta`$ by computing solutions to the SDE.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinTimeAverage :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Measurable f →
    (∃ l : ℕ, ∃ C : ℝ, 0 ≤ C ∧ ∀ y, |f y| ≤ C*(1+‖y.2‖^2)^l) → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际同一全时随机周期Langevin轨迹，任意点初始状态、全部可测多项式动量增长观测量、几乎处处时间均值；不把初始density的ensemble衰减当轨迹时间均值。
- [EXTRA] 补实际选解存在、真实积分方程、唯一性、限制及同一全时随机过程一致性的完整声明类型；有限窗选择不能仅凭choose名称认定相容。

### 6. 审计结论（含网站结论）

网站原返回：PASS。相空间、归一Gibbs测度、β和γ及Wiener向量与上一条一致。结论确为沿同一随机轨迹的Cesàro时间均值：∀确定x、∀可测实f，若存在l∈N及C≥0使|f|≤C(1+‖p‖²)^l，则对P几乎所有样本，实数T→+∞时T⁻¹∫₀ᵀf(X\_s)ds趋于Gibbs空间平均。l=0允许全部有界可测函数；零测例外集可以依赖x、f，并未声称所有x、f共享例外集。GlobalRandomPhase虽按ceil(t)+1选有限窗，但本任务同时提供真实积分解、全局唯一性、窗口一致性及∀T的AE规格，故不是把不相容choose选择误认成一条轨迹。周期过程由该全时解投影得到；hU、hp即便以下划线命名仍是显式前提。没有用初始密度ensemble收敛替代时间平均。sorry不参与本签名判定。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinTimeAverage` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3216`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedH1

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> We denote by $`H^1(\mu)`$ the space of functions $`f(q,p)`$ defined on $`D=\mathbb T^{N_c}\times\mathbb R^{N_c}`$ with bounded norm

$$
\|f\|_{H^1(\mu)}^2\stackrel{\mathrm{def}}=\|f\|_{L^2(\mu)}^2+\|\nabla_qf\|_{L^2(\mu)}^2+\|\nabla_pf\|_{L^2(\mu)}^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedH1 {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) : Type :=
  textbookLangevinCanonicalWeakH1 U hU hp β hβ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Gibbs加权弱导数闭图及AE商的完整Hilbert H1；不是smooth jet子集，函数/导数投影和范数下一条明确。
- [EXTRA] 补坐标伴随测试表达式及memLp\_two完整规格；明确位置β∂U、动量βp项及分部积分符号，补摘录不算原书勘误。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weightedH1是Gibbs权重下的完整实弱H¹实现：none分量为函数的AE等价类，some(inl i)、some(inr i)分别是q、p的L²弱导数。测试恒等式的负号和β∂U、βp项正确，因为dμβ正比于exp(-βH)dω。所有测试函数的伴随表达式MemLp规格已实际摘录，不能只看名称。每项均为L²类，PiLp 2给出平方和范数；测试恒等式是连续线性约束，数学上刻画闭弱导数图及通常的Sobolev完备空间。所加U光滑、单位周期、β>0和Gibbs权重专业化已有EXTRA说明。这里审查类型和定义语义，不另宣称项目已证明闭性、完备性或所有相关实例。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedH1` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3233`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedH1Norm

印刷p.256–257 / PDFp.277–278；§6.4.4。

### 1. 原文陈述

> where

$$
\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega),
$$


> and, for a vector function $`w:D\to\mathbb R^{N_c}`$, we have

$$
\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem weightedH1Norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2) := by
  apply MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq <;> assumption

/-- 原文第一式：实标量L²范数平方等于平方积分。 -/
theorem weightedL2NormScalar26 {D : Type*} [MeasurableSpace D]
    (μ : Measure D) (f : Lp ℝ 2 μ) :
    ‖f‖ ^ 2 = ∫ x, (f x) ^ 2 ∂μ := by
  sorry

/-- 原文第二式：任意欧氏向量值L²函数的分量均属L²，范数平方为分量平方和。 -/
theorem weightedL2NormVector26 {D : Type*} [MeasurableSpace D] {Nc : ℕ}
    (μ : Measure D) (w : D → EuclideanSpace ℝ (Fin Nc)) (hw : MemLp w 2 μ) :
    ∃ hc : ∀ i : Fin Nc, MemLp (fun x ↦ w x i) 2 μ,
      ‖hw.toLp w‖ ^ 2 = ∑ i : Fin Nc, ‖(hc i).toLp (fun x ↦ w x i)‖ ^ 2 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。现有weightedH1Norm本身数学正确：它确实给出加权H¹范数等于函数值及全部位置、动量弱导数L²范数的平方和，N、β、U及坐标投影均正确。但原文JSON的两项主结论分别是‖f‖²L²=∫f²dμ，以及任意w:D→R^N的‖w‖²L²=Σ‖wᵢ‖²L²。该Lean结论没有积分，没有独立标量f:L²，也没有任意向量w，因此不能覆盖这些结论。FAIL仅指本条原文与声明的完整覆盖关系，不指jet等式错误，也不因证明或sorry。EXTRA承认缺口是准确的，但不能替代缺失声明。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedH1Norm` | 已证 | — | PASS |
| `MD.Ch06.weightedL2NormScalar26` | 未证 | 缺大型理论 | 修复后未再送网站 |
| `MD.Ch06.weightedL2NormVector26` | 未证 | 缺大型理论 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3240`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Proposition64Printed

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> Proposition 6.4 Let $`U`$ be $`C^\infty`$ on the position domain $`Q=\mathbb T^{N_c}`$ and suppose $`g\in H^1(\mu)`$ satisfies

$$
\int_D g\,d\mu_\beta=0,
$$


> where $`\mu_\beta`$ is the canonical measure, then the Poisson equation

$$
\mathcal L_{LD}^\dagger\varphi=g
$$


> has a solution $`\varphi\in H^1(\mu)`$ which is unique up to addition of a constant multiple of the Gibbs density.

### 2. 原文证明

> 原书给出证明论述；本条仅摘录命题，相关论述见相邻原页，未在此补写。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition64Printed :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留原flat/Gibbs坐标混用疑误和非Gibbs恒通量反例；补H¹伴随测试表达式，修正版本由Proposition64Relative独立保存。
- [ERRATUM?] 原印刷同时混用Gibbs零均值与flat前向核的Gibbs倍数结论；所给弱域存在非Gibbs恒通量零模，须人工核定伴随坐标与算子域，原句不改。
- [EXTRA] 本任务没有提供\_counterexample声明；不能把“保留反例”当作已完成的Lean审查证据。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed忠实性：PASS。给定光滑周期U、β>0、γ>0，对每个Gibbs加权H¹且μβ零均值的g，确实逐项保留flat-forward弱Poisson方程、完整H¹解存在、以及全部H¹解唯一模Gibbs密度倍数。CanonicalDensity为D52–D59的归一exp(-βH)，与未归一Gibbs密度相差正常数，不改变唯一模其倍数的表述。但这一原文字面版本在所定义弱域上存在明确恒通量反例；不能将平直前向伴随与Gibbs Hilbert伴随混用。因此总判NEEDS\_HUMAN，保留Printed；不是因sorry失败。修正版在条目6的独立声明另审，未用它替换此原文版。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition64Printed` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:3265`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

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

