# BATCH07：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：43, 44, 45；上下文读取该节相邻页。
2. `blueprint/ch01/ch01_source.json`（仅审本批source_id）及 `Blueprint/Ch01.lean`（包含全部辅助定义）。
3. 依赖定义文件（核实真实定义，不能依据名称）：

```text
MolecularDynamics/BasicDefinitions.lean
MolecularDynamics/Chapter01/Continuation.lean
MolecularDynamics/Chapter01/EnergyConservation.lean
MolecularDynamics/Chapter01/EnergyGlobalExistence.lean
MolecularDynamics/Chapter01/Equilibrium.lean
MolecularDynamics/Chapter01/EquilibriumLinearization.lean
MolecularDynamics/Chapter01/EuclideanStability.lean
MolecularDynamics/Chapter01/FirstIntegralGraph.lean
MolecularDynamics/Chapter01/FirstIntegralQuadrature.lean
MolecularDynamics/Chapter01/FirstIntegrals.lean
MolecularDynamics/Chapter01/FutureFlow.lean
MolecularDynamics/Chapter01/GeneralizedCoordinates.lean
MolecularDynamics/Chapter01/GlobalContinuation.lean
MolecularDynamics/Chapter01/GlobalFlow.lean
MolecularDynamics/Chapter01/Hamiltonian.lean
MolecularDynamics/Chapter01/HamiltonianHessian.lean
MolecularDynamics/Chapter01/HarmonicActionAngle.lean
MolecularDynamics/Chapter01/HarmonicOscillator.lean
MolecularDynamics/Chapter01/HarmonicTorus.lean
MolecularDynamics/Chapter01/Kepler.lean
MolecularDynamics/Chapter01/KeplerCartesianBridge.lean
MolecularDynamics/Chapter01/KeplerPolarDynamics.lean
MolecularDynamics/Chapter01/KeplerQuadrature.lean
MolecularDynamics/Chapter01/KeplerReconstruction.lean
MolecularDynamics/Chapter01/Lagrangian.lean
MolecularDynamics/Chapter01/LatticePairPotential.lean
MolecularDynamics/Chapter01/LegendreTransform.lean
MolecularDynamics/Chapter01/LinearFlow.lean
MolecularDynamics/Chapter01/LinearizedHamiltonian.lean
MolecularDynamics/Chapter01/LocalExistence.lean
MolecularDynamics/Chapter01/LocalTrajectories.lean
MolecularDynamics/Chapter01/MatrixFlow.lean
MolecularDynamics/Chapter01/MechanicalConfinement.lean
MolecularDynamics/Chapter01/MechanicalContinuation.lean
MolecularDynamics/Chapter01/MomentumBounds.lean
MolecularDynamics/Chapter01/MomentumConservation.lean
MolecularDynamics/Chapter01/NBody.lean
MolecularDynamics/Chapter01/ODEEndpoint.lean
MolecularDynamics/Chapter01/ParticleCoordinates.lean
MolecularDynamics/Chapter01/PhaseMetric.lean
MolecularDynamics/Chapter01/PlanarAngularMomentum.lean
MolecularDynamics/Chapter01/PolarCoordinateMap.lean
MolecularDynamics/Chapter01/PolarCoordinates.lean
MolecularDynamics/Chapter01/PotentialBarriers.lean
MolecularDynamics/Chapter01/PotentialRegularity.lean
MolecularDynamics/Chapter01/RealSpectralFlow.lean
MolecularDynamics/Chapter01/ReviewDefinitions.lean
MolecularDynamics/Chapter01/ReviewProofs.lean
MolecularDynamics/Chapter01/ScalarIntegrability.lean
MolecularDynamics/Chapter01/ScalarLocalIVP.lean
MolecularDynamics/Chapter01/ScalarTurning.lean
MolecularDynamics/Chapter01/SeparableQuadrature.lean
MolecularDynamics/Chapter01/Stability.lean
MolecularDynamics/Chapter01/Statements.lean
MolecularDynamics/Chapter01/TimeReversal.lean
MolecularDynamics/Chapter01/TorusDensity.lean
MolecularDynamics/Chapter01/TorusPeriod.lean
MolecularDynamics/Chapter01/VariationalEquation.lean
MolecularDynamics/Notation.lean
```

Lean4.34.0 / Mathlib v4.34.0。完整输入哈希见MANIFEST.json；本地审计不能替代你的网站独立审计。

## 第一部分：模板A 原文审校

逐条打开PDF原页，逐字核对statement_latex、proof_latex、页码及上下文；不把CSV转述当原文。不得静默纠正原书。若问题仅为原书疑误，保留原文并标记ISSUE。不得伪造证明；proof_latex=null表示无独立完整证明。status仅APPROVED / CORRECTED / NEEDS_HUMAN；issue_codes、issues及evidence给出页码和具体原文依据。corrected_json为完整修正版条目，无需修订则null。

## 第二部分：模板C 只读语义审计

基于A审校后的原文，逐条核对真实Lean定义展开、对象/域/量词/前提/全部结论；判断[EXTRA]是否合理，不能接受True、P→P、结论作前提或偷换对象。证明是否sorry与签名语义判定分开；只读，不修文件不写证明。verdict仅PASS / FAIL / NEEDS_HUMAN；反例有则明确给出，建议修复须指出缺失或强化；原文错误不得静默改成真命题。

## 本批输入

### MD-1.2-ScalarQuadrature

```json
{
  "source_id": "MD-1.2-ScalarQuadrature",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "20",
  "pdf_page": "43",
  "statement_latex": "Near this point, provided $\\eta\\ne0$, let us solve the equation $E(x,v)=E(\\xi,\\eta)$ for $v$ as a unique smooth function of $x,\\xi,\\eta$ using the implicit function theorem: $v=V(x,\\xi,\\eta)$. Inserting this into the differential equations we then find\n\\[\\frac{\\mathrm dx}{\\mathrm dt}=v=V(x,\\xi,\\eta).\\]\nThis is a separable differential equation; it is therefore easily integrated from any provided initial value, $x(0)=\\xi$, as a function of $t$, resulting in a relation $x=X(t,\\xi,\\eta)$. Then $v=V(X(t,\\xi,\\eta),\\xi,\\eta)$ and we see that it is possible to derive the formula for the solution $(x,v)$ as a function of $t$ and the initial conditions.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "HasScalarQuadratureRepresentation保留真实积分原函数、局部逆与逆等式。原文只对给定ξ,η说明；联合参数光滑性尚未完整登记。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.scalarquadrature",
  "extra_assumptions": [
    "U C2满足局部隐函数/唯一性资格；局部时间窗；非转向分支对应原文η≠0，其余分支为额外加强。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-065",
    "CH01-066"
  ]
}
```

```lean
theorem scalarquadrature :
  ∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (z₀ : ℝ × ℝ) (t₀ : ℝ),
    ∃ (ε : ℝ) (γ : ℝ → ℝ × ℝ), 0 < ε ∧ γ t₀ = z₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), HasDerivAt γ (scalarPotentialVectorField U (γ t)) t) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), scalarPotentialEnergy U (γ t) = scalarPotentialEnergy U z₀) ∧
      ScalarPotentialLocalDescription U γ (t₀ - ε) (t₀ + ε) t₀
```

### MD-1.2-UniformLJSystem

```json
{
  "source_id": "MD-1.2-UniformLJSystem",
  "kind": "definition",
  "label": "Example 1.5",
  "section": "1.2",
  "printed_page": "21",
  "pdf_page": "44",
  "statement_latex": "The energy of the system is\n\\[E=\\frac12\\sum_{i=1}^{N}m\\dot{\\boldsymbol q}_i^2+\\sum_{i=1}^{N-1}\\sum_{j=i+1}^{N}\\varphi_{\\mathrm{LJ}}(r_{ij}),\\]\nwhere $r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|$ and the mass $m$ of an argon atom is $6.69\\times10^{-26}$ kg.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "物理数值m只是原文参数背景，不形式化测量准确性；pairDistance=rij。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.uniformLJSystem",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-068"
  ]
}
```

```lean
def uniformLJSystem {N : ℕ} (m ε σ : ℝ) (q v : Fin N → V3) : ℝ :=
  (∑ i, m * ‖v i‖^2 / 2) + uniformLJEnergy ε σ q
```

### MD-1.2-RadialLJForceLiteral

```json
{
  "source_id": "MD-1.2-RadialLJForceLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "21",
  "pdf_page": "44",
  "statement_latex": "The equations of motion are, for $i=1,2,\\ldots,N$, using the chain rule,\n\\[m\\ddot{\\boldsymbol q}_i=\\sum_{j=1,\\ j\\ne i}^{N}\\frac{\\varphi'_{\\mathrm{LJ}}(r_{ij})}{r_{ij}}(\\boldsymbol q_i-\\boldsymbol q_j)\n=-24\\frac\\epsilon\\sigma\\sum_{j=1,\\ j\\ne i}^{N}r_{ij}^{-1}\\left[2\\left(\\frac\\sigma{r_{ij}}\\right)^{13}-\\left(\\frac\\sigma{r_{ij}}\\right)^7\\right](\\boldsymbol q_i-\\boldsymbol q_j).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "首个等式缺负号；所印次行实际为势的正梯度，不同于此前Newton负梯度。"
    }
  ],
  "lean_decl": "MD.Ch01.radial_lj_force_literal",
  "extra_assumptions": [
    "正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-069"
  ]
}
```

```lean
theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j))
```

### MD-1.2-LJCoordinateScaling

```json
{
  "source_id": "MD-1.2-LJCoordinateScaling",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "21",
  "pdf_page": "44",
  "statement_latex": "Now introduce the change of variables\n\\[\\boldsymbol Q_i=\\sigma^{-1}\\boldsymbol q_i,\\qquad i=1,2,\\ldots,N,\\]\nthen $\\dot{\\boldsymbol q}_i=\\sigma\\dot{\\boldsymbol Q}_i$, $\\ddot{\\boldsymbol q}_i=\\sigma\\ddot{\\boldsymbol Q}_i$, and $\\|\\boldsymbol q_i-\\boldsymbol q_j\\|=\\sigma\\|\\boldsymbol Q_i-\\boldsymbol Q_j\\|$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lj_coordinate_scaling",
  "extra_assumptions": [
    "σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-199"
  ]
}
```

```lean
theorem lj_coordinate_scaling (Q : ℝ → V3) (σ t : ℝ) (v a : V3)
    (hσ : 0 < σ) (hv : HasDerivAt Q v t) (ha : HasDerivAt (deriv Q) a t) :
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
    HasDerivAt (fun s => σ • deriv Q s) (σ • a) t ∧
    ∀ r s : V3, ‖σ • r - σ • s‖ = σ * ‖r-s‖
```

### MD-1.2-LJTimeScaling

```json
{
  "source_id": "MD-1.2-LJTimeScaling",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "21–22",
  "pdf_page": "44–45",
  "statement_latex": "Thus we see that if we make the additional time transformation\n\\[\\tau=\\alpha t,\\qquad\\alpha^2=\\frac\\epsilon{m\\sigma^2},\\]\nthen the equations become\n\\[\\frac{\\mathrm d^2\\boldsymbol Q_i}{\\mathrm d\\tau^2}=-\\sum_{j=1,\\ j\\ne i}^{N}\\frac{\\hat\\varphi'_{\\mathrm{LJ}}(R_{ij})}{R_{ij}}(\\boldsymbol Q_i-\\boldsymbol Q_j).\\]\nThis means that a natural choice for the unit of time is\n\\[\\alpha^{-1}=\\sigma\\sqrt{\\frac m\\epsilon}\\approx2.17\\times10^{-12}\\mathrm s.\\]\nBy using the units given here, we may work with a simplified form of the Lennard-Jones system involving unit masses and a parameter-independent potential energy function.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$R_{ij}=\\|\\boldsymbol Q_i-\\boldsymbol Q_j\\|$；$\\hat\\varphi_{LJ}(R)=4[R^{-12}-R^{-6}]$。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.ljtimescaling",
  "extra_assumptions": [
    "m,ε,σ,α正；真实C2非碰撞轨迹。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-200"
  ]
}
```

```lean
theorem ljtimescaling :
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    (((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)) ∧
    α⁻¹ = σ * Real.sqrt (m / ε)
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
