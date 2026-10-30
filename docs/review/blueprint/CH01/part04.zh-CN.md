[上一部分](part03.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## 1. MD-1.5.2-PlanarGraphReduction · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> In principle such an equation can be solved (locally at least) for $`y`$ as a function of $`x`$ due to the implicit function theorem. Hence one may write $`y=\psi(x)`$. Reinsert this into the first differential equation to get a reduced equation in just one dependent variable:

$$
\frac{\mathrm dx}{\mathrm dt}=g(x,\psi(x)).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem planargraphreduction :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0),
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t) := by
  exact @MolecularDynamics.planarFirstIntegral_localGraph_reduction
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planargraphreduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\mathrm dx}{\mathrm dt}=g(x,\psi(x)).`$ | MD.Ch01.planargraphreduction，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。 | [EXTRA] |

[EXTRA] 对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
量词覆盖任意平面向量场、区域、第一积分、真实解及区间内基点。hJ 是该点严格微分，hpartial 精确为 y 方向微分非零。结论给出可微图、附近整个水平集与图的双向等价、原轨道在局部时间窗的图表示及第一坐标的约化 ODE，非仅假设了所需结论。条件化签名正确；原句无条件措辞另标 NEEDS\_HUMAN。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1230；MD.Ch01.planargraphreduction。

## 1. MD-1.5.2-PlanarQuadrature · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Such an ordinary differential equation is said to be separable, and theoretically can be solved, given an initial condition, for x as a function of t.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem planarquadrature :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (f (γ t₀)).1 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1,
        g (separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (γ t).1 = t - t₀) := by
  exact @MolecularDynamics.planarFirstIntegral_nonturning_quadrature
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarquadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 正则第一积分图及非转向速度非零；真实C2、局部积分逆。 | [EXTRA] |

[EXTRA] 正则第一积分图及非转向速度非零；真实C2、局部积分逆。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
原文句子与第4页相符。hfirst 不是约化结论假设；真实解、区间内基点、C¹ 正则性、y 偏导非零及 x 速度非零均明确。结论给局部 ψ、时间逆 g、g′(0)=f₁、解的局部参数化、积分原函数与 g 双向局部互逆以及整个小时间窗积分恒等式。δ 虽未用于邻域界，仅冗余存在量，不影响正确性。此为非转向点上的分离变量结论，额外非退化资格已披露。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1248；MD.Ch01.planarquadrature。

## 1. MD-1.5.2-ScalarFirstIntegral · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Example 1.6 The single degree of freedom model of Example 1.4 has the energy as a first integral. The system is therefore integrable.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem scalar_first_integral_and_quadrature :
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U),
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U)) ∧
  (∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : (γ t₀).2 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (γ t₀).2 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1, g (separableTimePrimitive ψ (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive ψ (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive ψ (γ t₀).1 (γ t).1 = t - t₀)) := by
  exact ⟨@MolecularDynamics.scalarPotentialEnergy_isFirstIntegral, @MolecularDynamics.scalarPotential_nonturning_quadrature⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalar\_first\_integral\_and\_quadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| energy as a first integral | scalarPotentialEnergy\_isFirstIntegral的完整签名 | 一致 |
| therefore integrable | scalarPotential\_nonturning\_quadrature的实际局部积分逆重建 | 一致；非转向资格显式 |
| 原文未显式量化的技术资格 | U C2；开放时间段真实解、积分逆图使用速度非零点；转向点全局拼接不声称已有证明。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.scalar\_first\_integral\_and\_quadrature | 本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。 |

[EXTRA] U C2；开放时间段真实解、积分逆图使用速度非零点；转向点全局拼接不声称已有证明。；[EXTRA] 本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：本条正式覆盖为“能量守恒 + 非转向点局部求积”的部分形式化；转向点换坐标求积、平衡点常解分类和全局拼接列为覆盖缺口，不补理论。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
第5页 Example 1.6 转录相符。第一合取对任意 C² 势能证明能量 v²/2+U(x) 为 (v,−U′(x)) 的第一积分；第二合取的积分逆、局部参数化及速度符号均正确，但只量化速度非零点。相较原文“system is therefore integrable”的完整覆盖，缺少真实解在转向点的改用速度坐标求积、平衡点常解及相应重建说明。不是命题本身为假，也不是因 sorry 判 FAIL，而是覆盖不全。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1271；MD.Ch01.scalar\_first\_integral\_and\_quadrature。

## 1. MD-1.5.1-RealSpectralSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> Observations: (i) eigenvectors, eigenvalues, and coefficients $`c_i`$ may be complex, but if $`\boldsymbol A`$ and $`\boldsymbol\xi`$ have real coefficients, it is nonetheless possible to obtain a real solution,

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem realspectralsolution :
  ∀ {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ)
    (b : Module.Basis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (ν : Fin m → ℂ)
    (hb : ∀ j, Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)
      (b j) = ν j • b j)
    (z : EuclideanSpace ℂ (Fin m)) (hz : ∀ j, (z j).im = 0) (t : ℝ) (i : Fin m),
    ((∑ j, (b.repr z j * Complex.exp (ν j * (t : ℂ))) • b j) i).im = 0 := by
  exact @MolecularDynamics.realMatrix_complexSpectral_sum_isReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.realspectralsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1292；MD.Ch01.realspectralsolution。

## 1. MD-1.5.2-KeplerEnergy · definition · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Example 1.7 The Kepler problem describes the motion of a body in the plane moving under gravitational force exerted by a second, fixed body (located at the origin); it has the energy $`E(x,y,\dot x,\dot y)=\dot x^2/2+\dot y^2/2-1/\sqrt{x^2+y^2}`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def planarKeplerEnergy (x y v w : ℝ) : ℝ :=
  v^2/2 + w^2/2 - 1/Real.sqrt (x^2+y^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarKeplerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1306；MD.Ch01.planarKeplerEnergy。

## 1. MD-1.5.2-KeplerConservedEnergy · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> The two conserved quantities, energy and angular momentum, mean that the Kepler problem is an integrable system.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem kepler_energy_angular_integrability :
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t)) ∧
  (∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t)) ∧
  (∀ (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z),
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = (fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = (((fun r θ : ℝ => (WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ] : Position 2)) (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀])) := by
  refine ⟨@MolecularDynamics.kepler_energy_const_on_Ioo 2, @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo, ?_⟩
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.kepler\_energy\_angular\_integrability；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| energy and angular momentum | 平面真实解的kepler\_energy\_const\_on\_Ioo与kepler\_planarAngularMomentum\_const\_on\_Ioo完整签名 | 一致；两结论已桥接 |
| mean that … is an integrable system | 整个非碰撞存在区间的径向quadrature、角积分与初值重建合取 | 一致；未以只证明能量守恒代替全部结论 |
| 原文未显式量化的技术资格 | 真实平面非碰撞机械解；积分重建的整个存在区间含0，角为连续实提升；不声称穿越碰撞的全局轨道。 | [EXTRA] |

[EXTRA] 真实平面非碰撞机械解；积分重建的整个存在区间含0，角为连续实提升；不声称穿越碰撞的全局轨道。

### 6. 审计结论

逐字整句含能量守恒、角动量守恒与可积性三结论；已扩为完整合取。两守恒量用既有证明，完整极坐标/quadrature重建保持占位。

网站：网站PASS（EAUDIT复审）。
第6页整句转录相符。签名三重合取覆盖单位质量非碰撞平面解的能量常性、平面角动量常性，以及含0存在区间的径向—角向重建。massHamiltonian 展开为各动量平方/2减范数倒数；planarAngularMomentum 是 q₀p₁−q₁p₀。重建给 r>0、r′=v、有效势径向 ODE、角积分及位置；ScalarPotentialLocalDescription 覆盖径向非转向、转向及平衡三类，并用初始位置和动量公式联系初值，未将重建当作假设。有效势在 r=0 的总化不影响 r>0 上局部分类。原文可积性按求积与逆函数理解，未额外声称碰撞后的延拓。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1313；MD.Ch01.kepler\_energy\_angular\_integrability。

## 1. MD-1.5.2-KeplerAngularMomentum · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> however, due to the fact that the potential energy is rotationally invariant (dependent only on the distance of the moving particle from the origin), the angular momentum of the system is conserved.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerangularmomentum :
  ∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) := by
  exact @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerangularmomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第7页转录相符。任意非碰撞单位质量平面机械解、任意同一开放区间内 s,t，结论 q₀p₁−q₁p₀ 相等。velocityOperator 在单位质量下为恒等，故动量就是速度，与原文 xẏ−yẋ 一致。keplerForce 是径向中心力，力矩为零；这里只专门化原书 Kepler 例，未声称已形式化任意旋转不变势的 Noether 定理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1346；MD.Ch01.keplerangularmomentum。

## 1. MD-1.5.2-KeplerMomentum · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Note that a consequence of fixing one of the bodies in the Kepler problem is that the two components of the total momentum vector, i.e. $`(m\dot x,m\dot y)`$, are obviously no longer conserved;

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplermomentum :
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0 := by
  intro q hq
  simp [keplerForce, smul_eq_zero, hq, norm_ne_zero_iff.mpr hq]

theorem keplermomentum_not_first_integrals :
    ∀ i : Fin 2, ¬ IsFirstIntegralOn
      (mechanicalVectorField (fun _ : Fin 2 => (1 : ℝ)) keplerForce)
      {z : PhaseSpace 2 | z.1 ≠ 0} (fun z : PhaseSpace 2 => z.2 i) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplermomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | q≠0；单位质量。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.keplermomentum; MD.Ch01.keplermomentum\_not\_first\_integrals | 保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.keplermomentum; MD.Ch01.keplermomentum\_not\_first\_integrals | 保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。 |

[EXTRA] q≠0；单位质量。；[EXTRA] 19号：保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。

### 6. 审计结论

19号本地签名预审：保留非零力引理；另明确两个坐标动量各自不是对所有初值守恒的第一积分，不误称每条轨道两分量都变化。

网站：网站PASS（EAUDIT复审）。
第8页转录相符。主声明对每个 q≠0 给非零向心力，正确但单独不足以证明两个坐标分别不是第一积分。[EXTRA] keplermomentum\_not\_first\_integrals 对每个 i∈Fin 2 分别否定坐标动量在整个非碰撞相空间上、对所有真解的常性，补齐原文语义。取初始 q=eᵢ 时该坐标动量导数为−1，因此否定成立；不误称每条轨道的每个分量都变化。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1358；MD.Ch01.keplermomentum。

## 1. MD-1.5.2-PolarCoordinates · definition · 印刷p.29 / PDFp.52

### 2. 原文陈述

> In polar coordinates $`(x,y)=(r\cos\theta,r\sin\theta)`$, the Lagrangian $`L`$ for the Kepler problem is

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def polarCoordinates (r θ : ℝ) : Position 2 := WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.polarCoordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1373；MD.Ch01.polarCoordinates。

## 1. MD-1.5.2-KeplerPolarLagrangian · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述


$$
L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.
$$



### 3. 原文证明


$$
L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.
$$


原页三角/代数恒等式计算即原文论证，逐字引用；原文陈述中的同一计算保留。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerpolarlagrangian :
  ∀ (r θ v omega : ℝ),
    ((v * Real.cos θ - r * omega * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * omega * Real.cos θ) ^ 2) / 2 + 1 / r =
    v ^ 2 / 2 + r ^ 2 * omega ^ 2 / 2 + 1 / r := by
  exact @MolecularDynamics.keplerPolarLagrangian_identity
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerpolarlagrangian；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`L=K-U=\frac12(\dot r\cos\theta-r\dot\theta\sin\theta)^2+\frac12(\dot r\sin\theta+r\dot\theta\cos\theta)^2+\frac1r=\frac{\dot r^2}2+\frac{r^2\dot\theta^2}2+\frac1r.`$ | MD.Ch01.keplerpolarlagrangian，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1379；MD.Ch01.keplerpolarlagrangian。

## 1. MD-1.5.2-KeplerPolarODE · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Working these out directly, one gets

$$
\ddot r=-\frac1{r^2}+r\dot\theta^2,\qquad0=\frac{\mathrm d}{\mathrm dt}(r^2\dot\theta).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerpolarode :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ),
    IsKeplerPolarEulerLagrangeOn I r θ v omega ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (omega t) t ∧
        HasDerivAt v (r t * omega t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * omega u) 0 t := by
  exact @MolecularDynamics.keplerPolar_eulerLagrange_iff
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerpolarode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\ddot r=-\frac1{r^2}+r\dot\theta^2,\qquad0=\frac{\mathrm d}{\mathrm dt}(r^2\dot\theta).`$ | MD.Ch01.keplerpolarode，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第9页两式转录相符。对任意时间集合 I 和 r,θ,v,omega，左侧完整展开为正半径、r′=v、θ′=omega 及 L=v²/2+r²omega²/2+1/r 的两条 Euler–Lagrange 方程。对速度和半径的偏导分别为 v、r omega²−r⁻²；角动量偏导为 r²omega，角偏导为0。右侧恰给这两式及真实一阶导数，故不是用同义命名掩盖缺失运动方程。context\_notation 的“r≠0”可加强精确写为“r>0”，签名本身无误。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1390；MD.Ch01.keplerpolarode。

## 1. MD-1.5.2-PolarAngularIdentity · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Expressed in polar coordinates this is

$$
l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta) =r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,
$$



### 3. 原文证明

> Expressed in polar coordinates this is

$$
l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta) =r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,
$$


原页三角/代数恒等式计算即原文论证，逐字引用；原文陈述中的同一计算保留。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem polarangularidentity :
  ∀ (r θ v omega : ℝ),
    (r * Real.cos θ) * (v * Real.sin θ + r * omega * Real.cos θ) -
      (r * Real.sin θ) * (v * Real.cos θ - r * omega * Real.sin θ) = r ^ 2 * omega := by
  exact @MolecularDynamics.polarAngularMomentum_identity
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.polarangularidentity；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`l_z=(r\cos\theta)(\dot r\sin\theta+r\dot\theta\cos\theta)-(r\sin\theta)(\dot r\cos\theta-r\dot\theta\sin\theta)\lt br\gt =r^2\dot\theta(\cos^2\theta+\sin^2\theta)=r^2\dot\theta,`$ | MD.Ch01.polarangularidentity，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1402；MD.Ch01.polarangularidentity。

## 1. MD-1.5.2-KeplerRadialReduction · unnumbered_claim · 印刷p.29 / PDFp.52

### 2. 原文陈述

> Taking this quantity as fixed, we may write the remaining equation as $`\ddot r=-1/r^2+l_z^2/r^3`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem keplerradialreduction :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v omega) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * omega t = l),
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t := by
  exact @MolecularDynamics.keplerPolar_radial_reduction
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.keplerradialreduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。 | [EXTRA] |

[EXTRA] r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第10页转录相符。任意极坐标 Euler–Lagrange 真解、任意 t∈I、任意等于当时 r²omega 的 l，结论 v′=−r⁻²+l²/r³。由正半径及 omega=l/r² 代入径向式直接成立。hl 虽是单时刻相等而非全区间常数，已经足够推出本条点态结论；作为固定守恒角动量的应用需再结合上一条在连通时间区间的常性，未虚构全局常性。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1412；MD.Ch01.keplerradialreduction。

## 1. MD-1.5.2-KeplerRadialEnergy · definition · 印刷p.29–30 / PDFp.52–53

### 2. 原文陈述

> The equation for $`r`$ is that of a one-degree-of-freedom system with energy

$$
\widehat E(r,\dot r)=\frac{\dot r^2}2-\frac1r+\frac{l_z^2}{2r^2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def radialKeplerEnergy (ℓ r v : ℝ) : ℝ := v^2/2-1/r+ℓ^2/(2*r^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.radialKeplerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\widehat E(r,\dot r)=\frac{\dot r^2}2-\frac1r+\frac{l_z^2}{2r^2}.`$ | MD.Ch01.radialKeplerEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1423；MD.Ch01.radialKeplerEnergy。

## 1. MD-1.5.2-KeplerFullSolution · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> From our previous work, we know that this system (a single degree of freedom system) can be solved for $`r`$ as a function of $`t`$ and the initial conditions. Once $`r=r(t)`$ is known, we may obtain $`\theta`$ by integration:

$$
\theta=\theta(0)+\int_0^t\frac{l_z}{r^2(s)}\,\mathrm ds.
$$


> The example shows that the full solution of the Kepler problem can be worked out given the initial conditions, as long as we are happy to express the solution in terms of antiderivatives of simple functions (and their inverses).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem kepler_full_solution (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z) :
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = polarCoordinates (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = ((polarCoordinates (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀]) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.kepler\_full\_solution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\theta=\theta(0)+\int_0^t\frac{l_z}{r^2(s)}\,\mathrm ds.`$ | MD.Ch01.kepler\_full\_solution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。 | [EXTRA] |

[EXTRA] 完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
第11页三段原文及角积分转录相符。任意含0非碰撞平面真解产生全区间正半径、径向真导数和有效势方程、连续实角提升的积分表达、位置重建以及初始全相空间公式。ScalarPotentialLocalDescription 展开覆盖每个 t₀ 的非转向积分逆、转向交换坐标积分逆或径向常解；后者包括圆轨道，不误作整个二维轨道静止。θ₀ 与 z(0) 的对应由初始公式给定。声明不单独断言从任意初值构造解/唯一解，但在已有真解语境下完整给出本条求积表示和重建，符合披露的存在区间资格。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1429；MD.Ch01.kepler\_full\_solution。

## 1. MD-1.5.2-ActionAngleCoordinates · definition · 印刷p.30 / PDFp.53

### 2. 原文陈述

> Define new variables

$$
x=\sqrt{2I/\Omega}\cos\theta,\qquad v=\sqrt{2I\Omega}\sin\theta.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def oscillatorActionAngle (Ω I θ : ℝ) : ℝ × ℝ :=
  (Real.sqrt (2*I/Ω)*Real.cos θ, Real.sqrt (2*I*Ω)*Real.sin θ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.oscillatorActionAngle；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`x=\sqrt{2I/\Omega}\cos\theta,\qquad v=\sqrt{2I\Omega}\sin\theta.`$ | MD.Ch01.oscillatorActionAngle，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1449；MD.Ch01.oscillatorActionAngle。

## 1. MD-1.5.2-ActionEnergy · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> In these variables, the energy is $`E=I\Omega`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem actionenergy :
  ∀ (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J),
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω := by
  exact @MolecularDynamics.harmonicAction_energy
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.actionenergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω>0，I≥0；harmonicActionVelocity\_formula保证v的sqrt(2IΩ)形式一致。 | [EXTRA] |

[EXTRA] Ω>0，I≥0；harmonicActionVelocity\_formula保证v的sqrt(2IΩ)形式一致。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第12页原文 E=IΩ 相符。对 Ω>0、J≥0 及任意实角 θ，位置 A cosθ、速度 ΩA sinθ，A=√(2J/Ω)，代入 v²/2+Ω²x²/2 得 JΩ。Ω>0 保证 ΩA=√(2JΩ)，与原书速度坐标一致；允许 J=0 的能量等式正确，不需要此处定义非退化角。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1456；MD.Ch01.actionenergy。

## 1. MD-1.5.2-ActionODE · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> Introducing these formulas into the equations of motion and simplifying leads to $`\dot I=0`$, $`\dot\theta=-\Omega`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem actionode :
  ∀ (Ω : ℝ) (J θ : ℝ → ℝ) (d omega t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ omega t),
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ omega = -Ω := by
  exact @MolecularDynamics.harmonicAction_ode_iff
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.actionode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω,I正；真实I′、θ′，非退化局部角坐标。 | [EXTRA] |

[EXTRA] Ω,I正；真实I′、θ′，非退化局部角坐标。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第13页转录相符。Ω>0、J(t)>0，给 J 和 θ 在 t 的真实导数 d、omega；双向等价将重建位置速度的两条谐振子 ODE 精确化为 d=0、omega=−Ω。正 J 保证角坐标非退化且振幅平方根可微，消去二元线性系统合法；原书正号速度与负号角速度一致，没有符号翻转。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1466；MD.Ch01.actionode。

## 1. MD-1.5.2-ActionSolution · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> The first equation expresses the constancy of energy; the second describes a rotation with frequency $`\Omega`$, i.e., the solution is $`\theta(t)=\theta(0)-\Omega t`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem actionsolution :
  ∀ (Ω a b : ℝ) (J θ : ℝ → ℝ)
    (hΩ : 0 < Ω) (hJ : ∀ t ∈ Ioo a b, 0 < J t)
    (hreg : ∀ t ∈ Ioo a b, DifferentiableAt ℝ J t ∧ DifferentiableAt ℝ θ t)
    (hODE : ∀ t ∈ Ioo a b,
      HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    J t = J s ∧ θ t = θ s - Ω * (t - s) := by
  exact @MolecularDynamics.harmonicAction_time_formula
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.actionsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 连通开放时间窗含起始s；正action及Ω，真实坐标解。 | [EXTRA] |

[EXTRA] 连通开放时间窗含起始s；正action及Ω，真实坐标解。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
第14页转录相符。Ω>0、全开放区间正 J、J 和实角提升处处可微及重建量满足两条谐振子 ODE，推出任意 s,t∈同一区间的 J(t)=J(s)、θ(t)=θ(s)−Ω(t−s)。区间连通性排除跳支；无需额外假定全局实角定义以外的周期连续选择。s=0 且0在区间内即原书公式；同时保留第一方程的能量常性。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1479；MD.Ch01.actionsolution。

## 1. MD-1.5.2-HarmonicTorus · definition · 印刷p.30 / PDFp.53

### 2. 原文陈述

> The simple change of variables $`((x_j,v_j)\to(I_j,\theta_j))`$, applied to each oscillator, would yield equations of motion $`\dot I_j=0`$, $`\dot\theta_j=-\Omega_j`$. This describes a point winding about a $`d`$-dimensional torus defined by angular rotation frequencies $`\Omega_j`$ and radii $`|I_j|`$ (Fig. 1.14).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.oscillatorTorusMotion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
oscillatorTorusMotion 为任意 d、固定实 action 向量 I、频率 Ω、初始模2π角向量定义 (I, θ₀−Ωt)。展开 HarmonicTorus 和 rotation 可核对全部分量，确实保持每个 action 并以负频率旋转；这是原文作用角运动的定义层表示，而非已证明原相空间与该环面的微分同胚。原书“radii |I\_j|”在此由固定 action 参数记录，未给额外几何嵌入；当 action 为0时不应由本定义推出原相空间等能层仍有 d 维。作为 definition 审校通过，不能将其引用为无退化条件的坐标变换定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1496；MD.Ch01.oscillatorTorusMotion。

## 1. MD-1.5.2-TorusPeriod · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> Depending on the ratio of frequencies such motions may be periodic or quasi-periodic;

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem torusperiod :
  ∀ {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n),
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T := by
  exact @MolecularDynamics.harmonicTorusRotation_periodic_iff_integer

/-- Finite-dimensional torus translation: a quasiperiodic representation allows resonances. -/
def torusQuasiperiodic {n : ℕ} (γ : ℝ → HarmonicTorus n) : Prop :=
  ∃ (Ω : Fin n → ℝ) (θ : HarmonicTorus n), γ = fun t => harmonicTorusRotation Ω t θ

theorem torusperiod_classification {n : ℕ} (Ω : Fin n → ℝ) (θ : HarmonicTorus n) :
    (∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) ∨
    (torusQuasiperiodic (fun t => harmonicTorusRotation Ω t θ) ∧
      ¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) := by
  classical
  by_cases h : ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T
  · exact Or.inl h
  · exact Or.inr ⟨⟨Ω,θ,rfl⟩,h⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.torusperiod；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.torusperiod; MD.Ch01.torusQuasiperiodic; MD.Ch01.torusperiod\_classification | 保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.torusperiod; MD.Ch01.torusQuasiperiodic; MD.Ch01.torusperiod\_classification | 保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。 |

[EXTRA] 给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。；[EXTRA] 19号：保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。

### 6. 审计结论

19号本地签名预审：保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。

网站：网站PASS（EAUDIT复审）。
第16页原文相符。torusperiod 对任意有限 n、频率向量、实 T 和初角，给指定 T 是周期当且仅当每个 ΩⱼT 是2π整数倍；T=0、负T、零频率及 n=0 均正确。[EXTRA] torusQuasiperiodic 明示采用允许共振的有限环面平移表示定义；classification 用存在正周期与其否定给互斥完备二分。该定义比要求有理独立基频的某些惯例更宽，但已披露，结论没有声称非周期必稠密整个 n 维环面。原书按频率比的非形式化措辞在此有整数圈精确判据，不把 classification 的排中律误作独立无共振定理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1503；MD.Ch01.torusperiod。

## 1. MD-1.5.2-TorusDense · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> in the latter case the paths do not “close up” but instead we the curve gradually fills in the surface of the torus.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem torusdense :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：另补原句“非周期即充满整个环面”的literal；修正版显式全整数无共振，原有带资格陈述不变。 -/
theorem torusdense_literal :
    ∀ (n : ℕ) (Ω : Fin n → ℝ) (θ : HarmonicTorus n),
      (¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) →
      DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-TorusDense，改动：明确全整数无共振资格。 -/
theorem torusdense_corrected :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.torusdense；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。 | [EXTRA] |

[EXTRA] 高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。

### 6. 审计结论

高维准周期运动可能只在真子环面稠密；无正周期不等于全维无共振。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
torusdense 与 torusdense\_corrected 完全量化所有整数向量 k，要求 k·Ω=0 仅有零解；在连续实时间的模2π环面平移下这是全环面稠密的正确条件，不需要离散时间版本的额外常数项。torusdense\_literal 只假设无正周期，忠实表达上下文 quasi-periodic 的字面推论，但 n≥3 时为假。分别结论：torusdense PASS；torusdense\_literal 原文忠实性 PASS、原书数学 NEEDS\_HUMAN；torusdense\_corrected PASS。不能因 literal 带 sorry 判签名失败，也不能把修正版正确等同于原书无误。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1527；MD.Ch01.torusdense。

## 1. MD-1.5.2-LocalActionAngleReduction · unnumbered_claim · 印刷p.30 / PDFp.53

### 2. 原文陈述

> More generally, one finds occasional examples of nonlinear systems which possesses as many independent first integrals as degrees of freedom (satisfying a certain “involution” condition); such systems may be reduced via coordinate transformation to action-angle variables, i.e. they exhibit tori motion.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem local_action_angle_reduction :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：原书无紧性资格的环面推断另记literal；默认紧、连通、非空、正则共同水平集，保留局部正则坐标与全局环面结论。 -/
theorem local_action_angle_reduction_literal :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- 修正版，对应原文 MD-1.5.2-LocalActionAngleReduction，改动：紧连通非空正则共同水平集。 -/
theorem local_action_angle_reduction_corrected :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.local\_action\_angle\_reduction；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。 | [EXTRA] |

[EXTRA] 全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。

### 6. 审计结论

独立对合第一积分只给局部正则结构；非紧共同水平集未必为环面。IsConnected含非空。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
三个声明均核对：对象为2d维标准实相空间、d个C∞积分、全空间两两 Poisson 括号为零、共同水平集 S 及 S 上每点微分映射满射。symplecticGradient=(∂pH,−∂qH)，canonicalBilinear=dq∧dp，符号自洽。localActionAngle 要求开邻域上的双向光滑逆、保辛微分及全部 Hamilton 向量场被送到(0,Ωᵢ(q))，给局部正则坐标中的角向运动；它未明确规定新 action 就是原 I，属于合适的局部规约表达。主声明与 corrected 的 S 紧且 IsConnected（含非空）加正则性正好提供 Liouville–Arnold 环面资格；同一 e:S≃ₜTᵈ 同时线性化各个积分的流，Ω 的负号可吸收进选择的频率，不要求预指定正频率。literal 去掉紧连通资格而仍要 S≃ₜTᵈ，在非紧或空水平集上为假，但忠实反映原句过强措辞。分别：主声明 PASS；literal 忠实性 PASS、数学 NEEDS\_HUMAN；corrected PASS。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1551；MD.Ch01.local\_action\_angle\_reduction。

## 1. MD-1.5.3-Equilibrium · definition · 印刷p.31 / PDFp.54

### 2. 原文陈述

> An equilibrium point of such system is a solution of $`f(\boldsymbol z)=0`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def equilibriumDefinition {n : ℕ} (f : Position n → Position n) (z : Position n) : Prop := f z = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilibriumDefinition；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1598；MD.Ch01.equilibriumDefinition。

## 1. MD-1.5.3-ConstantEquilibrium · unnumbered_claim · 印刷p.31 / PDFp.54

### 2. 原文陈述

> An equilibrium point $`\boldsymbol z^*`$ corresponds to an equilibrium solution, since if we define a constant function $`\boldsymbol z(t)=\boldsymbol z^*`$ then we have $`\dot{\boldsymbol z}(t)=f(\boldsymbol z^*)=0`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constantequilibrium :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (f : E → E) (z₀ : E) (t : ℝ),
    HasDerivAt (fun _ : ℝ => z₀) (f z₀) t ↔ f z₀ = 0 := by
  exact @MolecularDynamics.equilibrium_constant_ode_iff
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constantequilibrium；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1604；MD.Ch01.constantequilibrium。

