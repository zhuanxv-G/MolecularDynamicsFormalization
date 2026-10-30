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

## 1. MD-4.1-ActualMidpointRelation · definition · 印刷p.142 / PDFp.164

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L468)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ImplicitFactor · definition · 印刷p.142 / PDFp.164

### 2. 原文陈述

> can be applied to $`\dot z=i\Omega z`$ and yields

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L479)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ImplicitModulus · unnumbered_claim · 印刷p.142 / PDFp.164

### 2. 原文陈述

> For all real $`\Omega`$, we find

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L491)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L522)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-ModifiedFrequencyLimit · unnumbered_claim · 印刷p.143 / PDFp.165

### 2. 原文陈述

> The figure shows that the frequency is only well approximated in case $`h\Omega`$ is sufficiently small. For $`h\Omega\gg1`$ the frequency is highly modified.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L534)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-MechanicalMidpoint · definition · 印刷p.144 / PDFp.166

### 2. 原文陈述

> we may reduce the equations to determining midpoint values $`\widehat q,\widehat p`$ such that

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L554)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.1-MidpointElimination · unnumbered_claim · 印刷p.144 / PDFp.166

### 2. 原文陈述

> We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $`\widehat p`$, we find

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L561)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-SplitHamiltonian · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> In many molecular dynamics applications, the system may be decomposed as $`H(q,p)=p^TM^{-1}p/2+U_S(q)+U_F(q)`$ where $`U_S`$ is a “soft” potential, in which the natural motion would be relatively slow, whereas $`U_F`$ is a much stronger term which would give rise to relatively rapid motion.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L586)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-FastVerlet · definition · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Let us $`\mathcal G_h^F`$ denote the map associated to the Verlet method for the system without $`U_S`$, using a stepsize $`h`$:

$$
\mathcal G_h^F=\mathrm e^{\frac h2\mathcal L_{U_F}}\mathrm e^{h\mathcal L_K}\mathrm e^{\frac h2\mathcal L_{U_F}},
$$


> where $`\mathcal L_K`$ is the Lie-derivative corresponding to the kinetic energy component of Hamiltonian $`(K=p^TM^{-1}p/2)`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L591)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-RESPA · (4.2) · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Now consider the map constructed by taking $`r`$ steps using $`\mathcal G_{F,h/r}`$ and composing this with kicks from the soft force:

$$
\mathcal G_h^{\mathrm{MTS}}=\mathrm e^{\frac h2\mathcal L_{U_S}}[\mathcal G_{h/r}^F]^r\mathrm e^{\frac h2\mathcal L_{U_S}}.
$$


> One step of the multiple timestepping algorithm is then implemented as follows:
> Reversible RESPA Algorithm

$$
P:=p-(h/2)\nabla U_S(q),\quad Q:=q;
$$


> Repeat $`r`$ times:

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L625)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-RESPAStructure · unnumbered_claim · 印刷p.145 / PDFp.167

### 2. 原文陈述

> Because $`U_F`$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L636)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L657)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L662)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseMatrix · definition · 印刷p.146 / PDFp.168

### 2. 原文陈述

> In the limit of small inner step, we solve the system with Hamiltonian $`H_F=p^2/2+\Omega^2q^2/2`$ exactly, meanwhile punctuating with impulses from $`U_S`$, thus the MTS flow map approximation, which is linear in this case, can be written in the form of a matrix-vector multiply

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L666)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ImpulseDet · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> Both of these matrices have unit determinant for any $`h`$, so the product of the eigenvalues of $`W_h`$ is $`1`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L671)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L696)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonancePower · unnumbered_claim · 印刷p.146 / PDFp.168

### 2. 原文陈述

> For example, at $`h=\pi/\Omega`$, we have

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L714)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceTaylor · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> We can see this by expanding $`\mu(h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega)`$ in a Taylor expansion around $`h=\pi/\Omega`$:

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L737)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceInstability · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> Here both eigenvalues are real and one is outside the unit circle. There is thus a small interval of exponential instability directly below $`h=\pi/\Omega`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L759)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceEigenPrinted · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> For $`\varepsilon\lt 0`$, however, we have

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L778)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.2-MollifiedAverage · definition · 印刷p.149 / PDFp.171

### 2. 原文陈述

> The mapping $`\mathcal A(q)`$ is defined by reference to the fast dynamics, e.g. by the weighted average

$$
\mathcal A(q)=\frac1{K+1}\sum_{i=0}^K\phi_i\theta_i(q),
$$


> where the $`\theta_i`$ are defined recursively by solving the system with Hamiltonian

$$
H^{\mathrm{fast}}(q,p)=p^TM^{-1}p/2+U_F(q)
$$


> starting from initial position $`q`$ and zero initial momentum $`p`$, for $`K`$ timesteps using a small stepsize $`\tau_f`$.

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
量词、初态及结果：隐式n:ℕ，显式参数m、UF、K:ℕ、w:ℕ→ℝ、δ:ℝ、q；固定前述参数后得到仅依赖q的映射。θ\_i(q)=((fastVerlet m UF δ)^[i](../../q,0)).1，θ\_0=q；Finset.range(K+1)恰给i=0,…,K，w i对应φ\_i，外部因子1/(K+1)与原式一致。δ就是平均过程的小步长参数，没有被强制等同于RESPA内步长，符合原页上下文。
[EXTRA]评估：原书只说 recursively by solving 及 e.g.，未指定快积分器；选择Verlet合理，但不是原文要求或唯一方案，必须保留该实例说明。有限加权和不要求权重和为K+1，也未宣称任意权重都有滤波效果。签名不限制δ为小正数、质量为正或UF光滑，是总函数定义的代数扩展；其物理积分器解释使用正质量、可微势及适当小正步长，不能据此把全部参数称为有效物理滤波器。这里没有关于有效性、收敛性或精确流的定理结论，故该总定义扩展不造成此条结论错误。
[ERRATUM?]：本条没有该标注；原页所选公式未发现需要勘误之处。证明状态：本项是def，主体无sorry；不据此声称滤波性能已证明。

### 7. 状态与证明位置

self-contained；`MD.Ch04.mollifiedAverage`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L801)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.2-MollifiedPotential · definition · 印刷p.148–149 / PDFp.170–171

### 2. 原文陈述

> Effectively, one replaces $`U_S(q)`$ wherever it appears within the MTS method by a modified potential function $`\overline U(q)\stackrel{\mathrm{def}}=U_S(\mathcal A(q))`$.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L806)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceLinearRate · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> and the norm of the solution will oscillate and grow linearly with $`n`$ as $`n\to\infty`$. This is the simplest type of linear resonance present in multiple timestepping.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L811)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.2.1-ResonanceGrowth · unnumbered_claim · 印刷p.147 / PDFp.169

### 2. 原文陈述

> and the norm of the solution will oscillate and grow linearly with $`n`$ as $`n\to\infty`$. This is the simplest type of linear resonance present in multiple timestepping.

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
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L881)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

