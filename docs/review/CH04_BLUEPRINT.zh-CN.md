# 第4章 Lean Blueprint 本地审阅材料

覆盖印刷p.139–174正文，习题除外。原文JSON审校状态见各条；本地模板C预审独立于网站审计。已整合网站返回0条，其余待网站审计；未冻结。编译和公理检查验证当前Lean陈述/证明，原文忠实性由独立审校核验。

| source_id | 页码 印刷/PDF | 本地预审 | 网站审计 | 状态 |
|---|---|---|---|---|
| MD-4-LinearField | 139/161 | PASS | 待网站审计 | self-contained |
| MD-4-EulerFactor | 139/161 | PASS | 待网站审计 | self-contained |
| MD-4-ScalarEulerStable | 139/161 | PASS | 待网站审计 | self-contained |
| MD-4-EulerRegion | 139/161 | PASS | 待网站审计 | self-contained |
| MD-4-OscillatorMatrix | 139/161 | PASS | 待网站审计 | self-contained |
| MD-4-EulerImaginaryGrowth | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4-SymplecticEulerMatrix | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4-SymplecticEulerCharacteristic | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4-PRKThreshold | 140/162 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-4-VerletStability | 141/163 | PASS | 待网站审计 | self-contained |
| MD-4-SymplecticEulerBoundaryPrinted | 140/162 | FAIL | 待网站审计 | incomplete |
| MD-4-VerletBoundaryPrinted | 141/163 | FAIL | 待网站审计 | incomplete |
| MD-4-OscillatorSpectrum | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4-SymplecticEulerRoots | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4-SymplecticEulerUnitRoots | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4-SymplecticEulerStability | 140/162 | PASS | 待网站审计 | self-contained |
| MD-4.1-PrintedImplicitRelation | 142/164 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-4.1-ActualMidpointRelation | 142/164 | PASS | 待网站审计 | self-contained |
| MD-4.1-ImplicitFactor | 142/164 | PASS | 待网站审计 | self-contained |
| MD-4.1-ImplicitModulus | 142/164 | PASS | 待网站审计 | self-contained |
| MD-4.1-PrintedModifiedFrequency | 143/165 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-4.1-ModifiedFrequencyLimit | 143/165 | PASS | 待网站审计 | self-contained |
| MD-4.1-MechanicalMidpoint | 144/166 | PASS | 待网站审计 | self-contained |
| MD-4.1-MidpointElimination | 144/166 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-SplitHamiltonian | 145/167 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-FastVerlet | 145/167 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-RESPA | 145/167 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-RESPAStructure | 145/167 | PASS | 待网站审计 | incomplete |
| MD-4.2.1-SlowMatrix | 146/168 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-FastMatrix | 146/168 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ImpulseMatrix | 146/168 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ImpulseDet | 146/168 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ImpulseTrace | 146/168 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ResonancePower | 146/168 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ResonanceTaylor | 147/169 | PASS | 待网站审计 | incomplete |
| MD-4.2.1-ResonanceInstability | 147/169 | PASS | 待网站审计 | incomplete |
| MD-4.2.1-ResonanceEigenPrinted | 147/169 | NEEDS_HUMAN | 待网站审计 | incomplete |
| MD-4.2.2-MollifiedAverage | 149/171 | PASS | 待网站审计 | self-contained |
| MD-4.2.2-MollifiedPotential | 149/171 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ResonanceLinearRate | 147/169 | PASS | 待网站审计 | self-contained |
| MD-4.2.1-ResonanceGrowth | 147/169 | PASS | 待网站审计 | self-contained |
| MD-4.2.2-MollifiedStructure | 149/171 | PASS | 待网站审计 | incomplete |

## 需要导师判断的问题

- MD-4-PRKThreshold：字面普适最大阈值2/Ω保留完整方法参数、阶一一致、显式分区与实际阶段关系；引用文献可能有阶段数/成本/方法类限制，不能凭泛称证明。
  原文[74]的方法类限制需要审，未访问引用文献。
- MD-4-VerletStability：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。
  Verlet的hΩ=2矩阵也有Jordan增长，不能以谱模1推出所有轨道有界。
- MD-4-SymplecticEulerBoundaryPrinted：Ω=1,h=2时A=[[-3,2],[-2,1]]=−I+N,N²=0,N≠0；A^k=(−1)^k(I−kN)，对合适非零初值线性增长。
  原≤2声明的端点反例；不证明FAIL。
- MD-4-VerletBoundaryPrinted：Ω=1,h=2时A=[[-1,2],[0,−1]]=−I+N,N²=0；初值(0,1)位置分量模2k，无界。
  原≤2端点不保证幂有界，单列原文不静默替换。
- MD-4-SymplecticEulerStability：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。
  ≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。
- MD-4.1-PrintedImplicitRelation：字面是梯形法。非线性实际中点f((z+Z)/2)另列，不静默改原公式；线性测试时二者相同。
  p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。
- MD-4.1-PrintedModifiedFrequency：印刷复log表达式原样保留，不用实atan定义替换原式。
  原书未指定复log分支；与连续实相位的桥接须审校。
- MD-4.2.1-ResonanceEigenPrinted：det=1、trace=−2+ε的二次根近−1±sqrt(|ε|)+O(ε)，印刷sqrt(|ε|/2)系数疑误；保留字面实根误差界，未更正成PASS。
  根展开首项疑少sqrt(2)因子；待网站/导师裁定。

## 1. MD-4-LinearField · (4.1) · 印刷p.139 / PDFp.161

### 2. 原文陈述

> Let us recall the method of studying the asymptotic numerical stability of a linear system
> \[\dot z=Az,\tag{4.1}\]
> where $z\in\mathbb R^m,A\in\mathbb R^{m\times m}$, when solved by a numerical method.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def linearField {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (z : Fin n → ℂ) := A *ᵥ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.linearField；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 复线性扩张用于随后的标量测试；原实矩阵实例嵌入ℂ。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:24](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:24>)（`MD.Ch04.linearField`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`2343e4ad3baf7e83982a97d63f3327af98af2aa7f07bdd5e721b45a7871a9b0f`；原文SHA256：`f908bd18ab6037f7036cac6de30801d3d61e5568a3c04dae15e140e28da73dea`。

## 1. MD-4-EulerFactor · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> Here $\lambda\in\mathbb C$, hence $u$ may in general be complex. Then one applies the numerical method directly to the scalar equation. For example Euler’s method yields
> \[u_{n+1}=(1+h\lambda)u_n.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def eulerFactor (h : ℝ) (rho : ℂ) : ℂ := 1 + (h : ℂ) * rho
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.eulerFactor；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:27](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:27>)（`MD.Ch04.eulerFactor`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`945ea42f3215592b72949d649a29895ead3dffa8d8f1eb1579fc65b319b273b2`；原文SHA256：`11e2745f8c70332de61e0fdf64c9292381589afe9ffc26b9c357b6942eddfd59`。

## 1. MD-4-ScalarEulerStable · unnumbered_claim · 印刷p.139 / PDFp.161

### 2. 原文陈述

> The iteration is stable if $|u_n|$ remains bounded as $n\to\infty$, implying the following condition for asymptotic stability:
> \[|1+h\lambda|\le1.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem scalarEulerStable :
  ∀ h rho, MolecularDynamics.Chapter04Review.scalarStable (MolecularDynamics.Chapter04Review.eulerFactor h rho) ↔ ‖MolecularDynamics.Chapter04Review.eulerFactor h rho‖ ≤ 1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.scalarEulerStable；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | scalarStable明确定义为因子各次幂一致有界；非零初值下等价于迭代有界，零初值例外。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:31](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:31>)（`MD.Ch04.scalarEulerStable`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ScalarEulerStable.json；blueprint/ch04/validation/short_search/ScalarEulerStable-route1.lean；blueprint/ch04/validation/short_search/ScalarEulerStable-route1.log；blueprint/ch04/validation/short_search/ScalarEulerStable-route2.lean；blueprint/ch04/validation/short_search/ScalarEulerStable-route2.log。

签名SHA256：`3f315af0062260da82758cfdc7c024e5b986f9d1a510a173c73a5378b4088fcc`；原文SHA256：`0aae779b1991fe59174b426a7055dcc7b47c4573b73e3b92814b7566a43249b3`。

## 1. MD-4-EulerRegion · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> This defines the “stability region” for Euler’s method as a disk in the complex $h\lambda$-plane centered around $-1$ of radius $1$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def eulerStabilityRegion : Set ℂ := {z | ‖1+z‖ ≤ 1}
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.eulerStabilityRegion；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:49](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:49>)（`MD.Ch04.eulerStabilityRegion`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`231d8f78a1e7f91da8d98646854f9a833fc9c40786178980d7bab42383ddc2fd`；原文SHA256：`1c821672c9684c1578f11daef87a53327c83737967e8c099357c2d8245da2c21`。

## 1. MD-4-OscillatorMatrix · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> If we consider applying this technique to the harmonic oscillator $\dot q=p;\dot p=-\Omega^2q$, then the matrix $A$ is
> \[A=\begin{bmatrix}0&I\\-\Omega^2&0\end{bmatrix}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def oscillatorMatrix (Ω : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![0,1; -Ω^2,0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.oscillatorMatrix；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 一个自由度，I=1；按标量频率实例解释。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:53](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:53>)（`MD.Ch04.oscillatorMatrix`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`563f0b30632a7fc6ce0df63f1cd289f4d29deb503b43f0ab60cdad3278c0ab9e`；原文SHA256：`ffc06999b3fbcc7d2e15d48e8e392a5ef38fc8e533ed2d993d126f7e4743e367`。

## 1. MD-4-EulerImaginaryGrowth · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues are $\pm i\omega$. The stability condition always fails to hold and, for Euler’s method, $z_n$ grows exponentially rapidly away from the equilibrium point.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem eulerImaginaryGrowth :
  ∀ h Ω : ℝ, h ≠ 0 → Ω ≠ 0 → ∀ z : ℂ, z ≠ 0 →
    Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖) atTop atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.eulerImaginaryGrowth；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:57](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:57>)（`MD.Ch04.eulerImaginaryGrowth`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/EulerImaginaryGrowth.json；blueprint/ch04/validation/short_search/EulerImaginaryGrowth-route1.lean；blueprint/ch04/validation/short_search/EulerImaginaryGrowth-route1.log；blueprint/ch04/validation/short_search/EulerImaginaryGrowth-route2.lean；blueprint/ch04/validation/short_search/EulerImaginaryGrowth-route2.log。

签名SHA256：`0f44362c601016203b92649b03b9a536c6f4476717ebb3c005e1da23eea658b1`；原文SHA256：`3fe388fd6891230a1c76da096e2bdf8c4d1acd8f60c28ae29ff6609574ae5090`。

## 1. MD-4-SymplecticEulerMatrix · definition · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The timestep map is defined by
> \[Q=q+hP,\qquad P=p-h\Omega^2q.\]
> Solving for $Q,P$ this yields
> \[\begin{bmatrix}Q\\P\end{bmatrix}=\begin{bmatrix}1-h^2\Omega^2&h\\-h\Omega^2&1\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.symplecticEulerMatrix；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:71](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:71>)（`MD.Ch04.symplecticEulerMatrix`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`bbda75ade1595aa85e225b144694e2c996f0fca307394537ff36da64e954171a`；原文SHA256：`58d34391774161609d1e0886e2a82753be851150076fd19b5edd2982551f1db7`。

## 1. MD-4-SymplecticEulerCharacteristic · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues of the matrix are easily found, they are
> \[\lambda_{1,2}=1-\frac{h^2\Omega^2}{2}\pm\frac12\sqrt{h^4\Omega^4-4h^2\Omega^2}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem symplecticEulerCharacteristic :
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.symplecticEulerCharacteristic；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:76](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:76>)（`MD.Ch04.symplecticEulerCharacteristic`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/SymplecticEulerCharacteristic.json；blueprint/ch04/validation/short_search/SymplecticEulerCharacteristic-route1.lean；blueprint/ch04/validation/short_search/SymplecticEulerCharacteristic-route1.log。

签名SHA256：`0bcc48984b3161487b089e49dd1c361bddd0791e16cde047e64421b6f10d7725`；原文SHA256：`e1d12391c39120e0595bb71c7531e3c9bb16dedf63ac6e629add455a5913f233`。

## 1. MD-4-PRKThreshold · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> Among explicit symplectic Partitioned Runge-Kutta methods this is the maximum stability threshold [74].

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem prkThreshold :
  ∀ s (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (G : ℝ → ℝ → Matrix (Fin 2) (Fin 2) ℝ), 0 < s →
    (∑ i,b i)=1 → (∑ i,c i)=1 →
    (∀ i j, b i*B i j+c j*A j i=b i*c j) →
    (∀ i j, i ≤ j → A i j=0) → (∀ i j, i < j → B i j=0) →
    (∀ Ω h z, ∃ q p, MolecularDynamics.Chapter04Review.prkOscillatorRelation A B b c Ω h z (G Ω h *ᵥ z) q p) →
    (∀ Ω h, MolecularDynamics.Chapter04Review.matrixStable (G Ω h) → |h*Ω| ≤ 2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.prkThreshold；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原页核对/疑点 | 原文[74]的方法类限制需要审，未访问引用文献。 | NEEDS_HUMAN |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。字面普适最大阈值2/Ω保留完整方法参数、阶一一致、显式分区与实际阶段关系；引用文献可能有阶段数/成本/方法类限制，不能凭泛称证明。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:86](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:86>)（`MD.Ch04.prkThreshold`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：缺明确方法类与阈值定理，不建立PRK稳定性最优理论。

签名SHA256：`c76c585d4e16eea65b7d8a110c4a2ce879f2b1b201d2c1186d83c94c5267bb3d`；原文SHA256：`373540377cfece70053172709112a6e52abce5bdd4748019ebf757854b6bd64a`。

## 1. MD-4-VerletStability · unnumbered_claim · 印刷p.141 / PDFp.163

### 2. 原文陈述

> For example, applying the Verlet method to the harmonic oscillator with frequency $\Omega$ we find that the origin is stable (and the numerical solution stays bounded for all time) provided $h\Omega\le2$ (the same condition as for stability of Symplectic Euler).

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem verletStability :
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.verletStability；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]真正幂有界版本0<\|hΩ\|<2；原文≤2字面版另列待审。 | [EXTRA] |
| 原页核对/疑点 | Verlet的hΩ=2矩阵也有Jordan增长，不能以谱模1推出所有轨道有界。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:99](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:99>)（`MD.Ch04.verletStability`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/VerletStability.json；blueprint/ch04/validation/short_search/VerletStability-route1.lean；blueprint/ch04/validation/short_search/VerletStability-route1.log；blueprint/ch04/validation/short_search/VerletStability-route2.lean；blueprint/ch04/validation/short_search/VerletStability-route2.log。

签名SHA256：`605e049af1358c1cae40697e582fb799623d7c0fb8e8cee9740481027cd3ba27`；原文SHA256：`7dd01a97d85bb21b46c6d5e2a721854c1cc0ee7270d57d0765dcabe78761bba3`。

## 1. MD-4-SymplecticEulerBoundaryPrinted · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> if $h\Omega\le2$ the integrator is stable.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem symplecticEulerBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.symplecticEulerBoundaryPrinted；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原页核对/疑点 | 原≤2声明的端点反例；不证明FAIL。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**FAIL**。Ω=1,h=2时A=[[-3,2],[-2,1]]=−I+N,N²=0,N≠0；A^k=(−1)^k(I−kN)，对合适非零初值线性增长。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:159](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:159>)（`MD.Ch04.symplecticEulerBoundaryPrinted`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：本地FAIL，等待网站/导师裁定端点。

签名SHA256：`d603617b43094c5a8d6ba8162b153041cf61ac69658d6c827001b6a2bf730605`；原文SHA256：`3c4c0973d1352ad94e3de00cd5870d8c2b2854151cf49868b62be74471998cc4`。

## 1. MD-4-VerletBoundaryPrinted · unnumbered_claim · 印刷p.141 / PDFp.163

### 2. 原文陈述

> the numerical solution stays bounded for all time) provided $h\Omega\le2$

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem verletBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.verletBoundaryPrinted；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原页核对/疑点 | 原≤2端点不保证幂有界，单列原文不静默替换。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**FAIL**。Ω=1,h=2时A=[[-1,2],[0,−1]]=−I+N,N²=0；初值(0,1)位置分量模2k，无界。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:165](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:165>)（`MD.Ch04.verletBoundaryPrinted`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：本地FAIL，等待网站/导师裁定。

签名SHA256：`dc35fa75a8696c46d4d3a045674e7aada7550306e61a5c38ebe827f2f94b2537`；原文SHA256：`b260b245c6ee4d9f78129b9e623782b546137449396f106d95ea8b1dd1f95d3c`。

## 1. MD-4-OscillatorSpectrum · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues are $\pm i\omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem oscillatorSpectrum :
    ∀ Ω : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.oscillatorMatrix Ω).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ζ=Complex.I*Ω ∨ ζ= -Complex.I*Ω
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.oscillatorSpectrum；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:170](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:170>)（`MD.Ch04.oscillatorSpectrum`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/OscillatorSpectrum.json；blueprint/ch04/validation/short_search/OscillatorSpectrum-route1.lean；blueprint/ch04/validation/short_search/OscillatorSpectrum-route1.log；blueprint/ch04/validation/short_search/OscillatorSpectrum-route2.lean；blueprint/ch04/validation/short_search/OscillatorSpectrum-route2.log。

签名SHA256：`17b2d4e2e7e56c7cd63d9e29fc454f25d02677e62509016806e04730f563c9ca`；原文SHA256：`a14108add0905fc8317b3f25276bdd6d8d8d6cf7db0416baae8d4bf2e9d4099f`。

## 1. MD-4-SymplecticEulerRoots · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues of the matrix are easily found, they are
> \[\lambda_{1,2}=1-\frac{h^2\Omega^2}{2}\pm\frac12\sqrt{h^4\Omega^4-4h^2\Omega^2}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem symplecticEulerRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ∃ d : ℂ, d^2=(h^4*Ω^4-4*h^2*Ω^2 : ℝ) ∧
        (ζ=1-(h^2*Ω^2 : ℝ)/2+d/2 ∨ ζ=1-(h^2*Ω^2 : ℝ)/2-d/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.symplecticEulerRoots；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:197](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:197>)（`MD.Ch04.symplecticEulerRoots`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/SymplecticEulerRoots.json；blueprint/ch04/validation/short_search/SymplecticEulerRoots-route1.lean；blueprint/ch04/validation/short_search/SymplecticEulerRoots-route1.log；blueprint/ch04/validation/short_search/SymplecticEulerRoots-route2.lean；blueprint/ch04/validation/short_search/SymplecticEulerRoots-route2.log。

签名SHA256：`bd906d72fcb5499e8d5e4d3bab404ee1bcabccbafd8515848c2e5d20cc544165`；原文SHA256：`6ae9249b71237b3be4e3633a3f1038522c7a6cc2bc5ed4ebaeef630ff56abd74`。

## 1. MD-4-SymplecticEulerUnitRoots · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> Then we observe that for $h^2\Omega^2\le4$, they are complex and their squared magnitude is
> \[|\lambda_{1,2}|^2=\left(1-\frac{h^2\Omega^2}{2}\right)^2+\frac14(4h^2\Omega^2-h^4\Omega^4)=1,\]
> thus both eigenvalues lie on the unit circle in the complex plane as long as $h\Omega\le2$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem symplecticEulerUnitRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ, h^2*Ω^2 ≤ 4 →
      ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1=0 → ‖ζ‖=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.symplecticEulerUnitRoots；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:227](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:227>)（`MD.Ch04.symplecticEulerUnitRoots`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/SymplecticEulerUnitRoots.json；blueprint/ch04/validation/short_search/SymplecticEulerUnitRoots-route1.lean；blueprint/ch04/validation/short_search/SymplecticEulerUnitRoots-route1.log；blueprint/ch04/validation/short_search/SymplecticEulerUnitRoots-route2.lean；blueprint/ch04/validation/short_search/SymplecticEulerUnitRoots-route2.log。

签名SHA256：`68aaecc991b3ea896935e9813a1be6d8be3b4b0a7218c1b69af5b1582d17cb10`；原文SHA256：`538eecb17dcfdfd45d1c7f27e719dc3b08b8b644de90b4222bdb8602a35e9cd0`。

## 1. MD-4-SymplecticEulerStability · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> This is the so-called linear stability condition of the Symplectic Euler method: if $h\Omega\le2$ the integrator is stable. When $h\Omega>2$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $2/\Omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem symplecticEulerStability :
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.symplecticEulerStability；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]正确的幂有界资格改为0<\|hΩ\|<2；原≤2字面版独立保留，未声称已审核修复。 | [EXTRA] |
| 原页核对/疑点 | ≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:255](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:255>)（`MD.Ch04.symplecticEulerStability`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试3次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/SymplecticEulerStability.json；blueprint/ch04/validation/short_search/SymplecticEulerStability-route1.lean；blueprint/ch04/validation/short_search/SymplecticEulerStability-route1.log；blueprint/ch04/validation/short_search/SymplecticEulerStability-route2.lean；blueprint/ch04/validation/short_search/SymplecticEulerStability-route2.log；blueprint/ch04/validation/short_search/SymplecticEulerStability-route3.lean；blueprint/ch04/validation/short_search/SymplecticEulerStability-route3.log。

签名SHA256：`31da4d14a4c75f5466f7d85db446a21959c4160c4d5ee6fdbdb6daf16433e5db`；原文SHA256：`5337d81ef03916ce02696f1c9144e1d1d1ebfb3bcf6ecefab190810118b9327f`。

## 1. MD-4.1-PrintedImplicitRelation · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> The Implicit Midpoint method, for the ODE $\dot z=f(z)$ takes the form
> \[z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.printedImplicitRelation；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原页核对/疑点 | p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。字面是梯形法。非线性实际中点f((z+Z)/2)另列，不静默改原公式；线性测试时二者相同。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:331](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:331>)（`MD.Ch04.printedImplicitRelation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`2d344c2d61f978a2d7d6bb20cf676fbf5af38e168191f3e4900a9d985ab82a95`；原文SHA256：`c6439bbfed99daee74b45848db6334ea99552445528c3096d990255f026f56b7`。

## 1. MD-4.1-ActualMidpointRelation · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> The Implicit Midpoint method, for the ODE $\dot z=f(z)$

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def actualMidpointRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.actualMidpointRelation；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:336](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:336>)（`MD.Ch04.actualMidpointRelation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`2adca08e7fa90663cfd925710d52fd3cafe69a6c4ff921bf675c7d69939839b4`；原文SHA256：`c99fa7adbb8ae88429088509e6b0567ebf4f3f9f12a7102e2374b088a9eee64b`。

## 1. MD-4.1-ImplicitFactor · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> can be applied to $\dot z=i\Omega z$ and yields
> \[z_{n+1}=\frac{1+ih\Omega/2}{1-ih\Omega/2}z_n.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.implicitFactor；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:340](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:340>)（`MD.Ch04.implicitFactor`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`d9d832e64c8fd7e95b1ef56e4db0959bb2032e82cdb926cac765b30b10075255`；原文SHA256：`6a31f54a97f5c56bc9a7669f42faea3a9f68fc3cb5fa2af287accd9565db811c`。

## 1. MD-4.1-ImplicitModulus · unnumbered_claim · 印刷p.142 / PDFp.164

### 2. 原文陈述

> For all real $\Omega$, we find
> \[\left|\frac{1+ih\Omega/2}{1-ih\Omega/2}\right|=1.\]
> This indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.implicitModulus；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:345](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:345>)（`MD.Ch04.implicitModulus`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试3次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ImplicitModulus.json；blueprint/ch04/validation/short_search/ImplicitModulus-route1.lean；blueprint/ch04/validation/short_search/ImplicitModulus-route1.log；blueprint/ch04/validation/short_search/ImplicitModulus-route2.lean；blueprint/ch04/validation/short_search/ImplicitModulus-route2.log；blueprint/ch04/validation/short_search/ImplicitModulus-route3.lean；blueprint/ch04/validation/short_search/ImplicitModulus-route3.log。

签名SHA256：`8b259dc410b5741b24216689b139a9e51f809a825dd9da04f9d418aece887aa8`；原文SHA256：`89f6ab88c37e62809e2a01032750181e6d65fd901e83b864521e2ec095666572`。

## 1. MD-4.1-PrintedModifiedFrequency · definition · 印刷p.143 / PDFp.165

### 2. 原文陈述

> If the Implicit Midpoint method is viewed as the exact solution of a perturbed harmonic oscillator, then the frequency of this oscillator is
> \[\widehat\Omega=\frac1{ih}\ln\frac{1+ih\Omega/2}{1-ih\Omega/2}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.printedModifiedFrequency；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原文省略/技术资格 | h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。 | [EXTRA] |
| 原页核对/疑点 | 原书未指定复log分支；与连续实相位的桥接须审校。 | NEEDS_HUMAN |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。印刷复log表达式原样保留，不用实atan定义替换原式。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:360](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:360>)（`MD.Ch04.printedModifiedFrequency`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`5eba9a5add8d49d24bb91db664632fcfec238c3f7a75edc2930ea29c196f48c5`；原文SHA256：`e5fc16a9abb9a7cb39dbbbf8a163d3f1c537da8a212b0553c2fed4173cce56c8`。

## 1. MD-4.1-ModifiedFrequencyLimit · unnumbered_claim · 印刷p.143 / PDFp.165

### 2. 原文陈述

> The figure shows that the frequency is only well approximated in case $h\Omega$ is sufficiently small. For $h\Omega\gg1$ the frequency is highly modified.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.modifiedFrequencyLimit；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:365](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:365>)（`MD.Ch04.modifiedFrequencyLimit`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ModifiedFrequencyLimit.json；blueprint/ch04/validation/short_search/ModifiedFrequencyLimit-route1.lean；blueprint/ch04/validation/short_search/ModifiedFrequencyLimit-route1.log；blueprint/ch04/validation/short_search/ModifiedFrequencyLimit-route2.lean；blueprint/ch04/validation/short_search/ModifiedFrequencyLimit-route2.log。

签名SHA256：`f90608e8aadadcc5fedfcc3878723bd1bd821207392530d00059dea9251feadd`；原文SHA256：`158997a643d0dd75ca1b1104dd73e36fa51948789c5131ff5ea0683b341de662`。

## 1. MD-4.1-MechanicalMidpoint · definition · 印刷p.144 / PDFp.166

### 2. 原文陈述

> we may reduce the equations to determining midpoint values $\widehat q,\widehat p$ such that
> \[\widehat q=q_n+\frac h2M^{-1}\widehat p,\qquad\widehat p=p_n-\frac h2\nabla U(\widehat q),\]
> where, then,
> \[q_{n+1}=\widehat q+\frac h2M^{-1}\widehat p,\qquad p_{n+1}=\widehat p-\frac h2\nabla U(\widehat q).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.mechanicalMidpointRelation；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:376](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:376>)（`MD.Ch04.mechanicalMidpointRelation`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`cc89103a989ba65c687486328e9ecea420dd2f14235618f896b284eb0ae08ccc`；原文SHA256：`d3bf29dd2b5588df5b8afd96e6e6f3e8cf5d573795c567afbd9298d56893e1b3`。

## 1. MD-4.1-MidpointElimination · unnumbered_claim · 印刷p.144 / PDFp.166

### 2. 原文陈述

> We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $\widehat p$, we find
> \[\widehat q=q_n+\frac h2M^{-1}p_n-\frac{h^2}{4}M^{-1}\nabla U(\widehat q).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem midpointElimination :
  ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) h (z mid out : MolecularDynamics.Chapter04Review.Z n),
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m z.2-(h^2/4) • MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad U mid.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.midpointElimination；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:382](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:382>)（`MD.Ch04.midpointElimination`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试2次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/MidpointElimination.json；blueprint/ch04/validation/short_search/MidpointElimination-route1.lean；blueprint/ch04/validation/short_search/MidpointElimination-route1.log；blueprint/ch04/validation/short_search/MidpointElimination-route2.lean；blueprint/ch04/validation/short_search/MidpointElimination-route2.log。

签名SHA256：`e3b6a28ba13587e41761631949da73e619dbe835a66c510d2ac7501efa576452`；原文SHA256：`331a97825adf39b0fbcf3aded12b6481735a24b27ed72a631b52357faa2a5135`。

## 1. MD-4.2.1-SplitHamiltonian · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> In many molecular dynamics applications, the system may be decomposed as $H(q,p)=p^TM^{-1}p/2+U_S(q)+U_F(q)$ where $U_S$ is a “soft” potential, in which the natural motion would be relatively slow, whereas $U_F$ is a much stronger term which would give rise to relatively rapid motion.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.dot z.2 (MolecularDynamics.Chapter04Review.invMass m z.2)/2+US z.1+UF z.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.splitHamiltonian；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:397](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:397>)（`MD.Ch04.splitHamiltonian`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`94c1998ddac54259cd781f59222a2c68d7f6f1f3b8d554bcf71dba5aae191a2b`；原文SHA256：`0e932039bf2898aeae607954c63d9480cb516d4eb042376cb5a1421fbb9c380d`。

## 1. MD-4.2.1-FastVerlet · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Let $\mathcal G_h^F$ denote the map associated to the Verlet method for the system without $U_S$, using a stepsize $h$:
> \[\mathcal G_h^F=\mathrm e^{\frac h2L_{U_F}}\mathrm e^{hL_K}\mathrm e^{\frac h2L_{U_F}},\]
> where $L_K$ is the Lie-derivative corresponding to the kinetic energy component of the Hamiltonian $(K=p^TM^{-1}p/2)$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.fastVerlet；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:401](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:401>)（`MD.Ch04.fastVerlet`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`073410dc01ff793d657b7b96352504132f4f7c94d24d7f0ef43e01a297922acb`；原文SHA256：`5e3d5b4020722d6c51e6f0e981d401cd128d094469a1ff035fd97779964161c6`。

## 1. MD-4.2.1-RESPA · (4.2) · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Now consider the map constructed by taking $r$ steps using $\mathcal G_{F,h/r}$ and composing this with kicks from the soft force:
> \[\mathcal G_h^{\mathrm{MTS}}=\mathrm e^{\frac h2L_{U_S}}[\mathcal G_{h/r}^F]^r\mathrm e^{\frac h2L_{U_S}}.\]
> Reversible RESPA Algorithm
> \[P:=p-(h/2)\nabla U_S(q),\quad Q:=q;\]
> Repeat $r$ times:
> \[P:=P-(h/2)\nabla U_F(Q)/r,\quad Q:=Q+hM^{-1}P/r,\quad P:=P-(h/2)\nabla U_F(Q)/r;\tag{4.2}\]
> \[P:=P-(h/2)\nabla U_S(Q).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.respa；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:406](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:406>)（`MD.Ch04.respa`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`2273a2e2e8ca383156223f74cde2e0ac99835f2315bd9e5c4d5c6136d3761d4f`；原文SHA256：`8c0389340cbef6eff8d59f6d809cb58792c2b056acfbef6694f4f851a5f4073d`。

## 1. MD-4.2.1-RESPAStructure · unnumbered_claim · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Because $U_F$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem respaStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.respaStructure；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:411](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:411>)（`MD.Ch04.respaStructure`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：需桥接坐标kick/drift实际辛性、复合与迭代反步；不重新建立辛流理论。

签名SHA256：`a314b48440705f3acfa18d43202e0fc75ecb51d46dc3720d3400fd41ca437db9`；原文SHA256：`e8a3b7166c903cace2a11553cbcea944ab7dcd5d52ea9d2391b1b23504f7c524`。

## 1. MD-4.2.1-SlowMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> with
> \[S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.slowMatrix；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:418](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:418>)（`MD.Ch04.slowMatrix`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`4e0bb16f3b5c7b6c1aced7417d0dbab8ca882c12d7f7517d82e8666b1d1c78eb`；原文SHA256：`e56642a00bee67a83aa2316a1f6bc5d771a2d88aa36f47e1bec09165bf5afd7f`。

## 1. MD-4.2.1-FastMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> with
> \[S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.fastMatrix；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:422](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:422>)（`MD.Ch04.fastMatrix`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`0d473ad72b0101a09508ad66db6100ec9461a6e110f8769e3f3b351bc6b86fdc`；原文SHA256：`b7b9e31de4f976bad480b382e7193f46cb1e2e1d5095fb0e4d7d316b86040e1a`。

## 1. MD-4.2.1-ImpulseMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> In the limit of small inner step, we solve the system with Hamiltonian $H_F=p^2/2+\Omega^2q^2/2$ exactly, meanwhile punctuating with impulses from $U_S$, thus the MTS flow map approximation, which is linear in this case, can be written in the form of a matrix-vector multiply
> \[\begin{bmatrix}Q\\P\end{bmatrix}=W_h\begin{bmatrix}q\\p\end{bmatrix},\qquad W_h=S_{h/2}F_hS_{h/2}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.impulseMatrix；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:426](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:426>)（`MD.Ch04.impulseMatrix`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`64842efb9c63fea33a0ec905f5f73ca3e9eaddf19da2d68f650e7ddaa93372d3`；原文SHA256：`385d9c855689e8e7931acb2aaecc3805448f67cbf5cb6a11523679ca3562d783`。

## 1. MD-4.2.1-ImpulseDet · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> Both of these matrices have unit determinant for any $h$, so the product of the eigenvalues of $W_h$ is $1$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem impulseDet :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 ∧ (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 ∧ (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.impulseDet；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:430](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:430>)（`MD.Ch04.impulseDet`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ImpulseDet.json；blueprint/ch04/validation/short_search/ImpulseDet-route1.lean；blueprint/ch04/validation/short_search/ImpulseDet-route1.log。

签名SHA256：`e55a7a1121f0356d9b35f9a05d76bf656cdce8d5c150f0d720ed00450058719b`；原文SHA256：`ac0f093548303a53716d3ea80b2b0bd31227d226e0bca455c9abe31451db4530`。

## 1. MD-4.2.1-ImpulseTrace · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> On the other hand, a short calculation shows that
> \[\lambda_1+\lambda_2=\operatorname{Tr}(W_h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.impulseTrace；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:447](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:447>)（`MD.Ch04.impulseTrace`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ImpulseTrace.json；blueprint/ch04/validation/short_search/ImpulseTrace-route1.lean；blueprint/ch04/validation/short_search/ImpulseTrace-route1.log。

签名SHA256：`8744a90f21eba6afe67b3ce7d307e5f6e1cf6ed9460f31a5f61216c5b0486c9d`；原文SHA256：`edd1ff987c35a3029372584d512d73120d95c5d04f6af7ccc4c07e69cb34da11`。

## 1. MD-4.2.1-ResonancePower · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> For example, at $h=\pi/\Omega$, we have
> \[F_h=-I\Rightarrow W_h=-S_{h/2}^2=-\begin{bmatrix}1&0\\-h&1\end{bmatrix},\]
> so that
> \[W_h^n=(-1)^n\begin{bmatrix}1&0\\-nh&1\end{bmatrix}.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.resonancePower；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | Ω>0；所有自然数k，不止图中有限迭代。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:458](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:458>)（`MD.Ch04.resonancePower`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ResonancePower.json；blueprint/ch04/validation/short_search/ResonancePower-route1.lean；blueprint/ch04/validation/short_search/ResonancePower-route1.log。

签名SHA256：`e9b4b2e16c4ad7ef30077d178e17c7856cc79115a7749a5f4457ae8423049aea`；原文SHA256：`196c661b5e939dc6b2a1691100c71dd1460cf18cfe8235bf0f98ad066bac68d1`。

## 1. MD-4.2.1-ResonanceTaylor · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> We can see this by expanding $\mu(h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega)$ in a Taylor expansion around $h=\pi/\Omega$:
> \[\mu(h)=-2+\varepsilon,\qquad\varepsilon=\frac\pi\Omega(h-\pi/\Omega).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.resonanceTaylor；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:480](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:480>)（`MD.Ch04.resonanceTaylor`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：待真实二阶Taylor余项及三角导数在共振点的桥接。

签名SHA256：`e46fe72a72c80eb27102a7974fd30c0322751c5a2f7af7a040b4815d58ca2127`；原文SHA256：`6ad29b0b557e87897c0309ad1f57cd8e9b29c71f249ec90683fce1986db48890`。

## 1. MD-4.2.1-ResonanceInstability · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> Here both eigenvalues are real and one is outside the unit circle. There is thus a small interval of exponential instability directly below $h=\pi/\Omega$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem resonanceInstability :
  ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.resonanceInstability；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | Ω>0；存在左邻域，每个h有真实复谱模>1。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:488](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:488>)（`MD.Ch04.resonanceInstability`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：缺trace<-2的局部Taylor判定与真实复特征向量桥接；保留实际谱而非假设谱。

签名SHA256：`5b080c9c3f8865f5479aadc88c4fff9378f549deefc1d9b520d14b5317b711b4`；原文SHA256：`f88b0ecd97f827166dfa9c87f5f4a16f918acd062c1358004b949282c42fca2c`。

## 1. MD-4.2.1-ResonanceEigenPrinted · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> For $\varepsilon<0$, however, we have
> \[\lambda=-1\pm(|\varepsilon|/2)^{1/2}+O(\varepsilon).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem resonanceEigenPrinted :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)| ≤ C*|h-Real.pi/Ω|
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.resonanceEigenPrinted；定义体/完整签名见上 | 字面签名保留；原文/资格疑点尚未裁定，见issues和本地审计。 |
| 原页核对/疑点 | 根展开首项疑少sqrt(2)因子；待网站/导师裁定。 | [ERRATUM?] |

### 6. 审计结论

本地预审：**NEEDS_HUMAN**。det=1、trace=−2+ε的二次根近−1±sqrt(|ε|)+O(ε)，印刷sqrt(|ε|/2)系数疑误；保留字面实根误差界，未更正成PASS。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:495](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:495>)（`MD.Ch04.resonanceEigenPrinted`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：字面签名疑误不证明；正确二次根展开也未声称已证。

签名SHA256：`20f66d1682ef33cb686bacee35ccd1e4ef53e8c195315d0ef42c60fcafaf74b4`；原文SHA256：`aeca3f026e8df083ad5c216f72a3652bc67446bb049eedcdc8fc11411ddbb883`。

## 1. MD-4.2.2-MollifiedAverage · definition · 印刷p.149 / PDFp.171

### 2. 原文陈述

> The mapping $\mathcal A(q)$ is defined by reference to the fast dynamics, e.g. by the weighted average
> \[\mathcal A(q)=\frac1{K+1}\sum_{i=0}^K\phi_i\theta_i(q),\]
> where the $\theta_i$ are defined recursively by solving the system with Hamiltonian
> \[H^{\mathrm{fast}}(q,p)=p^TM^{-1}p/2+U_F(q)\]
> starting from initial position $q$ and zero initial momentum $p$, for $K$ timesteps using a small stepsize $\tau_f$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def mollifiedAverage {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (K : ℕ) (w : ℕ → ℝ) (δ : ℝ) (q : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (1/(K+1 : ℝ)) • ∑ i ∈ Finset.range (K+1), w i • ((MolecularDynamics.Chapter04Review.fastVerlet m UF δ)^[i] (q,0)).1
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.mollifiedAverage；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]原未指定快积分器，以真实fastVerlet离散位置作为θi的具体实例；K+1项有限加权和，不假定权重任意都有效滤波。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:504](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:504>)（`MD.Ch04.mollifiedAverage`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`98420d95ae66762e0ec997d05f0e289f04d58569cb8ec8b54e5c32d81ce15c08`；原文SHA256：`3978a3812eb2bfa22836cbe7319fdaaa9b40bbce5352911885db04edefbc4e8f`。

## 1. MD-4.2.2-MollifiedPotential · definition · 印刷p.149 / PDFp.171

### 2. 原文陈述

> Effectively, one replaces $U_S(q)$ wherever it appears within the MTS method by a modified potential function $\overline U(q)\stackrel{\mathrm{def}}=U_S(\mathcal A(q))$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def mollifiedPotential {n : ℕ} (US : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) := US ∘ A
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.mollifiedPotential；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch04.lean:509](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:509>)（`MD.Ch04.mollifiedPotential`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

签名SHA256：`7a639dfabaaaa5022aefe6a96444e2ff6727fd9e04bf66baabcd9879ca365539`；原文SHA256：`4ceadc2faf5b3206cdb4ae28cbded32e7badd1ac52334d7c038fb73787cfeab1`。

## 1. MD-4.2.1-ResonanceLinearRate · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> and the norm of the solution will oscillate and grow linearly with $n$ as $n\to\infty$. This is the simplest type of linear resonance present in multiple timestepping.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem resonanceLinearRate : ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
    atTop (𝓝 (|(Real.pi/Ω)*z 0|))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.resonanceLinearRate；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | [EXTRA]选实际Pi最大范数给出精确正线性率；q0≠0，否则此增长结论不成立。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:513](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:513>)（`MD.Ch04.resonanceLinearRate`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试3次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ResonanceLinearRate.json；blueprint/ch04/validation/short_search/ResonanceLinearRate-route1.lean；blueprint/ch04/validation/short_search/ResonanceLinearRate-route1.log；blueprint/ch04/validation/short_search/ResonanceLinearRate-route2.lean；blueprint/ch04/validation/short_search/ResonanceLinearRate-route2.log；blueprint/ch04/validation/short_search/ResonanceLinearRate-route3.lean；blueprint/ch04/validation/short_search/ResonanceLinearRate-route3.log。

签名SHA256：`977fba3e1ba4b1d821dbe9d772cf0faa6ba69f8c794a66874ffb8056e3fb45cf`；原文SHA256：`b6928ab92d85a2a353ffdfca3232fc1336bc655886be252e714f13057e943bbf`。

## 1. MD-4.2.1-ResonanceGrowth · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> and the norm of the solution will oscillate and grow linearly with $n$ as $n\to\infty$. This is the simplest type of linear resonance present in multiple timestepping.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem resonanceGrowth :
  ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.resonanceGrowth；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch04.lean:547](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:547>)（`MD.Ch04.resonanceGrowth`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试1次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/ResonanceGrowth.json；blueprint/ch04/validation/short_search/ResonanceGrowth-route1.lean；blueprint/ch04/validation/short_search/ResonanceGrowth-route1.log。

签名SHA256：`d3e327fdb1093367a08b5bc62ceb39ee2a2b2a06427d1e254036ebd12446d5a6`；原文SHA256：`c14b76c48f0cc3a78788c5e145dd4b341ad12e33312ed3fc9bf1f90780b44e2a`。

## 1. MD-4.2.2-MollifiedStructure · unnumbered_claim · 印刷p.149 / PDFp.171

### 2. 原文陈述

> In each of the mollified multiple timestepping methods, since only the potential energy is modified, and by a smooth mapping of positions, the forces derived by differentiating $\overline U$ are still conservative, and, just as with the MTS method, the scheme remains symplectic.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem mollifiedStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (MolecularDynamics.Chapter04Review.mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m (MolecularDynamics.Chapter04Review.mollifiedPotential US A) UF r h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch04.mollifiedStructure；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |
| 原文省略/技术资格 | 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。 | [EXTRA] |

### 6. 审计结论

本地预审：**PASS**。本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch04.lean:562](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:562>)（`MD.Ch04.mollifiedStructure`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：未检出；直接sorry的sorryAx已单列。

缺失/继续路线：正式库无RESPA实际Jacobian辛性/反步定理；需实际链式法则与有限迭代复合桥接，保留sorry，不另建辛流理论。

签名SHA256：`c888250b6e4e206b92153d5c4b8e3be242c306acc46160dcb4c50a522517e9c4`；原文SHA256：`783f68f12d7dad05b4aa84255eb0e8e4ca179c7e2ab99f221d23ff01ab12b87a`。
