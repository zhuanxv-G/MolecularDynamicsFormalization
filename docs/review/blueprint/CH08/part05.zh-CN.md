[上一部分](part04.zh-CN.md) / [目录](../../CH08_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

## MD-8.8-AndersenCoordinates

印刷页 379–380 / PDF页 400–401。

### 1. 原文陈述

> $`q_i=V^{1/3}\bar q_i`$; $`\dot q_i=(1/3)V^{-2/3}\dot V\bar q_i+V^{1/3}\dot{\bar q}_i`$; $`\bar p_i=m_iV^{1/3}\dot q_i`$. (8.71),(8.72).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def andersenPosition (V : ℝ) (qbar : Vec n) : Vec n := volumeScale V • qbar
def andersenVelocity (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  ((1/3 : ℝ)*Real.rpow V (-2/3 : ℝ)*Vdot) • qbar+volumeScale V • vbar
def andersenMomentum (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  fun i ↦ m i*((1/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i+
    Real.rpow V (2/3 : ℝ)*vbar i)
theorem andersenPosition_derivative (V : ℝ → ℝ) (qbar : ℝ → Vec n)
    (t Vdot : ℝ) (vbar : Vec n) (hV : 0 < V t)
    (hdV : HasDerivAt V Vdot t) (hdq : HasDerivAt qbar vbar t) :
    HasDerivAt (fun s ↦ andersenPosition (V s) (qbar s))
      (andersenVelocity (V t) Vdot (qbar t) vbar) t := by
  sorry
theorem andersenMomentum_velocity (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) :
    andersenMomentum m V Vdot qbar vbar =
      fun i ↦ m i*volumeScale V*andersenVelocity V Vdot qbar vbar i := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 位置、速度、共轭动量的实际变换式与两个局部等式目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`V\gt 0`$用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页400–401。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.andersenPosition`：定义
- `MD.Ch08.andersenVelocity`：定义
- `MD.Ch08.andersenMomentum`：定义
- `MD.Ch08.andersenPosition_derivative`：未证；缺大型理论
- `MD.Ch08.andersenMomentum_velocity`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-AndersenKineticEnergy

印刷页 379 / PDF页 400。

### 1. 原文陈述

> After $`q=V^{1/3}\bar q`$, $`\bar K=\sum_i(m_i/2)[(1/9)V^{-4/3}\dot V^2\lvert\bar q_i\rvert^2+(2/3)V^{-1/3}\dot V\bar q_i\cdot\dot{\bar q}_i+V^{2/3}\lvert\dot{\bar q}_i\rvert^2]`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def andersenKinetic (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i*(andersenVelocity V Vdot qbar vbar i)^2/2
def andersenKineticExpanded (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i/2*((1/9 : ℝ)*Real.rpow V (-4/3 : ℝ)*Vdot^2*qbar i^2+
    (2/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i*vbar i+
    Real.rpow V (2/3 : ℝ)*vbar i^2)
theorem andersenKinetic_expansion (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) : andersenKinetic m V Vdot qbar vbar =
      andersenKineticExpanded m V Vdot qbar vbar := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印动能展开的逐标量坐标版本。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 坐标逐分量求和就是三维点积展开，避免把Pi类型的最大范数误作物理Euclidean长度；V正。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页400。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.andersenKinetic`：定义
- `MD.Ch08.andersenKineticExpanded`：定义
- `MD.Ch08.andersenKinetic_expansion`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-AndersenHamiltonianPrinted

印刷页 380 / PDF页 401。

### 1. 原文陈述

> $`\hat H=\sum_i\lvert\bar p_i\rvert^2/(2m_iV^{2/3})+\bar U(\bar q;V)+p_V^2/(2\mu_V)+PV`$, and $`\rho_{NPT}=\sqrt{\beta/(2\pi\mu_V)}\int\exp(-\beta\hat H)dp_V`$. (8.73).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def andersenHamiltonian (m : Vec n) (U : Vec n → ℝ) (QV P : ℝ)
    (z : (Phase n × ℝ) × ℝ) : ℝ :=
  (∑ i, z.1.1.2 i^2/(2*m i*Real.rpow z.1.2 (2/3 : ℝ)))+
    U (andersenPosition z.1.2 z.1.1.1)+z.2^2/(2*QV)+P*z.1.2
def andersenMarginalPrinted (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (z : Phase n × ℝ) : ℝ :=
  Real.sqrt (β/(2*Real.pi*QV))*∫ pV, Real.exp (-β*andersenHamiltonian m U QV P (z,pV))
def andersenMarginal_corrected (m : Vec n) (U : Vec n → ℝ) (QV P β Z : ℝ)
    (z : Phase n × ℝ) : ℝ := andersenMarginalPrinted m U QV P β z/Z
theorem andersenGaussian_marginal (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (hQV : 0 < QV) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    andersenMarginalPrinted m U QV P β z =
      Real.exp (-β*((∑ i, z.1.2 i^2/(2*m i*Real.rpow z.2 (2/3 : ℝ)))+
        U (andersenPosition z.2 z.1.1)+P*z.2)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。
- [EXTRA] andersenMarginal_corrected本身仅为除以Z的函数定义；要解释为概率密度须另证明Z等于正确域上正有限配分积分。
- [EXTRA] `andersenMarginal_corrected`仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和$`V\gt 0`$域上可积，且Z为相同权重的正有限配分积分；任意$`Z\gt 0`$不足。
- 覆盖缺口：[EXTRA] `andersenMarginal_corrected`仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和$`V\gt 0`$域上可积，且Z为相同权重的正有限配分积分；任意$`Z\gt 0`$不足。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；相对归一NPT密度缺配分因子。
修正版：原送审Gaussian消元及除Z权重合理；正有限配分积分未保证，不宣称概率归一。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF401：边缘公式未写此前$`\rho_{NPT}`$定义中的$`Z_{NPT}^{-1}`$；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。；[ERRATUM?] 保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意$`Z\gt 0`$。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页401。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.andersenHamiltonian`：定义
- `MD.Ch08.andersenMarginalPrinted`：定义
- `MD.Ch08.andersenMarginal_corrected`：定义
- `MD.Ch08.andersenGaussian_marginal`：未证；原书疑误不证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-NHLPistonEquations

印刷页 381–382 / PDF页 402–403。

### 1. 原文陈述

> $`\dot q=M^{-1}p+\eta q`$, $`\dot p=F-\eta p-\xi p`$, $`\dot V=\eta V`$; $`d\xi=(h_T-\gamma_T\xi)dt+\sqrt{2k_B T\gamma_T/\mu_T}dW_T`$, $`d\eta=(h_P-\gamma_P\eta)dt+\sqrt{2k_B T\gamma_P/\mu_P}dW_P`$, with $`h_T=(p^{\mathsf T}M^{-1}p-N_d k_B T)/\mu_T`$ and $`h_P=(V\Pi-PV+k_B T)/\mu_P`$. (8.75)–(8.79).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev PistonState (n : ℕ) := Phase n × Vec 3
def pistonPressure (invm : Vec n) (U : Vec n × ℝ → ℝ) (q p : Vec n) (V : ℝ) : ℝ :=
  (kineticTwice invm p-dot q (gradient (fun x ↦ U (x,V)) q)-
    V*deriv (fun v ↦ U (q,v)) V)/V
def pistonDrift (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i+z.2 2*z.1.1 i,
    fun i ↦ -gradient (fun q ↦ U (q,z.2 0)) z.1.1 i-(z.2 2+z.2 1)*z.1.2 i),
   ![z.2 2*z.2 0,(kineticTwice invm z.1.2-n*θ)/QT-γT*z.2 1,
     (z.2 0*pistonPressure invm U z.1.1 z.1.2 (z.2 0)-P*z.2 0+θ)/QP-γP*z.2 2])
def pistonNoise (θ QT QP γT γP : ℝ) (j : Fin 2) : PistonState n :=
  ((0,0),if j=0 then ![0,Real.sqrt (2*θ*γT/QT),0] else ![0,0,Real.sqrt (2*θ*γP/QP)])
def isNHLPistonSolution (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (μ : Measure Ω) (W : ℝ → Ω → Vec 2) (X : ℝ → Ω → PistonState n)
    (x0 : PistonState n) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ 0 < QT ∧ 0 < QP ∧ 0 ≤ γT ∧ 0 ≤ γP ∧
  ContDiff ℝ 2 U ∧ 0 < x0.2 0 ∧ (∀ t, 0 ≤ t → ∀ᵐ sample ∂μ, 0 < (X t sample).2 0) ∧
  additiveSDE μ 2 W X x0 (pistonDrift invm U θ P QT QP γT γP) (pistonNoise θ QT QP γT γP)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际压力、反馈、漂移扩散和正体积NHL活塞积分解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`z.2=(V,\xi,\eta)`$，$`V\gt 0`$、热浴/活塞质量正、独立二维Wiener明确；所有辅助变量除V均为实数。
- 选择正体积域内的积分解类，不声明该类存在唯一或必然遍历；$`n=3N`$为物理情形。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页402–403。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.PistonState`：定义
- `MD.Ch08.pistonPressure`：定义
- `MD.Ch08.pistonDrift`：定义
- `MD.Ch08.pistonNoise`：定义
- `MD.Ch08.isNHLPistonSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonHamiltonianSubfield

印刷页 381 / PDF页 402。

### 1. 原文陈述

> $`\rho_1=\varphi_1(p^{\mathsf T}M^{-1}p/2+U(q))\psi(V,\xi,\eta)`$ is stated to be stationary for the Liouvillian of the printed vector field $`(p,-\nabla U,0,0,0)`$. [ERRATUM?] For general mass the Hamiltonian field should have first component $`M^{-1}p`$; the Lean stationarity target uses this corrected field.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonHamiltonianPart (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)
theorem pistonHamiltonianWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (φ : ℝ → ℝ) (ψ : Vec 3 → ℝ) (hU : ContDiff ℝ 2 U)
    (hφ : ContDiff ℝ 1 φ) (hψ : ContDiff ℝ 1 ψ) (z : PistonState n) :
    textbookDivergence (fun x : PistonState n ↦
      (φ (kineticTwice invm x.1.2/2+U (x.1.1,x.2 0))*ψ x.2) •
        pistonHamiltonianPart invm U x) z=0 := by
  sorry

/-- 原印Hamiltonian子场：第一分量为p，忠实保留其一般质量疑误。 -/
def pistonHamiltonianPartPrinted (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((z.1.2,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)

/-- 修正版第一分量为M⁻¹p；现有驻定目标已采用此场。 -/
def pistonHamiltonianPart_corrected (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n := pistonHamiltonianPart invm U z
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印p子场、$`M^{-1}p`$修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] invm:Fin n→ℝ表示固定对角逆质量系数；Lean全称允许任意实系数，不要求正性，散度恒等式仍成立。
- [EXTRA] $`U:(\mathrm{Vec}\,n\times\mathbb R)\to\mathbb R`$为$`C^2`$，$`\varphi:\mathbb R\to\mathbb R`$和$`\psi:\mathrm{Vec}\,3\to\mathbb R`$为$`C^1`$；U允许依赖作为冻结参数的V。
- [EXTRA] 状态为$`((q,p),(V,\xi,\eta))`$，后三坐标在子场下全为零。Lean仅陈述局部通量散度零，不要求权非负、归一或可积，也不证明全局流或边界性质。
- [ERRATUM?] 原印子场首分量p，仅单位质量等特殊情形与所印能量一致；修正版采用$`M^{-1}p`$。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；{"overall": "原印场的一般质量疑误判NEEDS_HUMAN；Printed定义忠实、修正场及其散度恒等式签名PASS。未依据sorry否定签名。", "objects_and_domains": "n为任意自然数；`Vec n=Fin n→ℝ`，`Phase n=Vec n×Vec n`，`PistonState n=Phase n×Vec 3`。z任意，无$`V\ge0`$限制；x.2 0是V，ξ、η为另外两冻结坐标。invm为常实对角系数；质量正性对恒等式不必要。", "declarations": [{"lean_decl": "MD.Ch08.pistonHamiltonianPart", "verdict": "PASS", "explanation": "场为$`((invm\cdot p,-\nabla_q U(q,V)),0)`$，梯度按标准坐标方向fderiv定义，后三分量为零。与一般对角质量的Hamiltonian修正一致，但不能叫原印逐字场。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianWeight_stationary", "verdict": "PASS", "explanation": "对任意invm、$`C^2`$的U、$`C^1`$的φ及ψ和任意z，全结论为$`\operatorname{div}([\varphi(H)\psi]F)(z)=0`$，其中$`H=\sum invm_i p_i^2/2+U(q,V)`$，div为完整状态空间上导数线性映射的trace。F自身散度为零，$`F\cdot\nabla H=\sum(U_{qi}invm_i p_i-invm_i p_i U_{qi})=0`$，ψ只依赖冻结坐标故沿场导数零。U依赖V不会引入额外通量项，因为V方向场分量恒为零。结论不要求质量正性或权可积，亦不推出概率归一化。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianPartPrinted", "verdict": "PASS", "explanation": "完整场$`((p,-\nabla_q U(q,V)),0)`$与原印$`(p,-\nabla U,0,0,0)`$逐分量一致；没有附带错误的驻定定理，故原印疑误不构成本定义忠实性的FAIL。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianPart_corrected", "verdict": "PASS", "explanation": "定义展开即pistonHamiltonianPart invm U z，明确把首分量修正为对角$`M^{-1}p`$，其余力及冻结坐标正确。"}]}
原文版：Printed的p场忠实性PASS；一般质量下原驻定声称疑误待导师。
修正版：$`M^{-1}p`$修正场及局部散度目标签名网站PASS；非概率平稳分布或全局保测流。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原页先给$`\dot q=M^{-1}p+\eta q`$，随后驻定子场却明确印为$`(p,-\nabla U,0,0,0)`$。对于一般质量及所印能量，二者不一致；不可将原印首分量静默改为$`M^{-1}p`$。；[EXTRA] Lean只陈述全实坐标空间上的局部加权通量散度为零；φ、ψ可取有符号光滑权，未要求非负、归一化或$`V\ge0`$上的可积性。因此不能解释为已构造概率平稳分布或全局保测流。；已目视核对原页PDF402：原印场为$`(p,-\nabla U,0,0,0)`$，一般质量的修正场为$`(M^{-1}p,-\nabla U,0,0,0)`$。原印p与本页$`\dot q=M^{-1}p+\eta q`$不一致，修正版仅给局部通量散度目标。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页402。

### 7. 状态与证明位置

- `MD.Ch08.pistonHamiltonianPart`：定义
- `MD.Ch08.pistonHamiltonianWeight_stationary`：未证；缺大型理论
- `MD.Ch08.pistonHamiltonianPartPrinted`：定义
- `MD.Ch08.pistonHamiltonianPart_corrected`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonThermostatWeightPrinted

印刷页 381 / PDF页 402。

### 1. 原文陈述

> The book prints $`\rho_2=\exp(-\beta[p^{\mathsf T}M^{-1}p+\mu_T\xi^2/2])\psi_2(q,\eta,V)`$ for $`\dot p=-\xi p`$, $`\dot\xi=(p^{\mathsf T}M^{-1}p-N_d k_B T)/\mu_T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonThermostatPart (invm : Vec n) (θ QT : ℝ) (z : PistonState n) : PistonState n :=
  ((0,fun i ↦ -z.2 1*z.1.2 i),![0,(kineticTwice invm z.1.2-n*θ)/QT,0])
def pistonRho2Printed (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2+QT*(z.2 1)^2/2))
def pistonRho2_corrected (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+QT*(z.2 1)^2/2))
theorem pistonRho2_stationary_corrected (invm : Vec n) (β QT : ℝ)
    (hm : ∀ i, 0 < invm i) (hβ : 0 < β) (hQT : 0 < QT) (z : PistonState n) :
    textbookDivergence (fun x ↦ pistonRho2_corrected invm β QT x •
      pistonThermostatPart invm β⁻¹ QT x) z=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/修正权重及$`\psi_2=1`$时的实际子场驻定目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅取$`\psi_2=1`$的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；原印动能缺1/2。
修正版：原送审恢复1/2的_corrected及局部驻定签名PASS，$`\psi_2=1`$。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF402：$`\rho_2`$动能项缺1/2；所印反馈仍为$`p^{\mathsf T}M^{-1}p-N_d k_B T`$。原印权重保留，工作修正采用标准动能的一半。；保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页402。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pistonThermostatPart`：定义
- `MD.Ch08.pistonRho2Printed`：定义
- `MD.Ch08.pistonRho2_corrected`：定义
- `MD.Ch08.pistonRho2_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonReducedPDE

印刷页 382 / PDF页 403。

### 1. 原文陈述

> $`-q\cdot\nabla_q\psi+p\cdot\nabla_p\psi-\psi-V\partial_V\psi+(\beta V\Pi-\beta PV+1)\psi=0`$, solved by $`\psi\propto\exp(-\beta(H+PV))`$. (8.74).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonReducedOperator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (ψ : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  -fderiv ℝ ψ z ((z.1.1,0),0)+fderiv ℝ ψ z ((0,z.1.2),0)-ψ z-
  z.2*fderiv ℝ ψ z ((0,0),1)+
    (β*z.2*pistonPressure invm U z.1.1 z.1.2 z.2-β*P*z.2+1)*ψ z
theorem pistonReduced_boltzmann (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    pistonReducedOperator invm U β P
      (fun x ↦ Real.exp (-β*(kineticTwice invm x.1.2/2+U (x.1.1,x.2)+P*x.2))) z=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 完整(8.74)及Boltzmann权代入目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。
- 覆盖缺口：只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页403。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pistonReducedOperator`：定义
- `MD.Ch08.pistonReduced_boltzmann`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.1-PistonStationaryWeight

印刷页 382 / PDF页 403。

### 1. 原文陈述

> Adding the two independent OU thermostats to $`\xi,\eta`$ preserves the candidate weight $`\exp[-\beta(H+PV+\mu_T\xi^2/2+\mu_P\eta^2/2)]`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pistonWeight (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP : ℝ)
    (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+U (z.1.1,z.2 0)+P*z.2 0+
    QT*(z.2 1)^2/2+QP*(z.2 2)^2/2))
def pistonForward (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (ρ : PistonState n → ℝ) (z : PistonState n) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • pistonDrift invm U θ P QT QP γT γP x) z+
    (∑ j : Fin 2, fderiv ℝ (fun x ↦ fderiv ℝ ρ x (pistonNoise θ QT QP γT γP j))
      z (pistonNoise θ QT QP γT γP j))/2
theorem pistonWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (β P QT QP γT γP : ℝ) (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U)
    (hβ : 0 < β) (hQT : 0 < QT) (hQP : 0 < QP) (hγT : 0 ≤ γT) (hγP : 0 ≤ γP)
    (z : PistonState n) (hV : 0 < z.2 0) :
    pistonForward invm U β⁻¹ P QT QP γT γP (pistonWeight invm U β P QT QP) z=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 候选权重与实际局部前向算子的驻定目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述正V内的真实Fokker–Planck微分表达式为零；候选正权重并不自动可积/归一。
- 盒边界/体积边界的通量、Markov半群不变概率及唯一遍历性需要NPT理论，明确列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页403。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pistonWeight`：定义
- `MD.Ch08.pistonForward`：定义
- `MD.Ch08.pistonWeight_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.2-PistonIntegrator

印刷页 383 / PDF页 404。

### 1. 原文陈述

> The printed algorithm interleaves feedback half-updates, exponentially damped momentum kicks, exponential position/volume drifts, feedback recomputation and final independent OU steps. $`\psi(\alpha,t)=(e^{\alpha t}-1)/\alpha`$, extended by $`t`$ at $`\alpha=0`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def expIntegrated (a t : ℝ) : ℝ := if a=0 then t else (Real.exp (a*t)-1)/a
def pistonWrap (V : ℝ) (q : Vec n) : Vec n := fun i ↦
  volumeScale V*(q i/volumeScale V+1/2-(Int.floor (q i/volumeScale V+1/2) : ℝ)-1/2)
def pistonMomentumKick (U : Vec n × ℝ → ℝ) (h : ℝ) (z : PistonState n) : PistonState n :=
  ((z.1.1,fun i ↦ Real.exp (-(z.2 1+z.2 2)*h)*z.1.2 i-
    expIntegrated (-(z.2 1+z.2 2)) h*gradient (fun q ↦ U (q,z.2 0)) z.1.1 i),z.2)
def pistonFeedback (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP h : ℝ)
    (z : PistonState n) : PistonState n :=
  let f := pistonDrift invm U θ P QT QP 0 0 z
  (z.1,![z.2 0,z.2 1+h*f.2 1,z.2 2+h*f.2 2])
def pistonOU (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) : PistonState n :=
  (z.1,![z.2 0,Real.exp (-γT*h)*z.2 1+Real.sqrt ((1-Real.exp (-2*γT*h))/(β*QT))*R 0,
    Real.exp (-γP*h)*z.2 2+Real.sqrt ((1-Real.exp (-2*γP*h))/(β*QP))*R 1])
def pistonIntegrator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP γT γP h : ℝ)
    (R : Vec 2) (z : PistonState n) : PistonState n :=
  let a := pistonFeedback invm U β⁻¹ P QT QP (h/2) z
  let b := pistonMomentumKick U (h/2) a
  let q := pistonWrap (b.2 0) (fun i ↦ Real.exp (b.2 2*h)*b.1.1 i+
    expIntegrated (b.2 2) h*invm i*b.1.2 i)
  let c := pistonMomentumKick U (h/2) ((q,b.1.2),b.2)
  let V := Real.exp (c.2 2*h)*c.2 0
  let d : PistonState n := ((pistonWrap V c.1.1,c.1.2),![V,c.2 1,c.2 2])
  pistonOU β QT QP γT γP h R (pistonFeedback invm U β⁻¹ P QT QP (h/2) d)
theorem pistonOU_volume (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) :
    (pistonOU β QT QP γT γP h R z).2 0=z.2 0 := rfl
theorem pistonVolume_positive (V η h : ℝ) (hV : 0 < V) : 0 < Real.exp (η*h)*V :=
  mul_pos (Real.exp_pos _) hV
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 完整分步算法、周期映射及OU保持V和指数体积正性的短结论。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正β、QT、QP、质量、体积及$`h\ge0`$是物理有效域；R取独立标准二维正态且跨步独立，参照independentWiener/standardNormalSequence所列资格。
- 零指数分支按原页连续延拓；周期位置在每次q/V更新后按当前盒长映射。只定义完整算法，不证明二阶、可逆或不变分布精度。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页404。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.expIntegrated`：定义
- `MD.Ch08.pistonWrap`：定义
- `MD.Ch08.pistonMomentumKick`：定义
- `MD.Ch08.pistonFeedback`：定义
- `MD.Ch08.pistonOU`：定义
- `MD.Ch08.pistonIntegrator`：定义
- `MD.Ch08.pistonOU_volume`：已证
- `MD.Ch08.pistonVolume_positive`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8.3-ParrinelloRahman

印刷页 385 / PDF页 406。

### 1. 原文陈述

> For cell matrix $`h=[a\ b\ c]`$, $`V=\det(h)=a\cdot(b\times c)`$, $`q_i=h\bar q_i`$, $`G=h^{\mathsf T}h`$, $`L=(1/2)\sum m_i\dot{\bar q}_i^{\mathsf T}G\dot{\bar q}_i-\bar U(\bar q)+(\mu/2)\operatorname{Tr}(\dot h^{\mathsf T}\dot h)-PV`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def cellVolume (h : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := Matrix.det h
def cellMetric (h : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ := h.transpose*h
def cellPosition (h : Matrix (Fin 3) (Fin 3) ℝ) (qbar : Vec 3) : Vec 3 := h *ᵥ qbar
def cross3 (a b : Vec 3) : Vec 3 := ![a 1*b 2-a 2*b 1,a 2*b 0-a 0*b 2,a 0*b 1-a 1*b 0]
theorem cellVolume_triple (h : Matrix (Fin 3) (Fin 3) ℝ) :
    cellVolume h=dot (fun i ↦ h i 0) (cross3 (fun i ↦ h i 1) (fun i ↦ h i 2)) := by
  simp [cellVolume,Matrix.det_fin_three,dot,Fin.sum_univ_succ,cross3]
  ring
def parrinelloRahmanLagrangian {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → Vec 3) → ℝ)
    (Q P : ℝ) (h hdot : Matrix (Fin 3) (Fin 3) ℝ) (qbar vbar : Fin N → Vec 3) : ℝ :=
  (∑ i, m i/2*dot (vbar i) (cellMetric h *ᵥ vbar i))-U qbar+
    Q/2*Matrix.trace (hdot.transpose*hdot)-P*cellVolume h
def cellQualification {N : ℕ} (m : Fin N → ℝ) (Q : ℝ)
    (h : Matrix (Fin 3) (Fin 3) ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < Q ∧ 0 < Matrix.det h
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 各向异性盒的体积/位置/度量/Lagrangian及标量三重积恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 选定正定向非退化盒det(h)>0及正质量；U为缩放坐标势，必要时由实际h映射后势复合而得。
- 拉氏方程、与热浴耦合和防止盒塌缩均未在原页给完整条件，列覆盖缺口，不把内部结构的经验稳定性当定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页406。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.cellVolume`：定义
- `MD.Ch08.cellMetric`：定义
- `MD.Ch08.cellPosition`：定义
- `MD.Ch08.cross3`：定义
- `MD.Ch08.cellVolume_triple`：已证
- `MD.Ch08.parrinelloRahmanLagrangian`：定义
- `MD.Ch08.cellQualification`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9-TotalMomentum

印刷页 386 / PDF页 407。

### 1. 原文陈述

> With central conservative forces $`\sum_iF_i=0`$, Nosé dynamics gives $`d p_{tot}/dt=-\xi p_{tot}`$. Zero total momentum is formally invariant.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev ParticleConfig (N d : ℕ) := Fin N → Vec d
abbrev ParticlePhase (N d : ℕ) := ParticleConfig N d × ParticleConfig N d
def totalMomentum {N d : ℕ} (p : ParticleConfig N d) : Vec d := ∑ i, p i
theorem noseTotalForce {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) :
    totalMomentum (fun i ↦ F i-ξ • p i) = -ξ • totalMomentum p := by
  simp only [totalMomentum,Finset.sum_sub_distrib,← Finset.smul_sum] at *
  rw [hF]; simp
theorem noseTotalForce_zero {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) (hp : totalMomentum p=0) :
    totalMomentum (fun i ↦ F i-ξ • p i)=0 := by rw [noseTotalForce F p ξ hF,hp,smul_zero]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 总动量定义和Nosé瞬时总力/零总动量时总力为零。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只证明瞬时总力恒等式；沿连续轨道的零动量不变需要ODE唯一性，有限精度“飞冰块”属经验现象，列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页407。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.ParticleConfig`：定义
- `MD.Ch08.ParticlePhase`：定义
- `MD.Ch08.totalMomentum`：定义
- `MD.Ch08.noseTotalForce`：已证
- `MD.Ch08.noseTotalForce_zero`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDSoftPotential

印刷页 387–388 / PDF页 408–409。

### 1. 原文陈述

> $`r_{ij}=\lvert q_i-q_j\rvert`$, $`e_{ij}=(q_i-q_j)/r_{ij}`$. $`F^c_{ij}=\alpha(1-r_{ij}/r_c)e_{ij}`$ for $`r_{ij}\lt r_c`$, zero otherwise; $`\varphi_{DPD}=(\alpha r_c/2)(1-r/r_c)^2`$ below cutoff, $`U=\sum_{i\lt j}\varphi(r_{ij})`$. (8.80)–(8.84).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairDistance {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : ℝ :=
  Real.sqrt (dot (q i-q j) (q i-q j))
def pairDirection {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (pairDistance q i j)⁻¹ • (q i-q j)
def dpdSoftPotential (α rc r : ℝ) : ℝ := if r < rc then α*rc/2*(1-r/rc)^2 else 0
def dpdPairConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  if pairDistance q i j < rc then (α*(1-pairDistance q i j/rc)) • pairDirection q i j else 0
def dpdPotential {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), dpdSoftPotential α rc (pairDistance q i j)
def dpdConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairConservative α rc q i j
def particleGradient {N d : ℕ} (U : ParticleConfig N d → ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i a ↦ fderiv ℝ U q (Pi.single i (Pi.single a 1))
theorem dpdConservative_gradient {N d : ℕ} (α rc : ℝ) (hα : 0 ≤ α) (hrc : 0 < rc)
    (q : ParticleConfig N d) (hnocoll : ∀ i j, i ≠ j → 0 < pairDistance q i j)
    (hcut : ∀ i j, i ≠ j → pairDistance q i j ≠ rc) :
    dpdConservative α rc q = -particleGradient (dpdPotential α rc) q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 软势、保守成对力/总力与光滑有效域的梯度目标；完整SDE见后条。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- d维Euclidean距离由坐标平方和开方，避免Pi最大范数；只在非碰撞且离开截断接缝的有效域声明梯度关系。N、d为物理正整数，$`m_i\gt 0`$在动力学资格另列。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页408–409。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pairDistance`：定义
- `MD.Ch08.pairDirection`：定义
- `MD.Ch08.dpdSoftPotential`：定义
- `MD.Ch08.dpdPairConservative`：定义
- `MD.Ch08.dpdPotential`：定义
- `MD.Ch08.dpdConservative`：定义
- `MD.Ch08.particleGradient`：定义
- `MD.Ch08.dpdConservative_gradient`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDPairForces

印刷页 388 / PDF页 409。

### 1. 原文陈述

> $`F^D_{ij}=-\gamma\omega^D(r_{ij})(e_{ij}\cdot v_{ij})e_{ij}`$, $`F^R_{ij}=\sigma\omega^R(r_{ij})\theta_{ij}e_{ij}`$, $`\omega^R(r)=1-r/r_c`$ below cutoff. $`v_{ij}=p_i/m_i-p_j/m_j`$. (8.85)–(8.87).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdWeightR (rc r : ℝ) : ℝ := if r < rc then 1-r/rc else 0
def relativeVelocity {N d : ℕ} (m : Fin N → ℝ) (p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (m i)⁻¹ • p i-(m j)⁻¹ • p j
def dpdPairDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (-γ*wD (pairDistance q i j)*dot (pairDirection q i j) (relativeVelocity m p i j)) • pairDirection q i j
def dpdPairRandom {N d : ℕ} (σ : ℝ) (wR : ℝ → ℝ) (q : ParticleConfig N d)
    (i j : Fin N) (R : ℝ) : Vec d := (σ*wR (pairDistance q i j)*R) • pairDirection q i j
def dpdDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairDissipative m γ wD q p i j
def pairImpulseVector {N d : ℕ} (i j : Fin N) (v : Vec d) : ParticleConfig N d :=
  Pi.single i v-Pi.single j v
def dpdNoise {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ) (wR : ℝ → ℝ)
    (q : ParticleConfig N d) (k : Fin K) : ParticlePhase N d :=
  (0,pairImpulseVector (pairs k).1 (pairs k).2
    ((σ*wR (pairDistance q (pairs k).1 (pairs k).2)) • pairDirection q (pairs k).1 (pairs k).2))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 全部成对/总耗散力、软随机权与成对守恒扩散方向。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 白噪声$`\theta_{ij}`$不作为逐点函数使用；随机力的实际意义是下一条无序对独立Wiener驱动、双方相反的扩散向量。总化$`r=0`$只作辅助，在动力学中要求非碰撞。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页409。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdWeightR`：定义
- `MD.Ch08.relativeVelocity`：定义
- `MD.Ch08.dpdPairDissipative`：定义
- `MD.Ch08.dpdPairRandom`：定义
- `MD.Ch08.dpdDissipative`：定义
- `MD.Ch08.pairImpulseVector`：定义
- `MD.Ch08.dpdNoise`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDPairWiener

印刷页 388–389 / PDF页 409–410。

### 1. 原文陈述

> $`\theta_{ij}=\theta_{ji}`$; $`E\theta_{ij}=0`$ and $`E[\theta_{ij}(t)\theta_{kl}(t')]=(\delta_{ik}\delta_{jl}+\delta_{il}\delta_{jk})\delta(t-t')`$. Distinct unordered pairs are independent. (8.88).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairEnumeration {N K : ℕ} (pairs : Fin K → Fin N × Fin N) : Prop :=
  (∀ k, (pairs k).1 < (pairs k).2) ∧ Function.Injective pairs ∧
  ∀ i j, i < j → ∃ k, pairs k=(i,j)
def pairNoiseIncrement {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) (sample : Ω) : ℝ :=
  ∑ k, if pairs k=(i,j) ∨ pairs k=(j,i) then W t sample k-W s sample k else 0
theorem pairNoiseIncrement_symmetric {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) :
    pairNoiseIncrement pairs W s t i j=pairNoiseIncrement pairs W s t j i := by
  sorry
theorem pairNoiseIncrement_covariance {N K : ℕ} (P : Measure Ω)
    (pairs : Fin K → Fin N × Fin N) (he : pairEnumeration pairs)
    (W : ℝ → Ω → Vec K) (hW : independentWiener P K W)
    (s t : ℝ) (hs : 0 ≤ s) (hst : s ≤ t) (i j k l : Fin N) (hij : i ≠ j) (hkl : k ≠ l) :
    (∫ sample, pairNoiseIncrement pairs W s t i j sample*pairNoiseIncrement pairs W s t k l sample ∂P)=
      if (i=k ∧ j=l) ∨ (i=l ∧ j=k) then t-s else 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 对称噪声增量和对应所印δ协方差的积分版本。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只对无序对使用独立标准Wiener；$`W_{ij}=W_{ji}`$由同一坐标实现，不能把有序对全部设独立。Dirac白噪声公式通过有限时间增量协方差表达。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页409–410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pairEnumeration`：定义
- `MD.Ch08.pairNoiseIncrement`：定义
- `MD.Ch08.pairNoiseIncrement_symmetric`：未证；时间盒止
- `MD.Ch08.pairNoiseIncrement_covariance`：未证；时间盒止

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDIntegralSystem

印刷页 389 / PDF页 410。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$, $`dp=-\nabla U\,dt-\Delta(q)p\,dt+\Sigma(q)dW`$. (8.90).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def strictItoIntegral8 (P : Measure Ω) (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ k, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T k) 2 P) ∧ MemLp Y 2 P ∧
  Tendsto (fun k ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T k sample-Y sample)^2 ∂P)
    atTop (𝓝 0)
def multiplicativeSDE8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (P : Measure Ω) (r : ℕ)
    (W : ℝ → Ω → Vec r) (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : E → Fin r → E) : Prop :=
  independentWiener P r W ∧ Measurable (Function.uncurry X) ∧ (∀ j, Measurable (fun x ↦ B x j)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ T, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
    ∀ ell : E →L[ℝ] ℝ, ∃ Y : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral8 P (fun s sample ↦ W s sample j)
        (fun s sample ↦ ell (B (X s sample) j)) T (Y j)) ∧
      ∀ᵐ sample ∂P, ell (X T sample-x0-(∫ s in (0 : ℝ)..T, a (X s sample)))=∑ j, Y j sample
def dpdDrift {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),dpdConservative α rc z.1+dpdDissipative m γ wD z.1 z.2)
def isDPDSolution {N d K : ℕ} (m : Fin N → ℝ) (α rc γ σ θ : ℝ) (wD wR : ℝ → ℝ)
    (pairs : Fin K → Fin N × Fin N) (P : Measure Ω) (W : ℝ → Ω → Vec K)
    (X : ℝ → Ω → ParticlePhase N d) (x0 : ParticlePhase N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 ≤ α ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ r, wD r=(wR r)^2) ∧ σ^2=2*γ*θ ∧ pairEnumeration pairs ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1 i j) ∧
  multiplicativeSDE8 P K W X x0 (dpdDrift m α rc γ wD)
    (fun z ↦ dpdNoise pairs σ wR z.1)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 配置依赖扩散的真实积分解规格及正质量/涨落耗散/无序噪声资格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 实际多维独立Wiener、共同自然历史适应、联合可测、路径连续、漂移可积、所有网格左和及积分代表$`L^2`$均明示。
- 选择强$`L^2`$、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。
- 覆盖缺口：选择强$`L^2`$、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.strictItoIntegral8`：定义
- `MD.Ch08.multiplicativeSDE8`：定义
- `MD.Ch08.dpdDrift`：定义
- `MD.Ch08.isDPDSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDCanonicalLeaf

印刷页 389 / PDF页 410。

### 1. 原文陈述

> $`\omega^D=(\omega^R)^2`$, $`\sigma^2=2\gamma k_B T`$. The canonical density is restricted to fixed total momentum $`\pi`$ by $`\delta(\sum p-\pi)`$. (8.89).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdFluctuationDissipation (γ σ θ : ℝ) (wD wR : ℝ → ℝ) : Prop :=
  0 ≤ γ ∧ 0 < θ ∧ σ^2=2*γ*θ ∧ ∀ r, wD r=(wR r)^2
def momentumLeaf {N d : ℕ} (π : Vec d) : Set (ParticlePhase N d) :=
  {z | totalMomentum z.2=π}
def particleHamiltonian {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (z : ParticlePhase N d) : ℝ := (∑ i, dot (z.2 i) (z.2 i)/(2*m i))+U z.1
def momentumCanonical {N d : ℕ} (ν : Measure (ParticlePhase N d)) (m : Fin N → ℝ)
    (U : ParticleConfig N d → ℝ) (β : ℝ) : Measure (ParticlePhase N d) :=
  ν.withDensity (fun z ↦ ENNReal.ofReal (Real.exp (-β*particleHamiltonian m U z)/
    (∫ x, Real.exp (-β*particleHamiltonian m U x) ∂ν)))
def momentumCanonicalQualification {N d : ℕ} (ν : Measure (ParticlePhase N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ν (momentumLeaf π)ᶜ=0 ∧
  Integrable (fun z ↦ Real.exp (-β*particleHamiltonian m U z)) ν ∧
  (0 < ∫ z, Real.exp (-β*particleHamiltonian m U z) ∂ν) ∧
  IsProbabilityMeasure (momentumCanonical ν m U β)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 涨落耗散资格、动量约束叶及其可归一canonical测度定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Dirac乘积解释为指定动量叶上的参考测度，未伪造Lebesgue密度；参考测度需另指定几何/周期体积。
- 只是权重与概率资格目标；DPD保持该测度、流体力学保持及高密度一维遍历性的大型定理均列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdFluctuationDissipation`：定义
- `MD.Ch08.momentumLeaf`：定义
- `MD.Ch08.particleHamiltonian`：定义
- `MD.Ch08.momentumCanonical`：定义
- `MD.Ch08.momentumCanonicalQualification`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.1-DPDMassOrderPrinted

印刷页 389 / PDF页 410。

### 1. 原文陈述

> For $`dp=-\nabla U\,dt-\Delta(q)p\,dt+\Sigma(q)dW`$, the book gives $`\Delta=M^{-1}\Sigma\Sigma^{\mathsf T}/(2k_B T)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdMatrixFDPrinted {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • (M⁻¹*(B*B.transpose))
def dpdMatrixFD_corrected {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • ((B*B.transpose)*M⁻¹)
theorem dpdMassOrder_counterexample :
    (!![1,0;0,(1/2 : ℝ)]) * (!![1,-1;-1,1]) ≠
      (!![1,-1;-1,1]) * (!![1,0;0,(1/2 : ℝ)]) := by
  intro h
  have hh := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ ↦ A 0 1) h
  norm_num [Matrix.mul_apply,Fin.sum_univ_two] at hh
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/校正的质量矩阵次序及具体代数反例。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- M应正定、$`\theta\gt 0`$；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- 覆盖缺口：M应正定、$`\theta\gt 0`$；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；一般不等质量的乘法次序错误。
修正版：原送审右乘$`M^{-1}`$修正版与不交换反例PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF410：对动量漂移$`-\Delta p`$、动量协方差$`k_B TM`$，应为$`\Delta=\Sigma\Sigma^{\mathsf T}M^{-1}/(2k_B T)`$；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。；保留Printed等式；[ERRATUM?]记录一般质量情形改为$`\Sigma\Sigma^{\mathsf T}M^{-1}/(2k_B T)`$，标注等质量或交换条件下两者相同。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdMatrixFDPrinted`：定义
- `MD.Ch08.dpdMatrixFD_corrected`：定义
- `MD.Ch08.dpdMassOrder_counterexample`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

