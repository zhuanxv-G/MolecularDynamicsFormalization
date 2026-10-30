[上一部分](part06.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / 下一部分：无

## 1. MD-1.7-IsoscelesAccessibleRegion · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> kinetic energy is non-negative, we must have

$$
2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem isoscelesaccessibleregion :
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E := by
  exact MolecularDynamics.Chapter01Review.isoscelesEnergyBound_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isoscelesaccessibleregion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x)\le E.`$ | MD.Ch01.isoscelesaccessibleregion，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
全称x,y,v,w,E，仅假设能量等于E；由v²+w²/3≥0推出isoscelesPotential≤E。势的两倍斜边项与底边项完整，无需额外动态或正性前提。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2415；MD.Ch01.isoscelesaccessibleregion。

## 1. MD-1.7-EquilateralTrimerMinimum · Example 1.8 (Planar Lennard-Jones Trimer) · 印刷p.38 / PDFp.61

### 2. 原文陈述

> The global minimum of this simple system must be radially symmetric. Placing the atoms at the vertices of an equilateral triangle, we have

$$
U=3\hat\varphi_{\mathrm{LJ}}(r),
$$


> where $`r`$ is the length of a side. This is minimized when $`r=2^{1/6}\approx1.1225`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem equilateraltrimerminimum :
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilateraltrimerminimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U=3\hat\varphi_{\mathrm{LJ}}(r),`$ | MD.Ch01.equilateraltrimerminimum，完整展开陈述见上一行及第4段 | 一致 |
| 全局极小值-3 | -3≤uniformLJEnergy 1 1 q | 一致 |
| 达到极小当且仅当三边等于2^(1/6) | 能量=-3 ↔ ∀i≠j,pairDistance…=Real.rpow 2 (1/6) | 一致 |
| 原文未显式量化的技术资格 | 单位LJ；非碰撞配置。 | [EXTRA] |

[EXTRA] 单位LJ；非碰撞配置。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
对任意三维非碰撞三点，势≥−3且等号当且仅当全部非同标距离为2^(1/6)。这是原文全局最低势与等边构型的正确精确化；三维三个点仍共面。每对φ+1=(2/r⁶−1)²≥0，等号恰在r⁶=2；未把约1.1225当精确值，未因sorry扣分。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2423；MD.Ch01.equilateraltrimerminimum。

## 1. MD-1.7-TrimerEnergyLowerBound · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> (When $`E\gt 0`$, the bodies eventually escape to infinity; $`E\lt -3`$ is not attainable.)

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimerenergylowerbound :
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q := by
  exact MolecularDynamics.Chapter01Review.trimerLowerBound_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimerenergylowerbound；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
任意非碰撞三粒子配置和任意速度，结论是动能加三对势≥−3；动能非负及每对势≥−1给出。与原文E<−3不可达一致；E>0部分按范围交第14条处理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2434；MD.Ch01.trimerenergylowerbound。

## 1. MD-1.7-CollinearTrimer · definition · 印刷p.40 / PDFp.63

### 2. 原文陈述

> Arranging the three atoms in a collinear configuration ($`y=0`$) the potential energy becomes $`\hat U=\hat U(x)=2\hat\varphi_{\mathrm{LJ}}(x)+\hat\varphi_{\mathrm{LJ}}(2x)`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.collinearTrimer；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2443；MD.Ch01.collinearTrimer。

## 1. MD-1.7-TrimerSaddle · unnumbered_claim · 印刷p.40–41 / PDFp.63–64

### 2. 原文陈述

> Minimizing the potential in the collinear configuration allows us to determine the saddle point $`(x^*,0)`$. Near this point, $`U`$ decreases if we move in the $`\pm y`$ direction and increases if we move in the $`\pm x`$ direction.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimersaddle :
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimersaddle；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。 | [EXTRA] |

[EXTRA] x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
存在正x为全部正共线参数的全局极小，且存在同一个正δ，横向任何足够小非零位移严格增势、纵向任何足够小非零位移严格减势，量词及严格性符合原文。δ可缩至小于x排除u=0。令A=2+2⁻¹²，B=2+2⁻⁶，则共线势=4(Ax⁻¹²−Bx⁻⁶)，唯一极小满足x⁶=2A/B<2；故φ′(x)<0，纵向二阶项φ′(x)y²/x为负，横向二阶项为正。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2450；MD.Ch01.trimersaddle。

## 1. MD-1.7-TrimerEscapeLiteral · unnumbered_claim · 印刷p.40 / PDFp.63

### 2. 原文陈述

> (When $`E\gt 0`$, the bodies eventually escape to infinity; $`E\lt -3`$ is not attainable.)

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem trimerescapeliteral :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop := by
  sorry

/-- 修正版，对应原文 MD-1.7-TrimerEscapeLiteral，改动：把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。 -/
theorem trimerescapeliteral_corrected :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => dist (q t i) (q t j)) atTop atTop := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.trimerescapeliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

总能量正并不直接推出每个粒子相对固定原点趋于无穷；系统分离与逐粒子逃逸不同。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=NEEDS\_HUMAN（待独立散射论证）。
literal保留逐粒子范数趋∞的字面解释；签名具真实Newton导数、单位LJ力、全时非碰撞、正能量、零质心/动量/角动量及等腰约束，无循环前提，但逐粒子结论过强。corrected保留全部资格并改为存在固定一对距离趋∞，改动方向合理；此候选的强极限结论尚需独立散射论证，不能由能量非负或现有反例直接认证。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2461；MD.Ch01.trimerescapeliteral。

## 1. MD-1.7.1-ChaosConditions · definition · 印刷p.41–42 / PDFp.64–65

### 2. 原文陈述

> Typical definitions of a “chaotic dynamical system” [103] require at least the following conditions to be satisfied on the phase space $`D`$:
> • The solutions depend sensitively on the initial data taken from $`D`$;
> • The flow is topologically transitive in $`D`$.
> The second condition states that given arbitrarily small neighborhoods $`D_1`$ and $`D_2`$ of two different points in $`D`$ then it is possible to find a trajectory that goes from some point of $`D_1`$ to some point of $`D_2`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.chaosConditions；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。 | [EXTRA] |
| 原文未显式量化的技术资格 | topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。 | [EXTRA] |

[EXTRA] 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。；topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。

### 6. 审计结论

两必要性质及transitivity邻域关系保留；敏感依赖正文随后“given pair rapidly grows”不是标准存在扰动量词，需导师确认数学化选择。

网站：网站PASS（EAUDIT复审）。
chaosConditions准确为敏感依赖和拓扑传递的合取。敏感依赖依次量化∃ε>0、∀x∈D、∀δ>0、∃y∈D、∃t≥0，近邻及分离不等号正确；ε>0已自动排除y=x。传递用环境开集与D交等价于相对开集形式，起终点都在D。作为两个条件的谓词可用于任意F,D；解释为混沌真实系统时还须外部限定F为流、D不变。原文说at least，不能把本谓词称为混沌的充分必要定义；已有注释明确这只是选定的严格化。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2491；MD.Ch01.chaosConditions。

## 1. MD-1.7.1-TransitivityErgodicityLiteral · unnumbered_claim · 印刷p.42 / PDFp.65

### 2. 原文陈述

> We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem transitivityergodicityliteral :
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.1-TransitivityErgodicityLiteral，改动：改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。 -/
theorem transitivityergodicityliteral_corrected {n : ℕ}
    (f : Position n → Position n) (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) [IsFiniteMeasure μ]
    (hf : ContDiff ℝ 1 f) (hflow : isFlowOf f F) (hcont : Continuous (Function.uncurry F))
    (hfull : ∀ U : Set (Position n), IsOpen U → U.Nonempty → μ U ≠ 0)
    (he : flowErgodic F μ) : topologicalTransitivity F univ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.transitivityergodicityliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。 | [EXTRA] |

[EXTRA] 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。

### 6. 审计结论

拓扑传递依赖拓扑，遍历性依赖选定不变测度；一般不能直接等价。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal在连续真实流和不变测度下断言拓扑传递↔测度遍历，忠实表达原句但普遍错误。corrected限制有限满支撑测度，仅断言遍历⇒拓扑传递，方向与条件正确；flowErgodic已含全部时间的测度保持。hf:C¹确保ODE唯一性，由isFlowOf得到群性质，故不缺流合成资格；连续性使开集时间饱和为开可测，有限测度复现可保证正向时间的传递。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2498；MD.Ch01.transitivityergodicityliteral。

## 1. MD-1.7.1-AnisotropicOscillator · Example 1.9 (Anisotropic Oscillator) · 印刷p.42 / PDFp.65

### 2. 原文陈述

> Consider the system with energy

$$
E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\tag{1.9}
$$


> where

$$
c_3=\cos(3\theta)
$$


> is defined in terms of the angular coordinate of the position $`(x,y)`$ with respect to the $`(1,0)`$-direction,

$$
\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,
$$


> and we have defined

$$
\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.anisotropicEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E(x,y,\dot x,\dot y)=\frac12(\dot x^2+\dot y^2)+\frac{\kappa(c_3)}2(r-l(c_3))^2,\qquad r=\sqrt{x^2+y^2},\quad\text{(1.9)}`$；$`c_3=\cos(3\theta)`$；$`\cos\theta=c=\frac xr,\qquad c_3=4c^3-3c,`$；$`\kappa(c_3)=\kappa_0(1-\tfrac12\epsilon c_3),\qquad l(c_3)=l_0(1+\tfrac12\epsilon c_3).`$ | MD.Ch01.anisotropicEnergy，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 定义在r=0用Lean总函数延拓，物理域r>0。 | [EXTRA] |

[EXTRA] 定义在r=0用Lean总函数延拓，物理域r>0。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PDF字形确认κ及κ₀。anisotropicAngular以x/√(x²+y²)代入4c³−3c，与cos3θ一致；参数分别κ₀(1−εc₃/2)、l₀(1+εc₃/2)，势的κ/2及平方和动能全部正确。r>0物理域与r=0总函数延拓已注明，未把数值实验参数或轨迹观察误作全称定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2519；MD.Ch01.anisotropicEnergy。

## 1. MD-1.7.2-FlowJacobianLiteral · definition · 印刷p.44 / PDFp.67

### 2. 原文陈述

> Let a dynamical system $`\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)`$ be given in $`\mathbb R^m`$ with flow map $`F_t:\mathbb R^m\to\mathbb R^m`$ which we assume to be continuously differentiable. Let $`\boldsymbol z(t,\boldsymbol\xi)`$ represent the solution of initial value problem

$$
\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.
$$


> We then compute the $`m\times m`$ Jacobian matrix of $`F_t(\boldsymbol z(t,\boldsymbol\xi))`$:

$$
\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)

/-- 修正版，对应原文 MD-1.7.2-FlowJacobianLiteral，改动：DF_t取值点从F_t(ξ)改为初值ξ。 -/
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.variationalMatrixLiteral；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.`$；$`\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).`$ | MD.Ch01.variationalMatrixLiteral，完整展开陈述见上一行及第4段 | 一致 |
| W的取值点为z(t,ξ)=Ftξ | fderiv ℝ (F t) (F t ξ) | [ERRATUM?] 字面保留，未换为ξ |

[EXTRA] 

### 6. 审计结论

对初值求导的Jacobian应在初值取值；把演化后位置再次代入是复合了不同取值点。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal确为fderiv(F t)在F t ξ处的取值，忠实保留PDF的z(t,ξ)取值点；导数作为连续线性算子与欧氏Jacobian矩阵等价。corrected改为在ξ处取值是标准初值变分矩阵。两者为定义，可对任意F作总函数定义；真实流和C¹资格用于后续理论。作为原文变分理论基础有取值点疑误，保留人工裁定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2527；MD.Ch01.variationalMatrixLiteral。

## 1. MD-1.7.2-VariationalEquationLiteral · unnumbered_claim · 印刷p.44–45 / PDFp.67–68

### 2. 原文陈述

> Differentiating $`\boldsymbol W(t)`$ with respect to $`t`$ and using the differential equation and the chain rule, we have

$$
\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\tag{1.10}
$$


> The system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $`\mathrm d\boldsymbol z/\mathrm dt=\boldsymbol f(\boldsymbol z)`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem variationalequationliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-VariationalEquationLiteral，改动：采用W(t)=DF_t(ξ)，保留C¹向量场及真实流资格。 -/
theorem variationalequationliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral_corrected F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral_corrected F ξ t)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.variationalequationliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\quad\text{(1.10)}`$ | MD.Ch01.variationalequationliteral，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

原W的取值点多复合一次F\_t，时间微分产生额外链式项，不满足标准变分方程。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal完整保留C¹向量场、每个F\_t为C¹、真实流初值和时间ODE，以及全部ξ,t上的算子导数；右端复合顺序Df(F\_tξ)∘W正确，但原文字面W使方程失效。corrected使用DF\_t(ξ)后为正确标准变分方程。C¹向量场和全局真实解以唯一性及局部参数依赖给出所需时间可微性，无需额外假设F联合C²；sorry不构成签名失败。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2538；MD.Ch01.variationalequationliteral。

## 1. MD-1.7.2-NearbyTrajectoryLiteral · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> If we have two solutions started from nearby initial conditions $`\boldsymbol\xi,\hat{\boldsymbol\xi}`$, then their difference is approximated by the solution of the variational equations

$$
\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-NearbyTrajectoryLiteral，改动：线性化在初值ξ处取DF_t，固定t的余项为o(扰动)。 -/
theorem nearby_trajectory_literal_corrected :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral_corrected F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  intro n F hF t ξ
  exact ((hF t).differentiable (by norm_num) ξ).hasFDerivAt.isLittleO
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nearby\_trajectory\_literal；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).`$ | MD.Ch01.nearby\_trajectory\_literal，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。 | [EXTRA] |

[EXTRA] ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。

### 6. 审计结论

错误取值点的导数通常与真实DF\_t(ξ)不同，差额线性项不是小o。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
固定t、ξ时以x→ξ的Fréchet小o严格化≈，扰动、基点、线性算子作用顺序均忠实。literal沿用错误取值点，不能成立。corrected改用DF\_t(ξ)后正是HasFDerivAt的小o结论；只需每个F\_t可微，故未要求真实流是合法推广，不是缺失的必要前提。未声称此结论关于t一致或对长时间有效。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2557；MD.Ch01.nearby\_trajectory\_literal。

## 1. MD-1.7.2-SingularValues · definition · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The square roots of the eigenvalues of $`\boldsymbol A^T\boldsymbol A`$, also called the singular values of $`\boldsymbol A`$, then give the axes of the image ellipsoid.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.singularValues；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。 | [EXTRA] |

[EXTRA] 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2575；MD.Ch01.singularValues。

## 1. MD-1.7.2-SingularEllipsoid · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> We may view a regular linear mapping $`\boldsymbol v\mapsto\boldsymbol A\boldsymbol v`$, where $`\boldsymbol A\in\mathbb R^{m\times m}`$, as a mapping of an $`m-1`$-dimensional sphere (embedded in the $`m`$-dimensional Euclidean space) to an ellipsoid in the same space (Fig. 1.26). The square roots of the eigenvalues of $`\boldsymbol A^T\boldsymbol A`$, also called the singular values of $`\boldsymbol A`$, then give the axes of the image ellipsoid.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem singularellipsoid :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1} := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.singularellipsoid；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。 | [EXTRA] |

[EXTRA] regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2584；MD.Ch01.singularellipsoid。

## 1. MD-1.7.2-LyapunovExponents · definition · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The Lyapunov exponents $`\lambda_1,\lambda_2,\ldots,\lambda_m`$ are defined by

$$
\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),
$$


> where $`\sigma_i`$ represents the ith singular value of the given matrix (to maintain continuity, these should be ordered in some way, say largest to smallest).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lyapunovExponent；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\lambda_i=\limsup_{t\to\infty}\frac1t\log\sigma_i(\boldsymbol W),`$ | MD.Ch01.lyapunovExponent，完整展开陈述见上一行及第4段 | 一致 |
| limsup与有序奇异值 | Filter.limsup ((Real.log (σ t)/t : ℝ) : EReal) atTop；σ为singularValues关系的第i分量 | 一致 |
| 原文未显式量化的技术资格 | 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。 | [EXTRA] |

[EXTRA] 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2596；MD.Ch01.lyapunovExponent。

## 1. MD-1.7.2-PositiveLyapunovGrowth · unnumbered_claim · 印刷p.45 / PDFp.68

### 2. 原文陈述

> The presence of a positive Lyapunov exponent implies exponential growth of perturbations, which, as we have seen, is one of the hallmarks of chaos.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positivelyapunovgrowth :
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t := by
  intro σ hσ hpos
  obtain ⟨c,hc,hclim⟩ := EReal.exists_between_coe_real hpos
  refine ⟨c,EReal.coe_pos.mp hc,?_⟩
  intro T
  change (c : EReal) < Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop at hclim
  have hf := Filter.frequently_lt_of_lt_limsup (h := hclim)
  obtain ⟨t,htc,htt⟩ := (hf.and_eventually (eventually_gt_atTop (max T 0))).exists
  have ht : 0 < t := lt_of_le_of_lt (le_max_right T 0) htt
  refine ⟨t,lt_of_le_of_lt (le_max_left T 0) htt,?_⟩
  have hl : c < Real.log (σ t)/t := EReal.coe_lt_coe_iff.mp htc
  have he : c*t < Real.log (σ t) := (lt_div_iff₀ ht).mp hl
  exact (Real.exp_lt_exp.mpr he).trans_eq (Real.exp_log (hσ t ht))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positivelyapunovgrowth；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 正limsup蕴涵指数放大 | ∃c>0,∀T,∃t>T,Real.exp(c*t)<σ t | 一致；任意晚子列，不增强为全部晚时刻 |
| 原文未显式量化的技术资格 | 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。 | [EXTRA] |

[EXTRA] 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2603；MD.Ch01.positivelyapunovgrowth。

