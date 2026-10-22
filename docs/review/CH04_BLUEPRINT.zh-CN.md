# 第4章 Lean Blueprint 本地审阅材料

179条；网站PASS 133，本地按意见修复7条（未再送网站），合并勘误26项。
统计与证明状态见[导师摘要](CH04_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](CH04_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch04/full/CHECK\_REPORT.json。

## 1. MD-4-LinearField · (4.1) · 印刷p.139 / PDFp.161

### 2. 原文陈述

> Let us recall the method of studying the asymptotic numerical stability of a linear system

$$
\dot z=Az,\tag{4.1}
$$


> where $z\in\mathbb R^m,A\in\mathbb R^{m\times m}$, when solved by a numerical method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def linearField {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (z : Fin n → ℂ) := A *ᵥ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.linearField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 复线性扩张用于随后的标量测试；原实矩阵实例嵌入ℂ。 | [EXTRA] |

[EXTRA] 复线性扩张用于随后的标量测试；原实矩阵实例嵌入ℂ。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:26；依赖 ReviewDefinitions.lean（Ch04\_deps.txt:4387）展开 linearField 为 A *ᵥ z，即第i分量 Σj Aᵢⱼzⱼ。原文定义实线性系统的右端；Lean 给出复线性右端，实矩阵和实向量逐项嵌入后完全一致。[EXTRA] 是明示且合理的复扩张，无对角化或谱判据的额外断言。此定义不承担ODE解或渐近性质证明。定义体无 sorry；本次仅审计语义，未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.linearField`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L25)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-EulerFactor · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> Here $\lambda$, hence $u$ may in general be complex. Then one applies the numerical method directly to the scalar equation. For example Euler’s method yields

$$
u_{n+1}=(1+h\lambda)u_n.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerFactor (h : ℝ) (rho : ℂ) : ℂ := 1 + (h : ℂ) * rho
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.eulerFactor` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；h 为实数，rho 为复数，返回复数 1+h*rho；rho 对应原 λ。定义提取迭代因子，未把标量推广为矩阵，未增加限制。

### 7. 状态与证明位置

self-contained；`MD.Ch04.eulerFactor`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L28)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-ScalarEulerStable · unnumbered_claim · 印刷p.139 / PDFp.161

### 2. 原文陈述

> The iteration is stable if $|u_n|$ remains bounded as $n\to\infty$, implying the following condition for asymptotic stability:

$$
|1+h\lambda|\le1.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem scalarEulerStable :
  ∀ h rho, MolecularDynamics.Chapter04Review.scalarStable (MolecularDynamics.Chapter04Review.eulerFactor h rho) ↔ ‖MolecularDynamics.Chapter04Review.eulerFactor h rho‖ ≤ 1 := by
  intro h rho
  constructor
  · rintro ⟨C, hC⟩
    by_contra hn
    have ht := (tendsto_pow_atTop_atTop_of_one_lt (lt_of_not_ge hn)).eventually (eventually_gt_atTop C)
    obtain ⟨k,hk⟩ := ht.exists
    have hb := hC k
    rw [norm_pow] at hb
    exact (not_lt_of_ge hb) hk
  · intro ha
    refine ⟨1, ?_⟩
    intro k
    rw [norm_pow]
    exact pow_le_one₀ (norm_nonneg _) ha
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.scalarEulerStable` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | scalarStable明确定义为因子各次幂一致有界；非零初值下等价于迭代有界，零初值例外。 | [EXTRA] |

[EXTRA] scalarStable明确定义为因子各次幂一致有界；非零初值下等价于迭代有界，零初值例外。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:33–48；依赖 ReviewDefinitions.lean（Ch04\_deps.txt:4388,4390）：eulerFactor h rho = 1+(h:ℂ)*rho；scalarStable a = ∃ C:ℝ, ∀ k:ℕ, ‖a^k‖≤C。签名为 ∀ h:ℝ, ∀ rho:ℂ，上述幂有界性质 ↔ ‖1+h rho‖≤1。常数在k之前，正确要求一致有界；复范数等于模。[EXTRA] 合理地明确方法稳定性，而不是仅某个零初值轨道的有界性：对非零初值乘除‖u₀‖即可等价，对所有初值也等价。等价式的充分方向是原文条件的正确补全。没有将有界误作趋零。证明体无 sorry；未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.scalarEulerStable`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L32)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-EulerRegion · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> This defines the “stability region” for Euler’s method as a disk in the complex $h\lambda$-plane centered around $-1$ of radius $1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerStabilityRegion : Set ℂ := {z | ‖1+z‖ ≤ 1}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.eulerStabilityRegion` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:51；依赖 ReviewDefinitions.lean（Ch04\_deps.txt:4389）同名定义展开为 {z:ℂ | ‖1+z‖≤1}。每个z满足 dist z (−1)=‖1+z‖，故恰为复平面以−1为心、半径1的闭圆盘；变量为hλ，不是λ。无额外假设；定义体无 sorry，未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.eulerStabilityRegion`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L50)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-OscillatorMatrix · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> If we consider applying this technique to the harmonic oscillator $\dot q=p;\dot p=-\Omega^2q$, then the matrix $A$ is

$$
A=\begin{bmatrix}0&I\\-\Omega^2&0\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def oscillatorMatrix (Ω : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![0,1; -Ω^2,0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.oscillatorMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 一个自由度，I=1；按标量频率实例解释。 | [EXTRA] |

[EXTRA] 一个自由度，I=1；按标量频率实例解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:55；依赖 ReviewDefinitions.lean（Ch04\_deps.txt:4393）oscillatorMatrix Ω = !![0,1; −Ω^2,0]，Ω:ℝ，作用于(q,p)得到(p,−Ω²q)。[EXTRA] 明示一个自由度、I=1，是合理的标量振子实例；不能将本定义当作一般多自由度块矩阵的形式化。原句本身未量化一般矩阵Ω，按已声明的标量实例接受。定义体无 sorry；未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.oscillatorMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L54)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-EulerImaginaryGrowth · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues are $\pm i\omega$. The reason a method like Euler’s method can never perform well for molecular dynamics is that molecular dynamics is a Hamiltonian system and at the bottoms of basins on the energy surface, which correspond to stable centers, we expect all the eigenvalues of a local linearization of the problem to be purely imaginary. The stability condition always fails to hold and, for Euler’s method, $z_n$ grows exponentially rapidly away from the equilibrium point.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerImaginaryGrowth :
  ∀ h Ω : ℝ, h ≠ 0 → Ω ≠ 0 → ∀ z : ℂ, z ≠ 0 →
    Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖) atTop atTop := by
  intro h Ω hh hΩ z hz
  have hs : ‖MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω)‖^2=1+(h*Ω)^2 := by
    simp_all [MolecularDynamics.Chapter04Review.eulerFactor, Complex.sq_norm, Complex.normSq_apply]
    ring
  have hp : 0 < (h*Ω)^2 := sq_pos_of_ne_zero (mul_ne_zero hh hΩ)
  have hg : 1 < ‖MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω)‖ := by
    nlinarith [norm_nonneg (MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))]
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hg).atTop_mul_const (norm_pos_iff.mpr hz)
  simpa [norm_mul, norm_pow] using ht

theorem eulerImaginaryGrowth_rate (h Ω : ℝ) (_hh : h ≠ 0) (_hΩ : Ω ≠ 0) :
    let r := Real.sqrt (1+(h*Ω)^2)
    1 < r ∧ (∀ (z : ℂ) (k : ℕ),
      ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖=r^k*‖z‖) ∧
    (∀ (v : Fin 2 → ℝ) (k : ℕ),
      let w := (1+h • MolecularDynamics.Chapter04Review.oscillatorMatrix Ω)^k *ᵥ v
      Real.sqrt (Ω^2*(w 0)^2+(w 1)^2)=
        r^k*Real.sqrt (Ω^2*(v 0)^2+(v 1)^2)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条覆盖Euler的标量/实轨道指数增长；振子完整谱由MD-4-OscillatorSpectrum承担，未删原句。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.eulerImaginaryGrowth`；`MD.Ch04.eulerImaginaryGrowth_rate` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证趋无穷，并补精确指数率r>1和实际实振子Euler轨道的加权范数等式；矩阵完整复谱已由MD-4-OscillatorSpectrum单列承担，原ω=Ω。非零步长/频率为[EXTRA]资格，新结论暂sorry。 | [EXTRA] |

[EXTRA] h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。；[EXTRA] 保留已证趋无穷，并补精确指数率r>1和实际实振子Euler轨道的加权范数等式；矩阵完整复谱已由MD-4-OscillatorSpectrum单列承担，原ω=Ω。非零步长/频率为[EXTRA]资格，新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全部 h,Ω∈ℝ，非零条件及非零复初值明确；第一条是趋无穷，补充条给 r=sqrt(1+(hΩ)²)>1、所有复初值和自然数步数的精确范数率，以及真实实矩阵轨道的加权范数率。对 Ω≠0，该加权范数正定，非零实轨道指数增长。零初值在恒等式中允许，与趋无穷条的非零前提不冲突。谱由条目5承担。[EXTRA] 已显式说明限制，均合理。

### 7. 状态与证明位置

incomplete；`MD.Ch04.eulerImaginaryGrowth`：已证；`MD.Ch04.eulerImaginaryGrowth_rate`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L59)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerMatrix · definition · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The timestep map is defined by

$$
Q=q+hP,\qquad P=p-h\Omega^2q.
$$


> Solving for $Q,P$ this yields

$$
\begin{bmatrix}Q\\P\end{bmatrix}=\begin{bmatrix}1-h^2\Omega^2&h\\-h\Omega^2&1\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.symplecticEulerMatrix` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:77–78；依赖 ReviewDefinitions.lean（Ch04\_deps.txt:4394–4395）symplecticEulerMatrix Ω h=!![1−h^2*Ω^2,h;−h*Ω^2,1]。任意实Ω,h及输入(q,p)，矩阵输出P=p−hΩ²q，Q=(1−h²Ω²)q+hp=q+hP，覆盖两条更新关系及消元矩阵，无隐式分支或非零条件。上下文动量先更新正确。无 [EXTRA]/[ERRATUM?]；定义体无 sorry，未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.symplecticEulerMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L83)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerCharacteristic · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues of the matrix are easily found, they are

$$
\lambda_{1,2}=1-\frac{h^2\Omega^2}{2}\pm\frac12\sqrt{h^4\Omega^4-4h^2\Omega^2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerCharacteristic :
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1 := by
  intro Ω h rho
  simp [MolecularDynamics.Chapter04Review.symplecticEulerMatrix, Matrix.det_fin_two]
  push_cast
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅特征多项式辅助等式；原展示特征值的完整等价结论由MD-4-SymplecticEulerRoots承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.symplecticEulerCharacteristic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅为特征多项式辅助计算；原完整两个复根（含零/负判别式及重根）已由MD-4-SymplecticEulerRoots明确承担，跨条目范围写明，保留原文。 | [EXTRA] |

[EXTRA] 以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。；[EXTRA] 本条仅为特征多项式辅助计算；原完整两个复根（含零/负判别式及重根）已由MD-4-SymplecticEulerRoots明确承担，跨条目范围写明，保留原文。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀Ω,h∈ℝ、∀rho∈ℂ，计算实际复化矩阵 det(rho I-A)=rho²-(2-h²Ω²)rho+1。量词和常数项正确；本条明确只是辅助特征多项式，完整求根由条目6承担，不把本条独立当成完整求根。

### 7. 状态与证明位置

self-contained；`MD.Ch04.symplecticEulerCharacteristic`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L89)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-PRKThreshold · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> Among explicit symplectic Partitioned Runge-Kutta methods this is the maximum stability threshold [74].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem prkThreshold :
  ∀ s (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (G : ℝ → ℝ → Matrix (Fin 2) (Fin 2) ℝ), 0 < s →
    (∑ i,b i)=1 → (∑ i,c i)=1 →
    (∀ i j, b i*B i j+c j*A j i=b i*c j) →
    (∀ i j, i ≤ j → A i j=0) → (∀ i j, i < j → B i j=0) →
    (∀ Ω h z, ∃ q p, MolecularDynamics.Chapter04Review.prkOscillatorRelation A B b c Ω h z (G Ω h *ᵥ z) q p) →
    (∀ Ω h, MolecularDynamics.Chapter04Review.matrixStable (G Ω h) → |h*Ω| ≤ 2) := by
  sorry



/-- 修正版，对应原文 MD-4-PRKThreshold。改动：删除一般多级PRK的普遍阈值2，只给反例所用两个半步辛Euler的实际稳定区0<hΩ<4；未对所有PRK给新的最优阈值。 -/
```

独立修正版：

```lean
theorem prkThreshold_corrected (Ω h : ℝ) (_hΩ : 0 < Ω) (_hh : 0 < h)
    (_hst : h*Ω < 4) :
    MolecularDynamics.Chapter04Review.matrixStable
      ((MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω (h/2))^2) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.prkThreshold`；`MD.Ch04.prkThreshold_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 删除一般多级PRK的普遍阈值2，只给反例所用两个半步辛Euler的实际稳定区0<hΩ<4；未对所有PRK给新的最优阈值。 | [EXTRA] |

[EXTRA] [ERRATUM?] 删除一般多级PRK的普遍阈值2，只给反例所用两个半步辛Euler的实际稳定区0<hΩ<4；未对所有PRK给新的最优阈值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 中 MolecularDynamics/Chapter04/ReviewDefinitions.lean 的正式定义：matrixStable(A)=∃C∈ℝ,∀k∈ℕ,∀v∈ℝ², ‖A^k v‖≤C‖v‖，是统一幂有界而不是仅谱模≤1；symplecticEulerMatrix(Ω,h)=[[1-h²Ω²,h],[-hΩ²,1]]；verletMatrix(Ω,h)=[[1-h²Ω²/2,h],[-hΩ²(1-h²Ω²/4),1-h²Ω²/2]]。 prkOscillatorRelation 展开为 qᵢ=z₀+hΣⱼAᵢⱼpⱼ，pᵢ=z₁-hΩ²ΣⱼBᵢⱼqⱼ，out₀=z₀+hΣᵢbᵢpᵢ，out₁=z₁-hΩ²Σᵢcᵢqᵢ。签名全称量化任意级数s和系数；一致性、辛条件及A严格下三角/B下三角均未限制子步数或成本。将“最大阈值”编码为任意稳定步长均≤2更强，且本方法类内已有反例。此判断无需缺失定义或查阅[74]。实际声明含sorry，另记为未完成证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.prkThreshold`：未证（原书疑误不证）；`MD.Ch04.prkThreshold_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L100)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-VerletStability · unnumbered_claim · 印刷p.141 / PDFp.163

### 2. 原文陈述

> For example, applying the Verlet method to the harmonic oscillator with frequency $\Omega$ we find that the origin is stable (and the numerical solution stays bounded for all time) provided $h\Omega\le2$ (the same condition as for stability of Symplectic Euler).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletStability :
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h) := by
  intro Ω h hn ht
  have hΩ : Ω ≠ 0 := by intro hz; simp [hz] at hn
  have ht2 : h^2*Ω^2 < 4 := by
    obtain ⟨ha,hb⟩ := abs_lt.mp ht
    nlinarith
  let b : ℝ := Ω^2*(1-h^2*Ω^2/4)
  have hb : 0 < b := mul_pos (sq_pos_of_ne_zero hΩ) (by nlinarith)
  let A := MolecularDynamics.Chapter04Review.verletMatrix Ω h
  let K : (Fin 2 → ℝ) → ℝ := fun v => v 1^2+b*v 0^2
  have hstep : ∀ v : Fin 2 → ℝ, K (A *ᵥ v)=K v := by
    intro v
    simp [K,A,b,MolecularDynamics.Chapter04Review.verletMatrix,Matrix.mulVec,dotProduct, vecHead, vecTail,Fin.sum_univ_two]
    ring
  have hi : ∀ k : ℕ, ∀ v : Fin 2 → ℝ, K (A^k *ᵥ v)=K v := by
    intro k v
    induction k with
    | zero => simp
    | succ k ih => rw [pow_succ',← Matrix.mulVec_mulVec,hstep,ih]
  let d : ℝ := min 1 b
  have hd : 0 < d := lt_min (by norm_num) hb
  have hd1 : d ≤ 1 := min_le_left _ _
  have hdb : d ≤ b := min_le_right _ _
  have hcoord : ∀ (v : Fin 2 → ℝ) (i : Fin 2), (v i)^2 ≤ ‖v‖^2 := by
    intro v i
    rw [← sq_abs]
    exact (sq_le_sq₀ (abs_nonneg _) (norm_nonneg _)).mpr (by simpa using norm_le_pi_norm v i)
  have hu : ∀ v : Fin 2 → ℝ, K v ≤ (1+b)*‖v‖^2 := by
    intro v
    have hm := mul_le_mul_of_nonneg_left (hcoord v 0) hb.le
    dsimp [K]
    nlinarith [hcoord v 1]
  have hl : ∀ (v : Fin 2 → ℝ) (i : Fin 2), d*(v i)^2 ≤ K v := by
    intro v i
    fin_cases i
    · dsimp [K]
      nlinarith [mul_nonneg (sub_nonneg.mpr hdb) (sq_nonneg (v 0)),sq_nonneg (v 1)]
    · dsimp [K]
      nlinarith [mul_nonneg (sub_nonneg.mpr hd1) (sq_nonneg (v 1)),mul_nonneg hb.le (sq_nonneg (v 0))]
  let C : ℝ := Real.sqrt ((1+b)/d)
  have hC : 0 ≤ C := Real.sqrt_nonneg _
  have hCs : C^2*d=1+b := by
    dsimp [C]
    rw [Real.sq_sqrt (by positivity)]
    field_simp [ne_of_gt hd]
  refine ⟨C, ?_⟩
  intro k v
  apply (pi_norm_le_iff_of_nonneg (mul_nonneg hC (norm_nonneg v))).mpr
  intro i
  have hm : d*((A^k *ᵥ v) i)^2 ≤ d*(C*‖v‖)^2 := calc
    d*((A^k *ᵥ v) i)^2 ≤ K (A^k *ᵥ v) := hl _ i
    _ = K v := hi k v
    _ ≤ (1+b)*‖v‖^2 := hu v
    _ = d*(C*‖v‖)^2 := by rw [← hCs]; ring
  have hsq := le_of_mul_le_mul_left hm hd
  simpa using abs_le_of_sq_le_sq hsq (mul_nonneg hC (norm_nonneg v))

theorem verletStability_zero (Ω : ℝ) :
    MolecularDynamics.Chapter04Review.matrixStable
      (MolecularDynamics.Chapter04Review.verletMatrix Ω 0) := by
  sorry



/-- 修正版，对应原文 MD-4-VerletStability。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem verletStability_corrected :
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 显式修订的严格稳定内区间及零步长；原印≤端点由MD-4-VerletBoundaryPrinted保留为疑误。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.verletStability`；`MD.Ch04.verletStability_zero`；`MD.Ch04.verletStability_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真正幂有界版本0<\|hΩ\|<2；原文≤2字面版另列待审。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条明确是严格稳定内区间的修订版本，另补h=0分支；原印含端点结论保留MD-4-VerletBoundaryPrinted待导师，不宣称与原句等价。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]真正幂有界版本0<|hΩ|<2；原文≤2字面版另列待审。；[EXTRA] 本条明确是严格稳定内区间的修订版本，另补h=0分支；原印含端点结论保留MD-4-VerletBoundaryPrinted待导师，不宣称与原句等价。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；两个签名分别为 0<|hΩ|<2 时的矩阵幂有界和任意 Ω 下 h=0 的幂有界；matrixStable 是同一 C 同时控制所有自然步数和所有实初值，非仅谱模≤1。verletMatrix 为实际速度Verlet矩阵。严格区间的正定二次型 p²+Ω²(1-h²Ω²/4)q²保持，h=0 为恒等矩阵，修订合理且陈述正确；PASS仅针对明示修订版，不认可原印≤端点。引用的 BoundaryPrinted 不在19条内，未据此宣称它已审。

### 7. 状态与证明位置

incomplete；`MD.Ch04.verletStability`：已证；`MD.Ch04.verletStability_zero`：未证（原书疑误不证）；`MD.Ch04.verletStability_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L128)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerBoundaryPrinted · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> if $h\Omega\le2$ the integrator is stable.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h) := by
  sorry



/-- 修正版，对应原文 MD-4-SymplecticEulerBoundaryPrinted。改动：幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。 -/
```

独立修正版：

```lean
theorem symplecticEulerBoundaryPrinted_corrected :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.symplecticEulerBoundaryPrinted`；`MD.Ch04.symplecticEulerBoundaryPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。 | [EXTRA] |

[EXTRA] [ERRATUM?] 幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 中 MolecularDynamics/Chapter04/ReviewDefinitions.lean 的正式定义：matrixStable(A)=∃C∈ℝ,∀k∈ℕ,∀v∈ℝ², ‖A^k v‖≤C‖v‖，是统一幂有界而不是仅谱模≤1；symplecticEulerMatrix(Ω,h)=[[1-h²Ω²,h],[-hΩ²,1]]；verletMatrix(Ω,h)=[[1-h²Ω²/2,h],[-hΩ²(1-h²Ω²/4),1-h²Ω²/2]]。 Ω>0和h>0是频率/步长背景的合理显式假设；≤2忠实保留印刷端点，但将稳定解释成matrixStable使印刷断言为假。[ERRATUM?]端点反例成立。忠实保留错误原句与数学真伪分别记录；声明含sorry，不能视作已证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.symplecticEulerBoundaryPrinted`：未证（原书疑误不证）；`MD.Ch04.symplecticEulerBoundaryPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L205)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-VerletBoundaryPrinted · unnumbered_claim · 印刷p.141 / PDFp.163

### 2. 原文陈述

> the numerical solution stays bounded for all time) provided $h\Omega\le2$

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h) := by
  sorry



/-- 修正版，对应原文 MD-4-VerletBoundaryPrinted。改动：幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。 -/
```

独立修正版：

```lean
theorem verletBoundaryPrinted_corrected :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.verletBoundaryPrinted`；`MD.Ch04.verletBoundaryPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。 | [EXTRA] |

[EXTRA] [ERRATUM?] 幂有界稳定区排除hΩ=2的Jordan端点，只保留0<hΩ<2。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 中 MolecularDynamics/Chapter04/ReviewDefinitions.lean 的正式定义：matrixStable(A)=∃C∈ℝ,∀k∈ℕ,∀v∈ℝ², ‖A^k v‖≤C‖v‖，是统一幂有界而不是仅谱模≤1；symplecticEulerMatrix(Ω,h)=[[1-h²Ω²,h],[-hΩ²,1]]；verletMatrix(Ω,h)=[[1-h²Ω²/2,h],[-hΩ²(1-h²Ω²/4),1-h²Ω²/2]]。 Ω>0和h>0是频率/步长背景的合理显式假设；≤2忠实保留印刷端点，但将稳定解释成matrixStable使印刷断言为假。[ERRATUM?]端点反例成立。忠实保留错误原句与数学真伪分别记录；声明含sorry，不能视作已证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.verletBoundaryPrinted`：未证（原书疑误不证）；`MD.Ch04.verletBoundaryPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L223)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-OscillatorSpectrum · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues are $\pm i\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem oscillatorSpectrum :
    ∀ Ω : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.oscillatorMatrix Ω).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ζ=Complex.I*Ω ∨ ζ= -Complex.I*Ω := by
  intro Ω ζ
  let A : Matrix (Fin 2) (Fin 2) ℂ := (MolecularDynamics.Chapter04Review.oscillatorMatrix Ω).map Complex.ofReal
  have heig : (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=0 := by
    rw [← Matrix.exists_mulVec_eq_zero_iff]
    simp only [Matrix.sub_mulVec, Matrix.smul_mulVec, Matrix.one_mulVec, sub_eq_zero]
    constructor
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
  have hd : (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=ζ^2+(Ω : ℂ)^2 := by
    simp [A, MolecularDynamics.Chapter04Review.oscillatorMatrix, Matrix.det_fin_two]
    push_cast
    ring
  change (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ _
  rw [heig,hd]
  have hf : ζ^2+(Ω : ℂ)^2=(ζ-Complex.I*Ω)*(ζ+Complex.I*Ω) := by
    ring_nf
    rw [Complex.I_sq]
    ring
  rw [hf,mul_eq_zero,sub_eq_zero,add_eq_zero_iff_eq_neg]
  simp only [neg_mul]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.oscillatorSpectrum` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀Ω∈ℝ、∀ζ∈ℂ，以非零复向量的实际特征方程定义谱，等价于 ζ=±iΩ。实矩阵 [[0,1],[-Ω²,0]] 正确，Ω=0 时谱集合退化为{0}，未误称可对角化或出现两个独立特征向量。

### 7. 状态与证明位置

self-contained；`MD.Ch04.oscillatorSpectrum`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L239)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerRoots · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues of the matrix are easily found, they are

$$
\lambda_{1,2}=1-\frac{h^2\Omega^2}{2}\pm\frac12\sqrt{h^4\Omega^4-4h^2\Omega^2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ∃ d : ℂ, d^2=(h^4*Ω^4-4*h^2*Ω^2 : ℝ) ∧
        (ζ=1-(h^2*Ω^2 : ℝ)/2+d/2 ∨ ζ=1-(h^2*Ω^2 : ℝ)/2-d/2) := by
  intro Ω h ζ
  let A : Matrix (Fin 2) (Fin 2) ℂ := (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal
  have heig : (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=0 := by
    rw [← Matrix.exists_mulVec_eq_zero_iff]
    simp only [Matrix.sub_mulVec, Matrix.smul_mulVec, Matrix.one_mulVec, sub_eq_zero]
    constructor
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
    · rintro ⟨v,hv,he⟩; exact ⟨v,hv,he.symm⟩
  have hchar : (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-A).det=ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1 := by
    simp [A, MolecularDynamics.Chapter04Review.symplecticEulerMatrix, Matrix.det_fin_two]
    push_cast
    ring
  change (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔ _
  rw [heig,hchar]
  constructor
  · intro he
    refine ⟨2*ζ-(2-h^2*Ω^2 : ℝ), ?_, Or.inl ?_⟩
    · push_cast at he ⊢
      linear_combination 4*he
    · push_cast
      ring
  · rintro ⟨d,hroot,(rfl|rfl)⟩ <;> push_cast at hroot ⊢ <;>
      linear_combination (1/4 : ℂ)*hroot
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.symplecticEulerRoots` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。 | [EXTRA] |

[EXTRA] 以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀Ω,h∈ℝ、∀ζ∈ℂ；左侧是实际复特征向量存在，右侧存在 d∈ℂ 满足 d²=h⁴Ω⁴-4h²Ω² 且 ζ=1-h²Ω²/2±d/2。存在式避免强制实平方根或主值分支，覆盖正、负、零判别式及重根。作为根集合结论完整，不额外声称重根的几何重数。

### 7. 状态与证明位置

self-contained；`MD.Ch04.symplecticEulerRoots`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L266)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerUnitRoots · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> Then we observe that for $h^2\Omega^2\le4$, they are complex and their squared magnitude is

$$
|\lambda_{1,2}|^2=\left(1-\frac{h^2\Omega^2}{2}\right)^2+\frac14(4h^2\Omega^2-h^4\Omega^4)=1,
$$


> thus both eigenvalues lie on the unit circle in the complex plane as long as $h\Omega\le2$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerUnitRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ, h^2*Ω^2 ≤ 4 →
      ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1=0 → ‖ζ‖=1 := by
  intro Ω h ζ ht he
  have hr := congrArg Complex.re he
  have hi := congrArg Complex.im he
  simp [pow_two, Complex.mul_re, Complex.mul_im] at hr hi
  have hz : (2*ζ.re-(2-h^2*Ω^2))*ζ.im=0 := by nlinarith [hi]
  have hn : ζ.re^2+ζ.im^2=1 := by
    rcases mul_eq_zero.mp hz with hz|hz
    · nlinarith [hr]
    · by_cases hpos : 0 ≤ ζ.re
      · have hab : 0 ≤ h^2*Ω^2*ζ.re := mul_nonneg (mul_nonneg (sq_nonneg h) (sq_nonneg Ω)) hpos
        have hs : (ζ.re-1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re-1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith
      · have hab : 0 ≤ (4-h^2*Ω^2)*(-ζ.re) := mul_nonneg (by linarith) (by linarith)
        have hs : (ζ.re+1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re+1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith
  have hnorm : ‖ζ‖^2=1 := by
    rw [Complex.sq_norm,Complex.normSq_apply]
    nlinarith [hn]
  nlinarith [norm_nonneg ζ]



/-- 修正版，对应原文 MD-4-SymplecticEulerUnitRoots。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticEulerUnitRoots_corrected :
    ∀ Ω h : ℝ, ∀ ζ : ℂ, h^2*Ω^2 ≤ 4 →
      ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1=0 → ‖ζ‖=1 := by
  intro Ω h ζ ht he
  have hr := congrArg Complex.re he
  have hi := congrArg Complex.im he
  simp [pow_two, Complex.mul_re, Complex.mul_im] at hr hi
  have hz : (2*ζ.re-(2-h^2*Ω^2))*ζ.im=0 := by nlinarith [hi]
  have hn : ζ.re^2+ζ.im^2=1 := by
    rcases mul_eq_zero.mp hz with hz|hz
    · nlinarith [hr]
    · by_cases hpos : 0 ≤ ζ.re
      · have hab : 0 ≤ h^2*Ω^2*ζ.re := mul_nonneg (mul_nonneg (sq_nonneg h) (sq_nonneg Ω)) hpos
        have hs : (ζ.re-1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re-1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith
      · have hab : 0 ≤ (4-h^2*Ω^2)*(-ζ.re) := mul_nonneg (by linarith) (by linarith)
        have hs : (ζ.re+1)^2=0 := by nlinarith [hr,sq_nonneg (ζ.re+1)]
        have hzre := sq_eq_zero_iff.mp hs
        nlinarith
  have hnorm : ‖ζ‖^2=1 := by
    rw [Complex.sq_norm,Complex.normSq_apply]
    nlinarith [hn]
  nlinarith [norm_nonneg ζ]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.symplecticEulerUnitRoots`；`MD.Ch04.symplecticEulerUnitRoots_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；∀Ω,h∈ℝ、∀ζ∈ℂ，在 h²Ω²≤4 及实际特征二次式为零的条件下 ‖ζ‖=1 正确，包括重根±1。借条目3明确连接到实际矩阵谱；未断言根非实、未把单位圆谱当幂有界。原模平方恒等式与该范数结论一致。

### 7. 状态与证明位置

self-contained；`MD.Ch04.symplecticEulerUnitRoots`：已证；`MD.Ch04.symplecticEulerUnitRoots_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L297)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerStability · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> This is the so-called linear stability condition of the Symplectic Euler method: if $h\Omega\le2$ the integrator is stable. When $h\Omega>2$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $2/\Omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerStability :
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) := by
  intro Ω h
  constructor
  · rintro ⟨hn,ht⟩
    obtain ⟨C,hC⟩ := verletStability Ω h hn ht
    let s : ℝ := h*Ω^2/2
    let P : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -s,1]
    let S : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; s,1]
    let A := MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h
    let B := MolecularDynamics.Chapter04Review.verletMatrix Ω h
    have hSP : S*P=1 := by
      ext i j; fin_cases i <;> fin_cases j <;>
        simp [S,P,Matrix.mul_apply,Fin.sum_univ_two]
    have hPA : P*A=B*P := by
      ext i j; fin_cases i <;> fin_cases j <;>
        simp [P,A,B,s,MolecularDynamics.Chapter04Review.symplecticEulerMatrix,
          MolecularDynamics.Chapter04Review.verletMatrix,Matrix.mul_apply,Fin.sum_univ_two] <;> ring
    have hp : ∀ k : ℕ, P*A^k=B^k*P := by
      intro k
      induction k with
      | zero => simp
      | succ k ih => rw [pow_succ',pow_succ',← mul_assoc,hPA,mul_assoc,ih,← mul_assoc]
    have hs : ∀ a : ℝ, ∀ v : Fin 2 → ℝ,
        ‖(!![1,0; a,1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ v‖ ≤ (1+|a|)*‖v‖ := by
      intro a v
      have h0 : |v 0| ≤ ‖v‖ := by simpa using norm_le_pi_norm v 0
      have h1 : |v 1| ≤ ‖v‖ := by simpa using norm_le_pi_norm v 1
      apply (pi_norm_le_iff_of_nonneg (by positivity)).mpr
      intro i
      fin_cases i
      · simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]
        nlinarith [mul_nonneg (abs_nonneg a) (norm_nonneg v)]
      · simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,vecHead,vecTail]
        change |a*v 0+v 1| ≤ (1+|a|)*‖v‖
        calc
          _ ≤ |a| * |v 0|+|v 1| := by simpa [abs_mul] using abs_add_le (a*v 0) (v 1)
          _ ≤ |a| * ‖v‖+‖v‖ := add_le_add (mul_le_mul_of_nonneg_left h0 (abs_nonneg a)) h1
          _ = _ := by ring
    refine ⟨(1+|s|)^2*|C|, ?_⟩
    intro k v
    have he : A^k *ᵥ v=S *ᵥ (B^k *ᵥ (P *ᵥ v)) := by
      have inner : B^k *ᵥ (P *ᵥ v)=(P*A^k) *ᵥ v := by rw [Matrix.mulVec_mulVec,hp k]
      rw [inner,Matrix.mulVec_mulVec,← mul_assoc,hSP,one_mul]
    rw [he]
    calc
      _ ≤ (1+|s|)*‖B^k *ᵥ (P *ᵥ v)‖ := hs s _
      _ ≤ (1+|s|)*(|C| * ‖P *ᵥ v‖) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        exact (hC k (P *ᵥ v)).trans (mul_le_mul_of_nonneg_right (le_abs_self C) (norm_nonneg _))
      _ ≤ (1+|s|)*(|C| * ((1+|s|)*‖v‖)) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        apply mul_le_mul_of_nonneg_left _ (abs_nonneg C)
        simpa [P,abs_neg] using hs (-s) v
      _ = _ := by ring
  · intro ht
    have ht2 : 4 < h^2*Ω^2 := by
      have hs := sq_lt_sq₀ (by norm_num : (0:ℝ) ≤ 2) (abs_nonneg (h*Ω))
      have hh : (2:ℝ)^2 < |h*Ω|^2 := hs.mpr ht
      norm_num [sq_abs,mul_pow] at hh ⊢
      exact hh
    let D : ℝ := h^4*Ω^4-4*h^2*Ω^2
    have hD : 0 < D := by dsimp [D]; nlinarith
    let d : ℝ := Real.sqrt D
    have hd : d^2=D := Real.sq_sqrt hD.le
    let ρ : ℝ := 1-h^2*Ω^2/2-d/2
    have hr : ρ < -1 := by dsimp [ρ,d]; nlinarith [Real.sqrt_nonneg D]
    have hv := (symplecticEulerRoots Ω h (ρ : ℂ)).mpr
      ⟨(d : ℂ),by exact_mod_cast hd,Or.inr (by dsimp [ρ]; push_cast; ring)⟩
    refine ⟨(ρ : ℂ), ?_, hv⟩
    rw [Complex.norm_real,Real.norm_eq_abs,abs_of_neg (by linarith)]
    linarith

theorem symplecticEulerStability_complete (Ω : ℝ) (_hΩ : 0 < Ω) :
    (sSup {h : ℝ | 0 < h ∧ MolecularDynamics.Chapter04Review.matrixStable
      (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)}=2/Ω) ∧
    (∀ h : ℝ, 2 < h*Ω →
      ∃ a b : ℝ, 0 < |a| ∧ |a| < 1 ∧ 1 < |b| ∧
        (∀ ζ : ℂ, (∃ v : Fin 2 → ℂ, v ≠ 0 ∧
          (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v=ζ • v) ↔
          ζ=(a : ℂ) ∨ ζ=(b : ℂ)) ∧
        ∃ v : Fin 2 → ℝ, v ≠ 0 ∧ ∀ k : ℕ,
          (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)^k *ᵥ v=b^k • v) := by
  sorry



/-- 修正版，对应原文 MD-4-SymplecticEulerStability。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticEulerStability_corrected :
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 修订的严格内区间、超阈值两实根/指数轨道及阈值上确界；原印含端点句由MD-4-SymplecticEulerBoundaryPrinted保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.symplecticEulerStability`；`MD.Ch04.symplecticEulerStability_complete`；`MD.Ch04.symplecticEulerStability_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正确的幂有界资格改为0<\|hΩ\|<2；原≤2字面版独立保留，未声称已审核修复。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 明确为修订稳定内区间结论；补超阈值实谱恰为一内一外非零实根、真实指数增长轨道及正步长稳定集合上确界2/Ω。原端点错误单列保留，未新增证明。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正确的幂有界资格改为0<|hΩ|<2；原≤2字面版独立保留，未声称已审核修复。；[EXTRA] 明确为修订稳定内区间结论；补超阈值实谱恰为一内一外非零实根、真实指数增长轨道及正步长稳定集合上确界2/Ω。原端点错误单列保留，未新增证明。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；首条在严格非零内区间给真实矩阵幂有界，在 2<|hΩ| 给实际复特征值在单位圆外。补充条要求 Ω>0，正步长稳定集合的实上确界为2/Ω；对任意超阈值 h，存在两个实根 a,b，0<|a|<1<|b|，完整谱等价式排除遗漏，并存在非零实初值满足所有 k 的 A^k v=b^k v。该精确轨道足以推出指数增长，不是仅有谱断言。修订范围和正频率条件已明示，陈述正确；PASS不认可原印端点。BoundaryPrinted 未随本任务给出，不纳入已审结论。

### 7. 状态与证明位置

incomplete；`MD.Ch04.symplecticEulerStability`：已证；`MD.Ch04.symplecticEulerStability_complete`：未证（原书疑误不证）；`MD.Ch04.symplecticEulerStability_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L355)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-PrintedImplicitRelation · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> The Implicit Midpoint method which, for the ODE $\dot z=f(z)$ takes the form

$$
z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)



/-- 修正版，对应原文 MD-4.1-PrintedImplicitRelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def printedImplicitRelation_corrected {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedImplicitRelation`；`MD.Ch04.printedImplicitRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；名称 printedImplicitRelation 标识字面版。∀维数、任意实向量场及实步长和两个实状态，关系 out=z+(h/2)(f(z)+f(out)) 正是原印梯形式，系数和端点函数值均正确。按任务只审忠实性，不要求把字面版改成真中点。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedImplicitRelation`：定义；`MD.Ch04.printedImplicitRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L456)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ActualMidpointRelation · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> The Implicit Midpoint method which, for the ODE $\dot z=f(z)$ takes the form

$$
z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def actualMidpointRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))



/-- 修正版，对应原文 MD-4.1-ActualMidpointRelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def actualMidpointRelation_corrected {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.actualMidpointRelation`；`MD.Ch04.actualMidpointRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖摘录 MolecularDynamics/Chapter04/ReviewDefinitions.lean: Q n = Fin n → ℝ，Z n = Q n × Q n；向量运算逐坐标。 实际定义为 Z=z+h f((z+Z)/2)，而指定原页给的是 Z=z+(h/2)(f(z)+f(Z))。[EXTRA] 已坦陈这是另行更正候选，合理用于比较，但不使其成为原页忠实陈述。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.actualMidpointRelation`：定义；`MD.Ch04.actualMidpointRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L468)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ImplicitFactor · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> can be applied to $\dot z=i\Omega z$ and yields

$$
z_{n+1}=\frac{1+ih\Omega/2}{1-ih\Omega/2}z_n.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))

theorem implicitFactor_update (Ω h : ℝ) (z out : ℂ) :
    (out=z+(h : ℂ)*(Complex.I*Ω*z+Complex.I*Ω*out)/2) ↔
      out=implicitFactor Ω h*z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.implicitFactor`；`MD.Ch04.implicitFactor_update` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；implicitFactor 对任意实 Ω,h 定义原复比值。implicitFactor\_update 对任意复 z,out 给印刷线性隐式更新与乘因子的双向等价；iΩ 的乘法、h/2 和 out 位置正确。分母实部为1，对这些域永不为零；无需增加分母假设。在线性场上梯形与中点一致。

### 7. 状态与证明位置

incomplete；`MD.Ch04.implicitFactor`：定义；`MD.Ch04.implicitFactor_update`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L479)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ImplicitModulus · unnumbered_claim · 印刷p.142 / PDFp.164

### 2. 原文陈述

> For all real $\Omega$, we find

$$
\left|\frac{1+ih\Omega/2}{1-ih\Omega/2}\right|=1.
$$


> This indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
  intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by simp
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr

theorem implicitModulus_iterates (Ω h : ℝ) (z : ℂ) (k : ℕ) :
    ‖(MolecularDynamics.Chapter04Review.implicitFactor Ω h)^k*z‖=‖z‖ := by
  sorry



/-- 修正版，对应原文 MD-4.1-ImplicitModulus。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem implicitModulus_corrected :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.implicitModulus`；`MD.Ch04.implicitModulus_iterates`；`MD.Ch04.implicitModulus_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。；[EXTRA] 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；对任意实 Ω,h 的模长等式及任意复初值、自然步数的范数保持均正确，且涵盖零频率零步长。[EXTRA] 明确限定纯虚标量模态，足以表达当前振子无步长稳定阈值；不把它推广为任意线性系统有界性。原书泛称仍交人工，不以缩域签名静默消除疑误。

### 7. 状态与证明位置

incomplete；`MD.Ch04.implicitModulus`：已证；`MD.Ch04.implicitModulus_iterates`：未证（原书疑误不证）；`MD.Ch04.implicitModulus_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L491)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-PrintedModifiedFrequency · definition · 印刷p.143 / PDFp.165

### 2. 原文陈述

> If the Implicit Midpoint method is viewed as the exact solution of a perturbed harmonic oscillator, then the frequency of this oscillator is

$$
\widehat\Omega=\frac1{ih}\ln\frac{1+ih\Omega/2}{1-ih\Omega/2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)



/-- 修正版，对应原文 MD-4.1-PrintedModifiedFrequency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def printedModifiedFrequency_corrected (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log (MolecularDynamics.Chapter04Review.implicitFactor Ω h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedModifiedFrequency`；`MD.Ch04.printedModifiedFrequency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；MD.Ch04.printedModifiedFrequency 展开为 (i h)⁻¹ * Complex.log factor，factor 的正式定义已查明。原文 ln 的分支未指定，这是需要裁定的原文问题，并非缺失项目定义。主支候选合理：有限实 x=hΩ/2 时 factor 的连续主相位为 2 atan x ∈ (-π,π)，与实频率解释相容；其他支给频率加 2πk/h。[EXTRA] 注释写 h≠0，但实际定义没有这一资格，Lean 总化逆元在 h=0 返回0；必须显式限制物理解读到非零步长。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedModifiedFrequency`：定义；`MD.Ch04.printedModifiedFrequency_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L522)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ModifiedFrequencyLimit · unnumbered_claim · 印刷p.143 / PDFp.165

### 2. 原文陈述

> The figure shows that the frequency is only well approximated in case $h\Omega$ is sufficiently small. For $h\Omega\gg1$ the frequency is highly modified.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω) := by
  intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num <;> ring
  convert hd.tendsto_slope_zero using 1
  funext t
  simp [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv]
  ring

def midpointFrequencyRatio (x : ℝ) : ℝ := 2*Real.arctan (x/2)/x

theorem modifiedFrequencyRatio_limits :
    Tendsto midpointFrequencyRatio (nhdsWithin 0 ({0}ᶜ)) (𝓝 1) ∧
    Tendsto midpointFrequencyRatio atTop (𝓝 0) ∧
    (∀ Ω h : ℝ, h*Ω ≠ 0 →
      MolecularDynamics.Chapter04Review.modifiedFrequency Ω h/Ω=midpointFrequencyRatio (h*Ω)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.modifiedFrequencyLimit`；`MD.Ch04.midpointFrequencyRatio`；`MD.Ch04.modifiedFrequencyRatio_limits` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。 | [EXTRA] |

[EXTRA] [EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。；[EXTRA] 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；modifiedFrequency=2 atan(hΩ/2)/h。∀实 Ω，沿去掉零点的 h→0 趋Ω；midpointFrequencyRatio 定义2 atan(x/2)/x，沿去零x→0趋1、x→+∞趋0；∀实Ω,h且hΩ≠0，频率比桥接正确。负频率和负步长均无代数问题。明确实连续相位，不在本条擅自断言任意复log分支或耦合系统误差估计。

### 7. 状态与证明位置

incomplete；`MD.Ch04.modifiedFrequencyLimit`：已证；`MD.Ch04.midpointFrequencyRatio`：定义；`MD.Ch04.modifiedFrequencyRatio_limits`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L534)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-MechanicalMidpoint · definition · 印刷p.144 / PDFp.166

### 2. 原文陈述

> we may reduce the equations to determining midpoint values $\widehat q,\widehat p$ such that

$$
\widehat q=q_n+\frac h2M^{-1}\widehat p,\qquad\widehat p=p_n-\frac h2\nabla U(\widehat q),
$$


> where, then,

$$
q_{n+1}=\widehat q+\frac h2M^{-1}\widehat p,\qquad p_{n+1}=\widehat p-\frac h2\nabla U(\widehat q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mechanicalMidpointRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖摘录 MolecularDynamics/Chapter04/ReviewDefinitions.lean: Q n = Fin n → ℝ，Z n = Q n × Q n；向量运算逐坐标。正式 grad U q = textbookConstraintGradient U q；在 MolecularDynamics/Chapter04/ConstrainedProjection.lean 展开后为 fun i => (fderiv ℝ U q) (Pi.single i 1)，是真实 Fréchet 偏导梯度。invMass m v = fun i => (m i)⁻¹*v i，是对角质量逆作用。 四个合取逐项对应 mid=(q̂,p̂)、z=(q\_n,p\_n)、out=(q_{n+1},p_{n+1})，全部正负号和 h/2 系数正确。没有交换量词或宣称解存在唯一。[EXTRA] 无新增假设；物理质量应正、势应可微，签名是代数关系的总化延伸，对合格对象限制后忠实；它没有声称任意不可微 U 的 fderiv 就是经典梯度。应明确记录此使用域，m=0 的逆元总化不代表物理质量逆。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mechanicalMidpointRelation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L554)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-MidpointElimination · unnumbered_claim · 印刷p.144 / PDFp.166

### 2. 原文陈述

> We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $\widehat p$, we find

$$
\widehat q=q_n+\frac h2M^{-1}p_n-\frac{h^2}{4}M^{-1}\nabla U(\widehat q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem midpointElimination :
  ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) h (z mid out : MolecularDynamics.Chapter04Review.Z n),
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m z.2-(h^2/4) • MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad U mid.1) := by
  intro n m U h z mid out hm
  rcases hm with ⟨hq,hp,houtq,houtp⟩
  calc
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 := hq
    _ = _ := by
      rw [hp]
      funext i
      simp [MolecularDynamics.Chapter04Review.invMass]
      ring

theorem midpointEulerHalfSteps (n : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z mid out : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out ↔
      (let f := fun w : MolecularDynamics.Chapter04Review.Z n ↦
        (MolecularDynamics.Chapter04Review.invMass m w.2,
          -MolecularDynamics.Chapter04Review.grad U w.1)
       mid=z+(h/2) • f mid ∧ out=mid+(h/2) • f mid) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.midpointElimination`；`MD.Ch04.midpointEulerHalfSteps` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。 | [EXTRA] |

[EXTRA] [EXTRA] 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n、质量函数、实势函数、实h、相空间 z,mid,out；以实际四关系为前提推出位置消元，并用同一机械向量场给隐式Euler半步后显式Euler半步的双向等价。Q和Z为有限实坐标及其乘积，grad 的 fderiv 坐标定义一致，invMass 是逐坐标乘质量倒数，故所需线性性成立。结论是关系代数式，不声称解存在、唯一或迭代收敛；对非物理质量或非光滑势的总化扩域也不使这两个代数命题变假，但不能据此解释为真实机械流。

### 7. 状态与证明位置

incomplete；`MD.Ch04.midpointElimination`：已证；`MD.Ch04.midpointEulerHalfSteps`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L561)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-SplitHamiltonian · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> In many molecular dynamics applications, the system may be decomposed as $H(q,p)=p^TM^{-1}p/2+U_S(q)+U_F(q)$ where $U_S$ is a “soft” potential, in which the natural motion would be relatively slow, whereas $U_F$ is a much stronger term which would give rise to relatively rapid motion.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.dot z.2 (MolecularDynamics.Chapter04Review.invMass m z.2)/2+US z.1+UF z.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.splitHamiltonian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；所读 /workspace/Ch04.lean 对应本报告逻辑路径 Blueprint/Ch04.lean；第398–399行的 MD.Ch04.splitHamiltonian 为本条实际声明。Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean 中，Q n=Fin n→ℝ，Z n=Q n×Q n，故 z.1=q、z.2=p；invMass m v 的第i分量为 (m i)⁻¹*v i，dot u v=∑i,u i*v i。完全展开后返回 (∑i,p\_i*(m\_i⁻¹*p\_i))/2+US(q)+UF(q)，在教材的正对角质量约定下正是 p^T M⁻¹p/2+US(q)+UF(q)。参数次序 n,m,US,UF,z 及势函数的配置空间自变量一致，没有遗漏公式项。定义对任意实 m 总化；m\_i=0 时的 Lean 逆元约定不能解释为物理质量矩阵的逆，但此定义没有声称这些非物理输入也是教材的系统。慢/快、软/强作为定性背景没有被改为虚构的数值假设。本条无 [EXTRA]、[ERRATUM?]。本条是无 sorry 的定义；PASS 是公式语义结论，未运行 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.splitHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L586)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-FastVerlet · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Let us $\mathcal G_h^F$ denote the map associated to the Verlet method for the system without $U_S$, using a stepsize $h$:

$$
\mathcal G_h^F=\mathrm e^{\frac h2\mathcal L_{U_F}}\mathrm e^{h\mathcal L_K}\mathrm e^{\frac h2\mathcal L_{U_F}},
$$


> where $\mathcal L_K$ is the Lie-derivative corresponding to the kinetic energy component of Hamiltonian $(K=p^TM^{-1}p/2)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h



/-- 本地核对网站缺摘录项：动量半kick、位置整drift、动量半kick。 -/

theorem fastVerlet_kick_drift_kick {n : ℕ} (m : Fin n → ℝ)
    (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) :
    fastVerlet m UF h z =
      let F := fun q => -MolecularDynamics.Chapter04Review.grad UF q
      let pHalf := z.2+(h/2) • F z.1
      let qNew := z.1+h • Chapter02Review.invMass m pHalf
      (qNew,pHalf+(h/2) • F qNew) := by
  let F := fun q => -MolecularDynamics.Chapter04Review.grad UF q
  have hq : z.1+h • Chapter02Review.invMass m z.2+
      (h^2/2) • Chapter02Review.invMass m (F z.1) =
      z.1+h • Chapter02Review.invMass m (z.2+(h/2) • F z.1) := by
    ext i
    simp [Chapter02Review.invMass]
    <;> ring
  dsimp only [fastVerlet, Chapter02Review.verlet]
  change (z.1+h • Chapter02Review.invMass m z.2+(h^2/2) • Chapter02Review.invMass m (F z.1),
    z.2+(h/2) • (F z.1+F (z.1+h • Chapter02Review.invMass m z.2+(h^2/2) • Chapter02Review.invMass m (F z.1)))) = _
  rw [hq]
  apply Prod.ext
  · rfl
  · ext i
    simp [F]
    <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.fastVerlet`；`MD.Ch04.fastVerlet_kick_drift_kick` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本地核验通过（网站因摘录缺失未判）；须与本章最终逐声明公理结果共同读取 | [EXTRA] |

[EXTRA] [EXTRA] 本地核验通过（网站因摘录缺失未判）；须与本章最终逐声明公理结果共同读取

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；n、实质量函数、实势和步长、Q/Z及负梯度力的类型和符号可核对。关键调用 Chapter02Review.verlet 的定义未在本条、依赖摘录或本任务其他条中给出；这是项目定义，不能按Mathlib直接采信。仅凭名字不能确认它是 kick(h/2)→drift(h)→kick(h/2)、质量放置及返回(q,p)次序，因此无法完成实际映射的全依赖审校。未读取任务禁止的旧工程，未据缺失材料推断函数错误。

### 7. 状态与证明位置

self-contained；`MD.Ch04.fastVerlet`：定义；`MD.Ch04.fastVerlet_kick_drift_kick`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L591)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-RESPA · (4.2) · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Now consider the map constructed by taking $r$ steps using $\mathcal G_{F,h/r}$ and composing this with kicks from the soft force:

$$
\mathcal G_h^{\mathrm{MTS}}=\mathrm e^{\frac h2\mathcal L_{U_S}}[\mathcal G_{h/r}^F]^r\mathrm e^{\frac h2\mathcal L_{U_S}}.
$$


> One step of the multiple timestepping algorithm is then implemented as follows:
> Reversible RESPA Algorithm

$$
P:=p-(h/2)\nabla U_S(q),\quad Q:=q;
$$


> Repeat $r$ times:

$$
P:=P-(h/2)\nabla U_F(Q)/r,\quad Q:=Q+hM^{-1}P/r,\quad P:=P-(h/2)\nabla U_F(Q)/r;\tag{4.2}
$$



$$
P:=P-(h/2)\nabla U_S(Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def respaTotalized {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))

def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (r : ℕ) (_hr : 0 < r) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.Z n := respaTotalized m US UF r h z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.respaTotalized`；`MD.Ch04.respa` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected\_json补回。 | [EXTRA] |

[EXTRA] r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。；[EXTRA] 总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected\_json补回。

### 6. 审计结论

本轮修复：总化辅助respaTotalized保留；主接口respa增加0<r。当前Blueprint没有主接口下游调用需调整；正式库旧辅助不改。已展开同版本Chapter02Review.verlet核对为kick(h/2)→drift(h)→kick(h/2)，桥接见FastVerlet本地核验记录。原文网站漏句按corrected\_json补回。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；r 声明为任意自然数，没有0<r或非零资格，和 extra\_assumptions 的 r为正自然数矛盾。正r时外层两次慢kick以及内部真实函数迭代的组合顺序正确；但r=0被Lean总化为跳过快步、连续两个慢半kick，已超出原文h/r与正细分数的域。另继承条目14未给出 Chapter02Review.verlet 定义的材料缺口。FAIL来自明确缺失的r资格，不来自sorry或无法检查的实现。

### 7. 状态与证明位置

self-contained；`MD.Ch04.respaTotalized`：定义；`MD.Ch04.respa`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L625)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-RESPAStructure · unnumbered_claim · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Because $U_F$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem respaStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z := by
  sorry



/-- 修正版，对应原文 MD-4.2.1-RESPAStructure。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem respaStructure_corrected :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.respaStructure`；`MD.Ch04.respaStructure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Ch04.lean 第412–416行量化 n、m、US、UF、r、h，要求所有 m\_i>0、US/UF 为 C²、r>0，然后结论为辛性与对所有 z 的 G_{−h}(G\_h(z))=z。所有依赖均已展开：Q n=Fin n→ℝ、Z n=Q n×Q n；dot u v=∑i u\_i v\_i；phaseForm(u,v)=dot(u.q,v.p)−dot(v.q,u.p)；symplecticMap G=∀z u v,phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)。respa、kick、fastVerlet、Chapter02Review.verlet、invMass、grad→textbookConstraintGradient 分别是两次软势半 kick 包住 r 次快势 Verlet、p↦p−t∇U、实际坐标梯度及质量 drift，不是把保辛或可逆结论预先塞入定义。n 到 h 的量词顺序没有隐藏依赖，h 可为任意实数；C²保证实际梯度的 C¹ 及 Hessian 对称。[EXTRA] 正质量与 r>0 是合理的物理/算法资格，C² 是保辛的合理充分正则性；反步恒等式本身并不需要 C²，且作为代数映射的辛性也不严格需要质量为正，只需所用对角 drift 的适当解释。它们没有制造错误结论。FAIL 的原因是当前 statement\_scope 明定仅覆盖所引原句及展示公式，而第167页这句话只是对称分裂的动机，没有断言任意 C² 势、任意步长下的全局 Jacobian 辛性与恒等式。注释把第171页的辛性及算法名称合并，扩大了来源与结论范围；[EXTRA] 可以标明补充假设，但不能自动使两项额外结论成为当前冻结原句的忠实陈述。此外 G_{−h}∘G\_h=id 表示步长反号的自伴性；若 Reversible 专指 R(q,p)=(q,−p) 的动量反射可逆，还应显式交代 R∘G\_h∘R=G_{−h}。该具体算法在这些正则性条件下的保结构命题数学上合理，此 FAIL 是来源/范围不匹配，没有声称已找到数学反例。本条无 [ERRATUM?]。第416行存在 sorry，证明仍未完成；范围 FAIL 不以 sorry 为理由，亦不把 sorry 当作命题为假的证据。

### 7. 状态与证明位置

incomplete；`MD.Ch04.respaStructure`：未证（原书疑误不证）；`MD.Ch04.respaStructure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L636)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-SlowMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> with

$$
S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅S\_h定义；合引中的F\_h由MD-4.2.1-FastMatrix承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.slowMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条明确只承担S\_h；同一展示中的F\_h由MD-4.2.1-FastMatrix承担，原合引文字保留。 | [EXTRA] |

[EXTRA] [EXTRA] 本条明确只承担S\_h；同一展示中的F\_h由MD-4.2.1-FastMatrix承担，原合引文字保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实h的2×2实矩阵[[1,0],[-h,1]]，作用于(q,p)列向量给(q,p-hq)，与质量1、U\_S=q²/2 的慢kick相符。未误把F\_h也算作本声明定义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.slowMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L657)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-FastMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> with

$$
S_h=\begin{bmatrix}1&0\\-h&1\end{bmatrix};\qquad F_h=\begin{bmatrix}\cos(\Omega h)&\Omega^{-1}\sin(\Omega h)\\-\Omega\sin(\Omega h)&\cos(\Omega h)\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅非零频率模型中的F\_h定义；S\_h由MD-4.2.1-SlowMatrix承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.fastMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] F\_h使用原Ω≫1模型的非零频率域，防止除零总化；S\_h由SlowMatrix承担，原展示不删。 | [EXTRA] |

[EXTRA] Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。；[EXTRA] F\_h使用原Ω≫1模型的非零频率域，防止除零总化；S\_h由SlowMatrix承担，原展示不删。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Ω,h∈ℝ且显式Ω≠0，矩阵对角cos(Ωh)，右上sin(Ωh)/Ω，左下-Ωsin(Ωh)，符号、坐标及分母正确。原Ω≫1背景允许推广至非零实Ω；正Ω频率是物理解释，并非本代数定义必须的附加资格。它是精确快流，不是单次Verlet。

### 7. 状态与证明位置

self-contained；`MD.Ch04.fastMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L662)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> In the limit of small inner step, we solve the system with Hamiltonian $H_F=p^2/2+\Omega^2q^2/2$ exactly, meanwhile punctuating with impulses from $U_S$, thus the MTS flow map approximation, which is linear in this case, can be written in the form of a matrix-vector multiply

$$
\begin{bmatrix}Q\\P\end{bmatrix}=W_h\begin{bmatrix}q\\p\end{bmatrix},\qquad W_h=S_{h/2}F_hS_{h/2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.impulseMatrix` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；实际 MD.Ch04.impulseMatrix 在 Ch04.lean 第427行；它使用的是依赖正式库中的 slowMatrix 与 fastMatrix，均已查体：S\_t=[[1,0],[−t,1]]，F\_h=[[cos(Ωh),sin(Ωh)/Ω],[−Ωsin(Ωh),cos(Ωh)]]。返回 Matrix (Fin 2) (Fin 2) ℝ 的乘积 S_{h/2}*F\_h*S_{h/2}；Matrix 乘法按列向量作用时右因子先作用，正是软势半 impulse、精确快振子流、软势半 impulse。任意输入 (q,p) 的输出是此矩阵乘该列向量，两分量次序与原页 [Q,P]^T 对齐，所有乘积因子和系数齐全。这里审核的是该理想 exact-inner-step 矩阵定义，原文 “In the limit of small inner step” 描述理想模型的选取，不含给定范数/收敛速率的独立极限定理；该 def 也没有把有限 r RESPA 矩阵与这个理想矩阵断言为相等。Ω 的解释域继承原 Ω≫1 模型，至少应取 Ω≠0；它没有声称除零总化后的 Ω=0 仍是精确快流。US=q²/2、UF=Ω²q²/2 与质量1已体现在查得的两个矩阵中，没有将一般势偷换成这些矩阵。本条无新增 [EXTRA] 或 [ERRATUM?]。定义无 sorry；本 PASS 是定义与模型公式的语义对应，不是对内步极限收敛或 Lean 编译的证明认证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.impulseMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L666)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseDet · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> Both of these matrices have unit determinant for any $h$, so the product of the eigenvalues of $W_h$ is $1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem impulseDet :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 ∧ (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 ∧ (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=1 := by
  intro Ω h hΩ
  simp only [MolecularDynamics.Chapter04Review.impulseMatrix, Matrix.det_mul]
  have hs : (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hs2 : (MolecularDynamics.Chapter04Review.slowMatrix (h/2)).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hf : (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.fastMatrix, Matrix.det_fin_two]
    field_simp
    nlinarith [Real.sin_sq_add_cos_sq (Ω*h)]
  exact ⟨hs,hf,by rw [hs2,hf]; norm_num⟩

theorem impulseDet_eigenvalueProduct (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ, a*b=1 ∧ ∀ ζ : ℂ,
      (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
          (ζ-a)*(ζ-b) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.impulseDet`；`MD.Ch04.impulseDet_eigenvalueProduct` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。 | [EXTRA] |

[EXTRA] Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。；[EXTRA] 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀实Ω,h且Ω≠0，实际S\_h、F\_h、W\_h三项det=1。依赖的Chapter04Review.fastMatrix本身无非零参数，但本定理前提已正确限制，勿与条目17的MD包装定义混淆。W=S(h/2)F(h)S(h/2) 次序正确。补充存在复a,b满足ab=1，且对所有复ζ的完整首一二次分解，绑定计重的两个根，不是任取两根，正确覆盖重根。

### 7. 状态与证明位置

incomplete；`MD.Ch04.impulseDet`：已证；`MD.Ch04.impulseDet_eigenvalueProduct`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L671)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseTrace · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> On the other hand, a short calculation shows that

$$
\lambda_1+\lambda_2=\operatorname{Tr}(W_h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) := by
  intro Ω h hΩ
  simp [MolecularDynamics.Chapter04Review.impulseMatrix, MolecularDynamics.Chapter04Review.slowMatrix,
    MolecularDynamics.Chapter04Review.fastMatrix, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]
  rw [mul_comm h Ω]
  ring

theorem impulseTrace_eigenvalueSum (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ,
      a+b=(2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) : ℝ) ∧
      (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=(ζ-a)*(ζ-b)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.impulseTrace`；`MD.Ch04.impulseTrace_eigenvalueSum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。 | [EXTRA] |

[EXTRA] Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。；[EXTRA] 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀实Ω,h且Ω≠0，实际W的trace为2cos(hΩ)-(h/Ω)sin(hΩ)。补充存在复a,b给同一完整特征二次式的所有ζ分解并约束a+b为该实trace的复嵌入，正确表达按代数重数的根和，未重复选择同一简单根。与条目18的根对未要求顺序相同，完整同一多项式分解已经保证根多重集相同。

### 7. 状态与证明位置

incomplete；`MD.Ch04.impulseTrace`：已证；`MD.Ch04.impulseTrace_eigenvalueSum`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L696)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonancePower · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> For example, at $h=\pi/\Omega$, we have

$$
F_h=-I\Rightarrow W_h=-S_{h/2}^2=-\begin{bmatrix}1&0\\-h&1\end{bmatrix},
$$


> so that

$$
W_h^n=(-1)^n\begin{bmatrix}1&0\\-nh&1\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1] := by
  intro Ω hΩ k
  have hne : Ω ≠ 0 := ne_of_gt hΩ
  have ha : Ω*(Real.pi/Ω)=Real.pi := by field_simp
  have hm : MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω)= -!![1,0; -(Real.pi/Ω),1] := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.impulseMatrix,MolecularDynamics.Chapter04Review.slowMatrix,MolecularDynamics.Chapter04Review.fastMatrix,Matrix.mul_apply,Fin.sum_univ_two,ha] <;> ring
  induction k with
  | zero =>
    ext i j
    fin_cases i <;> fin_cases j <;> norm_num
  | succ k hk =>
    rw [pow_succ,hk,hm,pow_succ]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,Nat.cast_add,Nat.cast_one] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonancePower` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω>0；所有自然数k，不止图中有限迭代。 | [EXTRA] |

[EXTRA] Ω>0；所有自然数k，不止图中有限迭代。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意实Ω>0及每个自然数k，结论是实际S(h/2)F(h)S(h/2)的矩阵幂，而非另一种Verlet矩阵。负号标量幂、左下角−kπ/Ω、k=0均正确。k=1给出W的展示式，F(π/Ω)=−I由给定fastMatrix直接化简；此中间式也出现在当前证明中。Ω>0是合理物理资格，不需Ω≫1的定量界。

### 7. 状态与证明位置

self-contained；`MD.Ch04.resonancePower`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L714)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceTaylor · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> We can see this by expanding $\mu(h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega)$ in a Taylor expansion around $h=\pi/\Omega$:

$$
\mu(h)=-2+\varepsilon,\qquad\varepsilon=\frac\pi\Omega(h-\pi/\Omega).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
  sorry



/-- 修正版，对应原文 MD-4.2.1-ResonanceTaylor。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem resonanceTaylor_corrected :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonanceTaylor`；`MD.Ch04.resonanceTaylor_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；固定每个Ω>0后才选择C、δ，二者允许依赖Ω；对整个双侧邻域以二次余项一致控制。实际trace的常数项为−2，一阶导数为π/Ω，故与截断Taylor的合理修正版一致；不是声称对所有Ω使用同一C。sorry仅表明未完成证明，不影响本次签名审校。

### 7. 状态与证明位置

incomplete；`MD.Ch04.resonanceTaylor`：未证（原书疑误不证）；`MD.Ch04.resonanceTaylor_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L737)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceInstability · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> Here both eigenvalues are real and one is outside the unit circle. There is thus a small interval of exponential instability directly below $h=\pi/\Omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonanceInstability :
  ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.impulseMatrix Ω h) := by
  sorry

theorem resonanceInstability_realSpectrum (Ω : ℝ) (_hΩ : 0 < Ω) :
    ∃ δ > 0, δ ≤ Real.pi/Ω ∧ ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω),
      ∃ a b : ℝ, 1 < max |a| |b| ∧
        (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
          (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
            (ζ-(a:ℂ))*(ζ-(b:ℂ))) ∧
        (∃ v : Fin 2 → ℝ, v ≠ 0 ∧
          ((1 < |a| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=a^k • v) ∨
           (1 < |b| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=b^k • v))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonanceInstability`；`MD.Ch04.resonanceInstability_realSpectrum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω>0；存在左邻域，每个h有真实复谱模>1。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补共振左邻域完整两实根分解、圆外根及实际指数轨道；δ≤π/Ω明确正步长。旧圆外复根结论保留。 | [EXTRA] |

[EXTRA] Ω>0；存在左邻域，每个h有真实复谱模>1。；[EXTRA] 补共振左邻域完整两实根分解、圆外根及实际指数轨道；δ≤π/Ω明确正步长。旧圆外复根结论保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两声明联合覆盖原句：旧声明给出真实复特征值及非零特征向量；realSpectrum在同一正步长左邻域给出实a,b、完整复特征多项式分解、至少一个模>1，以及对应非零实向量上的所有自然数次指数轨道。δ≤π/Ω避免负步长。det=1由已给矩阵定义决定，因此两根互为倒数。未把圆外性或指数轨道当作假设。

### 7. 状态与证明位置

incomplete；`MD.Ch04.resonanceInstability`：未证（缺大型理论）；`MD.Ch04.resonanceInstability_realSpectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L759)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceEigenPrinted · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> For $\varepsilon<0$, however, we have

$$
\lambda=-1\pm(|\varepsilon|/2)^{1/2}+O(\varepsilon).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonanceEigenPrinted :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)| ≤ C*|h-Real.pi/Ω| := by
  sorry



/-- 修正版，对应原文 MD-4.2.1-ResonanceEigenPrinted。改动：去掉平方根内错误因子1/2；本独立修正版仅一支特征根估计，完整双支谱分解列覆盖缺口。 -/
```

独立修正版：

```lean
theorem resonanceEigenPrinted_corrected :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|)| ≤ C*|h-Real.pi/Ω| := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonanceEigenPrinted`；`MD.Ch04.resonanceEigenPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 去掉平方根内错误因子1/2；本独立修正版仅一支特征根估计，完整双支谱分解列覆盖缺口。 | [EXTRA] |

[EXTRA] [ERRATUM?] 去掉平方根内错误因子1/2；本独立修正版仅一支特征根估计，完整双支谱分解列覆盖缺口。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Ch04\_deps.txt中-- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean的slowMatrix、fastMatrix、impulseMatrix（原文件行4418–4421）；分别为[[1,0],[-h,1]]、[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]和S(h/2)F(Ω,h)S(h/2)，对象与原文(q,p)列向量一致。 原印刷(|ε|/2)^(1/2)确有系数错误，[ERRATUM?]成立：令t=h₀−h>0、a=π/Ω，则μ=−2−at+O(t²)，根为−1±sqrt(at)+O(t)，不是−1±sqrt(at/2)+O(t)。Lean保留了错误的正支近似，任何根都不能满足该O(t)误差。另外原±两支均需刻画，签名只存在一根。Ω>0合理；先∃C,δ后∀h正确，但不能救错误系数。实际文件含sorry；FAIL由假命题及缺支造成，非因sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch04.resonanceEigenPrinted`：未证（原书疑误不证）；`MD.Ch04.resonanceEigenPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L778)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.2-MollifiedAverage · definition · 印刷p.149 / PDFp.171

### 2. 原文陈述

> The mapping $\mathcal A(q)$ is defined by reference to the fast dynamics, e.g. by the weighted average

$$
\mathcal A(q)=\frac1{K+1}\sum_{i=0}^K\phi_i\theta_i(q),
$$


> where the $\theta_i$ are defined recursively by solving the system with Hamiltonian

$$
H^{\mathrm{fast}}(q,p)=p^TM^{-1}p/2+U_F(q)
$$


> starting from initial position $q$ and zero initial momentum $p$, for $K$ timesteps using a small stepsize $\tau_f$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mollifiedAverage {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (K : ℕ) (w : ℕ → ℝ) (δ : ℝ) (q : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (1/(K+1 : ℝ)) • ∑ i ∈ Finset.range (K+1), w i • ((MolecularDynamics.Chapter04Review.fastVerlet m UF δ)^[i] (q,0)).1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mollifiedAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原未指定快积分器，以真实fastVerlet离散位置作为θi的具体实例；K+1项有限加权和，不假定权重任意都有效滤波。 | [EXTRA] |

[EXTRA] [EXTRA]原未指定快积分器，以真实fastVerlet离散位置作为θi的具体实例；K+1项有限加权和，不假定权重任意都有效滤波。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；结论：PASS，按已明示的[EXTRA]解释为原书加权构造的Verlet具体实例。实际附件是 /workspace/Ch04.lean；在 input\_sha256 中按请求使用逻辑键 Blueprint/Ch04.lean。以下为只读签名及定义审计，未编辑附件、未补证明、未将compact摘录作为独立工程编译。
对象与依赖展开：Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；invMass m p 的第j分量为(m j)⁻¹p j，即常对角质量矩阵的逆作用；grad U q=textbookConstraintGradient U q。后者在 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean 定义为 j↦(fderiv ℝ U q)(Pi.single j 1)，不是未知或抽象力。fastVerlet m UF δ=Chapter02Review.verlet m (fun q=>−grad UF q) δ；继续展开 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 的同型Q、Z、invMass和verlet，得到 q⁺=q+δM⁻¹p−(δ²/2)M⁻¹grad UF(q)，p⁺=p−(δ/2)(grad UF(q)+grad UF(q⁺))。因此这是快Hamiltonian pᵀM⁻¹p/2+UF(q)的velocity-Verlet离散位置序列。
量词、初态及结果：隐式n:ℕ，显式参数m、UF、K:ℕ、w:ℕ→ℝ、δ:ℝ、q；固定前述参数后得到仅依赖q的映射。θ\_i(q)=((fastVerlet m UF δ)^[i](q,0)).1，θ\_0=q；Finset.range(K+1)恰给i=0,…,K，w i对应φ\_i，外部因子1/(K+1)与原式一致。δ就是平均过程的小步长参数，没有被强制等同于RESPA内步长，符合原页上下文。
[EXTRA]评估：原书只说 recursively by solving 及 e.g.，未指定快积分器；选择Verlet合理，但不是原文要求或唯一方案，必须保留该实例说明。有限加权和不要求权重和为K+1，也未宣称任意权重都有滤波效果。签名不限制δ为小正数、质量为正或UF光滑，是总函数定义的代数扩展；其物理积分器解释使用正质量、可微势及适当小正步长，不能据此把全部参数称为有效物理滤波器。这里没有关于有效性、收敛性或精确流的定理结论，故该总定义扩展不造成此条结论错误。
[ERRATUM?]：本条没有该标注；原页所选公式未发现需要勘误之处。证明状态：本项是def，主体无sorry；不据此声称滤波性能已证明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mollifiedAverage`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L801)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.2-MollifiedPotential · definition · 印刷p.148–149 / PDFp.170–171

### 2. 原文陈述

> Effectively, one replaces $U_S(q)$ wherever it appears within the MTS method by a modified potential function $\overline U(q)\stackrel{\mathrm{def}}=U_S(\mathcal A(q))$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mollifiedPotential {n : ℕ} (US : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) := US ∘ A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mollifiedPotential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；US:Q n→ℝ与A:Q n→Q n的复合，逐点恰为US(A(q))，维数一致，既未换成US(q)也未额外断言滤波效果或守恒性。此处只是修改势的定义，不需要把前后段的A加权构造并入定义签名。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mollifiedPotential`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L806)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceLinearRate · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> and the norm of the solution will oscillate and grow linearly with $n$ as $n\to\infty$. This is the simplest type of linear resonance present in multiple timestepping.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonanceLinearRate : ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
    atTop (𝓝 (|(Real.pi/Ω)*z 0|)) := by
  intro Ω hΩ z hz
  let c : ℝ := (Real.pi/Ω)*z 0
  let w : ℕ → Fin 2 → ℝ := fun k => ![z 0/(k : ℝ),z 1/(k : ℝ)-c]
  have ht : Tendsto w atTop (𝓝 (![0,-c] : Fin 2 → ℝ)) := by
    apply tendsto_pi_nhds.mpr
    intro i
    fin_cases i
    · simpa [w] using tendsto_const_div_atTop_nhds_zero_nat (z 0 : ℝ)
    · simpa [w] using (tendsto_const_div_atTop_nhds_zero_nat (z 1 : ℝ)).sub_const c
  have hn : ‖(![0,-c] : Fin 2 → ℝ)‖=|c| := by
    apply le_antisymm
    · apply (pi_norm_le_iff_of_nonneg (abs_nonneg c)).mpr
      intro i
      fin_cases i <;> simp
    · simpa using (norm_le_pi_norm (![0,-c] : Fin 2 → ℝ) 1)
  have he : (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
      =ᶠ[atTop] fun k => ‖w k‖ := by
    filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
    have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
    have hp := resonancePower Ω hΩ k
    have hv : (!![1,0; -(k : ℝ)*(Real.pi/Ω),1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ z
        = (k : ℝ) • w k := by
      ext i
      fin_cases i <;> simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,w,c] <;> field_simp [hk0] <;> ring
    rw [hp,Matrix.smul_mulVec,hv,norm_smul,norm_smul]
    simp [Real.norm_eq_abs,abs_pow,abs_of_nonneg ((Nat.cast_nonneg k : (0 : ℝ) ≤ (k : ℝ))),hk0]
  simpa only [hn,c] using (ht.norm.congr' he.symm)




/-- 修正版，对应原文 MD-4.2.1-ResonanceLinearRate。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem resonanceLinearRate_corrected : ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
    atTop (𝓝 (|(Real.pi/Ω)*z 0|)) := by
  intro Ω hΩ z hz
  let c : ℝ := (Real.pi/Ω)*z 0
  let w : ℕ → Fin 2 → ℝ := fun k => ![z 0/(k : ℝ),z 1/(k : ℝ)-c]
  have ht : Tendsto w atTop (𝓝 (![0,-c] : Fin 2 → ℝ)) := by
    apply tendsto_pi_nhds.mpr
    intro i
    fin_cases i
    · simpa [w] using tendsto_const_div_atTop_nhds_zero_nat (z 0 : ℝ)
    · simpa [w] using (tendsto_const_div_atTop_nhds_zero_nat (z 1 : ℝ)).sub_const c
  have hn : ‖(![0,-c] : Fin 2 → ℝ)‖=|c| := by
    apply le_antisymm
    · apply (pi_norm_le_iff_of_nonneg (abs_nonneg c)).mpr
      intro i
      fin_cases i <;> simp
    · simpa using (norm_le_pi_norm (![0,-c] : Fin 2 → ℝ) 1)
  have he : (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖/(k : ℝ))
      =ᶠ[atTop] fun k => ‖w k‖ := by
    filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
    have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
    have hp := resonancePower Ω hΩ k
    have hv : (!![1,0; -(k : ℝ)*(Real.pi/Ω),1] : Matrix (Fin 2) (Fin 2) ℝ) *ᵥ z
        = (k : ℝ) • w k := by
      ext i
      fin_cases i <;> simp [Matrix.mulVec,dotProduct,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,w,c] <;> field_simp [hk0] <;> ring
    rw [hp,Matrix.smul_mulVec,hv,norm_smul,norm_smul]
    simp [Real.norm_eq_abs,abs_pow,abs_of_nonneg ((Nat.cast_nonneg k : (0 : ℝ) ≤ (k : ℝ))),hk0]
  simpa only [hn,c] using (ht.norm.congr' he.symm)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonanceLinearRate`；`MD.Ch04.resonanceLinearRate_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]选实际Pi最大范数给出精确正线性率；q0≠0，否则此增长结论不成立。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]选实际Pi最大范数给出精确正线性率；q0≠0，否则此增长结论不成立。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Ch04\_deps.txt中-- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean的slowMatrix、fastMatrix、impulseMatrix（原文件行4418–4421）；分别为[[1,0],[-h,1]]、[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]和S(h/2)F(Ω,h)S(h/2)，对象与原文(q,p)列向量一致。 Ω>0与q₀=z 0≠0合理且q₀≠0对正增长必要。Fin 2→ℝ的范数是max(|q|,|p|)，故极限为|h₀q₀|>0，定量地保留了线性增长；量词先Ω、再所有合格初值，没有假设增长本身。可是所引句还声称范数oscillate，签名没有该子句，且原句对范数的字面表述不成立。该签名适合作为明确纠正措辞后的线性率定理，不能判为所引全部原句忠实编码。实际文件有证明体、无sorry，本次未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.resonanceLinearRate`：已证；`MD.Ch04.resonanceLinearRate_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L811)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceGrowth · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> and the norm of the solution will oscillate and grow linearly with $n$ as $n\to\infty$. This is the simplest type of linear resonance present in multiple timestepping.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem resonanceGrowth :
  ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop := by
  intro Ω hΩ z hz
  have hc : 0 < |(Real.pi/Ω)*z 0| := abs_pos.mpr (mul_ne_zero (div_ne_zero Real.pi_ne_zero (ne_of_gt hΩ)) hz)
  have hr := resonanceLinearRate Ω hΩ z hz
  have ht := hr.pos_mul_atTop hc (tendsto_natCast_atTop_atTop (R := ℝ))
  apply ht.congr'
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
  have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  exact div_mul_cancel₀ _ hk0




/-- 修正版，对应原文 MD-4.2.1-ResonanceGrowth。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem resonanceGrowth_corrected :
  ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop := by
  intro Ω hΩ z hz
  have hc : 0 < |(Real.pi/Ω)*z 0| := abs_pos.mpr (mul_ne_zero (div_ne_zero Real.pi_ne_zero (ne_of_gt hΩ)) hz)
  have hr := resonanceLinearRate Ω hΩ z hz
  have ht := hr.pos_mul_atTop hc (tendsto_natCast_atTop_atTop (R := ℝ))
  apply ht.congr'
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
  have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  exact div_mul_cancel₀ _ hk0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅非零q初值轨道发散推论；完整线性率见MD-4.2.1-ResonanceLinearRate，带(-1)^k的精确幂见MD-4.2.1-ResonancePower，norm振荡措辞待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.resonanceGrowth`；`MD.Ch04.resonanceGrowth_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条明确为发散推论；线性率由MD-4.2.1-ResonanceLinearRate、交替幂公式由MD-4.2.1-ResonancePower承担，原norm振荡疑误在LinearRate待导师，不删句。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。；[EXTRA] 本条明确为发散推论；线性率由MD-4.2.1-ResonanceLinearRate、交替幂公式由MD-4.2.1-ResonancePower承担，原norm振荡疑误在LinearRate待导师，不删句。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；当前声明对Ω>0、q₀≠0确实正确地断言Pi最大范数趋于无穷；然而它仅是发散推论，签名本身不表达线性率或振荡。EXTRA明确把线性率分配给本批未提供的ResonanceLinearRate，不能将那一外部声明视作本条已审通过。原句把解的交替符号说成范数振荡，且缺少q₀≠0，应保留并人工裁决。

### 7. 状态与证明位置

self-contained；`MD.Ch04.resonanceGrowth`：已证；`MD.Ch04.resonanceGrowth_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L881)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.2-MollifiedStructure · unnumbered_claim · 印刷p.149 / PDFp.171

### 2. 原文陈述

> In each of the mollified multiple timestepping methods, since only the potential energy is modified, and by a smooth mapping of positions, the forces derived by differentiating $\overline U$ are still conservative, and, just as with the MTS method, the scheme remains symplectic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mollifiedStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (MolecularDynamics.Chapter04Review.mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m (MolecularDynamics.Chapter04Review.mollifiedPotential US A) UF r h) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mollifiedStructure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。 | [EXTRA] |

[EXTRA] 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；结论：PASS，针对实际RESPA/Verlet实现及任意C²位置映射；原文的两项结构结论均可由所用真实定义读取，不靠名称或sorry判断。实际附件是 /workspace/Ch04.lean；在 input\_sha256 中按请求使用逻辑键 Blueprint/Ch04.lean。以下为只读签名及定义审计，未编辑附件、未补证明、未将compact摘录作为独立工程编译。
全部对象与量词顺序：∀n:ℕ、m:Fin n→ℝ、US UF:Q n→ℝ、A:Q n→Q n、r:ℕ、h:ℝ，随后依次假设∀i,0<m i、ContDiff ℝ 2 US、ContDiff ℝ 2 UF、ContDiff ℝ 2 A、0<r。结论为链式法则与辛性之合取；链式法则再对所有q,v:Q n量化。h未被要求为小正数，无隐藏依赖顺序或先假设结论。
复合势与保守力展开：库 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean 的mollifiedPotential US A=US∘A，Q n=Fin n→ℝ。第一合取为D(US∘A)(q)[v]=DUS(A(q))[DA(q)[v]]。同文件grad U q=textbookConstraintGradient U q，而 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean 的后者逐分量给出DU(q)[e\_i]。kick U t(q,p)=(q,p−t grad U(q))，故实际慢力F\_i(q)=−D(US∘A)(q)[e\_i]=−DUS(A(q))[DA(q)e\_i]，即全局标量势的负梯度。原文 conservative 虽未单独引入谓词，但实际力及其势的关系已被这些定义直接表达，未漏用DA，也未把力保守作为前提。
算法展开：respa m U UF r h(q,p)=kick U(h/2)((fastVerlet m UF(h/r))^[r](kick U(h/2)(q,p)))，其中U=US∘A。fastVerlet=Chapter02Review.verlet m(−grad UF)；展开 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 的verlet及invMass，给出q⁺=q+tM⁻¹p−t²M⁻¹grad UF(q)/2和p⁺=p−t(grad UF(q)+grad UF(q⁺))/2。快势和快步未被复合映射替换，只有慢势kick使用复合势，符合原页紧接着的 only applied ... modifying the slow impulse 的解释。任意C²的A覆盖本批所谈位置映射，不要求A为可逆映射、辛映射或平均构造。
辛性结论展开：同一库文件Z n=Q n×Q n，dot a b=Σ\_i a\_i b\_i，phaseForm(u,v)=Σ\_i u\_qi v\_pi−Σ\_i v\_qi u\_pi。symplecticMap G真正声明∀z,u,v，phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)，即标准辛形式的实际Fréchet导数拉回。该算法在给定C²假设下有C¹梯度和C¹更新，故不存在靠不可微点的fderiv默认值空洞表达辛性的情形。此处不是只检验行列式或抽象性质。
[EXTRA]逐项评估：正质量为原物理常质量的合理资格，数学上非零质量已足够，正性不是最弱假设；US、UF、A的C²确保复合势C²、梯度C¹及Hessian对称，是保结构所需的合理充分光滑性，比原 smooth 的无限光滑要求更弱而不损失该结论；r>0保证自然数细分及h/r有实际步数意义，排除了无快步的r=0退化情形，虽该退化代数映射也可单独保辛。上述条件均未假设待证链式法则、保守性或辛性。以实际RESPA和fastVerlet表达是批次明确采用的实现范围，不声称证明了未指定的任意快积分器也辛。
[ERRATUM?]：本条无该标注，所引原文未发现需要改写的数学错误。证明状态独立记录：Ch04.lean中mollifiedStructure的证明体是by sorry；依赖Statements.lean的mollifiedStructure\_statement只是对应Prop定义。PASS仅指签名和展开后语义忠实，不表示证明已完成或编译验证通过。

### 7. 状态与证明位置

incomplete；`MD.Ch04.mollifiedStructure`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L911)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-HolonomicRelation · (4.3) · 印刷p.149–150 / PDFp.171–172

### 2. 原文陈述

> In this section we consider holonomic constraints which may be expressed in terms of positions only, and perhaps time, i.e.

$$
g(q,t)=0.\tag{4.3}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.holonomicRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；g的位置参数为Q n、显式时间参数为ℝ、值为Q l；沿给定位置曲线对每个实时间要求g(q(t),t)=0。没有独立动量参数或错误地删除显式时间依赖。它是全实轴曲线满足完整约束的定义，不是声称任意曲线均满足约束。

### 7. 状态与证明位置

self-contained；`MD.Ch04.holonomicRelation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L919)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-TimeConstraintDerivative · unnumbered_claim · 印刷p.150 / PDFp.172

### 2. 原文陈述

> Note that by differentiating (4.3) with respect to time, we obtain $\nabla_q g(q,t)\cdot\dot q+\partial g/\partial t=0$ which involves velocities.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem timeConstraintDerivative :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0 := by
  intro n l g q t v hg hq hz
  have hp : HasDerivAt (fun s : ℝ => (q s,s)) (v,1) t := hq.prodMk (hasDerivAt_id t)
  have hd : HasDerivAt (fun s => g (q s) s)
      ((fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)) t :=
    hg.hasFDerivAt.comp_hasDerivAt (f := fun s : ℝ => (q s,s)) t hp
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz
  exact hd.unique hzero
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.timeConstraintDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。 | [EXTRA] |

[EXTRA] g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 Function.uncurry g 的对象是位置×时间；量词为任意 n,l,g,q,t,v，依次要求联合可微、q 在 t 的实际导数为 v、局部约束恒等于零，结论为 Dg(q(t),t)(v,1)=0。该结论按线性性展开正是 D\_qg·q̇+∂_tg=0；联合可微和曲线可微是原文链式求导所需的合理 [EXTRA]，局部恒零足以且比全时恒零弱，没有把所求结论作前提。Ch04.lean:576–587 给出链式法则和导数唯一性证明，无 sorry；本结论仍为签名审计而非编译验证。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.timeConstraintDerivative`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L924)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstrainedSolution · (4.4)–(4.9) · 印刷p.152 / PDFp.174

### 2. 原文陈述

> the equations of motion may be written

$$
\dot q=M^{-1}p,\tag{4.4}
$$



$$
\dot p=-\nabla U(q)-\sum_{k=1}^l\lambda_k\nabla g_k(q),\tag{4.5}
$$



$$
0=g_j(q),\quad j=1,2,\ldots,l.\tag{4.6}
$$


> then we may write the constrained equations of motion in the form

$$
\dot q=M^{-1}p,\quad\text{(4.7)}\qquad\dot p=-\nabla U(q)-g'(q)^T\lambda,\quad\text{(4.8)}\qquad0=g(q).\quad\text{(4.9)}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

def constrainedSolution_generalForce {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedSolution`；`MD.Ch04.constrainedSolution_generalForce` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。 | [EXTRA] |

[EXTRA] [EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主定义在开时间域I逐时要求真实HasDerivAt：q′=m⁻¹p、p′=−grad U−Gᵀρ及每个标量约束为零。m分量严格正、U及所有g\_j可微都显式给出；grad和G来自实际Fréchet导数，矩阵转置乘法正是逐约束求和。ρ是待检验曲线的参数而非已假设存在的乘子。generalForce允许任意F及within导数，作为明确命名的辅助定义保留合理；一般域包含退化域，因此不可单独当经典运动的主接口。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedSolution`：定义；`MD.Ch04.constrainedSolution_generalForce`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L939)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintSet · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> Constraints such as those described above define a manifold in the configuration space $\mathcal M=\{q\mid g(q)=0\}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry



/-- 修正版，对应原文 MD-4.3-ConstraintSet。改动：修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。 -/
```

独立修正版：

```lean
theorem constraintSet_corrected (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintSet`；`MD.Ch04.constraintSet_regularLevel`；`MD.Ch04.constraintSet_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。 | [EXTRA] |

[EXTRA] 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。；[EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；零点集合定义忠实。regularLevel在l≤n、各g\_j光滑、q为零点及真实向量导数满射的EXTRA条件下给出开邻域、双向光滑互逆坐标、q映至0及前l个坐标为零的完整等价，确实是余维l局部嵌入流形正规形。∞用于C∞符合目标。修正版签名正确，但原句未注明正则性即泛称流形，不能用增加前提消除原书疑误。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constraintSet`：定义；`MD.Ch04.constraintSet_regularLevel`：未证（原书疑误不证）；`MD.Ch04.constraintSet_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L961)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-CotangentSet · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> The set of pairs $(q,p)$ satisfying, simultaneously, the equations

$$
g(q)=0,\qquad g'(q)M^{-1}p=0,
$$


> is called the co-tangent bundle associated to the manifold $\mathcal M$, and we refer to it as $T^*\mathcal M$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentSet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量及独立梯度为几何解释资格。 | [EXTRA] |

[EXTRA] 正质量及独立梯度为几何解释资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 定义的元素确为相空间中的(q,p)，两个且仅两个集合成员条件逐分量展开为 g(q)=0 与 g′(q)M⁻¹p=0；未漏掉同时满足要求。原文在这里用这两个等式命名其嵌入相空间的余切集合，该集合实现忠实，不能据此宣称已经构造抽象余切丛。正质量保证质量逆的物理解释，梯度独立和光滑性保证基底流形及通常余切丛解释；[EXTRA] 为这些解释资格而非成员条件中额外过滤条件，合理。任意 m,g 的总化扩展不能单独承载上述几何解释，但不改变本条所给集合等式。定义无 sorry。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cotangentSet`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L998)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintJacobian · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> It is often convenient to combine all the constraints and to describe them by a single vector-valued function $g:\mathbb R^{N_c}\to\mathbb R^l$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i

def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintJacobian`；`MD.Ch04.combineConstraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 在同一source\_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。 | [EXTRA] |

[EXTRA] [EXTRA] 在同一source\_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；combineConstraints把Fin l族标量函数按q↦(j↦g\_j(q))组合成Q n→Q l，完整覆盖原句。constraintJacobian的行j列i为真实Fréchet导数在第i个基向量上的取值，尺寸l×n，作为相邻(4.8)的附加对象已被EXTRA区分；没有只交付Jacobian而遗漏向量函数。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintJacobian`：定义；`MD.Ch04.combineConstraints`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1003)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-JacobianActualDerivative · unnumbered_claim · 印刷p.152 / PDFp.174

### 2. 原文陈述

> Given a motion $(q(t),p(t),\lambda(t))$ of (4.7)–(4.9) we note that $g(q(t))\equiv0$ at all times $t$, hence, by differentiation

$$
g'(q(t))\dot q(t)\equiv0,
$$


> which we may rephrase as

$$
g'(q(t))M^{-1}p(t)\equiv0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem jacobianActualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap := by
  apply MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative <;> assumption

theorem jacobianActualDerivative_curve (n l : ℕ)
    (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (p v : MolecularDynamics.Chapter04Review.Q n) (t : ℝ)
    (_hg : ∀ j, DifferentiableAt ℝ (g j) (q t)) (_hq : HasDerivAt q v t)
    (_hv : v=MolecularDynamics.Chapter04Review.invMass m p)
    (_hc : ∀ᶠ s in 𝓝 t, ∀ j, g j (q s)=0) :
    textbookConstraintJacobian g (q t) *ᵥ v=0 ∧
    textbookConstraintJacobian g (q t) *ᵥ MolecularDynamics.Chapter04Review.invMass m p=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.jacobianActualDerivative`；`MD.Ch04.jacobianActualDerivative_curve` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。 | [EXTRA] |

[EXTRA] [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。；[EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；首声明在各标量函数于q可微时把实际Jacobian等同向量函数Fréchet导数的标准矩阵。curve声明在任意时刻t、实际速度v、v=m⁻¹p及邻域内所有约束恒零的前提下，同时给出Gv=0和Gm⁻¹p=0。局部邻域恒零是从完整运动中抽取的足够条件；未循环假设隐藏约束。只需速度方程，不需无关的加速度/乘子前提。

### 7. 状态与证明位置

incomplete；`MD.Ch04.jacobianActualDerivative`：已证；`MD.Ch04.jacobianActualDerivative_curve`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1015)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintDegrees · unnumbered_claim · 印刷p.151 / PDFp.173

### 2. 原文陈述

> Note that with $l$ constraints the actual number of degrees of freedom, which is needed for things like the computation of temperature, is $N_d=N_c-l$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constraintDegrees :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l) (q : MolecularDynamics.Chapter04Review.Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n := by
  intro n l g q hg hs
  have hh := LinearMap.finrank_range_add_finrank_ker (fderiv ℝ g q).toLinearMap
  rw [LinearMap.range_eq_top.mpr hs] at hh
  simpa [add_comm] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintDegrees` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。 | [EXTRA] |

[EXTRA] [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 量词依次为维数 n,l、真实向量约束 g 和点 q，再给可微及真实导数满射条件；结论 dim ker Dg+l=n 等价于独立约束下 Nd=Nc−l。满射保证 l≤n，避免自然数截断伪装维数关系；没有把维数关系作为前提。原文未显式说独立约束，但这是自由度公式必要而合理的 [EXTRA]，例如重复约束不应重复扣减。当前结论是线性化可行速度空间的维数；如进一步声称零集为光滑流形，还需合适邻域光滑性，当前定理不含此额外几何声称。Ch04.lean:621–630 的证明用秩零化度公式，无 sorry。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintDegrees`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1035)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-FlexiblePendulumHamiltonian · definition · 印刷p.150 / PDFp.172

### 2. 原文陈述

> We suppose the restraint to have an associated coefficient $k=\varepsilon^{-1}$, where $\varepsilon$ is a small parameter. Then we have a generalized flexible pendulum with Hamiltonian $H=\|p\|^2/(2m)+U(q)+\varepsilon^{-1}(\|q\|-r_0)^2/2$ (see the left panel of Fig. 4.4).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.flexiblePendulumHamiltonian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Position 3按附件定义为EuclideanSpace ℝ (Fin 3)，所以动量和位置均用欧氏范数。z.1是q、z.2是p，动能分母2m、势能U(q)、弹簧项ε⁻¹(‖q‖−r₀)²/2均正确。作为总化的数值表达式定义可接受所有实参数；物理使用应限m>0、ε>0及通常r₀>0，此定义未宣称零参数也构成物理模型。

### 7. 状态与证明位置

self-contained；`MD.Ch04.flexiblePendulumHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1045)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-RestraintPotential · definition · 印刷p.150 / PDFp.172

### 2. 原文陈述

> where the restraint potential $\varphi_\varepsilon(q)=\varepsilon^{-1}(\|q\|-r_0)^2/2$ has associated restoring force

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def restraintPotential (ε r₀ : ℝ) (q : Position 3) : ℝ :=
  ε⁻¹*(‖q‖-r₀)^2/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.restraintPotential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:636–637；Position 3 展开为 EuclideanSpace ℝ (Fin 3)，势为 ε⁻¹(‖q‖−r₀)²/2，与 PDF172 相同。这里只定义函数，未宣称在 q=0 可微或光滑；无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.restraintPotential`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1050)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-RestraintForcePrinted · unnumbered_claim · 印刷p.150 / PDFp.172

### 2. 原文陈述


$$
F_\varepsilon=-\nabla\varphi_\varepsilon(q)=\varphi_\varepsilon(q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem restraintForcePrinted :
    ∀ ε r₀ : ℝ, ∀ q : Position 3,
      -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q =
       gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q := by
  sorry



/-- 修正版，对应原文 MD-4.3-RestraintForcePrinted。改动：独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。 -/
```

独立修正版：

```lean
def restraintForcePrinted_corrected (ε r₀ : ℝ) (_hε : 0 < ε) (q : Position 3) : Position 3 :=
  -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.restraintForcePrinted`；`MD.Ch04.restraintForcePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将prime暂按配置梯度解释；该记号解释待审。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。 | [EXTRA] |

[EXTRA] [EXTRA]将prime暂按配置梯度解释；该记号解释待审。；[ERRATUM?] 独立定义物理恢复力为势能负梯度；不保留原书把标量势与向量力相等的类型混淆为可证定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Ch04.lean:642–647 实际量化所有 ε,r₀,q 并断言 −gradient φ q = gradient φ q。原 PDF172 的末项是 φε(q)，没有 prime，且 φ 为标量、力为向量，原书确有类型疑误。[EXTRA] 把 prime 解释为配置梯度既无原文依据，也产生错误等式。[ERRATUM?] 应改为原书的标量势/向量力疑误，不能把缺失的 prime 当成原书问题。Position 是欧氏空间；gradient 为真实总梯度，光滑点不是任意符号。该声明另有 sorry，但 FAIL 来自签名。

### 7. 状态与证明位置

incomplete；`MD.Ch04.restraintForcePrinted`：未证（原书疑误不证）；`MD.Ch04.restraintForcePrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1057)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstrainedPendulum · definition · 印刷p.151 / PDFp.173

### 2. 原文陈述

> The equations of motion for the constrained system take the form

$$
\dot q=v,\qquad\dot v=-\nabla U(q)-q\lambda,\qquad0=\|q\|^2-r_0^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0



/-- 修正版，对应原文 MD-4.3-ConstrainedPendulum。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def constrainedPendulum_corrected (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedPendulum`；`MD.Ch04.constrainedPendulum_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。；[EXTRA] 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；按本页字面三个方程核对：真实欧氏q,v曲线，q′=v、v′=−gradient U−λq、‖q‖²−r₀²=0，开I使within导数等同普通导数，均忠实。原前页仍保留一般质量m，本页加速度式未说明单位质量或势的重新归一化；把因子2吸收到λ可行，但吸收质量不能同时消除势力中的1/m。另U未附可微资格，gradient作为标准总化算子时，只有可微U才是经典势力语义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedPendulum`：定义；`MD.Ch04.constrainedPendulum_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1073)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintCurvature · definition · 印刷p.153 / PDFp.175

### 2. 原文陈述

> where $\varphi$ is an $l$-dimensional vector whose $k$th component is

$$
\varphi_k=p(t)^TM^{-1}\nabla_q^2g_k(q(t))M^{-1}p(t).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def constraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintCurvature` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；Ch04.lean:657–661；textbookInverseMassMatrix 展开为 diagonal (fun i => (m i)⁻¹)。因此每分量是 D²γ\_j(q)[M⁻¹p,M⁻¹p]，正是 pᵀM⁻¹ Hessian(γ\_j) M⁻¹p（对角质量矩阵对称）。Fin Mc 表示 l 个分量，q,p 为当前时间切片。Pi 的范数不影响有限维坐标导数及此双线性计算，未使用错误的径向 Pi 范数。fderiv 是总操作；这一定义不声称非光滑约束也具有经典 Hessian。无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintCurvature`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1089)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ReactionMultiplier · definition · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Using (4.8) in (4.10) we obtain

$$
g'(q)M^{-1}[F-g'(q)^T\lambda]+\varphi\equiv0.
$$


> This is a system of linear equations for $\lambda$. Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\lambda$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def reactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | [EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.reactionMultiplier` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] [EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 不将无条件总化定义报告成唯一求解结论。 | [EXTRA] |

[EXTRA] [EXTRA] [EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 不将无条件总化定义报告成唯一求解结论。

### 6. 审计结论

本轮修复：[EXTRA] 逆Gram候选公式定义（含奇异点的总化）；原句在det≠0时解平衡方程及唯一性由MD-4.3-ReactionBalance和MD-4.3-GramInvertible共同覆盖。 不将无条件总化定义报告成唯一求解结论。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；reactionMultiplier给出的逆Gram公式代数符号、各域及曲率二阶导数正确，但这是对任意m、γ、q,p,F总化的函数定义。本条statement\_scope仍声称覆盖所引全部原句，而本条同source\_id并没有det≠0条件下满足线性方程或唯一可解的命题。其它条目的reactionBalance及gramInvertible\_multiplier可补这一逻辑内容，但不能冒充本条定义本身已含条件性求解结论。

### 7. 状态与证明位置

self-contained；`MD.Ch04.reactionMultiplier`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1096)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ReactionBalance · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Using (4.8) in (4.10) we obtain

$$
g'(q)M^{-1}[F-g'(q)^T\lambda]+\varphi\equiv0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reactionBalance {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) (hdet : (textbookConstraintGram m γ q).det ≠ 0) :
    textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (F q - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookConstrainedReactionMultiplier m γ F q p)) +
        textbookConstraintCurvature m γ q p = 0 := by
  apply MolecularDynamics.textbookConstrainedReaction_balance <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.reactionBalance` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。 | [EXTRA] |

[EXTRA] 真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对所有有限维m、γ、F,q,p，在真实Gram行列式非零条件下断言由逆Gram构造的乘子使G M⁻¹(F−Gᵀλ)+φ=0。φ由实际迭代Fréchet二阶导数沿v=M⁻¹p两次评价，次序无误。此命题是代数平衡，不宣称任意非光滑γ也具有经典Hessian；用于机械系统时再取光滑约束。一般F推广已标明，F=−grad U可实例化。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.reactionBalance`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1105)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-GramPositive · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\lambda$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gramPositive {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).PosDef := by
  apply MolecularDynamics.textbookConstraintGram_posDef <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅约束Gram正定的EXTRA充分条件辅助；原句解乘子由MD-4.3-GramInvertible承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.gramPositive` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。 | [EXTRA] |

[EXTRA] [EXTRA]原假设的可检验充分条件：质量正且真实约束梯度线性独立；正定作为结论。；[EXTRA] 仅为正质量/梯度独立推出正定的充分条件辅助；原句可解且唯一的完整乘子结论由MD-4.3-GramInvertible补全，原文不删。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限Nc,Mc，严格正的每个质量以及真实梯度族的实线性独立，推出G diag(m⁻¹) Gᵀ正定。对于非零a，二次型为Σ\_i m\_i⁻¹(Σ\_j a\_j G\_ji)²，独立性保证至少一项非零；这验证充分条件，不把正定当作前提。statement\_scope已明确仅为EXTRA辅助；原句乘子可解内容由第16条单独完整承担。零维情形与标准正定语义相容。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.gramPositive`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1116)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-GramInvertible · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\lambda$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gramInvertible {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    (textbookConstraintGram m γ q).det ≠ 0 := by
  apply MolecularDynamics.textbookConstraintGram_det_ne_zero <;> assumption

theorem gramInvertible_multiplier (n l : ℕ) (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q F : MolecularDynamics.Chapter04Review.Q n) (φ : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    (∃! lam : MolecularDynamics.Chapter04Review.Q l,
      textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ∧
    (∀ lam : MolecularDynamics.Chapter04Review.Q l,
      (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m
        (F-(textbookConstraintJacobian g q)ᵀ *ᵥ lam)+φ=0) ↔
      lam=(textbookConstraintGram m g q)⁻¹ *ᵥ
        (textbookConstraintJacobian g q *ᵥ MolecularDynamics.Chapter04Review.invMass m F+φ)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.gramInvertible`；`MD.Ch04.gramInvertible_multiplier` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]质量正及梯度独立推出真实Gram det≠0；不是将该结论作为前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。 | [EXTRA] |

[EXTRA] [EXTRA]质量正及梯度独立推出真实Gram det≠0；不是将该结论作为前提。；[EXTRA] 保留原可逆性充分条件证明，补det≠0下反力乘子唯一可解及明确逆Gram公式；F和φ是给定线性方程数据，不把所求λ作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；gramInvertible由正质量和真实梯度独立推出实际Gram det≠0；multiplier在原本的det≠0前提下，对任意维数及给定q,F,φ同时给出存在唯一λ与所有λ的方程↔逆Gram公式。invMass与实际对角逆质量矩阵相同，线性方程整理为Gram λ=G m⁻¹F+φ，正负号及转置正确。F、φ作为给定右端数据而非所求解，不要求把λ存在作为假设；未因sorry判失败。

### 7. 状态与证明位置

incomplete；`MD.Ch04.gramInvertible`：已证；`MD.Ch04.gramInvertible_multiplier`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1126)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-CotangentInvariant · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Reinserting this expression for $\lambda$ into (4.8) then gives a system of ordinary differential equations whose solutions, starting from a point on $T^*\mathcal M$, will remain on $T^*\mathcal M$ for all time. The co-tangent bundle becomes an invariant manifold of this ODE system. $\lambda$ is defined at any time by the physical variables $q$ and $p$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentInvariant {Nc Mc : ℕ}
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
      (fderiv ℝ (γ j) (q t)) (textbookInverseMassMatrix m *ᵥ p t) = 0 := by
  apply MolecularDynamics.textbookConstrainedODE_cotangent_invariant_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定闭区间实际ODE解、C²约束、正质量及沿解梯度独立；“for all time”仅在实际解定义区间，不声称任意长时域解存在。 | [EXTRA] |

[EXTRA] 给定闭区间实际ODE解、C²约束、正质量及沿解梯度独立；“for all time”仅在实际解定义区间，不声称任意长时域解存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；在给定实际q,p曲线的Icc 0 τ上，正质量、每个约束C²、沿解梯度独立保证Gram可逆；hq和hp是代入实际逆Gram乘子的ODE，初始位置约束与隐藏约束分别显式给定。结论对每个区间时刻及每个约束同时保持两条件，恰为该余切集合不变性。τ<0时区间空而结论真，τ=0由初值，均无反例。仅在给定解存在区间断言保持是合理的for all time解释，不声称全局解存在；F不必保守，作为更一般力的推广应补标EXTRA。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentInvariant`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1149)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ReducedFieldRegularity · unnumbered_claim · 印刷p.153 / PDFp.175

### 2. 原文陈述

> Reinserting this expression for $\lambda$ into (4.8) then gives a system of ordinary differential equations

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reducedFieldRegularity
    {Nc Mc : ℕ} (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (z : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) z.1)) :
    ContDiffAt ℝ 1 (textbookConstrainedPhaseVectorField m γ U) z := by
  apply MolecularDynamics.contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.reducedFieldRegularity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C³约束/C¹位置力、质量正、真实梯度独立给局部C¹场；是隐含正则性的独立补充，不冒充构造流存在。 | [EXTRA] |

[EXTRA] [EXTRA]C³约束/C¹位置力、质量正、真实梯度独立给局部C¹场；是隐含正则性的独立补充，不冒充构造流存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意自然数 Nc、Mc，质量 m:Fin Nc→ℝ、Mc 个实值位置约束 γ、势 U 及相点 z=(q,p)，前提为逐项正质量、U 全局 C²、γ\_j 全局 C³，以及真实坐标梯度在 q 处线性独立；结论恰为代入反作用乘子后的相空间向量场在 z 处 C¹。所给依赖将逆质量实现为 diag(1/m\_i)，Jacobian 的第 j 行实现为 Dγ\_j，Gram 为 GM^{-1}G^T，曲率为 D²γ\_j[M^{-1}p,M^{-1}p]，乘子为 Gram^{-1}(GM^{-1}F+φ)，动量分量为 F−G^Tλ，符号及对象相符。上述正则性和质量/独立性均有 [EXTRA] 说明，确保局部逆矩阵有意义；本定理是所引 ODE 构造的局部正则性补充，没有声称已构造流、证明约束不变或证明全时存在。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.reducedFieldRegularity`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1166)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-RestrictedForm · definition · 印刷p.153 / PDFp.175

### 2. 原文陈述

> The simplifying concept that we exploit is that the symplectic $2$-form in the ambient space can be projected to the co-tangent bundle to define an associated symplectic form on the manifold.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def restrictedForm {n : ℕ} (chart : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (z u v : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)

theorem restrictedForm_nondegenerate (n l : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (z : MolecularDynamics.Chapter04Review.Z n)
    (_hz : ∀ j, g j z.1=0)
    (_hp : textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0)
    (_hind : LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1)) :
    let c := fun w : MolecularDynamics.Chapter04Review.Z n ↦
      ((fun j ↦ g j w.1), textbookConstraintJacobian g w.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m w.2)
    let T := (fderiv ℝ c z).ker
    ∀ u ∈ T, (∀ v ∈ T, MolecularDynamics.Chapter04Review.phaseForm u v=0) → u=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.restrictedForm`；`MD.Ch04.restrictedForm_nondegenerate` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。 | [EXTRA] |

[EXTRA] [EXTRA] 保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；restrictedForm 对任意 n、chart:Z n→Z n 及 z,u,v 定义 B(Dchart(z)u,Dchart(z)v)，输出实数；这是一般形式表达式，定义可总化，不暗含 chart 是坐标图、浸入或辛映射。补充定理对任意 n,l,m,g,z，在 m\_i>0、g\_j∈C²、g(z.q)=0、G(z.q)M^{-1}z.p=0、真实约束梯度独立的前提下，令 T=ker Dc(z)，完整结论为每个 u∈T 若与全部 v∈T 的标准二形式配对均为零，则 u=0。该结论是限制形式的非退化，量词次序和两个实际约束均正确。正质量与梯度独立使 GM^{-1}G^T 可逆，正是这一限制非退化的充分资格。一般拉回与实际切空间非退化分别陈述是合理的代数表述；不额外宣称抽象流形、闭性或任意 chart 的非退化已经由此定义构造。sorry 不影响本次签名结论。

### 7. 状态与证明位置

incomplete；`MD.Ch04.restrictedForm`：定义；`MD.Ch04.restrictedForm_nondegenerate`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1176)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-VariationalFormula · unnumbered_claim · 印刷p.154 / PDFp.176

### 2. 原文陈述

> Next, we interchange time derivatives and differentials, and use the chain rule to write

$$
\frac{\mathrm d}{\mathrm dt}\mathrm dq=M^{-1}\mathrm dp,\tag{4.11}
$$



$$
\frac{\mathrm d}{\mathrm dt}\mathrm dp=-U''(q)\mathrm dq-\sum_{k=1}^l[(\mathrm d\lambda_k)\nabla g_k(q)+\lambda_kg_k''\mathrm dq],\tag{4.12}
$$



$$
0=g_j'(q)\mathrm dq,\quad j=1,2,\ldots,l,\tag{4.13}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem variational :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry

theorem variational_constraints :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    ∀ (c : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ),
    c t=z → HasDerivAt c v t →
    (∀ᶠ s in 𝓝 t, ∀ j, g j (c s).1=0) →
    (∀ j, (fderiv ℝ (g j) z.1) v.1=0) ∧
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.variational`；`MD.Ch04.variational_constraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际Fréchet变分场：U/g C²、乘子ρ(z)可微；切向dg=0由tangentPhase/拉回消去条另保留，不把它漏掉或作无条件全空间结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。 | [EXTRA] |

[EXTRA] 实际Fréchet变分场：U/g C²、乘子ρ(z)可微；切向dg=0由tangentPhase/拉回消去条另保留，不把它漏掉或作无条件全空间结论。；[EXTRA] 保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两条声明均量化 n,l、对角质量 m、势 U、l 个约束 g、状态依赖乘子 rho、相点 z 与方向 v。U/g 的 C² 和 rho 在 z 可微保证实际场 X(q,p)=(M^{-1}p,−∇U(q)−G(q)^Tρ(q,p)) 可微。结论的第一分量为 M^{-1}v\_p，第二分量为 −D∇U(q)v\_q−Σ\_j[(Dρ(z)v)_j∇g\_j(q)+ρ\_j(z)D∇g\_j(q)v\_q]；每个求和域、方向、符号及乘子微分均与 (4.11)–(4.12) 的链式法则内容对应。variational 本身没有无条件声称 Gv\_q=0；variational\_constraints 通过 c(t)=z、HasDerivAt c v t 和邻域内 g\_j((c s).q)=0，另得 ∀j,Dg\_j(q)v\_q=0，并与相同的完整场导数公式合取，覆盖 (4.13)。质量只出现在固定线性映射中，代数导数公式无需再假设正质量。此为变分方程的场导数表述，未额外声称构造了随时间的变分解。

### 7. 状态与证明位置

incomplete；`MD.Ch04.variational`：未证（缺大型理论）；`MD.Ch04.variational_constraints`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1194)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-HessianPullbackCancel · unnumbered_claim · 印刷p.155 / PDFp.177

### 2. 原文陈述

> This follows from the antisymmetry of the wedge product $(\mathrm dx\wedge\mathrm dy=-\mathrm dy\wedge\mathrm dx)$, and the fact that the Hessian matrix of $U$ is symmetric. Next, note that

$$
\sum_{i=1}^{N_c}\sum_{k=1}^{l}\mathrm dq_i\wedge\lambda_k\sum_{j=1}^{N_c}(g_k^{\prime\prime})_{ij}\mathrm dq_j=\sum_{k=1}^{l}\lambda_k\sum_{i=1}^{N_c}\mathrm dq_i\wedge\sum_{j=1}^{N_c}(g_k^{\prime\prime})_{ij}\mathrm dq_j=0,
$$


> by the same reasoning, since each of $g_k^{\prime\prime}$ is a symmetric matrix. Finally

$$
\sum_{i=1}^{N_c}\sum_{k=1}^{l}[\mathrm dq_i\wedge(\mathrm d\lambda_k)g_{ki}^{\prime}=\sum_{k=1}^{l}\left(\sum_{i=1}^{N_c}g_{ki}^{\prime}\mathrm dq_i\right)\wedge\mathrm d\lambda_k=\sum_{k=1}^{l}\mathrm dg_k\wedge\mathrm d\lambda_k=0,
$$


> since we know that $\mathrm dg_k=0$ from (4.13). Therefore

$$
\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^{N_c}\mathrm dq_i\wedge\mathrm dp_i=0.
$$



### 3. 原文证明

原书无独立完整证明。
原页给出逐项消去推导，并由 Leibniz 规则得到完整二形式的时间导数为零；不是单列编号定理。原书 Finally 后首个双重求和有未闭合的排印方括号，本摘录按原页保留。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hessianPullbackCancel {Nc Mc : ℕ}
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
          (fun y => textbookPotentialForce U (q y))) x) u i * (fderiv ℝ q x) v i) = 0 := by
  apply MolecularDynamics.textbookConstrainedAcceleration_pullback_zero <;> assumption

theorem hessianPullbackCancel_time (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (ρ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j)) (_hρ : ContDiff ℝ 1 ρ)
    (γ u v : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ)
    (_hγ : HasDerivAt γ
      (MolecularDynamics.Chapter04Review.invMass m (γ t).2,
       -MolecularDynamics.Chapter04Review.grad U (γ t).1-(textbookConstraintJacobian g (γ t).1)ᵀ *ᵥ ρ (γ t)) t)
    (_hu : HasDerivAt u ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (u t)) t)
    (_hv : HasDerivAt v ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (v t)) t)
    (_htu : ∀ j, (fderiv ℝ (g j) (γ t).1) (u t).1=0)
    (_htv : ∀ j, (fderiv ℝ (g j) (γ t).1) (v t).1=0) :
    HasDerivAt (fun s ↦ MolecularDynamics.Chapter04Review.phaseForm (u s) (v s)) 0 t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.hessianPullbackCancel`；`MD.Ch04.hessianPullbackCancel_time` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 完整实际C²势/约束、可微乘子和切向位置图；前文各消去项在已证正式库有限和展开中保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。 | [EXTRA] |

[EXTRA] 完整实际C²势/约束、可微乘子和切向位置图；前文各消去项在已证正式库有限和展开中保留。；[EXTRA] 保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；第一条对任意 Nc、Mc、势 U、约束族 γ，以及 E 上的位置参数化 q 和逐分量乘子 ρ，在 U/γ 为 C²、q/ρ 在 x 可微、γ\_j∘q 局部为零的前提下，陈述 Dq(u)·DA(v)−DA(u)·Dq(v)=0；给定 textbookMultiConstrainedMomentum 的实际定义使 A=−∇U(q)−Σρ\_j∇γ\_j(q)，并非未经说明的假动量。第二条对任意 n,l,m,U,g、C¹ 乘子 ρ，以及时间曲线 γ,u,v 和时刻 t，显式假定 γ 的动力学导数、u/v 的线性变分导数和两者的位置切向条件，完整结论为 HasDerivAt(s↦phaseForm(u(s),v(s))) 0 t。phaseForm 的两个位置/动量配对均保留；逆质量项因对角对称性抵消，势与各约束 Hessian 因对称性抵消，乘子微分项由两条切向条件抵消。无需正质量即可得到此固定对角映射的消去恒等式。第二条只在给定 t 陈述导数零，不自行推出全局流存在；对每一时刻应用才得到源文沿流守恒的通常解释。E 的类型类环境没有在摘录中展开，本轮依 fderiv 所要求的实赋范向量空间语义审查，未运行或宣称编译验证。sorry 不构成失败。

### 7. 状态与证明位置

incomplete；`MD.Ch04.hessianPullbackCancel`：已证；`MD.Ch04.hessianPullbackCancel_time`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1223)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.1-ConstrainedFlowPullback · unnumbered_claim · 印刷p.156 / PDFp.178

### 2. 原文陈述

> Thus we see that the projected version of the symplectic form in the ambient space is conserved by the differential equation system (4.7)–(4.9). This is what is meant by saying that the constrained system is analogous to a Hamiltonian system. We may also think of its flow map as being a symplectic map of the co-tangent bundle.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedFlowPullback {Nc Mc : ℕ}
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
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) v) := by
  apply MolecularDynamics.textbookConstrainedFlow_pullback_constant_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedFlowPullback` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定joint C²的真实流/时间区间、C³约束及C²势、正质量/独立梯度；完整条件见桥接签名，不假设辛性结论。 | [EXTRA] |

[EXTRA] 给定joint C²的真实流/时间区间、C³约束及C²势、正质量/独立梯度；完整条件见桥接签名，不假设辛性结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；展开 textbookCotangentChart q p=Sum.elim q p，SymplecticCoordinates=(Fin Nc⊕Fin Nc)→ℝ，textbookJ=[0,I;−I,0]，textbookSymplecticForm=J.toBilin′，坐标值 Σᵢ(u.qᵢv.pᵢ−u.pᵢv.qᵢ)。InverseMassMatrix=diag(mᵢ⁻¹)，Gⱼᵢ=Dγⱼ(q)eᵢ，Gram=GM⁻¹Gᵀ；Curvatureⱼ=D²γⱼ(q)[M⁻¹p,M⁻¹p]，ReactionMultiplier=Gram⁻¹(GM⁻¹F+Curvature)，F=−grad U。PhaseVectorField=(M⁻¹p,F−GᵀReactionMultiplier)，符号与 (4.7)–(4.9) 相合。Φ 是给定联合 C² 解族；对区间全部 t、全部 y 要求 ODE 和梯度独立，初始位置/隐藏约束全保留；x,u,v 任意，结论恰为各时刻相对于 t=0 的二形式拉回相等。无需 Φ(0,y)=y：允许任意初始约束图，等式本身正是沿流保持该图的拉回形式，换成初始局部坐标即原句。它不声称构造全局流、逆映射或流形非退化定理，原文这里的辛映射表述按形式保持解释。正质量/独立梯度保证 Gram 可逆；联合 C²、C³约束/C²势是充分且合理的技术加强，非最低必要条件，没有将辛性作为前提。Icc 0 τ 只覆盖正向所给区间；τ<0 时为空，不能解释为负时守恒。对应这一局部守恒签名 PASS；无本条 [ERRATUM?]。正文调用依赖同名桥接定理，无显式 sorry；未做编译验证，此 PASS 仅为只读签名语义审计。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.constrainedFlowPullback`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1259)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-PositionEulerPrinted · (4.14)–(4.16) · 印刷p.156 / PDFp.178

### 2. 原文陈述

> A simple example of such a method is the constrained Symplectic Euler-like method

$$
q_{n+1}=q_n+hM^{-1}p_{n+1},\tag{4.14}
$$



$$
p_{n+1}=p_n-hF_n-hg'(q_n)^T\lambda_n,\tag{4.15}
$$



$$
0=g(q_{n+1}).\tag{4.16}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2-h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.positionEulerPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:782–786 的 Prop 恰记录三式，合取换序不改变含义；rho=λₙ，z=(qₙ,pₙ)，out=(qₙ₊₁,pₙ₊₁)。它是关系而非存在唯一性断言，不要求非零步长或隐约束成立。[ERRATUM?] 与书中其他力符号确有冲突；若Fₙ解释为∇U则此式自洽，不能仅从本页断言必须改负号。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.positionEulerPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1281)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-PositionEulerForceConvention · definition · 印刷p.156 / PDFp.178

### 2. 原文陈述

> A simple example of such a method is the constrained Symplectic Euler-like method

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.2-PositionEulerForceConvention。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def positionEulerRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2 ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.positionEulerRelation`；`MD.Ch04.positionEulerRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:789–793 只给任意 F 的 +hF 更新；没有 F=−grad U 的约束，也没有 F\_printed=−F 的参数转换。额外说明属于改变力参数或修订原式，不能作为同一F下的额外假设消除负号差异。原句仅命名方法，不能证明改号公式忠实。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.positionEulerRelation`：定义；`MD.Ch04.positionEulerRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1289)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-HiddenEulerError · unnumbered_claim · 印刷p.156 / PDFp.178

### 2. 原文陈述

> The hidden constraint $g'(q_0)M^{-1}p_0=0$ will be violated, but one hopes it remains approximately satisfied. The justification for the latter assumption is that if we expand $g$ in a Taylor series, we may write

$$
g(q_n)\approx g(q_{n+1})+g'(q_{n+1})(q_n-q_{n+1}).
$$


> Then since we maintain $g(q_n)=0$ for all $n$, we have

$$
g'(q_{n+1})M^{-1}p_{n+1}\approx0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hiddenEulerError :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (out : ℝ → MolecularDynamics.Chapter04Review.Z n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 out → out 0=z →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, MolecularDynamics.Chapter04Review.positionEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (out h) (rho h)) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      ‖textbookConstraintJacobian g (out h).1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (out h).2‖ ≤ C*h := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.hiddenEulerError` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。 | [EXTRA] |

[EXTRA] C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:796–803 全称量化固定旧状态z及真实out(h),rho(h)，随后给存在C,δ及全体0<h<δ的O(h)界。依赖4445–4448展开为+ h(−grad U)动量更新、q(h)=q₀+h invMass p(h)、全部位置约束。区间含0且out(0)=z，故初位置合法已蕴含；对位置恒等式在0求导并对g(q(h))=0求导得初隐约束，再由C²约束及分支得到残差C¹、在0为0，因而O(h)。C²实际分支是合理的局部条件，但比原文更强，且只论单步局部h界，不保证长时间一致误差。力符号不影响这个几何论证。原文“will be violated”是泛指通常不精确保持，非所有例子必非零（线性约束可精确保持）。签名合理形式化该近似结论；证明体为 sorry，未验证证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.hiddenEulerError`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1304)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-ProjectionResidual · (4.17) · 印刷p.156 / PDFp.178

### 2. 原文陈述

> To solve the Eqs. (4.14)–(4.16), insert the second in the first and the first then in the third to obtain the simplified equation

$$
g(Q_n-M^{-1}G_n^T\Lambda)=0,\tag{4.17}
$$


> where

$$
Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n,\qquad G_n=g'(q_n),\qquad\Lambda=h^2\lambda_n.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))

def projectionEquation {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  projectionResidual m g q base η=0

theorem projectionResidual_elimination {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Fprinted : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n)
    (lam : MolecularDynamics.Chapter04Review.Q l)
    (_hp : out.2=z.2-h • Fprinted z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ lam))
    (_hq : out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2) :
    (out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g) ↔
      projectionEquation m g z.1
        (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-
          h^2 • MolecularDynamics.Chapter04Review.invMass m (Fprinted z.1)) (h^2 • lam) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectionResidual`；`MD.Ch04.projectionEquation`；`MD.Ch04.projectionResidual_elimination` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m、l 个位置约束 g、旧位置 q、给定预测位置 base 和乘子 η，projectionResidual 的值域为 Q l，逐分量为 g\_j(base−M^{-1}G(q)^Tη)；projectionEquation 正确规定该向量等于零，不宣称根存在。消元声明另量化 Fprinted、实步长 h、旧/新相点 z/out 和 lam；前提完整保留原印 out.p=z.p−hFprinted(z.q)−hG(z.q)^Tlam 与 out.q=z.q+hM^{-1}out.p，结论将 out.q 的全部位置约束为零等价为 base=z.q+hM^{-1}z.p−h²M^{-1}Fprinted(z.q)、η=h²lam 的零残差方程。固定对角逆质量的线性性使该等价对全部实 h 成立，含 h=0；未除以 h，亦不需要正质量或可逆 Gram 才能陈述此代数等价。Fprinted 明确按原印符号使用，不在本条擅改为常见力记号；[EXTRA] 补充消元等价与零残差资格准确。

### 7. 状态与证明位置

incomplete；`MD.Ch04.projectionResidual`：定义；`MD.Ch04.projectionEquation`：定义；`MD.Ch04.projectionResidual_elimination`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1315)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-ProjectionJacobian · definition · 印刷p.157 / PDFp.179

### 2. 原文陈述

> $R^{(l)}\Delta\Lambda^{(l)}=g(Q^{(l)}),\qquad R^{(l)}\stackrel{\mathrm{def}}=g'(Q^{(l)})M^{-1}G_n^T$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ

def projectionNewtonIncrement {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n)
    (η ηnext : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  let Δ := ηnext-η
  projectionJacobian m g q base η *ᵥ Δ=projectionResidual m g q base η
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectionJacobian`；`MD.Ch04.projectionNewtonIncrement` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η\_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。 | [EXTRA] |

[EXTRA] [EXTRA] 保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η\_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m,g、q/base∈Q n、η∈Q l，projectionJacobian 的行列均索引于 Fin l，实际为 G(base−M^{-1}G(q)^Tη)M^{-1}G(q)^T；各乘法维数正确且当前 Jacobian 的求值点为 Q^(l)，右侧固定 Jacobian 的求值点为旧 q。projectionNewtonIncrement 对额外的 ηnext 定义 Δ=ηnext−η，完整命题为 R(η)Δ=r(η)，同时保留源文线性方程和增量含义。R 为残差对 η 的负 Jacobian，因此 Newton 更新是加号；没有把 R 误称为正的残差导数。两个都是定义，不要求矩阵可逆，也不宣称增量存在、唯一或已求解。[EXTRA] 对线性方程的补充说明准确。

### 7. 状态与证明位置

self-contained；`MD.Ch04.projectionJacobian`：定义；`MD.Ch04.projectionNewtonIncrement`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1339)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-NewtonConstraint · (4.18)–(4.19) · 印刷p.157 / PDFp.179

### 2. 原文陈述

> The simplest is Gauss-Newton iteration, which may be written

$$
\Lambda^{(l+1)}=\Lambda^{(l)}+[g'(Q^{(l)})M^{-1}G_n^T]^{-1}g(Q^{(l)}),\tag{4.18}
$$



$$
Q^{(l)}:=Q_n-M^{-1}G_n^T\Lambda^{(l)},\tag{4.19}
$$


> which might be initialized with $\Lambda^{(0)}=0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η

def newtonConstraintSequence {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ)
    (_hvalid : ∀ i < k,
      (MolecularDynamics.Chapter04Review.projectionJacobian m g q base
        ((MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[i] 0)).det ≠ 0) :
    MolecularDynamics.Chapter04Review.Q l :=
  (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.newtonConstraint`；`MD.Ch04.newtonConstraintSequence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。 | [EXTRA] |

[EXTRA] [EXTRA] 真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主接口对任意 n,l,m,g、q/base 和 η，显式要求当前 R(η).det≠0，返回 η+R(η)^{-1}r(η)，与原印公式完全一致；该前提是合法求解步所需的 [EXTRA] 资格，不是假设误差结论。有限序列另量化 k∈ℕ，使用带完整命名空间的 MolecularDynamics.Chapter04Review.newtonConstraint（无证明参数的底层总函数）从 0 迭代 k 次；_hvalid 要求每个 i<k 时该实际轨道上的 R 均非奇异。因此前 k 次更新均合法，k=0 返回 0 且条件空真，不误要求最终第 k 个点处还需可逆。已区分底层函数与 MD.Ch04.newtonConstraint 的签名，未把带 det 证明参数的接口直接当作可迭代自映射，也未因逆矩阵总化而接受奇异点为合法 Newton 步。

### 7. 状态与证明位置

self-contained；`MD.Ch04.newtonConstraint`：定义；`MD.Ch04.newtonConstraintSequence`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1353)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-FrozenNewtonConstraint · definition · 印刷p.157 / PDFp.179

### 2. 原文陈述

> we may be able to fix $R$ at the beginning of the timestep, factor it once only, and then solve at each iteration with the same factors. Moreover, in case we have chosen $\Lambda^{(0)}=0$, we have

$$
R^{(0)}=G_nM^{-1}G_n^T,
$$


> which is a symmetric matrix,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η



/-- 修正版，对应原文 MD-4.3.2-FrozenNewtonConstraint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def frozenNewtonConstraint_corrected {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.frozenNewtonConstraint`；`MD.Ch04.frozenNewtonConstraint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Ch04\_deps.txt:4377–4382 中 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v(i)=(m i)⁻¹v(i)、grad U=textbookConstraintGradient U；2975–2977 中该梯度第 i 项为 fderiv ℝ U q(Pi.single i 1)；3385–3387 中 G(j,i) 为约束 g j 的该坐标导数；3413–3415 中 D=diag((m i)⁻¹)；4428 中 constraintSet={q|∀j,g j q=0}。这些是实际导数而非独立输入矩阵。未运行编译，也不把 sorry 当作语义失败。 Ch04.lean:823–825及依赖4459–4461固定的是R(0)=G(base)DG(q)ᵀ。这属于合理的冻结Newton实现，但未忠实表达原文另外声称的旧位置Gram等式、对称性以及一次分解复用。所标[ERRATUM?]一般成立；不能把正确的交叉矩阵版本当作已表达错误原式。若显式采用修订语义，可保留实现并对原式另标疑误。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.frozenNewtonConstraint`：定义；`MD.Ch04.frozenNewtonConstraint_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1370)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-NewtonQuadratic · unnumbered_claim · 印刷p.157 / PDFp.179

### 2. 原文陈述

> When the solution is unique, the constraints sufficiently smooth, and the determinant of $R$ is bounded well away from zero, Newton’s method has a very rapid asymptotic convergence property. It is possible to show that, if $\Lambda_*$ is the solution of (4.17), then sufficiently near the zero we have

$$
\|\Lambda^{(l+1)}-\Lambda_*\|\le C\|\Lambda^{(l)}-\Lambda_*\|^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newtonQuadratic :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ → ‖MolecularDynamics.Chapter04Review.newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.newtonQuadratic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。 | [EXTRA] |

[EXTRA] 局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m,g、固定 q/base 和 root，前提为每个 g\_j∈C²、r(root)=0、R(root).det≠0；结论的量词为 ∃C>0,∃δ>0,∀η,‖η−root‖<δ→‖N(η)−root‖≤C‖η−root‖²。这里 r(η)=g(base−M^{-1}G(q)^Tη)，Dr(η)=−R(η)，N(η)=η+R(η)^{-1}r(η)，因而确为通常 Newton 映射而非反号更新。C² 及根处非奇异可在缩小的邻域给出有界逆矩阵和二阶 Taylor 余项，足以支持完整二次界；无需把全局唯一性和全域 determinant 下界作为额外前提。m 不要求逐项正也不破坏该一般方程的局部 Newton 结论，因为有效正则性由 R(root) 非奇异直接给出。该声明是局部一步误差估计；继续缩小 δ 可用于迭代收敛，但本次不冒充已另建收敛序列或已完成 sorry 证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.newtonQuadratic`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1383)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-FrozenNewtonLinear · unnumbered_claim · 印刷p.157 / PDFp.179

### 2. 原文陈述

> When $R$ is evaluated only once per step, the asymptotic convergence of Newton’s method is linear, i.e. we have instead

$$
\|\Lambda^{(l+1)}-\Lambda_*\|\le\widehat C\|\Lambda^{(l)}-\Lambda_*\|,
$$


> sufficiently near to the solution.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenNewtonLinear :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0).det ≠ 0 →
    ‖fderiv ℝ (MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base) root‖ < 1 →
    ∃ C ∈ Ioo (0 : ℝ) 1, ∃ δ > 0, ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ →
      ‖MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base η-root‖ ≤ C*‖η-root‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.frozenNewtonLinear` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。 | [EXTRA] |

[EXTRA] [EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 n,l,m,g、q/base、root，前提完整包括 g\_j∈C²、真实根 r(root)=0、固定矩阵 R(0).det≠0，以及实际冻结映射 T(η)=η+R(0)^{-1}r(η) 在 root 的 Fréchet 导数算子范数严格小于 1。结论为存在 0<C<1 和 δ>0，使所有 ‖η−root‖<δ 的 η 满足 ‖T(η)−root‖≤C‖η−root‖。根条件给 T(root)=root，光滑性与根处导数范数严格小于 1 足以支持邻域的一步收缩界，未直接把待证误差界放进前提。冻结点是乘子 η=0，矩阵不随 η 更新，与零初值语境一致。[EXTRA] 正确限制了源文的 small-step 收敛说法；本声明给“至少有线性收缩界”，没有断言精确收敛阶必为 1，也没有声称所有冻结迭代都自动收敛。

### 7. 状态与证明位置

incomplete；`MD.Ch04.frozenNewtonLinear`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1392)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-ProjectionScale · unnumbered_claim · 印刷p.158 / PDFp.180

### 2. 原文陈述

> It is worth noting that $\Lambda(h)=\mathcal{O}(h^2)$, i.e. for small steps $\Lambda$ will also be small. This justifies the initial guess $\Lambda^{(0)}=0$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem projectionScale :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (η : ℝ → MolecularDynamics.Chapter04Review.Q l), z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectionResidual m g z.1 (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-h^2 • MolecularDynamics.Chapter04Review.invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-4.3.2-ProjectionScale。改动：独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。 -/
```

独立修正版：

```lean
theorem projectionScale_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (η : ℝ → MolecularDynamics.Chapter04Review.Q l), z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectionResidual m g z.1 (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-h^2 • MolecularDynamics.Chapter04Review.invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectionScale`；`MD.Ch04.projectionScale_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] F按原印F\_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。 | [EXTRA] |

[EXTRA] 给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。；[EXTRA] F按原印F\_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。；[ERRATUM?] 独立限定版本采用原印负号预测器，并要求初态满足位置及隐藏余切约束、Gram非奇异、C²根分支且η(0)=0；只有位置约束不保证O(h²)。翻译预测器符号修复与原书缺相容性问题分开。

### 6. 审计结论

本轮修复：F按原印F\_n解释，预测位置+h²M⁻¹F改为−h²M⁻¹F；保留根分支、初态余切相容及Gram可逆资格，原句不改。原书O(h²)的初态范围另列勘误待导师，不把两种根方程混为一谈。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；签名量化任意 n,l,m、位置力 F:Q n→Q n、约束 g、初始相点 z 及分支 η:ℝ→Q l；假设 z∈cotangentSet、g\_j∈C²、η∈C²、η(0)=0、Gram(z.q).det≠0，以及某个双侧开邻域内的实际零残差根方程。完整结论为存在 C>0、δ>0，对全部 h∈(−δ,δ) 有 ‖η(h)‖≤Ch²，包含 h=0。作为当前所写“加号预测器”的条件数学定理，该结论正确：由根方程在 0 的一阶微分、初始隐藏约束和 Gram 可逆得到 η′(0)=0，再由 C² 分支得到二阶界；F 只在固定 z.q 处取值，故无需 F 对位置可微。没有循环假设 O(h²)，也没有宣称已找到根分支。然而原文/notation 的预测器是 z.q+hM^{-1}z.p−h²M^{-1}F\_n，当前签名却写成加号，且未注明反号变量关系或修正版，故源文对应审校为 FAIL，而非数学定理本身被反例否定。原书 O(h²) 适用范围的疑问另在 json\_review 标记 NEEDS\_HUMAN，保持原文并交由人工判断。

### 7. 状态与证明位置

incomplete；`MD.Ch04.projectionScale`：未证（原书疑误不证）；`MD.Ch04.projectionScale_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1405)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.2-FrozenGramPrinted · unnumbered_claim · 印刷p.157 / PDFp.179

### 2. 原文陈述

> Moreover, in case we have chosen $\Lambda^{(0)}=0$, we have

$$
R^{(0)}=G_nM^{-1}G_n^T,
$$


> which is a symmetric matrix,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenGramPrinted :
    ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n),
      MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0 = textbookConstraintGram m g q := by
  sorry



/-- 修正版，对应原文 MD-4.3.2-FrozenGramPrinted。改动：真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。 -/
```

独立修正版：

```lean
theorem frozenGramPrinted_corrected :
    ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n),
      MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0 = textbookConstraintJacobian g base * textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.frozenGramPrinted`；`MD.Ch04.frozenGramPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。 | [EXTRA] |

[EXTRA] [ERRATUM?] 真实残差Jacobian为新预测点/旧点的交叉矩阵，不无条件等于旧点Gram或对称矩阵。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；核对位置：Ch04.lean LF 859–864。Q n 在 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean LF 4377 展开为 Fin n → ℝ。正式库 projectionJacobian 的完整定义位于同文件 LF 4452–4455：R(η)=J(base−D J(q)ᵀη)D J(q)ᵀ，其中 invMass 的坐标式在 LF 4381，等价于 D=diag((m i)⁻¹) 的乘向量作用。J(x) 的每项为真实偏导 (fderiv ℝ (g j) x)(Pi.single i 1)，来自 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean LF 2975–2977 及 -- FILE: MolecularDynamics/Chapter04/CotangentProjection.lean LF 3385–3387；D 的定义在后者 LF 3413–3414，textbookConstraintGram 在 LF 3417–3420 实际为 J(q)D J(q)ᵀ。令 η=0 后，左边是 J(base)D J(q)ᵀ；右边则是 J(q)D J(q)ᵀ。
对象与量词：签名先对 n,l,m,g,q,base 全称量化，随后无任何假设就断言两矩阵相等。这逐字承接了原书所印等式，但原书 (4.19) 和同页 R 的定义并不支持它；本条 [ERRATUM?] 成立，问题已可由完整定义和反例判定，无需因“缺定义”转交人工。正质量、C² 约束、旧点满足约束、约束 Jacobian 满行秩、预测点任意接近旧点、甚至 R(0) 可逆，都不能补救该无条件等式。
缺失结论：原摘录还明确说“which is a symmetric matrix”，Lean 签名仅给等式，没有列出 R(0) 的对称性断言。右端 Gram 的确对称，因为 D 为实对角矩阵；但实际左端是两个不同位置 Jacobian 的交叉乘积，一般连对称性也不成立。在正确的同点或同 Jacobian 限定下，等式可用于推导对称性；要审查全部结论子句，应把这一性质在对应正确声明中显式列出，而不能靠错误等式充当其依据。
本条没有 [EXTRA] 假设；修复必须清楚区分“保留原书勘误记录”和“新增可证明的正确声明”，不得直接修改 corrected\_json 的原文等式。
证明状态单独记录：Ch04.lean LF 863–864 为 := by / sorry。FAIL 来自展开定义后的错误普遍等式及缺失结论，与 sorry 是否存在是两个独立问题。

### 7. 状态与证明位置

incomplete；`MD.Ch04.frozenGramPrinted`：未证（原书疑误不证）；`MD.Ch04.frozenGramPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1435)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.3-ComponentPrinted · definition · 印刷p.158 / PDFp.180

### 2. 原文陈述

> In general, we perform a sequence of updates

$$
\Delta\Lambda_j=[\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\qquad Q:=Q-M^{-1}G_n^j\Delta\Lambda_j,
$$


> as $j$ cycles repeatedly from $1$ to $m$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def componentPrinted {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)



/-- 修正版，对应原文 MD-4.3.3-ComponentPrinted。改动：把一般分量式分母中的G_j^1明确改为当前约束在旧点的梯度G_n^j，与分子所用方向一致；原Gsup1参数版完整保留。 -/
```

独立修正版：

```lean
def componentPrinted_corrected {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.componentPrinted`；`MD.Ch04.componentPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Gsup1是未定义印刷G\_j^1的显式参数，未假设它等于已定义梯度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 把一般分量式分母中的G\_j^1明确改为当前约束在旧点的梯度G\_n^j，与分子所用方向一致；原Gsup1参数版完整保留。 | [EXTRA] |

[EXTRA] [EXTRA]Gsup1是未定义印刷G\_j^1的显式参数，未假设它等于已定义梯度。；[EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。；[ERRATUM?] 把一般分量式分母中的G\_j^1明确改为当前约束在旧点的梯度G\_n^j，与分子所用方向一致；原Gsup1参数版完整保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；位置域为Fin n→ℝ，约束族Fin l，j任意；质量逐坐标为正，旧点q与当前点Qnow可微，当前标量分母非零。dot、grad、invMass展开后，返回值正是Qnow−[g\_j(Qnow)/(∇g\_j(Qnow)ᵀM⁻¹Gsup1\_j)]M⁻¹∇g\_j(q)。未把Gsup1认作梯度；这忠实保留原印分母G\_j^1，与更新方向G\_n^j分开。[EXTRA]均已明示，单步范围明确；但原印G\_j^1未定义，数学含义仍需人工确认。

### 7. 状态与证明位置

self-contained；`MD.Ch04.componentPrinted`：定义；`MD.Ch04.componentPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1457)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.3-ComponentConstraintStep · definition · 印刷p.158 / PDFp.180

### 2. 原文陈述


$$
\Delta\Lambda_1=[\nabla g_1(Q)^TM^{-1}G_n^1]^{-1}g_1(Q).
$$


> We then update $Q$ by

$$
Q:=Q-M^{-1}G_n^1\Delta\Lambda_1,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) (j : Fin l) (_hm : ∀ i, 0 < m i)
    (_hgq : DifferentiableAt ℝ (g j) q) (_hgQ : DifferentiableAt ℝ (g j) Qnow)
    (_hdenom : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow)
      (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)) ≠ 0) : MolecularDynamics.Chapter04Review.Q n :=
  Qnow-(g j Qnow / MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Qnow) (MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q))) •
    MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 单个有效分量步骤；重复顺序循环由MD-4.3.3-ComponentSweep承担。印刷Gsup1与梯度解释分开保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.componentConstraintStep` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。 | [EXTRA] |

[EXTRA] [EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。；[EXTRA] 补正质量、约束在旧点/当前点经典可微、当前分母非零的有效步骤资格；Fin首项0对应印刷j=1。Gsup1的原印参数保留；任意j的统一式为明确参数化解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n,l、正对角质量、约束族、旧位置q、当前位置Qnow和j，返回当前梯度与旧梯度形成的非零标量分母所给Newton分量更新。j=0对应印刷首项1，一般j是已披露的统一梯度解释；不是断言一步达到g\_j=0。旧点/当前点可微及分母非零均显式限定。[EXTRA]中提Gsup1属于串入的另一条注释，不是本声明参数。

### 7. 状态与证明位置

self-contained；`MD.Ch04.componentConstraintStep`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1479)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.3-ComponentSweep · definition · 印刷p.158 / PDFp.180

### 2. 原文陈述

> and continue to update $\Lambda_2$ in the same manner (using the second constraint). In general, we perform a sequence of updates

$$
\Delta\Lambda_j=[\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\qquad Q:=Q-M^{-1}G_n^j\Delta\Lambda_j,
$$


> as $j$ cycles repeatedly from $1$ to $m$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow

def componentPrintedDelta {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Q : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) (j : Fin l) : ℝ :=
  g j Q/MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
    (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j))

def componentPrintedTrajectory {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n) : ℕ → MolecularDynamics.Chapter04Review.Q n
  | 0 => Q₀
  | k+1 =>
    let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
    if hl : 0 < l then
      let j : Fin l := ⟨k%l,Nat.mod_lt k hl⟩
      Q-componentPrintedDelta m g Q Gsup1 j •
        MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad (g j) q)
    else Q

def componentPrintedIteration {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (rounds : ℕ) (_hm : ∀ i, 0 < m i) (_hl : 0 < l)
    (_hvalid : ∀ k < rounds*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) :
    MolecularDynamics.Chapter04Review.Q n :=
  componentPrintedTrajectory m g q Q₀ Gsup1 (rounds*l)

def componentPrintedStop {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Q₀ : MolecularDynamics.Chapter04Review.Q n)
    (Gsup1 : Fin l → MolecularDynamics.Chapter04Review.Q n)
    (round : ℕ) (tol : ℝ) (_hl : 0 < l)
    (_hvalid : ∀ k < (round+1)*l,
      let j : Fin l := ⟨k%l,Nat.mod_lt k _hl⟩
      let Q := componentPrintedTrajectory m g q Q₀ Gsup1 k
      DifferentiableAt ℝ (g j) q ∧ DifferentiableAt ℝ (g j) Q ∧
        MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.grad (g j) Q)
          (MolecularDynamics.Chapter04Review.invMass m (Gsup1 j)) ≠ 0) : Prop :=
  ∀ j : Fin l, |componentPrintedDelta m g
    (componentPrintedTrajectory m g q Q₀ Gsup1 (round*l+j.val)) Gsup1 j| ≤ tol



/-- 修正版，对应原文 MD-4.3.3-ComponentSweep。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def componentSweep_corrected {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q Qnow : MolecularDynamics.Chapter04Review.Q n) : MolecularDynamics.Chapter04Review.Q n :=
  (List.finRange l).foldl (fun Qcur j => MolecularDynamics.Chapter04Review.componentConstraintStep m g q Qcur j) Qnow
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.componentSweep`；`MD.Ch04.componentPrintedDelta`；`MD.Ch04.componentPrintedTrajectory`；`MD.Ch04.componentPrintedIteration`；`MD.Ch04.componentPrintedStop`；`MD.Ch04.componentSweep_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G\_j^1索引疑误保留待导师。没有更改逐分量更新次序。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。；[EXTRA] 保留一次修订梯度扫描辅助；新增字面Gsup1分母的实际逐分量轨迹、多轮顺序循环与每步有效域，以及一轮全部增量停止检查。字面原式不暗换Gsup1，不添加收敛承诺。；[EXTRA] 停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G\_j^1索引疑误保留待导师。没有更改逐分量更新次序。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本轮修复：停止判据恢复原印非严格≤tol，并要求含测试轮全部步骤的可微/分母非零资格；原G\_j^1索引疑误保留待导师。没有更改逐分量更新次序。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；componentSweep按finRange l升序foldl，每次用刚更新的Qcur，使用梯度修订方向；它调用的是Chapter04Review.componentConstraintStep，无有效域假设，是实数逆零总化下的辅助函数。componentPrintedDelta忠实保留Gsup1；Trajectory以k mod l循环、旧q不变，l=0时恒等；Iteration在正质量、l>0和每个已执行步骤可微/分母非零条件下返回rounds*l步位置。Stop检查round*l+j处、更新前计算的一整轮各分量增量，顺序正确，却使用<tol，原页是≤tol；故本条全部声明不能整体PASS。原印索引疑误另需人工裁定。

### 7. 状态与证明位置

self-contained；`MD.Ch04.componentSweep`：定义；`MD.Ch04.componentPrintedDelta`：定义；`MD.Ch04.componentPrintedTrajectory`：定义；`MD.Ch04.componentPrintedIteration`：定义；`MD.Ch04.componentPrintedStop`：定义；`MD.Ch04.componentSweep_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1492)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-ProjectedEulerPrinted · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> On the other hand it is not too difficult to correct this defect by incorporating an additional projection onto the cotangent space:

$$
q_{n+1}=q_n+hM^{-1}\bar p_{n+1},\tag{4.20}
$$



$$
\bar p_{n+1}=p_n-hF_n-hg'(q_n)^T\lambda_n,\tag{4.21}
$$



$$
0=g(q_{n+1}),\tag{4.22}
$$



$$
p_{n+1}=\bar p_{n+1}-g'(q_{n+1})^T\mu_{n+1},\tag{4.23}
$$



$$
0=g'(q_{n+1})M^{-1}p_{n+1}.\tag{4.24}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectedEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • (-F z.1)-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectedEulerPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i项为(m i)⁻¹v\_i；Jacobian的(j,i)项为fderiv(g j)(q)(e\_i)。constraintSet是所有g\_j(q)=0；cotangentSet同时含位置约束及GM⁻¹p=0。因此五个合取依次等价于(4.21)、(4.20)、(4.22)、(4.23)、(4.24)，重复位置约束不改变关系。输入与输出及两组乘子均为显式参数，不声称存在。保留−hF符合印刷本。[ERRATUM?]成立：PDF185印刷163为+hF；这不影响逐字版通过。

### 7. 状态与证明位置

self-contained；`MD.Ch04.projectedEulerPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1553)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-ProjectedEulerRelation · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> The demonstration that the method is symplectic can be seen as a consequence of the following lemma.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g



/-- 修正版，对应原文 MD-4.3.4-ProjectedEulerRelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def projectedEulerRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectedEulerRelation`；`MD.Ch04.projectedEulerRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。展开与逐字版相同，唯一变化为+hF，但所绑定原句是方法辛性的论断；此定义只有五条更新约束，没有任何拉回二形式不变结论，也没有F来自势的限制。[EXTRA]符号修正版可以作为另一个算法定义，但不能充当所引辛性原句的形式化。

### 7. 状态与证明位置

self-contained；`MD.Ch04.projectedEulerRelation`：定义；`MD.Ch04.projectedEulerRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1562)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-Lemma41 · Lemma 4.1 · 印刷p.159–160 / PDFp.181–182

### 2. 原文陈述

> Lemma 4.1 Let $\gamma:\mathbb R^{N_c}\to\mathbb R$ be $C^2$. Let $q,p\in\mathbb R^{N_c}$ be constrained to the manifold defined by

$$
\gamma(q)=0,\quad p\cdot\nabla\gamma(q)=0,
$$


> and suppose $P,\mu$ satisfy $P=p-\mu\nabla\gamma(q)$. Then

$$
\sum_{j=1}^{N_c}dq_j\wedge dP_j=\sum_{j=1}^{N_c}dq_j\wedge dp_j.
$$



### 3. 原文证明

> Clearly the result follows provided

$$
\sum_{j=1}^{N_c}dq_j\wedge d[\mu\nabla\gamma(q)]_j=0,
$$


> where $[\ldots]_j$ indicates the jth component of the term in brackets. We have

$$
\sum_{j=1}^{N_c}dq_j\wedge d[\mu\nabla\gamma(q)]_j=\sum_{j=1}^{N_c}dq_j\wedge\left(\frac{\partial\gamma}{\partial q_j}d\mu+\mu\sum_{i=1}^{N_c}\gamma''_{ij}dq_j\right).
$$


> Then we note

$$
\sum_{j=1}^{N_c}dq_j\wedge\frac{\partial\gamma}{\partial q_j}d\mu=\sum_{j=1}^{N_c}\frac{\partial\gamma}{\partial q_j}dq_j\wedge d\mu=0,
$$


> since $\gamma(q)\equiv0$ implies $d\gamma(q)=\sum_{j=1}^{N_c}\frac{\partial\gamma}{\partial q_j}dq_j\equiv0$. Moreover

$$
\sum_{j=1}^{N_c}dq_j\wedge\sum_{i=1}^{N_c}\gamma''_{ij}dq_j=0,
$$


> since the Hessian matrix $\gamma''$ is symmetric.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lemma41 {Nc : ℕ} {E : Type*}
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
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.lemma_4_1 <;> assumption



/-- 修正版，对应原文 MD-4.3.4-Lemma41。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem lemma41_corrected {Nc : ℕ} {E : Type*}
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
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.lemma_4_1 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.lemma41`；`MD.Ch04.lemma41_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；任意Nc及实赋范空间E，γ全局C²，q,p,μ在x可微；hchart在x邻域同时保留γ(q)=0和p·∇γ(q)=0。ConstrainedMomentum定义P=p−μ∇γ(q)，CotangentChart把位置与动量合并；J=[0 I;−I 0]所得双线性形式即Σdq\_j∧dp\_j。结论对任意u,v比较两个参数图的完整拉回二形式，符合原引理。局部图及可微性是明确资格，不把点约束误当微分约束。签名匹配，但原书证明两处dq\_j链式指标疑误须保留并人工确认。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.lemma41`：已证；`MD.Ch04.lemma41_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1581)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-MultiMomentumPullback · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Observe that $g'(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^l\mu_{n+1,k}\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\gamma$ replaced by each $g_k$ to demonstrate

$$
\sum_jdq_{n+1,j}\wedge dp_{n+1,j}=\sum_jdq_{n+1,j}\wedge d\bar p_{n+1,j}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem multiMomentumPullback {Nc : ℕ} {E ι : Type*}
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
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookMultiConstrainedMomentum_preserves_pullback <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.multiMomentumPullback` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。 | [EXTRA] |

[EXTRA] 有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。multiConstrainedMomentum=p−Σ_{j∈s}μ\_j∇γ\_j(q)，chart与SymplecticForm如Lemma41展开，结论正是新位置的Σdq∧dp等于Σdq∧d pbar。有限指标集推广Fin l合理，s中每条约束C²、乘子与q,p在x可微，且邻域位置约束确保dγ\_j(q)=0。无需假设pbar满足动量隐藏约束：该拉回恒等式对任意pbar成立，属于有效加强。[EXTRA]合理，不声称分支存在。调用依赖中的同名拉回定理。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.multiMomentumPullback`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1616)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-ProjectedEulerPullback · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Using similar argumentation based on the properties of the wedge product, we next show

$$
\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j};
$$


> and, finally, invoking Lemma 4.1 again,

$$
\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge dp_{n,j}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem projectedEulerPullback {Nc : ℕ} {E ι : Type*}
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
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookProjectedEulerChart_preserves_pullback <;> assumption

theorem projectedEulerPullback_intermediate {Nc : ℕ} {E ι : Type*}
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
    let Pbar := textbookProjectedEulerPreMomentum s γ lam U h a q p
    let Q := textbookProjectedEulerPosition m h q Pbar
    (textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart Q Pbar) x u) (fderiv ℝ (textbookCotangentChart Q Pbar) x v) = textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q Pbar) x u) (fderiv ℝ (textbookCotangentChart q Pbar) x v)) ∧
    (textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q Pbar) x u) (fderiv ℝ (textbookCotangentChart q Pbar) x v) = textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u) (fderiv ℝ (textbookCotangentChart q p) x v)) ∧
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.projectedEulerPullback`；`MD.Ch04.projectedEulerPullback_intermediate` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。 | [EXTRA] |

[EXTRA] 真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。；[EXTRA] 原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限指标集s、位置维数Nc、实赋范参数空间E、实系数h,a和对角质量m；q,p及各乘子在x可微，U和约束C²，旧/新位置约束在x邻域成立。PreMomentum=p+a(−∇U)−hΣλ\_j∇γ\_j，Position=q+hM⁻¹Pbar，Chart再减Σμ\_j∇γ\_j(Q)。intermediate的第一合取项准确比较(Q,Pbar)与(q,Pbar)，第二项比较(q,Pbar)与(q,p)，第三项及主声明是总拉回相等，均对任意u,v成立。任意a覆盖印刷力项的相应选择；逆质量为常数对角算子，代数二形式恒等式不需正质量。未声称乘子分支存在或自动满足隐藏动量约束。intermediate虽为sorry，本任务只审签名，不因此判FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch04.projectedEulerPullback`：已证；`MD.Ch04.projectedEulerPullback_intermediate`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1634)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentMultiplier · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> $0=g'(q_{n+1})M^{-1}p_{n+1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def cotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))

theorem cotangentMultiplier_hidden {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : MolecularDynamics.Chapter04Review.Q n)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    let μ := textbookCotangentMultiplier m g q p
    (textbookConstraintGram m g q) *ᵥ μ=
      textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ p) ∧
    textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (p-(textbookConstraintJacobian g q)ᵀ *ᵥ μ))=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentMultiplier`；`MD.Ch04.cotangentMultiplier_hidden` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。 | [EXTRA] |

[EXTRA] [EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。；[EXTRA] Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；令G为Mc×Nc约束Jacobian，D=diag(m\_i⁻¹)，A=GDGᵀ。对任意q、预投影p，在det A≠0资格下定义μ=A⁻¹GDp；hidden的第一合取项是Aμ=GDp，第二项是GD(p−Gᵀμ)=0，精确覆盖(4.23–24)在此资格下的构造。未把值函数冒充隐藏约束证明结论；未添加位置约束或质量正性，它们对此代数恒等式不是必要条件。任意γ用fderiv构造G，总化后恒等式仍成立；若解释为经典Jacobian须处于可微情形。hidden含sorry不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch04.cotangentMultiplier`：定义；`MD.Ch04.cotangentMultiplier_hidden`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1679)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentProjection · definition · 印刷p.159 / PDFp.181

### 2. 原文陈述

> $p_{n+1}=\bar p_{n+1}-g'(q_{n+1})^T\mu_{n+1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p P : Fin Nc → ℝ) (μ : Fin Mc → ℝ) : Prop :=
  P=p-(textbookConstraintJacobian γ q)ᵀ *ᵥ μ

noncomputable def cotangentProjection_gram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentProjection`；`MD.Ch04.cotangentProjection_gram` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。 | [EXTRA] |

[EXTRA] [EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。；[EXTRA] 主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主声明在任意Nc,Mc、m、约束族γ、新位置q、预动量p、投影动量P及任意μ下定义Prop：P=p−G(q)ᵀμ，忠实对应(4.23)；m在主等式中未使用，无隐含求解。_gram是独立的特定构造，增加det(GDGᵀ)≠0并代入实际Gram逆乘子。隐藏约束由上一条承担，主等式本身未误称任意μ均投影到余切空间。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cotangentProjection`：定义；`MD.Ch04.cotangentProjection_gram`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1699)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentHidden · unnumbered_claim · 印刷p.159 / PDFp.181

### 2. 原文陈述

> $0=g'(q_{n+1})M^{-1}p_{n+1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentHidden {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0 := by
  apply MolecularDynamics.textbookCotangentProjection_hiddenConstraint_of_mass_and_independence <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentHidden` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。 | [EXTRA] |

[EXTRA] [EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已读取实际 /workspace/Ch04.lean 与 Ch04\_deps.txt，而非仅按批次签名判断。以下为只读签名语义审计；未运行 Lean 编译，也不据 sorry 判定语义。展开输出为P=pbar−Gᵀ(GDGᵀ)⁻¹GDpbar，结论GP\_mass=GDP=0逐分量正是(4.24)。hm要求所有质量严格正，hind要求实际fderiv梯度行线性独立；依赖ConstrainedGram.lean给出Gram.det≠0，再调用CotangentProjection.lean隐藏约束定理。[EXTRA]是确保Gram可逆的充分且合理资格，未假设目标结论。q,pbar任意；此条只处理隐藏动量约束，原(4.24)本身也不包含位置约束，不应额外要求γ(q)=0。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentHidden`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1710)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentRegularity · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Thus we may apply Lemma 4.1 with $\gamma$ replaced by each $g_k$ to demonstrate $\sum_{j=1}^{N_c}dq_{n+1,j}\wedge dp_{n+1,j}=\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}$.

### 3. 原文证明

原书无独立完整证明。
> Observe that $g^{\prime}(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^{l}\mu_{n+1,k}\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\gamma$ replaced by each $g_k$.
原书以有限梯度和及 Lemma 4.1 给出本等式的简短论证；未另列独立定理或完整重复证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentRegularity {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentProjection m γ (q y) (p y)) x := by
  apply MolecularDynamics.contDiffAt_textbookCotangentProjection <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | Gram专项投影C¹正则性辅助；原句位置约束下完整二形式等式由MD-4.3.4-CotangentPullback承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentRegularity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际逆Gram投影的一阶正则性资格：C²约束、C¹参数图、Gram非奇异；非另印定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。 | [EXTRA] |

[EXTRA] [EXTRA]实际逆Gram投影的一阶正则性资格：C²约束、C¹参数图、Gram非奇异；非另印定理。；[EXTRA] 本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc,Mc、固定实对角逆质量、C²约束族、在x为C¹的q,p和点上非奇异Gram，结论仅为实际Gram投影复合图在x的C¹正则性。梯度为C¹，Gram及其逆在非奇异点局部C¹，故陈述合理；无需位置约束。该声明不含任何二形式等式，也不是原页独立定理；本条statement\_scope及[EXTRA]已明确将其定位为辅助，完整原句由第9条承担，按此已披露范围PASS，不将C¹结论算作原句等式的证明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentRegularity`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1721)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-CotangentPullback · unnumbered_claim · 印刷p.160 / PDFp.182

### 2. 原文陈述

> Thus we may apply Lemma 4.1 with $\gamma$ replaced by each $g_k$ to demonstrate $\sum_{j=1}^{N_c}dq_{n+1,j}\wedge dp_{n+1,j}=\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}$.

### 3. 原文证明

原书无独立完整证明。
> Observe that $g^{\prime}(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^{l}\mu_{n+1,k}\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\gamma$ replaced by each $g_k$.
原书以有限梯度和及 Lemma 4.1 给出本等式的简短论证；未另列独立定理或完整重复证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem cotangentPullback {Nc Mc : ℕ} (m : Fin Nc → ℝ)
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
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookCotangentProjection_preserves_pullback <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentPullback` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际逆Gram投影、C²约束、C¹参数图、Gram非奇异及邻域位置约束；可微乘子由正式库导出，不作新假设。 | [EXTRA] |

[EXTRA] 实际逆Gram投影、C²约束、C¹参数图、Gram非奇异及邻域位置约束；可微乘子由正式库导出，不作新假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc,Mc、C²约束族γ、C¹局部q,p、点上非奇异Gram、每个位置约束γ\_j(q(y))在x邻域为零，对任意u,v比较(q,Gram投影(q,p))与(q,p)的完整拉回辛二形式。邻域约束足以导出dγ\_j(q)=0；可微乘子由非奇异Gram和C²/C¹资格导出，不另假设。p在此表示原页Pbar，投影值为p_{n+1}；J块矩阵和坐标图定义给出正确Σdq∧dp符号及全部坐标求和。属于已披露的Gram专项实现；未证明一般任意μ版本，也未声称求解分支存在。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.cotangentPullback`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1730)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.4-GramProjectedEuler · unnumbered_claim · 印刷p.159 / PDFp.181

### 2. 原文陈述

> The demonstration that the method is symplectic can be seen as a consequence of the following lemma.

### 3. 原文证明

原书无独立完整证明。
> On printed p.160 (PDF p.182), Lemma 4.1 first gives $\sum_{j=1}^{N_c}dq_{n+1,j}\wedge dp_{n+1,j}=\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}$. The wedge-product argument next gives $\sum_{j=1}^{N_c}dq_{n+1,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j}$; invoking Lemma 4.1 again gives $\sum_{j=1}^{N_c}dq_{n,j}\wedge d\bar p_{n+1,j}=\sum_{j=1}^{N_c}dq_{n,j}\wedge dp_{n,j}$.
所引句位于印刷第159页；方法的三段二形式论证在印刷第160页，未另列独立完整定理证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gramProjectedEuler {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption

theorem gramProjectedEuler_general {Nc Mc : ℕ}
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
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption



/-- 修正版，对应原文 MD-4.3.4-GramProjectedEuler。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem gramProjectedEuler_corrected {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.gramProjectedEuler`；`MD.Ch04.gramProjectedEuler_general`；`MD.Ch04.gramProjectedEuler_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将(4.20–24)实际Gram末投影同时证明隐藏约束与完整拉回形式不变；给定C¹位置投影分支，非解的存在理论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]将(4.20–24)实际Gram末投影同时证明隐藏约束与完整拉回形式不变；给定C¹位置投影分支，非解的存在理论。；[EXTRA] 教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；签名逐项核对：Nc、Mc任意有限维，q、p及各λ在x为C¹，U和各γ为C²；旧、新位置约束在x邻域成立；新位置Gram行列式非零。结论第一合取是实际Gram末投影满足 g′M⁻¹pnew=0，第二合取对任意u、v给整个chart的辛形式拉回等式。Gram逆定义实现μ，未假设辛性。m未要求正或非零，但质量逆按实数总逆定义，M⁻¹仍对称，Gram非退化足够支持该几何结论；不能由此声称物理正质量或全局辛微分同胚。旧p不需隐藏约束是有效加强。general允许任意a且未冒充原印。就字面辛性声明可通过；整体因教材力号疑误分流人工。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch04.gramProjectedEuler`：已证；`MD.Ch04.gramProjectedEuler_general`：已证；`MD.Ch04.gramProjectedEuler_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1748)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionPrinted · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> In the presence of the constraint, we consider the scheme

$$
q_{n+1}-2q_n+q_{n-1}=h^2M^{-1}F(q_n)-h^2g'(q_n)^T\lambda_n,\tag{4.25}
$$



$$
g(q_{n+1})=0.\tag{4.26}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shakePositionPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b)-h^2 • ((textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。签名按参数a=qₙ₋₁、b=qₙ、c=qₙ₊₁、rho=λₙ，完整记录(4.25)和(4.26)，没有额外假设或存在性结论，定义无sorry。[ERRATUM?]成立：从(4.27)–(4.29)消元得h²M⁻¹(F−Gᵀλ)，原印刷反力缺M⁻¹；非标量质量下两种法向空间一般不同。本PASS仅指忠实保留原印刷。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakePositionPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1825)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionMass · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shakePositionRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.5-SHAKEPositionMass。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def shakePositionRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (a b c : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • MolecularDynamics.Chapter04Review.invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionRelation`；`MD.Ch04.shakePositionRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]质量一致位置式h²M⁻¹(F−Gᵀλ)，非原印刷(4.25)。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]质量一致位置式h²M⁻¹(F−Gᵀλ)，非原印刷(4.25)。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。该签名只是质量一致位置关系的定义，不是“由相空间方法消去动量得到(4.25)–(4.26)”这一断言：无SHAKE步骤前提、无序列、无消元蕴含，且它的反力为M⁻¹Gᵀρ而非原印刷Gᵀρ。[EXTRA]是合理的勘误候选，但属于改变公式而不是额外假设；不能代替原句的形式化。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakePositionRelation`：定义；`MD.Ch04.shakePositionRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1833)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPhase · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> A natural choice is to consider the phase space formulation of the Störmer-Verlet method for $\dot q=M^{-1}p,\dot p=F(q)$, then replace $F$ by $F-g'(q)^T\lambda$, resulting in

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.27}
$$



$$
p_{n+1/2}=p_n+(h/2)F(q_n)-(h/2)g'(q_n)^T\lambda_n,\tag{4.28}
$$



$$
p_{n+1}=p_{n+1/2}+(h/2)F(q_{n+1})-(h/2)g'(q_{n+1})^T\lambda_{n+1}.\tag{4.29}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho rhonew : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。half=pₙ₊½、z=(qₙ,pₙ)、out=(qₙ₊₁,pₙ₊₁)，四个合取项分别为(4.28)、(4.27)、实际位置约束、(4.29)。位置约束来自同页(4.26)的算法上下文，属于必要且合理的补全；两个乘子均按h/2缩放。未要求隐藏约束、未断言求解分支存在。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakeRelation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1847)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-RATTLE · definition · 印刷p.161 / PDFp.183

### 2. 原文陈述

> A method that automatically preserves both the constraint and hidden constraint is the RATTLE method [12] which consists of the following steps:

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.30}
$$



$$
p_{n+1/2}=p_n+(h/2)F_n-(h/2)g'(q_n)^T\lambda_n,\tag{4.31}
$$



$$
0=g(q_{n+1}),\tag{4.32}
$$



$$
p_{n+1}=p_{n+1/2}+(h/2)F_{n+1}-g'(q_{n+1})^T\mu_{n+1},\tag{4.33}
$$



$$
0=g'(q_{n+1})M^{-1}p_{n+1}.\tag{4.34}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rattleRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。half、rho、μ依次代表pₙ₊½、λₙ、μₙ₊₁。依赖rattleRelation和本地同名定义一致；合取完整包含(4.30)–(4.34)。cotangentSet重复位置约束并包含隐藏约束，故并未漏掉“自动保持两种约束”。末步μ前无h/2，忠实原书不同缩放。无额外假设、无sorry；关系本身不承诺隐式解存在。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rattleRelation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1854)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-ConstrainedOrders · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> The projected symplectic constrained method (4.20)–(4.24) is only first order accurate. We forego providing a detailed proof of this fact, but note that it could be demonstrated using standard methods [164]. There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedOrders :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  sorry

theorem constrainedOrders_global (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 4 U) (_hg : ∀ j, ContDiff ℝ 4 (g j))
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      (textbookConstraintGram m g z.1).det ≠ 0)
    (E R : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (pE pR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (η : ℝ) (_hη : 0 < η)
    (_hE : ContDiffOn ℝ 3 (Function.uncurry E) (Ioo (-η) η ×ˢ D))
    (_hR : ContDiffOn ℝ 3 (Function.uncurry R) (Ioo (-η) η ×ˢ D))
    (_hrhoE : ContDiffOn ℝ 2 (Function.uncurry rhoE) (Ioo (-η) η ×ˢ D))
    (_hμE : ContDiffOn ℝ 2 (Function.uncurry μE) (Ioo (-η) η ×ˢ D))
    (_hrhoR : ContDiffOn ℝ 2 (Function.uncurry rhoR) (Ioo (-η) η ×ˢ D))
    (_hμR : ContDiffOn ℝ 2 (Function.uncurry μR) (Ioo (-η) η ×ˢ D))
    (_hzero : ∀ z ∈ D, E 0 z=z ∧ R 0 z=z ∧ μE 0 z=0 ∧ μR 0 z=0)
    (_hsteps : ∀ h ∈ Ioo (-η) η, ∀ z ∈ D,
      z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (R h z) (pR h z) (rhoR h z) (μR h z))
    (T : ℝ) (_hT : 0 < T) (Φ : ℝ → MolecularDynamics.Chapter04Review.Z n)
    (_hΦ : ∀ t ∈ Icc 0 T, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t)
    (_hc : ∀ t ∈ Icc 0 T, Φ t ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hcompact : ∃ B, IsCompact B ∧ B ⊆ D ∧ ∀ t ∈ Icc 0 T, Φ t ∈ B) :
    ∃ C > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      let h := T/(N:ℝ)
      ∀ k ≤ N, ‖(E h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h ∧
        ‖(R h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h^2 := by
  sorry

theorem constrainedOrders_firstOrderSharp :
    ∃ c > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      c/(N:ℝ) ≤ ‖(MolecularDynamics.Chapter04Review.symplecticEulerMatrix 1 (1/(N:ℝ)))^N *ᵥ
        (![1,0] : Fin 2 → ℝ)-![Real.cos 1,-Real.sin 1]‖ := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-ConstrainedOrders。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem constrainedOrders_corrected :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 投影Euler全局一阶（含非二阶实例）及RATTLE全局二阶；SHAKE位置全局二阶由MD-4.3.5-SHAKEPositionOrder承担，其原印质量约定待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedOrders`；`MD.Ch04.constrainedOrders_global`；`MD.Ch04.constrainedOrders_firstOrderSharp`；`MD.Ch04.constrainedOrders_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。；[EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；constrainedOrders：正质量、C⁴势/约束、初点余切约束及Gram非零；E/R/Φ为C³步长曲线且在0等于z，乘子为C²，末投影μE、μR在0为零；真实步关系与精确ODE在双侧小窗口成立。结论是同一起点单步Euler O(h²)、RATTLE O(h³)，并非全局阶。pE/pR未单列光滑性，但步关系已给其光滑表达式。global另在开放D上设联合C³ E/R、联合C²乘子、零步恒等及正则余切域；精确轨道在[0,T]落于D内紧集。结论对充分大正整数N、全部k≤N给Euler Ch和RATTLE Ch²全局误差；没有将误差作为假设。firstOrderSharp对T=1振子初值(1,0)给全步误差c/N下界，确实排除该方法统一二阶。以上对正力号修订方法数学上合理，但与原印负力号不能无标记等同。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedOrders`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_global`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_firstOrderSharp`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1865)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-RATTLESymplectic · unnumbered_claim · 印刷p.162 / PDFp.184

### 2. 原文陈述

> Moreover, the symplecticness of (4.30)–(4.34) may be demonstrated using a very similar approach to that used to demonstrate the symplectic condition for (4.20)–(4.24). Given the above discussion and derivation, the proof of symplecticness of the RATTLE method (4.30)–(4.34) is now a formality. For details refer to [229].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rattleSymplectic (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j))
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D) (h : ℝ)
    (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1))
    (_hG : ContDiffOn ℝ 1 G D) (_hp : ContDiffOn ℝ 1 half D)
    (_hr : ContDiffOn ℝ 1 rho D) (_hμ : ContDiffOn ℝ 1 μ D)
    (_hstep : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) :
    ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      ∀ u v, MolecularDynamics.Chapter04Review.tangentPhase m g z u →
      MolecularDynamics.Chapter04Review.tangentPhase m g z v →
        MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=
          MolecularDynamics.Chapter04Review.phaseForm u v := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rattleSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。 | [EXTRA] |

[EXTRA] 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。；[EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意n/l、正质量、C² U/g、开放D及固定实步长h；仅在D与余切约束集交上要求位置梯度独立。G、half、rho、μ均在D上C¹；真实RATTLE关系只对约束初点要求，输出由关系保证位置及隐藏约束。tangentPhase准确包含g的一阶切条件及g′M⁻¹p的一阶切条件。结论对每个该初点及任意两条切向量给phaseForm(DG u,DG v)=phaseForm(u,v)，是完整受限辛性。正质量和满秩使该受限域为正则余切流形，允许由约束集上的关系沿切向量微分。h=0亦无问题。未要求全局单值求解或分支存在。[EXTRA]与签名一致；sorry不参与判错。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rattleSymplectic`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1945)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-StaggeredConstraint · definition · 印刷p.162 / PDFp.184

### 2. 原文陈述

> the iterations generated by them can be related to the following staggered iteration

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.35}
$$



$$
p_{n+1/2}=p_{n-1/2}+hF_n-hg'(q_n)^T\widetilde\lambda_n,\tag{4.36}
$$



$$
0=g(q_{n+1}),\tag{4.37}
$$


> where, for SHAKE, $\widetilde\lambda_n=\lambda_n$, while, in case of RATTLE, we must define $\widetilde\lambda_n=(\lambda_n+\mu_n)/2$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.5-StaggeredConstraint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def staggeredConstraintRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.staggeredConstraintRelation`；`MD.Ch04.staggeredConstraintRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。参数rho是独立的交错乘子，关系完整记录(4.35)–(4.37)，无sorry。但原文还有SHAKE的tildeλ=λ和RATTLE的tildeλ=(λ+μ)/2及两种迭代可归约为此关系，签名没有原方法乘子、无换算公式、无归约断言，遗漏实质子句。[ERRATUM?]成立：合并上一RATTLE末步和当前首步得newHalf=oldHalf+hF−Gᵀ(μₙ+(h/2)λₙ)，故h≠0时tildeλ=λₙ/2+μₙ/h，非印刷平均。

### 7. 状态与证明位置

self-contained；`MD.Ch04.staggeredConstraintRelation`：定义；`MD.Ch04.staggeredConstraintRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1970)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKERATTLEEquivalence · unnumbered_claim · 印刷p.162 / PDFp.184

### 2. 原文陈述

> Given an initial condition $(q_0^S,p_0^S)$ for the SHAKE discretization, we easily determine $\lambda_0^S$ by taking a step. Then it follows that

$$
p_{-1/2}=p_0-(h/2)F(q_0^S)-(h/2)g'(q_0^S)^T\lambda_0^S,
$$


> by solving (4.29). Next we obtain $p_0^R$ by solving (4.33)–(4.34) with $n=-1$. Then the sequences generated using $(q_0^S,p_0^S)$ as the initial point for SHAKE and that generated using $(q_0^S,p_0^R)$ in RATTLE will have identical positions (the momenta can be made compatible by simply projecting the SHAKE momenta onto the constraints).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakeRattlePositions :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-SHAKERATTLEEquivalence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakeRattlePositions_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeRattlePositions`；`MD.Ch04.shakeRattlePositions_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。；[EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。已展开projectionResidual\_j=g\_j(base−M⁻¹G(q)ᵀeta)、Gram=GM⁻¹Gᵀ、cotangentMultiplier=Gram⁻¹GM⁻¹p、cotangentProjection=p−GᵀGram⁻¹GM⁻¹p。两套真实步骤、qS0=qR0、halfS0=halfR0推出位置相同及k+1动量投影关系，是合理的条件版本，未直接假设位置相同。正质量及约束上梯度独立为实际投影所需，合理。但原文从给定SHAKE初态构造RATTLE初态，签名把半步兼容直接作假设，没有构造pR0，也无k=0的动量投影结论。宣称“同一局部唯一投影分支”的[EXTRA]实际却量化所有q、所有base、所有eta/nu，要求全局根的法向修正唯一；未限制邻域或分支，远强于局部资格并排除常见非线性约束。[ERRATUM?]初始反力符号疑误成立：由(4.29)应得oldHalf=p0−(h/2)F+(h/2)Gᵀλ0，而印刷为负号。定理体为sorry；本FAIL针对原文初始化缺项与不合理全局资格，不声称这个强假设下的条件定理必然为假。

### 7. 状态与证明位置

incomplete；`MD.Ch04.shakeRattlePositions`：未证（原书疑误不证）；`MD.Ch04.shakeRattlePositions_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L1988)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEElimination · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakeElimination :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1



/-- 修正版，对应原文 MD-4.3.5-SHAKEElimination。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakeElimination_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeElimination`；`MD.Ch04.shakeElimination_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 shakeRelation 展开为 half=p+(h/2)(F(q)−G(q)ᵀrho)，qnew=q+hM⁻¹half，g(qnew)=0，pnew=half+(h/2)(F(qnew)−G(qnew)ᵀrhonew)。签名全称量化 n,l,m,F,g,h 及四套序列，假设每一步满足该关系；用连续两步消去 p，结论以 k+1 为中心、乘子 rho(k+1)，并包含 g(q(k+2))=0；指标及量词正确，代数不需 h≠0、质量正性或光滑性。[EXTRA] 实际是更换结论公式，非额外假设；质量一致消元在数学上正确，但并非原句声称的印刷 (4.25)。[ERRATUM?] 反力缺失 M⁻¹ 的判断成立，不能对一般非标量对角质量仅重命名乘子解决。故原文忠实性 FAIL，非判定修正式为假。Ch04.lean:1120 有显式代数证明，无 sorry；未运行 Lean 编译，证明完成状态与语义结论分开。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakeElimination`：已证；`MD.Ch04.shakeElimination_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2032)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionOrder · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakePositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-SHAKEPositionOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakePositionOrder_corrected :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionOrder`；`MD.Ch04.shakePositionOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 grad U=textbookConstraintGradient U，所以 F=−∇U。constrainedSolution 在 I=[0,tau] 的每个 t 要求 q 的区间导数为 M⁻¹p，p 的区间导数为 −∇U−Gᵀrho，且 g(q)=0；textbookInverseMassMatrix=diag(m\_i⁻¹)，textbookConstraintGram=G diag(m\_i⁻¹) Gᵀ。全称量化数据与精确解后，先要求 tau>0、正质量、U/g/q 为 C⁴、p 为 C³、实际受约束解、沿紧区间 Gram 行列式非零；然后存在与 N 无关的 C>0,N0≥2，每个 N≥N0 存在离散位置及乘子，精确两步初值 qn0=q0,qn1=q(h)，满足 k+2≤N 的递推与全部 k≤N 的误差 C h²。这是真实有限区间二阶位置误差及存在性结论，不是把误差作假设。[EXTRA] 正质量、正则性、独立约束和相容起步对通常二阶收敛论述合理，但 C⁴ 全局正则及精确第二初值属于较强的充分条件，不应称为最小必要条件；结论仅选择存在的好分支，不声称所有隐式根均收敛，也不含动量误差。主要忠实性问题仍是：原页 symmetry 句紧接印刷 (4.25)，Lean 却对质量一致修正式给阶数，改变了方法；一般质量下两者甚至不逼近同一受约束解。因此 FAIL 不由 sorry 引起。Ch04.lean:1142 的证明为 sorry，二阶修正式的证明仍待完成，本审计不把它视为已验证定理。

### 7. 状态与证明位置

incomplete；`MD.Ch04.shakePositionOrder`：未证（原书疑误不证）；`MD.Ch04.shakePositionOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2078)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-AdjointEuler · definition · 印刷p.163 / PDFp.185

### 2. 原文陈述

> Now replace $h$ by $-h$ and then swap $Q$ with $q$ and $P$ with $p$, resulting in

$$
\widehat P=p-hg'(q)^T\lambda,\quad Q=q+hM^{-1}\widehat P,\quad P=\widehat P+hF(Q)-hg'(Q)^T\mu,
$$


> where $\lambda,\mu$ are again defined by the constraint conditions. This defines the adjoint method, another first order method for the constrained system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

theorem adjointEuler_inverseRelation (n l : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (_hh : h ≠ 0)
    (z out : MolecularDynamics.Chapter04Review.Z n)
    (_hz : z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hout : out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g) :
    (∃ half rho μ, adjointEulerRelation m F g h z out half rho μ) ↔
      ∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (-h) out z pbar rho μ := by
  sorry

theorem adjointEulerLocalOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E A : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 A → ContDiff ℝ 3 Φ → E 0=z → A 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖A h-Φ h‖ ≤ C*h^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.adjointEulerRelation`；`MD.Ch04.adjointEuler_inverseRelation`；`MD.Ch04.adjointEulerLocalOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；adjointEulerRelation对任意n/l、质量、F、约束、h和输入输出相点及三个辅助向量定义三式，并要求输出位置约束、输出隐藏约束。定义自身未要求输入在余切域，使用时另给；这不等同自动存在求解。inverseRelation在h≠0且两端余切约束下，对存在乘子的伴随关系与反向步长−h的正向关系给双向等价，质量无需正性，因为这里只作代数改写；乘子交换并缩放即可。该关系等价不声称局部分支唯一或逆映射存在。adjointEulerLocalOrder另设正质量、C⁴ U/g、初点Gram非零、C³ E/A/Φ、C²乘子、零步初值及μE(0)=μR(0)=0，配真实步关系和ODE，结论Euler与伴随各自局部O(h²)，数学合理且符合[EXTRA]所限定局部精度范围。未提供全局一阶或严格非二阶下界，不将局部结论冒称这些更强命题。

### 7. 状态与证明位置

incomplete；`MD.Ch04.adjointEulerRelation`：定义；`MD.Ch04.adjointEuler_inverseRelation`：未证（缺大型理论）；`MD.Ch04.adjointEulerLocalOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2117)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedComposition · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> By composing the maps $G_{h/2}$ and $G^*_{h/2}$ we get a second order symplectic method. In the sense that it is defined by first order maps which reduce to the Symplectic Euler method and its adjoint, this is an analogous scheme to the Störmer-Verlet method. Interestingly, this method is not equivalent to SHAKE or RATTLE.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedComposition :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoA μA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ q ∈ MolecularDynamics.Chapter04Review.constraintSet g, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) q)) →
    (∀ h ∈ Ioo (-η) η, ContDiff ℝ 1 (E h) ∧ ContDiff ℝ 1 (A h) ∧
      ContDiff ℝ 1 (pE h) ∧ ContDiff ℝ 1 (pA h) ∧ ContDiff ℝ 1 (rhoE h) ∧
      ContDiff ℝ 1 (μE h) ∧ ContDiff ℝ 1 (rhoA h) ∧ ContDiff ℝ 1 (μA h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h ∈ Ioo (-η) η, MolecularDynamics.Chapter04Review.restrictedSymplectic m g (A (h/2) ∘ E (h/2)) := by
  sorry

theorem constrainedComposition_circleExample :
    let m : Fin 2 → ℝ := fun _ ↦ 1
    let g : Fin 1 → (Fin 2 → ℝ) → ℝ := fun _ q ↦ (q 0)^2+(q 1)^2-1
    let F : (Fin 2 → ℝ) → Fin 2 → ℝ := fun _ ↦ 0
    let z : MolecularDynamics.Chapter04Review.Z 2 := (![1,0],![0,1])
    let e : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 15/4,1/4],![-1/4,Real.sqrt 15/4])
    let a : MolecularDynamics.Chapter04Review.Z 2 :=
      (![7/8,Real.sqrt 15/8],![-Real.sqrt 15/8,7/8])
    let r : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 3/2,1/2],![-1/2,Real.sqrt 3/2])
    ∃ pE pA pR pS ρE μE ρA μA ρR μR ρS ρSnew pSout,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (1/4) z e pE ρE μE ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m F g (1/4) e a pA ρA μA ∧
      MolecularDynamics.Chapter04Review.rattleRelation m F g (1/2) z r pR ρR μR ∧
      MolecularDynamics.Chapter04Review.shakeRelation m F g (1/2) z (r.1,pSout) pS ρS ρSnew ∧
      a.1 ≠ r.1 := by
  sorry

theorem constrainedComposition_noConstraints (n : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) :
    ((∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out pbar rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m (z.2+h • F z.1),z.2+h • F z.1)) ∧
    ((∃ half rho μ, MolecularDynamics.Chapter04Review.adjointEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out half rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2,
        z.2+h • F (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 小h光滑分支上的组合辛性、无约束退化及非等价实例；二阶精度子句由MD-4.3.5.1-ConstrainedCompositionOrder承担，原文保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedComposition`；`MD.Ch04.constrainedComposition_circleExample`；`MD.Ch04.constrainedComposition_noConstraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的固定步长、存在乘子的非等价位置实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。 | [EXTRA] |

[EXTRA] U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。；[EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的固定步长、存在乘子的非等价位置实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。；[EXTRA] 完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主定理量化n/l、正质量、C³ U/g、约束集上梯度独立以及η>0；E/A和所有辅助输出在每个|h|<η上对空间为C¹；对所有余切初点满足真实正向/伴随关系。结论仅组合在每个|h|<η上受限辛；h/2仍在窗口内，E输出在余切域，可再次应用A，故几何结论合理。这里无需步长光滑性，也没有步长光滑性，故不能由该签名附带得出二阶或对称性。circleExample：自由单位圆、m=1、初点((1,0),(0,1))，正向1/4得到e，伴随1/4得到a，RATTLE1/2得到r，SHAKE1/2存在同r位置的输出；a位置不同，确实给一组非等价候选更新。noConstraints准确退化为kick-drift Euler和drift-kick伴随，对任意质量/F/h成立，未声称任意F下辛。完整原文二阶子句仍须外部委托声明，按本任务材料不能核验；实例单值近分支资格也未覆盖。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedComposition`：未证（缺大型理论）；`MD.Ch04.constrainedComposition_circleExample`：未证（缺大型理论）；`MD.Ch04.constrainedComposition_noConstraints`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2153)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedCompositionOrder · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> By composing the maps $G_{h/2}$ and $G^*_{h/2}$ we get a second order symplectic method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedCompositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE muE rhoA muA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → MolecularDynamics.Chapter04Review.Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 组合方法O(h³)局部误差（二阶精度）子句；辛性、退化及非等价实例由MD-4.3.5.1-ConstrainedComposition承担；不冒充全局二阶收敛。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedCompositionOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。 | [EXTRA] |

[EXTRA] 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。；[EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词覆盖任意有限维n、约束数l、正质量、C⁴势和约束，以及在同一对称步长窗口内满足两种离散关系的C³相空间映射E、A。初值恒等且muE在零步长为零；起点属于余切约束集且Gram行列式非零。对任意同初值C³精确局部ODE轨道，结论是正小步长局部误差≤C h³；不是全局误差估计。辛性不在本签名中，已由statement\_scope明确分出，外部ConstrainedComposition未在本任务提供，不能据本条认证它。projectedEulerRelation末次修正未乘h，是将原页乘子hμ吸收到muE中的参数化；muE 0 z=0与该参数化相容。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedCompositionOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2201)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-MomentumProjector · definition · 印刷p.163 / PDFp.185

### 2. 原文陈述

> where $\Pi$ is a mass-weighted projector onto the tangent space of the constraints at the point $q$ defined by

$$
\Pi=I-g'(q)^T[g'(q)M^{-1}g'(q)^T]^{-1}g'(q)M^{-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def momentumProjector {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q : MolecularDynamics.Chapter04Review.Q n) :=
  (1 : Matrix (Fin n) (Fin n) ℝ)-(textbookConstraintJacobian g q)ᵀ *
    (textbookConstraintGram m g q)⁻¹ * textbookConstraintJacobian g q * textbookInverseMassMatrix m
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.momentumProjector` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 MolecularDynamics.Chapter04Review 的 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v=(m\_i⁻¹ v\_i)、constraintSet g={q|∀j,g\_j(q)=0}、cotangentSet m g={z|g(z.1)=0且G(z.1)M⁻¹z.2=0}。G=textbookConstraintJacobian，其(j,i)项为 fderiv ℝ (g j) q (Pi.single i 1)；grad U 同样取 U 的实际坐标 Fréchet 导数；textbookInverseMassMatrix=diag(m\_i⁻¹)；textbookConstraintGram=GM⁻¹Gᵀ。出处：依赖摘录 ConstrainedProjection.lean:2975–2977、CotangentProjection.lean:3385–3420、ReviewDefinitions.lean:4377–4444（行号均为附件行号）。 Ch04.lean:1198–1200 与依赖 ReviewDefinitions.lean:4503–4505 同为 I−Gᵀ(GM⁻¹Gᵀ)⁻¹GM⁻¹，矩阵顺序与 PDF185 完全一致。原文 tangent space 的措辞须按动量/速度的质量识别解释：Π 的像是 ker(GM⁻¹)，并非一般的速度切空间 ker G；context\_notation 已明确此点，未静默更改书中公式。正质量、Gram非奇异时 Π²=Π、GM⁻¹Π=0，对 M⁻¹ 内积自伴；M⁻¹Πp 对应切速度。具体地 G=(1,1), M=diag(1,2) 时 Π(1,0)=(1/3,−2/3)，GΠ(1,0)=−1/3 而 GM⁻¹Π(1,0)=0。这排除了把书中语句误读成欧氏正交速度投影。这里审核的是带已有 context 资格的公式定义，不是无条件投影定理；Lean 的总定义在奇异Gram、零质量处依然有值，不能据此宣称那些点也是投影。没有 [EXTRA] 或 [ERRATUM?] 标记，也没有 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.momentumProjector`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2217)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedPotentialFlow · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> For the potential energy term, an exact solution is given by $Q=q,\quad P=p-h\Pi(q)\nabla U(q)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedPotentialFlow :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n),
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    (∀ j, Differentiable ℝ (g j)) → ∀ t : ℝ,
    let P := fun s : ℝ => z.2-s • (MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1)
    (z.1,P t) ∈ MolecularDynamics.Chapter04Review.cotangentSet m g ∧ HasDerivAt P (-MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1) t := by
  intro n l m U g z hz hdet hg t
  rcases hz with ⟨hq,hp⟩
  let u := MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ MolecularDynamics.Chapter04Review.grad U z.1
  have hi : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.invMass m v=textbookInverseMassMatrix m *ᵥ v := by
    intro v
    ext i
    simp [MolecularDynamics.Chapter04Review.invMass,textbookInverseMassMatrix,Matrix.mulVec_diagonal]
  have hproj : ∀ v : Fin n → ℝ, MolecularDynamics.Chapter04Review.momentumProjector m g z.1 *ᵥ v=textbookCotangentProjection m g z.1 v := by
    intro v
    simp only [MolecularDynamics.Chapter04Review.momentumProjector,Matrix.sub_mulVec,Matrix.one_mulVec,
      textbookCotangentProjection,textbookCotangentMultiplier,Matrix.mulVec_mulVec,Matrix.mul_assoc]
  have hu : textbookConstraintJacobian g z.1 *ᵥ (textbookInverseMassMatrix m *ᵥ u)=0 := by
    dsimp [u]
    rw [hproj]
    exact textbookCotangentProjection_hiddenConstraint m g z.1 _ hdet
  rw [hi] at hp
  constructor
  · change z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
      textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m (z.2-t • u)=0
    refine ⟨hq,?_⟩
    rw [hi,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_sub,Matrix.mulVec_smul,hp,hu]
    simp
  · simpa [u,Matrix.neg_mulVec] using (((hasDerivAt_id t).smul_const u).const_sub z.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedPotentialFlow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]签名采用真实Gram行列式非零、可微约束及初始余切约束；正质量和独立约束是通常物理资格的充分条件。只证势能子流的固定位置与投影动量ODE。 | [EXTRA] |

[EXTRA] [EXTRA]签名采用真实Gram行列式非零、可微约束及初始余切约束；正质量和独立约束是通常物理资格的充分条件。只证势能子流的固定位置与投影动量ODE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 MolecularDynamics.Chapter04Review 的 Q n=Fin n→ℝ、Z n=Q n×Q n、invMass m v=(m\_i⁻¹ v\_i)、constraintSet g={q|∀j,g\_j(q)=0}、cotangentSet m g={z|g(z.1)=0且G(z.1)M⁻¹z.2=0}。G=textbookConstraintJacobian，其(j,i)项为 fderiv ℝ (g j) q (Pi.single i 1)；grad U 同样取 U 的实际坐标 Fréchet 导数；textbookInverseMassMatrix=diag(m\_i⁻¹)；textbookConstraintGram=GM⁻¹Gᵀ。出处：依赖摘录 ConstrainedProjection.lean:2975–2977、CotangentProjection.lean:3385–3420、ReviewDefinitions.lean:4377–4444（行号均为附件行号）。 Ch04.lean:1204–1210 的 let P(s)=p−sΠ(q)∇U(q) 显式固定 q；∀t 的结论既保留 g(q)=0 和 GM⁻¹P(t)=0，也给出 P′(t)=−Π(q)∇U(q)。因此 Q=q、P=p−tΠ∇U 的具体解以及投影动量ODE均已表达。q 常值的零导数是该表达的直接语义，不需要把公式改成泛称 solution。乘子可取 −(GM⁻¹Gᵀ)⁻¹GM⁻¹∇U，故 P′=−∇U−Gᵀlambda，与势能子流一致。[EXTRA] 初始余切域和非奇异Gram是自然资格，可微约束合理（实际该证明只用代数关系，可弱化）；不需要势能 Hessian，固定位置使斜率常值。U 没有可微假设，fderiv 在不可微点取总化默认值，故作为 Lean 代数恒等式结论仍成立；物理 Hamiltonian 解释应限制 U 在 q 可微，这是语义域资格，不把该总化扩展误当非光滑经典流。原文没有要求流的唯一性/全局存在性定理。无 [ERRATUM?]。此 theorem 的附件正文有实际证明且未出现 sorry，但本次未运行 Lean 编译，不作编译通过声明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedPotentialFlow`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2223)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-GeodesicRelation · definition · 印刷p.164 / PDFp.186

### 2. 原文陈述

> The constrained flow on the kinetic energy term, on the other hand, is generated by the equations of motion

$$
\frac{dq}{dt}=M^{-1}p,\quad\frac{dp}{dt}=-g'(q)^T\lambda,\quad0=g(q).
$$


> This is nothing other than the mass-weighted geodesic flow on the given constraint surface.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) (_hm : ∀ i, 0 < m i)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) : Prop :=
  MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ => 0) g q p rho I

def massMetric {n : ℕ} (m : Fin n → ℝ) (u v : Fin n → ℝ) : ℝ :=
  ∑ i, m i*u i*v i

theorem geodesicRelation_massMetric (n l : ℕ) (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (I : Set ℝ) (_hI : IsOpen I)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n) (_hq : ContDiff ℝ 2 q)
    (_hc : ∀ t ∈ I, ∀ j, g j (q t)=0)
    (_hreg : ∀ t ∈ I, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) (q t))) :
    (∀ t ∈ I, ∀ ξ : MolecularDynamics.Chapter04Review.Q n,
      textbookConstraintJacobian g (q t) *ᵥ ξ=0 →
        massMetric m (deriv (deriv q) t) ξ=0) ↔
    ∃ p rho, (∀ t ∈ I, p t=fun i ↦ m i*deriv q t i) ∧
      MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ ↦ 0) g q p rho I := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.geodesicRelation`；`MD.Ch04.massMetric`；`MD.Ch04.geodesicRelation_massMetric` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补正质量诱导度量∑m\_i u\_i v\_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。 | [EXTRA] |

[EXTRA] [EXTRA] 补正质量诱导度量∑m\_i u\_i v\_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Q=Fin n→ℝ；constrainedSolution实际被引用的是Chapter04Review中以力F为参数的版本，而非同名MD中以势U为参数的版本。F=0展开后正好是qdot=M⁻¹p、pdot=−Dgᵀrho及g(q)=0。IsOpen使within导数与普通导数一致。massMetric为Σm\_i u\_i v\_i；等价定理在C²约束、C²轨道、轨道留在约束面且梯度线性无关条件下，将质量正交加速度与存在p=M qdot及乘子对应。量词顺序允许选取整条轨道上的p、rho；不要求额外全局流存在。

### 7. 状态与证明位置

incomplete；`MD.Ch04.geodesicRelation`：定义；`MD.Ch04.massMetric`：定义；`MD.Ch04.geodesicRelation_massMetric`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2255)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-MShakeIteration · definition · 印刷p.164 / PDFp.186

### 2. 原文陈述

> M-Shake This is Newton-iteration-based implementation of SHAKE, using (4.18)–(4.19) to solve Eqs. (4.27)–(4.29).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mShakeIteration {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ) := (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mShakeIteration` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean、ConstrainedProjection.lean 与 CotangentProjection.lean：Q n=Fin n→ℝ；textbookConstraintGradient (g j) x i=(fderiv ℝ (g j) x)(Pi.single i 1)；G(x) 的 j,i 元为该梯度；invMass m v i=(m i)⁻¹v i，textbookInverseMassMatrix m=diag((m i)⁻¹)。令 x(η)=base−M⁻¹G(q)ᵀη，则 residual(η)=g(x(η))，projectionJacobian(η)=G(x(η))M⁻¹G(q)ᵀ，newtonConstraint(η)=η+projectionJacobian(η)⁻¹residual(η)。残差的真正导数为上述矩阵的负值，故更新中的加号正确，逐项对应 PDF179/印刷157 的(4.18)–(4.19)。mShakeIteration 将此实际更新从零复合 k 次，k=0 返回零，不是恒等占位或冻结雅可比更新。这里 base 是已消去显式动力学更新后的无约束位置，η 吸收步长因子；在 SHAKE 中可取 base=q+hM⁻¹p+(h²/2)M⁻¹F(q)，η=(h²/2)ρ，对应 PDF183 的(4.27)–(4.28)。正文允许零初值，context\_notation 明确本条仅记录有限次迭代，未声称已经精确求解、收敛或构成完整相空间时间步。自然数 n,l,k 与 m,g,q,base 均为定义参数，无存在性或全称收敛命题。定义没有假设正质量、可微性或每步可逆；Lean 的逆与 fderiv 在退化输入上是总化运算，这只扩展定义域，不能将退化输入解释为有效物理 Newton 求解。没有 [EXTRA] 或 [ERRATUM?] 标签；本定义无 sorry。签名在所标明有限迭代范围内忠实。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mShakeIteration`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2277)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-SETTLE · definition · 印刷p.165 / PDFp.187

### 2. 原文陈述

> SETTLE The SETTLE method [274] is just the SHAKE approach applied to a small system combined with an exact solve of the nonlinear equations. It is usually applied to treat rigid bodies (as discussed in the following section).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def settleRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop := MolecularDynamics.Chapter04Review.projectionResidual m g q base η=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.settleRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正文没有闭式算法细节，仅登记真实小系统residual=0关系；不发明SETTLE闭式或存在定理。 | [EXTRA] |

[EXTRA] [EXTRA]正文没有闭式算法细节，仅登记真实小系统residual=0关系；不发明SETTLE闭式或存在定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 projectionResidual、Q、invMass、textbookConstraintJacobian、textbookConstraintGradient 和 textbookInverseMassMatrix，具体表达同上一条：settleRelation m g q base η 等价于 ∀j, g j(base−M⁻¹G(q)ᵀη)=0。这是 SHAKE 消元后的真实非线性方程的精确解关系；等号是精确等号，没有误差容限。全部 n,l,m,g,q,base,η 为参数；无解的输入可以使关系为假，不宣称存在、唯一性、闭式求解器或输出算法。[EXTRA] 是明确的范围说明而非额外逻辑前提：正文没有给出 SETTLE 的专门求解公式，故记录解关系是合理的最小数学登记。小系统与通常用于刚体是应用范围描述，书中没有给出维数上界或只允许刚体的全称限制；不应自行添加 n 或 l 的数值界。此泛化关系不区分 SETTLE 与其他精确求解同一方程的方法，不能单凭此定义宣称已经形式化 SETTLE 的专门算法，但附件已明确只登记关系，因此本条按该范围 PASS。无 [ERRATUM?]，定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.settleRelation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2282)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-LINCSInverse · definition · 印刷p.165 / PDFp.187

### 2. 原文陈述

> LINCS In solving the Eqs. (4.27)–(4.29) by Newton iteration, the largest cost and the most significant barrier to parallelization is the linear solve. The LINCS method [119, 175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.lincsInverse` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。 | [EXTRA] |

[EXTRA] [EXTRA]标准Neumann有限和Σ(j=0..k) C^j表达series inverse，正文没有印系数公式；收敛条件另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限阶实方阵C和自然数k，range(k+1)给出从0至k共k+1项，含单位阵C⁰。定义的是归一化逆(I−C)⁻¹的Neumann截断，不是原始Newton矩阵逆的完整LINCS实现；原书仅定性提及级数，没有该公式。作为显式EXTRA的标准模型合理，需补明归一化及范围。

### 7. 状态与证明位置

self-contained；`MD.Ch04.lincsInverse`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2287)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.6-LINCSConvergence · unnumbered_claim · 印刷p.165 / PDFp.187

### 2. 原文陈述

> The LINCS method [119, 175] uses a series expansion to approximate the inverse matrix (which is valid only under certain conditions).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lincsConvergence :
  ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (MolecularDynamics.Chapter04Review.lincsInverse C) atTop (𝓝 ((1-C)⁻¹)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.lincsConvergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。 | [EXTRA] |

[EXTRA] [EXTRA]明确实际连续线性算子C.toLin'.toContinuousLinearMap的范数<1；不使用逐元素最大范数作为Neumann收敛资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意l及实方阵C；假设是C在Fin l→ℝ上的连续线性算子范数<1，而非逐元素最大值。结论是k→∞时Σ(j=0..k)C^j在矩阵空间收敛到(I−C)⁻¹，逆是矩阵逆。有限维下算子与矩阵拓扑相容，条件足以保证可逆与收敛；包含l=0也无矛盾。只是充分条件，不断言必要性，也未证明实际LINCS矩阵必满足此条件。

### 7. 状态与证明位置

incomplete；`MD.Ch04.lincsConvergence`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2291)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-WaterPairPotential · definition · 印刷p.166–167 / PDFp.188–189

### 2. 原文陈述

> The potential energy for the interaction of a pair of such molecules, the sets of whose charge sites are denoted by $A$ and $B$, takes the form

$$
\varphi^{\rm water-water}=\sum_{i\in A}\sum_{j\in B}\frac{k_1Q_iQ_j}{r_{ij}}+\frac{k_2}{r_{OO}^{12}}-\frac{k_3}{r_{OO}^{6}},
$$


> where $r_{OO}$ represents the distance between the oxygen atoms of the two molecules, and $k_1,k_2,k_3$ are positive constants.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.waterPairPotential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。 | [EXTRA] |

[EXTRA] 有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两个有限电荷集合用Fin a、Fin b参数化；Coulomb双和、氧间12次排斥和6次吸引的符号、指数及系数均对应原式。签名接受所有实数，实际没有k1,k2,k3及距离的正性前提；这是Lean实数除法的全定义代数表达式，在正文正参数、正距离域上解释为势能。应纠正EXTRA中仿佛已限制形式定义域的表述，不应把零距离处的形式值解释为物理势。

### 7. 状态与证明位置

self-contained；`MD.Ch04.waterPairPotential`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2298)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-TotalMass · definition · 印刷p.167 / PDFp.189

### 2. 原文陈述

> where $M=\sum_{i=1}^Nm_i$ is the total mass.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.totalMass` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3 → ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；有限和按 Fin N 编号，对应原文1至N。 展开正式库 totalMass m=∑ i,m i；本地定义相同，准确表达总质量。没有额外假设或勘误。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.totalMass`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2303)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CenterMass · definition · 印刷p.167 / PDFp.189

### 2. 原文陈述

> The atomic positions may be referred to a coordinate system placed at the center of mass of the collection $q_{\rm cm}=\frac{\sum_{i=1}^Nm_iq_i}{M}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  (MolecularDynamics.Chapter04Review.totalMass m)⁻¹ • ∑ i, m i • q i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.centerMass` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；位置是三维实向量，质量是任意实权重；totalMass确为Σm\_i。逆总质量的标量作用等于原式向量除以M。定义无M≠0前提，Lean取0⁻¹=0；在物理应用域M>0时忠实，在M=0时只是代数延拓。原文没有给零总质量情形赋予质心含义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.centerMass`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2306)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RelativePositions · definition · 印刷p.167 / PDFp.189

### 2. 原文陈述

> We write $q_i=q_{\rm cm}+\delta_i$, where $\sum_{i=1}^Nm_i\delta_i=0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V) : Fin N → MolecularDynamics.Chapter04Review.V :=
  fun i => q i-MolecularDynamics.Chapter04Review.centerMass m q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅q\_i=q\_cm+δ\_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.relativePositions` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅q\_i=q\_cm+δ\_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅q\_i=q\_cm+δ\_i的相对位置定义；加权零和由MD-4.4-RelativeWeightedZero承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意N、实质量和三维位置，逐项定义δ\_i=q\_i−centerMass m q，故q\_i=q\_cm+δ\_i恒成立。仅定义相对位置；未在本声明得出Σm\_iδ\_i=0。该后件已明确分配给RelativeWeightedZero，未在本任务给出，不能声称已核验该外部定理；尤其不能在任意总质量为零的实权重上无条件推广零和。

### 7. 状态与证明位置

self-contained；`MD.Ch04.relativePositions`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2311)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RelativeWeightedZero · unnumbered_claim · 印刷p.167 / PDFp.189

### 2. 原文陈述

> We write $q_i=q_{\rm cm}+\delta_i$, where $\sum_{i=1}^Nm_i\delta_i=0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem relativeWeightedZero : ∀ N (m : Fin N → ℝ) (q : Fin N → MolecularDynamics.Chapter04Review.V),
    MolecularDynamics.Chapter04Review.totalMass m ≠ 0 → (∑ i, m i • MolecularDynamics.Chapter04Review.relativePositions m q i)=0 := by
  intro N m q hm
  simp only [MolecularDynamics.Chapter04Review.relativePositions,smul_sub,Finset.sum_sub_distrib,← Finset.sum_smul]
  rw [MolecularDynamics.Chapter04Review.centerMass,smul_smul]
  change (∑ i, m i • q i)-(MolecularDynamics.Chapter04Review.totalMass m * (MolecularDynamics.Chapter04Review.totalMass m)⁻¹) • (∑ i, m i • q i)=0
  rw [mul_inv_cancel₀ hm,one_smul,sub_self]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.relativeWeightedZero` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 总质量非零；原物理正质量给此资格，空体系排除。 | [EXTRA] |

[EXTRA] 总质量非零；原物理正质量给此资格，空体系排除。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖 Ch04\_deps.txt 的 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3 → ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；有限和按 Fin N 编号，对应原文1至N。 展开 relativePositions、centerMass、totalMass 后，结论就是∑m\_i(q\_i-(∑m\_j q\_j)/M)=0，前提M≠0。该[EXTRA]合理且对任意实权重的推广一般必要：两权重1,-1、位置e1,0时M=0而加权和非零。正物理质量非空体系满足它；空体系零和本身成立，注释“空体系排除”只说明本签名不覆盖空体系而非其为反例。原句位置分解由展开减法自动成立，结论零和完整。该定理有实际by证明，无sorry；未运行编译，签名审计不等于编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.relativeWeightedZero`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2316)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-KineticSplit · unnumbered_claim · 印刷p.167 / PDFp.189

### 2. 原文陈述

> Thus the kinetic energy becomes

$$
K=\frac12\sum_{i=1}^Nm_i\|\dot q_{\rm cm}\|^2+\sum_{i=1}^Nm_i\dot q_{\rm cm}\cdot\dot\delta_i+\frac12\sum_{i=1}^Nm_i\|\dot\delta_i\|^2 =\frac M2\|\dot q_{\rm cm}\|^2+\frac12\sum_{i=1}^Nm_i\|\dot\delta_i\|^2,
$$


> where we have used the fact that $\sum_{i=1}^Nm_i\delta_i\equiv0$, hence that the time derivative also vanishes, in order to remove the middle term.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kineticSplit :
  ∀ N (m : Fin N → ℝ) (v : MolecularDynamics.Chapter04Review.V) (w : Fin N → MolecularDynamics.Chapter04Review.V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i))/2=MolecularDynamics.Chapter04Review.totalMass m*MolecularDynamics.Chapter04Review.dot v v/2+(∑ i,m i*MolecularDynamics.Chapter04Review.dot (w i) (w i))/2 := by
  intro N m v w hz
  have h0 := congrFun hz 0
  have h1 := congrFun hz 1
  have h2 := congrFun hz 2
  simp only [Finset.sum_apply,Pi.smul_apply,smul_eq_mul,Pi.zero_apply] at h0 h1 h2
  have he : ∀ i, MolecularDynamics.Chapter04Review.dot (v+w i) (v+w i)=
      MolecularDynamics.Chapter04Review.dot v v+2*MolecularDynamics.Chapter04Review.dot v (w i)+MolecularDynamics.Chapter04Review.dot (w i) (w i) := by
    intro i
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have ht : ∀ a : Fin 3, (∑ i, m i*(v a*w i a))=v a*∑ i,m i*w i a := by
    intro a
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  have hc : ∑ i, m i*MolecularDynamics.Chapter04Review.dot v (w i)=0 := by
    simp only [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,mul_add,Finset.sum_add_distrib]
    rw [ht 0,ht 1,ht 2,h0,h1,h2]
    ring
  simp_rw [he,mul_add,Finset.sum_add_distrib]
  rw [← Finset.sum_mul]
  have hx : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=0 := by
    rw [show (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot v (w i)))=2*∑ i,m i*MolecularDynamics.Chapter04Review.dot v (w i) by rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro i hi; ring,hc,mul_zero]
  rw [hx]
  simp [MolecularDynamics.Chapter04Review.totalMass]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.kineticSplit` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意N、实权重、公共速度v及相对速度w\_i，以Σm\_i w\_i=0为前提，给出Σm\_i|v+w\_i|²/2=M|v|²/2+Σm\_i|w\_i|²/2。dot实际为坐标乘积和，确为欧氏内积；代数上不需要质量正性。签名没有时间变量、轨道或求导，故原文从Σm\_iδ\_i恒零推导其时间导数为零这一解释应明确属于应用背景，前提hz是其速度层面的代数输入。

### 7. 状态与证明位置

self-contained；`MD.Ch04.kineticSplit`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2325)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SecondMoment · definition · 印刷p.168 / PDFp.190

### 2. 原文陈述

> where the fixed matrix $R$ is given by $R=\sum_{i=1}^Nm_i\delta_i(0)\delta_i(0)^T$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := ∑ i, m i • MolecularDynamics.Chapter04Review.outer (δ i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.secondMoment` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限N、实权重及三维参考向量δ，outer v的(i,j)分量为v\_i v\_j，有限和正是R=Σm\_iδ\_i(0)δ\_i(0)ᵀ。δ参数应解释为固定初始参考位置，不是随时间的当前位置；定义没有错误引入时间依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch04.secondMoment`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2358)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationKinetic · definition · 印刷p.168 / PDFp.190

### 2. 原文陈述

> $K_{\rm rot}=\frac12\sum_{i=1}^Nm_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0)$. This expression may be rewritten as $K_{\rm rot}=\frac12\operatorname{Tr}[\dot\Theta R\dot\Theta^T]$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rotationKinetic (R dΘ : MolecularDynamics.Chapter04Review.Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationKinetic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅旋转动能trace定义；粒子有限和及两式等价由MD-4.4-RotationTraceIdentity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意两个实3×3矩阵R、dΘ，定义trace(dΘ R dΘᵀ)/2。R的质量外积结构及dΘ为旋转轨道导数是应用解释，并非此代数定义的前提。有限粒子和与trace的等价已在明确scope中分给下一条RotationTraceIdentity；本条不单独声称两式等价。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationKinetic`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2362)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationTraceIdentity · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> $K_{\rm rot}=\frac12\sum_{i=1}^Nm_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0)$. This expression may be rewritten as $K_{\rm rot}=\frac12\operatorname{Tr}[\dot\Theta R\dot\Theta^T]$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (dΘ : MolecularDynamics.Chapter04Review.Mat3),
    (∑ i, m i*MolecularDynamics.Chapter04Review.dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      MolecularDynamics.Chapter04Review.rotationKinetic (MolecularDynamics.Chapter04Review.secondMoment m δ) dΘ := by
  intro N m δ dΘ
  unfold MolecularDynamics.Chapter04Review.rotationKinetic MolecularDynamics.Chapter04Review.secondMoment
  rw [Matrix.mul_sum,Matrix.sum_mul,Matrix.trace_sum]
  rw [Finset.sum_div,Finset.sum_div]
  apply Finset.sum_congr rfl
  intro i hi
  simp [Matrix.trace,Matrix.mul_apply,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationTraceIdentity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意N、实权重m、三维参考向量δ和任意实3×3矩阵dΘ，结论将Σm\_i dot(dΘδ\_i,dΘδ\_i)/2等于rotationKinetic(secondMoment m δ,dΘ)。展开后恰是δ\_iᵀdΘᵀdΘδ\_i与trace形式的恒等式；不需正交或正质量，使用任意矩阵比物理应用更一般且正确。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationTraceIdentity`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2365)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationSkew · unnumbered_claim · 印刷p.168–169 / PDFp.190–191

### 2. 原文陈述

> Moreover, since $\Theta\Theta^T=I$, we have $\dot\Theta\Theta^T+\Theta\dot\Theta^T=0$, which indicates that $\dot\Theta\Theta^T$ is a skew symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationSkew :
  ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ) := by
  intro Θ t d hd ho
  have hs : ∀ i j : Fin 3, ∑ k, (d i k*Θ t j k+Θ t i k*d j k)=0 := by
    intro i j
    have hf : HasDerivAt (fun s => ∑ k, Θ s i k*Θ s j k)
        (∑ k, (d i k*Θ t j k+Θ t i k*d j k)) t := by
      apply HasDerivAt.fun_sum
      intro k hk
      exact ((hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) k).mul (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd j) k))
    have he : (fun s => ∑ k, Θ s i k*Θ s j k) =ᶠ[𝓝 t] (fun _ => (1 : MolecularDynamics.Chapter04Review.Mat3) i j) := by
      filter_upwards [ho] with s h
      simpa [Matrix.mul_apply,Matrix.transpose_apply] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) h
    exact hf.unique ((hasDerivAt_const t ((1 : MolecularDynamics.Chapter04Review.Mat3) i j)).congr_of_eventuallyEq he)
  ext i j
  have h := hs i j
  simp only [Fin.sum_univ_three] at h
  simp [Matrix.mul_apply,Matrix.transpose_apply,Fin.sum_univ_three]
  nlinarith [h]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationSkew` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。 | [EXTRA] |

[EXTRA] 真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词为真实矩阵轨道Θ、时刻t及导数d；HasDerivAt给出真实导数，邻域eventually正交条件足以对ΘΘᵀ=I求导。结论是(d*(Θ t)ᵀ)ᵀ=−(d*(Θ t)ᵀ)，即乘积d*(Θ t)ᵀ反对称。由矩阵转置乘法公式，它等价于d*(Θ t)ᵀ+Θ t*dᵀ=0，故同时涵盖原文中间恒等式；未将待证导数恒等式放入假设。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationSkew`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2379)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SkewMatrix · (4.38) · 印刷p.169 / PDFp.191

### 2. 原文陈述

> Any $3\times3$ skew matrix may be written as

$$
\dot\Theta\Theta^T=\operatorname{skew}(\omega)\equiv\begin{bmatrix}0&-\omega_3&\omega_2\\\omega_3&0&-\omega_1\\-\omega_2&\omega_1&0\end{bmatrix}.\tag{4.38}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.skewMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；三维实向量映为实3×3矩阵，0基坐标v 0、v 1、v 2分别对应原书ω₁、ω₂、ω₃；六个非对角元的符号全部正确，主对角为0。scope仅定义；任意反对称矩阵的表示由本批第15条给出，旋转导数反对称性由第12条给出。

### 7. 状态与证明位置

self-contained；`MD.Ch04.skewMatrix`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2402)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CrossProduct · definition · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $\frac d{dt}\delta_i=\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cross3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意三维实向量u、v，三个分量依次是u₂v₃−u₃v₂、u₃v₁−u₁v₃、u₁v₂−u₂v₁，符合右手叉积。定义本身不涉及真实时间导数或完整三个等号；scope已明确，第17条承担导数结论。外部CrossIdentityFull未在本任务给出，不能把本条定义当作已核验该外部完整声明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cross3`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2406)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SkewRepresentation · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> Any $3\times3$ skew matrix may be written as

$$
\dot\Theta\Theta^T=\operatorname{skew}(\omega)\equiv\begin{bmatrix}0&-\omega_3&\omega_2\\\omega_3&0&-\omega_1\\-\omega_2&\omega_1&0\end{bmatrix}.\tag{4.38}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem skewRepresentation : ∀ A : MolecularDynamics.Chapter04Review.Mat3, Aᵀ = -A → ∃! «ω» : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix «ω»=A := by
  intro A ha
  have hs : ∀ i j : Fin 3, A j i= -A i j := by
    intro i j
    simpa using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) ha
  refine ⟨![A 2 1,A 0 2,A 1 0],?_,?_⟩
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.skewMatrix] <;> nlinarith [hs 0 0,hs 0 1,hs 0 2,hs 1 1,hs 1 2,hs 2 2]
  · intro w hw
    ext i
    fin_cases i
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 2 1) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 0 2) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 1 0) hw
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.skewRepresentation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意实3×3矩阵A，在Aᵀ=−A前提下，存在唯一实三维向量ω使Chapter04Review.skewMatrix ω=A。该依赖的坐标定义与本批MD版本相同。原文只说可表示，唯一性是正确加强：ω=(A₃₂,A₁₃,A₂₁)，与Lean的![A 2 1,A 0 2,A 1 0]相同；无额外隐藏前提。

### 7. 状态与证明位置

self-contained；`MD.Ch04.skewRepresentation`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2409)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CrossMatrix · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem crossMatrix :
  ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v := by
  intro u v
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.crossMatrix` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。 | [EXTRA] |

[EXTRA] [EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。；[EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意三维实向量u、v，证明skewMatrix u *ᵥ v=cross3 u v，类型、乘法方向及右手符号均正确。结论仅为原文代数链首等式；另一等式等价于叉积反交换性。本条scope和EXTRA已声明此分工；未提供的CrossIdentityFull签名不在本批认证范围。

### 7. 状态与证明位置

self-contained；`MD.Ch04.crossMatrix`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2427)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RigidVelocity · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $\frac d{dt}\delta_i=\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$, which is the usual definition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidVelocity : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (dΘ : MolecularDynamics.Chapter04Review.Mat3) (δ «ω» : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ=MolecularDynamics.Chapter04Review.skewMatrix «ω» →
    HasDerivAt (fun s => Θ s *ᵥ δ) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ)) t := by
  intro Θ dΘ δ «ω» t hd ho hs
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,dΘ i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  have hv : HasDerivAt (fun s => Θ s *ᵥ δ) (dΘ *ᵥ δ) t := hasDerivAt_pi.mpr he
  have hi : (Θ t)ᵀ*Θ t=1 := mul_eq_one_comm.mp ho
  have hcross : MolecularDynamics.Chapter04Review.skewMatrix «ω» *ᵥ (Θ t *ᵥ δ)=
      MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ) := by
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
  rw [← hcross,← hs,Matrix.mulVec_mulVec,Matrix.mul_assoc,hi,Matrix.mul_one]
  exact hv
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidVelocity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。 | [EXTRA] |

[EXTRA] 给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。；[EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意矩阵轨道Θ、候选导数dΘ、固定参考向量δ、空间角速度ω及t；前提HasDerivAt、时刻t的ΘΘᵀ=I以及dΘΘᵀ=skew(ω)足以推出真实轨道s↦Θ(s)δ的导数为ω×(Θ(t)δ)。参考δ与原文δ\_i(0)对应，结果中的Θ(t)δ才是当前δ\_i。方阵单侧正交足以推出反侧正交，不需另加邻域正交。已明示只承担导数与叉积的等式；完整代数链所指外部CrossIdentityFull未提供，不作额外认证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidVelocity`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2436)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaTensor · definition · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $K_{\rm rot}=\frac12\omega_b^TT\omega_b$, where the matrix $T=-\sum_{i=1}^Nm_i\operatorname{skew}(\delta_i(0))^2$ is referred to as the moment of inertia tensor or simply the inertia tensor and can be written as

$$
T=\sum_{i=1}^Nm_i[\|\delta_i(0)\|^2I-\delta_i(0)\delta_i(0)^T].
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω\_b关系由MD-4.4-RotationBodyEnergy承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaTensor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω\_b关系由MD-4.4-RotationBodyEnergy承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω\_b关系由MD-4.4-RotationBodyEnergy承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限N、实质量权m和三维参考向量δ，返回3×3实矩阵Σm\_i((δ\_i·δ\_i)I−δ\_iδ\_iᵀ)。dot、outer和单位矩阵展开均吻合欧氏公式；无需正质量前提即可定义。按显式statement\_scope仅核对该定义；本声明不证明skew平方或动能恒等式，跨条目分工不当作本声明已经证明的内容。

### 7. 状态与证明位置

self-contained；`MD.Ch04.inertiaTensor`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2456)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-CrossIdentityFull · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem crossIdentityFull : ∀ u v : MolecularDynamics.Chapter04Review.V,
    MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v ∧
    MolecularDynamics.Chapter04Review.cross3 u v= -(MolecularDynamics.Chapter04Review.skewMatrix v *ᵥ u) := by
  intro u v
  constructor <;> ext i <;> fin_cases i <;>
    simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.crossIdentityFull` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 skewMatrix u 展开为 [[0,−u₂,u₁],[u₂,0,−u₀],[−u₁,u₀,0]]；cross3 u v 展开为 (u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)。∀u v 的合取恰含两条等式，Lean 0基索引对应原书1基索引。任意实向量的代数恒等式无需运动学假设。没有 [EXTRA]/[ERRATUM?]。该声明有显式证明且未见 sorry；此与签名 PASS 分开记录。

### 7. 状态与证明位置

self-contained；`MD.Ch04.crossIdentityFull`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2460)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationalEnergy · definition · 印刷p.169 / PDFp.191

### 2. 原文陈述

> It is convenient to express this in terms of the so-called body angular velocity $\omega_b=\Theta^T\omega$ in which case it becomes $K_{\rm rot}=\frac12\omega_b^TT\omega_b$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) (ωb : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot ωb (T *ᵥ ωb)/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅体角速度ω\_b的二次型能量定义；ω\_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationalEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅体角速度ω\_b的二次型能量定义；ω\_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅体角速度ω\_b的二次型能量定义；ω\_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意3×3实矩阵T与三维实向量ωb映到ωb·(Tωb)/2，完整表达所声明的二次型定义。ωb=Θᵀω及真实粒子动能由本批第8条实际核对；这里不把任意T、ωb当作已满足刚体运动关系的对象。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationalEnergy`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2469)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaSkewIdentity · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $T=-\sum_{i=1}^Nm_i\operatorname{skew}(\delta_i(0))^2$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem inertiaSkewIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.inertiaTensor m δ= -∑ i, m i • (MolecularDynamics.Chapter04Review.skewMatrix (δ i))^2 := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v= -(MolecularDynamics.Chapter04Review.skewMatrix v)^2 := by
    intro v
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mul_apply,Fin.sum_univ_three,pow_two] <;> ring
  simp [MolecularDynamics.Chapter04Review.inertiaTensor,he,Finset.sum_neg_distrib]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaSkewIdentity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 inertiaTensor m δ 展开为 ∑i m\_i( (∑j δ\_ij²)I−δ\_iδ\_iᵀ)。skewMatrix 的矩阵平方恰为 δ\_iδ\_iᵀ−(∑jδ\_ij²)I，因此所有有限 N、实 m、实 δ 都满足签名。δ 参数可直接取参考构型 δ\_i(0)，无需时间参数；Fin N 覆盖原书1至N。无需正质量假设，推广到实权重合理；无额外假设或勘误。显式证明体未见 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.inertiaSkewIdentity`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2472)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaTracePrinted · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> This matrix is closely related to the matrix $R$:

$$
R=\sum_{i=1}^Nm_i\delta_i\delta_i^T=\sum_{i=1}^Nm_i\|\delta_i\|^2I-T=(T_{11}+T_{22}+T_{33})I-T.\tag{4.40}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem inertiaTracePrinted :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=(MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  sorry



/-- 修正版，对应原文 MD-4.4-InertiaTracePrinted。改动：二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。 -/
```

独立修正版：

```lean
theorem inertiaTracePrinted_corrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaTracePrinted`；`MD.Ch04.inertiaTracePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。 | [EXTRA] |

[EXTRA] [ERRATUM?] 二阶矩与惯性张量关系的trace(T)系数修正为1/2；原式保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 secondMoment 展开为 ∑i m\_iδ\_iδ\_iᵀ；inertiaTensor 如上述定义，trace(T)=2∑i m\_i dot δ\_i δ\_i。签名忠实保留原书错误的末式，故并非转录系数错误，但该全称命题为假；还未显式列出原句中间等式。原书 ERRATUM? 成立，应改系数为 trace(T)/2。实际证明体为 sorry；FAIL 的数学反例独立于 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch04.inertiaTracePrinted`：未证（原书疑误不证）；`MD.Ch04.inertiaTracePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2486)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-InertiaTraceCorrected · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> $R=\sum_{i=1}^Nm_i\delta_i\delta_i^T=\sum_{i=1}^Nm_i\|\delta_i\|^2I-T$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem inertiaTraceCorrected :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
  MolecularDynamics.Chapter04Review.secondMoment m δ=((MolecularDynamics.Chapter04Review.inertiaTensor m δ).trace/2) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.inertiaTensor m δ := by
  intro N m δ
  have he : ∀ v : MolecularDynamics.Chapter04Review.V,
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v).trace=2*MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    simp [Matrix.trace,MolecularDynamics.Chapter04Review.dot,MolecularDynamics.Chapter04Review.outer,Fin.sum_univ_three]
    ring
  rw [MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.trace_sum]
  simp_rw [Matrix.trace_smul,he,smul_eq_mul]
  have ht : (∑ i, m i*(2*MolecularDynamics.Chapter04Review.dot (δ i) (δ i)))/2=
      ∑ i, m i*MolecularDynamics.Chapter04Review.dot (δ i) (δ i) := by
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i hi
    ring
  rw [ht,MolecularDynamics.Chapter04Review.secondMoment]
  ext i j
  simp only [Matrix.sum_apply,Matrix.smul_apply,Matrix.sub_apply,smul_eq_mul]
  rw [Finset.sum_mul,← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro k hk
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.inertiaTraceCorrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。 | [EXTRA] |

[EXTRA] [EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全称量化任意N、实权m和三维δ，无额外前提；secondMoment=Σm\_iδ\_iδ\_iᵀ，inertiaTensor=Σm\_i((δ\_i·δ\_i)I−δ\_iδ\_iᵀ)。三维时trace(T)=2Σm\_i||δ\_i||²，所以R=(trace(T)/2)I−T正确。/2已明确标为纠正，不伪称原书印式。

### 7. 状态与证明位置

self-contained；`MD.Ch04.inertiaTraceCorrected`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2505)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarHamiltonian · Example 4.1 · 印刷p.169–170 / PDFp.191–192

### 2. 原文陈述

> Example 4.1 (Dipolar Molecular Liquid) The Hamiltonian for a more general dipolar system can be written

$$
H=K_{\rm rot}(\pi_1,\ldots,\pi_N)+K_{\rm trans}(p_1,\ldots,p_N)+U(q_1,\ldots,q_N,\mu_1,\ldots,\mu_N).
$$


> The vectors $\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\|\mu_k\|\equiv1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarHamiltonian {N : ℕ} (mass : Fin N → ℝ) (inertia : MolecularDynamics.Chapter04Review.V) (_hm : ∀ i, 0 < mass i) (_hI : ∀ j, 0 < inertia j)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.V) → ℝ)
    (q p μ πbody : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1) : ℝ :=
  (∑ i, ∑ j, (πbody i j)^2/(2*inertia j))+(∑ i, MolecularDynamics.Chapter04Review.dot (p i) (p i)/(2*mass i))+U q μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 真实物理接口补质量/主惯性正性和每个μ单位长度；πbody明确为体坐标角动量，数值公式不变。 | [EXTRA] |

[EXTRA] 所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。；[EXTRA] 真实物理接口补质量/主惯性正性和每个μ单位长度；πbody明确为体坐标角动量，数值公式不变。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；N个位置、平移动量、单位方向和体角动量均为Fin N→ℝ³；共同三个正惯量给出Σ\_iΣ\_j π\_ij²/(2I\_j)，正质量给出Σ\_i||p\_i||²/(2m\_i)，再加U q μ。逐i单位约束由dot=1实现，正性均已披露。允许质量随i变化是相同椭球模型的代数推广；在相同质量实例上完全一致，不影响定义公式。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2533)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarPairPotential · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> The total dipole-dipole interaction potential then takes the form $\varphi^{\rm dip}_{ij}=\varphi_{\rm LJ}(r_{ij})+\mu_i^TL(q_{ij})\mu_j$, with $U$ given as the sum of these over pairs. The $3\times3$ matrix $L$ is given by

$$
L(q_{ij})=\frac1{r_{ij}^3}-\frac3{r_{ij}^5}q_{ij}q_{ij}^T,\qquad q_{ij}=q_i-q_j.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)

def dipolarPairPotential_particles {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V) (i j : Fin N)
    (_hij : i ≠ j) (_hnoncollision : q i ≠ q j) : ℝ :=
  let r := q i-q j
  dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)

def dipolarSystemPotential {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hnoncollision : ∀ i j, i ≠ j → q i ≠ q j) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i<j),
    let r := q i-q j
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot r r)) r (μ i) (μ j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarPairPotential`；`MD.Ch04.dipolarPairPotential_particles`；`MD.Ch04.dipolarSystemPotential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留代数核；新增实际非碰撞粒子对q\_i−q\_j、r\_ij=√(r·r)实例和仅i<j的完整系统势能求和，避免任意r与q脱钩。 | [EXTRA] |

[EXTRA] r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。；[EXTRA] 保留代数核；新增实际非碰撞粒子对q\_i−q\_j、r\_ij=√(r·r)实例和仅i<j的完整系统势能求和，避免任意r与q脱钩。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；共三个声明：代数核保留独立r及q，故该核单独不宣称r=||q||；particles接口以q\_i−q\_j及sqrt(dot r r)绑定距离，并要求不同指标且不碰撞；system接口对所有非碰撞构形仅求i<j一次。矩阵核的幂次、负号、outer顺序及μᵀLν都正确；非碰撞保证物理实例距离正。lj是径向势参数，实例化为φ\_LJ即原模型。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarPairPotential`：定义；`MD.Ch04.dipolarPairPotential_particles`：定义；`MD.Ch04.dipolarSystemPotential`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2542)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarRotationalPrinted · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> Then $K_{\rm rot}=\sum_{i=1}^N\operatorname{Tr}[\dot\Theta_iR\dot\Theta_i^T]$, with $R$ defined in terms of $T=\operatorname{diag}(I_1,I_2,I_3)$ by (4.40).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarRotationalPrinted {N : ℕ} (R : MolecularDynamics.Chapter04Review.Mat3) (dΘ : Fin N → MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace



/-- 修正版，对应原文 MD-4.4-DipolarRotationalPrinted。改动：转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted_corrected共同核查。 -/
```

独立修正版：

```lean
def dipolarRotationalPrinted_corrected {N : ℕ} (R : MolecularDynamics.Chapter04Review.Mat3) (dΘ : Fin N → MolecularDynamics.Chapter04Review.Mat3) : ℝ :=
  (1/2 : ℝ) * ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarRotationalPrinted`；`MD.Ch04.dipolarRotationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted\_corrected共同核查。 | [EXTRA] |

[EXTRA] [ERRATUM?] 转动动能补系数1/2；R应按trace(T)/2·I−T解释并与InertiaTracePrinted\_corrected共同核查。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean：V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ，dot u v=∑j u\_j v\_j，outer v 的 (j,k) 元素为 v\_j v\_k；矩阵乘法、mulVec、trace 按实矩阵运算解释。实际审阅的 Blueprint 文件位于 /workspace/Ch04.lean，哈希绑定该文件原始字节。只读审查签名与证明体，未运行 Lean 编译。 函数准确保留印刷求和式且未擅自补1/2；但本条还明确要求 R 由 T=diag(I₁,I₂,I₃) 经(4.40)定义，签名 R 为自由矩阵，未含 T、I 或关系，dΘ 也不绑定旋转矩阵的导数。故全部原句的语义未覆盖；印刷动能缺1/2的 ERRATUM? 成立，并且所引(4.40)另有系数错误。此为 def，无 sorry；并非因没有证明而 FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarRotationalPrinted`：定义；`MD.Ch04.dipolarRotationalPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2561)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RigidHamiltonian · definition · 印刷p.170–171 / PDFp.192–193

### 2. 原文陈述

> The Hamiltonian is (for a single rigid body):

$$
H_{\rm RB}=\frac{\|p_{\rm cm}\|^2}{2M}+\frac{\operatorname{Tr}[\Pi R^{-1}\Pi^T]}2+U(q_{\rm cm},\Theta),
$$


> subject to the orthogonality constraint $\Theta^T\Theta=I$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidHamiltonian (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q p : MolecularDynamics.Chapter04Review.V) (Θ mom : MolecularDynamics.Chapter04Review.Mat3) (_hΘ : Θᵀ*Θ=1) : ℝ :=
  MolecularDynamics.Chapter04Review.dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主接口增加M>0、R可逆及ΘᵀΘ=I的实际受约束域，公式不再将任意矩阵姿态当刚体状态。 | [EXTRA] |

[EXTRA] M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。；[EXTRA] 主接口增加M>0、R可逆及ΘᵀΘ=I的实际受约束域，公式不再将任意矩阵姿态当刚体状态。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数M>0、R.det≠0已披露；q,p∈ℝ³，Θ,Π∈Mat3，并由实参证明ΘᵀΘ=I限定姿态。返回||p||²/(2M)+trace(ΠR⁻¹Πᵀ)/2+U(q,Θ)，乘法顺序和系数完整。R作为给定参考二阶矩使用；函数未断言任意可逆R都可由某个物理构形实现。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidHamiltonian`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2573)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-SecondMomentDiagonal · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> By choosing an appropriate coordinate frame, it is possible to insure that the symmetric matrix $R$ is a diagonal matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V),
    ∃ O : MolecularDynamics.Chapter04Review.Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*MolecularDynamics.Chapter04Review.secondMoment m δ*O) i j=0 := by
  intro N m δ
  let R := MolecularDynamics.Chapter04Review.secondMoment m δ
  have hs : R.IsHermitian := by
    change Rᴴ=R
    ext i j
    simp [R,MolecularDynamics.Chapter04Review.secondMoment,MolecularDynamics.Chapter04Review.outer,Matrix.conjTranspose_apply,Matrix.sum_apply,Matrix.smul_apply,mul_comm]
  let O := hs.eigenvectorUnitary
  refine ⟨(O : MolecularDynamics.Chapter04Review.Mat3),?_,?_⟩
  · simpa [Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using Unitary.coe_star_mul_self O
  · have he : (O : MolecularDynamics.Chapter04Review.Mat3)ᵀ*R*(O : MolecularDynamics.Chapter04Review.Mat3)=Matrix.diagonal hs.eigenvalues := by
      simpa [O,Unitary.conjStarAlgAut_star_apply,Matrix.star_eq_conjTranspose,Matrix.conjTranspose_eq_transpose_of_trivial] using hs.conjStarAlgAut_star_eigenvectorUnitary
    intro i j hij
    simpa [Matrix.diagonal,hij] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) he
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.secondMomentDiagonal` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限实权构形，存在O∈Mat3满足OᵀO=I且OᵀRO所有非对角元为零，正是选择正交坐标使实对称R对角化。无质量正性也成立；无须把特征值非负或det O=1另作原文结论。

### 7. 状态与证明位置

self-contained；`MD.Ch04.secondMomentDiagonal`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2577)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationBodyEnergy · unnumbered_claim · 印刷p.169 / PDFp.191

### 2. 原文陈述

> It is convenient to express this in terms of the so-called body angular velocity $\omega_b=\Theta^T\omega$ in which case it becomes $K_{\rm rot}=\frac12\omega_b^TT\omega_b$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
    MolecularDynamics.Chapter04Review.rotationalEnergy (MolecularDynamics.Chapter04Review.inertiaTensor m δ) (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  let x := Θᵀ *ᵥ «ω»
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hx : Θ *ᵥ x=«ω» := by
    dsimp [x]
    rw [Matrix.mulVec_mulVec,mul_eq_one_comm.mp ho,Matrix.one_mulVec]
  have hn : MolecularDynamics.Chapter04Review.dot «ω» «ω»=MolecularDynamics.Chapter04Review.dot x x := by
    conv_lhs => rw [← hx]
    rw [ht,hi]
  have hc : ∀ v w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 w v) (MolecularDynamics.Chapter04Review.cross3 w v)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot w w-(MolecularDynamics.Chapter04Review.dot v w)^2 := by
    intro v w
    simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three]
    ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot y ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ y)=MolecularDynamics.Chapter04Review.dot v v*MolecularDynamics.Chapter04Review.dot y y-(MolecularDynamics.Chapter04Review.dot v y)^2 := by
    intro v y
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hf : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      MolecularDynamics.Chapter04Review.dot x ((MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ x) := by
    intro v
    rw [hc,he]
    have hv : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by rw [ht,hi]
    have hw : MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) «ω»=MolecularDynamics.Chapter04Review.dot v x := ht Θ v «ω»
    rw [hv,hn,hw]
  have hsum : ∀ (K : ℕ) (a : Fin K → MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (∑ i,a i)=∑ i,MolecularDynamics.Chapter04Review.dot x (a i) := by
    intro K a
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Finset.sum_apply,Finset.mul_sum,Finset.sum_add_distrib]
  have hsmul : ∀ (c : ℝ) (v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot x (c • v)=c*MolecularDynamics.Chapter04Review.dot x v := by
    intro c v
    simp [MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  rw [MolecularDynamics.Chapter04Review.rotationalEnergy,MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.sum_mulVec]
  change (∑ i,m i*MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i)))/2=
      MolecularDynamics.Chapter04Review.dot x (∑ i,(m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))) *ᵥ x)/2
  simp_rw [Matrix.smul_mulVec]
  rw [hsum]
  simp_rw [hsmul,hf]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationBodyEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实SO3旋转；不把动能等式/叉积协变当假设。 | [EXTRA] |

[EXTRA] 真实SO3旋转；不把动能等式/叉积协变当假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意N,m,参考δ及SO(3)矩阵Θ和空间角速度ω，左边是Σm\_i||ω×(Θδ\_i)||²/2，右边用真实inertiaTensor及rotationalEnergy展开为(Θᵀω)ᵀT(Θᵀω)/2。正交与det=1均显式前提，未把能量相等本身当前提。该代数身份允许任意实权，覆盖物理质量。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationBodyEnergy`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2596)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarConstraint · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> The vectors $\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\|\mu_k\|\equiv1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarConstraint {N : ℕ} (μ : Fin N → MolecularDynamics.Chapter04Review.V) : Prop :=
  ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i)=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarConstraint` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；有限族三维实方向向量的Prop为∀i, μ\_i·μ\_i=1，与每个方向的欧氏长度为1等价。它是瞬时构形约束；沿轨道每时刻满足该Prop即可表达原文恒等号，不另声称由运动方程自动保持。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarConstraint`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2645)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-DipolarPotentialSum · definition · 印刷p.170 / PDFp.192

### 2. 原文陈述

> $\varphi^{\rm dip}_{ij}=\varphi_{\rm LJ}(r_{ij})+\mu_i^TL(q_{ij})\mu_j$, with $U$ given as the sum of these over pairs.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dipolarPotentialSumTotalized {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0

def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ)
    (q μ : Fin N → MolecularDynamics.Chapter04Review.V)
    (_hq : ∀ i j, i ≠ j → q i ≠ q j)
    (_hμ : ∀ i, MolecularDynamics.Chapter04Review.dot (μ i) (μ i) = 1) : ℝ :=
  dipolarPotentialSumTotalized lj q μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dipolarPotentialSumTotalized`；`MD.Ch04.dipolarPotentialSum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。 | [EXTRA] |

[EXTRA] 对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。；[EXTRA] 原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。

### 6. 审计结论

本轮修复：原任意输入有限和另名Totalized作代数辅助；物理主接口补不同粒子位置非碰撞及每个μ单位方向。总逆在零距离的值不解释为物理势。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；求和指标i,j均遍历Fin N，if i<j确保每个无序不同粒子对恰计一次；q差与sqrt(dot差差)确实绑定实际距离，pair核依赖也正确。但签名没有位置非碰撞前提，也没有μ单位约束，而context\_notation及EXTRA明确声称无重叠位置和单位方向。Lean实数逆在0处仍有总值，故碰撞状态被实际纳入定义域；这不能表述为已实现r\_ij>0的物理接口。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dipolarPotentialSumTotalized`：定义；`MD.Ch04.dipolarPotentialSum`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2651)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationTrajectory · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> $\delta_i(t)=\Theta(t)\delta_i(0)$, see Fig. 4.7, thus we have

$$
K_{\rm rot}=\frac12\sum_{i=1}^N m_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅δ\_i(t)=Θ(t)δ\_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationTrajectory` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅δ\_i(t)=Θ(t)δ\_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原完整引文，仅在statement\_scope显式分工到已有source\_id，所列其余结论未删；仅δ\_i(t)=Θ(t)δ\_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意矩阵轨道Θ、导数d、固定三维向量δ及实t，HasDerivAt Θ d t蕴含HasDerivAt (Θ(·)δ) (dδ) t，是真实时间导数的线性映射规则。按显式statement\_scope这是运动学辅助；不含原段动能有限和或trace结论，也不把未提供的RotationTraceIdentity当作已审校。正交性并非此导数规则所需。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rotationTrajectory`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2664)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RotationDerivativePrinted · unnumbered_claim · 印刷p.168 / PDFp.190

### 2. 原文陈述

> An alternative form for the rotational kinetic energy may be obtained by writing

$$
\dot\delta_i=\dot\Theta\delta_i(0)=\dot\Theta\Theta^T\Theta\delta_i(0)=\dot\Theta\Theta^T\dot\delta_i,
$$


> where we have used the fact that $\Theta$ is orthogonal.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rotationDerivativePrinted : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (d *ᵥ δ) := by
  sorry



/-- 修正版，对应原文 MD-4.4-RotationDerivativePrinted。改动：右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。 -/
```

独立修正版：

```lean
theorem rotationDerivativePrinted_corrected : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (Θ t *ᵥ δ) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rotationDerivativePrinted`；`MD.Ch04.rotationDerivativePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。 | [EXTRA] |

[EXTRA] [ERRATUM?] 右端末因子从Θ̇δ改为Θδ，恢复Θ̇δ=(Θ̇Θᵀ)(Θδ)。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；签名忠实再现印刷末项：设δ=δ\_i(0)、d=dotΘ(t)，右端确为(dΘ(t)^T)(dδ)。ERRATUM?成立，印刷末项应使用当前配置Θ(t)δ而非速度dδ。它不是正交性和可微性推得的真命题，即使Θ整条轨道属于SO(3)仍失败。HasDerivAt为实际矩阵时间导数；ΘΘ^T=I是正确的正交条件。该decl明确含sorry；此处FAIL来自反例，不是因为sorry，原文忠实性单独为通过。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rotationDerivativePrinted`：未证（原书疑误不证）；`MD.Ch04.rotationDerivativePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2677)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4-RigidMatrixRelation · definition · 印刷p.171 / PDFp.193

### 2. 原文陈述

> The constraint may be enforced using Lagrange multipliers with the following equations

$$
\frac d{dt}q_{\rm cm}=p_{\rm cm}/M,\quad\frac d{dt}\Theta=\Pi R^{-1},
$$



$$
\frac d{dt}p_{\rm cm}=-\nabla_{q_{\rm cm}}U,\quad\frac d{dt}\Pi=-\nabla_\Theta U-\Theta\Lambda,\quad I=\Theta^T\Theta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidMatrixRelation (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.V) (Θ mom Λ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (I : Set ℝ) (_hI : IsOpen I)
    (_hU : Differentiable ℝ (fun z : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 ↦ U z.1 z.2)) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-MolecularDynamics.Chapter04Review.grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-MolecularDynamics.Chapter04Review.matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidMatrixRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 增加开放时间域、势能联合经典可微、M>0及R可逆，使within导数等于真实时间导数，排除单点域伪运动；姿态正交约束仍逐t保留。 | [EXTRA] |

[EXTRA] [EXTRA] 增加开放时间域、势能联合经典可微、M>0及R可逆，使within导数等于真实时间导数，排除单点域伪运动；姿态正交约束仍逐t保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义Prop而非存在性定理；对开放实时间域I逐t要求四个HasDerivWithinAt及ΘᵀΘ=I。开放域内within导数等同通常导数；M>0、R可逆、U在ℝ³×Mat3联合可微均已披露。grad和matrixGrad实际为按标准基取fderiv分量，四个右端的符号、矩阵乘法次序和势能冻结参数正确。Λ为给定矩阵乘子轨道，原摘录未另写对称条件；此处不新增解存在或唯一性断言。空开放域只给空域关系，不构成解存在断言。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidMatrixRelation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2696)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AngularMomentum · definition · 印刷p.171 / PDFp.193

### 2. 原文陈述

> The angular momentum vector in the reference frame is given by $l=\sum_{i=1}^Nm_i\delta_i\times\dot\delta_i$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.angularMomentum` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限实权m及三维δ、速度v映到Σm\_i cross3(δ\_i,v\_i)。cross3三分量为标准右手叉积，质量作为标量乘法，完全吻合瞬时角动量定义；v作为输入代表dotδ，无须为定义引入全局轨道。

### 7. 状态与证明位置

self-contained；`MD.Ch04.angularMomentum`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2704)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-BodyMomentum · definition · 印刷p.171 / PDFp.193

### 2. 原文陈述

> Define $\pi=\Theta^Tl$, the angular momentum vector referred to the body frame of reference.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.bodyMomentum` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Mat3与三维空间角动量l映到Θᵀl，正是体坐标角动量的代数定义。正交旋转的物理解释已在context给出；这个线性算式可定义在更广矩阵域，不声称任意矩阵都为方向矩阵。

### 7. 状态与证明位置

self-contained；`MD.Ch04.bodyMomentum`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2708)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AngularInertia · unnumbered_claim · 印刷p.171 / PDFp.193

### 2. 原文陈述

> From Eq. (4.39) we may write this as $l=\sum_im_i\delta_i\times\omega\times\delta_i$, from which, using the vector triple product identity $a\times b\times c=(a\cdot c)b-(a\cdot b)c$, we obtain $l=\sum_im_i[\|\delta_i\|^2I-\delta_i\delta_i^T]\omega$. Define $\pi=\Theta^Tl$, then we have (using $\delta_i=\Theta\delta_i(0)$): $\pi=T\omega_b$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem angularInertia :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 → MolecularDynamics.Chapter04Review.bodyMomentum Θ
    (MolecularDynamics.Chapter04Review.angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i))) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hn : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    rw [ht,hi]
  have hc : ∀ u w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.cross3 u (MolecularDynamics.Chapter04Review.cross3 w u)=MolecularDynamics.Chapter04Review.dot u u • w-MolecularDynamics.Chapter04Review.dot u w • u := by
    intro u w
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul] <;> ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.outer v *ᵥ y=MolecularDynamics.Chapter04Review.dot v y • v := by
    intro v y
    ext i
    simp [MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  have hterm : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ MolecularDynamics.Chapter04Review.cross3 (Θ *ᵥ v) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ (Θᵀ *ᵥ «ω») := by
    intro v
    rw [hc,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_smul,hn,ht,hi,
      Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,he]
  simp only [MolecularDynamics.Chapter04Review.bodyMomentum,MolecularDynamics.Chapter04Review.angularMomentum,
    MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.mulVec_sum,Matrix.mulVec_smul,Matrix.sum_mulVec,Matrix.smul_mulVec]
  apply Finset.sum_congr rfl
  intro i hii
  rw [hterm]

theorem vectorTripleProduct (a b c : MolecularDynamics.Chapter04Review.V) :
    MolecularDynamics.Chapter04Review.cross3 a (MolecularDynamics.Chapter04Review.cross3 b c) =
      MolecularDynamics.Chapter04Review.dot a c • b-MolecularDynamics.Chapter04Review.dot a b • c := by
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,
    MolecularDynamics.Chapter04Review.dot, Fin.sum_univ_three, Pi.smul_apply, smul_eq_mul] <;> ring

theorem spatialAngularInertia (N : ℕ) (m : Fin N → ℝ)
    (δ : Fin N → MolecularDynamics.Chapter04Review.V) (omegaVec : MolecularDynamics.Chapter04Review.V) :
    MolecularDynamics.Chapter04Review.angularMomentum m δ
      (fun i => MolecularDynamics.Chapter04Review.cross3 omegaVec (δ i)) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ omegaVec := by
  simpa [MolecularDynamics.Chapter04Review.bodyMomentum] using
    (angularInertia N m δ (1 : MolecularDynamics.Chapter04Review.Mat3) omegaVec (by simp) (by simp))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.angularInertia`；`MD.Ch04.vectorTripleProduct`；`MD.Ch04.spatialAngularInertia` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。 | [EXTRA] |

[EXTRA] 真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。；[EXTRA] 原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。

### 6. 审计结论

本轮修复：原体坐标等式与证明完整保留；另列一般三重积（逐坐标ring证明）及空间角动量矩阵中间等式（体坐标已证式取Θ=1），覆盖引文遗漏。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；全称N,m,参考δ,Θ,ω，并以前提ΘᵀΘ=I及detΘ=1，结论确实是ΘᵀΣm\_i[(Θδ\_i)×(ω×Θδ\_i)]=T(Θᵀω)，右嵌套与原文给出的三重积公式一致。然而本条statement\_scope声称覆盖全部引文，签名仅给最终体坐标等式；未陈述一般三重积恒等式以及空间角动量等于Σm\_i[||δ\_i||²I−δ\_iδ\_iᵀ]ω的中间等式。证明体中的局部hc只给u×(w×u)特例，不是可替代完整结论的声明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.angularInertia`：已证；`MD.Ch04.vectorTripleProduct`：已证；`MD.Ch04.spatialAngularInertia`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2713)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-EulerRigidField · (4.41) · 印刷p.172 / PDFp.194

### 2. 原文陈述

> but since $\omega_b=T^{-1}\pi$, we may conclude $\dot\pi=\pi\times T^{-1}\pi$. These are the so-called Euler equations for the free rigid body.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.eulerRigidField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；MD.Ch04.eulerRigidField 的对象为实3×3矩阵T和实三维列向量π，返回同域向量。展开 cross3 的三个分量，恰为π×(T⁻¹π)，次序及符号与(4.41)一致。本条是右端向量场定义，未冒称已经构造轨道或证明ODE。Mat3上的矩阵逆为全定义运算，但可逆惯性张量上的限制完全忠实；定义本身不宣称奇异T有物理意义。

### 7. 状态与证明位置

self-contained；`MD.Ch04.eulerRigidField`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2766)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-FreeRigidSolution · definition · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $\dot\pi=\pi\times T^{-1}\pi$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) (_hI : IsOpen I) (_hT : T.PosDef) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.freeRigidSolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 采用开放时间域和正定惯性张量，明确within导数就是实际经典导数；Mathlib标准定义按用户约定直接采信，不再因未复制定义体待人工。 | [EXTRA] |

[EXTRA] [EXTRA] 采用开放时间域和正定惯性张量，明确within导数就是实际经典导数；Mathlib标准定义按用户约定直接采信，不再因未复制定义体待人工。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；freeRigidSolution 显式接收T、π:ℝ→V、I:Set ℝ、IsOpen I和T.PosDef，定义为每个t∈I的实际向量导数等于Euler场。开放性使点内within导数等价于经典导数；实PosDef含对称性且保证可逆。没有把零导数、守恒性或存在性作为替代。原书没有命名此解关系，context\_notation已明示这是形式化选择。

### 7. 状态与证明位置

self-contained；`MD.Ch04.freeRigidSolution`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2770)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidInvariants · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> Thus the Euler equations are in the form of a Hamiltonian system on a three-dimensional phase space. The symplectic structure matrix is dependent on the phase variables, and it is degenerate: $\widetilde J\pi=\pi\times\pi=0$, signifying that total angular momentum is conserved: $\|\pi\|=\mathrm{constant}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidInvariants :
  ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → MolecularDynamics.Chapter04Review.freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) ∧
      MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
  intro T π a b hT hab hπ hsol
  have hsym : (T⁻¹)ᵀ=T⁻¹ := by
    simpa [Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hcomm : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot u v=MolecularDynamics.Chapter04Review.dot v u := by
    intro u v
    simp [MolecularDynamics.Chapter04Review.dot,mul_comm]
  have htrans : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) (u v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot u (B *ᵥ v)=MolecularDynamics.Chapter04Review.dot (Bᵀ *ᵥ u) v := by
    intro B u v
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hc : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 u v) v=0 ∧ MolecularDynamics.Chapter04Review.dot u (MolecularDynamics.Chapter04Review.cross3 u v)=0 := by
    intro u v
    constructor <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three] <;> ring
  have hd : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) t, t ∈ Icc a b →
      HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (B *ᵥ π s))
      (MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (B *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))) (Icc a b) t := by
    intro B t ht
    have hp := hsol t ht
    have hx : ∀ i, HasDerivWithinAt (fun s => (B *ᵥ π s) i) ((B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) i) (Icc a b) t := by
      intro i
      change HasDerivWithinAt (fun s => ∑ j, B i j*π s j) (∑ j,B i j*MolecularDynamics.Chapter04Review.eulerRigidField T (π t) j) (Icc a b) t
      apply HasDerivWithinAt.fun_sum
      intro j hj
      exact (hasDerivWithinAt_pi.mp hp j).const_mul (B i j)
    have h := HasDerivWithinAt.fun_sum (u := Finset.univ) (fun i _ => (hasDerivWithinAt_pi.mp hp i).mul (hx i))
    simpa [MolecularDynamics.Chapter04Review.dot,Finset.sum_add_distrib] using h
  have he : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (T⁻¹ *ᵥ π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (T⁻¹ *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [htrans T⁻¹ (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)),hsym,hcomm (T⁻¹ *ᵥ π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).1]
    simpa [hz] using hd T⁻¹ t ht
  have hn : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)+MolecularDynamics.Chapter04Review.dot (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [hcomm (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).2]
    simpa [Matrix.one_mulVec,hz] using hd 1 t ht
  have ce : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (he t ht).continuousWithinAt)
    intro t ht
    exact (he t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  have cn : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (hn t ht).continuousWithinAt)
    intro t ht
    exact (hn t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  intro t ht
  exact ⟨ce t ht,cn t ht⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅能量与角动量模长守恒；同段Hamiltonian表示及结构矩阵反对称性由MD-4.4.1-RigidPoissonMatrix、退化由MD-4.4.1-PoissonDegeneracy承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidInvariants` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅保留原页的能量与角动量模长守恒，实际Hamiltonian梯度表示/反对称性由RigidPoissonMatrix补全，退化由PoissonDegeneracy原已有声明承担，完整原文保留。 | [EXTRA] |

[EXTRA] 对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。；[EXTRA] 本条仅保留原页的能量与角动量模长守恒，实际Hamiltonian梯度表示/反对称性由RigidPoissonMatrix补全，退化由PoissonDegeneracy原已有声明承担，完整原文保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；rigidInvariants 对所有T、π、实数a,b，在T.PosDef、a≤b、闭区间连续和真实Euler方程前提下，断言每个t∈[a,b]的π(t)ᵀT⁻¹π(t)及π(t)ᵀπ(t)等于a时刻值。前者是2H̃，后者是欧氏长度平方，缩放和平方均不丢失守恒结论。实际调用的是Chapter04Review.freeRigidSolution，而非条目2带开放域参数的MD.Ch04.freeRigidSolution；不存在把非平凡闭区间强迫为开放集的空前提问题。Hamiltonian表示与退化分别由本批条目4、5覆盖，符合显式statement\_scope。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidInvariants`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2776)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidPoissonMatrix · definition · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $\dot\pi=\widetilde J(\pi)\nabla\widetilde H$, where $\widetilde J(\pi)=\operatorname{skew}(\pi)$ is obviously skew symmetric, and $\widetilde H=\pi^TT^{-1}\pi/2$ is the energy function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π

def rigidBodyHamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (mom : MolecularDynamics.Chapter04Review.V) : ℝ :=
  MolecularDynamics.Chapter04Review.dot mom (T⁻¹ *ᵥ mom)/2

theorem rigidPoissonMatrix_hamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (_hT : T.PosDef) (mom : MolecularDynamics.Chapter04Review.V) :
    (rigidPoissonMatrix mom)ᵀ= -rigidPoissonMatrix mom ∧
    MolecularDynamics.Chapter04Review.eulerRigidField T mom=
      rigidPoissonMatrix mom *ᵥ MolecularDynamics.Chapter04Review.grad (rigidBodyHamiltonian T) mom := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidPoissonMatrix`；`MD.Ch04.rigidBodyHamiltonian`；`MD.Ch04.rigidPoissonMatrix_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留J定义，补实际二次能量定义、真实fderiv梯度Hamiltonian表示及反对称性；正定惯性是物理充分资格，不预设所求梯度公式。 | [EXTRA] |

[EXTRA] [EXTRA] 保留J定义，补实际二次能量定义、真实fderiv梯度Hamiltonian表示及反对称性；正定惯性是物理充分资格，不预设所求梯度公式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已合并审校同一source\_id下三项声明：J̃定义为skewMatrix；H̃定义为dot mom (T⁻¹*ᵥmom)/2；对每个正定实矩阵T和每个mom，给出J̃ᵀ=−J̃与Euler场=J̃乘真实fderiv坐标梯度的合取。正定性提供所需对称性，梯度不是公理化替代。三项共同覆盖原句的能量函数、反对称性与Hamiltonian表示；sorry不改变签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rigidPoissonMatrix`：定义；`MD.Ch04.rigidBodyHamiltonian`：定义；`MD.Ch04.rigidPoissonMatrix_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2832)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-PoissonDegeneracy · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $\widetilde J\pi=\pi\times\pi=0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonDegeneracy : ∀ π : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ π=0 := by
  intro π
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.poissonDegeneracy` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；poissonDegeneracy 对每个π:V断言Chapter04Review.rigidPoissonMatrix π *ᵥπ=0。该矩阵实际为skewMatrix π，故此结论就是原式π×π=0，并非仅由名称猜测退化。π=0时矩阵本身为零，亦无遗漏；本条选取的是核向量等式，不宣称恒定秩为2或额外Casimir定理。

### 7. 状态与证明位置

self-contained；`MD.Ch04.poissonDegeneracy`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2846)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AxisRotation · definition · 印刷p.173–174 / PDFp.195–196

### 2. 原文陈述

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7). The notation $\Theta^x(\phi)$ refers to a rotation around the x-axis by an angle $\phi$, that is

$$
\Theta^x(\phi)=\begin{bmatrix}1&0&0\\0&\cos(\phi)&-\sin(\phi)\\0&\sin(\phi)&\cos(\phi)\end{bmatrix},
$$


> with corresponding formulae for $\Theta^y$ and $\Theta^z$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.axisRotation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 不以矩阵名字推断ODE解。 | [EXTRA] |
| 尚未覆盖的结论 | 原印正角是否等于π×ω场的时间h子流，见AxisFlowFormal/ExactPlanarRotation勘误 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA] 三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 不以矩阵名字推断ODE解。

### 6. 审计结论

本轮修复：三个标准右手轴旋转矩阵的公式定义；第一句平面子流可积性是背景，移出本条承诺，由MD-4.4.1-ExactPlanarRotation的带负角修正版单独给出。 不以矩阵名字推断ODE解。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；axisRotation 本身的三支矩阵完全正确：i=0给出所印x轴矩阵，i=1与i=2分别是对应右手y、z轴矩阵，且∀φ:ℝ无额外前提。但原JSON的完整statement\_scope包含“Each of these ... easily integrated as a planar rotation”这一单轴ODE可积性结论；同一source\_id所给全部Lean只有矩阵定义，未出现子场、时间、初值、解或积分关系，extra\_assumptions也没有将该句排除/分配。故完整范围的签名FAIL，原因是结论遗漏；不是矩阵符号错误，也不是sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.axisRotation`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2853)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-SecondAxisPrinted · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $\dot\pi=\pi\times[0,T_2^{-1}\pi,0]^T$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def secondAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,a/I 1,0]



/-- 修正版，对应原文 MD-4.4.1-SecondAxisPrinted。改动：将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。 -/
```

独立修正版：

```lean
def secondAxisPrinted_corrected (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (_hI : 0 < I 1) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,π 1/I 1,0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.secondAxisPrinted`；`MD.Ch04.secondAxisPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 为未定义标量引入a供审校，不声称它等于π₂。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。 | [EXTRA] |

[EXTRA] 为未定义标量引入a供审校，不声称它等于π₂。；[ERRATUM?] 将未定义标量a绑定第二动量分量π₂，补正主惯量；原无下标π保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开Ch04.lean定义得到π×e\_2·(a/I\_2)。依赖没有缺失定义。a是新增独立实参数；若原书无下标π意为独立标量，此参数化可用；若意为动量分量π\_2则a应绑定该分量。原书此标量未定义，不能以参数占位宣称已忠实翻译。惯量由T\_j映射为I\_j符合前文T=diag(I₁,I₂,I₃)的意图，但原式T\_j记法本身也应保留解释记录。[ERRATUM?]缺下标外观确认，数学裁定仍需明确原文标量π含义。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.secondAxisPrinted`：定义；`MD.Ch04.secondAxisPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2862)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-ThirdAxisPrinted · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $\dot\pi=\pi\times[0,0,T_3^{-1}\pi]^T$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def thirdAxisPrinted (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (a : ℝ) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,0,a/I 2]



/-- 修正版，对应原文 MD-4.4.1-ThirdAxisPrinted。改动：将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。 -/
```

独立修正版：

```lean
def thirdAxisPrinted_corrected (I : MolecularDynamics.Chapter04Review.V) (π : MolecularDynamics.Chapter04Review.V) (_hI : 0 < I 2) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π ![0,0,π 2/I 2]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.thirdAxisPrinted`；`MD.Ch04.thirdAxisPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]a只为缺下标的印刷标量供审校。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。 | [EXTRA] |

[EXTRA] [EXTRA]a只为缺下标的印刷标量供审校。；[ERRATUM?] 将未定义标量a绑定第三动量分量π₃，补正主惯量；原无下标π保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开Ch04.lean定义得到π×e\_3·(a/I\_3)。依赖没有缺失定义。a是新增独立实参数；若原书无下标π意为独立标量，此参数化可用；若意为动量分量π\_3则a应绑定该分量。原书此标量未定义，不能以参数占位宣称已忠实翻译。惯量由T\_j映射为I\_j符合前文T=diag(I₁,I₂,I₃)的意图，但原式T\_j记法本身也应保留解释记录。[ERRATUM?]缺下标外观确认，数学裁定仍需明确原文标量π含义。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.thirdAxisPrinted`：定义；`MD.Ch04.thirdAxisPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2875)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-PrincipalAxisField · definition · 印刷p.172 / PDFp.194

### 2. 原文陈述

> If $T$ is a diagonal matrix, $T=\operatorname{diag}(I_1,I_2,I_3)$, then we split the Euler equations and approximate the solution by successive rotations around the three axes of inertia,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def principalAxisField (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))



/-- 修正版，对应原文 MD-4.4.1-PrincipalAxisField。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def principalAxisField_corrected (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅各单轴子向量场的定义；完整印刷五次复合由MD-4.4.1-PrintedSpinStep承担，精确平面子流解释由MD-4.4.1-ExactPlanarRotation单列待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.principalAxisField`；`MD.Ch04.principalAxisField_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条为单轴分裂场定义；完整印刷五次轴复合由PrintedSpinStep承担，实际子流的负角与原印正角冲突保留AxisFlowFormal/ExactPlanarRotation待导师。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。；[EXTRA] 本条为单轴分裂场定义；完整印刷五次轴复合由PrintedSpinStep承担，实际子流的负角与原印正角冲突保留AxisFlowFormal/ExactPlanarRotation待导师。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；数学上，定义cross3 π (Pi.single i (π i/I i))是对角惯性下合理且正确的单轴分裂场；在I各分量为正的物理域，三个子场之和对应Euler右端，轴编号0,1,2也正确。不得把这个分裂等式推广到任意奇异对角矩阵，因为矩阵总逆与逐分量总除法在奇异处可能不同。本条仅定义场，不声称已证明正角印刷旋转就是其时间h子流。但原书后续第二、第三项确实缺分量下标，当前非明确\_corrected名称的定义采用了补义版本。按原书数学疑误保留并分流要求，整条标NEEDS\_HUMAN，而非将正确的补义场判成数学反例型FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.principalAxisField`：定义；`MD.Ch04.principalAxisField_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2888)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-PrintedSpinAxis · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> $\pi^k:=\Theta\pi^k;\quad\Theta^k:=\Theta^k\Theta^T$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedSpinAxis (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (h : ℝ) (s : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  let R := MolecularDynamics.Chapter04Review.axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedSpinAxis` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。axisRotation 的三个分支分别是标准正角 x/y/z 旋转矩阵；角度为 hπ\_i/I\_i，返回 (Rπ,ΘRᵀ)，与 PDF196 五行中共同的赋值逐项一致。Fin 3 的 0/1/2 对应印刷 1/2/3；原书物理惯量非零，Lean 对除零的总化并不被声称为物理子流。[ERRATUM?] 成立：对 x 轴 I₁=1、π=(1,1,0)，R\_x(h)π 在 h=0 导数为 (0,0,1)，而 π×(1,0,0)=(0,0,-1)；这里只保留字面算法，没有声称精确求解(4.41)。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedSpinAxis`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2899)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-PrintedSpinStep · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedSpinStep (I : MolecularDynamics.Chapter04Review.V) (h : ℝ) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 → MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.printedSpinStep` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。展开 printedSpinAxis 与正式库 axisRotation；函数复合从右向左执行，回文链实际为 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。每次角度使用当前更新后的 π，姿态使用当前 Θ；与 PDF196 Step 3 全部五行一致。该定义没有附加精确子流或几何结构结论；正角符号疑误仍保留。

### 7. 状态与证明位置

self-contained；`MD.Ch04.printedSpinStep`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2904)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-AxisFlowFormal · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem axisFlow :
  ∀ (I π : MolecularDynamics.Chapter04Review.V) i, 0 < I i → ∀ t : ℝ,
  HasDerivAt (fun s : ℝ => (MolecularDynamics.Chapter04Review.spinAxis I i s (π,1)).1)
    (MolecularDynamics.Chapter04Review.cross3 ((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1) (Pi.single i (((MolecularDynamics.Chapter04Review.spinAxis I i t (π,1)).1 i)/I i))) t := by
  sorry



/-- 修正版，对应原文 MD-4.4.1-AxisFlowFormal。改动：采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。 -/
```

独立修正版：

```lean
theorem axisFlow_corrected : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.axisFlow`；`MD.Ch04.axisFlow_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。 | [EXTRA] |

[EXTRA] [EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。；[ERRATUM?] 采用负角旋转子流，独立给初值、轴分量恒定及π×ω的ODE，正角Printed算法保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 spinAxis展开为R=axisRotation i(tπ\_i/I\_i)，输出(Rπ,ΘRᵀ)；HasDerivAt对实时间求整个三维动量的导数，∀I,π,i且I\_i>0，∀t。正角导数为ω×π，签名右端为π×ω，符号相反；[ERRATUM?]在原矩阵与列动量约定下成立。I\_i>0合理且足够，但不能修复符号。axisFlow含sorry，仅记录证明未完成，FAIL依据签名反例。

### 7. 状态与证明位置

incomplete；`MD.Ch04.axisFlow`：未证（原书疑误不证）；`MD.Ch04.axisFlow_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2912)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-SpinPoissonFormal · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> This yields a simple, efficient algorithm for the free rigid body which is symplectic in a generalized sense.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem spinPoisson :
  ∀ I : MolecularDynamics.Chapter04Review.V, (∀ i, 0 < I i) → ∀ h : ℝ,
  poissonMap (fun π => (MolecularDynamics.Chapter04Review.spinStep I h (π,1)).1) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.spinPoisson` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。 | [EXTRA] |

[EXTRA] [EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 展开spinStep为x(h/2)∘y(h/2)∘z(h)∘y(h/2)∘x(h/2)五步，spinAxis的动量部分为正角Rπ，初始姿态1不影响动量。Statements.lean中poissonMap展开为∀π，D\_ij=(fderiv ℝ G π)(e\_j)_i，D skewMatrix(π) Dᵀ=skewMatrix(Gπ)。这确实是自由刚体三维约化动量上的Poisson保持，不是空谓词或抽象替代；对应本条generalized symplectic的几何结论。正角各步是相应负时间Hamiltonian子流，同样Poisson；故axisFlow符号FAIL不推出本条FAIL。∀I正主惯量、∀h合理；[EXTRA]明确约化动量范围，与自由刚体段落一致，不覆盖后续含姿态的完整算法。简单/高效为定性描述，无定量复杂度命题。spinPoisson含sorry；PASS只判签名语义，不声称已验证其证明。

### 7. 状态与证明位置

incomplete；`MD.Ch04.spinPoisson`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2933)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidPoissonSkew · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> $\widetilde J(\pi)=\operatorname{skew}(\pi)$ is obviously skew symmetric.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidPoissonSkew : ∀ π : MolecularDynamics.Chapter04Review.V, (MolecularDynamics.Chapter04Review.rigidPoissonMatrix π)ᵀ= -MolecularDynamics.Chapter04Review.rigidPoissonMatrix π := by
  intro π
  ext i j
  fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidPoissonSkew` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 rigidPoissonMatrix展开为skewMatrix(π)=[[0,−π₂,π₁],[π₂,0,−π₀],[−π₁,π₀,0]]。∀π，矩阵转置等于负矩阵，恰是原书skew symmetric，无Jacobi或非退化附加断言；无额外假设。Ch04.lean该声明有逐分量证明，无sorry；本次只读，不作编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidPoissonSkew`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2939)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-RigidHamiltonianField · unnumbered_claim · 印刷p.172 / PDFp.194

### 2. 原文陈述

> Let us observe that (4.41) is in the form $\dot\pi=\widetilde J(\pi)\nabla\widetilde H$, where $\widetilde J(\pi)=\operatorname{skew}(\pi)$ is obviously skew symmetric, and $\widetilde H=\pi^TT^{-1}\pi/2$ is the energy function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rigidHamiltonianField : ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V), T.PosDef →
  MolecularDynamics.Chapter04Review.eulerRigidField T π=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ
    MolecularDynamics.Chapter04Review.grad (fun x => MolecularDynamics.Chapter04Review.dot x (T⁻¹ *ᵥ x)/2) π := by
  intro T π hT
  let B := T⁻¹
  have hsym : Bᵀ=B := by
    simpa [B,Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hs : ∀ i j : Fin 3, B i j=B j i := by
    intro i j
    simpa using congrArg (fun A : MolecularDynamics.Chapter04Review.Mat3 => A j i) hsym
  let row : Fin 3 → (MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ) := fun i => ∑ j, B i j • (ContinuousLinearMap.proj j : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ)
  let L : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ := (2 : ℝ)⁻¹ • ∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ))
  have hb : ∀ i, HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => (B *ᵥ x) i) (row i) π := by
    intro i
    change HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => ∑ j,B i j*x j) (∑ j,B i j • (ContinuousLinearMap.proj j : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ)) π
    apply HasFDerivAt.fun_sum
    intro j hj
    exact (hasFDerivAt_apply j π).const_mul (B i j)
  have hh : HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => ∑ i,x i*(B *ᵥ x) i)
      (∑ i, (π i • row i+(B *ᵥ π) i • (ContinuousLinearMap.proj i : MolecularDynamics.Chapter04Review.V →L[ℝ] ℝ))) π := by
    apply HasFDerivAt.fun_sum
    intro i hii
    exact (hasFDerivAt_apply i π).mul (hb i)
  have hd : HasFDerivAt (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) L π := by
    convert hh.const_mul ((2 : ℝ)⁻¹) using 1
    funext x
    simp only [MolecularDynamics.Chapter04Review.dot,div_eq_mul_inv]
    ring
  have hg : MolecularDynamics.Chapter04Review.grad (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π=B *ᵥ π := by
    ext i
    change (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π) (Pi.single i 1)=(B *ᵥ π) i
    rw [hd.fderiv]
    fin_cases i <;> simp [L,row,ContinuousLinearMap.sum_apply,ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.proj_apply,Fin.sum_univ_three,Pi.single_apply,Matrix.mulVec,dotProduct,hs 1 0,hs 2 0,hs 2 1] <;> ring
  change MolecularDynamics.Chapter04Review.cross3 π (B *ᵥ π)=MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ MolecularDynamics.Chapter04Review.grad (fun x : MolecularDynamics.Chapter04Review.V => MolecularDynamics.Chapter04Review.dot x (B *ᵥ x)/2) π
  rw [hg]
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidHamiltonianField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。 | [EXTRA] |

[EXTRA] 正定T确保对称可逆；真实Fréchet配置梯度，不把∇H=T⁻¹π作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖展开：Chapter04/ReviewDefinitions.lean中V=Fin 3→ℝ，Mat3=3×3实矩阵，cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)；Fin索引0/1/2对应原书1/2/3。 eulerRigidField=π×(T⁻¹π)，rigidPoissonMatrix=skewMatrix(π)；dot=Σ\_i x\_i y\_i；grad= textbookConstraintGradient，后者在ConstrainedProjection.lean展开为i↦(fderiv ℝ H π)(Pi.single i 1)，为真实坐标梯度而非假设。原式的对象、所有能量因子及梯度位置完整保留。∀T,π，T.PosDef是物理非退化惯量的合理资格，提供对称与可逆性；对称性保证此二次型梯度为T⁻¹π，无把结论作假设。skew性质已由单列RigidPoissonSkew覆盖。[EXTRA]正定性强于此等式所需的对称性，但在使用T⁻¹的物理惯量范围合理。Ch04.lean有Fréchet微分和逐分量证明，无sorry；本次未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidHamiltonianField`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2946)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidForce · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The relevant expressions are:

$$
F^k=-\partial U/\partial q^k,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidForce` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；rigidForce 对任意单体/固定其他变量后的势切片U:V→Mat3→ℝ、位置q和方向Θ，返回−grad(fun x=>U x Θ) q。逐坐标即−∂U/∂q\_i，方向及其他变量在求导中固定；不是独立给定的力公理。原书的k只是指定刚体指标，冻结其他体坐标即可应用此任意切片定义，不必假设势能无耦合。总fderiv在不可微函数上的约定不等于证明物理势可微，现明确记入注释。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidForce`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2986)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-MatrixRot · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> for a $3\times3$ matrix $A$, $\operatorname{rot}(A)=\operatorname{skew}^{-1}(A-A^T)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def matrixRot (A : MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.matrixRot` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。skewMatrix(v)=[[0,-v₂,v₁],[v₂,0,-v₀],[-v₁,v₀,0]]。对 B=A−Aᵀ，skew 的逆为 (B₂₁,B₀₂,B₁₀)；展开后正是 Lean 三个坐标 (A₂₁−A₁₂,A₀₂−A₂₀,A₁₀−A₀₁)。没有额外 1/2，无新增假设。

### 7. 状态与证明位置

self-contained；`MD.Ch04.matrixRot`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2989)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidTorque · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $\tau^k=-\operatorname{rot}(\Theta^{kT}\partial U/\partial\Theta^k)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidTorque` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；rigidTorque 的实矩阵梯度逐元素取真实fderiv，A=ΘᵀmatrixGrad(U q) Θ；matrixRot(A)=(A₃₂−A₂₃,A₁₃−A₃₁,A₂₁−A₁₂)，故正是原书skew⁻¹(A−Aᵀ)，外层负号正确。这里rot本身不带1/2；rbForm中另用1/2取斜对称矩阵的轴向量，不能混淆。任意势切片也能表示多体中固定其余变量后的第k个力矩，无须无耦合假设。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidTorque`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2992)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrinted · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> DLM Rigid Body Molecular Dynamics Step
> 1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$


> 2. “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$


> 3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.
$$


> 4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $F^k$ and torques $\tau^k$ evaluated at the current $q,\Theta$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dlmPrinted (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)



/-- 修正版，对应原文 MD-4.4.2-DLMPrinted。改动：独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。 -/
```

独立修正版：

```lean
def dlmPrinted_corrected (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 原DLM完整算法的N=1实例；任意N耦合系统的原算法由MD-4.4.2-DLMPrintedSystem承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrinted`；`MD.Ch04.dlmPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留N=1字面算法作为单体实例；完整任意N、耦合势、逐阶段重算所有力矩的原算法已由DLMPrintedSystem覆盖，显式跨条目映射，不以单体冒充全系统。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。 | [EXTRA] |

[EXTRA] [EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。；[EXTRA] 保留N=1字面算法作为单体实例；完整任意N、耦合势、逐阶段重算所有力矩的原算法已由DLMPrintedSystem覆盖，显式跨条目映射，不以单体冒充全系统。；[ERRATUM?] 独立保留单位质量的印刷算法解释，质量取1才将Drift写成q+hp；Spin仍按印刷约定，仅解释该组合定义，不称其为一般质量或π×ω原动力学的一致子流。质量修订和轴流符号另列工作版本。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；按Printed的字面忠实性标准PASS，限明确声明的N=1实例。右侧先作用的复合依次是Kick(h/2)、Drift(1,h)、Spin(h)、Kick(h/2)，与原表顺序一致。printedSpinStep虽为函数复合，回文轴序使实际顺序仍为x半、y半、z全、y半、x半；每一步角度从当前s.1分量重新取值。动量用Rπ，方向用ΘRᵀ；最后Kick在更新后的q、Θ处重新求力和力矩。没有擅自加入质量因子或改正角。原书质量和符号疑点在json\_review标NEEDS\_HUMAN，不作为字面定义的FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dlmPrinted`：定义；`MD.Ch04.dlmPrinted_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L2999)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMMassOnly · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Drift”: step forward a whole step in positions $q^k:=q^k+hp^k$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dlmMassOnly (M : ℝ) (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)



/-- 修正版，对应原文 MD-4.4.2-DLMMassOnly。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def dlmMassOnly_corrected (M : ℝ) (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmMassOnly`；`MD.Ch04.dlmMassOnly_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]只将drift质量修为q+h p/M；仍保留原spin，不能据此称完整正确几何积分器。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]只将drift质量修为q+h p/M；仍保留原spin，不能据此称完整正确几何积分器。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 中 Chapter04Review 的 V=Fin 3→ℝ、Mat3=3×3 实矩阵。以下判定针对陈述/定义语义，不以 sorry 的有无判定。展开 rigidDrift M h 得 q+(h/M)p，并且 dlmMassOnly 是含两次 Kick 和五轴 Spin 的完整单体映射。所绑定原文却只有 Step 2 的 q+hp，既引入质量分母，又扩大对象到完整算法。[EXTRA] 描述的是修订算法而非额外数学假设，不能使陈述忠实于所引原句。质量修订有 PDF193 的 dq/dt=p/M 依据，但必须与原式分开；无论证明是否完成均属签名不一致。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dlmMassOnly`：定义；`MD.Ch04.dlmMassOnly_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3013)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DriftSpinCommute · unnumbered_claim · 印刷p.174 / PDFp.196

### 2. 原文陈述

> Note that the symmetric character of the algorithm could be revealed more clearly by dividing the “Drift” step into two half steps sandwiched around the Spin step (Kick, Drift, Spin, Drift, Kick), but as the updates Drift/Spin are decoupled, the order they are performed is not important.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem driftSpinCommute : ∀ M h (I : MolecularDynamics.Chapter04Review.V) (z : MolecularDynamics.Chapter04Review.RBState),
  MolecularDynamics.Chapter04Review.rigidDrift M h (z.1,printedSpinStep I h z.2)=
    ((MolecularDynamics.Chapter04Review.rigidDrift M h z).1,printedSpinStep I h (MolecularDynamics.Chapter04Review.rigidDrift M h z).2) := by
  intro M h I z
  rfl

theorem driftSpinCommute_halves (M h : ℝ) (I : MolecularDynamics.Chapter04Review.V)
    (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) :
    MolecularDynamics.Chapter04Review.rigidDrift M h=
      MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘ MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∧
    (MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘
      (fun z : MolecularDynamics.Chapter04Review.RBState ↦ (z.1,printedSpinStep I h z.2)) ∘
      MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2))=
    (MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘
      (fun z : MolecularDynamics.Chapter04Review.RBState ↦ (z.1,printedSpinStep I h z.2)) ∘
      MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.driftSpinCommute`；`MD.Ch04.driftSpinCommute_halves` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原交换性证明，并补漂移半步合成与完整Kick/Drift/Spin/Drift/Kick排列恒等式；M=1即字面原算法，新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原交换性证明，并补漂移半步合成与完整Kick/Drift/Spin/Drift/Kick排列恒等式；M=1即字面原算法，新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两个声明均已审校。driftSpinCommute 对任意实M,h、I和全状态z给出Drift∘Spin=Spin∘Drift的全状态等式：Drift只改变q，Spin只改变(π,Θ)。driftSpinCommute\_halves同时给出两个半步drift合成一步，以及含两端Kick的K(h/2)∘S(h)∘D(h)∘K(h/2)=K(h/2)∘D(h/2)∘S(h)∘D(h/2)∘K(h/2)。角度仍用整个spin步h，未误减半。M=1正是原印算法，任意M的代数推广不依赖旋转符号勘误；sorry不构成签名FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch04.driftSpinCommute`：已证；`MD.Ch04.driftSpinCommute_halves`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3026)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMStructureFormal · unnumbered_claim · 印刷p.173–174 / PDFp.195–196

### 2. 原文陈述

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dlmStructure :
  ∀ M (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h) ∧ ∀ z : MolecularDynamics.Chapter04Review.RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      MolecularDynamics.Chapter04Review.dlmMassConsistent M I U (-h) (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z)=z ∧
      (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2ᵀ*(MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2=1 := by
  sorry



/-- 修正版，对应原文 MD-4.4.2-DLMStructureFormal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem dlmStructure_corrected :
  ∀ M (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h) ∧ ∀ z : MolecularDynamics.Chapter04Review.RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      MolecularDynamics.Chapter04Review.dlmMassConsistent M I U (-h) (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z)=z ∧
      (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2ᵀ*(MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2=1 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmStructure`；`MD.Ch04.dlmStructure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。rbTangent(z,v) 为 ΘᵀδΘ+δΘᵀΘ=0；rbForm 用 ξ=rot(ΘᵀδΘ)/2、η=rot(Θᵀδ′Θ)/2，取 δq·δ′p−δ′q·δp+ξ·δ′π−η·δπ+π·(ξ×η)。rbSymplectic 量化所有满足 ΘᵀΘ=1、det Θ=1 的输入和两个实际切向量，要求真实 fderiv 的两形式拉回等式；它本身未要求输出 SO(3) 或输出导数切向性，不能仅凭谓词名字推断这些结论。axisRotation 的 x 轴矩阵为 [[1,0,0],[0,cos φ,−sin φ],[0,sin φ,cos φ]]，y、z 为对应标准主动旋转。spinAxis 每次由当前 π\_i 计算 φ=hπ\_i/I\_i，更新 (Rπ,ΘRᵀ)；spinStep 的函数复合从右向左执行 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。rigidKick 同时以 −grad U 和 −rot(ΘᵀmatrixGrad U) 更新两种动量；rigidDrift 使用 q+h p/M；dlmMassConsistent 是半 kick、drift、spin、半 kick。签名量词为任意正 M、正主惯性 I、C³ 单体势 U、任意 h；另对每个 SO(3) 输入要求逆步复合为恒等及输出正交性。正质量和正惯性合理，C³ 是较强但合理的技术资格；回逆与正交性是原引用句以外的算法性质，不应当作该句逐字结论。该对象是质量修订的 N=1 实例，而原文为全部刚体、可耦合势的完整系统；[EXTRA] 明示单体并不能补足原结论。签名中的质量一致也只修订 drift，spin 仍是印刷正角，名称不能当作精确原动力学流的证据。正角子步可看作负旋转动能的 Hamilton 子流，因此与原方程符号不符本身不反证辛性。此 FAIL 针对原文对象范围与陈述对应，而非由 sorry 推断数学命题为假。实际证明体含 sorry，独立于签名审计。

### 7. 状态与证明位置

incomplete；`MD.Ch04.dlmStructure`：未证（原书疑误不证）；`MD.Ch04.dlmStructure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3047)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrintedStructure · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dlmPrintedStructure : ∀ (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (dlmPrinted I U h) := by
    sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅N=1字面算法两形式拉回等式；原全系统含SO(3)域的结构断言由MD-4.4.2-DLMPrintedSystemStructure承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrintedStructure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅为字面单体辛性实例；原句任意N耦合算法与输入/输出SO(3)域由DLMPrintedSystemStructure承担，不再把rbSymplectic名字当作完整输出约束。 | [EXTRA] |

[EXTRA] 明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。；[EXTRA] 本条仅为字面单体辛性实例；原句任意N耦合算法与输入/输出SO(3)域由DLMPrintedSystemStructure承担，不再把rbSymplectic名字当作完整输出约束。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；就明确限定的N=1两形式拉回等式PASS。定理量化所有I、U，在逐项正惯性与联合C³势前提下，对任意实h断言实际dlmPrinted映射满足rbSymplectic。已展开该谓词：初态ΘᵀΘ=1且detΘ=1，对任意满足ΘᵀδΘ+δΘᵀΘ=0的u,v，实际fderiv像上的rbForm等于输入rbForm；并非只检查一个叫symplectic的标签。rbForm中的1/2·matrixRot给出正确体坐标切向量，叉积项符号与标准刚体余切形式一致。正角Printed spin对应负旋转动能子流，符号疑点不破坏子步的辛性，因此不能据条目10的物理一致性疑点把此签名判为假。

### 7. 状态与证明位置

incomplete；`MD.Ch04.dlmPrintedStructure`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3075)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemState · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> Procedures given below for rigid body $k$ are meant to be performed for all rigid bodies in the system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
@[reducible] def rigidSystemState (N : ℕ) := Fin N → MolecularDynamics.Chapter04Review.RBState
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemState` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。 | [EXTRA] |

[EXTRA] [EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。Fin N→RBState 确实为所有刚体同时保存 q、p、π、Θ；N 任意自然数，允许 N=0 是无害的空系统推广。[EXTRA] 是透明表示选择，并未强迫 U 为独立势。这里是承载状态的环境空间，不是 SO(3) 合法态子类型；原文旋转矩阵约束需在使用该状态的几何断言中施加，不能宣称这个类型自动满足它。作为本条“所有刚体执行”的状态表示忠实；无证明义务、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemState`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3082)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemForce · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The relevant expressions are:

$$
F^k=-\frac{\partial U}{\partial q^k},
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemForce` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；签名和定义体忠实于F^k = −∂U/∂q^k。V = Fin 3 → ℝ，Mat3 = Matrix (Fin 3) (Fin 3) ℝ；结果为三维力。对任意N、输入状态z和k，切片x ↦ U(update q k x) Θ在当前q^k处求负梯度，允许U耦合所有刚体，未将U替换为逐体可分势，也未改变或冻结其他刚体的当前状态。没有额外Lean前提或被遗漏的定理结论；这是一个定义。fderiv总化所带来的域外取值只作为形式定义的延拓，不据此宣称不可微势具有物理力。原文句末逗号属JSON摘录问题，不构成Lean签名FAIL。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemForce`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3085)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemTorque · definition · 印刷p.173 / PDFp.195

### 2. 原文陈述

> $\tau^k=-\operatorname{rot}([\Theta^k]^T\partial U/\partial\Theta^k)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemTorque` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐项核对通过。N为自然数，k取Fin N，U为完整位置/方向数组上的实值耦合势，输出为V。矩阵切片A ↦ U(q, update Θ k A)只改变第k个方向矩阵，在当前Θ^k处求matrixGrad，再左乘(Θ^k)^T并施加外层负matrixRot；所有位置及其余方向均保持当前状态。Fin 3从0起编号，所给三个反对称差分正对应原书从1起编号的(A32−A23,A13−A31,A21−A12)。未误加1/2、未交换乘法次序、未用当前角动量代替方向矩阵；无额外前提或结论。与原书导数的数学对应在相应切片可微处读取，fderiv的总化规则并非新增物理断言。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemTorque`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3091)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemKick · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemKick` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；签名及完整输出通过。N、U与前两项相同，新增实数子步参数和整个N体状态输入/输出；没有隐含的逐体顺序更新。q=(z k).1.1与Θ=(z k).2.2保持，p与π分别加相同子步长度乘当前力及力矩。源文h表示整体步长，Lean中同名局部参数表示子步时长；已给context\_notation说明且dlmPrintedSystem实际传入h/2，因此不存在半步遗漏或两倍系数错误。参数重命名属于记号对应，不是额外物理假设。没有新增前提或超出定义的定理结论。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemKick`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3098)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemDriftPrinted · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemDriftPrinted {N : ℕ} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemDriftPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。对所有 k 更新 q\_k+h p\_k，保持 p、π、Θ；与 PDF196 第2步字面完全一致。[ERRATUM?] 有依据：p 在 PDF195 被定义为线动量；由质心动能 p²/(2M\_k) 得 dq/dt=p/M\_k，故一般质量应为 q+h p/M\_k。例 M\_k=2、p=e₁、h=1，原表给位移 e₁，物理平移流给 e₁/2。定义明确是 Printed 且保留疑误，不静默修改，所以签名忠实于印刷式，PASS 不代表原算法对任意质量动力学一致。无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemDriftPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3106)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemSpinPrinted · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemSpinPrinted {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemSpinPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖定位：Ch04\_deps.txt 的 MolecularDynamics/Chapter04/ReviewDefinitions.lean 分段。V=Fin 3→ℝ，Mat3=3×3 实矩阵，RBState=(V×V)×(V×Mat3)，依次为(q,p,π,Θ)。axisRotation 的 x 轴矩阵为 [[1,0,0],[0,cos φ,−sin φ],[0,sin φ,cos φ]]，y、z 为对应标准主动旋转。spinAxis 每次由当前 π\_i 计算 φ=hπ\_i/I\_i，更新 (Rπ,ΘRᵀ)；spinStep 的函数复合从右向左执行 x(h/2),y(h/2),z(h),y(h/2),x(h/2)。MD.Ch04.printedSpinStep 与依赖展开的 spinStep 同式；每体调用 I k，可有不同主惯性，各子步用已更新动量。保持 q,p，按表更新 π,Θ，全部五子步均包含。[ERRATUM?] 成立：i=x、I₁=1、π=(1,1,0)、Θ=1 时，正角旋转的初始 π 导数为 (0,0,1)，而 π×(π₁e₁/I₁)=(0,0,−1)；Θ 导数也为 −Θ skew(π₁e₁/I₁)，与 PDF195 的恢复方程反号。这不妨碍它是印刷表的忠实定义，也不单独否定辛性。未冒充精确原 Euler 子流，无额外假设、无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemSpinPrinted`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3111)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrintedSystem · definition · 印刷p.174 / PDFp.196

### 2. 原文陈述

> DLM Rigid Body Molecular Dynamics Step
> 1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:

$$
p^k:=p^k+\tfrac h2 F^k,\quad\pi^k:=\pi^k+\tfrac h2\tau^k.
$$


> 2. “Drift”: step forward a whole step in positions

$$
q^k:=q^k+hp^k.
$$


> 3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps

$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$



$$
\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T
$$


> 4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $F^k$ and torques $\tau^k$ evaluated at the current $q,\Theta$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)



/-- 修正版，对应原文 MD-4.4.2-DLMPrintedSystem。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def dlmPrintedSystem_corrected {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrintedSystem`；`MD.Ch04.dlmPrintedSystem_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；字面忠实性核对通过，未发现应判FAIL的Lean语义偏差：Drift确为q+h p，未私补质量；Spin保留正角及配对的Rπ、ΘRᵀ，矩阵乘法方向正确。每个子步从其输入重新计算角度，不冻结初始π；所有刚体均执行。两次kick分别从各自输入完整状态计算耦合力/力矩，末kick使用Drift/Spin后的全部q、Θ，不复用旧力。定义域包括N : ℕ、逐体三维惯性I、任意实数h及任意所给U；定义无I>0或光滑性前提，这些物理资格不能假称已在定义中。总体NEEDS\_HUMAN仅依任务对原书数学疑点的分流规则：质量归一化及旋转动力学约定待确认。Printed版忠实，故不判FAIL；质量/旋转方向疑点也不是不辛反例。

### 7. 状态与证明位置

self-contained；`MD.Ch04.dlmPrintedSystem`：定义；`MD.Ch04.dlmPrintedSystem_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3118)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-SystemDriftSpinCommute · unnumbered_claim · 印刷p.174 / PDFp.196

### 2. 原文陈述

> as the updates Drift/Spin are decoupled, the order they are performed is not important.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem systemDriftSpinCommute : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V) h (z : rigidSystemState N),
    rigidSystemDriftPrinted h (rigidSystemSpinPrinted I h z)=
      rigidSystemSpinPrinted I h (rigidSystemDriftPrinted h z) := by
  intro N I h z
  rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.systemDriftSpinCommute` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；已展开Ch04.lean:1860、1884–1891的rigidSystemState、rigidSystemDriftPrinted和rigidSystemSpinPrinted，以及1739–1747的printedSpinAxis/printedSpinStep；正式库V、Mat3及RBState的实际定义已在Ch04\_deps.txt的-- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean中读到。全状态每体为((q,p),(π,Θ))。drift把(q,p)改为(q+h p,p)，完整保持(π,Θ)；spin完整保持(q,p)，其R角度只依赖当前π、该体I及h，输出(Rπ,ΘR^T)的五步组合，不读取q或p。两种复合逐体均为((q+h p,p),printedSpinStep(I\_k,h,(π,Θ)))，故原文的“decoupled”被表达为真正全N体函数值相等。量词∀N、∀I、∀h、∀z没有偷加独立势或N=1限制，也没有交换依赖全体构型的kick；无需惯性正性、SO(3)或势能正则性才能成立，因为该等式是分量独立性的恒等式。质量与Spin符号的印刷问题也不影响此交换性。Ch04.lean:1902–1907实际证明为intro N I h z; rfl，无sorry；签名忠实与该现有证明的状态分别核对。

### 7. 状态与证明位置

self-contained；`MD.Ch04.systemDriftSpinCommute`：已证。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3134)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-RigidSystemSymplectic · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅全系统辛性辅助谓词定义；原文算法性质由MD-4.4.2-DLMPrintedSystemStructure承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rigidSystemSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅定义全系统受约束两形式拉回性质，原句算法确实满足该性质由已有DLMPrintedSystemStructure断言，区分性质定义与算法定理。 | [EXTRA] |

[EXTRA] [EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。；[EXTRA] 本条仅定义全系统受约束两形式拉回性质，原句算法确实满足该性质由已有DLMPrintedSystemStructure断言，区分性质定义与算法定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；在输入明确限定的“辅助谓词定义”范围内PASS，不把def当作原句算法定理。参数为任意全系统映射G；对所有输入z，全部k的ΘᵀΘ=1及detΘ=1作为蕴含前件，结论明确包含全部输出SO(3)约束。随后量化完整u、v，分别要求每体rbTangent，再比较∑k rbForm(Gz\_k,(DG\_z u)_k,(DG\_z v)_k)与∑k rbForm(z\_k,u\_k,v\_k)。DG是整个G在整个z上的fderiv，故保留所有跨体耦合导数，未偷换为逐体局部导数。rbForm包含dq·δp−δq·dp及ξ·δπ−η·dπ+π·(ξ×η)；ξ、η中的1/2正确地抵消matrixRot对反对称矩阵的倍数。已列[EXTRA]准确揭示SO(3)、实际切向量、有限和与真实导数的形式化内容，没有以假设辛性替代结论。定义未单独断言G光滑或全局可逆，按既定scope只把它当作约束保持及拉回性质；实际算法性质仍须由条目6的theorem承担。

### 7. 状态与证明位置

self-contained；`MD.Ch04.rigidSystemSymplectic`：定义。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3143)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.2-DLMPrintedSystemStructure · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dlmPrintedSystemStructure : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
  sorry



/-- 修正版，对应原文 MD-4.4.2-DLMPrintedSystemStructure。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem dlmPrintedSystemStructure_corrected : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.dlmPrintedSystemStructure`；`MD.Ch04.dlmPrintedSystemStructure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；签名的字面忠实性核对通过。全部对象、域、量词及两个实质前提与给定定义相容：任意有限N体、逐体正主惯性矩、联合全局C³耦合势、任意实h。结论是该具体完整Printed组合对每一个SO(3)输入保持SO(3)输出，并对任意两条全系统切向量保持∑rbForm的真实Fréchet拉回；没有缩为单体、没有遗漏末次力/力矩重算、没有以预设辛性或抽象占位形式替换目标。正惯性和全环境全局C³属于显式[EXTRA]限缩，已细化披露。原句的可靠性解释不是额外定量定理，未形式化为误差界不构成结论遗漏。theorem中sorry仅表示证明未交付，不作为FAIL理由，本轮也不声称Lean证明已完成。总体NEEDS\_HUMAN依任务对原书质量及Spin动力学约定疑点的保留规则；这与签名忠实性通过并存。特别是无质量Drift及正角配对Spin本身都不能推出映射不辛，未据此提出辛性反例。

### 7. 状态与证明位置

incomplete；`MD.Ch04.dlmPrintedSystemStructure`：未证（原书疑误不证）；`MD.Ch04.dlmPrintedSystemStructure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3153)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.4.1-ExactPlanarRotation · unnumbered_claim · 印刷p.173 / PDFp.195

### 2. 原文陈述

> Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactPlanarRotation : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  sorry



/-- 修正版，对应原文 MD-4.4.1-ExactPlanarRotation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem exactPlanarRotation_corrected : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.exactPlanarRotation`；`MD.Ch04.exactPlanarRotation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]第二/第三子场按完整π₂/π₃解释，与PrincipalAxisField一致；显式负角主动旋转给出(4.41)的π×ω符号，不将原表正角错误候选当作该精确子流。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；依赖已展开：Ch04\_deps.txt中MolecularDynamics/Chapter04/ReviewDefinitions.lean的V=Fin 3→ℝ，Mat3=Matrix (Fin 3) (Fin 3) ℝ；cross3(u,v)=(u₁v₂−u₂v₁,u₂v₀−u₀v₂,u₀v₁−u₁v₀)。axisRotation的三分支分别是主动Rx=[[1,0,0],[0,cosφ,−sinφ],[0,sinφ,cosφ]]、Ry=[[cosφ,0,sinφ],[0,1,0],[−sinφ,0,cosφ]]、Rz=[[cosφ,−sinφ,0],[sinφ,cosφ,0],[0,0,1]]。Pi.single i a在i处为a，其余处为0；矩阵*ᵥ为逐行点积，HasDerivAt断言实际实参数向量导数。量词为任意I、初值π、轴i，在0<I\_i下，所有实t；γ(t)=R\_i(−tπ\_i/I\_i)π。旋转固定第i分量并在t=0为恒等，导数为−(π\_i/I\_i)e\_i×γ=γ×e\_i(γ\_i/I\_i)，因此该签名完整表达了预期主轴子场的精确平面旋转，三个结论均正确；不需要其它轴惯量的正性，选中惯量正性符合物理背景但数学上非零已足够。[EXTRA]负角是该主动矩阵与(4.41)叉积方向下必要的符号选择，并未将p.174正角算法替代为正确精确流。[EXTRA]把第二、第三子场的无下标π解释为π₂/π₃合理且符合p.172对角惯量分裂，但原页字面第二、第三式把向量π放在单个标量分量中，含义未定义；无法对原样展示公式无条件给PASS。需人工确认原书缺下标及T\_i与I\_i的意图；这是原文数学含义问题，不是缺库定义。[ERRATUM?]本条无独立该标签，所涉及缺下标确实存在；正角方向疑点由以上导数支持。签名语义与证明完成度分开：实际exactPlanarRotation的证明体为sorry，本次未写证明、未声称Lean已验证此结论。

### 7. 状态与证明位置

incomplete；`MD.Ch04.exactPlanarRotation`：未证（原书疑误不证）；`MD.Ch04.exactPlanarRotation_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../Blueprint/Ch04.lean#L3175)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

