# BATCH08：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：45, 46；上下文读取该节相邻页。
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

### MD-1.3-Lagrangian

```json
{
  "source_id": "MD-1.3-Lagrangian",
  "kind": "definition",
  "label": null,
  "section": "1.3",
  "printed_page": "22",
  "pdf_page": "45",
  "statement_latex": "For the system (1.3) with N atoms and $N_c=3N$ configuration coordinates, the Lagrangian is\n\\[L\\stackrel{\\mathrm{def}}=\\frac{\\dot{\\boldsymbol q}^{T}\\boldsymbol M\\dot{\\boldsymbol q}}2-U(\\boldsymbol q).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "固定对角M；n=Nc，三维按质量重复坐标。nBodyKineticEnergy_eq_inner给出矩阵二次式一致性。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.fixedMassLagrangian",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-070"
  ]
}
```

```lean
def fixedMassLagrangian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := nBodyKineticEnergy m v - U q
```

### MD-1.3-GeneralizedCoordinates

```json
{
  "source_id": "MD-1.3-GeneralizedCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.3",
  "printed_page": "23",
  "pdf_page": "46",
  "statement_latex": "When we introduce a smooth change of variables $\\boldsymbol q=\\boldsymbol\\Phi(\\boldsymbol Q)$, where $\\boldsymbol\\Phi:\\mathbb R^{N_c}\\to\\mathbb R^{N_c}$, this induces a corresponding transformation of the velocity vector by\n\\[\\dot{\\boldsymbol q}=\\boldsymbol\\Phi'(\\boldsymbol Q)\\dot{\\boldsymbol Q},\\]\nwhere $\\boldsymbol\\Phi'$ is the $N_c\\times N_c$ Jacobian matrix of $\\boldsymbol\\Phi$. Then the Lagrangian of the system is transformed to\n\\[\\widetilde L=\\frac{\\dot{\\boldsymbol Q}^{T}\\boldsymbol\\Phi'(\\boldsymbol Q)^{T}\\boldsymbol M\\boldsymbol\\Phi'(\\boldsymbol Q)\\dot{\\boldsymbol Q}}2-U(\\boldsymbol\\Phi(\\boldsymbol Q)),\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "J=Φ′(Q)真实Frechet导数；generalizedMassMatrix=JᵀMJ；后段允许k=Nd≤Nc参数化约束流形。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.generalized_coordinates",
  "extra_assumptions": [
    "原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-074",
    "CH01-075",
    "CH01-076",
    "CH01-077"
  ]
}
```

```lean
theorem generalized_coordinates {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t ∧
    massLagrangian m U (Φ (q t)) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ (q t))
```

### MD-1.3-GeneralizedMassRegular

```json
{
  "source_id": "MD-1.3-GeneralizedMassRegular",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.3",
  "printed_page": "23",
  "pdf_page": "46",
  "statement_latex": "We will assume that any such changes of variables are regular transformations in the sense that $\\boldsymbol\\Phi'$ is of full rank and the resulting generalized mass matrix is invertible.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "这是原文模型假设及其由正定质量推出的关系，不假设结论可逆。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.generalizedmassregular",
  "extra_assumptions": [
    "正粒子质量；full rank为Jacobian列单射，符合n≥k。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-078"
  ]
}
```

```lean
theorem generalizedmassregular :
  ∀ {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec),
    IsUnit (generalizedMassMatrix m J)
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
