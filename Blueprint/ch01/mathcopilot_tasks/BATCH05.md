# BATCH05：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：35, 36, 39, 40；上下文读取该节相邻页。
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

### MD-1.1.2-Coulomb

```json
{
  "source_id": "MD-1.1.2-Coulomb",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "12",
  "pdf_page": "35",
  "statement_latex": "When, as in the case of the alanine dipeptide, net charges are present on the atoms, one may model this by means of Coulomb potentials:\n\\[\\varphi_{ij}^{\\mathrm{Coulomb}}(r_{ij})=\\frac{CQ_iQ_j}{\\epsilon r_{ij}},\\]\nwhere $\\epsilon>0$ is the dielectric constant, and $Q_i,Q_j$ are the charges on atoms $i$ and $j$, respectively. $C$ is a positive coefficient allowing the adjustment of units. Obviously the effect of the Coulombic potential depends strongly on whether the atoms have the same or oppositely signed charges.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "不同电荷符号的影响是定性背景；原页没有旧清单声称的导数符号定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.coulombPotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-024",
    "CH01-025"
  ]
}
```

```lean
def coulombPotential (C Qᵢ Qⱼ dielectric r : ℝ) := C*Qᵢ*Qⱼ/(dielectric*r)
```

### MD-1.1.2-Cutoff

```json
{
  "source_id": "MD-1.1.2-Cutoff",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "12",
  "pdf_page": "35",
  "statement_latex": "In the simplest treatments, the Coulomb potential is simply cut off at distance $r_{\\mathrm{cut}}$, i.e., is taken to be zero for $r>r_{\\mathrm{cut}}$. This should be done in such a way that the potential remains at least continuously differentiable, preferably smoother (see Exercise 11).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.smoothCutoff",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-026"
  ]
}
```

```lean
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  ContDiff ℝ 1 φ ∧ ∀ r, r_cut < r → φ r = 0
```

### MD-1.1.2-Yukawa

```json
{
  "source_id": "MD-1.1.2-Yukawa",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "12",
  "pdf_page": "35",
  "statement_latex": "More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $\\kappa$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:\n\\[\\varphi_{ij}^{\\mathrm{screened}}(r_{ij})=\\frac{CQ_iQ_j}{\\epsilon r_{ij}}e^{-\\kappa r_{ij}}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "保留原文κ；不把指数改成-r/κ。原文称Debye length但式子以逆长度参数使用，待导师判断。"
  ],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文κ称Debye length，但e^{-κr}的量纲通常对应逆长度；本定义保留字面公式。"
    }
  ],
  "lean_decl": "MD.Ch01.yukawaScreened",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-027"
  ]
}
```

```lean
def yukawaScreened (C Qᵢ Qⱼ dielectric κ r : ℝ) : ℝ :=
  C * Qᵢ * Qⱼ / (dielectric * r) * Real.exp (-κ * r)
```

### MD-1.1.2-AngleBond

```json
{
  "source_id": "MD-1.1.2-AngleBond",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "13",
  "pdf_page": "36",
  "statement_latex": "When a trio of atoms with labels $i,j,k$ and $k$ admits a pair of length bonds, say $(i,j)$ and $(j,k)$, then an additional three-body term will need to be incorporated:\n\\[\\varphi_{ijk}^{\\mathrm{ang}}=\\frac{k_{ijk}^{\\mathrm{ang}}}{2}(\\theta_{ijk}-\\theta_{ijk}^0)^2,\\]\nwhere the angle $\\theta_{ijk}$ is given in terms of the positions as\n\\[\\theta_{ijk}=\\arccos\\frac{(\\boldsymbol q_i-\\boldsymbol q_j)\\cdot(\\boldsymbol q_j-\\boldsymbol q_k)}{r_{ij}r_{jk}}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "k正、两键长非零；保留原页(qᵢ-qⱼ)·(qⱼ-qₖ)方向及重复and k。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.angleBondModel",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-028",
    "CH01-029"
  ]
}
```

```lean
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2
```

### MD-1.1.2-Dihedral

```json
{
  "source_id": "MD-1.1.2-Dihedral",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "13",
  "pdf_page": "36",
  "statement_latex": "Dihedral potentials typically are modelled using a trigonometric potential function, as\n\\[\\varphi_{ijkl}^{\\mathrm{dih}}=k_{ijkl}^{\\mathrm{dih}}[1+\\cos(n_{ijkl}^{\\mathrm{dih}}\\eta_{ijkl}-d_{ijkl}^{\\mathrm{dih}})].\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "η位置角的通用转换公式原文未给；角作为参数。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.dihedralPotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-030"
  ]
}
```

```lean
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))
```

### MD-1.1.2-GayBerne

```json
{
  "source_id": "MD-1.1.2-GayBerne",
  "kind": "definition",
  "label": "Example 1.2",
  "section": "1.1.2",
  "printed_page": "16–17",
  "pdf_page": "39–40",
  "statement_latex": "The potential energy may be written as\n\\[\\varphi_{\\mathrm{GB}}(\\boldsymbol q_1,\\boldsymbol q_2,\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=4\\epsilon_{\\mathrm{GB}}\\left[\\left(\\frac{\\sigma_0}{\\Delta}\\right)^{12}-\\left(\\frac{\\sigma_0}{\\Delta}\\right)^6\\right],\\]\n\\[\\epsilon_{\\mathrm{GB}}(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=\\epsilon_1(\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)\\epsilon_2(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2),\\]\nwith\n\\[\\Delta(\\boldsymbol r,\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=\\|\\boldsymbol r\\|-\\sigma_0/\\sqrt{W(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2,\\chi)},\\]\n\\[\\epsilon_1(\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=\\epsilon_0[1-\\chi^2(\\hat{\\boldsymbol u}_1\\cdot\\hat{\\boldsymbol u}_2)^2]^{-1/2},\\qquad\\epsilon_2(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=W(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2,\\chi'),\\]\nand\n\\[W(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2,\\chi)\\stackrel{\\mathrm{def}}=1-\\frac\\chi2\\left[\\frac{(\\hat{\\boldsymbol r}\\cdot(\\hat{\\boldsymbol u}_1+\\hat{\\boldsymbol u}_2))^2}{1+\\chi\\hat{\\boldsymbol u}_1\\cdot\\hat{\\boldsymbol u}_2}+\\frac{(\\hat{\\boldsymbol r}\\cdot(\\hat{\\boldsymbol u}_1-\\hat{\\boldsymbol u}_2))^2}{1-\\chi\\hat{\\boldsymbol u}_1\\cdot\\hat{\\boldsymbol u}_2}\\right].\\]\nFinally\n\\[\\chi=\\frac{[\\sigma_e/\\sigma_s]^2-1}{[\\sigma_e/\\sigma_s]^2+1},\\qquad\\chi'=\\frac{1-[\\epsilon_e/\\epsilon_s]^{1/\\mu}}{1+[\\epsilon_e/\\epsilon_s]^{1/\\mu}}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$\\boldsymbol r=\\boldsymbol q_{12}=\\boldsymbol q_2-\\boldsymbol q_1$；$\\hat{\\boldsymbol r}=\\boldsymbol r/\\|\\boldsymbol r\\|$；两取向单位向量；各根号正、分母非零。",
    "放大PDF39原页确认εGB=ε1ε2，无平方；旧库gayBerneWell有ε2²，不能桥接，Blueprint保留忠实公式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.gayBerneModel",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-035",
    "CH01-036",
    "CH01-037",
    "CH01-038",
    "CH01-039",
    "CH01-040",
    "CH01-041",
    "CH01-042",
    "CH01-043"
  ]
}
```

```lean
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
