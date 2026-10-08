# 第6章人工审阅材料

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

### CH06-001 · §6.1.1 · 定义 · 印刷p.214 / PDF235

原文（忠实转述）：The isolated system is described by the microcanonical energy-surface distribution.

```lean
-- MolecularDynamics.Chapter05Review.microMeasure
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```

差异、假设及缺口：复用第5章真实正则面加权测度；一般几何识别仍未证。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:68`。

### CH06-002 · §6.1.1 · 定义 · 印刷p.214 / PDF235

原文（忠实转述）：Entropy is S(E)=kB log Z(E), (6.1).

```lean
-- MolecularDynamics.Chapter06Review.entropy
def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)
```

差异、假设及缺口：Z为能量面partition，正有限是物理解释前提。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:19`。

### CH06-003 · §6.1.1 · 未编号结论 · 印刷p.215 / PDF236

原文（忠实转述）：Independent subsystems have Z_AB=Z_A Z_B and additive entropy.

```lean
-- MolecularDynamics.Chapter06Review.entropyAdditivity_statement
def entropyAdditivity_statement : Prop := ∀ (kB ZA ZB : ℝ), 0 < ZA → 0 < ZB →
  kB*Real.log (ZA*ZB) = kB*Real.log ZA+kB*Real.log ZB

-- MolecularDynamics.Chapter06Review.independentPartition_statement
def independentPartition_statement : Prop := ∀ {n m : ℕ} (HA : Chapter05Review.E n → ℝ)
    (HB : Chapter05Review.E m → ℝ) (EA EB : ℝ),
  Chapter05Review.regularEnergy HA EA → Chapter05Review.regularEnergy HB EB →
  let μA := Chapter05Review.microRaw HA EA
  let μB := Chapter05Review.microRaw HB EB
  (μA.prod μB) univ = μA univ * μB univ
```

差异、假设及缺口：不将固定总能量的卷积partition误作独立固定能量乘积。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:9;MolecularDynamics/Chapter06/Statements.lean:17`。

### CH06-004 · §6.1.1 · 未编号结论 · 印刷p.215 / PDF236

原文（忠实转述）：At a differentiable interior entropy maximum under E_A+E_B=E, S_A'=S_B'.

```lean
-- MolecularDynamics.Chapter06Review.entropyEquilibrium_statement
def entropyEquilibrium_statement : Prop := ∀ (SA SB : ℝ → ℝ) (E e : ℝ),
  DifferentiableAt ℝ SA e → DifferentiableAt ℝ SB (E-e) →
  IsLocalMax (fun x ↦ SA x+SB (E-x)) e → deriv SA e = deriv SB (E-e)
```

差异、假设及缺口：固定总能量、一元内点极值；只陈述。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:11`。

### CH06-005 · §6.1.2 · 定义 · 印刷p.215 / PDF236

原文（忠实转述）：The inverse temperature is partial S/partial E, 1/T=S'(E).

```lean
-- MolecularDynamics.Chapter06Review.inverseTemperature
def inverseTemperature (S : ℝ → ℝ) (E : ℝ) : ℝ := deriv S E

-- MolecularDynamics.Chapter06Review.temperature
def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (inverseTemperature S E)⁻¹
```

差异、假设及缺口：真实导数；导数非零才可倒数。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:20;MolecularDynamics/Chapter06/ReviewDefinitions.lean:21`。

### CH06-006 · §6.1.2 · notation · 印刷p.216 / PDF237

原文（忠实转述）：The inverse thermal energy is beta=1/(kB T), (6.2).

```lean
-- MolecularDynamics.Chapter06Review.inverseThermal
def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹
```

差异、假设及缺口：正kB、正T。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:22`。

### CH06-007 · §6.1.2 · 未编号结论 · 印刷p.216 / PDF237

原文（忠实转述）：The large-bath entropy expansion produces a Boltzmann factor exp(-beta E_A) to first order.

```lean
-- MolecularDynamics.Chapter06Review.bathTaylor_statement
def bathTaylor_statement : Prop := ∀ (S : ℝ → ℝ) (E : ℝ), ContDiff ℝ 2 S →
  ∃ C δ : ℝ, 0 ≤ C ∧ 0 < δ ∧ ∀ e, |e| < δ →
    |S (E-e)-S E+deriv S E*e| ≤ C*e^2
```

差异、假设及缺口：局部C2 Taylor余项明确量化；一般热力学极限不在本次范围。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:14`。

### CH06-008 · §6.1.2 · 定义 · 印刷p.216 / PDF237

原文（忠实转述）：The canonical energy distribution is proportional to Z_A(E) exp(-beta E).

```lean
-- MolecularDynamics.Chapter06Review.canonicalEnergyDensity
def canonicalEnergyDensity (Z : ℝ → ℝ) (β E : ℝ) : ℝ :=
  Z E * Real.exp (-β * E) / (∫ e, Z e * Real.exp (-β * e))
```

差异、假设及缺口：实际能量积分归一化，正有限分母另需假设。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:23`。

### CH06-009 · §6.1.3 · 定义 · 印刷p.217 / PDF238

原文（忠实转述）：The entropy functional is -kB integral rho log rho.

```lean
-- MolecularDynamics.Chapter06Review.entropyFunctional
def entropyFunctional {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (kB : ℝ) (ρ : D → ℝ) : ℝ := -kB * ∫ x, ρ x * Real.log (ρ x) ∂ν
```

差异、假设及缺口：0log0按实数log总定义处理；可积性需明确。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:25`。

### CH06-010 · §6.1.3 · 未编号结论 · 印刷p.218 / PDF239

原文（忠实转述）：The constrained entropy first variation yields -(1+log rho)-lambda-beta H=0 and hence rho=exp(-1-lambda)exp(-beta H).

```lean
-- MolecularDynamics.Chapter06Review.entropyVariation_statement
def entropyVariation_statement : Prop := ∀ {n : ℕ} (H ρ : V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  (∀ ψ : V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    IsLocalMax (fun e ↦ entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β) 0) →
  ∀ x, -(1+Real.log (ρ x))-lambdaParam-β*H x=0 ∧
    ρ x=Real.exp (-1-lambdaParam)*Real.exp (-β*H x)

-- MolecularDynamics.Chapter06Review.entropyFirstVariation_statement
def entropyFirstVariation_statement : Prop := ∀ {n : ℕ} (H ρ : V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  ∀ ψ : V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    HasDerivAt (fun e ↦ entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β)
      (∫ x, (-(1+Real.log (ρ x))-lambdaParam-β*H x)*ψ x) 0
```

差异、假设及缺口：正rho、可积变分和约束；不假设Euler-Lagrange结论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:29;MolecularDynamics/Chapter06/Statements.lean:23`。

### CH06-011 · §6.1.3 · 定义 · 印刷p.218 / PDF239

原文（忠实转述）：The canonical Gibbs density is exp(-beta H)/Zcan, (6.3).

```lean
-- MolecularDynamics.Chapter06Review.canonicalDensity
def canonicalDensity {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ) (x : D) : ℝ := Real.exp (-β * H x) / (∫ z, Real.exp (-β * H z) ∂ν)

-- MolecularDynamics.textbookCanonicalPartition
noncomputable def textbookCanonicalPartition {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) : ℝ :=
  ∫ z, textbookHamiltonianGibbsWeight H β z
```

差异、假设及缺口：复用真实partition；不把密度定义计证明；同模块历史ledger CH06-DEP-026。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:29;MolecularDynamics/Chapter06/CanonicalTemperature.lean:15`。

### CH06-012 · §6.1.3 · 未编号结论 · 印刷p.218 / PDF239

原文（忠实转述）：A separable Hamiltonian has a configurational times Gaussian momentum partition.

```lean
-- MolecularDynamics.textbookLangevinCanonicalPartition_formula
theorem textbookLangevinCanonicalPartition_formula {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalPartition U β =
      textbookConfigurationPartition U β * (Real.sqrt (2 * Real.pi * β⁻¹)) ^ N

-- MolecularDynamics.Chapter06Review.partitionMass_statement
def partitionMass_statement : Prop := ∀ {n : ℕ} (m : V n) (U : V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∫ x : Phase n, Real.exp (-β*massHamiltonian m U x)) =
    (∫ q, Real.exp (-β*U q)) * ∏ i, Real.sqrt (2*Real.pi*m i/β)
```

差异、假设及缺口：已有完整单位质量/单位torus公式；一般各坐标质量公式仅陈述partitionMass_statement；同模块历史ledger CH06-DEP-151。

状态：**weakened**；位置：`MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean:52;MolecularDynamics/Chapter06/Statements.lean:36`。

### CH06-013 · §6.1.3 · 未编号结论 · 印刷p.218 / PDF239

原文（忠实转述）：Smooth potentials bounded below on a compact position torus give a positive finite partition.

```lean
-- MolecularDynamics.textbookLangevinCanonicalPartition_pos
theorem textbookLangevinCanonicalPartition_pos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : 0 < textbookLangevinCanonicalPartition U β

-- MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable
theorem textbookLangevinPeriodicGibbsWeight_integrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))
```

差异、假设及缺口：既有真实单位质量/周期模型；有限有界域若边界奇异不能仅用内部smooth；同模块历史ledger CH06-DEP-151。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean:74;MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean:37`。

### CH06-014 · §6.1.3 · 未编号结论 · 印刷p.219 / PDF240

原文（忠实转述）：A confining full-space potential with U(q)>=c norm(q)^p-C has a finite canonical partition.

```lean
-- MolecularDynamics.Chapter06Review.confiningPartition_statement
def confiningPartition_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ) (β c p C : ℝ),
  Continuous U → 0 < β → 0 < c → 0 < p →
  (∀ q, c*Real.rpow ‖q‖ p-C ≤ U q) → Integrable (fun q ↦ Real.exp (-β*U q))
```

差异、假设及缺口：c,p,beta正；需尾部可积估计，未新增证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:40`。

### CH06-015 · §6.1.4 · 定义 · 印刷p.220 / PDF241

原文（忠实转述）：Canonical observables may grow polynomially in momentum.

```lean
-- MolecularDynamics.Chapter06Review.polynomialObservable
def polynomialObservable {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C * (1 + ‖x.2‖) ^ r
```

差异、假设及缺口：q在紧torus；显式uniform polynomial bound。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:35`。

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

### CH06-017 · §6.1.4 · 未编号结论 · 印刷p.220 / PDF241

原文（忠实转述）：The normalized canonical average of one equals one.

```lean
-- MolecularDynamics.textbookCanonicalAverage_one
theorem textbookCanonicalAverage_one {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    textbookCanonicalAverage H β (fun _ ↦ 1) = 1
```

差异、假设及缺口：原partition可积即可；此前已验收；同模块历史ledger CH06-DEP-026。

状态：**proved**；位置：`MolecularDynamics/Chapter06/CanonicalTemperature.lean:32`。

### CH06-018 · §6.1.5 · 未编号结论 · 印刷p.221 / PDF242

原文（忠实转述）：Equipartition gives Av(p_i squared)=m_i/beta and Av(2K)=Nc/beta.

```lean
-- MolecularDynamics.Chapter06Review.equipartition_statement
def equipartition_statement : Prop := ∀ {n : ℕ} (m : V n) (U : V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  0 < (∫ q, Real.exp (-β*U q)) →
  (∀ i, (∫ x : Phase n, (x.2 i)^2 * canonicalDensity volume (massHamiltonian m U) β x) = m i/β) ∧
  (∫ x : Phase n, (∑ i, (x.2 i)^2/m i) * canonicalDensity volume (massHamiltonian m U) β x) = n/β
```

差异、假设及缺口：一般质量、真实可积Gibbs；既有Gaussian动量measure尚未打包此式。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:43`。

### CH06-019 · §6.1.5 · 未编号结论 · 印刷p.222 / PDF243

原文（忠实转述）：The configurational temperature is Av(norm(grad U)^2)/Av(laplacian U)=kB T, (6.5).

```lean
-- MolecularDynamics.Chapter06Review.configTemperature_statement
def configTemperature_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ) (β : ℝ),
  ContDiff ℝ 2 U → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q ^ 2 * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial (textbookConfigurationPartial U i) i q * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q * Real.exp (-β*U q))) →
  0 < (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) →
  (∫ q, (∑ i, textbookConfigurationPartial U i q ^ 2) * Real.exp (-β*U q)) /
    (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) = β⁻¹
```

差异、假设及缺口：质量/域及非零分母明确；Prop6.1不是此特定选G的完整包装。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:48`。

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

### CH06-021 · §6.1.5 · 未编号结论 · 印刷p.222 / PDF243

原文（忠实转述）：Integration by parts gives integral div(G exp(-beta H))=0 under the flux hypotheses.

```lean
-- MolecularDynamics.textbookCanonicalWeightedFlux_integral_divergence_eq_zero
theorem textbookCanonicalWeightedFlux_integral_divergence_eq_zero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    (∫ z, textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z) = 0

-- MolecularDynamics.textbookCanonicalAverage_divergence_eq_beta_lieDerivative
theorem textbookCanonicalAverage_divergence_eq_beta_lieDerivative {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    textbookCanonicalAverage H β (textbookDivergence G) =
      β * textbookCanonicalAverage H β (textbookLieDerivative G H)
```

差异、假设及缺口：真实全相空间两截断+DCT，未假设目标IBP；同模块历史ledger CH06-NUM-001,CH06-DEP-027。

状态：**proved**；位置：`MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean:237;MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean:333`。

### CH06-022 · §6.1.5 · 未编号结论 · 印刷p.223 / PDF244

原文（忠实转述）：G=(0,p) produces kinetic temperature; G=(grad U,0) gives configurational temperature; G=(q,0) gives a virial formula.

```lean
-- MolecularDynamics.Chapter06Review.temperatureChoices_statement
def temperatureChoices_statement : Prop := ∀ {n : ℕ} (m : V n) (U : V n → ℝ) (q p : V n),
  (∀ i, 0 < m i) → ContDiff ℝ 2 U →
  fderiv ℝ (massHamiltonian m U) (q,p) (0,p) = ∑ i, p i^2/m i ∧
  fderiv ℝ (massHamiltonian m U) (q,p) ((fun i ↦ textbookConfigurationPartial U i q),0) =
    ∑ i, textbookConfigurationPartial U i q ^ 2 ∧
  fderiv ℝ (massHamiltonian m U) (q,p) (q,0) = ∑ i, q i * textbookConfigurationPartial U i q
```

差异、假设及缺口：完整三个选项一般质量定义；不将G=(q,0)视为periodic。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:56`。

### CH06-023 · §6.1.5 · 未编号结论 · 印刷p.223 / PDF244

原文（忠实转述）：Opposite periodic boundary faces cancel for smooth periodic H and G.

```lean
-- MolecularDynamics.textbookConfigurationCube_integral_divergence_eq_zero
theorem textbookConfigurationCube_integral_divergence_eq_zero {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ ∞ (F i))
    (hp : ∀ i, textbookUnitPeriodicPotential (F i)) :
    (∫ q in textbookConfigurationCube Nc,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0
```

差异、假设及缺口：既有真实任意维周期cube散度积分；momentum无穷方向仍需尾部条件；同模块历史ledger CH06-NUM-004,CH06-DEP-028。

状态：**proved**；位置：`MolecularDynamics/Chapter06/BrownianDirichlet.lean:65`。

### CH06-024 · §6.2 · 未编号结论 · 印刷p.224 / PDF245

原文（忠实转述）：A constant-energy trajectory cannot sample canonical mass on other energies.

```lean
-- MolecularDynamics.Chapter06Review.energyObstruction_statement
def energyObstruction_statement : Prop := ∀ {n : ℕ} (H : V n → ℝ) (E : ℝ)
    (z : ℝ → V n) (μ : Measure (V n)), Continuous H →
  (∀ t, H (z t) = E) → 0 < μ {x | H x ≠ E} →
  (∀ t, z t ∉ {x | H x ≠ E}) ∧ μ {x | H x ≠ E} ≠ 0
```

差异、假设及缺口：给定能量守恒及canonical另一能量集合正测度；不假设采样失败为前提。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:62`。

### CH06-025 · §6.2.1 · 定义 · 印刷p.225 / PDF246

原文（忠实转述）：A random walk is X_n=dx sum_(k<n) J_k with X_0=0.

```lean
-- MolecularDynamics.Chapter06Review.randomWalk
def randomWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  dx * ∑ k ∈ Finset.range n, J k sample

-- MolecularDynamics.Chapter06Review.walkIncrement
def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  randomWalk J dx (n+1) sample - randomWalk J dx n sample
```

差异、假设及缺口：真实有限和；Rademacher独立同分布条件在结论列明。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:39;MolecularDynamics/Chapter06/ReviewDefinitions.lean:41`。

### CH06-026 · §6.2.1 · 未编号结论 · 印刷p.225 / PDF246

原文（忠实转述）：The recurrence X_(n+1)=X_n+dx J_n follows from the finite sum.

```lean
-- MolecularDynamics.Chapter06Review.walkRecurrence_statement
def walkRecurrence_statement : Prop := ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω),
  randomWalk J dx (n+1) sample = randomWalk J dx n sample + dx*J n sample
```

差异、假设及缺口：仅陈述，未做新证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:66`。

### CH06-027 · §6.2.1 · 未编号结论 · 印刷p.226 / PDF247

原文（忠实转述）：Independent centered unit-variance jumps give E X_n=0 and Var X_n=n dx squared.

```lean
-- MolecularDynamics.Chapter06Review.walkVariance_statement
def walkVariance_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ), rademacherJumps P J →
  (∫ sample, randomWalk J dx n sample ∂P) = 0 ∧ (∫ sample, randomWalk J dx n sample ^ 2 ∂P) = n*dx^2
```

差异、假设及缺口：随机变量L2与独立性，不假设二阶和公式。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:68`。

### CH06-028 · §6.2.1 · 定义 · 印刷p.226 / PDF247

原文（忠实转述）：The diffusive walk has jumps sqrt(dt) J_k and linear interpolation.

```lean
-- MolecularDynamics.Chapter06Review.diffusiveWalk
def diffusiveWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt : ℝ) : ℕ → Ω → ℝ :=
  randomWalk J (Real.sqrt dt)

-- MolecularDynamics.Chapter06Review.interpolatedWalk
def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (diffusiveWalk J dt (n+1) sample - diffusiveWalk J dt n sample)
```

差异、假设及缺口：dt正；n项有限和，不用书中含端点的多一项版本。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:43;MolecularDynamics/Chapter06/ReviewDefinitions.lean:45`。

### CH06-029 · §6.2.1 · 未编号结论 · 印刷p.226 / PDF247

原文（忠实转述）：On grid points E(Y_l-Y_k)=0 and Var(Y_l-Y_k)=(l-k)dt.

```lean
-- MolecularDynamics.Chapter06Review.walkGridMoments_statement
def walkGridMoments_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dt : ℝ) (k l : ℕ), rademacherJumps P J → 0 < dt → k ≤ l →
  (∫ sample, diffusiveWalk J dt l sample-diffusiveWalk J dt k sample ∂P) = 0 ∧
  (∫ sample, (diffusiveWalk J dt l sample-diffusiveWalk J dt k sample)^2 ∂P) = ((l : ℝ)-k)*dt
```

差异、假设及缺口：0<=k<=l；插值区间方差不与时间差完全相同。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:71`。

### CH06-030 · §6.2.1 · 未编号结论 · 印刷p.226 / PDF247

原文（忠实转述）：Diffusively rescaled independent Rademacher walks converge in law to the Wiener process.

```lean
-- MolecularDynamics.Chapter06Review.walkDiffusion_statement
def walkDiffusion_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (T : ℝ), rademacherJumps P J → 0 < T →
  ∃ μ : Measure (C(Icc (0 : ℝ) T, ℝ)), IsProbabilityMeasure μ ∧
    (∀ t : Icc (0 : ℝ) T, μ.map (fun w ↦ w t) = gaussianReal 0 t.1.toNNReal) ∧
    (∀ s t : Icc (0 : ℝ) T, s ≤ t →
      HasLaw (fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w t-w s) (gaussianReal 0 (t.1-s.1).toNNReal) μ) ∧
    (∀ k : ℕ, ∀ ts : Fin (k+1) → Icc (0 : ℝ) T, Monotone ts →
      iIndepFun (fun i : Fin k ↦ fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w (ts i.succ)-w (ts i.castSucc)) μ) ∧
    ∀ F : C(Icc (0 : ℝ) T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
      ∃ Y : ℕ → Ω → C(Icc (0 : ℝ) T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample t, Y K sample t = interpolatedWalk J (T/K) t sample) ∧
        Tendsto (fun K ↦ ∫ sample, F (Y K sample) ∂P) atTop (𝓝 (∫ w, F w ∂μ))
```

差异、假设及缺口：需Donsker函数空间不变性原理及tightness；不是CLT一维极限已证明。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter06/Statements.lean:75`。

### CH06-031 · §6.2.1 · 定义 · 印刷p.227 / PDF248

原文（忠实转述）：A vector Wiener process has independent centered Gaussian stationary increments and starts at zero.

```lean
-- MolecularDynamics.textbookIsWienerVector
structure textbookIsWienerVector {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) : Prop where
  gaussian : IsGaussianProcess (fun z : (_ : Fin Nc) × ℝ≥0 ↦ fun ω ↦ B z.2 ω z.1) P
  mean : ∀ i t, P[fun ω ↦ B t ω i] = 0
  covariance : ∀ i j s t, cov[fun ω ↦ B s ω i, fun ω ↦ B t ω j; P] =
    if i = j then ((min s t : ℝ≥0) : ℝ) else 0
  cont : ∀ᵐ ω ∂P, Continuous (fun t ↦ B t ω)
```

差异、假设及缺口：实际Mathlib IsPreBrownianReal+vectorGaussian法则；连续版本已有独立证明；同模块历史ledger CH06-NUM-006,CH06-DEP-010。

状态：**defined**；位置：`MolecularDynamics/Chapter06/WienerVectorSupport.lean:13`。

### CH06-032 · §6.2.1 · 未编号结论 · 印刷p.227 / PDF248

原文（忠实转述）：W(t)-W(s) has Gaussian law with variance abs(t-s), (6.7).

```lean
-- MolecularDynamics.textbookWienerIncrement_hasLaw
theorem textbookWienerIncrement_hasLaw {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P

-- MolecularDynamics.textbookWienerIncrement_independent
theorem textbookWienerIncrement_independent {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P

-- MolecularDynamics.Chapter06Review.wienerIncrement_statement
def wienerIncrement_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P → ∀ s t : ℝ≥0,
      HasLaw (fun sample ↦ W t sample-W s sample) (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P ∧
      (∫ sample, (W t sample-W s sample)^2 ∂P)=|((t : ℝ)-s)|
```

差异、假设及缺口：既有等距网格增量任意T/K与独立性；一般实时间版本通过Wiener定义映射，非独立再证明；同模块历史ledger CH06-NUM-002。

状态：**weakened**；位置：`MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:117;MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:139;MolecularDynamics/Chapter06/Statements.lean:90`。

### CH06-033 · §6.2.1 · 未编号结论 · 印刷p.227 / PDF248

原文（忠实转述）：Wiener paths have an almost surely continuous version.

```lean
-- MolecularDynamics.textbookWienerVectorContinuousPath_eval
theorem textbookWienerVectorContinuousPath_eval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample

-- MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable
theorem textbookWienerVectorContinuousPath_aemeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P

-- MolecularDynamics.Chapter06Review.wienerContinuousVersion_statement
def wienerContinuousVersion_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∃ V : ℝ≥0 → Ω → ℝ, (∀ t, W t =ᵐ[P] V t) ∧ ∀ᵐ sample ∂P, Continuous (fun t ↦ V t sample)
```

差异、假设及缺口：给定含AE连续性标准Wiener模型，真实路径值版本和可测性已验收；一般preBrownian法则的连续修改存在本次仅陈述，不将连续性前提当结论；同模块历史ledger CH06-DEP-014。

状态：**weakened**；位置：`MolecularDynamics/Chapter06/WienerVectorContinuousPath.lean:21;MolecularDynamics/Chapter06/WienerVectorContinuousPath.lean:28;MolecularDynamics/Chapter06/Statements.lean:87`。

### CH06-034 · §6.2.1 · 未编号结论 · 印刷p.227 / PDF248

原文（忠实转述）：Almost every Wiener path is nowhere differentiable.

```lean
-- MolecularDynamics.Chapter06Review.wienerNondifferentiable_statement
def wienerNondifferentiable_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  (∀ᵐ sample ∂P, Continuous (fun t : ℝ≥0 ↦ W t sample)) →
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t → ¬ DifferentiableAt ℝ (fun s ↦ W s.toNNReal sample) t
```

差异、假设及缺口：需Brownian路径振荡/几乎处处不可微分析，不新增理论。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter06/Statements.lean:94`。

### CH06-035 · §6.2.1 · 未编号结论 · 印刷p.227 / PDF248

原文（忠实转述）：Future Wiener increments are independent of the completed past filtration.

```lean
-- MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration
theorem textbookWienerVectorFuture_independent_completed_filtration
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion
```

差异、假设及缺口：复用真实完成filtration独立；Markov条件概率语义需说明；同模块历史ledger CH06-DEP-023。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinCompletedHistory.lean:46`。

### CH06-036 · §6.2.2 · 定义 · 印刷p.228 / PDF249

原文（忠实转述）：The Ito integral is the mean-square limit of left-point sums.

```lean
-- MolecularDynamics.Chapter06Review.itoLeftSum
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)

-- MolecularDynamics.Chapter06Review.isItoIntegral
def isItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)
```

差异、假设及缺口：实际概率测度/L2余差；存在性不由定义给出。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:54;MolecularDynamics/Chapter06/ReviewDefinitions.lean:57`。

### CH06-037 · §6.2.2 · 定义 · 印刷p.228 / PDF249

原文（忠实转述）：The Stratonovich integral uses temporal midpoint values in the sums.

```lean
-- MolecularDynamics.textbookWienerMidpointSum
noncomputable def textbookWienerMidpointSum (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun ω ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) ω *
    textbookWienerIncrement W T K k ω
```

差异、假设及缺口：真实W时间中点，不混同端点算术中点；同模块历史ledger CH06-CLM-003。

状态：**defined**；位置：`MolecularDynamics/Chapter06/WienerStratonovich.lean:58`。

### CH06-038 · §6.2.2 · 未编号结论 · 印刷p.228 / PDF249

原文（忠实转述）：The self Ito finite sum equals one half of W(T)^2-W(0)^2 minus the quadratic sum.

```lean
-- MolecularDynamics.textbookWienerSelfItoSum_identity
theorem textbookWienerSelfItoSum_identity {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ ω ∂P, 2 * textbookWienerSelfItoSum W T K ω =
      W T ω ^ 2 - textbookWienerQuadraticSum W T K ω
```

差异、假设及缺口：此前完整有限望远镜恒等；同模块历史ledger CH06-NUM-003,CH06-CLM-002,CH06-DEP-002。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerIntegration.lean:115`。

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

### CH06-040 · §6.2.2 · 未编号结论 · 印刷p.230 / PDF251

原文（忠实转述）：E increment=0, E increment squared=T/K, E increment fourth=3(T/K)^2.

```lean
-- MolecularDynamics.textbookCenteredGaussian_secondMoment
theorem textbookCenteredGaussian_secondMoment {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ ω, X ω ^ 2 ∂P) = (v : ℝ)

-- MolecularDynamics.textbookCenteredGaussian_fourthMoment
theorem textbookCenteredGaussian_fourthMoment {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ ω, X ω ^ 4 ∂P) = 3 * (v : ℝ) ^ 2
```

差异、假设及缺口：已有真实Gaussian矩；增量law前页映射；同模块历史ledger CH06-NUM-002。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:71;MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:79`。

### CH06-041 · §6.2.2 · 未编号结论 · 印刷p.230 / PDF251

原文（忠实转述）：The quadratic-sum mean-square error is 2T squared/K.

```lean
-- MolecularDynamics.textbookWienerQuadraticSum_meanSquareError
theorem textbookWienerQuadraticSum_meanSquareError {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ ω, (textbookWienerQuadraticSum W T K ω - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ)
```

差异、假设及缺口：K>0；原交叉项负号改为正常平方展开；同模块历史ledger CH06-NUM-002。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerQuadraticVariation.lean:187`。

### CH06-042 · §6.2.2 · 未编号结论 · 印刷p.230 / PDF251

原文（忠实转述）：Integral W dW=one half(W(T)^2-T).

```lean
-- MolecularDynamics.textbookWienerSelfItoIntegral_exists
theorem textbookWienerSelfItoIntegral_exists {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerSelfItoSum W T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ ω ∂P, Y ω = (W T ω ^ 2 - (T : ℝ)) / 2

-- MolecularDynamics.textbookWienerSelfItoSum_meanSquare_tendsto
theorem textbookWienerSelfItoSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerSelfItoSum W T K ω -
      (W T ω ^ 2 - (T : ℝ)) / 2) ^ 2 ∂P) atTop (𝓝 0)
```

差异、假设及缺口：实际L2见证与均方极限；不是一般Ito理论；同模块历史ledger CH06-NUM-003,CH06-CLM-002,CH06-DEP-002。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerIntegration.lean:179;MolecularDynamics/Chapter06/WienerIntegration.lean:170`。

### CH06-043 · §6.2.2 · 未编号结论 · 印刷p.230 / PDF251

原文（忠实转述）：Integral W circle dW=one half W(T)^2.

```lean
-- MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists
theorem textbookWienerSelfStratonovichIntegral_exists {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerMidpointSum W T K ω - Y ω) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ ω ∂P, Y ω = W T ω ^ 2 / 2

-- MolecularDynamics.textbookWienerMidpointSum_meanSquare_tendsto
theorem textbookWienerMidpointSum_meanSquare_tendsto {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ ω, (textbookWienerMidpointSum W T K ω - W T ω ^ 2 / 2) ^ 2 ∂P)
      atTop (𝓝 0)
```

差异、假设及缺口：真实时间中点余差整体均方估计，补足原单步O(sqrt dt)启发；同模块历史ledger CH06-CLM-003。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerStratonovich.lean:169;MolecularDynamics/Chapter06/WienerStratonovich.lean:161`。

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

### CH06-045 · §6.2.2 · 定义 · 印刷p.231 / PDF252

原文（忠实转述）：dY=g(t)dW, Y(0)=0 denotes the corresponding integral process, (6.8).

```lean
-- MolecularDynamics.Chapter06Review.deterministicIntegralProcess
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W (fun s _ ↦ g s) T (Y T)
```

差异、假设及缺口：对所有有限时间的真实Ito极限关系；共同AE版本需另外处理。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:60`。

### CH06-046 · §6.3 · 定义 · 印刷p.232 / PDF253

原文（忠实转述）：The biased walk uses increments a(X_n,t_n)dt+b(X_n,t_n)sqrt(dt)J_n, (6.9)-(6.10).

```lean
-- MolecularDynamics.Chapter06Review.biasedWalk
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample
```

差异、假设及缺口：递归初值真实有限离散过程；仅定义。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:63`。

### CH06-047 · §6.3 · 定义 · 印刷p.232 / PDF253

原文（忠实转述）：The scalar SDE means X(t)-X(0)=integral a ds+integral b dW, (6.11)-(6.14).

```lean
-- MolecularDynamics.Chapter06Review.scalarSDE
def scalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W (fun s sample ↦ b (X s sample) s) T
    (fun sample ↦ X T sample - x0 - ∫ s in 0..T, a (X s sample) s)
```

差异、假设及缺口：确定漂移时间积分及真实left-sum极限，不假设ODE导数存在。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:68`。

### CH06-048 · §6.3 · 定义 · 印刷p.233 / PDF254

原文（忠实转述）：A system of additive SDEs is dZ=a(Z)dt+B dW, (6.15)-(6.16).

```lean
-- MolecularDynamics.Chapter06Review.additiveSDE
def additiveSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → V r) (X : ℝ → Ω → V n)
    (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ) (x0 : V n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    X t sample = x0 + (∫ s in 0..t, a (X s sample)) + B.mulVec (W t sample - W 0 sample)
```

差异、假设及缺口：真实向量积分方程；连续轨道/过程可测条件分列。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:77`。

### CH06-049 · §6.3.1 · 未编号结论 · 印刷p.233 / PDF254

原文（忠实转述）：The scalar Ito formula adds one half phi'' b squared dt, (6.17).

```lean
-- MolecularDynamics.Chapter06Review.itoFormula_statement
def itoFormula_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2)
```

差异、假设及缺口：实际scalarSDE+局部C2/可积/适应条件；一般随机Ito链式法则未证。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:98`。

### CH06-050 · §6.3.1 · 未编号结论 · 印刷p.234 / PDF255

原文（忠实转述）：For phi(x,t), the Ito formula also includes phi_t dt, (6.18).

```lean
-- MolecularDynamics.Chapter06Review.itoTimeFormula_statement
def itoTimeFormula_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X a b x0 → ContDiff ℝ 2 φ →
  adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2)
```

差异、假设及缺口：原显示phi_t遗漏dt；忠实解释为时间积分项。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:107`。

### CH06-051 · §6.3.2 · 定义 · 印刷p.234 / PDF255

原文（忠实转述）：Ornstein-Uhlenbeck dynamics is dX=-gamma Xdt+sigma dW, gamma>0, (6.19).

```lean
-- MolecularDynamics.Chapter06Review.ouProcess
def ouProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  scalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0

-- MolecularDynamics.Chapter06Review.ouMean
def ouMean (γ x0 t : ℝ) : ℝ := Real.exp (-γ*t)*x0

-- MolecularDynamics.Chapter06Review.ouVariance
def ouVariance (γ σ t : ℝ) : ℝ := σ^2 * (1-Real.exp (-2*γ*t))/(2*γ)
```

差异、假设及缺口：真实scalar积分关系，方差非标准差。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:82;MolecularDynamics/Chapter06/ReviewDefinitions.lean:85;MolecularDynamics/Chapter06/ReviewDefinitions.lean:86`。

### CH06-052 · §6.3.2 · 未编号结论 · 印刷p.234 / PDF255

原文（忠实转述）：The OU solution is exp(-gamma t)X0+sigma exp(-gamma t) integral exp(gamma s)dW.

```lean
-- MolecularDynamics.Chapter06Review.ouIntegratingFactor_statement
def ouIntegratingFactor_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ouProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, isItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample
```

差异、假设及缺口：实际Ito极限、初值确定、gamma正；无新证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:116`。

### CH06-053 · §6.3.2 · 未编号结论 · 印刷p.235 / PDF256

原文（忠实转述）：The OU marginal law is Gaussian with mean exp(-gamma t)X0 and variance sigma squared(1-exp(-2gamma t))/(2gamma).

```lean
-- MolecularDynamics.Chapter06Review.ouLaw_statement
def ouLaw_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ouProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (ouMean γ x0 T) (ouVariance γ σ T).toNNReal) P
```

差异、假设及缺口：只单时刻law；不把独立标准Gaussian各时刻视作同一过程。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:121`。

### CH06-054 · §6.3.2 · 未编号结论 · 印刷p.235 / PDF256

原文（忠实转述）：With sigma squared=2gamma kB T m, OU laws converge to the Gibbs Gaussian.

```lean
-- MolecularDynamics.Chapter06Review.ouGibbsLimit_statement
def ouGibbsLimit_statement : Prop := ∀ (γ θ m x0 : ℝ), 0 < γ → 0 < θ → 0 < m →
  ∀ f : ℝ → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ x, f x ∂gaussianReal (ouMean γ x0 t)
      (ouVariance γ (Real.sqrt (2*γ*θ*m)) t).toNNReal) atTop
      (𝓝 (∫ x, f x ∂gaussianReal 0 (θ*m).toNNReal))
```

差异、假设及缺口：弱收敛有界连续test；正gamma、kB、T、m。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:125`。

### CH06-055 · §6.3.2 · 定义 · 印刷p.235 / PDF256

原文（忠实转述）：Vector momentum OU has drift -gamma p and independent noise sqrt(2gamma kB T m_i), (6.20)-(6.21).

```lean
-- MolecularDynamics.Chapter06Review.momentumOU
def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → V n) (m : V n) (γ θ : ℝ) (p0 : V n) : Prop :=
  ∀ i, ouProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)
```

差异、假设及缺口：一般对角质量；仅完整积分关系。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:91`。

### CH06-056 · §6.3.3 · 定义 · 印刷p.236 / PDF257

原文（忠实转述）：The finite oscillator bath Hamiltonian includes p_i squared/(2mu_i) and (q_i-Q)^2/(2k).

```lean
-- MolecularDynamics.Chapter06Review.bathHamiltonian
def bathHamiltonian {k : ℕ} (μ : V k) (U : ℝ → ℝ) (Q P : ℝ) (q p : V k) : ℝ :=
  P^2/2 + (∑ i, (p i)^2/(2*μ i)) + U Q + (∑ i, (q i-Q)^2)/(2*k)
```

差异、假设及缺口：正文推导用模型，区别于独立介绍数值例子。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:94`。

### CH06-057 · §6.3.3 · 未编号结论 · 印刷p.236 / PDF257

原文（忠实转述）：The bath Hamiltonian gives the displayed four coupled Hamilton equations, (6.22)-(6.25).

```lean
-- MolecularDynamics.Chapter06Review.bathHamiltonEquations_statement
def bathHamiltonEquations_statement : Prop := ∀ {k : ℕ} (μ : V k) (U : ℝ → ℝ)
    (Q P : ℝ) (q p : V k), 0 < k → (∀ i, 0 < μ i) → DifferentiableAt ℝ U Q →
  deriv (fun z ↦ bathHamiltonian μ U Q z q p) P = P ∧
  -deriv (fun z ↦ bathHamiltonian μ U z P q p) Q = -deriv U Q-(∑ i : Fin k, (Q - q i))/(k : ℝ) ∧
  (∀ i, fderiv ℝ (fun v ↦ bathHamiltonian μ U Q P q v) p (Pi.single i 1) = p i/μ i) ∧
  (∀ i, -fderiv ℝ (fun v ↦ bathHamiltonian μ U Q P v p) q (Pi.single i 1) = (Q-q i)/(k : ℝ))
```

差异、假设及缺口：真实有限坐标导数；k正、mu正。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:130`。

### CH06-058 · §6.3.3 · 未编号结论 · 印刷p.236 / PDF257

原文（忠实转述）：The forced linear bath oscillator has the cosine-sine convolution solution, (6.26).

```lean
-- MolecularDynamics.Chapter06Review.bathOscillator_statement
def bathOscillator_statement : Prop := ∀ (Q q : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 2 q → Continuous Q → 0 < Ω → 0 ≤ t →
  (∀ s ∈ Icc 0 t, deriv (deriv q) s = Ω^2*(Q s-q s)) →
  q t = Real.cos (Ω*t)*q 0 + Ω⁻¹*Real.sin (Ω*t)*deriv q 0 +
    ∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s
```

差异、假设及缺口：Omega=(k mu)^-1/2，真实C2强解与有限区间。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:136`。

### CH06-059 · §6.3.3 · 未编号结论 · 印刷p.237 / PDF258

原文（忠实转述）：Integration by parts rewrites the convolution using cos and the distinguished momentum.

```lean
-- MolecularDynamics.Chapter06Review.bathConvolutionIBP_statement
def bathConvolutionIBP_statement : Prop := ∀ (Q P : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 1 Q → (∀ s, deriv Q s=P s) → 0 ≤ t →
  (∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s) = Q t-Real.cos (Ω*t)*Q 0 -
    ∫ s in 0..t, Real.cos (Ω*(t-s))*P s
```

差异、假设及缺口：Q'=P、Omega非零；实际区间积分。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:141`。

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

### CH06-061 · §6.3.3 · 未编号结论 · 印刷p.237 / PDF258

原文（忠实转述）：The reduced momentum equation is P'=-U'(Q)+f(t)-integral memory(t-s)P(s)ds, (6.29).

```lean
-- MolecularDynamics.Chapter06Review.bathReduction_statement
def bathReduction_statement : Prop := ∀ {k : ℕ} (μ : V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, memoryKernel μ (t-s)*P s

-- MolecularDynamics.Chapter06Review.bathReductionPrinted_statement
def bathReductionPrinted_statement : Prop := ∀ {k : ℕ} (μ : V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+bathForcePrinted μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, memoryKernel μ (t-s)*P s
```

差异、假设及缺口：保留原字面负f与代入一致版；未把经验噪声极限当严格结论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:145;MolecularDynamics/Chapter06/Statements.lean:153`。

### CH06-062 · §6.3.3 · 定义 · 印刷p.238 / PDF259

原文（忠实转述）：Langevin dynamics combines Hamiltonian drift, friction and Wiener forcing, (6.30)-(6.33).

```lean
-- MolecularDynamics.Chapter06Review.langevinMassSDE
def langevinMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (m : V n)
    (U : V n → ℝ) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹ * (X s sample).2 i) ∧
    (X t sample).2 = x0.2 + (∫ s in 0..t, fun i ↦
      -textbookConfigurationPartial U i (X s sample).1 - γ*(X s sample).2 i) +
      fun i ↦ Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

-- MolecularDynamics.textbookLangevinIntegralSolution
def textbookLangevinIntegralSolution {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ)
    (γ σ T : ℝ) (x : textbookLangevinPhase Nc) (W q p : ℝ → (Fin Nc → ℝ)) : Prop :=
  ContinuousOn q (Icc 0 T) ∧ ContinuousOn p (Icc 0 T) ∧ ContinuousOn W (Icc 0 T) ∧
    W 0 = 0 ∧
    (∀ t ∈ Icc 0 T, q t = x.1 + ∫ s in 0..t, p s) ∧
    (∀ t ∈ Icc 0 T, p t = x.2 +
      (∫ s in 0..t, textbookPotentialForce U (q s) - γ • p s) + σ • W t)
```

差异、假设及缺口：一般质量完整积分式；复用单位质量模型，两者区分；同模块历史ledger CH06-NUM-006,CH06-DEP-005,CH06-DEP-012。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:103;MolecularDynamics/Chapter06/LangevinNoiseStability.lean:12`。

### CH06-063 · §6.3.3 · 定义 · 印刷p.239 / PDF260

原文（忠实转述）：Position-dependent matrix friction uses Gamma Gamma transpose and sqrt(2kB T)M^(1/2)Gamma noise, (6.34)-(6.35).

```lean
-- MolecularDynamics.Chapter06Review.variableFrictionSDE
def variableFrictionSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → V r) (X : ℝ → Ω → Phase n) (m : V n) (U : V n → ℝ)
    (Γ : V n → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ) (x0 : Phase n) : Prop :=
  (∀ᵐ sample ∂P, ∀ t ∈ Ici 0, (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹*(X s sample).2 i)) ∧
  ∀ i, ∀ T : ℝ, 0 ≤ T →
    Tendsto (fun K : ℕ ↦ ∫ sample,
      ((∑ j : Fin r, itoLeftSum (fun t sample ↦ W t sample j)
        (fun t sample ↦ Real.sqrt (2*θ*m i)*Γ (X t sample).1 i j) T K sample) -
        ((X T sample).2 i-x0.2 i - ∫ s in 0..T,
          -textbookConfigurationPartial U i (X s sample).1 -
            ((Γ (X s sample).1 * (Γ (X s sample).1).transpose).mulVec (X s sample).2) i))^2 ∂P)
      atTop (𝓝 0)
```

差异、假设及缺口：忠实质量乘法次序；一般Gamma不自动满足目标Gibbs，需要交换/涨落耗散条件。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:111`。

### CH06-064 · §6.3.3 · 未编号结论 · 印刷p.239 / PDF260

原文（忠实转述）：The actual Langevin process has the Markov property.

```lean
-- MolecularDynamics.textbookLangevinPeriodicTransitionKernel_add
theorem textbookLangevinPeriodicTransitionKernel_add {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (S T : ℝ≥0) :
    textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ (S + T) =
      textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ T ∘ₖ
        textbookLangevinPeriodicTransitionKernel B P U hU hP L hF γ σ S

-- MolecularDynamics.textbookLangevinPeriodicGlobalRandomPhase_condDistrib_completed_history_of_periodic
theorem textbookLangevinPeriodicGlobalRandomPhase_condDistrib_completed_history_of_periodic
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (x : textbookLangevinPeriodicPhase Nc) :
    letI : IsProbabilityMeasure P
```

差异、假设及缺口：复用单位质量/单位周期实际kernel CK及完成history条件期望；原一般质量/variable friction未扩展；同模块历史ledger CH06-DEP-021,CH06-DEP-024。

状态：**weakened**；位置：`MolecularDynamics/Chapter06/LangevinTransitionSemigroup.lean:130;MolecularDynamics/Chapter06/LangevinCompletedMarkov.lean:284`。

### CH06-065 · §6.3.4 · 定义 · 印刷p.240 / PDF261

原文（忠实转述）：Neglecting inertia yields Brownian drift -gamma^-1 M^-1 grad U and noise sqrt(2kB T/gamma)M^-1/2, (6.36).

```lean
-- MolecularDynamics.Chapter06Review.brownianMassSDE
def brownianMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W q : ℝ → Ω → V n) (m : V n) (U : V n → ℝ) (γ θ : ℝ) (q0 : V n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ q t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    q t sample = q0 + (∫ s in 0..t, fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample)) +
      fun i ↦ Real.sqrt (2*θ/(γ*m i))*(W t sample i-W 0 sample i)

-- MolecularDynamics.textbookBrownianIntegralSolution
def textbookBrownianIntegralSolution (T : ℝ) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) : Prop :=
  ContinuousOn q (Icc 0 T) ∧ ContinuousOn W (Icc 0 T) ∧
    ∀ t ∈ Icc 0 T, q t = x + (∫ s in 0..t, textbookBrownianSDEDrift m U (q s)) +
      textbookBrownianSDENoise m β (W t - W 0)

include hm hU hPU hβ in
```

差异、假设及缺口：代数消元定义；严谨Kramers-Smoluchowski极限不宣称已证；同模块历史ledger CH06-DEP-073。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:123;MolecularDynamics/Chapter06/BrownianPathSolution.lean:21`。

### CH06-066 · §6.3.4 · 未编号结论 · 印刷p.240 / PDF261

原文（忠实转述）：The scaled Langevin position converges to overdamped Brownian dynamics in the large-friction limit.

```lean
-- MolecularDynamics.Chapter06Review.overdampedLimit_statement
def overdampedLimit_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → V n) (U : V n → ℝ) (β : ℝ)
    (x0 : Phase n) (X : ℝ → ℝ → Ω → Phase n) (q : ℝ → Ω → V n),
  textbookIsWienerVector B P → ContDiff ℝ ∞ U → textbookUnitPeriodicPotential U → 0 < β →
  (∀ γ : ℝ, 0 < γ → langevinMassSDE P (fun t sample ↦ B t.toNNReal sample) (X γ)
    (fun _ ↦ 1) U γ β⁻¹ x0) →
  brownianMassSDE P (fun t sample ↦ B t.toNNReal sample) q (fun _ ↦ 1) U 1 β⁻¹ x0.1 →
  ∀ T : ℝ, 0 < T → ∀ f : V n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun γ : ℝ ↦ ∫ sample, f (X γ (γ*T) sample).1 ∂P) atTop
      (𝓝 (∫ sample, f (q T sample) ∂P))
```

差异、假设及缺口：需明确时间重标度、初值/质量与随机奇异摄动紧性；书只作形式消元。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter06/Statements.lean:161`。

### CH06-067 · §6.3.5 · 定义 · 印刷p.240 / PDF261

原文（忠实转述）：The scalar generator is a phi'+one half b squared phi'', (6.38).

```lean
-- MolecularDynamics.Chapter06Review.scalarGenerator
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x
```

差异、假设及缺口：实际一二阶导数；形式differential expression与闭generator域分开。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:128`。

### CH06-068 · §6.3.5 · 未编号结论 · 印刷p.240 / PDF261

原文（忠实转述）：The derivative of E phi(X_t) equals E L phi(X_t), (6.37).

```lean
-- MolecularDynamics.Chapter06Review.generatorExpectation_statement
def generatorExpectation_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b φ : ℝ → ℝ) (x0 : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 2 φ → adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample)) →
  (∀ t : ℝ, 0 ≤ t → Integrable (fun sample ↦ scalarGenerator a b φ (X t sample)) P) →
  ContinuousOn (fun t ↦ ∫ sample, scalarGenerator a b φ (X t sample) ∂P) (Ici 0) →
  ∀ t : ℝ, 0 < t → HasDerivAt (fun s ↦ ∫ sample, φ (X s sample) ∂P)
    (∫ sample, scalarGenerator a b φ (X t sample) ∂P) t
```

差异、假设及缺口：实际SDE+适应可积支配条件；已有特定Brownian/Langevin模型依赖另见证据登记。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:171`。

### CH06-069 · §6.3.6 · 定义 · 印刷p.241 / PDF262

原文（忠实转述）：C-infinity polynomial-growth functions obey a global polynomial bound.

```lean
-- MolecularDynamics.Chapter06Review.polynomialSmooth
def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r
```

差异、假设及缺口：原只约束函数不约束全部导数；不据此自动消边界。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:131`。

### CH06-070 · §6.3.6 · 未编号结论 · 印刷p.241 / PDF262

原文（忠实转述）：Exponentially decaying density and appropriate derivative tails permit the drift integration by parts.

```lean
-- MolecularDynamics.Chapter06Review.fpDriftAdjoint_statement
def fpDriftAdjoint_statement : Prop := ∀ (a ρ φ : ℝ → ℝ),
  ContDiff ℝ 1 a → ContDiff ℝ 1 ρ → ContDiff ℝ 1 φ →
  HasCompactSupport φ → (∫ x, a x*deriv φ x*ρ x) = ∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x)
```

差异、假设及缺口：显式实际乘积可积及边界极限；原C1rho不足二阶PDE。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:179`。

### CH06-071 · §6.3.6 · 未编号结论 · 印刷p.242 / PDF263

原文（忠实转述）：Two integrations by parts give the scalar Fokker-Planck adjoint and density PDE.

```lean
-- MolecularDynamics.Chapter06Review.fpEquation_statement
def fpEquation_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∀ φ : ℝ → ℝ, ContDiff ℝ ∞ φ → HasCompactSupport φ → ∀ t : ℝ, 0 < t →
    HasDerivAt (fun s ↦ ∫ x, φ x*ρ s x) (∫ x, scalarGenerator a b φ x*ρ t x) t) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=scalarForward a b (ρ t) x

-- MolecularDynamics.Chapter06Review.fpAdjoint_statement
def fpAdjoint_statement : Prop := ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ →
  HasCompactSupport φ → (∫ x, scalarGenerator a b φ x*ρ x) = ∫ x, φ x*scalarForward a b ρ x
```

差异、假设及缺口：明确C2rho和所有必要尾部；既有过程特例不能当一般FP理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:185;MolecularDynamics/Chapter06/Statements.lean:182`。

### CH06-072 · §6.3.6 · 定义 · 印刷p.242 / PDF263

原文（忠实转述）：The scalar forward operator is -(a rho)'+one half (b squared rho)'', called Kolmogorov operator.

```lean
-- MolecularDynamics.Chapter06Review.scalarForward
def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2
```

差异、假设及缺口：真实deriv表达；flat形式伴随不同于Gibbs加权伴随。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:129`。

### CH06-073 · §6.3.6 · 未编号结论 · 印刷p.242 / PDF263

原文（忠实转述）：Zero noise reduces the generator to the Lie derivative and its forward operator to Liouville.

```lean
-- MolecularDynamics.Chapter06Review.zeroNoise_statement
def zeroNoise_statement : Prop := ∀ (a f ρ : ℝ → ℝ) (x : ℝ),
  scalarGenerator a (fun _ ↦ 0) f x=a x*deriv f x ∧
    scalarForward a (fun _ ↦ 0) ρ x = -deriv (fun z ↦ a z*ρ z) x
```

差异、假设及缺口：逐点代数表达；不构造一般PDE解。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:193`。

### CH06-074 · §6.3.7 · 定义 · 印刷p.243 / PDF264

原文（忠实转述）：The vector generator has diffusion one half trace(B transpose Hess(phi)B).

```lean
-- MolecularDynamics.Chapter06Review.vectorGenerator
def vectorGenerator {n r : ℕ} (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ)
    (f : V n → ℝ) (x : V n) : ℝ := fderiv ℝ f x (a x) + vectorDiffusion B f x/2

-- MolecularDynamics.Chapter06Review.vectorForward
def vectorForward {n r : ℕ} (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ)
    (ρ : V n → ℝ) (x : V n) : ℝ :=
  -(∑ i, textbookConfigurationPartial (fun z ↦ a z i*ρ z) i x) + vectorDiffusion B ρ x/2
```

差异、假设及缺口：B常量，实际有限和二阶导数；multiplicative B需导数作用于B Btranspose rho。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:136;MolecularDynamics/Chapter06/ReviewDefinitions.lean:138`。

### CH06-075 · §6.3.7 · 未编号结论 · 印刷p.243 / PDF264

原文（忠实转述）：The vector Ito formula has trace diffusion and yields the vector Fokker-Planck equation.

```lean
-- MolecularDynamics.Chapter06Review.vectorIto_statement
def vectorIto_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → V r) (X : ℝ → Ω → V n)
    (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ) (x0 : V n) (φ : V n → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P → additiveSDE P W X a B x0 → ContDiff ℝ 2 φ →
  (∀ j, adaptedSquareIntegrand P (fun t sample ↦ W t sample j)
    (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j))) →
  ∀ T : ℝ, 0 ≤ T → Tendsto (fun K : ℕ ↦ ∫ sample,
    ((∑ j : Fin r, itoLeftSum (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T K sample) -
      (φ (X T sample)-φ x0 - ∫ s in 0..T, vectorGenerator a B φ (X s sample)))^2 ∂P) atTop (𝓝 0)

-- MolecularDynamics.Chapter06Review.vectorFP_statement
def vectorFP_statement : Prop := ∀ {n r : ℕ} (a : V n → V n)
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : ℝ → V n → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 (Function.uncurry ρ) →
  (∀ φ : V n → ℝ, ContDiff ℝ ∞ φ → HasCompactSupport φ → ∀ t : ℝ, 0 < t →
    (∫ x, φ x*deriv (fun s ↦ ρ s x) t) = ∫ x, vectorGenerator a B φ x*ρ t x) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x
```

差异、假设及缺口：实际additiveSDE/L2随机积分；原dW_i dW_j=dt delta仅启发notation。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:196;MolecularDynamics/Chapter06/Statements.lean:206`。

### CH06-076 · §6.3.7 · 未编号结论 · 印刷p.243 / PDF264

原文（忠实转述）：trace(B transpose Hess(phi)B)=sum_ij (B Btranspose)_ij partial_ij phi.

```lean
-- MolecularDynamics.Chapter06Review.diffusionTrace_statement
def diffusionTrace_statement : Prop := ∀ {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ)
    (H : Matrix (Fin n) (Fin n) ℝ),
  Matrix.trace (B.transpose*H*B)=∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j*H i j
```

差异、假设及缺口：有限矩阵表达；不做新代数证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:212`。

### CH06-077 · §6.3.8 · 定义 · 印刷p.244 / PDF265

原文（忠实转述）：The Langevin Kolmogorov operator is -div_q(M^-1 p rho)+div_p((grad U+gamma p)rho)+gamma/beta sum m_i partial_pi²rho, (6.42).

```lean
-- MolecularDynamics.Chapter06Review.langevinMassForward
def langevinMassForward {n : ℕ} (m : V n) (U : V n → ℝ) (γ β : ℝ)
    (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))

-- MolecularDynamics.textbookLangevinForwardDifferentialOperator
def textbookLangevinForwardDifferentialOperator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ : ℝ) (f : textbookLangevinPhase N → ℝ)
    (z : textbookLangevinPhase N) : ℝ :=
  -deriv (fun t : ℝ ↦ f (z + t • textbookLangevinDrift U γ z)) 0 -
    textbookLangevinPhaseDivergence (textbookLangevinDrift U γ) z * f z +
    σ ^ 2 / 2 * ∑ i : Fin N,
      deriv (deriv (fun t : ℝ ↦ f (z + t • ((0 : Fin N → ℝ), Pi.single i 1)))) 0
```

差异、假设及缺口：一般质量表达与已有单位质量表达映射，不混同overdamped逆质量；同模块历史ledger CH06-DEP-149。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:141;MolecularDynamics/Chapter06/LangevinGibbsStationaryExpression.lean:46`。

### CH06-078 · §6.4.1 · 定义 · 印刷p.245 / PDF266

原文（忠实转述）：A finite Markov transition matrix has nonnegative rows summing to one.

```lean
-- MolecularDynamics.Chapter06Review.stochasticMatrix
def stochasticMatrix {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  (∀ i j, 0 ≤ PiMark i j) ∧ ∀ i, ∑ j, PiMark i j = 1

-- MolecularDynamics.Chapter06Review.finiteDistribution
def finiteDistribution {k : ℕ} (ψ : V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1
```

差异、假设及缺口：原distribution nonzero应为nonnegative；严格正初值不必要。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:146;MolecularDynamics/Chapter06/ReviewDefinitions.lean:148`。

### CH06-079 · §6.4.1 · 定义 · 印刷p.245 / PDF266

原文（忠实转述）：A distribution evolves by row-vector multiplication psi_(n+1)=psi_n Pi.

```lean
-- MolecularDynamics.Chapter06Review.finiteEvolution
def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : V k) (n : ℕ) : V k :=
  Matrix.vecMul ψ (PiMark^n)
```

差异、假设及缺口：方向i到j；原pi(l)解释颠倒，遵循row convention。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:149`。

### CH06-080 · §6.4.1 · 定义 · 印刷p.245 / PDF266

原文（忠实转述）：A state period is the gcd of positive return times; aperiodicity means period one.

```lean
-- MolecularDynamics.Chapter06Review.returnTimes
def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}

-- MolecularDynamics.Chapter06Review.period
def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ returnTimes PiMark i, d ∣ n}

-- MolecularDynamics.Chapter06Review.aperiodic
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, period PiMark i = 1
```

差异、假设及缺口：正整数时间，排除l=0；用Nat.gcd全返回集合。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:151;MolecularDynamics/Chapter06/ReviewDefinitions.lean:153;MolecularDynamics/Chapter06/ReviewDefinitions.lean:155`。

### CH06-081 · §6.4.1 · 定义 · 印刷p.246 / PDF267

原文（忠实转述）：Irreducibility means every pair communicates; a stationary distribution is a left eigenvector for eigenvalue one.

```lean
-- MolecularDynamics.Chapter06Review.irreducible
def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j

-- MolecularDynamics.Chapter06Review.finiteInvariant
def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : V k) : Prop :=
  finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ
```

差异、假设及缺口：同向可达双向自动量化，不把无向连接当strong connectivity。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:156;MolecularDynamics/Chapter06/ReviewDefinitions.lean:157`。

### CH06-082 · §6.4.1 · 未编号结论 · 印刷p.246 / PDF267

原文（忠实转述）：A finite irreducible aperiodic chain has a unique stationary probability and all initial distributions converge to it.

```lean
-- MolecularDynamics.Chapter06Review.finiteErgodicity_statement
def finiteErgodicity_statement : Prop := ∀ {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ),
  0 < k → stochasticMatrix PiMark → irreducible PiMark → aperiodic PiMark →
  ∃ ψ : V k, finiteInvariant PiMark ψ ∧ (∀ χ, finiteInvariant PiMark χ → χ=ψ) ∧
    ∀ ψ0 : V k, finiteDistribution ψ0 → Tendsto (finiteEvolution PiMark ψ0) atTop (𝓝 ψ)
```

差异、假设及缺口：非空有限状态、真实Pi^n；不新增Perron-Frobenius理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:215`。

### CH06-083 · §6.4.2 · 定义 · 印刷p.247 / PDF268

原文（忠实转述）：An additive diffusion on a torus-cylinder has generator b0 dot grad+one half trace(B transpose Hess B).

```lean
-- MolecularDynamics.Chapter06Review.additiveSDE
def additiveSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → V r) (X : ℝ → Ω → V n)
    (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ) (x0 : V n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    X t sample = x0 + (∫ s in 0..t, a (X s sample)) + B.mulVec (W t sample - W 0 sample)

-- MolecularDynamics.Chapter06Review.vectorGenerator
def vectorGenerator {n r : ℕ} (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ)
    (f : V n → ℝ) (x : V n) : ℝ := fderiv ℝ f x (a x) + vectorDiffusion B f x/2
```

差异、假设及缺口：局部坐标与周期lift；原forward式Hessian phi应为rho。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:77;MolecularDynamics/Chapter06/ReviewDefinitions.lean:136`。

### CH06-084 · §6.4.2 · 未编号结论 · 印刷p.247 / PDF268

原文（忠实转述）：A stationary density solves L* rho=0 and yields an invariant probability when the actual evolution is uniquely identified.

```lean
-- MolecularDynamics.Chapter06Review.stationaryInvariant_statement
def stationaryInvariant_statement : Prop := ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ kernelAverage K f s.toNNReal x)
      (L (fun y ↦ kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  invariantKernel K μ
```

差异、假设及缺口：弱stationarity不自动推出过程不变，需semigroup与generator域桥接。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:219`。

### CH06-085 · §6.4.2 · 未编号结论 · 印刷p.248 / PDF269

原文（忠实转述）：Canonical mixing means evolved averages tend to Gibbs averages, including point initial laws.

```lean
-- MolecularDynamics.Chapter06Review.canonicalMixing_statement
def canonicalMixing_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ → ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ))
```

差异、假设及缺口：真实Markovkernel、任意初值/合适test；非仅形式exp。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:228`。

### CH06-086 · §6.4.2 · 未编号结论 · 印刷p.248 / PDF269

原文（忠实转述）：OU time-dependent density is a normalized Gaussian with the displayed mean and variance, (6.44)-(6.45).

```lean
-- MolecularDynamics.Chapter06Review.ouLaw_statement
def ouLaw_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ouProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (ouMean γ x0 T) (ouVariance γ σ T).toNNReal) P

-- MolecularDynamics.Chapter06Review.ouDensityPrinted
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-ouMean γ x0 t)^2/(2*ouVariance γ σ t))

-- MolecularDynamics.Chapter06Review.ouDensity
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*ouVariance γ σ t)
```

差异、假设及缺口：原6.44遗漏Gaussian归一因子；字面与标准密度分列。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:121;MolecularDynamics/Chapter06/ReviewDefinitions.lean:87;MolecularDynamics/Chapter06/ReviewDefinitions.lean:89`。

### CH06-087 · §6.4.3 · 定义 · 印刷p.249 / PDF270

原文（忠实转述）：For Brownian dynamics M=I,gamma=1, Lf=-grad U dot grad f+beta^-1 laplacian f.

```lean
-- MolecularDynamics.textbookBrownianGenerator
noncomputable def textbookBrownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

差异、假设及缺口：已有实际一般逆质量版本，取unit即可；同模块历史ledger CH06-NUM-004,CH06-DEP-028。

状态：**defined**；位置：`MolecularDynamics/Chapter06/BrownianDirichlet.lean:31`。

### CH06-088 · §6.4.3 · 定义 · 印刷p.249 / PDF270

原文（忠实转述）：The Gibbs weighted inner product is integral f g exp(-beta U).

```lean
-- MolecularDynamics.textbookConfigurationInner
noncomputable def textbookConfigurationInner {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ *
    ∫ q in textbookConfigurationCube Nc, f q * g q * textbookConfigurationGibbsWeight U β q
```

差异、假设及缺口：未归一cube内积与真实normalizedtorusL2只差partition系数；同模块历史ledger CH06-NUM-004,CH06-DEP-028。

状态：**defined**；位置：`MolecularDynamics/Chapter06/BrownianDirichlet.lean:276`。

### CH06-089 · §6.4.3 · 未编号结论 · 印刷p.250 / PDF271

原文（忠实转述）：Brownian integration by parts gives the weighted Dirichlet identity and symmetry.

```lean
-- MolecularDynamics.textbookBrownianGenerator_inner_dirichlet
theorem textbookBrownianGenerator_inner_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β g) =
      -β⁻¹ * (textbookConfigurationPartition U β)⁻¹ *
        ∫ q in textbookConfigurationCube Nc,
          textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q

-- MolecularDynamics.textbookBrownianGenerator_inner_symmetric
theorem textbookBrownianGenerator_inner_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β g) =
      textbookConfigurationInner U β (textbookBrownianGenerator m U β f) g
```

差异、假设及缺口：完整周期lift/任意正质量；形式对称区别于C2核心已自伴；同模块历史ledger CH06-NUM-004,CH06-DEP-028。

状态：**proved**；位置：`MolecularDynamics/Chapter06/BrownianDirichlet.lean:303;MolecularDynamics/Chapter06/BrownianDirichlet.lean:318`。

### CH06-090 · §6.4.3 · 未编号结论 · 印刷p.250 / PDF271

原文（忠实转述）：The Brownian generator has nonpositive quadratic form and nonpositive real eigenvalues.

```lean
-- MolecularDynamics.textbookBrownianGenerator_inner_nonpos
theorem textbookBrownianGenerator_inner_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β f) ≤ 0

-- MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos
theorem textbookBrownianGenerator_real_eigenvalue_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0
```

差异、假设及缺口：常数在核，所以原negative definite应nonpositive；同模块历史ledger CH06-NUM-004,CH06-DEP-028。

状态：**proved**；位置：`MolecularDynamics/Chapter06/BrownianDirichlet.lean:344;MolecularDynamics/Chapter06/BrownianDirichlet.lean:396`。

### CH06-091 · §6.4.3 · 未编号结论 · 印刷p.250 / PDF271

原文（忠实转述）：The Gibbs Hilbert generator has a self-adjoint closed realization.

```lean
-- MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint
theorem textbookBrownianGibbsComplexOperator_isSelfAdjoint :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ)
```

差异、假设及缺口：复用已验收实际complex闭graph；不是原C2compact核心本身自伴；同模块历史ledger CH06-DEP-066。

状态：**proved**；位置：`MolecularDynamics/Chapter06/BrownianGibbsComplexOperator.lean:245`。

### CH06-092 · §6.4.3 · 未编号结论 · 印刷p.250 / PDF271

原文（忠实转述）：The closed Brownian generator has compact resolvent and isolated discrete real spectrum.

```lean
-- MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact
theorem textbookBrownianGibbsComplexResolvent_isCompact :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ)

-- MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_countable
theorem textbookBrownianGibbsGeneratorComplexSpectrum_countable :
    (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable

-- MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_isolated
theorem textbookBrownianGibbsGeneratorComplexSpectrum_isolated (z : ℂ)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) :
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ = {z}
```

差异、假设及缺口：真实normalizedGibbs L2/复谱；182文件内已有接受，不重证明；同模块历史ledger CH06-DEP-067,CH06-DEP-068。

状态：**proved**；位置：`MolecularDynamics/Chapter06/BrownianGibbsComplexResolvent.lean:81;MolecularDynamics/Chapter06/BrownianGibbsComplexSpectrum.lean:304;MolecularDynamics/Chapter06/BrownianGibbsComplexSpectrum.lean:347`。

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

### CH06-094 · §6.4.3 · 未编号结论 · 印刷p.251 / PDF272

原文（忠实转述）：Nonzero spectral points lie to the left of a strictly negative threshold.

```lean
-- MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_gap
theorem textbookBrownianGibbsGeneratorComplexSpectrum_gap (z : ℂ) (hz0 : z ≠ 0)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) :
    z.re ≤ -textbookBrownianGibbsCoercivityRate m U hU hPU β

-- MolecularDynamics.textbookBrownianGibbsGeneratorComplexSpectrum_nonpos
theorem textbookBrownianGibbsGeneratorComplexSpectrum_nonpos (z : ℂ)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) : z.re ≤ 0
```

差异、假设及缺口：既有实际闭算子复谱结论；不据此将完整Theorem6.1标proved；同模块历史ledger CH06-DEP-068。

状态：**proved**；位置：`MolecularDynamics/Chapter06/BrownianGibbsComplexSpectrum.lean:286;MolecularDynamics/Chapter06/BrownianGibbsComplexSpectrum.lean:279`。

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

### CH06-097 · §6.4.4 · 定义 · 印刷p.252 / PDF273

原文（忠实转述）：Assumption 2 is a positive proper Lyapunov function with Lphi<=-alpha phi+delta.

```lean
-- MolecularDynamics.Chapter06Review.assumption2
def assumption2 {D : Type*} [TopologicalSpace D] (L : (D → ℝ) → D → ℝ)
    (φ : D → ℝ) (α δ : ℝ) : Prop :=
  (∀ x, 0 < φ x) ∧ Continuous φ ∧ (∀ R : ℝ, IsCompact {x | φ x ≤ R}) ∧
    0 < α ∧ 0 < δ ∧ ∀ x, L φ x ≤ -α*φ x+δ
local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
```

差异、假设及缺口：用compact sublevels描述torus-cylinder趋无穷；不把Harris结论藏进假设。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:184`。

### CH06-098 · §6.4.4 · 未编号结论 · 印刷p.252 / PDF273

原文（忠实转述）：The compact accessibility and density conditions yield a minorization bound.

```lean
-- MolecularDynamics.Chapter06Review.minorization_statement
def minorization_statement : Prop := ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D), assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x
```

差异、假设及缺口：有限正时间真实kernel，小集阈值/aperiodicity尚需条件；已有单位周期conditional依赖登记。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:260`。

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

### CH06-100 · §6.4.4 · 未编号结论 · 印刷p.253 / PDF274

原文（忠实转述）：A smooth periodic potential is bounded above and below; an additive energy shift makes its lower bound greater than one.

```lean
-- MolecularDynamics.textbookUnitPeriodicPotential_bound
theorem textbookUnitPeriodicPotential_bound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M

-- MolecularDynamics.textbookUnitPeriodicPotential_normalization
theorem textbookUnitPeriodicPotential_normalization {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Continuous U) (hp : textbookUnitPeriodicPotential U) :
    ∃ c : ℝ, ∀ q, 1 ≤ U q + c
```

差异、假设及缺口：原同时U周期且q趋无穷U趋无穷矛盾；使用周期bounded及实际shift；同模块历史ledger CH06-NUM-005,CH06-NUM-006,CH06-DEP-011,CH06-CLM-005,CH06-DEP-016,CH06-DEP-115。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinPeriodicForce.lean:48;MolecularDynamics/Chapter06/LangevinPotentialNormalization.lean:92`。

### CH06-101 · §6.4.4 · 定义 · 印刷p.253 / PDF274

原文（忠实转述）：The Langevin Lyapunov function is phi=H^l with H=norm(p)^2/2+U(q).

```lean
-- MolecularDynamics.textbookLangevinHamiltonianPower
noncomputable def textbookLangevinHamiltonianPower {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (l : ℕ)
    (z : textbookLangevinPhase Nc) : ℝ := textbookLangevinHamiltonian U z ^ l

-- MolecularDynamics.textbookLangevinPeriodicHamiltonianPower
noncomputable def textbookLangevinPeriodicHamiltonianPower {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (z : textbookLangevinPeriodicPhase Nc) : ℝ :=
  textbookLangevinHamiltonianPower U l (textbookLangevinPeriodicRepresentative z.1, z.2)
```

差异、假设及缺口：单位质量/单位torus；l>=1，U>=1；同模块历史ledger CH06-NUM-005,CH06-CLM-005,CH06-DEP-016。

状态：**defined**；位置：`MolecularDynamics/Chapter06/LangevinLyapunov.lean:16;MolecularDynamics/Chapter06/LangevinPeriodicLyapunov.lean:43`。

### CH06-102 · §6.4.4 · 未编号结论 · 印刷p.253 / PDF274

原文（忠实转述）：The Hamiltonian part annihilates H^l and p dot grad_p H^l=2lH^l-2lH^(l-1)U.

```lean
-- MolecularDynamics.textbookLangevinHamiltonianPower_drift_hasDerivAt
theorem textbookLangevinHamiltonianPower_drift_hasDerivAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ : ℝ) (l : ℕ) (z : textbookLangevinPhase Nc) :
    HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z + t • textbookLangevinDrift U γ z))
      (-γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2)) 0

-- MolecularDynamics.textbookLangevinHamiltonianPower_differentialOperator
theorem textbookLangevinHamiltonianPower_differentialOperator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z =
      -γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2) +
        σ ^ 2 / 2 * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) *
          (∑ i, z.2 i ^ 2) + (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1))
```

差异、假设及缺口：实际导数，无目标导数前置；同模块历史ledger CH06-NUM-005,CH06-CLM-005,CH06-DEP-016。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinLyapunov.lean:259;MolecularDynamics/Chapter06/LangevinLyapunov.lean:269`。

### CH06-103 · §6.4.4 · 未编号结论 · 印刷p.253 / PDF274

原文（忠实转述）：The momentum Laplacian is l(l-1)H^(l-2) norm(p)^2+Nc l H^(l-1).

```lean
-- MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian
theorem textbookLangevinHamiltonianPower_momentum_laplacian {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) =
      (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (∑ i, z.2 i ^ 2) +
        (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1)
```

差异、假设及缺口：保留正确系数；原随后bound遗漏2，另有已证counterexample；同模块历史ledger CH06-NUM-005,CH06-CLM-005,CH06-DEP-016。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinLyapunov.lean:159`。

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

### CH06-105 · §6.4.4 · 未编号结论 · 印刷p.254 / PDF275

原文（忠实转述）：The corrected Hamiltonian-power Lyapunov drift has a positive linear restoring bound.

```lean
-- MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov
theorem textbookLangevinPeriodicHamiltonianPower_physical_lyapunov {Nc : ℕ}
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
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ

-- MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel
theorem textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) (R : ℝ) :
    IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}
```

差异、假设及缺口：真实thermal系数与correct factor2；单位质量模型完整，非一般Theorem6.2；同模块历史ledger CH06-NUM-005,CH06-CLM-005,CH06-DEP-016。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinPeriodicLyapunov.lean:169;MolecularDynamics/Chapter06/LangevinPeriodicLyapunov.lean:84`。

### CH06-106 · §6.4.4 · 定义 · 印刷p.254 / PDF275

原文（忠实转述）：The genuine Lie bracket is Dv[u]-Du[v].

```lean
-- MolecularDynamics.Chapter06Review.lieBracket
def lieBracket {n : ℕ} (u v : V n → V n) : V n → V n := VectorField.lieBracket ℝ u v
```

差异、假设及缺口：实际Fréchet导数，来自已有Chapter08公共依赖。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:159`。

### CH06-107 · §6.4.4 · 未编号结论 · 印刷p.254 / PDF275

原文（忠实转述）：Lie brackets are bilinear and skew-symmetric and [u,u]=0.

```lean
-- MolecularDynamics.Chapter06Review.bracketProperties_statement
def bracketProperties_statement : Prop := ∀ {n : ℕ} (u v w : V n → V n) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (lieBracket (fun x ↦ a • u x+b • v x) w = (fun x ↦ a • lieBracket u w x+b • lieBracket v w x)) ∧
  lieBracket u v = -lieBracket v u ∧ lieBracket u u=0
```

差异、假设及缺口：Mathlib真实Lie括号已有基础支持；本次仅陈述，不作新证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:280`。

### CH06-108 · §6.4.4 · 定义 · 印刷p.254 / PDF275

原文（忠实转述）：Definition 6.1: drift/noise and iterated brackets span the full tangent space at a point.

```lean
-- MolecularDynamics.textbookHormanderAt
def textbookHormanderAt (seed : Set (E → E)) (x : E) : Prop :=
  textbookBracketPointSpan seed x = ⊤
```

差异、假设及缺口：忠实原定义含drift b0；密度定理所需parabolic版本不能自动混同；同模块历史ledger CH06-DEF-001。

状态：**defined**；位置：`MolecularDynamics/Chapter08/HormanderClosure.lean:33`。

### CH06-109 · §6.4.4 · 定义 · 印刷p.255 / PDF276

原文（忠实转述）：The unit-mass Langevin drift and independent noise vectors are (p,-grad U-gamma p) and sigma(0,e_i).

```lean
-- MolecularDynamics.textbookLangevinDrift
noncomputable def textbookLangevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

-- MolecularDynamics.textbookLangevinNoise
def textbookLangevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)

-- MolecularDynamics.textbookLangevinSeed
def textbookLangevinSeed {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (γ σ : ℝ) :
    Set (textbookLangevinPhase Nc → textbookLangevinPhase Nc) :=
  {textbookLangevinDrift U γ} ∪ Set.range (textbookLangevinNoise Nc σ)
```

差异、假设及缺口：真实gradient/坐标；sigma非零；同模块历史ledger CH06-CLM-004。

状态：**defined**；位置：`MolecularDynamics/Chapter06/LangevinHormander.lean:15;MolecularDynamics/Chapter06/LangevinHormander.lean:20;MolecularDynamics/Chapter06/LangevinHormander.lean:23`。

### CH06-110 · §6.4.4 · 未编号结论 · 印刷p.255 / PDF276

原文（忠实转述）：The first noise commutators are -sigma(e_i,-gamma e_i), and the resulting 2Nc vectors are independent.

```lean
-- MolecularDynamics.textbookLangevinDrift_noise_bracket
theorem textbookLangevinDrift_noise_bracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1)

-- MolecularDynamics.textbookLangevinBracketFamily_linearIndependent
theorem textbookLangevinBracketFamily_linearIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ)
```

差异、假设及缺口：真实C2 Jacobian与有限族消元已验收；同模块历史ledger CH06-CLM-004。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinHormander.lean:52;MolecularDynamics/Chapter06/LangevinHormander.lean:78`。

### CH06-111 · §6.4.4 · 未编号结论 · 印刷p.255 / PDF276

原文（忠实转述）：Langevin's noise/bracket fields satisfy the stated Hormander span condition.

```lean
-- MolecularDynamics.textbookLangevin_hormander_physicalNoise
theorem textbookLangevin_hormander_physicalNoise {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z
```

差异、假设及缺口：C-infinity U、positivegamma/thermal；不计transitiondensity存在已证；同模块历史ledger CH06-CLM-004。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinHormander.lean:162`。

### CH06-112 · §6.4.4 · 未编号结论 · 印刷p.255 / PDF276

原文（忠实转述）：The parabolic Hormander condition implies a positive-time smooth transition density.

```lean
-- MolecularDynamics.Chapter06Review.hormanderDensity_statement
def hormanderDensity_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂flatPhaseMeasure n
```

差异、假设及缺口：需真正hypoellipticity/Malliavin密度定理、parabolic bracket族；不能仅从含b0原span推出。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:284`。

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

### CH06-114 · §6.4.4 · 未编号结论 · 印刷p.255 / PDF276

原文（忠实转述）：There is a smooth control path realizing any prescribed position and velocity endpoints.

```lean
-- MolecularDynamics.textbookLangevinControlledEndpoint
theorem textbookLangevinControlledEndpoint {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t
```

差异、假设及缺口：既有实际Hermite路径和derivedR，不将控制存在误作随机正概率；同模块历史ledger CH06-NUM-006,CH06-DEP-004。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinControlPath.lean:151`。

### CH06-115 · §6.4.4 · 未编号结论 · 印刷p.256 / PDF277

原文（忠实转述）：Uniformly small noise perturbations keep the endpoint within the chosen ball.

```lean
-- MolecularDynamics.textbookLangevinControlledEndpoint_stable
theorem textbookLangevinControlledEndpoint_stable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ
```

差异、假设及缺口：光滑势局部cutoff/退出时间，未添加globalLipschitz前提；同模块历史ledger CH06-NUM-006,CH06-EXT-002,CH06-DEP-006。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinSmoothCutoff.lean:122`。

### CH06-116 · §6.4.4 · 未编号结论 · 印刷p.256 / PDF277

原文（忠实转述）：Every positive-radius finite-time tube around the smooth Wiener control has positive probability.

```lean
-- MolecularDynamics.textbookWienerVectorRealControlTube_pos
theorem textbookWienerVectorRealControlTube_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε)
```

差异、假设及缺口：真实Gaussian独立segments及路径支持；标准vectorWiener；同模块历史ledger CH06-NUM-006,CH06-DEP-010。

状态：**proved**；位置：`MolecularDynamics/Chapter06/WienerVectorSupport.lean:181`。

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

### CH06-118 · §6.4.4 · 未编号结论 · 印刷p.256 / PDF277

原文（忠实转述）：Langevin dynamics is geometrically ergodic and time averages converge to canonical averages.

```lean
-- MolecularDynamics.Chapter06Review.langevinErgodicity_statement
def langevinErgodicity_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → V n) (P : Measure Ω) (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Continuous f → HasCompactSupport f →
    ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧ ∀ t : ℝ≥0,
      |kernelAverage (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
        (Real.sqrt (2*γ*β⁻¹))) f t x - (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
          C*Real.exp (-lambdaParam*(t : ℝ))

-- MolecularDynamics.Chapter06Review.langevinTimeAverage_statement
def langevinTimeAverage_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → V n) (P : Measure Ω) (U : V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Continuous f → HasCompactSupport f → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ))
```

差异、假设及缺口：仍缺density实际存在、唯一性/Harris条件验收及canonical实际invariance；不借假设声称完整。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:303;MolecularDynamics/Chapter06/Statements.lean:316`。

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

### CH06-120 · §6.4.4 · 未编号结论 · 印刷p.257 / PDF278

原文（忠实转述）：The H1 norm squared is the L2 value plus the sum of squared coordinate-derivative L2 norms.

```lean
-- MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq
theorem textbookLangevinCanonicalWeakH1_norm_sq {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2)
```

差异、假设及缺口：既有完整真实Hilbert范数恒等；同模块历史ledger CH06-DEP-163。

状态：**proved**；位置：`MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean:141`。

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

### CH06-122 · §6.4.4 · 未编号结论 · 印刷p.257 / PDF278

原文（忠实转述）：Fredholm alternative gives solvability exactly when the right-hand side is orthogonal to the adjoint kernel.

```lean
-- MolecularDynamics.Chapter06Review.fredholm_statement
def fredholm_statement : Prop := ∀ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [CompleteSpace E] (A : E →ₗ.[ℝ] E), Dense (A.domain : Set E) → IsClosed (A.graph : Set (E × E)) →
  (∃ R : E →L[ℝ] E, IsCompactOperator R ∧
    (∀ x, (R x, R x-x) ∈ A.graph) ∧
    ∀ x y, (y,y-x) ∈ A.graph → y=R x) →
  ∀ g : E, (∃ φ : E, (φ,g) ∈ A.graph) ↔ ∀ y : E, (y,0) ∈ A.adjoint.graph → ⟪y,g⟫_ℝ=0
```

差异、假设及缺口：用actualclosed Hilbertpartialoperator graph与formalAdjoint；compactresolvent待证。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:355`。

### CH06-123 · §6.4.4 · 未编号结论 · 印刷p.257 / PDF278

原文（忠实转述）：The only conserved observables are constants and the only flat-forward stationary modes are Gibbs multiples.

```lean
-- MolecularDynamics.Chapter06Review.kernelConstant_statement
def kernelConstant_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ),
    (f,0) ∈ (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ, f x=c
```

差异、假设及缺口：C0固定观测量特例已证但roughweightedHilbertkernel未完成；CanonicalKernelConstant封存不计成果。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:361`。

### CH06-124 · §6.4.5 · 定义 · 印刷p.257 / PDF278

原文（忠实转述）：The evolving measure is the actual Markov transition applied to the initial measure.

```lean
-- MolecularDynamics.Chapter06Review.kernelEvolution
def kernelEvolution {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (t : ℝ≥0) : Measure D := K t ∘ₘ μ

-- MolecularDynamics.Chapter06Review.kernelAverage
def kernelAverage {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (t : ℝ≥0) (x : D) : ℝ := ∫ z, f z ∂K t x
```

差异、假设及缺口：真实kernelcompProd测度；形式exp不是独立收敛级数。

状态：**defined**；位置：`MolecularDynamics/Chapter06/ReviewDefinitions.lean:160;MolecularDynamics/Chapter06/ReviewDefinitions.lean:162`。

### CH06-125 · §6.4.5 · 未编号结论 · 印刷p.258 / PDF279

原文（忠实转述）：Forward density evolution and backward observable evolution have the same averaged pairing.

```lean
-- MolecularDynamics.Chapter06Review.kernelDuality_statement
def kernelDuality_statement : Prop := ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (t : ℝ≥0) (f : D → ℝ),
  IsProbabilityMeasure μ → IsMarkovKernel (K t) → Measurable f →
  Integrable f (kernelEvolution K μ t) →
  (∫ x, f x ∂kernelEvolution K μ t) = ∫ x, kernelAverage K f t x ∂μ
```

差异、假设及缺口：实际kernel积分双重平均，可测可积；不泛化既有Brownian谱对偶到所有Langevin密度。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:367`。

### CH06-126 · §6.4.5 · 未编号结论 · 印刷p.258 / PDF279

原文（忠实转述）：An eigenmode density perturbation evolves as rho_eq+alpha exp(lambda t)rho_1 and its average correction decays exponentially.

```lean
-- MolecularDynamics.Chapter06Review.eigenmodeDecay_statement
def eigenmodeDecay_statement : Prop := ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (S : ℝ≥0 → E →L[ℝ] E) (ρeq ρ1 : E) (α lambdaParam : ℝ),
  S 0=ContinuousLinearMap.id ℝ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
  (∀ x, Continuous (fun t : ℝ≥0 ↦ S t x)) →
  (∀ t, S t ρeq=ρeq) →
  (∀ t : ℝ, 0 ≤ t → HasDerivWithinAt (fun s : ℝ ↦ S s.toNNReal ρ1)
    (lambdaParam • S t.toNNReal ρ1) (Ici 0) t) → lambdaParam < 0 →
  (∀ t : ℝ≥0, S t (ρeq+α • ρ1)=ρeq+(α*Real.exp (lambdaParam*(t : ℝ))) • ρ1) ∧
  ∀ ℓ : E →L[ℝ] ℝ, ∀ t : ℝ≥0,
    |ℓ (S t (ρeq+α • ρ1))-ℓ ρeq| ≤ |α| *‖ℓ‖*‖ρ1‖*Real.exp (lambdaParam*(t : ℝ))
```

差异、假设及缺口：generator本征向量+实际semigroup/初值正性；Re(lambda)<0，所有smooth函数不自动L2；最终展示先取实负lambda，complex Re(lambda)的一般型未证。

状态：**statement_only**；位置：`MolecularDynamics/Chapter06/Statements.lean:372`。
