[上一部分](part09.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part11.zh-CN.md)

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

## 1. MD-5.6-ForwardEnergyGrowth · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the eigenvalues of the propagation matrix are outside the unit disk.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem forwardEnergyGrowth : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 1)^2=
    (1+h^2)^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.forwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.forwardEuler h x 1)^2=(1+h^2)*((x 0)^2+(x 1)^2) := by
    simp [MolecularDynamics.Chapter05Review.forwardEuler]
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

theorem forwardEnergyGrowth_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔
      ζ=1+Complex.I*h ∨ ζ=1-Complex.I*h) ∧
    ‖(1 : ℂ)+Complex.I*h‖=Real.sqrt (1+h^2) ∧
    ‖(1 : ℂ)-Complex.I*h‖=Real.sqrt (1+h^2) ∧ 1 < Real.sqrt (1+h^2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.forwardEnergyGrowth`；`MD.Ch05.forwardEnergyGrowth_spectrum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。 | [EXTRA] |

[EXTRA] [EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。；[EXTRA] 保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：forwardEuler=(q+hp,p−hq)。首声明对所有实h、二维实z、自然k给平方范数精确因子(1+h²)^k，k=0及h=0均正确。spectrum另对h≠0给复矩阵[[1,h],[-h,1]]全部非零向量特征值的充要刻画1±ih、两个模均sqrt(1+h²)、以及严格大于1；无遗漏另一特征值。[EXTRA]条件与量词合理，谱外扩并非假设，sorry不构成FAIL。 本条全部本地声明：MD.Ch05.forwardEnergyGrowth, MD.Ch05.forwardEnergyGrowth\_spectrum。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.forwardEnergyGrowth`：已证；`MD.Ch05.forwardEnergyGrowth_spectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2232)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-EulerInvariant · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> This means that with the single exception $`\rho(q,p;0)=\delta[q]\delta[p]`$ there is no limiting (invariant) distribution for Forward Euler. To put it another way, the only solution, in the weak sense, of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$ is the point distribution $`\delta[q]\delta[p]`$, and this solution is not “asymptotically stable.”

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerInvariant :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2 := by
  intro h hh μ hμ hΦ
  letI := hμ
  have heq : ∀ᵐ z ∂μ,z=(0 : MolecularDynamics.Chapter05Review.E 2) := by
    filter_upwards [hΦ.conservative.ae_frequently_mem_of_mem_nhds] with z hz
    by_contra hn
    have hs : 0 < (z 0)^2+(z 1)^2 := by
      have hs' : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hn) _
      rw [EuclideanSpace.norm_sq_eq] at hs'
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hs'
    have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
    have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
    have hret := hz (Metric.ball 0 (‖z‖+1))
      (Metric.isOpen_ball.mem_nhds (by simp [Metric.mem_ball,dist_zero_right]))
    obtain ⟨k,hk,hlarge⟩ := (hret.and_eventually
      (ht.eventually (eventually_ge_atTop ((‖z‖+1)^2+1)))).exists
    have hen : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
        (1+h^2)^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
    rw [←hen] at hlarge
    rw [Metric.mem_ball,dist_zero_right] at hk
    nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),norm_nonneg z]
  have hm : Measure.map (fun z : MolecularDynamics.Chapter05Review.E 2 => z) μ =
      Measure.map (fun _ : MolecularDynamics.Chapter05Review.E 2 => (0 : MolecularDynamics.Chapter05Review.E 2)) μ := Measure.map_congr heq
  simpa [MolecularDynamics.Chapter05Review.diracMeasure,Measure.map_id,Measure.map_const] using hm

theorem eulerInvariant_no_probability_limit (h : ℝ) (_hh : h ≠ 0)
    (μ : Measure (MolecularDynamics.Chapter05Review.E 2)) (_hμ : IsProbabilityMeasure μ)
    (_hne : μ ≠ MolecularDynamics.Chapter05Review.diracMeasure 2) :
    ¬∃ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure ν ∧
      ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun k : ℕ ↦ ∫ z,φ ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) ∂μ)
          atTop (𝓝 (∫ z,φ z ∂ν)) := by
  sorry



/-- 修正版，对应原文 MD-5.6-EulerInvariant。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem eulerInvariant_corrected :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅离散Euler唯一不变概率及非Dirac初始概率无弱概率极限（补列）；实际modified模型一步对应由MD-5.6-EulerLogCorrespondence，弱稳态唯一/非吸引由MD-5.6-ForwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.eulerInvariant`；`MD.Ch05.eulerInvariant_no_probability_limit`；`MD.Ch05.eulerInvariant_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。；[EXTRA] 除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：eulerInvariant量化非零h及所有概率μ，以真实forwardEuler保持μ为前提，结论μ=δ₀正确；no\_probability\_limit对每个非Dirac概率μ排除任何概率ν的全部有界连续测试函数弱极限，强度和量词正确，部分质量留在0也仍不紧。已给[EXTRA]诚实限定为离散概率测度，并将连续模型/弱稳态分配外部source\_id；这些外部声明未在本任务摘录，不能认证其覆盖。原书声称唯一弱解若指所有分布而非概率测度，必须人工限定类别；亦不能把离散不变性直接当连续生成元核。故两条已给Lean声明本身通过，但整条原书弱稳态/稳定性尚不能PASS。 本条全部本地声明：MD.Ch05.eulerInvariant, MD.Ch05.eulerInvariant\_no\_probability\_limit。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.eulerInvariant`：已证；`MD.Ch05.eulerInvariant_no_probability_limit`：未证（原书疑误不证）；`MD.Ch05.eulerInvariant_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2259)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardEuler · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> As an alternative, consider the Backward Euler method: $`q_{n+1}=q_n+hp_{n+1}`$, $`p_{n+1}=p_n-hq_{n+1}`$. Then it is easily shown that both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $`n`$ (the origin is an attractive equilibrium point).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardEuler` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。 | [EXTRA] |

[EXTRA] [EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：本条statement\_scope明确只定义解出的映射，任意实h和z=(q,p)返回((q+hp)/(1+h²),(p−hq)/(1+h²))。分母始终正，代回q′=q+hp′、p′=p−hq′成立；h=0是恒等映射。没有把原句谱或趋零含混放入定义，跨条目12和13在本批可直接核实且均补h≠0。[EXTRA]落实。 本条全部本地声明：MD.Ch05.backwardEuler。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.backwardEuler`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2312)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-BackwardEnergyDecay · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $`n`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem backwardEnergyDecay : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 1)^2=
    (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.backwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.backwardEuler h x 1)^2=(1+h^2)⁻¹*((x 0)^2+(x 1)^2) := by
    have hd : 1+h^2 ≠ 0 := ne_of_gt (by positivity)
    simp [MolecularDynamics.Chapter05Review.backwardEuler]
    field_simp
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

theorem backwardEnergyDecay_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    let B := ((1+h^2 : ℝ)⁻¹ : ℂ) • A
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ B *ᵥ v=ζ • v) ↔
      ζ=(1+Complex.I*h)/(1+h^2) ∨ ζ=(1-Complex.I*h)/(1+h^2)) ∧
    ‖((1 : ℂ)+Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    ‖((1 : ℂ)-Complex.I*h)/(1+h^2)‖=1/Real.sqrt (1+h^2) ∧
    1/Real.sqrt (1+h^2) < 1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 能量衰减与复谱/模；全部离散迭代趋零由MD-5.6-BackwardEulerLimit，连续模型对应和稳态由MD-5.6-EulerLogCorrespondence/BackwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardEnergyDecay`；`MD.Ch05.backwardEnergyDecay_spectrum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。 | [EXTRA] |

[EXTRA] [EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。；[EXTRA] 保留能量衰减已有证明，补两个完整复特征值及模严格小于1；迭代趋零由BackwardEulerLimit，实际模型由EulerLogCorrespondence/BackwardWeakStationary承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：首声明对所有h,z,k给平方范数乘((1+h²)⁻¹)^k，逆元与幂括号正确。spectrum在h≠0下以复矩阵B=(1+h²)⁻¹[[1,h],[-h,1]]刻画全部特征值(1±ih)/(1+h²)，两模1/sqrt(1+h²)且严格小于1；实分母转为复数无歧义。迭代趋零按scope归条目13且可核实，外部连续模型不在此条承诺范围。[EXTRA]与定义一致。 本条全部本地声明：MD.Ch05.backwardEnergyDecay, MD.Ch05.backwardEnergyDecay\_spectrum。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.backwardEnergyDecay`：已证；`MD.Ch05.backwardEnergyDecay_spectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2318)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

