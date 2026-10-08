# 第4章导师快速审阅（15条）

扫描用户指定PDF159–197；实际第4章标题在印刷139/PDF161，正文止于印刷174/PDF196。PDF159–160是第3章习题；印刷175/PDF197从Exercises开始，均不纳入。§4.3.7是数值实验，逐页核对后排除。介绍模型、图表、实现成本与经验性能不作为独立数学交付。

清单是进度来源；defined与proved分开统计。Prop定义编译通过只确认陈述类型正确，不表示结论成立。
原文为用户提供的教材PDF逐页忠实转述；机器验收见VALIDATION.json和check-full目录。导师语义审阅待完成。
代码块展示陈述及定义体，省略证明；节参数、类型实例及命名空间环境以链接源码为准。

| 状态 | 条数 |
| --- | ---: |
| defined | 48 |
| proved | 13 |
| statement_only | 38 |
| weakened | 0 |
| not_formalizable_now | 1 |
| 合计 | 100 |

proved为清单行数；重复映射同一证明不等于独立定理数量。

需人工判断的问题：

1. 印刷142把trapezoidal写为Implicit Midpoint；144却使用真正midpoint。是否接受字面和实际算法分列？
2. 印刷140显式辛PRK最大阈值2/Omega是否隐含阶段数或单位计算成本？分步组合可以改变阈值，书中文字面普适陈述未证明。147特征值sqrt项系数是否有误？
3. 位置投影/受约束Euler和RATTLE现有证明只接受给定光滑分支；隐式解存在、唯一选根及算法阶是否允许继续保持仅陈述？SHAKE/RATTLE乘子缩放需如何统一？
4. 公式(4.25)约束反力的M^-1、(4.40)的1/2、DLM drift的1/M和spin符号是否需勘误？字面版与质量一致版均保留；旋转惯性矩阵需非奇异。
5. C2/C3约束、正质量与梯度独立的明确假设是否忠实表达原文局部正则框架？joint C2流证明是否应标为较强实现条件？

### CH04-009 · §4 · 未编号结论 · 印刷p.140 / PDF162

原文（忠实转述）：For 0<abs(h Omega)<2 symplectic Euler powers are bounded; for abs(h Omega)>2 it has an eigenvalue outside the unit circle.

```lean
-- MolecularDynamics.Chapter04Review.symplecticEulerStability_statement
def symplecticEulerStability_statement : Prop :=
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → matrixStable (symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → eigenvalueOutside (symplecticEulerMatrix Ω h))
-- The reference supplies the missing method-class restrictions; kept for review.
```

差异、假设及缺口：边界abs(h Omega)=2通常有Jordan增长；补绝对值与非零条件。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:18`。

### CH04-012 · §4.1 · 定义 · 印刷p.142 / PDF164

原文（忠实转述）：The printed Implicit Midpoint formula averages f(z) and f(Z).

```lean
-- MolecularDynamics.Chapter04Review.printedImplicitRelation
def printedImplicitRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z znew : Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```

差异、假设及缺口：字面是trapezoidal；实际midpoint另附定义，原文误名待人工判断。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:38`。

### CH04-021 · §4.2.1 · 定义 · 印刷p.145 / PDF167

原文（忠实转述）：Reversible RESPA is slow half-kick, r fast Verlet steps of size h/r, slow half-kick, (4.2).

```lean
-- MolecularDynamics.Chapter04Review.respa
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : Q n → ℝ) (r : ℕ) (h : ℝ) (z : Z n) : Z n :=
  kick US (h/2) ((fastVerlet m UF (h/r))^[r] (kick US (h/2) z))
```

差异、假设及缺口：r>0；使用实际有限迭代，不将形式exp当实际流。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:54`。

### CH04-029 · §4.2.1 · 未编号结论 · 印刷p.147 / PDF169

原文（忠实转述）：Immediately below pi/Omega the impulse matrix has a real eigenvalue outside the unit circle.

```lean
-- MolecularDynamics.Chapter04Review.resonanceInstability_statement
def resonanceInstability_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), eigenvalueOutside (impulseMatrix Ω h)

-- MolecularDynamics.Chapter04Review.resonanceEigenPrinted_statement
def resonanceEigenPrinted_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)| ≤ C*|h-Real.pi/Ω|
```

差异、假设及缺口：原特征值sqrt(abs(epsilon)/2)系数疑误，附字面Prop；只登记局部区间。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:54;MolecularDynamics/Chapter04/Statements.lean:56`。

### CH04-042 · §4.3 · 未编号结论 · 印刷p.153 / PDF175

原文（忠实转述）：A given actual reduced ODE solution starting in the cotangent set stays there on its specified interval.

```lean
-- MolecularDynamics.textbookConstrainedODE_cotangent_invariant_of_mass_and_independence
theorem textbookConstrainedODE_cotangent_invariant_of_mass_and_independence {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (F : (Fin Nc → ℝ) → Fin Nc → ℝ) (q p : ℝ → Fin Nc → ℝ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (q t)))
    (hq : ∀ t ∈ Icc 0 τ, HasDerivWithinAt q (textbookInverseMassMatrix m *ᵥ p t) (Icc 0 τ) t)
    (hp : ∀ t ∈ Icc 0 τ, HasDerivWithinAt p
      (F (q t) - (textbookConstraintJacobian γ (q t))ᵀ *ᵥ
        textbookConstrainedReactionMultiplier m γ F (q t) (p t)) (Icc 0 τ) t)
    (hpos₀ : ∀ j, γ j (q 0) = 0)
    (hhidden₀ : ∀ j, (fderiv ℝ (γ j) (q 0)) (textbookInverseMassMatrix m *ᵥ p 0) = 0) :
    ∀ t ∈ Icc 0 τ, ∀ j, γ j (q t) = 0 ∧
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0
```

差异、假设及缺口：C2约束，给定闭区间解；非全时域解存在证明。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedGram.lean:83`。

### CH04-047 · §4.3.1 · 未编号结论 · 印刷p.156 / PDF178

原文（忠实转述）：The constrained flow preserves the pulled-back canonical two-form.

```lean
-- MolecularDynamics.textbookConstrainedFlow_pullback_constant_of_mass_and_independence
theorem textbookConstrainedFlow_pullback_constant_of_mass_and_independence {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (Φ : ℝ × E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, ∀ y,
      LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (Φ (t, y)).1))
    (hODE : ∀ t ∈ Icc 0 τ, ∀ y, HasDerivAt (fun s => Φ (s, y))
      (textbookConstrainedPhaseVectorField m γ U (Φ (t, y))) t)
    (hpos₀ : ∀ y j, γ j (Φ (0, y)).1 = 0)
    (hhidden₀ : ∀ y j, (fderiv ℝ (γ j) (Φ (0, y)).1)
      (textbookInverseMassMatrix m *ᵥ (Φ (0, y)).2) = 0) (x u v : E) :
    ∀ t ∈ Icc 0 τ,
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) v) =
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) v)
```

差异、假设及缺口：joint C2给定流、质量正/梯度独立；不声称构造流存在。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedFlowSymplectic.lean:258`。

### CH04-057 · §4.3.4 · 引理 · 印刷p.159 / PDF181

原文（忠实转述）：Lemma 4.1: for C2 gamma, constrained q,p and P=p-mu grad gamma(q), the pulled-back sum dq∧dP equals sum dq∧dp.

```lean
-- MolecularDynamics.lemma_4_1
theorem lemma_4_1 {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0 ∧
      p y ⬝ᵥ textbookConstraintGradient γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v)

-- MolecularDynamics.lemma_4_1_coordinates
theorem lemma_4_1_coordinates {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0) (u v : E) :
    ∑ i : Fin Nc, ((fderiv ℝ q x u) i *
        (fderiv ℝ (textbookConstrainedMomentum γ μ q p) x v) i -
      (fderiv ℝ (textbookConstrainedMomentum γ μ q p) x u) i * (fderiv ℝ q x v) i) =
    ∑ i : Fin Nc, ((fderiv ℝ q x u) i * (fderiv ℝ p x v) i -
      (fderiv ℝ p x u) i * (fderiv ℝ q x v) i)
```

差异、假设及缺口：已验收原标量完整证明；实际局部约束图，不重复证明；导师语义签核待定。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedProjection.lean:162;MolecularDynamics/Chapter04/ConstrainedProjection.lean:94`。

### CH04-063 · §4.3.4 · 未编号结论 · 印刷p.160 / PDF182

原文（忠实转述）：The constructed Gram projected Euler chart has both the hidden constraint and preserved pullback form.

```lean
-- MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback
theorem textbookGramProjectedEulerChart_hiddenConstraint_and_pullback {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v)
```

差异、假设及缺口：仅给定光滑位置投影分支；现有完整依赖映射。

状态：**proved**；位置：`MolecularDynamics/Chapter04/CotangentProjectionRegularity.lean:178`。

### CH04-066 · §4.3.5 · 定义 · 印刷p.161 / PDF183

原文（忠实转述）：RATTLE preserves position and hidden constraints with the two multipliers in (4.30)-(4.34).

```lean
-- MolecularDynamics.Chapter04Review.rattleRelation
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ cotangentSet m g
```

差异、假设及缺口：完整真实有限算法关系。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:125`。

### CH04-070 · §4.3.5 · 未编号结论 · 印刷p.162 / PDF184

原文（忠实转述）：After compatible initialization and cotangent projection, SHAKE and RATTLE have identical position sequences.

```lean
-- MolecularDynamics.Chapter04Review.shakeRattlePositions_statement
def shakeRattlePositions_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (F : Q n → Q n) (g : Fin l → Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q base : Q n, ∀ eta nu : Q l, q ∈ constraintSet g →
      projectionResidual m g q base eta=0 → projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → Q n) (rhoS rhoR muR : ℕ → Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1))
```

差异、假设及缺口：原mu与lambda在缩放上需审阅；给各自完整关系与相容半步动量，不把位置相等放进假设。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:140`。

### CH04-052 · §4.3.2 · 未编号结论 · 印刷p.157 / PDF179

原文（忠实转述）：Near a regular root the full Newton iteration converges quadratically.

```lean
-- MolecularDynamics.Chapter04Review.newtonQuadratic_statement
def newtonQuadratic_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (q base : Q n) (root : Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → projectionResidual m g q base root=0 →
    (projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : Q l, ‖η-root‖ < δ → ‖newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2
```

差异、假设及缺口：局部C2、Jacobian非奇异，未搭Newton一般收敛理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:85`。

### CH04-086 · §4.4 · 未编号结论 · 印刷p.169 / PDF191

原文（忠实转述）：The printed relation is R=trace(T) I-T, (4.40); the corrected coefficient is trace(T)/2.

```lean
-- MolecularDynamics.Chapter04Review.inertiaTracePrinted_statement
def inertiaTracePrinted_statement : Prop := ∀ N (m : Fin N → ℝ) (δ : Fin N → V),
  secondMoment m δ=(inertiaTensor m δ).trace • (1 : Mat3)-inertiaTensor m δ

-- MolecularDynamics.Chapter04Review.inertiaTraceCorrected_statement
def inertiaTraceCorrected_statement : Prop := ∀ N (m : Fin N → ℝ) (δ : Fin N → V),
  secondMoment m δ=((inertiaTensor m δ).trace/2) • (1 : Mat3)-inertiaTensor m δ
```

差异、假设及缺口：已图像核对；保留字面及修正版，字面一般不成立。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:209;MolecularDynamics/Chapter04/Statements.lean:211`。

### CH04-092 · §4.4.1 · 未编号结论 · 印刷p.172 / PDF194

原文（忠实转述）：Euler dynamics conserves rotational energy and angular momentum magnitude.

```lean
-- MolecularDynamics.Chapter04Review.rigidInvariants_statement
def rigidInvariants_statement : Prop := ∀ (T : Mat3) (π : ℝ → V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, dot (π t) (T⁻¹ *ᵥ π t)=dot (π a) (T⁻¹ *ᵥ π a) ∧
      dot (π t) (π t)=dot (π a) (π a)
```

差异、假设及缺口：实际ODE、对称正定T，固定时间区间。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:217`。

### CH04-097 · §4.4.2 · 定义 · 印刷p.174 / PDF196

原文（忠实转述）：The DLM step is half kick, drift, five-axis symmetric spin, half kick with refreshed force/torque.

```lean
-- MolecularDynamics.Chapter04Review.dlmPrinted
def dlmPrinted (I : V) (U : V → Mat3 → ℝ) (h : ℝ) := dlmMassConsistent 1 I U h

-- MolecularDynamics.Chapter04Review.dlmMassConsistent
def dlmMassConsistent (M : ℝ) (I : V) (U : V → Mat3 → ℝ) (h : ℝ) : RBState → RBState :=
  rigidKick U (h/2) ∘ rigidSpin I h ∘ rigidDrift M h ∘ rigidKick U (h/2)
```

差异、假设及缺口：原drift写q+h p缺1/M，保留字面与质量一致版；实际算法映射。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:202;MolecularDynamics/Chapter04/ReviewDefinitions.lean:200`。

### CH04-099 · §4.4.2 · 未编号结论 · 印刷p.174 / PDF196

原文（忠实转述）：The complete rigid-body splitting is symmetric and preserves the constrained geometric structure.

```lean
-- MolecularDynamics.Chapter04Review.dlmStructure_statement
def dlmStructure_statement : Prop := ∀ M (I : V) (U : V → Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rbSymplectic (dlmMassConsistent M I U h) ∧ ∀ z : RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      dlmMassConsistent M I U (-h) (dlmMassConsistent M I U h z)=z ∧
      (dlmMassConsistent M I U h z).2.2ᵀ*(dlmMassConsistent M I U h z).2.2=1
```

差异、假设及缺口：完整非canonical Poisson/约束辛性缺口；不搭建新理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:231`。
