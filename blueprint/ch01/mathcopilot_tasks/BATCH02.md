# BATCH02：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：28, 29, 30；上下文读取该节相邻页。
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

### MD-1.1-Schrodinger

```json
{
  "source_id": "MD-1.1-Schrodinger",
  "kind": "definition",
  "label": null,
  "section": "1.1",
  "printed_page": "5",
  "pdf_page": "28",
  "statement_latex": "The Schrödinger equation itself is a partial differential equation of the following form:\n\\[i\\hbar\\frac{\\partial\\Phi}{\\partial t}=-\\hbar^2\\sum_{j=1}^{13}\\frac{1}{2\\mu_j}\\left(\\frac{\\partial^2\\Phi}{\\partial q_{j,x}^2}+\\frac{\\partial^2\\Phi}{\\partial q_{j,y}^2}+\\frac{\\partial^2\\Phi}{\\partial q_{j,z}^2}\\right)+U_P(q_{1,x},q_{1,y},\\ldots,q_{13,z})\\Phi.\\tag{1.1}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$\\Phi:\\mathbb R\\times\\mathbb R^{39}\\to\\mathbb C$；$i^2=-1$；$\\hbar$为Planck常数；$\\mu_j$为第$j$粒子质量；$U_P$为原始原子势能。13粒子来自10电子+3核水分子示例。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.schrodingerEquation",
  "extra_assumptions": [
    "正质量及正Planck参数；按经典解解释，Φ在时间/位置联合C2，保证总导数算子表示实际偏导数；不声明解存在。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-001",
    "CH01-002",
    "CH01-003",
    "CH01-004",
    "CH01-005",
    "CH01-006"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ContDiff ℝ 2 (Function.uncurry Φ) ∧
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
```

### MD-1.1-NewtonModel

```json
{
  "source_id": "MD-1.1-NewtonModel",
  "kind": "definition",
  "label": null,
  "section": "1.1",
  "printed_page": "6",
  "pdf_page": "29",
  "statement_latex": "where the forces are determined from the potential energy function $U$. Denoting the coordinates of the $i$th nucleus of an N-atom system by $q_{i,x},q_{i,y},q_{i,z}$, and the atomic mass by $m_i$, the equations of motion for the nucleus can be written out as\n\\[m_i\\frac{\\mathrm d^2q_{i,x}}{\\mathrm dt^2}=-\\frac{\\partial U}{\\partial q_{i,x}},\\qquad m_i\\frac{\\mathrm d^2q_{i,y}}{\\mathrm dt^2}=-\\frac{\\partial U}{\\partial q_{i,y}},\\qquad m_i\\frac{\\mathrm d^2q_{i,z}}{\\mathrm dt^2}=-\\frac{\\partial U}{\\partial q_{i,z}}.\\tag{1.2}\\]\nIt is important to recognize that (1.2) does not, itself, give a complete description of the motion; it must be supplemented by initial conditions (positions and velocities given at some specified instant) for all atoms.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$U=U_{BO}$仅依赖核位置；$n=3N$，每粒子质量重复三次。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.newtonInitialValueModel",
  "extra_assumptions": [
    "n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-007",
    "CH01-008",
    "CH01-009"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def newtonInitialValueModel {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) (t₀ : ℝ)
    (q₀ v₀ : Position n) : Prop :=
  IsNewtonTrajectoryOn m U Q I q ∧ q t₀ = q₀ ∧ HasDerivAt q v₀ t₀
```

### MD-1.1-HardSphere

```json
{
  "source_id": "MD-1.1-HardSphere",
  "kind": "definition",
  "label": null,
  "section": "1.1",
  "printed_page": "7",
  "pdf_page": "30",
  "statement_latex": "The simplest model for a molecular interaction potential is the hard-sphere model. We assume that each atom is an impenetrable sphere which interacts with other atoms via perfectly elastic collision with the atoms transferring, according to standard rules, momentum and energy to one another during the collisions.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hardSphereModel",
  "extra_assumptions": [
    "只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-010"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def hardSphereModel (R₁ R₂ m₁ m₂ : ℝ) (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  0 < R₁ ∧ 0 < R₂ ∧ 0 < m₁ ∧ 0 < m₂ ∧ R₁ + R₂ ≤ dist q₁ q₂ ∧
  (dist q₁ q₂ = R₁ + R₂ →
    m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
    m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 = m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2)
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
