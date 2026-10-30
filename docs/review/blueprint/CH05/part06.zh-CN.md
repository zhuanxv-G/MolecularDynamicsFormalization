[上一部分](part05.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

## 1. MD-5.3.2-WholeShellVolumeLimit · unnumbered_claim · 印刷p.192 / PDFp.213

### 2. 原文陈述

> $`\Delta V/\Delta E=\int_M\|\nabla H\|^{-1}d\sigma+O(\Delta E)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shellVolumeLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microPartition H c)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-WholeShellVolumeLimit。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shellVolumeLimit_corrected :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microPartition H c)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellVolumeLimit`；`MD.Ch05.shellVolumeLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.shellVolumeLimit（821–827行）及所引PDF213/印刷192比值式。在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。regularEnergy 并非仅正则值条件，而是能量面非空、紧、处处grad≠0、raw总质量严格正且有限的合取。microPartition H c=((microRaw H c) univ).toReal；regularEnergy确保有限性，在此处toReal无损。签名表达整能量面全壳{c≤H≤c+ε}的体积比值在ε→0+时收敛到该总质量。额外紧正则能量带避免远处分支贡献，是合理的全壳控制；其邻域∀z梯度非零明确且非循环。但所引式对任意片M并含O(ΔE)，而本签名无M且仅Tendsto，没有O(ε)误差界。[EXTRA]诚实标明这是特例，不能使较弱特例等同于所引全部结论；别条保留片定理也不改变本声明。附件对应theorem的证明体仍为sorry；这里只判断签名语义，PASS不表示Lean证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.shellVolumeLimit`：未证（原书疑误不证）；`MD.Ch05.shellVolumeLimit_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1066)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroRawInvariant · unnumbered_claim · 印刷p.193 / PDFp.214

### 2. 原文陈述

> As both volume and energy are invariant under the Hamiltonian flow, $`\mu(\mathcal M)`$ must be invariant under the flow, thus $`\mu(\mathcal F_t(\mathcal M))=\mu(\mathcal M)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem microRawInvariant : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microRaw H c) (MolecularDynamics.Chapter05Review.microRaw H c) ∧
    ∀ M,MeasurableSet M → (MolecularDynamics.Chapter05Review.microRaw H c) (Φ t '' M)=(MolecularDynamics.Chapter05Review.microRaw H c) M := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microRawInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。 | [EXTRA] |

[EXTRA] [EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。光滑全流、体积保持和能量保持是本条的实际输入，待证的加权曲面测度不变性没有被假设。联合光滑性及逆时间使像集合结论与 MeasurePreserving 相容。原书只写 M⊂Σ\_E；Lean 对任意可测环境 M 陈述等式是支持于能级的测度的自然扩展。regularEnergy 的额外限制较原句强，已在 corrected\_json 明示。

### 7. 状态与证明位置

incomplete；`MD.Ch05.microRawInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1091)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroInvariant · unnumbered_claim · 印刷p.193 / PDFp.214

### 2. 原文陈述

> $`\mu(\mathcal F_t(\mathcal M))=\mu(\mathcal M)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem microInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.microMeasure H c) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。 | [EXTRA] |

[EXTRA] [EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS（按已明示的归一化变体及跨条目映射审校）。当前声明的对象确为 microMeasure，并未冒称其定义就是原页 μ。正有限的总质量使这一变体与 raw 不变性相容；原页 raw 的像集合等式已经由本批第1条 microRawInvariant 完整保留。MeasurePreserving 虽按逆像表述，在此光滑可逆全流下不会丢失原书的像集合含义。

### 7. 状态与证明位置

incomplete；`MD.Ch05.microInvariant`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1101)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-MicroPartition · definition · 印刷p.193 / PDFp.214

### 2. 原文陈述

> The invariant measure of the whole level set $`\Sigma_E`$ is defined as the microcanonical partition function $`Z_E=\mu(\Sigma_E)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := ((MolecularDynamics.Chapter05Review.microRaw H c) univ).toReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microPartition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS（有限质量的实值实现）。原注释已经明确 ENNReal 转实只在有限总质量时适用，因此这里没有把 ∞ 解释成有限配分函数。univ 与能级的差别由 raw 测度受限于能级解释。定义本身允许任意 H,c，是一个总化函数；审校通过不包含“所有能级的 Z\_E 都有限”的额外结论。概率用途还需正质量，见第9、10条。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microPartition`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1109)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ShellPointValuePrinted · notation · 印刷p.191 / PDFp.212

### 2. 原文陈述

> The proof that (5.8) can be taken and that

$$
\lim_{\varepsilon\to0}Z_\varepsilon^{-1}\int_D\phi(q,p)\rho_\varepsilon d\omega=\rho_0(q,p)=Z_{H=E}^{-1}\int_D\phi(q,p)\delta[H(q,p)-E]d\omega
$$


> may be found in the PhD thesis of Hartmann [171, Appendix D].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def shellWeakPairing {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.microAverage H c φ



/-- 修正版，对应原文 MD-5.3.2-ShellPointValuePrinted。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def shellWeakPairing_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.microAverage H c φ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.shellWeakPairing`；`MD.Ch05.shellWeakPairing_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学语义：EuclideanSpace 是欧氏空间，volume 是其标准Lebesgue测度，积分为Bochner积分，MeasurePreserving 是可测映射的推前测度保持；restrict、withDensity、Tendsto、ContDiff、gradient、ENNReal.ofReal/toReal 等均按标准含义，不要求其定义体收录在依赖摘录。仅展开本项目自定义，使用与上一轮三项SHA256完全相同的附件；未采用其他旧工程文件。核对 Ch05.lean 的 MD.Ch05.shellWeakPairing（853–854行）及PDF212/印刷191展示式。在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 中逐项展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z | H z=c}；grad H z=gradient H z；normalField H z=‖grad H z‖⁻¹ • grad H z；hausdorffArea d=ENNReal.ofReal(vol(Ball(0:E d,1)).toReal/2^d) • hausdorffMeasure d；surfaceMeasure 是 hausdorffArea(n−1) 在 energySurface 上的限制；microRaw 是 surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))，即原文未归一化的曲面加权测度。欧氏空间中这个Hausdorff归一化对应通常诱导面积，不因工程尚有余面积证明义务而把定义判为未知。项目定义链为shellWeakPairing H c φ=microAverage H c φ=average(microMeasure H c)φ，average μ φ=∫z,φ z ∂μ，microMeasure=(raw univ)⁻¹ • raw。故它是一个实值归一化曲面测试函数配对；标准Bochner积分不可积时取0，无测试函数或Integrable限制的def不能额外承诺其物理弱配对对所有φ都有效。本条实际没有ε、D、Z\_ε、ρ\_ε及Tendsto，不表达所引弱极限等式。[EXTRA]如实承认这里只给notation；这不够覆盖当前statement\_scope的整条原式。原式把依赖φ的标量配对写成分布ρ₀(q,p)点值，ERRATUM判断成立；重复的Z\_ε⁻¹按原印刷保留，其解释不得从本notation的类型正确性推出。此def本身无sorry，但也无待验证的弱极限定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.shellWeakPairing`：定义；`MD.Ch05.shellWeakPairing_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1114)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HarmonicEnergy · Example 5.1 · 印刷p.193 / PDFp.214

### 2. 原文陈述

> Example 5.1 Consider the harmonic oscillator $`H(q,p)=p^2/2+\Omega^2q^2/2`$. The energy surface $`H=E\gt 0`$ is an ellipse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def harmonicEnergy (Ω : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) := (z 1)^2/2+Ω^2*(z 0)^2/2

theorem harmonicEnergy_ellipse (Ω c : ℝ) (_hΩ : Ω ≠ 0) (_hc : 0 < c)
    (z : MolecularDynamics.Chapter05Review.E 2) :
    harmonicEnergy Ω z=c ↔
      (z 0/(Real.sqrt (2*c)/|Ω|))^2+(z 1/Real.sqrt (2*c))^2=1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicEnergy`；`MD.Ch05.harmonicEnergy_ellipse` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。 | [EXTRA] |

[EXTRA] [EXTRA] 补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。能量定义和椭圆等价式均忠实；|Ω| 正确处理负的形式参数。Ω=0 会退化，原文的 oscillator 语境及已有 [EXTRA] 已将其排除在椭圆断言的适用范围之外，没有静默改写原句。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicEnergy`：定义；`MD.Ch05.harmonicEnergy_ellipse`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1125)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HarmonicQuadraturePrinted · unnumbered_claim · 印刷p.193 / PDFp.214

### 2. 原文陈述

> Parameterizing the surface by $`q`$, we have $`p=\sqrt{2E-\Omega^2q^2}`$, then

$$
\mu(\Sigma_E)=4\int_0^{\sqrt{2E}}\frac{\sqrt{1+p_q^2}}{\sqrt{H_p^2+H_q^2}}dq =4\int_0^{\sqrt{2E}/\Omega}\frac{\sqrt{1+\frac{\Omega^4q^2}{2E-\Omega^2q^2}}}{\sqrt{p^2+\Omega^4q^2}}dq =4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem harmonicQuadraturePrinted : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c),
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-HarmonicQuadraturePrinted。改动：首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。 -/
```

独立修正版：

```lean
theorem harmonicQuadraturePrinted_corrected : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicQuadraturePrinted`；`MD.Ch05.harmonicQuadraturePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。 | [EXTRA] |

[EXTRA] [EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。；[ERRATUM?] 首积分上界补/Ω，后续积分及microPartition由HarmonicPartition配套声明；原印上界不改。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按补充规则，Mathlib v4.34.0 的 EuclideanSpace、volume、gradient、Hausdorff 测度、restrict、withDensity、ENNReal.ofReal、toReal、实平方根、实数幂、Gamma 和区间 Bochner 积分均直接采用标准数学含义，不要求在 Ch05\_deps.txt 查找其定义体。只对项目自定义逐层展开；判断签名是否覆盖本 source\_id 的全部原文结论，与是否存在 sorry 分开。 PDF214/印刷193的第一积分上界确为√(2E)，后两项为√(2E)/Ω。附件签名量化所有Ω,c>0，将图形上的p\_q²展开为(Ω²q/√(2c−Ω²q²))²，将H\_p²+H\_q²展开为2c−Ω²q²+Ω⁴q²；这些在实图形内部正确，但不同上界的两积分一般不等。[EXTRA]正c在原页已有，正Ω为合理频率约定且排除退化；端点总化只修改零测点，不能修复区间长度的差异。原书首上界应为√(2E)/Ω的疑误可由下述反例确认；未静默修改原书。所引完整链的μ(Σ\_E)及2π/Ω还没有出现在本签名中。失败依据是假命题和缺失子句，并非Mathlib定义缺失；该theorem的sorry仅说明证明尚未完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicQuadraturePrinted`：未证（原书疑误不证）；`MD.Ch05.harmonicQuadraturePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1136)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-HarmonicPartition · Example 5.1 · 印刷p.193 / PDFp.214

### 2. 原文陈述

> $`\mu(\Sigma_E)=4\int_0^{\sqrt{2E}/\Omega}\frac1{\sqrt{2E-\Omega^2q^2}}dq=2\pi/\Omega`$.

### 3. 原文证明

原书无独立完整证明。
> The partition function is obtained by integrating in the standard way. Parameterizing the surface by $`q`$, we have $`p=\sqrt{2E-\Omega^2q^2}`$, then

$$
\begin{aligned}\mu(\Sigma_E)&=4\int_0^{\sqrt{2E}}\frac{\sqrt{1+p_q^2}}{\sqrt{H_p^2+H_q^2}}\,dq\\&=4\int_0^{\sqrt{2E}/\Omega}\frac{\sqrt{1+\frac{\Omega^4q^2}{2E-\Omega^2q^2}}}{\sqrt{p^2+\Omega^4q^2}}\,dq\\&=4\int_0^{\sqrt{2E}/\Omega}\frac{1}{\sqrt{2E-\Omega^2q^2}}\,dq\\&=2\pi/\Omega.\end{aligned}
$$


原页给出 Example 5.1 的参数积分计算，未另设命题证明；首个参数积分上限有原印疑点，保留待人工确认。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem harmonicPartition : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω := by
  sorry

theorem harmonicPartition_quadrature (Ω c : ℝ) (_hΩ : 0 < Ω) (_hc : 0 < c) :
    MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=
      4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) ∧
    4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2))=2*Real.pi/Ω := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-HarmonicPartition。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem harmonicPartition_corrected : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicPartition`；`MD.Ch05.harmonicPartition_quadrature`；`MD.Ch05.harmonicPartition_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。；[EXTRA] 保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；NEEDS\_HUMAN 是原页推导疑误的分流，不是因 sorry 或因当前两个签名错误。两条 Lean 签名在 Ω,c>0 下均通过；quadrature 实现原印后两行的正确积分。原印第一行另有不一致上限，不能用这两条签名声称整段印刷推导已经逐字正确。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicPartition`：未证（原书疑误不证）；`MD.Ch05.harmonicPartition_quadrature`：未证（原书疑误不证）；`MD.Ch05.harmonicPartition_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1159)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-IdealGasEnergy · Example 5.2 · 印刷p.193 / PDFp.214

### 2. 原文陈述

> Example 5.2 Consider a system of $`N`$ non-interacting particles of mass $`m`$ moving in periodic boundary conditions within a box of volume $`V`$. The Hamiltonian is

$$
H=\frac1{2m}\sum_{i=1}^N\|p_i\|^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def idealGasEnergy (N : ℕ) (m : ℝ) (z : MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  (∑ i : Fin (3*N),(z (Fin.natAdd (3*N) i))^2)/(2*m)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.idealGasEnergy` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。周期边界不影响局部动能公式，展平坐标没有改变粒子数或质量因子。定义在所有形式参数上的总化扩展不产生质量为0时的物理断言；后续配分函数明确要求 N,m,c,L>0。

### 7. 状态与证明位置

self-contained；`MD.Ch05.idealGasEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1181)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-IdealGasPositionDomain · definition · 印刷p.193–194 / PDFp.214–215

### 2. 原文陈述

> $`Z_E=V^N\int_{\mathcal S}(m/r)d\sigma`$, where $`\mathcal S`$ is the $`3N-1`$ dimensional sphere in $`3N`$ dimensions of radius $`r=\sqrt{2mE}`$, and $`d\sigma`$ is the surface area element on this sphere. $`V^N`$ is the contribution due to integration over positions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.idealGasPositionDomain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。 | [EXTRA] |

[EXTRA] [EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS（仅按已明示的辅助域范围）。此定义没有单独证明原文球面积分公式，也没有声称原文逐点定义了闭胞；statement\_scope 和 [EXTRA] 已明确将剩余原文映射到第8条。该映射在本批可核对：idealGasPartition\_factors 给出同一半径球面、(L³)^N 因子和真实 raw 曲面质量的积分分解。因映射明确且实际存在，不以辅助定义替代整段原文。

### 7. 状态与证明位置

self-contained；`MD.Ch05.idealGasPositionDomain`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1187)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-IdealGasPartition · Example 5.2 · 印刷p.194 / PDFp.215

### 2. 原文陈述

> Thus we have

$$
Z_E=V^N\frac{m}{\sqrt{2mE}}A(\mathcal S) =V^N\frac{\sqrt m}{\sqrt{2E}}\frac{3N\pi^{3N/2}(2mE)^{(3N-1)/2}}{\Gamma(3N/2+1)} =V^N\frac{(2\pi mE)^{3N/2}}{E\Gamma(3N/2)}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem idealGasPartition : ∀ (N : ℕ) (m c L : ℝ),0 < N → 0 < m → 0 < c → 0 < L →
  ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal=
    (L^3)^N*Real.rpow (2*Real.pi*m*c) ((3*N : ℝ)/2)/(c*Real.Gamma ((3*N : ℝ)/2)) := by
  sorry

theorem idealGasPartition_factors (N : ℕ) (m c L : ℝ)
    (_hN : 0 < N) (_hm : 0 < m) (_hc : 0 < c) (_hL : 0 < L) :
    let S := Metric.sphere (0 : MolecularDynamics.Chapter05Review.E (3*N)) (Real.sqrt (2*m*c))
    let A := (MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1) S).toReal
    let Z := ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal
    Z=(L^3)^N*(∫ p in S,m/Real.sqrt (2*m*c)
      ∂(MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1))) ∧
    Z=(L^3)^N*(m/Real.sqrt (2*m*c))*A ∧
    Z=(L^3)^N*(Real.sqrt m/Real.sqrt (2*c))*
      ((3*N : ℝ)*Real.rpow Real.pi ((3*N : ℝ)/2)*Real.rpow (2*m*c) (((3*N : ℝ)-1)/2)/
      Real.Gamma ((3*N : ℝ)/2+1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.idealGasPartition`；`MD.Ch05.idealGasPartition_factors` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。 | [EXTRA] |

[EXTRA] [EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。；[EXTRA] 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。对象、全部前提和各步结论吻合；位置体积(L³)^N、球面半径及其面积系数都保留。3N·π^(3N/2)/Γ(3N/2+1) 是正确球面积系数，代入梯度权重得到所列最终式。[EXTRA] 未把因子分解结论作为假设，也未用参数积分定义 microRaw。有限基本胞是明确且合理的实现范围。

### 7. 状态与证明位置

incomplete；`MD.Ch05.idealGasPartition`：未证（缺大型理论）；`MD.Ch05.idealGasPartition_factors`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1193)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-MicroMeasure · definition · 印刷p.194 / PDFp.215

### 2. 原文陈述

> Let $`d\mu_E=Z_E^{-1}\|\nabla H\|^{-1}d\sigma`$. We refer to this as the microcanonical probability density and write, for an “appropriate” set $`\mathcal A`$, $`\operatorname{Pr}(\mathcal A)=\mu_E(\mathcal A)=\int_{\mathcal A} d\mu_E`$. The only requirement for this to make sense is that the set $`\mathcal A`$ be a measurable subset of the $`H=E`$ energy surface, i.e. that it be possible to compute its surface area.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c



/-- 修正版，对应原文 MD-5.3.3-MicroMeasure。改动：归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。 -/
```

独立修正版：

```lean
def microMeasure_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (_hpos : 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ)
    (_hfinite : (MolecularDynamics.Chapter05Review.microRaw H c) univ < ⊤) :
    Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microMeasure`；`MD.Ch05.microMeasure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]总raw质量正且有限是使用概率意义的必要资格；定义用实际ENNReal标量归一化，不把无穷总质量逆值0解释成概率测度。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。 | [EXTRA] |

[EXTRA] [EXTRA]总raw质量正且有限是使用概率意义的必要资格；定义用实际ENNReal标量归一化，不把无穷总质量逆值0解释成概率测度。；[ERRATUM?] 归一化主接口显式要求原始质量正且有限；任意H,c的总化公式仍保留为原辅助，不声称退化能级也是概率分布。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；NEEDS\_HUMAN 针对原书“唯一要求”及可测性解释的资格问题。Lean 定义作为一个总化测度通过签名审校，[EXTRA] 也正确声明了概率解释必须有正有限 raw 总质量；不能因此把原书未写出的条件说成已在原句中出现。当前定义的每个值都是测度，而它成为概率测度的范围由第10条严格规定。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microMeasure`：定义；`MD.Ch05.microMeasure_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1214)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-MicroProbability · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We have the standard properties of a probability function: $`0\leq\operatorname{Pr}(\mathcal A)\leq1`$ for all measurable sets $`\mathcal A`$; $`\operatorname{Pr}(\Sigma_E)=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem microProbability : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 1 H → 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ → (MolecularDynamics.Chapter05Review.microRaw H c) univ < (⊤ : ENNReal) →
  (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 ∧
    (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.energySurface H c)=1 ∧
    ∀ A : Set (MolecularDynamics.Chapter05Review.E n),0 ≤ (MolecularDynamics.Chapter05Review.microMeasure H c) A ∧ (MolecularDynamics.Chapter05Review.microMeasure H c) A ≤ 1 := by
  intro n H c hH hpos hfin
  let σ := MolecularDynamics.Chapter05Review.energySurface H c
  have hσ : MeasurableSet σ := by
    exact (isClosed_eq hH.continuous continuous_const).measurableSet
  have hzero : (MolecularDynamics.Chapter05Review.microRaw H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microRaw
    apply withDensity_absolutelyContinuous
    unfold MolecularDynamics.Chapter05Review.surfaceMeasure
    rw [Measure.restrict_apply hσ.compl]
    simp [σ]
  have hu : (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,smul_eq_mul]
    exact ENNReal.inv_mul_cancel (ne_of_gt hpos) (ne_of_lt hfin)
  have hz : (MolecularDynamics.Chapter05Review.microMeasure H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,hzero,smul_zero]
  refine ⟨hu,?_,?_⟩
  · have hh := measure_add_measure_compl hσ (μ:=MolecularDynamics.Chapter05Review.microMeasure H c)
    simpa only [hz,add_zero,hu] using hh
  · intro A
    exact ⟨bot_le,(measure_mono (subset_univ A)).trans_eq hu⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原H光滑背景及正有限总质量明示；ΣE总概率1也保留，不仅证明ambient univ质量1。 | [EXTRA] |

[EXTRA] [EXTRA]原H光滑背景及正有限总质量明示；ΣE总概率1也保留，不仅证明ambient univ质量1。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；PASS。两个正有限质量前提保证逆标量合法，闭能级及支持性质保证能级本身的质量为1。Measure 的集合函数对所有集合按外测度取值，因此把界限推广到任意 A 是正确加强，包含原文所有可测子集。[EXTRA] 完整登记了这些资格；没有靠缺失的证明将签名判为失败。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microProbability`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1228)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-LowerDimensionNull · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We also note that lower order objects such as a point or a curve in $`\mathbb R^2`$, or a surface in $`\mathbb R^3`$, have zero measure with respect to Lebesgue measure for the ambient space. Similarly, for a Hamiltonian system with $`N_d`$ degrees of freedom, the energy surface is of dimension $`2N_d-1`$ and the probability measure of sets of lower dimension than this will vanish.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lowerDimensionNull :
  ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : Set (MolecularDynamics.Chapter05Review.E d)), d+1 < n → ContDiff ℝ 1 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
    ContDiff ℝ 1 g → IsCompact K →
    g '' K ⊆ MolecularDynamics.Chapter05Review.energySurface H c → (MolecularDynamics.Chapter05Review.microMeasure H c) (g '' K)=0 := by
  sorry

theorem lowerDimensionNull_countable (n d : ℕ)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d+1 < n)
    (_hH : ContDiff ℝ 1 H)
    (_hreg : ∀ z,MolecularDynamics.Chapter05Review.energySurface H c z →
      MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (_hblocks : ∀ k,ContDiff ℝ 1 (g k) ∧ IsCompact (K k) ∧
      g k '' K k ⊆ MolecularDynamics.Chapter05Review.energySurface H c) :
    (MolecularDynamics.Chapter05Review.microMeasure H c) (⋃ k,g k '' K k)=0 ∧
      volume (⋃ k,g k '' K k)=0 := by
  sorry

theorem lowerDimensionNull_level_dimension (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 1 H)
    (c : ℝ) (_hreg : ∀ z,H z=c → MolecularDynamics.Chapter05Review.grad H z ≠ 0) :
    ∀ z,H z=c → ∃ U : Set (MolecularDynamics.Chapter05Review.E n),
      IsOpen U ∧ z ∈ U ∧ ∃ V : Set (MolecularDynamics.Chapter05Review.E (n-1)),
      IsOpen V ∧ Nonempty (V ≃ₜ ↥(MolecularDynamics.Chapter05Review.energySurface H c ∩ U)) := by
  sorry
```

独立修正版：

```lean
theorem lowerDimensionNull_ambient_corrected (n d : ℕ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d < n)
    (_hblocks : ∀ k, ContDiff ℝ 1 (g k) ∧ IsCompact (K k)) :
    volume (⋃ k, g k '' K k) = 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lowerDimensionNull`；`MD.Ch05.lowerDimensionNull_countable`；`MD.Ch05.lowerDimensionNull_level_dimension`；`MD.Ch05.lowerDimensionNull_ambient_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]低维光滑参数化的紧像、正则C¹能量面，维数严格小于能量面；未将任意“拓扑低维集合”自动视为零测。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N\_d）。环境Lebesgue零测也在本批同列。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。 | [EXTRA] |

[EXTRA] [EXTRA]低维光滑参数化的紧像、正则C¹能量面，维数严格小于能量面；未将任意“拓扑低维集合”自动视为零测。；[EXTRA] 保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N\_d）。环境Lebesgue零测也在本批同列。；[EXTRA] 保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。；[ERRATUM?] 本条网站意见已由FAIL修复处理，完整引文保留并独立登记覆盖问题；一般环境零测结论不作无条件能级维数定理。

### 6. 审计结论

本轮修复：保留既有三个正则能级声明，另加不依赖H、c或能级包含关系的一般d<n环境Lebesgue零测声明，覆盖平面曲线和三维曲面；新增声明尚未证明。原书无条件能级维数句保留疑误。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；FAIL（整条原文的完整覆盖），同时原书的未限定维数语言需人工确认。三个现有 Lean 声明本身均数学正确，且第二条确有环境 volume=0；但这只覆盖位于能级且 d<n−1 的集合，不能冒称原文第一句的一般环境低维零测已覆盖。n=2,d=1 的曲线及 n=3,d=2 的曲面都不满足其严格维数前提，而它们恰是原文列举对象。第二句的正则能级、光滑低维零测已有合理受限实现；该部分通过不能补上第一句的缺口。

### 7. 状态与证明位置

incomplete；`MD.Ch05.lowerDimensionNull`：未证（原书疑误不证）；`MD.Ch05.lowerDimensionNull_countable`：未证（原书疑误不证）；`MD.Ch05.lowerDimensionNull_level_dimension`：未证（原书疑误不证）；`MD.Ch05.lowerDimensionNull_ambient_corrected`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1260)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.3-MicroAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> As we mentioned in motivating the microcanonical distribution, we could alternatively view microcanonical averages as integrals with respect to the singular measure on the ambient space $`\mathcal D`$ defined by $`\rho'_Ed\omega=Z_E^{-1}\delta[H-E]d\omega`$, where $`\delta`$ represents the Dirac delta function. The notation $`d\omega`$ represents the volume element in the Euclidean space defined by all coordinates and momenta. This is the more common definition of the microcanonical distribution encountered in physics treatments.
> 
> Regardless of which formulation is adopted, we may use the probability measure to compute expectations (averages) of (suitable) functions defined on the phase space. We write such an expectation as

$$
\operatorname{Av}_{H=E}(g)=\int_{\Sigma_E}g(z)d\mu_E=\int_{\mathcal D}g(z)\rho'_Ed\omega.
$$


> Incidentally, any such function is referred to as an observable function (or, simply, an observable) of the system in this context.
> 
> As shorthand, where the underlying space and probability density are assumed, one may write such an average more simply as $`\operatorname{Av}_{H=E}(g)=\langle g\rangle`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g

theorem microAverage_surface_and_delta_limit (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 2 H)
    (c : ℝ) (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hband : ∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧
      ∀ z,|H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hφ : ContDiff ℝ ∞ φ)
    (_hc : HasCompactSupport φ) :
    microAverage H c φ=(MolecularDynamics.Chapter05Review.microPartition H c)⁻¹*
      (∫ z in MolecularDynamics.Chapter05Review.energySurface H c,
        φ z/‖MolecularDynamics.Chapter05Review.grad H z‖
        ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))) ∧
    Tendsto (fun ε : ℝ ↦
      (∫ z in {z | |H z-c| < ε},φ z)/
      (volume {z | |H z-c| < ε}).toReal) (𝓝[>] 0) (𝓝 (microAverage H c φ)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microAverage`；`MD.Ch05.microAverage_surface_and_delta_limit` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。 | [EXTRA] |

[EXTRA] [EXTRA] 补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对象为 n 维实欧氏空间，H,c,g 的类型正确；average 是实际 Bochner 积分，microRaw 是能量面上归一化 Hausdorff 面积的逆梯度密度，microMeasure 用总质量归一化，并非把 Dirac δ 当普通函数。定义在任意 H,c 上总化；只有正有限总质量时才解释为概率平均。附加定理明确 n>0、H∈C²、非空紧正则能量面及正有限原始质量，并进一步要求整个闭能量带紧且无临界点；φ 为全局 C∞ 紧支撑函数。完整结论既有曲面积分等式，也有正 ε 趋零的真实体积薄壳积分比极限。紧正则能量带足以排除远端薄壳质量，归一化使分子分母的 2ε 因子抵消；签名合理。该定理只覆盖所列测试函数，不宣称所有可测 g 都有 δ 配对极限。未检查或补写 sorry 证明。

### 7. 状态与证明位置

incomplete；`MD.Ch05.microAverage`：定义；`MD.Ch05.microAverage_surface_and_delta_limit`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1298)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

