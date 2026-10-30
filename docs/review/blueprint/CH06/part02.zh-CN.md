[上一部分](part01.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## MD-6.1.3-PeriodicPartitionBridge

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> then the integral separates

$$
Z_{\rm can}=\int_{\mathbb R^{N_c}}e^{-\beta p^TM^{-1}p/2}d\omega_p\times\int_Q e^{-\beta U(q)}d\omega_q.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem periodicPartitionBridge {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    textbookLangevinCanonicalPartition U β =
      textbookConfigurationPartition U β * (Real.sqrt (2 * Real.pi * β⁻¹)) ^ N := by
  apply MolecularDynamics.textbookLangevinCanonicalPartition_formula <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]仅独立特例：单位质量、单位周期torus、实际Haar配置测度与光滑周期U；完整一般质量/Q的两条义务仍保留，不将特例计为完整原结论已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U在Fin N→ℝ上C∞且对任意整数向量平移周期，β>0；左边由D20在单位配置torus Haar测度×全动量Lebesgue测度上积分D23 Gibbs权重。D21–D26把Hamiltonian固定为Σp\_i²/2+U；D7的配置partition在Icc 0 1上积分exp(−βU)。周期性保证任意代表元选取不影响权重，torus积分与单位基本域积分一致，边界测度为0。右边sqrt(2πβ⁻¹)^N是单位质量高斯因子，等式正确。该[EXTRA]独立特例不覆盖第21、22条的一般质量/配置域。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicPartitionBridge` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:317`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-ConfiningPartition

印刷p.218–220 / PDFp.239–241；§6.1.3。

### 1. 原文陈述

> Typically one assumes that (i) $`U`$ is smooth except on a low-dimensional set of singular points, (ii) $`U`$ is bounded below (which is normally the case if a potential such as Lennard-Jones, steeply repulsive at short range, is incorporated between all pairs of atoms), and (iii) $`U`$ grows sufficiently rapidly as $`q\to\infty`$, in the case of an infinite domain.
> [\ldots]
> Typical assumptions for potentials on the unbounded domain are that (i) $`U`$ is bounded below, and (ii) $`U`$ grows sufficiently rapidly as $`q\to\infty`$. This ensures that

$$
\int_\Omega\exp(-\beta U(q))d\omega_q\lt \infty.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem confiningPartition :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β c p C : ℝ),
  Continuous U → 0 < β → 0 < c → 0 < p →
  (∀ q, c*Real.rpow ‖q‖ p-C ≤ U q) → Integrable (fun q ↦ Real.exp (-β*U q)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]无奇点的连续全空间充分条件：U(q)≥c‖q‖ᵖ−C，其中c,p,β>0；把“足够快”明确量化，不将任意增长都视为足够。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对象是任意有限维V n上的连续U，以及实β,c,p,C；要求β,c,p>0并对全部q有c‖q‖^p−C≤U(q)。于是0<exp(−βU(q))≤exp(βC)exp(−βc‖q‖^p)，右侧在有限维空间任意p>0下可积，故结论正确。Pi范数与Euclidean范数等价，V n使用坐标函数范数不破坏可积性。C可为任意实数，无须额外C≥0。[EXTRA]已经把“足够快”量化，并明确只处理无奇点连续全空间充分条件，未声称涵盖一般奇点势或任意缓慢增长。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.confiningPartition` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:326`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-LennardJonesNonintegrable

印刷p.219 / PDFp.240；§6.1.3。

### 1. 原文陈述

> For example a collection of atoms on the infinite domain interacting in Lennard-Jones potentials does not satisfy the third condition, and it does not have a well defined canonical partition function. We can understand this by considering what happens over time in such a system. For simplicity, just take the case of a one degree-of-freedom system with $`H=p^2/2+q^{-12}-q^{-6}`$, $`q\gt 0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lennardJonesNonintegrable : ∀ β : ℝ, 0 < β →
  ¬ IntegrableOn (fun q : ℝ ↦ Real.exp (-β*(q⁻¹^12-q⁻¹^6))) (Ioi 0) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]精确取原一自由度例子的q>0配置权重；动量Gaussian有限因子不会修复配置尾部发散。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量化任意β>0，结论恰为q>0上exp[−β((q⁻¹)^12−(q⁻¹)^6)]不可积。Lean的逆元幂在q>0与原q⁻¹²−q⁻⁶一致。对q≥1，此势≤0，故权重≥1，尾积分直接发散；无需把q=0奇点或数值轨迹作为理由。动量高斯有限且正，不能消去配置积分发散。[EXTRA]清楚限定为原书一自由度例子的配置结论，未声称凭此定理已证明任意多体Lennard-Jones系统的发散。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lennardJonesNonintegrable` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:334`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-LennardJonesConfinement

印刷p.219 / PDFp.240；§6.1.3。

### 1. 原文陈述

> In order to use a one degree-of-freedom model on an infinite domain in the canonical setting, we would need to incorporate a restraining potential, slightly modifying for example the Lennard-Jones potential to $`U(q)=q^{-12}-q^{-6}+\epsilon q^2`$ (Fig. 6.2).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lennardJonesConfinement : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ,
  ∀ q : ℝ, ε*q^2- C ≤ q⁻¹^12-q⁻¹^6+ε*q^2 := by
  intro ε hε
  refine ⟨1/4, ?_⟩
  intro q
  have hsq := sq_nonneg (q⁻¹^6 - 1/2)
  have heq : q⁻¹^12 = (q⁻¹^6)^2 := by ring
  rw [heq]
  nlinarith
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]ε>0；保存完整势能公式，并给出足以控制无穷尾部的二次下界；q=0处总逆元记号不替代原q>0模型，不计奇点积分已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对每个ε>0存在统一C，使所有实q满足εq²−C≤(q⁻¹)^12−(q⁻¹)^6+εq²。取t=(q⁻¹)^6，有t²−t=(t−1/2)²−1/4，因此C=1/4即可，且不依赖ε；实逆元在q=0的总定义也满足该下界。结论是正确的全局二次下界，包含原q>0域。[EXTRA]已明确它只保存公式与控制尾部的估计，签名没有β、可积性或概率归一化结论，不把此下界本身计为完整正则化模型已证。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lennardJonesConfinement` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:340`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-PeriodicWeightIntegrable

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> If $`U`$ is smooth and the domain $`Q`$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem periodicWeightIntegrable {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  exact MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable U hU hp β hβ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]独立单位质量/单位torus、光滑周期U特例；配置Haar×动量Lebesgue采用正式flatPhaseMeasure的实际定义，避免隐式不同测度。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际声明是已标[EXTRA]的正确特例：U全轴C∞且单位周期，β>0，D23的真实周期Gibbs权重关于flatPhaseMeasure n可积。flatPhaseMeasure明确就是单位配置torus上的Haar体积×实动量Lebesgue体积，与权重的定义域一致；周期U在紧torus上有界，配置权重有界，β>0的动量高斯可积，故结论正确。原书一般有限域句子的疑误不使此严格特例的签名FAIL；json\_review保留NEEDS\_HUMAN以区分原文层面的歧义与本条数学结论PASS。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicWeightIntegrable` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:352`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-PeriodicPartitionPositive

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> In order for the density in (6.3) to be normalizable, it is necessary that the quantity $`Z_{\rm can}`$ ... be finite, i.e., that the integral converge.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem periodicPartitionPositive {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) : 0 < textbookLangevinCanonicalPartition U β := by
  apply MolecularDynamics.textbookLangevinCanonicalPartition_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正式库现成真实周期、单位质量、正β特例；正finite partition由已证可积性和严格正权重推出，未假设所需归一化结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U在Fin N→ℝ上光滑、单位周期且β>0，结论是实际实值周期canonical partition严格为正。D20中的积分域/测度与第28条一致，D23权重处处严格正；结合该情形的可积性与非零乘积体积，正性正确，N=0时也不例外。这里是[EXTRA]的真实周期单位质量特例，既未把正性当前提，也不宣称原书的“一般可归一化必需有限”本身等价于本签名；实值积分的有限性须由可积性支撑，不能只因结果类型是ℝ就略过第28条。reusable\_proofs仅为复用线索，本轮未检查其未提供证明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicPartitionPositive` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:361`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.4-PolynomialObservable

印刷p.220 / PDFp.241；§6.1.4。

### 1. 原文陈述

> In the case of periodic boundary conditions we will assume that, for any observable of interest,

$$
|\phi(q,p)|=O(\|p\|^\alpha),\qquad p\to\infty,
$$


> for some positive constant $`\alpha`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def polynomialObservable {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C * (1 + ‖x.2‖) ^ r
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]q在实际紧torus上；用一致C(1+‖p‖)^r、C≥0及自然数r表达至多多项式增长，实α可取更大整数；不证明每个可观测量自动满足增长界。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对象为单位配置环面×实动量空间。存在统一C≥0、自然数r，对全部配置和动量有全局界。该条件是明确标注的较强增长条件；仅靠环面紧性并不能把任意不连续函数的渐近界升级为全局界，不能把此定义宣称为对所有函数都与原大O等价。对连续可观测量和一致的大O，紧集有界后可作此替换。r=0也允许，仍满足某个正指数的渐近界。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.polynomialObservable` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:368`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.4-CanonicalAveragePrinted

印刷p.220 / PDFp.241；§6.1.4。

### 1. 原文陈述

> Under assumptions on the potential energy as discussed above, and with $`\phi`$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $`\rho_\beta`$, namely

$$
\operatorname{Av}_\beta(\phi)=Z_{\rm can}^{-1}\int_D\phi(q,p)\rho_\beta(q,p)d\omega.\tag{6.4}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def canonicalAveragePrinted {Nc : ℕ} (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ *
    ∫ z, f z * MolecularDynamics.Chapter06Review.canonicalDensity volume H β z
```

同问题的独立限定/修正版（位于另一条）：
```lean
noncomputable def canonicalAveragePrinted_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed定义确实在D1已归一密度之外又乘D2的Z倒数；全实相空间、H、β、f的类型一致。作为原书字面定义忠实，不能因其非标准平均而判签名FAIL；原书与(6.3)及p.221用法冲突，须人工处理。修正版已在条目5给出，需分别看待。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalAveragePrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:374`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.4-CanonicalAverage

印刷p.220–221 / PDFp.241–242；§6.1.4。

### 1. 原文陈述

> We will denote the average with respect to the canonical probability density by $`\operatorname{Av}_\beta`$. Using (6.4), we can compute the average of the function $`p^2`$ as

$$
\operatorname{Av}_\beta(p^2)=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}p^2\rho_\beta dqdp.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def canonicalAverage {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z

/-- 修正版，对应原文 MD-6.1.4-CanonicalAveragePrinted；改动：去掉对已经归一化ρβ的第二次Zcan⁻¹；沿用未归一权重乘一次Zcan⁻¹的定义。 -/
noncomputable def canonicalAveragePrinted_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ * ∫ z, f z * textbookHamiltonianGibbsWeight H β z
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA][ERRATUM?]按p.221的实际用法与概率平均标准定义去掉式(6.4)对已归一ρ的第二次Z⁻¹；原字面版仍保留NEEDS\_HUMAN。

### 6. 审计结论（含网站结论）

网站原返回：PASS。canonicalAverage与canonicalAveragePrinted\_corrected均为D2真实partition倒数乘未归一权重积分，只含一个归一化因子。两者对同一全实相空间及任意H、β、f定义；无可积性前提是总定义的延拓，不表示任意输入都已是概率平均。修正与p.221一致，合理且定义正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalAverage` | 定义 | — | PASS |
| `MD.Ch06.canonicalAveragePrinted_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:381`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.4-CanonicalAverageOne

印刷p.218–220 / PDFp.239–241；§6.1.4。

### 1. 原文陈述

> The quantity $`Z_{\rm can}`$ is a normalizing constant so that this is a probability density.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem canonicalAverageOne {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (hρ : Integrable (textbookHamiltonianGibbsWeight H β)) :
    textbookCanonicalAverage H β (fun _ ↦ 1) = 1 := by
  apply MolecularDynamics.textbookCanonicalAverage_one <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]标准归一化概率平均的实际检验Avβ(1)=1；保留旧CH06-017，独立于错误的式(6.4)重复归一化字面定义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀Nc、H、β；hρ为整个实相空间权重可积。正指数在非零Lebesgue测度上可积，积分自动严格正（Nc=0时单点体积亦为1），故不缺Z≠0前提。D4积分化为Z⁻¹Z=1。[EXTRA]正确地区分了Printed错误平均。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalAverageOne` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:392`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-Equipartition

印刷p.221 / PDFp.242；§6.1.5。

### 1. 原文陈述

> We then integrate by parts to obtain

$$
\operatorname{Av}_\beta(p^2)=m\beta^{-1},
$$


> which means that $`T=\operatorname{Av}_\beta\left(\frac{p^2}{mk_B}\right)`$.
> If we consider a $`N_d=N_c`$ degree of freedom system with kinetic energy $`K=\sum_{i=1}^{N_c} p_i^2/(2m_i)`$ and potential energy $`U(q_1,q_2,\ldots,q_{N_c})`$, then we may decompose the unnormalized canonical distribution as

$$
\exp(-\beta[K(p)+U(q)])=\exp(-\beta K(p))\exp(-\beta U(q)) =\exp(-\beta U(q))\prod_{i=1}^{N_c}\exp\left(-\beta\frac{p_i^2}{2m_i}\right).
$$


> Then we again find, by the integration argument given above, that $`\operatorname{Av}_\beta(m_i^{-1}k_B^{-1}p_i^2)=T`$.

$$
\operatorname{Av}_\beta(2K)=N_ck_BT.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem equipartition :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  0 < (∫ q, Real.exp (-β*U q)) →
  (∀ i, (∫ x : MolecularDynamics.Chapter06Review.Phase n, (x.2 i)^2 * MolecularDynamics.Chapter06Review.canonicalDensity volume (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) = m i/β) ∧
  (∫ x : MolecularDynamics.Chapter06Review.Phase n, (∑ i, (x.2 i)^2/m i) * MolecularDynamics.Chapter06Review.canonicalDensity volume (MolecularDynamics.Chapter06Review.massHamiltonian m U) β x) = n/β := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]标准归一化真实全空间密度、正β及全部正质量；可积且正配置partition；β⁻¹=kBT，完整逐坐标和总动能两项保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。V n=Fin n→ℝ，Phase n=V n×V n；D5含每坐标质量。全部质量正、β正、配置权重可积且积分正；高斯动量因子给出每个i的p\_i²平均=m\_i/β及总和平均=n/β，二者均保留。n=0结论仍成立；β⁻¹=kBT作为物理记号替换已标明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.equipartition` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:400`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-ConfigurationalTemperature

印刷p.222 / PDFp.243；§6.1.5。

### 1. 原文陈述

> For example, Rugh [319] suggested the formula

$$
\frac{\operatorname{Av}_\beta(\|\nabla U\|^2)}{\operatorname{Av}_\beta(\Delta U)}=k_BT.\tag{6.5}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem configTemperature :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  ContDiff ℝ 2 U → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q ^ 2 * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial (textbookConfigurationPartial U i) i q * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q * Real.exp (-β*U q))) →
  0 < (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) →
  (∫ q, (∑ i, textbookConfigurationPartial U i q ^ 2) * Real.exp (-β*U q)) /
    (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) = β⁻¹ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]C²实际U、正β、真实梯度和二阶导数、各加权导数可积及严格正分母；不是将比值等式作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C²U、β>0、配置权重可积、逐坐标三类加权导数可积及拉普拉斯加权积分正。D7为真实坐标偏导；分子为欧氏梯度平方的坐标和，分母为拉普拉斯。对∂iU exp(-βU)作全空间W¹,¹分部积分即有分母=β分子，正分母允许相除；共同partition消去，结论确为β⁻¹。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.configTemperature` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:410`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-Proposition61

印刷p.222 / PDFp.243；§6.1.5。

### 1. 原文陈述

> Proposition 6.1 Let $`H`$ be a Hamiltonian defined on the phase space $`\mathbb R^{2N_c}`$ and suppose $`G:\mathbb R^{2N_c}\to\mathbb R^{2N_c}`$ is a smooth ($`C^1`$) vector field with the following properties:

$$
0\lt |\operatorname{Av}_\beta(G\cdot\nabla H)|\lt \infty,\quad 0\lt \operatorname{Av}_\beta(\nabla\cdot G)\lt \infty,\quad |Ge^{-\beta H}|\lt \infty.
$$


> Then

$$
k_BT=\frac{\operatorname{Av}_\beta(G\cdot\nabla H)}{\operatorname{Av}_\beta(\nabla\cdot G)}.
$$



### 2. 原文证明

> The proof relies on a $`2N_c`$-dimensional version of integration by parts. Let $`B_R`$ be the $`2N_c`$-dimensional ball centered at the origin, of radius $`R`$, and let $`\Gamma_R`$ be its boundary, the $`2N_c-1`$-dimensional sphere. Then, for any smooth scalar field $`g`$ defined on $`B_R`$, we have

$$
\int_{B_R}G\cdot\nabla g\,d\omega=\int_{\Gamma_R}(Gg)\cdot\hat n\,d\Gamma-\int_{B_R}(\nabla\cdot G)g\,d\omega.\tag{6.6}
$$


> where $`d\omega=dq_1\ldots dp_{N_c}`$ is the standard measure of Lebesgue integration in $`\mathbb R^{2N_c}`$, and $`d\Gamma`$ is the surface area element of the hypersphere, and $`\hat n`$ represents the unit outward normal of the sphere. Replace $`g`$ by $`\rho_\beta=\exp(-\beta H)`$, then it follows that

$$
\left|\int_{\Gamma_R}(G\rho_\beta)\cdot\hat n\,d\Gamma\right|\leq\max_{\Gamma_R}|G\rho_\beta|\sigma_R
$$


> where $`\sigma_R`$ is the surface area of the hypersphere. Divide (6.6) by the volume $`v_R`$ of $`B_R`$. Then, for large $`R`$, since the ratio of surface area to volume is proportional to $`R^{-1}`$, we have

$$
\frac{\int_{B_R}G\cdot\nabla\rho_\beta d\omega}{v_R}\approx\frac{-\int_{B_R}(\nabla\cdot G)\rho_\beta d\omega}{v_R}.
$$


> Since $`\nabla\rho_\beta=-\beta\nabla H\rho_\beta`$, we obtain, in the limit $`R\to\infty`$, the desired result.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition61 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :
    kB * T =
      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /
        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G) := by
  apply MolecularDynamics.proposition_6_1 <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem proposition61_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (kB T : ℝ) (hkB : 0 < kB) (hT : 0 < T) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H (kB * T)⁻¹))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H (kB * T)⁻¹ z • G z‖ ≤ C)
    (hpos : 0 < textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G)) :
    kB * T =
      textbookCanonicalAverage H (kB * T)⁻¹ (textbookLieDerivative G H) /
        textbookCanonicalAverage H (kB * T)⁻¹ (textbookDivergence G) := by
  apply MolecularDynamics.proposition_6_1 <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正kB,T、实际C¹ H,G、Gibbs及两个加权可观测量可积，分母严格正；原|Ge⁻βH|<∞解释为统一有界C≥0，不采用仅逐点有限的空洞条件。
- [EXTRA] 所交为显式加强条件的温度恒等式；原证明除以球体积后取极限只给0=0，保留原证明并登记缺口；原下标和体积元依网站原页修订，未认证原论证。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。proposition61及proposition61\_corrected签名相同：在2Nc维实相空间，kB,T>0、H,G为C¹、Gibbs权重及散度/能量方向导数乘权重可积、权重乘G统一有界、归一散度平均严格正，推出kB*T为两归一平均之比。GibbsWeight=exp(-βH)、partition=积分、average=Z⁻¹乘加权积分、LieDerivative=fderiv H(G)、divergence=trace(DG)，均吻合。上述加强条件足以用截断IBP证明；两签名PASS。原书仅由边界/体积→0，不能推出未缩放积分相等，故本条整体NEEDS\_HUMAN；不能把调用现有定理当作原书证明通过。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition61` | 已证 | — | PASS |
| `MD.Ch06.proposition61_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:424`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-WeightedFluxZero

印刷p.222 / PDFp.243；§6.1.5。

### 1. 原文陈述

> The proof relies on a $`2N`$-dimensional version of integration by parts.
> Since $`\nabla\rho_\beta=-\beta\nabla H\rho_\beta`$, we obtain, in the limit $`R\to\infty`$, the desired result.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem weightedFluxZero {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    (∫ z, textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z) = 0 := by
  apply MolecularDynamics.textbookCanonicalWeightedFlux_integral_divergence_eq_zero <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实全空间、原有统一加权场界及可积性，导出实际div(ρG)积分零，不把边界通量消失作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意β、C¹H,G；权重、散度项、能量项可积及F=exp(-βH)G统一有界。结论是实际∫divF=0而非将通量消失作前提。可用w=exp(-βH)>0的层集截断：divF和F·∇log w可积，w≥ε部分有限体积且F有界，空间截断后再令ε趋0。原书单纯除球体积的论证不够，但这里的加强前提可支持该结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedFluxZero` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:455`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-CanonicalDivergenceIdentity

印刷p.222 / PDFp.243；§6.1.5。

### 1. 原文陈述

> Since $`\nabla\rho_\beta=-\beta\nabla H\rho_\beta`$, we obtain, in the limit $`R\to\infty`$, the desired result.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem canonicalDivergenceIdentity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (hH : ContDiff ℝ 1 H) (hG : ContDiff ℝ 1 G)
    (hρI : Integrable (textbookHamiltonianGibbsWeight H β))
    (hdivI : Integrable (fun z ↦ textbookDivergence G z * textbookHamiltonianGibbsWeight H β z))
    (henergyI : Integrable (fun z ↦ textbookLieDerivative G H z * textbookHamiltonianGibbsWeight H β z))
    (C : ℝ) (hC : 0 ≤ C)
    (hbound : ∀ z, ‖textbookHamiltonianGibbsWeight H β z • G z‖ ≤ C) :
    textbookCanonicalAverage H β (textbookDivergence G) =
      β * textbookCanonicalAverage H β (textbookLieDerivative G H) := by
  apply MolecularDynamics.textbookCanonicalAverage_divergence_eq_beta_lieDerivative <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]同一真实全空间、实际权重可积及统一有界场；导出Avβ(divG)=βAvβ(G·∇H)，不假设IBP结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。与条目10相同完整对象及前提，D4仅在外面乘共同Z⁻¹。由div(wG)=w divG-βw dH(G)及条目10类型的积分恒等式得Av(divG)=βAv(dH(G))，无需β正也无需把恒等式预设；[EXTRA]与实际一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalDivergenceIdentity` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:468`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-TemperatureChoiceDerivatives

印刷p.223 / PDFp.244；§6.1.5。

### 1. 原文陈述

> Observe that, defining $`G=(0,p)^T`$ yields the kinetic temperature observable $`k_BT=\operatorname{Av}_\beta(p^TM^{-1}p)/N_c`$, whereas $`G=(\nabla U(q),0)^T`$ gives the configurational temperature observable (6.5).
> An even simpler configuration-dependent choice is derived from $`G=(q,0)^T`$, corresponding to

$$
k_BT=\frac{\operatorname{Av}_\beta(q\cdot\nabla U)}{N_c}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem temperatureChoiceDerivatives :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (q p : MolecularDynamics.Chapter06Review.V n),
  (∀ i, 0 < m i) → ContDiff ℝ 2 U →
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) (0,p) = ∑ i, p i^2/m i ∧
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) ((fun i ↦ textbookConfigurationPartial U i q),0) =
    ∑ i, textbookConfigurationPartial U i q ^ 2 ∧
  fderiv ℝ (MolecularDynamics.Chapter06Review.massHamiltonian m U) (q,p) (q,0) = ∑ i, q i * textbookConfigurationPartial U i q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]保存三个原实际向量场的真实方向导数/分子计算；完整动能、配置温度和virial平均公式分别在Equipartition、ConfigurationalTemperature、VirialTemperature保留，不将分子计算计为完整温度公式。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀n,m,U,q,p，全部质量正及C²U。D5在三个实际切向量(0,p)、(∂U,0)、(q,0)上的Fréchet导数，分别为动能二倍、梯度平方和、virial坐标和，三个合取完整。它没有计算散度或平均温度，但此范围缩小已由[EXTRA]明确说明，完整公式另列条目7、8、16。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.temperatureChoiceDerivatives` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:482`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-PeriodicBoundaryCancellation

印刷p.223–224 / PDFp.244–245；§6.1.5。

### 1. 原文陈述

> If $`G`$ and $`H`$ are both periodic in $`q`$ and $`G`$ is smooth, then everything works since the outward pointing normal will be in opposite directions on each side of the simulation cell, and the boundary term will cancel.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem periodicBoundaryCancellation {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ ∞ (F i))
    (hp : ∀ i, textbookUnitPeriodicPotential (F i)) :
    (∫ q in textbookConfigurationCube Nc,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0 := by
  apply MolecularDynamics.textbookConfigurationCube_integral_divergence_eq_zero <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正式现成单位周期配置cube的真实光滑向量场散度积分；F为实际各分量，可以对固定p取F=Gρ；无穷动量方向仍需原尾部资格，不计所有p积分可积性已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。F为Fin Nc索引的真实配置向量场分量；各分量C∞且对全部整数向量平移周期。配置域为Icc 0 1，D7的同坐标偏导求和。逐坐标基本定理及对面周期值相等使积分为0。光滑性较原C¹强、单位盒及固定p截面均已标[EXTRA]，没有声称动量无穷尾部自动可积。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicBoundaryCancellation` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:493`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-MeanEnergyConstraint

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> whereas $`\beta`$ and hence the temperature arises from the choice of average energy, i.e. from solving the equation

$$
\frac{\int H(z)e^{-\beta H(z)}d\omega}{\int e^{-\beta H(z)}d\omega}=\bar E.
$$


> Alternatively, we may take the position that the temperature is specified and the mean energy is a direct consequence of this choice.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def meanEnergyConstraint {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β meanEnergy : ℝ) : Prop :=
  (∫ z, H z * Real.exp (-β*H z) ∂ν) / (∫ z, Real.exp (-β*H z) ∂ν) = meanEnergy
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

网站原返回：PASS。对任意可测D、测度ν、实值Hamiltonian H及实β,meanEnergy，定义命题为∫H exp(−βH)/∫exp(−βH)=meanEnergy；两处测度相同，权重与分式方向正确。它只是确定β所需的约束定义，没有为任意给定能量伪造β存在或唯一性。Lean积分和实除法是总定义，若分母为0仍会得到形式命题，故必须连同输入已注明的物理适用条件理解，不能把定义本身当成非退化概率期望的存在定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.meanEnergyConstraint` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:502`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-DensityNormalization

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> The quantity $`Z_{\rm can}`$ is a normalizing constant so that this is a probability density.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem densityNormalization : ∀ {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ),
  Integrable (fun x ↦ Real.exp (-β*H x)) ν → 0 < (∫ x, Real.exp (-β*H x) ∂ν) →
  (∫ x, MolecularDynamics.Chapter06Review.canonicalDensity ν H β x ∂ν) = 1 := by
  intro D inst ν H β hI hZ
  simp only [MolecularDynamics.Chapter06Review.canonicalDensity]
  rw [integral_div]
  exact div_self hZ.ne'
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]任意实际参考测度、权重可积且分母正；结论是实际归一化，不假设密度积分一。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意类型D及其可测结构、任意参考测度ν；H与β任意。D1为exp(-βH)/实际积分。权重可积及积分严格正恰使积分等于Z/Z=1；无循环前提。[EXTRA]准确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.densityNormalization` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:508`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-PartitionInversePrinted

印刷p.220 / PDFp.241；§6.1.5。

### 1. 原文陈述

> The associated canonical density is

$$
\rho_\beta=Z_{\rm can}^{-1}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right),
$$


> where

$$
Z_{\rm can}^{-1}=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right)dpdq.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem partitionInversePrinted : ∀ {n : ℕ}
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β →
  Integrable (fun x : MolecularDynamics.Chapter06Review.Phase n ↦
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x))⁻¹ =
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) := by
  sorry

/-- 修正版，对应原文 MD-6.1.5-PartitionInversePrinted；改动：Zcan定义为积分本身；归一密度的结论另见DensityNormalization，避免把定义重述作新定理。 -/
def partitionInversePrinted_corrected {n : ℕ} (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) : ℝ :=
  ∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)
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

网站原返回：NEEDS\_HUMAN。partitionInversePrinted把正质量、β>0且Gibbs权重可积时的积分Z写成Z⁻¹=Z，忠实记录归一因子印刷疑误，数学上一般不成立。维数n由一自由度原文推广到任意n；massHamiltonian的动能分母2m\_i、Phase=位置×动量、全空间体积积分已核对。partitionInversePrinted\_corrected只把积分定义为配分函数，PASS作为定义；未断言该任意参数总化积分正有限，也未证明密度归一化。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.partitionInversePrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.partitionInversePrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:520`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-WeightedFluxIdentity

印刷p.222 / PDFp.243；§6.1.5。

### 1. 原文陈述

> Since $`\nabla\rho_\beta=-\beta\nabla H\rho_\beta`$, we obtain, in the limit $`R\to\infty`$, the desired result.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem weightedFluxIdentity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (G : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (β : ℝ) (z : SymplecticCoordinates Nc)
    (hH : DifferentiableAt ℝ H z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ textbookHamiltonianGibbsWeight H β x • G x) z =
      textbookHamiltonianGibbsWeight H β z *
        (textbookDivergence G z - β * textbookLieDerivative G H z) := by
  apply MolecularDynamics.textbookCanonicalWeightedFlux_divergence <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Fréchet导数和散度乘法恒等式，β任意、H,G在该点可微；不假设加权散度恒等式。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀Nc,H,G,β,z；只要求H和G在z可微。D3权重乘向量场、D8导数迹及D9方向导数满足乘积法则，恰为w(divG-βdH(G))，符号、β系数及全部量词正确；不需要全局积分前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedFluxIdentity` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:540`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

