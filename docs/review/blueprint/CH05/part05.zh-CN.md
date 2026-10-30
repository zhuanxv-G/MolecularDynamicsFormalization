[上一部分](part04.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / 下一部分：无

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

## 1. MD-5.6-BackwardEulerLimit · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> all solutions of the recurrence relation tend to the origin with increasing $`n`$ (the origin is an attractive equilibrium point). In this case, all densities evolve toward the Dirac distribution centered at the origin: $`\delta[q]\delta[p]`$. The only (distributional) solution of $`\mathcal L_{\widetilde f}\rho=0`$ is again $`\delta[q]\delta[p]`$, which in this case is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem backwardEulerLimit :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0)) := by
  intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      simp only [Function.comp_apply]
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd



/-- 修正版，对应原文 MD-5.6-BackwardEulerLimit。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem backwardEulerLimit_corrected :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0)) := by
  intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      simp only [Function.comp_apply]
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.backwardEulerLimit`；`MD.Ch05.backwardEulerLimit_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅所有离散迭代趋零及任意初始概率弱趋Dirac；实际modified流一步对应由MD-5.6-EulerLogCorrespondence，概率弱稳态唯一及连续吸引由MD-5.6-BackwardWeakStationary承担。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：声明对每个h≠0同时给所有二维初值的离散轨道趋0，以及对任意初始概率μ、任意有界连续φ的积分随自然k趋φ(0)，即概率推前弱趋δ₀；无矩条件需求，量词和结论完整，[EXTRA]准确。没有给连续密度生成元稳态唯一性/连续吸引性，scope将其交外部两个source\_id，本任务无其签名不可审。所给离散签名正确，但原页L无dagger和未限定分布类别是必须人工裁定的原书疑误。 本条全部本地声明：MD.Ch05.backwardEulerLimit。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.backwardEulerLimit`：已证；`MD.Ch05.backwardEulerLimit_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2349)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEuler · definition · 印刷p.207 / PDFp.228

### 2. 原文陈述

> Now consider the application of the Symplectic Euler method, $`q_{n+1}=q_n+hp_{n+1}`$, $`p_{n+1}=p_n-hq_n`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；复审采用用户指定的 Lean 4.34.0 / Mathlib v4.34.0 标准数学含义：EuclideanSpace ℝ (Fin 2) 是二维欧氏相空间，WithLp.toLp 2 只是相同坐标的欧氏空间包装，volume 是 Lebesgue 测度，MeasurePreserving G μ μ 表示 G 可测且 Measure.map G μ=μ，IsProbabilityMeasure 表示总质量为1，Function.iterate 表示非负整数次迭代，Tendsto 表示相应拓扑/滤子的收敛，integral 是 Bochner 积分。不要求 Ch05\_deps.txt 提供这些 Mathlib 定义体。项目定义已展开：Ch05\_deps.txt:5315 的 MolecularDynamics.Chapter05Review.E n=EuclideanSpace ℝ (Fin n)。 MD.Ch05.symplecticEuler（Ch05.lean:1585）与项目库 symplecticEuler（Ch05\_deps.txt:5402）都展开为 S\_h(q,p)=((1−h²)q+hp,p−hq)。给定任意实步长和二维初值，先 p′=p−hq，再 q′=q+hp′，恰为原页两式，无量词限制、符号差异或额外假设。本引文只有方法定义，没有需要另行纳入的谱、椭圆或密度结论。证明状态单独记录：本声明文本不含 sorry；本轮未编译 Lean，也未据此声明完成传递依赖的公理审计。

### 7. 状态与证明位置

self-contained；`MD.Ch05.symplecticEuler`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2431)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEulerShadow · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the solution through any given initial point remains confined to an ellipse for all $`n`$ defined by $`\widetilde H_h(q,p)=\widetilde H_h(q_0,p_0)`$, where $`\widetilde H_h`$ is the perturbed Hamiltonian defined by the backward error analysis.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerShadow : symplecticEulerShadow_statement := by
  apply MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved <;> assumption

def symplecticEulerLogScale (h : ℝ) : ℝ :=
  if h=0 then 1 else (2*Real.arcsin (h/2))/(h*Real.sqrt (1-h^2/4))

def symplecticEulerModifiedHamiltonian (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : ℝ :=
  symplecticEulerLogScale h*MolecularDynamics.Chapter05Review.shadowOscillator h z

def symplecticEulerModifiedFlow (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :
    MolecularDynamics.Chapter05Review.E 2 :=
  let A : Matrix (Fin 2) (Fin 2) ℝ := symplecticEulerLogScale h • !![-h/2,1;-1,h/2]
  WithLp.toLp 2 (NormedSpace.exp (t • A) *ᵥ WithLp.ofLp z)

theorem symplecticEulerShadow_modified_model (h : ℝ) (_hh : |h| < 2) :
    0 < symplecticEulerLogScale h ∧
    (∀ z,symplecticEulerModifiedFlow h h z=MolecularDynamics.Chapter05Review.symplecticEuler h z) ∧
    MolecularDynamics.Chapter05Review.flow
      (fun z : MolecularDynamics.Chapter05Review.E 2 ↦ WithLp.toLp 2
        ![(gradient (symplecticEulerModifiedHamiltonian h) z) 1,
          -(gradient (symplecticEulerModifiedHamiltonian h) z) 0])
      (symplecticEulerModifiedFlow h) := by
  sorry

theorem symplecticEulerShadow_modified_scale_order (R : ℝ) (_hR : 0 < R) :
    ∃ C > 0,∃ δ > 0,δ < 2 ∧ ∀ h : ℝ,|h| < δ →
      ∀ z : MolecularDynamics.Chapter05Review.E 2,‖z‖ ≤ R →
        |symplecticEulerModifiedHamiltonian h z-MolecularDynamics.Chapter05Review.shadowOscillator h z| ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-5.6-SymplecticEulerShadow。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticEulerShadow_corrected : symplecticEulerShadow_statement := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 一步二次不变量与实际主对数modified Hamiltonian/流对应及比例阶次；全部k和椭圆/零退化由MD-5.6-SymplecticEulerEllipse、连续概率稳态/非吸引由MD-5.6-SymplecticWeakStationary承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEulerShadow`；`MD.Ch05.symplecticEulerLogScale`；`MD.Ch05.symplecticEulerModifiedHamiltonian`；`MD.Ch05.symplecticEulerModifiedFlow`；`MD.Ch05.symplecticEulerShadow_modified_model`；`MD.Ch05.symplecticEulerShadow_modified_scale_order`；`MD.Ch05.symplecticEulerShadow_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留一步不变量证明，补稳定区内主对数Hamiltonian=c(h)·二次不变量、c>0、实际矩阵指数Hamiltonian流及其时间h恰为离散步，并给两能量有界域O(h²)比例差；全部k/椭圆由SymplecticEulerEllipse、弱稳态由SymplecticWeakStationary承担。新增模型是显式技术选择，不冒称唯一修正能量。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。；[EXTRA] 保留一步不变量证明，补稳定区内主对数Hamiltonian=c(h)·二次不变量、c>0、实际矩阵指数Hamiltonian流及其时间h恰为离散步，并给两能量有界域O(h²)比例差；全部k/椭圆由SymplecticEulerEllipse、弱稳态由SymplecticWeakStationary承担。新增模型是显式技术选择，不冒称唯一修正能量。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：symplecticEulerShadow\_statement是所有实h、所有z的一步Q\_h保持，Q\_h=(q²+p²−hqp)/2；对摘录辛Euler步[[1−h²,h],[-h,1]]此恒等式正确。新增c(h)在h=0特判1，|h|<2内为正；A=c(h)[[-h/2,1],[-1,h/2]]正是cQ\_h的Hamilton向量场。设s=sqrt(1−h²/4)，该未缩放矩阵平方=−s²I，角θ=2arcsin(h/2)满足sinθ=hs、cosθ=1−h²/2，故exp(hA)精确给数值步。flow定义含初值、群律和每时刻ODE，主模型全部合取正确，h=0亦成立。c(h)=1+h²/6+O(h⁴)，有界球上差界C h²合理，量词C,δ可依赖R。[EXTRA]准确；但原书无条件椭圆说法不成立，需保留疑误人工处理，新增正确模型不消除此原文问题。 本条全部本地声明：MD.Ch05.symplecticEulerShadow, MD.Ch05.symplecticEulerLogScale, MD.Ch05.symplecticEulerModifiedHamiltonian, MD.Ch05.symplecticEulerModifiedFlow, MD.Ch05.symplecticEulerShadow\_modified\_model, MD.Ch05.symplecticEulerShadow\_modified\_scale\_order。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticEulerShadow`：已证；`MD.Ch05.symplecticEulerLogScale`：定义；`MD.Ch05.symplecticEulerModifiedHamiltonian`：定义；`MD.Ch05.symplecticEulerModifiedFlow`：定义；`MD.Ch05.symplecticEulerShadow_modified_model`：未证（原书疑误不证）；`MD.Ch05.symplecticEulerShadow_modified_scale_order`：未证（原书疑误不证）；`MD.Ch05.symplecticEulerShadow_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2437)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEulerEllipse · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> the solution through any given initial point remains confined to an ellipse for all $`n`$ defined by $`\widetilde H_h(q,p)=\widetilde H_h(q_0,p_0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerEllipse : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z) := by
  intro h hh
  let d := 2-|h|
  have hd : 0 < d := by dsimp [d];linarith
  have lower (z : MolecularDynamics.Chapter05Review.E 2) :
      d*((z 0)^2+(z 1)^2) ≤ 4*MolecularDynamics.Chapter05Review.shadowOscillator h z := by
    unfold MolecularDynamics.Chapter05Review.shadowOscillator
    dsimp [d]
    by_cases hp : 0 ≤ h
    · rw [abs_of_nonneg hp]
      nlinarith [mul_nonneg hp (sq_nonneg (z 0-z 1))]
    · rw [abs_of_neg (lt_of_not_ge hp)]
      nlinarith [mul_nonneg (neg_nonneg.mpr (le_of_lt (lt_of_not_ge hp))) (sq_nonneg (z 0+z 1))]
  have normeq (z : MolecularDynamics.Chapter05Review.E 2) : ‖z‖^2=(z 0)^2+(z 1)^2 := by
    rw [EuclideanSpace.norm_sq_eq]
    simp [Fin.sum_univ_two,Real.norm_eq_abs]
  refine ⟨?_,?_,?_⟩
  · intro z hz
    have hnorm : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    have hl := lower z
    rw [←normeq] at hl
    nlinarith [mul_pos hd hnorm]
  · intro c
    have hc : Continuous (MolecularDynamics.Chapter05Review.shadowOscillator h) := by
      unfold MolecularDynamics.Chapter05Review.shadowOscillator;fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|/d+1)).of_isClosed_subset hclosed
    intro z hz
    have hl := lower z
    rw [←normeq] at hl
    change MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c at hz
    have hle : ‖z‖^2 ≤ 4*|c|/d := (le_div_iff₀ hd).mpr (by nlinarith [le_abs_self c])
    have hB : 0 ≤ 4*|c|/d := by positivity
    rw [Metric.mem_closedBall,dist_zero_right]
    nlinarith [norm_nonneg z]
  · intro z k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply',MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved,ih]

theorem symplecticEulerEllipse_geometry (h : ℝ) (_hh : |h| < 2) :
    {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=0}={0} ∧
    (∀ c : ℝ,0 < c → Nonempty
      (↥{z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z=c} ≃ₜ
        ↥(Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) := by
  sorry



/-- 修正版，对应原文 MD-5.6-SymplecticEulerEllipse。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticEulerEllipse_corrected : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEulerEllipse`；`MD.Ch05.symplecticEulerEllipse_geometry`；`MD.Ch05.symplecticEulerEllipse_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]稳定条件\|h\|<2；原不加资格的椭圆说法在\|h\|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]稳定条件|h|<2；原不加资格的椭圆说法在|h|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。；[EXTRA] 保留正定/全部k保持证明，并补正能级椭圆拓扑及零能级单点退化；二次不变量作为modified Hamiltonian的显式固定选择，实际场/流资格见SymplecticWeakStationary，不声称唯一修正能量。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：修正版主定理对所有|h|<2给非零点Q\_h>0、每个实c的次水平集紧性、每个z及全部自然k的能量保持；包含负c时空集和k=0。geometry另断言零能级={0}，每个c>0的能级与单位圆同胚，数学正确。二次型矩阵[[1,−h/2],[-h/2,1]]特征值1±h/2均正，结合显式二次型可认定几何椭圆；单独同胚本身只表达拓扑圆，不能作为一般集合是几何椭圆的充分定义。条目14还提供与主对数Hamiltonian的正比例联系，故修正版范围内能级与modified模型一致。[EXTRA]明确，sorry不构成签名FAIL。原文无稳定区及零初值例外须人工裁定。 本条全部本地声明：MD.Ch05.symplecticEulerEllipse, MD.Ch05.symplecticEulerEllipse\_geometry。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticEulerEllipse`：已证；`MD.Ch05.symplecticEulerEllipse_geometry`：未证（原书疑误不证）；`MD.Ch05.symplecticEulerEllipse_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2481)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SymplecticEulerDensity · unnumbered_claim · 印刷p.207 / PDFp.228

### 2. 原文陈述

> This implies that a density which is a function of $`\widetilde H_h`$ will remain invariant under the associated Liouville equation. There are many solutions of $`\mathcal L_{\widetilde f}^{\dagger}\rho=0`$, none of which is attractive.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerDensity :
  ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h) →
    MeasurePreserving (MolecularDynamics.Chapter05Review.symplecticEuler h) (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h))
      (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.symplecticEulerDensity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。 | [EXTRA] |

[EXTRA] [EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅离散映射的函数能量密度不变；连续modified能量场、概率弱稳态多样与非吸引由MD-5.6-SymplecticWeakStationary承担，原整段保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对象为实二维欧氏相空间；对所有实 h 满足 |h|<2 及所有 r:ℝ→ℝ，前提要求 r∘shadowOscillator 可测、非负、可积且积分为1，结论为实际辛Euler映射对该密度测度的 MeasurePreserving。矩阵为 [[1-h²,h],[-h,1]]，行列式为1，保持 (q²+p²-hqp)/2，故结论正确；h=0亦无问题。能量与原modified Hamiltonian只差可能的h依赖常数因子，不改变“能量的函数”这一类。这里只通过已明示的离散密度不变范围；连续弱稳态、多解和非吸引不在该签名内，跨条映射仅记录，未以未提供的声明作为已核验证据。

### 7. 状态与证明位置

incomplete；`MD.Ch05.symplecticEulerDensity`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2551)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-VerletShadow2 · definition · 印刷p.208 / PDFp.229

### 2. 原文陈述

> For the Verlet scheme the modified Hamiltonian is

$$
\widetilde H_h=H+\frac{h^2}{24}\left(2p^TM^{-1}U''(q)M^{-1}p-\nabla U(q)M^{-1}\nabla U(q)\right)+O(h^4).
$$


> Actually, as explained previously, we must interpret this carefully: a finite truncation of this expansion may characterize the discrete trajectories observed in practice, but the series expansion itself does not typically converge.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def verletShadow2 {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ) (h : ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  let v : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 fun i => z.2 i/m i
  (∑ i,z.2 i^2/m i)/2+U z.1+h^2/24*
    (2*(fderiv ℝ (fderiv ℝ U) z.1) v v-∑ i,(MolecularDynamics.Chapter05Review.grad U z.1 i)^2/m i)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.verletShadow2` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean4.34.0/Mathlibv4.34.0 的标准定义；未要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目自定义已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开：E n=EuclideanSpace ℝ (Fin n)，Phase n=E n×E n，grad H=gradient H，energySurface H c={z | H z=c}。附件声明和项目同名定义均展开为 v\_i=p\_i/m\_i，H₂(q,p)=∑p\_i²/(2m\_i)+U(q)+(h²/24)(2D²U(q)[v,v]−∑(∂_iU(q))²/m\_i)。fderiv、欧氏 gradient 与 WithLp.toLp 2 的标准含义直接给出矩阵式 pᵀM⁻¹U″M⁻¹p 和力平方项。对原书正对角质量矩阵、光滑 U，逐项系数、负号、对象一致；任意 n、m、U、h、z 的定义没有额外命题量词。本条 context\_notation 明确是有限 h² 截断定义，PASS 限于该表达式：未证明原算法的 O(h⁴) 余项、近似轨道性质或形式级数不收敛。零质量/不可微函数上的总化值不被当作物理 Hamiltonian。无 [EXTRA] 或 [ERRATUM?]；定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.verletShadow2`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2559)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-Theorem51 · Theorem 5.1 · 印刷p.208–209 / PDFp.229–230

### 2. 原文陈述

> Theorem 5.1 Let $`H(q,p)`$ and $`\widetilde H(q,p)=H(q,p)+\varepsilon\eta(q,p)`$ be two Hamiltonian functions. Suppose the energy surface $`\Sigma_E=\{(q,p)\mid H(q,p)=E\}`$ to be compact and define the perturbed energy surface by $`\widetilde\Sigma_E=\{(q,p)\mid\widetilde H(q,p)=E\}`$, also assumed compact.
> Suppose that $`w`$ is an arbitrary smooth vector field such that $`w\cdot\nabla H\ne0`$ on $`\Sigma_E`$. Then the perturbation of the microcanonical average of a smooth function $`g`$ is given by

$$
\operatorname{Av}_{H=E}(g)-\operatorname{Av}_{\widetilde H=E}(g)=\operatorname{Av}_{\widetilde H=E}(\nabla\cdot gu)-\operatorname{Av}_{\widetilde H=E}(g)\operatorname{Av}_{\widetilde H=E}(\nabla\cdot u)+O(\varepsilon^2),
$$


> where $`u=\varepsilon\eta w/(w\cdot\nabla H)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem theorem51 :
  ∀ n (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c,
    0 < n → ContDiff ℝ ∞ H → ContDiff ℝ ∞ η → ContDiff ℝ ∞ g → ContDiff ℝ ∞ w →
    MolecularDynamics.Chapter05Review.regularEnergy H c → (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.theorem51` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |

[EXTRA] [EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化所有正维实欧氏空间、H/η/g/w及能量c；四个对象均C∞。regularEnergy明确含非空、紧、梯度非零及微正则原始质量有限正。统一紧集K同时包含ε邻域内全部扰动能量面（ε=0亦包含原面），其上分母不为零；这些是已披露的加强条件，防止从无穷远产生未控制分支。microRaw为面积测度乘1/‖∇H‖，microMeasure按总质量归一。结论完整保留平均差、校正项和存在C>0、δ>0对所有|ε|<δ成立的Cε²界。u的分母使用原H，两个右端平均使用H+εη，div(gu)包含g div u；符号及归一化协方差项与原式一致。任意正维推广不依赖辛结构，属合法几何推广。

### 7. 状态与证明位置

incomplete；`MD.Ch05.theorem51`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2567)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-PerturbationDisplacement · definition · 印刷p.209 / PDFp.230

### 2. 原文陈述

> $`u=\varepsilon\frac{\eta}{w\cdot\nabla H}w`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def perturbationDisplacement {n : ℕ} (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  (ε*η z/inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)) • w z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.perturbationDisplacement` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean4.34.0/Mathlibv4.34.0 的标准定义；未要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目自定义已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开：E n=EuclideanSpace ℝ (Fin n)，Phase n=E n×E n，grad H=gradient H，energySurface H c={z | H z=c}。附件声明与项目同名定义逐点均为 u(z)=(εη(z)/⟨w(z),∇H(z)⟩)w(z)，与 PDF230 的分数、乘法和向量方向完全相同；H、η、w、ε 先作参数，再取 z。原书横截条件及 context\_notation 明示相关带内分母非零，这属于该表达式的数学适用域，定义并未另断言位移公式在分母零处成立。Lean 实数除法的总化不构成此合格域上的差异。无 [EXTRA] 或 [ERRATUM?]；定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.perturbationDisplacement`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2581)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-PerturbationCorrection · definition · 印刷p.209 / PDFp.230

### 2. 原文陈述

> $`\operatorname{Av}_{H=E}(g)-\operatorname{Av}_{\widetilde H=E}(g)=\operatorname{Av}_{\widetilde H=E}(\nabla\cdot gu)-\operatorname{Av}_{\widetilde H=E}(g)\operatorname{Av}_{\widetilde H=E}(\nabla\cdot u)+O(\varepsilon^2)`$;

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.perturbationCorrection` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Theorem5.1右端两个平均组成的校正项定义；完整正则能量族平均误差估计由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意维数、实值H/η/g、向量场w及实c/ε，定义Hε=H+εη、u=(εη/⟨w,∇H⟩)w，返回Av\_Hε(div(gu))−Av\_Hε(g)Av\_Hε(div u)。乘法次序、负号、两处能量面及完整散度均正确。该定义是总函数，未假设光滑、正则或分母非零；这些条件应由使用它的定理提供，不能仅凭定义推得原公式。已披露范围仅为校正项。

### 7. 状态与证明位置

self-contained；`MD.Ch05.perturbationCorrection`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2586)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DenominatorBound · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> Suppose that $`w`$ is an arbitrary smooth vector field such that $`w\cdot\nabla H\ne0`$ on $`\Sigma_E`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem denominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|) (MolecularDynamics.Chapter05Review.energySurface H c))
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.denominatorBound_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.denominatorBound` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅紧能量面横截分母的正下界衍生引理；原光滑与横截资格及完整平均扰动公式由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数及H/w/c，假设原能量面紧、绝对分母在该面连续且分母逐点非零，结论是存在统一a>0使面上绝对分母≥a。非空情形用紧集上正连续函数的最小值；空面情形结论真空成立，故无需增补非空性。无需H光滑即可作为已明示的衍生引理成立；不替代Theorem5.1。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.denominatorBound`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2595)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-SmoothDenominatorBound · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> Suppose that $`w`$ is an arbitrary smooth vector field such that $`w\cdot\nabla H\ne0`$ on $`\Sigma_E`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem smoothDenominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c)) (hH : ContDiff ℝ 2 H) (hw : Continuous w)
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.smoothDenominatorBound_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.smoothDenominatorBound` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]由C² H、连续w自动得到实际连续分母和紧性下界；正式已证特殊后果，不当完整微正则扰动定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA]由C² H、连续w自动得到实际连续分母和紧性下界；正式已证特殊后果，不当完整微正则扰动定理。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅C² H/连续w的横截分母下界一般化衍生引理；原光滑资格及完整公式由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数H/w/c；H为C²、w连续、能量面紧、横截分母非零。C²保证∇H连续，因而绝对内积连续，得到统一正下界；空能量面亦成立。C²/连续条件弱于原smooth，是合理的一般化且已在[EXTRA]披露；完整扰动公式不属于此条。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.smoothDenominatorBound`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2605)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-ZeroPerturbation · unnumbered_claim · 印刷p.208–209 / PDFp.229–230

### 2. 原文陈述

> $`\widetilde H(q,p)=H(q,p)+\varepsilon\eta(q,p)`$; $`u=\varepsilon\eta w/(w\cdot\nabla H)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem zeroPerturbation {n : ℕ} (H g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c ε :
    MolecularDynamics.Chapter05Review.perturbationCorrection H (fun _ => 0) g w c ε=0 := by
  apply MolecularDynamics.Chapter05Review.zeroPerturbation_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.zeroPerturbation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]η恒0时实际校正函数为0的直接后果；不将零扰动特例冒充任意η的平均误差定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。 | [EXTRA] |

[EXTRA] [EXTRA]η恒0时实际校正函数为0的直接后果；不将零扰动特例冒充任意η的平均误差定理。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅η≡0校正量为零的后果；一般位移定义由MD-5.6-PerturbationDisplacement、完整平均误差由MD-5.6-Theorem51承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意维数、H/g/w及c/ε，无额外正则假设，η恒0时位移恒为零。Lean实数除法的总化约定使0/0也为0；零向量场及g乘零场的导数、散度为零，两个零函数积分为零。因此实际perturbationCorrection恒0，对奇异面或零分母亦成立。结论严格限于校正量的零扰动特例。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.zeroPerturbation`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2614)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-GradientTransverse · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> A natural choice of the function $`w`$ that appears in the theorem is $`w=\nabla H`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gradientTransverse :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
    ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (MolecularDynamics.Chapter05Review.grad H z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0 := by
  intro n H c hn z hz
  exact inner_self_ne_zero.mpr (hn z hz)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gradientTransverse` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正则能量面grad H非零，实际平方范数保证横截；不是任意能量处的无条件结论。 | [EXTRA] |

[EXTRA] [EXTRA]正则能量面grad H非零，实际平方范数保证横截；不是任意能量处的无条件结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean4.34.0/Mathlibv4.34.0 的标准定义；未要求 Ch05\_deps.txt 提供 Mathlib 定义体。项目自定义已在 Ch05\_deps.txt 的 -- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开：E n=EuclideanSpace ℝ (Fin n)，Phase n=E n×E n，grad H=gradient H，energySurface H c={z | H z=c}。先固定 n、H、c，要求能量面上 ∇H≠0，再对所有该面上的 z 得 ⟨∇H(z),∇H(z)⟩≠0。这是欧氏内积平方范数的标准性质，确实验证选取 w=∇H 的横截资格；任意正则 H 都适用。[EXTRA] 梯度非零必要且合理，也由原定理任何横截 w 的存在推出。原文光滑 H 的上下文使 ∇H 光滑，本声明没有声称对不光滑 H 的梯度也光滑；在该上下文中保留了选择及其适用条件。无 [ERRATUM?]；附件展示证明仅用 inner\_self\_ne\_zero，无 sorry，本轮不编译、不补证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gradientTransverse`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2620)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.6-DynamicalCorrection · unnumbered_claim · 印刷p.209 / PDFp.230

### 2. 原文陈述

> The interpretation of a dynamical average (e.g. an autocorrelation function) as a stationary average means that we can apply the perturbation result to such computations as well.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem dynamicalCorrection :
  ∀ n d (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c t,
    0 < n → ContDiff ℝ ∞ H → ContDiff ℝ ∞ η → ContDiff ℝ ∞ w →
    ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ (Φ t) → MolecularDynamics.Chapter05Review.regularEnergy H c →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧ MolecularDynamics.Chapter05Review.energySurface H c ⊆ K ∧
      (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) ∧
      ∀ ε ∈ Ioo (-δ) δ,MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K) →
    let g := fun z => inner ℝ (a (Φ t z)) (b z)
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.dynamicalCorrection` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 | [EXTRA] |

[EXTRA] [EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。；[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化n/d、H/η/w、向量观测a/b、任意时间族Φ及固定c/t；n>0，相关函数及Φ t均C∞，原面regularEnergy，扰动面由同一紧K容纳且K上分母非零。g(z)=⟨a(Φ(t,z)),b(z)⟩光滑，对这个固定且不随ε变化的g，完整Cε²平均差结论是Theorem5.1的实例。不要求Φ为H的流，是对固定光滑pullback的合法推广；不证明H与Hε各自不同动力学之间的相关函数误差。[EXTRA]已明确这一限制，不能据此推广到随ε变化的Φ。

### 7. 状态与证明位置

incomplete；`MD.Ch05.dynamicalCorrection`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L2630)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

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

