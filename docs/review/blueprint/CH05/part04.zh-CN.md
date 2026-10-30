[上一部分](part03.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## 1. MD-5.4.1-TwoOscillatorTori · Example 5.4 · 印刷p.199 / PDFp.220

### 2. 原文陈述

> For any $`E_1,E_2\gt 0`$, the set of points satisfying $`H_1=E_1,H_2=E_2`$ is a two-dimensional torus. If the frequencies $`\Omega_1`$ and $`\Omega_2`$ are not rationally related (i.e. $`\Omega_1/\Omega_2`$ is an irrational number), then for any $`E_1,E_2`$ the torus will eventually be filled in by any trajectory. On the other hand, the energy surface $`H=E`$ is the union of all such 2-tori with $`E_1+E_2=E`$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem twoOscillatorTori : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {z : MolecularDynamics.Chapter05Review.E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1 × Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬MolecularDynamics.Chapter05Review.setErgodic (MolecularDynamics.Chapter05Review.microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω)) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-TwoOscillatorTori。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem twoOscillatorTori_corrected : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {z : MolecularDynamics.Chapter05Review.E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1 × Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬MolecularDynamics.Chapter05Review.setErgodic (MolecularDynamics.Chapter05Review.microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorTori`；`MD.Ch05.twoOscillatorTori_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目依赖Chapter05/ReviewDefinitions.lean实际展开：E n=EuclideanSpace ℝ (Fin n)；energySurface H c={z|H z=c}；grad H=gradient H；hausdorffArea d=[vol(B₁⊂Rᵈ)/2ᵈ]·HausdorffMeasure d；surfaceMeasure=(hausdorffArea(n−1)).restrict(energySurface H c)；microRaw=surfaceMeasure.withDensity(ofReal(‖grad H‖⁻¹))；microMeasure=(microRaw univ)⁻¹·microRaw；average μ g=∫g dμ；microAverage H c g=average(microMeasure H c)g。本地Hᵢ和Φ分别展开为上述分能量及无耦合旋转。签名∀Ω,c，∀i Ωᵢ≠0且cᵢ>0，然后令T={z|∀i,Hᵢ(z)=cᵢ}；其合取项分别是T与两个欧氏单位圆的积同胚、∀z∈T∀t∀i的分能量保持、Ω₁/Ω₂无理时每条全实时间轨道闭包等于T、以及∀E>0的总能量微正则非遍历性。项目flowInvariant Φ A=∀t,Φt ''A=A；setErgodic μ Φ=∀可测A,flowInvariant Φ A→μA=0∨μA=1。这些对象和量词均准确；正分能量及非零频率是非退化2-torus所需，“filled in”解释为稠密而非有限时间覆盖合理。但原文“总能量面是全部这类层的并”的分解结论不在本定理的四个合取项中；[EXTRA]指出退化圆，却没有在本lean\_decl写出包括它们的分解。原书按正分能量2-tori穷尽整面存在确定边界漏项，须明示勘误而非静默改变原文。FAIL是结论缺项；证明体sorry单独记录，标准Hausdorff测度/积分未提供定义体不是判定理由。

### 7. 状态与证明位置

incomplete；`MD.Ch05.twoOscillatorTori`：未证（原书疑误不证）；`MD.Ch05.twoOscillatorTori_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1630)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-Mixing · definition · 印刷p.199 / PDFp.220

### 2. 原文陈述

> An even stronger property than the ergodic property is the concept of a mixing system. For a mixing system, the finite time density $`\rho(z;t)`$ converges, in the weak sense, to the invariant distribution $`\rho_\infty(z)`$, as $`t\to\infty`$. That is, we have, for all test functions $`\phi`$ in some chosen space

$$
\lim_{t\to\infty}\langle\phi,\rho(\cdot;t)\rangle=\langle\phi,\rho_\infty\rangle.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (IsProbabilityMeasure μ ∧ (∀ t, MeasurePreserving (Φ t) μ μ) ∧ (∀ z,Φ 0 z=z) ∧
    (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) ∧ Measurable (Function.uncurry Φ)) ∧
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakMixing` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。 | [EXTRA] |

[EXTRA] [EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。；[EXTRA] 混合定义在谓词内记录概率参考测度、零时恒等、群律、联合可测实际流；保留AC初始概率与有界连续测试配对。相关已有证明取第二合取后重查。；[EXTRA] 补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。

### 6. 审计结论

本轮修复：补全部实时间的MeasurePreserving，μ明确为不变概率参考分布。weakMixing为兼容保留的名称，含义是密度在有界连续测试下的弱收敛，不用作标准术语“弱混合”。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；weakMixing的概率μ、零时恒等、全实时间群律、联合可测均已写在第一合取内。第二合取对所有L¹、逐点非负、积分为1的初始密度r，以及所有有界连续实测试函数φ，要求∫φ(Φ\_t z)r(z)dμ→∫φdμ；这准确表达了AC初始概率分布的弱收敛，测试函数与初始密度的量词及极限方向正确。但定义既没有∀t,MeasurePreserving (Φ t) μ μ，也没有足以从弱收敛推出不变性的空间连续性条件。因此μ不一定是源文及[EXTRA]所说的不变参考分布。下面的联合可测群作用满足整个当前谓词，却不保持μ。此外weakMixing这个名称不能按标准术语读作“弱混合”；这里本来意图表达的是混合导致分布弱收敛。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakMixing`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1661)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-KAMPersistence · unnumbered_claim · 印刷p.200 / PDFp.221

### 2. 原文陈述

> The energy surface is three-dimensional (represented as the zero-set of a single constraint in four-dimensional space), but apparently it bifurcates into a collection of isolated components (bounded by two-dimensional closed surfaces). These are none other than the tori predicted by the KAM theory [386].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kam :
  ∀ n (H0 : MolecularDynamics.Chapter05Review.E n → ℝ) (P : MolecularDynamics.Chapter05Review.Phase n → ℝ) (I0 : MolecularDynamics.Chapter05Review.E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → MolecularDynamics.Chapter05Review.periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → MolecularDynamics.Chapter05Review.diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=MolecularDynamics.Chapter05Review.hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-KAMPersistence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem kam_corrected :
  ∀ n (H0 : MolecularDynamics.Chapter05Review.E n → ℝ) (P : MolecularDynamics.Chapter05Review.Phase n → ℝ) (I0 : MolecularDynamics.Chapter05Review.E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → MolecularDynamics.Chapter05Review.periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → MolecularDynamics.Chapter05Review.diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=MolecularDynamics.Chapter05Review.hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.kam`；`MD.Ch05.kam_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。项目E n=Rⁿ，Phase n=E n×E n。依赖hamiltonianField H(q,p)=(∇pH,−∇qH)；periodicPerturbation P为P(q+k,p)=P(q,p)（∀整数向量k）；diophantine ω κ τ为κ>0、τ>n−1及∀k≠0,κ/(1+‖k‖)^τ≤|k·ω|。附件1146–1158在n>0、全域解析H₀,P、周期扰动、I₀处频率映射导数双射、上述Diophantine条件下，量化∃δ>0∀|ε|<δ∃K；K为C¹、导数逐点单射、整数平移等变、DK·∇H₀(I₀)=X_{H₀+εP}∘K，且作用量距I₀<1。[EXTRA]的解析近可积资格和非退化性合理；这是通用KAM背景命题。但所引原文是特定双摆的三维能量面、隔离区域及图示环面的叙述；本签名没有该双摆、指定能量或其KAM适用资格的验证，[EXTRA]还明确不声称双摆参数满足资格。因此并非当前statement\_scope下完整原句的忠实形式化。导数单射本身只表示浸入；半共轭等式还须结合周期等变、Diophantine稠密性及光滑ODE唯一性来理解全局嵌入/共轭，不能用任意自交浸入充当满足全部条件的反例。本轮FAIL仅由确切来源对象与结论缺失支撑。原书components也未被静默提升为拓扑连通分支断言。证明体为sorry；标准解析性或导数定义未出现在摘录中不影响上述审计。

### 7. 状态与证明位置

incomplete；`MD.Ch05.kam`：未证（原书疑误不证）；`MD.Ch05.kam_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1671)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicPotential · Example 5.6 · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Example 5.6 (Anisotropic Oscillator) The anisotropic oscillator was used in Chap. 1 to illustrate the concept of a chaotic dynamical system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def anisotropicPotential (κ l ε : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicPotential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信Lean 4.34.0 / Mathlib v4.34.0的标准含义：EuclideanSpace为带欧氏内积的实坐标空间，volume为标准Lebesgue测度，积分为Bochner积分（不可积时取0），限制测度、withDensity、ENNReal.ofReal、连续性、闭包、同胚、梯度和Fréchet导数均采用标准数学含义；不要求这些库定义出现在项目依赖摘录。附件1161–1162调用项目Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0。依赖Chapter01/ReviewDefinitions.lean实际展开anisotropicAngular：r=√(x²+y²)，c=x/r，c₃=4c³−3c；anisotropicParameters=(κ(1−εc₃/2),l(1+εc₃/2))；anisotropicEnergy=(v²+w²)/2+κ(1−εc₃/2)(r−l(1+εc₃/2))²/2。令v=w=0取得原第1章模型的势能，E 2为位置欧氏平面；与context\_notation明确限定的零速度势一致。不把历史性的混沌模型回引误当作本def证明混沌。原点的总化除法是既有定义的延拓约定，本条没有声称原点解析性，也没有额外物理假设。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.anisotropicPotential`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1707)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicAxisPrinted · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $`E_0`$, with positions in a small interval on the positive $`x`$ axis, $`1.05\le x\le1.15`$ and $`y=0`$. For each point $`(x,0)`$ taken from this set select the initial velocities as $`\dot x=0`$, $`\dot y=[2(E_0-U(x,0))]^{1/2}`$. The set $`y=0`$, $`\dot y=0`$ is invariant under the differential equations of the perturbed central force problem, since the force acts in the radial direction; our choice of initial conditions ensures that trajectories explore the larger $`H=E_0`$ energy surface.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem anisotropicAxisPrinted : ∀ (κ l ε : ℝ) (z : ℝ → MolecularDynamics.Chapter05Review.Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0 := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-AnisotropicAxisPrinted。改动：只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。 -/
```

独立修正版：

```lean
theorem anisotropicAxisPrinted_corrected : ∀ (κ l ε : ℝ) (z : ℝ → MolecularDynamics.Chapter05Review.Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (∀ t, (z t).1 ≠ 0) → (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicAxisPrinted`；`MD.Ch05.anisotropicAxisPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。 | [EXTRA] |

[EXTRA] [EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。；[ERRATUM?] 只在整条经典轨道避开原点的光滑域内给轴不变性；原点的范数势不可微资格不能省去。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。声明对任意 κ₀,l₀>0、任意实 ε 以及任意全实时间 C¹ 相空间轨道 z，假定 z′=(p,−∇U(q))、y(0)=p\_y(0)=0，推出所有实 t 的 y(t)=p\_y(t)=0。该签名刻画轴不变性，没有把该结论作前提；但原文 statement\_scope 包含能量 E₀、给定短区间初值与“ensures ... explore the larger H=E₀ energy surface”，本声明不含这些初值约束和探索条款，不能把整段原句判为覆盖完整。初值构造已另有条目，不等于此声明包含了缺失结论。[EXTRA]正基准参数是合理物理资格，全时间轨道限制须区分于经典局部解；并且正基准参数不保证任意 ε 下有效参数为正。展开的势含角向依赖，故原书径向力理由一般不成立；远离原点的轴上则有反射对称性，可用于局部轴不变结论。全局签名未区分原点处总定义的 Lean gradient 与经典可微势，宜另加有效定义域资格。FAIL 的确定依据是全条覆盖缺失和原书理由的显式问题，无须因标准库定义缺失转为 NEEDS\_HUMAN。声明体为 sorry；这与签名语义分开记录。

### 7. 状态与证明位置

incomplete；`MD.Ch05.anisotropicAxisPrinted`：未证（原书疑误不证）；`MD.Ch05.anisotropicAxisPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1713)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-TwoOscillatorEnergyDecomposition · unnumbered_claim · 印刷p.199 / PDFp.220

### 2. 原文陈述

> On the other hand, the energy surface $`H=E`$ is the union of all such 2-tori with $`E_1+E_2=E`$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem twoOscillatorEnergyDecomposition : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-TwoOscillatorEnergyDecomposition。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem twoOscillatorEnergyDecomposition_corrected : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.twoOscillatorEnergyDecomposition`；`MD.Ch05.twoOscillatorEnergyDecomposition_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]包括c\_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]包括c\_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅含零分能量退化边界的静态能量层分解；正层拓扑/不变性/非遍历由MD-5.4.1-TwoOscillatorTori承担并保留其原书退化层疑误待导师。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；twoOscillatorEnergyDecomposition逐点量化任意实频率Ω、任意实E和z:E 4。左侧是两个真实分能量之和等于E；右侧存在c:Fin 2→ℝ，各c\_i非负、总和等于E且逐项H\_i(z)=c\_i。各H\_i是平方项之和，故取c\_i=H\_i(z)得到这一双向分解；E<0时两侧均不能成立，E=0时也没有被排除。这是正确的、含边界退化层的静态修订。[EXTRA]与statement\_scope已明确不在本条断言各层都是二维环面、轨道稠密性或非遍历性；这些额外结论不能由当前静态等价式获得。本条签名PASS不改变原书关于“all such 2-tori”的疑误，外部TwoOscillatorTori未在本批复核。

### 7. 状态与证明位置

incomplete；`MD.Ch05.twoOscillatorEnergyDecomposition`：未证（原书疑误不证）；`MD.Ch05.twoOscillatorEnergyDecomposition_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1736)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CurveImageDimension · unnumbered_claim · 印刷p.202 / PDFp.223

### 2. 原文陈述

> The segment of initial conditions, a one-dimensional object, when transformed by the smooth map defined by solving initial value problems, should result, again, in a one-dimensional object, i.e. a curve. Yet it appears also to provide a dense covering of a two-dimensional region in the position projection.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem curveImageDimension : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (γ : ℝ → MolecularDynamics.Chapter05Review.E n),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ ∞ (Function.uncurry Φ) → ContDiff ℝ ∞ γ →
  (∀ s,deriv γ s ≠ 0) → ∀ t,
  ContDiff ℝ ∞ (fun s => Φ t (γ s)) ∧ (∀ s,deriv (fun r => Φ t (γ r)) s ≠ 0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.curveImageDimension` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |

[EXTRA] [EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；curveImageDimension对任意n、向量场f、全实时间流Φ和γ:ℝ→E n量化。flow依赖确实包含零时恒等、群律及轨道微分方程；另有Φ的联合C∞、γ的C∞和所有参数处deriv γ≠0。结论对每个固定实时间t给出像参数曲线的C∞及处处非零导数。群律使Φ\_t与Φ_−t互为逆，其光滑微分互逆，故不会把非零切向量压为0；这不是把结论正则性预先作为假设。γ全实参数及正则性是已公开的精确版本，蕴含区间上的局部曲线结论。[EXTRA]准确区分相空间的正则曲线和位置投影；没有断言投影仍浸入或有限时间曲线覆盖二维开集。原句“appears”是数值外观的描述，未被强化为数学稠密性定理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.curveImageDimension`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1756)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-PendulumPotential · Example 5.5 · 印刷p.200 / PDFp.221

### 2. 原文陈述

> Example 5.5 (Double Pendulum) To explore some of the issues related to ergodicity, let us return to the double pendulum considered in Chap. 3.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : MolecularDynamics.Chapter05Review.E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.pendulumPotential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。 | [EXTRA] |

[EXTRA] [EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；pendulumPotential输入四个实参数及二维位置q，给出k₁/2·(r₁−l₁)²+k₂/2·(r₂−l₂)²。r₁²=x²+y²，r₂²=x²+(y+2)²，故第二固定端确为(0,−2)，不是(0,2)。与本条context\_notation及[EXTRA]摘录的第3章真实双弹簧势完全一致。函数对任意实参数作多项式/平方根表达式的总延拓；物理使用时要求正弹簧系数和正自然长度，不影响定义本身的正确性。本条没有形式化整个Example 5.5的数值非遍历现象。本次另查同目录原书PDF148只用于核实已在本条明确回指的公式；没有使用旧项目定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.pendulumPotential`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1764)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-PendulumRegionPrinted · unnumbered_claim · 印刷p.200 / PDFp.221

### 2. 原文陈述

> For given positive values of the coefficients, the region swept out in the plane by trajectories can be seen to be a union of intersections of pairs of disks centered at the origin and $`(0,-2)`$, with radii $`r_1,r_2`$ respectively, which themselves represent a point on an ellipse in the first quadrant. Determining the boundary of this region analytically is difficult but it is easy to find it numerically. For the special case $`k_1=k_2=2`$, $`l_1=l_2=1`$, and $`E=4`$ that the projected region covered by positions at this energy is the interior of the level set $`U=E`$ shown as a dark oval curve in the three panels of Fig. 5.4.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem pendulumRegionPrinted : ∀ k₁ k₂ l₁ l₂ c : ℝ,
  0 < k₁ → 0 < k₂ → 0 < l₁ → 0 < l₂ → 0 < c →
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c}=
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ r₁ > 0,∃ r₂ > 0,
    k₁/2*(r₁-l₁)^2+k₂/2*(r₂-l₂)^2=c ∧
    Real.sqrt ((q 0)^2+(q 1)^2) ≤ r₁ ∧ Real.sqrt ((q 0)^2+(q 1+2)^2) ≤ r₂} := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-PendulumRegionPrinted。改动：能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。 -/
```

独立修正版：

```lean
theorem pendulumRegionPrinted_corrected (k₁ k₂ l₁ l₂ c : ℝ) :
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c} =
  {q : MolecularDynamics.Chapter05Review.E 2 | pendulumPotential k₁ k₂ l₁ l₂ q ≤ c} := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.pendulumRegionPrinted`；`MD.Ch05.pendulumRegionPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。 | [EXTRA] |

[EXTRA] [EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。；[ERRATUM?] 能量面的位置投影修正为势能次水平集，删除不成立的一般圆盘并参数化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件:1189–1191 的 pendulumPotential 逐项为双弹簧势 U(q)=k₁(d₁−l₁)²/2+k₂(d₂−l₂)²/2，其中 d₁=√(x²+y²)、d₂=√(x²+(y+2)²)。声明量化所有严格正 k₁,k₂,l₁,l₂,c。左集是存在动量使 |p|²/2+U(q)=c 的位置投影，按标准实欧氏语义恰为 {U≤c}；右集是存在正 r₁,r₂ 处于半径能量椭圆，且 d₁≤r₁、d₂≤r₂ 的圆盘交之并。平方项(r−l)²在 r<l 时并不单调递增，故半径上界不足以控制实际势。[EXTRA]单位质量及将可达区域解释为所有能量初值的位置投影合理，全部正参数也未把结论作前提，但它们不能消除下列反例。原书特例及 interior 的边界问题亦应区分；闭能量投影包含零动量边界。FAIL 是展开后等式为假的确定判定，无需查看 Mathlib 定义体。声明体为 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch05.pendulumRegionPrinted`：未证（原书疑误不证）；`MD.Ch05.pendulumRegionPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1771)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicInitialCurve · definition · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $`E_0`$, with positions in a small interval on the positive $`x`$ axis, $`1.05\le x\le1.15`$ and $`y=0`$. For each point $`(x,0)`$ taken from this set select the initial velocities as $`\dot x=0`$, $`\dot y=[2(E_0-U(x,0))]^{1/2}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def anisotropicInitialCurve (κ l ε c x : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![0,Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicInitialCurve` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。展开目标附件:1205–1206 的 anisotropicInitialCurve 得 γ(x)=((x,0),(0,√(2(c−U(x,0)))))，WithLp.toLp 2 仅将指定坐标放入标准欧氏空间；c 对应 E₀，单位质量下动量等于速度。此项是参数化公式定义，原区间[1.05,1.15]已在 context\_notation 明示，集合使用时应限制到该区间，映射本身在整个实线上定义并不改变受限初值集。Real.sqrt 在负参数上取0的总定义按标准语义理解：本 def 自身没有断言所有参数下能量恒等式成立，实初值能量资格由下一条明确约束。因此不将缺少定义体或总定义延拓误判为缺失对象或数学错误。extra\_assumptions 为空，def 无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.anisotropicInitialCurve`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1794)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicInitialEnergy · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> For each point $`(x,0)`$ taken from this set select the initial velocities as $`\dot x=0`$, $`\dot y=[2(E_0-U(x,0))]^{1/2}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem anisotropicInitialEnergy : ∀ κ l ε c x : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := anisotropicInitialCurve κ l ε c x
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicInitialEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。 | [EXTRA] |

[EXTRA] [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。目标附件:1205–1206 的初值定义展开为 q=(x,0)、p=(0,√(2(c−U(q))))。本声明量化所有实 κ₀,l₀,ε,c,x，在唯一前提 c−U(q)≥0 下推出 |p|²/2+U(q)=c；前提正好保证实平方根的平方等于根号内量。[EXTRA]非负根号资格必要且合理，单位质量已体现于动能系数1/2；参数正性和短区间约束不是这个代数能量恒等式所必需，省去它们是有效的一般化。本项没有声称轨道覆盖或遍历整个能量面，也未将能量结论作为前提。PASS 只批准签名语义，theorem 主体仍为 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch05.anisotropicInitialEnergy`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1799)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InitialSegmentPrinted · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> The set of initial conditions forms a line segment in the four-dimensional phase space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem initialSegmentPrinted : ∀ κ l ε c : ℝ,
  (∀ x ∈ Icc (105/100 : ℝ) (115/100),0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])) →
  ∃ a b : MolecularDynamics.Chapter05Review.Phase 2,anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)=segment ℝ a b := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-InitialSegmentPrinted。改动：四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。 -/
```

独立修正版：

```lean
def initialSegmentPrinted_corrected (κ l ε c : ℝ) : Set (MolecularDynamics.Chapter05Review.Phase 2) :=
  anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.initialSegmentPrinted`；`MD.Ch05.initialSegmentPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。 | [EXTRA] |

[EXTRA] [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。；[ERRATUM?] 四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。目标附件:1205–1206 的实际初值是 γ(x)=((x,0),(0,√(2(c−U(x,0)))))；1218–1220 量化任意实 κ₀,l₀,ε,c，假定闭区间 I=[21/20,23/20] 上 c−U≥0，结论存在 a,b∈Phase 2 使 γ(I)=segment ℝ a b。标准 Mathlib segment ℝ a b 是 {(1−s)a+s b | 0≤s≤1} 的仿射闭线段，不能理解成任意拓扑弧或参数曲线。[EXTRA]保留真实相空间对象、区间与非负根号资格正确且无循环，但不能使平方根动量关于 x 为仿射函数。该签名忠实复现原书 line segment 的字面措辞，同时把原书疑误写成了假的数学定理，应 FAIL；问题与 Mathlib 定义体是否提供无关。没有显式 [ERRATUM?] 标签可据此默认接受错误，疑误及修复必须明示。声明体为 sorry，独立记录。

### 7. 状态与证明位置

incomplete；`MD.Ch05.initialSegmentPrinted`：未证（原书疑误不证）；`MD.Ch05.initialSegmentPrinted_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1808)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialPoints · definition · 印刷p.202 / PDFp.223

### 2. 原文陈述

> Now consider an alternative initial set. Begin, as before, with a line segment on the $`x`$-axis, but now choose the initial momenta from the uniform distribution on the circle $`p_x^2+p_y^2=2(E_0-U(x,0))`$. In this way we again get initial conditions on the $`H=E_0`$ energy surface, but this time the points are not close to one another in phase space, since the momenta of successive points may differ greatly.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def circleInitialPoints (κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100)) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])

def circleInitialPoints_total (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialPoints`；`MD.Ch05.circleInitialPoints_total` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。 | [EXTRA] |

[EXTRA] [EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对circleInitialPoints及circleInitialPoints\_total。Phase 2确为E 2×E 2，位置为(x,0)，动量为(R cos θ,R sin θ)，R=√(2(c−U(x,0)))。实际接口显式要求c−U(x,0)≥0及x∈[1.05,1.15]，与可行能量及“as before”的原位置区间相符；κ,l,ε,c,x,θ均为实参数，θ没有在本定义中被伪称随机变量的概率律。U实际调用给出的anisotropicPotential→anisotropicEnergy，零速度消去了动能；角向参数是4 cos³α−3 cosα，对应给出的各向异性参数定义，没有换成双弹簧势。total接口明确是无前提的辅助总延拓，负能差时不能称为能量c上的初值。均匀性在条目11另作测度定义，能量等式在条目12另作结论；[EXTRA]没有将样本可能相距很远强化为所有θ、所有样本都分离。

### 7. 状态与证明位置

self-contained；`MD.Ch05.circleInitialPoints`：定义；`MD.Ch05.circleInitialPoints_total`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1821)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialLaw · definition · 印刷p.202 / PDFp.223

### 2. 原文陈述

> choose the initial momenta from the uniform distribution on the circle $`p_x^2+p_y^2=2(E_0-U(x,0))`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def circleInitialLaw (κ l ε c x : ℝ)
    (hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (hx : x ∈ Icc (105/100 : ℝ) (115/100)) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (fun θ ↦ circleInitialPoints κ l ε c x θ hfeas hx)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialLaw` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。 | [EXTRA] |

[EXTRA] [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。；[EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；circleInitialLaw对固定κ,l,ε,c,x及其可行性、区间资格，定义Phase 2上的真实Measure.map。原测度是(2π)⁻¹倍的Lebesgue测度在(0,2π]上的限制；π>0，区间长度为2π，归一化系数和端点选择正确。推前映射恰是条目10的实际可行接口，关于θ连续，因此推前确有概率总质量1；没有把“尚未证明概率实例”误作公式错误。当R>0，这给出固定位置下对动量圆的均匀角/归一化弧长概率分布；R=0时退化为该固定相点的Dirac概率。原文没有指定跨x的联合抽样规律，本定义也没有擅加x均匀性或不同x之间的独立性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.circleInitialLaw`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1834)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialEnergy · unnumbered_claim · 印刷p.202 / PDFp.223

### 2. 原文陈述

> In this way we again get initial conditions on the $`H=E_0`$ energy surface,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints_total κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。 | [EXTRA] |

[EXTRA] [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。；[EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；circleInitialEnergy对所有κ,l,ε,c,x,θ∈ℝ，仅要求c−U(x,0)≥0，在circleInitialPoints\_total上断言两动量平方和的一半加同一势能等于c。cos²θ+sin²θ=1及非负根号平方给出该恒等式，动能系数与圆半径的因子2相抵；R=0同样成立。本条作为辅助总定义的结论不限制x区间是正确的推广，实际书中抽样接口的区间限制在条目10、11，且两种点定义在其共同可行域的表达式相同。没有偷换势能，未把能量等式本身作前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.circleInitialEnergy`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1843)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-Correlation · definition · 印刷p.203–204 / PDFp.224–225

### 2. 原文陈述

> Let $`a`$ and $`b`$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $`a`$ and $`b`$ (on the surface of energy $`E`$) by

$$
C_{ab}(\tau)\stackrel{\rm def}{=}k\operatorname{Av}_{H=E}(a(\mathcal F_t(z))\cdot b(z)) =kZ_E^{-1}\int_{\Sigma_E}a(\mathcal F_t(z))\cdot b(z)\delta[H-E]d\omega;
$$


> where $`k`$ is a normalization constant that is often incorporated to ensure that $`C_{ab}(0)=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)



/-- 修正版，对应原文 MD-5.5-Correlation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def correlation_corrected {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlation`；`MD.Ch05.correlation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；correlation对任意状态维n、共同输出维d，接受μ、Φ及a,b:E n→E d和实k,t，返回k乘以真实实欧氏内积的μ积分；只在a上施加Φ\_t，b取初始状态，次序与源文相符。这里定义的是通用测度下的相关核，取μ为已归一化微正则概率测度时才对应原Av_(H=E)；不能据此声称对任意μ都等于原δ积分，也未在此定义或证明微正则测度构造。积分定义可以总延拓至任意观测量；作通常统计相关解释时仍须有相关乘积的可积性。k任意是正确的，“often”并未要求无条件C(0)=1；零lag积分非零时才能取其倒数归一化。Lean统一用一个lag参数t，是对源文τ/t混用的已公开合理修订。

### 7. 状态与证明位置

self-contained；`MD.Ch05.correlation`：定义；`MD.Ch05.correlation_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1851)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationPullback · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Using the notation developed earlier for the propagator, this has the alternative formulation

$$
C_{ab}(t)=k\operatorname{Av}_{H=E}\left[b(z)\cdot(e^{t\mathcal L}a)(z)\right].
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationPullback {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t :
    MolecularDynamics.Chapter05Review.correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ) := by
  apply MolecularDynamics.Chapter05Review.correlationPullback_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationPullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目pullback Φ g t z := g(Φ t z)，solutionOperator Φ t g := pullback Φ g t。两者在定义中为实标量观测；向量观测的逐坐标传播就是a(Φt z)。主声明对任意n,d,μ,Φ,a,b,k,t断言correlation等于其展开积分，保留k及全部配对项；欧氏实内积对称，故与原b(z)·(e^{tL}a)(z)相同。没有凭函数名字假定它是微分算子的指数：这里使用原flow拉回的传播含义，实际展开体已核对。无额外假设或新增勘误。Ch05\_deps.txt的ReviewProofs.lean中correlationPullback\_proved为rfl，主声明调用它；本条无sorry。无编译验证声明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.correlationPullback`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1861)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationTimePrinted · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $`H=E`$ energy surface:

$$
C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationTimePrinted : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
  sorry



/-- 修正版，对应原文 MD-5.5-CorrelationTimePrinted。改动：any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。 -/
```

独立修正版：

```lean
theorem correlationTimePrinted_corrected : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.regularEnergy H c →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationTimePrinted`；`MD.Ch05.correlationTimePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。 | [EXTRA] |

[EXTRA] [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。；[ERRATUM?] any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 energySurface H c := {z | H z=c}；grad H := gradient H；hausdorffArea m := ofReal(volume(单位ℝ^m球).toReal/2^m) • hausdorffMeasure m；surfaceMeasure H c := (hausdorffArea (n-1)).restrict(energySurface H c)；microRaw H c := (surfaceMeasure H c).withDensity(fun z => ofReal(‖grad H z‖⁻¹))；microMeasure H c := ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage H c g := average(microMeasure H c)g。timeAverage z g T := T⁻¹*(∫s in 0..T,g(z s))；hasTimeAverage z g a := Tendsto(timeAverage z g) atTop (𝓝 a)；microErgodic H c Φ := ∀g, Integrable g (microMeasure H c) → ∀ᵐz∂microMeasure H c, hasTimeAverage(fun s=>Φs z)g(microAverage H c g)。签名依次全称量化n,d,H,c,Φ,a,b,k,t，假设Φ0=id、flow加法群律、microErgodic及给定lag观测的可积性，结论为所有z∈{H=c}的相关时间积分极限。原文any trajectory确实对应这个全点结论；但本项目microErgodic只提供对每个可积观测的AE性质，不能推出全能量面点性质。[EXTRA]给定lag可积和群律合理，却不足以支持原any；没有正有限微正则质量、正则能量资格或全点平均假设。原文any在通常测度遍历含义下应公开作AE勘误，不能由名字ergodic获得全点结论。下面给出当前签名的直接反例，不因未给Mathlib定义而待裁定。主声明有sorry，但签名失败独立于证明完成度。

### 7. 状态与证明位置

incomplete；`MD.Ch05.correlationTimePrinted`：未证（原书疑误不证）；`MD.Ch05.correlationTimePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1868)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationTimeAE · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $`H=E`$ energy surface:

$$
C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationTime :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh



/-- 修正版，对应原文 MD-5.5-CorrelationTimeAE。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem correlationTime_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationTime`；`MD.Ch05.correlationTime_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；correlationTime已逐项核对全部n,d,μ,Φ,a,b,k,t量词、零时恒等及群律。遍历资格在此作为“每个L¹实观测量有各自AE时间平均”的标准性质传入，并要求给定lag的相关观测量可积；在条目1的概率保测可测流条件下，这个资格可由setErgodic取得，未把特定相关等式直接作为假设。结论对给定t几乎处处z，保留k、T⁻¹、真实0到T积分以及a(Φ_(s+t)z)与b(Φ\_s z)的实内积。群律和实数加法交换保证该 integrand 是固定观测量g\_t沿Φ\_s的值，极限目标是同一μ、Φ、a、b、k、t的correlation。没有交换∀t与AE z；也没有从一般遍历性推出每个初值。因此AE修订版完整签名PASS，原书any trajectory仍独立标为待人工。

### 7. 状态与证明位置

self-contained；`MD.Ch05.correlationTime`：已证；`MD.Ch05.correlationTime_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1897)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-VelocityCorrelation · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> The velocity autocorrelation function is often written in the shorthand notation

$$
C_{v,v}(t)\stackrel{\rm def}{=}\frac{\langle v(t)\cdot v(0)\rangle}{\langle v(0)\cdot v(0)\rangle},
$$


> where the averaging may be assumed to be against the microcanonical measure, if otherwise unspecified.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def velocityCorrelation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (v : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (t : ℝ) := MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 t/MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.velocityCorrelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 velocityCorrelation μ Φ v t := correlation μ Φ v v 1 t / correlation μ Φ v v 1 0；MD.Ch05中的定义调用同一项目correlation。展开为∫inner(v(Φt z))(v z)∂μ除以∫inner(v(Φ0 z))(v z)∂μ。在原轨迹/flow上下文Φ0=id时分母正是〈v(0)·v(0)〉，输出空间ℝ^d及真实dot均保留。μ参数允许原otherwise unspecified的微正则选择及其他指定测度。此定义不声称任意Φ为flow，不自动证明分母非零或可积；context已明确除零总化没有归一化意义，合法使用时须非零零lag平均。无[EXTRA]/[ERRATUM?]假设；定义无sorry。标准Bochner积分/除法定义不造成NEEDS\_HUMAN。

### 7. 状态与证明位置

self-contained；`MD.Ch05.velocityCorrelation`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1931)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-PositionTransition · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Now let $`A`$ and $`B`$ be subsets of configuration space (i.e. subsets in the position space) of nonzero measure, and define $`T_{AB}(\tau)\stackrel{\rm def}{=}C_{1_B,1_A}(\tau)`$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (k t : ℝ) :=
  k*
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.positionTransition` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。 | [EXTRA] |

[EXTRA] [EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；positionTransition接受同一μ、Φ、实k和t，位置映射π:E n→E d，以及配置集合A、B。被积函数是1\_B(π(Φ\_t z))·1\_A(π z)，并在积分外完整保留k，正对应C_(1\_B,1\_A)的顺序；没有交换始发集合A和目标集合B。π作为参数是通用观测映射，实际原文用法须选为位置投影；原非零测度和可测性要求在一般定义中可以放宽，因为本条没有做除法或断言条件概率。若作概率解释则还须相应概率测度、可测集/映射；特别应取k=1，再除以起始事件的正概率。当前定义本身不是首次到达分布，也不保证对任意k其值都在[0,1]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.positionTransition`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1936)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-TransitionProbability · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Dividing $`T_{AB}`$ by the measure of the set $`A`$, we obtain the probability for a trajectory to make this transition in the given time, which we may write as

$$
\operatorname{Pr}_\tau(A\to B)=\frac{\langle1_B(z(\tau))1_A(z(0))\rangle}{\langle1_A(z(0))\rangle},
$$


> where the averaging is assumed to be with respect to the microcanonical distribution at given energy $`E`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def transitionProbability {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (A B : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.transitionProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。 | [EXTRA] |

[EXTRA] [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 transitionProbability μ Φ A B t := (μ(A ∩ (Φt)⁻¹' B)).toReal/(μA).toReal。量化n及指定μ、Φ、相空间集合A/B和时刻t，事件是初始在A且终时在B，没有交换方向或替换为首次到达。按[EXTRA]，A/B解释为配置集合在实际位置投影下的逆像；这与上一条位置配置对象兼容。对微正则概率μ、可测/μ零可测的事件、可测flow及0<μA，指标乘积是A∩(Φt)⁻¹B的指标，故Bochner积分比值就是该测度比值；Φ0=id对应原初始轨迹记号。定义泛化到其他μ/集合不声称这些输入均有原条件概率解释；零分母及无限测度toReal的总化不是概率性结论。在原有限概率、正分母域内，所有分子分母子句完整，[EXTRA]逆像解释必要且合理。上一条T\_AB的k歧义不影响这里直接写出的无k比值公式。定义无sorry；未要求项目附件重给Mathlib指标积分定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.transitionProbability`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1944)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MeasureDuality · (5.10) · 印刷p.205 / PDFp.226

### 2. 原文陈述


$$
\int_{\Sigma_E}\phi(z)\rho(z;t)d\omega =\int_{\Sigma_E}\phi(z)e^{t\mathcal L^\dagger}\rho(z,0)d\omega =\int_{\Sigma_E}[e^{t\mathcal L}\phi(z)]\rho(z,0)d\omega =\int_{\Sigma_E}\phi(\mathcal F_t(z))\rho(z,0)d\omega =\int_{\Sigma_E}\phi(\mathcal F_t(z))\frac{\rho(z,0)}{\rho_E(z)}\rho_E(z)d\omega.\tag{5.10}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem measureDuality :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (φ : MolecularDynamics.Chapter05Review.E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) →
    MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) φ=MolecularDynamics.Chapter05Review.average μ (MolecularDynamics.Chapter05Review.pullback Φ φ t) := by
  intro n μ Φ φ t hm hi
  exact integral_map hm.aemeasurable hi.aestronglyMeasurable

theorem measureDuality_RN (n : ℕ)
    (ν : Measure (MolecularDynamics.Chapter05Review.E n)) (_hν : IsProbabilityMeasure ν)
    (r : MolecularDynamics.Chapter05Review.E n → ℝ) (_hr : Integrable r ν)
    (_hrpos : ∀ z,0 ≤ r z) (_hrmass : (∫ z,r z ∂ν)=1)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (t : ℝ) (_hΦ : Measurable (Φ t))
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hc : Continuous φ)
    (_hb : Bornology.IsBounded (range φ)) :
    let μ₀ := ν.withDensity (fun z ↦ ENNReal.ofReal (r z))
    MolecularDynamics.Chapter05Review.average (Measure.map (Φ t) μ₀) φ=
      MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t) ∧
    MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t)=
      ∫ z,φ (Φ t z)*r z ∂ν := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.measureDuality`；`MD.Ch05.measureDuality_RN` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ\_E的RN解释，不对奇异δ作函数相除。 | [EXTRA] |

[EXTRA] [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。；[EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ\_E的RN解释，不对奇异δ作函数相除。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已分别核对measureDuality和measureDuality\_RN。前者对任意n、μ、Φ、实值φ和实t，在Φ\_t可测且φ对推前measurePropagator可积时，断言推前积分等于初始测度下的pullback积分。实际measurePropagator定义确为Measure.map，pullback确为φ∘Φ\_t，方向与原配对链相符，未把最终等式作前提；这一单时刻换元无需额外流群律。后者对概率参考ν、非负L¹密度r且∫r=1，置μ₀=ν.withDensity(ofReal∘r)，对可测Φ\_t及有界连续φ，依次给出推前配对=μ₀下pullback配对=∫φ(Φ\_t z)r(z)dν。非负性确保ofReal不截去密度，归一化确保μ₀为概率，有界连续φ使所需配对可积。这里的r是相对于ν的RN密度，对应原ρ₀/ρ\_E的已公开测度解释，不是对Dirac分布作函数相除。原来有界密度的语境被推广为非负L¹概率密度，仍足以保证本条有界测试函数的配对链。PASS限于推前/拉回及加权积分的这套明示解释；本条没有定义生成元或证明算子指数e^(tL)、e^(tL†)的解析半群理论。

### 7. 状态与证明位置

incomplete；`MD.Ch05.measureDuality`：已证；`MD.Ch05.measureDuality_RN`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1951)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingMemoryLoss · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> We assume $`\psi(z)\stackrel{\rm def}{=}\rho(z;0)/\rho_E(z)`$ is bounded on $`\Sigma_E`$, and moreover $`\operatorname{Av}_{H=E}(\psi)=\int_{\Sigma_E}\frac{\rho(z;0)}{\rho_E(z)}\rho_E(z)\,d\omega=1`$ (i.e., the initial density is a probability density on the energy surface), and that the system is mixing. Then the integral (5.10) is well defined and we may view it as a two-point correlation function of $`\phi`$ and $`\psi`$. By the mixing property it must converge to $`\int_{\Sigma_E}\phi(z)\rho_Ed\omega`$, thus the average value of $`\phi`$ is ultimately independent of the initial conditions. We have

$$
\lim_{t\to\infty}\int_{\Sigma_E}\phi(\mathcal F_t(z))(\psi(z)-1)\rho_Ed\omega=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingMemoryLoss : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (β φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0) := by
  intro n μ Φ β φ hμ hm hβ hβbound hβpos hβmass hφ hb hΦ
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hi : Integrable φ μ := Integrable.mono' (integrable_const C)
    hφ.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (φ z) (mem_range_self z)))
  have he (t : ℝ) : (∫ z,φ (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ φ := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable φ (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact hi.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have hp (t : ℝ) : Integrable (fun z => φ (Φ t z)*β z) μ :=
    hβ.bdd_mul (hφ.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hB (φ (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : (∫ z,φ (Φ t z)*(β z-1) ∂μ)=
      (∫ z,φ (Φ t z)*β z ∂μ)-MolecularDynamics.Chapter05Review.average μ φ := by
    simp_rw [mul_sub,mul_one]
    have hip : Integrable (fun z => φ (Φ t z)) μ := by
      simpa only [Function.comp_def] using (hΦ t).integrable_comp_of_integrable hi
    rw [integral_sub (hp t) hip,he]
  simp_rw [heq]
  simpa only [sub_self] using (hm.2 β φ hβ hβpos hβmass hφ hb).sub (tendsto_const_nhds : Tendsto (fun _ : ℝ => MolecularDynamics.Chapter05Review.average μ φ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingMemoryLoss` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。 | [EXTRA] |

[EXTRA] [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。；[EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：n任意，E n为有限维实欧氏空间；μ是表示能量面参考概率的环境测度，未额外假设Lebesgue密度。Φ为实时间流，weakMixing第一合取规定概率、单位元、群律及联合可测，第二合取是对任意可积非负质量1密度和有界连续测试函数的弱收敛；这是混合的密度测试刻画，并非标准仅Cesàro意义的weak mixing。β可积、有界、非负且积分1，φ有界连续，各时Φ保持μ，结论是整个中心化积分随实t→+∞趋0。由测度保持和质量1亦恢复非中心化极限；[EXTRA]限制明确且充分，未把本条特定中心化结论作假设。 本条全部本地声明：MD.Ch05.mixingMemoryLoss。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.mixingMemoryLoss`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1976)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingCorrelationPrinted · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> More generally, in a mixing system, if $`a`$ and $`b`$ are two arbitrary functions of the phase variables, then

$$
\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\operatorname{Av}_{H=E}(b).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingCorrelationPrinted :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → weakMixing μ Φ → Continuous a → Continuous b →
    Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
    Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  sorry



/-- 修正版，对应原文 MD-5.5-MixingCorrelationPrinted。改动：独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。 -/
```

独立修正版：

```lean
theorem mixingCorrelationPrinted_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingCorrelationPrinted`；`MD.Ch05.mixingCorrelationPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。 | [EXTRA] |

[EXTRA] [EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。；[ERRATUM?] 独立修正版恢复任意向量维数及k因子，给有界连续向量观测量的内积均值极限；无k实值原式独立保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；按本轮规则，Mathlib标准定义直接按Lean 4.34.0 / Mathlib v4.34.0的标准数学含义采信：EuclideanSpace ℝ (Fin n)是欧氏ℝⁿ；integral为Bochner积分且不可积时取0；IsProbabilityMeasure μ表示μ全空间质量1；MeasurePreserving表示可测且推前测度等于μ；Integrable表示相对于指定μ可积；Continuous及IsBounded(range f)分别为连续和全局有界；Tendsto ... atTop (𝓝 L)为实时间趋向+∞时趋向L。不要求Ch05\_deps.txt提供这些Mathlib定义体。 已展开本项目定义：Ch05\_deps.txt的-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean中，E n:=EuclideanSpace ℝ (Fin n)，average μ g:=∫g dμ，correlation μ Φ a b k t:=k∫inner ℝ (a(Φ t z)) (b z)dμ，其中a,b:E n→E d且d任意。Ch05.lean中本地MD.Ch05.weakMixing的定义为：∀ r φ:E n→ℝ，Integrable r μ→(∀z,0≤r z)→∫r dμ=1→Continuous φ→IsBounded(range φ)→∫φ(Φ t z)r z dμ趋向average μ φ。它是原书PDF220（印刷199）所述概率初值弱收敛的测试函数版本，不因名称weakMixing而解释成通常Cesàro弱混合。它没有引用deps中那个使用Lebesgue可积density r的旧mixing定义。μ任意量化是对微正则参考概率测度的抽象推广；不额外断言任意μ就是微正则测度。 所有项目自定义符号均有定义可核对，无缺失定义导致的NEEDS\_HUMAN。 Ch05.lean:1335起量化任意实数k，结论左端为k∫a(Φ\_t z)b(z)dμ而右端为average μ a·average μ b，确实照录PDF226（印刷205）的漏k公式。PDF224–225（印刷203–204）的C\_ab定义含k；故原印归一化疑误成立，字面签名即使在全部函数可积的情形仍为假。[EXTRA]概率测度及有界连续函数是合理的统计/测试资格，不能弥补漏k。此条没有独立保测前提；下列反例甚至满足保测，所以添加保测也不能修复。另有对象范围遗漏：原C\_ab及项目correlation允许任意同一Euclidean空间值a,b，而本声明仅量化实值a,b。这与Mathlib定义是否提供无关。签名失败不由sorry推断；声明正文有sorry，须另外记为证明未完成。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mixingCorrelationPrinted`：未证（原书疑误不证）；`MD.Ch05.mixingCorrelationPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2007)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingCorrelation · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> $`\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\cdot\operatorname{Av}_{H=E}(b)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingCorrelation :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
  sorry

theorem mixingCorrelation_scalar :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hbb.exists_pos_norm_le
  obtain ⟨R,hR,hA⟩ := hba.exists_pos_norm_le
  have ib : Integrable b μ := Integrable.mono' (integrable_const C)
    hb.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (b z) (mem_range_self z)))
  have ia : Integrable a μ := Integrable.mono' (integrable_const R)
    ha.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hA (a z) (mem_range_self z)))
  have ibound : |∫ z,b z ∂μ| ≤ C := by
    simpa only [Real.norm_eq_abs,probReal_univ,mul_one] using
      norm_integral_le_of_norm_le_const (ae_of_all μ (fun z => hB (b z) (mem_range_self z)))
  let D := C+1
  let M := (∫ z,b z ∂μ)+D
  have hM : 0 < M := by dsimp [M,D];linarith [neg_le_of_abs_le ibound]
  let r (z) := (b z+D)/M
  have ir : Integrable r μ := (ib.add (integrable_const D)).div_const M
  have rpos (z) : 0 ≤ r z := by
    have hx : |b z| ≤ C := by simpa only [Real.norm_eq_abs] using hB (b z) (mem_range_self z)
    dsimp [r,D]
    apply div_nonneg _ hM.le
    linarith [neg_le_of_abs_le hx]
  have rmass : (∫ z,r z ∂μ)=1 := by
    dsimp [r]
    rw [integral_div,integral_add ib (integrable_const D)]
    simp [integral_const,M,ne_of_gt hM]
  have ht := hm r a ir rpos rmass ha hba
  have iap (t : ℝ) : Integrable (fun z => a (Φ t z)) μ :=
    (hΦ t).integrable_comp_of_integrable ia
  have ie (t : ℝ) : (∫ z,a (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ a := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable a (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact ia.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have ipr (t : ℝ) : Integrable (fun z => a (Φ t z)*r z) μ :=
    ir.bdd_mul (ha.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hA (a (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : M*(∫ z,a (Φ t z)*r z ∂μ)-D*MolecularDynamics.Chapter05Review.average μ a=
      (∫ z,a (Φ t z)*b z ∂μ) := by
    rw [←ie t,←integral_const_mul,←integral_const_mul,
      ←integral_sub ((ipr t).const_mul M) ((iap t).const_mul D)]
    apply integral_congr_ae
    filter_upwards [] with z
    dsimp [r]
    field_simp [ne_of_gt hM] <;> ring
  have hh := (ht.const_mul M).sub (tendsto_const_nhds : Tendsto
    (fun _ : ℝ => D*MolecularDynamics.Chapter05Review.average μ a) atTop
    (𝓝 (D*MolecularDynamics.Chapter05Review.average μ a)))
  simp_rw [heq] at hh
  convert hh.const_mul k using 1
  unfold MolecularDynamics.Chapter05Review.average
  dsimp [M]
  ring



/-- 修正版，对应原文 MD-5.5-MixingCorrelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem mixingCorrelation_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)) atTop (𝓝 (k*inner ℝ (∫ z,a z ∂μ) (∫ z,b z ∂μ))) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingCorrelation`；`MD.Ch05.mixingCorrelation_scalar`；`MD.Ch05.mixingCorrelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。；[EXTRA] 修订版扩至任意有限维向量观测量并以Bochner均值及inner表达完整k相关极限；保留原标量证明为辅助，新向量结论暂sorry，原漏k版本单列待导师。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：主声明量化n,d、任意实k、概率μ、各时保持测度的Φ和有界连续向量a,b；密度测试混合前提作用于所有标量r,φ。有限维逐分量推出带k的内积均值极限，数学正确；scalar声明是相应d=1公式，k*Av(a)*Av(b)括号无误。未要求Φ群律不妨碍此蕴含。全部[EXTRA]与修正版相符，sorry不影响签名审核。但名为mixingCorrelation的结论是带k的修正版，不能同时认证为原书无k字面版本；需人工确认原文/勘误分流。 本条全部本地声明：MD.Ch05.mixingCorrelation, MD.Ch05.mixingCorrelation\_scalar。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mixingCorrelation`：未证（原书疑误不证）；`MD.Ch05.mixingCorrelation_scalar`：已证；`MD.Ch05.mixingCorrelation_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2034)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CenteredCorrelation · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> So if either property has mean zero, then the absolute value of the autocorrelation function decays with time to zero.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem centeredCorrelation : ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  ((∫ z,a z ∂μ)=0 ∨ (∫ z,b z ∂μ)=0) →
  Tendsto (fun t => |k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)|) atTop (𝓝 0) := by
  sorry

theorem centeredCorrelation_scalar : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  (MolecularDynamics.Chapter05Review.average μ a=0 ∨ MolecularDynamics.Chapter05Review.average μ b=0) →
  Tendsto (fun t => |k*(∫ z,a (Φ t z)*b z ∂μ)|) atTop (𝓝 0) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb hzero
  have ht := mixingCorrelation_scalar n μ Φ a b k hμ hΦ hm.2 ha hb hba hbb
  have hl : k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b=0 := by
    rcases hzero with h | h <;> rw [h] <;> ring
  rw [hl] at ht
  simpa only [abs_zero] using ht.abs
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.centeredCorrelation`；`MD.Ch05.centeredCorrelation_scalar` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。 | [EXTRA] |

[EXTRA] [EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。；[EXTRA] 扩至向量观测量、任意一向量Bochner零均值及相关绝对值趋零，保留旧标量证明辅助；不添加单调衰减。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：主声明对任意n,d,k、概率μ、测度保持Φ、weakMixing及有界连续向量a,b，要求任一Bochner均值为零，结论是带k内积相关的绝对值趋0。scalar声明相同地使用实均值及乘积。两种均值零的析取及绝对值均未遗漏；衰减解释为趋零而非单调性，与[EXTRA]一致。标准混合前提通过所摘weakMixing的密度测试合取落实。 本条全部本地声明：MD.Ch05.centeredCorrelation, MD.Ch05.centeredCorrelation\_scalar。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.centeredCorrelation`：未证（缺大型理论）；`MD.Ch05.centeredCorrelation_scalar`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2125)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DiscreteAveragePrinted · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> If $`z_n`$ represents the approximation to $`z(t_n)`$, then we might attempt to estimate $`\bar g_\Gamma`$ by

$$
\bar g_\Gamma\approx\lim_{n\to\infty}n^{-1}\sum_{k=0}^ng(z_k).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.discreteAveragePrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：对任意类型X、自治步进G、实观测量g、初值z及自然数N，range(N+1)精确包含0,…,N，前因子为实N的逆元；Printed定义忠实给出有限统计量。N=0因实数逆元总化而得0，只是形式定义，不宣称统计意义或极限存在。原页只是尝试估计并随即警告极限可能不存在，因此无需补一个无条件收敛定理。 本条全部本地声明：MD.Ch05.discreteAveragePrinted。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.discreteAveragePrinted`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2146)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DiscreteAverage · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> $`\bar g_\Gamma\approx\lim_{n\to\infty}n^{-1}\sum_{k=0}^ng(z_k)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.discreteAverage` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。 | [EXTRA] |

[EXTRA] [EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：X,G,g,z,N的域同Printed，range N只有0,…,N−1；这是[EXTRA]及statement\_scope明确标出的独立标准N项变体，并非原式逐字形式化。N=0总化为0，未断言两有限统计量相同、极限存在或等于原时间平均。该范围划分合理，原字面版本在本批条目4可核实。 本条全部本地声明：MD.Ch05.discreteAverage。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.discreteAverage`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2151)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DiscretePropagator · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> In a similar way, a numerical method $`z_{n+1}=\mathcal F_h(z_n)`$ induces an effective distributional propagator.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (_hG : Measurable G) (μ : Measure X) := Measure.map G μ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.discretePropagator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。 | [EXTRA] |

[EXTRA] [EXTRA] 离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：任意可测空间X、可测自映射G、任意测度μ，返回Measure.map G μ，恰是一个数值步的分布推前；G可取F\_h，h不必作为独立参数。μ不要求概率是合法推广，若μ概率则可测推前仍概率；显式Measurable G排除了不可测map的总化问题。[EXTRA]落实，不声称精确modified流或存在密度。 本条全部本地声明：MD.Ch05.discretePropagator。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.discretePropagator`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2156)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ModifiedField · definition · 印刷p.206 / PDFp.227

### 2. 原文陈述

> One way to understand this propagator is to interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation

$$
\frac{dz}{dt}=f(z)+h^rf_{(r)}(z)\equiv\widetilde f_h(z).
$$


> The perturbation term may be viewed as the finite truncation of the perturbative expansion obtained from the backward error analysis using the methods of the previous chapter. ($`r`$ is the order of the numerical method.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.modifiedField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：n自然数，f,fr:E n→E n，h实数，r自然数，返回z↦f z+h^r •fr z，向量加法及标量乘法正确。此为修正场的定义，允许r=0是代数扩域，不是声称0阶方法的数值分析结论；上下文仍应把实际方法阶数取正整数。没有证明或假设数值步与ODE近似程度、余项界或形式级数收敛；context已明示这些不由定义推出，故不把定义夸大为误差定理。 本条全部本地声明：MD.Ch05.modifiedField。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.modifiedField`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2159)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ModifiedLiouvillian · unnumbered_claim · 印刷p.206 / PDFp.227

### 2. 原文陈述

> Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by

$$
\frac{\partial\rho}{\partial t}=\mathcal L_{\widetilde f}^{\dagger}\rho \stackrel{\rm def}{=}\mathcal L_f^{\dagger}\rho+h^r\mathcal L_{f_{(r)}}^{\dagger}\rho.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem modifiedLiouvillian :
  ∀ n (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=MolecularDynamics.Chapter05Review.liouvillian f u z+h^r*MolecularDynamics.Chapter05Review.liouvillian fr u z := by
  intro n f fr u h r hf hfr hu z
  have hx : DifferentiableAt ℝ (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z :=
    (hf z).add ((hfr z).const_smul (h^r))
  rw [liouvilleProduct n _ u z hx (hu z),liouvilleProduct n f u z (hf z) (hu z),
    liouvilleProduct n fr u z (hfr z) (hu z)]
  have hd : MolecularDynamics.Chapter05Review.divergence (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z=
      MolecularDynamics.Chapter05Review.divergence f z+(h^r)*MolecularDynamics.Chapter05Review.divergence fr z := by
    unfold MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.modifiedField
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      (fderiv ℝ (f+(h^r) • fr) z).toLinearMap=_
    rw [((hf z).hasFDerivAt.add ((hfr z).hasFDerivAt.const_smul (h^r))).fderiv]
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      ((fderiv ℝ f z).toLinearMap+(h^r) • (fderiv ℝ fr z).toLinearMap)=_
    simp only [map_add,map_smul,smul_eq_mul]
  have hl : MolecularDynamics.Chapter05Review.lie (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=
      MolecularDynamics.Chapter05Review.lie f u z+(h^r)*MolecularDynamics.Chapter05Review.lie fr u z := by
    simp [MolecularDynamics.Chapter05Review.lie,MolecularDynamics.Chapter05Review.modifiedField,
      map_add,map_smul,smul_eq_mul]
  rw [hd,hl]
  ring

def modifiedDensityEquation {n : ℕ}
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (h : ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  ∀ t z,HasDerivAt (fun s ↦ ρ s z)
    (MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) (ρ t) z) t

theorem modifiedLiouvillian_model_equivalence (n : ℕ)
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : Differentiable ℝ f) (_hfr : Differentiable ℝ fr)
    (h : ℝ) (r : ℕ) (hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (_hρ : ∀ t,Differentiable ℝ (ρ t)) :
    modifiedDensityEquation f fr h r hr ρ ↔
      ∀ t z,HasDerivAt (fun s ↦ ρ s z)
        (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z+
          h^r*MolecularDynamics.Chapter05Review.liouvillian fr (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.modifiedLiouvillian`；`MD.Ch05.modifiedDensityEquation`；`MD.Ch05.modifiedLiouvillian_model_equivalence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。 | [EXTRA] |

[EXTRA] [EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。；[EXTRA] 保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：liouvillian f u=−div(u f)，div由Fréchet导数的trace定义，是密度侧伴随生成元，不是观测量侧lie。首定理对任意n、可微f,fr,u、实h及自然r、每点z断言场线性，符号及h^r正确。modifiedDensityEquation对r≥1和所有t,z，以HasDerivAt精确规定ρ时间导数等于修正场密度生成元；equivalence在f,fr及每个ρ\_t空间可微时等价于展开PDE。全部新增声明完整涵盖模型定义及展开，未假装任意ρ自动解PDE，也未声称O(h^r)分布误差。[EXTRA]准确。 本条全部本地声明：MD.Ch05.modifiedLiouvillian, MD.Ch05.modifiedDensityEquation, MD.Ch05.modifiedLiouvillian\_model\_equivalence。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.modifiedLiouvillian`：已证；`MD.Ch05.modifiedDensityEquation`：定义；`MD.Ch05.modifiedLiouvillian_model_equivalence`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2164)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardEuler · definition · 印刷p.206–207 / PDFp.227–228

### 2. 原文陈述

> Applying Forward Euler to the harmonic oscillator, we have

$$
q_{n+1}=q_n+hp_n,\qquad p_{n+1}=p_n-hq_n,
$$


> or $`\binom{q_{n+1}}{p_{n+1}}=\begin{pmatrix}1&h\\-h&1\end{pmatrix}\binom{q_n}{p_n}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮以BATCH24附件签名及哈希绑定的Blueprint/Ch05.lean为准；Mathlib标准定义按补充规则直接采信，无须在Ch05\_deps.txt中展开。项目E在ReviewDefinitions.lean:5315为实二维欧氏空间（n=2）；forwardEuler在:5401及附件声明是WithLp.toLp 2 ![z 0+h*z 1,z 1−h*z 0]。标准WithLp转换保留坐标，因此将z 0=q、z 1=p后得到q\_next=q+h p、p\_next=p−h q，等价于矩阵[[1,h],[−h,1]]，完整覆盖PDF227–228／印刷206–207的两种写法。h为任意实定义参数，不需要渐近增长所需的h≠0。单位频率由原文H=(p²+q²)/2固定；没有把质量或频率引入额外资格。没有[EXTRA]或字面[ERRATUM?]标签；它是def，未涉及sorry证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.forwardEuler`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2208)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ForwardComponentsPrinted · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $`(q_0,p_0)=(0,0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardComponentsPrinted : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 0|) atTop atTop ∧
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 1|) atTop atTop := by
  sorry



/-- 修正版，对应原文 MD-5.6-ForwardComponentsPrinted。改动：两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。 -/
```

独立修正版：

```lean
theorem forwardComponentsPrinted_corrected : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardComponentsPrinted`；`MD.Ch05.forwardComponentsPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。 | [EXTRA] |

[EXTRA] [EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。；[ERRATUM?] 两分量各自发散修正为非零初值的范数发散；原分量断言的旋转反例保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮以BATCH24附件签名及哈希绑定的Blueprint/Ch05.lean为准；Mathlib标准定义按补充规则直接采信，无须在Ch05\_deps.txt中展开。ReviewDefinitions.lean:5315、5401展开后，对象为实际欧氏平面的A\_h=[[1,h],[−h,1]]迭代。量词为所有非零实h、所有非零初值z；两个Tendsto atTop atTop按标准意义分别要求每个坐标绝对值最终超过任意实阈值。[EXTRA]h≠0、z≠0对增长是合理必要资格，绝对值解释也明确，但两坐标各自趋于+∞仍有反例，故原书疑误能够确定，不需NEEDS\_HUMAN。PDF228／印刷207的谱外扩子句亦未单独表达；特征值模大于1可导致范数发散，不保证每个坐标绝对值发散。不存在字面[ERRATUM?]标签，但应明确保留原句并报告此疑误。附件中本声明证明体直接含sorry；反例与遗漏子句是FAIL依据，sorry另记，不能混淆。

### 7. 状态与证明位置

incomplete；`MD.Ch05.forwardComponentsPrinted`：未证（原书疑误不证）；`MD.Ch05.forwardComponentsPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2213)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

