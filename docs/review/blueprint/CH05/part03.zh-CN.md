[上一部分](part02.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

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

## 1. MD-5.3.3-AmbientLowerDimensionNull · unnumbered_claim · 印刷p.195 / PDFp.216

### 2. 原文陈述

> We also note that lower order objects such as a point or a curve in $`\mathbb R^2`$, or a surface in $`\mathbb R^3`$, have zero measure with respect to Lebesgue measure for the ambient space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ambientLowerDimensionNull : ∀ n d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n) (K : Set (MolecularDynamics.Chapter05Review.E d)),
  d < n → ContDiff ℝ 1 g → IsCompact K → volume (g '' K)=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ambientLowerDimensionNull` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。 | [EXTRA] |

[EXTRA] [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准数学含义，不要求在项目依赖摘录中提供Mathlib定义体。已展开项目E（Ch05\_deps.txt中MolecularDynamics/Chapter05/ReviewDefinitions.lean行5315）：E n=EuclideanSpace ℝ (Fin n)，即欧氏ℝⁿ；volume按标准含义为其Lebesgue测度，无需项目摘录另供定义体。Ch05.lean行938–939依次量化任意n,d,C¹映射g:ℝᵈ→ℝⁿ及紧K⊆ℝᵈ，并在d<n时断言volume(g''K)=0；对象、量词、维数比较及实际ambient零测结论正确。PDF第216页（印刷195页）点、ℝ²中的曲线、ℝ³中的曲面分别有d=0、(d,n)=(1,2)、(2,3)的光滑参数块模型。[EXTRA]C¹参数化紧像已明确披露，是通常光滑低维对象的合理局部形式；C¹提供局部Lipschitz性质，紧性有利于有限局部覆盖，并非零测所必需。一般光滑曲线或曲面可通过可数紧参数块/局部图覆盖归约，原文无限对象不会因局部块形式而被解释成高维对象。不扩张为任意连续曲线或任意拓扑低维集合的断言。无[ERRATUM?]。证明体含sorry，但签名的语义PASS与证明完成度分开；未运行编译。

### 7. 状态与证明位置

incomplete；`MD.Ch05.ambientLowerDimensionNull`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1318)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-TimeAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> Given an autonomous system of differential equations $`\dot z=f(z)`$ in $`\mathbb R^m`$, and a trajectory $`\Gamma=\{z(t)\mid t\in[0,\infty]\}`$, let $`g=g(z)`$ be any smooth scalar valued function of $`z`$ (an observable) and define (assuming it exists) the infinite time average of $`g`$ along $`\Gamma`$ by

$$
\bar g_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau g(z(t))dt.\tag{5.9}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.timeAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；X 是任意类型，z:ℝ→X，g:X→ℝ，T:ℝ；定义恰为 T⁻¹ 乘 0..T 的真实有向区间积分。按明确 statement\_scope 本条仅承担有限截断因子，无限极限由下一条承担，未把有限值冒充无限平均。任意路径和函数是公式层面的自然推广；原书光滑正向轨道是其适用特例。T=0 或不可积函数的 Lean 总化值不赋予原书平均意义，负 T 仅属定义延拓。

### 7. 状态与证明位置

self-contained；`MD.Ch05.timeAverage`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1324)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-HasTimeAverage · definition · 印刷p.195 / PDFp.216

### 2. 原文陈述

> define (assuming it exists) the infinite time average of $`g`$ along $`\Gamma`$ by $`\bar g_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau g(z(t))dt`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hasTimeAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意 X,z,g 及候选实数 a，以 Tendsto (timeAverage z g) atTop (𝓝 a) 表达式(5.9)。使用的是摘录的 Chapter05Review.timeAverage，即真实 0..T 区间积分。a 是平均值参数，并未假设每个可观测量都有极限。atTop 的最终正时间使负时延拓和 T=0 不影响结论；原文的轨道及光滑性背景不被误写成极限自动存在的定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.hasTimeAverage`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1327)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-ConservedAverage · unnumbered_claim · 印刷p.196–197 / PDFp.217–218

### 2. 原文陈述

> Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $`I=I(z)`$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conservedAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : MolecularDynamics.Chapter05Review.timeAverage z g T=a := by
  apply MolecularDynamics.Chapter05Review.conservedAverage_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.conservedAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀X,z,g,a，前提 ∀t∈ℝ,g(z t)=a，结论对每个非零实数 T 为有限时间平均=a。任意负 T 的有向积分也满足该恒等式；T≠0 必须保留，因为 T=0 时总化平均为0。此条按 scope 是守恒观测量的有限平均辅助引理；原文第一积分及其函数的无限时间结论映射至下一条，并非遗漏后仍宣称完成全部原文结论。比正时间轨道更强的全实时间守恒前提是明确延拓，实际第一积分满足。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.conservedAverage`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1333)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-ConservedInfiniteAverage · unnumbered_claim · 印刷p.196–197 / PDFp.217–218

### 2. 原文陈述

> Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $`I=I(z)`$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conservedInfiniteAverage {X : Type*} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  MolecularDynamics.Chapter05Review.hasTimeAverage z I (I (z 0)) ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z (r ∘ I) (r (I (z 0))) := by
  have hm (g : X → ℝ) (hg : ∀ t,g (z t)=g (z 0)) :
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) := by
    apply tendsto_congr' _ |>.2 tendsto_const_nhds
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    exact MolecularDynamics.Chapter05Review.conservedAverage_proved z g (g (z 0)) hg T (ne_of_gt hT)
  exact ⟨hm I hI,hm (r ∘ I) (fun t => by simp only [Function.comp_apply,hI])⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.conservedInfiniteAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀X,z,I,r，hI 要求每个实时间的 I(z t)=I(z 0)。完整合取分别给出 I 的无限平均 I(z 0)，以及任意函数 r∘I 的无限平均 r(I(z 0))。不需 r 连续或可测，因为沿此轨道两个被积函数都恒定；不存在把“复合量有平均”作为前提的问题。结果准确表达平均由初值的积分值决定，不承诺不同初值一定产生不同平均；例如常值 r 的平均可以相同。

### 7. 状态与证明位置

self-contained；`MD.Ch05.conservedInfiniteAverage`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1338)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellEnergy · Example 5.3 · 印刷p.196 / PDFp.217

### 2. 原文陈述

> Example 5.3 Consider the double well potential $`\phi(q)=(1-q^2)^2`$. The energy $`H(q,p)=p^2/2+\phi(q)`$ will tend to $`+\infty`$ as $`q\to\infty`$ or $`p\to\infty`$, but is obviously bounded below (by zero).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E 2 是 Fin 2 上的实欧氏空间，z 0 对应 q、z 1 对应 p；定义严格为 p²/2+(1−q²)²。仅按 scope 核对公式定义：原文非负及趋于无穷的断言未包含于此定义，其映射的 DoubleWellCoercivity 不在本任务提供的声明中，因此不声称本次已核对该外部条目。定义对所有 z 总化，实数平方和不会引入额外域限制。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1351)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellCoercivity · unnumbered_claim · 印刷p.196 / PDFp.217

### 2. 原文陈述

> The energy $`H(q,p)=p^2/2+(1-q^2)^2`$ will tend to $`+\infty`$ as $`q\to\infty`$ or $`p\to\infty`$, but is obviously bounded below (by zero).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellCoercivity : (∀ z : MolecularDynamics.Chapter05Review.E 2,0 ≤ doubleWellEnergy z) ∧
  ∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} := by
  constructor
  · intro z
    unfold doubleWellEnergy
    positivity
  · intro c
    have hc : Continuous (doubleWellEnergy) := by unfold doubleWellEnergy; fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|+4)).of_isClosed_subset hclosed
    intro z hz
    have he : (z 1)^2/2+(1-(z 0)^2)^2 ≤ c := hz
    have hpos : 0 ≤ c := by nlinarith [sq_nonneg (z 1),sq_nonneg (1-(z 0)^2)]
    have hq : (z 0)^2 ≤ (c+3)/2 := by
      nlinarith [sq_nonneg (z 1),sq_nonneg ((z 0)^2-2)]
    have hp : (z 1)^2 ≤ 2*c := by nlinarith [sq_nonneg (1-(z 0)^2)]
    have hnorm : ‖z‖^2=(z 0)^2+(z 1)^2 := by
      rw [EuclideanSpace.norm_sq_eq]
      simp [Fin.sum_univ_two,Real.norm_eq_abs]
    rw [Metric.mem_closedBall,dist_zero_right,abs_of_nonneg hpos]
    nlinarith [norm_nonneg z]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellCoercivity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。 | [EXTRA] |

[EXTRA] [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义，不要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目依赖 MolecularDynamics/Chapter05/ReviewDefinitions.lean（Ch05\_deps.txt 第5315行）展开 E n=EuclideanSpace ℝ (Fin n)，按标准含义是具有欧氏内积与拓扑的 ℝⁿ；Blueprint/Ch05.lean 第968行的 MD.Ch05.doubleWellEnergy 展开为 p²/2+(1-q²)²，其中 q=z 0、p=z 1。 Blueprint/Ch05.lean 第972–993行结论为(∀z,0≤H(z))与(∀c∈ℝ,{z|H(z)≤c}紧)的合取。IsCompact 按标准欧氏紧性理解；能量为连续多项式，其闭下水平集在有限维空间紧，等价于通常的强制性，涵盖原文 q→+∞ 或 p→+∞ 时 H→+∞（另一坐标固定或任意变化），并合理推广到任意坐标逃逸。c<0 时下水平集为空，紧性仍成立，无能级遗漏。[EXTRA]实际是性质的等价表达说明，而非签名中的附加前提；没有给一般势函数添加未经论证的强制性。两个原文结论均被表达，无[ERRATUM?]。证明状态单独记录：本条实际正文未出现 sorry/admit；仅做只读语义审计，未运行 Lean 编译，也未核验整个项目的公理依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellCoercivity`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1355)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellDisconnected · Example 5.3 · 印刷p.196 / PDFp.217

### 2. 原文陈述

> From the graph it is clear that the energy surface $`H(q,p)=E`$ has more than one component if $`0\lt E\lt 1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellDisconnected : ∀ c ∈ Ioo (0 : ℝ) 1,
  ¬IsPreconnected (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by
  intro c hc hS
  let a : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![-1,Real.sqrt (2*c)]
  let b : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![1,Real.sqrt (2*c)]
  have hsqrt : (Real.sqrt (2*c))^2=2*c := Real.sq_sqrt (by linarith [hc.1])
  have ha : a ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(-1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hb : b ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hq : ContinuousOn (fun z : MolecularDynamics.Chapter05Review.E 2 => z 0)
      (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by fun_prop
  have hzero : (0 : ℝ) ∈ Icc (a 0) (b 0) := by norm_num [a,b]
  obtain ⟨z,hz,hz0⟩ := hS.intermediate_value ha hb hq hzero
  change doubleWellEnergy z=c at hz
  unfold doubleWellEnergy at hz
  change z 0=0 at hz0
  rw [hz0] at hz
  nlinarith [sq_nonneg (z 1),hc.2]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellDisconnected` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义，不要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目依赖 MolecularDynamics/Chapter05/ReviewDefinitions.lean（Ch05\_deps.txt 第5315行）展开 E n=EuclideanSpace ℝ (Fin n)，按标准含义是具有欧氏内积与拓扑的 ℝⁿ；Blueprint/Ch05.lean 第968行的 MD.Ch05.doubleWellEnergy 展开为 p²/2+(1-q²)²，其中 q=z 0、p=z 1。 项目依赖 ReviewDefinitions.lean 第5355行展开 energySurface H c={z|H(z)=c}。Blueprint/Ch05.lean 第996–1015行量词 ∀c∈Ioo 0 1 正是对所有0<c<1。标准 ¬IsPreconnected 表达该能级作为拓扑子空间不连通；这里能级非空（例如 q=±1,p=√(2c)），因而与原文“more than one component”一致，不依赖空集约定。q=0 时 H=p²/2+1≥1，且能级同时含 q<0 和 q>0 两侧点，断开对象确实是整个能量面，并非投影或子集。无额外前提、无[EXTRA]/[ERRATUM?]。标准连通定义直接采信，不因依赖摘录不含其 Mathlib 定义体而降级。证明状态单独记录：本条实际正文未出现 sorry/admit；仅做只读语义审计，未运行 Lean 编译，也未核验整个项目的公理依赖。

### 7. 状态与证明位置

self-contained；`MD.Ch05.doubleWellDisconnected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1379)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4-DoubleWellBasin · unnumbered_claim · 印刷p.196 / PDFp.217

### 2. 原文陈述

> If an initial condition is taken from one of the two basins, say with energy $`E_0`$, then the trajectory through that point will remain forever in the one basin, thus the averages of many quantities, if computed using the trajectory values, would not be a good approximation of the overall average at constant energy $`E_0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem doubleWellBasin : ∀ (z : ℝ → MolecularDynamics.Chapter05Review.E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0) := by
  intro z c hz hc hE t
  let q (s : ℝ) := (z s) 0
  have hq : Continuous q := by dsimp [q]; fun_prop
  have hn (s : ℝ) : q s ≠ 0 := by
    intro heq
    have hh := hE s
    unfold doubleWellEnergy at hh
    change (z s) 0=0 at heq
    rw [heq] at hh
    nlinarith [sq_nonneg ((z s) 1),hc.2]
  by_cases h0 : 0 < q 0
  · left
    refine ⟨h0,?_⟩
    by_contra ht
    have hneg : q t < 0 := lt_of_le_of_ne (le_of_not_gt ht) (hn t)
    obtain ⟨s,hs⟩ := intermediate_value_univ t 0 hq (show (0 : ℝ) ∈ Icc (q t) (q 0) from ⟨hneg.le,h0.le⟩)
    exact hn s hs
  · right
    have hneg : q 0 < 0 := lt_of_le_of_ne (le_of_not_gt h0) (hn 0)
    refine ⟨hneg,?_⟩
    by_contra ht
    have hpos : 0 < q t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm (hn t))
    obtain ⟨s,hs⟩ := intermediate_value_univ 0 t hq (show (0 : ℝ) ∈ Icc (q 0) (q t) from ⟨hneg.le,hpos.le⟩)
    exact hn s hs

theorem doubleWellBasin_average_witness (c : ℝ) (_hc : c ∈ Ioo (0 : ℝ) 1)
    (z : ℝ → MolecularDynamics.Chapter05Review.E 2) (_hz : Continuous z)
    (_hE : ∀ t,doubleWellEnergy (z t)=c) :
    ∃ g : MolecularDynamics.Chapter05Review.E 2 → ℝ,ContDiff ℝ ∞ g ∧ HasCompactSupport g ∧
      (∀ x,doubleWellEnergy x=c → g x=if 0 < x 0 then (1 : ℝ) else 0) ∧
      MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g=1/2 ∧
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) ∧
      g (z 0) ≠ MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.doubleWellBasin`；`MD.Ch05.doubleWellBasin_average_witness` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。 | [EXTRA] |

[EXTRA] [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。；[EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；第一条声明量化所有连续实时间路径与 0<c<1 的守恒能量，结论对所有 t 同时保留初值及当前值的同一严格正号或同一严格负号。q=0 时能量≥1，故连续路径不能穿越，两阱结论完整。第二条声明在同样前提下存在全局 C∞ 紧支撑实值 g，在整个能量面上等于右阱的0/1分支值，且真实 microAverage=1/2、沿指定路径有无限平均 g(z0)、该平均不等于空间平均，三个结论均未作为前提。两条紧分离能量分支允许光滑截断；q↦−q 的欧氏等距对称保持能量、面测度及梯度范数，使两个分支质量相等且正有限。故该加强见证正确，不把全局不连续示性函数说成光滑函数，也未伪造“许多”的数量或误差界。

### 7. 状态与证明位置

incomplete；`MD.Ch05.doubleWellBasin`：已证；`MD.Ch05.doubleWellBasin_average_witness`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1404)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-UniformMicroErgodic · Definition 5.1 · 印刷p.197 / PDFp.218

### 2. 原文陈述

> Definition 5.1 A Hamiltonian system is said to be ergodic on an energy surface $`\Sigma_E`$ (microcanonically ergodic) if, for almost all trajectories $`\Gamma`$ emanating from initial conditions on $`\Sigma_E`$, and for any observable $`g`$, the following holds $`\bar g_\Gamma=\operatorname{Av}_{H=E}(g)`$, where $`\bar g_\Gamma`$ is defined in (5.9). By “almost all” we mean that there could be a low-dimensional subset for which the trajectory averages fail to equal the space averages.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)



/-- 修正版，对应原文 MD-5.4.1-UniformMicroErgodic。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def uniformMicroErgodic_corrected {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.uniformMicroErgodic`；`MD.Ch05.uniformMicroErgodic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ\_E零测资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ\_E零测资格。；[EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主谓词的量词顺序准确为对 microMeasure 几乎处处 z，再对每个全局 C∞ 且该测度可积的实值 g；结论是实际无限时间平均等于实际空间平均。flow 明确零时恒等、实时间群律与逐时 ODE 导数；另有 H∈C²、全空间能量保持、非空紧正则面及正有限质量，并用常可逆反对称矩阵 J 指定 f=J∇H。这些 [EXTRA] 均在接口中，紧能量面上光滑 g 可积并不实质删去原文光滑观测量。问题在原书把 almost all 用 low-dimensional subset 解释：测度零与低维条件不能一般等同，Lean 未出现维数谓词。按通常微正则零测解释签名正确；若原文要求异常集严格低维则尚不忠实，需人工确定，不能静默裁定原书。

### 7. 状态与证明位置

self-contained；`MD.Ch05.uniformMicroErgodic`：定义；`MD.Ch05.uniformMicroErgodic_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1446)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-MicroErgodicStandard · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> for almost all trajectories $`\Gamma`$ emanating from initial conditions on $`\Sigma_E`$, and for any observable $`g`$, the following holds $`\bar g_\Gamma=\operatorname{Av}_{H=E}(g)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)

def microErgodic_L1_alternative {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.microErgodic`；`MD.Ch05.microErgodic_L1_alternative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。 | [EXTRA] |

[EXTRA] [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。；[EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主 microErgodic 与上一条共同满测集的 C∞ 版本相同，完整保留 AE z 后 ∀g 以及 flow、正则面、C²、能量保持、常非退化反对称 J 等所有参数前提。额外 microErgodic\_L1\_alternative 的顺序是 ∀g，Integrable g μ→AE z，允许不同 g 有不同异常集，且只要求 L¹ 而不要求光滑；该声明仅定义替代性质，不断言与主定义等价。它无 Hamiltonian/概率前提，故只能视为一般测度映射的性质，单独使用时不能保证动力系统背景；应在注释中明确。本条摘录本身没有 low-dimensional 句，故此处无该句的维数承诺。

### 7. 状态与证明位置

self-contained；`MD.Ch05.microErgodic`：定义；`MD.Ch05.microErgodic_L1_alternative`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1476)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-FlowInvariant · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> An invariant set $`\mathcal A`$ of the flow is one such that $`\mathcal F_t(\mathcal A)=\mathcal A`$, for all $`t\ne0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.flowInvariant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。 | [EXTRA] |

[EXTRA] [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。；[EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意类型 X、任意 Φ:ℝ→X→X 和 A:Set X，定义恰为 ∀t,t≠0→Φ t''A=A，使用集合像而非原像/包含关系。没有默加 t=0，也不声称任意 Φ 自动具有流律。真实流满足 Φ0=id 时，才与全时间像不变等价。旧第一条 EXTRA 声称当前实现使用全时间条件，与实际 MD 定义冲突，已仅修正文档；Lean 声明本身通过。

### 7. 状态与证明位置

self-contained；`MD.Ch05.flowInvariant`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1495)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-SetErgodic · definition · 印刷p.197 / PDFp.218

### 2. 原文陈述

> Alternatively, we may say that a dynamical system as ergodic if the probability measure of any invariant set $`\mathcal A`$ of the flow is either 0 or 1.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.setErgodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。 | [EXTRA] |

[EXTRA] [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。；[EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；X 带可测空间，μ 为概率测度；Φ 有零时恒等、所有实 s,t 的群律和联合可测性。结论只量化可测集合 A，以实际 Chapter05Review.flowInvariant（全实时间像相等）为前提，要求 μ A=0 或 μ A=1。因 h0，全时间不变与本批 MD.flowInvariant 的 t≠0 条件等价，命名空间差异不会改变真实流上的语义。可测性限制是概率集合定义的合理明确化。签名没有 MeasurePreserving 前提，因此本次仅批准原句的0/1定义，不把它当作已证明与时间平均相等的等价定理；建立这种等价通常还需保测等背景。原书 as ergodic 的语法错误应原样保留，不属数学修正。

### 7. 状态与证明位置

self-contained；`MD.Ch05.setErgodic`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1500)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InvariantIndicator · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> Then for any trajectory starting in $`\mathcal A`$, we have that the average of $`\chi`$ along $`\Gamma`$ vanishes, i.e. $`\bar\chi_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau\chi(z(t))dt=0`$, since $`\mathcal A`$ is an invariant set.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem invariantIndicator {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0 := by
  apply MolecularDynamics.Chapter05Review.invariantIndicator_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.invariantIndicator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。 | [EXTRA] |

[EXTRA] [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意 X,Φ,A，全时间集合像不变 h，以及 z∈A、任意实数 t；结论为 ambient 补集 Aᶜ 的常1示性函数在 Φt z 处=0。由 Φt''A=A 即有 Φt z∈A，不需可测性、可积性或 flow 群律。此沿轨道结论与原书能量面内补集示性函数一致，因为路径始终留在 A；不宣称两个示性函数在能量面外相等。scope 明确此条只给逐点辅助结论，完整无限平均另条承担。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.invariantIndicator`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1509)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InvariantIndicatorAverage · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> $`\bar\chi_\Gamma=\lim_{\tau\to\infty}\tau^{-1}\int_0^\tau\chi(z(t))dt=0`$, since $`\mathcal A`$ is an invariant set.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem invariantIndicatorAverage {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (hA : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) :
  MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) (Aᶜ.indicator (fun _ => (1 : ℝ))) 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.invariantIndicatorAverage` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数为任意 X,Φ,A、全时间集合像不变 hA、初值 z∈A；完整结论是实际 hasTimeAverage (fun t=>Φ t z) (Aᶜ.indicator 1) 0，已包含 Tendsto、0..T 积分及归一化，不仅是逐点等式或有限平均。像不变性保证轨道全时刻在 A，从而被积函数恒零，故无须额外可测或连续前提。使用全时间 Chapter05Review.flowInvariant；在真实流背景下和原印 t≠0 等价。sorry 不影响本次签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch05.invariantIndicatorAverage`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1515)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-ErgodicTimeEquivalence · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> If we assume the system is ergodic, we must have $`\operatorname{Pr}(\Sigma_E\setminus\mathcal A)=0`$, thus $`\operatorname{Pr}(\mathcal A)=1`$. Since, according to the definition, equality of time and space averages is allowed to fail only on a set of probability measure zero, we have that either $`\operatorname{Pr}(\mathcal A)=0`$ or $`\operatorname{Pr}(\mathcal A)=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ergodicTimeAverage :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_common_smooth (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n))
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hμ : IsProbabilityMeasure μ) (_hpres : ∀ t,MeasurePreserving (Φ t) μ μ)
    (_h0 : ∀ z,Φ 0 z=z) (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hΦ : Continuous (Function.uncurry Φ))
    (_hK : ∃ K : Set (MolecularDynamics.Chapter05Review.E n),IsCompact K ∧ μ Kᶜ=0) :
    (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
      ∀ᵐ z ∂μ,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
        ContDiff ℝ ∞ g → Integrable g μ →
          MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z) g
            (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_positive_invariant (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_herg : MolecularDynamics.Chapter05Review.setErgodic μ Φ)
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) :
    μ A=1 ∧ (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-ErgodicTimeEquivalence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem ergodicTimeAverage_corrected :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.ergodicTimeAverage`；`MD.Ch05.ergodicTimeAverage_common_smooth`；`MD.Ch05.ergodicTimeAverage_positive_invariant`；`MD.Ch05.ergodicTimeAverage_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。；[EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；已分别核对ergodicTimeAverage、ergodicTimeAverage\_common\_smooth、ergodicTimeAverage\_positive\_invariant。E n为任意有限维实欧氏空间；第一条在概率测度、每个实时间保测、零时恒等、全实时间群律及联合可测前提下，给出严格不变可测集的0/1性质与“每个L¹实观测量各自几乎处处具有空间均值时间平均”的双向等价；积分为真实0到T区间积分，极限为T→+∞。第二条另要求联合连续及紧支撑，结论确实把AE置于所有C∞实观测量之前，这些增加的条件已经[EXTRA]公开，不能把第二条当成第一条无条件交换量词。第三条显式要求可测不变集A有正概率，结论同时包含μ(A)=1、所有实时间轨道留在A、补集指标函数的实际时间平均为0；未把这些结论作假设。三条修订/扩展签名合理。本条PASS只涉及这些明确声明，不认可原书省略正概率分支的中间推理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.ergodicTimeAverage`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_common_smooth`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_positive_invariant`：未证（原书疑误不证）；`MD.Ch05.ergodicTimeAverage_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1524)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-NonergodicSet · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> If a system is not ergodic, then there will be an invariant set $`\mathcal A`$ whose probability measure is strictly between zero and one. The trajectories emanating from this set are unable to explore the entire energy surface and the corresponding trajectory averages will, at least for some observables, be different than the spatial average of that observable.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem nonergodicSet :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (¬MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
    ∃ A : Set (MolecularDynamics.Chapter05Review.E n),MeasurableSet A ∧ MolecularDynamics.Chapter05Review.flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1) := by
  sorry

theorem nonergodicSet_average_witness (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) (_hlt : μ A < 1) :
    (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) ∧
    MolecularDynamics.Chapter05Review.average μ (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) ≠ 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.nonergodicSet`；`MD.Ch05.nonergodicSet_average_witness` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。 | [EXTRA] |

[EXTRA] [EXTRA] 补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对nonergodicSet及nonergodicSet\_average\_witness。第一条对任意n、概率μ及实时间作用Φ，把非setErgodic准确展开为存在可测、严格流不变且0<μ A<1的集合；概率性保证不存在大于1或无限质量的遗漏分支。第二条对任意这样的A和实际群作用，结论逐一包含所有z∈A及所有t的轨道保持、补集实值指标的0到T时间平均趋于0，以及该指标的空间积分非0。后者由μ(Aᶜ)>0给出，与源文“至少某些观测量”相符；没有把平均不等式预先作假设。测度可集中在能量面，E n的环境空间参数化没有把μ误当Lebesgue测度。

### 7. 状态与证明位置

incomplete；`MD.Ch05.nonergodicSet`：未证（缺大型理论）；`MD.Ch05.nonergodicSet_average_witness`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1577)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-HarmonicFlow · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def harmonicFlow (Ω t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicFlow` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。 | [EXTRA] |

[EXTRA] [EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅原系统推导的辅助解析流；原遍历结论由MD-5.4.1-HarmonicErgodic承担，频率正及能量正按该定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；本条只有harmonicFlow定义，输入Ω,t∈ℝ和z∈E 2，输出仍为E 2；坐标顺序为(q,p)。两个分量分别为q cos(Ωt)+(p/Ω)sin(Ωt)和p cos(Ωt)−Ωq sin(Ωt)，非零频率时是单位质量振子的正确解析流，正负非零频率均适用。[EXTRA]与statement\_scope已明确本条只是辅助定义，原句的能量面遍历性分配给MD-5.4.1-HarmonicErgodic，故不把这个def当成遍历定理。该外部source\_id的声明未在R6给出，本次未核查其结论或证明。Ω=0处Lean除零总化得到恒等映射，不代表零频自由粒子的流；原有正频率使用限定是必要的。

### 7. 状态与证明位置

self-contained；`MD.Ch05.harmonicFlow`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1598)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-HarmonicErgodic · unnumbered_claim · 印刷p.198 / PDFp.219

### 2. 原文陈述

> As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem harmonicErgodic : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microErgodic (harmonicEnergy Ω) c (harmonicFlow Ω) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.harmonicErgodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。 | [EXTRA] |

[EXTRA] [EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目依赖Chapter05/ReviewDefinitions.lean实际展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z|H z=c}；grad H=gradient H；hausdorffArea d=[vol(B₁⊂Rᵈ)/2ᵈ]·HausdorffMeasure d；surfaceMeasure=(hausdorffArea(n−1)).restrict(energySurface H c)；microRaw=surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure=(microRaw univ)⁻¹·microRaw；average μ g=∫g dμ；microAverage H c g=average(microMeasure H c)g。附件本地harmonicEnergy=(p²+Ω²q²)/2，harmonicFlow是上条解析流。项目timeAverage=T⁻¹∫₀ᵀg(Φt z)dt，hasTimeAverage是该函数在atTop收敛到指定平均。microErgodic实际量词为∀g,Integrable g μ→∀ᵐz,hasTimeAverage(Φ·z)g(∫g dμ)。量词没有被误读为∀ᵐz∀g；[EXTRA]明确选取标准逐个L¹观测量版本。Ω>0排除退化频率，符号限制可由Ω↦|Ω|消除；c>0限定非退化能量曲线，在该椭圆上梯度非零，microRaw有限正，microMeasure是真概率测度。轨道覆盖整条椭圆且周期为2π/Ω；ds/‖∇H‖等于时间元，所以空间平均等于归一化周期平均。光滑观测量在所有初值上都得到该周期平均，亦符合原文共同满测集的光滑解释。或者以紧椭圆上连续函数的可数一致稠密族及一致逼近恢复共同满测集。因此量词改为标准L¹版本在此具体系统中没有导致语义反例。PASS范围为声明的正频率、正能量；不声称梯度零的零能量点也适用此microMeasure构造。证明体为sorry，故PASS仅指签名语义，不指Lean证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.harmonicErgodic`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1604)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorEnergy · Example 5.4 · 印刷p.198–199 / PDFp.219–220

### 2. 原文陈述

> Example 5.4 (2D Harmonic System) Consider a two-dimensional harmonic system, i.e. the system with Hamiltonian

$$
H=p_1^2/2+p_2^2/2+\Omega_1^2q_1^2/2+\Omega_2^2q_2^2/2;
$$


> where $`\Omega_1,\Omega_2`$ are two nonzero parameters. Because the two systems involving $`q_1,p_1`$ and $`q_2,p_2`$ are not coupled in the equations of motion, this system has two invariants $`H_1=p_1^2/2+\Omega_1^2q_1^2/2`$ and $`H_2=p_2^2/2+\Omega_2^2q_2^2/2`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅两项分能量H₁/H₂定义；总能量分解由MD-5.4.1-TwoOscillatorEnergyDecomposition，分能量不变性由MD-5.4.1-TwoOscillatorTori承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；twoOscillatorEnergy的Ω:Fin 2→ℝ、i:Fin 2、z:E 4均与两个子系统相符。Fin.castAdd 2 i取下标0、1的q\_i，Fin.natAdd 2 i取下标2、3的p\_i，故在(q₁,q₂,p₁,p₂)顺序下确为p\_i²/2+Ω\_i²q\_i²/2。这个多项式定义对零频率也有意义，较原非零参数域的总延拓不造成虚假动力学结论。本条公开范围仅是H₁、H₂定义；总能量用两项求和表示（条目7），全初值不变性已经由本批条目5的定理承担。未把单个def当作独立证明总能量守恒或二维环面拓扑。

### 7. 状态与证明位置

self-contained；`MD.Ch05.twoOscillatorEnergy`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1610)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorFlow · unnumbered_claim · 印刷p.199 / PDFp.220

### 2. 原文陈述

> Because the two systems involving $`q_1,p_1`$ and $`q_2,p_2`$ are not coupled in the equations of motion, this system has two invariants $`H_1=p_1^2/2+\Omega_1^2q_1^2/2`$ and $`H_2=p_2^2/2+\Omega_2^2q_2^2/2`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E 4) : MolecularDynamics.Chapter05Review.E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]

theorem twoOscillatorFlow_invariants (Ω : Fin 2 → ℝ) (_hΩ : ∀ i,Ω i ≠ 0)
    (z : MolecularDynamics.Chapter05Review.E 4) (t : ℝ) (i : Fin 2) :
    twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=twoOscillatorEnergy Ω i z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorFlow`；`MD.Ch05.twoOscillatorFlow_invariants` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留解析流并补任意初值（包括零分能量退化层）的两个真实分能量不变量，不再只依赖正共同层的Tori结论。原非零频率资格显式。 | [EXTRA] |

[EXTRA] [EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。；[EXTRA] 保留解析流并补任意初值（包括零分能量退化层）的两个真实分能量不变量，不再只依赖正共同层的Tori结论。原非零频率资格显式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对twoOscillatorFlow及twoOscillatorFlow\_invariants。四维状态确按(q₁,q₂,p₁,p₂)排列；每个q分量只使用相应p和Ω，两个p分量分别带−Ω\_i q\_i sin(Ω\_i t)，未交换下标或符号。不变量定理要求∀i,Ω\_i≠0，随后对任意初值z、任意实时间t和任意i断言H\_i(Φ\_t z)=H\_i(z)，包含零分能量的退化层，并非仅在正能量共同层上给出条件结论。这覆盖了原句的两个不变量；源文没有给出显式流公式，该公式是已公开的派生构造。

### 7. 状态与证明位置

incomplete；`MD.Ch05.twoOscillatorFlow`：定义；`MD.Ch05.twoOscillatorFlow_invariants`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1616)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

