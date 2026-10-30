[上一部分](part07.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part09.zh-CN.md)

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

