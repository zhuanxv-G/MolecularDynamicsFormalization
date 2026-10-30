[上一部分](part08.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part10.zh-CN.md)

## MD-6.4.2-CylinderForwardPrinted

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $`\mathcal L^\dagger`$, acting on a density $`\rho(X)`$ as

$$
\mathcal L^\dagger\rho=-\nabla\cdot(b_0\rho)+\tfrac12\operatorname{Tr}(B^T\phi''B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderForwardPrinted {n r : ℕ} (b₀ : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ φ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  -(∑ i, fderiv ℝ (fun z ↦ b₀ z i*ρ z) x (Pi.single i 1)) +
    MolecularDynamics.Chapter06Review.vectorDiffusion B φ x / 2

/-- 修正版：真正环面×动量圆柱空间的前向表达式，使用周期lift方向导数。
原Euclidean坐标辅助cylinderForwardPrinted_corrected另保留；本定义不声称密度存在。 -/
def cylinderForwardPeriodic_corrected {n r : ℕ}
    (a : textbookLangevinPeriodicPhase n → (Fin n ⊕ Fin n → ℝ))
    (B : Matrix (Fin n ⊕ Fin n) (Fin r) ℝ)
    (ρ : textbookLangevinPeriodicPhase n → ℝ) (x : textbookLangevinPeriodicPhase n) : ℝ :=
  -(∑ i : Fin n ⊕ Fin n, textbookLangevinPeriodicDirectionalDerivative
      (fun y ↦ a y i*ρ y) (textbookLangevinCanonicalCoordinateDirection i) x) +
    (∑ j : Fin r, ∑ i : Fin n ⊕ Fin n, ∑ k : Fin n ⊕ Fin n,
      B i j*B k j*textbookLangevinPeriodicDirectionalDerivative
        (textbookLangevinPeriodicDirectionalDerivative ρ (textbookLangevinCanonicalCoordinateDirection k))
        (textbookLangevinCanonicalCoordinateDirection i) x)/2
```

同问题的独立限定/修正版（位于另一条）：
```lean
def cylinderForwardPrinted_corrected {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。cylinderForwardPrinted：任意欧氏n维b0、n×r常B、密度ρ和独立测试φ，负散度作用于b0ρ，扩散作用φ并除2，忠实保留原书符号错误，但这是欧氏局部坐标表达式，不是完整一般T^k1×R^k2域。cylinderForwardPrinted\_corrected调用vectorForward，将扩散改为ρ，欧氏辅助定义正确。cylinderForwardPeriodic\_corrected在真实T^n×R^n上按Fin n⊕Fin n坐标方向求周期lift的一、二阶方向导数，用Σ\_j B\_ij B\_kj和1/2给前向密度算子；维数与噪声列维一致，作为光滑周期密度的形式表达式正确。它只覆盖k1=k2=n的Langevin相空间，非原页全部k1,k2；且未在类型内强制光滑/密度资格，不能当算子域或不变性定理。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderForwardPrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.cylinderForwardPeriodic_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2105`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-StationaryDensity

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of

$$
\mathcal L^\dagger\rho_{\rm eq}\equiv0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stationaryWeightRaw25 {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0

def stationaryDensity {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧ Integrable ρ volume ∧
  (∫ x, ρ x)=1 ∧ ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。

### 6. 审计结论（含网站结论）

网站原返回：PASS。stationaryWeightRaw25只定义任意实函数的vectorForward逐点为0，是总化辅助。stationaryDensity另外要求ρ可测、处处非负、Lebesgue可积及积分1，再要求同一逐点形式方程，概率密度资格已补足，签名作为形式平稳密度定义PASS。D29为负散度加常B扩散半项；n,r任意，当前域为ℝ^n而非一般圆柱。类型未要求C²或适当generator域，Lean的不可微处导数总化为零；所以不能凭该谓词推出真实Markov核不变性，当前context\_notation已明示形式stationarity且另给generator域/演化。该限制须持续保留，不把“correspond in general”误报为已证等价定理。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stationaryWeightRaw25` | 定义 | — | PASS |
| `MD.Ch06.stationaryDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2126`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-StationaryInvariant

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of

$$
\mathcal L^\dagger\rho_{\rm eq}\equiv0.
$$


> Solutions to this equation are of central importance to the probabilistic behavior of solutions to (6.43). Such solutions give distributions of points in phase space which will remain constant as solutions evolve in time.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem stationaryInvariant :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  MolecularDynamics.Chapter06Review.markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → ∀ T : ℝ, 0 ≤ T →
    ∃ bound : D → ℝ, Integrable bound μ ∧ ∀ s ∈ Icc 0 T, ∀ x,
      |L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal y) x| ≤ bound x) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal x)
      (L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  MolecularDynamics.Chapter06Review.invariantKernel K μ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Markov kernel semigroup、真实generator对演化检验的导数关系与弱stationarity，并明确局部可积支配保证求导换积分；完整kernel测度不变，未假设不变结论或把形式exp当实际流。
- [EXTRA] 补实际Chapter06Review.invariantKernel及其kernelEvolution定义体；不以MD.Ch06同名定义替代。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：引文、公式、节号及印刷247/PDF268页均与附件第1页相符。C：D为任意可测状态空间，K为非负时间的实际概率Markov核半群，μ为概率测度；逐一核对了全部有界可测检验函数、每个有限时间区间上的可积导数支配、演化检验函数的右侧导数关系、L作用后的可积性及弱平稳性前提。D3–D6中kernelAverage是真实核积分，kernelEvolution为K t ∘ₘ μ，invariantKernel量化所有非负时刻的测度相等。因此结论是完整的核不变性，未将形式指数、只对常数检验的恒等式或不变性本身作为前提。[EXTRA]清楚披露了这是一条在可交换微分与积分条件下由弱平稳推出不变的充分命题；不把它解读为无条件的形式偏微分方程等价定理。本次只审签名，不因sorry扣分。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stationaryInvariant` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2138`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4-CanonicalMixingMeaning

印刷p.244 / PDFp.265；§6.4。

### 1. 原文陈述

> At any time $`t`$ we take a snapshot $`M_t`$ of the resulting set of random variables. Even if $`M_0`$ is bounded, the evolving set of points would be expected to expand and fill in the phase space accessible at the temperature $`T`$; eventually we hope that the points will be distributed in the entire phase space in accordance with the target measure (usually the Gibbs distribution $`e^{-\beta H}`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def canonicalMixingMeaning {D : Type*} [TopologicalSpace D] [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ x : D, ∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂K t.toNNReal x) atTop (𝓝 (∫ z, f z ∂μ))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实概率目标和任意点初始law、全部有界连续检验函数弱混合定义；没有宣称所有SDE自动满足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义为概率目标及每个点初值、每个有界连续实检验的弱收敛；时间atTop下toNNReal不影响极限。此为[EXTRA]明确选择的含义，不是任意SDE的定理。Kernel本身不保证Markov，应避免把任意K称概率law。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalMixingMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2155`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-LangevinCanonicalMixing

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> Even a single phase space point, which corresponds to a delta-function initial distribution, will instantly diffuse as the solution of the Fokker-Planck equation and, eventually, would cover the entire phase space.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinCanonicalMixing :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ →
  (∀ t : ℝ≥0, 0 < t → ∃ density : textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n → ℝ,
    Continuous density ∧ (∀ x y, 0 < density (x,y)) ∧
    ∀ x, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t x =
        (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun y ↦ ENNReal.ofReal (density (x,y)))) ∧
  ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实现有周期单位质量Langevin kernel、正γ/β、原光滑力全局Lipschitz；完整任意点初值的正时刻严格正连续转移密度以及全部有界连续检验弱混合，原一般混合意义另条，不以单位质量特例替代一般定义。
- [EXTRA] 补所选真实路径的存在规格和初值/积分方程；范围仅周期、单位质量及已列全局Lipschitz力，不声称一般非周期Langevin结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：印刷248/PDF269页中从“Even a single phase space point”到“entire phase space”的摘录准确。C：状态空间确为单位位置环面×实动量，U全局C∞且单位周期，力为−∇U并有显式全局Lipschitz常数；β、γ正，噪声幅度√(2γ/β)，B满足给定高斯、均值、协方差和几乎处处连续的Wiener规格。D17、D19–D23给出所选路径的存在、初值和两条积分方程；D28的核是该实际路径端点的推前，未任意选一个具有所需性质的核。flatPhaseMeasure为位置Haar×动量Lebesgue；canonicalMeasure为归一位置Gibbs×各坐标方差β⁻¹的独立高斯。第一结论对每个t>0提供在两个初末态变量上连续、处处严格正的密度及全测度相等；第二结论对每个点初值、每个有界连续f给出到该规范测度的弱收敛。[EXTRA]已明确周期、单位质量的范围；不把此声明扩大为任意退化SDE或非紧配置空间的结论。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinCanonicalMixing` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2163`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianGenerator

印刷p.249 / PDFp.270；§6.4.3。

### 1. 原文陈述

> For example, let us return to Brownian dynamics (or overdamped Langevin dynamics) and set $`M=I`$ and $`\gamma=1`$ in (6.36), giving an equation of motion

$$
dq=-\nabla U(q)dt+\sqrt{2k_BT}dW.\tag{6.46}
$$


> Writing $`\beta^{-1}=k_BT`$ as usual, the generator of the stochastic process may be written as

$$
\mathcal L f=-\nabla U^T\cdot\nabla f+\beta^{-1}\Delta f.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def brownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际任意对角质量版本，取m≡1即此处公式；不声称原6.46本身含一般质量。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐坐标fderiv方向导数及二阶导数给出逆质量加权漂移和扩散；m≡1还原原式。[EXTRA]已披露推广。当前是代数算子定义，并非在任意β,m及任意f下断言存在相应扩散生成元。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2183`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianWeightedInner

印刷p.249 / PDFp.270；§6.4.3。

### 1. 原文陈述

> Let $`\bar\rho_\beta=\exp(-\beta U)`$, and define the space of functions $`C_0^2(\bar\mu_\beta)`$ consisting of functions in $`C_0^2`$ on the configuration space $`\mathcal Q\subset\mathbb R^{N_c}`$ together with the inner product

$$
\langle f,g\rangle_\beta\stackrel{\rm def}=\int_{\mathcal Q}f(q)g(q)\bar\mu_\beta(d\omega_q)=\int_{\mathcal Q}f(q)g(q)\bar\rho_\beta(q)d\omega_q;
$$


> where $`d\omega_q=dq_1dq_2\cdots dq_{N_c}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def brownianWeightedInner {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube n, f q*g q*Real.exp (-β*U q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]本章后续周期Q的单位基本域；保留原未归一权重，不偷加Z⁻¹。C₀²域与闭算子域另行区别。

### 6. 审计结论（含网站结论）

网站原返回：PASS。积分域确为Icc 0 1，权重exp(-βU)未除Z；f,g为任意函数的总定义，适当函数域上才是内积。周期基本域限制已披露；此定义没有形式化C₀²函数空间本身。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianWeightedInner` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2192`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianDirichlet

印刷p.249–250 / PDFp.270–271；§6.4.3。

### 1. 原文陈述

> Combining this with the first part of the inner product, we see that

$$
\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.
$$



### 2. 原文证明


$$
\langle f,\mathcal Lg\rangle_\beta=\int_{\mathcal Q}f[-\nabla U^T\nabla g+\beta^{-1}\Delta g]\bar\rho_\beta d\omega_q.
$$


> Integrating by parts in the second term we have

$$
\beta^{-1}\int_{\mathcal Q}f\Delta g\bar\rho_\beta d\omega_q=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla(f\bar\rho_\beta)d\omega_q =-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q+\int_{\mathcal Q}f(\nabla g^T\nabla U)\bar\rho_\beta d\omega_q.
$$


> Combining this with the first part of the inner product, we see that

$$
\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.
$$



### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianDirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  apply MolecularDynamics.textbookBrownianGenerator_integral_dirichlet <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C∞周期资格保证边界通量消去；实际全质量逆M梯度积，m≡1还原原式；β≠0。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U,f,g全域C∞、整数平移周期及β≠0保证分部积分边界抵消；两侧使用同一未归一权重和全部逆质量坐标和。等式不需质量正性；m≡1还原原文。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianDirichlet` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2198`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianSymmetry

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In this form we see that $`f`$ and $`g`$ appear symmetrically, so we may write

$$
\langle f,\mathcal Lg\rangle_\beta=\langle\mathcal Lf,g\rangle_\beta;
$$


> hence, with respect to the weighted inner product, $`\mathcal L^\dagger=\mathcal L`$. (Note that the adjoint indicated here is quite different than the $`L^2`$ adjoint mentioned previously in connection with the Fokker-Planck operator.)

### 2. 原文证明

> 原书给出分部积分得到形式对称配对的论证；未给出无界算子闭域及伴随域相等的完整论证。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianSymmetry {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianSymmetry_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原文引文保持不变；两份Lean声明仅覆盖C∞单位周期核心上的加权配对对称。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整未归一配对等式，由现成归一配对消去正Z⁻¹；C∞周期核心上的形式对称，不宣称C₀²核心本身已闭自伴。
- [EXTRA] 本条仅为周期光滑核心上的形式对称配对；核心对称不推出伴随域相等。闭实现自伴另见BrownianClosedSelfAdjoint，原C₀²域解释待签核。
- [ERRATUM?] 形式对称与闭自伴须区分；本条配对恒等式不等于已经忠实实现原C₀²域上的L†=L。
- [EXTRA] 复审范围：两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
- 覆盖缺口：原C₀²域的自伴解释待人工确认；闭实现的自伴性由BrownianClosedSelfAdjoint单独处理。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：配对等式及随后L†=L的引文准确，原文的自伴措辞应保留。C：两份Lean签名完全相同，均为PASS的限定配对恒等式：积分在一个基本立方体上，权为exp(−βU)，U、f、g均C∞且单位周期，β≠0；m仅作实系数参数，形式对称本身不需要质量正性。D32–D34及归一配对定义表明取消正的配分函数因子不会改变等式。它们没有表达伴随算子的定义域等于原定义域。原页从对称积分直接说L†=L，但此前给出的C₀²域是否指闭实现并不清楚，不能把正确的核心对称等式当作原域已自伴。corrected版数学陈述通过；整条因原文域解释仍为NEEDS\_HUMAN，而非因证明占位或定义缺失。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianSymmetry` | 已证 | — | PASS |
| `MD.Ch06.brownianSymmetry_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2213`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianNonpositive

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> Moreover, from the calculation above,

$$
\langle f,\mathcal Lf\rangle=-\beta^{-1}\int_{\mathcal Q}\|\nabla f\|^2\bar\rho_\beta d\omega_q;
$$


> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianNonpositive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNonpositive；改动：采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。 -/
theorem brownianNonpositive_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNegativeDefinitePrinted；改动：将严格小于0改为小于等于0；零特征值与常数核保留。 -/
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

- [EXTRA]正质量与β>0，未归一配对；本条结论精确保留≤0，原negative definite术语错误另记录。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。正质量、β>0及周期光滑域下未归一二次型≤0正确。原文negative definite错误，已有[ERRATUM?]保留；本签名仅保留正确的半负定子结论。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianNonpositive` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.brownianNonpositive_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.brownianNegativeDefinitePrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2246`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianRealEigenvalue

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianRealEigenvalue {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianRealEigenvalue_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真正非零L²特征函数、C∞周期、正质量与β>0；不以特征值符号作假设。
- [EXTRA] [ERRATUM?]原引文negative definite应为半负定，常数零模反例与BrownianNegativeDefinitePrinted共用；本条只证明已给实特征参数≤0，不冒称全部复谱实性。
- 覆盖缺口：仅证明已给实特征参数非正；不单独证明复特征值实性，也不把原严格负定用语认作成立。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：原文确实同时写⟨f,Lf⟩≤0和“negative definite”，转录未错，不能在原引文中静默改成半负定。C：两份签名均PASS：正质量、β>0、C∞周期U及非零L²意义的C∞周期f，逐点满足Lf=ℓf，且参数ℓ预先属于ℝ，结论ℓ≤0。非零性相对于基本立方体Lebesgue几乎处处定义，正Gibbs权使其等价于Gibbs-L²非零；没有把特征值符号作为假设。声明不证明任意复特征值实性，也不证明严格负定；这些限制已由[EXTRA]说明。整条因原书严格负定用语的数学疑误需人工签核。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianRealEigenvalue` | 已证 | — | PASS |
| `MD.Ch06.brownianRealEigenvalue_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2281`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianClosedSelfAdjoint

印刷p.249–250 / PDFp.270–271；§6.4.3。

### 1. 原文陈述

> Then $`\mathcal L`$ is self-adjoint with respect to this inner product.

### 2. 原文证明

> 原书给出形式分部积分的论证，见印刷249–250页；未说明完整闭域及伴随域。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianClosedSelfAdjoint {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianClosedSelfAdjoint_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原文自伴句保持不变；Lean主版与corrected版均指周期Gibbs复L²上的闭/最大图实现。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]使用现成实际Gibbs复L²闭实现及完整adjoint域；原C₀²核心对称不等于闭自伴。权重归一不改变自伴关系。
- [EXTRA] 明确采用周期紧环面的Gibbs L²图闭包/最大复图实现；此域修正替换原C₀²核心域，不能把核心上的形式对称当原域自伴，待人工签核。
- [EXTRA] 原页先取单位质量；本条还推广至任意正对角质量。
- [ERRATUM?] 原C₀²域上的形式对称不应直接等同于完整无界算子的自伴。
- [EXTRA] 复审范围：限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
- 覆盖缺口：原C₀²核心域自伴的字面断言未由这两份签名实现，需人工确认作者原意。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：印刷249页末的“Then L is self-adjoint with respect to this inner product.”摘录准确。C：两份签名相同且作为修正版均PASS：正对角质量、β>0、C∞单位周期势；对象为归一Gibbs复L²上的实际部分线性算子，结论为完整IsSelfAdjoint。已展开光滑周期空间→L²嵌入→光滑域算子→实图闭包→由实际闭算子特征空间构成的复Hilbert基→最大复图。复图约束的是所有谱系数，并非只在原光滑域验证对称；归一权重的常数缩放不改变自伴关系。原书该句的前置对象是C₀²(μ̄β)，并先取M=I、γ=1；本条采用周期闭实现及正对角质量推广，是明确披露的域修正而非原C₀²域的逐字实现。[EXTRA]已要求人工确认，整条据此为NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianClosedSelfAdjoint` | 已证 | — | PASS |
| `MD.Ch06.brownianClosedSelfAdjoint_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2303`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianCompactResolvent

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianCompactResolvent {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianCompactResolvent_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Lean仅覆盖紧环面Gibbs-L²闭实现的(1−L)⁻¹紧性；原文离散谱子句由条目7承接。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Gibbs复L²闭实现的(1−L)⁻¹；全部离散谱子结论另条保留，未从本条自动声称原C₀²域自伴。
- [EXTRA] 仅断言紧torus上的闭实现具有紧预解式；原一般C₀²措辞未覆盖，域与紧配置假设需人工签核。
- [ERRATUM?] 预解式必须属于明确的闭实现，不能仅以核心上的形式微分表达认定原域具有该预解式。
- [EXTRA] 复审范围：只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
- 覆盖缺口：原C₀²域及一般配置空间的解释待人工确认。
- 覆盖缺口：原句中的离散谱结论由BrownianDiscreteSpectrum及其eigenvalue补充声明另列。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：compact resolvent、引用[360]及随后可数离散特征值的原句准确。C：两份紧性签名作为周期闭实现的限定版均PASS。已展开D86–D91：实闭图上的shift为(x,y)↦x−y，逆映射后取第一坐标，所得确为(1−L)⁻¹；复预解式由实部、虚部分别作用该真实预解式并复线性化得到，不是一个仅名为resolvent的任意紧算子。正质量、β>0和紧配置环面是明确前提；没有将紧性本身假设进去。此条签名仅给预解式紧性，离散谱的对应条目为7。原页仍把性质归在C₀²函数空间上；与闭实现、紧配置假设之间的解释差别已在[EXTRA]要求签核，不能由本条自动认证原一般域表述。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianCompactResolvent` | 已证 | — | PASS |
| `MD.Ch06.brownianCompactResolvent_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2319`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianDiscreteSpectrum

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianDiscreteSpectrum {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ, z.im=0) ∧
  ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ={z} := by
  refine ⟨textbookBrownianGibbsGeneratorComplexSpectrum_countable m hm U hU hPU β hβ, ?_, ?_⟩
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_isolated m hm U hU hPU β hβ z hz

/-- 25号补全：每个谱点均为闭实现的特征值；尚缺完整谱理论桥接。 -/
theorem brownianDiscreteSpectrum_eigenvalue {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
      ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
        (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。
- [EXTRA] 全部谱结论针对正质量、β>0、C∞单位周期势的紧环面Gibbs复L²闭实现。
- [ERRATUM?] 原C₀²域与上述闭实现的对应关系承接条目6，仍需人工签核。
- [EXTRA] 复审范围：合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。
- 覆盖缺口：有限重数和无有限聚点的标准离散谱强化尚未单列。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：与条目6同一句原文，转录准确。C：两份签名分别PASS。主声明给出所定义复谱的可数性、虚部为零及每个谱点的开邻域孤立性；补充声明对每个谱点给出非零复L²向量及(v,z•v)在完整闭图中，准确表达它是特征值而非仅“谱点可数”。D92–D93的预解集要求有界复线性算子同时满足左右逆图关系，谱取其补集，未偷换成预先枚举的特征值集合。审校按两份声明合并覆盖原文的“countable collection of eigenvalues”，不因补充声明的sorry判FAIL。有限重数没有作为该两份签名的结论；不得把依赖中某定理的存在误计为这里显式列出的结论。整条仍承接条目6的原C₀²域/闭实现解释疑问。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianDiscreteSpectrum` | 已证 | — | PASS |
| `MD.Ch06.brownianDiscreteSpectrum_eigenvalue` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2334`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianSpectralGap

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianSpectralGap {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    z ≠ 0 → z.im=0 ∧ z.re ≤ -α := by
  refine ⟨textbookBrownianGibbsCoercivityRate m U hU hPU β,
    textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ, ?_⟩
  intro z hz hn
  exact ⟨textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz,
    textbookBrownianGibbsGeneratorComplexSpectrum_gap m hm U hU hPU β hβ z hn hz⟩
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]现成实际全闭谱；正谱隙从真实Poincaré常数得出，不把目标谱隙作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在统一α>0，对全复谱每个非零点同时给出虚部0和实部≤−α，未将谱隙作为假设；与原排除零特征值的陈述吻合。正质量、β>0、C∞周期及完整谱已明确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianSpectralGap` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2358`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

