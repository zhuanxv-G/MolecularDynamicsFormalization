[上一部分](part01.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-1.5-EnergyBounds · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> Assume that $`U`$ is a potential energy function which is bounded below, $`U\geq U_{\min}`$. For given $`E_0\geq U_{\min}`$ define $`\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}`$. Then, for $`(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}`$ we have

$$
\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.
$$


> $`\boldsymbol M^{-1}`$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $`E_0`$,

$$
U_{\min}\leq U(\boldsymbol q)\leq E_0.
$$



### 3. 原文证明

> Then, for $`(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}`$ we have

$$
\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.
$$


> $`\boldsymbol M^{-1}`$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $`E_0`$,

$$
U_{\min}\leq U(\boldsymbol q)\leq E_0.
$$


原页能量不等式及正定推界论证逐字引用；与陈述合引部分保留，未添加原书没有的证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem energy_bounds {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : ∀ q, Umin ≤ U q) :
    (∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ →
      inner ℝ p (matrixAction M⁻¹ p) / 2 = E₀ - U q ∧
      inner ℝ p (matrixAction M⁻¹ p) / 2 ≤ E₀ - Umin ∧ Umin ≤ U q ∧ U q ≤ E₀) ∧
    ∃ R : ℝ, ∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ → ‖p‖ ≤ R := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energy\_bounds；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.`$；$`U_{\min}\leq U(\boldsymbol q)\leq E_0.`$ | MD.Ch01.energy\_bounds，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。 | [EXTRA] |

[EXTRA] U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1040；MD.Ch01.energy\_bounds。

## 1. MD-1.5-UniformLevelsCompact · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> What is needed is an assumption that the level sets $`\widehat\Sigma_\alpha=\{\boldsymbol q\mid U(\boldsymbol q)=\alpha\}`$ are bounded uniformly for $`\alpha\in[U_{\min},E_0]`$. Then it follows that solutions satisfying the energy constraint remain confined to a compact (closed and bounded) set.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem uniform_levels_compact {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : Continuous U) (hlower : ∀ q, Umin ≤ U q)
    (hlevels : ∃ R : ℝ, ∀ α ∈ Icc Umin E₀, ∀ q, U q = α → ‖q‖ ≤ R) :
    IsCompact {z : PhaseSpace n | variableMassHamiltonian (fun _ => M) U z.1 z.2 = E₀} := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.uniform\_levels\_compact；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。 | [EXTRA] |

[EXTRA] U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1053；MD.Ch01.uniform\_levels\_compact。

## 1. MD-1.5-CompactContinuation · unnumbered_claim · 印刷p.25–26 / PDFp.48–49

### 2. 原文陈述

> The uniqueness of solutions is easily verified in the usual way (as for the local result for uniqueness of solutions). The key point is that, with the energy constraint, solutions typically remain bounded for all time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
/- General confinement helper retained separately from the Hamiltonian result. -/
theorem compact_continuation_aux {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry

theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z₀ : PhaseSpace n) (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U)
    (hlower : ∃ b : ℝ, ∀ q, b ≤ U q)
    (hconfine : ∀ E : ℝ, Bornology.IsBounded {q : Position n | U q ≤ E}) :
    ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ γ ∧ γ 0 = z₀ ∧
      (∀ t, massHamiltonian m U (γ t) = massHamiltonian m U z₀) ∧
      Bornology.IsBounded (Set.range γ) ∧
      (∀ η : ℝ → PhaseSpace n,
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ η → η 0 = z₀ → η = γ) ∧
      (∀ a b η, 0 ∈ Ioo a b →
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ (Ioo a b) η → η 0 = z₀ →
        ∀ t ∈ Ioo a b, η t = γ t) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.compact\_continuation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.compact\_continuation\_aux; MD.Ch01.compact\_continuation | 主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.compact\_continuation\_aux; MD.Ch01.compact\_continuation | 主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。 |

[EXTRA] 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。；[EXTRA] 19号：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。

### 6. 审计结论

19号本地签名预审：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。

网站：网站PASS（EAUDIT复审）。
aux：正质量、开放Q、C¹力、紧K⊂Q×P、初值在K，hconfine只量化已有局部解，不循环假设全局存在；结论是全实时间解且留K。主条：任意初值、正对角质量、全域C²实势、统一下界以及每个次水平集有界；结论同时含全时间机械解、初值、能量守恒、轨道有界、全局解函数唯一以及含0开区间上的局部解逐点唯一。闭次水平集由连续性给出，有限维闭有界给紧性；动量界由能量和正质量给出。原书p26的能级集在α区间上一致有界正对应次水平集有界，已展开背景，不把仅能量守恒误作普遍位置有界。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1074；MD.Ch01.compact\_continuation。

## 1. MD-1.5-Nonconfining · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The assumption on $`U`$ is not satisfied by some simple potentials. For example consider $`U(x,y)=x^2`$ which is completely independent of $`y`$ and so places no restriction on that variable for constant energy.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nonconfining :
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1} := by
  intro h
  obtain ⟨R,hR⟩ := h.exists_norm_le
  let q : Position 2 := WithLp.toLp 2 ![1,|R|+1]
  have hb : ‖q‖ ≤ R := hR q (by simp [q])
  have hv : |R|+1 ≤ ‖q‖ := by
    simpa [q, abs_of_nonneg (by positivity : 0 ≤ |R|+1)] using PiLp.norm_apply_le q (1 : Fin 2)
  have := le_abs_self R
  linarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nonconfining；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1093；MD.Ch01.nonconfining。

## 1. MD-1.5.1-FlowMap · definition · 印刷p.26 / PDFp.49

### 2. 原文陈述

> Consider now the initial value problem

$$
\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\tag{1.5}
$$


> in a $`m`$-dimensional space. If we assume that $`f`$ corresponds to a molecular Hamiltonian system satisfying the assumptions of the existence and uniqueness result of the previous subsection, then we may define a mapping from a point in phase space to the point $`t`$ units later along the time-evolution starting from the initial point. We refer to this map as the flow map and denote it by $`\mathcal F_t`$. $`\mathcal F_t(\boldsymbol\xi)=\boldsymbol z(t)`$ solves the initial value problem (1.5).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def flowMap {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ ξ, F 0 ξ = ξ) ∧ ∀ ξ t, HasDerivAt (fun s => F s ξ) (f (F t ξ)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flowMap；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\quad\text{(1.5)}`$ | MD.Ch01.flowMap，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1108；MD.Ch01.flowMap。

## 1. MD-1.5.1-FlowEnergy · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The flow map of a Hamiltonian system conserves its Hamiltonian, thus

$$
H(\mathcal F_t(\boldsymbol\xi))\equiv H(\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ := by
  intro ξ t
  have hd (s : ℝ) : HasDerivAt (fun u => H (F u ξ)) 0 s := by
    let z := F s ξ
    let A := fderiv ℝ H z
    have hA : HasFDerivAt H A z := (hH z).hasFDerivAt
    have hq := hA.comp z.1 ((hasFDerivAt_id (𝕜 := ℝ) z.1).prodMk (hasFDerivAt_const (𝕜 := ℝ) z.2 z.1))
    have hp := hA.comp z.2 ((hasFDerivAt_const (𝕜 := ℝ) z.1 z.2).prodMk (hasFDerivAt_id (𝕜 := ℝ) z.2))
    simp only [Function.comp_def, id_eq] at hq hp
    let gq := gradient (fun q => H (q,z.2)) z.1
    let gp := gradient (fun p => H (z.1,p)) z.2
    have eqQ (v : Position n) : A (v,0) = inner ℝ gq v := by
      rw [inner_gradient_left, hq.fderiv]
      rfl
    have eqP (v : Position n) : A (0,v) = inner ℝ gp v := by
      rw [inner_gradient_left, hp.fderiv]
      rfl
    have hz : A (symplecticGradient H z) = 0 := by
      change A (gp,-gq) = 0
      have he : (gp,-gq) = (gp,0)+(0,-gq) := by simp
      rw [he, map_add, eqQ, eqP, inner_neg_right, real_inner_comm gq gp]
      ring
    have hh := hA.comp_hasDerivAt s ((hF ξ).2 s)
    have he : A (symplecticGradient H (F s ξ)) = 0 := hz
    rw [he] at hh
    simpa only [Function.comp_def] using hh
  have hc := is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
  simpa [(hF ξ).1] using hc
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flow\_energy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`H(\mathcal F_t(\boldsymbol\xi))=H(\boldsymbol\xi).`$ | MD.Ch01.flow\_energy，完整展开陈述见上一行及第4段 | 一致 |
| 一般Hamilton流保能量，所有初值与时间 | ∀ξ t,H(F t ξ)=H ξ；hF为实际symplecticGradient H的ODE | 一致；守恒未作前提 |
| 原文未显式量化的技术资格 | H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。 | [EXTRA] |

[EXTRA] H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。

### 6. 审计结论

已改一般H和一般Hamilton流，保留所有初值/时间守恒，未把机械可分离特例当通用证明。

网站：网站PASS（EAUDIT复审）。
任意有限维相空间、可微实H、全时间F。hF只含F(0,ξ)=ξ及真实Hamilton ODE，不预设守恒。结论对每个初值和每个实t均为H(F(t,ξ))=H(ξ)；symplecticGradient 的两个偏梯度及负号正确。可微H足以链式求导得到沿轨道导数为零，不必额外C¹。声明数学等号正确，源JSON恢复书面恒等号。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1115；MD.Ch01.flow\_energy。

## 1. MD-1.5.1-HarmonicPhaseFlow · definition · 印刷p.27 / PDFp.50

### 2. 原文陈述

> for which the solution subject to initial values $`q(0)=q_0,p(0)=p_0`$ is

$$
\begin{pmatrix}q(t)\\p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\\p_0\end{pmatrix}\equiv\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\\-q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)

theorem harmonicPhaseFlow_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    harmonicPhaseFlow Ω 0 z = z ∧
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω^2)) • q) univ univ (fun t => harmonicPhaseFlow Ω t z) := by
  constructor
  · simp [harmonicPhaseFlow]
  · exact harmonicFlow_isMechanicalSolution Ω hΩ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.harmonicPhaseFlow；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\begin{pmatrix}q(t)\cr p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\cr p_0\end{pmatrix}=\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\cr -q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.`$ | MD.Ch01.harmonicPhaseFlow，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.harmonicPhaseFlow; MD.Ch01.harmonicPhaseFlow\_solution | 保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.harmonicPhaseFlow; MD.Ch01.harmonicPhaseFlow\_solution | 保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。 |

[EXTRA] [EXTRA] 19号：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。

### 6. 审计结论

19号本地签名预审：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。

网站：网站PASS（EAUDIT复审）。
harmonicPhaseFlow 的两个分量与原式一致，n维共同频率推广合法。总函数本身允许Ω=0，但 harmonicPhaseFlow\_solution 明确 hΩ:Ω≠0，结论含初值及单位质量、力 -(Ω²)q 的全时间真实积分曲线；没有声称零频总化式仍满足自由粒子方程。全部 [EXTRA] 已兑现。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1152；MD.Ch01.harmonicPhaseFlow。

## 1. MD-1.5.1-SpectralSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> If $`\boldsymbol A`$ has a basis of eigenvectors $`\boldsymbol\eta_i`$, $`i=1,\ldots,m`$, with corresponding eigenvalues $`\lambda_1,\lambda_2,\ldots,\lambda_m`$, then we may write the solution at time $`t`$ as

$$
\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i
$$


> where the coefficients $`c_i`$ are obtained by solving the equation

$$
\boldsymbol z(t_0)\equiv \boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem spectralsolution :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E] {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ),
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i := by
  exact @MolecularDynamics.complexExponentialFlow_eigenbasis
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.spectralsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i`$；$`\boldsymbol z(t_0)=\boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.`$ | MD.Ch01.spectralsolution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。 | [EXTRA] |

[EXTRA] 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意完备复赋范空间、有穷索引全基 b，A复连续线性、各基向量对应复特征值ν。有限基保证有限维；没有偷换实谱。公式对所有实elapsed time t和初值z，以b.repr z为系数，给复算子流的谱展开。将t实例化为目标时间减t₀即可得到原式；基坐标本身满足初值展开，省去显式t₀是时间平移的等价参数化。complexExponentialFlow 经 restrictScalars ℝ 的算子指数仍是原复线性系统的真实流。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1168；MD.Ch01.spectralsolution。

## 1. MD-1.5.1-BasisCoefficients · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> (ii) with our assumption that the $`\{\boldsymbol\eta_i\}`$ form a basis, the calculation of the coefficients is always possible, since the matrix $`\boldsymbol X`$ whose columns are the eigenvectors will be invertible, that is, the coefficients $`c_i`$ can be enumerated as the components of a vector $`\boldsymbol c`$ which satisfies the square linear system

$$
\boldsymbol\xi=\boldsymbol X\boldsymbol c.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  exact ⟨basisColumnMatrix_isUnit b, basisColumnMatrix_mulVec_repr b z,
    basisColumnMatrix_inverse_coefficients b z⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.basis\_coefficients；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol\xi=\boldsymbol X\boldsymbol c.`$ | MD.Ch01.basis\_coefficients，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | RCLike域包含实/复两种；真实有限基。 | [EXTRA] |

[EXTRA] RCLike域包含实/复两种；真实有限基。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意m、RCLike域、EuclideanSpace 的完整 Fin m 基。basisColumnMatrix i j=b j i 确实以基向量作列；结论同时给矩阵可逆、X(b.repr z)=z以及X⁻¹z=b.repr z，包含可计算坐标及其唯一性依据，实复均覆盖。不要求特征向量性质是此线性代数子命题的合理推广。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1180；MD.Ch01.basis\_coefficients。

## 1. MD-1.5.1-MatrixExponentialSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> An alternative expression for the solution is in terms of the exponential of the matrix $`\boldsymbol A`$ scaled by time,

$$
\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem matrixexponentialsolution :
  ∀ {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z),
    γ = fun t => matrixExponentialFlow A (t - t₀) z := by
  exact @MolecularDynamics.matrixExponentialFlow_unique
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.matrixexponentialsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.`$ | MD.Ch01.matrixexponentialsolution，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意实m×m矩阵A、初值z、实t₀及全时间γ；hγ给真实导数γ′=Aγ，hinit给初值。结论是整个函数等于t↦matrixExponentialFlow A(t-t₀)z。依摘录展开为 exp((t-t₀)•A的连续算子表示)作用于z；有限维矩阵和连续线性算子代数同构保存指数，确为原式e^{A(t-t₀)}z。无对角化或实谱额外假设；本条是任意已给解的表示/唯一性，不单独新增存在结论。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1192；MD.Ch01.matrixexponentialsolution。

## 1. MD-1.5.1-MatrixExpSeries · unnumbered_claim · 印刷p.27–28 / PDFp.50–51

### 2. 原文陈述

> Alternatively, we may think of $`\exp(\boldsymbol A)`$ as the sum of the exponential series

$$
e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots
$$


> although this is seldom the most efficient method to compute it (this series converges for all matrices $`\boldsymbol A`$, and so in fact the exponential expression for the solution of the linear system is well defined even in the absence of a full set of eigenvectors).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem matrix_exp_series {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A) := by
  exact MolecularDynamics.Chapter01Review.matrixExponentialSeries_hasSum A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.matrix\_exp\_series；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots`$ | MD.Ch01.matrix\_exp\_series，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1204；MD.Ch01.matrix\_exp\_series。

## 1. MD-1.5.2-FirstIntegral · definition · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Another term for constant of motion is first integral. In general, if we have a dynamical system $`\dot{\boldsymbol z}=f(\boldsymbol z)`$, a first integral is a smooth function $`I(\boldsymbol z)`$ which is constant along solutions, for all values of the initial condition.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.smoothFirstIntegral；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
smoothFirstIntegral 的对象是有限维实欧氏空间上的向量场 f、区域 Q 和实值 I；结论同时要求 Q 上 C∞ 及 IsFirstIntegralOn。后者遍历所有开放时间区间、所有留在 Q 中并满足真实 HasDerivAt 的解，再量化任意两时刻，准确表达所有初值解上的常性，不偷加全局存在。Q 是原文定义的区域化参数；取 univ 即全空间版本。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1212；MD.Ch01.smoothFirstIntegral。

## 1. MD-1.5.2-FirstIntegralCriterion · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Since this should hold everywhere, the condition for $`I`$ to be a first integral is that $`\nabla I\cdot f\equiv0`$.

### 3. 原文证明

> Let $`\boldsymbol z(t):t\in\mathbb R`$ be a solution, then

$$
I(\boldsymbol z(t))\equiv I(\boldsymbol z(0))\Rightarrow0\equiv\frac{\mathrm d}{\mathrm dt}I(\boldsymbol z(t))=\nabla I(\boldsymbol z(t))\cdot\dot{\boldsymbol z}(t)=\nabla I(\boldsymbol z(t))\cdot f(\boldsymbol z(t)).
$$


按渲染原页逐字转录原文论证。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem firstintegralcriterion :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x),
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0 := by
  exact @MolecularDynamics.isFirstIntegralOn_iff_differential
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.firstintegralcriterion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral\_gradient\_criterion。 | [EXTRA] |

[EXTRA] 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral\_gradient\_criterion。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
对任意完备实赋范空间 E，开放 Q、Q 上局部 C¹ 向量场和可微 J，给出第一积分与每点 dJ(f)=0 的双向等价。完备性、局部 C¹ 和开放域提供从每个初值出发的局部解，从而必要方向不因缺乏解而真空成立；充分方向由链式法则及区间连通性成立。以连续线性微分替代梯度内积是等价且更一般的表达，未把梯度相等式当作额外结论。原文 smooth 类的判据在更弱可微类中仍成立。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1219；MD.Ch01.firstintegralcriterion。

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

## 1. MD-1.5.3-EquilibriumLinearization · unnumbered_claim · 印刷p.31 / PDFp.54

### 2. 原文陈述

> We assume that $`f`$ is continuously differentiable in the vicinity of the equilibrium point $`\boldsymbol z^*`$ and make use of the fact that $`f(\boldsymbol z)\approx f(\boldsymbol z^*)+f'(\boldsymbol z^*)(\boldsymbol z-\boldsymbol z^*)`$ for $`\|\boldsymbol z-\boldsymbol z^*\|`$ sufficiently small. Since $`f(\boldsymbol z^*)=0`$ we have, defining $`\delta\boldsymbol z:=\boldsymbol z-\boldsymbol z^*`$,

$$
\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}\approx\boldsymbol A\delta\boldsymbol z,\qquad\boldsymbol A=f'(\boldsymbol z^*).
$$


> The symbol $`\approx`$ is not very precise. In general, the approximation of solutions is only local in time meaning that solutions of the nonlinear system and the linear approximation may diverge. We refer to the system

$$
\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}=f'(\boldsymbol z^*)\delta\boldsymbol z
$$


> as the linearization of the system (1.6) around $`\boldsymbol z^*`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem equilibriumlinearization :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0),
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h) := by
  exact @MolecularDynamics.equilibrium_linearized_IVP
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.equilibriumlinearization；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\mathrm d\delta\boldsymbol z}{\mathrm dt}=\boldsymbol A\delta\boldsymbol z,\qquad\boldsymbol A=f'(\boldsymbol z^*).`$ | MD.Ch01.equilibriumlinearization，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意实完备赋范空间（较原书有限维推广）、f在z₀处C¹、f(z₀)=0，以及任意初始扰动h₀和t₀。结论存在独立的线性曲线δ，δ(t₀)=h₀且δ′=Df(z₀)δ，并给 f(z₀+h)-Df(z₀)h=o(h)。heq使余项不用再减f(z₀)。没有把δ定义成任意非线性轨道减z₀，故Lean正确地区分一阶近似和线性化ODE。A阶段等号转录必须修正，不能据此给正确Lean判FAIL。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1613；MD.Ch01.equilibriumlinearization。

## 1. MD-1.5.3-Hyperbolic · definition · 印刷p.31–32 / PDFp.54–55

### 2. 原文陈述

> In case the equilibrium point is hyperbolic, meaning that the real parts of the eigenvalues of $`\boldsymbol A=f'(\boldsymbol z^*)`$ are nonzero,

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hyperbolic；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1625；MD.Ch01.hyperbolic。

## 1. MD-1.5.3-HartmanGrobmanLiteral · unnumbered_claim · 印刷p.31–32 / PDFp.54–55

### 2. 原文陈述

> then one can infer that the solutions of the nonlinear and linear systems are in fact topologically conjugate: if $`\boldsymbol z`$ is the solution of the nonlinear system and $`\delta\boldsymbol z`$ is the solution of the linear system, then there is a smooth, invertible map $`\boldsymbol\Phi`$ of $`\mathbb R^m`$ defined in a neighborhood of the origin such that

$$
\boldsymbol z(t)=\boldsymbol z^*+\boldsymbol\Phi(\delta\boldsymbol z(t)).
$$


> This is referred to as the Hartman-Grobman theorem (for more discussion, see [177], where this result is referred to as the “Linearization Theorem”; a proof may be found in [362]).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hartmangrobmanliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry

/-- 修正版，对应原文 MD-1.5.3-HartmanGrobmanLiteral，改动：C∞可逆坐标替换改为连续互逆局部同胚；保留零点、邻域与留域期间共轭公式。 -/
theorem hartmangrobmanliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContinuousOn φ U ∧ ContinuousOn ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hartmangrobmanliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\boldsymbol z(t)=\boldsymbol z^*+\boldsymbol\Phi(\delta\boldsymbol z(t)).`$ | MD.Ch01.hartmangrobmanliteral，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。 | [EXTRA] |

[EXTRA] C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。

### 6. 审计结论

C¹双曲系统的一般Hartman–Grobman结论为拓扑共轭，不保证C∞线性化。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
hyperbolic定义用实x/y表示复特征向量，(x≠0∨y≠0)及a≠0正确排除纯虚谱。isFlowOf只含初值和真实ODE，C¹提供唯一性；全局流是已披露的较强技术资格。主 literal：忠实性 PASS，开邻域U/V均含0、φ(0)=0、双向映射和逆关系，φ/ψ均C∞；在整个连接0至t的线性轨道留U期间给F(t,z+φx)=z+φ(e^{tA}x)。其数学真值有原书疑误。_corrected：PASS，完全相同量词、留域条件和公式，仅把坐标正则性改为连续互逆，正确为局部拓扑共轭。没有以“某一对解”代替共同坐标映射。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1633；MD.Ch01.hartmangrobmanliteral。

## 1. MD-1.5.3-LyapunovStability · definition · 印刷p.32 / PDFp.55

### 2. 原文陈述

> Let $`\boldsymbol z^*`$ be an equilibrium point. We say that $`\boldsymbol z^*`$ is stable (“in the sense of Lyapunov”) if, for all $`\epsilon`$, there exists $`\delta`$ such that, for all $`\boldsymbol z_0`$ such that $`\|\boldsymbol z_0-\boldsymbol z^*\|\lt \delta`$,

$$
\sup_{t\geq0}\|\mathcal F_t(\boldsymbol z_0)-\boldsymbol z^*\|\lt \epsilon.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovStable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, ‖x-z‖ < δ →
    BddAbove (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) ∧
    sSup (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) < ε
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lyapunovStable；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\sup_{t\geq0}\Vert \mathcal F_t(\boldsymbol z_0)-\boldsymbol z^*\Vert \lt \epsilon.`$ | MD.Ch01.lyapunovStable，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。 | [EXTRA] |

[EXTRA] ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1664；MD.Ch01.lyapunovStable。

## 1. MD-1.5.3-HyperbolicStabilityTransfer · unnumbered_claim · 印刷p.32 / PDFp.55

### 2. 原文陈述

> The Hartman-Grobman theorem clearly implies that the stability of a given hyperbolic equilibrium point $`\boldsymbol z^*`$ of a nonlinear system can be inferred from the stability of the origin for the linearization of the system around $`\boldsymbol z^*`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hyperbolicstabilitytransfer :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry

/-- 修正版，对应原文 MD-1.5.3-HyperbolicStabilityTransfer，改动：显式独立登记以拓扑共轭为依据的稳定性转移，不调用光滑literal。 -/
theorem hyperbolicstabilitytransfer_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hyperbolicstabilitytransfer；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。 | [EXTRA] |

[EXTRA] C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。

### 6. 审计结论

结论本身是标准推论，但原证明链不能依赖原书过强的光滑共轭。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：网站PASS（EAUDIT复审）。
两条声明主名和\_corrected签名相同，均PASS。量化所有n、C¹ f、平衡z、双曲Df(z)、真实全局流F；结论为非线性平衡与线性指数流原点稳定性的双向等价。stable展开为每ε>0选δ>0，对每个近初值存在该轨道统一B<ε，全部t≥0距离≤B；这准确实现书面严格sup<ε，亦与通常Lyapunov稳定等价（缩小ε可得统一余量）。局部同胚及首次离域论证足以转移稳定性，无需错误的C∞共轭。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1673；MD.Ch01.hyperbolicstabilitytransfer。

## 1. MD-1.5.3-HamiltonEquilibrium · unnumbered_claim · 印刷p.32 / PDFp.55

### 2. 原文陈述

> Observe that an equilibrium point $`\boldsymbol z^*=(\boldsymbol q^*,\boldsymbol p^*)`$ of a Hamiltonian system in “kinetic plus potential” form

$$
H(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)
$$


> will always have $`\boldsymbol p^*=0`$ and $`\nabla U(\boldsymbol q^*)=0`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamilton_equilibrium {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q)
    (heq : gradient (fun v => variableMassHamiltonian (fun _ => M) U q v) p = 0 ∧
      gradient (fun x => variableMassHamiltonian (fun _ => M) U x p) q = 0) :
    p = 0 ∧ gradient U q = 0 := by
  have hg := hamilton_fixed_mass M U q p hM hU
  have hv : matrixAction M⁻¹ p = 0 := hg.1.gradient.symm.trans heq.1
  have hc : M⁻¹.mulVec (WithLp.ofLp p) = M⁻¹.mulVec 0 := by
    have hh := congrArg WithLp.ofLp hv
    simpa [matrixAction] using hh
  have hinj := Matrix.mulVec_injective_iff_isUnit.mpr hM.inv.isUnit
  have hp : p = 0 := by
    have hh := hinj hc
    simpa using hh
  exact ⟨hp,hg.2.gradient.symm.trans heq.2⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamilton\_equilibrium；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`H(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)`$ | MD.Ch01.hamilton\_equilibrium，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。 | [EXTRA] |

[EXTRA] 一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1692；MD.Ch01.hamilton\_equilibrium。

## 1. MD-1.5.3-StrongLocalMinimum · definition · 印刷p.32 / PDFp.55

### 2. 原文陈述

> We say that $`\boldsymbol q^*`$ is a strong local minimum of the potential if there exists $`\epsilon\gt 0`$ such that

$$
0\lt \|\boldsymbol q-\boldsymbol q^*\|\lt \epsilon\Rightarrow U(\boldsymbol q)\gt U(\boldsymbol q^*).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def strongLocalMinimum {n : ℕ} (U : PotentialEnergy n) (qstar : Position n) : Prop :=
  ∃ ε > 0, ∀ q, 0 < ‖q-qstar‖ → ‖q-qstar‖ < ε → U qstar < U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.strongLocalMinimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`0\lt \Vert \boldsymbol q-\boldsymbol q^*\Vert \lt \epsilon\Rightarrow U(\boldsymbol q)\gt U(\boldsymbol q^*).`$ | MD.Ch01.strongLocalMinimum，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1713；MD.Ch01.strongLocalMinimum。

## 1. MD-1.5.3-LinearizedHamiltonian · definition · 印刷p.32 / PDFp.55

### 2. 原文陈述

> If the potential is $`C^2`$, the linearized version of this system has “kinetic plus potential” form with Hamiltonian

$$
\widetilde H=\frac{\delta\boldsymbol p^T\boldsymbol M^{-1}\delta\boldsymbol p}2+\frac{\delta\boldsymbol q^T U''(\boldsymbol q^*)\delta\boldsymbol q}2.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def linearizedHamiltonian {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (δq δp : Position n) : ℝ :=
  inner ℝ δp (matrixAction M⁻¹ δp)/2 + inner ℝ δq (fderiv ℝ (gradient U) qstar δq)/2

theorem linearizedHamiltonian_field {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hM : M.PosDef)
    (hU : ContDiff ℝ 2 U) (heq : gradient U qstar = 0) :
    ∀ δz : PhaseSpace n,
      fderiv ℝ (symplecticGradient (fun z : PhaseSpace n =>
        inner ℝ z.2 (matrixAction M⁻¹ z.2)/2 + U z.1)) (qstar,0) δz =
      symplecticGradient (fun z : PhaseSpace n => linearizedHamiltonian M U qstar z.1 z.2) δz := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.linearizedHamiltonian；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\widetilde H=\frac{\delta\boldsymbol p^T\boldsymbol M^{-1}\delta\boldsymbol p}2+\frac{\delta\boldsymbol q^T U''(\boldsymbol q^*)\delta\boldsymbol q}2.`$ | MD.Ch01.linearizedHamiltonian，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedHamiltonian; MD.Ch01.linearizedHamiltonian\_field | 保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedHamiltonian; MD.Ch01.linearizedHamiltonian\_field | 保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。 |

[EXTRA] [EXTRA] 19号：保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。

### 6. 审计结论

19号本地签名预审：保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。

网站：网站PASS（EAUDIT复审）。
linearizedHamiltonian定义精确给动量M⁻¹二次型加位置Hessian二次型，各1/2，M为常矩阵。单独定义使用总化fderiv，但field声明同时加M.PosDef、U全域C²及∇U(q*)=0，故Hessian为真实自伴Hessian。field对每个δz要求原Hamilton向量场在(q*,0)的Fréchet导数作用于δz等于该二次Hamilton向量场；这兑现“linearized version”的完整动力学对应，非仅同名函数。C²/正质量及平衡背景充分，未漏负号或交换相空间分量。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1720；MD.Ch01.linearizedHamiltonian。

## 1. MD-1.5.3-PositiveHessianQuadratic · unnumbered_claim · 印刷p.33 / PDFp.56

### 2. 原文陈述

> A condition for this system to have a strong local minimum at $`\delta\boldsymbol p=0`$, $`\delta\boldsymbol q=0`$ is that the Hessian matrix $`U''(\boldsymbol q^*)`$ be positive definite.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positivehessianquadratic :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    IsStrictPotentialMin (fun z : PhaseSpace n =>
      inner ℝ z.2 (M⁻¹.toEuclideanLin z.2)/2 + inner ℝ z.1 (K.toEuclideanLin z.1)/2) 0 := by
  intro n M K hM hK
  have hn (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosSemidef) (v : Position n) :
      0 ≤ inner ℝ v (A.toEuclideanLin v) := by
    change 0 ≤ inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    simpa using ha.dotProduct_mulVec_nonneg (x := WithLp.ofLp v)
  have hp (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosDef) (v : Position n) (hv : v ≠ 0) :
      0 < inner ℝ v (A.toEuclideanLin v) := by
    change 0 < inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    have hv' : WithLp.ofLp v ≠ 0 := by simpa using hv
    simpa using ha.dotProduct_mulVec_pos hv'
  refine ⟨1,by norm_num,?_⟩
  intro z hz _
  have hzn : z ≠ 0 := dist_pos.mp hz
  have hq := hn K hK.posSemidef z.1
  have hpp := hn M⁻¹ hM.inv.posSemidef z.2
  have hz0 : inner ℝ ((0:PhaseSpace n).2) (M⁻¹.toEuclideanLin (0:PhaseSpace n).2)/2 +
      inner ℝ ((0:PhaseSpace n).1) (K.toEuclideanLin (0:PhaseSpace n).1)/2 = 0 := by
    change inner ℝ (0:Position n) (M⁻¹.toEuclideanLin 0)/2 + inner ℝ (0:Position n) (K.toEuclideanLin 0)/2 = 0
    simp
  dsimp only
  rw [hz0]
  by_cases hqz : z.1 = 0
  · have hpz : z.2 ≠ 0 := by
      intro h; exact hzn (Prod.ext hqz h)
    nlinarith [hp M⁻¹ hM.inv z.2 hpz]
  · nlinarith [hp K hK z.1 hqz]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positivehessianquadratic；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | M正定，K=U″对称正定；一般矩阵。 | [EXTRA] |

[EXTRA] M正定，K=U″对称正定；一般矩阵。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
任意n、一般实矩阵M/K，M.PosDef和K.PosDef包含实对称性。结论IsStrictPotentialMin展开为某R>0内所有非零相点的二次Hamilton值严格高于原点；动量项M⁻¹及位置项K、1/2系数均正确。至少一个分量非零给严格正，故实际上全局严格最小，局部结论充分；零维结论真且无非零点。K是Hessian值的抽象替代，命题是充分条件，不误称必要条件，也不把“strong”误读为统一强凸常数。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1737；MD.Ch01.positivehessianquadratic。

## 1. MD-1.5.3-PositiveHessianMinimum · unnumbered_claim · 印刷p.33 / PDFp.56

### 2. 原文陈述

> In case the eigenvalues of $`U''(\boldsymbol q^*)`$ are all distinct and positive, then the strong local minimum property will also follow for $`\boldsymbol q^*`$ in relation to the original potential.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem positive_hessian_minimum {n : ℕ} (U : PotentialEnergy n) (q : Position n)
    (hU : ContDiff ℝ 2 U) (hq : gradient U q = 0)
    (B : Module.Basis (Fin n) ℝ (Position n)) (freq : Fin n → ℝ)
    (hdistinct : Function.Injective freq) (hpos : ∀ i, 0 < freq i)
    (heig : ∀ i, fderiv ℝ (gradient U) q (B i) = freq i • B i) :
    IsStrictPotentialMin U q := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.positive\_hessian\_minimum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| distinct positive eigenvalues | Function.Injective freq；∀i,0<freq i；实特征基完整heig | 一致 |
| 势的严格局部极小 | IsStrictPotentialMin U q | 一致；未替换为纯二次型 |
| 原文未显式量化的技术资格 | C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。 | [EXTRA] |

[EXTRA] C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。

### 6. 审计结论

保留distinct及positive全部谱前提、平衡点与C2背景；不把distinct删掉。实Hessian对称确保可取实特征基。

网站：网站PASS（EAUDIT复审）。
任意n、实势U全域C²、平衡∇U(q)=0，实全基B、实特征值freq、Injective freq和每项>0，并要求Df(gradient U)q作用于B i等于freq i倍基向量。全部distinct positive eigenvalues经完整基覆盖；C²保证Hessian自伴，虽未给正交基也可由正谱推出正定。IsStrictPotentialMin恰为原书穿孔邻域严格最小，C²及平衡资格来自同节且已披露。特征值互异虽不必要但忠实保留，没有静默削弱或把正频率替代平方特征值。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1774；MD.Ch01.positive\_hessian\_minimum。

## 1. MD-1.6-UniformPairLattice · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> Let us suppose we have a uniform pair potential $`\varphi`$ and define the total potential energy of a system of N atoms by

$$
U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi(|x_i-x_j|).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def latticePairPotential {N : ℕ} (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i, ∑ j ∈ Finset.Ioi i, φ |x i-x j|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.latticePairPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi(\Vert x_i-x_j\Vert ).`$ | MD.Ch01.latticePairPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1790；MD.Ch01.latticePairPotential。

## 1. MD-1.6-UnorderedPairCount · unnumbered_claim · 印刷p.33 / PDFp.56

### 2. 原文陈述

> The computation of the energy requires $`N(N-1)/2`$ separate calculations, which could be very expensive if N is large.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem unorderedpaircount :
  ∀ N : ℕ, (Finset.univ.filter (fun p : Fin N × Fin N => p.1 < p.2)).card = N*(N-1)/2 := by
  intro N
  simpa [Nat.choose_two_right] using Finset.card_product_filter_lt (s := (Finset.univ : Finset (Fin N)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.unorderedpaircount；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1797；MD.Ch01.unorderedpaircount。

## 1. MD-1.6-NearestNeighbor · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> We can reduce this by assuming only nearest neighbor forces, which means the energy becomes

$$
U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def nearestNeighborModel {N : ℕ} (φ : ℝ → ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ |x i.succ-x i.castSucc|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nearestNeighborModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(\Vert x_{i+1}-x_i\Vert ).`$ | MD.Ch01.nearestNeighborModel，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1806；MD.Ch01.nearestNeighborModel。

## 1. MD-1.6-WalledChain · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> In order to keep such a system bounded we might then introduce walls at the ends of the chain, e.g. by adding confining potentials to $`U`$:

$$
U(x_1,x_2,\ldots,x_N)=\varphi_c(|x_1|)+\varphi_c(|L-x_N|)+\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|).\tag{1.7}
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def walledChainModel {N : ℕ} (φ φc : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  φc |x 0| + φc |L-x (Fin.last N)| + nearestNeighborModel φ x
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.walledChainModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U(x_1,x_2,\ldots,x_N)=\varphi_c(\Vert x_1\Vert )+\varphi_c(\Vert L-x_N\Vert )+\sum_{i=1}^{N-1}\varphi(\Vert x_{i+1}-x_i\Vert ).\quad\text{(1.7)}`$ | MD.Ch01.walledChainModel，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1813；MD.Ch01.walledChainModel。

## 1. MD-1.6-PeriodicChain · definition · 印刷p.33 / PDFp.56

### 2. 原文陈述

> Alternatively one could restrict to a bounded domain by use of periodic boundary conditions, introducing the potential energy:

$$
U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(|x_{i+1}-x_i|)+\varphi(|L+x_1-x_N|).\tag{1.8}
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicChainModel {N : ℕ} (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  nearestNeighborModel φ x + φ |L+x 0-x (Fin.last N)|
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicChainModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U(x_1,x_2,\ldots,x_N)=\sum_{i=1}^{N-1}\varphi(\Vert x_{i+1}-x_i\Vert )+\varphi(\Vert L+x_1-x_N\Vert ).\quad\text{(1.8)}`$ | MD.Ch01.periodicChainModel，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1820；MD.Ch01.periodicChainModel。

## 1. MD-1.6-PeriodicBoundary · definition · 印刷p.34 / PDFp.57

### 2. 原文陈述

> If a particle moves to the right of $`x=L`$ we simply shift its position to $`x-L`$; likewise any particle exiting to the left of $`x=0`$ has its position shifted to $`x+L`$ (see Fig. 1.15).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicPositionEquivalent (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L

def periodicBoundary (L : {x : ℝ // 0 < x}) (x y : ℝ) : Prop :=
  y = if L.val < x then x-L.val else if x < 0 then x+L.val else x
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicBoundary；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodicPositionEquivalent; MD.Ch01.periodicBoundary | 原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodicPositionEquivalent; MD.Ch01.periodicBoundary | 原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。 |

[EXTRA] [EXTRA] 19号：原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。

### 6. 审计结论

19号本地签名预审：原等价关系另名辅助；主定义逐字表达正盒长下右越界减L、左越界加L、否则不变的一步更新，不伪称任意大越界一步即可落盒。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.periodicBoundary：PASS。对任意 L>0 及 x,y∈ℝ，结论恰为 y=(x−L 若 x>L；x+L 若 x<0；否则 x)。当 x=0 或 x=L 时保持原值，与 moves to the right / exiting to the left 的严格越界相符。它不声称任意大越界经一步后已落入盒内。MD.Ch01.periodicPositionEquivalent：PASS，∃k∈ℤ, y=x+kL 是独立辅助关系；L=0 或 L<0 时该关系仍有定义，但主更新明确只接受正 L。[EXTRA] 对一步更新和辅助等价关系的区分准确。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1829；MD.Ch01.periodicBoundary。

## 1. MD-1.6-PeriodicTranslationMomentum · unnumbered_claim · 印刷p.34 / PDFp.57

### 2. 原文陈述

> Periodic boundary conditions allow us to preserve Newton’s third law, the translational symmetry, and thus the conservation of momentum.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem periodic_translation_momentum :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ),
    let U := boxPeriodicNearestNeighborPotentialEnergy φ L
    (∀ q c, U (fun i => q i+c) = U q) ∧
    (∀ q, DifferentiableAt ℝ U q → fderiv ℝ U q (fun _ => 1) = 0) ∧
    ∀ (m : Fin (N+1) → ℝ) (q v : ℝ → Fin (N+1) → ℝ) (I : Set ℝ),
      IsOpen I → IsPreconnected I → (∀ i, 0 < m i) →
      (∀ t ∈ I, DifferentiableAt ℝ U (q t)) →
      (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t ∧
        HasDerivAt (fun s => m i*v s i) (-fderiv ℝ U (q t) (Pi.single i 1)) t) →
      (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i*v s i) 0 t) ∧
      ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i*v a i) = ∑ i, m i*v b i := by
  sorry

/-- Both endpoint forces of each norm-based periodic bond, including the closing bond. -/
def periodicBondEnergy (φ : ℝ → ℝ) (L : ℝ) (x y : ℝ) (closing : Bool) : ℝ :=
  φ ‖y-x + if closing then L else 0‖

theorem periodic_translation_third_law (φ : ℝ → ℝ) (L x y : ℝ) (closing : Bool)
    (hφ : DifferentiableAt ℝ (fun s => φ ‖s‖) (y-x + if closing then L else 0)) :
    -deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -(-deriv (fun u => periodicBondEnergy φ L x u closing) y) := by
  have hx := hφ.hasDerivAt.scomp x
    (((hasDerivAt_const x y).sub (hasDerivAt_id x)).add_const (if closing then L else 0))
  have hy := hφ.hasDerivAt.scomp y
    (((hasDerivAt_id y).sub_const x).add_const (if closing then L else 0))
  have hx' : deriv (fun u => periodicBondEnergy φ L u y closing) x =
      -deriv (fun s => φ ‖s‖) (y-x + if closing then L else 0) := by
    simpa [periodicBondEnergy, Function.comp_def] using hx.deriv
  have hy' : deriv (fun u => periodicBondEnergy φ L x u closing) y =
      deriv (fun s => φ ‖s‖) (y-x + if closing then L else 0) := by
    simpa [periodicBondEnergy, Function.comp_def] using hy.deriv
  rw [hx',hy']
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodic\_translation\_momentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 平移不变及方向导数为零 | ∀q c,U(q+c)=U q；fderiv U q (fun _=>1)=0 | 一致 |
| 真实Newton系统总动量守恒 | 有限和HasDerivAt 0及∀a b∈I动量相等 | 一致 |
| 原文未显式量化的技术资格 | 一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodic\_translation\_momentum; MD.Ch01.periodicBondEnergy; MD.Ch01.periodic\_translation\_third\_law | 完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.periodic\_translation\_momentum; MD.Ch01.periodicBondEnergy; MD.Ch01.periodic\_translation\_third\_law | 完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。 |
| 21号网站建议修复 | MD.Ch01.periodic\_translation\_momentum | 键能量补范数，第三定律改对ψ=φ∘\|·\|在有向差处可微；平移/动量主定理逐字未改。 |

[EXTRA] 一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。；[EXTRA] 19号：完整保留平移/方向导数/动量结论，补真实每条周期键两端负偏导相反的Newton第三定律（含闭合键），依赖包展开真实周期能量。；[EXTRA] 键能量补范数，第三定律改对ψ=φ∘|·|在有向差处可微；平移/动量主定理逐字未改。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：键能量补范数，第三定律改对ψ=φ∘|·|在有向差处可微；平移/动量主定理逐字未改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.periodic\_translation\_momentum：PASS（签名语义）。N∈ℕ，系统有 N+1 个实坐标；φ:ℝ→ℝ 与 L∈ℝ 任意。真实 U 的 N 个相邻键及闭合键只依赖坐标差，故同时平移不变；可微时沿全1向量的导数为0。对正质量 m、轨迹 q,v、开且预连通的 I，给出的势可微性和逐粒子速度/动量 Newton 导数足以推出总动量导数0及任意 a,b∈I 的总动量相等；全部结论均保留。MD.Ch01.periodicBondEnergy：FAIL（与实际依赖的对应关系），其定义是有向差的 φ 值，没有真实 U 中的范数。MD.Ch01.periodic\_translation\_third\_law：作为这个有向辅助能量的两端力相反定理，签名本身 PASS；hφ 也恰好是有向参数处的可微性。然而，它未针对实际 U 的 φ∘|·| 键作陈述。没有 φ 偶性、键方向/位置资格或替换势的桥接，不能将其认作实际周期链中每条键的第三定律。[EXTRA] 中“真实每条周期键”“含闭合键”的覆盖说法因此不成立。总 verdict=FAIL 源于模型对应错误，不源于 sorry。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1837；MD.Ch01.periodic\_translation\_momentum。

## 1. MD-1.6-RegularLattice · definition · 印刷p.34 / PDFp.57

### 2. 原文陈述

> On the line, we think of a (finite) lattice as a sequence of discrete points separated by a fixed distance $`\Delta x`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.regularLattice；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1875；MD.Ch01.regularLattice。

## 1. MD-1.6-RegularLatticeMinimizerLiteral · unnumbered_claim · 印刷p.34 / PDFp.57

### 2. 原文陈述

> An obvious benefit of using periodic boundary conditions is that, with a uniform pair potential, the energy minimizers are points of a regular lattice; with confining potentials this is unlikely to be the case.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem regularlatticeminimizerliteral :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x := by
  sorry

/-- 修正版，对应原文 MD-1.6-RegularLatticeMinimizerLiteral，改动：改为一维周期有序粒子的正间距和L固定、严格凸最近邻势；Jensen给等间距最小且仅等间距等号。 -/
theorem regularlatticeminimizerliteral_corrected (N : ℕ) (φ : ℝ → ℝ)
    (L : ℝ) (hL : 0 < L) (hφ : StrictConvexOn ℝ (Ioi 0) φ) :
    let d := L / (N+1)
    ∀ gaps : Fin (N+1) → ℝ, (∀ i, 0 < gaps i) → (∑ i, gaps i) = L →
      (N+1 : ℝ) * φ d ≤ ∑ i, φ (gaps i) ∧
      ((∑ i, φ (gaps i)) = (N+1 : ℝ) * φ d ↔ ∀ i, gaps i = d) := by
  dsimp only
  intro gaps hg hs
  have hc : 0 < (N+1 : ℝ) := by positivity
  have hw : (∑ _ : Fin (N+1), (N+1 : ℝ)⁻¹) = 1 := by
    simp [Nat.cast_add, Nat.cast_one, hc.ne']
  have hm : (∑ i, (N+1 : ℝ)⁻¹ * gaps i) = L/(N+1) := by
    rw [← Finset.mul_sum,hs]
    ring
  have hv : (∑ i, (N+1 : ℝ)⁻¹ * φ (gaps i)) = (∑ i,φ (gaps i))/(N+1) := by
    rw [← Finset.mul_sum]
    ring
  have hpos : ∀ i ∈ (Finset.univ : Finset (Fin (N+1))), 0 < (N+1 : ℝ)⁻¹ :=
    fun _ _ => inv_pos.mpr hc
  have hmem : ∀ i ∈ (Finset.univ : Finset (Fin (N+1))), gaps i ∈ Ioi (0 : ℝ) :=
    fun i _ => hg i
  have hi := hφ.convexOn.map_sum_le (fun i hi => (hpos i hi).le) hw hmem
  have he := hφ.map_sum_eq_iff hpos hw hmem
  simp only [smul_eq_mul] at hi he
  rw [hm,hv] at hi he
  refine ⟨?_,?_⟩
  · simpa [mul_comm] using (le_div_iff₀ hc).mp hi
  · constructor
    · intro hh
      have hh' : φ (L/(N+1)) = (∑ i,φ (gaps i))/(N+1) := by
        apply (eq_div_iff hc.ne').mpr
        nlinarith
      exact fun i => he.mp hh' i (Finset.mem_univ i)
    · intro hh
      have hh' : φ (L/(N+1)) = (∑ i,φ (gaps i))/(N+1) :=
        he.mpr (by simpa using hh)
      have := (eq_div_iff hc.ne').mp hh'
      nlinarith

theorem regularlatticeminimizerliteral_counterexample :
    (∀ x y : Fin 2 → ℝ,
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 x ≤
      boxPeriodicNearestNeighborPotentialEnergy (fun _ => 0) 1 y) ∧
    ¬ ∃ a : ℝ, regularLattice a (1/2) (fun _ : Fin 2 => 0) := by
  constructor
  · intro x y; simp [boxPeriodicNearestNeighborPotentialEnergy,nearestNeighborPotentialEnergy]
  · rintro ⟨a,ha⟩
    have h0 := ha.2 (0 : Fin 2)
    have h1 := ha.2 (1 : Fin 2)
    norm_num at h0 h1
    linarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.regularlatticeminimizerliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

任意uniform pair potential不保证晶格最小；还缺排序、盒域和势的凸性等资格。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
MD.Ch01.regularlatticeminimizerliteral：字面意旨保留，但数学疑误 NEEDS\_HUMAN。它对任意 N、任意 φ、L>0 及所有实配置 x，在全空间全局最小的前提下断言 ∃a, xᵢ=a+iL/(N+1)，其中 regularLattice 还要求正间距。该签名确实保留了原书无势资格的极强断言，不应因已知反例或 sorry 将“忠实版”判作实现 FAIL。须注意 Lean 进一步选择了周期最近邻、固定标号递增和固定环长间距的解释，不能据此宣称已经处理任意标号重排或任意多维 pair potential。MD.Ch01.regularlatticeminimizerliteral\_corrected：PASS。φ 在 (0,∞) 严格凸、L>0、每个 gapsᵢ>0 且 ∑gapsᵢ=L，使 d=L/(N+1)>0。结论是 (N+1)φ(d)≤∑φ(gapsᵢ)，且等号当且仅当全部 gapsᵢ=d；这是有限等权严格 Jensen 的准确陈述，包括 N=0 的单项情形。它是明确改变问题域的合理勘误，不是任意原始配置的无条件结论。MD.Ch01.regularlatticeminimizerliteral\_counterexample：PASS。零势下所有 Fin 2 配置能量均为0；常零配置不可能满足间距1/2的有标号 regularLattice。[EXTRA] 为空不能被理解为原命题因此获得凸性或顺序条件。总判 NEEDS\_HUMAN，需人工确认原书的隐藏势与配置资格。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1882；MD.Ch01.regularlatticeminimizerliteral。

