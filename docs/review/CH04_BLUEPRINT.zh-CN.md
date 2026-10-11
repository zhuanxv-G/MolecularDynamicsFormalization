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

位置：[Blueprint/Ch04.lean:21](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:21>)（`MD.Ch04.linearField`）。

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

位置：[Blueprint/Ch04.lean:24](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:24>)（`MD.Ch04.eulerFactor`）。

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

位置：[Blueprint/Ch04.lean:28](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:28>)（`MD.Ch04.scalarEulerStable`）。

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

位置：[Blueprint/Ch04.lean:46](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:46>)（`MD.Ch04.eulerStabilityRegion`）。

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

位置：[Blueprint/Ch04.lean:50](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:50>)（`MD.Ch04.oscillatorMatrix`）。

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

位置：[Blueprint/Ch04.lean:54](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:54>)（`MD.Ch04.eulerImaginaryGrowth`）。

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

位置：[Blueprint/Ch04.lean:68](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:68>)（`MD.Ch04.symplecticEulerMatrix`）。

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

位置：[Blueprint/Ch04.lean:73](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:73>)（`MD.Ch04.symplecticEulerCharacteristic`）。

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

位置：[Blueprint/Ch04.lean:83](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:83>)（`MD.Ch04.prkThreshold`）。

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

位置：[Blueprint/Ch04.lean:96](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:96>)（`MD.Ch04.verletStability`）。

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

位置：[Blueprint/Ch04.lean:156](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:156>)（`MD.Ch04.symplecticEulerBoundaryPrinted`）。

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

位置：[Blueprint/Ch04.lean:162](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:162>)（`MD.Ch04.verletBoundaryPrinted`）。

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

位置：[Blueprint/Ch04.lean:167](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:167>)（`MD.Ch04.oscillatorSpectrum`）。

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

位置：[Blueprint/Ch04.lean:194](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:194>)（`MD.Ch04.symplecticEulerRoots`）。

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

位置：[Blueprint/Ch04.lean:224](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:224>)（`MD.Ch04.symplecticEulerUnitRoots`）。

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

位置：[Blueprint/Ch04.lean:252](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch04.lean:252>)（`MD.Ch04.symplecticEulerStability`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出；直接sorry的sorryAx已单列。

本地路线尝试3次，未通过0次（含超时或签名展开预算失败）；证据：blueprint/ch04/validation/short_search/SymplecticEulerStability.json；blueprint/ch04/validation/short_search/SymplecticEulerStability-route1.lean；blueprint/ch04/validation/short_search/SymplecticEulerStability-route1.log；blueprint/ch04/validation/short_search/SymplecticEulerStability-route2.lean；blueprint/ch04/validation/short_search/SymplecticEulerStability-route2.log；blueprint/ch04/validation/short_search/SymplecticEulerStability-route3.lean；blueprint/ch04/validation/short_search/SymplecticEulerStability-route3.log。

签名SHA256：`31da4d14a4c75f5466f7d85db446a21959c4160c4d5ee6fdbdb6daf16433e5db`；原文SHA256：`5337d81ef03916ce02696f1c9144e1d1d1ebfb3bcf6ecefab190810118b9327f`。
