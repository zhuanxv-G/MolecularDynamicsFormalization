[上一部分](part02.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

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

## 1. MD-4.2.2-MollifiedStructure · unnumbered_claim · 印刷p.149 / PDFp.171

### 2. 原文陈述

> In each of the mollified multiple timestepping methods, since only the potential energy is modified, and by a smooth mapping of positions, the forces derived by differentiating $`\overline U`$ are still conservative, and, just as with the MTS method, the scheme remains symplectic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mollifiedStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (A : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (MolecularDynamics.Chapter04Review.mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m (MolecularDynamics.Chapter04Review.mollifiedPotential US A) UF r h) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.mollifiedStructure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。 | [EXTRA] |

[EXTRA] 正质量、US/UF/A C²、r>0；实际Fréchet链式法则及RESPA的Jacobian辛性，不假定保结构结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；结论：PASS，针对实际RESPA/Verlet实现及任意C²位置映射；原文的两项结构结论均可由所用真实定义读取，不靠名称或sorry判断。实际附件是 /workspace/Ch04.lean；在 input\_sha256 中按请求使用逻辑键 Blueprint/Ch04.lean。以下为只读签名及定义审计，未编辑附件、未补证明、未将compact摘录作为独立工程编译。
全部对象与量词顺序：∀n:ℕ、m:Fin n→ℝ、US UF:Q n→ℝ、A:Q n→Q n、r:ℕ、h:ℝ，随后依次假设∀i,0<m i、ContDiff ℝ 2 US、ContDiff ℝ 2 UF、ContDiff ℝ 2 A、0<r。结论为链式法则与辛性之合取；链式法则再对所有q,v:Q n量化。h未被要求为小正数，无隐藏依赖顺序或先假设结论。
复合势与保守力展开：库 -- FILE: MolecularDynamics/Chapter04/ReviewDefinitions.lean 的mollifiedPotential US A=US∘A，Q n=Fin n→ℝ。第一合取为D(US∘A)(q)[v]=DUS(A(q))[DA(q)[v]]。同文件grad U q=textbookConstraintGradient U q，而 -- FILE: MolecularDynamics/Chapter04/ConstrainedProjection.lean 的后者逐分量给出DU(q)[e\_i]。kick U t(q,p)=(q,p−t grad U(q))，故实际慢力F\_i(q)=−D(US∘A)(q)[e\_i]=−DUS(A(q))[DA(q)e\_i]，即全局标量势的负梯度。原文 conservative 虽未单独引入谓词，但实际力及其势的关系已被这些定义直接表达，未漏用DA，也未把力保守作为前提。
算法展开：respa m U UF r h(q,p)=kick U(h/2)((fastVerlet m UF(h/r))^[r](../../kick U(h/2)(q,p)))，其中U=US∘A。fastVerlet=Chapter02Review.verlet m(−grad UF)；展开 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 的verlet及invMass，给出q⁺=q+tM⁻¹p−t²M⁻¹grad UF(q)/2和p⁺=p−t(grad UF(q)+grad UF(q⁺))/2。快势和快步未被复合映射替换，只有慢势kick使用复合势，符合原页紧接着的 only applied ... modifying the slow impulse 的解释。任意C²的A覆盖本批所谈位置映射，不要求A为可逆映射、辛映射或平均构造。
辛性结论展开：同一库文件Z n=Q n×Q n，dot a b=Σ\_i a\_i b\_i，phaseForm(u,v)=Σ\_i u\_qi v\_pi−Σ\_i v\_qi u\_pi。symplecticMap G真正声明∀z,u,v，phaseForm((fderiv ℝ G z)u,(fderiv ℝ G z)v)=phaseForm(u,v)，即标准辛形式的实际Fréchet导数拉回。该算法在给定C²假设下有C¹梯度和C¹更新，故不存在靠不可微点的fderiv默认值空洞表达辛性的情形。此处不是只检验行列式或抽象性质。
[EXTRA]逐项评估：正质量为原物理常质量的合理资格，数学上非零质量已足够，正性不是最弱假设；US、UF、A的C²确保复合势C²、梯度C¹及Hessian对称，是保结构所需的合理充分光滑性，比原 smooth 的无限光滑要求更弱而不损失该结论；r>0保证自然数细分及h/r有实际步数意义，排除了无快步的r=0退化情形，虽该退化代数映射也可单独保辛。上述条件均未假设待证链式法则、保守性或辛性。以实际RESPA和fastVerlet表达是批次明确采用的实现范围，不声称证明了未指定的任意快积分器也辛。
[ERRATUM?]：本条无该标注，所引原文未发现需要改写的数学错误。证明状态独立记录：Ch04.lean中mollifiedStructure的证明体是by sorry；依赖Statements.lean的mollifiedStructure\_statement只是对应Prop定义。PASS仅指签名和展开后语义忠实，不表示证明已完成或编译验证通过。

### 7. 状态与证明位置

incomplete；`MD.Ch04.mollifiedStructure`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L911)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-HolonomicRelation · (4.3) · 印刷p.149–150 / PDFp.171–172

### 2. 原文陈述

> In this section we consider holonomic constraints which may be expressed in terms of positions only, and perhaps time, i.e.

$$
g(q,t)=0.\tag{4.3}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.holonomicRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；g的位置参数为Q n、显式时间参数为ℝ、值为Q l；沿给定位置曲线对每个实时间要求g(q(t),t)=0。没有独立动量参数或错误地删除显式时间依赖。它是全实轴曲线满足完整约束的定义，不是声称任意曲线均满足约束。

### 7. 状态与证明位置

self-contained；`MD.Ch04.holonomicRelation`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L919)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-TimeConstraintDerivative · unnumbered_claim · 印刷p.150 / PDFp.172

### 2. 原文陈述

> Note that by differentiating (4.3) with respect to time, we obtain $`\nabla_q g(q,t)\cdot\dot q+\partial g/\partial t=0`$ which involves velocities.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem timeConstraintDerivative :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0 := by
  intro n l g q t v hg hq hz
  have hp : HasDerivAt (fun s : ℝ => (q s,s)) (v,1) t := hq.prodMk (hasDerivAt_id t)
  have hd : HasDerivAt (fun s => g (q s) s)
      ((fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)) t :=
    hg.hasFDerivAt.comp_hasDerivAt (f := fun s : ℝ => (q s,s)) t hp
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz
  exact hd.unique hzero
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.timeConstraintDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。 | [EXTRA] |

[EXTRA] g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 Function.uncurry g 的对象是位置×时间；量词为任意 n,l,g,q,t,v，依次要求联合可微、q 在 t 的实际导数为 v、局部约束恒等于零，结论为 Dg(q(t),t)(v,1)=0。该结论按线性性展开正是 D\_qg·q̇+∂_tg=0；联合可微和曲线可微是原文链式求导所需的合理 [EXTRA]，局部恒零足以且比全时恒零弱，没有把所求结论作前提。Ch04.lean:576–587 给出链式法则和导数唯一性证明，无 sorry；本结论仍为签名审计而非编译验证。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.timeConstraintDerivative`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L924)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstrainedSolution · (4.4)–(4.9) · 印刷p.152 / PDFp.174

### 2. 原文陈述

> the equations of motion may be written

$$
\dot q=M^{-1}p,\tag{4.4}
$$



$$
\dot p=-\nabla U(q)-\sum_{k=1}^l\lambda_k\nabla g_k(q),\tag{4.5}
$$



$$
0=g_j(q),\quad j=1,2,\ldots,l.\tag{4.6}
$$


> then we may write the constrained equations of motion in the form

$$
\dot q=M^{-1}p,\quad\text{(4.7)}\qquad\dot p=-\nabla U(q)-g'(q)^T\lambda,\quad\text{(4.8)}\qquad0=g(q).\quad\text{(4.9)}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

def constrainedSolution_generalForce {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedSolution`；`MD.Ch04.constrainedSolution_generalForce` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。 | [EXTRA] |

[EXTRA] [EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主定义在开时间域I逐时要求真实HasDerivAt：q′=m⁻¹p、p′=−grad U−Gᵀρ及每个标量约束为零。m分量严格正、U及所有g\_j可微都显式给出；grad和G来自实际Fréchet导数，矩阵转置乘法正是逐约束求和。ρ是待检验曲线的参数而非已假设存在的乘子。generalForce允许任意F及within导数，作为明确命名的辅助定义保留合理；一般域包含退化域，因此不可单独当经典运动的主接口。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constrainedSolution`：定义；`MD.Ch04.constrainedSolution_generalForce`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L939)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintSet · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> Constraints such as those described above define a manifold in the configuration space $`\mathcal M=\{q\mid g(q)=0\}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry



/-- 修正版，对应原文 MD-4.3-ConstraintSet。改动：修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。 -/
```

独立修正版：

```lean
theorem constraintSet_corrected (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ∞ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ∞ φ A ∧ ContDiffOn ℝ ∞ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintSet`；`MD.Ch04.constraintSet_regularLevel`；`MD.Ch04.constraintSet_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。 | [EXTRA] |

[EXTRA] 定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。；[EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 修正版明确满秩、C∞和维数资格，以局部可逆坐标描述正则约束面；任意零点集合不自动是流形。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；零点集合定义忠实。regularLevel在l≤n、各g\_j光滑、q为零点及真实向量导数满射的EXTRA条件下给出开邻域、双向光滑互逆坐标、q映至0及前l个坐标为零的完整等价，确实是余维l局部嵌入流形正规形。∞用于C∞符合目标。修正版签名正确，但原句未注明正则性即泛称流形，不能用增加前提消除原书疑误。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constraintSet`：定义；`MD.Ch04.constraintSet_regularLevel`：未证（原书疑误不证）；`MD.Ch04.constraintSet_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L961)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-CotangentSet · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> The set of pairs $`(q,p)`$ satisfying, simultaneously, the equations

$$
g(q)=0,\qquad g'(q)M^{-1}p=0,
$$


> is called the co-tangent bundle associated to the manifold $`\mathcal M`$, and we refer to it as $`T^*\mathcal M`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.cotangentSet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量及独立梯度为几何解释资格。 | [EXTRA] |

[EXTRA] 正质量及独立梯度为几何解释资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 定义的元素确为相空间中的(q,p)，两个且仅两个集合成员条件逐分量展开为 g(q)=0 与 g′(q)M⁻¹p=0；未漏掉同时满足要求。原文在这里用这两个等式命名其嵌入相空间的余切集合，该集合实现忠实，不能据此宣称已经构造抽象余切丛。正质量保证质量逆的物理解释，梯度独立和光滑性保证基底流形及通常余切丛解释；[EXTRA] 为这些解释资格而非成员条件中额外过滤条件，合理。任意 m,g 的总化扩展不能单独承载上述几何解释，但不改变本条所给集合等式。定义无 sorry。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.cotangentSet`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L998)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintJacobian · definition · 印刷p.152 / PDFp.174

### 2. 原文陈述

> It is often convenient to combine all the constraints and to describe them by a single vector-valued function $`g:\mathbb R^{N_c}\to\mathbb R^l`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i

def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintJacobian`；`MD.Ch04.combineConstraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 在同一source\_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。 | [EXTRA] |

[EXTRA] [EXTRA] 在同一source\_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；combineConstraints把Fin l族标量函数按q↦(j↦g\_j(q))组合成Q n→Q l，完整覆盖原句。constraintJacobian的行j列i为真实Fréchet导数在第i个基向量上的取值，尺寸l×n，作为相邻(4.8)的附加对象已被EXTRA区分；没有只交付Jacobian而遗漏向量函数。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintJacobian`：定义；`MD.Ch04.combineConstraints`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1003)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-JacobianActualDerivative · unnumbered_claim · 印刷p.152 / PDFp.174

### 2. 原文陈述

> Given a motion $`(q(t),p(t),\lambda(t))`$ of (4.7)–(4.9) we note that $`g(q(t))\equiv0`$ at all times $`t`$, hence, by differentiation

$$
g'(q(t))\dot q(t)\equiv0,
$$


> which we may rephrase as

$$
g'(q(t))M^{-1}p(t)\equiv0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem jacobianActualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap := by
  apply MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative <;> assumption

theorem jacobianActualDerivative_curve (n l : ℕ)
    (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (p v : MolecularDynamics.Chapter04Review.Q n) (t : ℝ)
    (_hg : ∀ j, DifferentiableAt ℝ (g j) (q t)) (_hq : HasDerivAt q v t)
    (_hv : v=MolecularDynamics.Chapter04Review.invMass m p)
    (_hc : ∀ᶠ s in 𝓝 t, ∀ j, g j (q s)=0) :
    textbookConstraintJacobian g (q t) *ᵥ v=0 ∧
    textbookConstraintJacobian g (q t) *ᵥ MolecularDynamics.Chapter04Review.invMass m p=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.jacobianActualDerivative`；`MD.Ch04.jacobianActualDerivative_curve` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。 | [EXTRA] |

[EXTRA] [EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。；[EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；首声明在各标量函数于q可微时把实际Jacobian等同向量函数Fréchet导数的标准矩阵。curve声明在任意时刻t、实际速度v、v=m⁻¹p及邻域内所有约束恒零的前提下，同时给出Gv=0和Gm⁻¹p=0。局部邻域恒零是从完整运动中抽取的足够条件；未循环假设隐藏约束。只需速度方程，不需无关的加速度/乘子前提。

### 7. 状态与证明位置

incomplete；`MD.Ch04.jacobianActualDerivative`：已证；`MD.Ch04.jacobianActualDerivative_curve`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1015)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3-ConstraintDegrees · unnumbered_claim · 印刷p.151 / PDFp.173

### 2. 原文陈述

> Note that with $`l`$ constraints the actual number of degrees of freedom, which is needed for things like the computation of temperature, is $`N_d=N_c-l`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constraintDegrees :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l) (q : MolecularDynamics.Chapter04Review.Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n := by
  intro n l g q hg hs
  have hh := LinearMap.finrank_range_add_finrank_ker (fderiv ℝ g q).toLinearMap
  rw [LinearMap.range_eq_top.mpr hs] at hh
  simpa [add_comm] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constraintDegrees` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。 | [EXTRA] |

[EXTRA] [EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 fd88a08d64fd41ccdf0275379f551900977af72e2ec1ce6ab6151e2ae0335b61）。
网站原返回（对应其审校版本）：PASS；依赖已展开：Chapter04Review.Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m p 的第 i 分量为(m i)⁻¹p i；constraintSet g={q | ∀j,g j q=0}。textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian γ q j i 为此梯度第 i 分量，故矩阵乘向量第 j 分量为 D(γ j)(q)v，转置乘乘子第 i 分量为Σj λj ∂iγj。依赖位置：Ch04\_deps.txt:2975、3385、4377–4383、4428–4436。 量词依次为维数 n,l、真实向量约束 g 和点 q，再给可微及真实导数满射条件；结论 dim ker Dg+l=n 等价于独立约束下 Nd=Nc−l。满射保证 l≤n，避免自然数截断伪装维数关系；没有把维数关系作为前提。原文未显式说独立约束，但这是自由度公式必要而合理的 [EXTRA]，例如重复约束不应重复扣减。当前结论是线性化可行速度空间的维数；如进一步声称零集为光滑流形，还需合适邻域光滑性，当前定理不含此额外几何声称。Ch04.lean:621–630 的证明用秩零化度公式，无 sorry。 本审计只读，不修改附件、不补证明；未运行Lean编译。未发现本条的[ERRATUM?]标记。

### 7. 状态与证明位置

self-contained；`MD.Ch04.constraintDegrees`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1035)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

