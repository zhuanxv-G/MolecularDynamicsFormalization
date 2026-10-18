# 第6章逐条形式化审阅材料

正文249条；最新网站直接PASS 203条。本轮60条：25 PASS / 8 FAIL / 27 NEEDS_HUMAN；8条按意见处理且本地核验通过，未再送网站。32项合并疑误/范围问题及1项解释记录。
统计见[导师摘要](CH06_SUMMARY_FOR_MENTOR.zh-CN.md)；原书问题见[勘误清单](CH06_ERRATA.zh-CN.md)。网站评价与证明完成情况分别统计。

## MD-6.1.1-Microcanonical

印刷p.214 / PDFp.235；§6.1.1。

### 1. 原文陈述

> The density function may then be represented by a Dirac delta function as follows:
> \[\rho_{\rm mc}=Z^{-1}\delta[H-E],\qquad Z=\int_D\delta[H-E]d\omega.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对象为任意自然数维数n、实值Hamiltonian H:E n→ℝ及实能量energy。microcanonical直接返回microMeasure；展开为能量面上的1/‖gradient H‖加权面积测度再除以其总质量，符合Dirac记号的测度解释。它是总定义，不宣称任意H、energy均给概率测度；正则性及总质量正且有限的物理适用范围已在context_notation明确，不能把此定义计为coarea识别或归一化定理。原D由所选环境/相空间承载，此签名没有独立的任意区域D参数。
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
> \[S:=k_B\ln Z.\tag{6.1}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> We denote by $Z(E_A,E_B)$ the total number of states the system can occupy with systems A and B having energies $E_A$ and $E_B$, respectively. We make use of our assumption that the two systems do not exchange particles so that the total number of states the combined system can be found in depends solely on the energies of the two independent systems, i.e.,
> \[Z(E_A,E_B)=Z_A(E_A)\times Z_B(E_B).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Taking logarithms and replacing the value for $E_B$ by $E-E_A$, we have
> \[\ln Z(E_A,E-E_A)=\ln Z_A(E_A)+\ln Z_B(E-E_A).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> This value of $E_A$ occurs where
> \[\frac{d}{dE_A}\ln Z(E_A,E-E_A)=0,\]
> or equivalently where
> \[\frac{d}{dE_A}S_A=\frac{d}{dE_B}S_B,\]
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> The temperature of a system $T$, is defined as
> \[\frac1T:=\frac{\partial S}{\partial E}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (MolecularDynamics.Chapter06Review.inverseTemperature S E)⁻¹
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。S:ℝ→ℝ及实能量E的temperature定义为inverseTemperature S E的倒数；展开项目定义即(deriv S E)⁻¹，方向正确。固定其他物理参数后单变量导数承载原偏导。Lean逆元与deriv均为总定义，此条不宣称S必可微或T必正；context_notation已限定实际导数及非零情形下的温度解释。
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
> \[\frac{d}{dE_A}\ln Z_A(E_A)=\frac{d}{dE_B}\ln Z_B(E_B)=\frac1{k_BT}=: \beta.\tag{6.2}\]
> We shall refer to the quantity $\beta$ as the system's inverse or reciprocal temperature.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。inverseThermal量化kB,T∈ℝ，值为(kB*T)⁻¹，恰好形式化β的定义。该定义自身没有A、B两个系统，不能被计作式(6.2)整条平衡导数关系的证明；输入context_notation已明确将导数关系分给EntropyEquilibrium及LogTemperature，并注明物理解释要求kB,T>0，因此定义范围匹配。
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

> Since $Z_B(E-s)=\exp(S_B(E-s)/k_B)$, and $s\ll E$, we (naively) apply the mean value theorem to $S_B$ to obtain
> \[S_B(E-s)=S_B(E)-S'_B(\xi)s,\]
> and from $S'_B(\xi)=1/T$, we obtain
> \[Z_B(E-s)\propto\exp(-\beta s).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]熵C²、正热浴能量及kB；β以原页固定温度关系表示，不假设所需中间点导数恒定。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。
- [EXTRA] 复审范围：修正版只是全局恒定熵导数（仿射熵）特例，未给一般热浴近似误差界。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。bathBoltzmannPrinted：中值部分在C²前提下正确；第二合取把只在energy处给定的导数扩张成全区间精确指数比，不是中值定理的推论。作为Printed，保留原书启发式而标NEEDS_HUMAN，不因其错误直接判签名FAIL。bathBoltzmannPrinted_counterexample：exp(-1)≠exp(-2)正确，代入S(e)=e²、energy=kB=s=1、β=2即见原断言失败。bathBoltzmannPrinted_corrected：所有e处deriv S e=kB*β且S可微、kB>0，足以推出任意实数s的精确比值；是正确的全局仿射熵限定版，但并非一般热浴近似的误差估计。
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

> The temperature of a system $T$, is defined as $1/T:=\partial S/\partial E$, giving, when the system is in thermal equilibrium,
> \[\frac{d}{dE_A}\ln Z_A(E_A)=\frac{d}{dE_B}\ln Z_B(E_B)=\frac1{k_BT}=: \beta.\tag{6.2}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> we (naively) apply the mean value theorem to $S_B$ to obtain
> \[S_B(E-s)=S_B(E)-S'_B(\xi)s.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Since $Z_B(E-s)=\exp(S_B(E-s)/k_B)$, and $s\ll E$, we (naively) apply the mean value theorem to $S_B$ to obtain
> \[S_B(E-s)=S_B(E)-S'_B(\xi)s,\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]对原页热浴近似给出可核验的局部C²一阶展开及C·s²余项；这是额外严格表述，完整字面Boltzmann关系仍为NEEDS_HUMAN。

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

> and from $S'_B(\xi)=1/T$, we obtain
> \[Z_B(E-s)\propto\exp(-\beta s),\]
> where $\beta=(k_BT)^{-1}$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> On the other hand the probability for the active system to have energy $\leq\alpha$ is the same as the probability of the bath having energy $\geq E-\alpha$, this must be
> \[P(\alpha)=\Pr\{E_B\geq E-\alpha\}\propto\int_0^\alpha Z_B(E-s)ds.\]
> [The intervening bath-entropy argument is quoted separately in MD-6.1.2-BathTaylor.]
> Thus we have $P(\alpha)\propto\int_0^\alpha\exp(-\beta s)ds$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。canonicalCDFPrinted：任意连续、全实轴严格正ZA,ZB，0<α<energy，等同含ZA与不含ZA的两个归一化积分。它精确呈现原书忽略简并度的主张，其数学疑误保留为NEEDS_HUMAN。canonicalCDFPrinted_corrected：保留分子分母ZA的定义是正确候选CDF表达式；本定义对任意函数和实α总化，不保证非负、归一、单调或分母非零。作为公式定义PASS；只有在正可积权重及0≤α≤energy时才有概率解释；定义没有证明热浴熵近似后的指数形式。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalCDFPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |
| `MD.Ch06.canonicalCDFPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:220`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.2-CanonicalEnergyDensity

印刷p.216 / PDFp.237；§6.1.2。

### 1. 原文陈述

> The volume (or number, in the case of discrete systems) of states available at energy $\alpha$ is $Z_A(\alpha)$. Thus the energy density of the canonical ensemble at energy level $\alpha$ is proportional to $Z_A(\alpha)\exp(-\beta\alpha)$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[S=-k_B\int\rho\ln\rho\,d\omega,\]
> subject to the constraints $\int\rho(z)d\omega=1$, $\int H(z)\rho(z)d\omega=\bar E$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对象为任意可测空间D、测度ν、实kB及实函数ρ；返回−kB乘ρ logρ的Bochner积分，符号与权重正确。此条仅形式化熵泛函定义；归一化及平均能量约束由第16条另存，驻点分析由第17、18条另存，context_notation已明确拆分。ρ≥0、可积性及0 log0的总定义不在此签名中被证明，不应把它计成任意ρ的合法概率熵定理。
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
> \[V=S/k_B-\lambda\left[\int\rho(z)d\omega-1\right]-\beta\left[\int H(z)\rho(z)d\omega-\bar E\right]\]
> with respect to the choice of density $\rho$ and coefficients $\lambda$ and $\beta$. The resulting equations for the maximizing density are obtained by variational differentiation (see Sect. 2.2.1):
> \[\frac{\delta V}{\delta\rho}=0,\quad\int\rho(z)d\omega=1,\quad\int H(z)\rho(z)d\omega=\bar E.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量化任意可测D、测度ν、实值H,ρ及四个实参数。返回的第一分量是S/kB−λ(∫ρ−1)−β(∫Hρ−meanEnergy)，常数项没有丢失；第二分量是两个约束的合取命题，不能把构造这个Prop误当成证明约束已成立。签名没有驻点或最大化断言，输入context_notation已把实际一阶变分和驻点结论分给第17、18条。kB≠0下S/kB与物理表达式一致；kB=0只保留Lean总定义，不冒充约消证明。
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
> \[-(1+\ln\rho)-\lambda-\beta H=0\]
> yielding $\rho=e^{-1-\lambda}e^{-\beta H}$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[-(1+\ln\rho)-\lambda-\beta H=0\]
> yielding
> \[\rho=e^{-1-\lambda}e^{-\beta H}.\]
> The normalization condition determines the parameter $\lambda$, whereas $\beta$ and hence the temperature arises from the choice of average energy, i.e. from solving the equation
> \[\frac{\int H(z)e^{-\beta H(z)}d\omega}{\int e^{-\beta H(z)}d\omega}=\bar E.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\rho_\beta=Z_{\rm can}^{-1}e^{-\beta H(q,p)}.\tag{6.3}\]
> where the parameter $\beta=1/(k_BT)$. The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.
> [\ldots]
> \[Z_{\rm can}=\int e^{-\beta H(q,p)}d\omega.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。可测空间D、测度ν、实H及β与点x全部显式；canonicalDensity恰为exp(−βH x)除以同一权重的实际积分，分母不是独立任意常数。测度ν承载所选相空间域。定义对应原归一化表达式；没有宣称任意ν,H,β均有正有限partition或积分为1，context_notation已限定适用条件。输入中的β=1/(kB T)是参数解释，不是此函数隐含证明的平衡定理。
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

> If we have a standard molecular Hamiltonian $H(q,p)=p^TM^{-1}p/2+U(q)$ with $N_c=Nd$ degrees of freedom

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。n个实坐标的m∈V n、势能U:V n→ℝ及相点x∈Phase n全部显式；Phase n=V n×V n，x.1为q、x.2为p。动能是Σ_i p_i²/(2m_i)，等于对角质量矩阵的pᵀM⁻¹p/2，保留每个m_i，未偷换为单位质量。定义没有限制m_i，但context_notation明确物理模型为正对角质量，后续积分定理也逐坐标要求m_i>0；此处是总定义而非任意质量正定的断言。
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
> \[Z_{\rm can}=\int_D e^{-\beta H(q,p)}d\omega
> =\int_{\mathbb R^{N_c}}e^{-\beta p^TM^{-1}p/2}d\omega_p\times\int_Q e^{-\beta U(q)}d\omega_q.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]此条取Q=全配置实空间；正β、任意正对角质量和配置权重可积；一般Q用下一条独立保存。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对任意n、正对角质量m、β>0及配置权重可积的U，结论给整个Phase n上的指数积分=配置积分×Π_i sqrt(2πm_i/β)。[EXTRA]已明确Q取全部配置实空间，n为任意自然数，不能把它当作一般区域Q结论。D19的质量Hamiltonian与第20条相同；高斯因子与每个质量、β的依赖正确，乘积次序交换无影响。可积性保证实际实值积分与Fubini分离合法，n=0时空乘积为1亦相容。
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

> where $Q$ is the accessible position domain, $d\omega_p=dp_1dp_2\cdots dp_{N_c}$ and $d\omega_q=dq_1dq_2\cdots dq_{N_c}$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。
- [EXTRA] 复审范围：修正版只给紧域构型权重可积；正体积、正配分函数、动量积分与归一化没有随之成立。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。finiteDomainPrinted：将finite解释成可测有限体积，并只要求域内C∞、β>0，不足以保证exp(-βU)可积，原书含糊处需人工确认。finiteDomainPrinted_corrected：任意维n、紧Q、域上连续U、任意实β，指数权重在Q可积，正确且加强条件已明确。两版都只陈述构型积分的可积性，未陈述动量积分、正配分函数或密度归一化；紧集还可能体积为零。
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
> \[Z_{\rm can}=\int_{\mathbb R^{N_c}}e^{-\beta p^TM^{-1}p/2}d\omega_p\times\int_Q e^{-\beta U(q)}d\omega_q.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]仅独立特例：单位质量、单位周期torus、实际Haar配置测度与光滑周期U；完整一般质量/Q的两条义务仍保留，不将特例计为完整原结论已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U在Fin N→ℝ上C∞且对任意整数向量平移周期，β>0；左边由D20在单位配置torus Haar测度×全动量Lebesgue测度上积分D23 Gibbs权重。D21–D26把Hamiltonian固定为Σp_i²/2+U；D7的配置partition在Icc 0 1上积分exp(−βU)。周期性保证任意代表元选取不影响权重，torus积分与单位基本域积分一致，边界测度为0。右边sqrt(2πβ⁻¹)^N是单位质量高斯因子，等式正确。该[EXTRA]独立特例不覆盖第21、22条的一般质量/配置域。
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

> Typically one assumes that (i) $U$ is smooth except on a low-dimensional set of singular points, (ii) $U$ is bounded below (which is normally the case if a potential such as Lennard-Jones, steeply repulsive at short range, is incorporated between all pairs of atoms), and (iii) $U$ grows sufficiently rapidly as $q\to\infty$, in the case of an infinite domain.
> [\ldots]
> Typical assumptions for potentials on the unbounded domain are that (i) $U$ is bounded below, and (ii) $U$ grows sufficiently rapidly as $q\to\infty$. This ensures that
> \[\int_\Omega\exp(-\beta U(q))d\omega_q<\infty.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For example a collection of atoms on the infinite domain interacting in Lennard-Jones potentials does not satisfy the third condition, and it does not have a well defined canonical partition function. We can understand this by considering what happens over time in such a system. For simplicity, just take the case of a one degree-of-freedom system with $H=p^2/2+q^{-12}-q^{-6}$, $q>0$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> In order to use a one degree-of-freedom model on an infinite domain in the canonical setting, we would need to incorporate a restraining potential, slightly modifying for example the Lennard-Jones potential to $U(q)=q^{-12}-q^{-6}+\epsilon q^2$ (Fig. 6.2).

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]独立单位质量/单位torus、光滑周期U特例；配置Haar×动量Lebesgue采用正式flatPhaseMeasure的实际定义，避免隐式不同测度。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际声明是已标[EXTRA]的正确特例：U全轴C∞且单位周期，β>0，D23的真实周期Gibbs权重关于flatPhaseMeasure n可积。flatPhaseMeasure明确就是单位配置torus上的Haar体积×实动量Lebesgue体积，与权重的定义域一致；周期U在紧torus上有界，配置权重有界，β>0的动量高斯可积，故结论正确。原书一般有限域句子的疑误不使此严格特例的签名FAIL；json_review保留NEEDS_HUMAN以区分原文层面的歧义与本条数学结论PASS。
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

> In order for the density in (6.3) to be normalizable, it is necessary that the quantity $Z_{\rm can}$ ... be finite, i.e., that the integral converge.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正式库现成真实周期、单位质量、正β特例；正finite partition由已证可积性和严格正权重推出，未假设所需归一化结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U在Fin N→ℝ上光滑、单位周期且β>0，结论是实际实值周期canonical partition严格为正。D20中的积分域/测度与第28条一致，D23权重处处严格正；结合该情形的可积性与非零乘积体积，正性正确，N=0时也不例外。这里是[EXTRA]的真实周期单位质量特例，既未把正性当前提，也不宣称原书的“一般可归一化必需有限”本身等价于本签名；实值积分的有限性须由可积性支撑，不能只因结果类型是ℝ就略过第28条。reusable_proofs仅为复用线索，本轮未检查其未提供证明。
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
> \[|\phi(q,p)|=O(\|p\|^\alpha),\qquad p\to\infty,\]
> for some positive constant $\alpha$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Under assumptions on the potential energy as discussed above, and with $\phi$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $\rho_\beta$, namely
> \[\operatorname{Av}_\beta(\phi)=Z_{\rm can}^{-1}\int_D\phi(q,p)\rho_\beta(q,p)d\omega.\tag{6.4}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。Printed定义确实在D1已归一密度之外又乘D2的Z倒数；全实相空间、H、β、f的类型一致。作为原书字面定义忠实，不能因其非标准平均而判签名FAIL；原书与(6.3)及p.221用法冲突，须人工处理。修正版已在条目5给出，需分别看待。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalAveragePrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:374`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.4-CanonicalAverage

印刷p.220–221 / PDFp.241–242；§6.1.4。

### 1. 原文陈述

> We will denote the average with respect to the canonical probability density by $\operatorname{Av}_\beta$. Using (6.4), we can compute the average of the function $p^2$ as
> \[\operatorname{Av}_\beta(p^2)=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}p^2\rho_\beta dqdp.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA][ERRATUM?]按p.221的实际用法与概率平均标准定义去掉式(6.4)对已归一ρ的第二次Z⁻¹；原字面版仍保留NEEDS_HUMAN。

### 6. 审计结论（含网站结论）

网站原返回：PASS。canonicalAverage与canonicalAveragePrinted_corrected均为D2真实partition倒数乘未归一权重积分，只含一个归一化因子。两者对同一全实相空间及任意H、β、f定义；无可积性前提是总定义的延拓，不表示任意输入都已是概率平均。修正与p.221一致，合理且定义正确。
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

> The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\operatorname{Av}_\beta(p^2)=m\beta^{-1},\]
> which means that $T=\operatorname{Av}_\beta\left(\frac{p^2}{mk_B}\right)$.
> If we consider a $N_d=N_c$ degree of freedom system with kinetic energy $K=\sum_{i=1}^{N_c} p_i^2/(2m_i)$ and potential energy $U(q_1,q_2,\ldots,q_{N_c})$, then we may decompose the unnormalized canonical distribution as
> \[\exp(-\beta[K(p)+U(q)])=\exp(-\beta K(p))\exp(-\beta U(q))
> =\exp(-\beta U(q))\prod_{i=1}^{N_c}\exp\left(-\beta\frac{p_i^2}{2m_i}\right).\]
> Then we again find, by the integration argument given above, that $\operatorname{Av}_\beta(m_i^{-1}k_B^{-1}p_i^2)=T$.
> \[\operatorname{Av}_\beta(2K)=N_ck_BT.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]标准归一化真实全空间密度、正β及全部正质量；可积且正配置partition；β⁻¹=kBT，完整逐坐标和总动能两项保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。V n=Fin n→ℝ，Phase n=V n×V n；D5含每坐标质量。全部质量正、β正、配置权重可积且积分正；高斯动量因子给出每个i的p_i²平均=m_i/β及总和平均=n/β，二者均保留。n=0结论仍成立；β⁻¹=kBT作为物理记号替换已标明。
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
> \[\frac{\operatorname{Av}_\beta(\|\nabla U\|^2)}{\operatorname{Av}_\beta(\Delta U)}=k_BT.\tag{6.5}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Proposition 6.1 Let $H$ be a Hamiltonian defined on the phase space $\mathbb R^{2N_c}$ and suppose $G:\mathbb R^{2N_c}\to\mathbb R^{2N_c}$ is a smooth ($C^1$) vector field with the following properties:
> \[0<|\operatorname{Av}_\beta(G\cdot\nabla H)|<\infty,\quad
> 0<\operatorname{Av}_\beta(\nabla\cdot G)<\infty,\quad |Ge^{-\beta H}|<\infty.\]
> Then
> \[k_BT=\frac{\operatorname{Av}_\beta(G\cdot\nabla H)}{\operatorname{Av}_\beta(\nabla\cdot G)}.\]

### 2. 原文证明

> The proof relies on a $2N_c$-dimensional version of integration by parts. Let $B_R$ be the $2N_c$-dimensional ball centered at the origin, of radius $R$, and let $\Gamma_R$ be its boundary, the $2N_c-1$-dimensional sphere. Then, for any smooth scalar field $g$ defined on $B_R$, we have
> \[\int_{B_R}G\cdot\nabla g\,d\omega=\int_{\Gamma_R}(Gg)\cdot\hat n\,d\Gamma-\int_{B_R}(\nabla\cdot G)g\,d\omega.\tag{6.6}\]
> where $d\omega=dq_1\ldots dp_{N_c}$ is the standard measure of Lebesgue integration in $\mathbb R^{2N_c}$, and $d\Gamma$ is the surface area element of the hypersphere, and $\hat n$ represents the unit outward normal of the sphere. Replace $g$ by $\rho_\beta=\exp(-\beta H)$, then it follows that
> \[\left|\int_{\Gamma_R}(G\rho_\beta)\cdot\hat n\,d\Gamma\right|\leq\max_{\Gamma_R}|G\rho_\beta|\sigma_R\]
> where $\sigma_R$ is the surface area of the hypersphere. Divide (6.6) by the volume $v_R$ of $B_R$. Then, for large $R$, since the ratio of surface area to volume is proportional to $R^{-1}$, we have
> \[\frac{\int_{B_R}G\cdot\nabla\rho_\beta d\omega}{v_R}\approx\frac{-\int_{B_R}(\nabla\cdot G)\rho_\beta d\omega}{v_R}.\]
> Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正kB,T、实际C¹ H,G、Gibbs及两个加权可观测量可积，分母严格正；原|Ge⁻βH|<∞解释为统一有界C≥0，不采用仅逐点有限的空洞条件。
- [EXTRA] 所交为显式加强条件的温度恒等式；原证明除以球体积后取极限只给0=0，保留原证明并登记缺口；原下标和体积元依网站原页修订，未认证原论证。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。proposition61及proposition61_corrected签名相同：在2Nc维实相空间，kB,T>0、H,G为C¹、Gibbs权重及散度/能量方向导数乘权重可积、权重乘G统一有界、归一散度平均严格正，推出kB*T为两归一平均之比。GibbsWeight=exp(-βH)、partition=积分、average=Z⁻¹乘加权积分、LieDerivative=fderiv H(G)、divergence=trace(DG)，均吻合。上述加强条件足以用截断IBP证明；两签名PASS。原书仅由边界/体积→0，不能推出未缩放积分相等，故本条整体NEEDS_HUMAN；不能把调用现有定理当作原书证明通过。
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

> The proof relies on a $2N$-dimensional version of integration by parts.
> Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Observe that, defining $G=(0,p)^T$ yields the kinetic temperature observable $k_BT=\operatorname{Av}_\beta(p^TM^{-1}p)/N_c$, whereas $G=(\nabla U(q),0)^T$ gives the configurational temperature observable (6.5).
> An even simpler configuration-dependent choice is derived from $G=(q,0)^T$, corresponding to
> \[k_BT=\frac{\operatorname{Av}_\beta(q\cdot\nabla U)}{N_c}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> If $G$ and $H$ are both periodic in $q$ and $G$ is smooth, then everything works since the outward pointing normal will be in opposite directions on each side of the simulation cell, and the boundary term will cancel.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> whereas $\beta$ and hence the temperature arises from the choice of average energy, i.e. from solving the equation
> \[\frac{\int H(z)e^{-\beta H(z)}d\omega}{\int e^{-\beta H(z)}d\omega}=\bar E.\]
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\rho_\beta=Z_{\rm can}^{-1}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right),\]
> where
> \[Z_{\rm can}^{-1}=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}\exp\left(-\beta\left[\frac{p^2}{2m}+U(q)\right]\right)dpdq.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。partitionInversePrinted把正质量、β>0且Gibbs权重可积时的积分Z写成Z⁻¹=Z，忠实记录归一因子印刷疑误，数学上一般不成立。维数n由一自由度原文推广到任意n；massHamiltonian的动能分母2m_i、Phase=位置×动量、全空间体积积分已核对。partitionInversePrinted_corrected只把积分定义为配分函数，PASS作为定义；未断言该任意参数总化积分正有限，也未证明密度归一化。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.partitionInversePrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |
| `MD.Ch06.partitionInversePrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:520`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.1.5-WeightedFluxIdentity

印刷p.222 / PDFp.243；§6.1.5。

### 1. 原文陈述

> Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> An even simpler configuration-dependent choice is derived from $G=(q,0)^T$, corresponding to
> \[k_BT=\frac{\operatorname{Av}_\beta(q\cdot\nabla U)}{N_c}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> However $G(z)=(q,0)^T$ is problematic for periodic boundary conditions.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]沿实际单位周期坐标平移时配置部分q变化，因此G=(q,0)不定义周期torus向量场；i : Fin n自动排除零维空坐标情形。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀n,i:Fin n,q；结论为q+e_i≠q。评价第i坐标即q_i+1≠q_i，准确表达virial配置部分不周期；i的存在已排除零维。没有错误地把环面上相等的商类与实空间代表相等混淆。
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

> The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\exp(-\beta[K(p)+U(q)])=\exp(-\beta K(p))\exp(-\beta U(q))
> =\exp(-\beta U(q))\prod_{i=1}^{N_c}\exp\left(-\beta\frac{p_i^2}{2m_i}\right).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> It should be apparent that constant-energy dynamics (designed to sample the microcanonical ensemble with constant energy $E$) will not sample the canonical distribution in the absence of the heat bath: such Newtonian trajectories cannot access regions of the phase space where $H(z)\neq H(z_0)$, where $z_0$ is the initial condition.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> such Newtonian trajectories cannot access regions of the phase space where $H(z)\neq H(z_0)$, where $z_0$ is the initial condition.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> In the classic model of a random walk the jump takes values $\pm1$ with equal probability.
> The increments of the random walk are the differences $\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}$, thus $(X_n)$ is a random process with independent increments.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[X_{n+1}=X_n+\delta x J_n.\]
> We initiate the random walk with $X_0=0$.
> The solution $X_n$ of the random walk may be written
> \[X_n=\delta x\sum_{k=0}^{n-1}J_k.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> A random walk is a discrete stochastic process in which the state $X_n$ at a given instant (defined by the index $n$) is related to the state $X_{n-1}$, at step $n-1$ by an offset that may be viewed as a random variable. That is, we have
> \[X_{n+1}=X_n+\delta x J_n.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有J、dx,n,sample，无概率或正步长假设；range(n+1)拆最后一项便得X_(n+1)=X_n+dxJ_n，量词、下标及结论完整。
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

> We initiate the random walk with $X_0=0$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\mathbb E X_n^2=\delta x^2\mathbb E\left(\sum_{k=0}^{n-1}J_k\right)^2.\]
> Expanding the squared sum we see that there are (i) $n$ squares $J_k^2$ plus (ii) products of the form $J_kJ_l$, $k\neq l$. Clearly the former are always one and the latter have zero expectation, thus
> \[\mathbb E X_n^2=n\delta x^2.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整真实概率、L²、独立且公平±1跳跃；同时保存零均值与原完整二阶矩，不将和的二阶矩或交叉项零作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意概率空间P、J、dx,n，在D14条件下零均值及完整二阶矩n dx²同时保留。独立性消去异指标乘积，AE的J_k²=1给对角项；L²使有限和及平方可积。因此二阶矩等于原方差，未将待证矩作为假设。
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

> Let $t_n=n\delta t$, $n=0,1,\ldots,\nu$ and define
> \[Y(t_{k+1})=Y(t_k)+\sqrt{\delta t}J_k,\qquad k=0,1,\ldots,\nu-1,\]
> where $Y(0)=0$. Effectively we are making the size of the jump $\delta x$ taken at each step of the random walk equal to $\sqrt{\delta t}$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For points between $t_k$ and $t_{k+1}$ we define the value of $Y(t)$ by linear interpolation:
> \[Y(t)=Y_k+\frac{t-t_k}{\delta t}\Delta Y_k.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。在dt>0、t≥0的原语境，n=Nat.floor(t/dt)正是网格区间编号；增量为Y_(n+1)-Y_n，系数(t-n dt)/dt正确，端点也与网格值一致。定义对其他实数的延拓未声称为原书正步长过程。A层公式因子位置须恢复原页顺序。
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

> The increments of the random walk are the differences $\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}$, thus $(X_n)$ is a random process with independent increments.
> We will use the shorthand $Y_k=Y(t_k)$ and $\Delta Y_k=Y_{k+1}-Y_k=\sqrt{\delta t}J_k$. The increments are clearly independent.

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

网站原返回：PASS。walkIncrement对任意样本类型、任意实跳过程J及实dx，定义randomWalk(n+1)-randomWalk(n)。randomWalk=dx*Σ_{k<n}J_k，故是原文ΔX_(n+1)的重新编号。没有概率测度或J独立前提，因此没有宣称独立性。statement_scope和coverage_gaps已诚实注明只覆盖一步差分，未覆盖dx*J等式、扩散缩放或独立增量；按披露的局部范围PASS。
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

> Let us observe the following facts, for $0\leq k\leq l\leq\nu$
> \[(i)\quad\mathbb E(Y_l-Y_k)=0,\qquad(ii)\quad\operatorname{Var}(Y_l-Y_k)=t_l-t_k.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Then, for $0\leq t\leq s\leq\tau$, we have
> \[\mathbb E(Y(s)-Y(t))=0.\]
> This is easy to demonstrate. However, the intuitive corresponding statement $\operatorname{Var}(Y(s)-Y(t))=(s-t)$ does not quite hold due to the reliance on interpolation.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[W(t)=\widehat{\lim}_{\delta t\to0}\sqrt{\delta t}\sum_{k=0}^{\lfloor t/\delta t\rfloor}J_k.\]
> The convergence here, signified by the symbol $\widehat{\lim}$ is in the sense of distributions (see Appendix B).

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> As we take $n$ to infinity, $\delta t$ to zero, in such a way that $n\delta t=t$, we obtain the random variable $W(t)$ such that
> \[W(t)\sim N(0,t).\]
> For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$;

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义接受任意维数n、非负时间过程B及P；D12要求联合Gaussian、零均值、同坐标min(s,t)协方差、异坐标0及AE连续。属于已在context_notation注明的多维Wiener结构别名；没有声称由单时CLT构造连续过程。标量边际/增量结论另见第3条。
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
> \[\mathbb E(W(t)-W(s))^2=|t-s|.\tag{6.7}\]
> For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$;

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$; this does not depend on whether there is additional information available regarding its value prior to $\min(t,s)$, that is to say, the Wiener process is a Markov process.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$;

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> this does not depend on whether there is additional information available regarding its value prior to $\min(t,s)$, that is to say, the Wiener process is a Markov process.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

## MD-6.2.1-CoarseMarkovPrinted

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> Let $A(x)$, $B(x)$ and $C(x)$ be three events dependent on state variable $x$, and let $t_+>t_0>t_-$ be three times, then, for a Markov process $X(t)$ we have (using the notation for conditional probability):
> \[\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem coarseMarkovPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∀ (a b c : Set ℝ) (past present future : ℝ≥0),
    MeasurableSet a → MeasurableSet b → MeasurableSet c → past < present → present < future →
    0 < P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) →
    P ((W future ⁻¹' a) ∩ ((W present ⁻¹' b) ∩ (W past ⁻¹' c))) /
      P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) =
    P ((W future ⁻¹' a) ∩ (W present ⁻¹' b)) / P (W present ⁻¹' b) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。字面版在真实PreBrownian下量化任意可测事件a,b,c、past<present<future及正条件事件概率，ENNReal比值忠实表达印刷条件概率式。但原书把完整当前状态换成任意粗事件，一般错误，须保留疑误而不因字面忠实判数学正确。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.coarseMarkovPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:807`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-StateMarkovMeaning

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> More generally, when we say that a stochastic process is Markovian, we mean that the probability of a future event conditioned on the current state of the process and the past history of the process is the same as the probability conditioned on the current state of the process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))

/-- 修正版，对应原文 MD-6.2.1-CoarseMarkovPrinted；改动：以完整当前状态生成的σ代数写条件期望Markov性质。 -/
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：原版及coarseMarkovPrinted_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原版及coarseMarkovPrinted_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。

### 6. 审计结论（含网站结论）

网站原返回：PASS。stateMarkovMeaning与coarseMarkovPrinted_corrected完全相同：概率空间、每时X可测、history严格等于0≤r≤s的全部自然历史；对s≤t及所有可测实事件a，未来事件指标关于历史与当前状态的条件期望AE相等。指标可积且两个σ代数从X的可测性均小于环境σ代数，排除了任意history和默认零条件期望的伪性质。是实值过程标准自然历史Markov定义，两版PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stateMarkovMeaning` | 定义 | — | PASS |
| `MD.Ch06.coarseMarkovPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:819`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-RiemannTags

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> Recall that the Riemann integral of a continuous function $g$ on $[0,\tau]$ is the limit of Riemann sums constructed as follows: partition the interval $[0,\tau]$ into $K$ subintervals each of width $\delta t=\tau/\nu$, choose an arbitrary $t_k$ from the $k$th subinterval, $1\leq k\leq \nu$, and evaluate the integral as a limit of the sum of products:
> \[\int_0^\tau g(t)dt=\lim_{\nu\to\infty}\sum_{k=0}^{\nu-1}g(t_k)\delta t.\]
> We know that this limit does not depend on where the $t_k$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem riemannTags : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem riemannTags_corrected : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]非负窗口和所有合法任意tags；完整标签无关性，没有缩减为仅左端点特例。
- [EXTRA] 原书文字1≤k≤ν与求和0≤k<ν冲突；本条数学修正版统一0≤k<ν，原句保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。riemannTags与riemannTags_corrected都对任意连续于[0,T]的g、T≥0及所有合法tag族陈述均匀网格Riemann和趋于区间积分。K>0和k<K只用于标签条件，K=0单项不影响atTop极限；T=0也正确。任意端点或内部tag均包含，未降成左端点特例。两个数学签名PASS，但这是统一索引后的版本，原文索引疑误应保留NEEDS_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.riemannTags` | 未证 | 时间盒止 | PASS |
| `MD.Ch06.riemannTags_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:841`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-ItoLeftSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:
> \[\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.\]
> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。W,g是实时间随机函数，任意T和K的有限和；左端点kT/K与相应W增量均正确，range K精确为0到K−1；仅定义有限和，不断言存在极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.itoLeftSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:857`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StrictItoIntegral

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:
> \[\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.\]
> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.
> where, for a sequence of random variables, $A_\nu$ and a random variable $B$, we have
> \[\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)

/-- 修正版，对应原文 MD-6.2.2-WeakItoAlias；改动：严格定义要求每个有限和及极限变量均属于L²；正式库冻结，只在Blueprint使用严格版。 -/
def weakItoAlias_corrected {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式所有有限和与极限的L²资格，防止Bochner非可积默认值0伪造均方收敛；真实取样和极限，不假设任何求值结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意P、W,g,T,Y；每个有限和及Y均MemLp 2，再要求误差平方积分趋零。D16取样相符。所附weakItoAlias_corrected逐项相同，合理修复第16条非可积默认值漏洞；作为L²均方积分定义不声称所有g可积。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictItoIntegral` | 定义 | — | PASS |
| `MD.Ch06.weakItoAlias_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:863`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-WeakItoAlias

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:
> \[\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.\]
> where the increments $W((k+1)\delta t)-W(k\delta t)$ identified here are the increments of a Wiener process whose properties are given above. (In particular they are normally distributed with mean zero and variance $\delta t$.) First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.
> Next, unlike in the case of the Riemann sums, it turns out that the result depends on where we place the points $t_k$. Using the properties of the Wiener process we may easily show that the choice $t_k=k\delta t$ (left endpoint) and the choice $t_k=(k+1/2)\delta t$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weakItoAlias {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weakItoAlias是任意测度P、过程W,g、实T和候选Y的均方左和极限关系：每个K的itoLeftSum及Y均为L²，平方误差积分趋0。D3的和确用左端点kT/K和相邻W增量。L²前提排除了不可积函数Bochner默认零的漏洞。作为左和极限关系定义PASS；P不是自动概率、W不是自动Wiener、g不是自动适应，此定义本身不授予标准Itô积分的存在性或一般等距性质，不能扩充解释。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weakItoAlias` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:878`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StratonovichSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:
> \[\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.\]
> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实时间中点((k+1/2)T/K)处取g值，而非端点g均值；W增量及0到K−1索引均正确。只定义原书中点和，不声称对任意随机g等于一般Stratonovich积分。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stratonovichSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:884`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoFiniteIdentity

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> As an example, consider the case where $g(t)=W(t)$. We suppose this to be approximated by a sum
> \[\int_0^\tau W(t)dW(t)\approx\sum_{k=0}^{\nu-1}W(k\delta t)[W((k+1)\delta t)-W(k\delta t)],\]
> \[=\frac12\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2-(W((k+1)\delta t)-W(k\delta t))^2].\]
> Breaking this into two parts, we see that the first sum telescopes to give $W(\tau)^2$ (as $W(0)=0$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoFiniteIdentity {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ sample ∂P, 2 * textbookWienerSelfItoSum W T K sample =
      W T sample ^ 2 - textbookWienerQuadraticSum W T K sample := by
  apply MolecularDynamics.textbookWienerSelfItoSum_identity <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实PreBrownian、K>0和AE W0=0；保存完整有限和望远镜恒等。

### 6. 审计结论（含网站结论）

网站原返回：PASS。K>0，PreBrownian给W0=0几乎处处；D18左和与D17平方增量和构成2S=W(T)^2−Q的AE有限恒等，完整保留望远镜结果而没有把积分极限偷当前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoFiniteIdentity` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:890`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-Proposition62

印刷p.229–230 / PDFp.250–251；§6.2.2。

### 1. 原文陈述

> Proposition 6.2 Let $\nu\delta t=\tau$ then
> \[\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,\]
> where, for a sequence of random variables, $A_\nu$ and a random variable $B$, we have
> \[\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.\]
> (This is referred to as convergence in the mean square sense.)

### 2. 原文证明

> With $\tau,\nu$ fixed, we have $\delta t=\tau/\nu$.
> Let $\Delta W_{\nu,k}=W((k+1)\delta t)-W(k\delta t)=W((k+1)\tau/\nu)-W(k\tau/\nu)$ and observe that
> \[\sum_{k=0}^{\nu-1}\Delta W_{\nu,k}^2-\tau=\sum_{k=0}^{\nu-1}[\Delta W_{\nu,k}^2-\delta t].\]
> Then
> \[I_\nu\stackrel{\rm def}=\mathbb E(\sum_{k=0}^{\nu-1}\Delta W_{\nu,k}^2-\tau)^2=\mathbb E(\sum_{k=0}^{\nu-1}[\Delta W_{\nu,k}^2-\delta t])^2.\]
> Terms of the form $Z_{\nu,k}\stackrel{\rm def}=\Delta W_{\nu,k}^2-\delta t$ are independent and have mean zero. Therefore
> \[\mathbb E(\sum_{k=0}^{\nu-1}Z_{\nu,k})^2=\mathbb E\sum_{k=0}^{\nu-1}Z_{\nu,k}^2-2\mathbb E\sum_{k\ne l}Z_{\nu,k}Z_{\nu,l}=\mathbb E\sum_{k=0}^{\nu-1}Z_{\nu,k}^2,\]
> where the last equation follows from independence of the increments ($\mathbb E Z_kZ_l=0$ if $k\ne l$).
> Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
> \[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.\]
> Thus we have
> \[I_\nu=\sum_{k=0}^{\nu-1}\mathbb E(\Delta W_{\nu,k}^2-\delta t)^2
> =\sum_{k=0}^{\nu-1}\mathbb E[\Delta W_{\nu,k}^4-2\delta t\Delta W_{\nu,k}^2+\delta t^2]
> =\sum_{k=0}^{\nu-1}[3\delta t^2-2\delta t^2+\delta t^2]=2\nu\delta t^2=2\tau^2/\nu.\]
> Thus $I_\nu\to0$ as $\nu\to0$, which is the desired result.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition62 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 修正版，对应原文 MD-6.2.2-Proposition62；改动：保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。 -/
theorem proposition62_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 【原书疑误】p.229错误交叉项展开；双变量形式，原文不证。 -/
def proposition62Printed (x y : ℝ) : ℝ := x^2+y^2-4*x*y

/-- 修正平方展开；有序交叉和的系数为+1。 -/
theorem proposition62Expansion_corrected (x y : ℝ) : (x+y)^2=x^2+y^2+2*x*y := by
  ring

theorem proposition62Printed_counterexample : ¬ ((1+1 : ℝ)^2=1^2+1^2-4*1*1) := by
  norm_num
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian law、τ≥0、全部均方极限；印刷最后K→0是笔误，更正K→∞。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。proposition62及proposition62_corrected：实际IsPreBrownianReal、T≥0，均匀网格平方增量和的均方误差atTop趋0，签名正确。WienerTime=k*T/K、WienerIncrement为相邻差、QuadraticSum为Fin K平方和，均核对。proposition62Printed定义x²+y²-4xy，忠实记录按有序k≠l理解印刷展开的两变量表达；未将错误式当定理。proposition62Expansion_corrected的普通平方展开正确；proposition62Printed_counterexample在x=y=1正确。原书一般代数展开错误虽因独立零均值而不改变期望最终结果，仍需标疑误；末极限应为ν→∞。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition62` | 已证 | — | PASS |
| `MD.Ch06.proposition62_corrected` | 已证 | — | PASS |
| `MD.Ch06.proposition62Printed` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |
| `MD.Ch06.proposition62Expansion_corrected` | 已证 | — | PASS |
| `MD.Ch06.proposition62Printed_counterexample` | 已证 | — | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:900`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-MeanSquareConvergence

印刷p.229 / PDFp.250；§6.2.2。

### 1. 原文陈述

> where, for a sequence of random variables, $A_\nu$ and a random variable $B$, we have
> \[\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式L²随机变量资格防止非可积Bochner默认值；不假设收敛结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义量化所有K的L²资格、B的L²资格及误差平方期望趋零；比印刷速记补足合法均方随机变量域，[EXTRA]已明确。并非仅形式Bochner默认0。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.meanSquareConvergence` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:925`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-WienerMidpointSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> The choice $t_k=k\delta t$ (left endpoint) and the choice $t_k=(k+1/2)\delta t$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def wienerMidpointSum {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun sample ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) sample *
    textbookWienerIncrement W T K k sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Fin K上取W((2k+1)T/(2K))乘整步增量，K>0时精确时间中点；K=0为空和。虽有未使用的P隐参，不改变数学内容。仅g=W辅助定义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerMidpointSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:931`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementMean

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
> \[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0 := by
  rw [hX.integral_eq, integral_id_gaussianReal]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]任意真实中心Gaussian完整法则推出零均值；增量law桥接先前已保存。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意HasLaw X (gaussianReal 0 v) P，v≥0，推出期望0；真实增量法则在第7条提供。此条只承载三项矩公式的第一项，其余分别由第23、24条承载。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementMean` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:937`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementSecond

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
> \[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementSecond {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 2 ∂P) = (v : ℝ) := by
  apply MolecularDynamics.textbookCenteredGaussian_secondMoment <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同一中心Gaussian完整法则推出二阶矩v，包括v=0；未把二阶矩作为前提，网格代入v=T/K与原式一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementSecond` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:944`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementFourth

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
> \[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementFourth {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 4 ∂P) = 3 * (v : ℝ) ^ 2 := by
  apply MolecularDynamics.textbookCenteredGaussian_fourthMoment <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意中心Gaussian完整法则推出四阶矩3v²，包括退化v=0；并未遗漏四次幂或误用标准差。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementFourth` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:951`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-QuadraticMeanSquareError

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Thus we have
> \[I_\nu=\mathbb E\sum_{k=0}^{\nu-1}(\Delta W_{\nu,k}^2-\tau/\nu)^2
> =\sum_{k=0}^{\nu-1}\mathbb E\left(\Delta W_{\nu,k}^4-2\frac{\tau}{\nu}\Delta W_{\nu,k}^2+\frac{\tau^2}{\nu^2}\right)
> =\sum_{k=0}^{\nu-1}\left(3(\tau/\nu)^2-2(\tau/\nu)^2+\tau^2/\nu^2\right)=2\frac{\tau^2}{\nu^2}\nu=2\frac{\tau^2}{\nu}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem quadraticMeanSquareError {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquareError <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian且K>0；精确误差，不是仅Tendsto0。

### 6. 审计结论（含网站结论）

网站原返回：PASS。T≥0，K>0，实际PreBrownian平方增量和的整体误差平方期望精确等于2T²/K；不是仅逐项矩或仅极限。D14、15、17的网格与原书一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.quadraticMeanSquareError` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:958`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoIntegral

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> The calculation implies that
> \[\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerSelfItoSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = (W T sample ^ 2 - (T : ℝ)) / 2 := by
  apply MolecularDynamics.textbookWienerSelfItoIntegral_exists <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实L²见证、全均方收敛及AE求值三项保留；有限和L²另条补足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在Y∈L²、真实D18左和整体均方趋于Y、Y几乎处处等于(W(T)²−T)/2三项齐全。任意T≥0；没有把积分求值当前提。有限和L²不在此签名显式陈述，但对PreBrownian有限Gaussian乘积成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoIntegral` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:966`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfStratonovichIntegral

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> In contrast, the Stratonovich (midpoint) integral (denoted by $\int_0^\tau\circ dW(t)$) can be calculated as
> \[\int_0^\tau W(t)\circ dW(t)=\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].\]
> Writing
> \[W(k\delta t+\delta t/2)=W(\frac{(k+1)\delta t+k\delta t}{2})=\frac12(W((k+1)\delta t)+W(k\delta t))+O(\sqrt{\delta t}),\]
> allows us to evaluate the integral as
> \[\int_0^\tau W(t)\circ dW(t)=\frac12\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2]=\frac12W(\tau)^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfStratonovichIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem selfStratonovichIntegral_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实时间中点和、L²见证、整体均方极限、AE求值；原O(√δt)单步启发不足，正式整体均方误差证明不直接丢弃逐步残项。
- [EXTRA] 仅覆盖真实时间中点和的均方结论；原单步O(√dt)推理未控制总误差，不能当成完整证明；所需Brownian桥残差估计未补建。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。selfStratonovichIntegral及_corrected在IsPreBrownianReal、T≥0下给出L²见证Y、真实时间中点和的均方收敛及Y=W(T)²/2的AE求值，数学签名PASS。MidpointSum确取2K细网格的2k+1时刻，并非端点值平均。布朗增量Gaussian四阶矩保证各和及极限的资格。原书将单步中点桥差O(sqrt(dt))直接舍掉未控制总和，不能单凭该行作完整证明；两相同定理签名没有解决原书论证缺口。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfStratonovichIntegral` | 已证 | — | PASS |
| `MD.Ch06.selfStratonovichIntegral_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:976`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-Proposition63

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Proposition 6.3 Let $g$ be a smooth deterministic function and $W(t)$ a Wiener process. The stochastic integral $Y(t)=\int_0^t g(s)dW(s)$ is, for all times $t\geq0$, a normally distributed random variable such that
> \[\mathbb E(Y(t))=0;\quad\mathbb E(Y^2(t))=\sigma^2(t)=\int_0^t g(s)^2ds.\]

### 2. 原文证明

> See Exercise 2.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition63 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerDeterministicSum W g T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ sample, Y sample ∂P) = 0 ∧ (∫ sample, Y sample ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  apply MolecularDynamics.textbookWienerDeterministicIto_proposition63 <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian与C¹ g已足；完整构造L²见证、均方极限、Gaussian law、零均值及二阶矩，不仅保存矩。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意T≥0、PreBrownian及C¹实确定函数g；存在Y∈L²，实际左和均方收敛；Gaussian完整法则的方差是∫g²的toNNReal（非负故不截断值）；均值0及二阶矩等于∫g²齐全。C¹比原smooth弱且足够。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition63` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:993`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-QuadraticSumExpectation

印刷p.229 / PDFp.250；§6.2.2。

### 1. 原文陈述

> On the other hand, from (6.7), we have
> \[\lim_{\nu\to\infty}\mathbb E\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem quadraticSumExpectation {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, textbookWienerQuadraticSum W T K sample ∂P) = (T : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_integral <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际上每个K>0有限和期望已经恰等于τ；均方极限在Prop6.2保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。K>0时平方增量有限和期望已经等于T，较原文极限式强并直接蕴含它；[EXTRA]准确注明。非负窗口、真实PreBrownian及完整和均保留。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.quadraticSumExpectation` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1004`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoLimitL2

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoLimitL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun sample ↦ (W T sample ^ 2 - (T : ℝ)) / 2) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoLimit_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。签名只证明候选极限(W(T)²−T)/2的MemLp 2 P，数学正确。extra_assumptions声称“有限和/候选极限”两者L²，但此签名没有有限和L²结论，须缩减标注。引文实际在印刷228页，并不在所配附件第39页（印刷230）。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoLimitL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1011`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoSumsL2

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> The calculation implies that
> \[\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoSum_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Ω任意可测空间，P任意测度但hW给出PreBrownian资格；T非负、K正。结论仅左点有限乘积和属于L²，没有候选极限或收敛结论。有限联合Gaussian的四阶矩足够，签名正确；[EXTRA]中的“候选极限”超出本声明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoSumsL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1018`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-MidpointSumsL2

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> In contrast, the Stratonovich (midpoint) integral (denoted by $\int_0^\tau\circ dW(t)$) can be calculated as
> \[\int_0^\tau W(t)\circ dW(t)=\mathrm{l.i.m.}_{
> u\to\infty}\sum_{k=0}^{
> u-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem midpointSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerMidpointSum_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同第1条的空间/测度资格；T≥0、K>0；依D1、D2及所列定义，采样时间为(2k+1)T/(2K)，乘整段增量。仅有限和MemLp 2正确；未证明候选极限资格或收敛。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.midpointSumsL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1025`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicIntegralProcess

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Also it is natural to view the stochastic integral as the solution of the stochastic differential equation (SDE) with zero initial condition:
> \[dY(t)=g(t)dW(t);\quad Y(0)=0.\tag{6.8}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部非负时间真实严格L²积分关系；Y0=0从零时间L²极限导出，不能把单时Gaussian独立采样当同一过程。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对同一W,Y以及确定g，量化全部T≥0，D5要求每个有限左点和及Y T的L²资格和均方收敛。T=0的和恒零，所以Y 0=0几乎处处。作为积分关系定义正确；未独立断言W是Wiener、过程路径连续或同时逐样本等式，使用时须另给W资格。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicIntegralProcess` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1032`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicStrobePrinted

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Finally, we observe that by calculating $\sigma^2(t_n)$ and generating random increments $R_n\sim N(0,\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t)$, effectively an exact stroboscopic representation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem deterministicStrobePrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  ∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 ((Real.sqrt (∫ s in (0 : ℝ)..times k, g s^2))^2).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Printed保留原书累计尺度N(0,σ(t_n))；将第二参数解释为标准差并平方传入gaussianReal是额外约定，需确认。本条未摘录所称相邻区间方差与整族独立性的修正版，不能认证该修正版。
- [EXTRA] 复审范围：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
- 覆盖缺口：本条未提供[EXTRA]声称的独立修正版完整声明，无法审校其相邻区间方差及整族独立性。
- 覆盖缺口：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。deterministicIntegralProcess为每个T≥0的严格均方积分资格，已核对。deterministicStrobePrinted把第k到k+1观测的增量分布方差写成0到times k的累计∫g²（对sqrt再平方），保留了原书增量/边际混淆。N(0,σ)按标准差理解是额外约定；此前书中W(t)∼N(0,t)使用方差式习惯，更需人工确认。[EXTRA]与statement_scope声称独立修正版包含相邻区间方差和整族独立性，但本条全部摘录没有任何相应_corrected声明；不能认证未提供的修正版，coverage_gaps=[]不实。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicStrobePrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1039`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicStrobeCorrected

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Finally, we observe that by calculating $\sigma^2(t_n)$ and generating random increments $R_n\sim N(0,\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t)$, effectively an exact stroboscopic representation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem deterministicStrobeCorrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry

/-- 修正版，对应原文 MD-6.2.2-DeterministicStrobePrinted；改动：采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。 -/
theorem deterministicStrobePrinted_corrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]相邻时间积分g²为完整增量方差，并保存整个增量族独立性；不是仅单时law；强L²模型。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PreBrownian、C¹确定g、全部时间严格积分关系、非负单调times足够；各相邻增量的variance为∫[times k,times(k+1)]g²，并断言整个族iIndepFun。允许相等时刻，退化零增量正确。修正数学合理；若称完整stroboscopic表示，应从实际Y(times 0)初始化，或另设times 0=0。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicStrobeCorrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.deterministicStrobePrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1049`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StochasticDifferentialIntegral

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Importantly, with appropriate regularity we have the familiar relation from calculus:
> \[\int_0^t dY(s)=Y(t)-Y(0).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。P,Y及integralOfDifferential均任意，对全部T≥0断言两随机变量几乎处处相等。按context_notation，这是积分符号的语义定义；没有循环地声称已构造一般积分或证明链式法则。无需样本普通导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stochasticDifferentialIntegral` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1069`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalk

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> We introduce a pair of smooth functions $a(x,t)$ and $b(x,t)$, where $a$ represents a drift tendency and $b$ the average magnitude of the random jump. In the interval $[n\delta t,(n+1)\delta t]$, a step $\delta X_n=X_{n+1}-X_n$ of the random walk will be given by
> \[\delta X_n=a(X_n,t_n)h+b(X_n,t_n)J_n\delta x.\tag{6.9}\]
> where the random increment $J_n$ was introduced in Sect. 6.2.1.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]按正文h=δt及δx=√δt解释真实递归与x0初值；印刷h/δt记号不一致已保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。递归以x0起始；第n步在n*dt取a,b，漂移a*dt，噪声b*sqrt(dt)*J_n，次序和乘法正确。MD包装调用Chapter06Review的旧步值，按D10/D11展开逐步一致。作为确定性递归定义允许任意dt,a,b,J；随机游走解释另需dt>0和Rademacher资格。[EXTRA]将h解释为δt需标为解释而非书中显式等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1075`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalkSum

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Choose a positive $t$ and sum (6.9) from $n=0$ to $\nu-1$, where $\nu=\lfloor t/\delta t\rfloor$, obtaining
> \[X_\nu-X_0=\sum_{n=0}^{\nu-1}\delta X_n=\sum_{n=0}^{\nu-1}a(X_n,t_n)\delta t+\sum_{n=0}^{\nu-1}b(X_n,t_n)J_n\delta x.\tag{6.10}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem biasedWalkSum : ∀ {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) (K : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 K sample-x0 =
    (∑ k ∈ Finset.range K, a (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*dt) +
    ∑ k ∈ Finset.range K, b (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*Real.sqrt dt*J k sample := by
  intro Ω a b J dt x0 K sample
  induction K with
  | zero => simp [MolecularDynamics.Chapter06Review.biasedWalk]
  | succ K ih =>
    simp only [MolecularDynamics.Chapter06Review.biasedWalk, Finset.sum_range_succ]
    linarith [ih]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对任意K∈ℕ、任意sample作递归望远镜求和，K=0也成立。K泛化原ν，不丢失原结论；dt和系数无正性/随机性限制也不影响此代数恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalkSum` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1082`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-ScalarSDE

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Take the diffusion limit $\delta t\to0$, $\delta x^2/\delta t\to1$ with $\nu\delta t=t$ fixed, then we obtain, under the Itô convention,
> \[X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).\tag{6.11}\]
> \[dX=a(X,t)dt+b(X,t)dW.\tag{6.14}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实连续路径、实际可积漂移及全部有限和L²的Ito极限；是方程意义，不计随机游走扩散极限已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D19保留连续路径和确定初值的共同AE集合；每个T≥0漂移路径区间可积，并以完整残差作严格Ito积分。a,b仍状态和时间依赖。作为方程关系定义可接受；[EXTRA]正确说明未由此证明游走极限，W及适应性资格应由使用环境另给。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictScalarSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1096`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-VectorSDE

印刷p.232–233 / PDFp.253–254；§6.3。

### 1. 原文陈述

> We mention in passing the extension to systems of SDEs. Let $a(z,t)$ and $b^{(i)}(z,t)$, $i=1,2,\ldots,r$ be a set of $r+1$ vector fields in $\mathbb R^m$, and let $W_1,W_2,\ldots,W_r$ be a collection of $r$ independent Wiener processes, then we may write a system of SDEs in $\mathbb R^m$ in the form
> \[dZ=a(Z,t)dt+\sum_{i=1}^r b^{(i)}(Z,t)dW_i.\tag{6.15}\]
> alternatively, if $B$ is the matrix with columns $b^{(1)},b^{(2)},\ldots,b^{(r)}$, and $W$ represents the $r$-component vector of Wiener processes, then
> \[dZ=a(Z,t)dt+B(Z,t)dW.\tag{6.16}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictVectorSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → ℝ → (Fin n → ℝ))
    (B : (Fin n → ℝ) → ℝ → Matrix (Fin n) (Fin r) ℝ) (x0 : Fin n → ℝ) : Prop :=
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s i) volume 0 T) ∧
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ B (X s sample) s i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, X T sample i-x0 i-(∫ s in 0..T, a (X s sample) s i)=∑ j, integrals j sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。
- [EXTRA] 复审范围：strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。
- 覆盖缺口：strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。strictVectorSDE对任意n,r、样本空间、实时间W和X、时变向量a与n×r矩阵B、确定初态x0，要求真实联合Gaussian向量Wiener、AE连续初态、逐坐标逐T漂移可积与各列严格左和积分，增量等于列积分和。D9的Gaussian、零均值、全部跨时协方差和AE连续确可给坐标过程独立，D10、D11已核对，未仅以同一时刻独立代替。但定义不要求X联合可测或相对共同W历史适应，不能未经限定当作标准适应Itô解的完整定义；第28条另外加这些资格印证区别。作为积分方程关系签名正确，作为完整SDE资格仍需人工确认范围。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictVectorSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1105`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-ScalarItoFormula

印刷p.233 / PDFp.254；§6.3.1。

### 1. 原文陈述

> Let $\phi(\cdot)$ be any continuously twice differentiable function and let $X_n\in\mathbb R$ represent the state of a biased random walk as considered in Sect. 6.3, i.e., with state $X_{n+1}=X_n+a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x$.
> \[d\phi(X)=\phi'(X)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi''(X)b(X,t)^2dt.\tag{6.17}\]

### 2. 原文证明

> Let $\phi_n=\phi(X_n)$, then Taylor's theorem gives
> \[\delta\phi\stackrel{\rm def}=\phi_{n+1}-\phi_n=\phi'(X_n)\delta X_n+\tfrac12\phi''(X_n)\delta X_n^2+o(\delta X_n^2)
> =\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)
> +\tfrac12\phi''(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)^2+o(\delta X_n^2).\]
> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\delta x^2\sim\delta t$, thus we have
> \[\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).\]
> Passing to the limit, this leads to the SDE.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem scalarItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与_corrected同步，漏dt原文形式单列保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与_corrected同步，漏dt原文形式单列保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。scalarItoFormula：P上的preBrownian、strictScalarSDE（AE连续、确定初态、逐终点漂移可积和严格均方左和关系）、φ为C²、a,b在状态时间上C¹，再加φ′(X)b适应平方可积、X联合可测及自然历史适应、gridItoQualification25。后者含P概率、联合可测和适应、每时L²、每个左和L²以及局部均方Hölder控制，并未假设所求结论。结论为每T≥0下φ(X_T)-φ(x0)-∫(φ′a+φ″b²/2)等于φ′b的严格均方积分，系数、初项、时变量和量词正确。限定签名PASS，不因sorry判FAIL；原文C²余项推成O(dt^(3/2))及直接过极限缺口保留NEEDS_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarItoFormula` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1120`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-DiffusiveTaylorPrinted

印刷p.233 / PDFp.254；§6.3.1。

### 1. 原文陈述

> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\delta x^2\sim\delta t$, thus we have
> \[\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem diffusiveTaylorPrinted : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 2 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-DiffusiveTaylorPrinted；改动：C²加强为C³，使三阶Taylor余项与扩散缩放匹配。 -/
theorem diffusiveTaylorPrinted_corrected : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 3 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。diffusiveTaylorPrinted：任意C² φ、任意实x,a,b，沿dt→0+对增量a*dt+b*sqrt(dt)宣称三阶扩散余项BigO，忠实记录原书J=+1特例但断言过强。diffusiveTaylorPrinted_corrected：C³提供局部三阶Taylor界，混合二阶项也为O(dt^(3/2))，对固定实x,a,b正确。右滤子和实rpow的指数3/2均正确；b可负；此式只包含J=+1分支，J=-1可用替换b覆盖，但不是显式随机极限定理。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.diffusiveTaylorPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |
| `MD.Ch06.diffusiveTaylorPrinted_corrected` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1138`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-TimeItoFormula

印刷p.234 / PDFp.255；§6.3.1。

### 1. 原文陈述

> We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $\phi(x,t)$:
> \[d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem timeItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-TimeItoFormula；改动：原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。 -/
theorem timeItoFormula_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 【原书疑误】(6.17)逐字右端形式表达，dX/dXX为形式微分占位；不宣称它是正确积分等式。 -/
def timeItoFormulaPrinted (φ : ℝ×ℝ → ℝ) (x t dX dXX : ℝ) : ℝ :=
  fderiv ℝ φ (x,t) (0,1)+fderiv ℝ φ (x,t) (1,0)*dX+
    fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (x,t) (1,0)*dXX/2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与_corrected同步，漏dt原文形式单列保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与_corrected同步，漏dt原文形式单列保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。timeItoFormula及timeItoFormula_corrected签名相同：在与标量版一致的preBrownian、严格SDE、C¹ a,b、C²联合φ、联合可测及自然适应X、被积过程适应平方可积和网格L²/Hölder资格下，给出任意T≥0完整积分公式。方向(1,0)为x偏导，(0,1)为t偏导，二次方向导数给φ_xx；漂移积分已正确包含φ_t，初值φ(x0,0)，扩散φ_x*b，系数b²/2均正确，两数学签名PASS。timeItoFormulaPrinted以dX,dXX形式占位保留漏dt的右端，是表达式定义，不是正确积分定理，其文档误标(6.17)，应为(6.18)。原书疑误与已修正主签名不能混认。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.timeItoFormula` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.timeItoFormula_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.timeItoFormulaPrinted` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1154`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalkDiffusion

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Take the diffusion limit $\delta t\to0$, $\delta x^2/\delta t\to1$ with $\nu\delta t=t$ fixed, then we obtain, under the Itô convention,
> \[X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem biasedWalkDiffusion : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (W : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 T : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J →
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ W t sample) (Ici 0)) →
  (∃ L : ℝ≥0, LipschitzWith L (Function.uncurry a) ∧ LipschitzWith L (Function.uncurry b)) → 0 < T →
  ∃ X : ℝ → Ω → ℝ, strictScalarSDE P W X a b x0 ∧
    ∃ paths : Ω → C(Icc 0 T, ℝ),
      (∀ᵐ sample ∂P, ∀ t : Icc 0 T, paths sample t=X t sample) ∧
      ∃ walks : ℕ → Ω → C(Icc 0 T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample (t : Icc 0 T),
          walks K sample t = let dt := T/K; let k := Nat.floor ((t : ℝ)/dt);
            MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample +
            ((t : ℝ)-k*dt)/dt*(MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 (k+1) sample-
              MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample)) ∧
        (∀ F : C(Icc 0 T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
          Tendsto (fun K ↦ ∫ sample, F (walks K sample) ∂P) atTop (𝓝 (∫ sample, F (paths sample) ∂P))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确全局Lipschitz技术资格及AE连续W版本；完整SDE解存在与真实偏置有限游走线性插值的路径空间弱极限，没有只以定义取代扩散极限。

### 6. 审计结论（含网站结论）

网站原返回：PASS。rademacherJumps含概率测度、独立、可测、±1、均值零。W另有PreBrownian和AE连续资格；a,b对(x,t)全局Lipschitz是明示[EXTRA]。结论含全时间严格标量SDE解、[0,T]连续路径版本、dt=T/K的线性插值及所有有界连续路径泛函积分收敛；不是仅参数或单时边际收敛。T>0且K=0不约束无碍atTop。J与W无需互相独立，因为结论只作分布极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalkDiffusion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1196`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUProcess

印刷p.234 / PDFp.255；§6.3.2。

### 1. 原文陈述

> For now we will examine the special case of a scalar equation
> \[dX=-\gamma Xdt+\sigma dW;\tag{6.19}\]
> where $\gamma>0$ and $\sigma$ are constants. We term Eq. (6.19) the Ornstein-Uhlenbeck SDE.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原显式γ>0保留在真实严格L²积分方程的资格中，不将分布式解作方程前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D21明列γ>0并把a(x,t)=−γx、b(x,t)=σ、固定x0代入D19。保留负漂移、实常σ和严格积分语义；不是用Gaussian law定义OU。W资格仍需在使用处给出。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictOUProcess` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1217`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUIntegratingFactor

印刷p.234 / PDFp.255；§6.3.2。

### 1. 原文陈述

> Multiply both sides of (6.19) by the integrating factor $\exp(\gamma t)$, and observe that
> \[d(\exp(\gamma t)X)=\exp(\gamma t)(dX+\gamma Xdt);\]
> thus (6.19) becomes
> \[d(\exp(\gamma t)X)=\sigma\exp(\gamma t)dW(t).\]
> We then integrate both sides to obtain
> \[\exp(\gamma t)X(t)=X(0)+\int_0^t\sigma\exp(\gamma s)dW(s).\]
> Multiplying by $e^{-\gamma t}$ gives
> \[X(t)=e^{-\gamma t}X(0)+\sigma e^{-\gamma t}\int_0^t\exp(\gamma s)dW(s).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouIntegratingFactor :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, strictItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian、严格OU与严格确定性Ito积分见证、γ>0和t≥0；完整求值，不以解公式作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意概率样本空间和PreBrownian W，真实OU关系、γ>0、T≥0；存在Y为exp(γs)的严格确定积分且X T几乎处处等于完整变常数解。σ=0也成立；额外重复γ>0无害。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouIntegratingFactor` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1223`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUVarianceIntegral

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> Using Proposition 6.3, we know that for a Wiener process $W(t)$, $Y(t)\stackrel{\rm def}=\int_0^t\exp(\gamma s)dW(s)$ is a Gaussian random variable with mean zero and variance
> \[\operatorname{Var}\{Y(t)\}=\int_0^t e^{2\gamma s}ds=\frac{e^{2\gamma t}-1}{2\gamma}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouVarianceIntegral : ∀ (γ T : ℝ), 0 < γ → 0 ≤ T →
  (∫ s in (0 : ℝ)..T, Real.exp (2*γ*s))=(Real.exp (2*γ*T)-1)/(2*γ) := by
  intro γ T hγ hT
  have hc : 2*γ ≠ 0 := mul_ne_zero (by norm_num) hγ.ne'
  have hd : ∀ x : ℝ, HasDerivAt (fun s : ℝ ↦ Real.exp (2*γ*s)/(2*γ))
      (Real.exp (2*γ*x)) x := by
    intro x
    simpa [hc] using
      ((Real.hasDerivAt_exp (2*γ*x)).comp x
        ((hasDerivAt_id x).const_mul (2*γ))).div_const (2*γ)
  have hi : IntervalIntegrable (fun s : ℝ ↦ Real.exp (2*γ*s)) volume 0 T :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ ↦ hd x) hi]
  simp only [mul_zero, Real.exp_zero]
  ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。
- 覆盖缺口：仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouVarianceIntegral对任意γ>0、T≥0断言确定性区间积分∫exp(2γs)=(exp(2γT)-1)/(2γ)，签名正确。明确排除γ=0以免总化除零给错误值。scope和coverage_gaps已声明不覆盖随机积分Gaussian法则、均值或方差的识别；按此范围PASS。条目中额外列出的SymplecticCoordinates、textbookJ及复合辛映射声明与本积分结论无关，不把它们当证据。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouVarianceIntegral` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1233`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OULawPrinted

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> The solution with equivalent distribution is therefore
> \[X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}(1-e^{-2\gamma t})}\widehat Y(t).\]
> where $\widehat Y(t)$ should be interpreted as random process which at every time $t$ evaluates to a normal random variable ($\widehat Y(t)\sim N(0,1)$). This is what we mean by the exact distributional solution of the Ornstein-Uhlenbeck SDE with prescribed initial value $X(0)$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouLawPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 →
  0 < γ → 0 ≤ T → HasLaw (X T)
    (gaussianReal (Real.exp (-γ*T)*x0)
      (σ^2*(1-Real.exp (-2*γ*T))/(2*γ)).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouLawPrinted：对实际preBrownian驱动与strictOUProcess（γ>0及线性漂移-γx、常扩散σ、确定初态x0的严格积分方程），任意T≥0，X_T有Gaussian法则，均值exp(-γT)x0、方差σ²(1-exp(-2γT))/(2γ)。方差非负，toNNReal不截掉任何合法量；σ为任意实数、T=0退化为初态Dirac也正确。原文只规定每时刻正态边际，签名没有错误声称各时刻独立或整路径法则，因此PASS；sorry不影响签名审校。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouLawPrinted` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1251`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OULawCorrect

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> The solution with equivalent distribution is therefore
> \[X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}(1-e^{-2\gamma t})}\widehat Y(t).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouLawCorrect :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry

/-- 修正版，对应原文 MD-6.3.2-OULawPrinted；改动：把整个(1−e^(−2γt))/(2γ)放入根号；只断言同一OU过程的单时刻法则。 -/
theorem ouLawPrinted_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]修正标准差σ√((1−e⁻²γt)/(2γ))，完整真实单时Gaussian法则；均值e⁻γtx0、方差σ²(1−e⁻²γt)/(2γ)，不预置law结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouMean和ouVariance的实际定义已给，完整均值及variance正确；PreBrownian、严格OU、γ>0及T≥0足够。σ任意实数由σ²消除符号，T=0退化为点质量正确。这一law忠实于实际PDF公式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouLawCorrect` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.ouLawPrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1261`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUGibbsLimit

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> Let $\sigma=\sqrt{2\gamma k_BT m}$; then for large $t$ the exponentials of the form $e^{-\gamma t}$ tend to zero, and we have
> \[X(t)\approx\sqrt{k_BT m}\widehat Y(t);\]
>  in which case $X(t)$ is drawn from the probability density
> \[\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For a system with $N_c$ configurational variables we may write
> \[dp_i=-\gamma p_i dt+\sqrt{2\gamma k_BT m_i}\,dW_i;\tag{6.20}\]
> where $W_1(t),W_2(t),\ldots,W_{N_c}(t)$ represent $N_c$ independent Wiener processes, or, in vectorial notation, denoting $W=[W_1,W_2,\ldots,W_{N_c}]^T$, we have
> \[dp=-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{6.21}\]

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

网站原返回：PASS。momentumOU在任意n上要求整族向量Wiener（联合Gaussian、全跨时协方差、连续路径）、逐质量正、γ>0、θ>0，其中θ表示kBT；每坐标为γ相同、σ_i=sqrt(2γθm_i)、初态p0_i的strictOUProcess。各噪声来自同一真实独立坐标Wiener，并非任意彼此相关标量过程。常系数线性方程对应对角M^(1/2)，签名PASS；不把该定义当作长期采样或不变性定理。
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

> in which case $X(t)$ is drawn from the probability density
> \[\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> We assume as in [138] that we are given a system of $k$ coupled oscillators (a “heat bath”) in contact with a distinguished particle. The Hamiltonian is
> \[H=\frac{P^2}{2}+\sum_{i=1}^k\frac{p_i^2}{2\mu_i}+U(Q)+\frac1{2k}\sum_{i=1}^k(q_i-Q)^2\]
> where $Q$ and $P$ represent the position and momentum of the distinguished particle and $\{q_i,p_i\}$ are the positions and momenta of the particles of the bath, $\mu_i$ giving the mass of the $i$th light particle.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式k>0及全部μi>0，避免零质量/零热浴大小的总化除法冒充物理模型。

### 6. 审计结论（含网站结论）

网站原返回：PASS。k>0、所有μ_i>0显式参数，Q,P实数，q,p为Fin k→ℝ，U任意实势函数。动能p_i²/(2μ_i)、势能U Q及耦合1/(2k)均正确。定义能量无需U可微。
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
> \[\dot Q=P;\tag{6.22}\quad\dot P=-U'(Q)-k^{-1}\sum_{i=1}^k(Q-q_i);\tag{6.23}\]
> where, for $i=1,2,\ldots,k$,
> \[\dot q_i=p_i/\mu_i;\tag{6.24}\quad\dot p_i=(Q-q_i)/k.\tag{6.25}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Hamiltonian全部偏导、正质量、k>0和U沿Q可微；全部四组等式，不只定义方程。

### 6. 审计结论（含网站结论）

网站原返回：PASS。在k>0、μ_i>0及U在Q可微下，实际Hamiltonian对P,Q以及各p_i,q_i的方向导数完整给出四个Hamilton向量场分量。Pi.single i 1为第i坐标方向，负号分配正确。此为全部动力场分量的求导核验，不额外宣称轨道存在性。
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

> where $\Omega_i=k^{-1/2}\mu_i^{-1/2}$ is the frequency of the $i$th oscillator.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathFrequency {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (i : Fin k) : ℝ := (Real.sqrt ((k : ℝ)*μ i))⁻¹
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]k>0和全部μi>0已编码为真实参数资格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。k>0和正μ_i确保sqrt(kμ_i)>0，其倒数与k^(−1/2)μ_i^(−1/2)等价。i:Fin k，未出现频率零或总化负质量问题。
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

> Because the system (6.24)–(6.25) is linear, we may solve it analytically for $\{q_i,p_i\}$; this yields:
> \[q_i(t)=\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i+k^{-1}\mu_i^{-1}\int_0^t\Omega_i^{-1}\sin(\Omega_i(t-s))Q(s)ds.\tag{6.26}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\int_0^t\Omega_i\sin(\Omega_i(t-s))Q(s)ds=[\cos(\Omega_i(t-s))Q(s)]_0^t-\int_0^t\cos(\Omega_i(t-s))P(s)ds
> =Q(t)-\cos(\Omega_i t)Q(0)-\int_0^t\cos(\Omega_i(t-s))P(s)ds.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]按(6.23)推导得到正k⁻¹实际合力；原页负号与+f项冲突，字面版本另列；不宣称更正已由网站裁定。
- [EXTRA]k>0和全部μi>0已编码，排除非物理逆质量/频率总化值。

### 6. 审计结论（含网站结论）

网站原返回：PASS。两份所示定义bathForce和bathForcePrinted_corrected都是正k⁻¹的同一表达式。按[EXTRA]作为明示修正版审校合理：从(6.23)−k⁻¹Σ(Q−q)=+k⁻¹Σ(q−Q)得到正初值力，再减记忆卷积。k>0、正μ齐全；不是原书负号的字面版。原书符号冲突保留待人工裁定。
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
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def bathForcePrinted {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ := -MolecularDynamics.Chapter06Review.bathForce μ q0 p0 Q0 t
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> \[\psi(t)=k^{-1}\sum_{i=1}^k\cos(\Omega_i(t)).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\dot Q=P;\tag{6.27}\quad\dot P=-U'(Q)-k^{-1}\sum_{i=1}^k(Q-q_i);\tag{6.28}\]
> \[=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> \[\dot P=-U'(Q)+f(t)-\int_0^t\psi(t-s)P(s)ds.\tag{6.29}\]
> \[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。bathReductionPrinted：k>0、μ_i>0、t≥0、Q,q为C²，dot Q=P、重粒子与热浴坐标的完整动力学均已列出。bathFrequency=1/sqrt(kμ_i)、memoryKernel=(1/k)Σcos、bathForcePrinted=-bathForce均核对。Printed的力与由dot P=-U′+(1/k)Σ(q_i-Q)导出的力差一个负号，原版忠实但需NEEDS_HUMAN。bathReductionPrinted_corrected保持相同域量词前提，用正bathForce替换，记忆项仍为负卷积，数学上正确；p0/μ_i与Ω_i^(-1)因子吻合。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.bathReductionPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:1388`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.3-MemoryKernelDeltaMeaning

印刷p.238 / PDFp.259；§6.3.3。

### 1. 原文陈述

> If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $\psi$ by a Dirac delta function scaled by a positive coefficient $\gamma$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs
> \[dQ=Pdt;\tag{6.30}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\tag{6.31}\]

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
| 所引原句 | 两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确ηk→γδ0的实际分布意义，仅定义该近似资格；不计极限或Langevin推导已证。
- [EXTRA] 旧_corrected只加正质量并非有效修复：固定1/k平均使|ψk|≤1，不可能收敛到正质量Dirac。此谓词在当前归一化下不可实现；原启发式与两版资格定义均留存，待确认时间/振幅重标度及单边边界因子；不把资格定义计成极限定理。
- [EXTRA] 复审范围：两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。
- 覆盖缺口：两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。memoryKernelDeltaMeaning定义对全部C∞紧支测试f的全实轴分布收敛到γf(0)，γ>0；_corrected再要求所有质量正。两者作为收敛资格的形式表达准确，均非存在或Langevin推导定理。但memoryKernel的1/k归一使所有k,t的绝对值≤1，因此两谓词在γ>0时都不可实现；正质量未修复。[EXTRA]已披露这一点，故保留NEEDS_HUMAN，不把不可实现资格当有效修正版。全线γδ0与0到t卷积的边界因子尚需约定，(6.30)–(6.31)本身未被定义覆盖。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
两个δ收敛资格在现有1/k归一及γ>0时均不可实现；不能将_corrected名字解释为已获有效物理极限。需重标度、单边质量和边界约定。
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

> \[dQ=Pdt;\tag{6.30}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\tag{6.31}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[dq=M^{-1}pdt;\tag{6.32}\quad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{6.33}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：n维状态为V n×V n，m每个分量正，γ、θ=kBT正，U为C∞；n维Wiener、确定初值x0、非负时间连续路径与两漂移可积性均显式保留。坐标噪声√(2γθ m_i)(W_i(t)−W_i(0))与质量矩阵噪声相符；位置积分m_i⁻¹p_i和势偏导D13正确。[EXTRA]准确描述技术限制；不证明解存在或不变分布。
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
> \[dq=M^{-1}pdt;\tag{6.34}\quad dp=-\nabla U(q)dt-\Gamma(q)\Gamma(q)^T pdt+\sqrt{2k_BT}M^{1/2}\Gamma(q)d\widehat W;\tag{6.35}\]
> where we use the matrix $\Gamma(q)\in\mathbb R^{N_c\times S}$ and a vector of $S$ independent Wiener processes $\widehat W$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整任意矩形Γ(q)、任意质量和真实全部噪声坐标严格Ito积分；未缩成对角或单位质量，不宣称自动Gibbs不变。
- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：n/r独立量化，Γ为n×r的空间依赖矩阵；m_i>0、θ>0、U/Γ光滑，r维联合Wiener，连续初值路径与位置方程齐全。每个动量坐标i、每个T≥0存在全部r个严格积分，系数√(2θm_i)Γ_ij，漂移−∂iU−(ΓΓᵀp)_i，均正确，全部漂移可积性明示。没有单位质量或对角化偷换；严格L²积分模型比一般局部Itô解范围窄，[EXTRA]已说明严格积分范围。
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

> In the case of Langevin dynamics with different, variable friction coefficients for each particle, we have $S=N_c$ and
> \[\Gamma=\operatorname{diag}(\gamma_1(q),\gamma_1(q),\gamma_1(q),\gamma_2(q),\gamma_2(q),\gamma_2(q),\ldots,\gamma_N(q),\gamma_N(q),\gamma_N(q)).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Let $v=M^{-1}p$ and assume that the acceleration is negligible, so that Langevin dynamics reduces to
> \[dq=vdt;\quad0=-\nabla U(q)dt-\gamma Mvdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\]
> The second equation can be solved for $v$ and we obtain the following SDE for $q$:
> \[dq=-\gamma^{-1}M^{-1}\nabla U(q)dt+\sqrt{2k_B\gamma^{-1}T}M^{-1/2}dW.\tag{6.36}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意维正m、γ>0、θ>0、光滑U、n维Wiener以及q0；真实连续路径积分方程的漂移−(γm_i)⁻¹∂iU、噪声√(2θ/(γm_i))均正确，全部漂移区间可积性已明示。此定义编码形式Brownian模型；不将令加速度为0当作已经证明小质量/大摩擦收敛，实际极限另见条目16。
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

> \[\psi(t)=k^{-1}\sum_{i=1}^k\cos(\Omega_i(t)).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]以实际给定频率直接表达原核，方便记录图6.4/6.5全部数值族；k>0用于物理解释，有限函数定义不计δ极限已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意有限频率族Ω和实t，函数为k⁻¹∑cos(Ω_i*t)，与D3相同的频率解释。k=0在Lean中定义为0；[EXTRA]所说k>0仅为物理解释，实际签名没有该前提，不应当作已验证的正k模型定理。此为核定义，无δ极限结论。
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

> Fig. 6.4 The memory kernel $\psi$ is shown for three different sets of frequencies $\Omega_i$. Blue: $k=400$, $\Omega_i=0.01i$; red: $k=1,000$, $\Omega_i\sim U[0,1]$; green: $k=1,000$, $\Omega_i=10\widehat\Omega_i$, where $\widehat\Omega_i\sim U[0,1]$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Fig. 6.5 The memory kernels are shown for various choices of $\Omega_i^{(k)}$. Left: $\Omega_i^{(k)}=i/\sqrt k$, $k=5^2,10^2,\ldots,35^2$; center: $\Omega_i=\sqrt k\widehat\Omega_i$, $\widehat\Omega_i\sim U[0,1]$, $k=10,20,\ldots,100$; right: $\Omega_i=k\widehat\Omega_i$, $\widehat\Omega_i\sim U[0,1]$, $k=10,20,\ldots,100$. In each case the red curve indicates the largest value of $k$ considered, whereas green indicates the smallest value.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For large $k$ and for many choices of the frequencies $\Omega_i$ and the initial conditions $\{q_i(0);p_i(0)\}$, function $f(t)$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].

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
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整连续路径空间的弱法则，而非只收敛均值/某单时边际；实际有限热浴力路径与Wiener路径逐点关联，只定义原希望的资格，不宣称任意族满足。
- [EXTRA] 两版补概率空间与连续路径随机变量可测性；Printed是力路径、corrected是正力时间积分；物理标度和极限是否可实现仍待导师，不把弱收敛资格谓词当存在定理。
- [EXTRA] 复审范围：两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。
- 覆盖缺口：两个定义分别表达力路径及积分力路径的收敛资格；没有断言实现条件存在，也没有初态、频谱标度、σ及紧性定理，网站未认证实际热浴极限。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。bathForceWeakLimitMeaning：在概率空间、正质量下，将实际Printed力逐点嵌入C([0,T])，要求路径随机变量可测，W为preBrownian并有连续路径代表；对每T>0全部有界连续泛函的期望收敛，确为路径法则弱收敛而非仅边际。_corrected改成正bathForce的0至s时间积分，其余量词不变；这是与dP中的白噪声驱动更相符的候选。没有任何版本断言存在初态/质量族满足；也没有σ幅度或物理标度条件，所以不能认证实际热浴收敛或称“修复完成”。两版定义签名各自表达所说资格，但数学解释保留NEEDS_HUMAN。
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> where $\mathcal L$ is a linear operator, called the generator of the stochastic process, defined by
> \[\mathcal L\phi(x)=\left(a(x)\frac d{dx}+\tfrac12 b^2(x)\frac{d^2}{dx^2}\right)\phi(x).\tag{6.38}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\mathbb E\{d\phi(X)\}=\mathbb E\{\phi'(X)a(X)\}dt+\tfrac12\mathbb E\{\phi''(X)b(X)^2\}dt
> =\mathbb E\{(\mathcal L\phi)(X)\}dt.\tag{6.37}\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $C^\infty$ smooth and satisfy the polynomial growth restriction by $C_P^\infty$:
> \[C_P^\infty\stackrel{\mathrm{def}}=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：ContDiff ℝ ∞ f且存在统一C≥0、自然r、∀x的|f(x)|≤C(1+|x|)^r。光滑函数在紧区间有界，因此该全局界与原双侧无穷处Big-O等价。没有擅自把C_P∞强化为所有阶导数都多项式增长。
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

> For any $\phi\in C_P^\infty$, the expectation with respect to $\rho(x,t)$ is well defined and we have
> \[\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\mathcal L^\dagger\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx},\]
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{+\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx
> =-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> With two rounds of integration by parts on the term involving $b(x)$, we find, using the fact that the boundary terms vanish,
> \[\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.\]

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
| 所引原句 | 本条Lean覆盖范围：PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧_corrected名字仅兼容保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧_corrected名字仅兼容保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。fpDiffusionPrinted与_corrected同签名：b,ρ,φ为C²，φ紧支撑，则∫b²φ″ρ=∫φ(b²ρ)″。将时间固定后ρ为实函数符合原式；紧支撑φ及其导数消除边界项，C²使各紧支 integrand可积。没有外负号，亦没有在该纯扩散分部积分恒等式中额外放1/2。两版PASS；_corrected只是兼容同义名，不是原书勘误。fpDriftAdjoint的C¹紧支辅助式负号也正确。
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

> where the operator appearing on the right hand side is the adjoint $\mathcal L^\dagger$ of the generator of the stochastic process, satisfying the relation
> \[\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.\]
> In the case at hand the adjoint is
> \[\mathcal L^\dagger\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx},\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]紧支撑C²检验的完整正号伴随恒等；多项式检验及指数尾版本另条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：对任意C² a/b/ρ/φ和紧支φ，真实全实轴∫(Lφ)ρ=∫φ(L†ρ)。D47/D50展开后正确，紧支使全部相关积分存在；紧支C²范围已在[EXTRA]明示，不把它计作所有C_P∞测试的完整伴随域结论。
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

> We assume that $\rho$ is $C^\infty$ for all $t$ and that the density tends to zero exponentially fast as $x\to\pm\infty$, whereas $a$ and $b$ are $C^\infty$ functions which grow at most polynomially fast in these limits, that is, there are constants $\eta_a$, $\eta_b$ such that
> \[a(x)=\mathcal O(|x|^{\eta_a}),\quad b(x)=\mathcal O(|x|^{\eta_b}),\quad x\to\pm\infty.\]
> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $C^\infty$ smooth and satisfy the polynomial growth restriction by $CP^\infty$:
> \[CP^\infty=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.\]
> For any $\phi\in CP^\infty$, the expectation with respect to $\rho(x,t)$ is well defined and we have
> \[\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.\]
> Taking the differential, we obtain an equation for $\mathbb E d\phi$ which must be equal to (6.37):
> \[\int_{-\infty}^{+\infty}\phi(x)\frac{\partial\rho}{\partial t}dx=\int_{-\infty}^{+\infty}(\mathcal L\phi)(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}(a(x)\phi'+\tfrac12 b^2(x)\phi''(x))\rho(x,t)dx.\]
> Using the assumptions given above regarding the exponential rate of decay of the density, it is possible to recast the right hand side as an integral of a product with $\phi$. First, we find
> \[\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx=-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.\]
> With two rounds of integration by parts on the term involving $b(x)$, we find, using the fact that the boundary terms vanish,
> \[\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.\]
> Finally, putting these results together, we have
> \[\int_{-\infty}^{+\infty}\phi(x)\left[\frac{\partial\rho}{\partial t}+\frac{\partial}{\partial x}(a(x)\rho(x,t))-\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho)\right]dx=0.\]
> If this is to hold for all test functions $\phi$, we must have
> \[\frac{\partial\rho}{\partial t}=-\frac{\partial}{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).\]
> This partial differential equation is often called the Fokker-Planck equation. The great benefit of the Fokker-Planck equation is that it enables the macroscopic perspective on the solutions of an SDE.
> The Fokker-Planck equation may be written in the compact form
> \[\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho,\]
> where the operator appearing on the right hand side is the adjoint $\mathcal L^\dagger$ of the generator of the stochastic process, satisfying the relation
> \[\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原C∞P值增长不足以控制所有IBP边界；明确一、二阶a,b,φ多项式增长及ρ导数指数尾，保存整个非紧支撑真实积分恒等。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。fpPolynomialAdjoint及_corrected：a,b,ρ,φ为C∞；a,b,φ的0至2阶导数逐阶有全局多项式界，ρ的0至2阶导数逐阶有正指数尾；这些明确加强条件保证真正非紧支撑积分可积与所需边界消失，scalarGenerator=aφ′+b²φ″/2、scalarForward=-(aρ)′+(b²ρ)″/2，签名正确。fpPolynomialAdjointPrinted只约束k=0的函数值，忠实于原书CP∞和密度衰减，不能据此控制导数、边界或积分；Printed保留NEEDS_HUMAN。原文并未证明任意此类测试函数的Lφ可积，不能让Bochner总化积分掩盖问题。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpPolynomialAdjoint` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.fpPolynomialAdjoint_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.fpPolynomialAdjointPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:1739`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPEquation

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> If this is to hold for all test functions $\phi$, we must have
> \[\frac{\partial\rho}{\partial t}=-\frac\partial{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).\]
> The Fokker-Planck equation may be written in the compact form
> \[\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho.\]

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

网站原返回：FAIL。fpEquation的P、W,X、a,b、确定初态x0及ρ(t,x)量词、自然历史适应与联合可测X、扩散平方可积、真实正密度HasLaw、多项式值界及正时间紧窗一致指数尾均已核对；结论是每t>0、每x的经典PDE，scalarForward系数正确，未把目标PDE设为前提。但ContDiff ℝ ∞ (Function.uncurry ρ)要求ρ在包括t=0的整个ℝ²光滑，同时strictScalarSDE要求X0=x0且AE路径在0连续，HasLaw对所有t>0成立。这使整组前提不可能：连续初态的边际趋δ_x0，而跨t=0连续的Lebesgue密度在小紧矩形有一致界，不能产生该原子极限。因此该签名是空泛的加强，并非原书“给定初始密度”的FP陈述，判FAIL；与sorry无关。仅补适应性不能修复时间域和初始法则。
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

> In case $b\equiv0$, the SDE becomes an ordinary differential equation. Then the generator $\mathcal L$ becomes simply the Lie derivative, and its adjoint is just the Liouvillian.

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

> If $\phi$ is a scalar valued function of $\mathbb R^m$, and $Z(t)$ is the solution of the SDE system
> \[dZ=a(Z)dt+B dW;\tag{6.39}\]
> where $a$ is a function in $\mathbb R^m$ and $B$ is a constant matrix, then we have
> \[d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12dW^TB^T\phi''B dW;\tag{6.40}\]
> where $\phi''$ is the Hessian matrix of $\phi$, i.e. the matrix of second partial derivatives of $\phi$ with respect to pairs of the variables. In some applications $B=B(Z)$, in which case the SDE (6.39) is said to involve multiplicative noise (as oppose to the additive case we consider when $B$ is constant). For a discussion of the differences and applications of these types of noise, see [289, 324].
> All components on the right hand side of (6.40) are evaluated at $Z(t)$. Then using the shorthand rules $dW_i dW_j=dt\delta_{ij}$ (where $\delta_{ij}$ is one if $i=j$, zero otherwise), we have
> \[d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12\operatorname{Tr}(B^T\phi''B)dt.\tag{6.41}\]

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
| 所引原句 | 本条Lean覆盖范围：改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected_json恢复连接文本。仍缺一般多维Itô理论。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected_json恢复连接文本。仍缺一般多维Itô理论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。vectorIto：任意n,r、共同向量Wiener及strictVectorSDE、常n×r矩阵B、C² φ、联合可测且共同向量自然历史适应X；vectorGridItoQualification25对每列方向导数被积过程给共同历史适应、每时及每网格L²、局部均方Hölder资格。结论逐T≥0存在r个严格标量积分，且φ增量减∫vectorGenerator等于积分和AE。共同过滤不误限为各自单坐标过滤；vectorDiffusion=Σ_ij(BBᵀ)_ij∂i∂jφ，等价Tr(Bᵀ Hess φ B)，漂移fderiv φ(a)与1/2正确。资格未预设结论，签名PASS；只审签名，不认证sorry证明。
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

> In the multivariate case, the density is a function of the vector describing a state of the system $z$ and $t$, and is governed by the partial differential equation
> \[\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意n/r、向量漂移a、常n×r矩阵B、标量ρ及状态x；MD包装的精确项目定义为−∑i∂i(a_iρ)+½ vectorDiffusion B ρ，D51给BBᵀ与ρ的混合二阶导数，次序和系数正确。context_notation已明示这里只定义前向算子，不算从law证明PDE。代码块附带的cylinderForwardPrinted_corrected是另一source_id的别名，目标相同且无额外数学断言，不把它混算为本条证明或独立条目。
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
> \[\operatorname{Tr}(B^T\rho''B)=\sum_{i=1}^m\sum_{j=1}^m(BB^T)_{ij}\frac{\partial^2\rho}{\partial z_i\partial z_j}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：签名将Hessian抽象为任意n×n实矩阵H，B为n×r；没有额外正定或对称前提。trace(BᵀHB)=∑ij(BBᵀ)ij H_ij对任意H成立：按矩阵乘法展开并用实数乘法交换律及BBᵀ对称性重排。包括n/r=0的空和情况。取H=ρ的Hessian即原式，强化为任意矩阵没有丢结论，也不需要用Hessian对称性作隐藏前提。
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

> In the multivariate case, the density is a function of the vector describing a state of the system $z$ and $t$, and is governed by the partial differential equation
> \[\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> In the special case of Langevin dynamics (6.32)–(6.33) for a system with $N_c$ configuration variables, the density is a function of the vectors of positions $q$, momenta $p$, and time, and the formula for the Kolmogorov operator becomes
> \[\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho;\tag{6.42}\]
> where the mass-weighted Laplacian $\Delta_M$ is defined as
> \[\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> \[\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\mathcal L^\dagger\rho_{\rm eq}\equiv0.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\mathcal L^\dagger\rho_{\rm eq}\equiv0.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> \[dp=-\nabla U(q)dt-\Gamma(q)\Gamma(q)^T pdt+\sqrt{2k_BT}M^{1/2}\Gamma(q)d\widehat W.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整原矩形Γ、任意质量的实际漂移与噪声协方差导出形式前向表达，供验证canonical资格；没有偷换为常矩阵或单位质量。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：定义对任意n、r、m、U、空间依赖Γ、θ、密度ρ和相点x；位置项−m_i⁻¹p_i∂qiρ，动量项∂pi[(∂iU+(ΓΓᵀp)i)ρ]，扩散θ√m_i√m_k(ΓΓᵀ)ik∂pi∂pkρ，恰为该SDE协方差的一半。Γ只依赖q，不需动量导数落在Γ上。签名为形式算子，可在非正m上有Lean总定义；物理对应限于正质量、光滑密度，不把此定义当PDE或stationarity证明。[EXTRA]的任意质量应理解为任意正质量。
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

> However, it should be noted that in many types of modelling, the physical nature of the interaction with the solvent bath is neglected and $\gamma$ or $\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]该条为原恢复canonical目标的必要形式stationarity检验；完整任意质量/Γ对象保留，不以必要检验计完整采样收敛已证。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。C：量化任意n/r、正m、光滑U/Γ、θ>0以及所有相点，断言D42作用于未归一化exp(−H/θ)为0；对象、Hamiltonian质量分母和全部结论无遗漏。但该Printed全称命题不成立。作为原书canonical目标的必要检验可保留，不能认定数学PASS；也没有证明归一化存在或采样遍历性。[EXTRA]正确提醒必要性，不修复非交换问题。
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

> $\gamma$ or $\Gamma(q)$ are simply viewed as artificial parameters which allow recovery of averages with respect to the canonical distribution.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> A discrete Markov Chain is a stochastic process in which, at each step, a transition is made from the current state $i$ to another $j$ selected from a given probability distribution. In the case of a finite collection of states $\Sigma=\{1,2,\ldots,k\}$, we assume that the transition probabilities $\pi_{ij}\in[0,1]$ are given and denote the state at time $n$ by $S_n$. Thus we have
> \[\Pr(S_{n+1}=j\mid S_n=i)=\pi_{ij}.\]
> The sum of the elements in row $i$ gives the probability of being in some state at time $n+1$ given that we were in state $i$ at time $n$, thus it is one.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> A distribution on the state space is typically associated to a row vector $\psi=(\psi_1,\psi_2,\ldots,\psi_k)$ with nonzero elements and which is normalized such that
> \[\sum_{i=1}^k\psi_i=1.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]概率权重取非负，允许零概率状态；原nonzero作为“typically”的描述而非概率的必要条件，不添加严格正初值要求。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐个审校：finiteDistribution及_corrected均为非负且总和1的一般概率向量；finiteDistributionPrinted按概率权重上下文将nonzero保留为严格正且总和1；反例(1,0)确实满足前者且不满足后者。三种对象及counterexample相互吻合。原句含typically，不能无条件把原文认定为错误定义；应保留人审。
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

> The probability of being in state $i$ at the $n+1$st iteration, is the sum over $j$ of the probabilities of being in state $j$ multiplied by the probability of transitioning from state $j$ to state $i$, thus
> \[\psi_{n+1}=\psi_n\Pi.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义ψ_n=ψ₀Πⁿ，Matrix.vecMul方向是行向量右乘；n=0得到初值，全部分量保留。原递推式与此闭式等价（19另列完整递推定理）。作为线性演化定义允许任意实矩阵/向量，不声称它们都是概率；无需额外随机性前提。
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

> \[\psi_{n+1}=\psi_n\Pi.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For each state of the chain, we define the number $d(i)$ to be the greatest common divisor of all integers $l$ such that $\pi_{ii}^{(l)}>0$ (if the probability of return to state $i$ is zero, then we set $d(i)=0$).

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> For each state of the chain, we define the number $d(i)$ to be the greatest common divisor of all integers $l$ such that $\pi_{ii}^{(l)}>0$ (if the probability of return to state $i$ is zero, then we set $d(i)=0$).

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> If $d(i)=1$, for all $i$ then we say that the chain is aperiodic.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, MolecularDynamics.Chapter06Review.period PiMark i = 1
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> States $i$ and $j$ are said to communicate if $\pi_{ij}^{(l_1)}>0$ and $\pi_{ji}^{(l_2)}>0$ for some integers $l_1$ and $l_2$. This means that it is possible to reach $j$ from $i$ with positive probability and vice-versa.
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> An invariant distribution is a left eigenvector of $\Pi$, having only non-negative elements, and corresponding to the eigenvalue 1. That is, an invariant distribution $\psi_*$ satisfies
> \[\psi_*=\psi_*\Pi.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> The fundamental result for Markov chains is the following: If a given Markov chain is both irreducible and aperiodic, then it can be shown that there is a unique invariant distribution $\psi_*$ such that
> \[\lim_{n\to\infty}\psi_n=\psi_*,\]
> for arbitrary initial distribution $\psi_0$. The convergence of an irreducible finite Markov chain to its stationary distribution can be understood through the properties of its eigenvalues by applying of the Perron-Frobenius theorem (see [269]).

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> \[\Pi=\begin{bmatrix}0.2&0.1&0.7&0&0\\0&0&0&1&0\\0.3&0&0&0.3&0.4\\0&0.5&0&0.3&0.2\\0&0&0&1&0\end{bmatrix}.\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> States $i$ and $j$ are said to communicate if $\pi_{ij}^{(l_1)}>0$ and $\pi_{ji}^{(l_2)}>0$ for some integers $l_1$ and $l_2$. This means that it is possible to reach $j$ from $i$ with positive probability and vice-versa.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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
> For a directed graph, we must have, for any pair of vertices $A$ and $B$, paths which take us from $A$ to $B$ and vice-versa.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Now consider an SDE system defined on the space $D=\mathbb T^{k_1}\times\mathbb R^{k_2}$ for non-negative integers $k_1$ and $k_2$.

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Now consider an SDE system defined on the space $D=\mathbb T^{k_1}\times\mathbb R^{k_2}$ for non-negative integers $k_1$ and $k_2$:
> \[dX=b_0(X)dt+\sum_{i=1}^r b_i dW_i;\tag{6.43}\]
> where $b_0$ is $C^\infty$ and the $W_i$ are independent standard Wiener processes. In this book, we will only consider the analysis for the case of additive noise (i.e. the $b_i$ vectors multiplying a Wiener process are constant).

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

> Working in flat $L^2$ space, we have that the infinitesmal generator for (6.43) acting on a smooth test function $\phi(X)$ is
> \[\mathcal L\phi=b_0\cdot\nabla\phi+\tfrac12\operatorname{Tr}(B^T\phi''B);\]

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
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
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

## MD-6.4.2-CylinderForwardPrinted

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $\mathcal L^\dagger$, acting on a density $\rho(X)$ as
> \[\mathcal L^\dagger\rho=-\nabla\cdot(b_0\rho)+\tfrac12\operatorname{Tr}(B^T\phi''B).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderForwardPrinted {n r : ℕ} (b₀ : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ φ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  -(∑ i, fderiv ℝ (fun z ↦ b₀ z i*ρ z) x (Pi.single i 1)) +
    MolecularDynamics.Chapter06Review.vectorDiffusion B φ x / 2

/-- 修正版：真正环面×动量圆柱空间的前向表达式，使用周期lift方向导数。
原Euclidean坐标辅助cylinderForwardPrinted_corrected另保留；本定义不声称密度存在。 -/
def cylinderForwardPeriodic_corrected {n r : ℕ}
    (a : textbookLangevinPeriodicPhase n → (Fin n ⊕ Fin n → ℝ))
    (B : Matrix (Fin n ⊕ Fin n) (Fin r) ℝ)
    (ρ : textbookLangevinPeriodicPhase n → ℝ) (x : textbookLangevinPeriodicPhase n) : ℝ :=
  -(∑ i : Fin n ⊕ Fin n, textbookLangevinPeriodicDirectionalDerivative
      (fun y ↦ a y i*ρ y) (textbookLangevinCanonicalCoordinateDirection i) x) +
    (∑ j : Fin r, ∑ i : Fin n ⊕ Fin n, ∑ k : Fin n ⊕ Fin n,
      B i j*B k j*textbookLangevinPeriodicDirectionalDerivative
        (textbookLangevinPeriodicDirectionalDerivative ρ (textbookLangevinCanonicalCoordinateDirection k))
        (textbookLangevinCanonicalCoordinateDirection i) x)/2
```

同问题的独立限定/修正版（位于另一条）：
```lean
def cylinderForwardPrinted_corrected {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。cylinderForwardPrinted：任意欧氏n维b0、n×r常B、密度ρ和独立测试φ，负散度作用于b0ρ，扩散作用φ并除2，忠实保留原书符号错误，但这是欧氏局部坐标表达式，不是完整一般T^k1×R^k2域。cylinderForwardPrinted_corrected调用vectorForward，将扩散改为ρ，欧氏辅助定义正确。cylinderForwardPeriodic_corrected在真实T^n×R^n上按Fin n⊕Fin n坐标方向求周期lift的一、二阶方向导数，用Σ_j B_ij B_kj和1/2给前向密度算子；维数与噪声列维一致，作为光滑周期密度的形式表达式正确。它只覆盖k1=k2=n的Langevin相空间，非原页全部k1,k2；且未在类型内强制光滑/密度资格，不能当算子域或不变性定理。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderForwardPrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |
| `MD.Ch06.cylinderForwardPeriodic_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2105`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-StationaryDensity

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of
> \[\mathcal L^\dagger\rho_{\rm eq}\equiv0.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stationaryWeightRaw25 {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0

def stationaryDensity {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧ Integrable ρ volume ∧
  (∫ x, ρ x)=1 ∧ ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。

### 6. 审计结论（含网站结论）

网站原返回：PASS。stationaryWeightRaw25只定义任意实函数的vectorForward逐点为0，是总化辅助。stationaryDensity另外要求ρ可测、处处非负、Lebesgue可积及积分1，再要求同一逐点形式方程，概率密度资格已补足，签名作为形式平稳密度定义PASS。D29为负散度加常B扩散半项；n,r任意，当前域为ℝ^n而非一般圆柱。类型未要求C²或适当generator域，Lean的不可微处导数总化为零；所以不能凭该谓词推出真实Markov核不变性，当前context_notation已明示形式stationarity且另给generator域/演化。该限制须持续保留，不把“correspond in general”误报为已证等价定理。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stationaryWeightRaw25` | 定义 | — | PASS |
| `MD.Ch06.stationaryDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2126`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-StationaryInvariant

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of
> \[\mathcal L^\dagger\rho_{\rm eq}\equiv0.\]
> Solutions to this equation are of central importance to the probabilistic behavior of solutions to (6.43). Such solutions give distributions of points in phase space which will remain constant as solutions evolve in time.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem stationaryInvariant :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  MolecularDynamics.Chapter06Review.markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → ∀ T : ℝ, 0 ≤ T →
    ∃ bound : D → ℝ, Integrable bound μ ∧ ∀ s ∈ Icc 0 T, ∀ x,
      |L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal y) x| ≤ bound x) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal x)
      (L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  MolecularDynamics.Chapter06Review.invariantKernel K μ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Markov kernel semigroup、真实generator对演化检验的导数关系与弱stationarity，并明确局部可积支配保证求导换积分；完整kernel测度不变，未假设不变结论或把形式exp当实际流。
- [EXTRA] 补实际Chapter06Review.invariantKernel及其kernelEvolution定义体；不以MD.Ch06同名定义替代。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：引文、公式、节号及印刷247/PDF268页均与附件第1页相符。C：D为任意可测状态空间，K为非负时间的实际概率Markov核半群，μ为概率测度；逐一核对了全部有界可测检验函数、每个有限时间区间上的可积导数支配、演化检验函数的右侧导数关系、L作用后的可积性及弱平稳性前提。D3–D6中kernelAverage是真实核积分，kernelEvolution为K t ∘ₘ μ，invariantKernel量化所有非负时刻的测度相等。因此结论是完整的核不变性，未将形式指数、只对常数检验的恒等式或不变性本身作为前提。[EXTRA]清楚披露了这是一条在可交换微分与积分条件下由弱平稳推出不变的充分命题；不把它解读为无条件的形式偏微分方程等价定理。本次只审签名，不因sorry扣分。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stationaryInvariant` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2138`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4-CanonicalMixingMeaning

印刷p.244 / PDFp.265；§6.4。

### 1. 原文陈述

> At any time $t$ we take a snapshot $M_t$ of the resulting set of random variables. Even if $M_0$ is bounded, the evolving set of points would be expected to expand and fill in the phase space accessible at the temperature $T$; eventually we hope that the points will be distributed in the entire phase space in accordance with the target measure (usually the Gibbs distribution $e^{-\beta H}$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def canonicalMixingMeaning {D : Type*} [TopologicalSpace D] [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ x : D, ∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂K t.toNNReal x) atTop (𝓝 (∫ z, f z ∂μ))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实概率目标和任意点初始law、全部有界连续检验函数弱混合定义；没有宣称所有SDE自动满足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义为概率目标及每个点初值、每个有界连续实检验的弱收敛；时间atTop下toNNReal不影响极限。此为[EXTRA]明确选择的含义，不是任意SDE的定理。Kernel本身不保证Markov，应避免把任意K称概率law。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalMixingMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2155`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-LangevinCanonicalMixing

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> Even a single phase space point, which corresponds to a delta-function initial distribution, will instantly diffuse as the solution of the Fokker-Planck equation and, eventually, would cover the entire phase space.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinCanonicalMixing :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ →
  (∀ t : ℝ≥0, 0 < t → ∃ density : textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n → ℝ,
    Continuous density ∧ (∀ x y, 0 < density (x,y)) ∧
    ∀ x, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t x =
        (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun y ↦ ENNReal.ofReal (density (x,y)))) ∧
  ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实现有周期单位质量Langevin kernel、正γ/β、原光滑力全局Lipschitz；完整任意点初值的正时刻严格正连续转移密度以及全部有界连续检验弱混合，原一般混合意义另条，不以单位质量特例替代一般定义。
- [EXTRA] 补所选真实路径的存在规格和初值/积分方程；范围仅周期、单位质量及已列全局Lipschitz力，不声称一般非周期Langevin结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：印刷248/PDF269页中从“Even a single phase space point”到“entire phase space”的摘录准确。C：状态空间确为单位位置环面×实动量，U全局C∞且单位周期，力为−∇U并有显式全局Lipschitz常数；β、γ正，噪声幅度√(2γ/β)，B满足给定高斯、均值、协方差和几乎处处连续的Wiener规格。D17、D19–D23给出所选路径的存在、初值和两条积分方程；D28的核是该实际路径端点的推前，未任意选一个具有所需性质的核。flatPhaseMeasure为位置Haar×动量Lebesgue；canonicalMeasure为归一位置Gibbs×各坐标方差β⁻¹的独立高斯。第一结论对每个t>0提供在两个初末态变量上连续、处处严格正的密度及全测度相等；第二结论对每个点初值、每个有界连续f给出到该规范测度的弱收敛。[EXTRA]已明确周期、单位质量的范围；不把此声明扩大为任意退化SDE或非紧配置空间的结论。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinCanonicalMixing` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2163`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianGenerator

印刷p.249 / PDFp.270；§6.4.3。

### 1. 原文陈述

> For example, let us return to Brownian dynamics (or overdamped Langevin dynamics) and set $M=I$ and $\gamma=1$ in (6.36), giving an equation of motion
> \[dq=-\nabla U(q)dt+\sqrt{2k_BT}dW.\tag{6.46}\]
> Writing $\beta^{-1}=k_BT$ as usual, the generator of the stochastic process may be written as
> \[\mathcal L f=-\nabla U^T\cdot\nabla f+\beta^{-1}\Delta f.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def brownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际任意对角质量版本，取m≡1即此处公式；不声称原6.46本身含一般质量。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐坐标fderiv方向导数及二阶导数给出逆质量加权漂移和扩散；m≡1还原原式。[EXTRA]已披露推广。当前是代数算子定义，并非在任意β,m及任意f下断言存在相应扩散生成元。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2183`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianWeightedInner

印刷p.249 / PDFp.270；§6.4.3。

### 1. 原文陈述

> Let $\bar\rho_\beta=\exp(-\beta U)$, and define the space of functions $C_0^2(\bar\mu_\beta)$ consisting of functions in $C_0^2$ on the configuration space $\mathcal Q\subset\mathbb R^{N_c}$ together with the inner product
> \[\langle f,g\rangle_\beta\stackrel{\rm def}=\int_{\mathcal Q}f(q)g(q)\bar\mu_\beta(d\omega_q)=\int_{\mathcal Q}f(q)g(q)\bar\rho_\beta(q)d\omega_q;\]
> where $d\omega_q=dq_1dq_2\cdots dq_{N_c}$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def brownianWeightedInner {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube n, f q*g q*Real.exp (-β*U q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]本章后续周期Q的单位基本域；保留原未归一权重，不偷加Z⁻¹。C₀²域与闭算子域另行区别。

### 6. 审计结论（含网站结论）

网站原返回：PASS。积分域确为Icc 0 1，权重exp(-βU)未除Z；f,g为任意函数的总定义，适当函数域上才是内积。周期基本域限制已披露；此定义没有形式化C₀²函数空间本身。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianWeightedInner` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2192`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianDirichlet

印刷p.249–250 / PDFp.270–271；§6.4.3。

### 1. 原文陈述

> Combining this with the first part of the inner product, we see that
> \[\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.\]

### 2. 原文证明

> \[\langle f,\mathcal Lg\rangle_\beta=\int_{\mathcal Q}f[-\nabla U^T\nabla g+\beta^{-1}\Delta g]\bar\rho_\beta d\omega_q.\]
> Integrating by parts in the second term we have
> \[\beta^{-1}\int_{\mathcal Q}f\Delta g\bar\rho_\beta d\omega_q=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla(f\bar\rho_\beta)d\omega_q
> =-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q+\int_{\mathcal Q}f(\nabla g^T\nabla U)\bar\rho_\beta d\omega_q.\]
> Combining this with the first part of the inner product, we see that
> \[\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.\]

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianDirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  apply MolecularDynamics.textbookBrownianGenerator_integral_dirichlet <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C∞周期资格保证边界通量消去；实际全质量逆M梯度积，m≡1还原原式；β≠0。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U,f,g全域C∞、整数平移周期及β≠0保证分部积分边界抵消；两侧使用同一未归一权重和全部逆质量坐标和。等式不需质量正性；m≡1还原原文。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianDirichlet` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2198`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianSymmetry

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In this form we see that $f$ and $g$ appear symmetrically, so we may write
> \[\langle f,\mathcal Lg\rangle_\beta=\langle\mathcal Lf,g\rangle_\beta;\]
> hence, with respect to the weighted inner product, $\mathcal L^\dagger=\mathcal L$. (Note that the adjoint indicated here is quite different than the $L^2$ adjoint mentioned previously in connection with the Fokker-Planck operator.)

### 2. 原文证明

> 原书给出分部积分得到形式对称配对的论证；未给出无界算子闭域及伴随域相等的完整论证。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianSymmetry {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianSymmetry_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原文引文保持不变；两份Lean声明仅覆盖C∞单位周期核心上的加权配对对称。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整未归一配对等式，由现成归一配对消去正Z⁻¹；C∞周期核心上的形式对称，不宣称C₀²核心本身已闭自伴。
- [EXTRA] 本条仅为周期光滑核心上的形式对称配对；核心对称不推出伴随域相等。闭实现自伴另见BrownianClosedSelfAdjoint，原C₀²域解释待签核。
- [ERRATUM?] 形式对称与闭自伴须区分；本条配对恒等式不等于已经忠实实现原C₀²域上的L†=L。
- [EXTRA] 复审范围：两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
- 覆盖缺口：原C₀²域的自伴解释待人工确认；闭实现的自伴性由BrownianClosedSelfAdjoint单独处理。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：配对等式及随后L†=L的引文准确，原文的自伴措辞应保留。C：两份Lean签名完全相同，均为PASS的限定配对恒等式：积分在一个基本立方体上，权为exp(−βU)，U、f、g均C∞且单位周期，β≠0；m仅作实系数参数，形式对称本身不需要质量正性。D32–D34及归一配对定义表明取消正的配分函数因子不会改变等式。它们没有表达伴随算子的定义域等于原定义域。原页从对称积分直接说L†=L，但此前给出的C₀²域是否指闭实现并不清楚，不能把正确的核心对称等式当作原域已自伴。corrected版数学陈述通过；整条因原文域解释仍为NEEDS_HUMAN，而非因证明占位或定义缺失。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianSymmetry` | 已证 | — | PASS |
| `MD.Ch06.brownianSymmetry_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2213`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianNonpositive

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> Moreover, from the calculation above,
> \[\langle f,\mathcal Lf\rangle=-\beta^{-1}\int_{\mathcal Q}\|\nabla f\|^2\bar\rho_\beta d\omega_q;\]
> so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianNonpositive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNonpositive；改动：采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。 -/
theorem brownianNonpositive_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNegativeDefinitePrinted；改动：将严格小于0改为小于等于0；零特征值与常数核保留。 -/
theorem brownianNegativeDefinitePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正质量与β>0，未归一配对；本条结论精确保留≤0，原negative definite术语错误另记录。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。正质量、β>0及周期光滑域下未归一二次型≤0正确。原文negative definite错误，已有[ERRATUM?]保留；本签名仅保留正确的半负定子结论。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianNonpositive` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.brownianNonpositive_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.brownianNegativeDefinitePrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2246`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianRealEigenvalue

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianRealEigenvalue {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianRealEigenvalue_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真正非零L²特征函数、C∞周期、正质量与β>0；不以特征值符号作假设。
- [EXTRA] [ERRATUM?]原引文negative definite应为半负定，常数零模反例与BrownianNegativeDefinitePrinted共用；本条只证明已给实特征参数≤0，不冒称全部复谱实性。
- 覆盖缺口：仅证明已给实特征参数非正；不单独证明复特征值实性，也不把原严格负定用语认作成立。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：原文确实同时写⟨f,Lf⟩≤0和“negative definite”，转录未错，不能在原引文中静默改成半负定。C：两份签名均PASS：正质量、β>0、C∞周期U及非零L²意义的C∞周期f，逐点满足Lf=ℓf，且参数ℓ预先属于ℝ，结论ℓ≤0。非零性相对于基本立方体Lebesgue几乎处处定义，正Gibbs权使其等价于Gibbs-L²非零；没有把特征值符号作为假设。声明不证明任意复特征值实性，也不证明严格负定；这些限制已由[EXTRA]说明。整条因原书严格负定用语的数学疑误需人工签核。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianRealEigenvalue` | 已证 | — | PASS |
| `MD.Ch06.brownianRealEigenvalue_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2281`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianClosedSelfAdjoint

印刷p.249–250 / PDFp.270–271；§6.4.3。

### 1. 原文陈述

> Then $\mathcal L$ is self-adjoint with respect to this inner product.

### 2. 原文证明

> 原书给出形式分部积分的论证，见印刷249–250页；未说明完整闭域及伴随域。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianClosedSelfAdjoint {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianClosedSelfAdjoint_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原文自伴句保持不变；Lean主版与corrected版均指周期Gibbs复L²上的闭/最大图实现。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]使用现成实际Gibbs复L²闭实现及完整adjoint域；原C₀²核心对称不等于闭自伴。权重归一不改变自伴关系。
- [EXTRA] 明确采用周期紧环面的Gibbs L²图闭包/最大复图实现；此域修正替换原C₀²核心域，不能把核心上的形式对称当原域自伴，待人工签核。
- [EXTRA] 原页先取单位质量；本条还推广至任意正对角质量。
- [ERRATUM?] 原C₀²域上的形式对称不应直接等同于完整无界算子的自伴。
- [EXTRA] 复审范围：限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
- 覆盖缺口：原C₀²核心域自伴的字面断言未由这两份签名实现，需人工确认作者原意。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：印刷249页末的“Then L is self-adjoint with respect to this inner product.”摘录准确。C：两份签名相同且作为修正版均PASS：正对角质量、β>0、C∞单位周期势；对象为归一Gibbs复L²上的实际部分线性算子，结论为完整IsSelfAdjoint。已展开光滑周期空间→L²嵌入→光滑域算子→实图闭包→由实际闭算子特征空间构成的复Hilbert基→最大复图。复图约束的是所有谱系数，并非只在原光滑域验证对称；归一权重的常数缩放不改变自伴关系。原书该句的前置对象是C₀²(μ̄β)，并先取M=I、γ=1；本条采用周期闭实现及正对角质量推广，是明确披露的域修正而非原C₀²域的逐字实现。[EXTRA]已要求人工确认，整条据此为NEEDS_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianClosedSelfAdjoint` | 已证 | — | PASS |
| `MD.Ch06.brownianClosedSelfAdjoint_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2303`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianCompactResolvent

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianCompactResolvent {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianCompactResolvent_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Lean仅覆盖紧环面Gibbs-L²闭实现的(1−L)⁻¹紧性；原文离散谱子句由条目7承接。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Gibbs复L²闭实现的(1−L)⁻¹；全部离散谱子结论另条保留，未从本条自动声称原C₀²域自伴。
- [EXTRA] 仅断言紧torus上的闭实现具有紧预解式；原一般C₀²措辞未覆盖，域与紧配置假设需人工签核。
- [ERRATUM?] 预解式必须属于明确的闭实现，不能仅以核心上的形式微分表达认定原域具有该预解式。
- [EXTRA] 复审范围：只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
- 覆盖缺口：原C₀²域及一般配置空间的解释待人工确认。
- 覆盖缺口：原句中的离散谱结论由BrownianDiscreteSpectrum及其eigenvalue补充声明另列。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：compact resolvent、引用[360]及随后可数离散特征值的原句准确。C：两份紧性签名作为周期闭实现的限定版均PASS。已展开D86–D91：实闭图上的shift为(x,y)↦x−y，逆映射后取第一坐标，所得确为(1−L)⁻¹；复预解式由实部、虚部分别作用该真实预解式并复线性化得到，不是一个仅名为resolvent的任意紧算子。正质量、β>0和紧配置环面是明确前提；没有将紧性本身假设进去。此条签名仅给预解式紧性，离散谱的对应条目为7。原页仍把性质归在C₀²函数空间上；与闭实现、紧配置假设之间的解释差别已在[EXTRA]要求签核，不能由本条自动认证原一般域表述。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianCompactResolvent` | 已证 | — | PASS |
| `MD.Ch06.brownianCompactResolvent_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2319`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianDiscreteSpectrum

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianDiscreteSpectrum {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ, z.im=0) ∧
  ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ={z} := by
  refine ⟨textbookBrownianGibbsGeneratorComplexSpectrum_countable m hm U hU hPU β hβ, ?_, ?_⟩
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_isolated m hm U hU hPU β hβ z hz

/-- 25号补全：每个谱点均为闭实现的特征值；尚缺完整谱理论桥接。 -/
theorem brownianDiscreteSpectrum_eigenvalue {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
      ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
        (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。
- [EXTRA] 全部谱结论针对正质量、β>0、C∞单位周期势的紧环面Gibbs复L²闭实现。
- [ERRATUM?] 原C₀²域与上述闭实现的对应关系承接条目6，仍需人工签核。
- [EXTRA] 复审范围：合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。
- 覆盖缺口：有限重数和无有限聚点的标准离散谱强化尚未单列。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：与条目6同一句原文，转录准确。C：两份签名分别PASS。主声明给出所定义复谱的可数性、虚部为零及每个谱点的开邻域孤立性；补充声明对每个谱点给出非零复L²向量及(v,z•v)在完整闭图中，准确表达它是特征值而非仅“谱点可数”。D92–D93的预解集要求有界复线性算子同时满足左右逆图关系，谱取其补集，未偷换成预先枚举的特征值集合。审校按两份声明合并覆盖原文的“countable collection of eigenvalues”，不因补充声明的sorry判FAIL。有限重数没有作为该两份签名的结论；不得把依赖中某定理的存在误计为这里显式列出的结论。整条仍承接条目6的原C₀²域/闭实现解释疑问。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianDiscreteSpectrum` | 已证 | — | PASS |
| `MD.Ch06.brownianDiscreteSpectrum_eigenvalue` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2334`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianSpectralGap

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> $\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianSpectralGap {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    z ≠ 0 → z.im=0 ∧ z.re ≤ -α := by
  refine ⟨textbookBrownianGibbsCoercivityRate m U hU hPU β,
    textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ, ?_⟩
  intro z hz hn
  exact ⟨textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz,
    textbookBrownianGibbsGeneratorComplexSpectrum_gap m hm U hU hPU β hβ z hn hz⟩
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]现成实际全闭谱；正谱隙从真实Poincaré常数得出，不把目标谱隙作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在统一α>0，对全复谱每个非零点同时给出虚部0和实部≤−α，未将谱隙作为假设；与原排除零特征值的陈述吻合。正质量、β>0、C∞周期及完整谱已明确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianSpectralGap` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2358`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-Theorem61

印刷p.250–251 / PDFp.271–272；§6.4.3。

### 1. 原文陈述

> Theorem 6.1 Define the generator of Brownian dynamics by
> \[\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.\]
> Suppose that $U$ is smooth with periodic boundary conditions $\mathcal Q=\mathbb T^{N_c}$ ($\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\mu_\beta)$ with inner product $\langle f,g\rangle_\beta$ as defined above, we have:
> 1. $\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\infty,0]$.
> 2. $\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
> \[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};\]
> for some positive $K$ and $\alpha$, where recall $\bar\varphi(t)$ denotes the time average of $\varphi$ defined in (5.6).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem61 :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.4.3-Theorem61；改动：明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。 -/
theorem theorem61_corrected :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 【限定摘录，非原域字面版】保留严格负定及(5.6)轨道时间平均的疑误，但算子为闭Gibbs复L²实现；不把另列质量表达式当成本声明的算子，不证明此版。 -/
theorem theorem61ClosedRealizationExcerpt :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  (∀ f : (Fin n → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube n)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω), textbookIsWienerVector B P →
    ∀ x : UnitAddTorus (Fin n), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
      ∀ f : textbookPeriodicSmoothSpace n, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
        |t⁻¹*(∫ s in (0 : ℝ)..t,
            textbookConfigurationTorusObservable f
              (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hp β hβ x B s sample)) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K*‖textbookPeriodicSmoothEmbedding U hU hp β f‖*Real.exp (-α*t) := by
  sorry

/-- 【原书疑误】在ΔM=Σmi∂ii这一记号解释下的条件性代数表达；原页记号尚待核定，不宣称它是整个原定理或Brownian过程生成元。 -/
def brownianMassGeneratorPrinted {n : ℕ} (m : Fin n → ℝ) (U f : (Fin n → ℝ) → ℝ)
    (β : ℝ) (x : Fin n → ℝ) : ℝ :=
  ∑ i, (-(m i)⁻¹*fderiv ℝ U x (Pi.single i 1)*fderiv ℝ f x (Pi.single i 1)+
    β⁻¹*m i*fderiv ℝ (fun y ↦ fderiv ℝ f y (Pi.single i 1)) x (Pi.single i 1))

/-- 修正版，Brownian扩散使用逆质量权重；实际生成元的表达式定义。 -/
noncomputable def brownianMassGeneratorPrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：主版与_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 主版与_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06_ERRATA。
- 覆盖缺口：原C₀²域及原ΔM生成元对应的整条字面形式化未提供；独立质量表达式不补足此联系。
- 覆盖缺口：严格负定与几乎处处轨道时间平均的固定指数界不作为成立结论。
- 覆盖缺口：本轮已目视核定印刷244/PDF265：ΔM=Σmi∂²/∂pi²。质量表达式注释中的“原页记号尚待核定”是复审时旧状态；核页不等于已建立原域/整条生成元联系。Theorem6.1的构型逆质量解释仍待导师。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：Theorem 6.1的生成元、三款结论及最后明确指向(5.6)的time average均准确转录；书中分布平均与轨道时间平均的冲突以及negative definite措辞须保留为原书疑误。C分版本：theorem61和theorem61_corrected作为限定修正版均PASS，包含完整闭自伴、全部复谱实且非正、可数、每点有非零图特征向量、孤立、非零谱隙及对所有非负归一L²相对初始密度的演化分布平均指数界。K、α在ρ之后、在所有f和t之前选择，量词正确；DensityLaw为真实Brownian核作用初始ρμβ，DensityAverage的分母在这些概率条件下为1。修正生成元的扩散和漂移均用逆质量，匹配给出的实际Brownian路径系数。theorem61Printed的严格负定及几乎处处轨道平均指数界保留了原文疑误，但它仍使用与corrected相同的闭复L²算子，而原文明确以C₀²(μβ)为域；其全部谱/自伴断言也未与另列的brownianMassGeneratorPrinted建立对象联系。因此该名字为Printed的整条声明不是原域及原生成元的字面实现，忠实性FAIL；这与原书数学错误本身的NEEDS_HUMAN及sorry无关。brownianMassGeneratorPrinted的代数表达与其注释一致，但附件没有印刷244页，无法据本附件独立确认ΔM在该页的既定含义，应保留记号歧义而不能假称已逐页核实。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
主版与_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem61` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem61_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem61ClosedRealizationExcerpt` | 未证 | 原书疑误不证 | 修复后未再送网站 |
| `MD.Ch06.brownianMassGeneratorPrinted` | 定义 | — | 修复后未再送网站 |
| `MD.Ch06.brownianMassGeneratorPrinted_corrected` | 定义 | — | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:2373`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-Theorem61TimeAveragePrinted

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> Theorem 6.1 Define the generator of Brownian dynamics by
> \[\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.\]
> Suppose that $U$ is smooth with periodic boundary conditions $\mathcal Q=\mathbb T^{N_c}$ ($\mathbb T^{N_c}$ an $N_c$-dimensional torus). Then, with respect to the space $C_0^2(\mu_\beta)$ with inner product $\langle f,g\rangle_\beta$ as defined above, we have:
> 1. $\mathcal L$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $(-\infty,0]$.
> 2. $\mathcal L$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $\sigma(\mathcal L)\subset(-\infty,-\alpha]$ for some $\alpha>0$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
> \[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};\]
> for some positive $K$ and $\alpha$, where recall $\bar\varphi(t)$ denotes the time average of $\varphi$ defined in (5.6).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem61TimeAveragePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
  ∀ x : UnitAddTorus (Fin Nc), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
    ∀ f : textbookPeriodicSmoothSpace Nc, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
      |t⁻¹*(∫ s in (0 : ℝ)..t,
          textbookConfigurationTorusObservable f
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) -
        (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
          K*‖textbookPeriodicSmoothEmbedding U hU hPU β f‖*Real.exp (-α*t) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Brownian全时torus过程、任意点初值、AE路径资格和t>0明确；原C∞紧支检验在紧torus周期表示。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。按Printed规则核查：任意点初值、K,α先于f与AE样本、全部t>0的轨道时间积分，确为原末句时间平均读法的明确化。AE资格是额外选择；原文本身与前句分布平均冲突且该指数路径界一般错误。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem61TimeAveragePrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2476`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianEnsembleExponential

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $\varphi$, we have
> \[|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianEnsembleExponential {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption

/-- 修正版，对应原文 MD-6.4.3-Theorem61TimeAveragePrinted；改动：选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。 -/
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]选择实际演化分布平均；真实Wiener/kernel和非负质量1的L²初始相对密度，所有光滑周期检验同时受界。范围限定不覆盖singular点初始law，不是原轨道时间平均证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Wiener驱动转移kernel推动非负质量1的L²相对密度；DensityAverage是总质量归一的演化分布平均，右侧Z⁻¹积分与torus Gibbs平均一致。K,α统一于所有光滑周期f与t≥0；归一范数与原范数的常数差可吸收进K。[EXTRA]明确非轨道平均及不含奇异初始law。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianEnsembleExponential` | 已证 | — | PASS |
| `MD.Ch06.theorem61TimeAveragePrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2492`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianNegativeDefinitePrinted

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> so that $\langle f,\mathcal Lf\rangle\le0$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianNegativeDefinitePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∀ f : (Fin Nc → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0 := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem brownianNegativeDefinitePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确严格负定含全部非零周期光滑L²函数的读法。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。Printed严格负定版准确编码任意非零周期光滑f的二次型<0；虽为假，按原文字面版规则不以不忠实判FAIL。已有[ERRATUM?]正确。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianNegativeDefinitePrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:2531`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-OUDensityPrinted

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> The solution $p(t)$ to the Ornstein-Uhlenbeck equation, for any finite time $t$, is always normally distributed
> \[\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}\]
> where
> \[\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-MolecularDynamics.Chapter06Review.ouMean γ x0 t)^2/(2*MolecularDynamics.Chapter06Review.ouVariance γ σ t))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]定义中使用通用噪声σ，取σ=√(2γkBTm)即6.45；t=0资格另记录。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Printed定义保留了原书未归一化指数。ouMean=exp(−γt)x0，ouVariance=σ_noise²(1−exp(−2γt))/(2γ)；取σ_noise²=2γkBTm就得到6.45。[EXTRA]已经说明参数转换。作为字面公式定义PASS，不把原书缺归一化或t=0问题算成该字面定义的签名错误。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouDensityPrinted` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2542`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-OUDensityCorrect

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> The solution $p(t)$ to the Ornstein-Uhlenbeck equation, for any finite time $t$, is always normally distributed
> \[\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}\]
> where
> \[\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)

/-- 修正版，对应原文 MD-6.4.2-OUDensityPrinted；改动：增加(2πσ²(t))⁻¹/²，并限γ>0、噪声非零、t>0的密度解释。 -/
def ouDensityPrinted_corrected (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]补归一化系数，正γ/温度/质量且t>0使用；仅实际密度公式定义，原OU严格law结论在§6.3.2保留，不计密度积分或过程law已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouDensity与ouDensityPrinted_corrected均用完整指数除以sqrt(2πv)，修正合理。γ>0、σ_noise≠0、t>0时v>0，得到通常正态密度；注释明确密度解释只在这一域成立。定义对全部实数全定义不意味着声称退化参数下也是密度；没有积分归一化或过程HasLaw定理可被误计为已证。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouDensity` | 定义 | — | PASS |
| `MD.Ch06.ouDensityPrinted_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2547`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption1Printed

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $C\in\mathcal B(D)$, the conditions:
> (i) For some $y\in\operatorname{int}(C)$, we have that for any $\delta>0$ there is a $t_0>0$ such that
> \[\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)>0,\quad\forall X_0\in C.\]
> (ii) For $t>0$, the transition kernel possesses a density $\widehat\rho(X,z,t)$ such that
> \[\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);\]
> and $\widehat\rho(X,z,t)$ is jointly continuous in $C\times C\times[0,\infty)$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption1Printed {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ici 0)
```

同问题的独立限定/修正版（位于另一条）：
```lean
def assumption1Printed_corrected {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Borel Markov kernel与局部参考测度；完整同一内点可达、全部初值与可测子集及联合连续资格。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。Printed保留紧C、同一内点y、δ后选统一t、全部x和可测A⊆C及联合连续时间Ici 0；与原[0,∞)一致。ν是披露的参考测度推广，但Kernel本身不含Markov/半群资格；此定义只编码局部条件。原零时连续性疑误保留。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption1Printed` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2558`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption1Correct

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $C\in\mathcal B(D)$, the conditions:
> (i) For some $y\in\operatorname{int}(C)$, we have that for any $\delta>0$ there is a $t_0>0$ such that
> \[\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)>0,\quad\forall X_0\in C.\]
> (ii) For $t>0$, the transition kernel possesses a density $\widehat\rho(X,z,t)$ such that
> \[\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);\]
> and $\widehat\rho(X,z,t)$ is jointly continuous in $C\times C\times[0,\infty)$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption1 {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)

/-- 修正版，对应原文 MD-6.4.4-Assumption1Printed；改动：联合连续性的时间域由[0,∞)改为(0,∞)。 -/
def assumption1Printed_corrected {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]联合连续域改为C×C×(0,∞)，正时刻实际密度与全部可达资格保留；只定义修正版，未计任何具体SDE已满足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。assumption1与assumption1Printed_corrected两定义一致，唯一实质修正为Ici 0→Ioi 0；密度公式仍仅正时、x∈C及可测A⊆C，内点可达量词未变。作为修正条件定义合理，不是具体SDE满足它的断言。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption1` | 定义 | — | PASS |
| `MD.Ch06.assumption1Printed_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2569`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption2

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 2 There is a function $\varphi:D\to(0,\infty)$, with $\varphi(X)\to\infty$ as $|X|\to\infty$ such that
> \[\mathcal L\varphi\le-\alpha\varphi+\delta\]
> for positive constants $\alpha$ and $\delta$, where $\mathcal L$ is the generator of the stochastic process (6.43). The function $\varphi$ is known as a Lyapunov function.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption2 {D : Type*} [TopologicalSpace D] (L : (D → ℝ) → D → ℝ)
    (φ : D → ℝ) (α δ : ℝ) : Prop :=
  (∀ x, 0 < φ x) ∧ Continuous φ ∧ (∀ R : ℝ, IsCompact {x | φ x ≤ R}) ∧
    0 < α ∧ 0 < δ ∧ ∀ x, L φ x ≤ -α*φ x+δ
local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]柱形相空间以真实compact sublevels表达趋无穷；连续正Lyapunov及正α/δ，未把Harris结论藏进定义。具体generator域资格在对应命题明确。

### 6. 审计结论（含网站结论）

网站原返回：PASS。φ处处严格正、连续、所有实数水平的次水平集紧，α,δ>0及逐点漂移不等式完整。在欧氏/torus×欧氏常用状态空间上，这是披露的proper Lyapunov解释；一般拓扑上仅是所选推广。L的域资格未由该定义提供。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption2` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2590`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-MinorizationPrinted

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem minorizationPrinted : ∀ {S : Type*} [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (ν : Measure S) (K : ℝ≥0 → Kernel S S) (C : Set S),
  MolecularDynamics.Chapter06Review.assumption1Printed ν K C ↔
    ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure S,
      IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem minorizationPrinted_corrected :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。Printed将tantamount忠实读为↔，右侧给一个正时刻、正ENNReal下界系数和同一概率μ，对全部x∈C作完整测度序下界。左侧仍为原零时连续版；抽象签名没有SDE或Markov半群假设，等价一般错误。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.minorizationPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:2599`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-MinorizationCorrectedImplication

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem minorizationCorrectedImplication :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-MinorizationPrinted；改动：只保留在明确正时刻密度、可达性条件下到小集下界的充分方向。 -/
theorem minorizationPrinted_corrected :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 只覆盖加强假设下由Assumption 1到共同小集下界的充分方向；不覆盖原tantamount所可能表示的必要方向。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 主版与minorizationPrinted_corrected同时补Chapman–Kolmogorov/Markov半群及参考测度全支撑。两步核局部共同下界仍需大型小集理论，未证明、未宣称数学结论已核定；审阅结论按各版本分别记录。
- [EXTRA] 还独立假设：对所有t>0、所有x及所有非空开集A，K t x A>0；这比原Assumption 1(i)强，不能省略于假设说明。
- [EXTRA] assumption1中的密度联合连续性只在t>0要求；原书写到t=0的端点问题另见条目10、14。
- [EXTRA] 复审范围：仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
- 覆盖缺口：未声明或认证minorization反推原Assumption 1的必要方向。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：关于“tantamount”及small sets的两句原文准确。C：两份声明签名相同，作为明确加强前提的充分方向均PASS。逐项包含实际概率核半群/Chapman–Kolmogorov、参考测度对所有非空开集为正、紧C及其内点可达条件、仅正时刻在C×C上联合连续的实非负密度；此外还另行假设所有点、所有正时刻对每个非空开集都有正概率。这一全局开放集可达性是实质性加强，不能由原Assumption 1(i)的固定内点可达性直接冒充。结论的时间、ε>0及概率μ先于所有x∈C选择，测度序ε•μ≤K t x正是共同小集下界；ε不必额外假设≤1，因为K t x和μ为概率。连续局部密度、紧性和真实核合成足以支持此加强版的共同下界；未以sorry是否消除作为签名判据。这里只认证充分方向，未把原文“tantamount”解读为已经认证了必要方向。JSON须补记遗漏的全局可达前提。
当前处理：网站PASS（复审）。
仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.minorizationCorrectedImplication` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.minorizationPrinted_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2608`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Theorem62

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Theorem 6.2 (Geometric Ergodicity) Let the solution to (6.43) be denoted $X(t)$. If Assumption 1 and Assumption 2 are satisfied for
> \[C=\{X\in D\mid\varphi(X)\le K_{\alpha,\delta}\},\]
> where $K_{\alpha,\delta}$ is a particular positive value depending on $\alpha$ and $\delta$, then
> (i) there exists a unique invariant measure $\rho_*$, with $\mathcal L^*\rho_*=0$, and
> (ii) there exist positive constants $\kappa$ and $\lambda$ such that for all suitable functions $f$ with $|f|\le\varphi$,
> \[|e^{t\mathcal L}f(X_0)-\operatorname{Av}(f)|\le \kappa e^{-\lambda t}\varphi(X_0);\tag{6.48}\]
> where $\operatorname{Av}(f)=\int_D f(z)\rho_*(z)dz$ is the spatial average.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem62 :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    (∀ (t : ℝ≥0) (x : D), Integrable φ (K t x) ∧
      MolecularDynamics.Chapter06Review.kernelAverage K φ t x ≤
        Real.exp (-α*(t : ℝ))*φ x+δ/α) →
    MolecularDynamics.Chapter06Review.assumption1 ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-Theorem62；改动：明示实际Markov/Feller演化、正确正时刻密度、generator联系和先于过程选择的阈值；整条仍未证明。 -/
theorem theorem62_corrected :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    (∀ (t : ℝ≥0) (x : D), Integrable φ (K t x) ∧
      MolecularDynamics.Chapter06Review.kernelAverage K φ t x ≤
        Real.exp (-α*(t : ℝ))*φ x+δ/α) →
    MolecularDynamics.Chapter06Review.assumption1 ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry

/-- 【原书疑误】采用印刷Assumption1的版本；技术量词仍显式保留，不证。 -/
theorem theorem62Printed :
  ∃ threshold : ℝ → ℝ → ℝ,
    (∀ α δ : ℝ, 0 < α → 0 < δ → 0 < threshold α δ) ∧
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D] [CompleteSpace D] [SecondCountableTopology D] [LocallyCompactSpace D]
    (ν : Measure D) [SigmaFinite ν] (K : ℝ≥0 → Kernel D D), MolecularDynamics.Chapter06Review.markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (MolecularDynamics.Chapter06Review.kernelAverage K f t)) →
  (∀ t : ℝ≥0, 0 < t → ∀ x : D, ∃ density : D → ℝ,
    Measurable density ∧ (∀ z, 0 ≤ density z) ∧
      K t x = ν.withDensity (fun z ↦ ENNReal.ofReal (density z))) →
  ∀ (φ : D → ℝ) (α δ : ℝ), MolecularDynamics.Chapter06Review.assumption2 (MolecularDynamics.Chapter06Review.kernelGenerator K) φ α δ →
    MolecularDynamics.Chapter06Review.assumption1Printed ν K {x | φ x ≤ threshold α δ} →
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ MolecularDynamics.Chapter06Review.invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → MolecularDynamics.Chapter06Review.invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        (∀ x, HasDerivWithinAt
          (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
          (MolecularDynamics.Chapter06Review.kernelGenerator K f x) (Ici 0) 0) →
        (∃ ε : ℝ, 0 < ε ∧ ∃ bound : D → ℝ, Integrable bound μ ∧
          ∀ t ∈ Ioo (0 : ℝ) ε, ∀ x,
            |(MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x-f x)/t| ≤ bound x) →
        Integrable (MolecularDynamics.Chapter06Review.kernelGenerator K f) μ → (∫ x, MolecularDynamics.Chapter06Review.kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |MolecularDynamics.Chapter06Review.kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06_ERRATA。
- 覆盖缺口：原Assumption 1(ii)在t=0要求连续密度的疑误保留；Printed含明确的实际生成元测试资格，并非无技术前提的整条字面翻译。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：节号、页码、阈值集合、唯一不变测度、弱平稳意图、加权指数界及空间平均均核对；原页的正系数为κ，JSON两处写为k，应作转录纠正，其余原文数学措辞保留。C：theorem62及corrected作为加强的半群版本，签名PASS：阈值函数先于状态空间、过程及φ量化；完整Markov/Feller、局部紧Polish状态、σ有限ν、每个正时刻全部初值的绝对连续性；φ正连续且子水平紧，α、δ正；另有实际积分可积性和半群漂移估计；结论保留全部不变概率的唯一性、相对于ν的密度、受真实右导数及局部可积差商支配限制的弱平稳检验，以及统一于所有可测|f|≤φ、t≥0、x的指数界。没有把不变性或收敛结论作假设，也没有把有限个检验或单一初态替代全部量词。Printed保留[0,∞)连续密度的原书疑误，这一点本身应NEEDS_HUMAN；但其弱平稳分句量化所有有界连续f，仅假设kernelGenerator f可积，没有要求该f存在真实右导数/属于生成元测试域。D中kernelGenerator是总定义的derivWithin，不能把其无导数时的默认值当成原书实际SDE生成元。该超出原生成元域的Printed弱平稳断言不属于原书字面陈述，忠实性FAIL。主版新增的测试域保护没有在Printed中保留，这一偏差不是sorry问题，也不能全标成原书疑误。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
原文两处k按网站逐页核对改回κ（转录纠正）。Printed的弱平稳测试补主版同样的真实右导数及局部可积差商支配，排除derivWithin默认值；保留原[0,∞)连续密度端点疑误，阈值统一性和全部结论量词不变。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem62` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem62_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem62Printed` | 未证 | 原书疑误不证 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:2636`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-PeriodicPotentialBound

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> We also consider the potential energy to be smooth ($C^\infty$) with $U(q)\to\infty$ as $|q|\to\infty$. As we have a smooth potential on a bounded (position) domain, we have
> \[1<U_{\min}\le U(q)\le U_{\max}<\infty,\quad\forall q\in\mathcal Q,\]
> for some constants $U_{\min}$ and $U_{\max}$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem periodicPotentialBound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M := by
  apply MolecularDynamics.textbookUnitPeriodicPotential_bound <;> assumption

/-- 修正版，对应原文 MD-6.4.4-PeriodicPotentialBound；改动：保留周期势有界结论；正下界通过加常数归一单独实现。 -/
theorem periodicPotentialBound_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M := by
  apply MolecularDynamics.textbookUnitPeriodicPotential_bound <;> assumption

/-- 【原书疑误】光滑周期势本身不能推出印刷的严格正下界；不证。 -/
theorem periodicPotentialBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
    ContDiff ℝ ∞ U → textbookUnitPeriodicPotential U →
    ∃ Umin Umax : ℝ, 1 < Umin ∧ ∀ q, Umin ≤ U q ∧ U q ≤ Umax := by
  sorry

/-- 零势的下界不可能严格大于1。 -/
theorem periodicPotentialBoundPrinted_counterexample :
    ¬ (∃ Umin Umax : ℝ, 1 < Umin ∧ ∀ q : Fin 1 → ℝ,
      Umin ≤ (fun _ ↦ (0 : ℝ)) q ∧ (fun _ ↦ (0 : ℝ)) q ≤ Umax) := by
  rintro ⟨Umin,Umax,hmin,hbound⟩
  have hzero := (hbound 0).1
  dsimp only at hzero
  linarith
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整全域有限范数界，给上下界±M；正下界>1需实际势能平移，另条给出。原周期与q→∞围束资格冲突另留字面记录，不由本条消去。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。连续周期势全域有界的签名正确，M≥0的范数界给−M≤U≤M。它未包含原1<Umin；该要求由下一条平移解释而非本条证明。原文同时要求周期与配置无穷远围束，本条[ERRATUM?]正确保留。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicPotentialBound` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.periodicPotentialBound_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.periodicPotentialBoundPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |
| `MD.Ch06.periodicPotentialBoundPrinted_counterexample` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2735`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-PotentialNormalization

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> We also consider the potential energy to be smooth ($C^\infty$) with $U(q)\to\infty$ as $|q|\to\infty$. As we have a smooth potential on a bounded (position) domain, we have
> \[1<U_{\min}\le U(q)\le U_{\max}<\infty,\quad\forall q\in\mathcal Q,\]
> for some constants $U_{\min}$ and $U_{\max}$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem potentialNormalization {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Continuous U) (hp : textbookUnitPeriodicPotential U) :
  ∃ c : ℝ, (∀ q, 1 < U q+c) ∧
    textbookPotentialForce (fun q ↦ U q+c)=textbookPotentialForce U := by
  obtain ⟨c,hc⟩ := textbookUnitPeriodicPotential_normalization U hU hp
  refine ⟨c+1, ?_, textbookPotentialForce_add_const U (c+1)⟩
  intro q
  linarith [hc q]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]将Umin>1解释为实际加常数归一；严格>1与真实力不变全部保留，而非直接假定任何原势已大于1。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在单一c使所有q严格U(q)+c>1，且真实fderiv所定义势能力作为函数相等。连续周期已足以给有限下界，导数总定义对加常数保持相同，故不需额外假设原势处处可微。此为[EXTRA]明确的归一解释。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.potentialNormalization` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2763`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-UnitLangevinModel

印刷p.251 / PDFp.272；§6.4.4。

### 1. 原文陈述

> In Langevin dynamics, taking $M=I$ for simplicity,
> \[dq=pdt;\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}dW;\tag{6.47}\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def unitLangevinModel {n : ℕ} {A : Type*} [MeasurableSpace A] (P : Measure A)
    (W : ℝ → A → (Fin n → ℝ)) (X : ℝ → A → ((Fin n → ℝ) × (Fin n → ℝ)))
    (U : (Fin n → ℝ) → ℝ) (γ β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  0 < β ∧ ContDiff ℝ ∞ U ∧ MD.Ch06.langevinMassSDE P W X (fun _ ↦ 1) U γ β⁻¹ x0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实单位质量完整耦合路径方程；β>0及光滑势保证原梯度存在，γ>0由实际MassLangevin资格保留。Wiener law在对应定理另给，不宣称任意W是Wiener。

### 6. 审计结论（含网站结论）

网站原返回：PASS。展开langevinMassSDE后有正γ、正温度β⁻¹、单位质量、完整两分量积分方程、AE连续/可积资格以及textbookIsWienerVector。故σ=√(2γβ⁻¹)、dq=pdt均正确。元数据说Wiener law另给与实际定义不符，须纠正。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.unitLangevinModel` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2774`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-PeriodicConfiningPrinted

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> The whole phase space is $D=\mathbb T^{N_c}\times\mathbb R^{N_c}$. We also consider the potential energy to be smooth ($C^\infty$) with $U(q)\to\infty$ as $|q|\to\infty$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def periodicConfiningPrinted {n : ℕ} (_hn : 0 < n) (U : (Fin n → ℝ) → ℝ) : Prop :=
  ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
    Tendsto U (cocompact (Fin n → ℝ)) atTop
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem periodicConfiningPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际正维单位周期lift，cocompact表达配置无穷远；不是动量Hamiltonian的围束。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。Printed对正维欧氏lift同时要求C∞、整数平移周期、cocompact处趋∞，确实忠实表达原矛盾资格；hn排除零维真空情况。不应要求构造满足它的势。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.periodicConfiningPrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:2783`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPower

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> For the Lyapunov condition (Assumption 2), we choose the Lyapunov function
> \[\varphi(q,p)=H^l(q,p)=\left[\tfrac12\|p\|^2+U(q)\right]^l;\]
> for a fixed positive integer $l$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def hamiltonianPower {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (_hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) : ℝ := textbookLangevinHamiltonian U z ^ l
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]l≥1编码，真实单位质量Hamiltonian，未把形式jet当真实函数；正性与柱形proper在后续实际桥接证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实相空间为两个Fin Nc→ℝ之积，Hamiltonian为坐标平方和/2+U；l:ℕ及1≤l表达固定正整数。定义只给候选函数，不断言它无条件满足全部Assumption2。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPower` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2789`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerCancellation

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> we can see that
> \[p\cdot\nabla_q\varphi-\nabla U(q)\cdot\nabla_p\varphi=\mathcal L_H\varphi=0;\]
> where $\mathcal L_H$ is the Lie derivative of our original Hamiltonian system (which preserves all functions of the Hamiltonian).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerCancellation {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Differentiable ℝ U) (l : ℕ) (_hl : 1 ≤ l) (z : textbookLangevinPhase n) :
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
    (z+t • textbookLangevinDrift U 0 z)) 0 0 := by
  simpa using textbookLangevinHamiltonianPower_drift_hasDerivAt U hU (0 : ℝ) l z
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际沿Hamiltonian方向的真实导数为0；γ=0只在此Hamiltonian部分，非把整个物理Langevin摩擦设零。

### 6. 审计结论（含网站结论）

网站原返回：PASS。γ=0时真实drift=(p,−∇U)，HasDerivAt对直线z+t drift在t=0给导数0，正是Lie方向导数；不是声称直线轨道的Hamiltonian在所有t常值。全域Differentiable U足以给链式法则，l≥1。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerCancellation` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2794`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerMomentumDerivative

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> Using $\|p\|^2<2H$, we compute derivatives to find
> \[p\cdot\nabla_p\varphi=lH^{l-1}\|p\|^2=2l\varphi-2lH^{l-1}U(q).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerMomentumDerivative : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (l : ℕ) (z : textbookLangevinPhase n), 1 ≤ l →
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z.1,(1+t) • z.2))
    ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2)) 0 ∧
  (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2) =
    2*(l : ℝ)*textbookLangevinHamiltonianPower U l z -
      2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1 := by
  intro n U l z hl
  let S : ℝ := ∑ i, z.2 i^2
  have he : ∀ t : ℝ, textbookLangevinHamiltonian U (z.1,(1+t) • z.2)=
      (1+t)^2*S/2+U z.1 := by
    intro t
    simp only [textbookLangevinHamiltonian, Pi.smul_apply, smul_eq_mul, mul_pow,
      ← Finset.mul_sum]
    rfl
  have hd : HasDerivAt (fun t : ℝ ↦ ((1+t)^2*S/2+U z.1)^l)
      ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S) 0 := by
    convert! (((((hasDerivAt_id (0 : ℝ)).const_add 1).pow 2).mul_const S).div_const 2 |>.add_const (U z.1)).pow l using 1 <;>
      simp [textbookLangevinHamiltonian, S] <;> ring
  constructor
  · simpa only [textbookLangevinHamiltonianPower, he] using hd
  · change (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S=
      2*(l : ℝ)*textbookLangevinHamiltonian U z^l-
        2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1
    rw [show textbookLangevinHamiltonian U z^l=
      textbookLangevinHamiltonian U z^(l-1)*textbookLangevinHamiltonian U z by
      rw [← pow_succ, Nat.sub_add_cancel hl]]
    dsimp [textbookLangevinHamiltonian, S]
    ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实沿动量p方向的导数及全部两个表达式，不仅登记事先给定的导数值；实际所有坐标平方和。

### 6. 审计结论（含网站结论）

网站原返回：PASS。动量曲线(1+t)p在t=0的切向量为p，HasDerivAt给实际p·∇p H^l；第二合取保留2lH^l−2lH^(l−1)U的完整恒等式。U仅在固定q取值，故动量导数不需U光滑，l=1及H=0亦成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerMomentumDerivative` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2802`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerMomentumLaplacian

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> \[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerMomentumLaplacian {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) =
      (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (∑ i, z.2 i ^ 2) +
        (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian <;> assumption
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem laplacianBoundCorrect {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption

/-- 修正版，对应原文 MD-6.4.4-LaplacianBoundPrinted；改动：系数l(l+Nc−1)改为2l(l−1)+Nc·l。 -/
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原印刷等式及错误上界均保留。目标主声明只给精确等式；随包关联声明laplacianBoundPrinted和laplacianBoundCorrect分别作字面忠实性与修正正确性审校。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证精确Laplacian等式；原错误上界Printed与修正系数分别由MD-6.4.4-LaplacianBoundPrinted/LaplacianBoundCorrect保存，不能把等式视为已覆盖原印刷不等式。
- [ERRATUM?] 原上界缺少由‖p‖²<2H产生的因子2；正确的统一系数为2l(l−1)+Ncl。
- [EXTRA] 复审范围：精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。
- 覆盖缺口：Printed上界存在明确反例，不能被视为已成立；上界修正须人工认可。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：原页的动量Laplacian精确等式和上界系数l(l+Nc−1)均准确转录，应保留原错误系数作疑误。C分版本：hamiltonianPowerMomentumLaplacian为PASS；相空间两分量确为(q,p)，H=Σpᵢ²/2+U(q)，沿(0,eᵢ)作两次一元导数再求和，结论是完整精确等式。l为正自然数；l=1时(l−2)的自然数截断无害，因为前系数l(l−1)=0；对任意U也合理，因为只对动量微分。附带给出的laplacianBoundPrinted忠实保留原上界，但该不等式错误，应NEEDS_HUMAN而非因数学错误将字面忠实版判FAIL。laplacianBoundCorrect的系数2l(l−1)+Ncl，在U≥1前提下是正确上界，签名PASS。JSON现称上界“不属于本条”，但本包又列出了两份上界声明；应明确它们是随包核对的关联声明，不能只审等式后声称原不等式已成立。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
精确等式与修正版上界2l(l−1)+Ncl获PASS；随包原上界l(l+Nc−1)保留疑误，三者分别登记。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerMomentumLaplacian` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2834`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LaplacianBoundPrinted

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> \[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem laplacianBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
  (∀ q, 1 ≤ U q) → ∀ (l : ℕ), 1 ≤ l → ∀ z : textbookLangevinPhase n,
    (∑ i : Fin n, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z+t • ((0 : Fin n → ℝ), Pi.single i 1)))) 0) ≤
      (l : ℝ)*((l : ℝ)+(n : ℝ)-1)*textbookLangevinHamiltonian U z^(l-1) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem laplacianBoundPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有_corrected完整签名，不从repair_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。原字面上界的量词n、U≥1、l≥1、全部相点及系数l(l+n−1)忠实；原数学断言错误，按要求保留而不把原书错误算作转录失败。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.laplacianBoundPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:2845`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LaplacianBoundCounterexample

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> \[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem laplacianBoundCounterexample :
    deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 = 52 ∧
      ¬ deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 ≤
        (2 : ℝ) * (2 + 1 - 1) * (4 ^ 2 / 2 + 2) ^ (2 - 1 : ℕ) := by
  apply MolecularDynamics.textbookLangevinLyapunov_printed_laplacian_bound_counterexample <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]现成具体n=1、U=2、l=2、p=4反例52>40；仅差异证据，未用它替代原全量词界或完整Lyapunov论证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实一元二阶导数在p=4等于52，右侧40；n=1、U=2、l=2均由公式固定。[EXTRA]正确说明它仅是反例，不能替代全量词界。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.laplacianBoundCounterexample` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2854`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-HamiltonianPowerGenerator

印刷p.253–254 / PDFp.274–275；§6.4.4。

### 1. 原文陈述

> Computing the generator of Langevin dynamics as
> \[\mathcal L_{LD}f=p\cdot\nabla_qf-\nabla U(q)\cdot\nabla_pf-\gamma p\cdot\nabla_pf+\gamma k_BT\Delta_p\varphi,\]
> we can see that $\mathcal L_H\varphi=0$. Hence
> \[\mathcal L_{LD}\varphi=-\gamma p\cdot\nabla_p\varphi+\gamma k_BT\Delta_p\varphi.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem hamiltonianPowerGenerator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z =
      -γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2) +
        σ ^ 2 / 2 * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) *
          (∑ i, z.2 i ^ 2) + (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1)) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_differentialOperator <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际全坐标一二阶导数与完整H^l，现成通用σ算子取σ=√(2γkBT)使σ²/2=γkBT；不是给定目标导数再改写。物理热参数代入在下一完整Lyapunov桥接实际出现。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D1–D5给出真实H、H^l、力和全相空间方向导数算子；hU仅一阶可微已足够，动量二阶导数来自多项式。l=1时(l−1)系数为零，Nat截断l−2无误；σ²/2保留通用参数，物理代入已明确标注。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.hamiltonianPowerGenerator` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2862`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LaplacianBoundCorrect

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> \[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem laplacianBoundCorrect {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption

/-- 修正版，对应原文 MD-6.4.4-LaplacianBoundPrinted；改动：系数l(l+Nc−1)改为2l(l−1)+Nc·l。 -/
theorem laplacianBoundPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  apply MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]修正上界系数为2l(l−1)+Nc l；原错误l(l+Nc−1)另列NEEDS，未静默更换JSON原句。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐坐标动量二阶导数总和，n与l全量词，U≥1确保H≥1。由∑p_i²≤2H得正确系数2l(l−1)+nl；l=1也成立。[EXTRA]已明确这是勘误版。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.laplacianBoundCorrect` | 已证 | — | PASS |
| `MD.Ch06.laplacianBoundPrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2873`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LyapunovYoungBounds

印刷p.253 / PDFp.274；§6.4.4。

### 1. 原文陈述

> As $H^l$ grows faster than $H^{l-1}$, for any fixed $l$ we are able to find positive constants $c$ and $d$ such that
> \[l(l+N_c-1)H^{l-1}\le\tfrac l2H^l+c;\qquad 2lH^{l-1}U(q)<2lH^{l-1}U_{\max}\le\tfrac l2H^l+d.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lyapunovYoungBounds : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) := by
  intro l n Umax hl hU
  have hlpos : (0 : ℝ) < l := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hl)
  let A1 : ℝ := (l : ℝ)*((l : ℝ)+(n : ℝ)-1)
  let A2 : ℝ := 2*(l : ℝ)*Umax
  let A3 : ℝ := 2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l
  let A : ℝ := max 0 (max A1 (max A2 A3))
  let ε : ℝ := (l : ℝ)/2
  have hε : 0 < ε := by dsimp [ε]; positivity
  have hA : 0 ≤ A := le_max_left _ _
  let M : ℝ := max 1 (A/ε)
  have hM : 0 ≤ M := le_trans zero_le_one (le_max_left _ _)
  have hAM : A ≤ ε*M := by
    have hd : A/ε ≤ M := le_max_right _ _
    simpa only [mul_comm] using (div_le_iff₀ hε).mp hd
  let C : ℝ := A*M^(l-1)+1
  have hC : 0 < C := by dsimp [C]; positivity
  have hbound : ∀ H : ℝ, 1 ≤ H → A*H^(l-1) ≤ ε*H^l+C := by
    intro H hH
    have hH0 : 0 ≤ H := le_trans zero_le_one hH
    by_cases h : M ≤ H
    · have hAH := hAM.trans (mul_le_mul_of_nonneg_left h hε.le)
      calc
        _ ≤ (ε*H)*H^(l-1) := mul_le_mul_of_nonneg_right hAH (pow_nonneg hH0 _)
        _ = ε*(H^(l-1)*H) := by ring
        _ = ε*H^l := by rw [← pow_succ, Nat.sub_add_cancel hl]
        _ ≤ ε*H^l+C := le_add_of_nonneg_right hC.le
    · have hpow := pow_le_pow_left₀ hH0 (le_of_lt (lt_of_not_ge h)) (l-1)
      have hb := mul_le_mul_of_nonneg_left hpow hA
      have hp : 0 ≤ ε*H^l := mul_nonneg hε.le (pow_nonneg hH0 _)
      dsimp [C]
      linarith
  have h1 : A1 ≤ A := (le_max_left _ _).trans (le_max_right _ _)
  have h2 : A2 ≤ A := (le_max_left _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  have h3 : A3 ≤ A := (le_max_right _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  refine ⟨C,C,hC,hC,fun H hH ↦ ?_⟩
  have hp : 0 ≤ H^(l-1) := pow_nonneg (le_trans zero_le_one hH) _
  exact ⟨(mul_le_mul_of_nonneg_right h1 hp).trans (hbound H hH),
    (by simpa only [A2, mul_assoc, mul_left_comm, mul_comm] using (mul_le_mul_of_nonneg_right h2 hp).trans (hbound H hH)),
    (mul_le_mul_of_nonneg_right h3 hp).trans (hbound H hH)⟩

/-- 修正版，对应原文 MD-6.4.4-LyapunovYoungBounds；改动：采用非严格上界，并列原有效标量界和正确Laplacian系数所需界；若另选严格外上界才可写原严格号。 -/
theorem lyapunovYoungBounds_corrected :
  ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H → ∀ Uq : ℝ, Uq ≤ Umax →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Uq ≤ 2*(l : ℝ)*H^(l-1)*Umax) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) := by
  intro l n Umax hl hU
  obtain ⟨c,d,hc,hd,hbounds⟩ := lyapunovYoungBounds l n Umax hl hU
  refine ⟨c,d,hc,hd,?_⟩
  intro H hH Uq hUq
  have hH0 : 0 ≤ H := le_trans zero_le_one hH
  have hb := hbounds H hH
  exact ⟨hb.1,mul_le_mul_of_nonneg_left hUq (by positivity),hb.2.1,hb.2.2⟩

/-- 【原书疑误】保留印刷严格中间不等号，仅有Uq≤Umax时不证明此版。 -/
theorem lyapunovYoungBoundsPrinted : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H → ∀ Uq : ℝ, Uq ≤ Umax →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Uq < 2*(l : ℝ)*H^(l-1)*Umax) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) := by
  sorry

theorem lyapunovYoungBoundsPrinted_counterexample :
    ¬ (2*(1 : ℝ)*1^(1-1)*1 < 2*(1 : ℝ)*1^(1-1)*1) := by
  norm_num
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整同时覆盖原两个标量界与修正系数界，常数可依赖l/n/Umax但不依赖H；H≥1来自已归一物理势。原U(q)<Umax一环需选择严格外界，本条没有从≤假推出<。

### 6. 审计结论（含网站结论）

网站原返回：PASS。量词顺序正确：c,d依赖l,n,Umax，独立于所有H≥1；正性、两条原有效非严格标量界及修正系数界同时覆盖。未编码U(q)的严格不等式，已在EXTRA/ERRATUM?说明是修正版；应保留该范围说明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lyapunovYoungBounds` | 已证 | — | PASS |
| `MD.Ch06.lyapunovYoungBounds_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.lyapunovYoungBoundsPrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |
| `MD.Ch06.lyapunovYoungBoundsPrinted_counterexample` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2893`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinLyapunov

印刷p.253–254 / PDFp.274–275；§6.4.4。

### 1. 原文陈述

> giving
> \[\mathcal L_{LD}\varphi\le-2\gamma l\varphi+2\gamma lH^{l-1}U(q)+\gamma l(l+N_c-1)H^{l-1}
> \le-\gamma l\varphi+\gamma c+\gamma d
> \le-\alpha\varphi+\delta,\]
> satisfying Assumption 2. The purpose of using the $l$ exponent in the Lyapunov function is to ensure that we can apply the theorem to a wide enough class of observables, as (6.48) is only valid for functions $f$ with magnitude less than or equal to the Lyapunov function.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinLyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption

/-- 修正版，对应原文 MD-6.4.4-PeriodicConfiningPrinted；改动：围束对象改为环面×动量空间上的Hamiltonian幂；无穷远只涉及动量方向。 -/
theorem periodicConfiningPrinted_corrected {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  apply MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际单位质量周期模型、归一U≥1、γ/β>0及l≥1；完整正性/紧子水平集/无穷远proper/正δ全域线性恢复界，采用真实更正系数2。原证明计算的错系数仍按原句保留；不是整个Thm6.2或canonical invariance桥接。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际周期相空间、正γ和β、归一U≥1、l≥1、热系数恒等式、正性、全部子水平紧性、cocompact无穷远增长以及全域漂移界均完整。δ位于z之前；γl>0。结论为合理修正版，未声称证明原错误中间链。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinLyapunov` | 已证 | — | PASS |
| `MD.Ch06.periodicConfiningPrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2968`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LieBracket

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> The Lie bracket of a pair of vector fields $u(z),v(z)$ is another vector field
> \[[u,v]=v'u-u'v;\]
> where $u'$ is the Jacobian matrix of the vector field $u$. In coordinates, if we let $w=[u,v]$, then the coordinates of $w$ are
> \[w_i=\sum_{j=1}^m\left(\frac{\partial v_i}{\partial z_j}u_j-\frac{\partial u_i}{\partial z_j}v_j\right).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def lieBracket {n : ℕ} (D : Set (Fin n → ℝ)) (_hD : IsOpen D)
    (u v : (Fin n → ℝ) → (Fin n → ℝ)) (_hu : ContDiffOn ℝ 1 u D)
    (_hv : ContDiffOn ℝ 1 v D) (x : D) : (Fin n → ℝ) :=
  MolecularDynamics.Chapter06Review.lieBracket u v x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Fréchet导数括号，具体性质/迭代均要求适当可微字段；其通用辅助函数的非可微总化值不作经典Jacobian解释。有限坐标式由真实fderiv在basis上取分量。
- [EXTRA]实际字段仅需原开域内C¹，输出点属于D，非可微/域外的总化fderiv值不作为经典Jacobian。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D36连接标准VectorField.lieBracket，符号为Dv·u−Du·v；D开、x∈D及域内C¹保证真实局部导数。坐标表达可由基展开得到，未把域外总化值作经典导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lieBracket` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3000`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LieBracketProperties

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> The Lie bracket is a bilinear and skew-symmetric operation:
> • $[\alpha u+\beta v,w]=\alpha[u,w]+\beta[v,w]$,
> • $[u,v]=-[v,u]$ and $[u,u]=0$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lieBracketProperties : ∀ {n : ℕ} (u v w : (Fin n → ℝ) → (Fin n → ℝ)) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (MolecularDynamics.Chapter06Review.lieBracket (fun x ↦ a • u x+b • v x) w =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u w x+b • MolecularDynamics.Chapter06Review.lieBracket v w x) ∧
  (MolecularDynamics.Chapter06Review.lieBracket u (fun x ↦ a • v x+b • w x) =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u v x+b • MolecularDynamics.Chapter06Review.lieBracket u w x) ∧
  MolecularDynamics.Chapter06Review.lieBracket u v = -MolecularDynamics.Chapter06Review.lieBracket v u ∧
  MolecularDynamics.Chapter06Review.lieBracket u u=0 := by
  intro n u v w a b hu hv hw
  have hb : ∀ (u v : (Fin n → ℝ) → (Fin n → ℝ)),
      MolecularDynamics.Chapter06Review.lieBracket u v=VectorField.lieBracket ℝ u v :=
    fun u v ↦ rfl
  simp_rw [hb]
  refine ⟨?_,?_,?_,?_⟩
  · funext x
    change VectorField.lieBracket ℝ (a • u+b • v) w x = _
    rw [VectorField.lieBracket_add_left ((hu x).const_smul a) ((hv x).const_smul b),
      VectorField.lieBracket_const_smul_left (hu x),
      VectorField.lieBracket_const_smul_left (hv x)]
  · funext x
    change VectorField.lieBracket ℝ u (a • v+b • w) x = _
    rw [VectorField.lieBracket_add_right ((hv x).const_smul a) ((hw x).const_smul b),
      VectorField.lieBracket_const_smul_right (hv x),
      VectorField.lieBracket_const_smul_right (hw x)]
  · funext x
    exact VectorField.lieBracket_swap
  · exact VectorField.lieBracket_self
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部双槽线性、skew及自身零明确，真实全域可微资格；不只保存某一固定字段或单槽例子。

### 6. 审计结论（含网站结论）

网站原返回：PASS。两槽所有实线性组合、反对称、自括号零同时给出，字段全局可微确保导数线性；全局版本为已标注技术范围。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lieBracketProperties` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3007`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Definition61

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> Definition 6.1 (Hörmander's Condition) Let $U\subset\mathbb R^m$ be open. The SDE (6.43) with $C^\infty$ vector fields $b_0,b_1,\ldots,b_r:U\to\mathbb R^m$ are said to satisfy Hörmander's condition at $z\in U$ if the vector space spanned by the collection of iterated Lie brackets
> \[b_0,b_1,\ldots,b_r,[b_0,b_1],[b_0,b_2],\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\ldots\]
> (evaluated at $z$) is $\mathbb R^m$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def definition61 {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x

/-- 修正版，对应原文 MD-6.4.4-Definition61；改动：用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。 -/
def parabolicNoiseBracketLevels {m S : ℕ}
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) : ℕ → Set ((Fin m → ℝ) → (Fin m → ℝ))
  | 0 => Set.range (fun i : Fin S ↦ b i.succ)
  | k+1 => parabolicNoiseBracketLevels b k ∪
      {w | ∃ u ∈ parabolicNoiseBracketLevels b k, ∃ i : Fin (S+1),
        w=MolecularDynamics.Chapter06Review.lieBracket (b i) u}

def definition61_corrected {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧
    Submodule.span ℝ {v | ∃ k : ℕ, ∃ w ∈ parabolicNoiseBracketLevels b k, v=w x}=⊤

/-- 【原书疑误】保留原含漂移的张成条件，不能据此推出一般转移密度。 -/
def definition61Printed {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]Fin(S+1)完整包含原drift b0与全部噪声，实际无限次括号及实span；明确C∞字段资格。保留原定义含b0，不冒充一般parabolic噪声生成条件；具体Langevin rank另证。
- [EXTRA]原开域U和域内点完整保留；坐标字段全空间任意总化只用于函数表示，C∞仅要求在原开域，不要求全局光滑延拓。开域内真实fderiv/全部迭代括号是局部对象。
- [EXTRA] 补textbookIteratedBracket定义体；原含漂移版仅为原书括号秩定义，密度用途必须用噪声起始的抛物型修正版。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：Definition 6.1的开域、光滑向量场、域内点、包括b0的迭代括号及实线性张成等于ℝm均准确转录，省略号保持同一完整有限生成族。C：definition61与Printed逐项保留开域D、x∈D、所有Fin(S+1)字段在D上C∞以及包括漂移b0的全部迭代Lie括号；D95不是有限深度截断，D96–D97在x处取实span=⊤。全空间总化函数只用于表示局部字段，D开且光滑性只要求ContDiffOn D，因此不要求原书没有的全局光滑延拓。Bracket符号与原文v′u−u′v一致。corrected的第0层只用b1,…,bS，后续允许与任一bᵢ取括号再取并，最后量化所有自然数层并取实span，正确区分用于正时刻密度的抛物型条件。原定义包含漂移作为一个数学定义本身并不矛盾；不能据此对一般SDE断言转移密度，而本条也没有这样的定理结论。四个定义的角色及[EXTRA]一致。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.definition61` | 定义 | — | PASS |
| `MD.Ch06.parabolicNoiseBracketLevels` | 定义 | — | PASS |
| `MD.Ch06.definition61_corrected` | 定义 | — | PASS |
| `MD.Ch06.definition61Printed` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3040`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinFields

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> In the case of Langevin dynamics, we identify the vectors $b_i$ in (6.43) with the terms in (6.47). One puts Langevin dynamics into the correct form by using
> \[b_0=\begin{bmatrix}p\\-\nabla U(q)-\gamma p\end{bmatrix},\qquad b_i=\sigma\begin{bmatrix}0\\e_i\end{bmatrix},\quad i=1,2,\ldots,N_c,\]
> where $e_i$ is the $i$th Euclidean basis vector in $\mathbb R^{N_c}$ and $\sigma=\sqrt{2\gamma k_BT}$ is constant.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def langevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) (_hU : ContDiff ℝ ∞ U) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

def langevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际全部2Nc相空间坐标的真实drift/noise，C∞势资格编码，通用σ在物理定理取√(2γkBT)；不把noise定义计作独立Wiener law或密度存在证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Drift为(p,−∇U−γp)，Noise为(0,σe_i)，Fin Nc覆盖全部坐标。C∞资格和通用σ/物理代入均已说明；噪声定义自身不是Wiener定律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinDrift` | 定义 | — | PASS |
| `MD.Ch06.langevinNoise` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:3064`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinNoiseBracket

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> For $i=1,2,\ldots,N_c$, we have, using the fact that $b_i$ is a constant vector field and so its Jacobian matrix vanishes,
> \[[b_0,b_i]=-\begin{bmatrix}0&I\\-U''(q)&-\gamma I\end{bmatrix}b_i
> =-\sigma\begin{bmatrix}e_i\\-\gamma e_i\end{bmatrix}.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinNoiseBracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) := by
  apply MolecularDynamics.textbookLangevinDrift_noise_bracket <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C²势的Fréchet Jacobian、全部噪声坐标；σ任意，非零条件在独立性条明确。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C²势足以使力可微；常字段导数为零，−Db0·bi=(−σe_i,σγe_i)，与原符号和全部i,z吻合；σ=0也允许本恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinNoiseBracket` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3073`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinBracketIndependent

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> As these $N_c$ vectors, taken together with the original $b_i$, clearly provide a linearly independent set of $2N_c$ vectors,

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinBracketIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ) := by
  apply MolecularDynamics.textbookLangevinBracketFamily_linearIndependent <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Fin Nc⊕Fin Nc的全部2Nc向量族、σ≠0；不以维数计数代替独立性。

### 6. 审计结论（含网站结论）

网站原返回：PASS。族定义Sum.elim分别为全部噪声及全部括号，Fin Nc⊕Fin Nc恰有2Nc个向量；σ≠0保证位置块再动量块消元独立，n=0为空族也正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinBracketIndependent` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3082`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinHormander

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> we have verified Hörmander’s condition. Thus Assumption 1(ii) holds in the case of Langevin dynamics.

### 2. 原文证明

> 原书在结论前给出漂移、噪声、Lie括号计算及线性无关论证；本条仅摘录最后的结论句。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinHormander {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z := by
  apply MolecularDynamics.textbookLangevin_hormander_physicalNoise <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Lean仅覆盖实际Langevin向量场的原书括号秩条件；转移密度由条目14的正时刻修正版承接。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整物理σ=√(2γθ)、γ/θ>0、C∞ U的实际噪声及括号span；本桥只证rank，转移密度存在另条未证。
- [EXTRA] scope仅实际Langevin向量场括号rank；密度结论由LangevinTransitionDensity承接，补全部迭代括号定义。
- [ERRATUM?] 原Assumption 1(ii)中的零时刻端点不能由此rank核验推出；仅正时刻密度可由相应抛物型条件讨论。
- [EXTRA] 复审范围：原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。
- 覆盖缺口：本条rank签名不包含密度存在或连续性。
- 覆盖缺口：原Assumption 1(ii)包含t=0的端点仍需人工处理。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：所引两句与原页相符；原页在此前已明确计算漂移、噪声及第一层括号并说明2Nc个向量线性无关，proof_note不应让人误以为没有这段论证。C：rank声明自身PASS：状态为实配置×实动量，漂移(p,−∇U−γp)，噪声(0,σeᵢ)，σ=√(2γθ)且γ、θ正；给出每个z处的全部迭代括号span=整个相空间。Nc=0时是零维的无害情形。D95–D97以及实际seed均已展开，不是把rank结论当作假设。签名只给含漂移种子族的原书秩条件，没有直接给出转移密度或Assumption 1(ii)的联合连续性；这种拆分在EXTRA已有说明，需同步修正statement_scope和coverage_gaps。引文后半句的原Assumption 1(ii)实际写到t=0，正时刻密度即使正确，也不能自动覆盖这个端点，故原书层面的合并断言仍NEEDS_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinHormander` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3089`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinTransitionDensity

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Thus Assumption 1(ii) holds in the case of Langevin dynamics.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinTransitionDensity :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原引文保留；Lean覆盖实际周期单位质量Langevin核在t>0的联合连续转移密度及全部可测集合表示。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]具体实际单位周期Langevin、C∞势、正γ/β，全部点初值的正时间连续转移密度及真实平坦相空间测度表示；没有从含drift的任意原Definition6.1断言一般parabolic密度定理。
- [EXTRA] 补actual_path_solution_exists完整存在类型及所选解满足初值/积分方程的规格；不把缺摘录误记原书问题。
- [ERRATUM?] 原Assumption 1(ii)的[0,∞)应就转移密度连续性改为(0,∞)；点初值在零时刻是Dirac测度。
- [EXTRA] 复审范围：网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。
- 覆盖缺口：原Assumption 1(ii)在t=0的联合连续端点不成立/未按原文形式化，须勘误签核。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。A：所引“Thus Assumption 1(ii) holds in the case of Langevin dynamics.”原句准确；须连同其所引用的Assumption 1(ii)核对，不能只看该短句。C：当前正时刻限定签名PASS：真实周期单位质量Langevin端点核、C∞周期势和Lipschitz力、β和γ正、物理幅度√(2γ/β)、真实Wiener过程。D17、D19–D23及D28–D31说明是实际积分解的推前核；flatPhaseMeasure为真实平坦相空间测度。ρ先于所有t>0、x、可测A选择，在(x,z,t)联合变量上ContinuousOn(univ×(0,∞))，并给出全部可测集合上的限制积分表示；这是全密度结论，不是仅有限检验函数相等，也未把密度存在当作假设。原书Assumption 1(ii)却要求C×C×[0,∞)联合连续，当前声明有意改成t>0。该修改合理且必要，但应明标[ERRATUM?]并由人工认可；它不是原Assumption 1(ii)端点的完整忠实实现。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinTransitionDensity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3098`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Lemma61Printed

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Lemma 6.1 For all $t>0$ and all open $C\subset D$, we have that
> \[\Pr(X(t)\in C\mid X(0)=X_0)>0,\quad\forall X_0\in D,\]
> where $X(t)=(q(t),p(t))^T$ is a solution to Langevin dynamics (6.47).

### 2. 原文证明

> 原书给出证明论述；本条仅摘录命题，相关论述见相邻原页，未在此补写。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lemma61Printed {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ θ : ℝ) (hγ : 0 < γ) (hθ : 0 < θ)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*θ)) T x C := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06_ERRATA。
- 覆盖缺口：原书漏非空目标；Printed忠实保留空集漏洞。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：Lemma 6.1的标题、所有t>0、所有开集、全部点初值及原式准确；kind应为编号lemma而不是unnumbered_claim。C：缺少C.Nonempty忠实保留了原文的空集漏洞，这个数学错误应NEEDS_HUMAN，不能仅因此判Printed签名FAIL。实际端点核的定义、时间正性、全部点初值及周期单位质量相空间均已核对。不过原页把过程指定为(6.47)，其γ为正且噪声为√(2γkBT)；当前Printed却量化任意实γ和任意非零实σ，额外覆盖γ≤0及不满足物理噪声关系的过程。它们可用于有限时刻开放集可达性的正确推广，但该推广没有在本条EXTRA中完整披露，也不是(6.47)的字面参数域。按Printed必须审忠实性的要求，本条因参数域扩张FAIL；原书空集错误仍独立标NEEDS_HUMAN。此结论不依据sorry。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lemma61Printed` | 未证 | 原书疑误不证 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3117`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Lemma61Nonempty

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> \[\Pr(X(t)\in C\mid X(0)=X_0)>0,\quad\forall X_0\in D,\]

### 2. 原文证明

> 原书给出Lemma 6.1的Proof论述；本条只摘录展示式，未重录证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lemma61Nonempty {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption

/-- 修正版，对应原文 MD-6.4.4-Lemma61Printed；改动：增加目标开集非空；保留任意点初值、任意t>0的实际核正概率。 -/
theorem lemma61Printed_corrected {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原展示式保持原文；两份Lean声明均为增加目标非空条件、并将γ及σ参数推广后的实际周期单位质量核正概率命题。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]补非空目标；桥接实际单位周期相空间、原单位质量、真实Wiener/实际完整Langevin核，σ≠0。原一般质量扩大版不计已证。
- [EXTRA] 补所选解存在规格；目标开集非空修正保持。
- [EXTRA] γ可为任意实数，σ可为任意非零实数，是有限正时刻支持性质的推广；原物理(6.47)为其中的特例。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：该展示式来自同一Lemma 6.1；原页展示式以逗号承接where句，JSON改成句号，已还原。公式单独摘录时需补上原来的t>0、开集C、Langevin解及任意初值的上下文。原页下面有Proof段，当前proof_note应说明仅摘录命题，而不是遗漏这段原书论述。C：两份签名相同且作为修正/推广版均PASS：真实Wiener过程、C∞单位周期势及Lipschitz力、实际单位质量周期端点核；T>0、σ≠0、任意初值x以及非空开集C给出严格正概率。已展开路径存在规格和初值/积分方程、推前核定义，并核对所引open_pos定理的完整文件参数。增加C.Nonempty恰好消除条目15的空集漏洞；γ任意实数、σ任意非零实数是有限时刻可达性的合理推广，不需要为此引入规范不变测度或正摩擦。修正版并未声称一般质量矩阵版本已经覆盖。[EXTRA]应补全该参数推广，不把nonempty写进原文引文冒充原书已印出。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lemma61Nonempty` | 已证 | — | PASS |
| `MD.Ch06.lemma61Printed_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3129`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ControlPath

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Consider the ODE
> \[\frac{d^2q}{dt^2}+\nabla U(q)+\gamma\frac{dq}{dt}=\sigma\frac{dR}{dt}.\tag{6.49}\]
> for some positive constants $\gamma$ and $\sigma$. This is precisely Langevin dynamics (6.47), substituting a process $R(t)$ in place of the Wiener process. Choose $q$ to be a $C^\infty$ path such that for a given $t>0$
> \[(q(0),\dot q(0))^T=X_0;\quad(q(t),\dot q(t))^T=y.\]
> Taking $R(0)=0$, we can obtain a $C^\infty$ function $dR/dt$ by substitution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem controlPath {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整实际任意位置/速度端点、q/p/R全光滑、R0=0及真实全时ODE；σ≠0，未冒充随机正概率。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有x,y、T>0、σ≠0，存在全光滑q,p,R，四个端点及R0=0，逐时q′=p与p′=−∇U−γp+σR′全部保留。欧氏提升的可控性足够用于环面投影，EXTRA范围清楚。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.controlPath` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3150`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ControlEndpointStable

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Using the results of [257, Lemma 3.4], we can deduce that for any $\delta>0$, there exists a sufficiently small $\varepsilon>0$ such that if a realization of the Wiener process $W$ remains close to our solution $R$
> \[\sup_{0\le s\le t}\|W(s)-R(s)\|\le\varepsilon,\tag{6.50}\]
> then $X(t)\in\mathcal B_\delta(y)$. 

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem controlEndpointStable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint_stable <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际完整受控积分方程和原平滑势局部cutoff稳定性，全部端点/δ/ε；未假设全局Lipschitz势，原环面投影由上一真实核桥接。

### 6. 审计结论（含网站结论）

网站原返回：PASS。δ后选统一ε，再量化所有连续W,q,p；积分解定义包含初值、W0和两条真实积分方程。给定controlPosition/Momentum/Rate为Hermite三次路径及ODE反解，R为其积分；sup管道用逐时≤表达，端点严格dist<δ正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.controlEndpointStable` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3162`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WienerControlTube

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> The event (6.50) is shown in [349] to have positive probability for any $\varepsilon>0$, and hence the required property is shown for any open set.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerControlTube {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε) := by
  apply MolecularDynamics.textbookWienerVectorRealControlTube_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整实际标准多维Wiener法则、真实连续控制R0=0、T/ε>0及sup管道事件；非仅某单时Gaussian边际。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D50规定联合高斯、均值、独立坐标Brownian协方差与几乎处处连续，管道定义在闭时间区间逐时≤ε，T/ε>0且连续R起于0。对象、时间和事件完整，未以单时边际替代路径规律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerControlTube` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3173`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinCanonicalStationary

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Langevin dynamics is geometrically ergodic with respect to the canonical distribution
> \[\rho_\beta(q,p)=\exp(-\beta H(q,p)),\]
> where it is easily checked that
> \[\mathcal L_{LD}^\dagger\rho_\beta=0.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinCanonicalStationary {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际归一canonical density（原式缺Z为未归一权重，常数不影响微分式）、全部相空间点及物理噪声；这里只证stationary differential expression，真实invariance/ergodicity在下一条。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际forward算子全文为−DF·b−div(b)F+σ²Δ_pF/2；散度由全部位置/动量对角方向导数定义，确为平坦前向算子。D56–D57给归一canonical密度，正β、γ及σ=√(2γ/β)完整，逐点平稳式正确。原几何遍历性另列21，本条scope已限stationary differential expression。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinCanonicalStationary` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3182`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinGeometricErgodicity

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Hence Langevin dynamics is geometrically ergodic with respect to the canonical distribution
> \[\rho_\beta(q,p)=\exp(-\beta H(q,p)),\]
> where it is easily checked that
> \[\mathcal L_{LD}^{\dagger}\rho_\beta=0.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinGeometricErgodicity :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  MolecularDynamics.Chapter06Review.invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  (∀ ν : Measure (textbookLangevinPeriodicPhase n), IsProbabilityMeasure ν →
    MolecularDynamics.Chapter06Review.invariantKernel
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) ν →
    ν=textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ l : ℕ, 1 ≤ l → ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧
    ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Measurable f → (∀ y, |f y| ≤ (1+‖y.2‖^2)^l) → ∀ t : ℝ≥0,
      |MolecularDynamics.Chapter06Review.kernelAverage
        (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) f t x
        -(∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
        C*(1+‖x.2‖^2)^l*Real.exp (-lambdaParam*(t : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Lean采用单位周期、单位质量的实际Langevin核与归一Gibbs概率，显式要求U光滑周期、力全局Lipschitz及β,γ>0。
- [EXTRA] 对每个l≥1，常数在x、f、t之外；f精确限定为可测且|f(y)|≤(1+‖p‖²)^l的点态权界类。一般常数倍由缩放处理；不能称任意仅加权可积函数。
- [EXTRA] 固定有限维时可使用正平移后的Hamiltonian权重与(1+‖p‖²)^l比较，不能对未平移H^l作全局双边比较。
- [ERRATUM?] 原页exp(-βH)未显示归一因子；保留原式，需人工确认省略Z的约定。Lean实际采用归一Gibbs概率。
- [EXTRA] 复审范围：权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS指所交Lean签名的语义审校。相空间确为T^n×R^n；U光滑且单位周期，力全局Lipschitz，β、γ严格为正，噪声幅度√(2γ/β)。核来自有限窗真实Langevin积分解及Wiener路径分布；结论依次是归一Gibbs不变、全部不变概率的唯一性、每个整数l≥1上的统一加权指数估计。观测量为所有可测且逐点满足|f(y)|≤(1+‖p‖²)^l的实函数，既不是仅紧支函数，也不是任意加权L¹函数。C、λ可依赖n、U、β、γ、l等此前参数，但不依赖x、f、t；t=0包括在内。Fin n→R的标准范数与欧氏范数在固定有限维可比，不改变这一增长类。归一Gibbs与原页未写Z的exp(-βH)有明确区别，因此A阶段保留归一约定疑问为NEEDS_HUMAN；该疑问及过时EXTRA措辞不构成此正确签名的FAIL。未检查证明完成度。
当前处理：网站PASS（复审）。
权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinGeometricErgodicity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3192`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinTimeAverage

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Hence averages along solutions to (6.47) will converge to the spatial average with respect to $\rho_\beta$. Thus, Langevin dynamics is a useful tool for sampling the canonical distribution, as we may sample $\rho_\beta$ by computing solutions to the SDE.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinTimeAverage :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Measurable f →
    (∃ l : ℕ, ∃ C : ℝ, 0 ≤ C ∧ ∀ y, |f y| ≤ C*(1+‖y.2‖^2)^l) → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际同一全时随机周期Langevin轨迹，任意点初始状态、全部可测多项式动量增长观测量、几乎处处时间均值；不把初始density的ensemble衰减当轨迹时间均值。
- [EXTRA] 补实际选解存在、真实积分方程、唯一性、限制及同一全时随机过程一致性的完整声明类型；有限窗选择不能仅凭choose名称认定相容。

### 6. 审计结论（含网站结论）

网站原返回：PASS。相空间、归一Gibbs测度、β和γ及Wiener向量与上一条一致。结论确为沿同一随机轨迹的Cesàro时间均值：∀确定x、∀可测实f，若存在l∈N及C≥0使|f|≤C(1+‖p‖²)^l，则对P几乎所有样本，实数T→+∞时T⁻¹∫₀ᵀf(X_s)ds趋于Gibbs空间平均。l=0允许全部有界可测函数；零测例外集可以依赖x、f，并未声称所有x、f共享例外集。GlobalRandomPhase虽按ceil(t)+1选有限窗，但本任务同时提供真实积分解、全局唯一性、窗口一致性及∀T的AE规格，故不是把不相容choose选择误认成一条轨迹。周期过程由该全时解投影得到；hU、hp即便以下划线命名仍是显式前提。没有用初始密度ensemble收敛替代时间平均。sorry不参与本签名判定。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinTimeAverage` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3216`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedH1

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> We denote by $H^1(\mu)$ the space of functions $f(q,p)$ defined on $D=\mathbb T^{N_c}\times\mathbb R^{N_c}$ with bounded norm
> \[\|f\|_{H^1(\mu)}^2\stackrel{\mathrm{def}}=\|f\|_{L^2(\mu)}^2+\|\nabla_qf\|_{L^2(\mu)}^2+\|\nabla_pf\|_{L^2(\mu)}^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedH1 {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) : Type :=
  textbookLangevinCanonicalWeakH1 U hU hp β hβ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Gibbs加权弱导数闭图及AE商的完整Hilbert H1；不是smooth jet子集，函数/导数投影和范数下一条明确。
- [EXTRA] 补坐标伴随测试表达式及memLp_two完整规格；明确位置β∂U、动量βp项及分部积分符号，补摘录不算原书勘误。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weightedH1是Gibbs权重下的完整实弱H¹实现：none分量为函数的AE等价类，some(inl i)、some(inr i)分别是q、p的L²弱导数。测试恒等式的负号和β∂U、βp项正确，因为dμβ正比于exp(-βH)dω。所有测试函数的伴随表达式MemLp规格已实际摘录，不能只看名称。每项均为L²类，PiLp 2给出平方和范数；测试恒等式是连续线性约束，数学上刻画闭弱导数图及通常的Sobolev完备空间。所加U光滑、单位周期、β>0和Gibbs权重专业化已有EXTRA说明。这里审查类型和定义语义，不另宣称项目已证明闭性、完备性或所有相关实例。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedH1` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3233`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedH1Norm

印刷p.256–257 / PDFp.277–278；§6.4.4。

### 1. 原文陈述

> where
> \[\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega),\]
> and, for a vector function $w:D\to\mathbb R^{N_c}$, we have
> \[\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem weightedH1Norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2) := by
  apply MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq <;> assumption

/-- 原文第一式：实标量L²范数平方等于平方积分。 -/
theorem weightedL2NormScalar26 {D : Type*} [MeasurableSpace D]
    (μ : Measure D) (f : Lp ℝ 2 μ) :
    ‖f‖ ^ 2 = ∫ x, (f x) ^ 2 ∂μ := by
  sorry

/-- 原文第二式：任意欧氏向量值L²函数的分量均属L²，范数平方为分量平方和。 -/
theorem weightedL2NormVector26 {D : Type*} [MeasurableSpace D] {Nc : ℕ}
    (μ : Measure D) (w : D → EuclideanSpace ℝ (Fin Nc)) (hw : MemLp w 2 μ) :
    ∃ hc : ∀ i : Fin Nc, MemLp (fun x ↦ w x i) 2 μ,
      ‖hw.toLp w‖ ^ 2 = ∑ i : Fin Nc, ‖(hc i).toLp (fun x ↦ w x i)‖ ^ 2 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。现有weightedH1Norm本身数学正确：它确实给出加权H¹范数等于函数值及全部位置、动量弱导数L²范数的平方和，N、β、U及坐标投影均正确。但原文JSON的两项主结论分别是‖f‖²L²=∫f²dμ，以及任意w:D→R^N的‖w‖²L²=Σ‖wᵢ‖²L²。该Lean结论没有积分，没有独立标量f:L²，也没有任意向量w，因此不能覆盖这些结论。FAIL仅指本条原文与声明的完整覆盖关系，不指jet等式错误，也不因证明或sorry。EXTRA承认缺口是准确的，但不能替代缺失声明。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedH1Norm` | 已证 | — | PASS |
| `MD.Ch06.weightedL2NormScalar26` | 未证 | 缺大型理论 | 修复后未再送网站 |
| `MD.Ch06.weightedL2NormVector26` | 未证 | 缺大型理论 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3240`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Proposition64Printed

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> Proposition 6.4 Let $U$ be $C^\infty$ on the position domain $Q=\mathbb T^{N_c}$ and suppose $g\in H^1(\mu)$ satisfies
> \[\int_D g\,d\mu_\beta=0,\]
> where $\mu_\beta$ is the canonical measure, then the Poisson equation
> \[\mathcal L_{LD}^\dagger\varphi=g\]
> has a solution $\varphi\in H^1(\mu)$ which is unique up to addition of a constant multiple of the Gibbs density.

### 2. 原文证明

> 原书给出证明论述；本条仅摘录命题，相关论述见相邻原页，未在此补写。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition64Printed :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留原flat/Gibbs坐标混用疑误和非Gibbs恒通量反例；补H¹伴随测试表达式，修正版本由Proposition64Relative独立保存。
- [ERRATUM?] 原印刷同时混用Gibbs零均值与flat前向核的Gibbs倍数结论；所给弱域存在非Gibbs恒通量零模，须人工核定伴随坐标与算子域，原句不改。
- [EXTRA] 本任务没有提供_counterexample声明；不能把“保留反例”当作已完成的Lean审查证据。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS_HUMAN。Printed忠实性：PASS。给定光滑周期U、β>0、γ>0，对每个Gibbs加权H¹且μβ零均值的g，确实逐项保留flat-forward弱Poisson方程、完整H¹解存在、以及全部H¹解唯一模Gibbs密度倍数。CanonicalDensity为D52–D59的归一exp(-βH)，与未归一Gibbs密度相差正常数，不改变唯一模其倍数的表述。但这一原文字面版本在所定义弱域上存在明确恒通量反例；不能将平直前向伴随与Gibbs Hilbert伴随混用。因此总判NEEDS_HUMAN，保留Printed；不是因sorry失败。修正版在条目6的独立声明另审，未用它替换此原文版。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition64Printed` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS_HUMAN |

位置：`Blueprint/Ch06.lean:3265`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Proposition64Relative

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> \[\mathcal L_{LD}^{\dagger}\varphi=g\]
> has a solution $\varphi\in H^1(\mu)$ which is unique up to addition of a constant multiple of the Gibbs density.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition64Relative :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-Proposition64Printed；改动：选择相对Gibbs密度坐标与真实加权伴随算子，核相应为常数；保留完整H¹解存在与唯一性目标。 -/
theorem proposition64Printed_corrected :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确相对Gibbs密度坐标，实际加权Hilbert闭算子adjoint图与完整H1、加权零均值、解存在/唯一模常数；与印刷flat-density Gibbs倍数版分列，非静默纠错。
- [EXTRA] 补H¹坐标伴随测试表达式与memLp规格；相对Gibbs密度采用闭Hilbert adjoint，唯一模常数，不是flat Gibbs倍数。
- [ERRATUM?] 原页为Gibbs density倍数，原文照录；本条Lean是相对Gibbs坐标下的明确修正版，因此唯一性改为模常数。原印刷坐标/域问题见Proposition64Printed。

### 6. 审计结论（含网站结论）

网站原返回：PASS。proposition64Relative：PASS；proposition64Printed_corrected：PASS。二者都在归一Gibbs L²中使用实际Langevin后向算子的闭图伴随，对全部完整弱H¹且μβ零均值的g，断言存在H¹解，(value φ,value g)属于A.graph；对任意另一H¹解，差值μβ-AE为实常数。β、γ正、U光滑周期、噪声√(2γ/β)均保留，未把解空间缩成光滑或紧支函数。加权伴随作用于相对Gibbs密度r，flat密度为ρβr，所以核从Gibbs倍数变成常数是合理而明确的修正；Weighted H¹的导数测试及闭Hilbert图的算子表达式均已核对。这里认可修正版陈述与坐标选择，不认定其大型存在/正则性证明已完成。A阶段原印刷问题仍为NEEDS_HUMAN，不静默改写原书。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition64Relative` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.proposition64Printed_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3285`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-FredholmAlternative

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> The condition is a consequence of the Fredholm Alternative which says that, for a linear operator $A$ with compact resolvent, we have one of the following two conditions:
> • $A\varphi=g$ has a solution.
> • There is a function $y$ with $A^*y=0$ and $\langle y,g\rangle\ne0$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fredholmAlternative :
  ∀ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [CompleteSpace E] (A : E →ₗ.[ℝ] E), Dense (A.domain : Set E) → IsClosed (A.graph : Set (E × E)) →
  (∃ R : E →L[ℝ] E, IsCompactOperator R ∧
    (∀ x, (R x, R x-x) ∈ A.graph) ∧
    ∀ x y, (y,y-x) ∈ A.graph → y=R x) →
  ∀ g : E, (∃ φ : E, (φ,g) ∈ A.graph) ↔ ∀ y : E, (y,0) ∈ A.adjoint.graph → ⟪y,g⟫_ℝ=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际稠密域闭Hilbert partialoperator图、actual adjoint以及shift1的完整紧resolvent（含逆的存在/唯一）；全部g可解当且仅当adjoint kernel正交，没有假设目标可解性。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实完备Hilbert空间、稠密定义域、闭图、紧R及(I−A)的存在与唯一性逆规格完整；固定实移位1是已明确的技术范围。对每个g，可解当且仅当与实际adjoint全部零模正交，等价于Fredholm二择一，不预设目标可解。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fredholmAlternative` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3324`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-BackwardKernelConstants

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> In our case, $A=\mathcal L_{LD}^\dagger$. The only solutions of $\mathcal L_{LD}y=0$ (conserved quantities of Langevin dynamics) are the constants.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem backwardKernelConstants :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ),
    (f,0) ∈ (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ, f x=c := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Gibbs加权Lp²闭backward operator图的全部粗域元素；不能用已证C0固定观测量特例替代。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有L²粗域元素f在实际闭backward图内且Af=0蕴含AE常数；域及正参数、周期光滑势正确，未把连续函数特例当全部粗域。该句“only”是必要性，当前签名未断言常数均入域，不影响所选文字。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.backwardKernelConstants` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3335`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ForwardKernelGibbs

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> If we have two solutions $\varphi_1,\varphi_2$ of $\mathcal L_{LD}^\dagger\varphi=g$, then their difference $w$ must be a solution of $\mathcal L_{LD}^{\dagger}w=0$ and the only such solution is a constant multiple of the Gibbs density $\rho_\beta$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem forwardKernelGibbs : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ) (hβ : 0 < β),
  0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ w : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (textbookLangevinCanonicalWeakH1Value U hU hp β hβ w,0) ∈ A.graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
      textbookLangevinCanonicalWeakH1Value U hU hp β hβ w x=c := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 改用相对Gibbs密度的Hilbert adjoint闭域，核结论为常数；旧flat紧支弱测试允许非Gibbs恒通量零模，网站反例保留。改后核定理尚缺大型理论，不证明；原印刷flat措辞由Proposition64Printed留存。
- [ERRATUM?] 原flat-forward核结论需自然算子域/可积性约束；当前Lean明确改为相对Gibbs闭Hilbert伴随，核为常数。原书文字保留。
- [EXTRA] 未提供_counterexample声明，不能以“网站保留”作为形式验证证据。
- 覆盖缺口：本条只交付相对Gibbs修正版核结论，没有独立交付原flat坐标的两解差与Gibbs倍数核声明；原印刷Poisson命题在条目5保留，但不能据此称本条原核结论已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS限于EXTRA明确交付的相对Gibbs修正版。它保留所有光滑周期U、β>0、γ>0，对每个完整弱H¹零模w，在真实Langevin后向闭算子的Gibbs Hilbert伴随域内断言value(w)为常数。图成员资格不可省略，且这里没有使用旧flat紧支测试定义。这与r↦ρβr的密度转换一致，核陈述合理。原句的“两解差”可由伴随图线性化为此零模结论，但本条没有另外给出flat坐标的两解差等式；不能将常数直接说成原坐标的Gibbs密度倍数。EXTRA已经声明改动，故不当作静默纠错或签名FAIL；原书域/坐标问题在A阶段维持NEEDS_HUMAN。本结论尚待证明与签名是否正确是两回事。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.forwardKernelGibbs` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3346`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedFunctionNorm

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> \[\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedFunctionNorm {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ‖f‖^2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Lp² AE类范数；Mathlib的eLpNorm定义为真实二阶积分，不把任意非可积函数的默认Bochner积分当范数。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weightedFunctionNorm命名易误读但实际返回‖f‖²，正好对应所引平方范数；f是canonical measure的实Lp² AE类，故标准L²积分等式适用，不包含不可积任意函数。β>0且真实Gibbs乘积测度明确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedFunctionNorm` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3358`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedVectorNorm

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> and, for a vector function $w:D\to\mathbb R^{N_c}$, we have
> \[\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedVectorNorm {n r : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (w : Fin r → Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) : ℝ := ∑ i, ‖w i‖^2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整任意维度的所有真实L²分量，弱导数族使用同一实际Gibbs测度；不遗漏向量范数定义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。n为位置/动量坐标维数，r为向量分量数，二者独立且可任意有限；w各分量为同一真实canonical measure下的实L²等价类。返回值∑‖w i‖²恰为原公式的平方范数；并未开平方，故应按平方范数解释此名称。本条是定义而不是向量Lp范数等式定理。β>0保证动量高斯方差为正；U的平滑、周期及归一资格没有编码，因而只在原书Gibbs设置下解释为canonical probability。额外说明中的弱导数族在此声明中不存在，本条也无需弱导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedVectorNorm` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3363`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-KernelEvolution

印刷p.257 / PDFp.278；§6.4.5。

### 1. 原文陈述

> Given a collection of phase space points distributed according to the density $\rho_0(q,p)$, we know that its evolution (under Langevin dynamics) after a time $t$ will be described by
> \[\rho(q,p,t)=e^{t\mathcal L_{LD}^{\dagger}}\rho_0(q,p).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def kernelEvolutionRaw25 {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (t : ℝ≥0) : Measure D := K t ∘ₘ μ

def kernelEvolution {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (_hK : MolecularDynamics.Chapter06Review.markovSemigroup K) (t : ℝ≥0) : Measure D := K t ∘ₘ μ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：本source_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 本source_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。
- 覆盖缺口：特定Langevin核与前向密度半群的识别、ρt dω=Kt∘ₘ(ρ0 dω)及e^{tL†}解释未由本条给出。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A阶段APPROVED表示原文JSON与其“仅核推进”的限制说明真实。两个Lean辅助定义本身均正确：Raw25允许任意核族，主入口另要求真正Markov半群，D是任意可测类型，μ是任意测度，t≥0。即使μ未限定概率，该定义仍成立；仅在μ为概率时才得到概率推进。但原文完整结论是特定Langevin密度随前向指数算子演化。两个辅助体没有U、β、γ、ρ0、ρt、平直参考测度、生成元或密度等式。FAIL仅指该原文完整结论未由本条交付；EXTRA如实承认限制，不据此把缺失部分判成已经覆盖。条目10、13的资格定义另行审校，不能合并替代本条。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
本source_id仅登记两个核作用于测度的辅助定义；hK要求真实Markov半群，但不因此提供特定Langevin前向密度或指数算子识别。明确原式尚未由本条形式化，缺口继续保留。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kernelEvolutionRaw25` | 定义 | — | PASS（仅辅助定义） |
| `MD.Ch06.kernelEvolution` | 定义 | — | PASS（仅辅助定义） |

位置：`Blueprint/Ch06.lean:3369`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-KernelAverage

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> which says that the average of a function $\varphi$ with respect to the distribution at time $t$ is equivalent to the average of the forward propagation of $\varphi$ with respect to the initial distribution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def kernelAverage {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (t : ℝ≥0) (x : D) : ℝ := ∫ z, f z ∂K t x

/-- 原句的两种平均相等：明确初始/演化分布及可积资格。 -/
theorem kernelAverage_distributionIdentity26 {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ0 μt : Measure D) (t : ℝ≥0) (f : D → ℝ)
    (hμ0 : IsProbabilityMeasure μ0) (hK : IsMarkovKernel (K t))
    (hμt : μt = K t ∘ₘ μ0) (hf : Measurable f) (hi : Integrable f μt) :
    (∫ x, f x ∂μt) = ∫ x, kernelAverage K f t x ∂μ0 := by
  subst μt
  letI : IsProbabilityMeasure μ0 := hμ0
  letI : IsMarkovKernel (K t) := hK
  unfold kernelAverage
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。该辅助定义正确且与EXTRA所称“总化记号”相符：D为任意可测空间、K为任意核族、f为任意实函数；Lean积分对不合格函数仍有总化值。因此本定义不能解释为任意f都有概率平均，更不能推出原句的∫f dμt=∫Kt f dμ0。原句要求分布演化、可积资格及核积分交换的等式，而这些对象和结论均未在当前声明中出现。FAIL为完整原句覆盖不足，非定义或证明错误。原文JSON没有伪称它已覆盖，故A状态APPROVED并保留既有coverage_gaps。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
保留kernelAverage总化辅助记号；新增实际分布平均恒等式，显式量化μ0、μt、μt=Kt∘ₘμ0、概率/Markov资格以及f可测可积，不再仅引用未随本条送审的KernelDuality名称。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kernelAverage` | 定义 | — | PASS（仅辅助定义） |
| `MD.Ch06.kernelAverage_distributionIdentity26` | 已证 | — | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3378`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-DensityEvolutionMeaning

印刷p.257–258 / PDFp.278–279；§6.4.5。

### 1. 原文陈述

> More precisely this relation should be interpreted in the variational sense, so that we have, for any suitable test function $\varphi$, e.g. $\varphi\in C^\infty$,
> \[\int_D\varphi\rho(q,p,t)d\omega=\int_D\varphi e^{t\mathcal L_{LD}^{\dagger}}\rho_0(q,p)d\omega.\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def densityEvolutionMeaning {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ) (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (ρ0 : textbookLangevinPeriodicPhase n → ℝ) (ρ : ℝ≥0 → textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  langevinKernelQualification25 U β γ K ∧
  (∀ x, 0 ≤ ρ0 x) ∧ Integrable ρ0 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, ρ0 x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ x, ρ 0 x = ρ0 x) ∧
  ∀ t, (∫ x, ρ t x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
    (∀ x, 0 ≤ ρ t x) ∧ Integrable (ρ t) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
    MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ0 x))) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ t x)) ∧
    ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Integrable (fun x ↦ f x*ρ t x) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
      Integrable f (K t ∘ₘ ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity
        (fun x ↦ ENNReal.ofReal (ρ0 x)))) →
      (∫ x, f x*ρ t x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n) =
        ∫ x, f x ∂K t ∘ₘ ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity
          (fun x ↦ ENNReal.ofReal (ρ0 x)))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补Markov/初值/半群及真实右生成元识别资格，补各时刻概率质量和初值；逐点非负为所选代表，显式列可积测试的变分等式。此为语义资格定义，未声称密度存在或任意核满足它。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补Markov/初值/半群及真实右生成元识别资格，补各时刻概率质量和初值；逐点非负为所选代表，显式列可积测试的变分等式。此为语义资格定义，未声称密度存在或任意核满足它。

### 6. 审计结论（含网站结论）

网站原返回：PASS。这是对给定K、ρ0、ρ的语义资格定义，未声称任意K或任意输入都存在密度。位置与动量维数一致，t∈R≥0。langevinKernelQualification25包含真实表达式p·∇q-∇U·∇p-γp·∇p+(γ/β)Δp在0处的右导数条件，并包含Markov初值与组合律；它是明确的生成元资格，不是仅有Markov名称。密度均相对于flatPhaseMeasure；withDensity采用ofReal前已有逐点非负，不能以裁剪冒充负密度。ρ0和各ρt均为单位质量并可积，ρ(0)=ρ0逐点明确。最后对所有满足两侧明确Integrable条件的实测试函数给出积分等式，把原页模糊的suitable test function落实为可积范围，不声称所有C∞在非紧空间自动合格。没有构造指数算子或证明K唯一等于路径核；EXTRA已明确只交语义资格。这个定义的对象、条件和完整定义体正确。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.densityEvolutionMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3398`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-KernelDuality

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> This is of course an inner product, and due to the properties of the inner product, we may interpret the right hand side as
> \[\int_D\left[e^{t\mathcal L_{LD}}\varphi(q,p)\right]\rho_0(q,p)d\omega,\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem kernelDuality :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (t : ℝ≥0) (f : D → ℝ),
  IsProbabilityMeasure μ → IsMarkovKernel (K t) → Measurable f →
  Integrable f (MolecularDynamics.Chapter06Review.kernelEvolution K μ t) →
  (∫ x, f x ∂MolecularDynamics.Chapter06Review.kernelEvolution K μ t) = ∫ x, MolecularDynamics.Chapter06Review.kernelAverage K f t x ∂μ := by
  intro D _ K μ t f hμ hK hf hi
  letI : IsProbabilityMeasure μ := hμ
  letI : IsMarkovKernel (K t) := hK
  unfold MolecularDynamics.Chapter06Review.kernelEvolution MolecularDynamics.Chapter06Review.kernelAverage at *
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部实际可测可积检验、真实Markov kernel及初始概率measure；非仅Brownian谱模型配对。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对任意可测空间D、任意时刻t、初始概率μ、该时刻Markov核K t及可测实函数f，假设f对演化measure可积，结论恰是演化measure积分等于初始measure下的核平均积分。μ概率及K t Markov给出有限性，从总积分可积可获AE纤维可积，迭代积分有明确资格；无需所有时刻半群律即可证明该时刻对偶式。原文density×flat measure在此抽象为μ，泛化合理；本条未声称已把任意K识别为Langevin。所有量词、前提及等号方向与[EXTRA]一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.kernelDuality` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3419`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-SmoothTestL2Printed

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> Since all the eigenvalues lie to the left of a vertical line in the left half plane, for any $\varphi$ in $C^\infty$ we have
> \[\int_D\varphi\rho(q,p,t)d\omega=\operatorname{Av}_\beta(\varphi)+\alpha e^{t\lambda_1}\int_D\varphi\rho^{(1)}d\omega.\]
> The latter integral is bounded since both $\varphi$ and $\rho^{(1)}$ are in $L^2$, and since $\operatorname{Re}(\lambda_1)<0$, we see that this converges exponentially to the desired average.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem smoothTestL2Printed : ∀ {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ),
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) →
  MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  sorry

/-- 修正版，对应原文 MD-6.4.5-SmoothTestL2Printed；改动：明确要求检验函数属于所选L²空间；给出正确检验函数域定义，不冒称所有C∞函数可积。 -/
def smoothTestL2Printed_corrected {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) ∧
    MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06_ERRATA。
- 覆盖缺口：平均恒等式、ρ^(1)的L²资格及与测试函数配对的有界性没有在本条两声明中表达；未将这些内容标为已经形式化。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。分版审校：smoothTestL2Printed忠实地保留原页隐含的“每个光滑测试函数均在平直L²”子主张；该子主张的原书数学疑误判NEEDS_HUMAN，而不因它为假就判Printed不忠实。smoothTestL2Printed_corrected是正确的限定域定义C∞∩L²，修正合理，局部签名PASS；但它是def，不是有界积分定理。本条scope仍称覆盖所引原句及展示公式，coverage_gaps却为null。实际两个声明都没有ρt、ρeq、ρ1、λ1、α、传播关系、平均恒等式或积分界，因此总audit为FAIL，理由是独立的完整结论覆盖缺口，而不是原书数学疑误或sorry。原文错误另在json_review中保留NEEDS_HUMAN。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
恢复原文完整末句。Printed仅保留光滑蕴含平直L²的原书疑误子主张；_corrected仅是网站已PASS的C∞∩L²合格域定义。限定当前覆盖，不把该定义计作平均公式或积分有界定理。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.smoothTestL2Printed` | 未证 | 原书疑误不证 | 原文子主张忠实性PASS；原书数学NEEDS_HUMAN |
| `MD.Ch06.smoothTestL2Printed_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3437`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-ComplexInitialDensity

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> For example, if we assume that $\lambda_1,\rho^{(1)}$ is some eigenvalue, eigenfunction pair with $\operatorname{Re}(\lambda_1)<0$ and take the initial distribution to be
> \[\rho_0=\rho_{eq}+\alpha\rho^{(1)},\]
> for $\alpha\in\mathbb R$, then we have

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def complexInitialDensity {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
def complexInitialDensity_corrected {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 只定义给定复L²候选ρeq、ρ1及实α的平衡候选与初始组合的概率资格；不单独编码本征对、Reλ<0或实际Gibbs识别，也不声称所有α合格。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确真实初始概率的实性/非负/积分1，原单复模式不自动是概率；保留复Lp空间与复本征值，未缩成实负λ玩具。复共轭成对构造可另建，但原单模式需这些资格。
- [EXTRA] 仅为给定复L²候选的概率资格辅助定义；本征关系、Reλ<0及平衡态识别须在使用处另列，单一非实模式须共轭配对后再查非负性，不能覆盖任意α的原句。
- [ERRATUM?] 原文取initial distribution需隐含实性、非负和单位质量的额外限制；不能把任意α或任意单一复模式当作概率。原句保留。
- 覆盖缺口：本条不含本征关系、Reλ<0与实际Gibbs平衡态识别；相关使用条件在ComplexEigenmodeDecay另列，不能据此称本定义包含这些条件。

### 6. 审计结论（含网站结论）

网站原返回：PASS。complexInitialDensity：作为EXTRA明确声明的概率资格辅助定义，PASS；complexInitialDensity_corrected：同样PASS，且二者实为同体，不是一个已证另一个待证。它们要求ρeq及给定组合ρeq+αρ1各自AE实且非负，实部可积且积分1；这些是复L²候选代表概率密度所需的正确条件。不要求ρ1本身非负，亦不要求α≠0，均正确；α=0时没有从单位质量倒推ρ1零积分。定义里没有λ或A，也没有声称所有α合格、ρeq确为Gibbs或ρ1确为本征函数；这些必须由使用处如条目14另列。因此这是合理的显式限定，不是对原页任意α的无条件实现；A阶段仍须人工核定原文中“initial distribution”的隐含范围。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.complexInitialDensity` | 定义 | — | PASS |
| `MD.Ch06.complexInitialDensity_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3450`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-LangevinForwardSemigroupMeaning

印刷p.257–258 / PDFp.278–279；§6.4.5。

### 1. 原文陈述

> \[\rho(q,p,t)=e^{t\mathcal L_{LD}^{\dagger}}\rho_0(q,p).\]

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def langevinForwardSemigroupMeaning {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ)
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (S : ℝ≥0 → Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →L[ℂ]
      Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) : Prop :=
  langevinKernelQualification25 U β γ K ∧
  S 0 = ContinuousLinearMap.id ℂ _ ∧
  (∀ s t, S (s+t) = (S s).comp (S t)) ∧
  (∀ v, Continuous (fun t ↦ S t v)) ∧
  ∀ v : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n),
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (v x).im=0 ∧ 0 ≤ (v x).re) →
    Integrable (fun x ↦ (v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
    ∀ t, (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      (S t v x).im=0 ∧ 0 ≤ (S t v x).re) ∧
      Integrable (fun x ↦ (S t v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
      MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (v x).re)) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal ((S t v x).re))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补C₀半群（初值/组合/强连续）、Markov核及实际Langevin右生成元联系；每个合格输入的输出AE实且非负并可积，排除(1+i)id和ofReal裁剪伪识别。此为资格定义，未证明存在。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补C₀半群（初值/组合/强连续）、Markov核及实际Langevin右生成元联系；每个合格输入的输出AE实且非负并可积，排除(1+i)id和ofReal裁剪伪识别。此为资格定义，未证明存在。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对给定U、β、γ、K、S定义资格，非存在定理。S t为复L²(flatPhaseMeasure)上的有界复线性算子，S0=id、组合律及对每个v的强连续性齐全。K满足β、γ正、U光滑周期、Markov半群及紧支光滑函数的0处真实Langevin右生成元资格。对每个AE实非负且L¹的v，定义要求所有t的S t v也AE实非负且L¹，并将输入、输出平直密度测度精确关联为Kt推进。输入不必质量1，因此包括全部非负可积L²密度；质量由Markov性质保留。这些条件排除了(1+i)id及ofReal裁剪假象；双线性/复线性与非负可积类的线性生成关系可延伸识别，不必错误地对所有复v使用非负withDensity。该定义没有直接写出S的全域生成元图等于L†或证明K等于某条路径核；交付范围是EXTRA声明的生成元和测度推进语义资格，本次不把资格或存在性视为已证。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinForwardSemigroupMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3473`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.5-ComplexEigenmodeDecay

印刷p.258 / PDFp.279；§6.4.5。

### 1. 原文陈述

> \[\rho(q,p,t)=e^{t\mathcal L_{LD}^{\dagger}}\rho_0=e^{t\mathcal L_{LD}^{\dagger}}\rho_{eq}+\alpha e^{t\mathcal L_{LD}^{\dagger}}\rho^{(1)}=\rho_{eq}+\alpha e^{t\lambda_1}\rho^{(1)}.\]

### 2. 原文证明

> The latter integral is bounded since both $\varphi$ and $\rho^{(1)}$ are in $L^2$, and since $\operatorname{Re}(\lambda_1)<0$, we see that this converges exponentially to the desired average.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem complexEigenmodeDecay : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (β γ : ℝ)
    (hβ : 0 < β) (_hγ : 0 < γ), textbookIsWienerVector B P →
  let E := Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
  ∀ (S : ℝ≥0 → E →L[ℂ] E) (A : E →ₗ.[ℂ] E) (ρeq ρ1 : E) (α : ℝ) (ev : ℂ),
    langevinForwardSemigroupMeaning U β γ
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) S →
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      ρeq x=(textbookLangevinCanonicalDensity U β x : ℂ)) →
    S 0=ContinuousLinearMap.id ℂ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
    (∀ v, Continuous (fun t : ℝ≥0 ↦ S t v)) →
    (∀ v w, (v,w) ∈ A.graph → HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal v) w (Ici 0) 0) →
    (ρeq,0) ∈ A.graph → (ρ1,ev • ρ1) ∈ A.graph → ρ1 ≠ 0 → ev.re < 0 →
    complexInitialDensity ρeq ρ1 α →
    (∀ t : ℝ≥0, S t (ρeq+(α : ℂ) • ρ1)=ρeq+((α : ℂ)*Complex.exp ((t : ℂ)*ev)) • ρ1) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ=⟪f,ρeq⟫_ℂ+
        ((α : ℂ)*Complex.exp ((t : ℂ)*ev))*⟪f,ρ1⟫_ℂ) ∧
    (∀ f : E, ∀ t : ℝ≥0,
      ‖⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ-⟪f,ρeq⟫_ℂ‖ ≤
        |α| * ‖f‖*‖ρ1‖*Real.exp (ev.re*(t : ℝ))) ∧
    ∀ f : E, Tendsto (fun t : ℝ≥0 ↦ ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ)
      atTop (𝓝 ⟪f,ρeq⟫_ℂ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | statement_latex只存演化展示式；proof_discussion_latex存不相邻的原页完整末句。二者之间的平均段落见SmoothTestL2Printed，不冒充连续引文。本条Lean结论含模式演化、全部L²测试的平均恒等式、指数界与极限。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 采用平直复L²空间、实α和完整复特征值ev，要求ev.re<0、非零本征向量及真实初始概率资格；不把所有α、所有单一非实模式视为概率扰动。
- [EXTRA] S以LangevinForwardSemigroupMeaning U β γ作用于本条真实周期Langevin路径核为前提；ρeq与归一Gibbs密度AE识别。资格已编码，实际半群存在及资格实现仍未视为已证。
- [EXTRA] 0处生成元图成员、驻定态和本征关系为前提；全时指数模式、平均恒等式、Cauchy–Schwarz界与极限全部为结论。测试对象精确为复L²，未沿用原书任意C∞的可积性推断。
- [ERRATUM?] 单个非实本征模式的初始概率资格及原页任意C∞的L²推断分别见ComplexInitialDensity和SmoothTestL2Printed；保留原书末句，不以该句证明本条。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS。对象为真实T^n×R^n周期Langevin核、平直复L²空间E、复C₀半群S及复部分线性算子A。U光滑单位周期、力全局Lipschitz、Wiener驱动、β、γ正及噪声√(2γ/β)均显式；ρeq与真实归一Gibbs密度AE相等，并有complexInitialDensity的概率资格，不是把任意复扰动当概率。S和真实核的关联是明确前提。生成元仅需A.graph中的(v,w)推出S轨道0处右导数为w；为两个指定图成员推出指数轨道已足够，不必额外假定A等于整个最大生成元。其驻定、本征条件保留完整复ev及ev.re<0，结论中的Complex.exp((t:ℂ)*ev)及|α|‖f‖‖ρ1‖exp(ev.re*t)符号、系数均正确。复内积对第二变量线性，故αexp(t ev)在右侧不取共轭；对应普通实测试平均时取实f即可。身份、组合、强连续在语义资格之外重复列出虽冗余但无误。若ev非实且仅用单一模式，要使初始密度实而α≠0通常不相容；该定理仍正确，因为概率资格显式且允许α=0，未声称任意非实模式存在非平凡概率扰动。原页任意C∞的可积性疑误已在条目11保留NEEDS_HUMAN；本声明明确限定所有L²测试，未继承那个错误。本次只审校签名，未因sorry失败，也未把前向半群的存在与资格实现视为已证明。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.complexEigenmodeDecay` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3494`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## 公共辅助资格定义

以下共同定义由各条引用，计入定义数；定义本身不表示存在性或结论已经证明。

```lean
def naturalHistory25 {Ω V : Type*} [MeasurableSpace Ω] [MeasurableSpace V]
    (X : ℝ → Ω → V) (s : ℝ) : MeasurableSpace Ω :=
  ⨆ r : {r : ℝ // 0 ≤ r ∧ r ≤ s}, MeasurableSpace.comap (X r) inferInstance

/-- 25号：严格网格积分的充分资格；切片L²、有限和L²及局部均方Hölder控制。
不把积分公式或其所求极限作为假设。 -/
```

```lean
def gridItoQualification25 {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ Measurable (Function.uncurry g) ∧
  (∀ t : ℝ, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (g t)) ∧
  ∀ T : ℝ, 0 ≤ T →
    (∀ t ∈ Icc 0 T, MemLp (g t) 2 P) ∧
    (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
    ∃ C : ℝ, 0 ≤ C ∧ ∀ s ∈ Icc 0 T, ∀ t ∈ Icc 0 T,
      (∫ sample, (g s sample-g t sample)^2 ∂P) ≤ C*|s-t|

/-- 25号：共同向量自然过滤上的适应性与均方时间正则；不要求仅对单坐标历史适应。 -/
```

```lean
def vectorGridItoQualification25 {Ω : Type*} [MeasurableSpace Ω] {r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → (Fin r → ℝ)) (g : Fin r → ℝ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, Measurable (Function.uncurry (g j))) ∧
  (∀ j t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (g j t)) ∧
  ∀ j T, 0 ≤ T → (∀ t ∈ Icc 0 T, MemLp (g j t) 2 P) ∧
    (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum
      (fun s sample ↦ W s sample j) (g j) T K) 2 P) ∧
    ∃ C : ℝ, 0 ≤ C ∧ ∀ s ∈ Icc 0 T, ∀ t ∈ Icc 0 T,
      (∫ sample, (g j s sample-g j t sample)^2 ∂P) ≤ C*|s-t|

/-- 25号：Markov半群及紧支光滑测试的真实右生成元资格。
它是给定核与Langevin微分表达式的识别条件，不是任意核存在性定理。 -/
```

```lean
def langevinKernelQualification25 {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β γ : ℝ)
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n)) : Prop :=
  0 < β ∧ 0 < γ ∧ ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
  MolecularDynamics.Chapter06Review.markovSemigroup K ∧
  ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) → HasCompactSupport f →
    ∀ x, HasDerivWithinAt
      (fun t : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal x)
      (textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2*γ*β⁻¹)) f x) (Ici 0) 0
```

