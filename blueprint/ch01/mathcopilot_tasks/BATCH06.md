# BATCH06：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：41, 42, 43；上下文读取该节相邻页。
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

### MD-1.2-NewtonCompact

```json
{
  "source_id": "MD-1.2-NewtonCompact",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "In this book, we shall frequently use a compact, vectorial notation, where $\\boldsymbol q$ and $\\dot{\\boldsymbol q}$ represent vectors of the positions and velocities, and $\\boldsymbol M$ is a diagonal mass matrix, so the equations of motion (1.2) become\n\\[\\boldsymbol M\\frac{\\mathrm d^2}{\\mathrm dt^2}\\boldsymbol q=\\boldsymbol F(\\boldsymbol q)=-\\nabla U(\\boldsymbol q).\\tag{1.3}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$N_c=3N$；$\\boldsymbol M=\\operatorname{diag}(m_1,m_1,m_1,\\ldots,m_N,m_N,m_N)$；一维时$N_c=N$。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.compactNewton",
  "extra_assumptions": [
    "真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-044",
    "CH01-045",
    "CH01-046",
    "CH01-047",
    "CH01-048",
    "CH01-049",
    "CH01-050"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)
```

### MD-1.2-DegreesFreedom

```json
{
  "source_id": "MD-1.2-DegreesFreedom",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $N_d$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.degreesOfFreedom",
  "extra_assumptions": [
    "在可微约束C局部正则层中以导数核维数表示；无约束取零约束。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-051"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)
```

### MD-1.2-ConstraintDimension

```json
{
  "source_id": "MD-1.2-ConstraintDimension",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "For the N-body system in $\\mathbb R^3$ without additional constraints there are $N_d=N_c=3N$ degrees of freedom. If $r$ independent constraints are present the number of degrees of freedom is $N_d=N_c-r$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.constraintdimension",
  "extra_assumptions": [
    "约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-052"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem constraintdimension :
  ∀ (n r : ℕ) (C : Position n → Position r) (q : Position n),
    DifferentiableAt ℝ C q → Function.Surjective (fderiv ℝ C q) →
    degreesOfFreedom C q + r = n
```

### MD-1.2-TotalEnergy

```json
{
  "source_id": "MD-1.2-TotalEnergy",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "The total energy of the N-body system is a function of positions and velocities,\n\\[E(\\boldsymbol q_1,\\ldots,\\boldsymbol q_N,\\dot{\\boldsymbol q}_1,\\ldots,\\dot{\\boldsymbol q}_N)=\\sum_{j=1}^{N}\\frac{m_j\\|\\dot{\\boldsymbol q}_j\\|^2}{2}+U(\\boldsymbol q_1,\\ldots,\\boldsymbol q_N).\\tag{1.4}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "斜体E为函数，直立E为守恒能量值；动能是有限和。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.particleTotalEnergy",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-053",
    "CH01-054",
    "CH01-057"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q
```

### MD-1.2-PairCancellation

```json
{
  "source_id": "MD-1.2-PairCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19",
  "pdf_page": "42",
  "statement_latex": "This means that the sum of all the forces will vanish.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "前文Newton第三定律：i作用j的力是j作用i的力的exact negative。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.paircancellation",
  "extra_assumptions": [
    "Fi i=0，内部两体力反对称；无外力。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-058"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem paircancellation :
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0
```

### MD-1.2-MomentumConservation

```json
{
  "source_id": "MD-1.2-MomentumConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19",
  "pdf_page": "42",
  "statement_latex": "and thus the three components of the total momentum vector $\\boldsymbol p_{\\mathrm{tot}}:=\\sum_{i=1}^{N}\\boldsymbol p_i$ will be conserved quantities.",
  "proof_latex": "Since\n\\[\\frac{\\mathrm d\\boldsymbol p_i}{\\mathrm dt}=\\boldsymbol F_i,\\]\nwe have\n\\[\\sum_{i=1}^{N}\\frac{\\mathrm d\\boldsymbol p_i}{\\mathrm dt}=\\sum_{i=1}^{N}\\boldsymbol F_i=0\\]",
  "proof_note": "按渲染原页逐字转录原文论证。",
  "context_notation": [
    "p=m qdot，三维d=3，任意d为推广；IsMechanicalSolutionOn是真正时间微分方程。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.momentum_conservation",
  "extra_assumptions": [
    "真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-059",
    "CH01-060",
    "CH01-061"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem momentum_conservation :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i
```

### MD-1.2-HarmonicSolution

```json
{
  "source_id": "MD-1.2-HarmonicSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19–20",
  "pdf_page": "42–43",
  "statement_latex": "Example 1.3 (Harmonic Oscillator) Consider the system\n\\[\\dot x=v,\\qquad\\dot v=-\\Omega^2x.\\]\nThis system describes the behavior of a particle with unit mass in one dimension, with energy function $E(x,\\dot x)=\\dot x^2/2+\\Omega^2x^2/2$, where its motion is governed by a linear 2nd order equation $\\ddot x+\\Omega^2x=0$. The solution, for given $x(0)=\\xi$, $\\dot x(0)=v(0)=\\eta$, is\n\\[x(t)=\\xi\\cos(\\Omega t)+\\frac\\eta\\Omega\\sin(\\Omega t).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "harmonicFlow同时给出位置与实际动量/速度；harmonicFlow_zero保证初值。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.harmonic_solution",
  "extra_assumptions": [
    "Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-062",
    "CH01-063"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    ∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2
```

### MD-1.2-ScalarMechanical

```json
{
  "source_id": "MD-1.2-ScalarMechanical",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "20",
  "pdf_page": "43",
  "statement_latex": "Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $m=1$ for simplicity) and energy function $E(x,\\dot x)=\\dot x^2/2+U(x)$ (which includes the harmonic oscillator as a special case). The equations of motion are\n\\[\\dot x=v,\\qquad\\dot v=-\\frac{\\partial U}{\\partial x}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "scalarPotentialEnergy U z = z.2²/2+U z.1；定义方程不宣称解存在。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.scalarMechanicalModel",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-064"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

```lean
def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, HasDerivAt z ((z t).2, -deriv U (z t).1) t
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
