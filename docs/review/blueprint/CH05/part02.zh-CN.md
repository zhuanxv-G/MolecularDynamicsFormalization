[上一部分](part01.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-5.2.1-DomainL2 · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The set of functions from $`\mathcal D\subset\mathbb R^m`$ to $`\mathbb R`$ which satisfy (5.3) is referred to as the space $`L^2(\mathcal D)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)



/-- 修正版，对应原文 MD-5.2.1-DomainL2。改动：明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。 -/
```

独立修正版：

```lean
@[reducible] def domainL2_corrected (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2`；`MD.Ch05.domainL2_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。 | [EXTRA] |

[EXTRA] [EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。；[ERRATUM?] 明确采用Lebesgue可测函数按几乎处处相等取商的Lp空间；原生函数集合不直接宣称为Hilbert空间。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；domainL2对任意n和D采用Lp ℝ 2 (volume.restrict D)，是可测平方可积函数的几乎处处等价类，数学上是合理的标准L²实现。[EXTRA]已披露AE商，然而原句字面是原生函数集合；这是原书的语义省略，不能把商空间静默当作逐字原文。修正方案合理，但忠实字面版与标准解释仍需人工确认。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2`：定义；`MD.Ch05.domainL2_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L201)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Norm · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> we define the $`L^2(\mathcal D)`$ norm by $`\|\phi\|_{L^2(\mathcal D)}\stackrel{\rm def}{=}[\int_{\mathcal D}\phi^2(z)\,d\omega]^{1/2}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖



/-- 修正版，对应原文 MD-5.2.1-L2Norm。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def domainL2Norm_corrected {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Norm`；`MD.Ch05.domainL2Norm_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；domainL2Norm的g属于先前标准Lp实现的domainL2 n D，定义为其真实范数。按用户允许直接采信Mathlib标准含义，该实L²范数正是积分平方的平方根；不需要额外假设g的可积性或另造范数。所给定义没有独立积分公式定理，不能据此宣称该独立接口已经提供；这不改变定义的数学签名正确性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Norm`：定义；`MD.Ch05.domainL2Norm_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L210)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Inner · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> for any $`\phi,\psi\in L^2(D)`$, the inner product is defined by $`\langle\phi,\psi\rangle_{L^2(D)}\stackrel{\rm def}{=}\int_D\phi(z)\psi(z)\,d\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Inner` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）的 ∀φ,ψ∈L²(D)，⟨φ,ψ⟩=∫D φψ，对应 Ch05.lean:177–178 的 domainL2Inner f g := ∫ z in D, f z*g z。展开 domainL2，f、g 是同一限制测度下的实 L² 类；标准 Hölder/Cauchy–Schwarz 保证乘积可积，积分与代表选择无关。标准 L2.inner\_def 与实数内积的乘法表达表明它恰为真实 L² 内积。对象、全部输入及积分域一致，没有遗漏前提或加入额外前提。定义无 sorry，无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Inner`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L218)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2NormSquare · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> Thus $`\|\phi\|_{L^2(\mathcal D)}^2=\langle\phi,\phi\rangle_{L^2(\mathcal D)}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g := by
  intro n D g
  change ‖g‖^2=∫ z in D,g z*g z
  simpa only [MeasureTheory.L2.inner_def,Real.inner_apply] using (real_inner_self_eq_norm_sq g).symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2NormSquare` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对所有n,D及g:domainL2 n D断言domainL2Norm g²=domainL2Inner g g。摘录的inner确为∫_D g(z)g(z)，norm为Lp范数，实值域、平方与自内积的顺序正确；标准Lp资格已包含平方可积性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2NormSquare`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L222)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2Complete · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> This is a real Hilbert space or complete inner product space in which, for any $`\phi,\psi\in L^2(\mathcal D)`$, the inner product is defined by $`\langle\phi,\psi\rangle_{L^2(\mathcal D)}\stackrel{\rm def}{=}\int_{\mathcal D}\phi(z)\psi(z)\,d\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu



/-- 修正版，对应原文 MD-5.2.1-L2Complete。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem domainL2Complete_corrected : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2Complete`；`MD.Ch05.domainL2Complete_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；在domainL2采用标准AE商Lp解释下，∀n,D及所有Cauchy序列u存在同空间极限v的声明正确，等价于该度量空间完备性；Lp的实内积结构与积分自洽。但原书将前述原生函数集合直接称为Hilbert空间，正定性存在AE资格省略。[EXTRA]披露了修正；不能把修正版的正确性等同于原书字面正确性。所引内积积分定义不在本条主声明中，项目在条目7摘录了domainL2Inner，可作配套定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2Complete`：已证；`MD.Ch05.domainL2Complete_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L231)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-L2SymmetricBilinear · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The inner product is a symmetric, bilinear operation: if $`\alpha,\beta`$ are real scalars and $`f,g,h\in L^2(D)`$, then $`\langle\alpha f+\beta g,h\rangle=\alpha\langle f,h\rangle+\beta\langle g,h\rangle`$, and $`\langle f,g\rangle=\langle g,f\rangle`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem domainL2SymmetricBilinear : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f := by
  intro n D f g h a b
  have hi : ∀ u v : domainL2 n D,domainL2Inner u v=inner ℝ u v := by
    intro u v
    simp only [domainL2Inner,MeasureTheory.L2.inner_def,Real.inner_apply]
  simp only [hi,inner_add_left,inner_smul_left,real_inner_comm]
  simp
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.domainL2SymmetricBilinear` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）的线性公式和对称公式，在 Ch05.lean:195–203 由合取同时保留：inner(a•f+b•g,h)=a*inner(f,h)+b*inner(g,h)，以及 inner(f,g)=inner(g,f)。n、D、f、g、h、a、b 均任意，全称量词中独立标量的位置换序无语义变化。展开 domainL2Inner 为乘积积分、domainL2 为真实 L² 类后，标准 Lp 的加法/实数标量乘法与代表元的逐点运算 a.e. 一致，全部乘积可积。对称性加左线性也蕴含右线性，故原文“symmetric, bilinear”完整保留。无新增前提。证明无 sorry；不将此事实与签名语义混淆，本轮未编译。无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.domainL2SymmetricBilinear`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L245)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-CompactL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> The space $`L^2(\mathbb R^m)`$ includes for example the continuous functions with compact (closed, bounded) support, where the support of a function $`f`$ is the closure of the set of arguments for which the function is nonzero and is denoted $`\operatorname{supp}f`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compactL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume := by
  intro n g hg hs
  exact hg.memLp_of_hasCompactSupport hs
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.compactL2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.204（印刷 p.183）称欧氏空间上的连续紧支持实函数属于 L²，且 support 是非零集合的闭包。Ch05.lean:206–209 对任意 n 和 g:E n→ℝ，以 Continuous g 与 HasCompactSupport g 为前提，结论 MemLp g 2 volume。按标准含义 HasCompactSupport g 是 tsupport g 的紧性，tsupport=closure(Function.support g)，Function.support 是非零集合；因此与原书闭支持定义一致。在有限维欧氏空间中紧等价于闭且有界；连续紧支持函数有界且支集的 Lebesgue 测度有限，确为平方可积。MemLp 同时提供可测资格，正好表达原文包含关系，无须强行构造商类作为结论。对象、全部假设及结论一致，无额外假设。证明无 sorry，本轮未编译；无 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.compactL2`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L256)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-DensityAverageOn · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Given a density $`\rho`$, we may identify a collection of functions $`g`$ for which the integral with respect to $`\rho`$ is bounded, i.e. for which we can define the inner product $`\langle g,\rho\rangle=\int_Dg(z)\rho(z)\,d\omega`$, and thus we can define

$$
\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega.
$$


> We term this the spatial average of the function $`g`$ with respect to the probability measure associated to $`\rho`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.densityAverageOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依据用户补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义，不要求在项目依赖摘录中寻找 Mathlib 定义体。项目自定义 E 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 分段展开为 EuclideanSpace ℝ (Fin n)；本批 MD.Ch05 的自定义定义按哈希绑定的附件声明展开。PDF p.205（印刷 p.184）的空间平均定义，对应 Ch05.lean:212–213 的 densityAverageOn D ρ g := (∫D gρ)/(∫Dρ)，其中 E n 展开为欧氏 ℝⁿ。原文第一种写法 (∫Dρ)⁻¹⟨g,ρ⟩ 在本段将 ⟨g,ρ⟩定义为乘积积分，故与该比值相同；令 ρ̂(z)=ρ(z)/(∫Dρ)，Bochner 积分对常数因子的标准性质给出同一表达式 ∫D gρ̂，完整保留展示公式的两种表达，不需要要求 g、ρ 都属于 L²。原文的概率解释适用于非负可积密度、正的有限质量以及可积乘积；原 JSON 的 context\_notation 已明确这个解释范围。该 Lean 声明是比值的总化定义，并没有声称所有任意输入都生成概率测度；对零质量、负密度或不可积输入也给一个总化值不会构成对原文适用域内公式的反例，故撤回上一轮将这些输入作为 FAIL 反例的判断。Bochner 积分不可积时取0以及实数除法的总化均按标准库含义采信，未把这些扩展值解释为概率期望。项目依赖中 density（Measurable、非负、Integrable）、probabilityDensity（另要求质量1）、densityMeasure（volume.withDensity (ENNReal.ofReal∘ρ)）的定义可核对上述概率解释，但它们并不是本声明隐藏调用的前提。定义无需把所有适用域条件作为类型参数，也不额外冒称已经证明概率测度构造定理。定义无 sorry、无 [EXTRA] 或 [ERRATUM?] 标记。

### 7. 状态与证明位置

self-contained；`MD.Ch05.densityAverageOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L262)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-ClosedSupport · definition · 印刷p.183 / PDFp.204

### 2. 原文陈述

> the support of a function $`f`$ is the closure of the set of arguments for which the function is nonzero and is denoted $`\operatorname{supp}f`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def closedSupport {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) : Set (MolecularDynamics.Chapter05Review.E n) := tsupport f
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.closedSupport` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则直接采信 Mathlib 标准含义。已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开项目别名 E n := EuclideanSpace ℝ (Fin n)，对象为欧氏 ℝⁿ 上的实函数。附件 Blueprint/Ch05.lean 中 MD.Ch05.closedSupport f := tsupport f，展开标准含义就是 closure (Function.support f)=closure {z | f z ≠ 0}，与 PDF204/印刷183 正文支集定义完全一致。任意 n、任意 f，不添加连续性或紧性假设，不将支集误作未闭合的非零点集；完整返回该集合。本条没有 [EXTRA] 或 [ERRATUM?]。该声明是定义，无 sorry；PASS 仅评价定义语义，不声称完成 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch05.closedSupport`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L266)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-GaussianL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $`L^2(\mathbb R^m)`$ also includes many other types of functions important in molecular modelling, for example the multivariate Gaussian $`\exp(-\sum_{i=1}^m\alpha_i x_i^2)`$, where $`\alpha_i\gt 0,i=1,2,\ldots,m`$ are coefficients; such a function goes rapidly to zero as any $`x_i\to\infty`$, so the improper integral converges.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume := by
  intro n a ha
  have hc : Continuous (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) := by fun_prop
  rw [memLp_two_iff_integrable_sq hc.aestronglyMeasurable]
  have hi := GaussianFourier.integrable_cexp_neg_sum_mul_add (ι := Fin n) (b := fun i => ((2*a i : ℝ) : ℂ))
    (by intro i; simpa using (mul_pos (by norm_num : (0 : ℝ)<2) (ha i))) (fun _ => (0 : ℂ))
  have hr : Integrable (fun v : Fin n → ℝ => Real.exp (-(∑ i,(2*a i)*(v i)^2))) volume := by
    have hreal := hi.re
    change Integrable (fun v : Fin n → ℝ => (Complex.exp (-(∑ i,((2*a i : ℝ) : ℂ)*(v i : ℂ)^2)+(∑ i,(0 : ℂ)*(v i : ℂ)))).re) volume at hreal
    simpa only [zero_mul,Finset.sum_const_zero,add_zero,← Complex.ofReal_pow,← Complex.ofReal_mul,
      ← Complex.ofReal_sum,← Complex.ofReal_neg,Complex.exp_ofReal_re] using hreal
  have he : Integrable (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,(2*a i)*(z i)^2))) volume := by
    rw [← (PiLp.volume_preserving_toLp (Fin n)).integrable_comp_emb (MeasurableEquiv.toLp 2 _).measurableEmbedding]
    exact hr
  convert he using 1
  funext z
  rw [← Real.exp_nat_mul]
  congr 1
  simp only [mul_assoc,← Finset.mul_sum]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianL2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则采信标准 MemLp、EuclideanSpace 和 volume。已在 Ch05\_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)，所以体积为完整 ℝⁿ 上标准 Lebesgue 测度。签名先量化任意有限维 n、所有系数 a : Fin n → ℝ，再要求每个 a i > 0；结论 MemLp (exp(-∑ i,a i*(z i)^2)) 2 volume 恰为该实 Gaussian 可测且平方可积。与 PDF204/印刷183 脚注2所称任意正系数多元 Gaussian 属于 L²(ℝᵐ) 一致，未改为等系数径向函数、截断域或预先假设可积。原文“goes rapidly to zero”是可积性的解释，未单列为具有指定速率的极限定理；可测性由连续性自然满足，平方后仍为系数 2a i > 0 的 Gaussian，其平方积分为有限乘积 ∏ᵢ sqrt(π/(2a i))。允许 n=0 是无害扩展，空乘积为1。本条无 [EXTRA]/[ERRATUM?]。附件本条有证明正文且未含 sorry；语义 PASS 与编译及证明核验分开。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianL2`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L269)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-FiniteJumpL2 · unnumbered_claim · 印刷p.183 / PDFp.204

### 2. 原文陈述

> $`L^2(\mathbb R^m)`$ also includes the compactly supported functions with finite “jump discontinuities” at a finite number of locations.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem finiteJumpL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ) (S : Set (MolecularDynamics.Chapter05Review.E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume := by
  intro n g S hS hs hc hb
  have hm : Measurable g := hc.measurable_of_countable_compl (by simpa only [compl_compl] using hS.countable)
  have hl : ∀ z,∃ C > 0,∀ᶠ x in 𝓝 z,|g x| ≤ C := by
    intro z
    by_cases hz : z ∈ S
    · obtain ⟨C,hC,U,hU,hbU⟩ := hb z hz
      exact ⟨C,hC,Filter.mem_of_superset hU hbU⟩
    · have hcont := hc.continuousAt (hS.isClosed.isOpen_compl.mem_nhds hz)
      refine ⟨|g z|+1,by positivity,?_⟩
      exact (hcont.abs.eventually_lt_const (lt_add_one _)).mono (fun _ h => h.le)
  have hbound : ∃ C > 0,∀ x ∈ tsupport g,|g x| ≤ C := by
    apply hs.induction_on (p := fun A => ∃ C > 0,∀ x ∈ A,|g x| ≤ C)
    · exact ⟨1,by norm_num,by simp⟩
    · intro A B hAB hB
      obtain ⟨C,hC,hCB⟩ := hB
      exact ⟨C,hC,fun x hx => hCB x (hAB hx)⟩
    · intro A B hA hB
      obtain ⟨C,hC,hCA⟩ := hA
      obtain ⟨D,hD,hDB⟩ := hB
      refine ⟨max C D,lt_of_lt_of_le hC (le_max_left _ _),?_⟩
      intro x hx
      rcases hx with hx|hx
      · exact (hCA x hx).trans (le_max_left _ _)
      · exact (hDB x hx).trans (le_max_right _ _)
    · intro z hz
      obtain ⟨C,hC,hCL⟩ := hl z
      exact ⟨{x | |g x| ≤ C},mem_nhdsWithin_of_mem_nhds hCL,C,hC,fun _ hx => hx⟩
  obtain ⟨C,hC,hBC⟩ := hbound
  apply hs.memLp_of_bound hm.aestronglyMeasurable C
  filter_upwards [] with x
  by_cases hx : x ∈ tsupport g
  · simpa only [Real.norm_eq_abs] using hBC x hx
  · rw [image_eq_zero_of_notMem_tsupport hx,norm_zero]
    exact hC.le
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.finiteJumpL2` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。 | [EXTRA] |

[EXTRA] [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已从 Ch05\_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)；Mathlib 的 HasCompactSupport 表示 closure {x | g x ≠ 0} 紧，MemLp g 2 volume 表示对标准 Lebesgue 测度平方可积。签名依次量化 n、实函数 g、异常集 S，假设 S 有限、g 紧支、g 在 S 的补集连续，并在每个 z∈S 量化各自的 C>0 和邻域 U，使 U 中所有 |g x|≤C；结论只有完整 L² 归属，与 PDF204/印刷183 脚注2的结论一致。[EXTRA] 合理且不循环：有限跳跃具有有限邻域界，该条件还允许较一般的有界振荡，并不把有限跳跃当作精确定义的等价命题。它是对原文有限跳跃函数的充分资格，不排除原文中只有有限个跳跃位置的实函数。有限异常集外连续保证可测；各点局部有界和支集紧性给出统一有限界，紧集的 Lebesgue 测度有限，故平方可积。若仅要求紧支和有限异常点而省掉邻域控制，g(x)=1/x（0<x<1）、其余处为0将不平方可积；它不满足有限跳跃条件，也不是本签名反例。无 [ERRATUM?]，不修正原书。本条证明正文无 sorry；PASS 是签名语义判定，未运行编译。

### 7. 状态与证明位置

self-contained；`MD.Ch05.finiteJumpL2`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L293)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.1-NormalizedAverageFormula · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $`\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalizedAverageFormula : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x))) := by
  intro n D ρ g
  simp only [densityAverageOn,← mul_div_assoc,integral_div]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalizedAverageFormula` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已从 Ch05\_deps.txt 的 ReviewDefinitions.lean 段展开 E n := EuclideanSpace ℝ (Fin n)。本条实际引用的项目定义是附件 Blueprint/Ch05.lean 中本地 MD.Ch05.densityAverageOn D ρ g := (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)，已读取并展开；它不是依赖摘录中定义在全空间的 MolecularDynamics.Chapter05Review.densityAverage。令 c=∫ x in D,ρ x，右端为 ∫ z in D,g z*(ρ z/c)，以受限 Lebesgue 测度积分。先量化 n、任意 D、ρ、g 后给出等式，保留 PDF205/印刷184 的平均积分比值和归一化密度 ρ̂=ρ/c 两种表示。按标准 Bochner 积分及实数除法的总化含义，常数因子可移出积分：c≠0 时可积性在乘以 c⁻¹ 后等价，不可积时两积分都按标准约定取0；c=0 时 ρ/c 恒0，等式两端皆0。因此无需额外密度、可积性或非零分母假设即可成立为代数恒等式。在教材的密度、正质量及有限配对条件下它就是原公式；JSON context 已明确该公式不宣称任意输入都有概率平均意义。无 [EXTRA]/[ERRATUM?]。证明正文无 sorry；PASS 评价语义，不等于 Lean 编译证明检查。

### 7. 状态与证明位置

self-contained；`MD.Ch05.normalizedAverageFormula`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L333)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MassFraction · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Let $`\rho(z,t)`$ be the probability density associated to a collection of phase points moving under a vector field $`f`$ on the phase space $`\mathbb R^m`$. Let $`\mathcal A`$ be a suitable region of volume $`V`$ within the phase space (say a rectangular $`m`$-dimensional box). The fraction $`\nu`$ of phase points present in $`\mathcal A`$ at time $`t`$ is the integral of $`\rho`$ over $`\mathcal A`$:

$$
\nu(t)=\int_\mathcal A\rho(z,t)\,d\omega,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def massFraction {n : ℕ} (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) := ∫ z in A,ρ t z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.massFraction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；massFraction对任意时间密度族ρ:ℝ→E n→ℝ、固定区域A及时间t定义∫_A ρ t。时间参数顺序与原ρ(z,t)仅是柯里化差异，积分域及Lebesgue体积正确。定义允许一般函数，不自行证明结果位于[0,1]；作为质量积分定义不需要把概率条件塞入定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.massFraction`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L339)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MassDerivative · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> which may be viewed as a smooth function of time. On the one hand

$$
\frac{d\nu}{dt}=\int_\mathcal A\frac{\partial\rho(z,t)}{\partial t}\,d\omega,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem massDerivative :
  ∀ n (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) t,
  MeasurableSet A → (∀ s,IntegrableOn (ρ s) A) →
  (∃ δ > 0, ∃ b : MolecularDynamics.Chapter05Review.E n → ℝ, IntegrableOn b A ∧
    (∀ s ∈ Ioo (t-δ) (t+δ), ∀ z ∈ A, HasDerivAt (fun u => ρ u z) (deriv (fun u => ρ u z) s) s ∧
      |deriv (fun u => ρ u z) s| ≤ b z)) →
  HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A) (∫ z in A,deriv (fun u => ρ u z) t) t := by
  intro n ρ A t hA hint hloc
  obtain ⟨δ,hδ,b,hb,hlocal⟩ := hloc
  have ht : t ∈ Ioo (t-δ) (t+δ) := ⟨by linarith,by linarith⟩
  have hm : AEStronglyMeasurable (fun z => deriv (fun u => ρ u z) t) (volume.restrict A) := by
    apply aestronglyMeasurable_of_tendsto_ae (𝓝[≠] (0 : ℝ))
      (f := fun h z => h⁻¹*(ρ (t+h) z-ρ t z))
    · intro h
      exact ((hint (t+h)).aestronglyMeasurable.sub (hint t).aestronglyMeasurable).const_mul _
    · filter_upwards [ae_restrict_mem hA] with z hz
      simpa only [smul_eq_mul] using (hlocal t ht z hz).1.tendsto_slope_zero
  have he := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume.restrict A) (F := ρ) (F' := fun s z => deriv (fun u => ρ u z) s)
    (bound := b) (Ioo_mem_nhds (by linarith) (by linarith))
    (Filter.Eventually.of_forall (fun s => (hint s).aestronglyMeasurable)) (hint t) hm
    ((ae_restrict_mem hA).mono (fun z hz s hs => by
      simpa only [Real.norm_eq_abs] using (hlocal s hs z hz).2)) hb
    ((ae_restrict_mem hA).mono (fun z hz s hs => (hlocal s hs z hz).1))
  simpa only [MolecularDynamics.Chapter05Review.massFraction] using! he.2

theorem massDerivative_smooth (n : ℕ)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ)
    (A : Set (MolecularDynamics.Chapter05Review.E n))
    (_hA : MeasurableSet A) (_hc : IsCompact A)
    (_hρ : ContDiff ℝ ∞ (Function.uncurry ρ)) :
    ContDiff ℝ ∞ (MolecularDynamics.Chapter05Review.massFraction ρ A) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.massDerivative`；`MD.Ch05.massDerivative_smooth` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。 | [EXTRA] |

[EXTRA] [EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。；[EXTRA] 保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；massDerivative在任意n、固定可测A与时间t下，显式要求每一时刻ρ可积，存在δ>0和A上可积支配b，邻域每个s及A上每个z具有真实时间导数并满足绝对值界，结论是质量函数在t的HasDerivAt及积分内偏导。没有把交换公式作为前提。smooth另在紧A与全局联合C∞密度下断言质量函数C∞，确为原smooth措辞的充分资格；两声明量词、局部区间及[EXTRA]一致。

### 7. 状态与证明位置

incomplete；`MD.Ch05.massDerivative`：已证；`MD.Ch05.massDerivative_smooth`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L344)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-OutwardNormal · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> where $`n(z)`$ is the unit outward normal to the surface $`\partial \mathcal A`$ at the point $`z`$ and $`d\sigma`$ is the surface element.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def outwardNormalFor {n : ℕ} (A : Set (MolecularDynamics.Chapter05Review.E n)) (ν : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set (MolecularDynamics.Chapter05Review.E n),∃ r : MolecularDynamics.Chapter05Review.E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ MolecularDynamics.Chapter05Review.grad r z ≠ 0 ∧
    ν z=‖MolecularDynamics.Chapter05Review.grad r z‖⁻¹ • MolecularDynamics.Chapter05Review.grad r z



/-- 修正版，对应原文 MD-5.2.2-OutwardNormal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def outwardNormalFor_corrected {n : ℕ} (A : Set (MolecularDynamics.Chapter05Review.E n)) (ν : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set (MolecularDynamics.Chapter05Review.E n),∃ r : MolecularDynamics.Chapter05Review.E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ MolecularDynamics.Chapter05Review.grad r z ≠ 0 ∧
    ν z=‖MolecularDynamics.Chapter05Review.grad r z‖⁻¹ • MolecularDynamics.Chapter05Review.grad r z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.outwardNormalFor`；`MD.Ch05.outwardNormalFor_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；outwardNormalFor在每个z∈frontier A要求开邻域O、C²局部定义函数r、A在O内恰为r<0、非零真实梯度及ν z=∇r/‖∇r‖。边界点连续性迫使r(z)=0，正梯度方向指向A外，范数为1；资格确实限定光滑开放域。矩形角点不满足此全点条件，但[EXTRA]明确分面版本另列，未将角点假称光滑。dσ的具体测度在条目12定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.outwardNormalFor`：定义；`MD.Ch05.outwardNormalFor_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L381)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-GeneralFluxBalance · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> this same rate of change may be written as the negative of the particle flux over the boundary of $`\mathcal A`$:

$$
\frac{d\nu}{dt}=-\int_{\partial \mathcal A}f\cdot n\,\rho(z,t)\,d\sigma,
$$


> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:

$$
\frac{d\nu}{dt}=-\int_\mathcal A\nabla\cdot(f(z)\rho(z,t))\,d\omega.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem generalFluxBalance : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ν f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
  (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)))) t ∧
    (∫ z in A,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)) := by
  sorry



/-- 修正版，对应原文 MD-5.2.2-GeneralFluxBalance。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem generalFluxBalance_corrected : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ν f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
  (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)))) t ∧
    (∫ z in A,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.generalFluxBalance`；`MD.Ch05.generalFluxBalance_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；两个结论本身在所列资格下合理：任意正维n、开放D与有界光滑开放A、closure A⊆D、真实外法线；f为D上C¹，Φ为全局C²实际自治流且保持D，ρ在ℝ×D上C¹，各时刻为D上的概率密度，受限密度测度按Measure.map输运。结论先给质量时间导数等于负边界通量，再给体散度积分等于边界通量，两者推出原第二式。hausdorffArea使用单位球体积/2^d归一化直径型Hausdorff测度，方向和负号正确。[EXTRA]中“不要求ρ在D外光滑或归一化”按“在D外”共同限定两项来读，与签名一致；为避免误读，corrected\_json进一步明确D内确有概率归一化要求。这是注释澄清，不构成定理签名错误。

### 7. 状态与证明位置

incomplete；`MD.Ch05.generalFluxBalance`：未证（原书疑误不证）；`MD.Ch05.generalFluxBalance_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L399)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-Divergence · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> $`\mathcal M_fw=-\nabla\cdot(wf)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M\_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.divergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M\_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 | [EXTRA] |

[EXTRA] [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M\_f w=−div(wf)由MD-5.2.2-Liouvillian承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主定义对任意n、f:E n→E n和z取真实Fréchet导数的线性迹，正是可微向量场的散度。当前statement\_scope明确只是散度辅助定义，完整M\_fw=−div(wf)由本任务条目14实际提供，跨条映射可就所给文本核实，未将任意矩阵命名为Jacobian。不可微点的fderiv总化值不应被解释为经典散度存在。

### 7. 状态与证明位置

self-contained；`MD.Ch05.divergence`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L433)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-Liouvillian · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> The operator $`\mathcal M_f`$, defined for a scalar valued function $`w`$ by $`\mathcal M_fw=-\nabla\cdot(wf)`$, is called the Liouvillian operator.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvillian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、向量场f、实值函数u与点z，liouvillian定义为−divergence(x↦u(x)•f(x))(z)。与原w的字母差异无语义影响，负号、乘积、空间导数及标量值域均正确。对经典含义需乘积向量场可微；当前定义为标准fderiv的总化扩展，没有断言任意函数经典可微。

### 7. 状态与证明位置

self-contained；`MD.Ch05.liouvillian`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L437)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

