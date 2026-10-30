[上一部分](part05.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

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

