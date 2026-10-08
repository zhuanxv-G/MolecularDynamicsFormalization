# 第6章导师快速审阅（15条）

扫描用户PDF233–285并补核标题PDF232；实际第6章正文印刷211–258/PDF232–279，PDF280为Exercises、PDF282起第7章，排除。逐页边界见PAGE_SCAN.json。全部proved/weakened为既有正式库成果映射，本次没有新证明。CanonicalKernelConstant等封存文件不导入、不恢复。Theorem6.1、Theorem6.2、Proposition6.4保持statement_only。

清单是进度来源；defined与proved分开统计。Prop定义编译通过只确认陈述类型正确，不表示结论成立。
原文为用户提供的教材PDF逐页忠实转述；机器验收见VALIDATION.json和check-full目录。导师语义审阅待完成。
代码块展示陈述及定义体，省略证明；节参数、类型实例及命名空间环境以链接源码为准。

| 状态 | 条数 |
| --- | ---: |
| defined | 45 |
| proved | 30 |
| statement_only | 42 |
| weakened | 6 |
| not_formalizable_now | 3 |
| 合计 | 126 |

proved为清单行数；重复映射同一证明不等于独立定理数量。

需人工判断的问题：

1. Prop6.1–6.3的已验收内容与原文一般质量/域/正则性是否一致？单位质量、单位周期实现的范围差异已逐行列明。
2. Theorem6.1已有真实复谱、半群与过程law/L2密度平均桥接；本章完整陈述补L2初始密度和闭实现，原C2核心、任意初值及time average术语尚未统一验收。是否保留statement_only？
3. Assumption1的字面密度连续含t=0，标准扩散从点初值的密度不能如此延拓；一般Harris理论、实际正时密度存在和唯一性仍缺。是否接受字面与t>0版本分列？
4. Proposition6.4把weighted均值条件与flat前向伴随混用；字面版唯一性模Gibbs、相对密度修正版模常数分列，仍缺Fredholm/紧预解/rough核识别。是否需勘误？封存不计成果。
5. Lemma6.1可达性已证单位质量/单位周期模型，但原文更一般域/质量和适应性语义签核仍需人工判断；相关行是否应保留weakened？

### CH06-093 · §6.4.3 · 定理 · 印刷p.250 / PDF271

原文（忠实转述）：Theorem 6.1: self-adjoint nonpositive discrete spectrum, a positive spectral gap, and exponential convergence of evolved ensemble averages.

```lean
-- MolecularDynamics.Chapter06Review.theorem61_statement
def theorem61_statement : Prop := ∀ {n : ℕ} (m : V n) (hm : ∀ i, 0 < m i)
    (U : V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ))
```

差异、假设及缺口：保留完整三部分待证陈述；已有复谱、半群和真实law-L2平均桥接较旧ledger更完整，但教材C2域/所有初始分布及平均术语未统一验收；Brownian由6.36采用逆质量Laplacian，区别于6.42动量正质量Laplacian；原negative definite及time average术语需签核。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:237`。

### CH06-099 · §6.4.4 · 定理 · 印刷p.252 / PDF273

原文（忠实转述）：Theorem 6.2: under Assumptions 1 and 2 on an appropriate Lyapunov sublevel, there is a unique invariant probability and a uniform weighted exponential estimate.

```lean
-- MolecularDynamics.Chapter06Review.theorem62_statement
def theorem62_statement : Prop := ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D), markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (kernelAverage K f t)) →
  ∀ (φ : D → ℝ) (α δ : ℝ), assumption2 (kernelGenerator K) φ α δ →
    ∃ R : ℝ, 0 < R ∧ ∀ (_ : assumption1 ν K {x | φ x ≤ R}),
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        Integrable (kernelGenerator K f) μ → (∫ x, kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x
```

差异、假设及缺口：完整唯一性和alltime bound；一般Harris定理/实际density存在未完成，条件Harris证明不替代假设验证；kernel版以右导数描述generator，真实扩散generator域及Feller条件的识别仍需语义签核。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:265`。

### CH06-121 · §6.4.4 · 命题 · 印刷p.257 / PDF278

原文（忠实转述）：Proposition 6.4: weighted-mean-zero g in H1 has a forward Poisson solution, unique modulo the Gibbs density.

```lean
-- MolecularDynamics.Chapter06Review.proposition64_statement
def proposition64_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x

-- MolecularDynamics.Chapter06Review.proposition64Relative_statement
def proposition64Relative_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
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
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c
```

差异、假设及缺口：忠实flat前向字面版与Gibbs加权相对密度修正版分列；printed兼容条件/adjoint测度不一致；Fredholm/compactresolvent/kernel仍缺，封存不恢复。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:326;MolecularDynamics/Chapter06/Statements.lean:340`。

### CH06-113 · §6.4.4 · 引理 · 印刷p.255 / PDF276

原文（忠实转述）：Lemma 6.1: at every positive time every nonempty open set has positive transition probability from every initial point.

```lean
-- MolecularDynamics.textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos
theorem textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase Nc) :
    ∃ q : ℝ → Ω → UnitAddTorus (Fin Nc), ∃ p : ℝ → Ω → (Fin Nc → ℝ),
      (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T → textbookLangevinPeriodicIntegralSolution U γ (Real.sqrt (2 * γ * β⁻¹)) T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample)) ∧
      (∀ t : ℝ, 0 ≤ t → AEMeasurable (fun sample ↦ (q t sample, p t sample)) P) ∧
      ∀ T : ℝ, 0 < T → ∀ C : Set (textbookLangevinPeriodicPhase Nc), IsOpen C → C.Nonempty →
        NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
          0 < P {sample | (q T sample, p T sample) ∈ C}

-- MolecularDynamics.Chapter06Review.lemma61_statement
def lemma61_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → V n) (m : V n) (U : V n → ℝ)
    (γ β : ℝ) (x0 : Phase n) (X : ℝ → Ω → Phase n),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  0 < γ → 0 < β → langevinMassSDE P (fun t sample ↦ B t.toNNReal sample) X m U γ β⁻¹ x0 →
  (∀ t : ℝ, 0 ≤ t → AEMeasurable (X t) P) →
  ∀ t : ℝ, 0 < t → ∀ C : Set (Phase n), IsOpen C → C.Nonempty → 0 < P {sample | X t sample ∈ C}
```

差异、假设及缺口：完整单位质量/单位周期实际模型已验收；一般正质量/任意周期框架忠实陈述但未推广；原漏Nonempty已补；同模块历史ledger CH06-NUM-006,CH06-DEP-015。

状态：**weakened**；位置：`MolecularDynamics/Chapter06/LangevinGlobalRandomSolution.lean:167;MolecularDynamics/Chapter06/Statements.lean:296`。

### CH06-020 · §6.1.5 · 命题 · 印刷p.222 / PDF243

原文（忠实转述）：Proposition 6.1: kB T=Av(G dot grad H)/Av(div G).

```lean
-- MolecularDynamics.proposition_6_1
theorem proposition_6_1 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :
    kB * T =
      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /
        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)
```

差异、假设及缺口：复用完整证明；G exp(-beta H)解释为统一有界，两weighted观测量可积；正文球体积除法证明不足，真实双截断替代；历史ledger CH06-NUM-001；同模块历史ledger CH06-NUM-001,CH06-DEP-027。

状态：**proved**；位置：`MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean:376`。

### CH06-039 · §6.2.2 · 命题 · 印刷p.229 / PDF250

原文（忠实转述）：Proposition 6.2: the quadratic sum converges to T in mean square.

```lean
-- MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto
theorem textbookWienerQuadraticSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ ω,
      (textbookWienerQuadraticSum W T K ω - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0)
```

差异、假设及缺口：真实preBrownian法则、T>=0；K趋无穷，原最后K趋0为笔误；同模块历史ledger CH06-NUM-002。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:200`。

### CH06-044 · §6.2.2 · 命题 · 印刷p.231 / PDF252

原文（忠实转述）：Proposition 6.3: for smooth deterministic g, the Ito integral is Gaussian with mean zero and variance integral g squared.

```lean
-- MolecularDynamics.textbookWienerDeterministicIto_proposition63
theorem textbookWienerDeterministicIto_proposition63 {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerDeterministicSum W g T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ ω, Y ω ∂P) = 0 ∧ (∫ ω, Y ω ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2
```

差异、假设及缺口：C1足够，真实L2构造+Gaussian法则，无law结论前置；同模块历史ledger CH06-NUM-003。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerDeterministicLaw.lean:164`。

### CH06-095 · §6.4.3 · 未编号结论 · 印刷p.251 / PDF272

原文（忠实转述）：For nonnegative unit-mass L2 initial density, actual Brownian ensemble averages converge exponentially.

```lean
-- MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential
theorem textbookBrownianDensityAverage_smooth_exponential
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace N) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube N, (f : (Fin N → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α * (t : ℝ))
```

差异、假设及缺口：真实Wiener实际过程+L2 Gibbs density，有限K依赖initial；所有singular初始law未计此式；同模块历史ledger CH06-DEP-097。

状态：**weakened**；位置：`MolecularDynamics/Chapter06/BrownianProbabilityDensityAverage.lean:199`。

### CH06-096 · §6.4.4 · 定义 · 印刷p.252 / PDF273

原文（忠实转述）：Assumption 1 combines one compact-set accessible interior point and a jointly continuous local transition density.

```lean
-- MolecularDynamics.Chapter06Review.assumption1
def assumption1 {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)

-- MolecularDynamics.Chapter06Review.assumption1Printed
def assumption1Printed {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ici 0)
```

差异、假设及缺口：字面连续包括t=0，非原点平滑概率密度可实现；修正版仅t>0，忠实保留两版。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:168;MolecularDynamics/Chapter06/ReviewDefinitions.lean:176`。

### CH06-117 · §6.4.4 · 未编号结论 · 印刷p.256 / PDF277

原文（忠实转述）：The Langevin Gibbs density satisfies the stationary forward differential expression.

```lean
-- MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero
theorem textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0
```

差异、假设及缺口：单位质量真实已归一canonicaldensity，实际operator；不变measure识别仍未证；同模块历史ledger CH06-DEP-151。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean:141`。

### CH06-108 · §6.4.4 · 定义 · 印刷p.254 / PDF275

原文（忠实转述）：Definition 6.1: drift/noise and iterated brackets span the full tangent space at a point.

```lean
-- MolecularDynamics.textbookHormanderAt
def textbookHormanderAt (seed : Set (E → E)) (x : E) : Prop :=
  textbookBracketPointSpan seed x = ⊤
```

差异、假设及缺口：忠实原定义含drift b0；密度定理所需parabolic版本不能自动混同；同模块历史ledger CH06-DEF-001。

状态：**defined**；位置：`MolecularDynamics/Chapter08/HormanderClosure.lean:33`。

### CH06-104 · §6.4.4 · 未编号结论 · 印刷p.253 / PDF274

原文（忠实转述）：The printed Laplacian upper bound l(l+Nc-1)H^(l-1) is false in general.

```lean
-- MolecularDynamics.textbookLangevinLyapunov_printed_laplacian_bound_counterexample
theorem textbookLangevinLyapunov_printed_laplacian_bound_counterexample :
    deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 = 52 ∧
      ¬ deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 ≤
        (2 : ℝ) * (2 + 1 - 1) * (4 ^ 2 / 2 + 2) ^ (2 - 1 : ℕ)
```

差异、假设及缺口：既有具体52>40反例，是原文差异证据，不算原断言证明；同模块历史ledger CH06-NUM-005,CH06-CLM-005,CH06-DEP-016。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinLyapunov.lean:41`。

### CH06-119 · §6.4.4 · 定义 · 印刷p.256 / PDF277

原文（忠实转述）：H1(mu) consists of L2 functions with L2 weak position and momentum derivatives.

```lean
-- MolecularDynamics.textbookLangevinCanonicalWeakH1
abbrev textbookLangevinCanonicalWeakH1 {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : Type :=
  ↥(textbookLangevinCanonicalH1WeakGraph U hU hp β hβ)

-- MolecularDynamics.textbookLangevinCanonicalWeakH1Value
def textbookLangevinCanonicalWeakH1Value {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ →L[ℝ] Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (PiLp.proj 2 (fun _ : Option (Fin N ⊕ Fin N) ↦ Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) none).comp
    (textbookLangevinCanonicalH1WeakGraph U hU hp β hβ).subtypeL

-- MolecularDynamics.textbookLangevinCanonicalWeakH1Derivative
def textbookLangevinCanonicalWeakH1Derivative {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    textbookLangevinCanonicalWeakH1 U hU hp β hβ →L[ℝ] Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) :=
  (PiLp.proj 2 (fun _ : Option (Fin N ⊕ Fin N) ↦ Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) (some j)).comp
    (textbookLangevinCanonicalH1WeakGraph U hU hp β hβ).subtypeL
```

差异、假设及缺口：已有真实weightedweakH1，使用AE商；不将smooth jet当全H1；历史ledger CH06-DEP-163,CH06-DEP-164；同模块历史ledger CH06-DEP-163。

状态：**defined**；位置：`MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean:83;MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean:95;MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean:103`。

### CH06-060 · §6.3.3 · 定义 · 印刷p.237 / PDF258

原文（忠实转述）：Eliminating bath modes gives a finite cosine memory kernel and initial-condition force.

```lean
-- MolecularDynamics.Chapter06Review.memoryKernel
def memoryKernel {k : ℕ} (μ : V k) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, Real.cos (bathFrequency μ i*t)

-- MolecularDynamics.Chapter06Review.bathForcePrinted
def bathForcePrinted {k : ℕ} (μ q0 p0 : V k) (Q0 t : ℝ) : ℝ := -bathForce μ q0 p0 Q0 t

-- MolecularDynamics.Chapter06Review.bathForce
def bathForce {k : ℕ} (μ q0 p0 : V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (bathFrequency μ i*t)*(q0 i-Q0) +
    (bathFrequency μ i)⁻¹ * Real.sin (bathFrequency μ i*t)*p0 i/μ i)
```

差异、假设及缺口：原f的负号与qi-Q推导冲突，保留字面和代入后正号版。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:97;MolecularDynamics/Chapter06/ReviewDefinitions.lean:102;MolecularDynamics/Chapter06/ReviewDefinitions.lean:99`。

### CH06-016 · §6.1.4 · 定义 · 印刷p.220 / PDF241

原文（忠实转述）：The canonical average is the normalized Gibbs integral, (6.4).

```lean
-- MolecularDynamics.textbookCanonicalAverage
noncomputable def textbookCanonicalAverage {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

-- MolecularDynamics.Chapter06Review.canonicalAveragePrinted
def canonicalAveragePrinted {Nc : ℕ} (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ *
    ∫ z, f z * canonicalDensity volume H β z
```

差异、假设及缺口：原6.4又乘已归一rho的Z^-1，保留字面与标准版；同模块历史ledger CH06-DEP-026。

状态：**defined**；位置：`MolecularDynamics/Chapter06/CanonicalTemperature.lean:20;MolecularDynamics/Chapter06/ReviewDefinitions.lean:31`。
