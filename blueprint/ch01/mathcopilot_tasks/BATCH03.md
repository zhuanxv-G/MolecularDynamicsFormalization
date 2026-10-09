# BATCH03：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：31, 32, 33, 34；上下文读取该节相邻页。
2. `blueprint/ch01/ch01_source.json`（仅审本批source_id）及 `Blueprint/Ch01.lean`（包含全部辅助定义）。
3. 依赖定义文件（核实真实定义，不能依据名称）：

```text
MolecularDynamics/BasicDefinitions.lean
MolecularDynamics/Chapter01/BasisMatrix.lean
MolecularDynamics/Chapter01/ComplexSpectralFlow.lean
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
MolecularDynamics/Chapter01/LatticeVibrations.lean
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
MolecularDynamics/Chapter01/NormalModes.lean
MolecularDynamics/Chapter01/ODEEndpoint.lean
MolecularDynamics/Chapter01/ParticleCoordinates.lean
MolecularDynamics/Chapter01/PhaseMetric.lean
MolecularDynamics/Chapter01/PlanarAngularMomentum.lean
MolecularDynamics/Chapter01/PolarCoordinateMap.lean
MolecularDynamics/Chapter01/PolarCoordinates.lean
MolecularDynamics/Chapter01/PotentialBarriers.lean
MolecularDynamics/Chapter01/PotentialRegularity.lean
MolecularDynamics/Chapter01/RealRecoveryFlow.lean
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

### MD-1.1.1-Multibody

```json
{
  "source_id": "MD-1.1.1-Multibody",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "8",
  "pdf_page": "31",
  "statement_latex": "In the most common situations, the potential energy function consists of a sum of 2-body, 3-body and/or 4-body terms,\n\\[U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j),\\qquad U_{ijk}(\\boldsymbol q_i,\\boldsymbol q_j,\\boldsymbol q_k),\\qquad U_{ijkl}(\\boldsymbol q_i,\\boldsymbol q_j,\\boldsymbol q_k,\\boldsymbol q_l),\\]\nwhere $\\boldsymbol q_i$ is the position vector of atom $i$ such that $(q_{i,x},q_{i,y},q_{i,z})=\\boldsymbol q_i\\in\\mathbb R^3$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.multibodyPotential",
  "extra_assumptions": [
    "按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-011",
    "CH01-012",
    "CH01-013",
    "CH01-014"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def multibodyPotential {N : ℕ} (U₂ : Fin N → Fin N → V3 → V3 → ℝ)
    (U₃ : Fin N → Fin N → Fin N → V3 → V3 → V3 → ℝ)
    (U₄ : Fin N → Fin N → Fin N → Fin N → V3 → V3 → V3 → V3 → ℝ)
    (q : Fin N → V3) : ℝ :=
  (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, ∑ l ∈ Finset.Ioi k,
    U₄ i j k l (q i) (q j) (q k) (q l))
```

### MD-1.1.1-Morse

```json
{
  "source_id": "MD-1.1.1-Morse",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "8",
  "pdf_page": "31",
  "statement_latex": "A simple potential energy function whose graph can be used to approximate the potential energy of bond dissociation is the Morse potential\n\\[\\varphi_{\\mathrm{Morse}}(r)=D\\left(1-e^{-a(r-r_e)}\\right)^2.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$D,a,r_e>0$为物理参数；$r>0$为核距离。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.morsePotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-015"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2
```

### MD-1.1.1-MorseMinimum

```json
{
  "source_id": "MD-1.1.1-MorseMinimum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.1.1",
  "printed_page": "8",
  "pdf_page": "31",
  "statement_latex": "(See Fig. 1.5.) $r_e$ is the location of the minimum, $D$ gives the well depth, and $a$ is a shape parameter that can be used to control the curvature at the minimum.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "a controls curvature为定性形状参数说明，合并为Morse定义背景；原页无二阶导数公式，不凭计算添加原文公式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.morse_minimum",
  "extra_assumptions": [
    "D,a,rₑ正；well depth解释为无穷远极限减最小值。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-016"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem morse_minimum :
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D)
```

### MD-1.1.1-LengthBond

```json
{
  "source_id": "MD-1.1.1-LengthBond",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "9",
  "pdf_page": "32",
  "statement_latex": "Because they often do not need to be allowed to break during simulation and are very strong compared to the other potential terms, chemical bonds such as the covalent $\\mathrm H_2^+$ bond described above are sometimes treated as springs with given rest-length:\n\\[\\varphi_{ij}^{\\mathrm{len}}(r_{ij})=\\frac{k_{ij}^{\\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\\qquad r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|$；Lean pairDistance；$k>0$，$r_0$静长。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lengthBond",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-017",
    "CH01-018"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def lengthBond (k r₀ r : ℝ) := k / 2 * (r-r₀)^2
```

### MD-1.1.1-Dispersion

```json
{
  "source_id": "MD-1.1.1-Dispersion",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "10",
  "pdf_page": "33",
  "statement_latex": "This leads to an instantaneous polarization and an attractive interaction termed London dispersion; it is most often modelled using an inverse sixth power potential:\n\\[\\varphi_{\\mathrm{disp}}(r)\\sim-\\frac K{r^6},\\qquad K>0.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$r>0$；$\\sim$表示经验模型形式，此def只定义右侧模型。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.dispersionPotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-019"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def dispersionPotential (K r : ℝ) := -K / r^6
```

### MD-1.1.1-Buckingham

```json
{
  "source_id": "MD-1.1.1-Buckingham",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "10",
  "pdf_page": "33",
  "statement_latex": "Buckingham [56] suggested a combined potential of the form\n\\[\\varphi_B(r)=Ae^{-Br}-\\frac C{r^6},\\qquad A>0,\\ B>0,\\ C>0.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$r>0$；参数正。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.buckinghamPotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-020"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def buckinghamPotential (A B C r : ℝ) := A * Real.exp (-B*r) - C/r^6
```

### MD-1.1.1-LennardJones

```json
{
  "source_id": "MD-1.1.1-LennardJones",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "10",
  "pdf_page": "33",
  "statement_latex": "A more common choice in simulation is the Lennard-Jones (6–12) potential\n\\[\\varphi_{\\mathrm{LJ}}(r)=4\\epsilon\\left[\\left(\\frac\\sigma r\\right)^{12}-\\left(\\frac\\sigma r\\right)^6\\right].\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$\\epsilon,\\sigma,r>0$。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lennardJonesPotential",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-021"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

### MD-1.1.1-LJRepulsion

```json
{
  "source_id": "MD-1.1.1-LJRepulsion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.1.1",
  "printed_page": "10–11",
  "pdf_page": "33–34",
  "statement_latex": "Because of the strongly repulsive character of short-ranged soft walls in molecular dynamics, i.e., the fact that $\\varphi_{\\mathrm{LJ}}$ tends rapidly to positive infinity as $r\\to0$, the atoms remain well separated in long simulations. The singularity at $r=0$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "数学结论是原文r→0极限；长模拟保持分离为定性经验，不升级为有限能量全局无碰撞定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lj_repulsion",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-022"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem lj_repulsion :
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
