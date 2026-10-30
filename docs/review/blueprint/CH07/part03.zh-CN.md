[上一部分](part02.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## MD-7.4.1-StationaryMomentSystem

印刷页 275 / PDF页 296。

### 1. 原文陈述

> Hence we have $`\mathbb E(\mu_{n,i}q_n)=\mathbb E(\mu_{n,i}p_n)=0`$, for any $`i`$ and $`n`$. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then considering the limit $`n\to\infty`$ we obtain a closed, linear system of equations

$$
Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+\bar\mu_{11},
$$



$$
P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+\bar\mu_{22},
$$



$$
C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\bar\mu_{12},\tag{7.11}
$$


> where $`\bar\mu_{11}=\mathbb E(\mu_{n,1}^2)`$, $`\bar\mu_{12}=\mathbb E(\mu_{n,1}\mu_{n,2})`$, $`\bar\mu_{22}=\mathbb E(\mu_{n,2}^2)`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def momentSystem (a b c d u v w Q P C : ℝ) : Prop :=
  Q = a^2*Q+b^2*P+2*a*b*C+u ∧
  P = c^2*Q+d^2*P+2*c*d*C+w ∧
  C = a*c*Q+b*d*P+(a*d+b*c)*C+v

def invariantLinearLaw (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ IsProbabilityMeasure η ∧
  Measure.map (fun z ↦ linearUpdate a b c d z.1 z.2) (μ.prod η) = μ

theorem stationaryMomentSystem (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ)
    (hinv : invariantLinearLaw μ η a b c d)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hr : MemLp (fun x ↦ x.1) 2 η) (hs : MemLp (fun x ↦ x.2) 2 η)
    (hmean : (∫ x, x.1 ∂η) = 0 ∧ (∫ x, x.2 ∂η) = 0) :
    momentSystem a b c d (momentQ η) (momentQP η) (momentP η)
      (momentQ μ) (momentP μ) (momentQP μ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 momentSystem, invariantLinearLaw, stationaryMomentSystem 所列对象、量词、前提和结论。范围说明：momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 使用独立乘积μ.prodη及实际推前不变性，不把所求矩方程当作该定理假设；所有坐标L²、噪声中心化明示。
- 只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。
- 覆盖缺口：只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 momentSystem, invariantLinearLaw, stationaryMomentSystem 所列对象、量词、前提和结论。范围说明：momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。

### 7. 状态与证明位置

- `MD.Ch07.momentSystem`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.invariantLinearLaw`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.stationaryMomentSystem`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-ABOHarmonic

印刷页 275–276 / PDF页 296–297。

### 1. 原文陈述

> Example 7.1 Consider the scheme coded $`[ABO]`$.
> In the case of the one-dimensional harmonic oscillator, we have $`U'(q)=\Omega^2q`$, yielding the compact form of one iteration as

$$
\binom{q_{n+1}}{p_{n+1}}=\begin{bmatrix}1&h/m\\-\Omega^2he^{-h\gamma}&(1-\Omega^2h^2/m)e^{-h\gamma}\end{bmatrix}\binom{q_n}{p_n}+\binom0{\zeta m^{1/2}R_n}.\tag{7.12}
$$


> Taking expectations of (7.12) and then taking the limit as $`n\to\infty`$, we see immediately that
> $`\langle q\rangle_h^{[ABO]}=\langle p\rangle_h^{[ABO]}=0`$, as $`\mathbb E(R_n)=0`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def aboHarmonic (m Ω γ θ h R : ℝ) (x : ℝ × ℝ) : ℝ × ℝ :=
  linearUpdate 1 (h/m) (-Ω^2*h*Real.exp (-h*γ)) ((1-Ω^2*h^2/m)*Real.exp (-h*γ)) x
    (0, Real.sqrt (θ*(1-Real.exp (-2*γ*h)))*Real.sqrt m*R)

theorem aboStationaryMean (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : Integrable (fun x ↦ x.1) μ) (hp : Integrable (fun x ↦ x.2) μ)
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    (∫ x, x.1 ∂μ) = 0 ∧ (∫ x, x.2 ∂μ) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 aboHarmonic, aboStationaryMean 所列对象、量词、前提和结论。范围说明：aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 aboHarmonic, aboStationaryMean 所列对象、量词、前提和结论。范围说明：aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。

### 7. 状态与证明位置

- `MD.Ch07.aboHarmonic`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aboStationaryMean`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-ABOVariance

印刷页 276 / PDF页 297。

### 1. 原文陈述

> For example, the relative increase in the variance of position is computed for the $`[ABO]`$ scheme as

$$
\frac{\langle q^2\rangle_h^{[ABO]}}{\langle q^2\rangle}=\frac{e^{h\gamma}m(1+e^{-h\gamma})^2}{2m(1+e^{-h\gamma})-h^2\Omega^2e^{-h\gamma}} =1+\gamma h/2+(\Omega^2+\gamma^2m)h^2/(4m)+O(h^3).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def aboVarianceRatio (m Ω γ h : ℝ) : ℝ :=
  Real.exp (h*γ)*m*(1+Real.exp (-h*γ))^2 /
    (2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))

theorem aboVarianceRatio_expansion (m Ω γ : ℝ) (hm : 0 < m) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ aboVarianceRatio m Ω γ h - (1+γ*h/2+(Ω^2+γ^2*m)*h^2/(4*m)))
      (fun h ↦ h^3) := by
  sorry

theorem aboStationaryVariance (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hden : 0 < 2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ / (θ/Ω^2) = aboVarianceRatio m Ω γ h := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 aboVarianceRatio, aboVarianceRatio\_expansion, aboStationaryVariance 所列对象、量词、前提和结论。范围说明：有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 aboVarianceRatio, aboVarianceRatio\_expansion, aboStationaryVariance 所列对象、量词、前提和结论。范围说明：有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。

### 7. 状态与证明位置

- `MD.Ch07.aboVarianceRatio`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aboVarianceRatio_expansion`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.aboStationaryVariance`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-Table71

印刷页 277 / PDF页 298。

### 1. 原文陈述

> Table 7.1 The expected long-time computed average using the given second-order Langevin dynamics discretization scheme

$$
\begin{array}{c|ccc} \text{Scheme}&\langle q^2\rangle_h/\langle q^2\rangle&\langle p^2\rangle_h/\langle p^2\rangle&\langle qp\rangle\\ [ABOBA]&1&[1-h^2\Omega^2/(4m)]^{-1}&0\\ [OBABO]&[1-h^2\Omega^2/(4m)]^{-1}&1&0\\ [BAOAB]&1&1-h^2\Omega^2/(4m)&0\\ [OABAO]&1-h^2\Omega^2/(4m)&1&0 \end{array}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def scalarLift (F : Phase 1 → Phase 1) (x : ℝ × ℝ) : ℝ × ℝ :=
  let y := F ((fun _ ↦ x.1),(fun _ ↦ x.2))
  (y.1 0,y.2 0)

def symmetricHarmonicStep (scheme : Fin 4) (m Ω γ θ h : ℝ) (R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if scheme = 0 then aboba masses U γ θ h (fun _ ↦ R)
    else if scheme = 1 then obabo masses U γ θ h (fun _ ↦ R) (fun _ ↦ S)
    else if scheme = 2 then baoab masses U γ θ h (fun _ ↦ R)
    else oabao masses U γ θ h (fun _ ↦ R) (fun _ ↦ S))

def symmetricInvariant (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ symmetricHarmonicStep scheme m Ω γ θ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

theorem table71 (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hinv : symmetricInvariant scheme m Ω γ θ h μ) :
    momentQ μ/(θ/Ω^2) = (if scheme = 1 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 3 then 1-h^2*Ω^2/(4*m) else 1) ∧
    momentP μ/(θ*m) = (if scheme = 0 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 2 then 1-h^2*Ω^2/(4*m) else 1) ∧ momentQP μ = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 scalarLift, symmetricHarmonicStep, symmetricInvariant, table71 所列对象、量词、前提和结论。范围说明：Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。
- 4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。
- 只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。
- 覆盖缺口：只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 scalarLift, symmetricHarmonicStep, symmetricInvariant, table71 所列对象、量词、前提和结论。范围说明：Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。

### 7. 状态与证明位置

- `MD.Ch07.scalarLift`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricHarmonicStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricInvariant`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.table71`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.1-NonsymmetricExactMoments

印刷页 277 / PDF页 298。

### 1. 原文陈述

> For example, analysis shows that the schemes denoted $`[AOAB]`$ or $`[BAOA]`$ both exhibit a first order error in the covariance $`\langle qp\rangle_h=O(h)`$, however they give exact results for both $`\langle q^2\rangle_h`$ and $`\langle p^2\rangle_h`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m ∧
    (∫ x, x.1*x.2 ∂μ) = (if flip then -θ*h/2 else θ*h/2) := by
  sorry

theorem nonsymmetricMixedMoment_order (θ : ℝ) (flip : Bool) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ if flip then -θ*h/2 else θ*h/2) (fun h : ℝ ↦ h) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。
- 本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。
- 29号覆盖限定：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。flip=true 执行 AOAB（两段 A 各 h/2），false 执行 BAOA；正参数、稳定范围、L² 和不变推前下两个精确二阶矩结论合理。但是原文另外断言的 ⟨qp⟩_h=O(h) 完全未出现在结论中，尽管 extra\_assumptions 承认缺口，仍不是原文完整结论的形式化。
网站复审结论：PASS。所有概率、积分和稳定性前提均显式。MemLp二阶在概率测度下足以保证q²、p²及qp的可积性；μ的不变性使用新独立标量标准高斯。两个精确二阶矩及混合矩符号与定义的两个算法一致，Big-O声明适用于固定参数。原文将混合矩称协方差；在此非退化稳定谐振子模型中平稳一阶矩为零，表述相容。未因sorry判失败。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。

### 7. 状态与证明位置

- `MD.Ch07.nonsymmetricHarmonicStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.nonsymmetricExactMoments`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.nonsymmetricMixedMoment_order`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStar

印刷页 277–278 / PDF页 298–299。

### 1. 原文陈述

> Example 7.2 Consider the variant of the BBK integrator that recycles the random number between steps:
> Brünger-Brooks-Karplus with post-step re-use of random number (BBK*)

$$
p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,
$$



$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_{n+1}]/(1+h\gamma/2),
$$


> where $`R_n`$ is a vector of normal random numbers with zero mean and unit variance.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkStarTrajectory, bbkStarNoise 所列对象、量词、前提和结论。范围说明：递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkStarTrajectory, bbkStarNoise 所列对象、量词、前提和结论。范围说明：递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarTrajectory`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bbkStarNoise`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStarCorrelations

印刷页 278 / PDF页 299。

### 1. 原文陈述

> Denoting the entries of $`\Psi^{\rm BBK*}`$ by $`\psi_{ij}`$ we have

$$
\mathbb E(\mu_{n,2}p_n)=\mathbb E((\kappa_2R_n+\kappa_3R_{n+1})(\psi_{21}q_{n-1}+\psi_{22}p_{n-1}+\kappa_2R_{n-1}+\kappa_3R_n))=\kappa_2\kappa_3.
$$


> Additionally it is easily shown that

$$
\mathbb E(\mu_{n,1}q_n)=\mathbb E(\mu_{n,2}q_n)=0,\quad \mathbb E(\mu_{n,1}p_n)=\kappa_1\kappa_3,
$$


> with $`\mathbb E(\mu_{n,1}^2)=\kappa_1^2`$, $`\mathbb E(\mu_{n,1}\mu_{n,2})=\kappa_1\kappa_2`$, $`\mathbb E(\mu_{n,2}^2)=\kappa_2^2+\kappa_3^2`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem bbkStarCorrelations (P : Measure Ω) [IsProbabilityMeasure P]
    (R S Qold Pold : Ω → ℝ) (a b c d κ1 κ2 κ3 : ℝ)
    (hR : HasLaw R (gaussianReal 0 1) P) (hS : HasLaw S (gaussianReal 0 1) P)
    (hind : IndepFun (fun sample ↦ (Qold sample,Pold sample)) (fun sample ↦ (R sample,S sample)) P)
    (hRS : IndepFun R S P) (hq : MemLp Qold 2 P) (hp : MemLp Pold 2 P) :
    let q := fun sample ↦ a*Qold sample+b*Pold sample
    let p := fun sample ↦ c*Qold sample+d*Pold sample+κ3*R sample
    let u := fun sample ↦ κ1*R sample
    let v := fun sample ↦ κ2*R sample+κ3*S sample
    (∫ sample, v sample*p sample ∂P) = κ2*κ3 ∧
    (∫ sample, u sample*q sample ∂P) = 0 ∧
    (∫ sample, v sample*q sample ∂P) = 0 ∧
    (∫ sample, u sample*p sample ∂P) = κ1*κ3 ∧
    (∫ sample, (u sample)^2 ∂P) = κ1^2 ∧
    (∫ sample, u sample*v sample ∂P) = κ1*κ2 ∧
    (∫ sample, (v sample)^2 ∂P) = κ2^2+κ3^2 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkStarCorrelations 所列对象、量词、前提和结论。范围说明：七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Qold/Pold代表吸收R_{n-1}后仍独立于未来R\_n,R_{n+1}的旧状态组合；不把当前p与R\_n假设独立。
- 所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkStarCorrelations 所列对象、量词、前提和结论。范围说明：七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarCorrelations`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStarMomentSystemPrinted

印刷页 278–279 / PDF页 299–300。

### 1. 原文陈述

> Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives

$$
Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+2\psi_{12}\kappa_1 2\psi_{12}\kappa_1\kappa_3+\kappa_1^2,
$$



$$
P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+2\psi_{22}\kappa_2 2\psi_{22}\kappa_2\kappa_3+\kappa_2^2+\kappa_3^2,
$$



$$
C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\kappa_1\kappa_2+\psi_{12}\kappa_2\kappa_3+\psi_{22}\kappa_1\kappa_3.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。
- 29号覆盖限定：保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。Printed 前两式忠实保留原页相邻重复因子，第三式亦一致。corrected 用条目16及(7.8)–(7.10)恢复 2bκ1κ3、2dκ2κ3，改动正确。counterexample 的实数不等式是 4≠2，正确，说明重复因子不能一般删除为恒等变形；它不是完整随机平稳模型的反例。原文版忠实性 PASS、修正版代数正确性 PASS，原书排印勘误交人工。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarMomentSystemPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.bbkStarMomentSystemPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.bbkStarExtraFactor_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4.2-BBKStarStationary

印刷页 279 / PDF页 300。

### 1. 原文陈述

> Finally, solving the simultaneous equations gives the stationary observed averages as

$$
\langle q^2\rangle_h^{\rm BBK*}=\frac{k_BT}{\Omega^2}(1-\frac{\Omega^2h^2}{4m})^{-1},\qquad \langle p^2\rangle_h^{\rm BBK*}=k_BTm(1+\frac{\gamma h}2)^{-1},\qquad \langle qp\rangle_h^{\rm BBK*}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkStarStationaryAlgebra 所列对象、量词、前提和结论。范围说明：hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkStarStationaryAlgebra 所列对象、量词、前提和结论。范围说明：hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。

### 7. 状态与证明位置

- `MD.Ch07.bbkStarStationaryAlgebra`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.5-PerturbedHamiltonian

印刷页 279 / PDF页 300。

### 1. 原文陈述

> We consider sampling canonically the Hamiltonian

$$
H(q,p)=p^2/2+q^2/2+\epsilon q^4/4,\tag{7.13}
$$


> using Langevin dynamics, where $`q,p\in\mathbb R`$, with a small nonlinearity parameter $`\epsilon\gt 0`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def perturbedPotential (ε q : ℝ) : ℝ := q^2/2+ε*q^4/4
def perturbedHamiltonian (ε : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/2+perturbedPotential ε x.1
def perturbedGibbs (ε : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-perturbedHamiltonian ε x)
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def perturbedStep (s : Fin 4) (ε γ h R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let m : V 1 := fun _ ↦ 1
  let U : V 1 → ℝ := fun q ↦ perturbedPotential ε (q 0)
  scalarLift (if s = 0 then aboba m U γ 1 h (fun _ ↦ R)
    else if s = 1 then baoab m U γ 1 h (fun _ ↦ R)
    else if s = 2 then obabo m U γ 1 h (fun _ ↦ R) (fun _ ↦ S)
    else oabao m U γ 1 h (fun _ ↦ R) (fun _ ↦ S))
def perturbedStationary (s : Fin 4) (ε γ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ perturbedStep s ε γ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 perturbedPotential, perturbedHamiltonian, perturbedGibbs, perturbedStep, perturbedStationary 所列对象、量词、前提和结论。范围说明：势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。
- 分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 perturbedPotential, perturbedHamiltonian, perturbedGibbs, perturbedStep, perturbedStationary 所列对象、量词、前提和结论。范围说明：势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。

### 7. 状态与证明位置

- `MD.Ch07.perturbedPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedHamiltonian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbedStationary`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.5-PerturbedErrorExpansion

印刷页 280 / PDF页 301。

### 1. 原文陈述

> We find that truncating the update equations to $`O(\epsilon^3)`$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:

$$
\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle=\frac{3h^2\epsilon[48\epsilon-4+3\gamma^2(9\epsilon-1)]}{12\gamma^2+16}+O(\epsilon h^4+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle=-\frac{9h^2\epsilon^2}{6\gamma^2+8}-\frac{3h^4\epsilon^2[6\gamma^4+19\gamma^2+16]}{8(3\gamma^2+4)^2}+O(\epsilon^2h^6+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle=h^2\left(\frac14+\frac{\epsilon[144\epsilon+81\epsilon\gamma^2-9\gamma^2-12]}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2),
$$



$$
\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle=-h^2\left(\frac14+\frac{18\epsilon^2}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2).\tag{7.14}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def perturbedLeading (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then 3*h^2*ε*(48*ε-4+3*γ^2*(9*ε-1))/(12*γ^2+16)
  else if s = 1 then -9*h^2*ε^2/(6*γ^2+8)-3*h^4*ε^2*(6*γ^4+19*γ^2+16)/(8*(3*γ^2+4)^2)
  else if s = 2 then h^2*(1/4+ε*(144*ε+81*ε*γ^2-9*γ^2-12)/(12*γ^2+16))
  else -h^2*(1/4+18*ε^2/(12*γ^2+16))
def perturbedRemainder (s : Fin 4) (ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^4+ε^3*h^2
  else if s = 1 then ε^2*h^6+ε^3*h^2 else h^4+ε^3*h^2
def positivePairLimit : Filter (ℝ × ℝ) :=
  𝓝[Set.Ioi (0 : ℝ) ×ˢ Set.Ioi (0 : ℝ)] (0,0)
theorem perturbedErrorExpansion (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)-perturbedLeading s γ z.1 z.2)
      (fun z ↦ perturbedRemainder s z.1 z.2) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | (7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。
- 实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。
- 29号覆盖限定：(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。四种 leading 和 remainder 的所有系数、正负号、幂次与(7.14)一致。positivePairLimit 是 (ε,h) 同时从正象限趋零；γ固定且为正。hinv 仅要求最终存在实际平稳 L² 概率分布；结论却给出任意该类族的统一双参数 Big-O。原页说明的是形式截断计算，未提供如此强的严格余项控制，不能以系数抄写一致批准严格定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。

### 7. 状态与证明位置

- `MD.Ch07.perturbedLeading`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.perturbedRemainder`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.positivePairLimit`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.perturbedErrorExpansion`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.5-PerturbedErrorOrders

印刷页 280 / PDF页 301。

### 1. 原文陈述

> The behavior of the methods can thus be summarized as

$$
|\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle|=O(\epsilon h^2),\qquad |\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle|=O\left(\frac{\epsilon^2h^2}{1+\gamma^2}+\epsilon^2h^4\right),
$$



$$
|\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle|=O(h^2),\qquad |\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle|=O(h^2).\tag{7.15}
$$


> The twofold surprising result though, is that (a) the leading error of the $`[BAOAB]`$ scheme has behavior proportional to $`\epsilon^2`$, while (b) the leading order term of the $`[BAOAB]`$ scheme is annihilated for large $`\gamma`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def perturbedErrorScale (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^2 else if s = 1 then ε^2*h^2/(1+γ^2)+ε^2*h^4 else h^2
theorem perturbedErrorOrders (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ |momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)|)
      (fun z ↦ perturbedErrorScale s γ z.1 z.2) := by
  sorry
theorem baoabLeading_largeFriction (ε h : ℝ) :
    Filter.Tendsto (fun γ : ℝ ↦ -9*h^2*ε^2/(6*γ^2+8)) Filter.atTop (𝓝 0) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 29号覆盖限定：固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。perturbedErrorScale 四种公式对应(7.15)，绝对值与 IsBigO 的固定 γ 正向双参数极限一致。baoabLeading\_largeFriction 只针对 -9h²ε²/(6γ²+8) 的大摩擦极限，正确；不证明完整误差关于 γ 的一致界。extra\_assumptions 中称 ε³h² 余项不足以推出固定 γ 的 ε²h²+ε²h⁴ 界不正确：ε→0 时 ε³≤ε²，且固定 γ 的 1/(1+γ²)>0 是常数。严格平稳分布渐近仍继承条目20的待确认问题。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。

### 7. 状态与证明位置

- `MD.Ch07.perturbedErrorScale`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.perturbedErrorOrders`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.baoabLeading_largeFriction`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-GibbsComposition

印刷页 282 / PDF页 303。

### 1. 原文陈述

> The flows of each of these systems individually preserves the Gibbs distribution: denoting the Fokker-Planck operators associated to these flows by $`\mathcal L_H^\dagger`$ and $`\mathcal L_O^\dagger`$ we have

$$
\mathcal L_H^\dagger\rho_\beta=0,\qquad\mathcal L_O^\dagger\rho_\beta=0,
$$


> and hence

$$
\exp(t\mathcal L_H^\dagger)\rho_\beta=\exp(t\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.
$$


> For a scheme $`[HO]`$, we have

$$
\exp(h\mathcal L_O^\dagger)[\exp(h\mathcal L_H^\dagger)\rho_\beta]=\exp(h\mathcal L_O^\dagger)\rho_\beta=\rho_\beta.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。
- 29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。
- 覆盖缺口：29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。gibbsComposition 对任意 E、自映射 P,Q 及共同固定点 ρ 的复合固定点恒等式正确。但原文包含 H/O 的实际生成元、Gibbs 密度、两个生成元为零及其半群固定点关系；这些对象均未在本条声明出现。把两种不变性直接当作 hP,hQ 只覆盖最后一步，extra\_assumptions 的承认不补足整条结论。
网站复审结论：PASS。gibbsComposition PASS，正确形式化原页最后一步的抽象固定点论证。其hP、hQ是已给定假设，不是由H/O微分方程推得；类型E无测度或半群结构。statement\_scope和coverage\_gaps对此作了明确限制，因此只在该范围内通过，不将此定理当作H/O各自Gibbs不变性的证明。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。

### 7. 状态与证明位置

- `MD.Ch07.gibbsComposition`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-DivergenceFreeInvariant

印刷页 282 / PDF页 303。

### 1. 原文陈述

> Given any divergence free vector field $`f`$, we have

$$
-\nabla\cdot(f\rho)=-f\cdot\nabla\rho,
$$


> thus $`\mathcal L_f^\dagger\rho=-\mathcal L_f\rho`$.
> If $`\mathcal L_f`$ preserves a first integral $`I`$, then $`\mathcal L_f`$ preserves any distribution which is a function of $`I`$. It follows that any energy-preserving, divergence free vector field will always preserve the Gibbs distribution.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def lieField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  (fderiv ℝ ρ x) (f x)
def divergenceField (f : V n → V n) (x : V n) : ℝ :=
  ∑ i, coordDerivative (fun y ↦ f y i) x i
def forwardField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  -∑ i, coordDerivative (fun y ↦ f y i*ρ y) x i
theorem divergenceFreeInvariant (f : V n → V n) (ρ : V n → ℝ)
    (hf : ContDiff ℝ 1 f) (hρ : ContDiff ℝ 1 ρ)
    (hdiv : ∀ x, divergenceField f x = 0) : ∀ x, forwardField f ρ x = -lieField f ρ x := by
  sorry
theorem firstIntegral_density (f : V n → V n) (I : V n → ℝ) (g : ℝ → ℝ)
    (hI : Differentiable ℝ I) (hg : Differentiable ℝ g)
    (hfirst : ∀ x, lieField f I x = 0) : ∀ x, lieField f (g ∘ I) x = 0 := by
  intro x
  rw [lieField, fderiv_comp x (hg (I x)) (hI x)]
  simp only [ContinuousLinearMap.comp_apply]
  change (fderiv ℝ g (I x)) (lieField f I x) = 0
  rw [hfirst x, map_zero]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。
- 不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。
- 29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。
- 覆盖缺口：29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。lieField 为实际 Fréchet 导数沿 f 的作用；coordDerivative、divergenceField、forwardField 定义给出的符号和负号正确。C¹ 前提足以推出散度乘积公式；firstIntegral\_density 用 I,g 可微及第一积分零给出复合第一积分，正确。结论只到生成元为零，没有 Gibbs 密度的特化、概率归一化或全局流保持测度的陈述，因而未覆盖原文最后的分布不变结论。
网站复审结论：PASS。两个定理的对象、正则性、全称量词及负号都正确。firstIntegral\_density本身只给Lie导数为零；与前一个散度自由恒等式组合后才能得到生成元湮灭相应密度。非负、归一化和全局流存在条件在extra\_assumptions中明确另列，未被省略成无条件概率不变性。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。

### 7. 状态与证明位置

- `MD.Ch07.lieField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.divergenceField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.forwardField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.divergenceFreeInvariant`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.firstIntegral_density`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-GeMarsdenRestriction

印刷页 282 / PDF页 303。

### 1. 原文陈述

> All symplectic methods preserve the volume, but for a system with no first integrals except the energy, it is known from a theorem of Ge and Marsden [400] that a symplectic method cannot preserve the system energy exactly (unless the symplectic method is itself a time-reparameterization of the exact solution).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def onlyEnergyIntegrals (H : V n → ℝ) (f : V n → V n) : Prop :=
  ∀ I : V n → ℝ, ContDiff ℝ ⊤ I → (∀ x, lieField f I x = 0) →
    ∃ g : ℝ → ℝ, I = g ∘ H
def timeReparametrizes {E : Type*} (G flow : ℝ → E → E) : Prop :=
  ∃ τ : ℝ → E → ℝ, ∀ h x, G h x = flow (τ h x) x
def geMarsdenConclusion {k : ℕ}
    (H : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (G flow : ℝ → MolecularDynamics.SymplecticCoordinates k → MolecularDynamics.SymplecticCoordinates k) : Prop :=
  MolecularDynamics.Chapter02Review.symplecticIntegrator G →
  (∀ h x, H (G h x) = H x) → timeReparametrizes G flow
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。
- 辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。
- 29号覆盖限定：只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。onlyEnergyIntegrals在Fin n→ℝ上量化全部光滑第一积分，并要求全局分解I=g∘H；g没有光滑性条件。timeReparametrizes允许τ依赖步长和初值且无连续/单调/非退化条件。geMarsdenConclusion只定义“辛且保能量⇒沿给定flow轨道”，未包含onlyEnergyIntegrals，也未约束flow为H的精确流；三个定义没有连成原文限定定理，辛映射保体积亦未陈述。D3–D8的辛条件是C¹且DΦᵀJDΦ=J，含义本身正确。JSON已承认主要缺口，但原书简述的定理技术条件不能由本页确定，保留原文并交人工。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。

### 7. 状态与证明位置

- `MD.Ch07.onlyEnergyIntegrals`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.timeReparametrizes`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.geMarsdenConclusion`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

