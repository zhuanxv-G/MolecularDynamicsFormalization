上一部分：无 / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第6章逐条形式化审阅材料

正文249条；最新网站直接PASS 203条。本轮60条：25 PASS / 8 FAIL / 27 NEEDS\_HUMAN；8条按意见处理且本地核验通过，未再送网站。32项合并疑误/范围问题及1项解释记录。
统计见[导师摘要](../../CH06_SUMMARY_FOR_MENTOR.zh-CN.md)；原书问题见[勘误清单](../../CH06_ERRATA.zh-CN.md)。网站评价与证明完成情况分别统计。

## MD-6.1.1-Microcanonical

印刷p.214 / PDFp.235；§6.1.1。

### 1. 原文陈述

> The density function may then be represented by a Dirac delta function as follows:

$$
\rho_{\rm mc}=Z^{-1}\delta[H-E],\qquad Z=\int_D\delta[H-E]d\omega.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def microcanonical {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (energy : ℝ) :=
  MolecularDynamics.Chapter05Review.microMeasure H energy
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

网站原返回：PASS。对象为任意自然数维数n、实值Hamiltonian H:E n→ℝ及实能量energy。microcanonical直接返回microMeasure；展开为能量面上的1/‖gradient H‖加权面积测度再除以其总质量，符合Dirac记号的测度解释。它是总定义，不宣称任意H、energy均给概率测度；正则性及总质量正且有限的物理适用范围已在context\_notation明确，不能把此定义计为coarea识别或归一化定理。原D由所选环境/相空间承载，此签名没有独立的任意区域D参数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.microcanonical` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:65`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-Entropy

印刷p.214 / PDFp.235；§6.1.2。

### 1. 原文陈述

> In terms of a microcanonical system, the entropy is enshrined in the famous formula that appears on Boltzmann's tombstone:

$$
S:=k_B\ln Z.\tag{6.1}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)
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

网站原返回：PASS。kB∈ℝ、Z:ℝ→ℝ及能量E∈ℝ的定义值恰为kB*log(Z E)，与Boltzmann熵定义一致。把Z写成能量函数没有改变固定能量处的公式。Z>0及物理常量的适用说明已经列出；定义自身不证明正性、物理第二定律或极值。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.entropy` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:69`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-IndependentPartition

印刷p.215 / PDFp.236；§6.1.2。

### 1. 原文陈述

> We denote by $`Z(E_A,E_B)`$ the total number of states the system can occupy with systems A and B having energies $`E_A`$ and $`E_B`$, respectively. We make use of our assumption that the two systems do not exchange particles so that the total number of states the combined system can be found in depends solely on the energies of the two independent systems, i.e.,

$$
Z(E_A,E_B)=Z_A(E_A)\times Z_B(E_B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem independentPartition :
  ∀ {n m : ℕ} (HA : Chapter05Review.E n → ℝ)
    (HB : Chapter05Review.E m → ℝ) (EA EB : ℝ),
  Chapter05Review.regularEnergy HA EA → Chapter05Review.regularEnergy HB EB →
  let μA := Chapter05Review.microRaw HA EA
  let μB := Chapter05Review.microRaw HB EB
  (μA.prod μB) univ = μA univ * μB univ := by
  intro n m HA HB EA EB hA hB
  letI : IsFiniteMeasure (MolecularDynamics.Chapter05Review.microRaw HA EA) := ⟨hA.2.2.2.2⟩
  letI : IsFiniteMeasure (MolecularDynamics.Chapter05Review.microRaw HB EB) := ⟨hB.2.2.2.2⟩
  dsimp
  simpa only [univ_prod_univ] using (Measure.prod_prod
    (μ := MolecularDynamics.Chapter05Review.microRaw HA EA)
    (ν := MolecularDynamics.Chapter05Review.microRaw HB EB) univ univ)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]独立、分别固定能量的真实加权能量面测度乘积；不将固定总能量partition的卷积偷换为乘积。
- [EXTRA] 只补regularEnergy的真实定义体；不因未摘录而认定原书有错，不删正则前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS：independentPartition 对任意维数n,m、实值Hamiltonian及分别固定的EA,EB，在regularEnergy前提下断言两个microRaw测度的乘积总质量等于总质量之积。E为EuclideanSpace；microRaw确为能量面Hausdorff测度乘以逆梯度范数，regularEnergy含非空、紧性、非零梯度、正有限质量，均已核对。前提比原书独立状态计数强，已由[EXTRA]披露。这里只把联合系统明确解释为独立测度乘积，未证明固定总能量的卷积公式，也没有偷换为该公式。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.independentPartition` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:74`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-EntropyAdditivity

印刷p.215 / PDFp.236；§6.1.2。

### 1. 原文陈述

> Taking logarithms and replacing the value for $`E_B`$ by $`E-E_A`$, we have

$$
\ln Z(E_A,E-E_A)=\ln Z_A(E_A)+\ln Z_B(E-E_A).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem entropyAdditivity :
  ∀ (kB ZA ZB : ℝ), 0 < ZA → 0 < ZB →
  kB*Real.log (ZA*ZB) = kB*Real.log ZA+kB*Real.log ZB := by
  intro kB ZA ZB hA hB
  rw [Real.log_mul hA.ne' hB.ne']
  ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]两个正实数partition；结论同时保留乘kB的熵加法，kB=1包含所印log式。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量化任意实kB,ZA,ZB，并明确要求ZA,ZB>0；结论完整保留kB log(ZA ZB)=kB log ZA+kB log ZB，两边加号及乘法因子正确。把能量处的两个partition值作为实参数是合法抽象。取kB=1就是原页对数式；任意kB给出已标[EXTRA]的熵加法，没有添加独立性结论或偷换固定总能量的积分。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.entropyAdditivity` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:91`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-EntropyEquilibrium

印刷p.215 / PDFp.236；§6.1.2。

### 1. 原文陈述

> This value of $`E_A`$ occurs where

$$
\frac{d}{dE_A}\ln Z(E_A,E-E_A)=0,
$$


> or equivalently where

$$
\frac{d}{dE_A}S_A=\frac{d}{dE_B}S_B,
$$


> where we have used Boltzmann's relation to express this in terms of the entropy.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem entropyEquilibrium :
  ∀ (SA SB : ℝ → ℝ) (E e : ℝ),
  DifferentiableAt ℝ SA e → DifferentiableAt ℝ SB (E-e) →
  IsLocalMax (fun x ↦ SA x+SB (E-x)) e → deriv SA e = deriv SB (E-e) := by
  intro SA SB energy e hSA hSB hmax
  have hd := hSA.hasDerivAt.add (hSB.hasDerivAt.comp_const_sub energy e)
  have hz := hmax.hasDerivAt_eq_zero hd
  linarith
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]固定总能量；两个熵函数在相应能量可微，内点局部最大为前提；实际导数相等为结论，不假设平衡导数关系。

### 6. 审计结论（含网站结论）

网站原返回：PASS。SA,SB:ℝ→ℝ，E为固定总能量、e为A的能量；在e及E−e处可微，且x↦SA x+SB(E−x)在e有局部最大，是已明示的[EXTRA]内点情形。其导数为SA′(e)−SB′(E−e)，故结论SA′(e)=SB′(E−e)正确，链式求导负号没有遗漏。没有把该一阶必要条件表述成平衡存在、最大值充分性或热力学定律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.entropyEquilibrium` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:100`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-Temperature

印刷p.215 / PDFp.236；§6.1.2。

### 1. 原文陈述

> The temperature of a system $`T`$, is defined as

$$
\frac1T:=\frac{\partial S}{\partial E}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (MolecularDynamics.Chapter06Review.inverseTemperature S E)⁻¹
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

网站原返回：PASS。S:ℝ→ℝ及实能量E的temperature定义为inverseTemperature S E的倒数；展开项目定义即(deriv S E)⁻¹，方向正确。固定其他物理参数后单变量导数承载原偏导。Lean逆元与deriv均为总定义，此条不宣称S必可微或T必正；context\_notation已限定实际导数及非零情形下的温度解释。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.temperature` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:110`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-InverseThermal

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> giving, when the system is in thermal equilibrium,

$$
\frac{d}{dE_A}\ln Z_A(E_A)=\frac{d}{dE_B}\ln Z_B(E_B)=\frac1{k_BT}=: \beta.\tag{6.2}
$$


> We shall refer to the quantity $`\beta`$ as the system's inverse or reciprocal temperature.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹
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

网站原返回：PASS。inverseThermal量化kB,T∈ℝ，值为(kB*T)⁻¹，恰好形式化β的定义。该定义自身没有A、B两个系统，不能被计作式(6.2)整条平衡导数关系的证明；输入context\_notation已明确将导数关系分给EntropyEquilibrium及LogTemperature，并注明物理解释要求kB,T>0，因此定义范围匹配。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.inverseThermal` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:113`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-BathTaylor

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> Since $`Z_B(E-s)=\exp(S_B(E-s)/k_B)`$, and $`s\ll E`$, we (naively) apply the mean value theorem to $`S_B`$ to obtain

$$
S_B(E-s)=S_B(E)-S'_B(\xi)s,
$$


> and from $`S'_B(\xi)=1/T`$, we obtain

$$
Z_B(E-s)\propto\exp(-\beta s).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathBoltzmannPrinted : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  ContDiff ℝ 2 S → 0 < energy → 0 < kB → deriv S energy = kB * β →
  (∀ s : ℝ, 0 < s → ∃ ξ ∈ Icc (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s) ∧
  (∀ s ∈ Icc (0 : ℝ) energy,
    Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s)) := by
  sorry

theorem bathBoltzmannPrinted_counterexample : Real.exp ((0 : ℝ)^2-1^2) ≠ Real.exp (-2) := by
  intro h
  have hn := Real.exp_injective h
  norm_num at hn
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem bathBoltzmannPrinted_corrected : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s) := by
  intro S energy kB β hS hkB hder s
  have hm : ∀ a b : ℝ, a < b → S b-S a = kB*β*(b-a) := by
    intro a b hab
    obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hab hS.continuous.continuousOn hS.differentiableOn
    have hn : b-a ≠ 0 := by linarith
    rw [hder ξ] at hd
    exact ((eq_div_iff hn).mp hd).symm
  have he : S (energy-s)-S energy = -kB*β*s := by
    rcases lt_trichotomy s 0 with hs | rfl | hs
    · have hh := hm energy (energy-s) (by linarith)
      nlinarith
    · simp
    · have hh := hm (energy-s) energy (by linarith)
      nlinarith
  have hd : (S (energy-s)-S energy)/kB = -β*s := by
    apply (div_eq_iff hkB.ne').mpr
    nlinarith [he]
  rw [← Real.exp_sub, ← sub_div, hd]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]熵C²、正热浴能量及kB；β以原页固定温度关系表示，不假设所需中间点导数恒定。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。
- [EXTRA] 复审范围：修正版只是全局恒定熵导数（仿射熵）特例，未给一般热浴近似误差界。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。bathBoltzmannPrinted：中值部分在C²前提下正确；第二合取把只在energy处给定的导数扩张成全区间精确指数比，不是中值定理的推论。作为Printed，保留原书启发式而标NEEDS\_HUMAN，不因其错误直接判签名FAIL。bathBoltzmannPrinted\_counterexample：exp(-1)≠exp(-2)正确，代入S(e)=e²、energy=kB=s=1、β=2即见原断言失败。bathBoltzmannPrinted\_corrected：所有e处deriv S e=kB*β且S可微、kB>0，足以推出任意实数s的精确比值；是正确的全局仿射熵限定版，但并非一般热浴近似的误差估计。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
修正版只是全局恒定熵导数（仿射熵）特例，未给一般热浴近似误差界。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathBoltzmannPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |
| `MD.Ch06.bathBoltzmannPrinted_counterexample` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:119`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-LogTemperature

印刷p.215–216 / PDFp.236–237；§6.1.2。

### 1. 原文陈述

> The temperature of a system $`T`$, is defined as $`1/T:=\partial S/\partial E`$, giving, when the system is in thermal equilibrium,

$$
\frac{d}{dE_A}\ln Z_A(E_A)=\frac{d}{dE_B}\ln Z_B(E_B)=\frac1{k_BT}=: \beta.\tag{6.2}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem logTemperature : ∀ (kB : ℝ) (Z : ℝ → ℝ) (energy : ℝ),
  DifferentiableAt ℝ Z energy → 0 < Z energy →
  deriv (fun e ↦ Real.log (Z e)) energy = deriv Z energy / Z energy ∧
  MolecularDynamics.Chapter06Review.inverseTemperature
    (MolecularDynamics.Chapter06Review.entropy kB Z) energy = kB * deriv Z energy / Z energy := by
  intro kB Z energy hZ hpos
  have hd := hZ.hasDerivAt.log hpos.ne'
  constructor
  · exact hd.deriv
  · unfold MolecularDynamics.Chapter06Review.inverseTemperature
      MolecularDynamics.Chapter06Review.entropy
    rw [deriv_const_mul kB hd.differentiableAt, hd.deriv]
    ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]partition在该能量可微且正；本条保留温度与log partition的实际微分关系，系统之间平衡关系由EntropyEquilibrium保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量化实kB、函数Z及实能量；要求Z在该点可微且值为正。第一结论是(log∘Z)′=Z′/Z，第二结论展开项目定义后为(kB log Z)′=kB Z′/Z，均正确，kB不必非零即可成立。按已标[EXTRA]，这里只是单系统的实际微分关系；跨系统等温关系由第5条处理，显式的T、β及1/(kB T)关系不在本签名结论中，不能把本条单独计为完整式(6.2)已证。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.logTemperature` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:134`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-BathMeanValue

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> we (naively) apply the mean value theorem to $`S_B`$ to obtain

$$
S_B(E-s)=S_B(E)-S'_B(\xi)s.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathMeanValue : ∀ (S : ℝ → ℝ) (energy s : ℝ),
  ContDiff ℝ 1 S → 0 < s → ∃ ξ ∈ Ioo (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s := by
  intro S energy s hS hs
  have hlt : energy-s < energy := by linarith
  obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hlt hS.continuous.continuousOn
    (hS.differentiable (by norm_num)).differentiableOn
  refine ⟨ξ, hξ, ?_⟩
  have hn : energy-(energy-s) ≠ 0 := by linarith
  have he := (eq_div_iff hn).mp hd
  nlinarith
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]C¹熵且s>0；只保留真实均值定理，不把ξ处导数改为E处导数。

### 6. 审计结论（含网站结论）

网站原返回：PASS。S:ℝ→ℝ，energy,s均为实数，C¹及s>0保证在[energy−s,energy]连续、内部可微；结论存在ξ∈Ioo(energy−s,energy)并满足所印等式，开区间条件比原页未指定ξ位置更精确。符号、区间端点及乘s的负号正确；不推出恒温指数因子。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathMeanValue` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:150`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-BathTaylorEstimate

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> Since $`Z_B(E-s)=\exp(S_B(E-s)/k_B)`$, and $`s\ll E`$, we (naively) apply the mean value theorem to $`S_B`$ to obtain

$$
S_B(E-s)=S_B(E)-S'_B(\xi)s,
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem bathTaylorEstimate :
  ∀ (S : ℝ → ℝ) (E : ℝ), ContDiff ℝ 2 S →
  ∃ C δ : ℝ, 0 ≤ C ∧ 0 < δ ∧ ∀ e, |e| < δ →
    |S (E-e)-S E+deriv S E*e| ≤ C*e^2 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]对原页热浴近似给出可核验的局部C²一阶展开及C·s²余项；这是额外严格表述，完整字面Boltzmann关系仍为NEEDS\_HUMAN。

### 6. 审计结论（含网站结论）

网站原返回：PASS。签名对每个C²实函数S及展开点E，给出C≥0、δ>0，使所有|e|<δ满足|S(E−e)−S(E)+S′(E)e|≤C e²。量词顺序、双侧邻域和余项符号正确；C²保证局部二阶导数有界。该C·e²估计是已明确标记的[EXTRA]严格化，不是原页已有的独立定理，也没有推出一般热浴的精确Boltzmann式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathTaylorEstimate` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:164`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-BoltzmannConstantSlope

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> and from $`S'_B(\xi)=1/T`$, we obtain

$$
Z_B(E-s)\propto\exp(-\beta s),
$$


> where $`\beta=(k_BT)^{-1}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem boltzmannConstantSlope : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s) := by
  intro S energy kB β hS hkB hder s
  have hm : ∀ a b : ℝ, a < b → S b-S a = kB*β*(b-a) := by
    intro a b hab
    obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hab hS.continuous.continuousOn hS.differentiableOn
    have hn : b-a ≠ 0 := by linarith
    rw [hder ξ] at hd
    exact ((eq_div_iff hn).mp hd).symm
  have he : S (energy-s)-S energy = -kB*β*s := by
    rcases lt_trichotomy s 0 with hs | rfl | hs
    · have hh := hm energy (energy-s) (by linarith)
      nlinarith
    · simp
    · have hh := hm (energy-s) energy (by linarith)
      nlinarith
  have hd : (S (energy-s)-S energy)/kB = -β*s := by
    apply (div_eq_iff hkB.ne').mpr
    nlinarith [he]
  rw [← Real.exp_sub, ← sub_div, hd]

/-- 修正版，对应原文 MD-6.1.2-BathTaylor；改动：精确Boltzmann因子增加整个能量区间的恒定熵斜率；一般热浴只保留带余项近似。 -/
theorem bathBoltzmannPrinted_corrected : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s) := by
  intro S energy kB β hS hkB hder s
  have hm : ∀ a b : ℝ, a < b → S b-S a = kB*β*(b-a) := by
    intro a b hab
    obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hab hS.continuous.continuousOn hS.differentiableOn
    have hn : b-a ≠ 0 := by linarith
    rw [hder ξ] at hd
    exact ((eq_div_iff hn).mp hd).symm
  have he : S (energy-s)-S energy = -kB*β*s := by
    rcases lt_trichotomy s 0 with hs | rfl | hs
    · have hh := hm energy (energy-s) (by linarith)
      nlinarith
    · simp
    · have hh := hm (energy-s) energy (by linarith)
      nlinarith
  have hd : (S (energy-s)-S energy)/kB = -β*s := by
    apply (div_eq_iff hkB.ne').mpr
    nlinarith [he]
  rw [← Real.exp_sub, ← sub_div, hd]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]理想恒温热浴明确要求熵导数在整个实轴恒定；不从固定能量的温度偷推出该条件，不将本条代替字面版。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量化可微实熵S、energy,kB,β；要求kB>0及所有实e处S′(e)=kBβ，再对所有实s给出精确指数比。全轴恒斜率意味着S是仿射函数，S(energy−s)−S(energy)=−kBβs，因此结论正确。恒斜率是明确标记的额外理想热浴假设，没有从单点温度偷推出此条件；与第8条Printed版严格区分。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.boltzmannConstantSlope` | 已证 | — | PASS |
| `MD.Ch06.bathBoltzmannPrinted_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:172`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-CanonicalCDFPrinted

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> On the other hand the probability for the active system to have energy $`\leq\alpha`$ is the same as the probability of the bath having energy $`\geq E-\alpha`$, this must be

$$
P(\alpha)=\Pr\{E_B\geq E-\alpha\}\propto\int_0^\alpha Z_B(E-s)ds.
$$


> [The intervening bath-entropy argument is quoted separately in MD-6.1.2-BathTaylor.]
> Thus we have $`P(\alpha)\propto\int_0^\alpha\exp(-\beta s)ds`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem canonicalCDFPrinted : ∀ (ZA ZB : ℝ → ℝ) (energy α : ℝ),
  Continuous ZA → Continuous ZB → (∀ e, 0 < ZA e) → (∀ e, 0 < ZB e) →
  0 < α → α < energy →
  (∫ s in 0..α, ZA s * ZB (energy-s)) / (∫ s in 0..energy, ZA s * ZB (energy-s)) =
  (∫ s in 0..α, ZB (energy-s)) / (∫ s in 0..energy, ZB (energy-s)) := by
  sorry

/-- 修正版，对应原文 MD-6.1.2-CanonicalCDFPrinted；改动：能量累计概率的分子分母均保留ZA(s)权重；改为正确累计概率的定义。 -/
def canonicalCDFPrinted_corrected (ZA ZB : ℝ → ℝ) (energy α : ℝ) : ℝ :=
  (∫ s in 0..α, ZA s*ZB (energy-s))/(∫ s in 0..energy, ZA s*ZB (energy-s))
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

网站原返回：NEEDS\_HUMAN。canonicalCDFPrinted：任意连续、全实轴严格正ZA,ZB，0<α<energy，等同含ZA与不含ZA的两个归一化积分。它精确呈现原书忽略简并度的主张，其数学疑误保留为NEEDS\_HUMAN。canonicalCDFPrinted\_corrected：保留分子分母ZA的定义是正确候选CDF表达式；本定义对任意函数和实α总化，不保证非负、归一、单调或分母非零。作为公式定义PASS；只有在正可积权重及0≤α≤energy时才有概率解释；定义没有证明热浴熵近似后的指数形式。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalCDFPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.canonicalCDFPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:220`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-CanonicalEnergyDensity

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> The volume (or number, in the case of discrete systems) of states available at energy $`\alpha`$ is $`Z_A(\alpha)`$. Thus the energy density of the canonical ensemble at energy level $`\alpha`$ is proportional to $`Z_A(\alpha)\exp(-\beta\alpha)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def canonicalEnergyDensity (Z : ℝ → ℝ) (β E : ℝ) : ℝ :=
  Z E * Real.exp (-β * E) / (∫ e, Z e * Real.exp (-β * e))
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

网站原返回：PASS。参数Z:ℝ→ℝ表示主动系统态密度，β,E为实数；定义分子为Z(E)exp(−βE)，分母为同一权重对全能量实轴的实际积分。比例系数不依赖E，符合所印比例关系。输入明确说明实际能量域可通过Z在域外取零表示，且正有限分母才有概率密度解释；本总定义不声称可积、非负或归一化自动成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalEnergyDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:232`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-EntropyFunctional

印刷p.217 / PDFp.238；§6.1.3。

### 1. 原文陈述

> density is as a stationary point of the Gibbs-Boltzmann entropy

$$
S=-k_B\int\rho\ln\rho\,d\omega,
$$


> subject to the constraints $`\int\rho(z)d\omega=1`$, $`\int H(z)\rho(z)d\omega=\bar E`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def entropyFunctional {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (kB : ℝ) (ρ : D → ℝ) : ℝ := -kB * ∫ x, ρ x * Real.log (ρ x) ∂ν
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

网站原返回：PASS。对象为任意可测空间D、测度ν、实kB及实函数ρ；返回−kB乘ρ logρ的Bochner积分，符号与权重正确。此条仅形式化熵泛函定义；归一化及平均能量约束由第16条另存，驻点分析由第17、18条另存，context\_notation已明确拆分。ρ≥0、可积性及0 log0的总定义不在此签名中被证明，不应把它计成任意ρ的合法概率熵定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.entropyFunctional` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:236`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-ConstrainedEntropyModel

印刷p.217 / PDFp.238；§6.1.3。

### 1. 原文陈述

> Using the method of Lagrange multipliers, we seek stationary solutions of

$$
V=S/k_B-\lambda\left[\int\rho(z)d\omega-1\right]-\beta\left[\int H(z)\rho(z)d\omega-\bar E\right]
$$


> with respect to the choice of density $`\rho`$ and coefficients $`\lambda`$ and $`\beta`$. The resulting equations for the maximizing density are obtained by variational differentiation (see Sect. 2.2.1):

$$
\frac{\delta V}{\delta\rho}=0,\quad\int\rho(z)d\omega=1,\quad\int H(z)\rho(z)d\omega=\bar E.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def constrainedEntropyModel {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H ρ : D → ℝ) (kB lambdaParam β meanEnergy : ℝ) : ℝ × Prop :=
  (MolecularDynamics.Chapter06Review.entropyFunctional ν kB ρ / kB -
    lambdaParam * ((∫ x, ρ x ∂ν)-1) - β * ((∫ x, H x * ρ x ∂ν)-meanEnergy),
    (∫ x, ρ x ∂ν) = 1 ∧ (∫ x, H x * ρ x ∂ν) = meanEnergy)
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

网站原返回：PASS。量化任意可测D、测度ν、实值H,ρ及四个实参数。返回的第一分量是S/kB−λ(∫ρ−1)−β(∫Hρ−meanEnergy)，常数项没有丢失；第二分量是两个约束的合取命题，不能把构造这个Prop误当成证明约束已成立。签名没有驻点或最大化断言，输入context\_notation已把实际一阶变分和驻点结论分给第17、18条。kB≠0下S/kB与物理表达式一致；kB=0只保留Lean总定义，不冒充约消证明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.constrainedEntropyModel` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:240`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-EntropyFirstVariation

印刷p.217–218 / PDFp.238–239；§6.1.3。

### 1. 原文陈述

> The first equation reduces to

$$
-(1+\ln\rho)-\lambda-\beta H=0
$$


> yielding $`\rho=e^{-1-\lambda}e^{-\beta H}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem entropyFirstVariation :
  ∀ {n : ℕ} (H ρ : MolecularDynamics.Chapter06Review.V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  ∀ ψ : MolecularDynamics.Chapter06Review.V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    HasDerivAt (fun e ↦ MolecularDynamics.Chapter06Review.entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β)
      (∫ x, (-(1+Real.log (ρ x))-lambdaParam-β*H x)*ψ x) 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际正连续密度、可积熵/能量及光滑紧支变分；保存对V的实际HasDerivAt积分表达式，不把Euler–Lagrange结论作前提。
- [EXTRA]省略与ρ无关的λ+βĒ常数不影响本条导数；完整含常数V另见ConstrainedEntropyModel。

### 6. 审计结论（含网站结论）

网站原返回：PASS。H,ρ定义在V n=Fin n→ℝ；H,ρ连续、ρ处处正，且ρ、ρ logρ、Hρ分别可积。对每个光滑紧支ψ，结论是沿实际ρ+eψ的entropyLagrangian在e=0处具有导数∫[−(1+logρ)−λ−βH]ψ，方向、负号、β因子及求导点均正确。正连续ρ在ψ的紧支集上有正下界，保证局部可保持密度正值并对积分求导。D17以kB=1消去熵因子，省去的λ+βĒ与ρ无关，正如[EXTRA]所述。本条只是一阶变分恒等式，原页EL及指数解由第18条承接，不误计本条已经给出点态EL。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.entropyFirstVariation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:249`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-EntropyVariation

印刷p.217–218 / PDFp.238–239；§6.1.3。

### 1. 原文陈述

> The first equation reduces to

$$
-(1+\ln\rho)-\lambda-\beta H=0
$$


> yielding

$$
\rho=e^{-1-\lambda}e^{-\beta H}.
$$


> The normalization condition determines the parameter $`\lambda`$, whereas $`\beta`$ and hence the temperature arises from the choice of average energy, i.e. from solving the equation

$$
\frac{\int H(z)e^{-\beta H(z)}d\omega}{\int e^{-\beta H(z)}d\omega}=\bar E.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem entropyVariation :
  ∀ {n : ℕ} (H ρ : MolecularDynamics.Chapter06Review.V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  (∀ ψ : MolecularDynamics.Chapter06Review.V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    IsLocalMax (fun e ↦ MolecularDynamics.Chapter06Review.entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β) 0) →
  ∀ x, -(1+Real.log (ρ x))-lambdaParam-β*H x=0 ∧
    ρ x=Real.exp (-1-lambdaParam)*Real.exp (-β*H x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]在每个光滑紧支实际密度方向的内点局部极值、正连续可积密度；不假设变分导数零或点态EL结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。与第17条相同的有限维空间及正性、连续性、三个可积性前提下，额外要求每个光滑紧支方向的实际Lagrangian在0处局部最大；没有把变分导数零或EL式直接当前提。由一阶变分及连续系数的基本变分引理得到每个x处EL式，再由ρ>0取指数得到ρ(x)=exp(−1−λ)exp(−βH(x))，两个合取结论完整且正确。此签名既不假设归一化/给定meanEnergy，也不证明λ或β存在、唯一或被指定能量确定；原文后续的约束说明仅由第16、30条记录，不能算成本定理额外结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.entropyVariation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:260`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-CanonicalDensity

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> This defines the phase space density of the canonical ensemble which we refer to as the Gibbs-Boltzmann density:

$$
\rho_\beta=Z_{\rm can}^{-1}e^{-\beta H(q,p)}.\tag{6.3}
$$


> where the parameter $`\beta=1/(k_BT)`$. The quantity $`Z_{\rm can}`$ is a normalizing constant so that this is a probability density.
> [\ldots]

$$
Z_{\rm can}=\int e^{-\beta H(q,p)}d\omega.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def canonicalDensity {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ) (x : D) : ℝ := Real.exp (-β * H x) / (∫ z, Real.exp (-β * H z) ∂ν)
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

网站原返回：PASS。可测空间D、测度ν、实H及β与点x全部显式；canonicalDensity恰为exp(−βH x)除以同一权重的实际积分，分母不是独立任意常数。测度ν承载所选相空间域。定义对应原归一化表达式；没有宣称任意ν,H,β均有正有限partition或积分为1，context\_notation已限定适用条件。输入中的β=1/(kB T)是参数解释，不是此函数隐含证明的平衡定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:271`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-MassHamiltonian

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> If we have a standard molecular Hamiltonian $`H(q,p)=p^TM^{-1}p/2+U(q)`$ with $`N_c=Nd`$ degrees of freedom

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def massHamiltonian {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  (∑ i, (x.2 i) ^ 2 / (2 * m i)) + U x.1
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

网站原返回：PASS。n个实坐标的m∈V n、势能U:V n→ℝ及相点x∈Phase n全部显式；Phase n=V n×V n，x.1为q、x.2为p。动能是Σ\_i p\_i²/(2m\_i)，等于对角质量矩阵的pᵀM⁻¹p/2，保留每个m\_i，未偷换为单位质量。定义没有限制m\_i，但context\_notation明确物理模型为正对角质量，后续积分定理也逐坐标要求m\_i>0；此处是总定义而非任意质量正定的断言。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.massHamiltonian` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:275`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-PartitionMass

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> then the integral separates

$$
Z_{\rm can}=\int_D e^{-\beta H(q,p)}d\omega =\int_{\mathbb R^{N_c}}e^{-\beta p^TM^{-1}p/2}d\omega_p\times\int_Q e^{-\beta U(q)}d\omega_q.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem partitionMass :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n, Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)) =
    (∫ q, Real.exp (-β*U q)) * ∏ i, Real.sqrt (2*Real.pi*m i/β) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]此条取Q=全配置实空间；正β、任意正对角质量和配置权重可积；一般Q用下一条独立保存。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对任意n、正对角质量m、β>0及配置权重可积的U，结论给整个Phase n上的指数积分=配置积分×Π\_i sqrt(2πm\_i/β)。[EXTRA]已明确Q取全部配置实空间，n为任意自然数，不能把它当作一般区域Q结论。D19的质量Hamiltonian与第20条相同；高斯因子与每个质量、β的依赖正确，乘积次序交换无影响。可积性保证实际实值积分与Fubini分离合法，n=0时空乘积为1亦相容。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.partitionMass` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:280`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-PartitionDomain

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> where $`Q`$ is the accessible position domain, $`d\omega_p=dp_1dp_2\cdots dp_{N_c}`$ and $`d\omega_q=dq_1dq_2\cdots dq_{N_c}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem partitionDomain : ∀ {n : ℕ}
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [SigmaFinite μ]
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) μ →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)
    ∂μ.prod (volume : Measure (MolecularDynamics.Chapter06Review.V n))) =
  (∫ q, Real.exp (-β*U q) ∂μ) * ∏ i, Real.sqrt (2*Real.pi*m i/β) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]配置测度μ为sigma-finite，原Q对应μ=volume.restrict Q；真实乘积测度及一般正质量，不将有限域换为torus。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量化任意n及配置测度μ:Measure(V n)，明确[SigmaFinite μ]；正逐坐标质量、β>0及配置权重关于μ可积为前提。左边实际使用μ.prod(volume)作用在(q,p)顺序的Phase n上，右边是关于同一μ的配置积分乘正确的高斯质量因子。[EXTRA]说明原Q由μ=volume.restrict Q表示；这既保留一般可测配置域，也未把Q改成torus或把质量改成1。任意σ有限μ的推广与原公式相容，不额外声称其归一化常数为正。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.partitionDomain` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:289`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.3-FiniteDomainPrinted

印刷p.218 / PDFp.239；§6.1.3。

### 1. 原文陈述

> If $`U`$ is smooth and the domain $`Q`$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem finiteDomainPrinted : ∀ {n : ℕ} (Q : Set (MolecularDynamics.Chapter06Review.V n))
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  MeasurableSet Q → (volume : Measure (MolecularDynamics.Chapter06Review.V n)) Q < ⊤ →
  ContDiffOn ℝ ∞ U Q → 0 < β → IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q := by
  sorry

/-- 修正版，对应原文 MD-6.1.3-FiniteDomainPrinted；改动：将有限体积域内光滑改为紧域上连续，使用紧性保证权重可积。 -/
theorem finiteDomainPrinted_corrected {n : ℕ} (Q : Set (Fin n → ℝ))
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hQ : IsCompact Q) (hU : ContinuousOn U Q) :
    IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q := by
  exact (Real.continuous_exp.comp_continuousOn (hU.const_mul (-β))).integrableOn_compact hQ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。
- [EXTRA] 复审范围：修正版只给紧域构型权重可积；正体积、正配分函数、动量积分与归一化没有随之成立。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。finiteDomainPrinted：将finite解释成可测有限体积，并只要求域内C∞、β>0，不足以保证exp(-βU)可积，原书含糊处需人工确认。finiteDomainPrinted\_corrected：任意维n、紧Q、域上连续U、任意实β，指数权重在Q可积，正确且加强条件已明确。两版都只陈述构型积分的可积性，未陈述动量积分、正配分函数或密度归一化；紧集还可能体积为零。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
修正版只给紧域构型权重可积；正体积、正配分函数、动量积分与归一化没有随之成立。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteDomainPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |
| `MD.Ch06.finiteDomainPrinted_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:303`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

