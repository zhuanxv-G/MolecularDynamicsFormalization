[上一部分](part07.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part09.zh-CN.md)

## MD-6.3.8-LangevinFPEquation

印刷p.244 / PDFp.265；§6.3.8。

### 1. 原文陈述

> the formula for the Kolmogorov operator becomes

$$
\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin n → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) (ρ : ℝ → ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P → (∀ i, 0 < m i) → 0 < γ → 0 < β →
  MolecularDynamics.Chapter06Review.langevinMassSDE P W X m U γ β⁻¹ x0 → ContDiff ℝ ∞ U →
  ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ t ∈ Icc lo hi,
    ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.langevinMassForward m U γ β (ρ t) x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实任意质量Langevin过程和实际非负平滑密度law及求导尾部资格；不以弱PDE或强PDE作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际前提调用的是Chapter06Review.langevinMassSDE，不是同名MD加强版；已逐字展开核对：它给出连续路径和所有非负t的q、p积分方程，噪声为sqrt(2γβ⁻¹mi)(Wi(t)−Wi(0))。正质量、γ/β正性及U光滑由定理另行补齐，连续路径保证这里的漂移沿有限区间可积。结论对任意t>0、全部相点给出真实law密度的时间导数等于D10算子；没有预设PDE。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinFPEquation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1879`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-MassGibbsStationary

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of

$$
\mathcal L^\dagger\rho_{\rm eq}\equiv0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem massGibbsStationary : ∀ {n : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ) (γ β : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → 0 < γ → 0 < β →
  ∀ x, MolecularDynamics.Chapter06Review.langevinMassForward m U γ β
    (fun z ↦ Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实任意正质量与匹配β⁻¹噪声；完整原Gibbs权重的形式stationarity验证，不将它计为Markov演化测度不变性。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D10与massHamiltonian的全部质量权重匹配：H=∑pi²/(2mi)+U，ρ=exp(−βH)。Hamilton项互消，摩擦项与γβ⁻¹mi的扩散项互消。正质量、光滑U及γ/β正性已明列。只断言形式算子为零，[EXTRA]已说明没有归一化或测度不变性结论；例如U=0时权重在非紧q空间不归一化也不影响该代数微分恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.massGibbsStationary` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1894`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-UnitMassGibbsStationaryBridge

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of

$$
\mathcal L^\dagger\rho_{\rm eq}\equiv0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem unitMassGibbsStationaryBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U) (β γ σ : ℝ) (hβ : 0 < β)
    (hσ : σ ^ 2 = 2 * γ / β) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (textbookLangevinGibbsWeight U β) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_gibbs_eq_zero <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]现成真实单位质量原机械Hamiltonian权重、σ²=2γ/β的前向形式表达；未代表任意质量或真实过程测度不变性全部已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。单位质量相空间、机械Hamiltonian、Gibbs指数及σ²=2γ/β一致。给出的前向定义沿冻结漂移方向作一阶导数，加实际相空间散度及全部动量二阶导数；散度为−γN，势力只需U可微，因为散度只对动量力的动量变量求导。结论是任意z上的形式消去，不声称一般质量或概率测度不变性。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.unitMassGibbsStationaryBridge` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1902`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-VariableFrictionForward

印刷p.239 / PDFp.260；§6.3.3。

### 1. 原文陈述


$$
dp=-\nabla U(q)dt-\Gamma(q)\Gamma(q)^T pdt+\sqrt{2k_BT}M^{1/2}\Gamma(q)d\widehat W.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def variableFrictionForward {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  (∑ i, (-(m i)⁻¹*x.2 i*fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z ↦ (textbookConfigurationPartial U i z.1+
      ((Γ z.1*(Γ z.1).transpose).mulVec z.2) i)*ρ z) x (0,Pi.single i 1))) +
  ∑ i, ∑ k, θ*Real.sqrt (m i)*Real.sqrt (m k)*(Γ x.1*(Γ x.1).transpose) i k *
    fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single k 1)) x (0,Pi.single i 1)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整原矩形Γ、任意质量的实际漂移与噪声协方差导出形式前向表达，供验证canonical资格；没有偷换为常矩阵或单位质量。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：定义对任意n、r、m、U、空间依赖Γ、θ、密度ρ和相点x；位置项−m\_i⁻¹p\_i∂qiρ，动量项∂pi[(∂iU+(ΓΓᵀp)i)ρ]，扩散θ√m\_i√m\_k(ΓΓᵀ)ik∂pi∂pkρ，恰为该SDE协方差的一半。Γ只依赖q，不需动量导数落在Γ上。签名为形式算子，可在非正m上有Lean总定义；物理对应限于正质量、光滑密度，不把此定义当PDE或stationarity证明。[EXTRA]的任意质量应理解为任意正质量。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.variableFrictionForward` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1910`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-VariableFrictionCanonicalPrinted

印刷p.239 / PDFp.260；§6.3.3。

### 1. 原文陈述

> However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $`\gamma`$ or $`\Gamma(q)`$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem variableFrictionCanonicalPrinted : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem variableFrictionCanonicalPrinted_corrected : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]该条为原恢复canonical目标的必要形式stationarity检验；完整任意质量/Γ对象保留，不以必要检验计完整采样收敛已证。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。C：量化任意n/r、正m、光滑U/Γ、θ>0以及所有相点，断言D42作用于未归一化exp(−H/θ)为0；对象、Hamiltonian质量分母和全部结论无遗漏。但该Printed全称命题不成立。作为原书canonical目标的必要检验可保留，不能认定数学PASS；也没有证明归一化存在或采样遍历性。[EXTRA]正确提醒必要性，不修复非交换问题。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.variableFrictionCanonicalPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1923`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-VariableFrictionCommutingStationary

印刷p.239 / PDFp.260；§6.3.3。

### 1. 原文陈述

> $`\gamma`$ or $`\Gamma(q)`$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem variableFrictionCommutingStationary : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry

/-- 修正版，对应原文 MD-6.3.3-VariableFrictionCanonicalPrinted；改动：增加ΓΓᵀ与质量矩阵M交换条件；另一个可选修法是修改漂移以匹配噪声协方差。 -/
theorem variableFrictionCanonicalPrinted_corrected : ∀ {n r : ℕ} (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ),
  (∀ i, 0 < m i) → ContDiff ℝ ∞ U → ContDiff ℝ ∞ Γ → 0 < θ →
  (∀ q, (Γ q*(Γ q).transpose)*Matrix.diagonal m=Matrix.diagonal m*(Γ q*(Γ q).transpose)) →
  ∀ x, variableFrictionForward m U Γ θ
    (fun z ↦ Real.exp (-θ⁻¹*MolecularDynamics.Chapter06Review.massHamiltonian m U z)) x=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确ΓΓᵀ与M交换，保留任意维度/矩形Γ及完整Gibbs权重stationarity；未直接假设stationarity或声称采样收敛。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：除条目13所有对象/域/量词外，明确∀q，A(q)M=MA(q)，A=ΓΓᵀ。正对角M下A仅在同质量块内耦合，故M½AM½=AM，噪声协方差2θAM与摩擦Ap匹配。D43质量Hamiltonian给Hamilton输运抵消、动量部分抵消，所有x处形式Gibbs stationarity结论正确。无须Γ与M本身交换，实际条件正好作用于A。未预设结论，也未宣称归一化、遍历或平均收敛。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.variableFrictionCommutingStationary` | 未证 | 时间盒止 | PASS |
| `MD.Ch06.variableFrictionCanonicalPrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1932`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-StochasticMatrix

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> A discrete Markov Chain is a stochastic process in which, at each step, a transition is made from the current state $`i`$ to another $`j`$ selected from a given probability distribution. In the case of a finite collection of states $`\Sigma=\{1,2,\ldots,k\}`$, we assume that the transition probabilities $`\pi_{ij}\in[0,1]`$ are given and denote the state at time $`n`$ by $`S_n`$. Thus we have

$$
\Pr(S_{n+1}=j\mid S_n=i)=\pi_{ij}.
$$


> The sum of the elements in row $`i`$ gives the probability of being in some state at time $`n+1`$ given that we were in state $`i`$ at time $`n`$, thus it is one.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stochasticMatrix {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  (∀ i j, 0 ≤ PiMark i j) ∧ ∀ i, ∑ j, PiMark i j = 1
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意有限k×k实矩阵，所有元素非负且每行总和1，恰为右随机矩阵；每项≤1由这些条件推出，非遗漏。Fin k的0起始重编号与原{1,…,k}无语义差异；k=0为形式定义的空域推广。这里只定义矩阵资格，不伪称构造了随机过程。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stochasticMatrix` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1950`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteDistribution

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> A distribution on the state space is typically associated to a row vector $`\psi=(\psi_1,\psi_2,\ldots,\psi_k)`$ with nonzero elements and which is normalized such that

$$
\sum_{i=1}^k\psi_i=1.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteDistribution {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

/-- 修正版，对应原文 MD-6.4.1-FiniteDistribution；改动：原nonzero单独保留为严格正权重版本；一般定义采用非负权重、总和1。 -/
def finiteDistribution_corrected {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

/-- 【原书疑误】保留nonzero按正概率权重的字面版本。 -/
def finiteDistributionPrinted {k : ℕ} (ψ : Fin k → ℝ) : Prop :=
  (∀ i, 0 < ψ i) ∧ ∑ i, ψ i=1

/-- 边界概率向量(1,0)是概率分布，但不满足印刷nonzero权重资格。 -/
theorem finiteDistributionPrinted_counterexample :
    finiteDistribution (fun i : Fin 2 ↦ if i=0 then 1 else 0) ∧
      ¬ finiteDistributionPrinted (fun i : Fin 2 ↦ if i=0 then 1 else 0) := by
  constructor
  · constructor
    · intro i
      dsimp only
      split_ifs <;> norm_num
    · norm_num [Fin.sum_univ_two]
  · intro h
    have hi := h.1 (1 : Fin 2)
    norm_num at hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]概率权重取非负，允许零概率状态；原nonzero作为“typically”的描述而非概率的必要条件，不添加严格正初值要求。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐个审校：finiteDistribution及\_corrected均为非负且总和1的一般概率向量；finiteDistributionPrinted按概率权重上下文将nonzero保留为严格正且总和1；反例(1,0)确实满足前者且不满足后者。三种对象及counterexample相互吻合。原句含typically，不能无条件把原文认定为错误定义；应保留人审。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteDistribution` | 定义 | — | PASS |
| `MD.Ch06.finiteDistribution_corrected` | 定义 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.finiteDistributionPrinted` | 定义 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.finiteDistributionPrinted_counterexample` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1956`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteEvolution

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> The probability of being in state $`i`$ at the $`n+1`$st iteration, is the sum over $`j`$ of the probabilities of being in state $`j`$ multiplied by the probability of transitioning from state $`j`$ to state $`i`$, thus

$$
\psi_{n+1}=\psi_n\Pi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) (n : ℕ) : MolecularDynamics.Chapter06Review.V k :=
  Matrix.vecMul ψ (PiMark^n)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义ψ\_n=ψ₀Πⁿ，Matrix.vecMul方向是行向量右乘；n=0得到初值，全部分量保留。原递推式与此闭式等价（19另列完整递推定理）。作为线性演化定义允许任意实矩阵/向量，不声称它们都是概率；无需额外随机性前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteEvolution` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1980`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteEvolutionRecurrence

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述


$$
\psi_{n+1}=\psi_n\Pi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem finiteEvolutionRecurrence : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ)
    (initial : Fin k → ℝ) (n : ℕ),
  MolecularDynamics.Chapter06Review.finiteEvolution matrix initial (n+1)=
    Matrix.vecMul (MolecularDynamics.Chapter06Review.finiteEvolution matrix initial n) matrix := by
  intro k matrix initial n
  simp only [MolecularDynamics.Chapter06Review.finiteEvolution, pow_succ]
  exact (Matrix.vecMul_vecMul initial (matrix^n) matrix).symm
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意k、矩阵、初始向量及n均量化，结论把n+1步演化严格等于第n步行向量右乘同一个矩阵，是原递推的完整形式。由矩阵幂和行乘结合律成立，不需要随机矩阵或正初值。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteEvolutionRecurrence` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1984`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-ReturnTimes

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> For each state of the chain, we define the number $`d(i)`$ to be the greatest common divisor of all integers $`l`$ such that $`\pi_{ii}^{(l)}\gt 0`$ (if the probability of return to state $`i`$ is zero, then we set $`d(i)=0`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Πˡ正返回时间l>0，排除0步恒等阵；原gcd周期定义必须如此解读。

### 6. 审计结论（含网站结论）

网站原返回：PASS。返回时间集恰为所有正自然数n且(Πⁿ)ii>0，排除n=0恒等阵的平凡返回。[EXTRA]已明示这一解读，与原无返回时周期0的约定一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.returnTimes` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1994`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Period

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> For each state of the chain, we define the number $`d(i)`$ to be the greatest common divisor of all integers $`l`$ such that $`\pi_{ii}^{(l)}\gt 0`$ (if the probability of return to state $`i`$ is zero, then we set $`d(i)=0`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ MolecularDynamics.Chapter06Review.returnTimes PiMark i, d ∣ n}
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对正返回时间的公因子取自然数sSup：返回集非空时公因子被任一返回时间界住，最大者就是gcd；返回集空时公因子集为全部ℕ，Mathlib自然数条件完备序的无界sSup取0，符合书中特殊约定。不能把无界sSup误当作自然数中的无穷大而判错。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.period` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1998`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Aperiodic

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> If $`d(i)=1`$, for all $`i`$ then we say that the chain is aperiodic.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, MolecularDynamics.Chapter06Review.period PiMark i = 1
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有状态i均要求实际D18周期等于1；D16/D18与21所核对定义一致。没有偷换成单个状态、存在状态或仅自环条件。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.aperiodic` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2002`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Irreducible

印刷p.245–246 / PDFp.266–267；§6.4.1。

### 1. 原文陈述

> States $`i`$ and $`j`$ are said to communicate if $`\pi_{ij}^{(l_1)}\gt 0`$ and $`\pi_{ji}^{(l_2)}\gt 0`$ for some integers $`l_1`$ and $`l_2`$. This means that it is possible to reach $`j`$ from $`i`$ with positive probability and vice-versa.
> A finite state space model is irreducible if every state is reachable from every other state in a finite “time”, where time in this context refers to the number of iterations of the chain. Equivalently, we say the model is irreducible if all states communicate.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对每一对i,j存在有限自然数n使(Πⁿ)ij>0；交换全称变量即可得到反向存在，时间可不同，等价所有状态互相communicate。允许n=0只增加同状态的平凡可达性，不改变不同状态连通要求。原矩阵幂的文字方向有上下文笔误，但该全称双向定义不受影响。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.irreducible` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2005`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteInvariant

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> An invariant distribution is a left eigenvector of $`\Pi`$, having only non-negative elements, and corresponding to the eigenvalue 1. That is, an invariant distribution $`\psi_*`$ satisfies

$$
\psi_*=\psi_*\Pi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) : Prop :=
  MolecularDynamics.Chapter06Review.finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实Chapter06Review.finiteDistribution要求非负且总和1，再以Matrix.vecMul ψ Π=ψ表达特征值1的左不变性；完整概率对象而不是未归一化/零特征向量。总和1由distribution的前文语义继承合理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteInvariant` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2008`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteErgodicity

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> The fundamental result for Markov chains is the following: If a given Markov chain is both irreducible and aperiodic, then it can be shown that there is a unique invariant distribution $`\psi_*`$ such that

$$
\lim_{n\to\infty}\psi_n=\psi_*,
$$


> for arbitrary initial distribution $`\psi_0`$. The convergence of an irreducible finite Markov chain to its stationary distribution can be understood through the properties of its eigenvalues by applying of the Perron-Frobenius theorem (see [269]).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem finiteErgodicity :
  ∀ {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ),
  0 < k → MolecularDynamics.Chapter06Review.stochasticMatrix PiMark → MolecularDynamics.Chapter06Review.irreducible PiMark → MolecularDynamics.Chapter06Review.aperiodic PiMark →
  ∃ ψ : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteInvariant PiMark ψ ∧ (∀ χ, MolecularDynamics.Chapter06Review.finiteInvariant PiMark χ → χ=ψ) ∧
    ∀ ψ0 : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteDistribution ψ0 → Tendsto (MolecularDynamics.Chapter06Review.finiteEvolution PiMark ψ0) atTop (𝓝 ψ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]非空真实有限状态、右随机矩阵、全部幂Πⁿ、真实全部初始概率；完整存在、唯一性及任意初值向量收敛，不假设谱隙或收敛结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。非空有限域、实际右随机性、所有状态不可约且非周期的前提完整；结论为概率不变向量存在、在全部概率不变向量中唯一，以及所有初始概率向量的Πⁿ演化向该向量收敛。没有把谱隙或收敛作为前提，[EXTRA]说明准确。完整定理的非周期性排除了原末句单独阅读时的周期反例。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteErgodicity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2013`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-StochasticEntryBound

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> it is a matrix whose entries are all nonnegative and less than or equal to 1.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem stochasticEntryBound : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix → ∀ i j, matrix i j ≤ 1 := by
  intro k matrix h i j
  rw [← h.2 i]
  exact Finset.single_le_sum (fun k _ ↦ h.1 i k) (Finset.mem_univ j)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。输入实际stochasticMatrix已包含全部元素非负，结论逐一给出≤1；合在一起正是原条目全部[0,1]界。对任意k,i,j成立，来自行和1及其余元素非负，无遗漏。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stochasticEntryBound` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2021`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteChainExample

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> Fig. 6.6 A Markov matrix (left) and its graph representation (right). In this example, the Markov Chain is not irreducible.

$$
\Pi=\begin{bmatrix}0.2&0.1&0.7&0&0\\0&0&0&1&0\\0.3&0&0&0.3&0.4\\0&0.5&0&0.3&0.2\\0&0&0&1&0\end{bmatrix}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteChainExample : Matrix (Fin 5) (Fin 5) ℝ :=
  !![(1/5),(1/10),(7/10),0,0;
     0,0,0,1,0;
     (3/10),0,0,(3/10),(2/5);
     0,(1/2),0,(3/10),(1/5);
     0,0,0,1,0]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐个核对图6.6矩阵25个数值及行列方向；1/5=0.2、1/10=0.1、7/10=0.7、3/10=0.3、2/5=0.4、1/2=0.5，全部零和1也一致。该定义只负责数值矩阵，不可约结论由29独立审校。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteChainExample` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2028`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-ExampleStochastic

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> Fig. 6.6 A Markov matrix (left) and its graph representation (right).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem exampleStochastic : MolecularDynamics.Chapter06Review.stochasticMatrix finiteChainExample := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [finiteChainExample]
  · intro i
    fin_cases i <;> norm_num [finiteChainExample, Fin.sum_univ_succ]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原具体数值矩阵的真实随机行资格检查。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实谓词对27的完整数值矩阵逐项要求非负和行和1。五行分别为1、1、1、1、1，所有项非负；[EXTRA]是该具体例的资格检查，没有添加原例中不存在的假设。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.exampleStochastic` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2037`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-ExampleNotIrreducible

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> In this example, the Markov Chain is not irreducible.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem exampleNotIrreducible : ¬ MolecularDynamics.Chapter06Review.irreducible finiteChainExample := by
  have hz : ∀ n : ℕ,
      (finiteChainExample^n) (1 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (3 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (4 : Fin 5) 0=0 := by
    intro n
    induction n with
    | zero => norm_num
    | succ n ih =>
      rw [pow_succ']
      simp only [finiteChainExample] at ih
      norm_num [Matrix.mul_apply, Fin.sum_univ_succ, finiteChainExample,
        ih.1, ih.2.1, ih.2.2]
  intro h
  obtain ⟨n,hn⟩ := h (1 : Fin 5) (0 : Fin 5)
  rw [(hz n).1] at hn
  linarith
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际irreducible是所有有序状态对存在正概率有限步转移。按书中1起始标签，{2,4,5}为闭类，无法达到1或3，因此矩阵确实不不可约。没有误把无向连通或单步全正性当作不可约。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.exampleNotIrreducible` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2045`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Communicates

印刷p.245–246 / PDFp.266–267；§6.4.1。

### 1. 原文陈述

> States $`i`$ and $`j`$ are said to communicate if $`\pi_{ij}^{(l_1)}\gt 0`$ and $`\pi_{ji}^{(l_2)}\gt 0`$ for some integers $`l_1`$ and $`l_2`$. This means that it is possible to reach $`j`$ from $`i`$ with positive probability and vice-versa.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def communicates {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ) (i j : Fin k) : Prop :=
  (∃ n : ℕ, 0 < (matrix^n) i j) ∧ ∃ n : ℕ, 0 < (matrix^n) j i
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。两个方向分别使用存在自然数n，允许不同时间；矩阵幂正项忠实表达正概率可达。原句的integers结合Markov步数解读为非负整数，不能允许任意负幂；这是上下文限定而不是额外概率假设。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.communicates` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2064`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-DirectedGraphIrreducible

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> Then one may understand irreducibility as expressing the connectedness of this graph (see Fig. 6.6).
> For a directed graph, we must have, for any pair of vertices $`A`$ and $`B`$, paths which take us from $`A`$ to $`B`$ and vice-versa.

### 2. 原文证明

> 原书未给独立完整证明。 本摘录第二句来自同页脚注8；正文与脚注间有省略。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem directedGraphIrreducible : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix →
  (MolecularDynamics.Chapter06Review.irreducible matrix ↔
    ∀ i j, Relation.ReflTransGen (fun a b ↦ 0 < matrix a b) i j) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实正权边与有向路径可达关系；∀i,j强连通，不用无向连通偷换。

### 6. 审计结论（含网站结论）

网站原返回：PASS。有限非负行随机矩阵；irreducible为任意i,j存在自然数次幂正元，右侧为正权边自反传递闭包。非负性排除路径贡献抵消；n=0与零长路径相合，k=0亦无遗漏。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.directedGraphIrreducible` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:2069`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderCoordinates

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Now consider an SDE system defined on the space $`D=\mathbb T^{k_1}\times\mathbb R^{k_2}`$ for non-negative integers $`k_1`$ and $`k_2`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderCoordinates {k₁ k₂ : ℕ} (z : Fin (k₁+k₂) → ℝ) :
    (Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ) :=
  (fun i ↦ (z ⟨i.val, by omega⟩ : AddCircle (1 : ℝ)), fun j ↦ z ⟨k₁+j.val, by omega⟩)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际圆环商坐标与Euclidean非紧坐标；局部微分表达通过周期lift解释，不偷换D为纯ℝⁿ。

### 6. 审计结论（含网站结论）

网站原返回：PASS。k₁、k₂取任意自然数，允许零；前k₁个实坐标商到AddCircle 1，后k₂个保留为实数。维数及真正的圆环×非紧空间均正确，定义是坐标投影这一明确[EXTRA]构造。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderCoordinates` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2077`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderSDE

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Now consider an SDE system defined on the space $`D=\mathbb T^{k_1}\times\mathbb R^{k_2}`$ for non-negative integers $`k_1`$ and $`k_2`$:

$$
dX=b_0(X)dt+\sum_{i=1}^r b_i dW_i;\tag{6.43}
$$


> where $`b_0`$ is $`C^\infty`$ and the $`W_i`$ are independent standard Wiener processes. In this book, we will only consider the analysis for the case of additive noise (i.e. the $`b_i`$ vectors multiplying a Wiener process are constant).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderSDE {Ω : Type*} [MeasurableSpace Ω] {k₁ k₂ r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ))
    (X : ℝ → Ω → ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)))
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ) (x0 : Fin (k₁+k₂) → ℝ) : Prop :=
  ContDiff ℝ ∞ (fun z ↦ b₀ (cylinderCoordinates z)) ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  ∃ lift : ℝ → Ω → (Fin (k₁+k₂) → ℝ),
    strictVectorSDE P W lift (fun z _ ↦ b₀ (cylinderCoordinates z)) (fun _ _ ↦ B) x0 ∧
    (∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → X t sample=cylinderCoordinates (lift t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实D及其周期lift、原C∞漂移、常矩形B和全部严格Ito积分；仅方程意义，不预置遍历/不变结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义同时要求周期lift漂移C∞、D6独立标准Wiener向量、全部常噪声矩阵和D4严格路径方程；输出X确实在圆环×实空间中，且几乎处处对所有非负时刻等于lift投影。x0是选定实lift初值，[EXTRA]已明确；没有先假设遍历或不变性。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2083`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderGenerator

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Working in flat $`L^2`$ space, we have that the infinitesmal generator for (6.43) acting on a smooth test function $`\phi(X)`$ is

$$
\mathcal L\phi=b_0\cdot\nabla\phi+\tfrac12\operatorname{Tr}(B^T\phi''B);
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderGenerator {k₁ k₂ r : ℕ}
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ)
    (φ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → ℝ) (z : Fin (k₁+k₂) → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorGenerator (fun y ↦ b₀ (cylinderCoordinates y)) B
    (fun y ↦ φ (cylinderCoordinates y)) z
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。展开vectorGenerator后是一阶方向导数Dφ·b₀加D7扩散的一半；φ和b₀都经cylinderCoordinates拉回，输入空间和全部k₁+k₂方向正确。此处给出局部微分表达式的定义，不是另一个声称已证明强生成元域的定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2095`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

