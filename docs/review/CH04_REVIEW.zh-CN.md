# 第4章人工审阅材料

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

### CH04-001 · §4 · 定义 · 印刷p.139 / PDF161

原文（忠实转述）：Linear test dynamics is z'=Az, (4.1).

```lean
-- MolecularDynamics.Chapter04Review.linearField
def linearField {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (z : Fin n → ℂ) := A *ᵥ z
```

差异、假设及缺口：有限维实/复线性系统；一般非对角化矩阵不能只看特征值。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:25`。

### CH04-002 · §4 · 定义 · 印刷p.139 / PDF161

原文（忠实转述）：Scalar Euler has amplification factor 1+h lambda.

```lean
-- MolecularDynamics.Chapter04Review.eulerFactor
def eulerFactor (h : ℝ) (rho : ℂ) : ℂ := 1 + (h : ℂ) * rho
```

差异、假设及缺口：复数测试方程。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:26`。

### CH04-003 · §4 · 未编号结论 · 印刷p.139 / PDF161

原文（忠实转述）：Scalar Euler iterates are bounded exactly when abs(1+h lambda)≤1, for nonzero initial data.

```lean
-- MolecularDynamics.Chapter04Review.scalarEulerStable_statement
def scalarEulerStable_statement : Prop := ∀ h rho, scalarStable (eulerFactor h rho) ↔ ‖eulerFactor h rho‖ ≤ 1
```

差异、假设及缺口：限标量；Jordan边界另需条件。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:11`。

### CH04-004 · §4 · 定义 · 印刷p.139 / PDF161

原文（忠实转述）：Euler's stability region is the disk centered at -1 with radius 1.

```lean
-- MolecularDynamics.Chapter04Review.eulerStabilityRegion
def eulerStabilityRegion : Set ℂ := {z | ‖1+z‖ ≤ 1}
```

差异、假设及缺口：以复数h lambda为自变量。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:27`。

### CH04-005 · §4 · 定义 · 印刷p.139 / PDF161

原文（忠实转述）：The harmonic oscillator matrix is [[0,1],[-Omega²,0]].

```lean
-- MolecularDynamics.Chapter04Review.oscillatorMatrix
def oscillatorMatrix (Ω : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![0,1; -Ω^2,0]
```

差异、假设及缺口：单位质量模型。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:31`。

### CH04-006 · §4 · 未编号结论 · 印刷p.140 / PDF162

原文（忠实转述）：The oscillator eigenvalues are ±i Omega; Euler grows for a nonzero oscillator frequency and nonzero step.

```lean
-- MolecularDynamics.Chapter04Review.eulerImaginaryGrowth_statement
def eulerImaginaryGrowth_statement : Prop :=
  ∀ h Ω : ℝ, h ≠ 0 → Ω ≠ 0 → ∀ z : ℂ, z ≠ 0 →
    Tendsto (fun k : ℕ => ‖(eulerFactor h (Complex.I*Ω))^k*z‖) atTop atTop
```

差异、假设及缺口：排除零频率、零步长和零初值。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:12`。

### CH04-007 · §4 · 定义 · 印刷p.140 / PDF162

原文（忠实转述）：Symplectic Euler oscillator matrix is [[1-h²Omega²,h],[-h Omega²,1]].

```lean
-- MolecularDynamics.Chapter04Review.symplecticEulerMatrix
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```

差异、假设及缺口：位置先用更新后的动量。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:32`。

### CH04-008 · §4 · 未编号结论 · 印刷p.140 / PDF162

原文（忠实转述）：The characteristic polynomial of symplectic Euler is lambda²-(2-h²Omega²)lambda+1.

```lean
-- MolecularDynamics.Chapter04Review.symplecticEulerCharacteristic_statement
def symplecticEulerCharacteristic_statement : Prop :=
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1
```

差异、假设及缺口：复特征值，有限行列式恒等式。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:15`。

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

### CH04-010 · §4 · 未编号结论 · 印刷p.140 / PDF162

原文（忠实转述）：The maximal harmonic stability threshold among explicit symplectic PRK methods is quoted as 2/Omega.

```lean
-- MolecularDynamics.Chapter04Review.prkThreshold_statement
def prkThreshold_statement : Prop :=
  ∀ s (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (G : ℝ → ℝ → Matrix (Fin 2) (Fin 2) ℝ), 0 < s →
    (∑ i,b i)=1 → (∑ i,c i)=1 →
    (∀ i j, b i*B i j+c j*A j i=b i*c j) →
    (∀ i j, i ≤ j → A i j=0) → (∀ i j, i < j → B i j=0) →
    (∀ Ω h z, ∃ q p, prkOscillatorRelation A B b c Ω h z (G Ω h *ᵥ z) q p) →
    (∀ Ω h, matrixStable (G Ω h) → |h*Ω| ≤ 2)
```

差异、假设及缺口：原文援引[74]；需限制阶段数/成本与方法类，保留书中文字面普适断言，未证明。

状态：**not_formalizable_now**；位置：`MolecularDynamics/Chapter04/Statements.lean:22`。

### CH04-011 · §4 · 未编号结论 · 印刷p.141 / PDF163

原文（忠实转述）：Verlet oscillator trajectories remain bounded for abs(h Omega)<2.

```lean
-- MolecularDynamics.Chapter04Review.verletStability_statement
def verletStability_statement : Prop :=
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → matrixStable (verletMatrix Ω h)
```

差异、假设及缺口：非零正频率；无声称非线性系统全局稳定。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:30`。

### CH04-012 · §4.1 · 定义 · 印刷p.142 / PDF164

原文（忠实转述）：The printed Implicit Midpoint formula averages f(z) and f(Z).

```lean
-- MolecularDynamics.Chapter04Review.printedImplicitRelation
def printedImplicitRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z znew : Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```

差异、假设及缺口：字面是trapezoidal；实际midpoint另附定义，原文误名待人工判断。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:38`。

### CH04-013 · §4.1 · 定义 · 印刷p.142 / PDF164

原文（忠实转述）：On imaginary linear dynamics the implicit amplification factor is (1+i h Omega/2)/(1-i h Omega/2).

```lean
-- MolecularDynamics.Chapter04Review.implicitFactor
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
```

差异、假设及缺口：线性情形midpoint/trapezoidal重合。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:42`。

### CH04-014 · §4.1 · 未编号结论 · 印刷p.142 / PDF164

原文（忠实转述）：The imaginary-axis implicit amplification factor has modulus one for every real h Omega.

```lean
-- MolecularDynamics.Chapter04Review.implicitModulus_statement
def implicitModulus_statement : Prop := ∀ Ω h : ℝ, ‖implicitFactor Ω h‖=1
```

差异、假设及缺口：仅线性振荡系统；不保证一般不稳定线性场稳定。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:32`。

### CH04-015 · §4.1 · 定义 · 印刷p.143 / PDF165

原文（忠实转述）：The numerical oscillator frequency is the continuous-branch phase divided by h.

```lean
-- MolecularDynamics.Chapter04Review.modifiedFrequency
def modifiedFrequency (Ω h : ℝ) : ℝ := 2*Real.arctan (h*Ω/2)/h
```

差异、假设及缺口：用2 atan(h Omega/2)/h消除复log分支歧义，h非零。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:44`。

### CH04-016 · §4.1 · 未编号结论 · 印刷p.143 / PDF165

原文（忠实转述）：The modified frequency tends to Omega as h tends to zero, but differs at large h Omega.

```lean
-- MolecularDynamics.Chapter04Review.modifiedFrequencyLimit_statement
def modifiedFrequencyLimit_statement : Prop :=
  ∀ Ω : ℝ, Tendsto (modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω)
```

差异、假设及缺口：极限是可核实数学内容；耦合共振的实践推测不计定理。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:33`。

### CH04-017 · §4.1 · 定义 · 印刷p.144 / PDF166

原文（忠实转述）：Mechanical midpoint is qhat=q+h M^-1 phat/2,phat=p-h grad U(qhat)/2, followed by the same half updates.

```lean
-- MolecularDynamics.Chapter04Review.mechanicalMidpointRelation
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (h : ℝ) (z mid out : Z n) : Prop :=
  mid.1=z.1+(h/2) • invMass m mid.2 ∧ mid.2=z.2-(h/2) • grad U mid.1 ∧
  out.1=mid.1+(h/2) • invMass m mid.2 ∧ out.2=mid.2-(h/2) • grad U mid.1
```

差异、假设及缺口：质量正；关系不代表隐式解存在/唯一。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:45`。

### CH04-018 · §4.1 · 未编号结论 · 印刷p.144 / PDF166

原文（忠实转述）：Eliminating phat gives qhat=q+h M^-1p/2-h² M^-1 grad U(qhat)/4.

```lean
-- MolecularDynamics.Chapter04Review.midpointElimination_statement
def midpointElimination_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h (z mid out : Z n),
    mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • invMass m z.2-(h^2/4) • invMass m (grad U mid.1)
```

差异、假设及缺口：只陈述有限代数等价，不建立求解理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:35`。

### CH04-019 · §4.2.1 · 定义 · 印刷p.145 / PDF167

原文（忠实转述）：The slow/fast Hamiltonian is kinetic+US+UF.

```lean
-- MolecularDynamics.Chapter04Review.splitHamiltonian
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : Q n → ℝ) (z : Z n) : ℝ :=
  dot z.2 (invMass m z.2)/2+US z.1+UF z.1
```

差异、假设及缺口：固定正质量。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:49`。

### CH04-020 · §4.2.1 · 定义 · 印刷p.145 / PDF167

原文（忠实转述）：Fast inner steps use kick-drift-kick Verlet for UF.

```lean
-- MolecularDynamics.Chapter04Review.fastVerlet
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  Chapter02Review.verlet m (fun q => -grad UF q) h
```

差异、假设及缺口：复用第2章Verlet数学映射。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:52`。

### CH04-021 · §4.2.1 · 定义 · 印刷p.145 / PDF167

原文（忠实转述）：Reversible RESPA is slow half-kick, r fast Verlet steps of size h/r, slow half-kick, (4.2).

```lean
-- MolecularDynamics.Chapter04Review.respa
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : Q n → ℝ) (r : ℕ) (h : ℝ) (z : Z n) : Z n :=
  kick US (h/2) ((fastVerlet m UF (h/r))^[r] (kick US (h/2) z))
```

差异、假设及缺口：r>0；使用实际有限迭代，不将形式exp当实际流。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:54`。

### CH04-022 · §4.2.1 · 未编号结论 · 印刷p.145 / PDF167

原文（忠实转述）：RESPA is symplectic and reversible when its component maps are well-defined smooth Hamiltonian kicks and drifts.

```lean
-- MolecularDynamics.Chapter04Review.respaStructure_statement
def respaStructure_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (US UF : Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    symplecticMap (respa m US UF r h) ∧ ∀ z, respa m US UF r (-h) (respa m US UF r h z)=z
```

差异、假设及缺口：新增仅陈述；辛性需实际导数，未重复证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:39`。

### CH04-023 · §4.2.1 · 定义 · 印刷p.146 / PDF168

原文（忠实转述）：The resonance model uses slow kick S_h and exact fast rotation F_h.

```lean
-- MolecularDynamics.Chapter04Review.slowMatrix
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]

-- MolecularDynamics.Chapter04Review.fastMatrix
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]

-- MolecularDynamics.Chapter04Review.impulseMatrix
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```

差异、假设及缺口：Omega>0；矩阵乘积顺序S(h/2) F(h) S(h/2)。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:56;MolecularDynamics/Chapter04/ReviewDefinitions.lean:57;MolecularDynamics/Chapter04/ReviewDefinitions.lean:59`。

### CH04-024 · §4.2.1 · 未编号结论 · 印刷p.146 / PDF168

原文（忠实转述）：S_h and F_h have determinant one, hence W_h does too.

```lean
-- MolecularDynamics.Chapter04Review.impulseDet_statement
def impulseDet_statement : Prop := ∀ Ω h : ℝ, Ω ≠ 0 →
  (slowMatrix h).det=1 ∧ (fastMatrix Ω h).det=1 ∧ (impulseMatrix Ω h).det=1
```

差异、假设及缺口：有限实矩阵。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:43`。

### CH04-025 · §4.2.1 · 未编号结论 · 印刷p.146 / PDF168

原文（忠实转述）：The trace of W_h is 2 cos(h Omega)-(h/Omega) sin(h Omega).

```lean
-- MolecularDynamics.Chapter04Review.impulseTrace_statement
def impulseTrace_statement : Prop := ∀ Ω h : ℝ, Ω ≠ 0 →
  (impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω)
```

差异、假设及缺口：补非零Omega。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:45`。

### CH04-026 · §4.2.1 · 未编号结论 · 印刷p.146 / PDF168

原文（忠实转述）：At h=pi/Omega, W_h^n=(-1)^n [[1,0],[-n h,1]].

```lean
-- MolecularDynamics.Chapter04Review.resonancePower_statement
def resonancePower_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1]
```

差异、假设及缺口：所有自然数n，Omega>0。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:47`。

### CH04-027 · §4.2.1 · 未编号结论 · 印刷p.147 / PDF169

原文（忠实转述）：Resonance at h=pi/Omega causes linear growth for initial q≠0.

```lean
-- MolecularDynamics.Chapter04Review.resonanceGrowth_statement
def resonanceGrowth_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop
```

差异、假设及缺口：不是所有初值都增长。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:49`。

### CH04-028 · §4.2.1 · 未编号结论 · 印刷p.147 / PDF169

原文（忠实转述）：The trace has linear expansion -2+(pi/Omega)(h-pi/Omega)+O((h-pi/Omega)²).

```lean
-- MolecularDynamics.Chapter04Review.resonanceTaylor_statement
def resonanceTaylor_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2
```

差异、假设及缺口：原图核对；保留Taylor余项量化。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:51`。

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

### CH04-030 · §4.2.2 · 定义 · 印刷p.149 / PDF171

原文（忠实转述）：MOLLY replaces US(q) by US(A(q)); A is a weighted average of fast positions from zero momentum.

```lean
-- MolecularDynamics.Chapter04Review.mollifiedAverage
def mollifiedAverage {n : ℕ} (m : Fin n → ℝ) (UF : Q n → ℝ)
    (K : ℕ) (w : ℕ → ℝ) (δ : ℝ) (q : Q n) : Q n :=
  (1/(K+1 : ℝ)) • ∑ i ∈ Finset.range (K+1), w i • ((fastVerlet m UF δ)^[i] (q,0)).1

-- MolecularDynamics.Chapter04Review.mollifiedPotential
def mollifiedPotential {n : ℕ} (US : Q n → ℝ) (A : Q n → Q n) := US ∘ A
```

差异、假设及缺口：实际有限fastVerlet迭代；不声称权重任意时物理有效。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:60;MolecularDynamics/Chapter04/ReviewDefinitions.lean:63`。

### CH04-031 · §4.2.2 · 未编号结论 · 印刷p.149 / PDF171

原文（忠实转述）：A smooth mollified potential has conservative forces and its RESPA composition is symplectic.

```lean
-- MolecularDynamics.Chapter04Review.mollifiedStructure_statement
def mollifiedStructure_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (US UF : Q n → ℝ) (A : Q n → Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    symplecticMap (respa m (mollifiedPotential US A) UF r h)
```

差异、假设及缺口：真实链式导数；不证明实践的步长增益。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:60`。

### CH04-032 · §4.3 · 定义 · 印刷p.150 / PDF172

原文（忠实转述）：A holonomic constraint is g(q,t)=0, (4.3).

```lean
-- MolecularDynamics.Chapter04Review.holonomicRelation
def holonomicRelation {n l : ℕ} (g : Q n → ℝ → Q l) (q : ℝ → Q n) : Prop :=
  ∀ t, g (q t) t=0
```

差异、假设及缺口：允许显式时间依赖，后续自主g单列。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:64`。

### CH04-033 · §4.3 · 未编号结论 · 印刷p.150 / PDF172

原文（忠实转述）：Differentiating g(q(t),t)=0 gives Dq g q'+partial_t g=0.

```lean
-- MolecularDynamics.Chapter04Review.timeConstraintDerivative_statement
def timeConstraintDerivative_statement : Prop :=
  ∀ n l (g : Q n → ℝ → Q l) (q : ℝ → Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0
```

差异、假设及缺口：补可微实际曲线，局部恒为零。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:65`。

### CH04-034 · §4.3 · 定义 · 印刷p.152 / PDF174

原文（忠实转述）：The constrained system is q'=M^-1p,p'=F-G^T lambda,g(q)=0, (4.4)-(4.9).

```lean
-- MolecularDynamics.Chapter04Review.constrainedSolution
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (q p : ℝ → Q n) (rho : ℝ → Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ constraintSet g
```

差异、假设及缺口：F=-grad U；不把约束力存在视为证明。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:69`。

### CH04-035 · §4.3 · 定义 · 印刷p.152 / PDF174

原文（忠实转述）：The constraint manifold and cotangent phase set satisfy g(q)=0 and G(q)M^-1p=0.

```lean
-- MolecularDynamics.Chapter04Review.constraintSet
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}

-- MolecularDynamics.Chapter04Review.cotangentSet
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) : Set (Z n) :=
  {z | z.1 ∈ constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ invMass m z.2=0}
```

差异、假设及缺口：正质量/独立梯度是光滑流形解释所需条件。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:66;MolecularDynamics/Chapter04/ReviewDefinitions.lean:67`。

### CH04-036 · §4.3 · 定义 · 印刷p.152 / PDF174

原文（忠实转述）：G(q) is the actual Jacobian of the component constraints.

```lean
-- MolecularDynamics.textbookConstraintJacobian
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```

差异、假设及缺口：真实Fréchet偏导矩阵。

状态：**defined**；位置：`MolecularDynamics/Chapter04/CotangentProjection.lean:19`。

### CH04-037 · §4.3 · 未编号结论 · 印刷p.152 / PDF174

原文（忠实转述）：The Jacobian multiplication equals the actual directional derivative of each constraint.

```lean
-- MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative
theorem textbookConstraintJacobian_eq_actualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap
```

差异、假设及缺口：复用既有证明，需可微。

状态：**proved**；位置：`MolecularDynamics/Chapter04/CotangentProjection.lean:36`。

### CH04-038 · §4.3 · 定义 · 印刷p.153 / PDF175

原文（忠实转述）：The curvature is D²g_k(q)[M^-1p,M^-1p].

```lean
-- MolecularDynamics.textbookConstraintCurvature
noncomputable def textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
```

差异、假设及缺口：真实二阶导数。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ConstrainedReaction.lean:20`。

### CH04-039 · §4.3 · 定义 · 印刷p.153 / PDF175

原文（忠实转述）：The reaction multiplier solves the Gram system with right side G M^-1F+curvature.

```lean
-- MolecularDynamics.textbookConstrainedReactionMultiplier
noncomputable def textbookConstrainedReactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```

差异、假设及缺口：逆Gram；非奇异另需验证。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ConstrainedReaction.lean:26`。

### CH04-040 · §4.3 · 未编号结论 · 印刷p.153 / PDF175

原文（忠实转述）：The constructed multiplier satisfies G M^-1(F-G^T lambda)+curvature=0, (4.10).

```lean
-- MolecularDynamics.textbookConstrainedReaction_balance
theorem textbookConstrainedReaction_balance {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (F q - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookConstrainedReactionMultiplier m γ F q p)) +
        textbookConstraintCurvature m γ q p = 0
```

差异、假设及缺口：Gram行列式非零；复用既有证明。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedReaction.lean:33`。

### CH04-041 · §4.3 · 未编号结论 · 印刷p.153 / PDF175

原文（忠实转述）：Positive masses and linearly independent constraint gradients make the Gram matrix positive definite and invertible.

```lean
-- MolecularDynamics.textbookConstraintGram_posDef
theorem textbookConstraintGram_posDef {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef

-- MolecularDynamics.textbookConstraintGram_det_ne_zero
theorem textbookConstraintGram_det_ne_zero {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).det ≠ 0
```

差异、假设及缺口：复用既有证明。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedGram.lean:39;MolecularDynamics/Chapter04/ConstrainedGram.lean:55`。

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

### CH04-043 · §4.3 · 未编号结论 · 印刷p.153 / PDF175

原文（忠实转述）：Smooth constraints and independent gradients give a smooth reduced constrained vector field.

```lean
-- MolecularDynamics.contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence
theorem contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (z : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) z.1)) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z
```

差异、假设及缺口：相应C3约束/C1力；局部正则性复用。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedReactionRegularity.lean:118`。

### CH04-044 · §4.3.1 · 定义 · 印刷p.153 / PDF175

原文（忠实转述）：The symplectic form is the ambient canonical two-form pulled back to constraint charts.

```lean
-- MolecularDynamics.Chapter04Review.restrictedForm
def restrictedForm {n : ℕ} (chart : Z n → Z n) (z u v : Z n) : ℝ :=
  phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)
```

差异、假设及缺口：坐标拉回，未构造抽象余切丛。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:74`。

### CH04-045 · §4.3.1 · 未编号结论 · 印刷p.154 / PDF176

原文（忠实转述）：Differentials of the constrained vector field obey the displayed variational formulas (4.11)-(4.13).

```lean
-- MolecularDynamics.Chapter04Review.variational_statement
def variational_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (rho : Z n → Q l) (z v : Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    (fderiv ℝ (fun x : Z n =>
      (invMass m x.2,-grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (invMass m v.2,-(fderiv ℝ (grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • grad (g j) z.1+
          rho z j • (fderiv ℝ (grad (g j)) z.1) v.1))
```

差异、假设及缺口：实际fderiv；现有场正则性仅依赖，完整变分方程另陈述。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:69`。

### CH04-046 · §4.3.1 · 未编号结论 · 印刷p.155 / PDF177

原文（忠实转述）：Symmetric Hessian terms and tangent constraint terms cancel in the derivative of the pulled-back two-form.

```lean
-- MolecularDynamics.textbookConstrainedAcceleration_pullback_zero
theorem textbookConstrainedAcceleration_pullback_zero {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (ρ : Fin Mc → E → ℝ) (q : E → Fin Nc → ℝ) (x u v : E)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hq : DifferentiableAt ℝ q x) (hρ : ∀ j, DifferentiableAt ℝ (ρ j) x)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) :
    ∑ i : Fin Nc,
      ((fderiv ℝ q x) u i * (fderiv ℝ
        (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) v i -
        (fderiv ℝ (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) u i * (fderiv ℝ q x) v i) = 0
```

差异、假设及缺口：真实Hessian与切向条件；复用既有证明。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedFlowSymplectic.lean:50`。

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

### CH04-048 · §4.3.2 · 定义 · 印刷p.156 / PDF178

原文（忠实转述）：Position-projected symplectic Euler is (4.14)-(4.16).

```lean
-- MolecularDynamics.Chapter04Review.positionEulerRelation
def positionEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (rho : Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m out.2 ∧ out.1 ∈ constraintSet g
```

差异、假设及缺口：Fn印刷负号与F=-grad U约定不一致；附统一力符号。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:83`。

### CH04-049 · §4.3.2 · 未编号结论 · 印刷p.156 / PDF178

原文（忠实转述）：The hidden constraint error of position-projected Euler is O(h).

```lean
-- MolecularDynamics.Chapter04Review.hiddenEulerError_statement
def hiddenEulerError_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (z : Z n) (out : ℝ → Z n) (rho : ℝ → Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 out → out 0=z →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, positionEulerRelation m (fun q => -grad U q) g h z (out h) (rho h)) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      ‖textbookConstraintJacobian g (out h).1 *ᵥ invMass m (out h).2‖ ≤ C*h
```

差异、假设及缺口：光滑局部分支/小乘子条件；不会误记完全保持隐藏约束。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:78`。

### CH04-050 · §4.3.2 · 定义 · 印刷p.156 / PDF178

原文（忠实转述）：The projection equation is g(Qn-M^-1 Gn^T eta)=0 with eta=h²lambda, (4.17).

```lean
-- MolecularDynamics.Chapter04Review.projectionResidual
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))

-- MolecularDynamics.Chapter04Review.projectionJacobian
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```

差异、假设及缺口：给定Qn/Gn；真实Jacobian交叉Gram。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:87;MolecularDynamics/Chapter04/ReviewDefinitions.lean:90`。

### CH04-051 · §4.3.2 · 定义 · 印刷p.157 / PDF179

原文（忠实转述）：Newton solves R(eta) Delta eta=g(Q(eta)), then adds Delta eta, (4.18)-(4.19).

```lean
-- MolecularDynamics.Chapter04Review.newtonConstraint
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base η)⁻¹ *ᵥ projectionResidual m g q base η

-- MolecularDynamics.Chapter04Review.frozenNewtonConstraint
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base 0)⁻¹ *ᵥ projectionResidual m g q base η
```

差异、假设及缺口：逆矩阵的适用需非奇异；冻结矩阵版也登记。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:94;MolecularDynamics/Chapter04/ReviewDefinitions.lean:97`。

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

### CH04-053 · §4.3.2 · 未编号结论 · 印刷p.157 / PDF179

原文（忠实转述）：With a frozen nonsingular matrix and a contraction derivative, the modified Newton iteration converges linearly.

```lean
-- MolecularDynamics.Chapter04Review.frozenNewtonLinear_statement
def frozenNewtonLinear_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (q base : Q n) (root : Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → projectionResidual m g q base root=0 →
    (projectionJacobian m g q base 0).det ≠ 0 →
    ‖fderiv ℝ (frozenNewtonConstraint m g q base) root‖ < 1 →
    ∃ C ∈ Ioo (0 : ℝ) 1, ∃ δ > 0, ∀ η : Q l, ‖η-root‖ < δ →
      ‖frozenNewtonConstraint m g q base η-root‖ ≤ C*‖η-root‖
```

差异、假设及缺口：书中小步条件量化为真实导数范数<1；不无条件断言。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:90`。

### CH04-054 · §4.3.2 · 未编号结论 · 印刷p.158 / PDF180

原文（忠实转述）：The position projection multiplier eta is O(h²) for consistent constrained initial data.

```lean
-- MolecularDynamics.Chapter04Review.projectionScale_statement
def projectionScale_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (F : Q n → Q n) (g : Fin l → Q n → ℝ)
    (z : Z n) (η : ℝ → Q l), z ∈ cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      projectionResidual m g z.1 (z.1+h • invMass m z.2+h^2 • invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2
```

差异、假设及缺口：局部光滑选根且eta(0)=0；不构造隐式分支存在。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:97`。

### CH04-055 · §4.3.3 · 定义 · 印刷p.158 / PDF180

原文（忠实转述）：The component-wise solver updates one constraint using its scalar linearized denominator and sweeps all constraints.

```lean
-- MolecularDynamics.Chapter04Review.componentConstraintStep
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q Qnow : Q n) (j : Fin l) : Q n :=
  Qnow-(g j Qnow / dot (grad (g j) Qnow) (invMass m (grad (g j) q))) •
    invMass m (grad (g j) q)

-- MolecularDynamics.Chapter04Review.componentSweep
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q Qnow : Q n) : Q n :=
  (List.finRange l).foldl (fun Qcur j => componentConstraintStep m g q Qcur j) Qnow
```

差异、假设及缺口：印刷G1_j索引误写，采用Gj_n；分母非零才是可用步骤。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:100;MolecularDynamics/Chapter04/ReviewDefinitions.lean:104`。

### CH04-056 · §4.3.4 · 定义 · 印刷p.159 / PDF181

原文（忠实转述）：Projected constrained Euler adds P=pbar-G(Q)^T mu and enforces G(Q)M^-1P=0, (4.20)-(4.24).

```lean
-- MolecularDynamics.Chapter04Review.projectedEulerRelation
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (pbar : Q n) (rho μ : Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m pbar ∧ out.1 ∈ constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ cotangentSet m g
```

差异、假设及缺口：完整关系；lambda/mu由原约束指定，未给存在理论。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:107`。

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

### CH04-058 · §4.3.4 · 未编号结论 · 印刷p.160 / PDF182

原文（忠实转述）：The lemma extends to a sum of constraint-gradient momentum corrections.

```lean
-- MolecularDynamics.textbookMultiConstrainedMomentum_preserves_pullback
theorem textbookMultiConstrainedMomentum_preserves_pullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q : E → Fin Nc → ℝ) (x : E) (hq : DifferentiableAt ℝ q x)
    (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hconstraint : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (p : E → Fin Nc → ℝ) (hp : DifferentiableAt ℝ p x) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v)
```

差异、假设及缺口：有限约束族、真实可微乘子；复用既有证明。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedProjection.lean:202`。

### CH04-059 · §4.3.4 · 未编号结论 · 印刷p.160 / PDF182

原文（忠实转述）：The drift and projected constrained Euler chart preserve the pullback two-form.

```lean
-- MolecularDynamics.textbookProjectedEulerChart_preserves_pullback
theorem textbookProjectedEulerChart_preserves_pullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x)
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hold : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q (textbookProjectedEulerPreMomentum s γ lam U h a q p) y) = 0)
    (u v : E) :
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v)
```

差异、假设及缺口：给定可微分支及位置约束；不是求解存在证明。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedIntegrator.lean:89`。

### CH04-060 · §4.3.4 · 定义 · 印刷p.160 / PDF182

原文（忠实转述）：The cotangent correction is obtained from the true inverse Gram matrix.

```lean
-- MolecularDynamics.textbookCotangentMultiplier
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))

-- MolecularDynamics.textbookCotangentProjection
noncomputable def textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```

差异、假设及缺口：原公式质量一致。

状态：**defined**；位置：`MolecularDynamics/Chapter04/CotangentProjection.lean:57;MolecularDynamics/Chapter04/CotangentProjection.lean:62`。

### CH04-061 · §4.3.4 · 未编号结论 · 印刷p.160 / PDF182

原文（忠实转述）：The true Gram cotangent projection enforces the hidden constraint.

```lean
-- MolecularDynamics.textbookCotangentProjection_hiddenConstraint_of_mass_and_independence
theorem textbookCotangentProjection_hiddenConstraint_of_mass_and_independence {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0
```

差异、假设及缺口：正质量、梯度独立；已验收。

状态：**proved**；位置：`MolecularDynamics/Chapter04/ConstrainedGram.lean:62`。

### CH04-062 · §4.3.4 · 未编号结论 · 印刷p.160 / PDF182

原文（忠实转述）：The cotangent projection is differentiable and preserves the restricted two-form.

```lean
-- MolecularDynamics.contDiffAt_textbookCotangentProjection
theorem contDiffAt_textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentProjection m γ (q y) (p y)) x

-- MolecularDynamics.textbookCotangentProjection_preserves_pullback
theorem textbookCotangentProjection_preserves_pullback {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x u)
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v)
```

差异、假设及缺口：真实正则性与Gram非奇异；已验收。

状态：**proved**；位置：`MolecularDynamics/Chapter04/CotangentProjectionRegularity.lean:102;MolecularDynamics/Chapter04/CotangentProjectionRegularity.lean:118`。

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

### CH04-064 · §4.3.5 · 定义 · 印刷p.161 / PDF183

原文（忠实转述）：The printed position-only SHAKE scheme is (4.25)-(4.26).

```lean
-- MolecularDynamics.Chapter04Review.shakePositionPrinted
def shakePositionPrinted {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (a b c : Q n) (rho : Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • invMass m (F b)-h^2 • ((textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ constraintSet g

-- MolecularDynamics.Chapter04Review.shakePositionRelation
def shakePositionRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (a b c : Q n) (rho : Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ constraintSet g
```

差异、假设及缺口：印刷约束反力缺M^-1；同时给质量一致版本，关系不计证明。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:112;MolecularDynamics/Chapter04/ReviewDefinitions.lean:116`。

### CH04-065 · §4.3.5 · 定义 · 印刷p.161 / PDF183

原文（忠实转述）：The phase-space SHAKE scheme uses the same force-plus-constraint half kicks, (4.27)-(4.29).

```lean
-- MolecularDynamics.Chapter04Review.shakeRelation
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho rhonew : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
```

差异、假设及缺口：不保证隐藏约束；未求解分支。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:120`。

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

### CH04-067 · §4.3.5 · 未编号结论 · 印刷p.161 / PDF183

原文（忠实转述）：Projected Euler is first order; SHAKE/RATTLE are second order for regular smooth constrained branches.

```lean
-- MolecularDynamics.Chapter04Review.constrainedOrders_statement
def constrainedOrders_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (z : Z n) (Φ E R : ℝ → Z n) (pE pR : ℝ → Q n) (rhoE μE rhoR μR : ℝ → Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      projectedEulerRelation m (fun q => -grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      rattleRelation m (fun q => -grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3

-- MolecularDynamics.Chapter04Review.shakePositionOrder_statement
def shakePositionOrder_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (q p : ℝ → Q n) (rho : ℝ → Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    constrainedSolution m (fun x => -grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → Q n) (rhon : ℕ → Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → shakePositionRelation m (fun x => -grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2
```

差异、假设及缺口：统一实际ODE局部误差；阶结论非作为输入；不建立分支存在。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:115;MolecularDynamics/Chapter04/Statements.lean:158`。

### CH04-068 · §4.3.5 · 未编号结论 · 印刷p.162 / PDF184

原文（忠实转述）：RATTLE is symplectic on the cotangent set.

```lean
-- MolecularDynamics.Chapter04Review.rattleSymplectic_statement
def rattleSymplectic_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    h (G : Z n → Z n) (half : Z n → Q n) (rho μ : Z n → Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 U → Differentiable ℝ G →
    Differentiable ℝ half → Differentiable ℝ rho → Differentiable ℝ μ →
    (∀ z ∈ cotangentSet m g, rattleRelation m (fun q => -grad U q) g h z (G z) (half z) (rho z) (μ z)) →
    restrictedSymplectic m g G
```

差异、假设及缺口：已有Lemma4.1/Gram依赖映射；完整算法陈述未证。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:108`。

### CH04-069 · §4.3.5 · 定义 · 印刷p.162 / PDF184

原文（忠实转述）：The common staggered scheme is (4.35)-(4.37).

```lean
-- MolecularDynamics.Chapter04Review.staggeredConstraintRelation
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : Q n) (rho : Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • invMass m newHalf ∧ qnew ∈ constraintSet g
```

差异、假设及缺口：F力约定显式。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:131`。

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

### CH04-071 · §4.3.5.1 · 定义 · 印刷p.163 / PDF185

原文（忠实转述）：The constrained adjoint Euler method swaps force and constraint corrections as displayed.

```lean
-- MolecularDynamics.Chapter04Review.adjointEulerRelation
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ cotangentSet m g
```

差异、假设及缺口：mu/h缩放可吸收入独立乘子；h非零。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:135`。

### CH04-072 · §4.3.5.1 · 未编号结论 · 印刷p.163 / PDF185

原文（忠实转述）：Half-step Euler followed by its adjoint is a second-order symplectic constrained method.

```lean
-- MolecularDynamics.Chapter04Review.constrainedComposition_statement
def constrainedComposition_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (E A : ℝ → Z n → Z n) (pE pA : ℝ → Z n → Q n) (rhoE μE rhoA μA : ℝ → Z n → Q l),
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ h, Differentiable ℝ (E h) ∧ Differentiable ℝ (A h) ∧
      Differentiable ℝ (pE h) ∧ Differentiable ℝ (pA h) ∧ Differentiable ℝ (rhoE h) ∧
      Differentiable ℝ (μE h) ∧ Differentiable ℝ (rhoA h) ∧ Differentiable ℝ (μA h)) →
    (∀ h z, z ∈ cotangentSet m g →
      projectedEulerRelation m (fun q => -grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      adjointEulerRelation m (fun q => -grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h, restrictedSymplectic m g (A (h/2) ∘ E (h/2))

-- MolecularDynamics.Chapter04Review.constrainedCompositionOrder_statement
def constrainedCompositionOrder_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (E A : ℝ → Z n → Z n) (pE pA : ℝ → Z n → Q n) (rhoE muE rhoA muA : ℝ → Z n → Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h z, z ∈ cotangentSet m g →
      projectedEulerRelation m (fun q => -grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      adjointEulerRelation m (fun q => -grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3
```

差异、假设及缺口：完整阶/辛陈述依赖实际光滑分支；未证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:171;MolecularDynamics/Chapter04/Statements.lean:182`。

### CH04-073 · §4.3.5.1 · 定义 · 印刷p.163 / PDF185

原文（忠实转述）：The mass-weighted momentum projector is I-G^T(GM^-1G^T)^-1 GM^-1.

```lean
-- MolecularDynamics.Chapter04Review.momentumProjector
def momentumProjector {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (q : Q n) :=
  (1 : Matrix (Fin n) (Fin n) ℝ)-(textbookConstraintJacobian g q)ᵀ *
    (textbookConstraintGram m g q)⁻¹ * textbookConstraintJacobian g q * textbookInverseMassMatrix m
```

差异、假设及缺口：注意投影作用于动量协向量。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:141`。

### CH04-074 · §4.3.5.1 · 未编号结论 · 印刷p.163 / PDF185

原文（忠实转述）：The constrained potential flow is Q=q,P=p-h Pi(q) grad U(q).

```lean
-- MolecularDynamics.Chapter04Review.constrainedPotentialFlow_statement
def constrainedPotentialFlow_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ) (z : Z n),
    z ∈ cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    (∀ j, Differentiable ℝ (g j)) → ∀ t : ℝ,
    let P := fun s : ℝ => z.2-s • (momentumProjector m g z.1 *ᵥ grad U z.1)
    (z.1,P t) ∈ cotangentSet m g ∧ HasDerivAt P (-momentumProjector m g z.1 *ᵥ grad U z.1) t
```

差异、假设及缺口：仅给定正则固定q；真实约束ODE，不用流结论作假设。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:195`。

### CH04-075 · §4.3.5.1 · 定义 · 印刷p.164 / PDF186

原文（忠实转述）：The constrained kinetic flow is the mass-weighted geodesic system q'=M^-1p,p'=-G^Tlambda,g(q)=0.

```lean
-- MolecularDynamics.Chapter04Review.geodesicRelation
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q p : ℝ → Q n) (rho : ℝ → Q l) (I : Set ℝ) : Prop :=
  constrainedSolution m (fun _ => 0) g q p rho I
```

差异、假设及缺口：不搭建流形测地流存在理论。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:144`。

### CH04-076 · §4.3.6 · 定义 · 印刷p.164 / PDF186

原文（忠实转述）：M-SHAKE implements SHAKE using the Newton solver; the traditional solver is component-wise.

```lean
-- MolecularDynamics.Chapter04Review.mShakeIteration
def mShakeIteration {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (k : ℕ) := (newtonConstraint m g q base)^[k] 0
```

差异、假设及缺口：只登记数学迭代；计算成本/实现建议非数学定理。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:147`。

### CH04-077 · §4.3.6 · 定义 · 印刷p.165 / PDF187

原文（忠实转述）：SETTLE uses an exact small-system constraint solve; LINCS approximates an inverse by a series.

```lean
-- MolecularDynamics.Chapter04Review.settleRelation
def settleRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Prop := projectionResidual m g q base η=0

-- MolecularDynamics.Chapter04Review.lincsInverse
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```

差异、假设及缺口：SETTLE为exact关系，正文没有详细closed form，不额外发明；LINCS有限级数。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:149;MolecularDynamics/Chapter04/ReviewDefinitions.lean:151`。

### CH04-078 · §4.3.6 · 未编号结论 · 印刷p.165 / PDF187

原文（忠实转述）：The LINCS Neumann series converges to the inverse when the coupling matrix is contractive.

```lean
-- MolecularDynamics.Chapter04Review.lincsConvergence_statement
def lincsConvergence_statement : Prop := ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (lincsInverse C) atTop (𝓝 ((1-C)⁻¹))
```

差异、假设及缺口：范数<1；缺一般算法误差/并行成本理论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:201`。

### CH04-079 · §4.4 · 定义 · 印刷p.167 / PDF189

原文（忠实转述）：The center of mass is sum mi qi divided by total mass and weighted relative positions sum to zero.

```lean
-- MolecularDynamics.Chapter04Review.totalMass
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i

-- MolecularDynamics.Chapter04Review.centerMass
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → V) : V :=
  (totalMass m)⁻¹ • ∑ i, m i • q i

-- MolecularDynamics.Chapter04Review.relativePositions
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → V) : Fin N → V :=
  fun i => q i-centerMass m q
```

差异、假设及缺口：排除TIP4P介绍模型和数值实例。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:152;MolecularDynamics/Chapter04/ReviewDefinitions.lean:153;MolecularDynamics/Chapter04/ReviewDefinitions.lean:155`。

### CH04-080 · §4.4 · 未编号结论 · 印刷p.167 / PDF189

原文（忠实转述）：Kinetic energy splits into translational and relative rotational terms when weighted relative velocities sum to zero.

```lean
-- MolecularDynamics.Chapter04Review.kineticSplit_statement
def kineticSplit_statement : Prop := ∀ N (m : Fin N → ℝ) (v : V) (w : Fin N → V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*dot (v+w i) (v+w i))/2=totalMass m*dot v v/2+(∑ i,m i*dot (w i) (w i))/2
```

差异、假设及缺口：质量正、真实有限和；只陈述。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:203`。

### CH04-081 · §4.4 · 定义 · 印刷p.168 / PDF190

原文（忠实转述）：The fixed second moment matrix R is sum mi delta_i delta_i^T and Krot=trace(dotTheta R dotTheta^T)/2.

```lean
-- MolecularDynamics.Chapter04Review.secondMoment
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 := ∑ i, m i • outer (δ i)

-- MolecularDynamics.Chapter04Review.rotationKinetic
def rotationKinetic (R dΘ : Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```

差异、假设及缺口：参照体坐标；不含例4.1独立交付。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:158;MolecularDynamics/Chapter04/ReviewDefinitions.lean:159`。

### CH04-082 · §4.4 · 未编号结论 · 印刷p.168 / PDF190

原文（忠实转述）：For an orthogonal rotation trajectory, dotTheta Theta^T is skew-symmetric.

```lean
-- MolecularDynamics.Chapter04Review.rotationSkew_statement
def rotationSkew_statement : Prop := ∀ (Θ : ℝ → Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ)
```

差异、假设及缺口：真实HasDerivAt与局部正交。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:206`。

### CH04-083 · §4.4 · 定义 · 印刷p.169 / PDF191

原文（忠实转述）：skew(omega) is the displayed 3x3 cross-product matrix, (4.38).

```lean
-- MolecularDynamics.Chapter04Review.skewMatrix
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]

-- MolecularDynamics.Chapter04Review.cross3
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

差异、假设及缺口：坐标展开，固定右手符号。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:160;MolecularDynamics/Chapter04/ReviewDefinitions.lean:161`。

### CH04-084 · §4.4 · 未编号结论 · 印刷p.169 / PDF191

原文（忠实转述）：skew(omega)delta=omega cross delta, and rigid relative velocities have this form, (4.39).

```lean
-- MolecularDynamics.Chapter04Review.crossMatrix_statement
def crossMatrix_statement : Prop := ∀ u v : V, skewMatrix u *ᵥ v=cross3 u v
```

差异、假设及缺口：有限坐标恒等式与实际运动学分开。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:208`。

### CH04-085 · §4.4 · 定义 · 印刷p.169 / PDF191

原文（忠实转述）：The inertia tensor is sum mi (abs(delta_i)² I-delta_i delta_i^T).

```lean
-- MolecularDynamics.Chapter04Review.inertiaTensor
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 :=
  ∑ i, m i • (dot (δ i) (δ i) • (1 : Mat3)-outer (δ i))

-- MolecularDynamics.Chapter04Review.rotationalEnergy
def rotationalEnergy (T : Mat3) (ω : V) : ℝ := dot ω (T *ᵥ ω)/2
```

差异、假设及缺口：body angular velocity/动能定义；平方范数用Euclidean有限和。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:162;MolecularDynamics/Chapter04/ReviewDefinitions.lean:164`。

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

### CH04-087 · §4.4 · 定义 · 印刷p.170 / PDF192

原文（忠实转述）：The rigid body matrix Hamiltonian is p_cm²/(2M)+trace(Pi R^-1 Pi^T)/2+U(q_cm,Theta).

```lean
-- MolecularDynamics.Chapter04Review.rigidHamiltonian
def rigidHamiltonian (M : ℝ) (R : Mat3) (U : V → Mat3 → ℝ) (q p : V) (Θ mom : Mat3) : ℝ :=
  dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
```

差异、假设及缺口：R逆存在另需非奇异，正交约束单列。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:165`。

### CH04-088 · §4.4 · 定义 · 印刷p.171 / PDF193

原文（忠实转述）：The rigid matrix ODE has q'=p/M,Theta'=Pi R^-1,p'=-grad_q U,Pi'=-grad_Theta U-Theta Lambda,Theta^TTheta=I.

```lean
-- MolecularDynamics.Chapter04Review.rigidMatrixRelation
def rigidMatrixRelation (M : ℝ) (R : Mat3) (U : V → Mat3 → ℝ)
    (q p : ℝ → V) (Θ mom Λ : ℝ → Mat3) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1
```

差异、假设及缺口：矩阵梯度以实际fderiv构造；未搭解存在/辛理论。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:169`。

### CH04-089 · §4.4.1 · 定义 · 印刷p.171 / PDF193

原文（忠实转述）：Spatial angular momentum is sum mi delta_i cross delta_i', and body momentum is Theta^T l.

```lean
-- MolecularDynamics.Chapter04Review.angularMomentum
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → V) : V :=
  ∑ i, m i • cross3 (δ i) (v i)

-- MolecularDynamics.Chapter04Review.bodyMomentum
def bodyMomentum (Θ : Mat3) (l : V) : V := Θᵀ *ᵥ l
```

差异、假设及缺口：实际有限坐标函数。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:174;MolecularDynamics/Chapter04/ReviewDefinitions.lean:176`。

### CH04-090 · §4.4.1 · 未编号结论 · 印刷p.171 / PDF193

原文（忠实转述）：Body angular momentum equals inertia times body angular velocity.

```lean
-- MolecularDynamics.Chapter04Review.angularInertia_statement
def angularInertia_statement : Prop := ∀ N (m : Fin N → ℝ) (δ : Fin N → V) (Θ : Mat3) (ω : V),
  Θᵀ*Θ=1 → Θ.det=1 → bodyMomentum Θ
    (angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => cross3 ω (Θ *ᵥ δ i))) =
      inertiaTensor m δ *ᵥ (Θᵀ *ᵥ ω)
```

差异、假设及缺口：在SO(3)旋转下；正文三重积符号需导师复核。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:213`。

### CH04-091 · §4.4.1 · 定义 · 印刷p.172 / PDF194

原文（忠实转述）：Free-body Euler equations are pi'=pi cross (T^-1 pi), (4.41).

```lean
-- MolecularDynamics.Chapter04Review.eulerRigidField
def eulerRigidField (T : Mat3) (π : V) : V := cross3 π (T⁻¹ *ᵥ π)

-- MolecularDynamics.Chapter04Review.freeRigidSolution
def freeRigidSolution (T : Mat3) (π : ℝ → V) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (eulerRigidField T (π t)) I t
```

差异、假设及缺口：正惯性矩阵；不把解存在计为定义。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:177;MolecularDynamics/Chapter04/ReviewDefinitions.lean:178`。

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

### CH04-093 · §4.4.1 · 定义 · 印刷p.172 / PDF194

原文（忠实转述）：The noncanonical structure is J(pi)=skew(pi), with J(pi)pi=0.

```lean
-- MolecularDynamics.Chapter04Review.rigidPoissonMatrix
def rigidPoissonMatrix (π : V) : Mat3 := skewMatrix π
```

差异、假设及缺口：J退化；是否Poisson/Jacobi另待理论。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:180`。

### CH04-094 · §4.4.1 · 定义 · 印刷p.173 / PDF195

原文（忠实转述）：Split free-body dynamics rotates successively about principal inertia axes.

```lean
-- MolecularDynamics.Chapter04Review.axisRotation
def axisRotation (i : Fin 3) (φ : ℝ) : Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]

-- MolecularDynamics.Chapter04Review.spinAxis
def spinAxis (I : V) (i : Fin 3) (h : ℝ) (s : V × Mat3) : V × Mat3 :=
  let R := axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)

-- MolecularDynamics.Chapter04Review.spinStep
def spinStep (I : V) (h : ℝ) : V × Mat3 → V × Mat3 :=
  spinAxis I 0 (h/2) ∘ spinAxis I 1 (h/2) ∘ spinAxis I 2 h ∘
    spinAxis I 1 (h/2) ∘ spinAxis I 0 (h/2)
```

差异、假设及缺口：显示第二分量误写pi，采用pi_2；正I1/I2/I3。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:181;MolecularDynamics/Chapter04/ReviewDefinitions.lean:185;MolecularDynamics/Chapter04/ReviewDefinitions.lean:188`。

### CH04-095 · §4.4.1 · 未编号结论 · 印刷p.173 / PDF195

原文（忠实转述）：Each principal-axis subsystem is solved exactly by its planar rotation, and the composition is a Poisson integrator.

```lean
-- MolecularDynamics.Chapter04Review.axisFlow_statement
def axisFlow_statement : Prop := ∀ (I π : V) i, 0 < I i → ∀ t : ℝ,
  HasDerivAt (fun s : ℝ => (spinAxis I i s (π,1)).1)
    (cross3 ((spinAxis I i t (π,1)).1) (Pi.single i (((spinAxis I i t (π,1)).1 i)/I i))) t

-- MolecularDynamics.Chapter04Review.spinPoisson_statement
def spinPoisson_statement : Prop := ∀ I : V, (∀ i, 0 < I i) → ∀ h : ℝ,
  poissonMap (fun π => (spinStep I h (π,1)).1)
```

差异、假设及缺口：真实解公式与非canonical Poisson映射分开；不搭完整刚体辛理论；原DLM旋转正角与Euler pi cross omega的符号不一致，字面算法结论未证明。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:221;MolecularDynamics/Chapter04/Statements.lean:227`。

### CH04-096 · §4.4.2 · 定义 · 印刷p.173 / PDF195

原文（忠实转述）：The force is -partial_q U and torque is -rot(Theta^T partial_Theta U).

```lean
-- MolecularDynamics.Chapter04Review.rigidForce
def rigidForce (U : V → Mat3 → ℝ) (q : V) (Θ : Mat3) := -grad (fun x => U x Θ) q

-- MolecularDynamics.Chapter04Review.matrixRot
def matrixRot (A : Mat3) : V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]

-- MolecularDynamics.Chapter04Review.rigidTorque
def rigidTorque (U : V → Mat3 → ℝ) (q : V) (Θ : Mat3) := -matrixRot (Θᵀ*matrixGrad (U q) Θ)
```

差异、假设及缺口：实际Fréchet偏导，原rot(A)=skew^-1(A-A^T)，不额外除以2。

状态：**defined**；位置：`MolecularDynamics/Chapter04/ReviewDefinitions.lean:191;MolecularDynamics/Chapter04/ReviewDefinitions.lean:192;MolecularDynamics/Chapter04/ReviewDefinitions.lean:193`。

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

### CH04-098 · §4.4.2 · 未编号结论 · 印刷p.174 / PDF196

原文（忠实转述）：Drift and spin commute, revealing the symmetric kick-drift-spin-drift-kick composition.

```lean
-- MolecularDynamics.Chapter04Review.driftSpinCommute_statement
def driftSpinCommute_statement : Prop := ∀ M h (I : V) (z : RBState),
  rigidDrift M h (rigidSpin I h z)=rigidSpin I h (rigidDrift M h z)
```

差异、假设及缺口：真实分量更新，正质量与惯量。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:229`。

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

### CH04-100 · §4.3 · 未编号结论 · 印刷p.151 / PDF173

原文（忠实转述）：For l independent regular holonomic constraints, the true number of degrees of freedom is Nc-l.

```lean
-- MolecularDynamics.Chapter04Review.constraintDegrees_statement
def constraintDegrees_statement : Prop :=
  ∀ n l (g : Q n → Q l) (q : Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n
```

差异、假设及缺口：页脚数学结论；真实导数满射与kernel维数，秩/零化度等式仅陈述；不把自由度值假设为结论。

状态：**statement_only**；位置：`MolecularDynamics/Chapter04/Statements.lean:7`。
