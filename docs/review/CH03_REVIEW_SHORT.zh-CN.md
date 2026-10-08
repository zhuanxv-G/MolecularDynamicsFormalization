# 第3章导师快速审阅（15条）

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
