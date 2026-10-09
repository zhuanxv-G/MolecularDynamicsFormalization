# 第2章 Lean Blueprint 本地审阅材料

覆盖印刷p.53–94正文，习题除外。原文JSON审校状态见各条；本地模板C预审独立于网站审计。已整合网站返回0条，其余待网站审计；未冻结。编译和公理检查验证当前Lean陈述/证明，原文忠实性由独立审校核验。

| source_id | 页码 印刷/PDF | 本地预审 | 网站审计 | 状态 |
|---|---|---|---|---|
| MD-2-HamiltonianODE | 53/75 | PASS | 待网站审计 | self-contained |
| MD-2-Hamiltonian | 53/75 | PASS | 待网站审计 | self-contained |
| MD-2-CanonicalJ | 53/75 | PASS | 待网站审计 | self-contained |
| MD-2-Euler | 54/76 | PASS | 待网站审计 | self-contained |
| MD-2-OneStep | 54/76 | PASS | 待网站审计 | self-contained |
| MD-2.1-Convergence | 55/77 | PASS | 待网站审计 | self-contained |
| MD-2.1-Order | 55/77 | PASS | 待网站审计 | self-contained |
| MD-2.1-Error | 56/78 | PASS | 待网站审计 | self-contained |
| MD-2.1-Thm2.1 | 56/78 | PASS | 待网站审计 | checked+documented priors |
| MD-2.1.2-SecondDerivative | 59/81 | PASS | 待网站审计 | self-contained |
| MD-2.1.2-Taylor2 | 59/81 | PASS | 待网站审计 | self-contained |
| MD-2.1.2-Taylor2Order | 59/81 | PASS | 待网站审计 | incomplete |

## 需要导师判断的问题


## 1. MD-2-HamiltonianODE · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> The challenge before us is to compute solutions of
> \[\dot{\boldsymbol q}=M^{-1}\boldsymbol p,\qquad \dot{\boldsymbol p}=F(\boldsymbol q)=-\nabla U(\boldsymbol q),\]
> or, more compactly, with $\boldsymbol z$ representing the collection of all positions and momenta,
> \[\dot{\boldsymbol z}=f(\boldsymbol z),\qquad f(\boldsymbol z)=J\nabla H.\tag{2.1}\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def hamiltonianODE {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.hamiltonianODE；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:17](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:17>)（`MD.Ch02.hamiltonianODE`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`64f9c96d0a4ae55f8528b9a0b3968ff0bb32f8d587793814546bf59b4528ae21`；原文SHA256：`f301f432947b8cd8cd1f797e187b98d88cbaf439b166e59d430547574427f4b8`。

## 1. MD-2-Hamiltonian · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> and $H=\boldsymbol p^TM^{-1}\boldsymbol p/2+U(\boldsymbol q)$ is the Hamiltonian.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n) :
    PhaseSpace n → ℝ := massHamiltonian m U
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.mechanicalHamiltonian；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:23](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:23>)（`MD.Ch02.mechanicalHamiltonian`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`8b8585b4f7838dd429ec99818a63e6aa3c0a4a75852725679fec79facca9f335`；原文SHA256：`9582ae8e070d8e8590851645f60a3c7ee8ca7618c0ec81610c8862d58d94746c`。

## 1. MD-2-CanonicalJ · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> where $J=\begin{bmatrix}0&I\\-I&0\end{bmatrix}$,

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def canonicalJ (n : ℕ) : Matrix (Sum (Fin n) (Fin n)) (Sum (Fin n) (Fin n)) ℝ :=
  textbookJ n
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.canonicalJ；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:27](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:27>)（`MD.Ch02.canonicalJ`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`8efac37fc95eb8b9de41f2bbf9c8a7fedb99cebaf41d853e46b0d232bdcdf45d`；原文SHA256：`095ea3da4b1fa82829de23a62989e5ae58186e1cb46b233c5107e7957646d9b3`。

## 1. MD-2-Euler · definition · 印刷p.54 / PDFp.76

### 2. 原文陈述

> The simplest scheme is certainly Euler’s method which advances the solution from timestep to timestep by the formula
> \[\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_n).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.euler；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:31](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:31>)（`MD.Ch02.euler`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`d972017500dc16cadac7cbc70966761995bf5f94337b248f235b4bf71b73bb3e`；原文SHA256：`556ff4e49f4de350844702b3e325099ed4354d027bbfb35b2327f38a68ed5176`。

## 1. MD-2-OneStep · definition · 印刷p.54 / PDFp.76

### 2. 原文陈述

> Suppose that the system under study has a well defined flow map $\mathcal F_t$ defined on the phase space (which is assumed to exclude any singular points of the potential energy function). The solution of the initial value problem, $\dot{\boldsymbol z}=f(\boldsymbol z)$, $\boldsymbol z(0)=\boldsymbol\zeta$, may be written $\boldsymbol z(t;\boldsymbol\zeta)$ (with $\boldsymbol z(0;\boldsymbol\zeta)=\boldsymbol\zeta$), and the flow-map $\mathcal F_t$ satisfies $\mathcal F_t(\boldsymbol\zeta)=\boldsymbol z(t;\boldsymbol\zeta)$: A one-step method, starting from a given point, approximates a point on the solution trajectory at a given time $h$ units later. Such a method defines a map $\mathcal G_h$ of the phase space as illustrated in Fig. 2.1.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def numericalTrajectory {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (n : ℕ) : E :=
  (G h)^[n] ζ
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.numericalTrajectory；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。定义只记录给定单步映射的有限迭代，不将任意映射称为收敛近似或宣称全球流存在。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:35](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:35>)（`MD.Ch02.numericalTrajectory`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`f79d2e780fa2934c8ed0abd0f39a54ed010cb0660fc97384d1268e8419201ec8`；原文SHA256：`50854266d91d56e9de89433ff4f0dbdea0937e0f64fc529cb88ba06fbc24429e`。

## 1. MD-2.1-Convergence · definition · 印刷p.55 / PDFp.77

### 2. 原文陈述

> The convergence of a numerical method refers to the ability of the method to provide an arbitrary level of accuracy by using small enough timesteps.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def convergence {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.convergence；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:40](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:40>)（`MD.Ch02.convergence`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`dae87f54a85b8f54c7b38cf55b26311d4cd0b182d41066bdc9ba6215dd5b8332`；原文SHA256：`106e2e0548f85e7558b5e2486576383ee65ffd5a3f031b60dabd22aeb0c902c3`。

## 1. MD-2.1-Order · definition · 印刷p.55 / PDFp.77

### 2. 原文陈述

> The order of accuracy is the exponent in the power law by which the error in the method is related to the stepsize. For example, when we say that a method is third order accurate, we mean that the global error (on a fixed finite time interval) can be bounded by $Kh^3$, where $h$ is a sufficiently small timestep and $K$ is a number which depends on the length of the time interval and the features of the problem, but which is independent of $h$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def order {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ K > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ K * (τ / ν)^r
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.order；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:45](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:45>)（`MD.Ch02.order`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`e05f04a1c9ec06ba535591b5c5ae2e10043d637264e49e2d516a5c8f0a8ad0bb`；原文SHA256：`521f3bc13fdfb77f200ddc91bac62fcd97501db1a8710cd5397703a27b8a6365`。

## 1. MD-2.1-Error · definition · 印刷p.56 / PDFp.78

### 2. 原文陈述

> Let the approximate solution vectors at successive timesteps be $\boldsymbol z_0,\boldsymbol z_1,\ldots,\boldsymbol z_\nu$ where $\nu h=\tau$. We assume that $\tau$, the length of the time interval, is fixed, and $\nu$ is an integer parameter representing the total number of timesteps. In order to improve the quality of the approximation, the parameter $\nu$ may be increased, as the stepsize is proportionately decreased. The error at step $n$ is defined by $e_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|$, where $t_n=nh$; it clearly depends on $h$.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def maximumError {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G : ℝ → E → E) (γ : ℝ → E) (h : ℝ) (ν : ℕ) : ℝ :=
  oneStepMaxError G h γ ν
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.maximumError；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:50](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:50>)（`MD.Ch02.maximumError`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`89ff35b2af09075c46c9358168fc7352256ab3050071ad67f9901084c30931b6`；原文SHA256：`5778e0756874a90384d47e74ba0a86feb22b35b5f60071e99e54a1743e8b6ffa`。

## 1. MD-2.1-Thm2.1 · Theorem 2.1 · 印刷p.56 / PDFp.78

### 2. 原文陈述

> Let $\mathcal D$ be a bounded, open region in $\mathbb R^m$ such that $f:\mathcal D\to\mathbb R^m$ is continuously differentiable. Let $\boldsymbol\zeta$ be an interior point of $\mathcal D$ and suppose the initial value problem (2.1) has a unique solution that remains in $\mathcal D$ for $t\in[0,\tau]$. Then there exists a constant $C(\tau)>0$ such that for sufficiently large $\nu\in\mathbb N$ the numerical solution $\boldsymbol z_n$ remains in $\mathcal D$ for $n=0,1,\ldots,\nu$, where $h\nu=\tau$, and, moreover, the maximum global error in Euler’s method satisfies
> \[\bar e:=\max_{0\le n\le\nu}e_n\le C(\tau)h.\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem theorem_2_1 {m : ℕ} (D : Set (Position m))
    (hDb : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t)
    (_hunique : ∀ η : ℝ → Position m, η 0 = γ 0 → MapsTo η (Icc 0 τ) D →
      (∀ t ∈ Icc 0 τ, HasDerivWithinAt η (f (η t)) (Icc 0 τ) t) →
      ∀ t ∈ Icc 0 τ, η t = γ t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 有界开放D、f C¹、初值内部及唯一实际解 | hDb,hD,hf,hγD,hγ,_hunique；ζ=γ0 | 一致；唯一性保留但桥接证明不需使用 |
| 足够大ν后每个n≤ν数值留域，最大误差≤Ch | C>0、ν₀>0、∀ν≥ν₀后的两个合取结论 | 一致；未将数值留域作假设 |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**checked+documented priors**；本地证明状态：existing_bridge。

位置：[Blueprint/Ch02.lean:56](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:56>)（`MD.Ch02.theorem_2_1`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

已登记前置证明/定义：MolecularDynamics.theorem_2_1_euler。

签名SHA256：`6f0e434a31407f1f5de51e8b81dd515c9958fb26ddd37238cb15934a39e502b3`；原文SHA256：`105c67fe4d2690a8e158608c6cd1a31beb9a90a596bb3888ef9428281a05af81`。

## 1. MD-2.1.2-SecondDerivative · unnumbered_claim · 印刷p.59 / PDFp.81

### 2. 原文陈述

> and the second derivative is obtained by differentiating the differential equation itself:
> \[\ddot{\boldsymbol z}(t)=\frac{\mathrm d}{\mathrm dt}\dot{\boldsymbol z}(t)=\frac{\mathrm d}{\mathrm dt}f(\boldsymbol z(t))=f'(\boldsymbol z(t))\dot{\boldsymbol z}(t)=f'(\boldsymbol z(t))f(\boldsymbol z(t)),\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem odeSecondDerivative :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.odeSecondDerivative；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：local_proof。

位置：[Blueprint/Ch02.lean:72](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:72>)（`MD.Ch02.odeSecondDerivative`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`bedcaaed95d38f1ca0a96e32276b27794c9f081c2dd7a3856d1c0135a1dbe773`；原文SHA256：`f0edac03e3505f2255f4541aa715ea9b136cdefbfbc1b06a1f267e480147d770`。

## 1. MD-2.1.2-Taylor2 · Example 2.1 (map) · 印刷p.59 / PDFp.81

### 2. 原文陈述

> so one may write the 2nd order Taylor series method as
> \[\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_n)+\frac{h^2}{2}f'(\boldsymbol z_n)f(\boldsymbol z_n).\]
> This method generates the flow map approximation
> \[\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\boldsymbol z)+\frac{h^2}{2}f'(\boldsymbol z)f(\boldsymbol z).\]

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
def taylorSecond {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.taylorSecond；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**self-contained**；本地证明状态：definition。

位置：[Blueprint/Ch02.lean:82](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:82>)（`MD.Ch02.taylorSecond`）。

Lean编译/公理检查：已验证；公理：`propext, Classical.choice, Quot.sound`。

直接占位：无直接sorry；传递占位：未检出。

签名SHA256：`2f0a0b493c444eedd7791d6e5e1250bc7f7ed3cfc089cbc805c63a748f83f396`；原文SHA256：`c16befc845b50ae8093d42ee030fcf27a058116412bc95532fd0b00c808afe69`。

## 1. MD-2.1.2-Taylor2Order · Example 2.1 (order) · 印刷p.59 / PDFp.81

### 2. 原文陈述

> which is referred to as the 2nd order Taylor series method.

### 3. 原文证明

原书无独立完整证明（proof_latex=null）。

原书未给独立完整证明。

### 4. Lean陈述

```lean
theorem taylor2Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2
```

### 5. 对照表

| 原文成分 | Lean对应 | 一致/[EXTRA]/[ERRATUM?] |
|---|---|---|
| 原文完整数学对象和展示式 | MD.Ch02.taylor2Order；定义体/完整签名见上 | 一致；逐条技术条件见[EXTRA] |

### 6. 审计结论

本地预审：**PASS**。已逐项比对原文对象、实际定义、量词、前提和完整结论；技术前提见[EXTRA]。

网站审计：**待网站审计**。原文JSON：DRAFT；未冻结。

### 7. 状态与证明位置

**incomplete**；本地证明状态：placeholder。

位置：[Blueprint/Ch02.lean:87](<C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization/Blueprint/Ch02.lean:87>)（`MD.Ch02.taylor2Order`）。

Lean编译/公理检查：已验证；公理：`propext, sorryAx, Classical.choice, Quot.sound`。

直接占位：有sorry；传递占位：含sorryAx。

缺失/继续路线：缺一般Taylor方法局部截断误差、数值留域与全局阶桥接；当前库仅一般one-step条件误差定理。

签名SHA256：`b274d6afd631fc6a123c0b272800e3d1c0093a3a226d18f1ab5cae8d1ec8570a`；原文SHA256：`d5b6c3d33183b985921f59e298ff73cc05ed309fc3d507b224229f7bffda0e36`。
