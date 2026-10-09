# BATCH04：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：34；上下文读取该节相邻页。
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

### MD-1.1.1-HeterogeneousLJ

```json
{
  "source_id": "MD-1.1.1-HeterogeneousLJ",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "11",
  "pdf_page": "34",
  "statement_latex": "When there are many atoms of different types, the parameters of the potential will depend on this, so we obtain contributions to the total potential energy of the form\n\\[\\varphi_{ij}^{\\mathrm{LJ}}(r_{ij})=4\\epsilon_{ij}\\left[\\left(\\frac{\\sigma_{ij}}{r_{ij}}\\right)^{12}-\\left(\\frac{\\sigma_{ij}}{r_{ij}}\\right)^6\\right],\\]\nwhere $r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.heterogeneousLJ",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-023"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
