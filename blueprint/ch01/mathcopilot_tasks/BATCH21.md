# BATCH21：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：61, 62, 63, 64；上下文读取该节相邻页。
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

### MD-1.7-IsoscelesEnergyReduction

```json
{
  "source_id": "MD-1.7-IsoscelesEnergyReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "reducing the energy to\n\\[E=\\dot x^2+\\frac{\\dot y^2}{3}+2\\hat\\varphi_{\\mathrm{LJ}}\\left(\\sqrt{x^2+y^2}\\right)+\\hat\\varphi_{\\mathrm{LJ}}(2x),\\]\nwhich describes the vibrational motion.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.isosceles_energy_reduction",
  "extra_assumptions": [
    "单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-181"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w
```

### MD-1.7-IsoscelesAccessibleRegion

```json
{
  "source_id": "MD-1.7-IsoscelesAccessibleRegion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "kinetic energy is non-negative, we must have\n\\[2\\hat\\varphi_{\\mathrm{LJ}}\\left(\\sqrt{x^2+y^2}\\right)+\\hat\\varphi_{\\mathrm{LJ}}(2x)\\le E.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.isoscelesaccessibleregion",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-182"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem isoscelesaccessibleregion :
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E
```

### MD-1.7-EquilateralTrimerMinimum

```json
{
  "source_id": "MD-1.7-EquilateralTrimerMinimum",
  "kind": "unnumbered_claim",
  "label": "Example 1.8 (Planar Lennard-Jones Trimer)",
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "The global minimum of this simple system must be radially symmetric. Placing the atoms at the vertices of an equilateral triangle, we have\n\\[U=3\\hat\\varphi_{\\mathrm{LJ}}(r),\\]\nwhere $r$ is the length of a side. This is minimized when $r=2^{1/6}\\approx1.1225$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.equilateraltrimerminimum",
  "extra_assumptions": [
    "单位LJ；非碰撞配置。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-203"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem equilateraltrimerminimum :
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6))
```

### MD-1.7-TrimerEnergyLowerBound

```json
{
  "source_id": "MD-1.7-TrimerEnergyLowerBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "(When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "本条为E<-3不可达；E>0逃逸下一条字面保留。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.trimerenergylowerbound",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-204"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem trimerenergylowerbound :
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q
```

### MD-1.7-CollinearTrimer

```json
{
  "source_id": "MD-1.7-CollinearTrimer",
  "kind": "definition",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "Arranging the three atoms in a collinear configuration ($y=0$) the potential energy becomes $\\hat U=\\hat U(x)=2\\hat\\varphi_{\\mathrm{LJ}}(x)+\\hat\\varphi_{\\mathrm{LJ}}(2x)$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "x>0；本def逐字记录共线模型。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.collinearTrimer",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-205"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
```

### MD-1.7-TrimerSaddle

```json
{
  "source_id": "MD-1.7-TrimerSaddle",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40–41",
  "pdf_page": "63–64",
  "statement_latex": "Minimizing the potential in the collinear configuration allows us to determine the saddle point $(x^*,0)$. Near this point, $U$ decreases if we move in the $\\pm y$ direction and increases if we move in the $\\pm x$ direction.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.trimersaddle",
  "extra_assumptions": [
    "x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-206"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem trimersaddle :
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0
```

### MD-1.7-TrimerEscapeLiteral

```json
{
  "source_id": "MD-1.7-TrimerEscapeLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "(When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "every body逃逸字面过强：取等腰退化为共线y≡0，q₁=(x,0,0)、q₂=(-x,0,0)、q₃=0，中心粒子合力零，质心/动量/角动量均零；x>1的外向正能量解使外侧两粒子逃逸而中心始终固定。需裁定是否改为至少一对分离。"
    }
  ],
  "lean_decl": "MD.Ch01.trimerescapeliteral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-207"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem trimerescapeliteral :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
