# BATCH19：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：59, 60；上下文读取该节相邻页。
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

### MD-1.6.1-MinimumGradientZero

```json
{
  "source_id": "MD-1.6.1-MinimumGradientZero",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "36–37",
  "pdf_page": "59–60",
  "statement_latex": "Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where\n\\[\\nabla U=0,\\]\nwhich gives in general a nonlinear system of $N_c$ equations in $N_c$ unknowns to be solved for the position vector $\\boldsymbol q^*$ associated to mechanical equilibrium.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "不限定内点及可微时，Regardless of boundary的全梯度零过强；显式[EXTRA]内点解释。"
    }
  ],
  "lean_decl": "MD.Ch01.minimumgradientzero",
  "extra_assumptions": [
    "可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-166"
  ]
}
```

```lean
theorem minimumgradientzero :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0
```

### MD-1.6.1-ForceLinearization

```json
{
  "source_id": "MD-1.6.1-ForceLinearization",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "At the equilibrium point, we can linearize the system of differential equations by computing the Hessian matrix, then we find\n\\[\\nabla U(\\boldsymbol q)\\approx U''(\\boldsymbol q^*)(\\boldsymbol q-\\boldsymbol q^*).\\]\nThen, letting $\\delta\\boldsymbol q=\\boldsymbol q-\\boldsymbol q^*$, $\\delta\\boldsymbol p$ represent small deviations from the equilibrium point at $(\\boldsymbol q,\\boldsymbol p)=(\\boldsymbol q^*,0)$, we have\n\\[\\frac{\\mathrm d\\delta\\boldsymbol q}{\\mathrm dt}=\\boldsymbol M^{-1}\\delta\\boldsymbol p,\\qquad\\frac{\\mathrm d\\delta\\boldsymbol p}{\\mathrm dt}=-U''(\\boldsymbol q^*)\\delta\\boldsymbol q.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.force_linearization",
  "extra_assumptions": [
    "真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-167",
    "CH01-168",
    "CH01-170"
  ]
}
```

```lean
theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar)
```

### MD-1.6.1-MinimumHessianLiteral

```json
{
  "source_id": "MD-1.6.1-MinimumHessianLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "At the minimum of the potential energy, $U''$ is a positive definite symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "局部极小Hessian仅半正定；U(x)=x^4在0为严格极小但二阶导数0。"
    }
  ],
  "lean_decl": "MD.Ch01.minimumhessianliteral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-169"
  ]
}
```

```lean
theorem minimumhessianliteral :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v)
```

### MD-1.6.1-ImaginarySpectrum

```json
{
  "source_id": "MD-1.6.1-ImaginarySpectrum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "The eigenvalues of the matrix\n\\[\\boldsymbol A:=\\begin{bmatrix}0&\\boldsymbol M^{-1}\\\\-U''(\\boldsymbol q^*)&0\\end{bmatrix}\\]\nare therefore all purely imaginary ($\\pm i\\Omega$, $\\Omega^2\\in\\mathbb R^+$).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.imaginary_spectrum",
  "extra_assumptions": [
    "M和Hessian K正定；复谱实虚向量编码。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-171"
  ]
}
```

```lean
theorem imaginary_spectrum :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2, -K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y →
      a = 0 ∧ 0 < b^2 ∧ A x = -b • y ∧ A (-y) = -b • x
```

### MD-1.6.1-ComplexNormalMode

```json
{
  "source_id": "MD-1.6.1-ComplexNormalMode",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "Associated to each eigenvalue pair we have a pair of complex conjugate eigenvectors $\\boldsymbol\\xi,\\overline{\\boldsymbol\\xi}$ and also a pair of solutions which can be written in the complex form\n\\[\\boldsymbol z(t)=ae^{i\\Omega t}\\boldsymbol\\xi+be^{-i\\Omega t}\\overline{\\boldsymbol\\xi},\\]\n($a,b$ complex coefficients),",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "实A确保共轭模式；两个解的复线性组合，未强迫结果为实。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.complexnormalmode",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-172"
  ]
}
```

```lean
theorem complexnormalmode :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t
```

### MD-1.6.1-RealNormalMode

```json
{
  "source_id": "MD-1.6.1-RealNormalMode",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "or recast in real form as ($\\alpha,\\beta$ real coefficients):\n\\[\\boldsymbol z(t)=\\alpha[\\sin(\\Omega t)\\operatorname{Re}(\\boldsymbol\\xi)+\\cos(\\Omega t)\\operatorname{Im}(\\boldsymbol\\xi)]+\\beta[\\cos(\\Omega t)\\operatorname{Re}(\\boldsymbol\\xi)-\\sin(\\Omega t)\\operatorname{Im}(\\boldsymbol\\xi)].\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "u=Reξ,v=Imξ，Au=-Ωv、Av=Ωu来自实矩阵复特征向量方程；realNormalMode展开即原式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.realnormalmode",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-173"
  ]
}
```

```lean
theorem realnormalmode :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ),
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
