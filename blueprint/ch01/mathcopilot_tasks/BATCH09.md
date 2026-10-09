# BATCH09：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：47, 48；上下文读取该节相邻页。
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

### MD-1.4-ConvexLegendre

```json
{
  "source_id": "MD-1.4-ConvexLegendre",
  "kind": "definition",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "Abstractly, a Legendre transformation of a given convex function $g=g(\\boldsymbol\\xi):\\mathbb R^m\\to\\mathbb R$ is a new function $\\widetilde g=\\widetilde g(\\boldsymbol\\eta):\\mathbb R^m\\to\\mathbb R$ defined by\n\\[\\widetilde g(\\boldsymbol\\eta)=\\sup_{\\boldsymbol\\xi}(\\boldsymbol\\eta^T\\boldsymbol\\xi-g(\\boldsymbol\\xi)),\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文给任意凸g却称共轭R值；g=0,η≠0时上确界+∞。Blueprint保留sup定义并显式扩展值域，须导师裁定是否接受。"
    }
  ],
  "lean_decl": "MD.Ch01.legendreTransform",
  "extra_assumptions": [
    "值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-079"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)
```

### MD-1.4-HamiltonEquations

```json
{
  "source_id": "MD-1.4-HamiltonEquations",
  "kind": "definition",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "The equations of motion can be written\n\\[\\dot{\\boldsymbol q}=\\frac{\\partial H}{\\partial\\boldsymbol p},\\qquad\\dot{\\boldsymbol p}=-\\frac{\\partial H}{\\partial\\boldsymbol q}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "速度与动量导数均是真导数；H可微的模型背景在使用时另给资格。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hamiltonEquations",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-084"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t, HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t
```

### MD-1.4-HamiltonFixedMass

```json
{
  "source_id": "MD-1.4-HamiltonFixedMass",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "For constant $\\boldsymbol M$ we obtain the dynamical equations,\n\\[\\dot{\\boldsymbol q}=\\boldsymbol M^{-1}\\boldsymbol p,\\qquad\\dot{\\boldsymbol p}=\\boldsymbol F=-\\partial U/\\partial\\boldsymbol q.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hamilton_fixed_mass",
  "extra_assumptions": [
    "常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-085"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem hamilton_fixed_mass {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun v => variableMassHamiltonian (fun _ => M) U q v)
      (matrixAction M⁻¹ p) p ∧
    HasGradientAt (fun x => variableMassHamiltonian (fun _ => M) U x p)
      (gradient U q) q
```

### MD-1.4-HamiltonLagrangeEquivalence

```json
{
  "source_id": "MD-1.4-HamiltonLagrangeEquivalence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.4",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "More generally, for molecular models, the Hamiltonian and Lagrangian formulations are interchangeable, but the use of the Hamiltonian form is preferred for allowing simplified description of the geometric character of the solutions of the system as we discuss in Chaps. 2–4.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hamiltonlagrangeequivalence",
  "extra_assumptions": [
    "一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-086"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem hamiltonlagrangeequivalence :
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t)
```

### MD-1.4-PhaseSpace

```json
{
  "source_id": "MD-1.4-PhaseSpace",
  "kind": "definition",
  "label": null,
  "section": "1.4",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $\\mathbb R^3$ is described by coordinates and positions, i.e., by a point in $\\mathbb R^{6N}$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "p.25原句described by coordinates and positions字面重复位置；前句定义是positions and momenta，Lean按前句定义保留位置×动量，原句不静默改字。"
    }
  ],
  "lean_decl": "MD.Ch01.finiteEnergyPhaseDomain",
  "extra_assumptions": [
    "采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-087",
    "CH01-088"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
