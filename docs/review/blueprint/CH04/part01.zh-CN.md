上一部分：无 / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第4章 Lean Blueprint 本地审阅材料

179条；网站PASS 133，本地按意见修复7条（未再送网站），合并勘误26项。
统计与证明状态见[导师摘要](../../CH04_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](../../CH04_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch04/full/CHECK\_REPORT.json。

## 1. MD-4-LinearField · (4.1) · 印刷p.139 / PDFp.161

### 2. 原文陈述

> Let us recall the method of studying the asymptotic numerical stability of a linear system

$$
\dot z=Az,\tag{4.1}
$$


> where $`z\in\mathbb R^m,A\in\mathbb R^{m\times m}`$, when solved by a numerical method.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L25)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-EulerFactor · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> Here $`\lambda`$, hence $`u`$ may in general be complex. Then one applies the numerical method directly to the scalar equation. For example Euler’s method yields

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L28)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-ScalarEulerStable · unnumbered_claim · 印刷p.139 / PDFp.161

### 2. 原文陈述

> The iteration is stable if $`|u_n|`$ remains bounded as $`n\to\infty`$, implying the following condition for asymptotic stability:

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L32)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-EulerRegion · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> This defines the “stability region” for Euler’s method as a disk in the complex $`h\lambda`$-plane centered around $`-1`$ of radius $`1`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L50)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-OscillatorMatrix · definition · 印刷p.139 / PDFp.161

### 2. 原文陈述

> If we consider applying this technique to the harmonic oscillator $`\dot q=p;\dot p=-\Omega^2q`$, then the matrix $`A`$ is

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L54)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-EulerImaginaryGrowth · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues are $`\pm i\omega`$. The reason a method like Euler’s method can never perform well for molecular dynamics is that molecular dynamics is a Hamiltonian system and at the bottoms of basins on the energy surface, which correspond to stable centers, we expect all the eigenvalues of a local linearization of the problem to be purely imaginary. The stability condition always fails to hold and, for Euler’s method, $`z_n`$ grows exponentially rapidly away from the equilibrium point.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L59)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerMatrix · definition · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The timestep map is defined by

$$
Q=q+hP,\qquad P=p-h\Omega^2q.
$$


> Solving for $`Q,P`$ this yields

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L83)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L89)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L100)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-VerletStability · unnumbered_claim · 印刷p.141 / PDFp.163

### 2. 原文陈述

> For example, applying the Verlet method to the harmonic oscillator with frequency $`\Omega`$ we find that the origin is stable (and the numerical solution stays bounded for all time) provided $`h\Omega\le2`$ (the same condition as for stability of Symplectic Euler).

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L128)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerBoundaryPrinted · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> if $`h\Omega\le2`$ the integrator is stable.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L205)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-VerletBoundaryPrinted · unnumbered_claim · 印刷p.141 / PDFp.163

### 2. 原文陈述

> the numerical solution stays bounded for all time) provided $`h\Omega\le2`$

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L223)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-OscillatorSpectrum · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> The eigenvalues are $`\pm i\omega`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L239)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L266)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerUnitRoots · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> Then we observe that for $`h^2\Omega^2\le4`$, they are complex and their squared magnitude is

$$
|\lambda_{1,2}|^2=\left(1-\frac{h^2\Omega^2}{2}\right)^2+\frac14(4h^2\Omega^2-h^4\Omega^4)=1,
$$


> thus both eigenvalues lie on the unit circle in the complex plane as long as $`h\Omega\le2`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L297)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4-SymplecticEulerStability · unnumbered_claim · 印刷p.140 / PDFp.162

### 2. 原文陈述

> This is the so-called linear stability condition of the Symplectic Euler method: if $`h\Omega\le2`$ the integrator is stable. When $`h\Omega\gt 2`$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $`2/\Omega`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L355)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-PrintedImplicitRelation · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> The Implicit Midpoint method which, for the ODE $`\dot z=f(z)`$ takes the form

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L456)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

