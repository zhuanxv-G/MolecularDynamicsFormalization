# 第5章导师快速审阅（15条）

扫描用户指定PDF199–231；实际页码及章节标题边界以本章PAGE_SCAN.json为准。数值实验、介绍性模型和Exercises不纳入。微正则、Liouville、遍历和KAM一般理论只登记明确缺口，不搭建。

清单是进度来源；defined与proved分开统计。Prop定义编译通过只确认陈述类型正确，不表示结论成立。
原文为用户提供的教材PDF逐页忠实转述；机器验收见VALIDATION.json和check-full目录。导师语义审阅待完成。
代码块展示陈述及定义体，省略证明；节参数、类型实例及命名空间环境以链接源码为准。

| 状态 | 条数 |
| --- | ---: |
| defined | 37 |
| proved | 11 |
| statement_only | 28 |
| weakened | 0 |
| not_formalizable_now | 10 |
| 合计 | 86 |

proved为清单行数；重复映射同一证明不等于独立定理数量。

需人工判断的问题：

1. 微正则测度是否采用能量面Hausdorff/Riemannian测度乘1/abs(grad H)的规范？该几何构造尚无一般证明。
2. Theorem5.1公式使用div(g u)，其几何平均校正本身不假设ergodic；数值轨道解释另需ergodicity。实现补统一紧能量带/非零分母/正有限raw mass，是否接受这些较强技术条件？
3. 遍历定义的量词是每个可积观测量分别几乎处处，还是共同满测集？Birkhoff条件平均与空间平均不可无条件等同。
4. 原文KAM需非退化、Diophantine条件及有限光滑/解析正则性；是否接受显式列出这些条件，正文定性结论仅陈述？
5. 印刷页与PDF页偏移发生变化；本章标题/Exercises/下章标题边界是否接受本次原页核对？

### CH05-081 · §5.6 · 定理 · 印刷p.208 / PDF229

原文（忠实转述）：Theorem 5.1: microcanonical averages for H and H+epsilon eta differ by average(div(g u))-average(g)average(div u)+O(epsilon²),u=epsilon eta w/(w dot grad H).

```lean
-- MolecularDynamics.Chapter05Review.theorem51_statement
def theorem51_statement : Prop :=
  ∀ n (H η g : E n → ℝ) (w : E n → E n) c,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ g → ContDiff ℝ ⊤ w →
    regularEnergy H c → (∀ z ∈ energySurface H c,inner ℝ (w z) (grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, regularEnergy (fun z => H z+ε*η z) c ∧
        energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |microAverage H c g-microAverage (fun z => H z+ε*η z) c g-
        perturbationCorrection H η g w c ε| ≤ C*ε^2
```

差异、假设及缺口：紧正则能量面、smooth H/eta/g/w、w dot grad H非零；完整几何平均差量化，未把校正公式假设成前提；实现额外明示统一紧能量带、原分母在能量带非零及raw mass有限正，完整几何定理仍未证。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:175`。

### CH05-083 · §5.6 · 未编号结论 · 印刷p.209 / PDF230

原文（忠实转述）：On a compact energy surface a smooth nowhere-zero w dot grad H is bounded away from zero.

```lean
-- MolecularDynamics.Chapter05Review.denominatorBound_proved
theorem denominatorBound_proved {n : ℕ} (H : E n → ℝ) (w : E n → E n) c
    (hK : IsCompact (energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (grad H z)|) (energySurface H c))
    (hn : ∀ z ∈ energySurface H c,inner ℝ (w z) (grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ energySurface H c,a ≤ |inner ℝ (w z) (grad H z)|

-- MolecularDynamics.Chapter05Review.smoothDenominatorBound_proved
theorem smoothDenominatorBound_proved {n : ℕ} (H : E n → ℝ) (w : E n → E n) c
    (hK : IsCompact (energySurface H c)) (hH : ContDiff ℝ 2 H) (hw : Continuous w)
    (hn : ∀ z ∈ energySurface H c,inner ℝ (w z) (grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ energySurface H c,a ≤ |inner ℝ (w z) (grad H z)|
```

差异、假设及缺口：仅Theorem5.1可直接推出的正则部分；完整micro平均校正未证；由C2 H/连续w自动得到连续分母绝对值，紧性给正下界。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:25;MolecularDynamics/Chapter05/ReviewProofs.lean:31`。

### CH05-084 · §5.6 · 未编号结论 · 印刷p.209 / PDF230

原文（忠实转述）：The first-order correction vanishes when eta is identically zero.

```lean
-- MolecularDynamics.Chapter05Review.zeroPerturbation_proved
theorem zeroPerturbation_proved {n : ℕ} (H g : E n → ℝ) (w : E n → E n) c ε :
    perturbationCorrection H (fun _ => 0) g w c ε=0
```

差异、假设及缺口：只证显式校正函数恒等式，不将一般平均扰动定理记proved。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:41`。

### CH05-025 · §5.2.2 · 未编号结论 · 印刷p.185 / PDF206

原文（忠实转述）：The transported smooth density satisfies partial_t rho=-div(rho f).

```lean
-- MolecularDynamics.Chapter05Review.liouvilleEquation_statement
def liouvilleEquation_statement : Prop := ∀ n (f : E n → E n) Φ (ρ : ℝ → E n → ℝ),
  ContDiff ℝ 1 f → flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  ContDiff ℝ 1 (Function.uncurry ρ) → (∀ t,probabilityDensity (ρ t)) →
  (∀ t,densityMeasure (ρ t)=measurePropagator Φ t (densityMeasure (ρ 0))) →
  ∀ t z, HasDerivAt (fun s => ρ s z) (liouvillian f (ρ t) z) t
```

差异、假设及缺口：实际体积变换密度与连续性方程；缺一般PDE/几何输运桥接。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:50`。

### CH05-027 · §5.2.2 · 未编号结论 · 印刷p.185 / PDF206

原文（忠实转述）：Integration by parts gives integral u L_f v=integral M_f u v after the boundary term vanishes, (5.4)-(5.5).

```lean
-- MolecularDynamics.Chapter05Review.liouvillianAdjoint_statement
def liouvillianAdjoint_statement : Prop := ∀ n (f : E n → E n) (u v : E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*lie f v z)=(∫ z,liouvillian f u z*v z)
```

差异、假设及缺口：用C1 compact support给明确消边界条件；形式伴随不是闭算子Hilbert伴随已识别。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:58`。

### CH05-045 · §5.3.2 · 定义 · 印刷p.191 / PDF212

原文（忠实转述）：The geometric microcanonical measure is surface measure weighted by 1/abs(grad H).

```lean
-- MolecularDynamics.Chapter05Review.energySurface
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}

-- MolecularDynamics.Chapter05Review.surfaceMeasure
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)

-- MolecularDynamics.Chapter05Review.microRaw
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```

差异、假设及缺口：真实Hausdorff measure withDensity；归一化常数不宣称构造已正确识别Riemannian体积。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:58;MolecularDynamics/Chapter05/ReviewDefinitions.lean:63;MolecularDynamics/Chapter05/ReviewDefinitions.lean:65`。

### CH05-044 · §5.3.2 · 未编号结论 · 印刷p.191 / PDF212

原文（忠实转述）：The normalized shell densities converge weakly to the normalized microcanonical measure, (5.7)-(5.8).

```lean
-- MolecularDynamics.Chapter05Review.shellWeakLimit_statement
def shellWeakLimit_statement : Prop := ∀ n (H : E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → regularEnergy H c →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (shellWeight H c ε) volume ∧ 0 < shellPartition H c ε)) →
  ∀ φ : testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (microAverage H c φ.1))

-- MolecularDynamics.Chapter05Review.shellWeakPrinted_statement
def shellWeakPrinted_statement : Prop := ∀ n (H : E n → ℝ) c,
  ContDiff ℝ 2 H → regularEnergy H c → ∀ φ : testSpace n,
    Tendsto (fun ε => (shellPartition H c ε)⁻¹*(∫ z,φ.1 z*shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (microAverage H c φ.1))
```

差异、假设及缺口：需coarea及正则紧能量面/尾部控制；原文rho已归一又乘Z^-1疑重复，保留字面版。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:79;MolecularDynamics/Chapter05/Statements.lean:85`。

### CH05-046 · §5.3.2 · 未编号结论 · 印刷p.191 / PDF212

原文（忠实转述）：A smooth injective regular parameterization has area element sqrt(det(Dg^T Dg)).

```lean
-- MolecularDynamics.Chapter05Review.surfaceAreaFormula_statement
def surfaceAreaFormula_statement : Prop := ∀ d (g : E d → E (d+1)) (U : Set (E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ))
```

差异、假设及缺口：需曲面面积/coarea/嵌入流形Riemannian volume form；可陈述未证明。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:89`。

### CH05-050 · §5.3.2 · 未编号结论 · 印刷p.193 / PDF214

原文（忠实转述）：The geometric microcanonical measure is invariant under Hamiltonian flow.

```lean
-- MolecularDynamics.Chapter05Review.microInvariant_statement
def microInvariant_statement : Prop := ∀ n (H : E n → ℝ) c (f : E n → E n) Φ,
  ContDiff ℝ 2 H → regularEnergy H c → flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (microMeasure H c) (microMeasure H c)
```

差异、假设及缺口：体积与能量守恒并不足以已证曲面测度桥接；需coarea与流正则性。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:104`。

### CH05-058 · §5.4.1 · 定义 · 印刷p.197 / PDF218

原文（忠实转述）：Definition 5.1: microcanonical ergodicity equates temporal and spatial averages for almost every initial state and every integrable observable.

```lean
-- MolecularDynamics.Chapter05Review.microErgodic
def microErgodic {n : ℕ} (H : E n → ℝ) (c : ℝ) (Φ : ℝ → E n → E n) : Prop :=
  ∀ g : E n → ℝ, Integrable g (microMeasure H c) →
    ∀ᵐ z ∂microMeasure H c, hasTimeAverage (fun t => Φ t z) g (microAverage H c g)
```

差异、假设及缺口：采用每观测量分别AE；书中共满测集和低维例外表述不严谨，待审。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:79`。

### CH05-061 · §5.4.1 · 未编号结论 · 印刷p.198 / PDF219

原文（忠实转述）：The time-average definition of ergodicity is equivalent to invariant-set zero-one ergodicity.

```lean
-- MolecularDynamics.Chapter05Review.ergodicTimeAverage_statement
def ergodicTimeAverage_statement : Prop := ∀ n (μ : Measure (E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (setErgodic μ Φ ↔ ∀ g : E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, hasTimeAverage (fun t => Φ t z) g (average μ g))
```

差异、假设及缺口：Mathlib有离散ergodic支持；缺本章连续流Birkhoff/积分时间平均桥接，不搭理论。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:115`。

### CH05-063 · §5.4.1 · 未编号结论 · 印刷p.200 / PDF221

原文（忠实转述）：KAM theory predicts invariant torus barriers in suitable near-integrable systems, obstructing energy-surface coverage.

```lean
-- MolecularDynamics.Chapter05Review.kam_statement
def kam_statement : Prop := ∀ n (H0 : E n → ℝ) (P : Phase n → ℝ) (I0 : E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : E n → Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1)
```

差异、假设及缺口：原文只在double-pendulum例中定性引用；陈述为非退化Diophantine torus的持久化，不宣称例5.5参数已满足，需KAM/Nash-Moser与测度版。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:127`。

### CH05-071 · §5.5 · 未编号结论 · 印刷p.205 / PDF226

原文（忠实转述）：Mixing implies correlations converge to the product of means and centered correlations tend to zero.

```lean
-- MolecularDynamics.Chapter05Review.mixingCorrelation_statement
def mixingCorrelation_statement : Prop := ∀ n (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (a b : E n → ℝ) k, IsProbabilityMeasure μ →
  (∀ r φ : E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*average μ a*average μ b))

-- MolecularDynamics.Chapter05Review.mixingCorrelationPrinted_statement
def mixingCorrelationPrinted_statement : Prop := ∀ n (μ : Measure (E n)) Φ
    (a b : E n → ℝ) k, IsProbabilityMeasure μ → mixing μ Φ → Continuous a → Continuous b →
    Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
    Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (average μ a*average μ b))
```

差异、假设及缺口：保留原k归一化；印刷极限遗漏k，附修正版。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:148;MolecularDynamics/Chapter05/Statements.lean:155`。

### CH05-078 · §5.6 · 未编号结论 · 印刷p.207 / PDF228

原文（忠实转述）：Symplectic Euler preserves its modified quadratic oscillator Hamiltonian.

```lean
-- MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved
theorem symplecticEulerShadow_proved : symplecticEulerShadow_statement
```

差异、假设及缺口：既有完整有限模型证明，稳定椭圆需abs(h Omega)<2。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:47`。

### CH05-077 · §5.6 · 未编号结论 · 印刷p.207 / PDF228

原文（忠实转述）：Backward Euler oscillator trajectories tend to zero and every initial probability measure tends weakly to delta0.

```lean
-- MolecularDynamics.Chapter05Review.backwardEulerLimit_statement
def backwardEulerLimit_statement : Prop := ∀ h : ℝ,h ≠ 0 →
  (∀ z : E 2,Tendsto (fun k : ℕ => (backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (E 2),IsProbabilityMeasure μ → ∀ φ : E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0))
```

差异、假设及缺口：h非零；weak有界连续test与真实概率，非点wise密度收敛。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:164`。
