[上一部分](part02.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## MD-6.1.5-VirialTemperature

印刷p.223 / PDFp.244；§6.1.5。

### 1. 原文陈述

> An even simpler configuration-dependent choice is derived from $`G=(q,0)^T`$, corresponding to

$$
k_BT=\frac{\operatorname{Av}_\beta(q\cdot\nabla U)}{N_c}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem virialTemperature : ∀ {n : ℕ} (hn : 0 < n)
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → ContDiff ℝ 2 U →
  Integrable (fun q ↦ Real.exp (-β*U q)) →
  Integrable (fun q ↦ (∑ i, q i * textbookConfigurationPartial U i q) * Real.exp (-β*U q)) →
  (∃ C : ℝ, 0 ≤ C ∧ ∀ q, ‖q‖ * Real.exp (-β*U q) ≤ C) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    (∑ i, x.1 i * textbookConfigurationPartial U i x.1) *
      MolecularDynamics.Chapter06Review.canonicalDensity volume
        (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) / n = β⁻¹ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际全配置空间、n>0、一般正质量、正β及C²U；真实加权virial可积且配置通量统一有界，不假设平均温度公式。

### 6. 审计结论（含网站结论）

网站原返回：PASS。n>0、所有质量正、β正、C²U；配置权重及virial权重可积，并有‖q‖exp(-βU)统一界。光滑正权重可积使配置partition正；可由有界配置通量与权重截断得∫q·∇U w=nZ/β，再结合可分离高斯动量，得到全Phase平均除n=β⁻¹。没有假定温度公式；n>0确保相除合法。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.virialTemperature` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:551`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-VirialFieldNotPeriodic

印刷p.224 / PDFp.245；§6.1.5。

### 1. 原文陈述

> However $`G(z)=(q,0)^T`$ is problematic for periodic boundary conditions.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem virialFieldNotPeriodic : ∀ {n : ℕ} (i : Fin n) (q : Fin n → ℝ),
  q + Pi.single i 1 ≠ q := by
  intro n i q h
  have hi := congrFun h i
  simp at hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]沿实际单位周期坐标平移时配置部分q变化，因此G=(q,0)不定义周期torus向量场；i : Fin n自动排除零维空坐标情形。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀n,i:Fin n,q；结论为q+e\_i≠q。评价第i坐标即q\_i+1≠q\_i，准确表达virial配置部分不周期；i的存在已排除零维。没有错误地把环面上相等的商类与实空间代表相等混淆。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.virialFieldNotPeriodic` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:566`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-DensityPositive

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> The quantity $`Z_{\rm can}`$ is a normalizing constant so that this is a probability density.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem densityPositive : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  0 < (∫ z, Real.exp (-β*H z) ∂ν) →
  ∀ x, 0 < MolecularDynamics.Chapter06Review.canonicalDensity ν H β x := by
  intro D inst ν H β hZ x
  exact div_pos (Real.exp_pos _) hZ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实partition严格正时实际密度点态正；不将正密度作前提，积分为一在独立Normalization条目。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同一D1、任意D、ν、H、β；唯一前提是实际分母严格正。指数逐点严格正，故对全部x密度严格正。此结论不需要另设可积性或β>0；没有把积分归一化混入结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.densityPositive` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:574`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-KineticWeightFactorization

印刷p.221 / PDFp.242；§6.1.5。

### 1. 原文陈述

> then we may decompose the unnormalized canonical distribution as

$$
\exp(-\beta[K(p)+U(q)])=\exp(-\beta K(p))\exp(-\beta U(q)) =\exp(-\beta U(q))\prod_{i=1}^{N_c}\exp\left(-\beta\frac{p_i^2}{2m_i}\right).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem kineticWeightFactorization : ∀ {n : ℕ}
    (m q p : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U (q,p)) =
    Real.exp (-β*U q) * ∏ i, Real.exp (-β*(p i)^2/(2*m i)) := by
  intro n m q p U β
  unfold MolecularDynamics.Chapter06Review.massHamiltonian
  rw [mul_add, Real.exp_add, Finset.mul_sum, Real.exp_sum, mul_comm]
  congr 1
  apply Finset.prod_congr rfl
  intro i hi
  congr 1
  ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]保存每坐标质量和实际有限乘积；这是点态指数代数恒等式，正质量是物理解释所需，不计积分/能均分已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀n,m,q,p,U,β均无符号限制；D5有限和及exp加法/有限和公式给出完整乘积。即使质量为0，Lean实数除法的总定义也使两边同样处理相应项，代数恒等式仍真；正质量仅是物理使用条件，[EXTRA]文字不应误读为实际签名前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kineticWeightFactorization` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:583`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2-EnergySupportObstruction

印刷p.224 / PDFp.245；§6.2。

### 1. 原文陈述

> It should be apparent that constant-energy dynamics (designed to sample the microcanonical ensemble with constant energy $`E`$) will not sample the canonical distribution in the absence of the heat bath: such Newtonian trajectories cannot access regions of the phase space where $`H(z)\neq H(z_0)`$, where $`z_0`$ is the initial condition.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem energySupportObstruction :
  ∀ {n : ℕ} (H : MolecularDynamics.Chapter06Review.V n → ℝ) (E : ℝ)
    (z : ℝ → MolecularDynamics.Chapter06Review.V n) (μ : Measure (MolecularDynamics.Chapter06Review.V n)), Continuous H →
  (∀ t, H (z t) = E) → 0 < μ {x | H x ≠ E} →
  (∀ t, z t ∉ {x | H x ≠ E}) ∧ μ {x | H x ≠ E} ≠ 0 := by
  intro n H energy z μ hH hz hpositive
  constructor
  · intro t ht
    exact ht (hz t)
  · exact hpositive.ne'
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际能量守恒轨道、连续H及另一能量区域有正μ测度；本条是支持障碍，完整积分/时间平均障碍在下一条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀n,H,E,z,μ；连续H、全部实时间能量守恒、另一能量集合测度正。结论同时给出所有时间避开该集合和目标集合非零测度，严格支持障碍。μ任意测度而非专门canonical，属于已标注的抽象推广；不冒称已建立时间平均反例。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.energySupportObstruction` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:599`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2-CanonicalSamplingObstruction

印刷p.224 / PDFp.245；§6.2。

### 1. 原文陈述

> such Newtonian trajectories cannot access regions of the phase space where $`H(z)\neq H(z_0)`$, where $`z_0`$ is the initial condition.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem canonicalSamplingObstruction : ∀ {n : ℕ}
    (H : MolecularDynamics.Chapter06Review.V n → ℝ) (energy : ℝ)
    (z : ℝ → MolecularDynamics.Chapter06Review.V n)
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [IsProbabilityMeasure μ],
  Continuous H → (∀ t, H (z t) = energy) → 0 < μ {x | H x ≠ energy} →
  ∃ g : MolecularDynamics.Chapter06Review.V n → ℝ, Integrable g μ ∧
    0 < (∫ x, g x ∂μ) ∧
    Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 0) := by
  intro n H energy z μ inst hH hz hpositive
  let S : Set (MolecularDynamics.Chapter06Review.V n) := {x | H x ≠ energy}
  have hS : MeasurableSet S := (isClosed_singleton.preimage hH).isOpen_compl.measurableSet
  let g : MolecularDynamics.Chapter06Review.V n → ℝ := S.indicator (fun _ ↦ 1)
  have hgi : Integrable g μ := (integrable_const (1 : ℝ)).indicator hS
  have hIntegral : (∫ x, g x ∂μ)=μ.real S := integral_indicator_one hS
  have hzero : ∀ t : ℝ, g (z t)=0 := by
    intro t
    simp only [g, Set.indicator, S, Set.mem_setOf_eq, hz t, ne_eq, not_true_eq_false, ↓reduceIte]
  refine ⟨g,hgi,?_,?_⟩
  · rw [hIntegral]
    exact ENNReal.toReal_pos hpositive.ne' (measure_ne_top μ S)
  · have hfun : MolecularDynamics.Chapter05Review.timeAverage z g=(fun _ : ℝ ↦ 0) := by
      funext T
      simp [MolecularDynamics.Chapter05Review.timeAverage,hzero]
    rw [hfun]
    exact tendsto_const_nhds
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]目标为真实概率测度、其他能量区域正测度；结论构造实际可积检验函数，其沿轨道时间平均为零而目标平均严格正；不以采样失败为前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同一实向量空间上任意概率μ，连续H、轨道能量恒定、补能层正测度。取g为开集{H≠energy}的示性函数，概率空间上可积，积分正，轨道上恒0，所以D时间平均在所有T均0且极限0。无需轨道连续或可测，因为复合函数恒0。结论完整保留积分/时间平均采样障碍。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalSamplingObstruction` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:613`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-RademacherJumps

印刷p.225 / PDFp.246；§6.2.1。

### 1. 原文陈述

> In the classic model of a random walk the jump takes values $`\pm1`$ with equal probability.
> The increments of the random walk are the differences $`\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}`$, thus $`(X_n)`$ is a random process with independent increments.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def rademacherJumps {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun J P ∧ ∀ k,
    Measurable (J k) ∧ MemLp (J k) 2 P ∧
    (∀ᵐ sample ∂P, J k sample = 1 ∨ J k sample = -1) ∧ (∫ sample, J k sample ∂P) = 0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实概率空间、独立可测L²跳跃、AE取±1且期望零；这些条件保留公平Rademacher意义，不把二阶有限和结论作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意可测概率空间、独立可测L²跳跃、AE取±1且均值0，推出两点概率各1/2，正确表达公平Rademacher列。[EXTRA]中独立性和可积性均为实际条件；AE版本是概率变量的适当语义，不要求零测集上逐点取值。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.rademacherJumps` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:642`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-RandomWalk

印刷p.225 / PDFp.246；§6.2.1。

### 1. 原文陈述

> That is, we have

$$
X_{n+1}=X_n+\delta x J_n.
$$


> We initiate the random walk with $`X_0=0`$.
> The solution $`X_n`$ of the random walk may be written

$$
X_n=\delta x\sum_{k=0}^{n-1}J_k.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def randomWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  dx * ∑ k ∈ Finset.range n, J k sample
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

网站原返回：PASS。∀样本空间、J、dx,n,sample；range n确为k=0,…,n-1，有限和乘dx准确，n=0为空和。定义本身无需概率结构；初始值及递推在独立条目23、24审查。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.randomWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:649`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkRecurrence

印刷p.225 / PDFp.246；§6.2.1。

### 1. 原文陈述

> A random walk is a discrete stochastic process in which the state $`X_n`$ at a given instant (defined by the index $`n`$) is related to the state $`X_{n-1}`$, at step $`n-1`$ by an offset that may be viewed as a random variable. That is, we have

$$
X_{n+1}=X_n+\delta x J_n.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkRecurrence :
  ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample = MolecularDynamics.Chapter06Review.randomWalk J dx n sample + dx*J n sample := by
  intro Ω J dx n sample
  simp only [MolecularDynamics.Chapter06Review.randomWalk, Finset.sum_range_succ]
  ring
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

网站原返回：PASS。所有J、dx,n,sample，无概率或正步长假设；range(n+1)拆最后一项便得X_(n+1)=X\_n+dxJ\_n，量词、下标及结论完整。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkRecurrence` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:653`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkInitial

印刷p.225 / PDFp.246；§6.2.1。

### 1. 原文陈述

> We initiate the random walk with $`X_0=0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkInitial : ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx 0 sample = 0 := by
  intro Ω J dx sample
  simp [MolecularDynamics.Chapter06Review.randomWalk]
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

网站原返回：PASS。所有J、dx,sample，n=0时range为空，定义直接给0；无需随机性或额外假设。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkInitial` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:661`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkVariance

印刷p.225–226 / PDFp.246–247；§6.2.1。

### 1. 原文陈述

> hence the variance is

$$
\mathbb E X_n^2=\delta x^2\mathbb E\left(\sum_{k=0}^{n-1}J_k\right)^2.
$$


> Expanding the squared sum we see that there are (i) $`n`$ squares $`J_k^2`$ plus (ii) products of the form $`J_kJ_l`$, $`k\neq l`$. Clearly the former are always one and the latter have zero expectation, thus

$$
\mathbb E X_n^2=n\delta x^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkVariance :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J →
  (∫ sample, MolecularDynamics.Chapter06Review.randomWalk J dx n sample ∂P) = 0 ∧ (∫ sample, MolecularDynamics.Chapter06Review.randomWalk J dx n sample ^ 2 ∂P) = n*dx^2 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整真实概率、L²、独立且公平±1跳跃；同时保存零均值与原完整二阶矩，不将和的二阶矩或交叉项零作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意概率空间P、J、dx,n，在D14条件下零均值及完整二阶矩n dx²同时保留。独立性消去异指标乘积，AE的J\_k²=1给对角项；L²使有限和及平方可积。因此二阶矩等于原方差，未将待证矩作为假设。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkVariance` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:668`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-DiffusiveWalk

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> Let $`t_n=n\delta t`$, $`n=0,1,\ldots,\nu`$ and define

$$
Y(t_{k+1})=Y(t_k)+\sqrt{\delta t}J_k,\qquad k=0,1,\ldots,\nu-1,
$$


> where $`Y(0)=0`$. Effectively we are making the size of the jump $`\delta x`$ taken at each step of the random walk equal to $`\sqrt{\delta t}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def diffusiveWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt : ℝ) : ℕ → Ω → ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J (Real.sqrt dt)
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

网站原返回：PASS。定义是在全部自然数网格上取dx=sqrt(dt)的D22随机游走；原书有限窗口是其限制。物理使用dt>0时正确，定义对dt≤0的Lean总延拓不代表负时间步长物理主张。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.diffusiveWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:675`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-InterpolatedWalk

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> For points between $`t_k`$ and $`t_{k+1}`$ we define the value of $`Y(t)`$ by linear interpolation:

$$
Y(t)=Y_k+\frac{t-t_k}{\delta t}\Delta Y_k.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (MolecularDynamics.Chapter06Review.diffusiveWalk J dt (n+1) sample - MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample)
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

网站原返回：PASS。在dt>0、t≥0的原语境，n=Nat.floor(t/dt)正是网格区间编号；增量为Y_(n+1)-Y\_n，系数(t-n dt)/dt正确，端点也与网格值一致。定义对其他实数的延拓未声称为原书正步长过程。A层公式因子位置须恢复原页顺序。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.interpolatedWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:679`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkIncrement

印刷p.225–226 / PDFp.246–247；§6.2.1。

### 1. 原文陈述

> The increments of the random walk are the differences $`\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}`$, thus $`(X_n)`$ is a random process with independent increments.
> We will use the shorthand $`Y_k=Y(t_k)`$ and $`\Delta Y_k=Y_{k+1}-Y_k=\sqrt{\delta t}J_k`$. The increments are clearly independent.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample - MolecularDynamics.Chapter06Review.randomWalk J dx n sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。
- 覆盖缺口：仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。walkIncrement对任意样本类型、任意实跳过程J及实dx，定义randomWalk(n+1)-randomWalk(n)。randomWalk=dx*Σ_{k<n}J\_k，故是原文ΔX_(n+1)的重新编号。没有概率测度或J独立前提，因此没有宣称独立性。statement\_scope和coverage\_gaps已诚实注明只覆盖一步差分，未覆盖dx*J等式、扩散缩放或独立增量；按披露的局部范围PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkIncrement` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:686`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkGridMoments

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> Let us observe the following facts, for $`0\leq k\leq l\leq\nu`$

$$
(i)\quad\mathbb E(Y_l-Y_k)=0,\qquad(ii)\quad\operatorname{Var}(Y_l-Y_k)=t_l-t_k.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkGridMoments :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dt : ℝ) (k l : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → k ≤ l →
  (∫ sample, MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample ∂P) = 0 ∧
  (∫ sample, (MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample)^2 ∂P) = ((l : ℝ)-k)*dt := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际独立公平L²跳跃、正δt和k≤l；保存零均值与完整增量二阶矩，不假设这些结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀P,J,dt,k,l，D14、dt>0、k≤l。结论含增量均值0及二阶矩((l:ℝ)-k)dt；由零均值与L²等于原Var，涵盖k=l时零增量。无有限ν限制是同一无限跳跃列上的直接推广，可限制到任一窗口。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkGridMoments` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:691`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-InterpolatedWalkMean

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> Then, for $`0\leq t\leq s\leq\tau`$, we have

$$
\mathbb E(Y(s)-Y(t))=0.
$$


> This is easy to demonstrate. However, the intuitive corresponding statement $`\operatorname{Var}(Y(s)-Y(t))=(s-t)`$ does not quite hold due to the reliance on interpolation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem interpolatedWalkMean : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (J : ℕ → Ω → ℝ) (dt t s : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → 0 ≤ t → t ≤ s →
  (∫ sample, MolecularDynamics.Chapter06Review.interpolatedWalk J dt s sample -
    MolecularDynamics.Chapter06Review.interpolatedWalk J dt t sample ∂P) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实线性插值均值；任意有限正时间可置于τ窗口，不声称精确插值方差等于s−t。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀P,J,dt,t,s，D14、dt>0、0≤t≤s；D24插值值是有限个L²跳跃的确定线性组合，因此两插值之差可积且均值0。没有τ上界是可限制到任意有限窗口的推广；没有错误声称插值方差恰为s-t。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.interpolatedWalkMean` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:700`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkDiffusion

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).

$$
W(t)=\widehat{\lim}_{\delta t\to0}\sqrt{\delta t}\sum_{k=0}^{\lfloor t/\delta t\rfloor}J_k.
$$


> The convergence here, signified by the symbol $`\widehat{\lim}`$ is in the sense of distributions (see Appendix B).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkDiffusion :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (T : ℝ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < T →
  ∃ μ : Measure (C(Icc (0 : ℝ) T, ℝ)), IsProbabilityMeasure μ ∧
    (∀ t : Icc (0 : ℝ) T, μ.map (fun w ↦ w t) = gaussianReal 0 t.1.toNNReal) ∧
    (∀ s t : Icc (0 : ℝ) T, s ≤ t →
      HasLaw (fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w t-w s) (gaussianReal 0 (t.1-s.1).toNNReal) μ) ∧
    (∀ k : ℕ, ∀ ts : Fin (k+1) → Icc (0 : ℝ) T, Monotone ts →
      iIndepFun (fun i : Fin k ↦ fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w (ts i.succ)-w (ts i.castSucc)) μ) ∧
    ∀ F : C(Icc (0 : ℝ) T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
      ∃ Y : ℕ → Ω → C(Icc (0 : ℝ) T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample t, Y K sample t = MolecularDynamics.Chapter06Review.interpolatedWalk J (T/K) t sample) ∧
        Tendsto (fun K ↦ ∫ sample, F (Y K sample) ∂P) atTop (𝓝 (∫ w, F w ∂μ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整连续路径空间C([0,T],ℝ)弱法则、各时Gaussian边际、独立增量和全部有界连续路径检验函数；使用实际线性插值的n项和，不将单时CLT计为路径Donsker已证。
- [EXTRA]印刷含端点的多一项有限和与标准n项版本之差在扩散极限消失须另核；连续版本和不可微性质另条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。P为任意测度、J为可测独立零均值±1跳跃且P为概率；T>0。结论完整量化连续路径概率μ、所有单时边际、任意有序时刻增量法则和独立性，以及每个有界连续路径检验函数的积分极限。插值采用range n而非印刷含端点和，差至多√(T/K)（几乎处处）；与印刷扩散极限一致。[EXTRA]明确加强到路径弱收敛。Y虽在F之后存在，其K>0的值由插值唯一确定，未削弱检验族。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkDiffusion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:710`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerVector

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> As we take $`n`$ to infinity, $`\delta t`$ to zero, in such a way that $`n\delta t=t`$, we obtain the random variable $`W(t)`$ such that

$$
W(t)\sim N(0,t).
$$


> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$;

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def wienerVector {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) : Prop :=
  MolecularDynamics.textbookIsWienerVector B P
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

网站原返回：PASS。定义接受任意维数n、非负时间过程B及P；D12要求联合Gaussian、零均值、同坐标min(s,t)协方差、异坐标0及AE连续。属于已在context\_notation注明的多维Wiener结构别名；没有声称由单时CLT构造连续过程。标量边际/增量结论另见第3条。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerVector` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:726`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerIncrement

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> Moreover, we may easily demonstrate that

$$
\mathbb E(W(t)-W(s))^2=|t-s|.\tag{6.7}
$$


> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$;

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerIncrement :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P → ∀ s t : ℝ≥0,
      HasLaw (fun sample ↦ W t sample-W s sample) (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P ∧
      (∫ sample, (W t sample-W s sample)^2 ∂P)=|((t : ℝ)-s)| := by
  intro Ω inst P W hW s t
  have hl : HasLaw (fun sample ↦ W t sample-W s sample)
      (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P := by
    convert hW.hasLaw_sub t s using 1
    apply congrArg (gaussianReal 0)
    apply NNReal.coe_injective
    simp [Real.nndist_eq, Real.nnabs]
  refine ⟨hl, ?_⟩
  simpa only [Real.coe_toNNReal _ (abs_nonneg _)] using
    MolecularDynamics.textbookCenteredGaussian_secondMoment hl
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际IsPreBrownianReal模型、任意非负s,t、完整Gaussian法则与二阶矩；不局限等距网格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意PreBrownian实过程、任意非负s,t，完整保留方差|t−s|的中心Gaussian法则及二阶矩。t<s亦以对称Gaussian分布处理；t=s允许退化法则。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerIncrement` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:732`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerContinuousVersion

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerContinuousVersion :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∃ V : ℝ≥0 → Ω → ℝ, (∀ t, W t =ᵐ[P] V t) ∧ ∀ᵐ sample ∂P, Continuous (fun t ↦ V t sample) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]从实际PreBrownian Gaussian法则构造AE连续修改，保持每个时刻AE一致；不将连续性本身作存在连续版本定理的前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。从PreBrownian假设存在逐时AE相等的修改V，且同一满测度集上V整条非负时间路径连续；没有把连续性作为构造前提。此处是修改而非任意原版本与V不可分辨，符合原文可取连续路径的含义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerContinuousVersion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:750`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerNondifferentiable

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerNondifferentiable :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  (∀ᵐ sample ∂P, Continuous (fun t : ℝ≥0 ↦ W t sample)) →
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t → ¬ DifferentiableAt ℝ (fun s ↦ W s.toNNReal sample) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian法则与连续路径版本，结论AE每个正时刻不可微；不将不可微性作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。加入原版本AE连续假设后，在同一满测度集上所有正实时间点均不可微；不是仅每个固定时刻分别AE不可微。toNNReal在正时刻邻域为恒等。时间0的单侧不可微未陈述，[EXTRA]已明确正时刻范围。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerNondifferentiable` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:758`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerFutureCompletedHistory

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$; this does not depend on whether there is additional information available regarding its value prior to $`\min(t,s)`$, that is to say, the Wiener process is a Markov process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerFutureCompletedHistory
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion := by
  apply MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实多维Wiener、真实未来连续路径与整个零集完成的过去filtration独立；独立对象全部保留。粗事件条件概率式另条疑误，不将本条视为该式证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D12真实Wiener向量；未来定义B(S+t)−B(S)，D13在不连续样本上置零。结论为完整未来C([0,T],ℝ^Nc)生成σ代数与所有r≤S的过去σ代数加P零集生成σ代数，在P.completion下独立。T任意实数，T<0的空区间情形无额外断言。确实为未来增量路径独立，非未来原值独立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerFutureCompletedHistory` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:767`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-GridWienerIncrementLaw

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$;

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gridWienerIncrementLaw {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P := by
  apply MolecularDynamics.textbookWienerIncrement_hasLaw <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]等距T/K网格完整Gaussian法则；任意时刻原结论另条WienerIncrement保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。T为非负、K为自然数、k:Fin K自动使K>0。D14、D15给第k个T/K长度增量，结论为方差T/K的完整Gaussian法则。为已标明的网格辅助条，不冒充任意s,t定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gridWienerIncrementLaw` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:777`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-GridIncrementIndependent

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> this does not depend on whether there is additional information available regarding its value prior to $`\min(t,s)`$, that is to say, the Wiener process is a Markov process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gridIncrementIndependent {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P := by
  apply MolecularDynamics.textbookWienerIncrement_independent <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际等距有限增量族iIndepFun；整条未来路径独立在上一条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意K个相邻网格增量族整体iIndepFun，非仅两两独立；K=0为空族无碍。任意T≥0及PreBrownian假设与[EXTRA]一致；完整过去独立另在第6条。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gridIncrementIndependent` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:784`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerContinuousPathEval

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerContinuousPathEval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_eval <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]给定连续样本的真实C([0,T],ℝⁿ)值与所有时刻原路径一致；不证明从PreBrownian构造连续修改。

### 6. 审计结论（含网站结论）

网站原返回：PASS。不要求概率空间或Wiener性质；给定一条连续样本，D13真分支在每个t:Icc 0 T的值恰为原B值。假设、全称时间及向量值均吻合辅助求值条。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerContinuousPathEval` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:791`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerContinuousPathMeasurable

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerContinuousPathMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]给定真实连续Wiener模型导出整个连续路径空间AE可测性；不是将路径可测结论作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。由真实Wiener向量结构（包括AE连续）得整个连续路径空间映射AEMeasurable；不是仅各个时间点可测，也没有将路径可测性当前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerContinuousPathMeasurable` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:799`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

