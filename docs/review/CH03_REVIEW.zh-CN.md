# 第3章人工审阅材料

印刷97–136 / PDF119–158，止于印刷136的Exercises标题；数值实验、图表及纯实现伪代码排除。
清单为唯一进度来源；定义不计为证明。Prop定义编译通过不表示命题成立。
忠实转述来自用户提供的教材PDF；问题公式以原页图像复核。代码块保留陈述和必要定义体，不贴证明；须在工程导入与对应命名空间/节参数环境中阅读。
原文语义尚待导师审阅；机器验收证据见本章VALIDATION.json及check-full目录。

| 状态 | 条数 |
| --- | ---: |
| defined | 51 |
| proved | 39 |
| statement_only | 47 |
| weakened | 2 |
| not_formalizable_now | 4 |
| 合计 | 143 |

已证明结论数：39（按清单行统计，重复映射同一证明不是独立定理）。

需要人工判断的问题：

1. Theorem3.1的C^infinity、每个固定k的代数长时间界，是否应与额外解析性下的指数小匹配/指数长时间界严格区分？
2. 形式级数、有限截断和实际收敛级数是否清楚区分？全阶构造与匹配仅陈述，有限系数和有条件能量界已有证明。
3. 印刷105的Lie–Poisson commutator符号前后颠倒、108的不同步长log可交换断言、113的处理器能量展开遗漏U，是否接受所附勘误？Verlet的有限系数定义与高阶匹配证明须分开。
4. 印刷128一般involution的反演场应使用R而非R转置；130的PRK只能保证分块变换等变；131转置谱不能沿用同一特征向量。能量/辛性no-go需无额外第一积分等条件，是否接受这些限定？
5. 硬球动量有跳跃，原文一/二阶误差应采用事件时间对齐还是只比较位置？134端点碰撞三阶说法与显示线性项矛盾，135在tc=hmax时未反射，136 second却写alpha一阶导，是否需修正文句/算法？投影须非零动能与E-U≥0。

### CH03-001 · §3 · 未编号结论 · 印刷p.97 / PDF119

原文（忠实转述）：A smooth near-identity symplectic integrator admits a formal modified Hamiltonian to arbitrary finite order.

```lean
-- MolecularDynamics.Chapter03Review.modifiedConstruction_statement
def modifiedConstruction_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G

-- MolecularDynamics.Chapter03Review.smoothSymplecticData
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r

-- MolecularDynamics.Chapter03Review.actualFlowNearCompact
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

-- MolecularDynamics.Chapter03Review.localOrder
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)

-- MolecularDynamics.Chapter03Review.finiteMatching
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)

-- MolecularDynamics.Chapter03Review.truncatedFlow
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

差异及额外假设：局部凸开域；完整构造与匹配仅陈述；缺形式jet的Hamiltonian构造、逐阶匹配及局部ODE统一余项；finiteMatching是所需结论，未被用作完整构造的假设。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:49;MolecularDynamics/Chapter03/Statements.lean:31;MolecularDynamics/Chapter03/Statements.lean:25;MolecularDynamics/Chapter03/Statements.lean:20;MolecularDynamics/Chapter03/Statements.lean:42;MolecularDynamics/Chapter03/ReviewDefinitions.lean:87`。

### CH03-002 · §3.1 · 定义 · 印刷p.98 / PDF120

原文（忠实转述）：Adjoint symplectic Euler for the oscillator is Q=q+h p,P=p-h Omega^2 Q.

```lean
-- MolecularDynamics.Chapter03Review.oscillatorAdjointEuler
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```

差异及额外假设：数学算法，排除数值六点轨道实验。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:14`。

### CH03-003 · §3.1 · 定义 · 印刷p.98 / PDF120

原文（忠实转述）：The modified oscillator invariant is (p^2+h Omega^2 p q+Omega^2 q^2)/2, (3.1).

```lean
-- MolecularDynamics.Chapter03Review.oscillatorShadow
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2
```

差异及额外假设：精确实数二次式。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:18`。

### CH03-004 · §3.1 · 未编号结论 · 印刷p.98 / PDF120

原文（忠实转述）：The physical oscillator energy is generally not preserved by adjoint symplectic Euler.

```lean
-- MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_proved
theorem oscillatorEnergyFailure_proved : oscillatorEnergyFailure_statement

-- MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_statement
def oscillatorEnergyFailure_statement : Prop :=
  oscillatorEnergy 1 (oscillatorAdjointEuler 1 1 (1,0)) ≠ oscillatorEnergy 1 (1,0)
```

差异及额外假设：给具体非零误差，不声称所有初值都漂移；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:11;MolecularDynamics/Chapter03/Statements.lean:93`。

### CH03-005 · §3.1 · 未编号结论 · 印刷p.99 / PDF121

原文（忠实转述）：The modified oscillator Hamiltonian (3.1) is exactly preserved.

```lean
-- MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved
theorem oscillatorShadowInvariant_proved : oscillatorShadowInvariant_statement

-- MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_statement
def oscillatorShadowInvariant_statement : Prop :=
  ∀ Ω h z, oscillatorShadow Ω h (oscillatorAdjointEuler Ω h z)=oscillatorShadow Ω h z
```

差异及额外假设：可有限代数证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:14;MolecularDynamics/Chapter03/Statements.lean:95`。

### CH03-006 · §3.1 · 未编号结论 · 印刷p.99 / PDF121

原文（忠实转述）：For abs(h Omega)<2 the modified oscillator level sets are ellipses.

```lean
-- MolecularDynamics.Chapter03Review.shadowPositive_statement
def shadowPositive_statement : Prop :=
  ∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
    (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
    ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z, oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2
```

差异及额外假设：正频率和正能量；边界与不稳定步长排除。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:97`。

### CH03-007 · §3.1 · 未编号结论 · 印刷p.100 / PDF122

原文（忠实转述）：Euler oscillator energy grows without bound for a nonzero fixed step and nonzero initial energy.

```lean
-- MolecularDynamics.Chapter03Review.eulerOscillatorGrowth_statement
def eulerOscillatorGrowth_statement : Prop :=
  ∀ Ω h : ℝ, Ω ≠ 0 → h ≠ 0 → ∀ z : ℝ × ℝ, 0 < oscillatorEnergy Ω z →
    Tendsto (fun ν : ℕ => oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z)) atTop atTop
```

差异及额外假设：Omega非零、初值非零，避免平衡点例外。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:101`。

### CH03-008 · §3.1 · 定义 · 印刷p.100 / PDF122

原文（忠实转述）：The modified Hamiltonian has formal expansion H+h^r H_r+h^(r+1) H_(r+1)+... .

```lean
-- MolecularDynamics.Chapter03Review.formalHamiltonian
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```

差异及额外假设：形式PowerSeries，不宣称收敛。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:20`。

### CH03-009 · §3.1 · 定义 · 印刷p.100 / PDF122

原文（忠实转述）：The modified field is J grad of each coefficient in the Hamiltonian series.

```lean
-- MolecularDynamics.Chapter03Review.formalHamiltonianField
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n)
    (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
```

差异及额外假设：逐系数定义。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:26`。

### CH03-010 · §3.2 · 定义 · 印刷p.100 / PDF122

原文（忠实转述）：The Lie derivative L_f phi is f dot grad phi.

```lean
-- MolecularDynamics.textbookLieDerivative
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

差异及额外假设：实际Fréchet导数。

状态：**defined**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:25`。

### CH03-011 · §3.2 · 未编号结论 · 印刷p.100 / PDF122

原文（忠实转述）：The derivative of an observable along an actual solution equals L_f phi.

```lean
-- MolecularDynamics.hasDerivAt_textbookLieDerivative
theorem hasDerivAt_textbookLieDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t
```

差异及额外假设：实际时间链式法则；只需局部解。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:35`。

### CH03-012 · §3.2 · 未编号结论 · 印刷p.101 / PDF123

原文（忠实转述）：The second derivative along a solution equals L_f^2 phi.

```lean
-- MolecularDynamics.hasDerivAt_textbookLieDerivative_second
theorem hasDerivAt_textbookLieDerivative_second (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ)
    (hγ : ∀ t, HasDerivAt γ (f (γ t)) t) (t : ℝ) :
    HasDerivAt (fun u => deriv (fun v => φ (γ v)) u)
      (textbookLieDerivative f (textbookLieDerivative f φ) (γ t)) t
```

差异及额外假设：C1场/C2观测量；实际导数。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:48`。

### CH03-013 · §3.2 · 定义 · 印刷p.101 / PDF123

原文（忠实转述）：Repeated Lie derivatives give the formal operator exponential coefficients 1/j!.

```lean
-- MolecularDynamics.textbookFormalOperatorExponential
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

差异及额外假设：在实非交换代数上；不宣称实际算子收敛。

状态：**defined**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:22`。

### CH03-014 · §3.2 · 定义 · 印刷p.101 / PDF123

原文（忠实转述）：The formal evolution of an observable is sum t^j L_f^j phi/j!.

```lean
-- MolecularDynamics.Chapter03Review.formalObservable
def formalObservable {n : ℕ} (f : Q n → Q n) (φ : Q n → ℝ) (z : Q n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => ((textbookLieDerivative f)^[j] φ) z/(Nat.factorial j : ℝ))
```

差异及额外假设：形式级数。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:33`。

### CH03-015 · §3.2 · 未编号结论 · 印刷p.101 / PDF123

原文（忠实转述）：A finite Taylor expansion along the flow has repeated Lie derivatives and a remainder of order k+1.

```lean
-- MolecularDynamics.Chapter03Review.lieTaylor_statement
def lieTaylor_statement : Prop :=
  ∀ (n k : ℕ) (f : Q n → Q n) (φ : Q n → ℝ) (γ : ℝ → Q n),
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ φ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∃ C > 0, ∃ δ > 0, ∀ t ∈ Ioo (-δ) δ,
      |φ (γ t)-∑ j ∈ Finset.range (k+1), t^j/(Nat.factorial j:ℝ)*
        ((textbookLieDerivative f)^[j] φ) (γ 0)| ≤ C*|t|^(k+1)
```

差异及额外假设：补足光滑阶数；原文明确不处理无限级数收敛。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:105`。

### CH03-016 · §3.2 · 未编号结论 · 印刷p.101 / PDF123

原文（忠实转述）：The flow components are given by the evolution operator acting on coordinate functions.

```lean
-- MolecularDynamics.Chapter03Review.flowObservable_statement
def flowObservable_statement : Prop :=
  ∀ (n : ℕ) (f : Q n → Q n) (D : Set (Q n)) (Φ : ℝ → Q n → Q n) η,
    actualFlow f D Φ η → ∀ z ∈ D, ∀ t ∈ Ioo (-η) η, ∀ i : Fin n,
      HasDerivAt (fun s => Φ s z i) (f (Φ t z) i) t
```

差异及额外假设：解释为实际pullback；不把形式exp当收敛级数。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:112`。

### CH03-017 · §3.2 · 定义 · 印刷p.102 / PDF124

原文（忠实转述）：The Poisson bracket is grad F^T J grad G.

```lean
-- MolecularDynamics.textbookPoissonBracket
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```

差异及额外假设：教材符号。

状态：**defined**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:121`。

### CH03-018 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：The Poisson bracket equals the sum of F_q G_p-G_q F_p.

```lean
-- MolecularDynamics.textbookPoissonBracket_coordinates
theorem textbookPoissonBracket_coordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1))
```

差异及额外假设：实际偏导。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:126`。

### CH03-019 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：The Poisson bracket is bilinear in both arguments.

```lean
-- MolecularDynamics.textbookPoissonBracket_linear_right
theorem textbookPoissonBracket_linear_right (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hG : DifferentiableAt ℝ G z) (hH : DifferentiableAt ℝ H z) :
    textbookPoissonBracket F (fun x => α * G x + β * H x) z =
      α * textbookPoissonBracket F G z + β * textbookPoissonBracket F H z

-- MolecularDynamics.textbookPoissonBracket_linear_left
theorem textbookPoissonBracket_linear_left (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hH : DifferentiableAt ℝ H z) :
    textbookPoissonBracket (fun x => α * F x + β * H x) G z =
      α * textbookPoissonBracket F G z + β * textbookPoissonBracket H G z
```

差异及额外假设：相应可微条件。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:154;MolecularDynamics/Chapter03/LiePoisson.lean:241`。

### CH03-020 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：The Poisson bracket is skew symmetric.

```lean
-- MolecularDynamics.textbookPoissonBracket_skew
theorem textbookPoissonBracket_skew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z
```

差异及额外假设：教材J的反对称性。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:141`。

### CH03-021 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：The Poisson bracket of a function with itself is zero.

```lean
-- MolecularDynamics.textbookPoissonBracket_self
theorem textbookPoissonBracket_self (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0
```

差异及额外假设：精确恒等式。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:148`。

### CH03-022 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：The Poisson bracket satisfies the Jacobi identity.

```lean
-- MolecularDynamics.textbookPoissonBracket_jacobi
theorem textbookPoissonBracket_jacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0
```

差异及额外假设：C2三函数；实际Hessian对称性。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:189`。

### CH03-023 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：Along a Hamiltonian trajectory, the derivative of F is {F,H}.

```lean
-- MolecularDynamics.hasDerivWithinAt_textbookPoissonBracket
theorem hasDerivWithinAt_textbookPoissonBracket (F H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (s : Set ℝ) (t : ℝ)
    (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) s t) :
    HasDerivWithinAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) s t
```

差异及额外假设：真实Hamiltonian ODE。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:217`。

### CH03-024 · §3.2 · 未编号结论 · 印刷p.102 / PDF124

原文（忠实转述）：L_(J grad H) F={F,H}.

```lean
-- MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson
theorem textbookLieDerivative_hamiltonian_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H
```

差异及额外假设：固定符号。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:212`。

### CH03-025 · §3.2 · notation · 印刷p.102 / PDF124

原文（忠实转述）：L_H is shorthand for the Lie derivative along J grad H.

```lean
-- MolecularDynamics.Chapter03Review.hamiltonianLie
def hamiltonianLie {n : ℕ} (H φ : SymplecticCoordinates n → ℝ) : SymplecticCoordinates n → ℝ :=
  textbookLieDerivative (textbookHamiltonianVectorField H) φ
```

差异及额外假设：观测量算子。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:31`。

### CH03-026 · §3.3 · 未编号结论 · 印刷p.103 / PDF125

原文（忠实转述）：L_(H1+H2)=L_H1+L_H2.

```lean
-- MolecularDynamics.textbookHamiltonianLieDerivative_add
theorem textbookHamiltonianLieDerivative_add (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z
```

差异及额外假设：可微H1/H2。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:252`。

### CH03-027 · §3.3 · 定义 · 印刷p.103 / PDF125

原文（忠实转述）：A splitting evolution operator is exp(h L_H1) exp(h L_H2).

```lean
-- MolecularDynamics.Chapter03Review.formalSplitting
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B
```

差异及额外假设：形式算子乘积，不混同状态映射组合次序。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:36`。

### CH03-028 · §3.3 · 未编号结论 · 印刷p.103 / PDF125

原文（忠实转述）：The exact formal exponential coefficients through cubic order are (A+B)^j/j!.

```lean
-- MolecularDynamics.textbookFormalOperatorExponential_coeff
theorem textbookFormalOperatorExponential_coeff (A : R) (n : ℕ) :
    PowerSeries.coeff n (textbookFormalOperatorExponential A) =
      (1 / (n.factorial : ℝ)) • A ^ n
```

差异及额外假设：纯形式代数。

状态：**proved**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:25`。

### CH03-029 · §3.3 · 未编号结论 · 印刷p.104 / PDF126

原文（忠实转述）：The product exponential has coefficients 1,A+B,(A^2+2AB+B^2)/2 and (A^3+3A^2B+3AB^2+B^3)/6.

```lean
-- MolecularDynamics.textbookFormalOperatorProduct_coeff_zero
theorem textbookFormalOperatorProduct_coeff_zero (A B : R) :
    PowerSeries.coeff 0
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) = 1

-- MolecularDynamics.textbookFormalOperatorProduct_coeff_one
theorem textbookFormalOperatorProduct_coeff_one (A B : R) :
    PowerSeries.coeff 1
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) = A + B

-- MolecularDynamics.textbookFormalOperatorProduct_coeff_two
theorem textbookFormalOperatorProduct_coeff_two (A B : R) :
    PowerSeries.coeff 2
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      (1 / 2 : ℝ) • A ^ 2 + A * B + (1 / 2 : ℝ) • B ^ 2

-- MolecularDynamics.textbookFormalOperatorProduct_coeff_three
theorem textbookFormalOperatorProduct_coeff_three (A B : R) :
    PowerSeries.coeff 3
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      (1 / 6 : ℝ) • A ^ 3 + (1 / 2 : ℝ) • (A ^ 2 * B) +
        (1 / 2 : ℝ) • (A * B ^ 2) + (1 / 6 : ℝ) • B ^ 3
```

差异及额外假设：顺序AB保留非交换性。

状态：**proved**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:47;MolecularDynamics/Chapter03/FormalOperatorSeries.lean:52;MolecularDynamics/Chapter03/FormalOperatorSeries.lean:58;MolecularDynamics/Chapter03/FormalOperatorSeries.lean:67`。

### CH03-030 · §3.3 · 未编号结论 · 印刷p.104 / PDF126

原文（忠实转述）：The degree-two difference of product and sum exponentials is [A,B]/2.

```lean
-- MolecularDynamics.textbookFormalOperatorDifference_coeff_two
theorem textbookFormalOperatorDifference_coeff_two (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A)
```

差异及额外假设：完整形式系数证明。

状态：**proved**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:79`。

### CH03-031 · §3.3 · 未编号结论 · 印刷p.104 / PDF126

原文（忠实转述）：The cubic difference is (2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)/6.

```lean
-- MolecularDynamics.textbookFormalOperatorDifference_coeff_three
theorem textbookFormalOperatorDifference_coeff_three (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A)
```

差异及额外假设：完整非交换系数证明。

状态：**proved**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:89`。

### CH03-032 · §3.3 · 定义 · 印刷p.104 / PDF126

原文（忠实转述）：The commutator is [A,B]=AB-BA.

```lean
-- MolecularDynamics.Chapter03Review.commutator
def commutator {R : Type*} [Ring R] (A B : R) : R := A*B-B*A
```

差异及额外假设：非交换实代数。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:35`。

### CH03-033 · §3.3 · 未编号结论 · 印刷p.104 / PDF126

原文（忠实转述）：The splitting leading defect is h^2 [L_H1,L_H2]/2 at the formal level.

```lean
-- MolecularDynamics.textbookFormalOperatorDifference_coeff_two
theorem textbookFormalOperatorDifference_coeff_two (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A)
```

差异及额外假设：只声称形式系数，实际范数余项另需正则条件。

状态：**proved**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:79`。

### CH03-034 · §3.3 · 未编号结论 · 印刷p.105 / PDF127

原文（忠实转述）：[L_H1,L_H2]F=L_{H2,H1}F; the next display reverses the bracket.

```lean
-- MolecularDynamics.textbookHamiltonianLieDerivative_commutator
theorem textbookHamiltonianLieDerivative_commutator
    (F H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiffAt ℝ 2 F z) (hH₁ : ContDiffAt ℝ 2 H₁ z)
    (hH₂ : ContDiffAt ℝ 2 H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField H₁)
        (textbookLieDerivative (textbookHamiltonianVectorField H₂) F) z -
      textbookLieDerivative (textbookHamiltonianVectorField H₂)
        (textbookLieDerivative (textbookHamiltonianVectorField H₁) F) z =
      textbookLieDerivative (textbookHamiltonianVectorField
        (textbookPoissonBracket H₂ H₁)) F z

-- MolecularDynamics.Chapter03Review.leadingShadowPrinted_statement
def leadingShadowPrinted_statement : Prop :=
  ∀ (n : ℕ) (A B F : SymplecticCoordinates n → ℝ), ContDiff ℝ 2 A →
    ContDiff ℝ 2 B → ContDiff ℝ 2 F → ∀ z,
    hamiltonianLie A (hamiltonianLie B F) z-hamiltonianLie B (hamiltonianLie A F) z=
      hamiltonianLie (textbookPoissonBracket A B) F z
```

差异及额外假设：既有完整证明给正确{H2,H1}；补印刷{H1,H2}字面Prop。

状态：**weakened**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:264;MolecularDynamics/Chapter03/Statements.lean:117`。

### CH03-035 · §3.3 · 未编号结论 · 印刷p.105 / PDF127

原文（忠实转述）：The first modified exponential correction is R=[A,B]/2.

```lean
-- MolecularDynamics.textbookFormalModifiedExponential_matches_product
theorem textbookFormalModifiedExponential_matches_product (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A)))
```

差异及额外假设：已证明所有n<3系数匹配，非完整BCH收敛。

状态：**proved**。位置：`MolecularDynamics/Chapter03/FormalOperatorSeries.lean:187`。

### CH03-036 · §3.3 · 未编号结论 · 印刷p.105 / PDF127

原文（忠实转述）：The leading shadow Hamiltonian is H1+H2+h{H1,H2}/2 under the displayed convention.

```lean
-- MolecularDynamics.Chapter03Review.leadingShadowHamiltonian_statement
def leadingShadowHamiltonian_statement : Prop :=
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3
```

差异及额外假设：原文Lie commutator符号与此系数需一起审阅；状态/观测量顺序须区分。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:122`。

### CH03-037 · §3.3 · 未编号结论 · 印刷p.106 / PDF128

原文（忠实转述）：BCH logarithm has the displayed degree-two, degree-three and degree-four nested commutators.

```lean
-- MolecularDynamics.Chapter03Review.bch4_statement
def bch4_statement : Prop :=
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j < 5,
    PowerSeries.coeff j (formalLog (formalSplitting A B))=PowerSeries.coeff j (bchLog4 A B)
```

差异及额外假设：真实形式幂级数有限阶等式；高阶未证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:131`。

### CH03-038 · §3.3 · 定义 · 印刷p.106 / PDF128

原文（忠实转述）：A finite modified Hamiltonian uses nested Poisson bracket coefficients through h^3.

```lean
-- MolecularDynamics.Chapter03Review.bchHamiltonian3
def bchHamiltonian3 {n : ℕ} (A B : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  A z+B z+h/2*textbookPoissonBracket A B z+
    h^2/12*(textbookPoissonBracket A (textbookPoissonBracket A B) z-
      textbookPoissonBracket B (textbookPoissonBracket A B) z)-
    h^3/24*textbookPoissonBracket B (textbookPoissonBracket A (textbookPoissonBracket A B)) z
```

差异及额外假设：保留印刷公式作为有限函数；不声称匹配。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:48`。

### CH03-039 · §3.3 · 未编号结论 · 印刷p.106 / PDF128

原文（忠实转述）：The finite BCH Hamiltonian matches the splitting through the stated order.

```lean
-- MolecularDynamics.Chapter03Review.bchHamiltonianMatching_statement
def bchHamiltonianMatching_statement : Prop :=
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    matchesHamiltonian (bchHamiltonian3 A B) (fun h => Φ h ∘ Ψ h) K 4
```

差异及额外假设：需符号/映射顺序核对和更高系数推导。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:139`。

### CH03-040 · §3.3 · 未编号结论 · 印刷p.106 / PDF128

原文（忠实转述）：If H1 and H2 Poisson commute, their exact splitting has no error.

```lean
-- MolecularDynamics.Chapter03Review.commutingFlows_statement
def commutingFlows_statement : Prop :=
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ Ψ Χ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    (∀ z ∈ D, textbookPoissonBracket A B z=0) →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    actualFlow (textbookHamiltonianVectorField (fun z => A z+B z)) D Χ η →
    ∀ z ∈ D, ∀ h ∈ Ioo (-η/2) (η/2), Φ h (Ψ h z)=Χ h z
```

差异及额外假设：光滑、流存在、适当共域和完整时间范围。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:145`。

### CH03-041 · §3.3.1 · 定义 · 印刷p.106 / PDF128

原文（忠实转述）：The symplectic Euler modified Hamiltonian through h^3 is the displayed mechanical expression.

```lean
-- MolecularDynamics.Chapter03Review.symplecticEulerShadow3
def symplecticEulerShadow3 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z-h/2*(∑ i, invMass m z.2 i*grad U z.1 i)+
    h^2/12*((shadowTerms m U z).1+(shadowTerms m U z).2.1)-h^3/12*(shadowTerms m U z).2.2
```

差异及额外假设：质量正、实际梯度和Hessian；有限式与匹配分开。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:61`。

### CH03-042 · §3.3.1 · 未编号结论 · 印刷p.106 / PDF128

原文（忠实转述）：The mechanical symplectic Euler shadow expansion agrees to the displayed order.

```lean
-- MolecularDynamics.Chapter03Review.symplecticEulerShadowMatching_statement
def symplecticEulerShadowMatching_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (fun h z => symplecticEulerShadow3 m U h (unpack z))
      (textbookSymplecticEuler m U) B 4
```

差异及额外假设：真实局部流误差O(h5)；未证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:153`。

### CH03-043 · §3.3.2 · 定义 · 印刷p.107 / PDF129

原文（忠实转述）：Velocity Verlet is kick-drift-kick; position Verlet is drift-kick-drift, (3.3).

```lean
-- MolecularDynamics.Chapter02Review.coordinateVerlet
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)

-- MolecularDynamics.Chapter03Review.positionVerlet
def positionVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookPositionDrift m (h/2) ∘ textbookMomentumKick F h ∘ textbookPositionDrift m (h/2)
```

差异及额外假设：速度版复用第2章，位置版新增。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:138;MolecularDynamics/Chapter03/ReviewDefinitions.lean:64`。

### CH03-044 · §3.3.2 · 定义 · 印刷p.107 / PDF129

原文（忠实转述）：Velocity Verlet splits H as U/2,T,U/2.

```lean
-- MolecularDynamics.Chapter03Review.verletHamiltonianParts
def verletHamiltonianParts {n : ℕ} (T U : SymplecticCoordinates n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z => U z/2), T, (fun z => U z/2)]
```

差异及额外假设：有限三部分。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:67`。

### CH03-045 · §3.3.2 · 未编号结论 · 印刷p.107 / PDF129

原文（忠实转述）：Both Verlet variants are symplectic and self-adjoint.

```lean
-- MolecularDynamics.Chapter03Review.verletVariants_proved
theorem verletVariants_proved : verletVariants_statement

-- MolecularDynamics.Chapter03Review.verletVariants_statement
def verletVariants_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) ∧
      IsTextbookSymplecticMap (positionVerlet m (textbookPotentialForce U) h)) ∧
    (∀ h z, coordinateVerlet m (textbookPotentialForce U) (-h)
      (coordinateVerlet m (textbookPotentialForce U) h z)=z) ∧
    (∀ h z, positionVerlet m (textbookPotentialForce U) (-h)
      (positionVerlet m (textbookPotentialForce U) h z)=z)
```

差异及额外假设：复用既有kick/drift及伴随引理；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:65;MolecularDynamics/Chapter03/Statements.lean:158`。

### CH03-046 · §3.3.2 · 定义 · 印刷p.107 / PDF129

原文（忠实转述）：The printed Verlet shadow Hamiltonian includes the displayed h^2 and h^4 nested brackets.

```lean
-- MolecularDynamics.Chapter03Review.verletModifiedH
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)
```

差异及额外假设：印刷与kick/drift次序需审阅；定义不代表系数已证明。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:69`。

### CH03-047 · §3.3.2 · 未编号结论 · 印刷p.107 / PDF129

原文（忠实转述）：The printed nested-bracket Hamiltonian matches a Verlet variant through h^4.

```lean
-- MolecularDynamics.Chapter03Review.verletModifiedH_statement
def verletModifiedH_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (velocityVerletShadow2 m U) (coordinateVerlet m (textbookPotentialForce U)) B 3

-- MolecularDynamics.Chapter03Review.verletModifiedHPrinted_statement
def verletModifiedHPrinted_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (verletModifiedH (fun z => quadraticKinetic m (unpack z).2) (fun z => U (unpack z).1))
      (coordinateVerlet m (textbookPotentialForce U)) B 5
```

差异及额外假设：同时给明确速度Verlet与印刷版，不能混同两种Verlet。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:174;MolecularDynamics/Chapter03/Statements.lean:166`。

### CH03-048 · §3.3.2 · 未编号结论 · 印刷p.107 / PDF129

原文（忠实转述）：Symmetry removes odd powers from the modified Hamiltonian.

```lean
-- MolecularDynamics.Chapter03Review.modifiedEven_statement
def modifiedEven_statement : Prop :=
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j : ℕ,
    PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0
```

差异及额外假设：形式log奇性而非不同步长log互相可交换。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:178`。

### CH03-049 · §3.3.2 · 定义 · 印刷p.108 / PDF130

原文（忠实转述）：A Strang product is exp(t X/2) exp(t Y) exp(t X/2).

```lean
-- MolecularDynamics.Chapter03Review.formalStrang
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
```

差异及额外假设：非交换PowerSeries。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:38`。

### CH03-050 · §3.3.2 · 未编号结论 · 印刷p.108 / PDF130

原文（忠实转述）：Z_s and Z_t are claimed to commute for different step sizes.

```lean
-- MolecularDynamics.Chapter03Review.differentLogsCommute_statement
def differentLogsCommute_statement : Prop :=
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R) (s t : ℝ),
    commutator (formalLog (formalStrang (s • A) (s • B))) (formalLog (formalStrang (t • A) (t • B)))=0
```

差异及额外假设：字面一般不成立；保留待审，正确奇性不依赖此断言。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:181`。

### CH03-051 · §3.3.2 · 未编号结论 · 印刷p.108 / PDF130

原文（忠实转述）：A symmetric product times its negative-step counterpart is the identity.

```lean
-- MolecularDynamics.Chapter03Review.strangInverse_statement
def strangInverse_statement : Prop :=
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), formalStrang A B * formalStrang (-A) (-B)=1
```

差异及额外假设：纯形式级数反步关系。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:184`。

### CH03-052 · §3.3.2 · 未编号结论 · 印刷p.108 / PDF130

原文（忠实转述）：The cubic Strang log coefficient is [Y,[Y,X]]/12-[X,[X,Y]]/24, (3.7).

```lean
-- MolecularDynamics.Chapter03Review.strangCubic_statement
def strangCubic_statement : Prop :=
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B)
```

差异及额外假设：有限正式系数；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:186`。

### CH03-053 · §3.3.3 · 定义 · 印刷p.109 / PDF131

原文（忠实转述）：Yoshida uses three steps a h,b h,a h with 2a+b=1.

```lean
-- MolecularDynamics.Chapter03Review.yoshidaCompose
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```

差异及额外假设：保留负步长。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:76`。

### CH03-054 · §3.3.3 · 未编号结论 · 印刷p.109 / PDF131

原文（忠实转述）：The cancellation equations are 2a+b=1 and 2a^(2s+1)+b^(2s+1)=0.

```lean
-- MolecularDynamics.Chapter03Review.yoshidaCancellation_statement
def yoshidaCancellation_statement : Prop :=
  ∀ s : ℕ, 1 ≤ s → let ab := yoshidaCoefficients s
    2*ab.1+ab.2=1 ∧ 2*ab.1^(2*s+1)+ab.2^(2*s+1)=0 ∧ ab.2 < 0
```

差异及额外假设：有限代数参数条件。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:190`。

### CH03-055 · §3.3.3 · 定义 · 印刷p.109 / PDF131

原文（忠实转述）：Yoshida coefficients are a=1/(2-kappa), b=-kappa/(2-kappa), kappa^(2s+1)=2.

```lean
-- MolecularDynamics.Chapter03Review.yoshidaCoefficients
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```

差异及额外假设：采用Real.rpow给正实根；s≥1。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:78`。

### CH03-056 · §3.3.3 · 未编号结论 · 印刷p.109 / PDF131

原文（忠实转述）：The two cancellation equations have the unique real solution stated.

```lean
-- MolecularDynamics.Chapter03Review.yoshidaUnique_statement
def yoshidaUnique_statement : Prop :=
  ∀ s : ℕ, 1 ≤ s → ∀ a b : ℝ,
    (2*a+b=1 ∧ 2*a^(2*s+1)+b^(2*s+1)=0) ↔ (a,b)=yoshidaCoefficients s
```

差异及额外假设：奇次幂根唯一与非零分母；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:193`。

### CH03-057 · §3.3.3 · 未编号结论 · 印刷p.109 / PDF131

原文（忠实转述）：A symmetric method of order 2s is raised to order 2s+2 by Yoshida composition.

```lean
-- MolecularDynamics.Chapter03Review.yoshidaRaiseOrder_statement
def yoshidaRaiseOrder_statement : Prop :=
  ∀ (n s : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    1 ≤ s → ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η →
    (∀ h z, G (-h) (G h z)=z) → localOrder G Φ B (2*s) →
    localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ B (2*s+2)
```

差异及额外假设：需实际局部误差展开、负步长流存在；不搭大型BCH理论。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:196`。

### CH03-058 · §3.3.3 · 定义 · 印刷p.110 / PDF132

原文（忠实转述）：Fourth-order Yoshida is three velocity Verlet steps with the cube-root coefficients, (3.8).

```lean
-- MolecularDynamics.Chapter03Review.yoshida4
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```

差异及额外假设：算法数学映射；纯实现步骤和成本排除。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:79`。

### CH03-059 · §3.3.3 · 未编号结论 · 印刷p.110 / PDF132

原文（忠实转述）：Yoshida4 is symplectic and symmetric.

```lean
-- MolecularDynamics.Chapter03Review.yoshida4Structure_proved
theorem yoshida4Structure_proved : yoshida4Structure_statement

-- MolecularDynamics.Chapter03Review.yoshida4Structure_statement
def yoshida4Structure_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (yoshida4 m U h)) ∧ (∀ h z, yoshida4 m U (-h) (yoshida4 m U h z)=z)
```

差异及额外假设：可直接组合既有引理；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:81;MolecularDynamics/Chapter03/Statements.lean:202`。

### CH03-060 · §3.3.3 · 定义 · 印刷p.111 / PDF133

原文（忠实转述）：General composition alternates drift and kick maps with coefficients alpha_i,beta_i.

```lean
-- MolecularDynamics.Chapter03Review.generalSplitting
def generalSplitting {E : Type*} (T U : ℝ → E → E) (coeff : List (ℝ × ℝ)) (h : ℝ) : E → E :=
  coeff.foldr (fun ab acc => T (ab.1*h) ∘ U (ab.2*h) ∘ acc) id
```

差异及额外假设：有限列表、顺序显式。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:81`。

### CH03-061 · §3.3.4 · 定义 · 印刷p.112 / PDF134

原文（忠实转述）：Takahashi-Imada uses Verlet with U-h^2 grad U^T M^-1 grad U/24.

```lean
-- MolecularDynamics.Chapter02Review.takahashiPotential
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i
```

差异及额外假设：复用第2章；符号待导师审阅。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:134`。

### CH03-062 · §3.3.4 · 未编号结论 · 印刷p.112 / PDF134

原文（忠实转述）：grad U^T M^-1 grad U={U,{U,T}}.

```lean
-- MolecularDynamics.Chapter03Review.potentialDoubleBracket_statement
def potentialDoubleBracket_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ 2 U → ∀ z : Z n,
    (∑ i, grad U z.1 i*invMass m (grad U z.1) i)=
      textbookPoissonBracket (fun x => U (unpack x).1)
        (textbookPoissonBracket (fun x => U (unpack x).1) (fun x => quadraticKinetic m (unpack x).2)) (pack z)
```

差异及额外假设：实际Poisson偏导和固定正质量。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:205`。

### CH03-063 · §3.3.4 · 定义 · 印刷p.112 / PDF134

原文（忠实转述）：The printed leading TI shadow correction is (p^T M^-1 U'' M^-1 p-grad U^T M^-1 grad U)/12.

```lean
-- MolecularDynamics.Chapter03Review.takahashiShadow2
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)
```

差异及额外假设：有限函数定义。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:83`。

### CH03-064 · §3.3.4 · 定义 · 印刷p.113 / PDF135

原文（忠实转述）：The processor is qtilde=q-h^2 M^-1 grad U/12, ptilde=p+h^2 U'' M^-1 p/12, (3.9).

```lean
-- MolecularDynamics.Chapter03Review.takahashiProcessor
def takahashiProcessor {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n :=
  (z.1-(h^2/12) • invMass m (grad U z.1), z.2+(h^2/12) • hessianAction U z.1 (invMass m z.2))
```

差异及额外假设：数学坐标变换；不假设全球可逆。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:85`。

### CH03-065 · §3.3.4 · 未编号结论 · 印刷p.113 / PDF135

原文（忠实转述）：H after the processor equals the printed TI shadow through O(h^4).

```lean
-- MolecularDynamics.Chapter03Review.processorEnergy_statement
def processorEnergy_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (Z n)),
    positiveMass m → ContDiff ℝ 4 U → IsCompact B → ∃ C > 0, ∃ δ > 0,
      ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
        |mechanicalEnergy m U (takahashiProcessor m U h z)-takahashiShadow2 m U h z| ≤ C*h^4
```

差异及额外假设：补前式遗漏U；实际Taylor余项待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:210`。

### CH03-066 · §3.3.4 · 未编号结论 · 印刷p.113 / PDF135

原文（忠实转述）：Takahashi-Imada has effective fourth order for general observables.

```lean
-- MolecularDynamics.Chapter02Review.takahashiOrder_statement
def takahashiOrder_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
    ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
      solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
      ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        oneStepMaxError (fun h => textbookProcessedMethod χ
          (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
          (τ/ν) γ ν ≤ C*(τ/ν)^4
```

差异及额外假设：复用第2章忠实处理陈述，未证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:349`。

### CH03-067 · §3.4 · 定义 · 印刷p.113 / PDF135

原文（忠实转述）：A modified vector field is the formal series f+h^r f_r+... .

```lean
-- MolecularDynamics.Chapter03Review.formalField
def formalField {n : ℕ} (f : Q n → Q n) (fj : ℕ → Q n → Q n) (r : ℕ)
    (z : Q n) (i : Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then f z i else if r ≤ j then fj j z i else 0)
```

差异及额外假设：逐系数形式对象。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:23`。

### CH03-068 · §3.4 · 未编号结论 · 印刷p.113 / PDF135

原文（忠实转述）：The leading modified vector-field coefficient equals the leading local error coefficient.

```lean
-- MolecularDynamics.Chapter03Review.leadingModifiedField_statement
def leadingModifiedField_statement : Prop :=
  ∀ (n r : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    0 < r → ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η → localOrder G Φ B r →
    ∃ fr : Q n → Q n, ContDiffOn ℝ ⊤ fr D ∧
      (∀ z ∈ B, Tendsto (fun h => (h^(r+1))⁻¹ • (G h z-Φ h z)) (𝓝[≠] 0) (𝓝 (fr z))) ∧
      ∃ Γ : ℝ → Q n → ℝ → Q n, ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z ∈ B,
        Γ h z 0=z ∧ solution (fun x => f x+h^r • fr x) (Γ h z) 0 h ∧
          ‖G h z-Γ h z h‖ ≤ C*h^(r+2)
```

差异及额外假设：完整匹配关系；需步长光滑展开。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:215`。

### CH03-069 · §3.4 · 定义 · 印刷p.114 / PDF136

原文（忠实转述）：A finite Hamiltonian truncation is H+sum_(j=r)^k h^j H_j, (3.11).

```lean
-- MolecularDynamics.textbookTruncatedHamiltonian
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

差异及额外假设：已有有限函数定义，非收敛级数。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean:21`。

### CH03-070 · §3.4 · 未编号结论 · 印刷p.114 / PDF136

原文（忠实转述）：The actual finite truncation is C1 if its finitely many coefficients are C1.

```lean
-- MolecularDynamics.contDiffOn_textbookTruncatedHamiltonian
theorem contDiffOn_textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ContDiffOn ℝ 1 (textbookTruncatedHamiltonian H Hj r k h) D
```

差异及额外假设：固定r,k,h；原文proof依赖。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean:25`。

### CH03-071 · §3.4 · 定理 · 印刷p.114 / PDF136

原文（忠实转述）：Theorem 3.1 with the omitted construction made explicit: high-order modified Hamiltonians and matching yield physical energy O(h^r) for n h=O(h^(-k+r)).

```lean
-- MolecularDynamics.Chapter03Review.theorem31_statement
def theorem31_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
    ∀ k ≥ r, finiteMatching H Hj r k D B G ∧
      ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
        (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
        (∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
          ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
            (∀ t ∈ Icc 0 h, Γ h z t ∈ B)) →
        (ν:ℝ)*h*h^(k-r) ≤ T → ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r

-- MolecularDynamics.Chapter03Review.analyticBEA_statement
def analyticBEA_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r → AnalyticOnNhd ℝ H D →
    AnalyticOnNhd ℝ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-1:ℝ) 1 ×ˢ D) →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, AnalyticOnNhd ℝ (Hj j) D) ∧
    ∃ C > 0, ∃ A > 0, ∃ δ > 0,
      (∀ k ≥ r, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, A*((k+1:ℕ):ℝ)*h ≤ 1 → ∀ z ∈ B,
          truncatedFlow H Hj r k h z (Γ h z) ∧ (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧
          ‖G h z-Γ h z h‖ ≤ C*h*(A*((k+1:ℕ):ℝ)*h)^(k+1)) ∧
      ∃ γ > 0, ∃ κ : ℝ → ℕ, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, r ≤ κ h ∧
          ∀ z ∈ B, truncatedFlow H Hj r (κ h) h z (Γ h z) ∧
            ‖G h z-Γ h z h‖ ≤ C*h*Real.exp (-γ/h)

-- MolecularDynamics.Chapter03Review.smoothSymplecticData
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r

-- MolecularDynamics.Chapter03Review.actualFlowNearCompact
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

-- MolecularDynamics.Chapter03Review.localOrder
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)

-- MolecularDynamics.Chapter03Review.finiteMatching
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)

-- MolecularDynamics.Chapter03Review.truncatedFlow
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

差异及额外假设：完整构造/匹配/多项式长时间能量Prop，另附解析指数Prop；正阶数、凸开D、紧凸B⊂D、局部joint C∞近恒等辛映射、实际原始流与一致阶；数值及截断轨道留在B；常数依赖固定k与T，非全部k统一；缺逐阶Hamiltonian构造与ODE余项理论，未搭建大型一般理论；缺形式jet的Hamiltonian构造、逐阶匹配及局部ODE统一余项；finiteMatching是所需结论，未被用作完整构造的假设。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:56;MolecularDynamics/Chapter03/Statements.lean:69;MolecularDynamics/Chapter03/Statements.lean:31;MolecularDynamics/Chapter03/Statements.lean:25;MolecularDynamics/Chapter03/Statements.lean:20;MolecularDynamics/Chapter03/Statements.lean:42;MolecularDynamics/Chapter03/ReviewDefinitions.lean:87`。

### CH03-072 · §3.4 · 未编号结论 · 印刷p.114 / PDF136

原文（忠实转述）：Smooth H is Lipschitz on a compact convex B inside its open domain.

```lean
-- MolecularDynamics.exists_compact_C1_lipschitz_constant
theorem exists_compact_C1_lipschitz_constant (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (H : E → ℝ) (hH : ContDiffOn ℝ 1 H D) :
    ∃ L : ℝ, 0 < L ∧ ∀ u ∈ B, ∀ v ∈ B, ‖H v - H u‖ ≤ L * ‖v - u‖
```

差异及额外假设：真实fderiv界和紧性推导。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean:54`。

### CH03-073 · §3.4 · notation · 印刷p.115 / PDF137

原文（忠实转述）：F_h^(k) is the actual time-h flow of the finite modified Hamiltonian.

```lean
-- MolecularDynamics.Chapter03Review.truncatedFlow
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

差异及额外假设：定义满足真实ODE的曲线关系，不把exp算子当解存在证明。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:87`。

### CH03-074 · §3.4 · 未编号结论 · 印刷p.115 / PDF137

原文（忠实转述）：The numerical step can be written as a truncated-flow step plus a defect of order h^(k+1).

```lean
-- MolecularDynamics.Chapter03Review.modifiedConstruction_statement
def modifiedConstruction_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G

-- MolecularDynamics.Chapter03Review.smoothSymplecticData
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r

-- MolecularDynamics.Chapter03Review.actualFlowNearCompact
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

-- MolecularDynamics.Chapter03Review.localOrder
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)

-- MolecularDynamics.Chapter03Review.finiteMatching
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)

-- MolecularDynamics.Chapter03Review.truncatedFlow
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

差异及额外假设：完整构造与匹配不可当已证假设；全阶陈述待证；缺形式jet的Hamiltonian构造、逐阶匹配及局部ODE统一余项；finiteMatching是所需结论，未被用作完整构造的假设。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:49;MolecularDynamics/Chapter03/Statements.lean:31;MolecularDynamics/Chapter03/Statements.lean:25;MolecularDynamics/Chapter03/Statements.lean:20;MolecularDynamics/Chapter03/Statements.lean:42;MolecularDynamics/Chapter03/ReviewDefinitions.lean:87`。

### CH03-075 · §3.4 · 未编号结论 · 印刷p.115 / PDF137

原文（忠实转述）：The finite modified Hamiltonian is conserved by its own actual flow.

```lean
-- MolecularDynamics.textbookHamiltonian_energy_const_on_Icc
theorem textbookHamiltonian_energy_const_on_Icc (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0)
```

差异及额外假设：实际Hamilton曲线；不声称由数值方法构造完成。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:226`。

### CH03-076 · §3.4 · 未编号结论 · 印刷p.115 / PDF137

原文（忠实转述）：The modified energy change is the sum of successive changes along the numerical iterates.

```lean
-- MolecularDynamics.oneStep_energy_telescoping
theorem oneStep_energy_telescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀
```

差异及额外假设：任意函数和真实迭代，n=0包含。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean:21`。

### CH03-077 · §3.4 · 未编号结论 · 印刷p.115 / PDF137

原文（忠实转述）：The finite truncated Hamiltonian has a step-uniform Lipschitz constant.

```lean
-- MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz
theorem exists_uniform_textbookTruncatedHamiltonian_lipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖
```

差异及额外假设：常数来自有限系数的C1与紧凸域。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean:119`。

### CH03-078 · §3.4 · 未编号结论 · 印刷p.115 / PDF137

原文（忠实转述）：The difference between the finite truncation and H is uniformly O(h^r).

```lean
-- MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder
theorem exists_uniform_textbookTruncatedHamiltonian_remainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r

-- MolecularDynamics.textbookTruncatedHamiltonian_difference_isBigO
theorem textbookTruncatedHamiltonian_difference_isBigO
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B)
    (z : ℝ → E) (hz : ∀ h ∈ Icc (0 : ℝ) 1, z h ∈ B) :
    Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
      (fun h => textbookTruncatedHamiltonian H Hj r k h (z h) - H (z h))
      (fun h : ℝ => h ^ r)
```

差异及额外假设：所有h∈[0,1]与B内点，真实界。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean:70;MolecularDynamics/Chapter03/ModifiedHamiltonianBounds.lean:104`。

### CH03-079 · §3.4 · 未编号结论 · 印刷p.115 / PDF137

原文（忠实转述）：Physical energy drift is bounded by two truncation remainders plus a Lipschitz constant times actual endpoint defects.

```lean
-- MolecularDynamics.textbook_energy_drift_le_actual_defects
theorem textbook_energy_drift_le_actual_defects
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
            γ h (oneStepIterate G h z₀ i) h‖
```

差异及额外假设：不先假设所需能量结论，匹配另列。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean:68`。

### CH03-080 · §3.4 · 未编号结论 · 印刷p.116 / PDF138

原文（忠实转述）：A uniform O(h^(k+1)) matching defect implies O(h^r) energy error for polynomially long time.

```lean
-- MolecularDynamics.textbook_energy_drift_rate_of_flow_defect
theorem textbook_energy_drift_rate_of_flow_defect
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (hrk : r ≤ k) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t)
    (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T)
    (hdefect : ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z - γ h z h‖ ≤ A * h ^ (k + 1)) :
    ∃ M : ℝ, 0 < M ∧ ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
      (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
      (n : ℝ) * h * h ^ (k - r) ≤ T →
      ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ M * h ^ r
```

差异及额外假设：有条件部分已证；不声称产生该matching defect。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean:132`。

### CH03-081 · §3.4 · 未编号结论 · 印刷p.116 / PDF138

原文（忠实转述）：The step count identity n h^(k+1)=(n h h^(k-r)) h^r converts the drift bound.

```lean
-- MolecularDynamics.energy_step_count_power_factor
theorem energy_step_count_power_factor (r k n : ℕ) (hrk : r ≤ k) (h : ℝ) :
    (n : ℝ) * h ^ (k + 1) = ((n : ℝ) * h * h ^ (k - r)) * h ^ r
```

差异及额外假设：r≤k；纯代数。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ModifiedEnergyDrift.lean:124`。

### CH03-082 · §3.4 · 未编号结论 · 印刷p.116 / PDF138

原文（忠实转述）：C-infinity data permits each fixed truncation index, with constants depending on the index.

```lean
-- MolecularDynamics.Chapter03Review.modifiedConstruction_statement
def modifiedConstruction_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G

-- MolecularDynamics.Chapter03Review.smoothSymplecticData
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r

-- MolecularDynamics.Chapter03Review.actualFlowNearCompact
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

-- MolecularDynamics.Chapter03Review.localOrder
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)

-- MolecularDynamics.Chapter03Review.finiteMatching
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)

-- MolecularDynamics.Chapter03Review.truncatedFlow
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

差异及额外假设：全阶构造未证；不把C-infinity当指数估计充分条件；缺形式jet的Hamiltonian构造、逐阶匹配及局部ODE统一余项；finiteMatching是所需结论，未被用作完整构造的假设。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:49;MolecularDynamics/Chapter03/Statements.lean:31;MolecularDynamics/Chapter03/Statements.lean:25;MolecularDynamics/Chapter03/Statements.lean:20;MolecularDynamics/Chapter03/Statements.lean:42;MolecularDynamics/Chapter03/ReviewDefinitions.lean:87`。

### CH03-083 · §3.4 · 未编号结论 · 印刷p.116 / PDF138

原文（忠实转述）：Under analytic bounds, a finite modified flow defect is bounded by C h [D(k+1)h]^(k+1).

```lean
-- MolecularDynamics.Chapter03Review.analyticBEA_statement
def analyticBEA_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r → AnalyticOnNhd ℝ H D →
    AnalyticOnNhd ℝ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-1:ℝ) 1 ×ˢ D) →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, AnalyticOnNhd ℝ (Hj j) D) ∧
    ∃ C > 0, ∃ A > 0, ∃ δ > 0,
      (∀ k ≥ r, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, A*((k+1:ℕ):ℝ)*h ≤ 1 → ∀ z ∈ B,
          truncatedFlow H Hj r k h z (Γ h z) ∧ (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧
          ‖G h z-Γ h z h‖ ≤ C*h*(A*((k+1:ℕ):ℝ)*h)^(k+1)) ∧
      ∃ γ > 0, ∃ κ : ℝ → ℕ, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, r ≤ κ h ∧
          ∀ z ∈ B, truncatedFlow H Hj r (κ h) h z (Γ h z) ∧
            ‖G h z-Γ h z h‖ ≤ C*h*Real.exp (-γ/h)

-- MolecularDynamics.Chapter03Review.smoothSymplecticData
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r

-- MolecularDynamics.Chapter03Review.actualFlowNearCompact
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

-- MolecularDynamics.Chapter03Review.localOrder
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)

-- MolecularDynamics.Chapter03Review.finiteMatching
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)

-- MolecularDynamics.Chapter03Review.truncatedFlow
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

差异及额外假设：原文many standard classes缺明示正则性；补解析/Gevrey量化，未证；缺解析邻域/Cauchy阶乘界、整数最优截断及统一常数；指数误差没有从仅C∞推出。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:69;MolecularDynamics/Chapter03/Statements.lean:31;MolecularDynamics/Chapter03/Statements.lean:25;MolecularDynamics/Chapter03/Statements.lean:20;MolecularDynamics/Chapter03/Statements.lean:42;MolecularDynamics/Chapter03/ReviewDefinitions.lean:87`。

### CH03-084 · §3.4 · 未编号结论 · 印刷p.116 / PDF138

原文（忠实转述）：Optimal truncation near k+1=1/(D e h) gives an exponentially small defect C h exp(-gamma/h).

```lean
-- MolecularDynamics.Chapter03Review.optimalTruncation_statement
def optimalTruncation_statement : Prop :=
  ∀ A > 0, ∃ δ > 0, ∃ C > 0, ∀ h ∈ Ioo 0 δ,
    let k := Nat.floor (1/(A*Real.exp 1*h))
    0 < k ∧ (A*(k:ℝ)*h)^k ≤ C*Real.exp (-(1/(A*Real.exp 1))/h)
```

差异及额外假设：整数取整与小h域需补；未证；缺解析邻域/Cauchy阶乘界、整数最优截断及统一常数；指数误差没有从仅C∞推出。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:86`。

### CH03-085 · §3.4 · 未编号结论 · 印刷p.116 / PDF138

原文（忠实转述）：Exponential smallness decays faster than any fixed power as h tends to zero.

```lean
-- MolecularDynamics.Chapter03Review.exponentialFlat_statement
def exponentialFlat_statement : Prop :=
  ∀ γ > 0, ∀ k : ℕ, Tendsto (fun h : ℝ => Real.exp (-γ/h)/h^k) (𝓝[>] 0) (𝓝 0)
```

差异及额外假设：正gamma；可复用Mathlib极限。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:90`。

### CH03-086 · §3.4 · 定义 · 印刷p.117 / PDF139

原文（忠实转述）：For unit scalar mass, the printed Verlet shadow through h^4 uses derivatives U' through U''''.

```lean
-- MolecularDynamics.Chapter03Review.scalarVerletShadow4
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)
```

差异及额外假设：有限式；排除double-well数值图。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:90`。

### CH03-087 · §3.4 · 未编号结论 · 印刷p.117 / PDF139

原文（忠实转述）：If H is conserved by the modified Hamiltonian flow then {H,Htilde}=0.

```lean
-- MolecularDynamics.Chapter03Review.commutingEnergy_statement
def commutingEnergy_statement : Prop :=
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 H D → IsOpen D → actualFlow (textbookHamiltonianVectorField K) D Φ η →
    (∀ z ∈ D, ∀ t ∈ Ioo (-η) η, H (Φ t z)=H z) → ∀ z ∈ D, textbookPoissonBracket H K z=0
```

差异及额外假设：从所有初值的实际流守恒导出，非单条轨道。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:225`。

### CH03-088 · §3.4 · 未编号结论 · 印刷p.118 / PDF140

原文（忠实转述）：By bracket antisymmetry, {Htilde,H}=0 and Htilde is a first integral of the original system.

```lean
-- MolecularDynamics.Chapter03Review.commutingEnergySymmetry_statement
def commutingEnergySymmetry_statement : Prop :=
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 K D → IsOpen D → actualFlow (textbookHamiltonianVectorField H) D Φ η →
    (∀ z ∈ D, textbookPoissonBracket H K z=0) →
      (∀ z ∈ D, textbookPoissonBracket K H z=0) ∧ ∀ z ∈ D, ∀ t ∈ Ioo (-η) η, K (Φ t z)=K z
```

差异及额外假设：实际全域陈述与原始流存在。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:230`。

### CH03-089 · §3.4 · 未编号结论 · 印刷p.118 / PDF140

原文（忠实转述）：Energy preservation and symplecticity are described as practically incompatible except exact flow up to time rescaling.

```lean
-- MolecularDynamics.Chapter03Review.energySymplecticNoGo_statement
def energySymplecticNoGo_statement : Prop :=
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ H D → noExtraIntegrals H D →
    actualFlow (textbookHamiltonianVectorField H) D Φ η →
    ContDiff ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2) →
    (∀ z ∈ D, G 0 z=z) → (∀ h ∈ Ioo (-η) η, IsTextbookSymplecticMap (G h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, H (G h z)=H z) →
    ∃ δ > 0, ∃ τ : ℝ → ℝ → ℝ, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ D, G h z=Φ (τ h (H z)) z
```

差异及额外假设：缺非可积性/无额外第一积分等Ge-Marsden精确假设；保留条件化忠实Prop，不断言无条件不可能。

状态：**not_formalizable_now**。位置：`MolecularDynamics/Chapter03/Statements.lean:239`。

### CH03-090 · §3.5 · 定义 · 印刷p.122 / PDF144

原文（忠实转述）：The example system has u'=f(u,v),v'=f(u,v), and I=u-v.

```lean
-- MolecularDynamics.Chapter03Review.equalComponentIntegral
def equalComponentIntegral (z : ℝ × ℝ) : ℝ := z.1-z.2
```

差异及额外假设：数学示例，排除数值实验。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:95`。

### CH03-091 · §3.5 · 未编号结论 · 印刷p.123 / PDF145

原文（忠实转述）：Euler exactly preserves I=u-v for equal component fields.

```lean
-- MolecularDynamics.Chapter03Review.equalEulerIntegral_proved
theorem equalEulerIntegral_proved : equalEulerIntegral_statement

-- MolecularDynamics.Chapter03Review.equalEulerIntegral_statement
def equalEulerIntegral_statement : Prop :=
  ∀ (f : ℝ × ℝ → ℝ) h z, equalComponentIntegral (z.1+h*f z,z.2+h*f z)=equalComponentIntegral z
```

差异及额外假设：可有限代数证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:19;MolecularDynamics/Chapter03/Statements.lean:249`。

### CH03-092 · §3.5 · 未编号结论 · 印刷p.123 / PDF145

原文（忠实转述）：Euler exactly preserves a linear functional b dot z if b dot f(z)=0.

```lean
-- MolecularDynamics.Chapter03Review.linearEulerIntegral_proved
theorem linearEulerIntegral_proved : linearEulerIntegral_statement

-- MolecularDynamics.Chapter03Review.linearEulerIntegral_statement
def linearEulerIntegral_statement : Prop :=
  ∀ (n : ℕ) (b : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, b (f z)=0) →
    ∀ (h : ℝ) z, b (z+h • f z)=b z
```

差异及额外假设：任意有限维、精确实数；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:24;MolecularDynamics/Chapter03/Statements.lean:251`。

### CH03-093 · §3.5 · 未编号结论 · 印刷p.123 / PDF145

原文（忠实转述）：Runge-Kutta methods preserve such linear first integrals.

```lean
-- MolecularDynamics.Chapter03Review.linearRKIntegral_proved
theorem linearRKIntegral_proved : linearRKIntegral_statement

-- MolecularDynamics.Chapter03Review.linearRKIntegral_statement
def linearRKIntegral_statement : Prop :=
  ∀ (n s : ℕ) (ℓ : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, ℓ (f z)=0) →
    ∀ (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
      rungeKuttaRelation f A b h z w F → ℓ w=ℓ z
```

差异及额外假设：直接有限和证明，无需一般RK阶理论；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:28;MolecularDynamics/Chapter03/Statements.lean:254`。

### CH03-094 · §3.5 · 未编号结论 · 印刷p.123 / PDF145

原文（忠实转述）：Verlet oscillator energy remains bounded and fluctuates by O(h^2) for stable steps.

```lean
-- MolecularDynamics.Chapter03Review.verletOscillatorEnergy_statement
def verletOscillatorEnergy_statement : Prop :=
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2
```

差异及额外假设：需abs(h Omega)<2，排除不稳定步长；非一般非线性全时间定理。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:258`。

### CH03-095 · §3.5 · 定义 · 印刷p.123 / PDF145

原文（忠实转述）：Momentum projection leaves q unchanged and scales p by gamma.

```lean
-- MolecularDynamics.Chapter03Review.momentumProjection
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)
```

差异及额外假设：实际映射。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:96`。

### CH03-096 · §3.5 · 定义 · 印刷p.123 / PDF145

原文（忠实转述）：The energy correction solves gamma^2 Kbar+Ubar=E, (3.12).

```lean
-- MolecularDynamics.Chapter03Review.projectionConstraint
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E
```

差异及额外假设：数学约束。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:97`。

### CH03-097 · §3.5 · 定义 · 印刷p.124 / PDF146

原文（忠实转述）：The positive correction factor is sqrt((E-Ubar)/Kbar), (3.13).

```lean
-- MolecularDynamics.Chapter03Review.projectionFactor
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)
```

差异及额外假设：Kbar>0,E≥Ubar域。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:98`。

### CH03-098 · §3.5 · 未编号结论 · 印刷p.124 / PDF146

原文（忠实转述）：The momentum projection preserves the specified energy under its domain conditions.

```lean
-- MolecularDynamics.Chapter03Review.projectionEnergy_proved
theorem projectionEnergy_proved : projectionEnergy_statement

-- MolecularDynamics.Chapter03Review.projectionEnergy_statement
def projectionEnergy_statement : Prop :=
  ∀ E K U : ℝ, 0 < K → U ≤ E → projectionConstraint E K U (projectionFactor E K U)
```

差异及额外假设：明确非零动能和非负根号；可有限证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:34;MolecularDynamics/Chapter03/Statements.lean:263`。

### CH03-099 · §3.5 · 未编号结论 · 印刷p.124 / PDF146

原文（忠实转述）：When all momenta vanish, Kbar=0 and the correction quotient is undefined physically.

```lean
-- MolecularDynamics.Chapter03Review.kineticZero_proved
theorem kineticZero_proved : kineticZero_statement

-- MolecularDynamics.Chapter03Review.kineticZero_statement
def kineticZero_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (p : Position n), positiveMass m → (kinetic m p=0 ↔ p=0)
```

差异及额外假设：正质量下K=0 iff p=0；Lean全除法不等于物理解存在；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:118;MolecularDynamics/Chapter03/Statements.lean:265`。

### CH03-100 · §3.5 · 定义 · 印刷p.124 / PDF146

原文（忠实转述）：General energy projection solves H(Q,P)=E.

```lean
-- MolecularDynamics.Chapter03Review.energyProjectionRelation
def energyProjectionRelation {n : ℕ} (H : Z n → ℝ) (E : ℝ) (z : Z n) : Prop := H z=E
```

差异及额外假设：不声称求解存在和保几何结构。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:99`。

### CH03-101 · §3.5 · 未编号结论 · 印刷p.126 / PDF148

原文（忠实转述）：A Hamiltonian flow cannot have an attracting periodic orbit with an open basin.

```lean
-- MolecularDynamics.Chapter03Review.noHamiltonianAttractor_statement
def noHamiltonianAttractor_statement : Prop :=
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (orbit B : Set (SymplecticCoordinates n)), ContDiff ℝ 2 H →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (textbookHamiltonianVectorField H (Φ t z)) t) →
    IsCompact orbit → orbit.Nonempty → volume orbit=0 → IsOpen B → 0 < volume B → volume B < ⊤ →
    ¬ (∀ z ∈ B, Tendsto (fun t => Metric.infDist (Φ t z) orbit) atTop (𝓝 0))
```

差异及额外假设：补有限体积局部吸引和真实体积保持；缺一般动力系统基础。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:268`。

### CH03-102 · §3.6 · 未编号结论 · 印刷p.128 / PDF150

原文（忠实转述）：Hamiltonian mechanical flow preserves the symplectic form, energy and phase volume.

```lean
-- MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2
theorem textbookHamiltonianFlow_isSymplectic_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z))

-- MolecularDynamics.textbookHamiltonian_energy_const_on_Icc
theorem textbookHamiltonian_energy_const_on_Icc (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0)

-- MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2
theorem textbookHamiltonianFlow_volume_image_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s

-- MolecularDynamics.Chapter02Review.localHamiltonianStructures_statement
def localHamiltonianStructures_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S)
```

差异及额外假设：前三性质复用；jointC2较强假设，忠实C1域陈述复用第2章。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/ActualFlowVariations.lean:143;MolecularDynamics/Chapter03/LiePoisson.lean:226;MolecularDynamics/Chapter02/HamiltonianVolume.lean:122;MolecularDynamics/Chapter02/Statements.lean:379`。

### CH03-103 · §3.6 · 未编号结论 · 印刷p.128 / PDF150

原文（忠实转述）：Volume preservation is weaker than symplecticity.

```lean
-- MolecularDynamics.Chapter03Review.volumeNotSymplectic_statement
def volumeNotSymplectic_statement : Prop :=
  ∃ G : SymplecticCoordinates 2 → SymplecticCoordinates 2,
    ContDiff ℝ 1 G ∧ (∀ z, (textbookJacobian G z).det=1) ∧ ¬ IsTextbookSymplecticMap G
```

差异及额外假设：具体四维线性反例。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:275`。

### CH03-104 · §3.6.1 · 定义 · 印刷p.128 / PDF150

原文（忠实转述）：An involution R satisfies R^2=I.

```lean
-- MolecularDynamics.Chapter03Review.linearInvolution
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

差异及额外假设：一般线性R不自动正交。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:100`。

### CH03-105 · §3.6.1 · 定义 · 印刷p.128 / PDF150

原文（忠实转述）：The printed reversed field is -R^T f(Rz).

```lean
-- MolecularDynamics.Chapter03Review.reversedField
def reversedField {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (z : Q n) : Q n :=
  -(R.transpose.mulVec (f (R.mulVec z)))

-- MolecularDynamics.Chapter03Review.correctedReversedField
def correctedReversedField {n : ℕ} (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (z : Q n) : Q n := -R (f (R z))
```

差异及额外假设：字面定义；一般involution正确应R^-1=R，另给corrected。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:101;MolecularDynamics/Chapter03/ReviewDefinitions.lean:103`。

### CH03-106 · §3.6.1 · 定义 · 印刷p.128 / PDF150

原文（忠实转述）：Mechanical time reversal is R(q,p)=(q,-p).

```lean
-- MolecularDynamics.Chapter03Review.momentumReversal
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
```

差异及额外假设：该R确实对称正交。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:104`。

### CH03-107 · §3.6.1 · 未编号结论 · 印刷p.128 / PDF150

原文（忠实转述）：The mechanical field satisfies f(Rz)=-R f(z).

```lean
-- MolecularDynamics.Chapter03Review.mechanicalReversal_proved
theorem mechanicalReversal_proved : mechanicalReversal_statement

-- MolecularDynamics.Chapter03Review.mechanicalReversal_statement
def mechanicalReversal_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) z,
    mechanicalField m F (momentumReversal z)=-momentumReversal (mechanicalField m F z)
```

差异及额外假设：可直接有限代数证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:42;MolecularDynamics/Chapter03/Statements.lean:278`。

### CH03-108 · §3.6.1 · 未编号结论 · 印刷p.129 / PDF151

原文（忠实转述）：If f is reversible, t↦R gamma(-t) solves the same ODE.

```lean
-- MolecularDynamics.Chapter03Review.reversedTrajectory_statement
def reversedTrajectory_statement : Prop :=
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t

-- MolecularDynamics.Chapter03Review.reversedFieldPrinted_statement
def reversedFieldPrinted_statement : Prop :=
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (reversedField R f (R.mulVec (γ (-t)))) t
```

差异及额外假设：实际时间导数、线性R和反步域。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:281;MolecularDynamics/Chapter03/Statements.lean:286`。

### CH03-109 · §3.6.2 · 未编号结论 · 印刷p.129 / PDF151

原文（忠实转述）：The unique reversible flow satisfies F_(-t)(Rz)=R F_t(z).

```lean
-- MolecularDynamics.Chapter03Review.flowReversal_statement
def flowReversal_statement : Prop :=
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z)
```

差异及额外假设：真实唯一流；不把此等式藏进假设。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:291`。

### CH03-110 · §3.6.2 · 未编号结论 · 印刷p.129 / PDF151

原文（忠实转述）：The flow satisfies R composed with F_t composed with R composed with F_t=Id, (3.14).

```lean
-- MolecularDynamics.Chapter03Review.flowReversalIdentity_statement
def flowReversalIdentity_statement : Prop :=
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z
```

差异及额外假设：从反步关系与flow群性质推导。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:296`。

### CH03-111 · §3.6.2 · 定义 · 印刷p.130 / PDF152

原文（忠实转述）：A time-reversible numerical method satisfies R G_h R G_h=Id, (3.15).

```lean
-- MolecularDynamics.Chapter03Review.reversibleMethod
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z
```

差异及额外假设：固定R；与自伴随分开。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:107`。

### CH03-112 · §3.6.2 · 定义 · 印刷p.130 / PDF152

原文（忠实转述）：A symmetric numerical method satisfies G_(-h)=G_h^-1.

```lean
-- MolecularDynamics.Chapter03Review.symmetricMethod
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
```

差异及额外假设：步映射equivalence。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:108`。

### CH03-113 · §3.6.2 · 定义 · 印刷p.130 / PDF152

原文（忠实转述）：Definition 3.1: affine invariance transports a method on f to the method on A f A^-1.

```lean
-- MolecularDynamics.Chapter03Review.affineInvariant
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```

差异及额外假设：原定义只含线性A，无平移；保留区分。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:110`。

### CH03-114 · §3.6.2 · 未编号结论 · 印刷p.130 / PDF152

原文（忠实转述）：Symmetry and affine equivariance imply reversibility on an R-reversible field.

```lean
-- MolecularDynamics.Chapter03Review.symmetricAffineReversible_statement
def symmetricAffineReversible_statement : Prop :=
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ g h z, G (fun x => -g x) h z=G g (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f)
```

差异及额外假设：步长符号相容性是独立必要条件，须明示。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:301`。

### CH03-115 · §3.6.2 · 未编号结论 · 印刷p.130 / PDF152

原文（忠实转述）：Runge-Kutta methods are affine invariant.

```lean
-- MolecularDynamics.Chapter03Review.rkAffine_proved
theorem rkAffine_proved : rkAffine_statement

-- MolecularDynamics.Chapter03Review.rkAffine_statement
def rkAffine_statement : Prop :=
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i))
```

差异及额外假设：实际阶段方程运输；可有限和证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:91;MolecularDynamics/Chapter03/Statements.lean:307`。

### CH03-116 · §3.6.2 · 未编号结论 · 印刷p.130 / PDF152

原文（忠实转述）：Partitioned RK is affine invariant and symmetric methods preserve reversibility.

```lean
-- MolecularDynamics.Chapter03Review.partitionedAffine_statement
def partitionedAffine_statement : Prop :=
  ∀ (n s : ℕ) (Lq Lp : Q n ≃L[ℝ] Q n) (fq fp : Z n → Q n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) (h : ℝ) (z w : Z n) (Fq Fp : Fin s → Q n),
    (∀ i, Fq i=fq (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    (∀ i, Fp i=fp (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    w=(z.1+h • ∑ i, bq i • Fq i,z.2+h • ∑ i, bp i • Fp i) →
    (∀ i, Lq (Fq i)=Lq (fq (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (∀ i, Lp (Fp i)=Lp (fp (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (Lq w.1,Lp w.2)=(Lq z.1+h • ∑ i, bq i • Lq (Fq i),Lp z.2+h • ∑ i, bp i • Lp (Fp i))

-- MolecularDynamics.Chapter03Review.partitionedAffinePrinted_statement
def partitionedAffinePrinted_statement : Prop :=
  ∀ (n s : ℕ) (L : Z n ≃L[ℝ] Z n) (f : Z n → Z n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) h z w F,
    partitionedRKRelation f Aq Ap bq bp h z w F →
      partitionedRKRelation (fun x => L (f (L.symm x))) Aq Ap bq bp h (L z) (L w) (fun i => L (F i))
```

差异及额外假设：仅保留分块线性变换；原文任意混合q,p的全称过强，字面Prop待审。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:312;MolecularDynamics/Chapter03/Statements.lean:328`。

### CH03-117 · §3.6.3 · 未编号结论 · 印刷p.131 / PDF153

原文（忠实转述）：Symplectic Euler is symplectic but not time reversible for momentum reversal.

```lean
-- MolecularDynamics.Chapter03Review.symplecticNotReversible_statement
def symplecticNotReversible_statement : Prop :=
  ∃ (h : ℝ) (z : Z 1),
    canonicalReversal (textbookSymplecticEuler (fun _ : Fin 1 => 1) (fun q => q 0^2/2) h
      (canonicalReversal (textbookSymplecticEuler (fun _ => 1) (fun q => q 0^2/2) h (pack z)))) ≠ pack z

-- MolecularDynamics.textbookSymplecticEuler_isSymplectic
theorem textbookSymplecticEuler_isSymplectic {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h)
```

差异及额外假设：具体单位振子反例。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:333;MolecularDynamics/Chapter02/SymplecticEuler.lean:202`。

### CH03-118 · §3.6.3 · 定义 · 印刷p.131 / PDF153

原文（忠实转述）：Trapezoidal rule is Z=z+h(f(z)+f(Z))/2.

```lean
-- MolecularDynamics.Chapter03Review.trapezoidalRelation
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)
```

差异及额外假设：隐式关系。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:112`。

### CH03-119 · §3.6.3 · 未编号结论 · 印刷p.131 / PDF153

原文（忠实转述）：Trapezoidal rule is reversible but generally not symplectic.

```lean
-- MolecularDynamics.Chapter03Review.trapezoidalProperties_statement
def trapezoidalProperties_statement : Prop :=
  (∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) h z w,
    linearInvolution R → (∀ x, f (R x)=-R (f x)) → trapezoidalRelation f h z w →
    trapezoidalRelation f h (R w) (R z)) ∧
  ∃ (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ),
    ContDiff ℝ ⊤ H ∧ ContDiff ℝ 1 (G h) ∧
    (∀ z, G h z=z+(h/2) • (textbookHamiltonianVectorField H z+textbookHamiltonianVectorField H (G h z))) ∧
    ¬ IsTextbookSymplecticMap (G h)
```

差异及额外假设：给非线性实际局部解反例；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:337`。

### CH03-120 · §3.6.3 · 未编号结论 · 印刷p.131 / PDF153

原文（忠实转述）：Eigenvalues of a real Hamiltonian matrix J A with A symmetric occur in +/- and conjugate pairs.

```lean
-- MolecularDynamics.Chapter03Review.hamiltonianSpectrum_statement
def hamiltonianSpectrum_statement : Prop :=
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ), A.transpose=A → ∀ ζ,
    complexEigenvalue (textbookJ n*A) ζ → complexEigenvalue (textbookJ n*A) (-ζ) ∧
      complexEigenvalue (textbookJ n*A) (star ζ)
```

差异及额外假设：实际复特征值；不沿用原文同一u作为转置特征向量错误。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:346`。

### CH03-121 · §3.6.3 · 未编号结论 · 印刷p.131 / PDF153

原文（忠实转述）：Eigenvalues of a real symplectic matrix occur in reciprocal and conjugate pairs.

```lean
-- MolecularDynamics.Chapter03Review.symplecticSpectrum_statement
def symplecticSpectrum_statement : Prop :=
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ),
    A.transpose*textbookJ n*A=textbookJ n → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ)
```

差异及额外假设：复特征值及非零性；一般线性代数基础需复用。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:350`。

### CH03-122 · §3.6.3 · 未编号结论 · 印刷p.131 / PDF153

原文（忠实转述）：A reversible linear map with T^-1=R T R also has reciprocal/conjugate eigenvalue pairs.

```lean
-- MolecularDynamics.Chapter03Review.reversibleSpectrum_statement
def reversibleSpectrum_statement : Prop :=
  ∀ (n : ℕ) (A R : Matrix (Fin n) (Fin n) ℝ), IsUnit A.det → R*R=1 →
    A⁻¹=R*A*R → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ)
```

差异及额外假设：R可逆、T可逆，谱命题未证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:354`。

### CH03-123 · §3.6.3 · 未编号结论 · 印刷p.132 / PDF154

原文（忠实转述）：Conjugate iterates share transported asymptotic behavior.

```lean
-- MolecularDynamics.textbook_conjugate_iterates
theorem textbook_conjugate_iterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n])

-- MolecularDynamics.textbook_conjugate_iterates_tendsto_iff
theorem textbook_conjugate_iterates_tendsto_iff (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (z₀ zStar : E) :
    Tendsto (fun n : ℕ => A^[n] z₀) atTop (𝓝 zStar) ↔
      Tendsto (fun n : ℕ => B^[n] (χ z₀)) atTop (𝓝 (χ zStar))
```

差异及额外假设：原文homomorphism应homeomorphism；不保证任意处理器同有效阶。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:36;MolecularDynamics/Chapter02/ProcessedMethods.lean:45`。

### CH03-124 · §3.6.3 · 未编号结论 · 印刷p.132 / PDF154

原文（忠实转述）：A reversible map need not preserve phase volume.

```lean
-- MolecularDynamics.Chapter03Review.reversibleVolumeFailure_statement
def reversibleVolumeFailure_statement : Prop :=
  ∃ (n : ℕ) (R : Q n →L[ℝ] Q n) (G : Q n ≃ Q n), linearInvolution R ∧
    ContDiff ℝ 1 G ∧ ContDiff ℝ 1 G.symm ∧ (∀ z, R (G (R (G z)))=z) ∧
    ∃ z, |(textbookCoordinateJacobian G z).det| ≠ 1
```

差异及额外假设：非线性可逆反例，非线性det逐点可能≠1。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:358`。

### CH03-125 · §3.7 · 定义 · 印刷p.132 / PDF154

原文（忠实转述）：Hard cores impose norm(q_i-q_j)≥radius_i+radius_j.

```lean
-- MolecularDynamics.Chapter03Review.hardCoreDomain
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
```

差异及额外假设：有限粒子欧氏坐标；不混同重叠闭边界约定。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:115`。

### CH03-126 · §3.7 · 定义 · 印刷p.132 / PDF154

原文（忠实转述）：An elastic collision adds alpha times the constraint normal to momentum.

```lean
-- MolecularDynamics.Chapter03Review.elasticReflection
def elasticReflection {n : ℕ} (m : Fin n → ℝ) (u p : Position n) : Position n := p+elasticCoefficient m u p • u
```

差异及额外假设：质量度量法向反射，正质量、非零法向。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:120`。

### CH03-127 · §3.7 · 未编号结论 · 印刷p.132 / PDF154

原文（忠实转述）：The collision coefficient preserves kinetic energy and normal pair momentum exchange.

```lean
-- MolecularDynamics.Chapter03Review.elasticEnergy_statement
def elasticEnergy_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (u p : Position n), positiveMass m → u ≠ 0 →
    kinetic m (elasticReflection m u p)=kinetic m p ∧
      (∑ i, u i*elasticReflection m u p i/m i)=-(∑ i, u i*p i/m i)
```

差异及额外假设：可有限内积代数证明；二元无擦碰。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:363`。

### CH03-128 · §3.7 · 定义 · 印刷p.133 / PDF155

原文（忠实转述）：Hard-sphere trajectories concatenate smooth flow segments with collision maps.

```lean
-- MolecularDynamics.Chapter03Review.collisionComposition
def collisionComposition {E : Type*} (G : ℝ → E → E) (Rc : E → E) (times : List ℝ) : E → E :=
  match times with
  | [] => id
  | [t] => G t
  | t::u::ts => G t ∘ Rc ∘ collisionComposition G Rc (u::ts)
termination_by times.length
```

差异及额外假设：有限事件序列；不宣称无限碰撞/同时碰撞唯一解。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:121`。

### CH03-129 · §3.7 · 未编号结论 · 印刷p.133 / PDF155

原文（忠实转述）：The resulting trajectory has continuous positions and piecewise-smooth momenta with finite jumps.

```lean
-- MolecularDynamics.Chapter03Review.collisionRegularity_statement
def collisionRegularity_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) (g : Q n → ℝ)
    (times : ℕ → ℝ) (segments : ℕ → ℝ → Z n) ν,
    positiveMass m → ContDiff ℝ ⊤ F → concatenatedCollisionSegments m F g times segments ν →
    ContinuousOn (fun t => (gluedCollision times segments ν t).1) (Icc (times 0) (times (ν+1))) ∧
    (∀ j ≤ ν, ∀ t ∈ Ioo (times j) (times (j+1)),
      ContDiffAt ℝ ⊤ (fun t => (gluedCollision times segments ν t).2) t) ∧
    (∀ j < ν, Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[<] (times (j+1))) (𝓝 ((segments j (times (j+1))).2)) ∧
      Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[>] (times (j+1))) (𝓝 ((segments (j+1) (times (j+1))).2)))
```

差异及额外假设：有限二元非擦碰、事件隔离；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:385`。

### CH03-130 · §3.7.1 · 定义 · 印刷p.133 / PDF155

原文（忠实转述）：The hard-sphere potential is zero on nonoverlap and infinite on overlap.

```lean
-- MolecularDynamics.Chapter03Review.hardCorePotential
def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  @ite ENNReal (q ∈ hardCoreDomain σ) (Classical.propDecidable _) 0 ⊤
```

差异及额外假设：扩展非负实数；边界接触不当重叠。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:127`。

### CH03-131 · §3.7.1 · 定义 · 印刷p.133 / PDF155

原文（忠实转述）：Primitive splitting is half smooth kick, exact free hard-sphere evolution, half smooth kick.

```lean
-- MolecularDynamics.Chapter03Review.primitiveSplitting
def primitiveSplitting {n : ℕ} (U : Q n → ℝ)
    (Gfree : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ) :=
  textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ Gfree h ∘ textbookMomentumKick (textbookPotentialForce U) (h/2)
```

差异及额外假设：给定实际freeflow；不以伪代码实现计数学证明。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:129`。

### CH03-132 · §3.7.1 · 未编号结论 · 印刷p.133 / PDF155

原文（忠实转述）：Primitive hard-sphere splitting has first-order global error with finitely many collisions.

```lean
-- MolecularDynamics.Chapter03Review.primitiveOrder_statement
def primitiveOrder_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (Gfree : ℝ → Z n → Z n)
    (q p : ℝ → Q n) τ events,
    positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ g → 0 < τ →
    finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events → freeCollisionFlow m g Gfree →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 1
```

差异及额外假设：横截二元事件、有限间距、正规力；待证；缺隔离多约束硬球事件稳定性与非光滑误差理论；用当前隔离接触函数g表示二元碰撞；动量跳跃使同一时刻全相空间一致误差无定义保证，Prop采用误差同阶的单调时间对齐，原书误差度量需导师裁定。

状态：**not_formalizable_now**。位置：`MolecularDynamics/Chapter03/Statements.lean:409`。

### CH03-133 · §3.7.1 · 定义 · 印刷p.134 / PDF156

原文（忠实转述）：For unit mass and a fixed obstacle, alpha=-2 (u dot p)/(u dot u).

```lean
-- MolecularDynamics.Chapter03Review.obstacleReflection
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
```

差异及额外假设：非零法向。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:132`。

### CH03-134 · §3.7.1 · 未编号结论 · 印刷p.134 / PDF156

原文（忠实转述）：A primitive collisional step has leading energy defect -(h-2 t_c)(q_c dot pbar)/(q_c dot q_c)(q_c dot grad U(q_c))+O(h^2).

```lean
-- MolecularDynamics.Chapter03Review.primitiveDefect_statement
def primitiveDefect_statement : Prop :=
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ),
    ContDiff ℝ 3 U → qc ≠ 0 →
    (∀ h > 0, 0 < tc h ∧ tc h < h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))+
        (h-2*tc h)*(inner ℝ qc pbar/inner ℝ qc qc)*inner ℝ qc (gradient U qc)| ≤ C*h^2
```

差异及额外假设：实际碰撞族和小h展开；原式endcollision的解释与线性项矛盾待审。

状态：**statement_only**。位置：`MolecularDynamics/Chapter03/Statements.lean:417`。

### CH03-135 · §3.7.1 · 未编号结论 · 印刷p.134 / PDF156

原文（忠实转述）：The leading collision defect vanishes at midpoint impact or zero normal force or grazing momentum.

```lean
-- MolecularDynamics.Chapter03Review.collisionDefectZero_proved
theorem collisionDefectZero_proved : collisionDefectZero_statement

-- MolecularDynamics.Chapter03Review.collisionDefectZero_statement
def collisionDefectZero_statement : Prop :=
  ∀ h tc a b c : ℝ, (h=2*tc ∨ a=0 ∨ c=0) → (h-2*tc)*(a/b)*c=0
```

差异及额外假设：仅前式线性系数，不从endimpact推出一般三阶；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:49;MolecularDynamics/Chapter03/Statements.lean:430`。

### CH03-136 · §3.7.2 · 定义 · 印刷p.135 / PDF157

原文（忠实转述）：The collision prediction path is Q(t)=q+t M^-1 p+t^2 M^-1 F(q)/2, (3.18).

```lean
-- MolecularDynamics.Chapter03Review.collisionQuadraticPath
def collisionQuadraticPath {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) (t : ℝ) : Q n :=
  z.1+t • invMass m z.2+(t^2/2) • invMass m (F z.1)
```

差异及额外假设：数学多项式。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:133`。

### CH03-137 · §3.7.2 · 定义 · 印刷p.135 / PDF157

原文（忠实转述）：Collision times solve norm(Q_i(t)-Q_j(t))=radius_i+radius_j, (3.19).

```lean
-- MolecularDynamics.Chapter03Review.collisionTimeRelation
def collisionTimeRelation {d : ℕ} (a b : ℝ → Position d) (radius t : ℝ) : Prop := 0 < t ∧ ‖a t-b t‖=radius
```

差异及额外假设：此定义列出所有正候选根；最小根、横截与接触后状态条件在方法Prop另要求。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:135`。

### CH03-138 · §3.7.2 · 未编号结论 · 印刷p.135 / PDF157

原文（忠实转述）：Squaring the quadratic-path collision condition yields a quartic polynomial.

```lean
-- MolecularDynamics.Chapter03Review.collisionQuartic_proved
theorem collisionQuartic_proved : collisionQuartic_statement

-- MolecularDynamics.Chapter03Review.collisionQuartic_statement
def collisionQuartic_statement : Prop :=
  ∀ (d : ℕ) (a b c : Position d) (R t : ℝ), 0 ≤ R →
    (‖a+t • b+t^2 • c‖=R ↔
      inner ℝ c c*t^4+2*inner ℝ b c*t^3+(inner ℝ b b+2*inner ℝ a c)*t^2+
        2*inner ℝ a b*t+inner ℝ a a-R^2=0)
```

差异及额外假设：具体系数与正半径等价；可有限代数证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter03/ReviewProofs.lean:101;MolecularDynamics/Chapter03/Statements.lean:432`。

### CH03-139 · §3.7.2 · 定义 · 印刷p.135 / PDF157

原文（忠实转述）：Collisional Verlet takes min(next collision time,hmax), applies Verlet, and reflects if an impact occurs.

```lean
-- MolecularDynamics.Chapter03Review.collisionalVerletRelation
def collisionalVerletRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z
```

差异及额外假设：算法映射关系；不登记根搜索实现。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:136`。

### CH03-140 · §3.7.2 · 未编号结论 · 印刷p.135 / PDF157

原文（忠实转述）：Collisional Verlet has second-order accuracy.

```lean
-- MolecularDynamics.Chapter03Review.collisionalVerletOrder_statement
def collisionalVerletOrder_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (tc : Z n → ℝ) (Rc : Z n → Z n) (G : ℝ → Z n → Z n),
    positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ g → 0 < τ →
    finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events →
    (∀ z, admissibleCollisionState m g z → 0 < tc z ∧
      g (collisionQuadraticPath m (fun x => -grad U x) z (tc z))=0 ∧
      ∀ t ∈ Ioo 0 (tc z), 0 < g (collisionQuadraticPath m (fun x => -grad U x) z t)) →
    (∀ z, Rc z=(z.1,z.2+(-2*(∑ i, grad g z.1 i*z.2 i/m i)/
      (∑ i, grad g z.1 i^2/m i)) • grad g z.1)) →
    (∀ h > 0, ∀ z, collisionalVerletRelation m (fun x => -grad U x) Rc (tc z) h (min (tc z) h) z (G h z)) →
    ∃ C > 0, ∃ δ > 0, ∀ hmax ∈ Ioo 0 δ, ∀ times : ℕ → ℝ,
      times 0=0 → (∀ j, times (j+1)=times j+min (tc (oneStepIterate G hmax (q 0,p 0) j)) hmax) →
      (∀ j, times j < τ → admissibleCollisionState m g (oneStepIterate G hmax (q 0,p 0) j) ∧
        tc (oneStepIterate G hmax (q 0,p 0) j) ≠ hmax) →
      ∃ θ : ℝ ≃o ℝ, θ 0=0 ∧ θ τ=τ ∧ (∀ t ∈ Icc 0 τ, |θ t-t| ≤ C*hmax^2) ∧
        ∀ j, times j ≤ τ →
          ‖oneStepIterate G hmax (q 0,p 0) j-(q (θ (times j)),p (θ (times j)))‖ ≤ C*hmax^2
```

差异及额外假设：有限非擦碰、稳定事件定位、正外步长；大型非光滑误差理论缺口；仅碰撞隔离且所有内部接触严格早于hmax的步长序列；伪代码tc=hmax时未反射须导师判断；采用累计自适应时间，不能误作固定hmax步数；缺隔离多约束硬球事件稳定性与非光滑误差理论；用当前隔离接触函数g表示二元碰撞；动量跳跃使同一时刻全相空间一致误差无定义保证，Prop采用误差同阶的单调时间对齐，原书误差度量需导师裁定。

状态：**not_formalizable_now**。位置：`MolecularDynamics/Chapter03/Statements.lean:444`。

### CH03-141 · §3.7.3 · 定义 · 印刷p.136 / PDF158

原文（忠实转述）：Pair potentials split into alpha+beta with one radial derivative vanishing at contact.

```lean
-- MolecularDynamics.Chapter03Review.pairForceDecoupling
def pairForceDecoupling (φ α β : ℝ → ℝ) (contact : ℝ) : Prop :=
  (∀ r, φ r=α r+β r) ∧ deriv α contact=0
```

差异及额外假设：原文说second却写alpha'，两种字面约定待审。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:140`。

### CH03-142 · §3.7.3 · 未编号结论 · 印刷p.136 / PDF158

原文（忠实转述）：Zero-normal-component impulses permit a second-order hybrid collisional method.

```lean
-- MolecularDynamics.Chapter03Review.decoupledOrder_statement
def decoupledOrder_statement : Prop :=
  ∀ (n : ℕ) (m : Fin n → ℝ) (U V g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (Gfree : ℝ → Z n → Z n), positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ V →
    ContDiff ℝ ⊤ g → 0 < τ →
    (∀ x, g x=0 → ∑ i, grad g x i*invMass m (grad U x) i=0) →
    finiteCollisionTrajectory m (fun x => -grad U x-grad V x) g q p 0 τ events →
    (∀ z, 0 ≤ g z.1 → ∀ T > 0, ∃ ev, Gfree 0 z=z ∧
      finiteCollisionTrajectory m (fun x => -grad V x) g
        (fun t => (Gfree t z).1) (fun t => (Gfree t z).2) 0 T ev) →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 2
```

差异及额外假设：需要明确哪个势产生kick及事件误差；未证；缺隔离多约束硬球事件稳定性与非光滑误差理论；用当前隔离接触函数g表示二元碰撞；动量跳跃使同一时刻全相空间一致误差无定义保证，Prop采用误差同阶的单调时间对齐，原书误差度量需导师裁定。

状态：**not_formalizable_now**。位置：`MolecularDynamics/Chapter03/Statements.lean:462`。

### CH03-143 · §3.7.3 · 定义 · 印刷p.136 / PDF158

原文（忠实转述）：Modified-energy collision projection preserves a finite truncated shadow level.

```lean
-- MolecularDynamics.Chapter03Review.modifiedCollisionProjection
def modifiedCollisionProjection {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ) (h : ℝ)
    (z w : SymplecticCoordinates n) : Prop :=
  textbookTruncatedHamiltonian H Hj r k h w=textbookTruncatedHamiltonian H Hj r k h z
```

差异及额外假设：给关系、不宣称投影唯一或统计准确。

状态：**defined**。位置：`MolecularDynamics/Chapter03/ReviewDefinitions.lean:142`。
