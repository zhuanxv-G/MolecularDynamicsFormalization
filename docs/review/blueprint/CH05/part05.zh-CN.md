[上一部分](part04.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

## 1. MD-5.3.2-HamiltonianEnergyIntegral · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> In the case of a Hamiltonian system, we know that $`\mathcal L_f^\dagger=-\mathcal L_f`$, and, moreover, $`\mathcal L_fH=0`$, so that $`H`$ is a first integral.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0 := by
  rw [MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson]
  exact MolecularDynamics.textbookPoissonBracket_self H z

theorem hamiltonianEnergyIntegral_full (k : ℕ)
    (H u : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (_hH : ContDiff ℝ 2 H) (_hu : ContDiff ℝ 1 u)
    (z : MolecularDynamics.SymplecticCoordinates k)
    (γ : ℝ → MolecularDynamics.SymplecticCoordinates k) (a b : ℝ) (_hab : a ≤ b)
    (_hγ : ∀ t ∈ Icc a b,HasDerivWithinAt γ
      (MolecularDynamics.textbookHamiltonianVectorField H (γ t)) (Icc a b) t) :
    -(LinearMap.trace ℝ (MolecularDynamics.SymplecticCoordinates k)
      (fderiv ℝ (fun x ↦ u x • MolecularDynamics.textbookHamiltonianVectorField H x) z).toLinearMap)=
        -MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) u z ∧
    (∀ t ∈ Icc a b,H (γ t)=H (γ a)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianEnergyIntegral`；`MD.Ch05.hamiltonianEnergyIntegral_full` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实Hamiltonian场的−div(u f)=−L\_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L\_fH=0，不把散度零/能量守恒当假设。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实Hamiltonian场的−div(u f)=−L\_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L\_fH=0，不把散度零/能量守恒当假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；本条两项声明均已核对。hamiltonianEnergyIntegral 对任意 Nc、实 Hamiltonian H 及 z 给出真实 Hamiltonian 向量场的 L\_f H(z)=0；J 的项目定义为块矩阵 [0,I;−I,0]，Lie 导数为实际 Fréchet 导数沿 f 的作用。这个基础等式允许任意 H，是导数总化下的代数恒等式。hamiltonianEnergyIntegral\_full 另量化 k、H、u、z、实际轨道 γ、闭区间端点 a,b；要求 H 为 C²、u 为 C¹、a≤b，并在 Icc a b 每点满足正确的 HasDerivWithinAt Hamiltonian 轨道方程。其合取结论完整包含 −trace D(u f)(z)=−L\_f u(z)，以及对每个 t∈Icc a b 的 H(γ t)=H(γ a)。前者是书中形式伴随的点态表达，后者落实真实轨道上的第一积分；未把散度零或能量守恒当成假设。闭区间退化为单点时结论也正确。

### 7. 状态与证明位置

incomplete；`MD.Ch05.hamiltonianEnergyIntegral`：已证；`MD.Ch05.hamiltonianEnergyIntegral_full`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L878)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnergyDensityInvariant · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> Any probability distribution whose density is a smooth function of $`H`$ will also be an invariant distribution.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyDensityInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    Φ (r : ℝ → ℝ), MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,MolecularDynamics.Chapter05Review.lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ H) → ∀ t,
    MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H))=MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.energyDensityInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。 | [EXTRA] |

[EXTRA] [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05\_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input\_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x\_source.json。已展开 Chapter05/ReviewDefinitions 中 E、flow、lie、density、probabilityDensity、densityMeasure、measurePropagator，并核对 Ch05.lean:726–732。项目 probabilityDensity(r∘H) 要求其可测、非负、对标准体积可积且积分为 1；densityMeasure 是实际 withDensity(ofReal(r∘H))，推前是 Measure.map。全称量词对 n,H,f,Φ,r，假设 H,r 为 C¹、Φ 是真实自治流、DH[f]=0、每个 Φt 保体积和真实概率资格；结论是对全部实时间 t 密度测度推前等于原测度。[EXTRA] 能量第一积分与保体积是 Hamiltonian 背景的实际结构属性，抽象登记后给出更一般的同结论命题，并未把待证的不变密度测度当成假设。C¹ 足以支持链式法则，概率资格保留了源文对 distribution 的限制；未声称任意 r∘H 自动可积。对象、量词、假设及不变结论忠实；PASS。证明体为 sorry；该 PASS 只指签名语义，不表示证明完成。无 [ERRATUM?] 标注。

### 7. 状态与证明位置

incomplete；`MD.Ch05.energyDensityInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L898)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeight · definition · 印刷p.190 / PDFp.211

### 2. 原文陈述

> In particular, consider the density $`\rho_\varepsilon(\mathbf q,\mathbf p)=Z_\varepsilon^{-1}e^{-(H(\mathbf q,\mathbf p)-E)^2/(2\varepsilon)}`$, where $`\varepsilon`$ is an arbitrary small positive constant and $`E`$ is an accessible energy level.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeight` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellWeight 对 n、H:E n→ℝ、实 c、ε 以及 z 定义 exp(−(H(z)−c)²/(2ε))。能级 c 对应原文 E；平方、负号和2ε均正确。它确实只是未归一化权，没有被错认成 ρε；按已明示的范围，由 shellPartition 和 shellDensity 分别处理 Z 和完整密度。ε>0、可达性和增长性是原书的使用资格，裸函数定义的总化参数域并不声称任意输入都是概率密度。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellWeight`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L908)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellPartition · definition · 印刷p.190–191 / PDFp.211–212

### 2. 原文陈述

> We assume that $`H`$ tends to infinity sufficiently rapidly as $`\|\mathbf z\|\to\infty`$ so that the exponential decays sufficiently rapidly (and thus the total integral exists) and take $`Z_\varepsilon`$ to be a normalization factor that insures that we have, for each $`\varepsilon`$, a well defined probability density function.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellPartition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellPartition 的 n、H、能级 c、ε 与实际 shellWeight 一致；定义的是全 E n 上未归一化权的 Lebesgue 体积积分，正是原书归一化要求确定的 Zε。原文把增长足够快、从而总积分存在作为假定；当前声明是归一化因子的定义，没有另外声称从一个未指定速率的定量增长条件推出可积性。在原书的正 ε、可积权语境下指数处处为正，因此该积分是有限正归一化因子。context\_notation 已明确区分总化定义和实际概率使用资格；不能据此定义推断任意 H 的归一化可行。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellPartition`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L911)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellDensity · definition · 印刷p.190 / PDFp.211

### 2. 原文陈述

> $`\rho_\varepsilon(\mathbf q,\mathbf p)=Z_\varepsilon^{-1}e^{-(H(\mathbf q,\mathbf p)-E)^2/(2\varepsilon)}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellDensity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；shellDensity 使用真实 shellWeight H c ε z 除以真实 shellPartition H c ε，展开后恰为 Zε⁻¹ exp(−(H(z)−c)²/(2ε))；只除一次 Zε，所有参数和同一能级均保持。它没有偷换成另一个函数或常数，也未重复归一化。作为定义允许较大参数类型；概率密度的非负可积及正分母资格仍按原书及 context\_notation 使用，不由总化除法自动提供。此项没有额外宣称任意 H 或非正 ε 都是概率密度。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellDensity`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L914)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnergySurface · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> We assume the level sets $`\Sigma_E=\{(q,p)\mid H(q,p)=E\}`$ to be bounded.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.energySurface` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。 MD.Ch05.energySurface {n} H c = {z | H z=c}，与原文Σ\_E完全相同，n为环境维度，c为能量值。此条kind=definition，只形式化能量等值集合；原书有界性是使用假设，原条context\_notation已明确单列，不从def推出。没有额外假设或ERRATUM；定义体无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.energySurface`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L917)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-SurfaceMeasure · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> where $`d\sigma`$ is the “area element” of the energy surface. (The term “area” in this context might be replaced by “hyperarea” or “volume” since we are in many dimensions.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.surfaceMeasure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。 | [EXTRA] |

[EXTRA] [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。 MD.Ch05.surfaceMeasure直接采用上述项目曲面面积定义，所取维度n−1与原文m−1一致，测度对象位于整个相空间而其质量受限于能量面，这是dσ的标准测度实现。EXTRA的Hausdorff规范化选择合理，与Gram图公式的识别是后续证明义务；缺少该证明并不使定义的数学对象失真。正维光滑正则面是几何解释的背景，n=0仅是总化扩展。无ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.surfaceMeasure`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L921)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroRaw · definition · 印刷p.191 / PDFp.212

### 2. 原文陈述

> define the invariant measure of a set $`M\subset\Sigma_E`$ by

$$
\mu(M)=\int_M\frac1{\|\nabla H\|}d\sigma.
$$


> Thus the invariant measure of interest to us is a rescaling of the indicated metric by the factor $`1/\|\nabla H\|`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microRaw` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。 MD.Ch05.microRaw以非负权ofReal(‖grad H z‖⁻¹)给surfaceMeasure加密度。因此在非零梯度的原文使用范围内，对面上可测M确有μ(M)=∫_M 1/‖∇H‖ dσ，未加概率归一化因子。withDensity、restrict与ofReal按标准含义已足以判定这一对象，不需要它们的库内实现。零梯度处逆元总化为0，不能解释成奇异权；原文PDF213另设梯度远离0。context\_notation关于raw与概率的区别正确。此def记录原文测度，不独立证明Hamiltonian动力学下的invariant属性；没有将该属性冒充已证。无EXTRA/ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microRaw`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L925)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeakPrinted · unnumbered_claim · 印刷p.191 / PDFp.212

### 2. 原文陈述

> As we decrease $`\varepsilon`$, the density remains invariant under Liouville's equation. The prefactor means that we can think of a sequence of smooth densities taken with successively smaller values of $`\varepsilon`$ as approaching the limiting distribution defined in terms of the delta function by

$$
\rho_0(q,p)=Z_{H=E}^{-1}\delta[H(q,p)-E].\tag{5.7}
$$


> To make this statement precise, the definition of the limit must be taken here in the weak sense, that is, we need to study the limit

$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega,\tag{5.8}
$$


> taken in relation to a test function $`\phi\in\mathcal T`$.

### 3. 原文证明

原书无独立完整证明。
> The proof that (5.8) can be taken and that the stated weak-limit identity holds may be found in the PhD thesis of Hartmann [171, Appendix D].（对原页转引的摘要；该恒等式含原书重复归一化及以ρ₀(q,p)代替分布配对的记号疑误，未在此修正。）
原书未给独立完整证明；PDF212转引Hartmann博士论文[171, Appendix D]。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellWeakPrinted :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (MolecularDynamics.Chapter05Review.shellPartition H c ε)⁻¹*(∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ShellWeakPrinted。改动：删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。 -/
```

独立修正版：

```lean
theorem shellWeakPrinted_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧
    ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakPrinted`；`MD.Ch05.shellWeakPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。 | [EXTRA] |

[EXTRA] [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。；[ERRATUM?] 删除重复归一化，补紧正则能量带作为尾部控制充分资格；Hamilton不变性不由本极限定理替代。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。hausdorffArea d = ENNReal.ofReal(v\_d/2^d) • Measure.hausdorffMeasure d，其中v\_d为欧氏ℝᵈ单位球Lebesgue体积；这将基于直径的Hausdorff测度规范化为欧氏d维面积。surfaceMeasure H c = (hausdorffArea (n−1)).restrict {z | H z=c}。shellWeight H c ε z = exp(−(H z−c)²/(2ε))；shellPartition H c ε = ∫shellWeight；shellDensity = shellWeight/shellPartition。testSpace n = {φ : ℝⁿ→ℝ | φ为C∞且有紧支撑}。microRaw = surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure = ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage = average microMeasure，average μ g = ∫g dμ。regularEnergy H c展开为能量面非空、紧、每点grad≠0，以及raw总质量严格正且有限。 量词为∀n,H,c，在C²与regularEnergy前提后对每个C∞紧支φ，主张ε↓0时Z\_ε⁻¹∫φρ\_ε趋向microAverage。PDF211已将ρ\_ε定义为归一化密度，PDF212式(5.8)再次出现外层Z\_ε⁻¹；项目定义展开确认该签名确实重复归一化。全相空间D=ℝⁿ的EXTRA是合理范围选择，但不能消除反例；原书的尾部可积性也未由regularEnergy单独保证。原文所引Liouville不变性不在本签名结论中。相关原书疑误成立；FAIL来自错误极限和缺失结论，不是Mathlib材料不足。实际声明含sorry，此事实与语义判定分开。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellWeakPrinted`：未证（原书疑误不证）；`MD.Ch05.shellWeakPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L931)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellWeakLimitCorrected · 5.8 · 印刷p.191 / PDFp.212

### 2. 原文陈述


$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho_\varepsilon\,d\omega,\tag{5.8}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellWeakLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ShellWeakLimitCorrected。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shellWeakLimit_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakLimit`；`MD.Ch05.shellWeakLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正版：不再对已归一化ρ\_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正版：不再对已归一化ρ\_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；这是 source\_id 明示的独立勘误版本，不能按字面(5.8)要求它再除一次 Zε。声明完整量化 n、H、c，要求 n>0、H 为 C²、regularEnergy H c、能级可达，以及存在正 δ 的紧能带与所有 ε∈(0,δ) 的真实权可积及正分母。regularEnergy 展开后含非空紧能量面、其上处处非零的真实梯度、microRaw 有限正总质量；单列可达条件虽冗余但无害。测试空间确为全部 C∞ 紧支撑函数。被积式是 φ乘已经归一化的 shellDensity，ε 从正侧趋零。microAverage 展开为将曲面 Hausdorff 面积按 1/‖∇H‖ 加权后，再以该 raw 总质量归一化的真实测度积分。所有对象和归一化均匹配正确的 coarea 弱极限；紧带及一个较大正参数下的权可积控制带外尾部，所以假设足够，没有把极限当假设。未缩放的 Zε 通常趋零，曲面质量对应 Zε/√(2πε) 的极限而非 Zε 的普通极限。故当前勘误签名 PASS；原书重复归一化仍作为独立疑误 NEEDS\_HUMAN 保留。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellWeakLimit`：未证（原书疑误不证）；`MD.Ch05.shellWeakLimit_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L958)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-SurfaceAreaFormula · unnumbered_claim · 印刷p.191 / PDFp.212

### 2. 原文陈述

> If we can represent the $`m-1`$-dimensional set $`\mathcal M`$ as the image of an open set $`\mathcal U\in\mathbb R^{m-1}`$ under a smooth mapping $`\mathbf g:\mathbb R^{m-1}\to\Sigma_E`$, then we have

$$
\operatorname{Vol}(\mathcal M)=\int_{\mathcal U}\sqrt{\det[(\mathbf g^{\prime}(\boldsymbol\zeta))^T\mathbf g^{\prime}(\boldsymbol\zeta)]}\,d\zeta_1d\zeta_2\cdots d\zeta_{m-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem surfaceAreaFormula :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-SurfaceAreaFormula。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem surfaceAreaFormula_corrected :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.surfaceAreaFormula`；`MD.Ch05.surfaceAreaFormula_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；限定后的 Lean 面积公式在数学上正确：∀ d、g:E d→E(d+1)、开集 U，要求 U 上 C¹、g 全局单射，并要求 U 上每点的真实 fderiv 单射。结论左边使用项目 hausdorffArea d 在 g像U 上的测度，右边由标准欧氏基的导数向量内积构成完整 d×d Gram 矩阵，取 determinant 的非负平方根并在 U 上积分；正是 m=d+1 的无重数面积公式。hausdorffArea 的项目缩放为 d维单位球体积/2^d，落实标准欧氏面积。由于两边分别使用 ENNReal.toReal 和实值 Bochner 积分，非有限情形是总化解释，并不额外宣称面积有限；有限面积时即通常数值公式。未要求像落在某一特定能量面，是对与 H 无关的局部面积公式的合理推广。须明确的是 Function.Injective g 为全局单射，比仅在 U 上单射更强，且 C¹ 比原书 smooth 所需的正则性更弱；这两点都不使受限公式错误。[EXTRA] 确实补入了单射浸入资格，但原书仅凭任意 smooth mapping 的原句不成立，另有 ∈ 的类型错误；按任务要求原书疑误不能静默按 chart 解读，因此本条整体 NEEDS\_HUMAN，而非因 sorry 或限定后公式错误判 FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch05.surfaceAreaFormula`：未证（原书疑误不证）；`MD.Ch05.surfaceAreaFormula_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L986)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalField · definition · 印刷p.192 / PDFp.213

### 2. 原文陈述

> We suppose $`\|\nabla H\|`$ to be bounded away from zero on $`\Sigma_E`$. At each point of $`M`$ we let $`n=\nabla H/\|\nabla H\|`$ be the unit normal to the energy surface and define a local coordinate $`\xi`$ measuring distance along the direction of the unit normal.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def normalField {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := ‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹ • MolecularDynamics.Chapter05Review.grad H z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则，Mathlib v4.34.0的EuclideanSpace、volume、gradient、restrict、withDensity、ENNReal.ofReal、Bochner积分、ContDiff、Tendsto等直接采用标准数学含义，不在项目依赖中要求其定义体。已展开附件Ch05\_deps.txt中-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean的本项目定义。E n = EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ，volume为Lebesgue测度；grad H z = gradient H z。 展开MD.Ch05.normalField与项目normalField均为‖grad H z‖⁻¹ • grad H z，对非零梯度正是原文n=∇H/‖∇H‖，范数1并与能量面切空间正交。原文梯度在面上远离0是使用资格；context\_notation明确零梯度处总化向量0不具有单位法线意义。作为normalField定义，此条形式化n，局部距离坐标ξ为引用背景，不自动宣称其存在性。没有EXTRA/ERRATUM，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.normalField`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1014)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalEnergyTaylor · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $`\Delta E=H(\mathbf z+\mathbf n\xi)-H(\mathbf z)=\nabla H\cdot\mathbf n\xi+\mathcal O(\Delta E^2)`$, and $`\mathbf n=\nabla H/\|\nabla H\|`$, we have $`\xi=\Delta E/\|\nabla H\|+\mathcal O(\Delta E^2)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalEnergyTaylor :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • MolecularDynamics.Chapter05Review.normalField H z)-H z-s*‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*s^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalEnergyTaylor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 | [EXTRA] |

[EXTRA] [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀ 维数 n、H:E n→ℝ 和基点 z，C² 及 grad H z≠0 后给出 ∃C>0、∃δ>0，再对每个 |s|<δ 断言二阶余项估计。grad 是实际 gradient，normalField 是 ‖grad‖⁻¹•grad，故线性项确为 s‖∇H(z)‖，位置 z+s•normalField 正确。此结论是固定基点的实际 O(s²) 正向 Taylor 子引理；它没有单独给出以 e=ΔE 为参数的逆坐标或 O(e²)。输入 statement\_scope 和 [EXTRA] 已将这些剩余结论明确映射到本批条目16，后者确实完整包含，所以不把子引理冒充整句。C² 和非零梯度是合理的局部资格；没有从总化 gradient 推断任意 H 的 Taylor 展开。

### 7. 状态与证明位置

incomplete；`MD.Ch05.normalEnergyTaylor`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1019)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-NormalInverseTaylor · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $`\Delta E=H(\mathbf z+\mathbf n\xi)-H(\mathbf z)=\nabla H\cdot\mathbf n\xi+\mathcal O(\Delta E^2)`$, and $`\mathbf n=\nabla H/\|\nabla H\|`$, we have $`\xi=\Delta E/\|\nabla H\|+\mathcal O(\Delta E^2)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem normalInverseTaylor : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0,∃ δ > 0,
  ∀ e : ℝ,|e| < δ → ∃ ξ : ℝ,
    H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)=H z+e ∧
    |ξ-e/‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*e^2 ∧
    |H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)-H z-‖MolecularDynamics.Chapter05Review.grad H z‖*ξ| ≤ C*e^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.normalInverseTaylor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。 | [EXTRA] |

[EXTRA] [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；声明对每个 n、C² 函数 H 和非临界基点 z，先选择依赖 H,z 的 C>0 和 δ>0，再对每个实 |e|<δ 选择 ξ。三个合取结论都保留：真实能量方程 H(z+ξn)=H(z)+e；|ξ−e/‖∇H(z)‖|≤Ce²；以及同一 ξ 上 |H(z+ξn)−H(z)−‖∇H(z)‖ξ|≤Ce²。最后一项正是原文以 ΔE 为变量的正向余项，而不是只提供 O(ξ²)。同一 C 可通过增大常数同时控制两项；非零梯度给出一维法向能量映射的非零导数，C² 局部逆资格足够。估计还使 ξ 在 e→0 时趋0，故存在性不是无关的远处能量交点。原文 E 在此为 H(z)，法向取在固定基点；本条不声称对整个能量面有统一的常数。

### 7. 状态与证明位置

incomplete；`MD.Ch05.normalInverseTaylor`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1027)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-PatchShellVolume · unnumbered_claim · 印刷p.192–193 / PDFp.213–214

### 2. 原文陈述

> The volume of this thickened shell is clearly $`\Delta V=\int_M\xi d\sigma`$, but since $`\Delta E=H(z+n\xi)-H(z)=\nabla H\cdot n\xi+O(\Delta E^2)`$, and $`n=\nabla H/\|\nabla H\|`$, we have $`\xi=\Delta E/\|\nabla H\|+O(\Delta E^2)`$, and $`\Delta V=\int_M\frac{\Delta E}{\|\nabla H\|}d\sigma+O(\Delta E^2)`$. Taking the ratio of $`\Delta V`$ to $`\Delta E`$ we find $`\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)`$. The limit of this as $`\Delta E\to0`$ defines a quantity $`\mu(M)=\int_M\|\nabla H\|^{-1}d\sigma`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem patchShellVolume : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (M : Set (MolecularDynamics.Chapter05Review.E n)),
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ MolecularDynamics.Chapter05Review.energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • MolecularDynamics.Chapter05Review.normalField H z ∧ H x-H z ≤ e}).toReal/e-
        ((MolecularDynamics.Chapter05Review.microRaw H c) M).toReal| ≤ C*e := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-PatchShellVolume。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem patchShellVolume_corrected : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (M : Set (MolecularDynamics.Chapter05Review.E n)),
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ MolecularDynamics.Chapter05Review.energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • MolecularDynamics.Chapter05Review.normalField H z ∧ H x-H z ≤ e}).toReal/e-
        ((MolecularDynamics.Chapter05Review.microRaw H c) M).toReal| ≤ C*e := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.patchShellVolume`；`MD.Ch05.patchShellVolume_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.patchShellVolume（810–817行）及PDF213–214/印刷192–193。在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。regularEnergy 并非仅正则值条件，而是能量面非空、紧、处处grad≠0、raw总质量严格正且有限的合取。实际签名对每个紧可测M⊂Σ\_c，先选C,δ>0，再对所有0<e<δ，给由x=z+s n(z)、0≤s<δ、H(x)−H(z)≤e定义的真实法线薄壳满足|vol(S\_e)/e−μ(M)|≤Ce。C²、紧正则面与可测片足以保证小管几何，额外全能量面非空及质量正并非局部估计的最小要求，但作为明确的物理背景合理。最终O(e)结论以及由它推出的极限正确；乘以e也得到体积的O(e²)式。然而本条statement\_scope覆盖所引整段，其“clearly ΔV=∫_M ξdσ”精确等式既未编码也一般不成立；[EXTRA]关于Jacobian的勘误判断成立，不能将该错误原印刷式视为已经保留。此FAIL针对完整引用范围的覆盖，不是否定修正后最终渐近估计。附件对应theorem的证明体仍为sorry；这里只判断签名语义，PASS不表示Lean证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.patchShellVolume`：未证（原书疑误不证）；`MD.Ch05.patchShellVolume_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1038)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

