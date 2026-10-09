# BATCH11：第1章原文审校A + 只读语义审计C

## 开始前 @引用 / 上传

1. 教材PDF `../Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`；PDF页从1起算，本批页：49, 50, 51；上下文读取该节相邻页。
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

### MD-1.5.1-FlowMap

```json
{
  "source_id": "MD-1.5.1-FlowMap",
  "kind": "definition",
  "label": null,
  "section": "1.5.1",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "Consider now the initial value problem\n\\[\\dot{\\boldsymbol z}=f(\\boldsymbol z),\\qquad\\boldsymbol z(0)=\\boldsymbol\\xi,\\tag{1.5}\\]\nin a $m$-dimensional space. If we assume that $f$ corresponds to a molecular Hamiltonian system satisfying the assumptions of the existence and uniqueness result of the previous subsection, then we may define a mapping from a point in phase space to the point $t$ units later along the time-evolution starting from the initial point. We refer to this map as the flow map and denote it by $\\mathcal F_t$. $\\mathcal F_t(\\boldsymbol\\xi)=\\boldsymbol z(t)$ solves the initial value problem (1.5).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "这里只定义已存在全局流满足IVP；不假设群律，不声明任意f全局可解。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.flowMap",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-098"
  ]
}
```

```lean
def flowMap {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ ξ, F 0 ξ = ξ) ∧ ∀ ξ t, HasDerivAt (fun s => F s ξ) (f (F t ξ)) t
```

### MD-1.5.1-FlowEnergy

```json
{
  "source_id": "MD-1.5.1-FlowEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "The flow map of a Hamiltonian system conserves its Hamiltonian, thus\n\\[H(\\mathcal F_t(\\boldsymbol\\xi))=H(\\boldsymbol\\xi).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.flow_energy",
  "extra_assumptions": [
    "H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-101"
  ]
}
```

```lean
theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ
```

### MD-1.5.1-HarmonicPhaseFlow

```json
{
  "source_id": "MD-1.5.1-HarmonicPhaseFlow",
  "kind": "definition",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "for which the solution subject to initial values $q(0)=q_0,p(0)=p_0$ is\n\\[\\begin{pmatrix}q(t)\\\\p(t)\\end{pmatrix}=\\mathcal F_t\\begin{pmatrix}q_0\\\\p_0\\end{pmatrix}=\\begin{pmatrix}q_0\\cos(\\Omega t)+p_0\\sin(\\Omega t)/\\Omega\\\\-q_0\\Omega\\sin(\\Omega t)+p_0\\cos(\\Omega t)\\end{pmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "p.26方程q′=p,p′=-Ω²q；Ω≠0域；§1.2已有真实解与初值证明。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.harmonicPhaseFlow",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-102"
  ]
}
```

```lean
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)
```

### MD-1.5.1-SpectralSolution

```json
{
  "source_id": "MD-1.5.1-SpectralSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "If $\\boldsymbol A$ has a basis of eigenvectors $\\boldsymbol\\eta_i$, $i=1,\\ldots,m$, with corresponding eigenvalues $\\lambda_1,\\lambda_2,\\ldots,\\lambda_m$, then we may write the solution at time $t$ as\n\\[\\boldsymbol z(t)=\\sum_{i=1}^{m}c_i e^{\\lambda_i(t-t_0)}\\boldsymbol\\eta_i\\]\nwhere the coefficients $c_i$ are obtained by solving the equation\n\\[\\boldsymbol z(t_0)=\\boldsymbol\\xi=\\sum_{i=1}^{m}c_i\\boldsymbol\\eta_i.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "允许复数特征值，不偷换为实谱。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.spectralsolution",
  "extra_assumptions": [
    "有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-103"
  ]
}
```

```lean
theorem spectralsolution :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E] {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ),
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i
```

### MD-1.5.1-BasisCoefficients

```json
{
  "source_id": "MD-1.5.1-BasisCoefficients",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "(ii) with our assumption that the $\\{\\boldsymbol\\eta_i\\}$ form a basis, the calculation of the coefficients will always be possible, since the matrix $\\boldsymbol X$ whose columns are the eigenvectors will be invertible, that is, the coefficients $c_i$ can be enumerated as the components of a vector $\\boldsymbol c$ which satisfies the square linear system\n\\[\\boldsymbol\\xi=\\boldsymbol X\\boldsymbol c.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.basis_coefficients",
  "extra_assumptions": [
    "RCLike域包含实/复两种；真实有限基。"
  ],
  "repair_log": [],
  "old_ids": [
    "CH01-105"
  ]
}
```

```lean
theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z
```

### MD-1.5.1-MatrixExponentialSolution

```json
{
  "source_id": "MD-1.5.1-MatrixExponentialSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "An alternative expression for the solution is in terms of the exponential of the matrix $\\boldsymbol A$ scaled by time,\n\\[\\boldsymbol z(t)=e^{\\boldsymbol A(t-t_0)}\\boldsymbol\\xi.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "matrixExponentialFlow_eq把连续算子指数对应到真正矩阵指数。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.matrixexponentialsolution",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-106"
  ]
}
```

```lean
theorem matrixexponentialsolution :
  ∀ {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z),
    γ = fun t => matrixExponentialFlow A (t - t₀) z
```

### MD-1.5.1-MatrixExpSeries

```json
{
  "source_id": "MD-1.5.1-MatrixExpSeries",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27–28",
  "pdf_page": "50–51",
  "statement_latex": "Alternatively, we may think of $\\exp(\\boldsymbol A)$ as the sum of the exponential series\n\\[e^{\\boldsymbol A}=\\boldsymbol I+\\boldsymbol A+\\frac1{2!}\\boldsymbol A^2+\\frac1{3!}\\boldsymbol A^3+\\cdots\\]\nalthough this is seldom the most efficient method to compute it (this series converges for all matrices $\\boldsymbol A$, and so in fact the exponential expression for the solution of the linear system is well defined even in the absence of a full set of eigenvectors).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "HasSum包含级数收敛和等式；需要Matrix.Norms.L2Operator范数约定。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.matrix_exp_series",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-107",
    "CH01-108"
  ]
}
```

```lean
theorem matrix_exp_series {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A)
```

### MD-1.5.1-RealSpectralSolution

```json
{
  "source_id": "MD-1.5.1-RealSpectralSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "Observations: (i) eigenvectors, eigenvalues, and coefficients $c_i$ may be complex, but if $\\boldsymbol A$ and $\\boldsymbol\\xi$ have real coefficients, it is nonetheless possible to obtain a real solution,",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "谱和结果每坐标虚部=0，对t-t0调用；不强制特征值为实。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.realspectralsolution",
  "extra_assumptions": [],
  "repair_log": [],
  "old_ids": [
    "CH01-104"
  ]
}
```

```lean
theorem realspectralsolution :
  ∀ {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ)
    (b : Module.Basis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (ν : Fin m → ℂ)
    (hb : ∀ j, Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)
      (b j) = ν j • b j)
    (z : EuclideanSpace ℂ (Fin m)) (hz : ∀ j, (z j).im = 0) (t : ℝ) (i : Fin m),
    ((∑ j, (b.repr z j * Complex.exp (ν j * (t : ℂ))) • b j) i).im = 0
```

## 唯一输出

仅输出一个JSON数组，无Markdown围栏或额外文字。每条严格包含：
```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
