[上一部分](part01.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

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

## MD-7.6-JSplitting

印刷页 282–283 / PDF页 303–304。

### 1. 原文陈述

> Let $`J`$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $`J`$ into a finite number $`K`$ of skew-symmetric matrices $`J_i`$, $`i=1,\ldots,K`$. This induces a splitting of the Hamiltonian vector field into $`K`$ vector fields $`f_i=J_i\nabla H`$. Each of these vector fields preserves $`H`$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]

theorem jField_finiteDecomposition {K : ℕ} (J : Fin K → Matrix (Fin n) (Fin n) ℝ)
    (H : V n → ℝ) (hJ : ∀ k i j, J k i j = -J k j i) :
    jField (∑ k, J k) H = fun x ↦ ∑ k, jField (J k) H x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。
- 体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。
- 29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。
- 覆盖缺口：29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。jField是常矩阵乘坐标梯度；jSplitting\_energy在H∈C²、J反对称下给出每一点Lie导数为零及散度为零，符号正确。composition\_preservesEnergy对任意两个已保H的映射复合也正确。但无K族、∑Ji=J、∑fi=J∇H，没有流满足ODE及流保体积结论，也无复合流对原动力学的一致近似。散度零不等于签名已声明流保体积。extra\_assumptions说明缺口，却不补齐“本条全部对象与公式”的覆盖。
网站复审结论：PASS。所列定义与三个定理完整覆盖明示的常反对称矩阵代数、微分结论及已保能映射复合，不把散度为零直接冒称为已建立全局保体积流。有限分解定理没有将矩阵和固定为标准J，但适用于原文J=∑J\_i的代入；hJ对线性求和恒等式虽非必要，仍与原文条件一致。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。

### 7. 状态与证明位置

- `MD.Ch07.jField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.jSplitting_energy`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.composition_preservesEnergy`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.jField_finiteDecomposition`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-CoordinateJSplitting

印刷页 283 / PDF页 304。

### 1. 原文陈述

> As an example of such a $`J`$-splitting, we may take $`K=N_c`$ with each $`J_i`$ to be defined by the components of the canonical symplectic structure matrix having to do with the $`i`$th position and momentum pair, thus the equations of motion for the $`i`$th vector field become

$$
\dot q_i=p_i/m_i,\qquad \dot p_i=-\frac{\partial U}{\partial q_i}(\bar q_1,\ldots,\bar q_{i-1},q_i,\bar q_{i+1},\ldots,\bar q_{N_c}),
$$


> where components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)

def coordinateJQualification (m : V n) (U : V n → ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 U

theorem frozenPotential_deriv (m : V n) (U : V n → ℝ)
    (hq : coordinateJQualification m U) (q : V n) (i : Fin n) :
    deriv (frozenPotential U q i) (q i) = gradient U q i := rfl
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。
- 29号覆盖限定：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。
- 覆盖缺口：完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。Phase n=V n×V n，coordinateJField只在第i对分量非零，速度pi/mi和力−∂iU正确；frozenPotential正确使用Function.update冻结其余位置。没有mi>0或至少mi≠0以及U光滑性的物理资格，但这两个总函数定义可在更大域定义。未陈述冻结势的导数等于该力，亦没有一自由度求积可积性或流/顺序更新结论。JSON已承认求积缺口；完整所引陈述仍未覆盖。
网站复审结论：PASS。对象均为Phase n或V n，索引i:Fin n，未遗漏冻结坐标。资格命题不自动限制coordinateJField的所有调用，物理使用时需引用。Lean的结论只是冻结势的导数识别，分支、转折点、积分反演和全局流未覆盖，已披露；不因此否定当前限定范围内的正确签名。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。

### 7. 状态与证明位置

- `MD.Ch07.coordinateJField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.frozenPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.coordinateJQualification`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.frozenPotential_deriv`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7-ModifiedGenerator

印刷页 284 / PDF页 305。

### 1. 原文陈述

> We begin by defining the generator $`\widehat{\mathcal L}`$ associated to the propagation of averages under the numerical method for an SDE. We think of this generator as a perturbation of the exact Langevin dynamics generator $`\mathcal L_{LD}`$, or

$$
\widehat{\mathcal L}=\mathcal L_{LD}+h\mathcal L_1+h^2\mathcal L_2+h^3\mathcal L_3+O(h^4).\tag{7.16}
$$


> However, the operators involved are not equivalent to the operators that would arise from any stochastic differential equation (see [403]), so we must give up the direct analogy between the formal series and continuous SDE models (which is available in the deterministic setting).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def formalModifiedGenerator {R : Type*} [Ring R] [Algebra ℝ R]
    (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun k ↦ PowerSeries.coeff (k+1) (MolecularDynamics.textbookFormalOperatorLogarithm S))
def formalGeneratorExpansion {R : Type*} [Ring R] [Algebra ℝ R]
    (L : PowerSeries R) (L0 L1 L2 L3 : R) : Prop :=
  PowerSeries.coeff 0 L = L0 ∧ PowerSeries.coeff 1 L = L1 ∧
  PowerSeries.coeff 2 L = L2 ∧ PowerSeries.coeff 3 L = L3
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只取形式幂级数系数；O(h⁴)在此意为0–3阶系数相等，不宣称无界算符级数收敛，也不声称是另一SDE的生成元。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。

### 7. 状态与证明位置

- `MD.Ch07.formalModifiedGenerator`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.formalGeneratorExpansion`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7-InvariantDensityExpansion

印刷页 284 / PDF页 305。

### 1. 原文陈述

> We write this invariant distribution as a perturbation of the (target) canonical distribution

$$
\widehat\rho=\rho_\beta[1+hf_1+h^2f_2+h^3f_3+O(h^4)],\tag{7.17}
$$


> with each correction function $`f_k(q,p)`$ satisfying

$$
\int_{\mathcal D} f_k(q,p)\rho_\beta(q,p)d\omega=0,
$$


> ensuring a useful equivalence in the partition function

$$
\int_{\mathcal D}\widehat\rho(q,p)d\omega=\int_{\mathcal D}\rho_\beta(q,p)d\omega.
$$


> Our computed average is therefore $`\langle\phi\rangle_h\stackrel{\rm def}=\int_{\mathcal D}\phi(q,p)\widehat\rho(q,p)d\omega`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def densityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => ρ
  | k+1 => fun x ↦ ρ x*f (k+1) x
def centeredCorrections (μ : Measure Ω) (f : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ k, 0 < k → Integrable (f k) μ ∧ (∫ x, f k x ∂μ) = 0
def computedAverage (ν : Measure Ω) (φ ρhat : Ω → ℝ) : ℝ := ∫ x, φ x*ρhat x ∂ν
theorem densityExpansion_zeroMass (ν : Measure Ω) (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ)
    (hρ : Integrable ρ ν)
    (hf : ∀ k, 0 < k → Integrable (fun x ↦ ρ x*f k x) ν ∧ (∫ x, ρ x*f k x ∂ν) = 0) :
    ∀ k, (∫ x, densityExpansion ρ f k x ∂ν) = if k = 0 then ∫ x, ρ x ∂ν else 0 := by
  intro k
  cases k with
  | zero => simp [densityExpansion]
  | succ k => simpa [densityExpansion] using (hf (k+1) (Nat.zero_lt_succ k)).2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion\_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 系数零质量不等于任意h的截断密度非负；概率密度仍须非负、可积且归一。余项质量也为零或完整级数可交换积分时才推出精确总质量一致。
- 此处证明所有形式系数的质量约束；未把有限截断表达式假称实际不变概率。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion\_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。

### 7. 状态与证明位置

- `MD.Ch07.densityExpansion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.centeredCorrections`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.computedAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.densityExpansion_zeroMass`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-ExactABOPropagators

印刷页 285 / PDF页 306。

### 1. 原文陈述


$$
(e^{t\mathcal L_A}\phi)(q,p)=\phi(q+tM^{-1}p,p),\qquad (e^{t\mathcal L_B}\phi)(q,p)=\phi(q,p-t\nabla U(q)),
$$



$$
(e^{t\mathcal L_O}\phi)(q,p)=\int_{\mathcal P}\phi(q,e^{-\gamma t}p+\zeta M^{1/2}x)\frac{e^{-|x|^2/2}}{(2\pi)^{N_c/2}}dx,
$$


> where $`\zeta=[k_BT(1-e^{-2\gamma t})]^{1/2}`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。
- 半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。

### 7. 状态与证明位置

- `MD.Ch07.propagateA`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.propagateB`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.propagateO`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-OperatorOrderReversal

印刷页 285 / PDF页 306。

### 1. 原文陈述

> For example, for the method labelled by the string $`[ABAO]`$, we have

$$
\exp(h\widehat{\mathcal L}_{[ABAO]})=\exp((h/2)\mathcal L_A)\exp(h\mathcal L_B)\exp((h/2)\mathcal L_A)\exp(h\mathcal L_O),
$$


> where importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $`\widehat{\mathcal L}^\dagger`$, which we may compute as

$$
\exp(h\widehat{\mathcal L}_{[ABAO]}^\dagger)=\exp(h\mathcal L_O^\dagger)\exp((h/2)\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp((h/2)\mathcal L_A^\dagger).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))

theorem fourStage_duality {E : Type*} [AddCommGroup E] [Module ℝ E]
    (pair : E → E → ℝ) (A B C D a b c d : Module.End ℝ E)
    (hA : ∀ x y, pair (A x) y = pair x (a y))
    (hB : ∀ x y, pair (B x) y = pair x (b y))
    (hC : ∀ x y, pair (C x) y = pair x (c y))
    (hD : ∀ x y, pair (D x) y = pair x (d y)) (x y : E) :
    pair (A (B (C (D x)))) y = pair x (d (c (b (a y)))) := by
  rw [hA,hB,hC,hD]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。
- 伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。
- 29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。
- 覆盖缺口：29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。pullback\_order是φ∘(B∘A)=(φ∘B)∘A；结合拉回算子定义可说明顺序反转，但它本身仅为复合结合律。abaoBackward的嵌套次序和h/2系数正确。没有任何伴随对象或前向O A B A四段乘积，因而原文明确给出的第二条主等式未覆盖；extra\_assumptions只登记缺口。也未将此定义与实际离散随机映射的期望识别。
网站复审结论：PASS。后向定义、拉回等式及抽象反序对偶定理的对象和顺序正确。propagateO作为积分的总化定义对任意实参数和φ都有Lean值，但物理Markov半群解释还需适用参数、可测/可积资格；本条没有提出无条件半群识别定理。fourStage\_duality的结论完全由已给出的hA–hD推出，没有将未定义的密度伴随或无界算子域隐含为已完成。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.pullback_order`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.abaoBackward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fourStage_duality`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-StationaryModifiedPDE

印刷页 285–286 / PDF页 306–307。

### 1. 原文陈述

> Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $`\rho`$ is given by

$$
\frac\partial{\partial t}\rho(z,t)=\widehat{\mathcal L}^\dagger\rho,
$$


> with the important case of its invariant distribution satisfying the partial differential equation

$$
\widehat{\mathcal L}^\dagger\widehat\rho=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。
- Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。
- 29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。
- 覆盖缺口：29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。formalDensityEvolution对所有实t用HasDerivAt，且L为有界连续线性算子E→L[ℝ]E；原书Langevin/修改微分算子通常无界并需定义域，时间通常t≥0。stationaryModifiedDensity只是任意代数线性自映射的核条件，无密度资格，也未与前一个L识别。二者作为抽象定义有意义，不能据此确认原离散分布真实满足连续Fokker–Planck演化。原页把离散传播与连续方程直接联结需要形式解释或嵌入条件；JSON已提醒，须人工限定，不能静默改成普遍真实PDE。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。

### 7. 状态与证明位置

- `MD.Ch07.formalDensityEvolution`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.stationaryModifiedDensity`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-TwoOperatorBCH

印刷页 286 / PDF页 307。

### 1. 原文陈述

> Recall that for linear operators $`X`$ and $`Y`$, we can write the composition of their exponentials as

$$
\exp(hX)\exp(hY)=\exp(hZ),
$$


> where we have the expansion

$$
Z=X+Y+\frac h2[X,Y]+\frac{h^2}{12}([X,[X,Y]]+[Y,[Y,X]])+O(h^3).
$$


> The notation $`[X,Y]\stackrel{\rm def}=XY-YX`$ represents the commutator of the operators $`X`$ and $`Y`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def comm {R : Type*} [Ring R] (X Y : R) : R := X*Y-Y*X
def twoStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential X * MolecularDynamics.textbookFormalOperatorExponential Y
theorem twoOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (twoStage X Y)) = X+Y ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (twoStage X Y)) = (1/2 : ℝ) • comm X Y ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (twoStage X Y)) =
      (1/12 : ℝ) • (comm X (comm X Y)+comm Y (comm Y X)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。

### 7. 状态与证明位置

- `MD.Ch07.comm`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.twoStage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.twoOperatorBCH`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-TaylorRemainder

印刷页 286–287 / PDF页 307–308。

### 1. 原文陈述

> We can make use of Taylor’s theorem to write the identity

$$
P_h=P_0+h\left.\frac{dP_t}{dt}\right|_{t=0}+\cdots+\frac{h^n}{n!}\left.\frac{d^nP_t}{dt^n}\right|_{t=0} +\frac{h^{n+1}}{n!}\int_0^1(1-\lambda)^n\left.\frac{d^{n+1}P_t}{dt^{n+1}}\right|_{t=\lambda h}d\lambda,
$$


> for some finite truncation index $`n\in\{1,2,3,\ldots\}`$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry

theorem propagatedObservable_remainder {E : Type*} (P : ℝ → (E → ℝ) → E → ℝ)
    (φ : E → ℝ) (z : E) (k : ℕ)
    (htime : ContDiff ℝ (k+1) (fun t ↦ P t φ z)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ P h φ z-∑ j ∈ Finset.range (k+1),
        h^j/(Nat.factorial j : ℝ)*iteratedDeriv j (fun t ↦ P t φ z) 0)
      (fun h ↦ h^(k+1)) := taylorRemainder_bound _ k htime
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。
- 29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。
- 覆盖缺口：29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。taylorRemainder对标量F∈C^(k+1)、所有实h给出正确积分余项，k∈ℕ还合法扩展到0阶。taylorRemainder\_bound是h→0的标量局部O(h^(k+1))，正确但其常数可依赖F。没有P\_t作用在紧支撑可观测量后满足这些假设的桥，也无相空间/算子范数意义下的余项界；不能把逐点标量结论作为原文算子/观测量余项资格的完整审校通过。extra\_assumptions已承认范围缩减。
网站复审结论：PASS。三个声明量化所有k:ℕ；原文n≥1的情形包含其中，额外k=0情形合法。最后一个结论对给定φ,z成立，Big-O常数可依赖它们；并不提供对空间点或测试函数族的统一控制。P是任意时间算子族而不是已识别的ABO半群，htime没有被悄然由紧支撑推得；与明示限定范围一致。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。

### 7. 状态与证明位置

- `MD.Ch07.taylorRemainder`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.taylorRemainder_bound`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.propagatedObservable_remainder`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-ThreeOperatorBCH

印刷页 287 / PDF页 308。

### 1. 原文陈述


$$
\exp(hS)=\exp(hZ)\exp(hY)\exp(hX).\tag{7.18}
$$



$$
S=X+Y+Z+\frac h2([Z,Y]+[Z,X]+[Y,X])+\frac{h^2}{4}[Z,Y,X] +\frac{h^2}{12}([Y,Y,X]+[X,X,Y]+[Z,Z,Y]+[Z,Z,X]+[Y+X,Y+X,Z])+\cdots
$$


> where the notation $`[A,B,C]`$ is notation for $`[A,[B,C]]`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def threeStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential Z *
    MolecularDynamics.textbookFormalOperatorExponential Y * MolecularDynamics.textbookFormalOperatorExponential X
theorem threeOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (threeStage X Y Z)) = X+Y+Z ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/2 : ℝ) • (comm Z Y+comm Z X+comm Y X) ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/4 : ℝ) • comm Z (comm Y X)+(1/12 : ℝ) •
        (comm Y (comm Y X)+comm X (comm X Y)+comm Z (comm Z Y)+
          comm Z (comm Z X)+comm (Y+X) (comm (Y+X) Z)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。

### 7. 状态与证明位置

- `MD.Ch07.threeStage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.threeOperatorBCH`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-ScalarForwardOperators

印刷页 288 / PDF页 309。

### 1. 原文陈述

> In this one dimensional example, we substitute

$$
Z=\mathcal L_A^\dagger=-p\frac\partial{\partial q},\quad Y=\mathcal L_B^\dagger=U'(q)\frac\partial{\partial p},\quad X=\mathcal L_O^\dagger=\gamma\left({\rm Id}+p\frac\partial{\partial p}\right)+\frac{\sigma^2}{2}\frac{\partial^2}{\partial p^2},
$$


> where $`\sigma=\sqrt{2\gamma k_BT}`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
abbrev Density1 := (ℝ × ℝ) → ℝ
def dq (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun q ↦ f (q,x.2)) x.1
def dp (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun p ↦ f (x.1,p)) x.2
def opA (f : Density1) (x : ℝ × ℝ) : ℝ := -x.2*dq f x
def opB (U : ℝ → ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := deriv U x.1*dp f x
def opO (γ θ : ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := γ*(f x+x.2*dp f x)+γ*θ*dp (dp f) x
def opLD (U : ℝ → ℝ) (γ θ : ℝ) (f : Density1) : Density1 := opA f+opB U f+opO γ θ f
def opComm (A B : Density1 → Density1) (f : Density1) : Density1 := A (B f)-B (A f)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 所有偏导都是实际deriv，单位质量、θ=k\_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。

### 7. 状态与证明位置

- `MD.Ch07.Density1`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.dq`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.dp`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opA`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opB`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opO`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opLD`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opComm`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-CommutatorAB

印刷页 288 / PDF页 309。

### 1. 原文陈述


$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-p\frac\partial{\partial q}\left(U'(q)\frac{\partial\rho}{\partial p}\right)-U'(q)\frac\partial{\partial p}\left(-p\frac{\partial\rho}{\partial q}\right) =-pU''(q)\rho_p-pU'(q)\rho_{pq}+U'(q)\rho_q+U'(q)p\rho_{qp}.
$$


> As this is the commutator of two 1st order differential operators, the mixed partial term vanishes, leaving

$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-pU''(q)\rho_p+U'(q)\rho_q.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。

### 7. 状态与证明位置

- `MD.Ch07.commutatorAB`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-CommutatorsAOBO

印刷页 289 / PDF页 310。

### 1. 原文陈述

> Similar computations give

$$
[\mathcal L_A^\dagger,\mathcal L_O^\dagger]\rho=\gamma p\rho_q+\sigma^2\rho_{qp},\qquad [\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho=\gamma U'(q)\rho_p.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。

### 7. 状态与证明位置

- `MD.Ch07.commutatorsAOBO`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-OBAModifiedOperator

印刷页 288–289 / PDF页 309–310。

### 1. 原文陈述


$$
\exp(h\widehat{\mathcal L}_{[OBA]}^\dagger)=\exp(h\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp(h\mathcal L_O^\dagger).
$$



$$
\widehat{\mathcal L}_{[OBA]}^\dagger\rho=\mathcal L_{LD}^\dagger\rho+\frac h2[-pU''(q)\rho_p+U'(q)\rho_q+\gamma p\rho_q+\sigma^2\rho_{qp}+\gamma U'(q)\rho_p]+O(h^2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。
- 29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。
- 覆盖缺口：29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。obaFirstCorrection以θ替代kBT，五项各乘1/2，正确。obaFirstCorrection\_commutators在C³下仅证明此表达式等于三个实际交换子之和的一半，完全正确。但没有OBA前向乘积对象、log/h系数、LLD零阶或余项陈述，未把该函数认定为数值方案修改生成元的一阶系数。extra\_assumptions承认该桥未做，因而完整两条原式的覆盖仍FAIL；不是因sorry或证明状态。
网站复审结论：PASS。单位质量的一维设定下，θ=k\_BT给σ²=2γθ，五个导数项的符号和系数全部一致。U、ρ的C³资格足以展开三项真实交换子和交换混合偏导；γ、θ无需正性即可成立该纯微分代数恒等式。公式中的O(h²)属于源文的形式修改生成元展开，当前Lean并无关于h、乘积对数或余项范数的结论，且已准确披露。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。

### 7. 状态与证明位置

- `MD.Ch07.obaFirstCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obaFirstCorrection_commutators`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-SpectralQualification

印刷页 289 / PDF页 310。

### 1. 原文陈述

> The assumption of validity becomes more credible as we find that the operator $`\mathcal L_{LD}^\dagger`$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $`\rho_\beta`$ and all the remaining eigenvalues lie in the negative half plane.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)

def spectralConclusionPrinted {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop := printedSpectralConclusion L ρ

def spectralConclusionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧
  (∀ v : E, L v = 0 → v ∈ Submodule.span ℂ ({ρ} : Set E)) ∧
  ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    FiniteDimensional ℂ (Module.End.eigenspace L eigen) ∧ (eigen = 0 ∨ eigen.re < 0)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
- 29号覆盖限定：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。
- 覆盖缺口：只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。分别审校：simpleEigenvalue定义的是特征空间维数1（几何单重），不是通常谱论的代数单重。printedSpectralConclusion及spectralConclusionPrinted忠实保留“所有特征值单重、0对应ρ、其他实部负”的点谱目标，但没有紧预解式或完整谱的对象，也没有代数重数。_corrected把所有特征空间改为有限维，改掉“离散⇒单重”的错误方向是合理的；然而同时删掉零特征值应为唯一不变密度方向的约束，且有限维几何特征空间不等同于离散谱及有限代数重数。它只是较弱目标谓词，不是已得到的Langevin谱定理，也不是完整修正。由于原书错误及应保留哪些额外结论需人工决定，总判NEEDS\_HUMAN。
网站复审结论：NEEDS\_HUMAN。按已披露的范围，三个Printed/别名定义忠实记录原文的“点谱、几何单重”部分，corrected是较弱的点谱候选而不是已经证明的结论。原文“离散谱即单重谱”是实质数学疑误；此外几何单重不能代替代数单重，完整的原书谱论含义仍需人工选定，因此整体NEEDS\_HUMAN，不将源文错误隐改后判PASS。
按版本登记：网站仅认可已披露的点谱/几何单重定义；corrected仍是较弱候选Prop，未获完整紧预解式谱定理的PASS，不计为修正版定理通过。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。

### 7. 状态与证明位置

- `MD.Ch07.simpleEigenvalue`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.printedSpectralConclusion`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spectralConclusionPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spectralConclusionPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.3-PerturbationCoefficientEquation

印刷页 289–290 / PDF页 310–311。

### 1. 原文陈述

> Inserting this ansatz into the stationary Fokker-Planck equation $`\widehat{\mathcal L}^\dagger\widehat\rho=0`$, we obtain

$$
(\mathcal L_{LD}^\dagger+h\mathcal L_1^\dagger+h^2\mathcal L_2^\dagger+O(h^3))(\rho_\beta[1+hf_1+h^2f_2+O(h^3)])=0.
$$


> Combining like powers, we have at zero’th order, the equation $`\mathcal L_{LD}^\dagger\rho_\beta=0`$.
> At first order we obtain

$$
\mathcal L_{LD}^\dagger(\rho_\beta f_1)+\mathcal L_1^\dagger\rho_\beta=0.\tag{7.19}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def actionCoefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E) (k : ℕ) : E :=
  ∑ j ∈ Finset.range (k+1), L j (ρ (k-j))
theorem perturbationCoefficientEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (h0 : actionCoefficient L ρ 0 = 0) (h1 : actionCoefficient L ρ 1 = 0) :
    L 0 (ρ 0) = 0 ∧ L 0 (ρ 1)+L 1 (ρ 0) = 0 := by
  constructor
  · simpa [actionCoefficient] using h0
  · simpa [actionCoefficient, Finset.sum_range_succ] using h1
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 actionCoefficient, perturbationCoefficientEquation 所列对象、量词、前提和结论。范围说明：actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 在真实线性作用的形式系数卷积上推导0阶和1阶必要方程；并未由这些必要方程证明原离散链存在不变分布。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 actionCoefficient, perturbationCoefficientEquation 所列对象、量词、前提和结论。范围说明：actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。

### 7. 状态与证明位置

- `MD.Ch07.actionCoefficient`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.perturbationCoefficientEquation`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.3-ObservableCorrectionExpansion

印刷页 290 / PDF页 311。

### 1. 原文陈述

> For some observable $`\vartheta(q,p)`$, we have that

$$
\langle\vartheta\rangle_h=\int_{\mathcal D}\vartheta(q,p)\widehat\rho(q,p)d\omega =\int_{\mathcal D}\vartheta(q,p)\rho_\beta(q,p)(1+hf_1(q,p)+h^2f_2(q,p)+\cdots)d\omega =\langle\vartheta\rangle+h\langle\vartheta f_1\rangle+h^2\langle\vartheta f_2\rangle+\cdots.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem observableCorrectionExpansion (ν : Measure Ω) (φ ρ f1 f2 : Ω → ℝ) (h : ℝ)
    (h0 : Integrable (fun x ↦ φ x*ρ x) ν)
    (h1 : Integrable (fun x ↦ φ x*ρ x*f1 x) ν)
    (h2 : Integrable (fun x ↦ φ x*ρ x*f2 x) ν) :
    (∫ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) ∂ν) =
      (∫ x, φ x*ρ x ∂ν)+h*(∫ x, φ x*ρ x*f1 x ∂ν)+h^2*(∫ x, φ x*ρ x*f2 x ∂ν) := by
  have heq : ∀ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) =
      (φ x*ρ x+h*(φ x*ρ x*f1 x))+h^2*(φ x*ρ x*f2 x) := by intro x; ring
  simp_rw [heq]
  have hout := integral_add (h0.add (h1.const_mul h)) (h2.const_mul (h^2))
  have hin := integral_add h0 (h1.const_mul h)
  simp only [Pi.add_apply] at hout hin
  rw [hout, hin, integral_const_mul, integral_const_mul]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 observableCorrectionExpansion 所列对象、量词、前提和结论。范围说明：observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra\_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整覆盖0–2阶有限截断积分；无限级数交换与实际误差余项仍需支配收敛及弱展开理论，明确不声称已证。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra\_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 observableCorrectionExpansion 所列对象、量词、前提和结论。范围说明：observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra\_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。

### 7. 状态与证明位置

- `MD.Ch07.observableCorrectionExpansion`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.3-PerturbativeSolvabilityCaution

印刷页 290 / PDF页 311。

### 1. 原文陈述

> It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $`\mathcal L_{LD}^\dagger`$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def correctionSolvable {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (rhs : E) : Prop := ∃ u : E, L u = rhs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。
- 不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。
- 29号覆盖限定：仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。correctionSolvable是任意实模线性自映射L下rhs属于range(L)的命题，数学含义正确。但没有ρβf1结构、零质量归一条件、Fredholm相容性、紧预解式/定义域、指数稳定或全局半群存在。JSON明确只登记目标，不证明预期；原书也明确未给严格结果，必须保留并NEEDS\_HUMAN，不能把紧预解式及有界扰动升级为无条件可解性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。

### 7. 状态与证明位置

- `MD.Ch07.correctionSolvable`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8-FirstOrderOperator

印刷页 291 / PDF页 312。

### 1. 原文陈述

> By composing the semigroup operators

$$
\exp(h\widehat{\mathcal L}_{[XYZ]}^\dagger)=\exp(h\mathcal L_Z^\dagger)\exp(h\mathcal L_Y^\dagger)\exp(h\mathcal L_X^\dagger),
$$


> and computing the terms in the BCH expansion, we have

$$
\widehat{\mathcal L}_{[XYZ]}^\dagger=\mathcal L_{LD}^\dagger+h\mathcal L_{1,[XYZ]}^\dagger+O(h^2),
$$


> where

$$
\mathcal L_{1,[XYZ]}^\dagger=-\frac12([\mathcal L_X^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_X^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]).\tag{7.20}
$$


> The first order correction function for this scheme is then given by the particular solution to the PDE,

$$
\mathcal L_{LD}^\dagger(f_{1,[XYZ]}\rho_\beta)=-\mathcal L_{1,[XYZ]}^\dagger\rho_\beta.\tag{7.21}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def firstOrderOperator {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : R :=
  (-1/2 : ℝ) • (comm X Y+comm X Z+comm Y Z)
theorem firstOrderOperator_coefficient {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) = firstOrderOperator X Y Z := by
  sorry
def correctionEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L L1 : Module.End ℝ E) (ρ ρf : E) : Prop := L ρf = -L1 ρ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 firstOrderOperator, firstOrderOperator\_coefficient, correctionEquation 所列对象、量词、前提和结论。范围说明：C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator\_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 前向组合采用Z,Y,X顺序；正式级数系数推论覆盖所有六个排列，L0为三者和。修正方程为必要形式方程，可解性独立。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator\_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 firstOrderOperator, firstOrderOperator\_coefficient, correctionEquation 所列对象、量词、前提和结论。范围说明：C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator\_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。

### 7. 状态与证明位置

- `MD.Ch07.firstOrderOperator`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstOrderOperator_coefficient`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.correctionEquation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8-HomogeneousNormalization

印刷页 291 / PDF页 312。

### 1. 原文陈述

> The general solution of (7.21) will consist of the sum of the homogeneous solution $`f_{1,[XYZ]}^{[HS]}(q,p)`$ and particular solution $`f_{1,[XYZ]}^{[PS]}(q,p)`$ in the usual way. However, since $`\mathcal L_{LD}^\dagger\vartheta=0`$ has as its only solution $`\vartheta\propto\rho_\beta`$, the homogeneous solution of (7.21) is $`f_{1,[XYZ]}^{[HS]}(q,p)=c`$, for some constant $`c`$. Our assumption that $`\langle f_{1,[XYZ]}\rangle=0`$ means that $`c=-\langle f_{1,[XYZ]}^{[PS]}\rangle`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem homogeneousNormalization {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ u v rhs : E)
    (hker : ∀ w, L w = 0 → ∃ c : ℝ, w = c • ρ)
    (hu : L u = rhs) (hv : L v = rhs) : ∃ c : ℝ, u = v+c • ρ := by
  obtain ⟨c,hc⟩ := hker (u-v) (by rw [map_sub,hu,hv,sub_self])
  exact ⟨c,by rw [← hc]; abel⟩
theorem centeredParticular (μ : Measure Ω) [IsProbabilityMeasure μ] (f : Ω → ℝ)
    (hf : Integrable f μ) : (∫ x, f x-(∫ y, f y ∂μ) ∂μ) = 0 := by
  rw [integral_sub hf (integrable_const _)]
  simp
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 homogeneousNormalization, centeredParticular 所列对象、量词、前提和结论。范围说明：C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 核恰为ρ的一维空间是明确前提；不把Langevin核唯一性当作已证明。第二条为实际概率归一化的中心化恒等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 homogeneousNormalization, centeredParticular 所列对象、量词、前提和结论。范围说明：C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。

### 7. 状态与证明位置

- `MD.Ch07.homogeneousNormalization`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.centeredParticular`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-CommutatorPermutationRelations

印刷页 292 / PDF页 313。

### 1. 原文陈述


$$
([\mathcal L_O^\dagger,\mathcal L_A^\dagger]+[\mathcal L_O^\dagger,\mathcal L_B^\dagger])\rho_\beta=[\mathcal L_O^\dagger,\mathcal L_A^\dagger+\mathcal L_B^\dagger]\rho_\beta=0.
$$



$$
\mathcal L_{1,[ABO]}^\dagger\rho_\beta=\mathcal L_{1,[OAB]}^\dagger\rho_\beta=-\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\mathcal L_{1,[BAO]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta.\tag{7.22}
$$



$$
f_{1,[ABO]}=f_{1,[OAB]}=-f_{1,[OBA]}=-f_{1,[BAO]}.\tag{7.23}
$$



$$
\mathcal L_{1,[AOB]}^\dagger\rho_\beta=-\mathcal L_{1,[BOA]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger-\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho_\beta+\mathcal L_{1,[ABO]}^\dagger\rho_\beta.\tag{7.24}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorPermutationRelations {E : Type*} [AddCommGroup E] [Module ℝ E]
    (A B O : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (A+B) ρ = 0) :
    (comm O A+comm O B) ρ = 0 ∧
    firstOrderOperator A B O ρ = firstOrderOperator O A B ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator O B A ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator B A O ρ ∧
    firstOrderOperator A B O ρ = (-1/2 : ℝ) • comm A B ρ ∧
    firstOrderOperator A O B ρ = -firstOrderOperator B O A ρ ∧
    firstOrderOperator A O B ρ = (-1/2 : ℝ) • comm (A-B) O ρ+firstOrderOperator A B O ρ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。
- 29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。
- 覆盖缺口：实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。
- 覆盖缺口：29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：现有commutatorPermutationRelations的七个结论在Oρ=0和(A+B)ρ=0下均正确；实模、线性自同态与ρ的量词没有错误，交换子按复合定义。FAIL仅针对本条完整原文结论的覆盖：没有从相同PDE右端推出零均值解相等及相反的桥接定理。不能以“需要唯一性”为由把(7.23)当作已核对通过。
网站复审结论：PASS。七项结论为在两项明确湮灭条件下的真实线性算子代数恒等式，所有ρ和算子量词均保留；并未把它写成只对标量常数成立的替身。所用A,B,O是抽象算子，不自动等同实际Gibbs微分算子；源文(7.23)的解函数关系也没有被仅凭右端相等就冒称已证明。上述范围限制均有明示。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。

### 7. 状态与证明位置

- `MD.Ch07.commutatorPermutationRelations`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-GibbsDerivativeIdentities

印刷页 292–293 / PDF页 313–314。

### 1. 原文陈述

> If we define the function $`g(q,p)`$ as $`g(q,p)=\beta p^TM^{-1}\nabla U(q)`$, then through simple computation we have

$$
\mathcal L_A^\dagger\rho_\beta=-\mathcal L_B^\dagger\rho_\beta=g(q,p)\rho_\beta.
$$



$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=-(\mathcal L_A^\dagger+\mathcal L_B^\dagger)(g\rho_\beta)=(\mathcal L_O^\dagger-\mathcal L_{LD}^\dagger)(g\rho_\beta).
$$


> For a function $`\psi(q)`$ purely of position, we have

$$
\mathcal L_{LD}^\dagger(\psi(q)\rho_\beta)=-(p^TM^{-1}\nabla\psi(q))\rho_\beta(q,p),
$$


> and hence we can compute

$$
\mathcal L_O^\dagger(g(q,p)\rho_\beta)=\gamma\rho_\beta(-p\cdot\nabla_pg+\beta^{-1}\nabla_p\cdot M\nabla_pg) =-\gamma g\rho_\beta=\gamma\beta\mathcal L_{LD}^\dagger(U(q)\rho_\beta).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def mechanicalHamiltonian (m : V n) (U : V n → ℝ) (x : Phase n) : ℝ :=
  (∑ i, x.2 i^2/(2*m i))+U x.1
def gibbsWeight (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  Real.exp (-β*mechanicalHamiltonian m U x)
def gFunction (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*∑ i, x.2 i/m i*gradient U x.1 i
def phaseO (m : V n) (γ β : ℝ) (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ouForward m γ β⁻¹ (fun p ↦ ρ (x.1,p)) x.2
def phaseLD (m : V n) (U : V n → ℝ) (γ β : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  aForward m ρ+bForward U ρ+phaseO m γ β ρ
theorem gibbsDerivativeIdentities (m : V n) (U ψ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) (hψ : ContDiff ℝ ⊤ ψ) :
    let ρ := gibbsWeight m U β
    let g := gFunction m U β
    aForward m ρ = g*ρ ∧ bForward U ρ = -(g*ρ) ∧
    phaseLD m U γ β (fun x ↦ ψ x.1*ρ x) =
      (fun x ↦ -(∑ i, x.2 i/m i*gradient ψ x.1 i)*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ -γ*g x*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ γ*β*phaseLD m U γ β (fun y ↦ U y.1*ρ y) x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- ρ为未归一Gibbs权，所有微分等式对常数归一化同样成立；实际概率还要正有限配分积分。所有质量正、β>0、光滑资格明示。
- 覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。
- 29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。
- 覆盖缺口：29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：现有五项结论在m\_i>0、β>0、U和ψ光滑的全称量词下均正确；γ任意实数不影响这些代数微分恒等式。未归一权与归一密度只差常数，额外资格明确。FAIL源于原文含有但Lean未陈述的交换子等式及OU中间公式，非sorry问题。
网站复审结论：PASS。全部质量和β的非退化条件明确，C∞资格足以处理全部实际导数；γ的正性对这些代数微分恒等式非必要。Lean函数乘法g*ρ为逐点乘法，与源文相符。原段交换子及OU中间式仍为覆盖缺口，不因恢复源文中间项而宣称已由这五个结论形式化；配分积分的正有限性也不在本条结论中。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。

### 7. 状态与证明位置

- `MD.Ch07.mechanicalHamiltonian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.gibbsWeight`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.gFunction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.phaseO`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.phaseLD`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.gibbsDerivativeIdentities`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-FirstCorrectionTablePrinted

印刷页 293–294 / PDF页 314–315。

### 1. 原文陈述

> In summary, we find that

$$
f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25a}
$$



$$
f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\frac\beta2(\gamma U(q)-p^TM^{-1}\nabla U(q)-c),\tag{7.25b}
$$



$$
f_{1,[AOB]}(q,p)=-\frac\beta2(\gamma U(q)+p^TM^{-1}\nabla U(q)-c),\tag{7.25c}
$$



$$
f_{1,[BOA]}(q,p)=\frac\beta2(\gamma U(q)+p^TM^{-1}\nabla U(q)-c),\tag{7.25d}
$$


> where the constant $`c`$ is chosen to ensure each correction function has average 0, giving $`c=\gamma\langle U(q)\rangle`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 then -β/2*(γ*U x.1-v-c)
  else if s = 4 then -β/2*(γ*U x.1+v-c)
  else β/2*(γ*U x.1+v-c)
def firstCorrectionTablePrinted_corrected (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  if s = 4 then -β/2*(γ*U x.1+(∑ i, x.2 i/m i*gradient U x.1 i)-c)
  else firstCorrectionTablePrinted s m U β γ c x
theorem firstCorrection_sign_counterexample :
    (-(1 : ℝ)/2*(1-1-0)) ≠ -(1 : ℝ)/2*(1+1-0) := by norm_num
def phaseComm (A B : (Phase n → ℝ) → Phase n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := A (B ρ)-B (A ρ)
def firstCorrectionRHS (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  let A := aForward m
  let B := bForward U
  let O := phaseO m γ β
  let ops := if s = 0 then (A,B,O) else if s = 1 then (O,A,B)
    else if s = 2 then (O,B,A) else if s = 3 then (B,A,O)
    else if s = 4 then (A,O,B) else (B,O,A)
  fun x ↦ (1/2)*(phaseComm ops.1 ops.2.1 ρ x+phaseComm ops.1 ops.2.2 ρ x+phaseComm ops.2.1 ops.2.2 ρ x)
theorem firstCorrectionTable_pde (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    phaseLD m U γ β (fun x ↦ firstCorrectionTablePrinted_corrected s m U β γ c x*gibbsWeight m U β x) =
      firstCorrectionRHS s m U β γ (gibbsWeight m U β) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。
- 29号覆盖限定：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。
- PDF314–315已目视核对原页：(7.25c)括号内为+v；旧负号是转录错误，撤销原书疑误。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C分项：Printed定义FAIL（s=4字面符号错误）；_corrected定义PASS（其数学公式就是PDF字面正确式）；firstCorrection\_sign\_counterexample的实数不等式PASS，但仅说明错误转写与正确转写不等；phaseComm与firstCorrectionRHS PASS；firstCorrectionTable\_pde的正质量、正β、光滑U、任意常数c下的全部六个PDE签名PASS。汇总FAIL因为Printed不忠实且完整零均值结论缺失。不能把本条问题归为原书勘误。
网站复审结论：PASS。六个排列的完整分支、PDE及其所有前提与结论均正确。Printed与corrected当前完全相同，原书正号应保留；数值不等式本身成立，但其用途限于说明旧误录。任意常数c的PDE不等于已实现平均为零：后者需存在归一Gibbs概率、U和v可积及动量奇性消去后，才能取c=γ〈U〉。本条仅修补覆盖元数据，不改Lean。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。

### 7. 状态与证明位置

- `MD.Ch07.firstCorrectionTablePrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrectionTablePrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrection_sign_counterexample`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.phaseComm`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrectionRHS`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstCorrectionTable_pde`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-PositionMomentumCorrections

印刷页 294–295 / PDF页 315–316。

### 1. 原文陈述

> If $`\vartheta=\vartheta_1(p)`$ then this $`O(\gamma)`$ term will not trouble us, as

$$
\langle\vartheta_1(p)f_1(q,p)\rangle=\pm\frac\beta2\langle(\gamma U(q)-c)\vartheta_1(p)\pm p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle =\pm\frac\beta2\langle p^TM^{-1}\nabla U(q)\vartheta_1(p)\rangle.
$$


> However, if we instead set $`\vartheta=\vartheta_2(q)`$, then

$$
\langle\vartheta_2(q)f_1(q,p)\rangle=\pm\frac{\gamma\beta}{2}\langle(U(q)-\langle U(q)\rangle)\vartheta_2(q)\rangle.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def positionGibbs (U : V n → ℝ) (β : ℝ) : Measure (V n) :=
  volume.withDensity (fun q ↦ ENNReal.ofReal (Real.exp (-β*U q)/(∫ y, Real.exp (-β*U y))))
def momentumGibbs (m : V n) (β : ℝ) : Measure (V n) := Measure.pi (fun i ↦ gaussianReal 0 (Real.toNNReal (m i/β)))
def productGibbs (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  (positionGibbs U β).prod (momentumGibbs m β)
theorem positionMomentumCorrections (m : V n) (U ψ χ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hU : Integrable U (positionGibbs U β))
    (hψ : Integrable ψ (positionGibbs U β)) (hχ : Integrable χ (momentumGibbs m β))
    (hgrad : ∀ i, Integrable (fun q ↦ gradient U q i) (positionGibbs U β))
    (hint : ∀ s : Fin 6,
      Integrable (fun x ↦ ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β) ∧
      Integrable (fun x ↦ χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β)) :
    ∀ s : Fin 6, let sign : ℝ := if s = 0 ∨ s = 1 ∨ s = 5 then 1 else -1
    let vsign : ℝ := if s = 0 ∨ s = 1 ∨ s = 4 then -1 else 1
    (∫ x, ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      sign*γ*β/2*∫ q, (U q-(∫ y, U y ∂positionGibbs U β))*ψ q ∂positionGibbs U β ∧
    (∫ x, χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      vsign*β/2*∫ x, (∑ i, x.2 i/m i*gradient U x.1 i)*χ x.2 ∂productGibbs m U β := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 positionGibbs, momentumGibbs, productGibbs, positionMomentumCorrections 所列对象、量词、前提和结论。范围说明：C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m\_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 产品Gibbs实际含位置概率及独立中心Gaussian动量；所有显示期望需可积，未把待求修正值作为假设。
- 六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。
- 覆盖缺口：六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m\_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 positionGibbs, momentumGibbs, productGibbs, positionMomentumCorrections 所列对象、量词、前提和结论。范围说明：C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m\_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。

### 7. 状态与证明位置

- `MD.Ch07.positionGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.productGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.positionMomentumCorrections`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.1-OverdampedFirstOrderCaution

印刷页 295 / PDF页 316。

### 1. 原文陈述

> When considering the limit of infinite friction in the $`[XYZ]`$ schemes we obtain an inconsistent discretization. Hence these first-order schemes will be unsuitable for the integration of overdamped Langevin dynamics.
> This is not always the case for first order schemes, however. For example the scheme denoted $`[AOAB]`$ is consistent with the dynamics, and may be used for integrating the overdamped ($`\gamma=\infty`$) Langevin equation.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
    Filter.Tendsto (fun γ : ℝ ↦ aoab m U γ θ h R x) Filter.atTop (𝓝 (aoabInfiniteFriction m U θ h R x)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。
- 29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。
- 覆盖缺口：29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：aoab、aoabInfiniteFriction、aoabFrictionLimit彼此匹配；h>0确保指数衰减，U为C¹保证最终kick中梯度连续，θ>0明示。m没有正性前提，但作为Lean全定义实函数的单步极限仍成立，不能据此把任意m解释为物理质量。该极限定理本身PASS。完整原文断言的汇总FAIL，因为单步噪声替换极限不能替代对过阻尼SDE的一致性，更没有陈述六种XYZ的否定结论。
网站复审结论：PASS。AOAB两段A各h/2、O与B各h，完整映射、极限映射和Tendsto方向均正确。所有参数在极限中固定，仅γ变化；正时间保证exp(−γh)趋零，正质量/温度给出原物理噪声幅度，C¹势足以使梯度连续。结论只覆盖已声明的逐路径单步极限，不能据此宣告原文六种XYZ判断和AOAB有效时标一致性已形式化。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.aoab`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aoabInfiniteFriction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aoabFrictionLimit`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.8.2-BiasedDoubleWellExact

印刷页 295–297 / PDF页 316–318。

### 1. 原文陈述

> Let $`M=\beta=1`$ and define the biased double-well potential as

$$
U(q)=(q^2-1)^2+q/2.
$$


> We choose the observable

$$
\vartheta(q,p)=p^2-qU'(q)+2qp,\qquad\langle\vartheta\rangle=0.
$$


> The first order correction term for the $`[BOA]`$ scheme is given by the formula

$$
\langle\vartheta f_{1,[BOA]}\rangle=\frac\beta2\int_{\mathcal D}(p^2-qU'(q)+2qp)(pU'(q)+\gamma U(q)-c)\rho_\beta d\omega =\frac1\beta+\frac\gamma2\langle U\rangle-\frac{\gamma\beta}{2}\langle qUU'\rangle=\frac{2-\gamma}{2\beta}.
$$


> Hence for the critical value of $`\gamma=2`$, the leading order correction will be zero, giving

$$
\langle\vartheta\rangle_h^{[BOA]}=\langle\vartheta\rangle+O(h^2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def biasedDoubleWell (q : ℝ) : ℝ := (q^2-1)^2+q/2
def doubleWellObservable (x : ℝ × ℝ) : ℝ := x.2^2-x.1*deriv biasedDoubleWell x.1+2*x.1*x.2
def doubleWellGibbs (β : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-β*(x.2^2/2+biasedDoubleWell x.1))
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def doubleWellBOACorrection (β γ : ℝ) (x : ℝ × ℝ) : ℝ :=
  β/2*(x.2*deriv biasedDoubleWell x.1+γ*biasedDoubleWell x.1-
    γ*(∫ y, biasedDoubleWell y.1 ∂doubleWellGibbs β))
theorem doubleWellExact (β γ : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x ∂doubleWellGibbs β) = 0 ∧
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β γ x ∂doubleWellGibbs β) = (2-γ)/(2*β) := by
  sorry
theorem doubleWellCritical (β : ℝ) : (2-(2 : ℝ))/(2*β) = 0 := by ring

theorem doubleWellCritical_integral (β : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β 2 x ∂doubleWellGibbs β) = 0 := by
  simpa using (doubleWellExact β 2 hβ).2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 保留数值例中的精确数学积分和解析消项；原文虽起初β=1，推导中保留β，本条正β形式需同样积分分部理论。
- 中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。
- 29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。
- 覆盖缺口：29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：biasedDoubleWell、doubleWellObservable、doubleWellGibbs、doubleWellBOACorrection全部正确，密度以整个ℝ²积分归一且c=γ〈U〉。doubleWellExact的两个结论在β>0、γ任意下正确；没有把目标积分当作前提。doubleWellCritical代数等式虽对所有β成立，却未把β>0和doubleWellExact连接成积分消项推论。原文最后声称的真实算法平均O(h²)需要离散不变平均、h→0及弱展开余项，这些对象均不存在；因此完整覆盖FAIL。
网站复审结论：PASS。对象是ℝ×ℝ，q=x.1、p=x.2；Gibbs权为exp[−β(p²/2+U)]，以全相空间积分归一。修正中的中心常数γ∫U与〈ϑ〉=0相容。doubleWellExact全称β,γ∈ℝ并假设β>0，给出两个实际积分的合取；对任意实γ仍成立。分部积分给〈qU′〉=1/β、〈qUU′〉=〈U〉/β+1/β²，独立Gaussian给〈p²〉=1/β，故完整结果(2−γ)/(2β)正确。doubleWellCritical仅实数代数式，β=0亦按总化除法成立；integral推论确实接到Exact的第二分量。任意β>0是[EXTRA]推广，未覆盖真实算法O(h²)和中间积分链已如实声明。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.biasedDoubleWell`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellGibbs`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellBOACorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellExact`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellCritical`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.doubleWellCritical_integral`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

