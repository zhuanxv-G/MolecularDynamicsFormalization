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

