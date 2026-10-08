# 第2章导师快速审阅（15条）

印刷53–93 / PDF75–115；习题从印刷94开始，数值实验及数值图表排除。
清单为唯一进度来源；定义不计为证明。Prop定义编译通过不表示命题成立。
忠实转述来自用户提供的教材PDF；问题公式以原页图像复核。代码块保留陈述和必要定义体，不贴证明；须在工程导入与对应命名空间/节参数环境中阅读。
原文语义尚待导师审阅；机器验收证据见本章VALIDATION.json及check-full目录。

| 状态 | 条数 |
| --- | ---: |
| defined | 70 |
| proved | 39 |
| statement_only | 42 |
| weakened | 8 |
| not_formalizable_now | 1 |
| 合计 | 160 |

已证明结论数：39（按清单行统计，重复映射同一证明不是独立定理）。

需要人工判断的问题：

1. 印刷63的L中+U与实际展开-U不一致，端点q_nu又被列为可变节点；是否统一采用固定两端、仅内部驻值的版本？
2. 印刷68位置局部误差符号、印刷71常数1/2、印刷93修正力符号是否是笔误？字面Prop和修正版均保留，字面版没有证明。
3. 印刷79能否将“辛映射形成群”明确限于辛微分同胚？非零Jacobian只提供局部逆；流Jacobian应在初值处取导。
4. 印刷92 Newmark位置公式缺逆质量，是否采用质量一致版本？一般隐式方法均应明确局部解和非奇异条件。
5. Liouville/流辛性现有jointC2假设是否接受为较强实现条件？一般C1流、变分原理、Gauss配点等完整Prop均未证明。

### CH02-012 · §2.1 · 定理 · 印刷p.56 / PDF78

原文（忠实转述）：Theorem 2.1: for C1 f on a bounded open D and a unique trajectory staying in D, sufficiently fine Euler meshes stay in D and have maximum error at most C(tau) h.

```lean
-- MolecularDynamics.theorem_2_1_euler
theorem theorem_2_1_euler {m : ℕ} (D : Set (Position m))
    (_hDbounded : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ))
```

差异及额外假设：原页已核对；复用完整留域和误差证明，不将留域藏入假设。

状态：**proved**。位置：`MolecularDynamics/Chapter02/EulerConvergence.lean:328`。

### CH02-027 · §2.2.1 · 未编号结论 · 印刷p.62 / PDF84

原文（忠实转述）：Stationarity for all variations implies the Euler-Lagrange equations.

```lean
-- MolecularDynamics.Chapter02Review.hamiltonPrinciple_statement
def hamiltonPrinciple_statement : Prop :=
  ∀ n (L : Q n → Q n → ℝ) (q : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q →
    (stationaryAction L a b q ↔ ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x => L x (deriv q t)) (q t)) t)
```

差异及额外假设：需基本变分引理、正则性及真实一阶变分推导。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:40`。

### CH02-033 · §2.2.2 · 定义 · 印刷p.63 / PDF85

原文（忠实转述）：Discrete stationarity means derivatives in interior points vanish with endpoints fixed.

```lean
-- MolecularDynamics.Chapter02Review.discreteStationary
def discreteStationary {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k < ν →
    fderiv ℝ (fun x => discreteAction L (replaceNode q k x) h ν) (q k) = 0
```

差异及额外假设：仅1≤n<nu；原文n=nu索引待审。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:51`。

### CH02-041 · §2.2.2 · 定义 · 印刷p.65 / PDF87

原文（忠实转述）：The staggered initial velocity is v_0-h M^-1 F(q_0)/2.

```lean
-- MolecularDynamics.Chapter02Review.leapfrogInitialize
def leapfrogInitialize {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 - (h/2) • invMass m (F z.1)
```

差异及额外假设：不忽略初始化。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:66`。

### CH02-050 · §2.2.3 · 未编号结论 · 印刷p.68 / PDF90

原文（忠实转述）：The scalar Verlet momentum expansion has cubic coefficient (F'F+p^2 F'')/4.

```lean
-- MolecularDynamics.Chapter02Review.verletExpansion_statement
def verletExpansion_statement : Prop :=
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4)
```

差异及额外假设：C3力；实际O(h4)余项，待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:74`。

### CH02-063 · §2.3.1 · 未编号结论 · 印刷p.72 / PDF94

原文（忠实转述）：Liouville: divergence-free C1 flows preserve phase volume.

```lean
-- MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2
theorem textbookDivergenceFreeFlow_volume_image_of_jointC2
    (f : (ι → ℝ) → ι → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (ι → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s

-- MolecularDynamics.Chapter02Review.liouville_statement
def liouville_statement : Prop :=
  ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ,
    0 ≤ τ → flowC1 f Φ τ → (∀ z, divergence f z = 0) →
    ∀ t ∈ Icc 0 τ, ∀ S : Set (Q n), MeasurableSet S → volume ((fun z => Φ (t,z)) '' S) = volume S

-- MolecularDynamics.Chapter02Review.localLiouville_statement
def localLiouville_statement : Prop :=
  ∀ n (f : Q n → Q n) D Ω (Φ : ℝ × Q n → Q n) τ,
    0 < τ → localFlowC1 f D Ω Φ τ → (∀ z ∈ D, divergence f z = 0) →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) z)
        (textbookCoordinateJacobian f (Φ (t,z))*textbookCoordinateJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookCoordinateJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S)
```

差异及额外假设：已有证明要求jointC2解族；补忠实C1陈述，原文未写可测集和解域。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/LiouvilleVolume.lean:131;MolecularDynamics/Chapter02/Statements.lean:147;MolecularDynamics/Chapter02/Statements.lean:370`。

### CH02-064 · §2.3.1 · 未编号结论 · 印刷p.72 / PDF94

原文（忠实转述）：Hamiltonian vector fields have zero divergence by equality of mixed partials.

```lean
-- MolecularDynamics.textbookHamiltonianVectorField_divergence_zero
theorem textbookHamiltonianVectorField_divergence_zero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0
```

差异及额外假设：H C2。

状态：**proved**。位置：`MolecularDynamics/Chapter02/HamiltonianVolume.lean:31`。

### CH02-095 · §2.3.4 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：The variational equation is W'=J S W.

```lean
-- MolecularDynamics.textbookHamiltonianFlowJacobian_hasDerivAt
theorem textbookHamiltonianFlowJacobian_hasDerivAt {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (t : ℝ) (z : SymplecticCoordinates Nc)
    (hODE : ∀ᶠ y in 𝓝 z, HasDerivAt (fun s => Φ (s, y))
      (textbookHamiltonianVectorField H (Φ (t, y))) t) :
    HasDerivAt (fun s => textbookJacobian (fun y => Φ (s, y)) z)
      (textbookJ Nc * textbookHamiltonianHessian H (Φ (t, z)) *
        textbookJacobian (fun y => Φ (t, y)) z) t

-- MolecularDynamics.Chapter02Review.hamiltonianVariational_statement
def hamiltonianVariational_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, ∀ z, HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,z)) * textbookJacobian (fun y => Φ (t,y)) z) t

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

差异及额外假设：jointC2真实流、正确初值取导位置。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/ActualFlowVariations.lean:117;MolecularDynamics/Chapter02/Statements.lean:199;MolecularDynamics/Chapter02/Statements.lean:379`。

### CH02-099 · §2.3.5 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：The derivative of a composition is the product with the outer derivative at the inner image.

```lean
-- MolecularDynamics.textbookJacobian_comp
theorem textbookJacobian_comp {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z
```

差异及额外假设：修正原文省略取值点。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticMaps.lean:44`。

### CH02-121 · §2.4.1 · 未编号结论 · 印刷p.84 / PDF106

原文（忠实转述）：Composing half symplectic Euler and half its adjoint gives Verlet.

```lean
-- MolecularDynamics.Chapter02Review.verletComposition_proved
theorem verletComposition_proved : verletComposition_statement

-- MolecularDynamics.Chapter02Review.verletComposition_statement
def verletComposition_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z)
```

差异及额外假设：实际坐标等式，可有限代数证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:103;MolecularDynamics/Chapter02/Statements.lean:219`。

### CH02-122 · §2.4.1 · 未编号结论 · 印刷p.85 / PDF107

原文（忠实转述）：Verlet is symplectic.

```lean
-- MolecularDynamics.Chapter02Review.verletSymplectic_proved
theorem verletSymplectic_proved : verletSymplectic_statement

-- MolecularDynamics.Chapter02Review.verletSymplectic_statement
def verletSymplectic_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h)
```

差异及额外假设：组合已有辛性定理即可，不需重证；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:18;MolecularDynamics/Chapter02/Statements.lean:225`。

### CH02-136 · §2.4.5 · 定义 · 印刷p.88 / PDF110

原文（忠实转述）：A processed method pre-processes, iterates the kernel, then post-processes.

```lean
-- MolecularDynamics.textbookProcessedMethod
def textbookProcessedMethod (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E) (h : ℝ) : E → E :=
  textbookConjugateMap (χ h) (B h)

-- MolecularDynamics.textbookProcessedIterate
noncomputable def textbookProcessedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)
```

差异及额外假设：步长相关homeomorphism。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:61;MolecularDynamics/Chapter02/ProcessedMethods.lean:65`。

### CH02-143 · §2.5.1 · 未编号结论 · 印刷p.90 / PDF112

原文（忠实转述）：The RK symplectic coefficient condition is b_i a_ij+b_j a_ji=b_i b_j.

```lean
-- MolecularDynamics.Chapter02Review.rkSymplectic_statement
def rkSymplectic_statement : Prop :=
  ∀ n s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ)
    (H : SymplecticCoordinates n → ℝ) (h : ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
    ContDiff ℝ 2 H → ContDiff ℝ 1 G → (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
    (∀ i j, b i*A i j+b j*A j i = b i*b j) →
    (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
      G z = z+h • ∑ i, b i • stages z i) → IsTextbookSymplecticMap G
```

差异及额外假设：条件的充分性；必要性需不可约等附加条件。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:278`。

### CH02-148 · §2.5.2 · 定义 · 印刷p.90 / PDF112

原文（忠实转述）：Generalized Verlet uses the partitioned implicit equations (2.26)-(2.28).

```lean
-- MolecularDynamics.Chapter02Review.partitionedVerletRelation
def partitionedVerletRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) (p : Q n) : Prop :=
  p = z.2 - (h/2) • partialQ H z.1 p ∧
  w.1 = z.1 + (h/2) • (partialP H z.1 p + partialP H w.1 p) ∧
  w.2 = p - (h/2) • partialQ H w.1 p
```

差异及额外假设：保留q,p偏导和中间动量。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:120`。

### CH02-158 · §2.5.4 · 未编号结论 · 印刷p.93 / PDF115

原文（忠实转述）：The displayed modified force is -(I+h^2 U''M^-1/12) grad U.

```lean
-- MolecularDynamics.Chapter02Review.takahashiForce_statement
def takahashiForce_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q - (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q))

-- MolecularDynamics.Chapter02Review.takahashiForceCorrected_statement
def takahashiForceCorrected_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q + (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q))
```

差异及额外假设：与前式-U修正求负梯度的符号不一致；字面和修正版并存。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:339;MolecularDynamics/Chapter02/Statements.lean:344`。
