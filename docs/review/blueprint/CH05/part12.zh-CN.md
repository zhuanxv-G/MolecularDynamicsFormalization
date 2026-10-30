[上一部分](part11.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / 下一部分：无

## 1. MD-5.6-ForwardNormDivergence · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> and we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $`(q_0,p_0)=(0,0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardNormDivergence : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
  intro h hh z hz
  have hs : 0 < (z 0)^2+(z 1)^2 := by
    have hn : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    rw [EuclideanSpace.norm_sq_eq] at hn
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hn
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
      (1+h^2)^k*((z 0)^2+(z 1)^2) := by
    rw [EuclideanSpace.norm_sq_eq]
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
  apply tendsto_atTop.2
  intro b
  filter_upwards [ht.eventually (eventually_ge_atTop ((max b 0)^2+1))] with k hk
  rw [←he] at hk
  nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),le_max_left b 0,le_max_right b 0]



/-- 修正版，对应原文 MD-5.6-ForwardNormDivergence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem forwardNormDivergence_corrected : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
  intro h hh z hz
  have hs : 0 < (z 0)^2+(z 1)^2 := by
    have hn : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    rw [EuclideanSpace.norm_sq_eq] at hn
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hn
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
      (1+h^2)^k*((z 0)^2+(z 1)^2) := by
    rw [EuclideanSpace.norm_sq_eq]
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
  apply tendsto_atTop.2
  intro b
  filter_upwards [ht.eventually (eventually_ge_atTop ((max b 0)^2+1))] with k hk
  rw [←he] at hk
  nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),le_max_left b 0,le_max_right b 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardNormDivergence`；`MD.Ch05.forwardNormDivergence_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；C复审规则：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、内积、梯度、导数、Hausdorff测度、volume、Bochner integral、withDensity、restrict、ContDiff、HasCompactSupport、Tendsto 等均直接按其标准数学含义采信；未在依赖摘录中寻找Mathlib定义体，也不以缺少这些定义体为理由判NEEDS\_HUMAN。实际读取的三个文件已重新计算SHA256，并与上一轮附件哈希逐一相等；不使用其他旧版Ch0x.lean或source.json。项目自定义项已按依赖的ReviewDefinitions文件和当前附件MD.Ch05本地定义展开核对。 依赖展开依据：Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean，E n=EuclideanSpace ℝ (Fin n)，采用欧氏范数；不是坐标上确界范数。 Lean只给非零步长、非零初值下欧氏范数趋于+∞，既没有特征值位于单位圆外的结论，也没有原文“两分量趋于无穷”的结论。[EXTRA]h≠0必要，非原点对应原文例外；修正为范数发散在数学上正确，但不能作为原句全部结论的忠实形式化。没有显式ERRATUM标签，必须明确登记原书疑误。此定理正文未见sorry，但证明存在不消除语义偏差。 复审仍判FAIL的原因是与原书结论的绑定差异，而非Mathlib范数或Tendsto含义不明。[EXTRA]已明确承认是独立修正，修正合理不等于原句语义相同。

### 7. 状态与证明位置

self-contained；`MD.Ch05.forwardNormDivergence`：已证；`MD.Ch05.forwardNormDivergence_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2647)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-WeakStationary · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the only solution, in the weak sense, of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$ is the point distribution $`\delta[q]\delta[p]`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakStationaryModel {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  weakStationary f μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 从弱方程引用抽出的辅助技术定义；不是原书另立定义，唯一性结论由MD-5.6-ForwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakStationaryModel` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 仅弱PDE技术谓词，实际使用Blueprint修正后的C∞测试空间；原唯一概率断言由MD-5.6-ForwardWeakStationary承担。 | [EXTRA] |

[EXTRA] [EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。；[EXTRA] 仅弱PDE技术谓词，实际使用Blueprint修正后的C∞测试空间；原唯一概率断言由MD-5.6-ForwardWeakStationary承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数、向量场f及任意正测度μ，weakStationaryModel展开为对每个C∞紧支测试函数φ，Lie导数Dφ(f)可积且其μ积分为0；Lie使用fderiv的正确方向作用。这是弱散度方程的技术定义，允许Dirac且不强制绝对连续或概率归一化。定义本身不宣称唯一稳态，未把离散map不变性偷换为弱PDE；原书唯一概率结论已明确分流至另一source\_id，此次不核验未给出的声明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakStationaryModel`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2691)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-WeakAttractor · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> this solution is not “asymptotically stable.”

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  IsProbabilityMeasure μ ∧ ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakAttractor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。 | [EXTRA] |

[EXTRA] [EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅弱概率局部吸引的辅助技术定义；原负吸引性断言由MD-5.6-ForwardWeakStationary承担，不把定义本身当否定结论。；[EXTRA] 目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。

### 6. 审计结论

本轮修复：目标测度资格直接加入定义体IsProbabilityMeasure μ∧…，排除μ=0下空概率邻域的真空成立；其余有限测试族、共同ε和概率ν收敛量词不变。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；有限族有界连续ψ、共同ε>0、对邻域内所有概率ν及所有有界连续φ的t→+∞收敛，正确编码了局部弱吸引的收敛部分。但是目标μ的域是所有Measure，签名既没有IsProbabilityMeasure μ参数，也没有将其作为合取条件。因此可选择不含任何概率测度的所谓邻域而令全称命题真空成立，与[EXTRA]“概率弱拓扑中某邻域”的承诺不符。该缺陷独立于原书否定吸引的断言；辅助定义分流不能补足目标对象的域。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakAttractor`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2698)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerLogField · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the only solution, in the weak sense, of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$ is the point distribution $`\delta[q]\delta[p]`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerLogField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。 | [EXTRA] |

[EXTRA] [EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅单位振子h>0时新增的精确对数场技术模型（h=0总延拓不用作物理解释）；实际一步/ODE对应由MD-5.6-EulerLogCorrespondence，唯一概率稳态由MD-5.6-ForwardWeakStationary承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义在Bool、所有实h和二维z上：a=±log(1+h²)/(2h)，b=arctan(h)/h，场为(aq+bp,ap−bq)。h>0时forward径向增长、backward径向衰减，旋转方向均为(q̇,ṗ)=(p,−q)方向；对应矩阵分别I+hJ及(I−hJ)⁻¹的主实对数除以h。h=0的Lean总化值为零场，不是物理极限Jz，[EXTRA]明确排除该解释，故不判失败。定义未证明一步对应、ODE资格或一般BEA级数收敛，范围已披露。

### 7. 状态与证明位置

self-contained；`MD.Ch05.eulerLogField`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2709)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerLogFlow · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerLogFlow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。 | [EXTRA] |

[EXTRA] [EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对Bool、实h/t和二维z，返回exp(at)倍角度bt的顺时针旋转；在t=0恒为z，对t求导给出所列对数场，指数和旋转均满足时间加法。h>0时t=h的倍率为sqrt(1+h²)或其倒数，角为arctan h，分别得到前/后Euler一步。h=0时为恒等流，属已披露的总延拓。该技术定义不等同于任意数值方法有限截断的精确流，原文近似措辞及跨条对应义务均被保留。

### 7. 状态与证明位置

self-contained；`MD.Ch05.eulerLogFlow`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2717)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerLogCorrespondence · unnumbered_claim · 印刷p.206–207 / PDFp.227–228

### 2. 原文陈述

> Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by $`\frac{\partial\rho}{\partial t}=\mathcal L_{\widetilde f}^{\dagger}\rho\overset{\mathrm{def}}{\equiv}\mathcal L_f^{\dagger}\rho+h^r\mathcal L_{f_{(r)}}^{\dagger}\rho`$. […] Applying Forward Euler to the harmonic oscillator, we have $`q_{n+1}=q_n+hp_n`$, $`p_{n+1}=p_n-hq_n`$. […] As an alternative, consider the Backward Euler method: $`q_{n+1}=q_n+hp_{n+1}`$, $`p_{n+1}=p_n-hq_{n+1}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerLogCorrespondence : ∀ h : ℝ,0 < h →
  (∀ z,eulerLogFlow false h h z=MolecularDynamics.Chapter05Review.forwardEuler h z ∧
    eulerLogFlow true h h z=MolecularDynamics.Chapter05Review.backwardEuler h z) ∧
  (∀ backward z t,HasDerivAt (fun s => eulerLogFlow backward h s z)
    (eulerLogField backward h (eulerLogFlow backward h t z)) t) := by
  intro h hh
  have hn : h ≠ 0 := ne_of_gt hh
  have hp : 0 < 1+h^2 := by positivity
  have hs : Real.sqrt (1+h^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hp)
  have he : Real.exp (Real.log (1+h^2)/2)=Real.sqrt (1+h^2) := by
    have he2 : (Real.exp (Real.log (1+h^2)/2))^2=1+h^2 := by
      rw [pow_two,←Real.exp_add]
      convert Real.exp_log hp using 1 <;> congr 1 <;> ring
    nlinarith [Real.exp_pos (Real.log (1+h^2)/2),Real.sqrt_nonneg (1+h^2),Real.sq_sqrt hp.le]
  have hbh : Real.arctan h/h*h=Real.arctan h := by field_simp [hn]
  have haf : (Real.log (1+h^2)/(2*h))*h=Real.log (1+h^2)/2 := by field_simp [hn] <;> ring
  have hab : (-(Real.log (1+h^2))/(2*h))*h= -(Real.log (1+h^2)/2) := by field_simp [hn] <;> ring
  constructor
  · intro z
    constructor <;> ext i <;> fin_cases i <;>
      simp [eulerLogFlow,MolecularDynamics.Chapter05Review.forwardEuler,
        MolecularDynamics.Chapter05Review.backwardEuler,hbh,haf,hab,Real.exp_neg,
        he,Real.cos_arctan,Real.sin_arctan]
    all_goals field_simp [hs] <;> simp only [Real.sq_sqrt hp.le] <;> ring
  · intro backward z t
    let a := (if backward then (-1 : ℝ) else 1)*Real.log (1+h^2)/(2*h)
    let b := Real.arctan h/h
    have ha := ((hasDerivAt_id t).const_mul a).exp
    have hc := ((hasDerivAt_id t).const_mul b).cos
    have hs := ((hasDerivAt_id t).const_mul b).sin
    have hq := ha.mul ((hc.const_mul (z 0)).add (hs.const_mul (z 1)))
    have hp := ha.mul ((hc.const_mul (z 1)).sub (hs.const_mul (z 0)))
    have hv : HasDerivAt (fun s : ℝ => ![Real.exp (a*s)*(z 0*Real.cos (b*s)+z 1*Real.sin (b*s)),
        Real.exp (a*s)*(z 1*Real.cos (b*s)-z 0*Real.sin (b*s))])
        ![a*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))+
            b*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t))),
          a*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t)))-
            b*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))] t := by
      apply hasDerivAt_pi.mpr
      intro i
      fin_cases i
      · convert hq using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
      · convert hp using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
    convert (PiLp.hasFDerivAt_toLp (𝕜:=ℝ) 2 _).comp_hasDerivAt t hv using 1
    · funext s
      ext i
      fin_cases i <;> simp [eulerLogFlow,a,b]
    · ext i
      fin_cases i <;> simp [eulerLogField,eulerLogFlow,a,b] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerLogCorrespondence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。 | [EXTRA] |
| 尚未覆盖的结论 | 原文密度Liouville演化 | 覆盖缺口，未声称已证明 |
| 尚未覆盖的结论 | 密度侧伴随算子及生成元线性分解 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。；[EXTRA] Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。

### 6. 审计结论

本轮修复：Euler两个离散更新与连续对数向量场的精确单步插值，以及全时间线性ODE；仅这两个子句由当前Lean覆盖。 原引文完整保留，密度及伴随分解另列覆盖缺口，不宣称这些结论已证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；两Euler更新和全时间线性ODE部分的对象、量词、正步长前提与计算均正确；对数场是合理的精确单步插值。整条引文还明确包含密度Liouville演化及生成元分解，当前签名未表达该部分，故按完整结论审校FAIL。此结论与证明是否含sorry无关。

### 7. 状态与证明位置

self-contained；`MD.Ch05.eulerLogCorrespondence`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2726)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardWeakStationary · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> To put it another way, the only solution, in the weak sense, of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$ is the point distribution $`\delta[q]\delta[p]`$, and this solution is not “asymptotically stable.”

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField false h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  ¬weakAttractor (eulerLogFlow false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardWeakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。 | [EXTRA] |

[EXTRA] [EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全体对象、域、量词、0<h前提、三项完整结论和[EXTRA]一致。以概率分布解读原书的distribution符合本节密度语境；不宣称所有未归一化或任意Schwartz分布的唯一性。签名正确，sorry不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch05.forwardWeakStationary`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2778)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardWeakStationary · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> The only (distributional) solution of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$ is again $`\delta[q]\delta[p]`$, which in this case is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem backwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField true h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  weakAttractor (eulerLogFlow true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardWeakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。 | [EXTRA] |

[EXTRA] [EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；除原文JSON的伴随上标转写外，签名完整、正确：所有正h，实际Backward Euler对数场及流，唯一概率弱稳态和弱吸引性均匹配。sorry不作FAIL依据。

### 7. 状态与证明位置

incomplete；`MD.Ch05.backwardWeakStationary`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2787)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticWeakStationary · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> This implies that a density which is a function of $`\widetilde H_h`$ will remain invariant under the associated Liouville equation. There are many solutions of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$, none of which is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticWeakStationary : ∀ h : ℝ,|h| < 2 →
  let f := fun z : MolecularDynamics.Chapter05Review.E 2 => WithLp.toLp 2
    ![(gradient (symplecticEulerModifiedHamiltonian h) z) 1,-(gradient (symplecticEulerModifiedHamiltonian h) z) 0]
  ∀ Φ : ℝ → MolecularDynamics.Chapter05Review.E 2 → MolecularDynamics.Chapter05Review.E 2,MolecularDynamics.Chapter05Review.flow f Φ →
    (∀ r : ℝ → ℝ,MolecularDynamics.Chapter05Review.probabilityDensity (fun z => r (symplecticEulerModifiedHamiltonian h z)) →
      weakStationary f (MolecularDynamics.Chapter05Review.densityMeasure (fun z => r (symplecticEulerModifiedHamiltonian h z)))) ∧
    (∃ μ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ ∧ IsProbabilityMeasure ν ∧
      μ ≠ ν ∧ weakStationary f μ ∧ weakStationary f ν) ∧
    (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → weakStationary f μ → ¬weakAttractor Φ μ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticWeakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]稳定区\|h\|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 弱稳态接口使用前条实际一步对应的主对数modified Hamiltonian及其梯度场；函数能量密度、多种概率稳态和非吸引结论齐全，不把未按时间缩放的不变量场冒充数值步的时间h模型。 | [EXTRA] |

[EXTRA] [EXTRA]稳定区|h|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。；[EXTRA] 弱稳态接口使用前条实际一步对应的主对数modified Hamiltonian及其梯度场；函数能量密度、多种概率稳态和非吸引结论齐全，不把未按时间缩放的不变量场冒充数值步的时间h模型。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；稳定区内主对数Hamiltonian、梯度场、全时间真实流条件均正确。能量函数概率密度的弱稳态、至少两种不同概率稳态及全部概率稳态无弱吸引性三项完整。只需修正原文JSON的伴随上标；无需因sorry判FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticWeakStationary`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2797)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

