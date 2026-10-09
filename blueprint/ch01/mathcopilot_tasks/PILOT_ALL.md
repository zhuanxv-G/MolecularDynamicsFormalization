# 第1章试点：五条原文审校 + 只读语义审计（一个 Task）

## 开始前上传 / @引用

请在同一个MathCopilot Task中引用以下文件，随后依次执行第一、第二部分，最后仅返回一个JSON数组。路径均相对工程根MolecularDynamicsFormalization，PDF位于工程父目录。

1. 教材PDF：`../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。页号从1起算；需读取PDF **41–42、45–49、54–55**，对应印刷 **18–19、22–26、31–32**。
2. 原文数据：`blueprint/ch01/ch01_source.json`；当前尚未网站审校，先在本任务第一部分核对。
3. 完整Lean源码：`Blueprint/Ch01.lean`。正文仅嵌入五条签名及其注释；辅助定义`IsNewtonTrajectoryOn`、`matrixAction`、`variableMassLagrangian`、`variableMassHamiltonian`须在此附件中检查。
4. 项目依赖定义文件如下；请打开实际定义，不凭名称推断含义。`blueprint/ch01/dependency_inventory.json`列出对应导入关系和哈希；Mathlib版本固定v4.34.0，Lean版本4.34.0。

```text
MolecularDynamics/BasicDefinitions.lean
MolecularDynamics/Chapter01/Continuation.lean
MolecularDynamics/Chapter01/EnergyConservation.lean
MolecularDynamics/Chapter01/EnergyGlobalExistence.lean
MolecularDynamics/Chapter01/Equilibrium.lean
MolecularDynamics/Chapter01/EuclideanStability.lean
MolecularDynamics/Chapter01/FutureFlow.lean
MolecularDynamics/Chapter01/GlobalContinuation.lean
MolecularDynamics/Chapter01/GlobalFlow.lean
MolecularDynamics/Chapter01/Hamiltonian.lean
MolecularDynamics/Chapter01/Lagrangian.lean
MolecularDynamics/Chapter01/LegendreTransform.lean
MolecularDynamics/Chapter01/LocalExistence.lean
MolecularDynamics/Chapter01/LocalTrajectories.lean
MolecularDynamics/Chapter01/MechanicalConfinement.lean
MolecularDynamics/Chapter01/MechanicalContinuation.lean
MolecularDynamics/Chapter01/MomentumBounds.lean
MolecularDynamics/Chapter01/NBody.lean
MolecularDynamics/Chapter01/ODEEndpoint.lean
MolecularDynamics/Chapter01/ParticleCoordinates.lean
MolecularDynamics/Chapter01/PhaseMetric.lean
MolecularDynamics/Chapter01/PotentialBarriers.lean
MolecularDynamics/Chapter01/PotentialRegularity.lean
MolecularDynamics/Chapter01/Stability.lean
MolecularDynamics/Chapter01/TimeReversal.lean
MolecularDynamics/Notation.lean
```

| source_id | 目标原文：印刷页 / PDF页 | 必要上下文：PDF页 |
|---|---|---|
| MD-1.5.3-Thm1.1 | Theorem 1.1：32 / 55 | 41、48、54–55；定理不在54 |
| MD-1.2-EnergyConservation | 能量守恒：19 / 42 | 41–42，式(1.3)/(1.4) |
| MD-1.3-NewtonEulerLagrange | Newton ⇔ Euler–Lagrange：23 / 46 | 41、45–46 |
| MD-1.4-LegendreHamiltonian | Legendre变换：24 / 47 | 45–47，配置相关质量矩阵及凸性背景 |
| MD-1.5.1-FlowInverse | 流反演和整段群律：26 / 49 | 48–49，存在唯一性和双向时间背景 |

审计输入来自提交`0f0999d1c5b7adbcf35e30fcb277e022224fa07b`；本地任务登记`blueprint/ch01/tasks.json`保留五条输入哈希。若附件与下述片段不同，明确报告版本不一致，不自行选取有利版本。不要修改文件、证明定理、独立翻译或执行修复；本任务只返回审校数据和审计意见。

## 第一部分：模板A——五条原文JSON审校

你是独立审校员。对下方全部五条，只依据PDF原页审校：

1. 定位类型、编号、标题和实际页码跨度；逐字核对`statement_latex`、`proof_latex`以及有则列出的`proof_discussion_latex`。核对公式、上下标、字体所区分的对象、量词顺序、全部假设、边界和全部子句。
2. 检查漏句、重复、跨页截断、证明混入陈述或将证明思路误称完整证明。书中无完整证明时保留null并说明；不凭记忆补写。
3. 核对`context_notation`所指的定义和位置，区分原文明确前提、上下文继承前提与本地新增假设；主动尝试用原页证据反驳条目。
4. 每条给出`PASS`、`REPAIRED`或`NEEDS_HUMAN`。保持source_id；仅在输出`corrected_json`中给出修订，不改附件。原文疑似数学错误须保留原句并记issues，不能静默修正。
5. `issue_codes`用字符串数组，可含SYMBOL_ERROR、MISSING_CLAUSE、WRONG_OBJECT、WRONG_QUANTIFIER、CROSS_PAGE_GAP、DUPLICATE、WRONG_PAGE、POSSIBLE_ERRATUM。`evidence`明确印刷页/PDF页及支持判断的短原文。

先在内部完成五条的A审校，再进入第二部分；不要先输出中间结果。

## 第二部分：模板C——依据第一部分结果只读语义审计

证据优先级：PDF原文 > 第一部分已核对的原文JSON（包括REPAIRED的corrected_json） > 当前Lean陈述。即使A修订了JSON，C也必须审计附件中的现有Lean签名，不能把建议修复后的签名当作当前版本。

逐条检查：

1. 对象、类型、维数、定义域和时间范围是否一致；局部/全局、位置/动量、配置相关/固定质量是否混淆。
2. 量词顺序及依赖是否正确，谁依赖谁；所有假设和每个结论子句是否保留，包括唯一性、达到条件、双向等价、双向反演和群律。
3. 点开项目定义检查；逐条评估[EXTRA]是否原文隐含且必要，[ERRATUM?]是否得到原文上下文支持；不得因为已有可编译证明就直接判PASS。
4. 检查逐点/几乎处处、存在/唯一、是否弱化/加强、True、P→P、把结论藏进假设等语义问题。尽量给出最小反例，例如U(x)=x⁴、谐振子或一维负质量矩阵。
5. 特别检查：Theorem1.1的严格sup界和未来解存在；能量导数为零及区间内守恒；Newton/Euler–Lagrange两个方向；M(q)的Legendre上确界、精确达到条件、动量梯度和能量表示；流的完整反演/双射/Abelian群律。
6. A为NEEDS_HUMAN或缺少PDF/定义文件时，仍返回该条记录，但C的verdict用NEEDS_HUMAN，解释缺什么，禁止PASS。A为REPAIRED时明确说明C依据哪些原文修订判断。
7. 这是语义审计；无需执行fresh Check。若确实执行，才在explanation注明命令、版本和实际结果；未执行不得声称验证通过。Blueprint中的占位与数学陈述正确性分别说明，不将语义PASS冒充证明完成。

允许的audit.verdict：PASS、TOO_WEAK、TOO_STRONG、MISSING_CLAUSE、EXTRA_ASSUMPTION、WRONG_OBJECT、WRONG_QUANTIFIER、WRONG_LEVEL、POSSIBLE_ERRATUM、NEEDS_HUMAN。

## 本批输入：原文及当前Lean签名

以下JSON只省略修复日志和流程元数据，原文字符串保留不变；完整对象以附件ch01_source.json为准。Lean节选是供阅读的声明类型，没有证明体，不能直接作为独立可编译文件。

### 1. MD-1.5.3-Thm1.1

```json
{
  "source_id": "MD-1.5.3-Thm1.1",
  "kind": "theorem",
  "label": "Theorem 1.1",
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "If $\\boldsymbol{q}^*$ is a strong local minimum of smooth potential $U$ then $\\boldsymbol{z}^*=(\\boldsymbol{q}^*,0)$ is stable.",
  "proof_latex": null,
  "proof_note": "原文只有以下证明思路并指向[216]，无完整证明；不把思路冒充原文证明。",
  "proof_discussion_latex": "The proof of this theorem relies on showing that if trajectories are started from a point sufficiently close to $\\boldsymbol{z}^*$ they cannot wander away to infinity. Although the result holds in greater generality, it is easy to show under assumptions of local smoothness of $U$ (which we are normally happy to make in molecular dynamics). For more discussion see the text [216].",
  "context_notation": [
    "$\\boldsymbol{z}=(\\boldsymbol{q},\\boldsymbol{p})$，相空间位置与动量：§1.4印刷p.25/PDF48；$H(\\boldsymbol{q},\\boldsymbol{p})=\\boldsymbol{p}^TM^{-1}\\boldsymbol{p}/2+U(\\boldsymbol{q})$：§1.5.3印刷p.32/PDF55。",
    "平衡点$f(\\boldsymbol{z}^*)=0$：§1.5.3印刷p.31/PDF54；同节假设平衡点附近$f$连续可微。",
    "强局部极小：存在$\\epsilon>0$，$0<\\|\\boldsymbol{q}-\\boldsymbol{q}^*\\|<\\epsilon\\Rightarrow U(\\boldsymbol{q})>U(\\boldsymbol{q}^*)$，印刷p.32/PDF55。",
    "稳定：for all $\\epsilon$, there exists $\\delta$ such that, for all $\\boldsymbol{z}_0$ with $\\|\\boldsymbol{z}_0-\\boldsymbol{z}^*\\|<\\delta$, $\\sup_{t\\geq0}\\|\\mathcal{F}_t(\\boldsymbol{z}_0)-\\boldsymbol{z}^*\\|<\\epsilon$，印刷p.32/PDF55；按正容差解释，正文量词省略$\\epsilon,\\delta>0$。",
    "$\\boldsymbol{M}$固定正定质量矩阵：§1.2印刷p.18/PDF41的对角质量及§1.5印刷p.25/PDF48的正定前提。"
  ],
  "statement_scope": "只摘录定理句；稳定/强极小定义作为context_notation，Hartman–Grobman陈述不在试点。",
  "issues": [
    {
      "code": "PAGE_SPAN_CORRECTION",
      "status": "local_verified",
      "detail": "用户范围31–32/54–55是背景跨度；定理与证明思路均仅32/55。"
    }
  ]
}
```

```lean
/-- source_id: MD-1.5.3-Thm1.1 · Theorem 1.1 · printed p.32 / PDF p.55
Original: A strong local minimum of a smooth potential yields a stable equilibrium.
[EXTRA] hm: positive fixed diagonal masses, inherited from p.25 positive definiteness.
[EXTRA] hQ: open position domain for local ODEs and the minimum neighborhood.
[EXTRA] hstrict includes q₀ ∈ Q, the implicit domain qualification.
hU is the original smoothness hypothesis, not an extra C1-force assumption.
The Euclidean predicate retains positive ε/δ, all nearby initial states, future
existence, and a bounded real supremum strictly below ε for every future solution.
The theorem sentence and proof discussion are on p.32 only; p.31 is background. -/
theorem MD.Ch01.theorem_1_1 {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n))
```

### 2. MD-1.2-EnergyConservation

```json
{
  "source_id": "MD-1.2-EnergyConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19",
  "pdf_page": "42",
  "statement_latex": "Along the solutions of (1.3), the energy is conserved, since its derivative vanishes:",
  "proof_latex": "\\[\\frac{\\mathrm{d}}{\\mathrm{d}t}E=\\sum_{j=1}^{N}m_j\\dot{\\boldsymbol{q}}_j\\cdot\\ddot{\\boldsymbol{q}}_j+\\sum_{j=1}^{N}\\frac{\\partial U}{\\partial\\boldsymbol{q}_j}\\cdot\\dot{\\boldsymbol{q}}_j=\\sum_{j=1}^{N}\\left(m_j\\ddot{\\boldsymbol{q}}_j+\\frac{\\partial U}{\\partial\\boldsymbol{q}_j}\\right)\\cdot\\dot{\\boldsymbol{q}}_j=0.\\]",
  "proof_note": "原文紧接陈述给出完整导数计算；PDF字体记录确认能量函数为数学斜体E。",
  "context_notation": [
    "式(1.3)：$\\boldsymbol{M}\\frac{\\mathrm{d}^2}{\\mathrm{d}t^2}\\boldsymbol{q}=\\boldsymbol{F}(\\boldsymbol{q})=-\\nabla U(\\boldsymbol{q})$；$\\boldsymbol{M}=\\operatorname{diag}(m_1,m_1,m_1,\\ldots,m_N,m_N,m_N)$，§1.2印刷p.18/PDF41。",
    "式(1.4)：$E(\\boldsymbol{q}_1,\\ldots,\\boldsymbol{q}_N,\\dot{\\boldsymbol{q}}_1,\\ldots,\\dot{\\boldsymbol{q}}_N)=\\sum_{j=1}^{N}m_j\\|\\dot{\\boldsymbol{q}}_j\\|^2/2+U(\\boldsymbol{q}_1,\\ldots,\\boldsymbol{q}_N)$，§1.2印刷p.18/PDF41。",
    "粒子向量可按坐标展平；三维时n=N_c=3N，直线运动时n=N；本地固定对角质量公式覆盖两者，不约束不同坐标质量相等，需审计确认这种推广。"
  ],
  "statement_scope": "p.19首句及紧接的导数计算；后续总动量守恒是另一条，未摘录。",
  "issues": []
}
```

```lean
/-- source_id: MD-1.2-EnergyConservation · unnumbered claim · printed p.19 / PDF p.42
Original: Along Newtonian solutions the total energy is conserved and its derivative vanishes.
[EXTRA] hm: positive fixed diagonal masses for the auxiliary phase-space rewriting.
[EXTRA] hU: a differentiable potential makes the chain-rule computation meaningful.
[EXTRA] open connected time interval: comparisons are inside the solution interval.
The conclusion uses the position-velocity energy of (1.4), not only its momentum form.
The coordinate model admits arbitrary diagonal masses; physical 3D atom masses
are obtained by repeating each particle mass three times (semantic audit pending). -/
theorem MD.Ch01.energy_conservation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (q : ℝ → Position n)
    (hm : ∀ i, 0 < m i) (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x)
    (hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q) :
    (∀ t ∈ Ioo a b, HasDerivAt
      (fun s => nBodyTotalEnergy m U (q s) (deriv q s)) 0 t) ∧
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b,
      nBodyTotalEnergy m U (q s) (deriv q s) =
      nBodyTotalEnergy m U (q t) (deriv q t)
```

### 3. MD-1.3-NewtonEulerLagrange

```json
{
  "source_id": "MD-1.3-NewtonEulerLagrange",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.3",
  "printed_page": "23",
  "pdf_page": "46",
  "statement_latex": "The equations of motion may be expressed in terms of the Lagrangian as:\n\\[\\frac{\\mathrm{d}}{\\mathrm{d}t}\\frac{\\partial L}{\\partial\\dot{\\boldsymbol{q}}}=\\frac{\\partial L}{\\partial\\boldsymbol{q}}.\\]\n(Note that this must be interpreted in general as a set of $N_c=3N$ equations, one for each atomic coordinate.)",
  "proof_latex": null,
  "proof_note": "原文给出运动方程的等价表达，没有独立证明；下一段开始讨论坐标变换，不纳入本条。",
  "context_notation": [
    "$L\\stackrel{\\mathrm{def}}{=}\\dot{\\boldsymbol{q}}^TM\\dot{\\boldsymbol{q}}/2-U(\\boldsymbol{q})$，固定对角质量系统(1.3)的Lagrangian：§1.3印刷p.22/PDF45。",
    "式(1.3)与坐标数$N_c$：§1.2印刷p.18/PDF41；$\\boldsymbol{p}=\\boldsymbol{M}\\dot{\\boldsymbol{q}}$为用于复用证明的辅助相空间记号：§1.4印刷p.24/PDF47。"
  ],
  "statement_scope": "p.23首句、展示方程及完整括号说明；以真正牛顿二阶轨迹谓词给出双向等价，不仅保留旧单向定理。",
  "issues": []
}
```

```lean
/-- source_id: MD-1.3-NewtonEulerLagrange · unnumbered claim · printed p.23 / PDF p.46
Original: The Newton equations can be expressed as the Euler-Lagrange equations.
[EXTRA] hm: positive fixed diagonal masses used by the phase-space equivalence.
[EXTRA] hI: an open time domain turns within derivatives into two-sided derivatives.
[EXTRA] hU: differentiability makes ∂L/∂q a genuine gradient.
Both directions are present; the predicate enforces every coordinate equation.
The Lagrangian here is the fixed-mass L on p.22, before generalized coordinates. -/
theorem MD.Ch01.newton_iff_euler_lagrange {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q
```

### 4. MD-1.4-LegendreHamiltonian

```json
{
  "source_id": "MD-1.4-LegendreHamiltonian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "If $\\boldsymbol{M}(\\boldsymbol{q})$ is invertible, the supremum is achieved precisely when\n\\[\\boldsymbol{v}=\\boldsymbol{M}^{-1}(\\boldsymbol{q})\\boldsymbol{p},\\]\nwhich gives the standard definition of the momentum vector $\\boldsymbol{p}$ in terms of velocities,\n\\[\\boldsymbol{p}=\\frac{\\partial L}{\\partial\\dot{\\boldsymbol{q}}}=\\boldsymbol{M}(\\boldsymbol{q})\\dot{\\boldsymbol{q}},\\]\nand, with $\\boldsymbol{v}=\\boldsymbol{M}^{-1}(\\boldsymbol{q})\\boldsymbol{p}$, the Legendre transformation results in a new function\n\\[H(\\boldsymbol{q},\\boldsymbol{p})\\stackrel{\\mathrm{def}}{=}\\boldsymbol{p}^TM(\\boldsymbol{q})^{-1}\\boldsymbol{p}/2+U(\\boldsymbol{q}).\\]\nThis is precisely the energy function, written in terms of positions and momenta.",
  "proof_latex": "In the case of the Lagrangian $L(\\boldsymbol{q},\\boldsymbol{v})=\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2-U(\\boldsymbol{q})$ (which we have seen is the formulation of a mechanical system in generalized coordinates) we find\n\\[\\sup_{\\boldsymbol{v}}(\\boldsymbol{p}^T\\boldsymbol{v}-(\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2-U(\\boldsymbol{q})))=\\sup_{\\boldsymbol{v}}(\\boldsymbol{p}^T\\boldsymbol{v}-\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2)+U(\\boldsymbol{q}).\\]",
  "proof_note": "仅有上述代数推导；原文没有证明“可逆即达到上确界”或唯一性。",
  "context_notation": [
    "同页Legendre定义：凸函数$g(\\boldsymbol{\\xi}):\\mathbb{R}^m\\to\\mathbb{R}$，$\\widetilde g(\\boldsymbol{\\eta})=\\sup_{\\boldsymbol{\\xi}}(\\boldsymbol{\\eta}^T\\boldsymbol{\\xi}-g(\\boldsymbol{\\xi}))$；印刷p.24/PDF47。",
    "配置相关质量矩阵来自$\\Phi^{\\prime}(\\boldsymbol{Q})^TM\\Phi^{\\prime}(\\boldsymbol{Q})$，变化规则及满秩前提：§1.3印刷p.23/PDF46。因此对称/正定可能是继承的背景，不是“可逆”本身的推论，需独立审计裁决。",
    "$\\boldsymbol{q},\\boldsymbol{v},\\boldsymbol{p}\\in\\mathbb{R}^{N_c}$，$H$为位置和动量中的能量，§1.4印刷p.24/PDF47。"
  ],
  "statement_scope": "从“If M(q) is invertible”到“written in terms of positions and momenta.”；前一计算为proof_latex，前置抽象定义为context_notation；Hamilton方程属于下一条。",
  "issues": [
    {
      "code": "POSSIBLE_ERRATUM",
      "status": "NEEDS_HUMAN",
      "detail": "若只假设可逆，M=-1、p=0、U=0时目标=v²/2无上界；须确认同页凸性及p.23机械质量背景是否应并入假设。当前保留字面可逆陈述并标ERRATUM?，未静默加正定。"
    },
    {
      "code": "REUSE_SCOPE_GAP",
      "status": "open",
      "detail": "现有定理仅固定正对角m；本条保留任意配置相关M(q)、上界、sup、精确达到条件、动量偏导和能量对应，不能直接调用旧定理覆盖。"
    }
  ]
}
```

```lean
/-- source_id: MD-1.4-LegendreHamiltonian · unnumbered claim · printed p.24 / PDF p.47
Original: The Legendre supremum is attained precisely at M(q)⁻¹p and yields H(q,p).
[ERRATUM?] The literal invertibility premise alone does not imply a bounded objective:
M = -1, U = 0, p = 0 gives v²/2. Convexity/positive definiteness may be inherited
from the abstract convex Legendre definition and the mechanical mass model on p.23;
independent audit must settle the intended premise. It has not been silently added.
The full configuration-dependent matrix M(q) is retained. The fixed positive
diagonal library theorem cannot establish this signature. This draft is unproved.
The conjuncts keep boundedness, supremum, exact maximizing velocity, momentum
gradient, and the energy identity after the inverse-velocity substitution. -/
theorem MD.Ch01.hamiltonian_legendre_transform {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q
```

### 5. MD-1.5.1-FlowInverse

```json
{
  "source_id": "MD-1.5.1-FlowInverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "The classical systems treated here can be solved forward or backward in time. Observe that $\\mathcal{F}_{-t}\\mathcal{F}_t=\\operatorname{Id}$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $t$ form an Abelian group under the operation of composition ($\\mathcal{F}_t\\mathcal{F}_s=\\mathcal{F}_s\\mathcal{F}_t=\\mathcal{F}_{t+s}$).",
  "proof_latex": null,
  "proof_note": "原文用Observe that直接断言；没有独立证明。随后Hamiltonian守恒属于另一个结论，不纳入本条。",
  "context_notation": [
    "式(1.5)：$\\dot{\\boldsymbol{z}}=\\boldsymbol{f}(\\boldsymbol{z})$，$\\boldsymbol{z}(0)=\\boldsymbol{\\xi}$；$m$维空间及flow map定义$\\mathcal{F}_t(\\boldsymbol{\\xi})=\\boldsymbol{z}(t)$：§1.5.1印刷p.26/PDF49。",
    "正文明确继承前小节存在唯一性前提；势能下界、固定正定质量、能量限制下位置紧性：§1.5印刷p.25–26/PDF48–49。",
    "IsGlobalMechanicalFlowOn只假设逐初值全实时间ODE解、ψ 0 z=z和状态域S不变；不把反演、群律或双射藏进假设。"
  ],
  "statement_scope": "完整反演/可逆/Abelian群律段；恒等元ψ0由flow定义，结论覆盖双向反演、双射和加法/交换律。",
  "issues": []
}
```

```lean
/-- source_id: MD-1.5.1-FlowInverse · unnumbered claim · printed p.26 / PDF p.49
Original: Two-sided flow maps are inverse and form an Abelian composition group.
[EXTRA] hψ: actual all-real-time solutions, identity initial value and S-invariance;
these make the textbook's two-sided flow assumption explicit, not the group laws.
[EXTRA] hreg: C1 force for uniqueness, inherited from the preceding IVP discussion.
[EXTRA] _hm: positive fixed masses qualify the molecular Hamiltonian model.
The force is specifically -gradient U, as in the source Hamiltonian setting.
Quantification is on the invariant state domain S; no claim of global existence
for arbitrary forces or initial points outside S. Both inverses, bijectivity,
identity, addition and commutation clauses are included. -/
theorem MD.Ch01.flow_inverse {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n)
    (_hm : ∀ i, 0 < m i)
    (hψ : IsGlobalMechanicalFlowOn m (fun q => -gradient U q) Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∀ z ∈ S, ψ 0 z = z) ∧
    (∀ t : ℝ, ∀ z ∈ S, ψ (-t) (ψ t z) = z ∧ ψ t (ψ (-t) z) = z) ∧
    (∀ t : ℝ, BijOn (ψ t) S S) ∧
    ∀ s t : ℝ, ∀ z ∈ S,
      ψ t (ψ s z) = ψ s (ψ t z) ∧ ψ t (ψ s z) = ψ (t + s) z
```

## 最终唯一输出

只输出一个合法JSON数组，恰好五个对象，按上述source_id顺序各出现一次。不要Markdown围栏、开场说明、额外总结或第二个输出文件；模板B已取消。

每个对象结构如下（字段必须齐全；示例只说明结构，不能照抄占位内容）：

```json
[
  {
    "source_id": "MD-1.5.3-Thm1.1",
    "json_review": {
      "status": "PASS",
      "issue_codes": [],
      "corrected_json": null,
      "issues": [],
      "evidence": [{"printed_page": "32", "pdf_page": "55", "text": "支持判断的原页短引文"}]
    },
    "audit": {
      "lean_decl": "MD.Ch01.theorem_1_1",
      "verdict": "PASS",
      "explanation": "基于原页、A审校及实际定义的逐条理由；未验证项必须写清",
      "counterexample": null,
      "suggested_fix": null
    }
  }
]
```

PASS且无修改时corrected_json=null；REPAIRED时给出完整修订条目，保留原source_id及未改字段，不清空既有repair_log；NEEDS_HUMAN时不得猜补文本，corrected_json可为null。无反例/无需修改时相应字段为null。最终实际数组必须含全部五条，不能只返回这个示例中的一条。

用户将唯一输出保存为`blueprint/ch01/mathcopilot_results/PILOT_ALL_result.json`或`PILOT_ALL_result.md`。本地Codex随后一次性整合；不PASS或仍有未决问题的条目修复后，另用一个`PILOT_REAUDIT.md`复审任务，只含需复审条目。
