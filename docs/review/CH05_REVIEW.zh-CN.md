# 第5章人工审阅材料

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

### CH05-001 · §5.1 · 定义 · 印刷p.180 / PDF201

原文（忠实转述）：The Lie derivative is L_f g=Dg[f].

```lean
-- MolecularDynamics.Chapter05Review.lie
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```

差异、假设及缺口：实际Fréchet导数；复用第3章对象。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:20`。

### CH05-002 · §5.1 · 未编号结论 · 印刷p.180 / PDF201

原文（忠实转述）：Along an actual trajectory the time derivative of g is L_f g, (5.1).

```lean
-- MolecularDynamics.hasDerivAt_textbookLieDerivative
theorem hasDerivAt_textbookLieDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t
```

差异、假设及缺口：既有局部链式法则完整证明；实际解。

状态：**proved**；位置：`MolecularDynamics/Chapter03/LiePoisson.lean:35`。

### CH05-003 · §5.1 · 定义 · 印刷p.180 / PDF201

原文（忠实转述）：The observable solution operator is pullback g(F_t(z)).

```lean
-- MolecularDynamics.Chapter05Review.pullback
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```

差异、假设及缺口：实际流，不将形式exp当收敛算子。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:21`。

### CH05-004 · §5.1 · 未编号结论 · 印刷p.181 / PDF202

原文（忠实转述）：A differentiable autonomous flow satisfies DF_t(z) f(z)=f(F_t(z)).

```lean
-- MolecularDynamics.Chapter05Review.flowFieldTransport_statement
def flowFieldTransport_statement : Prop := ∀ n (f : E n → E n) Φ,
  flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z)
```

差异、假设及缺口：真实流群/C2条件；不搭一般flow变分理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:8`。

### CH05-005 · §5.1 · 未编号结论 · 印刷p.181 / PDF202

原文（忠实转述）：The pullback solves partial_t gtilde=L_f gtilde, (5.2).

```lean
-- MolecularDynamics.Chapter05Review.pullbackPDE_statement
def pullbackPDE_statement : Prop := ∀ n (f : E n → E n) Φ (g : E n → ℝ),
  flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => pullback Φ g s z) (lie f (pullback Φ g t) z) t
```

差异、假设及缺口：给定joint光滑实际流；一般输运PDE未证。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:11`。

### CH05-006 · §5.1 · 未编号结论 · 印刷p.181 / PDF202

原文（忠实转述）：Steady solutions of the observable equation are first integrals.

```lean
-- MolecularDynamics.Chapter05Review.steadyFirstIntegral_statement
def steadyFirstIntegral_statement : Prop := ∀ n (f : E n → E n) Φ (g : E n → ℝ),
  flow f Φ → Differentiable ℝ g → ((∀ z,lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z)
```

差异、假设及缺口：实际流与所有初值，量词清晰。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:14`。

### CH05-007 · §5.1 · notation · 印刷p.181 / PDF202

原文（忠实转述）：G_t=exp(t L_f) denotes the solution operator.

```lean
-- MolecularDynamics.Chapter05Review.solutionOperator
def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := pullback Φ g t
```

差异、假设及缺口：定义为pullback，不证明无界算子的exp构造。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:22`。

### CH05-008 · §5.1 · 未编号结论 · 印刷p.181 / PDF202

原文（忠实转述）：The solution operator applied to coordinate projection returns the trajectory coordinate.

```lean
-- MolecularDynamics.Chapter05Review.coordinatePullback_proved
theorem coordinatePullback_proved {n : ℕ} (Φ : ℝ → E n → E n) (t : ℝ) (z : E n) (i : Fin n) :
    pullback Φ (fun x => x i) t z=Φ t z i
```

差异、假设及缺口：定义展开的完整证明，不是ODE存在证明。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:9`。

### CH05-009 · §5.2.1 · 定义 · 印刷p.182 / PDF203

原文（忠实转述）：A density is measurable, nonnegative and has finite integral.

```lean
-- MolecularDynamics.Chapter05Review.density
def density {n : ℕ} (ρ : E n → ℝ) : Prop :=
  Measurable ρ ∧ (∀ z, 0 ≤ ρ z) ∧ Integrable ρ volume

-- MolecularDynamics.Chapter05Review.probabilityDensity
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```

差异、假设及缺口：显式Lebesgue测度与可积性；归一化单列。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:26;MolecularDynamics/Chapter05/ReviewDefinitions.lean:28`。

### CH05-010 · §5.2.1 · 未编号结论 · 印刷p.182 / PDF203

原文（忠实转述）：Every nonnegative density with positive finite integral can be normalized to a probability density.

```lean
-- MolecularDynamics.Chapter05Review.densityNormalization_statement
def densityNormalization_statement : Prop := ∀ n (ρ : E n → ℝ), density ρ → 0 < (∫ z,ρ z) →
  probabilityDensity (fun z => ρ z/(∫ x,ρ x))
```

差异、假设及缺口：基础积分理论有支持；本次有限时间盒未推广。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:16`。

### CH05-011 · §5.2.1 · 定义 · 印刷p.182 / PDF203

原文（忠实转述）：The density assigns a set its integral over that set.

```lean
-- MolecularDynamics.Chapter05Review.densityMeasure
def densityMeasure {n : ℕ} (ρ : E n → ℝ) : Measure (E n) := volume.withDensity (fun z => ENNReal.ofReal (ρ z))
```

差异、假设及缺口：真实withDensity，不将所有概率测度误限于AC。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:29`。

### CH05-012 · §5.2.1 · 未编号结论 · 印刷p.182 / PDF203

原文（忠实转述）：Open and closed sets and countable unions/intersections of measurable sets are measurable.

```lean
-- MolecularDynamics.Chapter05Review.borelClosure_statement
def borelClosure_statement : Prop := ∀ n (s : Set (E n)) (A : ℕ → Set (E n)),
  (IsOpen s → MeasurableSet s) ∧ (IsClosed s → MeasurableSet s) ∧
  ((∀ k,MeasurableSet (A k)) → MeasurableSet (⋃ k,A k) ∧ MeasurableSet (⋂ k,A k))
```

差异、假设及缺口：正文页脚理论逐条量化；Mathlib支持，未新增证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:18`。

### CH05-013 · §5.2.1 · 未编号结论 · 印刷p.183 / PDF204

原文（忠实转述）：A probability measure assigns every measurable set a value between zero and one.

```lean
-- MolecularDynamics.Chapter05Review.probabilityBounds_proved
theorem probabilityBounds_proved {n : ℕ} (μ : Measure (E n)) [IsProbabilityMeasure μ] (A : Set (E n)) :
    0 ≤ μ A ∧ μ A ≤ 1
```

差异、假设及缺口：Mathlib概率测度基础引理复用包装。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:11`。

### CH05-014 · §5.2.1 · 定义 · 印刷p.183 / PDF204

原文（忠实转述）：L2 consists of AE classes of square-integrable functions, with norm sqrt(integral f²).

```lean
-- MolecularDynamics.Chapter05Review.L2Space
abbrev L2Space {n : ℕ} (μ : Measure (E n)) := Lp ℝ 2 μ

-- MolecularDynamics.Chapter05Review.l2Norm
def l2Norm {n : ℕ} (μ : Measure (E n)) (g : L2Space μ) := ‖g‖
```

差异、假设及缺口：书中忽略AE商，Lean采用真实Lp；不将原始函数空间称Hilbert。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:30;MolecularDynamics/Chapter05/ReviewDefinitions.lean:31`。

### CH05-015 · §5.2.1 · 定义 · 印刷p.183 / PDF204

原文（忠实转述）：The L2 inner product is the integral of the product.

```lean
-- MolecularDynamics.Chapter05Review.l2Inner
def l2Inner {n : ℕ} (μ : Measure (E n)) (f g : E n → ℝ) := ∫ z, f z*g z ∂μ
```

差异、假设及缺口：实际Bochner integral。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:32`。

### CH05-016 · §5.2.1 · 未编号结论 · 印刷p.183 / PDF204

原文（忠实转述）：The actual L2 norm squared equals its self inner product.

```lean
-- MolecularDynamics.Chapter05Review.l2NormSquare_statement
def l2NormSquare_statement : Prop := ∀ n (μ : Measure (E n)) (g : L2Space μ),
  l2Norm μ g^2=∫ z,(g z)^2 ∂μ
```

差异、假设及缺口：真实Lp quotient，基础Mathlib支持；单列陈述。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:21`。

### CH05-017 · §5.2.1 · 未编号结论 · 印刷p.183 / PDF204

原文（忠实转述）：L2 is a complete Hilbert space.

```lean
-- MolecularDynamics.Chapter05Review.l2Complete_statement
def l2Complete_statement : Prop := ∀ n (μ : Measure (E n)) (u : ℕ → L2Space μ),
  CauchySeq u → ∃ v : L2Space μ,Tendsto u atTop (𝓝 v)
```

差异、假设及缺口：实际CauchySeq趋于极限；不搭新Hilbert理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:23`。

### CH05-018 · §5.2.1 · 未编号结论 · 印刷p.183 / PDF204

原文（忠实转述）：The L2 inner product is symmetric and bilinear.

```lean
-- MolecularDynamics.Chapter05Review.l2Symmetry_statement
def l2Symmetry_statement : Prop := ∀ n (μ : Measure (E n)) (f g : E n → ℝ),
  l2Inner μ f g=l2Inner μ g f

-- MolecularDynamics.Chapter05Review.l2Linearity_statement
def l2Linearity_statement : Prop := ∀ n (μ : Measure (E n)) (f g h : E n → ℝ) a b,
  Integrable (fun z => f z*h z) μ → Integrable (fun z => g z*h z) μ →
  l2Inner μ (fun z => a*f z+b*g z) h=a*l2Inner μ f h+b*l2Inner μ g h
```

差异、假设及缺口：补可积乘积/平方可积假设；原公式的严格版本。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:25;MolecularDynamics/Chapter05/Statements.lean:27`。

### CH05-019 · §5.2.1 · 未编号结论 · 印刷p.183 / PDF204

原文（忠实转述）：Continuous compactly supported functions belong to L2 of Euclidean space.

```lean
-- MolecularDynamics.Chapter05Review.compactL2_statement
def compactL2_statement : Prop := ∀ n (g : E n → ℝ), Continuous g → HasCompactSupport g → MemLp g 2 volume
```

差异、假设及缺口：实际Lebesgue局部有限测度；基础库支持未深挖。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:30`。

### CH05-020 · §5.2.1 · 定义 · 印刷p.184 / PDF205

原文（忠实转述）：The spatial average is integral(g rho)/integral(rho).

```lean
-- MolecularDynamics.Chapter05Review.densityAverage
def densityAverage {n : ℕ} (ρ g : E n → ℝ) := (∫ z,g z*ρ z)/(∫ z,ρ z)

-- MolecularDynamics.Chapter05Review.average
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```

差异、假设及缺口：分母正方可解释平均；average用给定Measure。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:34;MolecularDynamics/Chapter05/ReviewDefinitions.lean:33`。

### CH05-021 · §5.2.2 · 定义 · 印刷p.184 / PDF205

原文（忠实转述）：The mass fraction of points in A at time t is integral_A rho(t).

```lean
-- MolecularDynamics.Chapter05Review.massFraction
def massFraction {n : ℕ} (ρ : ℝ → E n → ℝ) (A : Set (E n)) (t : ℝ) := ∫ z in A,ρ t z
```

差异、假设及缺口：实际Lebesgue积分。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:35`。

### CH05-022 · §5.2.2 · 未编号结论 · 印刷p.184 / PDF205

原文（忠实转述）：Its derivative is integral_A partial_t rho under differentiation-under-integral hypotheses.

```lean
-- MolecularDynamics.Chapter05Review.massDerivative_statement
def massDerivative_statement : Prop := ∀ n (ρ : ℝ → E n → ℝ) (A : Set (E n)) t,
  MeasurableSet A → (∀ s,IntegrableOn (ρ s) A) →
  (∃ δ > 0, ∃ b : E n → ℝ, IntegrableOn b A ∧
    (∀ s ∈ Ioo (t-δ) (t+δ), ∀ z ∈ A, HasDerivAt (fun u => ρ u z) (deriv (fun u => ρ u z) s) s ∧
      |deriv (fun u => ρ u z) s| ≤ b z)) →
  HasDerivAt (massFraction ρ A) (∫ z in A,deriv (fun u => ρ u z) t) t
```

差异、假设及缺口：一致可积支配界；不搭一般输运解存在理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:31`。

### CH05-023 · §5.2.2 · 未编号结论 · 印刷p.184 / PDF205

原文（忠实转述）：The derivative of the mass is negative outward flux, and equals negative integral_A div(rho f).

```lean
-- MolecularDynamics.Chapter05Review.fluxBalance_statement
def fluxBalance_statement : Prop := ∀ n (f : E n → E n) Φ (ρ : ℝ → E n → ℝ) (a b : E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,probabilityDensity (ρ t)) →
  (∀ t,densityMeasure (ρ t)=measurePropagator Φ t (densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i))
```

差异、假设及缺口：需边界法向量/曲面测度及散度定理，对长方体给忠实有限面公式。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:41`。

### CH05-024 · §5.2.2 · 定义 · 印刷p.185 / PDF206

原文（忠实转述）：The Liouvillian is M_f w=-div(w f).

```lean
-- MolecularDynamics.Chapter05Review.divergence
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap

-- MolecularDynamics.Chapter05Review.liouvillian
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
```

差异、假设及缺口：实际偏导/trace。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:36;MolecularDynamics/Chapter05/ReviewDefinitions.lean:38`。

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

### CH05-026 · §5.2.2 · 未编号结论 · 印刷p.185 / PDF206

原文（忠实转述）：The continuity equation expands as -sum_i(rho partial_i f_i+f_i partial_i rho).

```lean
-- MolecularDynamics.Chapter05Review.liouvilleProduct_statement
def liouvilleProduct_statement : Prop := ∀ n (f : E n → E n) (ρ : E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  liouvillian f ρ z = -ρ z*divergence f z-lie f ρ z
```

差异、假设及缺口：局部乘积规则；完整实际导数。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:55`。

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

### CH05-028 · §5.2.2 · notation · 印刷p.186 / PDF207

原文（忠实转述）：The measure propagator is formally exp(t L_f^*) rho0.

```lean
-- MolecularDynamics.Chapter05Review.measurePropagator
def measurePropagator {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ
```

差异、假设及缺口：用真实Measure.map表示，exp仅原文notation。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:40`。

### CH05-029 · §5.2.3 · 未编号结论 · 印刷p.186 / PDF207

原文（忠实转述）：A C2 Hamiltonian vector field has zero divergence.

```lean
-- MolecularDynamics.textbookHamiltonianVectorField_divergence_zero
theorem textbookHamiltonianVectorField_divergence_zero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0
```

差异、假设及缺口：复用既有真实HamiltonianJacobian trace证明。

状态：**proved**；位置：`MolecularDynamics/Chapter02/HamiltonianVolume.lean:31`。

### CH05-030 · §5.2.3 · 未编号结论 · 印刷p.186 / PDF207

原文（忠实转述）：For a divergence-free field the differential expressions satisfy M_f=-L_f.

```lean
-- MolecularDynamics.Chapter05Review.hamiltonianSkewExpression_statement
def hamiltonianSkewExpression_statement : Prop := ∀ n (f : E n → E n) (u : E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,divergence f z=0) →
  ∀ z,liouvillian f u z= -lie f u z
```

差异、假设及缺口：实际differential expression；闭Hilbert skew-adjoint另需domain。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:61`。

### CH05-031 · §5.2.3 · 未编号结论 · 印刷p.187 / PDF208

原文（忠实转述）：Forward/backward Hamiltonian density propagation reverses time and preserves total mass.

```lean
-- MolecularDynamics.Chapter05Review.hamiltonianDensityPropagation_statement
def hamiltonianDensityPropagation_statement : Prop := ∀ n (f : E n → E n) Φ (ρ : E n → ℝ),
  ContDiff ℝ 1 f → flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ z,divergence f z=0) → density ρ → ∀ t,
  (∫ z,ρ (Φ (-t) z))=(∫ z,ρ z) ∧
  densityMeasure (fun z => ρ (Φ (-t) z))=measurePropagator Φ t (densityMeasure ρ)
```

差异、假设及缺口：给定全时域C2流及体积保留；非一般PDE存在。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:64`。

### CH05-032 · §5.2.3 · 定义 · 印刷p.187 / PDF208

原文（忠实转述）：The mechanical forward Liouvillian is -sum_i (p_i/m_i partial_qi+F_i partial_pi).

```lean
-- MolecularDynamics.Chapter05Review.mechanicalLiouvillian
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : E n → E n)
    (u : Phase n → ℝ) (z : Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```

差异、假设及缺口：F=-grad U；质量正解释。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:42`。

### CH05-033 · §5.3.1 · 定义 · 印刷p.188 / PDF209

原文（忠实转述）：The test spaces are C-infinity compact support functions and Schwartz functions.

```lean
-- MolecularDynamics.Chapter05Review.testSpace
def testSpace (n : ℕ) := {φ : E n → ℝ // ContDiff ℝ ⊤ φ ∧ HasCompactSupport φ}

-- MolecularDynamics.Chapter05Review.schwartzSpace
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```

差异、假设及缺口：实际SchwartzMap；正文广义函数需连续性，书只提线性。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:45;MolecularDynamics/Chapter05/ReviewDefinitions.lean:46`。

### CH05-034 · §5.3.1 · 定义 · 印刷p.188 / PDF209

原文（忠实转述）：A generalized function is a linear functional on the test space.

```lean
-- MolecularDynamics.Chapter05Review.distribution
abbrev distribution (n : ℕ) := schwartzSpace n →ₗ[ℝ] ℝ
```

差异、假设及缺口：原文代数线性定义；连续分布空间另列缺口。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:47`。

### CH05-035 · §5.3.1 · 定义 · 印刷p.188 / PDF209

原文（忠实转述）：A regular generalized function acts by integral f phi.

```lean
-- MolecularDynamics.Chapter05Review.regularDistribution
def regularDistribution {n : ℕ} (f : E n → ℝ) (φ : schwartzSpace n) := ∫ z, f z*φ z
```

差异、假设及缺口：先给积分表达；线性需可积条件。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:48`。

### CH05-036 · §5.3.1 · 定义 · 印刷p.189 / PDF210

原文（忠实转述）：The Dirac distribution acts by evaluating a test function at zero.

```lean
-- MolecularDynamics.Chapter05Review.diracAction
def diracAction {n : ℕ} (φ : schwartzSpace n) := φ 0

-- MolecularDynamics.Chapter05Review.diracMeasure
def diracMeasure (n : ℕ) : Measure (E n) := Measure.dirac 0
```

差异、假设及缺口：实际点测度与线性评价分别登记。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:49;MolecularDynamics/Chapter05/ReviewDefinitions.lean:50`。

### CH05-037 · §5.3.1 · 未编号结论 · 印刷p.189 / PDF210

原文（忠实转述）：A concentrated normalized approximate identity converges weakly to Dirac.

```lean
-- MolecularDynamics.Chapter05Review.diracApproximation_statement
def diracApproximation_statement : Prop := ∀ n (r : ℝ → E n → ℝ),
  (∀ ε > 0,probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0))
```

差异、假设及缺口：非负总质量1、support缩小；不将点wise收敛误作weak。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:69`。

### CH05-038 · §5.3.1 · 定义 · 印刷p.189 / PDF210

原文（忠实转述）：One-dimensional Gaussian approximate Dirac is exp(-z²/(2 epsilon))/sqrt(2 pi epsilon).

```lean
-- MolecularDynamics.Chapter05Review.gaussianDelta
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

差异、假设及缺口：epsilon>0；分母正。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:51`。

### CH05-039 · §5.3.2 · 定义 · 印刷p.189 / PDF210

原文（忠实转述）：A weak stationary distribution annihilates L_f acting on test functions.

```lean
-- MolecularDynamics.Chapter05Review.weakStationary
def weakStationary {n : ℕ} (f : E n → E n) (μ : Measure (E n)) : Prop :=
  ∀ φ : testSpace n, Integrable (lie f φ.1) μ ∧ (∫ z,lie f φ.1 z ∂μ)=0
```

差异、假设及缺口：对真实measure积分，未混同可微密度。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:52`。

### CH05-040 · §5.3.2 · 定义 · 印刷p.190 / PDF211

原文（忠实转述）：The finite-time ensemble average is the normalized density integral, (5.6).

```lean
-- MolecularDynamics.Chapter05Review.ensembleAverage
def ensembleAverage {n : ℕ} (ρ : ℝ → E n → ℝ) (φ : E n → ℝ) (t : ℝ) := densityAverage (ρ t) φ
```

差异、假设及缺口：不是轨道时间平均。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:54`。

### CH05-041 · §5.3.2 · 未编号结论 · 印刷p.190 / PDF211

原文（忠实转述）：Hamiltonian energy is a first integral: L_H H=0.

```lean
-- MolecularDynamics.textbookPoissonBracket_self
theorem textbookPoissonBracket_self (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0

-- MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson
theorem textbookLieDerivative_hamiltonian_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H
```

差异、假设及缺口：既有完整自括号/真实Hamiltonian Lie证明联合映射。

状态：**proved**；位置：`MolecularDynamics/Chapter03/LiePoisson.lean:148;MolecularDynamics/Chapter03/LiePoisson.lean:212`。

### CH05-042 · §5.3.2 · 未编号结论 · 印刷p.190 / PDF211

原文（忠实转述）：A smooth function of H has zero Hamiltonian Lie derivative and defines an invariant density when integrable.

```lean
-- MolecularDynamics.Chapter05Review.energyDensityInvariant_statement
def energyDensityInvariant_statement : Prop := ∀ n (H : E n → ℝ) (f : E n → E n)
    Φ (r : ℝ → ℝ), flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    probabilityDensity (r ∘ H) → ∀ t,
    measurePropagator Φ t (densityMeasure (r ∘ H))=densityMeasure (r ∘ H)
```

差异、假设及缺口：补归一化与真实全流；原文t导数趋零只为启发，非平均收敛充分条件。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:74`。

### CH05-043 · §5.3.2 · 定义 · 印刷p.190 / PDF211

原文（忠实转述）：The energy-shell smooth approximation is exp(-(H-E)²/(2 epsilon)) divided by its partition integral.

```lean
-- MolecularDynamics.Chapter05Review.shellDensity
def shellDensity {n : ℕ} (H : E n → ℝ) (c ε : ℝ) (z : E n) := shellWeight H c ε z/shellPartition H c ε

-- MolecularDynamics.Chapter05Review.shellPartition
def shellPartition {n : ℕ} (H : E n → ℝ) (c ε : ℝ) := ∫ z,shellWeight H c ε z
```

差异、假设及缺口：可积/非零归一化为适用条件。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:57;MolecularDynamics/Chapter05/ReviewDefinitions.lean:56`。

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

### CH05-047 · §5.3.2 · 定义 · 印刷p.192 / PDF213

原文（忠实转述）：The unit normal is grad H/abs(grad H) on a regular level surface.

```lean
-- MolecularDynamics.Chapter05Review.normalField
def normalField {n : ℕ} (H : E n → ℝ) (z : E n) := ‖grad H z‖⁻¹ • grad H z
```

差异、假设及缺口：Euclidean范数；grad采用真实导数。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:71`。

### CH05-048 · §5.3.2 · 未编号结论 · 印刷p.192 / PDF213

原文（忠实转述）：A normal energy displacement satisfies dE=abs(grad H) ds+O(ds²).

```lean
-- MolecularDynamics.Chapter05Review.normalEnergyTaylor_statement
def normalEnergyTaylor_statement : Prop := ∀ n (H : E n → ℝ) z,
  ContDiff ℝ 2 H → grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • normalField H z)-H z-s*‖grad H z‖| ≤ C*s^2
```

差异、假设及缺口：局部C2、非零grad；真实余项量化。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:96`。

### CH05-049 · §5.3.2 · 未编号结论 · 印刷p.192 / PDF213

原文（忠实转述）：Thickened-shell volume divided by dE tends to integral_surface 1/abs(grad H).

```lean
-- MolecularDynamics.Chapter05Review.shellVolumeLimit_statement
def shellVolumeLimit_statement : Prop := ∀ n (H : E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (microPartition H c))
```

差异、假设及缺口：缺tubular coordinates/coarea/几何Jacobian；明确正则紧性。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:99`。

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

### CH05-051 · §5.3.2 · 定义 · 印刷p.193 / PDF214

原文（忠实转述）：The microcanonical partition function is the total raw measure of the energy surface.

```lean
-- MolecularDynamics.Chapter05Review.microPartition
def microPartition {n : ℕ} (H : E n → ℝ) (c : ℝ) := ((microRaw H c) univ).toReal
```

差异、假设及缺口：ENNReal量转实；有限且正是使用条件。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:67`。

### CH05-052 · §5.3.3 · 定义 · 印刷p.194 / PDF215

原文（忠实转述）：The microcanonical probability measure is the normalized raw surface measure.

```lean
-- MolecularDynamics.Chapter05Review.microMeasure
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```

差异、假设及缺口：真实Measure scalar normalization；不视为已证概率实例。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:68`。

### CH05-053 · §5.3.3 · 未编号结论 · 印刷p.195 / PDF216

原文（忠实转述）：The normalized microcanonical measure has total mass one and all probabilities lie in [0,1].

```lean
-- MolecularDynamics.Chapter05Review.microProbability_statement
def microProbability_statement : Prop := ∀ n (H : E n → ℝ) c,
  0 < (microRaw H c) univ → (microRaw H c) univ < ∞ →
  (microMeasure H c) univ=1 ∧ ∀ A : Set (E n), (microMeasure H c) A ≤ 1
```

差异、假设及缺口：明确0<raw mass<infinity；基础归一化部分不需要一般几何理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:108`。

### CH05-054 · §5.3.3 · 未编号结论 · 印刷p.195 / PDF216

原文（忠实转述）：Lower-dimensional smooth submanifolds have zero microcanonical measure.

```lean
-- MolecularDynamics.Chapter05Review.lowerDimensionNull_statement
def lowerDimensionNull_statement : Prop := ∀ n d (H : E n → ℝ) c (g : E d → E n)
    (K : Set (E d)), d+1 < n → ContDiff ℝ 1 H → regularEnergy H c →
    ContDiff ℝ 1 g → IsCompact K →
    g '' K ⊆ energySurface H c → (microMeasure H c) (g '' K)=0
```

差异、假设及缺口：需Hausdorff维数/Lipschitz图像与几何measure桥接；非任意低维拓扑集。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter05/Statements.lean:111`。

### CH05-055 · §5.3.3 · 定义 · 印刷p.195 / PDF216

原文（忠实转述）：A microcanonical observable average is integral g against microMeasure, denoted angle brackets.

```lean
-- MolecularDynamics.Chapter05Review.microAverage
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
```

差异、假设及缺口：可积观测量；surface密度/ambient奇异measure分清。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:70`。

### CH05-056 · §5.4 · 定义 · 印刷p.195 / PDF216

原文（忠实转述）：The finite trajectory average is (1/T) integral_0^T g(z(t)); its infinite limit is (5.9).

```lean
-- MolecularDynamics.Chapter05Review.timeAverage
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))

-- MolecularDynamics.Chapter05Review.hasTimeAverage
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```

差异、假设及缺口：T>0；以Tendsto表达极限存在。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:76;MolecularDynamics/Chapter05/ReviewDefinitions.lean:77`。

### CH05-057 · §5.4 · 未编号结论 · 印刷p.197 / PDF218

原文（忠实转述）：The time average of a conserved first integral equals its initial value.

```lean
-- MolecularDynamics.Chapter05Review.conservedAverage_proved
theorem conservedAverage_proved {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : timeAverage z g T=a
```

差异、假设及缺口：给定轨道守恒值，有限时间积分完全证明；额外第一积分构造另列。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:15`。

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

### CH05-059 · §5.4.1 · 定义 · 印刷p.197 / PDF218

原文（忠实转述）：Invariant-set ergodicity means every measurable flow-invariant set has probability zero or one.

```lean
-- MolecularDynamics.Chapter05Review.setErgodic
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X) : Prop :=
  ∀ A : Set X, MeasurableSet A → flowInvariant Φ A → μ A=0 ∨ μ A=1

-- MolecularDynamics.Chapter05Review.flowInvariant
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```

差异、假设及缺口：真实概率Measure与全实时间流。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:83;MolecularDynamics/Chapter05/ReviewDefinitions.lean:82`。

### CH05-060 · §5.4.1 · 未编号结论 · 印刷p.198 / PDF219

原文（忠实转述）：For an invariant set the complement indicator is identically zero along its initial trajectories.

```lean
-- MolecularDynamics.Chapter05Review.invariantIndicator_proved
theorem invariantIndicator_proved {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0
```

差异、假设及缺口：集合实际不变性质的完整推导。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:18`。

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

### CH05-062 · §5.4.1 · 未编号结论 · 印刷p.198 / PDF219

原文（忠实转述）：A nonergodic system has an invariant set of probability strictly between zero and one.

```lean
-- MolecularDynamics.Chapter05Review.nonergodicSet_statement
def nonergodicSet_statement : Prop := ∀ n (μ : Measure (E n)) Φ,
  IsProbabilityMeasure μ → (¬setErgodic μ Φ ↔
    ∃ A : Set (E n),MeasurableSet A ∧ flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1)
-- A faithful persistence obligation, not a claim that the numerical example
-- meets KAM hypotheses. Analyticity, nondegeneracy and Diophantine conditions
-- are explicit; no invariant torus is supplied as an assumption.
```

差异、假设及缺口：显式概率/不变性前提；逻辑等价仅陈述。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:121`。

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

### CH05-064 · §5.4.1 · 定义 · 印刷p.199 / PDF220

原文（忠实转述）：Mixing means transported initial densities converge weakly to the invariant measure.

```lean
-- MolecularDynamics.Chapter05Review.mixing
def mixing {n : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n) : Prop :=
  ∀ r φ : E n → ℝ, density r → (∫ z,r z ∂μ)=1 → Continuous φ →
    Bornology.IsBounded (Set.range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (average μ φ))
```

差异、假设及缺口：对有界连续test与AC初始概率；比单轨道ergodicity强。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:85`。

### CH05-065 · §5.5 · 定义 · 印刷p.203 / PDF224

原文（忠实转述）：The temporal correlation is k times average of a(F_t(z)) dot b(z).

```lean
-- MolecularDynamics.Chapter05Review.correlation
def correlation {n d : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (a b : E n → E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

差异、假设及缺口：真实vector dot；k归一化须非零零时刻相关。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:89`。

### CH05-066 · §5.5 · 未编号结论 · 印刷p.204 / PDF225

原文（忠实转述）：The correlation can be expressed as an observable pullback spatial average.

```lean
-- MolecularDynamics.Chapter05Review.correlationPullback_proved
theorem correlationPullback_proved {n d : ℕ} (μ : Measure (E n)) Φ (a b : E n → E d) k t :
    correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

差异、假设及缺口：定义重写完整证明。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:23`。

### CH05-067 · §5.5 · 未编号结论 · 印刷p.204 / PDF225

原文（忠实转述）：For an ergodic flow the correlation equals the trajectory average of a(z(s+t)) dot b(z(s)).

```lean
-- MolecularDynamics.Chapter05Review.correlationTime_statement
def correlationTime_statement : Prop := ∀ n d (μ : Measure (E n)) Φ
    (a b : E n → E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, hasTimeAverage (fun s => Φ s z) g (average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (correlation μ Φ a b k t))
```

差异、假设及缺口：AE初值，给定lag逐次量词；semigroup与可积性。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:138`。

### CH05-068 · §5.5 · 定义 · 印刷p.204 / PDF225

原文（忠实转述）：Velocity autocorrelation is the correlation divided by its zero-lag value.

```lean
-- MolecularDynamics.Chapter05Review.velocityCorrelation
def velocityCorrelation {n d : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (v : E n → E d) (t : ℝ) := correlation μ Φ v v 1 t/correlation μ Φ v v 1 0
```

差异、假设及缺口：分母正才可归一；不假设任意v都非零。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:91`。

### CH05-069 · §5.5 · 定义 · 印刷p.204 / PDF225

原文（忠实转述）：The transition probability from A to B at lag t is average(1_A 1_B∘F_t)/average(1_A).

```lean
-- MolecularDynamics.Chapter05Review.transitionProbability
def transitionProbability {n : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (A B : Set (E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal
```

差异、假设及缺口：mu(A)>0；确定流endpoint概率非首达时间。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:93`。

### CH05-070 · §5.5 · 未编号结论 · 印刷p.205 / PDF226

原文（忠实转述）：Pushforward/pullback duality gives integral phi against evolved density equals integral phi∘F_t against the initial measure, (5.10).

```lean
-- MolecularDynamics.Chapter05Review.measureDuality_statement
def measureDuality_statement : Prop := ∀ n (μ : Measure (E n)) Φ (φ : E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (measurePropagator Φ t μ) →
    average (measurePropagator Φ t μ) φ=average μ (pullback Φ φ t)
```

差异、假设及缺口：真实Measure.map和可测/可积条件；基础库可用，时间盒保留。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:145`。

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

### CH05-072 · §5.6 · 定义 · 印刷p.206 / PDF227

原文（忠实转述）：The discrete finite average is n^-1 sum_(k=0)^n g(z_k) in the printed formula.

```lean
-- MolecularDynamics.Chapter05Review.discreteAveragePrinted
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)

-- MolecularDynamics.Chapter05Review.discreteAverage
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
```

差异、假设及缺口：书写n+1项却除n；补标准n项版，有限n0除零不作概率解释。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:96;MolecularDynamics/Chapter05/ReviewDefinitions.lean:98`。

### CH05-073 · §5.6 · 定义 · 印刷p.206 / PDF227

原文（忠实转述）：A numerical method induces a distribution propagator by pushforward.

```lean
-- MolecularDynamics.Chapter05Review.discretePropagator
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (μ : Measure X) := Measure.map G μ
```

差异、假设及缺口：真实measure map，不声称modified equation存在。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:100`。

### CH05-074 · §5.6 · 定义 · 印刷p.206 / PDF227

原文（忠实转述）：The finite modified field is f+h^r f_r and its forward differential expression splits linearly.

```lean
-- MolecularDynamics.Chapter05Review.modifiedField
def modifiedField {n : ℕ} (f fr : E n → E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```

差异、假设及缺口：不将BEA形式展开误作实际精确流。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:101`。

### CH05-075 · §5.6 · 未编号结论 · 印刷p.206 / PDF227

原文（忠实转述）：The Liouvillian of f+h^r f_r is the sum of the corresponding expressions.

```lean
-- MolecularDynamics.Chapter05Review.modifiedLiouvillian_statement
def modifiedLiouvillian_statement : Prop := ∀ n (f fr : E n → E n) (u : E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  liouvillian (modifiedField f fr h r) u z=liouvillian f u z+h^r*liouvillian fr u z
```

差异、假设及缺口：真实微分运算，补可微条件。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:159`。

### CH05-076 · §5.6 · 未编号结论 · 印刷p.207 / PDF228

原文（忠实转述）：Forward Euler oscillator admits only the point mass at the origin as an invariant probability measure for h≠0.

```lean
-- MolecularDynamics.Chapter05Review.eulerInvariant_statement
def eulerInvariant_statement : Prop := ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (E 2),
  IsProbabilityMeasure μ → MeasurePreserving (forwardEuler h) μ μ → μ=diracMeasure 2
```

差异、假设及缺口：原文两分量都趋∞并非严格成立；改述范数，delta不吸引。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:162`。

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

### CH05-078 · §5.6 · 未编号结论 · 印刷p.207 / PDF228

原文（忠实转述）：Symplectic Euler preserves its modified quadratic oscillator Hamiltonian.

```lean
-- MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved
theorem symplecticEulerShadow_proved : symplecticEulerShadow_statement
```

差异、假设及缺口：既有完整有限模型证明，稳定椭圆需abs(h Omega)<2。

状态：**proved**；位置：`MolecularDynamics/Chapter05/ReviewProofs.lean:47`。

### CH05-079 · §5.6 · 未编号结论 · 印刷p.207 / PDF228

原文（忠实转述）：An integrable normalized density depending on the preserved quadratic invariant remains invariant.

```lean
-- MolecularDynamics.Chapter05Review.symplecticEulerDensity_statement
def symplecticEulerDensity_statement : Prop := ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  probabilityDensity (r ∘ shadowOscillator h) →
    MeasurePreserving (symplecticEuler h) (densityMeasure (r ∘ shadowOscillator h))
      (densityMeasure (r ∘ shadowOscillator h))
```

差异、假设及缺口：补线性体积保留与可积；不推一般数值ergodicity。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:169`。

### CH05-080 · §5.6 · 定义 · 印刷p.208 / PDF229

原文（忠实转述）：The leading Verlet modified Hamiltonian has the displayed Hessian and force-square h² coefficient.

```lean
-- MolecularDynamics.Chapter02Review.takahashiPotential
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i

-- MolecularDynamics.Chapter05Review.verletShadow2
def verletShadow2 {n : ℕ} (m : Fin n → ℝ) (U : E n → ℝ) (h : ℝ) (z : Phase n) :=
  let v : E n := WithLp.toLp 2 fun i => z.2 i/m i
  (∑ i,z.2 i^2/m i)/2+U z.1+h^2/24*
    (2*(fderiv ℝ (fderiv ℝ U) z.1) v v-∑ i,(grad U z.1 i)^2/m i)
```

差异、假设及缺口：只定义有限修正函数，不声称全阶形式级数收敛。

状态：**defined**；位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:134;MolecularDynamics/Chapter05/ReviewDefinitions.lean:107`。

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

### CH05-082 · §5.6 · 定义 · 印刷p.209 / PDF230

原文（忠实转述）：The perturbation displacement is u=epsilon eta w/(w dot grad H).

```lean
-- MolecularDynamics.Chapter05Review.perturbationDisplacement
def perturbationDisplacement {n : ℕ} (H η : E n → ℝ) (w : E n → E n) (ε : ℝ) (z : E n) :=
  (ε*η z/inner ℝ (w z) (grad H z)) • w z

-- MolecularDynamics.Chapter05Review.perturbationCorrection
def perturbationCorrection {n : ℕ} (H η g : E n → ℝ) (w : E n → E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := perturbationDisplacement H η w ε
  microAverage Hε c (divergence (fun z => g z • u z))-
    microAverage Hε c g*microAverage Hε c (divergence u)
```

差异、假设及缺口：实际div(g u)而不是grad g dot u；真实Euclidean内积。

状态：**defined**；位置：`MolecularDynamics/Chapter05/ReviewDefinitions.lean:111;MolecularDynamics/Chapter05/ReviewDefinitions.lean:113`。

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

### CH05-085 · §5.6 · 未编号结论 · 印刷p.209 / PDF230

原文（忠实转述）：Choosing w=grad H satisfies transversality on a regular energy surface.

```lean
-- MolecularDynamics.Chapter05Review.gradientTransverse_statement
def gradientTransverse_statement : Prop := ∀ n (H : E n → ℝ) c,
  (∀ z ∈ energySurface H c,grad H z ≠ 0) →
    ∀ z ∈ energySurface H c,inner ℝ (grad H z) (grad H z) ≠ 0
```

差异、假设及缺口：有限Euclidean平方范数正；本次不推广几何理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:186`。

### CH05-086 · §5.6 · 未编号结论 · 印刷p.209 / PDF230

原文（忠实转述）：The perturbation formula applies to dynamical averages viewed as stationary observables.

```lean
-- MolecularDynamics.Chapter05Review.dynamicalCorrection_statement
def dynamicalCorrection_statement : Prop :=
  ∀ n d (H η : E n → ℝ) (w : E n → E n) (a b : E n → E d) (Φ : ℝ → E n → E n) c t,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ w →
    ContDiff ℝ ⊤ a → ContDiff ℝ ⊤ b → ContDiff ℝ ⊤ (Φ t) → regularEnergy H c →
    (∃ δ > 0, ∃ K : Set (E n), IsCompact K ∧ energySurface H c ⊆ K ∧
      (∀ z ∈ K,inner ℝ (w z) (grad H z) ≠ 0) ∧
      ∀ ε ∈ Ioo (-δ) δ,regularEnergy (fun z => H z+ε*η z) c ∧
        energySurface (fun z => H z+ε*η z) c ⊆ K) →
    let g := fun z => inner ℝ (a (Φ t z)) (b z)
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |microAverage H c g-microAverage (fun z => H z+ε*η z) c g-
        perturbationCorrection H η g w c ε| ≤ C*ε^2
```

差异、假设及缺口：固定lag的真实光滑pullback observable；流参数扰动不可自动忽略。

状态：**statement_only**；位置：`MolecularDynamics/Chapter05/Statements.lean:189`。
