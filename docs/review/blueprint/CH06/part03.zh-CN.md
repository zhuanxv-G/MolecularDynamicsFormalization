[上一部分](part02.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## MD-6.3.2-OUGibbsLimit

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> Let $`\sigma=\sqrt{2\gamma k_BT m}`$; then for large $`t`$ the exponentials of the form $`e^{-\gamma t}`$ tend to zero, and we have

$$
X(t)\approx\sqrt{k_BT m}\widehat Y(t);
$$


>  in which case $`X(t)`$ is drawn from the probability density

$$
\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouGibbsLimit :
  ∀ (γ θ m x0 : ℝ), 0 < γ → 0 < θ → 0 < m →
  ∀ f : ℝ → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ x, f x ∂gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 t)
      (MolecularDynamics.Chapter06Review.ouVariance γ (Real.sqrt (2*γ*θ*m)) t).toNNReal) atTop
      (𝓝 (∫ x, f x ∂gaussianReal 0 (θ*m).toNNReal)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]θ=kBT>0,m>0,γ>0；完整弱收敛，全部有界连续检验函数；不只证明均值/方差参数极限。

### 6. 审计结论（含网站结论）

网站原返回：PASS。γ,θ,m均正，σ=√(2γθm)，全部实t沿atTop；对所有有界连续f检验Gaussian测度积分，极限variance θm，均值0。完整弱收敛，不只均值方差参数收敛。负t的toNNReal总化不影响长时极限；本条未声称随机路径几乎处处收敛。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouGibbsLimit` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1278`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-MomentumOU

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> For a system with $`N_c`$ configurational variables we may write

$$
dp_i=-\gamma p_i dt+\sqrt{2\gamma k_BT m_i}\,dW_i;\tag{6.20}
$$


> where $`W_1(t),W_2(t),\ldots,W_{N_c}(t)`$ represent $`N_c`$ independent Wiener processes, or, in vectorial notation, denoting $`W=[W_1,W_2,\ldots,W_{N_c}]^T`$, we have

$$
dp=-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{6.21}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (γ θ : ℝ) (p0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧
  ∀ i, strictOUProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。

### 6. 审计结论（含网站结论）

网站原返回：PASS。momentumOU在任意n上要求整族向量Wiener（联合Gaussian、全跨时协方差、连续路径）、逐质量正、γ>0、θ>0，其中θ表示kBT；每坐标为γ相同、σ\_i=sqrt(2γθm\_i)、初态p0\_i的strictOUProcess。各噪声来自同一真实独立坐标Wiener，并非任意彼此相关标量过程。常系数线性方程对应对角M^(1/2)，签名PASS；不把该定义当作长期采样或不变性定理。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.momentumOU` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1288`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-GibbsGaussianDensity

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> in which case $`X(t)`$ is drawn from the probability density

$$
\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def gibbsGaussianDensity (θ m u : ℝ) : ℝ :=
  Real.exp (-(u^2/(2*m))/θ)/Real.sqrt (2*Real.pi*m*θ)
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

网站原返回：PASS。θ=kBT；exp(−(u²/(2m))/θ)/√(2πmθ)与原式相同。θ,m,u为实数；context明确θ,m>0才称概率密度。仅定义函数，不声称已证归一化或非正参数为密度，数学范围已注明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gibbsGaussianDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1295`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathHamiltonian

印刷p.236 / PDFp.257；§6.3.3。

### 1. 原文陈述

> We assume as in [138] that we are given a system of $`k`$ coupled oscillators (a “heat bath”) in contact with a distinguished particle. The Hamiltonian is

$$
H=\frac{P^2}{2}+\sum_{i=1}^k\frac{p_i^2}{2\mu_i}+U(Q)+\frac1{2k}\sum_{i=1}^k(q_i-Q)^2
$$


> where $`Q`$ and $`P`$ represent the position and momentum of the distinguished particle and $`\{q_i,p_i\}`$ are the positions and momenta of the particles of the bath, $`\mu_i`$ giving the mass of the $`i`$th light particle.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathHamiltonian {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (U : ℝ → ℝ) (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k) : ℝ :=
  P^2/2 + (∑ i, (p i)^2/(2*μ i)) + U Q + (∑ i, (q i-Q)^2)/(2*k)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式k>0及全部μi>0，避免零质量/零热浴大小的总化除法冒充物理模型。

### 6. 审计结论（含网站结论）

网站原返回：PASS。k>0、所有μ\_i>0显式参数，Q,P实数，q,p为Fin k→ℝ，U任意实势函数。动能p\_i²/(2μ\_i)、势能U Q及耦合1/(2k)均正确。定义能量无需U可微。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathHamiltonian` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1300`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathHamiltonEquations

印刷p.236 / PDFp.257；§6.3.3。

### 1. 原文陈述

> The equations of motion for the combined system are

$$
\dot Q=P;\quad\text{(6.22)}\quad\dot P=-U'(Q)-k^{-1}\sum_{i=1}^k(Q-q_i);\quad\text{(6.23)}
$$


> where, for $`i=1,2,\ldots,k`$,

$$
\dot q_i=p_i/\mu_i;\quad\text{(6.24)}\quad\dot p_i=(Q-q_i)/k.\quad\text{(6.25)}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathHamiltonEquations :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U : ℝ → ℝ)
    (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k), 0 < k → (∀ i, 0 < μ i) → DifferentiableAt ℝ U Q →
  deriv (fun z ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q z q p) P = P ∧
  -deriv (fun z ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U z P q p) Q = -deriv U Q-(∑ i : Fin k, (Q - q i))/(k : ℝ) ∧
  (∀ i, fderiv ℝ (fun v ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q P q v) p (Pi.single i 1) = p i/μ i) ∧
  (∀ i, -fderiv ℝ (fun v ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q P v p) q (Pi.single i 1) = (Q-q i)/(k : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Hamiltonian全部偏导、正质量、k>0和U沿Q可微；全部四组等式，不只定义方程。

### 6. 审计结论（含网站结论）

网站原返回：PASS。在k>0、μ\_i>0及U在Q可微下，实际Hamiltonian对P,Q以及各p\_i,q\_i的方向导数完整给出四个Hamilton向量场分量。Pi.single i 1为第i坐标方向，负号分配正确。此为全部动力场分量的求导核验，不额外宣称轨道存在性。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathHamiltonEquations` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1305`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathFrequency

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述

> where $`\Omega_i=k^{-1/2}\mu_i^{-1/2}`$ is the frequency of the $`i`$th oscillator.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathFrequency {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (i : Fin k) : ℝ := (Real.sqrt ((k : ℝ)*μ i))⁻¹
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]k>0和全部μi>0已编码为真实参数资格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。k>0和正μ\_i确保sqrt(kμ\_i)>0，其倒数与k^(−1/2)μ\_i^(−1/2)等价。i:Fin k，未出现频率零或总化负质量问题。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathFrequency` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1316`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathOscillatorSolution

印刷p.236–237 / PDFp.257–258；§6.3.3。

### 1. 原文陈述

> Because the system (6.24)–(6.25) is linear, we may solve it analytically for $`\{q_i,p_i\}`$; this yields:

$$
q_i(t)=\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i+k^{-1}\mu_i^{-1}\int_0^t\Omega_i^{-1}\sin(\Omega_i(t-s))Q(s)ds.\tag{6.26}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathOscillatorSolution : ∀ (Q q : ℝ → ℝ) (k : ℕ) (μ p0 t : ℝ),
  0 < k → 0 < μ → ContDiff ℝ 2 q → Continuous Q → 0 ≤ t →
  (deriv q 0=p0/μ) →
  (∀ s ∈ Icc 0 t, deriv (deriv q) s=(Q s-q s)/((k : ℝ)*μ)) →
  let Ω : ℝ := (Real.sqrt ((k : ℝ)*μ))⁻¹
  q t=Real.cos (Ω*t)*q 0+Ω⁻¹*Real.sin (Ω*t)*p0/μ+
    (k : ℝ)⁻¹*μ⁻¹*(∫ s in 0..t, Ω⁻¹*Real.sin (Ω*(t-s))*Q s) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际二阶受迫振子ODE、C²q、连续Q及t≥0；显式全部k>0、正μ、原初始动量p0与真实初始化q′0=p0/μ，Ω实际计算为(kμ)⁻¹/²；保留原k⁻¹μ⁻¹卷积系数，不以解公式作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。把任意一坐标写成实μ、k>0、p0，设q C²、Q连续、q′(0)=p0/μ及[0,t]上q″=(Q−q)/(kμ)。结论含q0、初始动量和完整受迫卷积；Ω=(√(kμ))⁻¹，k⁻¹μ⁻¹=Ω²，正确。仅证明q的表达式，原页展示也只给q；p可由μq′恢复。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathOscillatorSolution` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1320`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathConvolutionIBP

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述

> Integrating by parts, we have

$$
\int_0^t\Omega_i\sin(\Omega_i(t-s))Q(s)ds=[\cos(\Omega_i(t-s))Q(s)]_0^t-\int_0^t\cos(\Omega_i(t-s))P(s)ds =Q(t)-\cos(\Omega_i t)Q(0)-\int_0^t\cos(\Omega_i(t-s))P(s)ds.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathConvolutionIBP :
  ∀ (Q P : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 1 Q → (∀ s, deriv Q s=P s) → 0 ≤ t →
  (∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s) = Q t-Real.cos (Ω*t)*Q 0 -
    ∫ s in 0..t, Real.cos (Ω*(t-s))*P s := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C¹ Q和Q′=P；完整实际卷积IBP，不以通量结论作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Q C¹、处处Q′=P、t≥0，Ω任意实数。对s求导cos(Ω(t−s))为+Ω sin(Ω(t−s))，故端点Q t−cos(Ωt)Q0及−∫cos P符号正确。Ω=0仍成立，不需额外非零资格。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathConvolutionIBP` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1331`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathForce

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述

> where we define

$$
f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathForce {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)

/-- 修正版，对应原文 MD-6.3.3-BathForcePrinted；改动：选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。 -/
def bathForcePrinted_corrected {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]按(6.23)推导得到正k⁻¹实际合力；原页负号与+f项冲突，字面版本另列；不宣称更正已由网站裁定。
- [EXTRA]k>0和全部μi>0已编码，排除非物理逆质量/频率总化值。

### 6. 审计结论（含网站结论）

网站原返回：PASS。两份所示定义bathForce和bathForcePrinted\_corrected都是正k⁻¹的同一表达式。按[EXTRA]作为明示修正版审校合理：从(6.23)−k⁻¹Σ(Q−q)=+k⁻¹Σ(q−Q)得到正初值力，再减记忆卷积。k>0、正μ齐全；不是原书负号的字面版。原书符号冲突保留待人工裁定。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathForce` | 定义 | — | PASS |
| `MD.Ch06.bathForcePrinted_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1341`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathForcePrinted

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述

> where we define

$$
f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathForcePrinted {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ := -MolecularDynamics.Chapter06Review.bathForce μ q0 p0 Q0 t
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]保持原物理k>0与全部μi>0资格；字面符号仍待裁定。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Chapter06Review.bathForce为正k⁻¹和，外取负号得到原页字面f，括号内cos*(q0−Q0)及sin*p0/μ完全对应。k>0及μ>0齐全。作为Printed定义PASS，不能把它与保留+f的修正动力式同时当正确推导。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathForcePrinted` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1353`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-MemoryKernel

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述


$$
\psi(t)=k^{-1}\sum_{i=1}^k\cos(\Omega_i(t)).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def memoryKernel {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际k>0与全部μi>0参数资格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。正k、正μ，实际有限Fin k求和，系数1/k及cos频率乘时间正确。没有宣称有限核为Dirac δ，也未把它当已证明的随机极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.memoryKernel` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1357`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathReduction

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述

> Introducing this formula in (6.23), we obtain a reduced system

$$
\dot Q=P;\quad\text{(6.27)}\quad\dot P=-U'(Q)-k^{-1}\sum_{i=1}^k(Q-q_i);\quad\text{(6.28)}
$$



$$
=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathReduction :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry

/-- 修正版，对应原文 MD-6.3.3-BathReductionPrinted；改动：使用从原Hamilton方程实际代入所得的正合力卷积方程。 -/
theorem bathReductionPrinted_corrected :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]保留全部原Hamilton ODE与初值、正质量、真实卷积，按导出正k⁻¹合力；不将约化等式作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：量化k、正质量μ、U/Q/P、浴坐标q/p及t≥0；Q与q为C²，四组ODE/导数条件均保留，初值由q 0、p 0、Q 0取出。D1正合力、D2频率和D3记忆核代入，结论为正确的正合力减实际卷积。Qdot=P和原动量ODE在前提中，不是用所求约化式作前提。[EXTRA]范围基本准确；这是对原书f符号的修正版本，应明确勘误，不能称原f的字面版。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathReduction` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.bathReductionPrinted_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1362`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathReductionPrinted

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述


$$
\dot P=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}
$$



$$
f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathReductionPrinted :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForcePrinted μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem bathReductionPrinted_corrected :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter06Review.V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+MolecularDynamics.Chapter06Review.bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, MolecularDynamics.Chapter06Review.memoryKernel μ (t-s)*P s := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。bathReductionPrinted：k>0、μ\_i>0、t≥0、Q,q为C²，dot Q=P、重粒子与热浴坐标的完整动力学均已列出。bathFrequency=1/sqrt(kμ\_i)、memoryKernel=(1/k)Σcos、bathForcePrinted=-bathForce均核对。Printed的力与由dot P=-U′+(1/k)Σ(q\_i-Q)导出的力差一个负号，原版忠实但需NEEDS\_HUMAN。bathReductionPrinted\_corrected保持相同域量词前提，用正bathForce替换，记忆项仍为负卷积，数学上正确；p0/μ\_i与Ω\_i^(-1)因子吻合。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathReductionPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:1388`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-MemoryKernelDeltaMeaning

印刷p.238 / PDFp.259；§6.3.3。

### 1. 原文陈述

> If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $`\psi`$ by a Dirac delta function scaled by a positive coefficient $`\gamma`$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs

$$
dQ=Pdt;\quad\text{(6.30)}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\quad\text{(6.31)}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def memoryKernelDeltaMeaning (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))

/-- 修正版，对应原文 MD-6.3.3-MemoryKernelDeltaMeaning；改动：仅给分布收敛的精确定义，并明确正质量资格；不声称任意热浴满足该极限。 -/
def memoryKernelDeltaMeaning_corrected (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  (∀ k, ∀ i, 0 < masses k i) ∧ 0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将\_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确ηk→γδ0的实际分布意义，仅定义该近似资格；不计极限或Langevin推导已证。
- [EXTRA] 旧\_corrected只加正质量并非有效修复：固定1/k平均使|ψk|≤1，不可能收敛到正质量Dirac。此谓词在当前归一化下不可实现；原启发式与两版资格定义均留存，待确认时间/振幅重标度及单边边界因子；不把资格定义计成极限定理。
- [EXTRA] 复审范围：两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将\_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。
- 覆盖缺口：两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将\_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。memoryKernelDeltaMeaning定义对全部C∞紧支测试f的全实轴分布收敛到γf(0)，γ>0；_corrected再要求所有质量正。两者作为收敛资格的形式表达准确，均非存在或Langevin推导定理。但memoryKernel的1/k归一使所有k,t的绝对值≤1，因此两谓词在γ>0时都不可实现；正质量未修复。[EXTRA]已披露这一点，故保留NEEDS\_HUMAN，不把不可实现资格当有效修正版。全线γδ0与0到t卷积的边界因子尚需约定，(6.30)–(6.31)本身未被定义覆盖。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将\_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.memoryKernelDeltaMeaning` | 定义 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.memoryKernelDeltaMeaning_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1403`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-ScalarLangevin

印刷p.238 / PDFp.259；§6.3.3。

### 1. 原文陈述


$$
dQ=Pdt;\quad\text{(6.30)}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\quad\text{(6.31)}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def scalarLangevin {Ω : Type*} [MeasurableSpace Ω] (law : Measure Ω)
    (W Q momentum : ℝ → Ω → ℝ) (U : ℝ → ℝ) (γ σ q0 p0 : ℝ) : Prop :=
  0 < γ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample (_i : Fin 1) ↦ W t sample) law ∧
  (∀ᵐ sample ∂law, ContinuousOn (fun t ↦ Q t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ momentum t sample) (Ici 0) ∧ momentum 0 sample=p0 ∧ ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ momentum s sample) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -deriv U (Q s sample)-γ*momentum s sample) volume 0 T ∧
    Q T sample=q0+∫ s in 0..T, momentum s sample) ∧
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral law W (fun _ _ ↦ σ) T
    (fun sample ↦ momentum T sample-p0-∫ s in 0..T, -deriv U (Q s sample)-γ*momentum s sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实耦合随机Q(t,sample)及动量漂移、实际可积性、初值与严格Ito积分；无任意样本代替随机状态。
- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：对任意样本空间和law定义随机Q/动量模型；γ>0、U光滑、真正一维Wiener driver均明示。几乎处处连续、p(0)=p0、Q的积分方程及两项漂移可积性齐全；T=0给Q(0)=q0。每个T≥0以D10的L²左端和极限表达常σ积分，动量残差正确。σ任意实数与原式一致；固定初值及光滑范围作为[EXTRA]已披露。此为模型定义，无存在性/极限结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarLangevin` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1417`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-MassLangevin

印刷p.239 / PDFp.260；§6.3.3。

### 1. 原文陈述

> The equations of motion are, in vectorial form:

$$
dq=M^{-1}pdt;\quad\text{(6.32)}\quad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\quad\text{(6.33)}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def langevinMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (X : ℝ → Ω → MolecularDynamics.Chapter06Review.Phase n) (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ θ : ℝ) (x0 : MolecularDynamics.Chapter06Review.Phase n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ fun i ↦ -textbookConfigurationPartial U i (X s sample).1-
      γ*(X s sample).2 i) volume 0 T) ∧
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹ * (X s sample).2 i) ∧
    (X t sample).2 = x0.2 + (∫ s in 0..t, fun i ↦
      -textbookConfigurationPartial U i (X s sample).1 - γ*(X s sample).2 i) +
      fun i ↦ Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：n维状态为V n×V n，m每个分量正，γ、θ=kBT正，U为C∞；n维Wiener、确定初值x0、非负时间连续路径与两漂移可积性均显式保留。坐标噪声√(2γθ m\_i)(W\_i(t)−W\_i(0))与质量矩阵噪声相符；位置积分m\_i⁻¹p\_i和势偏导D13正确。[EXTRA]准确描述技术限制；不证明解存在或不变分布。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinMassSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1431`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-VariableFriction

印刷p.239 / PDFp.260；§6.3.3。

### 1. 原文陈述

> In particular, a different friction coefficient can be used for each particle and these coefficients can even depend on spatial location, thus we might work with the following system:

$$
dq=M^{-1}pdt;\quad\text{(6.34)}\quad dp=-\nabla U(q)dt-\Gamma(q)\Gamma(q)^T pdt+\sqrt{2k_BT}M^{1/2}\Gamma(q)d\widehat W;\quad\text{(6.35)}
$$


> where we use the matrix $`\Gamma(q)\in\mathbb R^{N_c\times S}`$ and a vector of $`S`$ independent Wiener processes $`\widehat W`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def variableFriction {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧ ContDiff ℝ ∞ Γ ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0 ∧
    ∀ T : ℝ, 0 ≤ T → IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
      (X T sample).1=x0.1+∫ s in 0..T, fun i ↦ (m i)⁻¹*(X s sample).2 i) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ Real.sqrt (2*θ*m i)*Γ (X s sample).1 i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i) volume 0 T ∧
        (X T sample).2 i-x0.2 i-(∫ s in 0..T, -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i)=∑ j, integrals j sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整任意矩形Γ(q)、任意质量和真实全部噪声坐标严格Ito积分；未缩成对角或单位质量，不宣称自动Gibbs不变。
- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：n/r独立量化，Γ为n×r的空间依赖矩阵；m\_i>0、θ>0、U/Γ光滑，r维联合Wiener，连续初值路径与位置方程齐全。每个动量坐标i、每个T≥0存在全部r个严格积分，系数√(2θm\_i)Γ\_ij，漂移−∂iU−(ΓΓᵀp)_i，均正确，全部漂移可积性明示。没有单位质量或对角化偷换；严格L²积分模型比一般局部Itô解范围窄，[EXTRA]已说明严格积分范围。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.variableFriction` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1448`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-ParticleDiagonalFriction

印刷p.239 / PDFp.260；§6.3.3。

### 1. 原文陈述

> In the case of Langevin dynamics with different, variable friction coefficients for each particle, we have $`S=N_c`$ and

$$
\Gamma=\operatorname{diag}(\gamma_1(q),\gamma_1(q),\gamma_1(q),\gamma_2(q),\gamma_2(q),\gamma_2(q),\ldots,\gamma_N(q),\gamma_N(q),\gamma_N(q)).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def particleDiagonalFriction {N : ℕ} (γ : Fin N → (Fin (N*3) → ℝ) → ℝ)
    (q : Fin (N*3) → ℝ) : Matrix (Fin (N*3)) (Fin (N*3)) ℝ :=
  Matrix.diagonal (fun i ↦ γ ⟨i.val/3, by omega⟩ q)
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

网站原返回：PASS。C：输出为(N*3)×(N*3)实矩阵，i.val/3从0起每组三坐标取同一粒子γ；输入γ允许依赖全部构型，Matrix.diagonal确保非对角项为0。未把γ静默替换为√γ；有限类型N=0为空矩阵，无越界对象。忠实于给出的Γ定义，而非把γ宣称为ΓΓᵀ中的系数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.particleDiagonalFriction` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1468`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.4-BrownianMassModel

印刷p.240 / PDFp.261；§6.3.4。

### 1. 原文陈述

> Let $`v=M^{-1}p`$ and assume that the acceleration is negligible, so that Langevin dynamics reduces to

$$
dq=vdt;\quad0=-\nabla U(q)dt-\gamma Mvdt+\sqrt{2\gamma k_BT}M^{1/2}dW.
$$


> The second equation can be solved for $`v`$ and we obtain the following SDE for $`q`$:

$$
dq=-\gamma^{-1}M^{-1}\nabla U(q)dt+\sqrt{2k_B\gamma^{-1}T}M^{-1/2}dW.\tag{6.36}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def brownianMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W q : ℝ → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ θ : ℝ) (q0 : MolecularDynamics.Chapter06Review.V n) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ (∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample))
      volume 0 T) ∧
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ q t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    q t sample = q0 + (∫ s in 0..t, fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample)) +
      fun i ↦ Real.sqrt (2*θ/(γ*m i))*(W t sample i-W 0 sample i)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意维正m、γ>0、θ>0、光滑U、n维Wiener以及q0；真实连续路径积分方程的漂移−(γm\_i)⁻¹∂iU、噪声√(2θ/(γm\_i))均正确，全部漂移区间可积性已明示。此定义编码形式Brownian模型；不将令加速度为0当作已经证明小质量/大摩擦收敛，实际极限另见条目16。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianMassSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1474`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-FrequencyMemoryKernel

印刷p.237 / PDFp.258；§6.3.3。

### 1. 原文陈述


$$
\psi(t)=k^{-1}\sum_{i=1}^k\cos(\Omega_i(t)).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def frequencyMemoryKernel {k : ℕ} (Ω : Fin k → ℝ) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹*∑ i, Real.cos (Ω i*t)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]以实际给定频率直接表达原核，方便记录图6.4/6.5全部数值族；k>0用于物理解释，有限函数定义不计δ极限已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意有限频率族Ω和实t，函数为k⁻¹∑cos(Ω\_i*t)，与D3相同的频率解释。k=0在Lean中定义为0；[EXTRA]所说k>0仅为物理解释，实际签名没有该前提，不应当作已验证的正k模型定理。此为核定义，无δ极限结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.frequencyMemoryKernel` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1486`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-Figure64Frequencies

印刷p.238 / PDFp.259；§6.3.3。

### 1. 原文陈述

> Fig. 6.4 The memory kernel $`\psi`$ is shown for three different sets of frequencies $`\Omega_i`$. Blue: $`k=400`$, $`\Omega_i=0.01i`$; red: $`k=1,000`$, $`\Omega_i\sim U[0,1]`$; green: $`k=1,000`$, $`\Omega_i=10\widehat\Omega_i`$, where $`\widehat\Omega_i\sim U[0,1]`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def figure64Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (blue : Fin 400 → ℝ) (red green : Fin 1000 → A → ℝ) : Prop :=
  (∀ i, blue i=(1/100 : ℝ)*(i.val+1)) ∧
  (∀ i, HasLaw (red i) (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ i, HasLaw (fun sample ↦ green i sample/10) (volume.restrict (Icc (0 : ℝ) 1)) P
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]Fin下标val+1恢复原i=1,…,k；长度1区间限制Lebesgue测度是U[0,1]，记录原边际law，未擅加原未明说的独立性。green/10完整表示10×Uniform频率。图中核使用前条实际频率求和定义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：blue长度400且val+1恢复i=1,…,400；red/green各1000个随机频率，每个red服从区间限制Lebesgue测度，每个green/10同分布。区间长度1，故无需额外归一化；没有把边际law冒充联合独立law，图注也未明确独立性。此声明仅编码频率，不证明图形或随机核收敛；[EXTRA]范围准确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.figure64Frequencies` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1491`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-Figure65Frequencies

印刷p.238 / PDFp.259；§6.3.3。

### 1. 原文陈述

> Fig. 6.5 The memory kernels are shown for various choices of $`\Omega_i^{(k)}`$. Left: $`\Omega_i^{(k)}=i/\sqrt k`$, $`k=5^2,10^2,\ldots,35^2`$; center: $`\Omega_i=\sqrt k\widehat\Omega_i`$, $`\widehat\Omega_i\sim U[0,1]`$, $`k=10,20,\ldots,100`$; right: $`\Omega_i=k\widehat\Omega_i`$, $`\widehat\Omega_i\sim U[0,1]`$, $`k=10,20,\ldots,100`$. In each case the red curve indicates the largest value of $`k`$ considered, whereas green indicates the smallest value.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def figure65Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (left : (k : ℕ) → Fin k → ℝ) (center right : (k : ℕ) → Fin k → A → ℝ) : Prop :=
  (∀ j ∈ Finset.range 7, ∀ i : Fin ((5*(j+1))^2),
    left ((5*(j+1))^2) i=(i.val+1 : ℝ)/Real.sqrt ((5*(j+1))^2 : ℕ)) ∧
  (∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ center (10*(j+1)) i sample/Real.sqrt (10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ right (10*(j+1)) i sample/(10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]两个原数列分别7/10项、完整全部频率及随机边际；Fin下标+1；不把绘图外观当严格极限定理。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：左列j∈range 7给k=25,100,…,1225和(i+1)/√k；中/右j∈range 10给k=10,20,…,100，并分别对center/√k和right/k断言U[0,1]边际，全部索引与量词正确。颜色对应与实际绘图不在本频率谓词内，不应计作图形验证；[EXTRA]未宣称极限成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.figure65Frequencies` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1499`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-BathForceWeakLimitMeaning

印刷p.237–238 / PDFp.258–259；§6.3.3。

### 1. 原文陈述

> For large $`k`$ and for many choices of the frequencies $`\Omega_i`$ and the initial conditions $`\{q_i(0);p_i(0)\}`$, function $`f(t)`$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathForceWeakLimitMeaning {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsProbabilityMeasure P ∧
  (∀ k T, Measurable (forcePaths k T)) ∧ (∀ T, Measurable (wienerPaths T)) ∧
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    MolecularDynamics.Chapter06Review.bathForcePrinted (masses k) (q0 k sample) (p0 k sample) Q0 s) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))

/-- 修正版，对应原文 MD-6.3.3-BathForceWeakLimitMeaning；改动：将与Wiener过程比较的对象改为时间积分后的热浴力；仍只定义极限意义。 -/
def bathForceWeakLimitMeaning_corrected {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsProbabilityMeasure P ∧
  (∀ k T, Measurable (forcePaths k T)) ∧ (∀ T, Measurable (wienerPaths T)) ∧
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    ∫ u in (0 : ℝ)..(s : ℝ), MolecularDynamics.Chapter06Review.bathForce (masses k) (q0 k sample) (p0 k sample) Q0 u) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整连续路径空间的弱法则，而非只收敛均值/某单时边际；实际有限热浴力路径与Wiener路径逐点关联，只定义原希望的资格，不宣称任意族满足。
- [EXTRA] 两版补概率空间与连续路径随机变量可测性；Printed是力路径、corrected是正力时间积分；物理标度和极限是否可实现仍待导师，不把弱收敛资格谓词当存在定理。
- [EXTRA] 复审范围：两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。
- 覆盖缺口：两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。bathForceWeakLimitMeaning：在概率空间、正质量下，将实际Printed力逐点嵌入C([0,T])，要求路径随机变量可测，W为preBrownian并有连续路径代表；对每T>0全部有界连续泛函的期望收敛，确为路径法则弱收敛而非仅边际。_corrected改成正bathForce的0至s时间积分，其余量词不变；这是与dP中的白噪声驱动更相符的候选。没有任何版本断言存在初态/质量族满足；也没有σ幅度或物理标度条件，所以不能认证实际热浴收敛或称“修复完成”。两版定义签名各自表达所说资格，但数学解释保留NEEDS\_HUMAN。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathForceWeakLimitMeaning` | 定义 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.bathForceWeakLimitMeaning_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1514`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.4-OverdampedLimit

印刷p.240 / PDFp.261；§6.3.4。

### 1. 原文陈述

> This is also sometimes referred to as Brownian dynamics or Smoluchowski dynamics. The transition from Langevin to Brownian dynamics is typically referred to as the “Kramers to Smoluchowski limit.”

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem overdampedLimit : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → (Fin n → ℝ)) (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ))
    (X : ℝ → ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ))) (q : ℝ → Ω → (Fin n → ℝ)),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  textbookUnitPeriodicPotential U → 0 < β →
  (∀ γ : ℝ, 0 < γ → MolecularDynamics.Chapter06Review.langevinMassSDE P
    (fun t sample ↦ B t.toNNReal sample) (X γ) m U γ β⁻¹ x0) →
  MolecularDynamics.Chapter06Review.brownianMassSDE P (fun t sample ↦ B t.toNNReal sample) q m U 1 β⁻¹ x0.1 →
  ∀ T : ℝ, 0 < T → ∀ f : (Fin n → ℝ) → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun γ : ℝ ↦ ∫ sample, f (X γ (γ*T) sample).1 ∂P) atTop
      (𝓝 (∫ sample, f (q T sample) ∂P)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部正对角质量、正β、光滑周期U，原热浴路径模型；高γ需按γT观察，完整任意有界连续检验弱极限，没有把极限本身作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意维正m、β>0、光滑单位周期势U，固定确定初始相点；B为共同n维Wiener。前提对所有γ>0给Chapter06Review.langevinMassSDE解族，q满足该命名空间brownianMassSDE且摩擦参数1、温度β⁻¹。结论仅在每个T>0对所有有界连续位置检验f有期望弱收敛，观察时间γT正确，未主张路径强收敛。核对了所引用的是项目Review模型，而非同名MD加强定义；在光滑周期势下梯度有界且Lipschitz，路径连续性使实际漂移积分有意义。周期、光滑、时间重标度和弱拓扑限制均已由[EXTRA]披露。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.overdampedLimit` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1551`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.5-ScalarGenerator

印刷p.240 / PDFp.261；§6.3.5。

### 1. 原文陈述

> where $`\mathcal L`$ is a linear operator, called the generator of the stochastic process, defined by

$$
\mathcal L\phi(x)=\left(a(x)\frac d{dx}+\tfrac12 b^2(x)\frac{d^2}{dx^2}\right)\phi(x).\tag{6.38}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x
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

网站原返回：PASS。C：任意实函数a/b/f及实x，a(x)f′(x)+b(x)²f″(x)/2与原生成元动作完全对应，括号和平方位置正确。对非光滑函数deriv有总定义，但这里是形式算子定义，不含错误的对任意函数经典可微性断言；经典解释取C²测试函数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1566`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.5-GeneratorExpectation

印刷p.240 / PDFp.261；§6.3.5。

### 1. 原文陈述

> Then, taking the expectation of the Itô-Doeblin formula (6.17) we find

$$
\mathbb E\{d\phi(X)\}=\mathbb E\{\phi'(X)a(X)\}dt+\tfrac12\mathbb E\{\phi''(X)b(X)^2\}dt =\mathbb E\{(\mathcal L\phi)(X)\}dt.\tag{6.37}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem generatorExpectation :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b φ : ℝ → ℝ) (x0 : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 1 a → ContDiff ℝ 1 b → ContDiff ℝ 2 φ → MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample)) →
  (∀ t : ℝ, 0 ≤ t → Integrable (fun sample ↦ MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample)) P) →
  ContinuousOn (fun t ↦ ∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) (Ici 0) →
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) →
  Measurable (Function.uncurry X) →
  (∀ T : ℝ, 0 ≤ T → Integrable
    (fun w : ℝ × Ω ↦ |MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X w.1 w.2)|)
    ((volume.restrict (Icc 0 T)).prod P)) →
  ∀ t : ℝ, 0 < t → HasDerivAt (fun s ↦ ∫ sample, φ (X s sample) ∂P)
    (∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实严格SDE、C²φ、适应平方可积资格、Lφ实际可积且时间期望连续；完整期望时间导数，不只定义L。
- [EXTRA]自然Wiener历史适应、联合可测X、C¹a/b及Lφ在每个有限时间×样本上的绝对可积资格，保证实际Fubini；有符号期望连续不自动蕴含此资格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：完整量化样本测度、W/X、a/b/φ、确定x0；前提为PreBrownian、实际strictScalarSDE、C¹a/b、C²φ、φ′(X)b(X)自然历史适应且平方时间可积、每时刻Lφ可积、期望连续、X自然历史适应/联合可测，以及每个有限时间×样本上|Lφ|可积。结论为每个t>0期望函数的HasDerivAt，导数等于E[Lφ(Xt)]。Fubini和去随机积分期望所需范围已作为[EXTRA]披露，没有把所求导数或弱PDE当作前提。严格SDE给实际积分残差，结论强于只定义L而未偷换对象。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.generatorExpectation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1571`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-PolynomialSmooth

印刷p.241 / PDFp.262；§6.3.6。

### 1. 原文陈述

> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $`C^\infty`$ smooth and satisfy the polynomial growth restriction by $`C_P^\infty`$:

$$
C_P^\infty\stackrel{\mathrm{def}}=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r
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

网站原返回：PASS。C：ContDiff ℝ ∞ f且存在统一C≥0、自然r、∀x的|f(x)|≤C(1+|x|)^r。光滑函数在紧区间有界，因此该全局界与原双侧无穷处Big-O等价。没有擅自把C\_P∞强化为所有阶导数都多项式增长。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.polynomialSmooth` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1589`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-DensityExpectation

印刷p.241 / PDFp.262；§6.3.6。

### 1. 原文陈述

> For any $`\phi\in C_P^\infty`$, the expectation with respect to $`\rho(x,t)`$ is well defined and we have

$$
\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem densityExpectation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (X : Ω → ℝ) (ρ φ : ℝ → ℝ),
  HasLaw X (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) P →
  (∀ x, 0 ≤ ρ x) → Measurable ρ → MolecularDynamics.Chapter06Review.polynomialSmooth φ →
  (∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x, ρ x ≤ C*Real.exp (-c*|x|)) →
  Integrable (fun sample ↦ φ (X sample)) P ∧
    (∫ sample, φ (X sample) ∂P)=(∫ x, φ x*ρ x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实非负可测density与全局指数尾界；完整可积与积分law等式，不预置这些结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：HasLaw把真实X分布与volume.withDensity(ofRealρ)关联，额外ρ非负且可测，φ取D49（函数值多项式增长），ρ有全局正指数尾上界。无需假设导数增长即可得|φ|ρ可积；结论同时给样本上的Integrable和与∫φρ相等，乘积顺序无影响。指数尾和多项式界控制实轴尾部，law桥接真实随机变量，不把积分恒等作前提。[EXTRA]准确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.densityExpectation` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1594`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-ScalarForward

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> In the case at hand the adjoint is

$$
\mathcal L^\dagger\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx},
$$


> which we shall refer to as the Kolmogorov operator.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2
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

网站原返回：PASS。C：任意实函数a/b/ρ及实x，−(aρ)′+(b²ρ)″/2完整正确。形式定义没有把ρ′′误写为φ′′，也没有带入条目23虚构的负扩散号。经典含义需相应可微性，此定义没有宣称PDE已从law推出。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarForward` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1604`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPDriftAdjoint

印刷p.241–242 / PDFp.262–263；§6.3.6。

### 1. 原文陈述

> First, we find

$$
\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{+\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx =-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpDriftAdjoint :
  ∀ (a ρ φ : ℝ → ℝ),
  ContDiff ℝ 1 a → ContDiff ℝ 1 ρ → ContDiff ℝ 1 φ →
  HasCompactSupport φ → (∫ x, a x*deriv φ x*ρ x) = ∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x) := by
  intro a ρ φ ha hρ hφ hc
  have hg : ContDiff ℝ 1 (fun x ↦ a x*ρ x) := ha.mul hρ
  have hi1 : Integrable (fun x ↦ (a x*ρ x)*deriv φ x) :=
    (hg.continuous.mul hφ.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.mul_left
  have hi2 : Integrable (fun x ↦ deriv (fun z ↦ a z*ρ z) x*φ x) :=
    (hg.continuous_deriv_one.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have hi3 : Integrable (fun x ↦ (a x*ρ x)*φ x) :=
    (hg.continuous.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have he := MeasureTheory.integral_mul_deriv_eq_deriv_mul_of_integrable
    (u := fun x ↦ a x*ρ x) (v := φ)
    (fun x _ ↦ (hg.differentiable_one x).hasDerivAt)
    (fun x _ ↦ (hφ.differentiable_one x).hasDerivAt) hi1 hi2 hi3
  simpa only [Pi.mul_apply, mul_comm, mul_left_comm, mul_assoc, mul_neg, integral_neg] using he
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]当前完整紧支撑C¹检验桥接；原指数尾和多项式检验的全域版本在FPPolynomialAdjoint保留，不将紧支撑特例计为原全部检验已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：∀a/ρ/φ为C¹，且φ紧支；左积分aφ′ρ，右积分φ[−(aρ)′]，全实轴真实积分相等。紧支和C¹使两边连续紧支、可积，边界自动消失；未要求a或ρ紧支。仅证明[EXTRA]明示的紧支桥接，不能计为原所有多项式测试函数的全域版本。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpDriftAdjoint` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1609`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPDiffusionPrinted

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> With two rounds of integration by parts on the term involving $`b(x)`$, we find, using the fact that the boundary terms vanish,

$$
\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpDiffusionPrinted : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  intro b ρ φ hb hρ hφ hc
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have h1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have h2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  calc
    _ = (∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
      apply integral_congr_ae
      filter_upwards [] with x
      ring
    _ = _ := by
      rw [h1,h2,neg_neg]
      apply integral_congr_ae
      filter_upwards [] with x
      ring



/-- 原页本为正号；此同义_corrected名称为兼容保留，不是原书勘误。 -/
theorem fpDiffusionPrinted_corrected : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  intro b ρ φ hb hρ hφ hc
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have h1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have h2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  calc
    _ = (∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
      apply integral_congr_ae
      filter_upwards [] with x
      ring
    _ = _ := by
      rw [h1,h2,neg_neg]
      apply integral_congr_ae
      filter_upwards [] with x
      ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧\_corrected名字仅兼容保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧\_corrected名字仅兼容保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。fpDiffusionPrinted与\_corrected同签名：b,ρ,φ为C²，φ紧支撑，则∫b²φ″ρ=∫φ(b²ρ)″。将时间固定后ρ为实函数符合原式；紧支撑φ及其导数消除边界项，C²使各紧支 integrand可积。没有外负号，亦没有在该纯扩散分部积分恒等式中额外放1/2。两版PASS；_corrected只是兼容同义名，不是原书勘误。fpDriftAdjoint的C¹紧支辅助式负号也正确。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpDiffusionPrinted` | 已证 | — | PASS |
| `MD.Ch06.fpDiffusionPrinted_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1629`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPAdjointCompact

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> where the operator appearing on the right hand side is the adjoint $`\mathcal L^\dagger`$ of the generator of the stochastic process, satisfying the relation

$$
\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.
$$


> In the case at hand the adjoint is

$$
\mathcal L^\dagger\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx},
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpAdjointCompact :
  ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ →
  HasCompactSupport φ → (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x) = ∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x := by
  intro a b ρ φ ha hb hρ hφ hc
  have ha1 : ContDiff ℝ 1 a := ha.of_le (by norm_num)
  have hρ1 : ContDiff ℝ 1 ρ := hρ.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hh1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have hh2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  have hdiff : (∫ x, (b x^2*ρ x)*deriv (deriv φ) x)=
      (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [hh1, hh2, neg_neg]
    congr 1
    funext x
    ring
  have hD := fpDriftAdjoint a ρ φ ha1 hρ1 hφ1 hc
  have hiA : Integrable (fun x ↦ a x*deriv φ x*ρ x) :=
    ((ha.continuous.mul hφ1.continuous_deriv_one).mul hρ.continuous).integrable_of_hasCompactSupport hc.deriv.mul_left.mul_right
  have hiB : Integrable (fun x ↦ (b x^2*ρ x)*deriv (deriv φ) x) :=
    (hG.continuous.mul hφ.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.deriv.mul_left
  have hiC : Integrable (fun x ↦ φ x*(-deriv (fun z ↦ a z*ρ z) x)) :=
    (hφ.continuous.mul (ha1.mul hρ1).continuous_deriv_one.neg).integrable_of_hasCompactSupport hc.mul_right
  have hiE : Integrable (fun x ↦ φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) :=
    (hφ.continuous.mul hG.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.mul_right
  have hleft : (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
      (∫ x, a x*deriv φ x*ρ x)+(1/2 : ℝ)*(∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
    rw [← integral_const_mul, ← integral_add hiA (hiB.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarGenerator]
    ring
  have hright : (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x)=
      (∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x))+
        (1/2 : ℝ)*(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [← integral_const_mul, ← integral_add hiC (hiE.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarForward]
    ring
  rw [hleft, hright, hD, hdiff]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]紧支撑C²检验的完整正号伴随恒等；多项式检验及指数尾版本另条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：对任意C² a/b/ρ/φ和紧支φ，真实全实轴∫(Lφ)ρ=∫φ(L†ρ)。D47/D50展开后正确，紧支使全部相关积分存在；紧支C²范围已在[EXTRA]明示，不把它计作所有C\_P∞测试的完整伴随域结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpAdjointCompact` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1686`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPPolynomialAdjoint

印刷p.241–242 / PDFp.262–263；§6.3.6。

### 1. 原文陈述

> We assume that $`\rho`$ is $`C^\infty`$ for all $`t`$ and that the density tends to zero exponentially fast as $`x\to\pm\infty`$, whereas $`a`$ and $`b`$ are $`C^\infty`$ functions which grow at most polynomially fast in these limits, that is, there are constants $`\eta_a`$, $`\eta_b`$ such that

$$
a(x)=\mathcal O(|x|^{\eta_a}),\quad b(x)=\mathcal O(|x|^{\eta_b}),\quad x\to\pm\infty.
$$


> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $`C^\infty`$ smooth and satisfy the polynomial growth restriction by $`CP^\infty`$:

$$
CP^\infty=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.
$$


> For any $`\phi\in CP^\infty`$, the expectation with respect to $`\rho(x,t)`$ is well defined and we have

$$
\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.
$$


> Taking the differential, we obtain an equation for $`\mathbb E d\phi`$ which must be equal to (6.37):

$$
\int_{-\infty}^{+\infty}\phi(x)\frac{\partial\rho}{\partial t}dx=\int_{-\infty}^{+\infty}(\mathcal L\phi)(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}(a(x)\phi'+\tfrac12 b^2(x)\phi''(x))\rho(x,t)dx.
$$


> Using the assumptions given above regarding the exponential rate of decay of the density, it is possible to recast the right hand side as an integral of a product with $`\phi`$. First, we find

$$
\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx=-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.
$$


> With two rounds of integration by parts on the term involving $`b(x)`$, we find, using the fact that the boundary terms vanish,

$$
\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.
$$


> Finally, putting these results together, we have

$$
\int_{-\infty}^{+\infty}\phi(x)\left[\frac{\partial\rho}{\partial t}+\frac{\partial}{\partial x}(a(x)\rho(x,t))-\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho)\right]dx=0.
$$


> If this is to hold for all test functions $`\phi`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\frac{\partial}{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).
$$


> This partial differential equation is often called the Fokker-Planck equation. The great benefit of the Fokker-Planck equation is that it enables the macroscopic perspective on the solutions of an SDE.
> The Fokker-Planck equation may be written in the compact form

$$
\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho,
$$


> where the operator appearing on the right hand side is the adjoint $`\mathcal L^\dagger`$ of the generator of the stochastic process, satisfying the relation

$$
\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpPolynomialAdjoint : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- 修正版，对应原文 MD-6.3.6-FPPolynomialAdjoint；改动：显式约束所需导数的多项式增长和密度导数的指数衰减。 -/
theorem fpPolynomialAdjoint_corrected : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- 【原书疑误】仅函数值增长条件的字面伴随断言；不证。 -/
theorem fpPolynomialAdjointPrinted : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k = 0 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k = 0 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原C∞P值增长不足以控制所有IBP边界；明确一、二阶a,b,φ多项式增长及ρ导数指数尾，保存整个非紧支撑真实积分恒等。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。fpPolynomialAdjoint及\_corrected：a,b,ρ,φ为C∞；a,b,φ的0至2阶导数逐阶有全局多项式界，ρ的0至2阶导数逐阶有正指数尾；这些明确加强条件保证真正非紧支撑积分可积与所需边界消失，scalarGenerator=aφ′+b²φ″/2、scalarForward=-(aρ)′+(b²ρ)″/2，签名正确。fpPolynomialAdjointPrinted只约束k=0的函数值，忠实于原书CP∞和密度衰减，不能据此控制导数、边界或积分；Printed保留NEEDS\_HUMAN。原文并未证明任意此类测试函数的Lφ可积，不能让Bochner总化积分掩盖问题。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpPolynomialAdjoint` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.fpPolynomialAdjoint_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.fpPolynomialAdjointPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:1739`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPEquation

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> If this is to hold for all test functions $`\phi`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\frac\partial{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).
$$


> The Fokker-Planck equation may be written in the compact form

$$
\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ b (X t sample)) →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiffOn ℝ ∞ (Function.uncurry ρ) {z : ℝ × ℝ | 0 < z.1} →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧
    HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |a x|+|b x| ≤ C*(1+|x|)^r) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*|x|)) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.scalarForward a b (ρ t) x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。
- 覆盖缺口：严格网格积分关系到通常适应Itô解、以及一般Fokker–Planck推导尚缺证明；不将单文件编译当作这些桥接已完成。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。fpEquation的P、W,X、a,b、确定初态x0及ρ(t,x)量词、自然历史适应与联合可测X、扩散平方可积、真实正密度HasLaw、多项式值界及正时间紧窗一致指数尾均已核对；结论是每t>0、每x的经典PDE，scalarForward系数正确，未把目标PDE设为前提。但ContDiff ℝ ∞ (Function.uncurry ρ)要求ρ在包括t=0的整个ℝ²光滑，同时strictScalarSDE要求X0=x0且AE路径在0连续，HasLaw对所有t>0成立。这使整组前提不可能：连续初态的边际趋δ\_x0，而跨t=0连续的Lebesgue密度在小紧矩形有一致界，不能产生该原子极限。因此该签名是空泛的加强，并非原书“给定初始密度”的FP陈述，判FAIL；与sorry无关。仅补适应性不能修复时间域和初始法则。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpEquation` | 未证 | 缺大型理论 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:1775`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-ZeroNoise

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> In case $`b\equiv0`$, the SDE becomes an ordinary differential equation. Then the generator $`\mathcal L`$ becomes simply the Lie derivative, and its adjoint is just the Liouvillian.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem zeroNoise :
  ∀ (a f ρ : ℝ → ℝ) (x : ℝ),
  MolecularDynamics.Chapter06Review.scalarGenerator a (fun _ ↦ 0) f x=a x*deriv f x ∧
    MolecularDynamics.Chapter06Review.scalarForward a (fun _ ↦ 0) ρ x = -deriv (fun z ↦ a z*ρ z) x := by
  intro a f ρ x
  constructor
  · simp [MolecularDynamics.Chapter06Review.scalarGenerator]
  · simp [MolecularDynamics.Chapter06Review.scalarForward]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。
- 覆盖缺口：仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。

### 6. 审计结论（含网站结论）

网站原返回：PASS。zeroNoise对任意实函数a,f,ρ和任意x给两合取：scalarGenerator(a,0)f=a f′及scalarForward(a,0)ρ=-(aρ)′。展开D25、D26即得，扩散项为恒零故不需可微性前提。覆盖范围已注明只是算子代数化简，未声称SDE解成为经典ODE解，PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.zeroNoise` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1793`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-VectorIto

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> If $`\phi`$ is a scalar valued function of $`\mathbb R^m`$, and $`Z(t)`$ is the solution of the SDE system

$$
dZ=a(Z)dt+B dW;\tag{6.39}
$$


> where $`a`$ is a function in $`\mathbb R^m`$ and $`B`$ is a constant matrix, then we have

$$
d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12dW^TB^T\phi''B dW;\tag{6.40}
$$


> where $`\phi''`$ is the Hessian matrix of $`\phi`$, i.e. the matrix of second partial derivatives of $`\phi`$ with respect to pairs of the variables. In some applications $`B=B(Z)`$, in which case the SDE (6.39) is said to involve multiplicative noise (as oppose to the additive case we consider when $`B`$ is constant). For a discussion of the differences and applications of these types of noise, see [289, 324].
> All components on the right hand side of (6.40) are evaluated at $`Z(t)`$. Then using the shorthand rules $`dW_i dW_j=dt\delta_{ij}`$ (where $`\delta_{ij}`$ is one if $`i=j`$, zero otherwise), we have

$$
d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12\operatorname{Tr}(B^T\phi''B)dt.\tag{6.41}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem vectorIto : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (φ : (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 → ContDiff ℝ 2 φ →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω (Fin n → ℝ) (naturalHistory25 W t) inferInstance (X t)) →
  vectorGridItoQualification25 P W
    (fun j t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) →
  ∀ T : ℝ, 0 ≤ T → ∃ integrals : Fin r → Ω → ℝ,
    (∀ j, strictItoIntegral P (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T (integrals j)) ∧
    (∀ᵐ sample ∂P, φ (X T sample)-φ x0-
      (∫ s in 0..T, MolecularDynamics.Chapter06Review.vectorGenerator a B φ (X s sample))=∑ j, integrals j sample) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected\_json恢复连接文本。仍缺一般多维Itô理论。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected\_json恢复连接文本。仍缺一般多维Itô理论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。vectorIto：任意n,r、共同向量Wiener及strictVectorSDE、常n×r矩阵B、C² φ、联合可测且共同向量自然历史适应X；vectorGridItoQualification25对每列方向导数被积过程给共同历史适应、每时及每网格L²、局部均方Hölder资格。结论逐T≥0存在r个严格标量积分，且φ增量减∫vectorGenerator等于积分和AE。共同过滤不误限为各自单坐标过滤；vectorDiffusion=Σ\_ij(BBᵀ)_ij∂i∂jφ，等价Tr(Bᵀ Hess φ B)，漂移fderiv φ(a)与1/2正确。资格未预设结论，签名PASS；只审签名，不认证sorry证明。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.vectorIto` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1804`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-VectorForward

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> In the multivariate case, the density is a function of the vector describing a state of the system $`z`$ and $`t`$, and is governed by the partial differential equation

$$
\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def vectorForward {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x

/-- 修正版，对应原文 MD-6.4.2-CylinderForwardPrinted；改动：扩散项中的φ″改为ρ″。 -/
def cylinderForwardPrinted_corrected {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x
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

网站原返回：PASS。C：任意n/r、向量漂移a、常n×r矩阵B、标量ρ及状态x；MD包装的精确项目定义为−∑i∂i(a\_iρ)+½ vectorDiffusion B ρ，D51给BBᵀ与ρ的混合二阶导数，次序和系数正确。context\_notation已明示这里只定义前向算子，不算从law证明PDE。代码块附带的cylinderForwardPrinted\_corrected是另一source\_id的别名，目标相同且无额外数学断言，不把它混算为本条证明或独立条目。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.vectorForward` | 定义 | — | PASS |
| `MD.Ch06.cylinderForwardPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1822`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-DiffusionTrace

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> The second order “diffusion” term in this expression may be expanded as

$$
\operatorname{Tr}(B^T\rho''B)=\sum_{i=1}^m\sum_{j=1}^m(BB^T)_{ij}\frac{\partial^2\rho}{\partial z_i\partial z_j}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem diffusionTrace :
  ∀ {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ)
    (H : Matrix (Fin n) (Fin n) ℝ),
  Matrix.trace (B.transpose*H*B)=∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j*H i j := by
  intro n r B H
  rw [Matrix.trace_mul_cycle B.transpose H B, Matrix.trace_mul_cycle B B.transpose H]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Finset.mul_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro k hk
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

网站原返回：PASS。C：签名将Hessian抽象为任意n×n实矩阵H，B为n×r；没有额外正定或对称前提。trace(BᵀHB)=∑ij(BBᵀ)ij H\_ij对任意H成立：按矩阵乘法展开并用实数乘法交换律及BBᵀ对称性重排。包括n/r=0的空和情况。取H=ρ的Hessian即原式，强化为任意矩阵没有丢结论，也不需要用Hessian对称性作隐藏前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.diffusionTrace` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1832`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-VectorFPEquation

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> In the multivariate case, the density is a function of the vector describing a state of the system $`z`$ and $`t`$, and is governed by the partial differential equation

$$
\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem vectorFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (ρ : ℝ → (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ k : ℕ, ∀ x, ‖a x‖ ≤ C*(1+‖x‖)^k) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实多维Wiener、严格SDE、完整非负密度law、光滑和局部尾部求导资格；没有将弱PDE结论作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。全部n个状态、r个噪声、常矩形B、确定初值和任意正时刻/空间点均保留。D2/D7/D8给出负散度及(1/2)∑(BBᵀ)ij∂ijρ，等于原迹公式。D3/D4是实际L²左和积分及路径方程，没有把PDE作前提；光滑、多项式漂移增长、局部一致指数密度/时间导数尾界均属已标[EXTRA]的充分资格。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.vectorFPEquation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1851`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.8-LangevinMassForward

印刷p.244 / PDFp.265；§6.3.8。

### 1. 原文陈述

> In the special case of Langevin dynamics (6.32)–(6.33) for a system with $`N_c`$ configuration variables, the density is a function of the vectors of positions $`q`$, momenta $`p`$, and time, and the formula for the Kolmogorov operator becomes

$$
\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho;\tag{6.42}
$$


> where the mass-weighted Laplacian $`\Delta_M`$ is defined as

$$
\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def langevinMassForward {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ β : ℝ)
    (ρ : MolecularDynamics.Chapter06Review.Phase n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : MolecularDynamics.Chapter06Review.Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))
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

网站原返回：PASS。Phase n明确是全部位置和动量的乘积。对每个i，位置项为−mi⁻¹pi∂qiρ，动量项对(∂iU+γpi)ρ整体求导，扩散为γβ⁻¹mi∂pi²ρ；β⁻¹=kBT。系数不依赖q，所以位置散度展开正确。此为算子定义，无须把密度law或PDE证明混入定义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinMassForward` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1866`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.8-MomentumMassLaplacian

印刷p.244 / PDFp.265；§6.3.8。

### 1. 原文陈述


$$
\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def momentumMassLaplacian {n : ℕ} (m : Fin n → ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  ∑ i, m i*fderiv ℝ (fun y ↦ fderiv ℝ ρ y (0,Pi.single i 1)) x (0,Pi.single i 1)
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

网站原返回：PASS。对所有Fin n动量方向(0,ei)作两次Fréchet导数，再以mi相乘求和，恰为原正质量权重动量Laplacian；没有误用mi⁻¹或位置方向。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.momentumMassLaplacian` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1873`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

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

