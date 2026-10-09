# BATCH23：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：67, 68；上下文读取该节相邻页。
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

### MD-1.7.2-FlowJacobianLiteral

```json
{
  "source_id": "MD-1.7.2-FlowJacobianLiteral",
  "kind": "definition",
  "label": null,
  "section": "1.7.2",
  "printed_page": "44",
  "pdf_page": "67",
  "statement_latex": "Let a dynamical system $\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z)$ be given in $\\mathbb R^m$ with flow map $F_t:\\mathbb R^m\\to\\mathbb R^m$ which we assume to be continuously differentiable. Let $\\boldsymbol z(t,\\boldsymbol\\xi)$ represent the solution of initial value problem\n\\[\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z),\\qquad\\boldsymbol z(0)=\\boldsymbol\\xi.\\]\nWe then compute the $m\\times m$ Jacobian matrix of $F_t(\\boldsymbol z(t,\\boldsymbol\\xi))$:\n\\[\\boldsymbol W(t)=F_t'(\\boldsymbol z(t,\\boldsymbol\\xi))=\\frac{\\partial F_t}{\\partial\\boldsymbol z}(\\boldsymbol z(t,\\boldsymbol\\xi)).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "F为C1真实flow，z(t,ξ)=Ftξ；原文字面在Ftξ处对初值变量微分。"
  ],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "标准变分矩阵应为DξFt(ξ)，原文把取值点写Ftξ；忠实保留字面定义，后续两条不静默改。"
    }
  ],
  "lean_decl": "MD.Ch01.variationalMatrixLiteral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-190",
    "CH01-191"
  ]
}
```

```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)
```

### MD-1.7.2-VariationalEquationLiteral

```json
{
  "source_id": "MD-1.7.2-VariationalEquationLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.2",
  "printed_page": "44–45",
  "pdf_page": "67–68",
  "statement_latex": "Differentiating $\\boldsymbol W(t)$ with respect to $t$ and using the differential equation and the chain rule, we have\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\boldsymbol W(t)=\\boldsymbol f'(\\boldsymbol z(t,\\boldsymbol\\xi))\\boldsymbol W(t).\\tag{1.10}\\]\nThe system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $\\mathrm d\\boldsymbol z/\\mathrm dt=\\boldsymbol f(\\boldsymbol z)$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "前条字面W=D Ft(Ftξ)多出取值点移动链式项。局部标量f(z)=z²,Ftξ=ξ/(1-tξ)：W=(1-tξ)²/(1-2tξ)²；t=0的W′=2ξ相合，但t≠0一般不满足原式。"
    }
  ],
  "lean_decl": "MD.Ch01.variationalequationliteral",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-192"
  ]
}
```

```lean
theorem variationalequationliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t
```

### MD-1.7.2-NearbyTrajectoryLiteral

```json
{
  "source_id": "MD-1.7.2-NearbyTrajectoryLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.2",
  "printed_page": "45",
  "pdf_page": "68",
  "statement_latex": "If we have two solutions started from nearby initial conditions $\\boldsymbol\\xi,\\hat{\\boldsymbol\\xi}$, then their difference is approximated by the solution of the variational equations\n\\[\\boldsymbol z(t,\\hat{\\boldsymbol\\xi})-\\boldsymbol z(t,\\boldsymbol\\xi)\\approx\\boldsymbol W(t)(\\hat{\\boldsymbol\\xi}-\\boldsymbol\\xi).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文字面W在Ftξ而不是ξ；前条非线性流提供不同Jacobian的反例，不能用修正版flowFirstOrder_proof冒充。"
    }
  ],
  "lean_decl": "MD.Ch01.nearby_trajectory_literal",
  "extra_assumptions": [
    "≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-193"
  ]
}
```

```lean
theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ)
```

### MD-1.7.2-SingularValues

```json
{
  "source_id": "MD-1.7.2-SingularValues",
  "kind": "definition",
  "label": null,
  "section": "1.7.2",
  "printed_page": "45",
  "pdf_page": "68",
  "statement_latex": "The square roots of the eigenvalues of $\\boldsymbol A^T\\boldsymbol A$, also called the singular values of $\\boldsymbol A$, then give the axes of the image ellipsoid.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "有限维实矩阵；非负、largest-to-smallest顺序及正交对角化刻画全部谱，顺序原文随后给出。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.singularValues",
  "extra_assumptions": [
    "用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-194"
  ]
}
```

```lean
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)
```

### MD-1.7.2-SingularEllipsoid

```json
{
  "source_id": "MD-1.7.2-SingularEllipsoid",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.2",
  "printed_page": "45",
  "pdf_page": "68",
  "statement_latex": "We may view a regular linear mapping $\\boldsymbol v\\mapsto\\boldsymbol A\\boldsymbol v$, where $\\boldsymbol A\\in\\mathbb R^{m\\times m}$, as a mapping of an $m-1$-dimensional sphere (embedded in the $m$-dimensional Euclidean space) to an ellipsoid in the same space (Fig. 1.26). The square roots of the eigenvalues of $\\boldsymbol A^T\\boldsymbol A$, also called the singular values of $\\boldsymbol A$, then give the axes of the image ellipsoid.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.singularellipsoid",
  "extra_assumptions": [
    "regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-195"
  ]
}
```

```lean
theorem singularellipsoid :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1}
```

### MD-1.7.2-LyapunovExponents

```json
{
  "source_id": "MD-1.7.2-LyapunovExponents",
  "kind": "definition",
  "label": null,
  "section": "1.7.2",
  "printed_page": "45",
  "pdf_page": "68",
  "statement_latex": "The Lyapunov exponents $\\lambda_1,\\lambda_2,\\ldots,\\lambda_m$ are defined by\n\\[\\lambda_i=\\limsup_{t\\to\\infty}\\frac1t\\log\\sigma_i(\\boldsymbol W),\\]\nwhere $\\sigma_i$ represents the ith singular value of the given matrix (to maintain continuity, these should be ordered in some way, say largest to smallest).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "σ:time→ith ordered singular value ofW(t)；与前条singularValues相接。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lyapunovExponent",
  "extra_assumptions": [
    "扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-196"
  ]
}
```

```lean
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
```

### MD-1.7.2-PositiveLyapunovGrowth

```json
{
  "source_id": "MD-1.7.2-PositiveLyapunovGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.2",
  "printed_page": "45",
  "pdf_page": "68",
  "statement_latex": "The presence of a positive Lyapunov exponent implies exponential growth of perturbations, which, as we have seen, is one of the hallmarks of chaos.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "σ来自实际W奇异值；大小增长描述无穷小扰动算子，有限扰动在有界相域会饱和。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.positivelyapunovgrowth",
  "extra_assumptions": [
    "依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-197"
  ]
}
```

```lean
theorem positivelyapunovgrowth :
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
