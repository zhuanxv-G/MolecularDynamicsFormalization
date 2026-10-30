[上一部分](part02.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## 1. MD-2.2.2-LeapfrogReconstruct · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> And it is also necessary to use, at any subsequent step,

$$
\boldsymbol v_n=\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,
$$


> if $`\boldsymbol q_n,\boldsymbol v_n`$ are both needed, e.g. for the evaluation of the energy or other velocity-dependent observable.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_leapfrogReconstruct {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 + (h/2) • invMass m (F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_leapfrogReconstruct` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean:2816–2817、2840：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m x i=(m i)⁻¹*x i；加减、实数标量作用均逐坐标，因此对应有限维坐标空间及固定对角质量矩阵 diag(m)。教材的非零（物理上正）质量域上，这正是 M⁻¹。Lean 在零质量处取 0⁻¹=0，是公式的全域延拓，不宣称零质量矩阵可逆；在原文定义域上没有改变公式。任意实数 h、任意 F 的代数公式无需光滑性、保守力或 h≠0；这些物理/分析条件不用于本条等式。五条均无 [EXTRA] 或 [ERRATUM?] 标记。实际蓝图附件为 /workspace/Ch02.lean，按要求以 Blueprint/Ch02.lean 为版本绑定键。已展开蓝图259–260行与正式库 leapfrogReconstruct（2868–2869）：输入 (q\_n,v_(n−1/2))，返回 v_(n−1/2)+(h/2)M⁻¹F(q\_n)，正号、半步系数、F\_n=F(q\_n)及返回整步速度完全一致。任意输入状态的定义可在任意后续步骤应用，无需将时间指标作为额外参数。能量和依赖速度的观测量是重建速度的用途，原文未给这些量的额外等式，本定义没有遗漏需形式化的结论。证明状态单列：显式定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_leapfrogReconstruct`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L360)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorDifference · unnumbered_claim · 印刷p.66 / PDFp.88

### 2. 原文陈述

> Taking the difference of the numerical and exact solutions, we have

$$
\boldsymbol z_{n+1}-\boldsymbol z(t_{n+1})=\mathcal G_h(\boldsymbol z_n)-\mathcal F_h(\boldsymbol z(t_n)).\tag{2.9}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem errorDifference :
  ∀ n (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) h k,
    γ ((k+1 : ℕ)*h) = F h (γ (k*h)) →
    oneStepIterate G h (γ 0) (k+1) - γ ((k+1 : ℕ)*h) =
      G h (oneStepIterate G h (γ 0) k) - F h (γ (k*h)) := by
  exact MolecularDynamics.Chapter02Review.errorDifference_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.errorDifference` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；对象展开：Ch02\_deps.txt:2816（MolecularDynamics/Chapter02/ReviewDefinitions.lean）Q n := Fin n → ℝ，是n维实坐标空间；加减逐坐标，默认Pi范数为最大坐标绝对值。原文此处使用范数而未在本条指定欧氏范数，此选择不改变所述范数不等式的结构；不能将该实例误称为欧氏范数。n可取完整状态的坐标数，Q这个名字不把变量限制为位置。 迭代展开：Ch02\_deps.txt:1443–1452（MolecularDynamics/Chapter02/OneStepConvergence.lean）oneStepIterate G h z₀ n := (G h)^[n] z₀；0次为z₀，后继为G h作用于前一节点。代入z₀=γ 0，正是共同初值的数值解。 Ch02.lean:263–270全称n,G,F,γ,h,k，先假设γ((k+1)h)=F\_h(γ(kh))，再得到数值后继减精确后继等于G\_h(数值当前节点)减F\_h(精确当前节点)，正是PDF88式(2.9)，未缺结论项。相同初值来自数值解的背景；任意h及无光滑性是代数恒等式的合理推广，无新增必要假设或[ERRATUM?]。依赖Statements.lean的errorDifference\_statement（deps:3020–3025）同签名，ReviewProofs.lean的errorDifference\_proved（deps:3366–3368）用后继递推及精确节点等式改写。证明状态单独记录：本地声明及本项直接调用的依赖证明体未见sorry；本次未编译工程，不据此认证整个依赖工程无证明缺口。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.errorDifference`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L364)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-Consistency · definition · 印刷p.66–67 / PDFp.88–89

### 2. 原文陈述

> The first assumption is that $`\mathscr G_h`$ is an $`O(h^{p+1})`$ approximation of $`\mathscr F_h`$ in the sense that there is a constant $`K\ge0`$ and a constant $`\Delta\gt 0`$ such that, for $`t\in[0,\tau]`$, we have

$$
\|\mathscr F_h(\boldsymbol z(t))-\mathscr G_h(\boldsymbol z(t))\|\le\bar K h^{p+1},\qquad h\lt \Delta.\tag{2.10}
$$


> The assumption (2.10) that the local error is of order $`p+1`$, $`p\gt 0`$, is termed the consistency of the numerical method. We say the method is consistent of order $`p`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  0 < p ∧ ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)



/-- 修正版，对应原文 MD-2.2.3-Consistency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def consistency_corrected {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  0 < p ∧ ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.consistency`；`MD.Ch02.consistency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；consistency固定G、F、γ、τ和自然数阶p；要求p>0，并先存在与t、h无关的K≥0、δ>0，再对全部t∈[0,τ]、0<h<δ给局部误差界Kh^(p+1)。严格步长范围与原式一致，整数阶限制已明确为[EXTRA]。未要求F必须是流是此纯误差关系的抽象接口。正文K和式中Kbar不一致已保留，不能在来源层面擅自等同，转人工。

### 7. 状态与证明位置

self-contained；`MD.Ch02.consistency`：定义；`MD.Ch02.consistency_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L374)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-Stability · definition · 印刷p.66–67 / PDFp.88–89

### 2. 原文陈述

> To tackle the question of the growth of local error, we still must make an important assumption on $`\mathcal G_h`$, namely that it satisfies a Lipschitz condition of the form

$$
\|\mathcal G_h(\boldsymbol u)-\mathcal G_h(\boldsymbol w)\|\le(1+hL)\|\boldsymbol u-\boldsymbol w\|,\qquad\boldsymbol u,\boldsymbol w\in\mathcal D;\ h\le\Delta.\tag{2.11}
$$


> The assumption (2.11) that the method does not increase the separation between two nearby trajectories by more than a factor of the form $`1+hL`$ in each step is referred to as the stability of the method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def stability {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u-G h w‖ ≤ (1+h*L)*‖u-w‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.stability` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；对象展开：Ch02\_deps.txt:2816（MolecularDynamics/Chapter02/ReviewDefinitions.lean）Q n := Fin n → ℝ，是n维实坐标空间；加减逐坐标，默认Pi范数为最大坐标绝对值。原文此处使用范数而未在本条指定欧氏范数，此选择不改变所述范数不等式的结构；不能将该实例误称为欧氏范数。n可取完整状态的坐标数，Q这个名字不把变量限制为位置。 Ch02.lean:278–280定义先存在L≥0、δ>0，再对0<h≤δ以及任意u,w∈D全称量化；展开后即PDF88式(2.11)。量词顺序、两个状态及全部结论一致。L非负是合理的常数选择：若某个实L满足界，放大到max L 0对h>0保持界，故存在性不变；后续需要除L时还能选严格正L。D内精确和数值留域是后续应用假设，无需置入此稳定性谓词；不需光滑性。[EXTRA]/[ERRATUM?]均无本地标记，原文h>0由背景提供。证明状态：完整def，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.stability`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L386)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorRecursion · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> then take norms and use the triangle inequality and (2.10), (2.11) to get the following recurrent inequality for the error $`\epsilon_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|`$:

$$
\epsilon_{n+1}\le(1+Lh)\epsilon_n+\bar K h^{p+1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem errorRecursion (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    (h L K p : ℝ) (ν : ℕ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1))
    (n : ℕ) (hn : n < ν) :
    ‖oneStepIterate G h (γ 0) (n + 1) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤
      (1 + h * L) * ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ +
        K * h ^ (p + 1) := by
  apply MolecularDynamics.oneStep_error_recursion <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.errorRecursion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。 | [EXTRA] |

[EXTRA] 精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；迭代展开：Ch02\_deps.txt:1443–1452（MolecularDynamics/Chapter02/OneStepConvergence.lean）oneStepIterate G h z₀ n := (G h)^[n] z₀；0次为z₀，后继为G h作用于前一节点。代入z₀=γ 0，正是共同初值的数值解。 Ch02.lean:284–299在实范数空间E中固定h,L,K,p,ν，hnum和hexact保证0≤n≤ν两类节点均在D；hstable为D上单步界，hconsistent为所有n<ν的轨道局部误差界，然后对任意n<ν输出完整ε_(n+1)≤(1+hL)ε\_n+K h^(p+1)。将F\_h(γ(nh))用精确后继γ((n+1)h)替换、并利用范数对相反差的对称性，忠实对应PDF89递推。[EXTRA]一般实范数空间是合理推广，有限维实例被覆盖而非附加有限维假设；p为实数、在固定步长局部界已直接假定时无需另加p>0、h<Δ等条件，推导只用三角不等式。留域不是额外未经说明的限制。deps:1479–1505的直接依赖证明展开了上述加减G\_h(精确节点)及三角不等式。无[ERRATUM?]标记。证明状态单独记录：本地声明及本项直接调用的依赖证明体未见sorry；本次未编译工程，不据此认证整个依赖工程无证明缺口。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.errorRecursion`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L392)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorBound · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> From this, the bound

$$
\epsilon_n\le\frac{\bar K}{L}e^{Lnh}h^p,\qquad n=0,1,\ldots,\nu,\tag{2.12}
$$


> follows by a straightforward calculation, for $`h\le\Delta`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem errorBound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply MolecularDynamics.oneStep_error_bound <;> assumption



/-- 修正版，对应原文 MD-2.2.3-ErrorBound。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem errorBound_corrected (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply MolecularDynamics.oneStep_error_bound <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.errorBound`；`MD.Ch02.errorBound_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；errorBound对给定正h、正L、非负K和ν，要求0至ν实际迭代与精确网格值均在D，G在D上稳定，且全部n<ν上的实际局部缺陷≤Kh^(p+1)。初始误差由迭代起点γ(0)保证为零。结论对所有n≤ν为(K/L)exp(Lnh)h^p；p为实数，h>0使实幂有意义。此加强前提的界正确，不需要额外p>0才能成立。但没有δ及h≤Δ的量词，不能据此消除书中从严格步长范围跳到闭端点的问题，整体转人工。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.errorBound`：已证；`MD.Ch02.errorBound_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L408)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ConsistencyConvergence · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> This result shows that a method which is consistent of order $`p`$ and stable is convergent of order $`p`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem consistencyConvergence
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
    Tendsto (fun ν : ℕ => oneStepMaxError G (τ / (ν : ℝ)) γ ν) atTop (𝓝 0) ∧
    ∀ᶠ ν : ℕ in atTop, oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
      ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
  constructor
  · exact MolecularDynamics.oneStep_converges_of_consistency_stability G γ D
      (τ := τ) (δ := δ) (L := L) (K := K) (p := p)
      hτ hδ hL hK hp hexact hnum hstable hconsistent
  · have hstep : Tendsto (fun ν : ℕ => τ / (ν : ℝ)) atTop (𝓝 0) :=
      tendsto_const_div_atTop_nhds_zero_nat τ
    have hbound : ∀ᶠ ν : ℕ in atTop,
        oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
          ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
      filter_upwards [eventually_gt_atTop (0 : ℕ), hstep.eventually_lt_const hδ]
        with ν hν hsmall
      have hνR : 0 < (ν : ℝ) := Nat.cast_pos.mpr hν
      have hh : 0 < τ / (ν : ℝ) := div_pos hτ hνR
      have hend : (ν : ℝ) * (τ / (ν : ℝ)) = τ := mul_div_cancel₀ _ hνR.ne'
      have htime : ∀ n ≤ ν, (n : ℝ) * (τ / (ν : ℝ)) ∈ Icc 0 τ := by
        intro n hn
        refine ⟨mul_nonneg (Nat.cast_nonneg n) hh.le, ?_⟩
        calc
          _ ≤ (ν : ℝ) * (τ / (ν : ℝ)) :=
            mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hn) hh.le
          _ = τ := hend
      apply oneStepMaxError_order_bound G γ D ν hh hL hK hend.le
        (hnum ν hν hsmall.le) (fun n hn => hexact (htime n hn))
        (hstable _ ⟨hh, hsmall.le⟩)
      intro n hn
      have ht := htime n (Nat.le_of_lt hn)
      have hnext := (htime (n + 1) (Nat.succ_le_of_lt hn)).2
      simp only [Nat.cast_add, Nat.cast_one, add_mul, one_mul] at hnext ⊢
      exact hconsistent _ ⟨hh, hsmall⟩ _ ht hnext
    exact hbound
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.consistencyConvergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。 | [EXTRA] |

[EXTRA] τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；迭代展开：Ch02\_deps.txt:1443–1452（MolecularDynamics/Chapter02/OneStepConvergence.lean）oneStepIterate G h z₀ n := (G h)^[n] z₀；0次为z₀，后继为G h作用于前一节点。代入z₀=γ 0，正是共同初值的数值解。 最大误差展开：deps:1460–1462的oneStepMaxError := (Finset.range (ν+1)).sup' 非空证明 (fun n => ‖oneStepIterate G h (γ 0) n−γ(nh)‖)，取的恰是0≤n≤ν全部节点的有限最大值，含两端。Ch02.lean:320–339先固定统一τ,δ,L,K,p并要求τ,δ,L,p>0、K≥0；精确轨道在[0,τ]留域，所有正ν且τ/ν≤δ的网格数值节点留域，稳定界统一覆盖0<h≤δ，局部界统一覆盖0<h<δ和t,t+h∈[0,τ]。结论第一项是最大误差沿ν→∞趋零，第二项是最终≤((K/L)exp(Lτ))(τ/ν)^p，既含收敛又含p阶，无遗漏子句。最终正ν自动避免τ/0，有限前缀不影响atTop。局部一致性仅用到t+h≤τ处是足够且合理的轨道表述，在精确流关系下与原文局部缺陷相同。[EXTRA]τ,δ,p正、K非负有背景依据；L正可放大取得；两类留域是原文明示的简化假设。一般E覆盖有限维空间，未额外假定ODE存在或唯一性，因为此处γ已给定且其精确后继局部缺陷直接作为假设。收敛不依赖h=δ端点，未受原书端点疑误影响；无本地[ERRATUM?]标记。deps:1587–1620直接依赖证明采用同一最大误差定义及同一量词和前提。证明状态单独记录：本地声明及本项直接调用的依赖证明体未见sorry；本次未编译工程，不据此认证整个依赖工程无证明缺口。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.consistencyConvergence`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L436)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ScalarVerlet · Example 2.2 (map) · 印刷p.67 / PDFp.89

### 2. 原文陈述

> In this example, assume a single degree of freedom system, i.e. $`q,p\in\mathbb R`$, and take $`M=1`$. The Verlet method can be written in the form of a map, as in (2.8), or, in slightly more detail, as

$$
Q=q+hp+\frac{h^2}{2}F(q),\tag{2.13}
$$



$$
P=p+\frac h2\left[F(q)+F(q+hp+\frac{h^2}{2}F(q))\right].\tag{2.14}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_scalarVerlet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；重新展开Ch02.lean:356–358本地bp\_scalarVerlet：z:ℝ×ℝ，z.1是初始q、z.2是初始p；局部绑定q\_new=z.1+h*z.2+(h²/2)F(z.1)，输出(q\_new,z.2+(h/2)(F(z.1)+F(q\_new)))。完全对应PDF89式(2.13)的Q及式(2.14)的P，坐标顺序、标量对象和单位质量无遗漏；原文F为力，不是此处前面精确流符号F\_h。deps:3026–3028正式scalarVerlet与此本地定义体一致，已另行读取核对。任意F,h的代数公式覆盖本例，无须额外光滑性；无[EXTRA]/[ERRATUM?]标记。证明状态：完整def，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_scalarVerlet`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L482)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletExpansion · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> Combining terms of like powers of $`h`$, we have

$$
P=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{4}[F'F+p^2F'']+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletExpansion :
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletExpansion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F C³，使O(h⁴)余项有实际意义。 | [EXTRA] |

[EXTRA] F C³，使O(h⁴)余项有实际意义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；展开scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2。F C³足以在固定q,p处产生O(h⁴)动量余项；所减多项式逐项为p+hF+(h²/2)pF′+(h³/4)(F′F+p²F″)，系数、求导点和双侧h→0均正确。不把邻近页位置误差符号疑误归到本条动量公式。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletExpansion`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L488)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ExactExpansion · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> Since $`\dot q=p`$, we have $`\ddot q=\dot p=F(q)`$, and the third derivative is $`q^{(3)}=F'(q)p`$. On the other hand $`\dot p=F(q)`$ implies that $`\ddot p=F'(q)\dot q=pF'`$, and thus

$$
p^{(3)}=p^2F''+F'F.
$$


> The Taylor expansion of the solution is (taking $`q(t)=q`$, $`p(t)=p`$):

$$
q(t+h)=q+hp+\frac{h^2}{2}F+\frac{h^3}{6}F'p+O(h^4),
$$



$$
p(t+h)=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{6}[p^2F''+F'F]+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactExpansion :
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.exactExpansion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。 | [EXTRA] |

[EXTRA] F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；F C³、全时实际轨迹γ且γ′=(p,F(q))；在t=0处同时给出位置和动量的三阶Taylor多项式，余项均为双侧O(h⁴)。位置三阶项F′p/6，动量三阶项(p²F″+F′F)/6，全部导数在初始q上取值。原文先写的q″、q⁽³⁾、p″、p⁽³⁾为展开的链式法则推导，已由同一实际ODE与正则性支持，并未改为任意指定Taylor系数。时间原点平移资格已披露。

### 7. 状态与证明位置

incomplete；`MD.Ch02.exactExpansion`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L498)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-DefectPrinted · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> We now examine the series expansions for the exact and Verlet solutions and find that these differ in the third (and higher) order terms.

$$
Q-q(t+h)=\frac{h^3}{6}F'p+O(h^4),
$$


> and

$$
P-p(t+h)=\frac{h^3}{12}[p^2F''+F'F]+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem defectPrinted : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
  sorry



/-- 修正版，对应原文 MD-2.2.3-DefectPrinted。改动：位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。 -/
```

独立修正版：

```lean
theorem defectPrinted_corrected : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1+
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.defectPrinted`；`MD.Ch02.defectPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际轨迹、F C³；t=0归一。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。 | [EXTRA] |

[EXTRA] 实际轨迹、F C³；t=0归一。；[ERRATUM?] 位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt:3026–3028，MolecularDynamics/Chapter02/Statements.lean 的正式 scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2，确与教材算法对应。Ch02.lean:386–392 的对象、量词、C³ 及实际标量轨迹假设与原印一致；两个残差也字面保留原印正号。然而正式定义给 Q−q(h)=−h³F′p/6+O(h⁴)，故位置残差中再减 h³F′p/6 不成立。动量三阶缺陷 (p²F″+F′F)/12 正确。原印的字面忠实与命题的数学错误须区分：本条 FAIL 是确认原书错误已被写成假定理；[ERRATUM?] 成立，不是翻译错号。依赖内另有 verletDefectExpansion\_statement（3043–3048）明确采用修正符号，但本次判断来自展开计算，而非仅凭该名字。[EXTRA] C³、实际轨迹及自治时间平移合理，全轴条件强于必要。本声明体为 sorry；该事实独立于数学反例。

### 7. 状态与证明位置

incomplete；`MD.Ch02.defectPrinted`：未证（原书疑误不证）；`MD.Ch02.defectPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L512)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletConsistency · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> These relations can be summarized as telling us that

$$
\|\mathscr G_h(\boldsymbol z)-\mathscr F_h(\boldsymbol z)\|=\kappa(\boldsymbol z)h^3+O(h^4),
$$


> where $`\kappa(\boldsymbol z)=\kappa(q,p)`$ is a function of the position and momentum. We may then define

$$
\bar K=\max_{t\in[0,\tau]}\kappa(\boldsymbol z(t))
$$


> bounding the local error by (with neglect of the fourth order terms) $`\bar K h^3`$. Thus the Verlet method is consistent of order two.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletConsistency : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
  sorry



/-- 修正版，对应原文 MD-2.2.3-VerletConsistency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem verletConsistency_corrected : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletConsistency`；`MD.Ch02.verletConsistency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；检查全部量词与四部分结论：F C³、τ和δ正、γ在闭窗连续；Φ从每个z出发在统一局部时间窗满足实际ODE且Φ₀z=z；γ与Φ在所需正步长内一致。κ在range γ上连续非负并逐z给正侧h→0的h³主项及O(h⁴)；闭窗上存在真正达到的最大值K；另有统一C、δ₀使闭窗全部t的局部误差≤Ch³。正侧避免|h|³与h³混淆，C吸收余项而不强称C=max κ。该严格修正版合理，但来源忽略余项的界仍需人工确认。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletConsistency`：未证（原书疑误不证）；`MD.Ch02.verletConsistency_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L541)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletStability · unnumbered_claim · 印刷p.68–69 / PDFp.90–91

### 2. 原文陈述

> To complete the convergence proof for Verlet’s method, we would still need to verify the second assumption. This requires the assumption that the force field $`F`$ satisfy a Lipschitz condition:

$$
\|F(\boldsymbol u)-F(\boldsymbol w)\|\le\hat L\|\boldsymbol u-\boldsymbol w\|\tag{2.15}
$$


> for all $`\boldsymbol u,\boldsymbol w`$. Generally speaking this could be taken to hold in a neighborhood of the solution where all approximate solutions for $`h\lt \bar h`$ are assumed to lie. With a bit of effort, it is then possible to demonstrate the stability condition for the numerical method (see Exercise 4).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletStability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。 | [EXTRA] |

[EXTRA] 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐字核对印刷68页末段、式(2.15)和69页续段，一致。全空间力F的Lipschitz条件、正质量、L≥0、δ>0均在前提；C在h之前存在，故同一C适用于[0,δ]全部步长及全部相点z,w。Q是有限维坐标空间的上确界范数，Z是乘积最大范数；verlet确为含逆质量的速度Verlet位置/动量更新。更新为恒等映射加O(h)的全局Lipschitz扰动，有限步长窗吸收h²、h³项，因子1+hC合理。采用全空间版本而非局部邻域版本已明确披露，且h=0结论为恒等式。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletStability`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L580)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-FirstIntegral · definition · 印刷p.70 / PDFp.92

### 2. 原文陈述

> Recall that the condition for a given function $`I:\mathbb R^m\to\mathbb R`$ to be a first integral is that

$$
\nabla I(\boldsymbol z)\cdot f(\boldsymbol z)=\sum_{j=1}^m\frac{\partial I}{\partial z_j}(\boldsymbol z)f_j(\boldsymbol z)\equiv 0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  IsOpen D ∧ DifferentiableOn ℝ I D ∧ ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_firstIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。 | [EXTRA] |

[EXTRA] [EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原句、梯度点积、求和指标j=1,…,m及恒零号逐字一致。n为任意自然数，I:Q n→ℝ、f:Q n→Q n，D为开放域。谓词同时要求IsOpen D、I在D可微，以及每个z∈D的真实导数作用于f(z)为0；在开放域可微保证fderiv是经典导数，与原坐标求和相同。开放域是原文下一句明许的范围；未把不可微点总化导数为零误当条件。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_firstIntegral`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L590)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralPreserved · unnumbered_claim · 印刷p.70 / PDFp.92

### 2. 原文陈述

> It is important in this definition that this is an equivalence that holds everywhere (or at least in some open set in $`\mathbb R^m`$), so the statement is not just that $`I(\boldsymbol z(t))=I(\boldsymbol z(0))`$ for some particular trajectory, but, moreover, $`I`$ is conserved for all nearby initial conditions. The flow map preserves the first integral, thus $`I(\mathcal F_t(\boldsymbol z))\equiv I(\boldsymbol z)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem firstIntegralPreserved :
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a) := by
  intro n I f D γ a b hab hI hD hfirst hγD hγ
  have hd : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => I (γ s)) 0 (Icc a b) t := by
    intro t ht
    have hIt : DifferentiableAt ℝ I (γ t) :=
      (hI (γ t) (hγD ht)).differentiableAt (hD.mem_nhds (hγD ht))
    have hc : HasDerivWithinAt (fun s => I (γ s))
        ((fderiv ℝ I (γ t)) (f (γ t))) (Icc a b) t :=
      hIt.hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
    rw [hfirst (γ t) (hγD ht)] at hc
    exact hc
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.firstIntegralPreserved` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。 | [EXTRA] |

[EXTRA] 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷70页从It is important到I(F\_t(z))≡I(z)的原文、括号及所有初始条件措辞一致。量化任意n,I,f,D,γ,a,b，要求a≤b、I可微、D开放、firstIntegral逐点为零、γ在整个闭窗留域并满足真实ODE。结论对全部t∈[a,b]为I(γ(t))=I(γ(a))。任意γ的全称量化覆盖任意初始条件；a替代0为时间平移推广。a=b退化窗结论仍正确，端点没有遗漏。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.firstIntegralPreserved`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L595)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-EnergyPreserved · unnumbered_claim · 印刷p.70 / PDFp.92

### 2. 原文陈述

> For example, in a Hamiltonian system, the flow map conserves the energy:

$$
H\circ\mathcal F_t=H.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyPreserved (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.energyPreserved` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。 | [EXTRA] |

[EXTRA] 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Ch02\_deps.txt:33 的 SymplecticCoordinates Nc=(Fin Nc⊕Fin Nc)→ℝ；:41 的 textbookJ=fromBlocks 0 1 (-1) 0；:1921 的 textbookHamiltonianVectorField H z=J*ᵥ(fun i=>(fderiv ℝ H z)(Pi.single i 1))。依次为 (q,p) 坐标，基向量导数为 (H\_q,H\_p)，场为 (H\_p,−H\_q)，并非依名称推测。故 dH(场)=Σ(H\_q H\_p−H\_p H\_q)=0。任意 H、γ、τ，在轨道全部窗内点 H 可微及 γ 满足该场的实际闭窗ODE关系后，全部 t 得 H(γ t)=H(γ 0)，完整表达 H∘流=H。[EXTRA] 轨道可微和实际解是合理资格，未假定能量守恒；τ<0 空窗，τ=0 平凡。已读取 :2728 起复用定理的同一签名及链式求导论证。Ch02 正文调用库定理、无直接 sorry；不据此认证证明工程。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.energyPreserved`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L615)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-AngularMomentum · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> There may, in specific instances, be additional first integrals present. For example, in a planar 2-body system in central forces, the angular momentum $`xp_y-yp_x=l`$ is a conserved quantity, thus $`l\circ\mathcal F_t=l`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem centralAngularMomentum :
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.centralAngularMomentum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。 | [EXTRA] |

[EXTRA] 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已重读实际声明。右结合 ℝ×ℝ×ℝ×ℝ 为 (x,y,p\_x,p\_y)，全部投影和导数元组展开为 x′=p\_x、y′=p\_y、p\_x′=ρ(x²+y²)x、p\_y′=ρ(x²+y²)y。任意ρ、实际γ及 a<b，全部闭窗时间守恒 xp\_y−yp\_x；导数为 p\_x p\_y+xρy−p\_y p\_x−yρx=0。中心力相对坐标和单位约化质量是合理模型资格，固定正约化质量版本同样抵消动量交叉项，可通过单位选择对应；a<b 排除仅需平凡处理的退化窗。未宣称存在解，故不必为给定的实际可微解另加ρ正则性。[EXTRA] 合理，无 ERRATUM 标记。正文有直接 sorry，证明未完成与签名 PASS 分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.centralAngularMomentum`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L625)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

