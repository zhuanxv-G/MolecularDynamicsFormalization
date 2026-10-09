# BATCH22：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：64, 65；上下文读取该节相邻页。
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

### MD-1.7.1-ChaosConditions

```json
{
  "source_id": "MD-1.7.1-ChaosConditions",
  "kind": "definition",
  "label": null,
  "section": "1.7.1",
  "printed_page": "41–42",
  "pdf_page": "64–65",
  "statement_latex": "Typical definitions of a “chaotic dynamical system” [103] require at least the following conditions to be satisfied on the phase space $D$:\n• The solutions depend sensitively on the initial data taken from $D$;\n• The flow is topologically transitive in $D$.\nThe second condition states that given arbitrarily small neighborhoods $D_1$ and $D_2$ of two different points in $D$ then it is possible to find a trajectory that goes from some point of $D_1$ to some point of $D_2$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.chaosConditions",
  "extra_assumptions": [
    "敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。",
    "topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-183",
    "CH01-184",
    "CH01-185"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```

### MD-1.7.1-TransitivityErgodicityLiteral

```json
{
  "source_id": "MD-1.7.1-TransitivityErgodicityLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.1",
  "printed_page": "42",
  "pdf_page": "65",
  "statement_latex": "We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "拓扑传递和给定测度遍历通常不等价；μ=0时identity流遍历为真而传递为假。非退化概率测度也需进一步限定。"
    }
  ],
  "lean_decl": "MD.Ch01.transitivityergodicityliteral",
  "extra_assumptions": [
    "为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-186"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem transitivityergodicityliteral :
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ)
```

### MD-1.7.1-AnisotropicOscillator

```json
{
  "source_id": "MD-1.7.1-AnisotropicOscillator",
  "kind": "definition",
  "label": "Example 1.9 (Anisotropic Oscillator)",
  "section": "1.7.1",
  "printed_page": "42",
  "pdf_page": "65",
  "statement_latex": "Consider the system with energy\n\\[E(x,y,\\dot x,\\dot y)=\\frac12(\\dot x^2+\\dot y^2)+\\frac{\\kappa(c_3)}2(r-l(c_3))^2,\\qquad r=\\sqrt{x^2+y^2},\\tag{1.9}\\]\nwhere\n\\[c_3=\\cos(3\\theta)\\]\nis defined in terms of the angular coordinate of the position $(x,y)$ with respect to the $(1,0)$-direction,\n\\[\\cos\\theta=c=\\frac xr,\\qquad c_3=4c^3-3c,\\]\nand we have defined\n\\[\\kappa(c_3)=\\kappa_0(1-\\tfrac12\\epsilon c_3),\\qquad l(c_3)=l_0(1+\\tfrac12\\epsilon c_3).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "anisotropicAngular及anisotropicParameters是本定义依赖公式；r>0；c3三倍角关系须单独核对。",
    "原文κ按PDF字形抄；数值实验κ₀=l₀=1、ε变化不转成全称轨迹定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.anisotropicEnergy",
  "extra_assumptions": [
    "定义在r=0用Lean总函数延拓，物理域r>0。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-187",
    "CH01-188",
    "CH01-189"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
