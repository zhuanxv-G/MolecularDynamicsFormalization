# 第2章人工审阅材料

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

### CH02-001 · §2 · 定义 · 印刷p.53 / PDF75

原文（忠实转述）：The Hamiltonian vector field is f=J grad H, equation (2.1).

```lean
-- MolecularDynamics.textbookHamiltonianVectorField
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```

差异及额外假设：有限维欧氏坐标；固定J符号。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SplittingError.lean:176`。

### CH02-002 · §2 · 定义 · 印刷p.53 / PDF75

原文（忠实转述）：The mechanical Hamiltonian is p^T M^-1 p/2+U(q).

```lean
-- MolecularDynamics.massHamiltonian
noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian
```

差异及额外假设：复用第1章固定正对角质量定义。

状态：**defined**。位置：`MolecularDynamics/Chapter01/Hamiltonian.lean:33`。

### CH02-003 · §2 · notation · 印刷p.53 / PDF75

原文（忠实转述）：J is the canonical block matrix with blocks 0,I,-I,0.

```lean
-- MolecularDynamics.textbookJ
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```

差异及额外假设：与Mathlib符号相反的教材约定。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticForm.lean:31`。

### CH02-004 · §2 · 定义 · 印刷p.54 / PDF76

原文（忠实转述）：Euler advances z to z+h f(z).

```lean
-- MolecularDynamics.eulerStep
noncomputable def eulerStep (f : E → E) (h : ℝ) (x : E) : E :=
  x + h • f x
```

差异及额外假设：精确实数映射。

状态：**defined**。位置：`MolecularDynamics/Chapter02/EulerConvergence.lean:34`。

### CH02-005 · §2 · 定义 · 印刷p.54 / PDF76

原文（忠实转述）：A numerical trajectory consists of repeated one-step maps from the initial point.

```lean
-- MolecularDynamics.oneStepIterate
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀
```

差异及额外假设：任意步映射的有限迭代。

状态：**defined**。位置：`MolecularDynamics/Chapter02/OneStepConvergence.lean:31`。

### CH02-006 · §2 · notation · 印刷p.54 / PDF76

原文（忠实转述）：F_t denotes the exact flow and G_h its one-step approximation.

```lean
-- MolecularDynamics.Chapter02Review.exactAndNumericalMaps
abbrev exactAndNumericalMaps (n : ℕ) := (ℝ → Q n → Q n) × (ℝ → Q n → Q n)
```

差异及额外假设：映射类型；不宣称存在全局流。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:19`。

### CH02-007 · §2.1 · 定义 · 印刷p.55 / PDF77

原文（忠实转述）：Convergence means that finite-interval maximum errors tend to zero as the step decreases.

```lean
-- MolecularDynamics.Chapter02Review.convergentMethod
def convergentMethod {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)
```

差异及额外假设：固定时间区间和h=tau/nu。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:23`。

### CH02-008 · §2.1 · 定义 · 印刷p.55 / PDF77

原文（忠实转述）：Global order r means an error bound C(tau) h^r with C independent of h.

```lean
-- MolecularDynamics.Chapter02Review.globalOrder
def globalOrder {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ C * (τ / ν) ^ r
```

差异及额外假设：足够小步长；显式量词。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:25`。

### CH02-009 · §2.1 · notation · 印刷p.56 / PDF78

原文（忠实转述）：The mesh has h nu=tau and t_n=n h.

```lean
-- MolecularDynamics.Chapter02Review.meshTime
def meshTime (h : ℝ) (n : ℕ) : ℝ := n * h
```

差异及额外假设：nu为正整数，tau正。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:20`。

### CH02-010 · §2.1 · 定义 · 印刷p.56 / PDF78

原文（忠实转述）：The error at node n is the norm of the difference between numerical and exact solutions.

```lean
-- MolecularDynamics.Chapter02Review.nodeError
def nodeError {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (h : ℝ) (k : ℕ) : ℝ :=
  ‖oneStepIterate G h (γ 0) k - γ (meshTime h k)‖
```

差异及额外假设：真实范数误差。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:21`。

### CH02-011 · §2.1 · 定义 · 印刷p.56 / PDF78

原文（忠实转述）：The maximum global error is the maximum over 0 through nu.

```lean
-- MolecularDynamics.oneStepMaxError
noncomputable def oneStepMaxError (G : ℝ → E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) : ℝ :=
  (Finset.range (ν + 1)).sup' Finset.nonempty_range_add_one
    (fun n => ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖)
```

差异及额外假设：非空有限最大值。

状态：**defined**。位置：`MolecularDynamics/Chapter02/OneStepConvergence.lean:48`。

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

### CH02-013 · §2.1 · 未编号结论 · 印刷p.56 / PDF78

原文（忠实转述）：Euler is first-order convergent on a fixed finite interval.

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

差异及额外假设：与Theorem2.1共用完整证明；不是第二个独立定理。

状态：**proved**。位置：`MolecularDynamics/Chapter02/EulerConvergence.lean:328`。

### CH02-014 · §2.1.2 · 未编号结论 · 印刷p.59 / PDF81

原文（忠实转述）：Differentiating z'=f(z) gives z''=f'(z) f(z).

```lean
-- MolecularDynamics.Chapter02Review.odeSecondDerivative_statement
def odeSecondDerivative_statement : Prop :=
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t
```

差异及额外假设：实际导数；f C1和解C2。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:10`。

### CH02-015 · §2.1.2 · 定义 · 印刷p.59 / PDF81

原文（忠实转述）：The second-order Taylor map is z+h f(z)+h^2 f'(z)f(z)/2.

```lean
-- MolecularDynamics.Chapter02Review.taylor2
def taylor2 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)
```

差异及额外假设：Fréchet导数作用。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:28`。

### CH02-016 · §2.1.2 · 未编号结论 · 印刷p.59 / PDF81

原文（忠实转述）：The second-order Taylor method has global order two.

```lean
-- MolecularDynamics.Chapter02Review.taylor2Order_statement
def taylor2Order_statement : Prop :=
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2
```

差异及额外假设：f足够光滑，轨道和数值留域、稳定性需落实；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:14`。

### CH02-017 · §2.1.2 · notation · 印刷p.59 / PDF81

原文（忠实转述）：f'(z) is the Jacobian, with ij entry partial_j f_i.

```lean
-- MolecularDynamics.textbookCoordinateJacobian
noncomputable def textbookCoordinateJacobian (f : (ι → ℝ) → ι → ℝ) (z : ι → ℝ) :
    Matrix ι ι ℝ := LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap
```

差异及额外假设：坐标Fréchet导数矩阵。

状态：**defined**。位置：`MolecularDynamics/Chapter02/LiouvilleVolume.lean:23`。

### CH02-018 · §2.2 · 未编号结论 · 印刷p.60 / PDF82

原文（忠实转述）：Verlet is a second-order method for q'=M^-1 p,p'=F(q).

```lean
-- MolecularDynamics.Chapter02Review.verletOrder_statement
def verletOrder_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError (verlet m F) (τ / ν) γ ν ≤ C * (τ / ν)^2
```

差异及额外假设：非数值示例；正质量、光滑力、留域；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:17`。

### CH02-019 · §2.2.1 · 定义 · 印刷p.60 / PDF82

原文（忠实转述）：The mechanical Lagrangian is v^T M v/2-U(q).

```lean
-- MolecularDynamics.massLagrangian
noncomputable def massLagrangian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) : ℝ :=
  nBodyKineticEnergy m v - U q
```

差异及额外假设：复用第1章。

状态：**defined**。位置：`MolecularDynamics/Chapter01/Lagrangian.lean:22`。

### CH02-020 · §2.2.1 · 定义 · 印刷p.60 / PDF82

原文（忠实转述）：Admissible curves have fixed endpoints and sufficient smoothness.

```lean
-- MolecularDynamics.Chapter02Review.admissibleCurve
def admissibleCurve {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  ContDiff ℝ 2 q ∧ q a = x ∧ q b = y
```

差异及额外假设：以C2曲线统一原文C2/C1不一致。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:30`。

### CH02-021 · §2.2.1 · 定义 · 印刷p.60 / PDF82

原文（忠实转述）：The classical action is the time integral of L(q,q').

```lean
-- MolecularDynamics.Chapter02Review.action
def action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
```

差异及额外假设：真实区间积分。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:32`。

### CH02-022 · §2.2.1 · 定义 · 印刷p.61 / PDF83

原文（忠实转述）：Variations are q_epsilon=q+epsilon eta with eta vanishing at endpoints.

```lean
-- MolecularDynamics.Chapter02Review.variation
def variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
```

差异及额外假设：实际曲线加法与数乘。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:34`。

### CH02-023 · §2.2.1 · 未编号结论 · 印刷p.61 / PDF83

原文（忠实转述）：The first variation of action is the integral of L_q eta+L_v eta'.

```lean
-- MolecularDynamics.Chapter02Review.firstVariation_statement
def firstVariation_statement : Prop :=
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    HasDerivAt (fun ε => action L a b (variation q η ε))
      (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) 0
```

差异及额外假设：C2及固定紧时间窗；积分与求导交换未证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:23`。

### CH02-024 · §2.2.1 · 未编号结论 · 印刷p.61 / PDF83

原文（忠实转述）：Taylor expansion includes derivative tensors and an order k+1 remainder.

```lean
-- MolecularDynamics.Chapter02Review.taylorRemainder_statement
def taylorRemainder_statement : Prop :=
  ∀ n (k : ℕ) (g : Q n → ℝ) z, ContDiff ℝ (k+1) g →
    ∃ C > 0, ∃ δ > 0, ∀ u : Q n, ‖u‖ < δ →
      |g (z+u) - ∑ j ∈ Finset.range (k+1),
        (iteratedFDeriv ℝ j g z (fun _ => u)) / (Nat.factorial j : ℝ)| ≤ C * ‖u‖^(k+1)
```

差异及额外假设：补原脚注遗漏的1/j!；一般向量空间Taylor界待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:29`。

### CH02-025 · §2.2.1 · 定义 · 印刷p.61 / PDF83

原文（忠实转述）：Hamilton's principle requires the first variation to vanish for every endpoint-fixed variation.

```lean
-- MolecularDynamics.Chapter02Review.stationaryAction
def stationaryAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ 2 η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0
```

差异及额外假设：驻值不是全局极小。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:35`。

### CH02-026 · §2.2.1 · 未编号结论 · 印刷p.62 / PDF84

原文（忠实转述）：Integration by parts removes eta' with zero boundary contributions.

```lean
-- MolecularDynamics.Chapter02Review.firstVariationParts_statement
def firstVariationParts_statement : Prop :=
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    η a = 0 → η b = 0 →
    (∫ t in a..b, (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
      -(∫ t in a..b, (deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t))
```

差异及额外假设：真实积分恒等式；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:34`。

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

### CH02-028 · §2.2.1 · 定义 · 印刷p.62 / PDF84

原文（忠实转述）：A variational derivative is a linear first-order approximation of the functional.

```lean
-- MolecularDynamics.Chapter02Review.variationalDerivative
def variationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop := HasFDerivAt F A q
```

差异及额外假设：用HasFDerivAt忠实定义，补原文缺失的F(q)。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:38`。

### CH02-029 · §2.2.1 · 未编号结论 · 印刷p.62 / PDF84

原文（忠实转述）：A stationary curve need not be an action minimizer.

```lean
-- MolecularDynamics.Chapter02Review.stationaryNotMinimum_statement
def stationaryNotMinimum_statement : Prop :=
  ∃ (L : Q 1 → Q 1 → ℝ) (q : ℝ → Q 1),
    ContDiff ℝ 2 (Function.uncurry L) ∧ ContDiff ℝ 2 q ∧ stationaryAction L 0 1 q ∧
    ∀ δ > 0, ∃ η : ℝ → Q 1, ContDiff ℝ 2 η ∧ η 0 = 0 ∧ η 1 = 0 ∧
      (∀ t ∈ Icc (0 : ℝ) 1, ‖η t‖ < δ) ∧ action L 0 1 (fun t => q t + η t) < action L 0 1 q
```

差异及额外假设：存在反例命题；原文脚注。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:46`。

### CH02-030 · §2.2.2 · 定义 · 印刷p.63 / PDF85

原文（忠实转述）：The discrete path consists of the points q_0,...,q_nu.

```lean
-- MolecularDynamics.Chapter02Review.discretePath
abbrev discretePath (n ν : ℕ) := Fin (ν + 1) → Q n
```

差异及额外假设：有限索引。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:40`。

### CH02-031 · §2.2.2 · 定义 · 印刷p.63 / PDF85

原文（忠实转述）：The discrete velocity is (q_(n+1)-q_n)/h.

```lean
-- MolecularDynamics.Chapter02Review.discreteVelocity
def discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)
```

差异及额外假设：h非零物理域。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:45`。

### CH02-032 · §2.2.2 · 定义 · 印刷p.63 / PDF85

原文（忠实转述）：The discrete action is h times the sum L(q_n,(q_(n+1)-q_n)/h).

```lean
-- MolecularDynamics.Chapter02Review.discreteAction
def discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)
```

差异及额外假设：正步长；原文L的+U为笔误，采用前文-U。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:47`。

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

### CH02-034 · §2.2.2 · 未编号结论 · 印刷p.64 / PDF86

原文（忠实转述）：The discrete action derivative is M(2q_n-q_(n-1)-q_(n+1))/h-h grad U(q_n).

```lean
-- MolecularDynamics.Chapter02Review.discreteActionDerivative_statement
def discreteActionDerivative_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i
```

差异及额外假设：实际Fréchet导数；仅内部节点。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:51`。

### CH02-035 · §2.2.2 · 未编号结论 · 印刷p.64 / PDF86

原文（忠实转述）：Discrete stationarity yields M(q_(n+1)-2q_n+q_(n-1))=-h^2 grad U(q_n), (2.4).

```lean
-- MolecularDynamics.Chapter02Review.discreteStationaryVerlet_statement
def discreteStationaryVerlet_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν,
    positiveMass m → Differentiable ℝ U → h ≠ 0 →
    (discreteStationary (mechanicalL m U) q h ν ↔
      ∀ k, 0 < k → k < ν → stormerRelation m (fun x => -grad U x) h (q (k-1)) (q k) (q (k+1)))
```

差异及额外假设：真实作用量驻值推导未证明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:57`。

### CH02-036 · §2.2.2 · 定义 · 印刷p.64 / PDF86

原文（忠实转述）：The Störmer position recurrence uses the centered second difference.

```lean
-- MolecularDynamics.Chapter02Review.stormerRelation
def stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  c - (2 : ℝ) • b + a = h^2 • invMass m (F b)
```

差异及额外假设：等式关系而非多步唯一解。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:54`。

### CH02-037 · §2.2.2 · 定义 · 印刷p.64 / PDF86

原文（忠实转述）：Velocity Verlet uses a half kick, position drift, and half kick, (2.5)-(2.7).

```lean
-- MolecularDynamics.Chapter02Review.velocityVerlet
def velocityVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vhalf := z.2 + (h/2) • invMass m (F z.1)
  let qnew := z.1 + h • vhalf
  (qnew, vhalf + (h/2) • invMass m (F qnew))
```

差异及额外假设：任意有限维正对角质量。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:56`。

### CH02-038 · §2.2.2 · 未编号结论 · 印刷p.65 / PDF87

原文（忠实转述）：Eliminating velocities from two Verlet steps yields the Störmer recurrence.

```lean
-- MolecularDynamics.Chapter02Review.velocityVerletStormer_proved
theorem velocityVerletStormer_proved : velocityVerletStormer_statement

-- MolecularDynamics.Chapter02Review.velocityVerletStormer_statement
def velocityVerletStormer_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h (a b c : Z n),
    b = velocityVerlet m F h a → c = velocityVerlet m F h b →
    stormerRelation m F h a.1 b.1 c.1
```

差异及额外假设：逐坐标代数；可限时补证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:24;MolecularDynamics/Chapter02/Statements.lean:62`。

### CH02-039 · §2.2.2 · 定义 · 印刷p.65 / PDF87

原文（忠实转述）：Momentum Verlet is Q=q+h M^-1 p+h^2 M^-1 F(q)/2, P=p+h(F(q)+F(Q))/2, (2.8).

```lean
-- MolecularDynamics.Chapter02Review.verlet
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```

差异及额外假设：定义完整映射，F独立参数。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:60`。

### CH02-040 · §2.2.2 · 定义 · 印刷p.65 / PDF87

原文（忠实转述）：Leapfrog evolves staggered velocity by a full kick and drifts positions.

```lean
-- MolecularDynamics.Chapter02Review.leapfrog
def leapfrog {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vnew := z.2 + h • invMass m (F z.1)
  (z.1 + h • vnew, vnew)
```

差异及额外假设：数学映射；排除力计算复用实现描述。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:63`。

### CH02-041 · §2.2.2 · 定义 · 印刷p.65 / PDF87

原文（忠实转述）：The staggered initial velocity is v_0-h M^-1 F(q_0)/2.

```lean
-- MolecularDynamics.Chapter02Review.leapfrogInitialize
def leapfrogInitialize {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 - (h/2) • invMass m (F z.1)
```

差异及额外假设：不忽略初始化。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:66`。

### CH02-042 · §2.2.2 · 定义 · 印刷p.65 / PDF87

原文（忠实转述）：Full-node velocity is reconstructed by a half kick.

```lean
-- MolecularDynamics.Chapter02Review.leapfrogReconstruct
def leapfrogReconstruct {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 + (h/2) • invMass m (F z.1)
```

差异及额外假设：真实速度关系。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:68`。

### CH02-043 · §2.2.3 · 未编号结论 · 印刷p.66 / PDF88

原文（忠实转述）：The error difference is G_h(z_n)-F_h(z(t_n)), (2.9).

```lean
-- MolecularDynamics.Chapter02Review.errorDifference_proved
theorem errorDifference_proved : errorDifference_statement

-- MolecularDynamics.Chapter02Review.errorDifference_statement
def errorDifference_statement : Prop :=
  ∀ n (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) h k,
    γ ((k+1 : ℕ)*h) = F h (γ (k*h)) →
    oneStepIterate G h (γ 0) (k+1) - γ ((k+1 : ℕ)*h) =
      G h (oneStepIterate G h (γ 0) k) - F h (γ (k*h))
```

差异及额外假设：实际一步关系；可直接证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:14;MolecularDynamics/Chapter02/Statements.lean:66`。

### CH02-044 · §2.2.3 · 定义 · 印刷p.66 / PDF88

原文（忠实转述）：Consistency of order p is a uniform local defect bound K h^(p+1), (2.10).

```lean
-- MolecularDynamics.Chapter02Review.consistentOrder
def consistentOrder {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  ∃ K > 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t) - G h (γ t)‖ ≤ K * h ^ (p+1)
```

差异及额外假设：沿精确轨道、固定窗口、K与h无关。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:70`。

### CH02-045 · §2.2.3 · 定义 · 印刷p.66 / PDF88

原文（忠实转述）：Stability is a Lipschitz factor at most 1+h L on the containing domain, (2.11).

```lean
-- MolecularDynamics.Chapter02Review.stableMethod
def stableMethod {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u - G h w‖ ≤ (1+h*L) * ‖u-w‖
```

差异及额外假设：L≥0，足够小正h。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:73`。

### CH02-046 · §2.2.3 · 未编号结论 · 印刷p.67 / PDF89

原文（忠实转述）：Local defect and stability imply e_(n+1)≤(1+Lh)e_n+K h^(p+1).

```lean
-- MolecularDynamics.oneStep_error_recursion
theorem oneStep_error_recursion (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    (h L K p : ℝ) (ν : ℕ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1))
    (n : ℕ) (hn : n < ν) :
    ‖oneStepIterate G h (γ 0) (n + 1) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤
      (1 + h * L) * ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ +
        K * h ^ (p + 1)
```

差异及额外假设：已证明实际误差递推；精确与数值留域。

状态：**proved**。位置：`MolecularDynamics/Chapter02/OneStepConvergence.lean:67`。

### CH02-047 · §2.2.3 · 未编号结论 · 印刷p.67 / PDF89

原文（忠实转述）：The error is bounded by (K/L) exp(Lnh) h^p, (2.12).

```lean
-- MolecularDynamics.oneStep_error_bound
theorem oneStep_error_bound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p
```

差异及额外假设：L>0避免除零；可把零L扩为正L。

状态：**proved**。位置：`MolecularDynamics/Chapter02/OneStepConvergence.lean:132`。

### CH02-048 · §2.2.3 · 未编号结论 · 印刷p.67 / PDF89

原文（忠实转述）：Consistency of order p and stability give convergence of order p.

```lean
-- MolecularDynamics.oneStep_converges_of_consistency_stability
theorem oneStep_converges_of_consistency_stability
    (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {τ δ L K p : ℝ} (hτ : 0 < τ) (hδ : 0 < δ) (hL : 0 < L)
    (hK : 0 ≤ K) (hp : 0 < p)
    (hexact : MapsTo γ (Icc 0 τ) D)
    (hnum : ∀ ν : ℕ, 0 < ν → τ / (ν : ℝ) ≤ δ →
      ∀ n ≤ ν, oneStepIterate G (τ / (ν : ℝ)) (γ 0) n ∈ D)
    (hstable : ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
      ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ h ∈ Ioo 0 δ, ∀ t ∈ Icc 0 τ, t + h ≤ τ →
      ‖G h (γ t) - γ (t + h)‖ ≤ K * h ^ (p + 1)) :
    Tendsto (fun ν : ℕ => oneStepMaxError G (τ / (ν : ℝ)) γ ν) atTop (𝓝 0)
```

差异及额外假设：保留原文简化的数值留域假设。

状态：**proved**。位置：`MolecularDynamics/Chapter02/OneStepConvergence.lean:168`。

### CH02-049 · §2.2.3 · 定义 · 印刷p.67 / PDF89

原文（忠实转述）：The scalar Verlet map has Q=q+h p+h^2 F(q)/2 and P=p+h(F(q)+F(Q))/2.

```lean
-- MolecularDynamics.Chapter02Review.verlet
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```

差异及额外假设：n=1,m=1实例。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:60`。

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

### CH02-051 · §2.2.3 · 未编号结论 · 印刷p.68 / PDF90

原文（忠实转述）：Exact position and momentum have cubic Taylor coefficients F'p/6 and (p^2 F''+F'F)/6.

```lean
-- MolecularDynamics.Chapter02Review.exactExpansion_statement
def exactExpansion_statement : Prop :=
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4)
```

差异及额外假设：真实解、C3力、原文展开；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:80`。

### CH02-052 · §2.2.3 · 未编号结论 · 印刷p.68 / PDF90

原文（忠实转述）：Verlet position defect is -h^3 F'p/6+O(h^4) and momentum defect h^3(p^2 F''+F'F)/12+O(h^4).

```lean
-- MolecularDynamics.Chapter02Review.verletDefectExpansion_statement
def verletDefectExpansion_statement : Prop :=
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1+
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1)) (fun h : ℝ => h^4)

-- MolecularDynamics.Chapter02Review.verletDefectPrinted_statement
def verletDefectPrinted_statement : Prop :=
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4)
```

差异及额外假设：原文位置差误写正号；保留修正与字面两个陈述。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:88;MolecularDynamics/Chapter02/Statements.lean:95`。

### CH02-053 · §2.2.3 · 未编号结论 · 印刷p.68 / PDF90

原文（忠实转述）：Verlet has uniform local error O(h^3) on a compact trajectory.

```lean
-- MolecularDynamics.Chapter02Review.verletConsistency_statement
def verletConsistency_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) (Φ : ℝ → Z n → Z n) (K : Set (Z n)) δ,
    positiveMass m → ContDiff ℝ 3 F → IsCompact K → 0 < δ →
    ContinuousOn (Function.uncurry Φ) (Icc (-δ) δ ×ˢ K) →
    (∀ z ∈ K, Φ 0 z = z ∧ solution (mechanicalField m F) (fun t => Φ t z) (-δ) δ) →
    ∃ C > 0, ∀ h ∈ Icc 0 δ, ∀ z ∈ K, ‖verlet m F h z-Φ h z‖ ≤ C*h^3
```

差异及额外假设：不是忽略h4项当严格界；补紧性和正则性。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:100`。

### CH02-054 · §2.2.3 · 未编号结论 · 印刷p.69 / PDF91

原文（忠实转述）：A Lipschitz force gives the Verlet stability factor 1+h L.

```lean
-- MolecularDynamics.Chapter02Review.verletStability_statement
def verletStability_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖
```

差异及额外假设：整空间Lipschitz或留域邻域；仅正文结论，习题证明排除。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:106`。

### CH02-055 · §2.2.4 · 定义 · 印刷p.70 / PDF92

原文（忠实转述）：A first integral satisfies grad I dot f=0 on the domain.

```lean
-- MolecularDynamics.Chapter02Review.firstIntegral
def firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```

差异及额外假设：定义用fderiv作用。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:76`。

### CH02-056 · §2.2.4 · 未编号结论 · 印刷p.70 / PDF92

原文（忠实转述）：A first integral is preserved by the exact flow.

```lean
-- MolecularDynamics.firstIntegral_const_on_Ioo
theorem firstIntegral_const_on_Ioo (f : E → E) (J : E → ℝ) (Q : Set E)
    (a b : ℝ) (γ : ℝ → E)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x)
    (hfirst : ∀ x ∈ Q, fderiv ℝ J x (f x) = 0)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) : J (γ s) = J (γ t)

-- MolecularDynamics.Chapter02Review.firstIntegralPreserved_statement
def firstIntegralPreserved_statement : Prop :=
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a)
```

差异及额外假设：真实解和连通时间区间；复用第1章开放时间区间完整守恒证明；所附较强闭区间Prop仍未证明。

状态：**proved**。位置：`MolecularDynamics/Chapter01/FirstIntegrals.lean:29;MolecularDynamics/Chapter02/Statements.lean:112`。

### CH02-057 · §2.2.4 · 未编号结论 · 印刷p.70 / PDF92

原文（忠实转述）：Hamiltonian flow preserves H.

```lean
-- MolecularDynamics.textbookHamiltonian_energy_const_on_Icc
theorem textbookHamiltonian_energy_const_on_Icc (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0)
```

差异及额外假设：已有Chapter03可复用；可微H、真实Hamilton曲线。

状态：**proved**。位置：`MolecularDynamics/Chapter03/LiePoisson.lean:226`。

### CH02-058 · §2.2.4 · 未编号结论 · 印刷p.71 / PDF93

原文（忠实转述）：Planar central-force motion conserves angular momentum.

```lean
-- MolecularDynamics.Chapter02Review.centralAngularMomentum_statement
def centralAngularMomentum_statement : Prop :=
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1
```

差异及额外假设：复用第1章结论核对后映射，当前一般陈述待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:116`。

### CH02-059 · §2.2.4 · 未编号结论 · 印刷p.71 / PDF93

原文（忠实转述）：The scalar mean-value theorem gives I(a)-I(b)=grad I(c) dot(a-b) on the segment.

```lean
-- MolecularDynamics.Chapter02Review.integralMeanValue_statement
def integralMeanValue_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b = (fderiv ℝ I c) (a-b)
```

差异及额外假设：补包含整条线段的开域；非任意非凸D。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:124`。

### CH02-060 · §2.2.4 · 未编号结论 · 印刷p.71 / PDF93

原文（忠实转述）：A bounded gradient makes I Lipschitz along the segment.

```lean
-- MolecularDynamics.Chapter02Review.integralLipschitz_statement
def integralLipschitz_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) → |I a-I b| ≤ B*‖a-b‖
```

差异及额外假设：凸邻域或线段包含条件；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:128`。

### CH02-061 · §2.2.4 · 未编号结论 · 印刷p.71 / PDF93

原文（忠实转述）：First-integral error inherits O(h^p) finite-interval trajectory error, (2.16).

```lean
-- MolecularDynamics.Chapter02Review.integralError_statement
def integralError_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/L)*Real.exp (L*k*h)*h^p

-- MolecularDynamics.Chapter02Review.integralErrorPrinted_statement
def integralErrorPrinted_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/(2*L))*Real.exp (L*k*h)*h^p
```

差异及额外假设：原常数1/2无出处；忠实字面版与安全界并存。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:132;MolecularDynamics/Chapter02/Statements.lean:138`。

### CH02-062 · §2.3.1 · 定义 · 印刷p.72 / PDF94

原文（忠实转述）：Divergence is the trace of the Jacobian.

```lean
-- MolecularDynamics.Chapter02Review.divergence
def divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace
```

差异及额外假设：有限实坐标。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:78`。

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

### CH02-065 · §2.3.1 · 未编号结论 · 印刷p.72 / PDF94

原文（忠实转述）：Hamiltonian flow preserves phase-space volume.

```lean
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

-- MolecularDynamics.Chapter02Review.hamiltonianVolume_statement
def hamiltonianVolume_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → volume ((fun z => Φ (t,z)) '' S) = volume S

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

差异及额外假设：jointC2解族、实际可测域；补较弱正则性忠实陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/HamiltonianVolume.lean:122;MolecularDynamics/Chapter02/Statements.lean:151;MolecularDynamics/Chapter02/Statements.lean:379`。

### CH02-066 · §2.3.1 · 未编号结论 · 印刷p.73 / PDF95

原文（忠实转述）：Volume under a flow is the integral of the absolute Jacobian determinant.

```lean
-- MolecularDynamics.Chapter02Review.volumeChange_statement
def volumeChange_statement : Prop :=
  ∀ n (Φ : Q n → Q n) (S : Set (Q n)), ContDiff ℝ 1 Φ → Function.Injective Φ → MeasurableSet S →
    volume (Φ '' S) = ∫⁻ z in S, ENNReal.ofReal |(textbookCoordinateJacobian Φ z).det| ∂volume
```

差异及额外假设：C1单射微分同胚、可测集；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:156`。

### CH02-067 · §2.3.1 · 未编号结论 · 印刷p.73 / PDF95

原文（忠实转述）：The actual flow Jacobian solves W'=f'(z)W.

```lean
-- MolecularDynamics.textbookSolutionFamilyJacobian_hasDerivAt
theorem textbookSolutionFamilyJacobian_hasDerivAt (f : (ι → ℝ) → ι → ℝ)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (t : ℝ) (z : ι → ℝ)
    (hf : DifferentiableAt ℝ f (Φ (t, z)))
    (hODE : ∀ᶠ y in 𝓝 z, HasDerivAt (fun s => Φ (s, y)) (f (Φ (t, y))) t) :
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s, y)) z)
      (textbookCoordinateJacobian f (Φ (t, z)) *
        textbookCoordinateJacobian (fun y => Φ (t, y)) z) t

-- MolecularDynamics.Chapter02Review.flowVariational_statement
def flowVariational_statement : Prop :=
  ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ, ∀ z,
      HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) z)
        (textbookCoordinateJacobian f (Φ (t,z)) * textbookCoordinateJacobian (fun y => Φ (t,y)) z) t

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

差异及额外假设：jointC2解族；书中W取值点应为初值，不应重复沿轨道。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/LiouvilleVolume.lean:63;MolecularDynamics/Chapter02/Statements.lean:159;MolecularDynamics/Chapter02/Statements.lean:370`。

### CH02-068 · §2.3.1 · 未编号结论 · 印刷p.73 / PDF95

原文（忠实转述）：D=det W solves D'=div f(z) D.

```lean
-- MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE
theorem textbookMatrixDet_hasDerivAt_of_linearODE (W : ℝ → Matrix ι ι ℝ)
    (A : Matrix ι ι ℝ) (t : ℝ) (hW : HasDerivAt W (A * W t) t) :
    HasDerivAt (fun s => (W s).det) (A.trace * (W t).det) t
```

差异及额外假设：完整矩阵导数公式；不需假设W可逆。

状态：**proved**。位置：`MolecularDynamics/Chapter02/LiouvilleVolume.lean:41`。

### CH02-069 · §2.3.1 · 未编号结论 · 印刷p.73 / PDF95

原文（忠实转述）：D(t)=D(0) exp(integral_0^t div f(z(s)) ds).

```lean
-- MolecularDynamics.Chapter02Review.determinantExponential_statement
def determinantExponential_statement : Prop :=
  ∀ n (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    Continuous A → (∀ s, HasDerivAt W (A s * W s) s) →
    (W t).det = (W 0).det * Real.exp (∫ s in (0 : ℝ)..t, (A s).trace)
```

差异及额外假设：连续系数、真实W；待补积分解公式。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:164`。

### CH02-070 · §2.3.1 · 未编号结论 · 印刷p.73 / PDF95

原文（忠实转述）：If div f=0 and W(0)=I then det W(t)=1.

```lean
-- MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2
theorem textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2
    (f : (ι → ℝ) → ι → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × (ι → ℝ) → ι → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1

-- MolecularDynamics.Chapter02Review.flowDet_statement
def flowDet_statement : Prop :=
  ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ,
    flowC1 f Φ τ → (∀ z, divergence f z = 0) → ∀ t ∈ Icc 0 τ, ∀ z,
      (textbookCoordinateJacobian (fun y => Φ (t,y)) z).det = 1

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

差异及额外假设：jointC2解族；补C1变分陈述。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/LiouvilleVolume.lean:82;MolecularDynamics/Chapter02/Statements.lean:168;MolecularDynamics/Chapter02/Statements.lean:370`。

### CH02-071 · §2.3.2 · 未编号结论 · 印刷p.74 / PDF96

原文（忠实转述）：A linear system z'=S z is divergence free exactly when tr S=0.

```lean
-- MolecularDynamics.Chapter02Review.linearDivergence_statement
def linearDivergence_statement : Prop :=
  ∀ n (S : Matrix (Fin n) (Fin n) ℝ) z, divergence S.mulVec z = S.trace
```

差异及额外假设：有限实矩阵；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:172`。

### CH02-072 · §2.3.2 · 定义 · 印刷p.75 / PDF97

原文（忠实转述）：Euler for z'=S z is multiplication by I+hS.

```lean
-- MolecularDynamics.Chapter02Review.linearEuler
def linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S
```

差异及额外假设：有限矩阵。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:79`。

### CH02-073 · §2.3.2 · 未编号结论 · 印刷p.75 / PDF97

原文（忠实转述）：Euler preserves oriented linear volume exactly when det(I+hS)=1.

```lean
-- MolecularDynamics.Chapter02Review.linearEulerVolume_statement
def linearEulerVolume_statement : Prop :=
  ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T → volume ((linearEuler S h).mulVec '' T) = volume T) ↔
      |(linearEuler S h).det| = 1
```

差异及额外假设：原体积只需绝对det=1；正小h方向条件需注明。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:174`。

### CH02-074 · §2.3.2 · 未编号结论 · 印刷p.75 / PDF97

原文（忠实转述）：Euler does not generally preserve volume for divergence-free fields.

```lean
-- MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved
theorem eulerVolumeCounterexample_proved : eulerVolumeCounterexample_statement

-- MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_statement
def eulerVolumeCounterexample_statement : Prop :=
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1
```

差异及额外假设：具体二维旋转反例而非含糊否定；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:63;MolecularDynamics/Chapter02/Statements.lean:178`。

### CH02-075 · §2.3.2 · 定义 · 印刷p.75 / PDF97

原文（忠实转述）：Asymmetric Euler is U=u+h f(U,v), V=v+h g(U,v).

```lean
-- MolecularDynamics.Chapter02Review.asymmetricEulerRelation
def asymmetricEulerRelation (f g : ℝ → ℝ → ℝ) (h u v U V : ℝ) : Prop :=
  U = u + h*f U v ∧ V = v + h*g U v
```

差异及额外假设：隐式关系；不宣称全球唯一解。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:81`。

### CH02-076 · §2.3.2 · 未编号结论 · 印刷p.75 / PDF97

原文（忠实转述）：Its Jacobian determinant is (1+h g_v)/(1-h f_u).

```lean
-- MolecularDynamics.Chapter02Review.asymmetricDet_statement
def asymmetricDet_statement : Prop :=
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))
```

差异及额外假设：隐式函数可微、分母非零。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:180`。

### CH02-077 · §2.3.2 · 未编号结论 · 印刷p.76 / PDF98

原文（忠实转述）：Asymmetric Euler preserves area when f_u+g_v=0.

```lean
-- MolecularDynamics.Chapter02Review.asymmetricArea_statement
def asymmetricArea_statement : Prop :=
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    ∀ z, (textbookCoordinateJacobian Ψ z).det = 1
```

差异及额外假设：存在光滑局部解和分母非零。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:187`。

### CH02-078 · §2.3.3 · 定义 · 印刷p.76 / PDF98

原文（忠实转述）：A symplectic map satisfies D Phi^T J D Phi=J.

```lean
-- MolecularDynamics.IsTextbookSymplecticMap
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```

差异及额外假设：要求可微；局部性质不保证全球可逆。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticMaps.lean:55`。

### CH02-079 · §2.3.3 · 定义 · 印刷p.76 / PDF98

原文（忠实转述）：A one-form is a point-dependent linear functional.

```lean
-- MolecularDynamics.Chapter02Review.oneForm
abbrev oneForm (n : ℕ) := Q n → Q n →L[ℝ] ℝ
```

差异及额外假设：坐标域中的线性形式族。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:83`。

### CH02-080 · §2.3.3 · 定义 · 印刷p.76 / PDF98

原文（忠实转述）：The differential dg is the derivative of g acting on tangent vectors.

```lean
-- MolecularDynamics.Chapter02Review.differential
def differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g
```

差异及额外假设：实际Fréchet导数。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:84`。

### CH02-081 · §2.3.3 · 定义 · 印刷p.76 / PDF98

原文（忠实转述）：dq_i and dp_i select tangent vector coordinates.

```lean
-- MolecularDynamics.textbookDq
def textbookDq {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinates Nc →ₗ[ℝ] ℝ where
  toFun u := u (Sum.inl i)
  -- 结构证明字段省略；完整定义见源码

-- MolecularDynamics.textbookDp
def textbookDp {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinates Nc →ₗ[ℝ] ℝ where
  toFun u := u (Sum.inr i)
  -- 结构证明字段省略；完整定义见源码
```

差异及额外假设：位置/动量索引。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticForm.lean:47;MolecularDynamics/Chapter02/SymplecticForm.lean:53`。

### CH02-082 · §2.3.3 · 定义 · 印刷p.76 / PDF98

原文（忠实转述）：The wedge is alpha(u) beta(v)-alpha(v) beta(u).

```lean
-- MolecularDynamics.textbookWedgeOneForms
def textbookWedgeOneForms {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α
```

差异及额外假设：反对称双线性式。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticForm.lean:65`。

### CH02-083 · §2.3.3 · 定义 · 印刷p.77 / PDF99

原文（忠实转述）：The canonical symplectic form is u^T J v.

```lean
-- MolecularDynamics.textbookSymplecticForm
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

差异及额外假设：教材符号。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticForm.lean:77`。

### CH02-084 · §2.3.3 · 未编号结论 · 印刷p.77 / PDF99

原文（忠实转述）：The symplectic form is the sum of dq_i wedge dp_i.

```lean
-- MolecularDynamics.textbookSymplecticForm_eq_sum_wedges
theorem textbookSymplecticForm_eq_sum_wedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i)
```

差异及额外假设：有限坐标求和。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticForm.lean:89`。

### CH02-085 · §2.3.3 · 定义 · 印刷p.77 / PDF99

原文（忠实转述）：A general two-form has skew coefficients depending on the point.

```lean
-- MolecularDynamics.Chapter02Review.twoForm
def twoForm (n : ℕ) :=
  {A : Q n → Q n →L[ℝ] Q n →L[ℝ] ℝ // ∀ z u v, A z u v = -A z v u}
```

差异及额外假设：反对称矩阵；原文双和与系数2约定待审。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:85`。

### CH02-086 · §2.3.3 · 定义 · 印刷p.77 / PDF99

原文（忠实转述）：Pullback of a one-form evaluates it at Phi(z) on D Phi(z) u.

```lean
-- MolecularDynamics.Chapter02Review.pullbackOne
def pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)
```

差异及额外假设：真实Jacobian与取值点。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:87`。

### CH02-087 · §2.3.3 · 定义 · 印刷p.77 / PDF99

原文（忠实转述）：Pullback of a two-form acts on both derivative-transformed arguments.

```lean
-- MolecularDynamics.Chapter02Review.pullbackTwo
def pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)
```

差异及额外假设：完整位置相关定义。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:89`。

### CH02-088 · §2.3.3 · 未编号结论 · 印刷p.78 / PDF100

原文（忠实转述）：Matrix pullback is D Phi(z)^T A(Phi(z)) D Phi(z).

```lean
-- MolecularDynamics.Chapter02Review.pullbackMatrix_statement
def pullbackMatrix_statement : Prop :=
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v)
```

差异及额外假设：原文一般守恒省略A取值点；用完整版本。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:194`。

### CH02-089 · §2.3.3 · 定义 · 印刷p.78 / PDF100

原文（忠实转述）：Preservation of a two-form is equality of its pullback with itself.

```lean
-- MolecularDynamics.Chapter02Review.preservesTwoForm
def preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v
```

差异及额外假设：位置相关A需在Phi(z)取值。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:91`。

### CH02-090 · §2.3.3 · 未编号结论 · 印刷p.78 / PDF100

原文（忠实转述）：Symplecticity is equivalent to preserving the canonical form.

```lean
-- MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form
theorem isTextbookSymplecticMap_iff_preserves_form {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v
```

差异及额外假设：实际可微映射。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticMaps.lean:61`。

### CH02-091 · §2.3.3 · 未编号结论 · 印刷p.78 / PDF100

原文（忠实转述）：A symplectic Jacobian has determinant squared one and absolute determinant one.

```lean
-- MolecularDynamics.IsTextbookSymplectic.det_square
theorem IsTextbookSymplectic.det_square {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : A.det ^ 2 = 1

-- MolecularDynamics.IsTextbookSymplectic.abs_det
theorem IsTextbookSymplectic.abs_det {Nc : ℕ} {A : SymplecticCoordinateMatrix Nc}
    (hA : IsTextbookSymplectic A) : |A.det| = 1
```

差异及额外假设：已有更强det=1结论；原文±1疑虑无须流连续性。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticForm.lean:177;MolecularDynamics/Chapter02/SymplecticForm.lean:182`。

### CH02-092 · §2.3.3 · 未编号结论 · 印刷p.78 / PDF100

原文（忠实转述）：Hamiltonian flow has determinant one.

```lean
-- MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2
theorem textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t, y)) z).det = 1

-- MolecularDynamics.Chapter02Review.hamiltonianDet_statement
def hamiltonianDet_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det = 1

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

差异及额外假设：jointC2解族；完整C1域陈述补齐。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/ActualFlowVariations.lean:165;MolecularDynamics/Chapter02/Statements.lean:210;MolecularDynamics/Chapter02/Statements.lean:379`。

### CH02-093 · §2.3.4 · 定义 · 印刷p.79 / PDF101

原文（忠实转述）：The Hessian of H gives a symmetric matrix S.

```lean
-- MolecularDynamics.textbookHamiltonianHessian
noncomputable def textbookHamiltonianHessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)
```

差异及额外假设：C2时对称性另有证明。

状态：**defined**。位置：`MolecularDynamics/Chapter02/HamiltonianVariational.lean:50`。

### CH02-094 · §2.3.4 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：The Hamiltonian Hessian is symmetric.

```lean
-- MolecularDynamics.textbookHamiltonianHessian_isSymm
theorem textbookHamiltonianHessian_isSymm {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm
```

差异及额外假设：H C2。

状态：**proved**。位置：`MolecularDynamics/Chapter02/HamiltonianVariational.lean:55`。

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

### CH02-096 · §2.3.4 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：J^T=-J and J^2=-I imply cancellation in the derivative of W^T J W.

```lean
-- MolecularDynamics.hamiltonian_variational_matrix_cancellation
theorem hamiltonian_variational_matrix_cancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0
```

差异及额外假设：对称S；真实矩阵代数。

状态：**proved**。位置：`MolecularDynamics/Chapter02/HamiltonianVariational.lean:63`。

### CH02-097 · §2.3.4 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：W^T J W is constant along Hamiltonian variational solutions.

```lean
-- MolecularDynamics.hamiltonian_variational_form_constant
theorem hamiltonian_variational_form_constant {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, (W t)ᵀ * textbookJ Nc * W t = (W 0)ᵀ * textbookJ Nc * W 0
```

差异及额外假设：连通时间区间、实际导数。

状态：**proved**。位置：`MolecularDynamics/Chapter02/HamiltonianVariational.lean:93`。

### CH02-098 · §2.3.4 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：Hamiltonian flow is symplectic.

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

-- MolecularDynamics.Chapter02Review.hamiltonianSymplectic_statement
def hamiltonianSymplectic_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t,z))

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

差异及额外假设：jointC2解族；一般局部C1流陈述补齐。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/ActualFlowVariations.lean:143;MolecularDynamics/Chapter02/Statements.lean:205;MolecularDynamics/Chapter02/Statements.lean:379`。

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

### CH02-100 · §2.3.5 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：A composition of symplectic maps is symplectic.

```lean
-- MolecularDynamics.IsTextbookSymplecticMap.comp
theorem IsTextbookSymplecticMap.comp {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ)
```

差异及额外假设：真实可微映射。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticMaps.lean:86`。

### CH02-101 · §2.3.5 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：An inverse symplectic diffeomorphism is symplectic.

```lean
-- MolecularDynamics.IsTextbookSymplecticEquiv.symm
theorem IsTextbookSymplecticEquiv.symm {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm
```

差异及额外假设：假设给定全局可微逆，不从局部det非零冒充全球逆。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticMaps.lean:136`。

### CH02-102 · §2.3.5 · 未编号结论 · 印刷p.79 / PDF101

原文（忠实转述）：Symplectic maps are always globally invertible and form a group.

```lean
-- MolecularDynamics.Chapter02Review.globalSymplecticGroup_statement
def globalSymplecticGroup_statement : Prop :=
  ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n), IsTextbookSymplecticMap Φ → Function.Bijective Φ
```

差异及额外假设：字面断言欠全球双射；另有正确辛微分同胚群定义，待人工判断。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:215`。

### CH02-103 · §2.3.5 · 定义 · 印刷p.79 / PDF101

原文（忠实转述）：Globally invertible smooth symplectic maps form the symplectic diffeomorphism group.

```lean
-- MolecularDynamics.textbookSymplecticDiffeomorphismGroup_mem_iff
theorem textbookSymplecticDiffeomorphismGroup_mem_iff {Nc : ℕ}
    (e : Equiv.Perm (SymplecticCoordinates Nc)) :
    e ∈ textbookSymplecticDiffeomorphismGroup Nc ↔ IsTextbookSymplecticEquiv e

-- MolecularDynamics.textbookSymplecticDiffeomorphismGroup
noncomputable def textbookSymplecticDiffeomorphismGroup (Nc : ℕ) :
    Subgroup (Equiv.Perm (SymplecticCoordinates Nc)) where
  carrier := {e | IsTextbookSymplecticEquiv e}
  -- 结构证明字段省略；完整定义见源码
```

差异及额外假设：全球可微逆明示。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticMaps.lean:155;MolecularDynamics/Chapter02/SymplecticMaps.lean:148`。

### CH02-104 · §2.3.6 · 定义 · 印刷p.80 / PDF102

原文（忠实转述）：A symplectic integrator is a one-step map preserving the symplectic form.

```lean
-- MolecularDynamics.Chapter02Review.symplecticIntegrator
def symplecticIntegrator {n : ℕ} (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∀ h, IsTextbookSymplecticMap (G h)
```

差异及额外假设：不将精度结论塞进定义。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:93`。

### CH02-105 · §2.3.6 · 定义 · 印刷p.80 / PDF102

原文（忠实转述）：Symplectic Euler is P=p+h F(q), Q=q+h M^-1 P.

```lean
-- MolecularDynamics.textbookSymplecticEuler
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```

差异及额外假设：kick后drift。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticEuler.lean:184`。

### CH02-106 · §2.3.6 · 未编号结论 · 印刷p.81 / PDF103

原文（忠实转述）：The derivative of the kick contains the symmetric potential Hessian.

```lean
-- MolecularDynamics.textbookJacobian_momentumKick
theorem textbookJacobian_momentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    textbookJacobian (textbookMomentumKick F h) z = Matrix.fromBlocks 1 0
      (h • LinearMap.toMatrix' (fderiv ℝ F (textbookPositionProjection Nc z)).toLinearMap) 1
```

差异及额外假设：U C2、实际Jacobian。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticEuler.lean:107`。

### CH02-107 · §2.3.6 · 未编号结论 · 印刷p.81 / PDF103

原文（忠实转述）：The wedge of a one-form with itself vanishes.

```lean
-- MolecularDynamics.Chapter02Review.wedgeSelf_proved
theorem wedgeSelf_proved : wedgeSelf_statement

-- MolecularDynamics.Chapter02Review.wedgeSelf_statement
def wedgeSelf_statement : Prop :=
  ∀ n (α : SymplecticCoordinates n →ₗ[ℝ] ℝ) u v, textbookWedgeOneForms α α u v = 0
```

差异及额外假设：可直接双线性代数证明；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:9;MolecularDynamics/Chapter02/Statements.lean:217`。

### CH02-108 · §2.3.6 · 未编号结论 · 印刷p.81 / PDF103

原文（忠实转述）：Symplectic Euler preserves the canonical form.

```lean
-- MolecularDynamics.textbookSymplecticEuler_isSymplectic
theorem textbookSymplecticEuler_isSymplectic {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h)
```

差异及额外假设：U C2，固定对角质量。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SymplecticEuler.lean:202`。

### CH02-109 · §2.3.7 · 定义 · 印刷p.81 / PDF103

原文（忠实转述）：The adjoint is G_h^*=G_(-h)^-1.

```lean
-- MolecularDynamics.textbookAdjointMethod
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```

差异及额外假设：给定每步双射，反步可用。

状态：**defined**。位置：`MolecularDynamics/Chapter02/AdjointMethods.lean:16`。

### CH02-110 · §2.3.7 · 未编号结论 · 印刷p.82 / PDF104

原文（忠实转述）：The exact flow is self-adjoint.

```lean
-- MolecularDynamics.textbookFlowMethod_isSelfAdjoint
theorem textbookFlowMethod_isSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F
```

差异及额外假设：全局flow群接口；局部流需限制定义域。

状态：**proved**。位置：`MolecularDynamics/Chapter02/AdjointMethods.lean:41`。

### CH02-111 · §2.3.7 · 定义 · 印刷p.82 / PDF104

原文（忠实转述）：Backward Euler is Z=z+h f(Z).

```lean
-- MolecularDynamics.Chapter02Review.backwardEulerRelation
def backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
```

差异及额外假设：关系、不宣称解唯一。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:95`。

### CH02-112 · §2.3.7 · 未编号结论 · 印刷p.82 / PDF104

原文（忠实转述）：Euler's adjoint is backward Euler.

```lean
-- MolecularDynamics.euler_adjoint_iff_backward
theorem euler_adjoint_iff_backward (f : E → E) (G : ℝ → Equiv.Perm E)
    (h : ℝ) (hG : ∀ Z, G (-h) Z = eulerStep f (-h) Z) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ Z = z + h • f Z
```

差异及额外假设：给定Euler双射，不假设所有h均可逆。

状态：**proved**。位置：`MolecularDynamics/Chapter02/AdjointMethods.lean:61`。

### CH02-113 · §2.3.7 · 定义 · 印刷p.82 / PDF104

原文（忠实转述）：Adjoint symplectic Euler is Q=q+h M^-1 p, P=p+h F(Q).

```lean
-- MolecularDynamics.textbookAdjointSymplecticEuler
noncomputable def textbookAdjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h
```

差异及额外假设：实际drift后kick。

状态：**defined**。位置：`MolecularDynamics/Chapter02/AdjointMethods.lean:69`。

### CH02-114 · §2.3.7 · 未编号结论 · 印刷p.82 / PDF104

原文（忠实转述）：The adjoint of the adjoint is the original method.

```lean
-- MolecularDynamics.textbookAdjointMethod_involutive
theorem textbookAdjointMethod_involutive {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G
```

差异及额外假设：Equiv.Perm接口。

状态：**proved**。位置：`MolecularDynamics/Chapter02/AdjointMethods.lean:25`。

### CH02-115 · §2.4.1 · 定义 · 印刷p.83 / PDF105

原文（忠实转述）：A Hamiltonian splitting divides H into H1+H2 and composes their maps.

```lean
-- MolecularDynamics.Chapter02Review.splittingMap
def splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h
```

差异及额外假设：组合从右到左。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:141`。

### CH02-116 · §2.4.1 · 未编号结论 · 印刷p.83 / PDF105

原文（忠实转述）：The Hamiltonian vector field of H1+H2 is the sum of the fields.

```lean
-- MolecularDynamics.textbookHamiltonianVectorField_add
theorem textbookHamiltonianVectorField_add {Nc : ℕ}
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (h₁ : DifferentiableAt ℝ H₁ z) (h₂ : DifferentiableAt ℝ H₂ z) :
    textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) z =
      textbookHamiltonianVectorField H₁ z + textbookHamiltonianVectorField H₂ z
```

差异及额外假设：两者可微。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SplittingError.lean:198`。

### CH02-117 · §2.4.1 · 未编号结论 · 印刷p.83 / PDF105

原文（忠实转述）：Splitting actual subflows gives local error O(h^2).

```lean
-- MolecularDynamics.exists_hamiltonian_splitting_localError_bound
theorem exists_hamiltonian_splitting_localError_bound {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2))
```

差异及额外假设：真实子流正则性和留域；常数从C1/C2条件推导。

状态：**proved**。位置：`MolecularDynamics/Chapter02/SplittingError.lean:217`。

### CH02-118 · §2.4.1 · 定义 · 印刷p.83 / PDF105

原文（忠实转述）：The kinetic subflow is Q=q+h M^-1 p, P=p.

```lean
-- MolecularDynamics.textbookPositionDrift
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```

差异及额外假设：固定质量。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticEuler.lean:77`。

### CH02-119 · §2.4.1 · 定义 · 印刷p.84 / PDF106

原文（忠实转述）：The potential subflow is Q=q, P=p-h grad U(q).

```lean
-- MolecularDynamics.textbookMomentumKick
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```

差异及额外假设：真实势力定义。

状态：**defined**。位置：`MolecularDynamics/Chapter02/SymplecticEuler.lean:70`。

### CH02-120 · §2.4.1 · 未编号结论 · 印刷p.84 / PDF106

原文（忠实转述）：Kinetic and potential maps compose to symplectic Euler and its adjoint.

```lean
-- MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved
theorem kineticPotentialComposition_proved : kineticPotentialComposition_statement

-- MolecularDynamics.Chapter02Review.kineticPotentialComposition_statement
def kineticPotentialComposition_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z)
```

差异及额外假设：已有映射定义即组合；流解身份单列补证；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:74;MolecularDynamics/Chapter02/Statements.lean:357`。

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

### CH02-123 · §2.4.1 · 未编号结论 · 印刷p.85 / PDF107

原文（忠实转述）：A composition with its adjoint in symmetric half steps is self-adjoint.

```lean
-- MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint
theorem textbookSymmetricComposition_isSelfAdjoint {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G
```

差异及额外假设：可逆步映射。

状态：**proved**。位置：`MolecularDynamics/Chapter02/CompositionMethods.lean:49`。

### CH02-124 · §2.4.1 · 未编号结论 · 印刷p.85 / PDF107

原文（忠实转述）：A consistent symmetric method has even finite order.

```lean
-- MolecularDynamics.Chapter02Review.symmetricEvenOrder_statement
def symmetricEvenOrder_statement : Prop :=
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r
```

差异及额外假设：需存在非零首误差项和光滑步长展开，排除精确流的无穷阶。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:231`。

### CH02-125 · §2.4.2 · 未编号结论 · 印刷p.85 / PDF107

原文（忠实转述）：Composing symplectic numerical methods gives another symplectic method.

```lean
-- MolecularDynamics.textbookComposeMethods_isSymplectic
theorem textbookComposeMethods_isSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → Equiv.Perm (SymplecticCoordinates Nc))
    (hG₁ : ∀ h, IsTextbookSymplecticEquiv (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticEquiv (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticEquiv (textbookComposeMethods G₁ G₂ h)
```

差异及额外假设：任意组合步参数。

状态：**proved**。位置：`MolecularDynamics/Chapter02/CompositionMethods.lean:56`。

### CH02-126 · §2.4.2 · 未编号结论 · 印刷p.85 / PDF107

原文（忠实转述）：For approximations to the same flow, half-step composition has order at least the minimum of the two orders.

```lean
-- MolecularDynamics.Chapter02Review.compositionOrder_statement
def compositionOrder_statement : Prop :=
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s)
```

差异及额外假设：补same flow与稳定性；不同Hamiltonian半步字面需区分。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:239`。

### CH02-127 · §2.4.3 · 定义 · 印刷p.85 / PDF107

原文（忠实转述）：Harmonic plus anharmonic splitting composes the oscillator matrix flow with a potential kick.

```lean
-- MolecularDynamics.Chapter02Review.harmonicAnharmonic
def harmonicAnharmonic (Ω : ℝ) (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```

差异及额外假设：Omega非零；定义数学映射，不含数值实验。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:96`。

### CH02-128 · §2.4.4 · 未编号结论 · 印刷p.86 / PDF108

原文（忠实转述）：Small-step implicit equations have a unique smooth local solution when the defining derivative is nonsingular.

```lean
-- MolecularDynamics.Chapter02Review.implicitLocal_statement
def implicitLocal_statement : Prop :=
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n), ContDiff ℝ 1 g → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ U V : Set (Q n), IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g x ∈ V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ 1 inv V ∧
        (∀ y ∈ V, inv y ∈ U ∧ g (inv y) = y) ∧ (∀ y ∈ U, inv (g y) = y)
```

差异及额外假设：局部逆函数条件；不声称全球逆。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:245`。

### CH02-129 · §2.4.4 · 定义 · 印刷p.86 / PDF108

原文（忠实转述）：Newton's update is x-(g'(x))^-1(g(x)-tau).

```lean
-- MolecularDynamics.Chapter02Review.newtonStep
def newtonStep {n : ℕ} (g : Q n → Q n) (τ x : Q n) (A : Q n ≃L[ℝ] Q n) : Q n :=
  x - A.symm (g x - τ)
```

差异及额外假设：有限维连续线性等价接口。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:99`。

### CH02-130 · §2.4.4 · 未编号结论 · 印刷p.87 / PDF109

原文（忠实转述）：Newton's method converges quadratically near a simple zero.

```lean
-- MolecularDynamics.Chapter02Review.newtonQuadratic_statement
def newtonQuadratic_statement : Prop :=
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2
```

差异及额外假设：C2、非奇异导数、充分近初值，待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:250`。

### CH02-131 · §2.4.4 · 未编号结论 · 印刷p.87 / PDF109

原文（忠实转述）：A frozen approximate Jacobian gives geometric convergence under a contraction condition.

```lean
-- MolecularDynamics.Chapter02Review.frozenNewton_statement
def frozenNewton_statement : Prop :=
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 ≤ ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖
```

差异及额外假设：补范数收缩条件；原文泛称many cases并非无条件。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:255`。

### CH02-132 · §2.4.5 · 定义 · 印刷p.88 / PDF110

原文（忠实转述）：Conjugacy is A=chi^-1 composed with B composed with chi.

```lean
-- MolecularDynamics.textbookConjugateMap
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```

差异及额外假设：chi为homeomorphism。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:23`。

### CH02-133 · §2.4.5 · 未编号结论 · 印刷p.88 / PDF110

原文（忠实转述）：Conjugate iterates satisfy A^n=chi^-1 B^n chi.

```lean
-- MolecularDynamics.textbook_conjugate_iterates
theorem textbook_conjugate_iterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n])
```

差异及额外假设：精确任意n恒等式。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:36`。

### CH02-134 · §2.4.5 · 未编号结论 · 印刷p.88 / PDF110

原文（忠实转述）：Conjugacy carries convergence of iterates to the corresponding transformed limit.

```lean
-- MolecularDynamics.textbook_conjugate_iterates_tendsto_iff
theorem textbook_conjugate_iterates_tendsto_iff (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (z₀ zStar : E) :
    Tendsto (fun n : ℕ => A^[n] z₀) atTop (𝓝 zStar) ↔
      Tendsto (fun n : ℕ => B^[n] (χ z₀)) atTop (𝓝 (χ zStar))
```

差异及额外假设：正确初值是chi(z0)；不冒充定量稳定性界。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:45`。

### CH02-135 · §2.4.5 · 未编号结论 · 印刷p.88 / PDF110

原文（忠实转述）：Symplectic Euler is conjugate to Verlet by a half kick.

```lean
-- MolecularDynamics.Chapter02Review.symplecticEulerConjugacy_statement
def symplecticEulerConjugacy_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h
```

差异及额外假设：正文声明保留，习题12的要求排除。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:260`。

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

### CH02-137 · §2.4.5 · 未编号结论 · 印刷p.88 / PDF110

原文（忠实转述）：Processed iterates equal the iterates of the conjugate higher-order map.

```lean
-- MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy
theorem textbookProcessedIterate_eq_of_conjugacy (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n
```

差异及额外假设：精确公式；不声称处理器存在。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:78`。

### CH02-138 · §2.4.5 · 未编号结论 · 印刷p.88 / PDF110

原文（忠实转述）：Processed maximum errors equal those of the conjugate method.

```lean
-- MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy
theorem textbookProcessedMaxError_eq_of_conjugacy (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (γ : ℝ → E) (ν : ℕ) :
    textbookProcessedMaxError χ B h γ ν = oneStepMaxError G h γ ν
```

差异及额外假设：同一初值、精确conjugacy。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ProcessedMethods.lean:99`。

### CH02-139 · §2.5.1 · 定义 · 印刷p.89 / PDF111

原文（忠实转述）：Runge-Kutta stages satisfy F_i=f(z+h sum a_ij F_j), and Z=z+h sum b_i F_i.

```lean
-- MolecularDynamics.Chapter02Review.rungeKuttaRelation
def rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
```

差异及额外假设：有限s阶段隐式关系。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:101`。

### CH02-140 · §2.5.1 · 定义 · 印刷p.89 / PDF111

原文（忠实转述）：Classical RK4 has the stated four stages and weights 1/6,1/3,1/3,1/6.

```lean
-- MolecularDynamics.Chapter02Review.rk4
def rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)
```

差异及额外假设：明确四阶段映射。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:104`。

### CH02-141 · §2.5.1 · 未编号结论 · 印刷p.89 / PDF111

原文（忠实转述）：Classical RK4 has global order four.

```lean
-- MolecularDynamics.Chapter02Review.rk4Order_statement
def rk4Order_statement : Prop :=
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ, compactTrajectory f γ τ → globalOrder (rk4 f) γ τ 4
```

差异及额外假设：光滑f、紧轨道、留域和稳定性；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:264`。

### CH02-142 · §2.5.1 · 未编号结论 · 印刷p.89 / PDF111

原文（忠实转述）：No consistent explicit RK method is universally symplectic.

```lean
-- MolecularDynamics.Chapter02Review.explicitRKNotSymplectic_proved
theorem explicitRKNotSymplectic_proved : explicitRKNotSymplectic_statement

-- MolecularDynamics.Chapter02Review.explicitRKNotSymplectic_statement
def explicitRKNotSymplectic_statement : Prop :=
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ¬ (∀ i j, b i*A i j+b j*A j i = b i*b j)

-- MolecularDynamics.Chapter02Review.explicitRKUniversal_statement
def explicitRKUniversal_statement : Prop :=
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ⊤ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G
```

差异及额外假设：补一致性sum b=1；不把零权重恒等法算反例；新增完整证明，经单文件构建；已证严格下三角A不能满足辛系数条件；原文普适不辛结论的必要性/实际RK反例仍仅Prop。

状态：**weakened**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:54;MolecularDynamics/Chapter02/Statements.lean:266;MolecularDynamics/Chapter02/Statements.lean:270`。

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

### CH02-144 · §2.5.1 · 定义 · 印刷p.90 / PDF112

原文（忠实转述）：Implicit midpoint is Z=z+h f((z+Z)/2).

```lean
-- MolecularDynamics.Chapter02Review.midpointRelation
def midpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop :=
  w = z + h • f ((1/2 : ℝ) • (z+w))
```

差异及额外假设：关系而非全局求解器。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:110`。

### CH02-145 · §2.5.1 · 未编号结论 · 印刷p.90 / PDF112

原文（忠实转述）：Gauss-Legendre RK schemes are symmetric and have even order.

```lean
-- MolecularDynamics.Chapter02Review.gaussRK_statement
def gaussRK_statement : Prop :=
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ methodLocalOrder G F (2*s)
```

差异及额外假设：s阶段实际Gauss配点构造；大型配点理论缺口；缺一般Gauss配点阶条件与对称性理论；给实际Legendre节点/积分系数及唯一阶段条件的完整Prop，未证。

状态：**not_formalizable_now**。位置：`MolecularDynamics/Chapter02/Statements.lean:292`。

### CH02-146 · §2.5.1 · 未编号结论 · 印刷p.90 / PDF112

原文（忠实转述）：Implicit midpoint is second order and symplectic.

```lean
-- MolecularDynamics.Chapter02Review.midpointProperties_statement
def midpointProperties_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    ContDiff ℝ 4 H → ContDiff ℝ 1 (Function.uncurry G) →
    (∀ h z, G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z))) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (textbookHamiltonianVectorField H (F t z)) t) →
    (∀ h, IsTextbookSymplecticMap (G h)) ∧ methodLocalOrder G F 2
```

差异及额外假设：光滑向量场，Hamiltonian C2，局部唯一可微解。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:303`。

### CH02-147 · §2.5.1 · 定义 · 印刷p.90 / PDF112

原文（忠实转述）：The two-stage Gauss method has b_i=1/2 and A entries 1/4 with off-diagonal shifts +/-sqrt(3)/6.

```lean
-- MolecularDynamics.Chapter02Review.gaussTwoCoefficients
def gaussTwoCoefficients : Matrix (Fin 2) (Fin 2) ℝ :=
  !![(1/4 : ℝ), 1/4-Real.sqrt 3/6; 1/4+Real.sqrt 3/6, 1/4]
```

差异及额外假设：实际系数矩阵。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:112`。

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

### CH02-149 · §2.5.2 · 未编号结论 · 印刷p.91 / PDF113

原文（忠实转述）：Generalized Verlet reduces to Verlet for separable mechanical H.

```lean
-- MolecularDynamics.Chapter02Review.partitionedReduction_statement
def partitionedReduction_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z w,
    positiveMass m → Differentiable ℝ U →
    ((∃ p, partitionedVerletRelation (fun z : Z n => (∑ i, z.2 i^2/m i)/2+U z.1) h z w p) ↔
      w = verlet m (fun q => -grad U q) h z)
```

差异及额外假设：固定正质量、U可微；实际关系等价。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:309`。

### CH02-150 · §2.5.2 · 定义 · 印刷p.91 / PDF113

原文（忠实转述）：General symplectic Euler is P=p-h H_q(q,P), Q=q+h H_p(q,P).

```lean
-- MolecularDynamics.Chapter02Review.generalSymplecticEulerRelation
def generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2
```

差异及额外假设：隐式映射存在另述。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:118`。

### CH02-151 · §2.5.2 · 未编号结论 · 印刷p.91 / PDF113

原文（忠实转述）：General implicit symplectic Euler and generalized Verlet are symplectic.

```lean
-- MolecularDynamics.Chapter02Review.generalSymplectic_statement
def generalSymplectic_statement : Prop :=
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n) h,
    ContDiff ℝ 2 H → ContDiff ℝ 1 G →
    (∀ z, generalSymplecticEulerRelation H h (unpack z) (unpack (G z))) → IsTextbookSymplecticMap G

-- MolecularDynamics.Chapter02Review.generalizedVerletSymplectic_statement
def generalizedVerletSymplectic_statement : Prop :=
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (p : SymplecticCoordinates n → Q n) h, ContDiff ℝ 2 H → ContDiff ℝ 1 G → ContDiff ℝ 1 p →
    (∀ z, partitionedVerletRelation H h (unpack z) (unpack (G z)) (p z)) → IsTextbookSymplecticMap G
```

差异及额外假设：C2 H、局部唯一可微解；混合Hessian与楔和抵消待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:314;MolecularDynamics/Chapter02/Statements.lean:318`。

### CH02-152 · §2.5.3 · 定义 · 印刷p.92 / PDF114

原文（忠实转述）：Newmark uses parameters gamma,beta and the two displayed position/momentum equations.

```lean
-- MolecularDynamics.Chapter02Review.newmarkRelation
def newmarkRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (γ β h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 + (h*(1-γ)) • F z.1 + (h*γ) • F w.1 ∧
  w.1 = z.1 + h • invMass m z.2 + (h^2*(1/2-β)) • F z.1 + (h^2*β) • F w.1
```

差异及额外假设：字面Q式缺M^-1；另给质量一致修正版。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:124`。

### CH02-153 · §2.5.3 · 未编号结论 · 印刷p.92 / PDF114

原文（忠实转述）：Newmark with gamma=1/2,beta=0 reduces to Verlet.

```lean
-- MolecularDynamics.Chapter02Review.newmarkReduction_proved
theorem newmarkReduction_proved : newmarkReduction_statement

-- MolecularDynamics.Chapter02Review.newmarkReduction_statement
def newmarkReduction_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkMassCorrected m F (1/2) 0 h z w ↔ w = verlet m F h z

-- MolecularDynamics.Chapter02Review.newmarkPrintedReduction_statement
def newmarkPrintedReduction_statement : Prop :=
  ∀ n (F : Q n → Q n) h z w, newmarkRelation (fun _ => (1 : ℝ)) F (1/2) 0 h z w ↔
    w = verlet (fun _ => 1) F h z
```

差异及额外假设：字面仅M=I；质量一致修正版适用于一般正质量；新增完整证明，经单文件构建。

状态：**proved**。位置：`MolecularDynamics/Chapter02/ReviewProofs.lean:33;MolecularDynamics/Chapter02/Statements.lean:322;MolecularDynamics/Chapter02/Statements.lean:325`。

### CH02-154 · §2.5.3 · 未编号结论 · 印刷p.92 / PDF114

原文（忠实转述）：Gamma=1/2 avoids artificial damping in the linear oscillator.

```lean
-- MolecularDynamics.Chapter02Review.newmarkNoDamping_statement
def newmarkNoDamping_statement : Prop :=
  ∀ (G : Q 2 → Q 2) Ω β h,
    ContDiff ℝ 1 G → (∀ z,
      G z 1 = z 1-h/2*Ω^2*(z 0+G z 0) ∧
      G z 0 = z 0+h*z 1-h^2*((1/2-β)*Ω^2*z 0+β*Ω^2*G z 0)) →
    1+h^2*β*Ω^2 ≠ 0 → ∀ z, (textbookCoordinateJacobian G z).det = 1
```

差异及额外假设：线性振子放大矩阵det=1，需非奇异解域。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:328`。

### CH02-155 · §2.5.3 · 未编号结论 · 印刷p.92 / PDF114

原文（忠实转述）：Implicit Newmark is generally not symplectic for nonlinear potentials.

```lean
-- MolecularDynamics.Chapter02Review.newmarkNotSymplectic_statement
def newmarkNotSymplectic_statement : Prop :=
  ∃ (U : Q 1 → ℝ) (β h : ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1),
    ContDiff ℝ 3 U ∧ β ≠ 0 ∧ h ≠ 0 ∧ ContDiff ℝ 1 G ∧
    (∀ z, newmarkMassCorrected (fun _ => 1) (textbookPotentialForce U) (1/2) β h
      (unpack z) (unpack (G z))) ∧ ¬ IsTextbookSymplecticMap G
```

差异及额外假设：具体非线性反例存在；避免错误全称排除线性特殊情况。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:334`。

### CH02-156 · §2.5.4 · 定义 · 印刷p.92 / PDF114

原文（忠实转述）：The multiderivative Taylor map uses terms h^j z^(j)/j!.

```lean
-- MolecularDynamics.Chapter02Review.multiTaylor
def multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j
```

差异及额外假设：时间导数数据；不宣称误差阶。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:131`。

### CH02-157 · §2.5.4 · 定义 · 印刷p.92 / PDF114

原文（忠实转述）：Takahashi-Imada uses Verlet with modified potential U-h^2 grad U^T M^-1 grad U/24.

```lean
-- MolecularDynamics.Chapter02Review.takahashiPotential
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i
```

差异及额外假设：h固定参数。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:134`。

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

### CH02-159 · §2.5.4 · 未编号结论 · 印刷p.93 / PDF115

原文（忠实转述）：Takahashi-Imada has effective order four after processing.

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

差异及额外假设：处理器存在、C足够阶、实际四阶全局误差；待证。

状态：**statement_only**。位置：`MolecularDynamics/Chapter02/Statements.lean:349`。

### CH02-160 · §2.5.5 · 定义 · 印刷p.93 / PDF115

原文（忠实转述）：Position-only Verlet is a multistep recurrence q_(n+1)-2q_n+q_(n-1)=h^2 M^-1 F(q_n).

```lean
-- MolecularDynamics.Chapter02Review.stormerRelation
def stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  c - (2 : ℝ) • b + a = h^2 • invMass m (F b)
```

差异及额外假设：与前文同一数学算法；排除实现成本。

状态：**defined**。位置：`MolecularDynamics/Chapter02/ReviewDefinitions.lean:54`。
