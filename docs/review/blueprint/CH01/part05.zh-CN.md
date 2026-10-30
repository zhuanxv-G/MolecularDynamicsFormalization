[上一部分](part04.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

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

## 1. MD-1.6-PeriodicImages · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> periodic boundary conditions involve an extended potential energy of the form

$$
U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),
$$


> where $`k,l,m`$ run over $`-1,0,1`$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $`\boldsymbol v_i^T=(L\boldsymbol e_i^T,L\boldsymbol e_i^T,\ldots,L\boldsymbol e_i^T)`$, $`i=1,2,3`$, where $`\boldsymbol e_i`$ is the $`i`$th Euclidean basis vector in $`\mathbb R^3`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.periodicImageEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),`$ | MD.Ch01.periodicImageEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.periodicImageEnergy：对“将原页 v\_i 解释为其对应粒子三维块 L e\_i”的解释，签名 PASS。对任意自然数 N、实 L、所有二体项 φᵢⱼ 与三维配置 q，定义恰枚举27个位移和全部无序不同标签对 i<j，逐项计算 φᵢⱼ(qᵢ,qⱼ+L(k,l,m))。N=0 或1时空配对求和为0，忠实于印刷的 i<j；没有擅加 i=j 的自镜像，也没有擅加1/2。构造公式本身可推广到任意 L,q，物理盒长正且坐标位于盒内是书中背景，而非这一定义声称的额外定理。未解决之处是原页把 v\_i 定义为全配置重复块，和此处二体参数三维之间存在类型冲突；JSON 的“等价”说明只能给出一种修复解释，不能消除原书符号问题。因此总判 NEEDS\_HUMAN，而非声称已逐类型忠实形式化了原公式。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1947；MD.Ch01.periodicImageEnergy。

## 1. MD-1.6-MinimumImage · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> The minimum image convention states that, in computing the force, a given atom interacts only with the nearest replica of any other atom.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖

def minimumImageForce {N : ℕ} (L : ℝ) (q : Fin N → V3)
    (image : Fin N → Fin N → V3) (pairForce : Fin N → Fin N → V3 → V3 → V3)
    (force : Fin N → V3) : Prop :=
  0 < L ∧ (∀ i j, i ≠ j → minimumImage L (q i) (q j) (image i j)) ∧
    ∀ i, force i = ∑ j ∈ Finset.univ.erase i, pairForce i j (q i) (image i j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumImage；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.minimumImage; MD.Ch01.minimumImageForce | 最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.minimumImage; MD.Ch01.minimumImageForce | 最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。 |

[EXTRA] [EXTRA] 19号：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。

### 6. 审计结论

19号本地签名预审：最近像关系留作辅助；完整模型以L>0、不同原子标签及每对选中复制体唯一参与求力落实only限定（同距可任选）。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.minimumImage：PASS。L∈ℝ，q,r,image∈V3；存在 k∈ℤ³ 使 image=r+Lk，且对所有 l∈ℤ³ 有 ‖q−image‖≤‖q−(r+Ll)‖。最小性使用≤，允许距离并列；关系自身不含 L>0，但下述完整模型补足。MD.Ch01.minimumImageForce：PASS。对 N 个标签的位置 q、每对标签的选中像 image、二体力回调 pairForce 以及总力 force，要求0<L；对 i≠j 要求对应最小像关系；对每个 i 总力恰为 j≠i 上 pairForce(i,j,qᵢ,imageᵢⱼ) 的和。因此“other”不包括自标签，“only”通过每个其他标签只出现一个选中复制体落实。并未错误断言距离最小者在数学上唯一，也不将并列的所有像一起相加。pairForce 是输入的二体力，原句未给它另一个解析表达式。[EXTRA] 与这两层定义一致。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1956；MD.Ch01.minimumImage。

## 1. MD-1.6-RhombicLattice · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> In 2D, the typical geometry observed at low temperature is defined by a rhombic lattice with sides of fixed length $`n_x,n_y`$ and the angle between them ($`\theta`$), see Fig. 1.17.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}

def RhombicLatticeValidDomain (a b θ : ℝ) : Prop :=
  0 < a ∧ 0 < b ∧ Real.sin θ ≠ 0

def rhombicLatticeOnDomain (a b θ : ℝ) (_h : RhombicLatticeValidDomain a b θ) :
    Set (Position 2) := rhombicLattice a b θ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.rhombicLatticeOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.rhombicLatticeOnDomain | 一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。 |

[EXTRA] [EXTRA] 一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：一般整数生成集rhombicLattice保留为辅助；二维格入口增加a>0、b>0、sinθ≠0，不加a=b；下游六角格恒等式无须调整。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.rhombicLattice：FAIL（参数域/几何资格）。集合公式 x=k(a,0)+l(b cosθ,b sinθ)，k,l∈ℤ，方向、索引及二维实欧氏对象均正确；旋转/平移选定坐标本身不是问题。缺陷是 a,b,θ 无任何资格，不能保证两条边的长度为正或两个生成方向独立：行列式为 ab sinθ，可能为0。原文及图1.17描述的是二维格，而当前构造连秩0、秩1的退化集合也全部接收。[EXTRA] 为空，不能从“基向量”这个中文名称推入 Lean 中没有的线性无关性。作为一般整数生成集合的辅助定义它是合法的，但作为未加资格的二维 rhombic lattice 完整对应不足。没有把“低温典型”误审为必须额外证明的普遍低温定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1977；MD.Ch01.rhombicLatticeOnDomain。

